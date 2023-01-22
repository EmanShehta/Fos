
obj/user/fos_factorial:     file format elf32-i386


Disassembly of section .text:

00800020 <_start>:
// starts us running when we are initially loaded into a new environment.
.text
.globl _start
_start:
	// See if we were started with arguments on the stack
	mov $0, %eax
  800020:	b8 00 00 00 00       	mov    $0x0,%eax
	cmpl $USTACKTOP, %esp
  800025:	81 fc 00 e0 bf ee    	cmp    $0xeebfe000,%esp
	jne args_exist
  80002b:	75 04                	jne    800031 <args_exist>

	// If not, push dummy argc/argv arguments.
	// This happens when we are loaded by the kernel,
	// because the kernel does not know about passing arguments.
	pushl $0
  80002d:	6a 00                	push   $0x0
	pushl $0
  80002f:	6a 00                	push   $0x0

00800031 <args_exist>:

args_exist:
	call libmain
  800031:	e8 95 00 00 00       	call   8000cb <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int factorial(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	atomic_readline("Please enter a number:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 e0 1b 80 00       	push   $0x801be0
  800057:	e8 df 09 00 00       	call   800a3b <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 31 0e 00 00       	call   800ea3 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = factorial(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <factorial>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Factorial %d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 f7 1b 80 00       	push   $0x801bf7
  800097:	e8 4c 02 00 00       	call   8002e8 <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <factorial>:


int factorial(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	83 ec 08             	sub    $0x8,%esp
	if (n <= 1)
  8000a8:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ac:	7f 07                	jg     8000b5 <factorial+0x13>
		return 1 ;
  8000ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b3:	eb 14                	jmp    8000c9 <factorial+0x27>
	return n * factorial(n-1) ;
  8000b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b8:	48                   	dec    %eax
  8000b9:	83 ec 0c             	sub    $0xc,%esp
  8000bc:	50                   	push   %eax
  8000bd:	e8 e0 ff ff ff       	call   8000a2 <factorial>
  8000c2:	83 c4 10             	add    $0x10,%esp
  8000c5:	0f af 45 08          	imul   0x8(%ebp),%eax
}
  8000c9:	c9                   	leave  
  8000ca:	c3                   	ret    

008000cb <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000cb:	55                   	push   %ebp
  8000cc:	89 e5                	mov    %esp,%ebp
  8000ce:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000d1:	e8 16 12 00 00       	call   8012ec <sys_getenvindex>
  8000d6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000dc:	89 d0                	mov    %edx,%eax
  8000de:	01 c0                	add    %eax,%eax
  8000e0:	01 d0                	add    %edx,%eax
  8000e2:	c1 e0 04             	shl    $0x4,%eax
  8000e5:	29 d0                	sub    %edx,%eax
  8000e7:	c1 e0 03             	shl    $0x3,%eax
  8000ea:	01 d0                	add    %edx,%eax
  8000ec:	c1 e0 02             	shl    $0x2,%eax
  8000ef:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000f4:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8000fe:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800104:	84 c0                	test   %al,%al
  800106:	74 0f                	je     800117 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800108:	a1 20 30 80 00       	mov    0x803020,%eax
  80010d:	05 5c 05 00 00       	add    $0x55c,%eax
  800112:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800117:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80011b:	7e 0a                	jle    800127 <libmain+0x5c>
		binaryname = argv[0];
  80011d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800120:	8b 00                	mov    (%eax),%eax
  800122:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800127:	83 ec 08             	sub    $0x8,%esp
  80012a:	ff 75 0c             	pushl  0xc(%ebp)
  80012d:	ff 75 08             	pushl  0x8(%ebp)
  800130:	e8 03 ff ff ff       	call   800038 <_main>
  800135:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800138:	e8 4a 13 00 00       	call   801487 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80013d:	83 ec 0c             	sub    $0xc,%esp
  800140:	68 24 1c 80 00       	push   $0x801c24
  800145:	e8 71 01 00 00       	call   8002bb <cprintf>
  80014a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80014d:	a1 20 30 80 00       	mov    0x803020,%eax
  800152:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800158:	a1 20 30 80 00       	mov    0x803020,%eax
  80015d:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800163:	83 ec 04             	sub    $0x4,%esp
  800166:	52                   	push   %edx
  800167:	50                   	push   %eax
  800168:	68 4c 1c 80 00       	push   $0x801c4c
  80016d:	e8 49 01 00 00       	call   8002bb <cprintf>
  800172:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800175:	a1 20 30 80 00       	mov    0x803020,%eax
  80017a:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  80018b:	a1 20 30 80 00       	mov    0x803020,%eax
  800190:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800196:	51                   	push   %ecx
  800197:	52                   	push   %edx
  800198:	50                   	push   %eax
  800199:	68 74 1c 80 00       	push   $0x801c74
  80019e:	e8 18 01 00 00       	call   8002bb <cprintf>
  8001a3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001a6:	83 ec 0c             	sub    $0xc,%esp
  8001a9:	68 24 1c 80 00       	push   $0x801c24
  8001ae:	e8 08 01 00 00       	call   8002bb <cprintf>
  8001b3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001b6:	e8 e6 12 00 00       	call   8014a1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001bb:	e8 19 00 00 00       	call   8001d9 <exit>
}
  8001c0:	90                   	nop
  8001c1:	c9                   	leave  
  8001c2:	c3                   	ret    

008001c3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001c3:	55                   	push   %ebp
  8001c4:	89 e5                	mov    %esp,%ebp
  8001c6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001c9:	83 ec 0c             	sub    $0xc,%esp
  8001cc:	6a 00                	push   $0x0
  8001ce:	e8 e5 10 00 00       	call   8012b8 <sys_env_destroy>
  8001d3:	83 c4 10             	add    $0x10,%esp
}
  8001d6:	90                   	nop
  8001d7:	c9                   	leave  
  8001d8:	c3                   	ret    

008001d9 <exit>:

void
exit(void)
{
  8001d9:	55                   	push   %ebp
  8001da:	89 e5                	mov    %esp,%ebp
  8001dc:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001df:	e8 3a 11 00 00       	call   80131e <sys_env_exit>
}
  8001e4:	90                   	nop
  8001e5:	c9                   	leave  
  8001e6:	c3                   	ret    

008001e7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001e7:	55                   	push   %ebp
  8001e8:	89 e5                	mov    %esp,%ebp
  8001ea:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001f0:	8b 00                	mov    (%eax),%eax
  8001f2:	8d 48 01             	lea    0x1(%eax),%ecx
  8001f5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f8:	89 0a                	mov    %ecx,(%edx)
  8001fa:	8b 55 08             	mov    0x8(%ebp),%edx
  8001fd:	88 d1                	mov    %dl,%cl
  8001ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  800202:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800206:	8b 45 0c             	mov    0xc(%ebp),%eax
  800209:	8b 00                	mov    (%eax),%eax
  80020b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800210:	75 2c                	jne    80023e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800212:	a0 24 30 80 00       	mov    0x803024,%al
  800217:	0f b6 c0             	movzbl %al,%eax
  80021a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80021d:	8b 12                	mov    (%edx),%edx
  80021f:	89 d1                	mov    %edx,%ecx
  800221:	8b 55 0c             	mov    0xc(%ebp),%edx
  800224:	83 c2 08             	add    $0x8,%edx
  800227:	83 ec 04             	sub    $0x4,%esp
  80022a:	50                   	push   %eax
  80022b:	51                   	push   %ecx
  80022c:	52                   	push   %edx
  80022d:	e8 44 10 00 00       	call   801276 <sys_cputs>
  800232:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800235:	8b 45 0c             	mov    0xc(%ebp),%eax
  800238:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80023e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800241:	8b 40 04             	mov    0x4(%eax),%eax
  800244:	8d 50 01             	lea    0x1(%eax),%edx
  800247:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80024d:	90                   	nop
  80024e:	c9                   	leave  
  80024f:	c3                   	ret    

00800250 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800250:	55                   	push   %ebp
  800251:	89 e5                	mov    %esp,%ebp
  800253:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800259:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800260:	00 00 00 
	b.cnt = 0;
  800263:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80026a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80026d:	ff 75 0c             	pushl  0xc(%ebp)
  800270:	ff 75 08             	pushl  0x8(%ebp)
  800273:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800279:	50                   	push   %eax
  80027a:	68 e7 01 80 00       	push   $0x8001e7
  80027f:	e8 11 02 00 00       	call   800495 <vprintfmt>
  800284:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800287:	a0 24 30 80 00       	mov    0x803024,%al
  80028c:	0f b6 c0             	movzbl %al,%eax
  80028f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800295:	83 ec 04             	sub    $0x4,%esp
  800298:	50                   	push   %eax
  800299:	52                   	push   %edx
  80029a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002a0:	83 c0 08             	add    $0x8,%eax
  8002a3:	50                   	push   %eax
  8002a4:	e8 cd 0f 00 00       	call   801276 <sys_cputs>
  8002a9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002ac:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002b3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002b9:	c9                   	leave  
  8002ba:	c3                   	ret    

008002bb <cprintf>:

int cprintf(const char *fmt, ...) {
  8002bb:	55                   	push   %ebp
  8002bc:	89 e5                	mov    %esp,%ebp
  8002be:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002c1:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002c8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d1:	83 ec 08             	sub    $0x8,%esp
  8002d4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002d7:	50                   	push   %eax
  8002d8:	e8 73 ff ff ff       	call   800250 <vcprintf>
  8002dd:	83 c4 10             	add    $0x10,%esp
  8002e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e6:	c9                   	leave  
  8002e7:	c3                   	ret    

008002e8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002e8:	55                   	push   %ebp
  8002e9:	89 e5                	mov    %esp,%ebp
  8002eb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002ee:	e8 94 11 00 00       	call   801487 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002f3:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8002fc:	83 ec 08             	sub    $0x8,%esp
  8002ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800302:	50                   	push   %eax
  800303:	e8 48 ff ff ff       	call   800250 <vcprintf>
  800308:	83 c4 10             	add    $0x10,%esp
  80030b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80030e:	e8 8e 11 00 00       	call   8014a1 <sys_enable_interrupt>
	return cnt;
  800313:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800316:	c9                   	leave  
  800317:	c3                   	ret    

00800318 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800318:	55                   	push   %ebp
  800319:	89 e5                	mov    %esp,%ebp
  80031b:	53                   	push   %ebx
  80031c:	83 ec 14             	sub    $0x14,%esp
  80031f:	8b 45 10             	mov    0x10(%ebp),%eax
  800322:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800325:	8b 45 14             	mov    0x14(%ebp),%eax
  800328:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80032b:	8b 45 18             	mov    0x18(%ebp),%eax
  80032e:	ba 00 00 00 00       	mov    $0x0,%edx
  800333:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800336:	77 55                	ja     80038d <printnum+0x75>
  800338:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80033b:	72 05                	jb     800342 <printnum+0x2a>
  80033d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800340:	77 4b                	ja     80038d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800342:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800345:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800348:	8b 45 18             	mov    0x18(%ebp),%eax
  80034b:	ba 00 00 00 00       	mov    $0x0,%edx
  800350:	52                   	push   %edx
  800351:	50                   	push   %eax
  800352:	ff 75 f4             	pushl  -0xc(%ebp)
  800355:	ff 75 f0             	pushl  -0x10(%ebp)
  800358:	e8 07 16 00 00       	call   801964 <__udivdi3>
  80035d:	83 c4 10             	add    $0x10,%esp
  800360:	83 ec 04             	sub    $0x4,%esp
  800363:	ff 75 20             	pushl  0x20(%ebp)
  800366:	53                   	push   %ebx
  800367:	ff 75 18             	pushl  0x18(%ebp)
  80036a:	52                   	push   %edx
  80036b:	50                   	push   %eax
  80036c:	ff 75 0c             	pushl  0xc(%ebp)
  80036f:	ff 75 08             	pushl  0x8(%ebp)
  800372:	e8 a1 ff ff ff       	call   800318 <printnum>
  800377:	83 c4 20             	add    $0x20,%esp
  80037a:	eb 1a                	jmp    800396 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80037c:	83 ec 08             	sub    $0x8,%esp
  80037f:	ff 75 0c             	pushl  0xc(%ebp)
  800382:	ff 75 20             	pushl  0x20(%ebp)
  800385:	8b 45 08             	mov    0x8(%ebp),%eax
  800388:	ff d0                	call   *%eax
  80038a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80038d:	ff 4d 1c             	decl   0x1c(%ebp)
  800390:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800394:	7f e6                	jg     80037c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800396:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800399:	bb 00 00 00 00       	mov    $0x0,%ebx
  80039e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003a4:	53                   	push   %ebx
  8003a5:	51                   	push   %ecx
  8003a6:	52                   	push   %edx
  8003a7:	50                   	push   %eax
  8003a8:	e8 c7 16 00 00       	call   801a74 <__umoddi3>
  8003ad:	83 c4 10             	add    $0x10,%esp
  8003b0:	05 f4 1e 80 00       	add    $0x801ef4,%eax
  8003b5:	8a 00                	mov    (%eax),%al
  8003b7:	0f be c0             	movsbl %al,%eax
  8003ba:	83 ec 08             	sub    $0x8,%esp
  8003bd:	ff 75 0c             	pushl  0xc(%ebp)
  8003c0:	50                   	push   %eax
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	ff d0                	call   *%eax
  8003c6:	83 c4 10             	add    $0x10,%esp
}
  8003c9:	90                   	nop
  8003ca:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003cd:	c9                   	leave  
  8003ce:	c3                   	ret    

008003cf <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003cf:	55                   	push   %ebp
  8003d0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003d2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003d6:	7e 1c                	jle    8003f4 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	8b 00                	mov    (%eax),%eax
  8003dd:	8d 50 08             	lea    0x8(%eax),%edx
  8003e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e3:	89 10                	mov    %edx,(%eax)
  8003e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e8:	8b 00                	mov    (%eax),%eax
  8003ea:	83 e8 08             	sub    $0x8,%eax
  8003ed:	8b 50 04             	mov    0x4(%eax),%edx
  8003f0:	8b 00                	mov    (%eax),%eax
  8003f2:	eb 40                	jmp    800434 <getuint+0x65>
	else if (lflag)
  8003f4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003f8:	74 1e                	je     800418 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	8b 00                	mov    (%eax),%eax
  8003ff:	8d 50 04             	lea    0x4(%eax),%edx
  800402:	8b 45 08             	mov    0x8(%ebp),%eax
  800405:	89 10                	mov    %edx,(%eax)
  800407:	8b 45 08             	mov    0x8(%ebp),%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	83 e8 04             	sub    $0x4,%eax
  80040f:	8b 00                	mov    (%eax),%eax
  800411:	ba 00 00 00 00       	mov    $0x0,%edx
  800416:	eb 1c                	jmp    800434 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	8b 00                	mov    (%eax),%eax
  80041d:	8d 50 04             	lea    0x4(%eax),%edx
  800420:	8b 45 08             	mov    0x8(%ebp),%eax
  800423:	89 10                	mov    %edx,(%eax)
  800425:	8b 45 08             	mov    0x8(%ebp),%eax
  800428:	8b 00                	mov    (%eax),%eax
  80042a:	83 e8 04             	sub    $0x4,%eax
  80042d:	8b 00                	mov    (%eax),%eax
  80042f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800434:	5d                   	pop    %ebp
  800435:	c3                   	ret    

00800436 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800436:	55                   	push   %ebp
  800437:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800439:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80043d:	7e 1c                	jle    80045b <getint+0x25>
		return va_arg(*ap, long long);
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	8b 00                	mov    (%eax),%eax
  800444:	8d 50 08             	lea    0x8(%eax),%edx
  800447:	8b 45 08             	mov    0x8(%ebp),%eax
  80044a:	89 10                	mov    %edx,(%eax)
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	83 e8 08             	sub    $0x8,%eax
  800454:	8b 50 04             	mov    0x4(%eax),%edx
  800457:	8b 00                	mov    (%eax),%eax
  800459:	eb 38                	jmp    800493 <getint+0x5d>
	else if (lflag)
  80045b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80045f:	74 1a                	je     80047b <getint+0x45>
		return va_arg(*ap, long);
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	8b 00                	mov    (%eax),%eax
  800466:	8d 50 04             	lea    0x4(%eax),%edx
  800469:	8b 45 08             	mov    0x8(%ebp),%eax
  80046c:	89 10                	mov    %edx,(%eax)
  80046e:	8b 45 08             	mov    0x8(%ebp),%eax
  800471:	8b 00                	mov    (%eax),%eax
  800473:	83 e8 04             	sub    $0x4,%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	99                   	cltd   
  800479:	eb 18                	jmp    800493 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	8b 00                	mov    (%eax),%eax
  800480:	8d 50 04             	lea    0x4(%eax),%edx
  800483:	8b 45 08             	mov    0x8(%ebp),%eax
  800486:	89 10                	mov    %edx,(%eax)
  800488:	8b 45 08             	mov    0x8(%ebp),%eax
  80048b:	8b 00                	mov    (%eax),%eax
  80048d:	83 e8 04             	sub    $0x4,%eax
  800490:	8b 00                	mov    (%eax),%eax
  800492:	99                   	cltd   
}
  800493:	5d                   	pop    %ebp
  800494:	c3                   	ret    

