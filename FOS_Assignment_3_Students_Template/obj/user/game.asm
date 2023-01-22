
obj/user/game:     file format elf32-i386


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
  800031:	e8 79 00 00 00       	call   8000af <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>
	
void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int i=28;
  80003e:	c7 45 f4 1c 00 00 00 	movl   $0x1c,-0xc(%ebp)
	for(;i<128; i++)
  800045:	eb 5f                	jmp    8000a6 <_main+0x6e>
	{
		int c=0;
  800047:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for(;c<10; c++)
  80004e:	eb 16                	jmp    800066 <_main+0x2e>
		{
			cprintf("%c",i);
  800050:	83 ec 08             	sub    $0x8,%esp
  800053:	ff 75 f4             	pushl  -0xc(%ebp)
  800056:	68 20 19 80 00       	push   $0x801920
  80005b:	e8 3f 02 00 00       	call   80029f <cprintf>
  800060:	83 c4 10             	add    $0x10,%esp
{	
	int i=28;
	for(;i<128; i++)
	{
		int c=0;
		for(;c<10; c++)
  800063:	ff 45 f0             	incl   -0x10(%ebp)
  800066:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  80006a:	7e e4                	jle    800050 <_main+0x18>
		{
			cprintf("%c",i);
		}
		int d=0;
  80006c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for(; d< 500000; d++);	
  800073:	eb 03                	jmp    800078 <_main+0x40>
  800075:	ff 45 ec             	incl   -0x14(%ebp)
  800078:	81 7d ec 1f a1 07 00 	cmpl   $0x7a11f,-0x14(%ebp)
  80007f:	7e f4                	jle    800075 <_main+0x3d>
		c=0;
  800081:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for(;c<10; c++)
  800088:	eb 13                	jmp    80009d <_main+0x65>
		{
			cprintf("\b");
  80008a:	83 ec 0c             	sub    $0xc,%esp
  80008d:	68 23 19 80 00       	push   $0x801923
  800092:	e8 08 02 00 00       	call   80029f <cprintf>
  800097:	83 c4 10             	add    $0x10,%esp
			cprintf("%c",i);
		}
		int d=0;
		for(; d< 500000; d++);	
		c=0;
		for(;c<10; c++)
  80009a:	ff 45 f0             	incl   -0x10(%ebp)
  80009d:	83 7d f0 09          	cmpl   $0x9,-0x10(%ebp)
  8000a1:	7e e7                	jle    80008a <_main+0x52>
	
void
_main(void)
{	
	int i=28;
	for(;i<128; i++)
  8000a3:	ff 45 f4             	incl   -0xc(%ebp)
  8000a6:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
  8000aa:	7e 9b                	jle    800047 <_main+0xf>
		{
			cprintf("\b");
		}		
	}
	
	return;	
  8000ac:	90                   	nop
}
  8000ad:	c9                   	leave  
  8000ae:	c3                   	ret    

008000af <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000af:	55                   	push   %ebp
  8000b0:	89 e5                	mov    %esp,%ebp
  8000b2:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000b5:	e8 10 10 00 00       	call   8010ca <sys_getenvindex>
  8000ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000bd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c0:	89 d0                	mov    %edx,%eax
  8000c2:	01 c0                	add    %eax,%eax
  8000c4:	01 d0                	add    %edx,%eax
  8000c6:	c1 e0 04             	shl    $0x4,%eax
  8000c9:	29 d0                	sub    %edx,%eax
  8000cb:	c1 e0 03             	shl    $0x3,%eax
  8000ce:	01 d0                	add    %edx,%eax
  8000d0:	c1 e0 02             	shl    $0x2,%eax
  8000d3:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000d8:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000dd:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e2:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8000e8:	84 c0                	test   %al,%al
  8000ea:	74 0f                	je     8000fb <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8000ec:	a1 20 20 80 00       	mov    0x802020,%eax
  8000f1:	05 5c 05 00 00       	add    $0x55c,%eax
  8000f6:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000fb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000ff:	7e 0a                	jle    80010b <libmain+0x5c>
		binaryname = argv[0];
  800101:	8b 45 0c             	mov    0xc(%ebp),%eax
  800104:	8b 00                	mov    (%eax),%eax
  800106:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80010b:	83 ec 08             	sub    $0x8,%esp
  80010e:	ff 75 0c             	pushl  0xc(%ebp)
  800111:	ff 75 08             	pushl  0x8(%ebp)
  800114:	e8 1f ff ff ff       	call   800038 <_main>
  800119:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80011c:	e8 44 11 00 00       	call   801265 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 40 19 80 00       	push   $0x801940
  800129:	e8 71 01 00 00       	call   80029f <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800131:	a1 20 20 80 00       	mov    0x802020,%eax
  800136:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  80013c:	a1 20 20 80 00       	mov    0x802020,%eax
  800141:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800147:	83 ec 04             	sub    $0x4,%esp
  80014a:	52                   	push   %edx
  80014b:	50                   	push   %eax
  80014c:	68 68 19 80 00       	push   $0x801968
  800151:	e8 49 01 00 00       	call   80029f <cprintf>
  800156:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800159:	a1 20 20 80 00       	mov    0x802020,%eax
  80015e:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800164:	a1 20 20 80 00       	mov    0x802020,%eax
  800169:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  80016f:	a1 20 20 80 00       	mov    0x802020,%eax
  800174:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80017a:	51                   	push   %ecx
  80017b:	52                   	push   %edx
  80017c:	50                   	push   %eax
  80017d:	68 90 19 80 00       	push   $0x801990
  800182:	e8 18 01 00 00       	call   80029f <cprintf>
  800187:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80018a:	83 ec 0c             	sub    $0xc,%esp
  80018d:	68 40 19 80 00       	push   $0x801940
  800192:	e8 08 01 00 00       	call   80029f <cprintf>
  800197:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80019a:	e8 e0 10 00 00       	call   80127f <sys_enable_interrupt>

	// exit gracefully
	exit();
  80019f:	e8 19 00 00 00       	call   8001bd <exit>
}
  8001a4:	90                   	nop
  8001a5:	c9                   	leave  
  8001a6:	c3                   	ret    

008001a7 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001a7:	55                   	push   %ebp
  8001a8:	89 e5                	mov    %esp,%ebp
  8001aa:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001ad:	83 ec 0c             	sub    $0xc,%esp
  8001b0:	6a 00                	push   $0x0
  8001b2:	e8 df 0e 00 00       	call   801096 <sys_env_destroy>
  8001b7:	83 c4 10             	add    $0x10,%esp
}
  8001ba:	90                   	nop
  8001bb:	c9                   	leave  
  8001bc:	c3                   	ret    

008001bd <exit>:

void
exit(void)
{
  8001bd:	55                   	push   %ebp
  8001be:	89 e5                	mov    %esp,%ebp
  8001c0:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001c3:	e8 34 0f 00 00       	call   8010fc <sys_env_exit>
}
  8001c8:	90                   	nop
  8001c9:	c9                   	leave  
  8001ca:	c3                   	ret    

008001cb <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001cb:	55                   	push   %ebp
  8001cc:	89 e5                	mov    %esp,%ebp
  8001ce:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d4:	8b 00                	mov    (%eax),%eax
  8001d6:	8d 48 01             	lea    0x1(%eax),%ecx
  8001d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001dc:	89 0a                	mov    %ecx,(%edx)
  8001de:	8b 55 08             	mov    0x8(%ebp),%edx
  8001e1:	88 d1                	mov    %dl,%cl
  8001e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e6:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001ed:	8b 00                	mov    (%eax),%eax
  8001ef:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001f4:	75 2c                	jne    800222 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001f6:	a0 24 20 80 00       	mov    0x802024,%al
  8001fb:	0f b6 c0             	movzbl %al,%eax
  8001fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800201:	8b 12                	mov    (%edx),%edx
  800203:	89 d1                	mov    %edx,%ecx
  800205:	8b 55 0c             	mov    0xc(%ebp),%edx
  800208:	83 c2 08             	add    $0x8,%edx
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	50                   	push   %eax
  80020f:	51                   	push   %ecx
  800210:	52                   	push   %edx
  800211:	e8 3e 0e 00 00       	call   801054 <sys_cputs>
  800216:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800219:	8b 45 0c             	mov    0xc(%ebp),%eax
  80021c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800222:	8b 45 0c             	mov    0xc(%ebp),%eax
  800225:	8b 40 04             	mov    0x4(%eax),%eax
  800228:	8d 50 01             	lea    0x1(%eax),%edx
  80022b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800231:	90                   	nop
  800232:	c9                   	leave  
  800233:	c3                   	ret    

00800234 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800234:	55                   	push   %ebp
  800235:	89 e5                	mov    %esp,%ebp
  800237:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80023d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800244:	00 00 00 
	b.cnt = 0;
  800247:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80024e:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800251:	ff 75 0c             	pushl  0xc(%ebp)
  800254:	ff 75 08             	pushl  0x8(%ebp)
  800257:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80025d:	50                   	push   %eax
  80025e:	68 cb 01 80 00       	push   $0x8001cb
  800263:	e8 11 02 00 00       	call   800479 <vprintfmt>
  800268:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80026b:	a0 24 20 80 00       	mov    0x802024,%al
  800270:	0f b6 c0             	movzbl %al,%eax
  800273:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800279:	83 ec 04             	sub    $0x4,%esp
  80027c:	50                   	push   %eax
  80027d:	52                   	push   %edx
  80027e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800284:	83 c0 08             	add    $0x8,%eax
  800287:	50                   	push   %eax
  800288:	e8 c7 0d 00 00       	call   801054 <sys_cputs>
  80028d:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800290:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  800297:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80029d:	c9                   	leave  
  80029e:	c3                   	ret    

0080029f <cprintf>:

int cprintf(const char *fmt, ...) {
  80029f:	55                   	push   %ebp
  8002a0:	89 e5                	mov    %esp,%ebp
  8002a2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002a5:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002ac:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002af:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b5:	83 ec 08             	sub    $0x8,%esp
  8002b8:	ff 75 f4             	pushl  -0xc(%ebp)
  8002bb:	50                   	push   %eax
  8002bc:	e8 73 ff ff ff       	call   800234 <vcprintf>
  8002c1:	83 c4 10             	add    $0x10,%esp
  8002c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002ca:	c9                   	leave  
  8002cb:	c3                   	ret    

008002cc <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002cc:	55                   	push   %ebp
  8002cd:	89 e5                	mov    %esp,%ebp
  8002cf:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002d2:	e8 8e 0f 00 00       	call   801265 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002d7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002da:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e0:	83 ec 08             	sub    $0x8,%esp
  8002e3:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e6:	50                   	push   %eax
  8002e7:	e8 48 ff ff ff       	call   800234 <vcprintf>
  8002ec:	83 c4 10             	add    $0x10,%esp
  8002ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002f2:	e8 88 0f 00 00       	call   80127f <sys_enable_interrupt>
	return cnt;
  8002f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002fa:	c9                   	leave  
  8002fb:	c3                   	ret    

008002fc <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002fc:	55                   	push   %ebp
  8002fd:	89 e5                	mov    %esp,%ebp
  8002ff:	53                   	push   %ebx
  800300:	83 ec 14             	sub    $0x14,%esp
  800303:	8b 45 10             	mov    0x10(%ebp),%eax
  800306:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800309:	8b 45 14             	mov    0x14(%ebp),%eax
  80030c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80030f:	8b 45 18             	mov    0x18(%ebp),%eax
  800312:	ba 00 00 00 00       	mov    $0x0,%edx
  800317:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80031a:	77 55                	ja     800371 <printnum+0x75>
  80031c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80031f:	72 05                	jb     800326 <printnum+0x2a>
  800321:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800324:	77 4b                	ja     800371 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800326:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800329:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80032c:	8b 45 18             	mov    0x18(%ebp),%eax
  80032f:	ba 00 00 00 00       	mov    $0x0,%edx
  800334:	52                   	push   %edx
  800335:	50                   	push   %eax
  800336:	ff 75 f4             	pushl  -0xc(%ebp)
  800339:	ff 75 f0             	pushl  -0x10(%ebp)
  80033c:	e8 63 13 00 00       	call   8016a4 <__udivdi3>
  800341:	83 c4 10             	add    $0x10,%esp
  800344:	83 ec 04             	sub    $0x4,%esp
  800347:	ff 75 20             	pushl  0x20(%ebp)
  80034a:	53                   	push   %ebx
  80034b:	ff 75 18             	pushl  0x18(%ebp)
  80034e:	52                   	push   %edx
  80034f:	50                   	push   %eax
  800350:	ff 75 0c             	pushl  0xc(%ebp)
  800353:	ff 75 08             	pushl  0x8(%ebp)
  800356:	e8 a1 ff ff ff       	call   8002fc <printnum>
  80035b:	83 c4 20             	add    $0x20,%esp
  80035e:	eb 1a                	jmp    80037a <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800360:	83 ec 08             	sub    $0x8,%esp
  800363:	ff 75 0c             	pushl  0xc(%ebp)
  800366:	ff 75 20             	pushl  0x20(%ebp)
  800369:	8b 45 08             	mov    0x8(%ebp),%eax
  80036c:	ff d0                	call   *%eax
  80036e:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800371:	ff 4d 1c             	decl   0x1c(%ebp)
  800374:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800378:	7f e6                	jg     800360 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80037a:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80037d:	bb 00 00 00 00       	mov    $0x0,%ebx
  800382:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800385:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800388:	53                   	push   %ebx
  800389:	51                   	push   %ecx
  80038a:	52                   	push   %edx
  80038b:	50                   	push   %eax
  80038c:	e8 23 14 00 00       	call   8017b4 <__umoddi3>
  800391:	83 c4 10             	add    $0x10,%esp
  800394:	05 14 1c 80 00       	add    $0x801c14,%eax
  800399:	8a 00                	mov    (%eax),%al
  80039b:	0f be c0             	movsbl %al,%eax
  80039e:	83 ec 08             	sub    $0x8,%esp
  8003a1:	ff 75 0c             	pushl  0xc(%ebp)
  8003a4:	50                   	push   %eax
  8003a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a8:	ff d0                	call   *%eax
  8003aa:	83 c4 10             	add    $0x10,%esp
}
  8003ad:	90                   	nop
  8003ae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003b1:	c9                   	leave  
  8003b2:	c3                   	ret    

008003b3 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003b3:	55                   	push   %ebp
  8003b4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003b6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ba:	7e 1c                	jle    8003d8 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bf:	8b 00                	mov    (%eax),%eax
  8003c1:	8d 50 08             	lea    0x8(%eax),%edx
  8003c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c7:	89 10                	mov    %edx,(%eax)
  8003c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003cc:	8b 00                	mov    (%eax),%eax
  8003ce:	83 e8 08             	sub    $0x8,%eax
  8003d1:	8b 50 04             	mov    0x4(%eax),%edx
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	eb 40                	jmp    800418 <getuint+0x65>
	else if (lflag)
  8003d8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003dc:	74 1e                	je     8003fc <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003de:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e1:	8b 00                	mov    (%eax),%eax
  8003e3:	8d 50 04             	lea    0x4(%eax),%edx
  8003e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e9:	89 10                	mov    %edx,(%eax)
  8003eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ee:	8b 00                	mov    (%eax),%eax
  8003f0:	83 e8 04             	sub    $0x4,%eax
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	ba 00 00 00 00       	mov    $0x0,%edx
  8003fa:	eb 1c                	jmp    800418 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	8d 50 04             	lea    0x4(%eax),%edx
  800404:	8b 45 08             	mov    0x8(%ebp),%eax
  800407:	89 10                	mov    %edx,(%eax)
  800409:	8b 45 08             	mov    0x8(%ebp),%eax
  80040c:	8b 00                	mov    (%eax),%eax
  80040e:	83 e8 04             	sub    $0x4,%eax
  800411:	8b 00                	mov    (%eax),%eax
  800413:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800418:	5d                   	pop    %ebp
  800419:	c3                   	ret    

0080041a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80041a:	55                   	push   %ebp
  80041b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80041d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800421:	7e 1c                	jle    80043f <getint+0x25>
		return va_arg(*ap, long long);
  800423:	8b 45 08             	mov    0x8(%ebp),%eax
  800426:	8b 00                	mov    (%eax),%eax
  800428:	8d 50 08             	lea    0x8(%eax),%edx
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	89 10                	mov    %edx,(%eax)
  800430:	8b 45 08             	mov    0x8(%ebp),%eax
  800433:	8b 00                	mov    (%eax),%eax
  800435:	83 e8 08             	sub    $0x8,%eax
  800438:	8b 50 04             	mov    0x4(%eax),%edx
  80043b:	8b 00                	mov    (%eax),%eax
  80043d:	eb 38                	jmp    800477 <getint+0x5d>
	else if (lflag)
  80043f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800443:	74 1a                	je     80045f <getint+0x45>
		return va_arg(*ap, long);
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	8d 50 04             	lea    0x4(%eax),%edx
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	89 10                	mov    %edx,(%eax)
  800452:	8b 45 08             	mov    0x8(%ebp),%eax
  800455:	8b 00                	mov    (%eax),%eax
  800457:	83 e8 04             	sub    $0x4,%eax
  80045a:	8b 00                	mov    (%eax),%eax
  80045c:	99                   	cltd   
  80045d:	eb 18                	jmp    800477 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	8d 50 04             	lea    0x4(%eax),%edx
  800467:	8b 45 08             	mov    0x8(%ebp),%eax
  80046a:	89 10                	mov    %edx,(%eax)
  80046c:	8b 45 08             	mov    0x8(%ebp),%eax
  80046f:	8b 00                	mov    (%eax),%eax
  800471:	83 e8 04             	sub    $0x4,%eax
  800474:	8b 00                	mov    (%eax),%eax
  800476:	99                   	cltd   
}
  800477:	5d                   	pop    %ebp
  800478:	c3                   	ret    

