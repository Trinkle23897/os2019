#include <pmm.h>
#include <list.h>
#include <string.h>
#include <buddy_pmm.h>

#define BUDDY_MAX_DEPTH 30
static unsigned int* buddy_page;
static unsigned int buddy_page_num; // store buddy system
static unsigned int max_pages; // maintained by buddy
static struct Page* buddy_allocatable_base;

#define max(a, b) ((a) > (b) ? (a) : (b))

static void buddy_init(void) {}

static void buddy_init_memmap(struct Page *base, size_t n) {
    assert(n > 0);
    // calc buddy alloc page number
    max_pages = 1;
    for (int i = 1; i < BUDDY_MAX_DEPTH; ++i, max_pages <<= 1)
        if (max_pages + (max_pages >> 9) >= n)
            break;
    max_pages >>= 1;
    buddy_page_num = (max_pages >> 9) + 1;
    cprintf("buddy init: total %d, use %d, free %d\n", n, buddy_page_num, max_pages);
    // set these pages to reserved
    for (int i = 0; i < buddy_page_num; ++i)
        SetPageReserved(base + i);
    // set non-buddy page to be allocatable
    buddy_allocatable_base = base + buddy_page_num;
    for (struct Page *p = buddy_allocatable_base; p != base + n; ++p) {
        ClearPageReserved(p);
        SetPageProperty(p);
        set_page_ref(p, 0);
    }
    // init buddy page
    buddy_page = (unsigned int*)KADDR(page2pa(base));
    for (int i = max_pages; i < max_pages << 1; ++i)
        buddy_page[i] = 1;
    for (int i = max_pages - 1; i > 0; --i)
        buddy_page[i] = buddy_page[i << 1] << 1;
}

static struct Page* buddy_alloc_pages(size_t n) {
    assert(n > 0);
    if (n > buddy_page[1]) return NULL;
    unsigned int index = 1, size = max_pages;
    for (; size >= n; size >>= 1) {
        if (buddy_page[index << 1] >= n) index <<= 1;
        else if (buddy_page[index << 1 | 1] >= n) index = index << 1 | 1;
        else break;
    }
    buddy_page[index] = 0;
    // allocate all pages under node[index]
    struct Page* new_page = buddy_allocatable_base + index * size - max_pages;
    for (struct Page* p = new_page; p != new_page + size; ++p)
        set_page_ref(p, 0), ClearPageProperty(p);
    for (; (index >>= 1) > 0; ) // since destory continuous, use MAX instead of SUM
        buddy_page[index] = max(buddy_page[index << 1], buddy_page[index << 1 | 1]);
    return new_page;
}

static void buddy_free_pages(struct Page *base, size_t n) {
    assert(n > 0);
    unsigned int index = (unsigned int)(base - buddy_allocatable_base) + max_pages, size = 1;
    // find first buddy node which has buddy_page[index] == 0
    for (; buddy_page[index] > 0; index >>= 1, size <<= 1);
    // free all pages
    for (struct Page *p = base; p != base + n; ++p) {
        assert(!PageReserved(p) && !PageProperty(p));
        SetPageProperty(p), set_page_ref(p, 0);
    }
    // modify buddy_page
    for (buddy_page[index] = size; size <<= 1, (index >>= 1) > 0;)
        buddy_page[index] = (buddy_page[index << 1] + buddy_page[index << 1 | 1] == size) ? size : max(buddy_page[index << 1], buddy_page[index << 1 | 1]);
}

static size_t buddy_nr_free_pages(void) { return buddy_page[1]; }

static void buddy_check(void) {
    int all_pages = nr_free_pages();
    struct Page* p0, *p1, *p2, *p3;
    assert(alloc_pages(all_pages + 1) == NULL);

    p0 = alloc_pages(1);
    assert(p0 != NULL);
    p1 = alloc_pages(2);
    assert(p1 == p0 + 2);
    assert(!PageReserved(p0) && !PageProperty(p0));
    assert(!PageReserved(p1) && !PageProperty(p1));

    p2 = alloc_pages(1);
    assert(p2 == p0 + 1);
    p3 = alloc_pages(2);
    assert(p3 == p0 + 4);
    assert(!PageProperty(p3) && !PageProperty(p3 + 1) && PageProperty(p3 + 2));

    free_pages(p1, 2);
    assert(PageProperty(p1) && PageProperty(p1 + 1));
    assert(p1->ref == 0);

    free_pages(p0, 1);
    free_pages(p2, 1);

    p2 = alloc_pages(2);
    assert(p2 == p0);
    free_pages(p2, 2);
    assert((*(p2 + 1)).ref == 0);
    assert(nr_free_pages() == all_pages >> 1);

    free_pages(p3, 2);
    p1 = alloc_pages(129);
    free_pages(p1, 256);
}

const struct pmm_manager buddy_pmm_manager = {
    .name = "buddy_pmm_manager",
    .init = buddy_init,
    .init_memmap = buddy_init_memmap,
    .alloc_pages = buddy_alloc_pages,
    .free_pages = buddy_free_pages,
    .nr_free_pages = buddy_nr_free_pages,
    .check = buddy_check,
};