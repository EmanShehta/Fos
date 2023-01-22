
obj/user/tst_semaphore_2slave:     file format elf32-i386


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
  800031:	e8 8a 00 00 00       	call   8000c0 <libmain>
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
	int id = sys_getenvindex();
  80003e:	e8 98 10 00 00       	call   8010db <sys_getenvindex>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)

	int32 parentenvID = sys_getparentenvid();
  800046:	e8 a9 10 00 00       	call   8010f4 <sys_getparentenvid>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	//cprintf("Cust %d: outside the shop\n", id);

	sys_waitSemaphore(parentenvID, "shopCapacity") ;
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	68 e0 19 80 00       	push   $0x8019e0
  800056:	ff 75 f0             	pushl  -0x10(%ebp)
  800059:	e8 c5 12 00 00       	call   801323 <sys_waitSemaphore>
  80005e:	83 c4 10             	add    $0x10,%esp
		cprintf("Cust %d: inside the shop\n", id) ;
  800061:	83 ec 08             	sub    $0x8,%esp
  800064:	ff 75 f4             	pushl  -0xc(%ebp)
  800067:	68 ed 19 80 00       	push   $0x8019ed
  80006c:	e8 3f 02 00 00       	call   8002b0 <cprintf>
  800071:	83 c4 10             	add    $0x10,%esp
		env_sleep(1000) ;
  800074:	83 ec 0c             	sub    $0xc,%esp
  800077:	68 e8 03 00 00       	push   $0x3e8
  80007c:	e8 32 16 00 00       	call   8016b3 <env_sleep>
  800081:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "shopCapacity") ;
  800084:	83 ec 08             	sub    $0x8,%esp
  800087:	68 e0 19 80 00       	push   $0x8019e0
  80008c:	ff 75 f0             	pushl  -0x10(%ebp)
  80008f:	e8 ad 12 00 00       	call   801341 <sys_signalSemaphore>
  800094:	83 c4 10             	add    $0x10,%esp

	cprintf("Cust %d: exit the shop\n", id);
  800097:	83 ec 08             	sub    $0x8,%esp
  80009a:	ff 75 f4             	pushl  -0xc(%ebp)
  80009d:	68 07 1a 80 00       	push   $0x801a07
  8000a2:	e8 09 02 00 00       	call   8002b0 <cprintf>
  8000a7:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "depend") ;
  8000aa:	83 ec 08             	sub    $0x8,%esp
  8000ad:	68 1f 1a 80 00       	push   $0x801a1f
  8000b2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000b5:	e8 87 12 00 00       	call   801341 <sys_signalSemaphore>
  8000ba:	83 c4 10             	add    $0x10,%esp
	return;
  8000bd:	90                   	nop
}
  8000be:	c9                   	leave  
  8000bf:	c3                   	ret    

008000c0 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8000c0:	55                   	push   %ebp
  8000c1:	89 e5                	mov    %esp,%ebp
  8000c3:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8000c6:	e8 10 10 00 00       	call   8010db <sys_getenvindex>
  8000cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8000ce:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000d1:	89 d0                	mov    %edx,%eax
  8000d3:	01 c0                	add    %eax,%eax
  8000d5:	01 d0                	add    %edx,%eax
  8000d7:	c1 e0 04             	shl    $0x4,%eax
  8000da:	29 d0                	sub    %edx,%eax
  8000dc:	c1 e0 03             	shl    $0x3,%eax
  8000df:	01 d0                	add    %edx,%eax
  8000e1:	c1 e0 02             	shl    $0x2,%eax
  8000e4:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000e9:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000ee:	a1 20 20 80 00       	mov    0x802020,%eax
  8000f3:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8000f9:	84 c0                	test   %al,%al
  8000fb:	74 0f                	je     80010c <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8000fd:	a1 20 20 80 00       	mov    0x802020,%eax
  800102:	05 5c 05 00 00       	add    $0x55c,%eax
  800107:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80010c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800110:	7e 0a                	jle    80011c <libmain+0x5c>
		binaryname = argv[0];
  800112:	8b 45 0c             	mov    0xc(%ebp),%eax
  800115:	8b 00                	mov    (%eax),%eax
  800117:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80011c:	83 ec 08             	sub    $0x8,%esp
  80011f:	ff 75 0c             	pushl  0xc(%ebp)
  800122:	ff 75 08             	pushl  0x8(%ebp)
  800125:	e8 0e ff ff ff       	call   800038 <_main>
  80012a:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80012d:	e8 44 11 00 00       	call   801276 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800132:	83 ec 0c             	sub    $0xc,%esp
  800135:	68 40 1a 80 00       	push   $0x801a40
  80013a:	e8 71 01 00 00       	call   8002b0 <cprintf>
  80013f:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800142:	a1 20 20 80 00       	mov    0x802020,%eax
  800147:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  80014d:	a1 20 20 80 00       	mov    0x802020,%eax
  800152:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800158:	83 ec 04             	sub    $0x4,%esp
  80015b:	52                   	push   %edx
  80015c:	50                   	push   %eax
  80015d:	68 68 1a 80 00       	push   $0x801a68
  800162:	e8 49 01 00 00       	call   8002b0 <cprintf>
  800167:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80016a:	a1 20 20 80 00       	mov    0x802020,%eax
  80016f:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800175:	a1 20 20 80 00       	mov    0x802020,%eax
  80017a:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800180:	a1 20 20 80 00       	mov    0x802020,%eax
  800185:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80018b:	51                   	push   %ecx
  80018c:	52                   	push   %edx
  80018d:	50                   	push   %eax
  80018e:	68 90 1a 80 00       	push   $0x801a90
  800193:	e8 18 01 00 00       	call   8002b0 <cprintf>
  800198:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80019b:	83 ec 0c             	sub    $0xc,%esp
  80019e:	68 40 1a 80 00       	push   $0x801a40
  8001a3:	e8 08 01 00 00       	call   8002b0 <cprintf>
  8001a8:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001ab:	e8 e0 10 00 00       	call   801290 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001b0:	e8 19 00 00 00       	call   8001ce <exit>
}
  8001b5:	90                   	nop
  8001b6:	c9                   	leave  
  8001b7:	c3                   	ret    

008001b8 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001b8:	55                   	push   %ebp
  8001b9:	89 e5                	mov    %esp,%ebp
  8001bb:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8001be:	83 ec 0c             	sub    $0xc,%esp
  8001c1:	6a 00                	push   $0x0
  8001c3:	e8 df 0e 00 00       	call   8010a7 <sys_env_destroy>
  8001c8:	83 c4 10             	add    $0x10,%esp
}
  8001cb:	90                   	nop
  8001cc:	c9                   	leave  
  8001cd:	c3                   	ret    

008001ce <exit>:

void
exit(void)
{
  8001ce:	55                   	push   %ebp
  8001cf:	89 e5                	mov    %esp,%ebp
  8001d1:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001d4:	e8 34 0f 00 00       	call   80110d <sys_env_exit>
}
  8001d9:	90                   	nop
  8001da:	c9                   	leave  
  8001db:	c3                   	ret    

008001dc <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8001dc:	55                   	push   %ebp
  8001dd:	89 e5                	mov    %esp,%ebp
  8001df:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8001e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001e5:	8b 00                	mov    (%eax),%eax
  8001e7:	8d 48 01             	lea    0x1(%eax),%ecx
  8001ea:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001ed:	89 0a                	mov    %ecx,(%edx)
  8001ef:	8b 55 08             	mov    0x8(%ebp),%edx
  8001f2:	88 d1                	mov    %dl,%cl
  8001f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8001f7:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8001fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8001fe:	8b 00                	mov    (%eax),%eax
  800200:	3d ff 00 00 00       	cmp    $0xff,%eax
  800205:	75 2c                	jne    800233 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800207:	a0 24 20 80 00       	mov    0x802024,%al
  80020c:	0f b6 c0             	movzbl %al,%eax
  80020f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800212:	8b 12                	mov    (%edx),%edx
  800214:	89 d1                	mov    %edx,%ecx
  800216:	8b 55 0c             	mov    0xc(%ebp),%edx
  800219:	83 c2 08             	add    $0x8,%edx
  80021c:	83 ec 04             	sub    $0x4,%esp
  80021f:	50                   	push   %eax
  800220:	51                   	push   %ecx
  800221:	52                   	push   %edx
  800222:	e8 3e 0e 00 00       	call   801065 <sys_cputs>
  800227:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80022a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800233:	8b 45 0c             	mov    0xc(%ebp),%eax
  800236:	8b 40 04             	mov    0x4(%eax),%eax
  800239:	8d 50 01             	lea    0x1(%eax),%edx
  80023c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80023f:	89 50 04             	mov    %edx,0x4(%eax)
}
  800242:	90                   	nop
  800243:	c9                   	leave  
  800244:	c3                   	ret    

00800245 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800245:	55                   	push   %ebp
  800246:	89 e5                	mov    %esp,%ebp
  800248:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80024e:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800255:	00 00 00 
	b.cnt = 0;
  800258:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80025f:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800262:	ff 75 0c             	pushl  0xc(%ebp)
  800265:	ff 75 08             	pushl  0x8(%ebp)
  800268:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80026e:	50                   	push   %eax
  80026f:	68 dc 01 80 00       	push   $0x8001dc
  800274:	e8 11 02 00 00       	call   80048a <vprintfmt>
  800279:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80027c:	a0 24 20 80 00       	mov    0x802024,%al
  800281:	0f b6 c0             	movzbl %al,%eax
  800284:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80028a:	83 ec 04             	sub    $0x4,%esp
  80028d:	50                   	push   %eax
  80028e:	52                   	push   %edx
  80028f:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800295:	83 c0 08             	add    $0x8,%eax
  800298:	50                   	push   %eax
  800299:	e8 c7 0d 00 00       	call   801065 <sys_cputs>
  80029e:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8002a1:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8002a8:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8002ae:	c9                   	leave  
  8002af:	c3                   	ret    

008002b0 <cprintf>:

int cprintf(const char *fmt, ...) {
  8002b0:	55                   	push   %ebp
  8002b1:	89 e5                	mov    %esp,%ebp
  8002b3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8002b6:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8002bd:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c6:	83 ec 08             	sub    $0x8,%esp
  8002c9:	ff 75 f4             	pushl  -0xc(%ebp)
  8002cc:	50                   	push   %eax
  8002cd:	e8 73 ff ff ff       	call   800245 <vcprintf>
  8002d2:	83 c4 10             	add    $0x10,%esp
  8002d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8002d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8002db:	c9                   	leave  
  8002dc:	c3                   	ret    

008002dd <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8002dd:	55                   	push   %ebp
  8002de:	89 e5                	mov    %esp,%ebp
  8002e0:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8002e3:	e8 8e 0f 00 00       	call   801276 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8002e8:	8d 45 0c             	lea    0xc(%ebp),%eax
  8002eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8002ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f1:	83 ec 08             	sub    $0x8,%esp
  8002f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8002f7:	50                   	push   %eax
  8002f8:	e8 48 ff ff ff       	call   800245 <vcprintf>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800303:	e8 88 0f 00 00       	call   801290 <sys_enable_interrupt>
	return cnt;
  800308:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80030b:	c9                   	leave  
  80030c:	c3                   	ret    

0080030d <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80030d:	55                   	push   %ebp
  80030e:	89 e5                	mov    %esp,%ebp
  800310:	53                   	push   %ebx
  800311:	83 ec 14             	sub    $0x14,%esp
  800314:	8b 45 10             	mov    0x10(%ebp),%eax
  800317:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80031a:	8b 45 14             	mov    0x14(%ebp),%eax
  80031d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800320:	8b 45 18             	mov    0x18(%ebp),%eax
  800323:	ba 00 00 00 00       	mov    $0x0,%edx
  800328:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80032b:	77 55                	ja     800382 <printnum+0x75>
  80032d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800330:	72 05                	jb     800337 <printnum+0x2a>
  800332:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800335:	77 4b                	ja     800382 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800337:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80033a:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80033d:	8b 45 18             	mov    0x18(%ebp),%eax
  800340:	ba 00 00 00 00       	mov    $0x0,%edx
  800345:	52                   	push   %edx
  800346:	50                   	push   %eax
  800347:	ff 75 f4             	pushl  -0xc(%ebp)
  80034a:	ff 75 f0             	pushl  -0x10(%ebp)
  80034d:	e8 16 14 00 00       	call   801768 <__udivdi3>
  800352:	83 c4 10             	add    $0x10,%esp
  800355:	83 ec 04             	sub    $0x4,%esp
  800358:	ff 75 20             	pushl  0x20(%ebp)
  80035b:	53                   	push   %ebx
  80035c:	ff 75 18             	pushl  0x18(%ebp)
  80035f:	52                   	push   %edx
  800360:	50                   	push   %eax
  800361:	ff 75 0c             	pushl  0xc(%ebp)
  800364:	ff 75 08             	pushl  0x8(%ebp)
  800367:	e8 a1 ff ff ff       	call   80030d <printnum>
  80036c:	83 c4 20             	add    $0x20,%esp
  80036f:	eb 1a                	jmp    80038b <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800371:	83 ec 08             	sub    $0x8,%esp
  800374:	ff 75 0c             	pushl  0xc(%ebp)
  800377:	ff 75 20             	pushl  0x20(%ebp)
  80037a:	8b 45 08             	mov    0x8(%ebp),%eax
  80037d:	ff d0                	call   *%eax
  80037f:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800382:	ff 4d 1c             	decl   0x1c(%ebp)
  800385:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800389:	7f e6                	jg     800371 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80038b:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80038e:	bb 00 00 00 00       	mov    $0x0,%ebx
  800393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800396:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800399:	53                   	push   %ebx
  80039a:	51                   	push   %ecx
  80039b:	52                   	push   %edx
  80039c:	50                   	push   %eax
  80039d:	e8 d6 14 00 00       	call   801878 <__umoddi3>
  8003a2:	83 c4 10             	add    $0x10,%esp
  8003a5:	05 14 1d 80 00       	add    $0x801d14,%eax
  8003aa:	8a 00                	mov    (%eax),%al
  8003ac:	0f be c0             	movsbl %al,%eax
  8003af:	83 ec 08             	sub    $0x8,%esp
  8003b2:	ff 75 0c             	pushl  0xc(%ebp)
  8003b5:	50                   	push   %eax
  8003b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003b9:	ff d0                	call   *%eax
  8003bb:	83 c4 10             	add    $0x10,%esp
}
  8003be:	90                   	nop
  8003bf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8003c2:	c9                   	leave  
  8003c3:	c3                   	ret    

