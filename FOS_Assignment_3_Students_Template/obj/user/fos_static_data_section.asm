
obj/user/fos_static_data_section:     file format elf32-i386


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
  800031:	e8 1b 00 00 00       	call   800051 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:

/// Adding array of 20000 integer on user data section
int arr[20000];

void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	atomic_cprintf("user data section contains 20,000 integer\n");
  80003e:	83 ec 0c             	sub    $0xc,%esp
  800041:	68 c0 18 80 00       	push   $0x8018c0
  800046:	e8 23 02 00 00       	call   80026e <atomic_cprintf>
  80004b:	83 c4 10             	add    $0x10,%esp
	
	return;	
  80004e:	90                   	nop
}
  80004f:	c9                   	leave  
  800050:	c3                   	ret    

00800051 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800051:	55                   	push   %ebp
  800052:	89 e5                	mov    %esp,%ebp
  800054:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800057:	e8 10 10 00 00       	call   80106c <sys_getenvindex>
  80005c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80005f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800062:	89 d0                	mov    %edx,%eax
  800064:	01 c0                	add    %eax,%eax
  800066:	01 d0                	add    %edx,%eax
  800068:	c1 e0 04             	shl    $0x4,%eax
  80006b:	29 d0                	sub    %edx,%eax
  80006d:	c1 e0 03             	shl    $0x3,%eax
  800070:	01 d0                	add    %edx,%eax
  800072:	c1 e0 02             	shl    $0x2,%eax
  800075:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80007a:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80007f:	a1 20 20 80 00       	mov    0x802020,%eax
  800084:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80008a:	84 c0                	test   %al,%al
  80008c:	74 0f                	je     80009d <libmain+0x4c>
		binaryname = myEnv->prog_name;
  80008e:	a1 20 20 80 00       	mov    0x802020,%eax
  800093:	05 5c 05 00 00       	add    $0x55c,%eax
  800098:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80009d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000a1:	7e 0a                	jle    8000ad <libmain+0x5c>
		binaryname = argv[0];
  8000a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000a6:	8b 00                	mov    (%eax),%eax
  8000a8:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000ad:	83 ec 08             	sub    $0x8,%esp
  8000b0:	ff 75 0c             	pushl  0xc(%ebp)
  8000b3:	ff 75 08             	pushl  0x8(%ebp)
  8000b6:	e8 7d ff ff ff       	call   800038 <_main>
  8000bb:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000be:	e8 44 11 00 00       	call   801207 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000c3:	83 ec 0c             	sub    $0xc,%esp
  8000c6:	68 04 19 80 00       	push   $0x801904
  8000cb:	e8 71 01 00 00       	call   800241 <cprintf>
  8000d0:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8000d3:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d8:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8000de:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e3:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8000e9:	83 ec 04             	sub    $0x4,%esp
  8000ec:	52                   	push   %edx
  8000ed:	50                   	push   %eax
  8000ee:	68 2c 19 80 00       	push   $0x80192c
  8000f3:	e8 49 01 00 00       	call   800241 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8000fb:	a1 20 20 80 00       	mov    0x802020,%eax
  800100:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800106:	a1 20 20 80 00       	mov    0x802020,%eax
  80010b:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800111:	a1 20 20 80 00       	mov    0x802020,%eax
  800116:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80011c:	51                   	push   %ecx
  80011d:	52                   	push   %edx
  80011e:	50                   	push   %eax
  80011f:	68 54 19 80 00       	push   $0x801954
  800124:	e8 18 01 00 00       	call   800241 <cprintf>
  800129:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80012c:	83 ec 0c             	sub    $0xc,%esp
  80012f:	68 04 19 80 00       	push   $0x801904
  800134:	e8 08 01 00 00       	call   800241 <cprintf>
  800139:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80013c:	e8 e0 10 00 00       	call   801221 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800141:	e8 19 00 00 00       	call   80015f <exit>
}
  800146:	90                   	nop
  800147:	c9                   	leave  
  800148:	c3                   	ret    

00800149 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800149:	55                   	push   %ebp
  80014a:	89 e5                	mov    %esp,%ebp
  80014c:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80014f:	83 ec 0c             	sub    $0xc,%esp
  800152:	6a 00                	push   $0x0
  800154:	e8 df 0e 00 00       	call   801038 <sys_env_destroy>
  800159:	83 c4 10             	add    $0x10,%esp
}
  80015c:	90                   	nop
  80015d:	c9                   	leave  
  80015e:	c3                   	ret    

0080015f <exit>:

void
exit(void)
{
  80015f:	55                   	push   %ebp
  800160:	89 e5                	mov    %esp,%ebp
  800162:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800165:	e8 34 0f 00 00       	call   80109e <sys_env_exit>
}
  80016a:	90                   	nop
  80016b:	c9                   	leave  
  80016c:	c3                   	ret    

0080016d <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80016d:	55                   	push   %ebp
  80016e:	89 e5                	mov    %esp,%ebp
  800170:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800173:	8b 45 0c             	mov    0xc(%ebp),%eax
  800176:	8b 00                	mov    (%eax),%eax
  800178:	8d 48 01             	lea    0x1(%eax),%ecx
  80017b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80017e:	89 0a                	mov    %ecx,(%edx)
  800180:	8b 55 08             	mov    0x8(%ebp),%edx
  800183:	88 d1                	mov    %dl,%cl
  800185:	8b 55 0c             	mov    0xc(%ebp),%edx
  800188:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80018c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018f:	8b 00                	mov    (%eax),%eax
  800191:	3d ff 00 00 00       	cmp    $0xff,%eax
  800196:	75 2c                	jne    8001c4 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800198:	a0 24 20 80 00       	mov    0x802024,%al
  80019d:	0f b6 c0             	movzbl %al,%eax
  8001a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001a3:	8b 12                	mov    (%edx),%edx
  8001a5:	89 d1                	mov    %edx,%ecx
  8001a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001aa:	83 c2 08             	add    $0x8,%edx
  8001ad:	83 ec 04             	sub    $0x4,%esp
  8001b0:	50                   	push   %eax
  8001b1:	51                   	push   %ecx
  8001b2:	52                   	push   %edx
  8001b3:	e8 3e 0e 00 00       	call   800ff6 <sys_cputs>
  8001b8:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8001bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8001c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001c7:	8b 40 04             	mov    0x4(%eax),%eax
  8001ca:	8d 50 01             	lea    0x1(%eax),%edx
  8001cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d0:	89 50 04             	mov    %edx,0x4(%eax)
}
  8001d3:	90                   	nop
  8001d4:	c9                   	leave  
  8001d5:	c3                   	ret    

008001d6 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8001d6:	55                   	push   %ebp
  8001d7:	89 e5                	mov    %esp,%ebp
  8001d9:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8001df:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8001e6:	00 00 00 
	b.cnt = 0;
  8001e9:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8001f0:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8001f3:	ff 75 0c             	pushl  0xc(%ebp)
  8001f6:	ff 75 08             	pushl  0x8(%ebp)
  8001f9:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8001ff:	50                   	push   %eax
  800200:	68 6d 01 80 00       	push   $0x80016d
  800205:	e8 11 02 00 00       	call   80041b <vprintfmt>
  80020a:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80020d:	a0 24 20 80 00       	mov    0x802024,%al
  800212:	0f b6 c0             	movzbl %al,%eax
  800215:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80021b:	83 ec 04             	sub    $0x4,%esp
  80021e:	50                   	push   %eax
  80021f:	52                   	push   %edx
  800220:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800226:	83 c0 08             	add    $0x8,%eax
  800229:	50                   	push   %eax
  80022a:	e8 c7 0d 00 00       	call   800ff6 <sys_cputs>
  80022f:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800232:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800239:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80023f:	c9                   	leave  
  800240:	c3                   	ret    

00800241 <cprintf>:

int cprintf(const char *fmt, ...) {
  800241:	55                   	push   %ebp
  800242:	89 e5                	mov    %esp,%ebp
  800244:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800247:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  80024e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800251:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800254:	8b 45 08             	mov    0x8(%ebp),%eax
  800257:	83 ec 08             	sub    $0x8,%esp
  80025a:	ff 75 f4             	pushl  -0xc(%ebp)
  80025d:	50                   	push   %eax
  80025e:	e8 73 ff ff ff       	call   8001d6 <vcprintf>
  800263:	83 c4 10             	add    $0x10,%esp
  800266:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800269:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80026c:	c9                   	leave  
  80026d:	c3                   	ret    

0080026e <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80026e:	55                   	push   %ebp
  80026f:	89 e5                	mov    %esp,%ebp
  800271:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800274:	e8 8e 0f 00 00       	call   801207 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800279:	8d 45 0c             	lea    0xc(%ebp),%eax
  80027c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80027f:	8b 45 08             	mov    0x8(%ebp),%eax
  800282:	83 ec 08             	sub    $0x8,%esp
  800285:	ff 75 f4             	pushl  -0xc(%ebp)
  800288:	50                   	push   %eax
  800289:	e8 48 ff ff ff       	call   8001d6 <vcprintf>
  80028e:	83 c4 10             	add    $0x10,%esp
  800291:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800294:	e8 88 0f 00 00       	call   801221 <sys_enable_interrupt>
	return cnt;
  800299:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80029c:	c9                   	leave  
  80029d:	c3                   	ret    

0080029e <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80029e:	55                   	push   %ebp
  80029f:	89 e5                	mov    %esp,%ebp
  8002a1:	53                   	push   %ebx
  8002a2:	83 ec 14             	sub    $0x14,%esp
  8002a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8002ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002b1:	8b 45 18             	mov    0x18(%ebp),%eax
  8002b4:	ba 00 00 00 00       	mov    $0x0,%edx
  8002b9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002bc:	77 55                	ja     800313 <printnum+0x75>
  8002be:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8002c1:	72 05                	jb     8002c8 <printnum+0x2a>
  8002c3:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8002c6:	77 4b                	ja     800313 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8002c8:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8002cb:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8002ce:	8b 45 18             	mov    0x18(%ebp),%eax
  8002d1:	ba 00 00 00 00       	mov    $0x0,%edx
  8002d6:	52                   	push   %edx
  8002d7:	50                   	push   %eax
  8002d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002db:	ff 75 f0             	pushl  -0x10(%ebp)
  8002de:	e8 61 13 00 00       	call   801644 <__udivdi3>
  8002e3:	83 c4 10             	add    $0x10,%esp
  8002e6:	83 ec 04             	sub    $0x4,%esp
  8002e9:	ff 75 20             	pushl  0x20(%ebp)
  8002ec:	53                   	push   %ebx
  8002ed:	ff 75 18             	pushl  0x18(%ebp)
  8002f0:	52                   	push   %edx
  8002f1:	50                   	push   %eax
  8002f2:	ff 75 0c             	pushl  0xc(%ebp)
  8002f5:	ff 75 08             	pushl  0x8(%ebp)
  8002f8:	e8 a1 ff ff ff       	call   80029e <printnum>
  8002fd:	83 c4 20             	add    $0x20,%esp
  800300:	eb 1a                	jmp    80031c <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800302:	83 ec 08             	sub    $0x8,%esp
  800305:	ff 75 0c             	pushl  0xc(%ebp)
  800308:	ff 75 20             	pushl  0x20(%ebp)
  80030b:	8b 45 08             	mov    0x8(%ebp),%eax
  80030e:	ff d0                	call   *%eax
  800310:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800313:	ff 4d 1c             	decl   0x1c(%ebp)
  800316:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80031a:	7f e6                	jg     800302 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80031c:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80031f:	bb 00 00 00 00       	mov    $0x0,%ebx
  800324:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800327:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80032a:	53                   	push   %ebx
  80032b:	51                   	push   %ecx
  80032c:	52                   	push   %edx
  80032d:	50                   	push   %eax
  80032e:	e8 21 14 00 00       	call   801754 <__umoddi3>
  800333:	83 c4 10             	add    $0x10,%esp
  800336:	05 d4 1b 80 00       	add    $0x801bd4,%eax
  80033b:	8a 00                	mov    (%eax),%al
  80033d:	0f be c0             	movsbl %al,%eax
  800340:	83 ec 08             	sub    $0x8,%esp
  800343:	ff 75 0c             	pushl  0xc(%ebp)
  800346:	50                   	push   %eax
  800347:	8b 45 08             	mov    0x8(%ebp),%eax
  80034a:	ff d0                	call   *%eax
  80034c:	83 c4 10             	add    $0x10,%esp
}
  80034f:	90                   	nop
  800350:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800353:	c9                   	leave  
  800354:	c3                   	ret    

