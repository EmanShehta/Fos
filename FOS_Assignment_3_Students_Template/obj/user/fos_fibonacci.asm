
obj/user/fos_fibonacci:     file format elf32-i386


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
  800031:	e8 ab 00 00 00       	call   8000e1 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

int fibonacci(int n);

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	char buff1[256];
	atomic_readline("Please enter Fibonacci index:", buff1);
  800048:	83 ec 08             	sub    $0x8,%esp
  80004b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800051:	50                   	push   %eax
  800052:	68 e0 1b 80 00       	push   $0x801be0
  800057:	e8 f5 09 00 00       	call   800a51 <atomic_readline>
  80005c:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  80005f:	83 ec 04             	sub    $0x4,%esp
  800062:	6a 0a                	push   $0xa
  800064:	6a 00                	push   $0x0
  800066:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80006c:	50                   	push   %eax
  80006d:	e8 47 0e 00 00       	call   800eb9 <strtol>
  800072:	83 c4 10             	add    $0x10,%esp
  800075:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int res = fibonacci(i1) ;
  800078:	83 ec 0c             	sub    $0xc,%esp
  80007b:	ff 75 f4             	pushl  -0xc(%ebp)
  80007e:	e8 1f 00 00 00       	call   8000a2 <fibonacci>
  800083:	83 c4 10             	add    $0x10,%esp
  800086:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("Fibonacci #%d = %d\n",i1, res);
  800089:	83 ec 04             	sub    $0x4,%esp
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	68 fe 1b 80 00       	push   $0x801bfe
  800097:	e8 62 02 00 00       	call   8002fe <atomic_cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
	return;
  80009f:	90                   	nop
}
  8000a0:	c9                   	leave  
  8000a1:	c3                   	ret    

008000a2 <fibonacci>:


int fibonacci(int n)
{
  8000a2:	55                   	push   %ebp
  8000a3:	89 e5                	mov    %esp,%ebp
  8000a5:	53                   	push   %ebx
  8000a6:	83 ec 04             	sub    $0x4,%esp
	if (n <= 1)
  8000a9:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
  8000ad:	7f 07                	jg     8000b6 <fibonacci+0x14>
		return 1 ;
  8000af:	b8 01 00 00 00       	mov    $0x1,%eax
  8000b4:	eb 26                	jmp    8000dc <fibonacci+0x3a>
	return fibonacci(n-1) + fibonacci(n-2) ;
  8000b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8000b9:	48                   	dec    %eax
  8000ba:	83 ec 0c             	sub    $0xc,%esp
  8000bd:	50                   	push   %eax
  8000be:	e8 df ff ff ff       	call   8000a2 <fibonacci>
  8000c3:	83 c4 10             	add    $0x10,%esp
  8000c6:	89 c3                	mov    %eax,%ebx
  8000c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8000cb:	83 e8 02             	sub    $0x2,%eax
  8000ce:	83 ec 0c             	sub    $0xc,%esp
  8000d1:	50                   	push   %eax
  8000d2:	e8 cb ff ff ff       	call   8000a2 <fibonacci>
  8000d7:	83 c4 10             	add    $0x10,%esp
  8000da:	01 d8                	add    %ebx,%eax
}
  8000dc:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8000df:	c9                   	leave  
  8000e0:	c3                   	ret    

008000e1 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000e1:	55                   	push   %ebp
  8000e2:	89 e5                	mov    %esp,%ebp
  8000e4:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e7:	e8 16 12 00 00       	call   801302 <sys_getenvindex>
  8000ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ef:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000f2:	89 d0                	mov    %edx,%eax
  8000f4:	01 c0                	add    %eax,%eax
  8000f6:	01 d0                	add    %edx,%eax
  8000f8:	c1 e0 04             	shl    $0x4,%eax
  8000fb:	29 d0                	sub    %edx,%eax
  8000fd:	c1 e0 03             	shl    $0x3,%eax
  800100:	01 d0                	add    %edx,%eax
  800102:	c1 e0 02             	shl    $0x2,%eax
  800105:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80010a:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80010f:	a1 20 30 80 00       	mov    0x803020,%eax
  800114:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80011a:	84 c0                	test   %al,%al
  80011c:	74 0f                	je     80012d <libmain+0x4c>
		binaryname = myEnv->prog_name;
  80011e:	a1 20 30 80 00       	mov    0x803020,%eax
  800123:	05 5c 05 00 00       	add    $0x55c,%eax
  800128:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80012d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800131:	7e 0a                	jle    80013d <libmain+0x5c>
		binaryname = argv[0];
  800133:	8b 45 0c             	mov    0xc(%ebp),%eax
  800136:	8b 00                	mov    (%eax),%eax
  800138:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80013d:	83 ec 08             	sub    $0x8,%esp
  800140:	ff 75 0c             	pushl  0xc(%ebp)
  800143:	ff 75 08             	pushl  0x8(%ebp)
  800146:	e8 ed fe ff ff       	call   800038 <_main>
  80014b:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80014e:	e8 4a 13 00 00       	call   80149d <sys_disable_interrupt>
	cprintf("**************************************\n");
  800153:	83 ec 0c             	sub    $0xc,%esp
  800156:	68 2c 1c 80 00       	push   $0x801c2c
  80015b:	e8 71 01 00 00       	call   8002d1 <cprintf>
  800160:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800163:	a1 20 30 80 00       	mov    0x803020,%eax
  800168:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  80016e:	a1 20 30 80 00       	mov    0x803020,%eax
  800173:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800179:	83 ec 04             	sub    $0x4,%esp
  80017c:	52                   	push   %edx
  80017d:	50                   	push   %eax
  80017e:	68 54 1c 80 00       	push   $0x801c54
  800183:	e8 49 01 00 00       	call   8002d1 <cprintf>
  800188:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80018b:	a1 20 30 80 00       	mov    0x803020,%eax
  800190:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800196:	a1 20 30 80 00       	mov    0x803020,%eax
  80019b:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8001a1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a6:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8001ac:	51                   	push   %ecx
  8001ad:	52                   	push   %edx
  8001ae:	50                   	push   %eax
  8001af:	68 7c 1c 80 00       	push   $0x801c7c
  8001b4:	e8 18 01 00 00       	call   8002d1 <cprintf>
  8001b9:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001bc:	83 ec 0c             	sub    $0xc,%esp
  8001bf:	68 2c 1c 80 00       	push   $0x801c2c
  8001c4:	e8 08 01 00 00       	call   8002d1 <cprintf>
  8001c9:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001cc:	e8 e6 12 00 00       	call   8014b7 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001d1:	e8 19 00 00 00       	call   8001ef <exit>
}
  8001d6:	90                   	nop
  8001d7:	c9                   	leave  
  8001d8:	c3                   	ret    

008001d9 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001d9:	55                   	push   %ebp
  8001da:	89 e5                	mov    %esp,%ebp
  8001dc:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001df:	83 ec 0c             	sub    $0xc,%esp
  8001e2:	6a 00                	push   $0x0
  8001e4:	e8 e5 10 00 00       	call   8012ce <sys_env_destroy>
  8001e9:	83 c4 10             	add    $0x10,%esp
}
  8001ec:	90                   	nop
  8001ed:	c9                   	leave  
  8001ee:	c3                   	ret    

008001ef <exit>:

void
exit(void)
{
  8001ef:	55                   	push   %ebp
  8001f0:	89 e5                	mov    %esp,%ebp
  8001f2:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001f5:	e8 3a 11 00 00       	call   801334 <sys_env_exit>
}
  8001fa:	90                   	nop
  8001fb:	c9                   	leave  
  8001fc:	c3                   	ret    

008001fd <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001fd:	55                   	push   %ebp
  8001fe:	89 e5                	mov    %esp,%ebp
  800200:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800203:	8b 45 0c             	mov    0xc(%ebp),%eax
  800206:	8b 00                	mov    (%eax),%eax
  800208:	8d 48 01             	lea    0x1(%eax),%ecx
  80020b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80020e:	89 0a                	mov    %ecx,(%edx)
  800210:	8b 55 08             	mov    0x8(%ebp),%edx
  800213:	88 d1                	mov    %dl,%cl
  800215:	8b 55 0c             	mov    0xc(%ebp),%edx
  800218:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80021c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021f:	8b 00                	mov    (%eax),%eax
  800221:	3d ff 00 00 00       	cmp    $0xff,%eax
  800226:	75 2c                	jne    800254 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800228:	a0 24 30 80 00       	mov    0x803024,%al
  80022d:	0f b6 c0             	movzbl %al,%eax
  800230:	8b 55 0c             	mov    0xc(%ebp),%edx
  800233:	8b 12                	mov    (%edx),%edx
  800235:	89 d1                	mov    %edx,%ecx
  800237:	8b 55 0c             	mov    0xc(%ebp),%edx
  80023a:	83 c2 08             	add    $0x8,%edx
  80023d:	83 ec 04             	sub    $0x4,%esp
  800240:	50                   	push   %eax
  800241:	51                   	push   %ecx
  800242:	52                   	push   %edx
  800243:	e8 44 10 00 00       	call   80128c <sys_cputs>
  800248:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80024b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80024e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800254:	8b 45 0c             	mov    0xc(%ebp),%eax
  800257:	8b 40 04             	mov    0x4(%eax),%eax
  80025a:	8d 50 01             	lea    0x1(%eax),%edx
  80025d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800260:	89 50 04             	mov    %edx,0x4(%eax)
}
  800263:	90                   	nop
  800264:	c9                   	leave  
  800265:	c3                   	ret    

00800266 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800266:	55                   	push   %ebp
  800267:	89 e5                	mov    %esp,%ebp
  800269:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80026f:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800276:	00 00 00 
	b.cnt = 0;
  800279:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800280:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800283:	ff 75 0c             	pushl  0xc(%ebp)
  800286:	ff 75 08             	pushl  0x8(%ebp)
  800289:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80028f:	50                   	push   %eax
  800290:	68 fd 01 80 00       	push   $0x8001fd
  800295:	e8 11 02 00 00       	call   8004ab <vprintfmt>
  80029a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80029d:	a0 24 30 80 00       	mov    0x803024,%al
  8002a2:	0f b6 c0             	movzbl %al,%eax
  8002a5:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002ab:	83 ec 04             	sub    $0x4,%esp
  8002ae:	50                   	push   %eax
  8002af:	52                   	push   %edx
  8002b0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002b6:	83 c0 08             	add    $0x8,%eax
  8002b9:	50                   	push   %eax
  8002ba:	e8 cd 0f 00 00       	call   80128c <sys_cputs>
  8002bf:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002c2:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002c9:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002cf:	c9                   	leave  
  8002d0:	c3                   	ret    

008002d1 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002d1:	55                   	push   %ebp
  8002d2:	89 e5                	mov    %esp,%ebp
  8002d4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002d7:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002de:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002e1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e7:	83 ec 08             	sub    $0x8,%esp
  8002ea:	ff 75 f4             	pushl  -0xc(%ebp)
  8002ed:	50                   	push   %eax
  8002ee:	e8 73 ff ff ff       	call   800266 <vcprintf>
  8002f3:	83 c4 10             	add    $0x10,%esp
  8002f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002fc:	c9                   	leave  
  8002fd:	c3                   	ret    

008002fe <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002fe:	55                   	push   %ebp
  8002ff:	89 e5                	mov    %esp,%ebp
  800301:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800304:	e8 94 11 00 00       	call   80149d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800309:	8d 45 0c             	lea    0xc(%ebp),%eax
  80030c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80030f:	8b 45 08             	mov    0x8(%ebp),%eax
  800312:	83 ec 08             	sub    $0x8,%esp
  800315:	ff 75 f4             	pushl  -0xc(%ebp)
  800318:	50                   	push   %eax
  800319:	e8 48 ff ff ff       	call   800266 <vcprintf>
  80031e:	83 c4 10             	add    $0x10,%esp
  800321:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800324:	e8 8e 11 00 00       	call   8014b7 <sys_enable_interrupt>
	return cnt;
  800329:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80032c:	c9                   	leave  
  80032d:	c3                   	ret    

0080032e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80032e:	55                   	push   %ebp
  80032f:	89 e5                	mov    %esp,%ebp
  800331:	53                   	push   %ebx
  800332:	83 ec 14             	sub    $0x14,%esp
  800335:	8b 45 10             	mov    0x10(%ebp),%eax
  800338:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80033b:	8b 45 14             	mov    0x14(%ebp),%eax
  80033e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800341:	8b 45 18             	mov    0x18(%ebp),%eax
  800344:	ba 00 00 00 00       	mov    $0x0,%edx
  800349:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80034c:	77 55                	ja     8003a3 <printnum+0x75>
  80034e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800351:	72 05                	jb     800358 <printnum+0x2a>
  800353:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800356:	77 4b                	ja     8003a3 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800358:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80035b:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80035e:	8b 45 18             	mov    0x18(%ebp),%eax
  800361:	ba 00 00 00 00       	mov    $0x0,%edx
  800366:	52                   	push   %edx
  800367:	50                   	push   %eax
  800368:	ff 75 f4             	pushl  -0xc(%ebp)
  80036b:	ff 75 f0             	pushl  -0x10(%ebp)
  80036e:	e8 09 16 00 00       	call   80197c <__udivdi3>
  800373:	83 c4 10             	add    $0x10,%esp
  800376:	83 ec 04             	sub    $0x4,%esp
  800379:	ff 75 20             	pushl  0x20(%ebp)
  80037c:	53                   	push   %ebx
  80037d:	ff 75 18             	pushl  0x18(%ebp)
  800380:	52                   	push   %edx
  800381:	50                   	push   %eax
  800382:	ff 75 0c             	pushl  0xc(%ebp)
  800385:	ff 75 08             	pushl  0x8(%ebp)
  800388:	e8 a1 ff ff ff       	call   80032e <printnum>
  80038d:	83 c4 20             	add    $0x20,%esp
  800390:	eb 1a                	jmp    8003ac <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800392:	83 ec 08             	sub    $0x8,%esp
  800395:	ff 75 0c             	pushl  0xc(%ebp)
  800398:	ff 75 20             	pushl  0x20(%ebp)
  80039b:	8b 45 08             	mov    0x8(%ebp),%eax
  80039e:	ff d0                	call   *%eax
  8003a0:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003a3:	ff 4d 1c             	decl   0x1c(%ebp)
  8003a6:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003aa:	7f e6                	jg     800392 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003ac:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003af:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003ba:	53                   	push   %ebx
  8003bb:	51                   	push   %ecx
  8003bc:	52                   	push   %edx
  8003bd:	50                   	push   %eax
  8003be:	e8 c9 16 00 00       	call   801a8c <__umoddi3>
  8003c3:	83 c4 10             	add    $0x10,%esp
  8003c6:	05 f4 1e 80 00       	add    $0x801ef4,%eax
  8003cb:	8a 00                	mov    (%eax),%al
  8003cd:	0f be c0             	movsbl %al,%eax
  8003d0:	83 ec 08             	sub    $0x8,%esp
  8003d3:	ff 75 0c             	pushl  0xc(%ebp)
  8003d6:	50                   	push   %eax
  8003d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003da:	ff d0                	call   *%eax
  8003dc:	83 c4 10             	add    $0x10,%esp
}
  8003df:	90                   	nop
  8003e0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003e3:	c9                   	leave  
  8003e4:	c3                   	ret    

