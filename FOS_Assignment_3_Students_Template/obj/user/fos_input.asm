
obj/user/fos_input:     file format elf32-i386


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
  800031:	e8 a5 00 00 00       	call   8000db <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void
_main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 18 04 00 00    	sub    $0x418,%esp
	int i1=0;
  800041:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int i2=0;
  800048:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	char buff1[512];
	char buff2[512];


	atomic_readline("Please enter first number :", buff1);
  80004f:	83 ec 08             	sub    $0x8,%esp
  800052:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800058:	50                   	push   %eax
  800059:	68 a0 1c 80 00       	push   $0x801ca0
  80005e:	e8 e8 09 00 00       	call   800a4b <atomic_readline>
  800063:	83 c4 10             	add    $0x10,%esp
	i1 = strtol(buff1, NULL, 10);
  800066:	83 ec 04             	sub    $0x4,%esp
  800069:	6a 0a                	push   $0xa
  80006b:	6a 00                	push   $0x0
  80006d:	8d 85 f0 fd ff ff    	lea    -0x210(%ebp),%eax
  800073:	50                   	push   %eax
  800074:	e8 3a 0e 00 00       	call   800eb3 <strtol>
  800079:	83 c4 10             	add    $0x10,%esp
  80007c:	89 45 f4             	mov    %eax,-0xc(%ebp)

	//sleep
	env_sleep(2800);
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 f0 0a 00 00       	push   $0xaf0
  800087:	e8 48 18 00 00       	call   8018d4 <env_sleep>
  80008c:	83 c4 10             	add    $0x10,%esp

	atomic_readline("Please enter second number :", buff2);
  80008f:	83 ec 08             	sub    $0x8,%esp
  800092:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  800098:	50                   	push   %eax
  800099:	68 bc 1c 80 00       	push   $0x801cbc
  80009e:	e8 a8 09 00 00       	call   800a4b <atomic_readline>
  8000a3:	83 c4 10             	add    $0x10,%esp
	
	i2 = strtol(buff2, NULL, 10);
  8000a6:	83 ec 04             	sub    $0x4,%esp
  8000a9:	6a 0a                	push   $0xa
  8000ab:	6a 00                	push   $0x0
  8000ad:	8d 85 f0 fb ff ff    	lea    -0x410(%ebp),%eax
  8000b3:	50                   	push   %eax
  8000b4:	e8 fa 0d 00 00       	call   800eb3 <strtol>
  8000b9:	83 c4 10             	add    $0x10,%esp
  8000bc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	atomic_cprintf("number 1 + number 2 = %d\n",i1+i2);
  8000bf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c5:	01 d0                	add    %edx,%eax
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	50                   	push   %eax
  8000cb:	68 d9 1c 80 00       	push   $0x801cd9
  8000d0:	e8 23 02 00 00       	call   8002f8 <atomic_cprintf>
  8000d5:	83 c4 10             	add    $0x10,%esp
	return;	
  8000d8:	90                   	nop
}
  8000d9:	c9                   	leave  
  8000da:	c3                   	ret    

008000db <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000db:	55                   	push   %ebp
  8000dc:	89 e5                	mov    %esp,%ebp
  8000de:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000e1:	e8 16 12 00 00       	call   8012fc <sys_getenvindex>
  8000e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000ec:	89 d0                	mov    %edx,%eax
  8000ee:	01 c0                	add    %eax,%eax
  8000f0:	01 d0                	add    %edx,%eax
  8000f2:	c1 e0 04             	shl    $0x4,%eax
  8000f5:	29 d0                	sub    %edx,%eax
  8000f7:	c1 e0 03             	shl    $0x3,%eax
  8000fa:	01 d0                	add    %edx,%eax
  8000fc:	c1 e0 02             	shl    $0x2,%eax
  8000ff:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800104:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800109:	a1 20 30 80 00       	mov    0x803020,%eax
  80010e:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800114:	84 c0                	test   %al,%al
  800116:	74 0f                	je     800127 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800118:	a1 20 30 80 00       	mov    0x803020,%eax
  80011d:	05 5c 05 00 00       	add    $0x55c,%eax
  800122:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800127:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80012b:	7e 0a                	jle    800137 <libmain+0x5c>
		binaryname = argv[0];
  80012d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800130:	8b 00                	mov    (%eax),%eax
  800132:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800137:	83 ec 08             	sub    $0x8,%esp
  80013a:	ff 75 0c             	pushl  0xc(%ebp)
  80013d:	ff 75 08             	pushl  0x8(%ebp)
  800140:	e8 f3 fe ff ff       	call   800038 <_main>
  800145:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800148:	e8 4a 13 00 00       	call   801497 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	68 0c 1d 80 00       	push   $0x801d0c
  800155:	e8 71 01 00 00       	call   8002cb <cprintf>
  80015a:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80015d:	a1 20 30 80 00       	mov    0x803020,%eax
  800162:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800168:	a1 20 30 80 00       	mov    0x803020,%eax
  80016d:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800173:	83 ec 04             	sub    $0x4,%esp
  800176:	52                   	push   %edx
  800177:	50                   	push   %eax
  800178:	68 34 1d 80 00       	push   $0x801d34
  80017d:	e8 49 01 00 00       	call   8002cb <cprintf>
  800182:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800190:	a1 20 30 80 00       	mov    0x803020,%eax
  800195:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  80019b:	a1 20 30 80 00       	mov    0x803020,%eax
  8001a0:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8001a6:	51                   	push   %ecx
  8001a7:	52                   	push   %edx
  8001a8:	50                   	push   %eax
  8001a9:	68 5c 1d 80 00       	push   $0x801d5c
  8001ae:	e8 18 01 00 00       	call   8002cb <cprintf>
  8001b3:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001b6:	83 ec 0c             	sub    $0xc,%esp
  8001b9:	68 0c 1d 80 00       	push   $0x801d0c
  8001be:	e8 08 01 00 00       	call   8002cb <cprintf>
  8001c3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001c6:	e8 e6 12 00 00       	call   8014b1 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001cb:	e8 19 00 00 00       	call   8001e9 <exit>
}
  8001d0:	90                   	nop
  8001d1:	c9                   	leave  
  8001d2:	c3                   	ret    

008001d3 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001d3:	55                   	push   %ebp
  8001d4:	89 e5                	mov    %esp,%ebp
  8001d6:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001d9:	83 ec 0c             	sub    $0xc,%esp
  8001dc:	6a 00                	push   $0x0
  8001de:	e8 e5 10 00 00       	call   8012c8 <sys_env_destroy>
  8001e3:	83 c4 10             	add    $0x10,%esp
}
  8001e6:	90                   	nop
  8001e7:	c9                   	leave  
  8001e8:	c3                   	ret    

008001e9 <exit>:

void
exit(void)
{
  8001e9:	55                   	push   %ebp
  8001ea:	89 e5                	mov    %esp,%ebp
  8001ec:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001ef:	e8 3a 11 00 00       	call   80132e <sys_env_exit>
}
  8001f4:	90                   	nop
  8001f5:	c9                   	leave  
  8001f6:	c3                   	ret    

008001f7 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001f7:	55                   	push   %ebp
  8001f8:	89 e5                	mov    %esp,%ebp
  8001fa:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800200:	8b 00                	mov    (%eax),%eax
  800202:	8d 48 01             	lea    0x1(%eax),%ecx
  800205:	8b 55 0c             	mov    0xc(%ebp),%edx
  800208:	89 0a                	mov    %ecx,(%edx)
  80020a:	8b 55 08             	mov    0x8(%ebp),%edx
  80020d:	88 d1                	mov    %dl,%cl
  80020f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800212:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800216:	8b 45 0c             	mov    0xc(%ebp),%eax
  800219:	8b 00                	mov    (%eax),%eax
  80021b:	3d ff 00 00 00       	cmp    $0xff,%eax
  800220:	75 2c                	jne    80024e <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800222:	a0 24 30 80 00       	mov    0x803024,%al
  800227:	0f b6 c0             	movzbl %al,%eax
  80022a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80022d:	8b 12                	mov    (%edx),%edx
  80022f:	89 d1                	mov    %edx,%ecx
  800231:	8b 55 0c             	mov    0xc(%ebp),%edx
  800234:	83 c2 08             	add    $0x8,%edx
  800237:	83 ec 04             	sub    $0x4,%esp
  80023a:	50                   	push   %eax
  80023b:	51                   	push   %ecx
  80023c:	52                   	push   %edx
  80023d:	e8 44 10 00 00       	call   801286 <sys_cputs>
  800242:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800245:	8b 45 0c             	mov    0xc(%ebp),%eax
  800248:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80024e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800251:	8b 40 04             	mov    0x4(%eax),%eax
  800254:	8d 50 01             	lea    0x1(%eax),%edx
  800257:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025a:	89 50 04             	mov    %edx,0x4(%eax)
}
  80025d:	90                   	nop
  80025e:	c9                   	leave  
  80025f:	c3                   	ret    

00800260 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800260:	55                   	push   %ebp
  800261:	89 e5                	mov    %esp,%ebp
  800263:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800269:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800270:	00 00 00 
	b.cnt = 0;
  800273:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80027a:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80027d:	ff 75 0c             	pushl  0xc(%ebp)
  800280:	ff 75 08             	pushl  0x8(%ebp)
  800283:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800289:	50                   	push   %eax
  80028a:	68 f7 01 80 00       	push   $0x8001f7
  80028f:	e8 11 02 00 00       	call   8004a5 <vprintfmt>
  800294:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800297:	a0 24 30 80 00       	mov    0x803024,%al
  80029c:	0f b6 c0             	movzbl %al,%eax
  80029f:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8002a5:	83 ec 04             	sub    $0x4,%esp
  8002a8:	50                   	push   %eax
  8002a9:	52                   	push   %edx
  8002aa:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002b0:	83 c0 08             	add    $0x8,%eax
  8002b3:	50                   	push   %eax
  8002b4:	e8 cd 0f 00 00       	call   801286 <sys_cputs>
  8002b9:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002bc:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8002c3:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002c9:	c9                   	leave  
  8002ca:	c3                   	ret    

008002cb <cprintf>:

int cprintf(const char *fmt, ...) {
  8002cb:	55                   	push   %ebp
  8002cc:	89 e5                	mov    %esp,%ebp
  8002ce:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002d1:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8002d8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002de:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e1:	83 ec 08             	sub    $0x8,%esp
  8002e4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002e7:	50                   	push   %eax
  8002e8:	e8 73 ff ff ff       	call   800260 <vcprintf>
  8002ed:	83 c4 10             	add    $0x10,%esp
  8002f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002f6:	c9                   	leave  
  8002f7:	c3                   	ret    

008002f8 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002f8:	55                   	push   %ebp
  8002f9:	89 e5                	mov    %esp,%ebp
  8002fb:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002fe:	e8 94 11 00 00       	call   801497 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800303:	8d 45 0c             	lea    0xc(%ebp),%eax
  800306:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800309:	8b 45 08             	mov    0x8(%ebp),%eax
  80030c:	83 ec 08             	sub    $0x8,%esp
  80030f:	ff 75 f4             	pushl  -0xc(%ebp)
  800312:	50                   	push   %eax
  800313:	e8 48 ff ff ff       	call   800260 <vcprintf>
  800318:	83 c4 10             	add    $0x10,%esp
  80031b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80031e:	e8 8e 11 00 00       	call   8014b1 <sys_enable_interrupt>
	return cnt;
  800323:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800326:	c9                   	leave  
  800327:	c3                   	ret    

00800328 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800328:	55                   	push   %ebp
  800329:	89 e5                	mov    %esp,%ebp
  80032b:	53                   	push   %ebx
  80032c:	83 ec 14             	sub    $0x14,%esp
  80032f:	8b 45 10             	mov    0x10(%ebp),%eax
  800332:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800335:	8b 45 14             	mov    0x14(%ebp),%eax
  800338:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80033b:	8b 45 18             	mov    0x18(%ebp),%eax
  80033e:	ba 00 00 00 00       	mov    $0x0,%edx
  800343:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800346:	77 55                	ja     80039d <printnum+0x75>
  800348:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80034b:	72 05                	jb     800352 <printnum+0x2a>
  80034d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800350:	77 4b                	ja     80039d <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800352:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800355:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800358:	8b 45 18             	mov    0x18(%ebp),%eax
  80035b:	ba 00 00 00 00       	mov    $0x0,%edx
  800360:	52                   	push   %edx
  800361:	50                   	push   %eax
  800362:	ff 75 f4             	pushl  -0xc(%ebp)
  800365:	ff 75 f0             	pushl  -0x10(%ebp)
  800368:	e8 bb 16 00 00       	call   801a28 <__udivdi3>
  80036d:	83 c4 10             	add    $0x10,%esp
  800370:	83 ec 04             	sub    $0x4,%esp
  800373:	ff 75 20             	pushl  0x20(%ebp)
  800376:	53                   	push   %ebx
  800377:	ff 75 18             	pushl  0x18(%ebp)
  80037a:	52                   	push   %edx
  80037b:	50                   	push   %eax
  80037c:	ff 75 0c             	pushl  0xc(%ebp)
  80037f:	ff 75 08             	pushl  0x8(%ebp)
  800382:	e8 a1 ff ff ff       	call   800328 <printnum>
  800387:	83 c4 20             	add    $0x20,%esp
  80038a:	eb 1a                	jmp    8003a6 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80038c:	83 ec 08             	sub    $0x8,%esp
  80038f:	ff 75 0c             	pushl  0xc(%ebp)
  800392:	ff 75 20             	pushl  0x20(%ebp)
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	ff d0                	call   *%eax
  80039a:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80039d:	ff 4d 1c             	decl   0x1c(%ebp)
  8003a0:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8003a4:	7f e6                	jg     80038c <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8003a6:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8003a9:	bb 00 00 00 00       	mov    $0x0,%ebx
  8003ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8003b4:	53                   	push   %ebx
  8003b5:	51                   	push   %ecx
  8003b6:	52                   	push   %edx
  8003b7:	50                   	push   %eax
  8003b8:	e8 7b 17 00 00       	call   801b38 <__umoddi3>
  8003bd:	83 c4 10             	add    $0x10,%esp
  8003c0:	05 d4 1f 80 00       	add    $0x801fd4,%eax
  8003c5:	8a 00                	mov    (%eax),%al
  8003c7:	0f be c0             	movsbl %al,%eax
  8003ca:	83 ec 08             	sub    $0x8,%esp
  8003cd:	ff 75 0c             	pushl  0xc(%ebp)
  8003d0:	50                   	push   %eax
  8003d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d4:	ff d0                	call   *%eax
  8003d6:	83 c4 10             	add    $0x10,%esp
}
  8003d9:	90                   	nop
  8003da:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003dd:	c9                   	leave  
  8003de:	c3                   	ret    

