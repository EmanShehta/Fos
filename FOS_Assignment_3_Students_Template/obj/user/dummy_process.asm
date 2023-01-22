
obj/user/dummy_process:     file format elf32-i386


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
  800031:	e8 8d 00 00 00       	call   8000c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>

void high_complexity_function();

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 08             	sub    $0x8,%esp
	high_complexity_function() ;
  80003e:	e8 03 00 00 00       	call   800046 <high_complexity_function>
	return;
  800043:	90                   	nop
}
  800044:	c9                   	leave  
  800045:	c3                   	ret    

00800046 <high_complexity_function>:

void high_complexity_function()
{
  800046:	55                   	push   %ebp
  800047:	89 e5                	mov    %esp,%ebp
  800049:	83 ec 38             	sub    $0x38,%esp
	uint32 end1 = RAND(0, 5000);
  80004c:	8d 45 d4             	lea    -0x2c(%ebp),%eax
  80004f:	83 ec 0c             	sub    $0xc,%esp
  800052:	50                   	push   %eax
  800053:	e8 fc 13 00 00       	call   801454 <sys_get_virtual_time>
  800058:	83 c4 0c             	add    $0xc,%esp
  80005b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80005e:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800063:	ba 00 00 00 00       	mov    $0x0,%edx
  800068:	f7 f1                	div    %ecx
  80006a:	89 55 e8             	mov    %edx,-0x18(%ebp)
	uint32 end2 = RAND(0, 5000);
  80006d:	8d 45 dc             	lea    -0x24(%ebp),%eax
  800070:	83 ec 0c             	sub    $0xc,%esp
  800073:	50                   	push   %eax
  800074:	e8 db 13 00 00       	call   801454 <sys_get_virtual_time>
  800079:	83 c4 0c             	add    $0xc,%esp
  80007c:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80007f:	b9 88 13 00 00       	mov    $0x1388,%ecx
  800084:	ba 00 00 00 00       	mov    $0x0,%edx
  800089:	f7 f1                	div    %ecx
  80008b:	89 55 e4             	mov    %edx,-0x1c(%ebp)
	int x = 10;
  80008e:	c7 45 f4 0a 00 00 00 	movl   $0xa,-0xc(%ebp)
	for(int i = 0; i <= end1; i++)
  800095:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80009c:	eb 1a                	jmp    8000b8 <high_complexity_function+0x72>
	{
		for(int i = 0; i <= end2; i++)
  80009e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8000a5:	eb 06                	jmp    8000ad <high_complexity_function+0x67>
		{
			{
				 x++;
  8000a7:	ff 45 f4             	incl   -0xc(%ebp)
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
	{
		for(int i = 0; i <= end2; i++)
  8000aa:	ff 45 ec             	incl   -0x14(%ebp)
  8000ad:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000b0:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8000b3:	76 f2                	jbe    8000a7 <high_complexity_function+0x61>
void high_complexity_function()
{
	uint32 end1 = RAND(0, 5000);
	uint32 end2 = RAND(0, 5000);
	int x = 10;
	for(int i = 0; i <= end1; i++)
  8000b5:	ff 45 f0             	incl   -0x10(%ebp)
  8000b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000bb:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  8000be:	76 de                	jbe    80009e <high_complexity_function+0x58>
			{
				 x++;
			}
		}
	}
}
  8000c0:	90                   	nop
  8000c1:	c9                   	leave  
  8000c2:	c3                   	ret    

008000c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c3:	55                   	push   %ebp
  8000c4:	89 e5                	mov    %esp,%ebp
  8000c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c9:	e8 10 10 00 00       	call   8010de <sys_getenvindex>
  8000ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d4:	89 d0                	mov    %edx,%eax
  8000d6:	01 c0                	add    %eax,%eax
  8000d8:	01 d0                	add    %edx,%eax
  8000da:	c1 e0 04             	shl    $0x4,%eax
  8000dd:	29 d0                	sub    %edx,%eax
  8000df:	c1 e0 03             	shl    $0x3,%eax
  8000e2:	01 d0                	add    %edx,%eax
  8000e4:	c1 e0 02             	shl    $0x2,%eax
  8000e7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000ec:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000f1:	a1 20 20 80 00       	mov    0x802020,%eax
  8000f6:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8000fc:	84 c0                	test   %al,%al
  8000fe:	74 0f                	je     80010f <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800100:	a1 20 20 80 00       	mov    0x802020,%eax
  800105:	05 5c 05 00 00       	add    $0x55c,%eax
  80010a:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80010f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800113:	7e 0a                	jle    80011f <libmain+0x5c>
		binaryname = argv[0];
  800115:	8b 45 0c             	mov    0xc(%ebp),%eax
  800118:	8b 00                	mov    (%eax),%eax
  80011a:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80011f:	83 ec 08             	sub    $0x8,%esp
  800122:	ff 75 0c             	pushl  0xc(%ebp)
  800125:	ff 75 08             	pushl  0x8(%ebp)
  800128:	e8 0b ff ff ff       	call   800038 <_main>
  80012d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800130:	e8 44 11 00 00       	call   801279 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800135:	83 ec 0c             	sub    $0xc,%esp
  800138:	68 38 19 80 00       	push   $0x801938
  80013d:	e8 71 01 00 00       	call   8002b3 <cprintf>
  800142:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800145:	a1 20 20 80 00       	mov    0x802020,%eax
  80014a:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800150:	a1 20 20 80 00       	mov    0x802020,%eax
  800155:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80015b:	83 ec 04             	sub    $0x4,%esp
  80015e:	52                   	push   %edx
  80015f:	50                   	push   %eax
  800160:	68 60 19 80 00       	push   $0x801960
  800165:	e8 49 01 00 00       	call   8002b3 <cprintf>
  80016a:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80016d:	a1 20 20 80 00       	mov    0x802020,%eax
  800172:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800178:	a1 20 20 80 00       	mov    0x802020,%eax
  80017d:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800183:	a1 20 20 80 00       	mov    0x802020,%eax
  800188:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80018e:	51                   	push   %ecx
  80018f:	52                   	push   %edx
  800190:	50                   	push   %eax
  800191:	68 88 19 80 00       	push   $0x801988
  800196:	e8 18 01 00 00       	call   8002b3 <cprintf>
  80019b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80019e:	83 ec 0c             	sub    $0xc,%esp
  8001a1:	68 38 19 80 00       	push   $0x801938
  8001a6:	e8 08 01 00 00       	call   8002b3 <cprintf>
  8001ab:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001ae:	e8 e0 10 00 00       	call   801293 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001b3:	e8 19 00 00 00       	call   8001d1 <exit>
}
  8001b8:	90                   	nop
  8001b9:	c9                   	leave  
  8001ba:	c3                   	ret    

008001bb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001bb:	55                   	push   %ebp
  8001bc:	89 e5                	mov    %esp,%ebp
  8001be:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001c1:	83 ec 0c             	sub    $0xc,%esp
  8001c4:	6a 00                	push   $0x0
  8001c6:	e8 df 0e 00 00       	call   8010aa <sys_env_destroy>
  8001cb:	83 c4 10             	add    $0x10,%esp
}
  8001ce:	90                   	nop
  8001cf:	c9                   	leave  
  8001d0:	c3                   	ret    

008001d1 <exit>:

void
exit(void)
{
  8001d1:	55                   	push   %ebp
  8001d2:	89 e5                	mov    %esp,%ebp
  8001d4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001d7:	e8 34 0f 00 00       	call   801110 <sys_env_exit>
}
  8001dc:	90                   	nop
  8001dd:	c9                   	leave  
  8001de:	c3                   	ret    

008001df <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001df:	55                   	push   %ebp
  8001e0:	89 e5                	mov    %esp,%ebp
  8001e2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e8:	8b 00                	mov    (%eax),%eax
  8001ea:	8d 48 01             	lea    0x1(%eax),%ecx
  8001ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f0:	89 0a                	mov    %ecx,(%edx)
  8001f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8001f5:	88 d1                	mov    %dl,%cl
  8001f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001fa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800201:	8b 00                	mov    (%eax),%eax
  800203:	3d ff 00 00 00       	cmp    $0xff,%eax
  800208:	75 2c                	jne    800236 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80020a:	a0 24 20 80 00       	mov    0x802024,%al
  80020f:	0f b6 c0             	movzbl %al,%eax
  800212:	8b 55 0c             	mov    0xc(%ebp),%edx
  800215:	8b 12                	mov    (%edx),%edx
  800217:	89 d1                	mov    %edx,%ecx
  800219:	8b 55 0c             	mov    0xc(%ebp),%edx
  80021c:	83 c2 08             	add    $0x8,%edx
  80021f:	83 ec 04             	sub    $0x4,%esp
  800222:	50                   	push   %eax
  800223:	51                   	push   %ecx
  800224:	52                   	push   %edx
  800225:	e8 3e 0e 00 00       	call   801068 <sys_cputs>
  80022a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80022d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800230:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800236:	8b 45 0c             	mov    0xc(%ebp),%eax
  800239:	8b 40 04             	mov    0x4(%eax),%eax
  80023c:	8d 50 01             	lea    0x1(%eax),%edx
  80023f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800242:	89 50 04             	mov    %edx,0x4(%eax)
}
  800245:	90                   	nop
  800246:	c9                   	leave  
  800247:	c3                   	ret    

00800248 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800248:	55                   	push   %ebp
  800249:	89 e5                	mov    %esp,%ebp
  80024b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800251:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800258:	00 00 00 
	b.cnt = 0;
  80025b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800262:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800265:	ff 75 0c             	pushl  0xc(%ebp)
  800268:	ff 75 08             	pushl  0x8(%ebp)
  80026b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800271:	50                   	push   %eax
  800272:	68 df 01 80 00       	push   $0x8001df
  800277:	e8 11 02 00 00       	call   80048d <vprintfmt>
  80027c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80027f:	a0 24 20 80 00       	mov    0x802024,%al
  800284:	0f b6 c0             	movzbl %al,%eax
  800287:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80028d:	83 ec 04             	sub    $0x4,%esp
  800290:	50                   	push   %eax
  800291:	52                   	push   %edx
  800292:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800298:	83 c0 08             	add    $0x8,%eax
  80029b:	50                   	push   %eax
  80029c:	e8 c7 0d 00 00       	call   801068 <sys_cputs>
  8002a1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002a4:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002ab:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002b1:	c9                   	leave  
  8002b2:	c3                   	ret    

008002b3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002b3:	55                   	push   %ebp
  8002b4:	89 e5                	mov    %esp,%ebp
  8002b6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002b9:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002c0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c9:	83 ec 08             	sub    $0x8,%esp
  8002cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8002cf:	50                   	push   %eax
  8002d0:	e8 73 ff ff ff       	call   800248 <vcprintf>
  8002d5:	83 c4 10             	add    $0x10,%esp
  8002d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002e6:	e8 8e 0f 00 00       	call   801279 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002eb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f4:	83 ec 08             	sub    $0x8,%esp
  8002f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8002fa:	50                   	push   %eax
  8002fb:	e8 48 ff ff ff       	call   800248 <vcprintf>
  800300:	83 c4 10             	add    $0x10,%esp
  800303:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800306:	e8 88 0f 00 00       	call   801293 <sys_enable_interrupt>
	return cnt;
  80030b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80030e:	c9                   	leave  
  80030f:	c3                   	ret    

00800310 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800310:	55                   	push   %ebp
  800311:	89 e5                	mov    %esp,%ebp
  800313:	53                   	push   %ebx
  800314:	83 ec 14             	sub    $0x14,%esp
  800317:	8b 45 10             	mov    0x10(%ebp),%eax
  80031a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80031d:	8b 45 14             	mov    0x14(%ebp),%eax
  800320:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800323:	8b 45 18             	mov    0x18(%ebp),%eax
  800326:	ba 00 00 00 00       	mov    $0x0,%edx
  80032b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80032e:	77 55                	ja     800385 <printnum+0x75>
  800330:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800333:	72 05                	jb     80033a <printnum+0x2a>
  800335:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800338:	77 4b                	ja     800385 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80033a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80033d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800340:	8b 45 18             	mov    0x18(%ebp),%eax
  800343:	ba 00 00 00 00       	mov    $0x0,%edx
  800348:	52                   	push   %edx
  800349:	50                   	push   %eax
  80034a:	ff 75 f4             	pushl  -0xc(%ebp)
  80034d:	ff 75 f0             	pushl  -0x10(%ebp)
  800350:	e8 63 13 00 00       	call   8016b8 <__udivdi3>
  800355:	83 c4 10             	add    $0x10,%esp
  800358:	83 ec 04             	sub    $0x4,%esp
  80035b:	ff 75 20             	pushl  0x20(%ebp)
  80035e:	53                   	push   %ebx
  80035f:	ff 75 18             	pushl  0x18(%ebp)
  800362:	52                   	push   %edx
  800363:	50                   	push   %eax
  800364:	ff 75 0c             	pushl  0xc(%ebp)
  800367:	ff 75 08             	pushl  0x8(%ebp)
  80036a:	e8 a1 ff ff ff       	call   800310 <printnum>
  80036f:	83 c4 20             	add    $0x20,%esp
  800372:	eb 1a                	jmp    80038e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800374:	83 ec 08             	sub    $0x8,%esp
  800377:	ff 75 0c             	pushl  0xc(%ebp)
  80037a:	ff 75 20             	pushl  0x20(%ebp)
  80037d:	8b 45 08             	mov    0x8(%ebp),%eax
  800380:	ff d0                	call   *%eax
  800382:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800385:	ff 4d 1c             	decl   0x1c(%ebp)
  800388:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80038c:	7f e6                	jg     800374 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80038e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800391:	bb 00 00 00 00       	mov    $0x0,%ebx
  800396:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800399:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80039c:	53                   	push   %ebx
  80039d:	51                   	push   %ecx
  80039e:	52                   	push   %edx
  80039f:	50                   	push   %eax
  8003a0:	e8 23 14 00 00       	call   8017c8 <__umoddi3>
  8003a5:	83 c4 10             	add    $0x10,%esp
  8003a8:	05 f4 1b 80 00       	add    $0x801bf4,%eax
  8003ad:	8a 00                	mov    (%eax),%al
  8003af:	0f be c0             	movsbl %al,%eax
  8003b2:	83 ec 08             	sub    $0x8,%esp
  8003b5:	ff 75 0c             	pushl  0xc(%ebp)
  8003b8:	50                   	push   %eax
  8003b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bc:	ff d0                	call   *%eax
  8003be:	83 c4 10             	add    $0x10,%esp
}
  8003c1:	90                   	nop
  8003c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003c5:	c9                   	leave  
  8003c6:	c3                   	ret    

