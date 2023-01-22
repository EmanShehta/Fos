
obj/user/tst_semaphore_2master:     file format elf32-i386


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
  800031:	e8 8e 01 00 00       	call   8001c4 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
// Master program: take user input, create the semaphores, run slaves and wait them to finish
#include <inc/lib.h>

void
_main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	int envID = sys_getenvid();
  800041:	e8 66 15 00 00       	call   8015ac <sys_getenvid>
  800046:	89 45 f0             	mov    %eax,-0x10(%ebp)
	char line[256] ;
	readline("Enter total number of customers: ", line) ;
  800049:	83 ec 08             	sub    $0x8,%esp
  80004c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800052:	50                   	push   %eax
  800053:	68 c0 1e 80 00       	push   $0x801ec0
  800058:	e8 b9 0b 00 00       	call   800c16 <readline>
  80005d:	83 c4 10             	add    $0x10,%esp
	int totalNumOfCusts = strtol(line, NULL, 10);
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	6a 0a                	push   $0xa
  800065:	6a 00                	push   $0x0
  800067:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80006d:	50                   	push   %eax
  80006e:	e8 09 11 00 00       	call   80117c <strtol>
  800073:	83 c4 10             	add    $0x10,%esp
  800076:	89 45 ec             	mov    %eax,-0x14(%ebp)
	readline("Enter shop capacity: ", line) ;
  800079:	83 ec 08             	sub    $0x8,%esp
  80007c:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  800082:	50                   	push   %eax
  800083:	68 e2 1e 80 00       	push   $0x801ee2
  800088:	e8 89 0b 00 00       	call   800c16 <readline>
  80008d:	83 c4 10             	add    $0x10,%esp
	int shopCapacity = strtol(line, NULL, 10);
  800090:	83 ec 04             	sub    $0x4,%esp
  800093:	6a 0a                	push   $0xa
  800095:	6a 00                	push   $0x0
  800097:	8d 85 dc fe ff ff    	lea    -0x124(%ebp),%eax
  80009d:	50                   	push   %eax
  80009e:	e8 d9 10 00 00       	call   80117c <strtol>
  8000a3:	83 c4 10             	add    $0x10,%esp
  8000a6:	89 45 e8             	mov    %eax,-0x18(%ebp)

	sys_createSemaphore("shopCapacity", shopCapacity);
  8000a9:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000ac:	83 ec 08             	sub    $0x8,%esp
  8000af:	50                   	push   %eax
  8000b0:	68 f8 1e 80 00       	push   $0x801ef8
  8000b5:	e8 1a 17 00 00       	call   8017d4 <sys_createSemaphore>
  8000ba:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("depend", 0);
  8000bd:	83 ec 08             	sub    $0x8,%esp
  8000c0:	6a 00                	push   $0x0
  8000c2:	68 05 1f 80 00       	push   $0x801f05
  8000c7:	e8 08 17 00 00       	call   8017d4 <sys_createSemaphore>
  8000cc:	83 c4 10             	add    $0x10,%esp

	int i = 0 ;
  8000cf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int id ;
	for (; i<totalNumOfCusts; i++)
  8000d6:	eb 5e                	jmp    800136 <_main+0xfe>
	{
		id = sys_create_env("sem2Slave", (myEnv->page_WS_max_size), (myEnv->SecondListSize),(myEnv->percentage_of_WS_pages_to_be_removed));
  8000d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000dd:	8b 90 a0 05 00 00    	mov    0x5a0(%eax),%edx
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 e0 05 00 00    	mov    0x5e0(%eax),%eax
  8000ee:	89 c1                	mov    %eax,%ecx
  8000f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000f5:	8b 40 74             	mov    0x74(%eax),%eax
  8000f8:	52                   	push   %edx
  8000f9:	51                   	push   %ecx
  8000fa:	50                   	push   %eax
  8000fb:	68 0c 1f 80 00       	push   $0x801f0c
  800100:	e8 e0 17 00 00       	call   8018e5 <sys_create_env>
  800105:	83 c4 10             	add    $0x10,%esp
  800108:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		if (id == E_ENV_CREATION_ERROR)
  80010b:	83 7d e4 ef          	cmpl   $0xffffffef,-0x1c(%ebp)
  80010f:	75 14                	jne    800125 <_main+0xed>
			panic("NO AVAILABLE ENVs... Please reduce the number of customers and try again...");
  800111:	83 ec 04             	sub    $0x4,%esp
  800114:	68 18 1f 80 00       	push   $0x801f18
  800119:	6a 18                	push   $0x18
  80011b:	68 64 1f 80 00       	push   $0x801f64
  800120:	e8 bb 01 00 00       	call   8002e0 <_panic>
		sys_run_env(id) ;
  800125:	83 ec 0c             	sub    $0xc,%esp
  800128:	ff 75 e4             	pushl  -0x1c(%ebp)
  80012b:	e8 d3 17 00 00       	call   801903 <sys_run_env>
  800130:	83 c4 10             	add    $0x10,%esp
	sys_createSemaphore("shopCapacity", shopCapacity);
	sys_createSemaphore("depend", 0);

	int i = 0 ;
	int id ;
	for (; i<totalNumOfCusts; i++)
  800133:	ff 45 f4             	incl   -0xc(%ebp)
  800136:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800139:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  80013c:	7c 9a                	jl     8000d8 <_main+0xa0>
		if (id == E_ENV_CREATION_ERROR)
			panic("NO AVAILABLE ENVs... Please reduce the number of customers and try again...");
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  80013e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800145:	eb 16                	jmp    80015d <_main+0x125>
	{
		sys_waitSemaphore(envID, "depend") ;
  800147:	83 ec 08             	sub    $0x8,%esp
  80014a:	68 05 1f 80 00       	push   $0x801f05
  80014f:	ff 75 f0             	pushl  -0x10(%ebp)
  800152:	e8 b6 16 00 00       	call   80180d <sys_waitSemaphore>
  800157:	83 c4 10             	add    $0x10,%esp
		if (id == E_ENV_CREATION_ERROR)
			panic("NO AVAILABLE ENVs... Please reduce the number of customers and try again...");
		sys_run_env(id) ;
	}

	for (i = 0 ; i<totalNumOfCusts; i++)
  80015a:	ff 45 f4             	incl   -0xc(%ebp)
  80015d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800160:	3b 45 ec             	cmp    -0x14(%ebp),%eax
  800163:	7c e2                	jl     800147 <_main+0x10f>
	{
		sys_waitSemaphore(envID, "depend") ;
	}
	int sem1val = sys_getSemaphoreValue(envID, "shopCapacity");
  800165:	83 ec 08             	sub    $0x8,%esp
  800168:	68 f8 1e 80 00       	push   $0x801ef8
  80016d:	ff 75 f0             	pushl  -0x10(%ebp)
  800170:	e8 7b 16 00 00       	call   8017f0 <sys_getSemaphoreValue>
  800175:	83 c4 10             	add    $0x10,%esp
  800178:	89 45 e0             	mov    %eax,-0x20(%ebp)
	int sem2val = sys_getSemaphoreValue(envID, "depend");
  80017b:	83 ec 08             	sub    $0x8,%esp
  80017e:	68 05 1f 80 00       	push   $0x801f05
  800183:	ff 75 f0             	pushl  -0x10(%ebp)
  800186:	e8 65 16 00 00       	call   8017f0 <sys_getSemaphoreValue>
  80018b:	83 c4 10             	add    $0x10,%esp
  80018e:	89 45 dc             	mov    %eax,-0x24(%ebp)
	if (sem2val == 0 && sem1val == shopCapacity)
  800191:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800195:	75 1a                	jne    8001b1 <_main+0x179>
  800197:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80019a:	3b 45 e8             	cmp    -0x18(%ebp),%eax
  80019d:	75 12                	jne    8001b1 <_main+0x179>
		cprintf("Congratulations!! Test of Semaphores [2] completed successfully!!\n\n\n");
  80019f:	83 ec 0c             	sub    $0xc,%esp
  8001a2:	68 84 1f 80 00       	push   $0x801f84
  8001a7:	e8 e8 03 00 00       	call   800594 <cprintf>
  8001ac:	83 c4 10             	add    $0x10,%esp
  8001af:	eb 10                	jmp    8001c1 <_main+0x189>
	else
		cprintf("Error: wrong semaphore value... please review your semaphore code again...");
  8001b1:	83 ec 0c             	sub    $0xc,%esp
  8001b4:	68 cc 1f 80 00       	push   $0x801fcc
  8001b9:	e8 d6 03 00 00       	call   800594 <cprintf>
  8001be:	83 c4 10             	add    $0x10,%esp

	return;
  8001c1:	90                   	nop
}
  8001c2:	c9                   	leave  
  8001c3:	c3                   	ret    

008001c4 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8001c4:	55                   	push   %ebp
  8001c5:	89 e5                	mov    %esp,%ebp
  8001c7:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8001ca:	e8 f6 13 00 00       	call   8015c5 <sys_getenvindex>
  8001cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8001d2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8001d5:	89 d0                	mov    %edx,%eax
  8001d7:	01 c0                	add    %eax,%eax
  8001d9:	01 d0                	add    %edx,%eax
  8001db:	c1 e0 04             	shl    $0x4,%eax
  8001de:	29 d0                	sub    %edx,%eax
  8001e0:	c1 e0 03             	shl    $0x3,%eax
  8001e3:	01 d0                	add    %edx,%eax
  8001e5:	c1 e0 02             	shl    $0x2,%eax
  8001e8:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8001ed:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8001f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f7:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8001fd:	84 c0                	test   %al,%al
  8001ff:	74 0f                	je     800210 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800201:	a1 20 30 80 00       	mov    0x803020,%eax
  800206:	05 5c 05 00 00       	add    $0x55c,%eax
  80020b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800210:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800214:	7e 0a                	jle    800220 <libmain+0x5c>
		binaryname = argv[0];
  800216:	8b 45 0c             	mov    0xc(%ebp),%eax
  800219:	8b 00                	mov    (%eax),%eax
  80021b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800220:	83 ec 08             	sub    $0x8,%esp
  800223:	ff 75 0c             	pushl  0xc(%ebp)
  800226:	ff 75 08             	pushl  0x8(%ebp)
  800229:	e8 0a fe ff ff       	call   800038 <_main>
  80022e:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800231:	e8 2a 15 00 00       	call   801760 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800236:	83 ec 0c             	sub    $0xc,%esp
  800239:	68 30 20 80 00       	push   $0x802030
  80023e:	e8 51 03 00 00       	call   800594 <cprintf>
  800243:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800246:	a1 20 30 80 00       	mov    0x803020,%eax
  80024b:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800251:	a1 20 30 80 00       	mov    0x803020,%eax
  800256:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80025c:	83 ec 04             	sub    $0x4,%esp
  80025f:	52                   	push   %edx
  800260:	50                   	push   %eax
  800261:	68 58 20 80 00       	push   $0x802058
  800266:	e8 29 03 00 00       	call   800594 <cprintf>
  80026b:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80026e:	a1 20 30 80 00       	mov    0x803020,%eax
  800273:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800279:	a1 20 30 80 00       	mov    0x803020,%eax
  80027e:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800284:	a1 20 30 80 00       	mov    0x803020,%eax
  800289:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80028f:	51                   	push   %ecx
  800290:	52                   	push   %edx
  800291:	50                   	push   %eax
  800292:	68 80 20 80 00       	push   $0x802080
  800297:	e8 f8 02 00 00       	call   800594 <cprintf>
  80029c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80029f:	83 ec 0c             	sub    $0xc,%esp
  8002a2:	68 30 20 80 00       	push   $0x802030
  8002a7:	e8 e8 02 00 00       	call   800594 <cprintf>
  8002ac:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8002af:	e8 c6 14 00 00       	call   80177a <sys_enable_interrupt>

	// exit gracefully
	exit();
  8002b4:	e8 19 00 00 00       	call   8002d2 <exit>
}
  8002b9:	90                   	nop
  8002ba:	c9                   	leave  
  8002bb:	c3                   	ret    

008002bc <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8002bc:	55                   	push   %ebp
  8002bd:	89 e5                	mov    %esp,%ebp
  8002bf:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8002c2:	83 ec 0c             	sub    $0xc,%esp
  8002c5:	6a 00                	push   $0x0
  8002c7:	e8 c5 12 00 00       	call   801591 <sys_env_destroy>
  8002cc:	83 c4 10             	add    $0x10,%esp
}
  8002cf:	90                   	nop
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <exit>:

void
exit(void)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8002d8:	e8 1a 13 00 00       	call   8015f7 <sys_env_exit>
}
  8002dd:	90                   	nop
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8002e6:	8d 45 10             	lea    0x10(%ebp),%eax
  8002e9:	83 c0 04             	add    $0x4,%eax
  8002ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8002ef:	a1 18 31 80 00       	mov    0x803118,%eax
  8002f4:	85 c0                	test   %eax,%eax
  8002f6:	74 16                	je     80030e <_panic+0x2e>
		cprintf("%s: ", argv0);
  8002f8:	a1 18 31 80 00       	mov    0x803118,%eax
  8002fd:	83 ec 08             	sub    $0x8,%esp
  800300:	50                   	push   %eax
  800301:	68 d8 20 80 00       	push   $0x8020d8
  800306:	e8 89 02 00 00       	call   800594 <cprintf>
  80030b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80030e:	a1 00 30 80 00       	mov    0x803000,%eax
  800313:	ff 75 0c             	pushl  0xc(%ebp)
  800316:	ff 75 08             	pushl  0x8(%ebp)
  800319:	50                   	push   %eax
  80031a:	68 dd 20 80 00       	push   $0x8020dd
  80031f:	e8 70 02 00 00       	call   800594 <cprintf>
  800324:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800327:	8b 45 10             	mov    0x10(%ebp),%eax
  80032a:	83 ec 08             	sub    $0x8,%esp
  80032d:	ff 75 f4             	pushl  -0xc(%ebp)
  800330:	50                   	push   %eax
  800331:	e8 f3 01 00 00       	call   800529 <vcprintf>
  800336:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800339:	83 ec 08             	sub    $0x8,%esp
  80033c:	6a 00                	push   $0x0
  80033e:	68 f9 20 80 00       	push   $0x8020f9
  800343:	e8 e1 01 00 00       	call   800529 <vcprintf>
  800348:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80034b:	e8 82 ff ff ff       	call   8002d2 <exit>

	// should not return here
	while (1) ;
  800350:	eb fe                	jmp    800350 <_panic+0x70>

