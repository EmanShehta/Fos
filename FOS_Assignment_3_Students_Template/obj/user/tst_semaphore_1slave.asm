
obj/user/tst_semaphore_1slave:     file format elf32-i386


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
  800031:	e8 cd 00 00 00       	call   800103 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Slave program: enter critical section, print it's ID, exit and signal the master program
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	int32 parentenvID = sys_getparentenvid();
  80003e:	e8 d4 12 00 00       	call   801317 <sys_getparentenvid>
  800043:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int id = sys_getenvindex();
  800046:	e8 b3 12 00 00       	call   8012fe <sys_getenvindex>
  80004b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	cprintf("%d: before the critical section\n", id);
  80004e:	83 ec 08             	sub    $0x8,%esp
  800051:	ff 75 f0             	pushl  -0x10(%ebp)
  800054:	68 00 1c 80 00       	push   $0x801c00
  800059:	e8 75 04 00 00       	call   8004d3 <cprintf>
  80005e:	83 c4 10             	add    $0x10,%esp

	sys_waitSemaphore(parentenvID, "cs1") ;
  800061:	83 ec 08             	sub    $0x8,%esp
  800064:	68 21 1c 80 00       	push   $0x801c21
  800069:	ff 75 f4             	pushl  -0xc(%ebp)
  80006c:	e8 d5 14 00 00       	call   801546 <sys_waitSemaphore>
  800071:	83 c4 10             	add    $0x10,%esp
		cprintf("%d: inside the critical section\n", id) ;
  800074:	83 ec 08             	sub    $0x8,%esp
  800077:	ff 75 f0             	pushl  -0x10(%ebp)
  80007a:	68 28 1c 80 00       	push   $0x801c28
  80007f:	e8 4f 04 00 00       	call   8004d3 <cprintf>
  800084:	83 c4 10             	add    $0x10,%esp
		//cprintf("my ID is %d\n", id);
		int sem1val = sys_getSemaphoreValue(parentenvID, "cs1");
  800087:	83 ec 08             	sub    $0x8,%esp
  80008a:	68 21 1c 80 00       	push   $0x801c21
  80008f:	ff 75 f4             	pushl  -0xc(%ebp)
  800092:	e8 92 14 00 00       	call   801529 <sys_getSemaphoreValue>
  800097:	83 c4 10             	add    $0x10,%esp
  80009a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (sem1val > 0)
  80009d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8000a1:	7e 14                	jle    8000b7 <_main+0x7f>
			panic("Error: more than 1 process inside the CS... please review your semaphore code again...");
  8000a3:	83 ec 04             	sub    $0x4,%esp
  8000a6:	68 4c 1c 80 00       	push   $0x801c4c
  8000ab:	6a 11                	push   $0x11
  8000ad:	68 a3 1c 80 00       	push   $0x801ca3
  8000b2:	e8 68 01 00 00       	call   80021f <_panic>
		env_sleep(1000) ;
  8000b7:	83 ec 0c             	sub    $0xc,%esp
  8000ba:	68 e8 03 00 00       	push   $0x3e8
  8000bf:	e8 12 18 00 00       	call   8018d6 <env_sleep>
  8000c4:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "cs1") ;
  8000c7:	83 ec 08             	sub    $0x8,%esp
  8000ca:	68 21 1c 80 00       	push   $0x801c21
  8000cf:	ff 75 f4             	pushl  -0xc(%ebp)
  8000d2:	e8 8d 14 00 00       	call   801564 <sys_signalSemaphore>
  8000d7:	83 c4 10             	add    $0x10,%esp

	cprintf("%d: after the critical section\n", id);
  8000da:	83 ec 08             	sub    $0x8,%esp
  8000dd:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e0:	68 c0 1c 80 00       	push   $0x801cc0
  8000e5:	e8 e9 03 00 00       	call   8004d3 <cprintf>
  8000ea:	83 c4 10             	add    $0x10,%esp
	sys_signalSemaphore(parentenvID, "depend1") ;
  8000ed:	83 ec 08             	sub    $0x8,%esp
  8000f0:	68 e0 1c 80 00       	push   $0x801ce0
  8000f5:	ff 75 f4             	pushl  -0xc(%ebp)
  8000f8:	e8 67 14 00 00       	call   801564 <sys_signalSemaphore>
  8000fd:	83 c4 10             	add    $0x10,%esp
	return;
  800100:	90                   	nop
}
  800101:	c9                   	leave  
  800102:	c3                   	ret    

00800103 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800103:	55                   	push   %ebp
  800104:	89 e5                	mov    %esp,%ebp
  800106:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800109:	e8 f0 11 00 00       	call   8012fe <sys_getenvindex>
  80010e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800111:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800114:	89 d0                	mov    %edx,%eax
  800116:	01 c0                	add    %eax,%eax
  800118:	01 d0                	add    %edx,%eax
  80011a:	c1 e0 04             	shl    $0x4,%eax
  80011d:	29 d0                	sub    %edx,%eax
  80011f:	c1 e0 03             	shl    $0x3,%eax
  800122:	01 d0                	add    %edx,%eax
  800124:	c1 e0 02             	shl    $0x2,%eax
  800127:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80012c:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800131:	a1 20 30 80 00       	mov    0x803020,%eax
  800136:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80013c:	84 c0                	test   %al,%al
  80013e:	74 0f                	je     80014f <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800140:	a1 20 30 80 00       	mov    0x803020,%eax
  800145:	05 5c 05 00 00       	add    $0x55c,%eax
  80014a:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80014f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800153:	7e 0a                	jle    80015f <libmain+0x5c>
		binaryname = argv[0];
  800155:	8b 45 0c             	mov    0xc(%ebp),%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80015f:	83 ec 08             	sub    $0x8,%esp
  800162:	ff 75 0c             	pushl  0xc(%ebp)
  800165:	ff 75 08             	pushl  0x8(%ebp)
  800168:	e8 cb fe ff ff       	call   800038 <_main>
  80016d:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800170:	e8 24 13 00 00       	call   801499 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800175:	83 ec 0c             	sub    $0xc,%esp
  800178:	68 00 1d 80 00       	push   $0x801d00
  80017d:	e8 51 03 00 00       	call   8004d3 <cprintf>
  800182:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800190:	a1 20 30 80 00       	mov    0x803020,%eax
  800195:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80019b:	83 ec 04             	sub    $0x4,%esp
  80019e:	52                   	push   %edx
  80019f:	50                   	push   %eax
  8001a0:	68 28 1d 80 00       	push   $0x801d28
  8001a5:	e8 29 03 00 00       	call   8004d3 <cprintf>
  8001aa:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8001ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b2:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8001c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c8:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8001ce:	51                   	push   %ecx
  8001cf:	52                   	push   %edx
  8001d0:	50                   	push   %eax
  8001d1:	68 50 1d 80 00       	push   $0x801d50
  8001d6:	e8 f8 02 00 00       	call   8004d3 <cprintf>
  8001db:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8001de:	83 ec 0c             	sub    $0xc,%esp
  8001e1:	68 00 1d 80 00       	push   $0x801d00
  8001e6:	e8 e8 02 00 00       	call   8004d3 <cprintf>
  8001eb:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8001ee:	e8 c0 12 00 00       	call   8014b3 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8001f3:	e8 19 00 00 00       	call   800211 <exit>
}
  8001f8:	90                   	nop
  8001f9:	c9                   	leave  
  8001fa:	c3                   	ret    

008001fb <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8001fb:	55                   	push   %ebp
  8001fc:	89 e5                	mov    %esp,%ebp
  8001fe:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800201:	83 ec 0c             	sub    $0xc,%esp
  800204:	6a 00                	push   $0x0
  800206:	e8 bf 10 00 00       	call   8012ca <sys_env_destroy>
  80020b:	83 c4 10             	add    $0x10,%esp
}
  80020e:	90                   	nop
  80020f:	c9                   	leave  
  800210:	c3                   	ret    

00800211 <exit>:

void
exit(void)
{
  800211:	55                   	push   %ebp
  800212:	89 e5                	mov    %esp,%ebp
  800214:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800217:	e8 14 11 00 00       	call   801330 <sys_env_exit>
}
  80021c:	90                   	nop
  80021d:	c9                   	leave  
  80021e:	c3                   	ret    

0080021f <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80021f:	55                   	push   %ebp
  800220:	89 e5                	mov    %esp,%ebp
  800222:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800225:	8d 45 10             	lea    0x10(%ebp),%eax
  800228:	83 c0 04             	add    $0x4,%eax
  80022b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80022e:	a1 18 31 80 00       	mov    0x803118,%eax
  800233:	85 c0                	test   %eax,%eax
  800235:	74 16                	je     80024d <_panic+0x2e>
		cprintf("%s: ", argv0);
  800237:	a1 18 31 80 00       	mov    0x803118,%eax
  80023c:	83 ec 08             	sub    $0x8,%esp
  80023f:	50                   	push   %eax
  800240:	68 a8 1d 80 00       	push   $0x801da8
  800245:	e8 89 02 00 00       	call   8004d3 <cprintf>
  80024a:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80024d:	a1 00 30 80 00       	mov    0x803000,%eax
  800252:	ff 75 0c             	pushl  0xc(%ebp)
  800255:	ff 75 08             	pushl  0x8(%ebp)
  800258:	50                   	push   %eax
  800259:	68 ad 1d 80 00       	push   $0x801dad
  80025e:	e8 70 02 00 00       	call   8004d3 <cprintf>
  800263:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800266:	8b 45 10             	mov    0x10(%ebp),%eax
  800269:	83 ec 08             	sub    $0x8,%esp
  80026c:	ff 75 f4             	pushl  -0xc(%ebp)
  80026f:	50                   	push   %eax
  800270:	e8 f3 01 00 00       	call   800468 <vcprintf>
  800275:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800278:	83 ec 08             	sub    $0x8,%esp
  80027b:	6a 00                	push   $0x0
  80027d:	68 c9 1d 80 00       	push   $0x801dc9
  800282:	e8 e1 01 00 00       	call   800468 <vcprintf>
  800287:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80028a:	e8 82 ff ff ff       	call   800211 <exit>

	// should not return here
	while (1) ;
  80028f:	eb fe                	jmp    80028f <_panic+0x70>

