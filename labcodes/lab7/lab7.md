# Lab7

> 计64 翁家翌 2016011446

## 练习0

需要把 `kern/trap/trap.c` 中的时钟中断从调用 `sched_class_proc_tick` 修改为 `run_timer_list`

## 练习1

利用等待队列实现对某个信号等待的进程的管理，同时定义信号量来在等待队列的基础上完成互斥与同步。具体定义如下：

```c
typedef struct {
    struct proc_struct *proc; // 等待进程的指针
    uint32_t wakeup_flags; // 进程被放入等待队列的原因标记
    wait_queue_t *wait_queue; // 指向此wait结构所属于的wait_queue
    list_entry_t wait_link; // 用来组织wait_queue中wait节点的连接
} wait_t;

typedef struct {
    list_entry_t wait_head; // wait_queue的队头
} wait_queue_t;

le2wait(le, member) // 实现wait_t中成员的指针向wait_t 指针的转化
    
typedef struct {
    int value; // 信号量的当前值
    wait_queue_t wait_queue; // 信号量对应的等待队列
} semaphore_t;
```

大致执行流程主要分为初始化、up、down，定义如下：

```c
void sem_init(semaphore_t *sem, int value) {
    // 信号量的初始化过程中需要设置初始的value值并初始化等待队列
    sem->value = value;
    wait_queue_init(&(sem->wait_queue));
}

static __noinline void __up(semaphore_t *sem, uint32_t wait_state) { // P()
    bool intr_flag; // 为了保证信号量的操作不被其他进程或线程打算需要关闭中断
    local_intr_save(intr_flag);
    {
        wait_t *wait;
        // 如果信号量的等待队列中没有等待的进程或者线程，将value++
        // 相当于课件的 value >= 0
        if ((wait = wait_queue_first(&(sem->wait_queue))) == NULL) {
            sem->value ++;
        }
        // 如果信号量的等待队列中没有等待的进程或者线程，则从队列头部取下一个等待进程（线程）并唤醒
        // 处理方式相当于课件的 value < 0的情况（在ucore实现中value恒大于等于0）
        else {
            assert(wait->proc->wait_state == wait_state);
            wakeup_wait(&(sem->wait_queue), wait, wait_state, 1);
        }
    }
    local_intr_restore(intr_flag);
}

static __noinline uint32_t __down(semaphore_t *sem, uint32_t wait_state) { // V()
    bool intr_flag; // 为了保证信号量的操作不被其他进程或线程打算需要关闭中断
    local_intr_save(intr_flag);
    if (sem->value > 0) {
        sem->value --;
        local_intr_restore(intr_flag);
        return 0;
    }
    // 如果信号量的 value <= 0 （实际value不会小于0），则将当前进程（线程）放入到改信号量的等待队列中
    // 让当前进程进入睡眠状态，主动放弃控制权，并要求OS进行调度
    wait_t __wait, *wait = &__wait;
    wait_current_set(&(sem->wait_queue), wait, wait_state);
    local_intr_restore(intr_flag);

    schedule();

    local_intr_save(intr_flag);
    wait_current_del(&(sem->wait_queue), wait);
    local_intr_restore(intr_flag);

    if (wait->wakeup_flags != wait_state) {
        return wait->wakeup_flags;
    }
    return 0;
}
```

1. 初始化一个信号量时，将该信号量的数值初始化为给定的值，等待队列初始化为单个元素的队列（只有头哨兵）。
2. P()操作时：
   - 若等待队列为空，则信号数值加1并返回，表示该信号有富余的量；若等待队列不为空，则选取等待队列队首的元素唤醒。
   - 操作时需要关、开中断来保证共享变量的互斥操作。
3. V()操作时：
   - 若信号量有多（value大于0），value减少1并立即返回，表示信号量被进程消耗；
   - 若信号量value等于0，则将当前进程放入等待队列，运行调度器以调度到其他进程。当该进程被再次调度回来时，说明进程被唤醒，且若等待进程的`wakeup_flags`没有改变，则信号量被该进程所消耗，从而可以将该进程从等待队列中删除。若等待进程的`wakeup_flags`改变，说明进程因为其他原因被唤醒，此时仍然需要将进程从等待队列中移除（因为进程被其他原因唤醒，不可以再等待该信号量），并且返回唤醒原因。
   - 操作时需要关、开中断来保证共享变量的互斥操作。

> 给出给用户态进程/线程提供信号量机制的设计方案，并比较说明给内核级提供信号量机制的异同

基本原理依然可以使用等待队列的生产者-消费者模式，但不同进程对于共享变量的互斥操作就不是关中断可以实现的了，因此需要内核来提供一把锁，来保证用户态访问共享变量时需要通过中断来进入内核态，由内核态进程判断是否可以给用户态读写该共享变量。

## 练习2

主要关注`monitor.c`中的代码。首先列出管程相关的数据结构：

```c
typedef struct monitor monitor_t;

typedef struct condvar{
    semaphore_t sem;        // 条件变量中的信号量，通过信号量的操作可以间接完成条件变量的操作
    int count;              // 挂在该条件变量中的进程或者线程数量
    monitor_t * owner;      // 条件变量所属的管程
} condvar_t;

typedef struct monitor{
    semaphore_t mutex;      // the mutex lock for going into the routines in monitor, should be initialized to 1
    semaphore_t next;       // the next semaphore is used to down the signaling proc itself, and the other OR wakeuped waiting proc should wake up the sleeped signaling proc.
    int next_count;         // the number of of sleeped signaling proc
    condvar_t *cv;          // the condvars in monitor
} monitor_t;
```