00800352 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800352:	55                   	push   %ebp
  800353:	89 e5                	mov    %esp,%ebp
  800355:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800358:	a1 20 30 80 00       	mov    0x803020,%eax
  80035d:	8b 50 74             	mov    0x74(%eax),%edx
  800360:	8b 45 0c             	mov    0xc(%ebp),%eax
  800363:	39 c2                	cmp    %eax,%edx
  800365:	74 14                	je     80037b <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800367:	83 ec 04             	sub    $0x4,%esp
  80036a:	68 fc 20 80 00       	push   $0x8020fc
  80036f:	6a 26                	push   $0x26
  800371:	68 48 21 80 00       	push   $0x802148
  800376:	e8 65 ff ff ff       	call   8002e0 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80037b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800382:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800389:	e9 c2 00 00 00       	jmp    800450 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80038e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800391:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800398:	8b 45 08             	mov    0x8(%ebp),%eax
  80039b:	01 d0                	add    %edx,%eax
  80039d:	8b 00                	mov    (%eax),%eax
  80039f:	85 c0                	test   %eax,%eax
  8003a1:	75 08                	jne    8003ab <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8003a3:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8003a6:	e9 a2 00 00 00       	jmp    80044d <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8003ab:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003b2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8003b9:	eb 69                	jmp    800424 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8003bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c0:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8003c6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003c9:	89 d0                	mov    %edx,%eax
  8003cb:	01 c0                	add    %eax,%eax
  8003cd:	01 d0                	add    %edx,%eax
  8003cf:	c1 e0 03             	shl    $0x3,%eax
  8003d2:	01 c8                	add    %ecx,%eax
  8003d4:	8a 40 04             	mov    0x4(%eax),%al
  8003d7:	84 c0                	test   %al,%al
  8003d9:	75 46                	jne    800421 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8003db:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e0:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8003e6:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8003e9:	89 d0                	mov    %edx,%eax
  8003eb:	01 c0                	add    %eax,%eax
  8003ed:	01 d0                	add    %edx,%eax
  8003ef:	c1 e0 03             	shl    $0x3,%eax
  8003f2:	01 c8                	add    %ecx,%eax
  8003f4:	8b 00                	mov    (%eax),%eax
  8003f6:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8003f9:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8003fc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800401:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800403:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800406:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80040d:	8b 45 08             	mov    0x8(%ebp),%eax
  800410:	01 c8                	add    %ecx,%eax
  800412:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800414:	39 c2                	cmp    %eax,%edx
  800416:	75 09                	jne    800421 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800418:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80041f:	eb 12                	jmp    800433 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800421:	ff 45 e8             	incl   -0x18(%ebp)
  800424:	a1 20 30 80 00       	mov    0x803020,%eax
  800429:	8b 50 74             	mov    0x74(%eax),%edx
  80042c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80042f:	39 c2                	cmp    %eax,%edx
  800431:	77 88                	ja     8003bb <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800433:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800437:	75 14                	jne    80044d <CheckWSWithoutLastIndex+0xfb>
			panic(
  800439:	83 ec 04             	sub    $0x4,%esp
  80043c:	68 54 21 80 00       	push   $0x802154
  800441:	6a 3a                	push   $0x3a
  800443:	68 48 21 80 00       	push   $0x802148
  800448:	e8 93 fe ff ff       	call   8002e0 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80044d:	ff 45 f0             	incl   -0x10(%ebp)
  800450:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800453:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800456:	0f 8c 32 ff ff ff    	jl     80038e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80045c:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800463:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80046a:	eb 26                	jmp    800492 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80046c:	a1 20 30 80 00       	mov    0x803020,%eax
  800471:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800477:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80047a:	89 d0                	mov    %edx,%eax
  80047c:	01 c0                	add    %eax,%eax
  80047e:	01 d0                	add    %edx,%eax
  800480:	c1 e0 03             	shl    $0x3,%eax
  800483:	01 c8                	add    %ecx,%eax
  800485:	8a 40 04             	mov    0x4(%eax),%al
  800488:	3c 01                	cmp    $0x1,%al
  80048a:	75 03                	jne    80048f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80048c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80048f:	ff 45 e0             	incl   -0x20(%ebp)
  800492:	a1 20 30 80 00       	mov    0x803020,%eax
  800497:	8b 50 74             	mov    0x74(%eax),%edx
  80049a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80049d:	39 c2                	cmp    %eax,%edx
  80049f:	77 cb                	ja     80046c <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8004a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004a4:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8004a7:	74 14                	je     8004bd <CheckWSWithoutLastIndex+0x16b>
		panic(
  8004a9:	83 ec 04             	sub    $0x4,%esp
  8004ac:	68 a8 21 80 00       	push   $0x8021a8
  8004b1:	6a 44                	push   $0x44
  8004b3:	68 48 21 80 00       	push   $0x802148
  8004b8:	e8 23 fe ff ff       	call   8002e0 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8004bd:	90                   	nop
  8004be:	c9                   	leave  
  8004bf:	c3                   	ret    

008004c0 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8004c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004c9:	8b 00                	mov    (%eax),%eax
  8004cb:	8d 48 01             	lea    0x1(%eax),%ecx
  8004ce:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004d1:	89 0a                	mov    %ecx,(%edx)
  8004d3:	8b 55 08             	mov    0x8(%ebp),%edx
  8004d6:	88 d1                	mov    %dl,%cl
  8004d8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004db:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8004df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004e2:	8b 00                	mov    (%eax),%eax
  8004e4:	3d ff 00 00 00       	cmp    $0xff,%eax
  8004e9:	75 2c                	jne    800517 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8004eb:	a0 24 30 80 00       	mov    0x803024,%al
  8004f0:	0f b6 c0             	movzbl %al,%eax
  8004f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004f6:	8b 12                	mov    (%edx),%edx
  8004f8:	89 d1                	mov    %edx,%ecx
  8004fa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004fd:	83 c2 08             	add    $0x8,%edx
  800500:	83 ec 04             	sub    $0x4,%esp
  800503:	50                   	push   %eax
  800504:	51                   	push   %ecx
  800505:	52                   	push   %edx
  800506:	e8 44 10 00 00       	call   80154f <sys_cputs>
  80050b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80050e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800511:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800517:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051a:	8b 40 04             	mov    0x4(%eax),%eax
  80051d:	8d 50 01             	lea    0x1(%eax),%edx
  800520:	8b 45 0c             	mov    0xc(%ebp),%eax
  800523:	89 50 04             	mov    %edx,0x4(%eax)
}
  800526:	90                   	nop
  800527:	c9                   	leave  
  800528:	c3                   	ret    

00800529 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800529:	55                   	push   %ebp
  80052a:	89 e5                	mov    %esp,%ebp
  80052c:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800532:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800539:	00 00 00 
	b.cnt = 0;
  80053c:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800543:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800546:	ff 75 0c             	pushl  0xc(%ebp)
  800549:	ff 75 08             	pushl  0x8(%ebp)
  80054c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800552:	50                   	push   %eax
  800553:	68 c0 04 80 00       	push   $0x8004c0
  800558:	e8 11 02 00 00       	call   80076e <vprintfmt>
  80055d:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800560:	a0 24 30 80 00       	mov    0x803024,%al
  800565:	0f b6 c0             	movzbl %al,%eax
  800568:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80056e:	83 ec 04             	sub    $0x4,%esp
  800571:	50                   	push   %eax
  800572:	52                   	push   %edx
  800573:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800579:	83 c0 08             	add    $0x8,%eax
  80057c:	50                   	push   %eax
  80057d:	e8 cd 0f 00 00       	call   80154f <sys_cputs>
  800582:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800585:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80058c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800592:	c9                   	leave  
  800593:	c3                   	ret    

00800594 <cprintf>:

int cprintf(const char *fmt, ...) {
  800594:	55                   	push   %ebp
  800595:	89 e5                	mov    %esp,%ebp
  800597:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80059a:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8005a1:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005aa:	83 ec 08             	sub    $0x8,%esp
  8005ad:	ff 75 f4             	pushl  -0xc(%ebp)
  8005b0:	50                   	push   %eax
  8005b1:	e8 73 ff ff ff       	call   800529 <vcprintf>
  8005b6:	83 c4 10             	add    $0x10,%esp
  8005b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8005bc:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005bf:	c9                   	leave  
  8005c0:	c3                   	ret    

008005c1 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8005c1:	55                   	push   %ebp
  8005c2:	89 e5                	mov    %esp,%ebp
  8005c4:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c7:	e8 94 11 00 00       	call   801760 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8005cc:	8d 45 0c             	lea    0xc(%ebp),%eax
  8005cf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8005d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d5:	83 ec 08             	sub    $0x8,%esp
  8005d8:	ff 75 f4             	pushl  -0xc(%ebp)
  8005db:	50                   	push   %eax
  8005dc:	e8 48 ff ff ff       	call   800529 <vcprintf>
  8005e1:	83 c4 10             	add    $0x10,%esp
  8005e4:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8005e7:	e8 8e 11 00 00       	call   80177a <sys_enable_interrupt>
	return cnt;
  8005ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8005ef:	c9                   	leave  
  8005f0:	c3                   	ret    

008005f1 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8005f1:	55                   	push   %ebp
  8005f2:	89 e5                	mov    %esp,%ebp
  8005f4:	53                   	push   %ebx
  8005f5:	83 ec 14             	sub    $0x14,%esp
  8005f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8005fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8005fe:	8b 45 14             	mov    0x14(%ebp),%eax
  800601:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800604:	8b 45 18             	mov    0x18(%ebp),%eax
  800607:	ba 00 00 00 00       	mov    $0x0,%edx
  80060c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80060f:	77 55                	ja     800666 <printnum+0x75>
  800611:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800614:	72 05                	jb     80061b <printnum+0x2a>
  800616:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800619:	77 4b                	ja     800666 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  80061b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80061e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800621:	8b 45 18             	mov    0x18(%ebp),%eax
  800624:	ba 00 00 00 00       	mov    $0x0,%edx
  800629:	52                   	push   %edx
  80062a:	50                   	push   %eax
  80062b:	ff 75 f4             	pushl  -0xc(%ebp)
  80062e:	ff 75 f0             	pushl  -0x10(%ebp)
  800631:	e8 0a 16 00 00       	call   801c40 <__udivdi3>
  800636:	83 c4 10             	add    $0x10,%esp
  800639:	83 ec 04             	sub    $0x4,%esp
  80063c:	ff 75 20             	pushl  0x20(%ebp)
  80063f:	53                   	push   %ebx
  800640:	ff 75 18             	pushl  0x18(%ebp)
  800643:	52                   	push   %edx
  800644:	50                   	push   %eax
  800645:	ff 75 0c             	pushl  0xc(%ebp)
  800648:	ff 75 08             	pushl  0x8(%ebp)
  80064b:	e8 a1 ff ff ff       	call   8005f1 <printnum>
  800650:	83 c4 20             	add    $0x20,%esp
  800653:	eb 1a                	jmp    80066f <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800655:	83 ec 08             	sub    $0x8,%esp
  800658:	ff 75 0c             	pushl  0xc(%ebp)
  80065b:	ff 75 20             	pushl  0x20(%ebp)
  80065e:	8b 45 08             	mov    0x8(%ebp),%eax
  800661:	ff d0                	call   *%eax
  800663:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800666:	ff 4d 1c             	decl   0x1c(%ebp)
  800669:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80066d:	7f e6                	jg     800655 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  80066f:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800672:	bb 00 00 00 00       	mov    $0x0,%ebx
  800677:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80067d:	53                   	push   %ebx
  80067e:	51                   	push   %ecx
  80067f:	52                   	push   %edx
  800680:	50                   	push   %eax
  800681:	e8 ca 16 00 00       	call   801d50 <__umoddi3>
  800686:	83 c4 10             	add    $0x10,%esp
  800689:	05 14 24 80 00       	add    $0x802414,%eax
  80068e:	8a 00                	mov    (%eax),%al
  800690:	0f be c0             	movsbl %al,%eax
  800693:	83 ec 08             	sub    $0x8,%esp
  800696:	ff 75 0c             	pushl  0xc(%ebp)
  800699:	50                   	push   %eax
  80069a:	8b 45 08             	mov    0x8(%ebp),%eax
  80069d:	ff d0                	call   *%eax
  80069f:	83 c4 10             	add    $0x10,%esp
}
  8006a2:	90                   	nop
  8006a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8006a6:	c9                   	leave  
  8006a7:	c3                   	ret    

008006a8 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  8006a8:	55                   	push   %ebp
  8006a9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8006ab:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8006af:	7e 1c                	jle    8006cd <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  8006b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b4:	8b 00                	mov    (%eax),%eax
  8006b6:	8d 50 08             	lea    0x8(%eax),%edx
  8006b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006bc:	89 10                	mov    %edx,(%eax)
  8006be:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c1:	8b 00                	mov    (%eax),%eax
  8006c3:	83 e8 08             	sub    $0x8,%eax
  8006c6:	8b 50 04             	mov    0x4(%eax),%edx
  8006c9:	8b 00                	mov    (%eax),%eax
  8006cb:	eb 40                	jmp    80070d <getuint+0x65>
	else if (lflag)
  8006cd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006d1:	74 1e                	je     8006f1 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  8006d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d6:	8b 00                	mov    (%eax),%eax
  8006d8:	8d 50 04             	lea    0x4(%eax),%edx
  8006db:	8b 45 08             	mov    0x8(%ebp),%eax
  8006de:	89 10                	mov    %edx,(%eax)
  8006e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006e3:	8b 00                	mov    (%eax),%eax
  8006e5:	83 e8 04             	sub    $0x4,%eax
  8006e8:	8b 00                	mov    (%eax),%eax
  8006ea:	ba 00 00 00 00       	mov    $0x0,%edx
  8006ef:	eb 1c                	jmp    80070d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8006f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f4:	8b 00                	mov    (%eax),%eax
  8006f6:	8d 50 04             	lea    0x4(%eax),%edx
  8006f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8006fc:	89 10                	mov    %edx,(%eax)
  8006fe:	8b 45 08             	mov    0x8(%ebp),%eax
  800701:	8b 00                	mov    (%eax),%eax
  800703:	83 e8 04             	sub    $0x4,%eax
  800706:	8b 00                	mov    (%eax),%eax
  800708:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80070d:	5d                   	pop    %ebp
  80070e:	c3                   	ret    

0080070f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80070f:	55                   	push   %ebp
  800710:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800712:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800716:	7e 1c                	jle    800734 <getint+0x25>
		return va_arg(*ap, long long);
  800718:	8b 45 08             	mov    0x8(%ebp),%eax
  80071b:	8b 00                	mov    (%eax),%eax
  80071d:	8d 50 08             	lea    0x8(%eax),%edx
  800720:	8b 45 08             	mov    0x8(%ebp),%eax
  800723:	89 10                	mov    %edx,(%eax)
  800725:	8b 45 08             	mov    0x8(%ebp),%eax
  800728:	8b 00                	mov    (%eax),%eax
  80072a:	83 e8 08             	sub    $0x8,%eax
  80072d:	8b 50 04             	mov    0x4(%eax),%edx
  800730:	8b 00                	mov    (%eax),%eax
  800732:	eb 38                	jmp    80076c <getint+0x5d>
	else if (lflag)
  800734:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800738:	74 1a                	je     800754 <getint+0x45>
		return va_arg(*ap, long);
  80073a:	8b 45 08             	mov    0x8(%ebp),%eax
  80073d:	8b 00                	mov    (%eax),%eax
  80073f:	8d 50 04             	lea    0x4(%eax),%edx
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	89 10                	mov    %edx,(%eax)
  800747:	8b 45 08             	mov    0x8(%ebp),%eax
  80074a:	8b 00                	mov    (%eax),%eax
  80074c:	83 e8 04             	sub    $0x4,%eax
  80074f:	8b 00                	mov    (%eax),%eax
  800751:	99                   	cltd   
  800752:	eb 18                	jmp    80076c <getint+0x5d>
	else
		return va_arg(*ap, int);
  800754:	8b 45 08             	mov    0x8(%ebp),%eax
  800757:	8b 00                	mov    (%eax),%eax
  800759:	8d 50 04             	lea    0x4(%eax),%edx
  80075c:	8b 45 08             	mov    0x8(%ebp),%eax
  80075f:	89 10                	mov    %edx,(%eax)
  800761:	8b 45 08             	mov    0x8(%ebp),%eax
  800764:	8b 00                	mov    (%eax),%eax
  800766:	83 e8 04             	sub    $0x4,%eax
  800769:	8b 00                	mov    (%eax),%eax
  80076b:	99                   	cltd   
}
  80076c:	5d                   	pop    %ebp
  80076d:	c3                   	ret    

