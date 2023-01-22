
obj/user/tst_semaphore_1master:     file format elf32-i386


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
  800031:	e8 8d 01 00 00       	call   8001c3 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 28             	sub    $0x28,%esp
	int envID = sys_getenvid();
  80003e:	e8 82 11 00 00       	call   8011c5 <sys_getenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)

	sys_createSemaphore("cs1", 1);
  800046:	83 ec 08             	sub    $0x8,%esp
  800049:	6a 01                	push   $0x1
  80004b:	68 20 1a 80 00       	push   $0x801a20
  800050:	e8 98 13 00 00       	call   8013ed <sys_createSemaphore>
  800055:	83 c4 10             	add    $0x10,%esp

	sys_createSemaphore("depend1", 0);
  800058:	83 ec 08             	sub    $0x8,%esp
  80005b:	6a 00                	push   $0x0
  80005d:	68 24 1a 80 00       	push   $0x801a24
  800062:	e8 86 13 00 00       	call   8013ed <sys_createSemaphore>
  800067:	83 c4 10             	add    $0x10,%esp

	int id1, id2, id3;
	id1 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80006a:	a1 20 20 80 00       	mov    0x802020,%eax
  80006f:	8b 90 a0 05 00 00    	mov    0x5a0(%eax),%edx
  800075:	a1 20 20 80 00       	mov    0x802020,%eax
  80007a:	8b 80 e0 05 00 00    	mov    0x5e0(%eax),%eax
  800080:	89 c1                	mov    %eax,%ecx
  800082:	a1 20 20 80 00       	mov    0x802020,%eax
  800087:	8b 40 74             	mov    0x74(%eax),%eax
  80008a:	52                   	push   %edx
  80008b:	51                   	push   %ecx
  80008c:	50                   	push   %eax
  80008d:	68 2c 1a 80 00       	push   $0x801a2c
  800092:	e8 67 14 00 00       	call   8014fe <sys_create_env>
  800097:	83 c4 10             	add    $0x10,%esp
  80009a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	id2 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  80009d:	a1 20 20 80 00       	mov    0x802020,%eax
  8000a2:	8b 90 a0 05 00 00    	mov    0x5a0(%eax),%edx
  8000a8:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ad:	8b 80 e0 05 00 00    	mov    0x5e0(%eax),%eax
  8000b3:	89 c1                	mov    %eax,%ecx
  8000b5:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ba:	8b 40 74             	mov    0x74(%eax),%eax
  8000bd:	52                   	push   %edx
  8000be:	51                   	push   %ecx
  8000bf:	50                   	push   %eax
  8000c0:	68 2c 1a 80 00       	push   $0x801a2c
  8000c5:	e8 34 14 00 00       	call   8014fe <sys_create_env>
  8000ca:	83 c4 10             	add    $0x10,%esp
  8000cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
	id3 = sys_create_env("sem1Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize), (myEnv->percentage_of_WS_pages_to_be_removed));
  8000d0:	a1 20 20 80 00       	mov    0x802020,%eax
  8000d5:	8b 90 a0 05 00 00    	mov    0x5a0(%eax),%edx
  8000db:	a1 20 20 80 00       	mov    0x802020,%eax
  8000e0:	8b 80 e0 05 00 00    	mov    0x5e0(%eax),%eax
  8000e6:	89 c1                	mov    %eax,%ecx
  8000e8:	a1 20 20 80 00       	mov    0x802020,%eax
  8000ed:	8b 40 74             	mov    0x74(%eax),%eax
  8000f0:	52                   	push   %edx
  8000f1:	51                   	push   %ecx
  8000f2:	50                   	push   %eax
  8000f3:	68 2c 1a 80 00       	push   $0x801a2c
  8000f8:	e8 01 14 00 00       	call   8014fe <sys_create_env>
  8000fd:	83 c4 10             	add    $0x10,%esp
  800100:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_run_env(id1);
  800103:	83 ec 0c             	sub    $0xc,%esp
  800106:	ff 75 f0             	pushl  -0x10(%ebp)
  800109:	e8 0e 14 00 00       	call   80151c <sys_run_env>
  80010e:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id2);
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	ff 75 ec             	pushl  -0x14(%ebp)
  800117:	e8 00 14 00 00       	call   80151c <sys_run_env>
  80011c:	83 c4 10             	add    $0x10,%esp
	sys_run_env(id3);
  80011f:	83 ec 0c             	sub    $0xc,%esp
  800122:	ff 75 e8             	pushl  -0x18(%ebp)
  800125:	e8 f2 13 00 00       	call   80151c <sys_run_env>
  80012a:	83 c4 10             	add    $0x10,%esp

	sys_waitSemaphore(envID, "depend1") ;
  80012d:	83 ec 08             	sub    $0x8,%esp
  800130:	68 24 1a 80 00       	push   $0x801a24
  800135:	ff 75 f4             	pushl  -0xc(%ebp)
  800138:	e8 e9 12 00 00       	call   801426 <sys_waitSemaphore>
  80013d:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  800140:	83 ec 08             	sub    $0x8,%esp
  800143:	68 24 1a 80 00       	push   $0x801a24
  800148:	ff 75 f4             	pushl  -0xc(%ebp)
  80014b:	e8 d6 12 00 00       	call   801426 <sys_waitSemaphore>
  800150:	83 c4 10             	add    $0x10,%esp
	sys_waitSemaphore(envID, "depend1") ;
  800153:	83 ec 08             	sub    $0x8,%esp
  800156:	68 24 1a 80 00       	push   $0x801a24
  80015b:	ff 75 f4             	pushl  -0xc(%ebp)
  80015e:	e8 c3 12 00 00       	call   801426 <sys_waitSemaphore>
  800163:	83 c4 10             	add    $0x10,%esp

	int sem1val = sys_getSemaphoreValue(envID, "cs1");
  800166:	83 ec 08             	sub    $0x8,%esp
  800169:	68 20 1a 80 00       	push   $0x801a20
  80016e:	ff 75 f4             	pushl  -0xc(%ebp)
  800171:	e8 93 12 00 00       	call   801409 <sys_getSemaphoreValue>
  800176:	83 c4 10             	add    $0x10,%esp
  800179:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend1");
  80017c:	83 ec 08             	sub    $0x8,%esp
  80017f:	68 24 1a 80 00       	push   $0x801a24
  800184:	ff 75 f4             	pushl  -0xc(%ebp)
  800187:	e8 7d 12 00 00       	call   801409 <sys_getSemaphoreValue>
  80018c:	83 c4 10             	add    $0x10,%esp
  80018f:	89 45 e0             	mov    %eax,-0x20(%ebp)
	if (sem2val == 0 && sem1val == 1)
  800192:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800196:	75 18                	jne    8001b0 <_main+0x178>
  800198:	83 7d e4 01          	cmpl   $0x1,-0x1c(%ebp)
  80019c:	75 12                	jne    8001b0 <_main+0x178>
		cprintf("Congratulations!! Test of Semaphores [1] completed successfully!!\n\n\n");
  80019e:	83 ec 0c             	sub    $0xc,%esp
  8001a1:	68 38 1a 80 00       	push   $0x801a38
  8001a6:	e8 08 02 00 00       	call   8003b3 <cprintf>
  8001ab:	83 c4 10             	add    $0x10,%esp
  8001ae:	eb 10                	jmp    8001c0 <_main+0x188>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  8001b0:	83 ec 0c             	sub    $0xc,%esp
  8001b3:	68 80 1a 80 00       	push   $0x801a80
  8001b8:	e8 f6 01 00 00       	call   8003b3 <cprintf>
  8001bd:	83 c4 10             	add    $0x10,%esp

	return;
  8001c0:	90                   	nop
}
  8001c1:	c9                   	leave  
  8001c2:	c3                   	ret    

008001c3 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001c3:	55                   	push   %ebp
  8001c4:	89 e5                	mov    %esp,%ebp
  8001c6:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001c9:	e8 10 10 00 00       	call   8011de <sys_getenvindex>
  8001ce:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001d1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001d4:	89 d0                	mov    %edx,%eax
  8001d6:	01 c0                	add    %eax,%eax
  8001d8:	01 d0                	add    %edx,%eax
  8001da:	c1 e0 04             	shl    $0x4,%eax
  8001dd:	29 d0                	sub    %edx,%eax
  8001df:	c1 e0 03             	shl    $0x3,%eax
  8001e2:	01 d0                	add    %edx,%eax
  8001e4:	c1 e0 02             	shl    $0x2,%eax
  8001e7:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001ec:	a3 20 20 80 00       	mov    %eax,0x802020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001f1:	a1 20 20 80 00       	mov    0x802020,%eax
  8001f6:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8001fc:	84 c0                	test   %al,%al
  8001fe:	74 0f                	je     80020f <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800200:	a1 20 20 80 00       	mov    0x802020,%eax
  800205:	05 5c 05 00 00       	add    $0x55c,%eax
  80020a:	a3 00 20 80 00       	mov    %eax,0x802000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80020f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800213:	7e 0a                	jle    80021f <libmain+0x5c>
		binaryname = argv[0];
  800215:	8b 45 0c             	mov    0xc(%ebp),%eax
  800218:	8b 00                	mov    (%eax),%eax
  80021a:	a3 00 20 80 00       	mov    %eax,0x802000

	// call user main routine
	_main(argc, argv);
  80021f:	83 ec 08             	sub    $0x8,%esp
  800222:	ff 75 0c             	pushl  0xc(%ebp)
  800225:	ff 75 08             	pushl  0x8(%ebp)
  800228:	e8 0b fe ff ff       	call   800038 <_main>
  80022d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800230:	e8 44 11 00 00       	call   801379 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800235:	83 ec 0c             	sub    $0xc,%esp
  800238:	68 e4 1a 80 00       	push   $0x801ae4
  80023d:	e8 71 01 00 00       	call   8003b3 <cprintf>
  800242:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800245:	a1 20 20 80 00       	mov    0x802020,%eax
  80024a:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800250:	a1 20 20 80 00       	mov    0x802020,%eax
  800255:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80025b:	83 ec 04             	sub    $0x4,%esp
  80025e:	52                   	push   %edx
  80025f:	50                   	push   %eax
  800260:	68 0c 1b 80 00       	push   $0x801b0c
  800265:	e8 49 01 00 00       	call   8003b3 <cprintf>
  80026a:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80026d:	a1 20 20 80 00       	mov    0x802020,%eax
  800272:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800278:	a1 20 20 80 00       	mov    0x802020,%eax
  80027d:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800283:	a1 20 20 80 00       	mov    0x802020,%eax
  800288:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80028e:	51                   	push   %ecx
  80028f:	52                   	push   %edx
  800290:	50                   	push   %eax
  800291:	68 34 1b 80 00       	push   $0x801b34
  800296:	e8 18 01 00 00       	call   8003b3 <cprintf>
  80029b:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80029e:	83 ec 0c             	sub    $0xc,%esp
  8002a1:	68 e4 1a 80 00       	push   $0x801ae4
  8002a6:	e8 08 01 00 00       	call   8003b3 <cprintf>
  8002ab:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002ae:	e8 e0 10 00 00       	call   801393 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002b3:	e8 19 00 00 00       	call   8002d1 <exit>
}
  8002b8:	90                   	nop
  8002b9:	c9                   	leave  
  8002ba:	c3                   	ret    

008002bb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002bb:	55                   	push   %ebp
  8002bc:	89 e5                	mov    %esp,%ebp
  8002be:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002c1:	83 ec 0c             	sub    $0xc,%esp
  8002c4:	6a 00                	push   $0x0
  8002c6:	e8 df 0e 00 00       	call   8011aa <sys_env_destroy>
  8002cb:	83 c4 10             	add    $0x10,%esp
}
  8002ce:	90                   	nop
  8002cf:	c9                   	leave  
  8002d0:	c3                   	ret    

008002d1 <exit>:

void
exit(void)
{
  8002d1:	55                   	push   %ebp
  8002d2:	89 e5                	mov    %esp,%ebp
  8002d4:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002d7:	e8 34 0f 00 00       	call   801210 <sys_env_exit>
}
  8002dc:	90                   	nop
  8002dd:	c9                   	leave  
  8002de:	c3                   	ret    

008002df <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8002df:	55                   	push   %ebp
  8002e0:	89 e5                	mov    %esp,%ebp
  8002e2:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8002e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002e8:	8b 00                	mov    (%eax),%eax
  8002ea:	8d 48 01             	lea    0x1(%eax),%ecx
  8002ed:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002f0:	89 0a                	mov    %ecx,(%edx)
  8002f2:	8b 55 08             	mov    0x8(%ebp),%edx
  8002f5:	88 d1                	mov    %dl,%cl
  8002f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8002fa:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8002fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800301:	8b 00                	mov    (%eax),%eax
  800303:	3d ff 00 00 00       	cmp    $0xff,%eax
  800308:	75 2c                	jne    800336 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80030a:	a0 24 20 80 00       	mov    0x802024,%al
  80030f:	0f b6 c0             	movzbl %al,%eax
  800312:	8b 55 0c             	mov    0xc(%ebp),%edx
  800315:	8b 12                	mov    (%edx),%edx
  800317:	89 d1                	mov    %edx,%ecx
  800319:	8b 55 0c             	mov    0xc(%ebp),%edx
  80031c:	83 c2 08             	add    $0x8,%edx
  80031f:	83 ec 04             	sub    $0x4,%esp
  800322:	50                   	push   %eax
  800323:	51                   	push   %ecx
  800324:	52                   	push   %edx
  800325:	e8 3e 0e 00 00       	call   801168 <sys_cputs>
  80032a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80032d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800330:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800336:	8b 45 0c             	mov    0xc(%ebp),%eax
  800339:	8b 40 04             	mov    0x4(%eax),%eax
  80033c:	8d 50 01             	lea    0x1(%eax),%edx
  80033f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800342:	89 50 04             	mov    %edx,0x4(%eax)
}
  800345:	90                   	nop
  800346:	c9                   	leave  
  800347:	c3                   	ret    