008003c7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003c7:	55                   	push   %ebp
  8003c8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003ca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003ce:	7e 1c                	jle    8003ec <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d3:	8b 00                	mov    (%eax),%eax
  8003d5:	8d 50 08             	lea    0x8(%eax),%edx
  8003d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003db:	89 10                	mov    %edx,(%eax)
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	8b 00                	mov    (%eax),%eax
  8003e2:	83 e8 08             	sub    $0x8,%eax
  8003e5:	8b 50 04             	mov    0x4(%eax),%edx
  8003e8:	8b 00                	mov    (%eax),%eax
  8003ea:	eb 40                	jmp    80042c <getuint+0x65>
	else if (lflag)
  8003ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003f0:	74 1e                	je     800410 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	8b 00                	mov    (%eax),%eax
  8003f7:	8d 50 04             	lea    0x4(%eax),%edx
  8003fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fd:	89 10                	mov    %edx,(%eax)
  8003ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800402:	8b 00                	mov    (%eax),%eax
  800404:	83 e8 04             	sub    $0x4,%eax
  800407:	8b 00                	mov    (%eax),%eax
  800409:	ba 00 00 00 00       	mov    $0x0,%edx
  80040e:	eb 1c                	jmp    80042c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
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
}
  80042c:	5d                   	pop    %ebp
  80042d:	c3                   	ret    

0080042e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800431:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800435:	7e 1c                	jle    800453 <getint+0x25>
		return va_arg(*ap, long long);
  800437:	8b 45 08             	mov    0x8(%ebp),%eax
  80043a:	8b 00                	mov    (%eax),%eax
  80043c:	8d 50 08             	lea    0x8(%eax),%edx
  80043f:	8b 45 08             	mov    0x8(%ebp),%eax
  800442:	89 10                	mov    %edx,(%eax)
  800444:	8b 45 08             	mov    0x8(%ebp),%eax
  800447:	8b 00                	mov    (%eax),%eax
  800449:	83 e8 08             	sub    $0x8,%eax
  80044c:	8b 50 04             	mov    0x4(%eax),%edx
  80044f:	8b 00                	mov    (%eax),%eax
  800451:	eb 38                	jmp    80048b <getint+0x5d>
	else if (lflag)
  800453:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800457:	74 1a                	je     800473 <getint+0x45>
		return va_arg(*ap, long);
  800459:	8b 45 08             	mov    0x8(%ebp),%eax
  80045c:	8b 00                	mov    (%eax),%eax
  80045e:	8d 50 04             	lea    0x4(%eax),%edx
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	89 10                	mov    %edx,(%eax)
  800466:	8b 45 08             	mov    0x8(%ebp),%eax
  800469:	8b 00                	mov    (%eax),%eax
  80046b:	83 e8 04             	sub    $0x4,%eax
  80046e:	8b 00                	mov    (%eax),%eax
  800470:	99                   	cltd   
  800471:	eb 18                	jmp    80048b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800473:	8b 45 08             	mov    0x8(%ebp),%eax
  800476:	8b 00                	mov    (%eax),%eax
  800478:	8d 50 04             	lea    0x4(%eax),%edx
  80047b:	8b 45 08             	mov    0x8(%ebp),%eax
  80047e:	89 10                	mov    %edx,(%eax)
  800480:	8b 45 08             	mov    0x8(%ebp),%eax
  800483:	8b 00                	mov    (%eax),%eax
  800485:	83 e8 04             	sub    $0x4,%eax
  800488:	8b 00                	mov    (%eax),%eax
  80048a:	99                   	cltd   
}
  80048b:	5d                   	pop    %ebp
  80048c:	c3                   	ret    

0080048d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80048d:	55                   	push   %ebp
  80048e:	89 e5                	mov    %esp,%ebp
  800490:	56                   	push   %esi
  800491:	53                   	push   %ebx
  800492:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800495:	eb 17                	jmp    8004ae <vprintfmt+0x21>
			if (ch == '\0')
  800497:	85 db                	test   %ebx,%ebx
  800499:	0f 84 af 03 00 00    	je     80084e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80049f:	83 ec 08             	sub    $0x8,%esp
  8004a2:	ff 75 0c             	pushl  0xc(%ebp)
  8004a5:	53                   	push   %ebx
  8004a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a9:	ff d0                	call   *%eax
  8004ab:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8004b1:	8d 50 01             	lea    0x1(%eax),%edx
  8004b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b7:	8a 00                	mov    (%eax),%al
  8004b9:	0f b6 d8             	movzbl %al,%ebx
  8004bc:	83 fb 25             	cmp    $0x25,%ebx
  8004bf:	75 d6                	jne    800497 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004c1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004c5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004cc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004d3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e4:	8d 50 01             	lea    0x1(%eax),%edx
  8004e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8004ea:	8a 00                	mov    (%eax),%al
  8004ec:	0f b6 d8             	movzbl %al,%ebx
  8004ef:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004f2:	83 f8 55             	cmp    $0x55,%eax
  8004f5:	0f 87 2b 03 00 00    	ja     800826 <vprintfmt+0x399>
  8004fb:	8b 04 85 18 1c 80 00 	mov    0x801c18(,%eax,4),%eax
  800502:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800504:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800508:	eb d7                	jmp    8004e1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80050a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80050e:	eb d1                	jmp    8004e1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800510:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800517:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80051a:	89 d0                	mov    %edx,%eax
  80051c:	c1 e0 02             	shl    $0x2,%eax
  80051f:	01 d0                	add    %edx,%eax
  800521:	01 c0                	add    %eax,%eax
  800523:	01 d8                	add    %ebx,%eax
  800525:	83 e8 30             	sub    $0x30,%eax
  800528:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80052b:	8b 45 10             	mov    0x10(%ebp),%eax
  80052e:	8a 00                	mov    (%eax),%al
  800530:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800533:	83 fb 2f             	cmp    $0x2f,%ebx
  800536:	7e 3e                	jle    800576 <vprintfmt+0xe9>
  800538:	83 fb 39             	cmp    $0x39,%ebx
  80053b:	7f 39                	jg     800576 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80053d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800540:	eb d5                	jmp    800517 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800542:	8b 45 14             	mov    0x14(%ebp),%eax
  800545:	83 c0 04             	add    $0x4,%eax
  800548:	89 45 14             	mov    %eax,0x14(%ebp)
  80054b:	8b 45 14             	mov    0x14(%ebp),%eax
  80054e:	83 e8 04             	sub    $0x4,%eax
  800551:	8b 00                	mov    (%eax),%eax
  800553:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800556:	eb 1f                	jmp    800577 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800558:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80055c:	79 83                	jns    8004e1 <vprintfmt+0x54>
				width = 0;
  80055e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800565:	e9 77 ff ff ff       	jmp    8004e1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80056a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800571:	e9 6b ff ff ff       	jmp    8004e1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800576:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800577:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80057b:	0f 89 60 ff ff ff    	jns    8004e1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800581:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800584:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800587:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80058e:	e9 4e ff ff ff       	jmp    8004e1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800593:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800596:	e9 46 ff ff ff       	jmp    8004e1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80059b:	8b 45 14             	mov    0x14(%ebp),%eax
  80059e:	83 c0 04             	add    $0x4,%eax
  8005a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a7:	83 e8 04             	sub    $0x4,%eax
  8005aa:	8b 00                	mov    (%eax),%eax
  8005ac:	83 ec 08             	sub    $0x8,%esp
  8005af:	ff 75 0c             	pushl  0xc(%ebp)
  8005b2:	50                   	push   %eax
  8005b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b6:	ff d0                	call   *%eax
  8005b8:	83 c4 10             	add    $0x10,%esp
			break;
  8005bb:	e9 89 02 00 00       	jmp    800849 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c3:	83 c0 04             	add    $0x4,%eax
  8005c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005cc:	83 e8 04             	sub    $0x4,%eax
  8005cf:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005d1:	85 db                	test   %ebx,%ebx
  8005d3:	79 02                	jns    8005d7 <vprintfmt+0x14a>
				err = -err;
  8005d5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005d7:	83 fb 64             	cmp    $0x64,%ebx
  8005da:	7f 0b                	jg     8005e7 <vprintfmt+0x15a>
  8005dc:	8b 34 9d 60 1a 80 00 	mov    0x801a60(,%ebx,4),%esi
  8005e3:	85 f6                	test   %esi,%esi
  8005e5:	75 19                	jne    800600 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005e7:	53                   	push   %ebx
  8005e8:	68 05 1c 80 00       	push   $0x801c05
  8005ed:	ff 75 0c             	pushl  0xc(%ebp)
  8005f0:	ff 75 08             	pushl  0x8(%ebp)
  8005f3:	e8 5e 02 00 00       	call   800856 <printfmt>
  8005f8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005fb:	e9 49 02 00 00       	jmp    800849 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800600:	56                   	push   %esi
  800601:	68 0e 1c 80 00       	push   $0x801c0e
  800606:	ff 75 0c             	pushl  0xc(%ebp)
  800609:	ff 75 08             	pushl  0x8(%ebp)
  80060c:	e8 45 02 00 00       	call   800856 <printfmt>
  800611:	83 c4 10             	add    $0x10,%esp
			break;
  800614:	e9 30 02 00 00       	jmp    800849 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800619:	8b 45 14             	mov    0x14(%ebp),%eax
  80061c:	83 c0 04             	add    $0x4,%eax
  80061f:	89 45 14             	mov    %eax,0x14(%ebp)
  800622:	8b 45 14             	mov    0x14(%ebp),%eax
  800625:	83 e8 04             	sub    $0x4,%eax
  800628:	8b 30                	mov    (%eax),%esi
  80062a:	85 f6                	test   %esi,%esi
  80062c:	75 05                	jne    800633 <vprintfmt+0x1a6>
				p = "(null)";
  80062e:	be 11 1c 80 00       	mov    $0x801c11,%esi
			if (width > 0 && padc != '-')
  800633:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800637:	7e 6d                	jle    8006a6 <vprintfmt+0x219>
  800639:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80063d:	74 67                	je     8006a6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80063f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800642:	83 ec 08             	sub    $0x8,%esp
  800645:	50                   	push   %eax
  800646:	56                   	push   %esi
  800647:	e8 0c 03 00 00       	call   800958 <strnlen>
  80064c:	83 c4 10             	add    $0x10,%esp
  80064f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800652:	eb 16                	jmp    80066a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800654:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800658:	83 ec 08             	sub    $0x8,%esp
  80065b:	ff 75 0c             	pushl  0xc(%ebp)
  80065e:	50                   	push   %eax
  80065f:	8b 45 08             	mov    0x8(%ebp),%eax
  800662:	ff d0                	call   *%eax
  800664:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800667:	ff 4d e4             	decl   -0x1c(%ebp)
  80066a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066e:	7f e4                	jg     800654 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800670:	eb 34                	jmp    8006a6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800672:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800676:	74 1c                	je     800694 <vprintfmt+0x207>
  800678:	83 fb 1f             	cmp    $0x1f,%ebx
  80067b:	7e 05                	jle    800682 <vprintfmt+0x1f5>
  80067d:	83 fb 7e             	cmp    $0x7e,%ebx
  800680:	7e 12                	jle    800694 <vprintfmt+0x207>
					putch('?', putdat);
  800682:	83 ec 08             	sub    $0x8,%esp
  800685:	ff 75 0c             	pushl  0xc(%ebp)
  800688:	6a 3f                	push   $0x3f
  80068a:	8b 45 08             	mov    0x8(%ebp),%eax
  80068d:	ff d0                	call   *%eax
  80068f:	83 c4 10             	add    $0x10,%esp
  800692:	eb 0f                	jmp    8006a3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800694:	83 ec 08             	sub    $0x8,%esp
  800697:	ff 75 0c             	pushl  0xc(%ebp)
  80069a:	53                   	push   %ebx
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	ff d0                	call   *%eax
  8006a0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006a3:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a6:	89 f0                	mov    %esi,%eax
  8006a8:	8d 70 01             	lea    0x1(%eax),%esi
  8006ab:	8a 00                	mov    (%eax),%al
  8006ad:	0f be d8             	movsbl %al,%ebx
  8006b0:	85 db                	test   %ebx,%ebx
  8006b2:	74 24                	je     8006d8 <vprintfmt+0x24b>
  8006b4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b8:	78 b8                	js     800672 <vprintfmt+0x1e5>
  8006ba:	ff 4d e0             	decl   -0x20(%ebp)
  8006bd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006c1:	79 af                	jns    800672 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006c3:	eb 13                	jmp    8006d8 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006c5:	83 ec 08             	sub    $0x8,%esp
  8006c8:	ff 75 0c             	pushl  0xc(%ebp)
  8006cb:	6a 20                	push   $0x20
  8006cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d0:	ff d0                	call   *%eax
  8006d2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d5:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006dc:	7f e7                	jg     8006c5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006de:	e9 66 01 00 00       	jmp    800849 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006e3:	83 ec 08             	sub    $0x8,%esp
  8006e6:	ff 75 e8             	pushl  -0x18(%ebp)
  8006e9:	8d 45 14             	lea    0x14(%ebp),%eax
  8006ec:	50                   	push   %eax
  8006ed:	e8 3c fd ff ff       	call   80042e <getint>
  8006f2:	83 c4 10             	add    $0x10,%esp
  8006f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800701:	85 d2                	test   %edx,%edx
  800703:	79 23                	jns    800728 <vprintfmt+0x29b>
				putch('-', putdat);
  800705:	83 ec 08             	sub    $0x8,%esp
  800708:	ff 75 0c             	pushl  0xc(%ebp)
  80070b:	6a 2d                	push   $0x2d
  80070d:	8b 45 08             	mov    0x8(%ebp),%eax
  800710:	ff d0                	call   *%eax
  800712:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800715:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800718:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80071b:	f7 d8                	neg    %eax
  80071d:	83 d2 00             	adc    $0x0,%edx
  800720:	f7 da                	neg    %edx
  800722:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800725:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800728:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072f:	e9 bc 00 00 00       	jmp    8007f0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800734:	83 ec 08             	sub    $0x8,%esp
  800737:	ff 75 e8             	pushl  -0x18(%ebp)
  80073a:	8d 45 14             	lea    0x14(%ebp),%eax
  80073d:	50                   	push   %eax
  80073e:	e8 84 fc ff ff       	call   8003c7 <getuint>
  800743:	83 c4 10             	add    $0x10,%esp
  800746:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800749:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80074c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800753:	e9 98 00 00 00       	jmp    8007f0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800758:	83 ec 08             	sub    $0x8,%esp
  80075b:	ff 75 0c             	pushl  0xc(%ebp)
  80075e:	6a 58                	push   $0x58
  800760:	8b 45 08             	mov    0x8(%ebp),%eax
  800763:	ff d0                	call   *%eax
  800765:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800768:	83 ec 08             	sub    $0x8,%esp
  80076b:	ff 75 0c             	pushl  0xc(%ebp)
  80076e:	6a 58                	push   $0x58
  800770:	8b 45 08             	mov    0x8(%ebp),%eax
  800773:	ff d0                	call   *%eax
  800775:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800778:	83 ec 08             	sub    $0x8,%esp
  80077b:	ff 75 0c             	pushl  0xc(%ebp)
  80077e:	6a 58                	push   $0x58
  800780:	8b 45 08             	mov    0x8(%ebp),%eax
  800783:	ff d0                	call   *%eax
  800785:	83 c4 10             	add    $0x10,%esp
			break;
  800788:	e9 bc 00 00 00       	jmp    800849 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80078d:	83 ec 08             	sub    $0x8,%esp
  800790:	ff 75 0c             	pushl  0xc(%ebp)
  800793:	6a 30                	push   $0x30
  800795:	8b 45 08             	mov    0x8(%ebp),%eax
  800798:	ff d0                	call   *%eax
  80079a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80079d:	83 ec 08             	sub    $0x8,%esp
  8007a0:	ff 75 0c             	pushl  0xc(%ebp)
  8007a3:	6a 78                	push   $0x78
  8007a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a8:	ff d0                	call   *%eax
  8007aa:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b0:	83 c0 04             	add    $0x4,%eax
  8007b3:	89 45 14             	mov    %eax,0x14(%ebp)
  8007b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b9:	83 e8 04             	sub    $0x4,%eax
  8007bc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007c8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007cf:	eb 1f                	jmp    8007f0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007d1:	83 ec 08             	sub    $0x8,%esp
  8007d4:	ff 75 e8             	pushl  -0x18(%ebp)
  8007d7:	8d 45 14             	lea    0x14(%ebp),%eax
  8007da:	50                   	push   %eax
  8007db:	e8 e7 fb ff ff       	call   8003c7 <getuint>
  8007e0:	83 c4 10             	add    $0x10,%esp
  8007e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007e9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007f0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007f7:	83 ec 04             	sub    $0x4,%esp
  8007fa:	52                   	push   %edx
  8007fb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007fe:	50                   	push   %eax
  8007ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800802:	ff 75 f0             	pushl  -0x10(%ebp)
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	ff 75 08             	pushl  0x8(%ebp)
  80080b:	e8 00 fb ff ff       	call   800310 <printnum>
  800810:	83 c4 20             	add    $0x20,%esp
			break;
  800813:	eb 34                	jmp    800849 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800815:	83 ec 08             	sub    $0x8,%esp
  800818:	ff 75 0c             	pushl  0xc(%ebp)
  80081b:	53                   	push   %ebx
  80081c:	8b 45 08             	mov    0x8(%ebp),%eax
  80081f:	ff d0                	call   *%eax
  800821:	83 c4 10             	add    $0x10,%esp
			break;
  800824:	eb 23                	jmp    800849 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800826:	83 ec 08             	sub    $0x8,%esp
  800829:	ff 75 0c             	pushl  0xc(%ebp)
  80082c:	6a 25                	push   $0x25
  80082e:	8b 45 08             	mov    0x8(%ebp),%eax
  800831:	ff d0                	call   *%eax
  800833:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800836:	ff 4d 10             	decl   0x10(%ebp)
  800839:	eb 03                	jmp    80083e <vprintfmt+0x3b1>
  80083b:	ff 4d 10             	decl   0x10(%ebp)
  80083e:	8b 45 10             	mov    0x10(%ebp),%eax
  800841:	48                   	dec    %eax
  800842:	8a 00                	mov    (%eax),%al
  800844:	3c 25                	cmp    $0x25,%al
  800846:	75 f3                	jne    80083b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800848:	90                   	nop
		}
	}
  800849:	e9 47 fc ff ff       	jmp    800495 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80084e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80084f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800852:	5b                   	pop    %ebx
  800853:	5e                   	pop    %esi
  800854:	5d                   	pop    %ebp
  800855:	c3                   	ret    