0080076e <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80076e:	55                   	push   %ebp
  80076f:	89 e5                	mov    %esp,%ebp
  800771:	56                   	push   %esi
  800772:	53                   	push   %ebx
  800773:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800776:	eb 17                	jmp    80078f <vprintfmt+0x21>
			if (ch == '\0')
  800778:	85 db                	test   %ebx,%ebx
  80077a:	0f 84 af 03 00 00    	je     800b2f <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800780:	83 ec 08             	sub    $0x8,%esp
  800783:	ff 75 0c             	pushl  0xc(%ebp)
  800786:	53                   	push   %ebx
  800787:	8b 45 08             	mov    0x8(%ebp),%eax
  80078a:	ff d0                	call   *%eax
  80078c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80078f:	8b 45 10             	mov    0x10(%ebp),%eax
  800792:	8d 50 01             	lea    0x1(%eax),%edx
  800795:	89 55 10             	mov    %edx,0x10(%ebp)
  800798:	8a 00                	mov    (%eax),%al
  80079a:	0f b6 d8             	movzbl %al,%ebx
  80079d:	83 fb 25             	cmp    $0x25,%ebx
  8007a0:	75 d6                	jne    800778 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  8007a2:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  8007a6:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  8007ad:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  8007b4:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  8007bb:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  8007c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8007c5:	8d 50 01             	lea    0x1(%eax),%edx
  8007c8:	89 55 10             	mov    %edx,0x10(%ebp)
  8007cb:	8a 00                	mov    (%eax),%al
  8007cd:	0f b6 d8             	movzbl %al,%ebx
  8007d0:	8d 43 dd             	lea    -0x23(%ebx),%eax
  8007d3:	83 f8 55             	cmp    $0x55,%eax
  8007d6:	0f 87 2b 03 00 00    	ja     800b07 <vprintfmt+0x399>
  8007dc:	8b 04 85 38 24 80 00 	mov    0x802438(,%eax,4),%eax
  8007e3:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8007e5:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8007e9:	eb d7                	jmp    8007c2 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8007eb:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8007ef:	eb d1                	jmp    8007c2 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8007f1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8007f8:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8007fb:	89 d0                	mov    %edx,%eax
  8007fd:	c1 e0 02             	shl    $0x2,%eax
  800800:	01 d0                	add    %edx,%eax
  800802:	01 c0                	add    %eax,%eax
  800804:	01 d8                	add    %ebx,%eax
  800806:	83 e8 30             	sub    $0x30,%eax
  800809:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80080c:	8b 45 10             	mov    0x10(%ebp),%eax
  80080f:	8a 00                	mov    (%eax),%al
  800811:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800814:	83 fb 2f             	cmp    $0x2f,%ebx
  800817:	7e 3e                	jle    800857 <vprintfmt+0xe9>
  800819:	83 fb 39             	cmp    $0x39,%ebx
  80081c:	7f 39                	jg     800857 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80081e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800821:	eb d5                	jmp    8007f8 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800823:	8b 45 14             	mov    0x14(%ebp),%eax
  800826:	83 c0 04             	add    $0x4,%eax
  800829:	89 45 14             	mov    %eax,0x14(%ebp)
  80082c:	8b 45 14             	mov    0x14(%ebp),%eax
  80082f:	83 e8 04             	sub    $0x4,%eax
  800832:	8b 00                	mov    (%eax),%eax
  800834:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800837:	eb 1f                	jmp    800858 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800839:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80083d:	79 83                	jns    8007c2 <vprintfmt+0x54>
				width = 0;
  80083f:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800846:	e9 77 ff ff ff       	jmp    8007c2 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  80084b:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800852:	e9 6b ff ff ff       	jmp    8007c2 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800857:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800858:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80085c:	0f 89 60 ff ff ff    	jns    8007c2 <vprintfmt+0x54>
				width = precision, precision = -1;
  800862:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800865:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800868:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  80086f:	e9 4e ff ff ff       	jmp    8007c2 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800874:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800877:	e9 46 ff ff ff       	jmp    8007c2 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  80087c:	8b 45 14             	mov    0x14(%ebp),%eax
  80087f:	83 c0 04             	add    $0x4,%eax
  800882:	89 45 14             	mov    %eax,0x14(%ebp)
  800885:	8b 45 14             	mov    0x14(%ebp),%eax
  800888:	83 e8 04             	sub    $0x4,%eax
  80088b:	8b 00                	mov    (%eax),%eax
  80088d:	83 ec 08             	sub    $0x8,%esp
  800890:	ff 75 0c             	pushl  0xc(%ebp)
  800893:	50                   	push   %eax
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	ff d0                	call   *%eax
  800899:	83 c4 10             	add    $0x10,%esp
			break;
  80089c:	e9 89 02 00 00       	jmp    800b2a <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  8008a1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008a4:	83 c0 04             	add    $0x4,%eax
  8008a7:	89 45 14             	mov    %eax,0x14(%ebp)
  8008aa:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ad:	83 e8 04             	sub    $0x4,%eax
  8008b0:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  8008b2:	85 db                	test   %ebx,%ebx
  8008b4:	79 02                	jns    8008b8 <vprintfmt+0x14a>
				err = -err;
  8008b6:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  8008b8:	83 fb 64             	cmp    $0x64,%ebx
  8008bb:	7f 0b                	jg     8008c8 <vprintfmt+0x15a>
  8008bd:	8b 34 9d 80 22 80 00 	mov    0x802280(,%ebx,4),%esi
  8008c4:	85 f6                	test   %esi,%esi
  8008c6:	75 19                	jne    8008e1 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  8008c8:	53                   	push   %ebx
  8008c9:	68 25 24 80 00       	push   $0x802425
  8008ce:	ff 75 0c             	pushl  0xc(%ebp)
  8008d1:	ff 75 08             	pushl  0x8(%ebp)
  8008d4:	e8 5e 02 00 00       	call   800b37 <printfmt>
  8008d9:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8008dc:	e9 49 02 00 00       	jmp    800b2a <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8008e1:	56                   	push   %esi
  8008e2:	68 2e 24 80 00       	push   $0x80242e
  8008e7:	ff 75 0c             	pushl  0xc(%ebp)
  8008ea:	ff 75 08             	pushl  0x8(%ebp)
  8008ed:	e8 45 02 00 00       	call   800b37 <printfmt>
  8008f2:	83 c4 10             	add    $0x10,%esp
			break;
  8008f5:	e9 30 02 00 00       	jmp    800b2a <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8008fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8008fd:	83 c0 04             	add    $0x4,%eax
  800900:	89 45 14             	mov    %eax,0x14(%ebp)
  800903:	8b 45 14             	mov    0x14(%ebp),%eax
  800906:	83 e8 04             	sub    $0x4,%eax
  800909:	8b 30                	mov    (%eax),%esi
  80090b:	85 f6                	test   %esi,%esi
  80090d:	75 05                	jne    800914 <vprintfmt+0x1a6>
				p = "(null)";
  80090f:	be 31 24 80 00       	mov    $0x802431,%esi
			if (width > 0 && padc != '-')
  800914:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800918:	7e 6d                	jle    800987 <vprintfmt+0x219>
  80091a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  80091e:	74 67                	je     800987 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800920:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800923:	83 ec 08             	sub    $0x8,%esp
  800926:	50                   	push   %eax
  800927:	56                   	push   %esi
  800928:	e8 12 05 00 00       	call   800e3f <strnlen>
  80092d:	83 c4 10             	add    $0x10,%esp
  800930:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800933:	eb 16                	jmp    80094b <vprintfmt+0x1dd>
					putch(padc, putdat);
  800935:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800939:	83 ec 08             	sub    $0x8,%esp
  80093c:	ff 75 0c             	pushl  0xc(%ebp)
  80093f:	50                   	push   %eax
  800940:	8b 45 08             	mov    0x8(%ebp),%eax
  800943:	ff d0                	call   *%eax
  800945:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800948:	ff 4d e4             	decl   -0x1c(%ebp)
  80094b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80094f:	7f e4                	jg     800935 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800951:	eb 34                	jmp    800987 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800953:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800957:	74 1c                	je     800975 <vprintfmt+0x207>
  800959:	83 fb 1f             	cmp    $0x1f,%ebx
  80095c:	7e 05                	jle    800963 <vprintfmt+0x1f5>
  80095e:	83 fb 7e             	cmp    $0x7e,%ebx
  800961:	7e 12                	jle    800975 <vprintfmt+0x207>
					putch('?', putdat);
  800963:	83 ec 08             	sub    $0x8,%esp
  800966:	ff 75 0c             	pushl  0xc(%ebp)
  800969:	6a 3f                	push   $0x3f
  80096b:	8b 45 08             	mov    0x8(%ebp),%eax
  80096e:	ff d0                	call   *%eax
  800970:	83 c4 10             	add    $0x10,%esp
  800973:	eb 0f                	jmp    800984 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800975:	83 ec 08             	sub    $0x8,%esp
  800978:	ff 75 0c             	pushl  0xc(%ebp)
  80097b:	53                   	push   %ebx
  80097c:	8b 45 08             	mov    0x8(%ebp),%eax
  80097f:	ff d0                	call   *%eax
  800981:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800984:	ff 4d e4             	decl   -0x1c(%ebp)
  800987:	89 f0                	mov    %esi,%eax
  800989:	8d 70 01             	lea    0x1(%eax),%esi
  80098c:	8a 00                	mov    (%eax),%al
  80098e:	0f be d8             	movsbl %al,%ebx
  800991:	85 db                	test   %ebx,%ebx
  800993:	74 24                	je     8009b9 <vprintfmt+0x24b>
  800995:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800999:	78 b8                	js     800953 <vprintfmt+0x1e5>
  80099b:	ff 4d e0             	decl   -0x20(%ebp)
  80099e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009a2:	79 af                	jns    800953 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009a4:	eb 13                	jmp    8009b9 <vprintfmt+0x24b>
				putch(' ', putdat);
  8009a6:	83 ec 08             	sub    $0x8,%esp
  8009a9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ac:	6a 20                	push   $0x20
  8009ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8009b1:	ff d0                	call   *%eax
  8009b3:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  8009b6:	ff 4d e4             	decl   -0x1c(%ebp)
  8009b9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009bd:	7f e7                	jg     8009a6 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  8009bf:	e9 66 01 00 00       	jmp    800b2a <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  8009c4:	83 ec 08             	sub    $0x8,%esp
  8009c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8009ca:	8d 45 14             	lea    0x14(%ebp),%eax
  8009cd:	50                   	push   %eax
  8009ce:	e8 3c fd ff ff       	call   80070f <getint>
  8009d3:	83 c4 10             	add    $0x10,%esp
  8009d6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8009d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8009dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009e2:	85 d2                	test   %edx,%edx
  8009e4:	79 23                	jns    800a09 <vprintfmt+0x29b>
				putch('-', putdat);
  8009e6:	83 ec 08             	sub    $0x8,%esp
  8009e9:	ff 75 0c             	pushl  0xc(%ebp)
  8009ec:	6a 2d                	push   $0x2d
  8009ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f1:	ff d0                	call   *%eax
  8009f3:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8009f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8009fc:	f7 d8                	neg    %eax
  8009fe:	83 d2 00             	adc    $0x0,%edx
  800a01:	f7 da                	neg    %edx
  800a03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a06:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a09:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a10:	e9 bc 00 00 00       	jmp    800ad1 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a15:	83 ec 08             	sub    $0x8,%esp
  800a18:	ff 75 e8             	pushl  -0x18(%ebp)
  800a1b:	8d 45 14             	lea    0x14(%ebp),%eax
  800a1e:	50                   	push   %eax
  800a1f:	e8 84 fc ff ff       	call   8006a8 <getuint>
  800a24:	83 c4 10             	add    $0x10,%esp
  800a27:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a2a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a2d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a34:	e9 98 00 00 00       	jmp    800ad1 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a39:	83 ec 08             	sub    $0x8,%esp
  800a3c:	ff 75 0c             	pushl  0xc(%ebp)
  800a3f:	6a 58                	push   $0x58
  800a41:	8b 45 08             	mov    0x8(%ebp),%eax
  800a44:	ff d0                	call   *%eax
  800a46:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a49:	83 ec 08             	sub    $0x8,%esp
  800a4c:	ff 75 0c             	pushl  0xc(%ebp)
  800a4f:	6a 58                	push   $0x58
  800a51:	8b 45 08             	mov    0x8(%ebp),%eax
  800a54:	ff d0                	call   *%eax
  800a56:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800a59:	83 ec 08             	sub    $0x8,%esp
  800a5c:	ff 75 0c             	pushl  0xc(%ebp)
  800a5f:	6a 58                	push   $0x58
  800a61:	8b 45 08             	mov    0x8(%ebp),%eax
  800a64:	ff d0                	call   *%eax
  800a66:	83 c4 10             	add    $0x10,%esp
			break;
  800a69:	e9 bc 00 00 00       	jmp    800b2a <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800a6e:	83 ec 08             	sub    $0x8,%esp
  800a71:	ff 75 0c             	pushl  0xc(%ebp)
  800a74:	6a 30                	push   $0x30
  800a76:	8b 45 08             	mov    0x8(%ebp),%eax
  800a79:	ff d0                	call   *%eax
  800a7b:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800a7e:	83 ec 08             	sub    $0x8,%esp
  800a81:	ff 75 0c             	pushl  0xc(%ebp)
  800a84:	6a 78                	push   $0x78
  800a86:	8b 45 08             	mov    0x8(%ebp),%eax
  800a89:	ff d0                	call   *%eax
  800a8b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800a8e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a91:	83 c0 04             	add    $0x4,%eax
  800a94:	89 45 14             	mov    %eax,0x14(%ebp)
  800a97:	8b 45 14             	mov    0x14(%ebp),%eax
  800a9a:	83 e8 04             	sub    $0x4,%eax
  800a9d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a9f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800aa2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800aa9:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ab0:	eb 1f                	jmp    800ad1 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ab2:	83 ec 08             	sub    $0x8,%esp
  800ab5:	ff 75 e8             	pushl  -0x18(%ebp)
  800ab8:	8d 45 14             	lea    0x14(%ebp),%eax
  800abb:	50                   	push   %eax
  800abc:	e8 e7 fb ff ff       	call   8006a8 <getuint>
  800ac1:	83 c4 10             	add    $0x10,%esp
  800ac4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800aca:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ad1:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ad5:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ad8:	83 ec 04             	sub    $0x4,%esp
  800adb:	52                   	push   %edx
  800adc:	ff 75 e4             	pushl  -0x1c(%ebp)
  800adf:	50                   	push   %eax
  800ae0:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae3:	ff 75 f0             	pushl  -0x10(%ebp)
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	ff 75 08             	pushl  0x8(%ebp)
  800aec:	e8 00 fb ff ff       	call   8005f1 <printnum>
  800af1:	83 c4 20             	add    $0x20,%esp
			break;
  800af4:	eb 34                	jmp    800b2a <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800af6:	83 ec 08             	sub    $0x8,%esp
  800af9:	ff 75 0c             	pushl  0xc(%ebp)
  800afc:	53                   	push   %ebx
  800afd:	8b 45 08             	mov    0x8(%ebp),%eax
  800b00:	ff d0                	call   *%eax
  800b02:	83 c4 10             	add    $0x10,%esp
			break;
  800b05:	eb 23                	jmp    800b2a <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b07:	83 ec 08             	sub    $0x8,%esp
  800b0a:	ff 75 0c             	pushl  0xc(%ebp)
  800b0d:	6a 25                	push   $0x25
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	ff d0                	call   *%eax
  800b14:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b17:	ff 4d 10             	decl   0x10(%ebp)
  800b1a:	eb 03                	jmp    800b1f <vprintfmt+0x3b1>
  800b1c:	ff 4d 10             	decl   0x10(%ebp)
  800b1f:	8b 45 10             	mov    0x10(%ebp),%eax
  800b22:	48                   	dec    %eax
  800b23:	8a 00                	mov    (%eax),%al
  800b25:	3c 25                	cmp    $0x25,%al
  800b27:	75 f3                	jne    800b1c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b29:	90                   	nop
		}
	}
  800b2a:	e9 47 fc ff ff       	jmp    800776 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b2f:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b30:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b33:	5b                   	pop    %ebx
  800b34:	5e                   	pop    %esi
  800b35:	5d                   	pop    %ebp
  800b36:	c3                   	ret    

00800b37 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b37:	55                   	push   %ebp
  800b38:	89 e5                	mov    %esp,%ebp
  800b3a:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800b3d:	8d 45 10             	lea    0x10(%ebp),%eax
  800b40:	83 c0 04             	add    $0x4,%eax
  800b43:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800b46:	8b 45 10             	mov    0x10(%ebp),%eax
  800b49:	ff 75 f4             	pushl  -0xc(%ebp)
  800b4c:	50                   	push   %eax
  800b4d:	ff 75 0c             	pushl  0xc(%ebp)
  800b50:	ff 75 08             	pushl  0x8(%ebp)
  800b53:	e8 16 fc ff ff       	call   80076e <vprintfmt>
  800b58:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800b5b:	90                   	nop
  800b5c:	c9                   	leave  
  800b5d:	c3                   	ret    

00800b5e <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800b5e:	55                   	push   %ebp
  800b5f:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800b61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b64:	8b 40 08             	mov    0x8(%eax),%eax
  800b67:	8d 50 01             	lea    0x1(%eax),%edx
  800b6a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b6d:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800b70:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b73:	8b 10                	mov    (%eax),%edx
  800b75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b78:	8b 40 04             	mov    0x4(%eax),%eax
  800b7b:	39 c2                	cmp    %eax,%edx
  800b7d:	73 12                	jae    800b91 <sprintputch+0x33>
		*b->buf++ = ch;
  800b7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	8d 48 01             	lea    0x1(%eax),%ecx
  800b87:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b8a:	89 0a                	mov    %ecx,(%edx)
  800b8c:	8b 55 08             	mov    0x8(%ebp),%edx
  800b8f:	88 10                	mov    %dl,(%eax)
}
  800b91:	90                   	nop
  800b92:	5d                   	pop    %ebp
  800b93:	c3                   	ret    

00800b94 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800b94:	55                   	push   %ebp
  800b95:	89 e5                	mov    %esp,%ebp
  800b97:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800ba0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba3:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ba6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba9:	01 d0                	add    %edx,%eax
  800bab:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bae:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800bb5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800bb9:	74 06                	je     800bc1 <vsnprintf+0x2d>
  800bbb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bbf:	7f 07                	jg     800bc8 <vsnprintf+0x34>
		return -E_INVAL;
  800bc1:	b8 03 00 00 00       	mov    $0x3,%eax
  800bc6:	eb 20                	jmp    800be8 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800bc8:	ff 75 14             	pushl  0x14(%ebp)
  800bcb:	ff 75 10             	pushl  0x10(%ebp)
  800bce:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800bd1:	50                   	push   %eax
  800bd2:	68 5e 0b 80 00       	push   $0x800b5e
  800bd7:	e8 92 fb ff ff       	call   80076e <vprintfmt>
  800bdc:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800bdf:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800be2:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800be5:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800be8:	c9                   	leave  
  800be9:	c3                   	ret    