00800348 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800348:	55                   	push   %ebp
  800349:	89 e5                	mov    %esp,%ebp
  80034b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800351:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800358:	00 00 00 
	b.cnt = 0;
  80035b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800362:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800365:	ff 75 0c             	pushl  0xc(%ebp)
  800368:	ff 75 08             	pushl  0x8(%ebp)
  80036b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800371:	50                   	push   %eax
  800372:	68 df 02 80 00       	push   $0x8002df
  800377:	e8 11 02 00 00       	call   80058d <vprintfmt>
  80037c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80037f:	a0 24 20 80 00       	mov    0x802024,%al
  800384:	0f b6 c0             	movzbl %al,%eax
  800387:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80038d:	83 ec 04             	sub    $0x4,%esp
  800390:	50                   	push   %eax
  800391:	52                   	push   %edx
  800392:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800398:	83 c0 08             	add    $0x8,%eax
  80039b:	50                   	push   %eax
  80039c:	e8 c7 0d 00 00       	call   801168 <sys_cputs>
  8003a1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8003a4:	c6 05 24 20 80 00 00 	movb   $0x0,0x802024
	return b.cnt;
  8003ab:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8003b1:	c9                   	leave  
  8003b2:	c3                   	ret    

008003b3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8003b3:	55                   	push   %ebp
  8003b4:	89 e5                	mov    %esp,%ebp
  8003b6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8003b9:	c6 05 24 20 80 00 01 	movb   $0x1,0x802024
	va_start(ap, fmt);
  8003c0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	83 ec 08             	sub    $0x8,%esp
  8003cc:	ff 75 f4             	pushl  -0xc(%ebp)
  8003cf:	50                   	push   %eax
  8003d0:	e8 73 ff ff ff       	call   800348 <vcprintf>
  8003d5:	83 c4 10             	add    $0x10,%esp
  8003d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8003db:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8003de:	c9                   	leave  
  8003df:	c3                   	ret    

008003e0 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8003e0:	55                   	push   %ebp
  8003e1:	89 e5                	mov    %esp,%ebp
  8003e3:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8003e6:	e8 8e 0f 00 00       	call   801379 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8003eb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8003ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	83 ec 08             	sub    $0x8,%esp
  8003f7:	ff 75 f4             	pushl  -0xc(%ebp)
  8003fa:	50                   	push   %eax
  8003fb:	e8 48 ff ff ff       	call   800348 <vcprintf>
  800400:	83 c4 10             	add    $0x10,%esp
  800403:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800406:	e8 88 0f 00 00       	call   801393 <sys_enable_interrupt>
	return cnt;
  80040b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80040e:	c9                   	leave  
  80040f:	c3                   	ret    

00800410 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800410:	55                   	push   %ebp
  800411:	89 e5                	mov    %esp,%ebp
  800413:	53                   	push   %ebx
  800414:	83 ec 14             	sub    $0x14,%esp
  800417:	8b 45 10             	mov    0x10(%ebp),%eax
  80041a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80041d:	8b 45 14             	mov    0x14(%ebp),%eax
  800420:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800423:	8b 45 18             	mov    0x18(%ebp),%eax
  800426:	ba 00 00 00 00       	mov    $0x0,%edx
  80042b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80042e:	77 55                	ja     800485 <printnum+0x75>
  800430:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800433:	72 05                	jb     80043a <printnum+0x2a>
  800435:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800438:	77 4b                	ja     800485 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80043a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80043d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800440:	8b 45 18             	mov    0x18(%ebp),%eax
  800443:	ba 00 00 00 00       	mov    $0x0,%edx
  800448:	52                   	push   %edx
  800449:	50                   	push   %eax
  80044a:	ff 75 f4             	pushl  -0xc(%ebp)
  80044d:	ff 75 f0             	pushl  -0x10(%ebp)
  800450:	e8 63 13 00 00       	call   8017b8 <__udivdi3>
  800455:	83 c4 10             	add    $0x10,%esp
  800458:	83 ec 04             	sub    $0x4,%esp
  80045b:	ff 75 20             	pushl  0x20(%ebp)
  80045e:	53                   	push   %ebx
  80045f:	ff 75 18             	pushl  0x18(%ebp)
  800462:	52                   	push   %edx
  800463:	50                   	push   %eax
  800464:	ff 75 0c             	pushl  0xc(%ebp)
  800467:	ff 75 08             	pushl  0x8(%ebp)
  80046a:	e8 a1 ff ff ff       	call   800410 <printnum>
  80046f:	83 c4 20             	add    $0x20,%esp
  800472:	eb 1a                	jmp    80048e <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800474:	83 ec 08             	sub    $0x8,%esp
  800477:	ff 75 0c             	pushl  0xc(%ebp)
  80047a:	ff 75 20             	pushl  0x20(%ebp)
  80047d:	8b 45 08             	mov    0x8(%ebp),%eax
  800480:	ff d0                	call   *%eax
  800482:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800485:	ff 4d 1c             	decl   0x1c(%ebp)
  800488:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80048c:	7f e6                	jg     800474 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80048e:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800491:	bb 00 00 00 00       	mov    $0x0,%ebx
  800496:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800499:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80049c:	53                   	push   %ebx
  80049d:	51                   	push   %ecx
  80049e:	52                   	push   %edx
  80049f:	50                   	push   %eax
  8004a0:	e8 23 14 00 00       	call   8018c8 <__umoddi3>
  8004a5:	83 c4 10             	add    $0x10,%esp
  8004a8:	05 b4 1d 80 00       	add    $0x801db4,%eax
  8004ad:	8a 00                	mov    (%eax),%al
  8004af:	0f be c0             	movsbl %al,%eax
  8004b2:	83 ec 08             	sub    $0x8,%esp
  8004b5:	ff 75 0c             	pushl  0xc(%ebp)
  8004b8:	50                   	push   %eax
  8004b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bc:	ff d0                	call   *%eax
  8004be:	83 c4 10             	add    $0x10,%esp
}
  8004c1:	90                   	nop
  8004c2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8004c5:	c9                   	leave  
  8004c6:	c3                   	ret    

008004c7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8004c7:	55                   	push   %ebp
  8004c8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004ca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004ce:	7e 1c                	jle    8004ec <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8004d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d3:	8b 00                	mov    (%eax),%eax
  8004d5:	8d 50 08             	lea    0x8(%eax),%edx
  8004d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004db:	89 10                	mov    %edx,(%eax)
  8004dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e0:	8b 00                	mov    (%eax),%eax
  8004e2:	83 e8 08             	sub    $0x8,%eax
  8004e5:	8b 50 04             	mov    0x4(%eax),%edx
  8004e8:	8b 00                	mov    (%eax),%eax
  8004ea:	eb 40                	jmp    80052c <getuint+0x65>
	else if (lflag)
  8004ec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004f0:	74 1e                	je     800510 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8004f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f5:	8b 00                	mov    (%eax),%eax
  8004f7:	8d 50 04             	lea    0x4(%eax),%edx
  8004fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fd:	89 10                	mov    %edx,(%eax)
  8004ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800502:	8b 00                	mov    (%eax),%eax
  800504:	83 e8 04             	sub    $0x4,%eax
  800507:	8b 00                	mov    (%eax),%eax
  800509:	ba 00 00 00 00       	mov    $0x0,%edx
  80050e:	eb 1c                	jmp    80052c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	8b 00                	mov    (%eax),%eax
  800515:	8d 50 04             	lea    0x4(%eax),%edx
  800518:	8b 45 08             	mov    0x8(%ebp),%eax
  80051b:	89 10                	mov    %edx,(%eax)
  80051d:	8b 45 08             	mov    0x8(%ebp),%eax
  800520:	8b 00                	mov    (%eax),%eax
  800522:	83 e8 04             	sub    $0x4,%eax
  800525:	8b 00                	mov    (%eax),%eax
  800527:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80052c:	5d                   	pop    %ebp
  80052d:	c3                   	ret    

0080052e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80052e:	55                   	push   %ebp
  80052f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800531:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800535:	7e 1c                	jle    800553 <getint+0x25>
		return va_arg(*ap, long long);
  800537:	8b 45 08             	mov    0x8(%ebp),%eax
  80053a:	8b 00                	mov    (%eax),%eax
  80053c:	8d 50 08             	lea    0x8(%eax),%edx
  80053f:	8b 45 08             	mov    0x8(%ebp),%eax
  800542:	89 10                	mov    %edx,(%eax)
  800544:	8b 45 08             	mov    0x8(%ebp),%eax
  800547:	8b 00                	mov    (%eax),%eax
  800549:	83 e8 08             	sub    $0x8,%eax
  80054c:	8b 50 04             	mov    0x4(%eax),%edx
  80054f:	8b 00                	mov    (%eax),%eax
  800551:	eb 38                	jmp    80058b <getint+0x5d>
	else if (lflag)
  800553:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800557:	74 1a                	je     800573 <getint+0x45>
		return va_arg(*ap, long);
  800559:	8b 45 08             	mov    0x8(%ebp),%eax
  80055c:	8b 00                	mov    (%eax),%eax
  80055e:	8d 50 04             	lea    0x4(%eax),%edx
  800561:	8b 45 08             	mov    0x8(%ebp),%eax
  800564:	89 10                	mov    %edx,(%eax)
  800566:	8b 45 08             	mov    0x8(%ebp),%eax
  800569:	8b 00                	mov    (%eax),%eax
  80056b:	83 e8 04             	sub    $0x4,%eax
  80056e:	8b 00                	mov    (%eax),%eax
  800570:	99                   	cltd   
  800571:	eb 18                	jmp    80058b <getint+0x5d>
	else
		return va_arg(*ap, int);
  800573:	8b 45 08             	mov    0x8(%ebp),%eax
  800576:	8b 00                	mov    (%eax),%eax
  800578:	8d 50 04             	lea    0x4(%eax),%edx
  80057b:	8b 45 08             	mov    0x8(%ebp),%eax
  80057e:	89 10                	mov    %edx,(%eax)
  800580:	8b 45 08             	mov    0x8(%ebp),%eax
  800583:	8b 00                	mov    (%eax),%eax
  800585:	83 e8 04             	sub    $0x4,%eax
  800588:	8b 00                	mov    (%eax),%eax
  80058a:	99                   	cltd   
}
  80058b:	5d                   	pop    %ebp
  80058c:	c3                   	ret    

