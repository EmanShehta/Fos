
obj/user/fos_helloWorld:     file format elf32-i386


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
  800031:	e8 31 00 00 00       	call   800067 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// hello, world
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	extern unsigned char * etext;
	//cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D %d\n",4);		
	atomic_cprintf("HELLO WORLD , FOS IS SAYING HI :D:D:D \n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 c0 18 80 00       	push   $0x8018c0
  800046:	e8 39 02 00 00       	call   800284 <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	atomic_cprintf("end of code = %x\n",etext);
  80004e:	a1 bd 18 80 00       	mov    0x8018bd,%eax
  800053:	83 ec 08             	sub    $0x8,%esp
  800056:	50                   	push   %eax
  800057:	68 e8 18 80 00       	push   $0x8018e8
  80005c:	e8 23 02 00 00       	call   800284 <atomic_cprintf>
  800061:	83 c4 10             	add    $0x10,%esp
}
  800064:	90                   	nop
  800065:	c9                   	leave  
  800066:	c3                   	ret    

00800067 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800067:	55                   	push   %ebp
  800068:	89 e5                	mov    %esp,%ebp
  80006a:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80006d:	e8 10 10 00 00       	call   801082 <sys_getenvindex>
  800072:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800075:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800078:	89 d0                	mov    %edx,%eax
  80007a:	01 c0                	add    %eax,%eax
  80007c:	01 d0                	add    %edx,%eax
  80007e:	c1 e0 04             	shl    $0x4,%eax
  800081:	29 d0                	sub    %edx,%eax
  800083:	c1 e0 03             	shl    $0x3,%eax
  800086:	01 d0                	add    %edx,%eax
  800088:	c1 e0 02             	shl    $0x2,%eax
  80008b:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800090:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800095:	a1 20 20 80 00       	mov    0x802020,%eax
  80009a:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8000a0:	84 c0                	test   %al,%al
  8000a2:	74 0f                	je     8000b3 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8000a4:	a1 20 20 80 00       	mov    0x802020,%eax
  8000a9:	05 5c 05 00 00       	add    $0x55c,%eax
  8000ae:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000b3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000b7:	7e 0a                	jle    8000c3 <libmain+0x5c>
		binaryname = argv[0];
  8000b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000bc:	8b 00                	mov    (%eax),%eax
  8000be:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000c3:	83 ec 08             	sub    $0x8,%esp
  8000c6:	ff 75 0c             	pushl  0xc(%ebp)
  8000c9:	ff 75 08             	pushl  0x8(%ebp)
  8000cc:	e8 67 ff ff ff       	call   800038 <_main>
  8000d1:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000d4:	e8 44 11 00 00       	call   80121d <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	68 14 19 80 00       	push   $0x801914
  8000e1:	e8 71 01 00 00       	call   800257 <cprintf>
  8000e6:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000e9:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ee:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8000f4:	a1 20 20 80 00       	mov    0x802020,%eax
  8000f9:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	52                   	push   %edx
  800103:	50                   	push   %eax
  800104:	68 3c 19 80 00       	push   $0x80193c
  800109:	e8 49 01 00 00       	call   800257 <cprintf>
  80010e:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800111:	a1 20 20 80 00       	mov    0x802020,%eax
  800116:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80011c:	a1 20 20 80 00       	mov    0x802020,%eax
  800121:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800127:	a1 20 20 80 00       	mov    0x802020,%eax
  80012c:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800132:	51                   	push   %ecx
  800133:	52                   	push   %edx
  800134:	50                   	push   %eax
  800135:	68 64 19 80 00       	push   $0x801964
  80013a:	e8 18 01 00 00       	call   800257 <cprintf>
  80013f:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800142:	83 ec 0c             	sub    $0xc,%esp
  800145:	68 14 19 80 00       	push   $0x801914
  80014a:	e8 08 01 00 00       	call   800257 <cprintf>
  80014f:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800152:	e8 e0 10 00 00       	call   801237 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800157:	e8 19 00 00 00       	call   800175 <exit>
}
  80015c:	90                   	nop
  80015d:	c9                   	leave  
  80015e:	c3                   	ret    

0080015f <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80015f:	55                   	push   %ebp
  800160:	89 e5                	mov    %esp,%ebp
  800162:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800165:	83 ec 0c             	sub    $0xc,%esp
  800168:	6a 00                	push   $0x0
  80016a:	e8 df 0e 00 00       	call   80104e <sys_env_destroy>
  80016f:	83 c4 10             	add    $0x10,%esp
}
  800172:	90                   	nop
  800173:	c9                   	leave  
  800174:	c3                   	ret    

00800175 <exit>:

void
exit(void)
{
  800175:	55                   	push   %ebp
  800176:	89 e5                	mov    %esp,%ebp
  800178:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80017b:	e8 34 0f 00 00       	call   8010b4 <sys_env_exit>
}
  800180:	90                   	nop
  800181:	c9                   	leave  
  800182:	c3                   	ret    

00800183 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800183:	55                   	push   %ebp
  800184:	89 e5                	mov    %esp,%ebp
  800186:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800189:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018c:	8b 00                	mov    (%eax),%eax
  80018e:	8d 48 01             	lea    0x1(%eax),%ecx
  800191:	8b 55 0c             	mov    0xc(%ebp),%edx
  800194:	89 0a                	mov    %ecx,(%edx)
  800196:	8b 55 08             	mov    0x8(%ebp),%edx
  800199:	88 d1                	mov    %dl,%cl
  80019b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80019e:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001a5:	8b 00                	mov    (%eax),%eax
  8001a7:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001ac:	75 2c                	jne    8001da <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001ae:	a0 24 20 80 00       	mov    0x802024,%al
  8001b3:	0f b6 c0             	movzbl %al,%eax
  8001b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001b9:	8b 12                	mov    (%edx),%edx
  8001bb:	89 d1                	mov    %edx,%ecx
  8001bd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c0:	83 c2 08             	add    $0x8,%edx
  8001c3:	83 ec 04             	sub    $0x4,%esp
  8001c6:	50                   	push   %eax
  8001c7:	51                   	push   %ecx
  8001c8:	52                   	push   %edx
  8001c9:	e8 3e 0e 00 00       	call   80100c <sys_cputs>
  8001ce:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001dd:	8b 40 04             	mov    0x4(%eax),%eax
  8001e0:	8d 50 01             	lea    0x1(%eax),%edx
  8001e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e6:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001e9:	90                   	nop
  8001ea:	c9                   	leave  
  8001eb:	c3                   	ret    

008001ec <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001ec:	55                   	push   %ebp
  8001ed:	89 e5                	mov    %esp,%ebp
  8001ef:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001f5:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001fc:	00 00 00 
	b.cnt = 0;
  8001ff:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800206:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800209:	ff 75 0c             	pushl  0xc(%ebp)
  80020c:	ff 75 08             	pushl  0x8(%ebp)
  80020f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800215:	50                   	push   %eax
  800216:	68 83 01 80 00       	push   $0x800183
  80021b:	e8 11 02 00 00       	call   800431 <vprintfmt>
  800220:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800223:	a0 24 20 80 00       	mov    0x802024,%al
  800228:	0f b6 c0             	movzbl %al,%eax
  80022b:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800231:	83 ec 04             	sub    $0x4,%esp
  800234:	50                   	push   %eax
  800235:	52                   	push   %edx
  800236:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80023c:	83 c0 08             	add    $0x8,%eax
  80023f:	50                   	push   %eax
  800240:	e8 c7 0d 00 00       	call   80100c <sys_cputs>
  800245:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800248:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80024f:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800255:	c9                   	leave  
  800256:	c3                   	ret    

00800257 <cprintf>:

int cprintf(const char *fmt, ...) {
  800257:	55                   	push   %ebp
  800258:	89 e5                	mov    %esp,%ebp
  80025a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80025d:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800264:	8d 45 0c             	lea    0xc(%ebp),%eax
  800267:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80026a:	8b 45 08             	mov    0x8(%ebp),%eax
  80026d:	83 ec 08             	sub    $0x8,%esp
  800270:	ff 75 f4             	pushl  -0xc(%ebp)
  800273:	50                   	push   %eax
  800274:	e8 73 ff ff ff       	call   8001ec <vcprintf>
  800279:	83 c4 10             	add    $0x10,%esp
  80027c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80027f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800282:	c9                   	leave  
  800283:	c3                   	ret    

00800284 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800284:	55                   	push   %ebp
  800285:	89 e5                	mov    %esp,%ebp
  800287:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80028a:	e8 8e 0f 00 00       	call   80121d <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80028f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800292:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800295:	8b 45 08             	mov    0x8(%ebp),%eax
  800298:	83 ec 08             	sub    $0x8,%esp
  80029b:	ff 75 f4             	pushl  -0xc(%ebp)
  80029e:	50                   	push   %eax
  80029f:	e8 48 ff ff ff       	call   8001ec <vcprintf>
  8002a4:	83 c4 10             	add    $0x10,%esp
  8002a7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002aa:	e8 88 0f 00 00       	call   801237 <sys_enable_interrupt>
	return cnt;
  8002af:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002b2:	c9                   	leave  
  8002b3:	c3                   	ret    

008002b4 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002b4:	55                   	push   %ebp
  8002b5:	89 e5                	mov    %esp,%ebp
  8002b7:	53                   	push   %ebx
  8002b8:	83 ec 14             	sub    $0x14,%esp
  8002bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8002be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8002c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002c7:	8b 45 18             	mov    0x18(%ebp),%eax
  8002ca:	ba 00 00 00 00       	mov    $0x0,%edx
  8002cf:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002d2:	77 55                	ja     800329 <printnum+0x75>
  8002d4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002d7:	72 05                	jb     8002de <printnum+0x2a>
  8002d9:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002dc:	77 4b                	ja     800329 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002de:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002e1:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002e4:	8b 45 18             	mov    0x18(%ebp),%eax
  8002e7:	ba 00 00 00 00       	mov    $0x0,%edx
  8002ec:	52                   	push   %edx
  8002ed:	50                   	push   %eax
  8002ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f1:	ff 75 f0             	pushl  -0x10(%ebp)
  8002f4:	e8 63 13 00 00       	call   80165c <__udivdi3>
  8002f9:	83 c4 10             	add    $0x10,%esp
  8002fc:	83 ec 04             	sub    $0x4,%esp
  8002ff:	ff 75 20             	pushl  0x20(%ebp)
  800302:	53                   	push   %ebx
  800303:	ff 75 18             	pushl  0x18(%ebp)
  800306:	52                   	push   %edx
  800307:	50                   	push   %eax
  800308:	ff 75 0c             	pushl  0xc(%ebp)
  80030b:	ff 75 08             	pushl  0x8(%ebp)
  80030e:	e8 a1 ff ff ff       	call   8002b4 <printnum>
  800313:	83 c4 20             	add    $0x20,%esp
  800316:	eb 1a                	jmp    800332 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800318:	83 ec 08             	sub    $0x8,%esp
  80031b:	ff 75 0c             	pushl  0xc(%ebp)
  80031e:	ff 75 20             	pushl  0x20(%ebp)
  800321:	8b 45 08             	mov    0x8(%ebp),%eax
  800324:	ff d0                	call   *%eax
  800326:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800329:	ff 4d 1c             	decl   0x1c(%ebp)
  80032c:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800330:	7f e6                	jg     800318 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800332:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800335:	bb 00 00 00 00       	mov    $0x0,%ebx
  80033a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800340:	53                   	push   %ebx
  800341:	51                   	push   %ecx
  800342:	52                   	push   %edx
  800343:	50                   	push   %eax
  800344:	e8 23 14 00 00       	call   80176c <__umoddi3>
  800349:	83 c4 10             	add    $0x10,%esp
  80034c:	05 d4 1b 80 00       	add    $0x801bd4,%eax
  800351:	8a 00                	mov    (%eax),%al
  800353:	0f be c0             	movsbl %al,%eax
  800356:	83 ec 08             	sub    $0x8,%esp
  800359:	ff 75 0c             	pushl  0xc(%ebp)
  80035c:	50                   	push   %eax
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	ff d0                	call   *%eax
  800362:	83 c4 10             	add    $0x10,%esp
}
  800365:	90                   	nop
  800366:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800369:	c9                   	leave  
  80036a:	c3                   	ret    

0080036b <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80036b:	55                   	push   %ebp
  80036c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80036e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800372:	7e 1c                	jle    800390 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800374:	8b 45 08             	mov    0x8(%ebp),%eax
  800377:	8b 00                	mov    (%eax),%eax
  800379:	8d 50 08             	lea    0x8(%eax),%edx
  80037c:	8b 45 08             	mov    0x8(%ebp),%eax
  80037f:	89 10                	mov    %edx,(%eax)
  800381:	8b 45 08             	mov    0x8(%ebp),%eax
  800384:	8b 00                	mov    (%eax),%eax
  800386:	83 e8 08             	sub    $0x8,%eax
  800389:	8b 50 04             	mov    0x4(%eax),%edx
  80038c:	8b 00                	mov    (%eax),%eax
  80038e:	eb 40                	jmp    8003d0 <getuint+0x65>
	else if (lflag)
  800390:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800394:	74 1e                	je     8003b4 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	8b 00                	mov    (%eax),%eax
  80039b:	8d 50 04             	lea    0x4(%eax),%edx
  80039e:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a1:	89 10                	mov    %edx,(%eax)
  8003a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	83 e8 04             	sub    $0x4,%eax
  8003ab:	8b 00                	mov    (%eax),%eax
  8003ad:	ba 00 00 00 00       	mov    $0x0,%edx
  8003b2:	eb 1c                	jmp    8003d0 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b7:	8b 00                	mov    (%eax),%eax
  8003b9:	8d 50 04             	lea    0x4(%eax),%edx
  8003bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bf:	89 10                	mov    %edx,(%eax)
  8003c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c4:	8b 00                	mov    (%eax),%eax
  8003c6:	83 e8 04             	sub    $0x4,%eax
  8003c9:	8b 00                	mov    (%eax),%eax
  8003cb:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003d0:	5d                   	pop    %ebp
  8003d1:	c3                   	ret    