008003c4 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8003c4:	55                   	push   %ebp
  8003c5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8003c7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8003cb:	7e 1c                	jle    8003e9 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	8b 00                	mov    (%eax),%eax
  8003d2:	8d 50 08             	lea    0x8(%eax),%edx
  8003d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d8:	89 10                	mov    %edx,(%eax)
  8003da:	8b 45 08             	mov    0x8(%ebp),%eax
  8003dd:	8b 00                	mov    (%eax),%eax
  8003df:	83 e8 08             	sub    $0x8,%eax
  8003e2:	8b 50 04             	mov    0x4(%eax),%edx
  8003e5:	8b 00                	mov    (%eax),%eax
  8003e7:	eb 40                	jmp    800429 <getuint+0x65>
	else if (lflag)
  8003e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8003ed:	74 1e                	je     80040d <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	8b 00                	mov    (%eax),%eax
  8003f4:	8d 50 04             	lea    0x4(%eax),%edx
  8003f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8003fa:	89 10                	mov    %edx,(%eax)
  8003fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ff:	8b 00                	mov    (%eax),%eax
  800401:	83 e8 04             	sub    $0x4,%eax
  800404:	8b 00                	mov    (%eax),%eax
  800406:	ba 00 00 00 00       	mov    $0x0,%edx
  80040b:	eb 1c                	jmp    800429 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80040d:	8b 45 08             	mov    0x8(%ebp),%eax
  800410:	8b 00                	mov    (%eax),%eax
  800412:	8d 50 04             	lea    0x4(%eax),%edx
  800415:	8b 45 08             	mov    0x8(%ebp),%eax
  800418:	89 10                	mov    %edx,(%eax)
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	8b 00                	mov    (%eax),%eax
  80041f:	83 e8 04             	sub    $0x4,%eax
  800422:	8b 00                	mov    (%eax),%eax
  800424:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800429:	5d                   	pop    %ebp
  80042a:	c3                   	ret    

0080042b <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80042b:	55                   	push   %ebp
  80042c:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80042e:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800432:	7e 1c                	jle    800450 <getint+0x25>
		return va_arg(*ap, long long);
  800434:	8b 45 08             	mov    0x8(%ebp),%eax
  800437:	8b 00                	mov    (%eax),%eax
  800439:	8d 50 08             	lea    0x8(%eax),%edx
  80043c:	8b 45 08             	mov    0x8(%ebp),%eax
  80043f:	89 10                	mov    %edx,(%eax)
  800441:	8b 45 08             	mov    0x8(%ebp),%eax
  800444:	8b 00                	mov    (%eax),%eax
  800446:	83 e8 08             	sub    $0x8,%eax
  800449:	8b 50 04             	mov    0x4(%eax),%edx
  80044c:	8b 00                	mov    (%eax),%eax
  80044e:	eb 38                	jmp    800488 <getint+0x5d>
	else if (lflag)
  800450:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800454:	74 1a                	je     800470 <getint+0x45>
		return va_arg(*ap, long);
  800456:	8b 45 08             	mov    0x8(%ebp),%eax
  800459:	8b 00                	mov    (%eax),%eax
  80045b:	8d 50 04             	lea    0x4(%eax),%edx
  80045e:	8b 45 08             	mov    0x8(%ebp),%eax
  800461:	89 10                	mov    %edx,(%eax)
  800463:	8b 45 08             	mov    0x8(%ebp),%eax
  800466:	8b 00                	mov    (%eax),%eax
  800468:	83 e8 04             	sub    $0x4,%eax
  80046b:	8b 00                	mov    (%eax),%eax
  80046d:	99                   	cltd   
  80046e:	eb 18                	jmp    800488 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	8b 00                	mov    (%eax),%eax
  800475:	8d 50 04             	lea    0x4(%eax),%edx
  800478:	8b 45 08             	mov    0x8(%ebp),%eax
  80047b:	89 10                	mov    %edx,(%eax)
  80047d:	8b 45 08             	mov    0x8(%ebp),%eax
  800480:	8b 00                	mov    (%eax),%eax
  800482:	83 e8 04             	sub    $0x4,%eax
  800485:	8b 00                	mov    (%eax),%eax
  800487:	99                   	cltd   
}
  800488:	5d                   	pop    %ebp
  800489:	c3                   	ret    

0080048a <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80048a:	55                   	push   %ebp
  80048b:	89 e5                	mov    %esp,%ebp
  80048d:	56                   	push   %esi
  80048e:	53                   	push   %ebx
  80048f:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800492:	eb 17                	jmp    8004ab <vprintfmt+0x21>
			if (ch == '\0')
  800494:	85 db                	test   %ebx,%ebx
  800496:	0f 84 af 03 00 00    	je     80084b <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80049c:	83 ec 08             	sub    $0x8,%esp
  80049f:	ff 75 0c             	pushl  0xc(%ebp)
  8004a2:	53                   	push   %ebx
  8004a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a6:	ff d0                	call   *%eax
  8004a8:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8004ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ae:	8d 50 01             	lea    0x1(%eax),%edx
  8004b1:	89 55 10             	mov    %edx,0x10(%ebp)
  8004b4:	8a 00                	mov    (%eax),%al
  8004b6:	0f b6 d8             	movzbl %al,%ebx
  8004b9:	83 fb 25             	cmp    $0x25,%ebx
  8004bc:	75 d6                	jne    800494 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8004be:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8004c2:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8004c9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8004d0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8004d7:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8004de:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e1:	8d 50 01             	lea    0x1(%eax),%edx
  8004e4:	89 55 10             	mov    %edx,0x10(%ebp)
  8004e7:	8a 00                	mov    (%eax),%al
  8004e9:	0f b6 d8             	movzbl %al,%ebx
  8004ec:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8004ef:	83 f8 55             	cmp    $0x55,%eax
  8004f2:	0f 87 2b 03 00 00    	ja     800823 <vprintfmt+0x399>
  8004f8:	8b 04 85 38 1d 80 00 	mov    0x801d38(,%eax,4),%eax
  8004ff:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800501:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800505:	eb d7                	jmp    8004de <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800507:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80050b:	eb d1                	jmp    8004de <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80050d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800514:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800517:	89 d0                	mov    %edx,%eax
  800519:	c1 e0 02             	shl    $0x2,%eax
  80051c:	01 d0                	add    %edx,%eax
  80051e:	01 c0                	add    %eax,%eax
  800520:	01 d8                	add    %ebx,%eax
  800522:	83 e8 30             	sub    $0x30,%eax
  800525:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800528:	8b 45 10             	mov    0x10(%ebp),%eax
  80052b:	8a 00                	mov    (%eax),%al
  80052d:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800530:	83 fb 2f             	cmp    $0x2f,%ebx
  800533:	7e 3e                	jle    800573 <vprintfmt+0xe9>
  800535:	83 fb 39             	cmp    $0x39,%ebx
  800538:	7f 39                	jg     800573 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80053a:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80053d:	eb d5                	jmp    800514 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80053f:	8b 45 14             	mov    0x14(%ebp),%eax
  800542:	83 c0 04             	add    $0x4,%eax
  800545:	89 45 14             	mov    %eax,0x14(%ebp)
  800548:	8b 45 14             	mov    0x14(%ebp),%eax
  80054b:	83 e8 04             	sub    $0x4,%eax
  80054e:	8b 00                	mov    (%eax),%eax
  800550:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800553:	eb 1f                	jmp    800574 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800555:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800559:	79 83                	jns    8004de <vprintfmt+0x54>
				width = 0;
  80055b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800562:	e9 77 ff ff ff       	jmp    8004de <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800567:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80056e:	e9 6b ff ff ff       	jmp    8004de <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800573:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800574:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800578:	0f 89 60 ff ff ff    	jns    8004de <vprintfmt+0x54>
				width = precision, precision = -1;
  80057e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800581:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800584:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80058b:	e9 4e ff ff ff       	jmp    8004de <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800590:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800593:	e9 46 ff ff ff       	jmp    8004de <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800598:	8b 45 14             	mov    0x14(%ebp),%eax
  80059b:	83 c0 04             	add    $0x4,%eax
  80059e:	89 45 14             	mov    %eax,0x14(%ebp)
  8005a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8005a4:	83 e8 04             	sub    $0x4,%eax
  8005a7:	8b 00                	mov    (%eax),%eax
  8005a9:	83 ec 08             	sub    $0x8,%esp
  8005ac:	ff 75 0c             	pushl  0xc(%ebp)
  8005af:	50                   	push   %eax
  8005b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005b3:	ff d0                	call   *%eax
  8005b5:	83 c4 10             	add    $0x10,%esp
			break;
  8005b8:	e9 89 02 00 00       	jmp    800846 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8005bd:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c0:	83 c0 04             	add    $0x4,%eax
  8005c3:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c6:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c9:	83 e8 04             	sub    $0x4,%eax
  8005cc:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8005ce:	85 db                	test   %ebx,%ebx
  8005d0:	79 02                	jns    8005d4 <vprintfmt+0x14a>
				err = -err;
  8005d2:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8005d4:	83 fb 64             	cmp    $0x64,%ebx
  8005d7:	7f 0b                	jg     8005e4 <vprintfmt+0x15a>
  8005d9:	8b 34 9d 80 1b 80 00 	mov    0x801b80(,%ebx,4),%esi
  8005e0:	85 f6                	test   %esi,%esi
  8005e2:	75 19                	jne    8005fd <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8005e4:	53                   	push   %ebx
  8005e5:	68 25 1d 80 00       	push   $0x801d25
  8005ea:	ff 75 0c             	pushl  0xc(%ebp)
  8005ed:	ff 75 08             	pushl  0x8(%ebp)
  8005f0:	e8 5e 02 00 00       	call   800853 <printfmt>
  8005f5:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8005f8:	e9 49 02 00 00       	jmp    800846 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8005fd:	56                   	push   %esi
  8005fe:	68 2e 1d 80 00       	push   $0x801d2e
  800603:	ff 75 0c             	pushl  0xc(%ebp)
  800606:	ff 75 08             	pushl  0x8(%ebp)
  800609:	e8 45 02 00 00       	call   800853 <printfmt>
  80060e:	83 c4 10             	add    $0x10,%esp
			break;
  800611:	e9 30 02 00 00       	jmp    800846 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800616:	8b 45 14             	mov    0x14(%ebp),%eax
  800619:	83 c0 04             	add    $0x4,%eax
  80061c:	89 45 14             	mov    %eax,0x14(%ebp)
  80061f:	8b 45 14             	mov    0x14(%ebp),%eax
  800622:	83 e8 04             	sub    $0x4,%eax
  800625:	8b 30                	mov    (%eax),%esi
  800627:	85 f6                	test   %esi,%esi
  800629:	75 05                	jne    800630 <vprintfmt+0x1a6>
				p = "(null)";
  80062b:	be 31 1d 80 00       	mov    $0x801d31,%esi
			if (width > 0 && padc != '-')
  800630:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800634:	7e 6d                	jle    8006a3 <vprintfmt+0x219>
  800636:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80063a:	74 67                	je     8006a3 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80063c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80063f:	83 ec 08             	sub    $0x8,%esp
  800642:	50                   	push   %eax
  800643:	56                   	push   %esi
  800644:	e8 0c 03 00 00       	call   800955 <strnlen>
  800649:	83 c4 10             	add    $0x10,%esp
  80064c:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80064f:	eb 16                	jmp    800667 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800651:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800655:	83 ec 08             	sub    $0x8,%esp
  800658:	ff 75 0c             	pushl  0xc(%ebp)
  80065b:	50                   	push   %eax
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	ff d0                	call   *%eax
  800661:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800664:	ff 4d e4             	decl   -0x1c(%ebp)
  800667:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80066b:	7f e4                	jg     800651 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80066d:	eb 34                	jmp    8006a3 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80066f:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800673:	74 1c                	je     800691 <vprintfmt+0x207>
  800675:	83 fb 1f             	cmp    $0x1f,%ebx
  800678:	7e 05                	jle    80067f <vprintfmt+0x1f5>
  80067a:	83 fb 7e             	cmp    $0x7e,%ebx
  80067d:	7e 12                	jle    800691 <vprintfmt+0x207>
					putch('?', putdat);
  80067f:	83 ec 08             	sub    $0x8,%esp
  800682:	ff 75 0c             	pushl  0xc(%ebp)
  800685:	6a 3f                	push   $0x3f
  800687:	8b 45 08             	mov    0x8(%ebp),%eax
  80068a:	ff d0                	call   *%eax
  80068c:	83 c4 10             	add    $0x10,%esp
  80068f:	eb 0f                	jmp    8006a0 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800691:	83 ec 08             	sub    $0x8,%esp
  800694:	ff 75 0c             	pushl  0xc(%ebp)
  800697:	53                   	push   %ebx
  800698:	8b 45 08             	mov    0x8(%ebp),%eax
  80069b:	ff d0                	call   *%eax
  80069d:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006a0:	ff 4d e4             	decl   -0x1c(%ebp)
  8006a3:	89 f0                	mov    %esi,%eax
  8006a5:	8d 70 01             	lea    0x1(%eax),%esi
  8006a8:	8a 00                	mov    (%eax),%al
  8006aa:	0f be d8             	movsbl %al,%ebx
  8006ad:	85 db                	test   %ebx,%ebx
  8006af:	74 24                	je     8006d5 <vprintfmt+0x24b>
  8006b1:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006b5:	78 b8                	js     80066f <vprintfmt+0x1e5>
  8006b7:	ff 4d e0             	decl   -0x20(%ebp)
  8006ba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8006be:	79 af                	jns    80066f <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006c0:	eb 13                	jmp    8006d5 <vprintfmt+0x24b>
				putch(' ', putdat);
  8006c2:	83 ec 08             	sub    $0x8,%esp
  8006c5:	ff 75 0c             	pushl  0xc(%ebp)
  8006c8:	6a 20                	push   $0x20
  8006ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cd:	ff d0                	call   *%eax
  8006cf:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8006d2:	ff 4d e4             	decl   -0x1c(%ebp)
  8006d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006d9:	7f e7                	jg     8006c2 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8006db:	e9 66 01 00 00       	jmp    800846 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8006e0:	83 ec 08             	sub    $0x8,%esp
  8006e3:	ff 75 e8             	pushl  -0x18(%ebp)
  8006e6:	8d 45 14             	lea    0x14(%ebp),%eax
  8006e9:	50                   	push   %eax
  8006ea:	e8 3c fd ff ff       	call   80042b <getint>
  8006ef:	83 c4 10             	add    $0x10,%esp
  8006f2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8006f5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8006f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006fe:	85 d2                	test   %edx,%edx
  800700:	79 23                	jns    800725 <vprintfmt+0x29b>
				putch('-', putdat);
  800702:	83 ec 08             	sub    $0x8,%esp
  800705:	ff 75 0c             	pushl  0xc(%ebp)
  800708:	6a 2d                	push   $0x2d
  80070a:	8b 45 08             	mov    0x8(%ebp),%eax
  80070d:	ff d0                	call   *%eax
  80070f:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800712:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800715:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800718:	f7 d8                	neg    %eax
  80071a:	83 d2 00             	adc    $0x0,%edx
  80071d:	f7 da                	neg    %edx
  80071f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800722:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800725:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80072c:	e9 bc 00 00 00       	jmp    8007ed <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	ff 75 e8             	pushl  -0x18(%ebp)
  800737:	8d 45 14             	lea    0x14(%ebp),%eax
  80073a:	50                   	push   %eax
  80073b:	e8 84 fc ff ff       	call   8003c4 <getuint>
  800740:	83 c4 10             	add    $0x10,%esp
  800743:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800746:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800749:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800750:	e9 98 00 00 00       	jmp    8007ed <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800755:	83 ec 08             	sub    $0x8,%esp
  800758:	ff 75 0c             	pushl  0xc(%ebp)
  80075b:	6a 58                	push   $0x58
  80075d:	8b 45 08             	mov    0x8(%ebp),%eax
  800760:	ff d0                	call   *%eax
  800762:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800765:	83 ec 08             	sub    $0x8,%esp
  800768:	ff 75 0c             	pushl  0xc(%ebp)
  80076b:	6a 58                	push   $0x58
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	ff d0                	call   *%eax
  800772:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800775:	83 ec 08             	sub    $0x8,%esp
  800778:	ff 75 0c             	pushl  0xc(%ebp)
  80077b:	6a 58                	push   $0x58
  80077d:	8b 45 08             	mov    0x8(%ebp),%eax
  800780:	ff d0                	call   *%eax
  800782:	83 c4 10             	add    $0x10,%esp
			break;
  800785:	e9 bc 00 00 00       	jmp    800846 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80078a:	83 ec 08             	sub    $0x8,%esp
  80078d:	ff 75 0c             	pushl  0xc(%ebp)
  800790:	6a 30                	push   $0x30
  800792:	8b 45 08             	mov    0x8(%ebp),%eax
  800795:	ff d0                	call   *%eax
  800797:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80079a:	83 ec 08             	sub    $0x8,%esp
  80079d:	ff 75 0c             	pushl  0xc(%ebp)
  8007a0:	6a 78                	push   $0x78
  8007a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a5:	ff d0                	call   *%eax
  8007a7:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8007aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ad:	83 c0 04             	add    $0x4,%eax
  8007b0:	89 45 14             	mov    %eax,0x14(%ebp)
  8007b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007b6:	83 e8 04             	sub    $0x4,%eax
  8007b9:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8007bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007be:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8007c5:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8007cc:	eb 1f                	jmp    8007ed <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8007ce:	83 ec 08             	sub    $0x8,%esp
  8007d1:	ff 75 e8             	pushl  -0x18(%ebp)
  8007d4:	8d 45 14             	lea    0x14(%ebp),%eax
  8007d7:	50                   	push   %eax
  8007d8:	e8 e7 fb ff ff       	call   8003c4 <getuint>
  8007dd:	83 c4 10             	add    $0x10,%esp
  8007e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007e3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8007e6:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8007ed:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8007f1:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8007f4:	83 ec 04             	sub    $0x4,%esp
  8007f7:	52                   	push   %edx
  8007f8:	ff 75 e4             	pushl  -0x1c(%ebp)
  8007fb:	50                   	push   %eax
  8007fc:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ff:	ff 75 f0             	pushl  -0x10(%ebp)
  800802:	ff 75 0c             	pushl  0xc(%ebp)
  800805:	ff 75 08             	pushl  0x8(%ebp)
  800808:	e8 00 fb ff ff       	call   80030d <printnum>
  80080d:	83 c4 20             	add    $0x20,%esp
			break;
  800810:	eb 34                	jmp    800846 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 0c             	pushl  0xc(%ebp)
  800818:	53                   	push   %ebx
  800819:	8b 45 08             	mov    0x8(%ebp),%eax
  80081c:	ff d0                	call   *%eax
  80081e:	83 c4 10             	add    $0x10,%esp
			break;
  800821:	eb 23                	jmp    800846 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800823:	83 ec 08             	sub    $0x8,%esp
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	6a 25                	push   $0x25
  80082b:	8b 45 08             	mov    0x8(%ebp),%eax
  80082e:	ff d0                	call   *%eax
  800830:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800833:	ff 4d 10             	decl   0x10(%ebp)
  800836:	eb 03                	jmp    80083b <vprintfmt+0x3b1>
  800838:	ff 4d 10             	decl   0x10(%ebp)
  80083b:	8b 45 10             	mov    0x10(%ebp),%eax
  80083e:	48                   	dec    %eax
  80083f:	8a 00                	mov    (%eax),%al
  800841:	3c 25                	cmp    $0x25,%al
  800843:	75 f3                	jne    800838 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800845:	90                   	nop
		}
	}
  800846:	e9 47 fc ff ff       	jmp    800492 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80084b:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80084c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80084f:	5b                   	pop    %ebx
  800850:	5e                   	pop    %esi
  800851:	5d                   	pop    %ebp
  800852:	c3                   	ret    