008003e5 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003e5:	55                   	push   %ebp
  8003e6:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003e8:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ec:	7e 1c                	jle    80040a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f1:	8b 00                	mov    (%eax),%eax
  8003f3:	8d 50 08             	lea    0x8(%eax),%edx
  8003f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f9:	89 10                	mov    %edx,(%eax)
  8003fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fe:	8b 00                	mov    (%eax),%eax
  800400:	83 e8 08             	sub    $0x8,%eax
  800403:	8b 50 04             	mov    0x4(%eax),%edx
  800406:	8b 00                	mov    (%eax),%eax
  800408:	eb 40                	jmp    80044a <getuint+0x65>
	else if (lflag)
  80040a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80040e:	74 1e                	je     80042e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800410:	8b 45 08             	mov    0x8(%ebp),%eax
  800413:	8b 00                	mov    (%eax),%eax
  800415:	8d 50 04             	lea    0x4(%eax),%edx
  800418:	8b 45 08             	mov    0x8(%ebp),%eax
  80041b:	89 10                	mov    %edx,(%eax)
  80041d:	8b 45 08             	mov    0x8(%ebp),%eax
  800420:	8b 00                	mov    (%eax),%eax
  800422:	83 e8 04             	sub    $0x4,%eax
  800425:	8b 00                	mov    (%eax),%eax
  800427:	ba 00 00 00 00       	mov    $0x0,%edx
  80042c:	eb 1c                	jmp    80044a <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80042e:	8b 45 08             	mov    0x8(%ebp),%eax
  800431:	8b 00                	mov    (%eax),%eax
  800433:	8d 50 04             	lea    0x4(%eax),%edx
  800436:	8b 45 08             	mov    0x8(%ebp),%eax
  800439:	89 10                	mov    %edx,(%eax)
  80043b:	8b 45 08             	mov    0x8(%ebp),%eax
  80043e:	8b 00                	mov    (%eax),%eax
  800440:	83 e8 04             	sub    $0x4,%eax
  800443:	8b 00                	mov    (%eax),%eax
  800445:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80044a:	5d                   	pop    %ebp
  80044b:	c3                   	ret    

0080044c <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80044c:	55                   	push   %ebp
  80044d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80044f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800453:	7e 1c                	jle    800471 <getint+0x25>
		return va_arg(*ap, long long);
  800455:	8b 45 08             	mov    0x8(%ebp),%eax
  800458:	8b 00                	mov    (%eax),%eax
  80045a:	8d 50 08             	lea    0x8(%eax),%edx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	89 10                	mov    %edx,(%eax)
  800462:	8b 45 08             	mov    0x8(%ebp),%eax
  800465:	8b 00                	mov    (%eax),%eax
  800467:	83 e8 08             	sub    $0x8,%eax
  80046a:	8b 50 04             	mov    0x4(%eax),%edx
  80046d:	8b 00                	mov    (%eax),%eax
  80046f:	eb 38                	jmp    8004a9 <getint+0x5d>
	else if (lflag)
  800471:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800475:	74 1a                	je     800491 <getint+0x45>
		return va_arg(*ap, long);
  800477:	8b 45 08             	mov    0x8(%ebp),%eax
  80047a:	8b 00                	mov    (%eax),%eax
  80047c:	8d 50 04             	lea    0x4(%eax),%edx
  80047f:	8b 45 08             	mov    0x8(%ebp),%eax
  800482:	89 10                	mov    %edx,(%eax)
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	8b 00                	mov    (%eax),%eax
  800489:	83 e8 04             	sub    $0x4,%eax
  80048c:	8b 00                	mov    (%eax),%eax
  80048e:	99                   	cltd   
  80048f:	eb 18                	jmp    8004a9 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800491:	8b 45 08             	mov    0x8(%ebp),%eax
  800494:	8b 00                	mov    (%eax),%eax
  800496:	8d 50 04             	lea    0x4(%eax),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	89 10                	mov    %edx,(%eax)
  80049e:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a1:	8b 00                	mov    (%eax),%eax
  8004a3:	83 e8 04             	sub    $0x4,%eax
  8004a6:	8b 00                	mov    (%eax),%eax
  8004a8:	99                   	cltd   
}
  8004a9:	5d                   	pop    %ebp
  8004aa:	c3                   	ret    

008004ab <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004ab:	55                   	push   %ebp
  8004ac:	89 e5                	mov    %esp,%ebp
  8004ae:	56                   	push   %esi
  8004af:	53                   	push   %ebx
  8004b0:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004b3:	eb 17                	jmp    8004cc <vprintfmt+0x21>
			if (ch == '\0')
  8004b5:	85 db                	test   %ebx,%ebx
  8004b7:	0f 84 af 03 00 00    	je     80086c <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004bd:	83 ec 08             	sub    $0x8,%esp
  8004c0:	ff 75 0c             	pushl  0xc(%ebp)
  8004c3:	53                   	push   %ebx
  8004c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c7:	ff d0                	call   *%eax
  8004c9:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cf:	8d 50 01             	lea    0x1(%eax),%edx
  8004d2:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d5:	8a 00                	mov    (%eax),%al
  8004d7:	0f b6 d8             	movzbl %al,%ebx
  8004da:	83 fb 25             	cmp    $0x25,%ebx
  8004dd:	75 d6                	jne    8004b5 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004df:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004e3:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004ea:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004f8:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004ff:	8b 45 10             	mov    0x10(%ebp),%eax
  800502:	8d 50 01             	lea    0x1(%eax),%edx
  800505:	89 55 10             	mov    %edx,0x10(%ebp)
  800508:	8a 00                	mov    (%eax),%al
  80050a:	0f b6 d8             	movzbl %al,%ebx
  80050d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800510:	83 f8 55             	cmp    $0x55,%eax
  800513:	0f 87 2b 03 00 00    	ja     800844 <vprintfmt+0x399>
  800519:	8b 04 85 18 1f 80 00 	mov    0x801f18(,%eax,4),%eax
  800520:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800522:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800526:	eb d7                	jmp    8004ff <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800528:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80052c:	eb d1                	jmp    8004ff <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80052e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800535:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800538:	89 d0                	mov    %edx,%eax
  80053a:	c1 e0 02             	shl    $0x2,%eax
  80053d:	01 d0                	add    %edx,%eax
  80053f:	01 c0                	add    %eax,%eax
  800541:	01 d8                	add    %ebx,%eax
  800543:	83 e8 30             	sub    $0x30,%eax
  800546:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800549:	8b 45 10             	mov    0x10(%ebp),%eax
  80054c:	8a 00                	mov    (%eax),%al
  80054e:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800551:	83 fb 2f             	cmp    $0x2f,%ebx
  800554:	7e 3e                	jle    800594 <vprintfmt+0xe9>
  800556:	83 fb 39             	cmp    $0x39,%ebx
  800559:	7f 39                	jg     800594 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80055b:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80055e:	eb d5                	jmp    800535 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800560:	8b 45 14             	mov    0x14(%ebp),%eax
  800563:	83 c0 04             	add    $0x4,%eax
  800566:	89 45 14             	mov    %eax,0x14(%ebp)
  800569:	8b 45 14             	mov    0x14(%ebp),%eax
  80056c:	83 e8 04             	sub    $0x4,%eax
  80056f:	8b 00                	mov    (%eax),%eax
  800571:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800574:	eb 1f                	jmp    800595 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800576:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80057a:	79 83                	jns    8004ff <vprintfmt+0x54>
				width = 0;
  80057c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800583:	e9 77 ff ff ff       	jmp    8004ff <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800588:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80058f:	e9 6b ff ff ff       	jmp    8004ff <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800594:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800595:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800599:	0f 89 60 ff ff ff    	jns    8004ff <vprintfmt+0x54>
				width = precision, precision = -1;
  80059f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005a2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005a5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005ac:	e9 4e ff ff ff       	jmp    8004ff <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005b1:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005b4:	e9 46 ff ff ff       	jmp    8004ff <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005b9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bc:	83 c0 04             	add    $0x4,%eax
  8005bf:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c5:	83 e8 04             	sub    $0x4,%eax
  8005c8:	8b 00                	mov    (%eax),%eax
  8005ca:	83 ec 08             	sub    $0x8,%esp
  8005cd:	ff 75 0c             	pushl  0xc(%ebp)
  8005d0:	50                   	push   %eax
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	ff d0                	call   *%eax
  8005d6:	83 c4 10             	add    $0x10,%esp
			break;
  8005d9:	e9 89 02 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005de:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e1:	83 c0 04             	add    $0x4,%eax
  8005e4:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ea:	83 e8 04             	sub    $0x4,%eax
  8005ed:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005ef:	85 db                	test   %ebx,%ebx
  8005f1:	79 02                	jns    8005f5 <vprintfmt+0x14a>
				err = -err;
  8005f3:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005f5:	83 fb 64             	cmp    $0x64,%ebx
  8005f8:	7f 0b                	jg     800605 <vprintfmt+0x15a>
  8005fa:	8b 34 9d 60 1d 80 00 	mov    0x801d60(,%ebx,4),%esi
  800601:	85 f6                	test   %esi,%esi
  800603:	75 19                	jne    80061e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800605:	53                   	push   %ebx
  800606:	68 05 1f 80 00       	push   $0x801f05
  80060b:	ff 75 0c             	pushl  0xc(%ebp)
  80060e:	ff 75 08             	pushl  0x8(%ebp)
  800611:	e8 5e 02 00 00       	call   800874 <printfmt>
  800616:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800619:	e9 49 02 00 00       	jmp    800867 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80061e:	56                   	push   %esi
  80061f:	68 0e 1f 80 00       	push   $0x801f0e
  800624:	ff 75 0c             	pushl  0xc(%ebp)
  800627:	ff 75 08             	pushl  0x8(%ebp)
  80062a:	e8 45 02 00 00       	call   800874 <printfmt>
  80062f:	83 c4 10             	add    $0x10,%esp
			break;
  800632:	e9 30 02 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800637:	8b 45 14             	mov    0x14(%ebp),%eax
  80063a:	83 c0 04             	add    $0x4,%eax
  80063d:	89 45 14             	mov    %eax,0x14(%ebp)
  800640:	8b 45 14             	mov    0x14(%ebp),%eax
  800643:	83 e8 04             	sub    $0x4,%eax
  800646:	8b 30                	mov    (%eax),%esi
  800648:	85 f6                	test   %esi,%esi
  80064a:	75 05                	jne    800651 <vprintfmt+0x1a6>
				p = "(null)";
  80064c:	be 11 1f 80 00       	mov    $0x801f11,%esi
			if (width > 0 && padc != '-')
  800651:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800655:	7e 6d                	jle    8006c4 <vprintfmt+0x219>
  800657:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80065b:	74 67                	je     8006c4 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80065d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800660:	83 ec 08             	sub    $0x8,%esp
  800663:	50                   	push   %eax
  800664:	56                   	push   %esi
  800665:	e8 12 05 00 00       	call   800b7c <strnlen>
  80066a:	83 c4 10             	add    $0x10,%esp
  80066d:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800670:	eb 16                	jmp    800688 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800672:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800676:	83 ec 08             	sub    $0x8,%esp
  800679:	ff 75 0c             	pushl  0xc(%ebp)
  80067c:	50                   	push   %eax
  80067d:	8b 45 08             	mov    0x8(%ebp),%eax
  800680:	ff d0                	call   *%eax
  800682:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800685:	ff 4d e4             	decl   -0x1c(%ebp)
  800688:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80068c:	7f e4                	jg     800672 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80068e:	eb 34                	jmp    8006c4 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800690:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800694:	74 1c                	je     8006b2 <vprintfmt+0x207>
  800696:	83 fb 1f             	cmp    $0x1f,%ebx
  800699:	7e 05                	jle    8006a0 <vprintfmt+0x1f5>
  80069b:	83 fb 7e             	cmp    $0x7e,%ebx
  80069e:	7e 12                	jle    8006b2 <vprintfmt+0x207>
					putch('?', putdat);
  8006a0:	83 ec 08             	sub    $0x8,%esp
  8006a3:	ff 75 0c             	pushl  0xc(%ebp)
  8006a6:	6a 3f                	push   $0x3f
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	ff d0                	call   *%eax
  8006ad:	83 c4 10             	add    $0x10,%esp
  8006b0:	eb 0f                	jmp    8006c1 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006b2:	83 ec 08             	sub    $0x8,%esp
  8006b5:	ff 75 0c             	pushl  0xc(%ebp)
  8006b8:	53                   	push   %ebx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	ff d0                	call   *%eax
  8006be:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006c1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c4:	89 f0                	mov    %esi,%eax
  8006c6:	8d 70 01             	lea    0x1(%eax),%esi
  8006c9:	8a 00                	mov    (%eax),%al
  8006cb:	0f be d8             	movsbl %al,%ebx
  8006ce:	85 db                	test   %ebx,%ebx
  8006d0:	74 24                	je     8006f6 <vprintfmt+0x24b>
  8006d2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d6:	78 b8                	js     800690 <vprintfmt+0x1e5>
  8006d8:	ff 4d e0             	decl   -0x20(%ebp)
  8006db:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006df:	79 af                	jns    800690 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006e1:	eb 13                	jmp    8006f6 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006e3:	83 ec 08             	sub    $0x8,%esp
  8006e6:	ff 75 0c             	pushl  0xc(%ebp)
  8006e9:	6a 20                	push   $0x20
  8006eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ee:	ff d0                	call   *%eax
  8006f0:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006f3:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006fa:	7f e7                	jg     8006e3 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006fc:	e9 66 01 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800701:	83 ec 08             	sub    $0x8,%esp
  800704:	ff 75 e8             	pushl  -0x18(%ebp)
  800707:	8d 45 14             	lea    0x14(%ebp),%eax
  80070a:	50                   	push   %eax
  80070b:	e8 3c fd ff ff       	call   80044c <getint>
  800710:	83 c4 10             	add    $0x10,%esp
  800713:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800716:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800719:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80071c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80071f:	85 d2                	test   %edx,%edx
  800721:	79 23                	jns    800746 <vprintfmt+0x29b>
				putch('-', putdat);
  800723:	83 ec 08             	sub    $0x8,%esp
  800726:	ff 75 0c             	pushl  0xc(%ebp)
  800729:	6a 2d                	push   $0x2d
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	ff d0                	call   *%eax
  800730:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800733:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800736:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800739:	f7 d8                	neg    %eax
  80073b:	83 d2 00             	adc    $0x0,%edx
  80073e:	f7 da                	neg    %edx
  800740:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800743:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800746:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80074d:	e9 bc 00 00 00       	jmp    80080e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800752:	83 ec 08             	sub    $0x8,%esp
  800755:	ff 75 e8             	pushl  -0x18(%ebp)
  800758:	8d 45 14             	lea    0x14(%ebp),%eax
  80075b:	50                   	push   %eax
  80075c:	e8 84 fc ff ff       	call   8003e5 <getuint>
  800761:	83 c4 10             	add    $0x10,%esp
  800764:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800767:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80076a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800771:	e9 98 00 00 00       	jmp    80080e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800776:	83 ec 08             	sub    $0x8,%esp
  800779:	ff 75 0c             	pushl  0xc(%ebp)
  80077c:	6a 58                	push   $0x58
  80077e:	8b 45 08             	mov    0x8(%ebp),%eax
  800781:	ff d0                	call   *%eax
  800783:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800786:	83 ec 08             	sub    $0x8,%esp
  800789:	ff 75 0c             	pushl  0xc(%ebp)
  80078c:	6a 58                	push   $0x58
  80078e:	8b 45 08             	mov    0x8(%ebp),%eax
  800791:	ff d0                	call   *%eax
  800793:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 0c             	pushl  0xc(%ebp)
  80079c:	6a 58                	push   $0x58
  80079e:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a1:	ff d0                	call   *%eax
  8007a3:	83 c4 10             	add    $0x10,%esp
			break;
  8007a6:	e9 bc 00 00 00       	jmp    800867 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007ab:	83 ec 08             	sub    $0x8,%esp
  8007ae:	ff 75 0c             	pushl  0xc(%ebp)
  8007b1:	6a 30                	push   $0x30
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	ff d0                	call   *%eax
  8007b8:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007bb:	83 ec 08             	sub    $0x8,%esp
  8007be:	ff 75 0c             	pushl  0xc(%ebp)
  8007c1:	6a 78                	push   $0x78
  8007c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c6:	ff d0                	call   *%eax
  8007c8:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007cb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ce:	83 c0 04             	add    $0x4,%eax
  8007d1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d7:	83 e8 04             	sub    $0x4,%eax
  8007da:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007e6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007ed:	eb 1f                	jmp    80080e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007ef:	83 ec 08             	sub    $0x8,%esp
  8007f2:	ff 75 e8             	pushl  -0x18(%ebp)
  8007f5:	8d 45 14             	lea    0x14(%ebp),%eax
  8007f8:	50                   	push   %eax
  8007f9:	e8 e7 fb ff ff       	call   8003e5 <getuint>
  8007fe:	83 c4 10             	add    $0x10,%esp
  800801:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800804:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800807:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80080e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800812:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800815:	83 ec 04             	sub    $0x4,%esp
  800818:	52                   	push   %edx
  800819:	ff 75 e4             	pushl  -0x1c(%ebp)
  80081c:	50                   	push   %eax
  80081d:	ff 75 f4             	pushl  -0xc(%ebp)
  800820:	ff 75 f0             	pushl  -0x10(%ebp)
  800823:	ff 75 0c             	pushl  0xc(%ebp)
  800826:	ff 75 08             	pushl  0x8(%ebp)
  800829:	e8 00 fb ff ff       	call   80032e <printnum>
  80082e:	83 c4 20             	add    $0x20,%esp
			break;
  800831:	eb 34                	jmp    800867 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800833:	83 ec 08             	sub    $0x8,%esp
  800836:	ff 75 0c             	pushl  0xc(%ebp)
  800839:	53                   	push   %ebx
  80083a:	8b 45 08             	mov    0x8(%ebp),%eax
  80083d:	ff d0                	call   *%eax
  80083f:	83 c4 10             	add    $0x10,%esp
			break;
  800842:	eb 23                	jmp    800867 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800844:	83 ec 08             	sub    $0x8,%esp
  800847:	ff 75 0c             	pushl  0xc(%ebp)
  80084a:	6a 25                	push   $0x25
  80084c:	8b 45 08             	mov    0x8(%ebp),%eax
  80084f:	ff d0                	call   *%eax
  800851:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800854:	ff 4d 10             	decl   0x10(%ebp)
  800857:	eb 03                	jmp    80085c <vprintfmt+0x3b1>
  800859:	ff 4d 10             	decl   0x10(%ebp)
  80085c:	8b 45 10             	mov    0x10(%ebp),%eax
  80085f:	48                   	dec    %eax
  800860:	8a 00                	mov    (%eax),%al
  800862:	3c 25                	cmp    $0x25,%al
  800864:	75 f3                	jne    800859 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800866:	90                   	nop
		}
	}
  800867:	e9 47 fc ff ff       	jmp    8004b3 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80086c:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80086d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800870:	5b                   	pop    %ebx
  800871:	5e                   	pop    %esi
  800872:	5d                   	pop    %ebp
  800873:	c3                   	ret    