008003df <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003df:	55                   	push   %ebp
  8003e0:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003e2:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003e6:	7e 1c                	jle    800404 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003eb:	8b 00                	mov    (%eax),%eax
  8003ed:	8d 50 08             	lea    0x8(%eax),%edx
  8003f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f3:	89 10                	mov    %edx,(%eax)
  8003f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f8:	8b 00                	mov    (%eax),%eax
  8003fa:	83 e8 08             	sub    $0x8,%eax
  8003fd:	8b 50 04             	mov    0x4(%eax),%edx
  800400:	8b 00                	mov    (%eax),%eax
  800402:	eb 40                	jmp    800444 <getuint+0x65>
	else if (lflag)
  800404:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800408:	74 1e                	je     800428 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80040a:	8b 45 08             	mov    0x8(%ebp),%eax
  80040d:	8b 00                	mov    (%eax),%eax
  80040f:	8d 50 04             	lea    0x4(%eax),%edx
  800412:	8b 45 08             	mov    0x8(%ebp),%eax
  800415:	89 10                	mov    %edx,(%eax)
  800417:	8b 45 08             	mov    0x8(%ebp),%eax
  80041a:	8b 00                	mov    (%eax),%eax
  80041c:	83 e8 04             	sub    $0x4,%eax
  80041f:	8b 00                	mov    (%eax),%eax
  800421:	ba 00 00 00 00       	mov    $0x0,%edx
  800426:	eb 1c                	jmp    800444 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800428:	8b 45 08             	mov    0x8(%ebp),%eax
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	8d 50 04             	lea    0x4(%eax),%edx
  800430:	8b 45 08             	mov    0x8(%ebp),%eax
  800433:	89 10                	mov    %edx,(%eax)
  800435:	8b 45 08             	mov    0x8(%ebp),%eax
  800438:	8b 00                	mov    (%eax),%eax
  80043a:	83 e8 04             	sub    $0x4,%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800444:	5d                   	pop    %ebp
  800445:	c3                   	ret    

00800446 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800446:	55                   	push   %ebp
  800447:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800449:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80044d:	7e 1c                	jle    80046b <getint+0x25>
		return va_arg(*ap, long long);
  80044f:	8b 45 08             	mov    0x8(%ebp),%eax
  800452:	8b 00                	mov    (%eax),%eax
  800454:	8d 50 08             	lea    0x8(%eax),%edx
  800457:	8b 45 08             	mov    0x8(%ebp),%eax
  80045a:	89 10                	mov    %edx,(%eax)
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	8b 00                	mov    (%eax),%eax
  800461:	83 e8 08             	sub    $0x8,%eax
  800464:	8b 50 04             	mov    0x4(%eax),%edx
  800467:	8b 00                	mov    (%eax),%eax
  800469:	eb 38                	jmp    8004a3 <getint+0x5d>
	else if (lflag)
  80046b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80046f:	74 1a                	je     80048b <getint+0x45>
		return va_arg(*ap, long);
  800471:	8b 45 08             	mov    0x8(%ebp),%eax
  800474:	8b 00                	mov    (%eax),%eax
  800476:	8d 50 04             	lea    0x4(%eax),%edx
  800479:	8b 45 08             	mov    0x8(%ebp),%eax
  80047c:	89 10                	mov    %edx,(%eax)
  80047e:	8b 45 08             	mov    0x8(%ebp),%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	83 e8 04             	sub    $0x4,%eax
  800486:	8b 00                	mov    (%eax),%eax
  800488:	99                   	cltd   
  800489:	eb 18                	jmp    8004a3 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80048b:	8b 45 08             	mov    0x8(%ebp),%eax
  80048e:	8b 00                	mov    (%eax),%eax
  800490:	8d 50 04             	lea    0x4(%eax),%edx
  800493:	8b 45 08             	mov    0x8(%ebp),%eax
  800496:	89 10                	mov    %edx,(%eax)
  800498:	8b 45 08             	mov    0x8(%ebp),%eax
  80049b:	8b 00                	mov    (%eax),%eax
  80049d:	83 e8 04             	sub    $0x4,%eax
  8004a0:	8b 00                	mov    (%eax),%eax
  8004a2:	99                   	cltd   
}
  8004a3:	5d                   	pop    %ebp
  8004a4:	c3                   	ret    

008004a5 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8004a5:	55                   	push   %ebp
  8004a6:	89 e5                	mov    %esp,%ebp
  8004a8:	56                   	push   %esi
  8004a9:	53                   	push   %ebx
  8004aa:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ad:	eb 17                	jmp    8004c6 <vprintfmt+0x21>
			if (ch == '\0')
  8004af:	85 db                	test   %ebx,%ebx
  8004b1:	0f 84 af 03 00 00    	je     800866 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8004b7:	83 ec 08             	sub    $0x8,%esp
  8004ba:	ff 75 0c             	pushl  0xc(%ebp)
  8004bd:	53                   	push   %ebx
  8004be:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c1:	ff d0                	call   *%eax
  8004c3:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004c6:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c9:	8d 50 01             	lea    0x1(%eax),%edx
  8004cc:	89 55 10             	mov    %edx,0x10(%ebp)
  8004cf:	8a 00                	mov    (%eax),%al
  8004d1:	0f b6 d8             	movzbl %al,%ebx
  8004d4:	83 fb 25             	cmp    $0x25,%ebx
  8004d7:	75 d6                	jne    8004af <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004d9:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004dd:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004e4:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004eb:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004f2:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8004fc:	8d 50 01             	lea    0x1(%eax),%edx
  8004ff:	89 55 10             	mov    %edx,0x10(%ebp)
  800502:	8a 00                	mov    (%eax),%al
  800504:	0f b6 d8             	movzbl %al,%ebx
  800507:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80050a:	83 f8 55             	cmp    $0x55,%eax
  80050d:	0f 87 2b 03 00 00    	ja     80083e <vprintfmt+0x399>
  800513:	8b 04 85 f8 1f 80 00 	mov    0x801ff8(,%eax,4),%eax
  80051a:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80051c:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800520:	eb d7                	jmp    8004f9 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800522:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800526:	eb d1                	jmp    8004f9 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800528:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80052f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800532:	89 d0                	mov    %edx,%eax
  800534:	c1 e0 02             	shl    $0x2,%eax
  800537:	01 d0                	add    %edx,%eax
  800539:	01 c0                	add    %eax,%eax
  80053b:	01 d8                	add    %ebx,%eax
  80053d:	83 e8 30             	sub    $0x30,%eax
  800540:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800543:	8b 45 10             	mov    0x10(%ebp),%eax
  800546:	8a 00                	mov    (%eax),%al
  800548:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80054b:	83 fb 2f             	cmp    $0x2f,%ebx
  80054e:	7e 3e                	jle    80058e <vprintfmt+0xe9>
  800550:	83 fb 39             	cmp    $0x39,%ebx
  800553:	7f 39                	jg     80058e <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800555:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800558:	eb d5                	jmp    80052f <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80055a:	8b 45 14             	mov    0x14(%ebp),%eax
  80055d:	83 c0 04             	add    $0x4,%eax
  800560:	89 45 14             	mov    %eax,0x14(%ebp)
  800563:	8b 45 14             	mov    0x14(%ebp),%eax
  800566:	83 e8 04             	sub    $0x4,%eax
  800569:	8b 00                	mov    (%eax),%eax
  80056b:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80056e:	eb 1f                	jmp    80058f <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800570:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800574:	79 83                	jns    8004f9 <vprintfmt+0x54>
				width = 0;
  800576:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80057d:	e9 77 ff ff ff       	jmp    8004f9 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800582:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800589:	e9 6b ff ff ff       	jmp    8004f9 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  80058e:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  80058f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800593:	0f 89 60 ff ff ff    	jns    8004f9 <vprintfmt+0x54>
				width = precision, precision = -1;
  800599:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80059c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80059f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8005a6:	e9 4e ff ff ff       	jmp    8004f9 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8005ab:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8005ae:	e9 46 ff ff ff       	jmp    8004f9 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8005b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8005b6:	83 c0 04             	add    $0x4,%eax
  8005b9:	89 45 14             	mov    %eax,0x14(%ebp)
  8005bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8005bf:	83 e8 04             	sub    $0x4,%eax
  8005c2:	8b 00                	mov    (%eax),%eax
  8005c4:	83 ec 08             	sub    $0x8,%esp
  8005c7:	ff 75 0c             	pushl  0xc(%ebp)
  8005ca:	50                   	push   %eax
  8005cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ce:	ff d0                	call   *%eax
  8005d0:	83 c4 10             	add    $0x10,%esp
			break;
  8005d3:	e9 89 02 00 00       	jmp    800861 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005d8:	8b 45 14             	mov    0x14(%ebp),%eax
  8005db:	83 c0 04             	add    $0x4,%eax
  8005de:	89 45 14             	mov    %eax,0x14(%ebp)
  8005e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005e4:	83 e8 04             	sub    $0x4,%eax
  8005e7:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005e9:	85 db                	test   %ebx,%ebx
  8005eb:	79 02                	jns    8005ef <vprintfmt+0x14a>
				err = -err;
  8005ed:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005ef:	83 fb 64             	cmp    $0x64,%ebx
  8005f2:	7f 0b                	jg     8005ff <vprintfmt+0x15a>
  8005f4:	8b 34 9d 40 1e 80 00 	mov    0x801e40(,%ebx,4),%esi
  8005fb:	85 f6                	test   %esi,%esi
  8005fd:	75 19                	jne    800618 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005ff:	53                   	push   %ebx
  800600:	68 e5 1f 80 00       	push   $0x801fe5
  800605:	ff 75 0c             	pushl  0xc(%ebp)
  800608:	ff 75 08             	pushl  0x8(%ebp)
  80060b:	e8 5e 02 00 00       	call   80086e <printfmt>
  800610:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800613:	e9 49 02 00 00       	jmp    800861 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800618:	56                   	push   %esi
  800619:	68 ee 1f 80 00       	push   $0x801fee
  80061e:	ff 75 0c             	pushl  0xc(%ebp)
  800621:	ff 75 08             	pushl  0x8(%ebp)
  800624:	e8 45 02 00 00       	call   80086e <printfmt>
  800629:	83 c4 10             	add    $0x10,%esp
			break;
  80062c:	e9 30 02 00 00       	jmp    800861 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800631:	8b 45 14             	mov    0x14(%ebp),%eax
  800634:	83 c0 04             	add    $0x4,%eax
  800637:	89 45 14             	mov    %eax,0x14(%ebp)
  80063a:	8b 45 14             	mov    0x14(%ebp),%eax
  80063d:	83 e8 04             	sub    $0x4,%eax
  800640:	8b 30                	mov    (%eax),%esi
  800642:	85 f6                	test   %esi,%esi
  800644:	75 05                	jne    80064b <vprintfmt+0x1a6>
				p = "(null)";
  800646:	be f1 1f 80 00       	mov    $0x801ff1,%esi
			if (width > 0 && padc != '-')
  80064b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80064f:	7e 6d                	jle    8006be <vprintfmt+0x219>
  800651:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800655:	74 67                	je     8006be <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800657:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80065a:	83 ec 08             	sub    $0x8,%esp
  80065d:	50                   	push   %eax
  80065e:	56                   	push   %esi
  80065f:	e8 12 05 00 00       	call   800b76 <strnlen>
  800664:	83 c4 10             	add    $0x10,%esp
  800667:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80066a:	eb 16                	jmp    800682 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80066c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800670:	83 ec 08             	sub    $0x8,%esp
  800673:	ff 75 0c             	pushl  0xc(%ebp)
  800676:	50                   	push   %eax
  800677:	8b 45 08             	mov    0x8(%ebp),%eax
  80067a:	ff d0                	call   *%eax
  80067c:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  80067f:	ff 4d e4             	decl   -0x1c(%ebp)
  800682:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800686:	7f e4                	jg     80066c <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800688:	eb 34                	jmp    8006be <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80068a:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  80068e:	74 1c                	je     8006ac <vprintfmt+0x207>
  800690:	83 fb 1f             	cmp    $0x1f,%ebx
  800693:	7e 05                	jle    80069a <vprintfmt+0x1f5>
  800695:	83 fb 7e             	cmp    $0x7e,%ebx
  800698:	7e 12                	jle    8006ac <vprintfmt+0x207>
					putch('?', putdat);
  80069a:	83 ec 08             	sub    $0x8,%esp
  80069d:	ff 75 0c             	pushl  0xc(%ebp)
  8006a0:	6a 3f                	push   $0x3f
  8006a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a5:	ff d0                	call   *%eax
  8006a7:	83 c4 10             	add    $0x10,%esp
  8006aa:	eb 0f                	jmp    8006bb <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8006ac:	83 ec 08             	sub    $0x8,%esp
  8006af:	ff 75 0c             	pushl  0xc(%ebp)
  8006b2:	53                   	push   %ebx
  8006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b6:	ff d0                	call   *%eax
  8006b8:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006bb:	ff 4d e4             	decl   -0x1c(%ebp)
  8006be:	89 f0                	mov    %esi,%eax
  8006c0:	8d 70 01             	lea    0x1(%eax),%esi
  8006c3:	8a 00                	mov    (%eax),%al
  8006c5:	0f be d8             	movsbl %al,%ebx
  8006c8:	85 db                	test   %ebx,%ebx
  8006ca:	74 24                	je     8006f0 <vprintfmt+0x24b>
  8006cc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d0:	78 b8                	js     80068a <vprintfmt+0x1e5>
  8006d2:	ff 4d e0             	decl   -0x20(%ebp)
  8006d5:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006d9:	79 af                	jns    80068a <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006db:	eb 13                	jmp    8006f0 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006dd:	83 ec 08             	sub    $0x8,%esp
  8006e0:	ff 75 0c             	pushl  0xc(%ebp)
  8006e3:	6a 20                	push   $0x20
  8006e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e8:	ff d0                	call   *%eax
  8006ea:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006ed:	ff 4d e4             	decl   -0x1c(%ebp)
  8006f0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006f4:	7f e7                	jg     8006dd <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006f6:	e9 66 01 00 00       	jmp    800861 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006fb:	83 ec 08             	sub    $0x8,%esp
  8006fe:	ff 75 e8             	pushl  -0x18(%ebp)
  800701:	8d 45 14             	lea    0x14(%ebp),%eax
  800704:	50                   	push   %eax
  800705:	e8 3c fd ff ff       	call   800446 <getint>
  80070a:	83 c4 10             	add    $0x10,%esp
  80070d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800710:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800713:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800716:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800719:	85 d2                	test   %edx,%edx
  80071b:	79 23                	jns    800740 <vprintfmt+0x29b>
				putch('-', putdat);
  80071d:	83 ec 08             	sub    $0x8,%esp
  800720:	ff 75 0c             	pushl  0xc(%ebp)
  800723:	6a 2d                	push   $0x2d
  800725:	8b 45 08             	mov    0x8(%ebp),%eax
  800728:	ff d0                	call   *%eax
  80072a:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80072d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800730:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800733:	f7 d8                	neg    %eax
  800735:	83 d2 00             	adc    $0x0,%edx
  800738:	f7 da                	neg    %edx
  80073a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80073d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800740:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800747:	e9 bc 00 00 00       	jmp    800808 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80074c:	83 ec 08             	sub    $0x8,%esp
  80074f:	ff 75 e8             	pushl  -0x18(%ebp)
  800752:	8d 45 14             	lea    0x14(%ebp),%eax
  800755:	50                   	push   %eax
  800756:	e8 84 fc ff ff       	call   8003df <getuint>
  80075b:	83 c4 10             	add    $0x10,%esp
  80075e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800761:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800764:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80076b:	e9 98 00 00 00       	jmp    800808 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
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
			putch('X', putdat);
  800790:	83 ec 08             	sub    $0x8,%esp
  800793:	ff 75 0c             	pushl  0xc(%ebp)
  800796:	6a 58                	push   $0x58
  800798:	8b 45 08             	mov    0x8(%ebp),%eax
  80079b:	ff d0                	call   *%eax
  80079d:	83 c4 10             	add    $0x10,%esp
			break;
  8007a0:	e9 bc 00 00 00       	jmp    800861 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8007a5:	83 ec 08             	sub    $0x8,%esp
  8007a8:	ff 75 0c             	pushl  0xc(%ebp)
  8007ab:	6a 30                	push   $0x30
  8007ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b0:	ff d0                	call   *%eax
  8007b2:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8007b5:	83 ec 08             	sub    $0x8,%esp
  8007b8:	ff 75 0c             	pushl  0xc(%ebp)
  8007bb:	6a 78                	push   $0x78
  8007bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c0:	ff d0                	call   *%eax
  8007c2:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007c5:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c8:	83 c0 04             	add    $0x4,%eax
  8007cb:	89 45 14             	mov    %eax,0x14(%ebp)
  8007ce:	8b 45 14             	mov    0x14(%ebp),%eax
  8007d1:	83 e8 04             	sub    $0x4,%eax
  8007d4:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007e0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007e7:	eb 1f                	jmp    800808 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007e9:	83 ec 08             	sub    $0x8,%esp
  8007ec:	ff 75 e8             	pushl  -0x18(%ebp)
  8007ef:	8d 45 14             	lea    0x14(%ebp),%eax
  8007f2:	50                   	push   %eax
  8007f3:	e8 e7 fb ff ff       	call   8003df <getuint>
  8007f8:	83 c4 10             	add    $0x10,%esp
  8007fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800801:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800808:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80080c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80080f:	83 ec 04             	sub    $0x4,%esp
  800812:	52                   	push   %edx
  800813:	ff 75 e4             	pushl  -0x1c(%ebp)
  800816:	50                   	push   %eax
  800817:	ff 75 f4             	pushl  -0xc(%ebp)
  80081a:	ff 75 f0             	pushl  -0x10(%ebp)
  80081d:	ff 75 0c             	pushl  0xc(%ebp)
  800820:	ff 75 08             	pushl  0x8(%ebp)
  800823:	e8 00 fb ff ff       	call   800328 <printnum>
  800828:	83 c4 20             	add    $0x20,%esp
			break;
  80082b:	eb 34                	jmp    800861 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80082d:	83 ec 08             	sub    $0x8,%esp
  800830:	ff 75 0c             	pushl  0xc(%ebp)
  800833:	53                   	push   %ebx
  800834:	8b 45 08             	mov    0x8(%ebp),%eax
  800837:	ff d0                	call   *%eax
  800839:	83 c4 10             	add    $0x10,%esp
			break;
  80083c:	eb 23                	jmp    800861 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80083e:	83 ec 08             	sub    $0x8,%esp
  800841:	ff 75 0c             	pushl  0xc(%ebp)
  800844:	6a 25                	push   $0x25
  800846:	8b 45 08             	mov    0x8(%ebp),%eax
  800849:	ff d0                	call   *%eax
  80084b:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80084e:	ff 4d 10             	decl   0x10(%ebp)
  800851:	eb 03                	jmp    800856 <vprintfmt+0x3b1>
  800853:	ff 4d 10             	decl   0x10(%ebp)
  800856:	8b 45 10             	mov    0x10(%ebp),%eax
  800859:	48                   	dec    %eax
  80085a:	8a 00                	mov    (%eax),%al
  80085c:	3c 25                	cmp    $0x25,%al
  80085e:	75 f3                	jne    800853 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800860:	90                   	nop
		}
	}
  800861:	e9 47 fc ff ff       	jmp    8004ad <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800866:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800867:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80086a:	5b                   	pop    %ebx
  80086b:	5e                   	pop    %esi
  80086c:	5d                   	pop    %ebp
  80086d:	c3                   	ret    