00800853 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800853:	55                   	push   %ebp
  800854:	89 e5                	mov    %esp,%ebp
  800856:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800859:	8d 45 10             	lea    0x10(%ebp),%eax
  80085c:	83 c0 04             	add    $0x4,%eax
  80085f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800862:	8b 45 10             	mov    0x10(%ebp),%eax
  800865:	ff 75 f4             	pushl  -0xc(%ebp)
  800868:	50                   	push   %eax
  800869:	ff 75 0c             	pushl  0xc(%ebp)
  80086c:	ff 75 08             	pushl  0x8(%ebp)
  80086f:	e8 16 fc ff ff       	call   80048a <vprintfmt>
  800874:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800877:	90                   	nop
  800878:	c9                   	leave  
  800879:	c3                   	ret    

0080087a <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80087a:	55                   	push   %ebp
  80087b:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  80087d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800880:	8b 40 08             	mov    0x8(%eax),%eax
  800883:	8d 50 01             	lea    0x1(%eax),%edx
  800886:	8b 45 0c             	mov    0xc(%ebp),%eax
  800889:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80088c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80088f:	8b 10                	mov    (%eax),%edx
  800891:	8b 45 0c             	mov    0xc(%ebp),%eax
  800894:	8b 40 04             	mov    0x4(%eax),%eax
  800897:	39 c2                	cmp    %eax,%edx
  800899:	73 12                	jae    8008ad <sprintputch+0x33>
		*b->buf++ = ch;
  80089b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80089e:	8b 00                	mov    (%eax),%eax
  8008a0:	8d 48 01             	lea    0x1(%eax),%ecx
  8008a3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008a6:	89 0a                	mov    %ecx,(%edx)
  8008a8:	8b 55 08             	mov    0x8(%ebp),%edx
  8008ab:	88 10                	mov    %dl,(%eax)
}
  8008ad:	90                   	nop
  8008ae:	5d                   	pop    %ebp
  8008af:	c3                   	ret    

008008b0 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8008b0:	55                   	push   %ebp
  8008b1:	89 e5                	mov    %esp,%ebp
  8008b3:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8008b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8008bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008bf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	01 d0                	add    %edx,%eax
  8008c7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8008d1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008d5:	74 06                	je     8008dd <vsnprintf+0x2d>
  8008d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008db:	7f 07                	jg     8008e4 <vsnprintf+0x34>
		return -E_INVAL;
  8008dd:	b8 03 00 00 00       	mov    $0x3,%eax
  8008e2:	eb 20                	jmp    800904 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8008e4:	ff 75 14             	pushl  0x14(%ebp)
  8008e7:	ff 75 10             	pushl  0x10(%ebp)
  8008ea:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8008ed:	50                   	push   %eax
  8008ee:	68 7a 08 80 00       	push   $0x80087a
  8008f3:	e8 92 fb ff ff       	call   80048a <vprintfmt>
  8008f8:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8008fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008fe:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800901:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800904:	c9                   	leave  
  800905:	c3                   	ret    

00800906 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800906:	55                   	push   %ebp
  800907:	89 e5                	mov    %esp,%ebp
  800909:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80090c:	8d 45 10             	lea    0x10(%ebp),%eax
  80090f:	83 c0 04             	add    $0x4,%eax
  800912:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800915:	8b 45 10             	mov    0x10(%ebp),%eax
  800918:	ff 75 f4             	pushl  -0xc(%ebp)
  80091b:	50                   	push   %eax
  80091c:	ff 75 0c             	pushl  0xc(%ebp)
  80091f:	ff 75 08             	pushl  0x8(%ebp)
  800922:	e8 89 ff ff ff       	call   8008b0 <vsnprintf>
  800927:	83 c4 10             	add    $0x10,%esp
  80092a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80092d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800930:	c9                   	leave  
  800931:	c3                   	ret    

00800932 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800932:	55                   	push   %ebp
  800933:	89 e5                	mov    %esp,%ebp
  800935:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800938:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80093f:	eb 06                	jmp    800947 <strlen+0x15>
		n++;
  800941:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800944:	ff 45 08             	incl   0x8(%ebp)
  800947:	8b 45 08             	mov    0x8(%ebp),%eax
  80094a:	8a 00                	mov    (%eax),%al
  80094c:	84 c0                	test   %al,%al
  80094e:	75 f1                	jne    800941 <strlen+0xf>
		n++;
	return n;
  800950:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800953:	c9                   	leave  
  800954:	c3                   	ret    

00800955 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800955:	55                   	push   %ebp
  800956:	89 e5                	mov    %esp,%ebp
  800958:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80095b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800962:	eb 09                	jmp    80096d <strnlen+0x18>
		n++;
  800964:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800967:	ff 45 08             	incl   0x8(%ebp)
  80096a:	ff 4d 0c             	decl   0xc(%ebp)
  80096d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800971:	74 09                	je     80097c <strnlen+0x27>
  800973:	8b 45 08             	mov    0x8(%ebp),%eax
  800976:	8a 00                	mov    (%eax),%al
  800978:	84 c0                	test   %al,%al
  80097a:	75 e8                	jne    800964 <strnlen+0xf>
		n++;
	return n;
  80097c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80097f:	c9                   	leave  
  800980:	c3                   	ret    

00800981 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800981:	55                   	push   %ebp
  800982:	89 e5                	mov    %esp,%ebp
  800984:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800987:	8b 45 08             	mov    0x8(%ebp),%eax
  80098a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80098d:	90                   	nop
  80098e:	8b 45 08             	mov    0x8(%ebp),%eax
  800991:	8d 50 01             	lea    0x1(%eax),%edx
  800994:	89 55 08             	mov    %edx,0x8(%ebp)
  800997:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80099d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8009a0:	8a 12                	mov    (%edx),%dl
  8009a2:	88 10                	mov    %dl,(%eax)
  8009a4:	8a 00                	mov    (%eax),%al
  8009a6:	84 c0                	test   %al,%al
  8009a8:	75 e4                	jne    80098e <strcpy+0xd>
		/* do nothing */;
	return ret;
  8009aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009ad:	c9                   	leave  
  8009ae:	c3                   	ret    

008009af <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8009af:	55                   	push   %ebp
  8009b0:	89 e5                	mov    %esp,%ebp
  8009b2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8009b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8009bb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009c2:	eb 1f                	jmp    8009e3 <strncpy+0x34>
		*dst++ = *src;
  8009c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c7:	8d 50 01             	lea    0x1(%eax),%edx
  8009ca:	89 55 08             	mov    %edx,0x8(%ebp)
  8009cd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d0:	8a 12                	mov    (%edx),%dl
  8009d2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8009d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d7:	8a 00                	mov    (%eax),%al
  8009d9:	84 c0                	test   %al,%al
  8009db:	74 03                	je     8009e0 <strncpy+0x31>
			src++;
  8009dd:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8009e0:	ff 45 fc             	incl   -0x4(%ebp)
  8009e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8009e6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8009e9:	72 d9                	jb     8009c4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8009eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8009ee:	c9                   	leave  
  8009ef:	c3                   	ret    

008009f0 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8009f0:	55                   	push   %ebp
  8009f1:	89 e5                	mov    %esp,%ebp
  8009f3:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8009f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8009fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a00:	74 30                	je     800a32 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a02:	eb 16                	jmp    800a1a <strlcpy+0x2a>
			*dst++ = *src++;
  800a04:	8b 45 08             	mov    0x8(%ebp),%eax
  800a07:	8d 50 01             	lea    0x1(%eax),%edx
  800a0a:	89 55 08             	mov    %edx,0x8(%ebp)
  800a0d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a10:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a13:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a16:	8a 12                	mov    (%edx),%dl
  800a18:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a1a:	ff 4d 10             	decl   0x10(%ebp)
  800a1d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a21:	74 09                	je     800a2c <strlcpy+0x3c>
  800a23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a26:	8a 00                	mov    (%eax),%al
  800a28:	84 c0                	test   %al,%al
  800a2a:	75 d8                	jne    800a04 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800a2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800a32:	8b 55 08             	mov    0x8(%ebp),%edx
  800a35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a38:	29 c2                	sub    %eax,%edx
  800a3a:	89 d0                	mov    %edx,%eax
}
  800a3c:	c9                   	leave  
  800a3d:	c3                   	ret    

