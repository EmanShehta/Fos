
obj/user/fos_add:     file format elf32-i386


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
  800031:	e8 60 00 00 00       	call   800096 <libmain>
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
  80003b:	83 ec 18             	sub    $0x18,%esp
	int i1=0;
  80003e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800045:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	i1 = strtol("1", NULL, 10);
  80004c:	83 ec 04             	sub    $0x4,%esp
  80004f:	6a 0a                	push   $0xa
  800051:	6a 00                	push   $0x0
  800053:	68 00 19 80 00       	push   $0x801900
  800058:	e8 0b 0c 00 00       	call   800c68 <strtol>
  80005d:	83 c4 10             	add    $0x10,%esp
  800060:	89 45 f4             	mov    %eax,-0xc(%ebp)
	i2 = strtol("2", NULL, 10);
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	6a 0a                	push   $0xa
  800068:	6a 00                	push   $0x0
  80006a:	68 02 19 80 00       	push   $0x801902
  80006f:	e8 f4 0b 00 00       	call   800c68 <strtol>
  800074:	83 c4 10             	add    $0x10,%esp
  800077:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  80007a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80007d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800080:	01 d0                	add    %edx,%eax
  800082:	83 ec 08             	sub    $0x8,%esp
  800085:	50                   	push   %eax
  800086:	68 04 19 80 00       	push   $0x801904
  80008b:	e8 23 02 00 00       	call   8002b3 <atomic_cprintf>
  800090:	83 c4 10             	add    $0x10,%esp
	//cprintf("number 1 + number 2 = \n");
	return;
  800093:	90                   	nop
}
  800094:	c9                   	leave  
  800095:	c3                   	ret    

00800096 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800096:	55                   	push   %ebp
  800097:	89 e5                	mov    %esp,%ebp
  800099:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80009c:	e8 10 10 00 00       	call   8010b1 <sys_getenvindex>
  8000a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a7:	89 d0                	mov    %edx,%eax
  8000a9:	01 c0                	add    %eax,%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	c1 e0 04             	shl    $0x4,%eax
  8000b0:	29 d0                	sub    %edx,%eax
  8000b2:	c1 e0 03             	shl    $0x3,%eax
  8000b5:	01 d0                	add    %edx,%eax
  8000b7:	c1 e0 02             	shl    $0x2,%eax
  8000ba:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000bf:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000c4:	a1 20 20 80 00       	mov    0x802020,%eax
  8000c9:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8000cf:	84 c0                	test   %al,%al
  8000d1:	74 0f                	je     8000e2 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8000d3:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d8:	05 5c 05 00 00       	add    $0x55c,%eax
  8000dd:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000e2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000e6:	7e 0a                	jle    8000f2 <libmain+0x5c>
		binaryname = argv[0];
  8000e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  8000f2:	83 ec 08             	sub    $0x8,%esp
  8000f5:	ff 75 0c             	pushl  0xc(%ebp)
  8000f8:	ff 75 08             	pushl  0x8(%ebp)
  8000fb:	e8 38 ff ff ff       	call   800038 <_main>
  800100:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800103:	e8 44 11 00 00       	call   80124c <sys_disable_interrupt>
	cprintf("**************************************\n");
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	68 38 19 80 00       	push   $0x801938
  800110:	e8 71 01 00 00       	call   800286 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800118:	a1 20 20 80 00       	mov    0x802020,%eax
  80011d:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800123:	a1 20 20 80 00       	mov    0x802020,%eax
  800128:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80012e:	83 ec 04             	sub    $0x4,%esp
  800131:	52                   	push   %edx
  800132:	50                   	push   %eax
  800133:	68 60 19 80 00       	push   $0x801960
  800138:	e8 49 01 00 00       	call   800286 <cprintf>
  80013d:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800140:	a1 20 20 80 00       	mov    0x802020,%eax
  800145:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80014b:	a1 20 20 80 00       	mov    0x802020,%eax
  800150:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800156:	a1 20 20 80 00       	mov    0x802020,%eax
  80015b:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800161:	51                   	push   %ecx
  800162:	52                   	push   %edx
  800163:	50                   	push   %eax
  800164:	68 88 19 80 00       	push   $0x801988
  800169:	e8 18 01 00 00       	call   800286 <cprintf>
  80016e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800171:	83 ec 0c             	sub    $0xc,%esp
  800174:	68 38 19 80 00       	push   $0x801938
  800179:	e8 08 01 00 00       	call   800286 <cprintf>
  80017e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800181:	e8 e0 10 00 00       	call   801266 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800186:	e8 19 00 00 00       	call   8001a4 <exit>
}
  80018b:	90                   	nop
  80018c:	c9                   	leave  
  80018d:	c3                   	ret    

0080018e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80018e:	55                   	push   %ebp
  80018f:	89 e5                	mov    %esp,%ebp
  800191:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800194:	83 ec 0c             	sub    $0xc,%esp
  800197:	6a 00                	push   $0x0
  800199:	e8 df 0e 00 00       	call   80107d <sys_env_destroy>
  80019e:	83 c4 10             	add    $0x10,%esp
}
  8001a1:	90                   	nop
  8001a2:	c9                   	leave  
  8001a3:	c3                   	ret    

008001a4 <exit>:

void
exit(void)
{
  8001a4:	55                   	push   %ebp
  8001a5:	89 e5                	mov    %esp,%ebp
  8001a7:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001aa:	e8 34 0f 00 00       	call   8010e3 <sys_env_exit>
}
  8001af:	90                   	nop
  8001b0:	c9                   	leave  
  8001b1:	c3                   	ret    

008001b2 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001b2:	55                   	push   %ebp
  8001b3:	89 e5                	mov    %esp,%ebp
  8001b5:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001bb:	8b 00                	mov    (%eax),%eax
  8001bd:	8d 48 01             	lea    0x1(%eax),%ecx
  8001c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001c3:	89 0a                	mov    %ecx,(%edx)
  8001c5:	8b 55 08             	mov    0x8(%ebp),%edx
  8001c8:	88 d1                	mov    %dl,%cl
  8001ca:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001cd:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001d4:	8b 00                	mov    (%eax),%eax
  8001d6:	3d ff 00 00 00       	cmp    $0xff,%eax
  8001db:	75 2c                	jne    800209 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8001dd:	a0 24 20 80 00       	mov    0x802024,%al
  8001e2:	0f b6 c0             	movzbl %al,%eax
  8001e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001e8:	8b 12                	mov    (%edx),%edx
  8001ea:	89 d1                	mov    %edx,%ecx
  8001ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ef:	83 c2 08             	add    $0x8,%edx
  8001f2:	83 ec 04             	sub    $0x4,%esp
  8001f5:	50                   	push   %eax
  8001f6:	51                   	push   %ecx
  8001f7:	52                   	push   %edx
  8001f8:	e8 3e 0e 00 00       	call   80103b <sys_cputs>
  8001fd:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800200:	8b 45 0c             	mov    0xc(%ebp),%eax
  800203:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800209:	8b 45 0c             	mov    0xc(%ebp),%eax
  80020c:	8b 40 04             	mov    0x4(%eax),%eax
  80020f:	8d 50 01             	lea    0x1(%eax),%edx
  800212:	8b 45 0c             	mov    0xc(%ebp),%eax
  800215:	89 50 04             	mov    %edx,0x4(%eax)
}
  800218:	90                   	nop
  800219:	c9                   	leave  
  80021a:	c3                   	ret    

0080021b <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80021b:	55                   	push   %ebp
  80021c:	89 e5                	mov    %esp,%ebp
  80021e:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800224:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80022b:	00 00 00 
	b.cnt = 0;
  80022e:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800235:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800238:	ff 75 0c             	pushl  0xc(%ebp)
  80023b:	ff 75 08             	pushl  0x8(%ebp)
  80023e:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800244:	50                   	push   %eax
  800245:	68 b2 01 80 00       	push   $0x8001b2
  80024a:	e8 11 02 00 00       	call   800460 <vprintfmt>
  80024f:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800252:	a0 24 20 80 00       	mov    0x802024,%al
  800257:	0f b6 c0             	movzbl %al,%eax
  80025a:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800260:	83 ec 04             	sub    $0x4,%esp
  800263:	50                   	push   %eax
  800264:	52                   	push   %edx
  800265:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80026b:	83 c0 08             	add    $0x8,%eax
  80026e:	50                   	push   %eax
  80026f:	e8 c7 0d 00 00       	call   80103b <sys_cputs>
  800274:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800277:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  80027e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800284:	c9                   	leave  
  800285:	c3                   	ret    

00800286 <cprintf>:

int cprintf(const char *fmt, ...) {
  800286:	55                   	push   %ebp
  800287:	89 e5                	mov    %esp,%ebp
  800289:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80028c:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  800293:	8d 45 0c             	lea    0xc(%ebp),%eax
  800296:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800299:	8b 45 08             	mov    0x8(%ebp),%eax
  80029c:	83 ec 08             	sub    $0x8,%esp
  80029f:	ff 75 f4             	pushl  -0xc(%ebp)
  8002a2:	50                   	push   %eax
  8002a3:	e8 73 ff ff ff       	call   80021b <vcprintf>
  8002a8:	83 c4 10             	add    $0x10,%esp
  8002ab:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002b1:	c9                   	leave  
  8002b2:	c3                   	ret    

008002b3 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002b3:	55                   	push   %ebp
  8002b4:	89 e5                	mov    %esp,%ebp
  8002b6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002b9:	e8 8e 0f 00 00       	call   80124c <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002be:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c7:	83 ec 08             	sub    $0x8,%esp
  8002ca:	ff 75 f4             	pushl  -0xc(%ebp)
  8002cd:	50                   	push   %eax
  8002ce:	e8 48 ff ff ff       	call   80021b <vcprintf>
  8002d3:	83 c4 10             	add    $0x10,%esp
  8002d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8002d9:	e8 88 0f 00 00       	call   801266 <sys_enable_interrupt>
	return cnt;
  8002de:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002e1:	c9                   	leave  
  8002e2:	c3                   	ret    

008002e3 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8002e3:	55                   	push   %ebp
  8002e4:	89 e5                	mov    %esp,%ebp
  8002e6:	53                   	push   %ebx
  8002e7:	83 ec 14             	sub    $0x14,%esp
  8002ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8002ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8002f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8002f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8002f6:	8b 45 18             	mov    0x18(%ebp),%eax
  8002f9:	ba 00 00 00 00       	mov    $0x0,%edx
  8002fe:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800301:	77 55                	ja     800358 <printnum+0x75>
  800303:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800306:	72 05                	jb     80030d <printnum+0x2a>
  800308:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80030b:	77 4b                	ja     800358 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80030d:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800310:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800313:	8b 45 18             	mov    0x18(%ebp),%eax
  800316:	ba 00 00 00 00       	mov    $0x0,%edx
  80031b:	52                   	push   %edx
  80031c:	50                   	push   %eax
  80031d:	ff 75 f4             	pushl  -0xc(%ebp)
  800320:	ff 75 f0             	pushl  -0x10(%ebp)
  800323:	e8 64 13 00 00       	call   80168c <__udivdi3>
  800328:	83 c4 10             	add    $0x10,%esp
  80032b:	83 ec 04             	sub    $0x4,%esp
  80032e:	ff 75 20             	pushl  0x20(%ebp)
  800331:	53                   	push   %ebx
  800332:	ff 75 18             	pushl  0x18(%ebp)
  800335:	52                   	push   %edx
  800336:	50                   	push   %eax
  800337:	ff 75 0c             	pushl  0xc(%ebp)
  80033a:	ff 75 08             	pushl  0x8(%ebp)
  80033d:	e8 a1 ff ff ff       	call   8002e3 <printnum>
  800342:	83 c4 20             	add    $0x20,%esp
  800345:	eb 1a                	jmp    800361 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800347:	83 ec 08             	sub    $0x8,%esp
  80034a:	ff 75 0c             	pushl  0xc(%ebp)
  80034d:	ff 75 20             	pushl  0x20(%ebp)
  800350:	8b 45 08             	mov    0x8(%ebp),%eax
  800353:	ff d0                	call   *%eax
  800355:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800358:	ff 4d 1c             	decl   0x1c(%ebp)
  80035b:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80035f:	7f e6                	jg     800347 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800361:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800364:	bb 00 00 00 00       	mov    $0x0,%ebx
  800369:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80036c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80036f:	53                   	push   %ebx
  800370:	51                   	push   %ecx
  800371:	52                   	push   %edx
  800372:	50                   	push   %eax
  800373:	e8 24 14 00 00       	call   80179c <__umoddi3>
  800378:	83 c4 10             	add    $0x10,%esp
  80037b:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  800380:	8a 00                	mov    (%eax),%al
  800382:	0f be c0             	movsbl %al,%eax
  800385:	83 ec 08             	sub    $0x8,%esp
  800388:	ff 75 0c             	pushl  0xc(%ebp)
  80038b:	50                   	push   %eax
  80038c:	8b 45 08             	mov    0x8(%ebp),%eax
  80038f:	ff d0                	call   *%eax
  800391:	83 c4 10             	add    $0x10,%esp
}
  800394:	90                   	nop
  800395:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800398:	c9                   	leave  
  800399:	c3                   	ret    