00800291 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800291:	55                   	push   %ebp
  800292:	89 e5                	mov    %esp,%ebp
  800294:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800297:	a1 20 30 80 00       	mov    0x803020,%eax
  80029c:	8b 50 74             	mov    0x74(%eax),%edx
  80029f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a2:	39 c2                	cmp    %eax,%edx
  8002a4:	74 14                	je     8002ba <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002a6:	83 ec 04             	sub    $0x4,%esp
  8002a9:	68 cc 1d 80 00       	push   $0x801dcc
  8002ae:	6a 26                	push   $0x26
  8002b0:	68 18 1e 80 00       	push   $0x801e18
  8002b5:	e8 65 ff ff ff       	call   80021f <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002ba:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002c8:	e9 c2 00 00 00       	jmp    80038f <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8002da:	01 d0                	add    %edx,%eax
  8002dc:	8b 00                	mov    (%eax),%eax
  8002de:	85 c0                	test   %eax,%eax
  8002e0:	75 08                	jne    8002ea <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8002e2:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8002e5:	e9 a2 00 00 00       	jmp    80038c <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8002ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002f1:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8002f8:	eb 69                	jmp    800363 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8002fa:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ff:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800305:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800308:	89 d0                	mov    %edx,%eax
  80030a:	01 c0                	add    %eax,%eax
  80030c:	01 d0                	add    %edx,%eax
  80030e:	c1 e0 03             	shl    $0x3,%eax
  800311:	01 c8                	add    %ecx,%eax
  800313:	8a 40 04             	mov    0x4(%eax),%al
  800316:	84 c0                	test   %al,%al
  800318:	75 46                	jne    800360 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80031a:	a1 20 30 80 00       	mov    0x803020,%eax
  80031f:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800325:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800328:	89 d0                	mov    %edx,%eax
  80032a:	01 c0                	add    %eax,%eax
  80032c:	01 d0                	add    %edx,%eax
  80032e:	c1 e0 03             	shl    $0x3,%eax
  800331:	01 c8                	add    %ecx,%eax
  800333:	8b 00                	mov    (%eax),%eax
  800335:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800338:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80033b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800340:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800342:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800345:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 c8                	add    %ecx,%eax
  800351:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800353:	39 c2                	cmp    %eax,%edx
  800355:	75 09                	jne    800360 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800357:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80035e:	eb 12                	jmp    800372 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800360:	ff 45 e8             	incl   -0x18(%ebp)
  800363:	a1 20 30 80 00       	mov    0x803020,%eax
  800368:	8b 50 74             	mov    0x74(%eax),%edx
  80036b:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80036e:	39 c2                	cmp    %eax,%edx
  800370:	77 88                	ja     8002fa <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800372:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800376:	75 14                	jne    80038c <CheckWSWithoutLastIndex+0xfb>
			panic(
  800378:	83 ec 04             	sub    $0x4,%esp
  80037b:	68 24 1e 80 00       	push   $0x801e24
  800380:	6a 3a                	push   $0x3a
  800382:	68 18 1e 80 00       	push   $0x801e18
  800387:	e8 93 fe ff ff       	call   80021f <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80038c:	ff 45 f0             	incl   -0x10(%ebp)
  80038f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800392:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800395:	0f 8c 32 ff ff ff    	jl     8002cd <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80039b:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003a2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003a9:	eb 26                	jmp    8003d1 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b0:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8003b6:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003b9:	89 d0                	mov    %edx,%eax
  8003bb:	01 c0                	add    %eax,%eax
  8003bd:	01 d0                	add    %edx,%eax
  8003bf:	c1 e0 03             	shl    $0x3,%eax
  8003c2:	01 c8                	add    %ecx,%eax
  8003c4:	8a 40 04             	mov    0x4(%eax),%al
  8003c7:	3c 01                	cmp    $0x1,%al
  8003c9:	75 03                	jne    8003ce <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003cb:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ce:	ff 45 e0             	incl   -0x20(%ebp)
  8003d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003d6:	8b 50 74             	mov    0x74(%eax),%edx
  8003d9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003dc:	39 c2                	cmp    %eax,%edx
  8003de:	77 cb                	ja     8003ab <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8003e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e3:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8003e6:	74 14                	je     8003fc <CheckWSWithoutLastIndex+0x16b>
		panic(
  8003e8:	83 ec 04             	sub    $0x4,%esp
  8003eb:	68 78 1e 80 00       	push   $0x801e78
  8003f0:	6a 44                	push   $0x44
  8003f2:	68 18 1e 80 00       	push   $0x801e18
  8003f7:	e8 23 fe ff ff       	call   80021f <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8003fc:	90                   	nop
  8003fd:	c9                   	leave  
  8003fe:	c3                   	ret    

008003ff <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8003ff:	55                   	push   %ebp
  800400:	89 e5                	mov    %esp,%ebp
  800402:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800405:	8b 45 0c             	mov    0xc(%ebp),%eax
  800408:	8b 00                	mov    (%eax),%eax
  80040a:	8d 48 01             	lea    0x1(%eax),%ecx
  80040d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800410:	89 0a                	mov    %ecx,(%edx)
  800412:	8b 55 08             	mov    0x8(%ebp),%edx
  800415:	88 d1                	mov    %dl,%cl
  800417:	8b 55 0c             	mov    0xc(%ebp),%edx
  80041a:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80041e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800421:	8b 00                	mov    (%eax),%eax
  800423:	3d ff 00 00 00       	cmp    $0xff,%eax
  800428:	75 2c                	jne    800456 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80042a:	a0 24 30 80 00       	mov    0x803024,%al
  80042f:	0f b6 c0             	movzbl %al,%eax
  800432:	8b 55 0c             	mov    0xc(%ebp),%edx
  800435:	8b 12                	mov    (%edx),%edx
  800437:	89 d1                	mov    %edx,%ecx
  800439:	8b 55 0c             	mov    0xc(%ebp),%edx
  80043c:	83 c2 08             	add    $0x8,%edx
  80043f:	83 ec 04             	sub    $0x4,%esp
  800442:	50                   	push   %eax
  800443:	51                   	push   %ecx
  800444:	52                   	push   %edx
  800445:	e8 3e 0e 00 00       	call   801288 <sys_cputs>
  80044a:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80044d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800450:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800456:	8b 45 0c             	mov    0xc(%ebp),%eax
  800459:	8b 40 04             	mov    0x4(%eax),%eax
  80045c:	8d 50 01             	lea    0x1(%eax),%edx
  80045f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800462:	89 50 04             	mov    %edx,0x4(%eax)
}
  800465:	90                   	nop
  800466:	c9                   	leave  
  800467:	c3                   	ret    

00800468 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800468:	55                   	push   %ebp
  800469:	89 e5                	mov    %esp,%ebp
  80046b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800471:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800478:	00 00 00 
	b.cnt = 0;
  80047b:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800482:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800485:	ff 75 0c             	pushl  0xc(%ebp)
  800488:	ff 75 08             	pushl  0x8(%ebp)
  80048b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800491:	50                   	push   %eax
  800492:	68 ff 03 80 00       	push   $0x8003ff
  800497:	e8 11 02 00 00       	call   8006ad <vprintfmt>
  80049c:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80049f:	a0 24 30 80 00       	mov    0x803024,%al
  8004a4:	0f b6 c0             	movzbl %al,%eax
  8004a7:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004ad:	83 ec 04             	sub    $0x4,%esp
  8004b0:	50                   	push   %eax
  8004b1:	52                   	push   %edx
  8004b2:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004b8:	83 c0 08             	add    $0x8,%eax
  8004bb:	50                   	push   %eax
  8004bc:	e8 c7 0d 00 00       	call   801288 <sys_cputs>
  8004c1:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004c4:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004cb:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004d1:	c9                   	leave  
  8004d2:	c3                   	ret    

008004d3 <cprintf>:

int cprintf(const char *fmt, ...) {
  8004d3:	55                   	push   %ebp
  8004d4:	89 e5                	mov    %esp,%ebp
  8004d6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8004d9:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8004e0:	8d 45 0c             	lea    0xc(%ebp),%eax
  8004e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8004e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004e9:	83 ec 08             	sub    $0x8,%esp
  8004ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8004ef:	50                   	push   %eax
  8004f0:	e8 73 ff ff ff       	call   800468 <vcprintf>
  8004f5:	83 c4 10             	add    $0x10,%esp
  8004f8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8004fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004fe:	c9                   	leave  
  8004ff:	c3                   	ret    

00800500 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800500:	55                   	push   %ebp
  800501:	89 e5                	mov    %esp,%ebp
  800503:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800506:	e8 8e 0f 00 00       	call   801499 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80050b:	8d 45 0c             	lea    0xc(%ebp),%eax
  80050e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800511:	8b 45 08             	mov    0x8(%ebp),%eax
  800514:	83 ec 08             	sub    $0x8,%esp
  800517:	ff 75 f4             	pushl  -0xc(%ebp)
  80051a:	50                   	push   %eax
  80051b:	e8 48 ff ff ff       	call   800468 <vcprintf>
  800520:	83 c4 10             	add    $0x10,%esp
  800523:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800526:	e8 88 0f 00 00       	call   8014b3 <sys_enable_interrupt>
	return cnt;
  80052b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80052e:	c9                   	leave  
  80052f:	c3                   	ret    

00800530 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800530:	55                   	push   %ebp
  800531:	89 e5                	mov    %esp,%ebp
  800533:	53                   	push   %ebx
  800534:	83 ec 14             	sub    $0x14,%esp
  800537:	8b 45 10             	mov    0x10(%ebp),%eax
  80053a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80053d:	8b 45 14             	mov    0x14(%ebp),%eax
  800540:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800543:	8b 45 18             	mov    0x18(%ebp),%eax
  800546:	ba 00 00 00 00       	mov    $0x0,%edx
  80054b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80054e:	77 55                	ja     8005a5 <printnum+0x75>
  800550:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800553:	72 05                	jb     80055a <printnum+0x2a>
  800555:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800558:	77 4b                	ja     8005a5 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80055a:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80055d:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800560:	8b 45 18             	mov    0x18(%ebp),%eax
  800563:	ba 00 00 00 00       	mov    $0x0,%edx
  800568:	52                   	push   %edx
  800569:	50                   	push   %eax
  80056a:	ff 75 f4             	pushl  -0xc(%ebp)
  80056d:	ff 75 f0             	pushl  -0x10(%ebp)
  800570:	e8 17 14 00 00       	call   80198c <__udivdi3>
  800575:	83 c4 10             	add    $0x10,%esp
  800578:	83 ec 04             	sub    $0x4,%esp
  80057b:	ff 75 20             	pushl  0x20(%ebp)
  80057e:	53                   	push   %ebx
  80057f:	ff 75 18             	pushl  0x18(%ebp)
  800582:	52                   	push   %edx
  800583:	50                   	push   %eax
  800584:	ff 75 0c             	pushl  0xc(%ebp)
  800587:	ff 75 08             	pushl  0x8(%ebp)
  80058a:	e8 a1 ff ff ff       	call   800530 <printnum>
  80058f:	83 c4 20             	add    $0x20,%esp
  800592:	eb 1a                	jmp    8005ae <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800594:	83 ec 08             	sub    $0x8,%esp
  800597:	ff 75 0c             	pushl  0xc(%ebp)
  80059a:	ff 75 20             	pushl  0x20(%ebp)
  80059d:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a0:	ff d0                	call   *%eax
  8005a2:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005a5:	ff 4d 1c             	decl   0x1c(%ebp)
  8005a8:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005ac:	7f e6                	jg     800594 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005ae:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005b1:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005b6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005b9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005bc:	53                   	push   %ebx
  8005bd:	51                   	push   %ecx
  8005be:	52                   	push   %edx
  8005bf:	50                   	push   %eax
  8005c0:	e8 d7 14 00 00       	call   801a9c <__umoddi3>
  8005c5:	83 c4 10             	add    $0x10,%esp
  8005c8:	05 f4 20 80 00       	add    $0x8020f4,%eax
  8005cd:	8a 00                	mov    (%eax),%al
  8005cf:	0f be c0             	movsbl %al,%eax
  8005d2:	83 ec 08             	sub    $0x8,%esp
  8005d5:	ff 75 0c             	pushl  0xc(%ebp)
  8005d8:	50                   	push   %eax
  8005d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005dc:	ff d0                	call   *%eax
  8005de:	83 c4 10             	add    $0x10,%esp
}
  8005e1:	90                   	nop
  8005e2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8005e5:	c9                   	leave  
  8005e6:	c3                   	ret    

008005e7 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8005e7:	55                   	push   %ebp
  8005e8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005ea:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005ee:	7e 1c                	jle    80060c <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8005f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f3:	8b 00                	mov    (%eax),%eax
  8005f5:	8d 50 08             	lea    0x8(%eax),%edx
  8005f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8005fb:	89 10                	mov    %edx,(%eax)
  8005fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800600:	8b 00                	mov    (%eax),%eax
  800602:	83 e8 08             	sub    $0x8,%eax
  800605:	8b 50 04             	mov    0x4(%eax),%edx
  800608:	8b 00                	mov    (%eax),%eax
  80060a:	eb 40                	jmp    80064c <getuint+0x65>
	else if (lflag)
  80060c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800610:	74 1e                	je     800630 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	8b 00                	mov    (%eax),%eax
  800617:	8d 50 04             	lea    0x4(%eax),%edx
  80061a:	8b 45 08             	mov    0x8(%ebp),%eax
  80061d:	89 10                	mov    %edx,(%eax)
  80061f:	8b 45 08             	mov    0x8(%ebp),%eax
  800622:	8b 00                	mov    (%eax),%eax
  800624:	83 e8 04             	sub    $0x4,%eax
  800627:	8b 00                	mov    (%eax),%eax
  800629:	ba 00 00 00 00       	mov    $0x0,%edx
  80062e:	eb 1c                	jmp    80064c <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800630:	8b 45 08             	mov    0x8(%ebp),%eax
  800633:	8b 00                	mov    (%eax),%eax
  800635:	8d 50 04             	lea    0x4(%eax),%edx
  800638:	8b 45 08             	mov    0x8(%ebp),%eax
  80063b:	89 10                	mov    %edx,(%eax)
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8b 00                	mov    (%eax),%eax
  800642:	83 e8 04             	sub    $0x4,%eax
  800645:	8b 00                	mov    (%eax),%eax
  800647:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80064c:	5d                   	pop    %ebp
  80064d:	c3                   	ret    

0080064e <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80064e:	55                   	push   %ebp
  80064f:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800651:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800655:	7e 1c                	jle    800673 <getint+0x25>
		return va_arg(*ap, long long);
  800657:	8b 45 08             	mov    0x8(%ebp),%eax
  80065a:	8b 00                	mov    (%eax),%eax
  80065c:	8d 50 08             	lea    0x8(%eax),%edx
  80065f:	8b 45 08             	mov    0x8(%ebp),%eax
  800662:	89 10                	mov    %edx,(%eax)
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	8b 00                	mov    (%eax),%eax
  800669:	83 e8 08             	sub    $0x8,%eax
  80066c:	8b 50 04             	mov    0x4(%eax),%edx
  80066f:	8b 00                	mov    (%eax),%eax
  800671:	eb 38                	jmp    8006ab <getint+0x5d>
	else if (lflag)
  800673:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800677:	74 1a                	je     800693 <getint+0x45>
		return va_arg(*ap, long);
  800679:	8b 45 08             	mov    0x8(%ebp),%eax
  80067c:	8b 00                	mov    (%eax),%eax
  80067e:	8d 50 04             	lea    0x4(%eax),%edx
  800681:	8b 45 08             	mov    0x8(%ebp),%eax
  800684:	89 10                	mov    %edx,(%eax)
  800686:	8b 45 08             	mov    0x8(%ebp),%eax
  800689:	8b 00                	mov    (%eax),%eax
  80068b:	83 e8 04             	sub    $0x4,%eax
  80068e:	8b 00                	mov    (%eax),%eax
  800690:	99                   	cltd   
  800691:	eb 18                	jmp    8006ab <getint+0x5d>
	else
		return va_arg(*ap, int);
  800693:	8b 45 08             	mov    0x8(%ebp),%eax
  800696:	8b 00                	mov    (%eax),%eax
  800698:	8d 50 04             	lea    0x4(%eax),%edx
  80069b:	8b 45 08             	mov    0x8(%ebp),%eax
  80069e:	89 10                	mov    %edx,(%eax)
  8006a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a3:	8b 00                	mov    (%eax),%eax
  8006a5:	83 e8 04             	sub    $0x4,%eax
  8006a8:	8b 00                	mov    (%eax),%eax
  8006aa:	99                   	cltd   
}
  8006ab:	5d                   	pop    %ebp
  8006ac:	c3                   	ret    

