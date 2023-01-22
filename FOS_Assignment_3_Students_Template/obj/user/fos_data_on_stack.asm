
obj/user/fos_data_on_stack:     file format elf32-i386


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
  800031:	e8 1e 00 00 00       	call   800054 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 48 27 00 00    	sub    $0x2748,%esp
	/// Adding array of 512 integer on user stack
	int arr[2512];

	atomic_cprintf("user stack contains 512 integer\n");
  800041:	83 ec 0c             	sub    $0xc,%esp
  800044:	68 c0 18 80 00       	push   $0x8018c0
  800049:	e8 23 02 00 00       	call   800271 <atomic_cprintf>
  80004e:	83 c4 10             	add    $0x10,%esp

	return;	
  800051:	90                   	nop
}
  800052:	c9                   	leave  
  800053:	c3                   	ret    

00800054 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800054:	55                   	push   %ebp
  800055:	89 e5                	mov    %esp,%ebp
  800057:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80005a:	e8 10 10 00 00       	call   80106f <sys_getenvindex>
  80005f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800062:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800065:	89 d0                	mov    %edx,%eax
  800067:	01 c0                	add    %eax,%eax
  800069:	01 d0                	add    %edx,%eax
  80006b:	c1 e0 04             	shl    $0x4,%eax
  80006e:	29 d0                	sub    %edx,%eax
  800070:	c1 e0 03             	shl    $0x3,%eax
  800073:	01 d0                	add    %edx,%eax
  800075:	c1 e0 02             	shl    $0x2,%eax
  800078:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80007d:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800082:	a1 20 20 80 00       	mov    0x802020,%eax
  800087:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80008d:	84 c0                	test   %al,%al
  80008f:	74 0f                	je     8000a0 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800091:	a1 20 20 80 00       	mov    0x802020,%eax
  800096:	05 5c 05 00 00       	add    $0x55c,%eax
  80009b:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000a0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000a4:	7e 0a                	jle    8000b0 <libmain+0x5c>
		binaryname = argv[0];
  8000a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000a9:	8b 00                	mov    (%eax),%eax
  8000ab:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000b0:	83 ec 08             	sub    $0x8,%esp
  8000b3:	ff 75 0c             	pushl  0xc(%ebp)
  8000b6:	ff 75 08             	pushl  0x8(%ebp)
  8000b9:	e8 7a ff ff ff       	call   800038 <_main>
  8000be:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000c1:	e8 44 11 00 00       	call   80120a <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000c6:	83 ec 0c             	sub    $0xc,%esp
  8000c9:	68 fc 18 80 00       	push   $0x8018fc
  8000ce:	e8 71 01 00 00       	call   800244 <cprintf>
  8000d3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000d6:	a1 20 20 80 00       	mov    0x802020,%eax
  8000db:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8000e1:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e6:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8000ec:	83 ec 04             	sub    $0x4,%esp
  8000ef:	52                   	push   %edx
  8000f0:	50                   	push   %eax
  8000f1:	68 24 19 80 00       	push   $0x801924
  8000f6:	e8 49 01 00 00       	call   800244 <cprintf>
  8000fb:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8000fe:	a1 20 20 80 00       	mov    0x802020,%eax
  800103:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800109:	a1 20 20 80 00       	mov    0x802020,%eax
  80010e:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800114:	a1 20 20 80 00       	mov    0x802020,%eax
  800119:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80011f:	51                   	push   %ecx
  800120:	52                   	push   %edx
  800121:	50                   	push   %eax
  800122:	68 4c 19 80 00       	push   $0x80194c
  800127:	e8 18 01 00 00       	call   800244 <cprintf>
  80012c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80012f:	83 ec 0c             	sub    $0xc,%esp
  800132:	68 fc 18 80 00       	push   $0x8018fc
  800137:	e8 08 01 00 00       	call   800244 <cprintf>
  80013c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80013f:	e8 e0 10 00 00       	call   801224 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800144:	e8 19 00 00 00       	call   800162 <exit>
}
  800149:	90                   	nop
  80014a:	c9                   	leave  
  80014b:	c3                   	ret    

0080014c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80014c:	55                   	push   %ebp
  80014d:	89 e5                	mov    %esp,%ebp
  80014f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800152:	83 ec 0c             	sub    $0xc,%esp
  800155:	6a 00                	push   $0x0
  800157:	e8 df 0e 00 00       	call   80103b <sys_env_destroy>
  80015c:	83 c4 10             	add    $0x10,%esp
}
  80015f:	90                   	nop
  800160:	c9                   	leave  
  800161:	c3                   	ret    

00800162 <exit>:

void
exit(void)
{
  800162:	55                   	push   %ebp
  800163:	89 e5                	mov    %esp,%ebp
  800165:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800168:	e8 34 0f 00 00       	call   8010a1 <sys_env_exit>
}
  80016d:	90                   	nop
  80016e:	c9                   	leave  
  80016f:	c3                   	ret    

00800170 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800170:	55                   	push   %ebp
  800171:	89 e5                	mov    %esp,%ebp
  800173:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800176:	8b 45 0c             	mov    0xc(%ebp),%eax
  800179:	8b 00                	mov    (%eax),%eax
  80017b:	8d 48 01             	lea    0x1(%eax),%ecx
  80017e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800181:	89 0a                	mov    %ecx,(%edx)
  800183:	8b 55 08             	mov    0x8(%ebp),%edx
  800186:	88 d1                	mov    %dl,%cl
  800188:	8b 55 0c             	mov    0xc(%ebp),%edx
  80018b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80018f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800192:	8b 00                	mov    (%eax),%eax
  800194:	3d ff 00 00 00       	cmp    $0xff,%eax
  800199:	75 2c                	jne    8001c7 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80019b:	a0 24 20 80 00       	mov    0x802024,%al
  8001a0:	0f b6 c0             	movzbl %al,%eax
  8001a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001a6:	8b 12                	mov    (%edx),%edx
  8001a8:	89 d1                	mov    %edx,%ecx
  8001aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ad:	83 c2 08             	add    $0x8,%edx
  8001b0:	83 ec 04             	sub    $0x4,%esp
  8001b3:	50                   	push   %eax
  8001b4:	51                   	push   %ecx
  8001b5:	52                   	push   %edx
  8001b6:	e8 3e 0e 00 00       	call   800ff9 <sys_cputs>
  8001bb:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ca:	8b 40 04             	mov    0x4(%eax),%eax
  8001cd:	8d 50 01             	lea    0x1(%eax),%edx
  8001d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001d6:	90                   	nop
  8001d7:	c9                   	leave  
  8001d8:	c3                   	ret    

008001d9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001d9:	55                   	push   %ebp
  8001da:	89 e5                	mov    %esp,%ebp
  8001dc:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001e2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001e9:	00 00 00 
	b.cnt = 0;
  8001ec:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001f3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001f6:	ff 75 0c             	pushl  0xc(%ebp)
  8001f9:	ff 75 08             	pushl  0x8(%ebp)
  8001fc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800202:	50                   	push   %eax
  800203:	68 70 01 80 00       	push   $0x800170
  800208:	e8 11 02 00 00       	call   80041e <vprintfmt>
  80020d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800210:	a0 24 20 80 00       	mov    0x802024,%al
  800215:	0f b6 c0             	movzbl %al,%eax
  800218:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80021e:	83 ec 04             	sub    $0x4,%esp
  800221:	50                   	push   %eax
  800222:	52                   	push   %edx
  800223:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800229:	83 c0 08             	add    $0x8,%eax
  80022c:	50                   	push   %eax
  80022d:	e8 c7 0d 00 00       	call   800ff9 <sys_cputs>
  800232:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800235:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80023c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800242:	c9                   	leave  
  800243:	c3                   	ret    

00800244 <cprintf>:

int cprintf(const char *fmt, ...) {
  800244:	55                   	push   %ebp
  800245:	89 e5                	mov    %esp,%ebp
  800247:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80024a:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800251:	8d 45 0c             	lea    0xc(%ebp),%eax
  800254:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800257:	8b 45 08             	mov    0x8(%ebp),%eax
  80025a:	83 ec 08             	sub    $0x8,%esp
  80025d:	ff 75 f4             	pushl  -0xc(%ebp)
  800260:	50                   	push   %eax
  800261:	e8 73 ff ff ff       	call   8001d9 <vcprintf>
  800266:	83 c4 10             	add    $0x10,%esp
  800269:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80026c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80026f:	c9                   	leave  
  800270:	c3                   	ret    

00800271 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800271:	55                   	push   %ebp
  800272:	89 e5                	mov    %esp,%ebp
  800274:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800277:	e8 8e 0f 00 00       	call   80120a <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80027c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80027f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800282:	8b 45 08             	mov    0x8(%ebp),%eax
  800285:	83 ec 08             	sub    $0x8,%esp
  800288:	ff 75 f4             	pushl  -0xc(%ebp)
  80028b:	50                   	push   %eax
  80028c:	e8 48 ff ff ff       	call   8001d9 <vcprintf>
  800291:	83 c4 10             	add    $0x10,%esp
  800294:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800297:	e8 88 0f 00 00       	call   801224 <sys_enable_interrupt>
	return cnt;
  80029c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80029f:	c9                   	leave  
  8002a0:	c3                   	ret    

008002a1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002a1:	55                   	push   %ebp
  8002a2:	89 e5                	mov    %esp,%ebp
  8002a4:	53                   	push   %ebx
  8002a5:	83 ec 14             	sub    $0x14,%esp
  8002a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002ae:	8b 45 14             	mov    0x14(%ebp),%eax
  8002b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002b4:	8b 45 18             	mov    0x18(%ebp),%eax
  8002b7:	ba 00 00 00 00       	mov    $0x0,%edx
  8002bc:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002bf:	77 55                	ja     800316 <printnum+0x75>
  8002c1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002c4:	72 05                	jb     8002cb <printnum+0x2a>
  8002c6:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002c9:	77 4b                	ja     800316 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002cb:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002ce:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002d1:	8b 45 18             	mov    0x18(%ebp),%eax
  8002d4:	ba 00 00 00 00       	mov    $0x0,%edx
  8002d9:	52                   	push   %edx
  8002da:	50                   	push   %eax
  8002db:	ff 75 f4             	pushl  -0xc(%ebp)
  8002de:	ff 75 f0             	pushl  -0x10(%ebp)
  8002e1:	e8 62 13 00 00       	call   801648 <__udivdi3>
  8002e6:	83 c4 10             	add    $0x10,%esp
  8002e9:	83 ec 04             	sub    $0x4,%esp
  8002ec:	ff 75 20             	pushl  0x20(%ebp)
  8002ef:	53                   	push   %ebx
  8002f0:	ff 75 18             	pushl  0x18(%ebp)
  8002f3:	52                   	push   %edx
  8002f4:	50                   	push   %eax
  8002f5:	ff 75 0c             	pushl  0xc(%ebp)
  8002f8:	ff 75 08             	pushl  0x8(%ebp)
  8002fb:	e8 a1 ff ff ff       	call   8002a1 <printnum>
  800300:	83 c4 20             	add    $0x20,%esp
  800303:	eb 1a                	jmp    80031f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800305:	83 ec 08             	sub    $0x8,%esp
  800308:	ff 75 0c             	pushl  0xc(%ebp)
  80030b:	ff 75 20             	pushl  0x20(%ebp)
  80030e:	8b 45 08             	mov    0x8(%ebp),%eax
  800311:	ff d0                	call   *%eax
  800313:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800316:	ff 4d 1c             	decl   0x1c(%ebp)
  800319:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80031d:	7f e6                	jg     800305 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80031f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800322:	bb 00 00 00 00       	mov    $0x0,%ebx
  800327:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80032d:	53                   	push   %ebx
  80032e:	51                   	push   %ecx
  80032f:	52                   	push   %edx
  800330:	50                   	push   %eax
  800331:	e8 22 14 00 00       	call   801758 <__umoddi3>
  800336:	83 c4 10             	add    $0x10,%esp
  800339:	05 d4 1b 80 00       	add    $0x801bd4,%eax
  80033e:	8a 00                	mov    (%eax),%al
  800340:	0f be c0             	movsbl %al,%eax
  800343:	83 ec 08             	sub    $0x8,%esp
  800346:	ff 75 0c             	pushl  0xc(%ebp)
  800349:	50                   	push   %eax
  80034a:	8b 45 08             	mov    0x8(%ebp),%eax
  80034d:	ff d0                	call   *%eax
  80034f:	83 c4 10             	add    $0x10,%esp
}
  800352:	90                   	nop
  800353:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800356:	c9                   	leave  
  800357:	c3                   	ret    