0080039a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80039a:	55                   	push   %ebp
  80039b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80039d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003a1:	7e 1c                	jle    8003bf <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	8d 50 08             	lea    0x8(%eax),%edx
  8003ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ae:	89 10                	mov    %edx,(%eax)
  8003b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b3:	8b 00                	mov    (%eax),%eax
  8003b5:	83 e8 08             	sub    $0x8,%eax
  8003b8:	8b 50 04             	mov    0x4(%eax),%edx
  8003bb:	8b 00                	mov    (%eax),%eax
  8003bd:	eb 40                	jmp    8003ff <getuint+0x65>
	else if (lflag)
  8003bf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003c3:	74 1e                	je     8003e3 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c8:	8b 00                	mov    (%eax),%eax
  8003ca:	8d 50 04             	lea    0x4(%eax),%edx
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	89 10                	mov    %edx,(%eax)
  8003d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d5:	8b 00                	mov    (%eax),%eax
  8003d7:	83 e8 04             	sub    $0x4,%eax
  8003da:	8b 00                	mov    (%eax),%eax
  8003dc:	ba 00 00 00 00       	mov    $0x0,%edx
  8003e1:	eb 1c                	jmp    8003ff <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	8b 00                	mov    (%eax),%eax
  8003e8:	8d 50 04             	lea    0x4(%eax),%edx
  8003eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ee:	89 10                	mov    %edx,(%eax)
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	8b 00                	mov    (%eax),%eax
  8003f5:	83 e8 04             	sub    $0x4,%eax
  8003f8:	8b 00                	mov    (%eax),%eax
  8003fa:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8003ff:	5d                   	pop    %ebp
  800400:	c3                   	ret    

00800401 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800401:	55                   	push   %ebp
  800402:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800404:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800408:	7e 1c                	jle    800426 <getint+0x25>
		return va_arg(*ap, long long);
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	8d 50 08             	lea    0x8(%eax),%edx
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	89 10                	mov    %edx,(%eax)
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	83 e8 08             	sub    $0x8,%eax
  80041f:	8b 50 04             	mov    0x4(%eax),%edx
  800422:	8b 00                	mov    (%eax),%eax
  800424:	eb 38                	jmp    80045e <getint+0x5d>
	else if (lflag)
  800426:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80042a:	74 1a                	je     800446 <getint+0x45>
		return va_arg(*ap, long);
  80042c:	8b 45 08             	mov    0x8(%ebp),%eax
  80042f:	8b 00                	mov    (%eax),%eax
  800431:	8d 50 04             	lea    0x4(%eax),%edx
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	89 10                	mov    %edx,(%eax)
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 00                	mov    (%eax),%eax
  80043e:	83 e8 04             	sub    $0x4,%eax
  800441:	8b 00                	mov    (%eax),%eax
  800443:	99                   	cltd   
  800444:	eb 18                	jmp    80045e <getint+0x5d>
	else
		return va_arg(*ap, int);
  800446:	8b 45 08             	mov    0x8(%ebp),%eax
  800449:	8b 00                	mov    (%eax),%eax
  80044b:	8d 50 04             	lea    0x4(%eax),%edx
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	89 10                	mov    %edx,(%eax)
  800453:	8b 45 08             	mov    0x8(%ebp),%eax
  800456:	8b 00                	mov    (%eax),%eax
  800458:	83 e8 04             	sub    $0x4,%eax
  80045b:	8b 00                	mov    (%eax),%eax
  80045d:	99                   	cltd   
}
  80045e:	5d                   	pop    %ebp
  80045f:	c3                   	ret    

00800460 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800460:	55                   	push   %ebp
  800461:	89 e5                	mov    %esp,%ebp
  800463:	56                   	push   %esi
  800464:	53                   	push   %ebx
  800465:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800468:	eb 17                	jmp    800481 <vprintfmt+0x21>
			if (ch == '\0')
  80046a:	85 db                	test   %ebx,%ebx
  80046c:	0f 84 af 03 00 00    	je     800821 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	ff 75 0c             	pushl  0xc(%ebp)
  800478:	53                   	push   %ebx
  800479:	8b 45 08             	mov    0x8(%ebp),%eax
  80047c:	ff d0                	call   *%eax
  80047e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800481:	8b 45 10             	mov    0x10(%ebp),%eax
  800484:	8d 50 01             	lea    0x1(%eax),%edx
  800487:	89 55 10             	mov    %edx,0x10(%ebp)
  80048a:	8a 00                	mov    (%eax),%al
  80048c:	0f b6 d8             	movzbl %al,%ebx
  80048f:	83 fb 25             	cmp    $0x25,%ebx
  800492:	75 d6                	jne    80046a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800494:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800498:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80049f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004a6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004ad:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b7:	8d 50 01             	lea    0x1(%eax),%edx
  8004ba:	89 55 10             	mov    %edx,0x10(%ebp)
  8004bd:	8a 00                	mov    (%eax),%al
  8004bf:	0f b6 d8             	movzbl %al,%ebx
  8004c2:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004c5:	83 f8 55             	cmp    $0x55,%eax
  8004c8:	0f 87 2b 03 00 00    	ja     8007f9 <vprintfmt+0x399>
  8004ce:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  8004d5:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8004d7:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8004db:	eb d7                	jmp    8004b4 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8004dd:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8004e1:	eb d1                	jmp    8004b4 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8004e3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8004ea:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004ed:	89 d0                	mov    %edx,%eax
  8004ef:	c1 e0 02             	shl    $0x2,%eax
  8004f2:	01 d0                	add    %edx,%eax
  8004f4:	01 c0                	add    %eax,%eax
  8004f6:	01 d8                	add    %ebx,%eax
  8004f8:	83 e8 30             	sub    $0x30,%eax
  8004fb:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8004fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800501:	8a 00                	mov    (%eax),%al
  800503:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800506:	83 fb 2f             	cmp    $0x2f,%ebx
  800509:	7e 3e                	jle    800549 <vprintfmt+0xe9>
  80050b:	83 fb 39             	cmp    $0x39,%ebx
  80050e:	7f 39                	jg     800549 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800510:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800513:	eb d5                	jmp    8004ea <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800515:	8b 45 14             	mov    0x14(%ebp),%eax
  800518:	83 c0 04             	add    $0x4,%eax
  80051b:	89 45 14             	mov    %eax,0x14(%ebp)
  80051e:	8b 45 14             	mov    0x14(%ebp),%eax
  800521:	83 e8 04             	sub    $0x4,%eax
  800524:	8b 00                	mov    (%eax),%eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800529:	eb 1f                	jmp    80054a <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80052b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80052f:	79 83                	jns    8004b4 <vprintfmt+0x54>
				width = 0;
  800531:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800538:	e9 77 ff ff ff       	jmp    8004b4 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80053d:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800544:	e9 6b ff ff ff       	jmp    8004b4 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800549:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80054a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80054e:	0f 89 60 ff ff ff    	jns    8004b4 <vprintfmt+0x54>
				width = precision, precision = -1;
  800554:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800557:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80055a:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800561:	e9 4e ff ff ff       	jmp    8004b4 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800566:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800569:	e9 46 ff ff ff       	jmp    8004b4 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80056e:	8b 45 14             	mov    0x14(%ebp),%eax
  800571:	83 c0 04             	add    $0x4,%eax
  800574:	89 45 14             	mov    %eax,0x14(%ebp)
  800577:	8b 45 14             	mov    0x14(%ebp),%eax
  80057a:	83 e8 04             	sub    $0x4,%eax
  80057d:	8b 00                	mov    (%eax),%eax
  80057f:	83 ec 08             	sub    $0x8,%esp
  800582:	ff 75 0c             	pushl  0xc(%ebp)
  800585:	50                   	push   %eax
  800586:	8b 45 08             	mov    0x8(%ebp),%eax
  800589:	ff d0                	call   *%eax
  80058b:	83 c4 10             	add    $0x10,%esp
			break;
  80058e:	e9 89 02 00 00       	jmp    80081c <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800593:	8b 45 14             	mov    0x14(%ebp),%eax
  800596:	83 c0 04             	add    $0x4,%eax
  800599:	89 45 14             	mov    %eax,0x14(%ebp)
  80059c:	8b 45 14             	mov    0x14(%ebp),%eax
  80059f:	83 e8 04             	sub    $0x4,%eax
  8005a2:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005a4:	85 db                	test   %ebx,%ebx
  8005a6:	79 02                	jns    8005aa <vprintfmt+0x14a>
				err = -err;
  8005a8:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005aa:	83 fb 64             	cmp    $0x64,%ebx
  8005ad:	7f 0b                	jg     8005ba <vprintfmt+0x15a>
  8005af:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  8005b6:	85 f6                	test   %esi,%esi
  8005b8:	75 19                	jne    8005d3 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005ba:	53                   	push   %ebx
  8005bb:	68 05 1c 80 00       	push   $0x801c05
  8005c0:	ff 75 0c             	pushl  0xc(%ebp)
  8005c3:	ff 75 08             	pushl  0x8(%ebp)
  8005c6:	e8 5e 02 00 00       	call   800829 <printfmt>
  8005cb:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005ce:	e9 49 02 00 00       	jmp    80081c <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005d3:	56                   	push   %esi
  8005d4:	68 0e 1c 80 00       	push   $0x801c0e
  8005d9:	ff 75 0c             	pushl  0xc(%ebp)
  8005dc:	ff 75 08             	pushl  0x8(%ebp)
  8005df:	e8 45 02 00 00       	call   800829 <printfmt>
  8005e4:	83 c4 10             	add    $0x10,%esp
			break;
  8005e7:	e9 30 02 00 00       	jmp    80081c <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8005ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ef:	83 c0 04             	add    $0x4,%eax
  8005f2:	89 45 14             	mov    %eax,0x14(%ebp)
  8005f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8005f8:	83 e8 04             	sub    $0x4,%eax
  8005fb:	8b 30                	mov    (%eax),%esi
  8005fd:	85 f6                	test   %esi,%esi
  8005ff:	75 05                	jne    800606 <vprintfmt+0x1a6>
				p = "(null)";
  800601:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  800606:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80060a:	7e 6d                	jle    800679 <vprintfmt+0x219>
  80060c:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800610:	74 67                	je     800679 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800612:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800615:	83 ec 08             	sub    $0x8,%esp
  800618:	50                   	push   %eax
  800619:	56                   	push   %esi
  80061a:	e8 0c 03 00 00       	call   80092b <strnlen>
  80061f:	83 c4 10             	add    $0x10,%esp
  800622:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800625:	eb 16                	jmp    80063d <vprintfmt+0x1dd>
					putch(padc, putdat);
  800627:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80062b:	83 ec 08             	sub    $0x8,%esp
  80062e:	ff 75 0c             	pushl  0xc(%ebp)
  800631:	50                   	push   %eax
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	ff d0                	call   *%eax
  800637:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80063a:	ff 4d e4             	decl   -0x1c(%ebp)
  80063d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800641:	7f e4                	jg     800627 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800643:	eb 34                	jmp    800679 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800645:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800649:	74 1c                	je     800667 <vprintfmt+0x207>
  80064b:	83 fb 1f             	cmp    $0x1f,%ebx
  80064e:	7e 05                	jle    800655 <vprintfmt+0x1f5>
  800650:	83 fb 7e             	cmp    $0x7e,%ebx
  800653:	7e 12                	jle    800667 <vprintfmt+0x207>
					putch('?', putdat);
  800655:	83 ec 08             	sub    $0x8,%esp
  800658:	ff 75 0c             	pushl  0xc(%ebp)
  80065b:	6a 3f                	push   $0x3f
  80065d:	8b 45 08             	mov    0x8(%ebp),%eax
  800660:	ff d0                	call   *%eax
  800662:	83 c4 10             	add    $0x10,%esp
  800665:	eb 0f                	jmp    800676 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800667:	83 ec 08             	sub    $0x8,%esp
  80066a:	ff 75 0c             	pushl  0xc(%ebp)
  80066d:	53                   	push   %ebx
  80066e:	8b 45 08             	mov    0x8(%ebp),%eax
  800671:	ff d0                	call   *%eax
  800673:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800676:	ff 4d e4             	decl   -0x1c(%ebp)
  800679:	89 f0                	mov    %esi,%eax
  80067b:	8d 70 01             	lea    0x1(%eax),%esi
  80067e:	8a 00                	mov    (%eax),%al
  800680:	0f be d8             	movsbl %al,%ebx
  800683:	85 db                	test   %ebx,%ebx
  800685:	74 24                	je     8006ab <vprintfmt+0x24b>
  800687:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80068b:	78 b8                	js     800645 <vprintfmt+0x1e5>
  80068d:	ff 4d e0             	decl   -0x20(%ebp)
  800690:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800694:	79 af                	jns    800645 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800696:	eb 13                	jmp    8006ab <vprintfmt+0x24b>
				putch(' ', putdat);
  800698:	83 ec 08             	sub    $0x8,%esp
  80069b:	ff 75 0c             	pushl  0xc(%ebp)
  80069e:	6a 20                	push   $0x20
  8006a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a3:	ff d0                	call   *%eax
  8006a5:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006a8:	ff 4d e4             	decl   -0x1c(%ebp)
  8006ab:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006af:	7f e7                	jg     800698 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006b1:	e9 66 01 00 00       	jmp    80081c <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006b6:	83 ec 08             	sub    $0x8,%esp
  8006b9:	ff 75 e8             	pushl  -0x18(%ebp)
  8006bc:	8d 45 14             	lea    0x14(%ebp),%eax
  8006bf:	50                   	push   %eax
  8006c0:	e8 3c fd ff ff       	call   800401 <getint>
  8006c5:	83 c4 10             	add    $0x10,%esp
  8006c8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006ce:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006d4:	85 d2                	test   %edx,%edx
  8006d6:	79 23                	jns    8006fb <vprintfmt+0x29b>
				putch('-', putdat);
  8006d8:	83 ec 08             	sub    $0x8,%esp
  8006db:	ff 75 0c             	pushl  0xc(%ebp)
  8006de:	6a 2d                	push   $0x2d
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	ff d0                	call   *%eax
  8006e5:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8006e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006eb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006ee:	f7 d8                	neg    %eax
  8006f0:	83 d2 00             	adc    $0x0,%edx
  8006f3:	f7 da                	neg    %edx
  8006f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8006fb:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800702:	e9 bc 00 00 00       	jmp    8007c3 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800707:	83 ec 08             	sub    $0x8,%esp
  80070a:	ff 75 e8             	pushl  -0x18(%ebp)
  80070d:	8d 45 14             	lea    0x14(%ebp),%eax
  800710:	50                   	push   %eax
  800711:	e8 84 fc ff ff       	call   80039a <getuint>
  800716:	83 c4 10             	add    $0x10,%esp
  800719:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80071c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80071f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800726:	e9 98 00 00 00       	jmp    8007c3 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80072b:	83 ec 08             	sub    $0x8,%esp
  80072e:	ff 75 0c             	pushl  0xc(%ebp)
  800731:	6a 58                	push   $0x58
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	ff d0                	call   *%eax
  800738:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80073b:	83 ec 08             	sub    $0x8,%esp
  80073e:	ff 75 0c             	pushl  0xc(%ebp)
  800741:	6a 58                	push   $0x58
  800743:	8b 45 08             	mov    0x8(%ebp),%eax
  800746:	ff d0                	call   *%eax
  800748:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80074b:	83 ec 08             	sub    $0x8,%esp
  80074e:	ff 75 0c             	pushl  0xc(%ebp)
  800751:	6a 58                	push   $0x58
  800753:	8b 45 08             	mov    0x8(%ebp),%eax
  800756:	ff d0                	call   *%eax
  800758:	83 c4 10             	add    $0x10,%esp
			break;
  80075b:	e9 bc 00 00 00       	jmp    80081c <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800760:	83 ec 08             	sub    $0x8,%esp
  800763:	ff 75 0c             	pushl  0xc(%ebp)
  800766:	6a 30                	push   $0x30
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	ff d0                	call   *%eax
  80076d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800770:	83 ec 08             	sub    $0x8,%esp
  800773:	ff 75 0c             	pushl  0xc(%ebp)
  800776:	6a 78                	push   $0x78
  800778:	8b 45 08             	mov    0x8(%ebp),%eax
  80077b:	ff d0                	call   *%eax
  80077d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800780:	8b 45 14             	mov    0x14(%ebp),%eax
  800783:	83 c0 04             	add    $0x4,%eax
  800786:	89 45 14             	mov    %eax,0x14(%ebp)
  800789:	8b 45 14             	mov    0x14(%ebp),%eax
  80078c:	83 e8 04             	sub    $0x4,%eax
  80078f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800791:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800794:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80079b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007a2:	eb 1f                	jmp    8007c3 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007a4:	83 ec 08             	sub    $0x8,%esp
  8007a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8007aa:	8d 45 14             	lea    0x14(%ebp),%eax
  8007ad:	50                   	push   %eax
  8007ae:	e8 e7 fb ff ff       	call   80039a <getuint>
  8007b3:	83 c4 10             	add    $0x10,%esp
  8007b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007b9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007bc:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007c3:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007c7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007ca:	83 ec 04             	sub    $0x4,%esp
  8007cd:	52                   	push   %edx
  8007ce:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007d1:	50                   	push   %eax
  8007d2:	ff 75 f4             	pushl  -0xc(%ebp)
  8007d5:	ff 75 f0             	pushl  -0x10(%ebp)
  8007d8:	ff 75 0c             	pushl  0xc(%ebp)
  8007db:	ff 75 08             	pushl  0x8(%ebp)
  8007de:	e8 00 fb ff ff       	call   8002e3 <printnum>
  8007e3:	83 c4 20             	add    $0x20,%esp
			break;
  8007e6:	eb 34                	jmp    80081c <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8007e8:	83 ec 08             	sub    $0x8,%esp
  8007eb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ee:	53                   	push   %ebx
  8007ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f2:	ff d0                	call   *%eax
  8007f4:	83 c4 10             	add    $0x10,%esp
			break;
  8007f7:	eb 23                	jmp    80081c <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8007f9:	83 ec 08             	sub    $0x8,%esp
  8007fc:	ff 75 0c             	pushl  0xc(%ebp)
  8007ff:	6a 25                	push   $0x25
  800801:	8b 45 08             	mov    0x8(%ebp),%eax
  800804:	ff d0                	call   *%eax
  800806:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800809:	ff 4d 10             	decl   0x10(%ebp)
  80080c:	eb 03                	jmp    800811 <vprintfmt+0x3b1>
  80080e:	ff 4d 10             	decl   0x10(%ebp)
  800811:	8b 45 10             	mov    0x10(%ebp),%eax
  800814:	48                   	dec    %eax
  800815:	8a 00                	mov    (%eax),%al
  800817:	3c 25                	cmp    $0x25,%al
  800819:	75 f3                	jne    80080e <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80081b:	90                   	nop
		}
	}
  80081c:	e9 47 fc ff ff       	jmp    800468 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800821:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800822:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800825:	5b                   	pop    %ebx
  800826:	5e                   	pop    %esi
  800827:	5d                   	pop    %ebp
  800828:	c3                   	ret    