00800874 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800874:	55                   	push   %ebp
  800875:	89 e5                	mov    %esp,%ebp
  800877:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80087a:	8d 45 10             	lea    0x10(%ebp),%eax
  80087d:	83 c0 04             	add    $0x4,%eax
  800880:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800883:	8b 45 10             	mov    0x10(%ebp),%eax
  800886:	ff 75 f4             	pushl  -0xc(%ebp)
  800889:	50                   	push   %eax
  80088a:	ff 75 0c             	pushl  0xc(%ebp)
  80088d:	ff 75 08             	pushl  0x8(%ebp)
  800890:	e8 16 fc ff ff       	call   8004ab <vprintfmt>
  800895:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800898:	90                   	nop
  800899:	c9                   	leave  
  80089a:	c3                   	ret    

0080089b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80089b:	55                   	push   %ebp
  80089c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80089e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a1:	8b 40 08             	mov    0x8(%eax),%eax
  8008a4:	8d 50 01             	lea    0x1(%eax),%edx
  8008a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008aa:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008ad:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b0:	8b 10                	mov    (%eax),%edx
  8008b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b5:	8b 40 04             	mov    0x4(%eax),%eax
  8008b8:	39 c2                	cmp    %eax,%edx
  8008ba:	73 12                	jae    8008ce <sprintputch+0x33>
		*b->buf++ = ch;
  8008bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bf:	8b 00                	mov    (%eax),%eax
  8008c1:	8d 48 01             	lea    0x1(%eax),%ecx
  8008c4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c7:	89 0a                	mov    %ecx,(%edx)
  8008c9:	8b 55 08             	mov    0x8(%ebp),%edx
  8008cc:	88 10                	mov    %dl,(%eax)
}
  8008ce:	90                   	nop
  8008cf:	5d                   	pop    %ebp
  8008d0:	c3                   	ret    

008008d1 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008d1:	55                   	push   %ebp
  8008d2:	89 e5                	mov    %esp,%ebp
  8008d4:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008da:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008dd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e0:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e6:	01 d0                	add    %edx,%eax
  8008e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008eb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008f2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008f6:	74 06                	je     8008fe <vsnprintf+0x2d>
  8008f8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008fc:	7f 07                	jg     800905 <vsnprintf+0x34>
		return -E_INVAL;
  8008fe:	b8 03 00 00 00       	mov    $0x3,%eax
  800903:	eb 20                	jmp    800925 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800905:	ff 75 14             	pushl  0x14(%ebp)
  800908:	ff 75 10             	pushl  0x10(%ebp)
  80090b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80090e:	50                   	push   %eax
  80090f:	68 9b 08 80 00       	push   $0x80089b
  800914:	e8 92 fb ff ff       	call   8004ab <vprintfmt>
  800919:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80091c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80091f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800922:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800925:	c9                   	leave  
  800926:	c3                   	ret    

00800927 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800927:	55                   	push   %ebp
  800928:	89 e5                	mov    %esp,%ebp
  80092a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80092d:	8d 45 10             	lea    0x10(%ebp),%eax
  800930:	83 c0 04             	add    $0x4,%eax
  800933:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800936:	8b 45 10             	mov    0x10(%ebp),%eax
  800939:	ff 75 f4             	pushl  -0xc(%ebp)
  80093c:	50                   	push   %eax
  80093d:	ff 75 0c             	pushl  0xc(%ebp)
  800940:	ff 75 08             	pushl  0x8(%ebp)
  800943:	e8 89 ff ff ff       	call   8008d1 <vsnprintf>
  800948:	83 c4 10             	add    $0x10,%esp
  80094b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80094e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800951:	c9                   	leave  
  800952:	c3                   	ret    

00800953 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800953:	55                   	push   %ebp
  800954:	89 e5                	mov    %esp,%ebp
  800956:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800959:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80095d:	74 13                	je     800972 <readline+0x1f>
		cprintf("%s", prompt);
  80095f:	83 ec 08             	sub    $0x8,%esp
  800962:	ff 75 08             	pushl  0x8(%ebp)
  800965:	68 70 20 80 00       	push   $0x802070
  80096a:	e8 62 f9 ff ff       	call   8002d1 <cprintf>
  80096f:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800972:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800979:	83 ec 0c             	sub    $0xc,%esp
  80097c:	6a 00                	push   $0x0
  80097e:	e8 ed 0f 00 00       	call   801970 <iscons>
  800983:	83 c4 10             	add    $0x10,%esp
  800986:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800989:	e8 94 0f 00 00       	call   801922 <getchar>
  80098e:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800991:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800995:	79 22                	jns    8009b9 <readline+0x66>
			if (c != -E_EOF)
  800997:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80099b:	0f 84 ad 00 00 00    	je     800a4e <readline+0xfb>
				cprintf("read error: %e\n", c);
  8009a1:	83 ec 08             	sub    $0x8,%esp
  8009a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8009a7:	68 73 20 80 00       	push   $0x802073
  8009ac:	e8 20 f9 ff ff       	call   8002d1 <cprintf>
  8009b1:	83 c4 10             	add    $0x10,%esp
			return;
  8009b4:	e9 95 00 00 00       	jmp    800a4e <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009b9:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009bd:	7e 34                	jle    8009f3 <readline+0xa0>
  8009bf:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009c6:	7f 2b                	jg     8009f3 <readline+0xa0>
			if (echoing)
  8009c8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009cc:	74 0e                	je     8009dc <readline+0x89>
				cputchar(c);
  8009ce:	83 ec 0c             	sub    $0xc,%esp
  8009d1:	ff 75 ec             	pushl  -0x14(%ebp)
  8009d4:	e8 01 0f 00 00       	call   8018da <cputchar>
  8009d9:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009df:	8d 50 01             	lea    0x1(%eax),%edx
  8009e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009e5:	89 c2                	mov    %eax,%edx
  8009e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ea:	01 d0                	add    %edx,%eax
  8009ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009ef:	88 10                	mov    %dl,(%eax)
  8009f1:	eb 56                	jmp    800a49 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009f3:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009f7:	75 1f                	jne    800a18 <readline+0xc5>
  8009f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009fd:	7e 19                	jle    800a18 <readline+0xc5>
			if (echoing)
  8009ff:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a03:	74 0e                	je     800a13 <readline+0xc0>
				cputchar(c);
  800a05:	83 ec 0c             	sub    $0xc,%esp
  800a08:	ff 75 ec             	pushl  -0x14(%ebp)
  800a0b:	e8 ca 0e 00 00       	call   8018da <cputchar>
  800a10:	83 c4 10             	add    $0x10,%esp

			i--;
  800a13:	ff 4d f4             	decl   -0xc(%ebp)
  800a16:	eb 31                	jmp    800a49 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a18:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a1c:	74 0a                	je     800a28 <readline+0xd5>
  800a1e:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a22:	0f 85 61 ff ff ff    	jne    800989 <readline+0x36>
			if (echoing)
  800a28:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a2c:	74 0e                	je     800a3c <readline+0xe9>
				cputchar(c);
  800a2e:	83 ec 0c             	sub    $0xc,%esp
  800a31:	ff 75 ec             	pushl  -0x14(%ebp)
  800a34:	e8 a1 0e 00 00       	call   8018da <cputchar>
  800a39:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a3c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	01 d0                	add    %edx,%eax
  800a44:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a47:	eb 06                	jmp    800a4f <readline+0xfc>
		}
	}
  800a49:	e9 3b ff ff ff       	jmp    800989 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a4e:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a4f:	c9                   	leave  
  800a50:	c3                   	ret    