00800495 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800495:	55                   	push   %ebp
  800496:	89 e5                	mov    %esp,%ebp
  800498:	56                   	push   %esi
  800499:	53                   	push   %ebx
  80049a:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80049d:	eb 17                	jmp    8004b6 <vprintfmt+0x21>
			if (ch == '\0')
  80049f:	85 db                	test   %ebx,%ebx
  8004a1:	0f 84 af 03 00 00    	je     800856 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004a7:	83 ec 08             	sub    $0x8,%esp
  8004aa:	ff 75 0c             	pushl  0xc(%ebp)
  8004ad:	53                   	push   %ebx
  8004ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b1:	ff d0                	call   *%eax
  8004b3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b9:	8d 50 01             	lea    0x1(%eax),%edx
  8004bc:	89 55 10             	mov    %edx,0x10(%ebp)
  8004bf:	8a 00                	mov    (%eax),%al
  8004c1:	0f b6 d8             	movzbl %al,%ebx
  8004c4:	83 fb 25             	cmp    $0x25,%ebx
  8004c7:	75 d6                	jne    80049f <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004c9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004cd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004d4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004db:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004e2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ec:	8d 50 01             	lea    0x1(%eax),%edx
  8004ef:	89 55 10             	mov    %edx,0x10(%ebp)
  8004f2:	8a 00                	mov    (%eax),%al
  8004f4:	0f b6 d8             	movzbl %al,%ebx
  8004f7:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004fa:	83 f8 55             	cmp    $0x55,%eax
  8004fd:	0f 87 2b 03 00 00    	ja     80082e <vprintfmt+0x399>
  800503:	8b 04 85 18 1f 80 00 	mov    0x801f18(,%eax,4),%eax
  80050a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80050c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800510:	eb d7                	jmp    8004e9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800512:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800516:	eb d1                	jmp    8004e9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800518:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80051f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800522:	89 d0                	mov    %edx,%eax
  800524:	c1 e0 02             	shl    $0x2,%eax
  800527:	01 d0                	add    %edx,%eax
  800529:	01 c0                	add    %eax,%eax
  80052b:	01 d8                	add    %ebx,%eax
  80052d:	83 e8 30             	sub    $0x30,%eax
  800530:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800533:	8b 45 10             	mov    0x10(%ebp),%eax
  800536:	8a 00                	mov    (%eax),%al
  800538:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80053b:	83 fb 2f             	cmp    $0x2f,%ebx
  80053e:	7e 3e                	jle    80057e <vprintfmt+0xe9>
  800540:	83 fb 39             	cmp    $0x39,%ebx
  800543:	7f 39                	jg     80057e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800545:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800548:	eb d5                	jmp    80051f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80054a:	8b 45 14             	mov    0x14(%ebp),%eax
  80054d:	83 c0 04             	add    $0x4,%eax
  800550:	89 45 14             	mov    %eax,0x14(%ebp)
  800553:	8b 45 14             	mov    0x14(%ebp),%eax
  800556:	83 e8 04             	sub    $0x4,%eax
  800559:	8b 00                	mov    (%eax),%eax
  80055b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80055e:	eb 1f                	jmp    80057f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800560:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800564:	79 83                	jns    8004e9 <vprintfmt+0x54>
				width = 0;
  800566:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80056d:	e9 77 ff ff ff       	jmp    8004e9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800572:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800579:	e9 6b ff ff ff       	jmp    8004e9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80057e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80057f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800583:	0f 89 60 ff ff ff    	jns    8004e9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800589:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80058c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80058f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800596:	e9 4e ff ff ff       	jmp    8004e9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80059b:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80059e:	e9 46 ff ff ff       	jmp    8004e9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005a3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a6:	83 c0 04             	add    $0x4,%eax
  8005a9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8005af:	83 e8 04             	sub    $0x4,%eax
  8005b2:	8b 00                	mov    (%eax),%eax
  8005b4:	83 ec 08             	sub    $0x8,%esp
  8005b7:	ff 75 0c             	pushl  0xc(%ebp)
  8005ba:	50                   	push   %eax
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	ff d0                	call   *%eax
  8005c0:	83 c4 10             	add    $0x10,%esp
			break;
  8005c3:	e9 89 02 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005c8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cb:	83 c0 04             	add    $0x4,%eax
  8005ce:	89 45 14             	mov    %eax,0x14(%ebp)
  8005d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005d4:	83 e8 04             	sub    $0x4,%eax
  8005d7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005d9:	85 db                	test   %ebx,%ebx
  8005db:	79 02                	jns    8005df <vprintfmt+0x14a>
				err = -err;
  8005dd:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005df:	83 fb 64             	cmp    $0x64,%ebx
  8005e2:	7f 0b                	jg     8005ef <vprintfmt+0x15a>
  8005e4:	8b 34 9d 60 1d 80 00 	mov    0x801d60(,%ebx,4),%esi
  8005eb:	85 f6                	test   %esi,%esi
  8005ed:	75 19                	jne    800608 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005ef:	53                   	push   %ebx
  8005f0:	68 05 1f 80 00       	push   $0x801f05
  8005f5:	ff 75 0c             	pushl  0xc(%ebp)
  8005f8:	ff 75 08             	pushl  0x8(%ebp)
  8005fb:	e8 5e 02 00 00       	call   80085e <printfmt>
  800600:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800603:	e9 49 02 00 00       	jmp    800851 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800608:	56                   	push   %esi
  800609:	68 0e 1f 80 00       	push   $0x801f0e
  80060e:	ff 75 0c             	pushl  0xc(%ebp)
  800611:	ff 75 08             	pushl  0x8(%ebp)
  800614:	e8 45 02 00 00       	call   80085e <printfmt>
  800619:	83 c4 10             	add    $0x10,%esp
			break;
  80061c:	e9 30 02 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800621:	8b 45 14             	mov    0x14(%ebp),%eax
  800624:	83 c0 04             	add    $0x4,%eax
  800627:	89 45 14             	mov    %eax,0x14(%ebp)
  80062a:	8b 45 14             	mov    0x14(%ebp),%eax
  80062d:	83 e8 04             	sub    $0x4,%eax
  800630:	8b 30                	mov    (%eax),%esi
  800632:	85 f6                	test   %esi,%esi
  800634:	75 05                	jne    80063b <vprintfmt+0x1a6>
				p = "(null)";
  800636:	be 11 1f 80 00       	mov    $0x801f11,%esi
			if (width > 0 && padc != '-')
  80063b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80063f:	7e 6d                	jle    8006ae <vprintfmt+0x219>
  800641:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800645:	74 67                	je     8006ae <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800647:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80064a:	83 ec 08             	sub    $0x8,%esp
  80064d:	50                   	push   %eax
  80064e:	56                   	push   %esi
  80064f:	e8 12 05 00 00       	call   800b66 <strnlen>
  800654:	83 c4 10             	add    $0x10,%esp
  800657:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80065a:	eb 16                	jmp    800672 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80065c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	ff 75 0c             	pushl  0xc(%ebp)
  800666:	50                   	push   %eax
  800667:	8b 45 08             	mov    0x8(%ebp),%eax
  80066a:	ff d0                	call   *%eax
  80066c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80066f:	ff 4d e4             	decl   -0x1c(%ebp)
  800672:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800676:	7f e4                	jg     80065c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800678:	eb 34                	jmp    8006ae <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80067a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80067e:	74 1c                	je     80069c <vprintfmt+0x207>
  800680:	83 fb 1f             	cmp    $0x1f,%ebx
  800683:	7e 05                	jle    80068a <vprintfmt+0x1f5>
  800685:	83 fb 7e             	cmp    $0x7e,%ebx
  800688:	7e 12                	jle    80069c <vprintfmt+0x207>
					putch('?', putdat);
  80068a:	83 ec 08             	sub    $0x8,%esp
  80068d:	ff 75 0c             	pushl  0xc(%ebp)
  800690:	6a 3f                	push   $0x3f
  800692:	8b 45 08             	mov    0x8(%ebp),%eax
  800695:	ff d0                	call   *%eax
  800697:	83 c4 10             	add    $0x10,%esp
  80069a:	eb 0f                	jmp    8006ab <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80069c:	83 ec 08             	sub    $0x8,%esp
  80069f:	ff 75 0c             	pushl  0xc(%ebp)
  8006a2:	53                   	push   %ebx
  8006a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a6:	ff d0                	call   *%eax
  8006a8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006ab:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ae:	89 f0                	mov    %esi,%eax
  8006b0:	8d 70 01             	lea    0x1(%eax),%esi
  8006b3:	8a 00                	mov    (%eax),%al
  8006b5:	0f be d8             	movsbl %al,%ebx
  8006b8:	85 db                	test   %ebx,%ebx
  8006ba:	74 24                	je     8006e0 <vprintfmt+0x24b>
  8006bc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c0:	78 b8                	js     80067a <vprintfmt+0x1e5>
  8006c2:	ff 4d e0             	decl   -0x20(%ebp)
  8006c5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c9:	79 af                	jns    80067a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006cb:	eb 13                	jmp    8006e0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	ff 75 0c             	pushl  0xc(%ebp)
  8006d3:	6a 20                	push   $0x20
  8006d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d8:	ff d0                	call   *%eax
  8006da:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006dd:	ff 4d e4             	decl   -0x1c(%ebp)
  8006e0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e4:	7f e7                	jg     8006cd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006e6:	e9 66 01 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	ff 75 e8             	pushl  -0x18(%ebp)
  8006f1:	8d 45 14             	lea    0x14(%ebp),%eax
  8006f4:	50                   	push   %eax
  8006f5:	e8 3c fd ff ff       	call   800436 <getint>
  8006fa:	83 c4 10             	add    $0x10,%esp
  8006fd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800700:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800703:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800706:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800709:	85 d2                	test   %edx,%edx
  80070b:	79 23                	jns    800730 <vprintfmt+0x29b>
				putch('-', putdat);
  80070d:	83 ec 08             	sub    $0x8,%esp
  800710:	ff 75 0c             	pushl  0xc(%ebp)
  800713:	6a 2d                	push   $0x2d
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	ff d0                	call   *%eax
  80071a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80071d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800720:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800723:	f7 d8                	neg    %eax
  800725:	83 d2 00             	adc    $0x0,%edx
  800728:	f7 da                	neg    %edx
  80072a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80072d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800730:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800737:	e9 bc 00 00 00       	jmp    8007f8 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80073c:	83 ec 08             	sub    $0x8,%esp
  80073f:	ff 75 e8             	pushl  -0x18(%ebp)
  800742:	8d 45 14             	lea    0x14(%ebp),%eax
  800745:	50                   	push   %eax
  800746:	e8 84 fc ff ff       	call   8003cf <getuint>
  80074b:	83 c4 10             	add    $0x10,%esp
  80074e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800751:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800754:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80075b:	e9 98 00 00 00       	jmp    8007f8 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800760:	83 ec 08             	sub    $0x8,%esp
  800763:	ff 75 0c             	pushl  0xc(%ebp)
  800766:	6a 58                	push   $0x58
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	ff d0                	call   *%eax
  80076d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	6a 58                	push   $0x58
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	ff d0                	call   *%eax
  80077d:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	ff 75 0c             	pushl  0xc(%ebp)
  800786:	6a 58                	push   $0x58
  800788:	8b 45 08             	mov    0x8(%ebp),%eax
  80078b:	ff d0                	call   *%eax
  80078d:	83 c4 10             	add    $0x10,%esp
			break;
  800790:	e9 bc 00 00 00       	jmp    800851 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800795:	83 ec 08             	sub    $0x8,%esp
  800798:	ff 75 0c             	pushl  0xc(%ebp)
  80079b:	6a 30                	push   $0x30
  80079d:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a0:	ff d0                	call   *%eax
  8007a2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007a5:	83 ec 08             	sub    $0x8,%esp
  8007a8:	ff 75 0c             	pushl  0xc(%ebp)
  8007ab:	6a 78                	push   $0x78
  8007ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b0:	ff d0                	call   *%eax
  8007b2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b8:	83 c0 04             	add    $0x4,%eax
  8007bb:	89 45 14             	mov    %eax,0x14(%ebp)
  8007be:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c1:	83 e8 04             	sub    $0x4,%eax
  8007c4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007d0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007d7:	eb 1f                	jmp    8007f8 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007d9:	83 ec 08             	sub    $0x8,%esp
  8007dc:	ff 75 e8             	pushl  -0x18(%ebp)
  8007df:	8d 45 14             	lea    0x14(%ebp),%eax
  8007e2:	50                   	push   %eax
  8007e3:	e8 e7 fb ff ff       	call   8003cf <getuint>
  8007e8:	83 c4 10             	add    $0x10,%esp
  8007eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007f1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007f8:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007fc:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007ff:	83 ec 04             	sub    $0x4,%esp
  800802:	52                   	push   %edx
  800803:	ff 75 e4             	pushl  -0x1c(%ebp)
  800806:	50                   	push   %eax
  800807:	ff 75 f4             	pushl  -0xc(%ebp)
  80080a:	ff 75 f0             	pushl  -0x10(%ebp)
  80080d:	ff 75 0c             	pushl  0xc(%ebp)
  800810:	ff 75 08             	pushl  0x8(%ebp)
  800813:	e8 00 fb ff ff       	call   800318 <printnum>
  800818:	83 c4 20             	add    $0x20,%esp
			break;
  80081b:	eb 34                	jmp    800851 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80081d:	83 ec 08             	sub    $0x8,%esp
  800820:	ff 75 0c             	pushl  0xc(%ebp)
  800823:	53                   	push   %ebx
  800824:	8b 45 08             	mov    0x8(%ebp),%eax
  800827:	ff d0                	call   *%eax
  800829:	83 c4 10             	add    $0x10,%esp
			break;
  80082c:	eb 23                	jmp    800851 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80082e:	83 ec 08             	sub    $0x8,%esp
  800831:	ff 75 0c             	pushl  0xc(%ebp)
  800834:	6a 25                	push   $0x25
  800836:	8b 45 08             	mov    0x8(%ebp),%eax
  800839:	ff d0                	call   *%eax
  80083b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80083e:	ff 4d 10             	decl   0x10(%ebp)
  800841:	eb 03                	jmp    800846 <vprintfmt+0x3b1>
  800843:	ff 4d 10             	decl   0x10(%ebp)
  800846:	8b 45 10             	mov    0x10(%ebp),%eax
  800849:	48                   	dec    %eax
  80084a:	8a 00                	mov    (%eax),%al
  80084c:	3c 25                	cmp    $0x25,%al
  80084e:	75 f3                	jne    800843 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800850:	90                   	nop
		}
	}
  800851:	e9 47 fc ff ff       	jmp    80049d <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800856:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800857:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80085a:	5b                   	pop    %ebx
  80085b:	5e                   	pop    %esi
  80085c:	5d                   	pop    %ebp
  80085d:	c3                   	ret    