00800358 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800358:	55                   	push   %ebp
  800359:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80035b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80035f:	7e 1c                	jle    80037d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800361:	8b 45 08             	mov    0x8(%ebp),%eax
  800364:	8b 00                	mov    (%eax),%eax
  800366:	8d 50 08             	lea    0x8(%eax),%edx
  800369:	8b 45 08             	mov    0x8(%ebp),%eax
  80036c:	89 10                	mov    %edx,(%eax)
  80036e:	8b 45 08             	mov    0x8(%ebp),%eax
  800371:	8b 00                	mov    (%eax),%eax
  800373:	83 e8 08             	sub    $0x8,%eax
  800376:	8b 50 04             	mov    0x4(%eax),%edx
  800379:	8b 00                	mov    (%eax),%eax
  80037b:	eb 40                	jmp    8003bd <getuint+0x65>
	else if (lflag)
  80037d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800381:	74 1e                	je     8003a1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800383:	8b 45 08             	mov    0x8(%ebp),%eax
  800386:	8b 00                	mov    (%eax),%eax
  800388:	8d 50 04             	lea    0x4(%eax),%edx
  80038b:	8b 45 08             	mov    0x8(%ebp),%eax
  80038e:	89 10                	mov    %edx,(%eax)
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	8b 00                	mov    (%eax),%eax
  800395:	83 e8 04             	sub    $0x4,%eax
  800398:	8b 00                	mov    (%eax),%eax
  80039a:	ba 00 00 00 00       	mov    $0x0,%edx
  80039f:	eb 1c                	jmp    8003bd <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	8b 00                	mov    (%eax),%eax
  8003a6:	8d 50 04             	lea    0x4(%eax),%edx
  8003a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ac:	89 10                	mov    %edx,(%eax)
  8003ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b1:	8b 00                	mov    (%eax),%eax
  8003b3:	83 e8 04             	sub    $0x4,%eax
  8003b6:	8b 00                	mov    (%eax),%eax
  8003b8:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003bd:	5d                   	pop    %ebp
  8003be:	c3                   	ret    

008003bf <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003bf:	55                   	push   %ebp
  8003c0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003c6:	7e 1c                	jle    8003e4 <getint+0x25>
		return va_arg(*ap, long long);
  8003c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cb:	8b 00                	mov    (%eax),%eax
  8003cd:	8d 50 08             	lea    0x8(%eax),%edx
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	89 10                	mov    %edx,(%eax)
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	8b 00                	mov    (%eax),%eax
  8003da:	83 e8 08             	sub    $0x8,%eax
  8003dd:	8b 50 04             	mov    0x4(%eax),%edx
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	eb 38                	jmp    80041c <getint+0x5d>
	else if (lflag)
  8003e4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003e8:	74 1a                	je     800404 <getint+0x45>
		return va_arg(*ap, long);
  8003ea:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ed:	8b 00                	mov    (%eax),%eax
  8003ef:	8d 50 04             	lea    0x4(%eax),%edx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	89 10                	mov    %edx,(%eax)
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	8b 00                	mov    (%eax),%eax
  8003fc:	83 e8 04             	sub    $0x4,%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	99                   	cltd   
  800402:	eb 18                	jmp    80041c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	8b 00                	mov    (%eax),%eax
  800409:	8d 50 04             	lea    0x4(%eax),%edx
  80040c:	8b 45 08             	mov    0x8(%ebp),%eax
  80040f:	89 10                	mov    %edx,(%eax)
  800411:	8b 45 08             	mov    0x8(%ebp),%eax
  800414:	8b 00                	mov    (%eax),%eax
  800416:	83 e8 04             	sub    $0x4,%eax
  800419:	8b 00                	mov    (%eax),%eax
  80041b:	99                   	cltd   
}
  80041c:	5d                   	pop    %ebp
  80041d:	c3                   	ret    

0080041e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80041e:	55                   	push   %ebp
  80041f:	89 e5                	mov    %esp,%ebp
  800421:	56                   	push   %esi
  800422:	53                   	push   %ebx
  800423:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800426:	eb 17                	jmp    80043f <vprintfmt+0x21>
			if (ch == '\0')
  800428:	85 db                	test   %ebx,%ebx
  80042a:	0f 84 af 03 00 00    	je     8007df <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800430:	83 ec 08             	sub    $0x8,%esp
  800433:	ff 75 0c             	pushl  0xc(%ebp)
  800436:	53                   	push   %ebx
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	ff d0                	call   *%eax
  80043c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80043f:	8b 45 10             	mov    0x10(%ebp),%eax
  800442:	8d 50 01             	lea    0x1(%eax),%edx
  800445:	89 55 10             	mov    %edx,0x10(%ebp)
  800448:	8a 00                	mov    (%eax),%al
  80044a:	0f b6 d8             	movzbl %al,%ebx
  80044d:	83 fb 25             	cmp    $0x25,%ebx
  800450:	75 d6                	jne    800428 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800452:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800456:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80045d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800464:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80046b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800472:	8b 45 10             	mov    0x10(%ebp),%eax
  800475:	8d 50 01             	lea    0x1(%eax),%edx
  800478:	89 55 10             	mov    %edx,0x10(%ebp)
  80047b:	8a 00                	mov    (%eax),%al
  80047d:	0f b6 d8             	movzbl %al,%ebx
  800480:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800483:	83 f8 55             	cmp    $0x55,%eax
  800486:	0f 87 2b 03 00 00    	ja     8007b7 <vprintfmt+0x399>
  80048c:	8b 04 85 f8 1b 80 00 	mov    0x801bf8(,%eax,4),%eax
  800493:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800495:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800499:	eb d7                	jmp    800472 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80049b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80049f:	eb d1                	jmp    800472 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004a1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004a8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004ab:	89 d0                	mov    %edx,%eax
  8004ad:	c1 e0 02             	shl    $0x2,%eax
  8004b0:	01 d0                	add    %edx,%eax
  8004b2:	01 c0                	add    %eax,%eax
  8004b4:	01 d8                	add    %ebx,%eax
  8004b6:	83 e8 30             	sub    $0x30,%eax
  8004b9:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bf:	8a 00                	mov    (%eax),%al
  8004c1:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004c4:	83 fb 2f             	cmp    $0x2f,%ebx
  8004c7:	7e 3e                	jle    800507 <vprintfmt+0xe9>
  8004c9:	83 fb 39             	cmp    $0x39,%ebx
  8004cc:	7f 39                	jg     800507 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004ce:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004d1:	eb d5                	jmp    8004a8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d6:	83 c0 04             	add    $0x4,%eax
  8004d9:	89 45 14             	mov    %eax,0x14(%ebp)
  8004dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8004df:	83 e8 04             	sub    $0x4,%eax
  8004e2:	8b 00                	mov    (%eax),%eax
  8004e4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004e7:	eb 1f                	jmp    800508 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004e9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004ed:	79 83                	jns    800472 <vprintfmt+0x54>
				width = 0;
  8004ef:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004f6:	e9 77 ff ff ff       	jmp    800472 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8004fb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800502:	e9 6b ff ff ff       	jmp    800472 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800507:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800508:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80050c:	0f 89 60 ff ff ff    	jns    800472 <vprintfmt+0x54>
				width = precision, precision = -1;
  800512:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800515:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800518:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80051f:	e9 4e ff ff ff       	jmp    800472 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800524:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800527:	e9 46 ff ff ff       	jmp    800472 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80052c:	8b 45 14             	mov    0x14(%ebp),%eax
  80052f:	83 c0 04             	add    $0x4,%eax
  800532:	89 45 14             	mov    %eax,0x14(%ebp)
  800535:	8b 45 14             	mov    0x14(%ebp),%eax
  800538:	83 e8 04             	sub    $0x4,%eax
  80053b:	8b 00                	mov    (%eax),%eax
  80053d:	83 ec 08             	sub    $0x8,%esp
  800540:	ff 75 0c             	pushl  0xc(%ebp)
  800543:	50                   	push   %eax
  800544:	8b 45 08             	mov    0x8(%ebp),%eax
  800547:	ff d0                	call   *%eax
  800549:	83 c4 10             	add    $0x10,%esp
			break;
  80054c:	e9 89 02 00 00       	jmp    8007da <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800551:	8b 45 14             	mov    0x14(%ebp),%eax
  800554:	83 c0 04             	add    $0x4,%eax
  800557:	89 45 14             	mov    %eax,0x14(%ebp)
  80055a:	8b 45 14             	mov    0x14(%ebp),%eax
  80055d:	83 e8 04             	sub    $0x4,%eax
  800560:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800562:	85 db                	test   %ebx,%ebx
  800564:	79 02                	jns    800568 <vprintfmt+0x14a>
				err = -err;
  800566:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800568:	83 fb 64             	cmp    $0x64,%ebx
  80056b:	7f 0b                	jg     800578 <vprintfmt+0x15a>
  80056d:	8b 34 9d 40 1a 80 00 	mov    0x801a40(,%ebx,4),%esi
  800574:	85 f6                	test   %esi,%esi
  800576:	75 19                	jne    800591 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800578:	53                   	push   %ebx
  800579:	68 e5 1b 80 00       	push   $0x801be5
  80057e:	ff 75 0c             	pushl  0xc(%ebp)
  800581:	ff 75 08             	pushl  0x8(%ebp)
  800584:	e8 5e 02 00 00       	call   8007e7 <printfmt>
  800589:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80058c:	e9 49 02 00 00       	jmp    8007da <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800591:	56                   	push   %esi
  800592:	68 ee 1b 80 00       	push   $0x801bee
  800597:	ff 75 0c             	pushl  0xc(%ebp)
  80059a:	ff 75 08             	pushl  0x8(%ebp)
  80059d:	e8 45 02 00 00       	call   8007e7 <printfmt>
  8005a2:	83 c4 10             	add    $0x10,%esp
			break;
  8005a5:	e9 30 02 00 00       	jmp    8007da <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ad:	83 c0 04             	add    $0x4,%eax
  8005b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b6:	83 e8 04             	sub    $0x4,%eax
  8005b9:	8b 30                	mov    (%eax),%esi
  8005bb:	85 f6                	test   %esi,%esi
  8005bd:	75 05                	jne    8005c4 <vprintfmt+0x1a6>
				p = "(null)";
  8005bf:	be f1 1b 80 00       	mov    $0x801bf1,%esi
			if (width > 0 && padc != '-')
  8005c4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c8:	7e 6d                	jle    800637 <vprintfmt+0x219>
  8005ca:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005ce:	74 67                	je     800637 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d3:	83 ec 08             	sub    $0x8,%esp
  8005d6:	50                   	push   %eax
  8005d7:	56                   	push   %esi
  8005d8:	e8 0c 03 00 00       	call   8008e9 <strnlen>
  8005dd:	83 c4 10             	add    $0x10,%esp
  8005e0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005e3:	eb 16                	jmp    8005fb <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005e5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005e9:	83 ec 08             	sub    $0x8,%esp
  8005ec:	ff 75 0c             	pushl  0xc(%ebp)
  8005ef:	50                   	push   %eax
  8005f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f3:	ff d0                	call   *%eax
  8005f5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005f8:	ff 4d e4             	decl   -0x1c(%ebp)
  8005fb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005ff:	7f e4                	jg     8005e5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800601:	eb 34                	jmp    800637 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800603:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800607:	74 1c                	je     800625 <vprintfmt+0x207>
  800609:	83 fb 1f             	cmp    $0x1f,%ebx
  80060c:	7e 05                	jle    800613 <vprintfmt+0x1f5>
  80060e:	83 fb 7e             	cmp    $0x7e,%ebx
  800611:	7e 12                	jle    800625 <vprintfmt+0x207>
					putch('?', putdat);
  800613:	83 ec 08             	sub    $0x8,%esp
  800616:	ff 75 0c             	pushl  0xc(%ebp)
  800619:	6a 3f                	push   $0x3f
  80061b:	8b 45 08             	mov    0x8(%ebp),%eax
  80061e:	ff d0                	call   *%eax
  800620:	83 c4 10             	add    $0x10,%esp
  800623:	eb 0f                	jmp    800634 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800625:	83 ec 08             	sub    $0x8,%esp
  800628:	ff 75 0c             	pushl  0xc(%ebp)
  80062b:	53                   	push   %ebx
  80062c:	8b 45 08             	mov    0x8(%ebp),%eax
  80062f:	ff d0                	call   *%eax
  800631:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800634:	ff 4d e4             	decl   -0x1c(%ebp)
  800637:	89 f0                	mov    %esi,%eax
  800639:	8d 70 01             	lea    0x1(%eax),%esi
  80063c:	8a 00                	mov    (%eax),%al
  80063e:	0f be d8             	movsbl %al,%ebx
  800641:	85 db                	test   %ebx,%ebx
  800643:	74 24                	je     800669 <vprintfmt+0x24b>
  800645:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800649:	78 b8                	js     800603 <vprintfmt+0x1e5>
  80064b:	ff 4d e0             	decl   -0x20(%ebp)
  80064e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800652:	79 af                	jns    800603 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800654:	eb 13                	jmp    800669 <vprintfmt+0x24b>
				putch(' ', putdat);
  800656:	83 ec 08             	sub    $0x8,%esp
  800659:	ff 75 0c             	pushl  0xc(%ebp)
  80065c:	6a 20                	push   $0x20
  80065e:	8b 45 08             	mov    0x8(%ebp),%eax
  800661:	ff d0                	call   *%eax
  800663:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800666:	ff 4d e4             	decl   -0x1c(%ebp)
  800669:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066d:	7f e7                	jg     800656 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80066f:	e9 66 01 00 00       	jmp    8007da <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800674:	83 ec 08             	sub    $0x8,%esp
  800677:	ff 75 e8             	pushl  -0x18(%ebp)
  80067a:	8d 45 14             	lea    0x14(%ebp),%eax
  80067d:	50                   	push   %eax
  80067e:	e8 3c fd ff ff       	call   8003bf <getint>
  800683:	83 c4 10             	add    $0x10,%esp
  800686:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800689:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80068c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80068f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800692:	85 d2                	test   %edx,%edx
  800694:	79 23                	jns    8006b9 <vprintfmt+0x29b>
				putch('-', putdat);
  800696:	83 ec 08             	sub    $0x8,%esp
  800699:	ff 75 0c             	pushl  0xc(%ebp)
  80069c:	6a 2d                	push   $0x2d
  80069e:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a1:	ff d0                	call   *%eax
  8006a3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ac:	f7 d8                	neg    %eax
  8006ae:	83 d2 00             	adc    $0x0,%edx
  8006b1:	f7 da                	neg    %edx
  8006b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006b6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006b9:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006c0:	e9 bc 00 00 00       	jmp    800781 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006c5:	83 ec 08             	sub    $0x8,%esp
  8006c8:	ff 75 e8             	pushl  -0x18(%ebp)
  8006cb:	8d 45 14             	lea    0x14(%ebp),%eax
  8006ce:	50                   	push   %eax
  8006cf:	e8 84 fc ff ff       	call   800358 <getuint>
  8006d4:	83 c4 10             	add    $0x10,%esp
  8006d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006da:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006dd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006e4:	e9 98 00 00 00       	jmp    800781 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006e9:	83 ec 08             	sub    $0x8,%esp
  8006ec:	ff 75 0c             	pushl  0xc(%ebp)
  8006ef:	6a 58                	push   $0x58
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	ff d0                	call   *%eax
  8006f6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006f9:	83 ec 08             	sub    $0x8,%esp
  8006fc:	ff 75 0c             	pushl  0xc(%ebp)
  8006ff:	6a 58                	push   $0x58
  800701:	8b 45 08             	mov    0x8(%ebp),%eax
  800704:	ff d0                	call   *%eax
  800706:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800709:	83 ec 08             	sub    $0x8,%esp
  80070c:	ff 75 0c             	pushl  0xc(%ebp)
  80070f:	6a 58                	push   $0x58
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	ff d0                	call   *%eax
  800716:	83 c4 10             	add    $0x10,%esp
			break;
  800719:	e9 bc 00 00 00       	jmp    8007da <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80071e:	83 ec 08             	sub    $0x8,%esp
  800721:	ff 75 0c             	pushl  0xc(%ebp)
  800724:	6a 30                	push   $0x30
  800726:	8b 45 08             	mov    0x8(%ebp),%eax
  800729:	ff d0                	call   *%eax
  80072b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80072e:	83 ec 08             	sub    $0x8,%esp
  800731:	ff 75 0c             	pushl  0xc(%ebp)
  800734:	6a 78                	push   $0x78
  800736:	8b 45 08             	mov    0x8(%ebp),%eax
  800739:	ff d0                	call   *%eax
  80073b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80073e:	8b 45 14             	mov    0x14(%ebp),%eax
  800741:	83 c0 04             	add    $0x4,%eax
  800744:	89 45 14             	mov    %eax,0x14(%ebp)
  800747:	8b 45 14             	mov    0x14(%ebp),%eax
  80074a:	83 e8 04             	sub    $0x4,%eax
  80074d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80074f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800752:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800759:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800760:	eb 1f                	jmp    800781 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800762:	83 ec 08             	sub    $0x8,%esp
  800765:	ff 75 e8             	pushl  -0x18(%ebp)
  800768:	8d 45 14             	lea    0x14(%ebp),%eax
  80076b:	50                   	push   %eax
  80076c:	e8 e7 fb ff ff       	call   800358 <getuint>
  800771:	83 c4 10             	add    $0x10,%esp
  800774:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800777:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80077a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800781:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800785:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800788:	83 ec 04             	sub    $0x4,%esp
  80078b:	52                   	push   %edx
  80078c:	ff 75 e4             	pushl  -0x1c(%ebp)
  80078f:	50                   	push   %eax
  800790:	ff 75 f4             	pushl  -0xc(%ebp)
  800793:	ff 75 f0             	pushl  -0x10(%ebp)
  800796:	ff 75 0c             	pushl  0xc(%ebp)
  800799:	ff 75 08             	pushl  0x8(%ebp)
  80079c:	e8 00 fb ff ff       	call   8002a1 <printnum>
  8007a1:	83 c4 20             	add    $0x20,%esp
			break;
  8007a4:	eb 34                	jmp    8007da <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007a6:	83 ec 08             	sub    $0x8,%esp
  8007a9:	ff 75 0c             	pushl  0xc(%ebp)
  8007ac:	53                   	push   %ebx
  8007ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b0:	ff d0                	call   *%eax
  8007b2:	83 c4 10             	add    $0x10,%esp
			break;
  8007b5:	eb 23                	jmp    8007da <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007b7:	83 ec 08             	sub    $0x8,%esp
  8007ba:	ff 75 0c             	pushl  0xc(%ebp)
  8007bd:	6a 25                	push   $0x25
  8007bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c2:	ff d0                	call   *%eax
  8007c4:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007c7:	ff 4d 10             	decl   0x10(%ebp)
  8007ca:	eb 03                	jmp    8007cf <vprintfmt+0x3b1>
  8007cc:	ff 4d 10             	decl   0x10(%ebp)
  8007cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8007d2:	48                   	dec    %eax
  8007d3:	8a 00                	mov    (%eax),%al
  8007d5:	3c 25                	cmp    $0x25,%al
  8007d7:	75 f3                	jne    8007cc <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007d9:	90                   	nop
		}
	}
  8007da:	e9 47 fc ff ff       	jmp    800426 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007df:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007e0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007e3:	5b                   	pop    %ebx
  8007e4:	5e                   	pop    %esi
  8007e5:	5d                   	pop    %ebp
  8007e6:	c3                   	ret    