00800bea <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800bea:	55                   	push   %ebp
  800beb:	89 e5                	mov    %esp,%ebp
  800bed:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800bf0:	8d 45 10             	lea    0x10(%ebp),%eax
  800bf3:	83 c0 04             	add    $0x4,%eax
  800bf6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800bf9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfc:	ff 75 f4             	pushl  -0xc(%ebp)
  800bff:	50                   	push   %eax
  800c00:	ff 75 0c             	pushl  0xc(%ebp)
  800c03:	ff 75 08             	pushl  0x8(%ebp)
  800c06:	e8 89 ff ff ff       	call   800b94 <vsnprintf>
  800c0b:	83 c4 10             	add    $0x10,%esp
  800c0e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c11:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c14:	c9                   	leave  
  800c15:	c3                   	ret    

00800c16 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  800c16:	55                   	push   %ebp
  800c17:	89 e5                	mov    %esp,%ebp
  800c19:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  800c1c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c20:	74 13                	je     800c35 <readline+0x1f>
		cprintf("%s", prompt);
  800c22:	83 ec 08             	sub    $0x8,%esp
  800c25:	ff 75 08             	pushl  0x8(%ebp)
  800c28:	68 90 25 80 00       	push   $0x802590
  800c2d:	e8 62 f9 ff ff       	call   800594 <cprintf>
  800c32:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800c35:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800c3c:	83 ec 0c             	sub    $0xc,%esp
  800c3f:	6a 00                	push   $0x0
  800c41:	e8 ed 0f 00 00       	call   801c33 <iscons>
  800c46:	83 c4 10             	add    $0x10,%esp
  800c49:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800c4c:	e8 94 0f 00 00       	call   801be5 <getchar>
  800c51:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800c54:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800c58:	79 22                	jns    800c7c <readline+0x66>
			if (c != -E_EOF)
  800c5a:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800c5e:	0f 84 ad 00 00 00    	je     800d11 <readline+0xfb>
				cprintf("read error: %e\n", c);
  800c64:	83 ec 08             	sub    $0x8,%esp
  800c67:	ff 75 ec             	pushl  -0x14(%ebp)
  800c6a:	68 93 25 80 00       	push   $0x802593
  800c6f:	e8 20 f9 ff ff       	call   800594 <cprintf>
  800c74:	83 c4 10             	add    $0x10,%esp
			return;
  800c77:	e9 95 00 00 00       	jmp    800d11 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800c7c:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800c80:	7e 34                	jle    800cb6 <readline+0xa0>
  800c82:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800c89:	7f 2b                	jg     800cb6 <readline+0xa0>
			if (echoing)
  800c8b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800c8f:	74 0e                	je     800c9f <readline+0x89>
				cputchar(c);
  800c91:	83 ec 0c             	sub    $0xc,%esp
  800c94:	ff 75 ec             	pushl  -0x14(%ebp)
  800c97:	e8 01 0f 00 00       	call   801b9d <cputchar>
  800c9c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800c9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ca2:	8d 50 01             	lea    0x1(%eax),%edx
  800ca5:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800ca8:	89 c2                	mov    %eax,%edx
  800caa:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cad:	01 d0                	add    %edx,%eax
  800caf:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800cb2:	88 10                	mov    %dl,(%eax)
  800cb4:	eb 56                	jmp    800d0c <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  800cb6:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800cba:	75 1f                	jne    800cdb <readline+0xc5>
  800cbc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800cc0:	7e 19                	jle    800cdb <readline+0xc5>
			if (echoing)
  800cc2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800cc6:	74 0e                	je     800cd6 <readline+0xc0>
				cputchar(c);
  800cc8:	83 ec 0c             	sub    $0xc,%esp
  800ccb:	ff 75 ec             	pushl  -0x14(%ebp)
  800cce:	e8 ca 0e 00 00       	call   801b9d <cputchar>
  800cd3:	83 c4 10             	add    $0x10,%esp

			i--;
  800cd6:	ff 4d f4             	decl   -0xc(%ebp)
  800cd9:	eb 31                	jmp    800d0c <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  800cdb:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800cdf:	74 0a                	je     800ceb <readline+0xd5>
  800ce1:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800ce5:	0f 85 61 ff ff ff    	jne    800c4c <readline+0x36>
			if (echoing)
  800ceb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800cef:	74 0e                	je     800cff <readline+0xe9>
				cputchar(c);
  800cf1:	83 ec 0c             	sub    $0xc,%esp
  800cf4:	ff 75 ec             	pushl  -0x14(%ebp)
  800cf7:	e8 a1 0e 00 00       	call   801b9d <cputchar>
  800cfc:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  800cff:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d02:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d05:	01 d0                	add    %edx,%eax
  800d07:	c6 00 00             	movb   $0x0,(%eax)
			return;
  800d0a:	eb 06                	jmp    800d12 <readline+0xfc>
		}
	}
  800d0c:	e9 3b ff ff ff       	jmp    800c4c <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  800d11:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  800d12:	c9                   	leave  
  800d13:	c3                   	ret    

00800d14 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  800d14:	55                   	push   %ebp
  800d15:	89 e5                	mov    %esp,%ebp
  800d17:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800d1a:	e8 41 0a 00 00       	call   801760 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  800d1f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d23:	74 13                	je     800d38 <atomic_readline+0x24>
		cprintf("%s", prompt);
  800d25:	83 ec 08             	sub    $0x8,%esp
  800d28:	ff 75 08             	pushl  0x8(%ebp)
  800d2b:	68 90 25 80 00       	push   $0x802590
  800d30:	e8 5f f8 ff ff       	call   800594 <cprintf>
  800d35:	83 c4 10             	add    $0x10,%esp

	i = 0;
  800d38:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  800d3f:	83 ec 0c             	sub    $0xc,%esp
  800d42:	6a 00                	push   $0x0
  800d44:	e8 ea 0e 00 00       	call   801c33 <iscons>
  800d49:	83 c4 10             	add    $0x10,%esp
  800d4c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  800d4f:	e8 91 0e 00 00       	call   801be5 <getchar>
  800d54:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  800d57:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800d5b:	79 23                	jns    800d80 <atomic_readline+0x6c>
			if (c != -E_EOF)
  800d5d:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  800d61:	74 13                	je     800d76 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  800d63:	83 ec 08             	sub    $0x8,%esp
  800d66:	ff 75 ec             	pushl  -0x14(%ebp)
  800d69:	68 93 25 80 00       	push   $0x802593
  800d6e:	e8 21 f8 ff ff       	call   800594 <cprintf>
  800d73:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800d76:	e8 ff 09 00 00       	call   80177a <sys_enable_interrupt>
			return;
  800d7b:	e9 9a 00 00 00       	jmp    800e1a <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  800d80:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  800d84:	7e 34                	jle    800dba <atomic_readline+0xa6>
  800d86:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  800d8d:	7f 2b                	jg     800dba <atomic_readline+0xa6>
			if (echoing)
  800d8f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800d93:	74 0e                	je     800da3 <atomic_readline+0x8f>
				cputchar(c);
  800d95:	83 ec 0c             	sub    $0xc,%esp
  800d98:	ff 75 ec             	pushl  -0x14(%ebp)
  800d9b:	e8 fd 0d 00 00       	call   801b9d <cputchar>
  800da0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  800da3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800da6:	8d 50 01             	lea    0x1(%eax),%edx
  800da9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800dac:	89 c2                	mov    %eax,%edx
  800dae:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db1:	01 d0                	add    %edx,%eax
  800db3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800db6:	88 10                	mov    %dl,(%eax)
  800db8:	eb 5b                	jmp    800e15 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  800dba:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  800dbe:	75 1f                	jne    800ddf <atomic_readline+0xcb>
  800dc0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800dc4:	7e 19                	jle    800ddf <atomic_readline+0xcb>
			if (echoing)
  800dc6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800dca:	74 0e                	je     800dda <atomic_readline+0xc6>
				cputchar(c);
  800dcc:	83 ec 0c             	sub    $0xc,%esp
  800dcf:	ff 75 ec             	pushl  -0x14(%ebp)
  800dd2:	e8 c6 0d 00 00       	call   801b9d <cputchar>
  800dd7:	83 c4 10             	add    $0x10,%esp
			i--;
  800dda:	ff 4d f4             	decl   -0xc(%ebp)
  800ddd:	eb 36                	jmp    800e15 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  800ddf:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  800de3:	74 0a                	je     800def <atomic_readline+0xdb>
  800de5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  800de9:	0f 85 60 ff ff ff    	jne    800d4f <atomic_readline+0x3b>
			if (echoing)
  800def:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  800df3:	74 0e                	je     800e03 <atomic_readline+0xef>
				cputchar(c);
  800df5:	83 ec 0c             	sub    $0xc,%esp
  800df8:	ff 75 ec             	pushl  -0x14(%ebp)
  800dfb:	e8 9d 0d 00 00       	call   801b9d <cputchar>
  800e00:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  800e03:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e06:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e09:	01 d0                	add    %edx,%eax
  800e0b:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  800e0e:	e8 67 09 00 00       	call   80177a <sys_enable_interrupt>
			return;
  800e13:	eb 05                	jmp    800e1a <atomic_readline+0x106>
		}
	}
  800e15:	e9 35 ff ff ff       	jmp    800d4f <atomic_readline+0x3b>
}
  800e1a:	c9                   	leave  
  800e1b:	c3                   	ret    

00800e1c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800e1c:	55                   	push   %ebp
  800e1d:	89 e5                	mov    %esp,%ebp
  800e1f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800e22:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e29:	eb 06                	jmp    800e31 <strlen+0x15>
		n++;
  800e2b:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800e2e:	ff 45 08             	incl   0x8(%ebp)
  800e31:	8b 45 08             	mov    0x8(%ebp),%eax
  800e34:	8a 00                	mov    (%eax),%al
  800e36:	84 c0                	test   %al,%al
  800e38:	75 f1                	jne    800e2b <strlen+0xf>
		n++;
	return n;
  800e3a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e3d:	c9                   	leave  
  800e3e:	c3                   	ret    

00800e3f <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800e3f:	55                   	push   %ebp
  800e40:	89 e5                	mov    %esp,%ebp
  800e42:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e4c:	eb 09                	jmp    800e57 <strnlen+0x18>
		n++;
  800e4e:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e51:	ff 45 08             	incl   0x8(%ebp)
  800e54:	ff 4d 0c             	decl   0xc(%ebp)
  800e57:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e5b:	74 09                	je     800e66 <strnlen+0x27>
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	8a 00                	mov    (%eax),%al
  800e62:	84 c0                	test   %al,%al
  800e64:	75 e8                	jne    800e4e <strnlen+0xf>
		n++;
	return n;
  800e66:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e69:	c9                   	leave  
  800e6a:	c3                   	ret    

00800e6b <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e6b:	55                   	push   %ebp
  800e6c:	89 e5                	mov    %esp,%ebp
  800e6e:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e71:	8b 45 08             	mov    0x8(%ebp),%eax
  800e74:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e77:	90                   	nop
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	8d 50 01             	lea    0x1(%eax),%edx
  800e7e:	89 55 08             	mov    %edx,0x8(%ebp)
  800e81:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e84:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e87:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e8a:	8a 12                	mov    (%edx),%dl
  800e8c:	88 10                	mov    %dl,(%eax)
  800e8e:	8a 00                	mov    (%eax),%al
  800e90:	84 c0                	test   %al,%al
  800e92:	75 e4                	jne    800e78 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e94:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e97:	c9                   	leave  
  800e98:	c3                   	ret    

00800e99 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e99:	55                   	push   %ebp
  800e9a:	89 e5                	mov    %esp,%ebp
  800e9c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea2:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800ea5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800eac:	eb 1f                	jmp    800ecd <strncpy+0x34>
		*dst++ = *src;
  800eae:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb1:	8d 50 01             	lea    0x1(%eax),%edx
  800eb4:	89 55 08             	mov    %edx,0x8(%ebp)
  800eb7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eba:	8a 12                	mov    (%edx),%dl
  800ebc:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800ebe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec1:	8a 00                	mov    (%eax),%al
  800ec3:	84 c0                	test   %al,%al
  800ec5:	74 03                	je     800eca <strncpy+0x31>
			src++;
  800ec7:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800eca:	ff 45 fc             	incl   -0x4(%ebp)
  800ecd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ed0:	3b 45 10             	cmp    0x10(%ebp),%eax
  800ed3:	72 d9                	jb     800eae <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800ed5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800ed8:	c9                   	leave  
  800ed9:	c3                   	ret    

00800eda <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800eda:	55                   	push   %ebp
  800edb:	89 e5                	mov    %esp,%ebp
  800edd:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ee6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eea:	74 30                	je     800f1c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800eec:	eb 16                	jmp    800f04 <strlcpy+0x2a>
			*dst++ = *src++;
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8d 50 01             	lea    0x1(%eax),%edx
  800ef4:	89 55 08             	mov    %edx,0x8(%ebp)
  800ef7:	8b 55 0c             	mov    0xc(%ebp),%edx
  800efa:	8d 4a 01             	lea    0x1(%edx),%ecx
  800efd:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800f00:	8a 12                	mov    (%edx),%dl
  800f02:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800f04:	ff 4d 10             	decl   0x10(%ebp)
  800f07:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f0b:	74 09                	je     800f16 <strlcpy+0x3c>
  800f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	84 c0                	test   %al,%al
  800f14:	75 d8                	jne    800eee <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800f16:	8b 45 08             	mov    0x8(%ebp),%eax
  800f19:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800f1c:	8b 55 08             	mov    0x8(%ebp),%edx
  800f1f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f22:	29 c2                	sub    %eax,%edx
  800f24:	89 d0                	mov    %edx,%eax
}
  800f26:	c9                   	leave  
  800f27:	c3                   	ret    

00800f28 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800f28:	55                   	push   %ebp
  800f29:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800f2b:	eb 06                	jmp    800f33 <strcmp+0xb>
		p++, q++;
  800f2d:	ff 45 08             	incl   0x8(%ebp)
  800f30:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800f33:	8b 45 08             	mov    0x8(%ebp),%eax
  800f36:	8a 00                	mov    (%eax),%al
  800f38:	84 c0                	test   %al,%al
  800f3a:	74 0e                	je     800f4a <strcmp+0x22>
  800f3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3f:	8a 10                	mov    (%eax),%dl
  800f41:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f44:	8a 00                	mov    (%eax),%al
  800f46:	38 c2                	cmp    %al,%dl
  800f48:	74 e3                	je     800f2d <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	8a 00                	mov    (%eax),%al
  800f4f:	0f b6 d0             	movzbl %al,%edx
  800f52:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f55:	8a 00                	mov    (%eax),%al
  800f57:	0f b6 c0             	movzbl %al,%eax
  800f5a:	29 c2                	sub    %eax,%edx
  800f5c:	89 d0                	mov    %edx,%eax
}
  800f5e:	5d                   	pop    %ebp
  800f5f:	c3                   	ret    

00800f60 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f60:	55                   	push   %ebp
  800f61:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f63:	eb 09                	jmp    800f6e <strncmp+0xe>
		n--, p++, q++;
  800f65:	ff 4d 10             	decl   0x10(%ebp)
  800f68:	ff 45 08             	incl   0x8(%ebp)
  800f6b:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f6e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f72:	74 17                	je     800f8b <strncmp+0x2b>
  800f74:	8b 45 08             	mov    0x8(%ebp),%eax
  800f77:	8a 00                	mov    (%eax),%al
  800f79:	84 c0                	test   %al,%al
  800f7b:	74 0e                	je     800f8b <strncmp+0x2b>
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	8a 10                	mov    (%eax),%dl
  800f82:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f85:	8a 00                	mov    (%eax),%al
  800f87:	38 c2                	cmp    %al,%dl
  800f89:	74 da                	je     800f65 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f8f:	75 07                	jne    800f98 <strncmp+0x38>
		return 0;
  800f91:	b8 00 00 00 00       	mov    $0x0,%eax
  800f96:	eb 14                	jmp    800fac <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f98:	8b 45 08             	mov    0x8(%ebp),%eax
  800f9b:	8a 00                	mov    (%eax),%al
  800f9d:	0f b6 d0             	movzbl %al,%edx
  800fa0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	0f b6 c0             	movzbl %al,%eax
  800fa8:	29 c2                	sub    %eax,%edx
  800faa:	89 d0                	mov    %edx,%eax
}
  800fac:	5d                   	pop    %ebp
  800fad:	c3                   	ret    

00800fae <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800fae:	55                   	push   %ebp
  800faf:	89 e5                	mov    %esp,%ebp
  800fb1:	83 ec 04             	sub    $0x4,%esp
  800fb4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fba:	eb 12                	jmp    800fce <strchr+0x20>
		if (*s == c)
  800fbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbf:	8a 00                	mov    (%eax),%al
  800fc1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800fc4:	75 05                	jne    800fcb <strchr+0x1d>
			return (char *) s;
  800fc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc9:	eb 11                	jmp    800fdc <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800fcb:	ff 45 08             	incl   0x8(%ebp)
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	84 c0                	test   %al,%al
  800fd5:	75 e5                	jne    800fbc <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800fd7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fdc:	c9                   	leave  
  800fdd:	c3                   	ret    