可以看出，管程中有`mutex`信号量用于保护管程，`next`信号量用于管理等待进入管程的进程。条件变量的两个核心操作是wait和signal，具体实现依赖于信号量的P(), V()操作，具体实现的分析如下：

```c
void cond_signal (condvar_t *cvp) {
   monitor_t *mtp = cvp->owner;
   // 如果等待队列为空则什么都不做
   // 如果条件变量存在等待的进程（线程），则进行如下操作
   if (cvp->count > 0) {
   	   // 让管程的next_count数加1，代表着管程所拥有的signal队列新增一个元素
       mtp->next_count++;
       // 让条件变量的信号量执行up操作，此时唤醒信号量的等待队列中的进程（线程）
       up(&(cvp->sem));
       // 让管程的next信号量执行down操作，实际上相当于让当前signaler进入等待
       down(&(mtp->next));
       // signaler被重新调度，让管程的next_count减1, 代表管程所拥有的signal队列减少一个元素
       mtp->next_count--;
   }
}

void cond_wait (condvar_t *cvp) {
    cvp->count++;
    monitor_t *mtp = cvp->owner;
    // 如果管程的next_count大于0，说明依旧有signaler在等待，则唤醒signaler
    // 如果管程的next_count等于0，说明没有signaler在等待，则释放临界区的锁
    if (mtp->next_count > 0) {
        up(&(mtp->next));
    } else {
        up(&(mtp->mutex));
    }
    // 让条件变量的信号量执行down操作，此时value = 0，故当前进程（线程）会睡眠进入等待队列中
    down(&(cvp->sem));
    // 进程（线程）被唤醒，重新获得控制权，等待队列的元素个数减1
    cvp->count--;
}
```

1. 初始化：

   - 将管程的`next`的值置0，`mutex`的值置1，表示没有进程进入、也没有进程在等待。
   - 为条件变量分配内存并初始化，将`sem`信号量的值置0，表示没有进程在等待。

2. `cond_signal`函数：

   - 用于激活某一个在等待管程的进程。

   - 首先进程B判断`cv.count`，如果不大于0，则表示当前没有执行`cond_wait`而睡眠的进程，因此就没有被唤醒的对象了，直接函数返回即可；

     如果大于0，这表示当前有执行`cond_wait`而睡眠的进程A，因此需要唤醒等待在`cv.sem`上
     睡眠的进程A。由于只允许一个进程在管程中执行，所以一旦进程B唤醒了别人（进程A），
     那么自己就需要睡眠。故让`monitor.next_count`加一，且让自己（进程B）睡在信号量
     `monitor.next`上。如果睡醒了，表示进程A已经访问结束，则让`monitor.next_count`减一。

3. `cond_wait`函数：

   - 用于等待某个条件变量。

   - 如果进程A执行了`cond_wait`函数，表示此进程等待某个条件`Cond`不为真，需要睡眠。因此表示等待此条件的睡眠进程个数`cv.count`要加一。接下来会出现两种情况:

     - 如果`monitor.next_count`大于0，表示有大于等于1个进程执行`cond_signal`函数且睡了，就睡在了`monitor.next`信号量上（假定这些进程挂在`monitor.next`信号量相关的等待队列Ｓ上），因此需要唤醒等待队列Ｓ中的一个进程B；然后进程A睡在`cv.sem`上。如果进程A醒了，则让`cv.count`减一，表示等待此条件变量的睡眠进程个数少了一个，可继续执行。

     - 如果`monitor.next_count`如果小于等于0，表示目前没有进程执行`cond_signal`函数且
       睡着了，那需要唤醒的是由于互斥条件限制而无法进入管程的进程，所以要唤醒睡在
       `monitor.mutex`上的进程。然后进程A睡在`cv.sem`上，如果睡醒了，则让`cv.count`减一，表示等待此条件的睡眠进程个数少了一个，可继续执行。


> 能否不用基于信号量机制来完成条件变量？如果不能，请给出理由，如果能，请给出设计说明和具体实现

可以。条件变量维护着进程等待队列，实际上可以直接使用等待队列+锁机制来完成条件变量。

条件变量本质上是信号量+等待队列，而锁机制是一种特殊的“传递信号”的量，其原理在本质上与练习2中实现的信号量机制是一样的。

具体实现为：

1. 初始化：
   - 等待队列
2. `signal`函数：
   - 关中断，选择等待队列中第一个进程，移出等待队列并唤醒该进程（若等待队列不为空），开中断，调度。
3. `wait`函数：
   - 关中断，当前进程释放对等待队列的锁，sleep并加到等待队列尾部，开中断，调度。
   - 再次切换到该进程时，表示该进程已经被`signal`操作唤醒，已出等待队列。此时进程重新占有对等待队列的锁即可。

因此，锁机制保证了某个条件变量只能有一个进程占有，其余进程都挂在等待队列上。

## 总结

#### 本实验中重要的知识点，以及与对应的OS原理中的知识点

1. 禁用中断的同步方法
2. 信号量
3. 条件变量、管程
4. 哲学家就餐问题

#### 本实验中没有对应的

1. 纯软件实现的同步方法
2. 读者-写者问题
3. 死锁
4. 进程间通信