008007e7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007e7:	55                   	push   %ebp
  8007e8:	89 e5                	mov    %esp,%ebp
  8007ea:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007ed:	8d 45 10             	lea    0x10(%ebp),%eax
  8007f0:	83 c0 04             	add    $0x4,%eax
  8007f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f9:	ff 75 f4             	pushl  -0xc(%ebp)
  8007fc:	50                   	push   %eax
  8007fd:	ff 75 0c             	pushl  0xc(%ebp)
  800800:	ff 75 08             	pushl  0x8(%ebp)
  800803:	e8 16 fc ff ff       	call   80041e <vprintfmt>
  800808:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80080b:	90                   	nop
  80080c:	c9                   	leave  
  80080d:	c3                   	ret    

0080080e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80080e:	55                   	push   %ebp
  80080f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800811:	8b 45 0c             	mov    0xc(%ebp),%eax
  800814:	8b 40 08             	mov    0x8(%eax),%eax
  800817:	8d 50 01             	lea    0x1(%eax),%edx
  80081a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800820:	8b 45 0c             	mov    0xc(%ebp),%eax
  800823:	8b 10                	mov    (%eax),%edx
  800825:	8b 45 0c             	mov    0xc(%ebp),%eax
  800828:	8b 40 04             	mov    0x4(%eax),%eax
  80082b:	39 c2                	cmp    %eax,%edx
  80082d:	73 12                	jae    800841 <sprintputch+0x33>
		*b->buf++ = ch;
  80082f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800832:	8b 00                	mov    (%eax),%eax
  800834:	8d 48 01             	lea    0x1(%eax),%ecx
  800837:	8b 55 0c             	mov    0xc(%ebp),%edx
  80083a:	89 0a                	mov    %ecx,(%edx)
  80083c:	8b 55 08             	mov    0x8(%ebp),%edx
  80083f:	88 10                	mov    %dl,(%eax)
}
  800841:	90                   	nop
  800842:	5d                   	pop    %ebp
  800843:	c3                   	ret    

00800844 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800844:	55                   	push   %ebp
  800845:	89 e5                	mov    %esp,%ebp
  800847:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80084a:	8b 45 08             	mov    0x8(%ebp),%eax
  80084d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800850:	8b 45 0c             	mov    0xc(%ebp),%eax
  800853:	8d 50 ff             	lea    -0x1(%eax),%edx
  800856:	8b 45 08             	mov    0x8(%ebp),%eax
  800859:	01 d0                	add    %edx,%eax
  80085b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80085e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800865:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800869:	74 06                	je     800871 <vsnprintf+0x2d>
  80086b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80086f:	7f 07                	jg     800878 <vsnprintf+0x34>
		return -E_INVAL;
  800871:	b8 03 00 00 00       	mov    $0x3,%eax
  800876:	eb 20                	jmp    800898 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800878:	ff 75 14             	pushl  0x14(%ebp)
  80087b:	ff 75 10             	pushl  0x10(%ebp)
  80087e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800881:	50                   	push   %eax
  800882:	68 0e 08 80 00       	push   $0x80080e
  800887:	e8 92 fb ff ff       	call   80041e <vprintfmt>
  80088c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80088f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800892:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800895:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800898:	c9                   	leave  
  800899:	c3                   	ret    

0080089a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80089a:	55                   	push   %ebp
  80089b:	89 e5                	mov    %esp,%ebp
  80089d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008a0:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a3:	83 c0 04             	add    $0x4,%eax
  8008a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008a9:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8008af:	50                   	push   %eax
  8008b0:	ff 75 0c             	pushl  0xc(%ebp)
  8008b3:	ff 75 08             	pushl  0x8(%ebp)
  8008b6:	e8 89 ff ff ff       	call   800844 <vsnprintf>
  8008bb:	83 c4 10             	add    $0x10,%esp
  8008be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008c4:	c9                   	leave  
  8008c5:	c3                   	ret    

008008c6 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008c6:	55                   	push   %ebp
  8008c7:	89 e5                	mov    %esp,%ebp
  8008c9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008d3:	eb 06                	jmp    8008db <strlen+0x15>
		n++;
  8008d5:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008d8:	ff 45 08             	incl   0x8(%ebp)
  8008db:	8b 45 08             	mov    0x8(%ebp),%eax
  8008de:	8a 00                	mov    (%eax),%al
  8008e0:	84 c0                	test   %al,%al
  8008e2:	75 f1                	jne    8008d5 <strlen+0xf>
		n++;
	return n;
  8008e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008e7:	c9                   	leave  
  8008e8:	c3                   	ret    

008008e9 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008e9:	55                   	push   %ebp
  8008ea:	89 e5                	mov    %esp,%ebp
  8008ec:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008ef:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008f6:	eb 09                	jmp    800901 <strnlen+0x18>
		n++;
  8008f8:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008fb:	ff 45 08             	incl   0x8(%ebp)
  8008fe:	ff 4d 0c             	decl   0xc(%ebp)
  800901:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800905:	74 09                	je     800910 <strnlen+0x27>
  800907:	8b 45 08             	mov    0x8(%ebp),%eax
  80090a:	8a 00                	mov    (%eax),%al
  80090c:	84 c0                	test   %al,%al
  80090e:	75 e8                	jne    8008f8 <strnlen+0xf>
		n++;
	return n;
  800910:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800913:	c9                   	leave  
  800914:	c3                   	ret    

00800915 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800915:	55                   	push   %ebp
  800916:	89 e5                	mov    %esp,%ebp
  800918:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80091b:	8b 45 08             	mov    0x8(%ebp),%eax
  80091e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800921:	90                   	nop
  800922:	8b 45 08             	mov    0x8(%ebp),%eax
  800925:	8d 50 01             	lea    0x1(%eax),%edx
  800928:	89 55 08             	mov    %edx,0x8(%ebp)
  80092b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092e:	8d 4a 01             	lea    0x1(%edx),%ecx
  800931:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800934:	8a 12                	mov    (%edx),%dl
  800936:	88 10                	mov    %dl,(%eax)
  800938:	8a 00                	mov    (%eax),%al
  80093a:	84 c0                	test   %al,%al
  80093c:	75 e4                	jne    800922 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80093e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800941:	c9                   	leave  
  800942:	c3                   	ret    

00800943 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800943:	55                   	push   %ebp
  800944:	89 e5                	mov    %esp,%ebp
  800946:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80094f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800956:	eb 1f                	jmp    800977 <strncpy+0x34>
		*dst++ = *src;
  800958:	8b 45 08             	mov    0x8(%ebp),%eax
  80095b:	8d 50 01             	lea    0x1(%eax),%edx
  80095e:	89 55 08             	mov    %edx,0x8(%ebp)
  800961:	8b 55 0c             	mov    0xc(%ebp),%edx
  800964:	8a 12                	mov    (%edx),%dl
  800966:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800968:	8b 45 0c             	mov    0xc(%ebp),%eax
  80096b:	8a 00                	mov    (%eax),%al
  80096d:	84 c0                	test   %al,%al
  80096f:	74 03                	je     800974 <strncpy+0x31>
			src++;
  800971:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800974:	ff 45 fc             	incl   -0x4(%ebp)
  800977:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80097a:	3b 45 10             	cmp    0x10(%ebp),%eax
  80097d:	72 d9                	jb     800958 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80097f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800982:	c9                   	leave  
  800983:	c3                   	ret    