008003d2 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003d2:	55                   	push   %ebp
  8003d3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003d5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003d9:	7e 1c                	jle    8003f7 <getint+0x25>
		return va_arg(*ap, long long);
  8003db:	8b 45 08             	mov    0x8(%ebp),%eax
  8003de:	8b 00                	mov    (%eax),%eax
  8003e0:	8d 50 08             	lea    0x8(%eax),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	89 10                	mov    %edx,(%eax)
  8003e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003eb:	8b 00                	mov    (%eax),%eax
  8003ed:	83 e8 08             	sub    $0x8,%eax
  8003f0:	8b 50 04             	mov    0x4(%eax),%edx
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	eb 38                	jmp    80042f <getint+0x5d>
	else if (lflag)
  8003f7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003fb:	74 1a                	je     800417 <getint+0x45>
		return va_arg(*ap, long);
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	8b 00                	mov    (%eax),%eax
  800402:	8d 50 04             	lea    0x4(%eax),%edx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	89 10                	mov    %edx,(%eax)
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	83 e8 04             	sub    $0x4,%eax
  800412:	8b 00                	mov    (%eax),%eax
  800414:	99                   	cltd   
  800415:	eb 18                	jmp    80042f <getint+0x5d>
	else
		return va_arg(*ap, int);
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	8d 50 04             	lea    0x4(%eax),%edx
  80041f:	8b 45 08             	mov    0x8(%ebp),%eax
  800422:	89 10                	mov    %edx,(%eax)
  800424:	8b 45 08             	mov    0x8(%ebp),%eax
  800427:	8b 00                	mov    (%eax),%eax
  800429:	83 e8 04             	sub    $0x4,%eax
  80042c:	8b 00                	mov    (%eax),%eax
  80042e:	99                   	cltd   
}
  80042f:	5d                   	pop    %ebp
  800430:	c3                   	ret    

00800431 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800431:	55                   	push   %ebp
  800432:	89 e5                	mov    %esp,%ebp
  800434:	56                   	push   %esi
  800435:	53                   	push   %ebx
  800436:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800439:	eb 17                	jmp    800452 <vprintfmt+0x21>
			if (ch == '\0')
  80043b:	85 db                	test   %ebx,%ebx
  80043d:	0f 84 af 03 00 00    	je     8007f2 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800443:	83 ec 08             	sub    $0x8,%esp
  800446:	ff 75 0c             	pushl  0xc(%ebp)
  800449:	53                   	push   %ebx
  80044a:	8b 45 08             	mov    0x8(%ebp),%eax
  80044d:	ff d0                	call   *%eax
  80044f:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800452:	8b 45 10             	mov    0x10(%ebp),%eax
  800455:	8d 50 01             	lea    0x1(%eax),%edx
  800458:	89 55 10             	mov    %edx,0x10(%ebp)
  80045b:	8a 00                	mov    (%eax),%al
  80045d:	0f b6 d8             	movzbl %al,%ebx
  800460:	83 fb 25             	cmp    $0x25,%ebx
  800463:	75 d6                	jne    80043b <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800465:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800469:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800470:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800477:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80047e:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800485:	8b 45 10             	mov    0x10(%ebp),%eax
  800488:	8d 50 01             	lea    0x1(%eax),%edx
  80048b:	89 55 10             	mov    %edx,0x10(%ebp)
  80048e:	8a 00                	mov    (%eax),%al
  800490:	0f b6 d8             	movzbl %al,%ebx
  800493:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800496:	83 f8 55             	cmp    $0x55,%eax
  800499:	0f 87 2b 03 00 00    	ja     8007ca <vprintfmt+0x399>
  80049f:	8b 04 85 f8 1b 80 00 	mov    0x801bf8(,%eax,4),%eax
  8004a6:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004a8:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004ac:	eb d7                	jmp    800485 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004ae:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004b2:	eb d1                	jmp    800485 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004b4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004bb:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004be:	89 d0                	mov    %edx,%eax
  8004c0:	c1 e0 02             	shl    $0x2,%eax
  8004c3:	01 d0                	add    %edx,%eax
  8004c5:	01 c0                	add    %eax,%eax
  8004c7:	01 d8                	add    %ebx,%eax
  8004c9:	83 e8 30             	sub    $0x30,%eax
  8004cc:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d2:	8a 00                	mov    (%eax),%al
  8004d4:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004d7:	83 fb 2f             	cmp    $0x2f,%ebx
  8004da:	7e 3e                	jle    80051a <vprintfmt+0xe9>
  8004dc:	83 fb 39             	cmp    $0x39,%ebx
  8004df:	7f 39                	jg     80051a <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004e1:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004e4:	eb d5                	jmp    8004bb <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004e6:	8b 45 14             	mov    0x14(%ebp),%eax
  8004e9:	83 c0 04             	add    $0x4,%eax
  8004ec:	89 45 14             	mov    %eax,0x14(%ebp)
  8004ef:	8b 45 14             	mov    0x14(%ebp),%eax
  8004f2:	83 e8 04             	sub    $0x4,%eax
  8004f5:	8b 00                	mov    (%eax),%eax
  8004f7:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004fa:	eb 1f                	jmp    80051b <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004fc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800500:	79 83                	jns    800485 <vprintfmt+0x54>
				width = 0;
  800502:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800509:	e9 77 ff ff ff       	jmp    800485 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80050e:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800515:	e9 6b ff ff ff       	jmp    800485 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80051a:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80051b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80051f:	0f 89 60 ff ff ff    	jns    800485 <vprintfmt+0x54>
				width = precision, precision = -1;
  800525:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800528:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80052b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800532:	e9 4e ff ff ff       	jmp    800485 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800537:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80053a:	e9 46 ff ff ff       	jmp    800485 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80053f:	8b 45 14             	mov    0x14(%ebp),%eax
  800542:	83 c0 04             	add    $0x4,%eax
  800545:	89 45 14             	mov    %eax,0x14(%ebp)
  800548:	8b 45 14             	mov    0x14(%ebp),%eax
  80054b:	83 e8 04             	sub    $0x4,%eax
  80054e:	8b 00                	mov    (%eax),%eax
  800550:	83 ec 08             	sub    $0x8,%esp
  800553:	ff 75 0c             	pushl  0xc(%ebp)
  800556:	50                   	push   %eax
  800557:	8b 45 08             	mov    0x8(%ebp),%eax
  80055a:	ff d0                	call   *%eax
  80055c:	83 c4 10             	add    $0x10,%esp
			break;
  80055f:	e9 89 02 00 00       	jmp    8007ed <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800564:	8b 45 14             	mov    0x14(%ebp),%eax
  800567:	83 c0 04             	add    $0x4,%eax
  80056a:	89 45 14             	mov    %eax,0x14(%ebp)
  80056d:	8b 45 14             	mov    0x14(%ebp),%eax
  800570:	83 e8 04             	sub    $0x4,%eax
  800573:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800575:	85 db                	test   %ebx,%ebx
  800577:	79 02                	jns    80057b <vprintfmt+0x14a>
				err = -err;
  800579:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80057b:	83 fb 64             	cmp    $0x64,%ebx
  80057e:	7f 0b                	jg     80058b <vprintfmt+0x15a>
  800580:	8b 34 9d 40 1a 80 00 	mov    0x801a40(,%ebx,4),%esi
  800587:	85 f6                	test   %esi,%esi
  800589:	75 19                	jne    8005a4 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80058b:	53                   	push   %ebx
  80058c:	68 e5 1b 80 00       	push   $0x801be5
  800591:	ff 75 0c             	pushl  0xc(%ebp)
  800594:	ff 75 08             	pushl  0x8(%ebp)
  800597:	e8 5e 02 00 00       	call   8007fa <printfmt>
  80059c:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80059f:	e9 49 02 00 00       	jmp    8007ed <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005a4:	56                   	push   %esi
  8005a5:	68 ee 1b 80 00       	push   $0x801bee
  8005aa:	ff 75 0c             	pushl  0xc(%ebp)
  8005ad:	ff 75 08             	pushl  0x8(%ebp)
  8005b0:	e8 45 02 00 00       	call   8007fa <printfmt>
  8005b5:	83 c4 10             	add    $0x10,%esp
			break;
  8005b8:	e9 30 02 00 00       	jmp    8007ed <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c0:	83 c0 04             	add    $0x4,%eax
  8005c3:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c9:	83 e8 04             	sub    $0x4,%eax
  8005cc:	8b 30                	mov    (%eax),%esi
  8005ce:	85 f6                	test   %esi,%esi
  8005d0:	75 05                	jne    8005d7 <vprintfmt+0x1a6>
				p = "(null)";
  8005d2:	be f1 1b 80 00       	mov    $0x801bf1,%esi
			if (width > 0 && padc != '-')
  8005d7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005db:	7e 6d                	jle    80064a <vprintfmt+0x219>
  8005dd:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005e1:	74 67                	je     80064a <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005e3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005e6:	83 ec 08             	sub    $0x8,%esp
  8005e9:	50                   	push   %eax
  8005ea:	56                   	push   %esi
  8005eb:	e8 0c 03 00 00       	call   8008fc <strnlen>
  8005f0:	83 c4 10             	add    $0x10,%esp
  8005f3:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005f6:	eb 16                	jmp    80060e <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005f8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005fc:	83 ec 08             	sub    $0x8,%esp
  8005ff:	ff 75 0c             	pushl  0xc(%ebp)
  800602:	50                   	push   %eax
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	ff d0                	call   *%eax
  800608:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80060b:	ff 4d e4             	decl   -0x1c(%ebp)
  80060e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800612:	7f e4                	jg     8005f8 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800614:	eb 34                	jmp    80064a <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800616:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80061a:	74 1c                	je     800638 <vprintfmt+0x207>
  80061c:	83 fb 1f             	cmp    $0x1f,%ebx
  80061f:	7e 05                	jle    800626 <vprintfmt+0x1f5>
  800621:	83 fb 7e             	cmp    $0x7e,%ebx
  800624:	7e 12                	jle    800638 <vprintfmt+0x207>
					putch('?', putdat);
  800626:	83 ec 08             	sub    $0x8,%esp
  800629:	ff 75 0c             	pushl  0xc(%ebp)
  80062c:	6a 3f                	push   $0x3f
  80062e:	8b 45 08             	mov    0x8(%ebp),%eax
  800631:	ff d0                	call   *%eax
  800633:	83 c4 10             	add    $0x10,%esp
  800636:	eb 0f                	jmp    800647 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800638:	83 ec 08             	sub    $0x8,%esp
  80063b:	ff 75 0c             	pushl  0xc(%ebp)
  80063e:	53                   	push   %ebx
  80063f:	8b 45 08             	mov    0x8(%ebp),%eax
  800642:	ff d0                	call   *%eax
  800644:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800647:	ff 4d e4             	decl   -0x1c(%ebp)
  80064a:	89 f0                	mov    %esi,%eax
  80064c:	8d 70 01             	lea    0x1(%eax),%esi
  80064f:	8a 00                	mov    (%eax),%al
  800651:	0f be d8             	movsbl %al,%ebx
  800654:	85 db                	test   %ebx,%ebx
  800656:	74 24                	je     80067c <vprintfmt+0x24b>
  800658:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80065c:	78 b8                	js     800616 <vprintfmt+0x1e5>
  80065e:	ff 4d e0             	decl   -0x20(%ebp)
  800661:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800665:	79 af                	jns    800616 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800667:	eb 13                	jmp    80067c <vprintfmt+0x24b>
				putch(' ', putdat);
  800669:	83 ec 08             	sub    $0x8,%esp
  80066c:	ff 75 0c             	pushl  0xc(%ebp)
  80066f:	6a 20                	push   $0x20
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	ff d0                	call   *%eax
  800676:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800679:	ff 4d e4             	decl   -0x1c(%ebp)
  80067c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800680:	7f e7                	jg     800669 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800682:	e9 66 01 00 00       	jmp    8007ed <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800687:	83 ec 08             	sub    $0x8,%esp
  80068a:	ff 75 e8             	pushl  -0x18(%ebp)
  80068d:	8d 45 14             	lea    0x14(%ebp),%eax
  800690:	50                   	push   %eax
  800691:	e8 3c fd ff ff       	call   8003d2 <getint>
  800696:	83 c4 10             	add    $0x10,%esp
  800699:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80069c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80069f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006a5:	85 d2                	test   %edx,%edx
  8006a7:	79 23                	jns    8006cc <vprintfmt+0x29b>
				putch('-', putdat);
  8006a9:	83 ec 08             	sub    $0x8,%esp
  8006ac:	ff 75 0c             	pushl  0xc(%ebp)
  8006af:	6a 2d                	push   $0x2d
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	ff d0                	call   *%eax
  8006b6:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006b9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006bc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006bf:	f7 d8                	neg    %eax
  8006c1:	83 d2 00             	adc    $0x0,%edx
  8006c4:	f7 da                	neg    %edx
  8006c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006cc:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006d3:	e9 bc 00 00 00       	jmp    800794 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006d8:	83 ec 08             	sub    $0x8,%esp
  8006db:	ff 75 e8             	pushl  -0x18(%ebp)
  8006de:	8d 45 14             	lea    0x14(%ebp),%eax
  8006e1:	50                   	push   %eax
  8006e2:	e8 84 fc ff ff       	call   80036b <getuint>
  8006e7:	83 c4 10             	add    $0x10,%esp
  8006ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006ed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006f0:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006f7:	e9 98 00 00 00       	jmp    800794 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006fc:	83 ec 08             	sub    $0x8,%esp
  8006ff:	ff 75 0c             	pushl  0xc(%ebp)
  800702:	6a 58                	push   $0x58
  800704:	8b 45 08             	mov    0x8(%ebp),%eax
  800707:	ff d0                	call   *%eax
  800709:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80070c:	83 ec 08             	sub    $0x8,%esp
  80070f:	ff 75 0c             	pushl  0xc(%ebp)
  800712:	6a 58                	push   $0x58
  800714:	8b 45 08             	mov    0x8(%ebp),%eax
  800717:	ff d0                	call   *%eax
  800719:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80071c:	83 ec 08             	sub    $0x8,%esp
  80071f:	ff 75 0c             	pushl  0xc(%ebp)
  800722:	6a 58                	push   $0x58
  800724:	8b 45 08             	mov    0x8(%ebp),%eax
  800727:	ff d0                	call   *%eax
  800729:	83 c4 10             	add    $0x10,%esp
			break;
  80072c:	e9 bc 00 00 00       	jmp    8007ed <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 0c             	pushl  0xc(%ebp)
  800737:	6a 30                	push   $0x30
  800739:	8b 45 08             	mov    0x8(%ebp),%eax
  80073c:	ff d0                	call   *%eax
  80073e:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800741:	83 ec 08             	sub    $0x8,%esp
  800744:	ff 75 0c             	pushl  0xc(%ebp)
  800747:	6a 78                	push   $0x78
  800749:	8b 45 08             	mov    0x8(%ebp),%eax
  80074c:	ff d0                	call   *%eax
  80074e:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800751:	8b 45 14             	mov    0x14(%ebp),%eax
  800754:	83 c0 04             	add    $0x4,%eax
  800757:	89 45 14             	mov    %eax,0x14(%ebp)
  80075a:	8b 45 14             	mov    0x14(%ebp),%eax
  80075d:	83 e8 04             	sub    $0x4,%eax
  800760:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800762:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800765:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80076c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800773:	eb 1f                	jmp    800794 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800775:	83 ec 08             	sub    $0x8,%esp
  800778:	ff 75 e8             	pushl  -0x18(%ebp)
  80077b:	8d 45 14             	lea    0x14(%ebp),%eax
  80077e:	50                   	push   %eax
  80077f:	e8 e7 fb ff ff       	call   80036b <getuint>
  800784:	83 c4 10             	add    $0x10,%esp
  800787:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80078a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80078d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800794:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800798:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80079b:	83 ec 04             	sub    $0x4,%esp
  80079e:	52                   	push   %edx
  80079f:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007a2:	50                   	push   %eax
  8007a3:	ff 75 f4             	pushl  -0xc(%ebp)
  8007a6:	ff 75 f0             	pushl  -0x10(%ebp)
  8007a9:	ff 75 0c             	pushl  0xc(%ebp)
  8007ac:	ff 75 08             	pushl  0x8(%ebp)
  8007af:	e8 00 fb ff ff       	call   8002b4 <printnum>
  8007b4:	83 c4 20             	add    $0x20,%esp
			break;
  8007b7:	eb 34                	jmp    8007ed <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007b9:	83 ec 08             	sub    $0x8,%esp
  8007bc:	ff 75 0c             	pushl  0xc(%ebp)
  8007bf:	53                   	push   %ebx
  8007c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c3:	ff d0                	call   *%eax
  8007c5:	83 c4 10             	add    $0x10,%esp
			break;
  8007c8:	eb 23                	jmp    8007ed <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007ca:	83 ec 08             	sub    $0x8,%esp
  8007cd:	ff 75 0c             	pushl  0xc(%ebp)
  8007d0:	6a 25                	push   $0x25
  8007d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d5:	ff d0                	call   *%eax
  8007d7:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007da:	ff 4d 10             	decl   0x10(%ebp)
  8007dd:	eb 03                	jmp    8007e2 <vprintfmt+0x3b1>
  8007df:	ff 4d 10             	decl   0x10(%ebp)
  8007e2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007e5:	48                   	dec    %eax
  8007e6:	8a 00                	mov    (%eax),%al
  8007e8:	3c 25                	cmp    $0x25,%al
  8007ea:	75 f3                	jne    8007df <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007ec:	90                   	nop
		}
	}
  8007ed:	e9 47 fc ff ff       	jmp    800439 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007f2:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007f3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007f6:	5b                   	pop    %ebx
  8007f7:	5e                   	pop    %esi
  8007f8:	5d                   	pop    %ebp
  8007f9:	c3                   	ret    