008006ad <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006ad:	55                   	push   %ebp
  8006ae:	89 e5                	mov    %esp,%ebp
  8006b0:	56                   	push   %esi
  8006b1:	53                   	push   %ebx
  8006b2:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006b5:	eb 17                	jmp    8006ce <vprintfmt+0x21>
			if (ch == '\0')
  8006b7:	85 db                	test   %ebx,%ebx
  8006b9:	0f 84 af 03 00 00    	je     800a6e <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006bf:	83 ec 08             	sub    $0x8,%esp
  8006c2:	ff 75 0c             	pushl  0xc(%ebp)
  8006c5:	53                   	push   %ebx
  8006c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c9:	ff d0                	call   *%eax
  8006cb:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8006d1:	8d 50 01             	lea    0x1(%eax),%edx
  8006d4:	89 55 10             	mov    %edx,0x10(%ebp)
  8006d7:	8a 00                	mov    (%eax),%al
  8006d9:	0f b6 d8             	movzbl %al,%ebx
  8006dc:	83 fb 25             	cmp    $0x25,%ebx
  8006df:	75 d6                	jne    8006b7 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8006e1:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8006e5:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8006ec:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8006f3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8006fa:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800701:	8b 45 10             	mov    0x10(%ebp),%eax
  800704:	8d 50 01             	lea    0x1(%eax),%edx
  800707:	89 55 10             	mov    %edx,0x10(%ebp)
  80070a:	8a 00                	mov    (%eax),%al
  80070c:	0f b6 d8             	movzbl %al,%ebx
  80070f:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800712:	83 f8 55             	cmp    $0x55,%eax
  800715:	0f 87 2b 03 00 00    	ja     800a46 <vprintfmt+0x399>
  80071b:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  800722:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800724:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800728:	eb d7                	jmp    800701 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80072a:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80072e:	eb d1                	jmp    800701 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800730:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800737:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80073a:	89 d0                	mov    %edx,%eax
  80073c:	c1 e0 02             	shl    $0x2,%eax
  80073f:	01 d0                	add    %edx,%eax
  800741:	01 c0                	add    %eax,%eax
  800743:	01 d8                	add    %ebx,%eax
  800745:	83 e8 30             	sub    $0x30,%eax
  800748:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80074b:	8b 45 10             	mov    0x10(%ebp),%eax
  80074e:	8a 00                	mov    (%eax),%al
  800750:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800753:	83 fb 2f             	cmp    $0x2f,%ebx
  800756:	7e 3e                	jle    800796 <vprintfmt+0xe9>
  800758:	83 fb 39             	cmp    $0x39,%ebx
  80075b:	7f 39                	jg     800796 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80075d:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800760:	eb d5                	jmp    800737 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800762:	8b 45 14             	mov    0x14(%ebp),%eax
  800765:	83 c0 04             	add    $0x4,%eax
  800768:	89 45 14             	mov    %eax,0x14(%ebp)
  80076b:	8b 45 14             	mov    0x14(%ebp),%eax
  80076e:	83 e8 04             	sub    $0x4,%eax
  800771:	8b 00                	mov    (%eax),%eax
  800773:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800776:	eb 1f                	jmp    800797 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800778:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80077c:	79 83                	jns    800701 <vprintfmt+0x54>
				width = 0;
  80077e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800785:	e9 77 ff ff ff       	jmp    800701 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80078a:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800791:	e9 6b ff ff ff       	jmp    800701 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800796:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800797:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80079b:	0f 89 60 ff ff ff    	jns    800701 <vprintfmt+0x54>
				width = precision, precision = -1;
  8007a1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007a4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007a7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007ae:	e9 4e ff ff ff       	jmp    800701 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007b3:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007b6:	e9 46 ff ff ff       	jmp    800701 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8007be:	83 c0 04             	add    $0x4,%eax
  8007c1:	89 45 14             	mov    %eax,0x14(%ebp)
  8007c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c7:	83 e8 04             	sub    $0x4,%eax
  8007ca:	8b 00                	mov    (%eax),%eax
  8007cc:	83 ec 08             	sub    $0x8,%esp
  8007cf:	ff 75 0c             	pushl  0xc(%ebp)
  8007d2:	50                   	push   %eax
  8007d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d6:	ff d0                	call   *%eax
  8007d8:	83 c4 10             	add    $0x10,%esp
			break;
  8007db:	e9 89 02 00 00       	jmp    800a69 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8007e0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007e3:	83 c0 04             	add    $0x4,%eax
  8007e6:	89 45 14             	mov    %eax,0x14(%ebp)
  8007e9:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ec:	83 e8 04             	sub    $0x4,%eax
  8007ef:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8007f1:	85 db                	test   %ebx,%ebx
  8007f3:	79 02                	jns    8007f7 <vprintfmt+0x14a>
				err = -err;
  8007f5:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8007f7:	83 fb 64             	cmp    $0x64,%ebx
  8007fa:	7f 0b                	jg     800807 <vprintfmt+0x15a>
  8007fc:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  800803:	85 f6                	test   %esi,%esi
  800805:	75 19                	jne    800820 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800807:	53                   	push   %ebx
  800808:	68 05 21 80 00       	push   $0x802105
  80080d:	ff 75 0c             	pushl  0xc(%ebp)
  800810:	ff 75 08             	pushl  0x8(%ebp)
  800813:	e8 5e 02 00 00       	call   800a76 <printfmt>
  800818:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  80081b:	e9 49 02 00 00       	jmp    800a69 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800820:	56                   	push   %esi
  800821:	68 0e 21 80 00       	push   $0x80210e
  800826:	ff 75 0c             	pushl  0xc(%ebp)
  800829:	ff 75 08             	pushl  0x8(%ebp)
  80082c:	e8 45 02 00 00       	call   800a76 <printfmt>
  800831:	83 c4 10             	add    $0x10,%esp
			break;
  800834:	e9 30 02 00 00       	jmp    800a69 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800839:	8b 45 14             	mov    0x14(%ebp),%eax
  80083c:	83 c0 04             	add    $0x4,%eax
  80083f:	89 45 14             	mov    %eax,0x14(%ebp)
  800842:	8b 45 14             	mov    0x14(%ebp),%eax
  800845:	83 e8 04             	sub    $0x4,%eax
  800848:	8b 30                	mov    (%eax),%esi
  80084a:	85 f6                	test   %esi,%esi
  80084c:	75 05                	jne    800853 <vprintfmt+0x1a6>
				p = "(null)";
  80084e:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  800853:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800857:	7e 6d                	jle    8008c6 <vprintfmt+0x219>
  800859:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80085d:	74 67                	je     8008c6 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80085f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800862:	83 ec 08             	sub    $0x8,%esp
  800865:	50                   	push   %eax
  800866:	56                   	push   %esi
  800867:	e8 0c 03 00 00       	call   800b78 <strnlen>
  80086c:	83 c4 10             	add    $0x10,%esp
  80086f:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800872:	eb 16                	jmp    80088a <vprintfmt+0x1dd>
					putch(padc, putdat);
  800874:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800878:	83 ec 08             	sub    $0x8,%esp
  80087b:	ff 75 0c             	pushl  0xc(%ebp)
  80087e:	50                   	push   %eax
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	ff d0                	call   *%eax
  800884:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800887:	ff 4d e4             	decl   -0x1c(%ebp)
  80088a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80088e:	7f e4                	jg     800874 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800890:	eb 34                	jmp    8008c6 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800892:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800896:	74 1c                	je     8008b4 <vprintfmt+0x207>
  800898:	83 fb 1f             	cmp    $0x1f,%ebx
  80089b:	7e 05                	jle    8008a2 <vprintfmt+0x1f5>
  80089d:	83 fb 7e             	cmp    $0x7e,%ebx
  8008a0:	7e 12                	jle    8008b4 <vprintfmt+0x207>
					putch('?', putdat);
  8008a2:	83 ec 08             	sub    $0x8,%esp
  8008a5:	ff 75 0c             	pushl  0xc(%ebp)
  8008a8:	6a 3f                	push   $0x3f
  8008aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ad:	ff d0                	call   *%eax
  8008af:	83 c4 10             	add    $0x10,%esp
  8008b2:	eb 0f                	jmp    8008c3 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008b4:	83 ec 08             	sub    $0x8,%esp
  8008b7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ba:	53                   	push   %ebx
  8008bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008be:	ff d0                	call   *%eax
  8008c0:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008c3:	ff 4d e4             	decl   -0x1c(%ebp)
  8008c6:	89 f0                	mov    %esi,%eax
  8008c8:	8d 70 01             	lea    0x1(%eax),%esi
  8008cb:	8a 00                	mov    (%eax),%al
  8008cd:	0f be d8             	movsbl %al,%ebx
  8008d0:	85 db                	test   %ebx,%ebx
  8008d2:	74 24                	je     8008f8 <vprintfmt+0x24b>
  8008d4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008d8:	78 b8                	js     800892 <vprintfmt+0x1e5>
  8008da:	ff 4d e0             	decl   -0x20(%ebp)
  8008dd:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8008e1:	79 af                	jns    800892 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008e3:	eb 13                	jmp    8008f8 <vprintfmt+0x24b>
				putch(' ', putdat);
  8008e5:	83 ec 08             	sub    $0x8,%esp
  8008e8:	ff 75 0c             	pushl  0xc(%ebp)
  8008eb:	6a 20                	push   $0x20
  8008ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f0:	ff d0                	call   *%eax
  8008f2:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8008f5:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008fc:	7f e7                	jg     8008e5 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8008fe:	e9 66 01 00 00       	jmp    800a69 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800903:	83 ec 08             	sub    $0x8,%esp
  800906:	ff 75 e8             	pushl  -0x18(%ebp)
  800909:	8d 45 14             	lea    0x14(%ebp),%eax
  80090c:	50                   	push   %eax
  80090d:	e8 3c fd ff ff       	call   80064e <getint>
  800912:	83 c4 10             	add    $0x10,%esp
  800915:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800918:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80091b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80091e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800921:	85 d2                	test   %edx,%edx
  800923:	79 23                	jns    800948 <vprintfmt+0x29b>
				putch('-', putdat);
  800925:	83 ec 08             	sub    $0x8,%esp
  800928:	ff 75 0c             	pushl  0xc(%ebp)
  80092b:	6a 2d                	push   $0x2d
  80092d:	8b 45 08             	mov    0x8(%ebp),%eax
  800930:	ff d0                	call   *%eax
  800932:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800935:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800938:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80093b:	f7 d8                	neg    %eax
  80093d:	83 d2 00             	adc    $0x0,%edx
  800940:	f7 da                	neg    %edx
  800942:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800945:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800948:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80094f:	e9 bc 00 00 00       	jmp    800a10 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800954:	83 ec 08             	sub    $0x8,%esp
  800957:	ff 75 e8             	pushl  -0x18(%ebp)
  80095a:	8d 45 14             	lea    0x14(%ebp),%eax
  80095d:	50                   	push   %eax
  80095e:	e8 84 fc ff ff       	call   8005e7 <getuint>
  800963:	83 c4 10             	add    $0x10,%esp
  800966:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800969:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80096c:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800973:	e9 98 00 00 00       	jmp    800a10 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800978:	83 ec 08             	sub    $0x8,%esp
  80097b:	ff 75 0c             	pushl  0xc(%ebp)
  80097e:	6a 58                	push   $0x58
  800980:	8b 45 08             	mov    0x8(%ebp),%eax
  800983:	ff d0                	call   *%eax
  800985:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800988:	83 ec 08             	sub    $0x8,%esp
  80098b:	ff 75 0c             	pushl  0xc(%ebp)
  80098e:	6a 58                	push   $0x58
  800990:	8b 45 08             	mov    0x8(%ebp),%eax
  800993:	ff d0                	call   *%eax
  800995:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800998:	83 ec 08             	sub    $0x8,%esp
  80099b:	ff 75 0c             	pushl  0xc(%ebp)
  80099e:	6a 58                	push   $0x58
  8009a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a3:	ff d0                	call   *%eax
  8009a5:	83 c4 10             	add    $0x10,%esp
			break;
  8009a8:	e9 bc 00 00 00       	jmp    800a69 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009ad:	83 ec 08             	sub    $0x8,%esp
  8009b0:	ff 75 0c             	pushl  0xc(%ebp)
  8009b3:	6a 30                	push   $0x30
  8009b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b8:	ff d0                	call   *%eax
  8009ba:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009bd:	83 ec 08             	sub    $0x8,%esp
  8009c0:	ff 75 0c             	pushl  0xc(%ebp)
  8009c3:	6a 78                	push   $0x78
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	ff d0                	call   *%eax
  8009ca:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009cd:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d0:	83 c0 04             	add    $0x4,%eax
  8009d3:	89 45 14             	mov    %eax,0x14(%ebp)
  8009d6:	8b 45 14             	mov    0x14(%ebp),%eax
  8009d9:	83 e8 04             	sub    $0x4,%eax
  8009dc:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8009de:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8009e8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8009ef:	eb 1f                	jmp    800a10 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8009f1:	83 ec 08             	sub    $0x8,%esp
  8009f4:	ff 75 e8             	pushl  -0x18(%ebp)
  8009f7:	8d 45 14             	lea    0x14(%ebp),%eax
  8009fa:	50                   	push   %eax
  8009fb:	e8 e7 fb ff ff       	call   8005e7 <getuint>
  800a00:	83 c4 10             	add    $0x10,%esp
  800a03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a06:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a09:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a10:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a14:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a17:	83 ec 04             	sub    $0x4,%esp
  800a1a:	52                   	push   %edx
  800a1b:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a1e:	50                   	push   %eax
  800a1f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a22:	ff 75 f0             	pushl  -0x10(%ebp)
  800a25:	ff 75 0c             	pushl  0xc(%ebp)
  800a28:	ff 75 08             	pushl  0x8(%ebp)
  800a2b:	e8 00 fb ff ff       	call   800530 <printnum>
  800a30:	83 c4 20             	add    $0x20,%esp
			break;
  800a33:	eb 34                	jmp    800a69 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a35:	83 ec 08             	sub    $0x8,%esp
  800a38:	ff 75 0c             	pushl  0xc(%ebp)
  800a3b:	53                   	push   %ebx
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	ff d0                	call   *%eax
  800a41:	83 c4 10             	add    $0x10,%esp
			break;
  800a44:	eb 23                	jmp    800a69 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a46:	83 ec 08             	sub    $0x8,%esp
  800a49:	ff 75 0c             	pushl  0xc(%ebp)
  800a4c:	6a 25                	push   $0x25
  800a4e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a51:	ff d0                	call   *%eax
  800a53:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a56:	ff 4d 10             	decl   0x10(%ebp)
  800a59:	eb 03                	jmp    800a5e <vprintfmt+0x3b1>
  800a5b:	ff 4d 10             	decl   0x10(%ebp)
  800a5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a61:	48                   	dec    %eax
  800a62:	8a 00                	mov    (%eax),%al
  800a64:	3c 25                	cmp    $0x25,%al
  800a66:	75 f3                	jne    800a5b <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a68:	90                   	nop
		}
	}
  800a69:	e9 47 fc ff ff       	jmp    8006b5 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a6e:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a6f:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a72:	5b                   	pop    %ebx
  800a73:	5e                   	pop    %esi
  800a74:	5d                   	pop    %ebp
  800a75:	c3                   	ret    

00800a76 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a76:	55                   	push   %ebp
  800a77:	89 e5                	mov    %esp,%ebp
  800a79:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a7c:	8d 45 10             	lea    0x10(%ebp),%eax
  800a7f:	83 c0 04             	add    $0x4,%eax
  800a82:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a85:	8b 45 10             	mov    0x10(%ebp),%eax
  800a88:	ff 75 f4             	pushl  -0xc(%ebp)
  800a8b:	50                   	push   %eax
  800a8c:	ff 75 0c             	pushl  0xc(%ebp)
  800a8f:	ff 75 08             	pushl  0x8(%ebp)
  800a92:	e8 16 fc ff ff       	call   8006ad <vprintfmt>
  800a97:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a9a:	90                   	nop
  800a9b:	c9                   	leave  
  800a9c:	c3                   	ret    

00800a9d <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a9d:	55                   	push   %ebp
  800a9e:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800aa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aa3:	8b 40 08             	mov    0x8(%eax),%eax
  800aa6:	8d 50 01             	lea    0x1(%eax),%edx
  800aa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aac:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800aaf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab2:	8b 10                	mov    (%eax),%edx
  800ab4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ab7:	8b 40 04             	mov    0x4(%eax),%eax
  800aba:	39 c2                	cmp    %eax,%edx
  800abc:	73 12                	jae    800ad0 <sprintputch+0x33>
		*b->buf++ = ch;
  800abe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac1:	8b 00                	mov    (%eax),%eax
  800ac3:	8d 48 01             	lea    0x1(%eax),%ecx
  800ac6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac9:	89 0a                	mov    %ecx,(%edx)
  800acb:	8b 55 08             	mov    0x8(%ebp),%edx
  800ace:	88 10                	mov    %dl,(%eax)
}
  800ad0:	90                   	nop
  800ad1:	5d                   	pop    %ebp
  800ad2:	c3                   	ret    

00800ad3 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800ad3:	55                   	push   %ebp
  800ad4:	89 e5                	mov    %esp,%ebp
  800ad6:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800adf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae2:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	01 d0                	add    %edx,%eax
  800aea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800af4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800af8:	74 06                	je     800b00 <vsnprintf+0x2d>
  800afa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800afe:	7f 07                	jg     800b07 <vsnprintf+0x34>
		return -E_INVAL;
  800b00:	b8 03 00 00 00       	mov    $0x3,%eax
  800b05:	eb 20                	jmp    800b27 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b07:	ff 75 14             	pushl  0x14(%ebp)
  800b0a:	ff 75 10             	pushl  0x10(%ebp)
  800b0d:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b10:	50                   	push   %eax
  800b11:	68 9d 0a 80 00       	push   $0x800a9d
  800b16:	e8 92 fb ff ff       	call   8006ad <vprintfmt>
  800b1b:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b1e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b21:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b24:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b27:	c9                   	leave  
  800b28:	c3                   	ret    

00800b29 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b29:	55                   	push   %ebp
  800b2a:	89 e5                	mov    %esp,%ebp
  800b2c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b2f:	8d 45 10             	lea    0x10(%ebp),%eax
  800b32:	83 c0 04             	add    $0x4,%eax
  800b35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b38:	8b 45 10             	mov    0x10(%ebp),%eax
  800b3b:	ff 75 f4             	pushl  -0xc(%ebp)
  800b3e:	50                   	push   %eax
  800b3f:	ff 75 0c             	pushl  0xc(%ebp)
  800b42:	ff 75 08             	pushl  0x8(%ebp)
  800b45:	e8 89 ff ff ff       	call   800ad3 <vsnprintf>
  800b4a:	83 c4 10             	add    $0x10,%esp
  800b4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b50:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b53:	c9                   	leave  
  800b54:	c3                   	ret    