00800829 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800829:	55                   	push   %ebp
  80082a:	89 e5                	mov    %esp,%ebp
  80082c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80082f:	8d 45 10             	lea    0x10(%ebp),%eax
  800832:	83 c0 04             	add    $0x4,%eax
  800835:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800838:	8b 45 10             	mov    0x10(%ebp),%eax
  80083b:	ff 75 f4             	pushl  -0xc(%ebp)
  80083e:	50                   	push   %eax
  80083f:	ff 75 0c             	pushl  0xc(%ebp)
  800842:	ff 75 08             	pushl  0x8(%ebp)
  800845:	e8 16 fc ff ff       	call   800460 <vprintfmt>
  80084a:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80084d:	90                   	nop
  80084e:	c9                   	leave  
  80084f:	c3                   	ret    

00800850 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800850:	55                   	push   %ebp
  800851:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800853:	8b 45 0c             	mov    0xc(%ebp),%eax
  800856:	8b 40 08             	mov    0x8(%eax),%eax
  800859:	8d 50 01             	lea    0x1(%eax),%edx
  80085c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80085f:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800862:	8b 45 0c             	mov    0xc(%ebp),%eax
  800865:	8b 10                	mov    (%eax),%edx
  800867:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086a:	8b 40 04             	mov    0x4(%eax),%eax
  80086d:	39 c2                	cmp    %eax,%edx
  80086f:	73 12                	jae    800883 <sprintputch+0x33>
		*b->buf++ = ch;
  800871:	8b 45 0c             	mov    0xc(%ebp),%eax
  800874:	8b 00                	mov    (%eax),%eax
  800876:	8d 48 01             	lea    0x1(%eax),%ecx
  800879:	8b 55 0c             	mov    0xc(%ebp),%edx
  80087c:	89 0a                	mov    %ecx,(%edx)
  80087e:	8b 55 08             	mov    0x8(%ebp),%edx
  800881:	88 10                	mov    %dl,(%eax)
}
  800883:	90                   	nop
  800884:	5d                   	pop    %ebp
  800885:	c3                   	ret    

00800886 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800886:	55                   	push   %ebp
  800887:	89 e5                	mov    %esp,%ebp
  800889:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80088c:	8b 45 08             	mov    0x8(%ebp),%eax
  80088f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800892:	8b 45 0c             	mov    0xc(%ebp),%eax
  800895:	8d 50 ff             	lea    -0x1(%eax),%edx
  800898:	8b 45 08             	mov    0x8(%ebp),%eax
  80089b:	01 d0                	add    %edx,%eax
  80089d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008a7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008ab:	74 06                	je     8008b3 <vsnprintf+0x2d>
  8008ad:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008b1:	7f 07                	jg     8008ba <vsnprintf+0x34>
		return -E_INVAL;
  8008b3:	b8 03 00 00 00       	mov    $0x3,%eax
  8008b8:	eb 20                	jmp    8008da <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ba:	ff 75 14             	pushl  0x14(%ebp)
  8008bd:	ff 75 10             	pushl  0x10(%ebp)
  8008c0:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008c3:	50                   	push   %eax
  8008c4:	68 50 08 80 00       	push   $0x800850
  8008c9:	e8 92 fb ff ff       	call   800460 <vprintfmt>
  8008ce:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008d4:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8008d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8008da:	c9                   	leave  
  8008db:	c3                   	ret    

008008dc <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8008dc:	55                   	push   %ebp
  8008dd:	89 e5                	mov    %esp,%ebp
  8008df:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8008e2:	8d 45 10             	lea    0x10(%ebp),%eax
  8008e5:	83 c0 04             	add    $0x4,%eax
  8008e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8008eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8008ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8008f1:	50                   	push   %eax
  8008f2:	ff 75 0c             	pushl  0xc(%ebp)
  8008f5:	ff 75 08             	pushl  0x8(%ebp)
  8008f8:	e8 89 ff ff ff       	call   800886 <vsnprintf>
  8008fd:	83 c4 10             	add    $0x10,%esp
  800900:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800903:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800906:	c9                   	leave  
  800907:	c3                   	ret    

00800908 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800908:	55                   	push   %ebp
  800909:	89 e5                	mov    %esp,%ebp
  80090b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80090e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800915:	eb 06                	jmp    80091d <strlen+0x15>
		n++;
  800917:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80091a:	ff 45 08             	incl   0x8(%ebp)
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	8a 00                	mov    (%eax),%al
  800922:	84 c0                	test   %al,%al
  800924:	75 f1                	jne    800917 <strlen+0xf>
		n++;
	return n;
  800926:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800929:	c9                   	leave  
  80092a:	c3                   	ret    

0080092b <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  80092b:	55                   	push   %ebp
  80092c:	89 e5                	mov    %esp,%ebp
  80092e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800931:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800938:	eb 09                	jmp    800943 <strnlen+0x18>
		n++;
  80093a:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80093d:	ff 45 08             	incl   0x8(%ebp)
  800940:	ff 4d 0c             	decl   0xc(%ebp)
  800943:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800947:	74 09                	je     800952 <strnlen+0x27>
  800949:	8b 45 08             	mov    0x8(%ebp),%eax
  80094c:	8a 00                	mov    (%eax),%al
  80094e:	84 c0                	test   %al,%al
  800950:	75 e8                	jne    80093a <strnlen+0xf>
		n++;
	return n;
  800952:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800955:	c9                   	leave  
  800956:	c3                   	ret    

00800957 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800957:	55                   	push   %ebp
  800958:	89 e5                	mov    %esp,%ebp
  80095a:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80095d:	8b 45 08             	mov    0x8(%ebp),%eax
  800960:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800963:	90                   	nop
  800964:	8b 45 08             	mov    0x8(%ebp),%eax
  800967:	8d 50 01             	lea    0x1(%eax),%edx
  80096a:	89 55 08             	mov    %edx,0x8(%ebp)
  80096d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800970:	8d 4a 01             	lea    0x1(%edx),%ecx
  800973:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800976:	8a 12                	mov    (%edx),%dl
  800978:	88 10                	mov    %dl,(%eax)
  80097a:	8a 00                	mov    (%eax),%al
  80097c:	84 c0                	test   %al,%al
  80097e:	75 e4                	jne    800964 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800980:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800983:	c9                   	leave  
  800984:	c3                   	ret    

00800985 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800985:	55                   	push   %ebp
  800986:	89 e5                	mov    %esp,%ebp
  800988:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80098b:	8b 45 08             	mov    0x8(%ebp),%eax
  80098e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800991:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800998:	eb 1f                	jmp    8009b9 <strncpy+0x34>
		*dst++ = *src;
  80099a:	8b 45 08             	mov    0x8(%ebp),%eax
  80099d:	8d 50 01             	lea    0x1(%eax),%edx
  8009a0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a6:	8a 12                	mov    (%edx),%dl
  8009a8:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ad:	8a 00                	mov    (%eax),%al
  8009af:	84 c0                	test   %al,%al
  8009b1:	74 03                	je     8009b6 <strncpy+0x31>
			src++;
  8009b3:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009b6:	ff 45 fc             	incl   -0x4(%ebp)
  8009b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009bc:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009bf:	72 d9                	jb     80099a <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009c4:	c9                   	leave  
  8009c5:	c3                   	ret    

008009c6 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009c6:	55                   	push   %ebp
  8009c7:	89 e5                	mov    %esp,%ebp
  8009c9:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009d6:	74 30                	je     800a08 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8009d8:	eb 16                	jmp    8009f0 <strlcpy+0x2a>
			*dst++ = *src++;
  8009da:	8b 45 08             	mov    0x8(%ebp),%eax
  8009dd:	8d 50 01             	lea    0x1(%eax),%edx
  8009e0:	89 55 08             	mov    %edx,0x8(%ebp)
  8009e3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009e9:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009ec:	8a 12                	mov    (%edx),%dl
  8009ee:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8009f0:	ff 4d 10             	decl   0x10(%ebp)
  8009f3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8009f7:	74 09                	je     800a02 <strlcpy+0x3c>
  8009f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009fc:	8a 00                	mov    (%eax),%al
  8009fe:	84 c0                	test   %al,%al
  800a00:	75 d8                	jne    8009da <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a08:	8b 55 08             	mov    0x8(%ebp),%edx
  800a0b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a0e:	29 c2                	sub    %eax,%edx
  800a10:	89 d0                	mov    %edx,%eax
}
  800a12:	c9                   	leave  
  800a13:	c3                   	ret    