00800a3e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800a3e:	55                   	push   %ebp
  800a3f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800a41:	eb 06                	jmp    800a49 <strcmp+0xb>
		p++, q++;
  800a43:	ff 45 08             	incl   0x8(%ebp)
  800a46:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800a49:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4c:	8a 00                	mov    (%eax),%al
  800a4e:	84 c0                	test   %al,%al
  800a50:	74 0e                	je     800a60 <strcmp+0x22>
  800a52:	8b 45 08             	mov    0x8(%ebp),%eax
  800a55:	8a 10                	mov    (%eax),%dl
  800a57:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a5a:	8a 00                	mov    (%eax),%al
  800a5c:	38 c2                	cmp    %al,%dl
  800a5e:	74 e3                	je     800a43 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800a60:	8b 45 08             	mov    0x8(%ebp),%eax
  800a63:	8a 00                	mov    (%eax),%al
  800a65:	0f b6 d0             	movzbl %al,%edx
  800a68:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6b:	8a 00                	mov    (%eax),%al
  800a6d:	0f b6 c0             	movzbl %al,%eax
  800a70:	29 c2                	sub    %eax,%edx
  800a72:	89 d0                	mov    %edx,%eax
}
  800a74:	5d                   	pop    %ebp
  800a75:	c3                   	ret    

00800a76 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800a76:	55                   	push   %ebp
  800a77:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800a79:	eb 09                	jmp    800a84 <strncmp+0xe>
		n--, p++, q++;
  800a7b:	ff 4d 10             	decl   0x10(%ebp)
  800a7e:	ff 45 08             	incl   0x8(%ebp)
  800a81:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800a84:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a88:	74 17                	je     800aa1 <strncmp+0x2b>
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	8a 00                	mov    (%eax),%al
  800a8f:	84 c0                	test   %al,%al
  800a91:	74 0e                	je     800aa1 <strncmp+0x2b>
  800a93:	8b 45 08             	mov    0x8(%ebp),%eax
  800a96:	8a 10                	mov    (%eax),%dl
  800a98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9b:	8a 00                	mov    (%eax),%al
  800a9d:	38 c2                	cmp    %al,%dl
  800a9f:	74 da                	je     800a7b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800aa1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800aa5:	75 07                	jne    800aae <strncmp+0x38>
		return 0;
  800aa7:	b8 00 00 00 00       	mov    $0x0,%eax
  800aac:	eb 14                	jmp    800ac2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	8a 00                	mov    (%eax),%al
  800ab3:	0f b6 d0             	movzbl %al,%edx
  800ab6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab9:	8a 00                	mov    (%eax),%al
  800abb:	0f b6 c0             	movzbl %al,%eax
  800abe:	29 c2                	sub    %eax,%edx
  800ac0:	89 d0                	mov    %edx,%eax
}
  800ac2:	5d                   	pop    %ebp
  800ac3:	c3                   	ret    

00800ac4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ac4:	55                   	push   %ebp
  800ac5:	89 e5                	mov    %esp,%ebp
  800ac7:	83 ec 04             	sub    $0x4,%esp
  800aca:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800ad0:	eb 12                	jmp    800ae4 <strchr+0x20>
		if (*s == c)
  800ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad5:	8a 00                	mov    (%eax),%al
  800ad7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ada:	75 05                	jne    800ae1 <strchr+0x1d>
			return (char *) s;
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	eb 11                	jmp    800af2 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800ae1:	ff 45 08             	incl   0x8(%ebp)
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	8a 00                	mov    (%eax),%al
  800ae9:	84 c0                	test   %al,%al
  800aeb:	75 e5                	jne    800ad2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800aed:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800af2:	c9                   	leave  
  800af3:	c3                   	ret    

00800af4 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800af4:	55                   	push   %ebp
  800af5:	89 e5                	mov    %esp,%ebp
  800af7:	83 ec 04             	sub    $0x4,%esp
  800afa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800afd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b00:	eb 0d                	jmp    800b0f <strfind+0x1b>
		if (*s == c)
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	8a 00                	mov    (%eax),%al
  800b07:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b0a:	74 0e                	je     800b1a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b0c:	ff 45 08             	incl   0x8(%ebp)
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	8a 00                	mov    (%eax),%al
  800b14:	84 c0                	test   %al,%al
  800b16:	75 ea                	jne    800b02 <strfind+0xe>
  800b18:	eb 01                	jmp    800b1b <strfind+0x27>
		if (*s == c)
			break;
  800b1a:	90                   	nop
	return (char *) s;
  800b1b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b1e:	c9                   	leave  
  800b1f:	c3                   	ret    

00800b20 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b20:	55                   	push   %ebp
  800b21:	89 e5                	mov    %esp,%ebp
  800b23:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800b2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800b2f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800b32:	eb 0e                	jmp    800b42 <memset+0x22>
		*p++ = c;
  800b34:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b37:	8d 50 01             	lea    0x1(%eax),%edx
  800b3a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800b3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b40:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800b42:	ff 4d f8             	decl   -0x8(%ebp)
  800b45:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800b49:	79 e9                	jns    800b34 <memset+0x14>
		*p++ = c;

	return v;
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b4e:	c9                   	leave  
  800b4f:	c3                   	ret    

00800b50 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800b50:	55                   	push   %ebp
  800b51:	89 e5                	mov    %esp,%ebp
  800b53:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b56:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b59:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800b62:	eb 16                	jmp    800b7a <memcpy+0x2a>
		*d++ = *s++;
  800b64:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800b67:	8d 50 01             	lea    0x1(%eax),%edx
  800b6a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800b6d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800b70:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b73:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800b76:	8a 12                	mov    (%edx),%dl
  800b78:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800b7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800b7d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b80:	89 55 10             	mov    %edx,0x10(%ebp)
  800b83:	85 c0                	test   %eax,%eax
  800b85:	75 dd                	jne    800b64 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b8a:	c9                   	leave  
  800b8b:	c3                   	ret    

00800b8c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800b8c:	55                   	push   %ebp
  800b8d:	89 e5                	mov    %esp,%ebp
  800b8f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800b92:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b95:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800b9e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ba1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ba4:	73 50                	jae    800bf6 <memmove+0x6a>
  800ba6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bac:	01 d0                	add    %edx,%eax
  800bae:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800bb1:	76 43                	jbe    800bf6 <memmove+0x6a>
		s += n;
  800bb3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800bb9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bbc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800bbf:	eb 10                	jmp    800bd1 <memmove+0x45>
			*--d = *--s;
  800bc1:	ff 4d f8             	decl   -0x8(%ebp)
  800bc4:	ff 4d fc             	decl   -0x4(%ebp)
  800bc7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800bca:	8a 10                	mov    (%eax),%dl
  800bcc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bcf:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800bd1:	8b 45 10             	mov    0x10(%ebp),%eax
  800bd4:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bd7:	89 55 10             	mov    %edx,0x10(%ebp)
  800bda:	85 c0                	test   %eax,%eax
  800bdc:	75 e3                	jne    800bc1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800bde:	eb 23                	jmp    800c03 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800be0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800be3:	8d 50 01             	lea    0x1(%eax),%edx
  800be6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800be9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800bec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bef:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bf2:	8a 12                	mov    (%edx),%dl
  800bf4:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800bf6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bfc:	89 55 10             	mov    %edx,0x10(%ebp)
  800bff:	85 c0                	test   %eax,%eax
  800c01:	75 dd                	jne    800be0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c03:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c06:	c9                   	leave  
  800c07:	c3                   	ret    

00800c08 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c08:	55                   	push   %ebp
  800c09:	89 e5                	mov    %esp,%ebp
  800c0b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800c11:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c14:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c17:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c1a:	eb 2a                	jmp    800c46 <memcmp+0x3e>
		if (*s1 != *s2)
  800c1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c1f:	8a 10                	mov    (%eax),%dl
  800c21:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c24:	8a 00                	mov    (%eax),%al
  800c26:	38 c2                	cmp    %al,%dl
  800c28:	74 16                	je     800c40 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800c2a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	0f b6 d0             	movzbl %al,%edx
  800c32:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	0f b6 c0             	movzbl %al,%eax
  800c3a:	29 c2                	sub    %eax,%edx
  800c3c:	89 d0                	mov    %edx,%eax
  800c3e:	eb 18                	jmp    800c58 <memcmp+0x50>
		s1++, s2++;
  800c40:	ff 45 fc             	incl   -0x4(%ebp)
  800c43:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800c46:	8b 45 10             	mov    0x10(%ebp),%eax
  800c49:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c4c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4f:	85 c0                	test   %eax,%eax
  800c51:	75 c9                	jne    800c1c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800c53:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c58:	c9                   	leave  
  800c59:	c3                   	ret    

00800c5a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800c5a:	55                   	push   %ebp
  800c5b:	89 e5                	mov    %esp,%ebp
  800c5d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800c60:	8b 55 08             	mov    0x8(%ebp),%edx
  800c63:	8b 45 10             	mov    0x10(%ebp),%eax
  800c66:	01 d0                	add    %edx,%eax
  800c68:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800c6b:	eb 15                	jmp    800c82 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800c6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c70:	8a 00                	mov    (%eax),%al
  800c72:	0f b6 d0             	movzbl %al,%edx
  800c75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c78:	0f b6 c0             	movzbl %al,%eax
  800c7b:	39 c2                	cmp    %eax,%edx
  800c7d:	74 0d                	je     800c8c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800c7f:	ff 45 08             	incl   0x8(%ebp)
  800c82:	8b 45 08             	mov    0x8(%ebp),%eax
  800c85:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800c88:	72 e3                	jb     800c6d <memfind+0x13>
  800c8a:	eb 01                	jmp    800c8d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800c8c:	90                   	nop
	return (void *) s;
  800c8d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c90:	c9                   	leave  
  800c91:	c3                   	ret    

00800c92 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800c92:	55                   	push   %ebp
  800c93:	89 e5                	mov    %esp,%ebp
  800c95:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800c98:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800c9f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ca6:	eb 03                	jmp    800cab <strtol+0x19>
		s++;
  800ca8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800cab:	8b 45 08             	mov    0x8(%ebp),%eax
  800cae:	8a 00                	mov    (%eax),%al
  800cb0:	3c 20                	cmp    $0x20,%al
  800cb2:	74 f4                	je     800ca8 <strtol+0x16>
  800cb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb7:	8a 00                	mov    (%eax),%al
  800cb9:	3c 09                	cmp    $0x9,%al
  800cbb:	74 eb                	je     800ca8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800cbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc0:	8a 00                	mov    (%eax),%al
  800cc2:	3c 2b                	cmp    $0x2b,%al
  800cc4:	75 05                	jne    800ccb <strtol+0x39>
		s++;
  800cc6:	ff 45 08             	incl   0x8(%ebp)
  800cc9:	eb 13                	jmp    800cde <strtol+0x4c>
	else if (*s == '-')
  800ccb:	8b 45 08             	mov    0x8(%ebp),%eax
  800cce:	8a 00                	mov    (%eax),%al
  800cd0:	3c 2d                	cmp    $0x2d,%al
  800cd2:	75 0a                	jne    800cde <strtol+0x4c>
		s++, neg = 1;
  800cd4:	ff 45 08             	incl   0x8(%ebp)
  800cd7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800cde:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ce2:	74 06                	je     800cea <strtol+0x58>
  800ce4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800ce8:	75 20                	jne    800d0a <strtol+0x78>
  800cea:	8b 45 08             	mov    0x8(%ebp),%eax
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	3c 30                	cmp    $0x30,%al
  800cf1:	75 17                	jne    800d0a <strtol+0x78>
  800cf3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf6:	40                   	inc    %eax
  800cf7:	8a 00                	mov    (%eax),%al
  800cf9:	3c 78                	cmp    $0x78,%al
  800cfb:	75 0d                	jne    800d0a <strtol+0x78>
		s += 2, base = 16;
  800cfd:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d01:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d08:	eb 28                	jmp    800d32 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d0a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d0e:	75 15                	jne    800d25 <strtol+0x93>
  800d10:	8b 45 08             	mov    0x8(%ebp),%eax
  800d13:	8a 00                	mov    (%eax),%al
  800d15:	3c 30                	cmp    $0x30,%al
  800d17:	75 0c                	jne    800d25 <strtol+0x93>
		s++, base = 8;
  800d19:	ff 45 08             	incl   0x8(%ebp)
  800d1c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d23:	eb 0d                	jmp    800d32 <strtol+0xa0>
	else if (base == 0)
  800d25:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d29:	75 07                	jne    800d32 <strtol+0xa0>
		base = 10;
  800d2b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	3c 2f                	cmp    $0x2f,%al
  800d39:	7e 19                	jle    800d54 <strtol+0xc2>
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8a 00                	mov    (%eax),%al
  800d40:	3c 39                	cmp    $0x39,%al
  800d42:	7f 10                	jg     800d54 <strtol+0xc2>
			dig = *s - '0';
  800d44:	8b 45 08             	mov    0x8(%ebp),%eax
  800d47:	8a 00                	mov    (%eax),%al
  800d49:	0f be c0             	movsbl %al,%eax
  800d4c:	83 e8 30             	sub    $0x30,%eax
  800d4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d52:	eb 42                	jmp    800d96 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800d54:	8b 45 08             	mov    0x8(%ebp),%eax
  800d57:	8a 00                	mov    (%eax),%al
  800d59:	3c 60                	cmp    $0x60,%al
  800d5b:	7e 19                	jle    800d76 <strtol+0xe4>
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	8a 00                	mov    (%eax),%al
  800d62:	3c 7a                	cmp    $0x7a,%al
  800d64:	7f 10                	jg     800d76 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	8a 00                	mov    (%eax),%al
  800d6b:	0f be c0             	movsbl %al,%eax
  800d6e:	83 e8 57             	sub    $0x57,%eax
  800d71:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800d74:	eb 20                	jmp    800d96 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800d76:	8b 45 08             	mov    0x8(%ebp),%eax
  800d79:	8a 00                	mov    (%eax),%al
  800d7b:	3c 40                	cmp    $0x40,%al
  800d7d:	7e 39                	jle    800db8 <strtol+0x126>
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	8a 00                	mov    (%eax),%al
  800d84:	3c 5a                	cmp    $0x5a,%al
  800d86:	7f 30                	jg     800db8 <strtol+0x126>
			dig = *s - 'A' + 10;
  800d88:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8b:	8a 00                	mov    (%eax),%al
  800d8d:	0f be c0             	movsbl %al,%eax
  800d90:	83 e8 37             	sub    $0x37,%eax
  800d93:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800d96:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800d99:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d9c:	7d 19                	jge    800db7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800d9e:	ff 45 08             	incl   0x8(%ebp)
  800da1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800da4:	0f af 45 10          	imul   0x10(%ebp),%eax
  800da8:	89 c2                	mov    %eax,%edx
  800daa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800dad:	01 d0                	add    %edx,%eax
  800daf:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800db2:	e9 7b ff ff ff       	jmp    800d32 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800db7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800db8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dbc:	74 08                	je     800dc6 <strtol+0x134>
		*endptr = (char *) s;
  800dbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc1:	8b 55 08             	mov    0x8(%ebp),%edx
  800dc4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800dc6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800dca:	74 07                	je     800dd3 <strtol+0x141>
  800dcc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dcf:	f7 d8                	neg    %eax
  800dd1:	eb 03                	jmp    800dd6 <strtol+0x144>
  800dd3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800dd6:	c9                   	leave  
  800dd7:	c3                   	ret    