00800b55 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b55:	55                   	push   %ebp
  800b56:	89 e5                	mov    %esp,%ebp
  800b58:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b5b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b62:	eb 06                	jmp    800b6a <strlen+0x15>
		n++;
  800b64:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b67:	ff 45 08             	incl   0x8(%ebp)
  800b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6d:	8a 00                	mov    (%eax),%al
  800b6f:	84 c0                	test   %al,%al
  800b71:	75 f1                	jne    800b64 <strlen+0xf>
		n++;
	return n;
  800b73:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b76:	c9                   	leave  
  800b77:	c3                   	ret    

00800b78 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b78:	55                   	push   %ebp
  800b79:	89 e5                	mov    %esp,%ebp
  800b7b:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b7e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b85:	eb 09                	jmp    800b90 <strnlen+0x18>
		n++;
  800b87:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b8a:	ff 45 08             	incl   0x8(%ebp)
  800b8d:	ff 4d 0c             	decl   0xc(%ebp)
  800b90:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b94:	74 09                	je     800b9f <strnlen+0x27>
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	8a 00                	mov    (%eax),%al
  800b9b:	84 c0                	test   %al,%al
  800b9d:	75 e8                	jne    800b87 <strnlen+0xf>
		n++;
	return n;
  800b9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba2:	c9                   	leave  
  800ba3:	c3                   	ret    

00800ba4 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800ba4:	55                   	push   %ebp
  800ba5:	89 e5                	mov    %esp,%ebp
  800ba7:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800baa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bad:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bb0:	90                   	nop
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	8d 50 01             	lea    0x1(%eax),%edx
  800bb7:	89 55 08             	mov    %edx,0x8(%ebp)
  800bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bc3:	8a 12                	mov    (%edx),%dl
  800bc5:	88 10                	mov    %dl,(%eax)
  800bc7:	8a 00                	mov    (%eax),%al
  800bc9:	84 c0                	test   %al,%al
  800bcb:	75 e4                	jne    800bb1 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bcd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bd0:	c9                   	leave  
  800bd1:	c3                   	ret    

00800bd2 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bd2:	55                   	push   %ebp
  800bd3:	89 e5                	mov    %esp,%ebp
  800bd5:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800bde:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800be5:	eb 1f                	jmp    800c06 <strncpy+0x34>
		*dst++ = *src;
  800be7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bea:	8d 50 01             	lea    0x1(%eax),%edx
  800bed:	89 55 08             	mov    %edx,0x8(%ebp)
  800bf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bf3:	8a 12                	mov    (%edx),%dl
  800bf5:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800bf7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bfa:	8a 00                	mov    (%eax),%al
  800bfc:	84 c0                	test   %al,%al
  800bfe:	74 03                	je     800c03 <strncpy+0x31>
			src++;
  800c00:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c03:	ff 45 fc             	incl   -0x4(%ebp)
  800c06:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c09:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c0c:	72 d9                	jb     800be7 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c0e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c11:	c9                   	leave  
  800c12:	c3                   	ret    

00800c13 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c13:	55                   	push   %ebp
  800c14:	89 e5                	mov    %esp,%ebp
  800c16:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c1f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c23:	74 30                	je     800c55 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c25:	eb 16                	jmp    800c3d <strlcpy+0x2a>
			*dst++ = *src++;
  800c27:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2a:	8d 50 01             	lea    0x1(%eax),%edx
  800c2d:	89 55 08             	mov    %edx,0x8(%ebp)
  800c30:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c33:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c36:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c39:	8a 12                	mov    (%edx),%dl
  800c3b:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c3d:	ff 4d 10             	decl   0x10(%ebp)
  800c40:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c44:	74 09                	je     800c4f <strlcpy+0x3c>
  800c46:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c49:	8a 00                	mov    (%eax),%al
  800c4b:	84 c0                	test   %al,%al
  800c4d:	75 d8                	jne    800c27 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c55:	8b 55 08             	mov    0x8(%ebp),%edx
  800c58:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c5b:	29 c2                	sub    %eax,%edx
  800c5d:	89 d0                	mov    %edx,%eax
}
  800c5f:	c9                   	leave  
  800c60:	c3                   	ret    

00800c61 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c61:	55                   	push   %ebp
  800c62:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c64:	eb 06                	jmp    800c6c <strcmp+0xb>
		p++, q++;
  800c66:	ff 45 08             	incl   0x8(%ebp)
  800c69:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6f:	8a 00                	mov    (%eax),%al
  800c71:	84 c0                	test   %al,%al
  800c73:	74 0e                	je     800c83 <strcmp+0x22>
  800c75:	8b 45 08             	mov    0x8(%ebp),%eax
  800c78:	8a 10                	mov    (%eax),%dl
  800c7a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7d:	8a 00                	mov    (%eax),%al
  800c7f:	38 c2                	cmp    %al,%dl
  800c81:	74 e3                	je     800c66 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c83:	8b 45 08             	mov    0x8(%ebp),%eax
  800c86:	8a 00                	mov    (%eax),%al
  800c88:	0f b6 d0             	movzbl %al,%edx
  800c8b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8e:	8a 00                	mov    (%eax),%al
  800c90:	0f b6 c0             	movzbl %al,%eax
  800c93:	29 c2                	sub    %eax,%edx
  800c95:	89 d0                	mov    %edx,%eax
}
  800c97:	5d                   	pop    %ebp
  800c98:	c3                   	ret    

00800c99 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c99:	55                   	push   %ebp
  800c9a:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c9c:	eb 09                	jmp    800ca7 <strncmp+0xe>
		n--, p++, q++;
  800c9e:	ff 4d 10             	decl   0x10(%ebp)
  800ca1:	ff 45 08             	incl   0x8(%ebp)
  800ca4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ca7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cab:	74 17                	je     800cc4 <strncmp+0x2b>
  800cad:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb0:	8a 00                	mov    (%eax),%al
  800cb2:	84 c0                	test   %al,%al
  800cb4:	74 0e                	je     800cc4 <strncmp+0x2b>
  800cb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb9:	8a 10                	mov    (%eax),%dl
  800cbb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cbe:	8a 00                	mov    (%eax),%al
  800cc0:	38 c2                	cmp    %al,%dl
  800cc2:	74 da                	je     800c9e <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cc4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cc8:	75 07                	jne    800cd1 <strncmp+0x38>
		return 0;
  800cca:	b8 00 00 00 00       	mov    $0x0,%eax
  800ccf:	eb 14                	jmp    800ce5 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd4:	8a 00                	mov    (%eax),%al
  800cd6:	0f b6 d0             	movzbl %al,%edx
  800cd9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	0f b6 c0             	movzbl %al,%eax
  800ce1:	29 c2                	sub    %eax,%edx
  800ce3:	89 d0                	mov    %edx,%eax
}
  800ce5:	5d                   	pop    %ebp
  800ce6:	c3                   	ret    

00800ce7 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800ce7:	55                   	push   %ebp
  800ce8:	89 e5                	mov    %esp,%ebp
  800cea:	83 ec 04             	sub    $0x4,%esp
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cf3:	eb 12                	jmp    800d07 <strchr+0x20>
		if (*s == c)
  800cf5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf8:	8a 00                	mov    (%eax),%al
  800cfa:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cfd:	75 05                	jne    800d04 <strchr+0x1d>
			return (char *) s;
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	eb 11                	jmp    800d15 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d04:	ff 45 08             	incl   0x8(%ebp)
  800d07:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0a:	8a 00                	mov    (%eax),%al
  800d0c:	84 c0                	test   %al,%al
  800d0e:	75 e5                	jne    800cf5 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d10:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d15:	c9                   	leave  
  800d16:	c3                   	ret    

00800d17 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d17:	55                   	push   %ebp
  800d18:	89 e5                	mov    %esp,%ebp
  800d1a:	83 ec 04             	sub    $0x4,%esp
  800d1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d20:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d23:	eb 0d                	jmp    800d32 <strfind+0x1b>
		if (*s == c)
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	8a 00                	mov    (%eax),%al
  800d2a:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d2d:	74 0e                	je     800d3d <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d2f:	ff 45 08             	incl   0x8(%ebp)
  800d32:	8b 45 08             	mov    0x8(%ebp),%eax
  800d35:	8a 00                	mov    (%eax),%al
  800d37:	84 c0                	test   %al,%al
  800d39:	75 ea                	jne    800d25 <strfind+0xe>
  800d3b:	eb 01                	jmp    800d3e <strfind+0x27>
		if (*s == c)
			break;
  800d3d:	90                   	nop
	return (char *) s;
  800d3e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d41:	c9                   	leave  
  800d42:	c3                   	ret    

00800d43 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d43:	55                   	push   %ebp
  800d44:	89 e5                	mov    %esp,%ebp
  800d46:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d49:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d4f:	8b 45 10             	mov    0x10(%ebp),%eax
  800d52:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d55:	eb 0e                	jmp    800d65 <memset+0x22>
		*p++ = c;
  800d57:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d5a:	8d 50 01             	lea    0x1(%eax),%edx
  800d5d:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d63:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d65:	ff 4d f8             	decl   -0x8(%ebp)
  800d68:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d6c:	79 e9                	jns    800d57 <memset+0x14>
		*p++ = c;

	return v;
  800d6e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d71:	c9                   	leave  
  800d72:	c3                   	ret    

00800d73 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d73:	55                   	push   %ebp
  800d74:	89 e5                	mov    %esp,%ebp
  800d76:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d7c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d82:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d85:	eb 16                	jmp    800d9d <memcpy+0x2a>
		*d++ = *s++;
  800d87:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d8a:	8d 50 01             	lea    0x1(%eax),%edx
  800d8d:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d90:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d93:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d96:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d99:	8a 12                	mov    (%edx),%dl
  800d9b:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800da0:	8d 50 ff             	lea    -0x1(%eax),%edx
  800da3:	89 55 10             	mov    %edx,0x10(%ebp)
  800da6:	85 c0                	test   %eax,%eax
  800da8:	75 dd                	jne    800d87 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dad:	c9                   	leave  
  800dae:	c3                   	ret    

00800daf <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800daf:	55                   	push   %ebp
  800db0:	89 e5                	mov    %esp,%ebp
  800db2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800db5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800dc1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dc4:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dc7:	73 50                	jae    800e19 <memmove+0x6a>
  800dc9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcf:	01 d0                	add    %edx,%eax
  800dd1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800dd4:	76 43                	jbe    800e19 <memmove+0x6a>
		s += n;
  800dd6:	8b 45 10             	mov    0x10(%ebp),%eax
  800dd9:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800ddc:	8b 45 10             	mov    0x10(%ebp),%eax
  800ddf:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800de2:	eb 10                	jmp    800df4 <memmove+0x45>
			*--d = *--s;
  800de4:	ff 4d f8             	decl   -0x8(%ebp)
  800de7:	ff 4d fc             	decl   -0x4(%ebp)
  800dea:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ded:	8a 10                	mov    (%eax),%dl
  800def:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800df2:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800df4:	8b 45 10             	mov    0x10(%ebp),%eax
  800df7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dfa:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfd:	85 c0                	test   %eax,%eax
  800dff:	75 e3                	jne    800de4 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e01:	eb 23                	jmp    800e26 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e03:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e06:	8d 50 01             	lea    0x1(%eax),%edx
  800e09:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e0c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e0f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e12:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e15:	8a 12                	mov    (%edx),%dl
  800e17:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e19:	8b 45 10             	mov    0x10(%ebp),%eax
  800e1c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e1f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e22:	85 c0                	test   %eax,%eax
  800e24:	75 dd                	jne    800e03 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e26:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e29:	c9                   	leave  
  800e2a:	c3                   	ret    

00800e2b <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e2b:	55                   	push   %ebp
  800e2c:	89 e5                	mov    %esp,%ebp
  800e2e:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e37:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e3a:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e3d:	eb 2a                	jmp    800e69 <memcmp+0x3e>
		if (*s1 != *s2)
  800e3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e42:	8a 10                	mov    (%eax),%dl
  800e44:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e47:	8a 00                	mov    (%eax),%al
  800e49:	38 c2                	cmp    %al,%dl
  800e4b:	74 16                	je     800e63 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e4d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e50:	8a 00                	mov    (%eax),%al
  800e52:	0f b6 d0             	movzbl %al,%edx
  800e55:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e58:	8a 00                	mov    (%eax),%al
  800e5a:	0f b6 c0             	movzbl %al,%eax
  800e5d:	29 c2                	sub    %eax,%edx
  800e5f:	89 d0                	mov    %edx,%eax
  800e61:	eb 18                	jmp    800e7b <memcmp+0x50>
		s1++, s2++;
  800e63:	ff 45 fc             	incl   -0x4(%ebp)
  800e66:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e69:	8b 45 10             	mov    0x10(%ebp),%eax
  800e6c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e6f:	89 55 10             	mov    %edx,0x10(%ebp)
  800e72:	85 c0                	test   %eax,%eax
  800e74:	75 c9                	jne    800e3f <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e76:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e7b:	c9                   	leave  
  800e7c:	c3                   	ret    

00800e7d <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e7d:	55                   	push   %ebp
  800e7e:	89 e5                	mov    %esp,%ebp
  800e80:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e83:	8b 55 08             	mov    0x8(%ebp),%edx
  800e86:	8b 45 10             	mov    0x10(%ebp),%eax
  800e89:	01 d0                	add    %edx,%eax
  800e8b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e8e:	eb 15                	jmp    800ea5 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	8a 00                	mov    (%eax),%al
  800e95:	0f b6 d0             	movzbl %al,%edx
  800e98:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e9b:	0f b6 c0             	movzbl %al,%eax
  800e9e:	39 c2                	cmp    %eax,%edx
  800ea0:	74 0d                	je     800eaf <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ea2:	ff 45 08             	incl   0x8(%ebp)
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800eab:	72 e3                	jb     800e90 <memfind+0x13>
  800ead:	eb 01                	jmp    800eb0 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800eaf:	90                   	nop
	return (void *) s;
  800eb0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800eb3:	c9                   	leave  
  800eb4:	c3                   	ret    