00800a14 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a14:	55                   	push   %ebp
  800a15:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a17:	eb 06                	jmp    800a1f <strcmp+0xb>
		p++, q++;
  800a19:	ff 45 08             	incl   0x8(%ebp)
  800a1c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a22:	8a 00                	mov    (%eax),%al
  800a24:	84 c0                	test   %al,%al
  800a26:	74 0e                	je     800a36 <strcmp+0x22>
  800a28:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2b:	8a 10                	mov    (%eax),%dl
  800a2d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a30:	8a 00                	mov    (%eax),%al
  800a32:	38 c2                	cmp    %al,%dl
  800a34:	74 e3                	je     800a19 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a36:	8b 45 08             	mov    0x8(%ebp),%eax
  800a39:	8a 00                	mov    (%eax),%al
  800a3b:	0f b6 d0             	movzbl %al,%edx
  800a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a41:	8a 00                	mov    (%eax),%al
  800a43:	0f b6 c0             	movzbl %al,%eax
  800a46:	29 c2                	sub    %eax,%edx
  800a48:	89 d0                	mov    %edx,%eax
}
  800a4a:	5d                   	pop    %ebp
  800a4b:	c3                   	ret    

00800a4c <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a4c:	55                   	push   %ebp
  800a4d:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a4f:	eb 09                	jmp    800a5a <strncmp+0xe>
		n--, p++, q++;
  800a51:	ff 4d 10             	decl   0x10(%ebp)
  800a54:	ff 45 08             	incl   0x8(%ebp)
  800a57:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a5a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a5e:	74 17                	je     800a77 <strncmp+0x2b>
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	8a 00                	mov    (%eax),%al
  800a65:	84 c0                	test   %al,%al
  800a67:	74 0e                	je     800a77 <strncmp+0x2b>
  800a69:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6c:	8a 10                	mov    (%eax),%dl
  800a6e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a71:	8a 00                	mov    (%eax),%al
  800a73:	38 c2                	cmp    %al,%dl
  800a75:	74 da                	je     800a51 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800a77:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a7b:	75 07                	jne    800a84 <strncmp+0x38>
		return 0;
  800a7d:	b8 00 00 00 00       	mov    $0x0,%eax
  800a82:	eb 14                	jmp    800a98 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	8a 00                	mov    (%eax),%al
  800a89:	0f b6 d0             	movzbl %al,%edx
  800a8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a8f:	8a 00                	mov    (%eax),%al
  800a91:	0f b6 c0             	movzbl %al,%eax
  800a94:	29 c2                	sub    %eax,%edx
  800a96:	89 d0                	mov    %edx,%eax
}
  800a98:	5d                   	pop    %ebp
  800a99:	c3                   	ret    

00800a9a <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800a9a:	55                   	push   %ebp
  800a9b:	89 e5                	mov    %esp,%ebp
  800a9d:	83 ec 04             	sub    $0x4,%esp
  800aa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800aa6:	eb 12                	jmp    800aba <strchr+0x20>
		if (*s == c)
  800aa8:	8b 45 08             	mov    0x8(%ebp),%eax
  800aab:	8a 00                	mov    (%eax),%al
  800aad:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ab0:	75 05                	jne    800ab7 <strchr+0x1d>
			return (char *) s;
  800ab2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab5:	eb 11                	jmp    800ac8 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ab7:	ff 45 08             	incl   0x8(%ebp)
  800aba:	8b 45 08             	mov    0x8(%ebp),%eax
  800abd:	8a 00                	mov    (%eax),%al
  800abf:	84 c0                	test   %al,%al
  800ac1:	75 e5                	jne    800aa8 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800ac3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ac8:	c9                   	leave  
  800ac9:	c3                   	ret    

00800aca <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800aca:	55                   	push   %ebp
  800acb:	89 e5                	mov    %esp,%ebp
  800acd:	83 ec 04             	sub    $0x4,%esp
  800ad0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad3:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ad6:	eb 0d                	jmp    800ae5 <strfind+0x1b>
		if (*s == c)
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8a 00                	mov    (%eax),%al
  800add:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ae0:	74 0e                	je     800af0 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ae2:	ff 45 08             	incl   0x8(%ebp)
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	8a 00                	mov    (%eax),%al
  800aea:	84 c0                	test   %al,%al
  800aec:	75 ea                	jne    800ad8 <strfind+0xe>
  800aee:	eb 01                	jmp    800af1 <strfind+0x27>
		if (*s == c)
			break;
  800af0:	90                   	nop
	return (char *) s;
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800af4:	c9                   	leave  
  800af5:	c3                   	ret    

00800af6 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800af6:	55                   	push   %ebp
  800af7:	89 e5                	mov    %esp,%ebp
  800af9:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800afc:	8b 45 08             	mov    0x8(%ebp),%eax
  800aff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b02:	8b 45 10             	mov    0x10(%ebp),%eax
  800b05:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b08:	eb 0e                	jmp    800b18 <memset+0x22>
		*p++ = c;
  800b0a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b0d:	8d 50 01             	lea    0x1(%eax),%edx
  800b10:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b13:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b16:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b18:	ff 4d f8             	decl   -0x8(%ebp)
  800b1b:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b1f:	79 e9                	jns    800b0a <memset+0x14>
		*p++ = c;

	return v;
  800b21:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b24:	c9                   	leave  
  800b25:	c3                   	ret    

00800b26 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b26:	55                   	push   %ebp
  800b27:	89 e5                	mov    %esp,%ebp
  800b29:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b2c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b38:	eb 16                	jmp    800b50 <memcpy+0x2a>
		*d++ = *s++;
  800b3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b3d:	8d 50 01             	lea    0x1(%eax),%edx
  800b40:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b46:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b49:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b4c:	8a 12                	mov    (%edx),%dl
  800b4e:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b50:	8b 45 10             	mov    0x10(%ebp),%eax
  800b53:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b56:	89 55 10             	mov    %edx,0x10(%ebp)
  800b59:	85 c0                	test   %eax,%eax
  800b5b:	75 dd                	jne    800b3a <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b5d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b60:	c9                   	leave  
  800b61:	c3                   	ret    

00800b62 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b62:	55                   	push   %ebp
  800b63:	89 e5                	mov    %esp,%ebp
  800b65:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b77:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b7a:	73 50                	jae    800bcc <memmove+0x6a>
  800b7c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b7f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b82:	01 d0                	add    %edx,%eax
  800b84:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800b87:	76 43                	jbe    800bcc <memmove+0x6a>
		s += n;
  800b89:	8b 45 10             	mov    0x10(%ebp),%eax
  800b8c:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800b8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b92:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800b95:	eb 10                	jmp    800ba7 <memmove+0x45>
			*--d = *--s;
  800b97:	ff 4d f8             	decl   -0x8(%ebp)
  800b9a:	ff 4d fc             	decl   -0x4(%ebp)
  800b9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba0:	8a 10                	mov    (%eax),%dl
  800ba2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ba5:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800ba7:	8b 45 10             	mov    0x10(%ebp),%eax
  800baa:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bad:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb0:	85 c0                	test   %eax,%eax
  800bb2:	75 e3                	jne    800b97 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bb4:	eb 23                	jmp    800bd9 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800bb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bb9:	8d 50 01             	lea    0x1(%eax),%edx
  800bbc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bbf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bc2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bc8:	8a 12                	mov    (%edx),%dl
  800bca:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bcf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800bd5:	85 c0                	test   %eax,%eax
  800bd7:	75 dd                	jne    800bb6 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bdc:	c9                   	leave  
  800bdd:	c3                   	ret    

00800bde <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800bde:	55                   	push   %ebp
  800bdf:	89 e5                	mov    %esp,%ebp
  800be1:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800bea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bed:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800bf0:	eb 2a                	jmp    800c1c <memcmp+0x3e>
		if (*s1 != *s2)
  800bf2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bf5:	8a 10                	mov    (%eax),%dl
  800bf7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bfa:	8a 00                	mov    (%eax),%al
  800bfc:	38 c2                	cmp    %al,%dl
  800bfe:	74 16                	je     800c16 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c03:	8a 00                	mov    (%eax),%al
  800c05:	0f b6 d0             	movzbl %al,%edx
  800c08:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c0b:	8a 00                	mov    (%eax),%al
  800c0d:	0f b6 c0             	movzbl %al,%eax
  800c10:	29 c2                	sub    %eax,%edx
  800c12:	89 d0                	mov    %edx,%eax
  800c14:	eb 18                	jmp    800c2e <memcmp+0x50>
		s1++, s2++;
  800c16:	ff 45 fc             	incl   -0x4(%ebp)
  800c19:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c1c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c1f:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c22:	89 55 10             	mov    %edx,0x10(%ebp)
  800c25:	85 c0                	test   %eax,%eax
  800c27:	75 c9                	jne    800bf2 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c29:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c2e:	c9                   	leave  
  800c2f:	c3                   	ret    

00800c30 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c30:	55                   	push   %ebp
  800c31:	89 e5                	mov    %esp,%ebp
  800c33:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c36:	8b 55 08             	mov    0x8(%ebp),%edx
  800c39:	8b 45 10             	mov    0x10(%ebp),%eax
  800c3c:	01 d0                	add    %edx,%eax
  800c3e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c41:	eb 15                	jmp    800c58 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	8a 00                	mov    (%eax),%al
  800c48:	0f b6 d0             	movzbl %al,%edx
  800c4b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c4e:	0f b6 c0             	movzbl %al,%eax
  800c51:	39 c2                	cmp    %eax,%edx
  800c53:	74 0d                	je     800c62 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c55:	ff 45 08             	incl   0x8(%ebp)
  800c58:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c5e:	72 e3                	jb     800c43 <memfind+0x13>
  800c60:	eb 01                	jmp    800c63 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c62:	90                   	nop
	return (void *) s;
  800c63:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c66:	c9                   	leave  
  800c67:	c3                   	ret    

00800c68 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c68:	55                   	push   %ebp
  800c69:	89 e5                	mov    %esp,%ebp
  800c6b:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c6e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c75:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c7c:	eb 03                	jmp    800c81 <strtol+0x19>
		s++;
  800c7e:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	8a 00                	mov    (%eax),%al
  800c86:	3c 20                	cmp    $0x20,%al
  800c88:	74 f4                	je     800c7e <strtol+0x16>
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8d:	8a 00                	mov    (%eax),%al
  800c8f:	3c 09                	cmp    $0x9,%al
  800c91:	74 eb                	je     800c7e <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800c93:	8b 45 08             	mov    0x8(%ebp),%eax
  800c96:	8a 00                	mov    (%eax),%al
  800c98:	3c 2b                	cmp    $0x2b,%al
  800c9a:	75 05                	jne    800ca1 <strtol+0x39>
		s++;
  800c9c:	ff 45 08             	incl   0x8(%ebp)
  800c9f:	eb 13                	jmp    800cb4 <strtol+0x4c>
	else if (*s == '-')
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 00                	mov    (%eax),%al
  800ca6:	3c 2d                	cmp    $0x2d,%al
  800ca8:	75 0a                	jne    800cb4 <strtol+0x4c>
		s++, neg = 1;
  800caa:	ff 45 08             	incl   0x8(%ebp)
  800cad:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cb4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cb8:	74 06                	je     800cc0 <strtol+0x58>
  800cba:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800cbe:	75 20                	jne    800ce0 <strtol+0x78>
  800cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	3c 30                	cmp    $0x30,%al
  800cc7:	75 17                	jne    800ce0 <strtol+0x78>
  800cc9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccc:	40                   	inc    %eax
  800ccd:	8a 00                	mov    (%eax),%al
  800ccf:	3c 78                	cmp    $0x78,%al
  800cd1:	75 0d                	jne    800ce0 <strtol+0x78>
		s += 2, base = 16;
  800cd3:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800cd7:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800cde:	eb 28                	jmp    800d08 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800ce0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce4:	75 15                	jne    800cfb <strtol+0x93>
  800ce6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce9:	8a 00                	mov    (%eax),%al
  800ceb:	3c 30                	cmp    $0x30,%al
  800ced:	75 0c                	jne    800cfb <strtol+0x93>
		s++, base = 8;
  800cef:	ff 45 08             	incl   0x8(%ebp)
  800cf2:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800cf9:	eb 0d                	jmp    800d08 <strtol+0xa0>
	else if (base == 0)
  800cfb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cff:	75 07                	jne    800d08 <strtol+0xa0>
		base = 10;
  800d01:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	8a 00                	mov    (%eax),%al
  800d0d:	3c 2f                	cmp    $0x2f,%al
  800d0f:	7e 19                	jle    800d2a <strtol+0xc2>
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	8a 00                	mov    (%eax),%al
  800d16:	3c 39                	cmp    $0x39,%al
  800d18:	7f 10                	jg     800d2a <strtol+0xc2>
			dig = *s - '0';
  800d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1d:	8a 00                	mov    (%eax),%al
  800d1f:	0f be c0             	movsbl %al,%eax
  800d22:	83 e8 30             	sub    $0x30,%eax
  800d25:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d28:	eb 42                	jmp    800d6c <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2d:	8a 00                	mov    (%eax),%al
  800d2f:	3c 60                	cmp    $0x60,%al
  800d31:	7e 19                	jle    800d4c <strtol+0xe4>
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	3c 7a                	cmp    $0x7a,%al
  800d3a:	7f 10                	jg     800d4c <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3f:	8a 00                	mov    (%eax),%al
  800d41:	0f be c0             	movsbl %al,%eax
  800d44:	83 e8 57             	sub    $0x57,%eax
  800d47:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d4a:	eb 20                	jmp    800d6c <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	8a 00                	mov    (%eax),%al
  800d51:	3c 40                	cmp    $0x40,%al
  800d53:	7e 39                	jle    800d8e <strtol+0x126>
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8a 00                	mov    (%eax),%al
  800d5a:	3c 5a                	cmp    $0x5a,%al
  800d5c:	7f 30                	jg     800d8e <strtol+0x126>
			dig = *s - 'A' + 10;
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	0f be c0             	movsbl %al,%eax
  800d66:	83 e8 37             	sub    $0x37,%eax
  800d69:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d6c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d6f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d72:	7d 19                	jge    800d8d <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d74:	ff 45 08             	incl   0x8(%ebp)
  800d77:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d7a:	0f af 45 10          	imul   0x10(%ebp),%eax
  800d7e:	89 c2                	mov    %eax,%edx
  800d80:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d83:	01 d0                	add    %edx,%eax
  800d85:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800d88:	e9 7b ff ff ff       	jmp    800d08 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800d8d:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800d8e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d92:	74 08                	je     800d9c <strtol+0x134>
		*endptr = (char *) s;
  800d94:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d97:	8b 55 08             	mov    0x8(%ebp),%edx
  800d9a:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800d9c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800da0:	74 07                	je     800da9 <strtol+0x141>
  800da2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da5:	f7 d8                	neg    %eax
  800da7:	eb 03                	jmp    800dac <strtol+0x144>
  800da9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dac:	c9                   	leave  
  800dad:	c3                   	ret    