008007fa <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007fa:	55                   	push   %ebp
  8007fb:	89 e5                	mov    %esp,%ebp
  8007fd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800800:	8d 45 10             	lea    0x10(%ebp),%eax
  800803:	83 c0 04             	add    $0x4,%eax
  800806:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800809:	8b 45 10             	mov    0x10(%ebp),%eax
  80080c:	ff 75 f4             	pushl  -0xc(%ebp)
  80080f:	50                   	push   %eax
  800810:	ff 75 0c             	pushl  0xc(%ebp)
  800813:	ff 75 08             	pushl  0x8(%ebp)
  800816:	e8 16 fc ff ff       	call   800431 <vprintfmt>
  80081b:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80081e:	90                   	nop
  80081f:	c9                   	leave  
  800820:	c3                   	ret    

00800821 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800821:	55                   	push   %ebp
  800822:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800824:	8b 45 0c             	mov    0xc(%ebp),%eax
  800827:	8b 40 08             	mov    0x8(%eax),%eax
  80082a:	8d 50 01             	lea    0x1(%eax),%edx
  80082d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800830:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800833:	8b 45 0c             	mov    0xc(%ebp),%eax
  800836:	8b 10                	mov    (%eax),%edx
  800838:	8b 45 0c             	mov    0xc(%ebp),%eax
  80083b:	8b 40 04             	mov    0x4(%eax),%eax
  80083e:	39 c2                	cmp    %eax,%edx
  800840:	73 12                	jae    800854 <sprintputch+0x33>
		*b->buf++ = ch;
  800842:	8b 45 0c             	mov    0xc(%ebp),%eax
  800845:	8b 00                	mov    (%eax),%eax
  800847:	8d 48 01             	lea    0x1(%eax),%ecx
  80084a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80084d:	89 0a                	mov    %ecx,(%edx)
  80084f:	8b 55 08             	mov    0x8(%ebp),%edx
  800852:	88 10                	mov    %dl,(%eax)
}
  800854:	90                   	nop
  800855:	5d                   	pop    %ebp
  800856:	c3                   	ret    

00800857 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800857:	55                   	push   %ebp
  800858:	89 e5                	mov    %esp,%ebp
  80085a:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80085d:	8b 45 08             	mov    0x8(%ebp),%eax
  800860:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800863:	8b 45 0c             	mov    0xc(%ebp),%eax
  800866:	8d 50 ff             	lea    -0x1(%eax),%edx
  800869:	8b 45 08             	mov    0x8(%ebp),%eax
  80086c:	01 d0                	add    %edx,%eax
  80086e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800871:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800878:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80087c:	74 06                	je     800884 <vsnprintf+0x2d>
  80087e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800882:	7f 07                	jg     80088b <vsnprintf+0x34>
		return -E_INVAL;
  800884:	b8 03 00 00 00       	mov    $0x3,%eax
  800889:	eb 20                	jmp    8008ab <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80088b:	ff 75 14             	pushl  0x14(%ebp)
  80088e:	ff 75 10             	pushl  0x10(%ebp)
  800891:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800894:	50                   	push   %eax
  800895:	68 21 08 80 00       	push   $0x800821
  80089a:	e8 92 fb ff ff       	call   800431 <vprintfmt>
  80089f:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008a5:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008ab:	c9                   	leave  
  8008ac:	c3                   	ret    

008008ad <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008ad:	55                   	push   %ebp
  8008ae:	89 e5                	mov    %esp,%ebp
  8008b0:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008b3:	8d 45 10             	lea    0x10(%ebp),%eax
  8008b6:	83 c0 04             	add    $0x4,%eax
  8008b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8008bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8008c2:	50                   	push   %eax
  8008c3:	ff 75 0c             	pushl  0xc(%ebp)
  8008c6:	ff 75 08             	pushl  0x8(%ebp)
  8008c9:	e8 89 ff ff ff       	call   800857 <vsnprintf>
  8008ce:	83 c4 10             	add    $0x10,%esp
  8008d1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008d7:	c9                   	leave  
  8008d8:	c3                   	ret    

008008d9 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008d9:	55                   	push   %ebp
  8008da:	89 e5                	mov    %esp,%ebp
  8008dc:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008df:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008e6:	eb 06                	jmp    8008ee <strlen+0x15>
		n++;
  8008e8:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008eb:	ff 45 08             	incl   0x8(%ebp)
  8008ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f1:	8a 00                	mov    (%eax),%al
  8008f3:	84 c0                	test   %al,%al
  8008f5:	75 f1                	jne    8008e8 <strlen+0xf>
		n++;
	return n;
  8008f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008fa:	c9                   	leave  
  8008fb:	c3                   	ret    

008008fc <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008fc:	55                   	push   %ebp
  8008fd:	89 e5                	mov    %esp,%ebp
  8008ff:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800902:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800909:	eb 09                	jmp    800914 <strnlen+0x18>
		n++;
  80090b:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80090e:	ff 45 08             	incl   0x8(%ebp)
  800911:	ff 4d 0c             	decl   0xc(%ebp)
  800914:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800918:	74 09                	je     800923 <strnlen+0x27>
  80091a:	8b 45 08             	mov    0x8(%ebp),%eax
  80091d:	8a 00                	mov    (%eax),%al
  80091f:	84 c0                	test   %al,%al
  800921:	75 e8                	jne    80090b <strnlen+0xf>
		n++;
	return n;
  800923:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800926:	c9                   	leave  
  800927:	c3                   	ret    

00800928 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800928:	55                   	push   %ebp
  800929:	89 e5                	mov    %esp,%ebp
  80092b:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800934:	90                   	nop
  800935:	8b 45 08             	mov    0x8(%ebp),%eax
  800938:	8d 50 01             	lea    0x1(%eax),%edx
  80093b:	89 55 08             	mov    %edx,0x8(%ebp)
  80093e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800941:	8d 4a 01             	lea    0x1(%edx),%ecx
  800944:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800947:	8a 12                	mov    (%edx),%dl
  800949:	88 10                	mov    %dl,(%eax)
  80094b:	8a 00                	mov    (%eax),%al
  80094d:	84 c0                	test   %al,%al
  80094f:	75 e4                	jne    800935 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800951:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800954:	c9                   	leave  
  800955:	c3                   	ret    

00800956 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800956:	55                   	push   %ebp
  800957:	89 e5                	mov    %esp,%ebp
  800959:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80095c:	8b 45 08             	mov    0x8(%ebp),%eax
  80095f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800962:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800969:	eb 1f                	jmp    80098a <strncpy+0x34>
		*dst++ = *src;
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	8d 50 01             	lea    0x1(%eax),%edx
  800971:	89 55 08             	mov    %edx,0x8(%ebp)
  800974:	8b 55 0c             	mov    0xc(%ebp),%edx
  800977:	8a 12                	mov    (%edx),%dl
  800979:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80097b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80097e:	8a 00                	mov    (%eax),%al
  800980:	84 c0                	test   %al,%al
  800982:	74 03                	je     800987 <strncpy+0x31>
			src++;
  800984:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800987:	ff 45 fc             	incl   -0x4(%ebp)
  80098a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80098d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800990:	72 d9                	jb     80096b <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800992:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800995:	c9                   	leave  
  800996:	c3                   	ret    

00800997 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800997:	55                   	push   %ebp
  800998:	89 e5                	mov    %esp,%ebp
  80099a:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80099d:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009a7:	74 30                	je     8009d9 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009a9:	eb 16                	jmp    8009c1 <strlcpy+0x2a>
			*dst++ = *src++;
  8009ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ae:	8d 50 01             	lea    0x1(%eax),%edx
  8009b1:	89 55 08             	mov    %edx,0x8(%ebp)
  8009b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009ba:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009bd:	8a 12                	mov    (%edx),%dl
  8009bf:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009c1:	ff 4d 10             	decl   0x10(%ebp)
  8009c4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009c8:	74 09                	je     8009d3 <strlcpy+0x3c>
  8009ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009cd:	8a 00                	mov    (%eax),%al
  8009cf:	84 c0                	test   %al,%al
  8009d1:	75 d8                	jne    8009ab <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d6:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009d9:	8b 55 08             	mov    0x8(%ebp),%edx
  8009dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009df:	29 c2                	sub    %eax,%edx
  8009e1:	89 d0                	mov    %edx,%eax
}
  8009e3:	c9                   	leave  
  8009e4:	c3                   	ret    