0080085e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80085e:	55                   	push   %ebp
  80085f:	89 e5                	mov    %esp,%ebp
  800861:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800864:	8d 45 10             	lea    0x10(%ebp),%eax
  800867:	83 c0 04             	add    $0x4,%eax
  80086a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80086d:	8b 45 10             	mov    0x10(%ebp),%eax
  800870:	ff 75 f4             	pushl  -0xc(%ebp)
  800873:	50                   	push   %eax
  800874:	ff 75 0c             	pushl  0xc(%ebp)
  800877:	ff 75 08             	pushl  0x8(%ebp)
  80087a:	e8 16 fc ff ff       	call   800495 <vprintfmt>
  80087f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800882:	90                   	nop
  800883:	c9                   	leave  
  800884:	c3                   	ret    

00800885 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800885:	55                   	push   %ebp
  800886:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800888:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088b:	8b 40 08             	mov    0x8(%eax),%eax
  80088e:	8d 50 01             	lea    0x1(%eax),%edx
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800897:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089a:	8b 10                	mov    (%eax),%edx
  80089c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089f:	8b 40 04             	mov    0x4(%eax),%eax
  8008a2:	39 c2                	cmp    %eax,%edx
  8008a4:	73 12                	jae    8008b8 <sprintputch+0x33>
		*b->buf++ = ch;
  8008a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a9:	8b 00                	mov    (%eax),%eax
  8008ab:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008b1:	89 0a                	mov    %ecx,(%edx)
  8008b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008b6:	88 10                	mov    %dl,(%eax)
}
  8008b8:	90                   	nop
  8008b9:	5d                   	pop    %ebp
  8008ba:	c3                   	ret    

008008bb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008bb:	55                   	push   %ebp
  8008bc:	89 e5                	mov    %esp,%ebp
  8008be:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ca:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d0:	01 d0                	add    %edx,%eax
  8008d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008dc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008e0:	74 06                	je     8008e8 <vsnprintf+0x2d>
  8008e2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008e6:	7f 07                	jg     8008ef <vsnprintf+0x34>
		return -E_INVAL;
  8008e8:	b8 03 00 00 00       	mov    $0x3,%eax
  8008ed:	eb 20                	jmp    80090f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ef:	ff 75 14             	pushl  0x14(%ebp)
  8008f2:	ff 75 10             	pushl  0x10(%ebp)
  8008f5:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008f8:	50                   	push   %eax
  8008f9:	68 85 08 80 00       	push   $0x800885
  8008fe:	e8 92 fb ff ff       	call   800495 <vprintfmt>
  800903:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800906:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800909:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80090c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80090f:	c9                   	leave  
  800910:	c3                   	ret    

00800911 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800911:	55                   	push   %ebp
  800912:	89 e5                	mov    %esp,%ebp
  800914:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800917:	8d 45 10             	lea    0x10(%ebp),%eax
  80091a:	83 c0 04             	add    $0x4,%eax
  80091d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800920:	8b 45 10             	mov    0x10(%ebp),%eax
  800923:	ff 75 f4             	pushl  -0xc(%ebp)
  800926:	50                   	push   %eax
  800927:	ff 75 0c             	pushl  0xc(%ebp)
  80092a:	ff 75 08             	pushl  0x8(%ebp)
  80092d:	e8 89 ff ff ff       	call   8008bb <vsnprintf>
  800932:	83 c4 10             	add    $0x10,%esp
  800935:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800938:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80093b:	c9                   	leave  
  80093c:	c3                   	ret    

0080093d <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80093d:	55                   	push   %ebp
  80093e:	89 e5                	mov    %esp,%ebp
  800940:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800943:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800947:	74 13                	je     80095c <readline+0x1f>
		cprintf("%s", prompt);
  800949:	83 ec 08             	sub    $0x8,%esp
  80094c:	ff 75 08             	pushl  0x8(%ebp)
  80094f:	68 70 20 80 00       	push   $0x802070
  800954:	e8 62 f9 ff ff       	call   8002bb <cprintf>
  800959:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80095c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800963:	83 ec 0c             	sub    $0xc,%esp
  800966:	6a 00                	push   $0x0
  800968:	e8 ed 0f 00 00       	call   80195a <iscons>
  80096d:	83 c4 10             	add    $0x10,%esp
  800970:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800973:	e8 94 0f 00 00       	call   80190c <getchar>
  800978:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80097b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80097f:	79 22                	jns    8009a3 <readline+0x66>
			if (c != -E_EOF)
  800981:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800985:	0f 84 ad 00 00 00    	je     800a38 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80098b:	83 ec 08             	sub    $0x8,%esp
  80098e:	ff 75 ec             	pushl  -0x14(%ebp)
  800991:	68 73 20 80 00       	push   $0x802073
  800996:	e8 20 f9 ff ff       	call   8002bb <cprintf>
  80099b:	83 c4 10             	add    $0x10,%esp
			return;
  80099e:	e9 95 00 00 00       	jmp    800a38 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009a3:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009a7:	7e 34                	jle    8009dd <readline+0xa0>
  8009a9:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009b0:	7f 2b                	jg     8009dd <readline+0xa0>
			if (echoing)
  8009b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009b6:	74 0e                	je     8009c6 <readline+0x89>
				cputchar(c);
  8009b8:	83 ec 0c             	sub    $0xc,%esp
  8009bb:	ff 75 ec             	pushl  -0x14(%ebp)
  8009be:	e8 01 0f 00 00       	call   8018c4 <cputchar>
  8009c3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009c9:	8d 50 01             	lea    0x1(%eax),%edx
  8009cc:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009cf:	89 c2                	mov    %eax,%edx
  8009d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d4:	01 d0                	add    %edx,%eax
  8009d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009d9:	88 10                	mov    %dl,(%eax)
  8009db:	eb 56                	jmp    800a33 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009dd:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009e1:	75 1f                	jne    800a02 <readline+0xc5>
  8009e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009e7:	7e 19                	jle    800a02 <readline+0xc5>
			if (echoing)
  8009e9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009ed:	74 0e                	je     8009fd <readline+0xc0>
				cputchar(c);
  8009ef:	83 ec 0c             	sub    $0xc,%esp
  8009f2:	ff 75 ec             	pushl  -0x14(%ebp)
  8009f5:	e8 ca 0e 00 00       	call   8018c4 <cputchar>
  8009fa:	83 c4 10             	add    $0x10,%esp

			i--;
  8009fd:	ff 4d f4             	decl   -0xc(%ebp)
  800a00:	eb 31                	jmp    800a33 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a02:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a06:	74 0a                	je     800a12 <readline+0xd5>
  800a08:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a0c:	0f 85 61 ff ff ff    	jne    800973 <readline+0x36>
			if (echoing)
  800a12:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a16:	74 0e                	je     800a26 <readline+0xe9>
				cputchar(c);
  800a18:	83 ec 0c             	sub    $0xc,%esp
  800a1b:	ff 75 ec             	pushl  -0x14(%ebp)
  800a1e:	e8 a1 0e 00 00       	call   8018c4 <cputchar>
  800a23:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a26:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2c:	01 d0                	add    %edx,%eax
  800a2e:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a31:	eb 06                	jmp    800a39 <readline+0xfc>
		}
	}
  800a33:	e9 3b ff ff ff       	jmp    800973 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a38:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a39:	c9                   	leave  
  800a3a:	c3                   	ret    

00800a3b <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a3b:	55                   	push   %ebp
  800a3c:	89 e5                	mov    %esp,%ebp
  800a3e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a41:	e8 41 0a 00 00       	call   801487 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a46:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a4a:	74 13                	je     800a5f <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a4c:	83 ec 08             	sub    $0x8,%esp
  800a4f:	ff 75 08             	pushl  0x8(%ebp)
  800a52:	68 70 20 80 00       	push   $0x802070
  800a57:	e8 5f f8 ff ff       	call   8002bb <cprintf>
  800a5c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a5f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a66:	83 ec 0c             	sub    $0xc,%esp
  800a69:	6a 00                	push   $0x0
  800a6b:	e8 ea 0e 00 00       	call   80195a <iscons>
  800a70:	83 c4 10             	add    $0x10,%esp
  800a73:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a76:	e8 91 0e 00 00       	call   80190c <getchar>
  800a7b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a7e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a82:	79 23                	jns    800aa7 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a84:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a88:	74 13                	je     800a9d <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a8a:	83 ec 08             	sub    $0x8,%esp
  800a8d:	ff 75 ec             	pushl  -0x14(%ebp)
  800a90:	68 73 20 80 00       	push   $0x802073
  800a95:	e8 21 f8 ff ff       	call   8002bb <cprintf>
  800a9a:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800a9d:	e8 ff 09 00 00       	call   8014a1 <sys_enable_interrupt>
			return;
  800aa2:	e9 9a 00 00 00       	jmp    800b41 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800aa7:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800aab:	7e 34                	jle    800ae1 <atomic_readline+0xa6>
  800aad:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ab4:	7f 2b                	jg     800ae1 <atomic_readline+0xa6>
			if (echoing)
  800ab6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800aba:	74 0e                	je     800aca <atomic_readline+0x8f>
				cputchar(c);
  800abc:	83 ec 0c             	sub    $0xc,%esp
  800abf:	ff 75 ec             	pushl  -0x14(%ebp)
  800ac2:	e8 fd 0d 00 00       	call   8018c4 <cputchar>
  800ac7:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800acd:	8d 50 01             	lea    0x1(%eax),%edx
  800ad0:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ad3:	89 c2                	mov    %eax,%edx
  800ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad8:	01 d0                	add    %edx,%eax
  800ada:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800add:	88 10                	mov    %dl,(%eax)
  800adf:	eb 5b                	jmp    800b3c <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800ae1:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800ae5:	75 1f                	jne    800b06 <atomic_readline+0xcb>
  800ae7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800aeb:	7e 19                	jle    800b06 <atomic_readline+0xcb>
			if (echoing)
  800aed:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800af1:	74 0e                	je     800b01 <atomic_readline+0xc6>
				cputchar(c);
  800af3:	83 ec 0c             	sub    $0xc,%esp
  800af6:	ff 75 ec             	pushl  -0x14(%ebp)
  800af9:	e8 c6 0d 00 00       	call   8018c4 <cputchar>
  800afe:	83 c4 10             	add    $0x10,%esp
			i--;
  800b01:	ff 4d f4             	decl   -0xc(%ebp)
  800b04:	eb 36                	jmp    800b3c <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b06:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b0a:	74 0a                	je     800b16 <atomic_readline+0xdb>
  800b0c:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b10:	0f 85 60 ff ff ff    	jne    800a76 <atomic_readline+0x3b>
			if (echoing)
  800b16:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b1a:	74 0e                	je     800b2a <atomic_readline+0xef>
				cputchar(c);
  800b1c:	83 ec 0c             	sub    $0xc,%esp
  800b1f:	ff 75 ec             	pushl  -0x14(%ebp)
  800b22:	e8 9d 0d 00 00       	call   8018c4 <cputchar>
  800b27:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b2a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b30:	01 d0                	add    %edx,%eax
  800b32:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b35:	e8 67 09 00 00       	call   8014a1 <sys_enable_interrupt>
			return;
  800b3a:	eb 05                	jmp    800b41 <atomic_readline+0x106>
		}
	}
  800b3c:	e9 35 ff ff ff       	jmp    800a76 <atomic_readline+0x3b>
}
  800b41:	c9                   	leave  
  800b42:	c3                   	ret    