00800dae <ltostr>:

void
ltostr(long value, char *str)
{
  800dae:	55                   	push   %ebp
  800daf:	89 e5                	mov    %esp,%ebp
  800db1:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800db4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800dbb:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dc2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800dc6:	79 13                	jns    800ddb <ltostr+0x2d>
	{
		neg = 1;
  800dc8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dd2:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dd5:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800dd8:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800ddb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dde:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800de3:	99                   	cltd   
  800de4:	f7 f9                	idiv   %ecx
  800de6:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800de9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dec:	8d 50 01             	lea    0x1(%eax),%edx
  800def:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800df2:	89 c2                	mov    %eax,%edx
  800df4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800df7:	01 d0                	add    %edx,%eax
  800df9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800dfc:	83 c2 30             	add    $0x30,%edx
  800dff:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e01:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e04:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e09:	f7 e9                	imul   %ecx
  800e0b:	c1 fa 02             	sar    $0x2,%edx
  800e0e:	89 c8                	mov    %ecx,%eax
  800e10:	c1 f8 1f             	sar    $0x1f,%eax
  800e13:	29 c2                	sub    %eax,%edx
  800e15:	89 d0                	mov    %edx,%eax
  800e17:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e1a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e1d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e22:	f7 e9                	imul   %ecx
  800e24:	c1 fa 02             	sar    $0x2,%edx
  800e27:	89 c8                	mov    %ecx,%eax
  800e29:	c1 f8 1f             	sar    $0x1f,%eax
  800e2c:	29 c2                	sub    %eax,%edx
  800e2e:	89 d0                	mov    %edx,%eax
  800e30:	c1 e0 02             	shl    $0x2,%eax
  800e33:	01 d0                	add    %edx,%eax
  800e35:	01 c0                	add    %eax,%eax
  800e37:	29 c1                	sub    %eax,%ecx
  800e39:	89 ca                	mov    %ecx,%edx
  800e3b:	85 d2                	test   %edx,%edx
  800e3d:	75 9c                	jne    800ddb <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e3f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e46:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e49:	48                   	dec    %eax
  800e4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e4d:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e51:	74 3d                	je     800e90 <ltostr+0xe2>
		start = 1 ;
  800e53:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e5a:	eb 34                	jmp    800e90 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e5c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e5f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e62:	01 d0                	add    %edx,%eax
  800e64:	8a 00                	mov    (%eax),%al
  800e66:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e69:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e6f:	01 c2                	add    %eax,%edx
  800e71:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e74:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e77:	01 c8                	add    %ecx,%eax
  800e79:	8a 00                	mov    (%eax),%al
  800e7b:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800e7d:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800e80:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e83:	01 c2                	add    %eax,%edx
  800e85:	8a 45 eb             	mov    -0x15(%ebp),%al
  800e88:	88 02                	mov    %al,(%edx)
		start++ ;
  800e8a:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800e8d:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800e90:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e93:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800e96:	7c c4                	jl     800e5c <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800e98:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800e9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9e:	01 d0                	add    %edx,%eax
  800ea0:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ea3:	90                   	nop
  800ea4:	c9                   	leave  
  800ea5:	c3                   	ret    

00800ea6 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ea6:	55                   	push   %ebp
  800ea7:	89 e5                	mov    %esp,%ebp
  800ea9:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800eac:	ff 75 08             	pushl  0x8(%ebp)
  800eaf:	e8 54 fa ff ff       	call   800908 <strlen>
  800eb4:	83 c4 04             	add    $0x4,%esp
  800eb7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800eba:	ff 75 0c             	pushl  0xc(%ebp)
  800ebd:	e8 46 fa ff ff       	call   800908 <strlen>
  800ec2:	83 c4 04             	add    $0x4,%esp
  800ec5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ec8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ecf:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ed6:	eb 17                	jmp    800eef <strcconcat+0x49>
		final[s] = str1[s] ;
  800ed8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800edb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ede:	01 c2                	add    %eax,%edx
  800ee0:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800ee3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee6:	01 c8                	add    %ecx,%eax
  800ee8:	8a 00                	mov    (%eax),%al
  800eea:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800eec:	ff 45 fc             	incl   -0x4(%ebp)
  800eef:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ef2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800ef5:	7c e1                	jl     800ed8 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800ef7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800efe:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f05:	eb 1f                	jmp    800f26 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f07:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f0a:	8d 50 01             	lea    0x1(%eax),%edx
  800f0d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f10:	89 c2                	mov    %eax,%edx
  800f12:	8b 45 10             	mov    0x10(%ebp),%eax
  800f15:	01 c2                	add    %eax,%edx
  800f17:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1d:	01 c8                	add    %ecx,%eax
  800f1f:	8a 00                	mov    (%eax),%al
  800f21:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f23:	ff 45 f8             	incl   -0x8(%ebp)
  800f26:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f29:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f2c:	7c d9                	jl     800f07 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f2e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f31:	8b 45 10             	mov    0x10(%ebp),%eax
  800f34:	01 d0                	add    %edx,%eax
  800f36:	c6 00 00             	movb   $0x0,(%eax)
}
  800f39:	90                   	nop
  800f3a:	c9                   	leave  
  800f3b:	c3                   	ret    

00800f3c <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f3c:	55                   	push   %ebp
  800f3d:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f3f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f42:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f48:	8b 45 14             	mov    0x14(%ebp),%eax
  800f4b:	8b 00                	mov    (%eax),%eax
  800f4d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f54:	8b 45 10             	mov    0x10(%ebp),%eax
  800f57:	01 d0                	add    %edx,%eax
  800f59:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f5f:	eb 0c                	jmp    800f6d <strsplit+0x31>
			*string++ = 0;
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8d 50 01             	lea    0x1(%eax),%edx
  800f67:	89 55 08             	mov    %edx,0x8(%ebp)
  800f6a:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f70:	8a 00                	mov    (%eax),%al
  800f72:	84 c0                	test   %al,%al
  800f74:	74 18                	je     800f8e <strsplit+0x52>
  800f76:	8b 45 08             	mov    0x8(%ebp),%eax
  800f79:	8a 00                	mov    (%eax),%al
  800f7b:	0f be c0             	movsbl %al,%eax
  800f7e:	50                   	push   %eax
  800f7f:	ff 75 0c             	pushl  0xc(%ebp)
  800f82:	e8 13 fb ff ff       	call   800a9a <strchr>
  800f87:	83 c4 08             	add    $0x8,%esp
  800f8a:	85 c0                	test   %eax,%eax
  800f8c:	75 d3                	jne    800f61 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	84 c0                	test   %al,%al
  800f95:	74 5a                	je     800ff1 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800f97:	8b 45 14             	mov    0x14(%ebp),%eax
  800f9a:	8b 00                	mov    (%eax),%eax
  800f9c:	83 f8 0f             	cmp    $0xf,%eax
  800f9f:	75 07                	jne    800fa8 <strsplit+0x6c>
		{
			return 0;
  800fa1:	b8 00 00 00 00       	mov    $0x0,%eax
  800fa6:	eb 66                	jmp    80100e <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fa8:	8b 45 14             	mov    0x14(%ebp),%eax
  800fab:	8b 00                	mov    (%eax),%eax
  800fad:	8d 48 01             	lea    0x1(%eax),%ecx
  800fb0:	8b 55 14             	mov    0x14(%ebp),%edx
  800fb3:	89 0a                	mov    %ecx,(%edx)
  800fb5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fbf:	01 c2                	add    %eax,%edx
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fc6:	eb 03                	jmp    800fcb <strsplit+0x8f>
			string++;
  800fc8:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fce:	8a 00                	mov    (%eax),%al
  800fd0:	84 c0                	test   %al,%al
  800fd2:	74 8b                	je     800f5f <strsplit+0x23>
  800fd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd7:	8a 00                	mov    (%eax),%al
  800fd9:	0f be c0             	movsbl %al,%eax
  800fdc:	50                   	push   %eax
  800fdd:	ff 75 0c             	pushl  0xc(%ebp)
  800fe0:	e8 b5 fa ff ff       	call   800a9a <strchr>
  800fe5:	83 c4 08             	add    $0x8,%esp
  800fe8:	85 c0                	test   %eax,%eax
  800fea:	74 dc                	je     800fc8 <strsplit+0x8c>
			string++;
	}
  800fec:	e9 6e ff ff ff       	jmp    800f5f <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  800ff1:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  800ff2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ff5:	8b 00                	mov    (%eax),%eax
  800ff7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ffe:	8b 45 10             	mov    0x10(%ebp),%eax
  801001:	01 d0                	add    %edx,%eax
  801003:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801009:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80100e:	c9                   	leave  
  80100f:	c3                   	ret    

00801010 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801010:	55                   	push   %ebp
  801011:	89 e5                	mov    %esp,%ebp
  801013:	57                   	push   %edi
  801014:	56                   	push   %esi
  801015:	53                   	push   %ebx
  801016:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801019:	8b 45 08             	mov    0x8(%ebp),%eax
  80101c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80101f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801022:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801025:	8b 7d 18             	mov    0x18(%ebp),%edi
  801028:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80102b:	cd 30                	int    $0x30
  80102d:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801030:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801033:	83 c4 10             	add    $0x10,%esp
  801036:	5b                   	pop    %ebx
  801037:	5e                   	pop    %esi
  801038:	5f                   	pop    %edi
  801039:	5d                   	pop    %ebp
  80103a:	c3                   	ret    

0080103b <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80103b:	55                   	push   %ebp
  80103c:	89 e5                	mov    %esp,%ebp
  80103e:	83 ec 04             	sub    $0x4,%esp
  801041:	8b 45 10             	mov    0x10(%ebp),%eax
  801044:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801047:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80104b:	8b 45 08             	mov    0x8(%ebp),%eax
  80104e:	6a 00                	push   $0x0
  801050:	6a 00                	push   $0x0
  801052:	52                   	push   %edx
  801053:	ff 75 0c             	pushl  0xc(%ebp)
  801056:	50                   	push   %eax
  801057:	6a 00                	push   $0x0
  801059:	e8 b2 ff ff ff       	call   801010 <syscall>
  80105e:	83 c4 18             	add    $0x18,%esp
}
  801061:	90                   	nop
  801062:	c9                   	leave  
  801063:	c3                   	ret    

00801064 <sys_cgetc>:

int
sys_cgetc(void)
{
  801064:	55                   	push   %ebp
  801065:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801067:	6a 00                	push   $0x0
  801069:	6a 00                	push   $0x0
  80106b:	6a 00                	push   $0x0
  80106d:	6a 00                	push   $0x0
  80106f:	6a 00                	push   $0x0
  801071:	6a 01                	push   $0x1
  801073:	e8 98 ff ff ff       	call   801010 <syscall>
  801078:	83 c4 18             	add    $0x18,%esp
}
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	6a 00                	push   $0x0
  801085:	6a 00                	push   $0x0
  801087:	6a 00                	push   $0x0
  801089:	6a 00                	push   $0x0
  80108b:	50                   	push   %eax
  80108c:	6a 05                	push   $0x5
  80108e:	e8 7d ff ff ff       	call   801010 <syscall>
  801093:	83 c4 18             	add    $0x18,%esp
}
  801096:	c9                   	leave  
  801097:	c3                   	ret    