00800856 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800856:	55                   	push   %ebp
  800857:	89 e5                	mov    %esp,%ebp
  800859:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80085c:	8d 45 10             	lea    0x10(%ebp),%eax
  80085f:	83 c0 04             	add    $0x4,%eax
  800862:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800865:	8b 45 10             	mov    0x10(%ebp),%eax
  800868:	ff 75 f4             	pushl  -0xc(%ebp)
  80086b:	50                   	push   %eax
  80086c:	ff 75 0c             	pushl  0xc(%ebp)
  80086f:	ff 75 08             	pushl  0x8(%ebp)
  800872:	e8 16 fc ff ff       	call   80048d <vprintfmt>
  800877:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80087a:	90                   	nop
  80087b:	c9                   	leave  
  80087c:	c3                   	ret    

0080087d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80087d:	55                   	push   %ebp
  80087e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800880:	8b 45 0c             	mov    0xc(%ebp),%eax
  800883:	8b 40 08             	mov    0x8(%eax),%eax
  800886:	8d 50 01             	lea    0x1(%eax),%edx
  800889:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80088f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800892:	8b 10                	mov    (%eax),%edx
  800894:	8b 45 0c             	mov    0xc(%ebp),%eax
  800897:	8b 40 04             	mov    0x4(%eax),%eax
  80089a:	39 c2                	cmp    %eax,%edx
  80089c:	73 12                	jae    8008b0 <sprintputch+0x33>
		*b->buf++ = ch;
  80089e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008a1:	8b 00                	mov    (%eax),%eax
  8008a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8008a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a9:	89 0a                	mov    %ecx,(%edx)
  8008ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ae:	88 10                	mov    %dl,(%eax)
}
  8008b0:	90                   	nop
  8008b1:	5d                   	pop    %ebp
  8008b2:	c3                   	ret    

008008b3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008b3:	55                   	push   %ebp
  8008b4:	89 e5                	mov    %esp,%ebp
  8008b6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	01 d0                	add    %edx,%eax
  8008ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008d8:	74 06                	je     8008e0 <vsnprintf+0x2d>
  8008da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008de:	7f 07                	jg     8008e7 <vsnprintf+0x34>
		return -E_INVAL;
  8008e0:	b8 03 00 00 00       	mov    $0x3,%eax
  8008e5:	eb 20                	jmp    800907 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008e7:	ff 75 14             	pushl  0x14(%ebp)
  8008ea:	ff 75 10             	pushl  0x10(%ebp)
  8008ed:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008f0:	50                   	push   %eax
  8008f1:	68 7d 08 80 00       	push   $0x80087d
  8008f6:	e8 92 fb ff ff       	call   80048d <vprintfmt>
  8008fb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800901:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800904:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800907:	c9                   	leave  
  800908:	c3                   	ret    

00800909 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800909:	55                   	push   %ebp
  80090a:	89 e5                	mov    %esp,%ebp
  80090c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80090f:	8d 45 10             	lea    0x10(%ebp),%eax
  800912:	83 c0 04             	add    $0x4,%eax
  800915:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800918:	8b 45 10             	mov    0x10(%ebp),%eax
  80091b:	ff 75 f4             	pushl  -0xc(%ebp)
  80091e:	50                   	push   %eax
  80091f:	ff 75 0c             	pushl  0xc(%ebp)
  800922:	ff 75 08             	pushl  0x8(%ebp)
  800925:	e8 89 ff ff ff       	call   8008b3 <vsnprintf>
  80092a:	83 c4 10             	add    $0x10,%esp
  80092d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800930:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800933:	c9                   	leave  
  800934:	c3                   	ret    

00800935 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800935:	55                   	push   %ebp
  800936:	89 e5                	mov    %esp,%ebp
  800938:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80093b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800942:	eb 06                	jmp    80094a <strlen+0x15>
		n++;
  800944:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800947:	ff 45 08             	incl   0x8(%ebp)
  80094a:	8b 45 08             	mov    0x8(%ebp),%eax
  80094d:	8a 00                	mov    (%eax),%al
  80094f:	84 c0                	test   %al,%al
  800951:	75 f1                	jne    800944 <strlen+0xf>
		n++;
	return n;
  800953:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800956:	c9                   	leave  
  800957:	c3                   	ret    

00800958 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800958:	55                   	push   %ebp
  800959:	89 e5                	mov    %esp,%ebp
  80095b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80095e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800965:	eb 09                	jmp    800970 <strnlen+0x18>
		n++;
  800967:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80096a:	ff 45 08             	incl   0x8(%ebp)
  80096d:	ff 4d 0c             	decl   0xc(%ebp)
  800970:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800974:	74 09                	je     80097f <strnlen+0x27>
  800976:	8b 45 08             	mov    0x8(%ebp),%eax
  800979:	8a 00                	mov    (%eax),%al
  80097b:	84 c0                	test   %al,%al
  80097d:	75 e8                	jne    800967 <strnlen+0xf>
		n++;
	return n;
  80097f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800982:	c9                   	leave  
  800983:	c3                   	ret    

00800984 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800984:	55                   	push   %ebp
  800985:	89 e5                	mov    %esp,%ebp
  800987:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  80098a:	8b 45 08             	mov    0x8(%ebp),%eax
  80098d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800990:	90                   	nop
  800991:	8b 45 08             	mov    0x8(%ebp),%eax
  800994:	8d 50 01             	lea    0x1(%eax),%edx
  800997:	89 55 08             	mov    %edx,0x8(%ebp)
  80099a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099d:	8d 4a 01             	lea    0x1(%edx),%ecx
  8009a0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009a3:	8a 12                	mov    (%edx),%dl
  8009a5:	88 10                	mov    %dl,(%eax)
  8009a7:	8a 00                	mov    (%eax),%al
  8009a9:	84 c0                	test   %al,%al
  8009ab:	75 e4                	jne    800991 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009b0:	c9                   	leave  
  8009b1:	c3                   	ret    

008009b2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009b2:	55                   	push   %ebp
  8009b3:	89 e5                	mov    %esp,%ebp
  8009b5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009be:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c5:	eb 1f                	jmp    8009e6 <strncpy+0x34>
		*dst++ = *src;
  8009c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ca:	8d 50 01             	lea    0x1(%eax),%edx
  8009cd:	89 55 08             	mov    %edx,0x8(%ebp)
  8009d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d3:	8a 12                	mov    (%edx),%dl
  8009d5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009da:	8a 00                	mov    (%eax),%al
  8009dc:	84 c0                	test   %al,%al
  8009de:	74 03                	je     8009e3 <strncpy+0x31>
			src++;
  8009e0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009e3:	ff 45 fc             	incl   -0x4(%ebp)
  8009e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009e9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009ec:	72 d9                	jb     8009c7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009ee:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009f1:	c9                   	leave  
  8009f2:	c3                   	ret    