00800a51 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a51:	55                   	push   %ebp
  800a52:	89 e5                	mov    %esp,%ebp
  800a54:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a57:	e8 41 0a 00 00       	call   80149d <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a5c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a60:	74 13                	je     800a75 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a62:	83 ec 08             	sub    $0x8,%esp
  800a65:	ff 75 08             	pushl  0x8(%ebp)
  800a68:	68 70 20 80 00       	push   $0x802070
  800a6d:	e8 5f f8 ff ff       	call   8002d1 <cprintf>
  800a72:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a75:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a7c:	83 ec 0c             	sub    $0xc,%esp
  800a7f:	6a 00                	push   $0x0
  800a81:	e8 ea 0e 00 00       	call   801970 <iscons>
  800a86:	83 c4 10             	add    $0x10,%esp
  800a89:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a8c:	e8 91 0e 00 00       	call   801922 <getchar>
  800a91:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a94:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a98:	79 23                	jns    800abd <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a9a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a9e:	74 13                	je     800ab3 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800aa0:	83 ec 08             	sub    $0x8,%esp
  800aa3:	ff 75 ec             	pushl  -0x14(%ebp)
  800aa6:	68 73 20 80 00       	push   $0x802073
  800aab:	e8 21 f8 ff ff       	call   8002d1 <cprintf>
  800ab0:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800ab3:	e8 ff 09 00 00       	call   8014b7 <sys_enable_interrupt>
			return;
  800ab8:	e9 9a 00 00 00       	jmp    800b57 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800abd:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800ac1:	7e 34                	jle    800af7 <atomic_readline+0xa6>
  800ac3:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800aca:	7f 2b                	jg     800af7 <atomic_readline+0xa6>
			if (echoing)
  800acc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800ad0:	74 0e                	je     800ae0 <atomic_readline+0x8f>
				cputchar(c);
  800ad2:	83 ec 0c             	sub    $0xc,%esp
  800ad5:	ff 75 ec             	pushl  -0x14(%ebp)
  800ad8:	e8 fd 0d 00 00       	call   8018da <cputchar>
  800add:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ae0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ae3:	8d 50 01             	lea    0x1(%eax),%edx
  800ae6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ae9:	89 c2                	mov    %eax,%edx
  800aeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aee:	01 d0                	add    %edx,%eax
  800af0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800af3:	88 10                	mov    %dl,(%eax)
  800af5:	eb 5b                	jmp    800b52 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800af7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800afb:	75 1f                	jne    800b1c <atomic_readline+0xcb>
  800afd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800b01:	7e 19                	jle    800b1c <atomic_readline+0xcb>
			if (echoing)
  800b03:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b07:	74 0e                	je     800b17 <atomic_readline+0xc6>
				cputchar(c);
  800b09:	83 ec 0c             	sub    $0xc,%esp
  800b0c:	ff 75 ec             	pushl  -0x14(%ebp)
  800b0f:	e8 c6 0d 00 00       	call   8018da <cputchar>
  800b14:	83 c4 10             	add    $0x10,%esp
			i--;
  800b17:	ff 4d f4             	decl   -0xc(%ebp)
  800b1a:	eb 36                	jmp    800b52 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b1c:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b20:	74 0a                	je     800b2c <atomic_readline+0xdb>
  800b22:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b26:	0f 85 60 ff ff ff    	jne    800a8c <atomic_readline+0x3b>
			if (echoing)
  800b2c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b30:	74 0e                	je     800b40 <atomic_readline+0xef>
				cputchar(c);
  800b32:	83 ec 0c             	sub    $0xc,%esp
  800b35:	ff 75 ec             	pushl  -0x14(%ebp)
  800b38:	e8 9d 0d 00 00       	call   8018da <cputchar>
  800b3d:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b40:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b46:	01 d0                	add    %edx,%eax
  800b48:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b4b:	e8 67 09 00 00       	call   8014b7 <sys_enable_interrupt>
			return;
  800b50:	eb 05                	jmp    800b57 <atomic_readline+0x106>
		}
	}
  800b52:	e9 35 ff ff ff       	jmp    800a8c <atomic_readline+0x3b>
}
  800b57:	c9                   	leave  
  800b58:	c3                   	ret    

00800b59 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b59:	55                   	push   %ebp
  800b5a:	89 e5                	mov    %esp,%ebp
  800b5c:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b5f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b66:	eb 06                	jmp    800b6e <strlen+0x15>
		n++;
  800b68:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b6b:	ff 45 08             	incl   0x8(%ebp)
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	8a 00                	mov    (%eax),%al
  800b73:	84 c0                	test   %al,%al
  800b75:	75 f1                	jne    800b68 <strlen+0xf>
		n++;
	return n;
  800b77:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b7a:	c9                   	leave  
  800b7b:	c3                   	ret    

00800b7c <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b7c:	55                   	push   %ebp
  800b7d:	89 e5                	mov    %esp,%ebp
  800b7f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b82:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b89:	eb 09                	jmp    800b94 <strnlen+0x18>
		n++;
  800b8b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b8e:	ff 45 08             	incl   0x8(%ebp)
  800b91:	ff 4d 0c             	decl   0xc(%ebp)
  800b94:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b98:	74 09                	je     800ba3 <strnlen+0x27>
  800b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9d:	8a 00                	mov    (%eax),%al
  800b9f:	84 c0                	test   %al,%al
  800ba1:	75 e8                	jne    800b8b <strnlen+0xf>
		n++;
	return n;
  800ba3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba6:	c9                   	leave  
  800ba7:	c3                   	ret    

00800ba8 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ba8:	55                   	push   %ebp
  800ba9:	89 e5                	mov    %esp,%ebp
  800bab:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bae:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bb4:	90                   	nop
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	8d 50 01             	lea    0x1(%eax),%edx
  800bbb:	89 55 08             	mov    %edx,0x8(%ebp)
  800bbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bc1:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bc7:	8a 12                	mov    (%edx),%dl
  800bc9:	88 10                	mov    %dl,(%eax)
  800bcb:	8a 00                	mov    (%eax),%al
  800bcd:	84 c0                	test   %al,%al
  800bcf:	75 e4                	jne    800bb5 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd4:	c9                   	leave  
  800bd5:	c3                   	ret    

00800bd6 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bd6:	55                   	push   %ebp
  800bd7:	89 e5                	mov    %esp,%ebp
  800bd9:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800be2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800be9:	eb 1f                	jmp    800c0a <strncpy+0x34>
		*dst++ = *src;
  800beb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bee:	8d 50 01             	lea    0x1(%eax),%edx
  800bf1:	89 55 08             	mov    %edx,0x8(%ebp)
  800bf4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf7:	8a 12                	mov    (%edx),%dl
  800bf9:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bfb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfe:	8a 00                	mov    (%eax),%al
  800c00:	84 c0                	test   %al,%al
  800c02:	74 03                	je     800c07 <strncpy+0x31>
			src++;
  800c04:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c07:	ff 45 fc             	incl   -0x4(%ebp)
  800c0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c10:	72 d9                	jb     800beb <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c12:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c15:	c9                   	leave  
  800c16:	c3                   	ret    

00800c17 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c17:	55                   	push   %ebp
  800c18:	89 e5                	mov    %esp,%ebp
  800c1a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c20:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c23:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c27:	74 30                	je     800c59 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c29:	eb 16                	jmp    800c41 <strlcpy+0x2a>
			*dst++ = *src++;
  800c2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2e:	8d 50 01             	lea    0x1(%eax),%edx
  800c31:	89 55 08             	mov    %edx,0x8(%ebp)
  800c34:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c37:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c3a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c3d:	8a 12                	mov    (%edx),%dl
  800c3f:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c41:	ff 4d 10             	decl   0x10(%ebp)
  800c44:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c48:	74 09                	je     800c53 <strlcpy+0x3c>
  800c4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4d:	8a 00                	mov    (%eax),%al
  800c4f:	84 c0                	test   %al,%al
  800c51:	75 d8                	jne    800c2b <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c59:	8b 55 08             	mov    0x8(%ebp),%edx
  800c5c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c5f:	29 c2                	sub    %eax,%edx
  800c61:	89 d0                	mov    %edx,%eax
}
  800c63:	c9                   	leave  
  800c64:	c3                   	ret    

00800c65 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c65:	55                   	push   %ebp
  800c66:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c68:	eb 06                	jmp    800c70 <strcmp+0xb>
		p++, q++;
  800c6a:	ff 45 08             	incl   0x8(%ebp)
  800c6d:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	8a 00                	mov    (%eax),%al
  800c75:	84 c0                	test   %al,%al
  800c77:	74 0e                	je     800c87 <strcmp+0x22>
  800c79:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7c:	8a 10                	mov    (%eax),%dl
  800c7e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	38 c2                	cmp    %al,%dl
  800c85:	74 e3                	je     800c6a <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	8a 00                	mov    (%eax),%al
  800c8c:	0f b6 d0             	movzbl %al,%edx
  800c8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c92:	8a 00                	mov    (%eax),%al
  800c94:	0f b6 c0             	movzbl %al,%eax
  800c97:	29 c2                	sub    %eax,%edx
  800c99:	89 d0                	mov    %edx,%eax
}
  800c9b:	5d                   	pop    %ebp
  800c9c:	c3                   	ret    

00800c9d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c9d:	55                   	push   %ebp
  800c9e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ca0:	eb 09                	jmp    800cab <strncmp+0xe>
		n--, p++, q++;
  800ca2:	ff 4d 10             	decl   0x10(%ebp)
  800ca5:	ff 45 08             	incl   0x8(%ebp)
  800ca8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cab:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800caf:	74 17                	je     800cc8 <strncmp+0x2b>
  800cb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb4:	8a 00                	mov    (%eax),%al
  800cb6:	84 c0                	test   %al,%al
  800cb8:	74 0e                	je     800cc8 <strncmp+0x2b>
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	8a 10                	mov    (%eax),%dl
  800cbf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cc2:	8a 00                	mov    (%eax),%al
  800cc4:	38 c2                	cmp    %al,%dl
  800cc6:	74 da                	je     800ca2 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cc8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ccc:	75 07                	jne    800cd5 <strncmp+0x38>
		return 0;
  800cce:	b8 00 00 00 00       	mov    $0x0,%eax
  800cd3:	eb 14                	jmp    800ce9 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	8a 00                	mov    (%eax),%al
  800cda:	0f b6 d0             	movzbl %al,%edx
  800cdd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce0:	8a 00                	mov    (%eax),%al
  800ce2:	0f b6 c0             	movzbl %al,%eax
  800ce5:	29 c2                	sub    %eax,%edx
  800ce7:	89 d0                	mov    %edx,%eax
}
  800ce9:	5d                   	pop    %ebp
  800cea:	c3                   	ret    

00800ceb <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ceb:	55                   	push   %ebp
  800cec:	89 e5                	mov    %esp,%ebp
  800cee:	83 ec 04             	sub    $0x4,%esp
  800cf1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cf7:	eb 12                	jmp    800d0b <strchr+0x20>
		if (*s == c)
  800cf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfc:	8a 00                	mov    (%eax),%al
  800cfe:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d01:	75 05                	jne    800d08 <strchr+0x1d>
			return (char *) s;
  800d03:	8b 45 08             	mov    0x8(%ebp),%eax
  800d06:	eb 11                	jmp    800d19 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d08:	ff 45 08             	incl   0x8(%ebp)
  800d0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0e:	8a 00                	mov    (%eax),%al
  800d10:	84 c0                	test   %al,%al
  800d12:	75 e5                	jne    800cf9 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d14:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d19:	c9                   	leave  
  800d1a:	c3                   	ret    

00800d1b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d1b:	55                   	push   %ebp
  800d1c:	89 e5                	mov    %esp,%ebp
  800d1e:	83 ec 04             	sub    $0x4,%esp
  800d21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d24:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d27:	eb 0d                	jmp    800d36 <strfind+0x1b>
		if (*s == c)
  800d29:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2c:	8a 00                	mov    (%eax),%al
  800d2e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d31:	74 0e                	je     800d41 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d33:	ff 45 08             	incl   0x8(%ebp)
  800d36:	8b 45 08             	mov    0x8(%ebp),%eax
  800d39:	8a 00                	mov    (%eax),%al
  800d3b:	84 c0                	test   %al,%al
  800d3d:	75 ea                	jne    800d29 <strfind+0xe>
  800d3f:	eb 01                	jmp    800d42 <strfind+0x27>
		if (*s == c)
			break;
  800d41:	90                   	nop
	return (char *) s;
  800d42:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d45:	c9                   	leave  
  800d46:	c3                   	ret    

00800d47 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d47:	55                   	push   %ebp
  800d48:	89 e5                	mov    %esp,%ebp
  800d4a:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d53:	8b 45 10             	mov    0x10(%ebp),%eax
  800d56:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d59:	eb 0e                	jmp    800d69 <memset+0x22>
		*p++ = c;
  800d5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5e:	8d 50 01             	lea    0x1(%eax),%edx
  800d61:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d64:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d67:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d69:	ff 4d f8             	decl   -0x8(%ebp)
  800d6c:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d70:	79 e9                	jns    800d5b <memset+0x14>
		*p++ = c;

	return v;
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d75:	c9                   	leave  
  800d76:	c3                   	ret    

00800d77 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d77:	55                   	push   %ebp
  800d78:	89 e5                	mov    %esp,%ebp
  800d7a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d80:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d89:	eb 16                	jmp    800da1 <memcpy+0x2a>
		*d++ = *s++;
  800d8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8e:	8d 50 01             	lea    0x1(%eax),%edx
  800d91:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d94:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d97:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d9a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d9d:	8a 12                	mov    (%edx),%dl
  800d9f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800da1:	8b 45 10             	mov    0x10(%ebp),%eax
  800da4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800da7:	89 55 10             	mov    %edx,0x10(%ebp)
  800daa:	85 c0                	test   %eax,%eax
  800dac:	75 dd                	jne    800d8b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db1:	c9                   	leave  
  800db2:	c3                   	ret    

00800db3 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800db3:	55                   	push   %ebp
  800db4:	89 e5                	mov    %esp,%ebp
  800db6:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800db9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dbc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc8:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dcb:	73 50                	jae    800e1d <memmove+0x6a>
  800dcd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd3:	01 d0                	add    %edx,%eax
  800dd5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd8:	76 43                	jbe    800e1d <memmove+0x6a>
		s += n;
  800dda:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddd:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800de0:	8b 45 10             	mov    0x10(%ebp),%eax
  800de3:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800de6:	eb 10                	jmp    800df8 <memmove+0x45>
			*--d = *--s;
  800de8:	ff 4d f8             	decl   -0x8(%ebp)
  800deb:	ff 4d fc             	decl   -0x4(%ebp)
  800dee:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df1:	8a 10                	mov    (%eax),%dl
  800df3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df6:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800df8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfb:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfe:	89 55 10             	mov    %edx,0x10(%ebp)
  800e01:	85 c0                	test   %eax,%eax
  800e03:	75 e3                	jne    800de8 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e05:	eb 23                	jmp    800e2a <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e07:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e0a:	8d 50 01             	lea    0x1(%eax),%edx
  800e0d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e10:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e13:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e16:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e19:	8a 12                	mov    (%edx),%dl
  800e1b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e1d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e20:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e23:	89 55 10             	mov    %edx,0x10(%ebp)
  800e26:	85 c0                	test   %eax,%eax
  800e28:	75 dd                	jne    800e07 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e2a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e2d:	c9                   	leave  
  800e2e:	c3                   	ret    