00800355 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800355:	55                   	push   %ebp
  800356:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800358:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80035c:	7e 1c                	jle    80037a <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80035e:	8b 45 08             	mov    0x8(%ebp),%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	8d 50 08             	lea    0x8(%eax),%edx
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	89 10                	mov    %edx,(%eax)
  80036b:	8b 45 08             	mov    0x8(%ebp),%eax
  80036e:	8b 00                	mov    (%eax),%eax
  800370:	83 e8 08             	sub    $0x8,%eax
  800373:	8b 50 04             	mov    0x4(%eax),%edx
  800376:	8b 00                	mov    (%eax),%eax
  800378:	eb 40                	jmp    8003ba <getuint+0x65>
	else if (lflag)
  80037a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80037e:	74 1e                	je     80039e <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800380:	8b 45 08             	mov    0x8(%ebp),%eax
  800383:	8b 00                	mov    (%eax),%eax
  800385:	8d 50 04             	lea    0x4(%eax),%edx
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	89 10                	mov    %edx,(%eax)
  80038d:	8b 45 08             	mov    0x8(%ebp),%eax
  800390:	8b 00                	mov    (%eax),%eax
  800392:	83 e8 04             	sub    $0x4,%eax
  800395:	8b 00                	mov    (%eax),%eax
  800397:	ba 00 00 00 00       	mov    $0x0,%edx
  80039c:	eb 1c                	jmp    8003ba <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80039e:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a1:	8b 00                	mov    (%eax),%eax
  8003a3:	8d 50 04             	lea    0x4(%eax),%edx
  8003a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a9:	89 10                	mov    %edx,(%eax)
  8003ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ae:	8b 00                	mov    (%eax),%eax
  8003b0:	83 e8 04             	sub    $0x4,%eax
  8003b3:	8b 00                	mov    (%eax),%eax
  8003b5:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003ba:	5d                   	pop    %ebp
  8003bb:	c3                   	ret    

008003bc <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8003bc:	55                   	push   %ebp
  8003bd:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003bf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003c3:	7e 1c                	jle    8003e1 <getint+0x25>
		return va_arg(*ap, long long);
  8003c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c8:	8b 00                	mov    (%eax),%eax
  8003ca:	8d 50 08             	lea    0x8(%eax),%edx
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	89 10                	mov    %edx,(%eax)
  8003d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d5:	8b 00                	mov    (%eax),%eax
  8003d7:	83 e8 08             	sub    $0x8,%eax
  8003da:	8b 50 04             	mov    0x4(%eax),%edx
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	eb 38                	jmp    800419 <getint+0x5d>
	else if (lflag)
  8003e1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003e5:	74 1a                	je     800401 <getint+0x45>
		return va_arg(*ap, long);
  8003e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ea:	8b 00                	mov    (%eax),%eax
  8003ec:	8d 50 04             	lea    0x4(%eax),%edx
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	89 10                	mov    %edx,(%eax)
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	83 e8 04             	sub    $0x4,%eax
  8003fc:	8b 00                	mov    (%eax),%eax
  8003fe:	99                   	cltd   
  8003ff:	eb 18                	jmp    800419 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800401:	8b 45 08             	mov    0x8(%ebp),%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	8d 50 04             	lea    0x4(%eax),%edx
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	89 10                	mov    %edx,(%eax)
  80040e:	8b 45 08             	mov    0x8(%ebp),%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	83 e8 04             	sub    $0x4,%eax
  800416:	8b 00                	mov    (%eax),%eax
  800418:	99                   	cltd   
}
  800419:	5d                   	pop    %ebp
  80041a:	c3                   	ret    

0080041b <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80041b:	55                   	push   %ebp
  80041c:	89 e5                	mov    %esp,%ebp
  80041e:	56                   	push   %esi
  80041f:	53                   	push   %ebx
  800420:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800423:	eb 17                	jmp    80043c <vprintfmt+0x21>
			if (ch == '\0')
  800425:	85 db                	test   %ebx,%ebx
  800427:	0f 84 af 03 00 00    	je     8007dc <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80042d:	83 ec 08             	sub    $0x8,%esp
  800430:	ff 75 0c             	pushl  0xc(%ebp)
  800433:	53                   	push   %ebx
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	ff d0                	call   *%eax
  800439:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80043c:	8b 45 10             	mov    0x10(%ebp),%eax
  80043f:	8d 50 01             	lea    0x1(%eax),%edx
  800442:	89 55 10             	mov    %edx,0x10(%ebp)
  800445:	8a 00                	mov    (%eax),%al
  800447:	0f b6 d8             	movzbl %al,%ebx
  80044a:	83 fb 25             	cmp    $0x25,%ebx
  80044d:	75 d6                	jne    800425 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80044f:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800453:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80045a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800461:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800468:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80046f:	8b 45 10             	mov    0x10(%ebp),%eax
  800472:	8d 50 01             	lea    0x1(%eax),%edx
  800475:	89 55 10             	mov    %edx,0x10(%ebp)
  800478:	8a 00                	mov    (%eax),%al
  80047a:	0f b6 d8             	movzbl %al,%ebx
  80047d:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800480:	83 f8 55             	cmp    $0x55,%eax
  800483:	0f 87 2b 03 00 00    	ja     8007b4 <vprintfmt+0x399>
  800489:	8b 04 85 f8 1b 80 00 	mov    0x801bf8(,%eax,4),%eax
  800490:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800492:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800496:	eb d7                	jmp    80046f <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800498:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80049c:	eb d1                	jmp    80046f <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80049e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004a5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004a8:	89 d0                	mov    %edx,%eax
  8004aa:	c1 e0 02             	shl    $0x2,%eax
  8004ad:	01 d0                	add    %edx,%eax
  8004af:	01 c0                	add    %eax,%eax
  8004b1:	01 d8                	add    %ebx,%eax
  8004b3:	83 e8 30             	sub    $0x30,%eax
  8004b6:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004bc:	8a 00                	mov    (%eax),%al
  8004be:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8004c1:	83 fb 2f             	cmp    $0x2f,%ebx
  8004c4:	7e 3e                	jle    800504 <vprintfmt+0xe9>
  8004c6:	83 fb 39             	cmp    $0x39,%ebx
  8004c9:	7f 39                	jg     800504 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004cb:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8004ce:	eb d5                	jmp    8004a5 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8004d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8004d3:	83 c0 04             	add    $0x4,%eax
  8004d6:	89 45 14             	mov    %eax,0x14(%ebp)
  8004d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8004dc:	83 e8 04             	sub    $0x4,%eax
  8004df:	8b 00                	mov    (%eax),%eax
  8004e1:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8004e4:	eb 1f                	jmp    800505 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8004e6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8004ea:	79 83                	jns    80046f <vprintfmt+0x54>
				width = 0;
  8004ec:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8004f3:	e9 77 ff ff ff       	jmp    80046f <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8004f8:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8004ff:	e9 6b ff ff ff       	jmp    80046f <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800504:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800505:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800509:	0f 89 60 ff ff ff    	jns    80046f <vprintfmt+0x54>
				width = precision, precision = -1;
  80050f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800512:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800515:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80051c:	e9 4e ff ff ff       	jmp    80046f <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800521:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800524:	e9 46 ff ff ff       	jmp    80046f <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800529:	8b 45 14             	mov    0x14(%ebp),%eax
  80052c:	83 c0 04             	add    $0x4,%eax
  80052f:	89 45 14             	mov    %eax,0x14(%ebp)
  800532:	8b 45 14             	mov    0x14(%ebp),%eax
  800535:	83 e8 04             	sub    $0x4,%eax
  800538:	8b 00                	mov    (%eax),%eax
  80053a:	83 ec 08             	sub    $0x8,%esp
  80053d:	ff 75 0c             	pushl  0xc(%ebp)
  800540:	50                   	push   %eax
  800541:	8b 45 08             	mov    0x8(%ebp),%eax
  800544:	ff d0                	call   *%eax
  800546:	83 c4 10             	add    $0x10,%esp
			break;
  800549:	e9 89 02 00 00       	jmp    8007d7 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80054e:	8b 45 14             	mov    0x14(%ebp),%eax
  800551:	83 c0 04             	add    $0x4,%eax
  800554:	89 45 14             	mov    %eax,0x14(%ebp)
  800557:	8b 45 14             	mov    0x14(%ebp),%eax
  80055a:	83 e8 04             	sub    $0x4,%eax
  80055d:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80055f:	85 db                	test   %ebx,%ebx
  800561:	79 02                	jns    800565 <vprintfmt+0x14a>
				err = -err;
  800563:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800565:	83 fb 64             	cmp    $0x64,%ebx
  800568:	7f 0b                	jg     800575 <vprintfmt+0x15a>
  80056a:	8b 34 9d 40 1a 80 00 	mov    0x801a40(,%ebx,4),%esi
  800571:	85 f6                	test   %esi,%esi
  800573:	75 19                	jne    80058e <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800575:	53                   	push   %ebx
  800576:	68 e5 1b 80 00       	push   $0x801be5
  80057b:	ff 75 0c             	pushl  0xc(%ebp)
  80057e:	ff 75 08             	pushl  0x8(%ebp)
  800581:	e8 5e 02 00 00       	call   8007e4 <printfmt>
  800586:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800589:	e9 49 02 00 00       	jmp    8007d7 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80058e:	56                   	push   %esi
  80058f:	68 ee 1b 80 00       	push   $0x801bee
  800594:	ff 75 0c             	pushl  0xc(%ebp)
  800597:	ff 75 08             	pushl  0x8(%ebp)
  80059a:	e8 45 02 00 00       	call   8007e4 <printfmt>
  80059f:	83 c4 10             	add    $0x10,%esp
			break;
  8005a2:	e9 30 02 00 00       	jmp    8007d7 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005a7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005aa:	83 c0 04             	add    $0x4,%eax
  8005ad:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b3:	83 e8 04             	sub    $0x4,%eax
  8005b6:	8b 30                	mov    (%eax),%esi
  8005b8:	85 f6                	test   %esi,%esi
  8005ba:	75 05                	jne    8005c1 <vprintfmt+0x1a6>
				p = "(null)";
  8005bc:	be f1 1b 80 00       	mov    $0x801bf1,%esi
			if (width > 0 && padc != '-')
  8005c1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005c5:	7e 6d                	jle    800634 <vprintfmt+0x219>
  8005c7:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8005cb:	74 67                	je     800634 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8005cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005d0:	83 ec 08             	sub    $0x8,%esp
  8005d3:	50                   	push   %eax
  8005d4:	56                   	push   %esi
  8005d5:	e8 0c 03 00 00       	call   8008e6 <strnlen>
  8005da:	83 c4 10             	add    $0x10,%esp
  8005dd:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8005e0:	eb 16                	jmp    8005f8 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8005e2:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8005e6:	83 ec 08             	sub    $0x8,%esp
  8005e9:	ff 75 0c             	pushl  0xc(%ebp)
  8005ec:	50                   	push   %eax
  8005ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f0:	ff d0                	call   *%eax
  8005f2:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8005f5:	ff 4d e4             	decl   -0x1c(%ebp)
  8005f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005fc:	7f e4                	jg     8005e2 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8005fe:	eb 34                	jmp    800634 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800600:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800604:	74 1c                	je     800622 <vprintfmt+0x207>
  800606:	83 fb 1f             	cmp    $0x1f,%ebx
  800609:	7e 05                	jle    800610 <vprintfmt+0x1f5>
  80060b:	83 fb 7e             	cmp    $0x7e,%ebx
  80060e:	7e 12                	jle    800622 <vprintfmt+0x207>
					putch('?', putdat);
  800610:	83 ec 08             	sub    $0x8,%esp
  800613:	ff 75 0c             	pushl  0xc(%ebp)
  800616:	6a 3f                	push   $0x3f
  800618:	8b 45 08             	mov    0x8(%ebp),%eax
  80061b:	ff d0                	call   *%eax
  80061d:	83 c4 10             	add    $0x10,%esp
  800620:	eb 0f                	jmp    800631 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800622:	83 ec 08             	sub    $0x8,%esp
  800625:	ff 75 0c             	pushl  0xc(%ebp)
  800628:	53                   	push   %ebx
  800629:	8b 45 08             	mov    0x8(%ebp),%eax
  80062c:	ff d0                	call   *%eax
  80062e:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800631:	ff 4d e4             	decl   -0x1c(%ebp)
  800634:	89 f0                	mov    %esi,%eax
  800636:	8d 70 01             	lea    0x1(%eax),%esi
  800639:	8a 00                	mov    (%eax),%al
  80063b:	0f be d8             	movsbl %al,%ebx
  80063e:	85 db                	test   %ebx,%ebx
  800640:	74 24                	je     800666 <vprintfmt+0x24b>
  800642:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800646:	78 b8                	js     800600 <vprintfmt+0x1e5>
  800648:	ff 4d e0             	decl   -0x20(%ebp)
  80064b:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80064f:	79 af                	jns    800600 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800651:	eb 13                	jmp    800666 <vprintfmt+0x24b>
				putch(' ', putdat);
  800653:	83 ec 08             	sub    $0x8,%esp
  800656:	ff 75 0c             	pushl  0xc(%ebp)
  800659:	6a 20                	push   $0x20
  80065b:	8b 45 08             	mov    0x8(%ebp),%eax
  80065e:	ff d0                	call   *%eax
  800660:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800663:	ff 4d e4             	decl   -0x1c(%ebp)
  800666:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066a:	7f e7                	jg     800653 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80066c:	e9 66 01 00 00       	jmp    8007d7 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800671:	83 ec 08             	sub    $0x8,%esp
  800674:	ff 75 e8             	pushl  -0x18(%ebp)
  800677:	8d 45 14             	lea    0x14(%ebp),%eax
  80067a:	50                   	push   %eax
  80067b:	e8 3c fd ff ff       	call   8003bc <getint>
  800680:	83 c4 10             	add    $0x10,%esp
  800683:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800686:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800689:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80068c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80068f:	85 d2                	test   %edx,%edx
  800691:	79 23                	jns    8006b6 <vprintfmt+0x29b>
				putch('-', putdat);
  800693:	83 ec 08             	sub    $0x8,%esp
  800696:	ff 75 0c             	pushl  0xc(%ebp)
  800699:	6a 2d                	push   $0x2d
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	ff d0                	call   *%eax
  8006a0:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006a6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006a9:	f7 d8                	neg    %eax
  8006ab:	83 d2 00             	adc    $0x0,%edx
  8006ae:	f7 da                	neg    %edx
  8006b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006b3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006b6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006bd:	e9 bc 00 00 00       	jmp    80077e <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8006c2:	83 ec 08             	sub    $0x8,%esp
  8006c5:	ff 75 e8             	pushl  -0x18(%ebp)
  8006c8:	8d 45 14             	lea    0x14(%ebp),%eax
  8006cb:	50                   	push   %eax
  8006cc:	e8 84 fc ff ff       	call   800355 <getuint>
  8006d1:	83 c4 10             	add    $0x10,%esp
  8006d4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006d7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8006da:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8006e1:	e9 98 00 00 00       	jmp    80077e <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8006e6:	83 ec 08             	sub    $0x8,%esp
  8006e9:	ff 75 0c             	pushl  0xc(%ebp)
  8006ec:	6a 58                	push   $0x58
  8006ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f1:	ff d0                	call   *%eax
  8006f3:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8006f6:	83 ec 08             	sub    $0x8,%esp
  8006f9:	ff 75 0c             	pushl  0xc(%ebp)
  8006fc:	6a 58                	push   $0x58
  8006fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800701:	ff d0                	call   *%eax
  800703:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800706:	83 ec 08             	sub    $0x8,%esp
  800709:	ff 75 0c             	pushl  0xc(%ebp)
  80070c:	6a 58                	push   $0x58
  80070e:	8b 45 08             	mov    0x8(%ebp),%eax
  800711:	ff d0                	call   *%eax
  800713:	83 c4 10             	add    $0x10,%esp
			break;
  800716:	e9 bc 00 00 00       	jmp    8007d7 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80071b:	83 ec 08             	sub    $0x8,%esp
  80071e:	ff 75 0c             	pushl  0xc(%ebp)
  800721:	6a 30                	push   $0x30
  800723:	8b 45 08             	mov    0x8(%ebp),%eax
  800726:	ff d0                	call   *%eax
  800728:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80072b:	83 ec 08             	sub    $0x8,%esp
  80072e:	ff 75 0c             	pushl  0xc(%ebp)
  800731:	6a 78                	push   $0x78
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	ff d0                	call   *%eax
  800738:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80073b:	8b 45 14             	mov    0x14(%ebp),%eax
  80073e:	83 c0 04             	add    $0x4,%eax
  800741:	89 45 14             	mov    %eax,0x14(%ebp)
  800744:	8b 45 14             	mov    0x14(%ebp),%eax
  800747:	83 e8 04             	sub    $0x4,%eax
  80074a:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  80074c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80074f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800756:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  80075d:	eb 1f                	jmp    80077e <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80075f:	83 ec 08             	sub    $0x8,%esp
  800762:	ff 75 e8             	pushl  -0x18(%ebp)
  800765:	8d 45 14             	lea    0x14(%ebp),%eax
  800768:	50                   	push   %eax
  800769:	e8 e7 fb ff ff       	call   800355 <getuint>
  80076e:	83 c4 10             	add    $0x10,%esp
  800771:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800774:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800777:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80077e:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800782:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800785:	83 ec 04             	sub    $0x4,%esp
  800788:	52                   	push   %edx
  800789:	ff 75 e4             	pushl  -0x1c(%ebp)
  80078c:	50                   	push   %eax
  80078d:	ff 75 f4             	pushl  -0xc(%ebp)
  800790:	ff 75 f0             	pushl  -0x10(%ebp)
  800793:	ff 75 0c             	pushl  0xc(%ebp)
  800796:	ff 75 08             	pushl  0x8(%ebp)
  800799:	e8 00 fb ff ff       	call   80029e <printnum>
  80079e:	83 c4 20             	add    $0x20,%esp
			break;
  8007a1:	eb 34                	jmp    8007d7 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007a3:	83 ec 08             	sub    $0x8,%esp
  8007a6:	ff 75 0c             	pushl  0xc(%ebp)
  8007a9:	53                   	push   %ebx
  8007aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ad:	ff d0                	call   *%eax
  8007af:	83 c4 10             	add    $0x10,%esp
			break;
  8007b2:	eb 23                	jmp    8007d7 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007b4:	83 ec 08             	sub    $0x8,%esp
  8007b7:	ff 75 0c             	pushl  0xc(%ebp)
  8007ba:	6a 25                	push   $0x25
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	ff d0                	call   *%eax
  8007c1:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8007c4:	ff 4d 10             	decl   0x10(%ebp)
  8007c7:	eb 03                	jmp    8007cc <vprintfmt+0x3b1>
  8007c9:	ff 4d 10             	decl   0x10(%ebp)
  8007cc:	8b 45 10             	mov    0x10(%ebp),%eax
  8007cf:	48                   	dec    %eax
  8007d0:	8a 00                	mov    (%eax),%al
  8007d2:	3c 25                	cmp    $0x25,%al
  8007d4:	75 f3                	jne    8007c9 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8007d6:	90                   	nop
		}
	}
  8007d7:	e9 47 fc ff ff       	jmp    800423 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8007dc:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8007dd:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8007e0:	5b                   	pop    %ebx
  8007e1:	5e                   	pop    %esi
  8007e2:	5d                   	pop    %ebp
  8007e3:	c3                   	ret    