00800479 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800479:	55                   	push   %ebp
  80047a:	89 e5                	mov    %esp,%ebp
  80047c:	56                   	push   %esi
  80047d:	53                   	push   %ebx
  80047e:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800481:	eb 17                	jmp    80049a <vprintfmt+0x21>
			if (ch == '\0')
  800483:	85 db                	test   %ebx,%ebx
  800485:	0f 84 af 03 00 00    	je     80083a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80048b:	83 ec 08             	sub    $0x8,%esp
  80048e:	ff 75 0c             	pushl  0xc(%ebp)
  800491:	53                   	push   %ebx
  800492:	8b 45 08             	mov    0x8(%ebp),%eax
  800495:	ff d0                	call   *%eax
  800497:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80049a:	8b 45 10             	mov    0x10(%ebp),%eax
  80049d:	8d 50 01             	lea    0x1(%eax),%edx
  8004a0:	89 55 10             	mov    %edx,0x10(%ebp)
  8004a3:	8a 00                	mov    (%eax),%al
  8004a5:	0f b6 d8             	movzbl %al,%ebx
  8004a8:	83 fb 25             	cmp    $0x25,%ebx
  8004ab:	75 d6                	jne    800483 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004ad:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004b1:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004b8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004bf:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004c6:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004d0:	8d 50 01             	lea    0x1(%eax),%edx
  8004d3:	89 55 10             	mov    %edx,0x10(%ebp)
  8004d6:	8a 00                	mov    (%eax),%al
  8004d8:	0f b6 d8             	movzbl %al,%ebx
  8004db:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004de:	83 f8 55             	cmp    $0x55,%eax
  8004e1:	0f 87 2b 03 00 00    	ja     800812 <vprintfmt+0x399>
  8004e7:	8b 04 85 38 1c 80 00 	mov    0x801c38(,%eax,4),%eax
  8004ee:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004f0:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004f4:	eb d7                	jmp    8004cd <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004f6:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004fa:	eb d1                	jmp    8004cd <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004fc:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800503:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800506:	89 d0                	mov    %edx,%eax
  800508:	c1 e0 02             	shl    $0x2,%eax
  80050b:	01 d0                	add    %edx,%eax
  80050d:	01 c0                	add    %eax,%eax
  80050f:	01 d8                	add    %ebx,%eax
  800511:	83 e8 30             	sub    $0x30,%eax
  800514:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800517:	8b 45 10             	mov    0x10(%ebp),%eax
  80051a:	8a 00                	mov    (%eax),%al
  80051c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80051f:	83 fb 2f             	cmp    $0x2f,%ebx
  800522:	7e 3e                	jle    800562 <vprintfmt+0xe9>
  800524:	83 fb 39             	cmp    $0x39,%ebx
  800527:	7f 39                	jg     800562 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800529:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80052c:	eb d5                	jmp    800503 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80052e:	8b 45 14             	mov    0x14(%ebp),%eax
  800531:	83 c0 04             	add    $0x4,%eax
  800534:	89 45 14             	mov    %eax,0x14(%ebp)
  800537:	8b 45 14             	mov    0x14(%ebp),%eax
  80053a:	83 e8 04             	sub    $0x4,%eax
  80053d:	8b 00                	mov    (%eax),%eax
  80053f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800542:	eb 1f                	jmp    800563 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800544:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800548:	79 83                	jns    8004cd <vprintfmt+0x54>
				width = 0;
  80054a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800551:	e9 77 ff ff ff       	jmp    8004cd <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800556:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80055d:	e9 6b ff ff ff       	jmp    8004cd <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800562:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800563:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800567:	0f 89 60 ff ff ff    	jns    8004cd <vprintfmt+0x54>
				width = precision, precision = -1;
  80056d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800570:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800573:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80057a:	e9 4e ff ff ff       	jmp    8004cd <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80057f:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800582:	e9 46 ff ff ff       	jmp    8004cd <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800587:	8b 45 14             	mov    0x14(%ebp),%eax
  80058a:	83 c0 04             	add    $0x4,%eax
  80058d:	89 45 14             	mov    %eax,0x14(%ebp)
  800590:	8b 45 14             	mov    0x14(%ebp),%eax
  800593:	83 e8 04             	sub    $0x4,%eax
  800596:	8b 00                	mov    (%eax),%eax
  800598:	83 ec 08             	sub    $0x8,%esp
  80059b:	ff 75 0c             	pushl  0xc(%ebp)
  80059e:	50                   	push   %eax
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	ff d0                	call   *%eax
  8005a4:	83 c4 10             	add    $0x10,%esp
			break;
  8005a7:	e9 89 02 00 00       	jmp    800835 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005ac:	8b 45 14             	mov    0x14(%ebp),%eax
  8005af:	83 c0 04             	add    $0x4,%eax
  8005b2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005b5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b8:	83 e8 04             	sub    $0x4,%eax
  8005bb:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005bd:	85 db                	test   %ebx,%ebx
  8005bf:	79 02                	jns    8005c3 <vprintfmt+0x14a>
				err = -err;
  8005c1:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005c3:	83 fb 64             	cmp    $0x64,%ebx
  8005c6:	7f 0b                	jg     8005d3 <vprintfmt+0x15a>
  8005c8:	8b 34 9d 80 1a 80 00 	mov    0x801a80(,%ebx,4),%esi
  8005cf:	85 f6                	test   %esi,%esi
  8005d1:	75 19                	jne    8005ec <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005d3:	53                   	push   %ebx
  8005d4:	68 25 1c 80 00       	push   $0x801c25
  8005d9:	ff 75 0c             	pushl  0xc(%ebp)
  8005dc:	ff 75 08             	pushl  0x8(%ebp)
  8005df:	e8 5e 02 00 00       	call   800842 <printfmt>
  8005e4:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005e7:	e9 49 02 00 00       	jmp    800835 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005ec:	56                   	push   %esi
  8005ed:	68 2e 1c 80 00       	push   $0x801c2e
  8005f2:	ff 75 0c             	pushl  0xc(%ebp)
  8005f5:	ff 75 08             	pushl  0x8(%ebp)
  8005f8:	e8 45 02 00 00       	call   800842 <printfmt>
  8005fd:	83 c4 10             	add    $0x10,%esp
			break;
  800600:	e9 30 02 00 00       	jmp    800835 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800605:	8b 45 14             	mov    0x14(%ebp),%eax
  800608:	83 c0 04             	add    $0x4,%eax
  80060b:	89 45 14             	mov    %eax,0x14(%ebp)
  80060e:	8b 45 14             	mov    0x14(%ebp),%eax
  800611:	83 e8 04             	sub    $0x4,%eax
  800614:	8b 30                	mov    (%eax),%esi
  800616:	85 f6                	test   %esi,%esi
  800618:	75 05                	jne    80061f <vprintfmt+0x1a6>
				p = "(null)";
  80061a:	be 31 1c 80 00       	mov    $0x801c31,%esi
			if (width > 0 && padc != '-')
  80061f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800623:	7e 6d                	jle    800692 <vprintfmt+0x219>
  800625:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800629:	74 67                	je     800692 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80062b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80062e:	83 ec 08             	sub    $0x8,%esp
  800631:	50                   	push   %eax
  800632:	56                   	push   %esi
  800633:	e8 0c 03 00 00       	call   800944 <strnlen>
  800638:	83 c4 10             	add    $0x10,%esp
  80063b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80063e:	eb 16                	jmp    800656 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800640:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800644:	83 ec 08             	sub    $0x8,%esp
  800647:	ff 75 0c             	pushl  0xc(%ebp)
  80064a:	50                   	push   %eax
  80064b:	8b 45 08             	mov    0x8(%ebp),%eax
  80064e:	ff d0                	call   *%eax
  800650:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800653:	ff 4d e4             	decl   -0x1c(%ebp)
  800656:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80065a:	7f e4                	jg     800640 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80065c:	eb 34                	jmp    800692 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80065e:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800662:	74 1c                	je     800680 <vprintfmt+0x207>
  800664:	83 fb 1f             	cmp    $0x1f,%ebx
  800667:	7e 05                	jle    80066e <vprintfmt+0x1f5>
  800669:	83 fb 7e             	cmp    $0x7e,%ebx
  80066c:	7e 12                	jle    800680 <vprintfmt+0x207>
					putch('?', putdat);
  80066e:	83 ec 08             	sub    $0x8,%esp
  800671:	ff 75 0c             	pushl  0xc(%ebp)
  800674:	6a 3f                	push   $0x3f
  800676:	8b 45 08             	mov    0x8(%ebp),%eax
  800679:	ff d0                	call   *%eax
  80067b:	83 c4 10             	add    $0x10,%esp
  80067e:	eb 0f                	jmp    80068f <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800680:	83 ec 08             	sub    $0x8,%esp
  800683:	ff 75 0c             	pushl  0xc(%ebp)
  800686:	53                   	push   %ebx
  800687:	8b 45 08             	mov    0x8(%ebp),%eax
  80068a:	ff d0                	call   *%eax
  80068c:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80068f:	ff 4d e4             	decl   -0x1c(%ebp)
  800692:	89 f0                	mov    %esi,%eax
  800694:	8d 70 01             	lea    0x1(%eax),%esi
  800697:	8a 00                	mov    (%eax),%al
  800699:	0f be d8             	movsbl %al,%ebx
  80069c:	85 db                	test   %ebx,%ebx
  80069e:	74 24                	je     8006c4 <vprintfmt+0x24b>
  8006a0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006a4:	78 b8                	js     80065e <vprintfmt+0x1e5>
  8006a6:	ff 4d e0             	decl   -0x20(%ebp)
  8006a9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006ad:	79 af                	jns    80065e <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006af:	eb 13                	jmp    8006c4 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006b1:	83 ec 08             	sub    $0x8,%esp
  8006b4:	ff 75 0c             	pushl  0xc(%ebp)
  8006b7:	6a 20                	push   $0x20
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	ff d0                	call   *%eax
  8006be:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006c1:	ff 4d e4             	decl   -0x1c(%ebp)
  8006c4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006c8:	7f e7                	jg     8006b1 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006ca:	e9 66 01 00 00       	jmp    800835 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006cf:	83 ec 08             	sub    $0x8,%esp
  8006d2:	ff 75 e8             	pushl  -0x18(%ebp)
  8006d5:	8d 45 14             	lea    0x14(%ebp),%eax
  8006d8:	50                   	push   %eax
  8006d9:	e8 3c fd ff ff       	call   80041a <getint>
  8006de:	83 c4 10             	add    $0x10,%esp
  8006e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006e4:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006ea:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ed:	85 d2                	test   %edx,%edx
  8006ef:	79 23                	jns    800714 <vprintfmt+0x29b>
				putch('-', putdat);
  8006f1:	83 ec 08             	sub    $0x8,%esp
  8006f4:	ff 75 0c             	pushl  0xc(%ebp)
  8006f7:	6a 2d                	push   $0x2d
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	ff d0                	call   *%eax
  8006fe:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800701:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800704:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800707:	f7 d8                	neg    %eax
  800709:	83 d2 00             	adc    $0x0,%edx
  80070c:	f7 da                	neg    %edx
  80070e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800711:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800714:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80071b:	e9 bc 00 00 00       	jmp    8007dc <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800720:	83 ec 08             	sub    $0x8,%esp
  800723:	ff 75 e8             	pushl  -0x18(%ebp)
  800726:	8d 45 14             	lea    0x14(%ebp),%eax
  800729:	50                   	push   %eax
  80072a:	e8 84 fc ff ff       	call   8003b3 <getuint>
  80072f:	83 c4 10             	add    $0x10,%esp
  800732:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800735:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800738:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80073f:	e9 98 00 00 00       	jmp    8007dc <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	ff 75 0c             	pushl  0xc(%ebp)
  80074a:	6a 58                	push   $0x58
  80074c:	8b 45 08             	mov    0x8(%ebp),%eax
  80074f:	ff d0                	call   *%eax
  800751:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800754:	83 ec 08             	sub    $0x8,%esp
  800757:	ff 75 0c             	pushl  0xc(%ebp)
  80075a:	6a 58                	push   $0x58
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	ff d0                	call   *%eax
  800761:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800764:	83 ec 08             	sub    $0x8,%esp
  800767:	ff 75 0c             	pushl  0xc(%ebp)
  80076a:	6a 58                	push   $0x58
  80076c:	8b 45 08             	mov    0x8(%ebp),%eax
  80076f:	ff d0                	call   *%eax
  800771:	83 c4 10             	add    $0x10,%esp
			break;
  800774:	e9 bc 00 00 00       	jmp    800835 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800779:	83 ec 08             	sub    $0x8,%esp
  80077c:	ff 75 0c             	pushl  0xc(%ebp)
  80077f:	6a 30                	push   $0x30
  800781:	8b 45 08             	mov    0x8(%ebp),%eax
  800784:	ff d0                	call   *%eax
  800786:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800789:	83 ec 08             	sub    $0x8,%esp
  80078c:	ff 75 0c             	pushl  0xc(%ebp)
  80078f:	6a 78                	push   $0x78
  800791:	8b 45 08             	mov    0x8(%ebp),%eax
  800794:	ff d0                	call   *%eax
  800796:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800799:	8b 45 14             	mov    0x14(%ebp),%eax
  80079c:	83 c0 04             	add    $0x4,%eax
  80079f:	89 45 14             	mov    %eax,0x14(%ebp)
  8007a2:	8b 45 14             	mov    0x14(%ebp),%eax
  8007a5:	83 e8 04             	sub    $0x4,%eax
  8007a8:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007ad:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007b4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007bb:	eb 1f                	jmp    8007dc <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007bd:	83 ec 08             	sub    $0x8,%esp
  8007c0:	ff 75 e8             	pushl  -0x18(%ebp)
  8007c3:	8d 45 14             	lea    0x14(%ebp),%eax
  8007c6:	50                   	push   %eax
  8007c7:	e8 e7 fb ff ff       	call   8003b3 <getuint>
  8007cc:	83 c4 10             	add    $0x10,%esp
  8007cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007d5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007dc:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007e3:	83 ec 04             	sub    $0x4,%esp
  8007e6:	52                   	push   %edx
  8007e7:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007ea:	50                   	push   %eax
  8007eb:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ee:	ff 75 f0             	pushl  -0x10(%ebp)
  8007f1:	ff 75 0c             	pushl  0xc(%ebp)
  8007f4:	ff 75 08             	pushl  0x8(%ebp)
  8007f7:	e8 00 fb ff ff       	call   8002fc <printnum>
  8007fc:	83 c4 20             	add    $0x20,%esp
			break;
  8007ff:	eb 34                	jmp    800835 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 0c             	pushl  0xc(%ebp)
  800807:	53                   	push   %ebx
  800808:	8b 45 08             	mov    0x8(%ebp),%eax
  80080b:	ff d0                	call   *%eax
  80080d:	83 c4 10             	add    $0x10,%esp
			break;
  800810:	eb 23                	jmp    800835 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 0c             	pushl  0xc(%ebp)
  800818:	6a 25                	push   $0x25
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	ff d0                	call   *%eax
  80081f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800822:	ff 4d 10             	decl   0x10(%ebp)
  800825:	eb 03                	jmp    80082a <vprintfmt+0x3b1>
  800827:	ff 4d 10             	decl   0x10(%ebp)
  80082a:	8b 45 10             	mov    0x10(%ebp),%eax
  80082d:	48                   	dec    %eax
  80082e:	8a 00                	mov    (%eax),%al
  800830:	3c 25                	cmp    $0x25,%al
  800832:	75 f3                	jne    800827 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800834:	90                   	nop
		}
	}
  800835:	e9 47 fc ff ff       	jmp    800481 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80083a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80083b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80083e:	5b                   	pop    %ebx
  80083f:	5e                   	pop    %esi
  800840:	5d                   	pop    %ebp
  800841:	c3                   	ret    

