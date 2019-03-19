# Lab4

> 计64 翁家翌 2016011446

## 练习1

根据注释对proc下的各个成员变量进行初始化即可，其中：

- `state` 设置为 `PROC_UNINIT` 为初始化状态
- `pid` 设置为 `-1`，表示未分配
- `cr3` 设置为 `boot_cr3`，为kernel初始化时页目录表的起始地址
- 其余所有值设为0，指针设为NULL



context保存了在内核态kernel进程切换的时候可能会被修改的寄存器，保证了各个进程之间的相对独立

trapframe保存了中断发生时进程在被打断之前的状态，用于到时候恢复中断前的现场

前者是用在不同进程的切换，后者用在某一进程的中断或异常。

## 练习2

翻译注释，但是要进行报错处理，具体如下：

1. 如果 proc 为 NULL，则表示无可用内存，跳转至 `fork_out`
2. 如果无法为 proc 分配内核栈，则跳转至 `bad_fork_cleanup_proc`，需要将之前的 `proc` 的页面释放掉
3. 如果在拷贝的时候挂了，则跳转至 `bad_fork_cleanup_kstack`，先释放已分配的栈空间，再释放 `proc` 的页面
4. 在调用 `get_pid`、插入链表之前需要关中断进行原子操作

新线程的 `uid` 唯一，因为在调用 `get_pid` 函数之前已经关闭中断确保是原子操作，不会发生竞争。

## 练习3

对 `proc_fun` 函数分析如下：

```c
void proc_run(struct proc_struct *proc) {
    if (proc != current) { // 只有当前运行的进程不等于要切换的进程才会切换
        bool intr_flag;
        struct proc_struct *prev = current, *next = proc;
        local_intr_save(intr_flag); // 关中断，确保原子操作
        {
            current = proc; // 更改当前运行进程
            load_esp0(next->kstack + KSTACKSIZE); // 修改TSS的esp0，使其指向新进程的堆栈起始地址
            lcr3(next->cr3); // 修改页目录表起始地址
            switch_to(&(prev->context), &(next->context)); // 切换进程上下文
        }
        local_intr_restore(intr_flag); // 恢复中断
    }
}
```

其中 `switch_to` 函数为汇编实现，复制了各个寄存器，如下所示：

```asm
.text
.globl switch_to
switch_to:                      # switch_to(from, to)

    # save from's registers
    movl 4(%esp), %eax          # eax points to from
    popl 0(%eax)                # save eip !popl
    movl %esp, 4(%eax)          # save esp::context of from
    movl %ebx, 8(%eax)          # save ebx::context of from
    movl %ecx, 12(%eax)         # save ecx::context of from
    movl %edx, 16(%eax)         # save edx::context of from
    movl %esi, 20(%eax)         # save esi::context of from
    movl %edi, 24(%eax)         # save edi::context of from
    movl %ebp, 28(%eax)         # save ebp::context of from

    # restore to's registers
    movl 4(%esp), %eax          # not 8(%esp): popped return address already
                                # eax now points to to
    movl 28(%eax), %ebp         # restore ebp::context of to
    movl 24(%eax), %edi         # restore edi::context of to
    movl 20(%eax), %esi         # restore esi::context of to
    movl 16(%eax), %edx         # restore edx::context of to
    movl 12(%eax), %ecx         # restore ecx::context of to
    movl 8(%eax), %ebx          # restore ebx::context of to
    movl 4(%eax), %esp          # restore esp::context of to
    
    pushl 0(%eax)               # push eip
    
    ret
```

此处的ret由于之前在函数 `copy_thread` 中，

```c
proc->context.eip = (uintptr_t)forkret;
proc->context.esp = (uintptr_t)(proc->tf);
```

将返回地址修改为 `forkret`，并且 `esp` 指向中断栈帧，从而 `ret` 会跳到 `forkret` 中，位于 `kern/trap/trapentry.S`，调用 `iret` 返回。后面的流程和Lab1的challenge十分相似。

在本次实验的执行过程中，一共创建且运行了两个内核线程。从 `proc_init` 可以看出，一个是 `initproc`，pid为1，作用为打印字符串；另一个是 `idleproc`，pid为0，作用为一直循环，有进程需要运行的时候换成对应的进程。

`local_intr_save` 和 `local_intr_restore` 两个函数用于关闭/开启中断，保证进程切换时context的切换过程不会被其他中断打断，确保其是一个原子操作。

## 总结

#### 本实验中重要的知识点，以及与对应的OS原理中的知识点

1. 进程状态模型
2. 内核线程的控制
3. proc和context的理解

#### 本实验中没有对应的

1. 用户进程
2. 挂起的进程