0080058d <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80058d:	55                   	push   %ebp
  80058e:	89 e5                	mov    %esp,%ebp
  800590:	56                   	push   %esi
  800591:	53                   	push   %ebx
  800592:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800595:	eb 17                	jmp    8005ae <vprintfmt+0x21>
			if (ch == '\0')
  800597:	85 db                	test   %ebx,%ebx
  800599:	0f 84 af 03 00 00    	je     80094e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  80059f:	83 ec 08             	sub    $0x8,%esp
  8005a2:	ff 75 0c             	pushl  0xc(%ebp)
  8005a5:	53                   	push   %ebx
  8005a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a9:	ff d0                	call   *%eax
  8005ab:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8005ae:	8b 45 10             	mov    0x10(%ebp),%eax
  8005b1:	8d 50 01             	lea    0x1(%eax),%edx
  8005b4:	89 55 10             	mov    %edx,0x10(%ebp)
  8005b7:	8a 00                	mov    (%eax),%al
  8005b9:	0f b6 d8             	movzbl %al,%ebx
  8005bc:	83 fb 25             	cmp    $0x25,%ebx
  8005bf:	75 d6                	jne    800597 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8005c1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8005c5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8005cc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8005d3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8005da:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8005e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8005e4:	8d 50 01             	lea    0x1(%eax),%edx
  8005e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8005ea:	8a 00                	mov    (%eax),%al
  8005ec:	0f b6 d8             	movzbl %al,%ebx
  8005ef:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8005f2:	83 f8 55             	cmp    $0x55,%eax
  8005f5:	0f 87 2b 03 00 00    	ja     800926 <vprintfmt+0x399>
  8005fb:	8b 04 85 d8 1d 80 00 	mov    0x801dd8(,%eax,4),%eax
  800602:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800604:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800608:	eb d7                	jmp    8005e1 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80060a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80060e:	eb d1                	jmp    8005e1 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800610:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800617:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80061a:	89 d0                	mov    %edx,%eax
  80061c:	c1 e0 02             	shl    $0x2,%eax
  80061f:	01 d0                	add    %edx,%eax
  800621:	01 c0                	add    %eax,%eax
  800623:	01 d8                	add    %ebx,%eax
  800625:	83 e8 30             	sub    $0x30,%eax
  800628:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80062b:	8b 45 10             	mov    0x10(%ebp),%eax
  80062e:	8a 00                	mov    (%eax),%al
  800630:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800633:	83 fb 2f             	cmp    $0x2f,%ebx
  800636:	7e 3e                	jle    800676 <vprintfmt+0xe9>
  800638:	83 fb 39             	cmp    $0x39,%ebx
  80063b:	7f 39                	jg     800676 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80063d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800640:	eb d5                	jmp    800617 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800642:	8b 45 14             	mov    0x14(%ebp),%eax
  800645:	83 c0 04             	add    $0x4,%eax
  800648:	89 45 14             	mov    %eax,0x14(%ebp)
  80064b:	8b 45 14             	mov    0x14(%ebp),%eax
  80064e:	83 e8 04             	sub    $0x4,%eax
  800651:	8b 00                	mov    (%eax),%eax
  800653:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800656:	eb 1f                	jmp    800677 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800658:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80065c:	79 83                	jns    8005e1 <vprintfmt+0x54>
				width = 0;
  80065e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800665:	e9 77 ff ff ff       	jmp    8005e1 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80066a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800671:	e9 6b ff ff ff       	jmp    8005e1 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800676:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800677:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80067b:	0f 89 60 ff ff ff    	jns    8005e1 <vprintfmt+0x54>
				width = precision, precision = -1;
  800681:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800684:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800687:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80068e:	e9 4e ff ff ff       	jmp    8005e1 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800693:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800696:	e9 46 ff ff ff       	jmp    8005e1 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80069b:	8b 45 14             	mov    0x14(%ebp),%eax
  80069e:	83 c0 04             	add    $0x4,%eax
  8006a1:	89 45 14             	mov    %eax,0x14(%ebp)
  8006a4:	8b 45 14             	mov    0x14(%ebp),%eax
  8006a7:	83 e8 04             	sub    $0x4,%eax
  8006aa:	8b 00                	mov    (%eax),%eax
  8006ac:	83 ec 08             	sub    $0x8,%esp
  8006af:	ff 75 0c             	pushl  0xc(%ebp)
  8006b2:	50                   	push   %eax
  8006b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b6:	ff d0                	call   *%eax
  8006b8:	83 c4 10             	add    $0x10,%esp
			break;
  8006bb:	e9 89 02 00 00       	jmp    800949 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8006c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8006c3:	83 c0 04             	add    $0x4,%eax
  8006c6:	89 45 14             	mov    %eax,0x14(%ebp)
  8006c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8006cc:	83 e8 04             	sub    $0x4,%eax
  8006cf:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8006d1:	85 db                	test   %ebx,%ebx
  8006d3:	79 02                	jns    8006d7 <vprintfmt+0x14a>
				err = -err;
  8006d5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8006d7:	83 fb 64             	cmp    $0x64,%ebx
  8006da:	7f 0b                	jg     8006e7 <vprintfmt+0x15a>
  8006dc:	8b 34 9d 20 1c 80 00 	mov    0x801c20(,%ebx,4),%esi
  8006e3:	85 f6                	test   %esi,%esi
  8006e5:	75 19                	jne    800700 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8006e7:	53                   	push   %ebx
  8006e8:	68 c5 1d 80 00       	push   $0x801dc5
  8006ed:	ff 75 0c             	pushl  0xc(%ebp)
  8006f0:	ff 75 08             	pushl  0x8(%ebp)
  8006f3:	e8 5e 02 00 00       	call   800956 <printfmt>
  8006f8:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8006fb:	e9 49 02 00 00       	jmp    800949 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800700:	56                   	push   %esi
  800701:	68 ce 1d 80 00       	push   $0x801dce
  800706:	ff 75 0c             	pushl  0xc(%ebp)
  800709:	ff 75 08             	pushl  0x8(%ebp)
  80070c:	e8 45 02 00 00       	call   800956 <printfmt>
  800711:	83 c4 10             	add    $0x10,%esp
			break;
  800714:	e9 30 02 00 00       	jmp    800949 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800719:	8b 45 14             	mov    0x14(%ebp),%eax
  80071c:	83 c0 04             	add    $0x4,%eax
  80071f:	89 45 14             	mov    %eax,0x14(%ebp)
  800722:	8b 45 14             	mov    0x14(%ebp),%eax
  800725:	83 e8 04             	sub    $0x4,%eax
  800728:	8b 30                	mov    (%eax),%esi
  80072a:	85 f6                	test   %esi,%esi
  80072c:	75 05                	jne    800733 <vprintfmt+0x1a6>
				p = "(null)";
  80072e:	be d1 1d 80 00       	mov    $0x801dd1,%esi
			if (width > 0 && padc != '-')
  800733:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800737:	7e 6d                	jle    8007a6 <vprintfmt+0x219>
  800739:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80073d:	74 67                	je     8007a6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80073f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800742:	83 ec 08             	sub    $0x8,%esp
  800745:	50                   	push   %eax
  800746:	56                   	push   %esi
  800747:	e8 0c 03 00 00       	call   800a58 <strnlen>
  80074c:	83 c4 10             	add    $0x10,%esp
  80074f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800752:	eb 16                	jmp    80076a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800754:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800758:	83 ec 08             	sub    $0x8,%esp
  80075b:	ff 75 0c             	pushl  0xc(%ebp)
  80075e:	50                   	push   %eax
  80075f:	8b 45 08             	mov    0x8(%ebp),%eax
  800762:	ff d0                	call   *%eax
  800764:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800767:	ff 4d e4             	decl   -0x1c(%ebp)
  80076a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80076e:	7f e4                	jg     800754 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800770:	eb 34                	jmp    8007a6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800772:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800776:	74 1c                	je     800794 <vprintfmt+0x207>
  800778:	83 fb 1f             	cmp    $0x1f,%ebx
  80077b:	7e 05                	jle    800782 <vprintfmt+0x1f5>
  80077d:	83 fb 7e             	cmp    $0x7e,%ebx
  800780:	7e 12                	jle    800794 <vprintfmt+0x207>
					putch('?', putdat);
  800782:	83 ec 08             	sub    $0x8,%esp
  800785:	ff 75 0c             	pushl  0xc(%ebp)
  800788:	6a 3f                	push   $0x3f
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	ff d0                	call   *%eax
  80078f:	83 c4 10             	add    $0x10,%esp
  800792:	eb 0f                	jmp    8007a3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800794:	83 ec 08             	sub    $0x8,%esp
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	53                   	push   %ebx
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	ff d0                	call   *%eax
  8007a0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8007a3:	ff 4d e4             	decl   -0x1c(%ebp)
  8007a6:	89 f0                	mov    %esi,%eax
  8007a8:	8d 70 01             	lea    0x1(%eax),%esi
  8007ab:	8a 00                	mov    (%eax),%al
  8007ad:	0f be d8             	movsbl %al,%ebx
  8007b0:	85 db                	test   %ebx,%ebx
  8007b2:	74 24                	je     8007d8 <vprintfmt+0x24b>
  8007b4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007b8:	78 b8                	js     800772 <vprintfmt+0x1e5>
  8007ba:	ff 4d e0             	decl   -0x20(%ebp)
  8007bd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8007c1:	79 af                	jns    800772 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007c3:	eb 13                	jmp    8007d8 <vprintfmt+0x24b>
				putch(' ', putdat);
  8007c5:	83 ec 08             	sub    $0x8,%esp
  8007c8:	ff 75 0c             	pushl  0xc(%ebp)
  8007cb:	6a 20                	push   $0x20
  8007cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d0:	ff d0                	call   *%eax
  8007d2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8007d5:	ff 4d e4             	decl   -0x1c(%ebp)
  8007d8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007dc:	7f e7                	jg     8007c5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8007de:	e9 66 01 00 00       	jmp    800949 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8007e3:	83 ec 08             	sub    $0x8,%esp
  8007e6:	ff 75 e8             	pushl  -0x18(%ebp)
  8007e9:	8d 45 14             	lea    0x14(%ebp),%eax
  8007ec:	50                   	push   %eax
  8007ed:	e8 3c fd ff ff       	call   80052e <getint>
  8007f2:	83 c4 10             	add    $0x10,%esp
  8007f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007f8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8007fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007fe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800801:	85 d2                	test   %edx,%edx
  800803:	79 23                	jns    800828 <vprintfmt+0x29b>
				putch('-', putdat);
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	ff 75 0c             	pushl  0xc(%ebp)
  80080b:	6a 2d                	push   $0x2d
  80080d:	8b 45 08             	mov    0x8(%ebp),%eax
  800810:	ff d0                	call   *%eax
  800812:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800815:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800818:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80081b:	f7 d8                	neg    %eax
  80081d:	83 d2 00             	adc    $0x0,%edx
  800820:	f7 da                	neg    %edx
  800822:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800825:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800828:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80082f:	e9 bc 00 00 00       	jmp    8008f0 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800834:	83 ec 08             	sub    $0x8,%esp
  800837:	ff 75 e8             	pushl  -0x18(%ebp)
  80083a:	8d 45 14             	lea    0x14(%ebp),%eax
  80083d:	50                   	push   %eax
  80083e:	e8 84 fc ff ff       	call   8004c7 <getuint>
  800843:	83 c4 10             	add    $0x10,%esp
  800846:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800849:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80084c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800853:	e9 98 00 00 00       	jmp    8008f0 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800858:	83 ec 08             	sub    $0x8,%esp
  80085b:	ff 75 0c             	pushl  0xc(%ebp)
  80085e:	6a 58                	push   $0x58
  800860:	8b 45 08             	mov    0x8(%ebp),%eax
  800863:	ff d0                	call   *%eax
  800865:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800868:	83 ec 08             	sub    $0x8,%esp
  80086b:	ff 75 0c             	pushl  0xc(%ebp)
  80086e:	6a 58                	push   $0x58
  800870:	8b 45 08             	mov    0x8(%ebp),%eax
  800873:	ff d0                	call   *%eax
  800875:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800878:	83 ec 08             	sub    $0x8,%esp
  80087b:	ff 75 0c             	pushl  0xc(%ebp)
  80087e:	6a 58                	push   $0x58
  800880:	8b 45 08             	mov    0x8(%ebp),%eax
  800883:	ff d0                	call   *%eax
  800885:	83 c4 10             	add    $0x10,%esp
			break;
  800888:	e9 bc 00 00 00       	jmp    800949 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80088d:	83 ec 08             	sub    $0x8,%esp
  800890:	ff 75 0c             	pushl  0xc(%ebp)
  800893:	6a 30                	push   $0x30
  800895:	8b 45 08             	mov    0x8(%ebp),%eax
  800898:	ff d0                	call   *%eax
  80089a:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80089d:	83 ec 08             	sub    $0x8,%esp
  8008a0:	ff 75 0c             	pushl  0xc(%ebp)
  8008a3:	6a 78                	push   $0x78
  8008a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a8:	ff d0                	call   *%eax
  8008aa:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8008ad:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b0:	83 c0 04             	add    $0x4,%eax
  8008b3:	89 45 14             	mov    %eax,0x14(%ebp)
  8008b6:	8b 45 14             	mov    0x14(%ebp),%eax
  8008b9:	83 e8 04             	sub    $0x4,%eax
  8008bc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8008be:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008c1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8008c8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8008cf:	eb 1f                	jmp    8008f0 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8008d1:	83 ec 08             	sub    $0x8,%esp
  8008d4:	ff 75 e8             	pushl  -0x18(%ebp)
  8008d7:	8d 45 14             	lea    0x14(%ebp),%eax
  8008da:	50                   	push   %eax
  8008db:	e8 e7 fb ff ff       	call   8004c7 <getuint>
  8008e0:	83 c4 10             	add    $0x10,%esp
  8008e3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008e6:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8008e9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8008f0:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8008f4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8008f7:	83 ec 04             	sub    $0x4,%esp
  8008fa:	52                   	push   %edx
  8008fb:	ff 75 e4             	pushl  -0x1c(%ebp)
  8008fe:	50                   	push   %eax
  8008ff:	ff 75 f4             	pushl  -0xc(%ebp)
  800902:	ff 75 f0             	pushl  -0x10(%ebp)
  800905:	ff 75 0c             	pushl  0xc(%ebp)
  800908:	ff 75 08             	pushl  0x8(%ebp)
  80090b:	e8 00 fb ff ff       	call   800410 <printnum>
  800910:	83 c4 20             	add    $0x20,%esp
			break;
  800913:	eb 34                	jmp    800949 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800915:	83 ec 08             	sub    $0x8,%esp
  800918:	ff 75 0c             	pushl  0xc(%ebp)
  80091b:	53                   	push   %ebx
  80091c:	8b 45 08             	mov    0x8(%ebp),%eax
  80091f:	ff d0                	call   *%eax
  800921:	83 c4 10             	add    $0x10,%esp
			break;
  800924:	eb 23                	jmp    800949 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800926:	83 ec 08             	sub    $0x8,%esp
  800929:	ff 75 0c             	pushl  0xc(%ebp)
  80092c:	6a 25                	push   $0x25
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	ff d0                	call   *%eax
  800933:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800936:	ff 4d 10             	decl   0x10(%ebp)
  800939:	eb 03                	jmp    80093e <vprintfmt+0x3b1>
  80093b:	ff 4d 10             	decl   0x10(%ebp)
  80093e:	8b 45 10             	mov    0x10(%ebp),%eax
  800941:	48                   	dec    %eax
  800942:	8a 00                	mov    (%eax),%al
  800944:	3c 25                	cmp    $0x25,%al
  800946:	75 f3                	jne    80093b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800948:	90                   	nop
		}
	}
  800949:	e9 47 fc ff ff       	jmp    800595 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  80094e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  80094f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800952:	5b                   	pop    %ebx
  800953:	5e                   	pop    %esi
  800954:	5d                   	pop    %ebp
  800955:	c3                   	ret    

00800956 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800956:	55                   	push   %ebp
  800957:	89 e5                	mov    %esp,%ebp
  800959:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80095c:	8d 45 10             	lea    0x10(%ebp),%eax
  80095f:	83 c0 04             	add    $0x4,%eax
  800962:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800965:	8b 45 10             	mov    0x10(%ebp),%eax
  800968:	ff 75 f4             	pushl  -0xc(%ebp)
  80096b:	50                   	push   %eax
  80096c:	ff 75 0c             	pushl  0xc(%ebp)
  80096f:	ff 75 08             	pushl  0x8(%ebp)
  800972:	e8 16 fc ff ff       	call   80058d <vprintfmt>
  800977:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80097a:	90                   	nop
  80097b:	c9                   	leave  
  80097c:	c3                   	ret    

0080097d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80097d:	55                   	push   %ebp
  80097e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800980:	8b 45 0c             	mov    0xc(%ebp),%eax
  800983:	8b 40 08             	mov    0x8(%eax),%eax
  800986:	8d 50 01             	lea    0x1(%eax),%edx
  800989:	8b 45 0c             	mov    0xc(%ebp),%eax
  80098c:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  80098f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800992:	8b 10                	mov    (%eax),%edx
  800994:	8b 45 0c             	mov    0xc(%ebp),%eax
  800997:	8b 40 04             	mov    0x4(%eax),%eax
  80099a:	39 c2                	cmp    %eax,%edx
  80099c:	73 12                	jae    8009b0 <sprintputch+0x33>
		*b->buf++ = ch;
  80099e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a1:	8b 00                	mov    (%eax),%eax
  8009a3:	8d 48 01             	lea    0x1(%eax),%ecx
  8009a6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009a9:	89 0a                	mov    %ecx,(%edx)
  8009ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8009ae:	88 10                	mov    %dl,(%eax)
}
  8009b0:	90                   	nop
  8009b1:	5d                   	pop    %ebp
  8009b2:	c3                   	ret    

008009b3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8009b3:	55                   	push   %ebp
  8009b4:	89 e5                	mov    %esp,%ebp
  8009b6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8009b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8009bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	01 d0                	add    %edx,%eax
  8009ca:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8009d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8009d8:	74 06                	je     8009e0 <vsnprintf+0x2d>
  8009da:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009de:	7f 07                	jg     8009e7 <vsnprintf+0x34>
		return -E_INVAL;
  8009e0:	b8 03 00 00 00       	mov    $0x3,%eax
  8009e5:	eb 20                	jmp    800a07 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8009e7:	ff 75 14             	pushl  0x14(%ebp)
  8009ea:	ff 75 10             	pushl  0x10(%ebp)
  8009ed:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8009f0:	50                   	push   %eax
  8009f1:	68 7d 09 80 00       	push   $0x80097d
  8009f6:	e8 92 fb ff ff       	call   80058d <vprintfmt>
  8009fb:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8009fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a01:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800a04:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800a07:	c9                   	leave  
  800a08:	c3                   	ret    

00800a09 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800a09:	55                   	push   %ebp
  800a0a:	89 e5                	mov    %esp,%ebp
  800a0c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800a0f:	8d 45 10             	lea    0x10(%ebp),%eax
  800a12:	83 c0 04             	add    $0x4,%eax
  800a15:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800a18:	8b 45 10             	mov    0x10(%ebp),%eax
  800a1b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a1e:	50                   	push   %eax
  800a1f:	ff 75 0c             	pushl  0xc(%ebp)
  800a22:	ff 75 08             	pushl  0x8(%ebp)
  800a25:	e8 89 ff ff ff       	call   8009b3 <vsnprintf>
  800a2a:	83 c4 10             	add    $0x10,%esp
  800a2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800a30:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a33:	c9                   	leave  
  800a34:	c3                   	ret    