00800dd8 <ltostr>:

void
ltostr(long value, char *str)
{
  800dd8:	55                   	push   %ebp
  800dd9:	89 e5                	mov    %esp,%ebp
  800ddb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800dde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800de5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800dec:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800df0:	79 13                	jns    800e05 <ltostr+0x2d>
	{
		neg = 1;
  800df2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800df9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dfc:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800dff:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e02:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e05:	8b 45 08             	mov    0x8(%ebp),%eax
  800e08:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e0d:	99                   	cltd   
  800e0e:	f7 f9                	idiv   %ecx
  800e10:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e13:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e16:	8d 50 01             	lea    0x1(%eax),%edx
  800e19:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e1c:	89 c2                	mov    %eax,%edx
  800e1e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e21:	01 d0                	add    %edx,%eax
  800e23:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e26:	83 c2 30             	add    $0x30,%edx
  800e29:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800e2b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e2e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e33:	f7 e9                	imul   %ecx
  800e35:	c1 fa 02             	sar    $0x2,%edx
  800e38:	89 c8                	mov    %ecx,%eax
  800e3a:	c1 f8 1f             	sar    $0x1f,%eax
  800e3d:	29 c2                	sub    %eax,%edx
  800e3f:	89 d0                	mov    %edx,%eax
  800e41:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800e44:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800e47:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800e4c:	f7 e9                	imul   %ecx
  800e4e:	c1 fa 02             	sar    $0x2,%edx
  800e51:	89 c8                	mov    %ecx,%eax
  800e53:	c1 f8 1f             	sar    $0x1f,%eax
  800e56:	29 c2                	sub    %eax,%edx
  800e58:	89 d0                	mov    %edx,%eax
  800e5a:	c1 e0 02             	shl    $0x2,%eax
  800e5d:	01 d0                	add    %edx,%eax
  800e5f:	01 c0                	add    %eax,%eax
  800e61:	29 c1                	sub    %eax,%ecx
  800e63:	89 ca                	mov    %ecx,%edx
  800e65:	85 d2                	test   %edx,%edx
  800e67:	75 9c                	jne    800e05 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800e69:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800e70:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e73:	48                   	dec    %eax
  800e74:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800e77:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e7b:	74 3d                	je     800eba <ltostr+0xe2>
		start = 1 ;
  800e7d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800e84:	eb 34                	jmp    800eba <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800e86:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e89:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e8c:	01 d0                	add    %edx,%eax
  800e8e:	8a 00                	mov    (%eax),%al
  800e90:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800e93:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	01 c2                	add    %eax,%edx
  800e9b:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800e9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea1:	01 c8                	add    %ecx,%eax
  800ea3:	8a 00                	mov    (%eax),%al
  800ea5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800ea7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800eaa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ead:	01 c2                	add    %eax,%edx
  800eaf:	8a 45 eb             	mov    -0x15(%ebp),%al
  800eb2:	88 02                	mov    %al,(%edx)
		start++ ;
  800eb4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800eb7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800eba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ebd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ec0:	7c c4                	jl     800e86 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800ec2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800ec5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec8:	01 d0                	add    %edx,%eax
  800eca:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800ecd:	90                   	nop
  800ece:	c9                   	leave  
  800ecf:	c3                   	ret    

00800ed0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800ed0:	55                   	push   %ebp
  800ed1:	89 e5                	mov    %esp,%ebp
  800ed3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800ed6:	ff 75 08             	pushl  0x8(%ebp)
  800ed9:	e8 54 fa ff ff       	call   800932 <strlen>
  800ede:	83 c4 04             	add    $0x4,%esp
  800ee1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800ee4:	ff 75 0c             	pushl  0xc(%ebp)
  800ee7:	e8 46 fa ff ff       	call   800932 <strlen>
  800eec:	83 c4 04             	add    $0x4,%esp
  800eef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ef2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ef9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f00:	eb 17                	jmp    800f19 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f02:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f05:	8b 45 10             	mov    0x10(%ebp),%eax
  800f08:	01 c2                	add    %eax,%edx
  800f0a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	01 c8                	add    %ecx,%eax
  800f12:	8a 00                	mov    (%eax),%al
  800f14:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f16:	ff 45 fc             	incl   -0x4(%ebp)
  800f19:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f1c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f1f:	7c e1                	jl     800f02 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f21:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800f28:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800f2f:	eb 1f                	jmp    800f50 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800f31:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f34:	8d 50 01             	lea    0x1(%eax),%edx
  800f37:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f3a:	89 c2                	mov    %eax,%edx
  800f3c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3f:	01 c2                	add    %eax,%edx
  800f41:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800f44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f47:	01 c8                	add    %ecx,%eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800f4d:	ff 45 f8             	incl   -0x8(%ebp)
  800f50:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f53:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f56:	7c d9                	jl     800f31 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800f58:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f5b:	8b 45 10             	mov    0x10(%ebp),%eax
  800f5e:	01 d0                	add    %edx,%eax
  800f60:	c6 00 00             	movb   $0x0,(%eax)
}
  800f63:	90                   	nop
  800f64:	c9                   	leave  
  800f65:	c3                   	ret    

00800f66 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800f66:	55                   	push   %ebp
  800f67:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800f69:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800f72:	8b 45 14             	mov    0x14(%ebp),%eax
  800f75:	8b 00                	mov    (%eax),%eax
  800f77:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800f7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f81:	01 d0                	add    %edx,%eax
  800f83:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f89:	eb 0c                	jmp    800f97 <strsplit+0x31>
			*string++ = 0;
  800f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8e:	8d 50 01             	lea    0x1(%eax),%edx
  800f91:	89 55 08             	mov    %edx,0x8(%ebp)
  800f94:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  800f97:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9a:	8a 00                	mov    (%eax),%al
  800f9c:	84 c0                	test   %al,%al
  800f9e:	74 18                	je     800fb8 <strsplit+0x52>
  800fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	0f be c0             	movsbl %al,%eax
  800fa8:	50                   	push   %eax
  800fa9:	ff 75 0c             	pushl  0xc(%ebp)
  800fac:	e8 13 fb ff ff       	call   800ac4 <strchr>
  800fb1:	83 c4 08             	add    $0x8,%esp
  800fb4:	85 c0                	test   %eax,%eax
  800fb6:	75 d3                	jne    800f8b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	8a 00                	mov    (%eax),%al
  800fbd:	84 c0                	test   %al,%al
  800fbf:	74 5a                	je     80101b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  800fc1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fc4:	8b 00                	mov    (%eax),%eax
  800fc6:	83 f8 0f             	cmp    $0xf,%eax
  800fc9:	75 07                	jne    800fd2 <strsplit+0x6c>
		{
			return 0;
  800fcb:	b8 00 00 00 00       	mov    $0x0,%eax
  800fd0:	eb 66                	jmp    801038 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  800fd2:	8b 45 14             	mov    0x14(%ebp),%eax
  800fd5:	8b 00                	mov    (%eax),%eax
  800fd7:	8d 48 01             	lea    0x1(%eax),%ecx
  800fda:	8b 55 14             	mov    0x14(%ebp),%edx
  800fdd:	89 0a                	mov    %ecx,(%edx)
  800fdf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800fe6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe9:	01 c2                	add    %eax,%edx
  800feb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fee:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ff0:	eb 03                	jmp    800ff5 <strsplit+0x8f>
			string++;
  800ff2:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  800ff5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff8:	8a 00                	mov    (%eax),%al
  800ffa:	84 c0                	test   %al,%al
  800ffc:	74 8b                	je     800f89 <strsplit+0x23>
  800ffe:	8b 45 08             	mov    0x8(%ebp),%eax
  801001:	8a 00                	mov    (%eax),%al
  801003:	0f be c0             	movsbl %al,%eax
  801006:	50                   	push   %eax
  801007:	ff 75 0c             	pushl  0xc(%ebp)
  80100a:	e8 b5 fa ff ff       	call   800ac4 <strchr>
  80100f:	83 c4 08             	add    $0x8,%esp
  801012:	85 c0                	test   %eax,%eax
  801014:	74 dc                	je     800ff2 <strsplit+0x8c>
			string++;
	}
  801016:	e9 6e ff ff ff       	jmp    800f89 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80101b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80101c:	8b 45 14             	mov    0x14(%ebp),%eax
  80101f:	8b 00                	mov    (%eax),%eax
  801021:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801028:	8b 45 10             	mov    0x10(%ebp),%eax
  80102b:	01 d0                	add    %edx,%eax
  80102d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801033:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801038:	c9                   	leave  
  801039:	c3                   	ret    

0080103a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80103a:	55                   	push   %ebp
  80103b:	89 e5                	mov    %esp,%ebp
  80103d:	57                   	push   %edi
  80103e:	56                   	push   %esi
  80103f:	53                   	push   %ebx
  801040:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801043:	8b 45 08             	mov    0x8(%ebp),%eax
  801046:	8b 55 0c             	mov    0xc(%ebp),%edx
  801049:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80104c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80104f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801052:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801055:	cd 30                	int    $0x30
  801057:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80105a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80105d:	83 c4 10             	add    $0x10,%esp
  801060:	5b                   	pop    %ebx
  801061:	5e                   	pop    %esi
  801062:	5f                   	pop    %edi
  801063:	5d                   	pop    %ebp
  801064:	c3                   	ret    

00801065 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801065:	55                   	push   %ebp
  801066:	89 e5                	mov    %esp,%ebp
  801068:	83 ec 04             	sub    $0x4,%esp
  80106b:	8b 45 10             	mov    0x10(%ebp),%eax
  80106e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801071:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	6a 00                	push   $0x0
  80107a:	6a 00                	push   $0x0
  80107c:	52                   	push   %edx
  80107d:	ff 75 0c             	pushl  0xc(%ebp)
  801080:	50                   	push   %eax
  801081:	6a 00                	push   $0x0
  801083:	e8 b2 ff ff ff       	call   80103a <syscall>
  801088:	83 c4 18             	add    $0x18,%esp
}
  80108b:	90                   	nop
  80108c:	c9                   	leave  
  80108d:	c3                   	ret    

0080108e <sys_cgetc>:

int
sys_cgetc(void)
{
  80108e:	55                   	push   %ebp
  80108f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801091:	6a 00                	push   $0x0
  801093:	6a 00                	push   $0x0
  801095:	6a 00                	push   $0x0
  801097:	6a 00                	push   $0x0
  801099:	6a 00                	push   $0x0
  80109b:	6a 01                	push   $0x1
  80109d:	e8 98 ff ff ff       	call   80103a <syscall>
  8010a2:	83 c4 18             	add    $0x18,%esp
}
  8010a5:	c9                   	leave  
  8010a6:	c3                   	ret    

008010a7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8010aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ad:	6a 00                	push   $0x0
  8010af:	6a 00                	push   $0x0
  8010b1:	6a 00                	push   $0x0
  8010b3:	6a 00                	push   $0x0
  8010b5:	50                   	push   %eax
  8010b6:	6a 05                	push   $0x5
  8010b8:	e8 7d ff ff ff       	call   80103a <syscall>
  8010bd:	83 c4 18             	add    $0x18,%esp
}
  8010c0:	c9                   	leave  
  8010c1:	c3                   	ret    

008010c2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8010c2:	55                   	push   %ebp
  8010c3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8010c5:	6a 00                	push   $0x0
  8010c7:	6a 00                	push   $0x0
  8010c9:	6a 00                	push   $0x0
  8010cb:	6a 00                	push   $0x0
  8010cd:	6a 00                	push   $0x0
  8010cf:	6a 02                	push   $0x2
  8010d1:	e8 64 ff ff ff       	call   80103a <syscall>
  8010d6:	83 c4 18             	add    $0x18,%esp
}
  8010d9:	c9                   	leave  
  8010da:	c3                   	ret    

008010db <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8010db:	55                   	push   %ebp
  8010dc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8010de:	6a 00                	push   $0x0
  8010e0:	6a 00                	push   $0x0
  8010e2:	6a 00                	push   $0x0
  8010e4:	6a 00                	push   $0x0
  8010e6:	6a 00                	push   $0x0
  8010e8:	6a 03                	push   $0x3
  8010ea:	e8 4b ff ff ff       	call   80103a <syscall>
  8010ef:	83 c4 18             	add    $0x18,%esp
}
  8010f2:	c9                   	leave  
  8010f3:	c3                   	ret    