008009e5 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009e5:	55                   	push   %ebp
  8009e6:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009e8:	eb 06                	jmp    8009f0 <strcmp+0xb>
		p++, q++;
  8009ea:	ff 45 08             	incl   0x8(%ebp)
  8009ed:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f3:	8a 00                	mov    (%eax),%al
  8009f5:	84 c0                	test   %al,%al
  8009f7:	74 0e                	je     800a07 <strcmp+0x22>
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	8a 10                	mov    (%eax),%dl
  8009fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a01:	8a 00                	mov    (%eax),%al
  800a03:	38 c2                	cmp    %al,%dl
  800a05:	74 e3                	je     8009ea <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	8a 00                	mov    (%eax),%al
  800a0c:	0f b6 d0             	movzbl %al,%edx
  800a0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a12:	8a 00                	mov    (%eax),%al
  800a14:	0f b6 c0             	movzbl %al,%eax
  800a17:	29 c2                	sub    %eax,%edx
  800a19:	89 d0                	mov    %edx,%eax
}
  800a1b:	5d                   	pop    %ebp
  800a1c:	c3                   	ret    

00800a1d <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a1d:	55                   	push   %ebp
  800a1e:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a20:	eb 09                	jmp    800a2b <strncmp+0xe>
		n--, p++, q++;
  800a22:	ff 4d 10             	decl   0x10(%ebp)
  800a25:	ff 45 08             	incl   0x8(%ebp)
  800a28:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a2f:	74 17                	je     800a48 <strncmp+0x2b>
  800a31:	8b 45 08             	mov    0x8(%ebp),%eax
  800a34:	8a 00                	mov    (%eax),%al
  800a36:	84 c0                	test   %al,%al
  800a38:	74 0e                	je     800a48 <strncmp+0x2b>
  800a3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3d:	8a 10                	mov    (%eax),%dl
  800a3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a42:	8a 00                	mov    (%eax),%al
  800a44:	38 c2                	cmp    %al,%dl
  800a46:	74 da                	je     800a22 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a4c:	75 07                	jne    800a55 <strncmp+0x38>
		return 0;
  800a4e:	b8 00 00 00 00       	mov    $0x0,%eax
  800a53:	eb 14                	jmp    800a69 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	8a 00                	mov    (%eax),%al
  800a5a:	0f b6 d0             	movzbl %al,%edx
  800a5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a60:	8a 00                	mov    (%eax),%al
  800a62:	0f b6 c0             	movzbl %al,%eax
  800a65:	29 c2                	sub    %eax,%edx
  800a67:	89 d0                	mov    %edx,%eax
}
  800a69:	5d                   	pop    %ebp
  800a6a:	c3                   	ret    

00800a6b <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a6b:	55                   	push   %ebp
  800a6c:	89 e5                	mov    %esp,%ebp
  800a6e:	83 ec 04             	sub    $0x4,%esp
  800a71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a74:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a77:	eb 12                	jmp    800a8b <strchr+0x20>
		if (*s == c)
  800a79:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7c:	8a 00                	mov    (%eax),%al
  800a7e:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a81:	75 05                	jne    800a88 <strchr+0x1d>
			return (char *) s;
  800a83:	8b 45 08             	mov    0x8(%ebp),%eax
  800a86:	eb 11                	jmp    800a99 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a88:	ff 45 08             	incl   0x8(%ebp)
  800a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8e:	8a 00                	mov    (%eax),%al
  800a90:	84 c0                	test   %al,%al
  800a92:	75 e5                	jne    800a79 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a94:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a99:	c9                   	leave  
  800a9a:	c3                   	ret    

00800a9b <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a9b:	55                   	push   %ebp
  800a9c:	89 e5                	mov    %esp,%ebp
  800a9e:	83 ec 04             	sub    $0x4,%esp
  800aa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa4:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aa7:	eb 0d                	jmp    800ab6 <strfind+0x1b>
		if (*s == c)
  800aa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800aac:	8a 00                	mov    (%eax),%al
  800aae:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ab1:	74 0e                	je     800ac1 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ab3:	ff 45 08             	incl   0x8(%ebp)
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	8a 00                	mov    (%eax),%al
  800abb:	84 c0                	test   %al,%al
  800abd:	75 ea                	jne    800aa9 <strfind+0xe>
  800abf:	eb 01                	jmp    800ac2 <strfind+0x27>
		if (*s == c)
			break;
  800ac1:	90                   	nop
	return (char *) s;
  800ac2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ac5:	c9                   	leave  
  800ac6:	c3                   	ret    

00800ac7 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ac7:	55                   	push   %ebp
  800ac8:	89 e5                	mov    %esp,%ebp
  800aca:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800acd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ad3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ad6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ad9:	eb 0e                	jmp    800ae9 <memset+0x22>
		*p++ = c;
  800adb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ade:	8d 50 01             	lea    0x1(%eax),%edx
  800ae1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ae4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae7:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ae9:	ff 4d f8             	decl   -0x8(%ebp)
  800aec:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800af0:	79 e9                	jns    800adb <memset+0x14>
		*p++ = c;

	return v;
  800af2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800af5:	c9                   	leave  
  800af6:	c3                   	ret    

00800af7 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800af7:	55                   	push   %ebp
  800af8:	89 e5                	mov    %esp,%ebp
  800afa:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800afd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b03:	8b 45 08             	mov    0x8(%ebp),%eax
  800b06:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b09:	eb 16                	jmp    800b21 <memcpy+0x2a>
		*d++ = *s++;
  800b0b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b0e:	8d 50 01             	lea    0x1(%eax),%edx
  800b11:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b14:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b17:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b1a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b1d:	8a 12                	mov    (%edx),%dl
  800b1f:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b21:	8b 45 10             	mov    0x10(%ebp),%eax
  800b24:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b27:	89 55 10             	mov    %edx,0x10(%ebp)
  800b2a:	85 c0                	test   %eax,%eax
  800b2c:	75 dd                	jne    800b0b <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b2e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b31:	c9                   	leave  
  800b32:	c3                   	ret    

00800b33 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b33:	55                   	push   %ebp
  800b34:	89 e5                	mov    %esp,%ebp
  800b36:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b3c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b45:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b48:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b4b:	73 50                	jae    800b9d <memmove+0x6a>
  800b4d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b50:	8b 45 10             	mov    0x10(%ebp),%eax
  800b53:	01 d0                	add    %edx,%eax
  800b55:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b58:	76 43                	jbe    800b9d <memmove+0x6a>
		s += n;
  800b5a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b5d:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b60:	8b 45 10             	mov    0x10(%ebp),%eax
  800b63:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b66:	eb 10                	jmp    800b78 <memmove+0x45>
			*--d = *--s;
  800b68:	ff 4d f8             	decl   -0x8(%ebp)
  800b6b:	ff 4d fc             	decl   -0x4(%ebp)
  800b6e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b71:	8a 10                	mov    (%eax),%dl
  800b73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b76:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b78:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7b:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b7e:	89 55 10             	mov    %edx,0x10(%ebp)
  800b81:	85 c0                	test   %eax,%eax
  800b83:	75 e3                	jne    800b68 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b85:	eb 23                	jmp    800baa <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b87:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b8a:	8d 50 01             	lea    0x1(%eax),%edx
  800b8d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b90:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b93:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b96:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b99:	8a 12                	mov    (%edx),%dl
  800b9b:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba3:	89 55 10             	mov    %edx,0x10(%ebp)
  800ba6:	85 c0                	test   %eax,%eax
  800ba8:	75 dd                	jne    800b87 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bad:	c9                   	leave  
  800bae:	c3                   	ret    

00800baf <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800baf:	55                   	push   %ebp
  800bb0:	89 e5                	mov    %esp,%ebp
  800bb2:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbe:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bc1:	eb 2a                	jmp    800bed <memcmp+0x3e>
		if (*s1 != *s2)
  800bc3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc6:	8a 10                	mov    (%eax),%dl
  800bc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bcb:	8a 00                	mov    (%eax),%al
  800bcd:	38 c2                	cmp    %al,%dl
  800bcf:	74 16                	je     800be7 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bd1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bd4:	8a 00                	mov    (%eax),%al
  800bd6:	0f b6 d0             	movzbl %al,%edx
  800bd9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bdc:	8a 00                	mov    (%eax),%al
  800bde:	0f b6 c0             	movzbl %al,%eax
  800be1:	29 c2                	sub    %eax,%edx
  800be3:	89 d0                	mov    %edx,%eax
  800be5:	eb 18                	jmp    800bff <memcmp+0x50>
		s1++, s2++;
  800be7:	ff 45 fc             	incl   -0x4(%ebp)
  800bea:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bed:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf3:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf6:	85 c0                	test   %eax,%eax
  800bf8:	75 c9                	jne    800bc3 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800bfa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bff:	c9                   	leave  
  800c00:	c3                   	ret    

00800c01 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c01:	55                   	push   %ebp
  800c02:	89 e5                	mov    %esp,%ebp
  800c04:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c07:	8b 55 08             	mov    0x8(%ebp),%edx
  800c0a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c0d:	01 d0                	add    %edx,%eax
  800c0f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c12:	eb 15                	jmp    800c29 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
  800c17:	8a 00                	mov    (%eax),%al
  800c19:	0f b6 d0             	movzbl %al,%edx
  800c1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1f:	0f b6 c0             	movzbl %al,%eax
  800c22:	39 c2                	cmp    %eax,%edx
  800c24:	74 0d                	je     800c33 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c26:	ff 45 08             	incl   0x8(%ebp)
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c2f:	72 e3                	jb     800c14 <memfind+0x13>
  800c31:	eb 01                	jmp    800c34 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c33:	90                   	nop
	return (void *) s;
  800c34:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c37:	c9                   	leave  
  800c38:	c3                   	ret    

00800c39 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c39:	55                   	push   %ebp
  800c3a:	89 e5                	mov    %esp,%ebp
  800c3c:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c3f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c46:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c4d:	eb 03                	jmp    800c52 <strtol+0x19>
		s++;
  800c4f:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c52:	8b 45 08             	mov    0x8(%ebp),%eax
  800c55:	8a 00                	mov    (%eax),%al
  800c57:	3c 20                	cmp    $0x20,%al
  800c59:	74 f4                	je     800c4f <strtol+0x16>
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	8a 00                	mov    (%eax),%al
  800c60:	3c 09                	cmp    $0x9,%al
  800c62:	74 eb                	je     800c4f <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	8a 00                	mov    (%eax),%al
  800c69:	3c 2b                	cmp    $0x2b,%al
  800c6b:	75 05                	jne    800c72 <strtol+0x39>
		s++;
  800c6d:	ff 45 08             	incl   0x8(%ebp)
  800c70:	eb 13                	jmp    800c85 <strtol+0x4c>
	else if (*s == '-')
  800c72:	8b 45 08             	mov    0x8(%ebp),%eax
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	3c 2d                	cmp    $0x2d,%al
  800c79:	75 0a                	jne    800c85 <strtol+0x4c>
		s++, neg = 1;
  800c7b:	ff 45 08             	incl   0x8(%ebp)
  800c7e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c85:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c89:	74 06                	je     800c91 <strtol+0x58>
  800c8b:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c8f:	75 20                	jne    800cb1 <strtol+0x78>
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8a 00                	mov    (%eax),%al
  800c96:	3c 30                	cmp    $0x30,%al
  800c98:	75 17                	jne    800cb1 <strtol+0x78>
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	40                   	inc    %eax
  800c9e:	8a 00                	mov    (%eax),%al
  800ca0:	3c 78                	cmp    $0x78,%al
  800ca2:	75 0d                	jne    800cb1 <strtol+0x78>
		s += 2, base = 16;
  800ca4:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800ca8:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800caf:	eb 28                	jmp    800cd9 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cb1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb5:	75 15                	jne    800ccc <strtol+0x93>
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	3c 30                	cmp    $0x30,%al
  800cbe:	75 0c                	jne    800ccc <strtol+0x93>
		s++, base = 8;
  800cc0:	ff 45 08             	incl   0x8(%ebp)
  800cc3:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cca:	eb 0d                	jmp    800cd9 <strtol+0xa0>
	else if (base == 0)
  800ccc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd0:	75 07                	jne    800cd9 <strtol+0xa0>
		base = 10;
  800cd2:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	3c 2f                	cmp    $0x2f,%al
  800ce0:	7e 19                	jle    800cfb <strtol+0xc2>
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8a 00                	mov    (%eax),%al
  800ce7:	3c 39                	cmp    $0x39,%al
  800ce9:	7f 10                	jg     800cfb <strtol+0xc2>
			dig = *s - '0';
  800ceb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cee:	8a 00                	mov    (%eax),%al
  800cf0:	0f be c0             	movsbl %al,%eax
  800cf3:	83 e8 30             	sub    $0x30,%eax
  800cf6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800cf9:	eb 42                	jmp    800d3d <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfe:	8a 00                	mov    (%eax),%al
  800d00:	3c 60                	cmp    $0x60,%al
  800d02:	7e 19                	jle    800d1d <strtol+0xe4>
  800d04:	8b 45 08             	mov    0x8(%ebp),%eax
  800d07:	8a 00                	mov    (%eax),%al
  800d09:	3c 7a                	cmp    $0x7a,%al
  800d0b:	7f 10                	jg     800d1d <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8a 00                	mov    (%eax),%al
  800d12:	0f be c0             	movsbl %al,%eax
  800d15:	83 e8 57             	sub    $0x57,%eax
  800d18:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d1b:	eb 20                	jmp    800d3d <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d1d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	3c 40                	cmp    $0x40,%al
  800d24:	7e 39                	jle    800d5f <strtol+0x126>
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8a 00                	mov    (%eax),%al
  800d2b:	3c 5a                	cmp    $0x5a,%al
  800d2d:	7f 30                	jg     800d5f <strtol+0x126>
			dig = *s - 'A' + 10;
  800d2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d32:	8a 00                	mov    (%eax),%al
  800d34:	0f be c0             	movsbl %al,%eax
  800d37:	83 e8 37             	sub    $0x37,%eax
  800d3a:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d40:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d43:	7d 19                	jge    800d5e <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d45:	ff 45 08             	incl   0x8(%ebp)
  800d48:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d4b:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d4f:	89 c2                	mov    %eax,%edx
  800d51:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d54:	01 d0                	add    %edx,%eax
  800d56:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d59:	e9 7b ff ff ff       	jmp    800cd9 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d5e:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d5f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d63:	74 08                	je     800d6d <strtol+0x134>
		*endptr = (char *) s;
  800d65:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d68:	8b 55 08             	mov    0x8(%ebp),%edx
  800d6b:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d6d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d71:	74 07                	je     800d7a <strtol+0x141>
  800d73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d76:	f7 d8                	neg    %eax
  800d78:	eb 03                	jmp    800d7d <strtol+0x144>
  800d7a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d7d:	c9                   	leave  
  800d7e:	c3                   	ret    