00800842 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800842:	55                   	push   %ebp
  800843:	89 e5                	mov    %esp,%ebp
  800845:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800848:	8d 45 10             	lea    0x10(%ebp),%eax
  80084b:	83 c0 04             	add    $0x4,%eax
  80084e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800851:	8b 45 10             	mov    0x10(%ebp),%eax
  800854:	ff 75 f4             	pushl  -0xc(%ebp)
  800857:	50                   	push   %eax
  800858:	ff 75 0c             	pushl  0xc(%ebp)
  80085b:	ff 75 08             	pushl  0x8(%ebp)
  80085e:	e8 16 fc ff ff       	call   800479 <vprintfmt>
  800863:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800866:	90                   	nop
  800867:	c9                   	leave  
  800868:	c3                   	ret    

00800869 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800869:	55                   	push   %ebp
  80086a:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80086c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086f:	8b 40 08             	mov    0x8(%eax),%eax
  800872:	8d 50 01             	lea    0x1(%eax),%edx
  800875:	8b 45 0c             	mov    0xc(%ebp),%eax
  800878:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80087b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087e:	8b 10                	mov    (%eax),%edx
  800880:	8b 45 0c             	mov    0xc(%ebp),%eax
  800883:	8b 40 04             	mov    0x4(%eax),%eax
  800886:	39 c2                	cmp    %eax,%edx
  800888:	73 12                	jae    80089c <sprintputch+0x33>
		*b->buf++ = ch;
  80088a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088d:	8b 00                	mov    (%eax),%eax
  80088f:	8d 48 01             	lea    0x1(%eax),%ecx
  800892:	8b 55 0c             	mov    0xc(%ebp),%edx
  800895:	89 0a                	mov    %ecx,(%edx)
  800897:	8b 55 08             	mov    0x8(%ebp),%edx
  80089a:	88 10                	mov    %dl,(%eax)
}
  80089c:	90                   	nop
  80089d:	5d                   	pop    %ebp
  80089e:	c3                   	ret    

0080089f <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80089f:	55                   	push   %ebp
  8008a0:	89 e5                	mov    %esp,%ebp
  8008a2:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ae:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b4:	01 d0                	add    %edx,%eax
  8008b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008c0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008c4:	74 06                	je     8008cc <vsnprintf+0x2d>
  8008c6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008ca:	7f 07                	jg     8008d3 <vsnprintf+0x34>
		return -E_INVAL;
  8008cc:	b8 03 00 00 00       	mov    $0x3,%eax
  8008d1:	eb 20                	jmp    8008f3 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008d3:	ff 75 14             	pushl  0x14(%ebp)
  8008d6:	ff 75 10             	pushl  0x10(%ebp)
  8008d9:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008dc:	50                   	push   %eax
  8008dd:	68 69 08 80 00       	push   $0x800869
  8008e2:	e8 92 fb ff ff       	call   800479 <vprintfmt>
  8008e7:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008ed:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008f3:	c9                   	leave  
  8008f4:	c3                   	ret    

008008f5 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008f5:	55                   	push   %ebp
  8008f6:	89 e5                	mov    %esp,%ebp
  8008f8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008fb:	8d 45 10             	lea    0x10(%ebp),%eax
  8008fe:	83 c0 04             	add    $0x4,%eax
  800901:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800904:	8b 45 10             	mov    0x10(%ebp),%eax
  800907:	ff 75 f4             	pushl  -0xc(%ebp)
  80090a:	50                   	push   %eax
  80090b:	ff 75 0c             	pushl  0xc(%ebp)
  80090e:	ff 75 08             	pushl  0x8(%ebp)
  800911:	e8 89 ff ff ff       	call   80089f <vsnprintf>
  800916:	83 c4 10             	add    $0x10,%esp
  800919:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80091c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800927:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80092e:	eb 06                	jmp    800936 <strlen+0x15>
		n++;
  800930:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800933:	ff 45 08             	incl   0x8(%ebp)
  800936:	8b 45 08             	mov    0x8(%ebp),%eax
  800939:	8a 00                	mov    (%eax),%al
  80093b:	84 c0                	test   %al,%al
  80093d:	75 f1                	jne    800930 <strlen+0xf>
		n++;
	return n;
  80093f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800942:	c9                   	leave  
  800943:	c3                   	ret    

00800944 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800944:	55                   	push   %ebp
  800945:	89 e5                	mov    %esp,%ebp
  800947:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80094a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800951:	eb 09                	jmp    80095c <strnlen+0x18>
		n++;
  800953:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800956:	ff 45 08             	incl   0x8(%ebp)
  800959:	ff 4d 0c             	decl   0xc(%ebp)
  80095c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800960:	74 09                	je     80096b <strnlen+0x27>
  800962:	8b 45 08             	mov    0x8(%ebp),%eax
  800965:	8a 00                	mov    (%eax),%al
  800967:	84 c0                	test   %al,%al
  800969:	75 e8                	jne    800953 <strnlen+0xf>
		n++;
	return n;
  80096b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80096e:	c9                   	leave  
  80096f:	c3                   	ret    

00800970 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800970:	55                   	push   %ebp
  800971:	89 e5                	mov    %esp,%ebp
  800973:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800976:	8b 45 08             	mov    0x8(%ebp),%eax
  800979:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80097c:	90                   	nop
  80097d:	8b 45 08             	mov    0x8(%ebp),%eax
  800980:	8d 50 01             	lea    0x1(%eax),%edx
  800983:	89 55 08             	mov    %edx,0x8(%ebp)
  800986:	8b 55 0c             	mov    0xc(%ebp),%edx
  800989:	8d 4a 01             	lea    0x1(%edx),%ecx
  80098c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80098f:	8a 12                	mov    (%edx),%dl
  800991:	88 10                	mov    %dl,(%eax)
  800993:	8a 00                	mov    (%eax),%al
  800995:	84 c0                	test   %al,%al
  800997:	75 e4                	jne    80097d <strcpy+0xd>
		/* do nothing */;
	return ret;
  800999:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80099c:	c9                   	leave  
  80099d:	c3                   	ret    