00800984 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800984:	55                   	push   %ebp
  800985:	89 e5                	mov    %esp,%ebp
  800987:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800990:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800994:	74 30                	je     8009c6 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800996:	eb 16                	jmp    8009ae <strlcpy+0x2a>
			*dst++ = *src++;
  800998:	8b 45 08             	mov    0x8(%ebp),%eax
  80099b:	8d 50 01             	lea    0x1(%eax),%edx
  80099e:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a4:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009a7:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009aa:	8a 12                	mov    (%edx),%dl
  8009ac:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009ae:	ff 4d 10             	decl   0x10(%ebp)
  8009b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009b5:	74 09                	je     8009c0 <strlcpy+0x3c>
  8009b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ba:	8a 00                	mov    (%eax),%al
  8009bc:	84 c0                	test   %al,%al
  8009be:	75 d8                	jne    800998 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c3:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009c6:	8b 55 08             	mov    0x8(%ebp),%edx
  8009c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009cc:	29 c2                	sub    %eax,%edx
  8009ce:	89 d0                	mov    %edx,%eax
}
  8009d0:	c9                   	leave  
  8009d1:	c3                   	ret    

008009d2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009d2:	55                   	push   %ebp
  8009d3:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009d5:	eb 06                	jmp    8009dd <strcmp+0xb>
		p++, q++;
  8009d7:	ff 45 08             	incl   0x8(%ebp)
  8009da:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e0:	8a 00                	mov    (%eax),%al
  8009e2:	84 c0                	test   %al,%al
  8009e4:	74 0e                	je     8009f4 <strcmp+0x22>
  8009e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e9:	8a 10                	mov    (%eax),%dl
  8009eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ee:	8a 00                	mov    (%eax),%al
  8009f0:	38 c2                	cmp    %al,%dl
  8009f2:	74 e3                	je     8009d7 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f7:	8a 00                	mov    (%eax),%al
  8009f9:	0f b6 d0             	movzbl %al,%edx
  8009fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ff:	8a 00                	mov    (%eax),%al
  800a01:	0f b6 c0             	movzbl %al,%eax
  800a04:	29 c2                	sub    %eax,%edx
  800a06:	89 d0                	mov    %edx,%eax
}
  800a08:	5d                   	pop    %ebp
  800a09:	c3                   	ret    

00800a0a <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a0a:	55                   	push   %ebp
  800a0b:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a0d:	eb 09                	jmp    800a18 <strncmp+0xe>
		n--, p++, q++;
  800a0f:	ff 4d 10             	decl   0x10(%ebp)
  800a12:	ff 45 08             	incl   0x8(%ebp)
  800a15:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a18:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a1c:	74 17                	je     800a35 <strncmp+0x2b>
  800a1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a21:	8a 00                	mov    (%eax),%al
  800a23:	84 c0                	test   %al,%al
  800a25:	74 0e                	je     800a35 <strncmp+0x2b>
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	8a 10                	mov    (%eax),%dl
  800a2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2f:	8a 00                	mov    (%eax),%al
  800a31:	38 c2                	cmp    %al,%dl
  800a33:	74 da                	je     800a0f <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a35:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a39:	75 07                	jne    800a42 <strncmp+0x38>
		return 0;
  800a3b:	b8 00 00 00 00       	mov    $0x0,%eax
  800a40:	eb 14                	jmp    800a56 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a42:	8b 45 08             	mov    0x8(%ebp),%eax
  800a45:	8a 00                	mov    (%eax),%al
  800a47:	0f b6 d0             	movzbl %al,%edx
  800a4a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4d:	8a 00                	mov    (%eax),%al
  800a4f:	0f b6 c0             	movzbl %al,%eax
  800a52:	29 c2                	sub    %eax,%edx
  800a54:	89 d0                	mov    %edx,%eax
}
  800a56:	5d                   	pop    %ebp
  800a57:	c3                   	ret    

00800a58 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a58:	55                   	push   %ebp
  800a59:	89 e5                	mov    %esp,%ebp
  800a5b:	83 ec 04             	sub    $0x4,%esp
  800a5e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a61:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a64:	eb 12                	jmp    800a78 <strchr+0x20>
		if (*s == c)
  800a66:	8b 45 08             	mov    0x8(%ebp),%eax
  800a69:	8a 00                	mov    (%eax),%al
  800a6b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a6e:	75 05                	jne    800a75 <strchr+0x1d>
			return (char *) s;
  800a70:	8b 45 08             	mov    0x8(%ebp),%eax
  800a73:	eb 11                	jmp    800a86 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a75:	ff 45 08             	incl   0x8(%ebp)
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	8a 00                	mov    (%eax),%al
  800a7d:	84 c0                	test   %al,%al
  800a7f:	75 e5                	jne    800a66 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a81:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a86:	c9                   	leave  
  800a87:	c3                   	ret    

00800a88 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a88:	55                   	push   %ebp
  800a89:	89 e5                	mov    %esp,%ebp
  800a8b:	83 ec 04             	sub    $0x4,%esp
  800a8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a91:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a94:	eb 0d                	jmp    800aa3 <strfind+0x1b>
		if (*s == c)
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	8a 00                	mov    (%eax),%al
  800a9b:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a9e:	74 0e                	je     800aae <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800aa0:	ff 45 08             	incl   0x8(%ebp)
  800aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa6:	8a 00                	mov    (%eax),%al
  800aa8:	84 c0                	test   %al,%al
  800aaa:	75 ea                	jne    800a96 <strfind+0xe>
  800aac:	eb 01                	jmp    800aaf <strfind+0x27>
		if (*s == c)
			break;
  800aae:	90                   	nop
	return (char *) s;
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ab2:	c9                   	leave  
  800ab3:	c3                   	ret    

00800ab4 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ab4:	55                   	push   %ebp
  800ab5:	89 e5                	mov    %esp,%ebp
  800ab7:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ac0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ac6:	eb 0e                	jmp    800ad6 <memset+0x22>
		*p++ = c;
  800ac8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800acb:	8d 50 01             	lea    0x1(%eax),%edx
  800ace:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ad1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad4:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ad6:	ff 4d f8             	decl   -0x8(%ebp)
  800ad9:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800add:	79 e9                	jns    800ac8 <memset+0x14>
		*p++ = c;

	return v;
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ae2:	c9                   	leave  
  800ae3:	c3                   	ret    

00800ae4 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ae4:	55                   	push   %ebp
  800ae5:	89 e5                	mov    %esp,%ebp
  800ae7:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800aea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800af0:	8b 45 08             	mov    0x8(%ebp),%eax
  800af3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800af6:	eb 16                	jmp    800b0e <memcpy+0x2a>
		*d++ = *s++;
  800af8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800afb:	8d 50 01             	lea    0x1(%eax),%edx
  800afe:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b01:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b04:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b07:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b0a:	8a 12                	mov    (%edx),%dl
  800b0c:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b0e:	8b 45 10             	mov    0x10(%ebp),%eax
  800b11:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b14:	89 55 10             	mov    %edx,0x10(%ebp)
  800b17:	85 c0                	test   %eax,%eax
  800b19:	75 dd                	jne    800af8 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b1e:	c9                   	leave  
  800b1f:	c3                   	ret    

00800b20 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b20:	55                   	push   %ebp
  800b21:	89 e5                	mov    %esp,%ebp
  800b23:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b35:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b38:	73 50                	jae    800b8a <memmove+0x6a>
  800b3a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b40:	01 d0                	add    %edx,%eax
  800b42:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b45:	76 43                	jbe    800b8a <memmove+0x6a>
		s += n;
  800b47:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4a:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b50:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b53:	eb 10                	jmp    800b65 <memmove+0x45>
			*--d = *--s;
  800b55:	ff 4d f8             	decl   -0x8(%ebp)
  800b58:	ff 4d fc             	decl   -0x4(%ebp)
  800b5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b5e:	8a 10                	mov    (%eax),%dl
  800b60:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b63:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b65:	8b 45 10             	mov    0x10(%ebp),%eax
  800b68:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b6b:	89 55 10             	mov    %edx,0x10(%ebp)
  800b6e:	85 c0                	test   %eax,%eax
  800b70:	75 e3                	jne    800b55 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b72:	eb 23                	jmp    800b97 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b74:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b77:	8d 50 01             	lea    0x1(%eax),%edx
  800b7a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b7d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b80:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b83:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b86:	8a 12                	mov    (%edx),%dl
  800b88:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b90:	89 55 10             	mov    %edx,0x10(%ebp)
  800b93:	85 c0                	test   %eax,%eax
  800b95:	75 dd                	jne    800b74 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b9a:	c9                   	leave  
  800b9b:	c3                   	ret    

00800b9c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ba8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bab:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bae:	eb 2a                	jmp    800bda <memcmp+0x3e>
		if (*s1 != *s2)
  800bb0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb3:	8a 10                	mov    (%eax),%dl
  800bb5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb8:	8a 00                	mov    (%eax),%al
  800bba:	38 c2                	cmp    %al,%dl
  800bbc:	74 16                	je     800bd4 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bc1:	8a 00                	mov    (%eax),%al
  800bc3:	0f b6 d0             	movzbl %al,%edx
  800bc6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc9:	8a 00                	mov    (%eax),%al
  800bcb:	0f b6 c0             	movzbl %al,%eax
  800bce:	29 c2                	sub    %eax,%edx
  800bd0:	89 d0                	mov    %edx,%eax
  800bd2:	eb 18                	jmp    800bec <memcmp+0x50>
		s1++, s2++;
  800bd4:	ff 45 fc             	incl   -0x4(%ebp)
  800bd7:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bda:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800be0:	89 55 10             	mov    %edx,0x10(%ebp)
  800be3:	85 c0                	test   %eax,%eax
  800be5:	75 c9                	jne    800bb0 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800be7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bec:	c9                   	leave  
  800bed:	c3                   	ret    

00800bee <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800bee:	55                   	push   %ebp
  800bef:	89 e5                	mov    %esp,%ebp
  800bf1:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bf4:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfa:	01 d0                	add    %edx,%eax
  800bfc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800bff:	eb 15                	jmp    800c16 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	8a 00                	mov    (%eax),%al
  800c06:	0f b6 d0             	movzbl %al,%edx
  800c09:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0c:	0f b6 c0             	movzbl %al,%eax
  800c0f:	39 c2                	cmp    %eax,%edx
  800c11:	74 0d                	je     800c20 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c13:	ff 45 08             	incl   0x8(%ebp)
  800c16:	8b 45 08             	mov    0x8(%ebp),%eax
  800c19:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c1c:	72 e3                	jb     800c01 <memfind+0x13>
  800c1e:	eb 01                	jmp    800c21 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c20:	90                   	nop
	return (void *) s;
  800c21:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c24:	c9                   	leave  
  800c25:	c3                   	ret    

00800c26 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c2c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c33:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c3a:	eb 03                	jmp    800c3f <strtol+0x19>
		s++;
  800c3c:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	8a 00                	mov    (%eax),%al
  800c44:	3c 20                	cmp    $0x20,%al
  800c46:	74 f4                	je     800c3c <strtol+0x16>
  800c48:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4b:	8a 00                	mov    (%eax),%al
  800c4d:	3c 09                	cmp    $0x9,%al
  800c4f:	74 eb                	je     800c3c <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c51:	8b 45 08             	mov    0x8(%ebp),%eax
  800c54:	8a 00                	mov    (%eax),%al
  800c56:	3c 2b                	cmp    $0x2b,%al
  800c58:	75 05                	jne    800c5f <strtol+0x39>
		s++;
  800c5a:	ff 45 08             	incl   0x8(%ebp)
  800c5d:	eb 13                	jmp    800c72 <strtol+0x4c>
	else if (*s == '-')
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	8a 00                	mov    (%eax),%al
  800c64:	3c 2d                	cmp    $0x2d,%al
  800c66:	75 0a                	jne    800c72 <strtol+0x4c>
		s++, neg = 1;
  800c68:	ff 45 08             	incl   0x8(%ebp)
  800c6b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c72:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c76:	74 06                	je     800c7e <strtol+0x58>
  800c78:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c7c:	75 20                	jne    800c9e <strtol+0x78>
  800c7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c81:	8a 00                	mov    (%eax),%al
  800c83:	3c 30                	cmp    $0x30,%al
  800c85:	75 17                	jne    800c9e <strtol+0x78>
  800c87:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8a:	40                   	inc    %eax
  800c8b:	8a 00                	mov    (%eax),%al
  800c8d:	3c 78                	cmp    $0x78,%al
  800c8f:	75 0d                	jne    800c9e <strtol+0x78>
		s += 2, base = 16;
  800c91:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c95:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800c9c:	eb 28                	jmp    800cc6 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800c9e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca2:	75 15                	jne    800cb9 <strtol+0x93>
  800ca4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca7:	8a 00                	mov    (%eax),%al
  800ca9:	3c 30                	cmp    $0x30,%al
  800cab:	75 0c                	jne    800cb9 <strtol+0x93>
		s++, base = 8;
  800cad:	ff 45 08             	incl   0x8(%ebp)
  800cb0:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cb7:	eb 0d                	jmp    800cc6 <strtol+0xa0>
	else if (base == 0)
  800cb9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cbd:	75 07                	jne    800cc6 <strtol+0xa0>
		base = 10;
  800cbf:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc9:	8a 00                	mov    (%eax),%al
  800ccb:	3c 2f                	cmp    $0x2f,%al
  800ccd:	7e 19                	jle    800ce8 <strtol+0xc2>
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8a 00                	mov    (%eax),%al
  800cd4:	3c 39                	cmp    $0x39,%al
  800cd6:	7f 10                	jg     800ce8 <strtol+0xc2>
			dig = *s - '0';
  800cd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdb:	8a 00                	mov    (%eax),%al
  800cdd:	0f be c0             	movsbl %al,%eax
  800ce0:	83 e8 30             	sub    $0x30,%eax
  800ce3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ce6:	eb 42                	jmp    800d2a <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ce8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ceb:	8a 00                	mov    (%eax),%al
  800ced:	3c 60                	cmp    $0x60,%al
  800cef:	7e 19                	jle    800d0a <strtol+0xe4>
  800cf1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf4:	8a 00                	mov    (%eax),%al
  800cf6:	3c 7a                	cmp    $0x7a,%al
  800cf8:	7f 10                	jg     800d0a <strtol+0xe4>
			dig = *s - 'a' + 10;
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	8a 00                	mov    (%eax),%al
  800cff:	0f be c0             	movsbl %al,%eax
  800d02:	83 e8 57             	sub    $0x57,%eax
  800d05:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d08:	eb 20                	jmp    800d2a <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	8a 00                	mov    (%eax),%al
  800d0f:	3c 40                	cmp    $0x40,%al
  800d11:	7e 39                	jle    800d4c <strtol+0x126>
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	3c 5a                	cmp    $0x5a,%al
  800d1a:	7f 30                	jg     800d4c <strtol+0x126>
			dig = *s - 'A' + 10;
  800d1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1f:	8a 00                	mov    (%eax),%al
  800d21:	0f be c0             	movsbl %al,%eax
  800d24:	83 e8 37             	sub    $0x37,%eax
  800d27:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d2d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d30:	7d 19                	jge    800d4b <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d32:	ff 45 08             	incl   0x8(%ebp)
  800d35:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d38:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d3c:	89 c2                	mov    %eax,%edx
  800d3e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d41:	01 d0                	add    %edx,%eax
  800d43:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d46:	e9 7b ff ff ff       	jmp    800cc6 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d4b:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d4c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d50:	74 08                	je     800d5a <strtol+0x134>
		*endptr = (char *) s;
  800d52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d55:	8b 55 08             	mov    0x8(%ebp),%edx
  800d58:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d5a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d5e:	74 07                	je     800d67 <strtol+0x141>
  800d60:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d63:	f7 d8                	neg    %eax
  800d65:	eb 03                	jmp    800d6a <strtol+0x144>
  800d67:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d6a:	c9                   	leave  
  800d6b:	c3                   	ret    