008009f3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009f3:	55                   	push   %ebp
  8009f4:	89 e5                	mov    %esp,%ebp
  8009f6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a03:	74 30                	je     800a35 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a05:	eb 16                	jmp    800a1d <strlcpy+0x2a>
			*dst++ = *src++;
  800a07:	8b 45 08             	mov    0x8(%ebp),%eax
  800a0a:	8d 50 01             	lea    0x1(%eax),%edx
  800a0d:	89 55 08             	mov    %edx,0x8(%ebp)
  800a10:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a13:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a16:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a19:	8a 12                	mov    (%edx),%dl
  800a1b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a1d:	ff 4d 10             	decl   0x10(%ebp)
  800a20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a24:	74 09                	je     800a2f <strlcpy+0x3c>
  800a26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a29:	8a 00                	mov    (%eax),%al
  800a2b:	84 c0                	test   %al,%al
  800a2d:	75 d8                	jne    800a07 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a32:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a35:	8b 55 08             	mov    0x8(%ebp),%edx
  800a38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a3b:	29 c2                	sub    %eax,%edx
  800a3d:	89 d0                	mov    %edx,%eax
}
  800a3f:	c9                   	leave  
  800a40:	c3                   	ret    

00800a41 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a41:	55                   	push   %ebp
  800a42:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a44:	eb 06                	jmp    800a4c <strcmp+0xb>
		p++, q++;
  800a46:	ff 45 08             	incl   0x8(%ebp)
  800a49:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4f:	8a 00                	mov    (%eax),%al
  800a51:	84 c0                	test   %al,%al
  800a53:	74 0e                	je     800a63 <strcmp+0x22>
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	8a 10                	mov    (%eax),%dl
  800a5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5d:	8a 00                	mov    (%eax),%al
  800a5f:	38 c2                	cmp    %al,%dl
  800a61:	74 e3                	je     800a46 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	8a 00                	mov    (%eax),%al
  800a68:	0f b6 d0             	movzbl %al,%edx
  800a6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6e:	8a 00                	mov    (%eax),%al
  800a70:	0f b6 c0             	movzbl %al,%eax
  800a73:	29 c2                	sub    %eax,%edx
  800a75:	89 d0                	mov    %edx,%eax
}
  800a77:	5d                   	pop    %ebp
  800a78:	c3                   	ret    

00800a79 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a79:	55                   	push   %ebp
  800a7a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a7c:	eb 09                	jmp    800a87 <strncmp+0xe>
		n--, p++, q++;
  800a7e:	ff 4d 10             	decl   0x10(%ebp)
  800a81:	ff 45 08             	incl   0x8(%ebp)
  800a84:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a8b:	74 17                	je     800aa4 <strncmp+0x2b>
  800a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a90:	8a 00                	mov    (%eax),%al
  800a92:	84 c0                	test   %al,%al
  800a94:	74 0e                	je     800aa4 <strncmp+0x2b>
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	8a 10                	mov    (%eax),%dl
  800a9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9e:	8a 00                	mov    (%eax),%al
  800aa0:	38 c2                	cmp    %al,%dl
  800aa2:	74 da                	je     800a7e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aa4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa8:	75 07                	jne    800ab1 <strncmp+0x38>
		return 0;
  800aaa:	b8 00 00 00 00       	mov    $0x0,%eax
  800aaf:	eb 14                	jmp    800ac5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab4:	8a 00                	mov    (%eax),%al
  800ab6:	0f b6 d0             	movzbl %al,%edx
  800ab9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800abc:	8a 00                	mov    (%eax),%al
  800abe:	0f b6 c0             	movzbl %al,%eax
  800ac1:	29 c2                	sub    %eax,%edx
  800ac3:	89 d0                	mov    %edx,%eax
}
  800ac5:	5d                   	pop    %ebp
  800ac6:	c3                   	ret    

00800ac7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ac7:	55                   	push   %ebp
  800ac8:	89 e5                	mov    %esp,%ebp
  800aca:	83 ec 04             	sub    $0x4,%esp
  800acd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ad3:	eb 12                	jmp    800ae7 <strchr+0x20>
		if (*s == c)
  800ad5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad8:	8a 00                	mov    (%eax),%al
  800ada:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800add:	75 05                	jne    800ae4 <strchr+0x1d>
			return (char *) s;
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	eb 11                	jmp    800af5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ae4:	ff 45 08             	incl   0x8(%ebp)
  800ae7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aea:	8a 00                	mov    (%eax),%al
  800aec:	84 c0                	test   %al,%al
  800aee:	75 e5                	jne    800ad5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800af0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800af5:	c9                   	leave  
  800af6:	c3                   	ret    

00800af7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800af7:	55                   	push   %ebp
  800af8:	89 e5                	mov    %esp,%ebp
  800afa:	83 ec 04             	sub    $0x4,%esp
  800afd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b00:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b03:	eb 0d                	jmp    800b12 <strfind+0x1b>
		if (*s == c)
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	8a 00                	mov    (%eax),%al
  800b0a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b0d:	74 0e                	je     800b1d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b0f:	ff 45 08             	incl   0x8(%ebp)
  800b12:	8b 45 08             	mov    0x8(%ebp),%eax
  800b15:	8a 00                	mov    (%eax),%al
  800b17:	84 c0                	test   %al,%al
  800b19:	75 ea                	jne    800b05 <strfind+0xe>
  800b1b:	eb 01                	jmp    800b1e <strfind+0x27>
		if (*s == c)
			break;
  800b1d:	90                   	nop
	return (char *) s;
  800b1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b21:	c9                   	leave  
  800b22:	c3                   	ret    

00800b23 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b23:	55                   	push   %ebp
  800b24:	89 e5                	mov    %esp,%ebp
  800b26:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b29:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b32:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b35:	eb 0e                	jmp    800b45 <memset+0x22>
		*p++ = c;
  800b37:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b3a:	8d 50 01             	lea    0x1(%eax),%edx
  800b3d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b43:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b45:	ff 4d f8             	decl   -0x8(%ebp)
  800b48:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b4c:	79 e9                	jns    800b37 <memset+0x14>
		*p++ = c;

	return v;
  800b4e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b51:	c9                   	leave  
  800b52:	c3                   	ret    

00800b53 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b53:	55                   	push   %ebp
  800b54:	89 e5                	mov    %esp,%ebp
  800b56:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b62:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b65:	eb 16                	jmp    800b7d <memcpy+0x2a>
		*d++ = *s++;
  800b67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b6a:	8d 50 01             	lea    0x1(%eax),%edx
  800b6d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b70:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b73:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b76:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b79:	8a 12                	mov    (%edx),%dl
  800b7b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800b80:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b83:	89 55 10             	mov    %edx,0x10(%ebp)
  800b86:	85 c0                	test   %eax,%eax
  800b88:	75 dd                	jne    800b67 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b8d:	c9                   	leave  
  800b8e:	c3                   	ret    

00800b8f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
  800b92:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ba1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ba7:	73 50                	jae    800bf9 <memmove+0x6a>
  800ba9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bac:	8b 45 10             	mov    0x10(%ebp),%eax
  800baf:	01 d0                	add    %edx,%eax
  800bb1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bb4:	76 43                	jbe    800bf9 <memmove+0x6a>
		s += n;
  800bb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbf:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bc2:	eb 10                	jmp    800bd4 <memmove+0x45>
			*--d = *--s;
  800bc4:	ff 4d f8             	decl   -0x8(%ebp)
  800bc7:	ff 4d fc             	decl   -0x4(%ebp)
  800bca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bcd:	8a 10                	mov    (%eax),%dl
  800bcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bd2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bda:	89 55 10             	mov    %edx,0x10(%ebp)
  800bdd:	85 c0                	test   %eax,%eax
  800bdf:	75 e3                	jne    800bc4 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800be1:	eb 23                	jmp    800c06 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800be3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be6:	8d 50 01             	lea    0x1(%eax),%edx
  800be9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800bec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bef:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bf2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bf5:	8a 12                	mov    (%edx),%dl
  800bf7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bf9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bff:	89 55 10             	mov    %edx,0x10(%ebp)
  800c02:	85 c0                	test   %eax,%eax
  800c04:	75 dd                	jne    800be3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c09:	c9                   	leave  
  800c0a:	c3                   	ret    

00800c0b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c0b:	55                   	push   %ebp
  800c0c:	89 e5                	mov    %esp,%ebp
  800c0e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c11:	8b 45 08             	mov    0x8(%ebp),%eax
  800c14:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c1a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c1d:	eb 2a                	jmp    800c49 <memcmp+0x3e>
		if (*s1 != *s2)
  800c1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c22:	8a 10                	mov    (%eax),%dl
  800c24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c27:	8a 00                	mov    (%eax),%al
  800c29:	38 c2                	cmp    %al,%dl
  800c2b:	74 16                	je     800c43 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c30:	8a 00                	mov    (%eax),%al
  800c32:	0f b6 d0             	movzbl %al,%edx
  800c35:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c38:	8a 00                	mov    (%eax),%al
  800c3a:	0f b6 c0             	movzbl %al,%eax
  800c3d:	29 c2                	sub    %eax,%edx
  800c3f:	89 d0                	mov    %edx,%eax
  800c41:	eb 18                	jmp    800c5b <memcmp+0x50>
		s1++, s2++;
  800c43:	ff 45 fc             	incl   -0x4(%ebp)
  800c46:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c49:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c4f:	89 55 10             	mov    %edx,0x10(%ebp)
  800c52:	85 c0                	test   %eax,%eax
  800c54:	75 c9                	jne    800c1f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c56:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c5b:	c9                   	leave  
  800c5c:	c3                   	ret    

00800c5d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c5d:	55                   	push   %ebp
  800c5e:	89 e5                	mov    %esp,%ebp
  800c60:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c63:	8b 55 08             	mov    0x8(%ebp),%edx
  800c66:	8b 45 10             	mov    0x10(%ebp),%eax
  800c69:	01 d0                	add    %edx,%eax
  800c6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c6e:	eb 15                	jmp    800c85 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c70:	8b 45 08             	mov    0x8(%ebp),%eax
  800c73:	8a 00                	mov    (%eax),%al
  800c75:	0f b6 d0             	movzbl %al,%edx
  800c78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7b:	0f b6 c0             	movzbl %al,%eax
  800c7e:	39 c2                	cmp    %eax,%edx
  800c80:	74 0d                	je     800c8f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c82:	ff 45 08             	incl   0x8(%ebp)
  800c85:	8b 45 08             	mov    0x8(%ebp),%eax
  800c88:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c8b:	72 e3                	jb     800c70 <memfind+0x13>
  800c8d:	eb 01                	jmp    800c90 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c8f:	90                   	nop
	return (void *) s;
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c93:	c9                   	leave  
  800c94:	c3                   	ret    

00800c95 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c95:	55                   	push   %ebp
  800c96:	89 e5                	mov    %esp,%ebp
  800c98:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ca2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ca9:	eb 03                	jmp    800cae <strtol+0x19>
		s++;
  800cab:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	8a 00                	mov    (%eax),%al
  800cb3:	3c 20                	cmp    $0x20,%al
  800cb5:	74 f4                	je     800cab <strtol+0x16>
  800cb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	3c 09                	cmp    $0x9,%al
  800cbe:	74 eb                	je     800cab <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc3:	8a 00                	mov    (%eax),%al
  800cc5:	3c 2b                	cmp    $0x2b,%al
  800cc7:	75 05                	jne    800cce <strtol+0x39>
		s++;
  800cc9:	ff 45 08             	incl   0x8(%ebp)
  800ccc:	eb 13                	jmp    800ce1 <strtol+0x4c>
	else if (*s == '-')
  800cce:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd1:	8a 00                	mov    (%eax),%al
  800cd3:	3c 2d                	cmp    $0x2d,%al
  800cd5:	75 0a                	jne    800ce1 <strtol+0x4c>
		s++, neg = 1;
  800cd7:	ff 45 08             	incl   0x8(%ebp)
  800cda:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800ce1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce5:	74 06                	je     800ced <strtol+0x58>
  800ce7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ceb:	75 20                	jne    800d0d <strtol+0x78>
  800ced:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf0:	8a 00                	mov    (%eax),%al
  800cf2:	3c 30                	cmp    $0x30,%al
  800cf4:	75 17                	jne    800d0d <strtol+0x78>
  800cf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf9:	40                   	inc    %eax
  800cfa:	8a 00                	mov    (%eax),%al
  800cfc:	3c 78                	cmp    $0x78,%al
  800cfe:	75 0d                	jne    800d0d <strtol+0x78>
		s += 2, base = 16;
  800d00:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d04:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d0b:	eb 28                	jmp    800d35 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d11:	75 15                	jne    800d28 <strtol+0x93>
  800d13:	8b 45 08             	mov    0x8(%ebp),%eax
  800d16:	8a 00                	mov    (%eax),%al
  800d18:	3c 30                	cmp    $0x30,%al
  800d1a:	75 0c                	jne    800d28 <strtol+0x93>
		s++, base = 8;
  800d1c:	ff 45 08             	incl   0x8(%ebp)
  800d1f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d26:	eb 0d                	jmp    800d35 <strtol+0xa0>
	else if (base == 0)
  800d28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d2c:	75 07                	jne    800d35 <strtol+0xa0>
		base = 10;
  800d2e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	3c 2f                	cmp    $0x2f,%al
  800d3c:	7e 19                	jle    800d57 <strtol+0xc2>
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d41:	8a 00                	mov    (%eax),%al
  800d43:	3c 39                	cmp    $0x39,%al
  800d45:	7f 10                	jg     800d57 <strtol+0xc2>
			dig = *s - '0';
  800d47:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4a:	8a 00                	mov    (%eax),%al
  800d4c:	0f be c0             	movsbl %al,%eax
  800d4f:	83 e8 30             	sub    $0x30,%eax
  800d52:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d55:	eb 42                	jmp    800d99 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d57:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5a:	8a 00                	mov    (%eax),%al
  800d5c:	3c 60                	cmp    $0x60,%al
  800d5e:	7e 19                	jle    800d79 <strtol+0xe4>
  800d60:	8b 45 08             	mov    0x8(%ebp),%eax
  800d63:	8a 00                	mov    (%eax),%al
  800d65:	3c 7a                	cmp    $0x7a,%al
  800d67:	7f 10                	jg     800d79 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d69:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6c:	8a 00                	mov    (%eax),%al
  800d6e:	0f be c0             	movsbl %al,%eax
  800d71:	83 e8 57             	sub    $0x57,%eax
  800d74:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d77:	eb 20                	jmp    800d99 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d79:	8b 45 08             	mov    0x8(%ebp),%eax
  800d7c:	8a 00                	mov    (%eax),%al
  800d7e:	3c 40                	cmp    $0x40,%al
  800d80:	7e 39                	jle    800dbb <strtol+0x126>
  800d82:	8b 45 08             	mov    0x8(%ebp),%eax
  800d85:	8a 00                	mov    (%eax),%al
  800d87:	3c 5a                	cmp    $0x5a,%al
  800d89:	7f 30                	jg     800dbb <strtol+0x126>
			dig = *s - 'A' + 10;
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	8a 00                	mov    (%eax),%al
  800d90:	0f be c0             	movsbl %al,%eax
  800d93:	83 e8 37             	sub    $0x37,%eax
  800d96:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d9c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d9f:	7d 19                	jge    800dba <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800da1:	ff 45 08             	incl   0x8(%ebp)
  800da4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da7:	0f af 45 10          	imul   0x10(%ebp),%eax
  800dab:	89 c2                	mov    %eax,%edx
  800dad:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800db0:	01 d0                	add    %edx,%eax
  800db2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800db5:	e9 7b ff ff ff       	jmp    800d35 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800dba:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800dbb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dbf:	74 08                	je     800dc9 <strtol+0x134>
		*endptr = (char *) s;
  800dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc4:	8b 55 08             	mov    0x8(%ebp),%edx
  800dc7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dc9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dcd:	74 07                	je     800dd6 <strtol+0x141>
  800dcf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd2:	f7 d8                	neg    %eax
  800dd4:	eb 03                	jmp    800dd9 <strtol+0x144>
  800dd6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dd9:	c9                   	leave  
  800dda:	c3                   	ret    