00800e2f <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e2f:	55                   	push   %ebp
  800e30:	89 e5                	mov    %esp,%ebp
  800e32:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3e:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e41:	eb 2a                	jmp    800e6d <memcmp+0x3e>
		if (*s1 != *s2)
  800e43:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e46:	8a 10                	mov    (%eax),%dl
  800e48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e4b:	8a 00                	mov    (%eax),%al
  800e4d:	38 c2                	cmp    %al,%dl
  800e4f:	74 16                	je     800e67 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e54:	8a 00                	mov    (%eax),%al
  800e56:	0f b6 d0             	movzbl %al,%edx
  800e59:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e5c:	8a 00                	mov    (%eax),%al
  800e5e:	0f b6 c0             	movzbl %al,%eax
  800e61:	29 c2                	sub    %eax,%edx
  800e63:	89 d0                	mov    %edx,%eax
  800e65:	eb 18                	jmp    800e7f <memcmp+0x50>
		s1++, s2++;
  800e67:	ff 45 fc             	incl   -0x4(%ebp)
  800e6a:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e70:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e73:	89 55 10             	mov    %edx,0x10(%ebp)
  800e76:	85 c0                	test   %eax,%eax
  800e78:	75 c9                	jne    800e43 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e7a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e7f:	c9                   	leave  
  800e80:	c3                   	ret    

00800e81 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e81:	55                   	push   %ebp
  800e82:	89 e5                	mov    %esp,%ebp
  800e84:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e87:	8b 55 08             	mov    0x8(%ebp),%edx
  800e8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800e8d:	01 d0                	add    %edx,%eax
  800e8f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e92:	eb 15                	jmp    800ea9 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	8a 00                	mov    (%eax),%al
  800e99:	0f b6 d0             	movzbl %al,%edx
  800e9c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9f:	0f b6 c0             	movzbl %al,%eax
  800ea2:	39 c2                	cmp    %eax,%edx
  800ea4:	74 0d                	je     800eb3 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ea6:	ff 45 08             	incl   0x8(%ebp)
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eac:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eaf:	72 e3                	jb     800e94 <memfind+0x13>
  800eb1:	eb 01                	jmp    800eb4 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800eb3:	90                   	nop
	return (void *) s;
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb7:	c9                   	leave  
  800eb8:	c3                   	ret    

00800eb9 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eb9:	55                   	push   %ebp
  800eba:	89 e5                	mov    %esp,%ebp
  800ebc:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ebf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ec6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ecd:	eb 03                	jmp    800ed2 <strtol+0x19>
		s++;
  800ecf:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	8a 00                	mov    (%eax),%al
  800ed7:	3c 20                	cmp    $0x20,%al
  800ed9:	74 f4                	je     800ecf <strtol+0x16>
  800edb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ede:	8a 00                	mov    (%eax),%al
  800ee0:	3c 09                	cmp    $0x9,%al
  800ee2:	74 eb                	je     800ecf <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ee4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee7:	8a 00                	mov    (%eax),%al
  800ee9:	3c 2b                	cmp    $0x2b,%al
  800eeb:	75 05                	jne    800ef2 <strtol+0x39>
		s++;
  800eed:	ff 45 08             	incl   0x8(%ebp)
  800ef0:	eb 13                	jmp    800f05 <strtol+0x4c>
	else if (*s == '-')
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	8a 00                	mov    (%eax),%al
  800ef7:	3c 2d                	cmp    $0x2d,%al
  800ef9:	75 0a                	jne    800f05 <strtol+0x4c>
		s++, neg = 1;
  800efb:	ff 45 08             	incl   0x8(%ebp)
  800efe:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f05:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f09:	74 06                	je     800f11 <strtol+0x58>
  800f0b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f0f:	75 20                	jne    800f31 <strtol+0x78>
  800f11:	8b 45 08             	mov    0x8(%ebp),%eax
  800f14:	8a 00                	mov    (%eax),%al
  800f16:	3c 30                	cmp    $0x30,%al
  800f18:	75 17                	jne    800f31 <strtol+0x78>
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	40                   	inc    %eax
  800f1e:	8a 00                	mov    (%eax),%al
  800f20:	3c 78                	cmp    $0x78,%al
  800f22:	75 0d                	jne    800f31 <strtol+0x78>
		s += 2, base = 16;
  800f24:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f28:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f2f:	eb 28                	jmp    800f59 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f31:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f35:	75 15                	jne    800f4c <strtol+0x93>
  800f37:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3a:	8a 00                	mov    (%eax),%al
  800f3c:	3c 30                	cmp    $0x30,%al
  800f3e:	75 0c                	jne    800f4c <strtol+0x93>
		s++, base = 8;
  800f40:	ff 45 08             	incl   0x8(%ebp)
  800f43:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f4a:	eb 0d                	jmp    800f59 <strtol+0xa0>
	else if (base == 0)
  800f4c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f50:	75 07                	jne    800f59 <strtol+0xa0>
		base = 10;
  800f52:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	8a 00                	mov    (%eax),%al
  800f5e:	3c 2f                	cmp    $0x2f,%al
  800f60:	7e 19                	jle    800f7b <strtol+0xc2>
  800f62:	8b 45 08             	mov    0x8(%ebp),%eax
  800f65:	8a 00                	mov    (%eax),%al
  800f67:	3c 39                	cmp    $0x39,%al
  800f69:	7f 10                	jg     800f7b <strtol+0xc2>
			dig = *s - '0';
  800f6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6e:	8a 00                	mov    (%eax),%al
  800f70:	0f be c0             	movsbl %al,%eax
  800f73:	83 e8 30             	sub    $0x30,%eax
  800f76:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f79:	eb 42                	jmp    800fbd <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7e:	8a 00                	mov    (%eax),%al
  800f80:	3c 60                	cmp    $0x60,%al
  800f82:	7e 19                	jle    800f9d <strtol+0xe4>
  800f84:	8b 45 08             	mov    0x8(%ebp),%eax
  800f87:	8a 00                	mov    (%eax),%al
  800f89:	3c 7a                	cmp    $0x7a,%al
  800f8b:	7f 10                	jg     800f9d <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f90:	8a 00                	mov    (%eax),%al
  800f92:	0f be c0             	movsbl %al,%eax
  800f95:	83 e8 57             	sub    $0x57,%eax
  800f98:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f9b:	eb 20                	jmp    800fbd <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa0:	8a 00                	mov    (%eax),%al
  800fa2:	3c 40                	cmp    $0x40,%al
  800fa4:	7e 39                	jle    800fdf <strtol+0x126>
  800fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa9:	8a 00                	mov    (%eax),%al
  800fab:	3c 5a                	cmp    $0x5a,%al
  800fad:	7f 30                	jg     800fdf <strtol+0x126>
			dig = *s - 'A' + 10;
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	8a 00                	mov    (%eax),%al
  800fb4:	0f be c0             	movsbl %al,%eax
  800fb7:	83 e8 37             	sub    $0x37,%eax
  800fba:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc0:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fc3:	7d 19                	jge    800fde <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fc5:	ff 45 08             	incl   0x8(%ebp)
  800fc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fcb:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fcf:	89 c2                	mov    %eax,%edx
  800fd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd4:	01 d0                	add    %edx,%eax
  800fd6:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fd9:	e9 7b ff ff ff       	jmp    800f59 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fde:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fdf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe3:	74 08                	je     800fed <strtol+0x134>
		*endptr = (char *) s;
  800fe5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe8:	8b 55 08             	mov    0x8(%ebp),%edx
  800feb:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fed:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ff1:	74 07                	je     800ffa <strtol+0x141>
  800ff3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff6:	f7 d8                	neg    %eax
  800ff8:	eb 03                	jmp    800ffd <strtol+0x144>
  800ffa:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ffd:	c9                   	leave  
  800ffe:	c3                   	ret    

00800fff <ltostr>:

void
ltostr(long value, char *str)
{
  800fff:	55                   	push   %ebp
  801000:	89 e5                	mov    %esp,%ebp
  801002:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801005:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80100c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801013:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801017:	79 13                	jns    80102c <ltostr+0x2d>
	{
		neg = 1;
  801019:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801020:	8b 45 0c             	mov    0xc(%ebp),%eax
  801023:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801026:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801029:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
  80102f:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801034:	99                   	cltd   
  801035:	f7 f9                	idiv   %ecx
  801037:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80103a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80103d:	8d 50 01             	lea    0x1(%eax),%edx
  801040:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801043:	89 c2                	mov    %eax,%edx
  801045:	8b 45 0c             	mov    0xc(%ebp),%eax
  801048:	01 d0                	add    %edx,%eax
  80104a:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80104d:	83 c2 30             	add    $0x30,%edx
  801050:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801052:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801055:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80105a:	f7 e9                	imul   %ecx
  80105c:	c1 fa 02             	sar    $0x2,%edx
  80105f:	89 c8                	mov    %ecx,%eax
  801061:	c1 f8 1f             	sar    $0x1f,%eax
  801064:	29 c2                	sub    %eax,%edx
  801066:	89 d0                	mov    %edx,%eax
  801068:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80106b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80106e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801073:	f7 e9                	imul   %ecx
  801075:	c1 fa 02             	sar    $0x2,%edx
  801078:	89 c8                	mov    %ecx,%eax
  80107a:	c1 f8 1f             	sar    $0x1f,%eax
  80107d:	29 c2                	sub    %eax,%edx
  80107f:	89 d0                	mov    %edx,%eax
  801081:	c1 e0 02             	shl    $0x2,%eax
  801084:	01 d0                	add    %edx,%eax
  801086:	01 c0                	add    %eax,%eax
  801088:	29 c1                	sub    %eax,%ecx
  80108a:	89 ca                	mov    %ecx,%edx
  80108c:	85 d2                	test   %edx,%edx
  80108e:	75 9c                	jne    80102c <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801097:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80109a:	48                   	dec    %eax
  80109b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80109e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010a2:	74 3d                	je     8010e1 <ltostr+0xe2>
		start = 1 ;
  8010a4:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010ab:	eb 34                	jmp    8010e1 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010ad:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010b3:	01 d0                	add    %edx,%eax
  8010b5:	8a 00                	mov    (%eax),%al
  8010b7:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c0:	01 c2                	add    %eax,%edx
  8010c2:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c8:	01 c8                	add    %ecx,%eax
  8010ca:	8a 00                	mov    (%eax),%al
  8010cc:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ce:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d4:	01 c2                	add    %eax,%edx
  8010d6:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010d9:	88 02                	mov    %al,(%edx)
		start++ ;
  8010db:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010de:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010e7:	7c c4                	jl     8010ad <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010e9:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ef:	01 d0                	add    %edx,%eax
  8010f1:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010f4:	90                   	nop
  8010f5:	c9                   	leave  
  8010f6:	c3                   	ret    

008010f7 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010f7:	55                   	push   %ebp
  8010f8:	89 e5                	mov    %esp,%ebp
  8010fa:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010fd:	ff 75 08             	pushl  0x8(%ebp)
  801100:	e8 54 fa ff ff       	call   800b59 <strlen>
  801105:	83 c4 04             	add    $0x4,%esp
  801108:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80110b:	ff 75 0c             	pushl  0xc(%ebp)
  80110e:	e8 46 fa ff ff       	call   800b59 <strlen>
  801113:	83 c4 04             	add    $0x4,%esp
  801116:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801119:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801120:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801127:	eb 17                	jmp    801140 <strcconcat+0x49>
		final[s] = str1[s] ;
  801129:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80112c:	8b 45 10             	mov    0x10(%ebp),%eax
  80112f:	01 c2                	add    %eax,%edx
  801131:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801134:	8b 45 08             	mov    0x8(%ebp),%eax
  801137:	01 c8                	add    %ecx,%eax
  801139:	8a 00                	mov    (%eax),%al
  80113b:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80113d:	ff 45 fc             	incl   -0x4(%ebp)
  801140:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801143:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801146:	7c e1                	jl     801129 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801148:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80114f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801156:	eb 1f                	jmp    801177 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801158:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80115b:	8d 50 01             	lea    0x1(%eax),%edx
  80115e:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801161:	89 c2                	mov    %eax,%edx
  801163:	8b 45 10             	mov    0x10(%ebp),%eax
  801166:	01 c2                	add    %eax,%edx
  801168:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80116b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116e:	01 c8                	add    %ecx,%eax
  801170:	8a 00                	mov    (%eax),%al
  801172:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801174:	ff 45 f8             	incl   -0x8(%ebp)
  801177:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80117a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80117d:	7c d9                	jl     801158 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80117f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801182:	8b 45 10             	mov    0x10(%ebp),%eax
  801185:	01 d0                	add    %edx,%eax
  801187:	c6 00 00             	movb   $0x0,(%eax)
}
  80118a:	90                   	nop
  80118b:	c9                   	leave  
  80118c:	c3                   	ret    

0080118d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80118d:	55                   	push   %ebp
  80118e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801190:	8b 45 14             	mov    0x14(%ebp),%eax
  801193:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801199:	8b 45 14             	mov    0x14(%ebp),%eax
  80119c:	8b 00                	mov    (%eax),%eax
  80119e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a8:	01 d0                	add    %edx,%eax
  8011aa:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b0:	eb 0c                	jmp    8011be <strsplit+0x31>
			*string++ = 0;
  8011b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b5:	8d 50 01             	lea    0x1(%eax),%edx
  8011b8:	89 55 08             	mov    %edx,0x8(%ebp)
  8011bb:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011be:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c1:	8a 00                	mov    (%eax),%al
  8011c3:	84 c0                	test   %al,%al
  8011c5:	74 18                	je     8011df <strsplit+0x52>
  8011c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ca:	8a 00                	mov    (%eax),%al
  8011cc:	0f be c0             	movsbl %al,%eax
  8011cf:	50                   	push   %eax
  8011d0:	ff 75 0c             	pushl  0xc(%ebp)
  8011d3:	e8 13 fb ff ff       	call   800ceb <strchr>
  8011d8:	83 c4 08             	add    $0x8,%esp
  8011db:	85 c0                	test   %eax,%eax
  8011dd:	75 d3                	jne    8011b2 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011df:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e2:	8a 00                	mov    (%eax),%al
  8011e4:	84 c0                	test   %al,%al
  8011e6:	74 5a                	je     801242 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011eb:	8b 00                	mov    (%eax),%eax
  8011ed:	83 f8 0f             	cmp    $0xf,%eax
  8011f0:	75 07                	jne    8011f9 <strsplit+0x6c>
		{
			return 0;
  8011f2:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f7:	eb 66                	jmp    80125f <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011fc:	8b 00                	mov    (%eax),%eax
  8011fe:	8d 48 01             	lea    0x1(%eax),%ecx
  801201:	8b 55 14             	mov    0x14(%ebp),%edx
  801204:	89 0a                	mov    %ecx,(%edx)
  801206:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80120d:	8b 45 10             	mov    0x10(%ebp),%eax
  801210:	01 c2                	add    %eax,%edx
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801217:	eb 03                	jmp    80121c <strsplit+0x8f>
			string++;
  801219:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8a 00                	mov    (%eax),%al
  801221:	84 c0                	test   %al,%al
  801223:	74 8b                	je     8011b0 <strsplit+0x23>
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	0f be c0             	movsbl %al,%eax
  80122d:	50                   	push   %eax
  80122e:	ff 75 0c             	pushl  0xc(%ebp)
  801231:	e8 b5 fa ff ff       	call   800ceb <strchr>
  801236:	83 c4 08             	add    $0x8,%esp
  801239:	85 c0                	test   %eax,%eax
  80123b:	74 dc                	je     801219 <strsplit+0x8c>
			string++;
	}
  80123d:	e9 6e ff ff ff       	jmp    8011b0 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801242:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801243:	8b 45 14             	mov    0x14(%ebp),%eax
  801246:	8b 00                	mov    (%eax),%eax
  801248:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80124f:	8b 45 10             	mov    0x10(%ebp),%eax
  801252:	01 d0                	add    %edx,%eax
  801254:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80125a:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80125f:	c9                   	leave  
  801260:	c3                   	ret    

00801261 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801261:	55                   	push   %ebp
  801262:	89 e5                	mov    %esp,%ebp
  801264:	57                   	push   %edi
  801265:	56                   	push   %esi
  801266:	53                   	push   %ebx
  801267:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80126a:	8b 45 08             	mov    0x8(%ebp),%eax
  80126d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801270:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801273:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801276:	8b 7d 18             	mov    0x18(%ebp),%edi
  801279:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80127c:	cd 30                	int    $0x30
  80127e:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801281:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801284:	83 c4 10             	add    $0x10,%esp
  801287:	5b                   	pop    %ebx
  801288:	5e                   	pop    %esi
  801289:	5f                   	pop    %edi
  80128a:	5d                   	pop    %ebp
  80128b:	c3                   	ret    

0080128c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80128c:	55                   	push   %ebp
  80128d:	89 e5                	mov    %esp,%ebp
  80128f:	83 ec 04             	sub    $0x4,%esp
  801292:	8b 45 10             	mov    0x10(%ebp),%eax
  801295:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801298:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80129c:	8b 45 08             	mov    0x8(%ebp),%eax
  80129f:	6a 00                	push   $0x0
  8012a1:	6a 00                	push   $0x0
  8012a3:	52                   	push   %edx
  8012a4:	ff 75 0c             	pushl  0xc(%ebp)
  8012a7:	50                   	push   %eax
  8012a8:	6a 00                	push   $0x0
  8012aa:	e8 b2 ff ff ff       	call   801261 <syscall>
  8012af:	83 c4 18             	add    $0x18,%esp
}
  8012b2:	90                   	nop
  8012b3:	c9                   	leave  
  8012b4:	c3                   	ret    