00801098 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801098:	55                   	push   %ebp
  801099:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80109b:	6a 00                	push   $0x0
  80109d:	6a 00                	push   $0x0
  80109f:	6a 00                	push   $0x0
  8010a1:	6a 00                	push   $0x0
  8010a3:	6a 00                	push   $0x0
  8010a5:	6a 02                	push   $0x2
  8010a7:	e8 64 ff ff ff       	call   801010 <syscall>
  8010ac:	83 c4 18             	add    $0x18,%esp
}
  8010af:	c9                   	leave  
  8010b0:	c3                   	ret    

008010b1 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010b1:	55                   	push   %ebp
  8010b2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	6a 00                	push   $0x0
  8010ba:	6a 00                	push   $0x0
  8010bc:	6a 00                	push   $0x0
  8010be:	6a 03                	push   $0x3
  8010c0:	e8 4b ff ff ff       	call   801010 <syscall>
  8010c5:	83 c4 18             	add    $0x18,%esp
}
  8010c8:	c9                   	leave  
  8010c9:	c3                   	ret    

008010ca <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010ca:	55                   	push   %ebp
  8010cb:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 00                	push   $0x0
  8010d1:	6a 00                	push   $0x0
  8010d3:	6a 00                	push   $0x0
  8010d5:	6a 00                	push   $0x0
  8010d7:	6a 04                	push   $0x4
  8010d9:	e8 32 ff ff ff       	call   801010 <syscall>
  8010de:	83 c4 18             	add    $0x18,%esp
}
  8010e1:	c9                   	leave  
  8010e2:	c3                   	ret    

008010e3 <sys_env_exit>:


void sys_env_exit(void)
{
  8010e3:	55                   	push   %ebp
  8010e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 00                	push   $0x0
  8010ea:	6a 00                	push   $0x0
  8010ec:	6a 00                	push   $0x0
  8010ee:	6a 00                	push   $0x0
  8010f0:	6a 06                	push   $0x6
  8010f2:	e8 19 ff ff ff       	call   801010 <syscall>
  8010f7:	83 c4 18             	add    $0x18,%esp
}
  8010fa:	90                   	nop
  8010fb:	c9                   	leave  
  8010fc:	c3                   	ret    

008010fd <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8010fd:	55                   	push   %ebp
  8010fe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801100:	8b 55 0c             	mov    0xc(%ebp),%edx
  801103:	8b 45 08             	mov    0x8(%ebp),%eax
  801106:	6a 00                	push   $0x0
  801108:	6a 00                	push   $0x0
  80110a:	6a 00                	push   $0x0
  80110c:	52                   	push   %edx
  80110d:	50                   	push   %eax
  80110e:	6a 07                	push   $0x7
  801110:	e8 fb fe ff ff       	call   801010 <syscall>
  801115:	83 c4 18             	add    $0x18,%esp
}
  801118:	c9                   	leave  
  801119:	c3                   	ret    

0080111a <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80111a:	55                   	push   %ebp
  80111b:	89 e5                	mov    %esp,%ebp
  80111d:	56                   	push   %esi
  80111e:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80111f:	8b 75 18             	mov    0x18(%ebp),%esi
  801122:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801125:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801128:	8b 55 0c             	mov    0xc(%ebp),%edx
  80112b:	8b 45 08             	mov    0x8(%ebp),%eax
  80112e:	56                   	push   %esi
  80112f:	53                   	push   %ebx
  801130:	51                   	push   %ecx
  801131:	52                   	push   %edx
  801132:	50                   	push   %eax
  801133:	6a 08                	push   $0x8
  801135:	e8 d6 fe ff ff       	call   801010 <syscall>
  80113a:	83 c4 18             	add    $0x18,%esp
}
  80113d:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801140:	5b                   	pop    %ebx
  801141:	5e                   	pop    %esi
  801142:	5d                   	pop    %ebp
  801143:	c3                   	ret    

00801144 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801147:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114a:	8b 45 08             	mov    0x8(%ebp),%eax
  80114d:	6a 00                	push   $0x0
  80114f:	6a 00                	push   $0x0
  801151:	6a 00                	push   $0x0
  801153:	52                   	push   %edx
  801154:	50                   	push   %eax
  801155:	6a 09                	push   $0x9
  801157:	e8 b4 fe ff ff       	call   801010 <syscall>
  80115c:	83 c4 18             	add    $0x18,%esp
}
  80115f:	c9                   	leave  
  801160:	c3                   	ret    

00801161 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801161:	55                   	push   %ebp
  801162:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801164:	6a 00                	push   $0x0
  801166:	6a 00                	push   $0x0
  801168:	6a 00                	push   $0x0
  80116a:	ff 75 0c             	pushl  0xc(%ebp)
  80116d:	ff 75 08             	pushl  0x8(%ebp)
  801170:	6a 0a                	push   $0xa
  801172:	e8 99 fe ff ff       	call   801010 <syscall>
  801177:	83 c4 18             	add    $0x18,%esp
}
  80117a:	c9                   	leave  
  80117b:	c3                   	ret    

0080117c <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80117c:	55                   	push   %ebp
  80117d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80117f:	6a 00                	push   $0x0
  801181:	6a 00                	push   $0x0
  801183:	6a 00                	push   $0x0
  801185:	6a 00                	push   $0x0
  801187:	6a 00                	push   $0x0
  801189:	6a 0b                	push   $0xb
  80118b:	e8 80 fe ff ff       	call   801010 <syscall>
  801190:	83 c4 18             	add    $0x18,%esp
}
  801193:	c9                   	leave  
  801194:	c3                   	ret    

00801195 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801195:	55                   	push   %ebp
  801196:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 00                	push   $0x0
  8011a0:	6a 00                	push   $0x0
  8011a2:	6a 0c                	push   $0xc
  8011a4:	e8 67 fe ff ff       	call   801010 <syscall>
  8011a9:	83 c4 18             	add    $0x18,%esp
}
  8011ac:	c9                   	leave  
  8011ad:	c3                   	ret    

008011ae <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011ae:	55                   	push   %ebp
  8011af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 00                	push   $0x0
  8011b5:	6a 00                	push   $0x0
  8011b7:	6a 00                	push   $0x0
  8011b9:	6a 00                	push   $0x0
  8011bb:	6a 0d                	push   $0xd
  8011bd:	e8 4e fe ff ff       	call   801010 <syscall>
  8011c2:	83 c4 18             	add    $0x18,%esp
}
  8011c5:	c9                   	leave  
  8011c6:	c3                   	ret    

008011c7 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011c7:	55                   	push   %ebp
  8011c8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	ff 75 0c             	pushl  0xc(%ebp)
  8011d3:	ff 75 08             	pushl  0x8(%ebp)
  8011d6:	6a 11                	push   $0x11
  8011d8:	e8 33 fe ff ff       	call   801010 <syscall>
  8011dd:	83 c4 18             	add    $0x18,%esp
	return;
  8011e0:	90                   	nop
}
  8011e1:	c9                   	leave  
  8011e2:	c3                   	ret    

008011e3 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8011e3:	55                   	push   %ebp
  8011e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8011e6:	6a 00                	push   $0x0
  8011e8:	6a 00                	push   $0x0
  8011ea:	6a 00                	push   $0x0
  8011ec:	ff 75 0c             	pushl  0xc(%ebp)
  8011ef:	ff 75 08             	pushl  0x8(%ebp)
  8011f2:	6a 12                	push   $0x12
  8011f4:	e8 17 fe ff ff       	call   801010 <syscall>
  8011f9:	83 c4 18             	add    $0x18,%esp
	return ;
  8011fc:	90                   	nop
}
  8011fd:	c9                   	leave  
  8011fe:	c3                   	ret    

008011ff <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8011ff:	55                   	push   %ebp
  801200:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801202:	6a 00                	push   $0x0
  801204:	6a 00                	push   $0x0
  801206:	6a 00                	push   $0x0
  801208:	6a 00                	push   $0x0
  80120a:	6a 00                	push   $0x0
  80120c:	6a 0e                	push   $0xe
  80120e:	e8 fd fd ff ff       	call   801010 <syscall>
  801213:	83 c4 18             	add    $0x18,%esp
}
  801216:	c9                   	leave  
  801217:	c3                   	ret    

00801218 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801218:	55                   	push   %ebp
  801219:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80121b:	6a 00                	push   $0x0
  80121d:	6a 00                	push   $0x0
  80121f:	6a 00                	push   $0x0
  801221:	6a 00                	push   $0x0
  801223:	ff 75 08             	pushl  0x8(%ebp)
  801226:	6a 0f                	push   $0xf
  801228:	e8 e3 fd ff ff       	call   801010 <syscall>
  80122d:	83 c4 18             	add    $0x18,%esp
}
  801230:	c9                   	leave  
  801231:	c3                   	ret    

00801232 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801232:	55                   	push   %ebp
  801233:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 00                	push   $0x0
  80123b:	6a 00                	push   $0x0
  80123d:	6a 00                	push   $0x0
  80123f:	6a 10                	push   $0x10
  801241:	e8 ca fd ff ff       	call   801010 <syscall>
  801246:	83 c4 18             	add    $0x18,%esp
}
  801249:	90                   	nop
  80124a:	c9                   	leave  
  80124b:	c3                   	ret    

0080124c <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80124c:	55                   	push   %ebp
  80124d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80124f:	6a 00                	push   $0x0
  801251:	6a 00                	push   $0x0
  801253:	6a 00                	push   $0x0
  801255:	6a 00                	push   $0x0
  801257:	6a 00                	push   $0x0
  801259:	6a 14                	push   $0x14
  80125b:	e8 b0 fd ff ff       	call   801010 <syscall>
  801260:	83 c4 18             	add    $0x18,%esp
}
  801263:	90                   	nop
  801264:	c9                   	leave  
  801265:	c3                   	ret    

00801266 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801266:	55                   	push   %ebp
  801267:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801269:	6a 00                	push   $0x0
  80126b:	6a 00                	push   $0x0
  80126d:	6a 00                	push   $0x0
  80126f:	6a 00                	push   $0x0
  801271:	6a 00                	push   $0x0
  801273:	6a 15                	push   $0x15
  801275:	e8 96 fd ff ff       	call   801010 <syscall>
  80127a:	83 c4 18             	add    $0x18,%esp
}
  80127d:	90                   	nop
  80127e:	c9                   	leave  
  80127f:	c3                   	ret    

00801280 <sys_cputc>:


void
sys_cputc(const char c)
{
  801280:	55                   	push   %ebp
  801281:	89 e5                	mov    %esp,%ebp
  801283:	83 ec 04             	sub    $0x4,%esp
  801286:	8b 45 08             	mov    0x8(%ebp),%eax
  801289:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80128c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801290:	6a 00                	push   $0x0
  801292:	6a 00                	push   $0x0
  801294:	6a 00                	push   $0x0
  801296:	6a 00                	push   $0x0
  801298:	50                   	push   %eax
  801299:	6a 16                	push   $0x16
  80129b:	e8 70 fd ff ff       	call   801010 <syscall>
  8012a0:	83 c4 18             	add    $0x18,%esp
}
  8012a3:	90                   	nop
  8012a4:	c9                   	leave  
  8012a5:	c3                   	ret    

008012a6 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012a6:	55                   	push   %ebp
  8012a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012a9:	6a 00                	push   $0x0
  8012ab:	6a 00                	push   $0x0
  8012ad:	6a 00                	push   $0x0
  8012af:	6a 00                	push   $0x0
  8012b1:	6a 00                	push   $0x0
  8012b3:	6a 17                	push   $0x17
  8012b5:	e8 56 fd ff ff       	call   801010 <syscall>
  8012ba:	83 c4 18             	add    $0x18,%esp
}
  8012bd:	90                   	nop
  8012be:	c9                   	leave  
  8012bf:	c3                   	ret    

008012c0 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012c0:	55                   	push   %ebp
  8012c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c6:	6a 00                	push   $0x0
  8012c8:	6a 00                	push   $0x0
  8012ca:	6a 00                	push   $0x0
  8012cc:	ff 75 0c             	pushl  0xc(%ebp)
  8012cf:	50                   	push   %eax
  8012d0:	6a 18                	push   $0x18
  8012d2:	e8 39 fd ff ff       	call   801010 <syscall>
  8012d7:	83 c4 18             	add    $0x18,%esp
}
  8012da:	c9                   	leave  
  8012db:	c3                   	ret    

008012dc <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8012dc:	55                   	push   %ebp
  8012dd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e5:	6a 00                	push   $0x0
  8012e7:	6a 00                	push   $0x0
  8012e9:	6a 00                	push   $0x0
  8012eb:	52                   	push   %edx
  8012ec:	50                   	push   %eax
  8012ed:	6a 1b                	push   $0x1b
  8012ef:	e8 1c fd ff ff       	call   801010 <syscall>
  8012f4:	83 c4 18             	add    $0x18,%esp
}
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8012fc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801302:	6a 00                	push   $0x0
  801304:	6a 00                	push   $0x0
  801306:	6a 00                	push   $0x0
  801308:	52                   	push   %edx
  801309:	50                   	push   %eax
  80130a:	6a 19                	push   $0x19
  80130c:	e8 ff fc ff ff       	call   801010 <syscall>
  801311:	83 c4 18             	add    $0x18,%esp
}
  801314:	90                   	nop
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80131a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80131d:	8b 45 08             	mov    0x8(%ebp),%eax
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 00                	push   $0x0
  801326:	52                   	push   %edx
  801327:	50                   	push   %eax
  801328:	6a 1a                	push   $0x1a
  80132a:	e8 e1 fc ff ff       	call   801010 <syscall>
  80132f:	83 c4 18             	add    $0x18,%esp
}
  801332:	90                   	nop
  801333:	c9                   	leave  
  801334:	c3                   	ret    