00800ddb <ltostr>:

void
ltostr(long value, char *str)
{
  800ddb:	55                   	push   %ebp
  800ddc:	89 e5                	mov    %esp,%ebp
  800dde:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800de1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800de8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800def:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800df3:	79 13                	jns    800e08 <ltostr+0x2d>
	{
		neg = 1;
  800df5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800dfc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dff:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e02:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e05:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e10:	99                   	cltd   
  800e11:	f7 f9                	idiv   %ecx
  800e13:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e16:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e19:	8d 50 01             	lea    0x1(%eax),%edx
  800e1c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e1f:	89 c2                	mov    %eax,%edx
  800e21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e24:	01 d0                	add    %edx,%eax
  800e26:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e29:	83 c2 30             	add    $0x30,%edx
  800e2c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e2e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e31:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e36:	f7 e9                	imul   %ecx
  800e38:	c1 fa 02             	sar    $0x2,%edx
  800e3b:	89 c8                	mov    %ecx,%eax
  800e3d:	c1 f8 1f             	sar    $0x1f,%eax
  800e40:	29 c2                	sub    %eax,%edx
  800e42:	89 d0                	mov    %edx,%eax
  800e44:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e47:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e4a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e4f:	f7 e9                	imul   %ecx
  800e51:	c1 fa 02             	sar    $0x2,%edx
  800e54:	89 c8                	mov    %ecx,%eax
  800e56:	c1 f8 1f             	sar    $0x1f,%eax
  800e59:	29 c2                	sub    %eax,%edx
  800e5b:	89 d0                	mov    %edx,%eax
  800e5d:	c1 e0 02             	shl    $0x2,%eax
  800e60:	01 d0                	add    %edx,%eax
  800e62:	01 c0                	add    %eax,%eax
  800e64:	29 c1                	sub    %eax,%ecx
  800e66:	89 ca                	mov    %ecx,%edx
  800e68:	85 d2                	test   %edx,%edx
  800e6a:	75 9c                	jne    800e08 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e76:	48                   	dec    %eax
  800e77:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e7e:	74 3d                	je     800ebd <ltostr+0xe2>
		start = 1 ;
  800e80:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e87:	eb 34                	jmp    800ebd <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8f:	01 d0                	add    %edx,%eax
  800e91:	8a 00                	mov    (%eax),%al
  800e93:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9c:	01 c2                	add    %eax,%edx
  800e9e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800ea1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea4:	01 c8                	add    %ecx,%eax
  800ea6:	8a 00                	mov    (%eax),%al
  800ea8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800eaa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800ead:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eb0:	01 c2                	add    %eax,%edx
  800eb2:	8a 45 eb             	mov    -0x15(%ebp),%al
  800eb5:	88 02                	mov    %al,(%edx)
		start++ ;
  800eb7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800eba:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800ebd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ec0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ec3:	7c c4                	jl     800e89 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ec5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecb:	01 d0                	add    %edx,%eax
  800ecd:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ed0:	90                   	nop
  800ed1:	c9                   	leave  
  800ed2:	c3                   	ret    

00800ed3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ed3:	55                   	push   %ebp
  800ed4:	89 e5                	mov    %esp,%ebp
  800ed6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ed9:	ff 75 08             	pushl  0x8(%ebp)
  800edc:	e8 54 fa ff ff       	call   800935 <strlen>
  800ee1:	83 c4 04             	add    $0x4,%esp
  800ee4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ee7:	ff 75 0c             	pushl  0xc(%ebp)
  800eea:	e8 46 fa ff ff       	call   800935 <strlen>
  800eef:	83 c4 04             	add    $0x4,%esp
  800ef2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ef5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800efc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f03:	eb 17                	jmp    800f1c <strcconcat+0x49>
		final[s] = str1[s] ;
  800f05:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f08:	8b 45 10             	mov    0x10(%ebp),%eax
  800f0b:	01 c2                	add    %eax,%edx
  800f0d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f10:	8b 45 08             	mov    0x8(%ebp),%eax
  800f13:	01 c8                	add    %ecx,%eax
  800f15:	8a 00                	mov    (%eax),%al
  800f17:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f19:	ff 45 fc             	incl   -0x4(%ebp)
  800f1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f22:	7c e1                	jl     800f05 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f24:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f2b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f32:	eb 1f                	jmp    800f53 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f37:	8d 50 01             	lea    0x1(%eax),%edx
  800f3a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f3d:	89 c2                	mov    %eax,%edx
  800f3f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f42:	01 c2                	add    %eax,%edx
  800f44:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f47:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4a:	01 c8                	add    %ecx,%eax
  800f4c:	8a 00                	mov    (%eax),%al
  800f4e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f50:	ff 45 f8             	incl   -0x8(%ebp)
  800f53:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f56:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f59:	7c d9                	jl     800f34 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f5b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f61:	01 d0                	add    %edx,%eax
  800f63:	c6 00 00             	movb   $0x0,(%eax)
}
  800f66:	90                   	nop
  800f67:	c9                   	leave  
  800f68:	c3                   	ret    

00800f69 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f69:	55                   	push   %ebp
  800f6a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f6c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f75:	8b 45 14             	mov    0x14(%ebp),%eax
  800f78:	8b 00                	mov    (%eax),%eax
  800f7a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f81:	8b 45 10             	mov    0x10(%ebp),%eax
  800f84:	01 d0                	add    %edx,%eax
  800f86:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f8c:	eb 0c                	jmp    800f9a <strsplit+0x31>
			*string++ = 0;
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	8d 50 01             	lea    0x1(%eax),%edx
  800f94:	89 55 08             	mov    %edx,0x8(%ebp)
  800f97:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9d:	8a 00                	mov    (%eax),%al
  800f9f:	84 c0                	test   %al,%al
  800fa1:	74 18                	je     800fbb <strsplit+0x52>
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	0f be c0             	movsbl %al,%eax
  800fab:	50                   	push   %eax
  800fac:	ff 75 0c             	pushl  0xc(%ebp)
  800faf:	e8 13 fb ff ff       	call   800ac7 <strchr>
  800fb4:	83 c4 08             	add    $0x8,%esp
  800fb7:	85 c0                	test   %eax,%eax
  800fb9:	75 d3                	jne    800f8e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbe:	8a 00                	mov    (%eax),%al
  800fc0:	84 c0                	test   %al,%al
  800fc2:	74 5a                	je     80101e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc7:	8b 00                	mov    (%eax),%eax
  800fc9:	83 f8 0f             	cmp    $0xf,%eax
  800fcc:	75 07                	jne    800fd5 <strsplit+0x6c>
		{
			return 0;
  800fce:	b8 00 00 00 00       	mov    $0x0,%eax
  800fd3:	eb 66                	jmp    80103b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fd5:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd8:	8b 00                	mov    (%eax),%eax
  800fda:	8d 48 01             	lea    0x1(%eax),%ecx
  800fdd:	8b 55 14             	mov    0x14(%ebp),%edx
  800fe0:	89 0a                	mov    %ecx,(%edx)
  800fe2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fe9:	8b 45 10             	mov    0x10(%ebp),%eax
  800fec:	01 c2                	add    %eax,%edx
  800fee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ff3:	eb 03                	jmp    800ff8 <strsplit+0x8f>
			string++;
  800ff5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ff8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffb:	8a 00                	mov    (%eax),%al
  800ffd:	84 c0                	test   %al,%al
  800fff:	74 8b                	je     800f8c <strsplit+0x23>
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	8a 00                	mov    (%eax),%al
  801006:	0f be c0             	movsbl %al,%eax
  801009:	50                   	push   %eax
  80100a:	ff 75 0c             	pushl  0xc(%ebp)
  80100d:	e8 b5 fa ff ff       	call   800ac7 <strchr>
  801012:	83 c4 08             	add    $0x8,%esp
  801015:	85 c0                	test   %eax,%eax
  801017:	74 dc                	je     800ff5 <strsplit+0x8c>
			string++;
	}
  801019:	e9 6e ff ff ff       	jmp    800f8c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80101e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80101f:	8b 45 14             	mov    0x14(%ebp),%eax
  801022:	8b 00                	mov    (%eax),%eax
  801024:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80102b:	8b 45 10             	mov    0x10(%ebp),%eax
  80102e:	01 d0                	add    %edx,%eax
  801030:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801036:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80103b:	c9                   	leave  
  80103c:	c3                   	ret    

0080103d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80103d:	55                   	push   %ebp
  80103e:	89 e5                	mov    %esp,%ebp
  801040:	57                   	push   %edi
  801041:	56                   	push   %esi
  801042:	53                   	push   %ebx
  801043:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	8b 55 0c             	mov    0xc(%ebp),%edx
  80104c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80104f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801052:	8b 7d 18             	mov    0x18(%ebp),%edi
  801055:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801058:	cd 30                	int    $0x30
  80105a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80105d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801060:	83 c4 10             	add    $0x10,%esp
  801063:	5b                   	pop    %ebx
  801064:	5e                   	pop    %esi
  801065:	5f                   	pop    %edi
  801066:	5d                   	pop    %ebp
  801067:	c3                   	ret    

00801068 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801068:	55                   	push   %ebp
  801069:	89 e5                	mov    %esp,%ebp
  80106b:	83 ec 04             	sub    $0x4,%esp
  80106e:	8b 45 10             	mov    0x10(%ebp),%eax
  801071:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801074:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801078:	8b 45 08             	mov    0x8(%ebp),%eax
  80107b:	6a 00                	push   $0x0
  80107d:	6a 00                	push   $0x0
  80107f:	52                   	push   %edx
  801080:	ff 75 0c             	pushl  0xc(%ebp)
  801083:	50                   	push   %eax
  801084:	6a 00                	push   $0x0
  801086:	e8 b2 ff ff ff       	call   80103d <syscall>
  80108b:	83 c4 18             	add    $0x18,%esp
}
  80108e:	90                   	nop
  80108f:	c9                   	leave  
  801090:	c3                   	ret    

00801091 <sys_cgetc>:

int
sys_cgetc(void)
{
  801091:	55                   	push   %ebp
  801092:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801094:	6a 00                	push   $0x0
  801096:	6a 00                	push   $0x0
  801098:	6a 00                	push   $0x0
  80109a:	6a 00                	push   $0x0
  80109c:	6a 00                	push   $0x0
  80109e:	6a 01                	push   $0x1
  8010a0:	e8 98 ff ff ff       	call   80103d <syscall>
  8010a5:	83 c4 18             	add    $0x18,%esp
}
  8010a8:	c9                   	leave  
  8010a9:	c3                   	ret    

