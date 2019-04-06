#include <defs.h>
#include <x86.h>
#include <stdio.h>
#include <string.h>
#include <swap.h>
#include <swap_exclock.h>
#include <list.h>

list_entry_t pra_list_head, *clock;
bool all_in;

static int
_exclock_init_mm(struct mm_struct *mm)
{
    list_init(&pra_list_head);
    clock = mm->sm_priv = &pra_list_head;
    all_in = 0;
    //cprintf(" mm->sm_priv %x in exclock_init_mm\n",mm->sm_priv);
    return 0;
}

#define debug_exclock {\
    list_entry_t *now, *head = mm->sm_priv;\
    uintptr_t cnt = 0;\
    for (now = list_next(head); now != head; now = list_next(now), ++cnt) {\
        struct Page* page = le2page(now, pra_page_link);\
        uintptr_t va = page->pra_vaddr;\
        pte_t *ptep = get_pte(mm->pgdir, va, 0);\
        uintptr_t A = *ptep & PTE_A, D = *ptep & PTE_D;\
        cprintf("#%d vaddr: 0x%08x %c%c", cnt, page->pra_vaddr, A ? 'A' : '-', D ? 'D' : '-');\
        if (now == clock)\
            cprintf(" ^");\
        cprintf("\n");\
    }\
}

/*
 * (3)_exclock_map_swappable: According EXCLOCK PRA, we should link the most recent arrival page at the back of pra_list_head qeueue
 */
static int
_exclock_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)
{
    if (all_in) return 0;
    list_entry_t *entry = &(page->pra_page_link), *head = mm->sm_priv;
    assert(entry != NULL && clock != NULL);
    list_add_before(head, entry);
#ifndef DEBUG_EXCLOCK
    debug_exclock
#endif
    return 0;
}
/*
 *  (4)_exclock_swap_out_victim: According EXCLOCK PRA, we should unlink the  earliest arrival page in front of pra_list_head qeueue,
 *                            then assign the value of *ptr_page to the addr of this page.
 */
static int
_exclock_swap_out_victim(struct mm_struct *mm, struct Page ** ptr_page, int in_tick)
{
    all_in = 1;
    list_entry_t *head = mm->sm_priv, *next;
    assert(clock != NULL);
    assert(in_tick == 0);
    if (clock == head) clock = list_next(clock);
#ifndef DEBUG_EXCLOCK
    cprintf("before:\n");
    debug_exclock
#endif
    /* Select the victim */
    for(; ; clock = list_next(clock)) {
        if (clock == head)
            continue;
        struct Page* page = le2page(clock, pra_page_link);
        uintptr_t va = page->pra_vaddr;
        pte_t *ptep = get_pte(mm->pgdir, va, 0);
        assert(*ptep & PTE_P);
        uintptr_t A = *ptep & PTE_A, D = *ptep & PTE_D;
        cprintf("visit vaddr: 0x%08x %c%c\n", page->pra_vaddr, A ? 'A' : '-', D ? 'D' : '-');
        if (A == 0 && D == 0) { // 00, replace
            *ptr_page = page;
            break;
        }
        else {
            if (A == 0) { // 01 -> 00
                swapfs_write((va / PGSIZE + 1) << 8, page);
                cprintf("write page vaddr 0x%x to swap %d\n", va, va / PGSIZE + 1);
                *ptep &= ~PTE_D;
            } else { // 10, 11 -> 00, 01
                *ptep &= ~PTE_A;
            }
            tlb_invalidate(mm->pgdir, va);
        }
    }
#ifndef DEBUG_EXCLOCK
    cprintf("after:\n");
    debug_exclock
#endif
    clock = list_next(clock);
    return 0;
}

static int
_exclock_check_swap(void) {
    // clear all AD
    pde_t *pgdir = KADDR((pde_t*) rcr3());
    for (int i = 1; i <= 4; ++i) {
        pte_t *ptep = get_pte(pgdir, i * 0x1000, 0);
        swapfs_write((i * 0x1000 / PGSIZE + 1) << 8, pte2page(*ptep));
        *ptep &= ~(PTE_A | PTE_D);
        tlb_invalidate(pgdir, i * 0x1000);
    }
    assert(pgfault_num == 4);
    cprintf("read Virt Page c in exclock_check_swap\n");
    assert(*(unsigned char *)0x3000 == 0x0c);
    assert(pgfault_num == 4);
    cprintf("write Virt Page a in exclock_check_swap\n");
    assert(*(unsigned char *)0x1000 == 0x0a);
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num == 4);
    cprintf("read Virt Page d in exclock_check_swap\n");
    assert(*(unsigned char *)0x4000 == 0x0d);
    assert(pgfault_num == 4);
    cprintf("write Virt Page b in exclock_check_swap\n");
    assert(*(unsigned char *)0x2000 == 0x0b);
    *(unsigned char *)0x2000 = 0x0b;
    assert(pgfault_num == 4);
    cprintf("read Virt Page e in exclock_check_swap\n");
    unsigned e = *(unsigned char *)0x5000;
    cprintf("e = 0x%04x\n", e);
    assert(pgfault_num == 5);
    cprintf("read Virt Page b in exclock_check_swap\n");
    assert(*(unsigned char *)0x2000 == 0x0b);
    assert(pgfault_num == 5);
    cprintf("write Virt Page a in exclock_check_swap\n");
    assert(*(unsigned char *)0x1000 == 0x0a);
    *(unsigned char *)0x1000 = 0x0a;
    assert(pgfault_num == 5);
    cprintf("read Virt Page b in exclock_check_swap\n");
    assert(*(unsigned char *)0x2000 == 0x0b);
    assert(pgfault_num == 5);
    cprintf("read Virt Page c in exclock_check_swap\n");
    assert(*(unsigned char *)0x3000 == 0x0c);
    assert(pgfault_num == 6);
    cprintf("read Virt Page d in exclock_check_swap\n");
    assert(*(unsigned char *)0x4000 == 0x0d);
    assert(pgfault_num == 7);
    return 0;
}

static int
_exclock_init(void)
{
    return 0;
}

static int
_exclock_set_unswappable(struct mm_struct *mm, uintptr_t addr)
{
    return 0;
}

static int
_exclock_tick_event(struct mm_struct *mm)
{ return 0; }


struct swap_manager swap_manager_exclock =
{
    .name            = "exclock swap manager",
    .init            = &_exclock_init,
    .init_mm         = &_exclock_init_mm,
    .tick_event      = &_exclock_tick_event,
    .map_swappable   = &_exclock_map_swappable,
    .set_unswappable = &_exclock_set_unswappable,
    .swap_out_victim = &_exclock_swap_out_victim,
    .check_swap      = &_exclock_check_swap,
};