00800a35 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800a35:	55                   	push   %ebp
  800a36:	89 e5                	mov    %esp,%ebp
  800a38:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800a3b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a42:	eb 06                	jmp    800a4a <strlen+0x15>
		n++;
  800a44:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800a47:	ff 45 08             	incl   0x8(%ebp)
  800a4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a4d:	8a 00                	mov    (%eax),%al
  800a4f:	84 c0                	test   %al,%al
  800a51:	75 f1                	jne    800a44 <strlen+0xf>
		n++;
	return n;
  800a53:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a56:	c9                   	leave  
  800a57:	c3                   	ret    

00800a58 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800a58:	55                   	push   %ebp
  800a59:	89 e5                	mov    %esp,%ebp
  800a5b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a5e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a65:	eb 09                	jmp    800a70 <strnlen+0x18>
		n++;
  800a67:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800a6a:	ff 45 08             	incl   0x8(%ebp)
  800a6d:	ff 4d 0c             	decl   0xc(%ebp)
  800a70:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a74:	74 09                	je     800a7f <strnlen+0x27>
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	8a 00                	mov    (%eax),%al
  800a7b:	84 c0                	test   %al,%al
  800a7d:	75 e8                	jne    800a67 <strnlen+0xf>
		n++;
	return n;
  800a7f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a82:	c9                   	leave  
  800a83:	c3                   	ret    

00800a84 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800a84:	55                   	push   %ebp
  800a85:	89 e5                	mov    %esp,%ebp
  800a87:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a90:	90                   	nop
  800a91:	8b 45 08             	mov    0x8(%ebp),%eax
  800a94:	8d 50 01             	lea    0x1(%eax),%edx
  800a97:	89 55 08             	mov    %edx,0x8(%ebp)
  800a9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a9d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800aa0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800aa3:	8a 12                	mov    (%edx),%dl
  800aa5:	88 10                	mov    %dl,(%eax)
  800aa7:	8a 00                	mov    (%eax),%al
  800aa9:	84 c0                	test   %al,%al
  800aab:	75 e4                	jne    800a91 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800aad:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ab0:	c9                   	leave  
  800ab1:	c3                   	ret    

00800ab2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800ab2:	55                   	push   %ebp
  800ab3:	89 e5                	mov    %esp,%ebp
  800ab5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  800abb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800abe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800ac5:	eb 1f                	jmp    800ae6 <strncpy+0x34>
		*dst++ = *src;
  800ac7:	8b 45 08             	mov    0x8(%ebp),%eax
  800aca:	8d 50 01             	lea    0x1(%eax),%edx
  800acd:	89 55 08             	mov    %edx,0x8(%ebp)
  800ad0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad3:	8a 12                	mov    (%edx),%dl
  800ad5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ad7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ada:	8a 00                	mov    (%eax),%al
  800adc:	84 c0                	test   %al,%al
  800ade:	74 03                	je     800ae3 <strncpy+0x31>
			src++;
  800ae0:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800ae3:	ff 45 fc             	incl   -0x4(%ebp)
  800ae6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ae9:	3b 45 10             	cmp    0x10(%ebp),%eax
  800aec:	72 d9                	jb     800ac7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800aee:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800af1:	c9                   	leave  
  800af2:	c3                   	ret    

00800af3 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800af3:	55                   	push   %ebp
  800af4:	89 e5                	mov    %esp,%ebp
  800af6:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800aff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b03:	74 30                	je     800b35 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800b05:	eb 16                	jmp    800b1d <strlcpy+0x2a>
			*dst++ = *src++;
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	8d 50 01             	lea    0x1(%eax),%edx
  800b0d:	89 55 08             	mov    %edx,0x8(%ebp)
  800b10:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b13:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b16:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b19:	8a 12                	mov    (%edx),%dl
  800b1b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800b1d:	ff 4d 10             	decl   0x10(%ebp)
  800b20:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b24:	74 09                	je     800b2f <strlcpy+0x3c>
  800b26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b29:	8a 00                	mov    (%eax),%al
  800b2b:	84 c0                	test   %al,%al
  800b2d:	75 d8                	jne    800b07 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800b2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b32:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800b35:	8b 55 08             	mov    0x8(%ebp),%edx
  800b38:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b3b:	29 c2                	sub    %eax,%edx
  800b3d:	89 d0                	mov    %edx,%eax
}
  800b3f:	c9                   	leave  
  800b40:	c3                   	ret    

00800b41 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800b41:	55                   	push   %ebp
  800b42:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800b44:	eb 06                	jmp    800b4c <strcmp+0xb>
		p++, q++;
  800b46:	ff 45 08             	incl   0x8(%ebp)
  800b49:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8a 00                	mov    (%eax),%al
  800b51:	84 c0                	test   %al,%al
  800b53:	74 0e                	je     800b63 <strcmp+0x22>
  800b55:	8b 45 08             	mov    0x8(%ebp),%eax
  800b58:	8a 10                	mov    (%eax),%dl
  800b5a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5d:	8a 00                	mov    (%eax),%al
  800b5f:	38 c2                	cmp    %al,%dl
  800b61:	74 e3                	je     800b46 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800b63:	8b 45 08             	mov    0x8(%ebp),%eax
  800b66:	8a 00                	mov    (%eax),%al
  800b68:	0f b6 d0             	movzbl %al,%edx
  800b6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6e:	8a 00                	mov    (%eax),%al
  800b70:	0f b6 c0             	movzbl %al,%eax
  800b73:	29 c2                	sub    %eax,%edx
  800b75:	89 d0                	mov    %edx,%eax
}
  800b77:	5d                   	pop    %ebp
  800b78:	c3                   	ret    

00800b79 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800b7c:	eb 09                	jmp    800b87 <strncmp+0xe>
		n--, p++, q++;
  800b7e:	ff 4d 10             	decl   0x10(%ebp)
  800b81:	ff 45 08             	incl   0x8(%ebp)
  800b84:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800b87:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b8b:	74 17                	je     800ba4 <strncmp+0x2b>
  800b8d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b90:	8a 00                	mov    (%eax),%al
  800b92:	84 c0                	test   %al,%al
  800b94:	74 0e                	je     800ba4 <strncmp+0x2b>
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	8a 10                	mov    (%eax),%dl
  800b9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b9e:	8a 00                	mov    (%eax),%al
  800ba0:	38 c2                	cmp    %al,%dl
  800ba2:	74 da                	je     800b7e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ba4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ba8:	75 07                	jne    800bb1 <strncmp+0x38>
		return 0;
  800baa:	b8 00 00 00 00       	mov    $0x0,%eax
  800baf:	eb 14                	jmp    800bc5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	8a 00                	mov    (%eax),%al
  800bb6:	0f b6 d0             	movzbl %al,%edx
  800bb9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bbc:	8a 00                	mov    (%eax),%al
  800bbe:	0f b6 c0             	movzbl %al,%eax
  800bc1:	29 c2                	sub    %eax,%edx
  800bc3:	89 d0                	mov    %edx,%eax
}
  800bc5:	5d                   	pop    %ebp
  800bc6:	c3                   	ret    

00800bc7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800bc7:	55                   	push   %ebp
  800bc8:	89 e5                	mov    %esp,%ebp
  800bca:	83 ec 04             	sub    $0x4,%esp
  800bcd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800bd3:	eb 12                	jmp    800be7 <strchr+0x20>
		if (*s == c)
  800bd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd8:	8a 00                	mov    (%eax),%al
  800bda:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800bdd:	75 05                	jne    800be4 <strchr+0x1d>
			return (char *) s;
  800bdf:	8b 45 08             	mov    0x8(%ebp),%eax
  800be2:	eb 11                	jmp    800bf5 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800be4:	ff 45 08             	incl   0x8(%ebp)
  800be7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bea:	8a 00                	mov    (%eax),%al
  800bec:	84 c0                	test   %al,%al
  800bee:	75 e5                	jne    800bd5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800bf0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800bf5:	c9                   	leave  
  800bf6:	c3                   	ret    

00800bf7 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800bf7:	55                   	push   %ebp
  800bf8:	89 e5                	mov    %esp,%ebp
  800bfa:	83 ec 04             	sub    $0x4,%esp
  800bfd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c00:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c03:	eb 0d                	jmp    800c12 <strfind+0x1b>
		if (*s == c)
  800c05:	8b 45 08             	mov    0x8(%ebp),%eax
  800c08:	8a 00                	mov    (%eax),%al
  800c0a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c0d:	74 0e                	je     800c1d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800c0f:	ff 45 08             	incl   0x8(%ebp)
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	8a 00                	mov    (%eax),%al
  800c17:	84 c0                	test   %al,%al
  800c19:	75 ea                	jne    800c05 <strfind+0xe>
  800c1b:	eb 01                	jmp    800c1e <strfind+0x27>
		if (*s == c)
			break;
  800c1d:	90                   	nop
	return (char *) s;
  800c1e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c21:	c9                   	leave  
  800c22:	c3                   	ret    

00800c23 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800c23:	55                   	push   %ebp
  800c24:	89 e5                	mov    %esp,%ebp
  800c26:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800c29:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800c2f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c32:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800c35:	eb 0e                	jmp    800c45 <memset+0x22>
		*p++ = c;
  800c37:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c3a:	8d 50 01             	lea    0x1(%eax),%edx
  800c3d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800c40:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c43:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800c45:	ff 4d f8             	decl   -0x8(%ebp)
  800c48:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800c4c:	79 e9                	jns    800c37 <memset+0x14>
		*p++ = c;

	return v;
  800c4e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c51:	c9                   	leave  
  800c52:	c3                   	ret    

00800c53 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800c53:	55                   	push   %ebp
  800c54:	89 e5                	mov    %esp,%ebp
  800c56:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c59:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800c65:	eb 16                	jmp    800c7d <memcpy+0x2a>
		*d++ = *s++;
  800c67:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c6a:	8d 50 01             	lea    0x1(%eax),%edx
  800c6d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c70:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c73:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c76:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c79:	8a 12                	mov    (%edx),%dl
  800c7b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800c7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c80:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c83:	89 55 10             	mov    %edx,0x10(%ebp)
  800c86:	85 c0                	test   %eax,%eax
  800c88:	75 dd                	jne    800c67 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800c8a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c8d:	c9                   	leave  
  800c8e:	c3                   	ret    

00800c8f <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c8f:	55                   	push   %ebp
  800c90:	89 e5                	mov    %esp,%ebp
  800c92:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c98:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ca1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ca7:	73 50                	jae    800cf9 <memmove+0x6a>
  800ca9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cac:	8b 45 10             	mov    0x10(%ebp),%eax
  800caf:	01 d0                	add    %edx,%eax
  800cb1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800cb4:	76 43                	jbe    800cf9 <memmove+0x6a>
		s += n;
  800cb6:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800cbc:	8b 45 10             	mov    0x10(%ebp),%eax
  800cbf:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800cc2:	eb 10                	jmp    800cd4 <memmove+0x45>
			*--d = *--s;
  800cc4:	ff 4d f8             	decl   -0x8(%ebp)
  800cc7:	ff 4d fc             	decl   -0x4(%ebp)
  800cca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ccd:	8a 10                	mov    (%eax),%dl
  800ccf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cd2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800cd4:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cda:	89 55 10             	mov    %edx,0x10(%ebp)
  800cdd:	85 c0                	test   %eax,%eax
  800cdf:	75 e3                	jne    800cc4 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800ce1:	eb 23                	jmp    800d06 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800ce3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ce6:	8d 50 01             	lea    0x1(%eax),%edx
  800ce9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800cec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800cef:	8d 4a 01             	lea    0x1(%edx),%ecx
  800cf2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800cf5:	8a 12                	mov    (%edx),%dl
  800cf7:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800cf9:	8b 45 10             	mov    0x10(%ebp),%eax
  800cfc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cff:	89 55 10             	mov    %edx,0x10(%ebp)
  800d02:	85 c0                	test   %eax,%eax
  800d04:	75 dd                	jne    800ce3 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800d06:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d09:	c9                   	leave  
  800d0a:	c3                   	ret    

00800d0b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800d0b:	55                   	push   %ebp
  800d0c:	89 e5                	mov    %esp,%ebp
  800d0e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800d11:	8b 45 08             	mov    0x8(%ebp),%eax
  800d14:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800d17:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800d1d:	eb 2a                	jmp    800d49 <memcmp+0x3e>
		if (*s1 != *s2)
  800d1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d22:	8a 10                	mov    (%eax),%dl
  800d24:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d27:	8a 00                	mov    (%eax),%al
  800d29:	38 c2                	cmp    %al,%dl
  800d2b:	74 16                	je     800d43 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800d2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d30:	8a 00                	mov    (%eax),%al
  800d32:	0f b6 d0             	movzbl %al,%edx
  800d35:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	0f b6 c0             	movzbl %al,%eax
  800d3d:	29 c2                	sub    %eax,%edx
  800d3f:	89 d0                	mov    %edx,%eax
  800d41:	eb 18                	jmp    800d5b <memcmp+0x50>
		s1++, s2++;
  800d43:	ff 45 fc             	incl   -0x4(%ebp)
  800d46:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800d49:	8b 45 10             	mov    0x10(%ebp),%eax
  800d4c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d4f:	89 55 10             	mov    %edx,0x10(%ebp)
  800d52:	85 c0                	test   %eax,%eax
  800d54:	75 c9                	jne    800d1f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800d56:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d5b:	c9                   	leave  
  800d5c:	c3                   	ret    

00800d5d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800d5d:	55                   	push   %ebp
  800d5e:	89 e5                	mov    %esp,%ebp
  800d60:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800d63:	8b 55 08             	mov    0x8(%ebp),%edx
  800d66:	8b 45 10             	mov    0x10(%ebp),%eax
  800d69:	01 d0                	add    %edx,%eax
  800d6b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800d6e:	eb 15                	jmp    800d85 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800d70:	8b 45 08             	mov    0x8(%ebp),%eax
  800d73:	8a 00                	mov    (%eax),%al
  800d75:	0f b6 d0             	movzbl %al,%edx
  800d78:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7b:	0f b6 c0             	movzbl %al,%eax
  800d7e:	39 c2                	cmp    %eax,%edx
  800d80:	74 0d                	je     800d8f <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800d82:	ff 45 08             	incl   0x8(%ebp)
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d8b:	72 e3                	jb     800d70 <memfind+0x13>
  800d8d:	eb 01                	jmp    800d90 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d8f:	90                   	nop
	return (void *) s;
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d93:	c9                   	leave  
  800d94:	c3                   	ret    