008010aa <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010aa:	55                   	push   %ebp
  8010ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b0:	6a 00                	push   $0x0
  8010b2:	6a 00                	push   $0x0
  8010b4:	6a 00                	push   $0x0
  8010b6:	6a 00                	push   $0x0
  8010b8:	50                   	push   %eax
  8010b9:	6a 05                	push   $0x5
  8010bb:	e8 7d ff ff ff       	call   80103d <syscall>
  8010c0:	83 c4 18             	add    $0x18,%esp
}
  8010c3:	c9                   	leave  
  8010c4:	c3                   	ret    

008010c5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010c5:	55                   	push   %ebp
  8010c6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010c8:	6a 00                	push   $0x0
  8010ca:	6a 00                	push   $0x0
  8010cc:	6a 00                	push   $0x0
  8010ce:	6a 00                	push   $0x0
  8010d0:	6a 00                	push   $0x0
  8010d2:	6a 02                	push   $0x2
  8010d4:	e8 64 ff ff ff       	call   80103d <syscall>
  8010d9:	83 c4 18             	add    $0x18,%esp
}
  8010dc:	c9                   	leave  
  8010dd:	c3                   	ret    

008010de <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010de:	55                   	push   %ebp
  8010df:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010e1:	6a 00                	push   $0x0
  8010e3:	6a 00                	push   $0x0
  8010e5:	6a 00                	push   $0x0
  8010e7:	6a 00                	push   $0x0
  8010e9:	6a 00                	push   $0x0
  8010eb:	6a 03                	push   $0x3
  8010ed:	e8 4b ff ff ff       	call   80103d <syscall>
  8010f2:	83 c4 18             	add    $0x18,%esp
}
  8010f5:	c9                   	leave  
  8010f6:	c3                   	ret    

008010f7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010f7:	55                   	push   %ebp
  8010f8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010fa:	6a 00                	push   $0x0
  8010fc:	6a 00                	push   $0x0
  8010fe:	6a 00                	push   $0x0
  801100:	6a 00                	push   $0x0
  801102:	6a 00                	push   $0x0
  801104:	6a 04                	push   $0x4
  801106:	e8 32 ff ff ff       	call   80103d <syscall>
  80110b:	83 c4 18             	add    $0x18,%esp
}
  80110e:	c9                   	leave  
  80110f:	c3                   	ret    

00801110 <sys_env_exit>:


void sys_env_exit(void)
{
  801110:	55                   	push   %ebp
  801111:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801113:	6a 00                	push   $0x0
  801115:	6a 00                	push   $0x0
  801117:	6a 00                	push   $0x0
  801119:	6a 00                	push   $0x0
  80111b:	6a 00                	push   $0x0
  80111d:	6a 06                	push   $0x6
  80111f:	e8 19 ff ff ff       	call   80103d <syscall>
  801124:	83 c4 18             	add    $0x18,%esp
}
  801127:	90                   	nop
  801128:	c9                   	leave  
  801129:	c3                   	ret    

0080112a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80112a:	55                   	push   %ebp
  80112b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80112d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	6a 00                	push   $0x0
  801135:	6a 00                	push   $0x0
  801137:	6a 00                	push   $0x0
  801139:	52                   	push   %edx
  80113a:	50                   	push   %eax
  80113b:	6a 07                	push   $0x7
  80113d:	e8 fb fe ff ff       	call   80103d <syscall>
  801142:	83 c4 18             	add    $0x18,%esp
}
  801145:	c9                   	leave  
  801146:	c3                   	ret    

00801147 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801147:	55                   	push   %ebp
  801148:	89 e5                	mov    %esp,%ebp
  80114a:	56                   	push   %esi
  80114b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80114c:	8b 75 18             	mov    0x18(%ebp),%esi
  80114f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801152:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801155:	8b 55 0c             	mov    0xc(%ebp),%edx
  801158:	8b 45 08             	mov    0x8(%ebp),%eax
  80115b:	56                   	push   %esi
  80115c:	53                   	push   %ebx
  80115d:	51                   	push   %ecx
  80115e:	52                   	push   %edx
  80115f:	50                   	push   %eax
  801160:	6a 08                	push   $0x8
  801162:	e8 d6 fe ff ff       	call   80103d <syscall>
  801167:	83 c4 18             	add    $0x18,%esp
}
  80116a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80116d:	5b                   	pop    %ebx
  80116e:	5e                   	pop    %esi
  80116f:	5d                   	pop    %ebp
  801170:	c3                   	ret    

00801171 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801171:	55                   	push   %ebp
  801172:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801174:	8b 55 0c             	mov    0xc(%ebp),%edx
  801177:	8b 45 08             	mov    0x8(%ebp),%eax
  80117a:	6a 00                	push   $0x0
  80117c:	6a 00                	push   $0x0
  80117e:	6a 00                	push   $0x0
  801180:	52                   	push   %edx
  801181:	50                   	push   %eax
  801182:	6a 09                	push   $0x9
  801184:	e8 b4 fe ff ff       	call   80103d <syscall>
  801189:	83 c4 18             	add    $0x18,%esp
}
  80118c:	c9                   	leave  
  80118d:	c3                   	ret    

0080118e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80118e:	55                   	push   %ebp
  80118f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801191:	6a 00                	push   $0x0
  801193:	6a 00                	push   $0x0
  801195:	6a 00                	push   $0x0
  801197:	ff 75 0c             	pushl  0xc(%ebp)
  80119a:	ff 75 08             	pushl  0x8(%ebp)
  80119d:	6a 0a                	push   $0xa
  80119f:	e8 99 fe ff ff       	call   80103d <syscall>
  8011a4:	83 c4 18             	add    $0x18,%esp
}
  8011a7:	c9                   	leave  
  8011a8:	c3                   	ret    

008011a9 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011a9:	55                   	push   %ebp
  8011aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011ac:	6a 00                	push   $0x0
  8011ae:	6a 00                	push   $0x0
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 00                	push   $0x0
  8011b4:	6a 00                	push   $0x0
  8011b6:	6a 0b                	push   $0xb
  8011b8:	e8 80 fe ff ff       	call   80103d <syscall>
  8011bd:	83 c4 18             	add    $0x18,%esp
}
  8011c0:	c9                   	leave  
  8011c1:	c3                   	ret    

008011c2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011c5:	6a 00                	push   $0x0
  8011c7:	6a 00                	push   $0x0
  8011c9:	6a 00                	push   $0x0
  8011cb:	6a 00                	push   $0x0
  8011cd:	6a 00                	push   $0x0
  8011cf:	6a 0c                	push   $0xc
  8011d1:	e8 67 fe ff ff       	call   80103d <syscall>
  8011d6:	83 c4 18             	add    $0x18,%esp
}
  8011d9:	c9                   	leave  
  8011da:	c3                   	ret    

008011db <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011db:	55                   	push   %ebp
  8011dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011de:	6a 00                	push   $0x0
  8011e0:	6a 00                	push   $0x0
  8011e2:	6a 00                	push   $0x0
  8011e4:	6a 00                	push   $0x0
  8011e6:	6a 00                	push   $0x0
  8011e8:	6a 0d                	push   $0xd
  8011ea:	e8 4e fe ff ff       	call   80103d <syscall>
  8011ef:	83 c4 18             	add    $0x18,%esp
}
  8011f2:	c9                   	leave  
  8011f3:	c3                   	ret    

008011f4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011f4:	55                   	push   %ebp
  8011f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011f7:	6a 00                	push   $0x0
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	ff 75 0c             	pushl  0xc(%ebp)
  801200:	ff 75 08             	pushl  0x8(%ebp)
  801203:	6a 11                	push   $0x11
  801205:	e8 33 fe ff ff       	call   80103d <syscall>
  80120a:	83 c4 18             	add    $0x18,%esp
	return;
  80120d:	90                   	nop
}
  80120e:	c9                   	leave  
  80120f:	c3                   	ret    

00801210 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801210:	55                   	push   %ebp
  801211:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	ff 75 0c             	pushl  0xc(%ebp)
  80121c:	ff 75 08             	pushl  0x8(%ebp)
  80121f:	6a 12                	push   $0x12
  801221:	e8 17 fe ff ff       	call   80103d <syscall>
  801226:	83 c4 18             	add    $0x18,%esp
	return ;
  801229:	90                   	nop
}
  80122a:	c9                   	leave  
  80122b:	c3                   	ret    

0080122c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80122c:	55                   	push   %ebp
  80122d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	6a 0e                	push   $0xe
  80123b:	e8 fd fd ff ff       	call   80103d <syscall>
  801240:	83 c4 18             	add    $0x18,%esp
}
  801243:	c9                   	leave  
  801244:	c3                   	ret    

00801245 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801245:	55                   	push   %ebp
  801246:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	ff 75 08             	pushl  0x8(%ebp)
  801253:	6a 0f                	push   $0xf
  801255:	e8 e3 fd ff ff       	call   80103d <syscall>
  80125a:	83 c4 18             	add    $0x18,%esp
}
  80125d:	c9                   	leave  
  80125e:	c3                   	ret    

0080125f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80125f:	55                   	push   %ebp
  801260:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801262:	6a 00                	push   $0x0
  801264:	6a 00                	push   $0x0
  801266:	6a 00                	push   $0x0
  801268:	6a 00                	push   $0x0
  80126a:	6a 00                	push   $0x0
  80126c:	6a 10                	push   $0x10
  80126e:	e8 ca fd ff ff       	call   80103d <syscall>
  801273:	83 c4 18             	add    $0x18,%esp
}
  801276:	90                   	nop
  801277:	c9                   	leave  
  801278:	c3                   	ret    

00801279 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801279:	55                   	push   %ebp
  80127a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 00                	push   $0x0
  801284:	6a 00                	push   $0x0
  801286:	6a 14                	push   $0x14
  801288:	e8 b0 fd ff ff       	call   80103d <syscall>
  80128d:	83 c4 18             	add    $0x18,%esp
}
  801290:	90                   	nop
  801291:	c9                   	leave  
  801292:	c3                   	ret    

00801293 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801293:	55                   	push   %ebp
  801294:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801296:	6a 00                	push   $0x0
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	6a 00                	push   $0x0
  8012a0:	6a 15                	push   $0x15
  8012a2:	e8 96 fd ff ff       	call   80103d <syscall>
  8012a7:	83 c4 18             	add    $0x18,%esp
}
  8012aa:	90                   	nop
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <sys_cputc>:


void
sys_cputc(const char c)
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
  8012b0:	83 ec 04             	sub    $0x4,%esp
  8012b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012b9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	50                   	push   %eax
  8012c6:	6a 16                	push   $0x16
  8012c8:	e8 70 fd ff ff       	call   80103d <syscall>
  8012cd:	83 c4 18             	add    $0x18,%esp
}
  8012d0:	90                   	nop
  8012d1:	c9                   	leave  
  8012d2:	c3                   	ret    

008012d3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012d3:	55                   	push   %ebp
  8012d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012d6:	6a 00                	push   $0x0
  8012d8:	6a 00                	push   $0x0
  8012da:	6a 00                	push   $0x0
  8012dc:	6a 00                	push   $0x0
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 17                	push   $0x17
  8012e2:	e8 56 fd ff ff       	call   80103d <syscall>
  8012e7:	83 c4 18             	add    $0x18,%esp
}
  8012ea:	90                   	nop
  8012eb:	c9                   	leave  
  8012ec:	c3                   	ret    

008012ed <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012ed:	55                   	push   %ebp
  8012ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f3:	6a 00                	push   $0x0
  8012f5:	6a 00                	push   $0x0
  8012f7:	6a 00                	push   $0x0
  8012f9:	ff 75 0c             	pushl  0xc(%ebp)
  8012fc:	50                   	push   %eax
  8012fd:	6a 18                	push   $0x18
  8012ff:	e8 39 fd ff ff       	call   80103d <syscall>
  801304:	83 c4 18             	add    $0x18,%esp
}
  801307:	c9                   	leave  
  801308:	c3                   	ret    

00801309 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801309:	55                   	push   %ebp
  80130a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80130c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130f:	8b 45 08             	mov    0x8(%ebp),%eax
  801312:	6a 00                	push   $0x0
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	52                   	push   %edx
  801319:	50                   	push   %eax
  80131a:	6a 1b                	push   $0x1b
  80131c:	e8 1c fd ff ff       	call   80103d <syscall>
  801321:	83 c4 18             	add    $0x18,%esp
}
  801324:	c9                   	leave  
  801325:	c3                   	ret    

00801326 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801326:	55                   	push   %ebp
  801327:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801329:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132c:	8b 45 08             	mov    0x8(%ebp),%eax
  80132f:	6a 00                	push   $0x0
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	52                   	push   %edx
  801336:	50                   	push   %eax
  801337:	6a 19                	push   $0x19
  801339:	e8 ff fc ff ff       	call   80103d <syscall>
  80133e:	83 c4 18             	add    $0x18,%esp
}
  801341:	90                   	nop
  801342:	c9                   	leave  
  801343:	c3                   	ret    

00801344 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801344:	55                   	push   %ebp
  801345:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801347:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	6a 00                	push   $0x0
  80134f:	6a 00                	push   $0x0
  801351:	6a 00                	push   $0x0
  801353:	52                   	push   %edx
  801354:	50                   	push   %eax
  801355:	6a 1a                	push   $0x1a
  801357:	e8 e1 fc ff ff       	call   80103d <syscall>
  80135c:	83 c4 18             	add    $0x18,%esp
}
  80135f:	90                   	nop
  801360:	c9                   	leave  
  801361:	c3                   	ret    