008007e4 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8007e4:	55                   	push   %ebp
  8007e5:	89 e5                	mov    %esp,%ebp
  8007e7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8007ea:	8d 45 10             	lea    0x10(%ebp),%eax
  8007ed:	83 c0 04             	add    $0x4,%eax
  8007f0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8007f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f9:	50                   	push   %eax
  8007fa:	ff 75 0c             	pushl  0xc(%ebp)
  8007fd:	ff 75 08             	pushl  0x8(%ebp)
  800800:	e8 16 fc ff ff       	call   80041b <vprintfmt>
  800805:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800808:	90                   	nop
  800809:	c9                   	leave  
  80080a:	c3                   	ret    

0080080b <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80080b:	55                   	push   %ebp
  80080c:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80080e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800811:	8b 40 08             	mov    0x8(%eax),%eax
  800814:	8d 50 01             	lea    0x1(%eax),%edx
  800817:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081a:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80081d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800820:	8b 10                	mov    (%eax),%edx
  800822:	8b 45 0c             	mov    0xc(%ebp),%eax
  800825:	8b 40 04             	mov    0x4(%eax),%eax
  800828:	39 c2                	cmp    %eax,%edx
  80082a:	73 12                	jae    80083e <sprintputch+0x33>
		*b->buf++ = ch;
  80082c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80082f:	8b 00                	mov    (%eax),%eax
  800831:	8d 48 01             	lea    0x1(%eax),%ecx
  800834:	8b 55 0c             	mov    0xc(%ebp),%edx
  800837:	89 0a                	mov    %ecx,(%edx)
  800839:	8b 55 08             	mov    0x8(%ebp),%edx
  80083c:	88 10                	mov    %dl,(%eax)
}
  80083e:	90                   	nop
  80083f:	5d                   	pop    %ebp
  800840:	c3                   	ret    

00800841 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800841:	55                   	push   %ebp
  800842:	89 e5                	mov    %esp,%ebp
  800844:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800847:	8b 45 08             	mov    0x8(%ebp),%eax
  80084a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80084d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800850:	8d 50 ff             	lea    -0x1(%eax),%edx
  800853:	8b 45 08             	mov    0x8(%ebp),%eax
  800856:	01 d0                	add    %edx,%eax
  800858:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80085b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800862:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800866:	74 06                	je     80086e <vsnprintf+0x2d>
  800868:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80086c:	7f 07                	jg     800875 <vsnprintf+0x34>
		return -E_INVAL;
  80086e:	b8 03 00 00 00       	mov    $0x3,%eax
  800873:	eb 20                	jmp    800895 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800875:	ff 75 14             	pushl  0x14(%ebp)
  800878:	ff 75 10             	pushl  0x10(%ebp)
  80087b:	8d 45 ec             	lea    -0x14(%ebp),%eax
  80087e:	50                   	push   %eax
  80087f:	68 0b 08 80 00       	push   $0x80080b
  800884:	e8 92 fb ff ff       	call   80041b <vprintfmt>
  800889:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80088c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80088f:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800892:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800895:	c9                   	leave  
  800896:	c3                   	ret    

00800897 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800897:	55                   	push   %ebp
  800898:	89 e5                	mov    %esp,%ebp
  80089a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80089d:	8d 45 10             	lea    0x10(%ebp),%eax
  8008a0:	83 c0 04             	add    $0x4,%eax
  8008a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8008a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8008ac:	50                   	push   %eax
  8008ad:	ff 75 0c             	pushl  0xc(%ebp)
  8008b0:	ff 75 08             	pushl  0x8(%ebp)
  8008b3:	e8 89 ff ff ff       	call   800841 <vsnprintf>
  8008b8:	83 c4 10             	add    $0x10,%esp
  8008bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8008be:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8008c1:	c9                   	leave  
  8008c2:	c3                   	ret    

008008c3 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8008c3:	55                   	push   %ebp
  8008c4:	89 e5                	mov    %esp,%ebp
  8008c6:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8008c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008d0:	eb 06                	jmp    8008d8 <strlen+0x15>
		n++;
  8008d2:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8008d5:	ff 45 08             	incl   0x8(%ebp)
  8008d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008db:	8a 00                	mov    (%eax),%al
  8008dd:	84 c0                	test   %al,%al
  8008df:	75 f1                	jne    8008d2 <strlen+0xf>
		n++;
	return n;
  8008e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8008e4:	c9                   	leave  
  8008e5:	c3                   	ret    

008008e6 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8008e6:	55                   	push   %ebp
  8008e7:	89 e5                	mov    %esp,%ebp
  8008e9:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8008f3:	eb 09                	jmp    8008fe <strnlen+0x18>
		n++;
  8008f5:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8008f8:	ff 45 08             	incl   0x8(%ebp)
  8008fb:	ff 4d 0c             	decl   0xc(%ebp)
  8008fe:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800902:	74 09                	je     80090d <strnlen+0x27>
  800904:	8b 45 08             	mov    0x8(%ebp),%eax
  800907:	8a 00                	mov    (%eax),%al
  800909:	84 c0                	test   %al,%al
  80090b:	75 e8                	jne    8008f5 <strnlen+0xf>
		n++;
	return n;
  80090d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800910:	c9                   	leave  
  800911:	c3                   	ret    

00800912 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800912:	55                   	push   %ebp
  800913:	89 e5                	mov    %esp,%ebp
  800915:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800918:	8b 45 08             	mov    0x8(%ebp),%eax
  80091b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80091e:	90                   	nop
  80091f:	8b 45 08             	mov    0x8(%ebp),%eax
  800922:	8d 50 01             	lea    0x1(%eax),%edx
  800925:	89 55 08             	mov    %edx,0x8(%ebp)
  800928:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80092e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800931:	8a 12                	mov    (%edx),%dl
  800933:	88 10                	mov    %dl,(%eax)
  800935:	8a 00                	mov    (%eax),%al
  800937:	84 c0                	test   %al,%al
  800939:	75 e4                	jne    80091f <strcpy+0xd>
		/* do nothing */;
	return ret;
  80093b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80093e:	c9                   	leave  
  80093f:	c3                   	ret    

00800940 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800940:	55                   	push   %ebp
  800941:	89 e5                	mov    %esp,%ebp
  800943:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800946:	8b 45 08             	mov    0x8(%ebp),%eax
  800949:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80094c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800953:	eb 1f                	jmp    800974 <strncpy+0x34>
		*dst++ = *src;
  800955:	8b 45 08             	mov    0x8(%ebp),%eax
  800958:	8d 50 01             	lea    0x1(%eax),%edx
  80095b:	89 55 08             	mov    %edx,0x8(%ebp)
  80095e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800961:	8a 12                	mov    (%edx),%dl
  800963:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800965:	8b 45 0c             	mov    0xc(%ebp),%eax
  800968:	8a 00                	mov    (%eax),%al
  80096a:	84 c0                	test   %al,%al
  80096c:	74 03                	je     800971 <strncpy+0x31>
			src++;
  80096e:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800971:	ff 45 fc             	incl   -0x4(%ebp)
  800974:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800977:	3b 45 10             	cmp    0x10(%ebp),%eax
  80097a:	72 d9                	jb     800955 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80097c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80097f:	c9                   	leave  
  800980:	c3                   	ret    