00800b43 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b43:	55                   	push   %ebp
  800b44:	89 e5                	mov    %esp,%ebp
  800b46:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b49:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b50:	eb 06                	jmp    800b58 <strlen+0x15>
		n++;
  800b52:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b55:	ff 45 08             	incl   0x8(%ebp)
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	8a 00                	mov    (%eax),%al
  800b5d:	84 c0                	test   %al,%al
  800b5f:	75 f1                	jne    800b52 <strlen+0xf>
		n++;
	return n;
  800b61:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b64:	c9                   	leave  
  800b65:	c3                   	ret    

00800b66 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b66:	55                   	push   %ebp
  800b67:	89 e5                	mov    %esp,%ebp
  800b69:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b6c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b73:	eb 09                	jmp    800b7e <strnlen+0x18>
		n++;
  800b75:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b78:	ff 45 08             	incl   0x8(%ebp)
  800b7b:	ff 4d 0c             	decl   0xc(%ebp)
  800b7e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b82:	74 09                	je     800b8d <strnlen+0x27>
  800b84:	8b 45 08             	mov    0x8(%ebp),%eax
  800b87:	8a 00                	mov    (%eax),%al
  800b89:	84 c0                	test   %al,%al
  800b8b:	75 e8                	jne    800b75 <strnlen+0xf>
		n++;
	return n;
  800b8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b90:	c9                   	leave  
  800b91:	c3                   	ret    

00800b92 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b92:	55                   	push   %ebp
  800b93:	89 e5                	mov    %esp,%ebp
  800b95:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b9e:	90                   	nop
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	8d 50 01             	lea    0x1(%eax),%edx
  800ba5:	89 55 08             	mov    %edx,0x8(%ebp)
  800ba8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bab:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bae:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bb1:	8a 12                	mov    (%edx),%dl
  800bb3:	88 10                	mov    %dl,(%eax)
  800bb5:	8a 00                	mov    (%eax),%al
  800bb7:	84 c0                	test   %al,%al
  800bb9:	75 e4                	jne    800b9f <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bbe:	c9                   	leave  
  800bbf:	c3                   	ret    

00800bc0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bc0:	55                   	push   %ebp
  800bc1:	89 e5                	mov    %esp,%ebp
  800bc3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bcc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bd3:	eb 1f                	jmp    800bf4 <strncpy+0x34>
		*dst++ = *src;
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	8d 50 01             	lea    0x1(%eax),%edx
  800bdb:	89 55 08             	mov    %edx,0x8(%ebp)
  800bde:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be1:	8a 12                	mov    (%edx),%dl
  800be3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800be5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be8:	8a 00                	mov    (%eax),%al
  800bea:	84 c0                	test   %al,%al
  800bec:	74 03                	je     800bf1 <strncpy+0x31>
			src++;
  800bee:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800bf1:	ff 45 fc             	incl   -0x4(%ebp)
  800bf4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf7:	3b 45 10             	cmp    0x10(%ebp),%eax
  800bfa:	72 d9                	jb     800bd5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800bfc:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800bff:	c9                   	leave  
  800c00:	c3                   	ret    

00800c01 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c01:	55                   	push   %ebp
  800c02:	89 e5                	mov    %esp,%ebp
  800c04:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c11:	74 30                	je     800c43 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c13:	eb 16                	jmp    800c2b <strlcpy+0x2a>
			*dst++ = *src++;
  800c15:	8b 45 08             	mov    0x8(%ebp),%eax
  800c18:	8d 50 01             	lea    0x1(%eax),%edx
  800c1b:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c21:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c24:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c27:	8a 12                	mov    (%edx),%dl
  800c29:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c2b:	ff 4d 10             	decl   0x10(%ebp)
  800c2e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c32:	74 09                	je     800c3d <strlcpy+0x3c>
  800c34:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c37:	8a 00                	mov    (%eax),%al
  800c39:	84 c0                	test   %al,%al
  800c3b:	75 d8                	jne    800c15 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c40:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c43:	8b 55 08             	mov    0x8(%ebp),%edx
  800c46:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c49:	29 c2                	sub    %eax,%edx
  800c4b:	89 d0                	mov    %edx,%eax
}
  800c4d:	c9                   	leave  
  800c4e:	c3                   	ret    

00800c4f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c4f:	55                   	push   %ebp
  800c50:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c52:	eb 06                	jmp    800c5a <strcmp+0xb>
		p++, q++;
  800c54:	ff 45 08             	incl   0x8(%ebp)
  800c57:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5d:	8a 00                	mov    (%eax),%al
  800c5f:	84 c0                	test   %al,%al
  800c61:	74 0e                	je     800c71 <strcmp+0x22>
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
  800c66:	8a 10                	mov    (%eax),%dl
  800c68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c6b:	8a 00                	mov    (%eax),%al
  800c6d:	38 c2                	cmp    %al,%dl
  800c6f:	74 e3                	je     800c54 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	8a 00                	mov    (%eax),%al
  800c76:	0f b6 d0             	movzbl %al,%edx
  800c79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7c:	8a 00                	mov    (%eax),%al
  800c7e:	0f b6 c0             	movzbl %al,%eax
  800c81:	29 c2                	sub    %eax,%edx
  800c83:	89 d0                	mov    %edx,%eax
}
  800c85:	5d                   	pop    %ebp
  800c86:	c3                   	ret    

00800c87 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c87:	55                   	push   %ebp
  800c88:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c8a:	eb 09                	jmp    800c95 <strncmp+0xe>
		n--, p++, q++;
  800c8c:	ff 4d 10             	decl   0x10(%ebp)
  800c8f:	ff 45 08             	incl   0x8(%ebp)
  800c92:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c95:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c99:	74 17                	je     800cb2 <strncmp+0x2b>
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	84 c0                	test   %al,%al
  800ca2:	74 0e                	je     800cb2 <strncmp+0x2b>
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	8a 10                	mov    (%eax),%dl
  800ca9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cac:	8a 00                	mov    (%eax),%al
  800cae:	38 c2                	cmp    %al,%dl
  800cb0:	74 da                	je     800c8c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cb2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb6:	75 07                	jne    800cbf <strncmp+0x38>
		return 0;
  800cb8:	b8 00 00 00 00       	mov    $0x0,%eax
  800cbd:	eb 14                	jmp    800cd3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	0f b6 d0             	movzbl %al,%edx
  800cc7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cca:	8a 00                	mov    (%eax),%al
  800ccc:	0f b6 c0             	movzbl %al,%eax
  800ccf:	29 c2                	sub    %eax,%edx
  800cd1:	89 d0                	mov    %edx,%eax
}
  800cd3:	5d                   	pop    %ebp
  800cd4:	c3                   	ret    

00800cd5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800cd5:	55                   	push   %ebp
  800cd6:	89 e5                	mov    %esp,%ebp
  800cd8:	83 ec 04             	sub    $0x4,%esp
  800cdb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cde:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ce1:	eb 12                	jmp    800cf5 <strchr+0x20>
		if (*s == c)
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	8a 00                	mov    (%eax),%al
  800ce8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ceb:	75 05                	jne    800cf2 <strchr+0x1d>
			return (char *) s;
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	eb 11                	jmp    800d03 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800cf2:	ff 45 08             	incl   0x8(%ebp)
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	8a 00                	mov    (%eax),%al
  800cfa:	84 c0                	test   %al,%al
  800cfc:	75 e5                	jne    800ce3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800cfe:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d03:	c9                   	leave  
  800d04:	c3                   	ret    

00800d05 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d05:	55                   	push   %ebp
  800d06:	89 e5                	mov    %esp,%ebp
  800d08:	83 ec 04             	sub    $0x4,%esp
  800d0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d0e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d11:	eb 0d                	jmp    800d20 <strfind+0x1b>
		if (*s == c)
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d1b:	74 0e                	je     800d2b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d1d:	ff 45 08             	incl   0x8(%ebp)
  800d20:	8b 45 08             	mov    0x8(%ebp),%eax
  800d23:	8a 00                	mov    (%eax),%al
  800d25:	84 c0                	test   %al,%al
  800d27:	75 ea                	jne    800d13 <strfind+0xe>
  800d29:	eb 01                	jmp    800d2c <strfind+0x27>
		if (*s == c)
			break;
  800d2b:	90                   	nop
	return (char *) s;
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d2f:	c9                   	leave  
  800d30:	c3                   	ret    

00800d31 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d31:	55                   	push   %ebp
  800d32:	89 e5                	mov    %esp,%ebp
  800d34:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d37:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d40:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d43:	eb 0e                	jmp    800d53 <memset+0x22>
		*p++ = c;
  800d45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d48:	8d 50 01             	lea    0x1(%eax),%edx
  800d4b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d4e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d51:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d53:	ff 4d f8             	decl   -0x8(%ebp)
  800d56:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d5a:	79 e9                	jns    800d45 <memset+0x14>
		*p++ = c;

	return v;
  800d5c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d5f:	c9                   	leave  
  800d60:	c3                   	ret    

00800d61 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d61:	55                   	push   %ebp
  800d62:	89 e5                	mov    %esp,%ebp
  800d64:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d67:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d73:	eb 16                	jmp    800d8b <memcpy+0x2a>
		*d++ = *s++;
  800d75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d78:	8d 50 01             	lea    0x1(%eax),%edx
  800d7b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d7e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d81:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d84:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d87:	8a 12                	mov    (%edx),%dl
  800d89:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d8b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d8e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d91:	89 55 10             	mov    %edx,0x10(%ebp)
  800d94:	85 c0                	test   %eax,%eax
  800d96:	75 dd                	jne    800d75 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d98:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9b:	c9                   	leave  
  800d9c:	c3                   	ret    

00800d9d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d9d:	55                   	push   %ebp
  800d9e:	89 e5                	mov    %esp,%ebp
  800da0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800da3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800daf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800db2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800db5:	73 50                	jae    800e07 <memmove+0x6a>
  800db7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dba:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbd:	01 d0                	add    %edx,%eax
  800dbf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dc2:	76 43                	jbe    800e07 <memmove+0x6a>
		s += n;
  800dc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dca:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800dd0:	eb 10                	jmp    800de2 <memmove+0x45>
			*--d = *--s;
  800dd2:	ff 4d f8             	decl   -0x8(%ebp)
  800dd5:	ff 4d fc             	decl   -0x4(%ebp)
  800dd8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ddb:	8a 10                	mov    (%eax),%dl
  800ddd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800de2:	8b 45 10             	mov    0x10(%ebp),%eax
  800de5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800de8:	89 55 10             	mov    %edx,0x10(%ebp)
  800deb:	85 c0                	test   %eax,%eax
  800ded:	75 e3                	jne    800dd2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800def:	eb 23                	jmp    800e14 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800df1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df4:	8d 50 01             	lea    0x1(%eax),%edx
  800df7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dfa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dfd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e00:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e03:	8a 12                	mov    (%edx),%dl
  800e05:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e07:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e0d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e10:	85 c0                	test   %eax,%eax
  800e12:	75 dd                	jne    800df1 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e17:	c9                   	leave  
  800e18:	c3                   	ret    

00800e19 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e19:	55                   	push   %ebp
  800e1a:	89 e5                	mov    %esp,%ebp
  800e1c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e22:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e25:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e28:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e2b:	eb 2a                	jmp    800e57 <memcmp+0x3e>
		if (*s1 != *s2)
  800e2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e30:	8a 10                	mov    (%eax),%dl
  800e32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e35:	8a 00                	mov    (%eax),%al
  800e37:	38 c2                	cmp    %al,%dl
  800e39:	74 16                	je     800e51 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e3b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e3e:	8a 00                	mov    (%eax),%al
  800e40:	0f b6 d0             	movzbl %al,%edx
  800e43:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e46:	8a 00                	mov    (%eax),%al
  800e48:	0f b6 c0             	movzbl %al,%eax
  800e4b:	29 c2                	sub    %eax,%edx
  800e4d:	89 d0                	mov    %edx,%eax
  800e4f:	eb 18                	jmp    800e69 <memcmp+0x50>
		s1++, s2++;
  800e51:	ff 45 fc             	incl   -0x4(%ebp)
  800e54:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e57:	8b 45 10             	mov    0x10(%ebp),%eax
  800e5a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e5d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e60:	85 c0                	test   %eax,%eax
  800e62:	75 c9                	jne    800e2d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e64:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e69:	c9                   	leave  
  800e6a:	c3                   	ret    

00800e6b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e6b:	55                   	push   %ebp
  800e6c:	89 e5                	mov    %esp,%ebp
  800e6e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e71:	8b 55 08             	mov    0x8(%ebp),%edx
  800e74:	8b 45 10             	mov    0x10(%ebp),%eax
  800e77:	01 d0                	add    %edx,%eax
  800e79:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e7c:	eb 15                	jmp    800e93 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	8a 00                	mov    (%eax),%al
  800e83:	0f b6 d0             	movzbl %al,%edx
  800e86:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e89:	0f b6 c0             	movzbl %al,%eax
  800e8c:	39 c2                	cmp    %eax,%edx
  800e8e:	74 0d                	je     800e9d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e90:	ff 45 08             	incl   0x8(%ebp)
  800e93:	8b 45 08             	mov    0x8(%ebp),%eax
  800e96:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e99:	72 e3                	jb     800e7e <memfind+0x13>
  800e9b:	eb 01                	jmp    800e9e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e9d:	90                   	nop
	return (void *) s;
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ea1:	c9                   	leave  
  800ea2:	c3                   	ret    