0080099e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80099e:	55                   	push   %ebp
  80099f:	89 e5                	mov    %esp,%ebp
  8009a1:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009b1:	eb 1f                	jmp    8009d2 <strncpy+0x34>
		*dst++ = *src;
  8009b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b6:	8d 50 01             	lea    0x1(%eax),%edx
  8009b9:	89 55 08             	mov    %edx,0x8(%ebp)
  8009bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009bf:	8a 12                	mov    (%edx),%dl
  8009c1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c6:	8a 00                	mov    (%eax),%al
  8009c8:	84 c0                	test   %al,%al
  8009ca:	74 03                	je     8009cf <strncpy+0x31>
			src++;
  8009cc:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009cf:	ff 45 fc             	incl   -0x4(%ebp)
  8009d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009d5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009d8:	72 d9                	jb     8009b3 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009da:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009eb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009ef:	74 30                	je     800a21 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009f1:	eb 16                	jmp    800a09 <strlcpy+0x2a>
			*dst++ = *src++;
  8009f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f6:	8d 50 01             	lea    0x1(%eax),%edx
  8009f9:	89 55 08             	mov    %edx,0x8(%ebp)
  8009fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ff:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a02:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a05:	8a 12                	mov    (%edx),%dl
  800a07:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a09:	ff 4d 10             	decl   0x10(%ebp)
  800a0c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a10:	74 09                	je     800a1b <strlcpy+0x3c>
  800a12:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a15:	8a 00                	mov    (%eax),%al
  800a17:	84 c0                	test   %al,%al
  800a19:	75 d8                	jne    8009f3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a1e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a21:	8b 55 08             	mov    0x8(%ebp),%edx
  800a24:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a27:	29 c2                	sub    %eax,%edx
  800a29:	89 d0                	mov    %edx,%eax
}
  800a2b:	c9                   	leave  
  800a2c:	c3                   	ret    

00800a2d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a2d:	55                   	push   %ebp
  800a2e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a30:	eb 06                	jmp    800a38 <strcmp+0xb>
		p++, q++;
  800a32:	ff 45 08             	incl   0x8(%ebp)
  800a35:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	8a 00                	mov    (%eax),%al
  800a3d:	84 c0                	test   %al,%al
  800a3f:	74 0e                	je     800a4f <strcmp+0x22>
  800a41:	8b 45 08             	mov    0x8(%ebp),%eax
  800a44:	8a 10                	mov    (%eax),%dl
  800a46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a49:	8a 00                	mov    (%eax),%al
  800a4b:	38 c2                	cmp    %al,%dl
  800a4d:	74 e3                	je     800a32 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a52:	8a 00                	mov    (%eax),%al
  800a54:	0f b6 d0             	movzbl %al,%edx
  800a57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5a:	8a 00                	mov    (%eax),%al
  800a5c:	0f b6 c0             	movzbl %al,%eax
  800a5f:	29 c2                	sub    %eax,%edx
  800a61:	89 d0                	mov    %edx,%eax
}
  800a63:	5d                   	pop    %ebp
  800a64:	c3                   	ret    

00800a65 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a65:	55                   	push   %ebp
  800a66:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a68:	eb 09                	jmp    800a73 <strncmp+0xe>
		n--, p++, q++;
  800a6a:	ff 4d 10             	decl   0x10(%ebp)
  800a6d:	ff 45 08             	incl   0x8(%ebp)
  800a70:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a73:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a77:	74 17                	je     800a90 <strncmp+0x2b>
  800a79:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7c:	8a 00                	mov    (%eax),%al
  800a7e:	84 c0                	test   %al,%al
  800a80:	74 0e                	je     800a90 <strncmp+0x2b>
  800a82:	8b 45 08             	mov    0x8(%ebp),%eax
  800a85:	8a 10                	mov    (%eax),%dl
  800a87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8a:	8a 00                	mov    (%eax),%al
  800a8c:	38 c2                	cmp    %al,%dl
  800a8e:	74 da                	je     800a6a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a90:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a94:	75 07                	jne    800a9d <strncmp+0x38>
		return 0;
  800a96:	b8 00 00 00 00       	mov    $0x0,%eax
  800a9b:	eb 14                	jmp    800ab1 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa0:	8a 00                	mov    (%eax),%al
  800aa2:	0f b6 d0             	movzbl %al,%edx
  800aa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa8:	8a 00                	mov    (%eax),%al
  800aaa:	0f b6 c0             	movzbl %al,%eax
  800aad:	29 c2                	sub    %eax,%edx
  800aaf:	89 d0                	mov    %edx,%eax
}
  800ab1:	5d                   	pop    %ebp
  800ab2:	c3                   	ret    

00800ab3 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ab3:	55                   	push   %ebp
  800ab4:	89 e5                	mov    %esp,%ebp
  800ab6:	83 ec 04             	sub    $0x4,%esp
  800ab9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800abf:	eb 12                	jmp    800ad3 <strchr+0x20>
		if (*s == c)
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	8a 00                	mov    (%eax),%al
  800ac6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ac9:	75 05                	jne    800ad0 <strchr+0x1d>
			return (char *) s;
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	eb 11                	jmp    800ae1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ad0:	ff 45 08             	incl   0x8(%ebp)
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	8a 00                	mov    (%eax),%al
  800ad8:	84 c0                	test   %al,%al
  800ada:	75 e5                	jne    800ac1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800adc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ae1:	c9                   	leave  
  800ae2:	c3                   	ret    

00800ae3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ae3:	55                   	push   %ebp
  800ae4:	89 e5                	mov    %esp,%ebp
  800ae6:	83 ec 04             	sub    $0x4,%esp
  800ae9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aec:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aef:	eb 0d                	jmp    800afe <strfind+0x1b>
		if (*s == c)
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8a 00                	mov    (%eax),%al
  800af6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800af9:	74 0e                	je     800b09 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800afb:	ff 45 08             	incl   0x8(%ebp)
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	8a 00                	mov    (%eax),%al
  800b03:	84 c0                	test   %al,%al
  800b05:	75 ea                	jne    800af1 <strfind+0xe>
  800b07:	eb 01                	jmp    800b0a <strfind+0x27>
		if (*s == c)
			break;
  800b09:	90                   	nop
	return (char *) s;
  800b0a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b0d:	c9                   	leave  
  800b0e:	c3                   	ret    

00800b0f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b0f:	55                   	push   %ebp
  800b10:	89 e5                	mov    %esp,%ebp
  800b12:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b15:	8b 45 08             	mov    0x8(%ebp),%eax
  800b18:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b1b:	8b 45 10             	mov    0x10(%ebp),%eax
  800b1e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b21:	eb 0e                	jmp    800b31 <memset+0x22>
		*p++ = c;
  800b23:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b26:	8d 50 01             	lea    0x1(%eax),%edx
  800b29:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b2c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b2f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b31:	ff 4d f8             	decl   -0x8(%ebp)
  800b34:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b38:	79 e9                	jns    800b23 <memset+0x14>
		*p++ = c;

	return v;
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b3d:	c9                   	leave  
  800b3e:	c3                   	ret    

00800b3f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b3f:	55                   	push   %ebp
  800b40:	89 e5                	mov    %esp,%ebp
  800b42:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b51:	eb 16                	jmp    800b69 <memcpy+0x2a>
		*d++ = *s++;
  800b53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b56:	8d 50 01             	lea    0x1(%eax),%edx
  800b59:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b5c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b5f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b62:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b65:	8a 12                	mov    (%edx),%dl
  800b67:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b69:	8b 45 10             	mov    0x10(%ebp),%eax
  800b6c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b6f:	89 55 10             	mov    %edx,0x10(%ebp)
  800b72:	85 c0                	test   %eax,%eax
  800b74:	75 dd                	jne    800b53 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b79:	c9                   	leave  
  800b7a:	c3                   	ret    

00800b7b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b7b:	55                   	push   %ebp
  800b7c:	89 e5                	mov    %esp,%ebp
  800b7e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b84:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b90:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b93:	73 50                	jae    800be5 <memmove+0x6a>
  800b95:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b98:	8b 45 10             	mov    0x10(%ebp),%eax
  800b9b:	01 d0                	add    %edx,%eax
  800b9d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ba0:	76 43                	jbe    800be5 <memmove+0x6a>
		s += n;
  800ba2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba5:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ba8:	8b 45 10             	mov    0x10(%ebp),%eax
  800bab:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bae:	eb 10                	jmp    800bc0 <memmove+0x45>
			*--d = *--s;
  800bb0:	ff 4d f8             	decl   -0x8(%ebp)
  800bb3:	ff 4d fc             	decl   -0x4(%ebp)
  800bb6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bb9:	8a 10                	mov    (%eax),%dl
  800bbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bbe:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bc0:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bc6:	89 55 10             	mov    %edx,0x10(%ebp)
  800bc9:	85 c0                	test   %eax,%eax
  800bcb:	75 e3                	jne    800bb0 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bcd:	eb 23                	jmp    800bf2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd2:	8d 50 01             	lea    0x1(%eax),%edx
  800bd5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bd8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bdb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bde:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800be1:	8a 12                	mov    (%edx),%dl
  800be3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800be5:	8b 45 10             	mov    0x10(%ebp),%eax
  800be8:	8d 50 ff             	lea    -0x1(%eax),%edx
  800beb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bee:	85 c0                	test   %eax,%eax
  800bf0:	75 dd                	jne    800bcf <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bf5:	c9                   	leave  
  800bf6:	c3                   	ret    

00800bf7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bf7:	55                   	push   %ebp
  800bf8:	89 e5                	mov    %esp,%ebp
  800bfa:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800c00:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c06:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c09:	eb 2a                	jmp    800c35 <memcmp+0x3e>
		if (*s1 != *s2)
  800c0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c0e:	8a 10                	mov    (%eax),%dl
  800c10:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c13:	8a 00                	mov    (%eax),%al
  800c15:	38 c2                	cmp    %al,%dl
  800c17:	74 16                	je     800c2f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c1c:	8a 00                	mov    (%eax),%al
  800c1e:	0f b6 d0             	movzbl %al,%edx
  800c21:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c24:	8a 00                	mov    (%eax),%al
  800c26:	0f b6 c0             	movzbl %al,%eax
  800c29:	29 c2                	sub    %eax,%edx
  800c2b:	89 d0                	mov    %edx,%eax
  800c2d:	eb 18                	jmp    800c47 <memcmp+0x50>
		s1++, s2++;
  800c2f:	ff 45 fc             	incl   -0x4(%ebp)
  800c32:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c35:	8b 45 10             	mov    0x10(%ebp),%eax
  800c38:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c3b:	89 55 10             	mov    %edx,0x10(%ebp)
  800c3e:	85 c0                	test   %eax,%eax
  800c40:	75 c9                	jne    800c0b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c42:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c47:	c9                   	leave  
  800c48:	c3                   	ret    

00800c49 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c49:	55                   	push   %ebp
  800c4a:	89 e5                	mov    %esp,%ebp
  800c4c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c4f:	8b 55 08             	mov    0x8(%ebp),%edx
  800c52:	8b 45 10             	mov    0x10(%ebp),%eax
  800c55:	01 d0                	add    %edx,%eax
  800c57:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c5a:	eb 15                	jmp    800c71 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	8a 00                	mov    (%eax),%al
  800c61:	0f b6 d0             	movzbl %al,%edx
  800c64:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c67:	0f b6 c0             	movzbl %al,%eax
  800c6a:	39 c2                	cmp    %eax,%edx
  800c6c:	74 0d                	je     800c7b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c6e:	ff 45 08             	incl   0x8(%ebp)
  800c71:	8b 45 08             	mov    0x8(%ebp),%eax
  800c74:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c77:	72 e3                	jb     800c5c <memfind+0x13>
  800c79:	eb 01                	jmp    800c7c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c7b:	90                   	nop
	return (void *) s;
  800c7c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c7f:	c9                   	leave  
  800c80:	c3                   	ret    