008012b5 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012b5:	55                   	push   %ebp
  8012b6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 01                	push   $0x1
  8012c4:	e8 98 ff ff ff       	call   801261 <syscall>
  8012c9:	83 c4 18             	add    $0x18,%esp
}
  8012cc:	c9                   	leave  
  8012cd:	c3                   	ret    

008012ce <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012ce:	55                   	push   %ebp
  8012cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	50                   	push   %eax
  8012dd:	6a 05                	push   $0x5
  8012df:	e8 7d ff ff ff       	call   801261 <syscall>
  8012e4:	83 c4 18             	add    $0x18,%esp
}
  8012e7:	c9                   	leave  
  8012e8:	c3                   	ret    

008012e9 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012e9:	55                   	push   %ebp
  8012ea:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	6a 02                	push   $0x2
  8012f8:	e8 64 ff ff ff       	call   801261 <syscall>
  8012fd:	83 c4 18             	add    $0x18,%esp
}
  801300:	c9                   	leave  
  801301:	c3                   	ret    

00801302 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801302:	55                   	push   %ebp
  801303:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 00                	push   $0x0
  80130d:	6a 00                	push   $0x0
  80130f:	6a 03                	push   $0x3
  801311:	e8 4b ff ff ff       	call   801261 <syscall>
  801316:	83 c4 18             	add    $0x18,%esp
}
  801319:	c9                   	leave  
  80131a:	c3                   	ret    

0080131b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80131b:	55                   	push   %ebp
  80131c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 04                	push   $0x4
  80132a:	e8 32 ff ff ff       	call   801261 <syscall>
  80132f:	83 c4 18             	add    $0x18,%esp
}
  801332:	c9                   	leave  
  801333:	c3                   	ret    

00801334 <sys_env_exit>:


void sys_env_exit(void)
{
  801334:	55                   	push   %ebp
  801335:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	6a 06                	push   $0x6
  801343:	e8 19 ff ff ff       	call   801261 <syscall>
  801348:	83 c4 18             	add    $0x18,%esp
}
  80134b:	90                   	nop
  80134c:	c9                   	leave  
  80134d:	c3                   	ret    

0080134e <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80134e:	55                   	push   %ebp
  80134f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801351:	8b 55 0c             	mov    0xc(%ebp),%edx
  801354:	8b 45 08             	mov    0x8(%ebp),%eax
  801357:	6a 00                	push   $0x0
  801359:	6a 00                	push   $0x0
  80135b:	6a 00                	push   $0x0
  80135d:	52                   	push   %edx
  80135e:	50                   	push   %eax
  80135f:	6a 07                	push   $0x7
  801361:	e8 fb fe ff ff       	call   801261 <syscall>
  801366:	83 c4 18             	add    $0x18,%esp
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
  80136e:	56                   	push   %esi
  80136f:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801370:	8b 75 18             	mov    0x18(%ebp),%esi
  801373:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801376:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801379:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	56                   	push   %esi
  801380:	53                   	push   %ebx
  801381:	51                   	push   %ecx
  801382:	52                   	push   %edx
  801383:	50                   	push   %eax
  801384:	6a 08                	push   $0x8
  801386:	e8 d6 fe ff ff       	call   801261 <syscall>
  80138b:	83 c4 18             	add    $0x18,%esp
}
  80138e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801391:	5b                   	pop    %ebx
  801392:	5e                   	pop    %esi
  801393:	5d                   	pop    %ebp
  801394:	c3                   	ret    

00801395 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801398:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139b:	8b 45 08             	mov    0x8(%ebp),%eax
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 00                	push   $0x0
  8013a2:	6a 00                	push   $0x0
  8013a4:	52                   	push   %edx
  8013a5:	50                   	push   %eax
  8013a6:	6a 09                	push   $0x9
  8013a8:	e8 b4 fe ff ff       	call   801261 <syscall>
  8013ad:	83 c4 18             	add    $0x18,%esp
}
  8013b0:	c9                   	leave  
  8013b1:	c3                   	ret    

008013b2 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013b2:	55                   	push   %ebp
  8013b3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	ff 75 0c             	pushl  0xc(%ebp)
  8013be:	ff 75 08             	pushl  0x8(%ebp)
  8013c1:	6a 0a                	push   $0xa
  8013c3:	e8 99 fe ff ff       	call   801261 <syscall>
  8013c8:	83 c4 18             	add    $0x18,%esp
}
  8013cb:	c9                   	leave  
  8013cc:	c3                   	ret    

008013cd <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013cd:	55                   	push   %ebp
  8013ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 0b                	push   $0xb
  8013dc:	e8 80 fe ff ff       	call   801261 <syscall>
  8013e1:	83 c4 18             	add    $0x18,%esp
}
  8013e4:	c9                   	leave  
  8013e5:	c3                   	ret    

008013e6 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013e6:	55                   	push   %ebp
  8013e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 00                	push   $0x0
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 0c                	push   $0xc
  8013f5:	e8 67 fe ff ff       	call   801261 <syscall>
  8013fa:	83 c4 18             	add    $0x18,%esp
}
  8013fd:	c9                   	leave  
  8013fe:	c3                   	ret    

008013ff <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013ff:	55                   	push   %ebp
  801400:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 00                	push   $0x0
  80140a:	6a 00                	push   $0x0
  80140c:	6a 0d                	push   $0xd
  80140e:	e8 4e fe ff ff       	call   801261 <syscall>
  801413:	83 c4 18             	add    $0x18,%esp
}
  801416:	c9                   	leave  
  801417:	c3                   	ret    

00801418 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	6a 00                	push   $0x0
  801421:	ff 75 0c             	pushl  0xc(%ebp)
  801424:	ff 75 08             	pushl  0x8(%ebp)
  801427:	6a 11                	push   $0x11
  801429:	e8 33 fe ff ff       	call   801261 <syscall>
  80142e:	83 c4 18             	add    $0x18,%esp
	return;
  801431:	90                   	nop
}
  801432:	c9                   	leave  
  801433:	c3                   	ret    

00801434 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801434:	55                   	push   %ebp
  801435:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801437:	6a 00                	push   $0x0
  801439:	6a 00                	push   $0x0
  80143b:	6a 00                	push   $0x0
  80143d:	ff 75 0c             	pushl  0xc(%ebp)
  801440:	ff 75 08             	pushl  0x8(%ebp)
  801443:	6a 12                	push   $0x12
  801445:	e8 17 fe ff ff       	call   801261 <syscall>
  80144a:	83 c4 18             	add    $0x18,%esp
	return ;
  80144d:	90                   	nop
}
  80144e:	c9                   	leave  
  80144f:	c3                   	ret    

00801450 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 00                	push   $0x0
  80145b:	6a 00                	push   $0x0
  80145d:	6a 0e                	push   $0xe
  80145f:	e8 fd fd ff ff       	call   801261 <syscall>
  801464:	83 c4 18             	add    $0x18,%esp
}
  801467:	c9                   	leave  
  801468:	c3                   	ret    

00801469 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801469:	55                   	push   %ebp
  80146a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	6a 00                	push   $0x0
  801472:	6a 00                	push   $0x0
  801474:	ff 75 08             	pushl  0x8(%ebp)
  801477:	6a 0f                	push   $0xf
  801479:	e8 e3 fd ff ff       	call   801261 <syscall>
  80147e:	83 c4 18             	add    $0x18,%esp
}
  801481:	c9                   	leave  
  801482:	c3                   	ret    

00801483 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801483:	55                   	push   %ebp
  801484:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	6a 00                	push   $0x0
  801490:	6a 10                	push   $0x10
  801492:	e8 ca fd ff ff       	call   801261 <syscall>
  801497:	83 c4 18             	add    $0x18,%esp
}
  80149a:	90                   	nop
  80149b:	c9                   	leave  
  80149c:	c3                   	ret    

0080149d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80149d:	55                   	push   %ebp
  80149e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 00                	push   $0x0
  8014a8:	6a 00                	push   $0x0
  8014aa:	6a 14                	push   $0x14
  8014ac:	e8 b0 fd ff ff       	call   801261 <syscall>
  8014b1:	83 c4 18             	add    $0x18,%esp
}
  8014b4:	90                   	nop
  8014b5:	c9                   	leave  
  8014b6:	c3                   	ret    

008014b7 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 15                	push   $0x15
  8014c6:	e8 96 fd ff ff       	call   801261 <syscall>
  8014cb:	83 c4 18             	add    $0x18,%esp
}
  8014ce:	90                   	nop
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
  8014d4:	83 ec 04             	sub    $0x4,%esp
  8014d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014da:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014dd:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	50                   	push   %eax
  8014ea:	6a 16                	push   $0x16
  8014ec:	e8 70 fd ff ff       	call   801261 <syscall>
  8014f1:	83 c4 18             	add    $0x18,%esp
}
  8014f4:	90                   	nop
  8014f5:	c9                   	leave  
  8014f6:	c3                   	ret    

008014f7 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014f7:	55                   	push   %ebp
  8014f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 17                	push   $0x17
  801506:	e8 56 fd ff ff       	call   801261 <syscall>
  80150b:	83 c4 18             	add    $0x18,%esp
}
  80150e:	90                   	nop
  80150f:	c9                   	leave  
  801510:	c3                   	ret    

00801511 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801511:	55                   	push   %ebp
  801512:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801514:	8b 45 08             	mov    0x8(%ebp),%eax
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	ff 75 0c             	pushl  0xc(%ebp)
  801520:	50                   	push   %eax
  801521:	6a 18                	push   $0x18
  801523:	e8 39 fd ff ff       	call   801261 <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801530:	8b 55 0c             	mov    0xc(%ebp),%edx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	52                   	push   %edx
  80153d:	50                   	push   %eax
  80153e:	6a 1b                	push   $0x1b
  801540:	e8 1c fd ff ff       	call   801261 <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
}
  801548:	c9                   	leave  
  801549:	c3                   	ret    

0080154a <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80154d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801550:	8b 45 08             	mov    0x8(%ebp),%eax
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	52                   	push   %edx
  80155a:	50                   	push   %eax
  80155b:	6a 19                	push   $0x19
  80155d:	e8 ff fc ff ff       	call   801261 <syscall>
  801562:	83 c4 18             	add    $0x18,%esp
}
  801565:	90                   	nop
  801566:	c9                   	leave  
  801567:	c3                   	ret    

00801568 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801568:	55                   	push   %ebp
  801569:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80156b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80156e:	8b 45 08             	mov    0x8(%ebp),%eax
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	52                   	push   %edx
  801578:	50                   	push   %eax
  801579:	6a 1a                	push   $0x1a
  80157b:	e8 e1 fc ff ff       	call   801261 <syscall>
  801580:	83 c4 18             	add    $0x18,%esp
}
  801583:	90                   	nop
  801584:	c9                   	leave  
  801585:	c3                   	ret    