00800d95 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d95:	55                   	push   %ebp
  800d96:	89 e5                	mov    %esp,%ebp
  800d98:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d9b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800da2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800da9:	eb 03                	jmp    800dae <strtol+0x19>
		s++;
  800dab:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800dae:	8b 45 08             	mov    0x8(%ebp),%eax
  800db1:	8a 00                	mov    (%eax),%al
  800db3:	3c 20                	cmp    $0x20,%al
  800db5:	74 f4                	je     800dab <strtol+0x16>
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	8a 00                	mov    (%eax),%al
  800dbc:	3c 09                	cmp    $0x9,%al
  800dbe:	74 eb                	je     800dab <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc3:	8a 00                	mov    (%eax),%al
  800dc5:	3c 2b                	cmp    $0x2b,%al
  800dc7:	75 05                	jne    800dce <strtol+0x39>
		s++;
  800dc9:	ff 45 08             	incl   0x8(%ebp)
  800dcc:	eb 13                	jmp    800de1 <strtol+0x4c>
	else if (*s == '-')
  800dce:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd1:	8a 00                	mov    (%eax),%al
  800dd3:	3c 2d                	cmp    $0x2d,%al
  800dd5:	75 0a                	jne    800de1 <strtol+0x4c>
		s++, neg = 1;
  800dd7:	ff 45 08             	incl   0x8(%ebp)
  800dda:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800de1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800de5:	74 06                	je     800ded <strtol+0x58>
  800de7:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800deb:	75 20                	jne    800e0d <strtol+0x78>
  800ded:	8b 45 08             	mov    0x8(%ebp),%eax
  800df0:	8a 00                	mov    (%eax),%al
  800df2:	3c 30                	cmp    $0x30,%al
  800df4:	75 17                	jne    800e0d <strtol+0x78>
  800df6:	8b 45 08             	mov    0x8(%ebp),%eax
  800df9:	40                   	inc    %eax
  800dfa:	8a 00                	mov    (%eax),%al
  800dfc:	3c 78                	cmp    $0x78,%al
  800dfe:	75 0d                	jne    800e0d <strtol+0x78>
		s += 2, base = 16;
  800e00:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800e04:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800e0b:	eb 28                	jmp    800e35 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800e0d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e11:	75 15                	jne    800e28 <strtol+0x93>
  800e13:	8b 45 08             	mov    0x8(%ebp),%eax
  800e16:	8a 00                	mov    (%eax),%al
  800e18:	3c 30                	cmp    $0x30,%al
  800e1a:	75 0c                	jne    800e28 <strtol+0x93>
		s++, base = 8;
  800e1c:	ff 45 08             	incl   0x8(%ebp)
  800e1f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800e26:	eb 0d                	jmp    800e35 <strtol+0xa0>
	else if (base == 0)
  800e28:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e2c:	75 07                	jne    800e35 <strtol+0xa0>
		base = 10;
  800e2e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800e35:	8b 45 08             	mov    0x8(%ebp),%eax
  800e38:	8a 00                	mov    (%eax),%al
  800e3a:	3c 2f                	cmp    $0x2f,%al
  800e3c:	7e 19                	jle    800e57 <strtol+0xc2>
  800e3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e41:	8a 00                	mov    (%eax),%al
  800e43:	3c 39                	cmp    $0x39,%al
  800e45:	7f 10                	jg     800e57 <strtol+0xc2>
			dig = *s - '0';
  800e47:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4a:	8a 00                	mov    (%eax),%al
  800e4c:	0f be c0             	movsbl %al,%eax
  800e4f:	83 e8 30             	sub    $0x30,%eax
  800e52:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e55:	eb 42                	jmp    800e99 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800e57:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5a:	8a 00                	mov    (%eax),%al
  800e5c:	3c 60                	cmp    $0x60,%al
  800e5e:	7e 19                	jle    800e79 <strtol+0xe4>
  800e60:	8b 45 08             	mov    0x8(%ebp),%eax
  800e63:	8a 00                	mov    (%eax),%al
  800e65:	3c 7a                	cmp    $0x7a,%al
  800e67:	7f 10                	jg     800e79 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	8a 00                	mov    (%eax),%al
  800e6e:	0f be c0             	movsbl %al,%eax
  800e71:	83 e8 57             	sub    $0x57,%eax
  800e74:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800e77:	eb 20                	jmp    800e99 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	8a 00                	mov    (%eax),%al
  800e7e:	3c 40                	cmp    $0x40,%al
  800e80:	7e 39                	jle    800ebb <strtol+0x126>
  800e82:	8b 45 08             	mov    0x8(%ebp),%eax
  800e85:	8a 00                	mov    (%eax),%al
  800e87:	3c 5a                	cmp    $0x5a,%al
  800e89:	7f 30                	jg     800ebb <strtol+0x126>
			dig = *s - 'A' + 10;
  800e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8e:	8a 00                	mov    (%eax),%al
  800e90:	0f be c0             	movsbl %al,%eax
  800e93:	83 e8 37             	sub    $0x37,%eax
  800e96:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e99:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e9c:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e9f:	7d 19                	jge    800eba <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800ea1:	ff 45 08             	incl   0x8(%ebp)
  800ea4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ea7:	0f af 45 10          	imul   0x10(%ebp),%eax
  800eab:	89 c2                	mov    %eax,%edx
  800ead:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800eb0:	01 d0                	add    %edx,%eax
  800eb2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800eb5:	e9 7b ff ff ff       	jmp    800e35 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800eba:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800ebb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ebf:	74 08                	je     800ec9 <strtol+0x134>
		*endptr = (char *) s;
  800ec1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ec7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800ec9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ecd:	74 07                	je     800ed6 <strtol+0x141>
  800ecf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ed2:	f7 d8                	neg    %eax
  800ed4:	eb 03                	jmp    800ed9 <strtol+0x144>
  800ed6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ed9:	c9                   	leave  
  800eda:	c3                   	ret    

00800edb <ltostr>:

void
ltostr(long value, char *str)
{
  800edb:	55                   	push   %ebp
  800edc:	89 e5                	mov    %esp,%ebp
  800ede:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800ee1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800ee8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800eef:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800ef3:	79 13                	jns    800f08 <ltostr+0x2d>
	{
		neg = 1;
  800ef5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800efc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eff:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800f02:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800f05:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800f08:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800f10:	99                   	cltd   
  800f11:	f7 f9                	idiv   %ecx
  800f13:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800f16:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f19:	8d 50 01             	lea    0x1(%eax),%edx
  800f1c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f1f:	89 c2                	mov    %eax,%edx
  800f21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f24:	01 d0                	add    %edx,%eax
  800f26:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800f29:	83 c2 30             	add    $0x30,%edx
  800f2c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800f2e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f31:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f36:	f7 e9                	imul   %ecx
  800f38:	c1 fa 02             	sar    $0x2,%edx
  800f3b:	89 c8                	mov    %ecx,%eax
  800f3d:	c1 f8 1f             	sar    $0x1f,%eax
  800f40:	29 c2                	sub    %eax,%edx
  800f42:	89 d0                	mov    %edx,%eax
  800f44:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800f47:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800f4a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800f4f:	f7 e9                	imul   %ecx
  800f51:	c1 fa 02             	sar    $0x2,%edx
  800f54:	89 c8                	mov    %ecx,%eax
  800f56:	c1 f8 1f             	sar    $0x1f,%eax
  800f59:	29 c2                	sub    %eax,%edx
  800f5b:	89 d0                	mov    %edx,%eax
  800f5d:	c1 e0 02             	shl    $0x2,%eax
  800f60:	01 d0                	add    %edx,%eax
  800f62:	01 c0                	add    %eax,%eax
  800f64:	29 c1                	sub    %eax,%ecx
  800f66:	89 ca                	mov    %ecx,%edx
  800f68:	85 d2                	test   %edx,%edx
  800f6a:	75 9c                	jne    800f08 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800f6c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800f73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f76:	48                   	dec    %eax
  800f77:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800f7a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f7e:	74 3d                	je     800fbd <ltostr+0xe2>
		start = 1 ;
  800f80:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800f87:	eb 34                	jmp    800fbd <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800f89:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8f:	01 d0                	add    %edx,%eax
  800f91:	8a 00                	mov    (%eax),%al
  800f93:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f96:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9c:	01 c2                	add    %eax,%edx
  800f9e:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800fa1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa4:	01 c8                	add    %ecx,%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800faa:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800fad:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb0:	01 c2                	add    %eax,%edx
  800fb2:	8a 45 eb             	mov    -0x15(%ebp),%al
  800fb5:	88 02                	mov    %al,(%edx)
		start++ ;
  800fb7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800fba:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800fbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fc0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fc3:	7c c4                	jl     800f89 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800fc5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800fc8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fcb:	01 d0                	add    %edx,%eax
  800fcd:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800fd0:	90                   	nop
  800fd1:	c9                   	leave  
  800fd2:	c3                   	ret    

00800fd3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800fd3:	55                   	push   %ebp
  800fd4:	89 e5                	mov    %esp,%ebp
  800fd6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800fd9:	ff 75 08             	pushl  0x8(%ebp)
  800fdc:	e8 54 fa ff ff       	call   800a35 <strlen>
  800fe1:	83 c4 04             	add    $0x4,%esp
  800fe4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800fe7:	ff 75 0c             	pushl  0xc(%ebp)
  800fea:	e8 46 fa ff ff       	call   800a35 <strlen>
  800fef:	83 c4 04             	add    $0x4,%esp
  800ff2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800ff5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800ffc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801003:	eb 17                	jmp    80101c <strcconcat+0x49>
		final[s] = str1[s] ;
  801005:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801008:	8b 45 10             	mov    0x10(%ebp),%eax
  80100b:	01 c2                	add    %eax,%edx
  80100d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	01 c8                	add    %ecx,%eax
  801015:	8a 00                	mov    (%eax),%al
  801017:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801019:	ff 45 fc             	incl   -0x4(%ebp)
  80101c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801022:	7c e1                	jl     801005 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801024:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80102b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801032:	eb 1f                	jmp    801053 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801034:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801037:	8d 50 01             	lea    0x1(%eax),%edx
  80103a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80103d:	89 c2                	mov    %eax,%edx
  80103f:	8b 45 10             	mov    0x10(%ebp),%eax
  801042:	01 c2                	add    %eax,%edx
  801044:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801047:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104a:	01 c8                	add    %ecx,%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801050:	ff 45 f8             	incl   -0x8(%ebp)
  801053:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801056:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801059:	7c d9                	jl     801034 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80105b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80105e:	8b 45 10             	mov    0x10(%ebp),%eax
  801061:	01 d0                	add    %edx,%eax
  801063:	c6 00 00             	movb   $0x0,(%eax)
}
  801066:	90                   	nop
  801067:	c9                   	leave  
  801068:	c3                   	ret    

00801069 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801069:	55                   	push   %ebp
  80106a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80106c:	8b 45 14             	mov    0x14(%ebp),%eax
  80106f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801075:	8b 45 14             	mov    0x14(%ebp),%eax
  801078:	8b 00                	mov    (%eax),%eax
  80107a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801081:	8b 45 10             	mov    0x10(%ebp),%eax
  801084:	01 d0                	add    %edx,%eax
  801086:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80108c:	eb 0c                	jmp    80109a <strsplit+0x31>
			*string++ = 0;
  80108e:	8b 45 08             	mov    0x8(%ebp),%eax
  801091:	8d 50 01             	lea    0x1(%eax),%edx
  801094:	89 55 08             	mov    %edx,0x8(%ebp)
  801097:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80109a:	8b 45 08             	mov    0x8(%ebp),%eax
  80109d:	8a 00                	mov    (%eax),%al
  80109f:	84 c0                	test   %al,%al
  8010a1:	74 18                	je     8010bb <strsplit+0x52>
  8010a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a6:	8a 00                	mov    (%eax),%al
  8010a8:	0f be c0             	movsbl %al,%eax
  8010ab:	50                   	push   %eax
  8010ac:	ff 75 0c             	pushl  0xc(%ebp)
  8010af:	e8 13 fb ff ff       	call   800bc7 <strchr>
  8010b4:	83 c4 08             	add    $0x8,%esp
  8010b7:	85 c0                	test   %eax,%eax
  8010b9:	75 d3                	jne    80108e <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8010bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010be:	8a 00                	mov    (%eax),%al
  8010c0:	84 c0                	test   %al,%al
  8010c2:	74 5a                	je     80111e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8010c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8010c7:	8b 00                	mov    (%eax),%eax
  8010c9:	83 f8 0f             	cmp    $0xf,%eax
  8010cc:	75 07                	jne    8010d5 <strsplit+0x6c>
		{
			return 0;
  8010ce:	b8 00 00 00 00       	mov    $0x0,%eax
  8010d3:	eb 66                	jmp    80113b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8010d5:	8b 45 14             	mov    0x14(%ebp),%eax
  8010d8:	8b 00                	mov    (%eax),%eax
  8010da:	8d 48 01             	lea    0x1(%eax),%ecx
  8010dd:	8b 55 14             	mov    0x14(%ebp),%edx
  8010e0:	89 0a                	mov    %ecx,(%edx)
  8010e2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ec:	01 c2                	add    %eax,%edx
  8010ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f1:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010f3:	eb 03                	jmp    8010f8 <strsplit+0x8f>
			string++;
  8010f5:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	8a 00                	mov    (%eax),%al
  8010fd:	84 c0                	test   %al,%al
  8010ff:	74 8b                	je     80108c <strsplit+0x23>
  801101:	8b 45 08             	mov    0x8(%ebp),%eax
  801104:	8a 00                	mov    (%eax),%al
  801106:	0f be c0             	movsbl %al,%eax
  801109:	50                   	push   %eax
  80110a:	ff 75 0c             	pushl  0xc(%ebp)
  80110d:	e8 b5 fa ff ff       	call   800bc7 <strchr>
  801112:	83 c4 08             	add    $0x8,%esp
  801115:	85 c0                	test   %eax,%eax
  801117:	74 dc                	je     8010f5 <strsplit+0x8c>
			string++;
	}
  801119:	e9 6e ff ff ff       	jmp    80108c <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80111e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80111f:	8b 45 14             	mov    0x14(%ebp),%eax
  801122:	8b 00                	mov    (%eax),%eax
  801124:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80112b:	8b 45 10             	mov    0x10(%ebp),%eax
  80112e:	01 d0                	add    %edx,%eax
  801130:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801136:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80113b:	c9                   	leave  
  80113c:	c3                   	ret    

0080113d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80113d:	55                   	push   %ebp
  80113e:	89 e5                	mov    %esp,%ebp
  801140:	57                   	push   %edi
  801141:	56                   	push   %esi
  801142:	53                   	push   %ebx
  801143:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801146:	8b 45 08             	mov    0x8(%ebp),%eax
  801149:	8b 55 0c             	mov    0xc(%ebp),%edx
  80114c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80114f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801152:	8b 7d 18             	mov    0x18(%ebp),%edi
  801155:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801158:	cd 30                	int    $0x30
  80115a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80115d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801160:	83 c4 10             	add    $0x10,%esp
  801163:	5b                   	pop    %ebx
  801164:	5e                   	pop    %esi
  801165:	5f                   	pop    %edi
  801166:	5d                   	pop    %ebp
  801167:	c3                   	ret    

00801168 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801168:	55                   	push   %ebp
  801169:	89 e5                	mov    %esp,%ebp
  80116b:	83 ec 04             	sub    $0x4,%esp
  80116e:	8b 45 10             	mov    0x10(%ebp),%eax
  801171:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801174:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801178:	8b 45 08             	mov    0x8(%ebp),%eax
  80117b:	6a 00                	push   $0x0
  80117d:	6a 00                	push   $0x0
  80117f:	52                   	push   %edx
  801180:	ff 75 0c             	pushl  0xc(%ebp)
  801183:	50                   	push   %eax
  801184:	6a 00                	push   $0x0
  801186:	e8 b2 ff ff ff       	call   80113d <syscall>
  80118b:	83 c4 18             	add    $0x18,%esp
}
  80118e:	90                   	nop
  80118f:	c9                   	leave  
  801190:	c3                   	ret    