00800981 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800981:	55                   	push   %ebp
  800982:	89 e5                	mov    %esp,%ebp
  800984:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80098d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800991:	74 30                	je     8009c3 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800993:	eb 16                	jmp    8009ab <strlcpy+0x2a>
			*dst++ = *src++;
  800995:	8b 45 08             	mov    0x8(%ebp),%eax
  800998:	8d 50 01             	lea    0x1(%eax),%edx
  80099b:	89 55 08             	mov    %edx,0x8(%ebp)
  80099e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a1:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009a4:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009a7:	8a 12                	mov    (%edx),%dl
  8009a9:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009ab:	ff 4d 10             	decl   0x10(%ebp)
  8009ae:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009b2:	74 09                	je     8009bd <strlcpy+0x3c>
  8009b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b7:	8a 00                	mov    (%eax),%al
  8009b9:	84 c0                	test   %al,%al
  8009bb:	75 d8                	jne    800995 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8009bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c0:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8009c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8009c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009c9:	29 c2                	sub    %eax,%edx
  8009cb:	89 d0                	mov    %edx,%eax
}
  8009cd:	c9                   	leave  
  8009ce:	c3                   	ret    

008009cf <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8009cf:	55                   	push   %ebp
  8009d0:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8009d2:	eb 06                	jmp    8009da <strcmp+0xb>
		p++, q++;
  8009d4:	ff 45 08             	incl   0x8(%ebp)
  8009d7:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	8a 00                	mov    (%eax),%al
  8009df:	84 c0                	test   %al,%al
  8009e1:	74 0e                	je     8009f1 <strcmp+0x22>
  8009e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e6:	8a 10                	mov    (%eax),%dl
  8009e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009eb:	8a 00                	mov    (%eax),%al
  8009ed:	38 c2                	cmp    %al,%dl
  8009ef:	74 e3                	je     8009d4 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8009f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f4:	8a 00                	mov    (%eax),%al
  8009f6:	0f b6 d0             	movzbl %al,%edx
  8009f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fc:	8a 00                	mov    (%eax),%al
  8009fe:	0f b6 c0             	movzbl %al,%eax
  800a01:	29 c2                	sub    %eax,%edx
  800a03:	89 d0                	mov    %edx,%eax
}
  800a05:	5d                   	pop    %ebp
  800a06:	c3                   	ret    

00800a07 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a07:	55                   	push   %ebp
  800a08:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a0a:	eb 09                	jmp    800a15 <strncmp+0xe>
		n--, p++, q++;
  800a0c:	ff 4d 10             	decl   0x10(%ebp)
  800a0f:	ff 45 08             	incl   0x8(%ebp)
  800a12:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a15:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a19:	74 17                	je     800a32 <strncmp+0x2b>
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	8a 00                	mov    (%eax),%al
  800a20:	84 c0                	test   %al,%al
  800a22:	74 0e                	je     800a32 <strncmp+0x2b>
  800a24:	8b 45 08             	mov    0x8(%ebp),%eax
  800a27:	8a 10                	mov    (%eax),%dl
  800a29:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2c:	8a 00                	mov    (%eax),%al
  800a2e:	38 c2                	cmp    %al,%dl
  800a30:	74 da                	je     800a0c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a32:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a36:	75 07                	jne    800a3f <strncmp+0x38>
		return 0;
  800a38:	b8 00 00 00 00       	mov    $0x0,%eax
  800a3d:	eb 14                	jmp    800a53 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a42:	8a 00                	mov    (%eax),%al
  800a44:	0f b6 d0             	movzbl %al,%edx
  800a47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4a:	8a 00                	mov    (%eax),%al
  800a4c:	0f b6 c0             	movzbl %al,%eax
  800a4f:	29 c2                	sub    %eax,%edx
  800a51:	89 d0                	mov    %edx,%eax
}
  800a53:	5d                   	pop    %ebp
  800a54:	c3                   	ret    

00800a55 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a55:	55                   	push   %ebp
  800a56:	89 e5                	mov    %esp,%ebp
  800a58:	83 ec 04             	sub    $0x4,%esp
  800a5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a61:	eb 12                	jmp    800a75 <strchr+0x20>
		if (*s == c)
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	8a 00                	mov    (%eax),%al
  800a68:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a6b:	75 05                	jne    800a72 <strchr+0x1d>
			return (char *) s;
  800a6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a70:	eb 11                	jmp    800a83 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800a72:	ff 45 08             	incl   0x8(%ebp)
  800a75:	8b 45 08             	mov    0x8(%ebp),%eax
  800a78:	8a 00                	mov    (%eax),%al
  800a7a:	84 c0                	test   %al,%al
  800a7c:	75 e5                	jne    800a63 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800a7e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800a83:	c9                   	leave  
  800a84:	c3                   	ret    

00800a85 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800a85:	55                   	push   %ebp
  800a86:	89 e5                	mov    %esp,%ebp
  800a88:	83 ec 04             	sub    $0x4,%esp
  800a8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800a91:	eb 0d                	jmp    800aa0 <strfind+0x1b>
		if (*s == c)
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	8a 00                	mov    (%eax),%al
  800a98:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800a9b:	74 0e                	je     800aab <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800a9d:	ff 45 08             	incl   0x8(%ebp)
  800aa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa3:	8a 00                	mov    (%eax),%al
  800aa5:	84 c0                	test   %al,%al
  800aa7:	75 ea                	jne    800a93 <strfind+0xe>
  800aa9:	eb 01                	jmp    800aac <strfind+0x27>
		if (*s == c)
			break;
  800aab:	90                   	nop
	return (char *) s;
  800aac:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800aaf:	c9                   	leave  
  800ab0:	c3                   	ret    

00800ab1 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ab1:	55                   	push   %ebp
  800ab2:	89 e5                	mov    %esp,%ebp
  800ab4:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800ab7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800abd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800ac3:	eb 0e                	jmp    800ad3 <memset+0x22>
		*p++ = c;
  800ac5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ac8:	8d 50 01             	lea    0x1(%eax),%edx
  800acb:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ace:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad1:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800ad3:	ff 4d f8             	decl   -0x8(%ebp)
  800ad6:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800ada:	79 e9                	jns    800ac5 <memset+0x14>
		*p++ = c;

	return v;
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800adf:	c9                   	leave  
  800ae0:	c3                   	ret    

00800ae1 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ae1:	55                   	push   %ebp
  800ae2:	89 e5                	mov    %esp,%ebp
  800ae4:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800af3:	eb 16                	jmp    800b0b <memcpy+0x2a>
		*d++ = *s++;
  800af5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800af8:	8d 50 01             	lea    0x1(%eax),%edx
  800afb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800afe:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b01:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b04:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b07:	8a 12                	mov    (%edx),%dl
  800b09:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b0b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b0e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b11:	89 55 10             	mov    %edx,0x10(%ebp)
  800b14:	85 c0                	test   %eax,%eax
  800b16:	75 dd                	jne    800af5 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b1b:	c9                   	leave  
  800b1c:	c3                   	ret    

00800b1d <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b1d:	55                   	push   %ebp
  800b1e:	89 e5                	mov    %esp,%ebp
  800b20:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b26:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b2f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b32:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b35:	73 50                	jae    800b87 <memmove+0x6a>
  800b37:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b3a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3d:	01 d0                	add    %edx,%eax
  800b3f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b42:	76 43                	jbe    800b87 <memmove+0x6a>
		s += n;
  800b44:	8b 45 10             	mov    0x10(%ebp),%eax
  800b47:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b4d:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b50:	eb 10                	jmp    800b62 <memmove+0x45>
			*--d = *--s;
  800b52:	ff 4d f8             	decl   -0x8(%ebp)
  800b55:	ff 4d fc             	decl   -0x4(%ebp)
  800b58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b5b:	8a 10                	mov    (%eax),%dl
  800b5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b60:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800b62:	8b 45 10             	mov    0x10(%ebp),%eax
  800b65:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b68:	89 55 10             	mov    %edx,0x10(%ebp)
  800b6b:	85 c0                	test   %eax,%eax
  800b6d:	75 e3                	jne    800b52 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800b6f:	eb 23                	jmp    800b94 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800b71:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b74:	8d 50 01             	lea    0x1(%eax),%edx
  800b77:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b7d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b80:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b83:	8a 12                	mov    (%edx),%dl
  800b85:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800b87:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b8d:	89 55 10             	mov    %edx,0x10(%ebp)
  800b90:	85 c0                	test   %eax,%eax
  800b92:	75 dd                	jne    800b71 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b97:	c9                   	leave  
  800b98:	c3                   	ret    

00800b99 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800b99:	55                   	push   %ebp
  800b9a:	89 e5                	mov    %esp,%ebp
  800b9c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800ba5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba8:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bab:	eb 2a                	jmp    800bd7 <memcmp+0x3e>
		if (*s1 != *s2)
  800bad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb0:	8a 10                	mov    (%eax),%dl
  800bb2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb5:	8a 00                	mov    (%eax),%al
  800bb7:	38 c2                	cmp    %al,%dl
  800bb9:	74 16                	je     800bd1 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800bbb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bbe:	8a 00                	mov    (%eax),%al
  800bc0:	0f b6 d0             	movzbl %al,%edx
  800bc3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bc6:	8a 00                	mov    (%eax),%al
  800bc8:	0f b6 c0             	movzbl %al,%eax
  800bcb:	29 c2                	sub    %eax,%edx
  800bcd:	89 d0                	mov    %edx,%eax
  800bcf:	eb 18                	jmp    800be9 <memcmp+0x50>
		s1++, s2++;
  800bd1:	ff 45 fc             	incl   -0x4(%ebp)
  800bd4:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800bd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800bda:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bdd:	89 55 10             	mov    %edx,0x10(%ebp)
  800be0:	85 c0                	test   %eax,%eax
  800be2:	75 c9                	jne    800bad <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800be4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800be9:	c9                   	leave  
  800bea:	c3                   	ret    

00800beb <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800beb:	55                   	push   %ebp
  800bec:	89 e5                	mov    %esp,%ebp
  800bee:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800bf1:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf7:	01 d0                	add    %edx,%eax
  800bf9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800bfc:	eb 15                	jmp    800c13 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8a 00                	mov    (%eax),%al
  800c03:	0f b6 d0             	movzbl %al,%edx
  800c06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c09:	0f b6 c0             	movzbl %al,%eax
  800c0c:	39 c2                	cmp    %eax,%edx
  800c0e:	74 0d                	je     800c1d <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c10:	ff 45 08             	incl   0x8(%ebp)
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c19:	72 e3                	jb     800bfe <memfind+0x13>
  800c1b:	eb 01                	jmp    800c1e <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c1d:	90                   	nop
	return (void *) s;
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c21:	c9                   	leave  
  800c22:	c3                   	ret    

00800c23 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c23:	55                   	push   %ebp
  800c24:	89 e5                	mov    %esp,%ebp
  800c26:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c29:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c30:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c37:	eb 03                	jmp    800c3c <strtol+0x19>
		s++;
  800c39:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3f:	8a 00                	mov    (%eax),%al
  800c41:	3c 20                	cmp    $0x20,%al
  800c43:	74 f4                	je     800c39 <strtol+0x16>
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	8a 00                	mov    (%eax),%al
  800c4a:	3c 09                	cmp    $0x9,%al
  800c4c:	74 eb                	je     800c39 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c51:	8a 00                	mov    (%eax),%al
  800c53:	3c 2b                	cmp    $0x2b,%al
  800c55:	75 05                	jne    800c5c <strtol+0x39>
		s++;
  800c57:	ff 45 08             	incl   0x8(%ebp)
  800c5a:	eb 13                	jmp    800c6f <strtol+0x4c>
	else if (*s == '-')
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	8a 00                	mov    (%eax),%al
  800c61:	3c 2d                	cmp    $0x2d,%al
  800c63:	75 0a                	jne    800c6f <strtol+0x4c>
		s++, neg = 1;
  800c65:	ff 45 08             	incl   0x8(%ebp)
  800c68:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800c6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c73:	74 06                	je     800c7b <strtol+0x58>
  800c75:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800c79:	75 20                	jne    800c9b <strtol+0x78>
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	8a 00                	mov    (%eax),%al
  800c80:	3c 30                	cmp    $0x30,%al
  800c82:	75 17                	jne    800c9b <strtol+0x78>
  800c84:	8b 45 08             	mov    0x8(%ebp),%eax
  800c87:	40                   	inc    %eax
  800c88:	8a 00                	mov    (%eax),%al
  800c8a:	3c 78                	cmp    $0x78,%al
  800c8c:	75 0d                	jne    800c9b <strtol+0x78>
		s += 2, base = 16;
  800c8e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800c92:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800c99:	eb 28                	jmp    800cc3 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800c9b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c9f:	75 15                	jne    800cb6 <strtol+0x93>
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	3c 30                	cmp    $0x30,%al
  800ca8:	75 0c                	jne    800cb6 <strtol+0x93>
		s++, base = 8;
  800caa:	ff 45 08             	incl   0x8(%ebp)
  800cad:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cb4:	eb 0d                	jmp    800cc3 <strtol+0xa0>
	else if (base == 0)
  800cb6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cba:	75 07                	jne    800cc3 <strtol+0xa0>
		base = 10;
  800cbc:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	8a 00                	mov    (%eax),%al
  800cc8:	3c 2f                	cmp    $0x2f,%al
  800cca:	7e 19                	jle    800ce5 <strtol+0xc2>
  800ccc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccf:	8a 00                	mov    (%eax),%al
  800cd1:	3c 39                	cmp    $0x39,%al
  800cd3:	7f 10                	jg     800ce5 <strtol+0xc2>
			dig = *s - '0';
  800cd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd8:	8a 00                	mov    (%eax),%al
  800cda:	0f be c0             	movsbl %al,%eax
  800cdd:	83 e8 30             	sub    $0x30,%eax
  800ce0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800ce3:	eb 42                	jmp    800d27 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	3c 60                	cmp    $0x60,%al
  800cec:	7e 19                	jle    800d07 <strtol+0xe4>
  800cee:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf1:	8a 00                	mov    (%eax),%al
  800cf3:	3c 7a                	cmp    $0x7a,%al
  800cf5:	7f 10                	jg     800d07 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800cf7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	0f be c0             	movsbl %al,%eax
  800cff:	83 e8 57             	sub    $0x57,%eax
  800d02:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d05:	eb 20                	jmp    800d27 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	3c 40                	cmp    $0x40,%al
  800d0e:	7e 39                	jle    800d49 <strtol+0x126>
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	3c 5a                	cmp    $0x5a,%al
  800d17:	7f 30                	jg     800d49 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8a 00                	mov    (%eax),%al
  800d1e:	0f be c0             	movsbl %al,%eax
  800d21:	83 e8 37             	sub    $0x37,%eax
  800d24:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d27:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d2a:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d2d:	7d 19                	jge    800d48 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d2f:	ff 45 08             	incl   0x8(%ebp)
  800d32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d35:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d39:	89 c2                	mov    %eax,%edx
  800d3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d3e:	01 d0                	add    %edx,%eax
  800d40:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d43:	e9 7b ff ff ff       	jmp    800cc3 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d48:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d49:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d4d:	74 08                	je     800d57 <strtol+0x134>
		*endptr = (char *) s;
  800d4f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d52:	8b 55 08             	mov    0x8(%ebp),%edx
  800d55:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d57:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800d5b:	74 07                	je     800d64 <strtol+0x141>
  800d5d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d60:	f7 d8                	neg    %eax
  800d62:	eb 03                	jmp    800d67 <strtol+0x144>
  800d64:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d67:	c9                   	leave  
  800d68:	c3                   	ret    