00800ea3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ea3:	55                   	push   %ebp
  800ea4:	89 e5                	mov    %esp,%ebp
  800ea6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ea9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eb0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800eb7:	eb 03                	jmp    800ebc <strtol+0x19>
		s++;
  800eb9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebf:	8a 00                	mov    (%eax),%al
  800ec1:	3c 20                	cmp    $0x20,%al
  800ec3:	74 f4                	je     800eb9 <strtol+0x16>
  800ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec8:	8a 00                	mov    (%eax),%al
  800eca:	3c 09                	cmp    $0x9,%al
  800ecc:	74 eb                	je     800eb9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	3c 2b                	cmp    $0x2b,%al
  800ed5:	75 05                	jne    800edc <strtol+0x39>
		s++;
  800ed7:	ff 45 08             	incl   0x8(%ebp)
  800eda:	eb 13                	jmp    800eef <strtol+0x4c>
	else if (*s == '-')
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	8a 00                	mov    (%eax),%al
  800ee1:	3c 2d                	cmp    $0x2d,%al
  800ee3:	75 0a                	jne    800eef <strtol+0x4c>
		s++, neg = 1;
  800ee5:	ff 45 08             	incl   0x8(%ebp)
  800ee8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800eef:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef3:	74 06                	je     800efb <strtol+0x58>
  800ef5:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ef9:	75 20                	jne    800f1b <strtol+0x78>
  800efb:	8b 45 08             	mov    0x8(%ebp),%eax
  800efe:	8a 00                	mov    (%eax),%al
  800f00:	3c 30                	cmp    $0x30,%al
  800f02:	75 17                	jne    800f1b <strtol+0x78>
  800f04:	8b 45 08             	mov    0x8(%ebp),%eax
  800f07:	40                   	inc    %eax
  800f08:	8a 00                	mov    (%eax),%al
  800f0a:	3c 78                	cmp    $0x78,%al
  800f0c:	75 0d                	jne    800f1b <strtol+0x78>
		s += 2, base = 16;
  800f0e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f12:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f19:	eb 28                	jmp    800f43 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f1b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f1f:	75 15                	jne    800f36 <strtol+0x93>
  800f21:	8b 45 08             	mov    0x8(%ebp),%eax
  800f24:	8a 00                	mov    (%eax),%al
  800f26:	3c 30                	cmp    $0x30,%al
  800f28:	75 0c                	jne    800f36 <strtol+0x93>
		s++, base = 8;
  800f2a:	ff 45 08             	incl   0x8(%ebp)
  800f2d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f34:	eb 0d                	jmp    800f43 <strtol+0xa0>
	else if (base == 0)
  800f36:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f3a:	75 07                	jne    800f43 <strtol+0xa0>
		base = 10;
  800f3c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	8a 00                	mov    (%eax),%al
  800f48:	3c 2f                	cmp    $0x2f,%al
  800f4a:	7e 19                	jle    800f65 <strtol+0xc2>
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	3c 39                	cmp    $0x39,%al
  800f53:	7f 10                	jg     800f65 <strtol+0xc2>
			dig = *s - '0';
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	0f be c0             	movsbl %al,%eax
  800f5d:	83 e8 30             	sub    $0x30,%eax
  800f60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f63:	eb 42                	jmp    800fa7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	3c 60                	cmp    $0x60,%al
  800f6c:	7e 19                	jle    800f87 <strtol+0xe4>
  800f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	3c 7a                	cmp    $0x7a,%al
  800f75:	7f 10                	jg     800f87 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	0f be c0             	movsbl %al,%eax
  800f7f:	83 e8 57             	sub    $0x57,%eax
  800f82:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f85:	eb 20                	jmp    800fa7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	8a 00                	mov    (%eax),%al
  800f8c:	3c 40                	cmp    $0x40,%al
  800f8e:	7e 39                	jle    800fc9 <strtol+0x126>
  800f90:	8b 45 08             	mov    0x8(%ebp),%eax
  800f93:	8a 00                	mov    (%eax),%al
  800f95:	3c 5a                	cmp    $0x5a,%al
  800f97:	7f 30                	jg     800fc9 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	0f be c0             	movsbl %al,%eax
  800fa1:	83 e8 37             	sub    $0x37,%eax
  800fa4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800faa:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fad:	7d 19                	jge    800fc8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800faf:	ff 45 08             	incl   0x8(%ebp)
  800fb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb5:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fb9:	89 c2                	mov    %eax,%edx
  800fbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fbe:	01 d0                	add    %edx,%eax
  800fc0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fc3:	e9 7b ff ff ff       	jmp    800f43 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fc8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fc9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fcd:	74 08                	je     800fd7 <strtol+0x134>
		*endptr = (char *) s;
  800fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd2:	8b 55 08             	mov    0x8(%ebp),%edx
  800fd5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fd7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fdb:	74 07                	je     800fe4 <strtol+0x141>
  800fdd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fe0:	f7 d8                	neg    %eax
  800fe2:	eb 03                	jmp    800fe7 <strtol+0x144>
  800fe4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800fe7:	c9                   	leave  
  800fe8:	c3                   	ret    

00800fe9 <ltostr>:

void
ltostr(long value, char *str)
{
  800fe9:	55                   	push   %ebp
  800fea:	89 e5                	mov    %esp,%ebp
  800fec:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800ff6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ffd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801001:	79 13                	jns    801016 <ltostr+0x2d>
	{
		neg = 1;
  801003:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80100a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80100d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801010:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801013:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801016:	8b 45 08             	mov    0x8(%ebp),%eax
  801019:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80101e:	99                   	cltd   
  80101f:	f7 f9                	idiv   %ecx
  801021:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801024:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801027:	8d 50 01             	lea    0x1(%eax),%edx
  80102a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80102d:	89 c2                	mov    %eax,%edx
  80102f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801032:	01 d0                	add    %edx,%eax
  801034:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801037:	83 c2 30             	add    $0x30,%edx
  80103a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80103c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80103f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801044:	f7 e9                	imul   %ecx
  801046:	c1 fa 02             	sar    $0x2,%edx
  801049:	89 c8                	mov    %ecx,%eax
  80104b:	c1 f8 1f             	sar    $0x1f,%eax
  80104e:	29 c2                	sub    %eax,%edx
  801050:	89 d0                	mov    %edx,%eax
  801052:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801055:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801058:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80105d:	f7 e9                	imul   %ecx
  80105f:	c1 fa 02             	sar    $0x2,%edx
  801062:	89 c8                	mov    %ecx,%eax
  801064:	c1 f8 1f             	sar    $0x1f,%eax
  801067:	29 c2                	sub    %eax,%edx
  801069:	89 d0                	mov    %edx,%eax
  80106b:	c1 e0 02             	shl    $0x2,%eax
  80106e:	01 d0                	add    %edx,%eax
  801070:	01 c0                	add    %eax,%eax
  801072:	29 c1                	sub    %eax,%ecx
  801074:	89 ca                	mov    %ecx,%edx
  801076:	85 d2                	test   %edx,%edx
  801078:	75 9c                	jne    801016 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80107a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801081:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801084:	48                   	dec    %eax
  801085:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801088:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80108c:	74 3d                	je     8010cb <ltostr+0xe2>
		start = 1 ;
  80108e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801095:	eb 34                	jmp    8010cb <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801097:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80109a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80109d:	01 d0                	add    %edx,%eax
  80109f:	8a 00                	mov    (%eax),%al
  8010a1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010aa:	01 c2                	add    %eax,%edx
  8010ac:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b2:	01 c8                	add    %ecx,%eax
  8010b4:	8a 00                	mov    (%eax),%al
  8010b6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010b8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010be:	01 c2                	add    %eax,%edx
  8010c0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010c3:	88 02                	mov    %al,(%edx)
		start++ ;
  8010c5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010c8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010d1:	7c c4                	jl     801097 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010d3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	01 d0                	add    %edx,%eax
  8010db:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010de:	90                   	nop
  8010df:	c9                   	leave  
  8010e0:	c3                   	ret    

008010e1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010e1:	55                   	push   %ebp
  8010e2:	89 e5                	mov    %esp,%ebp
  8010e4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010e7:	ff 75 08             	pushl  0x8(%ebp)
  8010ea:	e8 54 fa ff ff       	call   800b43 <strlen>
  8010ef:	83 c4 04             	add    $0x4,%esp
  8010f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8010f5:	ff 75 0c             	pushl  0xc(%ebp)
  8010f8:	e8 46 fa ff ff       	call   800b43 <strlen>
  8010fd:	83 c4 04             	add    $0x4,%esp
  801100:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801103:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80110a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801111:	eb 17                	jmp    80112a <strcconcat+0x49>
		final[s] = str1[s] ;
  801113:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801116:	8b 45 10             	mov    0x10(%ebp),%eax
  801119:	01 c2                	add    %eax,%edx
  80111b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80111e:	8b 45 08             	mov    0x8(%ebp),%eax
  801121:	01 c8                	add    %ecx,%eax
  801123:	8a 00                	mov    (%eax),%al
  801125:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801127:	ff 45 fc             	incl   -0x4(%ebp)
  80112a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80112d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801130:	7c e1                	jl     801113 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801132:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801139:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801140:	eb 1f                	jmp    801161 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801142:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801145:	8d 50 01             	lea    0x1(%eax),%edx
  801148:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80114b:	89 c2                	mov    %eax,%edx
  80114d:	8b 45 10             	mov    0x10(%ebp),%eax
  801150:	01 c2                	add    %eax,%edx
  801152:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	01 c8                	add    %ecx,%eax
  80115a:	8a 00                	mov    (%eax),%al
  80115c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80115e:	ff 45 f8             	incl   -0x8(%ebp)
  801161:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801164:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801167:	7c d9                	jl     801142 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801169:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80116c:	8b 45 10             	mov    0x10(%ebp),%eax
  80116f:	01 d0                	add    %edx,%eax
  801171:	c6 00 00             	movb   $0x0,(%eax)
}
  801174:	90                   	nop
  801175:	c9                   	leave  
  801176:	c3                   	ret    

00801177 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801177:	55                   	push   %ebp
  801178:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80117a:	8b 45 14             	mov    0x14(%ebp),%eax
  80117d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801183:	8b 45 14             	mov    0x14(%ebp),%eax
  801186:	8b 00                	mov    (%eax),%eax
  801188:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80118f:	8b 45 10             	mov    0x10(%ebp),%eax
  801192:	01 d0                	add    %edx,%eax
  801194:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80119a:	eb 0c                	jmp    8011a8 <strsplit+0x31>
			*string++ = 0;
  80119c:	8b 45 08             	mov    0x8(%ebp),%eax
  80119f:	8d 50 01             	lea    0x1(%eax),%edx
  8011a2:	89 55 08             	mov    %edx,0x8(%ebp)
  8011a5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ab:	8a 00                	mov    (%eax),%al
  8011ad:	84 c0                	test   %al,%al
  8011af:	74 18                	je     8011c9 <strsplit+0x52>
  8011b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b4:	8a 00                	mov    (%eax),%al
  8011b6:	0f be c0             	movsbl %al,%eax
  8011b9:	50                   	push   %eax
  8011ba:	ff 75 0c             	pushl  0xc(%ebp)
  8011bd:	e8 13 fb ff ff       	call   800cd5 <strchr>
  8011c2:	83 c4 08             	add    $0x8,%esp
  8011c5:	85 c0                	test   %eax,%eax
  8011c7:	75 d3                	jne    80119c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cc:	8a 00                	mov    (%eax),%al
  8011ce:	84 c0                	test   %al,%al
  8011d0:	74 5a                	je     80122c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011d2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011d5:	8b 00                	mov    (%eax),%eax
  8011d7:	83 f8 0f             	cmp    $0xf,%eax
  8011da:	75 07                	jne    8011e3 <strsplit+0x6c>
		{
			return 0;
  8011dc:	b8 00 00 00 00       	mov    $0x0,%eax
  8011e1:	eb 66                	jmp    801249 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011e3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e6:	8b 00                	mov    (%eax),%eax
  8011e8:	8d 48 01             	lea    0x1(%eax),%ecx
  8011eb:	8b 55 14             	mov    0x14(%ebp),%edx
  8011ee:	89 0a                	mov    %ecx,(%edx)
  8011f0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fa:	01 c2                	add    %eax,%edx
  8011fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ff:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801201:	eb 03                	jmp    801206 <strsplit+0x8f>
			string++;
  801203:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801206:	8b 45 08             	mov    0x8(%ebp),%eax
  801209:	8a 00                	mov    (%eax),%al
  80120b:	84 c0                	test   %al,%al
  80120d:	74 8b                	je     80119a <strsplit+0x23>
  80120f:	8b 45 08             	mov    0x8(%ebp),%eax
  801212:	8a 00                	mov    (%eax),%al
  801214:	0f be c0             	movsbl %al,%eax
  801217:	50                   	push   %eax
  801218:	ff 75 0c             	pushl  0xc(%ebp)
  80121b:	e8 b5 fa ff ff       	call   800cd5 <strchr>
  801220:	83 c4 08             	add    $0x8,%esp
  801223:	85 c0                	test   %eax,%eax
  801225:	74 dc                	je     801203 <strsplit+0x8c>
			string++;
	}
  801227:	e9 6e ff ff ff       	jmp    80119a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80122c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80122d:	8b 45 14             	mov    0x14(%ebp),%eax
  801230:	8b 00                	mov    (%eax),%eax
  801232:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801239:	8b 45 10             	mov    0x10(%ebp),%eax
  80123c:	01 d0                	add    %edx,%eax
  80123e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801244:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801249:	c9                   	leave  
  80124a:	c3                   	ret    

0080124b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80124b:	55                   	push   %ebp
  80124c:	89 e5                	mov    %esp,%ebp
  80124e:	57                   	push   %edi
  80124f:	56                   	push   %esi
  801250:	53                   	push   %ebx
  801251:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801254:	8b 45 08             	mov    0x8(%ebp),%eax
  801257:	8b 55 0c             	mov    0xc(%ebp),%edx
  80125a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80125d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801260:	8b 7d 18             	mov    0x18(%ebp),%edi
  801263:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801266:	cd 30                	int    $0x30
  801268:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80126b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80126e:	83 c4 10             	add    $0x10,%esp
  801271:	5b                   	pop    %ebx
  801272:	5e                   	pop    %esi
  801273:	5f                   	pop    %edi
  801274:	5d                   	pop    %ebp
  801275:	c3                   	ret    

00801276 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801276:	55                   	push   %ebp
  801277:	89 e5                	mov    %esp,%ebp
  801279:	83 ec 04             	sub    $0x4,%esp
  80127c:	8b 45 10             	mov    0x10(%ebp),%eax
  80127f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801282:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801286:	8b 45 08             	mov    0x8(%ebp),%eax
  801289:	6a 00                	push   $0x0
  80128b:	6a 00                	push   $0x0
  80128d:	52                   	push   %edx
  80128e:	ff 75 0c             	pushl  0xc(%ebp)
  801291:	50                   	push   %eax
  801292:	6a 00                	push   $0x0
  801294:	e8 b2 ff ff ff       	call   80124b <syscall>
  801299:	83 c4 18             	add    $0x18,%esp
}
  80129c:	90                   	nop
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <sys_cgetc>:

int
sys_cgetc(void)
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 01                	push   $0x1
  8012ae:	e8 98 ff ff ff       	call   80124b <syscall>
  8012b3:	83 c4 18             	add    $0x18,%esp
}
  8012b6:	c9                   	leave  
  8012b7:	c3                   	ret    

008012b8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012b8:	55                   	push   %ebp
  8012b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	50                   	push   %eax
  8012c7:	6a 05                	push   $0x5
  8012c9:	e8 7d ff ff ff       	call   80124b <syscall>
  8012ce:	83 c4 18             	add    $0x18,%esp
}
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 02                	push   $0x2
  8012e2:	e8 64 ff ff ff       	call   80124b <syscall>
  8012e7:	83 c4 18             	add    $0x18,%esp
}
  8012ea:	c9                   	leave  
  8012eb:	c3                   	ret    

008012ec <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012ec:	55                   	push   %ebp
  8012ed:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012ef:	6a 00                	push   $0x0
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 03                	push   $0x3
  8012fb:	e8 4b ff ff ff       	call   80124b <syscall>
  801300:	83 c4 18             	add    $0x18,%esp
}
  801303:	c9                   	leave  
  801304:	c3                   	ret    

00801305 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801305:	55                   	push   %ebp
  801306:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801308:	6a 00                	push   $0x0
  80130a:	6a 00                	push   $0x0
  80130c:	6a 00                	push   $0x0
  80130e:	6a 00                	push   $0x0
  801310:	6a 00                	push   $0x0
  801312:	6a 04                	push   $0x4
  801314:	e8 32 ff ff ff       	call   80124b <syscall>
  801319:	83 c4 18             	add    $0x18,%esp
}
  80131c:	c9                   	leave  
  80131d:	c3                   	ret    

0080131e <sys_env_exit>:


void sys_env_exit(void)
{
  80131e:	55                   	push   %ebp
  80131f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801321:	6a 00                	push   $0x0
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	6a 00                	push   $0x0
  80132b:	6a 06                	push   $0x6
  80132d:	e8 19 ff ff ff       	call   80124b <syscall>
  801332:	83 c4 18             	add    $0x18,%esp
}
  801335:	90                   	nop
  801336:	c9                   	leave  
  801337:	c3                   	ret    

00801338 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801338:	55                   	push   %ebp
  801339:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80133b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133e:	8b 45 08             	mov    0x8(%ebp),%eax
  801341:	6a 00                	push   $0x0
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	52                   	push   %edx
  801348:	50                   	push   %eax
  801349:	6a 07                	push   $0x7
  80134b:	e8 fb fe ff ff       	call   80124b <syscall>
  801350:	83 c4 18             	add    $0x18,%esp
}
  801353:	c9                   	leave  
  801354:	c3                   	ret    

00801355 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801355:	55                   	push   %ebp
  801356:	89 e5                	mov    %esp,%ebp
  801358:	56                   	push   %esi
  801359:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80135a:	8b 75 18             	mov    0x18(%ebp),%esi
  80135d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801360:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801363:	8b 55 0c             	mov    0xc(%ebp),%edx
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	56                   	push   %esi
  80136a:	53                   	push   %ebx
  80136b:	51                   	push   %ecx
  80136c:	52                   	push   %edx
  80136d:	50                   	push   %eax
  80136e:	6a 08                	push   $0x8
  801370:	e8 d6 fe ff ff       	call   80124b <syscall>
  801375:	83 c4 18             	add    $0x18,%esp
}
  801378:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80137b:	5b                   	pop    %ebx
  80137c:	5e                   	pop    %esi
  80137d:	5d                   	pop    %ebp
  80137e:	c3                   	ret    

0080137f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80137f:	55                   	push   %ebp
  801380:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801382:	8b 55 0c             	mov    0xc(%ebp),%edx
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	52                   	push   %edx
  80138f:	50                   	push   %eax
  801390:	6a 09                	push   $0x9
  801392:	e8 b4 fe ff ff       	call   80124b <syscall>
  801397:	83 c4 18             	add    $0x18,%esp
}
  80139a:	c9                   	leave  
  80139b:	c3                   	ret    

0080139c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80139c:	55                   	push   %ebp
  80139d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80139f:	6a 00                	push   $0x0
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	ff 75 0c             	pushl  0xc(%ebp)
  8013a8:	ff 75 08             	pushl  0x8(%ebp)
  8013ab:	6a 0a                	push   $0xa
  8013ad:	e8 99 fe ff ff       	call   80124b <syscall>
  8013b2:	83 c4 18             	add    $0x18,%esp
}
  8013b5:	c9                   	leave  
  8013b6:	c3                   	ret    

008013b7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013ba:	6a 00                	push   $0x0
  8013bc:	6a 00                	push   $0x0
  8013be:	6a 00                	push   $0x0
  8013c0:	6a 00                	push   $0x0
  8013c2:	6a 00                	push   $0x0
  8013c4:	6a 0b                	push   $0xb
  8013c6:	e8 80 fe ff ff       	call   80124b <syscall>
  8013cb:	83 c4 18             	add    $0x18,%esp
}
  8013ce:	c9                   	leave  
  8013cf:	c3                   	ret    

008013d0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013d0:	55                   	push   %ebp
  8013d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	6a 00                	push   $0x0
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 0c                	push   $0xc
  8013df:	e8 67 fe ff ff       	call   80124b <syscall>
  8013e4:	83 c4 18             	add    $0x18,%esp
}
  8013e7:	c9                   	leave  
  8013e8:	c3                   	ret    

008013e9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013e9:	55                   	push   %ebp
  8013ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 0d                	push   $0xd
  8013f8:	e8 4e fe ff ff       	call   80124b <syscall>
  8013fd:	83 c4 18             	add    $0x18,%esp
}
  801400:	c9                   	leave  
  801401:	c3                   	ret    

00801402 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801402:	55                   	push   %ebp
  801403:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801405:	6a 00                	push   $0x0
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	ff 75 0c             	pushl  0xc(%ebp)
  80140e:	ff 75 08             	pushl  0x8(%ebp)
  801411:	6a 11                	push   $0x11
  801413:	e8 33 fe ff ff       	call   80124b <syscall>
  801418:	83 c4 18             	add    $0x18,%esp
	return;
  80141b:	90                   	nop
}
  80141c:	c9                   	leave  
  80141d:	c3                   	ret    

0080141e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80141e:	55                   	push   %ebp
  80141f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	ff 75 0c             	pushl  0xc(%ebp)
  80142a:	ff 75 08             	pushl  0x8(%ebp)
  80142d:	6a 12                	push   $0x12
  80142f:	e8 17 fe ff ff       	call   80124b <syscall>
  801434:	83 c4 18             	add    $0x18,%esp
	return ;
  801437:	90                   	nop
}
  801438:	c9                   	leave  
  801439:	c3                   	ret    

0080143a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80143a:	55                   	push   %ebp
  80143b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 0e                	push   $0xe
  801449:	e8 fd fd ff ff       	call   80124b <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
}
  801451:	c9                   	leave  
  801452:	c3                   	ret    

00801453 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801453:	55                   	push   %ebp
  801454:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801456:	6a 00                	push   $0x0
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	ff 75 08             	pushl  0x8(%ebp)
  801461:	6a 0f                	push   $0xf
  801463:	e8 e3 fd ff ff       	call   80124b <syscall>
  801468:	83 c4 18             	add    $0x18,%esp
}
  80146b:	c9                   	leave  
  80146c:	c3                   	ret    

0080146d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80146d:	55                   	push   %ebp
  80146e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 10                	push   $0x10
  80147c:	e8 ca fd ff ff       	call   80124b <syscall>
  801481:	83 c4 18             	add    $0x18,%esp
}
  801484:	90                   	nop
  801485:	c9                   	leave  
  801486:	c3                   	ret    

00801487 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 00                	push   $0x0
  801492:	6a 00                	push   $0x0
  801494:	6a 14                	push   $0x14
  801496:	e8 b0 fd ff ff       	call   80124b <syscall>
  80149b:	83 c4 18             	add    $0x18,%esp
}
  80149e:	90                   	nop
  80149f:	c9                   	leave  
  8014a0:	c3                   	ret    

008014a1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014a1:	55                   	push   %ebp
  8014a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 15                	push   $0x15
  8014b0:	e8 96 fd ff ff       	call   80124b <syscall>
  8014b5:	83 c4 18             	add    $0x18,%esp
}
  8014b8:	90                   	nop
  8014b9:	c9                   	leave  
  8014ba:	c3                   	ret    

008014bb <sys_cputc>:


void
sys_cputc(const char c)
{
  8014bb:	55                   	push   %ebp
  8014bc:	89 e5                	mov    %esp,%ebp
  8014be:	83 ec 04             	sub    $0x4,%esp
  8014c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014c7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014cb:	6a 00                	push   $0x0
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	50                   	push   %eax
  8014d4:	6a 16                	push   $0x16
  8014d6:	e8 70 fd ff ff       	call   80124b <syscall>
  8014db:	83 c4 18             	add    $0x18,%esp
}
  8014de:	90                   	nop
  8014df:	c9                   	leave  
  8014e0:	c3                   	ret    

008014e1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014e1:	55                   	push   %ebp
  8014e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 17                	push   $0x17
  8014f0:	e8 56 fd ff ff       	call   80124b <syscall>
  8014f5:	83 c4 18             	add    $0x18,%esp
}
  8014f8:	90                   	nop
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8014fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	ff 75 0c             	pushl  0xc(%ebp)
  80150a:	50                   	push   %eax
  80150b:	6a 18                	push   $0x18
  80150d:	e8 39 fd ff ff       	call   80124b <syscall>
  801512:	83 c4 18             	add    $0x18,%esp
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80151a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80151d:	8b 45 08             	mov    0x8(%ebp),%eax
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	52                   	push   %edx
  801527:	50                   	push   %eax
  801528:	6a 1b                	push   $0x1b
  80152a:	e8 1c fd ff ff       	call   80124b <syscall>
  80152f:	83 c4 18             	add    $0x18,%esp
}
  801532:	c9                   	leave  
  801533:	c3                   	ret    

00801534 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801534:	55                   	push   %ebp
  801535:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801537:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153a:	8b 45 08             	mov    0x8(%ebp),%eax
  80153d:	6a 00                	push   $0x0
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	52                   	push   %edx
  801544:	50                   	push   %eax
  801545:	6a 19                	push   $0x19
  801547:	e8 ff fc ff ff       	call   80124b <syscall>
  80154c:	83 c4 18             	add    $0x18,%esp
}
  80154f:	90                   	nop
  801550:	c9                   	leave  
  801551:	c3                   	ret    

00801552 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801552:	55                   	push   %ebp
  801553:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801555:	8b 55 0c             	mov    0xc(%ebp),%edx
  801558:	8b 45 08             	mov    0x8(%ebp),%eax
  80155b:	6a 00                	push   $0x0
  80155d:	6a 00                	push   $0x0
  80155f:	6a 00                	push   $0x0
  801561:	52                   	push   %edx
  801562:	50                   	push   %eax
  801563:	6a 1a                	push   $0x1a
  801565:	e8 e1 fc ff ff       	call   80124b <syscall>
  80156a:	83 c4 18             	add    $0x18,%esp
}
  80156d:	90                   	nop
  80156e:	c9                   	leave  
  80156f:	c3                   	ret    

00801570 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801570:	55                   	push   %ebp
  801571:	89 e5                	mov    %esp,%ebp
  801573:	83 ec 04             	sub    $0x4,%esp
  801576:	8b 45 10             	mov    0x10(%ebp),%eax
  801579:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80157c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80157f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	6a 00                	push   $0x0
  801588:	51                   	push   %ecx
  801589:	52                   	push   %edx
  80158a:	ff 75 0c             	pushl  0xc(%ebp)
  80158d:	50                   	push   %eax
  80158e:	6a 1c                	push   $0x1c
  801590:	e8 b6 fc ff ff       	call   80124b <syscall>
  801595:	83 c4 18             	add    $0x18,%esp
}
  801598:	c9                   	leave  
  801599:	c3                   	ret    

0080159a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80159a:	55                   	push   %ebp
  80159b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80159d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	52                   	push   %edx
  8015aa:	50                   	push   %eax
  8015ab:	6a 1d                	push   $0x1d
  8015ad:	e8 99 fc ff ff       	call   80124b <syscall>
  8015b2:	83 c4 18             	add    $0x18,%esp
}
  8015b5:	c9                   	leave  
  8015b6:	c3                   	ret    

008015b7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015b7:	55                   	push   %ebp
  8015b8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015ba:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c3:	6a 00                	push   $0x0
  8015c5:	6a 00                	push   $0x0
  8015c7:	51                   	push   %ecx
  8015c8:	52                   	push   %edx
  8015c9:	50                   	push   %eax
  8015ca:	6a 1e                	push   $0x1e
  8015cc:	e8 7a fc ff ff       	call   80124b <syscall>
  8015d1:	83 c4 18             	add    $0x18,%esp
}
  8015d4:	c9                   	leave  
  8015d5:	c3                   	ret    