0080086e <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80086e:	55                   	push   %ebp
  80086f:	89 e5                	mov    %esp,%ebp
  800871:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800874:	8d 45 10             	lea    0x10(%ebp),%eax
  800877:	83 c0 04             	add    $0x4,%eax
  80087a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80087d:	8b 45 10             	mov    0x10(%ebp),%eax
  800880:	ff 75 f4             	pushl  -0xc(%ebp)
  800883:	50                   	push   %eax
  800884:	ff 75 0c             	pushl  0xc(%ebp)
  800887:	ff 75 08             	pushl  0x8(%ebp)
  80088a:	e8 16 fc ff ff       	call   8004a5 <vprintfmt>
  80088f:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800892:	90                   	nop
  800893:	c9                   	leave  
  800894:	c3                   	ret    

00800895 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800895:	55                   	push   %ebp
  800896:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800898:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089b:	8b 40 08             	mov    0x8(%eax),%eax
  80089e:	8d 50 01             	lea    0x1(%eax),%edx
  8008a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a4:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8008a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008aa:	8b 10                	mov    (%eax),%edx
  8008ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008af:	8b 40 04             	mov    0x4(%eax),%eax
  8008b2:	39 c2                	cmp    %eax,%edx
  8008b4:	73 12                	jae    8008c8 <sprintputch+0x33>
		*b->buf++ = ch;
  8008b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008b9:	8b 00                	mov    (%eax),%eax
  8008bb:	8d 48 01             	lea    0x1(%eax),%ecx
  8008be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008c1:	89 0a                	mov    %ecx,(%edx)
  8008c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8008c6:	88 10                	mov    %dl,(%eax)
}
  8008c8:	90                   	nop
  8008c9:	5d                   	pop    %ebp
  8008ca:	c3                   	ret    

008008cb <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008cb:	55                   	push   %ebp
  8008cc:	89 e5                	mov    %esp,%ebp
  8008ce:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008da:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e0:	01 d0                	add    %edx,%eax
  8008e2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008ec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008f0:	74 06                	je     8008f8 <vsnprintf+0x2d>
  8008f2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008f6:	7f 07                	jg     8008ff <vsnprintf+0x34>
		return -E_INVAL;
  8008f8:	b8 03 00 00 00       	mov    $0x3,%eax
  8008fd:	eb 20                	jmp    80091f <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008ff:	ff 75 14             	pushl  0x14(%ebp)
  800902:	ff 75 10             	pushl  0x10(%ebp)
  800905:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800908:	50                   	push   %eax
  800909:	68 95 08 80 00       	push   $0x800895
  80090e:	e8 92 fb ff ff       	call   8004a5 <vprintfmt>
  800913:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800916:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800919:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80091c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800927:	8d 45 10             	lea    0x10(%ebp),%eax
  80092a:	83 c0 04             	add    $0x4,%eax
  80092d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800930:	8b 45 10             	mov    0x10(%ebp),%eax
  800933:	ff 75 f4             	pushl  -0xc(%ebp)
  800936:	50                   	push   %eax
  800937:	ff 75 0c             	pushl  0xc(%ebp)
  80093a:	ff 75 08             	pushl  0x8(%ebp)
  80093d:	e8 89 ff ff ff       	call   8008cb <vsnprintf>
  800942:	83 c4 10             	add    $0x10,%esp
  800945:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800948:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80094b:	c9                   	leave  
  80094c:	c3                   	ret    

0080094d <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80094d:	55                   	push   %ebp
  80094e:	89 e5                	mov    %esp,%ebp
  800950:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800953:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800957:	74 13                	je     80096c <readline+0x1f>
		cprintf("%s", prompt);
  800959:	83 ec 08             	sub    $0x8,%esp
  80095c:	ff 75 08             	pushl  0x8(%ebp)
  80095f:	68 50 21 80 00       	push   $0x802150
  800964:	e8 62 f9 ff ff       	call   8002cb <cprintf>
  800969:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80096c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800973:	83 ec 0c             	sub    $0xc,%esp
  800976:	6a 00                	push   $0x0
  800978:	e8 a1 10 00 00       	call   801a1e <iscons>
  80097d:	83 c4 10             	add    $0x10,%esp
  800980:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800983:	e8 48 10 00 00       	call   8019d0 <getchar>
  800988:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80098b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80098f:	79 22                	jns    8009b3 <readline+0x66>
			if (c != -E_EOF)
  800991:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800995:	0f 84 ad 00 00 00    	je     800a48 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80099b:	83 ec 08             	sub    $0x8,%esp
  80099e:	ff 75 ec             	pushl  -0x14(%ebp)
  8009a1:	68 53 21 80 00       	push   $0x802153
  8009a6:	e8 20 f9 ff ff       	call   8002cb <cprintf>
  8009ab:	83 c4 10             	add    $0x10,%esp
			return;
  8009ae:	e9 95 00 00 00       	jmp    800a48 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8009b3:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8009b7:	7e 34                	jle    8009ed <readline+0xa0>
  8009b9:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8009c0:	7f 2b                	jg     8009ed <readline+0xa0>
			if (echoing)
  8009c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009c6:	74 0e                	je     8009d6 <readline+0x89>
				cputchar(c);
  8009c8:	83 ec 0c             	sub    $0xc,%esp
  8009cb:	ff 75 ec             	pushl  -0x14(%ebp)
  8009ce:	e8 b5 0f 00 00       	call   801988 <cputchar>
  8009d3:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8009d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009d9:	8d 50 01             	lea    0x1(%eax),%edx
  8009dc:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8009df:	89 c2                	mov    %eax,%edx
  8009e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e4:	01 d0                	add    %edx,%eax
  8009e6:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8009e9:	88 10                	mov    %dl,(%eax)
  8009eb:	eb 56                	jmp    800a43 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8009ed:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8009f1:	75 1f                	jne    800a12 <readline+0xc5>
  8009f3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8009f7:	7e 19                	jle    800a12 <readline+0xc5>
			if (echoing)
  8009f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8009fd:	74 0e                	je     800a0d <readline+0xc0>
				cputchar(c);
  8009ff:	83 ec 0c             	sub    $0xc,%esp
  800a02:	ff 75 ec             	pushl  -0x14(%ebp)
  800a05:	e8 7e 0f 00 00       	call   801988 <cputchar>
  800a0a:	83 c4 10             	add    $0x10,%esp

			i--;
  800a0d:	ff 4d f4             	decl   -0xc(%ebp)
  800a10:	eb 31                	jmp    800a43 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800a12:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800a16:	74 0a                	je     800a22 <readline+0xd5>
  800a18:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800a1c:	0f 85 61 ff ff ff    	jne    800983 <readline+0x36>
			if (echoing)
  800a22:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800a26:	74 0e                	je     800a36 <readline+0xe9>
				cputchar(c);
  800a28:	83 ec 0c             	sub    $0xc,%esp
  800a2b:	ff 75 ec             	pushl  -0x14(%ebp)
  800a2e:	e8 55 0f 00 00       	call   801988 <cputchar>
  800a33:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800a36:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3c:	01 d0                	add    %edx,%eax
  800a3e:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800a41:	eb 06                	jmp    800a49 <readline+0xfc>
		}
	}
  800a43:	e9 3b ff ff ff       	jmp    800983 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800a48:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800a49:	c9                   	leave  
  800a4a:	c3                   	ret    