00800eb5 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800eb5:	55                   	push   %ebp
  800eb6:	89 e5                	mov    %esp,%ebp
  800eb8:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ebb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800ec2:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ec9:	eb 03                	jmp    800ece <strtol+0x19>
		s++;
  800ecb:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ece:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed1:	8a 00                	mov    (%eax),%al
  800ed3:	3c 20                	cmp    $0x20,%al
  800ed5:	74 f4                	je     800ecb <strtol+0x16>
  800ed7:	8b 45 08             	mov    0x8(%ebp),%eax
  800eda:	8a 00                	mov    (%eax),%al
  800edc:	3c 09                	cmp    $0x9,%al
  800ede:	74 eb                	je     800ecb <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	8a 00                	mov    (%eax),%al
  800ee5:	3c 2b                	cmp    $0x2b,%al
  800ee7:	75 05                	jne    800eee <strtol+0x39>
		s++;
  800ee9:	ff 45 08             	incl   0x8(%ebp)
  800eec:	eb 13                	jmp    800f01 <strtol+0x4c>
	else if (*s == '-')
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	3c 2d                	cmp    $0x2d,%al
  800ef5:	75 0a                	jne    800f01 <strtol+0x4c>
		s++, neg = 1;
  800ef7:	ff 45 08             	incl   0x8(%ebp)
  800efa:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f01:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f05:	74 06                	je     800f0d <strtol+0x58>
  800f07:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f0b:	75 20                	jne    800f2d <strtol+0x78>
  800f0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	3c 30                	cmp    $0x30,%al
  800f14:	75 17                	jne    800f2d <strtol+0x78>
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	40                   	inc    %eax
  800f1a:	8a 00                	mov    (%eax),%al
  800f1c:	3c 78                	cmp    $0x78,%al
  800f1e:	75 0d                	jne    800f2d <strtol+0x78>
		s += 2, base = 16;
  800f20:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f24:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f2b:	eb 28                	jmp    800f55 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f2d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f31:	75 15                	jne    800f48 <strtol+0x93>
  800f33:	8b 45 08             	mov    0x8(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	3c 30                	cmp    $0x30,%al
  800f3a:	75 0c                	jne    800f48 <strtol+0x93>
		s++, base = 8;
  800f3c:	ff 45 08             	incl   0x8(%ebp)
  800f3f:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f46:	eb 0d                	jmp    800f55 <strtol+0xa0>
	else if (base == 0)
  800f48:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4c:	75 07                	jne    800f55 <strtol+0xa0>
		base = 10;
  800f4e:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f55:	8b 45 08             	mov    0x8(%ebp),%eax
  800f58:	8a 00                	mov    (%eax),%al
  800f5a:	3c 2f                	cmp    $0x2f,%al
  800f5c:	7e 19                	jle    800f77 <strtol+0xc2>
  800f5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f61:	8a 00                	mov    (%eax),%al
  800f63:	3c 39                	cmp    $0x39,%al
  800f65:	7f 10                	jg     800f77 <strtol+0xc2>
			dig = *s - '0';
  800f67:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6a:	8a 00                	mov    (%eax),%al
  800f6c:	0f be c0             	movsbl %al,%eax
  800f6f:	83 e8 30             	sub    $0x30,%eax
  800f72:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f75:	eb 42                	jmp    800fb9 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	3c 60                	cmp    $0x60,%al
  800f7e:	7e 19                	jle    800f99 <strtol+0xe4>
  800f80:	8b 45 08             	mov    0x8(%ebp),%eax
  800f83:	8a 00                	mov    (%eax),%al
  800f85:	3c 7a                	cmp    $0x7a,%al
  800f87:	7f 10                	jg     800f99 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	0f be c0             	movsbl %al,%eax
  800f91:	83 e8 57             	sub    $0x57,%eax
  800f94:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f97:	eb 20                	jmp    800fb9 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f99:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9c:	8a 00                	mov    (%eax),%al
  800f9e:	3c 40                	cmp    $0x40,%al
  800fa0:	7e 39                	jle    800fdb <strtol+0x126>
  800fa2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa5:	8a 00                	mov    (%eax),%al
  800fa7:	3c 5a                	cmp    $0x5a,%al
  800fa9:	7f 30                	jg     800fdb <strtol+0x126>
			dig = *s - 'A' + 10;
  800fab:	8b 45 08             	mov    0x8(%ebp),%eax
  800fae:	8a 00                	mov    (%eax),%al
  800fb0:	0f be c0             	movsbl %al,%eax
  800fb3:	83 e8 37             	sub    $0x37,%eax
  800fb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fb9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fbc:	3b 45 10             	cmp    0x10(%ebp),%eax
  800fbf:	7d 19                	jge    800fda <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fc1:	ff 45 08             	incl   0x8(%ebp)
  800fc4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc7:	0f af 45 10          	imul   0x10(%ebp),%eax
  800fcb:	89 c2                	mov    %eax,%edx
  800fcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fd0:	01 d0                	add    %edx,%eax
  800fd2:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800fd5:	e9 7b ff ff ff       	jmp    800f55 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800fda:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800fdb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fdf:	74 08                	je     800fe9 <strtol+0x134>
		*endptr = (char *) s;
  800fe1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe4:	8b 55 08             	mov    0x8(%ebp),%edx
  800fe7:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800fe9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800fed:	74 07                	je     800ff6 <strtol+0x141>
  800fef:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff2:	f7 d8                	neg    %eax
  800ff4:	eb 03                	jmp    800ff9 <strtol+0x144>
  800ff6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ff9:	c9                   	leave  
  800ffa:	c3                   	ret    

00800ffb <ltostr>:

void
ltostr(long value, char *str)
{
  800ffb:	55                   	push   %ebp
  800ffc:	89 e5                	mov    %esp,%ebp
  800ffe:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801001:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801008:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80100f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801013:	79 13                	jns    801028 <ltostr+0x2d>
	{
		neg = 1;
  801015:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80101c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101f:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801022:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801025:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801028:	8b 45 08             	mov    0x8(%ebp),%eax
  80102b:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801030:	99                   	cltd   
  801031:	f7 f9                	idiv   %ecx
  801033:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801036:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801039:	8d 50 01             	lea    0x1(%eax),%edx
  80103c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80103f:	89 c2                	mov    %eax,%edx
  801041:	8b 45 0c             	mov    0xc(%ebp),%eax
  801044:	01 d0                	add    %edx,%eax
  801046:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801049:	83 c2 30             	add    $0x30,%edx
  80104c:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80104e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801051:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801056:	f7 e9                	imul   %ecx
  801058:	c1 fa 02             	sar    $0x2,%edx
  80105b:	89 c8                	mov    %ecx,%eax
  80105d:	c1 f8 1f             	sar    $0x1f,%eax
  801060:	29 c2                	sub    %eax,%edx
  801062:	89 d0                	mov    %edx,%eax
  801064:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801067:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80106a:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80106f:	f7 e9                	imul   %ecx
  801071:	c1 fa 02             	sar    $0x2,%edx
  801074:	89 c8                	mov    %ecx,%eax
  801076:	c1 f8 1f             	sar    $0x1f,%eax
  801079:	29 c2                	sub    %eax,%edx
  80107b:	89 d0                	mov    %edx,%eax
  80107d:	c1 e0 02             	shl    $0x2,%eax
  801080:	01 d0                	add    %edx,%eax
  801082:	01 c0                	add    %eax,%eax
  801084:	29 c1                	sub    %eax,%ecx
  801086:	89 ca                	mov    %ecx,%edx
  801088:	85 d2                	test   %edx,%edx
  80108a:	75 9c                	jne    801028 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80108c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801093:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801096:	48                   	dec    %eax
  801097:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80109a:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80109e:	74 3d                	je     8010dd <ltostr+0xe2>
		start = 1 ;
  8010a0:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010a7:	eb 34                	jmp    8010dd <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010a9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010af:	01 d0                	add    %edx,%eax
  8010b1:	8a 00                	mov    (%eax),%al
  8010b3:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bc:	01 c2                	add    %eax,%edx
  8010be:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010c4:	01 c8                	add    %ecx,%eax
  8010c6:	8a 00                	mov    (%eax),%al
  8010c8:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010ca:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d0:	01 c2                	add    %eax,%edx
  8010d2:	8a 45 eb             	mov    -0x15(%ebp),%al
  8010d5:	88 02                	mov    %al,(%edx)
		start++ ;
  8010d7:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8010da:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8010dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e0:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8010e3:	7c c4                	jl     8010a9 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8010e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8010e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010eb:	01 d0                	add    %edx,%eax
  8010ed:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8010f0:	90                   	nop
  8010f1:	c9                   	leave  
  8010f2:	c3                   	ret    

008010f3 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8010f3:	55                   	push   %ebp
  8010f4:	89 e5                	mov    %esp,%ebp
  8010f6:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8010f9:	ff 75 08             	pushl  0x8(%ebp)
  8010fc:	e8 54 fa ff ff       	call   800b55 <strlen>
  801101:	83 c4 04             	add    $0x4,%esp
  801104:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801107:	ff 75 0c             	pushl  0xc(%ebp)
  80110a:	e8 46 fa ff ff       	call   800b55 <strlen>
  80110f:	83 c4 04             	add    $0x4,%esp
  801112:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801115:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80111c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801123:	eb 17                	jmp    80113c <strcconcat+0x49>
		final[s] = str1[s] ;
  801125:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801128:	8b 45 10             	mov    0x10(%ebp),%eax
  80112b:	01 c2                	add    %eax,%edx
  80112d:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801130:	8b 45 08             	mov    0x8(%ebp),%eax
  801133:	01 c8                	add    %ecx,%eax
  801135:	8a 00                	mov    (%eax),%al
  801137:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801139:	ff 45 fc             	incl   -0x4(%ebp)
  80113c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801142:	7c e1                	jl     801125 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801144:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80114b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801152:	eb 1f                	jmp    801173 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801154:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801157:	8d 50 01             	lea    0x1(%eax),%edx
  80115a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80115d:	89 c2                	mov    %eax,%edx
  80115f:	8b 45 10             	mov    0x10(%ebp),%eax
  801162:	01 c2                	add    %eax,%edx
  801164:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801167:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116a:	01 c8                	add    %ecx,%eax
  80116c:	8a 00                	mov    (%eax),%al
  80116e:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801170:	ff 45 f8             	incl   -0x8(%ebp)
  801173:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801176:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801179:	7c d9                	jl     801154 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80117b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80117e:	8b 45 10             	mov    0x10(%ebp),%eax
  801181:	01 d0                	add    %edx,%eax
  801183:	c6 00 00             	movb   $0x0,(%eax)
}
  801186:	90                   	nop
  801187:	c9                   	leave  
  801188:	c3                   	ret    

00801189 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801189:	55                   	push   %ebp
  80118a:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80118c:	8b 45 14             	mov    0x14(%ebp),%eax
  80118f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801195:	8b 45 14             	mov    0x14(%ebp),%eax
  801198:	8b 00                	mov    (%eax),%eax
  80119a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011a1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011a4:	01 d0                	add    %edx,%eax
  8011a6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ac:	eb 0c                	jmp    8011ba <strsplit+0x31>
			*string++ = 0;
  8011ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b1:	8d 50 01             	lea    0x1(%eax),%edx
  8011b4:	89 55 08             	mov    %edx,0x8(%ebp)
  8011b7:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bd:	8a 00                	mov    (%eax),%al
  8011bf:	84 c0                	test   %al,%al
  8011c1:	74 18                	je     8011db <strsplit+0x52>
  8011c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8011c6:	8a 00                	mov    (%eax),%al
  8011c8:	0f be c0             	movsbl %al,%eax
  8011cb:	50                   	push   %eax
  8011cc:	ff 75 0c             	pushl  0xc(%ebp)
  8011cf:	e8 13 fb ff ff       	call   800ce7 <strchr>
  8011d4:	83 c4 08             	add    $0x8,%esp
  8011d7:	85 c0                	test   %eax,%eax
  8011d9:	75 d3                	jne    8011ae <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8011db:	8b 45 08             	mov    0x8(%ebp),%eax
  8011de:	8a 00                	mov    (%eax),%al
  8011e0:	84 c0                	test   %al,%al
  8011e2:	74 5a                	je     80123e <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8011e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8011e7:	8b 00                	mov    (%eax),%eax
  8011e9:	83 f8 0f             	cmp    $0xf,%eax
  8011ec:	75 07                	jne    8011f5 <strsplit+0x6c>
		{
			return 0;
  8011ee:	b8 00 00 00 00       	mov    $0x0,%eax
  8011f3:	eb 66                	jmp    80125b <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8011f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8011f8:	8b 00                	mov    (%eax),%eax
  8011fa:	8d 48 01             	lea    0x1(%eax),%ecx
  8011fd:	8b 55 14             	mov    0x14(%ebp),%edx
  801200:	89 0a                	mov    %ecx,(%edx)
  801202:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801209:	8b 45 10             	mov    0x10(%ebp),%eax
  80120c:	01 c2                	add    %eax,%edx
  80120e:	8b 45 08             	mov    0x8(%ebp),%eax
  801211:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801213:	eb 03                	jmp    801218 <strsplit+0x8f>
			string++;
  801215:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801218:	8b 45 08             	mov    0x8(%ebp),%eax
  80121b:	8a 00                	mov    (%eax),%al
  80121d:	84 c0                	test   %al,%al
  80121f:	74 8b                	je     8011ac <strsplit+0x23>
  801221:	8b 45 08             	mov    0x8(%ebp),%eax
  801224:	8a 00                	mov    (%eax),%al
  801226:	0f be c0             	movsbl %al,%eax
  801229:	50                   	push   %eax
  80122a:	ff 75 0c             	pushl  0xc(%ebp)
  80122d:	e8 b5 fa ff ff       	call   800ce7 <strchr>
  801232:	83 c4 08             	add    $0x8,%esp
  801235:	85 c0                	test   %eax,%eax
  801237:	74 dc                	je     801215 <strsplit+0x8c>
			string++;
	}
  801239:	e9 6e ff ff ff       	jmp    8011ac <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80123e:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80123f:	8b 45 14             	mov    0x14(%ebp),%eax
  801242:	8b 00                	mov    (%eax),%eax
  801244:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80124b:	8b 45 10             	mov    0x10(%ebp),%eax
  80124e:	01 d0                	add    %edx,%eax
  801250:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801256:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80125b:	c9                   	leave  
  80125c:	c3                   	ret    

0080125d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80125d:	55                   	push   %ebp
  80125e:	89 e5                	mov    %esp,%ebp
  801260:	57                   	push   %edi
  801261:	56                   	push   %esi
  801262:	53                   	push   %ebx
  801263:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801266:	8b 45 08             	mov    0x8(%ebp),%eax
  801269:	8b 55 0c             	mov    0xc(%ebp),%edx
  80126c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80126f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801272:	8b 7d 18             	mov    0x18(%ebp),%edi
  801275:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801278:	cd 30                	int    $0x30
  80127a:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80127d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801280:	83 c4 10             	add    $0x10,%esp
  801283:	5b                   	pop    %ebx
  801284:	5e                   	pop    %esi
  801285:	5f                   	pop    %edi
  801286:	5d                   	pop    %ebp
  801287:	c3                   	ret    

00801288 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
  80128b:	83 ec 04             	sub    $0x4,%esp
  80128e:	8b 45 10             	mov    0x10(%ebp),%eax
  801291:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801294:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801298:	8b 45 08             	mov    0x8(%ebp),%eax
  80129b:	6a 00                	push   $0x0
  80129d:	6a 00                	push   $0x0
  80129f:	52                   	push   %edx
  8012a0:	ff 75 0c             	pushl  0xc(%ebp)
  8012a3:	50                   	push   %eax
  8012a4:	6a 00                	push   $0x0
  8012a6:	e8 b2 ff ff ff       	call   80125d <syscall>
  8012ab:	83 c4 18             	add    $0x18,%esp
}
  8012ae:	90                   	nop
  8012af:	c9                   	leave  
  8012b0:	c3                   	ret    

008012b1 <sys_cgetc>:

int
sys_cgetc(void)
{
  8012b1:	55                   	push   %ebp
  8012b2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012b4:	6a 00                	push   $0x0
  8012b6:	6a 00                	push   $0x0
  8012b8:	6a 00                	push   $0x0
  8012ba:	6a 00                	push   $0x0
  8012bc:	6a 00                	push   $0x0
  8012be:	6a 01                	push   $0x1
  8012c0:	e8 98 ff ff ff       	call   80125d <syscall>
  8012c5:	83 c4 18             	add    $0x18,%esp
}
  8012c8:	c9                   	leave  
  8012c9:	c3                   	ret    

008012ca <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012ca:	55                   	push   %ebp
  8012cb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d0:	6a 00                	push   $0x0
  8012d2:	6a 00                	push   $0x0
  8012d4:	6a 00                	push   $0x0
  8012d6:	6a 00                	push   $0x0
  8012d8:	50                   	push   %eax
  8012d9:	6a 05                	push   $0x5
  8012db:	e8 7d ff ff ff       	call   80125d <syscall>
  8012e0:	83 c4 18             	add    $0x18,%esp
}
  8012e3:	c9                   	leave  
  8012e4:	c3                   	ret    