00801335 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801335:	55                   	push   %ebp
  801336:	89 e5                	mov    %esp,%ebp
  801338:	83 ec 04             	sub    $0x4,%esp
  80133b:	8b 45 10             	mov    0x10(%ebp),%eax
  80133e:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801341:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801344:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801348:	8b 45 08             	mov    0x8(%ebp),%eax
  80134b:	6a 00                	push   $0x0
  80134d:	51                   	push   %ecx
  80134e:	52                   	push   %edx
  80134f:	ff 75 0c             	pushl  0xc(%ebp)
  801352:	50                   	push   %eax
  801353:	6a 1c                	push   $0x1c
  801355:	e8 b6 fc ff ff       	call   801010 <syscall>
  80135a:	83 c4 18             	add    $0x18,%esp
}
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801362:	8b 55 0c             	mov    0xc(%ebp),%edx
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 00                	push   $0x0
  80136e:	52                   	push   %edx
  80136f:	50                   	push   %eax
  801370:	6a 1d                	push   $0x1d
  801372:	e8 99 fc ff ff       	call   801010 <syscall>
  801377:	83 c4 18             	add    $0x18,%esp
}
  80137a:	c9                   	leave  
  80137b:	c3                   	ret    

0080137c <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80137c:	55                   	push   %ebp
  80137d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80137f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801382:	8b 55 0c             	mov    0xc(%ebp),%edx
  801385:	8b 45 08             	mov    0x8(%ebp),%eax
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	51                   	push   %ecx
  80138d:	52                   	push   %edx
  80138e:	50                   	push   %eax
  80138f:	6a 1e                	push   $0x1e
  801391:	e8 7a fc ff ff       	call   801010 <syscall>
  801396:	83 c4 18             	add    $0x18,%esp
}
  801399:	c9                   	leave  
  80139a:	c3                   	ret    

0080139b <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80139b:	55                   	push   %ebp
  80139c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80139e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a4:	6a 00                	push   $0x0
  8013a6:	6a 00                	push   $0x0
  8013a8:	6a 00                	push   $0x0
  8013aa:	52                   	push   %edx
  8013ab:	50                   	push   %eax
  8013ac:	6a 1f                	push   $0x1f
  8013ae:	e8 5d fc ff ff       	call   801010 <syscall>
  8013b3:	83 c4 18             	add    $0x18,%esp
}
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013bb:	6a 00                	push   $0x0
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	6a 20                	push   $0x20
  8013c7:	e8 44 fc ff ff       	call   801010 <syscall>
  8013cc:	83 c4 18             	add    $0x18,%esp
}
  8013cf:	c9                   	leave  
  8013d0:	c3                   	ret    

008013d1 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d7:	6a 00                	push   $0x0
  8013d9:	ff 75 14             	pushl  0x14(%ebp)
  8013dc:	ff 75 10             	pushl  0x10(%ebp)
  8013df:	ff 75 0c             	pushl  0xc(%ebp)
  8013e2:	50                   	push   %eax
  8013e3:	6a 21                	push   $0x21
  8013e5:	e8 26 fc ff ff       	call   801010 <syscall>
  8013ea:	83 c4 18             	add    $0x18,%esp
}
  8013ed:	c9                   	leave  
  8013ee:	c3                   	ret    

008013ef <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8013f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	6a 00                	push   $0x0
  8013fb:	6a 00                	push   $0x0
  8013fd:	50                   	push   %eax
  8013fe:	6a 22                	push   $0x22
  801400:	e8 0b fc ff ff       	call   801010 <syscall>
  801405:	83 c4 18             	add    $0x18,%esp
}
  801408:	90                   	nop
  801409:	c9                   	leave  
  80140a:	c3                   	ret    

0080140b <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80140b:	55                   	push   %ebp
  80140c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	50                   	push   %eax
  80141a:	6a 23                	push   $0x23
  80141c:	e8 ef fb ff ff       	call   801010 <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
}
  801424:	90                   	nop
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
  80142a:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80142d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801430:	8d 50 04             	lea    0x4(%eax),%edx
  801433:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801436:	6a 00                	push   $0x0
  801438:	6a 00                	push   $0x0
  80143a:	6a 00                	push   $0x0
  80143c:	52                   	push   %edx
  80143d:	50                   	push   %eax
  80143e:	6a 24                	push   $0x24
  801440:	e8 cb fb ff ff       	call   801010 <syscall>
  801445:	83 c4 18             	add    $0x18,%esp
	return result;
  801448:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80144b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80144e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801451:	89 01                	mov    %eax,(%ecx)
  801453:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	c9                   	leave  
  80145a:	c2 04 00             	ret    $0x4

0080145d <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80145d:	55                   	push   %ebp
  80145e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	ff 75 10             	pushl  0x10(%ebp)
  801467:	ff 75 0c             	pushl  0xc(%ebp)
  80146a:	ff 75 08             	pushl  0x8(%ebp)
  80146d:	6a 13                	push   $0x13
  80146f:	e8 9c fb ff ff       	call   801010 <syscall>
  801474:	83 c4 18             	add    $0x18,%esp
	return ;
  801477:	90                   	nop
}
  801478:	c9                   	leave  
  801479:	c3                   	ret    

0080147a <sys_rcr2>:
uint32 sys_rcr2()
{
  80147a:	55                   	push   %ebp
  80147b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 00                	push   $0x0
  801487:	6a 25                	push   $0x25
  801489:	e8 82 fb ff ff       	call   801010 <syscall>
  80148e:	83 c4 18             	add    $0x18,%esp
}
  801491:	c9                   	leave  
  801492:	c3                   	ret    

00801493 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801493:	55                   	push   %ebp
  801494:	89 e5                	mov    %esp,%ebp
  801496:	83 ec 04             	sub    $0x4,%esp
  801499:	8b 45 08             	mov    0x8(%ebp),%eax
  80149c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80149f:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014a3:	6a 00                	push   $0x0
  8014a5:	6a 00                	push   $0x0
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	50                   	push   %eax
  8014ac:	6a 26                	push   $0x26
  8014ae:	e8 5d fb ff ff       	call   801010 <syscall>
  8014b3:	83 c4 18             	add    $0x18,%esp
	return ;
  8014b6:	90                   	nop
}
  8014b7:	c9                   	leave  
  8014b8:	c3                   	ret    

008014b9 <rsttst>:
void rsttst()
{
  8014b9:	55                   	push   %ebp
  8014ba:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	6a 00                	push   $0x0
  8014c4:	6a 00                	push   $0x0
  8014c6:	6a 28                	push   $0x28
  8014c8:	e8 43 fb ff ff       	call   801010 <syscall>
  8014cd:	83 c4 18             	add    $0x18,%esp
	return ;
  8014d0:	90                   	nop
}
  8014d1:	c9                   	leave  
  8014d2:	c3                   	ret    

008014d3 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014d3:	55                   	push   %ebp
  8014d4:	89 e5                	mov    %esp,%ebp
  8014d6:	83 ec 04             	sub    $0x4,%esp
  8014d9:	8b 45 14             	mov    0x14(%ebp),%eax
  8014dc:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8014df:	8b 55 18             	mov    0x18(%ebp),%edx
  8014e2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014e6:	52                   	push   %edx
  8014e7:	50                   	push   %eax
  8014e8:	ff 75 10             	pushl  0x10(%ebp)
  8014eb:	ff 75 0c             	pushl  0xc(%ebp)
  8014ee:	ff 75 08             	pushl  0x8(%ebp)
  8014f1:	6a 27                	push   $0x27
  8014f3:	e8 18 fb ff ff       	call   801010 <syscall>
  8014f8:	83 c4 18             	add    $0x18,%esp
	return ;
  8014fb:	90                   	nop
}
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <chktst>:
void chktst(uint32 n)
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	6a 00                	push   $0x0
  801509:	ff 75 08             	pushl  0x8(%ebp)
  80150c:	6a 29                	push   $0x29
  80150e:	e8 fd fa ff ff       	call   801010 <syscall>
  801513:	83 c4 18             	add    $0x18,%esp
	return ;
  801516:	90                   	nop
}
  801517:	c9                   	leave  
  801518:	c3                   	ret    

00801519 <inctst>:

void inctst()
{
  801519:	55                   	push   %ebp
  80151a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80151c:	6a 00                	push   $0x0
  80151e:	6a 00                	push   $0x0
  801520:	6a 00                	push   $0x0
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 2a                	push   $0x2a
  801528:	e8 e3 fa ff ff       	call   801010 <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
	return ;
  801530:	90                   	nop
}
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <gettst>:
uint32 gettst()
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 2b                	push   $0x2b
  801542:	e8 c9 fa ff ff       	call   801010 <syscall>
  801547:	83 c4 18             	add    $0x18,%esp
}
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
  80154f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	6a 00                	push   $0x0
  80155c:	6a 2c                	push   $0x2c
  80155e:	e8 ad fa ff ff       	call   801010 <syscall>
  801563:	83 c4 18             	add    $0x18,%esp
  801566:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801569:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80156d:	75 07                	jne    801576 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80156f:	b8 01 00 00 00       	mov    $0x1,%eax
  801574:	eb 05                	jmp    80157b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801576:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
  801580:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 2c                	push   $0x2c
  80158f:	e8 7c fa ff ff       	call   801010 <syscall>
  801594:	83 c4 18             	add    $0x18,%esp
  801597:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80159a:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80159e:	75 07                	jne    8015a7 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015a0:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a5:	eb 05                	jmp    8015ac <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015a7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015ac:	c9                   	leave  
  8015ad:	c3                   	ret    

008015ae <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015ae:	55                   	push   %ebp
  8015af:	89 e5                	mov    %esp,%ebp
  8015b1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 00                	push   $0x0
  8015bc:	6a 00                	push   $0x0
  8015be:	6a 2c                	push   $0x2c
  8015c0:	e8 4b fa ff ff       	call   801010 <syscall>
  8015c5:	83 c4 18             	add    $0x18,%esp
  8015c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015cb:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015cf:	75 07                	jne    8015d8 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015d1:	b8 01 00 00 00       	mov    $0x1,%eax
  8015d6:	eb 05                	jmp    8015dd <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8015d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015dd:	c9                   	leave  
  8015de:	c3                   	ret    

008015df <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
  8015e2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 2c                	push   $0x2c
  8015f1:	e8 1a fa ff ff       	call   801010 <syscall>
  8015f6:	83 c4 18             	add    $0x18,%esp
  8015f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8015fc:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801600:	75 07                	jne    801609 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801602:	b8 01 00 00 00       	mov    $0x1,%eax
  801607:	eb 05                	jmp    80160e <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801609:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80160e:	c9                   	leave  
  80160f:	c3                   	ret    

00801610 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801610:	55                   	push   %ebp
  801611:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 00                	push   $0x0
  80161b:	ff 75 08             	pushl  0x8(%ebp)
  80161e:	6a 2d                	push   $0x2d
  801620:	e8 eb f9 ff ff       	call   801010 <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
	return ;
  801628:	90                   	nop
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
  80162e:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80162f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801632:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801635:	8b 55 0c             	mov    0xc(%ebp),%edx
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
  80163b:	6a 00                	push   $0x0
  80163d:	53                   	push   %ebx
  80163e:	51                   	push   %ecx
  80163f:	52                   	push   %edx
  801640:	50                   	push   %eax
  801641:	6a 2e                	push   $0x2e
  801643:	e8 c8 f9 ff ff       	call   801010 <syscall>
  801648:	83 c4 18             	add    $0x18,%esp
}
  80164b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80164e:	c9                   	leave  
  80164f:	c3                   	ret    

00801650 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801650:	55                   	push   %ebp
  801651:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801653:	8b 55 0c             	mov    0xc(%ebp),%edx
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	6a 00                	push   $0x0
  80165b:	6a 00                	push   $0x0
  80165d:	6a 00                	push   $0x0
  80165f:	52                   	push   %edx
  801660:	50                   	push   %eax
  801661:	6a 2f                	push   $0x2f
  801663:	e8 a8 f9 ff ff       	call   801010 <syscall>
  801668:	83 c4 18             	add    $0x18,%esp
}
  80166b:	c9                   	leave  
  80166c:	c3                   	ret    

0080166d <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80166d:	55                   	push   %ebp
  80166e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	ff 75 0c             	pushl  0xc(%ebp)
  801679:	ff 75 08             	pushl  0x8(%ebp)
  80167c:	6a 30                	push   $0x30
  80167e:	e8 8d f9 ff ff       	call   801010 <syscall>
  801683:	83 c4 18             	add    $0x18,%esp
	return ;
  801686:	90                   	nop
}
  801687:	c9                   	leave  
  801688:	c3                   	ret    
  801689:	66 90                	xchg   %ax,%ax
  80168b:	90                   	nop