00800d69 <ltostr>:

void
ltostr(long value, char *str)
{
  800d69:	55                   	push   %ebp
  800d6a:	89 e5                	mov    %esp,%ebp
  800d6c:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800d6f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800d76:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800d7d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d81:	79 13                	jns    800d96 <ltostr+0x2d>
	{
		neg = 1;
  800d83:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800d8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d8d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800d90:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800d93:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
  800d99:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800d9e:	99                   	cltd   
  800d9f:	f7 f9                	idiv   %ecx
  800da1:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800da4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da7:	8d 50 01             	lea    0x1(%eax),%edx
  800daa:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dad:	89 c2                	mov    %eax,%edx
  800daf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db2:	01 d0                	add    %edx,%eax
  800db4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800db7:	83 c2 30             	add    $0x30,%edx
  800dba:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800dbc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dbf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800dc4:	f7 e9                	imul   %ecx
  800dc6:	c1 fa 02             	sar    $0x2,%edx
  800dc9:	89 c8                	mov    %ecx,%eax
  800dcb:	c1 f8 1f             	sar    $0x1f,%eax
  800dce:	29 c2                	sub    %eax,%edx
  800dd0:	89 d0                	mov    %edx,%eax
  800dd2:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800dd5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800dd8:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ddd:	f7 e9                	imul   %ecx
  800ddf:	c1 fa 02             	sar    $0x2,%edx
  800de2:	89 c8                	mov    %ecx,%eax
  800de4:	c1 f8 1f             	sar    $0x1f,%eax
  800de7:	29 c2                	sub    %eax,%edx
  800de9:	89 d0                	mov    %edx,%eax
  800deb:	c1 e0 02             	shl    $0x2,%eax
  800dee:	01 d0                	add    %edx,%eax
  800df0:	01 c0                	add    %eax,%eax
  800df2:	29 c1                	sub    %eax,%ecx
  800df4:	89 ca                	mov    %ecx,%edx
  800df6:	85 d2                	test   %edx,%edx
  800df8:	75 9c                	jne    800d96 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800dfa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e04:	48                   	dec    %eax
  800e05:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e08:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e0c:	74 3d                	je     800e4b <ltostr+0xe2>
		start = 1 ;
  800e0e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e15:	eb 34                	jmp    800e4b <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e1d:	01 d0                	add    %edx,%eax
  800e1f:	8a 00                	mov    (%eax),%al
  800e21:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e24:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e27:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e2a:	01 c2                	add    %eax,%edx
  800e2c:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e32:	01 c8                	add    %ecx,%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e38:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e3b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3e:	01 c2                	add    %eax,%edx
  800e40:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e43:	88 02                	mov    %al,(%edx)
		start++ ;
  800e45:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e48:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e4b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e4e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e51:	7c c4                	jl     800e17 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e53:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e59:	01 d0                	add    %edx,%eax
  800e5b:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800e5e:	90                   	nop
  800e5f:	c9                   	leave  
  800e60:	c3                   	ret    

00800e61 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800e61:	55                   	push   %ebp
  800e62:	89 e5                	mov    %esp,%ebp
  800e64:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800e67:	ff 75 08             	pushl  0x8(%ebp)
  800e6a:	e8 54 fa ff ff       	call   8008c3 <strlen>
  800e6f:	83 c4 04             	add    $0x4,%esp
  800e72:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	e8 46 fa ff ff       	call   8008c3 <strlen>
  800e7d:	83 c4 04             	add    $0x4,%esp
  800e80:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800e83:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800e8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e91:	eb 17                	jmp    800eaa <strcconcat+0x49>
		final[s] = str1[s] ;
  800e93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e96:	8b 45 10             	mov    0x10(%ebp),%eax
  800e99:	01 c2                	add    %eax,%edx
  800e9b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea1:	01 c8                	add    %ecx,%eax
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800ea7:	ff 45 fc             	incl   -0x4(%ebp)
  800eaa:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ead:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800eb0:	7c e1                	jl     800e93 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800eb2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800eb9:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800ec0:	eb 1f                	jmp    800ee1 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800ec2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ec5:	8d 50 01             	lea    0x1(%eax),%edx
  800ec8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800ecb:	89 c2                	mov    %eax,%edx
  800ecd:	8b 45 10             	mov    0x10(%ebp),%eax
  800ed0:	01 c2                	add    %eax,%edx
  800ed2:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800ed5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ed8:	01 c8                	add    %ecx,%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800ede:	ff 45 f8             	incl   -0x8(%ebp)
  800ee1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ee4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ee7:	7c d9                	jl     800ec2 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800ee9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eec:	8b 45 10             	mov    0x10(%ebp),%eax
  800eef:	01 d0                	add    %edx,%eax
  800ef1:	c6 00 00             	movb   $0x0,(%eax)
}
  800ef4:	90                   	nop
  800ef5:	c9                   	leave  
  800ef6:	c3                   	ret    

00800ef7 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800ef7:	55                   	push   %ebp
  800ef8:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800efa:	8b 45 14             	mov    0x14(%ebp),%eax
  800efd:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f03:	8b 45 14             	mov    0x14(%ebp),%eax
  800f06:	8b 00                	mov    (%eax),%eax
  800f08:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f12:	01 d0                	add    %edx,%eax
  800f14:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f1a:	eb 0c                	jmp    800f28 <strsplit+0x31>
			*string++ = 0;
  800f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1f:	8d 50 01             	lea    0x1(%eax),%edx
  800f22:	89 55 08             	mov    %edx,0x8(%ebp)
  800f25:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f28:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2b:	8a 00                	mov    (%eax),%al
  800f2d:	84 c0                	test   %al,%al
  800f2f:	74 18                	je     800f49 <strsplit+0x52>
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	0f be c0             	movsbl %al,%eax
  800f39:	50                   	push   %eax
  800f3a:	ff 75 0c             	pushl  0xc(%ebp)
  800f3d:	e8 13 fb ff ff       	call   800a55 <strchr>
  800f42:	83 c4 08             	add    $0x8,%esp
  800f45:	85 c0                	test   %eax,%eax
  800f47:	75 d3                	jne    800f1c <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	8a 00                	mov    (%eax),%al
  800f4e:	84 c0                	test   %al,%al
  800f50:	74 5a                	je     800fac <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f52:	8b 45 14             	mov    0x14(%ebp),%eax
  800f55:	8b 00                	mov    (%eax),%eax
  800f57:	83 f8 0f             	cmp    $0xf,%eax
  800f5a:	75 07                	jne    800f63 <strsplit+0x6c>
		{
			return 0;
  800f5c:	b8 00 00 00 00       	mov    $0x0,%eax
  800f61:	eb 66                	jmp    800fc9 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800f63:	8b 45 14             	mov    0x14(%ebp),%eax
  800f66:	8b 00                	mov    (%eax),%eax
  800f68:	8d 48 01             	lea    0x1(%eax),%ecx
  800f6b:	8b 55 14             	mov    0x14(%ebp),%edx
  800f6e:	89 0a                	mov    %ecx,(%edx)
  800f70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f77:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7a:	01 c2                	add    %eax,%edx
  800f7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f81:	eb 03                	jmp    800f86 <strsplit+0x8f>
			string++;
  800f83:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	84 c0                	test   %al,%al
  800f8d:	74 8b                	je     800f1a <strsplit+0x23>
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	0f be c0             	movsbl %al,%eax
  800f97:	50                   	push   %eax
  800f98:	ff 75 0c             	pushl  0xc(%ebp)
  800f9b:	e8 b5 fa ff ff       	call   800a55 <strchr>
  800fa0:	83 c4 08             	add    $0x8,%esp
  800fa3:	85 c0                	test   %eax,%eax
  800fa5:	74 dc                	je     800f83 <strsplit+0x8c>
			string++;
	}
  800fa7:	e9 6e ff ff ff       	jmp    800f1a <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800fac:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800fad:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb0:	8b 00                	mov    (%eax),%eax
  800fb2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbc:	01 d0                	add    %edx,%eax
  800fbe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  800fc4:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800fc9:	c9                   	leave  
  800fca:	c3                   	ret    

00800fcb <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  800fcb:	55                   	push   %ebp
  800fcc:	89 e5                	mov    %esp,%ebp
  800fce:	57                   	push   %edi
  800fcf:	56                   	push   %esi
  800fd0:	53                   	push   %ebx
  800fd1:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fda:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800fdd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  800fe0:	8b 7d 18             	mov    0x18(%ebp),%edi
  800fe3:	8b 75 1c             	mov    0x1c(%ebp),%esi
  800fe6:	cd 30                	int    $0x30
  800fe8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  800feb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800fee:	83 c4 10             	add    $0x10,%esp
  800ff1:	5b                   	pop    %ebx
  800ff2:	5e                   	pop    %esi
  800ff3:	5f                   	pop    %edi
  800ff4:	5d                   	pop    %ebp
  800ff5:	c3                   	ret    

00800ff6 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  800ff6:	55                   	push   %ebp
  800ff7:	89 e5                	mov    %esp,%ebp
  800ff9:	83 ec 04             	sub    $0x4,%esp
  800ffc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fff:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801002:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	6a 00                	push   $0x0
  80100b:	6a 00                	push   $0x0
  80100d:	52                   	push   %edx
  80100e:	ff 75 0c             	pushl  0xc(%ebp)
  801011:	50                   	push   %eax
  801012:	6a 00                	push   $0x0
  801014:	e8 b2 ff ff ff       	call   800fcb <syscall>
  801019:	83 c4 18             	add    $0x18,%esp
}
  80101c:	90                   	nop
  80101d:	c9                   	leave  
  80101e:	c3                   	ret    

0080101f <sys_cgetc>:

int
sys_cgetc(void)
{
  80101f:	55                   	push   %ebp
  801020:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801022:	6a 00                	push   $0x0
  801024:	6a 00                	push   $0x0
  801026:	6a 00                	push   $0x0
  801028:	6a 00                	push   $0x0
  80102a:	6a 00                	push   $0x0
  80102c:	6a 01                	push   $0x1
  80102e:	e8 98 ff ff ff       	call   800fcb <syscall>
  801033:	83 c4 18             	add    $0x18,%esp
}
  801036:	c9                   	leave  
  801037:	c3                   	ret    

00801038 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801038:	55                   	push   %ebp
  801039:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80103b:	8b 45 08             	mov    0x8(%ebp),%eax
  80103e:	6a 00                	push   $0x0
  801040:	6a 00                	push   $0x0
  801042:	6a 00                	push   $0x0
  801044:	6a 00                	push   $0x0
  801046:	50                   	push   %eax
  801047:	6a 05                	push   $0x5
  801049:	e8 7d ff ff ff       	call   800fcb <syscall>
  80104e:	83 c4 18             	add    $0x18,%esp
}
  801051:	c9                   	leave  
  801052:	c3                   	ret    

00801053 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801053:	55                   	push   %ebp
  801054:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801056:	6a 00                	push   $0x0
  801058:	6a 00                	push   $0x0
  80105a:	6a 00                	push   $0x0
  80105c:	6a 00                	push   $0x0
  80105e:	6a 00                	push   $0x0
  801060:	6a 02                	push   $0x2
  801062:	e8 64 ff ff ff       	call   800fcb <syscall>
  801067:	83 c4 18             	add    $0x18,%esp
}
  80106a:	c9                   	leave  
  80106b:	c3                   	ret    