008012e5 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8012e5:	55                   	push   %ebp
  8012e6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 00                	push   $0x0
  8012ec:	6a 00                	push   $0x0
  8012ee:	6a 00                	push   $0x0
  8012f0:	6a 00                	push   $0x0
  8012f2:	6a 02                	push   $0x2
  8012f4:	e8 64 ff ff ff       	call   80125d <syscall>
  8012f9:	83 c4 18             	add    $0x18,%esp
}
  8012fc:	c9                   	leave  
  8012fd:	c3                   	ret    

008012fe <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8012fe:	55                   	push   %ebp
  8012ff:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801301:	6a 00                	push   $0x0
  801303:	6a 00                	push   $0x0
  801305:	6a 00                	push   $0x0
  801307:	6a 00                	push   $0x0
  801309:	6a 00                	push   $0x0
  80130b:	6a 03                	push   $0x3
  80130d:	e8 4b ff ff ff       	call   80125d <syscall>
  801312:	83 c4 18             	add    $0x18,%esp
}
  801315:	c9                   	leave  
  801316:	c3                   	ret    

00801317 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801317:	55                   	push   %ebp
  801318:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 00                	push   $0x0
  801320:	6a 00                	push   $0x0
  801322:	6a 00                	push   $0x0
  801324:	6a 04                	push   $0x4
  801326:	e8 32 ff ff ff       	call   80125d <syscall>
  80132b:	83 c4 18             	add    $0x18,%esp
}
  80132e:	c9                   	leave  
  80132f:	c3                   	ret    

00801330 <sys_env_exit>:


void sys_env_exit(void)
{
  801330:	55                   	push   %ebp
  801331:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 00                	push   $0x0
  801339:	6a 00                	push   $0x0
  80133b:	6a 00                	push   $0x0
  80133d:	6a 06                	push   $0x6
  80133f:	e8 19 ff ff ff       	call   80125d <syscall>
  801344:	83 c4 18             	add    $0x18,%esp
}
  801347:	90                   	nop
  801348:	c9                   	leave  
  801349:	c3                   	ret    

0080134a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80134a:	55                   	push   %ebp
  80134b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80134d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801350:	8b 45 08             	mov    0x8(%ebp),%eax
  801353:	6a 00                	push   $0x0
  801355:	6a 00                	push   $0x0
  801357:	6a 00                	push   $0x0
  801359:	52                   	push   %edx
  80135a:	50                   	push   %eax
  80135b:	6a 07                	push   $0x7
  80135d:	e8 fb fe ff ff       	call   80125d <syscall>
  801362:	83 c4 18             	add    $0x18,%esp
}
  801365:	c9                   	leave  
  801366:	c3                   	ret    

00801367 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801367:	55                   	push   %ebp
  801368:	89 e5                	mov    %esp,%ebp
  80136a:	56                   	push   %esi
  80136b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80136c:	8b 75 18             	mov    0x18(%ebp),%esi
  80136f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801372:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801375:	8b 55 0c             	mov    0xc(%ebp),%edx
  801378:	8b 45 08             	mov    0x8(%ebp),%eax
  80137b:	56                   	push   %esi
  80137c:	53                   	push   %ebx
  80137d:	51                   	push   %ecx
  80137e:	52                   	push   %edx
  80137f:	50                   	push   %eax
  801380:	6a 08                	push   $0x8
  801382:	e8 d6 fe ff ff       	call   80125d <syscall>
  801387:	83 c4 18             	add    $0x18,%esp
}
  80138a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80138d:	5b                   	pop    %ebx
  80138e:	5e                   	pop    %esi
  80138f:	5d                   	pop    %ebp
  801390:	c3                   	ret    

00801391 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801394:	8b 55 0c             	mov    0xc(%ebp),%edx
  801397:	8b 45 08             	mov    0x8(%ebp),%eax
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 00                	push   $0x0
  8013a0:	52                   	push   %edx
  8013a1:	50                   	push   %eax
  8013a2:	6a 09                	push   $0x9
  8013a4:	e8 b4 fe ff ff       	call   80125d <syscall>
  8013a9:	83 c4 18             	add    $0x18,%esp
}
  8013ac:	c9                   	leave  
  8013ad:	c3                   	ret    

008013ae <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013ae:	55                   	push   %ebp
  8013af:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	6a 00                	push   $0x0
  8013b7:	ff 75 0c             	pushl  0xc(%ebp)
  8013ba:	ff 75 08             	pushl  0x8(%ebp)
  8013bd:	6a 0a                	push   $0xa
  8013bf:	e8 99 fe ff ff       	call   80125d <syscall>
  8013c4:	83 c4 18             	add    $0x18,%esp
}
  8013c7:	c9                   	leave  
  8013c8:	c3                   	ret    

008013c9 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013c9:	55                   	push   %ebp
  8013ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013cc:	6a 00                	push   $0x0
  8013ce:	6a 00                	push   $0x0
  8013d0:	6a 00                	push   $0x0
  8013d2:	6a 00                	push   $0x0
  8013d4:	6a 00                	push   $0x0
  8013d6:	6a 0b                	push   $0xb
  8013d8:	e8 80 fe ff ff       	call   80125d <syscall>
  8013dd:	83 c4 18             	add    $0x18,%esp
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 00                	push   $0x0
  8013ed:	6a 00                	push   $0x0
  8013ef:	6a 0c                	push   $0xc
  8013f1:	e8 67 fe ff ff       	call   80125d <syscall>
  8013f6:	83 c4 18             	add    $0x18,%esp
}
  8013f9:	c9                   	leave  
  8013fa:	c3                   	ret    

008013fb <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8013fb:	55                   	push   %ebp
  8013fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 00                	push   $0x0
  801404:	6a 00                	push   $0x0
  801406:	6a 00                	push   $0x0
  801408:	6a 0d                	push   $0xd
  80140a:	e8 4e fe ff ff       	call   80125d <syscall>
  80140f:	83 c4 18             	add    $0x18,%esp
}
  801412:	c9                   	leave  
  801413:	c3                   	ret    

00801414 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801414:	55                   	push   %ebp
  801415:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 00                	push   $0x0
  80141d:	ff 75 0c             	pushl  0xc(%ebp)
  801420:	ff 75 08             	pushl  0x8(%ebp)
  801423:	6a 11                	push   $0x11
  801425:	e8 33 fe ff ff       	call   80125d <syscall>
  80142a:	83 c4 18             	add    $0x18,%esp
	return;
  80142d:	90                   	nop
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801433:	6a 00                	push   $0x0
  801435:	6a 00                	push   $0x0
  801437:	6a 00                	push   $0x0
  801439:	ff 75 0c             	pushl  0xc(%ebp)
  80143c:	ff 75 08             	pushl  0x8(%ebp)
  80143f:	6a 12                	push   $0x12
  801441:	e8 17 fe ff ff       	call   80125d <syscall>
  801446:	83 c4 18             	add    $0x18,%esp
	return ;
  801449:	90                   	nop
}
  80144a:	c9                   	leave  
  80144b:	c3                   	ret    

0080144c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80144c:	55                   	push   %ebp
  80144d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80144f:	6a 00                	push   $0x0
  801451:	6a 00                	push   $0x0
  801453:	6a 00                	push   $0x0
  801455:	6a 00                	push   $0x0
  801457:	6a 00                	push   $0x0
  801459:	6a 0e                	push   $0xe
  80145b:	e8 fd fd ff ff       	call   80125d <syscall>
  801460:	83 c4 18             	add    $0x18,%esp
}
  801463:	c9                   	leave  
  801464:	c3                   	ret    

00801465 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801465:	55                   	push   %ebp
  801466:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801468:	6a 00                	push   $0x0
  80146a:	6a 00                	push   $0x0
  80146c:	6a 00                	push   $0x0
  80146e:	6a 00                	push   $0x0
  801470:	ff 75 08             	pushl  0x8(%ebp)
  801473:	6a 0f                	push   $0xf
  801475:	e8 e3 fd ff ff       	call   80125d <syscall>
  80147a:	83 c4 18             	add    $0x18,%esp
}
  80147d:	c9                   	leave  
  80147e:	c3                   	ret    

0080147f <sys_scarce_memory>:

void sys_scarce_memory()
{
  80147f:	55                   	push   %ebp
  801480:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 00                	push   $0x0
  80148c:	6a 10                	push   $0x10
  80148e:	e8 ca fd ff ff       	call   80125d <syscall>
  801493:	83 c4 18             	add    $0x18,%esp
}
  801496:	90                   	nop
  801497:	c9                   	leave  
  801498:	c3                   	ret    

00801499 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801499:	55                   	push   %ebp
  80149a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80149c:	6a 00                	push   $0x0
  80149e:	6a 00                	push   $0x0
  8014a0:	6a 00                	push   $0x0
  8014a2:	6a 00                	push   $0x0
  8014a4:	6a 00                	push   $0x0
  8014a6:	6a 14                	push   $0x14
  8014a8:	e8 b0 fd ff ff       	call   80125d <syscall>
  8014ad:	83 c4 18             	add    $0x18,%esp
}
  8014b0:	90                   	nop
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 00                	push   $0x0
  8014ba:	6a 00                	push   $0x0
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 15                	push   $0x15
  8014c2:	e8 96 fd ff ff       	call   80125d <syscall>
  8014c7:	83 c4 18             	add    $0x18,%esp
}
  8014ca:	90                   	nop
  8014cb:	c9                   	leave  
  8014cc:	c3                   	ret    

008014cd <sys_cputc>:


void
sys_cputc(const char c)
{
  8014cd:	55                   	push   %ebp
  8014ce:	89 e5                	mov    %esp,%ebp
  8014d0:	83 ec 04             	sub    $0x4,%esp
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8014d9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8014dd:	6a 00                	push   $0x0
  8014df:	6a 00                	push   $0x0
  8014e1:	6a 00                	push   $0x0
  8014e3:	6a 00                	push   $0x0
  8014e5:	50                   	push   %eax
  8014e6:	6a 16                	push   $0x16
  8014e8:	e8 70 fd ff ff       	call   80125d <syscall>
  8014ed:	83 c4 18             	add    $0x18,%esp
}
  8014f0:	90                   	nop
  8014f1:	c9                   	leave  
  8014f2:	c3                   	ret    

008014f3 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8014f3:	55                   	push   %ebp
  8014f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8014f6:	6a 00                	push   $0x0
  8014f8:	6a 00                	push   $0x0
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	6a 17                	push   $0x17
  801502:	e8 56 fd ff ff       	call   80125d <syscall>
  801507:	83 c4 18             	add    $0x18,%esp
}
  80150a:	90                   	nop
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801510:	8b 45 08             	mov    0x8(%ebp),%eax
  801513:	6a 00                	push   $0x0
  801515:	6a 00                	push   $0x0
  801517:	6a 00                	push   $0x0
  801519:	ff 75 0c             	pushl  0xc(%ebp)
  80151c:	50                   	push   %eax
  80151d:	6a 18                	push   $0x18
  80151f:	e8 39 fd ff ff       	call   80125d <syscall>
  801524:	83 c4 18             	add    $0x18,%esp
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80152c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	52                   	push   %edx
  801539:	50                   	push   %eax
  80153a:	6a 1b                	push   $0x1b
  80153c:	e8 1c fd ff ff       	call   80125d <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801549:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154c:	8b 45 08             	mov    0x8(%ebp),%eax
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	52                   	push   %edx
  801556:	50                   	push   %eax
  801557:	6a 19                	push   $0x19
  801559:	e8 ff fc ff ff       	call   80125d <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
}
  801561:	90                   	nop
  801562:	c9                   	leave  
  801563:	c3                   	ret    

00801564 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801564:	55                   	push   %ebp
  801565:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801567:	8b 55 0c             	mov    0xc(%ebp),%edx
  80156a:	8b 45 08             	mov    0x8(%ebp),%eax
  80156d:	6a 00                	push   $0x0
  80156f:	6a 00                	push   $0x0
  801571:	6a 00                	push   $0x0
  801573:	52                   	push   %edx
  801574:	50                   	push   %eax
  801575:	6a 1a                	push   $0x1a
  801577:	e8 e1 fc ff ff       	call   80125d <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	90                   	nop
  801580:	c9                   	leave  
  801581:	c3                   	ret    

00801582 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801582:	55                   	push   %ebp
  801583:	89 e5                	mov    %esp,%ebp
  801585:	83 ec 04             	sub    $0x4,%esp
  801588:	8b 45 10             	mov    0x10(%ebp),%eax
  80158b:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80158e:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801591:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801595:	8b 45 08             	mov    0x8(%ebp),%eax
  801598:	6a 00                	push   $0x0
  80159a:	51                   	push   %ecx
  80159b:	52                   	push   %edx
  80159c:	ff 75 0c             	pushl  0xc(%ebp)
  80159f:	50                   	push   %eax
  8015a0:	6a 1c                	push   $0x1c
  8015a2:	e8 b6 fc ff ff       	call   80125d <syscall>
  8015a7:	83 c4 18             	add    $0x18,%esp
}
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	52                   	push   %edx
  8015bc:	50                   	push   %eax
  8015bd:	6a 1d                	push   $0x1d
  8015bf:	e8 99 fc ff ff       	call   80125d <syscall>
  8015c4:	83 c4 18             	add    $0x18,%esp
}
  8015c7:	c9                   	leave  
  8015c8:	c3                   	ret    

008015c9 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015c9:	55                   	push   %ebp
  8015ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	51                   	push   %ecx
  8015da:	52                   	push   %edx
  8015db:	50                   	push   %eax
  8015dc:	6a 1e                	push   $0x1e
  8015de:	e8 7a fc ff ff       	call   80125d <syscall>
  8015e3:	83 c4 18             	add    $0x18,%esp
}
  8015e6:	c9                   	leave  
  8015e7:	c3                   	ret    

008015e8 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8015e8:	55                   	push   %ebp
  8015e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8015eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f1:	6a 00                	push   $0x0
  8015f3:	6a 00                	push   $0x0
  8015f5:	6a 00                	push   $0x0
  8015f7:	52                   	push   %edx
  8015f8:	50                   	push   %eax
  8015f9:	6a 1f                	push   $0x1f
  8015fb:	e8 5d fc ff ff       	call   80125d <syscall>
  801600:	83 c4 18             	add    $0x18,%esp
}
  801603:	c9                   	leave  
  801604:	c3                   	ret    

00801605 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801605:	55                   	push   %ebp
  801606:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801608:	6a 00                	push   $0x0
  80160a:	6a 00                	push   $0x0
  80160c:	6a 00                	push   $0x0
  80160e:	6a 00                	push   $0x0
  801610:	6a 00                	push   $0x0
  801612:	6a 20                	push   $0x20
  801614:	e8 44 fc ff ff       	call   80125d <syscall>
  801619:	83 c4 18             	add    $0x18,%esp
}
  80161c:	c9                   	leave  
  80161d:	c3                   	ret    