00800d6c <ltostr>:

void
ltostr(long value, char *str)
{
  800d6c:	55                   	push   %ebp
  800d6d:	89 e5                	mov    %esp,%ebp
  800d6f:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d72:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d79:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d80:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d84:	79 13                	jns    800d99 <ltostr+0x2d>
	{
		neg = 1;
  800d86:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d90:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d93:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d96:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800da1:	99                   	cltd   
  800da2:	f7 f9                	idiv   %ecx
  800da4:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800da7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800daa:	8d 50 01             	lea    0x1(%eax),%edx
  800dad:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800db0:	89 c2                	mov    %eax,%edx
  800db2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db5:	01 d0                	add    %edx,%eax
  800db7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dba:	83 c2 30             	add    $0x30,%edx
  800dbd:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dbf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dc2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dc7:	f7 e9                	imul   %ecx
  800dc9:	c1 fa 02             	sar    $0x2,%edx
  800dcc:	89 c8                	mov    %ecx,%eax
  800dce:	c1 f8 1f             	sar    $0x1f,%eax
  800dd1:	29 c2                	sub    %eax,%edx
  800dd3:	89 d0                	mov    %edx,%eax
  800dd5:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dd8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ddb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800de0:	f7 e9                	imul   %ecx
  800de2:	c1 fa 02             	sar    $0x2,%edx
  800de5:	89 c8                	mov    %ecx,%eax
  800de7:	c1 f8 1f             	sar    $0x1f,%eax
  800dea:	29 c2                	sub    %eax,%edx
  800dec:	89 d0                	mov    %edx,%eax
  800dee:	c1 e0 02             	shl    $0x2,%eax
  800df1:	01 d0                	add    %edx,%eax
  800df3:	01 c0                	add    %eax,%eax
  800df5:	29 c1                	sub    %eax,%ecx
  800df7:	89 ca                	mov    %ecx,%edx
  800df9:	85 d2                	test   %edx,%edx
  800dfb:	75 9c                	jne    800d99 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800dfd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e04:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e07:	48                   	dec    %eax
  800e08:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e0b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e0f:	74 3d                	je     800e4e <ltostr+0xe2>
		start = 1 ;
  800e11:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e18:	eb 34                	jmp    800e4e <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e1a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e20:	01 d0                	add    %edx,%eax
  800e22:	8a 00                	mov    (%eax),%al
  800e24:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e27:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2d:	01 c2                	add    %eax,%edx
  800e2f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e32:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e35:	01 c8                	add    %ecx,%eax
  800e37:	8a 00                	mov    (%eax),%al
  800e39:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e3b:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e41:	01 c2                	add    %eax,%edx
  800e43:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e46:	88 02                	mov    %al,(%edx)
		start++ ;
  800e48:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e4b:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e51:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e54:	7c c4                	jl     800e1a <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e56:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e5c:	01 d0                	add    %edx,%eax
  800e5e:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e61:	90                   	nop
  800e62:	c9                   	leave  
  800e63:	c3                   	ret    

00800e64 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e64:	55                   	push   %ebp
  800e65:	89 e5                	mov    %esp,%ebp
  800e67:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e6a:	ff 75 08             	pushl  0x8(%ebp)
  800e6d:	e8 54 fa ff ff       	call   8008c6 <strlen>
  800e72:	83 c4 04             	add    $0x4,%esp
  800e75:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e78:	ff 75 0c             	pushl  0xc(%ebp)
  800e7b:	e8 46 fa ff ff       	call   8008c6 <strlen>
  800e80:	83 c4 04             	add    $0x4,%esp
  800e83:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e86:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e8d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e94:	eb 17                	jmp    800ead <strcconcat+0x49>
		final[s] = str1[s] ;
  800e96:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e99:	8b 45 10             	mov    0x10(%ebp),%eax
  800e9c:	01 c2                	add    %eax,%edx
  800e9e:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ea1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea4:	01 c8                	add    %ecx,%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eaa:	ff 45 fc             	incl   -0x4(%ebp)
  800ead:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eb0:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eb3:	7c e1                	jl     800e96 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800eb5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800ebc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ec3:	eb 1f                	jmp    800ee4 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ec5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec8:	8d 50 01             	lea    0x1(%eax),%edx
  800ecb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ece:	89 c2                	mov    %eax,%edx
  800ed0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed3:	01 c2                	add    %eax,%edx
  800ed5:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ed8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800edb:	01 c8                	add    %ecx,%eax
  800edd:	8a 00                	mov    (%eax),%al
  800edf:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ee1:	ff 45 f8             	incl   -0x8(%ebp)
  800ee4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eea:	7c d9                	jl     800ec5 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800eec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eef:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef2:	01 d0                	add    %edx,%eax
  800ef4:	c6 00 00             	movb   $0x0,(%eax)
}
  800ef7:	90                   	nop
  800ef8:	c9                   	leave  
  800ef9:	c3                   	ret    

00800efa <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800efa:	55                   	push   %ebp
  800efb:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800efd:	8b 45 14             	mov    0x14(%ebp),%eax
  800f00:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f06:	8b 45 14             	mov    0x14(%ebp),%eax
  800f09:	8b 00                	mov    (%eax),%eax
  800f0b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f12:	8b 45 10             	mov    0x10(%ebp),%eax
  800f15:	01 d0                	add    %edx,%eax
  800f17:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f1d:	eb 0c                	jmp    800f2b <strsplit+0x31>
			*string++ = 0;
  800f1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f22:	8d 50 01             	lea    0x1(%eax),%edx
  800f25:	89 55 08             	mov    %edx,0x8(%ebp)
  800f28:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2e:	8a 00                	mov    (%eax),%al
  800f30:	84 c0                	test   %al,%al
  800f32:	74 18                	je     800f4c <strsplit+0x52>
  800f34:	8b 45 08             	mov    0x8(%ebp),%eax
  800f37:	8a 00                	mov    (%eax),%al
  800f39:	0f be c0             	movsbl %al,%eax
  800f3c:	50                   	push   %eax
  800f3d:	ff 75 0c             	pushl  0xc(%ebp)
  800f40:	e8 13 fb ff ff       	call   800a58 <strchr>
  800f45:	83 c4 08             	add    $0x8,%esp
  800f48:	85 c0                	test   %eax,%eax
  800f4a:	75 d3                	jne    800f1f <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4f:	8a 00                	mov    (%eax),%al
  800f51:	84 c0                	test   %al,%al
  800f53:	74 5a                	je     800faf <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f55:	8b 45 14             	mov    0x14(%ebp),%eax
  800f58:	8b 00                	mov    (%eax),%eax
  800f5a:	83 f8 0f             	cmp    $0xf,%eax
  800f5d:	75 07                	jne    800f66 <strsplit+0x6c>
		{
			return 0;
  800f5f:	b8 00 00 00 00       	mov    $0x0,%eax
  800f64:	eb 66                	jmp    800fcc <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f66:	8b 45 14             	mov    0x14(%ebp),%eax
  800f69:	8b 00                	mov    (%eax),%eax
  800f6b:	8d 48 01             	lea    0x1(%eax),%ecx
  800f6e:	8b 55 14             	mov    0x14(%ebp),%edx
  800f71:	89 0a                	mov    %ecx,(%edx)
  800f73:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7d:	01 c2                	add    %eax,%edx
  800f7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f82:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f84:	eb 03                	jmp    800f89 <strsplit+0x8f>
			string++;
  800f86:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	84 c0                	test   %al,%al
  800f90:	74 8b                	je     800f1d <strsplit+0x23>
  800f92:	8b 45 08             	mov    0x8(%ebp),%eax
  800f95:	8a 00                	mov    (%eax),%al
  800f97:	0f be c0             	movsbl %al,%eax
  800f9a:	50                   	push   %eax
  800f9b:	ff 75 0c             	pushl  0xc(%ebp)
  800f9e:	e8 b5 fa ff ff       	call   800a58 <strchr>
  800fa3:	83 c4 08             	add    $0x8,%esp
  800fa6:	85 c0                	test   %eax,%eax
  800fa8:	74 dc                	je     800f86 <strsplit+0x8c>
			string++;
	}
  800faa:	e9 6e ff ff ff       	jmp    800f1d <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800faf:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb3:	8b 00                	mov    (%eax),%eax
  800fb5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbf:	01 d0                	add    %edx,%eax
  800fc1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fc7:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fcc:	c9                   	leave  
  800fcd:	c3                   	ret    

00800fce <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fce:	55                   	push   %ebp
  800fcf:	89 e5                	mov    %esp,%ebp
  800fd1:	57                   	push   %edi
  800fd2:	56                   	push   %esi
  800fd3:	53                   	push   %ebx
  800fd4:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fdd:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fe0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fe3:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fe6:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fe9:	cd 30                	int    $0x30
  800feb:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800fee:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ff1:	83 c4 10             	add    $0x10,%esp
  800ff4:	5b                   	pop    %ebx
  800ff5:	5e                   	pop    %esi
  800ff6:	5f                   	pop    %edi
  800ff7:	5d                   	pop    %ebp
  800ff8:	c3                   	ret    

00800ff9 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800ff9:	55                   	push   %ebp
  800ffa:	89 e5                	mov    %esp,%ebp
  800ffc:	83 ec 04             	sub    $0x4,%esp
  800fff:	8b 45 10             	mov    0x10(%ebp),%eax
  801002:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801005:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801009:	8b 45 08             	mov    0x8(%ebp),%eax
  80100c:	6a 00                	push   $0x0
  80100e:	6a 00                	push   $0x0
  801010:	52                   	push   %edx
  801011:	ff 75 0c             	pushl  0xc(%ebp)
  801014:	50                   	push   %eax
  801015:	6a 00                	push   $0x0
  801017:	e8 b2 ff ff ff       	call   800fce <syscall>
  80101c:	83 c4 18             	add    $0x18,%esp
}
  80101f:	90                   	nop
  801020:	c9                   	leave  
  801021:	c3                   	ret    

00801022 <sys_cgetc>:

int
sys_cgetc(void)
{
  801022:	55                   	push   %ebp
  801023:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801025:	6a 00                	push   $0x0
  801027:	6a 00                	push   $0x0
  801029:	6a 00                	push   $0x0
  80102b:	6a 00                	push   $0x0
  80102d:	6a 00                	push   $0x0
  80102f:	6a 01                	push   $0x1
  801031:	e8 98 ff ff ff       	call   800fce <syscall>
  801036:	83 c4 18             	add    $0x18,%esp
}
  801039:	c9                   	leave  
  80103a:	c3                   	ret    

0080103b <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80103b:	55                   	push   %ebp
  80103c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80103e:	8b 45 08             	mov    0x8(%ebp),%eax
  801041:	6a 00                	push   $0x0
  801043:	6a 00                	push   $0x0
  801045:	6a 00                	push   $0x0
  801047:	6a 00                	push   $0x0
  801049:	50                   	push   %eax
  80104a:	6a 05                	push   $0x5
  80104c:	e8 7d ff ff ff       	call   800fce <syscall>
  801051:	83 c4 18             	add    $0x18,%esp
}
  801054:	c9                   	leave  
  801055:	c3                   	ret    