0080168c <__udivdi3>:
  80168c:	55                   	push   %ebp
  80168d:	57                   	push   %edi
  80168e:	56                   	push   %esi
  80168f:	53                   	push   %ebx
  801690:	83 ec 1c             	sub    $0x1c,%esp
  801693:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801697:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80169b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80169f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016a3:	89 ca                	mov    %ecx,%edx
  8016a5:	89 f8                	mov    %edi,%eax
  8016a7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016ab:	85 f6                	test   %esi,%esi
  8016ad:	75 2d                	jne    8016dc <__udivdi3+0x50>
  8016af:	39 cf                	cmp    %ecx,%edi
  8016b1:	77 65                	ja     801718 <__udivdi3+0x8c>
  8016b3:	89 fd                	mov    %edi,%ebp
  8016b5:	85 ff                	test   %edi,%edi
  8016b7:	75 0b                	jne    8016c4 <__udivdi3+0x38>
  8016b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8016be:	31 d2                	xor    %edx,%edx
  8016c0:	f7 f7                	div    %edi
  8016c2:	89 c5                	mov    %eax,%ebp
  8016c4:	31 d2                	xor    %edx,%edx
  8016c6:	89 c8                	mov    %ecx,%eax
  8016c8:	f7 f5                	div    %ebp
  8016ca:	89 c1                	mov    %eax,%ecx
  8016cc:	89 d8                	mov    %ebx,%eax
  8016ce:	f7 f5                	div    %ebp
  8016d0:	89 cf                	mov    %ecx,%edi
  8016d2:	89 fa                	mov    %edi,%edx
  8016d4:	83 c4 1c             	add    $0x1c,%esp
  8016d7:	5b                   	pop    %ebx
  8016d8:	5e                   	pop    %esi
  8016d9:	5f                   	pop    %edi
  8016da:	5d                   	pop    %ebp
  8016db:	c3                   	ret    
  8016dc:	39 ce                	cmp    %ecx,%esi
  8016de:	77 28                	ja     801708 <__udivdi3+0x7c>
  8016e0:	0f bd fe             	bsr    %esi,%edi
  8016e3:	83 f7 1f             	xor    $0x1f,%edi
  8016e6:	75 40                	jne    801728 <__udivdi3+0x9c>
  8016e8:	39 ce                	cmp    %ecx,%esi
  8016ea:	72 0a                	jb     8016f6 <__udivdi3+0x6a>
  8016ec:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8016f0:	0f 87 9e 00 00 00    	ja     801794 <__udivdi3+0x108>
  8016f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8016fb:	89 fa                	mov    %edi,%edx
  8016fd:	83 c4 1c             	add    $0x1c,%esp
  801700:	5b                   	pop    %ebx
  801701:	5e                   	pop    %esi
  801702:	5f                   	pop    %edi
  801703:	5d                   	pop    %ebp
  801704:	c3                   	ret    
  801705:	8d 76 00             	lea    0x0(%esi),%esi
  801708:	31 ff                	xor    %edi,%edi
  80170a:	31 c0                	xor    %eax,%eax
  80170c:	89 fa                	mov    %edi,%edx
  80170e:	83 c4 1c             	add    $0x1c,%esp
  801711:	5b                   	pop    %ebx
  801712:	5e                   	pop    %esi
  801713:	5f                   	pop    %edi
  801714:	5d                   	pop    %ebp
  801715:	c3                   	ret    
  801716:	66 90                	xchg   %ax,%ax
  801718:	89 d8                	mov    %ebx,%eax
  80171a:	f7 f7                	div    %edi
  80171c:	31 ff                	xor    %edi,%edi
  80171e:	89 fa                	mov    %edi,%edx
  801720:	83 c4 1c             	add    $0x1c,%esp
  801723:	5b                   	pop    %ebx
  801724:	5e                   	pop    %esi
  801725:	5f                   	pop    %edi
  801726:	5d                   	pop    %ebp
  801727:	c3                   	ret    
  801728:	bd 20 00 00 00       	mov    $0x20,%ebp
  80172d:	89 eb                	mov    %ebp,%ebx
  80172f:	29 fb                	sub    %edi,%ebx
  801731:	89 f9                	mov    %edi,%ecx
  801733:	d3 e6                	shl    %cl,%esi
  801735:	89 c5                	mov    %eax,%ebp
  801737:	88 d9                	mov    %bl,%cl
  801739:	d3 ed                	shr    %cl,%ebp
  80173b:	89 e9                	mov    %ebp,%ecx
  80173d:	09 f1                	or     %esi,%ecx
  80173f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801743:	89 f9                	mov    %edi,%ecx
  801745:	d3 e0                	shl    %cl,%eax
  801747:	89 c5                	mov    %eax,%ebp
  801749:	89 d6                	mov    %edx,%esi
  80174b:	88 d9                	mov    %bl,%cl
  80174d:	d3 ee                	shr    %cl,%esi
  80174f:	89 f9                	mov    %edi,%ecx
  801751:	d3 e2                	shl    %cl,%edx
  801753:	8b 44 24 08          	mov    0x8(%esp),%eax
  801757:	88 d9                	mov    %bl,%cl
  801759:	d3 e8                	shr    %cl,%eax
  80175b:	09 c2                	or     %eax,%edx
  80175d:	89 d0                	mov    %edx,%eax
  80175f:	89 f2                	mov    %esi,%edx
  801761:	f7 74 24 0c          	divl   0xc(%esp)
  801765:	89 d6                	mov    %edx,%esi
  801767:	89 c3                	mov    %eax,%ebx
  801769:	f7 e5                	mul    %ebp
  80176b:	39 d6                	cmp    %edx,%esi
  80176d:	72 19                	jb     801788 <__udivdi3+0xfc>
  80176f:	74 0b                	je     80177c <__udivdi3+0xf0>
  801771:	89 d8                	mov    %ebx,%eax
  801773:	31 ff                	xor    %edi,%edi
  801775:	e9 58 ff ff ff       	jmp    8016d2 <__udivdi3+0x46>
  80177a:	66 90                	xchg   %ax,%ax
  80177c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801780:	89 f9                	mov    %edi,%ecx
  801782:	d3 e2                	shl    %cl,%edx
  801784:	39 c2                	cmp    %eax,%edx
  801786:	73 e9                	jae    801771 <__udivdi3+0xe5>
  801788:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80178b:	31 ff                	xor    %edi,%edi
  80178d:	e9 40 ff ff ff       	jmp    8016d2 <__udivdi3+0x46>
  801792:	66 90                	xchg   %ax,%ax
  801794:	31 c0                	xor    %eax,%eax
  801796:	e9 37 ff ff ff       	jmp    8016d2 <__udivdi3+0x46>
  80179b:	90                   	nop

0080179c <__umoddi3>:
  80179c:	55                   	push   %ebp
  80179d:	57                   	push   %edi
  80179e:	56                   	push   %esi
  80179f:	53                   	push   %ebx
  8017a0:	83 ec 1c             	sub    $0x1c,%esp
  8017a3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017a7:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017ab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017af:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017b3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017b7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017bb:	89 f3                	mov    %esi,%ebx
  8017bd:	89 fa                	mov    %edi,%edx
  8017bf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017c3:	89 34 24             	mov    %esi,(%esp)
  8017c6:	85 c0                	test   %eax,%eax
  8017c8:	75 1a                	jne    8017e4 <__umoddi3+0x48>
  8017ca:	39 f7                	cmp    %esi,%edi
  8017cc:	0f 86 a2 00 00 00    	jbe    801874 <__umoddi3+0xd8>
  8017d2:	89 c8                	mov    %ecx,%eax
  8017d4:	89 f2                	mov    %esi,%edx
  8017d6:	f7 f7                	div    %edi
  8017d8:	89 d0                	mov    %edx,%eax
  8017da:	31 d2                	xor    %edx,%edx
  8017dc:	83 c4 1c             	add    $0x1c,%esp
  8017df:	5b                   	pop    %ebx
  8017e0:	5e                   	pop    %esi
  8017e1:	5f                   	pop    %edi
  8017e2:	5d                   	pop    %ebp
  8017e3:	c3                   	ret    
  8017e4:	39 f0                	cmp    %esi,%eax
  8017e6:	0f 87 ac 00 00 00    	ja     801898 <__umoddi3+0xfc>
  8017ec:	0f bd e8             	bsr    %eax,%ebp
  8017ef:	83 f5 1f             	xor    $0x1f,%ebp
  8017f2:	0f 84 ac 00 00 00    	je     8018a4 <__umoddi3+0x108>
  8017f8:	bf 20 00 00 00       	mov    $0x20,%edi
  8017fd:	29 ef                	sub    %ebp,%edi
  8017ff:	89 fe                	mov    %edi,%esi
  801801:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801805:	89 e9                	mov    %ebp,%ecx
  801807:	d3 e0                	shl    %cl,%eax
  801809:	89 d7                	mov    %edx,%edi
  80180b:	89 f1                	mov    %esi,%ecx
  80180d:	d3 ef                	shr    %cl,%edi
  80180f:	09 c7                	or     %eax,%edi
  801811:	89 e9                	mov    %ebp,%ecx
  801813:	d3 e2                	shl    %cl,%edx
  801815:	89 14 24             	mov    %edx,(%esp)
  801818:	89 d8                	mov    %ebx,%eax
  80181a:	d3 e0                	shl    %cl,%eax
  80181c:	89 c2                	mov    %eax,%edx
  80181e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801822:	d3 e0                	shl    %cl,%eax
  801824:	89 44 24 04          	mov    %eax,0x4(%esp)
  801828:	8b 44 24 08          	mov    0x8(%esp),%eax
  80182c:	89 f1                	mov    %esi,%ecx
  80182e:	d3 e8                	shr    %cl,%eax
  801830:	09 d0                	or     %edx,%eax
  801832:	d3 eb                	shr    %cl,%ebx
  801834:	89 da                	mov    %ebx,%edx
  801836:	f7 f7                	div    %edi
  801838:	89 d3                	mov    %edx,%ebx
  80183a:	f7 24 24             	mull   (%esp)
  80183d:	89 c6                	mov    %eax,%esi
  80183f:	89 d1                	mov    %edx,%ecx
  801841:	39 d3                	cmp    %edx,%ebx
  801843:	0f 82 87 00 00 00    	jb     8018d0 <__umoddi3+0x134>
  801849:	0f 84 91 00 00 00    	je     8018e0 <__umoddi3+0x144>
  80184f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801853:	29 f2                	sub    %esi,%edx
  801855:	19 cb                	sbb    %ecx,%ebx
  801857:	89 d8                	mov    %ebx,%eax
  801859:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  80185d:	d3 e0                	shl    %cl,%eax
  80185f:	89 e9                	mov    %ebp,%ecx
  801861:	d3 ea                	shr    %cl,%edx
  801863:	09 d0                	or     %edx,%eax
  801865:	89 e9                	mov    %ebp,%ecx
  801867:	d3 eb                	shr    %cl,%ebx
  801869:	89 da                	mov    %ebx,%edx
  80186b:	83 c4 1c             	add    $0x1c,%esp
  80186e:	5b                   	pop    %ebx
  80186f:	5e                   	pop    %esi
  801870:	5f                   	pop    %edi
  801871:	5d                   	pop    %ebp
  801872:	c3                   	ret    
  801873:	90                   	nop
  801874:	89 fd                	mov    %edi,%ebp
  801876:	85 ff                	test   %edi,%edi
  801878:	75 0b                	jne    801885 <__umoddi3+0xe9>
  80187a:	b8 01 00 00 00       	mov    $0x1,%eax
  80187f:	31 d2                	xor    %edx,%edx
  801881:	f7 f7                	div    %edi
  801883:	89 c5                	mov    %eax,%ebp
  801885:	89 f0                	mov    %esi,%eax
  801887:	31 d2                	xor    %edx,%edx
  801889:	f7 f5                	div    %ebp
  80188b:	89 c8                	mov    %ecx,%eax
  80188d:	f7 f5                	div    %ebp
  80188f:	89 d0                	mov    %edx,%eax
  801891:	e9 44 ff ff ff       	jmp    8017da <__umoddi3+0x3e>
  801896:	66 90                	xchg   %ax,%ax
  801898:	89 c8                	mov    %ecx,%eax
  80189a:	89 f2                	mov    %esi,%edx
  80189c:	83 c4 1c             	add    $0x1c,%esp
  80189f:	5b                   	pop    %ebx
  8018a0:	5e                   	pop    %esi
  8018a1:	5f                   	pop    %edi
  8018a2:	5d                   	pop    %ebp
  8018a3:	c3                   	ret    
  8018a4:	3b 04 24             	cmp    (%esp),%eax
  8018a7:	72 06                	jb     8018af <__umoddi3+0x113>
  8018a9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018ad:	77 0f                	ja     8018be <__umoddi3+0x122>
  8018af:	89 f2                	mov    %esi,%edx
  8018b1:	29 f9                	sub    %edi,%ecx
  8018b3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018b7:	89 14 24             	mov    %edx,(%esp)
  8018ba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018be:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018c2:	8b 14 24             	mov    (%esp),%edx
  8018c5:	83 c4 1c             	add    $0x1c,%esp
  8018c8:	5b                   	pop    %ebx
  8018c9:	5e                   	pop    %esi
  8018ca:	5f                   	pop    %edi
  8018cb:	5d                   	pop    %ebp
  8018cc:	c3                   	ret    
  8018cd:	8d 76 00             	lea    0x0(%esi),%esi
  8018d0:	2b 04 24             	sub    (%esp),%eax
  8018d3:	19 fa                	sbb    %edi,%edx
  8018d5:	89 d1                	mov    %edx,%ecx
  8018d7:	89 c6                	mov    %eax,%esi
  8018d9:	e9 71 ff ff ff       	jmp    80184f <__umoddi3+0xb3>
  8018de:	66 90                	xchg   %ax,%ax
  8018e0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8018e4:	72 ea                	jb     8018d0 <__umoddi3+0x134>
  8018e6:	89 d9                	mov    %ebx,%ecx
  8018e8:	e9 62 ff ff ff       	jmp    80184f <__umoddi3+0xb3>