00800a4b <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800a4b:	55                   	push   %ebp
  800a4c:	89 e5                	mov    %esp,%ebp
  800a4e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a51:	e8 41 0a 00 00       	call   801497 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800a56:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a5a:	74 13                	je     800a6f <atomic_readline+0x24>
		cprintf("%s", prompt);
  800a5c:	83 ec 08             	sub    $0x8,%esp
  800a5f:	ff 75 08             	pushl  0x8(%ebp)
  800a62:	68 50 21 80 00       	push   $0x802150
  800a67:	e8 5f f8 ff ff       	call   8002cb <cprintf>
  800a6c:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800a6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800a76:	83 ec 0c             	sub    $0xc,%esp
  800a79:	6a 00                	push   $0x0
  800a7b:	e8 9e 0f 00 00       	call   801a1e <iscons>
  800a80:	83 c4 10             	add    $0x10,%esp
  800a83:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800a86:	e8 45 0f 00 00       	call   8019d0 <getchar>
  800a8b:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800a8e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a92:	79 23                	jns    800ab7 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800a94:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800a98:	74 13                	je     800aad <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800a9a:	83 ec 08             	sub    $0x8,%esp
  800a9d:	ff 75 ec             	pushl  -0x14(%ebp)
  800aa0:	68 53 21 80 00       	push   $0x802153
  800aa5:	e8 21 f8 ff ff       	call   8002cb <cprintf>
  800aaa:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800aad:	e8 ff 09 00 00       	call   8014b1 <sys_enable_interrupt>
			return;
  800ab2:	e9 9a 00 00 00       	jmp    800b51 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800ab7:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800abb:	7e 34                	jle    800af1 <atomic_readline+0xa6>
  800abd:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800ac4:	7f 2b                	jg     800af1 <atomic_readline+0xa6>
			if (echoing)
  800ac6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800aca:	74 0e                	je     800ada <atomic_readline+0x8f>
				cputchar(c);
  800acc:	83 ec 0c             	sub    $0xc,%esp
  800acf:	ff 75 ec             	pushl  -0x14(%ebp)
  800ad2:	e8 b1 0e 00 00       	call   801988 <cputchar>
  800ad7:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800ada:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800add:	8d 50 01             	lea    0x1(%eax),%edx
  800ae0:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ae3:	89 c2                	mov    %eax,%edx
  800ae5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae8:	01 d0                	add    %edx,%eax
  800aea:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800aed:	88 10                	mov    %dl,(%eax)
  800aef:	eb 5b                	jmp    800b4c <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800af1:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800af5:	75 1f                	jne    800b16 <atomic_readline+0xcb>
  800af7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800afb:	7e 19                	jle    800b16 <atomic_readline+0xcb>
			if (echoing)
  800afd:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b01:	74 0e                	je     800b11 <atomic_readline+0xc6>
				cputchar(c);
  800b03:	83 ec 0c             	sub    $0xc,%esp
  800b06:	ff 75 ec             	pushl  -0x14(%ebp)
  800b09:	e8 7a 0e 00 00       	call   801988 <cputchar>
  800b0e:	83 c4 10             	add    $0x10,%esp
			i--;
  800b11:	ff 4d f4             	decl   -0xc(%ebp)
  800b14:	eb 36                	jmp    800b4c <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800b16:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800b1a:	74 0a                	je     800b26 <atomic_readline+0xdb>
  800b1c:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800b20:	0f 85 60 ff ff ff    	jne    800a86 <atomic_readline+0x3b>
			if (echoing)
  800b26:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800b2a:	74 0e                	je     800b3a <atomic_readline+0xef>
				cputchar(c);
  800b2c:	83 ec 0c             	sub    $0xc,%esp
  800b2f:	ff 75 ec             	pushl  -0x14(%ebp)
  800b32:	e8 51 0e 00 00       	call   801988 <cputchar>
  800b37:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800b3a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b40:	01 d0                	add    %edx,%eax
  800b42:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800b45:	e8 67 09 00 00       	call   8014b1 <sys_enable_interrupt>
			return;
  800b4a:	eb 05                	jmp    800b51 <atomic_readline+0x106>
		}
	}
  800b4c:	e9 35 ff ff ff       	jmp    800a86 <atomic_readline+0x3b>
}
  800b51:	c9                   	leave  
  800b52:	c3                   	ret    

00800b53 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b53:	55                   	push   %ebp
  800b54:	89 e5                	mov    %esp,%ebp
  800b56:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b59:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b60:	eb 06                	jmp    800b68 <strlen+0x15>
		n++;
  800b62:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b65:	ff 45 08             	incl   0x8(%ebp)
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	8a 00                	mov    (%eax),%al
  800b6d:	84 c0                	test   %al,%al
  800b6f:	75 f1                	jne    800b62 <strlen+0xf>
		n++;
	return n;
  800b71:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b74:	c9                   	leave  
  800b75:	c3                   	ret    

00800b76 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b76:	55                   	push   %ebp
  800b77:	89 e5                	mov    %esp,%ebp
  800b79:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b83:	eb 09                	jmp    800b8e <strnlen+0x18>
		n++;
  800b85:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b88:	ff 45 08             	incl   0x8(%ebp)
  800b8b:	ff 4d 0c             	decl   0xc(%ebp)
  800b8e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b92:	74 09                	je     800b9d <strnlen+0x27>
  800b94:	8b 45 08             	mov    0x8(%ebp),%eax
  800b97:	8a 00                	mov    (%eax),%al
  800b99:	84 c0                	test   %al,%al
  800b9b:	75 e8                	jne    800b85 <strnlen+0xf>
		n++;
	return n;
  800b9d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba0:	c9                   	leave  
  800ba1:	c3                   	ret    

00800ba2 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
  800ba5:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bae:	90                   	nop
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	8d 50 01             	lea    0x1(%eax),%edx
  800bb5:	89 55 08             	mov    %edx,0x8(%ebp)
  800bb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbb:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bbe:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bc1:	8a 12                	mov    (%edx),%dl
  800bc3:	88 10                	mov    %dl,(%eax)
  800bc5:	8a 00                	mov    (%eax),%al
  800bc7:	84 c0                	test   %al,%al
  800bc9:	75 e4                	jne    800baf <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bce:	c9                   	leave  
  800bcf:	c3                   	ret    

00800bd0 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bd0:	55                   	push   %ebp
  800bd1:	89 e5                	mov    %esp,%ebp
  800bd3:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bdc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800be3:	eb 1f                	jmp    800c04 <strncpy+0x34>
		*dst++ = *src;
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	8d 50 01             	lea    0x1(%eax),%edx
  800beb:	89 55 08             	mov    %edx,0x8(%ebp)
  800bee:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf1:	8a 12                	mov    (%edx),%dl
  800bf3:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bf5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bf8:	8a 00                	mov    (%eax),%al
  800bfa:	84 c0                	test   %al,%al
  800bfc:	74 03                	je     800c01 <strncpy+0x31>
			src++;
  800bfe:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c01:	ff 45 fc             	incl   -0x4(%ebp)
  800c04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c07:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c0a:	72 d9                	jb     800be5 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c0c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c0f:	c9                   	leave  
  800c10:	c3                   	ret    

00800c11 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c11:	55                   	push   %ebp
  800c12:	89 e5                	mov    %esp,%ebp
  800c14:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c17:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c21:	74 30                	je     800c53 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c23:	eb 16                	jmp    800c3b <strlcpy+0x2a>
			*dst++ = *src++;
  800c25:	8b 45 08             	mov    0x8(%ebp),%eax
  800c28:	8d 50 01             	lea    0x1(%eax),%edx
  800c2b:	89 55 08             	mov    %edx,0x8(%ebp)
  800c2e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c31:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c34:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c37:	8a 12                	mov    (%edx),%dl
  800c39:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c3b:	ff 4d 10             	decl   0x10(%ebp)
  800c3e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c42:	74 09                	je     800c4d <strlcpy+0x3c>
  800c44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c47:	8a 00                	mov    (%eax),%al
  800c49:	84 c0                	test   %al,%al
  800c4b:	75 d8                	jne    800c25 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c50:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c53:	8b 55 08             	mov    0x8(%ebp),%edx
  800c56:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c59:	29 c2                	sub    %eax,%edx
  800c5b:	89 d0                	mov    %edx,%eax
}
  800c5d:	c9                   	leave  
  800c5e:	c3                   	ret    

00800c5f <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c5f:	55                   	push   %ebp
  800c60:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c62:	eb 06                	jmp    800c6a <strcmp+0xb>
		p++, q++;
  800c64:	ff 45 08             	incl   0x8(%ebp)
  800c67:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6d:	8a 00                	mov    (%eax),%al
  800c6f:	84 c0                	test   %al,%al
  800c71:	74 0e                	je     800c81 <strcmp+0x22>
  800c73:	8b 45 08             	mov    0x8(%ebp),%eax
  800c76:	8a 10                	mov    (%eax),%dl
  800c78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7b:	8a 00                	mov    (%eax),%al
  800c7d:	38 c2                	cmp    %al,%dl
  800c7f:	74 e3                	je     800c64 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c81:	8b 45 08             	mov    0x8(%ebp),%eax
  800c84:	8a 00                	mov    (%eax),%al
  800c86:	0f b6 d0             	movzbl %al,%edx
  800c89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8c:	8a 00                	mov    (%eax),%al
  800c8e:	0f b6 c0             	movzbl %al,%eax
  800c91:	29 c2                	sub    %eax,%edx
  800c93:	89 d0                	mov    %edx,%eax
}
  800c95:	5d                   	pop    %ebp
  800c96:	c3                   	ret    

00800c97 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c97:	55                   	push   %ebp
  800c98:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c9a:	eb 09                	jmp    800ca5 <strncmp+0xe>
		n--, p++, q++;
  800c9c:	ff 4d 10             	decl   0x10(%ebp)
  800c9f:	ff 45 08             	incl   0x8(%ebp)
  800ca2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ca5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ca9:	74 17                	je     800cc2 <strncmp+0x2b>
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	8a 00                	mov    (%eax),%al
  800cb0:	84 c0                	test   %al,%al
  800cb2:	74 0e                	je     800cc2 <strncmp+0x2b>
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	8a 10                	mov    (%eax),%dl
  800cb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbc:	8a 00                	mov    (%eax),%al
  800cbe:	38 c2                	cmp    %al,%dl
  800cc0:	74 da                	je     800c9c <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cc2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc6:	75 07                	jne    800ccf <strncmp+0x38>
		return 0;
  800cc8:	b8 00 00 00 00       	mov    $0x0,%eax
  800ccd:	eb 14                	jmp    800ce3 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ccf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd2:	8a 00                	mov    (%eax),%al
  800cd4:	0f b6 d0             	movzbl %al,%edx
  800cd7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cda:	8a 00                	mov    (%eax),%al
  800cdc:	0f b6 c0             	movzbl %al,%eax
  800cdf:	29 c2                	sub    %eax,%edx
  800ce1:	89 d0                	mov    %edx,%eax
}
  800ce3:	5d                   	pop    %ebp
  800ce4:	c3                   	ret    

00800ce5 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ce5:	55                   	push   %ebp
  800ce6:	89 e5                	mov    %esp,%ebp
  800ce8:	83 ec 04             	sub    $0x4,%esp
  800ceb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cee:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cf1:	eb 12                	jmp    800d05 <strchr+0x20>
		if (*s == c)
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	8a 00                	mov    (%eax),%al
  800cf8:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cfb:	75 05                	jne    800d02 <strchr+0x1d>
			return (char *) s;
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	eb 11                	jmp    800d13 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d02:	ff 45 08             	incl   0x8(%ebp)
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	84 c0                	test   %al,%al
  800d0c:	75 e5                	jne    800cf3 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d0e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d13:	c9                   	leave  
  800d14:	c3                   	ret    

00800d15 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d15:	55                   	push   %ebp
  800d16:	89 e5                	mov    %esp,%ebp
  800d18:	83 ec 04             	sub    $0x4,%esp
  800d1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1e:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d21:	eb 0d                	jmp    800d30 <strfind+0x1b>
		if (*s == c)
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d2b:	74 0e                	je     800d3b <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d2d:	ff 45 08             	incl   0x8(%ebp)
  800d30:	8b 45 08             	mov    0x8(%ebp),%eax
  800d33:	8a 00                	mov    (%eax),%al
  800d35:	84 c0                	test   %al,%al
  800d37:	75 ea                	jne    800d23 <strfind+0xe>
  800d39:	eb 01                	jmp    800d3c <strfind+0x27>
		if (*s == c)
			break;
  800d3b:	90                   	nop
	return (char *) s;
  800d3c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d3f:	c9                   	leave  
  800d40:	c3                   	ret    

00800d41 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d41:	55                   	push   %ebp
  800d42:	89 e5                	mov    %esp,%ebp
  800d44:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d4d:	8b 45 10             	mov    0x10(%ebp),%eax
  800d50:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d53:	eb 0e                	jmp    800d63 <memset+0x22>
		*p++ = c;
  800d55:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d58:	8d 50 01             	lea    0x1(%eax),%edx
  800d5b:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d5e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d61:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d63:	ff 4d f8             	decl   -0x8(%ebp)
  800d66:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d6a:	79 e9                	jns    800d55 <memset+0x14>
		*p++ = c;

	return v;
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d6f:	c9                   	leave  
  800d70:	c3                   	ret    

00800d71 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d71:	55                   	push   %ebp
  800d72:	89 e5                	mov    %esp,%ebp
  800d74:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d83:	eb 16                	jmp    800d9b <memcpy+0x2a>
		*d++ = *s++;
  800d85:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d88:	8d 50 01             	lea    0x1(%eax),%edx
  800d8b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d8e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d91:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d94:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d97:	8a 12                	mov    (%edx),%dl
  800d99:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d9b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d9e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800da1:	89 55 10             	mov    %edx,0x10(%ebp)
  800da4:	85 c0                	test   %eax,%eax
  800da6:	75 dd                	jne    800d85 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800da8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dab:	c9                   	leave  
  800dac:	c3                   	ret    

00800dad <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800dad:	55                   	push   %ebp
  800dae:	89 e5                	mov    %esp,%ebp
  800db0:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800db3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dbf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc2:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dc5:	73 50                	jae    800e17 <memmove+0x6a>
  800dc7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dca:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcd:	01 d0                	add    %edx,%eax
  800dcf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd2:	76 43                	jbe    800e17 <memmove+0x6a>
		s += n;
  800dd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd7:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800dda:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddd:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800de0:	eb 10                	jmp    800df2 <memmove+0x45>
			*--d = *--s;
  800de2:	ff 4d f8             	decl   -0x8(%ebp)
  800de5:	ff 4d fc             	decl   -0x4(%ebp)
  800de8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800deb:	8a 10                	mov    (%eax),%dl
  800ded:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df0:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800df2:	8b 45 10             	mov    0x10(%ebp),%eax
  800df5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df8:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfb:	85 c0                	test   %eax,%eax
  800dfd:	75 e3                	jne    800de2 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800dff:	eb 23                	jmp    800e24 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e01:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e04:	8d 50 01             	lea    0x1(%eax),%edx
  800e07:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e0a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e0d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e10:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e13:	8a 12                	mov    (%edx),%dl
  800e15:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e17:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e1d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e20:	85 c0                	test   %eax,%eax
  800e22:	75 dd                	jne    800e01 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e24:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e27:	c9                   	leave  
  800e28:	c3                   	ret    

00800e29 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e29:	55                   	push   %ebp
  800e2a:	89 e5                	mov    %esp,%ebp
  800e2c:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e35:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e38:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e3b:	eb 2a                	jmp    800e67 <memcmp+0x3e>
		if (*s1 != *s2)
  800e3d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e40:	8a 10                	mov    (%eax),%dl
  800e42:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e45:	8a 00                	mov    (%eax),%al
  800e47:	38 c2                	cmp    %al,%dl
  800e49:	74 16                	je     800e61 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	0f b6 d0             	movzbl %al,%edx
  800e53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e56:	8a 00                	mov    (%eax),%al
  800e58:	0f b6 c0             	movzbl %al,%eax
  800e5b:	29 c2                	sub    %eax,%edx
  800e5d:	89 d0                	mov    %edx,%eax
  800e5f:	eb 18                	jmp    800e79 <memcmp+0x50>
		s1++, s2++;
  800e61:	ff 45 fc             	incl   -0x4(%ebp)
  800e64:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e67:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e6d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e70:	85 c0                	test   %eax,%eax
  800e72:	75 c9                	jne    800e3d <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e74:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e79:	c9                   	leave  
  800e7a:	c3                   	ret    