00800fde <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800fde:	55                   	push   %ebp
  800fdf:	89 e5                	mov    %esp,%ebp
  800fe1:	83 ec 04             	sub    $0x4,%esp
  800fe4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe7:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fea:	eb 0d                	jmp    800ff9 <strfind+0x1b>
		if (*s == c)
  800fec:	8b 45 08             	mov    0x8(%ebp),%eax
  800fef:	8a 00                	mov    (%eax),%al
  800ff1:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800ff4:	74 0e                	je     801004 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800ff6:	ff 45 08             	incl   0x8(%ebp)
  800ff9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ffc:	8a 00                	mov    (%eax),%al
  800ffe:	84 c0                	test   %al,%al
  801000:	75 ea                	jne    800fec <strfind+0xe>
  801002:	eb 01                	jmp    801005 <strfind+0x27>
		if (*s == c)
			break;
  801004:	90                   	nop
	return (char *) s;
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801008:	c9                   	leave  
  801009:	c3                   	ret    

0080100a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80100a:	55                   	push   %ebp
  80100b:	89 e5                	mov    %esp,%ebp
  80100d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801010:	8b 45 08             	mov    0x8(%ebp),%eax
  801013:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801016:	8b 45 10             	mov    0x10(%ebp),%eax
  801019:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80101c:	eb 0e                	jmp    80102c <memset+0x22>
		*p++ = c;
  80101e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801021:	8d 50 01             	lea    0x1(%eax),%edx
  801024:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801027:	8b 55 0c             	mov    0xc(%ebp),%edx
  80102a:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80102c:	ff 4d f8             	decl   -0x8(%ebp)
  80102f:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801033:	79 e9                	jns    80101e <memset+0x14>
		*p++ = c;

	return v;
  801035:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801038:	c9                   	leave  
  801039:	c3                   	ret    

0080103a <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80103a:	55                   	push   %ebp
  80103b:	89 e5                	mov    %esp,%ebp
  80103d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801040:	8b 45 0c             	mov    0xc(%ebp),%eax
  801043:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80104c:	eb 16                	jmp    801064 <memcpy+0x2a>
		*d++ = *s++;
  80104e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801051:	8d 50 01             	lea    0x1(%eax),%edx
  801054:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801057:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80105a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80105d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801060:	8a 12                	mov    (%edx),%dl
  801062:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801064:	8b 45 10             	mov    0x10(%ebp),%eax
  801067:	8d 50 ff             	lea    -0x1(%eax),%edx
  80106a:	89 55 10             	mov    %edx,0x10(%ebp)
  80106d:	85 c0                	test   %eax,%eax
  80106f:	75 dd                	jne    80104e <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801074:	c9                   	leave  
  801075:	c3                   	ret    

00801076 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801076:	55                   	push   %ebp
  801077:	89 e5                	mov    %esp,%ebp
  801079:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80107c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801082:	8b 45 08             	mov    0x8(%ebp),%eax
  801085:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801088:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80108b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80108e:	73 50                	jae    8010e0 <memmove+0x6a>
  801090:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801093:	8b 45 10             	mov    0x10(%ebp),%eax
  801096:	01 d0                	add    %edx,%eax
  801098:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80109b:	76 43                	jbe    8010e0 <memmove+0x6a>
		s += n;
  80109d:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a0:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8010a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a6:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8010a9:	eb 10                	jmp    8010bb <memmove+0x45>
			*--d = *--s;
  8010ab:	ff 4d f8             	decl   -0x8(%ebp)
  8010ae:	ff 4d fc             	decl   -0x4(%ebp)
  8010b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010b4:	8a 10                	mov    (%eax),%dl
  8010b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010b9:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8010bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8010be:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010c1:	89 55 10             	mov    %edx,0x10(%ebp)
  8010c4:	85 c0                	test   %eax,%eax
  8010c6:	75 e3                	jne    8010ab <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8010c8:	eb 23                	jmp    8010ed <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8010ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010cd:	8d 50 01             	lea    0x1(%eax),%edx
  8010d0:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8010d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010d6:	8d 4a 01             	lea    0x1(%edx),%ecx
  8010d9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8010dc:	8a 12                	mov    (%edx),%dl
  8010de:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8010e0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010e3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010e6:	89 55 10             	mov    %edx,0x10(%ebp)
  8010e9:	85 c0                	test   %eax,%eax
  8010eb:	75 dd                	jne    8010ca <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010f0:	c9                   	leave  
  8010f1:	c3                   	ret    

008010f2 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
  8010f5:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  801101:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801104:	eb 2a                	jmp    801130 <memcmp+0x3e>
		if (*s1 != *s2)
  801106:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801109:	8a 10                	mov    (%eax),%dl
  80110b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80110e:	8a 00                	mov    (%eax),%al
  801110:	38 c2                	cmp    %al,%dl
  801112:	74 16                	je     80112a <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801114:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801117:	8a 00                	mov    (%eax),%al
  801119:	0f b6 d0             	movzbl %al,%edx
  80111c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80111f:	8a 00                	mov    (%eax),%al
  801121:	0f b6 c0             	movzbl %al,%eax
  801124:	29 c2                	sub    %eax,%edx
  801126:	89 d0                	mov    %edx,%eax
  801128:	eb 18                	jmp    801142 <memcmp+0x50>
		s1++, s2++;
  80112a:	ff 45 fc             	incl   -0x4(%ebp)
  80112d:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801130:	8b 45 10             	mov    0x10(%ebp),%eax
  801133:	8d 50 ff             	lea    -0x1(%eax),%edx
  801136:	89 55 10             	mov    %edx,0x10(%ebp)
  801139:	85 c0                	test   %eax,%eax
  80113b:	75 c9                	jne    801106 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80113d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801142:	c9                   	leave  
  801143:	c3                   	ret    

00801144 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801144:	55                   	push   %ebp
  801145:	89 e5                	mov    %esp,%ebp
  801147:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80114a:	8b 55 08             	mov    0x8(%ebp),%edx
  80114d:	8b 45 10             	mov    0x10(%ebp),%eax
  801150:	01 d0                	add    %edx,%eax
  801152:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801155:	eb 15                	jmp    80116c <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801157:	8b 45 08             	mov    0x8(%ebp),%eax
  80115a:	8a 00                	mov    (%eax),%al
  80115c:	0f b6 d0             	movzbl %al,%edx
  80115f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801162:	0f b6 c0             	movzbl %al,%eax
  801165:	39 c2                	cmp    %eax,%edx
  801167:	74 0d                	je     801176 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801169:	ff 45 08             	incl   0x8(%ebp)
  80116c:	8b 45 08             	mov    0x8(%ebp),%eax
  80116f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801172:	72 e3                	jb     801157 <memfind+0x13>
  801174:	eb 01                	jmp    801177 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801176:	90                   	nop
	return (void *) s;
  801177:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80117a:	c9                   	leave  
  80117b:	c3                   	ret    

0080117c <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80117c:	55                   	push   %ebp
  80117d:	89 e5                	mov    %esp,%ebp
  80117f:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801182:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801189:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801190:	eb 03                	jmp    801195 <strtol+0x19>
		s++;
  801192:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	3c 20                	cmp    $0x20,%al
  80119c:	74 f4                	je     801192 <strtol+0x16>
  80119e:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a1:	8a 00                	mov    (%eax),%al
  8011a3:	3c 09                	cmp    $0x9,%al
  8011a5:	74 eb                	je     801192 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	8a 00                	mov    (%eax),%al
  8011ac:	3c 2b                	cmp    $0x2b,%al
  8011ae:	75 05                	jne    8011b5 <strtol+0x39>
		s++;
  8011b0:	ff 45 08             	incl   0x8(%ebp)
  8011b3:	eb 13                	jmp    8011c8 <strtol+0x4c>
	else if (*s == '-')
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	8a 00                	mov    (%eax),%al
  8011ba:	3c 2d                	cmp    $0x2d,%al
  8011bc:	75 0a                	jne    8011c8 <strtol+0x4c>
		s++, neg = 1;
  8011be:	ff 45 08             	incl   0x8(%ebp)
  8011c1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8011c8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011cc:	74 06                	je     8011d4 <strtol+0x58>
  8011ce:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8011d2:	75 20                	jne    8011f4 <strtol+0x78>
  8011d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d7:	8a 00                	mov    (%eax),%al
  8011d9:	3c 30                	cmp    $0x30,%al
  8011db:	75 17                	jne    8011f4 <strtol+0x78>
  8011dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e0:	40                   	inc    %eax
  8011e1:	8a 00                	mov    (%eax),%al
  8011e3:	3c 78                	cmp    $0x78,%al
  8011e5:	75 0d                	jne    8011f4 <strtol+0x78>
		s += 2, base = 16;
  8011e7:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011eb:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011f2:	eb 28                	jmp    80121c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011f8:	75 15                	jne    80120f <strtol+0x93>
  8011fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fd:	8a 00                	mov    (%eax),%al
  8011ff:	3c 30                	cmp    $0x30,%al
  801201:	75 0c                	jne    80120f <strtol+0x93>
		s++, base = 8;
  801203:	ff 45 08             	incl   0x8(%ebp)
  801206:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80120d:	eb 0d                	jmp    80121c <strtol+0xa0>
	else if (base == 0)
  80120f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801213:	75 07                	jne    80121c <strtol+0xa0>
		base = 10;
  801215:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80121c:	8b 45 08             	mov    0x8(%ebp),%eax
  80121f:	8a 00                	mov    (%eax),%al
  801221:	3c 2f                	cmp    $0x2f,%al
  801223:	7e 19                	jle    80123e <strtol+0xc2>
  801225:	8b 45 08             	mov    0x8(%ebp),%eax
  801228:	8a 00                	mov    (%eax),%al
  80122a:	3c 39                	cmp    $0x39,%al
  80122c:	7f 10                	jg     80123e <strtol+0xc2>
			dig = *s - '0';
  80122e:	8b 45 08             	mov    0x8(%ebp),%eax
  801231:	8a 00                	mov    (%eax),%al
  801233:	0f be c0             	movsbl %al,%eax
  801236:	83 e8 30             	sub    $0x30,%eax
  801239:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80123c:	eb 42                	jmp    801280 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80123e:	8b 45 08             	mov    0x8(%ebp),%eax
  801241:	8a 00                	mov    (%eax),%al
  801243:	3c 60                	cmp    $0x60,%al
  801245:	7e 19                	jle    801260 <strtol+0xe4>
  801247:	8b 45 08             	mov    0x8(%ebp),%eax
  80124a:	8a 00                	mov    (%eax),%al
  80124c:	3c 7a                	cmp    $0x7a,%al
  80124e:	7f 10                	jg     801260 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801250:	8b 45 08             	mov    0x8(%ebp),%eax
  801253:	8a 00                	mov    (%eax),%al
  801255:	0f be c0             	movsbl %al,%eax
  801258:	83 e8 57             	sub    $0x57,%eax
  80125b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80125e:	eb 20                	jmp    801280 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801260:	8b 45 08             	mov    0x8(%ebp),%eax
  801263:	8a 00                	mov    (%eax),%al
  801265:	3c 40                	cmp    $0x40,%al
  801267:	7e 39                	jle    8012a2 <strtol+0x126>
  801269:	8b 45 08             	mov    0x8(%ebp),%eax
  80126c:	8a 00                	mov    (%eax),%al
  80126e:	3c 5a                	cmp    $0x5a,%al
  801270:	7f 30                	jg     8012a2 <strtol+0x126>
			dig = *s - 'A' + 10;
  801272:	8b 45 08             	mov    0x8(%ebp),%eax
  801275:	8a 00                	mov    (%eax),%al
  801277:	0f be c0             	movsbl %al,%eax
  80127a:	83 e8 37             	sub    $0x37,%eax
  80127d:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801280:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801283:	3b 45 10             	cmp    0x10(%ebp),%eax
  801286:	7d 19                	jge    8012a1 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801288:	ff 45 08             	incl   0x8(%ebp)
  80128b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80128e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801292:	89 c2                	mov    %eax,%edx
  801294:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801297:	01 d0                	add    %edx,%eax
  801299:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80129c:	e9 7b ff ff ff       	jmp    80121c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8012a1:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8012a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012a6:	74 08                	je     8012b0 <strtol+0x134>
		*endptr = (char *) s;
  8012a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ab:	8b 55 08             	mov    0x8(%ebp),%edx
  8012ae:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8012b0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012b4:	74 07                	je     8012bd <strtol+0x141>
  8012b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012b9:	f7 d8                	neg    %eax
  8012bb:	eb 03                	jmp    8012c0 <strtol+0x144>
  8012bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012c0:	c9                   	leave  
  8012c1:	c3                   	ret    

008012c2 <ltostr>:

void
ltostr(long value, char *str)
{
  8012c2:	55                   	push   %ebp
  8012c3:	89 e5                	mov    %esp,%ebp
  8012c5:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8012c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8012cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8012d6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012da:	79 13                	jns    8012ef <ltostr+0x2d>
	{
		neg = 1;
  8012dc:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8012e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e6:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012e9:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012ec:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f2:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012f7:	99                   	cltd   
  8012f8:	f7 f9                	idiv   %ecx
  8012fa:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801300:	8d 50 01             	lea    0x1(%eax),%edx
  801303:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801306:	89 c2                	mov    %eax,%edx
  801308:	8b 45 0c             	mov    0xc(%ebp),%eax
  80130b:	01 d0                	add    %edx,%eax
  80130d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801310:	83 c2 30             	add    $0x30,%edx
  801313:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801315:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801318:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80131d:	f7 e9                	imul   %ecx
  80131f:	c1 fa 02             	sar    $0x2,%edx
  801322:	89 c8                	mov    %ecx,%eax
  801324:	c1 f8 1f             	sar    $0x1f,%eax
  801327:	29 c2                	sub    %eax,%edx
  801329:	89 d0                	mov    %edx,%eax
  80132b:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80132e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801331:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801336:	f7 e9                	imul   %ecx
  801338:	c1 fa 02             	sar    $0x2,%edx
  80133b:	89 c8                	mov    %ecx,%eax
  80133d:	c1 f8 1f             	sar    $0x1f,%eax
  801340:	29 c2                	sub    %eax,%edx
  801342:	89 d0                	mov    %edx,%eax
  801344:	c1 e0 02             	shl    $0x2,%eax
  801347:	01 d0                	add    %edx,%eax
  801349:	01 c0                	add    %eax,%eax
  80134b:	29 c1                	sub    %eax,%ecx
  80134d:	89 ca                	mov    %ecx,%edx
  80134f:	85 d2                	test   %edx,%edx
  801351:	75 9c                	jne    8012ef <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801353:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80135a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80135d:	48                   	dec    %eax
  80135e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801361:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801365:	74 3d                	je     8013a4 <ltostr+0xe2>
		start = 1 ;
  801367:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80136e:	eb 34                	jmp    8013a4 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801370:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801373:	8b 45 0c             	mov    0xc(%ebp),%eax
  801376:	01 d0                	add    %edx,%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80137d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801380:	8b 45 0c             	mov    0xc(%ebp),%eax
  801383:	01 c2                	add    %eax,%edx
  801385:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801388:	8b 45 0c             	mov    0xc(%ebp),%eax
  80138b:	01 c8                	add    %ecx,%eax
  80138d:	8a 00                	mov    (%eax),%al
  80138f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801391:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801394:	8b 45 0c             	mov    0xc(%ebp),%eax
  801397:	01 c2                	add    %eax,%edx
  801399:	8a 45 eb             	mov    -0x15(%ebp),%al
  80139c:	88 02                	mov    %al,(%edx)
		start++ ;
  80139e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8013a1:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8013a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013aa:	7c c4                	jl     801370 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8013ac:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8013af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b2:	01 d0                	add    %edx,%eax
  8013b4:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8013b7:	90                   	nop
  8013b8:	c9                   	leave  
  8013b9:	c3                   	ret    

008013ba <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8013ba:	55                   	push   %ebp
  8013bb:	89 e5                	mov    %esp,%ebp
  8013bd:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8013c0:	ff 75 08             	pushl  0x8(%ebp)
  8013c3:	e8 54 fa ff ff       	call   800e1c <strlen>
  8013c8:	83 c4 04             	add    $0x4,%esp
  8013cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8013ce:	ff 75 0c             	pushl  0xc(%ebp)
  8013d1:	e8 46 fa ff ff       	call   800e1c <strlen>
  8013d6:	83 c4 04             	add    $0x4,%esp
  8013d9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8013dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8013e3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013ea:	eb 17                	jmp    801403 <strcconcat+0x49>
		final[s] = str1[s] ;
  8013ec:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8013f2:	01 c2                	add    %eax,%edx
  8013f4:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	01 c8                	add    %ecx,%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801400:	ff 45 fc             	incl   -0x4(%ebp)
  801403:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801406:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801409:	7c e1                	jl     8013ec <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80140b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801412:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801419:	eb 1f                	jmp    80143a <strcconcat+0x80>
		final[s++] = str2[i] ;
  80141b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80141e:	8d 50 01             	lea    0x1(%eax),%edx
  801421:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801424:	89 c2                	mov    %eax,%edx
  801426:	8b 45 10             	mov    0x10(%ebp),%eax
  801429:	01 c2                	add    %eax,%edx
  80142b:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80142e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801431:	01 c8                	add    %ecx,%eax
  801433:	8a 00                	mov    (%eax),%al
  801435:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801437:	ff 45 f8             	incl   -0x8(%ebp)
  80143a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80143d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801440:	7c d9                	jl     80141b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801442:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801445:	8b 45 10             	mov    0x10(%ebp),%eax
  801448:	01 d0                	add    %edx,%eax
  80144a:	c6 00 00             	movb   $0x0,(%eax)
}
  80144d:	90                   	nop
  80144e:	c9                   	leave  
  80144f:	c3                   	ret    

00801450 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801453:	8b 45 14             	mov    0x14(%ebp),%eax
  801456:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80145c:	8b 45 14             	mov    0x14(%ebp),%eax
  80145f:	8b 00                	mov    (%eax),%eax
  801461:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801468:	8b 45 10             	mov    0x10(%ebp),%eax
  80146b:	01 d0                	add    %edx,%eax
  80146d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801473:	eb 0c                	jmp    801481 <strsplit+0x31>
			*string++ = 0;
  801475:	8b 45 08             	mov    0x8(%ebp),%eax
  801478:	8d 50 01             	lea    0x1(%eax),%edx
  80147b:	89 55 08             	mov    %edx,0x8(%ebp)
  80147e:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801481:	8b 45 08             	mov    0x8(%ebp),%eax
  801484:	8a 00                	mov    (%eax),%al
  801486:	84 c0                	test   %al,%al
  801488:	74 18                	je     8014a2 <strsplit+0x52>
  80148a:	8b 45 08             	mov    0x8(%ebp),%eax
  80148d:	8a 00                	mov    (%eax),%al
  80148f:	0f be c0             	movsbl %al,%eax
  801492:	50                   	push   %eax
  801493:	ff 75 0c             	pushl  0xc(%ebp)
  801496:	e8 13 fb ff ff       	call   800fae <strchr>
  80149b:	83 c4 08             	add    $0x8,%esp
  80149e:	85 c0                	test   %eax,%eax
  8014a0:	75 d3                	jne    801475 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8014a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a5:	8a 00                	mov    (%eax),%al
  8014a7:	84 c0                	test   %al,%al
  8014a9:	74 5a                	je     801505 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8014ab:	8b 45 14             	mov    0x14(%ebp),%eax
  8014ae:	8b 00                	mov    (%eax),%eax
  8014b0:	83 f8 0f             	cmp    $0xf,%eax
  8014b3:	75 07                	jne    8014bc <strsplit+0x6c>
		{
			return 0;
  8014b5:	b8 00 00 00 00       	mov    $0x0,%eax
  8014ba:	eb 66                	jmp    801522 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8014bc:	8b 45 14             	mov    0x14(%ebp),%eax
  8014bf:	8b 00                	mov    (%eax),%eax
  8014c1:	8d 48 01             	lea    0x1(%eax),%ecx
  8014c4:	8b 55 14             	mov    0x14(%ebp),%edx
  8014c7:	89 0a                	mov    %ecx,(%edx)
  8014c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d3:	01 c2                	add    %eax,%edx
  8014d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d8:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014da:	eb 03                	jmp    8014df <strsplit+0x8f>
			string++;
  8014dc:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8014df:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e2:	8a 00                	mov    (%eax),%al
  8014e4:	84 c0                	test   %al,%al
  8014e6:	74 8b                	je     801473 <strsplit+0x23>
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014eb:	8a 00                	mov    (%eax),%al
  8014ed:	0f be c0             	movsbl %al,%eax
  8014f0:	50                   	push   %eax
  8014f1:	ff 75 0c             	pushl  0xc(%ebp)
  8014f4:	e8 b5 fa ff ff       	call   800fae <strchr>
  8014f9:	83 c4 08             	add    $0x8,%esp
  8014fc:	85 c0                	test   %eax,%eax
  8014fe:	74 dc                	je     8014dc <strsplit+0x8c>
			string++;
	}
  801500:	e9 6e ff ff ff       	jmp    801473 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801505:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801506:	8b 45 14             	mov    0x14(%ebp),%eax
  801509:	8b 00                	mov    (%eax),%eax
  80150b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801512:	8b 45 10             	mov    0x10(%ebp),%eax
  801515:	01 d0                	add    %edx,%eax
  801517:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80151d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801522:	c9                   	leave  
  801523:	c3                   	ret    

00801524 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801524:	55                   	push   %ebp
  801525:	89 e5                	mov    %esp,%ebp
  801527:	57                   	push   %edi
  801528:	56                   	push   %esi
  801529:	53                   	push   %ebx
  80152a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80152d:	8b 45 08             	mov    0x8(%ebp),%eax
  801530:	8b 55 0c             	mov    0xc(%ebp),%edx
  801533:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801536:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801539:	8b 7d 18             	mov    0x18(%ebp),%edi
  80153c:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80153f:	cd 30                	int    $0x30
  801541:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801544:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801547:	83 c4 10             	add    $0x10,%esp
  80154a:	5b                   	pop    %ebx
  80154b:	5e                   	pop    %esi
  80154c:	5f                   	pop    %edi
  80154d:	5d                   	pop    %ebp
  80154e:	c3                   	ret    

0080154f <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80154f:	55                   	push   %ebp
  801550:	89 e5                	mov    %esp,%ebp
  801552:	83 ec 04             	sub    $0x4,%esp
  801555:	8b 45 10             	mov    0x10(%ebp),%eax
  801558:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80155b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80155f:	8b 45 08             	mov    0x8(%ebp),%eax
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	52                   	push   %edx
  801567:	ff 75 0c             	pushl  0xc(%ebp)
  80156a:	50                   	push   %eax
  80156b:	6a 00                	push   $0x0
  80156d:	e8 b2 ff ff ff       	call   801524 <syscall>
  801572:	83 c4 18             	add    $0x18,%esp
}
  801575:	90                   	nop
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <sys_cgetc>:

int
sys_cgetc(void)
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	6a 00                	push   $0x0
  801583:	6a 00                	push   $0x0
  801585:	6a 01                	push   $0x1
  801587:	e8 98 ff ff ff       	call   801524 <syscall>
  80158c:	83 c4 18             	add    $0x18,%esp
}
  80158f:	c9                   	leave  
  801590:	c3                   	ret    

00801591 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801591:	55                   	push   %ebp
  801592:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801594:	8b 45 08             	mov    0x8(%ebp),%eax
  801597:	6a 00                	push   $0x0
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	50                   	push   %eax
  8015a0:	6a 05                	push   $0x5
  8015a2:	e8 7d ff ff ff       	call   801524 <syscall>
  8015a7:	83 c4 18             	add    $0x18,%esp
}
  8015aa:	c9                   	leave  
  8015ab:	c3                   	ret    

008015ac <sys_getenvid>:

int32 sys_getenvid(void)
{
  8015ac:	55                   	push   %ebp
  8015ad:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8015af:	6a 00                	push   $0x0
  8015b1:	6a 00                	push   $0x0
  8015b3:	6a 00                	push   $0x0
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 02                	push   $0x2
  8015bb:	e8 64 ff ff ff       	call   801524 <syscall>
  8015c0:	83 c4 18             	add    $0x18,%esp
}
  8015c3:	c9                   	leave  
  8015c4:	c3                   	ret    

008015c5 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 03                	push   $0x3
  8015d4:	e8 4b ff ff ff       	call   801524 <syscall>
  8015d9:	83 c4 18             	add    $0x18,%esp
}
  8015dc:	c9                   	leave  
  8015dd:	c3                   	ret    

008015de <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8015de:	55                   	push   %ebp
  8015df:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	6a 00                	push   $0x0
  8015e9:	6a 00                	push   $0x0
  8015eb:	6a 04                	push   $0x4
  8015ed:	e8 32 ff ff ff       	call   801524 <syscall>
  8015f2:	83 c4 18             	add    $0x18,%esp
}
  8015f5:	c9                   	leave  
  8015f6:	c3                   	ret    

008015f7 <sys_env_exit>:


void sys_env_exit(void)
{
  8015f7:	55                   	push   %ebp
  8015f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015fa:	6a 00                	push   $0x0
  8015fc:	6a 00                	push   $0x0
  8015fe:	6a 00                	push   $0x0
  801600:	6a 00                	push   $0x0
  801602:	6a 00                	push   $0x0
  801604:	6a 06                	push   $0x6
  801606:	e8 19 ff ff ff       	call   801524 <syscall>
  80160b:	83 c4 18             	add    $0x18,%esp
}
  80160e:	90                   	nop
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801614:	8b 55 0c             	mov    0xc(%ebp),%edx
  801617:	8b 45 08             	mov    0x8(%ebp),%eax
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	52                   	push   %edx
  801621:	50                   	push   %eax
  801622:	6a 07                	push   $0x7
  801624:	e8 fb fe ff ff       	call   801524 <syscall>
  801629:	83 c4 18             	add    $0x18,%esp
}
  80162c:	c9                   	leave  
  80162d:	c3                   	ret    

0080162e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80162e:	55                   	push   %ebp
  80162f:	89 e5                	mov    %esp,%ebp
  801631:	56                   	push   %esi
  801632:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801633:	8b 75 18             	mov    0x18(%ebp),%esi
  801636:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801639:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80163c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80163f:	8b 45 08             	mov    0x8(%ebp),%eax
  801642:	56                   	push   %esi
  801643:	53                   	push   %ebx
  801644:	51                   	push   %ecx
  801645:	52                   	push   %edx
  801646:	50                   	push   %eax
  801647:	6a 08                	push   $0x8
  801649:	e8 d6 fe ff ff       	call   801524 <syscall>
  80164e:	83 c4 18             	add    $0x18,%esp
}
  801651:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801654:	5b                   	pop    %ebx
  801655:	5e                   	pop    %esi
  801656:	5d                   	pop    %ebp
  801657:	c3                   	ret    

00801658 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801658:	55                   	push   %ebp
  801659:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80165b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	6a 00                	push   $0x0
  801663:	6a 00                	push   $0x0
  801665:	6a 00                	push   $0x0
  801667:	52                   	push   %edx
  801668:	50                   	push   %eax
  801669:	6a 09                	push   $0x9
  80166b:	e8 b4 fe ff ff       	call   801524 <syscall>
  801670:	83 c4 18             	add    $0x18,%esp
}
  801673:	c9                   	leave  
  801674:	c3                   	ret    

00801675 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801675:	55                   	push   %ebp
  801676:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801678:	6a 00                	push   $0x0
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	ff 75 0c             	pushl  0xc(%ebp)
  801681:	ff 75 08             	pushl  0x8(%ebp)
  801684:	6a 0a                	push   $0xa
  801686:	e8 99 fe ff ff       	call   801524 <syscall>
  80168b:	83 c4 18             	add    $0x18,%esp
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 0b                	push   $0xb
  80169f:	e8 80 fe ff ff       	call   801524 <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
}
  8016a7:	c9                   	leave  
  8016a8:	c3                   	ret    

008016a9 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8016a9:	55                   	push   %ebp
  8016aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8016ac:	6a 00                	push   $0x0
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 0c                	push   $0xc
  8016b8:	e8 67 fe ff ff       	call   801524 <syscall>
  8016bd:	83 c4 18             	add    $0x18,%esp
}
  8016c0:	c9                   	leave  
  8016c1:	c3                   	ret    

008016c2 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8016c2:	55                   	push   %ebp
  8016c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8016c5:	6a 00                	push   $0x0
  8016c7:	6a 00                	push   $0x0
  8016c9:	6a 00                	push   $0x0
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 0d                	push   $0xd
  8016d1:	e8 4e fe ff ff       	call   801524 <syscall>
  8016d6:	83 c4 18             	add    $0x18,%esp
}
  8016d9:	c9                   	leave  
  8016da:	c3                   	ret    

008016db <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8016db:	55                   	push   %ebp
  8016dc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8016de:	6a 00                	push   $0x0
  8016e0:	6a 00                	push   $0x0
  8016e2:	6a 00                	push   $0x0
  8016e4:	ff 75 0c             	pushl  0xc(%ebp)
  8016e7:	ff 75 08             	pushl  0x8(%ebp)
  8016ea:	6a 11                	push   $0x11
  8016ec:	e8 33 fe ff ff       	call   801524 <syscall>
  8016f1:	83 c4 18             	add    $0x18,%esp
	return;
  8016f4:	90                   	nop
}
  8016f5:	c9                   	leave  
  8016f6:	c3                   	ret    

008016f7 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016f7:	55                   	push   %ebp
  8016f8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	ff 75 0c             	pushl  0xc(%ebp)
  801703:	ff 75 08             	pushl  0x8(%ebp)
  801706:	6a 12                	push   $0x12
  801708:	e8 17 fe ff ff       	call   801524 <syscall>
  80170d:	83 c4 18             	add    $0x18,%esp
	return ;
  801710:	90                   	nop
}
  801711:	c9                   	leave  
  801712:	c3                   	ret    

00801713 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801713:	55                   	push   %ebp
  801714:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801716:	6a 00                	push   $0x0
  801718:	6a 00                	push   $0x0
  80171a:	6a 00                	push   $0x0
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 0e                	push   $0xe
  801722:	e8 fd fd ff ff       	call   801524 <syscall>
  801727:	83 c4 18             	add    $0x18,%esp
}
  80172a:	c9                   	leave  
  80172b:	c3                   	ret    

0080172c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80172c:	55                   	push   %ebp
  80172d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 00                	push   $0x0
  801735:	6a 00                	push   $0x0
  801737:	ff 75 08             	pushl  0x8(%ebp)
  80173a:	6a 0f                	push   $0xf
  80173c:	e8 e3 fd ff ff       	call   801524 <syscall>
  801741:	83 c4 18             	add    $0x18,%esp
}
  801744:	c9                   	leave  
  801745:	c3                   	ret    

00801746 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801746:	55                   	push   %ebp
  801747:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801749:	6a 00                	push   $0x0
  80174b:	6a 00                	push   $0x0
  80174d:	6a 00                	push   $0x0
  80174f:	6a 00                	push   $0x0
  801751:	6a 00                	push   $0x0
  801753:	6a 10                	push   $0x10
  801755:	e8 ca fd ff ff       	call   801524 <syscall>
  80175a:	83 c4 18             	add    $0x18,%esp
}
  80175d:	90                   	nop
  80175e:	c9                   	leave  
  80175f:	c3                   	ret    

00801760 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801760:	55                   	push   %ebp
  801761:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	6a 00                	push   $0x0
  80176d:	6a 14                	push   $0x14
  80176f:	e8 b0 fd ff ff       	call   801524 <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
}
  801777:	90                   	nop
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 00                	push   $0x0
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 15                	push   $0x15
  801789:	e8 96 fd ff ff       	call   801524 <syscall>
  80178e:	83 c4 18             	add    $0x18,%esp
}
  801791:	90                   	nop
  801792:	c9                   	leave  
  801793:	c3                   	ret    

00801794 <sys_cputc>:


void
sys_cputc(const char c)
{
  801794:	55                   	push   %ebp
  801795:	89 e5                	mov    %esp,%ebp
  801797:	83 ec 04             	sub    $0x4,%esp
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8017a0:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8017a4:	6a 00                	push   $0x0
  8017a6:	6a 00                	push   $0x0
  8017a8:	6a 00                	push   $0x0
  8017aa:	6a 00                	push   $0x0
  8017ac:	50                   	push   %eax
  8017ad:	6a 16                	push   $0x16
  8017af:	e8 70 fd ff ff       	call   801524 <syscall>
  8017b4:	83 c4 18             	add    $0x18,%esp
}
  8017b7:	90                   	nop
  8017b8:	c9                   	leave  
  8017b9:	c3                   	ret    

008017ba <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8017ba:	55                   	push   %ebp
  8017bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8017bd:	6a 00                	push   $0x0
  8017bf:	6a 00                	push   $0x0
  8017c1:	6a 00                	push   $0x0
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 17                	push   $0x17
  8017c9:	e8 56 fd ff ff       	call   801524 <syscall>
  8017ce:	83 c4 18             	add    $0x18,%esp
}
  8017d1:	90                   	nop
  8017d2:	c9                   	leave  
  8017d3:	c3                   	ret    

008017d4 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8017d4:	55                   	push   %ebp
  8017d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8017d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017da:	6a 00                	push   $0x0
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	ff 75 0c             	pushl  0xc(%ebp)
  8017e3:	50                   	push   %eax
  8017e4:	6a 18                	push   $0x18
  8017e6:	e8 39 fd ff ff       	call   801524 <syscall>
  8017eb:	83 c4 18             	add    $0x18,%esp
}
  8017ee:	c9                   	leave  
  8017ef:	c3                   	ret    