0080106c <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80106c:	55                   	push   %ebp
  80106d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80106f:	6a 00                	push   $0x0
  801071:	6a 00                	push   $0x0
  801073:	6a 00                	push   $0x0
  801075:	6a 00                	push   $0x0
  801077:	6a 00                	push   $0x0
  801079:	6a 03                	push   $0x3
  80107b:	e8 4b ff ff ff       	call   800fcb <syscall>
  801080:	83 c4 18             	add    $0x18,%esp
}
  801083:	c9                   	leave  
  801084:	c3                   	ret    

00801085 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801085:	55                   	push   %ebp
  801086:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801088:	6a 00                	push   $0x0
  80108a:	6a 00                	push   $0x0
  80108c:	6a 00                	push   $0x0
  80108e:	6a 00                	push   $0x0
  801090:	6a 00                	push   $0x0
  801092:	6a 04                	push   $0x4
  801094:	e8 32 ff ff ff       	call   800fcb <syscall>
  801099:	83 c4 18             	add    $0x18,%esp
}
  80109c:	c9                   	leave  
  80109d:	c3                   	ret    

0080109e <sys_env_exit>:


void sys_env_exit(void)
{
  80109e:	55                   	push   %ebp
  80109f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010a1:	6a 00                	push   $0x0
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 00                	push   $0x0
  8010a7:	6a 00                	push   $0x0
  8010a9:	6a 00                	push   $0x0
  8010ab:	6a 06                	push   $0x6
  8010ad:	e8 19 ff ff ff       	call   800fcb <syscall>
  8010b2:	83 c4 18             	add    $0x18,%esp
}
  8010b5:	90                   	nop
  8010b6:	c9                   	leave  
  8010b7:	c3                   	ret    

008010b8 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010b8:	55                   	push   %ebp
  8010b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8010bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010be:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c1:	6a 00                	push   $0x0
  8010c3:	6a 00                	push   $0x0
  8010c5:	6a 00                	push   $0x0
  8010c7:	52                   	push   %edx
  8010c8:	50                   	push   %eax
  8010c9:	6a 07                	push   $0x7
  8010cb:	e8 fb fe ff ff       	call   800fcb <syscall>
  8010d0:	83 c4 18             	add    $0x18,%esp
}
  8010d3:	c9                   	leave  
  8010d4:	c3                   	ret    

008010d5 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8010d5:	55                   	push   %ebp
  8010d6:	89 e5                	mov    %esp,%ebp
  8010d8:	56                   	push   %esi
  8010d9:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8010da:	8b 75 18             	mov    0x18(%ebp),%esi
  8010dd:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8010e0:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8010e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e9:	56                   	push   %esi
  8010ea:	53                   	push   %ebx
  8010eb:	51                   	push   %ecx
  8010ec:	52                   	push   %edx
  8010ed:	50                   	push   %eax
  8010ee:	6a 08                	push   $0x8
  8010f0:	e8 d6 fe ff ff       	call   800fcb <syscall>
  8010f5:	83 c4 18             	add    $0x18,%esp
}
  8010f8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8010fb:	5b                   	pop    %ebx
  8010fc:	5e                   	pop    %esi
  8010fd:	5d                   	pop    %ebp
  8010fe:	c3                   	ret    

008010ff <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8010ff:	55                   	push   %ebp
  801100:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801102:	8b 55 0c             	mov    0xc(%ebp),%edx
  801105:	8b 45 08             	mov    0x8(%ebp),%eax
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	6a 00                	push   $0x0
  80110e:	52                   	push   %edx
  80110f:	50                   	push   %eax
  801110:	6a 09                	push   $0x9
  801112:	e8 b4 fe ff ff       	call   800fcb <syscall>
  801117:	83 c4 18             	add    $0x18,%esp
}
  80111a:	c9                   	leave  
  80111b:	c3                   	ret    

0080111c <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80111c:	55                   	push   %ebp
  80111d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80111f:	6a 00                	push   $0x0
  801121:	6a 00                	push   $0x0
  801123:	6a 00                	push   $0x0
  801125:	ff 75 0c             	pushl  0xc(%ebp)
  801128:	ff 75 08             	pushl  0x8(%ebp)
  80112b:	6a 0a                	push   $0xa
  80112d:	e8 99 fe ff ff       	call   800fcb <syscall>
  801132:	83 c4 18             	add    $0x18,%esp
}
  801135:	c9                   	leave  
  801136:	c3                   	ret    

00801137 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801137:	55                   	push   %ebp
  801138:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80113a:	6a 00                	push   $0x0
  80113c:	6a 00                	push   $0x0
  80113e:	6a 00                	push   $0x0
  801140:	6a 00                	push   $0x0
  801142:	6a 00                	push   $0x0
  801144:	6a 0b                	push   $0xb
  801146:	e8 80 fe ff ff       	call   800fcb <syscall>
  80114b:	83 c4 18             	add    $0x18,%esp
}
  80114e:	c9                   	leave  
  80114f:	c3                   	ret    

00801150 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801150:	55                   	push   %ebp
  801151:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801153:	6a 00                	push   $0x0
  801155:	6a 00                	push   $0x0
  801157:	6a 00                	push   $0x0
  801159:	6a 00                	push   $0x0
  80115b:	6a 00                	push   $0x0
  80115d:	6a 0c                	push   $0xc
  80115f:	e8 67 fe ff ff       	call   800fcb <syscall>
  801164:	83 c4 18             	add    $0x18,%esp
}
  801167:	c9                   	leave  
  801168:	c3                   	ret    

00801169 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801169:	55                   	push   %ebp
  80116a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80116c:	6a 00                	push   $0x0
  80116e:	6a 00                	push   $0x0
  801170:	6a 00                	push   $0x0
  801172:	6a 00                	push   $0x0
  801174:	6a 00                	push   $0x0
  801176:	6a 0d                	push   $0xd
  801178:	e8 4e fe ff ff       	call   800fcb <syscall>
  80117d:	83 c4 18             	add    $0x18,%esp
}
  801180:	c9                   	leave  
  801181:	c3                   	ret    

00801182 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801182:	55                   	push   %ebp
  801183:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801185:	6a 00                	push   $0x0
  801187:	6a 00                	push   $0x0
  801189:	6a 00                	push   $0x0
  80118b:	ff 75 0c             	pushl  0xc(%ebp)
  80118e:	ff 75 08             	pushl  0x8(%ebp)
  801191:	6a 11                	push   $0x11
  801193:	e8 33 fe ff ff       	call   800fcb <syscall>
  801198:	83 c4 18             	add    $0x18,%esp
	return;
  80119b:	90                   	nop
}
  80119c:	c9                   	leave  
  80119d:	c3                   	ret    

0080119e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80119e:	55                   	push   %ebp
  80119f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011a1:	6a 00                	push   $0x0
  8011a3:	6a 00                	push   $0x0
  8011a5:	6a 00                	push   $0x0
  8011a7:	ff 75 0c             	pushl  0xc(%ebp)
  8011aa:	ff 75 08             	pushl  0x8(%ebp)
  8011ad:	6a 12                	push   $0x12
  8011af:	e8 17 fe ff ff       	call   800fcb <syscall>
  8011b4:	83 c4 18             	add    $0x18,%esp
	return ;
  8011b7:	90                   	nop
}
  8011b8:	c9                   	leave  
  8011b9:	c3                   	ret    

008011ba <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011ba:	55                   	push   %ebp
  8011bb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8011bd:	6a 00                	push   $0x0
  8011bf:	6a 00                	push   $0x0
  8011c1:	6a 00                	push   $0x0
  8011c3:	6a 00                	push   $0x0
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 0e                	push   $0xe
  8011c9:	e8 fd fd ff ff       	call   800fcb <syscall>
  8011ce:	83 c4 18             	add    $0x18,%esp
}
  8011d1:	c9                   	leave  
  8011d2:	c3                   	ret    

008011d3 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8011d3:	55                   	push   %ebp
  8011d4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8011d6:	6a 00                	push   $0x0
  8011d8:	6a 00                	push   $0x0
  8011da:	6a 00                	push   $0x0
  8011dc:	6a 00                	push   $0x0
  8011de:	ff 75 08             	pushl  0x8(%ebp)
  8011e1:	6a 0f                	push   $0xf
  8011e3:	e8 e3 fd ff ff       	call   800fcb <syscall>
  8011e8:	83 c4 18             	add    $0x18,%esp
}
  8011eb:	c9                   	leave  
  8011ec:	c3                   	ret    

008011ed <sys_scarce_memory>:

void sys_scarce_memory()
{
  8011ed:	55                   	push   %ebp
  8011ee:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8011f0:	6a 00                	push   $0x0
  8011f2:	6a 00                	push   $0x0
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 00                	push   $0x0
  8011fa:	6a 10                	push   $0x10
  8011fc:	e8 ca fd ff ff       	call   800fcb <syscall>
  801201:	83 c4 18             	add    $0x18,%esp
}
  801204:	90                   	nop
  801205:	c9                   	leave  
  801206:	c3                   	ret    

00801207 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801207:	55                   	push   %ebp
  801208:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80120a:	6a 00                	push   $0x0
  80120c:	6a 00                	push   $0x0
  80120e:	6a 00                	push   $0x0
  801210:	6a 00                	push   $0x0
  801212:	6a 00                	push   $0x0
  801214:	6a 14                	push   $0x14
  801216:	e8 b0 fd ff ff       	call   800fcb <syscall>
  80121b:	83 c4 18             	add    $0x18,%esp
}
  80121e:	90                   	nop
  80121f:	c9                   	leave  
  801220:	c3                   	ret    

00801221 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801221:	55                   	push   %ebp
  801222:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801224:	6a 00                	push   $0x0
  801226:	6a 00                	push   $0x0
  801228:	6a 00                	push   $0x0
  80122a:	6a 00                	push   $0x0
  80122c:	6a 00                	push   $0x0
  80122e:	6a 15                	push   $0x15
  801230:	e8 96 fd ff ff       	call   800fcb <syscall>
  801235:	83 c4 18             	add    $0x18,%esp
}
  801238:	90                   	nop
  801239:	c9                   	leave  
  80123a:	c3                   	ret    

0080123b <sys_cputc>:


void
sys_cputc(const char c)
{
  80123b:	55                   	push   %ebp
  80123c:	89 e5                	mov    %esp,%ebp
  80123e:	83 ec 04             	sub    $0x4,%esp
  801241:	8b 45 08             	mov    0x8(%ebp),%eax
  801244:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801247:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80124b:	6a 00                	push   $0x0
  80124d:	6a 00                	push   $0x0
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	50                   	push   %eax
  801254:	6a 16                	push   $0x16
  801256:	e8 70 fd ff ff       	call   800fcb <syscall>
  80125b:	83 c4 18             	add    $0x18,%esp
}
  80125e:	90                   	nop
  80125f:	c9                   	leave  
  801260:	c3                   	ret    

00801261 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801261:	55                   	push   %ebp
  801262:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 17                	push   $0x17
  801270:	e8 56 fd ff ff       	call   800fcb <syscall>
  801275:	83 c4 18             	add    $0x18,%esp
}
  801278:	90                   	nop
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80127e:	8b 45 08             	mov    0x8(%ebp),%eax
  801281:	6a 00                	push   $0x0
  801283:	6a 00                	push   $0x0
  801285:	6a 00                	push   $0x0
  801287:	ff 75 0c             	pushl  0xc(%ebp)
  80128a:	50                   	push   %eax
  80128b:	6a 18                	push   $0x18
  80128d:	e8 39 fd ff ff       	call   800fcb <syscall>
  801292:	83 c4 18             	add    $0x18,%esp
}
  801295:	c9                   	leave  
  801296:	c3                   	ret    

00801297 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801297:	55                   	push   %ebp
  801298:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80129a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80129d:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a0:	6a 00                	push   $0x0
  8012a2:	6a 00                	push   $0x0
  8012a4:	6a 00                	push   $0x0
  8012a6:	52                   	push   %edx
  8012a7:	50                   	push   %eax
  8012a8:	6a 1b                	push   $0x1b
  8012aa:	e8 1c fd ff ff       	call   800fcb <syscall>
  8012af:	83 c4 18             	add    $0x18,%esp
}
  8012b2:	c9                   	leave  
  8012b3:	c3                   	ret    

008012b4 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012b4:	55                   	push   %ebp
  8012b5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	52                   	push   %edx
  8012c4:	50                   	push   %eax
  8012c5:	6a 19                	push   $0x19
  8012c7:	e8 ff fc ff ff       	call   800fcb <syscall>
  8012cc:	83 c4 18             	add    $0x18,%esp
}
  8012cf:	90                   	nop
  8012d0:	c9                   	leave  
  8012d1:	c3                   	ret    

008012d2 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012d2:	55                   	push   %ebp
  8012d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012d5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	52                   	push   %edx
  8012e2:	50                   	push   %eax
  8012e3:	6a 1a                	push   $0x1a
  8012e5:	e8 e1 fc ff ff       	call   800fcb <syscall>
  8012ea:	83 c4 18             	add    $0x18,%esp
}
  8012ed:	90                   	nop
  8012ee:	c9                   	leave  
  8012ef:	c3                   	ret    