00800c81 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c81:	55                   	push   %ebp
  800c82:	89 e5                	mov    %esp,%ebp
  800c84:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c8e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c95:	eb 03                	jmp    800c9a <strtol+0x19>
		s++;
  800c97:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9d:	8a 00                	mov    (%eax),%al
  800c9f:	3c 20                	cmp    $0x20,%al
  800ca1:	74 f4                	je     800c97 <strtol+0x16>
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	8a 00                	mov    (%eax),%al
  800ca8:	3c 09                	cmp    $0x9,%al
  800caa:	74 eb                	je     800c97 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cac:	8b 45 08             	mov    0x8(%ebp),%eax
  800caf:	8a 00                	mov    (%eax),%al
  800cb1:	3c 2b                	cmp    $0x2b,%al
  800cb3:	75 05                	jne    800cba <strtol+0x39>
		s++;
  800cb5:	ff 45 08             	incl   0x8(%ebp)
  800cb8:	eb 13                	jmp    800ccd <strtol+0x4c>
	else if (*s == '-')
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	8a 00                	mov    (%eax),%al
  800cbf:	3c 2d                	cmp    $0x2d,%al
  800cc1:	75 0a                	jne    800ccd <strtol+0x4c>
		s++, neg = 1;
  800cc3:	ff 45 08             	incl   0x8(%ebp)
  800cc6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ccd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd1:	74 06                	je     800cd9 <strtol+0x58>
  800cd3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cd7:	75 20                	jne    800cf9 <strtol+0x78>
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	3c 30                	cmp    $0x30,%al
  800ce0:	75 17                	jne    800cf9 <strtol+0x78>
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	40                   	inc    %eax
  800ce6:	8a 00                	mov    (%eax),%al
  800ce8:	3c 78                	cmp    $0x78,%al
  800cea:	75 0d                	jne    800cf9 <strtol+0x78>
		s += 2, base = 16;
  800cec:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cf0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cf7:	eb 28                	jmp    800d21 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800cf9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cfd:	75 15                	jne    800d14 <strtol+0x93>
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8a 00                	mov    (%eax),%al
  800d04:	3c 30                	cmp    $0x30,%al
  800d06:	75 0c                	jne    800d14 <strtol+0x93>
		s++, base = 8;
  800d08:	ff 45 08             	incl   0x8(%ebp)
  800d0b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d12:	eb 0d                	jmp    800d21 <strtol+0xa0>
	else if (base == 0)
  800d14:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d18:	75 07                	jne    800d21 <strtol+0xa0>
		base = 10;
  800d1a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	3c 2f                	cmp    $0x2f,%al
  800d28:	7e 19                	jle    800d43 <strtol+0xc2>
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	3c 39                	cmp    $0x39,%al
  800d31:	7f 10                	jg     800d43 <strtol+0xc2>
			dig = *s - '0';
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	0f be c0             	movsbl %al,%eax
  800d3b:	83 e8 30             	sub    $0x30,%eax
  800d3e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d41:	eb 42                	jmp    800d85 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	3c 60                	cmp    $0x60,%al
  800d4a:	7e 19                	jle    800d65 <strtol+0xe4>
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3c 7a                	cmp    $0x7a,%al
  800d53:	7f 10                	jg     800d65 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	0f be c0             	movsbl %al,%eax
  800d5d:	83 e8 57             	sub    $0x57,%eax
  800d60:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d63:	eb 20                	jmp    800d85 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	8a 00                	mov    (%eax),%al
  800d6a:	3c 40                	cmp    $0x40,%al
  800d6c:	7e 39                	jle    800da7 <strtol+0x126>
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d71:	8a 00                	mov    (%eax),%al
  800d73:	3c 5a                	cmp    $0x5a,%al
  800d75:	7f 30                	jg     800da7 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d77:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7a:	8a 00                	mov    (%eax),%al
  800d7c:	0f be c0             	movsbl %al,%eax
  800d7f:	83 e8 37             	sub    $0x37,%eax
  800d82:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d85:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d88:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d8b:	7d 19                	jge    800da6 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d8d:	ff 45 08             	incl   0x8(%ebp)
  800d90:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d93:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d97:	89 c2                	mov    %eax,%edx
  800d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d9c:	01 d0                	add    %edx,%eax
  800d9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800da1:	e9 7b ff ff ff       	jmp    800d21 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800da6:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800da7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dab:	74 08                	je     800db5 <strtol+0x134>
		*endptr = (char *) s;
  800dad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db0:	8b 55 08             	mov    0x8(%ebp),%edx
  800db3:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800db5:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800db9:	74 07                	je     800dc2 <strtol+0x141>
  800dbb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dbe:	f7 d8                	neg    %eax
  800dc0:	eb 03                	jmp    800dc5 <strtol+0x144>
  800dc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dc5:	c9                   	leave  
  800dc6:	c3                   	ret    

00800dc7 <ltostr>:

void
ltostr(long value, char *str)
{
  800dc7:	55                   	push   %ebp
  800dc8:	89 e5                	mov    %esp,%ebp
  800dca:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dcd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dd4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800ddb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ddf:	79 13                	jns    800df4 <ltostr+0x2d>
	{
		neg = 1;
  800de1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800de8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800deb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dee:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800df1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800df4:	8b 45 08             	mov    0x8(%ebp),%eax
  800df7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800dfc:	99                   	cltd   
  800dfd:	f7 f9                	idiv   %ecx
  800dff:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e02:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e05:	8d 50 01             	lea    0x1(%eax),%edx
  800e08:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e0b:	89 c2                	mov    %eax,%edx
  800e0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e10:	01 d0                	add    %edx,%eax
  800e12:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e15:	83 c2 30             	add    $0x30,%edx
  800e18:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e1d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e22:	f7 e9                	imul   %ecx
  800e24:	c1 fa 02             	sar    $0x2,%edx
  800e27:	89 c8                	mov    %ecx,%eax
  800e29:	c1 f8 1f             	sar    $0x1f,%eax
  800e2c:	29 c2                	sub    %eax,%edx
  800e2e:	89 d0                	mov    %edx,%eax
  800e30:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e33:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e36:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e3b:	f7 e9                	imul   %ecx
  800e3d:	c1 fa 02             	sar    $0x2,%edx
  800e40:	89 c8                	mov    %ecx,%eax
  800e42:	c1 f8 1f             	sar    $0x1f,%eax
  800e45:	29 c2                	sub    %eax,%edx
  800e47:	89 d0                	mov    %edx,%eax
  800e49:	c1 e0 02             	shl    $0x2,%eax
  800e4c:	01 d0                	add    %edx,%eax
  800e4e:	01 c0                	add    %eax,%eax
  800e50:	29 c1                	sub    %eax,%ecx
  800e52:	89 ca                	mov    %ecx,%edx
  800e54:	85 d2                	test   %edx,%edx
  800e56:	75 9c                	jne    800df4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e58:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e5f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e62:	48                   	dec    %eax
  800e63:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e66:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e6a:	74 3d                	je     800ea9 <ltostr+0xe2>
		start = 1 ;
  800e6c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e73:	eb 34                	jmp    800ea9 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e75:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7b:	01 d0                	add    %edx,%eax
  800e7d:	8a 00                	mov    (%eax),%al
  800e7f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e82:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e88:	01 c2                	add    %eax,%edx
  800e8a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e90:	01 c8                	add    %ecx,%eax
  800e92:	8a 00                	mov    (%eax),%al
  800e94:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e96:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	01 c2                	add    %eax,%edx
  800e9e:	8a 45 eb             	mov    -0x15(%ebp),%al
  800ea1:	88 02                	mov    %al,(%edx)
		start++ ;
  800ea3:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800ea6:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ea9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eac:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800eaf:	7c c4                	jl     800e75 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800eb1:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800eb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb7:	01 d0                	add    %edx,%eax
  800eb9:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ebc:	90                   	nop
  800ebd:	c9                   	leave  
  800ebe:	c3                   	ret    

00800ebf <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ebf:	55                   	push   %ebp
  800ec0:	89 e5                	mov    %esp,%ebp
  800ec2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ec5:	ff 75 08             	pushl  0x8(%ebp)
  800ec8:	e8 54 fa ff ff       	call   800921 <strlen>
  800ecd:	83 c4 04             	add    $0x4,%esp
  800ed0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ed3:	ff 75 0c             	pushl  0xc(%ebp)
  800ed6:	e8 46 fa ff ff       	call   800921 <strlen>
  800edb:	83 c4 04             	add    $0x4,%esp
  800ede:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ee1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ee8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eef:	eb 17                	jmp    800f08 <strcconcat+0x49>
		final[s] = str1[s] ;
  800ef1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ef4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef7:	01 c2                	add    %eax,%edx
  800ef9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800efc:	8b 45 08             	mov    0x8(%ebp),%eax
  800eff:	01 c8                	add    %ecx,%eax
  800f01:	8a 00                	mov    (%eax),%al
  800f03:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f05:	ff 45 fc             	incl   -0x4(%ebp)
  800f08:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f0e:	7c e1                	jl     800ef1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f10:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f17:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f1e:	eb 1f                	jmp    800f3f <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f20:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f23:	8d 50 01             	lea    0x1(%eax),%edx
  800f26:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f29:	89 c2                	mov    %eax,%edx
  800f2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f2e:	01 c2                	add    %eax,%edx
  800f30:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f36:	01 c8                	add    %ecx,%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f3c:	ff 45 f8             	incl   -0x8(%ebp)
  800f3f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f42:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f45:	7c d9                	jl     800f20 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f47:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f4a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f4d:	01 d0                	add    %edx,%eax
  800f4f:	c6 00 00             	movb   $0x0,(%eax)
}
  800f52:	90                   	nop
  800f53:	c9                   	leave  
  800f54:	c3                   	ret    

00800f55 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f55:	55                   	push   %ebp
  800f56:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f58:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f61:	8b 45 14             	mov    0x14(%ebp),%eax
  800f64:	8b 00                	mov    (%eax),%eax
  800f66:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f6d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f70:	01 d0                	add    %edx,%eax
  800f72:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f78:	eb 0c                	jmp    800f86 <strsplit+0x31>
			*string++ = 0;
  800f7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7d:	8d 50 01             	lea    0x1(%eax),%edx
  800f80:	89 55 08             	mov    %edx,0x8(%ebp)
  800f83:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f86:	8b 45 08             	mov    0x8(%ebp),%eax
  800f89:	8a 00                	mov    (%eax),%al
  800f8b:	84 c0                	test   %al,%al
  800f8d:	74 18                	je     800fa7 <strsplit+0x52>
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	8a 00                	mov    (%eax),%al
  800f94:	0f be c0             	movsbl %al,%eax
  800f97:	50                   	push   %eax
  800f98:	ff 75 0c             	pushl  0xc(%ebp)
  800f9b:	e8 13 fb ff ff       	call   800ab3 <strchr>
  800fa0:	83 c4 08             	add    $0x8,%esp
  800fa3:	85 c0                	test   %eax,%eax
  800fa5:	75 d3                	jne    800f7a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	84 c0                	test   %al,%al
  800fae:	74 5a                	je     80100a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800fb3:	8b 00                	mov    (%eax),%eax
  800fb5:	83 f8 0f             	cmp    $0xf,%eax
  800fb8:	75 07                	jne    800fc1 <strsplit+0x6c>
		{
			return 0;
  800fba:	b8 00 00 00 00       	mov    $0x0,%eax
  800fbf:	eb 66                	jmp    801027 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc4:	8b 00                	mov    (%eax),%eax
  800fc6:	8d 48 01             	lea    0x1(%eax),%ecx
  800fc9:	8b 55 14             	mov    0x14(%ebp),%edx
  800fcc:	89 0a                	mov    %ecx,(%edx)
  800fce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fd5:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd8:	01 c2                	add    %eax,%edx
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fdf:	eb 03                	jmp    800fe4 <strsplit+0x8f>
			string++;
  800fe1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fe4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	84 c0                	test   %al,%al
  800feb:	74 8b                	je     800f78 <strsplit+0x23>
  800fed:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff0:	8a 00                	mov    (%eax),%al
  800ff2:	0f be c0             	movsbl %al,%eax
  800ff5:	50                   	push   %eax
  800ff6:	ff 75 0c             	pushl  0xc(%ebp)
  800ff9:	e8 b5 fa ff ff       	call   800ab3 <strchr>
  800ffe:	83 c4 08             	add    $0x8,%esp
  801001:	85 c0                	test   %eax,%eax
  801003:	74 dc                	je     800fe1 <strsplit+0x8c>
			string++;
	}
  801005:	e9 6e ff ff ff       	jmp    800f78 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80100a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80100b:	8b 45 14             	mov    0x14(%ebp),%eax
  80100e:	8b 00                	mov    (%eax),%eax
  801010:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801017:	8b 45 10             	mov    0x10(%ebp),%eax
  80101a:	01 d0                	add    %edx,%eax
  80101c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801022:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801027:	c9                   	leave  
  801028:	c3                   	ret    

00801029 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801029:	55                   	push   %ebp
  80102a:	89 e5                	mov    %esp,%ebp
  80102c:	57                   	push   %edi
  80102d:	56                   	push   %esi
  80102e:	53                   	push   %ebx
  80102f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801032:	8b 45 08             	mov    0x8(%ebp),%eax
  801035:	8b 55 0c             	mov    0xc(%ebp),%edx
  801038:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80103b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80103e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801041:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801044:	cd 30                	int    $0x30
  801046:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801049:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80104c:	83 c4 10             	add    $0x10,%esp
  80104f:	5b                   	pop    %ebx
  801050:	5e                   	pop    %esi
  801051:	5f                   	pop    %edi
  801052:	5d                   	pop    %ebp
  801053:	c3                   	ret    

00801054 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801054:	55                   	push   %ebp
  801055:	89 e5                	mov    %esp,%ebp
  801057:	83 ec 04             	sub    $0x4,%esp
  80105a:	8b 45 10             	mov    0x10(%ebp),%eax
  80105d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801060:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801064:	8b 45 08             	mov    0x8(%ebp),%eax
  801067:	6a 00                	push   $0x0
  801069:	6a 00                	push   $0x0
  80106b:	52                   	push   %edx
  80106c:	ff 75 0c             	pushl  0xc(%ebp)
  80106f:	50                   	push   %eax
  801070:	6a 00                	push   $0x0
  801072:	e8 b2 ff ff ff       	call   801029 <syscall>
  801077:	83 c4 18             	add    $0x18,%esp
}
  80107a:	90                   	nop
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <sys_cgetc>:

int
sys_cgetc(void)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801080:	6a 00                	push   $0x0
  801082:	6a 00                	push   $0x0
  801084:	6a 00                	push   $0x0
  801086:	6a 00                	push   $0x0
  801088:	6a 00                	push   $0x0
  80108a:	6a 01                	push   $0x1
  80108c:	e8 98 ff ff ff       	call   801029 <syscall>
  801091:	83 c4 18             	add    $0x18,%esp
}
  801094:	c9                   	leave  
  801095:	c3                   	ret    

00801096 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801096:	55                   	push   %ebp
  801097:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801099:	8b 45 08             	mov    0x8(%ebp),%eax
  80109c:	6a 00                	push   $0x0
  80109e:	6a 00                	push   $0x0
  8010a0:	6a 00                	push   $0x0
  8010a2:	6a 00                	push   $0x0
  8010a4:	50                   	push   %eax
  8010a5:	6a 05                	push   $0x5
  8010a7:	e8 7d ff ff ff       	call   801029 <syscall>
  8010ac:	83 c4 18             	add    $0x18,%esp
}
  8010af:	c9                   	leave  
  8010b0:	c3                   	ret    

008010b1 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010b1:	55                   	push   %ebp
  8010b2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 00                	push   $0x0
  8010ba:	6a 00                	push   $0x0
  8010bc:	6a 00                	push   $0x0
  8010be:	6a 02                	push   $0x2
  8010c0:	e8 64 ff ff ff       	call   801029 <syscall>
  8010c5:	83 c4 18             	add    $0x18,%esp
}
  8010c8:	c9                   	leave  
  8010c9:	c3                   	ret    

008010ca <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010ca:	55                   	push   %ebp
  8010cb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 00                	push   $0x0
  8010d1:	6a 00                	push   $0x0
  8010d3:	6a 00                	push   $0x0
  8010d5:	6a 00                	push   $0x0
  8010d7:	6a 03                	push   $0x3
  8010d9:	e8 4b ff ff ff       	call   801029 <syscall>
  8010de:	83 c4 18             	add    $0x18,%esp
}
  8010e1:	c9                   	leave  
  8010e2:	c3                   	ret    

008010e3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010e3:	55                   	push   %ebp
  8010e4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 00                	push   $0x0
  8010ec:	6a 00                	push   $0x0
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 04                	push   $0x4
  8010f2:	e8 32 ff ff ff       	call   801029 <syscall>
  8010f7:	83 c4 18             	add    $0x18,%esp
}
  8010fa:	c9                   	leave  
  8010fb:	c3                   	ret    

008010fc <sys_env_exit>:


void sys_env_exit(void)
{
  8010fc:	55                   	push   %ebp
  8010fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010ff:	6a 00                	push   $0x0
  801101:	6a 00                	push   $0x0
  801103:	6a 00                	push   $0x0
  801105:	6a 00                	push   $0x0
  801107:	6a 00                	push   $0x0
  801109:	6a 06                	push   $0x6
  80110b:	e8 19 ff ff ff       	call   801029 <syscall>
  801110:	83 c4 18             	add    $0x18,%esp
}
  801113:	90                   	nop
  801114:	c9                   	leave  
  801115:	c3                   	ret    

00801116 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801116:	55                   	push   %ebp
  801117:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801119:	8b 55 0c             	mov    0xc(%ebp),%edx
  80111c:	8b 45 08             	mov    0x8(%ebp),%eax
  80111f:	6a 00                	push   $0x0
  801121:	6a 00                	push   $0x0
  801123:	6a 00                	push   $0x0
  801125:	52                   	push   %edx
  801126:	50                   	push   %eax
  801127:	6a 07                	push   $0x7
  801129:	e8 fb fe ff ff       	call   801029 <syscall>
  80112e:	83 c4 18             	add    $0x18,%esp
}
  801131:	c9                   	leave  
  801132:	c3                   	ret    

00801133 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801133:	55                   	push   %ebp
  801134:	89 e5                	mov    %esp,%ebp
  801136:	56                   	push   %esi
  801137:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801138:	8b 75 18             	mov    0x18(%ebp),%esi
  80113b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80113e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801141:	8b 55 0c             	mov    0xc(%ebp),%edx
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	56                   	push   %esi
  801148:	53                   	push   %ebx
  801149:	51                   	push   %ecx
  80114a:	52                   	push   %edx
  80114b:	50                   	push   %eax
  80114c:	6a 08                	push   $0x8
  80114e:	e8 d6 fe ff ff       	call   801029 <syscall>
  801153:	83 c4 18             	add    $0x18,%esp
}
  801156:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801159:	5b                   	pop    %ebx
  80115a:	5e                   	pop    %esi
  80115b:	5d                   	pop    %ebp
  80115c:	c3                   	ret    

0080115d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80115d:	55                   	push   %ebp
  80115e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801160:	8b 55 0c             	mov    0xc(%ebp),%edx
  801163:	8b 45 08             	mov    0x8(%ebp),%eax
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	6a 00                	push   $0x0
  80116c:	52                   	push   %edx
  80116d:	50                   	push   %eax
  80116e:	6a 09                	push   $0x9
  801170:	e8 b4 fe ff ff       	call   801029 <syscall>
  801175:	83 c4 18             	add    $0x18,%esp
}
  801178:	c9                   	leave  
  801179:	c3                   	ret    

0080117a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80117a:	55                   	push   %ebp
  80117b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80117d:	6a 00                	push   $0x0
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	ff 75 0c             	pushl  0xc(%ebp)
  801186:	ff 75 08             	pushl  0x8(%ebp)
  801189:	6a 0a                	push   $0xa
  80118b:	e8 99 fe ff ff       	call   801029 <syscall>
  801190:	83 c4 18             	add    $0x18,%esp
}
  801193:	c9                   	leave  
  801194:	c3                   	ret    

00801195 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801195:	55                   	push   %ebp
  801196:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 0b                	push   $0xb
  8011a4:	e8 80 fe ff ff       	call   801029 <syscall>
  8011a9:	83 c4 18             	add    $0x18,%esp
}
  8011ac:	c9                   	leave  
  8011ad:	c3                   	ret    

008011ae <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011ae:	55                   	push   %ebp
  8011af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 0c                	push   $0xc
  8011bd:	e8 67 fe ff ff       	call   801029 <syscall>
  8011c2:	83 c4 18             	add    $0x18,%esp
}
  8011c5:	c9                   	leave  
  8011c6:	c3                   	ret    

008011c7 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011c7:	55                   	push   %ebp
  8011c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 00                	push   $0x0
  8011d4:	6a 0d                	push   $0xd
  8011d6:	e8 4e fe ff ff       	call   801029 <syscall>
  8011db:	83 c4 18             	add    $0x18,%esp
}
  8011de:	c9                   	leave  
  8011df:	c3                   	ret    

008011e0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011e0:	55                   	push   %ebp
  8011e1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	ff 75 0c             	pushl  0xc(%ebp)
  8011ec:	ff 75 08             	pushl  0x8(%ebp)
  8011ef:	6a 11                	push   $0x11
  8011f1:	e8 33 fe ff ff       	call   801029 <syscall>
  8011f6:	83 c4 18             	add    $0x18,%esp
	return;
  8011f9:	90                   	nop
}
  8011fa:	c9                   	leave  
  8011fb:	c3                   	ret    

008011fc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011fc:	55                   	push   %ebp
  8011fd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	6a 00                	push   $0x0
  801205:	ff 75 0c             	pushl  0xc(%ebp)
  801208:	ff 75 08             	pushl  0x8(%ebp)
  80120b:	6a 12                	push   $0x12
  80120d:	e8 17 fe ff ff       	call   801029 <syscall>
  801212:	83 c4 18             	add    $0x18,%esp
	return ;
  801215:	90                   	nop
}
  801216:	c9                   	leave  
  801217:	c3                   	ret    

00801218 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 00                	push   $0x0
  801223:	6a 00                	push   $0x0
  801225:	6a 0e                	push   $0xe
  801227:	e8 fd fd ff ff       	call   801029 <syscall>
  80122c:	83 c4 18             	add    $0x18,%esp
}
  80122f:	c9                   	leave  
  801230:	c3                   	ret    

00801231 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801231:	55                   	push   %ebp
  801232:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801234:	6a 00                	push   $0x0
  801236:	6a 00                	push   $0x0
  801238:	6a 00                	push   $0x0
  80123a:	6a 00                	push   $0x0
  80123c:	ff 75 08             	pushl  0x8(%ebp)
  80123f:	6a 0f                	push   $0xf
  801241:	e8 e3 fd ff ff       	call   801029 <syscall>
  801246:	83 c4 18             	add    $0x18,%esp
}
  801249:	c9                   	leave  
  80124a:	c3                   	ret    

0080124b <sys_scarce_memory>:

void sys_scarce_memory()
{
  80124b:	55                   	push   %ebp
  80124c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80124e:	6a 00                	push   $0x0
  801250:	6a 00                	push   $0x0
  801252:	6a 00                	push   $0x0
  801254:	6a 00                	push   $0x0
  801256:	6a 00                	push   $0x0
  801258:	6a 10                	push   $0x10
  80125a:	e8 ca fd ff ff       	call   801029 <syscall>
  80125f:	83 c4 18             	add    $0x18,%esp
}
  801262:	90                   	nop
  801263:	c9                   	leave  
  801264:	c3                   	ret    

00801265 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801265:	55                   	push   %ebp
  801266:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 00                	push   $0x0
  80126e:	6a 00                	push   $0x0
  801270:	6a 00                	push   $0x0
  801272:	6a 14                	push   $0x14
  801274:	e8 b0 fd ff ff       	call   801029 <syscall>
  801279:	83 c4 18             	add    $0x18,%esp
}
  80127c:	90                   	nop
  80127d:	c9                   	leave  
  80127e:	c3                   	ret    

0080127f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80127f:	55                   	push   %ebp
  801280:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 00                	push   $0x0
  801288:	6a 00                	push   $0x0
  80128a:	6a 00                	push   $0x0
  80128c:	6a 15                	push   $0x15
  80128e:	e8 96 fd ff ff       	call   801029 <syscall>
  801293:	83 c4 18             	add    $0x18,%esp
}
  801296:	90                   	nop
  801297:	c9                   	leave  
  801298:	c3                   	ret    

00801299 <sys_cputc>:


void
sys_cputc(const char c)
{
  801299:	55                   	push   %ebp
  80129a:	89 e5                	mov    %esp,%ebp
  80129c:	83 ec 04             	sub    $0x4,%esp
  80129f:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012a5:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 00                	push   $0x0
  8012b1:	50                   	push   %eax
  8012b2:	6a 16                	push   $0x16
  8012b4:	e8 70 fd ff ff       	call   801029 <syscall>
  8012b9:	83 c4 18             	add    $0x18,%esp
}
  8012bc:	90                   	nop
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012c2:	6a 00                	push   $0x0
  8012c4:	6a 00                	push   $0x0
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 00                	push   $0x0
  8012ca:	6a 00                	push   $0x0
  8012cc:	6a 17                	push   $0x17
  8012ce:	e8 56 fd ff ff       	call   801029 <syscall>
  8012d3:	83 c4 18             	add    $0x18,%esp
}
  8012d6:	90                   	nop
  8012d7:	c9                   	leave  
  8012d8:	c3                   	ret    

008012d9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012d9:	55                   	push   %ebp
  8012da:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	ff 75 0c             	pushl  0xc(%ebp)
  8012e8:	50                   	push   %eax
  8012e9:	6a 18                	push   $0x18
  8012eb:	e8 39 fd ff ff       	call   801029 <syscall>
  8012f0:	83 c4 18             	add    $0x18,%esp
}
  8012f3:	c9                   	leave  
  8012f4:	c3                   	ret    

008012f5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012f5:	55                   	push   %ebp
  8012f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	52                   	push   %edx
  801305:	50                   	push   %eax
  801306:	6a 1b                	push   $0x1b
  801308:	e8 1c fd ff ff       	call   801029 <syscall>
  80130d:	83 c4 18             	add    $0x18,%esp
}
  801310:	c9                   	leave  
  801311:	c3                   	ret    

00801312 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801312:	55                   	push   %ebp
  801313:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801315:	8b 55 0c             	mov    0xc(%ebp),%edx
  801318:	8b 45 08             	mov    0x8(%ebp),%eax
  80131b:	6a 00                	push   $0x0
  80131d:	6a 00                	push   $0x0
  80131f:	6a 00                	push   $0x0
  801321:	52                   	push   %edx
  801322:	50                   	push   %eax
  801323:	6a 19                	push   $0x19
  801325:	e8 ff fc ff ff       	call   801029 <syscall>
  80132a:	83 c4 18             	add    $0x18,%esp
}
  80132d:	90                   	nop
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801333:	8b 55 0c             	mov    0xc(%ebp),%edx
  801336:	8b 45 08             	mov    0x8(%ebp),%eax
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	52                   	push   %edx
  801340:	50                   	push   %eax
  801341:	6a 1a                	push   $0x1a
  801343:	e8 e1 fc ff ff       	call   801029 <syscall>
  801348:	83 c4 18             	add    $0x18,%esp
}
  80134b:	90                   	nop
  80134c:	c9                   	leave  
  80134d:	c3                   	ret    