00801362 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801362:	55                   	push   %ebp
  801363:	89 e5                	mov    %esp,%ebp
  801365:	83 ec 04             	sub    $0x4,%esp
  801368:	8b 45 10             	mov    0x10(%ebp),%eax
  80136b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80136e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801371:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801375:	8b 45 08             	mov    0x8(%ebp),%eax
  801378:	6a 00                	push   $0x0
  80137a:	51                   	push   %ecx
  80137b:	52                   	push   %edx
  80137c:	ff 75 0c             	pushl  0xc(%ebp)
  80137f:	50                   	push   %eax
  801380:	6a 1c                	push   $0x1c
  801382:	e8 b6 fc ff ff       	call   80103d <syscall>
  801387:	83 c4 18             	add    $0x18,%esp
}
  80138a:	c9                   	leave  
  80138b:	c3                   	ret    

0080138c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80138c:	55                   	push   %ebp
  80138d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80138f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801392:	8b 45 08             	mov    0x8(%ebp),%eax
  801395:	6a 00                	push   $0x0
  801397:	6a 00                	push   $0x0
  801399:	6a 00                	push   $0x0
  80139b:	52                   	push   %edx
  80139c:	50                   	push   %eax
  80139d:	6a 1d                	push   $0x1d
  80139f:	e8 99 fc ff ff       	call   80103d <syscall>
  8013a4:	83 c4 18             	add    $0x18,%esp
}
  8013a7:	c9                   	leave  
  8013a8:	c3                   	ret    

008013a9 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013a9:	55                   	push   %ebp
  8013aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	6a 00                	push   $0x0
  8013b7:	6a 00                	push   $0x0
  8013b9:	51                   	push   %ecx
  8013ba:	52                   	push   %edx
  8013bb:	50                   	push   %eax
  8013bc:	6a 1e                	push   $0x1e
  8013be:	e8 7a fc ff ff       	call   80103d <syscall>
  8013c3:	83 c4 18             	add    $0x18,%esp
}
  8013c6:	c9                   	leave  
  8013c7:	c3                   	ret    

008013c8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013c8:	55                   	push   %ebp
  8013c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	6a 00                	push   $0x0
  8013d3:	6a 00                	push   $0x0
  8013d5:	6a 00                	push   $0x0
  8013d7:	52                   	push   %edx
  8013d8:	50                   	push   %eax
  8013d9:	6a 1f                	push   $0x1f
  8013db:	e8 5d fc ff ff       	call   80103d <syscall>
  8013e0:	83 c4 18             	add    $0x18,%esp
}
  8013e3:	c9                   	leave  
  8013e4:	c3                   	ret    

008013e5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013e5:	55                   	push   %ebp
  8013e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013e8:	6a 00                	push   $0x0
  8013ea:	6a 00                	push   $0x0
  8013ec:	6a 00                	push   $0x0
  8013ee:	6a 00                	push   $0x0
  8013f0:	6a 00                	push   $0x0
  8013f2:	6a 20                	push   $0x20
  8013f4:	e8 44 fc ff ff       	call   80103d <syscall>
  8013f9:	83 c4 18             	add    $0x18,%esp
}
  8013fc:	c9                   	leave  
  8013fd:	c3                   	ret    

008013fe <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013fe:	55                   	push   %ebp
  8013ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801401:	8b 45 08             	mov    0x8(%ebp),%eax
  801404:	6a 00                	push   $0x0
  801406:	ff 75 14             	pushl  0x14(%ebp)
  801409:	ff 75 10             	pushl  0x10(%ebp)
  80140c:	ff 75 0c             	pushl  0xc(%ebp)
  80140f:	50                   	push   %eax
  801410:	6a 21                	push   $0x21
  801412:	e8 26 fc ff ff       	call   80103d <syscall>
  801417:	83 c4 18             	add    $0x18,%esp
}
  80141a:	c9                   	leave  
  80141b:	c3                   	ret    

0080141c <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80141c:	55                   	push   %ebp
  80141d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	50                   	push   %eax
  80142b:	6a 22                	push   $0x22
  80142d:	e8 0b fc ff ff       	call   80103d <syscall>
  801432:	83 c4 18             	add    $0x18,%esp
}
  801435:	90                   	nop
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	6a 00                	push   $0x0
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	50                   	push   %eax
  801447:	6a 23                	push   $0x23
  801449:	e8 ef fb ff ff       	call   80103d <syscall>
  80144e:	83 c4 18             	add    $0x18,%esp
}
  801451:	90                   	nop
  801452:	c9                   	leave  
  801453:	c3                   	ret    

00801454 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801454:	55                   	push   %ebp
  801455:	89 e5                	mov    %esp,%ebp
  801457:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80145a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80145d:	8d 50 04             	lea    0x4(%eax),%edx
  801460:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801463:	6a 00                	push   $0x0
  801465:	6a 00                	push   $0x0
  801467:	6a 00                	push   $0x0
  801469:	52                   	push   %edx
  80146a:	50                   	push   %eax
  80146b:	6a 24                	push   $0x24
  80146d:	e8 cb fb ff ff       	call   80103d <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
	return result;
  801475:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801478:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80147b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80147e:	89 01                	mov    %eax,(%ecx)
  801480:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801483:	8b 45 08             	mov    0x8(%ebp),%eax
  801486:	c9                   	leave  
  801487:	c2 04 00             	ret    $0x4

0080148a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80148d:	6a 00                	push   $0x0
  80148f:	6a 00                	push   $0x0
  801491:	ff 75 10             	pushl  0x10(%ebp)
  801494:	ff 75 0c             	pushl  0xc(%ebp)
  801497:	ff 75 08             	pushl  0x8(%ebp)
  80149a:	6a 13                	push   $0x13
  80149c:	e8 9c fb ff ff       	call   80103d <syscall>
  8014a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a4:	90                   	nop
}
  8014a5:	c9                   	leave  
  8014a6:	c3                   	ret    

008014a7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014a7:	55                   	push   %ebp
  8014a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014aa:	6a 00                	push   $0x0
  8014ac:	6a 00                	push   $0x0
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 25                	push   $0x25
  8014b6:	e8 82 fb ff ff       	call   80103d <syscall>
  8014bb:	83 c4 18             	add    $0x18,%esp
}
  8014be:	c9                   	leave  
  8014bf:	c3                   	ret    

008014c0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014c0:	55                   	push   %ebp
  8014c1:	89 e5                	mov    %esp,%ebp
  8014c3:	83 ec 04             	sub    $0x4,%esp
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014cc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 00                	push   $0x0
  8014d6:	6a 00                	push   $0x0
  8014d8:	50                   	push   %eax
  8014d9:	6a 26                	push   $0x26
  8014db:	e8 5d fb ff ff       	call   80103d <syscall>
  8014e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e3:	90                   	nop
}
  8014e4:	c9                   	leave  
  8014e5:	c3                   	ret    

008014e6 <rsttst>:
void rsttst()
{
  8014e6:	55                   	push   %ebp
  8014e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 00                	push   $0x0
  8014ef:	6a 00                	push   $0x0
  8014f1:	6a 00                	push   $0x0
  8014f3:	6a 28                	push   $0x28
  8014f5:	e8 43 fb ff ff       	call   80103d <syscall>
  8014fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8014fd:	90                   	nop
}
  8014fe:	c9                   	leave  
  8014ff:	c3                   	ret    

00801500 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801500:	55                   	push   %ebp
  801501:	89 e5                	mov    %esp,%ebp
  801503:	83 ec 04             	sub    $0x4,%esp
  801506:	8b 45 14             	mov    0x14(%ebp),%eax
  801509:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80150c:	8b 55 18             	mov    0x18(%ebp),%edx
  80150f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801513:	52                   	push   %edx
  801514:	50                   	push   %eax
  801515:	ff 75 10             	pushl  0x10(%ebp)
  801518:	ff 75 0c             	pushl  0xc(%ebp)
  80151b:	ff 75 08             	pushl  0x8(%ebp)
  80151e:	6a 27                	push   $0x27
  801520:	e8 18 fb ff ff       	call   80103d <syscall>
  801525:	83 c4 18             	add    $0x18,%esp
	return ;
  801528:	90                   	nop
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <chktst>:
void chktst(uint32 n)
{
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80152e:	6a 00                	push   $0x0
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	ff 75 08             	pushl  0x8(%ebp)
  801539:	6a 29                	push   $0x29
  80153b:	e8 fd fa ff ff       	call   80103d <syscall>
  801540:	83 c4 18             	add    $0x18,%esp
	return ;
  801543:	90                   	nop
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <inctst>:

void inctst()
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 2a                	push   $0x2a
  801555:	e8 e3 fa ff ff       	call   80103d <syscall>
  80155a:	83 c4 18             	add    $0x18,%esp
	return ;
  80155d:	90                   	nop
}
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <gettst>:
uint32 gettst()
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 2b                	push   $0x2b
  80156f:	e8 c9 fa ff ff       	call   80103d <syscall>
  801574:	83 c4 18             	add    $0x18,%esp
}
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
  80157c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 2c                	push   $0x2c
  80158b:	e8 ad fa ff ff       	call   80103d <syscall>
  801590:	83 c4 18             	add    $0x18,%esp
  801593:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801596:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80159a:	75 07                	jne    8015a3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80159c:	b8 01 00 00 00       	mov    $0x1,%eax
  8015a1:	eb 05                	jmp    8015a8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	6a 00                	push   $0x0
  8015b8:	6a 00                	push   $0x0
  8015ba:	6a 2c                	push   $0x2c
  8015bc:	e8 7c fa ff ff       	call   80103d <syscall>
  8015c1:	83 c4 18             	add    $0x18,%esp
  8015c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015c7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015cb:	75 07                	jne    8015d4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8015d2:	eb 05                	jmp    8015d9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d9:	c9                   	leave  
  8015da:	c3                   	ret    

008015db <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015db:	55                   	push   %ebp
  8015dc:	89 e5                	mov    %esp,%ebp
  8015de:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 2c                	push   $0x2c
  8015ed:	e8 4b fa ff ff       	call   80103d <syscall>
  8015f2:	83 c4 18             	add    $0x18,%esp
  8015f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015f8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015fc:	75 07                	jne    801605 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015fe:	b8 01 00 00 00       	mov    $0x1,%eax
  801603:	eb 05                	jmp    80160a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801605:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
  80160f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801612:	6a 00                	push   $0x0
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 2c                	push   $0x2c
  80161e:	e8 1a fa ff ff       	call   80103d <syscall>
  801623:	83 c4 18             	add    $0x18,%esp
  801626:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801629:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80162d:	75 07                	jne    801636 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80162f:	b8 01 00 00 00       	mov    $0x1,%eax
  801634:	eb 05                	jmp    80163b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801636:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80163b:	c9                   	leave  
  80163c:	c3                   	ret    

0080163d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80163d:	55                   	push   %ebp
  80163e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801640:	6a 00                	push   $0x0
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	ff 75 08             	pushl  0x8(%ebp)
  80164b:	6a 2d                	push   $0x2d
  80164d:	e8 eb f9 ff ff       	call   80103d <syscall>
  801652:	83 c4 18             	add    $0x18,%esp
	return ;
  801655:	90                   	nop
}
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
  80165b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80165c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80165f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801662:	8b 55 0c             	mov    0xc(%ebp),%edx
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	6a 00                	push   $0x0
  80166a:	53                   	push   %ebx
  80166b:	51                   	push   %ecx
  80166c:	52                   	push   %edx
  80166d:	50                   	push   %eax
  80166e:	6a 2e                	push   $0x2e
  801670:	e8 c8 f9 ff ff       	call   80103d <syscall>
  801675:	83 c4 18             	add    $0x18,%esp
}
  801678:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80167b:	c9                   	leave  
  80167c:	c3                   	ret    

0080167d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80167d:	55                   	push   %ebp
  80167e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801680:	8b 55 0c             	mov    0xc(%ebp),%edx
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 00                	push   $0x0
  80168c:	52                   	push   %edx
  80168d:	50                   	push   %eax
  80168e:	6a 2f                	push   $0x2f
  801690:	e8 a8 f9 ff ff       	call   80103d <syscall>
  801695:	83 c4 18             	add    $0x18,%esp
}
  801698:	c9                   	leave  
  801699:	c3                   	ret    

0080169a <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80169a:	55                   	push   %ebp
  80169b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80169d:	6a 00                	push   $0x0
  80169f:	6a 00                	push   $0x0
  8016a1:	6a 00                	push   $0x0
  8016a3:	ff 75 0c             	pushl  0xc(%ebp)
  8016a6:	ff 75 08             	pushl  0x8(%ebp)
  8016a9:	6a 30                	push   $0x30
  8016ab:	e8 8d f9 ff ff       	call   80103d <syscall>
  8016b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b3:	90                   	nop
}
  8016b4:	c9                   	leave  
  8016b5:	c3                   	ret    
  8016b6:	66 90                	xchg   %ax,%ax