00800d7f <ltostr>:

void
ltostr(long value, char *str)
{
  800d7f:	55                   	push   %ebp
  800d80:	89 e5                	mov    %esp,%ebp
  800d82:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d85:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d8c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d93:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d97:	79 13                	jns    800dac <ltostr+0x2d>
	{
		neg = 1;
  800d99:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800da0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da3:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800da6:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800da9:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800db4:	99                   	cltd   
  800db5:	f7 f9                	idiv   %ecx
  800db7:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800dba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dbd:	8d 50 01             	lea    0x1(%eax),%edx
  800dc0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dc3:	89 c2                	mov    %eax,%edx
  800dc5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc8:	01 d0                	add    %edx,%eax
  800dca:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dcd:	83 c2 30             	add    $0x30,%edx
  800dd0:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dd2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dd5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dda:	f7 e9                	imul   %ecx
  800ddc:	c1 fa 02             	sar    $0x2,%edx
  800ddf:	89 c8                	mov    %ecx,%eax
  800de1:	c1 f8 1f             	sar    $0x1f,%eax
  800de4:	29 c2                	sub    %eax,%edx
  800de6:	89 d0                	mov    %edx,%eax
  800de8:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800deb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dee:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800df3:	f7 e9                	imul   %ecx
  800df5:	c1 fa 02             	sar    $0x2,%edx
  800df8:	89 c8                	mov    %ecx,%eax
  800dfa:	c1 f8 1f             	sar    $0x1f,%eax
  800dfd:	29 c2                	sub    %eax,%edx
  800dff:	89 d0                	mov    %edx,%eax
  800e01:	c1 e0 02             	shl    $0x2,%eax
  800e04:	01 d0                	add    %edx,%eax
  800e06:	01 c0                	add    %eax,%eax
  800e08:	29 c1                	sub    %eax,%ecx
  800e0a:	89 ca                	mov    %ecx,%edx
  800e0c:	85 d2                	test   %edx,%edx
  800e0e:	75 9c                	jne    800dac <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e17:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1a:	48                   	dec    %eax
  800e1b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e1e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e22:	74 3d                	je     800e61 <ltostr+0xe2>
		start = 1 ;
  800e24:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e2b:	eb 34                	jmp    800e61 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e2d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e30:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e33:	01 d0                	add    %edx,%eax
  800e35:	8a 00                	mov    (%eax),%al
  800e37:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e40:	01 c2                	add    %eax,%edx
  800e42:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e48:	01 c8                	add    %ecx,%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e4e:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e51:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e54:	01 c2                	add    %eax,%edx
  800e56:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e59:	88 02                	mov    %al,(%edx)
		start++ ;
  800e5b:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e5e:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e61:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e64:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e67:	7c c4                	jl     800e2d <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e69:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6f:	01 d0                	add    %edx,%eax
  800e71:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e74:	90                   	nop
  800e75:	c9                   	leave  
  800e76:	c3                   	ret    

00800e77 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e77:	55                   	push   %ebp
  800e78:	89 e5                	mov    %esp,%ebp
  800e7a:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e7d:	ff 75 08             	pushl  0x8(%ebp)
  800e80:	e8 54 fa ff ff       	call   8008d9 <strlen>
  800e85:	83 c4 04             	add    $0x4,%esp
  800e88:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e8b:	ff 75 0c             	pushl  0xc(%ebp)
  800e8e:	e8 46 fa ff ff       	call   8008d9 <strlen>
  800e93:	83 c4 04             	add    $0x4,%esp
  800e96:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e99:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ea0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ea7:	eb 17                	jmp    800ec0 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ea9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eac:	8b 45 10             	mov    0x10(%ebp),%eax
  800eaf:	01 c2                	add    %eax,%edx
  800eb1:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800eb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb7:	01 c8                	add    %ecx,%eax
  800eb9:	8a 00                	mov    (%eax),%al
  800ebb:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ebd:	ff 45 fc             	incl   -0x4(%ebp)
  800ec0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec3:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ec6:	7c e1                	jl     800ea9 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ec8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ecf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ed6:	eb 1f                	jmp    800ef7 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ed8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800edb:	8d 50 01             	lea    0x1(%eax),%edx
  800ede:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ee1:	89 c2                	mov    %eax,%edx
  800ee3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ee6:	01 c2                	add    %eax,%edx
  800ee8:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800eeb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eee:	01 c8                	add    %ecx,%eax
  800ef0:	8a 00                	mov    (%eax),%al
  800ef2:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ef4:	ff 45 f8             	incl   -0x8(%ebp)
  800ef7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800efa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800efd:	7c d9                	jl     800ed8 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800eff:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f02:	8b 45 10             	mov    0x10(%ebp),%eax
  800f05:	01 d0                	add    %edx,%eax
  800f07:	c6 00 00             	movb   $0x0,(%eax)
}
  800f0a:	90                   	nop
  800f0b:	c9                   	leave  
  800f0c:	c3                   	ret    

00800f0d <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f0d:	55                   	push   %ebp
  800f0e:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f10:	8b 45 14             	mov    0x14(%ebp),%eax
  800f13:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f19:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1c:	8b 00                	mov    (%eax),%eax
  800f1e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f25:	8b 45 10             	mov    0x10(%ebp),%eax
  800f28:	01 d0                	add    %edx,%eax
  800f2a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f30:	eb 0c                	jmp    800f3e <strsplit+0x31>
			*string++ = 0;
  800f32:	8b 45 08             	mov    0x8(%ebp),%eax
  800f35:	8d 50 01             	lea    0x1(%eax),%edx
  800f38:	89 55 08             	mov    %edx,0x8(%ebp)
  800f3b:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	84 c0                	test   %al,%al
  800f45:	74 18                	je     800f5f <strsplit+0x52>
  800f47:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4a:	8a 00                	mov    (%eax),%al
  800f4c:	0f be c0             	movsbl %al,%eax
  800f4f:	50                   	push   %eax
  800f50:	ff 75 0c             	pushl  0xc(%ebp)
  800f53:	e8 13 fb ff ff       	call   800a6b <strchr>
  800f58:	83 c4 08             	add    $0x8,%esp
  800f5b:	85 c0                	test   %eax,%eax
  800f5d:	75 d3                	jne    800f32 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	84 c0                	test   %al,%al
  800f66:	74 5a                	je     800fc2 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f68:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6b:	8b 00                	mov    (%eax),%eax
  800f6d:	83 f8 0f             	cmp    $0xf,%eax
  800f70:	75 07                	jne    800f79 <strsplit+0x6c>
		{
			return 0;
  800f72:	b8 00 00 00 00       	mov    $0x0,%eax
  800f77:	eb 66                	jmp    800fdf <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f79:	8b 45 14             	mov    0x14(%ebp),%eax
  800f7c:	8b 00                	mov    (%eax),%eax
  800f7e:	8d 48 01             	lea    0x1(%eax),%ecx
  800f81:	8b 55 14             	mov    0x14(%ebp),%edx
  800f84:	89 0a                	mov    %ecx,(%edx)
  800f86:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f90:	01 c2                	add    %eax,%edx
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f97:	eb 03                	jmp    800f9c <strsplit+0x8f>
			string++;
  800f99:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9f:	8a 00                	mov    (%eax),%al
  800fa1:	84 c0                	test   %al,%al
  800fa3:	74 8b                	je     800f30 <strsplit+0x23>
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	8a 00                	mov    (%eax),%al
  800faa:	0f be c0             	movsbl %al,%eax
  800fad:	50                   	push   %eax
  800fae:	ff 75 0c             	pushl  0xc(%ebp)
  800fb1:	e8 b5 fa ff ff       	call   800a6b <strchr>
  800fb6:	83 c4 08             	add    $0x8,%esp
  800fb9:	85 c0                	test   %eax,%eax
  800fbb:	74 dc                	je     800f99 <strsplit+0x8c>
			string++;
	}
  800fbd:	e9 6e ff ff ff       	jmp    800f30 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fc2:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fc3:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc6:	8b 00                	mov    (%eax),%eax
  800fc8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fcf:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd2:	01 d0                	add    %edx,%eax
  800fd4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fda:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fdf:	c9                   	leave  
  800fe0:	c3                   	ret    

00800fe1 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fe1:	55                   	push   %ebp
  800fe2:	89 e5                	mov    %esp,%ebp
  800fe4:	57                   	push   %edi
  800fe5:	56                   	push   %esi
  800fe6:	53                   	push   %ebx
  800fe7:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ff0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800ff3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800ff6:	8b 7d 18             	mov    0x18(%ebp),%edi
  800ff9:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800ffc:	cd 30                	int    $0x30
  800ffe:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801001:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801004:	83 c4 10             	add    $0x10,%esp
  801007:	5b                   	pop    %ebx
  801008:	5e                   	pop    %esi
  801009:	5f                   	pop    %edi
  80100a:	5d                   	pop    %ebp
  80100b:	c3                   	ret    

0080100c <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80100c:	55                   	push   %ebp
  80100d:	89 e5                	mov    %esp,%ebp
  80100f:	83 ec 04             	sub    $0x4,%esp
  801012:	8b 45 10             	mov    0x10(%ebp),%eax
  801015:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801018:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80101c:	8b 45 08             	mov    0x8(%ebp),%eax
  80101f:	6a 00                	push   $0x0
  801021:	6a 00                	push   $0x0
  801023:	52                   	push   %edx
  801024:	ff 75 0c             	pushl  0xc(%ebp)
  801027:	50                   	push   %eax
  801028:	6a 00                	push   $0x0
  80102a:	e8 b2 ff ff ff       	call   800fe1 <syscall>
  80102f:	83 c4 18             	add    $0x18,%esp
}
  801032:	90                   	nop
  801033:	c9                   	leave  
  801034:	c3                   	ret    

00801035 <sys_cgetc>:

int
sys_cgetc(void)
{
  801035:	55                   	push   %ebp
  801036:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801038:	6a 00                	push   $0x0
  80103a:	6a 00                	push   $0x0
  80103c:	6a 00                	push   $0x0
  80103e:	6a 00                	push   $0x0
  801040:	6a 00                	push   $0x0
  801042:	6a 01                	push   $0x1
  801044:	e8 98 ff ff ff       	call   800fe1 <syscall>
  801049:	83 c4 18             	add    $0x18,%esp
}
  80104c:	c9                   	leave  
  80104d:	c3                   	ret    

0080104e <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80104e:	55                   	push   %ebp
  80104f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801051:	8b 45 08             	mov    0x8(%ebp),%eax
  801054:	6a 00                	push   $0x0
  801056:	6a 00                	push   $0x0
  801058:	6a 00                	push   $0x0
  80105a:	6a 00                	push   $0x0
  80105c:	50                   	push   %eax
  80105d:	6a 05                	push   $0x5
  80105f:	e8 7d ff ff ff       	call   800fe1 <syscall>
  801064:	83 c4 18             	add    $0x18,%esp
}
  801067:	c9                   	leave  
  801068:	c3                   	ret    

00801069 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801069:	55                   	push   %ebp
  80106a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80106c:	6a 00                	push   $0x0
  80106e:	6a 00                	push   $0x0
  801070:	6a 00                	push   $0x0
  801072:	6a 00                	push   $0x0
  801074:	6a 00                	push   $0x0
  801076:	6a 02                	push   $0x2
  801078:	e8 64 ff ff ff       	call   800fe1 <syscall>
  80107d:	83 c4 18             	add    $0x18,%esp
}
  801080:	c9                   	leave  
  801081:	c3                   	ret    