00801056 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801056:	55                   	push   %ebp
  801057:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801059:	6a 00                	push   $0x0
  80105b:	6a 00                	push   $0x0
  80105d:	6a 00                	push   $0x0
  80105f:	6a 00                	push   $0x0
  801061:	6a 00                	push   $0x0
  801063:	6a 02                	push   $0x2
  801065:	e8 64 ff ff ff       	call   800fce <syscall>
  80106a:	83 c4 18             	add    $0x18,%esp
}
  80106d:	c9                   	leave  
  80106e:	c3                   	ret    

0080106f <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80106f:	55                   	push   %ebp
  801070:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801072:	6a 00                	push   $0x0
  801074:	6a 00                	push   $0x0
  801076:	6a 00                	push   $0x0
  801078:	6a 00                	push   $0x0
  80107a:	6a 00                	push   $0x0
  80107c:	6a 03                	push   $0x3
  80107e:	e8 4b ff ff ff       	call   800fce <syscall>
  801083:	83 c4 18             	add    $0x18,%esp
}
  801086:	c9                   	leave  
  801087:	c3                   	ret    

00801088 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801088:	55                   	push   %ebp
  801089:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80108b:	6a 00                	push   $0x0
  80108d:	6a 00                	push   $0x0
  80108f:	6a 00                	push   $0x0
  801091:	6a 00                	push   $0x0
  801093:	6a 00                	push   $0x0
  801095:	6a 04                	push   $0x4
  801097:	e8 32 ff ff ff       	call   800fce <syscall>
  80109c:	83 c4 18             	add    $0x18,%esp
}
  80109f:	c9                   	leave  
  8010a0:	c3                   	ret    

008010a1 <sys_env_exit>:


void sys_env_exit(void)
{
  8010a1:	55                   	push   %ebp
  8010a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010a4:	6a 00                	push   $0x0
  8010a6:	6a 00                	push   $0x0
  8010a8:	6a 00                	push   $0x0
  8010aa:	6a 00                	push   $0x0
  8010ac:	6a 00                	push   $0x0
  8010ae:	6a 06                	push   $0x6
  8010b0:	e8 19 ff ff ff       	call   800fce <syscall>
  8010b5:	83 c4 18             	add    $0x18,%esp
}
  8010b8:	90                   	nop
  8010b9:	c9                   	leave  
  8010ba:	c3                   	ret    

008010bb <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010bb:	55                   	push   %ebp
  8010bc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c4:	6a 00                	push   $0x0
  8010c6:	6a 00                	push   $0x0
  8010c8:	6a 00                	push   $0x0
  8010ca:	52                   	push   %edx
  8010cb:	50                   	push   %eax
  8010cc:	6a 07                	push   $0x7
  8010ce:	e8 fb fe ff ff       	call   800fce <syscall>
  8010d3:	83 c4 18             	add    $0x18,%esp
}
  8010d6:	c9                   	leave  
  8010d7:	c3                   	ret    

008010d8 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010d8:	55                   	push   %ebp
  8010d9:	89 e5                	mov    %esp,%ebp
  8010db:	56                   	push   %esi
  8010dc:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010dd:	8b 75 18             	mov    0x18(%ebp),%esi
  8010e0:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010e3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ec:	56                   	push   %esi
  8010ed:	53                   	push   %ebx
  8010ee:	51                   	push   %ecx
  8010ef:	52                   	push   %edx
  8010f0:	50                   	push   %eax
  8010f1:	6a 08                	push   $0x8
  8010f3:	e8 d6 fe ff ff       	call   800fce <syscall>
  8010f8:	83 c4 18             	add    $0x18,%esp
}
  8010fb:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010fe:	5b                   	pop    %ebx
  8010ff:	5e                   	pop    %esi
  801100:	5d                   	pop    %ebp
  801101:	c3                   	ret    

00801102 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801102:	55                   	push   %ebp
  801103:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801105:	8b 55 0c             	mov    0xc(%ebp),%edx
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	6a 00                	push   $0x0
  80110d:	6a 00                	push   $0x0
  80110f:	6a 00                	push   $0x0
  801111:	52                   	push   %edx
  801112:	50                   	push   %eax
  801113:	6a 09                	push   $0x9
  801115:	e8 b4 fe ff ff       	call   800fce <syscall>
  80111a:	83 c4 18             	add    $0x18,%esp
}
  80111d:	c9                   	leave  
  80111e:	c3                   	ret    

0080111f <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80111f:	55                   	push   %ebp
  801120:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801122:	6a 00                	push   $0x0
  801124:	6a 00                	push   $0x0
  801126:	6a 00                	push   $0x0
  801128:	ff 75 0c             	pushl  0xc(%ebp)
  80112b:	ff 75 08             	pushl  0x8(%ebp)
  80112e:	6a 0a                	push   $0xa
  801130:	e8 99 fe ff ff       	call   800fce <syscall>
  801135:	83 c4 18             	add    $0x18,%esp
}
  801138:	c9                   	leave  
  801139:	c3                   	ret    

0080113a <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80113d:	6a 00                	push   $0x0
  80113f:	6a 00                	push   $0x0
  801141:	6a 00                	push   $0x0
  801143:	6a 00                	push   $0x0
  801145:	6a 00                	push   $0x0
  801147:	6a 0b                	push   $0xb
  801149:	e8 80 fe ff ff       	call   800fce <syscall>
  80114e:	83 c4 18             	add    $0x18,%esp
}
  801151:	c9                   	leave  
  801152:	c3                   	ret    

00801153 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801153:	55                   	push   %ebp
  801154:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801156:	6a 00                	push   $0x0
  801158:	6a 00                	push   $0x0
  80115a:	6a 00                	push   $0x0
  80115c:	6a 00                	push   $0x0
  80115e:	6a 00                	push   $0x0
  801160:	6a 0c                	push   $0xc
  801162:	e8 67 fe ff ff       	call   800fce <syscall>
  801167:	83 c4 18             	add    $0x18,%esp
}
  80116a:	c9                   	leave  
  80116b:	c3                   	ret    

0080116c <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80116c:	55                   	push   %ebp
  80116d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80116f:	6a 00                	push   $0x0
  801171:	6a 00                	push   $0x0
  801173:	6a 00                	push   $0x0
  801175:	6a 00                	push   $0x0
  801177:	6a 00                	push   $0x0
  801179:	6a 0d                	push   $0xd
  80117b:	e8 4e fe ff ff       	call   800fce <syscall>
  801180:	83 c4 18             	add    $0x18,%esp
}
  801183:	c9                   	leave  
  801184:	c3                   	ret    

00801185 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801185:	55                   	push   %ebp
  801186:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801188:	6a 00                	push   $0x0
  80118a:	6a 00                	push   $0x0
  80118c:	6a 00                	push   $0x0
  80118e:	ff 75 0c             	pushl  0xc(%ebp)
  801191:	ff 75 08             	pushl  0x8(%ebp)
  801194:	6a 11                	push   $0x11
  801196:	e8 33 fe ff ff       	call   800fce <syscall>
  80119b:	83 c4 18             	add    $0x18,%esp
	return;
  80119e:	90                   	nop
}
  80119f:	c9                   	leave  
  8011a0:	c3                   	ret    

008011a1 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011a1:	55                   	push   %ebp
  8011a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011a4:	6a 00                	push   $0x0
  8011a6:	6a 00                	push   $0x0
  8011a8:	6a 00                	push   $0x0
  8011aa:	ff 75 0c             	pushl  0xc(%ebp)
  8011ad:	ff 75 08             	pushl  0x8(%ebp)
  8011b0:	6a 12                	push   $0x12
  8011b2:	e8 17 fe ff ff       	call   800fce <syscall>
  8011b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8011ba:	90                   	nop
}
  8011bb:	c9                   	leave  
  8011bc:	c3                   	ret    

008011bd <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011bd:	55                   	push   %ebp
  8011be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011c0:	6a 00                	push   $0x0
  8011c2:	6a 00                	push   $0x0
  8011c4:	6a 00                	push   $0x0
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 0e                	push   $0xe
  8011cc:	e8 fd fd ff ff       	call   800fce <syscall>
  8011d1:	83 c4 18             	add    $0x18,%esp
}
  8011d4:	c9                   	leave  
  8011d5:	c3                   	ret    

008011d6 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011d6:	55                   	push   %ebp
  8011d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011d9:	6a 00                	push   $0x0
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 00                	push   $0x0
  8011df:	6a 00                	push   $0x0
  8011e1:	ff 75 08             	pushl  0x8(%ebp)
  8011e4:	6a 0f                	push   $0xf
  8011e6:	e8 e3 fd ff ff       	call   800fce <syscall>
  8011eb:	83 c4 18             	add    $0x18,%esp
}
  8011ee:	c9                   	leave  
  8011ef:	c3                   	ret    

008011f0 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011f0:	55                   	push   %ebp
  8011f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011f3:	6a 00                	push   $0x0
  8011f5:	6a 00                	push   $0x0
  8011f7:	6a 00                	push   $0x0
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 10                	push   $0x10
  8011ff:	e8 ca fd ff ff       	call   800fce <syscall>
  801204:	83 c4 18             	add    $0x18,%esp
}
  801207:	90                   	nop
  801208:	c9                   	leave  
  801209:	c3                   	ret    

0080120a <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80120a:	55                   	push   %ebp
  80120b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80120d:	6a 00                	push   $0x0
  80120f:	6a 00                	push   $0x0
  801211:	6a 00                	push   $0x0
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	6a 14                	push   $0x14
  801219:	e8 b0 fd ff ff       	call   800fce <syscall>
  80121e:	83 c4 18             	add    $0x18,%esp
}
  801221:	90                   	nop
  801222:	c9                   	leave  
  801223:	c3                   	ret    

00801224 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801224:	55                   	push   %ebp
  801225:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801227:	6a 00                	push   $0x0
  801229:	6a 00                	push   $0x0
  80122b:	6a 00                	push   $0x0
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 15                	push   $0x15
  801233:	e8 96 fd ff ff       	call   800fce <syscall>
  801238:	83 c4 18             	add    $0x18,%esp
}
  80123b:	90                   	nop
  80123c:	c9                   	leave  
  80123d:	c3                   	ret    

0080123e <sys_cputc>:


void
sys_cputc(const char c)
{
  80123e:	55                   	push   %ebp
  80123f:	89 e5                	mov    %esp,%ebp
  801241:	83 ec 04             	sub    $0x4,%esp
  801244:	8b 45 08             	mov    0x8(%ebp),%eax
  801247:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80124a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 00                	push   $0x0
  801256:	50                   	push   %eax
  801257:	6a 16                	push   $0x16
  801259:	e8 70 fd ff ff       	call   800fce <syscall>
  80125e:	83 c4 18             	add    $0x18,%esp
}
  801261:	90                   	nop
  801262:	c9                   	leave  
  801263:	c3                   	ret    

00801264 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801264:	55                   	push   %ebp
  801265:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801267:	6a 00                	push   $0x0
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 00                	push   $0x0
  801271:	6a 17                	push   $0x17
  801273:	e8 56 fd ff ff       	call   800fce <syscall>
  801278:	83 c4 18             	add    $0x18,%esp
}
  80127b:	90                   	nop
  80127c:	c9                   	leave  
  80127d:	c3                   	ret    

0080127e <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80127e:	55                   	push   %ebp
  80127f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801281:	8b 45 08             	mov    0x8(%ebp),%eax
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	ff 75 0c             	pushl  0xc(%ebp)
  80128d:	50                   	push   %eax
  80128e:	6a 18                	push   $0x18
  801290:	e8 39 fd ff ff       	call   800fce <syscall>
  801295:	83 c4 18             	add    $0x18,%esp
}
  801298:	c9                   	leave  
  801299:	c3                   	ret    

0080129a <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80129a:	55                   	push   %ebp
  80129b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80129d:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a3:	6a 00                	push   $0x0
  8012a5:	6a 00                	push   $0x0
  8012a7:	6a 00                	push   $0x0
  8012a9:	52                   	push   %edx
  8012aa:	50                   	push   %eax
  8012ab:	6a 1b                	push   $0x1b
  8012ad:	e8 1c fd ff ff       	call   800fce <syscall>
  8012b2:	83 c4 18             	add    $0x18,%esp
}
  8012b5:	c9                   	leave  
  8012b6:	c3                   	ret    

008012b7 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012b7:	55                   	push   %ebp
  8012b8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	6a 00                	push   $0x0
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	52                   	push   %edx
  8012c7:	50                   	push   %eax
  8012c8:	6a 19                	push   $0x19
  8012ca:	e8 ff fc ff ff       	call   800fce <syscall>
  8012cf:	83 c4 18             	add    $0x18,%esp
}
  8012d2:	90                   	nop
  8012d3:	c9                   	leave  
  8012d4:	c3                   	ret    

008012d5 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012d5:	55                   	push   %ebp
  8012d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012db:	8b 45 08             	mov    0x8(%ebp),%eax
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 00                	push   $0x0
  8012e4:	52                   	push   %edx
  8012e5:	50                   	push   %eax
  8012e6:	6a 1a                	push   $0x1a
  8012e8:	e8 e1 fc ff ff       	call   800fce <syscall>
  8012ed:	83 c4 18             	add    $0x18,%esp
}
  8012f0:	90                   	nop
  8012f1:	c9                   	leave  
  8012f2:	c3                   	ret    