008010f4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8010f4:	55                   	push   %ebp
  8010f5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8010f7:	6a 00                	push   $0x0
  8010f9:	6a 00                	push   $0x0
  8010fb:	6a 00                	push   $0x0
  8010fd:	6a 00                	push   $0x0
  8010ff:	6a 00                	push   $0x0
  801101:	6a 04                	push   $0x4
  801103:	e8 32 ff ff ff       	call   80103a <syscall>
  801108:	83 c4 18             	add    $0x18,%esp
}
  80110b:	c9                   	leave  
  80110c:	c3                   	ret    

0080110d <sys_env_exit>:


void sys_env_exit(void)
{
  80110d:	55                   	push   %ebp
  80110e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801110:	6a 00                	push   $0x0
  801112:	6a 00                	push   $0x0
  801114:	6a 00                	push   $0x0
  801116:	6a 00                	push   $0x0
  801118:	6a 00                	push   $0x0
  80111a:	6a 06                	push   $0x6
  80111c:	e8 19 ff ff ff       	call   80103a <syscall>
  801121:	83 c4 18             	add    $0x18,%esp
}
  801124:	90                   	nop
  801125:	c9                   	leave  
  801126:	c3                   	ret    

00801127 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801127:	55                   	push   %ebp
  801128:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80112a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80112d:	8b 45 08             	mov    0x8(%ebp),%eax
  801130:	6a 00                	push   $0x0
  801132:	6a 00                	push   $0x0
  801134:	6a 00                	push   $0x0
  801136:	52                   	push   %edx
  801137:	50                   	push   %eax
  801138:	6a 07                	push   $0x7
  80113a:	e8 fb fe ff ff       	call   80103a <syscall>
  80113f:	83 c4 18             	add    $0x18,%esp
}
  801142:	c9                   	leave  
  801143:	c3                   	ret    

00801144 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
  801147:	56                   	push   %esi
  801148:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801149:	8b 75 18             	mov    0x18(%ebp),%esi
  80114c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80114f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801152:	8b 55 0c             	mov    0xc(%ebp),%edx
  801155:	8b 45 08             	mov    0x8(%ebp),%eax
  801158:	56                   	push   %esi
  801159:	53                   	push   %ebx
  80115a:	51                   	push   %ecx
  80115b:	52                   	push   %edx
  80115c:	50                   	push   %eax
  80115d:	6a 08                	push   $0x8
  80115f:	e8 d6 fe ff ff       	call   80103a <syscall>
  801164:	83 c4 18             	add    $0x18,%esp
}
  801167:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80116a:	5b                   	pop    %ebx
  80116b:	5e                   	pop    %esi
  80116c:	5d                   	pop    %ebp
  80116d:	c3                   	ret    

0080116e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801171:	8b 55 0c             	mov    0xc(%ebp),%edx
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	6a 00                	push   $0x0
  801179:	6a 00                	push   $0x0
  80117b:	6a 00                	push   $0x0
  80117d:	52                   	push   %edx
  80117e:	50                   	push   %eax
  80117f:	6a 09                	push   $0x9
  801181:	e8 b4 fe ff ff       	call   80103a <syscall>
  801186:	83 c4 18             	add    $0x18,%esp
}
  801189:	c9                   	leave  
  80118a:	c3                   	ret    

0080118b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80118b:	55                   	push   %ebp
  80118c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80118e:	6a 00                	push   $0x0
  801190:	6a 00                	push   $0x0
  801192:	6a 00                	push   $0x0
  801194:	ff 75 0c             	pushl  0xc(%ebp)
  801197:	ff 75 08             	pushl  0x8(%ebp)
  80119a:	6a 0a                	push   $0xa
  80119c:	e8 99 fe ff ff       	call   80103a <syscall>
  8011a1:	83 c4 18             	add    $0x18,%esp
}
  8011a4:	c9                   	leave  
  8011a5:	c3                   	ret    

008011a6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8011a6:	55                   	push   %ebp
  8011a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8011a9:	6a 00                	push   $0x0
  8011ab:	6a 00                	push   $0x0
  8011ad:	6a 00                	push   $0x0
  8011af:	6a 00                	push   $0x0
  8011b1:	6a 00                	push   $0x0
  8011b3:	6a 0b                	push   $0xb
  8011b5:	e8 80 fe ff ff       	call   80103a <syscall>
  8011ba:	83 c4 18             	add    $0x18,%esp
}
  8011bd:	c9                   	leave  
  8011be:	c3                   	ret    

008011bf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8011bf:	55                   	push   %ebp
  8011c0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8011c2:	6a 00                	push   $0x0
  8011c4:	6a 00                	push   $0x0
  8011c6:	6a 00                	push   $0x0
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 0c                	push   $0xc
  8011ce:	e8 67 fe ff ff       	call   80103a <syscall>
  8011d3:	83 c4 18             	add    $0x18,%esp
}
  8011d6:	c9                   	leave  
  8011d7:	c3                   	ret    

008011d8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8011d8:	55                   	push   %ebp
  8011d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8011db:	6a 00                	push   $0x0
  8011dd:	6a 00                	push   $0x0
  8011df:	6a 00                	push   $0x0
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 0d                	push   $0xd
  8011e7:	e8 4e fe ff ff       	call   80103a <syscall>
  8011ec:	83 c4 18             	add    $0x18,%esp
}
  8011ef:	c9                   	leave  
  8011f0:	c3                   	ret    

008011f1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8011f1:	55                   	push   %ebp
  8011f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8011f4:	6a 00                	push   $0x0
  8011f6:	6a 00                	push   $0x0
  8011f8:	6a 00                	push   $0x0
  8011fa:	ff 75 0c             	pushl  0xc(%ebp)
  8011fd:	ff 75 08             	pushl  0x8(%ebp)
  801200:	6a 11                	push   $0x11
  801202:	e8 33 fe ff ff       	call   80103a <syscall>
  801207:	83 c4 18             	add    $0x18,%esp
	return;
  80120a:	90                   	nop
}
  80120b:	c9                   	leave  
  80120c:	c3                   	ret    

0080120d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80120d:	55                   	push   %ebp
  80120e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801210:	6a 00                	push   $0x0
  801212:	6a 00                	push   $0x0
  801214:	6a 00                	push   $0x0
  801216:	ff 75 0c             	pushl  0xc(%ebp)
  801219:	ff 75 08             	pushl  0x8(%ebp)
  80121c:	6a 12                	push   $0x12
  80121e:	e8 17 fe ff ff       	call   80103a <syscall>
  801223:	83 c4 18             	add    $0x18,%esp
	return ;
  801226:	90                   	nop
}
  801227:	c9                   	leave  
  801228:	c3                   	ret    

00801229 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801229:	55                   	push   %ebp
  80122a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80122c:	6a 00                	push   $0x0
  80122e:	6a 00                	push   $0x0
  801230:	6a 00                	push   $0x0
  801232:	6a 00                	push   $0x0
  801234:	6a 00                	push   $0x0
  801236:	6a 0e                	push   $0xe
  801238:	e8 fd fd ff ff       	call   80103a <syscall>
  80123d:	83 c4 18             	add    $0x18,%esp
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801245:	6a 00                	push   $0x0
  801247:	6a 00                	push   $0x0
  801249:	6a 00                	push   $0x0
  80124b:	6a 00                	push   $0x0
  80124d:	ff 75 08             	pushl  0x8(%ebp)
  801250:	6a 0f                	push   $0xf
  801252:	e8 e3 fd ff ff       	call   80103a <syscall>
  801257:	83 c4 18             	add    $0x18,%esp
}
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <sys_scarce_memory>:

void sys_scarce_memory()
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80125f:	6a 00                	push   $0x0
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 10                	push   $0x10
  80126b:	e8 ca fd ff ff       	call   80103a <syscall>
  801270:	83 c4 18             	add    $0x18,%esp
}
  801273:	90                   	nop
  801274:	c9                   	leave  
  801275:	c3                   	ret    

00801276 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801276:	55                   	push   %ebp
  801277:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801279:	6a 00                	push   $0x0
  80127b:	6a 00                	push   $0x0
  80127d:	6a 00                	push   $0x0
  80127f:	6a 00                	push   $0x0
  801281:	6a 00                	push   $0x0
  801283:	6a 14                	push   $0x14
  801285:	e8 b0 fd ff ff       	call   80103a <syscall>
  80128a:	83 c4 18             	add    $0x18,%esp
}
  80128d:	90                   	nop
  80128e:	c9                   	leave  
  80128f:	c3                   	ret    

00801290 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801290:	55                   	push   %ebp
  801291:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801293:	6a 00                	push   $0x0
  801295:	6a 00                	push   $0x0
  801297:	6a 00                	push   $0x0
  801299:	6a 00                	push   $0x0
  80129b:	6a 00                	push   $0x0
  80129d:	6a 15                	push   $0x15
  80129f:	e8 96 fd ff ff       	call   80103a <syscall>
  8012a4:	83 c4 18             	add    $0x18,%esp
}
  8012a7:	90                   	nop
  8012a8:	c9                   	leave  
  8012a9:	c3                   	ret    

008012aa <sys_cputc>:


void
sys_cputc(const char c)
{
  8012aa:	55                   	push   %ebp
  8012ab:	89 e5                	mov    %esp,%ebp
  8012ad:	83 ec 04             	sub    $0x4,%esp
  8012b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8012b6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 00                	push   $0x0
  8012c0:	6a 00                	push   $0x0
  8012c2:	50                   	push   %eax
  8012c3:	6a 16                	push   $0x16
  8012c5:	e8 70 fd ff ff       	call   80103a <syscall>
  8012ca:	83 c4 18             	add    $0x18,%esp
}
  8012cd:	90                   	nop
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8012d3:	6a 00                	push   $0x0
  8012d5:	6a 00                	push   $0x0
  8012d7:	6a 00                	push   $0x0
  8012d9:	6a 00                	push   $0x0
  8012db:	6a 00                	push   $0x0
  8012dd:	6a 17                	push   $0x17
  8012df:	e8 56 fd ff ff       	call   80103a <syscall>
  8012e4:	83 c4 18             	add    $0x18,%esp
}
  8012e7:	90                   	nop
  8012e8:	c9                   	leave  
  8012e9:	c3                   	ret    

008012ea <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8012ea:	55                   	push   %ebp
  8012eb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8012ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 00                	push   $0x0
  8012f4:	6a 00                	push   $0x0
  8012f6:	ff 75 0c             	pushl  0xc(%ebp)
  8012f9:	50                   	push   %eax
  8012fa:	6a 18                	push   $0x18
  8012fc:	e8 39 fd ff ff       	call   80103a <syscall>
  801301:	83 c4 18             	add    $0x18,%esp
}
  801304:	c9                   	leave  
  801305:	c3                   	ret    

00801306 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801309:	8b 55 0c             	mov    0xc(%ebp),%edx
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	6a 00                	push   $0x0
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	52                   	push   %edx
  801316:	50                   	push   %eax
  801317:	6a 1b                	push   $0x1b
  801319:	e8 1c fd ff ff       	call   80103a <syscall>
  80131e:	83 c4 18             	add    $0x18,%esp
}
  801321:	c9                   	leave  
  801322:	c3                   	ret    

00801323 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801326:	8b 55 0c             	mov    0xc(%ebp),%edx
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	52                   	push   %edx
  801333:	50                   	push   %eax
  801334:	6a 19                	push   $0x19
  801336:	e8 ff fc ff ff       	call   80103a <syscall>
  80133b:	83 c4 18             	add    $0x18,%esp
}
  80133e:	90                   	nop
  80133f:	c9                   	leave  
  801340:	c3                   	ret    

00801341 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801341:	55                   	push   %ebp
  801342:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801344:	8b 55 0c             	mov    0xc(%ebp),%edx
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	52                   	push   %edx
  801351:	50                   	push   %eax
  801352:	6a 1a                	push   $0x1a
  801354:	e8 e1 fc ff ff       	call   80103a <syscall>
  801359:	83 c4 18             	add    $0x18,%esp
}
  80135c:	90                   	nop
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
  801362:	83 ec 04             	sub    $0x4,%esp
  801365:	8b 45 10             	mov    0x10(%ebp),%eax
  801368:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80136b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80136e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	6a 00                	push   $0x0
  801377:	51                   	push   %ecx
  801378:	52                   	push   %edx
  801379:	ff 75 0c             	pushl  0xc(%ebp)
  80137c:	50                   	push   %eax
  80137d:	6a 1c                	push   $0x1c
  80137f:	e8 b6 fc ff ff       	call   80103a <syscall>
  801384:	83 c4 18             	add    $0x18,%esp
}
  801387:	c9                   	leave  
  801388:	c3                   	ret    

00801389 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801389:	55                   	push   %ebp
  80138a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80138c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
  801392:	6a 00                	push   $0x0
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	52                   	push   %edx
  801399:	50                   	push   %eax
  80139a:	6a 1d                	push   $0x1d
  80139c:	e8 99 fc ff ff       	call   80103a <syscall>
  8013a1:	83 c4 18             	add    $0x18,%esp
}
  8013a4:	c9                   	leave  
  8013a5:	c3                   	ret    

008013a6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8013a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013af:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b2:	6a 00                	push   $0x0
  8013b4:	6a 00                	push   $0x0
  8013b6:	51                   	push   %ecx
  8013b7:	52                   	push   %edx
  8013b8:	50                   	push   %eax
  8013b9:	6a 1e                	push   $0x1e
  8013bb:	e8 7a fc ff ff       	call   80103a <syscall>
  8013c0:	83 c4 18             	add    $0x18,%esp
}
  8013c3:	c9                   	leave  
  8013c4:	c3                   	ret    