00801191 <sys_cgetc>:

int
sys_cgetc(void)
{
  801191:	55                   	push   %ebp
  801192:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801194:	6a 00                	push   $0x0
  801196:	6a 00                	push   $0x0
  801198:	6a 00                	push   $0x0
  80119a:	6a 00                	push   $0x0
  80119c:	6a 00                	push   $0x0
  80119e:	6a 01                	push   $0x1
  8011a0:	e8 98 ff ff ff       	call   80113d <syscall>
  8011a5:	83 c4 18             	add    $0x18,%esp
}
  8011a8:	c9                   	leave  
  8011a9:	c3                   	ret    

008011aa <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8011aa:	55                   	push   %ebp
  8011ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8011ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b0:	6a 00                	push   $0x0
  8011b2:	6a 00                	push   $0x0
  8011b4:	6a 00                	push   $0x0
  8011b6:	6a 00                	push   $0x0
  8011b8:	50                   	push   %eax
  8011b9:	6a 05                	push   $0x5
  8011bb:	e8 7d ff ff ff       	call   80113d <syscall>
  8011c0:	83 c4 18             	add    $0x18,%esp
}
  8011c3:	c9                   	leave  
  8011c4:	c3                   	ret    

008011c5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8011c5:	55                   	push   %ebp
  8011c6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8011c8:	6a 00                	push   $0x0
  8011ca:	6a 00                	push   $0x0
  8011cc:	6a 00                	push   $0x0
  8011ce:	6a 00                	push   $0x0
  8011d0:	6a 00                	push   $0x0
  8011d2:	6a 02                	push   $0x2
  8011d4:	e8 64 ff ff ff       	call   80113d <syscall>
  8011d9:	83 c4 18             	add    $0x18,%esp
}
  8011dc:	c9                   	leave  
  8011dd:	c3                   	ret    

008011de <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8011de:	55                   	push   %ebp
  8011df:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8011e1:	6a 00                	push   $0x0
  8011e3:	6a 00                	push   $0x0
  8011e5:	6a 00                	push   $0x0
  8011e7:	6a 00                	push   $0x0
  8011e9:	6a 00                	push   $0x0
  8011eb:	6a 03                	push   $0x3
  8011ed:	e8 4b ff ff ff       	call   80113d <syscall>
  8011f2:	83 c4 18             	add    $0x18,%esp
}
  8011f5:	c9                   	leave  
  8011f6:	c3                   	ret    

008011f7 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8011f7:	55                   	push   %ebp
  8011f8:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8011fa:	6a 00                	push   $0x0
  8011fc:	6a 00                	push   $0x0
  8011fe:	6a 00                	push   $0x0
  801200:	6a 00                	push   $0x0
  801202:	6a 00                	push   $0x0
  801204:	6a 04                	push   $0x4
  801206:	e8 32 ff ff ff       	call   80113d <syscall>
  80120b:	83 c4 18             	add    $0x18,%esp
}
  80120e:	c9                   	leave  
  80120f:	c3                   	ret    

00801210 <sys_env_exit>:


void sys_env_exit(void)
{
  801210:	55                   	push   %ebp
  801211:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801213:	6a 00                	push   $0x0
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	6a 06                	push   $0x6
  80121f:	e8 19 ff ff ff       	call   80113d <syscall>
  801224:	83 c4 18             	add    $0x18,%esp
}
  801227:	90                   	nop
  801228:	c9                   	leave  
  801229:	c3                   	ret    

0080122a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80122a:	55                   	push   %ebp
  80122b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80122d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801230:	8b 45 08             	mov    0x8(%ebp),%eax
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 00                	push   $0x0
  801239:	52                   	push   %edx
  80123a:	50                   	push   %eax
  80123b:	6a 07                	push   $0x7
  80123d:	e8 fb fe ff ff       	call   80113d <syscall>
  801242:	83 c4 18             	add    $0x18,%esp
}
  801245:	c9                   	leave  
  801246:	c3                   	ret    

00801247 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801247:	55                   	push   %ebp
  801248:	89 e5                	mov    %esp,%ebp
  80124a:	56                   	push   %esi
  80124b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80124c:	8b 75 18             	mov    0x18(%ebp),%esi
  80124f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801252:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801255:	8b 55 0c             	mov    0xc(%ebp),%edx
  801258:	8b 45 08             	mov    0x8(%ebp),%eax
  80125b:	56                   	push   %esi
  80125c:	53                   	push   %ebx
  80125d:	51                   	push   %ecx
  80125e:	52                   	push   %edx
  80125f:	50                   	push   %eax
  801260:	6a 08                	push   $0x8
  801262:	e8 d6 fe ff ff       	call   80113d <syscall>
  801267:	83 c4 18             	add    $0x18,%esp
}
  80126a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80126d:	5b                   	pop    %ebx
  80126e:	5e                   	pop    %esi
  80126f:	5d                   	pop    %ebp
  801270:	c3                   	ret    

00801271 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801271:	55                   	push   %ebp
  801272:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801274:	8b 55 0c             	mov    0xc(%ebp),%edx
  801277:	8b 45 08             	mov    0x8(%ebp),%eax
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	52                   	push   %edx
  801281:	50                   	push   %eax
  801282:	6a 09                	push   $0x9
  801284:	e8 b4 fe ff ff       	call   80113d <syscall>
  801289:	83 c4 18             	add    $0x18,%esp
}
  80128c:	c9                   	leave  
  80128d:	c3                   	ret    

0080128e <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80128e:	55                   	push   %ebp
  80128f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801291:	6a 00                	push   $0x0
  801293:	6a 00                	push   $0x0
  801295:	6a 00                	push   $0x0
  801297:	ff 75 0c             	pushl  0xc(%ebp)
  80129a:	ff 75 08             	pushl  0x8(%ebp)
  80129d:	6a 0a                	push   $0xa
  80129f:	e8 99 fe ff ff       	call   80113d <syscall>
  8012a4:	83 c4 18             	add    $0x18,%esp
}
  8012a7:	c9                   	leave  
  8012a8:	c3                   	ret    

008012a9 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8012a9:	55                   	push   %ebp
  8012aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8012ac:	6a 00                	push   $0x0
  8012ae:	6a 00                	push   $0x0
  8012b0:	6a 00                	push   $0x0
  8012b2:	6a 00                	push   $0x0
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 0b                	push   $0xb
  8012b8:	e8 80 fe ff ff       	call   80113d <syscall>
  8012bd:	83 c4 18             	add    $0x18,%esp
}
  8012c0:	c9                   	leave  
  8012c1:	c3                   	ret    

008012c2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	6a 00                	push   $0x0
  8012cd:	6a 00                	push   $0x0
  8012cf:	6a 0c                	push   $0xc
  8012d1:	e8 67 fe ff ff       	call   80113d <syscall>
  8012d6:	83 c4 18             	add    $0x18,%esp
}
  8012d9:	c9                   	leave  
  8012da:	c3                   	ret    

008012db <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8012db:	55                   	push   %ebp
  8012dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8012de:	6a 00                	push   $0x0
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 0d                	push   $0xd
  8012ea:	e8 4e fe ff ff       	call   80113d <syscall>
  8012ef:	83 c4 18             	add    $0x18,%esp
}
  8012f2:	c9                   	leave  
  8012f3:	c3                   	ret    

008012f4 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8012f4:	55                   	push   %ebp
  8012f5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8012f7:	6a 00                	push   $0x0
  8012f9:	6a 00                	push   $0x0
  8012fb:	6a 00                	push   $0x0
  8012fd:	ff 75 0c             	pushl  0xc(%ebp)
  801300:	ff 75 08             	pushl  0x8(%ebp)
  801303:	6a 11                	push   $0x11
  801305:	e8 33 fe ff ff       	call   80113d <syscall>
  80130a:	83 c4 18             	add    $0x18,%esp
	return;
  80130d:	90                   	nop
}
  80130e:	c9                   	leave  
  80130f:	c3                   	ret    

00801310 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801310:	55                   	push   %ebp
  801311:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	ff 75 0c             	pushl  0xc(%ebp)
  80131c:	ff 75 08             	pushl  0x8(%ebp)
  80131f:	6a 12                	push   $0x12
  801321:	e8 17 fe ff ff       	call   80113d <syscall>
  801326:	83 c4 18             	add    $0x18,%esp
	return ;
  801329:	90                   	nop
}
  80132a:	c9                   	leave  
  80132b:	c3                   	ret    

0080132c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80132c:	55                   	push   %ebp
  80132d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80132f:	6a 00                	push   $0x0
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 0e                	push   $0xe
  80133b:	e8 fd fd ff ff       	call   80113d <syscall>
  801340:	83 c4 18             	add    $0x18,%esp
}
  801343:	c9                   	leave  
  801344:	c3                   	ret    

00801345 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801345:	55                   	push   %ebp
  801346:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801348:	6a 00                	push   $0x0
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	ff 75 08             	pushl  0x8(%ebp)
  801353:	6a 0f                	push   $0xf
  801355:	e8 e3 fd ff ff       	call   80113d <syscall>
  80135a:	83 c4 18             	add    $0x18,%esp
}
  80135d:	c9                   	leave  
  80135e:	c3                   	ret    

0080135f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80135f:	55                   	push   %ebp
  801360:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801362:	6a 00                	push   $0x0
  801364:	6a 00                	push   $0x0
  801366:	6a 00                	push   $0x0
  801368:	6a 00                	push   $0x0
  80136a:	6a 00                	push   $0x0
  80136c:	6a 10                	push   $0x10
  80136e:	e8 ca fd ff ff       	call   80113d <syscall>
  801373:	83 c4 18             	add    $0x18,%esp
}
  801376:	90                   	nop
  801377:	c9                   	leave  
  801378:	c3                   	ret    

00801379 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801379:	55                   	push   %ebp
  80137a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80137c:	6a 00                	push   $0x0
  80137e:	6a 00                	push   $0x0
  801380:	6a 00                	push   $0x0
  801382:	6a 00                	push   $0x0
  801384:	6a 00                	push   $0x0
  801386:	6a 14                	push   $0x14
  801388:	e8 b0 fd ff ff       	call   80113d <syscall>
  80138d:	83 c4 18             	add    $0x18,%esp
}
  801390:	90                   	nop
  801391:	c9                   	leave  
  801392:	c3                   	ret    

00801393 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801393:	55                   	push   %ebp
  801394:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	6a 15                	push   $0x15
  8013a2:	e8 96 fd ff ff       	call   80113d <syscall>
  8013a7:	83 c4 18             	add    $0x18,%esp
}
  8013aa:	90                   	nop
  8013ab:	c9                   	leave  
  8013ac:	c3                   	ret    

008013ad <sys_cputc>:


void
sys_cputc(const char c)
{
  8013ad:	55                   	push   %ebp
  8013ae:	89 e5                	mov    %esp,%ebp
  8013b0:	83 ec 04             	sub    $0x4,%esp
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8013b9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	6a 00                	push   $0x0
  8013c5:	50                   	push   %eax
  8013c6:	6a 16                	push   $0x16
  8013c8:	e8 70 fd ff ff       	call   80113d <syscall>
  8013cd:	83 c4 18             	add    $0x18,%esp
}
  8013d0:	90                   	nop
  8013d1:	c9                   	leave  
  8013d2:	c3                   	ret    

008013d3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8013d3:	55                   	push   %ebp
  8013d4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8013d6:	6a 00                	push   $0x0
  8013d8:	6a 00                	push   $0x0
  8013da:	6a 00                	push   $0x0
  8013dc:	6a 00                	push   $0x0
  8013de:	6a 00                	push   $0x0
  8013e0:	6a 17                	push   $0x17
  8013e2:	e8 56 fd ff ff       	call   80113d <syscall>
  8013e7:	83 c4 18             	add    $0x18,%esp
}
  8013ea:	90                   	nop
  8013eb:	c9                   	leave  
  8013ec:	c3                   	ret    

008013ed <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8013ed:	55                   	push   %ebp
  8013ee:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	6a 00                	push   $0x0
  8013f5:	6a 00                	push   $0x0
  8013f7:	6a 00                	push   $0x0
  8013f9:	ff 75 0c             	pushl  0xc(%ebp)
  8013fc:	50                   	push   %eax
  8013fd:	6a 18                	push   $0x18
  8013ff:	e8 39 fd ff ff       	call   80113d <syscall>
  801404:	83 c4 18             	add    $0x18,%esp
}
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80140c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80140f:	8b 45 08             	mov    0x8(%ebp),%eax
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 00                	push   $0x0
  801418:	52                   	push   %edx
  801419:	50                   	push   %eax
  80141a:	6a 1b                	push   $0x1b
  80141c:	e8 1c fd ff ff       	call   80113d <syscall>
  801421:	83 c4 18             	add    $0x18,%esp
}
  801424:	c9                   	leave  
  801425:	c3                   	ret    