008017f0 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017f0:	55                   	push   %ebp
  8017f1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	52                   	push   %edx
  801800:	50                   	push   %eax
  801801:	6a 1b                	push   $0x1b
  801803:	e8 1c fd ff ff       	call   801524 <syscall>
  801808:	83 c4 18             	add    $0x18,%esp
}
  80180b:	c9                   	leave  
  80180c:	c3                   	ret    

0080180d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80180d:	55                   	push   %ebp
  80180e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801810:	8b 55 0c             	mov    0xc(%ebp),%edx
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	52                   	push   %edx
  80181d:	50                   	push   %eax
  80181e:	6a 19                	push   $0x19
  801820:	e8 ff fc ff ff       	call   801524 <syscall>
  801825:	83 c4 18             	add    $0x18,%esp
}
  801828:	90                   	nop
  801829:	c9                   	leave  
  80182a:	c3                   	ret    

0080182b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80182b:	55                   	push   %ebp
  80182c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80182e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801831:	8b 45 08             	mov    0x8(%ebp),%eax
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	6a 00                	push   $0x0
  80183a:	52                   	push   %edx
  80183b:	50                   	push   %eax
  80183c:	6a 1a                	push   $0x1a
  80183e:	e8 e1 fc ff ff       	call   801524 <syscall>
  801843:	83 c4 18             	add    $0x18,%esp
}
  801846:	90                   	nop
  801847:	c9                   	leave  
  801848:	c3                   	ret    

00801849 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801849:	55                   	push   %ebp
  80184a:	89 e5                	mov    %esp,%ebp
  80184c:	83 ec 04             	sub    $0x4,%esp
  80184f:	8b 45 10             	mov    0x10(%ebp),%eax
  801852:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801855:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801858:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80185c:	8b 45 08             	mov    0x8(%ebp),%eax
  80185f:	6a 00                	push   $0x0
  801861:	51                   	push   %ecx
  801862:	52                   	push   %edx
  801863:	ff 75 0c             	pushl  0xc(%ebp)
  801866:	50                   	push   %eax
  801867:	6a 1c                	push   $0x1c
  801869:	e8 b6 fc ff ff       	call   801524 <syscall>
  80186e:	83 c4 18             	add    $0x18,%esp
}
  801871:	c9                   	leave  
  801872:	c3                   	ret    

00801873 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801873:	55                   	push   %ebp
  801874:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801876:	8b 55 0c             	mov    0xc(%ebp),%edx
  801879:	8b 45 08             	mov    0x8(%ebp),%eax
  80187c:	6a 00                	push   $0x0
  80187e:	6a 00                	push   $0x0
  801880:	6a 00                	push   $0x0
  801882:	52                   	push   %edx
  801883:	50                   	push   %eax
  801884:	6a 1d                	push   $0x1d
  801886:	e8 99 fc ff ff       	call   801524 <syscall>
  80188b:	83 c4 18             	add    $0x18,%esp
}
  80188e:	c9                   	leave  
  80188f:	c3                   	ret    

00801890 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801890:	55                   	push   %ebp
  801891:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801893:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801896:	8b 55 0c             	mov    0xc(%ebp),%edx
  801899:	8b 45 08             	mov    0x8(%ebp),%eax
  80189c:	6a 00                	push   $0x0
  80189e:	6a 00                	push   $0x0
  8018a0:	51                   	push   %ecx
  8018a1:	52                   	push   %edx
  8018a2:	50                   	push   %eax
  8018a3:	6a 1e                	push   $0x1e
  8018a5:	e8 7a fc ff ff       	call   801524 <syscall>
  8018aa:	83 c4 18             	add    $0x18,%esp
}
  8018ad:	c9                   	leave  
  8018ae:	c3                   	ret    

008018af <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8018af:	55                   	push   %ebp
  8018b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8018b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	6a 00                	push   $0x0
  8018ba:	6a 00                	push   $0x0
  8018bc:	6a 00                	push   $0x0
  8018be:	52                   	push   %edx
  8018bf:	50                   	push   %eax
  8018c0:	6a 1f                	push   $0x1f
  8018c2:	e8 5d fc ff ff       	call   801524 <syscall>
  8018c7:	83 c4 18             	add    $0x18,%esp
}
  8018ca:	c9                   	leave  
  8018cb:	c3                   	ret    

008018cc <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8018cc:	55                   	push   %ebp
  8018cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8018cf:	6a 00                	push   $0x0
  8018d1:	6a 00                	push   $0x0
  8018d3:	6a 00                	push   $0x0
  8018d5:	6a 00                	push   $0x0
  8018d7:	6a 00                	push   $0x0
  8018d9:	6a 20                	push   $0x20
  8018db:	e8 44 fc ff ff       	call   801524 <syscall>
  8018e0:	83 c4 18             	add    $0x18,%esp
}
  8018e3:	c9                   	leave  
  8018e4:	c3                   	ret    

008018e5 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018e5:	55                   	push   %ebp
  8018e6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018eb:	6a 00                	push   $0x0
  8018ed:	ff 75 14             	pushl  0x14(%ebp)
  8018f0:	ff 75 10             	pushl  0x10(%ebp)
  8018f3:	ff 75 0c             	pushl  0xc(%ebp)
  8018f6:	50                   	push   %eax
  8018f7:	6a 21                	push   $0x21
  8018f9:	e8 26 fc ff ff       	call   801524 <syscall>
  8018fe:	83 c4 18             	add    $0x18,%esp
}
  801901:	c9                   	leave  
  801902:	c3                   	ret    

00801903 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801903:	55                   	push   %ebp
  801904:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801906:	8b 45 08             	mov    0x8(%ebp),%eax
  801909:	6a 00                	push   $0x0
  80190b:	6a 00                	push   $0x0
  80190d:	6a 00                	push   $0x0
  80190f:	6a 00                	push   $0x0
  801911:	50                   	push   %eax
  801912:	6a 22                	push   $0x22
  801914:	e8 0b fc ff ff       	call   801524 <syscall>
  801919:	83 c4 18             	add    $0x18,%esp
}
  80191c:	90                   	nop
  80191d:	c9                   	leave  
  80191e:	c3                   	ret    

0080191f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80191f:	55                   	push   %ebp
  801920:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801922:	8b 45 08             	mov    0x8(%ebp),%eax
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 00                	push   $0x0
  80192b:	6a 00                	push   $0x0
  80192d:	50                   	push   %eax
  80192e:	6a 23                	push   $0x23
  801930:	e8 ef fb ff ff       	call   801524 <syscall>
  801935:	83 c4 18             	add    $0x18,%esp
}
  801938:	90                   	nop
  801939:	c9                   	leave  
  80193a:	c3                   	ret    

0080193b <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80193b:	55                   	push   %ebp
  80193c:	89 e5                	mov    %esp,%ebp
  80193e:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801941:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801944:	8d 50 04             	lea    0x4(%eax),%edx
  801947:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80194a:	6a 00                	push   $0x0
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	52                   	push   %edx
  801951:	50                   	push   %eax
  801952:	6a 24                	push   $0x24
  801954:	e8 cb fb ff ff       	call   801524 <syscall>
  801959:	83 c4 18             	add    $0x18,%esp
	return result;
  80195c:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80195f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801962:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801965:	89 01                	mov    %eax,(%ecx)
  801967:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80196a:	8b 45 08             	mov    0x8(%ebp),%eax
  80196d:	c9                   	leave  
  80196e:	c2 04 00             	ret    $0x4

00801971 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801971:	55                   	push   %ebp
  801972:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	ff 75 10             	pushl  0x10(%ebp)
  80197b:	ff 75 0c             	pushl  0xc(%ebp)
  80197e:	ff 75 08             	pushl  0x8(%ebp)
  801981:	6a 13                	push   $0x13
  801983:	e8 9c fb ff ff       	call   801524 <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
	return ;
  80198b:	90                   	nop
}
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <sys_rcr2>:
uint32 sys_rcr2()
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 25                	push   $0x25
  80199d:	e8 82 fb ff ff       	call   801524 <syscall>
  8019a2:	83 c4 18             	add    $0x18,%esp
}
  8019a5:	c9                   	leave  
  8019a6:	c3                   	ret    

008019a7 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8019a7:	55                   	push   %ebp
  8019a8:	89 e5                	mov    %esp,%ebp
  8019aa:	83 ec 04             	sub    $0x4,%esp
  8019ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8019b3:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	50                   	push   %eax
  8019c0:	6a 26                	push   $0x26
  8019c2:	e8 5d fb ff ff       	call   801524 <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ca:	90                   	nop
}
  8019cb:	c9                   	leave  
  8019cc:	c3                   	ret    

008019cd <rsttst>:
void rsttst()
{
  8019cd:	55                   	push   %ebp
  8019ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 00                	push   $0x0
  8019da:	6a 28                	push   $0x28
  8019dc:	e8 43 fb ff ff       	call   801524 <syscall>
  8019e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e4:	90                   	nop
}
  8019e5:	c9                   	leave  
  8019e6:	c3                   	ret    

008019e7 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019e7:	55                   	push   %ebp
  8019e8:	89 e5                	mov    %esp,%ebp
  8019ea:	83 ec 04             	sub    $0x4,%esp
  8019ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8019f0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019f3:	8b 55 18             	mov    0x18(%ebp),%edx
  8019f6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019fa:	52                   	push   %edx
  8019fb:	50                   	push   %eax
  8019fc:	ff 75 10             	pushl  0x10(%ebp)
  8019ff:	ff 75 0c             	pushl  0xc(%ebp)
  801a02:	ff 75 08             	pushl  0x8(%ebp)
  801a05:	6a 27                	push   $0x27
  801a07:	e8 18 fb ff ff       	call   801524 <syscall>
  801a0c:	83 c4 18             	add    $0x18,%esp
	return ;
  801a0f:	90                   	nop
}
  801a10:	c9                   	leave  
  801a11:	c3                   	ret    

00801a12 <chktst>:
void chktst(uint32 n)
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801a15:	6a 00                	push   $0x0
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	ff 75 08             	pushl  0x8(%ebp)
  801a20:	6a 29                	push   $0x29
  801a22:	e8 fd fa ff ff       	call   801524 <syscall>
  801a27:	83 c4 18             	add    $0x18,%esp
	return ;
  801a2a:	90                   	nop
}
  801a2b:	c9                   	leave  
  801a2c:	c3                   	ret    

00801a2d <inctst>:

void inctst()
{
  801a2d:	55                   	push   %ebp
  801a2e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 2a                	push   $0x2a
  801a3c:	e8 e3 fa ff ff       	call   801524 <syscall>
  801a41:	83 c4 18             	add    $0x18,%esp
	return ;
  801a44:	90                   	nop
}
  801a45:	c9                   	leave  
  801a46:	c3                   	ret    

00801a47 <gettst>:
uint32 gettst()
{
  801a47:	55                   	push   %ebp
  801a48:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 00                	push   $0x0
  801a54:	6a 2b                	push   $0x2b
  801a56:	e8 c9 fa ff ff       	call   801524 <syscall>
  801a5b:	83 c4 18             	add    $0x18,%esp
}
  801a5e:	c9                   	leave  
  801a5f:	c3                   	ret    

00801a60 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
  801a63:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a66:	6a 00                	push   $0x0
  801a68:	6a 00                	push   $0x0
  801a6a:	6a 00                	push   $0x0
  801a6c:	6a 00                	push   $0x0
  801a6e:	6a 00                	push   $0x0
  801a70:	6a 2c                	push   $0x2c
  801a72:	e8 ad fa ff ff       	call   801524 <syscall>
  801a77:	83 c4 18             	add    $0x18,%esp
  801a7a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a7d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a81:	75 07                	jne    801a8a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a83:	b8 01 00 00 00       	mov    $0x1,%eax
  801a88:	eb 05                	jmp    801a8f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a8a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a8f:	c9                   	leave  
  801a90:	c3                   	ret    

00801a91 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a91:	55                   	push   %ebp
  801a92:	89 e5                	mov    %esp,%ebp
  801a94:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 00                	push   $0x0
  801a9d:	6a 00                	push   $0x0
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 2c                	push   $0x2c
  801aa3:	e8 7c fa ff ff       	call   801524 <syscall>
  801aa8:	83 c4 18             	add    $0x18,%esp
  801aab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801aae:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801ab2:	75 07                	jne    801abb <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ab4:	b8 01 00 00 00       	mov    $0x1,%eax
  801ab9:	eb 05                	jmp    801ac0 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801abb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ac0:	c9                   	leave  
  801ac1:	c3                   	ret    

00801ac2 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801ac2:	55                   	push   %ebp
  801ac3:	89 e5                	mov    %esp,%ebp
  801ac5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ac8:	6a 00                	push   $0x0
  801aca:	6a 00                	push   $0x0
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 2c                	push   $0x2c
  801ad4:	e8 4b fa ff ff       	call   801524 <syscall>
  801ad9:	83 c4 18             	add    $0x18,%esp
  801adc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801adf:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ae3:	75 07                	jne    801aec <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ae5:	b8 01 00 00 00       	mov    $0x1,%eax
  801aea:	eb 05                	jmp    801af1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801aec:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801af1:	c9                   	leave  
  801af2:	c3                   	ret    

00801af3 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801af3:	55                   	push   %ebp
  801af4:	89 e5                	mov    %esp,%ebp
  801af6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 00                	push   $0x0
  801b03:	6a 2c                	push   $0x2c
  801b05:	e8 1a fa ff ff       	call   801524 <syscall>
  801b0a:	83 c4 18             	add    $0x18,%esp
  801b0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801b10:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801b14:	75 07                	jne    801b1d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801b16:	b8 01 00 00 00       	mov    $0x1,%eax
  801b1b:	eb 05                	jmp    801b22 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801b1d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801b22:	c9                   	leave  
  801b23:	c3                   	ret    

00801b24 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801b24:	55                   	push   %ebp
  801b25:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801b27:	6a 00                	push   $0x0
  801b29:	6a 00                	push   $0x0
  801b2b:	6a 00                	push   $0x0
  801b2d:	6a 00                	push   $0x0
  801b2f:	ff 75 08             	pushl  0x8(%ebp)
  801b32:	6a 2d                	push   $0x2d
  801b34:	e8 eb f9 ff ff       	call   801524 <syscall>
  801b39:	83 c4 18             	add    $0x18,%esp
	return ;
  801b3c:	90                   	nop
}
  801b3d:	c9                   	leave  
  801b3e:	c3                   	ret    

00801b3f <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801b3f:	55                   	push   %ebp
  801b40:	89 e5                	mov    %esp,%ebp
  801b42:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801b43:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b46:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b49:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4f:	6a 00                	push   $0x0
  801b51:	53                   	push   %ebx
  801b52:	51                   	push   %ecx
  801b53:	52                   	push   %edx
  801b54:	50                   	push   %eax
  801b55:	6a 2e                	push   $0x2e
  801b57:	e8 c8 f9 ff ff       	call   801524 <syscall>
  801b5c:	83 c4 18             	add    $0x18,%esp
}
  801b5f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b62:	c9                   	leave  
  801b63:	c3                   	ret    

00801b64 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b64:	55                   	push   %ebp
  801b65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6d:	6a 00                	push   $0x0
  801b6f:	6a 00                	push   $0x0
  801b71:	6a 00                	push   $0x0
  801b73:	52                   	push   %edx
  801b74:	50                   	push   %eax
  801b75:	6a 2f                	push   $0x2f
  801b77:	e8 a8 f9 ff ff       	call   801524 <syscall>
  801b7c:	83 c4 18             	add    $0x18,%esp
}
  801b7f:	c9                   	leave  
  801b80:	c3                   	ret    

00801b81 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801b81:	55                   	push   %ebp
  801b82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801b84:	6a 00                	push   $0x0
  801b86:	6a 00                	push   $0x0
  801b88:	6a 00                	push   $0x0
  801b8a:	ff 75 0c             	pushl  0xc(%ebp)
  801b8d:	ff 75 08             	pushl  0x8(%ebp)
  801b90:	6a 30                	push   $0x30
  801b92:	e8 8d f9 ff ff       	call   801524 <syscall>
  801b97:	83 c4 18             	add    $0x18,%esp
	return ;
  801b9a:	90                   	nop
}
  801b9b:	c9                   	leave  
  801b9c:	c3                   	ret    

00801b9d <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  801b9d:	55                   	push   %ebp
  801b9e:	89 e5                	mov    %esp,%ebp
  801ba0:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  801ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba6:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801ba9:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801bad:	83 ec 0c             	sub    $0xc,%esp
  801bb0:	50                   	push   %eax
  801bb1:	e8 de fb ff ff       	call   801794 <sys_cputc>
  801bb6:	83 c4 10             	add    $0x10,%esp
}
  801bb9:	90                   	nop
  801bba:	c9                   	leave  
  801bbb:	c3                   	ret    

