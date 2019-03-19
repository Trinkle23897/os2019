# Lab8

> 计64 翁家翌 2016011446

## 练习1

大致分为如下四种情况：

1. 开始和结束位置在同一块内
2. 开始和结束位置不在同一块内，开始位置未对齐
3. 开始和结束位置不在同一块内，中间对齐的块
4. 开始和结束位置不在同一块内，结束位置未对齐

对于非对齐块的操作，调用 `sfs_bmap_load_noblock` 得到块号之后，可以使用 `sfs_buf_op` 完成非对齐操作

对于对齐块的操作，得到块号之后，使用 `sfs_block_op` 进行整块操作

## 练习2

`load_icode` 大部分照搬之前lab7的代码，有两处明显的修改

1. 把原来从 `binary` 读出ELF改为从文件里面读取ELF `load_icode_read`，共两处地方

2. 在用户态栈上构建命令行参数。首先设置默认的选择子和寄存器和之前一致，然后我模拟了整个参数压栈过程，具体如下：

   ```c
   struct trapframe *tf = current->tf;
   memset(tf, 0, sizeof(struct trapframe));
   // set default parameter as before
   tf->tf_cs = USER_CS;
   tf->tf_ds = tf->tf_es = tf->tf_ss = USER_DS;
   tf->tf_esp = USTACKTOP;
   tf->tf_eip = elf.e_entry;
   tf->tf_eflags = FL_IF;
   // push raw data into stack
   char* uargv[EXEC_MAX_ARG_NUM];
   uargv[argc] = NULL;
   for (int i = argc - 1; i >= 0; --i) {
       tf->tf_esp -= strlen(kargv[i]) + 1; // add '\0'
       uargv[i] = (char*) tf->tf_esp;
       strcpy(uargv[i], kargv[i]);
   }
   // push char* pointer into stack
   tf->tf_esp = ROUNDDOWN(tf->tf_esp, sizeof(uintptr_t)) - sizeof(char*) * (argc + 1);
   memcpy((char**)tf->tf_esp, uargv, sizeof(char*) * (argc + 1));
   // push argc
   tf->tf_esp -= sizeof(uintptr_t);
   *(uintptr_t*)tf->tf_esp = argc;
   ```

   其中参数内容长度不确定，需要挨个求一下；二维数组压栈的时候，最后一个指针后面应该是一个空指针，表示结束；并且指针存放的时候需要四字节对齐。



## 总结

#### 本实验中重要的知识点，以及与对应的OS原理中的知识点

1. 管道
2. 虚拟文件系统框架
3. 文件描述符
4. 目录
5. inode、打开的文件等结构体
6. inode缓存
7. 简单文件系统
8. ucore特定的文件系统架构

#### 本实验中没有对应的

1. 其他进程间通信机制，例如信号、消息队列和共享内存
2. RAID
3. 磁盘调度算法
4. 磁盘缓存
5. IO