008012f3 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012f3:	55                   	push   %ebp
  8012f4:	89 e5                	mov    %esp,%ebp
  8012f6:	83 ec 04             	sub    $0x4,%esp
  8012f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fc:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8012ff:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801302:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	6a 00                	push   $0x0
  80130b:	51                   	push   %ecx
  80130c:	52                   	push   %edx
  80130d:	ff 75 0c             	pushl  0xc(%ebp)
  801310:	50                   	push   %eax
  801311:	6a 1c                	push   $0x1c
  801313:	e8 b6 fc ff ff       	call   800fce <syscall>
  801318:	83 c4 18             	add    $0x18,%esp
}
  80131b:	c9                   	leave  
  80131c:	c3                   	ret    

0080131d <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80131d:	55                   	push   %ebp
  80131e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801320:	8b 55 0c             	mov    0xc(%ebp),%edx
  801323:	8b 45 08             	mov    0x8(%ebp),%eax
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	6a 00                	push   $0x0
  80132c:	52                   	push   %edx
  80132d:	50                   	push   %eax
  80132e:	6a 1d                	push   $0x1d
  801330:	e8 99 fc ff ff       	call   800fce <syscall>
  801335:	83 c4 18             	add    $0x18,%esp
}
  801338:	c9                   	leave  
  801339:	c3                   	ret    

0080133a <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80133a:	55                   	push   %ebp
  80133b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80133d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801340:	8b 55 0c             	mov    0xc(%ebp),%edx
  801343:	8b 45 08             	mov    0x8(%ebp),%eax
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	51                   	push   %ecx
  80134b:	52                   	push   %edx
  80134c:	50                   	push   %eax
  80134d:	6a 1e                	push   $0x1e
  80134f:	e8 7a fc ff ff       	call   800fce <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80135c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	52                   	push   %edx
  801369:	50                   	push   %eax
  80136a:	6a 1f                	push   $0x1f
  80136c:	e8 5d fc ff ff       	call   800fce <syscall>
  801371:	83 c4 18             	add    $0x18,%esp
}
  801374:	c9                   	leave  
  801375:	c3                   	ret    

00801376 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801379:	6a 00                	push   $0x0
  80137b:	6a 00                	push   $0x0
  80137d:	6a 00                	push   $0x0
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 20                	push   $0x20
  801385:	e8 44 fc ff ff       	call   800fce <syscall>
  80138a:	83 c4 18             	add    $0x18,%esp
}
  80138d:	c9                   	leave  
  80138e:	c3                   	ret    

0080138f <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80138f:	55                   	push   %ebp
  801390:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	6a 00                	push   $0x0
  801397:	ff 75 14             	pushl  0x14(%ebp)
  80139a:	ff 75 10             	pushl  0x10(%ebp)
  80139d:	ff 75 0c             	pushl  0xc(%ebp)
  8013a0:	50                   	push   %eax
  8013a1:	6a 21                	push   $0x21
  8013a3:	e8 26 fc ff ff       	call   800fce <syscall>
  8013a8:	83 c4 18             	add    $0x18,%esp
}
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	6a 00                	push   $0x0
  8013bb:	50                   	push   %eax
  8013bc:	6a 22                	push   $0x22
  8013be:	e8 0b fc ff ff       	call   800fce <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
}
  8013c6:	90                   	nop
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	50                   	push   %eax
  8013d8:	6a 23                	push   $0x23
  8013da:	e8 ef fb ff ff       	call   800fce <syscall>
  8013df:	83 c4 18             	add    $0x18,%esp
}
  8013e2:	90                   	nop
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
  8013e8:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013eb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013ee:	8d 50 04             	lea    0x4(%eax),%edx
  8013f1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	52                   	push   %edx
  8013fb:	50                   	push   %eax
  8013fc:	6a 24                	push   $0x24
  8013fe:	e8 cb fb ff ff       	call   800fce <syscall>
  801403:	83 c4 18             	add    $0x18,%esp
	return result;
  801406:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801409:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80140c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80140f:	89 01                	mov    %eax,(%ecx)
  801411:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801414:	8b 45 08             	mov    0x8(%ebp),%eax
  801417:	c9                   	leave  
  801418:	c2 04 00             	ret    $0x4

0080141b <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80141b:	55                   	push   %ebp
  80141c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80141e:	6a 00                	push   $0x0
  801420:	6a 00                	push   $0x0
  801422:	ff 75 10             	pushl  0x10(%ebp)
  801425:	ff 75 0c             	pushl  0xc(%ebp)
  801428:	ff 75 08             	pushl  0x8(%ebp)
  80142b:	6a 13                	push   $0x13
  80142d:	e8 9c fb ff ff       	call   800fce <syscall>
  801432:	83 c4 18             	add    $0x18,%esp
	return ;
  801435:	90                   	nop
}
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <sys_rcr2>:
uint32 sys_rcr2()
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 25                	push   $0x25
  801447:	e8 82 fb ff ff       	call   800fce <syscall>
  80144c:	83 c4 18             	add    $0x18,%esp
}
  80144f:	c9                   	leave  
  801450:	c3                   	ret    

00801451 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801451:	55                   	push   %ebp
  801452:	89 e5                	mov    %esp,%ebp
  801454:	83 ec 04             	sub    $0x4,%esp
  801457:	8b 45 08             	mov    0x8(%ebp),%eax
  80145a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80145d:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	50                   	push   %eax
  80146a:	6a 26                	push   $0x26
  80146c:	e8 5d fb ff ff       	call   800fce <syscall>
  801471:	83 c4 18             	add    $0x18,%esp
	return ;
  801474:	90                   	nop
}
  801475:	c9                   	leave  
  801476:	c3                   	ret    

00801477 <rsttst>:
void rsttst()
{
  801477:	55                   	push   %ebp
  801478:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80147a:	6a 00                	push   $0x0
  80147c:	6a 00                	push   $0x0
  80147e:	6a 00                	push   $0x0
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 28                	push   $0x28
  801486:	e8 43 fb ff ff       	call   800fce <syscall>
  80148b:	83 c4 18             	add    $0x18,%esp
	return ;
  80148e:	90                   	nop
}
  80148f:	c9                   	leave  
  801490:	c3                   	ret    

00801491 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
  801494:	83 ec 04             	sub    $0x4,%esp
  801497:	8b 45 14             	mov    0x14(%ebp),%eax
  80149a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80149d:	8b 55 18             	mov    0x18(%ebp),%edx
  8014a0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014a4:	52                   	push   %edx
  8014a5:	50                   	push   %eax
  8014a6:	ff 75 10             	pushl  0x10(%ebp)
  8014a9:	ff 75 0c             	pushl  0xc(%ebp)
  8014ac:	ff 75 08             	pushl  0x8(%ebp)
  8014af:	6a 27                	push   $0x27
  8014b1:	e8 18 fb ff ff       	call   800fce <syscall>
  8014b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b9:	90                   	nop
}
  8014ba:	c9                   	leave  
  8014bb:	c3                   	ret    

008014bc <chktst>:
void chktst(uint32 n)
{
  8014bc:	55                   	push   %ebp
  8014bd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014bf:	6a 00                	push   $0x0
  8014c1:	6a 00                	push   $0x0
  8014c3:	6a 00                	push   $0x0
  8014c5:	6a 00                	push   $0x0
  8014c7:	ff 75 08             	pushl  0x8(%ebp)
  8014ca:	6a 29                	push   $0x29
  8014cc:	e8 fd fa ff ff       	call   800fce <syscall>
  8014d1:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d4:	90                   	nop
}
  8014d5:	c9                   	leave  
  8014d6:	c3                   	ret    

008014d7 <inctst>:

void inctst()
{
  8014d7:	55                   	push   %ebp
  8014d8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014da:	6a 00                	push   $0x0
  8014dc:	6a 00                	push   $0x0
  8014de:	6a 00                	push   $0x0
  8014e0:	6a 00                	push   $0x0
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 2a                	push   $0x2a
  8014e6:	e8 e3 fa ff ff       	call   800fce <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
	return ;
  8014ee:	90                   	nop
}
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <gettst>:
uint32 gettst()
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 2b                	push   $0x2b
  801500:	e8 c9 fa ff ff       	call   800fce <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	c9                   	leave  
  801509:	c3                   	ret    

0080150a <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
  80150d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801510:	6a 00                	push   $0x0
  801512:	6a 00                	push   $0x0
  801514:	6a 00                	push   $0x0
  801516:	6a 00                	push   $0x0
  801518:	6a 00                	push   $0x0
  80151a:	6a 2c                	push   $0x2c
  80151c:	e8 ad fa ff ff       	call   800fce <syscall>
  801521:	83 c4 18             	add    $0x18,%esp
  801524:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801527:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80152b:	75 07                	jne    801534 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80152d:	b8 01 00 00 00       	mov    $0x1,%eax
  801532:	eb 05                	jmp    801539 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801534:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801539:	c9                   	leave  
  80153a:	c3                   	ret    

0080153b <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80153b:	55                   	push   %ebp
  80153c:	89 e5                	mov    %esp,%ebp
  80153e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	6a 00                	push   $0x0
  801547:	6a 00                	push   $0x0
  801549:	6a 00                	push   $0x0
  80154b:	6a 2c                	push   $0x2c
  80154d:	e8 7c fa ff ff       	call   800fce <syscall>
  801552:	83 c4 18             	add    $0x18,%esp
  801555:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801558:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80155c:	75 07                	jne    801565 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80155e:	b8 01 00 00 00       	mov    $0x1,%eax
  801563:	eb 05                	jmp    80156a <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801565:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
  80156f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801572:	6a 00                	push   $0x0
  801574:	6a 00                	push   $0x0
  801576:	6a 00                	push   $0x0
  801578:	6a 00                	push   $0x0
  80157a:	6a 00                	push   $0x0
  80157c:	6a 2c                	push   $0x2c
  80157e:	e8 4b fa ff ff       	call   800fce <syscall>
  801583:	83 c4 18             	add    $0x18,%esp
  801586:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801589:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80158d:	75 07                	jne    801596 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80158f:	b8 01 00 00 00       	mov    $0x1,%eax
  801594:	eb 05                	jmp    80159b <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801596:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
  8015a0:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	6a 00                	push   $0x0
  8015ad:	6a 2c                	push   $0x2c
  8015af:	e8 1a fa ff ff       	call   800fce <syscall>
  8015b4:	83 c4 18             	add    $0x18,%esp
  8015b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015ba:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015be:	75 07                	jne    8015c7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015c0:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c5:	eb 05                	jmp    8015cc <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015c7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015cc:	c9                   	leave  
  8015cd:	c3                   	ret    

008015ce <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015ce:	55                   	push   %ebp
  8015cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	ff 75 08             	pushl  0x8(%ebp)
  8015dc:	6a 2d                	push   $0x2d
  8015de:	e8 eb f9 ff ff       	call   800fce <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
	return ;
  8015e6:	90                   	nop
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8015ed:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015f0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f9:	6a 00                	push   $0x0
  8015fb:	53                   	push   %ebx
  8015fc:	51                   	push   %ecx
  8015fd:	52                   	push   %edx
  8015fe:	50                   	push   %eax
  8015ff:	6a 2e                	push   $0x2e
  801601:	e8 c8 f9 ff ff       	call   800fce <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
}
  801609:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80160c:	c9                   	leave  
  80160d:	c3                   	ret    

0080160e <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80160e:	55                   	push   %ebp
  80160f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801611:	8b 55 0c             	mov    0xc(%ebp),%edx
  801614:	8b 45 08             	mov    0x8(%ebp),%eax
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	6a 00                	push   $0x0
  80161d:	52                   	push   %edx
  80161e:	50                   	push   %eax
  80161f:	6a 2f                	push   $0x2f
  801621:	e8 a8 f9 ff ff       	call   800fce <syscall>
  801626:	83 c4 18             	add    $0x18,%esp
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	ff 75 0c             	pushl  0xc(%ebp)
  801637:	ff 75 08             	pushl  0x8(%ebp)
  80163a:	6a 30                	push   $0x30
  80163c:	e8 8d f9 ff ff       	call   800fce <syscall>
  801641:	83 c4 18             	add    $0x18,%esp
	return ;
  801644:	90                   	nop
}
  801645:	c9                   	leave  
  801646:	c3                   	ret    
  801647:	90                   	nop