00801426 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801426:	55                   	push   %ebp
  801427:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801429:	8b 55 0c             	mov    0xc(%ebp),%edx
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	6a 00                	push   $0x0
  801431:	6a 00                	push   $0x0
  801433:	6a 00                	push   $0x0
  801435:	52                   	push   %edx
  801436:	50                   	push   %eax
  801437:	6a 19                	push   $0x19
  801439:	e8 ff fc ff ff       	call   80113d <syscall>
  80143e:	83 c4 18             	add    $0x18,%esp
}
  801441:	90                   	nop
  801442:	c9                   	leave  
  801443:	c3                   	ret    

00801444 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801444:	55                   	push   %ebp
  801445:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801447:	8b 55 0c             	mov    0xc(%ebp),%edx
  80144a:	8b 45 08             	mov    0x8(%ebp),%eax
  80144d:	6a 00                	push   $0x0
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	52                   	push   %edx
  801454:	50                   	push   %eax
  801455:	6a 1a                	push   $0x1a
  801457:	e8 e1 fc ff ff       	call   80113d <syscall>
  80145c:	83 c4 18             	add    $0x18,%esp
}
  80145f:	90                   	nop
  801460:	c9                   	leave  
  801461:	c3                   	ret    

00801462 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801462:	55                   	push   %ebp
  801463:	89 e5                	mov    %esp,%ebp
  801465:	83 ec 04             	sub    $0x4,%esp
  801468:	8b 45 10             	mov    0x10(%ebp),%eax
  80146b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80146e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801471:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	6a 00                	push   $0x0
  80147a:	51                   	push   %ecx
  80147b:	52                   	push   %edx
  80147c:	ff 75 0c             	pushl  0xc(%ebp)
  80147f:	50                   	push   %eax
  801480:	6a 1c                	push   $0x1c
  801482:	e8 b6 fc ff ff       	call   80113d <syscall>
  801487:	83 c4 18             	add    $0x18,%esp
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80148f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	6a 00                	push   $0x0
  801497:	6a 00                	push   $0x0
  801499:	6a 00                	push   $0x0
  80149b:	52                   	push   %edx
  80149c:	50                   	push   %eax
  80149d:	6a 1d                	push   $0x1d
  80149f:	e8 99 fc ff ff       	call   80113d <syscall>
  8014a4:	83 c4 18             	add    $0x18,%esp
}
  8014a7:	c9                   	leave  
  8014a8:	c3                   	ret    

008014a9 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8014a9:	55                   	push   %ebp
  8014aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8014ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b5:	6a 00                	push   $0x0
  8014b7:	6a 00                	push   $0x0
  8014b9:	51                   	push   %ecx
  8014ba:	52                   	push   %edx
  8014bb:	50                   	push   %eax
  8014bc:	6a 1e                	push   $0x1e
  8014be:	e8 7a fc ff ff       	call   80113d <syscall>
  8014c3:	83 c4 18             	add    $0x18,%esp
}
  8014c6:	c9                   	leave  
  8014c7:	c3                   	ret    

008014c8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8014c8:	55                   	push   %ebp
  8014c9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8014cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d1:	6a 00                	push   $0x0
  8014d3:	6a 00                	push   $0x0
  8014d5:	6a 00                	push   $0x0
  8014d7:	52                   	push   %edx
  8014d8:	50                   	push   %eax
  8014d9:	6a 1f                	push   $0x1f
  8014db:	e8 5d fc ff ff       	call   80113d <syscall>
  8014e0:	83 c4 18             	add    $0x18,%esp
}
  8014e3:	c9                   	leave  
  8014e4:	c3                   	ret    

008014e5 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8014e5:	55                   	push   %ebp
  8014e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	6a 00                	push   $0x0
  8014f0:	6a 00                	push   $0x0
  8014f2:	6a 20                	push   $0x20
  8014f4:	e8 44 fc ff ff       	call   80113d <syscall>
  8014f9:	83 c4 18             	add    $0x18,%esp
}
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801501:	8b 45 08             	mov    0x8(%ebp),%eax
  801504:	6a 00                	push   $0x0
  801506:	ff 75 14             	pushl  0x14(%ebp)
  801509:	ff 75 10             	pushl  0x10(%ebp)
  80150c:	ff 75 0c             	pushl  0xc(%ebp)
  80150f:	50                   	push   %eax
  801510:	6a 21                	push   $0x21
  801512:	e8 26 fc ff ff       	call   80113d <syscall>
  801517:	83 c4 18             	add    $0x18,%esp
}
  80151a:	c9                   	leave  
  80151b:	c3                   	ret    

0080151c <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80151c:	55                   	push   %ebp
  80151d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	50                   	push   %eax
  80152b:	6a 22                	push   $0x22
  80152d:	e8 0b fc ff ff       	call   80113d <syscall>
  801532:	83 c4 18             	add    $0x18,%esp
}
  801535:	90                   	nop
  801536:	c9                   	leave  
  801537:	c3                   	ret    

00801538 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801538:	55                   	push   %ebp
  801539:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80153b:	8b 45 08             	mov    0x8(%ebp),%eax
  80153e:	6a 00                	push   $0x0
  801540:	6a 00                	push   $0x0
  801542:	6a 00                	push   $0x0
  801544:	6a 00                	push   $0x0
  801546:	50                   	push   %eax
  801547:	6a 23                	push   $0x23
  801549:	e8 ef fb ff ff       	call   80113d <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	90                   	nop
  801552:	c9                   	leave  
  801553:	c3                   	ret    

00801554 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801554:	55                   	push   %ebp
  801555:	89 e5                	mov    %esp,%ebp
  801557:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80155a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80155d:	8d 50 04             	lea    0x4(%eax),%edx
  801560:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801563:	6a 00                	push   $0x0
  801565:	6a 00                	push   $0x0
  801567:	6a 00                	push   $0x0
  801569:	52                   	push   %edx
  80156a:	50                   	push   %eax
  80156b:	6a 24                	push   $0x24
  80156d:	e8 cb fb ff ff       	call   80113d <syscall>
  801572:	83 c4 18             	add    $0x18,%esp
	return result;
  801575:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801578:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80157e:	89 01                	mov    %eax,(%ecx)
  801580:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801583:	8b 45 08             	mov    0x8(%ebp),%eax
  801586:	c9                   	leave  
  801587:	c2 04 00             	ret    $0x4

0080158a <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80158a:	55                   	push   %ebp
  80158b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80158d:	6a 00                	push   $0x0
  80158f:	6a 00                	push   $0x0
  801591:	ff 75 10             	pushl  0x10(%ebp)
  801594:	ff 75 0c             	pushl  0xc(%ebp)
  801597:	ff 75 08             	pushl  0x8(%ebp)
  80159a:	6a 13                	push   $0x13
  80159c:	e8 9c fb ff ff       	call   80113d <syscall>
  8015a1:	83 c4 18             	add    $0x18,%esp
	return ;
  8015a4:	90                   	nop
}
  8015a5:	c9                   	leave  
  8015a6:	c3                   	ret    

008015a7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8015aa:	6a 00                	push   $0x0
  8015ac:	6a 00                	push   $0x0
  8015ae:	6a 00                	push   $0x0
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 25                	push   $0x25
  8015b6:	e8 82 fb ff ff       	call   80113d <syscall>
  8015bb:	83 c4 18             	add    $0x18,%esp
}
  8015be:	c9                   	leave  
  8015bf:	c3                   	ret    

008015c0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
  8015c3:	83 ec 04             	sub    $0x4,%esp
  8015c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8015cc:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	6a 00                	push   $0x0
  8015d6:	6a 00                	push   $0x0
  8015d8:	50                   	push   %eax
  8015d9:	6a 26                	push   $0x26
  8015db:	e8 5d fb ff ff       	call   80113d <syscall>
  8015e0:	83 c4 18             	add    $0x18,%esp
	return ;
  8015e3:	90                   	nop
}
  8015e4:	c9                   	leave  
  8015e5:	c3                   	ret    

008015e6 <rsttst>:
void rsttst()
{
  8015e6:	55                   	push   %ebp
  8015e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 00                	push   $0x0
  8015ed:	6a 00                	push   $0x0
  8015ef:	6a 00                	push   $0x0
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 28                	push   $0x28
  8015f5:	e8 43 fb ff ff       	call   80113d <syscall>
  8015fa:	83 c4 18             	add    $0x18,%esp
	return ;
  8015fd:	90                   	nop
}
  8015fe:	c9                   	leave  
  8015ff:	c3                   	ret    

00801600 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801600:	55                   	push   %ebp
  801601:	89 e5                	mov    %esp,%ebp
  801603:	83 ec 04             	sub    $0x4,%esp
  801606:	8b 45 14             	mov    0x14(%ebp),%eax
  801609:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80160c:	8b 55 18             	mov    0x18(%ebp),%edx
  80160f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801613:	52                   	push   %edx
  801614:	50                   	push   %eax
  801615:	ff 75 10             	pushl  0x10(%ebp)
  801618:	ff 75 0c             	pushl  0xc(%ebp)
  80161b:	ff 75 08             	pushl  0x8(%ebp)
  80161e:	6a 27                	push   $0x27
  801620:	e8 18 fb ff ff       	call   80113d <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
	return ;
  801628:	90                   	nop
}
  801629:	c9                   	leave  
  80162a:	c3                   	ret    

0080162b <chktst>:
void chktst(uint32 n)
{
  80162b:	55                   	push   %ebp
  80162c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80162e:	6a 00                	push   $0x0
  801630:	6a 00                	push   $0x0
  801632:	6a 00                	push   $0x0
  801634:	6a 00                	push   $0x0
  801636:	ff 75 08             	pushl  0x8(%ebp)
  801639:	6a 29                	push   $0x29
  80163b:	e8 fd fa ff ff       	call   80113d <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
	return ;
  801643:	90                   	nop
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <inctst>:

void inctst()
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	6a 00                	push   $0x0
  801651:	6a 00                	push   $0x0
  801653:	6a 2a                	push   $0x2a
  801655:	e8 e3 fa ff ff       	call   80113d <syscall>
  80165a:	83 c4 18             	add    $0x18,%esp
	return ;
  80165d:	90                   	nop
}
  80165e:	c9                   	leave  
  80165f:	c3                   	ret    

00801660 <gettst>:
uint32 gettst()
{
  801660:	55                   	push   %ebp
  801661:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 2b                	push   $0x2b
  80166f:	e8 c9 fa ff ff       	call   80113d <syscall>
  801674:	83 c4 18             	add    $0x18,%esp
}
  801677:	c9                   	leave  
  801678:	c3                   	ret    

00801679 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801679:	55                   	push   %ebp
  80167a:	89 e5                	mov    %esp,%ebp
  80167c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80167f:	6a 00                	push   $0x0
  801681:	6a 00                	push   $0x0
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	6a 2c                	push   $0x2c
  80168b:	e8 ad fa ff ff       	call   80113d <syscall>
  801690:	83 c4 18             	add    $0x18,%esp
  801693:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801696:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  80169a:	75 07                	jne    8016a3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80169c:	b8 01 00 00 00       	mov    $0x1,%eax
  8016a1:	eb 05                	jmp    8016a8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8016a3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
  8016ad:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 2c                	push   $0x2c
  8016bc:	e8 7c fa ff ff       	call   80113d <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
  8016c4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8016c7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8016cb:	75 07                	jne    8016d4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8016cd:	b8 01 00 00 00       	mov    $0x1,%eax
  8016d2:	eb 05                	jmp    8016d9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8016d4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8016d9:	c9                   	leave  
  8016da:	c3                   	ret    

008016db <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8016db:	55                   	push   %ebp
  8016dc:	89 e5                	mov    %esp,%ebp
  8016de:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016e1:	6a 00                	push   $0x0
  8016e3:	6a 00                	push   $0x0
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 2c                	push   $0x2c
  8016ed:	e8 4b fa ff ff       	call   80113d <syscall>
  8016f2:	83 c4 18             	add    $0x18,%esp
  8016f5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8016f8:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8016fc:	75 07                	jne    801705 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8016fe:	b8 01 00 00 00       	mov    $0x1,%eax
  801703:	eb 05                	jmp    80170a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801705:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80170a:	c9                   	leave  
  80170b:	c3                   	ret    

0080170c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80170c:	55                   	push   %ebp
  80170d:	89 e5                	mov    %esp,%ebp
  80170f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 2c                	push   $0x2c
  80171e:	e8 1a fa ff ff       	call   80113d <syscall>
  801723:	83 c4 18             	add    $0x18,%esp
  801726:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801729:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80172d:	75 07                	jne    801736 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80172f:	b8 01 00 00 00       	mov    $0x1,%eax
  801734:	eb 05                	jmp    80173b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801736:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80173b:	c9                   	leave  
  80173c:	c3                   	ret    

0080173d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80173d:	55                   	push   %ebp
  80173e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801740:	6a 00                	push   $0x0
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	ff 75 08             	pushl  0x8(%ebp)
  80174b:	6a 2d                	push   $0x2d
  80174d:	e8 eb f9 ff ff       	call   80113d <syscall>
  801752:	83 c4 18             	add    $0x18,%esp
	return ;
  801755:	90                   	nop
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
  80175b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80175c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80175f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801762:	8b 55 0c             	mov    0xc(%ebp),%edx
  801765:	8b 45 08             	mov    0x8(%ebp),%eax
  801768:	6a 00                	push   $0x0
  80176a:	53                   	push   %ebx
  80176b:	51                   	push   %ecx
  80176c:	52                   	push   %edx
  80176d:	50                   	push   %eax
  80176e:	6a 2e                	push   $0x2e
  801770:	e8 c8 f9 ff ff       	call   80113d <syscall>
  801775:	83 c4 18             	add    $0x18,%esp
}
  801778:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80177b:	c9                   	leave  
  80177c:	c3                   	ret    

0080177d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801780:	8b 55 0c             	mov    0xc(%ebp),%edx
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	6a 00                	push   $0x0
  801788:	6a 00                	push   $0x0
  80178a:	6a 00                	push   $0x0
  80178c:	52                   	push   %edx
  80178d:	50                   	push   %eax
  80178e:	6a 2f                	push   $0x2f
  801790:	e8 a8 f9 ff ff       	call   80113d <syscall>
  801795:	83 c4 18             	add    $0x18,%esp
}
  801798:	c9                   	leave  
  801799:	c3                   	ret    