00801082 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801082:	55                   	push   %ebp
  801083:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801085:	6a 00                	push   $0x0
  801087:	6a 00                	push   $0x0
  801089:	6a 00                	push   $0x0
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 03                	push   $0x3
  801091:	e8 4b ff ff ff       	call   800fe1 <syscall>
  801096:	83 c4 18             	add    $0x18,%esp
}
  801099:	c9                   	leave  
  80109a:	c3                   	ret    

0080109b <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80109b:	55                   	push   %ebp
  80109c:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80109e:	6a 00                	push   $0x0
  8010a0:	6a 00                	push   $0x0
  8010a2:	6a 00                	push   $0x0
  8010a4:	6a 00                	push   $0x0
  8010a6:	6a 00                	push   $0x0
  8010a8:	6a 04                	push   $0x4
  8010aa:	e8 32 ff ff ff       	call   800fe1 <syscall>
  8010af:	83 c4 18             	add    $0x18,%esp
}
  8010b2:	c9                   	leave  
  8010b3:	c3                   	ret    

008010b4 <sys_env_exit>:


void sys_env_exit(void)
{
  8010b4:	55                   	push   %ebp
  8010b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010b7:	6a 00                	push   $0x0
  8010b9:	6a 00                	push   $0x0
  8010bb:	6a 00                	push   $0x0
  8010bd:	6a 00                	push   $0x0
  8010bf:	6a 00                	push   $0x0
  8010c1:	6a 06                	push   $0x6
  8010c3:	e8 19 ff ff ff       	call   800fe1 <syscall>
  8010c8:	83 c4 18             	add    $0x18,%esp
}
  8010cb:	90                   	nop
  8010cc:	c9                   	leave  
  8010cd:	c3                   	ret    

008010ce <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010ce:	55                   	push   %ebp
  8010cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010d1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d7:	6a 00                	push   $0x0
  8010d9:	6a 00                	push   $0x0
  8010db:	6a 00                	push   $0x0
  8010dd:	52                   	push   %edx
  8010de:	50                   	push   %eax
  8010df:	6a 07                	push   $0x7
  8010e1:	e8 fb fe ff ff       	call   800fe1 <syscall>
  8010e6:	83 c4 18             	add    $0x18,%esp
}
  8010e9:	c9                   	leave  
  8010ea:	c3                   	ret    

008010eb <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010eb:	55                   	push   %ebp
  8010ec:	89 e5                	mov    %esp,%ebp
  8010ee:	56                   	push   %esi
  8010ef:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010f0:	8b 75 18             	mov    0x18(%ebp),%esi
  8010f3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010f9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ff:	56                   	push   %esi
  801100:	53                   	push   %ebx
  801101:	51                   	push   %ecx
  801102:	52                   	push   %edx
  801103:	50                   	push   %eax
  801104:	6a 08                	push   $0x8
  801106:	e8 d6 fe ff ff       	call   800fe1 <syscall>
  80110b:	83 c4 18             	add    $0x18,%esp
}
  80110e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801111:	5b                   	pop    %ebx
  801112:	5e                   	pop    %esi
  801113:	5d                   	pop    %ebp
  801114:	c3                   	ret    

00801115 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801115:	55                   	push   %ebp
  801116:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801118:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111b:	8b 45 08             	mov    0x8(%ebp),%eax
  80111e:	6a 00                	push   $0x0
  801120:	6a 00                	push   $0x0
  801122:	6a 00                	push   $0x0
  801124:	52                   	push   %edx
  801125:	50                   	push   %eax
  801126:	6a 09                	push   $0x9
  801128:	e8 b4 fe ff ff       	call   800fe1 <syscall>
  80112d:	83 c4 18             	add    $0x18,%esp
}
  801130:	c9                   	leave  
  801131:	c3                   	ret    

00801132 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801132:	55                   	push   %ebp
  801133:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801135:	6a 00                	push   $0x0
  801137:	6a 00                	push   $0x0
  801139:	6a 00                	push   $0x0
  80113b:	ff 75 0c             	pushl  0xc(%ebp)
  80113e:	ff 75 08             	pushl  0x8(%ebp)
  801141:	6a 0a                	push   $0xa
  801143:	e8 99 fe ff ff       	call   800fe1 <syscall>
  801148:	83 c4 18             	add    $0x18,%esp
}
  80114b:	c9                   	leave  
  80114c:	c3                   	ret    

0080114d <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80114d:	55                   	push   %ebp
  80114e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801150:	6a 00                	push   $0x0
  801152:	6a 00                	push   $0x0
  801154:	6a 00                	push   $0x0
  801156:	6a 00                	push   $0x0
  801158:	6a 00                	push   $0x0
  80115a:	6a 0b                	push   $0xb
  80115c:	e8 80 fe ff ff       	call   800fe1 <syscall>
  801161:	83 c4 18             	add    $0x18,%esp
}
  801164:	c9                   	leave  
  801165:	c3                   	ret    

00801166 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801166:	55                   	push   %ebp
  801167:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801169:	6a 00                	push   $0x0
  80116b:	6a 00                	push   $0x0
  80116d:	6a 00                	push   $0x0
  80116f:	6a 00                	push   $0x0
  801171:	6a 00                	push   $0x0
  801173:	6a 0c                	push   $0xc
  801175:	e8 67 fe ff ff       	call   800fe1 <syscall>
  80117a:	83 c4 18             	add    $0x18,%esp
}
  80117d:	c9                   	leave  
  80117e:	c3                   	ret    

0080117f <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80117f:	55                   	push   %ebp
  801180:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801182:	6a 00                	push   $0x0
  801184:	6a 00                	push   $0x0
  801186:	6a 00                	push   $0x0
  801188:	6a 00                	push   $0x0
  80118a:	6a 00                	push   $0x0
  80118c:	6a 0d                	push   $0xd
  80118e:	e8 4e fe ff ff       	call   800fe1 <syscall>
  801193:	83 c4 18             	add    $0x18,%esp
}
  801196:	c9                   	leave  
  801197:	c3                   	ret    

00801198 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801198:	55                   	push   %ebp
  801199:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80119b:	6a 00                	push   $0x0
  80119d:	6a 00                	push   $0x0
  80119f:	6a 00                	push   $0x0
  8011a1:	ff 75 0c             	pushl  0xc(%ebp)
  8011a4:	ff 75 08             	pushl  0x8(%ebp)
  8011a7:	6a 11                	push   $0x11
  8011a9:	e8 33 fe ff ff       	call   800fe1 <syscall>
  8011ae:	83 c4 18             	add    $0x18,%esp
	return;
  8011b1:	90                   	nop
}
  8011b2:	c9                   	leave  
  8011b3:	c3                   	ret    

008011b4 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011b4:	55                   	push   %ebp
  8011b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 00                	push   $0x0
  8011bd:	ff 75 0c             	pushl  0xc(%ebp)
  8011c0:	ff 75 08             	pushl  0x8(%ebp)
  8011c3:	6a 12                	push   $0x12
  8011c5:	e8 17 fe ff ff       	call   800fe1 <syscall>
  8011ca:	83 c4 18             	add    $0x18,%esp
	return ;
  8011cd:	90                   	nop
}
  8011ce:	c9                   	leave  
  8011cf:	c3                   	ret    

008011d0 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011d0:	55                   	push   %ebp
  8011d1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011d3:	6a 00                	push   $0x0
  8011d5:	6a 00                	push   $0x0
  8011d7:	6a 00                	push   $0x0
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 0e                	push   $0xe
  8011df:	e8 fd fd ff ff       	call   800fe1 <syscall>
  8011e4:	83 c4 18             	add    $0x18,%esp
}
  8011e7:	c9                   	leave  
  8011e8:	c3                   	ret    

008011e9 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011e9:	55                   	push   %ebp
  8011ea:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011ec:	6a 00                	push   $0x0
  8011ee:	6a 00                	push   $0x0
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	ff 75 08             	pushl  0x8(%ebp)
  8011f7:	6a 0f                	push   $0xf
  8011f9:	e8 e3 fd ff ff       	call   800fe1 <syscall>
  8011fe:	83 c4 18             	add    $0x18,%esp
}
  801201:	c9                   	leave  
  801202:	c3                   	ret    

00801203 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801203:	55                   	push   %ebp
  801204:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 00                	push   $0x0
  801210:	6a 10                	push   $0x10
  801212:	e8 ca fd ff ff       	call   800fe1 <syscall>
  801217:	83 c4 18             	add    $0x18,%esp
}
  80121a:	90                   	nop
  80121b:	c9                   	leave  
  80121c:	c3                   	ret    

0080121d <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80121d:	55                   	push   %ebp
  80121e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801220:	6a 00                	push   $0x0
  801222:	6a 00                	push   $0x0
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 14                	push   $0x14
  80122c:	e8 b0 fd ff ff       	call   800fe1 <syscall>
  801231:	83 c4 18             	add    $0x18,%esp
}
  801234:	90                   	nop
  801235:	c9                   	leave  
  801236:	c3                   	ret    

00801237 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801237:	55                   	push   %ebp
  801238:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80123a:	6a 00                	push   $0x0
  80123c:	6a 00                	push   $0x0
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 15                	push   $0x15
  801246:	e8 96 fd ff ff       	call   800fe1 <syscall>
  80124b:	83 c4 18             	add    $0x18,%esp
}
  80124e:	90                   	nop
  80124f:	c9                   	leave  
  801250:	c3                   	ret    

00801251 <sys_cputc>:


void
sys_cputc(const char c)
{
  801251:	55                   	push   %ebp
  801252:	89 e5                	mov    %esp,%ebp
  801254:	83 ec 04             	sub    $0x4,%esp
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80125d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	50                   	push   %eax
  80126a:	6a 16                	push   $0x16
  80126c:	e8 70 fd ff ff       	call   800fe1 <syscall>
  801271:	83 c4 18             	add    $0x18,%esp
}
  801274:	90                   	nop
  801275:	c9                   	leave  
  801276:	c3                   	ret    

00801277 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801277:	55                   	push   %ebp
  801278:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 17                	push   $0x17
  801286:	e8 56 fd ff ff       	call   800fe1 <syscall>
  80128b:	83 c4 18             	add    $0x18,%esp
}
  80128e:	90                   	nop
  80128f:	c9                   	leave  
  801290:	c3                   	ret    

00801291 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801294:	8b 45 08             	mov    0x8(%ebp),%eax
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	ff 75 0c             	pushl  0xc(%ebp)
  8012a0:	50                   	push   %eax
  8012a1:	6a 18                	push   $0x18
  8012a3:	e8 39 fd ff ff       	call   800fe1 <syscall>
  8012a8:	83 c4 18             	add    $0x18,%esp
}
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012b0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	52                   	push   %edx
  8012bd:	50                   	push   %eax
  8012be:	6a 1b                	push   $0x1b
  8012c0:	e8 1c fd ff ff       	call   800fe1 <syscall>
  8012c5:	83 c4 18             	add    $0x18,%esp
}
  8012c8:	c9                   	leave  
  8012c9:	c3                   	ret    

008012ca <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012ca:	55                   	push   %ebp
  8012cb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	52                   	push   %edx
  8012da:	50                   	push   %eax
  8012db:	6a 19                	push   $0x19
  8012dd:	e8 ff fc ff ff       	call   800fe1 <syscall>
  8012e2:	83 c4 18             	add    $0x18,%esp
}
  8012e5:	90                   	nop
  8012e6:	c9                   	leave  
  8012e7:	c3                   	ret    

008012e8 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012e8:	55                   	push   %ebp
  8012e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	6a 00                	push   $0x0
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	52                   	push   %edx
  8012f8:	50                   	push   %eax
  8012f9:	6a 1a                	push   $0x1a
  8012fb:	e8 e1 fc ff ff       	call   800fe1 <syscall>
  801300:	83 c4 18             	add    $0x18,%esp
}
  801303:	90                   	nop
  801304:	c9                   	leave  
  801305:	c3                   	ret    

00801306 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
  801309:	83 ec 04             	sub    $0x4,%esp
  80130c:	8b 45 10             	mov    0x10(%ebp),%eax
  80130f:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801312:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801315:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801319:	8b 45 08             	mov    0x8(%ebp),%eax
  80131c:	6a 00                	push   $0x0
  80131e:	51                   	push   %ecx
  80131f:	52                   	push   %edx
  801320:	ff 75 0c             	pushl  0xc(%ebp)
  801323:	50                   	push   %eax
  801324:	6a 1c                	push   $0x1c
  801326:	e8 b6 fc ff ff       	call   800fe1 <syscall>
  80132b:	83 c4 18             	add    $0x18,%esp
}
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801333:	8b 55 0c             	mov    0xc(%ebp),%edx
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	52                   	push   %edx
  801340:	50                   	push   %eax
  801341:	6a 1d                	push   $0x1d
  801343:	e8 99 fc ff ff       	call   800fe1 <syscall>
  801348:	83 c4 18             	add    $0x18,%esp
}
  80134b:	c9                   	leave  
  80134c:	c3                   	ret    