008016b8 <__udivdi3>:
  8016b8:	55                   	push   %ebp
  8016b9:	57                   	push   %edi
  8016ba:	56                   	push   %esi
  8016bb:	53                   	push   %ebx
  8016bc:	83 ec 1c             	sub    $0x1c,%esp
  8016bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8016c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8016c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8016cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8016cf:	89 ca                	mov    %ecx,%edx
  8016d1:	89 f8                	mov    %edi,%eax
  8016d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8016d7:	85 f6                	test   %esi,%esi
  8016d9:	75 2d                	jne    801708 <__udivdi3+0x50>
  8016db:	39 cf                	cmp    %ecx,%edi
  8016dd:	77 65                	ja     801744 <__udivdi3+0x8c>
  8016df:	89 fd                	mov    %edi,%ebp
  8016e1:	85 ff                	test   %edi,%edi
  8016e3:	75 0b                	jne    8016f0 <__udivdi3+0x38>
  8016e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8016ea:	31 d2                	xor    %edx,%edx
  8016ec:	f7 f7                	div    %edi
  8016ee:	89 c5                	mov    %eax,%ebp
  8016f0:	31 d2                	xor    %edx,%edx
  8016f2:	89 c8                	mov    %ecx,%eax
  8016f4:	f7 f5                	div    %ebp
  8016f6:	89 c1                	mov    %eax,%ecx
  8016f8:	89 d8                	mov    %ebx,%eax
  8016fa:	f7 f5                	div    %ebp
  8016fc:	89 cf                	mov    %ecx,%edi
  8016fe:	89 fa                	mov    %edi,%edx
  801700:	83 c4 1c             	add    $0x1c,%esp
  801703:	5b                   	pop    %ebx
  801704:	5e                   	pop    %esi
  801705:	5f                   	pop    %edi
  801706:	5d                   	pop    %ebp
  801707:	c3                   	ret    
  801708:	39 ce                	cmp    %ecx,%esi
  80170a:	77 28                	ja     801734 <__udivdi3+0x7c>
  80170c:	0f bd fe             	bsr    %esi,%edi
  80170f:	83 f7 1f             	xor    $0x1f,%edi
  801712:	75 40                	jne    801754 <__udivdi3+0x9c>
  801714:	39 ce                	cmp    %ecx,%esi
  801716:	72 0a                	jb     801722 <__udivdi3+0x6a>
  801718:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80171c:	0f 87 9e 00 00 00    	ja     8017c0 <__udivdi3+0x108>
  801722:	b8 01 00 00 00       	mov    $0x1,%eax
  801727:	89 fa                	mov    %edi,%edx
  801729:	83 c4 1c             	add    $0x1c,%esp
  80172c:	5b                   	pop    %ebx
  80172d:	5e                   	pop    %esi
  80172e:	5f                   	pop    %edi
  80172f:	5d                   	pop    %ebp
  801730:	c3                   	ret    
  801731:	8d 76 00             	lea    0x0(%esi),%esi
  801734:	31 ff                	xor    %edi,%edi
  801736:	31 c0                	xor    %eax,%eax
  801738:	89 fa                	mov    %edi,%edx
  80173a:	83 c4 1c             	add    $0x1c,%esp
  80173d:	5b                   	pop    %ebx
  80173e:	5e                   	pop    %esi
  80173f:	5f                   	pop    %edi
  801740:	5d                   	pop    %ebp
  801741:	c3                   	ret    
  801742:	66 90                	xchg   %ax,%ax
  801744:	89 d8                	mov    %ebx,%eax
  801746:	f7 f7                	div    %edi
  801748:	31 ff                	xor    %edi,%edi
  80174a:	89 fa                	mov    %edi,%edx
  80174c:	83 c4 1c             	add    $0x1c,%esp
  80174f:	5b                   	pop    %ebx
  801750:	5e                   	pop    %esi
  801751:	5f                   	pop    %edi
  801752:	5d                   	pop    %ebp
  801753:	c3                   	ret    
  801754:	bd 20 00 00 00       	mov    $0x20,%ebp
  801759:	89 eb                	mov    %ebp,%ebx
  80175b:	29 fb                	sub    %edi,%ebx
  80175d:	89 f9                	mov    %edi,%ecx
  80175f:	d3 e6                	shl    %cl,%esi
  801761:	89 c5                	mov    %eax,%ebp
  801763:	88 d9                	mov    %bl,%cl
  801765:	d3 ed                	shr    %cl,%ebp
  801767:	89 e9                	mov    %ebp,%ecx
  801769:	09 f1                	or     %esi,%ecx
  80176b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80176f:	89 f9                	mov    %edi,%ecx
  801771:	d3 e0                	shl    %cl,%eax
  801773:	89 c5                	mov    %eax,%ebp
  801775:	89 d6                	mov    %edx,%esi
  801777:	88 d9                	mov    %bl,%cl
  801779:	d3 ee                	shr    %cl,%esi
  80177b:	89 f9                	mov    %edi,%ecx
  80177d:	d3 e2                	shl    %cl,%edx
  80177f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801783:	88 d9                	mov    %bl,%cl
  801785:	d3 e8                	shr    %cl,%eax
  801787:	09 c2                	or     %eax,%edx
  801789:	89 d0                	mov    %edx,%eax
  80178b:	89 f2                	mov    %esi,%edx
  80178d:	f7 74 24 0c          	divl   0xc(%esp)
  801791:	89 d6                	mov    %edx,%esi
  801793:	89 c3                	mov    %eax,%ebx
  801795:	f7 e5                	mul    %ebp
  801797:	39 d6                	cmp    %edx,%esi
  801799:	72 19                	jb     8017b4 <__udivdi3+0xfc>
  80179b:	74 0b                	je     8017a8 <__udivdi3+0xf0>
  80179d:	89 d8                	mov    %ebx,%eax
  80179f:	31 ff                	xor    %edi,%edi
  8017a1:	e9 58 ff ff ff       	jmp    8016fe <__udivdi3+0x46>
  8017a6:	66 90                	xchg   %ax,%ax
  8017a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8017ac:	89 f9                	mov    %edi,%ecx
  8017ae:	d3 e2                	shl    %cl,%edx
  8017b0:	39 c2                	cmp    %eax,%edx
  8017b2:	73 e9                	jae    80179d <__udivdi3+0xe5>
  8017b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8017b7:	31 ff                	xor    %edi,%edi
  8017b9:	e9 40 ff ff ff       	jmp    8016fe <__udivdi3+0x46>
  8017be:	66 90                	xchg   %ax,%ax
  8017c0:	31 c0                	xor    %eax,%eax
  8017c2:	e9 37 ff ff ff       	jmp    8016fe <__udivdi3+0x46>
  8017c7:	90                   	nop

008017c8 <__umoddi3>:
  8017c8:	55                   	push   %ebp
  8017c9:	57                   	push   %edi
  8017ca:	56                   	push   %esi
  8017cb:	53                   	push   %ebx
  8017cc:	83 ec 1c             	sub    $0x1c,%esp
  8017cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8017d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8017d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8017df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8017e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8017e7:	89 f3                	mov    %esi,%ebx
  8017e9:	89 fa                	mov    %edi,%edx
  8017eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8017ef:	89 34 24             	mov    %esi,(%esp)
  8017f2:	85 c0                	test   %eax,%eax
  8017f4:	75 1a                	jne    801810 <__umoddi3+0x48>
  8017f6:	39 f7                	cmp    %esi,%edi
  8017f8:	0f 86 a2 00 00 00    	jbe    8018a0 <__umoddi3+0xd8>
  8017fe:	89 c8                	mov    %ecx,%eax
  801800:	89 f2                	mov    %esi,%edx
  801802:	f7 f7                	div    %edi
  801804:	89 d0                	mov    %edx,%eax
  801806:	31 d2                	xor    %edx,%edx
  801808:	83 c4 1c             	add    $0x1c,%esp
  80180b:	5b                   	pop    %ebx
  80180c:	5e                   	pop    %esi
  80180d:	5f                   	pop    %edi
  80180e:	5d                   	pop    %ebp
  80180f:	c3                   	ret    
  801810:	39 f0                	cmp    %esi,%eax
  801812:	0f 87 ac 00 00 00    	ja     8018c4 <__umoddi3+0xfc>
  801818:	0f bd e8             	bsr    %eax,%ebp
  80181b:	83 f5 1f             	xor    $0x1f,%ebp
  80181e:	0f 84 ac 00 00 00    	je     8018d0 <__umoddi3+0x108>
  801824:	bf 20 00 00 00       	mov    $0x20,%edi
  801829:	29 ef                	sub    %ebp,%edi
  80182b:	89 fe                	mov    %edi,%esi
  80182d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801831:	89 e9                	mov    %ebp,%ecx
  801833:	d3 e0                	shl    %cl,%eax
  801835:	89 d7                	mov    %edx,%edi
  801837:	89 f1                	mov    %esi,%ecx
  801839:	d3 ef                	shr    %cl,%edi
  80183b:	09 c7                	or     %eax,%edi
  80183d:	89 e9                	mov    %ebp,%ecx
  80183f:	d3 e2                	shl    %cl,%edx
  801841:	89 14 24             	mov    %edx,(%esp)
  801844:	89 d8                	mov    %ebx,%eax
  801846:	d3 e0                	shl    %cl,%eax
  801848:	89 c2                	mov    %eax,%edx
  80184a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80184e:	d3 e0                	shl    %cl,%eax
  801850:	89 44 24 04          	mov    %eax,0x4(%esp)
  801854:	8b 44 24 08          	mov    0x8(%esp),%eax
  801858:	89 f1                	mov    %esi,%ecx
  80185a:	d3 e8                	shr    %cl,%eax
  80185c:	09 d0                	or     %edx,%eax
  80185e:	d3 eb                	shr    %cl,%ebx
  801860:	89 da                	mov    %ebx,%edx
  801862:	f7 f7                	div    %edi
  801864:	89 d3                	mov    %edx,%ebx
  801866:	f7 24 24             	mull   (%esp)
  801869:	89 c6                	mov    %eax,%esi
  80186b:	89 d1                	mov    %edx,%ecx
  80186d:	39 d3                	cmp    %edx,%ebx
  80186f:	0f 82 87 00 00 00    	jb     8018fc <__umoddi3+0x134>
  801875:	0f 84 91 00 00 00    	je     80190c <__umoddi3+0x144>
  80187b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80187f:	29 f2                	sub    %esi,%edx
  801881:	19 cb                	sbb    %ecx,%ebx
  801883:	89 d8                	mov    %ebx,%eax
  801885:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801889:	d3 e0                	shl    %cl,%eax
  80188b:	89 e9                	mov    %ebp,%ecx
  80188d:	d3 ea                	shr    %cl,%edx
  80188f:	09 d0                	or     %edx,%eax
  801891:	89 e9                	mov    %ebp,%ecx
  801893:	d3 eb                	shr    %cl,%ebx
  801895:	89 da                	mov    %ebx,%edx
  801897:	83 c4 1c             	add    $0x1c,%esp
  80189a:	5b                   	pop    %ebx
  80189b:	5e                   	pop    %esi
  80189c:	5f                   	pop    %edi
  80189d:	5d                   	pop    %ebp
  80189e:	c3                   	ret    
  80189f:	90                   	nop
  8018a0:	89 fd                	mov    %edi,%ebp
  8018a2:	85 ff                	test   %edi,%edi
  8018a4:	75 0b                	jne    8018b1 <__umoddi3+0xe9>
  8018a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8018ab:	31 d2                	xor    %edx,%edx
  8018ad:	f7 f7                	div    %edi
  8018af:	89 c5                	mov    %eax,%ebp
  8018b1:	89 f0                	mov    %esi,%eax
  8018b3:	31 d2                	xor    %edx,%edx
  8018b5:	f7 f5                	div    %ebp
  8018b7:	89 c8                	mov    %ecx,%eax
  8018b9:	f7 f5                	div    %ebp
  8018bb:	89 d0                	mov    %edx,%eax
  8018bd:	e9 44 ff ff ff       	jmp    801806 <__umoddi3+0x3e>
  8018c2:	66 90                	xchg   %ax,%ax
  8018c4:	89 c8                	mov    %ecx,%eax
  8018c6:	89 f2                	mov    %esi,%edx
  8018c8:	83 c4 1c             	add    $0x1c,%esp
  8018cb:	5b                   	pop    %ebx
  8018cc:	5e                   	pop    %esi
  8018cd:	5f                   	pop    %edi
  8018ce:	5d                   	pop    %ebp
  8018cf:	c3                   	ret    
  8018d0:	3b 04 24             	cmp    (%esp),%eax
  8018d3:	72 06                	jb     8018db <__umoddi3+0x113>
  8018d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8018d9:	77 0f                	ja     8018ea <__umoddi3+0x122>
  8018db:	89 f2                	mov    %esi,%edx
  8018dd:	29 f9                	sub    %edi,%ecx
  8018df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8018e3:	89 14 24             	mov    %edx,(%esp)
  8018e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8018ee:	8b 14 24             	mov    (%esp),%edx
  8018f1:	83 c4 1c             	add    $0x1c,%esp
  8018f4:	5b                   	pop    %ebx
  8018f5:	5e                   	pop    %esi
  8018f6:	5f                   	pop    %edi
  8018f7:	5d                   	pop    %ebp
  8018f8:	c3                   	ret    
  8018f9:	8d 76 00             	lea    0x0(%esi),%esi
  8018fc:	2b 04 24             	sub    (%esp),%eax
  8018ff:	19 fa                	sbb    %edi,%edx
  801901:	89 d1                	mov    %edx,%ecx
  801903:	89 c6                	mov    %eax,%esi
  801905:	e9 71 ff ff ff       	jmp    80187b <__umoddi3+0xb3>
  80190a:	66 90                	xchg   %ax,%ax
  80190c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801910:	72 ea                	jb     8018fc <__umoddi3+0x134>
  801912:	89 d9                	mov    %ebx,%ecx
  801914:	e9 62 ff ff ff       	jmp    80187b <__umoddi3+0xb3>