00801586 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801586:	55                   	push   %ebp
  801587:	89 e5                	mov    %esp,%ebp
  801589:	83 ec 04             	sub    $0x4,%esp
  80158c:	8b 45 10             	mov    0x10(%ebp),%eax
  80158f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801592:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801595:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	6a 00                	push   $0x0
  80159e:	51                   	push   %ecx
  80159f:	52                   	push   %edx
  8015a0:	ff 75 0c             	pushl  0xc(%ebp)
  8015a3:	50                   	push   %eax
  8015a4:	6a 1c                	push   $0x1c
  8015a6:	e8 b6 fc ff ff       	call   801261 <syscall>
  8015ab:	83 c4 18             	add    $0x18,%esp
}
  8015ae:	c9                   	leave  
  8015af:	c3                   	ret    

008015b0 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015b3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	52                   	push   %edx
  8015c0:	50                   	push   %eax
  8015c1:	6a 1d                	push   $0x1d
  8015c3:	e8 99 fc ff ff       	call   801261 <syscall>
  8015c8:	83 c4 18             	add    $0x18,%esp
}
  8015cb:	c9                   	leave  
  8015cc:	c3                   	ret    

008015cd <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015cd:	55                   	push   %ebp
  8015ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015d0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d9:	6a 00                	push   $0x0
  8015db:	6a 00                	push   $0x0
  8015dd:	51                   	push   %ecx
  8015de:	52                   	push   %edx
  8015df:	50                   	push   %eax
  8015e0:	6a 1e                	push   $0x1e
  8015e2:	e8 7a fc ff ff       	call   801261 <syscall>
  8015e7:	83 c4 18             	add    $0x18,%esp
}
  8015ea:	c9                   	leave  
  8015eb:	c3                   	ret    

008015ec <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015ec:	55                   	push   %ebp
  8015ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015ef:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f5:	6a 00                	push   $0x0
  8015f7:	6a 00                	push   $0x0
  8015f9:	6a 00                	push   $0x0
  8015fb:	52                   	push   %edx
  8015fc:	50                   	push   %eax
  8015fd:	6a 1f                	push   $0x1f
  8015ff:	e8 5d fc ff ff       	call   801261 <syscall>
  801604:	83 c4 18             	add    $0x18,%esp
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 20                	push   $0x20
  801618:	e8 44 fc ff ff       	call   801261 <syscall>
  80161d:	83 c4 18             	add    $0x18,%esp
}
  801620:	c9                   	leave  
  801621:	c3                   	ret    

00801622 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801622:	55                   	push   %ebp
  801623:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801625:	8b 45 08             	mov    0x8(%ebp),%eax
  801628:	6a 00                	push   $0x0
  80162a:	ff 75 14             	pushl  0x14(%ebp)
  80162d:	ff 75 10             	pushl  0x10(%ebp)
  801630:	ff 75 0c             	pushl  0xc(%ebp)
  801633:	50                   	push   %eax
  801634:	6a 21                	push   $0x21
  801636:	e8 26 fc ff ff       	call   801261 <syscall>
  80163b:	83 c4 18             	add    $0x18,%esp
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801643:	8b 45 08             	mov    0x8(%ebp),%eax
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	6a 00                	push   $0x0
  80164e:	50                   	push   %eax
  80164f:	6a 22                	push   $0x22
  801651:	e8 0b fc ff ff       	call   801261 <syscall>
  801656:	83 c4 18             	add    $0x18,%esp
}
  801659:	90                   	nop
  80165a:	c9                   	leave  
  80165b:	c3                   	ret    

0080165c <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80165c:	55                   	push   %ebp
  80165d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	6a 00                	push   $0x0
  80166a:	50                   	push   %eax
  80166b:	6a 23                	push   $0x23
  80166d:	e8 ef fb ff ff       	call   801261 <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
}
  801675:	90                   	nop
  801676:	c9                   	leave  
  801677:	c3                   	ret    

00801678 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801678:	55                   	push   %ebp
  801679:	89 e5                	mov    %esp,%ebp
  80167b:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80167e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801681:	8d 50 04             	lea    0x4(%eax),%edx
  801684:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801687:	6a 00                	push   $0x0
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	52                   	push   %edx
  80168e:	50                   	push   %eax
  80168f:	6a 24                	push   $0x24
  801691:	e8 cb fb ff ff       	call   801261 <syscall>
  801696:	83 c4 18             	add    $0x18,%esp
	return result;
  801699:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80169c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80169f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016a2:	89 01                	mov    %eax,(%ecx)
  8016a4:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016aa:	c9                   	leave  
  8016ab:	c2 04 00             	ret    $0x4

008016ae <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	ff 75 10             	pushl  0x10(%ebp)
  8016b8:	ff 75 0c             	pushl  0xc(%ebp)
  8016bb:	ff 75 08             	pushl  0x8(%ebp)
  8016be:	6a 13                	push   $0x13
  8016c0:	e8 9c fb ff ff       	call   801261 <syscall>
  8016c5:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c8:	90                   	nop
}
  8016c9:	c9                   	leave  
  8016ca:	c3                   	ret    

008016cb <sys_rcr2>:
uint32 sys_rcr2()
{
  8016cb:	55                   	push   %ebp
  8016cc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 00                	push   $0x0
  8016d8:	6a 25                	push   $0x25
  8016da:	e8 82 fb ff ff       	call   801261 <syscall>
  8016df:	83 c4 18             	add    $0x18,%esp
}
  8016e2:	c9                   	leave  
  8016e3:	c3                   	ret    

008016e4 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016e4:	55                   	push   %ebp
  8016e5:	89 e5                	mov    %esp,%ebp
  8016e7:	83 ec 04             	sub    $0x4,%esp
  8016ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ed:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016f0:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	50                   	push   %eax
  8016fd:	6a 26                	push   $0x26
  8016ff:	e8 5d fb ff ff       	call   801261 <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
	return ;
  801707:	90                   	nop
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <rsttst>:
void rsttst()
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 28                	push   $0x28
  801719:	e8 43 fb ff ff       	call   801261 <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
	return ;
  801721:	90                   	nop
}
  801722:	c9                   	leave  
  801723:	c3                   	ret    

00801724 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801724:	55                   	push   %ebp
  801725:	89 e5                	mov    %esp,%ebp
  801727:	83 ec 04             	sub    $0x4,%esp
  80172a:	8b 45 14             	mov    0x14(%ebp),%eax
  80172d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801730:	8b 55 18             	mov    0x18(%ebp),%edx
  801733:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801737:	52                   	push   %edx
  801738:	50                   	push   %eax
  801739:	ff 75 10             	pushl  0x10(%ebp)
  80173c:	ff 75 0c             	pushl  0xc(%ebp)
  80173f:	ff 75 08             	pushl  0x8(%ebp)
  801742:	6a 27                	push   $0x27
  801744:	e8 18 fb ff ff       	call   801261 <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
	return ;
  80174c:	90                   	nop
}
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <chktst>:
void chktst(uint32 n)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	6a 00                	push   $0x0
  801758:	6a 00                	push   $0x0
  80175a:	ff 75 08             	pushl  0x8(%ebp)
  80175d:	6a 29                	push   $0x29
  80175f:	e8 fd fa ff ff       	call   801261 <syscall>
  801764:	83 c4 18             	add    $0x18,%esp
	return ;
  801767:	90                   	nop
}
  801768:	c9                   	leave  
  801769:	c3                   	ret    

0080176a <inctst>:

void inctst()
{
  80176a:	55                   	push   %ebp
  80176b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 00                	push   $0x0
  801775:	6a 00                	push   $0x0
  801777:	6a 2a                	push   $0x2a
  801779:	e8 e3 fa ff ff       	call   801261 <syscall>
  80177e:	83 c4 18             	add    $0x18,%esp
	return ;
  801781:	90                   	nop
}
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <gettst>:
uint32 gettst()
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 2b                	push   $0x2b
  801793:	e8 c9 fa ff ff       	call   801261 <syscall>
  801798:	83 c4 18             	add    $0x18,%esp
}
  80179b:	c9                   	leave  
  80179c:	c3                   	ret    

0080179d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80179d:	55                   	push   %ebp
  80179e:	89 e5                	mov    %esp,%ebp
  8017a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 2c                	push   $0x2c
  8017af:	e8 ad fa ff ff       	call   801261 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
  8017b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017ba:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017be:	75 07                	jne    8017c7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c5:	eb 05                	jmp    8017cc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017cc:	c9                   	leave  
  8017cd:	c3                   	ret    

008017ce <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017ce:	55                   	push   %ebp
  8017cf:	89 e5                	mov    %esp,%ebp
  8017d1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 2c                	push   $0x2c
  8017e0:	e8 7c fa ff ff       	call   801261 <syscall>
  8017e5:	83 c4 18             	add    $0x18,%esp
  8017e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017eb:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017ef:	75 07                	jne    8017f8 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f6:	eb 05                	jmp    8017fd <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
  801802:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	6a 00                	push   $0x0
  80180f:	6a 2c                	push   $0x2c
  801811:	e8 4b fa ff ff       	call   801261 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
  801819:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80181c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801820:	75 07                	jne    801829 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801822:	b8 01 00 00 00       	mov    $0x1,%eax
  801827:	eb 05                	jmp    80182e <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801829:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80182e:	c9                   	leave  
  80182f:	c3                   	ret    

00801830 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801830:	55                   	push   %ebp
  801831:	89 e5                	mov    %esp,%ebp
  801833:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 00                	push   $0x0
  80183e:	6a 00                	push   $0x0
  801840:	6a 2c                	push   $0x2c
  801842:	e8 1a fa ff ff       	call   801261 <syscall>
  801847:	83 c4 18             	add    $0x18,%esp
  80184a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80184d:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801851:	75 07                	jne    80185a <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801853:	b8 01 00 00 00       	mov    $0x1,%eax
  801858:	eb 05                	jmp    80185f <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80185a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185f:	c9                   	leave  
  801860:	c3                   	ret    

00801861 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801861:	55                   	push   %ebp
  801862:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 00                	push   $0x0
  80186a:	6a 00                	push   $0x0
  80186c:	ff 75 08             	pushl  0x8(%ebp)
  80186f:	6a 2d                	push   $0x2d
  801871:	e8 eb f9 ff ff       	call   801261 <syscall>
  801876:	83 c4 18             	add    $0x18,%esp
	return ;
  801879:	90                   	nop
}
  80187a:	c9                   	leave  
  80187b:	c3                   	ret    

0080187c <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80187c:	55                   	push   %ebp
  80187d:	89 e5                	mov    %esp,%ebp
  80187f:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801880:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801883:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801886:	8b 55 0c             	mov    0xc(%ebp),%edx
  801889:	8b 45 08             	mov    0x8(%ebp),%eax
  80188c:	6a 00                	push   $0x0
  80188e:	53                   	push   %ebx
  80188f:	51                   	push   %ecx
  801890:	52                   	push   %edx
  801891:	50                   	push   %eax
  801892:	6a 2e                	push   $0x2e
  801894:	e8 c8 f9 ff ff       	call   801261 <syscall>
  801899:	83 c4 18             	add    $0x18,%esp
}
  80189c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80189f:	c9                   	leave  
  8018a0:	c3                   	ret    

008018a1 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018a1:	55                   	push   %ebp
  8018a2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018aa:	6a 00                	push   $0x0
  8018ac:	6a 00                	push   $0x0
  8018ae:	6a 00                	push   $0x0
  8018b0:	52                   	push   %edx
  8018b1:	50                   	push   %eax
  8018b2:	6a 2f                	push   $0x2f
  8018b4:	e8 a8 f9 ff ff       	call   801261 <syscall>
  8018b9:	83 c4 18             	add    $0x18,%esp
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018c1:	6a 00                	push   $0x0
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ca:	ff 75 08             	pushl  0x8(%ebp)
  8018cd:	6a 30                	push   $0x30
  8018cf:	e8 8d f9 ff ff       	call   801261 <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d7:	90                   	nop
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
  8018dd:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8018e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e3:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8018e6:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8018ea:	83 ec 0c             	sub    $0xc,%esp
  8018ed:	50                   	push   %eax
  8018ee:	e8 de fb ff ff       	call   8014d1 <sys_cputc>
  8018f3:	83 c4 10             	add    $0x10,%esp
}
  8018f6:	90                   	nop
  8018f7:	c9                   	leave  
  8018f8:	c3                   	ret    

008018f9 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8018f9:	55                   	push   %ebp
  8018fa:	89 e5                	mov    %esp,%ebp
  8018fc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8018ff:	e8 99 fb ff ff       	call   80149d <sys_disable_interrupt>
	char c = ch;
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80190a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80190e:	83 ec 0c             	sub    $0xc,%esp
  801911:	50                   	push   %eax
  801912:	e8 ba fb ff ff       	call   8014d1 <sys_cputc>
  801917:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80191a:	e8 98 fb ff ff       	call   8014b7 <sys_enable_interrupt>
}
  80191f:	90                   	nop
  801920:	c9                   	leave  
  801921:	c3                   	ret    

00801922 <getchar>:

int
getchar(void)
{
  801922:	55                   	push   %ebp
  801923:	89 e5                	mov    %esp,%ebp
  801925:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  801928:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80192f:	eb 08                	jmp    801939 <getchar+0x17>
	{
		c = sys_cgetc();
  801931:	e8 7f f9 ff ff       	call   8012b5 <sys_cgetc>
  801936:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  801939:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80193d:	74 f2                	je     801931 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80193f:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <atomic_getchar>:

int
atomic_getchar(void)
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
  801947:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80194a:	e8 4e fb ff ff       	call   80149d <sys_disable_interrupt>
	int c=0;
  80194f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801956:	eb 08                	jmp    801960 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801958:	e8 58 f9 ff ff       	call   8012b5 <sys_cgetc>
  80195d:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801960:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801964:	74 f2                	je     801958 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801966:	e8 4c fb ff ff       	call   8014b7 <sys_enable_interrupt>
	return c;
  80196b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80196e:	c9                   	leave  
  80196f:	c3                   	ret    

00801970 <iscons>:

int iscons(int fdnum)
{
  801970:	55                   	push   %ebp
  801971:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801973:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801978:	5d                   	pop    %ebp
  801979:	c3                   	ret    
  80197a:	66 90                	xchg   %ax,%ax

0080197c <__udivdi3>:
  80197c:	55                   	push   %ebp
  80197d:	57                   	push   %edi
  80197e:	56                   	push   %esi
  80197f:	53                   	push   %ebx
  801980:	83 ec 1c             	sub    $0x1c,%esp
  801983:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801987:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80198b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80198f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801993:	89 ca                	mov    %ecx,%edx
  801995:	89 f8                	mov    %edi,%eax
  801997:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80199b:	85 f6                	test   %esi,%esi
  80199d:	75 2d                	jne    8019cc <__udivdi3+0x50>
  80199f:	39 cf                	cmp    %ecx,%edi
  8019a1:	77 65                	ja     801a08 <__udivdi3+0x8c>
  8019a3:	89 fd                	mov    %edi,%ebp
  8019a5:	85 ff                	test   %edi,%edi
  8019a7:	75 0b                	jne    8019b4 <__udivdi3+0x38>
  8019a9:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ae:	31 d2                	xor    %edx,%edx
  8019b0:	f7 f7                	div    %edi
  8019b2:	89 c5                	mov    %eax,%ebp
  8019b4:	31 d2                	xor    %edx,%edx
  8019b6:	89 c8                	mov    %ecx,%eax
  8019b8:	f7 f5                	div    %ebp
  8019ba:	89 c1                	mov    %eax,%ecx
  8019bc:	89 d8                	mov    %ebx,%eax
  8019be:	f7 f5                	div    %ebp
  8019c0:	89 cf                	mov    %ecx,%edi
  8019c2:	89 fa                	mov    %edi,%edx
  8019c4:	83 c4 1c             	add    $0x1c,%esp
  8019c7:	5b                   	pop    %ebx
  8019c8:	5e                   	pop    %esi
  8019c9:	5f                   	pop    %edi
  8019ca:	5d                   	pop    %ebp
  8019cb:	c3                   	ret    
  8019cc:	39 ce                	cmp    %ecx,%esi
  8019ce:	77 28                	ja     8019f8 <__udivdi3+0x7c>
  8019d0:	0f bd fe             	bsr    %esi,%edi
  8019d3:	83 f7 1f             	xor    $0x1f,%edi
  8019d6:	75 40                	jne    801a18 <__udivdi3+0x9c>
  8019d8:	39 ce                	cmp    %ecx,%esi
  8019da:	72 0a                	jb     8019e6 <__udivdi3+0x6a>
  8019dc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019e0:	0f 87 9e 00 00 00    	ja     801a84 <__udivdi3+0x108>
  8019e6:	b8 01 00 00 00       	mov    $0x1,%eax
  8019eb:	89 fa                	mov    %edi,%edx
  8019ed:	83 c4 1c             	add    $0x1c,%esp
  8019f0:	5b                   	pop    %ebx
  8019f1:	5e                   	pop    %esi
  8019f2:	5f                   	pop    %edi
  8019f3:	5d                   	pop    %ebp
  8019f4:	c3                   	ret    
  8019f5:	8d 76 00             	lea    0x0(%esi),%esi
  8019f8:	31 ff                	xor    %edi,%edi
  8019fa:	31 c0                	xor    %eax,%eax
  8019fc:	89 fa                	mov    %edi,%edx
  8019fe:	83 c4 1c             	add    $0x1c,%esp
  801a01:	5b                   	pop    %ebx
  801a02:	5e                   	pop    %esi
  801a03:	5f                   	pop    %edi
  801a04:	5d                   	pop    %ebp
  801a05:	c3                   	ret    
  801a06:	66 90                	xchg   %ax,%ax
  801a08:	89 d8                	mov    %ebx,%eax
  801a0a:	f7 f7                	div    %edi
  801a0c:	31 ff                	xor    %edi,%edi
  801a0e:	89 fa                	mov    %edi,%edx
  801a10:	83 c4 1c             	add    $0x1c,%esp
  801a13:	5b                   	pop    %ebx
  801a14:	5e                   	pop    %esi
  801a15:	5f                   	pop    %edi
  801a16:	5d                   	pop    %ebp
  801a17:	c3                   	ret    
  801a18:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a1d:	89 eb                	mov    %ebp,%ebx
  801a1f:	29 fb                	sub    %edi,%ebx
  801a21:	89 f9                	mov    %edi,%ecx
  801a23:	d3 e6                	shl    %cl,%esi
  801a25:	89 c5                	mov    %eax,%ebp
  801a27:	88 d9                	mov    %bl,%cl
  801a29:	d3 ed                	shr    %cl,%ebp
  801a2b:	89 e9                	mov    %ebp,%ecx
  801a2d:	09 f1                	or     %esi,%ecx
  801a2f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a33:	89 f9                	mov    %edi,%ecx
  801a35:	d3 e0                	shl    %cl,%eax
  801a37:	89 c5                	mov    %eax,%ebp
  801a39:	89 d6                	mov    %edx,%esi
  801a3b:	88 d9                	mov    %bl,%cl
  801a3d:	d3 ee                	shr    %cl,%esi
  801a3f:	89 f9                	mov    %edi,%ecx
  801a41:	d3 e2                	shl    %cl,%edx
  801a43:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a47:	88 d9                	mov    %bl,%cl
  801a49:	d3 e8                	shr    %cl,%eax
  801a4b:	09 c2                	or     %eax,%edx
  801a4d:	89 d0                	mov    %edx,%eax
  801a4f:	89 f2                	mov    %esi,%edx
  801a51:	f7 74 24 0c          	divl   0xc(%esp)
  801a55:	89 d6                	mov    %edx,%esi
  801a57:	89 c3                	mov    %eax,%ebx
  801a59:	f7 e5                	mul    %ebp
  801a5b:	39 d6                	cmp    %edx,%esi
  801a5d:	72 19                	jb     801a78 <__udivdi3+0xfc>
  801a5f:	74 0b                	je     801a6c <__udivdi3+0xf0>
  801a61:	89 d8                	mov    %ebx,%eax
  801a63:	31 ff                	xor    %edi,%edi
  801a65:	e9 58 ff ff ff       	jmp    8019c2 <__udivdi3+0x46>
  801a6a:	66 90                	xchg   %ax,%ax
  801a6c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a70:	89 f9                	mov    %edi,%ecx
  801a72:	d3 e2                	shl    %cl,%edx
  801a74:	39 c2                	cmp    %eax,%edx
  801a76:	73 e9                	jae    801a61 <__udivdi3+0xe5>
  801a78:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a7b:	31 ff                	xor    %edi,%edi
  801a7d:	e9 40 ff ff ff       	jmp    8019c2 <__udivdi3+0x46>
  801a82:	66 90                	xchg   %ax,%ax
  801a84:	31 c0                	xor    %eax,%eax
  801a86:	e9 37 ff ff ff       	jmp    8019c2 <__udivdi3+0x46>
  801a8b:	90                   	nop

00801a8c <__umoddi3>:
  801a8c:	55                   	push   %ebp
  801a8d:	57                   	push   %edi
  801a8e:	56                   	push   %esi
  801a8f:	53                   	push   %ebx
  801a90:	83 ec 1c             	sub    $0x1c,%esp
  801a93:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a97:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a9b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a9f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801aa3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801aa7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801aab:	89 f3                	mov    %esi,%ebx
  801aad:	89 fa                	mov    %edi,%edx
  801aaf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ab3:	89 34 24             	mov    %esi,(%esp)
  801ab6:	85 c0                	test   %eax,%eax
  801ab8:	75 1a                	jne    801ad4 <__umoddi3+0x48>
  801aba:	39 f7                	cmp    %esi,%edi
  801abc:	0f 86 a2 00 00 00    	jbe    801b64 <__umoddi3+0xd8>
  801ac2:	89 c8                	mov    %ecx,%eax
  801ac4:	89 f2                	mov    %esi,%edx
  801ac6:	f7 f7                	div    %edi
  801ac8:	89 d0                	mov    %edx,%eax
  801aca:	31 d2                	xor    %edx,%edx
  801acc:	83 c4 1c             	add    $0x1c,%esp
  801acf:	5b                   	pop    %ebx
  801ad0:	5e                   	pop    %esi
  801ad1:	5f                   	pop    %edi
  801ad2:	5d                   	pop    %ebp
  801ad3:	c3                   	ret    
  801ad4:	39 f0                	cmp    %esi,%eax
  801ad6:	0f 87 ac 00 00 00    	ja     801b88 <__umoddi3+0xfc>
  801adc:	0f bd e8             	bsr    %eax,%ebp
  801adf:	83 f5 1f             	xor    $0x1f,%ebp
  801ae2:	0f 84 ac 00 00 00    	je     801b94 <__umoddi3+0x108>
  801ae8:	bf 20 00 00 00       	mov    $0x20,%edi
  801aed:	29 ef                	sub    %ebp,%edi
  801aef:	89 fe                	mov    %edi,%esi
  801af1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801af5:	89 e9                	mov    %ebp,%ecx
  801af7:	d3 e0                	shl    %cl,%eax
  801af9:	89 d7                	mov    %edx,%edi
  801afb:	89 f1                	mov    %esi,%ecx
  801afd:	d3 ef                	shr    %cl,%edi
  801aff:	09 c7                	or     %eax,%edi
  801b01:	89 e9                	mov    %ebp,%ecx
  801b03:	d3 e2                	shl    %cl,%edx
  801b05:	89 14 24             	mov    %edx,(%esp)
  801b08:	89 d8                	mov    %ebx,%eax
  801b0a:	d3 e0                	shl    %cl,%eax
  801b0c:	89 c2                	mov    %eax,%edx
  801b0e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b12:	d3 e0                	shl    %cl,%eax
  801b14:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b18:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b1c:	89 f1                	mov    %esi,%ecx
  801b1e:	d3 e8                	shr    %cl,%eax
  801b20:	09 d0                	or     %edx,%eax
  801b22:	d3 eb                	shr    %cl,%ebx
  801b24:	89 da                	mov    %ebx,%edx
  801b26:	f7 f7                	div    %edi
  801b28:	89 d3                	mov    %edx,%ebx
  801b2a:	f7 24 24             	mull   (%esp)
  801b2d:	89 c6                	mov    %eax,%esi
  801b2f:	89 d1                	mov    %edx,%ecx
  801b31:	39 d3                	cmp    %edx,%ebx
  801b33:	0f 82 87 00 00 00    	jb     801bc0 <__umoddi3+0x134>
  801b39:	0f 84 91 00 00 00    	je     801bd0 <__umoddi3+0x144>
  801b3f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b43:	29 f2                	sub    %esi,%edx
  801b45:	19 cb                	sbb    %ecx,%ebx
  801b47:	89 d8                	mov    %ebx,%eax
  801b49:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b4d:	d3 e0                	shl    %cl,%eax
  801b4f:	89 e9                	mov    %ebp,%ecx
  801b51:	d3 ea                	shr    %cl,%edx
  801b53:	09 d0                	or     %edx,%eax
  801b55:	89 e9                	mov    %ebp,%ecx
  801b57:	d3 eb                	shr    %cl,%ebx
  801b59:	89 da                	mov    %ebx,%edx
  801b5b:	83 c4 1c             	add    $0x1c,%esp
  801b5e:	5b                   	pop    %ebx
  801b5f:	5e                   	pop    %esi
  801b60:	5f                   	pop    %edi
  801b61:	5d                   	pop    %ebp
  801b62:	c3                   	ret    
  801b63:	90                   	nop
  801b64:	89 fd                	mov    %edi,%ebp
  801b66:	85 ff                	test   %edi,%edi
  801b68:	75 0b                	jne    801b75 <__umoddi3+0xe9>
  801b6a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b6f:	31 d2                	xor    %edx,%edx
  801b71:	f7 f7                	div    %edi
  801b73:	89 c5                	mov    %eax,%ebp
  801b75:	89 f0                	mov    %esi,%eax
  801b77:	31 d2                	xor    %edx,%edx
  801b79:	f7 f5                	div    %ebp
  801b7b:	89 c8                	mov    %ecx,%eax
  801b7d:	f7 f5                	div    %ebp
  801b7f:	89 d0                	mov    %edx,%eax
  801b81:	e9 44 ff ff ff       	jmp    801aca <__umoddi3+0x3e>
  801b86:	66 90                	xchg   %ax,%ax
  801b88:	89 c8                	mov    %ecx,%eax
  801b8a:	89 f2                	mov    %esi,%edx
  801b8c:	83 c4 1c             	add    $0x1c,%esp
  801b8f:	5b                   	pop    %ebx
  801b90:	5e                   	pop    %esi
  801b91:	5f                   	pop    %edi
  801b92:	5d                   	pop    %ebp
  801b93:	c3                   	ret    
  801b94:	3b 04 24             	cmp    (%esp),%eax
  801b97:	72 06                	jb     801b9f <__umoddi3+0x113>
  801b99:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b9d:	77 0f                	ja     801bae <__umoddi3+0x122>
  801b9f:	89 f2                	mov    %esi,%edx
  801ba1:	29 f9                	sub    %edi,%ecx
  801ba3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801ba7:	89 14 24             	mov    %edx,(%esp)
  801baa:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bae:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bb2:	8b 14 24             	mov    (%esp),%edx
  801bb5:	83 c4 1c             	add    $0x1c,%esp
  801bb8:	5b                   	pop    %ebx
  801bb9:	5e                   	pop    %esi
  801bba:	5f                   	pop    %edi
  801bbb:	5d                   	pop    %ebp
  801bbc:	c3                   	ret    
  801bbd:	8d 76 00             	lea    0x0(%esi),%esi
  801bc0:	2b 04 24             	sub    (%esp),%eax
  801bc3:	19 fa                	sbb    %edi,%edx
  801bc5:	89 d1                	mov    %edx,%ecx
  801bc7:	89 c6                	mov    %eax,%esi
  801bc9:	e9 71 ff ff ff       	jmp    801b3f <__umoddi3+0xb3>
  801bce:	66 90                	xchg   %ax,%ax
  801bd0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801bd4:	72 ea                	jb     801bc0 <__umoddi3+0x134>
  801bd6:	89 d9                	mov    %ebx,%ecx
  801bd8:	e9 62 ff ff ff       	jmp    801b3f <__umoddi3+0xb3>