0080161e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80161e:	55                   	push   %ebp
  80161f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	6a 00                	push   $0x0
  801626:	ff 75 14             	pushl  0x14(%ebp)
  801629:	ff 75 10             	pushl  0x10(%ebp)
  80162c:	ff 75 0c             	pushl  0xc(%ebp)
  80162f:	50                   	push   %eax
  801630:	6a 21                	push   $0x21
  801632:	e8 26 fc ff ff       	call   80125d <syscall>
  801637:	83 c4 18             	add    $0x18,%esp
}
  80163a:	c9                   	leave  
  80163b:	c3                   	ret    

0080163c <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80163c:	55                   	push   %ebp
  80163d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	6a 00                	push   $0x0
  801644:	6a 00                	push   $0x0
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	50                   	push   %eax
  80164b:	6a 22                	push   $0x22
  80164d:	e8 0b fc ff ff       	call   80125d <syscall>
  801652:	83 c4 18             	add    $0x18,%esp
}
  801655:	90                   	nop
  801656:	c9                   	leave  
  801657:	c3                   	ret    

00801658 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80165b:	8b 45 08             	mov    0x8(%ebp),%eax
  80165e:	6a 00                	push   $0x0
  801660:	6a 00                	push   $0x0
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	50                   	push   %eax
  801667:	6a 23                	push   $0x23
  801669:	e8 ef fb ff ff       	call   80125d <syscall>
  80166e:	83 c4 18             	add    $0x18,%esp
}
  801671:	90                   	nop
  801672:	c9                   	leave  
  801673:	c3                   	ret    

00801674 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801674:	55                   	push   %ebp
  801675:	89 e5                	mov    %esp,%ebp
  801677:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  80167a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80167d:	8d 50 04             	lea    0x4(%eax),%edx
  801680:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801683:	6a 00                	push   $0x0
  801685:	6a 00                	push   $0x0
  801687:	6a 00                	push   $0x0
  801689:	52                   	push   %edx
  80168a:	50                   	push   %eax
  80168b:	6a 24                	push   $0x24
  80168d:	e8 cb fb ff ff       	call   80125d <syscall>
  801692:	83 c4 18             	add    $0x18,%esp
	return result;
  801695:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801698:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80169b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80169e:	89 01                	mov    %eax,(%ecx)
  8016a0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a6:	c9                   	leave  
  8016a7:	c2 04 00             	ret    $0x4

008016aa <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016ad:	6a 00                	push   $0x0
  8016af:	6a 00                	push   $0x0
  8016b1:	ff 75 10             	pushl  0x10(%ebp)
  8016b4:	ff 75 0c             	pushl  0xc(%ebp)
  8016b7:	ff 75 08             	pushl  0x8(%ebp)
  8016ba:	6a 13                	push   $0x13
  8016bc:	e8 9c fb ff ff       	call   80125d <syscall>
  8016c1:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c4:	90                   	nop
}
  8016c5:	c9                   	leave  
  8016c6:	c3                   	ret    

008016c7 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016c7:	55                   	push   %ebp
  8016c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 25                	push   $0x25
  8016d6:	e8 82 fb ff ff       	call   80125d <syscall>
  8016db:	83 c4 18             	add    $0x18,%esp
}
  8016de:	c9                   	leave  
  8016df:	c3                   	ret    

008016e0 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8016e0:	55                   	push   %ebp
  8016e1:	89 e5                	mov    %esp,%ebp
  8016e3:	83 ec 04             	sub    $0x4,%esp
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8016ec:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8016f0:	6a 00                	push   $0x0
  8016f2:	6a 00                	push   $0x0
  8016f4:	6a 00                	push   $0x0
  8016f6:	6a 00                	push   $0x0
  8016f8:	50                   	push   %eax
  8016f9:	6a 26                	push   $0x26
  8016fb:	e8 5d fb ff ff       	call   80125d <syscall>
  801700:	83 c4 18             	add    $0x18,%esp
	return ;
  801703:	90                   	nop
}
  801704:	c9                   	leave  
  801705:	c3                   	ret    

00801706 <rsttst>:
void rsttst()
{
  801706:	55                   	push   %ebp
  801707:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801709:	6a 00                	push   $0x0
  80170b:	6a 00                	push   $0x0
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 28                	push   $0x28
  801715:	e8 43 fb ff ff       	call   80125d <syscall>
  80171a:	83 c4 18             	add    $0x18,%esp
	return ;
  80171d:	90                   	nop
}
  80171e:	c9                   	leave  
  80171f:	c3                   	ret    

00801720 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801720:	55                   	push   %ebp
  801721:	89 e5                	mov    %esp,%ebp
  801723:	83 ec 04             	sub    $0x4,%esp
  801726:	8b 45 14             	mov    0x14(%ebp),%eax
  801729:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80172c:	8b 55 18             	mov    0x18(%ebp),%edx
  80172f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801733:	52                   	push   %edx
  801734:	50                   	push   %eax
  801735:	ff 75 10             	pushl  0x10(%ebp)
  801738:	ff 75 0c             	pushl  0xc(%ebp)
  80173b:	ff 75 08             	pushl  0x8(%ebp)
  80173e:	6a 27                	push   $0x27
  801740:	e8 18 fb ff ff       	call   80125d <syscall>
  801745:	83 c4 18             	add    $0x18,%esp
	return ;
  801748:	90                   	nop
}
  801749:	c9                   	leave  
  80174a:	c3                   	ret    

0080174b <chktst>:
void chktst(uint32 n)
{
  80174b:	55                   	push   %ebp
  80174c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80174e:	6a 00                	push   $0x0
  801750:	6a 00                	push   $0x0
  801752:	6a 00                	push   $0x0
  801754:	6a 00                	push   $0x0
  801756:	ff 75 08             	pushl  0x8(%ebp)
  801759:	6a 29                	push   $0x29
  80175b:	e8 fd fa ff ff       	call   80125d <syscall>
  801760:	83 c4 18             	add    $0x18,%esp
	return ;
  801763:	90                   	nop
}
  801764:	c9                   	leave  
  801765:	c3                   	ret    

00801766 <inctst>:

void inctst()
{
  801766:	55                   	push   %ebp
  801767:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 00                	push   $0x0
  80176f:	6a 00                	push   $0x0
  801771:	6a 00                	push   $0x0
  801773:	6a 2a                	push   $0x2a
  801775:	e8 e3 fa ff ff       	call   80125d <syscall>
  80177a:	83 c4 18             	add    $0x18,%esp
	return ;
  80177d:	90                   	nop
}
  80177e:	c9                   	leave  
  80177f:	c3                   	ret    

00801780 <gettst>:
uint32 gettst()
{
  801780:	55                   	push   %ebp
  801781:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	6a 00                	push   $0x0
  80178b:	6a 00                	push   $0x0
  80178d:	6a 2b                	push   $0x2b
  80178f:	e8 c9 fa ff ff       	call   80125d <syscall>
  801794:	83 c4 18             	add    $0x18,%esp
}
  801797:	c9                   	leave  
  801798:	c3                   	ret    

00801799 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801799:	55                   	push   %ebp
  80179a:	89 e5                	mov    %esp,%ebp
  80179c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80179f:	6a 00                	push   $0x0
  8017a1:	6a 00                	push   $0x0
  8017a3:	6a 00                	push   $0x0
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 2c                	push   $0x2c
  8017ab:	e8 ad fa ff ff       	call   80125d <syscall>
  8017b0:	83 c4 18             	add    $0x18,%esp
  8017b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017b6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017ba:	75 07                	jne    8017c3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017bc:	b8 01 00 00 00       	mov    $0x1,%eax
  8017c1:	eb 05                	jmp    8017c8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017c3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017c8:	c9                   	leave  
  8017c9:	c3                   	ret    

008017ca <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017ca:	55                   	push   %ebp
  8017cb:	89 e5                	mov    %esp,%ebp
  8017cd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017d0:	6a 00                	push   $0x0
  8017d2:	6a 00                	push   $0x0
  8017d4:	6a 00                	push   $0x0
  8017d6:	6a 00                	push   $0x0
  8017d8:	6a 00                	push   $0x0
  8017da:	6a 2c                	push   $0x2c
  8017dc:	e8 7c fa ff ff       	call   80125d <syscall>
  8017e1:	83 c4 18             	add    $0x18,%esp
  8017e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8017e7:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8017eb:	75 07                	jne    8017f4 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8017ed:	b8 01 00 00 00       	mov    $0x1,%eax
  8017f2:	eb 05                	jmp    8017f9 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8017f4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f9:	c9                   	leave  
  8017fa:	c3                   	ret    

008017fb <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8017fb:	55                   	push   %ebp
  8017fc:	89 e5                	mov    %esp,%ebp
  8017fe:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801801:	6a 00                	push   $0x0
  801803:	6a 00                	push   $0x0
  801805:	6a 00                	push   $0x0
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 2c                	push   $0x2c
  80180d:	e8 4b fa ff ff       	call   80125d <syscall>
  801812:	83 c4 18             	add    $0x18,%esp
  801815:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801818:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80181c:	75 07                	jne    801825 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80181e:	b8 01 00 00 00       	mov    $0x1,%eax
  801823:	eb 05                	jmp    80182a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801825:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80182a:	c9                   	leave  
  80182b:	c3                   	ret    

0080182c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80182c:	55                   	push   %ebp
  80182d:	89 e5                	mov    %esp,%ebp
  80182f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	6a 00                	push   $0x0
  80183c:	6a 2c                	push   $0x2c
  80183e:	e8 1a fa ff ff       	call   80125d <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
  801846:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801849:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80184d:	75 07                	jne    801856 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80184f:	b8 01 00 00 00       	mov    $0x1,%eax
  801854:	eb 05                	jmp    80185b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801856:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80185b:	c9                   	leave  
  80185c:	c3                   	ret    

0080185d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80185d:	55                   	push   %ebp
  80185e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	ff 75 08             	pushl  0x8(%ebp)
  80186b:	6a 2d                	push   $0x2d
  80186d:	e8 eb f9 ff ff       	call   80125d <syscall>
  801872:	83 c4 18             	add    $0x18,%esp
	return ;
  801875:	90                   	nop
}
  801876:	c9                   	leave  
  801877:	c3                   	ret    

00801878 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801878:	55                   	push   %ebp
  801879:	89 e5                	mov    %esp,%ebp
  80187b:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80187c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80187f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801882:	8b 55 0c             	mov    0xc(%ebp),%edx
  801885:	8b 45 08             	mov    0x8(%ebp),%eax
  801888:	6a 00                	push   $0x0
  80188a:	53                   	push   %ebx
  80188b:	51                   	push   %ecx
  80188c:	52                   	push   %edx
  80188d:	50                   	push   %eax
  80188e:	6a 2e                	push   $0x2e
  801890:	e8 c8 f9 ff ff       	call   80125d <syscall>
  801895:	83 c4 18             	add    $0x18,%esp
}
  801898:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80189b:	c9                   	leave  
  80189c:	c3                   	ret    

0080189d <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80189d:	55                   	push   %ebp
  80189e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018a0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a6:	6a 00                	push   $0x0
  8018a8:	6a 00                	push   $0x0
  8018aa:	6a 00                	push   $0x0
  8018ac:	52                   	push   %edx
  8018ad:	50                   	push   %eax
  8018ae:	6a 2f                	push   $0x2f
  8018b0:	e8 a8 f9 ff ff       	call   80125d <syscall>
  8018b5:	83 c4 18             	add    $0x18,%esp
}
  8018b8:	c9                   	leave  
  8018b9:	c3                   	ret    

008018ba <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018ba:	55                   	push   %ebp
  8018bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018bd:	6a 00                	push   $0x0
  8018bf:	6a 00                	push   $0x0
  8018c1:	6a 00                	push   $0x0
  8018c3:	ff 75 0c             	pushl  0xc(%ebp)
  8018c6:	ff 75 08             	pushl  0x8(%ebp)
  8018c9:	6a 30                	push   $0x30
  8018cb:	e8 8d f9 ff ff       	call   80125d <syscall>
  8018d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8018d3:	90                   	nop
}
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <env_sleep>:
#include <inc/lib.h>
#include <inc/timerreg.h>

void
env_sleep(uint32 approxMilliSeconds)
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
  8018d9:	83 ec 28             	sub    $0x28,%esp
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
  8018dc:	8b 55 08             	mov    0x8(%ebp),%edx
  8018df:	89 d0                	mov    %edx,%eax
  8018e1:	c1 e0 02             	shl    $0x2,%eax
  8018e4:	01 d0                	add    %edx,%eax
  8018e6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ed:	01 d0                	add    %edx,%eax
  8018ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f6:	01 d0                	add    %edx,%eax
  8018f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018ff:	01 d0                	add    %edx,%eax
  801901:	c1 e0 04             	shl    $0x4,%eax
  801904:	89 45 f0             	mov    %eax,-0x10(%ebp)
	uint32 cycles_counter =0;
  801907:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	struct uint64 baseTime = sys_get_virtual_time() ;
  80190e:	8d 45 e8             	lea    -0x18(%ebp),%eax
  801911:	83 ec 0c             	sub    $0xc,%esp
  801914:	50                   	push   %eax
  801915:	e8 5a fd ff ff       	call   801674 <sys_get_virtual_time>
  80191a:	83 c4 0c             	add    $0xc,%esp
	while(cycles_counter<time_in_cycles)
  80191d:	eb 41                	jmp    801960 <env_sleep+0x8a>
	{
		struct uint64 currentTime = sys_get_virtual_time() ;
  80191f:	8d 45 e0             	lea    -0x20(%ebp),%eax
  801922:	83 ec 0c             	sub    $0xc,%esp
  801925:	50                   	push   %eax
  801926:	e8 49 fd ff ff       	call   801674 <sys_get_virtual_time>
  80192b:	83 c4 0c             	add    $0xc,%esp

		// update the cycles_count
		#define M32 0xffffffff
		// subtract basetime from current time
		struct uint64 res;
		res.low = (currentTime.low - baseTime.low) & M32;
  80192e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  801931:	8b 45 e8             	mov    -0x18(%ebp),%eax
  801934:	29 c2                	sub    %eax,%edx
  801936:	89 d0                	mov    %edx,%eax
  801938:	89 45 d8             	mov    %eax,-0x28(%ebp)
		res.hi = (currentTime.hi - baseTime.hi - (res.low > currentTime.low)) & M32;
  80193b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  80193e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801941:	89 d1                	mov    %edx,%ecx
  801943:	29 c1                	sub    %eax,%ecx
  801945:	8b 55 d8             	mov    -0x28(%ebp),%edx
  801948:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80194b:	39 c2                	cmp    %eax,%edx
  80194d:	0f 97 c0             	seta   %al
  801950:	0f b6 c0             	movzbl %al,%eax
  801953:	29 c1                	sub    %eax,%ecx
  801955:	89 c8                	mov    %ecx,%eax
  801957:	89 45 dc             	mov    %eax,-0x24(%ebp)

		//update cycles_count with result
		cycles_counter = res.low;
  80195a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80195d:	89 45 f4             	mov    %eax,-0xc(%ebp)
//	cprintf("%s go to sleep...\n", myEnv->prog_name);
	uint32 time_in_cycles=approxMilliSeconds*CYCLES_PER_MILLISEC;
	uint32 cycles_counter =0;

	struct uint64 baseTime = sys_get_virtual_time() ;
	while(cycles_counter<time_in_cycles)
  801960:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801963:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801966:	72 b7                	jb     80191f <env_sleep+0x49>
//				,cycles_counter
//				);
	}
	//cprintf("%s [%d] wake up now!\n", myEnv->prog_name, myEnv->env_id);

}
  801968:	90                   	nop
  801969:	c9                   	leave  
  80196a:	c3                   	ret    