00801bbc <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  801bbc:	55                   	push   %ebp
  801bbd:	89 e5                	mov    %esp,%ebp
  801bbf:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801bc2:	e8 99 fb ff ff       	call   801760 <sys_disable_interrupt>
	char c = ch;
  801bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801bca:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  801bcd:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  801bd1:	83 ec 0c             	sub    $0xc,%esp
  801bd4:	50                   	push   %eax
  801bd5:	e8 ba fb ff ff       	call   801794 <sys_cputc>
  801bda:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  801bdd:	e8 98 fb ff ff       	call   80177a <sys_enable_interrupt>
}
  801be2:	90                   	nop
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <getchar>:

int
getchar(void)
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
  801be8:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  801beb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801bf2:	eb 08                	jmp    801bfc <getchar+0x17>
	{
		c = sys_cgetc();
  801bf4:	e8 7f f9 ff ff       	call   801578 <sys_cgetc>
  801bf9:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  801bfc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801c00:	74 f2                	je     801bf4 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  801c02:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801c05:	c9                   	leave  
  801c06:	c3                   	ret    

00801c07 <atomic_getchar>:

int
atomic_getchar(void)
{
  801c07:	55                   	push   %ebp
  801c08:	89 e5                	mov    %esp,%ebp
  801c0a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801c0d:	e8 4e fb ff ff       	call   801760 <sys_disable_interrupt>
	int c=0;
  801c12:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  801c19:	eb 08                	jmp    801c23 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  801c1b:	e8 58 f9 ff ff       	call   801578 <sys_cgetc>
  801c20:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  801c23:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801c27:	74 f2                	je     801c1b <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  801c29:	e8 4c fb ff ff       	call   80177a <sys_enable_interrupt>
	return c;
  801c2e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801c31:	c9                   	leave  
  801c32:	c3                   	ret    

00801c33 <iscons>:

int iscons(int fdnum)
{
  801c33:	55                   	push   %ebp
  801c34:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  801c36:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801c3b:	5d                   	pop    %ebp
  801c3c:	c3                   	ret    
  801c3d:	66 90                	xchg   %ax,%ax
  801c3f:	90                   	nop

00801c40 <__udivdi3>:
  801c40:	55                   	push   %ebp
  801c41:	57                   	push   %edi
  801c42:	56                   	push   %esi
  801c43:	53                   	push   %ebx
  801c44:	83 ec 1c             	sub    $0x1c,%esp
  801c47:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801c4b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801c4f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c53:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801c57:	89 ca                	mov    %ecx,%edx
  801c59:	89 f8                	mov    %edi,%eax
  801c5b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801c5f:	85 f6                	test   %esi,%esi
  801c61:	75 2d                	jne    801c90 <__udivdi3+0x50>
  801c63:	39 cf                	cmp    %ecx,%edi
  801c65:	77 65                	ja     801ccc <__udivdi3+0x8c>
  801c67:	89 fd                	mov    %edi,%ebp
  801c69:	85 ff                	test   %edi,%edi
  801c6b:	75 0b                	jne    801c78 <__udivdi3+0x38>
  801c6d:	b8 01 00 00 00       	mov    $0x1,%eax
  801c72:	31 d2                	xor    %edx,%edx
  801c74:	f7 f7                	div    %edi
  801c76:	89 c5                	mov    %eax,%ebp
  801c78:	31 d2                	xor    %edx,%edx
  801c7a:	89 c8                	mov    %ecx,%eax
  801c7c:	f7 f5                	div    %ebp
  801c7e:	89 c1                	mov    %eax,%ecx
  801c80:	89 d8                	mov    %ebx,%eax
  801c82:	f7 f5                	div    %ebp
  801c84:	89 cf                	mov    %ecx,%edi
  801c86:	89 fa                	mov    %edi,%edx
  801c88:	83 c4 1c             	add    $0x1c,%esp
  801c8b:	5b                   	pop    %ebx
  801c8c:	5e                   	pop    %esi
  801c8d:	5f                   	pop    %edi
  801c8e:	5d                   	pop    %ebp
  801c8f:	c3                   	ret    
  801c90:	39 ce                	cmp    %ecx,%esi
  801c92:	77 28                	ja     801cbc <__udivdi3+0x7c>
  801c94:	0f bd fe             	bsr    %esi,%edi
  801c97:	83 f7 1f             	xor    $0x1f,%edi
  801c9a:	75 40                	jne    801cdc <__udivdi3+0x9c>
  801c9c:	39 ce                	cmp    %ecx,%esi
  801c9e:	72 0a                	jb     801caa <__udivdi3+0x6a>
  801ca0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801ca4:	0f 87 9e 00 00 00    	ja     801d48 <__udivdi3+0x108>
  801caa:	b8 01 00 00 00       	mov    $0x1,%eax
  801caf:	89 fa                	mov    %edi,%edx
  801cb1:	83 c4 1c             	add    $0x1c,%esp
  801cb4:	5b                   	pop    %ebx
  801cb5:	5e                   	pop    %esi
  801cb6:	5f                   	pop    %edi
  801cb7:	5d                   	pop    %ebp
  801cb8:	c3                   	ret    
  801cb9:	8d 76 00             	lea    0x0(%esi),%esi
  801cbc:	31 ff                	xor    %edi,%edi
  801cbe:	31 c0                	xor    %eax,%eax
  801cc0:	89 fa                	mov    %edi,%edx
  801cc2:	83 c4 1c             	add    $0x1c,%esp
  801cc5:	5b                   	pop    %ebx
  801cc6:	5e                   	pop    %esi
  801cc7:	5f                   	pop    %edi
  801cc8:	5d                   	pop    %ebp
  801cc9:	c3                   	ret    
  801cca:	66 90                	xchg   %ax,%ax
  801ccc:	89 d8                	mov    %ebx,%eax
  801cce:	f7 f7                	div    %edi
  801cd0:	31 ff                	xor    %edi,%edi
  801cd2:	89 fa                	mov    %edi,%edx
  801cd4:	83 c4 1c             	add    $0x1c,%esp
  801cd7:	5b                   	pop    %ebx
  801cd8:	5e                   	pop    %esi
  801cd9:	5f                   	pop    %edi
  801cda:	5d                   	pop    %ebp
  801cdb:	c3                   	ret    
  801cdc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ce1:	89 eb                	mov    %ebp,%ebx
  801ce3:	29 fb                	sub    %edi,%ebx
  801ce5:	89 f9                	mov    %edi,%ecx
  801ce7:	d3 e6                	shl    %cl,%esi
  801ce9:	89 c5                	mov    %eax,%ebp
  801ceb:	88 d9                	mov    %bl,%cl
  801ced:	d3 ed                	shr    %cl,%ebp
  801cef:	89 e9                	mov    %ebp,%ecx
  801cf1:	09 f1                	or     %esi,%ecx
  801cf3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801cf7:	89 f9                	mov    %edi,%ecx
  801cf9:	d3 e0                	shl    %cl,%eax
  801cfb:	89 c5                	mov    %eax,%ebp
  801cfd:	89 d6                	mov    %edx,%esi
  801cff:	88 d9                	mov    %bl,%cl
  801d01:	d3 ee                	shr    %cl,%esi
  801d03:	89 f9                	mov    %edi,%ecx
  801d05:	d3 e2                	shl    %cl,%edx
  801d07:	8b 44 24 08          	mov    0x8(%esp),%eax
  801d0b:	88 d9                	mov    %bl,%cl
  801d0d:	d3 e8                	shr    %cl,%eax
  801d0f:	09 c2                	or     %eax,%edx
  801d11:	89 d0                	mov    %edx,%eax
  801d13:	89 f2                	mov    %esi,%edx
  801d15:	f7 74 24 0c          	divl   0xc(%esp)
  801d19:	89 d6                	mov    %edx,%esi
  801d1b:	89 c3                	mov    %eax,%ebx
  801d1d:	f7 e5                	mul    %ebp
  801d1f:	39 d6                	cmp    %edx,%esi
  801d21:	72 19                	jb     801d3c <__udivdi3+0xfc>
  801d23:	74 0b                	je     801d30 <__udivdi3+0xf0>
  801d25:	89 d8                	mov    %ebx,%eax
  801d27:	31 ff                	xor    %edi,%edi
  801d29:	e9 58 ff ff ff       	jmp    801c86 <__udivdi3+0x46>
  801d2e:	66 90                	xchg   %ax,%ax
  801d30:	8b 54 24 08          	mov    0x8(%esp),%edx
  801d34:	89 f9                	mov    %edi,%ecx
  801d36:	d3 e2                	shl    %cl,%edx
  801d38:	39 c2                	cmp    %eax,%edx
  801d3a:	73 e9                	jae    801d25 <__udivdi3+0xe5>
  801d3c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801d3f:	31 ff                	xor    %edi,%edi
  801d41:	e9 40 ff ff ff       	jmp    801c86 <__udivdi3+0x46>
  801d46:	66 90                	xchg   %ax,%ax
  801d48:	31 c0                	xor    %eax,%eax
  801d4a:	e9 37 ff ff ff       	jmp    801c86 <__udivdi3+0x46>
  801d4f:	90                   	nop

00801d50 <__umoddi3>:
  801d50:	55                   	push   %ebp
  801d51:	57                   	push   %edi
  801d52:	56                   	push   %esi
  801d53:	53                   	push   %ebx
  801d54:	83 ec 1c             	sub    $0x1c,%esp
  801d57:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801d5b:	8b 74 24 34          	mov    0x34(%esp),%esi
  801d5f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801d63:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801d67:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801d6b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801d6f:	89 f3                	mov    %esi,%ebx
  801d71:	89 fa                	mov    %edi,%edx
  801d73:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d77:	89 34 24             	mov    %esi,(%esp)
  801d7a:	85 c0                	test   %eax,%eax
  801d7c:	75 1a                	jne    801d98 <__umoddi3+0x48>
  801d7e:	39 f7                	cmp    %esi,%edi
  801d80:	0f 86 a2 00 00 00    	jbe    801e28 <__umoddi3+0xd8>
  801d86:	89 c8                	mov    %ecx,%eax
  801d88:	89 f2                	mov    %esi,%edx
  801d8a:	f7 f7                	div    %edi
  801d8c:	89 d0                	mov    %edx,%eax
  801d8e:	31 d2                	xor    %edx,%edx
  801d90:	83 c4 1c             	add    $0x1c,%esp
  801d93:	5b                   	pop    %ebx
  801d94:	5e                   	pop    %esi
  801d95:	5f                   	pop    %edi
  801d96:	5d                   	pop    %ebp
  801d97:	c3                   	ret    
  801d98:	39 f0                	cmp    %esi,%eax
  801d9a:	0f 87 ac 00 00 00    	ja     801e4c <__umoddi3+0xfc>
  801da0:	0f bd e8             	bsr    %eax,%ebp
  801da3:	83 f5 1f             	xor    $0x1f,%ebp
  801da6:	0f 84 ac 00 00 00    	je     801e58 <__umoddi3+0x108>
  801dac:	bf 20 00 00 00       	mov    $0x20,%edi
  801db1:	29 ef                	sub    %ebp,%edi
  801db3:	89 fe                	mov    %edi,%esi
  801db5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801db9:	89 e9                	mov    %ebp,%ecx
  801dbb:	d3 e0                	shl    %cl,%eax
  801dbd:	89 d7                	mov    %edx,%edi
  801dbf:	89 f1                	mov    %esi,%ecx
  801dc1:	d3 ef                	shr    %cl,%edi
  801dc3:	09 c7                	or     %eax,%edi
  801dc5:	89 e9                	mov    %ebp,%ecx
  801dc7:	d3 e2                	shl    %cl,%edx
  801dc9:	89 14 24             	mov    %edx,(%esp)
  801dcc:	89 d8                	mov    %ebx,%eax
  801dce:	d3 e0                	shl    %cl,%eax
  801dd0:	89 c2                	mov    %eax,%edx
  801dd2:	8b 44 24 08          	mov    0x8(%esp),%eax
  801dd6:	d3 e0                	shl    %cl,%eax
  801dd8:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ddc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801de0:	89 f1                	mov    %esi,%ecx
  801de2:	d3 e8                	shr    %cl,%eax
  801de4:	09 d0                	or     %edx,%eax
  801de6:	d3 eb                	shr    %cl,%ebx
  801de8:	89 da                	mov    %ebx,%edx
  801dea:	f7 f7                	div    %edi
  801dec:	89 d3                	mov    %edx,%ebx
  801dee:	f7 24 24             	mull   (%esp)
  801df1:	89 c6                	mov    %eax,%esi
  801df3:	89 d1                	mov    %edx,%ecx
  801df5:	39 d3                	cmp    %edx,%ebx
  801df7:	0f 82 87 00 00 00    	jb     801e84 <__umoddi3+0x134>
  801dfd:	0f 84 91 00 00 00    	je     801e94 <__umoddi3+0x144>
  801e03:	8b 54 24 04          	mov    0x4(%esp),%edx
  801e07:	29 f2                	sub    %esi,%edx
  801e09:	19 cb                	sbb    %ecx,%ebx
  801e0b:	89 d8                	mov    %ebx,%eax
  801e0d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801e11:	d3 e0                	shl    %cl,%eax
  801e13:	89 e9                	mov    %ebp,%ecx
  801e15:	d3 ea                	shr    %cl,%edx
  801e17:	09 d0                	or     %edx,%eax
  801e19:	89 e9                	mov    %ebp,%ecx
  801e1b:	d3 eb                	shr    %cl,%ebx
  801e1d:	89 da                	mov    %ebx,%edx
  801e1f:	83 c4 1c             	add    $0x1c,%esp
  801e22:	5b                   	pop    %ebx
  801e23:	5e                   	pop    %esi
  801e24:	5f                   	pop    %edi
  801e25:	5d                   	pop    %ebp
  801e26:	c3                   	ret    
  801e27:	90                   	nop
  801e28:	89 fd                	mov    %edi,%ebp
  801e2a:	85 ff                	test   %edi,%edi
  801e2c:	75 0b                	jne    801e39 <__umoddi3+0xe9>
  801e2e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e33:	31 d2                	xor    %edx,%edx
  801e35:	f7 f7                	div    %edi
  801e37:	89 c5                	mov    %eax,%ebp
  801e39:	89 f0                	mov    %esi,%eax
  801e3b:	31 d2                	xor    %edx,%edx
  801e3d:	f7 f5                	div    %ebp
  801e3f:	89 c8                	mov    %ecx,%eax
  801e41:	f7 f5                	div    %ebp
  801e43:	89 d0                	mov    %edx,%eax
  801e45:	e9 44 ff ff ff       	jmp    801d8e <__umoddi3+0x3e>
  801e4a:	66 90                	xchg   %ax,%ax
  801e4c:	89 c8                	mov    %ecx,%eax
  801e4e:	89 f2                	mov    %esi,%edx
  801e50:	83 c4 1c             	add    $0x1c,%esp
  801e53:	5b                   	pop    %ebx
  801e54:	5e                   	pop    %esi
  801e55:	5f                   	pop    %edi
  801e56:	5d                   	pop    %ebp
  801e57:	c3                   	ret    
  801e58:	3b 04 24             	cmp    (%esp),%eax
  801e5b:	72 06                	jb     801e63 <__umoddi3+0x113>
  801e5d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801e61:	77 0f                	ja     801e72 <__umoddi3+0x122>
  801e63:	89 f2                	mov    %esi,%edx
  801e65:	29 f9                	sub    %edi,%ecx
  801e67:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801e6b:	89 14 24             	mov    %edx,(%esp)
  801e6e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801e72:	8b 44 24 04          	mov    0x4(%esp),%eax
  801e76:	8b 14 24             	mov    (%esp),%edx
  801e79:	83 c4 1c             	add    $0x1c,%esp
  801e7c:	5b                   	pop    %ebx
  801e7d:	5e                   	pop    %esi
  801e7e:	5f                   	pop    %edi
  801e7f:	5d                   	pop    %ebp
  801e80:	c3                   	ret    
  801e81:	8d 76 00             	lea    0x0(%esi),%esi
  801e84:	2b 04 24             	sub    (%esp),%eax
  801e87:	19 fa                	sbb    %edi,%edx
  801e89:	89 d1                	mov    %edx,%ecx
  801e8b:	89 c6                	mov    %eax,%esi
  801e8d:	e9 71 ff ff ff       	jmp    801e03 <__umoddi3+0xb3>
  801e92:	66 90                	xchg   %ax,%ax
  801e94:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801e98:	72 ea                	jb     801e84 <__umoddi3+0x134>
  801e9a:	89 d9                	mov    %ebx,%ecx
  801e9c:	e9 62 ff ff ff       	jmp    801e03 <__umoddi3+0xb3>