0080134e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80134e:	55                   	push   %ebp
  80134f:	89 e5                	mov    %esp,%ebp
  801351:	83 ec 04             	sub    $0x4,%esp
  801354:	8b 45 10             	mov    0x10(%ebp),%eax
  801357:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80135a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80135d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801361:	8b 45 08             	mov    0x8(%ebp),%eax
  801364:	6a 00                	push   $0x0
  801366:	51                   	push   %ecx
  801367:	52                   	push   %edx
  801368:	ff 75 0c             	pushl  0xc(%ebp)
  80136b:	50                   	push   %eax
  80136c:	6a 1c                	push   $0x1c
  80136e:	e8 b6 fc ff ff       	call   801029 <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	c9                   	leave  
  801377:	c3                   	ret    

00801378 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801378:	55                   	push   %ebp
  801379:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80137b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	6a 00                	push   $0x0
  801387:	52                   	push   %edx
  801388:	50                   	push   %eax
  801389:	6a 1d                	push   $0x1d
  80138b:	e8 99 fc ff ff       	call   801029 <syscall>
  801390:	83 c4 18             	add    $0x18,%esp
}
  801393:	c9                   	leave  
  801394:	c3                   	ret    

00801395 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801395:	55                   	push   %ebp
  801396:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801398:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80139b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80139e:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	51                   	push   %ecx
  8013a6:	52                   	push   %edx
  8013a7:	50                   	push   %eax
  8013a8:	6a 1e                	push   $0x1e
  8013aa:	e8 7a fc ff ff       	call   801029 <syscall>
  8013af:	83 c4 18             	add    $0x18,%esp
}
  8013b2:	c9                   	leave  
  8013b3:	c3                   	ret    

008013b4 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013b4:	55                   	push   %ebp
  8013b5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	52                   	push   %edx
  8013c4:	50                   	push   %eax
  8013c5:	6a 1f                	push   $0x1f
  8013c7:	e8 5d fc ff ff       	call   801029 <syscall>
  8013cc:	83 c4 18             	add    $0x18,%esp
}
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 20                	push   $0x20
  8013e0:	e8 44 fc ff ff       	call   801029 <syscall>
  8013e5:	83 c4 18             	add    $0x18,%esp
}
  8013e8:	c9                   	leave  
  8013e9:	c3                   	ret    

008013ea <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013ea:	55                   	push   %ebp
  8013eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f0:	6a 00                	push   $0x0
  8013f2:	ff 75 14             	pushl  0x14(%ebp)
  8013f5:	ff 75 10             	pushl  0x10(%ebp)
  8013f8:	ff 75 0c             	pushl  0xc(%ebp)
  8013fb:	50                   	push   %eax
  8013fc:	6a 21                	push   $0x21
  8013fe:	e8 26 fc ff ff       	call   801029 <syscall>
  801403:	83 c4 18             	add    $0x18,%esp
}
  801406:	c9                   	leave  
  801407:	c3                   	ret    

00801408 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801408:	55                   	push   %ebp
  801409:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80140b:	8b 45 08             	mov    0x8(%ebp),%eax
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	50                   	push   %eax
  801417:	6a 22                	push   $0x22
  801419:	e8 0b fc ff ff       	call   801029 <syscall>
  80141e:	83 c4 18             	add    $0x18,%esp
}
  801421:	90                   	nop
  801422:	c9                   	leave  
  801423:	c3                   	ret    

00801424 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801427:	8b 45 08             	mov    0x8(%ebp),%eax
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	50                   	push   %eax
  801433:	6a 23                	push   $0x23
  801435:	e8 ef fb ff ff       	call   801029 <syscall>
  80143a:	83 c4 18             	add    $0x18,%esp
}
  80143d:	90                   	nop
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
  801443:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801446:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801449:	8d 50 04             	lea    0x4(%eax),%edx
  80144c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	52                   	push   %edx
  801456:	50                   	push   %eax
  801457:	6a 24                	push   $0x24
  801459:	e8 cb fb ff ff       	call   801029 <syscall>
  80145e:	83 c4 18             	add    $0x18,%esp
	return result;
  801461:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801464:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801467:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80146a:	89 01                	mov    %eax,(%ecx)
  80146c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80146f:	8b 45 08             	mov    0x8(%ebp),%eax
  801472:	c9                   	leave  
  801473:	c2 04 00             	ret    $0x4

00801476 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801476:	55                   	push   %ebp
  801477:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	ff 75 10             	pushl  0x10(%ebp)
  801480:	ff 75 0c             	pushl  0xc(%ebp)
  801483:	ff 75 08             	pushl  0x8(%ebp)
  801486:	6a 13                	push   $0x13
  801488:	e8 9c fb ff ff       	call   801029 <syscall>
  80148d:	83 c4 18             	add    $0x18,%esp
	return ;
  801490:	90                   	nop
}
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <sys_rcr2>:
uint32 sys_rcr2()
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 25                	push   $0x25
  8014a2:	e8 82 fb ff ff       	call   801029 <syscall>
  8014a7:	83 c4 18             	add    $0x18,%esp
}
  8014aa:	c9                   	leave  
  8014ab:	c3                   	ret    

008014ac <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014ac:	55                   	push   %ebp
  8014ad:	89 e5                	mov    %esp,%ebp
  8014af:	83 ec 04             	sub    $0x4,%esp
  8014b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014b8:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	50                   	push   %eax
  8014c5:	6a 26                	push   $0x26
  8014c7:	e8 5d fb ff ff       	call   801029 <syscall>
  8014cc:	83 c4 18             	add    $0x18,%esp
	return ;
  8014cf:	90                   	nop
}
  8014d0:	c9                   	leave  
  8014d1:	c3                   	ret    

008014d2 <rsttst>:
void rsttst()
{
  8014d2:	55                   	push   %ebp
  8014d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014d5:	6a 00                	push   $0x0
  8014d7:	6a 00                	push   $0x0
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 28                	push   $0x28
  8014e1:	e8 43 fb ff ff       	call   801029 <syscall>
  8014e6:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e9:	90                   	nop
}
  8014ea:	c9                   	leave  
  8014eb:	c3                   	ret    

008014ec <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014ec:	55                   	push   %ebp
  8014ed:	89 e5                	mov    %esp,%ebp
  8014ef:	83 ec 04             	sub    $0x4,%esp
  8014f2:	8b 45 14             	mov    0x14(%ebp),%eax
  8014f5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014f8:	8b 55 18             	mov    0x18(%ebp),%edx
  8014fb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014ff:	52                   	push   %edx
  801500:	50                   	push   %eax
  801501:	ff 75 10             	pushl  0x10(%ebp)
  801504:	ff 75 0c             	pushl  0xc(%ebp)
  801507:	ff 75 08             	pushl  0x8(%ebp)
  80150a:	6a 27                	push   $0x27
  80150c:	e8 18 fb ff ff       	call   801029 <syscall>
  801511:	83 c4 18             	add    $0x18,%esp
	return ;
  801514:	90                   	nop
}
  801515:	c9                   	leave  
  801516:	c3                   	ret    

00801517 <chktst>:
void chktst(uint32 n)
{
  801517:	55                   	push   %ebp
  801518:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	ff 75 08             	pushl  0x8(%ebp)
  801525:	6a 29                	push   $0x29
  801527:	e8 fd fa ff ff       	call   801029 <syscall>
  80152c:	83 c4 18             	add    $0x18,%esp
	return ;
  80152f:	90                   	nop
}
  801530:	c9                   	leave  
  801531:	c3                   	ret    

00801532 <inctst>:

void inctst()
{
  801532:	55                   	push   %ebp
  801533:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801535:	6a 00                	push   $0x0
  801537:	6a 00                	push   $0x0
  801539:	6a 00                	push   $0x0
  80153b:	6a 00                	push   $0x0
  80153d:	6a 00                	push   $0x0
  80153f:	6a 2a                	push   $0x2a
  801541:	e8 e3 fa ff ff       	call   801029 <syscall>
  801546:	83 c4 18             	add    $0x18,%esp
	return ;
  801549:	90                   	nop
}
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <gettst>:
uint32 gettst()
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 00                	push   $0x0
  801559:	6a 2b                	push   $0x2b
  80155b:	e8 c9 fa ff ff       	call   801029 <syscall>
  801560:	83 c4 18             	add    $0x18,%esp
}
  801563:	c9                   	leave  
  801564:	c3                   	ret    

00801565 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801565:	55                   	push   %ebp
  801566:	89 e5                	mov    %esp,%ebp
  801568:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	6a 00                	push   $0x0
  801575:	6a 2c                	push   $0x2c
  801577:	e8 ad fa ff ff       	call   801029 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
  80157f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801582:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801586:	75 07                	jne    80158f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801588:	b8 01 00 00 00       	mov    $0x1,%eax
  80158d:	eb 05                	jmp    801594 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80158f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
  801599:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 2c                	push   $0x2c
  8015a8:	e8 7c fa ff ff       	call   801029 <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
  8015b0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015b3:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015b7:	75 07                	jne    8015c0 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8015be:	eb 05                	jmp    8015c5 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015c0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
  8015ca:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015cd:	6a 00                	push   $0x0
  8015cf:	6a 00                	push   $0x0
  8015d1:	6a 00                	push   $0x0
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 2c                	push   $0x2c
  8015d9:	e8 4b fa ff ff       	call   801029 <syscall>
  8015de:	83 c4 18             	add    $0x18,%esp
  8015e1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015e4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015e8:	75 07                	jne    8015f1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015ea:	b8 01 00 00 00       	mov    $0x1,%eax
  8015ef:	eb 05                	jmp    8015f6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015f1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
  8015fb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	6a 00                	push   $0x0
  801606:	6a 00                	push   $0x0
  801608:	6a 2c                	push   $0x2c
  80160a:	e8 1a fa ff ff       	call   801029 <syscall>
  80160f:	83 c4 18             	add    $0x18,%esp
  801612:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801615:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801619:	75 07                	jne    801622 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80161b:	b8 01 00 00 00       	mov    $0x1,%eax
  801620:	eb 05                	jmp    801627 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801622:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801627:	c9                   	leave  
  801628:	c3                   	ret    

00801629 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801629:	55                   	push   %ebp
  80162a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80162c:	6a 00                	push   $0x0
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	ff 75 08             	pushl  0x8(%ebp)
  801637:	6a 2d                	push   $0x2d
  801639:	e8 eb f9 ff ff       	call   801029 <syscall>
  80163e:	83 c4 18             	add    $0x18,%esp
	return ;
  801641:	90                   	nop
}
  801642:	c9                   	leave  
  801643:	c3                   	ret    

00801644 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801644:	55                   	push   %ebp
  801645:	89 e5                	mov    %esp,%ebp
  801647:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801648:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80164b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80164e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801651:	8b 45 08             	mov    0x8(%ebp),%eax
  801654:	6a 00                	push   $0x0
  801656:	53                   	push   %ebx
  801657:	51                   	push   %ecx
  801658:	52                   	push   %edx
  801659:	50                   	push   %eax
  80165a:	6a 2e                	push   $0x2e
  80165c:	e8 c8 f9 ff ff       	call   801029 <syscall>
  801661:	83 c4 18             	add    $0x18,%esp
}
  801664:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801667:	c9                   	leave  
  801668:	c3                   	ret    

00801669 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801669:	55                   	push   %ebp
  80166a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80166c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80166f:	8b 45 08             	mov    0x8(%ebp),%eax
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	6a 00                	push   $0x0
  801678:	52                   	push   %edx
  801679:	50                   	push   %eax
  80167a:	6a 2f                	push   $0x2f
  80167c:	e8 a8 f9 ff ff       	call   801029 <syscall>
  801681:	83 c4 18             	add    $0x18,%esp
}
  801684:	c9                   	leave  
  801685:	c3                   	ret    

00801686 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801686:	55                   	push   %ebp
  801687:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801689:	6a 00                	push   $0x0
  80168b:	6a 00                	push   $0x0
  80168d:	6a 00                	push   $0x0
  80168f:	ff 75 0c             	pushl  0xc(%ebp)
  801692:	ff 75 08             	pushl  0x8(%ebp)
  801695:	6a 30                	push   $0x30
  801697:	e8 8d f9 ff ff       	call   801029 <syscall>
  80169c:	83 c4 18             	add    $0x18,%esp
	return ;
  80169f:	90                   	nop
}
  8016a0:	c9                   	leave  
  8016a1:	c3                   	ret    
  8016a2:	66 90                	xchg   %ax,%ax