0080179a <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  80179a:	55                   	push   %ebp
  80179b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80179d:	6a 00                	push   $0x0
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	ff 75 0c             	pushl  0xc(%ebp)
  8017a6:	ff 75 08             	pushl  0x8(%ebp)
  8017a9:	6a 30                	push   $0x30
  8017ab:	e8 8d f9 ff ff       	call   80113d <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
	return ;
  8017b3:	90                   	nop
}
  8017b4:	c9                   	leave  
  8017b5:	c3                   	ret    
  8017b6:	66 90                	xchg   %ax,%ax

008017b8 <__udivdi3>:
  8017b8:	55                   	push   %ebp
  8017b9:	57                   	push   %edi
  8017ba:	56                   	push   %esi
  8017bb:	53                   	push   %ebx
  8017bc:	83 ec 1c             	sub    $0x1c,%esp
  8017bf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8017c3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8017c7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8017cb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8017cf:	89 ca                	mov    %ecx,%edx
  8017d1:	89 f8                	mov    %edi,%eax
  8017d3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8017d7:	85 f6                	test   %esi,%esi
  8017d9:	75 2d                	jne    801808 <__udivdi3+0x50>
  8017db:	39 cf                	cmp    %ecx,%edi
  8017dd:	77 65                	ja     801844 <__udivdi3+0x8c>
  8017df:	89 fd                	mov    %edi,%ebp
  8017e1:	85 ff                	test   %edi,%edi
  8017e3:	75 0b                	jne    8017f0 <__udivdi3+0x38>
  8017e5:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ea:	31 d2                	xor    %edx,%edx
  8017ec:	f7 f7                	div    %edi
  8017ee:	89 c5                	mov    %eax,%ebp
  8017f0:	31 d2                	xor    %edx,%edx
  8017f2:	89 c8                	mov    %ecx,%eax
  8017f4:	f7 f5                	div    %ebp
  8017f6:	89 c1                	mov    %eax,%ecx
  8017f8:	89 d8                	mov    %ebx,%eax
  8017fa:	f7 f5                	div    %ebp
  8017fc:	89 cf                	mov    %ecx,%edi
  8017fe:	89 fa                	mov    %edi,%edx
  801800:	83 c4 1c             	add    $0x1c,%esp
  801803:	5b                   	pop    %ebx
  801804:	5e                   	pop    %esi
  801805:	5f                   	pop    %edi
  801806:	5d                   	pop    %ebp
  801807:	c3                   	ret    
  801808:	39 ce                	cmp    %ecx,%esi
  80180a:	77 28                	ja     801834 <__udivdi3+0x7c>
  80180c:	0f bd fe             	bsr    %esi,%edi
  80180f:	83 f7 1f             	xor    $0x1f,%edi
  801812:	75 40                	jne    801854 <__udivdi3+0x9c>
  801814:	39 ce                	cmp    %ecx,%esi
  801816:	72 0a                	jb     801822 <__udivdi3+0x6a>
  801818:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80181c:	0f 87 9e 00 00 00    	ja     8018c0 <__udivdi3+0x108>
  801822:	b8 01 00 00 00       	mov    $0x1,%eax
  801827:	89 fa                	mov    %edi,%edx
  801829:	83 c4 1c             	add    $0x1c,%esp
  80182c:	5b                   	pop    %ebx
  80182d:	5e                   	pop    %esi
  80182e:	5f                   	pop    %edi
  80182f:	5d                   	pop    %ebp
  801830:	c3                   	ret    
  801831:	8d 76 00             	lea    0x0(%esi),%esi
  801834:	31 ff                	xor    %edi,%edi
  801836:	31 c0                	xor    %eax,%eax
  801838:	89 fa                	mov    %edi,%edx
  80183a:	83 c4 1c             	add    $0x1c,%esp
  80183d:	5b                   	pop    %ebx
  80183e:	5e                   	pop    %esi
  80183f:	5f                   	pop    %edi
  801840:	5d                   	pop    %ebp
  801841:	c3                   	ret    
  801842:	66 90                	xchg   %ax,%ax
  801844:	89 d8                	mov    %ebx,%eax
  801846:	f7 f7                	div    %edi
  801848:	31 ff                	xor    %edi,%edi
  80184a:	89 fa                	mov    %edi,%edx
  80184c:	83 c4 1c             	add    $0x1c,%esp
  80184f:	5b                   	pop    %ebx
  801850:	5e                   	pop    %esi
  801851:	5f                   	pop    %edi
  801852:	5d                   	pop    %ebp
  801853:	c3                   	ret    
  801854:	bd 20 00 00 00       	mov    $0x20,%ebp
  801859:	89 eb                	mov    %ebp,%ebx
  80185b:	29 fb                	sub    %edi,%ebx
  80185d:	89 f9                	mov    %edi,%ecx
  80185f:	d3 e6                	shl    %cl,%esi
  801861:	89 c5                	mov    %eax,%ebp
  801863:	88 d9                	mov    %bl,%cl
  801865:	d3 ed                	shr    %cl,%ebp
  801867:	89 e9                	mov    %ebp,%ecx
  801869:	09 f1                	or     %esi,%ecx
  80186b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80186f:	89 f9                	mov    %edi,%ecx
  801871:	d3 e0                	shl    %cl,%eax
  801873:	89 c5                	mov    %eax,%ebp
  801875:	89 d6                	mov    %edx,%esi
  801877:	88 d9                	mov    %bl,%cl
  801879:	d3 ee                	shr    %cl,%esi
  80187b:	89 f9                	mov    %edi,%ecx
  80187d:	d3 e2                	shl    %cl,%edx
  80187f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801883:	88 d9                	mov    %bl,%cl
  801885:	d3 e8                	shr    %cl,%eax
  801887:	09 c2                	or     %eax,%edx
  801889:	89 d0                	mov    %edx,%eax
  80188b:	89 f2                	mov    %esi,%edx
  80188d:	f7 74 24 0c          	divl   0xc(%esp)
  801891:	89 d6                	mov    %edx,%esi
  801893:	89 c3                	mov    %eax,%ebx
  801895:	f7 e5                	mul    %ebp
  801897:	39 d6                	cmp    %edx,%esi
  801899:	72 19                	jb     8018b4 <__udivdi3+0xfc>
  80189b:	74 0b                	je     8018a8 <__udivdi3+0xf0>
  80189d:	89 d8                	mov    %ebx,%eax
  80189f:	31 ff                	xor    %edi,%edi
  8018a1:	e9 58 ff ff ff       	jmp    8017fe <__udivdi3+0x46>
  8018a6:	66 90                	xchg   %ax,%ax
  8018a8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8018ac:	89 f9                	mov    %edi,%ecx
  8018ae:	d3 e2                	shl    %cl,%edx
  8018b0:	39 c2                	cmp    %eax,%edx
  8018b2:	73 e9                	jae    80189d <__udivdi3+0xe5>
  8018b4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8018b7:	31 ff                	xor    %edi,%edi
  8018b9:	e9 40 ff ff ff       	jmp    8017fe <__udivdi3+0x46>
  8018be:	66 90                	xchg   %ax,%ax
  8018c0:	31 c0                	xor    %eax,%eax
  8018c2:	e9 37 ff ff ff       	jmp    8017fe <__udivdi3+0x46>
  8018c7:	90                   	nop

008018c8 <__umoddi3>:
  8018c8:	55                   	push   %ebp
  8018c9:	57                   	push   %edi
  8018ca:	56                   	push   %esi
  8018cb:	53                   	push   %ebx
  8018cc:	83 ec 1c             	sub    $0x1c,%esp
  8018cf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8018d3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8018d7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8018db:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8018df:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8018e3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8018e7:	89 f3                	mov    %esi,%ebx
  8018e9:	89 fa                	mov    %edi,%edx
  8018eb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8018ef:	89 34 24             	mov    %esi,(%esp)
  8018f2:	85 c0                	test   %eax,%eax
  8018f4:	75 1a                	jne    801910 <__umoddi3+0x48>
  8018f6:	39 f7                	cmp    %esi,%edi
  8018f8:	0f 86 a2 00 00 00    	jbe    8019a0 <__umoddi3+0xd8>
  8018fe:	89 c8                	mov    %ecx,%eax
  801900:	89 f2                	mov    %esi,%edx
  801902:	f7 f7                	div    %edi
  801904:	89 d0                	mov    %edx,%eax
  801906:	31 d2                	xor    %edx,%edx
  801908:	83 c4 1c             	add    $0x1c,%esp
  80190b:	5b                   	pop    %ebx
  80190c:	5e                   	pop    %esi
  80190d:	5f                   	pop    %edi
  80190e:	5d                   	pop    %ebp
  80190f:	c3                   	ret    
  801910:	39 f0                	cmp    %esi,%eax
  801912:	0f 87 ac 00 00 00    	ja     8019c4 <__umoddi3+0xfc>
  801918:	0f bd e8             	bsr    %eax,%ebp
  80191b:	83 f5 1f             	xor    $0x1f,%ebp
  80191e:	0f 84 ac 00 00 00    	je     8019d0 <__umoddi3+0x108>
  801924:	bf 20 00 00 00       	mov    $0x20,%edi
  801929:	29 ef                	sub    %ebp,%edi
  80192b:	89 fe                	mov    %edi,%esi
  80192d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801931:	89 e9                	mov    %ebp,%ecx
  801933:	d3 e0                	shl    %cl,%eax
  801935:	89 d7                	mov    %edx,%edi
  801937:	89 f1                	mov    %esi,%ecx
  801939:	d3 ef                	shr    %cl,%edi
  80193b:	09 c7                	or     %eax,%edi
  80193d:	89 e9                	mov    %ebp,%ecx
  80193f:	d3 e2                	shl    %cl,%edx
  801941:	89 14 24             	mov    %edx,(%esp)
  801944:	89 d8                	mov    %ebx,%eax
  801946:	d3 e0                	shl    %cl,%eax
  801948:	89 c2                	mov    %eax,%edx
  80194a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80194e:	d3 e0                	shl    %cl,%eax
  801950:	89 44 24 04          	mov    %eax,0x4(%esp)
  801954:	8b 44 24 08          	mov    0x8(%esp),%eax
  801958:	89 f1                	mov    %esi,%ecx
  80195a:	d3 e8                	shr    %cl,%eax
  80195c:	09 d0                	or     %edx,%eax
  80195e:	d3 eb                	shr    %cl,%ebx
  801960:	89 da                	mov    %ebx,%edx
  801962:	f7 f7                	div    %edi
  801964:	89 d3                	mov    %edx,%ebx
  801966:	f7 24 24             	mull   (%esp)
  801969:	89 c6                	mov    %eax,%esi
  80196b:	89 d1                	mov    %edx,%ecx
  80196d:	39 d3                	cmp    %edx,%ebx
  80196f:	0f 82 87 00 00 00    	jb     8019fc <__umoddi3+0x134>
  801975:	0f 84 91 00 00 00    	je     801a0c <__umoddi3+0x144>
  80197b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80197f:	29 f2                	sub    %esi,%edx
  801981:	19 cb                	sbb    %ecx,%ebx
  801983:	89 d8                	mov    %ebx,%eax
  801985:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801989:	d3 e0                	shl    %cl,%eax
  80198b:	89 e9                	mov    %ebp,%ecx
  80198d:	d3 ea                	shr    %cl,%edx
  80198f:	09 d0                	or     %edx,%eax
  801991:	89 e9                	mov    %ebp,%ecx
  801993:	d3 eb                	shr    %cl,%ebx
  801995:	89 da                	mov    %ebx,%edx
  801997:	83 c4 1c             	add    $0x1c,%esp
  80199a:	5b                   	pop    %ebx
  80199b:	5e                   	pop    %esi
  80199c:	5f                   	pop    %edi
  80199d:	5d                   	pop    %ebp
  80199e:	c3                   	ret    
  80199f:	90                   	nop
  8019a0:	89 fd                	mov    %edi,%ebp
  8019a2:	85 ff                	test   %edi,%edi
  8019a4:	75 0b                	jne    8019b1 <__umoddi3+0xe9>
  8019a6:	b8 01 00 00 00       	mov    $0x1,%eax
  8019ab:	31 d2                	xor    %edx,%edx
  8019ad:	f7 f7                	div    %edi
  8019af:	89 c5                	mov    %eax,%ebp
  8019b1:	89 f0                	mov    %esi,%eax
  8019b3:	31 d2                	xor    %edx,%edx
  8019b5:	f7 f5                	div    %ebp
  8019b7:	89 c8                	mov    %ecx,%eax
  8019b9:	f7 f5                	div    %ebp
  8019bb:	89 d0                	mov    %edx,%eax
  8019bd:	e9 44 ff ff ff       	jmp    801906 <__umoddi3+0x3e>
  8019c2:	66 90                	xchg   %ax,%ax
  8019c4:	89 c8                	mov    %ecx,%eax
  8019c6:	89 f2                	mov    %esi,%edx
  8019c8:	83 c4 1c             	add    $0x1c,%esp
  8019cb:	5b                   	pop    %ebx
  8019cc:	5e                   	pop    %esi
  8019cd:	5f                   	pop    %edi
  8019ce:	5d                   	pop    %ebp
  8019cf:	c3                   	ret    
  8019d0:	3b 04 24             	cmp    (%esp),%eax
  8019d3:	72 06                	jb     8019db <__umoddi3+0x113>
  8019d5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8019d9:	77 0f                	ja     8019ea <__umoddi3+0x122>
  8019db:	89 f2                	mov    %esi,%edx
  8019dd:	29 f9                	sub    %edi,%ecx
  8019df:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8019e3:	89 14 24             	mov    %edx,(%esp)
  8019e6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8019ea:	8b 44 24 04          	mov    0x4(%esp),%eax
  8019ee:	8b 14 24             	mov    (%esp),%edx
  8019f1:	83 c4 1c             	add    $0x1c,%esp
  8019f4:	5b                   	pop    %ebx
  8019f5:	5e                   	pop    %esi
  8019f6:	5f                   	pop    %edi
  8019f7:	5d                   	pop    %ebp
  8019f8:	c3                   	ret    
  8019f9:	8d 76 00             	lea    0x0(%esi),%esi
  8019fc:	2b 04 24             	sub    (%esp),%eax
  8019ff:	19 fa                	sbb    %edi,%edx
  801a01:	89 d1                	mov    %edx,%ecx
  801a03:	89 c6                	mov    %eax,%esi
  801a05:	e9 71 ff ff ff       	jmp    80197b <__umoddi3+0xb3>
  801a0a:	66 90                	xchg   %ax,%ax
  801a0c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801a10:	72 ea                	jb     8019fc <__umoddi3+0x134>
  801a12:	89 d9                	mov    %ebx,%ecx
  801a14:	e9 62 ff ff ff       	jmp    80197b <__umoddi3+0xb3>