008012f0 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8012f0:	55                   	push   %ebp
  8012f1:	89 e5                	mov    %esp,%ebp
  8012f3:	83 ec 04             	sub    $0x4,%esp
  8012f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f9:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8012fc:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8012ff:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801303:	8b 45 08             	mov    0x8(%ebp),%eax
  801306:	6a 00                	push   $0x0
  801308:	51                   	push   %ecx
  801309:	52                   	push   %edx
  80130a:	ff 75 0c             	pushl  0xc(%ebp)
  80130d:	50                   	push   %eax
  80130e:	6a 1c                	push   $0x1c
  801310:	e8 b6 fc ff ff       	call   800fcb <syscall>
  801315:	83 c4 18             	add    $0x18,%esp
}
  801318:	c9                   	leave  
  801319:	c3                   	ret    

0080131a <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80131a:	55                   	push   %ebp
  80131b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80131d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801320:	8b 45 08             	mov    0x8(%ebp),%eax
  801323:	6a 00                	push   $0x0
  801325:	6a 00                	push   $0x0
  801327:	6a 00                	push   $0x0
  801329:	52                   	push   %edx
  80132a:	50                   	push   %eax
  80132b:	6a 1d                	push   $0x1d
  80132d:	e8 99 fc ff ff       	call   800fcb <syscall>
  801332:	83 c4 18             	add    $0x18,%esp
}
  801335:	c9                   	leave  
  801336:	c3                   	ret    

00801337 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801337:	55                   	push   %ebp
  801338:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80133a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80133d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801340:	8b 45 08             	mov    0x8(%ebp),%eax
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	51                   	push   %ecx
  801348:	52                   	push   %edx
  801349:	50                   	push   %eax
  80134a:	6a 1e                	push   $0x1e
  80134c:	e8 7a fc ff ff       	call   800fcb <syscall>
  801351:	83 c4 18             	add    $0x18,%esp
}
  801354:	c9                   	leave  
  801355:	c3                   	ret    

00801356 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801356:	55                   	push   %ebp
  801357:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801359:	8b 55 0c             	mov    0xc(%ebp),%edx
  80135c:	8b 45 08             	mov    0x8(%ebp),%eax
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	52                   	push   %edx
  801366:	50                   	push   %eax
  801367:	6a 1f                	push   $0x1f
  801369:	e8 5d fc ff ff       	call   800fcb <syscall>
  80136e:	83 c4 18             	add    $0x18,%esp
}
  801371:	c9                   	leave  
  801372:	c3                   	ret    

00801373 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801376:	6a 00                	push   $0x0
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 20                	push   $0x20
  801382:	e8 44 fc ff ff       	call   800fcb <syscall>
  801387:	83 c4 18             	add    $0x18,%esp
}
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	6a 00                	push   $0x0
  801394:	ff 75 14             	pushl  0x14(%ebp)
  801397:	ff 75 10             	pushl  0x10(%ebp)
  80139a:	ff 75 0c             	pushl  0xc(%ebp)
  80139d:	50                   	push   %eax
  80139e:	6a 21                	push   $0x21
  8013a0:	e8 26 fc ff ff       	call   800fcb <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	6a 00                	push   $0x0
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	6a 00                	push   $0x0
  8013b8:	50                   	push   %eax
  8013b9:	6a 22                	push   $0x22
  8013bb:	e8 0b fc ff ff       	call   800fcb <syscall>
  8013c0:	83 c4 18             	add    $0x18,%esp
}
  8013c3:	90                   	nop
  8013c4:	c9                   	leave  
  8013c5:	c3                   	ret    

008013c6 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8013c6:	55                   	push   %ebp
  8013c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	50                   	push   %eax
  8013d5:	6a 23                	push   $0x23
  8013d7:	e8 ef fb ff ff       	call   800fcb <syscall>
  8013dc:	83 c4 18             	add    $0x18,%esp
}
  8013df:	90                   	nop
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
  8013e5:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8013e8:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013eb:	8d 50 04             	lea    0x4(%eax),%edx
  8013ee:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8013f1:	6a 00                	push   $0x0
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	52                   	push   %edx
  8013f8:	50                   	push   %eax
  8013f9:	6a 24                	push   $0x24
  8013fb:	e8 cb fb ff ff       	call   800fcb <syscall>
  801400:	83 c4 18             	add    $0x18,%esp
	return result;
  801403:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801406:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801409:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80140c:	89 01                	mov    %eax,(%ecx)
  80140e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801411:	8b 45 08             	mov    0x8(%ebp),%eax
  801414:	c9                   	leave  
  801415:	c2 04 00             	ret    $0x4

00801418 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80141b:	6a 00                	push   $0x0
  80141d:	6a 00                	push   $0x0
  80141f:	ff 75 10             	pushl  0x10(%ebp)
  801422:	ff 75 0c             	pushl  0xc(%ebp)
  801425:	ff 75 08             	pushl  0x8(%ebp)
  801428:	6a 13                	push   $0x13
  80142a:	e8 9c fb ff ff       	call   800fcb <syscall>
  80142f:	83 c4 18             	add    $0x18,%esp
	return ;
  801432:	90                   	nop
}
  801433:	c9                   	leave  
  801434:	c3                   	ret    

00801435 <sys_rcr2>:
uint32 sys_rcr2()
{
  801435:	55                   	push   %ebp
  801436:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	6a 00                	push   $0x0
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 25                	push   $0x25
  801444:	e8 82 fb ff ff       	call   800fcb <syscall>
  801449:	83 c4 18             	add    $0x18,%esp
}
  80144c:	c9                   	leave  
  80144d:	c3                   	ret    

0080144e <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80144e:	55                   	push   %ebp
  80144f:	89 e5                	mov    %esp,%ebp
  801451:	83 ec 04             	sub    $0x4,%esp
  801454:	8b 45 08             	mov    0x8(%ebp),%eax
  801457:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80145a:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80145e:	6a 00                	push   $0x0
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	50                   	push   %eax
  801467:	6a 26                	push   $0x26
  801469:	e8 5d fb ff ff       	call   800fcb <syscall>
  80146e:	83 c4 18             	add    $0x18,%esp
	return ;
  801471:	90                   	nop
}
  801472:	c9                   	leave  
  801473:	c3                   	ret    

00801474 <rsttst>:
void rsttst()
{
  801474:	55                   	push   %ebp
  801475:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 28                	push   $0x28
  801483:	e8 43 fb ff ff       	call   800fcb <syscall>
  801488:	83 c4 18             	add    $0x18,%esp
	return ;
  80148b:	90                   	nop
}
  80148c:	c9                   	leave  
  80148d:	c3                   	ret    

0080148e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80148e:	55                   	push   %ebp
  80148f:	89 e5                	mov    %esp,%ebp
  801491:	83 ec 04             	sub    $0x4,%esp
  801494:	8b 45 14             	mov    0x14(%ebp),%eax
  801497:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80149a:	8b 55 18             	mov    0x18(%ebp),%edx
  80149d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014a1:	52                   	push   %edx
  8014a2:	50                   	push   %eax
  8014a3:	ff 75 10             	pushl  0x10(%ebp)
  8014a6:	ff 75 0c             	pushl  0xc(%ebp)
  8014a9:	ff 75 08             	pushl  0x8(%ebp)
  8014ac:	6a 27                	push   $0x27
  8014ae:	e8 18 fb ff ff       	call   800fcb <syscall>
  8014b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b6:	90                   	nop
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <chktst>:
void chktst(uint32 n)
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	ff 75 08             	pushl  0x8(%ebp)
  8014c7:	6a 29                	push   $0x29
  8014c9:	e8 fd fa ff ff       	call   800fcb <syscall>
  8014ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d1:	90                   	nop
}
  8014d2:	c9                   	leave  
  8014d3:	c3                   	ret    

008014d4 <inctst>:

void inctst()
{
  8014d4:	55                   	push   %ebp
  8014d5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 2a                	push   $0x2a
  8014e3:	e8 e3 fa ff ff       	call   800fcb <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
	return ;
  8014eb:	90                   	nop
}
  8014ec:	c9                   	leave  
  8014ed:	c3                   	ret    

008014ee <gettst>:
uint32 gettst()
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 00                	push   $0x0
  8014f5:	6a 00                	push   $0x0
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 2b                	push   $0x2b
  8014fd:	e8 c9 fa ff ff       	call   800fcb <syscall>
  801502:	83 c4 18             	add    $0x18,%esp
}
  801505:	c9                   	leave  
  801506:	c3                   	ret    

00801507 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801507:	55                   	push   %ebp
  801508:	89 e5                	mov    %esp,%ebp
  80150a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 2c                	push   $0x2c
  801519:	e8 ad fa ff ff       	call   800fcb <syscall>
  80151e:	83 c4 18             	add    $0x18,%esp
  801521:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801524:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801528:	75 07                	jne    801531 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80152a:	b8 01 00 00 00       	mov    $0x1,%eax
  80152f:	eb 05                	jmp    801536 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801531:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
  80153b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	6a 00                	push   $0x0
  801548:	6a 2c                	push   $0x2c
  80154a:	e8 7c fa ff ff       	call   800fcb <syscall>
  80154f:	83 c4 18             	add    $0x18,%esp
  801552:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801555:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801559:	75 07                	jne    801562 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80155b:	b8 01 00 00 00       	mov    $0x1,%eax
  801560:	eb 05                	jmp    801567 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801562:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801567:	c9                   	leave  
  801568:	c3                   	ret    

00801569 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801569:	55                   	push   %ebp
  80156a:	89 e5                	mov    %esp,%ebp
  80156c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 00                	push   $0x0
  801577:	6a 00                	push   $0x0
  801579:	6a 2c                	push   $0x2c
  80157b:	e8 4b fa ff ff       	call   800fcb <syscall>
  801580:	83 c4 18             	add    $0x18,%esp
  801583:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801586:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80158a:	75 07                	jne    801593 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80158c:	b8 01 00 00 00       	mov    $0x1,%eax
  801591:	eb 05                	jmp    801598 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801593:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801598:	c9                   	leave  
  801599:	c3                   	ret    

0080159a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80159a:	55                   	push   %ebp
  80159b:	89 e5                	mov    %esp,%ebp
  80159d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 00                	push   $0x0
  8015a8:	6a 00                	push   $0x0
  8015aa:	6a 2c                	push   $0x2c
  8015ac:	e8 1a fa ff ff       	call   800fcb <syscall>
  8015b1:	83 c4 18             	add    $0x18,%esp
  8015b4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015b7:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8015bb:	75 07                	jne    8015c4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8015bd:	b8 01 00 00 00       	mov    $0x1,%eax
  8015c2:	eb 05                	jmp    8015c9 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8015c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c9:	c9                   	leave  
  8015ca:	c3                   	ret    

008015cb <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8015cb:	55                   	push   %ebp
  8015cc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	ff 75 08             	pushl  0x8(%ebp)
  8015d9:	6a 2d                	push   $0x2d
  8015db:	e8 eb f9 ff ff       	call   800fcb <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8015e3:	90                   	nop
}
  8015e4:	c9                   	leave  
  8015e5:	c3                   	ret    

008015e6 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8015e6:	55                   	push   %ebp
  8015e7:	89 e5                	mov    %esp,%ebp
  8015e9:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8015ea:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015ed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015f0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f6:	6a 00                	push   $0x0
  8015f8:	53                   	push   %ebx
  8015f9:	51                   	push   %ecx
  8015fa:	52                   	push   %edx
  8015fb:	50                   	push   %eax
  8015fc:	6a 2e                	push   $0x2e
  8015fe:	e8 c8 f9 ff ff       	call   800fcb <syscall>
  801603:	83 c4 18             	add    $0x18,%esp
}
  801606:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80160e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	52                   	push   %edx
  80161b:	50                   	push   %eax
  80161c:	6a 2f                	push   $0x2f
  80161e:	e8 a8 f9 ff ff       	call   800fcb <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
}
  801626:	c9                   	leave  
  801627:	c3                   	ret    

00801628 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801628:	55                   	push   %ebp
  801629:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80162b:	6a 00                	push   $0x0
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	ff 75 0c             	pushl  0xc(%ebp)
  801634:	ff 75 08             	pushl  0x8(%ebp)
  801637:	6a 30                	push   $0x30
  801639:	e8 8d f9 ff ff       	call   800fcb <syscall>
  80163e:	83 c4 18             	add    $0x18,%esp
	return ;
  801641:	90                   	nop
}
  801642:	c9                   	leave  
  801643:	c3                   	ret    