00800e7b <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e7b:	55                   	push   %ebp
  800e7c:	89 e5                	mov    %esp,%ebp
  800e7e:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e81:	8b 55 08             	mov    0x8(%ebp),%edx
  800e84:	8b 45 10             	mov    0x10(%ebp),%eax
  800e87:	01 d0                	add    %edx,%eax
  800e89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e8c:	eb 15                	jmp    800ea3 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e91:	8a 00                	mov    (%eax),%al
  800e93:	0f b6 d0             	movzbl %al,%edx
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	0f b6 c0             	movzbl %al,%eax
  800e9c:	39 c2                	cmp    %eax,%edx
  800e9e:	74 0d                	je     800ead <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ea0:	ff 45 08             	incl   0x8(%ebp)
  800ea3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea6:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ea9:	72 e3                	jb     800e8e <memfind+0x13>
  800eab:	eb 01                	jmp    800eae <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800ead:	90                   	nop
	return (void *) s;
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb1:	c9                   	leave  
  800eb2:	c3                   	ret    

00800eb3 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eb3:	55                   	push   %ebp
  800eb4:	89 e5                	mov    %esp,%ebp
  800eb6:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800eb9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ec0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec7:	eb 03                	jmp    800ecc <strtol+0x19>
		s++;
  800ec9:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ecc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ecf:	8a 00                	mov    (%eax),%al
  800ed1:	3c 20                	cmp    $0x20,%al
  800ed3:	74 f4                	je     800ec9 <strtol+0x16>
  800ed5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed8:	8a 00                	mov    (%eax),%al
  800eda:	3c 09                	cmp    $0x9,%al
  800edc:	74 eb                	je     800ec9 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ede:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee1:	8a 00                	mov    (%eax),%al
  800ee3:	3c 2b                	cmp    $0x2b,%al
  800ee5:	75 05                	jne    800eec <strtol+0x39>
		s++;
  800ee7:	ff 45 08             	incl   0x8(%ebp)
  800eea:	eb 13                	jmp    800eff <strtol+0x4c>
	else if (*s == '-')
  800eec:	8b 45 08             	mov    0x8(%ebp),%eax
  800eef:	8a 00                	mov    (%eax),%al
  800ef1:	3c 2d                	cmp    $0x2d,%al
  800ef3:	75 0a                	jne    800eff <strtol+0x4c>
		s++, neg = 1;
  800ef5:	ff 45 08             	incl   0x8(%ebp)
  800ef8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800eff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f03:	74 06                	je     800f0b <strtol+0x58>
  800f05:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f09:	75 20                	jne    800f2b <strtol+0x78>
  800f0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0e:	8a 00                	mov    (%eax),%al
  800f10:	3c 30                	cmp    $0x30,%al
  800f12:	75 17                	jne    800f2b <strtol+0x78>
  800f14:	8b 45 08             	mov    0x8(%ebp),%eax
  800f17:	40                   	inc    %eax
  800f18:	8a 00                	mov    (%eax),%al
  800f1a:	3c 78                	cmp    $0x78,%al
  800f1c:	75 0d                	jne    800f2b <strtol+0x78>
		s += 2, base = 16;
  800f1e:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f22:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f29:	eb 28                	jmp    800f53 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f2b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2f:	75 15                	jne    800f46 <strtol+0x93>
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	8a 00                	mov    (%eax),%al
  800f36:	3c 30                	cmp    $0x30,%al
  800f38:	75 0c                	jne    800f46 <strtol+0x93>
		s++, base = 8;
  800f3a:	ff 45 08             	incl   0x8(%ebp)
  800f3d:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f44:	eb 0d                	jmp    800f53 <strtol+0xa0>
	else if (base == 0)
  800f46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4a:	75 07                	jne    800f53 <strtol+0xa0>
		base = 10;
  800f4c:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	3c 2f                	cmp    $0x2f,%al
  800f5a:	7e 19                	jle    800f75 <strtol+0xc2>
  800f5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5f:	8a 00                	mov    (%eax),%al
  800f61:	3c 39                	cmp    $0x39,%al
  800f63:	7f 10                	jg     800f75 <strtol+0xc2>
			dig = *s - '0';
  800f65:	8b 45 08             	mov    0x8(%ebp),%eax
  800f68:	8a 00                	mov    (%eax),%al
  800f6a:	0f be c0             	movsbl %al,%eax
  800f6d:	83 e8 30             	sub    $0x30,%eax
  800f70:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f73:	eb 42                	jmp    800fb7 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f75:	8b 45 08             	mov    0x8(%ebp),%eax
  800f78:	8a 00                	mov    (%eax),%al
  800f7a:	3c 60                	cmp    $0x60,%al
  800f7c:	7e 19                	jle    800f97 <strtol+0xe4>
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	8a 00                	mov    (%eax),%al
  800f83:	3c 7a                	cmp    $0x7a,%al
  800f85:	7f 10                	jg     800f97 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f87:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8a:	8a 00                	mov    (%eax),%al
  800f8c:	0f be c0             	movsbl %al,%eax
  800f8f:	83 e8 57             	sub    $0x57,%eax
  800f92:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f95:	eb 20                	jmp    800fb7 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	3c 40                	cmp    $0x40,%al
  800f9e:	7e 39                	jle    800fd9 <strtol+0x126>
  800fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	3c 5a                	cmp    $0x5a,%al
  800fa7:	7f 30                	jg     800fd9 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fa9:	8b 45 08             	mov    0x8(%ebp),%eax
  800fac:	8a 00                	mov    (%eax),%al
  800fae:	0f be c0             	movsbl %al,%eax
  800fb1:	83 e8 37             	sub    $0x37,%eax
  800fb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fb7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fba:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fbd:	7d 19                	jge    800fd8 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fbf:	ff 45 08             	incl   0x8(%ebp)
  800fc2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc5:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fc9:	89 c2                	mov    %eax,%edx
  800fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fce:	01 d0                	add    %edx,%eax
  800fd0:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fd3:	e9 7b ff ff ff       	jmp    800f53 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fd8:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fd9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fdd:	74 08                	je     800fe7 <strtol+0x134>
		*endptr = (char *) s;
  800fdf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe2:	8b 55 08             	mov    0x8(%ebp),%edx
  800fe5:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fe7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800feb:	74 07                	je     800ff4 <strtol+0x141>
  800fed:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff0:	f7 d8                	neg    %eax
  800ff2:	eb 03                	jmp    800ff7 <strtol+0x144>
  800ff4:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ff7:	c9                   	leave  
  800ff8:	c3                   	ret    

00800ff9 <ltostr>:

void
ltostr(long value, char *str)
{
  800ff9:	55                   	push   %ebp
  800ffa:	89 e5                	mov    %esp,%ebp
  800ffc:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800fff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801006:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80100d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801011:	79 13                	jns    801026 <ltostr+0x2d>
	{
		neg = 1;
  801013:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80101a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101d:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801020:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801023:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80102e:	99                   	cltd   
  80102f:	f7 f9                	idiv   %ecx
  801031:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801034:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801037:	8d 50 01             	lea    0x1(%eax),%edx
  80103a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80103d:	89 c2                	mov    %eax,%edx
  80103f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801042:	01 d0                	add    %edx,%eax
  801044:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801047:	83 c2 30             	add    $0x30,%edx
  80104a:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80104c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80104f:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801054:	f7 e9                	imul   %ecx
  801056:	c1 fa 02             	sar    $0x2,%edx
  801059:	89 c8                	mov    %ecx,%eax
  80105b:	c1 f8 1f             	sar    $0x1f,%eax
  80105e:	29 c2                	sub    %eax,%edx
  801060:	89 d0                	mov    %edx,%eax
  801062:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801065:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801068:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80106d:	f7 e9                	imul   %ecx
  80106f:	c1 fa 02             	sar    $0x2,%edx
  801072:	89 c8                	mov    %ecx,%eax
  801074:	c1 f8 1f             	sar    $0x1f,%eax
  801077:	29 c2                	sub    %eax,%edx
  801079:	89 d0                	mov    %edx,%eax
  80107b:	c1 e0 02             	shl    $0x2,%eax
  80107e:	01 d0                	add    %edx,%eax
  801080:	01 c0                	add    %eax,%eax
  801082:	29 c1                	sub    %eax,%ecx
  801084:	89 ca                	mov    %ecx,%edx
  801086:	85 d2                	test   %edx,%edx
  801088:	75 9c                	jne    801026 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80108a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801091:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801094:	48                   	dec    %eax
  801095:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801098:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80109c:	74 3d                	je     8010db <ltostr+0xe2>
		start = 1 ;
  80109e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010a5:	eb 34                	jmp    8010db <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010a7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010aa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ad:	01 d0                	add    %edx,%eax
  8010af:	8a 00                	mov    (%eax),%al
  8010b1:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010b4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ba:	01 c2                	add    %eax,%edx
  8010bc:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c2:	01 c8                	add    %ecx,%eax
  8010c4:	8a 00                	mov    (%eax),%al
  8010c6:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010c8:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ce:	01 c2                	add    %eax,%edx
  8010d0:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010d3:	88 02                	mov    %al,(%edx)
		start++ ;
  8010d5:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010d8:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010db:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010de:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010e1:	7c c4                	jl     8010a7 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e9:	01 d0                	add    %edx,%eax
  8010eb:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010ee:	90                   	nop
  8010ef:	c9                   	leave  
  8010f0:	c3                   	ret    

008010f1 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010f1:	55                   	push   %ebp
  8010f2:	89 e5                	mov    %esp,%ebp
  8010f4:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010f7:	ff 75 08             	pushl  0x8(%ebp)
  8010fa:	e8 54 fa ff ff       	call   800b53 <strlen>
  8010ff:	83 c4 04             	add    $0x4,%esp
  801102:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801105:	ff 75 0c             	pushl  0xc(%ebp)
  801108:	e8 46 fa ff ff       	call   800b53 <strlen>
  80110d:	83 c4 04             	add    $0x4,%esp
  801110:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801113:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80111a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801121:	eb 17                	jmp    80113a <strcconcat+0x49>
		final[s] = str1[s] ;
  801123:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801126:	8b 45 10             	mov    0x10(%ebp),%eax
  801129:	01 c2                	add    %eax,%edx
  80112b:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	01 c8                	add    %ecx,%eax
  801133:	8a 00                	mov    (%eax),%al
  801135:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801137:	ff 45 fc             	incl   -0x4(%ebp)
  80113a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113d:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801140:	7c e1                	jl     801123 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801142:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801149:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801150:	eb 1f                	jmp    801171 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801152:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801155:	8d 50 01             	lea    0x1(%eax),%edx
  801158:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80115b:	89 c2                	mov    %eax,%edx
  80115d:	8b 45 10             	mov    0x10(%ebp),%eax
  801160:	01 c2                	add    %eax,%edx
  801162:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801165:	8b 45 0c             	mov    0xc(%ebp),%eax
  801168:	01 c8                	add    %ecx,%eax
  80116a:	8a 00                	mov    (%eax),%al
  80116c:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80116e:	ff 45 f8             	incl   -0x8(%ebp)
  801171:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801174:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801177:	7c d9                	jl     801152 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801179:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80117c:	8b 45 10             	mov    0x10(%ebp),%eax
  80117f:	01 d0                	add    %edx,%eax
  801181:	c6 00 00             	movb   $0x0,(%eax)
}
  801184:	90                   	nop
  801185:	c9                   	leave  
  801186:	c3                   	ret    

00801187 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801187:	55                   	push   %ebp
  801188:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80118a:	8b 45 14             	mov    0x14(%ebp),%eax
  80118d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801193:	8b 45 14             	mov    0x14(%ebp),%eax
  801196:	8b 00                	mov    (%eax),%eax
  801198:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80119f:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a2:	01 d0                	add    %edx,%eax
  8011a4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011aa:	eb 0c                	jmp    8011b8 <strsplit+0x31>
			*string++ = 0;
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8d 50 01             	lea    0x1(%eax),%edx
  8011b2:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b5:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	84 c0                	test   %al,%al
  8011bf:	74 18                	je     8011d9 <strsplit+0x52>
  8011c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c4:	8a 00                	mov    (%eax),%al
  8011c6:	0f be c0             	movsbl %al,%eax
  8011c9:	50                   	push   %eax
  8011ca:	ff 75 0c             	pushl  0xc(%ebp)
  8011cd:	e8 13 fb ff ff       	call   800ce5 <strchr>
  8011d2:	83 c4 08             	add    $0x8,%esp
  8011d5:	85 c0                	test   %eax,%eax
  8011d7:	75 d3                	jne    8011ac <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dc:	8a 00                	mov    (%eax),%al
  8011de:	84 c0                	test   %al,%al
  8011e0:	74 5a                	je     80123c <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e5:	8b 00                	mov    (%eax),%eax
  8011e7:	83 f8 0f             	cmp    $0xf,%eax
  8011ea:	75 07                	jne    8011f3 <strsplit+0x6c>
		{
			return 0;
  8011ec:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f1:	eb 66                	jmp    801259 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f6:	8b 00                	mov    (%eax),%eax
  8011f8:	8d 48 01             	lea    0x1(%eax),%ecx
  8011fb:	8b 55 14             	mov    0x14(%ebp),%edx
  8011fe:	89 0a                	mov    %ecx,(%edx)
  801200:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801207:	8b 45 10             	mov    0x10(%ebp),%eax
  80120a:	01 c2                	add    %eax,%edx
  80120c:	8b 45 08             	mov    0x8(%ebp),%eax
  80120f:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801211:	eb 03                	jmp    801216 <strsplit+0x8f>
			string++;
  801213:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801216:	8b 45 08             	mov    0x8(%ebp),%eax
  801219:	8a 00                	mov    (%eax),%al
  80121b:	84 c0                	test   %al,%al
  80121d:	74 8b                	je     8011aa <strsplit+0x23>
  80121f:	8b 45 08             	mov    0x8(%ebp),%eax
  801222:	8a 00                	mov    (%eax),%al
  801224:	0f be c0             	movsbl %al,%eax
  801227:	50                   	push   %eax
  801228:	ff 75 0c             	pushl  0xc(%ebp)
  80122b:	e8 b5 fa ff ff       	call   800ce5 <strchr>
  801230:	83 c4 08             	add    $0x8,%esp
  801233:	85 c0                	test   %eax,%eax
  801235:	74 dc                	je     801213 <strsplit+0x8c>
			string++;
	}
  801237:	e9 6e ff ff ff       	jmp    8011aa <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80123c:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80123d:	8b 45 14             	mov    0x14(%ebp),%eax
  801240:	8b 00                	mov    (%eax),%eax
  801242:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801249:	8b 45 10             	mov    0x10(%ebp),%eax
  80124c:	01 d0                	add    %edx,%eax
  80124e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801254:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801259:	c9                   	leave  
  80125a:	c3                   	ret    

0080125b <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80125b:	55                   	push   %ebp
  80125c:	89 e5                	mov    %esp,%ebp
  80125e:	57                   	push   %edi
  80125f:	56                   	push   %esi
  801260:	53                   	push   %ebx
  801261:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801264:	8b 45 08             	mov    0x8(%ebp),%eax
  801267:	8b 55 0c             	mov    0xc(%ebp),%edx
  80126a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80126d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801270:	8b 7d 18             	mov    0x18(%ebp),%edi
  801273:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801276:	cd 30                	int    $0x30
  801278:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80127b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80127e:	83 c4 10             	add    $0x10,%esp
  801281:	5b                   	pop    %ebx
  801282:	5e                   	pop    %esi
  801283:	5f                   	pop    %edi
  801284:	5d                   	pop    %ebp
  801285:	c3                   	ret    

00801286 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801286:	55                   	push   %ebp
  801287:	89 e5                	mov    %esp,%ebp
  801289:	83 ec 04             	sub    $0x4,%esp
  80128c:	8b 45 10             	mov    0x10(%ebp),%eax
  80128f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801292:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	52                   	push   %edx
  80129e:	ff 75 0c             	pushl  0xc(%ebp)
  8012a1:	50                   	push   %eax
  8012a2:	6a 00                	push   $0x0
  8012a4:	e8 b2 ff ff ff       	call   80125b <syscall>
  8012a9:	83 c4 18             	add    $0x18,%esp
}
  8012ac:	90                   	nop
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <sys_cgetc>:

int
sys_cgetc(void)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 01                	push   $0x1
  8012be:	e8 98 ff ff ff       	call   80125b <syscall>
  8012c3:	83 c4 18             	add    $0x18,%esp
}
  8012c6:	c9                   	leave  
  8012c7:	c3                   	ret    

008012c8 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012c8:	55                   	push   %ebp
  8012c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ce:	6a 00                	push   $0x0
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	50                   	push   %eax
  8012d7:	6a 05                	push   $0x5
  8012d9:	e8 7d ff ff ff       	call   80125b <syscall>
  8012de:	83 c4 18             	add    $0x18,%esp
}
  8012e1:	c9                   	leave  
  8012e2:	c3                   	ret    

008012e3 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012e3:	55                   	push   %ebp
  8012e4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 02                	push   $0x2
  8012f2:	e8 64 ff ff ff       	call   80125b <syscall>
  8012f7:	83 c4 18             	add    $0x18,%esp
}
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8012ff:	6a 00                	push   $0x0
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 03                	push   $0x3
  80130b:	e8 4b ff ff ff       	call   80125b <syscall>
  801310:	83 c4 18             	add    $0x18,%esp
}
  801313:	c9                   	leave  
  801314:	c3                   	ret    

00801315 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801315:	55                   	push   %ebp
  801316:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	6a 04                	push   $0x4
  801324:	e8 32 ff ff ff       	call   80125b <syscall>
  801329:	83 c4 18             	add    $0x18,%esp
}
  80132c:	c9                   	leave  
  80132d:	c3                   	ret    

0080132e <sys_env_exit>:


void sys_env_exit(void)
{
  80132e:	55                   	push   %ebp
  80132f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 06                	push   $0x6
  80133d:	e8 19 ff ff ff       	call   80125b <syscall>
  801342:	83 c4 18             	add    $0x18,%esp
}
  801345:	90                   	nop
  801346:	c9                   	leave  
  801347:	c3                   	ret    

00801348 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801348:	55                   	push   %ebp
  801349:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80134b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134e:	8b 45 08             	mov    0x8(%ebp),%eax
  801351:	6a 00                	push   $0x0
  801353:	6a 00                	push   $0x0
  801355:	6a 00                	push   $0x0
  801357:	52                   	push   %edx
  801358:	50                   	push   %eax
  801359:	6a 07                	push   $0x7
  80135b:	e8 fb fe ff ff       	call   80125b <syscall>
  801360:	83 c4 18             	add    $0x18,%esp
}
  801363:	c9                   	leave  
  801364:	c3                   	ret    

00801365 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801365:	55                   	push   %ebp
  801366:	89 e5                	mov    %esp,%ebp
  801368:	56                   	push   %esi
  801369:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80136a:	8b 75 18             	mov    0x18(%ebp),%esi
  80136d:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801370:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801373:	8b 55 0c             	mov    0xc(%ebp),%edx
  801376:	8b 45 08             	mov    0x8(%ebp),%eax
  801379:	56                   	push   %esi
  80137a:	53                   	push   %ebx
  80137b:	51                   	push   %ecx
  80137c:	52                   	push   %edx
  80137d:	50                   	push   %eax
  80137e:	6a 08                	push   $0x8
  801380:	e8 d6 fe ff ff       	call   80125b <syscall>
  801385:	83 c4 18             	add    $0x18,%esp
}
  801388:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80138b:	5b                   	pop    %ebx
  80138c:	5e                   	pop    %esi
  80138d:	5d                   	pop    %ebp
  80138e:	c3                   	ret    

0080138f <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80138f:	55                   	push   %ebp
  801390:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801392:	8b 55 0c             	mov    0xc(%ebp),%edx
  801395:	8b 45 08             	mov    0x8(%ebp),%eax
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	52                   	push   %edx
  80139f:	50                   	push   %eax
  8013a0:	6a 09                	push   $0x9
  8013a2:	e8 b4 fe ff ff       	call   80125b <syscall>
  8013a7:	83 c4 18             	add    $0x18,%esp
}
  8013aa:	c9                   	leave  
  8013ab:	c3                   	ret    

008013ac <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013ac:	55                   	push   %ebp
  8013ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	ff 75 0c             	pushl  0xc(%ebp)
  8013b8:	ff 75 08             	pushl  0x8(%ebp)
  8013bb:	6a 0a                	push   $0xa
  8013bd:	e8 99 fe ff ff       	call   80125b <syscall>
  8013c2:	83 c4 18             	add    $0x18,%esp
}
  8013c5:	c9                   	leave  
  8013c6:	c3                   	ret    

008013c7 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013c7:	55                   	push   %ebp
  8013c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013ca:	6a 00                	push   $0x0
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 0b                	push   $0xb
  8013d6:	e8 80 fe ff ff       	call   80125b <syscall>
  8013db:	83 c4 18             	add    $0x18,%esp
}
  8013de:	c9                   	leave  
  8013df:	c3                   	ret    

008013e0 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 0c                	push   $0xc
  8013ef:	e8 67 fe ff ff       	call   80125b <syscall>
  8013f4:	83 c4 18             	add    $0x18,%esp
}
  8013f7:	c9                   	leave  
  8013f8:	c3                   	ret    

008013f9 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013f9:	55                   	push   %ebp
  8013fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 0d                	push   $0xd
  801408:	e8 4e fe ff ff       	call   80125b <syscall>
  80140d:	83 c4 18             	add    $0x18,%esp
}
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	ff 75 0c             	pushl  0xc(%ebp)
  80141e:	ff 75 08             	pushl  0x8(%ebp)
  801421:	6a 11                	push   $0x11
  801423:	e8 33 fe ff ff       	call   80125b <syscall>
  801428:	83 c4 18             	add    $0x18,%esp
	return;
  80142b:	90                   	nop
}
  80142c:	c9                   	leave  
  80142d:	c3                   	ret    

0080142e <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	ff 75 0c             	pushl  0xc(%ebp)
  80143a:	ff 75 08             	pushl  0x8(%ebp)
  80143d:	6a 12                	push   $0x12
  80143f:	e8 17 fe ff ff       	call   80125b <syscall>
  801444:	83 c4 18             	add    $0x18,%esp
	return ;
  801447:	90                   	nop
}
  801448:	c9                   	leave  
  801449:	c3                   	ret    

0080144a <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80144a:	55                   	push   %ebp
  80144b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 0e                	push   $0xe
  801459:	e8 fd fd ff ff       	call   80125b <syscall>
  80145e:	83 c4 18             	add    $0x18,%esp
}
  801461:	c9                   	leave  
  801462:	c3                   	ret    

00801463 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801463:	55                   	push   %ebp
  801464:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801466:	6a 00                	push   $0x0
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	ff 75 08             	pushl  0x8(%ebp)
  801471:	6a 0f                	push   $0xf
  801473:	e8 e3 fd ff ff       	call   80125b <syscall>
  801478:	83 c4 18             	add    $0x18,%esp
}
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <sys_scarce_memory>:

void sys_scarce_memory()
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 10                	push   $0x10
  80148c:	e8 ca fd ff ff       	call   80125b <syscall>
  801491:	83 c4 18             	add    $0x18,%esp
}
  801494:	90                   	nop
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80149a:	6a 00                	push   $0x0
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 14                	push   $0x14
  8014a6:	e8 b0 fd ff ff       	call   80125b <syscall>
  8014ab:	83 c4 18             	add    $0x18,%esp
}
  8014ae:	90                   	nop
  8014af:	c9                   	leave  
  8014b0:	c3                   	ret    

008014b1 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014b1:	55                   	push   %ebp
  8014b2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 15                	push   $0x15
  8014c0:	e8 96 fd ff ff       	call   80125b <syscall>
  8014c5:	83 c4 18             	add    $0x18,%esp
}
  8014c8:	90                   	nop
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <sys_cputc>:


void
sys_cputc(const char c)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
  8014ce:	83 ec 04             	sub    $0x4,%esp
  8014d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014d7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	50                   	push   %eax
  8014e4:	6a 16                	push   $0x16
  8014e6:	e8 70 fd ff ff       	call   80125b <syscall>
  8014eb:	83 c4 18             	add    $0x18,%esp
}
  8014ee:	90                   	nop
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014f4:	6a 00                	push   $0x0
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 17                	push   $0x17
  801500:	e8 56 fd ff ff       	call   80125b <syscall>
  801505:	83 c4 18             	add    $0x18,%esp
}
  801508:	90                   	nop
  801509:	c9                   	leave  
  80150a:	c3                   	ret    

0080150b <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80150b:	55                   	push   %ebp
  80150c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80150e:	8b 45 08             	mov    0x8(%ebp),%eax
  801511:	6a 00                	push   $0x0
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	ff 75 0c             	pushl  0xc(%ebp)
  80151a:	50                   	push   %eax
  80151b:	6a 18                	push   $0x18
  80151d:	e8 39 fd ff ff       	call   80125b <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
}
  801525:	c9                   	leave  
  801526:	c3                   	ret    

00801527 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801527:	55                   	push   %ebp
  801528:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80152a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	52                   	push   %edx
  801537:	50                   	push   %eax
  801538:	6a 1b                	push   $0x1b
  80153a:	e8 1c fd ff ff       	call   80125b <syscall>
  80153f:	83 c4 18             	add    $0x18,%esp
}
  801542:	c9                   	leave  
  801543:	c3                   	ret    

00801544 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801544:	55                   	push   %ebp
  801545:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801547:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154a:	8b 45 08             	mov    0x8(%ebp),%eax
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	52                   	push   %edx
  801554:	50                   	push   %eax
  801555:	6a 19                	push   $0x19
  801557:	e8 ff fc ff ff       	call   80125b <syscall>
  80155c:	83 c4 18             	add    $0x18,%esp
}
  80155f:	90                   	nop
  801560:	c9                   	leave  
  801561:	c3                   	ret    

00801562 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801562:	55                   	push   %ebp
  801563:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801565:	8b 55 0c             	mov    0xc(%ebp),%edx
  801568:	8b 45 08             	mov    0x8(%ebp),%eax
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	52                   	push   %edx
  801572:	50                   	push   %eax
  801573:	6a 1a                	push   $0x1a
  801575:	e8 e1 fc ff ff       	call   80125b <syscall>
  80157a:	83 c4 18             	add    $0x18,%esp
}
  80157d:	90                   	nop
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
  801583:	83 ec 04             	sub    $0x4,%esp
  801586:	8b 45 10             	mov    0x10(%ebp),%eax
  801589:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80158c:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80158f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801593:	8b 45 08             	mov    0x8(%ebp),%eax
  801596:	6a 00                	push   $0x0
  801598:	51                   	push   %ecx
  801599:	52                   	push   %edx
  80159a:	ff 75 0c             	pushl  0xc(%ebp)
  80159d:	50                   	push   %eax
  80159e:	6a 1c                	push   $0x1c
  8015a0:	e8 b6 fc ff ff       	call   80125b <syscall>
  8015a5:	83 c4 18             	add    $0x18,%esp
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015ad:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	52                   	push   %edx
  8015ba:	50                   	push   %eax
  8015bb:	6a 1d                	push   $0x1d
  8015bd:	e8 99 fc ff ff       	call   80125b <syscall>
  8015c2:	83 c4 18             	add    $0x18,%esp
}
  8015c5:	c9                   	leave  
  8015c6:	c3                   	ret    

008015c7 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015c7:	55                   	push   %ebp
  8015c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015ca:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d3:	6a 00                	push   $0x0
  8015d5:	6a 00                	push   $0x0
  8015d7:	51                   	push   %ecx
  8015d8:	52                   	push   %edx
  8015d9:	50                   	push   %eax
  8015da:	6a 1e                	push   $0x1e
  8015dc:	e8 7a fc ff ff       	call   80125b <syscall>
  8015e1:	83 c4 18             	add    $0x18,%esp
}
  8015e4:	c9                   	leave  
  8015e5:	c3                   	ret    

008015e6 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015e6:	55                   	push   %ebp
  8015e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	52                   	push   %edx
  8015f6:	50                   	push   %eax
  8015f7:	6a 1f                	push   $0x1f
  8015f9:	e8 5d fc ff ff       	call   80125b <syscall>
  8015fe:	83 c4 18             	add    $0x18,%esp
}
  801601:	c9                   	leave  
  801602:	c3                   	ret    

00801603 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801603:	55                   	push   %ebp
  801604:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801606:	6a 00                	push   $0x0
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 20                	push   $0x20
  801612:	e8 44 fc ff ff       	call   80125b <syscall>
  801617:	83 c4 18             	add    $0x18,%esp
}
  80161a:	c9                   	leave  
  80161b:	c3                   	ret    