00801648 <__udivdi3>:
  801648:	55                   	push   %ebp
  801649:	57                   	push   %edi
  80164a:	56                   	push   %esi
  80164b:	53                   	push   %ebx
  80164c:	83 ec 1c             	sub    $0x1c,%esp
  80164f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801653:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801657:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80165b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80165f:	89 ca                	mov    %ecx,%edx
  801661:	89 f8                	mov    %edi,%eax
  801663:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801667:	85 f6                	test   %esi,%esi
  801669:	75 2d                	jne    801698 <__udivdi3+0x50>
  80166b:	39 cf                	cmp    %ecx,%edi
  80166d:	77 65                	ja     8016d4 <__udivdi3+0x8c>
  80166f:	89 fd                	mov    %edi,%ebp
  801671:	85 ff                	test   %edi,%edi
  801673:	75 0b                	jne    801680 <__udivdi3+0x38>
  801675:	b8 01 00 00 00       	mov    $0x1,%eax
  80167a:	31 d2                	xor    %edx,%edx
  80167c:	f7 f7                	div    %edi
  80167e:	89 c5                	mov    %eax,%ebp
  801680:	31 d2                	xor    %edx,%edx
  801682:	89 c8                	mov    %ecx,%eax
  801684:	f7 f5                	div    %ebp
  801686:	89 c1                	mov    %eax,%ecx
  801688:	89 d8                	mov    %ebx,%eax
  80168a:	f7 f5                	div    %ebp
  80168c:	89 cf                	mov    %ecx,%edi
  80168e:	89 fa                	mov    %edi,%edx
  801690:	83 c4 1c             	add    $0x1c,%esp
  801693:	5b                   	pop    %ebx
  801694:	5e                   	pop    %esi
  801695:	5f                   	pop    %edi
  801696:	5d                   	pop    %ebp
  801697:	c3                   	ret    
  801698:	39 ce                	cmp    %ecx,%esi
  80169a:	77 28                	ja     8016c4 <__udivdi3+0x7c>
  80169c:	0f bd fe             	bsr    %esi,%edi
  80169f:	83 f7 1f             	xor    $0x1f,%edi
  8016a2:	75 40                	jne    8016e4 <__udivdi3+0x9c>
  8016a4:	39 ce                	cmp    %ecx,%esi
  8016a6:	72 0a                	jb     8016b2 <__udivdi3+0x6a>
  8016a8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016ac:	0f 87 9e 00 00 00    	ja     801750 <__udivdi3+0x108>
  8016b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8016b7:	89 fa                	mov    %edi,%edx
  8016b9:	83 c4 1c             	add    $0x1c,%esp
  8016bc:	5b                   	pop    %ebx
  8016bd:	5e                   	pop    %esi
  8016be:	5f                   	pop    %edi
  8016bf:	5d                   	pop    %ebp
  8016c0:	c3                   	ret    
  8016c1:	8d 76 00             	lea    0x0(%esi),%esi
  8016c4:	31 ff                	xor    %edi,%edi
  8016c6:	31 c0                	xor    %eax,%eax
  8016c8:	89 fa                	mov    %edi,%edx
  8016ca:	83 c4 1c             	add    $0x1c,%esp
  8016cd:	5b                   	pop    %ebx
  8016ce:	5e                   	pop    %esi
  8016cf:	5f                   	pop    %edi
  8016d0:	5d                   	pop    %ebp
  8016d1:	c3                   	ret    
  8016d2:	66 90                	xchg   %ax,%ax
  8016d4:	89 d8                	mov    %ebx,%eax
  8016d6:	f7 f7                	div    %edi
  8016d8:	31 ff                	xor    %edi,%edi
  8016da:	89 fa                	mov    %edi,%edx
  8016dc:	83 c4 1c             	add    $0x1c,%esp
  8016df:	5b                   	pop    %ebx
  8016e0:	5e                   	pop    %esi
  8016e1:	5f                   	pop    %edi
  8016e2:	5d                   	pop    %ebp
  8016e3:	c3                   	ret    
  8016e4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016e9:	89 eb                	mov    %ebp,%ebx
  8016eb:	29 fb                	sub    %edi,%ebx
  8016ed:	89 f9                	mov    %edi,%ecx
  8016ef:	d3 e6                	shl    %cl,%esi
  8016f1:	89 c5                	mov    %eax,%ebp
  8016f3:	88 d9                	mov    %bl,%cl
  8016f5:	d3 ed                	shr    %cl,%ebp
  8016f7:	89 e9                	mov    %ebp,%ecx
  8016f9:	09 f1                	or     %esi,%ecx
  8016fb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016ff:	89 f9                	mov    %edi,%ecx
  801701:	d3 e0                	shl    %cl,%eax
  801703:	89 c5                	mov    %eax,%ebp
  801705:	89 d6                	mov    %edx,%esi
  801707:	88 d9                	mov    %bl,%cl
  801709:	d3 ee                	shr    %cl,%esi
  80170b:	89 f9                	mov    %edi,%ecx
  80170d:	d3 e2                	shl    %cl,%edx
  80170f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801713:	88 d9                	mov    %bl,%cl
  801715:	d3 e8                	shr    %cl,%eax
  801717:	09 c2                	or     %eax,%edx
  801719:	89 d0                	mov    %edx,%eax
  80171b:	89 f2                	mov    %esi,%edx
  80171d:	f7 74 24 0c          	divl   0xc(%esp)
  801721:	89 d6                	mov    %edx,%esi
  801723:	89 c3                	mov    %eax,%ebx
  801725:	f7 e5                	mul    %ebp
  801727:	39 d6                	cmp    %edx,%esi
  801729:	72 19                	jb     801744 <__udivdi3+0xfc>
  80172b:	74 0b                	je     801738 <__udivdi3+0xf0>
  80172d:	89 d8                	mov    %ebx,%eax
  80172f:	31 ff                	xor    %edi,%edi
  801731:	e9 58 ff ff ff       	jmp    80168e <__udivdi3+0x46>
  801736:	66 90                	xchg   %ax,%ax
  801738:	8b 54 24 08          	mov    0x8(%esp),%edx
  80173c:	89 f9                	mov    %edi,%ecx
  80173e:	d3 e2                	shl    %cl,%edx
  801740:	39 c2                	cmp    %eax,%edx
  801742:	73 e9                	jae    80172d <__udivdi3+0xe5>
  801744:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801747:	31 ff                	xor    %edi,%edi
  801749:	e9 40 ff ff ff       	jmp    80168e <__udivdi3+0x46>
  80174e:	66 90                	xchg   %ax,%ax
  801750:	31 c0                	xor    %eax,%eax
  801752:	e9 37 ff ff ff       	jmp    80168e <__udivdi3+0x46>
  801757:	90                   	nop

00801758 <__umoddi3>:
  801758:	55                   	push   %ebp
  801759:	57                   	push   %edi
  80175a:	56                   	push   %esi
  80175b:	53                   	push   %ebx
  80175c:	83 ec 1c             	sub    $0x1c,%esp
  80175f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801763:	8b 74 24 34          	mov    0x34(%esp),%esi
  801767:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80176b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80176f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801773:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801777:	89 f3                	mov    %esi,%ebx
  801779:	89 fa                	mov    %edi,%edx
  80177b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80177f:	89 34 24             	mov    %esi,(%esp)
  801782:	85 c0                	test   %eax,%eax
  801784:	75 1a                	jne    8017a0 <__umoddi3+0x48>
  801786:	39 f7                	cmp    %esi,%edi
  801788:	0f 86 a2 00 00 00    	jbe    801830 <__umoddi3+0xd8>
  80178e:	89 c8                	mov    %ecx,%eax
  801790:	89 f2                	mov    %esi,%edx
  801792:	f7 f7                	div    %edi
  801794:	89 d0                	mov    %edx,%eax
  801796:	31 d2                	xor    %edx,%edx
  801798:	83 c4 1c             	add    $0x1c,%esp
  80179b:	5b                   	pop    %ebx
  80179c:	5e                   	pop    %esi
  80179d:	5f                   	pop    %edi
  80179e:	5d                   	pop    %ebp
  80179f:	c3                   	ret    
  8017a0:	39 f0                	cmp    %esi,%eax
  8017a2:	0f 87 ac 00 00 00    	ja     801854 <__umoddi3+0xfc>
  8017a8:	0f bd e8             	bsr    %eax,%ebp
  8017ab:	83 f5 1f             	xor    $0x1f,%ebp
  8017ae:	0f 84 ac 00 00 00    	je     801860 <__umoddi3+0x108>
  8017b4:	bf 20 00 00 00       	mov    $0x20,%edi
  8017b9:	29 ef                	sub    %ebp,%edi
  8017bb:	89 fe                	mov    %edi,%esi
  8017bd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017c1:	89 e9                	mov    %ebp,%ecx
  8017c3:	d3 e0                	shl    %cl,%eax
  8017c5:	89 d7                	mov    %edx,%edi
  8017c7:	89 f1                	mov    %esi,%ecx
  8017c9:	d3 ef                	shr    %cl,%edi
  8017cb:	09 c7                	or     %eax,%edi
  8017cd:	89 e9                	mov    %ebp,%ecx
  8017cf:	d3 e2                	shl    %cl,%edx
  8017d1:	89 14 24             	mov    %edx,(%esp)
  8017d4:	89 d8                	mov    %ebx,%eax
  8017d6:	d3 e0                	shl    %cl,%eax
  8017d8:	89 c2                	mov    %eax,%edx
  8017da:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017de:	d3 e0                	shl    %cl,%eax
  8017e0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017e4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017e8:	89 f1                	mov    %esi,%ecx
  8017ea:	d3 e8                	shr    %cl,%eax
  8017ec:	09 d0                	or     %edx,%eax
  8017ee:	d3 eb                	shr    %cl,%ebx
  8017f0:	89 da                	mov    %ebx,%edx
  8017f2:	f7 f7                	div    %edi
  8017f4:	89 d3                	mov    %edx,%ebx
  8017f6:	f7 24 24             	mull   (%esp)
  8017f9:	89 c6                	mov    %eax,%esi
  8017fb:	89 d1                	mov    %edx,%ecx
  8017fd:	39 d3                	cmp    %edx,%ebx
  8017ff:	0f 82 87 00 00 00    	jb     80188c <__umoddi3+0x134>
  801805:	0f 84 91 00 00 00    	je     80189c <__umoddi3+0x144>
  80180b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80180f:	29 f2                	sub    %esi,%edx
  801811:	19 cb                	sbb    %ecx,%ebx
  801813:	89 d8                	mov    %ebx,%eax
  801815:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801819:	d3 e0                	shl    %cl,%eax
  80181b:	89 e9                	mov    %ebp,%ecx
  80181d:	d3 ea                	shr    %cl,%edx
  80181f:	09 d0                	or     %edx,%eax
  801821:	89 e9                	mov    %ebp,%ecx
  801823:	d3 eb                	shr    %cl,%ebx
  801825:	89 da                	mov    %ebx,%edx
  801827:	83 c4 1c             	add    $0x1c,%esp
  80182a:	5b                   	pop    %ebx
  80182b:	5e                   	pop    %esi
  80182c:	5f                   	pop    %edi
  80182d:	5d                   	pop    %ebp
  80182e:	c3                   	ret    
  80182f:	90                   	nop
  801830:	89 fd                	mov    %edi,%ebp
  801832:	85 ff                	test   %edi,%edi
  801834:	75 0b                	jne    801841 <__umoddi3+0xe9>
  801836:	b8 01 00 00 00       	mov    $0x1,%eax
  80183b:	31 d2                	xor    %edx,%edx
  80183d:	f7 f7                	div    %edi
  80183f:	89 c5                	mov    %eax,%ebp
  801841:	89 f0                	mov    %esi,%eax
  801843:	31 d2                	xor    %edx,%edx
  801845:	f7 f5                	div    %ebp
  801847:	89 c8                	mov    %ecx,%eax
  801849:	f7 f5                	div    %ebp
  80184b:	89 d0                	mov    %edx,%eax
  80184d:	e9 44 ff ff ff       	jmp    801796 <__umoddi3+0x3e>
  801852:	66 90                	xchg   %ax,%ax
  801854:	89 c8                	mov    %ecx,%eax
  801856:	89 f2                	mov    %esi,%edx
  801858:	83 c4 1c             	add    $0x1c,%esp
  80185b:	5b                   	pop    %ebx
  80185c:	5e                   	pop    %esi
  80185d:	5f                   	pop    %edi
  80185e:	5d                   	pop    %ebp
  80185f:	c3                   	ret    
  801860:	3b 04 24             	cmp    (%esp),%eax
  801863:	72 06                	jb     80186b <__umoddi3+0x113>
  801865:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801869:	77 0f                	ja     80187a <__umoddi3+0x122>
  80186b:	89 f2                	mov    %esi,%edx
  80186d:	29 f9                	sub    %edi,%ecx
  80186f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801873:	89 14 24             	mov    %edx,(%esp)
  801876:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80187a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80187e:	8b 14 24             	mov    (%esp),%edx
  801881:	83 c4 1c             	add    $0x1c,%esp
  801884:	5b                   	pop    %ebx
  801885:	5e                   	pop    %esi
  801886:	5f                   	pop    %edi
  801887:	5d                   	pop    %ebp
  801888:	c3                   	ret    
  801889:	8d 76 00             	lea    0x0(%esi),%esi
  80188c:	2b 04 24             	sub    (%esp),%eax
  80188f:	19 fa                	sbb    %edi,%edx
  801891:	89 d1                	mov    %edx,%ecx
  801893:	89 c6                	mov    %eax,%esi
  801895:	e9 71 ff ff ff       	jmp    80180b <__umoddi3+0xb3>
  80189a:	66 90                	xchg   %ax,%ax
  80189c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018a0:	72 ea                	jb     80188c <__umoddi3+0x134>
  8018a2:	89 d9                	mov    %ebx,%ecx
  8018a4:	e9 62 ff ff ff       	jmp    80180b <__umoddi3+0xb3>