008015d6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015d6:	55                   	push   %ebp
  8015d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	6a 00                	push   $0x0
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	52                   	push   %edx
  8015e6:	50                   	push   %eax
  8015e7:	6a 1f                	push   $0x1f
  8015e9:	e8 5d fc ff ff       	call   80124b <syscall>
  8015ee:	83 c4 18             	add    $0x18,%esp
}
  8015f1:	c9                   	leave  
  8015f2:	c3                   	ret    

008015f3 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8015f3:	55                   	push   %ebp
  8015f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8015f6:	6a 00                	push   $0x0
  8015f8:	6a 00                	push   $0x0
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 20                	push   $0x20
  801602:	e8 44 fc ff ff       	call   80124b <syscall>
  801607:	83 c4 18             	add    $0x18,%esp
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	6a 00                	push   $0x0
  801614:	ff 75 14             	pushl  0x14(%ebp)
  801617:	ff 75 10             	pushl  0x10(%ebp)
  80161a:	ff 75 0c             	pushl  0xc(%ebp)
  80161d:	50                   	push   %eax
  80161e:	6a 21                	push   $0x21
  801620:	e8 26 fc ff ff       	call   80124b <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
}
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	50                   	push   %eax
  801639:	6a 22                	push   $0x22
  80163b:	e8 0b fc ff ff       	call   80124b <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
}
  801643:	90                   	nop
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801649:	8b 45 08             	mov    0x8(%ebp),%eax
  80164c:	6a 00                	push   $0x0
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	50                   	push   %eax
  801655:	6a 23                	push   $0x23
  801657:	e8 ef fb ff ff       	call   80124b <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
}
  80165f:	90                   	nop
  801660:	c9                   	leave  
  801661:	c3                   	ret    

00801662 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
  801665:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801668:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80166b:	8d 50 04             	lea    0x4(%eax),%edx
  80166e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801671:	6a 00                	push   $0x0
  801673:	6a 00                	push   $0x0
  801675:	6a 00                	push   $0x0
  801677:	52                   	push   %edx
  801678:	50                   	push   %eax
  801679:	6a 24                	push   $0x24
  80167b:	e8 cb fb ff ff       	call   80124b <syscall>
  801680:	83 c4 18             	add    $0x18,%esp
	return result;
  801683:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801686:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801689:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80168c:	89 01                	mov    %eax,(%ecx)
  80168e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801691:	8b 45 08             	mov    0x8(%ebp),%eax
  801694:	c9                   	leave  
  801695:	c2 04 00             	ret    $0x4

00801698 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801698:	55                   	push   %ebp
  801699:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	ff 75 10             	pushl  0x10(%ebp)
  8016a2:	ff 75 0c             	pushl  0xc(%ebp)
  8016a5:	ff 75 08             	pushl  0x8(%ebp)
  8016a8:	6a 13                	push   $0x13
  8016aa:	e8 9c fb ff ff       	call   80124b <syscall>
  8016af:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b2:	90                   	nop
}
  8016b3:	c9                   	leave  
  8016b4:	c3                   	ret    

008016b5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016b5:	55                   	push   %ebp
  8016b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 00                	push   $0x0
  8016be:	6a 00                	push   $0x0
  8016c0:	6a 00                	push   $0x0
  8016c2:	6a 25                	push   $0x25
  8016c4:	e8 82 fb ff ff       	call   80124b <syscall>
  8016c9:	83 c4 18             	add    $0x18,%esp
}
  8016cc:	c9                   	leave  
  8016cd:	c3                   	ret    

008016ce <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
  8016d1:	83 ec 04             	sub    $0x4,%esp
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016da:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	6a 00                	push   $0x0
  8016e6:	50                   	push   %eax
  8016e7:	6a 26                	push   $0x26
  8016e9:	e8 5d fb ff ff       	call   80124b <syscall>
  8016ee:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f1:	90                   	nop
}
  8016f2:	c9                   	leave  
  8016f3:	c3                   	ret    

008016f4 <rsttst>:
void rsttst()
{
  8016f4:	55                   	push   %ebp
  8016f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 00                	push   $0x0
  8016ff:	6a 00                	push   $0x0
  801701:	6a 28                	push   $0x28
  801703:	e8 43 fb ff ff       	call   80124b <syscall>
  801708:	83 c4 18             	add    $0x18,%esp
	return ;
  80170b:	90                   	nop
}
  80170c:	c9                   	leave  
  80170d:	c3                   	ret    

0080170e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80170e:	55                   	push   %ebp
  80170f:	89 e5                	mov    %esp,%ebp
  801711:	83 ec 04             	sub    $0x4,%esp
  801714:	8b 45 14             	mov    0x14(%ebp),%eax
  801717:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80171a:	8b 55 18             	mov    0x18(%ebp),%edx
  80171d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801721:	52                   	push   %edx
  801722:	50                   	push   %eax
  801723:	ff 75 10             	pushl  0x10(%ebp)
  801726:	ff 75 0c             	pushl  0xc(%ebp)
  801729:	ff 75 08             	pushl  0x8(%ebp)
  80172c:	6a 27                	push   $0x27
  80172e:	e8 18 fb ff ff       	call   80124b <syscall>
  801733:	83 c4 18             	add    $0x18,%esp
	return ;
  801736:	90                   	nop
}
  801737:	c9                   	leave  
  801738:	c3                   	ret    

00801739 <chktst>:
void chktst(uint32 n)
{
  801739:	55                   	push   %ebp
  80173a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	ff 75 08             	pushl  0x8(%ebp)
  801747:	6a 29                	push   $0x29
  801749:	e8 fd fa ff ff       	call   80124b <syscall>
  80174e:	83 c4 18             	add    $0x18,%esp
	return ;
  801751:	90                   	nop
}
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <inctst>:

void inctst()
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801757:	6a 00                	push   $0x0
  801759:	6a 00                	push   $0x0
  80175b:	6a 00                	push   $0x0
  80175d:	6a 00                	push   $0x0
  80175f:	6a 00                	push   $0x0
  801761:	6a 2a                	push   $0x2a
  801763:	e8 e3 fa ff ff       	call   80124b <syscall>
  801768:	83 c4 18             	add    $0x18,%esp
	return ;
  80176b:	90                   	nop
}
  80176c:	c9                   	leave  
  80176d:	c3                   	ret    

0080176e <gettst>:
uint32 gettst()
{
  80176e:	55                   	push   %ebp
  80176f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 2b                	push   $0x2b
  80177d:	e8 c9 fa ff ff       	call   80124b <syscall>
  801782:	83 c4 18             	add    $0x18,%esp
}
  801785:	c9                   	leave  
  801786:	c3                   	ret    

00801787 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801787:	55                   	push   %ebp
  801788:	89 e5                	mov    %esp,%ebp
  80178a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 2c                	push   $0x2c
  801799:	e8 ad fa ff ff       	call   80124b <syscall>
  80179e:	83 c4 18             	add    $0x18,%esp
  8017a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017a4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017a8:	75 07                	jne    8017b1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017aa:	b8 01 00 00 00       	mov    $0x1,%eax
  8017af:	eb 05                	jmp    8017b6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017b1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017b6:	c9                   	leave  
  8017b7:	c3                   	ret    

008017b8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017b8:	55                   	push   %ebp
  8017b9:	89 e5                	mov    %esp,%ebp
  8017bb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 00                	push   $0x0
  8017c8:	6a 2c                	push   $0x2c
  8017ca:	e8 7c fa ff ff       	call   80124b <syscall>
  8017cf:	83 c4 18             	add    $0x18,%esp
  8017d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017d5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017d9:	75 07                	jne    8017e2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017db:	b8 01 00 00 00       	mov    $0x1,%eax
  8017e0:	eb 05                	jmp    8017e7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017e2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e7:	c9                   	leave  
  8017e8:	c3                   	ret    

008017e9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017e9:	55                   	push   %ebp
  8017ea:	89 e5                	mov    %esp,%ebp
  8017ec:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 2c                	push   $0x2c
  8017fb:	e8 4b fa ff ff       	call   80124b <syscall>
  801800:	83 c4 18             	add    $0x18,%esp
  801803:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801806:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80180a:	75 07                	jne    801813 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80180c:	b8 01 00 00 00       	mov    $0x1,%eax
  801811:	eb 05                	jmp    801818 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801813:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801818:	c9                   	leave  
  801819:	c3                   	ret    

0080181a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80181a:	55                   	push   %ebp
  80181b:	89 e5                	mov    %esp,%ebp
  80181d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 00                	push   $0x0
  80182a:	6a 2c                	push   $0x2c
  80182c:	e8 1a fa ff ff       	call   80124b <syscall>
  801831:	83 c4 18             	add    $0x18,%esp
  801834:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801837:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80183b:	75 07                	jne    801844 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80183d:	b8 01 00 00 00       	mov    $0x1,%eax
  801842:	eb 05                	jmp    801849 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801844:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80184e:	6a 00                	push   $0x0
  801850:	6a 00                	push   $0x0
  801852:	6a 00                	push   $0x0
  801854:	6a 00                	push   $0x0
  801856:	ff 75 08             	pushl  0x8(%ebp)
  801859:	6a 2d                	push   $0x2d
  80185b:	e8 eb f9 ff ff       	call   80124b <syscall>
  801860:	83 c4 18             	add    $0x18,%esp
	return ;
  801863:	90                   	nop
}
  801864:	c9                   	leave  
  801865:	c3                   	ret    

00801866 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801866:	55                   	push   %ebp
  801867:	89 e5                	mov    %esp,%ebp
  801869:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80186a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80186d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801870:	8b 55 0c             	mov    0xc(%ebp),%edx
  801873:	8b 45 08             	mov    0x8(%ebp),%eax
  801876:	6a 00                	push   $0x0
  801878:	53                   	push   %ebx
  801879:	51                   	push   %ecx
  80187a:	52                   	push   %edx
  80187b:	50                   	push   %eax
  80187c:	6a 2e                	push   $0x2e
  80187e:	e8 c8 f9 ff ff       	call   80124b <syscall>
  801883:	83 c4 18             	add    $0x18,%esp
}
  801886:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801889:	c9                   	leave  
  80188a:	c3                   	ret    

0080188b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80188b:	55                   	push   %ebp
  80188c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80188e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801891:	8b 45 08             	mov    0x8(%ebp),%eax
  801894:	6a 00                	push   $0x0
  801896:	6a 00                	push   $0x0
  801898:	6a 00                	push   $0x0
  80189a:	52                   	push   %edx
  80189b:	50                   	push   %eax
  80189c:	6a 2f                	push   $0x2f
  80189e:	e8 a8 f9 ff ff       	call   80124b <syscall>
  8018a3:	83 c4 18             	add    $0x18,%esp
}
  8018a6:	c9                   	leave  
  8018a7:	c3                   	ret    

008018a8 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018a8:	55                   	push   %ebp
  8018a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	ff 75 0c             	pushl  0xc(%ebp)
  8018b4:	ff 75 08             	pushl  0x8(%ebp)
  8018b7:	6a 30                	push   $0x30
  8018b9:	e8 8d f9 ff ff       	call   80124b <syscall>
  8018be:	83 c4 18             	add    $0x18,%esp
	return ;
  8018c1:	90                   	nop
}
  8018c2:	c9                   	leave  
  8018c3:	c3                   	ret    

008018c4 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8018c4:	55                   	push   %ebp
  8018c5:	89 e5                	mov    %esp,%ebp
  8018c7:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8018ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cd:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8018d0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8018d4:	83 ec 0c             	sub    $0xc,%esp
  8018d7:	50                   	push   %eax
  8018d8:	e8 de fb ff ff       	call   8014bb <sys_cputc>
  8018dd:	83 c4 10             	add    $0x10,%esp
}
  8018e0:	90                   	nop
  8018e1:	c9                   	leave  
  8018e2:	c3                   	ret    

008018e3 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8018e3:	55                   	push   %ebp
  8018e4:	89 e5                	mov    %esp,%ebp
  8018e6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8018e9:	e8 99 fb ff ff       	call   801487 <sys_disable_interrupt>
	char c = ch;
  8018ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8018f4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8018f8:	83 ec 0c             	sub    $0xc,%esp
  8018fb:	50                   	push   %eax
  8018fc:	e8 ba fb ff ff       	call   8014bb <sys_cputc>
  801901:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801904:	e8 98 fb ff ff       	call   8014a1 <sys_enable_interrupt>
}
  801909:	90                   	nop
  80190a:	c9                   	leave  
  80190b:	c3                   	ret    

0080190c <getchar>:

