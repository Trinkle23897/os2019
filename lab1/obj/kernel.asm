
bin/kernel：     文件格式 elf32-i386


Disassembly of section .text:

00100000 <kern_init>:
int kern_init(void) __attribute__((noreturn));
void grade_backtrace(void);
static void lab1_switch_test(void);

int
kern_init(void) {
  100000:	55                   	push   %ebp
  100001:	89 e5                	mov    %esp,%ebp
  100003:	83 ec 18             	sub    $0x18,%esp
    extern char edata[], end[];
    memset(edata, 0, end - edata);
  100006:	ba 20 fd 10 00       	mov    $0x10fd20,%edx
  10000b:	b8 16 ea 10 00       	mov    $0x10ea16,%eax
  100010:	29 c2                	sub    %eax,%edx
  100012:	89 d0                	mov    %edx,%eax
  100014:	83 ec 04             	sub    $0x4,%esp
  100017:	50                   	push   %eax
  100018:	6a 00                	push   $0x0
  10001a:	68 16 ea 10 00       	push   $0x10ea16
  10001f:	e8 d8 2c 00 00       	call   102cfc <memset>
  100024:	83 c4 10             	add    $0x10,%esp

    cons_init();                // init the console
  100027:	e8 18 15 00 00       	call   101544 <cons_init>

    const char *message = "(THU.CST) os is loading ...";
  10002c:	c7 45 f4 a0 34 10 00 	movl   $0x1034a0,-0xc(%ebp)
    cprintf("%s\n\n", message);
  100033:	83 ec 08             	sub    $0x8,%esp
  100036:	ff 75 f4             	pushl  -0xc(%ebp)
  100039:	68 bc 34 10 00       	push   $0x1034bc
  10003e:	e8 0a 02 00 00       	call   10024d <cprintf>
  100043:	83 c4 10             	add    $0x10,%esp

    print_kerninfo();
  100046:	e8 a1 08 00 00       	call   1008ec <print_kerninfo>

    grade_backtrace();
  10004b:	e8 79 00 00 00       	call   1000c9 <grade_backtrace>

    pmm_init();                 // init physical memory management
  100050:	e8 6b 29 00 00       	call   1029c0 <pmm_init>

    pic_init();                 // init interrupt controller
  100055:	e8 2d 16 00 00       	call   101687 <pic_init>
    idt_init();                 // init interrupt descriptor table
  10005a:	e8 8e 17 00 00       	call   1017ed <idt_init>

    clock_init();               // init clock interrupt
  10005f:	e8 c5 0c 00 00       	call   100d29 <clock_init>
    intr_enable();              // enable irq interrupt
  100064:	e8 5b 17 00 00       	call   1017c4 <intr_enable>

    //LAB1: CAHLLENGE 1 If you try to do it, uncomment lab1_switch_test()
    // user/kernel mode switch test
    lab1_switch_test();
  100069:	e8 50 01 00 00       	call   1001be <lab1_switch_test>

    /* do nothing */
    while (1);
  10006e:	eb fe                	jmp    10006e <kern_init+0x6e>

00100070 <grade_backtrace2>:
}

void __attribute__((noinline))
grade_backtrace2(int arg0, int arg1, int arg2, int arg3) {
  100070:	55                   	push   %ebp
  100071:	89 e5                	mov    %esp,%ebp
  100073:	83 ec 08             	sub    $0x8,%esp
    mon_backtrace(0, NULL, NULL);
  100076:	83 ec 04             	sub    $0x4,%esp
  100079:	6a 00                	push   $0x0
  10007b:	6a 00                	push   $0x0
  10007d:	6a 00                	push   $0x0
  10007f:	e8 93 0c 00 00       	call   100d17 <mon_backtrace>
  100084:	83 c4 10             	add    $0x10,%esp
}
  100087:	90                   	nop
  100088:	c9                   	leave  
  100089:	c3                   	ret    

0010008a <grade_backtrace1>:

void __attribute__((noinline))
grade_backtrace1(int arg0, int arg1) {
  10008a:	55                   	push   %ebp
  10008b:	89 e5                	mov    %esp,%ebp
  10008d:	53                   	push   %ebx
  10008e:	83 ec 04             	sub    $0x4,%esp
    grade_backtrace2(arg0, (int)&arg0, arg1, (int)&arg1);
  100091:	8d 4d 0c             	lea    0xc(%ebp),%ecx
  100094:	8b 55 0c             	mov    0xc(%ebp),%edx
  100097:	8d 5d 08             	lea    0x8(%ebp),%ebx
  10009a:	8b 45 08             	mov    0x8(%ebp),%eax
  10009d:	51                   	push   %ecx
  10009e:	52                   	push   %edx
  10009f:	53                   	push   %ebx
  1000a0:	50                   	push   %eax
  1000a1:	e8 ca ff ff ff       	call   100070 <grade_backtrace2>
  1000a6:	83 c4 10             	add    $0x10,%esp
}
  1000a9:	90                   	nop
  1000aa:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  1000ad:	c9                   	leave  
  1000ae:	c3                   	ret    

001000af <grade_backtrace0>:

void __attribute__((noinline))
grade_backtrace0(int arg0, int arg1, int arg2) {
  1000af:	55                   	push   %ebp
  1000b0:	89 e5                	mov    %esp,%ebp
  1000b2:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace1(arg0, arg2);
  1000b5:	83 ec 08             	sub    $0x8,%esp
  1000b8:	ff 75 10             	pushl  0x10(%ebp)
  1000bb:	ff 75 08             	pushl  0x8(%ebp)
  1000be:	e8 c7 ff ff ff       	call   10008a <grade_backtrace1>
  1000c3:	83 c4 10             	add    $0x10,%esp
}
  1000c6:	90                   	nop
  1000c7:	c9                   	leave  
  1000c8:	c3                   	ret    

001000c9 <grade_backtrace>:

void
grade_backtrace(void) {
  1000c9:	55                   	push   %ebp
  1000ca:	89 e5                	mov    %esp,%ebp
  1000cc:	83 ec 08             	sub    $0x8,%esp
    grade_backtrace0(0, (int)kern_init, 0xffff0000);
  1000cf:	b8 00 00 10 00       	mov    $0x100000,%eax
  1000d4:	83 ec 04             	sub    $0x4,%esp
  1000d7:	68 00 00 ff ff       	push   $0xffff0000
  1000dc:	50                   	push   %eax
  1000dd:	6a 00                	push   $0x0
  1000df:	e8 cb ff ff ff       	call   1000af <grade_backtrace0>
  1000e4:	83 c4 10             	add    $0x10,%esp
}
  1000e7:	90                   	nop
  1000e8:	c9                   	leave  
  1000e9:	c3                   	ret    

001000ea <lab1_print_cur_status>:

static void
lab1_print_cur_status(void) {
  1000ea:	55                   	push   %ebp
  1000eb:	89 e5                	mov    %esp,%ebp
  1000ed:	83 ec 18             	sub    $0x18,%esp
    static int round = 0;
    uint16_t reg1, reg2, reg3, reg4;
    asm volatile (
  1000f0:	8c 4d f6             	mov    %cs,-0xa(%ebp)
  1000f3:	8c 5d f4             	mov    %ds,-0xc(%ebp)
  1000f6:	8c 45 f2             	mov    %es,-0xe(%ebp)
  1000f9:	8c 55 f0             	mov    %ss,-0x10(%ebp)
            "mov %%cs, %0;"
            "mov %%ds, %1;"
            "mov %%es, %2;"
            "mov %%ss, %3;"
            : "=m"(reg1), "=m"(reg2), "=m"(reg3), "=m"(reg4));
    cprintf("%d: @ring %d\n", round, reg1 & 3);
  1000fc:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100100:	0f b7 c0             	movzwl %ax,%eax
  100103:	83 e0 03             	and    $0x3,%eax
  100106:	89 c2                	mov    %eax,%edx
  100108:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  10010d:	83 ec 04             	sub    $0x4,%esp
  100110:	52                   	push   %edx
  100111:	50                   	push   %eax
  100112:	68 c1 34 10 00       	push   $0x1034c1
  100117:	e8 31 01 00 00       	call   10024d <cprintf>
  10011c:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  cs = %x\n", round, reg1);
  10011f:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
  100123:	0f b7 d0             	movzwl %ax,%edx
  100126:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  10012b:	83 ec 04             	sub    $0x4,%esp
  10012e:	52                   	push   %edx
  10012f:	50                   	push   %eax
  100130:	68 cf 34 10 00       	push   $0x1034cf
  100135:	e8 13 01 00 00       	call   10024d <cprintf>
  10013a:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ds = %x\n", round, reg2);
  10013d:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100141:	0f b7 d0             	movzwl %ax,%edx
  100144:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100149:	83 ec 04             	sub    $0x4,%esp
  10014c:	52                   	push   %edx
  10014d:	50                   	push   %eax
  10014e:	68 dd 34 10 00       	push   $0x1034dd
  100153:	e8 f5 00 00 00       	call   10024d <cprintf>
  100158:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  es = %x\n", round, reg3);
  10015b:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  10015f:	0f b7 d0             	movzwl %ax,%edx
  100162:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100167:	83 ec 04             	sub    $0x4,%esp
  10016a:	52                   	push   %edx
  10016b:	50                   	push   %eax
  10016c:	68 eb 34 10 00       	push   $0x1034eb
  100171:	e8 d7 00 00 00       	call   10024d <cprintf>
  100176:	83 c4 10             	add    $0x10,%esp
    cprintf("%d:  ss = %x\n", round, reg4);
  100179:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  10017d:	0f b7 d0             	movzwl %ax,%edx
  100180:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  100185:	83 ec 04             	sub    $0x4,%esp
  100188:	52                   	push   %edx
  100189:	50                   	push   %eax
  10018a:	68 f9 34 10 00       	push   $0x1034f9
  10018f:	e8 b9 00 00 00       	call   10024d <cprintf>
  100194:	83 c4 10             	add    $0x10,%esp
    round ++;
  100197:	a1 20 ea 10 00       	mov    0x10ea20,%eax
  10019c:	83 c0 01             	add    $0x1,%eax
  10019f:	a3 20 ea 10 00       	mov    %eax,0x10ea20
}
  1001a4:	90                   	nop
  1001a5:	c9                   	leave  
  1001a6:	c3                   	ret    

001001a7 <lab1_switch_to_user>:

static void
lab1_switch_to_user(void) {
  1001a7:	55                   	push   %ebp
  1001a8:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 : TODO
    asm volatile (
  1001aa:	83 ec 08             	sub    $0x8,%esp
  1001ad:	cd 78                	int    $0x78
  1001af:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp" 
        : 
        : "i"(T_SWITCH_TOU)
    );
}
  1001b1:	90                   	nop
  1001b2:	5d                   	pop    %ebp
  1001b3:	c3                   	ret    

001001b4 <lab1_switch_to_kernel>:

static void
lab1_switch_to_kernel(void) {
  1001b4:	55                   	push   %ebp
  1001b5:	89 e5                	mov    %esp,%ebp
    //LAB1 CHALLENGE 1 :  TODO
    asm volatile (
  1001b7:	cd 79                	int    $0x79
  1001b9:	89 ec                	mov    %ebp,%esp
        "int %0 \n"
        "movl %%ebp, %%esp" 
        : 
        : "i"(T_SWITCH_TOK)
    );
}
  1001bb:	90                   	nop
  1001bc:	5d                   	pop    %ebp
  1001bd:	c3                   	ret    

001001be <lab1_switch_test>:

static void
lab1_switch_test(void) {
  1001be:	55                   	push   %ebp
  1001bf:	89 e5                	mov    %esp,%ebp
  1001c1:	83 ec 08             	sub    $0x8,%esp
    lab1_print_cur_status();
  1001c4:	e8 21 ff ff ff       	call   1000ea <lab1_print_cur_status>
    cprintf("+++ switch to  user  mode +++\n");
  1001c9:	83 ec 0c             	sub    $0xc,%esp
  1001cc:	68 08 35 10 00       	push   $0x103508
  1001d1:	e8 77 00 00 00       	call   10024d <cprintf>
  1001d6:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_user();
  1001d9:	e8 c9 ff ff ff       	call   1001a7 <lab1_switch_to_user>
    lab1_print_cur_status();
  1001de:	e8 07 ff ff ff       	call   1000ea <lab1_print_cur_status>
    cprintf("+++ switch to kernel mode +++\n");
  1001e3:	83 ec 0c             	sub    $0xc,%esp
  1001e6:	68 28 35 10 00       	push   $0x103528
  1001eb:	e8 5d 00 00 00       	call   10024d <cprintf>
  1001f0:	83 c4 10             	add    $0x10,%esp
    lab1_switch_to_kernel();
  1001f3:	e8 bc ff ff ff       	call   1001b4 <lab1_switch_to_kernel>
    lab1_print_cur_status();
  1001f8:	e8 ed fe ff ff       	call   1000ea <lab1_print_cur_status>
}
  1001fd:	90                   	nop
  1001fe:	c9                   	leave  
  1001ff:	c3                   	ret    

00100200 <cputch>:
/* *
 * cputch - writes a single character @c to stdout, and it will
 * increace the value of counter pointed by @cnt.
 * */
static void
cputch(int c, int *cnt) {
  100200:	55                   	push   %ebp
  100201:	89 e5                	mov    %esp,%ebp
  100203:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  100206:	83 ec 0c             	sub    $0xc,%esp
  100209:	ff 75 08             	pushl  0x8(%ebp)
  10020c:	e8 64 13 00 00       	call   101575 <cons_putc>
  100211:	83 c4 10             	add    $0x10,%esp
    (*cnt) ++;
  100214:	8b 45 0c             	mov    0xc(%ebp),%eax
  100217:	8b 00                	mov    (%eax),%eax
  100219:	8d 50 01             	lea    0x1(%eax),%edx
  10021c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10021f:	89 10                	mov    %edx,(%eax)
}
  100221:	90                   	nop
  100222:	c9                   	leave  
  100223:	c3                   	ret    

00100224 <vcprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want cprintf() instead.
 * */
int
vcprintf(const char *fmt, va_list ap) {
  100224:	55                   	push   %ebp
  100225:	89 e5                	mov    %esp,%ebp
  100227:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  10022a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    vprintfmt((void*)cputch, &cnt, fmt, ap);
  100231:	ff 75 0c             	pushl  0xc(%ebp)
  100234:	ff 75 08             	pushl  0x8(%ebp)
  100237:	8d 45 f4             	lea    -0xc(%ebp),%eax
  10023a:	50                   	push   %eax
  10023b:	68 00 02 10 00       	push   $0x100200
  100240:	e8 ed 2d 00 00       	call   103032 <vprintfmt>
  100245:	83 c4 10             	add    $0x10,%esp
    return cnt;
  100248:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10024b:	c9                   	leave  
  10024c:	c3                   	ret    

0010024d <cprintf>:
 *
 * The return value is the number of characters which would be
 * written to stdout.
 * */
int
cprintf(const char *fmt, ...) {
  10024d:	55                   	push   %ebp
  10024e:	89 e5                	mov    %esp,%ebp
  100250:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  100253:	8d 45 0c             	lea    0xc(%ebp),%eax
  100256:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vcprintf(fmt, ap);
  100259:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10025c:	83 ec 08             	sub    $0x8,%esp
  10025f:	50                   	push   %eax
  100260:	ff 75 08             	pushl  0x8(%ebp)
  100263:	e8 bc ff ff ff       	call   100224 <vcprintf>
  100268:	83 c4 10             	add    $0x10,%esp
  10026b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  10026e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100271:	c9                   	leave  
  100272:	c3                   	ret    

00100273 <cputchar>:

/* cputchar - writes a single character to stdout */
void
cputchar(int c) {
  100273:	55                   	push   %ebp
  100274:	89 e5                	mov    %esp,%ebp
  100276:	83 ec 08             	sub    $0x8,%esp
    cons_putc(c);
  100279:	83 ec 0c             	sub    $0xc,%esp
  10027c:	ff 75 08             	pushl  0x8(%ebp)
  10027f:	e8 f1 12 00 00       	call   101575 <cons_putc>
  100284:	83 c4 10             	add    $0x10,%esp
}
  100287:	90                   	nop
  100288:	c9                   	leave  
  100289:	c3                   	ret    

0010028a <cputs>:
/* *
 * cputs- writes the string pointed by @str to stdout and
 * appends a newline character.
 * */
int
cputs(const char *str) {
  10028a:	55                   	push   %ebp
  10028b:	89 e5                	mov    %esp,%ebp
  10028d:	83 ec 18             	sub    $0x18,%esp
    int cnt = 0;
  100290:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    char c;
    while ((c = *str ++) != '\0') {
  100297:	eb 14                	jmp    1002ad <cputs+0x23>
        cputch(c, &cnt);
  100299:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  10029d:	83 ec 08             	sub    $0x8,%esp
  1002a0:	8d 55 f0             	lea    -0x10(%ebp),%edx
  1002a3:	52                   	push   %edx
  1002a4:	50                   	push   %eax
  1002a5:	e8 56 ff ff ff       	call   100200 <cputch>
  1002aa:	83 c4 10             	add    $0x10,%esp
    while ((c = *str ++) != '\0') {
  1002ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1002b0:	8d 50 01             	lea    0x1(%eax),%edx
  1002b3:	89 55 08             	mov    %edx,0x8(%ebp)
  1002b6:	0f b6 00             	movzbl (%eax),%eax
  1002b9:	88 45 f7             	mov    %al,-0x9(%ebp)
  1002bc:	80 7d f7 00          	cmpb   $0x0,-0x9(%ebp)
  1002c0:	75 d7                	jne    100299 <cputs+0xf>
    }
    cputch('\n', &cnt);
  1002c2:	83 ec 08             	sub    $0x8,%esp
  1002c5:	8d 45 f0             	lea    -0x10(%ebp),%eax
  1002c8:	50                   	push   %eax
  1002c9:	6a 0a                	push   $0xa
  1002cb:	e8 30 ff ff ff       	call   100200 <cputch>
  1002d0:	83 c4 10             	add    $0x10,%esp
    return cnt;
  1002d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  1002d6:	c9                   	leave  
  1002d7:	c3                   	ret    

001002d8 <getchar>:

/* getchar - reads a single non-zero character from stdin */
int
getchar(void) {
  1002d8:	55                   	push   %ebp
  1002d9:	89 e5                	mov    %esp,%ebp
  1002db:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = cons_getc()) == 0)
  1002de:	e8 c2 12 00 00       	call   1015a5 <cons_getc>
  1002e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1002e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1002ea:	74 f2                	je     1002de <getchar+0x6>
        /* do nothing */;
    return c;
  1002ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  1002ef:	c9                   	leave  
  1002f0:	c3                   	ret    

001002f1 <readline>:
 * The readline() function returns the text of the line read. If some errors
 * are happened, NULL is returned. The return value is a global variable,
 * thus it should be copied before it is used.
 * */
char *
readline(const char *prompt) {
  1002f1:	55                   	push   %ebp
  1002f2:	89 e5                	mov    %esp,%ebp
  1002f4:	83 ec 18             	sub    $0x18,%esp
    if (prompt != NULL) {
  1002f7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  1002fb:	74 13                	je     100310 <readline+0x1f>
        cprintf("%s", prompt);
  1002fd:	83 ec 08             	sub    $0x8,%esp
  100300:	ff 75 08             	pushl  0x8(%ebp)
  100303:	68 47 35 10 00       	push   $0x103547
  100308:	e8 40 ff ff ff       	call   10024d <cprintf>
  10030d:	83 c4 10             	add    $0x10,%esp
    }
    int i = 0, c;
  100310:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        c = getchar();
  100317:	e8 bc ff ff ff       	call   1002d8 <getchar>
  10031c:	89 45 f0             	mov    %eax,-0x10(%ebp)
        if (c < 0) {
  10031f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100323:	79 0a                	jns    10032f <readline+0x3e>
            return NULL;
  100325:	b8 00 00 00 00       	mov    $0x0,%eax
  10032a:	e9 82 00 00 00       	jmp    1003b1 <readline+0xc0>
        }
        else if (c >= ' ' && i < BUFSIZE - 1) {
  10032f:	83 7d f0 1f          	cmpl   $0x1f,-0x10(%ebp)
  100333:	7e 2b                	jle    100360 <readline+0x6f>
  100335:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  10033c:	7f 22                	jg     100360 <readline+0x6f>
            cputchar(c);
  10033e:	83 ec 0c             	sub    $0xc,%esp
  100341:	ff 75 f0             	pushl  -0x10(%ebp)
  100344:	e8 2a ff ff ff       	call   100273 <cputchar>
  100349:	83 c4 10             	add    $0x10,%esp
            buf[i ++] = c;
  10034c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10034f:	8d 50 01             	lea    0x1(%eax),%edx
  100352:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100355:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100358:	88 90 40 ea 10 00    	mov    %dl,0x10ea40(%eax)
  10035e:	eb 4c                	jmp    1003ac <readline+0xbb>
        }
        else if (c == '\b' && i > 0) {
  100360:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
  100364:	75 1a                	jne    100380 <readline+0x8f>
  100366:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10036a:	7e 14                	jle    100380 <readline+0x8f>
            cputchar(c);
  10036c:	83 ec 0c             	sub    $0xc,%esp
  10036f:	ff 75 f0             	pushl  -0x10(%ebp)
  100372:	e8 fc fe ff ff       	call   100273 <cputchar>
  100377:	83 c4 10             	add    $0x10,%esp
            i --;
  10037a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  10037e:	eb 2c                	jmp    1003ac <readline+0xbb>
        }
        else if (c == '\n' || c == '\r') {
  100380:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
  100384:	74 06                	je     10038c <readline+0x9b>
  100386:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
  10038a:	75 8b                	jne    100317 <readline+0x26>
            cputchar(c);
  10038c:	83 ec 0c             	sub    $0xc,%esp
  10038f:	ff 75 f0             	pushl  -0x10(%ebp)
  100392:	e8 dc fe ff ff       	call   100273 <cputchar>
  100397:	83 c4 10             	add    $0x10,%esp
            buf[i] = '\0';
  10039a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10039d:	05 40 ea 10 00       	add    $0x10ea40,%eax
  1003a2:	c6 00 00             	movb   $0x0,(%eax)
            return buf;
  1003a5:	b8 40 ea 10 00       	mov    $0x10ea40,%eax
  1003aa:	eb 05                	jmp    1003b1 <readline+0xc0>
        }
    }
  1003ac:	e9 66 ff ff ff       	jmp    100317 <readline+0x26>
}
  1003b1:	c9                   	leave  
  1003b2:	c3                   	ret    

001003b3 <__panic>:
/* *
 * __panic - __panic is called on unresolvable fatal errors. it prints
 * "panic: 'message'", and then enters the kernel monitor.
 * */
void
__panic(const char *file, int line, const char *fmt, ...) {
  1003b3:	55                   	push   %ebp
  1003b4:	89 e5                	mov    %esp,%ebp
  1003b6:	83 ec 18             	sub    $0x18,%esp
    if (is_panic) {
  1003b9:	a1 40 ee 10 00       	mov    0x10ee40,%eax
  1003be:	85 c0                	test   %eax,%eax
  1003c0:	75 5f                	jne    100421 <__panic+0x6e>
        goto panic_dead;
    }
    is_panic = 1;
  1003c2:	c7 05 40 ee 10 00 01 	movl   $0x1,0x10ee40
  1003c9:	00 00 00 

    // print the 'message'
    va_list ap;
    va_start(ap, fmt);
  1003cc:	8d 45 14             	lea    0x14(%ebp),%eax
  1003cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel panic at %s:%d:\n    ", file, line);
  1003d2:	83 ec 04             	sub    $0x4,%esp
  1003d5:	ff 75 0c             	pushl  0xc(%ebp)
  1003d8:	ff 75 08             	pushl  0x8(%ebp)
  1003db:	68 4a 35 10 00       	push   $0x10354a
  1003e0:	e8 68 fe ff ff       	call   10024d <cprintf>
  1003e5:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  1003e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1003eb:	83 ec 08             	sub    $0x8,%esp
  1003ee:	50                   	push   %eax
  1003ef:	ff 75 10             	pushl  0x10(%ebp)
  1003f2:	e8 2d fe ff ff       	call   100224 <vcprintf>
  1003f7:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  1003fa:	83 ec 0c             	sub    $0xc,%esp
  1003fd:	68 66 35 10 00       	push   $0x103566
  100402:	e8 46 fe ff ff       	call   10024d <cprintf>
  100407:	83 c4 10             	add    $0x10,%esp
    
    cprintf("stack trackback:\n");
  10040a:	83 ec 0c             	sub    $0xc,%esp
  10040d:	68 68 35 10 00       	push   $0x103568
  100412:	e8 36 fe ff ff       	call   10024d <cprintf>
  100417:	83 c4 10             	add    $0x10,%esp
    print_stackframe();
  10041a:	e8 17 06 00 00       	call   100a36 <print_stackframe>
  10041f:	eb 01                	jmp    100422 <__panic+0x6f>
        goto panic_dead;
  100421:	90                   	nop
    
    va_end(ap);

panic_dead:
    intr_disable();
  100422:	e8 a4 13 00 00       	call   1017cb <intr_disable>
    while (1) {
        kmonitor(NULL);
  100427:	83 ec 0c             	sub    $0xc,%esp
  10042a:	6a 00                	push   $0x0
  10042c:	e8 0c 08 00 00       	call   100c3d <kmonitor>
  100431:	83 c4 10             	add    $0x10,%esp
    }
  100434:	eb f1                	jmp    100427 <__panic+0x74>

00100436 <__warn>:
}

/* __warn - like panic, but don't */
void
__warn(const char *file, int line, const char *fmt, ...) {
  100436:	55                   	push   %ebp
  100437:	89 e5                	mov    %esp,%ebp
  100439:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    va_start(ap, fmt);
  10043c:	8d 45 14             	lea    0x14(%ebp),%eax
  10043f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    cprintf("kernel warning at %s:%d:\n    ", file, line);
  100442:	83 ec 04             	sub    $0x4,%esp
  100445:	ff 75 0c             	pushl  0xc(%ebp)
  100448:	ff 75 08             	pushl  0x8(%ebp)
  10044b:	68 7a 35 10 00       	push   $0x10357a
  100450:	e8 f8 fd ff ff       	call   10024d <cprintf>
  100455:	83 c4 10             	add    $0x10,%esp
    vcprintf(fmt, ap);
  100458:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10045b:	83 ec 08             	sub    $0x8,%esp
  10045e:	50                   	push   %eax
  10045f:	ff 75 10             	pushl  0x10(%ebp)
  100462:	e8 bd fd ff ff       	call   100224 <vcprintf>
  100467:	83 c4 10             	add    $0x10,%esp
    cprintf("\n");
  10046a:	83 ec 0c             	sub    $0xc,%esp
  10046d:	68 66 35 10 00       	push   $0x103566
  100472:	e8 d6 fd ff ff       	call   10024d <cprintf>
  100477:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  10047a:	90                   	nop
  10047b:	c9                   	leave  
  10047c:	c3                   	ret    

0010047d <is_kernel_panic>:

bool
is_kernel_panic(void) {
  10047d:	55                   	push   %ebp
  10047e:	89 e5                	mov    %esp,%ebp
    return is_panic;
  100480:	a1 40 ee 10 00       	mov    0x10ee40,%eax
}
  100485:	5d                   	pop    %ebp
  100486:	c3                   	ret    

00100487 <stab_binsearch>:
 *      stab_binsearch(stabs, &left, &right, N_SO, 0xf0100184);
 * will exit setting left = 118, right = 554.
 * */
static void
stab_binsearch(const struct stab *stabs, int *region_left, int *region_right,
           int type, uintptr_t addr) {
  100487:	55                   	push   %ebp
  100488:	89 e5                	mov    %esp,%ebp
  10048a:	83 ec 20             	sub    $0x20,%esp
    int l = *region_left, r = *region_right, any_matches = 0;
  10048d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100490:	8b 00                	mov    (%eax),%eax
  100492:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100495:	8b 45 10             	mov    0x10(%ebp),%eax
  100498:	8b 00                	mov    (%eax),%eax
  10049a:	89 45 f8             	mov    %eax,-0x8(%ebp)
  10049d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

    while (l <= r) {
  1004a4:	e9 d2 00 00 00       	jmp    10057b <stab_binsearch+0xf4>
        int true_m = (l + r) / 2, m = true_m;
  1004a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1004ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
  1004af:	01 d0                	add    %edx,%eax
  1004b1:	89 c2                	mov    %eax,%edx
  1004b3:	c1 ea 1f             	shr    $0x1f,%edx
  1004b6:	01 d0                	add    %edx,%eax
  1004b8:	d1 f8                	sar    %eax
  1004ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
  1004bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004c0:	89 45 f0             	mov    %eax,-0x10(%ebp)

        // search for earliest stab with right type
        while (m >= l && stabs[m].n_type != type) {
  1004c3:	eb 04                	jmp    1004c9 <stab_binsearch+0x42>
            m --;
  1004c5:	83 6d f0 01          	subl   $0x1,-0x10(%ebp)
        while (m >= l && stabs[m].n_type != type) {
  1004c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004cc:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004cf:	7c 1f                	jl     1004f0 <stab_binsearch+0x69>
  1004d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  1004d4:	89 d0                	mov    %edx,%eax
  1004d6:	01 c0                	add    %eax,%eax
  1004d8:	01 d0                	add    %edx,%eax
  1004da:	c1 e0 02             	shl    $0x2,%eax
  1004dd:	89 c2                	mov    %eax,%edx
  1004df:	8b 45 08             	mov    0x8(%ebp),%eax
  1004e2:	01 d0                	add    %edx,%eax
  1004e4:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1004e8:	0f b6 c0             	movzbl %al,%eax
  1004eb:	3b 45 14             	cmp    0x14(%ebp),%eax
  1004ee:	75 d5                	jne    1004c5 <stab_binsearch+0x3e>
        }
        if (m < l) {    // no match in [l, m]
  1004f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1004f3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1004f6:	7d 0b                	jge    100503 <stab_binsearch+0x7c>
            l = true_m + 1;
  1004f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  1004fb:	83 c0 01             	add    $0x1,%eax
  1004fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
            continue;
  100501:	eb 78                	jmp    10057b <stab_binsearch+0xf4>
        }

        // actual binary search
        any_matches = 1;
  100503:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
        if (stabs[m].n_value < addr) {
  10050a:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10050d:	89 d0                	mov    %edx,%eax
  10050f:	01 c0                	add    %eax,%eax
  100511:	01 d0                	add    %edx,%eax
  100513:	c1 e0 02             	shl    $0x2,%eax
  100516:	89 c2                	mov    %eax,%edx
  100518:	8b 45 08             	mov    0x8(%ebp),%eax
  10051b:	01 d0                	add    %edx,%eax
  10051d:	8b 40 08             	mov    0x8(%eax),%eax
  100520:	3b 45 18             	cmp    0x18(%ebp),%eax
  100523:	73 13                	jae    100538 <stab_binsearch+0xb1>
            *region_left = m;
  100525:	8b 45 0c             	mov    0xc(%ebp),%eax
  100528:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10052b:	89 10                	mov    %edx,(%eax)
            l = true_m + 1;
  10052d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  100530:	83 c0 01             	add    $0x1,%eax
  100533:	89 45 fc             	mov    %eax,-0x4(%ebp)
  100536:	eb 43                	jmp    10057b <stab_binsearch+0xf4>
        } else if (stabs[m].n_value > addr) {
  100538:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10053b:	89 d0                	mov    %edx,%eax
  10053d:	01 c0                	add    %eax,%eax
  10053f:	01 d0                	add    %edx,%eax
  100541:	c1 e0 02             	shl    $0x2,%eax
  100544:	89 c2                	mov    %eax,%edx
  100546:	8b 45 08             	mov    0x8(%ebp),%eax
  100549:	01 d0                	add    %edx,%eax
  10054b:	8b 40 08             	mov    0x8(%eax),%eax
  10054e:	3b 45 18             	cmp    0x18(%ebp),%eax
  100551:	76 16                	jbe    100569 <stab_binsearch+0xe2>
            *region_right = m - 1;
  100553:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100556:	8d 50 ff             	lea    -0x1(%eax),%edx
  100559:	8b 45 10             	mov    0x10(%ebp),%eax
  10055c:	89 10                	mov    %edx,(%eax)
            r = m - 1;
  10055e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100561:	83 e8 01             	sub    $0x1,%eax
  100564:	89 45 f8             	mov    %eax,-0x8(%ebp)
  100567:	eb 12                	jmp    10057b <stab_binsearch+0xf4>
        } else {
            // exact match for 'addr', but continue loop to find
            // *region_right
            *region_left = m;
  100569:	8b 45 0c             	mov    0xc(%ebp),%eax
  10056c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  10056f:	89 10                	mov    %edx,(%eax)
            l = m;
  100571:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100574:	89 45 fc             	mov    %eax,-0x4(%ebp)
            addr ++;
  100577:	83 45 18 01          	addl   $0x1,0x18(%ebp)
    while (l <= r) {
  10057b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10057e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  100581:	0f 8e 22 ff ff ff    	jle    1004a9 <stab_binsearch+0x22>
        }
    }

    if (!any_matches) {
  100587:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  10058b:	75 0f                	jne    10059c <stab_binsearch+0x115>
        *region_right = *region_left - 1;
  10058d:	8b 45 0c             	mov    0xc(%ebp),%eax
  100590:	8b 00                	mov    (%eax),%eax
  100592:	8d 50 ff             	lea    -0x1(%eax),%edx
  100595:	8b 45 10             	mov    0x10(%ebp),%eax
  100598:	89 10                	mov    %edx,(%eax)
        l = *region_right;
        for (; l > *region_left && stabs[l].n_type != type; l --)
            /* do nothing */;
        *region_left = l;
    }
}
  10059a:	eb 3f                	jmp    1005db <stab_binsearch+0x154>
        l = *region_right;
  10059c:	8b 45 10             	mov    0x10(%ebp),%eax
  10059f:	8b 00                	mov    (%eax),%eax
  1005a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
        for (; l > *region_left && stabs[l].n_type != type; l --)
  1005a4:	eb 04                	jmp    1005aa <stab_binsearch+0x123>
  1005a6:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
  1005aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005ad:	8b 00                	mov    (%eax),%eax
  1005af:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  1005b2:	7d 1f                	jge    1005d3 <stab_binsearch+0x14c>
  1005b4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005b7:	89 d0                	mov    %edx,%eax
  1005b9:	01 c0                	add    %eax,%eax
  1005bb:	01 d0                	add    %edx,%eax
  1005bd:	c1 e0 02             	shl    $0x2,%eax
  1005c0:	89 c2                	mov    %eax,%edx
  1005c2:	8b 45 08             	mov    0x8(%ebp),%eax
  1005c5:	01 d0                	add    %edx,%eax
  1005c7:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1005cb:	0f b6 c0             	movzbl %al,%eax
  1005ce:	3b 45 14             	cmp    0x14(%ebp),%eax
  1005d1:	75 d3                	jne    1005a6 <stab_binsearch+0x11f>
        *region_left = l;
  1005d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005d6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  1005d9:	89 10                	mov    %edx,(%eax)
}
  1005db:	90                   	nop
  1005dc:	c9                   	leave  
  1005dd:	c3                   	ret    

001005de <debuginfo_eip>:
 * the specified instruction address, @addr.  Returns 0 if information
 * was found, and negative if not.  But even if it returns negative it
 * has stored some information into '*info'.
 * */
int
debuginfo_eip(uintptr_t addr, struct eipdebuginfo *info) {
  1005de:	55                   	push   %ebp
  1005df:	89 e5                	mov    %esp,%ebp
  1005e1:	83 ec 38             	sub    $0x38,%esp
    const struct stab *stabs, *stab_end;
    const char *stabstr, *stabstr_end;

    info->eip_file = "<unknown>";
  1005e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005e7:	c7 00 98 35 10 00    	movl   $0x103598,(%eax)
    info->eip_line = 0;
  1005ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005f0:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
    info->eip_fn_name = "<unknown>";
  1005f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  1005fa:	c7 40 08 98 35 10 00 	movl   $0x103598,0x8(%eax)
    info->eip_fn_namelen = 9;
  100601:	8b 45 0c             	mov    0xc(%ebp),%eax
  100604:	c7 40 0c 09 00 00 00 	movl   $0x9,0xc(%eax)
    info->eip_fn_addr = addr;
  10060b:	8b 45 0c             	mov    0xc(%ebp),%eax
  10060e:	8b 55 08             	mov    0x8(%ebp),%edx
  100611:	89 50 10             	mov    %edx,0x10(%eax)
    info->eip_fn_narg = 0;
  100614:	8b 45 0c             	mov    0xc(%ebp),%eax
  100617:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)

    stabs = __STAB_BEGIN__;
  10061e:	c7 45 f4 cc 3d 10 00 	movl   $0x103dcc,-0xc(%ebp)
    stab_end = __STAB_END__;
  100625:	c7 45 f0 4c b7 10 00 	movl   $0x10b74c,-0x10(%ebp)
    stabstr = __STABSTR_BEGIN__;
  10062c:	c7 45 ec 4d b7 10 00 	movl   $0x10b74d,-0x14(%ebp)
    stabstr_end = __STABSTR_END__;
  100633:	c7 45 e8 76 d7 10 00 	movl   $0x10d776,-0x18(%ebp)

    // String table validity checks
    if (stabstr_end <= stabstr || stabstr_end[-1] != 0) {
  10063a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10063d:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  100640:	76 0d                	jbe    10064f <debuginfo_eip+0x71>
  100642:	8b 45 e8             	mov    -0x18(%ebp),%eax
  100645:	83 e8 01             	sub    $0x1,%eax
  100648:	0f b6 00             	movzbl (%eax),%eax
  10064b:	84 c0                	test   %al,%al
  10064d:	74 0a                	je     100659 <debuginfo_eip+0x7b>
        return -1;
  10064f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  100654:	e9 91 02 00 00       	jmp    1008ea <debuginfo_eip+0x30c>
    // 'eip'.  First, we find the basic source file containing 'eip'.
    // Then, we look in that source file for the function.  Then we look
    // for the line number.

    // Search the entire set of stabs for the source file (type N_SO).
    int lfile = 0, rfile = (stab_end - stabs) - 1;
  100659:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  100660:	8b 55 f0             	mov    -0x10(%ebp),%edx
  100663:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100666:	29 c2                	sub    %eax,%edx
  100668:	89 d0                	mov    %edx,%eax
  10066a:	c1 f8 02             	sar    $0x2,%eax
  10066d:	69 c0 ab aa aa aa    	imul   $0xaaaaaaab,%eax,%eax
  100673:	83 e8 01             	sub    $0x1,%eax
  100676:	89 45 e0             	mov    %eax,-0x20(%ebp)
    stab_binsearch(stabs, &lfile, &rfile, N_SO, addr);
  100679:	ff 75 08             	pushl  0x8(%ebp)
  10067c:	6a 64                	push   $0x64
  10067e:	8d 45 e0             	lea    -0x20(%ebp),%eax
  100681:	50                   	push   %eax
  100682:	8d 45 e4             	lea    -0x1c(%ebp),%eax
  100685:	50                   	push   %eax
  100686:	ff 75 f4             	pushl  -0xc(%ebp)
  100689:	e8 f9 fd ff ff       	call   100487 <stab_binsearch>
  10068e:	83 c4 14             	add    $0x14,%esp
    if (lfile == 0)
  100691:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100694:	85 c0                	test   %eax,%eax
  100696:	75 0a                	jne    1006a2 <debuginfo_eip+0xc4>
        return -1;
  100698:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  10069d:	e9 48 02 00 00       	jmp    1008ea <debuginfo_eip+0x30c>

    // Search within that file's stabs for the function definition
    // (N_FUN).
    int lfun = lfile, rfun = rfile;
  1006a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1006a5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  1006a8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  1006ab:	89 45 d8             	mov    %eax,-0x28(%ebp)
    int lline, rline;
    stab_binsearch(stabs, &lfun, &rfun, N_FUN, addr);
  1006ae:	ff 75 08             	pushl  0x8(%ebp)
  1006b1:	6a 24                	push   $0x24
  1006b3:	8d 45 d8             	lea    -0x28(%ebp),%eax
  1006b6:	50                   	push   %eax
  1006b7:	8d 45 dc             	lea    -0x24(%ebp),%eax
  1006ba:	50                   	push   %eax
  1006bb:	ff 75 f4             	pushl  -0xc(%ebp)
  1006be:	e8 c4 fd ff ff       	call   100487 <stab_binsearch>
  1006c3:	83 c4 14             	add    $0x14,%esp

    if (lfun <= rfun) {
  1006c6:	8b 55 dc             	mov    -0x24(%ebp),%edx
  1006c9:	8b 45 d8             	mov    -0x28(%ebp),%eax
  1006cc:	39 c2                	cmp    %eax,%edx
  1006ce:	7f 7c                	jg     10074c <debuginfo_eip+0x16e>
        // stabs[lfun] points to the function name
        // in the string table, but check bounds just in case.
        if (stabs[lfun].n_strx < stabstr_end - stabstr) {
  1006d0:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006d3:	89 c2                	mov    %eax,%edx
  1006d5:	89 d0                	mov    %edx,%eax
  1006d7:	01 c0                	add    %eax,%eax
  1006d9:	01 d0                	add    %edx,%eax
  1006db:	c1 e0 02             	shl    $0x2,%eax
  1006de:	89 c2                	mov    %eax,%edx
  1006e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1006e3:	01 d0                	add    %edx,%eax
  1006e5:	8b 00                	mov    (%eax),%eax
  1006e7:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  1006ea:	8b 55 ec             	mov    -0x14(%ebp),%edx
  1006ed:	29 d1                	sub    %edx,%ecx
  1006ef:	89 ca                	mov    %ecx,%edx
  1006f1:	39 d0                	cmp    %edx,%eax
  1006f3:	73 22                	jae    100717 <debuginfo_eip+0x139>
            info->eip_fn_name = stabstr + stabs[lfun].n_strx;
  1006f5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  1006f8:	89 c2                	mov    %eax,%edx
  1006fa:	89 d0                	mov    %edx,%eax
  1006fc:	01 c0                	add    %eax,%eax
  1006fe:	01 d0                	add    %edx,%eax
  100700:	c1 e0 02             	shl    $0x2,%eax
  100703:	89 c2                	mov    %eax,%edx
  100705:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100708:	01 d0                	add    %edx,%eax
  10070a:	8b 10                	mov    (%eax),%edx
  10070c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10070f:	01 c2                	add    %eax,%edx
  100711:	8b 45 0c             	mov    0xc(%ebp),%eax
  100714:	89 50 08             	mov    %edx,0x8(%eax)
        }
        info->eip_fn_addr = stabs[lfun].n_value;
  100717:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10071a:	89 c2                	mov    %eax,%edx
  10071c:	89 d0                	mov    %edx,%eax
  10071e:	01 c0                	add    %eax,%eax
  100720:	01 d0                	add    %edx,%eax
  100722:	c1 e0 02             	shl    $0x2,%eax
  100725:	89 c2                	mov    %eax,%edx
  100727:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10072a:	01 d0                	add    %edx,%eax
  10072c:	8b 50 08             	mov    0x8(%eax),%edx
  10072f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100732:	89 50 10             	mov    %edx,0x10(%eax)
        addr -= info->eip_fn_addr;
  100735:	8b 45 0c             	mov    0xc(%ebp),%eax
  100738:	8b 40 10             	mov    0x10(%eax),%eax
  10073b:	29 45 08             	sub    %eax,0x8(%ebp)
        // Search within the function definition for the line number.
        lline = lfun;
  10073e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100741:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfun;
  100744:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100747:	89 45 d0             	mov    %eax,-0x30(%ebp)
  10074a:	eb 15                	jmp    100761 <debuginfo_eip+0x183>
    } else {
        // Couldn't find function stab!  Maybe we're in an assembly
        // file.  Search the whole file for the line number.
        info->eip_fn_addr = addr;
  10074c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10074f:	8b 55 08             	mov    0x8(%ebp),%edx
  100752:	89 50 10             	mov    %edx,0x10(%eax)
        lline = lfile;
  100755:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100758:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        rline = rfile;
  10075b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  10075e:	89 45 d0             	mov    %eax,-0x30(%ebp)
    }
    info->eip_fn_namelen = strfind(info->eip_fn_name, ':') - info->eip_fn_name;
  100761:	8b 45 0c             	mov    0xc(%ebp),%eax
  100764:	8b 40 08             	mov    0x8(%eax),%eax
  100767:	83 ec 08             	sub    $0x8,%esp
  10076a:	6a 3a                	push   $0x3a
  10076c:	50                   	push   %eax
  10076d:	e8 fe 23 00 00       	call   102b70 <strfind>
  100772:	83 c4 10             	add    $0x10,%esp
  100775:	89 c2                	mov    %eax,%edx
  100777:	8b 45 0c             	mov    0xc(%ebp),%eax
  10077a:	8b 40 08             	mov    0x8(%eax),%eax
  10077d:	29 c2                	sub    %eax,%edx
  10077f:	8b 45 0c             	mov    0xc(%ebp),%eax
  100782:	89 50 0c             	mov    %edx,0xc(%eax)

    // Search within [lline, rline] for the line number stab.
    // If found, set info->eip_line to the right line number.
    // If not found, return -1.
    stab_binsearch(stabs, &lline, &rline, N_SLINE, addr);
  100785:	83 ec 0c             	sub    $0xc,%esp
  100788:	ff 75 08             	pushl  0x8(%ebp)
  10078b:	6a 44                	push   $0x44
  10078d:	8d 45 d0             	lea    -0x30(%ebp),%eax
  100790:	50                   	push   %eax
  100791:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  100794:	50                   	push   %eax
  100795:	ff 75 f4             	pushl  -0xc(%ebp)
  100798:	e8 ea fc ff ff       	call   100487 <stab_binsearch>
  10079d:	83 c4 20             	add    $0x20,%esp
    if (lline <= rline) {
  1007a0:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007a3:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007a6:	39 c2                	cmp    %eax,%edx
  1007a8:	7f 24                	jg     1007ce <debuginfo_eip+0x1f0>
        info->eip_line = stabs[rline].n_desc;
  1007aa:	8b 45 d0             	mov    -0x30(%ebp),%eax
  1007ad:	89 c2                	mov    %eax,%edx
  1007af:	89 d0                	mov    %edx,%eax
  1007b1:	01 c0                	add    %eax,%eax
  1007b3:	01 d0                	add    %edx,%eax
  1007b5:	c1 e0 02             	shl    $0x2,%eax
  1007b8:	89 c2                	mov    %eax,%edx
  1007ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007bd:	01 d0                	add    %edx,%eax
  1007bf:	0f b7 40 06          	movzwl 0x6(%eax),%eax
  1007c3:	0f b7 d0             	movzwl %ax,%edx
  1007c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1007c9:	89 50 04             	mov    %edx,0x4(%eax)

    // Search backwards from the line number for the relevant filename stab.
    // We can't just use the "lfile" stab because inlined functions
    // can interpolate code from a different file!
    // Such included source files use the N_SOL stab type.
    while (lline >= lfile
  1007cc:	eb 13                	jmp    1007e1 <debuginfo_eip+0x203>
        return -1;
  1007ce:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1007d3:	e9 12 01 00 00       	jmp    1008ea <debuginfo_eip+0x30c>
           && stabs[lline].n_type != N_SOL
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
        lline --;
  1007d8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007db:	83 e8 01             	sub    $0x1,%eax
  1007de:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    while (lline >= lfile
  1007e1:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1007e4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1007e7:	39 c2                	cmp    %eax,%edx
  1007e9:	7c 56                	jl     100841 <debuginfo_eip+0x263>
           && stabs[lline].n_type != N_SOL
  1007eb:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1007ee:	89 c2                	mov    %eax,%edx
  1007f0:	89 d0                	mov    %edx,%eax
  1007f2:	01 c0                	add    %eax,%eax
  1007f4:	01 d0                	add    %edx,%eax
  1007f6:	c1 e0 02             	shl    $0x2,%eax
  1007f9:	89 c2                	mov    %eax,%edx
  1007fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1007fe:	01 d0                	add    %edx,%eax
  100800:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100804:	3c 84                	cmp    $0x84,%al
  100806:	74 39                	je     100841 <debuginfo_eip+0x263>
           && (stabs[lline].n_type != N_SO || !stabs[lline].n_value)) {
  100808:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10080b:	89 c2                	mov    %eax,%edx
  10080d:	89 d0                	mov    %edx,%eax
  10080f:	01 c0                	add    %eax,%eax
  100811:	01 d0                	add    %edx,%eax
  100813:	c1 e0 02             	shl    $0x2,%eax
  100816:	89 c2                	mov    %eax,%edx
  100818:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10081b:	01 d0                	add    %edx,%eax
  10081d:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  100821:	3c 64                	cmp    $0x64,%al
  100823:	75 b3                	jne    1007d8 <debuginfo_eip+0x1fa>
  100825:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100828:	89 c2                	mov    %eax,%edx
  10082a:	89 d0                	mov    %edx,%eax
  10082c:	01 c0                	add    %eax,%eax
  10082e:	01 d0                	add    %edx,%eax
  100830:	c1 e0 02             	shl    $0x2,%eax
  100833:	89 c2                	mov    %eax,%edx
  100835:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100838:	01 d0                	add    %edx,%eax
  10083a:	8b 40 08             	mov    0x8(%eax),%eax
  10083d:	85 c0                	test   %eax,%eax
  10083f:	74 97                	je     1007d8 <debuginfo_eip+0x1fa>
    }
    if (lline >= lfile && stabs[lline].n_strx < stabstr_end - stabstr) {
  100841:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  100844:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  100847:	39 c2                	cmp    %eax,%edx
  100849:	7c 46                	jl     100891 <debuginfo_eip+0x2b3>
  10084b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  10084e:	89 c2                	mov    %eax,%edx
  100850:	89 d0                	mov    %edx,%eax
  100852:	01 c0                	add    %eax,%eax
  100854:	01 d0                	add    %edx,%eax
  100856:	c1 e0 02             	shl    $0x2,%eax
  100859:	89 c2                	mov    %eax,%edx
  10085b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10085e:	01 d0                	add    %edx,%eax
  100860:	8b 00                	mov    (%eax),%eax
  100862:	8b 4d e8             	mov    -0x18(%ebp),%ecx
  100865:	8b 55 ec             	mov    -0x14(%ebp),%edx
  100868:	29 d1                	sub    %edx,%ecx
  10086a:	89 ca                	mov    %ecx,%edx
  10086c:	39 d0                	cmp    %edx,%eax
  10086e:	73 21                	jae    100891 <debuginfo_eip+0x2b3>
        info->eip_file = stabstr + stabs[lline].n_strx;
  100870:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  100873:	89 c2                	mov    %eax,%edx
  100875:	89 d0                	mov    %edx,%eax
  100877:	01 c0                	add    %eax,%eax
  100879:	01 d0                	add    %edx,%eax
  10087b:	c1 e0 02             	shl    $0x2,%eax
  10087e:	89 c2                	mov    %eax,%edx
  100880:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100883:	01 d0                	add    %edx,%eax
  100885:	8b 10                	mov    (%eax),%edx
  100887:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10088a:	01 c2                	add    %eax,%edx
  10088c:	8b 45 0c             	mov    0xc(%ebp),%eax
  10088f:	89 10                	mov    %edx,(%eax)
    }

    // Set eip_fn_narg to the number of arguments taken by the function,
    // or 0 if there was no containing function.
    if (lfun < rfun) {
  100891:	8b 55 dc             	mov    -0x24(%ebp),%edx
  100894:	8b 45 d8             	mov    -0x28(%ebp),%eax
  100897:	39 c2                	cmp    %eax,%edx
  100899:	7d 4a                	jge    1008e5 <debuginfo_eip+0x307>
        for (lline = lfun + 1;
  10089b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  10089e:	83 c0 01             	add    $0x1,%eax
  1008a1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  1008a4:	eb 18                	jmp    1008be <debuginfo_eip+0x2e0>
             lline < rfun && stabs[lline].n_type == N_PSYM;
             lline ++) {
            info->eip_fn_narg ++;
  1008a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008a9:	8b 40 14             	mov    0x14(%eax),%eax
  1008ac:	8d 50 01             	lea    0x1(%eax),%edx
  1008af:	8b 45 0c             	mov    0xc(%ebp),%eax
  1008b2:	89 50 14             	mov    %edx,0x14(%eax)
             lline ++) {
  1008b5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008b8:	83 c0 01             	add    $0x1,%eax
  1008bb:	89 45 d4             	mov    %eax,-0x2c(%ebp)
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008be:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  1008c1:	8b 45 d8             	mov    -0x28(%ebp),%eax
        for (lline = lfun + 1;
  1008c4:	39 c2                	cmp    %eax,%edx
  1008c6:	7d 1d                	jge    1008e5 <debuginfo_eip+0x307>
             lline < rfun && stabs[lline].n_type == N_PSYM;
  1008c8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  1008cb:	89 c2                	mov    %eax,%edx
  1008cd:	89 d0                	mov    %edx,%eax
  1008cf:	01 c0                	add    %eax,%eax
  1008d1:	01 d0                	add    %edx,%eax
  1008d3:	c1 e0 02             	shl    $0x2,%eax
  1008d6:	89 c2                	mov    %eax,%edx
  1008d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1008db:	01 d0                	add    %edx,%eax
  1008dd:	0f b6 40 04          	movzbl 0x4(%eax),%eax
  1008e1:	3c a0                	cmp    $0xa0,%al
  1008e3:	74 c1                	je     1008a6 <debuginfo_eip+0x2c8>
        }
    }
    return 0;
  1008e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1008ea:	c9                   	leave  
  1008eb:	c3                   	ret    

001008ec <print_kerninfo>:
 * print_kerninfo - print the information about kernel, including the location
 * of kernel entry, the start addresses of data and text segements, the start
 * address of free memory and how many memory that kernel has used.
 * */
void
print_kerninfo(void) {
  1008ec:	55                   	push   %ebp
  1008ed:	89 e5                	mov    %esp,%ebp
  1008ef:	83 ec 08             	sub    $0x8,%esp
    extern char etext[], edata[], end[], kern_init[];
    cprintf("Special kernel symbols:\n");
  1008f2:	83 ec 0c             	sub    $0xc,%esp
  1008f5:	68 a2 35 10 00       	push   $0x1035a2
  1008fa:	e8 4e f9 ff ff       	call   10024d <cprintf>
  1008ff:	83 c4 10             	add    $0x10,%esp
    cprintf("  entry  0x%08x (phys)\n", kern_init);
  100902:	83 ec 08             	sub    $0x8,%esp
  100905:	68 00 00 10 00       	push   $0x100000
  10090a:	68 bb 35 10 00       	push   $0x1035bb
  10090f:	e8 39 f9 ff ff       	call   10024d <cprintf>
  100914:	83 c4 10             	add    $0x10,%esp
    cprintf("  etext  0x%08x (phys)\n", etext);
  100917:	83 ec 08             	sub    $0x8,%esp
  10091a:	68 93 34 10 00       	push   $0x103493
  10091f:	68 d3 35 10 00       	push   $0x1035d3
  100924:	e8 24 f9 ff ff       	call   10024d <cprintf>
  100929:	83 c4 10             	add    $0x10,%esp
    cprintf("  edata  0x%08x (phys)\n", edata);
  10092c:	83 ec 08             	sub    $0x8,%esp
  10092f:	68 16 ea 10 00       	push   $0x10ea16
  100934:	68 eb 35 10 00       	push   $0x1035eb
  100939:	e8 0f f9 ff ff       	call   10024d <cprintf>
  10093e:	83 c4 10             	add    $0x10,%esp
    cprintf("  end    0x%08x (phys)\n", end);
  100941:	83 ec 08             	sub    $0x8,%esp
  100944:	68 20 fd 10 00       	push   $0x10fd20
  100949:	68 03 36 10 00       	push   $0x103603
  10094e:	e8 fa f8 ff ff       	call   10024d <cprintf>
  100953:	83 c4 10             	add    $0x10,%esp
    cprintf("Kernel executable memory footprint: %dKB\n", (end - kern_init + 1023)/1024);
  100956:	b8 20 fd 10 00       	mov    $0x10fd20,%eax
  10095b:	05 ff 03 00 00       	add    $0x3ff,%eax
  100960:	ba 00 00 10 00       	mov    $0x100000,%edx
  100965:	29 d0                	sub    %edx,%eax
  100967:	8d 90 ff 03 00 00    	lea    0x3ff(%eax),%edx
  10096d:	85 c0                	test   %eax,%eax
  10096f:	0f 48 c2             	cmovs  %edx,%eax
  100972:	c1 f8 0a             	sar    $0xa,%eax
  100975:	83 ec 08             	sub    $0x8,%esp
  100978:	50                   	push   %eax
  100979:	68 1c 36 10 00       	push   $0x10361c
  10097e:	e8 ca f8 ff ff       	call   10024d <cprintf>
  100983:	83 c4 10             	add    $0x10,%esp
}
  100986:	90                   	nop
  100987:	c9                   	leave  
  100988:	c3                   	ret    

00100989 <print_debuginfo>:
/* *
 * print_debuginfo - read and print the stat information for the address @eip,
 * and info.eip_fn_addr should be the first address of the related function.
 * */
void
print_debuginfo(uintptr_t eip) {
  100989:	55                   	push   %ebp
  10098a:	89 e5                	mov    %esp,%ebp
  10098c:	81 ec 28 01 00 00    	sub    $0x128,%esp
    struct eipdebuginfo info;
    if (debuginfo_eip(eip, &info) != 0) {
  100992:	83 ec 08             	sub    $0x8,%esp
  100995:	8d 45 dc             	lea    -0x24(%ebp),%eax
  100998:	50                   	push   %eax
  100999:	ff 75 08             	pushl  0x8(%ebp)
  10099c:	e8 3d fc ff ff       	call   1005de <debuginfo_eip>
  1009a1:	83 c4 10             	add    $0x10,%esp
  1009a4:	85 c0                	test   %eax,%eax
  1009a6:	74 15                	je     1009bd <print_debuginfo+0x34>
        cprintf("    <unknow>: -- 0x%08x --\n", eip);
  1009a8:	83 ec 08             	sub    $0x8,%esp
  1009ab:	ff 75 08             	pushl  0x8(%ebp)
  1009ae:	68 46 36 10 00       	push   $0x103646
  1009b3:	e8 95 f8 ff ff       	call   10024d <cprintf>
  1009b8:	83 c4 10             	add    $0x10,%esp
        }
        fnname[j] = '\0';
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
                fnname, eip - info.eip_fn_addr);
    }
}
  1009bb:	eb 65                	jmp    100a22 <print_debuginfo+0x99>
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  1009c4:	eb 1c                	jmp    1009e2 <print_debuginfo+0x59>
            fnname[j] = info.eip_fn_name[j];
  1009c6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1009c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009cc:	01 d0                	add    %edx,%eax
  1009ce:	0f b6 00             	movzbl (%eax),%eax
  1009d1:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  1009d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1009da:	01 ca                	add    %ecx,%edx
  1009dc:	88 02                	mov    %al,(%edx)
        for (j = 0; j < info.eip_fn_namelen; j ++) {
  1009de:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  1009e2:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1009e5:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  1009e8:	7f dc                	jg     1009c6 <print_debuginfo+0x3d>
        fnname[j] = '\0';
  1009ea:	8d 95 dc fe ff ff    	lea    -0x124(%ebp),%edx
  1009f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1009f3:	01 d0                	add    %edx,%eax
  1009f5:	c6 00 00             	movb   $0x0,(%eax)
                fnname, eip - info.eip_fn_addr);
  1009f8:	8b 45 ec             	mov    -0x14(%ebp),%eax
        cprintf("    %s:%d: %s+%d\n", info.eip_file, info.eip_line,
  1009fb:	8b 55 08             	mov    0x8(%ebp),%edx
  1009fe:	89 d1                	mov    %edx,%ecx
  100a00:	29 c1                	sub    %eax,%ecx
  100a02:	8b 55 e0             	mov    -0x20(%ebp),%edx
  100a05:	8b 45 dc             	mov    -0x24(%ebp),%eax
  100a08:	83 ec 0c             	sub    $0xc,%esp
  100a0b:	51                   	push   %ecx
  100a0c:	8d 8d dc fe ff ff    	lea    -0x124(%ebp),%ecx
  100a12:	51                   	push   %ecx
  100a13:	52                   	push   %edx
  100a14:	50                   	push   %eax
  100a15:	68 62 36 10 00       	push   $0x103662
  100a1a:	e8 2e f8 ff ff       	call   10024d <cprintf>
  100a1f:	83 c4 20             	add    $0x20,%esp
}
  100a22:	90                   	nop
  100a23:	c9                   	leave  
  100a24:	c3                   	ret    

00100a25 <read_eip>:

static __noinline uint32_t
read_eip(void) {
  100a25:	55                   	push   %ebp
  100a26:	89 e5                	mov    %esp,%ebp
  100a28:	83 ec 10             	sub    $0x10,%esp
    uint32_t eip;
    asm volatile("movl 4(%%ebp), %0" : "=r" (eip));
  100a2b:	8b 45 04             	mov    0x4(%ebp),%eax
  100a2e:	89 45 fc             	mov    %eax,-0x4(%ebp)
    return eip;
  100a31:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  100a34:	c9                   	leave  
  100a35:	c3                   	ret    

00100a36 <print_stackframe>:
 *
 * Note that, the length of ebp-chain is limited. In boot/bootasm.S, before jumping
 * to the kernel entry, the value of ebp has been set to zero, that's the boundary.
 * */
void
print_stackframe(void) {
  100a36:	55                   	push   %ebp
  100a37:	89 e5                	mov    %esp,%ebp
  100a39:	53                   	push   %ebx
  100a3a:	83 ec 14             	sub    $0x14,%esp
}

static inline uint32_t
read_ebp(void) {
    uint32_t ebp;
    asm volatile ("movl %%ebp, %0" : "=r" (ebp));
  100a3d:	89 e8                	mov    %ebp,%eax
  100a3f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    return ebp;
  100a42:	8b 45 e8             	mov    -0x18(%ebp),%eax
     /* LAB1 YOUR CODE : STEP 1 */
    uint32_t ebp, eip, i;
    ebp = read_ebp();
  100a45:	89 45 f4             	mov    %eax,-0xc(%ebp)
    eip = read_eip();
  100a48:	e8 d8 ff ff ff       	call   100a25 <read_eip>
  100a4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    for (i = 0; i < STACKFRAME_DEPTH; ++i) {
  100a50:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  100a57:	eb 69                	jmp    100ac2 <print_stackframe+0x8c>
        cprintf("ebp:0x%08x eip:0x%08x args:0x%08x 0x%08x 0x%08x 0x%08x\n", ebp, eip, *((uintptr_t*)ebp+2), *((uintptr_t*)ebp+3), *((uintptr_t*)ebp+4), *((uintptr_t*)ebp+5));
  100a59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a5c:	83 c0 14             	add    $0x14,%eax
  100a5f:	8b 18                	mov    (%eax),%ebx
  100a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a64:	83 c0 10             	add    $0x10,%eax
  100a67:	8b 08                	mov    (%eax),%ecx
  100a69:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a6c:	83 c0 0c             	add    $0xc,%eax
  100a6f:	8b 10                	mov    (%eax),%edx
  100a71:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100a74:	83 c0 08             	add    $0x8,%eax
  100a77:	8b 00                	mov    (%eax),%eax
  100a79:	83 ec 04             	sub    $0x4,%esp
  100a7c:	53                   	push   %ebx
  100a7d:	51                   	push   %ecx
  100a7e:	52                   	push   %edx
  100a7f:	50                   	push   %eax
  100a80:	ff 75 f0             	pushl  -0x10(%ebp)
  100a83:	ff 75 f4             	pushl  -0xc(%ebp)
  100a86:	68 74 36 10 00       	push   $0x103674
  100a8b:	e8 bd f7 ff ff       	call   10024d <cprintf>
  100a90:	83 c4 20             	add    $0x20,%esp
        print_debuginfo(eip - 1);
  100a93:	8b 45 f0             	mov    -0x10(%ebp),%eax
  100a96:	83 e8 01             	sub    $0x1,%eax
  100a99:	83 ec 0c             	sub    $0xc,%esp
  100a9c:	50                   	push   %eax
  100a9d:	e8 e7 fe ff ff       	call   100989 <print_debuginfo>
  100aa2:	83 c4 10             	add    $0x10,%esp
        eip = *((uintptr_t*)ebp+1);
  100aa5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100aa8:	83 c0 04             	add    $0x4,%eax
  100aab:	8b 00                	mov    (%eax),%eax
  100aad:	89 45 f0             	mov    %eax,-0x10(%ebp)
        ebp = *((uintptr_t*)ebp);
  100ab0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100ab3:	8b 00                	mov    (%eax),%eax
  100ab5:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (ebp == 0)
  100ab8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100abc:	74 0c                	je     100aca <print_stackframe+0x94>
    for (i = 0; i < STACKFRAME_DEPTH; ++i) {
  100abe:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
  100ac2:	83 7d ec 13          	cmpl   $0x13,-0x14(%ebp)
  100ac6:	76 91                	jbe    100a59 <print_stackframe+0x23>
      *    (3.4) call print_debuginfo(eip-1) to print the C calling function name and line number, etc.
      *    (3.5) popup a calling stackframe
      *           NOTICE: the calling funciton's return addr eip  = ss:[ebp+4]
      *                   the calling funciton's ebp = ss:[ebp]
      */
}
  100ac8:	eb 01                	jmp    100acb <print_stackframe+0x95>
            break;
  100aca:	90                   	nop
}
  100acb:	90                   	nop
  100acc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  100acf:	c9                   	leave  
  100ad0:	c3                   	ret    

00100ad1 <parse>:
#define MAXARGS         16
#define WHITESPACE      " \t\n\r"

/* parse - parse the command buffer into whitespace-separated arguments */
static int
parse(char *buf, char **argv) {
  100ad1:	55                   	push   %ebp
  100ad2:	89 e5                	mov    %esp,%ebp
  100ad4:	83 ec 18             	sub    $0x18,%esp
    int argc = 0;
  100ad7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while (1) {
        // find global whitespace
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100ade:	eb 0c                	jmp    100aec <parse+0x1b>
            *buf ++ = '\0';
  100ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  100ae3:	8d 50 01             	lea    0x1(%eax),%edx
  100ae6:	89 55 08             	mov    %edx,0x8(%ebp)
  100ae9:	c6 00 00             	movb   $0x0,(%eax)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) != NULL) {
  100aec:	8b 45 08             	mov    0x8(%ebp),%eax
  100aef:	0f b6 00             	movzbl (%eax),%eax
  100af2:	84 c0                	test   %al,%al
  100af4:	74 1e                	je     100b14 <parse+0x43>
  100af6:	8b 45 08             	mov    0x8(%ebp),%eax
  100af9:	0f b6 00             	movzbl (%eax),%eax
  100afc:	0f be c0             	movsbl %al,%eax
  100aff:	83 ec 08             	sub    $0x8,%esp
  100b02:	50                   	push   %eax
  100b03:	68 2c 37 10 00       	push   $0x10372c
  100b08:	e8 30 20 00 00       	call   102b3d <strchr>
  100b0d:	83 c4 10             	add    $0x10,%esp
  100b10:	85 c0                	test   %eax,%eax
  100b12:	75 cc                	jne    100ae0 <parse+0xf>
        }
        if (*buf == '\0') {
  100b14:	8b 45 08             	mov    0x8(%ebp),%eax
  100b17:	0f b6 00             	movzbl (%eax),%eax
  100b1a:	84 c0                	test   %al,%al
  100b1c:	74 69                	je     100b87 <parse+0xb6>
            break;
        }

        // save and scan past next arg
        if (argc == MAXARGS - 1) {
  100b1e:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
  100b22:	75 12                	jne    100b36 <parse+0x65>
            cprintf("Too many arguments (max %d).\n", MAXARGS);
  100b24:	83 ec 08             	sub    $0x8,%esp
  100b27:	6a 10                	push   $0x10
  100b29:	68 31 37 10 00       	push   $0x103731
  100b2e:	e8 1a f7 ff ff       	call   10024d <cprintf>
  100b33:	83 c4 10             	add    $0x10,%esp
        }
        argv[argc ++] = buf;
  100b36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100b39:	8d 50 01             	lea    0x1(%eax),%edx
  100b3c:	89 55 f4             	mov    %edx,-0xc(%ebp)
  100b3f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  100b46:	8b 45 0c             	mov    0xc(%ebp),%eax
  100b49:	01 c2                	add    %eax,%edx
  100b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  100b4e:	89 02                	mov    %eax,(%edx)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b50:	eb 04                	jmp    100b56 <parse+0x85>
            buf ++;
  100b52:	83 45 08 01          	addl   $0x1,0x8(%ebp)
        while (*buf != '\0' && strchr(WHITESPACE, *buf) == NULL) {
  100b56:	8b 45 08             	mov    0x8(%ebp),%eax
  100b59:	0f b6 00             	movzbl (%eax),%eax
  100b5c:	84 c0                	test   %al,%al
  100b5e:	0f 84 7a ff ff ff    	je     100ade <parse+0xd>
  100b64:	8b 45 08             	mov    0x8(%ebp),%eax
  100b67:	0f b6 00             	movzbl (%eax),%eax
  100b6a:	0f be c0             	movsbl %al,%eax
  100b6d:	83 ec 08             	sub    $0x8,%esp
  100b70:	50                   	push   %eax
  100b71:	68 2c 37 10 00       	push   $0x10372c
  100b76:	e8 c2 1f 00 00       	call   102b3d <strchr>
  100b7b:	83 c4 10             	add    $0x10,%esp
  100b7e:	85 c0                	test   %eax,%eax
  100b80:	74 d0                	je     100b52 <parse+0x81>
        }
    }
  100b82:	e9 57 ff ff ff       	jmp    100ade <parse+0xd>
            break;
  100b87:	90                   	nop
    return argc;
  100b88:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  100b8b:	c9                   	leave  
  100b8c:	c3                   	ret    

00100b8d <runcmd>:
/* *
 * runcmd - parse the input string, split it into separated arguments
 * and then lookup and invoke some related commands/
 * */
static int
runcmd(char *buf, struct trapframe *tf) {
  100b8d:	55                   	push   %ebp
  100b8e:	89 e5                	mov    %esp,%ebp
  100b90:	83 ec 58             	sub    $0x58,%esp
    char *argv[MAXARGS];
    int argc = parse(buf, argv);
  100b93:	83 ec 08             	sub    $0x8,%esp
  100b96:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100b99:	50                   	push   %eax
  100b9a:	ff 75 08             	pushl  0x8(%ebp)
  100b9d:	e8 2f ff ff ff       	call   100ad1 <parse>
  100ba2:	83 c4 10             	add    $0x10,%esp
  100ba5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if (argc == 0) {
  100ba8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  100bac:	75 0a                	jne    100bb8 <runcmd+0x2b>
        return 0;
  100bae:	b8 00 00 00 00       	mov    $0x0,%eax
  100bb3:	e9 83 00 00 00       	jmp    100c3b <runcmd+0xae>
    }
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100bb8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100bbf:	eb 59                	jmp    100c1a <runcmd+0x8d>
        if (strcmp(commands[i].name, argv[0]) == 0) {
  100bc1:	8b 4d b0             	mov    -0x50(%ebp),%ecx
  100bc4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100bc7:	89 d0                	mov    %edx,%eax
  100bc9:	01 c0                	add    %eax,%eax
  100bcb:	01 d0                	add    %edx,%eax
  100bcd:	c1 e0 02             	shl    $0x2,%eax
  100bd0:	05 00 e0 10 00       	add    $0x10e000,%eax
  100bd5:	8b 00                	mov    (%eax),%eax
  100bd7:	83 ec 08             	sub    $0x8,%esp
  100bda:	51                   	push   %ecx
  100bdb:	50                   	push   %eax
  100bdc:	e8 bc 1e 00 00       	call   102a9d <strcmp>
  100be1:	83 c4 10             	add    $0x10,%esp
  100be4:	85 c0                	test   %eax,%eax
  100be6:	75 2e                	jne    100c16 <runcmd+0x89>
            return commands[i].func(argc - 1, argv + 1, tf);
  100be8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100beb:	89 d0                	mov    %edx,%eax
  100bed:	01 c0                	add    %eax,%eax
  100bef:	01 d0                	add    %edx,%eax
  100bf1:	c1 e0 02             	shl    $0x2,%eax
  100bf4:	05 08 e0 10 00       	add    $0x10e008,%eax
  100bf9:	8b 10                	mov    (%eax),%edx
  100bfb:	8d 45 b0             	lea    -0x50(%ebp),%eax
  100bfe:	83 c0 04             	add    $0x4,%eax
  100c01:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  100c04:	83 e9 01             	sub    $0x1,%ecx
  100c07:	83 ec 04             	sub    $0x4,%esp
  100c0a:	ff 75 0c             	pushl  0xc(%ebp)
  100c0d:	50                   	push   %eax
  100c0e:	51                   	push   %ecx
  100c0f:	ff d2                	call   *%edx
  100c11:	83 c4 10             	add    $0x10,%esp
  100c14:	eb 25                	jmp    100c3b <runcmd+0xae>
    for (i = 0; i < NCOMMANDS; i ++) {
  100c16:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100c1a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100c1d:	83 f8 02             	cmp    $0x2,%eax
  100c20:	76 9f                	jbe    100bc1 <runcmd+0x34>
        }
    }
    cprintf("Unknown command '%s'\n", argv[0]);
  100c22:	8b 45 b0             	mov    -0x50(%ebp),%eax
  100c25:	83 ec 08             	sub    $0x8,%esp
  100c28:	50                   	push   %eax
  100c29:	68 4f 37 10 00       	push   $0x10374f
  100c2e:	e8 1a f6 ff ff       	call   10024d <cprintf>
  100c33:	83 c4 10             	add    $0x10,%esp
    return 0;
  100c36:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100c3b:	c9                   	leave  
  100c3c:	c3                   	ret    

00100c3d <kmonitor>:

/***** Implementations of basic kernel monitor commands *****/

void
kmonitor(struct trapframe *tf) {
  100c3d:	55                   	push   %ebp
  100c3e:	89 e5                	mov    %esp,%ebp
  100c40:	83 ec 18             	sub    $0x18,%esp
    cprintf("Welcome to the kernel debug monitor!!\n");
  100c43:	83 ec 0c             	sub    $0xc,%esp
  100c46:	68 68 37 10 00       	push   $0x103768
  100c4b:	e8 fd f5 ff ff       	call   10024d <cprintf>
  100c50:	83 c4 10             	add    $0x10,%esp
    cprintf("Type 'help' for a list of commands.\n");
  100c53:	83 ec 0c             	sub    $0xc,%esp
  100c56:	68 90 37 10 00       	push   $0x103790
  100c5b:	e8 ed f5 ff ff       	call   10024d <cprintf>
  100c60:	83 c4 10             	add    $0x10,%esp

    if (tf != NULL) {
  100c63:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  100c67:	74 0e                	je     100c77 <kmonitor+0x3a>
        print_trapframe(tf);
  100c69:	83 ec 0c             	sub    $0xc,%esp
  100c6c:	ff 75 08             	pushl  0x8(%ebp)
  100c6f:	e8 2e 0d 00 00       	call   1019a2 <print_trapframe>
  100c74:	83 c4 10             	add    $0x10,%esp
    }

    char *buf;
    while (1) {
        if ((buf = readline("K> ")) != NULL) {
  100c77:	83 ec 0c             	sub    $0xc,%esp
  100c7a:	68 b5 37 10 00       	push   $0x1037b5
  100c7f:	e8 6d f6 ff ff       	call   1002f1 <readline>
  100c84:	83 c4 10             	add    $0x10,%esp
  100c87:	89 45 f4             	mov    %eax,-0xc(%ebp)
  100c8a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  100c8e:	74 e7                	je     100c77 <kmonitor+0x3a>
            if (runcmd(buf, tf) < 0) {
  100c90:	83 ec 08             	sub    $0x8,%esp
  100c93:	ff 75 08             	pushl  0x8(%ebp)
  100c96:	ff 75 f4             	pushl  -0xc(%ebp)
  100c99:	e8 ef fe ff ff       	call   100b8d <runcmd>
  100c9e:	83 c4 10             	add    $0x10,%esp
  100ca1:	85 c0                	test   %eax,%eax
  100ca3:	78 02                	js     100ca7 <kmonitor+0x6a>
                break;
            }
        }
    }
  100ca5:	eb d0                	jmp    100c77 <kmonitor+0x3a>
                break;
  100ca7:	90                   	nop
}
  100ca8:	90                   	nop
  100ca9:	c9                   	leave  
  100caa:	c3                   	ret    

00100cab <mon_help>:

/* mon_help - print the information about mon_* functions */
int
mon_help(int argc, char **argv, struct trapframe *tf) {
  100cab:	55                   	push   %ebp
  100cac:	89 e5                	mov    %esp,%ebp
  100cae:	83 ec 18             	sub    $0x18,%esp
    int i;
    for (i = 0; i < NCOMMANDS; i ++) {
  100cb1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  100cb8:	eb 3c                	jmp    100cf6 <mon_help+0x4b>
        cprintf("%s - %s\n", commands[i].name, commands[i].desc);
  100cba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cbd:	89 d0                	mov    %edx,%eax
  100cbf:	01 c0                	add    %eax,%eax
  100cc1:	01 d0                	add    %edx,%eax
  100cc3:	c1 e0 02             	shl    $0x2,%eax
  100cc6:	05 04 e0 10 00       	add    $0x10e004,%eax
  100ccb:	8b 08                	mov    (%eax),%ecx
  100ccd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  100cd0:	89 d0                	mov    %edx,%eax
  100cd2:	01 c0                	add    %eax,%eax
  100cd4:	01 d0                	add    %edx,%eax
  100cd6:	c1 e0 02             	shl    $0x2,%eax
  100cd9:	05 00 e0 10 00       	add    $0x10e000,%eax
  100cde:	8b 00                	mov    (%eax),%eax
  100ce0:	83 ec 04             	sub    $0x4,%esp
  100ce3:	51                   	push   %ecx
  100ce4:	50                   	push   %eax
  100ce5:	68 b9 37 10 00       	push   $0x1037b9
  100cea:	e8 5e f5 ff ff       	call   10024d <cprintf>
  100cef:	83 c4 10             	add    $0x10,%esp
    for (i = 0; i < NCOMMANDS; i ++) {
  100cf2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  100cf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100cf9:	83 f8 02             	cmp    $0x2,%eax
  100cfc:	76 bc                	jbe    100cba <mon_help+0xf>
    }
    return 0;
  100cfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d03:	c9                   	leave  
  100d04:	c3                   	ret    

00100d05 <mon_kerninfo>:
/* *
 * mon_kerninfo - call print_kerninfo in kern/debug/kdebug.c to
 * print the memory occupancy in kernel.
 * */
int
mon_kerninfo(int argc, char **argv, struct trapframe *tf) {
  100d05:	55                   	push   %ebp
  100d06:	89 e5                	mov    %esp,%ebp
  100d08:	83 ec 08             	sub    $0x8,%esp
    print_kerninfo();
  100d0b:	e8 dc fb ff ff       	call   1008ec <print_kerninfo>
    return 0;
  100d10:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d15:	c9                   	leave  
  100d16:	c3                   	ret    

00100d17 <mon_backtrace>:
/* *
 * mon_backtrace - call print_stackframe in kern/debug/kdebug.c to
 * print a backtrace of the stack.
 * */
int
mon_backtrace(int argc, char **argv, struct trapframe *tf) {
  100d17:	55                   	push   %ebp
  100d18:	89 e5                	mov    %esp,%ebp
  100d1a:	83 ec 08             	sub    $0x8,%esp
    print_stackframe();
  100d1d:	e8 14 fd ff ff       	call   100a36 <print_stackframe>
    return 0;
  100d22:	b8 00 00 00 00       	mov    $0x0,%eax
}
  100d27:	c9                   	leave  
  100d28:	c3                   	ret    

00100d29 <clock_init>:
/* *
 * clock_init - initialize 8253 clock to interrupt 100 times per second,
 * and then enable IRQ_TIMER.
 * */
void
clock_init(void) {
  100d29:	55                   	push   %ebp
  100d2a:	89 e5                	mov    %esp,%ebp
  100d2c:	83 ec 18             	sub    $0x18,%esp
  100d2f:	66 c7 45 f6 43 00    	movw   $0x43,-0xa(%ebp)
  100d35:	c6 45 ef 34          	movb   $0x34,-0x11(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100d39:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
  100d3d:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100d41:	ee                   	out    %al,(%dx)
  100d42:	66 c7 45 f4 40 00    	movw   $0x40,-0xc(%ebp)
  100d48:	c6 45 f0 9c          	movb   $0x9c,-0x10(%ebp)
  100d4c:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
  100d50:	0f b7 55 f4          	movzwl -0xc(%ebp),%edx
  100d54:	ee                   	out    %al,(%dx)
  100d55:	66 c7 45 f2 40 00    	movw   $0x40,-0xe(%ebp)
  100d5b:	c6 45 f1 2e          	movb   $0x2e,-0xf(%ebp)
  100d5f:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  100d63:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100d67:	ee                   	out    %al,(%dx)
    outb(TIMER_MODE, TIMER_SEL0 | TIMER_RATEGEN | TIMER_16BIT);
    outb(IO_TIMER1, TIMER_DIV(100) % 256);
    outb(IO_TIMER1, TIMER_DIV(100) / 256);

    // initialize time counter 'ticks' to zero
    ticks = 0;
  100d68:	c7 05 08 f9 10 00 00 	movl   $0x0,0x10f908
  100d6f:	00 00 00 

    cprintf("++ setup timer interrupts\n");
  100d72:	83 ec 0c             	sub    $0xc,%esp
  100d75:	68 c2 37 10 00       	push   $0x1037c2
  100d7a:	e8 ce f4 ff ff       	call   10024d <cprintf>
  100d7f:	83 c4 10             	add    $0x10,%esp
    pic_enable(IRQ_TIMER);
  100d82:	83 ec 0c             	sub    $0xc,%esp
  100d85:	6a 00                	push   $0x0
  100d87:	e8 ce 08 00 00       	call   10165a <pic_enable>
  100d8c:	83 c4 10             	add    $0x10,%esp
}
  100d8f:	90                   	nop
  100d90:	c9                   	leave  
  100d91:	c3                   	ret    

00100d92 <delay>:
#include <picirq.h>
#include <trap.h>

/* stupid I/O delay routine necessitated by historical PC design flaws */
static void
delay(void) {
  100d92:	55                   	push   %ebp
  100d93:	89 e5                	mov    %esp,%ebp
  100d95:	83 ec 10             	sub    $0x10,%esp
  100d98:	66 c7 45 fe 84 00    	movw   $0x84,-0x2(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100d9e:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  100da2:	89 c2                	mov    %eax,%edx
  100da4:	ec                   	in     (%dx),%al
  100da5:	88 45 f4             	mov    %al,-0xc(%ebp)
  100da8:	66 c7 45 fc 84 00    	movw   $0x84,-0x4(%ebp)
  100dae:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
  100db2:	89 c2                	mov    %eax,%edx
  100db4:	ec                   	in     (%dx),%al
  100db5:	88 45 f5             	mov    %al,-0xb(%ebp)
  100db8:	66 c7 45 fa 84 00    	movw   $0x84,-0x6(%ebp)
  100dbe:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  100dc2:	89 c2                	mov    %eax,%edx
  100dc4:	ec                   	in     (%dx),%al
  100dc5:	88 45 f6             	mov    %al,-0xa(%ebp)
  100dc8:	66 c7 45 f8 84 00    	movw   $0x84,-0x8(%ebp)
  100dce:	0f b7 45 f8          	movzwl -0x8(%ebp),%eax
  100dd2:	89 c2                	mov    %eax,%edx
  100dd4:	ec                   	in     (%dx),%al
  100dd5:	88 45 f7             	mov    %al,-0x9(%ebp)
    inb(0x84);
    inb(0x84);
    inb(0x84);
    inb(0x84);
}
  100dd8:	90                   	nop
  100dd9:	c9                   	leave  
  100dda:	c3                   	ret    

00100ddb <cga_init>:
//    -- 数据寄存器 映射 到 端口 0x3D5或0x3B5 
//    -- 索引寄存器 0x3D4或0x3B4,决定在数据寄存器中的数据表示什么。

/* TEXT-mode CGA/VGA display output */
static void
cga_init(void) {
  100ddb:	55                   	push   %ebp
  100ddc:	89 e5                	mov    %esp,%ebp
  100dde:	83 ec 20             	sub    $0x20,%esp
    volatile uint16_t *cp = (uint16_t *)CGA_BUF;   //CGA_BUF: 0xB8000 (彩色显示的显存物理基址)
  100de1:	c7 45 fc 00 80 0b 00 	movl   $0xb8000,-0x4(%ebp)
    uint16_t was = *cp;                                            //保存当前显存0xB8000处的值
  100de8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100deb:	0f b7 00             	movzwl (%eax),%eax
  100dee:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
    *cp = (uint16_t) 0xA55A;                                   // 给这个地址随便写个值，看看能否再读出同样的值
  100df2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100df5:	66 c7 00 5a a5       	movw   $0xa55a,(%eax)
    if (*cp != 0xA55A) {                                            // 如果读不出来，说明没有这块显存，即是单显配置
  100dfa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100dfd:	0f b7 00             	movzwl (%eax),%eax
  100e00:	66 3d 5a a5          	cmp    $0xa55a,%ax
  100e04:	74 12                	je     100e18 <cga_init+0x3d>
        cp = (uint16_t*)MONO_BUF;                         //设置为单显的显存基址 MONO_BUF： 0xB0000
  100e06:	c7 45 fc 00 00 0b 00 	movl   $0xb0000,-0x4(%ebp)
        addr_6845 = MONO_BASE;                           //设置为单显控制的IO地址，MONO_BASE: 0x3B4
  100e0d:	66 c7 05 66 ee 10 00 	movw   $0x3b4,0x10ee66
  100e14:	b4 03 
  100e16:	eb 13                	jmp    100e2b <cga_init+0x50>
    } else {                                                                // 如果读出来了，有这块显存，即是彩显配置
        *cp = was;                                                      //还原原来显存位置的值
  100e18:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100e1b:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  100e1f:	66 89 10             	mov    %dx,(%eax)
        addr_6845 = CGA_BASE;                               // 设置为彩显控制的IO地址，CGA_BASE: 0x3D4 
  100e22:	66 c7 05 66 ee 10 00 	movw   $0x3d4,0x10ee66
  100e29:	d4 03 
    // Extract cursor location
    // 6845索引寄存器的index 0x0E（及十进制的14）== 光标位置(高位)
    // 6845索引寄存器的index 0x0F（及十进制的15）== 光标位置(低位)
    // 6845 reg 15 : Cursor Address (Low Byte)
    uint32_t pos;
    outb(addr_6845, 14);                                        
  100e2b:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e32:	0f b7 c0             	movzwl %ax,%eax
  100e35:	66 89 45 f8          	mov    %ax,-0x8(%ebp)
  100e39:	c6 45 ea 0e          	movb   $0xe,-0x16(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e3d:	0f b6 45 ea          	movzbl -0x16(%ebp),%eax
  100e41:	0f b7 55 f8          	movzwl -0x8(%ebp),%edx
  100e45:	ee                   	out    %al,(%dx)
    pos = inb(addr_6845 + 1) << 8;                       //读出了光标位置(高位)
  100e46:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e4d:	83 c0 01             	add    $0x1,%eax
  100e50:	0f b7 c0             	movzwl %ax,%eax
  100e53:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e57:	0f b7 45 f2          	movzwl -0xe(%ebp),%eax
  100e5b:	89 c2                	mov    %eax,%edx
  100e5d:	ec                   	in     (%dx),%al
  100e5e:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  100e61:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
  100e65:	0f b6 c0             	movzbl %al,%eax
  100e68:	c1 e0 08             	shl    $0x8,%eax
  100e6b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    outb(addr_6845, 15);
  100e6e:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e75:	0f b7 c0             	movzwl %ax,%eax
  100e78:	66 89 45 f0          	mov    %ax,-0x10(%ebp)
  100e7c:	c6 45 ec 0f          	movb   $0xf,-0x14(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100e80:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
  100e84:	0f b7 55 f0          	movzwl -0x10(%ebp),%edx
  100e88:	ee                   	out    %al,(%dx)
    pos |= inb(addr_6845 + 1);                             //读出了光标位置(低位)
  100e89:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  100e90:	83 c0 01             	add    $0x1,%eax
  100e93:	0f b7 c0             	movzwl %ax,%eax
  100e96:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100e9a:	0f b7 45 ee          	movzwl -0x12(%ebp),%eax
  100e9e:	89 c2                	mov    %eax,%edx
  100ea0:	ec                   	in     (%dx),%al
  100ea1:	88 45 ed             	mov    %al,-0x13(%ebp)
    return data;
  100ea4:	0f b6 45 ed          	movzbl -0x13(%ebp),%eax
  100ea8:	0f b6 c0             	movzbl %al,%eax
  100eab:	09 45 f4             	or     %eax,-0xc(%ebp)

    crt_buf = (uint16_t*) cp;                                  //crt_buf是CGA显存起始地址
  100eae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  100eb1:	a3 60 ee 10 00       	mov    %eax,0x10ee60
    crt_pos = pos;                                                  //crt_pos是CGA当前光标位置
  100eb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  100eb9:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
}
  100ebf:	90                   	nop
  100ec0:	c9                   	leave  
  100ec1:	c3                   	ret    

00100ec2 <serial_init>:

static bool serial_exists = 0;

static void
serial_init(void) {
  100ec2:	55                   	push   %ebp
  100ec3:	89 e5                	mov    %esp,%ebp
  100ec5:	83 ec 28             	sub    $0x28,%esp
  100ec8:	66 c7 45 f6 fa 03    	movw   $0x3fa,-0xa(%ebp)
  100ece:	c6 45 da 00          	movb   $0x0,-0x26(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100ed2:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
  100ed6:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  100eda:	ee                   	out    %al,(%dx)
  100edb:	66 c7 45 f4 fb 03    	movw   $0x3fb,-0xc(%ebp)
  100ee1:	c6 45 db 80          	movb   $0x80,-0x25(%ebp)
  100ee5:	0f b6 45 db          	movzbl -0x25(%ebp),%eax
  100ee9:	0f b7 55 f4          	movzwl -0xc(%ebp),%edx
  100eed:	ee                   	out    %al,(%dx)
  100eee:	66 c7 45 f2 f8 03    	movw   $0x3f8,-0xe(%ebp)
  100ef4:	c6 45 dc 0c          	movb   $0xc,-0x24(%ebp)
  100ef8:	0f b6 45 dc          	movzbl -0x24(%ebp),%eax
  100efc:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  100f00:	ee                   	out    %al,(%dx)
  100f01:	66 c7 45 f0 f9 03    	movw   $0x3f9,-0x10(%ebp)
  100f07:	c6 45 dd 00          	movb   $0x0,-0x23(%ebp)
  100f0b:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  100f0f:	0f b7 55 f0          	movzwl -0x10(%ebp),%edx
  100f13:	ee                   	out    %al,(%dx)
  100f14:	66 c7 45 ee fb 03    	movw   $0x3fb,-0x12(%ebp)
  100f1a:	c6 45 de 03          	movb   $0x3,-0x22(%ebp)
  100f1e:	0f b6 45 de          	movzbl -0x22(%ebp),%eax
  100f22:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  100f26:	ee                   	out    %al,(%dx)
  100f27:	66 c7 45 ec fc 03    	movw   $0x3fc,-0x14(%ebp)
  100f2d:	c6 45 df 00          	movb   $0x0,-0x21(%ebp)
  100f31:	0f b6 45 df          	movzbl -0x21(%ebp),%eax
  100f35:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  100f39:	ee                   	out    %al,(%dx)
  100f3a:	66 c7 45 ea f9 03    	movw   $0x3f9,-0x16(%ebp)
  100f40:	c6 45 e0 01          	movb   $0x1,-0x20(%ebp)
  100f44:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
  100f48:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  100f4c:	ee                   	out    %al,(%dx)
  100f4d:	66 c7 45 e8 fd 03    	movw   $0x3fd,-0x18(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f53:	0f b7 45 e8          	movzwl -0x18(%ebp),%eax
  100f57:	89 c2                	mov    %eax,%edx
  100f59:	ec                   	in     (%dx),%al
  100f5a:	88 45 e1             	mov    %al,-0x1f(%ebp)
    return data;
  100f5d:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
    // Enable rcv interrupts
    outb(COM1 + COM_IER, COM_IER_RDI);

    // Clear any preexisting overrun indications and interrupts
    // Serial port doesn't exist if COM_LSR returns 0xFF
    serial_exists = (inb(COM1 + COM_LSR) != 0xFF);
  100f61:	3c ff                	cmp    $0xff,%al
  100f63:	0f 95 c0             	setne  %al
  100f66:	0f b6 c0             	movzbl %al,%eax
  100f69:	a3 68 ee 10 00       	mov    %eax,0x10ee68
  100f6e:	66 c7 45 e6 fa 03    	movw   $0x3fa,-0x1a(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  100f74:	0f b7 45 e6          	movzwl -0x1a(%ebp),%eax
  100f78:	89 c2                	mov    %eax,%edx
  100f7a:	ec                   	in     (%dx),%al
  100f7b:	88 45 e2             	mov    %al,-0x1e(%ebp)
  100f7e:	66 c7 45 e4 f8 03    	movw   $0x3f8,-0x1c(%ebp)
  100f84:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
  100f88:	89 c2                	mov    %eax,%edx
  100f8a:	ec                   	in     (%dx),%al
  100f8b:	88 45 e3             	mov    %al,-0x1d(%ebp)
    (void) inb(COM1+COM_IIR);
    (void) inb(COM1+COM_RX);

    if (serial_exists) {
  100f8e:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  100f93:	85 c0                	test   %eax,%eax
  100f95:	74 0d                	je     100fa4 <serial_init+0xe2>
        pic_enable(IRQ_COM1);
  100f97:	83 ec 0c             	sub    $0xc,%esp
  100f9a:	6a 04                	push   $0x4
  100f9c:	e8 b9 06 00 00       	call   10165a <pic_enable>
  100fa1:	83 c4 10             	add    $0x10,%esp
    }
}
  100fa4:	90                   	nop
  100fa5:	c9                   	leave  
  100fa6:	c3                   	ret    

00100fa7 <lpt_putc_sub>:

static void
lpt_putc_sub(int c) {
  100fa7:	55                   	push   %ebp
  100fa8:	89 e5                	mov    %esp,%ebp
  100faa:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100fad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  100fb4:	eb 09                	jmp    100fbf <lpt_putc_sub+0x18>
        delay();
  100fb6:	e8 d7 fd ff ff       	call   100d92 <delay>
    for (i = 0; !(inb(LPTPORT + 1) & 0x80) && i < 12800; i ++) {
  100fbb:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  100fbf:	66 c7 45 f4 79 03    	movw   $0x379,-0xc(%ebp)
  100fc5:	0f b7 45 f4          	movzwl -0xc(%ebp),%eax
  100fc9:	89 c2                	mov    %eax,%edx
  100fcb:	ec                   	in     (%dx),%al
  100fcc:	88 45 f3             	mov    %al,-0xd(%ebp)
    return data;
  100fcf:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  100fd3:	84 c0                	test   %al,%al
  100fd5:	78 09                	js     100fe0 <lpt_putc_sub+0x39>
  100fd7:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  100fde:	7e d6                	jle    100fb6 <lpt_putc_sub+0xf>
    }
    outb(LPTPORT + 0, c);
  100fe0:	8b 45 08             	mov    0x8(%ebp),%eax
  100fe3:	0f b6 c0             	movzbl %al,%eax
  100fe6:	66 c7 45 f8 78 03    	movw   $0x378,-0x8(%ebp)
  100fec:	88 45 f0             	mov    %al,-0x10(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  100fef:	0f b6 45 f0          	movzbl -0x10(%ebp),%eax
  100ff3:	0f b7 55 f8          	movzwl -0x8(%ebp),%edx
  100ff7:	ee                   	out    %al,(%dx)
  100ff8:	66 c7 45 f6 7a 03    	movw   $0x37a,-0xa(%ebp)
  100ffe:	c6 45 f1 0d          	movb   $0xd,-0xf(%ebp)
  101002:	0f b6 45 f1          	movzbl -0xf(%ebp),%eax
  101006:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  10100a:	ee                   	out    %al,(%dx)
  10100b:	66 c7 45 fa 7a 03    	movw   $0x37a,-0x6(%ebp)
  101011:	c6 45 f2 08          	movb   $0x8,-0xe(%ebp)
  101015:	0f b6 45 f2          	movzbl -0xe(%ebp),%eax
  101019:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  10101d:	ee                   	out    %al,(%dx)
    outb(LPTPORT + 2, 0x08 | 0x04 | 0x01);
    outb(LPTPORT + 2, 0x08);
}
  10101e:	90                   	nop
  10101f:	c9                   	leave  
  101020:	c3                   	ret    

00101021 <lpt_putc>:

/* lpt_putc - copy console output to parallel port */
static void
lpt_putc(int c) {
  101021:	55                   	push   %ebp
  101022:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  101024:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  101028:	74 0d                	je     101037 <lpt_putc+0x16>
        lpt_putc_sub(c);
  10102a:	ff 75 08             	pushl  0x8(%ebp)
  10102d:	e8 75 ff ff ff       	call   100fa7 <lpt_putc_sub>
  101032:	83 c4 04             	add    $0x4,%esp
    else {
        lpt_putc_sub('\b');
        lpt_putc_sub(' ');
        lpt_putc_sub('\b');
    }
}
  101035:	eb 1e                	jmp    101055 <lpt_putc+0x34>
        lpt_putc_sub('\b');
  101037:	6a 08                	push   $0x8
  101039:	e8 69 ff ff ff       	call   100fa7 <lpt_putc_sub>
  10103e:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub(' ');
  101041:	6a 20                	push   $0x20
  101043:	e8 5f ff ff ff       	call   100fa7 <lpt_putc_sub>
  101048:	83 c4 04             	add    $0x4,%esp
        lpt_putc_sub('\b');
  10104b:	6a 08                	push   $0x8
  10104d:	e8 55 ff ff ff       	call   100fa7 <lpt_putc_sub>
  101052:	83 c4 04             	add    $0x4,%esp
}
  101055:	90                   	nop
  101056:	c9                   	leave  
  101057:	c3                   	ret    

00101058 <cga_putc>:

/* cga_putc - print character to console */
static void
cga_putc(int c) {
  101058:	55                   	push   %ebp
  101059:	89 e5                	mov    %esp,%ebp
  10105b:	53                   	push   %ebx
  10105c:	83 ec 14             	sub    $0x14,%esp
    // set black on white
    if (!(c & ~0xFF)) {
  10105f:	8b 45 08             	mov    0x8(%ebp),%eax
  101062:	b0 00                	mov    $0x0,%al
  101064:	85 c0                	test   %eax,%eax
  101066:	75 07                	jne    10106f <cga_putc+0x17>
        c |= 0x0700;
  101068:	81 4d 08 00 07 00 00 	orl    $0x700,0x8(%ebp)
    }

    switch (c & 0xff) {
  10106f:	8b 45 08             	mov    0x8(%ebp),%eax
  101072:	0f b6 c0             	movzbl %al,%eax
  101075:	83 f8 0a             	cmp    $0xa,%eax
  101078:	74 4e                	je     1010c8 <cga_putc+0x70>
  10107a:	83 f8 0d             	cmp    $0xd,%eax
  10107d:	74 59                	je     1010d8 <cga_putc+0x80>
  10107f:	83 f8 08             	cmp    $0x8,%eax
  101082:	0f 85 8a 00 00 00    	jne    101112 <cga_putc+0xba>
    case '\b':
        if (crt_pos > 0) {
  101088:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10108f:	66 85 c0             	test   %ax,%ax
  101092:	0f 84 a0 00 00 00    	je     101138 <cga_putc+0xe0>
            crt_pos --;
  101098:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10109f:	83 e8 01             	sub    $0x1,%eax
  1010a2:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
            crt_buf[crt_pos] = (c & ~0xff) | ' ';
  1010a8:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  1010ad:	0f b7 15 64 ee 10 00 	movzwl 0x10ee64,%edx
  1010b4:	0f b7 d2             	movzwl %dx,%edx
  1010b7:	01 d2                	add    %edx,%edx
  1010b9:	01 d0                	add    %edx,%eax
  1010bb:	8b 55 08             	mov    0x8(%ebp),%edx
  1010be:	b2 00                	mov    $0x0,%dl
  1010c0:	83 ca 20             	or     $0x20,%edx
  1010c3:	66 89 10             	mov    %dx,(%eax)
        }
        break;
  1010c6:	eb 70                	jmp    101138 <cga_putc+0xe0>
    case '\n':
        crt_pos += CRT_COLS;
  1010c8:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1010cf:	83 c0 50             	add    $0x50,%eax
  1010d2:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    case '\r':
        crt_pos -= (crt_pos % CRT_COLS);
  1010d8:	0f b7 1d 64 ee 10 00 	movzwl 0x10ee64,%ebx
  1010df:	0f b7 0d 64 ee 10 00 	movzwl 0x10ee64,%ecx
  1010e6:	0f b7 c1             	movzwl %cx,%eax
  1010e9:	69 c0 cd cc 00 00    	imul   $0xcccd,%eax,%eax
  1010ef:	c1 e8 10             	shr    $0x10,%eax
  1010f2:	89 c2                	mov    %eax,%edx
  1010f4:	66 c1 ea 06          	shr    $0x6,%dx
  1010f8:	89 d0                	mov    %edx,%eax
  1010fa:	c1 e0 02             	shl    $0x2,%eax
  1010fd:	01 d0                	add    %edx,%eax
  1010ff:	c1 e0 04             	shl    $0x4,%eax
  101102:	29 c1                	sub    %eax,%ecx
  101104:	89 ca                	mov    %ecx,%edx
  101106:	89 d8                	mov    %ebx,%eax
  101108:	29 d0                	sub    %edx,%eax
  10110a:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
        break;
  101110:	eb 27                	jmp    101139 <cga_putc+0xe1>
    default:
        crt_buf[crt_pos ++] = c;     // write the character
  101112:	8b 0d 60 ee 10 00    	mov    0x10ee60,%ecx
  101118:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  10111f:	8d 50 01             	lea    0x1(%eax),%edx
  101122:	66 89 15 64 ee 10 00 	mov    %dx,0x10ee64
  101129:	0f b7 c0             	movzwl %ax,%eax
  10112c:	01 c0                	add    %eax,%eax
  10112e:	01 c8                	add    %ecx,%eax
  101130:	8b 55 08             	mov    0x8(%ebp),%edx
  101133:	66 89 10             	mov    %dx,(%eax)
        break;
  101136:	eb 01                	jmp    101139 <cga_putc+0xe1>
        break;
  101138:	90                   	nop
    }

    // What is the purpose of this?
    if (crt_pos >= CRT_SIZE) {
  101139:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101140:	66 3d cf 07          	cmp    $0x7cf,%ax
  101144:	76 59                	jbe    10119f <cga_putc+0x147>
        int i;
        memmove(crt_buf, crt_buf + CRT_COLS, (CRT_SIZE - CRT_COLS) * sizeof(uint16_t));
  101146:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  10114b:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
  101151:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101156:	83 ec 04             	sub    $0x4,%esp
  101159:	68 00 0f 00 00       	push   $0xf00
  10115e:	52                   	push   %edx
  10115f:	50                   	push   %eax
  101160:	e8 d7 1b 00 00       	call   102d3c <memmove>
  101165:	83 c4 10             	add    $0x10,%esp
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101168:	c7 45 f4 80 07 00 00 	movl   $0x780,-0xc(%ebp)
  10116f:	eb 15                	jmp    101186 <cga_putc+0x12e>
            crt_buf[i] = 0x0700 | ' ';
  101171:	a1 60 ee 10 00       	mov    0x10ee60,%eax
  101176:	8b 55 f4             	mov    -0xc(%ebp),%edx
  101179:	01 d2                	add    %edx,%edx
  10117b:	01 d0                	add    %edx,%eax
  10117d:	66 c7 00 20 07       	movw   $0x720,(%eax)
        for (i = CRT_SIZE - CRT_COLS; i < CRT_SIZE; i ++) {
  101182:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101186:	81 7d f4 cf 07 00 00 	cmpl   $0x7cf,-0xc(%ebp)
  10118d:	7e e2                	jle    101171 <cga_putc+0x119>
        }
        crt_pos -= CRT_COLS;
  10118f:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101196:	83 e8 50             	sub    $0x50,%eax
  101199:	66 a3 64 ee 10 00    	mov    %ax,0x10ee64
    }

    // move that little blinky thing
    outb(addr_6845, 14);
  10119f:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  1011a6:	0f b7 c0             	movzwl %ax,%eax
  1011a9:	66 89 45 f2          	mov    %ax,-0xe(%ebp)
  1011ad:	c6 45 e8 0e          	movb   $0xe,-0x18(%ebp)
  1011b1:	0f b6 45 e8          	movzbl -0x18(%ebp),%eax
  1011b5:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  1011b9:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos >> 8);
  1011ba:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  1011c1:	66 c1 e8 08          	shr    $0x8,%ax
  1011c5:	0f b6 c0             	movzbl %al,%eax
  1011c8:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  1011cf:	83 c2 01             	add    $0x1,%edx
  1011d2:	0f b7 d2             	movzwl %dx,%edx
  1011d5:	66 89 55 f0          	mov    %dx,-0x10(%ebp)
  1011d9:	88 45 e9             	mov    %al,-0x17(%ebp)
  1011dc:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  1011e0:	0f b7 55 f0          	movzwl -0x10(%ebp),%edx
  1011e4:	ee                   	out    %al,(%dx)
    outb(addr_6845, 15);
  1011e5:	0f b7 05 66 ee 10 00 	movzwl 0x10ee66,%eax
  1011ec:	0f b7 c0             	movzwl %ax,%eax
  1011ef:	66 89 45 ee          	mov    %ax,-0x12(%ebp)
  1011f3:	c6 45 ea 0f          	movb   $0xf,-0x16(%ebp)
  1011f7:	0f b6 45 ea          	movzbl -0x16(%ebp),%eax
  1011fb:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  1011ff:	ee                   	out    %al,(%dx)
    outb(addr_6845 + 1, crt_pos);
  101200:	0f b7 05 64 ee 10 00 	movzwl 0x10ee64,%eax
  101207:	0f b6 c0             	movzbl %al,%eax
  10120a:	0f b7 15 66 ee 10 00 	movzwl 0x10ee66,%edx
  101211:	83 c2 01             	add    $0x1,%edx
  101214:	0f b7 d2             	movzwl %dx,%edx
  101217:	66 89 55 ec          	mov    %dx,-0x14(%ebp)
  10121b:	88 45 eb             	mov    %al,-0x15(%ebp)
  10121e:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
  101222:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  101226:	ee                   	out    %al,(%dx)
}
  101227:	90                   	nop
  101228:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  10122b:	c9                   	leave  
  10122c:	c3                   	ret    

0010122d <serial_putc_sub>:

static void
serial_putc_sub(int c) {
  10122d:	55                   	push   %ebp
  10122e:	89 e5                	mov    %esp,%ebp
  101230:	83 ec 10             	sub    $0x10,%esp
    int i;
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101233:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  10123a:	eb 09                	jmp    101245 <serial_putc_sub+0x18>
        delay();
  10123c:	e8 51 fb ff ff       	call   100d92 <delay>
    for (i = 0; !(inb(COM1 + COM_LSR) & COM_LSR_TXRDY) && i < 12800; i ++) {
  101241:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  101245:	66 c7 45 f8 fd 03    	movw   $0x3fd,-0x8(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10124b:	0f b7 45 f8          	movzwl -0x8(%ebp),%eax
  10124f:	89 c2                	mov    %eax,%edx
  101251:	ec                   	in     (%dx),%al
  101252:	88 45 f7             	mov    %al,-0x9(%ebp)
    return data;
  101255:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  101259:	0f b6 c0             	movzbl %al,%eax
  10125c:	83 e0 20             	and    $0x20,%eax
  10125f:	85 c0                	test   %eax,%eax
  101261:	75 09                	jne    10126c <serial_putc_sub+0x3f>
  101263:	81 7d fc ff 31 00 00 	cmpl   $0x31ff,-0x4(%ebp)
  10126a:	7e d0                	jle    10123c <serial_putc_sub+0xf>
    }
    outb(COM1 + COM_TX, c);
  10126c:	8b 45 08             	mov    0x8(%ebp),%eax
  10126f:	0f b6 c0             	movzbl %al,%eax
  101272:	66 c7 45 fa f8 03    	movw   $0x3f8,-0x6(%ebp)
  101278:	88 45 f6             	mov    %al,-0xa(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  10127b:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
  10127f:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  101283:	ee                   	out    %al,(%dx)
}
  101284:	90                   	nop
  101285:	c9                   	leave  
  101286:	c3                   	ret    

00101287 <serial_putc>:

/* serial_putc - print character to serial port */
static void
serial_putc(int c) {
  101287:	55                   	push   %ebp
  101288:	89 e5                	mov    %esp,%ebp
    if (c != '\b') {
  10128a:	83 7d 08 08          	cmpl   $0x8,0x8(%ebp)
  10128e:	74 0d                	je     10129d <serial_putc+0x16>
        serial_putc_sub(c);
  101290:	ff 75 08             	pushl  0x8(%ebp)
  101293:	e8 95 ff ff ff       	call   10122d <serial_putc_sub>
  101298:	83 c4 04             	add    $0x4,%esp
    else {
        serial_putc_sub('\b');
        serial_putc_sub(' ');
        serial_putc_sub('\b');
    }
}
  10129b:	eb 1e                	jmp    1012bb <serial_putc+0x34>
        serial_putc_sub('\b');
  10129d:	6a 08                	push   $0x8
  10129f:	e8 89 ff ff ff       	call   10122d <serial_putc_sub>
  1012a4:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub(' ');
  1012a7:	6a 20                	push   $0x20
  1012a9:	e8 7f ff ff ff       	call   10122d <serial_putc_sub>
  1012ae:	83 c4 04             	add    $0x4,%esp
        serial_putc_sub('\b');
  1012b1:	6a 08                	push   $0x8
  1012b3:	e8 75 ff ff ff       	call   10122d <serial_putc_sub>
  1012b8:	83 c4 04             	add    $0x4,%esp
}
  1012bb:	90                   	nop
  1012bc:	c9                   	leave  
  1012bd:	c3                   	ret    

001012be <cons_intr>:
/* *
 * cons_intr - called by device interrupt routines to feed input
 * characters into the circular console input buffer.
 * */
static void
cons_intr(int (*proc)(void)) {
  1012be:	55                   	push   %ebp
  1012bf:	89 e5                	mov    %esp,%ebp
  1012c1:	83 ec 18             	sub    $0x18,%esp
    int c;
    while ((c = (*proc)()) != -1) {
  1012c4:	eb 33                	jmp    1012f9 <cons_intr+0x3b>
        if (c != 0) {
  1012c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  1012ca:	74 2d                	je     1012f9 <cons_intr+0x3b>
            cons.buf[cons.wpos ++] = c;
  1012cc:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1012d1:	8d 50 01             	lea    0x1(%eax),%edx
  1012d4:	89 15 84 f0 10 00    	mov    %edx,0x10f084
  1012da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1012dd:	88 90 80 ee 10 00    	mov    %dl,0x10ee80(%eax)
            if (cons.wpos == CONSBUFSIZE) {
  1012e3:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1012e8:	3d 00 02 00 00       	cmp    $0x200,%eax
  1012ed:	75 0a                	jne    1012f9 <cons_intr+0x3b>
                cons.wpos = 0;
  1012ef:	c7 05 84 f0 10 00 00 	movl   $0x0,0x10f084
  1012f6:	00 00 00 
    while ((c = (*proc)()) != -1) {
  1012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  1012fc:	ff d0                	call   *%eax
  1012fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  101301:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
  101305:	75 bf                	jne    1012c6 <cons_intr+0x8>
            }
        }
    }
}
  101307:	90                   	nop
  101308:	c9                   	leave  
  101309:	c3                   	ret    

0010130a <serial_proc_data>:

/* serial_proc_data - get data from serial port */
static int
serial_proc_data(void) {
  10130a:	55                   	push   %ebp
  10130b:	89 e5                	mov    %esp,%ebp
  10130d:	83 ec 10             	sub    $0x10,%esp
  101310:	66 c7 45 f8 fd 03    	movw   $0x3fd,-0x8(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  101316:	0f b7 45 f8          	movzwl -0x8(%ebp),%eax
  10131a:	89 c2                	mov    %eax,%edx
  10131c:	ec                   	in     (%dx),%al
  10131d:	88 45 f7             	mov    %al,-0x9(%ebp)
    return data;
  101320:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
    if (!(inb(COM1 + COM_LSR) & COM_LSR_DATA)) {
  101324:	0f b6 c0             	movzbl %al,%eax
  101327:	83 e0 01             	and    $0x1,%eax
  10132a:	85 c0                	test   %eax,%eax
  10132c:	75 07                	jne    101335 <serial_proc_data+0x2b>
        return -1;
  10132e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  101333:	eb 2a                	jmp    10135f <serial_proc_data+0x55>
  101335:	66 c7 45 fa f8 03    	movw   $0x3f8,-0x6(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10133b:	0f b7 45 fa          	movzwl -0x6(%ebp),%eax
  10133f:	89 c2                	mov    %eax,%edx
  101341:	ec                   	in     (%dx),%al
  101342:	88 45 f6             	mov    %al,-0xa(%ebp)
    return data;
  101345:	0f b6 45 f6          	movzbl -0xa(%ebp),%eax
    }
    int c = inb(COM1 + COM_RX);
  101349:	0f b6 c0             	movzbl %al,%eax
  10134c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    if (c == 127) {
  10134f:	83 7d fc 7f          	cmpl   $0x7f,-0x4(%ebp)
  101353:	75 07                	jne    10135c <serial_proc_data+0x52>
        c = '\b';
  101355:	c7 45 fc 08 00 00 00 	movl   $0x8,-0x4(%ebp)
    }
    return c;
  10135c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  10135f:	c9                   	leave  
  101360:	c3                   	ret    

00101361 <serial_intr>:

/* serial_intr - try to feed input characters from serial port */
void
serial_intr(void) {
  101361:	55                   	push   %ebp
  101362:	89 e5                	mov    %esp,%ebp
  101364:	83 ec 08             	sub    $0x8,%esp
    if (serial_exists) {
  101367:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10136c:	85 c0                	test   %eax,%eax
  10136e:	74 10                	je     101380 <serial_intr+0x1f>
        cons_intr(serial_proc_data);
  101370:	83 ec 0c             	sub    $0xc,%esp
  101373:	68 0a 13 10 00       	push   $0x10130a
  101378:	e8 41 ff ff ff       	call   1012be <cons_intr>
  10137d:	83 c4 10             	add    $0x10,%esp
    }
}
  101380:	90                   	nop
  101381:	c9                   	leave  
  101382:	c3                   	ret    

00101383 <kbd_proc_data>:
 *
 * The kbd_proc_data() function gets data from the keyboard.
 * If we finish a character, return it, else 0. And return -1 if no data.
 * */
static int
kbd_proc_data(void) {
  101383:	55                   	push   %ebp
  101384:	89 e5                	mov    %esp,%ebp
  101386:	83 ec 18             	sub    $0x18,%esp
  101389:	66 c7 45 ec 64 00    	movw   $0x64,-0x14(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  10138f:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101393:	89 c2                	mov    %eax,%edx
  101395:	ec                   	in     (%dx),%al
  101396:	88 45 eb             	mov    %al,-0x15(%ebp)
    return data;
  101399:	0f b6 45 eb          	movzbl -0x15(%ebp),%eax
    int c;
    uint8_t data;
    static uint32_t shift;

    if ((inb(KBSTATP) & KBS_DIB) == 0) {
  10139d:	0f b6 c0             	movzbl %al,%eax
  1013a0:	83 e0 01             	and    $0x1,%eax
  1013a3:	85 c0                	test   %eax,%eax
  1013a5:	75 0a                	jne    1013b1 <kbd_proc_data+0x2e>
        return -1;
  1013a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
  1013ac:	e9 5d 01 00 00       	jmp    10150e <kbd_proc_data+0x18b>
  1013b1:	66 c7 45 f0 60 00    	movw   $0x60,-0x10(%ebp)
    asm volatile ("inb %1, %0" : "=a" (data) : "d" (port));
  1013b7:	0f b7 45 f0          	movzwl -0x10(%ebp),%eax
  1013bb:	89 c2                	mov    %eax,%edx
  1013bd:	ec                   	in     (%dx),%al
  1013be:	88 45 ea             	mov    %al,-0x16(%ebp)
    return data;
  1013c1:	0f b6 45 ea          	movzbl -0x16(%ebp),%eax
    }

    data = inb(KBDATAP);
  1013c5:	88 45 f3             	mov    %al,-0xd(%ebp)

    if (data == 0xE0) {
  1013c8:	80 7d f3 e0          	cmpb   $0xe0,-0xd(%ebp)
  1013cc:	75 17                	jne    1013e5 <kbd_proc_data+0x62>
        // E0 escape character
        shift |= E0ESC;
  1013ce:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013d3:	83 c8 40             	or     $0x40,%eax
  1013d6:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  1013db:	b8 00 00 00 00       	mov    $0x0,%eax
  1013e0:	e9 29 01 00 00       	jmp    10150e <kbd_proc_data+0x18b>
    } else if (data & 0x80) {
  1013e5:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013e9:	84 c0                	test   %al,%al
  1013eb:	79 47                	jns    101434 <kbd_proc_data+0xb1>
        // Key released
        data = (shift & E0ESC ? data : data & 0x7F);
  1013ed:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1013f2:	83 e0 40             	and    $0x40,%eax
  1013f5:	85 c0                	test   %eax,%eax
  1013f7:	75 09                	jne    101402 <kbd_proc_data+0x7f>
  1013f9:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  1013fd:	83 e0 7f             	and    $0x7f,%eax
  101400:	eb 04                	jmp    101406 <kbd_proc_data+0x83>
  101402:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101406:	88 45 f3             	mov    %al,-0xd(%ebp)
        shift &= ~(shiftcode[data] | E0ESC);
  101409:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10140d:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  101414:	83 c8 40             	or     $0x40,%eax
  101417:	0f b6 c0             	movzbl %al,%eax
  10141a:	f7 d0                	not    %eax
  10141c:	89 c2                	mov    %eax,%edx
  10141e:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101423:	21 d0                	and    %edx,%eax
  101425:	a3 88 f0 10 00       	mov    %eax,0x10f088
        return 0;
  10142a:	b8 00 00 00 00       	mov    $0x0,%eax
  10142f:	e9 da 00 00 00       	jmp    10150e <kbd_proc_data+0x18b>
    } else if (shift & E0ESC) {
  101434:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101439:	83 e0 40             	and    $0x40,%eax
  10143c:	85 c0                	test   %eax,%eax
  10143e:	74 11                	je     101451 <kbd_proc_data+0xce>
        // Last character was an E0 escape; or with 0x80
        data |= 0x80;
  101440:	80 4d f3 80          	orb    $0x80,-0xd(%ebp)
        shift &= ~E0ESC;
  101444:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101449:	83 e0 bf             	and    $0xffffffbf,%eax
  10144c:	a3 88 f0 10 00       	mov    %eax,0x10f088
    }

    shift |= shiftcode[data];
  101451:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101455:	0f b6 80 40 e0 10 00 	movzbl 0x10e040(%eax),%eax
  10145c:	0f b6 d0             	movzbl %al,%edx
  10145f:	a1 88 f0 10 00       	mov    0x10f088,%eax
  101464:	09 d0                	or     %edx,%eax
  101466:	a3 88 f0 10 00       	mov    %eax,0x10f088
    shift ^= togglecode[data];
  10146b:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  10146f:	0f b6 80 40 e1 10 00 	movzbl 0x10e140(%eax),%eax
  101476:	0f b6 d0             	movzbl %al,%edx
  101479:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10147e:	31 d0                	xor    %edx,%eax
  101480:	a3 88 f0 10 00       	mov    %eax,0x10f088

    c = charcode[shift & (CTL | SHIFT)][data];
  101485:	a1 88 f0 10 00       	mov    0x10f088,%eax
  10148a:	83 e0 03             	and    $0x3,%eax
  10148d:	8b 14 85 40 e5 10 00 	mov    0x10e540(,%eax,4),%edx
  101494:	0f b6 45 f3          	movzbl -0xd(%ebp),%eax
  101498:	01 d0                	add    %edx,%eax
  10149a:	0f b6 00             	movzbl (%eax),%eax
  10149d:	0f b6 c0             	movzbl %al,%eax
  1014a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if (shift & CAPSLOCK) {
  1014a3:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014a8:	83 e0 08             	and    $0x8,%eax
  1014ab:	85 c0                	test   %eax,%eax
  1014ad:	74 22                	je     1014d1 <kbd_proc_data+0x14e>
        if ('a' <= c && c <= 'z')
  1014af:	83 7d f4 60          	cmpl   $0x60,-0xc(%ebp)
  1014b3:	7e 0c                	jle    1014c1 <kbd_proc_data+0x13e>
  1014b5:	83 7d f4 7a          	cmpl   $0x7a,-0xc(%ebp)
  1014b9:	7f 06                	jg     1014c1 <kbd_proc_data+0x13e>
            c += 'A' - 'a';
  1014bb:	83 6d f4 20          	subl   $0x20,-0xc(%ebp)
  1014bf:	eb 10                	jmp    1014d1 <kbd_proc_data+0x14e>
        else if ('A' <= c && c <= 'Z')
  1014c1:	83 7d f4 40          	cmpl   $0x40,-0xc(%ebp)
  1014c5:	7e 0a                	jle    1014d1 <kbd_proc_data+0x14e>
  1014c7:	83 7d f4 5a          	cmpl   $0x5a,-0xc(%ebp)
  1014cb:	7f 04                	jg     1014d1 <kbd_proc_data+0x14e>
            c += 'a' - 'A';
  1014cd:	83 45 f4 20          	addl   $0x20,-0xc(%ebp)
    }

    // Process special keys
    // Ctrl-Alt-Del: reboot
    if (!(~shift & (CTL | ALT)) && c == KEY_DEL) {
  1014d1:	a1 88 f0 10 00       	mov    0x10f088,%eax
  1014d6:	f7 d0                	not    %eax
  1014d8:	83 e0 06             	and    $0x6,%eax
  1014db:	85 c0                	test   %eax,%eax
  1014dd:	75 2c                	jne    10150b <kbd_proc_data+0x188>
  1014df:	81 7d f4 e9 00 00 00 	cmpl   $0xe9,-0xc(%ebp)
  1014e6:	75 23                	jne    10150b <kbd_proc_data+0x188>
        cprintf("Rebooting!\n");
  1014e8:	83 ec 0c             	sub    $0xc,%esp
  1014eb:	68 dd 37 10 00       	push   $0x1037dd
  1014f0:	e8 58 ed ff ff       	call   10024d <cprintf>
  1014f5:	83 c4 10             	add    $0x10,%esp
  1014f8:	66 c7 45 ee 92 00    	movw   $0x92,-0x12(%ebp)
  1014fe:	c6 45 e9 03          	movb   $0x3,-0x17(%ebp)
    asm volatile ("outb %0, %1" :: "a" (data), "d" (port));
  101502:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
  101506:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  10150a:	ee                   	out    %al,(%dx)
        outb(0x92, 0x3); // courtesy of Chris Frost
    }
    return c;
  10150b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  10150e:	c9                   	leave  
  10150f:	c3                   	ret    

00101510 <kbd_intr>:

/* kbd_intr - try to feed input characters from keyboard */
static void
kbd_intr(void) {
  101510:	55                   	push   %ebp
  101511:	89 e5                	mov    %esp,%ebp
  101513:	83 ec 08             	sub    $0x8,%esp
    cons_intr(kbd_proc_data);
  101516:	83 ec 0c             	sub    $0xc,%esp
  101519:	68 83 13 10 00       	push   $0x101383
  10151e:	e8 9b fd ff ff       	call   1012be <cons_intr>
  101523:	83 c4 10             	add    $0x10,%esp
}
  101526:	90                   	nop
  101527:	c9                   	leave  
  101528:	c3                   	ret    

00101529 <kbd_init>:

static void
kbd_init(void) {
  101529:	55                   	push   %ebp
  10152a:	89 e5                	mov    %esp,%ebp
  10152c:	83 ec 08             	sub    $0x8,%esp
    // drain the kbd buffer
    kbd_intr();
  10152f:	e8 dc ff ff ff       	call   101510 <kbd_intr>
    pic_enable(IRQ_KBD);
  101534:	83 ec 0c             	sub    $0xc,%esp
  101537:	6a 01                	push   $0x1
  101539:	e8 1c 01 00 00       	call   10165a <pic_enable>
  10153e:	83 c4 10             	add    $0x10,%esp
}
  101541:	90                   	nop
  101542:	c9                   	leave  
  101543:	c3                   	ret    

00101544 <cons_init>:

/* cons_init - initializes the console devices */
void
cons_init(void) {
  101544:	55                   	push   %ebp
  101545:	89 e5                	mov    %esp,%ebp
  101547:	83 ec 08             	sub    $0x8,%esp
    cga_init();
  10154a:	e8 8c f8 ff ff       	call   100ddb <cga_init>
    serial_init();
  10154f:	e8 6e f9 ff ff       	call   100ec2 <serial_init>
    kbd_init();
  101554:	e8 d0 ff ff ff       	call   101529 <kbd_init>
    if (!serial_exists) {
  101559:	a1 68 ee 10 00       	mov    0x10ee68,%eax
  10155e:	85 c0                	test   %eax,%eax
  101560:	75 10                	jne    101572 <cons_init+0x2e>
        cprintf("serial port does not exist!!\n");
  101562:	83 ec 0c             	sub    $0xc,%esp
  101565:	68 e9 37 10 00       	push   $0x1037e9
  10156a:	e8 de ec ff ff       	call   10024d <cprintf>
  10156f:	83 c4 10             	add    $0x10,%esp
    }
}
  101572:	90                   	nop
  101573:	c9                   	leave  
  101574:	c3                   	ret    

00101575 <cons_putc>:

/* cons_putc - print a single character @c to console devices */
void
cons_putc(int c) {
  101575:	55                   	push   %ebp
  101576:	89 e5                	mov    %esp,%ebp
  101578:	83 ec 08             	sub    $0x8,%esp
    lpt_putc(c);
  10157b:	ff 75 08             	pushl  0x8(%ebp)
  10157e:	e8 9e fa ff ff       	call   101021 <lpt_putc>
  101583:	83 c4 04             	add    $0x4,%esp
    cga_putc(c);
  101586:	83 ec 0c             	sub    $0xc,%esp
  101589:	ff 75 08             	pushl  0x8(%ebp)
  10158c:	e8 c7 fa ff ff       	call   101058 <cga_putc>
  101591:	83 c4 10             	add    $0x10,%esp
    serial_putc(c);
  101594:	83 ec 0c             	sub    $0xc,%esp
  101597:	ff 75 08             	pushl  0x8(%ebp)
  10159a:	e8 e8 fc ff ff       	call   101287 <serial_putc>
  10159f:	83 c4 10             	add    $0x10,%esp
}
  1015a2:	90                   	nop
  1015a3:	c9                   	leave  
  1015a4:	c3                   	ret    

001015a5 <cons_getc>:
/* *
 * cons_getc - return the next input character from console,
 * or 0 if none waiting.
 * */
int
cons_getc(void) {
  1015a5:	55                   	push   %ebp
  1015a6:	89 e5                	mov    %esp,%ebp
  1015a8:	83 ec 18             	sub    $0x18,%esp
    int c;

    // poll for any pending input characters,
    // so that this function works even when interrupts are disabled
    // (e.g., when called from the kernel monitor).
    serial_intr();
  1015ab:	e8 b1 fd ff ff       	call   101361 <serial_intr>
    kbd_intr();
  1015b0:	e8 5b ff ff ff       	call   101510 <kbd_intr>

    // grab the next character from the input buffer.
    if (cons.rpos != cons.wpos) {
  1015b5:	8b 15 80 f0 10 00    	mov    0x10f080,%edx
  1015bb:	a1 84 f0 10 00       	mov    0x10f084,%eax
  1015c0:	39 c2                	cmp    %eax,%edx
  1015c2:	74 36                	je     1015fa <cons_getc+0x55>
        c = cons.buf[cons.rpos ++];
  1015c4:	a1 80 f0 10 00       	mov    0x10f080,%eax
  1015c9:	8d 50 01             	lea    0x1(%eax),%edx
  1015cc:	89 15 80 f0 10 00    	mov    %edx,0x10f080
  1015d2:	0f b6 80 80 ee 10 00 	movzbl 0x10ee80(%eax),%eax
  1015d9:	0f b6 c0             	movzbl %al,%eax
  1015dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
        if (cons.rpos == CONSBUFSIZE) {
  1015df:	a1 80 f0 10 00       	mov    0x10f080,%eax
  1015e4:	3d 00 02 00 00       	cmp    $0x200,%eax
  1015e9:	75 0a                	jne    1015f5 <cons_getc+0x50>
            cons.rpos = 0;
  1015eb:	c7 05 80 f0 10 00 00 	movl   $0x0,0x10f080
  1015f2:	00 00 00 
        }
        return c;
  1015f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1015f8:	eb 05                	jmp    1015ff <cons_getc+0x5a>
    }
    return 0;
  1015fa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  1015ff:	c9                   	leave  
  101600:	c3                   	ret    

00101601 <pic_setmask>:
// Initial IRQ mask has interrupt 2 enabled (for slave 8259A).
static uint16_t irq_mask = 0xFFFF & ~(1 << IRQ_SLAVE);
static bool did_init = 0;

static void
pic_setmask(uint16_t mask) {
  101601:	55                   	push   %ebp
  101602:	89 e5                	mov    %esp,%ebp
  101604:	83 ec 14             	sub    $0x14,%esp
  101607:	8b 45 08             	mov    0x8(%ebp),%eax
  10160a:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
    irq_mask = mask;
  10160e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101612:	66 a3 50 e5 10 00    	mov    %ax,0x10e550
    if (did_init) {
  101618:	a1 8c f0 10 00       	mov    0x10f08c,%eax
  10161d:	85 c0                	test   %eax,%eax
  10161f:	74 36                	je     101657 <pic_setmask+0x56>
        outb(IO_PIC1 + 1, mask);
  101621:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  101625:	0f b6 c0             	movzbl %al,%eax
  101628:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10162e:	88 45 fa             	mov    %al,-0x6(%ebp)
  101631:	0f b6 45 fa          	movzbl -0x6(%ebp),%eax
  101635:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  101639:	ee                   	out    %al,(%dx)
        outb(IO_PIC2 + 1, mask >> 8);
  10163a:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
  10163e:	66 c1 e8 08          	shr    $0x8,%ax
  101642:	0f b6 c0             	movzbl %al,%eax
  101645:	66 c7 45 fc a1 00    	movw   $0xa1,-0x4(%ebp)
  10164b:	88 45 fb             	mov    %al,-0x5(%ebp)
  10164e:	0f b6 45 fb          	movzbl -0x5(%ebp),%eax
  101652:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  101656:	ee                   	out    %al,(%dx)
    }
}
  101657:	90                   	nop
  101658:	c9                   	leave  
  101659:	c3                   	ret    

0010165a <pic_enable>:

void
pic_enable(unsigned int irq) {
  10165a:	55                   	push   %ebp
  10165b:	89 e5                	mov    %esp,%ebp
    pic_setmask(irq_mask & ~(1 << irq));
  10165d:	8b 45 08             	mov    0x8(%ebp),%eax
  101660:	ba 01 00 00 00       	mov    $0x1,%edx
  101665:	89 c1                	mov    %eax,%ecx
  101667:	d3 e2                	shl    %cl,%edx
  101669:	89 d0                	mov    %edx,%eax
  10166b:	f7 d0                	not    %eax
  10166d:	89 c2                	mov    %eax,%edx
  10166f:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  101676:	21 d0                	and    %edx,%eax
  101678:	0f b7 c0             	movzwl %ax,%eax
  10167b:	50                   	push   %eax
  10167c:	e8 80 ff ff ff       	call   101601 <pic_setmask>
  101681:	83 c4 04             	add    $0x4,%esp
}
  101684:	90                   	nop
  101685:	c9                   	leave  
  101686:	c3                   	ret    

00101687 <pic_init>:

/* pic_init - initialize the 8259A interrupt controllers */
void
pic_init(void) {
  101687:	55                   	push   %ebp
  101688:	89 e5                	mov    %esp,%ebp
  10168a:	83 ec 30             	sub    $0x30,%esp
    did_init = 1;
  10168d:	c7 05 8c f0 10 00 01 	movl   $0x1,0x10f08c
  101694:	00 00 00 
  101697:	66 c7 45 fe 21 00    	movw   $0x21,-0x2(%ebp)
  10169d:	c6 45 d6 ff          	movb   $0xff,-0x2a(%ebp)
  1016a1:	0f b6 45 d6          	movzbl -0x2a(%ebp),%eax
  1016a5:	0f b7 55 fe          	movzwl -0x2(%ebp),%edx
  1016a9:	ee                   	out    %al,(%dx)
  1016aa:	66 c7 45 fc a1 00    	movw   $0xa1,-0x4(%ebp)
  1016b0:	c6 45 d7 ff          	movb   $0xff,-0x29(%ebp)
  1016b4:	0f b6 45 d7          	movzbl -0x29(%ebp),%eax
  1016b8:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
  1016bc:	ee                   	out    %al,(%dx)
  1016bd:	66 c7 45 fa 20 00    	movw   $0x20,-0x6(%ebp)
  1016c3:	c6 45 d8 11          	movb   $0x11,-0x28(%ebp)
  1016c7:	0f b6 45 d8          	movzbl -0x28(%ebp),%eax
  1016cb:	0f b7 55 fa          	movzwl -0x6(%ebp),%edx
  1016cf:	ee                   	out    %al,(%dx)
  1016d0:	66 c7 45 f8 21 00    	movw   $0x21,-0x8(%ebp)
  1016d6:	c6 45 d9 20          	movb   $0x20,-0x27(%ebp)
  1016da:	0f b6 45 d9          	movzbl -0x27(%ebp),%eax
  1016de:	0f b7 55 f8          	movzwl -0x8(%ebp),%edx
  1016e2:	ee                   	out    %al,(%dx)
  1016e3:	66 c7 45 f6 21 00    	movw   $0x21,-0xa(%ebp)
  1016e9:	c6 45 da 04          	movb   $0x4,-0x26(%ebp)
  1016ed:	0f b6 45 da          	movzbl -0x26(%ebp),%eax
  1016f1:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
  1016f5:	ee                   	out    %al,(%dx)
  1016f6:	66 c7 45 f4 21 00    	movw   $0x21,-0xc(%ebp)
  1016fc:	c6 45 db 03          	movb   $0x3,-0x25(%ebp)
  101700:	0f b6 45 db          	movzbl -0x25(%ebp),%eax
  101704:	0f b7 55 f4          	movzwl -0xc(%ebp),%edx
  101708:	ee                   	out    %al,(%dx)
  101709:	66 c7 45 f2 a0 00    	movw   $0xa0,-0xe(%ebp)
  10170f:	c6 45 dc 11          	movb   $0x11,-0x24(%ebp)
  101713:	0f b6 45 dc          	movzbl -0x24(%ebp),%eax
  101717:	0f b7 55 f2          	movzwl -0xe(%ebp),%edx
  10171b:	ee                   	out    %al,(%dx)
  10171c:	66 c7 45 f0 a1 00    	movw   $0xa1,-0x10(%ebp)
  101722:	c6 45 dd 28          	movb   $0x28,-0x23(%ebp)
  101726:	0f b6 45 dd          	movzbl -0x23(%ebp),%eax
  10172a:	0f b7 55 f0          	movzwl -0x10(%ebp),%edx
  10172e:	ee                   	out    %al,(%dx)
  10172f:	66 c7 45 ee a1 00    	movw   $0xa1,-0x12(%ebp)
  101735:	c6 45 de 02          	movb   $0x2,-0x22(%ebp)
  101739:	0f b6 45 de          	movzbl -0x22(%ebp),%eax
  10173d:	0f b7 55 ee          	movzwl -0x12(%ebp),%edx
  101741:	ee                   	out    %al,(%dx)
  101742:	66 c7 45 ec a1 00    	movw   $0xa1,-0x14(%ebp)
  101748:	c6 45 df 03          	movb   $0x3,-0x21(%ebp)
  10174c:	0f b6 45 df          	movzbl -0x21(%ebp),%eax
  101750:	0f b7 55 ec          	movzwl -0x14(%ebp),%edx
  101754:	ee                   	out    %al,(%dx)
  101755:	66 c7 45 ea 20 00    	movw   $0x20,-0x16(%ebp)
  10175b:	c6 45 e0 68          	movb   $0x68,-0x20(%ebp)
  10175f:	0f b6 45 e0          	movzbl -0x20(%ebp),%eax
  101763:	0f b7 55 ea          	movzwl -0x16(%ebp),%edx
  101767:	ee                   	out    %al,(%dx)
  101768:	66 c7 45 e8 20 00    	movw   $0x20,-0x18(%ebp)
  10176e:	c6 45 e1 0a          	movb   $0xa,-0x1f(%ebp)
  101772:	0f b6 45 e1          	movzbl -0x1f(%ebp),%eax
  101776:	0f b7 55 e8          	movzwl -0x18(%ebp),%edx
  10177a:	ee                   	out    %al,(%dx)
  10177b:	66 c7 45 e6 a0 00    	movw   $0xa0,-0x1a(%ebp)
  101781:	c6 45 e2 68          	movb   $0x68,-0x1e(%ebp)
  101785:	0f b6 45 e2          	movzbl -0x1e(%ebp),%eax
  101789:	0f b7 55 e6          	movzwl -0x1a(%ebp),%edx
  10178d:	ee                   	out    %al,(%dx)
  10178e:	66 c7 45 e4 a0 00    	movw   $0xa0,-0x1c(%ebp)
  101794:	c6 45 e3 0a          	movb   $0xa,-0x1d(%ebp)
  101798:	0f b6 45 e3          	movzbl -0x1d(%ebp),%eax
  10179c:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
  1017a0:	ee                   	out    %al,(%dx)
    outb(IO_PIC1, 0x0a);    // read IRR by default

    outb(IO_PIC2, 0x68);    // OCW3
    outb(IO_PIC2, 0x0a);    // OCW3

    if (irq_mask != 0xFFFF) {
  1017a1:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017a8:	66 83 f8 ff          	cmp    $0xffff,%ax
  1017ac:	74 13                	je     1017c1 <pic_init+0x13a>
        pic_setmask(irq_mask);
  1017ae:	0f b7 05 50 e5 10 00 	movzwl 0x10e550,%eax
  1017b5:	0f b7 c0             	movzwl %ax,%eax
  1017b8:	50                   	push   %eax
  1017b9:	e8 43 fe ff ff       	call   101601 <pic_setmask>
  1017be:	83 c4 04             	add    $0x4,%esp
    }
}
  1017c1:	90                   	nop
  1017c2:	c9                   	leave  
  1017c3:	c3                   	ret    

001017c4 <intr_enable>:
#include <x86.h>
#include <intr.h>

/* intr_enable - enable irq interrupt */
void
intr_enable(void) {
  1017c4:	55                   	push   %ebp
  1017c5:	89 e5                	mov    %esp,%ebp
    asm volatile ("lidt (%0)" :: "r" (pd));
}

static inline void
sti(void) {
    asm volatile ("sti");
  1017c7:	fb                   	sti    
    sti();
}
  1017c8:	90                   	nop
  1017c9:	5d                   	pop    %ebp
  1017ca:	c3                   	ret    

001017cb <intr_disable>:

/* intr_disable - disable irq interrupt */
void
intr_disable(void) {
  1017cb:	55                   	push   %ebp
  1017cc:	89 e5                	mov    %esp,%ebp
}

static inline void
cli(void) {
    asm volatile ("cli");
  1017ce:	fa                   	cli    
    cli();
}
  1017cf:	90                   	nop
  1017d0:	5d                   	pop    %ebp
  1017d1:	c3                   	ret    

001017d2 <print_ticks>:
#include <console.h>
#include <kdebug.h>

#define TICK_NUM 100

static void print_ticks() {
  1017d2:	55                   	push   %ebp
  1017d3:	89 e5                	mov    %esp,%ebp
  1017d5:	83 ec 08             	sub    $0x8,%esp
    cprintf("%d ticks\n",TICK_NUM);
  1017d8:	83 ec 08             	sub    $0x8,%esp
  1017db:	6a 64                	push   $0x64
  1017dd:	68 20 38 10 00       	push   $0x103820
  1017e2:	e8 66 ea ff ff       	call   10024d <cprintf>
  1017e7:	83 c4 10             	add    $0x10,%esp
#ifdef DEBUG_GRADE
    cprintf("End of Test.\n");
    panic("EOT: kernel seems ok.");
#endif
}
  1017ea:	90                   	nop
  1017eb:	c9                   	leave  
  1017ec:	c3                   	ret    

001017ed <idt_init>:
    sizeof(idt) - 1, (uintptr_t)idt
};

/* idt_init - initialize IDT to each of the entry points in kern/trap/vectors.S */
void
idt_init(void) {
  1017ed:	55                   	push   %ebp
  1017ee:	89 e5                	mov    %esp,%ebp
  1017f0:	83 ec 10             	sub    $0x10,%esp
     *     You don't know the meaning of this instruction? just google it! and check the libs/x86.h to know more.
     *     Notice: the argument of lidt is idt_pd. try to find it!
     */
    extern uintptr_t __vectors[];
    int i;
    for (i = 0; i < 256; ++i)
  1017f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  1017fa:	e9 c3 00 00 00       	jmp    1018c2 <idt_init+0xd5>
        SETGATE(idt[i], 0, KERNEL_CS, __vectors[i], DPL_KERNEL);
  1017ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101802:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  101809:	89 c2                	mov    %eax,%edx
  10180b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10180e:	66 89 14 c5 a0 f0 10 	mov    %dx,0x10f0a0(,%eax,8)
  101815:	00 
  101816:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101819:	66 c7 04 c5 a2 f0 10 	movw   $0x8,0x10f0a2(,%eax,8)
  101820:	00 08 00 
  101823:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101826:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  10182d:	00 
  10182e:	83 e2 e0             	and    $0xffffffe0,%edx
  101831:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  101838:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10183b:	0f b6 14 c5 a4 f0 10 	movzbl 0x10f0a4(,%eax,8),%edx
  101842:	00 
  101843:	83 e2 1f             	and    $0x1f,%edx
  101846:	88 14 c5 a4 f0 10 00 	mov    %dl,0x10f0a4(,%eax,8)
  10184d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101850:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101857:	00 
  101858:	83 e2 f0             	and    $0xfffffff0,%edx
  10185b:	83 ca 0e             	or     $0xe,%edx
  10185e:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  101865:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101868:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  10186f:	00 
  101870:	83 e2 ef             	and    $0xffffffef,%edx
  101873:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  10187a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  10187d:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101884:	00 
  101885:	83 e2 9f             	and    $0xffffff9f,%edx
  101888:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  10188f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  101892:	0f b6 14 c5 a5 f0 10 	movzbl 0x10f0a5(,%eax,8),%edx
  101899:	00 
  10189a:	83 ca 80             	or     $0xffffff80,%edx
  10189d:	88 14 c5 a5 f0 10 00 	mov    %dl,0x10f0a5(,%eax,8)
  1018a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018a7:	8b 04 85 e0 e5 10 00 	mov    0x10e5e0(,%eax,4),%eax
  1018ae:	c1 e8 10             	shr    $0x10,%eax
  1018b1:	89 c2                	mov    %eax,%edx
  1018b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  1018b6:	66 89 14 c5 a6 f0 10 	mov    %dx,0x10f0a6(,%eax,8)
  1018bd:	00 
    for (i = 0; i < 256; ++i)
  1018be:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  1018c2:	81 7d fc ff 00 00 00 	cmpl   $0xff,-0x4(%ebp)
  1018c9:	0f 8e 30 ff ff ff    	jle    1017ff <idt_init+0x12>
    SETGATE(idt[T_SYSCALL], 1, KERNEL_CS, __vectors[T_SYSCALL], DPL_USER);
  1018cf:	a1 e0 e7 10 00       	mov    0x10e7e0,%eax
  1018d4:	66 a3 a0 f4 10 00    	mov    %ax,0x10f4a0
  1018da:	66 c7 05 a2 f4 10 00 	movw   $0x8,0x10f4a2
  1018e1:	08 00 
  1018e3:	0f b6 05 a4 f4 10 00 	movzbl 0x10f4a4,%eax
  1018ea:	83 e0 e0             	and    $0xffffffe0,%eax
  1018ed:	a2 a4 f4 10 00       	mov    %al,0x10f4a4
  1018f2:	0f b6 05 a4 f4 10 00 	movzbl 0x10f4a4,%eax
  1018f9:	83 e0 1f             	and    $0x1f,%eax
  1018fc:	a2 a4 f4 10 00       	mov    %al,0x10f4a4
  101901:	0f b6 05 a5 f4 10 00 	movzbl 0x10f4a5,%eax
  101908:	83 c8 0f             	or     $0xf,%eax
  10190b:	a2 a5 f4 10 00       	mov    %al,0x10f4a5
  101910:	0f b6 05 a5 f4 10 00 	movzbl 0x10f4a5,%eax
  101917:	83 e0 ef             	and    $0xffffffef,%eax
  10191a:	a2 a5 f4 10 00       	mov    %al,0x10f4a5
  10191f:	0f b6 05 a5 f4 10 00 	movzbl 0x10f4a5,%eax
  101926:	83 c8 60             	or     $0x60,%eax
  101929:	a2 a5 f4 10 00       	mov    %al,0x10f4a5
  10192e:	0f b6 05 a5 f4 10 00 	movzbl 0x10f4a5,%eax
  101935:	83 c8 80             	or     $0xffffff80,%eax
  101938:	a2 a5 f4 10 00       	mov    %al,0x10f4a5
  10193d:	a1 e0 e7 10 00       	mov    0x10e7e0,%eax
  101942:	c1 e8 10             	shr    $0x10,%eax
  101945:	66 a3 a6 f4 10 00    	mov    %ax,0x10f4a6
  10194b:	c7 45 f8 60 e5 10 00 	movl   $0x10e560,-0x8(%ebp)
    asm volatile ("lidt (%0)" :: "r" (pd));
  101952:	8b 45 f8             	mov    -0x8(%ebp),%eax
  101955:	0f 01 18             	lidtl  (%eax)
    lidt(&idt_pd);
}
  101958:	90                   	nop
  101959:	c9                   	leave  
  10195a:	c3                   	ret    

0010195b <trapname>:

static const char *
trapname(int trapno) {
  10195b:	55                   	push   %ebp
  10195c:	89 e5                	mov    %esp,%ebp
        "Alignment Check",
        "Machine-Check",
        "SIMD Floating-Point Exception"
    };

    if (trapno < sizeof(excnames)/sizeof(const char * const)) {
  10195e:	8b 45 08             	mov    0x8(%ebp),%eax
  101961:	83 f8 13             	cmp    $0x13,%eax
  101964:	77 0c                	ja     101972 <trapname+0x17>
        return excnames[trapno];
  101966:	8b 45 08             	mov    0x8(%ebp),%eax
  101969:	8b 04 85 80 3b 10 00 	mov    0x103b80(,%eax,4),%eax
  101970:	eb 18                	jmp    10198a <trapname+0x2f>
    }
    if (trapno >= IRQ_OFFSET && trapno < IRQ_OFFSET + 16) {
  101972:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
  101976:	7e 0d                	jle    101985 <trapname+0x2a>
  101978:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
  10197c:	7f 07                	jg     101985 <trapname+0x2a>
        return "Hardware Interrupt";
  10197e:	b8 2a 38 10 00       	mov    $0x10382a,%eax
  101983:	eb 05                	jmp    10198a <trapname+0x2f>
    }
    return "(unknown trap)";
  101985:	b8 3d 38 10 00       	mov    $0x10383d,%eax
}
  10198a:	5d                   	pop    %ebp
  10198b:	c3                   	ret    

0010198c <trap_in_kernel>:

/* trap_in_kernel - test if trap happened in kernel */
bool
trap_in_kernel(struct trapframe *tf) {
  10198c:	55                   	push   %ebp
  10198d:	89 e5                	mov    %esp,%ebp
    return (tf->tf_cs == (uint16_t)KERNEL_CS);
  10198f:	8b 45 08             	mov    0x8(%ebp),%eax
  101992:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101996:	66 83 f8 08          	cmp    $0x8,%ax
  10199a:	0f 94 c0             	sete   %al
  10199d:	0f b6 c0             	movzbl %al,%eax
}
  1019a0:	5d                   	pop    %ebp
  1019a1:	c3                   	ret    

001019a2 <print_trapframe>:
    "TF", "IF", "DF", "OF", NULL, NULL, "NT", NULL,
    "RF", "VM", "AC", "VIF", "VIP", "ID", NULL, NULL,
};

void
print_trapframe(struct trapframe *tf) {
  1019a2:	55                   	push   %ebp
  1019a3:	89 e5                	mov    %esp,%ebp
  1019a5:	83 ec 18             	sub    $0x18,%esp
    cprintf("trapframe at %p\n", tf);
  1019a8:	83 ec 08             	sub    $0x8,%esp
  1019ab:	ff 75 08             	pushl  0x8(%ebp)
  1019ae:	68 7e 38 10 00       	push   $0x10387e
  1019b3:	e8 95 e8 ff ff       	call   10024d <cprintf>
  1019b8:	83 c4 10             	add    $0x10,%esp
    print_regs(&tf->tf_regs);
  1019bb:	8b 45 08             	mov    0x8(%ebp),%eax
  1019be:	83 ec 0c             	sub    $0xc,%esp
  1019c1:	50                   	push   %eax
  1019c2:	e8 b8 01 00 00       	call   101b7f <print_regs>
  1019c7:	83 c4 10             	add    $0x10,%esp
    cprintf("  ds   0x----%04x\n", tf->tf_ds);
  1019ca:	8b 45 08             	mov    0x8(%ebp),%eax
  1019cd:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
  1019d1:	0f b7 c0             	movzwl %ax,%eax
  1019d4:	83 ec 08             	sub    $0x8,%esp
  1019d7:	50                   	push   %eax
  1019d8:	68 8f 38 10 00       	push   $0x10388f
  1019dd:	e8 6b e8 ff ff       	call   10024d <cprintf>
  1019e2:	83 c4 10             	add    $0x10,%esp
    cprintf("  es   0x----%04x\n", tf->tf_es);
  1019e5:	8b 45 08             	mov    0x8(%ebp),%eax
  1019e8:	0f b7 40 28          	movzwl 0x28(%eax),%eax
  1019ec:	0f b7 c0             	movzwl %ax,%eax
  1019ef:	83 ec 08             	sub    $0x8,%esp
  1019f2:	50                   	push   %eax
  1019f3:	68 a2 38 10 00       	push   $0x1038a2
  1019f8:	e8 50 e8 ff ff       	call   10024d <cprintf>
  1019fd:	83 c4 10             	add    $0x10,%esp
    cprintf("  fs   0x----%04x\n", tf->tf_fs);
  101a00:	8b 45 08             	mov    0x8(%ebp),%eax
  101a03:	0f b7 40 24          	movzwl 0x24(%eax),%eax
  101a07:	0f b7 c0             	movzwl %ax,%eax
  101a0a:	83 ec 08             	sub    $0x8,%esp
  101a0d:	50                   	push   %eax
  101a0e:	68 b5 38 10 00       	push   $0x1038b5
  101a13:	e8 35 e8 ff ff       	call   10024d <cprintf>
  101a18:	83 c4 10             	add    $0x10,%esp
    cprintf("  gs   0x----%04x\n", tf->tf_gs);
  101a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  101a1e:	0f b7 40 20          	movzwl 0x20(%eax),%eax
  101a22:	0f b7 c0             	movzwl %ax,%eax
  101a25:	83 ec 08             	sub    $0x8,%esp
  101a28:	50                   	push   %eax
  101a29:	68 c8 38 10 00       	push   $0x1038c8
  101a2e:	e8 1a e8 ff ff       	call   10024d <cprintf>
  101a33:	83 c4 10             	add    $0x10,%esp
    cprintf("  trap 0x%08x %s\n", tf->tf_trapno, trapname(tf->tf_trapno));
  101a36:	8b 45 08             	mov    0x8(%ebp),%eax
  101a39:	8b 40 30             	mov    0x30(%eax),%eax
  101a3c:	83 ec 0c             	sub    $0xc,%esp
  101a3f:	50                   	push   %eax
  101a40:	e8 16 ff ff ff       	call   10195b <trapname>
  101a45:	83 c4 10             	add    $0x10,%esp
  101a48:	89 c2                	mov    %eax,%edx
  101a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  101a4d:	8b 40 30             	mov    0x30(%eax),%eax
  101a50:	83 ec 04             	sub    $0x4,%esp
  101a53:	52                   	push   %edx
  101a54:	50                   	push   %eax
  101a55:	68 db 38 10 00       	push   $0x1038db
  101a5a:	e8 ee e7 ff ff       	call   10024d <cprintf>
  101a5f:	83 c4 10             	add    $0x10,%esp
    cprintf("  err  0x%08x\n", tf->tf_err);
  101a62:	8b 45 08             	mov    0x8(%ebp),%eax
  101a65:	8b 40 34             	mov    0x34(%eax),%eax
  101a68:	83 ec 08             	sub    $0x8,%esp
  101a6b:	50                   	push   %eax
  101a6c:	68 ed 38 10 00       	push   $0x1038ed
  101a71:	e8 d7 e7 ff ff       	call   10024d <cprintf>
  101a76:	83 c4 10             	add    $0x10,%esp
    cprintf("  eip  0x%08x\n", tf->tf_eip);
  101a79:	8b 45 08             	mov    0x8(%ebp),%eax
  101a7c:	8b 40 38             	mov    0x38(%eax),%eax
  101a7f:	83 ec 08             	sub    $0x8,%esp
  101a82:	50                   	push   %eax
  101a83:	68 fc 38 10 00       	push   $0x1038fc
  101a88:	e8 c0 e7 ff ff       	call   10024d <cprintf>
  101a8d:	83 c4 10             	add    $0x10,%esp
    cprintf("  cs   0x----%04x\n", tf->tf_cs);
  101a90:	8b 45 08             	mov    0x8(%ebp),%eax
  101a93:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101a97:	0f b7 c0             	movzwl %ax,%eax
  101a9a:	83 ec 08             	sub    $0x8,%esp
  101a9d:	50                   	push   %eax
  101a9e:	68 0b 39 10 00       	push   $0x10390b
  101aa3:	e8 a5 e7 ff ff       	call   10024d <cprintf>
  101aa8:	83 c4 10             	add    $0x10,%esp
    cprintf("  flag 0x%08x ", tf->tf_eflags);
  101aab:	8b 45 08             	mov    0x8(%ebp),%eax
  101aae:	8b 40 40             	mov    0x40(%eax),%eax
  101ab1:	83 ec 08             	sub    $0x8,%esp
  101ab4:	50                   	push   %eax
  101ab5:	68 1e 39 10 00       	push   $0x10391e
  101aba:	e8 8e e7 ff ff       	call   10024d <cprintf>
  101abf:	83 c4 10             	add    $0x10,%esp

    int i, j;
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101ac2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  101ac9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  101ad0:	eb 3f                	jmp    101b11 <print_trapframe+0x16f>
        if ((tf->tf_eflags & j) && IA32flags[i] != NULL) {
  101ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  101ad5:	8b 50 40             	mov    0x40(%eax),%edx
  101ad8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  101adb:	21 d0                	and    %edx,%eax
  101add:	85 c0                	test   %eax,%eax
  101adf:	74 29                	je     101b0a <print_trapframe+0x168>
  101ae1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101ae4:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101aeb:	85 c0                	test   %eax,%eax
  101aed:	74 1b                	je     101b0a <print_trapframe+0x168>
            cprintf("%s,", IA32flags[i]);
  101aef:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101af2:	8b 04 85 80 e5 10 00 	mov    0x10e580(,%eax,4),%eax
  101af9:	83 ec 08             	sub    $0x8,%esp
  101afc:	50                   	push   %eax
  101afd:	68 2d 39 10 00       	push   $0x10392d
  101b02:	e8 46 e7 ff ff       	call   10024d <cprintf>
  101b07:	83 c4 10             	add    $0x10,%esp
    for (i = 0, j = 1; i < sizeof(IA32flags) / sizeof(IA32flags[0]); i ++, j <<= 1) {
  101b0a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  101b0e:	d1 65 f0             	shll   -0x10(%ebp)
  101b11:	8b 45 f4             	mov    -0xc(%ebp),%eax
  101b14:	83 f8 17             	cmp    $0x17,%eax
  101b17:	76 b9                	jbe    101ad2 <print_trapframe+0x130>
        }
    }
    cprintf("IOPL=%d\n", (tf->tf_eflags & FL_IOPL_MASK) >> 12);
  101b19:	8b 45 08             	mov    0x8(%ebp),%eax
  101b1c:	8b 40 40             	mov    0x40(%eax),%eax
  101b1f:	25 00 30 00 00       	and    $0x3000,%eax
  101b24:	c1 e8 0c             	shr    $0xc,%eax
  101b27:	83 ec 08             	sub    $0x8,%esp
  101b2a:	50                   	push   %eax
  101b2b:	68 31 39 10 00       	push   $0x103931
  101b30:	e8 18 e7 ff ff       	call   10024d <cprintf>
  101b35:	83 c4 10             	add    $0x10,%esp

    if (!trap_in_kernel(tf)) {
  101b38:	83 ec 0c             	sub    $0xc,%esp
  101b3b:	ff 75 08             	pushl  0x8(%ebp)
  101b3e:	e8 49 fe ff ff       	call   10198c <trap_in_kernel>
  101b43:	83 c4 10             	add    $0x10,%esp
  101b46:	85 c0                	test   %eax,%eax
  101b48:	75 32                	jne    101b7c <print_trapframe+0x1da>
        cprintf("  esp  0x%08x\n", tf->tf_esp);
  101b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  101b4d:	8b 40 44             	mov    0x44(%eax),%eax
  101b50:	83 ec 08             	sub    $0x8,%esp
  101b53:	50                   	push   %eax
  101b54:	68 3a 39 10 00       	push   $0x10393a
  101b59:	e8 ef e6 ff ff       	call   10024d <cprintf>
  101b5e:	83 c4 10             	add    $0x10,%esp
        cprintf("  ss   0x----%04x\n", tf->tf_ss);
  101b61:	8b 45 08             	mov    0x8(%ebp),%eax
  101b64:	0f b7 40 48          	movzwl 0x48(%eax),%eax
  101b68:	0f b7 c0             	movzwl %ax,%eax
  101b6b:	83 ec 08             	sub    $0x8,%esp
  101b6e:	50                   	push   %eax
  101b6f:	68 49 39 10 00       	push   $0x103949
  101b74:	e8 d4 e6 ff ff       	call   10024d <cprintf>
  101b79:	83 c4 10             	add    $0x10,%esp
    }
}
  101b7c:	90                   	nop
  101b7d:	c9                   	leave  
  101b7e:	c3                   	ret    

00101b7f <print_regs>:

void
print_regs(struct pushregs *regs) {
  101b7f:	55                   	push   %ebp
  101b80:	89 e5                	mov    %esp,%ebp
  101b82:	83 ec 08             	sub    $0x8,%esp
    cprintf("  edi  0x%08x\n", regs->reg_edi);
  101b85:	8b 45 08             	mov    0x8(%ebp),%eax
  101b88:	8b 00                	mov    (%eax),%eax
  101b8a:	83 ec 08             	sub    $0x8,%esp
  101b8d:	50                   	push   %eax
  101b8e:	68 5c 39 10 00       	push   $0x10395c
  101b93:	e8 b5 e6 ff ff       	call   10024d <cprintf>
  101b98:	83 c4 10             	add    $0x10,%esp
    cprintf("  esi  0x%08x\n", regs->reg_esi);
  101b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  101b9e:	8b 40 04             	mov    0x4(%eax),%eax
  101ba1:	83 ec 08             	sub    $0x8,%esp
  101ba4:	50                   	push   %eax
  101ba5:	68 6b 39 10 00       	push   $0x10396b
  101baa:	e8 9e e6 ff ff       	call   10024d <cprintf>
  101baf:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebp  0x%08x\n", regs->reg_ebp);
  101bb2:	8b 45 08             	mov    0x8(%ebp),%eax
  101bb5:	8b 40 08             	mov    0x8(%eax),%eax
  101bb8:	83 ec 08             	sub    $0x8,%esp
  101bbb:	50                   	push   %eax
  101bbc:	68 7a 39 10 00       	push   $0x10397a
  101bc1:	e8 87 e6 ff ff       	call   10024d <cprintf>
  101bc6:	83 c4 10             	add    $0x10,%esp
    cprintf("  oesp 0x%08x\n", regs->reg_oesp);
  101bc9:	8b 45 08             	mov    0x8(%ebp),%eax
  101bcc:	8b 40 0c             	mov    0xc(%eax),%eax
  101bcf:	83 ec 08             	sub    $0x8,%esp
  101bd2:	50                   	push   %eax
  101bd3:	68 89 39 10 00       	push   $0x103989
  101bd8:	e8 70 e6 ff ff       	call   10024d <cprintf>
  101bdd:	83 c4 10             	add    $0x10,%esp
    cprintf("  ebx  0x%08x\n", regs->reg_ebx);
  101be0:	8b 45 08             	mov    0x8(%ebp),%eax
  101be3:	8b 40 10             	mov    0x10(%eax),%eax
  101be6:	83 ec 08             	sub    $0x8,%esp
  101be9:	50                   	push   %eax
  101bea:	68 98 39 10 00       	push   $0x103998
  101bef:	e8 59 e6 ff ff       	call   10024d <cprintf>
  101bf4:	83 c4 10             	add    $0x10,%esp
    cprintf("  edx  0x%08x\n", regs->reg_edx);
  101bf7:	8b 45 08             	mov    0x8(%ebp),%eax
  101bfa:	8b 40 14             	mov    0x14(%eax),%eax
  101bfd:	83 ec 08             	sub    $0x8,%esp
  101c00:	50                   	push   %eax
  101c01:	68 a7 39 10 00       	push   $0x1039a7
  101c06:	e8 42 e6 ff ff       	call   10024d <cprintf>
  101c0b:	83 c4 10             	add    $0x10,%esp
    cprintf("  ecx  0x%08x\n", regs->reg_ecx);
  101c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  101c11:	8b 40 18             	mov    0x18(%eax),%eax
  101c14:	83 ec 08             	sub    $0x8,%esp
  101c17:	50                   	push   %eax
  101c18:	68 b6 39 10 00       	push   $0x1039b6
  101c1d:	e8 2b e6 ff ff       	call   10024d <cprintf>
  101c22:	83 c4 10             	add    $0x10,%esp
    cprintf("  eax  0x%08x\n", regs->reg_eax);
  101c25:	8b 45 08             	mov    0x8(%ebp),%eax
  101c28:	8b 40 1c             	mov    0x1c(%eax),%eax
  101c2b:	83 ec 08             	sub    $0x8,%esp
  101c2e:	50                   	push   %eax
  101c2f:	68 c5 39 10 00       	push   $0x1039c5
  101c34:	e8 14 e6 ff ff       	call   10024d <cprintf>
  101c39:	83 c4 10             	add    $0x10,%esp
}
  101c3c:	90                   	nop
  101c3d:	c9                   	leave  
  101c3e:	c3                   	ret    

00101c3f <trap_dispatch>:

/* trap_dispatch - dispatch based on what type of trap occurred */
static void
trap_dispatch(struct trapframe *tf) {
  101c3f:	55                   	push   %ebp
  101c40:	89 e5                	mov    %esp,%ebp
  101c42:	83 ec 18             	sub    $0x18,%esp
    char c;

    switch (tf->tf_trapno) {
  101c45:	8b 45 08             	mov    0x8(%ebp),%eax
  101c48:	8b 40 30             	mov    0x30(%eax),%eax
  101c4b:	83 f8 2f             	cmp    $0x2f,%eax
  101c4e:	77 21                	ja     101c71 <trap_dispatch+0x32>
  101c50:	83 f8 2e             	cmp    $0x2e,%eax
  101c53:	0f 83 7a 01 00 00    	jae    101dd3 <trap_dispatch+0x194>
  101c59:	83 f8 21             	cmp    $0x21,%eax
  101c5c:	0f 84 87 00 00 00    	je     101ce9 <trap_dispatch+0xaa>
  101c62:	83 f8 24             	cmp    $0x24,%eax
  101c65:	74 5b                	je     101cc2 <trap_dispatch+0x83>
  101c67:	83 f8 20             	cmp    $0x20,%eax
  101c6a:	74 1c                	je     101c88 <trap_dispatch+0x49>
  101c6c:	e9 2c 01 00 00       	jmp    101d9d <trap_dispatch+0x15e>
  101c71:	83 f8 78             	cmp    $0x78,%eax
  101c74:	0f 84 96 00 00 00    	je     101d10 <trap_dispatch+0xd1>
  101c7a:	83 f8 79             	cmp    $0x79,%eax
  101c7d:	0f 84 53 01 00 00    	je     101dd6 <trap_dispatch+0x197>
  101c83:	e9 15 01 00 00       	jmp    101d9d <trap_dispatch+0x15e>
        /* handle the timer interrupt */
        /* (1) After a timer interrupt, you should record this event using a global variable (increase it), such as ticks in kern/driver/clock.c
         * (2) Every TICK_NUM cycle, you can print some info using a funciton, such as print_ticks().
         * (3) Too Simple? Yes, I think so!
         */
        ++ticks;
  101c88:	a1 08 f9 10 00       	mov    0x10f908,%eax
  101c8d:	83 c0 01             	add    $0x1,%eax
  101c90:	a3 08 f9 10 00       	mov    %eax,0x10f908
        if (ticks % TICK_NUM == 0)
  101c95:	8b 0d 08 f9 10 00    	mov    0x10f908,%ecx
  101c9b:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  101ca0:	89 c8                	mov    %ecx,%eax
  101ca2:	f7 e2                	mul    %edx
  101ca4:	89 d0                	mov    %edx,%eax
  101ca6:	c1 e8 05             	shr    $0x5,%eax
  101ca9:	6b c0 64             	imul   $0x64,%eax,%eax
  101cac:	29 c1                	sub    %eax,%ecx
  101cae:	89 c8                	mov    %ecx,%eax
  101cb0:	85 c0                	test   %eax,%eax
  101cb2:	0f 85 21 01 00 00    	jne    101dd9 <trap_dispatch+0x19a>
            print_ticks();
  101cb8:	e8 15 fb ff ff       	call   1017d2 <print_ticks>
        break;
  101cbd:	e9 17 01 00 00       	jmp    101dd9 <trap_dispatch+0x19a>
    case IRQ_OFFSET + IRQ_COM1:
        c = cons_getc();
  101cc2:	e8 de f8 ff ff       	call   1015a5 <cons_getc>
  101cc7:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("serial [%03d] %c\n", c, c);
  101cca:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101cce:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101cd2:	83 ec 04             	sub    $0x4,%esp
  101cd5:	52                   	push   %edx
  101cd6:	50                   	push   %eax
  101cd7:	68 d4 39 10 00       	push   $0x1039d4
  101cdc:	e8 6c e5 ff ff       	call   10024d <cprintf>
  101ce1:	83 c4 10             	add    $0x10,%esp
        break;
  101ce4:	e9 f1 00 00 00       	jmp    101dda <trap_dispatch+0x19b>
    case IRQ_OFFSET + IRQ_KBD:
        c = cons_getc();
  101ce9:	e8 b7 f8 ff ff       	call   1015a5 <cons_getc>
  101cee:	88 45 f7             	mov    %al,-0x9(%ebp)
        cprintf("kbd [%03d] %c\n", c, c);
  101cf1:	0f be 55 f7          	movsbl -0x9(%ebp),%edx
  101cf5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  101cf9:	83 ec 04             	sub    $0x4,%esp
  101cfc:	52                   	push   %edx
  101cfd:	50                   	push   %eax
  101cfe:	68 e6 39 10 00       	push   $0x1039e6
  101d03:	e8 45 e5 ff ff       	call   10024d <cprintf>
  101d08:	83 c4 10             	add    $0x10,%esp
        break;
  101d0b:	e9 ca 00 00 00       	jmp    101dda <trap_dispatch+0x19b>
    //LAB1 CHALLENGE 1 : 2016011446 you should modify below codes.
    case T_SWITCH_TOU:
        cprintf("%x\n", USER_CS);
  101d10:	83 ec 08             	sub    $0x8,%esp
  101d13:	6a 1b                	push   $0x1b
  101d15:	68 f5 39 10 00       	push   $0x1039f5
  101d1a:	e8 2e e5 ff ff       	call   10024d <cprintf>
  101d1f:	83 c4 10             	add    $0x10,%esp
        cprintf("%x\n", USER_DS);
  101d22:	83 ec 08             	sub    $0x8,%esp
  101d25:	6a 23                	push   $0x23
  101d27:	68 f5 39 10 00       	push   $0x1039f5
  101d2c:	e8 1c e5 ff ff       	call   10024d <cprintf>
  101d31:	83 c4 10             	add    $0x10,%esp

        tf->tf_cs = USER_CS;
  101d34:	8b 45 08             	mov    0x8(%ebp),%eax
  101d37:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
        tf->tf_ds = tf->tf_es = tf->tf_fs = tf->tf_gs = tf->tf_ss = USER_DS;
  101d3d:	8b 45 08             	mov    0x8(%ebp),%eax
  101d40:	66 c7 40 48 23 00    	movw   $0x23,0x48(%eax)
  101d46:	8b 45 08             	mov    0x8(%ebp),%eax
  101d49:	0f b7 50 48          	movzwl 0x48(%eax),%edx
  101d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  101d50:	66 89 50 20          	mov    %dx,0x20(%eax)
  101d54:	8b 45 08             	mov    0x8(%ebp),%eax
  101d57:	0f b7 50 20          	movzwl 0x20(%eax),%edx
  101d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  101d5e:	66 89 50 24          	mov    %dx,0x24(%eax)
  101d62:	8b 45 08             	mov    0x8(%ebp),%eax
  101d65:	0f b7 50 24          	movzwl 0x24(%eax),%edx
  101d69:	8b 45 08             	mov    0x8(%ebp),%eax
  101d6c:	66 89 50 28          	mov    %dx,0x28(%eax)
  101d70:	8b 45 08             	mov    0x8(%ebp),%eax
  101d73:	0f b7 50 28          	movzwl 0x28(%eax),%edx
  101d77:	8b 45 08             	mov    0x8(%ebp),%eax
  101d7a:	66 89 50 2c          	mov    %dx,0x2c(%eax)
        tf->tf_eflags |= FL_IOPL_MASK;
  101d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  101d81:	8b 40 40             	mov    0x40(%eax),%eax
  101d84:	80 cc 30             	or     $0x30,%ah
  101d87:	89 c2                	mov    %eax,%edx
  101d89:	8b 45 08             	mov    0x8(%ebp),%eax
  101d8c:	89 50 40             	mov    %edx,0x40(%eax)
        tf->tf_esp = ((uintptr_t)tf) + sizeof(struct trapframe);
  101d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  101d92:	8d 50 4c             	lea    0x4c(%eax),%edx
  101d95:	8b 45 08             	mov    0x8(%ebp),%eax
  101d98:	89 50 44             	mov    %edx,0x44(%eax)
        break;
  101d9b:	eb 3d                	jmp    101dda <trap_dispatch+0x19b>
    case IRQ_OFFSET + IRQ_IDE2:
        /* do nothing */
        break;
    default:
        // in kernel, it must be a mistake
        if ((tf->tf_cs & 3) == 0) {
  101d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  101da0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
  101da4:	0f b7 c0             	movzwl %ax,%eax
  101da7:	83 e0 03             	and    $0x3,%eax
  101daa:	85 c0                	test   %eax,%eax
  101dac:	75 2c                	jne    101dda <trap_dispatch+0x19b>
            print_trapframe(tf);
  101dae:	83 ec 0c             	sub    $0xc,%esp
  101db1:	ff 75 08             	pushl  0x8(%ebp)
  101db4:	e8 e9 fb ff ff       	call   1019a2 <print_trapframe>
  101db9:	83 c4 10             	add    $0x10,%esp
            panic("unexpected trap in kernel.\n");
  101dbc:	83 ec 04             	sub    $0x4,%esp
  101dbf:	68 f9 39 10 00       	push   $0x1039f9
  101dc4:	68 bc 00 00 00       	push   $0xbc
  101dc9:	68 15 3a 10 00       	push   $0x103a15
  101dce:	e8 e0 e5 ff ff       	call   1003b3 <__panic>
        break;
  101dd3:	90                   	nop
  101dd4:	eb 04                	jmp    101dda <trap_dispatch+0x19b>
        break;
  101dd6:	90                   	nop
  101dd7:	eb 01                	jmp    101dda <trap_dispatch+0x19b>
        break;
  101dd9:	90                   	nop
        }
    }
}
  101dda:	90                   	nop
  101ddb:	c9                   	leave  
  101ddc:	c3                   	ret    

00101ddd <trap>:
 * trap - handles or dispatches an exception/interrupt. if and when trap() returns,
 * the code in kern/trap/trapentry.S restores the old CPU state saved in the
 * trapframe and then uses the iret instruction to return from the exception.
 * */
void
trap(struct trapframe *tf) {
  101ddd:	55                   	push   %ebp
  101dde:	89 e5                	mov    %esp,%ebp
  101de0:	83 ec 08             	sub    $0x8,%esp
    // dispatch based on what type of trap occurred
    trap_dispatch(tf);
  101de3:	83 ec 0c             	sub    $0xc,%esp
  101de6:	ff 75 08             	pushl  0x8(%ebp)
  101de9:	e8 51 fe ff ff       	call   101c3f <trap_dispatch>
  101dee:	83 c4 10             	add    $0x10,%esp
}
  101df1:	90                   	nop
  101df2:	c9                   	leave  
  101df3:	c3                   	ret    

00101df4 <vector0>:
# handler
.text
.globl __alltraps
.globl vector0
vector0:
  pushl $0
  101df4:	6a 00                	push   $0x0
  pushl $0
  101df6:	6a 00                	push   $0x0
  jmp __alltraps
  101df8:	e9 69 0a 00 00       	jmp    102866 <__alltraps>

00101dfd <vector1>:
.globl vector1
vector1:
  pushl $0
  101dfd:	6a 00                	push   $0x0
  pushl $1
  101dff:	6a 01                	push   $0x1
  jmp __alltraps
  101e01:	e9 60 0a 00 00       	jmp    102866 <__alltraps>

00101e06 <vector2>:
.globl vector2
vector2:
  pushl $0
  101e06:	6a 00                	push   $0x0
  pushl $2
  101e08:	6a 02                	push   $0x2
  jmp __alltraps
  101e0a:	e9 57 0a 00 00       	jmp    102866 <__alltraps>

00101e0f <vector3>:
.globl vector3
vector3:
  pushl $0
  101e0f:	6a 00                	push   $0x0
  pushl $3
  101e11:	6a 03                	push   $0x3
  jmp __alltraps
  101e13:	e9 4e 0a 00 00       	jmp    102866 <__alltraps>

00101e18 <vector4>:
.globl vector4
vector4:
  pushl $0
  101e18:	6a 00                	push   $0x0
  pushl $4
  101e1a:	6a 04                	push   $0x4
  jmp __alltraps
  101e1c:	e9 45 0a 00 00       	jmp    102866 <__alltraps>

00101e21 <vector5>:
.globl vector5
vector5:
  pushl $0
  101e21:	6a 00                	push   $0x0
  pushl $5
  101e23:	6a 05                	push   $0x5
  jmp __alltraps
  101e25:	e9 3c 0a 00 00       	jmp    102866 <__alltraps>

00101e2a <vector6>:
.globl vector6
vector6:
  pushl $0
  101e2a:	6a 00                	push   $0x0
  pushl $6
  101e2c:	6a 06                	push   $0x6
  jmp __alltraps
  101e2e:	e9 33 0a 00 00       	jmp    102866 <__alltraps>

00101e33 <vector7>:
.globl vector7
vector7:
  pushl $0
  101e33:	6a 00                	push   $0x0
  pushl $7
  101e35:	6a 07                	push   $0x7
  jmp __alltraps
  101e37:	e9 2a 0a 00 00       	jmp    102866 <__alltraps>

00101e3c <vector8>:
.globl vector8
vector8:
  pushl $8
  101e3c:	6a 08                	push   $0x8
  jmp __alltraps
  101e3e:	e9 23 0a 00 00       	jmp    102866 <__alltraps>

00101e43 <vector9>:
.globl vector9
vector9:
  pushl $0
  101e43:	6a 00                	push   $0x0
  pushl $9
  101e45:	6a 09                	push   $0x9
  jmp __alltraps
  101e47:	e9 1a 0a 00 00       	jmp    102866 <__alltraps>

00101e4c <vector10>:
.globl vector10
vector10:
  pushl $10
  101e4c:	6a 0a                	push   $0xa
  jmp __alltraps
  101e4e:	e9 13 0a 00 00       	jmp    102866 <__alltraps>

00101e53 <vector11>:
.globl vector11
vector11:
  pushl $11
  101e53:	6a 0b                	push   $0xb
  jmp __alltraps
  101e55:	e9 0c 0a 00 00       	jmp    102866 <__alltraps>

00101e5a <vector12>:
.globl vector12
vector12:
  pushl $12
  101e5a:	6a 0c                	push   $0xc
  jmp __alltraps
  101e5c:	e9 05 0a 00 00       	jmp    102866 <__alltraps>

00101e61 <vector13>:
.globl vector13
vector13:
  pushl $13
  101e61:	6a 0d                	push   $0xd
  jmp __alltraps
  101e63:	e9 fe 09 00 00       	jmp    102866 <__alltraps>

00101e68 <vector14>:
.globl vector14
vector14:
  pushl $14
  101e68:	6a 0e                	push   $0xe
  jmp __alltraps
  101e6a:	e9 f7 09 00 00       	jmp    102866 <__alltraps>

00101e6f <vector15>:
.globl vector15
vector15:
  pushl $0
  101e6f:	6a 00                	push   $0x0
  pushl $15
  101e71:	6a 0f                	push   $0xf
  jmp __alltraps
  101e73:	e9 ee 09 00 00       	jmp    102866 <__alltraps>

00101e78 <vector16>:
.globl vector16
vector16:
  pushl $0
  101e78:	6a 00                	push   $0x0
  pushl $16
  101e7a:	6a 10                	push   $0x10
  jmp __alltraps
  101e7c:	e9 e5 09 00 00       	jmp    102866 <__alltraps>

00101e81 <vector17>:
.globl vector17
vector17:
  pushl $17
  101e81:	6a 11                	push   $0x11
  jmp __alltraps
  101e83:	e9 de 09 00 00       	jmp    102866 <__alltraps>

00101e88 <vector18>:
.globl vector18
vector18:
  pushl $0
  101e88:	6a 00                	push   $0x0
  pushl $18
  101e8a:	6a 12                	push   $0x12
  jmp __alltraps
  101e8c:	e9 d5 09 00 00       	jmp    102866 <__alltraps>

00101e91 <vector19>:
.globl vector19
vector19:
  pushl $0
  101e91:	6a 00                	push   $0x0
  pushl $19
  101e93:	6a 13                	push   $0x13
  jmp __alltraps
  101e95:	e9 cc 09 00 00       	jmp    102866 <__alltraps>

00101e9a <vector20>:
.globl vector20
vector20:
  pushl $0
  101e9a:	6a 00                	push   $0x0
  pushl $20
  101e9c:	6a 14                	push   $0x14
  jmp __alltraps
  101e9e:	e9 c3 09 00 00       	jmp    102866 <__alltraps>

00101ea3 <vector21>:
.globl vector21
vector21:
  pushl $0
  101ea3:	6a 00                	push   $0x0
  pushl $21
  101ea5:	6a 15                	push   $0x15
  jmp __alltraps
  101ea7:	e9 ba 09 00 00       	jmp    102866 <__alltraps>

00101eac <vector22>:
.globl vector22
vector22:
  pushl $0
  101eac:	6a 00                	push   $0x0
  pushl $22
  101eae:	6a 16                	push   $0x16
  jmp __alltraps
  101eb0:	e9 b1 09 00 00       	jmp    102866 <__alltraps>

00101eb5 <vector23>:
.globl vector23
vector23:
  pushl $0
  101eb5:	6a 00                	push   $0x0
  pushl $23
  101eb7:	6a 17                	push   $0x17
  jmp __alltraps
  101eb9:	e9 a8 09 00 00       	jmp    102866 <__alltraps>

00101ebe <vector24>:
.globl vector24
vector24:
  pushl $0
  101ebe:	6a 00                	push   $0x0
  pushl $24
  101ec0:	6a 18                	push   $0x18
  jmp __alltraps
  101ec2:	e9 9f 09 00 00       	jmp    102866 <__alltraps>

00101ec7 <vector25>:
.globl vector25
vector25:
  pushl $0
  101ec7:	6a 00                	push   $0x0
  pushl $25
  101ec9:	6a 19                	push   $0x19
  jmp __alltraps
  101ecb:	e9 96 09 00 00       	jmp    102866 <__alltraps>

00101ed0 <vector26>:
.globl vector26
vector26:
  pushl $0
  101ed0:	6a 00                	push   $0x0
  pushl $26
  101ed2:	6a 1a                	push   $0x1a
  jmp __alltraps
  101ed4:	e9 8d 09 00 00       	jmp    102866 <__alltraps>

00101ed9 <vector27>:
.globl vector27
vector27:
  pushl $0
  101ed9:	6a 00                	push   $0x0
  pushl $27
  101edb:	6a 1b                	push   $0x1b
  jmp __alltraps
  101edd:	e9 84 09 00 00       	jmp    102866 <__alltraps>

00101ee2 <vector28>:
.globl vector28
vector28:
  pushl $0
  101ee2:	6a 00                	push   $0x0
  pushl $28
  101ee4:	6a 1c                	push   $0x1c
  jmp __alltraps
  101ee6:	e9 7b 09 00 00       	jmp    102866 <__alltraps>

00101eeb <vector29>:
.globl vector29
vector29:
  pushl $0
  101eeb:	6a 00                	push   $0x0
  pushl $29
  101eed:	6a 1d                	push   $0x1d
  jmp __alltraps
  101eef:	e9 72 09 00 00       	jmp    102866 <__alltraps>

00101ef4 <vector30>:
.globl vector30
vector30:
  pushl $0
  101ef4:	6a 00                	push   $0x0
  pushl $30
  101ef6:	6a 1e                	push   $0x1e
  jmp __alltraps
  101ef8:	e9 69 09 00 00       	jmp    102866 <__alltraps>

00101efd <vector31>:
.globl vector31
vector31:
  pushl $0
  101efd:	6a 00                	push   $0x0
  pushl $31
  101eff:	6a 1f                	push   $0x1f
  jmp __alltraps
  101f01:	e9 60 09 00 00       	jmp    102866 <__alltraps>

00101f06 <vector32>:
.globl vector32
vector32:
  pushl $0
  101f06:	6a 00                	push   $0x0
  pushl $32
  101f08:	6a 20                	push   $0x20
  jmp __alltraps
  101f0a:	e9 57 09 00 00       	jmp    102866 <__alltraps>

00101f0f <vector33>:
.globl vector33
vector33:
  pushl $0
  101f0f:	6a 00                	push   $0x0
  pushl $33
  101f11:	6a 21                	push   $0x21
  jmp __alltraps
  101f13:	e9 4e 09 00 00       	jmp    102866 <__alltraps>

00101f18 <vector34>:
.globl vector34
vector34:
  pushl $0
  101f18:	6a 00                	push   $0x0
  pushl $34
  101f1a:	6a 22                	push   $0x22
  jmp __alltraps
  101f1c:	e9 45 09 00 00       	jmp    102866 <__alltraps>

00101f21 <vector35>:
.globl vector35
vector35:
  pushl $0
  101f21:	6a 00                	push   $0x0
  pushl $35
  101f23:	6a 23                	push   $0x23
  jmp __alltraps
  101f25:	e9 3c 09 00 00       	jmp    102866 <__alltraps>

00101f2a <vector36>:
.globl vector36
vector36:
  pushl $0
  101f2a:	6a 00                	push   $0x0
  pushl $36
  101f2c:	6a 24                	push   $0x24
  jmp __alltraps
  101f2e:	e9 33 09 00 00       	jmp    102866 <__alltraps>

00101f33 <vector37>:
.globl vector37
vector37:
  pushl $0
  101f33:	6a 00                	push   $0x0
  pushl $37
  101f35:	6a 25                	push   $0x25
  jmp __alltraps
  101f37:	e9 2a 09 00 00       	jmp    102866 <__alltraps>

00101f3c <vector38>:
.globl vector38
vector38:
  pushl $0
  101f3c:	6a 00                	push   $0x0
  pushl $38
  101f3e:	6a 26                	push   $0x26
  jmp __alltraps
  101f40:	e9 21 09 00 00       	jmp    102866 <__alltraps>

00101f45 <vector39>:
.globl vector39
vector39:
  pushl $0
  101f45:	6a 00                	push   $0x0
  pushl $39
  101f47:	6a 27                	push   $0x27
  jmp __alltraps
  101f49:	e9 18 09 00 00       	jmp    102866 <__alltraps>

00101f4e <vector40>:
.globl vector40
vector40:
  pushl $0
  101f4e:	6a 00                	push   $0x0
  pushl $40
  101f50:	6a 28                	push   $0x28
  jmp __alltraps
  101f52:	e9 0f 09 00 00       	jmp    102866 <__alltraps>

00101f57 <vector41>:
.globl vector41
vector41:
  pushl $0
  101f57:	6a 00                	push   $0x0
  pushl $41
  101f59:	6a 29                	push   $0x29
  jmp __alltraps
  101f5b:	e9 06 09 00 00       	jmp    102866 <__alltraps>

00101f60 <vector42>:
.globl vector42
vector42:
  pushl $0
  101f60:	6a 00                	push   $0x0
  pushl $42
  101f62:	6a 2a                	push   $0x2a
  jmp __alltraps
  101f64:	e9 fd 08 00 00       	jmp    102866 <__alltraps>

00101f69 <vector43>:
.globl vector43
vector43:
  pushl $0
  101f69:	6a 00                	push   $0x0
  pushl $43
  101f6b:	6a 2b                	push   $0x2b
  jmp __alltraps
  101f6d:	e9 f4 08 00 00       	jmp    102866 <__alltraps>

00101f72 <vector44>:
.globl vector44
vector44:
  pushl $0
  101f72:	6a 00                	push   $0x0
  pushl $44
  101f74:	6a 2c                	push   $0x2c
  jmp __alltraps
  101f76:	e9 eb 08 00 00       	jmp    102866 <__alltraps>

00101f7b <vector45>:
.globl vector45
vector45:
  pushl $0
  101f7b:	6a 00                	push   $0x0
  pushl $45
  101f7d:	6a 2d                	push   $0x2d
  jmp __alltraps
  101f7f:	e9 e2 08 00 00       	jmp    102866 <__alltraps>

00101f84 <vector46>:
.globl vector46
vector46:
  pushl $0
  101f84:	6a 00                	push   $0x0
  pushl $46
  101f86:	6a 2e                	push   $0x2e
  jmp __alltraps
  101f88:	e9 d9 08 00 00       	jmp    102866 <__alltraps>

00101f8d <vector47>:
.globl vector47
vector47:
  pushl $0
  101f8d:	6a 00                	push   $0x0
  pushl $47
  101f8f:	6a 2f                	push   $0x2f
  jmp __alltraps
  101f91:	e9 d0 08 00 00       	jmp    102866 <__alltraps>

00101f96 <vector48>:
.globl vector48
vector48:
  pushl $0
  101f96:	6a 00                	push   $0x0
  pushl $48
  101f98:	6a 30                	push   $0x30
  jmp __alltraps
  101f9a:	e9 c7 08 00 00       	jmp    102866 <__alltraps>

00101f9f <vector49>:
.globl vector49
vector49:
  pushl $0
  101f9f:	6a 00                	push   $0x0
  pushl $49
  101fa1:	6a 31                	push   $0x31
  jmp __alltraps
  101fa3:	e9 be 08 00 00       	jmp    102866 <__alltraps>

00101fa8 <vector50>:
.globl vector50
vector50:
  pushl $0
  101fa8:	6a 00                	push   $0x0
  pushl $50
  101faa:	6a 32                	push   $0x32
  jmp __alltraps
  101fac:	e9 b5 08 00 00       	jmp    102866 <__alltraps>

00101fb1 <vector51>:
.globl vector51
vector51:
  pushl $0
  101fb1:	6a 00                	push   $0x0
  pushl $51
  101fb3:	6a 33                	push   $0x33
  jmp __alltraps
  101fb5:	e9 ac 08 00 00       	jmp    102866 <__alltraps>

00101fba <vector52>:
.globl vector52
vector52:
  pushl $0
  101fba:	6a 00                	push   $0x0
  pushl $52
  101fbc:	6a 34                	push   $0x34
  jmp __alltraps
  101fbe:	e9 a3 08 00 00       	jmp    102866 <__alltraps>

00101fc3 <vector53>:
.globl vector53
vector53:
  pushl $0
  101fc3:	6a 00                	push   $0x0
  pushl $53
  101fc5:	6a 35                	push   $0x35
  jmp __alltraps
  101fc7:	e9 9a 08 00 00       	jmp    102866 <__alltraps>

00101fcc <vector54>:
.globl vector54
vector54:
  pushl $0
  101fcc:	6a 00                	push   $0x0
  pushl $54
  101fce:	6a 36                	push   $0x36
  jmp __alltraps
  101fd0:	e9 91 08 00 00       	jmp    102866 <__alltraps>

00101fd5 <vector55>:
.globl vector55
vector55:
  pushl $0
  101fd5:	6a 00                	push   $0x0
  pushl $55
  101fd7:	6a 37                	push   $0x37
  jmp __alltraps
  101fd9:	e9 88 08 00 00       	jmp    102866 <__alltraps>

00101fde <vector56>:
.globl vector56
vector56:
  pushl $0
  101fde:	6a 00                	push   $0x0
  pushl $56
  101fe0:	6a 38                	push   $0x38
  jmp __alltraps
  101fe2:	e9 7f 08 00 00       	jmp    102866 <__alltraps>

00101fe7 <vector57>:
.globl vector57
vector57:
  pushl $0
  101fe7:	6a 00                	push   $0x0
  pushl $57
  101fe9:	6a 39                	push   $0x39
  jmp __alltraps
  101feb:	e9 76 08 00 00       	jmp    102866 <__alltraps>

00101ff0 <vector58>:
.globl vector58
vector58:
  pushl $0
  101ff0:	6a 00                	push   $0x0
  pushl $58
  101ff2:	6a 3a                	push   $0x3a
  jmp __alltraps
  101ff4:	e9 6d 08 00 00       	jmp    102866 <__alltraps>

00101ff9 <vector59>:
.globl vector59
vector59:
  pushl $0
  101ff9:	6a 00                	push   $0x0
  pushl $59
  101ffb:	6a 3b                	push   $0x3b
  jmp __alltraps
  101ffd:	e9 64 08 00 00       	jmp    102866 <__alltraps>

00102002 <vector60>:
.globl vector60
vector60:
  pushl $0
  102002:	6a 00                	push   $0x0
  pushl $60
  102004:	6a 3c                	push   $0x3c
  jmp __alltraps
  102006:	e9 5b 08 00 00       	jmp    102866 <__alltraps>

0010200b <vector61>:
.globl vector61
vector61:
  pushl $0
  10200b:	6a 00                	push   $0x0
  pushl $61
  10200d:	6a 3d                	push   $0x3d
  jmp __alltraps
  10200f:	e9 52 08 00 00       	jmp    102866 <__alltraps>

00102014 <vector62>:
.globl vector62
vector62:
  pushl $0
  102014:	6a 00                	push   $0x0
  pushl $62
  102016:	6a 3e                	push   $0x3e
  jmp __alltraps
  102018:	e9 49 08 00 00       	jmp    102866 <__alltraps>

0010201d <vector63>:
.globl vector63
vector63:
  pushl $0
  10201d:	6a 00                	push   $0x0
  pushl $63
  10201f:	6a 3f                	push   $0x3f
  jmp __alltraps
  102021:	e9 40 08 00 00       	jmp    102866 <__alltraps>

00102026 <vector64>:
.globl vector64
vector64:
  pushl $0
  102026:	6a 00                	push   $0x0
  pushl $64
  102028:	6a 40                	push   $0x40
  jmp __alltraps
  10202a:	e9 37 08 00 00       	jmp    102866 <__alltraps>

0010202f <vector65>:
.globl vector65
vector65:
  pushl $0
  10202f:	6a 00                	push   $0x0
  pushl $65
  102031:	6a 41                	push   $0x41
  jmp __alltraps
  102033:	e9 2e 08 00 00       	jmp    102866 <__alltraps>

00102038 <vector66>:
.globl vector66
vector66:
  pushl $0
  102038:	6a 00                	push   $0x0
  pushl $66
  10203a:	6a 42                	push   $0x42
  jmp __alltraps
  10203c:	e9 25 08 00 00       	jmp    102866 <__alltraps>

00102041 <vector67>:
.globl vector67
vector67:
  pushl $0
  102041:	6a 00                	push   $0x0
  pushl $67
  102043:	6a 43                	push   $0x43
  jmp __alltraps
  102045:	e9 1c 08 00 00       	jmp    102866 <__alltraps>

0010204a <vector68>:
.globl vector68
vector68:
  pushl $0
  10204a:	6a 00                	push   $0x0
  pushl $68
  10204c:	6a 44                	push   $0x44
  jmp __alltraps
  10204e:	e9 13 08 00 00       	jmp    102866 <__alltraps>

00102053 <vector69>:
.globl vector69
vector69:
  pushl $0
  102053:	6a 00                	push   $0x0
  pushl $69
  102055:	6a 45                	push   $0x45
  jmp __alltraps
  102057:	e9 0a 08 00 00       	jmp    102866 <__alltraps>

0010205c <vector70>:
.globl vector70
vector70:
  pushl $0
  10205c:	6a 00                	push   $0x0
  pushl $70
  10205e:	6a 46                	push   $0x46
  jmp __alltraps
  102060:	e9 01 08 00 00       	jmp    102866 <__alltraps>

00102065 <vector71>:
.globl vector71
vector71:
  pushl $0
  102065:	6a 00                	push   $0x0
  pushl $71
  102067:	6a 47                	push   $0x47
  jmp __alltraps
  102069:	e9 f8 07 00 00       	jmp    102866 <__alltraps>

0010206e <vector72>:
.globl vector72
vector72:
  pushl $0
  10206e:	6a 00                	push   $0x0
  pushl $72
  102070:	6a 48                	push   $0x48
  jmp __alltraps
  102072:	e9 ef 07 00 00       	jmp    102866 <__alltraps>

00102077 <vector73>:
.globl vector73
vector73:
  pushl $0
  102077:	6a 00                	push   $0x0
  pushl $73
  102079:	6a 49                	push   $0x49
  jmp __alltraps
  10207b:	e9 e6 07 00 00       	jmp    102866 <__alltraps>

00102080 <vector74>:
.globl vector74
vector74:
  pushl $0
  102080:	6a 00                	push   $0x0
  pushl $74
  102082:	6a 4a                	push   $0x4a
  jmp __alltraps
  102084:	e9 dd 07 00 00       	jmp    102866 <__alltraps>

00102089 <vector75>:
.globl vector75
vector75:
  pushl $0
  102089:	6a 00                	push   $0x0
  pushl $75
  10208b:	6a 4b                	push   $0x4b
  jmp __alltraps
  10208d:	e9 d4 07 00 00       	jmp    102866 <__alltraps>

00102092 <vector76>:
.globl vector76
vector76:
  pushl $0
  102092:	6a 00                	push   $0x0
  pushl $76
  102094:	6a 4c                	push   $0x4c
  jmp __alltraps
  102096:	e9 cb 07 00 00       	jmp    102866 <__alltraps>

0010209b <vector77>:
.globl vector77
vector77:
  pushl $0
  10209b:	6a 00                	push   $0x0
  pushl $77
  10209d:	6a 4d                	push   $0x4d
  jmp __alltraps
  10209f:	e9 c2 07 00 00       	jmp    102866 <__alltraps>

001020a4 <vector78>:
.globl vector78
vector78:
  pushl $0
  1020a4:	6a 00                	push   $0x0
  pushl $78
  1020a6:	6a 4e                	push   $0x4e
  jmp __alltraps
  1020a8:	e9 b9 07 00 00       	jmp    102866 <__alltraps>

001020ad <vector79>:
.globl vector79
vector79:
  pushl $0
  1020ad:	6a 00                	push   $0x0
  pushl $79
  1020af:	6a 4f                	push   $0x4f
  jmp __alltraps
  1020b1:	e9 b0 07 00 00       	jmp    102866 <__alltraps>

001020b6 <vector80>:
.globl vector80
vector80:
  pushl $0
  1020b6:	6a 00                	push   $0x0
  pushl $80
  1020b8:	6a 50                	push   $0x50
  jmp __alltraps
  1020ba:	e9 a7 07 00 00       	jmp    102866 <__alltraps>

001020bf <vector81>:
.globl vector81
vector81:
  pushl $0
  1020bf:	6a 00                	push   $0x0
  pushl $81
  1020c1:	6a 51                	push   $0x51
  jmp __alltraps
  1020c3:	e9 9e 07 00 00       	jmp    102866 <__alltraps>

001020c8 <vector82>:
.globl vector82
vector82:
  pushl $0
  1020c8:	6a 00                	push   $0x0
  pushl $82
  1020ca:	6a 52                	push   $0x52
  jmp __alltraps
  1020cc:	e9 95 07 00 00       	jmp    102866 <__alltraps>

001020d1 <vector83>:
.globl vector83
vector83:
  pushl $0
  1020d1:	6a 00                	push   $0x0
  pushl $83
  1020d3:	6a 53                	push   $0x53
  jmp __alltraps
  1020d5:	e9 8c 07 00 00       	jmp    102866 <__alltraps>

001020da <vector84>:
.globl vector84
vector84:
  pushl $0
  1020da:	6a 00                	push   $0x0
  pushl $84
  1020dc:	6a 54                	push   $0x54
  jmp __alltraps
  1020de:	e9 83 07 00 00       	jmp    102866 <__alltraps>

001020e3 <vector85>:
.globl vector85
vector85:
  pushl $0
  1020e3:	6a 00                	push   $0x0
  pushl $85
  1020e5:	6a 55                	push   $0x55
  jmp __alltraps
  1020e7:	e9 7a 07 00 00       	jmp    102866 <__alltraps>

001020ec <vector86>:
.globl vector86
vector86:
  pushl $0
  1020ec:	6a 00                	push   $0x0
  pushl $86
  1020ee:	6a 56                	push   $0x56
  jmp __alltraps
  1020f0:	e9 71 07 00 00       	jmp    102866 <__alltraps>

001020f5 <vector87>:
.globl vector87
vector87:
  pushl $0
  1020f5:	6a 00                	push   $0x0
  pushl $87
  1020f7:	6a 57                	push   $0x57
  jmp __alltraps
  1020f9:	e9 68 07 00 00       	jmp    102866 <__alltraps>

001020fe <vector88>:
.globl vector88
vector88:
  pushl $0
  1020fe:	6a 00                	push   $0x0
  pushl $88
  102100:	6a 58                	push   $0x58
  jmp __alltraps
  102102:	e9 5f 07 00 00       	jmp    102866 <__alltraps>

00102107 <vector89>:
.globl vector89
vector89:
  pushl $0
  102107:	6a 00                	push   $0x0
  pushl $89
  102109:	6a 59                	push   $0x59
  jmp __alltraps
  10210b:	e9 56 07 00 00       	jmp    102866 <__alltraps>

00102110 <vector90>:
.globl vector90
vector90:
  pushl $0
  102110:	6a 00                	push   $0x0
  pushl $90
  102112:	6a 5a                	push   $0x5a
  jmp __alltraps
  102114:	e9 4d 07 00 00       	jmp    102866 <__alltraps>

00102119 <vector91>:
.globl vector91
vector91:
  pushl $0
  102119:	6a 00                	push   $0x0
  pushl $91
  10211b:	6a 5b                	push   $0x5b
  jmp __alltraps
  10211d:	e9 44 07 00 00       	jmp    102866 <__alltraps>

00102122 <vector92>:
.globl vector92
vector92:
  pushl $0
  102122:	6a 00                	push   $0x0
  pushl $92
  102124:	6a 5c                	push   $0x5c
  jmp __alltraps
  102126:	e9 3b 07 00 00       	jmp    102866 <__alltraps>

0010212b <vector93>:
.globl vector93
vector93:
  pushl $0
  10212b:	6a 00                	push   $0x0
  pushl $93
  10212d:	6a 5d                	push   $0x5d
  jmp __alltraps
  10212f:	e9 32 07 00 00       	jmp    102866 <__alltraps>

00102134 <vector94>:
.globl vector94
vector94:
  pushl $0
  102134:	6a 00                	push   $0x0
  pushl $94
  102136:	6a 5e                	push   $0x5e
  jmp __alltraps
  102138:	e9 29 07 00 00       	jmp    102866 <__alltraps>

0010213d <vector95>:
.globl vector95
vector95:
  pushl $0
  10213d:	6a 00                	push   $0x0
  pushl $95
  10213f:	6a 5f                	push   $0x5f
  jmp __alltraps
  102141:	e9 20 07 00 00       	jmp    102866 <__alltraps>

00102146 <vector96>:
.globl vector96
vector96:
  pushl $0
  102146:	6a 00                	push   $0x0
  pushl $96
  102148:	6a 60                	push   $0x60
  jmp __alltraps
  10214a:	e9 17 07 00 00       	jmp    102866 <__alltraps>

0010214f <vector97>:
.globl vector97
vector97:
  pushl $0
  10214f:	6a 00                	push   $0x0
  pushl $97
  102151:	6a 61                	push   $0x61
  jmp __alltraps
  102153:	e9 0e 07 00 00       	jmp    102866 <__alltraps>

00102158 <vector98>:
.globl vector98
vector98:
  pushl $0
  102158:	6a 00                	push   $0x0
  pushl $98
  10215a:	6a 62                	push   $0x62
  jmp __alltraps
  10215c:	e9 05 07 00 00       	jmp    102866 <__alltraps>

00102161 <vector99>:
.globl vector99
vector99:
  pushl $0
  102161:	6a 00                	push   $0x0
  pushl $99
  102163:	6a 63                	push   $0x63
  jmp __alltraps
  102165:	e9 fc 06 00 00       	jmp    102866 <__alltraps>

0010216a <vector100>:
.globl vector100
vector100:
  pushl $0
  10216a:	6a 00                	push   $0x0
  pushl $100
  10216c:	6a 64                	push   $0x64
  jmp __alltraps
  10216e:	e9 f3 06 00 00       	jmp    102866 <__alltraps>

00102173 <vector101>:
.globl vector101
vector101:
  pushl $0
  102173:	6a 00                	push   $0x0
  pushl $101
  102175:	6a 65                	push   $0x65
  jmp __alltraps
  102177:	e9 ea 06 00 00       	jmp    102866 <__alltraps>

0010217c <vector102>:
.globl vector102
vector102:
  pushl $0
  10217c:	6a 00                	push   $0x0
  pushl $102
  10217e:	6a 66                	push   $0x66
  jmp __alltraps
  102180:	e9 e1 06 00 00       	jmp    102866 <__alltraps>

00102185 <vector103>:
.globl vector103
vector103:
  pushl $0
  102185:	6a 00                	push   $0x0
  pushl $103
  102187:	6a 67                	push   $0x67
  jmp __alltraps
  102189:	e9 d8 06 00 00       	jmp    102866 <__alltraps>

0010218e <vector104>:
.globl vector104
vector104:
  pushl $0
  10218e:	6a 00                	push   $0x0
  pushl $104
  102190:	6a 68                	push   $0x68
  jmp __alltraps
  102192:	e9 cf 06 00 00       	jmp    102866 <__alltraps>

00102197 <vector105>:
.globl vector105
vector105:
  pushl $0
  102197:	6a 00                	push   $0x0
  pushl $105
  102199:	6a 69                	push   $0x69
  jmp __alltraps
  10219b:	e9 c6 06 00 00       	jmp    102866 <__alltraps>

001021a0 <vector106>:
.globl vector106
vector106:
  pushl $0
  1021a0:	6a 00                	push   $0x0
  pushl $106
  1021a2:	6a 6a                	push   $0x6a
  jmp __alltraps
  1021a4:	e9 bd 06 00 00       	jmp    102866 <__alltraps>

001021a9 <vector107>:
.globl vector107
vector107:
  pushl $0
  1021a9:	6a 00                	push   $0x0
  pushl $107
  1021ab:	6a 6b                	push   $0x6b
  jmp __alltraps
  1021ad:	e9 b4 06 00 00       	jmp    102866 <__alltraps>

001021b2 <vector108>:
.globl vector108
vector108:
  pushl $0
  1021b2:	6a 00                	push   $0x0
  pushl $108
  1021b4:	6a 6c                	push   $0x6c
  jmp __alltraps
  1021b6:	e9 ab 06 00 00       	jmp    102866 <__alltraps>

001021bb <vector109>:
.globl vector109
vector109:
  pushl $0
  1021bb:	6a 00                	push   $0x0
  pushl $109
  1021bd:	6a 6d                	push   $0x6d
  jmp __alltraps
  1021bf:	e9 a2 06 00 00       	jmp    102866 <__alltraps>

001021c4 <vector110>:
.globl vector110
vector110:
  pushl $0
  1021c4:	6a 00                	push   $0x0
  pushl $110
  1021c6:	6a 6e                	push   $0x6e
  jmp __alltraps
  1021c8:	e9 99 06 00 00       	jmp    102866 <__alltraps>

001021cd <vector111>:
.globl vector111
vector111:
  pushl $0
  1021cd:	6a 00                	push   $0x0
  pushl $111
  1021cf:	6a 6f                	push   $0x6f
  jmp __alltraps
  1021d1:	e9 90 06 00 00       	jmp    102866 <__alltraps>

001021d6 <vector112>:
.globl vector112
vector112:
  pushl $0
  1021d6:	6a 00                	push   $0x0
  pushl $112
  1021d8:	6a 70                	push   $0x70
  jmp __alltraps
  1021da:	e9 87 06 00 00       	jmp    102866 <__alltraps>

001021df <vector113>:
.globl vector113
vector113:
  pushl $0
  1021df:	6a 00                	push   $0x0
  pushl $113
  1021e1:	6a 71                	push   $0x71
  jmp __alltraps
  1021e3:	e9 7e 06 00 00       	jmp    102866 <__alltraps>

001021e8 <vector114>:
.globl vector114
vector114:
  pushl $0
  1021e8:	6a 00                	push   $0x0
  pushl $114
  1021ea:	6a 72                	push   $0x72
  jmp __alltraps
  1021ec:	e9 75 06 00 00       	jmp    102866 <__alltraps>

001021f1 <vector115>:
.globl vector115
vector115:
  pushl $0
  1021f1:	6a 00                	push   $0x0
  pushl $115
  1021f3:	6a 73                	push   $0x73
  jmp __alltraps
  1021f5:	e9 6c 06 00 00       	jmp    102866 <__alltraps>

001021fa <vector116>:
.globl vector116
vector116:
  pushl $0
  1021fa:	6a 00                	push   $0x0
  pushl $116
  1021fc:	6a 74                	push   $0x74
  jmp __alltraps
  1021fe:	e9 63 06 00 00       	jmp    102866 <__alltraps>

00102203 <vector117>:
.globl vector117
vector117:
  pushl $0
  102203:	6a 00                	push   $0x0
  pushl $117
  102205:	6a 75                	push   $0x75
  jmp __alltraps
  102207:	e9 5a 06 00 00       	jmp    102866 <__alltraps>

0010220c <vector118>:
.globl vector118
vector118:
  pushl $0
  10220c:	6a 00                	push   $0x0
  pushl $118
  10220e:	6a 76                	push   $0x76
  jmp __alltraps
  102210:	e9 51 06 00 00       	jmp    102866 <__alltraps>

00102215 <vector119>:
.globl vector119
vector119:
  pushl $0
  102215:	6a 00                	push   $0x0
  pushl $119
  102217:	6a 77                	push   $0x77
  jmp __alltraps
  102219:	e9 48 06 00 00       	jmp    102866 <__alltraps>

0010221e <vector120>:
.globl vector120
vector120:
  pushl $0
  10221e:	6a 00                	push   $0x0
  pushl $120
  102220:	6a 78                	push   $0x78
  jmp __alltraps
  102222:	e9 3f 06 00 00       	jmp    102866 <__alltraps>

00102227 <vector121>:
.globl vector121
vector121:
  pushl $0
  102227:	6a 00                	push   $0x0
  pushl $121
  102229:	6a 79                	push   $0x79
  jmp __alltraps
  10222b:	e9 36 06 00 00       	jmp    102866 <__alltraps>

00102230 <vector122>:
.globl vector122
vector122:
  pushl $0
  102230:	6a 00                	push   $0x0
  pushl $122
  102232:	6a 7a                	push   $0x7a
  jmp __alltraps
  102234:	e9 2d 06 00 00       	jmp    102866 <__alltraps>

00102239 <vector123>:
.globl vector123
vector123:
  pushl $0
  102239:	6a 00                	push   $0x0
  pushl $123
  10223b:	6a 7b                	push   $0x7b
  jmp __alltraps
  10223d:	e9 24 06 00 00       	jmp    102866 <__alltraps>

00102242 <vector124>:
.globl vector124
vector124:
  pushl $0
  102242:	6a 00                	push   $0x0
  pushl $124
  102244:	6a 7c                	push   $0x7c
  jmp __alltraps
  102246:	e9 1b 06 00 00       	jmp    102866 <__alltraps>

0010224b <vector125>:
.globl vector125
vector125:
  pushl $0
  10224b:	6a 00                	push   $0x0
  pushl $125
  10224d:	6a 7d                	push   $0x7d
  jmp __alltraps
  10224f:	e9 12 06 00 00       	jmp    102866 <__alltraps>

00102254 <vector126>:
.globl vector126
vector126:
  pushl $0
  102254:	6a 00                	push   $0x0
  pushl $126
  102256:	6a 7e                	push   $0x7e
  jmp __alltraps
  102258:	e9 09 06 00 00       	jmp    102866 <__alltraps>

0010225d <vector127>:
.globl vector127
vector127:
  pushl $0
  10225d:	6a 00                	push   $0x0
  pushl $127
  10225f:	6a 7f                	push   $0x7f
  jmp __alltraps
  102261:	e9 00 06 00 00       	jmp    102866 <__alltraps>

00102266 <vector128>:
.globl vector128
vector128:
  pushl $0
  102266:	6a 00                	push   $0x0
  pushl $128
  102268:	68 80 00 00 00       	push   $0x80
  jmp __alltraps
  10226d:	e9 f4 05 00 00       	jmp    102866 <__alltraps>

00102272 <vector129>:
.globl vector129
vector129:
  pushl $0
  102272:	6a 00                	push   $0x0
  pushl $129
  102274:	68 81 00 00 00       	push   $0x81
  jmp __alltraps
  102279:	e9 e8 05 00 00       	jmp    102866 <__alltraps>

0010227e <vector130>:
.globl vector130
vector130:
  pushl $0
  10227e:	6a 00                	push   $0x0
  pushl $130
  102280:	68 82 00 00 00       	push   $0x82
  jmp __alltraps
  102285:	e9 dc 05 00 00       	jmp    102866 <__alltraps>

0010228a <vector131>:
.globl vector131
vector131:
  pushl $0
  10228a:	6a 00                	push   $0x0
  pushl $131
  10228c:	68 83 00 00 00       	push   $0x83
  jmp __alltraps
  102291:	e9 d0 05 00 00       	jmp    102866 <__alltraps>

00102296 <vector132>:
.globl vector132
vector132:
  pushl $0
  102296:	6a 00                	push   $0x0
  pushl $132
  102298:	68 84 00 00 00       	push   $0x84
  jmp __alltraps
  10229d:	e9 c4 05 00 00       	jmp    102866 <__alltraps>

001022a2 <vector133>:
.globl vector133
vector133:
  pushl $0
  1022a2:	6a 00                	push   $0x0
  pushl $133
  1022a4:	68 85 00 00 00       	push   $0x85
  jmp __alltraps
  1022a9:	e9 b8 05 00 00       	jmp    102866 <__alltraps>

001022ae <vector134>:
.globl vector134
vector134:
  pushl $0
  1022ae:	6a 00                	push   $0x0
  pushl $134
  1022b0:	68 86 00 00 00       	push   $0x86
  jmp __alltraps
  1022b5:	e9 ac 05 00 00       	jmp    102866 <__alltraps>

001022ba <vector135>:
.globl vector135
vector135:
  pushl $0
  1022ba:	6a 00                	push   $0x0
  pushl $135
  1022bc:	68 87 00 00 00       	push   $0x87
  jmp __alltraps
  1022c1:	e9 a0 05 00 00       	jmp    102866 <__alltraps>

001022c6 <vector136>:
.globl vector136
vector136:
  pushl $0
  1022c6:	6a 00                	push   $0x0
  pushl $136
  1022c8:	68 88 00 00 00       	push   $0x88
  jmp __alltraps
  1022cd:	e9 94 05 00 00       	jmp    102866 <__alltraps>

001022d2 <vector137>:
.globl vector137
vector137:
  pushl $0
  1022d2:	6a 00                	push   $0x0
  pushl $137
  1022d4:	68 89 00 00 00       	push   $0x89
  jmp __alltraps
  1022d9:	e9 88 05 00 00       	jmp    102866 <__alltraps>

001022de <vector138>:
.globl vector138
vector138:
  pushl $0
  1022de:	6a 00                	push   $0x0
  pushl $138
  1022e0:	68 8a 00 00 00       	push   $0x8a
  jmp __alltraps
  1022e5:	e9 7c 05 00 00       	jmp    102866 <__alltraps>

001022ea <vector139>:
.globl vector139
vector139:
  pushl $0
  1022ea:	6a 00                	push   $0x0
  pushl $139
  1022ec:	68 8b 00 00 00       	push   $0x8b
  jmp __alltraps
  1022f1:	e9 70 05 00 00       	jmp    102866 <__alltraps>

001022f6 <vector140>:
.globl vector140
vector140:
  pushl $0
  1022f6:	6a 00                	push   $0x0
  pushl $140
  1022f8:	68 8c 00 00 00       	push   $0x8c
  jmp __alltraps
  1022fd:	e9 64 05 00 00       	jmp    102866 <__alltraps>

00102302 <vector141>:
.globl vector141
vector141:
  pushl $0
  102302:	6a 00                	push   $0x0
  pushl $141
  102304:	68 8d 00 00 00       	push   $0x8d
  jmp __alltraps
  102309:	e9 58 05 00 00       	jmp    102866 <__alltraps>

0010230e <vector142>:
.globl vector142
vector142:
  pushl $0
  10230e:	6a 00                	push   $0x0
  pushl $142
  102310:	68 8e 00 00 00       	push   $0x8e
  jmp __alltraps
  102315:	e9 4c 05 00 00       	jmp    102866 <__alltraps>

0010231a <vector143>:
.globl vector143
vector143:
  pushl $0
  10231a:	6a 00                	push   $0x0
  pushl $143
  10231c:	68 8f 00 00 00       	push   $0x8f
  jmp __alltraps
  102321:	e9 40 05 00 00       	jmp    102866 <__alltraps>

00102326 <vector144>:
.globl vector144
vector144:
  pushl $0
  102326:	6a 00                	push   $0x0
  pushl $144
  102328:	68 90 00 00 00       	push   $0x90
  jmp __alltraps
  10232d:	e9 34 05 00 00       	jmp    102866 <__alltraps>

00102332 <vector145>:
.globl vector145
vector145:
  pushl $0
  102332:	6a 00                	push   $0x0
  pushl $145
  102334:	68 91 00 00 00       	push   $0x91
  jmp __alltraps
  102339:	e9 28 05 00 00       	jmp    102866 <__alltraps>

0010233e <vector146>:
.globl vector146
vector146:
  pushl $0
  10233e:	6a 00                	push   $0x0
  pushl $146
  102340:	68 92 00 00 00       	push   $0x92
  jmp __alltraps
  102345:	e9 1c 05 00 00       	jmp    102866 <__alltraps>

0010234a <vector147>:
.globl vector147
vector147:
  pushl $0
  10234a:	6a 00                	push   $0x0
  pushl $147
  10234c:	68 93 00 00 00       	push   $0x93
  jmp __alltraps
  102351:	e9 10 05 00 00       	jmp    102866 <__alltraps>

00102356 <vector148>:
.globl vector148
vector148:
  pushl $0
  102356:	6a 00                	push   $0x0
  pushl $148
  102358:	68 94 00 00 00       	push   $0x94
  jmp __alltraps
  10235d:	e9 04 05 00 00       	jmp    102866 <__alltraps>

00102362 <vector149>:
.globl vector149
vector149:
  pushl $0
  102362:	6a 00                	push   $0x0
  pushl $149
  102364:	68 95 00 00 00       	push   $0x95
  jmp __alltraps
  102369:	e9 f8 04 00 00       	jmp    102866 <__alltraps>

0010236e <vector150>:
.globl vector150
vector150:
  pushl $0
  10236e:	6a 00                	push   $0x0
  pushl $150
  102370:	68 96 00 00 00       	push   $0x96
  jmp __alltraps
  102375:	e9 ec 04 00 00       	jmp    102866 <__alltraps>

0010237a <vector151>:
.globl vector151
vector151:
  pushl $0
  10237a:	6a 00                	push   $0x0
  pushl $151
  10237c:	68 97 00 00 00       	push   $0x97
  jmp __alltraps
  102381:	e9 e0 04 00 00       	jmp    102866 <__alltraps>

00102386 <vector152>:
.globl vector152
vector152:
  pushl $0
  102386:	6a 00                	push   $0x0
  pushl $152
  102388:	68 98 00 00 00       	push   $0x98
  jmp __alltraps
  10238d:	e9 d4 04 00 00       	jmp    102866 <__alltraps>

00102392 <vector153>:
.globl vector153
vector153:
  pushl $0
  102392:	6a 00                	push   $0x0
  pushl $153
  102394:	68 99 00 00 00       	push   $0x99
  jmp __alltraps
  102399:	e9 c8 04 00 00       	jmp    102866 <__alltraps>

0010239e <vector154>:
.globl vector154
vector154:
  pushl $0
  10239e:	6a 00                	push   $0x0
  pushl $154
  1023a0:	68 9a 00 00 00       	push   $0x9a
  jmp __alltraps
  1023a5:	e9 bc 04 00 00       	jmp    102866 <__alltraps>

001023aa <vector155>:
.globl vector155
vector155:
  pushl $0
  1023aa:	6a 00                	push   $0x0
  pushl $155
  1023ac:	68 9b 00 00 00       	push   $0x9b
  jmp __alltraps
  1023b1:	e9 b0 04 00 00       	jmp    102866 <__alltraps>

001023b6 <vector156>:
.globl vector156
vector156:
  pushl $0
  1023b6:	6a 00                	push   $0x0
  pushl $156
  1023b8:	68 9c 00 00 00       	push   $0x9c
  jmp __alltraps
  1023bd:	e9 a4 04 00 00       	jmp    102866 <__alltraps>

001023c2 <vector157>:
.globl vector157
vector157:
  pushl $0
  1023c2:	6a 00                	push   $0x0
  pushl $157
  1023c4:	68 9d 00 00 00       	push   $0x9d
  jmp __alltraps
  1023c9:	e9 98 04 00 00       	jmp    102866 <__alltraps>

001023ce <vector158>:
.globl vector158
vector158:
  pushl $0
  1023ce:	6a 00                	push   $0x0
  pushl $158
  1023d0:	68 9e 00 00 00       	push   $0x9e
  jmp __alltraps
  1023d5:	e9 8c 04 00 00       	jmp    102866 <__alltraps>

001023da <vector159>:
.globl vector159
vector159:
  pushl $0
  1023da:	6a 00                	push   $0x0
  pushl $159
  1023dc:	68 9f 00 00 00       	push   $0x9f
  jmp __alltraps
  1023e1:	e9 80 04 00 00       	jmp    102866 <__alltraps>

001023e6 <vector160>:
.globl vector160
vector160:
  pushl $0
  1023e6:	6a 00                	push   $0x0
  pushl $160
  1023e8:	68 a0 00 00 00       	push   $0xa0
  jmp __alltraps
  1023ed:	e9 74 04 00 00       	jmp    102866 <__alltraps>

001023f2 <vector161>:
.globl vector161
vector161:
  pushl $0
  1023f2:	6a 00                	push   $0x0
  pushl $161
  1023f4:	68 a1 00 00 00       	push   $0xa1
  jmp __alltraps
  1023f9:	e9 68 04 00 00       	jmp    102866 <__alltraps>

001023fe <vector162>:
.globl vector162
vector162:
  pushl $0
  1023fe:	6a 00                	push   $0x0
  pushl $162
  102400:	68 a2 00 00 00       	push   $0xa2
  jmp __alltraps
  102405:	e9 5c 04 00 00       	jmp    102866 <__alltraps>

0010240a <vector163>:
.globl vector163
vector163:
  pushl $0
  10240a:	6a 00                	push   $0x0
  pushl $163
  10240c:	68 a3 00 00 00       	push   $0xa3
  jmp __alltraps
  102411:	e9 50 04 00 00       	jmp    102866 <__alltraps>

00102416 <vector164>:
.globl vector164
vector164:
  pushl $0
  102416:	6a 00                	push   $0x0
  pushl $164
  102418:	68 a4 00 00 00       	push   $0xa4
  jmp __alltraps
  10241d:	e9 44 04 00 00       	jmp    102866 <__alltraps>

00102422 <vector165>:
.globl vector165
vector165:
  pushl $0
  102422:	6a 00                	push   $0x0
  pushl $165
  102424:	68 a5 00 00 00       	push   $0xa5
  jmp __alltraps
  102429:	e9 38 04 00 00       	jmp    102866 <__alltraps>

0010242e <vector166>:
.globl vector166
vector166:
  pushl $0
  10242e:	6a 00                	push   $0x0
  pushl $166
  102430:	68 a6 00 00 00       	push   $0xa6
  jmp __alltraps
  102435:	e9 2c 04 00 00       	jmp    102866 <__alltraps>

0010243a <vector167>:
.globl vector167
vector167:
  pushl $0
  10243a:	6a 00                	push   $0x0
  pushl $167
  10243c:	68 a7 00 00 00       	push   $0xa7
  jmp __alltraps
  102441:	e9 20 04 00 00       	jmp    102866 <__alltraps>

00102446 <vector168>:
.globl vector168
vector168:
  pushl $0
  102446:	6a 00                	push   $0x0
  pushl $168
  102448:	68 a8 00 00 00       	push   $0xa8
  jmp __alltraps
  10244d:	e9 14 04 00 00       	jmp    102866 <__alltraps>

00102452 <vector169>:
.globl vector169
vector169:
  pushl $0
  102452:	6a 00                	push   $0x0
  pushl $169
  102454:	68 a9 00 00 00       	push   $0xa9
  jmp __alltraps
  102459:	e9 08 04 00 00       	jmp    102866 <__alltraps>

0010245e <vector170>:
.globl vector170
vector170:
  pushl $0
  10245e:	6a 00                	push   $0x0
  pushl $170
  102460:	68 aa 00 00 00       	push   $0xaa
  jmp __alltraps
  102465:	e9 fc 03 00 00       	jmp    102866 <__alltraps>

0010246a <vector171>:
.globl vector171
vector171:
  pushl $0
  10246a:	6a 00                	push   $0x0
  pushl $171
  10246c:	68 ab 00 00 00       	push   $0xab
  jmp __alltraps
  102471:	e9 f0 03 00 00       	jmp    102866 <__alltraps>

00102476 <vector172>:
.globl vector172
vector172:
  pushl $0
  102476:	6a 00                	push   $0x0
  pushl $172
  102478:	68 ac 00 00 00       	push   $0xac
  jmp __alltraps
  10247d:	e9 e4 03 00 00       	jmp    102866 <__alltraps>

00102482 <vector173>:
.globl vector173
vector173:
  pushl $0
  102482:	6a 00                	push   $0x0
  pushl $173
  102484:	68 ad 00 00 00       	push   $0xad
  jmp __alltraps
  102489:	e9 d8 03 00 00       	jmp    102866 <__alltraps>

0010248e <vector174>:
.globl vector174
vector174:
  pushl $0
  10248e:	6a 00                	push   $0x0
  pushl $174
  102490:	68 ae 00 00 00       	push   $0xae
  jmp __alltraps
  102495:	e9 cc 03 00 00       	jmp    102866 <__alltraps>

0010249a <vector175>:
.globl vector175
vector175:
  pushl $0
  10249a:	6a 00                	push   $0x0
  pushl $175
  10249c:	68 af 00 00 00       	push   $0xaf
  jmp __alltraps
  1024a1:	e9 c0 03 00 00       	jmp    102866 <__alltraps>

001024a6 <vector176>:
.globl vector176
vector176:
  pushl $0
  1024a6:	6a 00                	push   $0x0
  pushl $176
  1024a8:	68 b0 00 00 00       	push   $0xb0
  jmp __alltraps
  1024ad:	e9 b4 03 00 00       	jmp    102866 <__alltraps>

001024b2 <vector177>:
.globl vector177
vector177:
  pushl $0
  1024b2:	6a 00                	push   $0x0
  pushl $177
  1024b4:	68 b1 00 00 00       	push   $0xb1
  jmp __alltraps
  1024b9:	e9 a8 03 00 00       	jmp    102866 <__alltraps>

001024be <vector178>:
.globl vector178
vector178:
  pushl $0
  1024be:	6a 00                	push   $0x0
  pushl $178
  1024c0:	68 b2 00 00 00       	push   $0xb2
  jmp __alltraps
  1024c5:	e9 9c 03 00 00       	jmp    102866 <__alltraps>

001024ca <vector179>:
.globl vector179
vector179:
  pushl $0
  1024ca:	6a 00                	push   $0x0
  pushl $179
  1024cc:	68 b3 00 00 00       	push   $0xb3
  jmp __alltraps
  1024d1:	e9 90 03 00 00       	jmp    102866 <__alltraps>

001024d6 <vector180>:
.globl vector180
vector180:
  pushl $0
  1024d6:	6a 00                	push   $0x0
  pushl $180
  1024d8:	68 b4 00 00 00       	push   $0xb4
  jmp __alltraps
  1024dd:	e9 84 03 00 00       	jmp    102866 <__alltraps>

001024e2 <vector181>:
.globl vector181
vector181:
  pushl $0
  1024e2:	6a 00                	push   $0x0
  pushl $181
  1024e4:	68 b5 00 00 00       	push   $0xb5
  jmp __alltraps
  1024e9:	e9 78 03 00 00       	jmp    102866 <__alltraps>

001024ee <vector182>:
.globl vector182
vector182:
  pushl $0
  1024ee:	6a 00                	push   $0x0
  pushl $182
  1024f0:	68 b6 00 00 00       	push   $0xb6
  jmp __alltraps
  1024f5:	e9 6c 03 00 00       	jmp    102866 <__alltraps>

001024fa <vector183>:
.globl vector183
vector183:
  pushl $0
  1024fa:	6a 00                	push   $0x0
  pushl $183
  1024fc:	68 b7 00 00 00       	push   $0xb7
  jmp __alltraps
  102501:	e9 60 03 00 00       	jmp    102866 <__alltraps>

00102506 <vector184>:
.globl vector184
vector184:
  pushl $0
  102506:	6a 00                	push   $0x0
  pushl $184
  102508:	68 b8 00 00 00       	push   $0xb8
  jmp __alltraps
  10250d:	e9 54 03 00 00       	jmp    102866 <__alltraps>

00102512 <vector185>:
.globl vector185
vector185:
  pushl $0
  102512:	6a 00                	push   $0x0
  pushl $185
  102514:	68 b9 00 00 00       	push   $0xb9
  jmp __alltraps
  102519:	e9 48 03 00 00       	jmp    102866 <__alltraps>

0010251e <vector186>:
.globl vector186
vector186:
  pushl $0
  10251e:	6a 00                	push   $0x0
  pushl $186
  102520:	68 ba 00 00 00       	push   $0xba
  jmp __alltraps
  102525:	e9 3c 03 00 00       	jmp    102866 <__alltraps>

0010252a <vector187>:
.globl vector187
vector187:
  pushl $0
  10252a:	6a 00                	push   $0x0
  pushl $187
  10252c:	68 bb 00 00 00       	push   $0xbb
  jmp __alltraps
  102531:	e9 30 03 00 00       	jmp    102866 <__alltraps>

00102536 <vector188>:
.globl vector188
vector188:
  pushl $0
  102536:	6a 00                	push   $0x0
  pushl $188
  102538:	68 bc 00 00 00       	push   $0xbc
  jmp __alltraps
  10253d:	e9 24 03 00 00       	jmp    102866 <__alltraps>

00102542 <vector189>:
.globl vector189
vector189:
  pushl $0
  102542:	6a 00                	push   $0x0
  pushl $189
  102544:	68 bd 00 00 00       	push   $0xbd
  jmp __alltraps
  102549:	e9 18 03 00 00       	jmp    102866 <__alltraps>

0010254e <vector190>:
.globl vector190
vector190:
  pushl $0
  10254e:	6a 00                	push   $0x0
  pushl $190
  102550:	68 be 00 00 00       	push   $0xbe
  jmp __alltraps
  102555:	e9 0c 03 00 00       	jmp    102866 <__alltraps>

0010255a <vector191>:
.globl vector191
vector191:
  pushl $0
  10255a:	6a 00                	push   $0x0
  pushl $191
  10255c:	68 bf 00 00 00       	push   $0xbf
  jmp __alltraps
  102561:	e9 00 03 00 00       	jmp    102866 <__alltraps>

00102566 <vector192>:
.globl vector192
vector192:
  pushl $0
  102566:	6a 00                	push   $0x0
  pushl $192
  102568:	68 c0 00 00 00       	push   $0xc0
  jmp __alltraps
  10256d:	e9 f4 02 00 00       	jmp    102866 <__alltraps>

00102572 <vector193>:
.globl vector193
vector193:
  pushl $0
  102572:	6a 00                	push   $0x0
  pushl $193
  102574:	68 c1 00 00 00       	push   $0xc1
  jmp __alltraps
  102579:	e9 e8 02 00 00       	jmp    102866 <__alltraps>

0010257e <vector194>:
.globl vector194
vector194:
  pushl $0
  10257e:	6a 00                	push   $0x0
  pushl $194
  102580:	68 c2 00 00 00       	push   $0xc2
  jmp __alltraps
  102585:	e9 dc 02 00 00       	jmp    102866 <__alltraps>

0010258a <vector195>:
.globl vector195
vector195:
  pushl $0
  10258a:	6a 00                	push   $0x0
  pushl $195
  10258c:	68 c3 00 00 00       	push   $0xc3
  jmp __alltraps
  102591:	e9 d0 02 00 00       	jmp    102866 <__alltraps>

00102596 <vector196>:
.globl vector196
vector196:
  pushl $0
  102596:	6a 00                	push   $0x0
  pushl $196
  102598:	68 c4 00 00 00       	push   $0xc4
  jmp __alltraps
  10259d:	e9 c4 02 00 00       	jmp    102866 <__alltraps>

001025a2 <vector197>:
.globl vector197
vector197:
  pushl $0
  1025a2:	6a 00                	push   $0x0
  pushl $197
  1025a4:	68 c5 00 00 00       	push   $0xc5
  jmp __alltraps
  1025a9:	e9 b8 02 00 00       	jmp    102866 <__alltraps>

001025ae <vector198>:
.globl vector198
vector198:
  pushl $0
  1025ae:	6a 00                	push   $0x0
  pushl $198
  1025b0:	68 c6 00 00 00       	push   $0xc6
  jmp __alltraps
  1025b5:	e9 ac 02 00 00       	jmp    102866 <__alltraps>

001025ba <vector199>:
.globl vector199
vector199:
  pushl $0
  1025ba:	6a 00                	push   $0x0
  pushl $199
  1025bc:	68 c7 00 00 00       	push   $0xc7
  jmp __alltraps
  1025c1:	e9 a0 02 00 00       	jmp    102866 <__alltraps>

001025c6 <vector200>:
.globl vector200
vector200:
  pushl $0
  1025c6:	6a 00                	push   $0x0
  pushl $200
  1025c8:	68 c8 00 00 00       	push   $0xc8
  jmp __alltraps
  1025cd:	e9 94 02 00 00       	jmp    102866 <__alltraps>

001025d2 <vector201>:
.globl vector201
vector201:
  pushl $0
  1025d2:	6a 00                	push   $0x0
  pushl $201
  1025d4:	68 c9 00 00 00       	push   $0xc9
  jmp __alltraps
  1025d9:	e9 88 02 00 00       	jmp    102866 <__alltraps>

001025de <vector202>:
.globl vector202
vector202:
  pushl $0
  1025de:	6a 00                	push   $0x0
  pushl $202
  1025e0:	68 ca 00 00 00       	push   $0xca
  jmp __alltraps
  1025e5:	e9 7c 02 00 00       	jmp    102866 <__alltraps>

001025ea <vector203>:
.globl vector203
vector203:
  pushl $0
  1025ea:	6a 00                	push   $0x0
  pushl $203
  1025ec:	68 cb 00 00 00       	push   $0xcb
  jmp __alltraps
  1025f1:	e9 70 02 00 00       	jmp    102866 <__alltraps>

001025f6 <vector204>:
.globl vector204
vector204:
  pushl $0
  1025f6:	6a 00                	push   $0x0
  pushl $204
  1025f8:	68 cc 00 00 00       	push   $0xcc
  jmp __alltraps
  1025fd:	e9 64 02 00 00       	jmp    102866 <__alltraps>

00102602 <vector205>:
.globl vector205
vector205:
  pushl $0
  102602:	6a 00                	push   $0x0
  pushl $205
  102604:	68 cd 00 00 00       	push   $0xcd
  jmp __alltraps
  102609:	e9 58 02 00 00       	jmp    102866 <__alltraps>

0010260e <vector206>:
.globl vector206
vector206:
  pushl $0
  10260e:	6a 00                	push   $0x0
  pushl $206
  102610:	68 ce 00 00 00       	push   $0xce
  jmp __alltraps
  102615:	e9 4c 02 00 00       	jmp    102866 <__alltraps>

0010261a <vector207>:
.globl vector207
vector207:
  pushl $0
  10261a:	6a 00                	push   $0x0
  pushl $207
  10261c:	68 cf 00 00 00       	push   $0xcf
  jmp __alltraps
  102621:	e9 40 02 00 00       	jmp    102866 <__alltraps>

00102626 <vector208>:
.globl vector208
vector208:
  pushl $0
  102626:	6a 00                	push   $0x0
  pushl $208
  102628:	68 d0 00 00 00       	push   $0xd0
  jmp __alltraps
  10262d:	e9 34 02 00 00       	jmp    102866 <__alltraps>

00102632 <vector209>:
.globl vector209
vector209:
  pushl $0
  102632:	6a 00                	push   $0x0
  pushl $209
  102634:	68 d1 00 00 00       	push   $0xd1
  jmp __alltraps
  102639:	e9 28 02 00 00       	jmp    102866 <__alltraps>

0010263e <vector210>:
.globl vector210
vector210:
  pushl $0
  10263e:	6a 00                	push   $0x0
  pushl $210
  102640:	68 d2 00 00 00       	push   $0xd2
  jmp __alltraps
  102645:	e9 1c 02 00 00       	jmp    102866 <__alltraps>

0010264a <vector211>:
.globl vector211
vector211:
  pushl $0
  10264a:	6a 00                	push   $0x0
  pushl $211
  10264c:	68 d3 00 00 00       	push   $0xd3
  jmp __alltraps
  102651:	e9 10 02 00 00       	jmp    102866 <__alltraps>

00102656 <vector212>:
.globl vector212
vector212:
  pushl $0
  102656:	6a 00                	push   $0x0
  pushl $212
  102658:	68 d4 00 00 00       	push   $0xd4
  jmp __alltraps
  10265d:	e9 04 02 00 00       	jmp    102866 <__alltraps>

00102662 <vector213>:
.globl vector213
vector213:
  pushl $0
  102662:	6a 00                	push   $0x0
  pushl $213
  102664:	68 d5 00 00 00       	push   $0xd5
  jmp __alltraps
  102669:	e9 f8 01 00 00       	jmp    102866 <__alltraps>

0010266e <vector214>:
.globl vector214
vector214:
  pushl $0
  10266e:	6a 00                	push   $0x0
  pushl $214
  102670:	68 d6 00 00 00       	push   $0xd6
  jmp __alltraps
  102675:	e9 ec 01 00 00       	jmp    102866 <__alltraps>

0010267a <vector215>:
.globl vector215
vector215:
  pushl $0
  10267a:	6a 00                	push   $0x0
  pushl $215
  10267c:	68 d7 00 00 00       	push   $0xd7
  jmp __alltraps
  102681:	e9 e0 01 00 00       	jmp    102866 <__alltraps>

00102686 <vector216>:
.globl vector216
vector216:
  pushl $0
  102686:	6a 00                	push   $0x0
  pushl $216
  102688:	68 d8 00 00 00       	push   $0xd8
  jmp __alltraps
  10268d:	e9 d4 01 00 00       	jmp    102866 <__alltraps>

00102692 <vector217>:
.globl vector217
vector217:
  pushl $0
  102692:	6a 00                	push   $0x0
  pushl $217
  102694:	68 d9 00 00 00       	push   $0xd9
  jmp __alltraps
  102699:	e9 c8 01 00 00       	jmp    102866 <__alltraps>

0010269e <vector218>:
.globl vector218
vector218:
  pushl $0
  10269e:	6a 00                	push   $0x0
  pushl $218
  1026a0:	68 da 00 00 00       	push   $0xda
  jmp __alltraps
  1026a5:	e9 bc 01 00 00       	jmp    102866 <__alltraps>

001026aa <vector219>:
.globl vector219
vector219:
  pushl $0
  1026aa:	6a 00                	push   $0x0
  pushl $219
  1026ac:	68 db 00 00 00       	push   $0xdb
  jmp __alltraps
  1026b1:	e9 b0 01 00 00       	jmp    102866 <__alltraps>

001026b6 <vector220>:
.globl vector220
vector220:
  pushl $0
  1026b6:	6a 00                	push   $0x0
  pushl $220
  1026b8:	68 dc 00 00 00       	push   $0xdc
  jmp __alltraps
  1026bd:	e9 a4 01 00 00       	jmp    102866 <__alltraps>

001026c2 <vector221>:
.globl vector221
vector221:
  pushl $0
  1026c2:	6a 00                	push   $0x0
  pushl $221
  1026c4:	68 dd 00 00 00       	push   $0xdd
  jmp __alltraps
  1026c9:	e9 98 01 00 00       	jmp    102866 <__alltraps>

001026ce <vector222>:
.globl vector222
vector222:
  pushl $0
  1026ce:	6a 00                	push   $0x0
  pushl $222
  1026d0:	68 de 00 00 00       	push   $0xde
  jmp __alltraps
  1026d5:	e9 8c 01 00 00       	jmp    102866 <__alltraps>

001026da <vector223>:
.globl vector223
vector223:
  pushl $0
  1026da:	6a 00                	push   $0x0
  pushl $223
  1026dc:	68 df 00 00 00       	push   $0xdf
  jmp __alltraps
  1026e1:	e9 80 01 00 00       	jmp    102866 <__alltraps>

001026e6 <vector224>:
.globl vector224
vector224:
  pushl $0
  1026e6:	6a 00                	push   $0x0
  pushl $224
  1026e8:	68 e0 00 00 00       	push   $0xe0
  jmp __alltraps
  1026ed:	e9 74 01 00 00       	jmp    102866 <__alltraps>

001026f2 <vector225>:
.globl vector225
vector225:
  pushl $0
  1026f2:	6a 00                	push   $0x0
  pushl $225
  1026f4:	68 e1 00 00 00       	push   $0xe1
  jmp __alltraps
  1026f9:	e9 68 01 00 00       	jmp    102866 <__alltraps>

001026fe <vector226>:
.globl vector226
vector226:
  pushl $0
  1026fe:	6a 00                	push   $0x0
  pushl $226
  102700:	68 e2 00 00 00       	push   $0xe2
  jmp __alltraps
  102705:	e9 5c 01 00 00       	jmp    102866 <__alltraps>

0010270a <vector227>:
.globl vector227
vector227:
  pushl $0
  10270a:	6a 00                	push   $0x0
  pushl $227
  10270c:	68 e3 00 00 00       	push   $0xe3
  jmp __alltraps
  102711:	e9 50 01 00 00       	jmp    102866 <__alltraps>

00102716 <vector228>:
.globl vector228
vector228:
  pushl $0
  102716:	6a 00                	push   $0x0
  pushl $228
  102718:	68 e4 00 00 00       	push   $0xe4
  jmp __alltraps
  10271d:	e9 44 01 00 00       	jmp    102866 <__alltraps>

00102722 <vector229>:
.globl vector229
vector229:
  pushl $0
  102722:	6a 00                	push   $0x0
  pushl $229
  102724:	68 e5 00 00 00       	push   $0xe5
  jmp __alltraps
  102729:	e9 38 01 00 00       	jmp    102866 <__alltraps>

0010272e <vector230>:
.globl vector230
vector230:
  pushl $0
  10272e:	6a 00                	push   $0x0
  pushl $230
  102730:	68 e6 00 00 00       	push   $0xe6
  jmp __alltraps
  102735:	e9 2c 01 00 00       	jmp    102866 <__alltraps>

0010273a <vector231>:
.globl vector231
vector231:
  pushl $0
  10273a:	6a 00                	push   $0x0
  pushl $231
  10273c:	68 e7 00 00 00       	push   $0xe7
  jmp __alltraps
  102741:	e9 20 01 00 00       	jmp    102866 <__alltraps>

00102746 <vector232>:
.globl vector232
vector232:
  pushl $0
  102746:	6a 00                	push   $0x0
  pushl $232
  102748:	68 e8 00 00 00       	push   $0xe8
  jmp __alltraps
  10274d:	e9 14 01 00 00       	jmp    102866 <__alltraps>

00102752 <vector233>:
.globl vector233
vector233:
  pushl $0
  102752:	6a 00                	push   $0x0
  pushl $233
  102754:	68 e9 00 00 00       	push   $0xe9
  jmp __alltraps
  102759:	e9 08 01 00 00       	jmp    102866 <__alltraps>

0010275e <vector234>:
.globl vector234
vector234:
  pushl $0
  10275e:	6a 00                	push   $0x0
  pushl $234
  102760:	68 ea 00 00 00       	push   $0xea
  jmp __alltraps
  102765:	e9 fc 00 00 00       	jmp    102866 <__alltraps>

0010276a <vector235>:
.globl vector235
vector235:
  pushl $0
  10276a:	6a 00                	push   $0x0
  pushl $235
  10276c:	68 eb 00 00 00       	push   $0xeb
  jmp __alltraps
  102771:	e9 f0 00 00 00       	jmp    102866 <__alltraps>

00102776 <vector236>:
.globl vector236
vector236:
  pushl $0
  102776:	6a 00                	push   $0x0
  pushl $236
  102778:	68 ec 00 00 00       	push   $0xec
  jmp __alltraps
  10277d:	e9 e4 00 00 00       	jmp    102866 <__alltraps>

00102782 <vector237>:
.globl vector237
vector237:
  pushl $0
  102782:	6a 00                	push   $0x0
  pushl $237
  102784:	68 ed 00 00 00       	push   $0xed
  jmp __alltraps
  102789:	e9 d8 00 00 00       	jmp    102866 <__alltraps>

0010278e <vector238>:
.globl vector238
vector238:
  pushl $0
  10278e:	6a 00                	push   $0x0
  pushl $238
  102790:	68 ee 00 00 00       	push   $0xee
  jmp __alltraps
  102795:	e9 cc 00 00 00       	jmp    102866 <__alltraps>

0010279a <vector239>:
.globl vector239
vector239:
  pushl $0
  10279a:	6a 00                	push   $0x0
  pushl $239
  10279c:	68 ef 00 00 00       	push   $0xef
  jmp __alltraps
  1027a1:	e9 c0 00 00 00       	jmp    102866 <__alltraps>

001027a6 <vector240>:
.globl vector240
vector240:
  pushl $0
  1027a6:	6a 00                	push   $0x0
  pushl $240
  1027a8:	68 f0 00 00 00       	push   $0xf0
  jmp __alltraps
  1027ad:	e9 b4 00 00 00       	jmp    102866 <__alltraps>

001027b2 <vector241>:
.globl vector241
vector241:
  pushl $0
  1027b2:	6a 00                	push   $0x0
  pushl $241
  1027b4:	68 f1 00 00 00       	push   $0xf1
  jmp __alltraps
  1027b9:	e9 a8 00 00 00       	jmp    102866 <__alltraps>

001027be <vector242>:
.globl vector242
vector242:
  pushl $0
  1027be:	6a 00                	push   $0x0
  pushl $242
  1027c0:	68 f2 00 00 00       	push   $0xf2
  jmp __alltraps
  1027c5:	e9 9c 00 00 00       	jmp    102866 <__alltraps>

001027ca <vector243>:
.globl vector243
vector243:
  pushl $0
  1027ca:	6a 00                	push   $0x0
  pushl $243
  1027cc:	68 f3 00 00 00       	push   $0xf3
  jmp __alltraps
  1027d1:	e9 90 00 00 00       	jmp    102866 <__alltraps>

001027d6 <vector244>:
.globl vector244
vector244:
  pushl $0
  1027d6:	6a 00                	push   $0x0
  pushl $244
  1027d8:	68 f4 00 00 00       	push   $0xf4
  jmp __alltraps
  1027dd:	e9 84 00 00 00       	jmp    102866 <__alltraps>

001027e2 <vector245>:
.globl vector245
vector245:
  pushl $0
  1027e2:	6a 00                	push   $0x0
  pushl $245
  1027e4:	68 f5 00 00 00       	push   $0xf5
  jmp __alltraps
  1027e9:	e9 78 00 00 00       	jmp    102866 <__alltraps>

001027ee <vector246>:
.globl vector246
vector246:
  pushl $0
  1027ee:	6a 00                	push   $0x0
  pushl $246
  1027f0:	68 f6 00 00 00       	push   $0xf6
  jmp __alltraps
  1027f5:	e9 6c 00 00 00       	jmp    102866 <__alltraps>

001027fa <vector247>:
.globl vector247
vector247:
  pushl $0
  1027fa:	6a 00                	push   $0x0
  pushl $247
  1027fc:	68 f7 00 00 00       	push   $0xf7
  jmp __alltraps
  102801:	e9 60 00 00 00       	jmp    102866 <__alltraps>

00102806 <vector248>:
.globl vector248
vector248:
  pushl $0
  102806:	6a 00                	push   $0x0
  pushl $248
  102808:	68 f8 00 00 00       	push   $0xf8
  jmp __alltraps
  10280d:	e9 54 00 00 00       	jmp    102866 <__alltraps>

00102812 <vector249>:
.globl vector249
vector249:
  pushl $0
  102812:	6a 00                	push   $0x0
  pushl $249
  102814:	68 f9 00 00 00       	push   $0xf9
  jmp __alltraps
  102819:	e9 48 00 00 00       	jmp    102866 <__alltraps>

0010281e <vector250>:
.globl vector250
vector250:
  pushl $0
  10281e:	6a 00                	push   $0x0
  pushl $250
  102820:	68 fa 00 00 00       	push   $0xfa
  jmp __alltraps
  102825:	e9 3c 00 00 00       	jmp    102866 <__alltraps>

0010282a <vector251>:
.globl vector251
vector251:
  pushl $0
  10282a:	6a 00                	push   $0x0
  pushl $251
  10282c:	68 fb 00 00 00       	push   $0xfb
  jmp __alltraps
  102831:	e9 30 00 00 00       	jmp    102866 <__alltraps>

00102836 <vector252>:
.globl vector252
vector252:
  pushl $0
  102836:	6a 00                	push   $0x0
  pushl $252
  102838:	68 fc 00 00 00       	push   $0xfc
  jmp __alltraps
  10283d:	e9 24 00 00 00       	jmp    102866 <__alltraps>

00102842 <vector253>:
.globl vector253
vector253:
  pushl $0
  102842:	6a 00                	push   $0x0
  pushl $253
  102844:	68 fd 00 00 00       	push   $0xfd
  jmp __alltraps
  102849:	e9 18 00 00 00       	jmp    102866 <__alltraps>

0010284e <vector254>:
.globl vector254
vector254:
  pushl $0
  10284e:	6a 00                	push   $0x0
  pushl $254
  102850:	68 fe 00 00 00       	push   $0xfe
  jmp __alltraps
  102855:	e9 0c 00 00 00       	jmp    102866 <__alltraps>

0010285a <vector255>:
.globl vector255
vector255:
  pushl $0
  10285a:	6a 00                	push   $0x0
  pushl $255
  10285c:	68 ff 00 00 00       	push   $0xff
  jmp __alltraps
  102861:	e9 00 00 00 00       	jmp    102866 <__alltraps>

00102866 <__alltraps>:
.text
.globl __alltraps
__alltraps:
    # push registers to build a trap frame
    # therefore make the stack look like a struct trapframe
    pushl %ds
  102866:	1e                   	push   %ds
    pushl %es
  102867:	06                   	push   %es
    pushl %fs
  102868:	0f a0                	push   %fs
    pushl %gs
  10286a:	0f a8                	push   %gs
    pushal
  10286c:	60                   	pusha  

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
  10286d:	b8 10 00 00 00       	mov    $0x10,%eax
    movw %ax, %ds
  102872:	8e d8                	mov    %eax,%ds
    movw %ax, %es
  102874:	8e c0                	mov    %eax,%es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp
  102876:	54                   	push   %esp

    # call trap(tf), where tf=%esp
    call trap
  102877:	e8 61 f5 ff ff       	call   101ddd <trap>

    # pop the pushed stack pointer
    popl %esp
  10287c:	5c                   	pop    %esp

0010287d <__trapret>:

    # return falls through to trapret...
.globl __trapret
__trapret:
    # restore registers from stack
    popal
  10287d:	61                   	popa   

    # restore %ds, %es, %fs and %gs
    popl %gs
  10287e:	0f a9                	pop    %gs
    popl %fs
  102880:	0f a1                	pop    %fs
    popl %es
  102882:	07                   	pop    %es
    popl %ds
  102883:	1f                   	pop    %ds

    # get rid of the trap number and error code
    addl $0x8, %esp
  102884:	83 c4 08             	add    $0x8,%esp
    iret
  102887:	cf                   	iret   

00102888 <lgdt>:
/* *
 * lgdt - load the global descriptor table register and reset the
 * data/code segement registers for kernel.
 * */
static inline void
lgdt(struct pseudodesc *pd) {
  102888:	55                   	push   %ebp
  102889:	89 e5                	mov    %esp,%ebp
    asm volatile ("lgdt (%0)" :: "r" (pd));
  10288b:	8b 45 08             	mov    0x8(%ebp),%eax
  10288e:	0f 01 10             	lgdtl  (%eax)
    asm volatile ("movw %%ax, %%gs" :: "a" (USER_DS));
  102891:	b8 23 00 00 00       	mov    $0x23,%eax
  102896:	8e e8                	mov    %eax,%gs
    asm volatile ("movw %%ax, %%fs" :: "a" (USER_DS));
  102898:	b8 23 00 00 00       	mov    $0x23,%eax
  10289d:	8e e0                	mov    %eax,%fs
    asm volatile ("movw %%ax, %%es" :: "a" (KERNEL_DS));
  10289f:	b8 10 00 00 00       	mov    $0x10,%eax
  1028a4:	8e c0                	mov    %eax,%es
    asm volatile ("movw %%ax, %%ds" :: "a" (KERNEL_DS));
  1028a6:	b8 10 00 00 00       	mov    $0x10,%eax
  1028ab:	8e d8                	mov    %eax,%ds
    asm volatile ("movw %%ax, %%ss" :: "a" (KERNEL_DS));
  1028ad:	b8 10 00 00 00       	mov    $0x10,%eax
  1028b2:	8e d0                	mov    %eax,%ss
    // reload cs
    asm volatile ("ljmp %0, $1f\n 1:\n" :: "i" (KERNEL_CS));
  1028b4:	ea bb 28 10 00 08 00 	ljmp   $0x8,$0x1028bb
}
  1028bb:	90                   	nop
  1028bc:	5d                   	pop    %ebp
  1028bd:	c3                   	ret    

001028be <gdt_init>:
/* temporary kernel stack */
uint8_t stack0[1024];

/* gdt_init - initialize the default GDT and TSS */
static void
gdt_init(void) {
  1028be:	55                   	push   %ebp
  1028bf:	89 e5                	mov    %esp,%ebp
  1028c1:	83 ec 10             	sub    $0x10,%esp
    // Setup a TSS so that we can get the right stack when we trap from
    // user to the kernel. But not safe here, it's only a temporary value,
    // it will be set to KSTACKTOP in lab2.
    ts.ts_esp0 = (uint32_t)&stack0 + sizeof(stack0);
  1028c4:	b8 20 f9 10 00       	mov    $0x10f920,%eax
  1028c9:	05 00 04 00 00       	add    $0x400,%eax
  1028ce:	a3 a4 f8 10 00       	mov    %eax,0x10f8a4
    ts.ts_ss0 = KERNEL_DS;
  1028d3:	66 c7 05 a8 f8 10 00 	movw   $0x10,0x10f8a8
  1028da:	10 00 

    // initialize the TSS filed of the gdt
    gdt[SEG_TSS] = SEG16(STS_T32A, (uint32_t)&ts, sizeof(ts), DPL_KERNEL);
  1028dc:	66 c7 05 08 ea 10 00 	movw   $0x68,0x10ea08
  1028e3:	68 00 
  1028e5:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1028ea:	66 a3 0a ea 10 00    	mov    %ax,0x10ea0a
  1028f0:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  1028f5:	c1 e8 10             	shr    $0x10,%eax
  1028f8:	a2 0c ea 10 00       	mov    %al,0x10ea0c
  1028fd:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102904:	83 e0 f0             	and    $0xfffffff0,%eax
  102907:	83 c8 09             	or     $0x9,%eax
  10290a:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  10290f:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102916:	83 c8 10             	or     $0x10,%eax
  102919:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  10291e:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102925:	83 e0 9f             	and    $0xffffff9f,%eax
  102928:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  10292d:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  102934:	83 c8 80             	or     $0xffffff80,%eax
  102937:	a2 0d ea 10 00       	mov    %al,0x10ea0d
  10293c:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102943:	83 e0 f0             	and    $0xfffffff0,%eax
  102946:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  10294b:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102952:	83 e0 ef             	and    $0xffffffef,%eax
  102955:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  10295a:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102961:	83 e0 df             	and    $0xffffffdf,%eax
  102964:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102969:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  102970:	83 c8 40             	or     $0x40,%eax
  102973:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102978:	0f b6 05 0e ea 10 00 	movzbl 0x10ea0e,%eax
  10297f:	83 e0 7f             	and    $0x7f,%eax
  102982:	a2 0e ea 10 00       	mov    %al,0x10ea0e
  102987:	b8 a0 f8 10 00       	mov    $0x10f8a0,%eax
  10298c:	c1 e8 18             	shr    $0x18,%eax
  10298f:	a2 0f ea 10 00       	mov    %al,0x10ea0f
    gdt[SEG_TSS].sd_s = 0;
  102994:	0f b6 05 0d ea 10 00 	movzbl 0x10ea0d,%eax
  10299b:	83 e0 ef             	and    $0xffffffef,%eax
  10299e:	a2 0d ea 10 00       	mov    %al,0x10ea0d

    // reload all segment registers
    lgdt(&gdt_pd);
  1029a3:	68 10 ea 10 00       	push   $0x10ea10
  1029a8:	e8 db fe ff ff       	call   102888 <lgdt>
  1029ad:	83 c4 04             	add    $0x4,%esp
  1029b0:	66 c7 45 fe 28 00    	movw   $0x28,-0x2(%ebp)
}

static inline void
ltr(uint16_t sel) {
    asm volatile ("ltr %0" :: "r" (sel));
  1029b6:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
  1029ba:	0f 00 d8             	ltr    %ax

    // load the TSS
    ltr(GD_TSS);
}
  1029bd:	90                   	nop
  1029be:	c9                   	leave  
  1029bf:	c3                   	ret    

001029c0 <pmm_init>:

/* pmm_init - initialize the physical memory management */
void
pmm_init(void) {
  1029c0:	55                   	push   %ebp
  1029c1:	89 e5                	mov    %esp,%ebp
    gdt_init();
  1029c3:	e8 f6 fe ff ff       	call   1028be <gdt_init>
}
  1029c8:	90                   	nop
  1029c9:	5d                   	pop    %ebp
  1029ca:	c3                   	ret    

001029cb <strlen>:
 * @s:        the input string
 *
 * The strlen() function returns the length of string @s.
 * */
size_t
strlen(const char *s) {
  1029cb:	55                   	push   %ebp
  1029cc:	89 e5                	mov    %esp,%ebp
  1029ce:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1029d1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (*s ++ != '\0') {
  1029d8:	eb 04                	jmp    1029de <strlen+0x13>
        cnt ++;
  1029da:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (*s ++ != '\0') {
  1029de:	8b 45 08             	mov    0x8(%ebp),%eax
  1029e1:	8d 50 01             	lea    0x1(%eax),%edx
  1029e4:	89 55 08             	mov    %edx,0x8(%ebp)
  1029e7:	0f b6 00             	movzbl (%eax),%eax
  1029ea:	84 c0                	test   %al,%al
  1029ec:	75 ec                	jne    1029da <strlen+0xf>
    }
    return cnt;
  1029ee:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  1029f1:	c9                   	leave  
  1029f2:	c3                   	ret    

001029f3 <strnlen>:
 * The return value is strlen(s), if that is less than @len, or
 * @len if there is no '\0' character among the first @len characters
 * pointed by @s.
 * */
size_t
strnlen(const char *s, size_t len) {
  1029f3:	55                   	push   %ebp
  1029f4:	89 e5                	mov    %esp,%ebp
  1029f6:	83 ec 10             	sub    $0x10,%esp
    size_t cnt = 0;
  1029f9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102a00:	eb 04                	jmp    102a06 <strnlen+0x13>
        cnt ++;
  102a02:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    while (cnt < len && *s ++ != '\0') {
  102a06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102a09:	3b 45 0c             	cmp    0xc(%ebp),%eax
  102a0c:	73 10                	jae    102a1e <strnlen+0x2b>
  102a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  102a11:	8d 50 01             	lea    0x1(%eax),%edx
  102a14:	89 55 08             	mov    %edx,0x8(%ebp)
  102a17:	0f b6 00             	movzbl (%eax),%eax
  102a1a:	84 c0                	test   %al,%al
  102a1c:	75 e4                	jne    102a02 <strnlen+0xf>
    }
    return cnt;
  102a1e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  102a21:	c9                   	leave  
  102a22:	c3                   	ret    

00102a23 <strcpy>:
 * To avoid overflows, the size of array pointed by @dst should be long enough to
 * contain the same string as @src (including the terminating null character), and
 * should not overlap in memory with @src.
 * */
char *
strcpy(char *dst, const char *src) {
  102a23:	55                   	push   %ebp
  102a24:	89 e5                	mov    %esp,%ebp
  102a26:	57                   	push   %edi
  102a27:	56                   	push   %esi
  102a28:	83 ec 20             	sub    $0x20,%esp
  102a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  102a2e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102a31:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a34:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_STRCPY
#define __HAVE_ARCH_STRCPY
static inline char *
__strcpy(char *dst, const char *src) {
    int d0, d1, d2;
    asm volatile (
  102a37:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102a3a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102a3d:	89 d1                	mov    %edx,%ecx
  102a3f:	89 c2                	mov    %eax,%edx
  102a41:	89 ce                	mov    %ecx,%esi
  102a43:	89 d7                	mov    %edx,%edi
  102a45:	ac                   	lods   %ds:(%esi),%al
  102a46:	aa                   	stos   %al,%es:(%edi)
  102a47:	84 c0                	test   %al,%al
  102a49:	75 fa                	jne    102a45 <strcpy+0x22>
  102a4b:	89 fa                	mov    %edi,%edx
  102a4d:	89 f1                	mov    %esi,%ecx
  102a4f:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102a52:	89 55 e8             	mov    %edx,-0x18(%ebp)
  102a55:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            "stosb;"
            "testb %%al, %%al;"
            "jne 1b;"
            : "=&S" (d0), "=&D" (d1), "=&a" (d2)
            : "0" (src), "1" (dst) : "memory");
    return dst;
  102a58:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_STRCPY
    return __strcpy(dst, src);
  102a5b:	90                   	nop
    char *p = dst;
    while ((*p ++ = *src ++) != '\0')
        /* nothing */;
    return dst;
#endif /* __HAVE_ARCH_STRCPY */
}
  102a5c:	83 c4 20             	add    $0x20,%esp
  102a5f:	5e                   	pop    %esi
  102a60:	5f                   	pop    %edi
  102a61:	5d                   	pop    %ebp
  102a62:	c3                   	ret    

00102a63 <strncpy>:
 * @len:    maximum number of characters to be copied from @src
 *
 * The return value is @dst
 * */
char *
strncpy(char *dst, const char *src, size_t len) {
  102a63:	55                   	push   %ebp
  102a64:	89 e5                	mov    %esp,%ebp
  102a66:	83 ec 10             	sub    $0x10,%esp
    char *p = dst;
  102a69:	8b 45 08             	mov    0x8(%ebp),%eax
  102a6c:	89 45 fc             	mov    %eax,-0x4(%ebp)
    while (len > 0) {
  102a6f:	eb 21                	jmp    102a92 <strncpy+0x2f>
        if ((*p = *src) != '\0') {
  102a71:	8b 45 0c             	mov    0xc(%ebp),%eax
  102a74:	0f b6 10             	movzbl (%eax),%edx
  102a77:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102a7a:	88 10                	mov    %dl,(%eax)
  102a7c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102a7f:	0f b6 00             	movzbl (%eax),%eax
  102a82:	84 c0                	test   %al,%al
  102a84:	74 04                	je     102a8a <strncpy+0x27>
            src ++;
  102a86:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
        }
        p ++, len --;
  102a8a:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102a8e:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    while (len > 0) {
  102a92:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102a96:	75 d9                	jne    102a71 <strncpy+0xe>
    }
    return dst;
  102a98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102a9b:	c9                   	leave  
  102a9c:	c3                   	ret    

00102a9d <strcmp>:
 * - A value greater than zero indicates that the first character that does
 *   not match has a greater value in @s1 than in @s2;
 * - And a value less than zero indicates the opposite.
 * */
int
strcmp(const char *s1, const char *s2) {
  102a9d:	55                   	push   %ebp
  102a9e:	89 e5                	mov    %esp,%ebp
  102aa0:	57                   	push   %edi
  102aa1:	56                   	push   %esi
  102aa2:	83 ec 20             	sub    $0x20,%esp
  102aa5:	8b 45 08             	mov    0x8(%ebp),%eax
  102aa8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102aab:	8b 45 0c             	mov    0xc(%ebp),%eax
  102aae:	89 45 f0             	mov    %eax,-0x10(%ebp)
    asm volatile (
  102ab1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ab4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ab7:	89 d1                	mov    %edx,%ecx
  102ab9:	89 c2                	mov    %eax,%edx
  102abb:	89 ce                	mov    %ecx,%esi
  102abd:	89 d7                	mov    %edx,%edi
  102abf:	ac                   	lods   %ds:(%esi),%al
  102ac0:	ae                   	scas   %es:(%edi),%al
  102ac1:	75 08                	jne    102acb <strcmp+0x2e>
  102ac3:	84 c0                	test   %al,%al
  102ac5:	75 f8                	jne    102abf <strcmp+0x22>
  102ac7:	31 c0                	xor    %eax,%eax
  102ac9:	eb 04                	jmp    102acf <strcmp+0x32>
  102acb:	19 c0                	sbb    %eax,%eax
  102acd:	0c 01                	or     $0x1,%al
  102acf:	89 fa                	mov    %edi,%edx
  102ad1:	89 f1                	mov    %esi,%ecx
  102ad3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102ad6:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102ad9:	89 55 e4             	mov    %edx,-0x1c(%ebp)
    return ret;
  102adc:	8b 45 ec             	mov    -0x14(%ebp),%eax
#ifdef __HAVE_ARCH_STRCMP
    return __strcmp(s1, s2);
  102adf:	90                   	nop
    while (*s1 != '\0' && *s1 == *s2) {
        s1 ++, s2 ++;
    }
    return (int)((unsigned char)*s1 - (unsigned char)*s2);
#endif /* __HAVE_ARCH_STRCMP */
}
  102ae0:	83 c4 20             	add    $0x20,%esp
  102ae3:	5e                   	pop    %esi
  102ae4:	5f                   	pop    %edi
  102ae5:	5d                   	pop    %ebp
  102ae6:	c3                   	ret    

00102ae7 <strncmp>:
 * they are equal to each other, it continues with the following pairs until
 * the characters differ, until a terminating null-character is reached, or
 * until @n characters match in both strings, whichever happens first.
 * */
int
strncmp(const char *s1, const char *s2, size_t n) {
  102ae7:	55                   	push   %ebp
  102ae8:	89 e5                	mov    %esp,%ebp
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102aea:	eb 0c                	jmp    102af8 <strncmp+0x11>
        n --, s1 ++, s2 ++;
  102aec:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  102af0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102af4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
    while (n > 0 && *s1 != '\0' && *s1 == *s2) {
  102af8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102afc:	74 1a                	je     102b18 <strncmp+0x31>
  102afe:	8b 45 08             	mov    0x8(%ebp),%eax
  102b01:	0f b6 00             	movzbl (%eax),%eax
  102b04:	84 c0                	test   %al,%al
  102b06:	74 10                	je     102b18 <strncmp+0x31>
  102b08:	8b 45 08             	mov    0x8(%ebp),%eax
  102b0b:	0f b6 10             	movzbl (%eax),%edx
  102b0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b11:	0f b6 00             	movzbl (%eax),%eax
  102b14:	38 c2                	cmp    %al,%dl
  102b16:	74 d4                	je     102aec <strncmp+0x5>
    }
    return (n == 0) ? 0 : (int)((unsigned char)*s1 - (unsigned char)*s2);
  102b18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102b1c:	74 18                	je     102b36 <strncmp+0x4f>
  102b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  102b21:	0f b6 00             	movzbl (%eax),%eax
  102b24:	0f b6 d0             	movzbl %al,%edx
  102b27:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b2a:	0f b6 00             	movzbl (%eax),%eax
  102b2d:	0f b6 c0             	movzbl %al,%eax
  102b30:	29 c2                	sub    %eax,%edx
  102b32:	89 d0                	mov    %edx,%eax
  102b34:	eb 05                	jmp    102b3b <strncmp+0x54>
  102b36:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102b3b:	5d                   	pop    %ebp
  102b3c:	c3                   	ret    

00102b3d <strchr>:
 *
 * The strchr() function returns a pointer to the first occurrence of
 * character in @s. If the value is not found, the function returns 'NULL'.
 * */
char *
strchr(const char *s, char c) {
  102b3d:	55                   	push   %ebp
  102b3e:	89 e5                	mov    %esp,%ebp
  102b40:	83 ec 04             	sub    $0x4,%esp
  102b43:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b46:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102b49:	eb 14                	jmp    102b5f <strchr+0x22>
        if (*s == c) {
  102b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  102b4e:	0f b6 00             	movzbl (%eax),%eax
  102b51:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102b54:	75 05                	jne    102b5b <strchr+0x1e>
            return (char *)s;
  102b56:	8b 45 08             	mov    0x8(%ebp),%eax
  102b59:	eb 13                	jmp    102b6e <strchr+0x31>
        }
        s ++;
  102b5b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  102b62:	0f b6 00             	movzbl (%eax),%eax
  102b65:	84 c0                	test   %al,%al
  102b67:	75 e2                	jne    102b4b <strchr+0xe>
    }
    return NULL;
  102b69:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102b6e:	c9                   	leave  
  102b6f:	c3                   	ret    

00102b70 <strfind>:
 * The strfind() function is like strchr() except that if @c is
 * not found in @s, then it returns a pointer to the null byte at the
 * end of @s, rather than 'NULL'.
 * */
char *
strfind(const char *s, char c) {
  102b70:	55                   	push   %ebp
  102b71:	89 e5                	mov    %esp,%ebp
  102b73:	83 ec 04             	sub    $0x4,%esp
  102b76:	8b 45 0c             	mov    0xc(%ebp),%eax
  102b79:	88 45 fc             	mov    %al,-0x4(%ebp)
    while (*s != '\0') {
  102b7c:	eb 0f                	jmp    102b8d <strfind+0x1d>
        if (*s == c) {
  102b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  102b81:	0f b6 00             	movzbl (%eax),%eax
  102b84:	3a 45 fc             	cmp    -0x4(%ebp),%al
  102b87:	74 10                	je     102b99 <strfind+0x29>
            break;
        }
        s ++;
  102b89:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s != '\0') {
  102b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  102b90:	0f b6 00             	movzbl (%eax),%eax
  102b93:	84 c0                	test   %al,%al
  102b95:	75 e7                	jne    102b7e <strfind+0xe>
  102b97:	eb 01                	jmp    102b9a <strfind+0x2a>
            break;
  102b99:	90                   	nop
    }
    return (char *)s;
  102b9a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  102b9d:	c9                   	leave  
  102b9e:	c3                   	ret    

00102b9f <strtol>:
 * an optional "0x" or "0X" prefix.
 *
 * The strtol() function returns the converted integral number as a long int value.
 * */
long
strtol(const char *s, char **endptr, int base) {
  102b9f:	55                   	push   %ebp
  102ba0:	89 e5                	mov    %esp,%ebp
  102ba2:	83 ec 10             	sub    $0x10,%esp
    int neg = 0;
  102ba5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    long val = 0;
  102bac:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

    // gobble initial whitespace
    while (*s == ' ' || *s == '\t') {
  102bb3:	eb 04                	jmp    102bb9 <strtol+0x1a>
        s ++;
  102bb5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    while (*s == ' ' || *s == '\t') {
  102bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  102bbc:	0f b6 00             	movzbl (%eax),%eax
  102bbf:	3c 20                	cmp    $0x20,%al
  102bc1:	74 f2                	je     102bb5 <strtol+0x16>
  102bc3:	8b 45 08             	mov    0x8(%ebp),%eax
  102bc6:	0f b6 00             	movzbl (%eax),%eax
  102bc9:	3c 09                	cmp    $0x9,%al
  102bcb:	74 e8                	je     102bb5 <strtol+0x16>
    }

    // plus/minus sign
    if (*s == '+') {
  102bcd:	8b 45 08             	mov    0x8(%ebp),%eax
  102bd0:	0f b6 00             	movzbl (%eax),%eax
  102bd3:	3c 2b                	cmp    $0x2b,%al
  102bd5:	75 06                	jne    102bdd <strtol+0x3e>
        s ++;
  102bd7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102bdb:	eb 15                	jmp    102bf2 <strtol+0x53>
    }
    else if (*s == '-') {
  102bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  102be0:	0f b6 00             	movzbl (%eax),%eax
  102be3:	3c 2d                	cmp    $0x2d,%al
  102be5:	75 0b                	jne    102bf2 <strtol+0x53>
        s ++, neg = 1;
  102be7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102beb:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
    }

    // hex or octal base prefix
    if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x')) {
  102bf2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102bf6:	74 06                	je     102bfe <strtol+0x5f>
  102bf8:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  102bfc:	75 24                	jne    102c22 <strtol+0x83>
  102bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  102c01:	0f b6 00             	movzbl (%eax),%eax
  102c04:	3c 30                	cmp    $0x30,%al
  102c06:	75 1a                	jne    102c22 <strtol+0x83>
  102c08:	8b 45 08             	mov    0x8(%ebp),%eax
  102c0b:	83 c0 01             	add    $0x1,%eax
  102c0e:	0f b6 00             	movzbl (%eax),%eax
  102c11:	3c 78                	cmp    $0x78,%al
  102c13:	75 0d                	jne    102c22 <strtol+0x83>
        s += 2, base = 16;
  102c15:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  102c19:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  102c20:	eb 2a                	jmp    102c4c <strtol+0xad>
    }
    else if (base == 0 && s[0] == '0') {
  102c22:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c26:	75 17                	jne    102c3f <strtol+0xa0>
  102c28:	8b 45 08             	mov    0x8(%ebp),%eax
  102c2b:	0f b6 00             	movzbl (%eax),%eax
  102c2e:	3c 30                	cmp    $0x30,%al
  102c30:	75 0d                	jne    102c3f <strtol+0xa0>
        s ++, base = 8;
  102c32:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102c36:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  102c3d:	eb 0d                	jmp    102c4c <strtol+0xad>
    }
    else if (base == 0) {
  102c3f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  102c43:	75 07                	jne    102c4c <strtol+0xad>
        base = 10;
  102c45:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

    // digits
    while (1) {
        int dig;

        if (*s >= '0' && *s <= '9') {
  102c4c:	8b 45 08             	mov    0x8(%ebp),%eax
  102c4f:	0f b6 00             	movzbl (%eax),%eax
  102c52:	3c 2f                	cmp    $0x2f,%al
  102c54:	7e 1b                	jle    102c71 <strtol+0xd2>
  102c56:	8b 45 08             	mov    0x8(%ebp),%eax
  102c59:	0f b6 00             	movzbl (%eax),%eax
  102c5c:	3c 39                	cmp    $0x39,%al
  102c5e:	7f 11                	jg     102c71 <strtol+0xd2>
            dig = *s - '0';
  102c60:	8b 45 08             	mov    0x8(%ebp),%eax
  102c63:	0f b6 00             	movzbl (%eax),%eax
  102c66:	0f be c0             	movsbl %al,%eax
  102c69:	83 e8 30             	sub    $0x30,%eax
  102c6c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c6f:	eb 48                	jmp    102cb9 <strtol+0x11a>
        }
        else if (*s >= 'a' && *s <= 'z') {
  102c71:	8b 45 08             	mov    0x8(%ebp),%eax
  102c74:	0f b6 00             	movzbl (%eax),%eax
  102c77:	3c 60                	cmp    $0x60,%al
  102c79:	7e 1b                	jle    102c96 <strtol+0xf7>
  102c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  102c7e:	0f b6 00             	movzbl (%eax),%eax
  102c81:	3c 7a                	cmp    $0x7a,%al
  102c83:	7f 11                	jg     102c96 <strtol+0xf7>
            dig = *s - 'a' + 10;
  102c85:	8b 45 08             	mov    0x8(%ebp),%eax
  102c88:	0f b6 00             	movzbl (%eax),%eax
  102c8b:	0f be c0             	movsbl %al,%eax
  102c8e:	83 e8 57             	sub    $0x57,%eax
  102c91:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102c94:	eb 23                	jmp    102cb9 <strtol+0x11a>
        }
        else if (*s >= 'A' && *s <= 'Z') {
  102c96:	8b 45 08             	mov    0x8(%ebp),%eax
  102c99:	0f b6 00             	movzbl (%eax),%eax
  102c9c:	3c 40                	cmp    $0x40,%al
  102c9e:	7e 3c                	jle    102cdc <strtol+0x13d>
  102ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  102ca3:	0f b6 00             	movzbl (%eax),%eax
  102ca6:	3c 5a                	cmp    $0x5a,%al
  102ca8:	7f 32                	jg     102cdc <strtol+0x13d>
            dig = *s - 'A' + 10;
  102caa:	8b 45 08             	mov    0x8(%ebp),%eax
  102cad:	0f b6 00             	movzbl (%eax),%eax
  102cb0:	0f be c0             	movsbl %al,%eax
  102cb3:	83 e8 37             	sub    $0x37,%eax
  102cb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
        }
        else {
            break;
        }
        if (dig >= base) {
  102cb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102cbc:	3b 45 10             	cmp    0x10(%ebp),%eax
  102cbf:	7d 1a                	jge    102cdb <strtol+0x13c>
            break;
        }
        s ++, val = (val * base) + dig;
  102cc1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  102cc5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102cc8:	0f af 45 10          	imul   0x10(%ebp),%eax
  102ccc:	89 c2                	mov    %eax,%edx
  102cce:	8b 45 f4             	mov    -0xc(%ebp),%eax
  102cd1:	01 d0                	add    %edx,%eax
  102cd3:	89 45 f8             	mov    %eax,-0x8(%ebp)
        // we don't properly detect overflow!
    }
  102cd6:	e9 71 ff ff ff       	jmp    102c4c <strtol+0xad>
            break;
  102cdb:	90                   	nop

    if (endptr) {
  102cdc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102ce0:	74 08                	je     102cea <strtol+0x14b>
        *endptr = (char *) s;
  102ce2:	8b 45 0c             	mov    0xc(%ebp),%eax
  102ce5:	8b 55 08             	mov    0x8(%ebp),%edx
  102ce8:	89 10                	mov    %edx,(%eax)
    }
    return (neg ? -val : val);
  102cea:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  102cee:	74 07                	je     102cf7 <strtol+0x158>
  102cf0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102cf3:	f7 d8                	neg    %eax
  102cf5:	eb 03                	jmp    102cfa <strtol+0x15b>
  102cf7:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  102cfa:	c9                   	leave  
  102cfb:	c3                   	ret    

00102cfc <memset>:
 * @n:        number of bytes to be set to the value
 *
 * The memset() function returns @s.
 * */
void *
memset(void *s, char c, size_t n) {
  102cfc:	55                   	push   %ebp
  102cfd:	89 e5                	mov    %esp,%ebp
  102cff:	57                   	push   %edi
  102d00:	83 ec 24             	sub    $0x24,%esp
  102d03:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d06:	88 45 d8             	mov    %al,-0x28(%ebp)
#ifdef __HAVE_ARCH_MEMSET
    return __memset(s, c, n);
  102d09:	0f be 45 d8          	movsbl -0x28(%ebp),%eax
  102d0d:	8b 55 08             	mov    0x8(%ebp),%edx
  102d10:	89 55 f8             	mov    %edx,-0x8(%ebp)
  102d13:	88 45 f7             	mov    %al,-0x9(%ebp)
  102d16:	8b 45 10             	mov    0x10(%ebp),%eax
  102d19:	89 45 f0             	mov    %eax,-0x10(%ebp)
#ifndef __HAVE_ARCH_MEMSET
#define __HAVE_ARCH_MEMSET
static inline void *
__memset(void *s, char c, size_t n) {
    int d0, d1;
    asm volatile (
  102d1c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  102d1f:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
  102d23:	8b 55 f8             	mov    -0x8(%ebp),%edx
  102d26:	89 d7                	mov    %edx,%edi
  102d28:	f3 aa                	rep stos %al,%es:(%edi)
  102d2a:	89 fa                	mov    %edi,%edx
  102d2c:	89 4d ec             	mov    %ecx,-0x14(%ebp)
  102d2f:	89 55 e8             	mov    %edx,-0x18(%ebp)
            "rep; stosb;"
            : "=&c" (d0), "=&D" (d1)
            : "0" (n), "a" (c), "1" (s)
            : "memory");
    return s;
  102d32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102d35:	90                   	nop
    while (n -- > 0) {
        *p ++ = c;
    }
    return s;
#endif /* __HAVE_ARCH_MEMSET */
}
  102d36:	83 c4 24             	add    $0x24,%esp
  102d39:	5f                   	pop    %edi
  102d3a:	5d                   	pop    %ebp
  102d3b:	c3                   	ret    

00102d3c <memmove>:
 * @n:        number of bytes to copy
 *
 * The memmove() function returns @dst.
 * */
void *
memmove(void *dst, const void *src, size_t n) {
  102d3c:	55                   	push   %ebp
  102d3d:	89 e5                	mov    %esp,%ebp
  102d3f:	57                   	push   %edi
  102d40:	56                   	push   %esi
  102d41:	53                   	push   %ebx
  102d42:	83 ec 30             	sub    $0x30,%esp
  102d45:	8b 45 08             	mov    0x8(%ebp),%eax
  102d48:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102d4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102d4e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  102d51:	8b 45 10             	mov    0x10(%ebp),%eax
  102d54:	89 45 e8             	mov    %eax,-0x18(%ebp)

#ifndef __HAVE_ARCH_MEMMOVE
#define __HAVE_ARCH_MEMMOVE
static inline void *
__memmove(void *dst, const void *src, size_t n) {
    if (dst < src) {
  102d57:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d5a:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  102d5d:	73 42                	jae    102da1 <memmove+0x65>
  102d5f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102d62:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102d65:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102d68:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102d6b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102d6e:	89 45 dc             	mov    %eax,-0x24(%ebp)
            "andl $3, %%ecx;"
            "jz 1f;"
            "rep; movsb;"
            "1:"
            : "=&c" (d0), "=&D" (d1), "=&S" (d2)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102d71:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102d74:	c1 e8 02             	shr    $0x2,%eax
  102d77:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102d79:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  102d7c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102d7f:	89 d7                	mov    %edx,%edi
  102d81:	89 c6                	mov    %eax,%esi
  102d83:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102d85:	8b 4d dc             	mov    -0x24(%ebp),%ecx
  102d88:	83 e1 03             	and    $0x3,%ecx
  102d8b:	74 02                	je     102d8f <memmove+0x53>
  102d8d:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102d8f:	89 f0                	mov    %esi,%eax
  102d91:	89 fa                	mov    %edi,%edx
  102d93:	89 4d d8             	mov    %ecx,-0x28(%ebp)
  102d96:	89 55 d4             	mov    %edx,-0x2c(%ebp)
  102d99:	89 45 d0             	mov    %eax,-0x30(%ebp)
            : "memory");
    return dst;
  102d9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
#ifdef __HAVE_ARCH_MEMMOVE
    return __memmove(dst, src, n);
  102d9f:	eb 36                	jmp    102dd7 <memmove+0x9b>
            : "0" (n), "1" (n - 1 + src), "2" (n - 1 + dst)
  102da1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102da4:	8d 50 ff             	lea    -0x1(%eax),%edx
  102da7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102daa:	01 c2                	add    %eax,%edx
  102dac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102daf:	8d 48 ff             	lea    -0x1(%eax),%ecx
  102db2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102db5:	8d 1c 01             	lea    (%ecx,%eax,1),%ebx
    asm volatile (
  102db8:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102dbb:	89 c1                	mov    %eax,%ecx
  102dbd:	89 d8                	mov    %ebx,%eax
  102dbf:	89 d6                	mov    %edx,%esi
  102dc1:	89 c7                	mov    %eax,%edi
  102dc3:	fd                   	std    
  102dc4:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102dc6:	fc                   	cld    
  102dc7:	89 f8                	mov    %edi,%eax
  102dc9:	89 f2                	mov    %esi,%edx
  102dcb:	89 4d cc             	mov    %ecx,-0x34(%ebp)
  102dce:	89 55 c8             	mov    %edx,-0x38(%ebp)
  102dd1:	89 45 c4             	mov    %eax,-0x3c(%ebp)
    return dst;
  102dd4:	8b 45 f0             	mov    -0x10(%ebp),%eax
            *d ++ = *s ++;
        }
    }
    return dst;
#endif /* __HAVE_ARCH_MEMMOVE */
}
  102dd7:	83 c4 30             	add    $0x30,%esp
  102dda:	5b                   	pop    %ebx
  102ddb:	5e                   	pop    %esi
  102ddc:	5f                   	pop    %edi
  102ddd:	5d                   	pop    %ebp
  102dde:	c3                   	ret    

00102ddf <memcpy>:
 * it always copies exactly @n bytes. To avoid overflows, the size of arrays pointed
 * by both @src and @dst, should be at least @n bytes, and should not overlap
 * (for overlapping memory area, memmove is a safer approach).
 * */
void *
memcpy(void *dst, const void *src, size_t n) {
  102ddf:	55                   	push   %ebp
  102de0:	89 e5                	mov    %esp,%ebp
  102de2:	57                   	push   %edi
  102de3:	56                   	push   %esi
  102de4:	83 ec 20             	sub    $0x20,%esp
  102de7:	8b 45 08             	mov    0x8(%ebp),%eax
  102dea:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ded:	8b 45 0c             	mov    0xc(%ebp),%eax
  102df0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102df3:	8b 45 10             	mov    0x10(%ebp),%eax
  102df6:	89 45 ec             	mov    %eax,-0x14(%ebp)
            : "0" (n / 4), "g" (n), "1" (dst), "2" (src)
  102df9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  102dfc:	c1 e8 02             	shr    $0x2,%eax
  102dff:	89 c1                	mov    %eax,%ecx
    asm volatile (
  102e01:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102e04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102e07:	89 d7                	mov    %edx,%edi
  102e09:	89 c6                	mov    %eax,%esi
  102e0b:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
  102e0d:	8b 4d ec             	mov    -0x14(%ebp),%ecx
  102e10:	83 e1 03             	and    $0x3,%ecx
  102e13:	74 02                	je     102e17 <memcpy+0x38>
  102e15:	f3 a4                	rep movsb %ds:(%esi),%es:(%edi)
  102e17:	89 f0                	mov    %esi,%eax
  102e19:	89 fa                	mov    %edi,%edx
  102e1b:	89 4d e8             	mov    %ecx,-0x18(%ebp)
  102e1e:	89 55 e4             	mov    %edx,-0x1c(%ebp)
  102e21:	89 45 e0             	mov    %eax,-0x20(%ebp)
    return dst;
  102e24:	8b 45 f4             	mov    -0xc(%ebp),%eax
#ifdef __HAVE_ARCH_MEMCPY
    return __memcpy(dst, src, n);
  102e27:	90                   	nop
    while (n -- > 0) {
        *d ++ = *s ++;
    }
    return dst;
#endif /* __HAVE_ARCH_MEMCPY */
}
  102e28:	83 c4 20             	add    $0x20,%esp
  102e2b:	5e                   	pop    %esi
  102e2c:	5f                   	pop    %edi
  102e2d:	5d                   	pop    %ebp
  102e2e:	c3                   	ret    

00102e2f <memcmp>:
 *   match in both memory blocks has a greater value in @v1 than in @v2
 *   as if evaluated as unsigned char values;
 * - And a value less than zero indicates the opposite.
 * */
int
memcmp(const void *v1, const void *v2, size_t n) {
  102e2f:	55                   	push   %ebp
  102e30:	89 e5                	mov    %esp,%ebp
  102e32:	83 ec 10             	sub    $0x10,%esp
    const char *s1 = (const char *)v1;
  102e35:	8b 45 08             	mov    0x8(%ebp),%eax
  102e38:	89 45 fc             	mov    %eax,-0x4(%ebp)
    const char *s2 = (const char *)v2;
  102e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  102e3e:	89 45 f8             	mov    %eax,-0x8(%ebp)
    while (n -- > 0) {
  102e41:	eb 30                	jmp    102e73 <memcmp+0x44>
        if (*s1 != *s2) {
  102e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e46:	0f b6 10             	movzbl (%eax),%edx
  102e49:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e4c:	0f b6 00             	movzbl (%eax),%eax
  102e4f:	38 c2                	cmp    %al,%dl
  102e51:	74 18                	je     102e6b <memcmp+0x3c>
            return (int)((unsigned char)*s1 - (unsigned char)*s2);
  102e53:	8b 45 fc             	mov    -0x4(%ebp),%eax
  102e56:	0f b6 00             	movzbl (%eax),%eax
  102e59:	0f b6 d0             	movzbl %al,%edx
  102e5c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  102e5f:	0f b6 00             	movzbl (%eax),%eax
  102e62:	0f b6 c0             	movzbl %al,%eax
  102e65:	29 c2                	sub    %eax,%edx
  102e67:	89 d0                	mov    %edx,%eax
  102e69:	eb 1a                	jmp    102e85 <memcmp+0x56>
        }
        s1 ++, s2 ++;
  102e6b:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  102e6f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    while (n -- > 0) {
  102e73:	8b 45 10             	mov    0x10(%ebp),%eax
  102e76:	8d 50 ff             	lea    -0x1(%eax),%edx
  102e79:	89 55 10             	mov    %edx,0x10(%ebp)
  102e7c:	85 c0                	test   %eax,%eax
  102e7e:	75 c3                	jne    102e43 <memcmp+0x14>
    }
    return 0;
  102e80:	b8 00 00 00 00       	mov    $0x0,%eax
}
  102e85:	c9                   	leave  
  102e86:	c3                   	ret    

00102e87 <printnum>:
 * @width:         maximum number of digits, if the actual width is less than @width, use @padc instead
 * @padc:        character that padded on the left if the actual width is less than @width
 * */
static void
printnum(void (*putch)(int, void*), void *putdat,
        unsigned long long num, unsigned base, int width, int padc) {
  102e87:	55                   	push   %ebp
  102e88:	89 e5                	mov    %esp,%ebp
  102e8a:	83 ec 38             	sub    $0x38,%esp
  102e8d:	8b 45 10             	mov    0x10(%ebp),%eax
  102e90:	89 45 d0             	mov    %eax,-0x30(%ebp)
  102e93:	8b 45 14             	mov    0x14(%ebp),%eax
  102e96:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    unsigned long long result = num;
  102e99:	8b 45 d0             	mov    -0x30(%ebp),%eax
  102e9c:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  102e9f:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102ea2:	89 55 ec             	mov    %edx,-0x14(%ebp)
    unsigned mod = do_div(result, base);
  102ea5:	8b 45 18             	mov    0x18(%ebp),%eax
  102ea8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  102eab:	8b 45 e8             	mov    -0x18(%ebp),%eax
  102eae:	8b 55 ec             	mov    -0x14(%ebp),%edx
  102eb1:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102eb4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  102eb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102eba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  102ebd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  102ec1:	74 1c                	je     102edf <printnum+0x58>
  102ec3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ec6:	ba 00 00 00 00       	mov    $0x0,%edx
  102ecb:	f7 75 e4             	divl   -0x1c(%ebp)
  102ece:	89 55 f4             	mov    %edx,-0xc(%ebp)
  102ed1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  102ed4:	ba 00 00 00 00       	mov    $0x0,%edx
  102ed9:	f7 75 e4             	divl   -0x1c(%ebp)
  102edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  102edf:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ee2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  102ee5:	f7 75 e4             	divl   -0x1c(%ebp)
  102ee8:	89 45 e0             	mov    %eax,-0x20(%ebp)
  102eeb:	89 55 dc             	mov    %edx,-0x24(%ebp)
  102eee:	8b 45 e0             	mov    -0x20(%ebp),%eax
  102ef1:	8b 55 f0             	mov    -0x10(%ebp),%edx
  102ef4:	89 45 e8             	mov    %eax,-0x18(%ebp)
  102ef7:	89 55 ec             	mov    %edx,-0x14(%ebp)
  102efa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  102efd:	89 45 d8             	mov    %eax,-0x28(%ebp)

    // first recursively print all preceding (more significant) digits
    if (num >= base) {
  102f00:	8b 45 18             	mov    0x18(%ebp),%eax
  102f03:	ba 00 00 00 00       	mov    $0x0,%edx
  102f08:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102f0b:	77 41                	ja     102f4e <printnum+0xc7>
  102f0d:	3b 55 d4             	cmp    -0x2c(%ebp),%edx
  102f10:	72 05                	jb     102f17 <printnum+0x90>
  102f12:	3b 45 d0             	cmp    -0x30(%ebp),%eax
  102f15:	77 37                	ja     102f4e <printnum+0xc7>
        printnum(putch, putdat, result, base, width - 1, padc);
  102f17:	8b 45 1c             	mov    0x1c(%ebp),%eax
  102f1a:	83 e8 01             	sub    $0x1,%eax
  102f1d:	83 ec 04             	sub    $0x4,%esp
  102f20:	ff 75 20             	pushl  0x20(%ebp)
  102f23:	50                   	push   %eax
  102f24:	ff 75 18             	pushl  0x18(%ebp)
  102f27:	ff 75 ec             	pushl  -0x14(%ebp)
  102f2a:	ff 75 e8             	pushl  -0x18(%ebp)
  102f2d:	ff 75 0c             	pushl  0xc(%ebp)
  102f30:	ff 75 08             	pushl  0x8(%ebp)
  102f33:	e8 4f ff ff ff       	call   102e87 <printnum>
  102f38:	83 c4 20             	add    $0x20,%esp
  102f3b:	eb 1b                	jmp    102f58 <printnum+0xd1>
    } else {
        // print any needed pad characters before first digit
        while (-- width > 0)
            putch(padc, putdat);
  102f3d:	83 ec 08             	sub    $0x8,%esp
  102f40:	ff 75 0c             	pushl  0xc(%ebp)
  102f43:	ff 75 20             	pushl  0x20(%ebp)
  102f46:	8b 45 08             	mov    0x8(%ebp),%eax
  102f49:	ff d0                	call   *%eax
  102f4b:	83 c4 10             	add    $0x10,%esp
        while (-- width > 0)
  102f4e:	83 6d 1c 01          	subl   $0x1,0x1c(%ebp)
  102f52:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  102f56:	7f e5                	jg     102f3d <printnum+0xb6>
    }
    // then print this (the least significant) digit
    putch("0123456789abcdef"[mod], putdat);
  102f58:	8b 45 d8             	mov    -0x28(%ebp),%eax
  102f5b:	05 50 3c 10 00       	add    $0x103c50,%eax
  102f60:	0f b6 00             	movzbl (%eax),%eax
  102f63:	0f be c0             	movsbl %al,%eax
  102f66:	83 ec 08             	sub    $0x8,%esp
  102f69:	ff 75 0c             	pushl  0xc(%ebp)
  102f6c:	50                   	push   %eax
  102f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  102f70:	ff d0                	call   *%eax
  102f72:	83 c4 10             	add    $0x10,%esp
}
  102f75:	90                   	nop
  102f76:	c9                   	leave  
  102f77:	c3                   	ret    

00102f78 <getuint>:
 * getuint - get an unsigned int of various possible sizes from a varargs list
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static unsigned long long
getuint(va_list *ap, int lflag) {
  102f78:	55                   	push   %ebp
  102f79:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102f7b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102f7f:	7e 14                	jle    102f95 <getuint+0x1d>
        return va_arg(*ap, unsigned long long);
  102f81:	8b 45 08             	mov    0x8(%ebp),%eax
  102f84:	8b 00                	mov    (%eax),%eax
  102f86:	8d 48 08             	lea    0x8(%eax),%ecx
  102f89:	8b 55 08             	mov    0x8(%ebp),%edx
  102f8c:	89 0a                	mov    %ecx,(%edx)
  102f8e:	8b 50 04             	mov    0x4(%eax),%edx
  102f91:	8b 00                	mov    (%eax),%eax
  102f93:	eb 30                	jmp    102fc5 <getuint+0x4d>
    }
    else if (lflag) {
  102f95:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102f99:	74 16                	je     102fb1 <getuint+0x39>
        return va_arg(*ap, unsigned long);
  102f9b:	8b 45 08             	mov    0x8(%ebp),%eax
  102f9e:	8b 00                	mov    (%eax),%eax
  102fa0:	8d 48 04             	lea    0x4(%eax),%ecx
  102fa3:	8b 55 08             	mov    0x8(%ebp),%edx
  102fa6:	89 0a                	mov    %ecx,(%edx)
  102fa8:	8b 00                	mov    (%eax),%eax
  102faa:	ba 00 00 00 00       	mov    $0x0,%edx
  102faf:	eb 14                	jmp    102fc5 <getuint+0x4d>
    }
    else {
        return va_arg(*ap, unsigned int);
  102fb1:	8b 45 08             	mov    0x8(%ebp),%eax
  102fb4:	8b 00                	mov    (%eax),%eax
  102fb6:	8d 48 04             	lea    0x4(%eax),%ecx
  102fb9:	8b 55 08             	mov    0x8(%ebp),%edx
  102fbc:	89 0a                	mov    %ecx,(%edx)
  102fbe:	8b 00                	mov    (%eax),%eax
  102fc0:	ba 00 00 00 00       	mov    $0x0,%edx
    }
}
  102fc5:	5d                   	pop    %ebp
  102fc6:	c3                   	ret    

00102fc7 <getint>:
 * getint - same as getuint but signed, we can't use getuint because of sign extension
 * @ap:            a varargs list pointer
 * @lflag:        determines the size of the vararg that @ap points to
 * */
static long long
getint(va_list *ap, int lflag) {
  102fc7:	55                   	push   %ebp
  102fc8:	89 e5                	mov    %esp,%ebp
    if (lflag >= 2) {
  102fca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  102fce:	7e 14                	jle    102fe4 <getint+0x1d>
        return va_arg(*ap, long long);
  102fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  102fd3:	8b 00                	mov    (%eax),%eax
  102fd5:	8d 48 08             	lea    0x8(%eax),%ecx
  102fd8:	8b 55 08             	mov    0x8(%ebp),%edx
  102fdb:	89 0a                	mov    %ecx,(%edx)
  102fdd:	8b 50 04             	mov    0x4(%eax),%edx
  102fe0:	8b 00                	mov    (%eax),%eax
  102fe2:	eb 28                	jmp    10300c <getint+0x45>
    }
    else if (lflag) {
  102fe4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  102fe8:	74 12                	je     102ffc <getint+0x35>
        return va_arg(*ap, long);
  102fea:	8b 45 08             	mov    0x8(%ebp),%eax
  102fed:	8b 00                	mov    (%eax),%eax
  102fef:	8d 48 04             	lea    0x4(%eax),%ecx
  102ff2:	8b 55 08             	mov    0x8(%ebp),%edx
  102ff5:	89 0a                	mov    %ecx,(%edx)
  102ff7:	8b 00                	mov    (%eax),%eax
  102ff9:	99                   	cltd   
  102ffa:	eb 10                	jmp    10300c <getint+0x45>
    }
    else {
        return va_arg(*ap, int);
  102ffc:	8b 45 08             	mov    0x8(%ebp),%eax
  102fff:	8b 00                	mov    (%eax),%eax
  103001:	8d 48 04             	lea    0x4(%eax),%ecx
  103004:	8b 55 08             	mov    0x8(%ebp),%edx
  103007:	89 0a                	mov    %ecx,(%edx)
  103009:	8b 00                	mov    (%eax),%eax
  10300b:	99                   	cltd   
    }
}
  10300c:	5d                   	pop    %ebp
  10300d:	c3                   	ret    

0010300e <printfmt>:
 * @putch:        specified putch function, print a single character
 * @putdat:        used by @putch function
 * @fmt:        the format string to use
 * */
void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...) {
  10300e:	55                   	push   %ebp
  10300f:	89 e5                	mov    %esp,%ebp
  103011:	83 ec 18             	sub    $0x18,%esp
    va_list ap;

    va_start(ap, fmt);
  103014:	8d 45 14             	lea    0x14(%ebp),%eax
  103017:	89 45 f4             	mov    %eax,-0xc(%ebp)
    vprintfmt(putch, putdat, fmt, ap);
  10301a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  10301d:	50                   	push   %eax
  10301e:	ff 75 10             	pushl  0x10(%ebp)
  103021:	ff 75 0c             	pushl  0xc(%ebp)
  103024:	ff 75 08             	pushl  0x8(%ebp)
  103027:	e8 06 00 00 00       	call   103032 <vprintfmt>
  10302c:	83 c4 10             	add    $0x10,%esp
    va_end(ap);
}
  10302f:	90                   	nop
  103030:	c9                   	leave  
  103031:	c3                   	ret    

00103032 <vprintfmt>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want printfmt() instead.
 * */
void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap) {
  103032:	55                   	push   %ebp
  103033:	89 e5                	mov    %esp,%ebp
  103035:	56                   	push   %esi
  103036:	53                   	push   %ebx
  103037:	83 ec 20             	sub    $0x20,%esp
    register int ch, err;
    unsigned long long num;
    int base, width, precision, lflag, altflag;

    while (1) {
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  10303a:	eb 17                	jmp    103053 <vprintfmt+0x21>
            if (ch == '\0') {
  10303c:	85 db                	test   %ebx,%ebx
  10303e:	0f 84 8e 03 00 00    	je     1033d2 <vprintfmt+0x3a0>
                return;
            }
            putch(ch, putdat);
  103044:	83 ec 08             	sub    $0x8,%esp
  103047:	ff 75 0c             	pushl  0xc(%ebp)
  10304a:	53                   	push   %ebx
  10304b:	8b 45 08             	mov    0x8(%ebp),%eax
  10304e:	ff d0                	call   *%eax
  103050:	83 c4 10             	add    $0x10,%esp
        while ((ch = *(unsigned char *)fmt ++) != '%') {
  103053:	8b 45 10             	mov    0x10(%ebp),%eax
  103056:	8d 50 01             	lea    0x1(%eax),%edx
  103059:	89 55 10             	mov    %edx,0x10(%ebp)
  10305c:	0f b6 00             	movzbl (%eax),%eax
  10305f:	0f b6 d8             	movzbl %al,%ebx
  103062:	83 fb 25             	cmp    $0x25,%ebx
  103065:	75 d5                	jne    10303c <vprintfmt+0xa>
        }

        // Process a %-escape sequence
        char padc = ' ';
  103067:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
        width = precision = -1;
  10306b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
  103072:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103075:	89 45 e8             	mov    %eax,-0x18(%ebp)
        lflag = altflag = 0;
  103078:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  10307f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  103082:	89 45 e0             	mov    %eax,-0x20(%ebp)

    reswitch:
        switch (ch = *(unsigned char *)fmt ++) {
  103085:	8b 45 10             	mov    0x10(%ebp),%eax
  103088:	8d 50 01             	lea    0x1(%eax),%edx
  10308b:	89 55 10             	mov    %edx,0x10(%ebp)
  10308e:	0f b6 00             	movzbl (%eax),%eax
  103091:	0f b6 d8             	movzbl %al,%ebx
  103094:	8d 43 dd             	lea    -0x23(%ebx),%eax
  103097:	83 f8 55             	cmp    $0x55,%eax
  10309a:	0f 87 05 03 00 00    	ja     1033a5 <vprintfmt+0x373>
  1030a0:	8b 04 85 74 3c 10 00 	mov    0x103c74(,%eax,4),%eax
  1030a7:	ff e0                	jmp    *%eax

        // flag to pad on the right
        case '-':
            padc = '-';
  1030a9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
            goto reswitch;
  1030ad:	eb d6                	jmp    103085 <vprintfmt+0x53>

        // flag to pad with 0's instead of spaces
        case '0':
            padc = '0';
  1030af:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
            goto reswitch;
  1030b3:	eb d0                	jmp    103085 <vprintfmt+0x53>

        // width field
        case '1' ... '9':
            for (precision = 0; ; ++ fmt) {
  1030b5:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
                precision = precision * 10 + ch - '0';
  1030bc:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  1030bf:	89 d0                	mov    %edx,%eax
  1030c1:	c1 e0 02             	shl    $0x2,%eax
  1030c4:	01 d0                	add    %edx,%eax
  1030c6:	01 c0                	add    %eax,%eax
  1030c8:	01 d8                	add    %ebx,%eax
  1030ca:	83 e8 30             	sub    $0x30,%eax
  1030cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
                ch = *fmt;
  1030d0:	8b 45 10             	mov    0x10(%ebp),%eax
  1030d3:	0f b6 00             	movzbl (%eax),%eax
  1030d6:	0f be d8             	movsbl %al,%ebx
                if (ch < '0' || ch > '9') {
  1030d9:	83 fb 2f             	cmp    $0x2f,%ebx
  1030dc:	7e 39                	jle    103117 <vprintfmt+0xe5>
  1030de:	83 fb 39             	cmp    $0x39,%ebx
  1030e1:	7f 34                	jg     103117 <vprintfmt+0xe5>
            for (precision = 0; ; ++ fmt) {
  1030e3:	83 45 10 01          	addl   $0x1,0x10(%ebp)
                    break;
                }
            }
  1030e7:	eb d3                	jmp    1030bc <vprintfmt+0x8a>
            goto process_precision;

        case '*':
            precision = va_arg(ap, int);
  1030e9:	8b 45 14             	mov    0x14(%ebp),%eax
  1030ec:	8d 50 04             	lea    0x4(%eax),%edx
  1030ef:	89 55 14             	mov    %edx,0x14(%ebp)
  1030f2:	8b 00                	mov    (%eax),%eax
  1030f4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
            goto process_precision;
  1030f7:	eb 1f                	jmp    103118 <vprintfmt+0xe6>

        case '.':
            if (width < 0)
  1030f9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1030fd:	79 86                	jns    103085 <vprintfmt+0x53>
                width = 0;
  1030ff:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
            goto reswitch;
  103106:	e9 7a ff ff ff       	jmp    103085 <vprintfmt+0x53>

        case '#':
            altflag = 1;
  10310b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
            goto reswitch;
  103112:	e9 6e ff ff ff       	jmp    103085 <vprintfmt+0x53>
            goto process_precision;
  103117:	90                   	nop

        process_precision:
            if (width < 0)
  103118:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  10311c:	0f 89 63 ff ff ff    	jns    103085 <vprintfmt+0x53>
                width = precision, precision = -1;
  103122:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  103125:	89 45 e8             	mov    %eax,-0x18(%ebp)
  103128:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
            goto reswitch;
  10312f:	e9 51 ff ff ff       	jmp    103085 <vprintfmt+0x53>

        // long flag (doubled for long long)
        case 'l':
            lflag ++;
  103134:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
            goto reswitch;
  103138:	e9 48 ff ff ff       	jmp    103085 <vprintfmt+0x53>

        // character
        case 'c':
            putch(va_arg(ap, int), putdat);
  10313d:	8b 45 14             	mov    0x14(%ebp),%eax
  103140:	8d 50 04             	lea    0x4(%eax),%edx
  103143:	89 55 14             	mov    %edx,0x14(%ebp)
  103146:	8b 00                	mov    (%eax),%eax
  103148:	83 ec 08             	sub    $0x8,%esp
  10314b:	ff 75 0c             	pushl  0xc(%ebp)
  10314e:	50                   	push   %eax
  10314f:	8b 45 08             	mov    0x8(%ebp),%eax
  103152:	ff d0                	call   *%eax
  103154:	83 c4 10             	add    $0x10,%esp
            break;
  103157:	e9 71 02 00 00       	jmp    1033cd <vprintfmt+0x39b>

        // error message
        case 'e':
            err = va_arg(ap, int);
  10315c:	8b 45 14             	mov    0x14(%ebp),%eax
  10315f:	8d 50 04             	lea    0x4(%eax),%edx
  103162:	89 55 14             	mov    %edx,0x14(%ebp)
  103165:	8b 18                	mov    (%eax),%ebx
            if (err < 0) {
  103167:	85 db                	test   %ebx,%ebx
  103169:	79 02                	jns    10316d <vprintfmt+0x13b>
                err = -err;
  10316b:	f7 db                	neg    %ebx
            }
            if (err > MAXERROR || (p = error_string[err]) == NULL) {
  10316d:	83 fb 06             	cmp    $0x6,%ebx
  103170:	7f 0b                	jg     10317d <vprintfmt+0x14b>
  103172:	8b 34 9d 34 3c 10 00 	mov    0x103c34(,%ebx,4),%esi
  103179:	85 f6                	test   %esi,%esi
  10317b:	75 19                	jne    103196 <vprintfmt+0x164>
                printfmt(putch, putdat, "error %d", err);
  10317d:	53                   	push   %ebx
  10317e:	68 61 3c 10 00       	push   $0x103c61
  103183:	ff 75 0c             	pushl  0xc(%ebp)
  103186:	ff 75 08             	pushl  0x8(%ebp)
  103189:	e8 80 fe ff ff       	call   10300e <printfmt>
  10318e:	83 c4 10             	add    $0x10,%esp
            }
            else {
                printfmt(putch, putdat, "%s", p);
            }
            break;
  103191:	e9 37 02 00 00       	jmp    1033cd <vprintfmt+0x39b>
                printfmt(putch, putdat, "%s", p);
  103196:	56                   	push   %esi
  103197:	68 6a 3c 10 00       	push   $0x103c6a
  10319c:	ff 75 0c             	pushl  0xc(%ebp)
  10319f:	ff 75 08             	pushl  0x8(%ebp)
  1031a2:	e8 67 fe ff ff       	call   10300e <printfmt>
  1031a7:	83 c4 10             	add    $0x10,%esp
            break;
  1031aa:	e9 1e 02 00 00       	jmp    1033cd <vprintfmt+0x39b>

        // string
        case 's':
            if ((p = va_arg(ap, char *)) == NULL) {
  1031af:	8b 45 14             	mov    0x14(%ebp),%eax
  1031b2:	8d 50 04             	lea    0x4(%eax),%edx
  1031b5:	89 55 14             	mov    %edx,0x14(%ebp)
  1031b8:	8b 30                	mov    (%eax),%esi
  1031ba:	85 f6                	test   %esi,%esi
  1031bc:	75 05                	jne    1031c3 <vprintfmt+0x191>
                p = "(null)";
  1031be:	be 6d 3c 10 00       	mov    $0x103c6d,%esi
            }
            if (width > 0 && padc != '-') {
  1031c3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  1031c7:	7e 76                	jle    10323f <vprintfmt+0x20d>
  1031c9:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  1031cd:	74 70                	je     10323f <vprintfmt+0x20d>
                for (width -= strnlen(p, precision); width > 0; width --) {
  1031cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  1031d2:	83 ec 08             	sub    $0x8,%esp
  1031d5:	50                   	push   %eax
  1031d6:	56                   	push   %esi
  1031d7:	e8 17 f8 ff ff       	call   1029f3 <strnlen>
  1031dc:	83 c4 10             	add    $0x10,%esp
  1031df:	89 c2                	mov    %eax,%edx
  1031e1:	8b 45 e8             	mov    -0x18(%ebp),%eax
  1031e4:	29 d0                	sub    %edx,%eax
  1031e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
  1031e9:	eb 17                	jmp    103202 <vprintfmt+0x1d0>
                    putch(padc, putdat);
  1031eb:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  1031ef:	83 ec 08             	sub    $0x8,%esp
  1031f2:	ff 75 0c             	pushl  0xc(%ebp)
  1031f5:	50                   	push   %eax
  1031f6:	8b 45 08             	mov    0x8(%ebp),%eax
  1031f9:	ff d0                	call   *%eax
  1031fb:	83 c4 10             	add    $0x10,%esp
                for (width -= strnlen(p, precision); width > 0; width --) {
  1031fe:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  103202:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103206:	7f e3                	jg     1031eb <vprintfmt+0x1b9>
                }
            }
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  103208:	eb 35                	jmp    10323f <vprintfmt+0x20d>
                if (altflag && (ch < ' ' || ch > '~')) {
  10320a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  10320e:	74 1c                	je     10322c <vprintfmt+0x1fa>
  103210:	83 fb 1f             	cmp    $0x1f,%ebx
  103213:	7e 05                	jle    10321a <vprintfmt+0x1e8>
  103215:	83 fb 7e             	cmp    $0x7e,%ebx
  103218:	7e 12                	jle    10322c <vprintfmt+0x1fa>
                    putch('?', putdat);
  10321a:	83 ec 08             	sub    $0x8,%esp
  10321d:	ff 75 0c             	pushl  0xc(%ebp)
  103220:	6a 3f                	push   $0x3f
  103222:	8b 45 08             	mov    0x8(%ebp),%eax
  103225:	ff d0                	call   *%eax
  103227:	83 c4 10             	add    $0x10,%esp
  10322a:	eb 0f                	jmp    10323b <vprintfmt+0x209>
                }
                else {
                    putch(ch, putdat);
  10322c:	83 ec 08             	sub    $0x8,%esp
  10322f:	ff 75 0c             	pushl  0xc(%ebp)
  103232:	53                   	push   %ebx
  103233:	8b 45 08             	mov    0x8(%ebp),%eax
  103236:	ff d0                	call   *%eax
  103238:	83 c4 10             	add    $0x10,%esp
            for (; (ch = *p ++) != '\0' && (precision < 0 || -- precision >= 0); width --) {
  10323b:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  10323f:	89 f0                	mov    %esi,%eax
  103241:	8d 70 01             	lea    0x1(%eax),%esi
  103244:	0f b6 00             	movzbl (%eax),%eax
  103247:	0f be d8             	movsbl %al,%ebx
  10324a:	85 db                	test   %ebx,%ebx
  10324c:	74 26                	je     103274 <vprintfmt+0x242>
  10324e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  103252:	78 b6                	js     10320a <vprintfmt+0x1d8>
  103254:	83 6d e4 01          	subl   $0x1,-0x1c(%ebp)
  103258:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  10325c:	79 ac                	jns    10320a <vprintfmt+0x1d8>
                }
            }
            for (; width > 0; width --) {
  10325e:	eb 14                	jmp    103274 <vprintfmt+0x242>
                putch(' ', putdat);
  103260:	83 ec 08             	sub    $0x8,%esp
  103263:	ff 75 0c             	pushl  0xc(%ebp)
  103266:	6a 20                	push   $0x20
  103268:	8b 45 08             	mov    0x8(%ebp),%eax
  10326b:	ff d0                	call   *%eax
  10326d:	83 c4 10             	add    $0x10,%esp
            for (; width > 0; width --) {
  103270:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
  103274:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  103278:	7f e6                	jg     103260 <vprintfmt+0x22e>
            }
            break;
  10327a:	e9 4e 01 00 00       	jmp    1033cd <vprintfmt+0x39b>

        // (signed) decimal
        case 'd':
            num = getint(&ap, lflag);
  10327f:	83 ec 08             	sub    $0x8,%esp
  103282:	ff 75 e0             	pushl  -0x20(%ebp)
  103285:	8d 45 14             	lea    0x14(%ebp),%eax
  103288:	50                   	push   %eax
  103289:	e8 39 fd ff ff       	call   102fc7 <getint>
  10328e:	83 c4 10             	add    $0x10,%esp
  103291:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103294:	89 55 f4             	mov    %edx,-0xc(%ebp)
            if ((long long)num < 0) {
  103297:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10329a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  10329d:	85 d2                	test   %edx,%edx
  10329f:	79 23                	jns    1032c4 <vprintfmt+0x292>
                putch('-', putdat);
  1032a1:	83 ec 08             	sub    $0x8,%esp
  1032a4:	ff 75 0c             	pushl  0xc(%ebp)
  1032a7:	6a 2d                	push   $0x2d
  1032a9:	8b 45 08             	mov    0x8(%ebp),%eax
  1032ac:	ff d0                	call   *%eax
  1032ae:	83 c4 10             	add    $0x10,%esp
                num = -(long long)num;
  1032b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  1032b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  1032b7:	f7 d8                	neg    %eax
  1032b9:	83 d2 00             	adc    $0x0,%edx
  1032bc:	f7 da                	neg    %edx
  1032be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1032c1:	89 55 f4             	mov    %edx,-0xc(%ebp)
            }
            base = 10;
  1032c4:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1032cb:	e9 9f 00 00 00       	jmp    10336f <vprintfmt+0x33d>

        // unsigned decimal
        case 'u':
            num = getuint(&ap, lflag);
  1032d0:	83 ec 08             	sub    $0x8,%esp
  1032d3:	ff 75 e0             	pushl  -0x20(%ebp)
  1032d6:	8d 45 14             	lea    0x14(%ebp),%eax
  1032d9:	50                   	push   %eax
  1032da:	e8 99 fc ff ff       	call   102f78 <getuint>
  1032df:	83 c4 10             	add    $0x10,%esp
  1032e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  1032e5:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 10;
  1032e8:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
            goto number;
  1032ef:	eb 7e                	jmp    10336f <vprintfmt+0x33d>

        // (unsigned) octal
        case 'o':
            num = getuint(&ap, lflag);
  1032f1:	83 ec 08             	sub    $0x8,%esp
  1032f4:	ff 75 e0             	pushl  -0x20(%ebp)
  1032f7:	8d 45 14             	lea    0x14(%ebp),%eax
  1032fa:	50                   	push   %eax
  1032fb:	e8 78 fc ff ff       	call   102f78 <getuint>
  103300:	83 c4 10             	add    $0x10,%esp
  103303:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103306:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 8;
  103309:	c7 45 ec 08 00 00 00 	movl   $0x8,-0x14(%ebp)
            goto number;
  103310:	eb 5d                	jmp    10336f <vprintfmt+0x33d>

        // pointer
        case 'p':
            putch('0', putdat);
  103312:	83 ec 08             	sub    $0x8,%esp
  103315:	ff 75 0c             	pushl  0xc(%ebp)
  103318:	6a 30                	push   $0x30
  10331a:	8b 45 08             	mov    0x8(%ebp),%eax
  10331d:	ff d0                	call   *%eax
  10331f:	83 c4 10             	add    $0x10,%esp
            putch('x', putdat);
  103322:	83 ec 08             	sub    $0x8,%esp
  103325:	ff 75 0c             	pushl  0xc(%ebp)
  103328:	6a 78                	push   $0x78
  10332a:	8b 45 08             	mov    0x8(%ebp),%eax
  10332d:	ff d0                	call   *%eax
  10332f:	83 c4 10             	add    $0x10,%esp
            num = (unsigned long long)(uintptr_t)va_arg(ap, void *);
  103332:	8b 45 14             	mov    0x14(%ebp),%eax
  103335:	8d 50 04             	lea    0x4(%eax),%edx
  103338:	89 55 14             	mov    %edx,0x14(%ebp)
  10333b:	8b 00                	mov    (%eax),%eax
  10333d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103340:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
            base = 16;
  103347:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
            goto number;
  10334e:	eb 1f                	jmp    10336f <vprintfmt+0x33d>

        // (unsigned) hexadecimal
        case 'x':
            num = getuint(&ap, lflag);
  103350:	83 ec 08             	sub    $0x8,%esp
  103353:	ff 75 e0             	pushl  -0x20(%ebp)
  103356:	8d 45 14             	lea    0x14(%ebp),%eax
  103359:	50                   	push   %eax
  10335a:	e8 19 fc ff ff       	call   102f78 <getuint>
  10335f:	83 c4 10             	add    $0x10,%esp
  103362:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103365:	89 55 f4             	mov    %edx,-0xc(%ebp)
            base = 16;
  103368:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
        number:
            printnum(putch, putdat, num, base, width, padc);
  10336f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  103373:	8b 45 ec             	mov    -0x14(%ebp),%eax
  103376:	83 ec 04             	sub    $0x4,%esp
  103379:	52                   	push   %edx
  10337a:	ff 75 e8             	pushl  -0x18(%ebp)
  10337d:	50                   	push   %eax
  10337e:	ff 75 f4             	pushl  -0xc(%ebp)
  103381:	ff 75 f0             	pushl  -0x10(%ebp)
  103384:	ff 75 0c             	pushl  0xc(%ebp)
  103387:	ff 75 08             	pushl  0x8(%ebp)
  10338a:	e8 f8 fa ff ff       	call   102e87 <printnum>
  10338f:	83 c4 20             	add    $0x20,%esp
            break;
  103392:	eb 39                	jmp    1033cd <vprintfmt+0x39b>

        // escaped '%' character
        case '%':
            putch(ch, putdat);
  103394:	83 ec 08             	sub    $0x8,%esp
  103397:	ff 75 0c             	pushl  0xc(%ebp)
  10339a:	53                   	push   %ebx
  10339b:	8b 45 08             	mov    0x8(%ebp),%eax
  10339e:	ff d0                	call   *%eax
  1033a0:	83 c4 10             	add    $0x10,%esp
            break;
  1033a3:	eb 28                	jmp    1033cd <vprintfmt+0x39b>

        // unrecognized escape sequence - just print it literally
        default:
            putch('%', putdat);
  1033a5:	83 ec 08             	sub    $0x8,%esp
  1033a8:	ff 75 0c             	pushl  0xc(%ebp)
  1033ab:	6a 25                	push   $0x25
  1033ad:	8b 45 08             	mov    0x8(%ebp),%eax
  1033b0:	ff d0                	call   *%eax
  1033b2:	83 c4 10             	add    $0x10,%esp
            for (fmt --; fmt[-1] != '%'; fmt --)
  1033b5:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1033b9:	eb 04                	jmp    1033bf <vprintfmt+0x38d>
  1033bb:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
  1033bf:	8b 45 10             	mov    0x10(%ebp),%eax
  1033c2:	83 e8 01             	sub    $0x1,%eax
  1033c5:	0f b6 00             	movzbl (%eax),%eax
  1033c8:	3c 25                	cmp    $0x25,%al
  1033ca:	75 ef                	jne    1033bb <vprintfmt+0x389>
                /* do nothing */;
            break;
  1033cc:	90                   	nop
        }
    }
  1033cd:	e9 68 fc ff ff       	jmp    10303a <vprintfmt+0x8>
                return;
  1033d2:	90                   	nop
}
  1033d3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  1033d6:	5b                   	pop    %ebx
  1033d7:	5e                   	pop    %esi
  1033d8:	5d                   	pop    %ebp
  1033d9:	c3                   	ret    

001033da <sprintputch>:
 * sprintputch - 'print' a single character in a buffer
 * @ch:            the character will be printed
 * @b:            the buffer to place the character @ch
 * */
static void
sprintputch(int ch, struct sprintbuf *b) {
  1033da:	55                   	push   %ebp
  1033db:	89 e5                	mov    %esp,%ebp
    b->cnt ++;
  1033dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033e0:	8b 40 08             	mov    0x8(%eax),%eax
  1033e3:	8d 50 01             	lea    0x1(%eax),%edx
  1033e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033e9:	89 50 08             	mov    %edx,0x8(%eax)
    if (b->buf < b->ebuf) {
  1033ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033ef:	8b 10                	mov    (%eax),%edx
  1033f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033f4:	8b 40 04             	mov    0x4(%eax),%eax
  1033f7:	39 c2                	cmp    %eax,%edx
  1033f9:	73 12                	jae    10340d <sprintputch+0x33>
        *b->buf ++ = ch;
  1033fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  1033fe:	8b 00                	mov    (%eax),%eax
  103400:	8d 48 01             	lea    0x1(%eax),%ecx
  103403:	8b 55 0c             	mov    0xc(%ebp),%edx
  103406:	89 0a                	mov    %ecx,(%edx)
  103408:	8b 55 08             	mov    0x8(%ebp),%edx
  10340b:	88 10                	mov    %dl,(%eax)
    }
}
  10340d:	90                   	nop
  10340e:	5d                   	pop    %ebp
  10340f:	c3                   	ret    

00103410 <snprintf>:
 * @str:        the buffer to place the result into
 * @size:        the size of buffer, including the trailing null space
 * @fmt:        the format string to use
 * */
int
snprintf(char *str, size_t size, const char *fmt, ...) {
  103410:	55                   	push   %ebp
  103411:	89 e5                	mov    %esp,%ebp
  103413:	83 ec 18             	sub    $0x18,%esp
    va_list ap;
    int cnt;
    va_start(ap, fmt);
  103416:	8d 45 14             	lea    0x14(%ebp),%eax
  103419:	89 45 f0             	mov    %eax,-0x10(%ebp)
    cnt = vsnprintf(str, size, fmt, ap);
  10341c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  10341f:	50                   	push   %eax
  103420:	ff 75 10             	pushl  0x10(%ebp)
  103423:	ff 75 0c             	pushl  0xc(%ebp)
  103426:	ff 75 08             	pushl  0x8(%ebp)
  103429:	e8 0b 00 00 00       	call   103439 <vsnprintf>
  10342e:	83 c4 10             	add    $0x10,%esp
  103431:	89 45 f4             	mov    %eax,-0xc(%ebp)
    va_end(ap);
    return cnt;
  103434:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103437:	c9                   	leave  
  103438:	c3                   	ret    

00103439 <vsnprintf>:
 *
 * Call this function if you are already dealing with a va_list.
 * Or you probably want snprintf() instead.
 * */
int
vsnprintf(char *str, size_t size, const char *fmt, va_list ap) {
  103439:	55                   	push   %ebp
  10343a:	89 e5                	mov    %esp,%ebp
  10343c:	83 ec 18             	sub    $0x18,%esp
    struct sprintbuf b = {str, str + size - 1, 0};
  10343f:	8b 45 08             	mov    0x8(%ebp),%eax
  103442:	89 45 ec             	mov    %eax,-0x14(%ebp)
  103445:	8b 45 0c             	mov    0xc(%ebp),%eax
  103448:	8d 50 ff             	lea    -0x1(%eax),%edx
  10344b:	8b 45 08             	mov    0x8(%ebp),%eax
  10344e:	01 d0                	add    %edx,%eax
  103450:	89 45 f0             	mov    %eax,-0x10(%ebp)
  103453:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if (str == NULL || b.buf > b.ebuf) {
  10345a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  10345e:	74 0a                	je     10346a <vsnprintf+0x31>
  103460:	8b 55 ec             	mov    -0x14(%ebp),%edx
  103463:	8b 45 f0             	mov    -0x10(%ebp),%eax
  103466:	39 c2                	cmp    %eax,%edx
  103468:	76 07                	jbe    103471 <vsnprintf+0x38>
        return -E_INVAL;
  10346a:	b8 fd ff ff ff       	mov    $0xfffffffd,%eax
  10346f:	eb 20                	jmp    103491 <vsnprintf+0x58>
    }
    // print the string to the buffer
    vprintfmt((void*)sprintputch, &b, fmt, ap);
  103471:	ff 75 14             	pushl  0x14(%ebp)
  103474:	ff 75 10             	pushl  0x10(%ebp)
  103477:	8d 45 ec             	lea    -0x14(%ebp),%eax
  10347a:	50                   	push   %eax
  10347b:	68 da 33 10 00       	push   $0x1033da
  103480:	e8 ad fb ff ff       	call   103032 <vprintfmt>
  103485:	83 c4 10             	add    $0x10,%esp
    // null terminate the buffer
    *b.buf = '\0';
  103488:	8b 45 ec             	mov    -0x14(%ebp),%eax
  10348b:	c6 00 00             	movb   $0x0,(%eax)
    return b.cnt;
  10348e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  103491:	c9                   	leave  
  103492:	c3                   	ret    