008016a4 <__udivdi3>:
  8016a4:	55                   	push   %ebp
  8016a5:	57                   	push   %edi
  8016a6:	56                   	push   %esi
  8016a7:	53                   	push   %ebx
  8016a8:	83 ec 1c             	sub    $0x1c,%esp
  8016ab:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016af:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016b3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016b7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016bb:	89 ca                	mov    %ecx,%edx
  8016bd:	89 f8                	mov    %edi,%eax
  8016bf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016c3:	85 f6                	test   %esi,%esi
  8016c5:	75 2d                	jne    8016f4 <__udivdi3+0x50>
  8016c7:	39 cf                	cmp    %ecx,%edi
  8016c9:	77 65                	ja     801730 <__udivdi3+0x8c>
  8016cb:	89 fd                	mov    %edi,%ebp
  8016cd:	85 ff                	test   %edi,%edi
  8016cf:	75 0b                	jne    8016dc <__udivdi3+0x38>
  8016d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d6:	31 d2                	xor    %edx,%edx
  8016d8:	f7 f7                	div    %edi
  8016da:	89 c5                	mov    %eax,%ebp
  8016dc:	31 d2                	xor    %edx,%edx
  8016de:	89 c8                	mov    %ecx,%eax
  8016e0:	f7 f5                	div    %ebp
  8016e2:	89 c1                	mov    %eax,%ecx
  8016e4:	89 d8                	mov    %ebx,%eax
  8016e6:	f7 f5                	div    %ebp
  8016e8:	89 cf                	mov    %ecx,%edi
  8016ea:	89 fa                	mov    %edi,%edx
  8016ec:	83 c4 1c             	add    $0x1c,%esp
  8016ef:	5b                   	pop    %ebx
  8016f0:	5e                   	pop    %esi
  8016f1:	5f                   	pop    %edi
  8016f2:	5d                   	pop    %ebp
  8016f3:	c3                   	ret    
  8016f4:	39 ce                	cmp    %ecx,%esi
  8016f6:	77 28                	ja     801720 <__udivdi3+0x7c>
  8016f8:	0f bd fe             	bsr    %esi,%edi
  8016fb:	83 f7 1f             	xor    $0x1f,%edi
  8016fe:	75 40                	jne    801740 <__udivdi3+0x9c>
  801700:	39 ce                	cmp    %ecx,%esi
  801702:	72 0a                	jb     80170e <__udivdi3+0x6a>
  801704:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801708:	0f 87 9e 00 00 00    	ja     8017ac <__udivdi3+0x108>
  80170e:	b8 01 00 00 00       	mov    $0x1,%eax
  801713:	89 fa                	mov    %edi,%edx
  801715:	83 c4 1c             	add    $0x1c,%esp
  801718:	5b                   	pop    %ebx
  801719:	5e                   	pop    %esi
  80171a:	5f                   	pop    %edi
  80171b:	5d                   	pop    %ebp
  80171c:	c3                   	ret    
  80171d:	8d 76 00             	lea    0x0(%esi),%esi
  801720:	31 ff                	xor    %edi,%edi
  801722:	31 c0                	xor    %eax,%eax
  801724:	89 fa                	mov    %edi,%edx
  801726:	83 c4 1c             	add    $0x1c,%esp
  801729:	5b                   	pop    %ebx
  80172a:	5e                   	pop    %esi
  80172b:	5f                   	pop    %edi
  80172c:	5d                   	pop    %ebp
  80172d:	c3                   	ret    
  80172e:	66 90                	xchg   %ax,%ax
  801730:	89 d8                	mov    %ebx,%eax
  801732:	f7 f7                	div    %edi
  801734:	31 ff                	xor    %edi,%edi
  801736:	89 fa                	mov    %edi,%edx
  801738:	83 c4 1c             	add    $0x1c,%esp
  80173b:	5b                   	pop    %ebx
  80173c:	5e                   	pop    %esi
  80173d:	5f                   	pop    %edi
  80173e:	5d                   	pop    %ebp
  80173f:	c3                   	ret    
  801740:	bd 20 00 00 00       	mov    $0x20,%ebp
  801745:	89 eb                	mov    %ebp,%ebx
  801747:	29 fb                	sub    %edi,%ebx
  801749:	89 f9                	mov    %edi,%ecx
  80174b:	d3 e6                	shl    %cl,%esi
  80174d:	89 c5                	mov    %eax,%ebp
  80174f:	88 d9                	mov    %bl,%cl
  801751:	d3 ed                	shr    %cl,%ebp
  801753:	89 e9                	mov    %ebp,%ecx
  801755:	09 f1                	or     %esi,%ecx
  801757:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80175b:	89 f9                	mov    %edi,%ecx
  80175d:	d3 e0                	shl    %cl,%eax
  80175f:	89 c5                	mov    %eax,%ebp
  801761:	89 d6                	mov    %edx,%esi
  801763:	88 d9                	mov    %bl,%cl
  801765:	d3 ee                	shr    %cl,%esi
  801767:	89 f9                	mov    %edi,%ecx
  801769:	d3 e2                	shl    %cl,%edx
  80176b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80176f:	88 d9                	mov    %bl,%cl
  801771:	d3 e8                	shr    %cl,%eax
  801773:	09 c2                	or     %eax,%edx
  801775:	89 d0                	mov    %edx,%eax
  801777:	89 f2                	mov    %esi,%edx
  801779:	f7 74 24 0c          	divl   0xc(%esp)
  80177d:	89 d6                	mov    %edx,%esi
  80177f:	89 c3                	mov    %eax,%ebx
  801781:	f7 e5                	mul    %ebp
  801783:	39 d6                	cmp    %edx,%esi
  801785:	72 19                	jb     8017a0 <__udivdi3+0xfc>
  801787:	74 0b                	je     801794 <__udivdi3+0xf0>
  801789:	89 d8                	mov    %ebx,%eax
  80178b:	31 ff                	xor    %edi,%edi
  80178d:	e9 58 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  801792:	66 90                	xchg   %ax,%ax
  801794:	8b 54 24 08          	mov    0x8(%esp),%edx
  801798:	89 f9                	mov    %edi,%ecx
  80179a:	d3 e2                	shl    %cl,%edx
  80179c:	39 c2                	cmp    %eax,%edx
  80179e:	73 e9                	jae    801789 <__udivdi3+0xe5>
  8017a0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017a3:	31 ff                	xor    %edi,%edi
  8017a5:	e9 40 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  8017aa:	66 90                	xchg   %ax,%ax
  8017ac:	31 c0                	xor    %eax,%eax
  8017ae:	e9 37 ff ff ff       	jmp    8016ea <__udivdi3+0x46>
  8017b3:	90                   	nop

008017b4 <__umoddi3>:
  8017b4:	55                   	push   %ebp
  8017b5:	57                   	push   %edi
  8017b6:	56                   	push   %esi
  8017b7:	53                   	push   %ebx
  8017b8:	83 ec 1c             	sub    $0x1c,%esp
  8017bb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017bf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017c7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017cb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017cf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017d3:	89 f3                	mov    %esi,%ebx
  8017d5:	89 fa                	mov    %edi,%edx
  8017d7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017db:	89 34 24             	mov    %esi,(%esp)
  8017de:	85 c0                	test   %eax,%eax
  8017e0:	75 1a                	jne    8017fc <__umoddi3+0x48>
  8017e2:	39 f7                	cmp    %esi,%edi
  8017e4:	0f 86 a2 00 00 00    	jbe    80188c <__umoddi3+0xd8>
  8017ea:	89 c8                	mov    %ecx,%eax
  8017ec:	89 f2                	mov    %esi,%edx
  8017ee:	f7 f7                	div    %edi
  8017f0:	89 d0                	mov    %edx,%eax
  8017f2:	31 d2                	xor    %edx,%edx
  8017f4:	83 c4 1c             	add    $0x1c,%esp
  8017f7:	5b                   	pop    %ebx
  8017f8:	5e                   	pop    %esi
  8017f9:	5f                   	pop    %edi
  8017fa:	5d                   	pop    %ebp
  8017fb:	c3                   	ret    
  8017fc:	39 f0                	cmp    %esi,%eax
  8017fe:	0f 87 ac 00 00 00    	ja     8018b0 <__umoddi3+0xfc>
  801804:	0f bd e8             	bsr    %eax,%ebp
  801807:	83 f5 1f             	xor    $0x1f,%ebp
  80180a:	0f 84 ac 00 00 00    	je     8018bc <__umoddi3+0x108>
  801810:	bf 20 00 00 00       	mov    $0x20,%edi
  801815:	29 ef                	sub    %ebp,%edi
  801817:	89 fe                	mov    %edi,%esi
  801819:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80181d:	89 e9                	mov    %ebp,%ecx
  80181f:	d3 e0                	shl    %cl,%eax
  801821:	89 d7                	mov    %edx,%edi
  801823:	89 f1                	mov    %esi,%ecx
  801825:	d3 ef                	shr    %cl,%edi
  801827:	09 c7                	or     %eax,%edi
  801829:	89 e9                	mov    %ebp,%ecx
  80182b:	d3 e2                	shl    %cl,%edx
  80182d:	89 14 24             	mov    %edx,(%esp)
  801830:	89 d8                	mov    %ebx,%eax
  801832:	d3 e0                	shl    %cl,%eax
  801834:	89 c2                	mov    %eax,%edx
  801836:	8b 44 24 08          	mov    0x8(%esp),%eax
  80183a:	d3 e0                	shl    %cl,%eax
  80183c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801840:	8b 44 24 08          	mov    0x8(%esp),%eax
  801844:	89 f1                	mov    %esi,%ecx
  801846:	d3 e8                	shr    %cl,%eax
  801848:	09 d0                	or     %edx,%eax
  80184a:	d3 eb                	shr    %cl,%ebx
  80184c:	89 da                	mov    %ebx,%edx
  80184e:	f7 f7                	div    %edi
  801850:	89 d3                	mov    %edx,%ebx
  801852:	f7 24 24             	mull   (%esp)
  801855:	89 c6                	mov    %eax,%esi
  801857:	89 d1                	mov    %edx,%ecx
  801859:	39 d3                	cmp    %edx,%ebx
  80185b:	0f 82 87 00 00 00    	jb     8018e8 <__umoddi3+0x134>
  801861:	0f 84 91 00 00 00    	je     8018f8 <__umoddi3+0x144>
  801867:	8b 54 24 04          	mov    0x4(%esp),%edx
  80186b:	29 f2                	sub    %esi,%edx
  80186d:	19 cb                	sbb    %ecx,%ebx
  80186f:	89 d8                	mov    %ebx,%eax
  801871:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801875:	d3 e0                	shl    %cl,%eax
  801877:	89 e9                	mov    %ebp,%ecx
  801879:	d3 ea                	shr    %cl,%edx
  80187b:	09 d0                	or     %edx,%eax
  80187d:	89 e9                	mov    %ebp,%ecx
  80187f:	d3 eb                	shr    %cl,%ebx
  801881:	89 da                	mov    %ebx,%edx
  801883:	83 c4 1c             	add    $0x1c,%esp
  801886:	5b                   	pop    %ebx
  801887:	5e                   	pop    %esi
  801888:	5f                   	pop    %edi
  801889:	5d                   	pop    %ebp
  80188a:	c3                   	ret    
  80188b:	90                   	nop
  80188c:	89 fd                	mov    %edi,%ebp
  80188e:	85 ff                	test   %edi,%edi
  801890:	75 0b                	jne    80189d <__umoddi3+0xe9>
  801892:	b8 01 00 00 00       	mov    $0x1,%eax
  801897:	31 d2                	xor    %edx,%edx
  801899:	f7 f7                	div    %edi
  80189b:	89 c5                	mov    %eax,%ebp
  80189d:	89 f0                	mov    %esi,%eax
  80189f:	31 d2                	xor    %edx,%edx
  8018a1:	f7 f5                	div    %ebp
  8018a3:	89 c8                	mov    %ecx,%eax
  8018a5:	f7 f5                	div    %ebp
  8018a7:	89 d0                	mov    %edx,%eax
  8018a9:	e9 44 ff ff ff       	jmp    8017f2 <__umoddi3+0x3e>
  8018ae:	66 90                	xchg   %ax,%ax
  8018b0:	89 c8                	mov    %ecx,%eax
  8018b2:	89 f2                	mov    %esi,%edx
  8018b4:	83 c4 1c             	add    $0x1c,%esp
  8018b7:	5b                   	pop    %ebx
  8018b8:	5e                   	pop    %esi
  8018b9:	5f                   	pop    %edi
  8018ba:	5d                   	pop    %ebp
  8018bb:	c3                   	ret    
  8018bc:	3b 04 24             	cmp    (%esp),%eax
  8018bf:	72 06                	jb     8018c7 <__umoddi3+0x113>
  8018c1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018c5:	77 0f                	ja     8018d6 <__umoddi3+0x122>
  8018c7:	89 f2                	mov    %esi,%edx
  8018c9:	29 f9                	sub    %edi,%ecx
  8018cb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018cf:	89 14 24             	mov    %edx,(%esp)
  8018d2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018d6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018da:	8b 14 24             	mov    (%esp),%edx
  8018dd:	83 c4 1c             	add    $0x1c,%esp
  8018e0:	5b                   	pop    %ebx
  8018e1:	5e                   	pop    %esi
  8018e2:	5f                   	pop    %edi
  8018e3:	5d                   	pop    %ebp
  8018e4:	c3                   	ret    
  8018e5:	8d 76 00             	lea    0x0(%esi),%esi
  8018e8:	2b 04 24             	sub    (%esp),%eax
  8018eb:	19 fa                	sbb    %edi,%edx
  8018ed:	89 d1                	mov    %edx,%ecx
  8018ef:	89 c6                	mov    %eax,%esi
  8018f1:	e9 71 ff ff ff       	jmp    801867 <__umoddi3+0xb3>
  8018f6:	66 90                	xchg   %ax,%ax
  8018f8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018fc:	72 ea                	jb     8018e8 <__umoddi3+0x134>
  8018fe:	89 d9                	mov    %ebx,%ecx
  801900:	e9 62 ff ff ff       	jmp    801867 <__umoddi3+0xb3>