008013c5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8013c5:	55                   	push   %ebp
  8013c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8013c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	52                   	push   %edx
  8013d5:	50                   	push   %eax
  8013d6:	6a 1f                	push   $0x1f
  8013d8:	e8 5d fc ff ff       	call   80103a <syscall>
  8013dd:	83 c4 18             	add    $0x18,%esp
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 20                	push   $0x20
  8013f1:	e8 44 fc ff ff       	call   80103a <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8013fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801401:	6a 00                	push   $0x0
  801403:	ff 75 14             	pushl  0x14(%ebp)
  801406:	ff 75 10             	pushl  0x10(%ebp)
  801409:	ff 75 0c             	pushl  0xc(%ebp)
  80140c:	50                   	push   %eax
  80140d:	6a 21                	push   $0x21
  80140f:	e8 26 fc ff ff       	call   80103a <syscall>
  801414:	83 c4 18             	add    $0x18,%esp
}
  801417:	c9                   	leave  
  801418:	c3                   	ret    

00801419 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801419:	55                   	push   %ebp
  80141a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80141c:	8b 45 08             	mov    0x8(%ebp),%eax
  80141f:	6a 00                	push   $0x0
  801421:	6a 00                	push   $0x0
  801423:	6a 00                	push   $0x0
  801425:	6a 00                	push   $0x0
  801427:	50                   	push   %eax
  801428:	6a 22                	push   $0x22
  80142a:	e8 0b fc ff ff       	call   80103a <syscall>
  80142f:	83 c4 18             	add    $0x18,%esp
}
  801432:	90                   	nop
  801433:	c9                   	leave  
  801434:	c3                   	ret    

00801435 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801435:	55                   	push   %ebp
  801436:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	50                   	push   %eax
  801444:	6a 23                	push   $0x23
  801446:	e8 ef fb ff ff       	call   80103a <syscall>
  80144b:	83 c4 18             	add    $0x18,%esp
}
  80144e:	90                   	nop
  80144f:	c9                   	leave  
  801450:	c3                   	ret    

00801451 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801451:	55                   	push   %ebp
  801452:	89 e5                	mov    %esp,%ebp
  801454:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801457:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80145a:	8d 50 04             	lea    0x4(%eax),%edx
  80145d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801460:	6a 00                	push   $0x0
  801462:	6a 00                	push   $0x0
  801464:	6a 00                	push   $0x0
  801466:	52                   	push   %edx
  801467:	50                   	push   %eax
  801468:	6a 24                	push   $0x24
  80146a:	e8 cb fb ff ff       	call   80103a <syscall>
  80146f:	83 c4 18             	add    $0x18,%esp
	return result;
  801472:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801475:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801478:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80147b:	89 01                	mov    %eax,(%ecx)
  80147d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	c9                   	leave  
  801484:	c2 04 00             	ret    $0x4

00801487 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801487:	55                   	push   %ebp
  801488:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80148a:	6a 00                	push   $0x0
  80148c:	6a 00                	push   $0x0
  80148e:	ff 75 10             	pushl  0x10(%ebp)
  801491:	ff 75 0c             	pushl  0xc(%ebp)
  801494:	ff 75 08             	pushl  0x8(%ebp)
  801497:	6a 13                	push   $0x13
  801499:	e8 9c fb ff ff       	call   80103a <syscall>
  80149e:	83 c4 18             	add    $0x18,%esp
	return ;
  8014a1:	90                   	nop
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8014a7:	6a 00                	push   $0x0
  8014a9:	6a 00                	push   $0x0
  8014ab:	6a 00                	push   $0x0
  8014ad:	6a 00                	push   $0x0
  8014af:	6a 00                	push   $0x0
  8014b1:	6a 25                	push   $0x25
  8014b3:	e8 82 fb ff ff       	call   80103a <syscall>
  8014b8:	83 c4 18             	add    $0x18,%esp
}
  8014bb:	c9                   	leave  
  8014bc:	c3                   	ret    

008014bd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8014bd:	55                   	push   %ebp
  8014be:	89 e5                	mov    %esp,%ebp
  8014c0:	83 ec 04             	sub    $0x4,%esp
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8014c9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8014cd:	6a 00                	push   $0x0
  8014cf:	6a 00                	push   $0x0
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	50                   	push   %eax
  8014d6:	6a 26                	push   $0x26
  8014d8:	e8 5d fb ff ff       	call   80103a <syscall>
  8014dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8014e0:	90                   	nop
}
  8014e1:	c9                   	leave  
  8014e2:	c3                   	ret    

008014e3 <rsttst>:
void rsttst()
{
  8014e3:	55                   	push   %ebp
  8014e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 28                	push   $0x28
  8014f2:	e8 43 fb ff ff       	call   80103a <syscall>
  8014f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8014fa:	90                   	nop
}
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
  801500:	83 ec 04             	sub    $0x4,%esp
  801503:	8b 45 14             	mov    0x14(%ebp),%eax
  801506:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801509:	8b 55 18             	mov    0x18(%ebp),%edx
  80150c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801510:	52                   	push   %edx
  801511:	50                   	push   %eax
  801512:	ff 75 10             	pushl  0x10(%ebp)
  801515:	ff 75 0c             	pushl  0xc(%ebp)
  801518:	ff 75 08             	pushl  0x8(%ebp)
  80151b:	6a 27                	push   $0x27
  80151d:	e8 18 fb ff ff       	call   80103a <syscall>
  801522:	83 c4 18             	add    $0x18,%esp
	return ;
  801525:	90                   	nop
}
  801526:	c9                   	leave  
  801527:	c3                   	ret    

00801528 <chktst>:
void chktst(uint32 n)
{
  801528:	55                   	push   %ebp
  801529:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80152b:	6a 00                	push   $0x0
  80152d:	6a 00                	push   $0x0
  80152f:	6a 00                	push   $0x0
  801531:	6a 00                	push   $0x0
  801533:	ff 75 08             	pushl  0x8(%ebp)
  801536:	6a 29                	push   $0x29
  801538:	e8 fd fa ff ff       	call   80103a <syscall>
  80153d:	83 c4 18             	add    $0x18,%esp
	return ;
  801540:	90                   	nop
}
  801541:	c9                   	leave  
  801542:	c3                   	ret    

00801543 <inctst>:

void inctst()
{
  801543:	55                   	push   %ebp
  801544:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801546:	6a 00                	push   $0x0
  801548:	6a 00                	push   $0x0
  80154a:	6a 00                	push   $0x0
  80154c:	6a 00                	push   $0x0
  80154e:	6a 00                	push   $0x0
  801550:	6a 2a                	push   $0x2a
  801552:	e8 e3 fa ff ff       	call   80103a <syscall>
  801557:	83 c4 18             	add    $0x18,%esp
	return ;
  80155a:	90                   	nop
}
  80155b:	c9                   	leave  
  80155c:	c3                   	ret    

0080155d <gettst>:
uint32 gettst()
{
  80155d:	55                   	push   %ebp
  80155e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 2b                	push   $0x2b
  80156c:	e8 c9 fa ff ff       	call   80103a <syscall>
  801571:	83 c4 18             	add    $0x18,%esp
}
  801574:	c9                   	leave  
  801575:	c3                   	ret    

00801576 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801576:	55                   	push   %ebp
  801577:	89 e5                	mov    %esp,%ebp
  801579:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80157c:	6a 00                	push   $0x0
  80157e:	6a 00                	push   $0x0
  801580:	6a 00                	push   $0x0
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 2c                	push   $0x2c
  801588:	e8 ad fa ff ff       	call   80103a <syscall>
  80158d:	83 c4 18             	add    $0x18,%esp
  801590:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801593:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801597:	75 07                	jne    8015a0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801599:	b8 01 00 00 00       	mov    $0x1,%eax
  80159e:	eb 05                	jmp    8015a5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8015a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
  8015aa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015ad:	6a 00                	push   $0x0
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 2c                	push   $0x2c
  8015b9:	e8 7c fa ff ff       	call   80103a <syscall>
  8015be:	83 c4 18             	add    $0x18,%esp
  8015c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8015c4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8015c8:	75 07                	jne    8015d1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8015ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8015cf:	eb 05                	jmp    8015d6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8015d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
  8015db:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8015de:	6a 00                	push   $0x0
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 2c                	push   $0x2c
  8015ea:	e8 4b fa ff ff       	call   80103a <syscall>
  8015ef:	83 c4 18             	add    $0x18,%esp
  8015f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8015f5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8015f9:	75 07                	jne    801602 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8015fb:	b8 01 00 00 00       	mov    $0x1,%eax
  801600:	eb 05                	jmp    801607 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801602:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801607:	c9                   	leave  
  801608:	c3                   	ret    

00801609 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801609:	55                   	push   %ebp
  80160a:	89 e5                	mov    %esp,%ebp
  80160c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 2c                	push   $0x2c
  80161b:	e8 1a fa ff ff       	call   80103a <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
  801623:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801626:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80162a:	75 07                	jne    801633 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80162c:	b8 01 00 00 00       	mov    $0x1,%eax
  801631:	eb 05                	jmp    801638 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801633:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801638:	c9                   	leave  
  801639:	c3                   	ret    

0080163a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80163a:	55                   	push   %ebp
  80163b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80163d:	6a 00                	push   $0x0
  80163f:	6a 00                	push   $0x0
  801641:	6a 00                	push   $0x0
  801643:	6a 00                	push   $0x0
  801645:	ff 75 08             	pushl  0x8(%ebp)
  801648:	6a 2d                	push   $0x2d
  80164a:	e8 eb f9 ff ff       	call   80103a <syscall>
  80164f:	83 c4 18             	add    $0x18,%esp
	return ;
  801652:	90                   	nop
}
  801653:	c9                   	leave  
  801654:	c3                   	ret    

00801655 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801655:	55                   	push   %ebp
  801656:	89 e5                	mov    %esp,%ebp
  801658:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801659:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80165c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80165f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	6a 00                	push   $0x0
  801667:	53                   	push   %ebx
  801668:	51                   	push   %ecx
  801669:	52                   	push   %edx
  80166a:	50                   	push   %eax
  80166b:	6a 2e                	push   $0x2e
  80166d:	e8 c8 f9 ff ff       	call   80103a <syscall>
  801672:	83 c4 18             	add    $0x18,%esp
}
  801675:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801678:	c9                   	leave  
  801679:	c3                   	ret    

0080167a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80167a:	55                   	push   %ebp
  80167b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80167d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801680:	8b 45 08             	mov    0x8(%ebp),%eax
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	52                   	push   %edx
  80168a:	50                   	push   %eax
  80168b:	6a 2f                	push   $0x2f
  80168d:	e8 a8 f9 ff ff       	call   80103a <syscall>
  801692:	83 c4 18             	add    $0x18,%esp
}
  801695:	c9                   	leave  
  801696:	c3                   	ret    

00801697 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801697:	55                   	push   %ebp
  801698:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	ff 75 0c             	pushl  0xc(%ebp)
  8016a3:	ff 75 08             	pushl  0x8(%ebp)
  8016a6:	6a 30                	push   $0x30
  8016a8:	e8 8d f9 ff ff       	call   80103a <syscall>
  8016ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8016b0:	90                   	nop
}
  8016b1:	c9                   	leave  
  8016b2:	c3                   	ret    

008016b3 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8016b3:	55                   	push   %ebp
  8016b4:	89 e5                	mov    %esp,%ebp
  8016b6:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8016b9:	8b 55 08             	mov    0x8(%ebp),%edx
  8016bc:	89 d0                	mov    %edx,%eax
  8016be:	c1 e0 02             	shl    $0x2,%eax
  8016c1:	01 d0                	add    %edx,%eax
  8016c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016ca:	01 d0                	add    %edx,%eax
  8016cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016d3:	01 d0                	add    %edx,%eax
  8016d5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016dc:	01 d0                	add    %edx,%eax
  8016de:	c1 e0 04             	shl    $0x4,%eax
  8016e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  8016e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  8016eb:	8d 45 e8             	lea    -0x18(%ebp),%eax
  8016ee:	83 ec 0c             	sub    $0xc,%esp
  8016f1:	50                   	push   %eax
  8016f2:	e8 5a fd ff ff       	call   801451 <sys_get_virtual_time>
  8016f7:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  8016fa:	eb 41                	jmp    80173d <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  8016fc:	8d 45 e0             	lea    -0x20(%ebp),%eax
  8016ff:	83 ec 0c             	sub    $0xc,%esp
  801702:	50                   	push   %eax
  801703:	e8 49 fd ff ff       	call   801451 <sys_get_virtual_time>
  801708:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80170b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80170e:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801711:	29 c2                	sub    %eax,%edx
  801713:	89 d0                	mov    %edx,%eax
  801715:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  801718:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80171b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80171e:	89 d1                	mov    %edx,%ecx
  801720:	29 c1                	sub    %eax,%ecx
  801722:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801725:	8b 45 e0             	mov    -0x20(%ebp),%eax
  801728:	39 c2                	cmp    %eax,%edx
  80172a:	0f 97 c0             	seta   %al
  80172d:	0f b6 c0             	movzbl %al,%eax
  801730:	29 c1                	sub    %eax,%ecx
  801732:	89 c8                	mov    %ecx,%eax
  801734:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  801737:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80173a:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  80173d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801740:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801743:	72 b7                	jb     8016fc <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801745:	90                   	nop
  801746:	c9                   	leave  
  801747:	c3                   	ret    

00801748 <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  801748:	55                   	push   %ebp
  801749:	89 e5                	mov    %esp,%ebp
  80174b:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  80174e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801755:	eb 03                	jmp    80175a <busy_wait+0x12>
  801757:	ff 45 fc             	incl   -0x4(%ebp)
  80175a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80175d:	3b 45 08             	cmp    0x8(%ebp),%eax
  801760:	72 f5                	jb     801757 <busy_wait+0xf>
	return i;
  801762:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801765:	c9                   	leave  
  801766:	c3                   	ret    
  801767:	90                   	nop