int
getchar(void)
{
  80190c:	55                   	push   %ebp
  80190d:	89 e5                	mov    %esp,%ebp
  80190f:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  801912:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801919:	eb 08                	jmp    801923 <getchar+0x17>
	{
		c = sys_cgetc();
  80191b:	e8 7f f9 ff ff       	call   80129f <sys_cgetc>
  801920:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  801923:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801927:	74 f2                	je     80191b <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801929:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80192c:	c9                   	leave  
  80192d:	c3                   	ret    

0080192e <atomic_getchar>:

int
atomic_getchar(void)
{
  80192e:	55                   	push   %ebp
  80192f:	89 e5                	mov    %esp,%ebp
  801931:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801934:	e8 4e fb ff ff       	call   801487 <sys_disable_interrupt>
	int c=0;
  801939:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801940:	eb 08                	jmp    80194a <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801942:	e8 58 f9 ff ff       	call   80129f <sys_cgetc>
  801947:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80194a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80194e:	74 f2                	je     801942 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801950:	e8 4c fb ff ff       	call   8014a1 <sys_enable_interrupt>
	return c;
  801955:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801958:	c9                   	leave  
  801959:	c3                   	ret    

0080195a <iscons>:

int iscons(int fdnum)
{
  80195a:	55                   	push   %ebp
  80195b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80195d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801962:	5d                   	pop    %ebp
  801963:	c3                   	ret    

00801964 <__udivdi3>:
  801964:	55                   	push   %ebp
  801965:	57                   	push   %edi
  801966:	56                   	push   %esi
  801967:	53                   	push   %ebx
  801968:	83 ec 1c             	sub    $0x1c,%esp
  80196b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80196f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801973:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801977:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80197b:	89 ca                	mov    %ecx,%edx
  80197d:	89 f8                	mov    %edi,%eax
  80197f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801983:	85 f6                	test   %esi,%esi
  801985:	75 2d                	jne    8019b4 <__udivdi3+0x50>
  801987:	39 cf                	cmp    %ecx,%edi
  801989:	77 65                	ja     8019f0 <__udivdi3+0x8c>
  80198b:	89 fd                	mov    %edi,%ebp
  80198d:	85 ff                	test   %edi,%edi
  80198f:	75 0b                	jne    80199c <__udivdi3+0x38>
  801991:	b8 01 00 00 00       	mov    $0x1,%eax
  801996:	31 d2                	xor    %edx,%edx
  801998:	f7 f7                	div    %edi
  80199a:	89 c5                	mov    %eax,%ebp
  80199c:	31 d2                	xor    %edx,%edx
  80199e:	89 c8                	mov    %ecx,%eax
  8019a0:	f7 f5                	div    %ebp
  8019a2:	89 c1                	mov    %eax,%ecx
  8019a4:	89 d8                	mov    %ebx,%eax
  8019a6:	f7 f5                	div    %ebp
  8019a8:	89 cf                	mov    %ecx,%edi
  8019aa:	89 fa                	mov    %edi,%edx
  8019ac:	83 c4 1c             	add    $0x1c,%esp
  8019af:	5b                   	pop    %ebx
  8019b0:	5e                   	pop    %esi
  8019b1:	5f                   	pop    %edi
  8019b2:	5d                   	pop    %ebp
  8019b3:	c3                   	ret    
  8019b4:	39 ce                	cmp    %ecx,%esi
  8019b6:	77 28                	ja     8019e0 <__udivdi3+0x7c>
  8019b8:	0f bd fe             	bsr    %esi,%edi
  8019bb:	83 f7 1f             	xor    $0x1f,%edi
  8019be:	75 40                	jne    801a00 <__udivdi3+0x9c>
  8019c0:	39 ce                	cmp    %ecx,%esi
  8019c2:	72 0a                	jb     8019ce <__udivdi3+0x6a>
  8019c4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019c8:	0f 87 9e 00 00 00    	ja     801a6c <__udivdi3+0x108>
  8019ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8019d3:	89 fa                	mov    %edi,%edx
  8019d5:	83 c4 1c             	add    $0x1c,%esp
  8019d8:	5b                   	pop    %ebx
  8019d9:	5e                   	pop    %esi
  8019da:	5f                   	pop    %edi
  8019db:	5d                   	pop    %ebp
  8019dc:	c3                   	ret    
  8019dd:	8d 76 00             	lea    0x0(%esi),%esi
  8019e0:	31 ff                	xor    %edi,%edi
  8019e2:	31 c0                	xor    %eax,%eax
  8019e4:	89 fa                	mov    %edi,%edx
  8019e6:	83 c4 1c             	add    $0x1c,%esp
  8019e9:	5b                   	pop    %ebx
  8019ea:	5e                   	pop    %esi
  8019eb:	5f                   	pop    %edi
  8019ec:	5d                   	pop    %ebp
  8019ed:	c3                   	ret    
  8019ee:	66 90                	xchg   %ax,%ax
  8019f0:	89 d8                	mov    %ebx,%eax
  8019f2:	f7 f7                	div    %edi
  8019f4:	31 ff                	xor    %edi,%edi
  8019f6:	89 fa                	mov    %edi,%edx
  8019f8:	83 c4 1c             	add    $0x1c,%esp
  8019fb:	5b                   	pop    %ebx
  8019fc:	5e                   	pop    %esi
  8019fd:	5f                   	pop    %edi
  8019fe:	5d                   	pop    %ebp
  8019ff:	c3                   	ret    
  801a00:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a05:	89 eb                	mov    %ebp,%ebx
  801a07:	29 fb                	sub    %edi,%ebx
  801a09:	89 f9                	mov    %edi,%ecx
  801a0b:	d3 e6                	shl    %cl,%esi
  801a0d:	89 c5                	mov    %eax,%ebp
  801a0f:	88 d9                	mov    %bl,%cl
  801a11:	d3 ed                	shr    %cl,%ebp
  801a13:	89 e9                	mov    %ebp,%ecx
  801a15:	09 f1                	or     %esi,%ecx
  801a17:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a1b:	89 f9                	mov    %edi,%ecx
  801a1d:	d3 e0                	shl    %cl,%eax
  801a1f:	89 c5                	mov    %eax,%ebp
  801a21:	89 d6                	mov    %edx,%esi
  801a23:	88 d9                	mov    %bl,%cl
  801a25:	d3 ee                	shr    %cl,%esi
  801a27:	89 f9                	mov    %edi,%ecx
  801a29:	d3 e2                	shl    %cl,%edx
  801a2b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a2f:	88 d9                	mov    %bl,%cl
  801a31:	d3 e8                	shr    %cl,%eax
  801a33:	09 c2                	or     %eax,%edx
  801a35:	89 d0                	mov    %edx,%eax
  801a37:	89 f2                	mov    %esi,%edx
  801a39:	f7 74 24 0c          	divl   0xc(%esp)
  801a3d:	89 d6                	mov    %edx,%esi
  801a3f:	89 c3                	mov    %eax,%ebx
  801a41:	f7 e5                	mul    %ebp
  801a43:	39 d6                	cmp    %edx,%esi
  801a45:	72 19                	jb     801a60 <__udivdi3+0xfc>
  801a47:	74 0b                	je     801a54 <__udivdi3+0xf0>
  801a49:	89 d8                	mov    %ebx,%eax
  801a4b:	31 ff                	xor    %edi,%edi
  801a4d:	e9 58 ff ff ff       	jmp    8019aa <__udivdi3+0x46>
  801a52:	66 90                	xchg   %ax,%ax
  801a54:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a58:	89 f9                	mov    %edi,%ecx
  801a5a:	d3 e2                	shl    %cl,%edx
  801a5c:	39 c2                	cmp    %eax,%edx
  801a5e:	73 e9                	jae    801a49 <__udivdi3+0xe5>
  801a60:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a63:	31 ff                	xor    %edi,%edi
  801a65:	e9 40 ff ff ff       	jmp    8019aa <__udivdi3+0x46>
  801a6a:	66 90                	xchg   %ax,%ax
  801a6c:	31 c0                	xor    %eax,%eax
  801a6e:	e9 37 ff ff ff       	jmp    8019aa <__udivdi3+0x46>
  801a73:	90                   	nop

00801a74 <__umoddi3>:
  801a74:	55                   	push   %ebp
  801a75:	57                   	push   %edi
  801a76:	56                   	push   %esi
  801a77:	53                   	push   %ebx
  801a78:	83 ec 1c             	sub    $0x1c,%esp
  801a7b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a7f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a83:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a87:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a8b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a8f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a93:	89 f3                	mov    %esi,%ebx
  801a95:	89 fa                	mov    %edi,%edx
  801a97:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a9b:	89 34 24             	mov    %esi,(%esp)
  801a9e:	85 c0                	test   %eax,%eax
  801aa0:	75 1a                	jne    801abc <__umoddi3+0x48>
  801aa2:	39 f7                	cmp    %esi,%edi
  801aa4:	0f 86 a2 00 00 00    	jbe    801b4c <__umoddi3+0xd8>
  801aaa:	89 c8                	mov    %ecx,%eax
  801aac:	89 f2                	mov    %esi,%edx
  801aae:	f7 f7                	div    %edi
  801ab0:	89 d0                	mov    %edx,%eax
  801ab2:	31 d2                	xor    %edx,%edx
  801ab4:	83 c4 1c             	add    $0x1c,%esp
  801ab7:	5b                   	pop    %ebx
  801ab8:	5e                   	pop    %esi
  801ab9:	5f                   	pop    %edi
  801aba:	5d                   	pop    %ebp
  801abb:	c3                   	ret    
  801abc:	39 f0                	cmp    %esi,%eax
  801abe:	0f 87 ac 00 00 00    	ja     801b70 <__umoddi3+0xfc>
  801ac4:	0f bd e8             	bsr    %eax,%ebp
  801ac7:	83 f5 1f             	xor    $0x1f,%ebp
  801aca:	0f 84 ac 00 00 00    	je     801b7c <__umoddi3+0x108>
  801ad0:	bf 20 00 00 00       	mov    $0x20,%edi
  801ad5:	29 ef                	sub    %ebp,%edi
  801ad7:	89 fe                	mov    %edi,%esi
  801ad9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801add:	89 e9                	mov    %ebp,%ecx
  801adf:	d3 e0                	shl    %cl,%eax
  801ae1:	89 d7                	mov    %edx,%edi
  801ae3:	89 f1                	mov    %esi,%ecx
  801ae5:	d3 ef                	shr    %cl,%edi
  801ae7:	09 c7                	or     %eax,%edi
  801ae9:	89 e9                	mov    %ebp,%ecx
  801aeb:	d3 e2                	shl    %cl,%edx
  801aed:	89 14 24             	mov    %edx,(%esp)
  801af0:	89 d8                	mov    %ebx,%eax
  801af2:	d3 e0                	shl    %cl,%eax
  801af4:	89 c2                	mov    %eax,%edx
  801af6:	8b 44 24 08          	mov    0x8(%esp),%eax
  801afa:	d3 e0                	shl    %cl,%eax
  801afc:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b00:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b04:	89 f1                	mov    %esi,%ecx
  801b06:	d3 e8                	shr    %cl,%eax
  801b08:	09 d0                	or     %edx,%eax
  801b0a:	d3 eb                	shr    %cl,%ebx
  801b0c:	89 da                	mov    %ebx,%edx
  801b0e:	f7 f7                	div    %edi
  801b10:	89 d3                	mov    %edx,%ebx
  801b12:	f7 24 24             	mull   (%esp)
  801b15:	89 c6                	mov    %eax,%esi
  801b17:	89 d1                	mov    %edx,%ecx
  801b19:	39 d3                	cmp    %edx,%ebx
  801b1b:	0f 82 87 00 00 00    	jb     801ba8 <__umoddi3+0x134>
  801b21:	0f 84 91 00 00 00    	je     801bb8 <__umoddi3+0x144>
  801b27:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b2b:	29 f2                	sub    %esi,%edx
  801b2d:	19 cb                	sbb    %ecx,%ebx
  801b2f:	89 d8                	mov    %ebx,%eax
  801b31:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b35:	d3 e0                	shl    %cl,%eax
  801b37:	89 e9                	mov    %ebp,%ecx
  801b39:	d3 ea                	shr    %cl,%edx
  801b3b:	09 d0                	or     %edx,%eax
  801b3d:	89 e9                	mov    %ebp,%ecx
  801b3f:	d3 eb                	shr    %cl,%ebx
  801b41:	89 da                	mov    %ebx,%edx
  801b43:	83 c4 1c             	add    $0x1c,%esp
  801b46:	5b                   	pop    %ebx
  801b47:	5e                   	pop    %esi
  801b48:	5f                   	pop    %edi
  801b49:	5d                   	pop    %ebp
  801b4a:	c3                   	ret    
  801b4b:	90                   	nop
  801b4c:	89 fd                	mov    %edi,%ebp
  801b4e:	85 ff                	test   %edi,%edi
  801b50:	75 0b                	jne    801b5d <__umoddi3+0xe9>
  801b52:	b8 01 00 00 00       	mov    $0x1,%eax
  801b57:	31 d2                	xor    %edx,%edx
  801b59:	f7 f7                	div    %edi
  801b5b:	89 c5                	mov    %eax,%ebp
  801b5d:	89 f0                	mov    %esi,%eax
  801b5f:	31 d2                	xor    %edx,%edx
  801b61:	f7 f5                	div    %ebp
  801b63:	89 c8                	mov    %ecx,%eax
  801b65:	f7 f5                	div    %ebp
  801b67:	89 d0                	mov    %edx,%eax
  801b69:	e9 44 ff ff ff       	jmp    801ab2 <__umoddi3+0x3e>
  801b6e:	66 90                	xchg   %ax,%ax
  801b70:	89 c8                	mov    %ecx,%eax
  801b72:	89 f2                	mov    %esi,%edx
  801b74:	83 c4 1c             	add    $0x1c,%esp
  801b77:	5b                   	pop    %ebx
  801b78:	5e                   	pop    %esi
  801b79:	5f                   	pop    %edi
  801b7a:	5d                   	pop    %ebp
  801b7b:	c3                   	ret    
  801b7c:	3b 04 24             	cmp    (%esp),%eax
  801b7f:	72 06                	jb     801b87 <__umoddi3+0x113>
  801b81:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b85:	77 0f                	ja     801b96 <__umoddi3+0x122>
  801b87:	89 f2                	mov    %esi,%edx
  801b89:	29 f9                	sub    %edi,%ecx
  801b8b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b8f:	89 14 24             	mov    %edx,(%esp)
  801b92:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b96:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b9a:	8b 14 24             	mov    (%esp),%edx
  801b9d:	83 c4 1c             	add    $0x1c,%esp
  801ba0:	5b                   	pop    %ebx
  801ba1:	5e                   	pop    %esi
  801ba2:	5f                   	pop    %edi
  801ba3:	5d                   	pop    %ebp
  801ba4:	c3                   	ret    
  801ba5:	8d 76 00             	lea    0x0(%esi),%esi
  801ba8:	2b 04 24             	sub    (%esp),%eax
  801bab:	19 fa                	sbb    %edi,%edx
  801bad:	89 d1                	mov    %edx,%ecx
  801baf:	89 c6                	mov    %eax,%esi
  801bb1:	e9 71 ff ff ff       	jmp    801b27 <__umoddi3+0xb3>
  801bb6:	66 90                	xchg   %ax,%ax
  801bb8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bbc:	72 ea                	jb     801ba8 <__umoddi3+0x134>
  801bbe:	89 d9                	mov    %ebx,%ecx
  801bc0:	e9 62 ff ff ff       	jmp    801b27 <__umoddi3+0xb3>