0080134d <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80134d:	55                   	push   %ebp
  80134e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801350:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801353:	8b 55 0c             	mov    0xc(%ebp),%edx
  801356:	8b 45 08             	mov    0x8(%ebp),%eax
  801359:	6a 00                	push   $0x0
  80135b:	6a 00                	push   $0x0
  80135d:	51                   	push   %ecx
  80135e:	52                   	push   %edx
  80135f:	50                   	push   %eax
  801360:	6a 1e                	push   $0x1e
  801362:	e8 7a fc ff ff       	call   800fe1 <syscall>
  801367:	83 c4 18             	add    $0x18,%esp
}
  80136a:	c9                   	leave  
  80136b:	c3                   	ret    

0080136c <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80136c:	55                   	push   %ebp
  80136d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80136f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	6a 00                	push   $0x0
  80137b:	52                   	push   %edx
  80137c:	50                   	push   %eax
  80137d:	6a 1f                	push   $0x1f
  80137f:	e8 5d fc ff ff       	call   800fe1 <syscall>
  801384:	83 c4 18             	add    $0x18,%esp
}
  801387:	c9                   	leave  
  801388:	c3                   	ret    

00801389 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801389:	55                   	push   %ebp
  80138a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	6a 00                	push   $0x0
  801394:	6a 00                	push   $0x0
  801396:	6a 20                	push   $0x20
  801398:	e8 44 fc ff ff       	call   800fe1 <syscall>
  80139d:	83 c4 18             	add    $0x18,%esp
}
  8013a0:	c9                   	leave  
  8013a1:	c3                   	ret    

008013a2 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013a2:	55                   	push   %ebp
  8013a3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a8:	6a 00                	push   $0x0
  8013aa:	ff 75 14             	pushl  0x14(%ebp)
  8013ad:	ff 75 10             	pushl  0x10(%ebp)
  8013b0:	ff 75 0c             	pushl  0xc(%ebp)
  8013b3:	50                   	push   %eax
  8013b4:	6a 21                	push   $0x21
  8013b6:	e8 26 fc ff ff       	call   800fe1 <syscall>
  8013bb:	83 c4 18             	add    $0x18,%esp
}
  8013be:	c9                   	leave  
  8013bf:	c3                   	ret    

008013c0 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013c0:	55                   	push   %ebp
  8013c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	50                   	push   %eax
  8013cf:	6a 22                	push   $0x22
  8013d1:	e8 0b fc ff ff       	call   800fe1 <syscall>
  8013d6:	83 c4 18             	add    $0x18,%esp
}
  8013d9:	90                   	nop
  8013da:	c9                   	leave  
  8013db:	c3                   	ret    

008013dc <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013dc:	55                   	push   %ebp
  8013dd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013df:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e2:	6a 00                	push   $0x0
  8013e4:	6a 00                	push   $0x0
  8013e6:	6a 00                	push   $0x0
  8013e8:	6a 00                	push   $0x0
  8013ea:	50                   	push   %eax
  8013eb:	6a 23                	push   $0x23
  8013ed:	e8 ef fb ff ff       	call   800fe1 <syscall>
  8013f2:	83 c4 18             	add    $0x18,%esp
}
  8013f5:	90                   	nop
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
  8013fb:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013fe:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801401:	8d 50 04             	lea    0x4(%eax),%edx
  801404:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801407:	6a 00                	push   $0x0
  801409:	6a 00                	push   $0x0
  80140b:	6a 00                	push   $0x0
  80140d:	52                   	push   %edx
  80140e:	50                   	push   %eax
  80140f:	6a 24                	push   $0x24
  801411:	e8 cb fb ff ff       	call   800fe1 <syscall>
  801416:	83 c4 18             	add    $0x18,%esp
	return result;
  801419:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80141c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80141f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801422:	89 01                	mov    %eax,(%ecx)
  801424:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801427:	8b 45 08             	mov    0x8(%ebp),%eax
  80142a:	c9                   	leave  
  80142b:	c2 04 00             	ret    $0x4

0080142e <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	ff 75 10             	pushl  0x10(%ebp)
  801438:	ff 75 0c             	pushl  0xc(%ebp)
  80143b:	ff 75 08             	pushl  0x8(%ebp)
  80143e:	6a 13                	push   $0x13
  801440:	e8 9c fb ff ff       	call   800fe1 <syscall>
  801445:	83 c4 18             	add    $0x18,%esp
	return ;
  801448:	90                   	nop
}
  801449:	c9                   	leave  
  80144a:	c3                   	ret    

0080144b <sys_rcr2>:
uint32 sys_rcr2()
{
  80144b:	55                   	push   %ebp
  80144c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80144e:	6a 00                	push   $0x0
  801450:	6a 00                	push   $0x0
  801452:	6a 00                	push   $0x0
  801454:	6a 00                	push   $0x0
  801456:	6a 00                	push   $0x0
  801458:	6a 25                	push   $0x25
  80145a:	e8 82 fb ff ff       	call   800fe1 <syscall>
  80145f:	83 c4 18             	add    $0x18,%esp
}
  801462:	c9                   	leave  
  801463:	c3                   	ret    

00801464 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801464:	55                   	push   %ebp
  801465:	89 e5                	mov    %esp,%ebp
  801467:	83 ec 04             	sub    $0x4,%esp
  80146a:	8b 45 08             	mov    0x8(%ebp),%eax
  80146d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801470:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801474:	6a 00                	push   $0x0
  801476:	6a 00                	push   $0x0
  801478:	6a 00                	push   $0x0
  80147a:	6a 00                	push   $0x0
  80147c:	50                   	push   %eax
  80147d:	6a 26                	push   $0x26
  80147f:	e8 5d fb ff ff       	call   800fe1 <syscall>
  801484:	83 c4 18             	add    $0x18,%esp
	return ;
  801487:	90                   	nop
}
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <rsttst>:
void rsttst()
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	6a 00                	push   $0x0
  801493:	6a 00                	push   $0x0
  801495:	6a 00                	push   $0x0
  801497:	6a 28                	push   $0x28
  801499:	e8 43 fb ff ff       	call   800fe1 <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a1:	90                   	nop
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
  8014a7:	83 ec 04             	sub    $0x4,%esp
  8014aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ad:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014b0:	8b 55 18             	mov    0x18(%ebp),%edx
  8014b3:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014b7:	52                   	push   %edx
  8014b8:	50                   	push   %eax
  8014b9:	ff 75 10             	pushl  0x10(%ebp)
  8014bc:	ff 75 0c             	pushl  0xc(%ebp)
  8014bf:	ff 75 08             	pushl  0x8(%ebp)
  8014c2:	6a 27                	push   $0x27
  8014c4:	e8 18 fb ff ff       	call   800fe1 <syscall>
  8014c9:	83 c4 18             	add    $0x18,%esp
	return ;
  8014cc:	90                   	nop
}
  8014cd:	c9                   	leave  
  8014ce:	c3                   	ret    

008014cf <chktst>:
void chktst(uint32 n)
{
  8014cf:	55                   	push   %ebp
  8014d0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	6a 00                	push   $0x0
  8014da:	ff 75 08             	pushl  0x8(%ebp)
  8014dd:	6a 29                	push   $0x29
  8014df:	e8 fd fa ff ff       	call   800fe1 <syscall>
  8014e4:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e7:	90                   	nop
}
  8014e8:	c9                   	leave  
  8014e9:	c3                   	ret    

008014ea <inctst>:

void inctst()
{
  8014ea:	55                   	push   %ebp
  8014eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 2a                	push   $0x2a
  8014f9:	e8 e3 fa ff ff       	call   800fe1 <syscall>
  8014fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801501:	90                   	nop
}
  801502:	c9                   	leave  
  801503:	c3                   	ret    

00801504 <gettst>:
uint32 gettst()
{
  801504:	55                   	push   %ebp
  801505:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801507:	6a 00                	push   $0x0
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 2b                	push   $0x2b
  801513:	e8 c9 fa ff ff       	call   800fe1 <syscall>
  801518:	83 c4 18             	add    $0x18,%esp
}
  80151b:	c9                   	leave  
  80151c:	c3                   	ret    

0080151d <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80151d:	55                   	push   %ebp
  80151e:	89 e5                	mov    %esp,%ebp
  801520:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801523:	6a 00                	push   $0x0
  801525:	6a 00                	push   $0x0
  801527:	6a 00                	push   $0x0
  801529:	6a 00                	push   $0x0
  80152b:	6a 00                	push   $0x0
  80152d:	6a 2c                	push   $0x2c
  80152f:	e8 ad fa ff ff       	call   800fe1 <syscall>
  801534:	83 c4 18             	add    $0x18,%esp
  801537:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80153a:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80153e:	75 07                	jne    801547 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801540:	b8 01 00 00 00       	mov    $0x1,%eax
  801545:	eb 05                	jmp    80154c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801547:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80154c:	c9                   	leave  
  80154d:	c3                   	ret    

0080154e <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80154e:	55                   	push   %ebp
  80154f:	89 e5                	mov    %esp,%ebp
  801551:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 00                	push   $0x0
  80155e:	6a 2c                	push   $0x2c
  801560:	e8 7c fa ff ff       	call   800fe1 <syscall>
  801565:	83 c4 18             	add    $0x18,%esp
  801568:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80156b:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80156f:	75 07                	jne    801578 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801571:	b8 01 00 00 00       	mov    $0x1,%eax
  801576:	eb 05                	jmp    80157d <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801578:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80157d:	c9                   	leave  
  80157e:	c3                   	ret    

0080157f <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80157f:	55                   	push   %ebp
  801580:	89 e5                	mov    %esp,%ebp
  801582:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	6a 2c                	push   $0x2c
  801591:	e8 4b fa ff ff       	call   800fe1 <syscall>
  801596:	83 c4 18             	add    $0x18,%esp
  801599:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80159c:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015a0:	75 07                	jne    8015a9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a7:	eb 05                	jmp    8015ae <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015a9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ae:	c9                   	leave  
  8015af:	c3                   	ret    

008015b0 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
  8015b3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 00                	push   $0x0
  8015c0:	6a 2c                	push   $0x2c
  8015c2:	e8 1a fa ff ff       	call   800fe1 <syscall>
  8015c7:	83 c4 18             	add    $0x18,%esp
  8015ca:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015cd:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015d1:	75 07                	jne    8015da <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015d3:	b8 01 00 00 00       	mov    $0x1,%eax
  8015d8:	eb 05                	jmp    8015df <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015da:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015df:	c9                   	leave  
  8015e0:	c3                   	ret    

008015e1 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015e1:	55                   	push   %ebp
  8015e2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	ff 75 08             	pushl  0x8(%ebp)
  8015ef:	6a 2d                	push   $0x2d
  8015f1:	e8 eb f9 ff ff       	call   800fe1 <syscall>
  8015f6:	83 c4 18             	add    $0x18,%esp
	return ;
  8015f9:	90                   	nop
}
  8015fa:	c9                   	leave  
  8015fb:	c3                   	ret    

008015fc <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
  8015ff:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801600:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801603:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801606:	8b 55 0c             	mov    0xc(%ebp),%edx
  801609:	8b 45 08             	mov    0x8(%ebp),%eax
  80160c:	6a 00                	push   $0x0
  80160e:	53                   	push   %ebx
  80160f:	51                   	push   %ecx
  801610:	52                   	push   %edx
  801611:	50                   	push   %eax
  801612:	6a 2e                	push   $0x2e
  801614:	e8 c8 f9 ff ff       	call   800fe1 <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
}
  80161c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80161f:	c9                   	leave  
  801620:	c3                   	ret    

00801621 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801621:	55                   	push   %ebp
  801622:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801624:	8b 55 0c             	mov    0xc(%ebp),%edx
  801627:	8b 45 08             	mov    0x8(%ebp),%eax
  80162a:	6a 00                	push   $0x0
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	52                   	push   %edx
  801631:	50                   	push   %eax
  801632:	6a 2f                	push   $0x2f
  801634:	e8 a8 f9 ff ff       	call   800fe1 <syscall>
  801639:	83 c4 18             	add    $0x18,%esp
}
  80163c:	c9                   	leave  
  80163d:	c3                   	ret    

0080163e <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80163e:	55                   	push   %ebp
  80163f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	6a 00                	push   $0x0
  801647:	ff 75 0c             	pushl  0xc(%ebp)
  80164a:	ff 75 08             	pushl  0x8(%ebp)
  80164d:	6a 30                	push   $0x30
  80164f:	e8 8d f9 ff ff       	call   800fe1 <syscall>
  801654:	83 c4 18             	add    $0x18,%esp
	return ;
  801657:	90                   	nop
}
  801658:	c9                   	leave  
  801659:	c3                   	ret    
  80165a:	66 90                	xchg   %ax,%ax