00801768 <__udivdi3>:
  801768:	55                   	push   %ebp
  801769:	57                   	push   %edi
  80176a:	56                   	push   %esi
  80176b:	53                   	push   %ebx
  80176c:	83 ec 1c             	sub    $0x1c,%esp
  80176f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801773:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801777:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80177b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80177f:	89 ca                	mov    %ecx,%edx
  801781:	89 f8                	mov    %edi,%eax
  801783:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801787:	85 f6                	test   %esi,%esi
  801789:	75 2d                	jne    8017b8 <__udivdi3+0x50>
  80178b:	39 cf                	cmp    %ecx,%edi
  80178d:	77 65                	ja     8017f4 <__udivdi3+0x8c>
  80178f:	89 fd                	mov    %edi,%ebp
  801791:	85 ff                	test   %edi,%edi
  801793:	75 0b                	jne    8017a0 <__udivdi3+0x38>
  801795:	b8 01 00 00 00       	mov    $0x1,%eax
  80179a:	31 d2                	xor    %edx,%edx
  80179c:	f7 f7                	div    %edi
  80179e:	89 c5                	mov    %eax,%ebp
  8017a0:	31 d2                	xor    %edx,%edx
  8017a2:	89 c8                	mov    %ecx,%eax
  8017a4:	f7 f5                	div    %ebp
  8017a6:	89 c1                	mov    %eax,%ecx
  8017a8:	89 d8                	mov    %ebx,%eax
  8017aa:	f7 f5                	div    %ebp
  8017ac:	89 cf                	mov    %ecx,%edi
  8017ae:	89 fa                	mov    %edi,%edx
  8017b0:	83 c4 1c             	add    $0x1c,%esp
  8017b3:	5b                   	pop    %ebx
  8017b4:	5e                   	pop    %esi
  8017b5:	5f                   	pop    %edi
  8017b6:	5d                   	pop    %ebp
  8017b7:	c3                   	ret    
  8017b8:	39 ce                	cmp    %ecx,%esi
  8017ba:	77 28                	ja     8017e4 <__udivdi3+0x7c>
  8017bc:	0f bd fe             	bsr    %esi,%edi
  8017bf:	83 f7 1f             	xor    $0x1f,%edi
  8017c2:	75 40                	jne    801804 <__udivdi3+0x9c>
  8017c4:	39 ce                	cmp    %ecx,%esi
  8017c6:	72 0a                	jb     8017d2 <__udivdi3+0x6a>
  8017c8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8017cc:	0f 87 9e 00 00 00    	ja     801870 <__udivdi3+0x108>
  8017d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8017d7:	89 fa                	mov    %edi,%edx
  8017d9:	83 c4 1c             	add    $0x1c,%esp
  8017dc:	5b                   	pop    %ebx
  8017dd:	5e                   	pop    %esi
  8017de:	5f                   	pop    %edi
  8017df:	5d                   	pop    %ebp
  8017e0:	c3                   	ret    
  8017e1:	8d 76 00             	lea    0x0(%esi),%esi
  8017e4:	31 ff                	xor    %edi,%edi
  8017e6:	31 c0                	xor    %eax,%eax
  8017e8:	89 fa                	mov    %edi,%edx
  8017ea:	83 c4 1c             	add    $0x1c,%esp
  8017ed:	5b                   	pop    %ebx
  8017ee:	5e                   	pop    %esi
  8017ef:	5f                   	pop    %edi
  8017f0:	5d                   	pop    %ebp
  8017f1:	c3                   	ret    
  8017f2:	66 90                	xchg   %ax,%ax
  8017f4:	89 d8                	mov    %ebx,%eax
  8017f6:	f7 f7                	div    %edi
  8017f8:	31 ff                	xor    %edi,%edi
  8017fa:	89 fa                	mov    %edi,%edx
  8017fc:	83 c4 1c             	add    $0x1c,%esp
  8017ff:	5b                   	pop    %ebx
  801800:	5e                   	pop    %esi
  801801:	5f                   	pop    %edi
  801802:	5d                   	pop    %ebp
  801803:	c3                   	ret    
  801804:	bd 20 00 00 00       	mov    $0x20,%ebp
  801809:	89 eb                	mov    %ebp,%ebx
  80180b:	29 fb                	sub    %edi,%ebx
  80180d:	89 f9                	mov    %edi,%ecx
  80180f:	d3 e6                	shl    %cl,%esi
  801811:	89 c5                	mov    %eax,%ebp
  801813:	88 d9                	mov    %bl,%cl
  801815:	d3 ed                	shr    %cl,%ebp
  801817:	89 e9                	mov    %ebp,%ecx
  801819:	09 f1                	or     %esi,%ecx
  80181b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80181f:	89 f9                	mov    %edi,%ecx
  801821:	d3 e0                	shl    %cl,%eax
  801823:	89 c5                	mov    %eax,%ebp
  801825:	89 d6                	mov    %edx,%esi
  801827:	88 d9                	mov    %bl,%cl
  801829:	d3 ee                	shr    %cl,%esi
  80182b:	89 f9                	mov    %edi,%ecx
  80182d:	d3 e2                	shl    %cl,%edx
  80182f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801833:	88 d9                	mov    %bl,%cl
  801835:	d3 e8                	shr    %cl,%eax
  801837:	09 c2                	or     %eax,%edx
  801839:	89 d0                	mov    %edx,%eax
  80183b:	89 f2                	mov    %esi,%edx
  80183d:	f7 74 24 0c          	divl   0xc(%esp)
  801841:	89 d6                	mov    %edx,%esi
  801843:	89 c3                	mov    %eax,%ebx
  801845:	f7 e5                	mul    %ebp
  801847:	39 d6                	cmp    %edx,%esi
  801849:	72 19                	jb     801864 <__udivdi3+0xfc>
  80184b:	74 0b                	je     801858 <__udivdi3+0xf0>
  80184d:	89 d8                	mov    %ebx,%eax
  80184f:	31 ff                	xor    %edi,%edi
  801851:	e9 58 ff ff ff       	jmp    8017ae <__udivdi3+0x46>
  801856:	66 90                	xchg   %ax,%ax
  801858:	8b 54 24 08          	mov    0x8(%esp),%edx
  80185c:	89 f9                	mov    %edi,%ecx
  80185e:	d3 e2                	shl    %cl,%edx
  801860:	39 c2                	cmp    %eax,%edx
  801862:	73 e9                	jae    80184d <__udivdi3+0xe5>
  801864:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801867:	31 ff                	xor    %edi,%edi
  801869:	e9 40 ff ff ff       	jmp    8017ae <__udivdi3+0x46>
  80186e:	66 90                	xchg   %ax,%ax
  801870:	31 c0                	xor    %eax,%eax
  801872:	e9 37 ff ff ff       	jmp    8017ae <__udivdi3+0x46>
  801877:	90                   	nop

00801878 <__umoddi3>:
  801878:	55                   	push   %ebp
  801879:	57                   	push   %edi
  80187a:	56                   	push   %esi
  80187b:	53                   	push   %ebx
  80187c:	83 ec 1c             	sub    $0x1c,%esp
  80187f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801883:	8b 74 24 34          	mov    0x34(%esp),%esi
  801887:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80188b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80188f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801893:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801897:	89 f3                	mov    %esi,%ebx
  801899:	89 fa                	mov    %edi,%edx
  80189b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80189f:	89 34 24             	mov    %esi,(%esp)
  8018a2:	85 c0                	test   %eax,%eax
  8018a4:	75 1a                	jne    8018c0 <__umoddi3+0x48>
  8018a6:	39 f7                	cmp    %esi,%edi
  8018a8:	0f 86 a2 00 00 00    	jbe    801950 <__umoddi3+0xd8>
  8018ae:	89 c8                	mov    %ecx,%eax
  8018b0:	89 f2                	mov    %esi,%edx
  8018b2:	f7 f7                	div    %edi
  8018b4:	89 d0                	mov    %edx,%eax
  8018b6:	31 d2                	xor    %edx,%edx
  8018b8:	83 c4 1c             	add    $0x1c,%esp
  8018bb:	5b                   	pop    %ebx
  8018bc:	5e                   	pop    %esi
  8018bd:	5f                   	pop    %edi
  8018be:	5d                   	pop    %ebp
  8018bf:	c3                   	ret    
  8018c0:	39 f0                	cmp    %esi,%eax
  8018c2:	0f 87 ac 00 00 00    	ja     801974 <__umoddi3+0xfc>
  8018c8:	0f bd e8             	bsr    %eax,%ebp
  8018cb:	83 f5 1f             	xor    $0x1f,%ebp
  8018ce:	0f 84 ac 00 00 00    	je     801980 <__umoddi3+0x108>
  8018d4:	bf 20 00 00 00       	mov    $0x20,%edi
  8018d9:	29 ef                	sub    %ebp,%edi
  8018db:	89 fe                	mov    %edi,%esi
  8018dd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8018e1:	89 e9                	mov    %ebp,%ecx
  8018e3:	d3 e0                	shl    %cl,%eax
  8018e5:	89 d7                	mov    %edx,%edi
  8018e7:	89 f1                	mov    %esi,%ecx
  8018e9:	d3 ef                	shr    %cl,%edi
  8018eb:	09 c7                	or     %eax,%edi
  8018ed:	89 e9                	mov    %ebp,%ecx
  8018ef:	d3 e2                	shl    %cl,%edx
  8018f1:	89 14 24             	mov    %edx,(%esp)
  8018f4:	89 d8                	mov    %ebx,%eax
  8018f6:	d3 e0                	shl    %cl,%eax
  8018f8:	89 c2                	mov    %eax,%edx
  8018fa:	8b 44 24 08          	mov    0x8(%esp),%eax
  8018fe:	d3 e0                	shl    %cl,%eax
  801900:	89 44 24 04          	mov    %eax,0x4(%esp)
  801904:	8b 44 24 08          	mov    0x8(%esp),%eax
  801908:	89 f1                	mov    %esi,%ecx
  80190a:	d3 e8                	shr    %cl,%eax
  80190c:	09 d0                	or     %edx,%eax
  80190e:	d3 eb                	shr    %cl,%ebx
  801910:	89 da                	mov    %ebx,%edx
  801912:	f7 f7                	div    %edi
  801914:	89 d3                	mov    %edx,%ebx
  801916:	f7 24 24             	mull   (%esp)
  801919:	89 c6                	mov    %eax,%esi
  80191b:	89 d1                	mov    %edx,%ecx
  80191d:	39 d3                	cmp    %edx,%ebx
  80191f:	0f 82 87 00 00 00    	jb     8019ac <__umoddi3+0x134>
  801925:	0f 84 91 00 00 00    	je     8019bc <__umoddi3+0x144>
  80192b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80192f:	29 f2                	sub    %esi,%edx
  801931:	19 cb                	sbb    %ecx,%ebx
  801933:	89 d8                	mov    %ebx,%eax
  801935:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801939:	d3 e0                	shl    %cl,%eax
  80193b:	89 e9                	mov    %ebp,%ecx
  80193d:	d3 ea                	shr    %cl,%edx
  80193f:	09 d0                	or     %edx,%eax
  801941:	89 e9                	mov    %ebp,%ecx
  801943:	d3 eb                	shr    %cl,%ebx
  801945:	89 da                	mov    %ebx,%edx
  801947:	83 c4 1c             	add    $0x1c,%esp
  80194a:	5b                   	pop    %ebx
  80194b:	5e                   	pop    %esi
  80194c:	5f                   	pop    %edi
  80194d:	5d                   	pop    %ebp
  80194e:	c3                   	ret    
  80194f:	90                   	nop
  801950:	89 fd                	mov    %edi,%ebp
  801952:	85 ff                	test   %edi,%edi
  801954:	75 0b                	jne    801961 <__umoddi3+0xe9>
  801956:	b8 01 00 00 00       	mov    $0x1,%eax
  80195b:	31 d2                	xor    %edx,%edx
  80195d:	f7 f7                	div    %edi
  80195f:	89 c5                	mov    %eax,%ebp
  801961:	89 f0                	mov    %esi,%eax
  801963:	31 d2                	xor    %edx,%edx
  801965:	f7 f5                	div    %ebp
  801967:	89 c8                	mov    %ecx,%eax
  801969:	f7 f5                	div    %ebp
  80196b:	89 d0                	mov    %edx,%eax
  80196d:	e9 44 ff ff ff       	jmp    8018b6 <__umoddi3+0x3e>
  801972:	66 90                	xchg   %ax,%ax
  801974:	89 c8                	mov    %ecx,%eax
  801976:	89 f2                	mov    %esi,%edx
  801978:	83 c4 1c             	add    $0x1c,%esp
  80197b:	5b                   	pop    %ebx
  80197c:	5e                   	pop    %esi
  80197d:	5f                   	pop    %edi
  80197e:	5d                   	pop    %ebp
  80197f:	c3                   	ret    
  801980:	3b 04 24             	cmp    (%esp),%eax
  801983:	72 06                	jb     80198b <__umoddi3+0x113>
  801985:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801989:	77 0f                	ja     80199a <__umoddi3+0x122>
  80198b:	89 f2                	mov    %esi,%edx
  80198d:	29 f9                	sub    %edi,%ecx
  80198f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801993:	89 14 24             	mov    %edx,(%esp)
  801996:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80199a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80199e:	8b 14 24             	mov    (%esp),%edx
  8019a1:	83 c4 1c             	add    $0x1c,%esp
  8019a4:	5b                   	pop    %ebx
  8019a5:	5e                   	pop    %esi
  8019a6:	5f                   	pop    %edi
  8019a7:	5d                   	pop    %ebp
  8019a8:	c3                   	ret    
  8019a9:	8d 76 00             	lea    0x0(%esi),%esi
  8019ac:	2b 04 24             	sub    (%esp),%eax
  8019af:	19 fa                	sbb    %edi,%edx
  8019b1:	89 d1                	mov    %edx,%ecx
  8019b3:	89 c6                	mov    %eax,%esi
  8019b5:	e9 71 ff ff ff       	jmp    80192b <__umoddi3+0xb3>
  8019ba:	66 90                	xchg   %ax,%ax
  8019bc:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8019c0:	72 ea                	jb     8019ac <__umoddi3+0x134>
  8019c2:	89 d9                	mov    %ebx,%ecx
  8019c4:	e9 62 ff ff ff       	jmp    80192b <__umoddi3+0xb3>