00801644 <__udivdi3>:
  801644:	55                   	push   %ebp
  801645:	57                   	push   %edi
  801646:	56                   	push   %esi
  801647:	53                   	push   %ebx
  801648:	83 ec 1c             	sub    $0x1c,%esp
  80164b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80164f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801653:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801657:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80165b:	89 ca                	mov    %ecx,%edx
  80165d:	89 f8                	mov    %edi,%eax
  80165f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801663:	85 f6                	test   %esi,%esi
  801665:	75 2d                	jne    801694 <__udivdi3+0x50>
  801667:	39 cf                	cmp    %ecx,%edi
  801669:	77 65                	ja     8016d0 <__udivdi3+0x8c>
  80166b:	89 fd                	mov    %edi,%ebp
  80166d:	85 ff                	test   %edi,%edi
  80166f:	75 0b                	jne    80167c <__udivdi3+0x38>
  801671:	b8 01 00 00 00       	mov    $0x1,%eax
  801676:	31 d2                	xor    %edx,%edx
  801678:	f7 f7                	div    %edi
  80167a:	89 c5                	mov    %eax,%ebp
  80167c:	31 d2                	xor    %edx,%edx
  80167e:	89 c8                	mov    %ecx,%eax
  801680:	f7 f5                	div    %ebp
  801682:	89 c1                	mov    %eax,%ecx
  801684:	89 d8                	mov    %ebx,%eax
  801686:	f7 f5                	div    %ebp
  801688:	89 cf                	mov    %ecx,%edi
  80168a:	89 fa                	mov    %edi,%edx
  80168c:	83 c4 1c             	add    $0x1c,%esp
  80168f:	5b                   	pop    %ebx
  801690:	5e                   	pop    %esi
  801691:	5f                   	pop    %edi
  801692:	5d                   	pop    %ebp
  801693:	c3                   	ret    
  801694:	39 ce                	cmp    %ecx,%esi
  801696:	77 28                	ja     8016c0 <__udivdi3+0x7c>
  801698:	0f bd fe             	bsr    %esi,%edi
  80169b:	83 f7 1f             	xor    $0x1f,%edi
  80169e:	75 40                	jne    8016e0 <__udivdi3+0x9c>
  8016a0:	39 ce                	cmp    %ecx,%esi
  8016a2:	72 0a                	jb     8016ae <__udivdi3+0x6a>
  8016a4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016a8:	0f 87 9e 00 00 00    	ja     80174c <__udivdi3+0x108>
  8016ae:	b8 01 00 00 00       	mov    $0x1,%eax
  8016b3:	89 fa                	mov    %edi,%edx
  8016b5:	83 c4 1c             	add    $0x1c,%esp
  8016b8:	5b                   	pop    %ebx
  8016b9:	5e                   	pop    %esi
  8016ba:	5f                   	pop    %edi
  8016bb:	5d                   	pop    %ebp
  8016bc:	c3                   	ret    
  8016bd:	8d 76 00             	lea    0x0(%esi),%esi
  8016c0:	31 ff                	xor    %edi,%edi
  8016c2:	31 c0                	xor    %eax,%eax
  8016c4:	89 fa                	mov    %edi,%edx
  8016c6:	83 c4 1c             	add    $0x1c,%esp
  8016c9:	5b                   	pop    %ebx
  8016ca:	5e                   	pop    %esi
  8016cb:	5f                   	pop    %edi
  8016cc:	5d                   	pop    %ebp
  8016cd:	c3                   	ret    
  8016ce:	66 90                	xchg   %ax,%ax
  8016d0:	89 d8                	mov    %ebx,%eax
  8016d2:	f7 f7                	div    %edi
  8016d4:	31 ff                	xor    %edi,%edi
  8016d6:	89 fa                	mov    %edi,%edx
  8016d8:	83 c4 1c             	add    $0x1c,%esp
  8016db:	5b                   	pop    %ebx
  8016dc:	5e                   	pop    %esi
  8016dd:	5f                   	pop    %edi
  8016de:	5d                   	pop    %ebp
  8016df:	c3                   	ret    
  8016e0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8016e5:	89 eb                	mov    %ebp,%ebx
  8016e7:	29 fb                	sub    %edi,%ebx
  8016e9:	89 f9                	mov    %edi,%ecx
  8016eb:	d3 e6                	shl    %cl,%esi
  8016ed:	89 c5                	mov    %eax,%ebp
  8016ef:	88 d9                	mov    %bl,%cl
  8016f1:	d3 ed                	shr    %cl,%ebp
  8016f3:	89 e9                	mov    %ebp,%ecx
  8016f5:	09 f1                	or     %esi,%ecx
  8016f7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8016fb:	89 f9                	mov    %edi,%ecx
  8016fd:	d3 e0                	shl    %cl,%eax
  8016ff:	89 c5                	mov    %eax,%ebp
  801701:	89 d6                	mov    %edx,%esi
  801703:	88 d9                	mov    %bl,%cl
  801705:	d3 ee                	shr    %cl,%esi
  801707:	89 f9                	mov    %edi,%ecx
  801709:	d3 e2                	shl    %cl,%edx
  80170b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80170f:	88 d9                	mov    %bl,%cl
  801711:	d3 e8                	shr    %cl,%eax
  801713:	09 c2                	or     %eax,%edx
  801715:	89 d0                	mov    %edx,%eax
  801717:	89 f2                	mov    %esi,%edx
  801719:	f7 74 24 0c          	divl   0xc(%esp)
  80171d:	89 d6                	mov    %edx,%esi
  80171f:	89 c3                	mov    %eax,%ebx
  801721:	f7 e5                	mul    %ebp
  801723:	39 d6                	cmp    %edx,%esi
  801725:	72 19                	jb     801740 <__udivdi3+0xfc>
  801727:	74 0b                	je     801734 <__udivdi3+0xf0>
  801729:	89 d8                	mov    %ebx,%eax
  80172b:	31 ff                	xor    %edi,%edi
  80172d:	e9 58 ff ff ff       	jmp    80168a <__udivdi3+0x46>
  801732:	66 90                	xchg   %ax,%ax
  801734:	8b 54 24 08          	mov    0x8(%esp),%edx
  801738:	89 f9                	mov    %edi,%ecx
  80173a:	d3 e2                	shl    %cl,%edx
  80173c:	39 c2                	cmp    %eax,%edx
  80173e:	73 e9                	jae    801729 <__udivdi3+0xe5>
  801740:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801743:	31 ff                	xor    %edi,%edi
  801745:	e9 40 ff ff ff       	jmp    80168a <__udivdi3+0x46>
  80174a:	66 90                	xchg   %ax,%ax
  80174c:	31 c0                	xor    %eax,%eax
  80174e:	e9 37 ff ff ff       	jmp    80168a <__udivdi3+0x46>
  801753:	90                   	nop

00801754 <__umoddi3>:
  801754:	55                   	push   %ebp
  801755:	57                   	push   %edi
  801756:	56                   	push   %esi
  801757:	53                   	push   %ebx
  801758:	83 ec 1c             	sub    $0x1c,%esp
  80175b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80175f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801763:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801767:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80176b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80176f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801773:	89 f3                	mov    %esi,%ebx
  801775:	89 fa                	mov    %edi,%edx
  801777:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80177b:	89 34 24             	mov    %esi,(%esp)
  80177e:	85 c0                	test   %eax,%eax
  801780:	75 1a                	jne    80179c <__umoddi3+0x48>
  801782:	39 f7                	cmp    %esi,%edi
  801784:	0f 86 a2 00 00 00    	jbe    80182c <__umoddi3+0xd8>
  80178a:	89 c8                	mov    %ecx,%eax
  80178c:	89 f2                	mov    %esi,%edx
  80178e:	f7 f7                	div    %edi
  801790:	89 d0                	mov    %edx,%eax
  801792:	31 d2                	xor    %edx,%edx
  801794:	83 c4 1c             	add    $0x1c,%esp
  801797:	5b                   	pop    %ebx
  801798:	5e                   	pop    %esi
  801799:	5f                   	pop    %edi
  80179a:	5d                   	pop    %ebp
  80179b:	c3                   	ret    
  80179c:	39 f0                	cmp    %esi,%eax
  80179e:	0f 87 ac 00 00 00    	ja     801850 <__umoddi3+0xfc>
  8017a4:	0f bd e8             	bsr    %eax,%ebp
  8017a7:	83 f5 1f             	xor    $0x1f,%ebp
  8017aa:	0f 84 ac 00 00 00    	je     80185c <__umoddi3+0x108>
  8017b0:	bf 20 00 00 00       	mov    $0x20,%edi
  8017b5:	29 ef                	sub    %ebp,%edi
  8017b7:	89 fe                	mov    %edi,%esi
  8017b9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8017bd:	89 e9                	mov    %ebp,%ecx
  8017bf:	d3 e0                	shl    %cl,%eax
  8017c1:	89 d7                	mov    %edx,%edi
  8017c3:	89 f1                	mov    %esi,%ecx
  8017c5:	d3 ef                	shr    %cl,%edi
  8017c7:	09 c7                	or     %eax,%edi
  8017c9:	89 e9                	mov    %ebp,%ecx
  8017cb:	d3 e2                	shl    %cl,%edx
  8017cd:	89 14 24             	mov    %edx,(%esp)
  8017d0:	89 d8                	mov    %ebx,%eax
  8017d2:	d3 e0                	shl    %cl,%eax
  8017d4:	89 c2                	mov    %eax,%edx
  8017d6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017da:	d3 e0                	shl    %cl,%eax
  8017dc:	89 44 24 04          	mov    %eax,0x4(%esp)
  8017e0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8017e4:	89 f1                	mov    %esi,%ecx
  8017e6:	d3 e8                	shr    %cl,%eax
  8017e8:	09 d0                	or     %edx,%eax
  8017ea:	d3 eb                	shr    %cl,%ebx
  8017ec:	89 da                	mov    %ebx,%edx
  8017ee:	f7 f7                	div    %edi
  8017f0:	89 d3                	mov    %edx,%ebx
  8017f2:	f7 24 24             	mull   (%esp)
  8017f5:	89 c6                	mov    %eax,%esi
  8017f7:	89 d1                	mov    %edx,%ecx
  8017f9:	39 d3                	cmp    %edx,%ebx
  8017fb:	0f 82 87 00 00 00    	jb     801888 <__umoddi3+0x134>
  801801:	0f 84 91 00 00 00    	je     801898 <__umoddi3+0x144>
  801807:	8b 54 24 04          	mov    0x4(%esp),%edx
  80180b:	29 f2                	sub    %esi,%edx
  80180d:	19 cb                	sbb    %ecx,%ebx
  80180f:	89 d8                	mov    %ebx,%eax
  801811:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801815:	d3 e0                	shl    %cl,%eax
  801817:	89 e9                	mov    %ebp,%ecx
  801819:	d3 ea                	shr    %cl,%edx
  80181b:	09 d0                	or     %edx,%eax
  80181d:	89 e9                	mov    %ebp,%ecx
  80181f:	d3 eb                	shr    %cl,%ebx
  801821:	89 da                	mov    %ebx,%edx
  801823:	83 c4 1c             	add    $0x1c,%esp
  801826:	5b                   	pop    %ebx
  801827:	5e                   	pop    %esi
  801828:	5f                   	pop    %edi
  801829:	5d                   	pop    %ebp
  80182a:	c3                   	ret    
  80182b:	90                   	nop
  80182c:	89 fd                	mov    %edi,%ebp
  80182e:	85 ff                	test   %edi,%edi
  801830:	75 0b                	jne    80183d <__umoddi3+0xe9>
  801832:	b8 01 00 00 00       	mov    $0x1,%eax
  801837:	31 d2                	xor    %edx,%edx
  801839:	f7 f7                	div    %edi
  80183b:	89 c5                	mov    %eax,%ebp
  80183d:	89 f0                	mov    %esi,%eax
  80183f:	31 d2                	xor    %edx,%edx
  801841:	f7 f5                	div    %ebp
  801843:	89 c8                	mov    %ecx,%eax
  801845:	f7 f5                	div    %ebp
  801847:	89 d0                	mov    %edx,%eax
  801849:	e9 44 ff ff ff       	jmp    801792 <__umoddi3+0x3e>
  80184e:	66 90                	xchg   %ax,%ax
  801850:	89 c8                	mov    %ecx,%eax
  801852:	89 f2                	mov    %esi,%edx
  801854:	83 c4 1c             	add    $0x1c,%esp
  801857:	5b                   	pop    %ebx
  801858:	5e                   	pop    %esi
  801859:	5f                   	pop    %edi
  80185a:	5d                   	pop    %ebp
  80185b:	c3                   	ret    
  80185c:	3b 04 24             	cmp    (%esp),%eax
  80185f:	72 06                	jb     801867 <__umoddi3+0x113>
  801861:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801865:	77 0f                	ja     801876 <__umoddi3+0x122>
  801867:	89 f2                	mov    %esi,%edx
  801869:	29 f9                	sub    %edi,%ecx
  80186b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80186f:	89 14 24             	mov    %edx,(%esp)
  801872:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801876:	8b 44 24 04          	mov    0x4(%esp),%eax
  80187a:	8b 14 24             	mov    (%esp),%edx
  80187d:	83 c4 1c             	add    $0x1c,%esp
  801880:	5b                   	pop    %ebx
  801881:	5e                   	pop    %esi
  801882:	5f                   	pop    %edi
  801883:	5d                   	pop    %ebp
  801884:	c3                   	ret    
  801885:	8d 76 00             	lea    0x0(%esi),%esi
  801888:	2b 04 24             	sub    (%esp),%eax
  80188b:	19 fa                	sbb    %edi,%edx
  80188d:	89 d1                	mov    %edx,%ecx
  80188f:	89 c6                	mov    %eax,%esi
  801891:	e9 71 ff ff ff       	jmp    801807 <__umoddi3+0xb3>
  801896:	66 90                	xchg   %ax,%ax
  801898:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80189c:	72 ea                	jb     801888 <__umoddi3+0x134>
  80189e:	89 d9                	mov    %ebx,%ecx
  8018a0:	e9 62 ff ff ff       	jmp    801807 <__umoddi3+0xb3>