0080165c <__udivdi3>:
  80165c:	55                   	push   %ebp
  80165d:	57                   	push   %edi
  80165e:	56                   	push   %esi
  80165f:	53                   	push   %ebx
  801660:	83 ec 1c             	sub    $0x1c,%esp
  801663:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801667:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80166b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80166f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801673:	89 ca                	mov    %ecx,%edx
  801675:	89 f8                	mov    %edi,%eax
  801677:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80167b:	85 f6                	test   %esi,%esi
  80167d:	75 2d                	jne    8016ac <__udivdi3+0x50>
  80167f:	39 cf                	cmp    %ecx,%edi
  801681:	77 65                	ja     8016e8 <__udivdi3+0x8c>
  801683:	89 fd                	mov    %edi,%ebp
  801685:	85 ff                	test   %edi,%edi
  801687:	75 0b                	jne    801694 <__udivdi3+0x38>
  801689:	b8 01 00 00 00       	mov    $0x1,%eax
  80168e:	31 d2                	xor    %edx,%edx
  801690:	f7 f7                	div    %edi
  801692:	89 c5                	mov    %eax,%ebp
  801694:	31 d2                	xor    %edx,%edx
  801696:	89 c8                	mov    %ecx,%eax
  801698:	f7 f5                	div    %ebp
  80169a:	89 c1                	mov    %eax,%ecx
  80169c:	89 d8                	mov    %ebx,%eax
  80169e:	f7 f5                	div    %ebp
  8016a0:	89 cf                	mov    %ecx,%edi
  8016a2:	89 fa                	mov    %edi,%edx
  8016a4:	83 c4 1c             	add    $0x1c,%esp
  8016a7:	5b                   	pop    %ebx
  8016a8:	5e                   	pop    %esi
  8016a9:	5f                   	pop    %edi
  8016aa:	5d                   	pop    %ebp
  8016ab:	c3                   	ret    
  8016ac:	39 ce                	cmp    %ecx,%esi
  8016ae:	77 28                	ja     8016d8 <__udivdi3+0x7c>
  8016b0:	0f bd fe             	bsr    %esi,%edi
  8016b3:	83 f7 1f             	xor    $0x1f,%edi
  8016b6:	75 40                	jne    8016f8 <__udivdi3+0x9c>
  8016b8:	39 ce                	cmp    %ecx,%esi
  8016ba:	72 0a                	jb     8016c6 <__udivdi3+0x6a>
  8016bc:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016c0:	0f 87 9e 00 00 00    	ja     801764 <__udivdi3+0x108>
  8016c6:	b8 01 00 00 00       	mov    $0x1,%eax
  8016cb:	89 fa                	mov    %edi,%edx
  8016cd:	83 c4 1c             	add    $0x1c,%esp
  8016d0:	5b                   	pop    %ebx
  8016d1:	5e                   	pop    %esi
  8016d2:	5f                   	pop    %edi
  8016d3:	5d                   	pop    %ebp
  8016d4:	c3                   	ret    
  8016d5:	8d 76 00             	lea    0x0(%esi),%esi
  8016d8:	31 ff                	xor    %edi,%edi
  8016da:	31 c0                	xor    %eax,%eax
  8016dc:	89 fa                	mov    %edi,%edx
  8016de:	83 c4 1c             	add    $0x1c,%esp
  8016e1:	5b                   	pop    %ebx
  8016e2:	5e                   	pop    %esi
  8016e3:	5f                   	pop    %edi
  8016e4:	5d                   	pop    %ebp
  8016e5:	c3                   	ret    
  8016e6:	66 90                	xchg   %ax,%ax
  8016e8:	89 d8                	mov    %ebx,%eax
  8016ea:	f7 f7                	div    %edi
  8016ec:	31 ff                	xor    %edi,%edi
  8016ee:	89 fa                	mov    %edi,%edx
  8016f0:	83 c4 1c             	add    $0x1c,%esp
  8016f3:	5b                   	pop    %ebx
  8016f4:	5e                   	pop    %esi
  8016f5:	5f                   	pop    %edi
  8016f6:	5d                   	pop    %ebp
  8016f7:	c3                   	ret    
  8016f8:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016fd:	89 eb                	mov    %ebp,%ebx
  8016ff:	29 fb                	sub    %edi,%ebx
  801701:	89 f9                	mov    %edi,%ecx
  801703:	d3 e6                	shl    %cl,%esi
  801705:	89 c5                	mov    %eax,%ebp
  801707:	88 d9                	mov    %bl,%cl
  801709:	d3 ed                	shr    %cl,%ebp
  80170b:	89 e9                	mov    %ebp,%ecx
  80170d:	09 f1                	or     %esi,%ecx
  80170f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801713:	89 f9                	mov    %edi,%ecx
  801715:	d3 e0                	shl    %cl,%eax
  801717:	89 c5                	mov    %eax,%ebp
  801719:	89 d6                	mov    %edx,%esi
  80171b:	88 d9                	mov    %bl,%cl
  80171d:	d3 ee                	shr    %cl,%esi
  80171f:	89 f9                	mov    %edi,%ecx
  801721:	d3 e2                	shl    %cl,%edx
  801723:	8b 44 24 08          	mov    0x8(%esp),%eax
  801727:	88 d9                	mov    %bl,%cl
  801729:	d3 e8                	shr    %cl,%eax
  80172b:	09 c2                	or     %eax,%edx
  80172d:	89 d0                	mov    %edx,%eax
  80172f:	89 f2                	mov    %esi,%edx
  801731:	f7 74 24 0c          	divl   0xc(%esp)
  801735:	89 d6                	mov    %edx,%esi
  801737:	89 c3                	mov    %eax,%ebx
  801739:	f7 e5                	mul    %ebp
  80173b:	39 d6                	cmp    %edx,%esi
  80173d:	72 19                	jb     801758 <__udivdi3+0xfc>
  80173f:	74 0b                	je     80174c <__udivdi3+0xf0>
  801741:	89 d8                	mov    %ebx,%eax
  801743:	31 ff                	xor    %edi,%edi
  801745:	e9 58 ff ff ff       	jmp    8016a2 <__udivdi3+0x46>
  80174a:	66 90                	xchg   %ax,%ax
  80174c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801750:	89 f9                	mov    %edi,%ecx
  801752:	d3 e2                	shl    %cl,%edx
  801754:	39 c2                	cmp    %eax,%edx
  801756:	73 e9                	jae    801741 <__udivdi3+0xe5>
  801758:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80175b:	31 ff                	xor    %edi,%edi
  80175d:	e9 40 ff ff ff       	jmp    8016a2 <__udivdi3+0x46>
  801762:	66 90                	xchg   %ax,%ax
  801764:	31 c0                	xor    %eax,%eax
  801766:	e9 37 ff ff ff       	jmp    8016a2 <__udivdi3+0x46>
  80176b:	90                   	nop

0080176c <__umoddi3>:
  80176c:	55                   	push   %ebp
  80176d:	57                   	push   %edi
  80176e:	56                   	push   %esi
  80176f:	53                   	push   %ebx
  801770:	83 ec 1c             	sub    $0x1c,%esp
  801773:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801777:	8b 74 24 34          	mov    0x34(%esp),%esi
  80177b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80177f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801783:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801787:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80178b:	89 f3                	mov    %esi,%ebx
  80178d:	89 fa                	mov    %edi,%edx
  80178f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801793:	89 34 24             	mov    %esi,(%esp)
  801796:	85 c0                	test   %eax,%eax
  801798:	75 1a                	jne    8017b4 <__umoddi3+0x48>
  80179a:	39 f7                	cmp    %esi,%edi
  80179c:	0f 86 a2 00 00 00    	jbe    801844 <__umoddi3+0xd8>
  8017a2:	89 c8                	mov    %ecx,%eax
  8017a4:	89 f2                	mov    %esi,%edx
  8017a6:	f7 f7                	div    %edi
  8017a8:	89 d0                	mov    %edx,%eax
  8017aa:	31 d2                	xor    %edx,%edx
  8017ac:	83 c4 1c             	add    $0x1c,%esp
  8017af:	5b                   	pop    %ebx
  8017b0:	5e                   	pop    %esi
  8017b1:	5f                   	pop    %edi
  8017b2:	5d                   	pop    %ebp
  8017b3:	c3                   	ret    
  8017b4:	39 f0                	cmp    %esi,%eax
  8017b6:	0f 87 ac 00 00 00    	ja     801868 <__umoddi3+0xfc>
  8017bc:	0f bd e8             	bsr    %eax,%ebp
  8017bf:	83 f5 1f             	xor    $0x1f,%ebp
  8017c2:	0f 84 ac 00 00 00    	je     801874 <__umoddi3+0x108>
  8017c8:	bf 20 00 00 00       	mov    $0x20,%edi
  8017cd:	29 ef                	sub    %ebp,%edi
  8017cf:	89 fe                	mov    %edi,%esi
  8017d1:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017d5:	89 e9                	mov    %ebp,%ecx
  8017d7:	d3 e0                	shl    %cl,%eax
  8017d9:	89 d7                	mov    %edx,%edi
  8017db:	89 f1                	mov    %esi,%ecx
  8017dd:	d3 ef                	shr    %cl,%edi
  8017df:	09 c7                	or     %eax,%edi
  8017e1:	89 e9                	mov    %ebp,%ecx
  8017e3:	d3 e2                	shl    %cl,%edx
  8017e5:	89 14 24             	mov    %edx,(%esp)
  8017e8:	89 d8                	mov    %ebx,%eax
  8017ea:	d3 e0                	shl    %cl,%eax
  8017ec:	89 c2                	mov    %eax,%edx
  8017ee:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017f2:	d3 e0                	shl    %cl,%eax
  8017f4:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017f8:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017fc:	89 f1                	mov    %esi,%ecx
  8017fe:	d3 e8                	shr    %cl,%eax
  801800:	09 d0                	or     %edx,%eax
  801802:	d3 eb                	shr    %cl,%ebx
  801804:	89 da                	mov    %ebx,%edx
  801806:	f7 f7                	div    %edi
  801808:	89 d3                	mov    %edx,%ebx
  80180a:	f7 24 24             	mull   (%esp)
  80180d:	89 c6                	mov    %eax,%esi
  80180f:	89 d1                	mov    %edx,%ecx
  801811:	39 d3                	cmp    %edx,%ebx
  801813:	0f 82 87 00 00 00    	jb     8018a0 <__umoddi3+0x134>
  801819:	0f 84 91 00 00 00    	je     8018b0 <__umoddi3+0x144>
  80181f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801823:	29 f2                	sub    %esi,%edx
  801825:	19 cb                	sbb    %ecx,%ebx
  801827:	89 d8                	mov    %ebx,%eax
  801829:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80182d:	d3 e0                	shl    %cl,%eax
  80182f:	89 e9                	mov    %ebp,%ecx
  801831:	d3 ea                	shr    %cl,%edx
  801833:	09 d0                	or     %edx,%eax
  801835:	89 e9                	mov    %ebp,%ecx
  801837:	d3 eb                	shr    %cl,%ebx
  801839:	89 da                	mov    %ebx,%edx
  80183b:	83 c4 1c             	add    $0x1c,%esp
  80183e:	5b                   	pop    %ebx
  80183f:	5e                   	pop    %esi
  801840:	5f                   	pop    %edi
  801841:	5d                   	pop    %ebp
  801842:	c3                   	ret    
  801843:	90                   	nop
  801844:	89 fd                	mov    %edi,%ebp
  801846:	85 ff                	test   %edi,%edi
  801848:	75 0b                	jne    801855 <__umoddi3+0xe9>
  80184a:	b8 01 00 00 00       	mov    $0x1,%eax
  80184f:	31 d2                	xor    %edx,%edx
  801851:	f7 f7                	div    %edi
  801853:	89 c5                	mov    %eax,%ebp
  801855:	89 f0                	mov    %esi,%eax
  801857:	31 d2                	xor    %edx,%edx
  801859:	f7 f5                	div    %ebp
  80185b:	89 c8                	mov    %ecx,%eax
  80185d:	f7 f5                	div    %ebp
  80185f:	89 d0                	mov    %edx,%eax
  801861:	e9 44 ff ff ff       	jmp    8017aa <__umoddi3+0x3e>
  801866:	66 90                	xchg   %ax,%ax
  801868:	89 c8                	mov    %ecx,%eax
  80186a:	89 f2                	mov    %esi,%edx
  80186c:	83 c4 1c             	add    $0x1c,%esp
  80186f:	5b                   	pop    %ebx
  801870:	5e                   	pop    %esi
  801871:	5f                   	pop    %edi
  801872:	5d                   	pop    %ebp
  801873:	c3                   	ret    
  801874:	3b 04 24             	cmp    (%esp),%eax
  801877:	72 06                	jb     80187f <__umoddi3+0x113>
  801879:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  80187d:	77 0f                	ja     80188e <__umoddi3+0x122>
  80187f:	89 f2                	mov    %esi,%edx
  801881:	29 f9                	sub    %edi,%ecx
  801883:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801887:	89 14 24             	mov    %edx,(%esp)
  80188a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80188e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801892:	8b 14 24             	mov    (%esp),%edx
  801895:	83 c4 1c             	add    $0x1c,%esp
  801898:	5b                   	pop    %ebx
  801899:	5e                   	pop    %esi
  80189a:	5f                   	pop    %edi
  80189b:	5d                   	pop    %ebp
  80189c:	c3                   	ret    
  80189d:	8d 76 00             	lea    0x0(%esi),%esi
  8018a0:	2b 04 24             	sub    (%esp),%eax
  8018a3:	19 fa                	sbb    %edi,%edx
  8018a5:	89 d1                	mov    %edx,%ecx
  8018a7:	89 c6                	mov    %eax,%esi
  8018a9:	e9 71 ff ff ff       	jmp    80181f <__umoddi3+0xb3>
  8018ae:	66 90                	xchg   %ax,%ax
  8018b0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018b4:	72 ea                	jb     8018a0 <__umoddi3+0x134>
  8018b6:	89 d9                	mov    %ebx,%ecx
  8018b8:	e9 62 ff ff ff       	jmp    80181f <__umoddi3+0xb3>