0080161c <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80161c:	55                   	push   %ebp
  80161d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80161f:	8b 45 08             	mov    0x8(%ebp),%eax
  801622:	6a 00                	push   $0x0
  801624:	ff 75 14             	pushl  0x14(%ebp)
  801627:	ff 75 10             	pushl  0x10(%ebp)
  80162a:	ff 75 0c             	pushl  0xc(%ebp)
  80162d:	50                   	push   %eax
  80162e:	6a 21                	push   $0x21
  801630:	e8 26 fc ff ff       	call   80125b <syscall>
  801635:	83 c4 18             	add    $0x18,%esp
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80163d:	8b 45 08             	mov    0x8(%ebp),%eax
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	50                   	push   %eax
  801649:	6a 22                	push   $0x22
  80164b:	e8 0b fc ff ff       	call   80125b <syscall>
  801650:	83 c4 18             	add    $0x18,%esp
}
  801653:	90                   	nop
  801654:	c9                   	leave  
  801655:	c3                   	ret    

00801656 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801656:	55                   	push   %ebp
  801657:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	6a 00                	push   $0x0
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	50                   	push   %eax
  801665:	6a 23                	push   $0x23
  801667:	e8 ef fb ff ff       	call   80125b <syscall>
  80166c:	83 c4 18             	add    $0x18,%esp
}
  80166f:	90                   	nop
  801670:	c9                   	leave  
  801671:	c3                   	ret    

00801672 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801672:	55                   	push   %ebp
  801673:	89 e5                	mov    %esp,%ebp
  801675:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801678:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80167b:	8d 50 04             	lea    0x4(%eax),%edx
  80167e:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	52                   	push   %edx
  801688:	50                   	push   %eax
  801689:	6a 24                	push   $0x24
  80168b:	e8 cb fb ff ff       	call   80125b <syscall>
  801690:	83 c4 18             	add    $0x18,%esp
	return result;
  801693:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801696:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801699:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80169c:	89 01                	mov    %eax,(%ecx)
  80169e:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	c9                   	leave  
  8016a5:	c2 04 00             	ret    $0x4

008016a8 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016a8:	55                   	push   %ebp
  8016a9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016ab:	6a 00                	push   $0x0
  8016ad:	6a 00                	push   $0x0
  8016af:	ff 75 10             	pushl  0x10(%ebp)
  8016b2:	ff 75 0c             	pushl  0xc(%ebp)
  8016b5:	ff 75 08             	pushl  0x8(%ebp)
  8016b8:	6a 13                	push   $0x13
  8016ba:	e8 9c fb ff ff       	call   80125b <syscall>
  8016bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c2:	90                   	nop
}
  8016c3:	c9                   	leave  
  8016c4:	c3                   	ret    

008016c5 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016c5:	55                   	push   %ebp
  8016c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 25                	push   $0x25
  8016d4:	e8 82 fb ff ff       	call   80125b <syscall>
  8016d9:	83 c4 18             	add    $0x18,%esp
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 04             	sub    $0x4,%esp
  8016e4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016ea:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	50                   	push   %eax
  8016f7:	6a 26                	push   $0x26
  8016f9:	e8 5d fb ff ff       	call   80125b <syscall>
  8016fe:	83 c4 18             	add    $0x18,%esp
	return ;
  801701:	90                   	nop
}
  801702:	c9                   	leave  
  801703:	c3                   	ret    

00801704 <rsttst>:
void rsttst()
{
  801704:	55                   	push   %ebp
  801705:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801707:	6a 00                	push   $0x0
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 28                	push   $0x28
  801713:	e8 43 fb ff ff       	call   80125b <syscall>
  801718:	83 c4 18             	add    $0x18,%esp
	return ;
  80171b:	90                   	nop
}
  80171c:	c9                   	leave  
  80171d:	c3                   	ret    

0080171e <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80171e:	55                   	push   %ebp
  80171f:	89 e5                	mov    %esp,%ebp
  801721:	83 ec 04             	sub    $0x4,%esp
  801724:	8b 45 14             	mov    0x14(%ebp),%eax
  801727:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80172a:	8b 55 18             	mov    0x18(%ebp),%edx
  80172d:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801731:	52                   	push   %edx
  801732:	50                   	push   %eax
  801733:	ff 75 10             	pushl  0x10(%ebp)
  801736:	ff 75 0c             	pushl  0xc(%ebp)
  801739:	ff 75 08             	pushl  0x8(%ebp)
  80173c:	6a 27                	push   $0x27
  80173e:	e8 18 fb ff ff       	call   80125b <syscall>
  801743:	83 c4 18             	add    $0x18,%esp
	return ;
  801746:	90                   	nop
}
  801747:	c9                   	leave  
  801748:	c3                   	ret    

00801749 <chktst>:
void chktst(uint32 n)
{
  801749:	55                   	push   %ebp
  80174a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	ff 75 08             	pushl  0x8(%ebp)
  801757:	6a 29                	push   $0x29
  801759:	e8 fd fa ff ff       	call   80125b <syscall>
  80175e:	83 c4 18             	add    $0x18,%esp
	return ;
  801761:	90                   	nop
}
  801762:	c9                   	leave  
  801763:	c3                   	ret    

00801764 <inctst>:

void inctst()
{
  801764:	55                   	push   %ebp
  801765:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 2a                	push   $0x2a
  801773:	e8 e3 fa ff ff       	call   80125b <syscall>
  801778:	83 c4 18             	add    $0x18,%esp
	return ;
  80177b:	90                   	nop
}
  80177c:	c9                   	leave  
  80177d:	c3                   	ret    

0080177e <gettst>:
uint32 gettst()
{
  80177e:	55                   	push   %ebp
  80177f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 2b                	push   $0x2b
  80178d:	e8 c9 fa ff ff       	call   80125b <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	c9                   	leave  
  801796:	c3                   	ret    

00801797 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801797:	55                   	push   %ebp
  801798:	89 e5                	mov    %esp,%ebp
  80179a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 2c                	push   $0x2c
  8017a9:	e8 ad fa ff ff       	call   80125b <syscall>
  8017ae:	83 c4 18             	add    $0x18,%esp
  8017b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017b4:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017b8:	75 07                	jne    8017c1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8017bf:	eb 05                	jmp    8017c6 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c6:	c9                   	leave  
  8017c7:	c3                   	ret    

008017c8 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
  8017cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ce:	6a 00                	push   $0x0
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 2c                	push   $0x2c
  8017da:	e8 7c fa ff ff       	call   80125b <syscall>
  8017df:	83 c4 18             	add    $0x18,%esp
  8017e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017e5:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017e9:	75 07                	jne    8017f2 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f0:	eb 05                	jmp    8017f7 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f7:	c9                   	leave  
  8017f8:	c3                   	ret    

008017f9 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017f9:	55                   	push   %ebp
  8017fa:	89 e5                	mov    %esp,%ebp
  8017fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 2c                	push   $0x2c
  80180b:	e8 4b fa ff ff       	call   80125b <syscall>
  801810:	83 c4 18             	add    $0x18,%esp
  801813:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801816:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80181a:	75 07                	jne    801823 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80181c:	b8 01 00 00 00       	mov    $0x1,%eax
  801821:	eb 05                	jmp    801828 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801823:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801828:	c9                   	leave  
  801829:	c3                   	ret    

0080182a <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80182a:	55                   	push   %ebp
  80182b:	89 e5                	mov    %esp,%ebp
  80182d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 2c                	push   $0x2c
  80183c:	e8 1a fa ff ff       	call   80125b <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
  801844:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801847:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80184b:	75 07                	jne    801854 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80184d:	b8 01 00 00 00       	mov    $0x1,%eax
  801852:	eb 05                	jmp    801859 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801854:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801859:	c9                   	leave  
  80185a:	c3                   	ret    

0080185b <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80185b:	55                   	push   %ebp
  80185c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	ff 75 08             	pushl  0x8(%ebp)
  801869:	6a 2d                	push   $0x2d
  80186b:	e8 eb f9 ff ff       	call   80125b <syscall>
  801870:	83 c4 18             	add    $0x18,%esp
	return ;
  801873:	90                   	nop
}
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
  801879:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80187a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80187d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801880:	8b 55 0c             	mov    0xc(%ebp),%edx
  801883:	8b 45 08             	mov    0x8(%ebp),%eax
  801886:	6a 00                	push   $0x0
  801888:	53                   	push   %ebx
  801889:	51                   	push   %ecx
  80188a:	52                   	push   %edx
  80188b:	50                   	push   %eax
  80188c:	6a 2e                	push   $0x2e
  80188e:	e8 c8 f9 ff ff       	call   80125b <syscall>
  801893:	83 c4 18             	add    $0x18,%esp
}
  801896:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801899:	c9                   	leave  
  80189a:	c3                   	ret    

0080189b <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80189b:	55                   	push   %ebp
  80189c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80189e:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a4:	6a 00                	push   $0x0
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	52                   	push   %edx
  8018ab:	50                   	push   %eax
  8018ac:	6a 2f                	push   $0x2f
  8018ae:	e8 a8 f9 ff ff       	call   80125b <syscall>
  8018b3:	83 c4 18             	add    $0x18,%esp
}
  8018b6:	c9                   	leave  
  8018b7:	c3                   	ret    

008018b8 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018b8:	55                   	push   %ebp
  8018b9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018bb:	6a 00                	push   $0x0
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	ff 75 0c             	pushl  0xc(%ebp)
  8018c4:	ff 75 08             	pushl  0x8(%ebp)
  8018c7:	6a 30                	push   $0x30
  8018c9:	e8 8d f9 ff ff       	call   80125b <syscall>
  8018ce:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d1:	90                   	nop
}
  8018d2:	c9                   	leave  
  8018d3:	c3                   	ret    

008018d4 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018d4:	55                   	push   %ebp
  8018d5:	89 e5                	mov    %esp,%ebp
  8018d7:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018da:	8b 55 08             	mov    0x8(%ebp),%edx
  8018dd:	89 d0                	mov    %edx,%eax
  8018df:	c1 e0 02             	shl    $0x2,%eax
  8018e2:	01 d0                	add    %edx,%eax
  8018e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018eb:	01 d0                	add    %edx,%eax
  8018ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f4:	01 d0                	add    %edx,%eax
  8018f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018fd:	01 d0                	add    %edx,%eax
  8018ff:	c1 e0 04             	shl    $0x4,%eax
  801902:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801905:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80190c:	8d 45 e8             	lea    -0x18(%ebp),%eax
  80190f:	83 ec 0c             	sub    $0xc,%esp
  801912:	50                   	push   %eax
  801913:	e8 5a fd ff ff       	call   801672 <sys_get_virtual_time>
  801918:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80191b:	eb 41                	jmp    80195e <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80191d:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801920:	83 ec 0c             	sub    $0xc,%esp
  801923:	50                   	push   %eax
  801924:	e8 49 fd ff ff       	call   801672 <sys_get_virtual_time>
  801929:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80192c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80192f:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801932:	29 c2                	sub    %eax,%edx
  801934:	89 d0                	mov    %edx,%eax
  801936:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801939:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80193c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80193f:	89 d1                	mov    %edx,%ecx
  801941:	29 c1                	sub    %eax,%ecx
  801943:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801946:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801949:	39 c2                	cmp    %eax,%edx
  80194b:	0f 97 c0             	seta   %al
  80194e:	0f b6 c0             	movzbl %al,%eax
  801951:	29 c1                	sub    %eax,%ecx
  801953:	89 c8                	mov    %ecx,%eax
  801955:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801958:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80195b:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80195e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801961:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801964:	72 b7                	jb     80191d <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801966:	90                   	nop
  801967:	c9                   	leave  
  801968:	c3                   	ret    

00801969 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801969:	55                   	push   %ebp
  80196a:	89 e5                	mov    %esp,%ebp
  80196c:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80196f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801976:	eb 03                	jmp    80197b <busy_wait+0x12>
  801978:	ff 45 fc             	incl   -0x4(%ebp)
  80197b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80197e:	3b 45 08             	cmp    0x8(%ebp),%eax
  801981:	72 f5                	jb     801978 <busy_wait+0xf>
	return i;
  801983:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
  80198b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80198e:	8b 45 08             	mov    0x8(%ebp),%eax
  801991:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801994:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801998:	83 ec 0c             	sub    $0xc,%esp
  80199b:	50                   	push   %eax
  80199c:	e8 2a fb ff ff       	call   8014cb <sys_cputc>
  8019a1:	83 c4 10             	add    $0x10,%esp
}
  8019a4:	90                   	nop
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
  8019aa:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8019ad:	e8 e5 fa ff ff       	call   801497 <sys_disable_interrupt>
	char c = ch;
  8019b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b5:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8019b8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8019bc:	83 ec 0c             	sub    $0xc,%esp
  8019bf:	50                   	push   %eax
  8019c0:	e8 06 fb ff ff       	call   8014cb <sys_cputc>
  8019c5:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8019c8:	e8 e4 fa ff ff       	call   8014b1 <sys_enable_interrupt>
}
  8019cd:	90                   	nop
  8019ce:	c9                   	leave  
  8019cf:	c3                   	ret    

008019d0 <getchar>:

int
getchar(void)
{
  8019d0:	55                   	push   %ebp
  8019d1:	89 e5                	mov    %esp,%ebp
  8019d3:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8019d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8019dd:	eb 08                	jmp    8019e7 <getchar+0x17>
	{
		c = sys_cgetc();
  8019df:	e8 cb f8 ff ff       	call   8012af <sys_cgetc>
  8019e4:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8019e7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8019eb:	74 f2                	je     8019df <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8019ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8019f0:	c9                   	leave  
  8019f1:	c3                   	ret    

008019f2 <atomic_getchar>:

int
atomic_getchar(void)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
  8019f5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8019f8:	e8 9a fa ff ff       	call   801497 <sys_disable_interrupt>
	int c=0;
  8019fd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801a04:	eb 08                	jmp    801a0e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801a06:	e8 a4 f8 ff ff       	call   8012af <sys_cgetc>
  801a0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801a0e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801a12:	74 f2                	je     801a06 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801a14:	e8 98 fa ff ff       	call   8014b1 <sys_enable_interrupt>
	return c;
  801a19:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801a1c:	c9                   	leave  
  801a1d:	c3                   	ret    

00801a1e <iscons>:

int iscons(int fdnum)
{
  801a1e:	55                   	push   %ebp
  801a1f:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801a21:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a26:	5d                   	pop    %ebp
  801a27:	c3                   	ret    

00801a28 <__udivdi3>:
  801a28:	55                   	push   %ebp
  801a29:	57                   	push   %edi
  801a2a:	56                   	push   %esi
  801a2b:	53                   	push   %ebx
  801a2c:	83 ec 1c             	sub    $0x1c,%esp
  801a2f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a33:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a37:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a3b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a3f:	89 ca                	mov    %ecx,%edx
  801a41:	89 f8                	mov    %edi,%eax
  801a43:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a47:	85 f6                	test   %esi,%esi
  801a49:	75 2d                	jne    801a78 <__udivdi3+0x50>
  801a4b:	39 cf                	cmp    %ecx,%edi
  801a4d:	77 65                	ja     801ab4 <__udivdi3+0x8c>
  801a4f:	89 fd                	mov    %edi,%ebp
  801a51:	85 ff                	test   %edi,%edi
  801a53:	75 0b                	jne    801a60 <__udivdi3+0x38>
  801a55:	b8 01 00 00 00       	mov    $0x1,%eax
  801a5a:	31 d2                	xor    %edx,%edx
  801a5c:	f7 f7                	div    %edi
  801a5e:	89 c5                	mov    %eax,%ebp
  801a60:	31 d2                	xor    %edx,%edx
  801a62:	89 c8                	mov    %ecx,%eax
  801a64:	f7 f5                	div    %ebp
  801a66:	89 c1                	mov    %eax,%ecx
  801a68:	89 d8                	mov    %ebx,%eax
  801a6a:	f7 f5                	div    %ebp
  801a6c:	89 cf                	mov    %ecx,%edi
  801a6e:	89 fa                	mov    %edi,%edx
  801a70:	83 c4 1c             	add    $0x1c,%esp
  801a73:	5b                   	pop    %ebx
  801a74:	5e                   	pop    %esi
  801a75:	5f                   	pop    %edi
  801a76:	5d                   	pop    %ebp
  801a77:	c3                   	ret    
  801a78:	39 ce                	cmp    %ecx,%esi
  801a7a:	77 28                	ja     801aa4 <__udivdi3+0x7c>
  801a7c:	0f bd fe             	bsr    %esi,%edi
  801a7f:	83 f7 1f             	xor    $0x1f,%edi
  801a82:	75 40                	jne    801ac4 <__udivdi3+0x9c>
  801a84:	39 ce                	cmp    %ecx,%esi
  801a86:	72 0a                	jb     801a92 <__udivdi3+0x6a>
  801a88:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a8c:	0f 87 9e 00 00 00    	ja     801b30 <__udivdi3+0x108>
  801a92:	b8 01 00 00 00       	mov    $0x1,%eax
  801a97:	89 fa                	mov    %edi,%edx
  801a99:	83 c4 1c             	add    $0x1c,%esp
  801a9c:	5b                   	pop    %ebx
  801a9d:	5e                   	pop    %esi
  801a9e:	5f                   	pop    %edi
  801a9f:	5d                   	pop    %ebp
  801aa0:	c3                   	ret    
  801aa1:	8d 76 00             	lea    0x0(%esi),%esi
  801aa4:	31 ff                	xor    %edi,%edi
  801aa6:	31 c0                	xor    %eax,%eax
  801aa8:	89 fa                	mov    %edi,%edx
  801aaa:	83 c4 1c             	add    $0x1c,%esp
  801aad:	5b                   	pop    %ebx
  801aae:	5e                   	pop    %esi
  801aaf:	5f                   	pop    %edi
  801ab0:	5d                   	pop    %ebp
  801ab1:	c3                   	ret    
  801ab2:	66 90                	xchg   %ax,%ax
  801ab4:	89 d8                	mov    %ebx,%eax
  801ab6:	f7 f7                	div    %edi
  801ab8:	31 ff                	xor    %edi,%edi
  801aba:	89 fa                	mov    %edi,%edx
  801abc:	83 c4 1c             	add    $0x1c,%esp
  801abf:	5b                   	pop    %ebx
  801ac0:	5e                   	pop    %esi
  801ac1:	5f                   	pop    %edi
  801ac2:	5d                   	pop    %ebp
  801ac3:	c3                   	ret    
  801ac4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ac9:	89 eb                	mov    %ebp,%ebx
  801acb:	29 fb                	sub    %edi,%ebx
  801acd:	89 f9                	mov    %edi,%ecx
  801acf:	d3 e6                	shl    %cl,%esi
  801ad1:	89 c5                	mov    %eax,%ebp
  801ad3:	88 d9                	mov    %bl,%cl
  801ad5:	d3 ed                	shr    %cl,%ebp
  801ad7:	89 e9                	mov    %ebp,%ecx
  801ad9:	09 f1                	or     %esi,%ecx
  801adb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801adf:	89 f9                	mov    %edi,%ecx
  801ae1:	d3 e0                	shl    %cl,%eax
  801ae3:	89 c5                	mov    %eax,%ebp
  801ae5:	89 d6                	mov    %edx,%esi
  801ae7:	88 d9                	mov    %bl,%cl
  801ae9:	d3 ee                	shr    %cl,%esi
  801aeb:	89 f9                	mov    %edi,%ecx
  801aed:	d3 e2                	shl    %cl,%edx
  801aef:	8b 44 24 08          	mov    0x8(%esp),%eax
  801af3:	88 d9                	mov    %bl,%cl
  801af5:	d3 e8                	shr    %cl,%eax
  801af7:	09 c2                	or     %eax,%edx
  801af9:	89 d0                	mov    %edx,%eax
  801afb:	89 f2                	mov    %esi,%edx
  801afd:	f7 74 24 0c          	divl   0xc(%esp)
  801b01:	89 d6                	mov    %edx,%esi
  801b03:	89 c3                	mov    %eax,%ebx
  801b05:	f7 e5                	mul    %ebp
  801b07:	39 d6                	cmp    %edx,%esi
  801b09:	72 19                	jb     801b24 <__udivdi3+0xfc>
  801b0b:	74 0b                	je     801b18 <__udivdi3+0xf0>
  801b0d:	89 d8                	mov    %ebx,%eax
  801b0f:	31 ff                	xor    %edi,%edi
  801b11:	e9 58 ff ff ff       	jmp    801a6e <__udivdi3+0x46>
  801b16:	66 90                	xchg   %ax,%ax
  801b18:	8b 54 24 08          	mov    0x8(%esp),%edx
  801b1c:	89 f9                	mov    %edi,%ecx
  801b1e:	d3 e2                	shl    %cl,%edx
  801b20:	39 c2                	cmp    %eax,%edx
  801b22:	73 e9                	jae    801b0d <__udivdi3+0xe5>
  801b24:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801b27:	31 ff                	xor    %edi,%edi
  801b29:	e9 40 ff ff ff       	jmp    801a6e <__udivdi3+0x46>
  801b2e:	66 90                	xchg   %ax,%ax
  801b30:	31 c0                	xor    %eax,%eax
  801b32:	e9 37 ff ff ff       	jmp    801a6e <__udivdi3+0x46>
  801b37:	90                   	nop

00801b38 <__umoddi3>:
  801b38:	55                   	push   %ebp
  801b39:	57                   	push   %edi
  801b3a:	56                   	push   %esi
  801b3b:	53                   	push   %ebx
  801b3c:	83 ec 1c             	sub    $0x1c,%esp
  801b3f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b43:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b47:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b4b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b4f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b53:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b57:	89 f3                	mov    %esi,%ebx
  801b59:	89 fa                	mov    %edi,%edx
  801b5b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b5f:	89 34 24             	mov    %esi,(%esp)
  801b62:	85 c0                	test   %eax,%eax
  801b64:	75 1a                	jne    801b80 <__umoddi3+0x48>
  801b66:	39 f7                	cmp    %esi,%edi
  801b68:	0f 86 a2 00 00 00    	jbe    801c10 <__umoddi3+0xd8>
  801b6e:	89 c8                	mov    %ecx,%eax
  801b70:	89 f2                	mov    %esi,%edx
  801b72:	f7 f7                	div    %edi
  801b74:	89 d0                	mov    %edx,%eax
  801b76:	31 d2                	xor    %edx,%edx
  801b78:	83 c4 1c             	add    $0x1c,%esp
  801b7b:	5b                   	pop    %ebx
  801b7c:	5e                   	pop    %esi
  801b7d:	5f                   	pop    %edi
  801b7e:	5d                   	pop    %ebp
  801b7f:	c3                   	ret    
  801b80:	39 f0                	cmp    %esi,%eax
  801b82:	0f 87 ac 00 00 00    	ja     801c34 <__umoddi3+0xfc>
  801b88:	0f bd e8             	bsr    %eax,%ebp
  801b8b:	83 f5 1f             	xor    $0x1f,%ebp
  801b8e:	0f 84 ac 00 00 00    	je     801c40 <__umoddi3+0x108>
  801b94:	bf 20 00 00 00       	mov    $0x20,%edi
  801b99:	29 ef                	sub    %ebp,%edi
  801b9b:	89 fe                	mov    %edi,%esi
  801b9d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801ba1:	89 e9                	mov    %ebp,%ecx
  801ba3:	d3 e0                	shl    %cl,%eax
  801ba5:	89 d7                	mov    %edx,%edi
  801ba7:	89 f1                	mov    %esi,%ecx
  801ba9:	d3 ef                	shr    %cl,%edi
  801bab:	09 c7                	or     %eax,%edi
  801bad:	89 e9                	mov    %ebp,%ecx
  801baf:	d3 e2                	shl    %cl,%edx
  801bb1:	89 14 24             	mov    %edx,(%esp)
  801bb4:	89 d8                	mov    %ebx,%eax
  801bb6:	d3 e0                	shl    %cl,%eax
  801bb8:	89 c2                	mov    %eax,%edx
  801bba:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bbe:	d3 e0                	shl    %cl,%eax
  801bc0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801bc4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bc8:	89 f1                	mov    %esi,%ecx
  801bca:	d3 e8                	shr    %cl,%eax
  801bcc:	09 d0                	or     %edx,%eax
  801bce:	d3 eb                	shr    %cl,%ebx
  801bd0:	89 da                	mov    %ebx,%edx
  801bd2:	f7 f7                	div    %edi
  801bd4:	89 d3                	mov    %edx,%ebx
  801bd6:	f7 24 24             	mull   (%esp)
  801bd9:	89 c6                	mov    %eax,%esi
  801bdb:	89 d1                	mov    %edx,%ecx
  801bdd:	39 d3                	cmp    %edx,%ebx
  801bdf:	0f 82 87 00 00 00    	jb     801c6c <__umoddi3+0x134>
  801be5:	0f 84 91 00 00 00    	je     801c7c <__umoddi3+0x144>
  801beb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bef:	29 f2                	sub    %esi,%edx
  801bf1:	19 cb                	sbb    %ecx,%ebx
  801bf3:	89 d8                	mov    %ebx,%eax
  801bf5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bf9:	d3 e0                	shl    %cl,%eax
  801bfb:	89 e9                	mov    %ebp,%ecx
  801bfd:	d3 ea                	shr    %cl,%edx
  801bff:	09 d0                	or     %edx,%eax
  801c01:	89 e9                	mov    %ebp,%ecx
  801c03:	d3 eb                	shr    %cl,%ebx
  801c05:	89 da                	mov    %ebx,%edx
  801c07:	83 c4 1c             	add    $0x1c,%esp
  801c0a:	5b                   	pop    %ebx
  801c0b:	5e                   	pop    %esi
  801c0c:	5f                   	pop    %edi
  801c0d:	5d                   	pop    %ebp
  801c0e:	c3                   	ret    
  801c0f:	90                   	nop
  801c10:	89 fd                	mov    %edi,%ebp
  801c12:	85 ff                	test   %edi,%edi
  801c14:	75 0b                	jne    801c21 <__umoddi3+0xe9>
  801c16:	b8 01 00 00 00       	mov    $0x1,%eax
  801c1b:	31 d2                	xor    %edx,%edx
  801c1d:	f7 f7                	div    %edi
  801c1f:	89 c5                	mov    %eax,%ebp
  801c21:	89 f0                	mov    %esi,%eax
  801c23:	31 d2                	xor    %edx,%edx
  801c25:	f7 f5                	div    %ebp
  801c27:	89 c8                	mov    %ecx,%eax
  801c29:	f7 f5                	div    %ebp
  801c2b:	89 d0                	mov    %edx,%eax
  801c2d:	e9 44 ff ff ff       	jmp    801b76 <__umoddi3+0x3e>
  801c32:	66 90                	xchg   %ax,%ax
  801c34:	89 c8                	mov    %ecx,%eax
  801c36:	89 f2                	mov    %esi,%edx
  801c38:	83 c4 1c             	add    $0x1c,%esp
  801c3b:	5b                   	pop    %ebx
  801c3c:	5e                   	pop    %esi
  801c3d:	5f                   	pop    %edi
  801c3e:	5d                   	pop    %ebp
  801c3f:	c3                   	ret    
  801c40:	3b 04 24             	cmp    (%esp),%eax
  801c43:	72 06                	jb     801c4b <__umoddi3+0x113>
  801c45:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c49:	77 0f                	ja     801c5a <__umoddi3+0x122>
  801c4b:	89 f2                	mov    %esi,%edx
  801c4d:	29 f9                	sub    %edi,%ecx
  801c4f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c53:	89 14 24             	mov    %edx,(%esp)
  801c56:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c5a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c5e:	8b 14 24             	mov    (%esp),%edx
  801c61:	83 c4 1c             	add    $0x1c,%esp
  801c64:	5b                   	pop    %ebx
  801c65:	5e                   	pop    %esi
  801c66:	5f                   	pop    %edi
  801c67:	5d                   	pop    %ebp
  801c68:	c3                   	ret    
  801c69:	8d 76 00             	lea    0x0(%esi),%esi
  801c6c:	2b 04 24             	sub    (%esp),%eax
  801c6f:	19 fa                	sbb    %edi,%edx
  801c71:	89 d1                	mov    %edx,%ecx
  801c73:	89 c6                	mov    %eax,%esi
  801c75:	e9 71 ff ff ff       	jmp    801beb <__umoddi3+0xb3>
  801c7a:	66 90                	xchg   %ax,%ax
  801c7c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c80:	72 ea                	jb     801c6c <__umoddi3+0x134>
  801c82:	89 d9                	mov    %ebx,%ecx
  801c84:	e9 62 ff ff ff       	jmp    801beb <__umoddi3+0xb3>