0080196b <busy_wait>:

//2017
uint32 busy_wait(uint32 loopMax)
{
  80196b:	55                   	push   %ebp
  80196c:	89 e5                	mov    %esp,%ebp
  80196e:	83 ec 10             	sub    $0x10,%esp
	uint32 i = 0 ;
  801971:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	while (i < loopMax) i++;
  801978:	eb 03                	jmp    80197d <busy_wait+0x12>
  80197a:	ff 45 fc             	incl   -0x4(%ebp)
  80197d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801980:	3b 45 08             	cmp    0x8(%ebp),%eax
  801983:	72 f5                	jb     80197a <busy_wait+0xf>
	return i;
  801985:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801988:	c9                   	leave  
  801989:	c3                   	ret    
  80198a:	66 90                	xchg   %ax,%ax

0080198c <__udivdi3>:
  80198c:	55                   	push   %ebp
  80198d:	57                   	push   %edi
  80198e:	56                   	push   %esi
  80198f:	53                   	push   %ebx
  801990:	83 ec 1c             	sub    $0x1c,%esp
  801993:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801997:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80199b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80199f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8019a3:	89 ca                	mov    %ecx,%edx
  8019a5:	89 f8                	mov    %edi,%eax
  8019a7:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8019ab:	85 f6                	test   %esi,%esi
  8019ad:	75 2d                	jne    8019dc <__udivdi3+0x50>
  8019af:	39 cf                	cmp    %ecx,%edi
  8019b1:	77 65                	ja     801a18 <__udivdi3+0x8c>
  8019b3:	89 fd                	mov    %edi,%ebp
  8019b5:	85 ff                	test   %edi,%edi
  8019b7:	75 0b                	jne    8019c4 <__udivdi3+0x38>
  8019b9:	b8 01 00 00 00       	mov    $0x1,%eax
  8019be:	31 d2                	xor    %edx,%edx
  8019c0:	f7 f7                	div    %edi
  8019c2:	89 c5                	mov    %eax,%ebp
  8019c4:	31 d2                	xor    %edx,%edx
  8019c6:	89 c8                	mov    %ecx,%eax
  8019c8:	f7 f5                	div    %ebp
  8019ca:	89 c1                	mov    %eax,%ecx
  8019cc:	89 d8                	mov    %ebx,%eax
  8019ce:	f7 f5                	div    %ebp
  8019d0:	89 cf                	mov    %ecx,%edi
  8019d2:	89 fa                	mov    %edi,%edx
  8019d4:	83 c4 1c             	add    $0x1c,%esp
  8019d7:	5b                   	pop    %ebx
  8019d8:	5e                   	pop    %esi
  8019d9:	5f                   	pop    %edi
  8019da:	5d                   	pop    %ebp
  8019db:	c3                   	ret    
  8019dc:	39 ce                	cmp    %ecx,%esi
  8019de:	77 28                	ja     801a08 <__udivdi3+0x7c>
  8019e0:	0f bd fe             	bsr    %esi,%edi
  8019e3:	83 f7 1f             	xor    $0x1f,%edi
  8019e6:	75 40                	jne    801a28 <__udivdi3+0x9c>
  8019e8:	39 ce                	cmp    %ecx,%esi
  8019ea:	72 0a                	jb     8019f6 <__udivdi3+0x6a>
  8019ec:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8019f0:	0f 87 9e 00 00 00    	ja     801a94 <__udivdi3+0x108>
  8019f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8019fb:	89 fa                	mov    %edi,%edx
  8019fd:	83 c4 1c             	add    $0x1c,%esp
  801a00:	5b                   	pop    %ebx
  801a01:	5e                   	pop    %esi
  801a02:	5f                   	pop    %edi
  801a03:	5d                   	pop    %ebp
  801a04:	c3                   	ret    
  801a05:	8d 76 00             	lea    0x0(%esi),%esi
  801a08:	31 ff                	xor    %edi,%edi
  801a0a:	31 c0                	xor    %eax,%eax
  801a0c:	89 fa                	mov    %edi,%edx
  801a0e:	83 c4 1c             	add    $0x1c,%esp
  801a11:	5b                   	pop    %ebx
  801a12:	5e                   	pop    %esi
  801a13:	5f                   	pop    %edi
  801a14:	5d                   	pop    %ebp
  801a15:	c3                   	ret    
  801a16:	66 90                	xchg   %ax,%ax
  801a18:	89 d8                	mov    %ebx,%eax
  801a1a:	f7 f7                	div    %edi
  801a1c:	31 ff                	xor    %edi,%edi
  801a1e:	89 fa                	mov    %edi,%edx
  801a20:	83 c4 1c             	add    $0x1c,%esp
  801a23:	5b                   	pop    %ebx
  801a24:	5e                   	pop    %esi
  801a25:	5f                   	pop    %edi
  801a26:	5d                   	pop    %ebp
  801a27:	c3                   	ret    
  801a28:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a2d:	89 eb                	mov    %ebp,%ebx
  801a2f:	29 fb                	sub    %edi,%ebx
  801a31:	89 f9                	mov    %edi,%ecx
  801a33:	d3 e6                	shl    %cl,%esi
  801a35:	89 c5                	mov    %eax,%ebp
  801a37:	88 d9                	mov    %bl,%cl
  801a39:	d3 ed                	shr    %cl,%ebp
  801a3b:	89 e9                	mov    %ebp,%ecx
  801a3d:	09 f1                	or     %esi,%ecx
  801a3f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801a43:	89 f9                	mov    %edi,%ecx
  801a45:	d3 e0                	shl    %cl,%eax
  801a47:	89 c5                	mov    %eax,%ebp
  801a49:	89 d6                	mov    %edx,%esi
  801a4b:	88 d9                	mov    %bl,%cl
  801a4d:	d3 ee                	shr    %cl,%esi
  801a4f:	89 f9                	mov    %edi,%ecx
  801a51:	d3 e2                	shl    %cl,%edx
  801a53:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a57:	88 d9                	mov    %bl,%cl
  801a59:	d3 e8                	shr    %cl,%eax
  801a5b:	09 c2                	or     %eax,%edx
  801a5d:	89 d0                	mov    %edx,%eax
  801a5f:	89 f2                	mov    %esi,%edx
  801a61:	f7 74 24 0c          	divl   0xc(%esp)
  801a65:	89 d6                	mov    %edx,%esi
  801a67:	89 c3                	mov    %eax,%ebx
  801a69:	f7 e5                	mul    %ebp
  801a6b:	39 d6                	cmp    %edx,%esi
  801a6d:	72 19                	jb     801a88 <__udivdi3+0xfc>
  801a6f:	74 0b                	je     801a7c <__udivdi3+0xf0>
  801a71:	89 d8                	mov    %ebx,%eax
  801a73:	31 ff                	xor    %edi,%edi
  801a75:	e9 58 ff ff ff       	jmp    8019d2 <__udivdi3+0x46>
  801a7a:	66 90                	xchg   %ax,%ax
  801a7c:	8b 54 24 08          	mov    0x8(%esp),%edx
  801a80:	89 f9                	mov    %edi,%ecx
  801a82:	d3 e2                	shl    %cl,%edx
  801a84:	39 c2                	cmp    %eax,%edx
  801a86:	73 e9                	jae    801a71 <__udivdi3+0xe5>
  801a88:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a8b:	31 ff                	xor    %edi,%edi
  801a8d:	e9 40 ff ff ff       	jmp    8019d2 <__udivdi3+0x46>
  801a92:	66 90                	xchg   %ax,%ax
  801a94:	31 c0                	xor    %eax,%eax
  801a96:	e9 37 ff ff ff       	jmp    8019d2 <__udivdi3+0x46>
  801a9b:	90                   	nop

00801a9c <__umoddi3>:
  801a9c:	55                   	push   %ebp
  801a9d:	57                   	push   %edi
  801a9e:	56                   	push   %esi
  801a9f:	53                   	push   %ebx
  801aa0:	83 ec 1c             	sub    $0x1c,%esp
  801aa3:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801aa7:	8b 74 24 34          	mov    0x34(%esp),%esi
  801aab:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aaf:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801ab3:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ab7:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801abb:	89 f3                	mov    %esi,%ebx
  801abd:	89 fa                	mov    %edi,%edx
  801abf:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801ac3:	89 34 24             	mov    %esi,(%esp)
  801ac6:	85 c0                	test   %eax,%eax
  801ac8:	75 1a                	jne    801ae4 <__umoddi3+0x48>
  801aca:	39 f7                	cmp    %esi,%edi
  801acc:	0f 86 a2 00 00 00    	jbe    801b74 <__umoddi3+0xd8>
  801ad2:	89 c8                	mov    %ecx,%eax
  801ad4:	89 f2                	mov    %esi,%edx
  801ad6:	f7 f7                	div    %edi
  801ad8:	89 d0                	mov    %edx,%eax
  801ada:	31 d2                	xor    %edx,%edx
  801adc:	83 c4 1c             	add    $0x1c,%esp
  801adf:	5b                   	pop    %ebx
  801ae0:	5e                   	pop    %esi
  801ae1:	5f                   	pop    %edi
  801ae2:	5d                   	pop    %ebp
  801ae3:	c3                   	ret    
  801ae4:	39 f0                	cmp    %esi,%eax
  801ae6:	0f 87 ac 00 00 00    	ja     801b98 <__umoddi3+0xfc>
  801aec:	0f bd e8             	bsr    %eax,%ebp
  801aef:	83 f5 1f             	xor    $0x1f,%ebp
  801af2:	0f 84 ac 00 00 00    	je     801ba4 <__umoddi3+0x108>
  801af8:	bf 20 00 00 00       	mov    $0x20,%edi
  801afd:	29 ef                	sub    %ebp,%edi
  801aff:	89 fe                	mov    %edi,%esi
  801b01:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b05:	89 e9                	mov    %ebp,%ecx
  801b07:	d3 e0                	shl    %cl,%eax
  801b09:	89 d7                	mov    %edx,%edi
  801b0b:	89 f1                	mov    %esi,%ecx
  801b0d:	d3 ef                	shr    %cl,%edi
  801b0f:	09 c7                	or     %eax,%edi
  801b11:	89 e9                	mov    %ebp,%ecx
  801b13:	d3 e2                	shl    %cl,%edx
  801b15:	89 14 24             	mov    %edx,(%esp)
  801b18:	89 d8                	mov    %ebx,%eax
  801b1a:	d3 e0                	shl    %cl,%eax
  801b1c:	89 c2                	mov    %eax,%edx
  801b1e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b22:	d3 e0                	shl    %cl,%eax
  801b24:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b28:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b2c:	89 f1                	mov    %esi,%ecx
  801b2e:	d3 e8                	shr    %cl,%eax
  801b30:	09 d0                	or     %edx,%eax
  801b32:	d3 eb                	shr    %cl,%ebx
  801b34:	89 da                	mov    %ebx,%edx
  801b36:	f7 f7                	div    %edi
  801b38:	89 d3                	mov    %edx,%ebx
  801b3a:	f7 24 24             	mull   (%esp)
  801b3d:	89 c6                	mov    %eax,%esi
  801b3f:	89 d1                	mov    %edx,%ecx
  801b41:	39 d3                	cmp    %edx,%ebx
  801b43:	0f 82 87 00 00 00    	jb     801bd0 <__umoddi3+0x134>
  801b49:	0f 84 91 00 00 00    	je     801be0 <__umoddi3+0x144>
  801b4f:	8b 54 24 04          	mov    0x4(%esp),%edx
  801b53:	29 f2                	sub    %esi,%edx
  801b55:	19 cb                	sbb    %ecx,%ebx
  801b57:	89 d8                	mov    %ebx,%eax
  801b59:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801b5d:	d3 e0                	shl    %cl,%eax
  801b5f:	89 e9                	mov    %ebp,%ecx
  801b61:	d3 ea                	shr    %cl,%edx
  801b63:	09 d0                	or     %edx,%eax
  801b65:	89 e9                	mov    %ebp,%ecx
  801b67:	d3 eb                	shr    %cl,%ebx
  801b69:	89 da                	mov    %ebx,%edx
  801b6b:	83 c4 1c             	add    $0x1c,%esp
  801b6e:	5b                   	pop    %ebx
  801b6f:	5e                   	pop    %esi
  801b70:	5f                   	pop    %edi
  801b71:	5d                   	pop    %ebp
  801b72:	c3                   	ret    
  801b73:	90                   	nop
  801b74:	89 fd                	mov    %edi,%ebp
  801b76:	85 ff                	test   %edi,%edi
  801b78:	75 0b                	jne    801b85 <__umoddi3+0xe9>
  801b7a:	b8 01 00 00 00       	mov    $0x1,%eax
  801b7f:	31 d2                	xor    %edx,%edx
  801b81:	f7 f7                	div    %edi
  801b83:	89 c5                	mov    %eax,%ebp
  801b85:	89 f0                	mov    %esi,%eax
  801b87:	31 d2                	xor    %edx,%edx
  801b89:	f7 f5                	div    %ebp
  801b8b:	89 c8                	mov    %ecx,%eax
  801b8d:	f7 f5                	div    %ebp
  801b8f:	89 d0                	mov    %edx,%eax
  801b91:	e9 44 ff ff ff       	jmp    801ada <__umoddi3+0x3e>
  801b96:	66 90                	xchg   %ax,%ax
  801b98:	89 c8                	mov    %ecx,%eax
  801b9a:	89 f2                	mov    %esi,%edx
  801b9c:	83 c4 1c             	add    $0x1c,%esp
  801b9f:	5b                   	pop    %ebx
  801ba0:	5e                   	pop    %esi
  801ba1:	5f                   	pop    %edi
  801ba2:	5d                   	pop    %ebp
  801ba3:	c3                   	ret    
  801ba4:	3b 04 24             	cmp    (%esp),%eax
  801ba7:	72 06                	jb     801baf <__umoddi3+0x113>
  801ba9:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801bad:	77 0f                	ja     801bbe <__umoddi3+0x122>
  801baf:	89 f2                	mov    %esi,%edx
  801bb1:	29 f9                	sub    %edi,%ecx
  801bb3:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801bb7:	89 14 24             	mov    %edx,(%esp)
  801bba:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801bbe:	8b 44 24 04          	mov    0x4(%esp),%eax
  801bc2:	8b 14 24             	mov    (%esp),%edx
  801bc5:	83 c4 1c             	add    $0x1c,%esp
  801bc8:	5b                   	pop    %ebx
  801bc9:	5e                   	pop    %esi
  801bca:	5f                   	pop    %edi
  801bcb:	5d                   	pop    %ebp
  801bcc:	c3                   	ret    
  801bcd:	8d 76 00             	lea    0x0(%esi),%esi
  801bd0:	2b 04 24             	sub    (%esp),%eax
  801bd3:	19 fa                	sbb    %edi,%edx
  801bd5:	89 d1                	mov    %edx,%ecx
  801bd7:	89 c6                	mov    %eax,%esi
  801bd9:	e9 71 ff ff ff       	jmp    801b4f <__umoddi3+0xb3>
  801bde:	66 90                	xchg   %ax,%ax
  801be0:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801be4:	72 ea                	jb     801bd0 <__umoddi3+0x134>
  801be6:	89 d9                	mov    %ebx,%ecx
  801be8:	e9 62 ff ff ff       	jmp    801b4f <__umoddi3+0xb3>
