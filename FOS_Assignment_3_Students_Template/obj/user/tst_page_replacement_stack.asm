
obj/user/tst_page_replacement_stack:     file format elf32-i386


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
  800031:	e8 f9 00 00 00       	call   80012f <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 14 a0 00 00    	sub    $0xa014,%esp
	char arr[PAGE_SIZE*10];

	uint32 kilo = 1024;
  800042:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)

//	cprintf("envID = %d\n",envID);

	int freePages = sys_calculate_free_frames();
  800049:	e8 a7 13 00 00       	call   8013f5 <sys_calculate_free_frames>
  80004e:	89 45 ec             	mov    %eax,-0x14(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  800051:	e8 22 14 00 00       	call   801478 <sys_pf_calculate_allocated_pages>
  800056:	89 45 e8             	mov    %eax,-0x18(%ebp)

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800059:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800060:	eb 15                	jmp    800077 <_main+0x3f>
		arr[i] = -1 ;
  800062:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  800068:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80006b:	01 d0                	add    %edx,%eax
  80006d:	c6 00 ff             	movb   $0xff,(%eax)

	int freePages = sys_calculate_free_frames();
	int usedDiskPages = sys_pf_calculate_allocated_pages();

	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800070:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  800077:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  80007e:	7e e2                	jle    800062 <_main+0x2a>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
  800080:	83 ec 0c             	sub    $0xc,%esp
  800083:	68 80 1b 80 00       	push   $0x801b80
  800088:	e8 72 04 00 00       	call   8004ff <cprintf>
  80008d:	83 c4 10             	add    $0x10,%esp
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800090:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800097:	eb 2c                	jmp    8000c5 <_main+0x8d>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");
  800099:	8d 95 e8 5f ff ff    	lea    -0xa018(%ebp),%edx
  80009f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	8a 00                	mov    (%eax),%al
  8000a6:	3c ff                	cmp    $0xff,%al
  8000a8:	74 14                	je     8000be <_main+0x86>
  8000aa:	83 ec 04             	sub    $0x4,%esp
  8000ad:	68 b8 1b 80 00       	push   $0x801bb8
  8000b2:	6a 1a                	push   $0x1a
  8000b4:	68 e8 1b 80 00       	push   $0x801be8
  8000b9:	e8 8d 01 00 00       	call   80024b <_panic>
		arr[i] = -1 ;


	cprintf("checking REPLACEMENT fault handling of STACK pages... \n");
	{
		for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8000be:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  8000c5:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  8000cc:	7e cb                	jle    800099 <_main+0x61>
			if( arr[i] != -1) panic("modified stack page(s) not restored correctly");

		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  9) panic("Unexpected extra/less pages have been added to page file");
  8000ce:	e8 a5 13 00 00       	call   801478 <sys_pf_calculate_allocated_pages>
  8000d3:	2b 45 e8             	sub    -0x18(%ebp),%eax
  8000d6:	83 f8 09             	cmp    $0x9,%eax
  8000d9:	74 14                	je     8000ef <_main+0xb7>
  8000db:	83 ec 04             	sub    $0x4,%esp
  8000de:	68 0c 1c 80 00       	push   $0x801c0c
  8000e3:	6a 1c                	push   $0x1c
  8000e5:	68 e8 1b 80 00       	push   $0x801be8
  8000ea:	e8 5c 01 00 00       	call   80024b <_panic>

		if( (freePages - (sys_calculate_free_frames() + sys_calculate_modified_frames())) != 0 ) panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  8000ef:	e8 01 13 00 00       	call   8013f5 <sys_calculate_free_frames>
  8000f4:	89 c3                	mov    %eax,%ebx
  8000f6:	e8 13 13 00 00       	call   80140e <sys_calculate_modified_frames>
  8000fb:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	39 c2                	cmp    %eax,%edx
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 48 1c 80 00       	push   $0x801c48
  80010d:	6a 1e                	push   $0x1e
  80010f:	68 e8 1b 80 00       	push   $0x801be8
  800114:	e8 32 01 00 00       	call   80024b <_panic>
	}

	cprintf("Congratulations: stack pages created, modified and read successfully!\n\n");
  800119:	83 ec 0c             	sub    $0xc,%esp
  80011c:	68 ac 1c 80 00       	push   $0x801cac
  800121:	e8 d9 03 00 00       	call   8004ff <cprintf>
  800126:	83 c4 10             	add    $0x10,%esp


	return;
  800129:	90                   	nop
}
  80012a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80012d:	c9                   	leave  
  80012e:	c3                   	ret    

0080012f <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80012f:	55                   	push   %ebp
  800130:	89 e5                	mov    %esp,%ebp
  800132:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800135:	e8 f0 11 00 00       	call   80132a <sys_getenvindex>
  80013a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80013d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800140:	89 d0                	mov    %edx,%eax
  800142:	01 c0                	add    %eax,%eax
  800144:	01 d0                	add    %edx,%eax
  800146:	c1 e0 04             	shl    $0x4,%eax
  800149:	29 d0                	sub    %edx,%eax
  80014b:	c1 e0 03             	shl    $0x3,%eax
  80014e:	01 d0                	add    %edx,%eax
  800150:	c1 e0 02             	shl    $0x2,%eax
  800153:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800158:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80015d:	a1 20 30 80 00       	mov    0x803020,%eax
  800162:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800168:	84 c0                	test   %al,%al
  80016a:	74 0f                	je     80017b <libmain+0x4c>
		binaryname = myEnv->prog_name;
  80016c:	a1 20 30 80 00       	mov    0x803020,%eax
  800171:	05 5c 05 00 00       	add    $0x55c,%eax
  800176:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80017b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80017f:	7e 0a                	jle    80018b <libmain+0x5c>
		binaryname = argv[0];
  800181:	8b 45 0c             	mov    0xc(%ebp),%eax
  800184:	8b 00                	mov    (%eax),%eax
  800186:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80018b:	83 ec 08             	sub    $0x8,%esp
  80018e:	ff 75 0c             	pushl  0xc(%ebp)
  800191:	ff 75 08             	pushl  0x8(%ebp)
  800194:	e8 9f fe ff ff       	call   800038 <_main>
  800199:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80019c:	e8 24 13 00 00       	call   8014c5 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001a1:	83 ec 0c             	sub    $0xc,%esp
  8001a4:	68 0c 1d 80 00       	push   $0x801d0c
  8001a9:	e8 51 03 00 00       	call   8004ff <cprintf>
  8001ae:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b6:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8001bc:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c1:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8001c7:	83 ec 04             	sub    $0x4,%esp
  8001ca:	52                   	push   %edx
  8001cb:	50                   	push   %eax
  8001cc:	68 34 1d 80 00       	push   $0x801d34
  8001d1:	e8 29 03 00 00       	call   8004ff <cprintf>
  8001d6:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8001d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8001de:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8001e4:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e9:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8001ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f4:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8001fa:	51                   	push   %ecx
  8001fb:	52                   	push   %edx
  8001fc:	50                   	push   %eax
  8001fd:	68 5c 1d 80 00       	push   $0x801d5c
  800202:	e8 f8 02 00 00       	call   8004ff <cprintf>
  800207:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80020a:	83 ec 0c             	sub    $0xc,%esp
  80020d:	68 0c 1d 80 00       	push   $0x801d0c
  800212:	e8 e8 02 00 00       	call   8004ff <cprintf>
  800217:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80021a:	e8 c0 12 00 00       	call   8014df <sys_enable_interrupt>

	// exit gracefully
	exit();
  80021f:	e8 19 00 00 00       	call   80023d <exit>
}
  800224:	90                   	nop
  800225:	c9                   	leave  
  800226:	c3                   	ret    

00800227 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800227:	55                   	push   %ebp
  800228:	89 e5                	mov    %esp,%ebp
  80022a:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	6a 00                	push   $0x0
  800232:	e8 bf 10 00 00       	call   8012f6 <sys_env_destroy>
  800237:	83 c4 10             	add    $0x10,%esp
}
  80023a:	90                   	nop
  80023b:	c9                   	leave  
  80023c:	c3                   	ret    

0080023d <exit>:

void
exit(void)
{
  80023d:	55                   	push   %ebp
  80023e:	89 e5                	mov    %esp,%ebp
  800240:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800243:	e8 14 11 00 00       	call   80135c <sys_env_exit>
}
  800248:	90                   	nop
  800249:	c9                   	leave  
  80024a:	c3                   	ret    

0080024b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80024b:	55                   	push   %ebp
  80024c:	89 e5                	mov    %esp,%ebp
  80024e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800251:	8d 45 10             	lea    0x10(%ebp),%eax
  800254:	83 c0 04             	add    $0x4,%eax
  800257:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80025a:	a1 18 31 80 00       	mov    0x803118,%eax
  80025f:	85 c0                	test   %eax,%eax
  800261:	74 16                	je     800279 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800263:	a1 18 31 80 00       	mov    0x803118,%eax
  800268:	83 ec 08             	sub    $0x8,%esp
  80026b:	50                   	push   %eax
  80026c:	68 b4 1d 80 00       	push   $0x801db4
  800271:	e8 89 02 00 00       	call   8004ff <cprintf>
  800276:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800279:	a1 00 30 80 00       	mov    0x803000,%eax
  80027e:	ff 75 0c             	pushl  0xc(%ebp)
  800281:	ff 75 08             	pushl  0x8(%ebp)
  800284:	50                   	push   %eax
  800285:	68 b9 1d 80 00       	push   $0x801db9
  80028a:	e8 70 02 00 00       	call   8004ff <cprintf>
  80028f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800292:	8b 45 10             	mov    0x10(%ebp),%eax
  800295:	83 ec 08             	sub    $0x8,%esp
  800298:	ff 75 f4             	pushl  -0xc(%ebp)
  80029b:	50                   	push   %eax
  80029c:	e8 f3 01 00 00       	call   800494 <vcprintf>
  8002a1:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8002a4:	83 ec 08             	sub    $0x8,%esp
  8002a7:	6a 00                	push   $0x0
  8002a9:	68 d5 1d 80 00       	push   $0x801dd5
  8002ae:	e8 e1 01 00 00       	call   800494 <vcprintf>
  8002b3:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8002b6:	e8 82 ff ff ff       	call   80023d <exit>

	// should not return here
	while (1) ;
  8002bb:	eb fe                	jmp    8002bb <_panic+0x70>

008002bd <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8002bd:	55                   	push   %ebp
  8002be:	89 e5                	mov    %esp,%ebp
  8002c0:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8002c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002c8:	8b 50 74             	mov    0x74(%eax),%edx
  8002cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ce:	39 c2                	cmp    %eax,%edx
  8002d0:	74 14                	je     8002e6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8002d2:	83 ec 04             	sub    $0x4,%esp
  8002d5:	68 d8 1d 80 00       	push   $0x801dd8
  8002da:	6a 26                	push   $0x26
  8002dc:	68 24 1e 80 00       	push   $0x801e24
  8002e1:	e8 65 ff ff ff       	call   80024b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8002e6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8002ed:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002f4:	e9 c2 00 00 00       	jmp    8003bb <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8002f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002fc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800303:	8b 45 08             	mov    0x8(%ebp),%eax
  800306:	01 d0                	add    %edx,%eax
  800308:	8b 00                	mov    (%eax),%eax
  80030a:	85 c0                	test   %eax,%eax
  80030c:	75 08                	jne    800316 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80030e:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800311:	e9 a2 00 00 00       	jmp    8003b8 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800316:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80031d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800324:	eb 69                	jmp    80038f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800326:	a1 20 30 80 00       	mov    0x803020,%eax
  80032b:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800331:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800334:	89 d0                	mov    %edx,%eax
  800336:	01 c0                	add    %eax,%eax
  800338:	01 d0                	add    %edx,%eax
  80033a:	c1 e0 03             	shl    $0x3,%eax
  80033d:	01 c8                	add    %ecx,%eax
  80033f:	8a 40 04             	mov    0x4(%eax),%al
  800342:	84 c0                	test   %al,%al
  800344:	75 46                	jne    80038c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800346:	a1 20 30 80 00       	mov    0x803020,%eax
  80034b:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800351:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800354:	89 d0                	mov    %edx,%eax
  800356:	01 c0                	add    %eax,%eax
  800358:	01 d0                	add    %edx,%eax
  80035a:	c1 e0 03             	shl    $0x3,%eax
  80035d:	01 c8                	add    %ecx,%eax
  80035f:	8b 00                	mov    (%eax),%eax
  800361:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800364:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800367:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80036c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80036e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800371:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800378:	8b 45 08             	mov    0x8(%ebp),%eax
  80037b:	01 c8                	add    %ecx,%eax
  80037d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80037f:	39 c2                	cmp    %eax,%edx
  800381:	75 09                	jne    80038c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800383:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80038a:	eb 12                	jmp    80039e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80038c:	ff 45 e8             	incl   -0x18(%ebp)
  80038f:	a1 20 30 80 00       	mov    0x803020,%eax
  800394:	8b 50 74             	mov    0x74(%eax),%edx
  800397:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80039a:	39 c2                	cmp    %eax,%edx
  80039c:	77 88                	ja     800326 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80039e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8003a2:	75 14                	jne    8003b8 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8003a4:	83 ec 04             	sub    $0x4,%esp
  8003a7:	68 30 1e 80 00       	push   $0x801e30
  8003ac:	6a 3a                	push   $0x3a
  8003ae:	68 24 1e 80 00       	push   $0x801e24
  8003b3:	e8 93 fe ff ff       	call   80024b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8003b8:	ff 45 f0             	incl   -0x10(%ebp)
  8003bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003be:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003c1:	0f 8c 32 ff ff ff    	jl     8002f9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8003c7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003ce:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8003d5:	eb 26                	jmp    8003fd <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8003d7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003dc:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8003e2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8003e5:	89 d0                	mov    %edx,%eax
  8003e7:	01 c0                	add    %eax,%eax
  8003e9:	01 d0                	add    %edx,%eax
  8003eb:	c1 e0 03             	shl    $0x3,%eax
  8003ee:	01 c8                	add    %ecx,%eax
  8003f0:	8a 40 04             	mov    0x4(%eax),%al
  8003f3:	3c 01                	cmp    $0x1,%al
  8003f5:	75 03                	jne    8003fa <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8003f7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8003fa:	ff 45 e0             	incl   -0x20(%ebp)
  8003fd:	a1 20 30 80 00       	mov    0x803020,%eax
  800402:	8b 50 74             	mov    0x74(%eax),%edx
  800405:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800408:	39 c2                	cmp    %eax,%edx
  80040a:	77 cb                	ja     8003d7 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80040c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80040f:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800412:	74 14                	je     800428 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800414:	83 ec 04             	sub    $0x4,%esp
  800417:	68 84 1e 80 00       	push   $0x801e84
  80041c:	6a 44                	push   $0x44
  80041e:	68 24 1e 80 00       	push   $0x801e24
  800423:	e8 23 fe ff ff       	call   80024b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800428:	90                   	nop
  800429:	c9                   	leave  
  80042a:	c3                   	ret    

0080042b <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80042b:	55                   	push   %ebp
  80042c:	89 e5                	mov    %esp,%ebp
  80042e:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800431:	8b 45 0c             	mov    0xc(%ebp),%eax
  800434:	8b 00                	mov    (%eax),%eax
  800436:	8d 48 01             	lea    0x1(%eax),%ecx
  800439:	8b 55 0c             	mov    0xc(%ebp),%edx
  80043c:	89 0a                	mov    %ecx,(%edx)
  80043e:	8b 55 08             	mov    0x8(%ebp),%edx
  800441:	88 d1                	mov    %dl,%cl
  800443:	8b 55 0c             	mov    0xc(%ebp),%edx
  800446:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80044a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044d:	8b 00                	mov    (%eax),%eax
  80044f:	3d ff 00 00 00       	cmp    $0xff,%eax
  800454:	75 2c                	jne    800482 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800456:	a0 24 30 80 00       	mov    0x803024,%al
  80045b:	0f b6 c0             	movzbl %al,%eax
  80045e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800461:	8b 12                	mov    (%edx),%edx
  800463:	89 d1                	mov    %edx,%ecx
  800465:	8b 55 0c             	mov    0xc(%ebp),%edx
  800468:	83 c2 08             	add    $0x8,%edx
  80046b:	83 ec 04             	sub    $0x4,%esp
  80046e:	50                   	push   %eax
  80046f:	51                   	push   %ecx
  800470:	52                   	push   %edx
  800471:	e8 3e 0e 00 00       	call   8012b4 <sys_cputs>
  800476:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800479:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800482:	8b 45 0c             	mov    0xc(%ebp),%eax
  800485:	8b 40 04             	mov    0x4(%eax),%eax
  800488:	8d 50 01             	lea    0x1(%eax),%edx
  80048b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80048e:	89 50 04             	mov    %edx,0x4(%eax)
}
  800491:	90                   	nop
  800492:	c9                   	leave  
  800493:	c3                   	ret    

00800494 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800494:	55                   	push   %ebp
  800495:	89 e5                	mov    %esp,%ebp
  800497:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80049d:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8004a4:	00 00 00 
	b.cnt = 0;
  8004a7:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8004ae:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8004b1:	ff 75 0c             	pushl  0xc(%ebp)
  8004b4:	ff 75 08             	pushl  0x8(%ebp)
  8004b7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004bd:	50                   	push   %eax
  8004be:	68 2b 04 80 00       	push   $0x80042b
  8004c3:	e8 11 02 00 00       	call   8006d9 <vprintfmt>
  8004c8:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8004cb:	a0 24 30 80 00       	mov    0x803024,%al
  8004d0:	0f b6 c0             	movzbl %al,%eax
  8004d3:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8004d9:	83 ec 04             	sub    $0x4,%esp
  8004dc:	50                   	push   %eax
  8004dd:	52                   	push   %edx
  8004de:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8004e4:	83 c0 08             	add    $0x8,%eax
  8004e7:	50                   	push   %eax
  8004e8:	e8 c7 0d 00 00       	call   8012b4 <sys_cputs>
  8004ed:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8004f0:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8004f7:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8004fd:	c9                   	leave  
  8004fe:	c3                   	ret    

008004ff <cprintf>:

int cprintf(const char *fmt, ...) {
  8004ff:	55                   	push   %ebp
  800500:	89 e5                	mov    %esp,%ebp
  800502:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800505:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80050c:	8d 45 0c             	lea    0xc(%ebp),%eax
  80050f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800512:	8b 45 08             	mov    0x8(%ebp),%eax
  800515:	83 ec 08             	sub    $0x8,%esp
  800518:	ff 75 f4             	pushl  -0xc(%ebp)
  80051b:	50                   	push   %eax
  80051c:	e8 73 ff ff ff       	call   800494 <vcprintf>
  800521:	83 c4 10             	add    $0x10,%esp
  800524:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800527:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80052a:	c9                   	leave  
  80052b:	c3                   	ret    

0080052c <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80052c:	55                   	push   %ebp
  80052d:	89 e5                	mov    %esp,%ebp
  80052f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800532:	e8 8e 0f 00 00       	call   8014c5 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800537:	8d 45 0c             	lea    0xc(%ebp),%eax
  80053a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	83 ec 08             	sub    $0x8,%esp
  800543:	ff 75 f4             	pushl  -0xc(%ebp)
  800546:	50                   	push   %eax
  800547:	e8 48 ff ff ff       	call   800494 <vcprintf>
  80054c:	83 c4 10             	add    $0x10,%esp
  80054f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800552:	e8 88 0f 00 00       	call   8014df <sys_enable_interrupt>
	return cnt;
  800557:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80055a:	c9                   	leave  
  80055b:	c3                   	ret    

0080055c <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80055c:	55                   	push   %ebp
  80055d:	89 e5                	mov    %esp,%ebp
  80055f:	53                   	push   %ebx
  800560:	83 ec 14             	sub    $0x14,%esp
  800563:	8b 45 10             	mov    0x10(%ebp),%eax
  800566:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800569:	8b 45 14             	mov    0x14(%ebp),%eax
  80056c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  80056f:	8b 45 18             	mov    0x18(%ebp),%eax
  800572:	ba 00 00 00 00       	mov    $0x0,%edx
  800577:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80057a:	77 55                	ja     8005d1 <printnum+0x75>
  80057c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80057f:	72 05                	jb     800586 <printnum+0x2a>
  800581:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800584:	77 4b                	ja     8005d1 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800586:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800589:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80058c:	8b 45 18             	mov    0x18(%ebp),%eax
  80058f:	ba 00 00 00 00       	mov    $0x0,%edx
  800594:	52                   	push   %edx
  800595:	50                   	push   %eax
  800596:	ff 75 f4             	pushl  -0xc(%ebp)
  800599:	ff 75 f0             	pushl  -0x10(%ebp)
  80059c:	e8 63 13 00 00       	call   801904 <__udivdi3>
  8005a1:	83 c4 10             	add    $0x10,%esp
  8005a4:	83 ec 04             	sub    $0x4,%esp
  8005a7:	ff 75 20             	pushl  0x20(%ebp)
  8005aa:	53                   	push   %ebx
  8005ab:	ff 75 18             	pushl  0x18(%ebp)
  8005ae:	52                   	push   %edx
  8005af:	50                   	push   %eax
  8005b0:	ff 75 0c             	pushl  0xc(%ebp)
  8005b3:	ff 75 08             	pushl  0x8(%ebp)
  8005b6:	e8 a1 ff ff ff       	call   80055c <printnum>
  8005bb:	83 c4 20             	add    $0x20,%esp
  8005be:	eb 1a                	jmp    8005da <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8005c0:	83 ec 08             	sub    $0x8,%esp
  8005c3:	ff 75 0c             	pushl  0xc(%ebp)
  8005c6:	ff 75 20             	pushl  0x20(%ebp)
  8005c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005cc:	ff d0                	call   *%eax
  8005ce:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8005d1:	ff 4d 1c             	decl   0x1c(%ebp)
  8005d4:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8005d8:	7f e6                	jg     8005c0 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8005da:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8005dd:	bb 00 00 00 00       	mov    $0x0,%ebx
  8005e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005e8:	53                   	push   %ebx
  8005e9:	51                   	push   %ecx
  8005ea:	52                   	push   %edx
  8005eb:	50                   	push   %eax
  8005ec:	e8 23 14 00 00       	call   801a14 <__umoddi3>
  8005f1:	83 c4 10             	add    $0x10,%esp
  8005f4:	05 f4 20 80 00       	add    $0x8020f4,%eax
  8005f9:	8a 00                	mov    (%eax),%al
  8005fb:	0f be c0             	movsbl %al,%eax
  8005fe:	83 ec 08             	sub    $0x8,%esp
  800601:	ff 75 0c             	pushl  0xc(%ebp)
  800604:	50                   	push   %eax
  800605:	8b 45 08             	mov    0x8(%ebp),%eax
  800608:	ff d0                	call   *%eax
  80060a:	83 c4 10             	add    $0x10,%esp
}
  80060d:	90                   	nop
  80060e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800611:	c9                   	leave  
  800612:	c3                   	ret    

00800613 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800613:	55                   	push   %ebp
  800614:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800616:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80061a:	7e 1c                	jle    800638 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80061c:	8b 45 08             	mov    0x8(%ebp),%eax
  80061f:	8b 00                	mov    (%eax),%eax
  800621:	8d 50 08             	lea    0x8(%eax),%edx
  800624:	8b 45 08             	mov    0x8(%ebp),%eax
  800627:	89 10                	mov    %edx,(%eax)
  800629:	8b 45 08             	mov    0x8(%ebp),%eax
  80062c:	8b 00                	mov    (%eax),%eax
  80062e:	83 e8 08             	sub    $0x8,%eax
  800631:	8b 50 04             	mov    0x4(%eax),%edx
  800634:	8b 00                	mov    (%eax),%eax
  800636:	eb 40                	jmp    800678 <getuint+0x65>
	else if (lflag)
  800638:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80063c:	74 1e                	je     80065c <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80063e:	8b 45 08             	mov    0x8(%ebp),%eax
  800641:	8b 00                	mov    (%eax),%eax
  800643:	8d 50 04             	lea    0x4(%eax),%edx
  800646:	8b 45 08             	mov    0x8(%ebp),%eax
  800649:	89 10                	mov    %edx,(%eax)
  80064b:	8b 45 08             	mov    0x8(%ebp),%eax
  80064e:	8b 00                	mov    (%eax),%eax
  800650:	83 e8 04             	sub    $0x4,%eax
  800653:	8b 00                	mov    (%eax),%eax
  800655:	ba 00 00 00 00       	mov    $0x0,%edx
  80065a:	eb 1c                	jmp    800678 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80065c:	8b 45 08             	mov    0x8(%ebp),%eax
  80065f:	8b 00                	mov    (%eax),%eax
  800661:	8d 50 04             	lea    0x4(%eax),%edx
  800664:	8b 45 08             	mov    0x8(%ebp),%eax
  800667:	89 10                	mov    %edx,(%eax)
  800669:	8b 45 08             	mov    0x8(%ebp),%eax
  80066c:	8b 00                	mov    (%eax),%eax
  80066e:	83 e8 04             	sub    $0x4,%eax
  800671:	8b 00                	mov    (%eax),%eax
  800673:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800678:	5d                   	pop    %ebp
  800679:	c3                   	ret    

0080067a <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80067a:	55                   	push   %ebp
  80067b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80067d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800681:	7e 1c                	jle    80069f <getint+0x25>
		return va_arg(*ap, long long);
  800683:	8b 45 08             	mov    0x8(%ebp),%eax
  800686:	8b 00                	mov    (%eax),%eax
  800688:	8d 50 08             	lea    0x8(%eax),%edx
  80068b:	8b 45 08             	mov    0x8(%ebp),%eax
  80068e:	89 10                	mov    %edx,(%eax)
  800690:	8b 45 08             	mov    0x8(%ebp),%eax
  800693:	8b 00                	mov    (%eax),%eax
  800695:	83 e8 08             	sub    $0x8,%eax
  800698:	8b 50 04             	mov    0x4(%eax),%edx
  80069b:	8b 00                	mov    (%eax),%eax
  80069d:	eb 38                	jmp    8006d7 <getint+0x5d>
	else if (lflag)
  80069f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8006a3:	74 1a                	je     8006bf <getint+0x45>
		return va_arg(*ap, long);
  8006a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8006a8:	8b 00                	mov    (%eax),%eax
  8006aa:	8d 50 04             	lea    0x4(%eax),%edx
  8006ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b0:	89 10                	mov    %edx,(%eax)
  8006b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006b5:	8b 00                	mov    (%eax),%eax
  8006b7:	83 e8 04             	sub    $0x4,%eax
  8006ba:	8b 00                	mov    (%eax),%eax
  8006bc:	99                   	cltd   
  8006bd:	eb 18                	jmp    8006d7 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8006bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c2:	8b 00                	mov    (%eax),%eax
  8006c4:	8d 50 04             	lea    0x4(%eax),%edx
  8006c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ca:	89 10                	mov    %edx,(%eax)
  8006cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cf:	8b 00                	mov    (%eax),%eax
  8006d1:	83 e8 04             	sub    $0x4,%eax
  8006d4:	8b 00                	mov    (%eax),%eax
  8006d6:	99                   	cltd   
}
  8006d7:	5d                   	pop    %ebp
  8006d8:	c3                   	ret    

008006d9 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8006d9:	55                   	push   %ebp
  8006da:	89 e5                	mov    %esp,%ebp
  8006dc:	56                   	push   %esi
  8006dd:	53                   	push   %ebx
  8006de:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006e1:	eb 17                	jmp    8006fa <vprintfmt+0x21>
			if (ch == '\0')
  8006e3:	85 db                	test   %ebx,%ebx
  8006e5:	0f 84 af 03 00 00    	je     800a9a <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8006eb:	83 ec 08             	sub    $0x8,%esp
  8006ee:	ff 75 0c             	pushl  0xc(%ebp)
  8006f1:	53                   	push   %ebx
  8006f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f5:	ff d0                	call   *%eax
  8006f7:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8006fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8006fd:	8d 50 01             	lea    0x1(%eax),%edx
  800700:	89 55 10             	mov    %edx,0x10(%ebp)
  800703:	8a 00                	mov    (%eax),%al
  800705:	0f b6 d8             	movzbl %al,%ebx
  800708:	83 fb 25             	cmp    $0x25,%ebx
  80070b:	75 d6                	jne    8006e3 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80070d:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800711:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800718:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80071f:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800726:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80072d:	8b 45 10             	mov    0x10(%ebp),%eax
  800730:	8d 50 01             	lea    0x1(%eax),%edx
  800733:	89 55 10             	mov    %edx,0x10(%ebp)
  800736:	8a 00                	mov    (%eax),%al
  800738:	0f b6 d8             	movzbl %al,%ebx
  80073b:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80073e:	83 f8 55             	cmp    $0x55,%eax
  800741:	0f 87 2b 03 00 00    	ja     800a72 <vprintfmt+0x399>
  800747:	8b 04 85 18 21 80 00 	mov    0x802118(,%eax,4),%eax
  80074e:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800750:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800754:	eb d7                	jmp    80072d <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800756:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80075a:	eb d1                	jmp    80072d <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80075c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800763:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800766:	89 d0                	mov    %edx,%eax
  800768:	c1 e0 02             	shl    $0x2,%eax
  80076b:	01 d0                	add    %edx,%eax
  80076d:	01 c0                	add    %eax,%eax
  80076f:	01 d8                	add    %ebx,%eax
  800771:	83 e8 30             	sub    $0x30,%eax
  800774:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800777:	8b 45 10             	mov    0x10(%ebp),%eax
  80077a:	8a 00                	mov    (%eax),%al
  80077c:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  80077f:	83 fb 2f             	cmp    $0x2f,%ebx
  800782:	7e 3e                	jle    8007c2 <vprintfmt+0xe9>
  800784:	83 fb 39             	cmp    $0x39,%ebx
  800787:	7f 39                	jg     8007c2 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800789:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80078c:	eb d5                	jmp    800763 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  80078e:	8b 45 14             	mov    0x14(%ebp),%eax
  800791:	83 c0 04             	add    $0x4,%eax
  800794:	89 45 14             	mov    %eax,0x14(%ebp)
  800797:	8b 45 14             	mov    0x14(%ebp),%eax
  80079a:	83 e8 04             	sub    $0x4,%eax
  80079d:	8b 00                	mov    (%eax),%eax
  80079f:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8007a2:	eb 1f                	jmp    8007c3 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8007a4:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007a8:	79 83                	jns    80072d <vprintfmt+0x54>
				width = 0;
  8007aa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8007b1:	e9 77 ff ff ff       	jmp    80072d <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8007b6:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8007bd:	e9 6b ff ff ff       	jmp    80072d <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8007c2:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8007c3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007c7:	0f 89 60 ff ff ff    	jns    80072d <vprintfmt+0x54>
				width = precision, precision = -1;
  8007cd:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8007d3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8007da:	e9 4e ff ff ff       	jmp    80072d <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8007df:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8007e2:	e9 46 ff ff ff       	jmp    80072d <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8007e7:	8b 45 14             	mov    0x14(%ebp),%eax
  8007ea:	83 c0 04             	add    $0x4,%eax
  8007ed:	89 45 14             	mov    %eax,0x14(%ebp)
  8007f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8007f3:	83 e8 04             	sub    $0x4,%eax
  8007f6:	8b 00                	mov    (%eax),%eax
  8007f8:	83 ec 08             	sub    $0x8,%esp
  8007fb:	ff 75 0c             	pushl  0xc(%ebp)
  8007fe:	50                   	push   %eax
  8007ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800802:	ff d0                	call   *%eax
  800804:	83 c4 10             	add    $0x10,%esp
			break;
  800807:	e9 89 02 00 00       	jmp    800a95 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80080c:	8b 45 14             	mov    0x14(%ebp),%eax
  80080f:	83 c0 04             	add    $0x4,%eax
  800812:	89 45 14             	mov    %eax,0x14(%ebp)
  800815:	8b 45 14             	mov    0x14(%ebp),%eax
  800818:	83 e8 04             	sub    $0x4,%eax
  80081b:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80081d:	85 db                	test   %ebx,%ebx
  80081f:	79 02                	jns    800823 <vprintfmt+0x14a>
				err = -err;
  800821:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800823:	83 fb 64             	cmp    $0x64,%ebx
  800826:	7f 0b                	jg     800833 <vprintfmt+0x15a>
  800828:	8b 34 9d 60 1f 80 00 	mov    0x801f60(,%ebx,4),%esi
  80082f:	85 f6                	test   %esi,%esi
  800831:	75 19                	jne    80084c <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800833:	53                   	push   %ebx
  800834:	68 05 21 80 00       	push   $0x802105
  800839:	ff 75 0c             	pushl  0xc(%ebp)
  80083c:	ff 75 08             	pushl  0x8(%ebp)
  80083f:	e8 5e 02 00 00       	call   800aa2 <printfmt>
  800844:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800847:	e9 49 02 00 00       	jmp    800a95 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  80084c:	56                   	push   %esi
  80084d:	68 0e 21 80 00       	push   $0x80210e
  800852:	ff 75 0c             	pushl  0xc(%ebp)
  800855:	ff 75 08             	pushl  0x8(%ebp)
  800858:	e8 45 02 00 00       	call   800aa2 <printfmt>
  80085d:	83 c4 10             	add    $0x10,%esp
			break;
  800860:	e9 30 02 00 00       	jmp    800a95 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800865:	8b 45 14             	mov    0x14(%ebp),%eax
  800868:	83 c0 04             	add    $0x4,%eax
  80086b:	89 45 14             	mov    %eax,0x14(%ebp)
  80086e:	8b 45 14             	mov    0x14(%ebp),%eax
  800871:	83 e8 04             	sub    $0x4,%eax
  800874:	8b 30                	mov    (%eax),%esi
  800876:	85 f6                	test   %esi,%esi
  800878:	75 05                	jne    80087f <vprintfmt+0x1a6>
				p = "(null)";
  80087a:	be 11 21 80 00       	mov    $0x802111,%esi
			if (width > 0 && padc != '-')
  80087f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800883:	7e 6d                	jle    8008f2 <vprintfmt+0x219>
  800885:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800889:	74 67                	je     8008f2 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  80088b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80088e:	83 ec 08             	sub    $0x8,%esp
  800891:	50                   	push   %eax
  800892:	56                   	push   %esi
  800893:	e8 0c 03 00 00       	call   800ba4 <strnlen>
  800898:	83 c4 10             	add    $0x10,%esp
  80089b:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  80089e:	eb 16                	jmp    8008b6 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8008a0:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8008a4:	83 ec 08             	sub    $0x8,%esp
  8008a7:	ff 75 0c             	pushl  0xc(%ebp)
  8008aa:	50                   	push   %eax
  8008ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ae:	ff d0                	call   *%eax
  8008b0:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8008b3:	ff 4d e4             	decl   -0x1c(%ebp)
  8008b6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008ba:	7f e4                	jg     8008a0 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008bc:	eb 34                	jmp    8008f2 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8008be:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8008c2:	74 1c                	je     8008e0 <vprintfmt+0x207>
  8008c4:	83 fb 1f             	cmp    $0x1f,%ebx
  8008c7:	7e 05                	jle    8008ce <vprintfmt+0x1f5>
  8008c9:	83 fb 7e             	cmp    $0x7e,%ebx
  8008cc:	7e 12                	jle    8008e0 <vprintfmt+0x207>
					putch('?', putdat);
  8008ce:	83 ec 08             	sub    $0x8,%esp
  8008d1:	ff 75 0c             	pushl  0xc(%ebp)
  8008d4:	6a 3f                	push   $0x3f
  8008d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d9:	ff d0                	call   *%eax
  8008db:	83 c4 10             	add    $0x10,%esp
  8008de:	eb 0f                	jmp    8008ef <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8008e0:	83 ec 08             	sub    $0x8,%esp
  8008e3:	ff 75 0c             	pushl  0xc(%ebp)
  8008e6:	53                   	push   %ebx
  8008e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ea:	ff d0                	call   *%eax
  8008ec:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8008ef:	ff 4d e4             	decl   -0x1c(%ebp)
  8008f2:	89 f0                	mov    %esi,%eax
  8008f4:	8d 70 01             	lea    0x1(%eax),%esi
  8008f7:	8a 00                	mov    (%eax),%al
  8008f9:	0f be d8             	movsbl %al,%ebx
  8008fc:	85 db                	test   %ebx,%ebx
  8008fe:	74 24                	je     800924 <vprintfmt+0x24b>
  800900:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800904:	78 b8                	js     8008be <vprintfmt+0x1e5>
  800906:	ff 4d e0             	decl   -0x20(%ebp)
  800909:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80090d:	79 af                	jns    8008be <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80090f:	eb 13                	jmp    800924 <vprintfmt+0x24b>
				putch(' ', putdat);
  800911:	83 ec 08             	sub    $0x8,%esp
  800914:	ff 75 0c             	pushl  0xc(%ebp)
  800917:	6a 20                	push   $0x20
  800919:	8b 45 08             	mov    0x8(%ebp),%eax
  80091c:	ff d0                	call   *%eax
  80091e:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800921:	ff 4d e4             	decl   -0x1c(%ebp)
  800924:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800928:	7f e7                	jg     800911 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  80092a:	e9 66 01 00 00       	jmp    800a95 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80092f:	83 ec 08             	sub    $0x8,%esp
  800932:	ff 75 e8             	pushl  -0x18(%ebp)
  800935:	8d 45 14             	lea    0x14(%ebp),%eax
  800938:	50                   	push   %eax
  800939:	e8 3c fd ff ff       	call   80067a <getint>
  80093e:	83 c4 10             	add    $0x10,%esp
  800941:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800944:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800947:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80094a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80094d:	85 d2                	test   %edx,%edx
  80094f:	79 23                	jns    800974 <vprintfmt+0x29b>
				putch('-', putdat);
  800951:	83 ec 08             	sub    $0x8,%esp
  800954:	ff 75 0c             	pushl  0xc(%ebp)
  800957:	6a 2d                	push   $0x2d
  800959:	8b 45 08             	mov    0x8(%ebp),%eax
  80095c:	ff d0                	call   *%eax
  80095e:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800961:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800964:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800967:	f7 d8                	neg    %eax
  800969:	83 d2 00             	adc    $0x0,%edx
  80096c:	f7 da                	neg    %edx
  80096e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800971:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800974:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80097b:	e9 bc 00 00 00       	jmp    800a3c <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800980:	83 ec 08             	sub    $0x8,%esp
  800983:	ff 75 e8             	pushl  -0x18(%ebp)
  800986:	8d 45 14             	lea    0x14(%ebp),%eax
  800989:	50                   	push   %eax
  80098a:	e8 84 fc ff ff       	call   800613 <getuint>
  80098f:	83 c4 10             	add    $0x10,%esp
  800992:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800995:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800998:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  80099f:	e9 98 00 00 00       	jmp    800a3c <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8009a4:	83 ec 08             	sub    $0x8,%esp
  8009a7:	ff 75 0c             	pushl  0xc(%ebp)
  8009aa:	6a 58                	push   $0x58
  8009ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8009af:	ff d0                	call   *%eax
  8009b1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009b4:	83 ec 08             	sub    $0x8,%esp
  8009b7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ba:	6a 58                	push   $0x58
  8009bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009bf:	ff d0                	call   *%eax
  8009c1:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8009c4:	83 ec 08             	sub    $0x8,%esp
  8009c7:	ff 75 0c             	pushl  0xc(%ebp)
  8009ca:	6a 58                	push   $0x58
  8009cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8009cf:	ff d0                	call   *%eax
  8009d1:	83 c4 10             	add    $0x10,%esp
			break;
  8009d4:	e9 bc 00 00 00       	jmp    800a95 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8009d9:	83 ec 08             	sub    $0x8,%esp
  8009dc:	ff 75 0c             	pushl  0xc(%ebp)
  8009df:	6a 30                	push   $0x30
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	ff d0                	call   *%eax
  8009e6:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8009e9:	83 ec 08             	sub    $0x8,%esp
  8009ec:	ff 75 0c             	pushl  0xc(%ebp)
  8009ef:	6a 78                	push   $0x78
  8009f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f4:	ff d0                	call   *%eax
  8009f6:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8009f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8009fc:	83 c0 04             	add    $0x4,%eax
  8009ff:	89 45 14             	mov    %eax,0x14(%ebp)
  800a02:	8b 45 14             	mov    0x14(%ebp),%eax
  800a05:	83 e8 04             	sub    $0x4,%eax
  800a08:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800a0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800a14:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800a1b:	eb 1f                	jmp    800a3c <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800a1d:	83 ec 08             	sub    $0x8,%esp
  800a20:	ff 75 e8             	pushl  -0x18(%ebp)
  800a23:	8d 45 14             	lea    0x14(%ebp),%eax
  800a26:	50                   	push   %eax
  800a27:	e8 e7 fb ff ff       	call   800613 <getuint>
  800a2c:	83 c4 10             	add    $0x10,%esp
  800a2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a32:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800a35:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800a3c:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800a40:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800a43:	83 ec 04             	sub    $0x4,%esp
  800a46:	52                   	push   %edx
  800a47:	ff 75 e4             	pushl  -0x1c(%ebp)
  800a4a:	50                   	push   %eax
  800a4b:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4e:	ff 75 f0             	pushl  -0x10(%ebp)
  800a51:	ff 75 0c             	pushl  0xc(%ebp)
  800a54:	ff 75 08             	pushl  0x8(%ebp)
  800a57:	e8 00 fb ff ff       	call   80055c <printnum>
  800a5c:	83 c4 20             	add    $0x20,%esp
			break;
  800a5f:	eb 34                	jmp    800a95 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800a61:	83 ec 08             	sub    $0x8,%esp
  800a64:	ff 75 0c             	pushl  0xc(%ebp)
  800a67:	53                   	push   %ebx
  800a68:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6b:	ff d0                	call   *%eax
  800a6d:	83 c4 10             	add    $0x10,%esp
			break;
  800a70:	eb 23                	jmp    800a95 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800a72:	83 ec 08             	sub    $0x8,%esp
  800a75:	ff 75 0c             	pushl  0xc(%ebp)
  800a78:	6a 25                	push   $0x25
  800a7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7d:	ff d0                	call   *%eax
  800a7f:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800a82:	ff 4d 10             	decl   0x10(%ebp)
  800a85:	eb 03                	jmp    800a8a <vprintfmt+0x3b1>
  800a87:	ff 4d 10             	decl   0x10(%ebp)
  800a8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8d:	48                   	dec    %eax
  800a8e:	8a 00                	mov    (%eax),%al
  800a90:	3c 25                	cmp    $0x25,%al
  800a92:	75 f3                	jne    800a87 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800a94:	90                   	nop
		}
	}
  800a95:	e9 47 fc ff ff       	jmp    8006e1 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800a9a:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800a9b:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800a9e:	5b                   	pop    %ebx
  800a9f:	5e                   	pop    %esi
  800aa0:	5d                   	pop    %ebp
  800aa1:	c3                   	ret    

00800aa2 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800aa2:	55                   	push   %ebp
  800aa3:	89 e5                	mov    %esp,%ebp
  800aa5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800aa8:	8d 45 10             	lea    0x10(%ebp),%eax
  800aab:	83 c0 04             	add    $0x4,%eax
  800aae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ab1:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab4:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab7:	50                   	push   %eax
  800ab8:	ff 75 0c             	pushl  0xc(%ebp)
  800abb:	ff 75 08             	pushl  0x8(%ebp)
  800abe:	e8 16 fc ff ff       	call   8006d9 <vprintfmt>
  800ac3:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800ac6:	90                   	nop
  800ac7:	c9                   	leave  
  800ac8:	c3                   	ret    

00800ac9 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ac9:	55                   	push   %ebp
  800aca:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800acc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800acf:	8b 40 08             	mov    0x8(%eax),%eax
  800ad2:	8d 50 01             	lea    0x1(%eax),%edx
  800ad5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad8:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800adb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ade:	8b 10                	mov    (%eax),%edx
  800ae0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae3:	8b 40 04             	mov    0x4(%eax),%eax
  800ae6:	39 c2                	cmp    %eax,%edx
  800ae8:	73 12                	jae    800afc <sprintputch+0x33>
		*b->buf++ = ch;
  800aea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aed:	8b 00                	mov    (%eax),%eax
  800aef:	8d 48 01             	lea    0x1(%eax),%ecx
  800af2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af5:	89 0a                	mov    %ecx,(%edx)
  800af7:	8b 55 08             	mov    0x8(%ebp),%edx
  800afa:	88 10                	mov    %dl,(%eax)
}
  800afc:	90                   	nop
  800afd:	5d                   	pop    %ebp
  800afe:	c3                   	ret    

00800aff <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800aff:	55                   	push   %ebp
  800b00:	89 e5                	mov    %esp,%ebp
  800b02:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800b05:	8b 45 08             	mov    0x8(%ebp),%eax
  800b08:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800b0b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b0e:	8d 50 ff             	lea    -0x1(%eax),%edx
  800b11:	8b 45 08             	mov    0x8(%ebp),%eax
  800b14:	01 d0                	add    %edx,%eax
  800b16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b19:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800b20:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800b24:	74 06                	je     800b2c <vsnprintf+0x2d>
  800b26:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b2a:	7f 07                	jg     800b33 <vsnprintf+0x34>
		return -E_INVAL;
  800b2c:	b8 03 00 00 00       	mov    $0x3,%eax
  800b31:	eb 20                	jmp    800b53 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800b33:	ff 75 14             	pushl  0x14(%ebp)
  800b36:	ff 75 10             	pushl  0x10(%ebp)
  800b39:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800b3c:	50                   	push   %eax
  800b3d:	68 c9 0a 80 00       	push   $0x800ac9
  800b42:	e8 92 fb ff ff       	call   8006d9 <vprintfmt>
  800b47:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800b4a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b4d:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800b50:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800b53:	c9                   	leave  
  800b54:	c3                   	ret    

00800b55 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800b55:	55                   	push   %ebp
  800b56:	89 e5                	mov    %esp,%ebp
  800b58:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800b5b:	8d 45 10             	lea    0x10(%ebp),%eax
  800b5e:	83 c0 04             	add    $0x4,%eax
  800b61:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800b64:	8b 45 10             	mov    0x10(%ebp),%eax
  800b67:	ff 75 f4             	pushl  -0xc(%ebp)
  800b6a:	50                   	push   %eax
  800b6b:	ff 75 0c             	pushl  0xc(%ebp)
  800b6e:	ff 75 08             	pushl  0x8(%ebp)
  800b71:	e8 89 ff ff ff       	call   800aff <vsnprintf>
  800b76:	83 c4 10             	add    $0x10,%esp
  800b79:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800b7c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800b7f:	c9                   	leave  
  800b80:	c3                   	ret    

00800b81 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800b81:	55                   	push   %ebp
  800b82:	89 e5                	mov    %esp,%ebp
  800b84:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800b87:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b8e:	eb 06                	jmp    800b96 <strlen+0x15>
		n++;
  800b90:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800b93:	ff 45 08             	incl   0x8(%ebp)
  800b96:	8b 45 08             	mov    0x8(%ebp),%eax
  800b99:	8a 00                	mov    (%eax),%al
  800b9b:	84 c0                	test   %al,%al
  800b9d:	75 f1                	jne    800b90 <strlen+0xf>
		n++;
	return n;
  800b9f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800ba2:	c9                   	leave  
  800ba3:	c3                   	ret    

00800ba4 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800ba4:	55                   	push   %ebp
  800ba5:	89 e5                	mov    %esp,%ebp
  800ba7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800baa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800bb1:	eb 09                	jmp    800bbc <strnlen+0x18>
		n++;
  800bb3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800bb6:	ff 45 08             	incl   0x8(%ebp)
  800bb9:	ff 4d 0c             	decl   0xc(%ebp)
  800bbc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc0:	74 09                	je     800bcb <strnlen+0x27>
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	8a 00                	mov    (%eax),%al
  800bc7:	84 c0                	test   %al,%al
  800bc9:	75 e8                	jne    800bb3 <strnlen+0xf>
		n++;
	return n;
  800bcb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bce:	c9                   	leave  
  800bcf:	c3                   	ret    

00800bd0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800bd0:	55                   	push   %ebp
  800bd1:	89 e5                	mov    %esp,%ebp
  800bd3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800bdc:	90                   	nop
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	8d 50 01             	lea    0x1(%eax),%edx
  800be3:	89 55 08             	mov    %edx,0x8(%ebp)
  800be6:	8b 55 0c             	mov    0xc(%ebp),%edx
  800be9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bec:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bef:	8a 12                	mov    (%edx),%dl
  800bf1:	88 10                	mov    %dl,(%eax)
  800bf3:	8a 00                	mov    (%eax),%al
  800bf5:	84 c0                	test   %al,%al
  800bf7:	75 e4                	jne    800bdd <strcpy+0xd>
		/* do nothing */;
	return ret;
  800bf9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800bfc:	c9                   	leave  
  800bfd:	c3                   	ret    

00800bfe <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800bfe:	55                   	push   %ebp
  800bff:	89 e5                	mov    %esp,%ebp
  800c01:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800c04:	8b 45 08             	mov    0x8(%ebp),%eax
  800c07:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800c0a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c11:	eb 1f                	jmp    800c32 <strncpy+0x34>
		*dst++ = *src;
  800c13:	8b 45 08             	mov    0x8(%ebp),%eax
  800c16:	8d 50 01             	lea    0x1(%eax),%edx
  800c19:	89 55 08             	mov    %edx,0x8(%ebp)
  800c1c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c1f:	8a 12                	mov    (%edx),%dl
  800c21:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800c23:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c26:	8a 00                	mov    (%eax),%al
  800c28:	84 c0                	test   %al,%al
  800c2a:	74 03                	je     800c2f <strncpy+0x31>
			src++;
  800c2c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800c2f:	ff 45 fc             	incl   -0x4(%ebp)
  800c32:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c35:	3b 45 10             	cmp    0x10(%ebp),%eax
  800c38:	72 d9                	jb     800c13 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800c3a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800c3d:	c9                   	leave  
  800c3e:	c3                   	ret    

00800c3f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800c3f:	55                   	push   %ebp
  800c40:	89 e5                	mov    %esp,%ebp
  800c42:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800c45:	8b 45 08             	mov    0x8(%ebp),%eax
  800c48:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800c4b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c4f:	74 30                	je     800c81 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800c51:	eb 16                	jmp    800c69 <strlcpy+0x2a>
			*dst++ = *src++;
  800c53:	8b 45 08             	mov    0x8(%ebp),%eax
  800c56:	8d 50 01             	lea    0x1(%eax),%edx
  800c59:	89 55 08             	mov    %edx,0x8(%ebp)
  800c5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800c5f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c62:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800c65:	8a 12                	mov    (%edx),%dl
  800c67:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800c69:	ff 4d 10             	decl   0x10(%ebp)
  800c6c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c70:	74 09                	je     800c7b <strlcpy+0x3c>
  800c72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c75:	8a 00                	mov    (%eax),%al
  800c77:	84 c0                	test   %al,%al
  800c79:	75 d8                	jne    800c53 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c7e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800c81:	8b 55 08             	mov    0x8(%ebp),%edx
  800c84:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c87:	29 c2                	sub    %eax,%edx
  800c89:	89 d0                	mov    %edx,%eax
}
  800c8b:	c9                   	leave  
  800c8c:	c3                   	ret    

00800c8d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800c8d:	55                   	push   %ebp
  800c8e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800c90:	eb 06                	jmp    800c98 <strcmp+0xb>
		p++, q++;
  800c92:	ff 45 08             	incl   0x8(%ebp)
  800c95:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800c98:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9b:	8a 00                	mov    (%eax),%al
  800c9d:	84 c0                	test   %al,%al
  800c9f:	74 0e                	je     800caf <strcmp+0x22>
  800ca1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca4:	8a 10                	mov    (%eax),%dl
  800ca6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ca9:	8a 00                	mov    (%eax),%al
  800cab:	38 c2                	cmp    %al,%dl
  800cad:	74 e3                	je     800c92 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	0f b6 d0             	movzbl %al,%edx
  800cb7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cba:	8a 00                	mov    (%eax),%al
  800cbc:	0f b6 c0             	movzbl %al,%eax
  800cbf:	29 c2                	sub    %eax,%edx
  800cc1:	89 d0                	mov    %edx,%eax
}
  800cc3:	5d                   	pop    %ebp
  800cc4:	c3                   	ret    

00800cc5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800cc5:	55                   	push   %ebp
  800cc6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800cc8:	eb 09                	jmp    800cd3 <strncmp+0xe>
		n--, p++, q++;
  800cca:	ff 4d 10             	decl   0x10(%ebp)
  800ccd:	ff 45 08             	incl   0x8(%ebp)
  800cd0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800cd3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cd7:	74 17                	je     800cf0 <strncmp+0x2b>
  800cd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdc:	8a 00                	mov    (%eax),%al
  800cde:	84 c0                	test   %al,%al
  800ce0:	74 0e                	je     800cf0 <strncmp+0x2b>
  800ce2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce5:	8a 10                	mov    (%eax),%dl
  800ce7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cea:	8a 00                	mov    (%eax),%al
  800cec:	38 c2                	cmp    %al,%dl
  800cee:	74 da                	je     800cca <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800cf0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800cf4:	75 07                	jne    800cfd <strncmp+0x38>
		return 0;
  800cf6:	b8 00 00 00 00       	mov    $0x0,%eax
  800cfb:	eb 14                	jmp    800d11 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	8a 00                	mov    (%eax),%al
  800d02:	0f b6 d0             	movzbl %al,%edx
  800d05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d08:	8a 00                	mov    (%eax),%al
  800d0a:	0f b6 c0             	movzbl %al,%eax
  800d0d:	29 c2                	sub    %eax,%edx
  800d0f:	89 d0                	mov    %edx,%eax
}
  800d11:	5d                   	pop    %ebp
  800d12:	c3                   	ret    

00800d13 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800d13:	55                   	push   %ebp
  800d14:	89 e5                	mov    %esp,%ebp
  800d16:	83 ec 04             	sub    $0x4,%esp
  800d19:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d1c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d1f:	eb 12                	jmp    800d33 <strchr+0x20>
		if (*s == c)
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	8a 00                	mov    (%eax),%al
  800d26:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d29:	75 05                	jne    800d30 <strchr+0x1d>
			return (char *) s;
  800d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2e:	eb 11                	jmp    800d41 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800d30:	ff 45 08             	incl   0x8(%ebp)
  800d33:	8b 45 08             	mov    0x8(%ebp),%eax
  800d36:	8a 00                	mov    (%eax),%al
  800d38:	84 c0                	test   %al,%al
  800d3a:	75 e5                	jne    800d21 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800d3c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800d41:	c9                   	leave  
  800d42:	c3                   	ret    

00800d43 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800d43:	55                   	push   %ebp
  800d44:	89 e5                	mov    %esp,%ebp
  800d46:	83 ec 04             	sub    $0x4,%esp
  800d49:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d4c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800d4f:	eb 0d                	jmp    800d5e <strfind+0x1b>
		if (*s == c)
  800d51:	8b 45 08             	mov    0x8(%ebp),%eax
  800d54:	8a 00                	mov    (%eax),%al
  800d56:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800d59:	74 0e                	je     800d69 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800d5b:	ff 45 08             	incl   0x8(%ebp)
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	8a 00                	mov    (%eax),%al
  800d63:	84 c0                	test   %al,%al
  800d65:	75 ea                	jne    800d51 <strfind+0xe>
  800d67:	eb 01                	jmp    800d6a <strfind+0x27>
		if (*s == c)
			break;
  800d69:	90                   	nop
	return (char *) s;
  800d6a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d6d:	c9                   	leave  
  800d6e:	c3                   	ret    

00800d6f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800d6f:	55                   	push   %ebp
  800d70:	89 e5                	mov    %esp,%ebp
  800d72:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800d7b:	8b 45 10             	mov    0x10(%ebp),%eax
  800d7e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800d81:	eb 0e                	jmp    800d91 <memset+0x22>
		*p++ = c;
  800d83:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d86:	8d 50 01             	lea    0x1(%eax),%edx
  800d89:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800d8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d8f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800d91:	ff 4d f8             	decl   -0x8(%ebp)
  800d94:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800d98:	79 e9                	jns    800d83 <memset+0x14>
		*p++ = c;

	return v;
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d9d:	c9                   	leave  
  800d9e:	c3                   	ret    

00800d9f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800d9f:	55                   	push   %ebp
  800da0:	89 e5                	mov    %esp,%ebp
  800da2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800da5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800dab:	8b 45 08             	mov    0x8(%ebp),%eax
  800dae:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800db1:	eb 16                	jmp    800dc9 <memcpy+0x2a>
		*d++ = *s++;
  800db3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800db6:	8d 50 01             	lea    0x1(%eax),%edx
  800db9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800dbc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800dbf:	8d 4a 01             	lea    0x1(%edx),%ecx
  800dc2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800dc5:	8a 12                	mov    (%edx),%dl
  800dc7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800dc9:	8b 45 10             	mov    0x10(%ebp),%eax
  800dcc:	8d 50 ff             	lea    -0x1(%eax),%edx
  800dcf:	89 55 10             	mov    %edx,0x10(%ebp)
  800dd2:	85 c0                	test   %eax,%eax
  800dd4:	75 dd                	jne    800db3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800dd6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800dd9:	c9                   	leave  
  800dda:	c3                   	ret    

00800ddb <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ddb:	55                   	push   %ebp
  800ddc:	89 e5                	mov    %esp,%ebp
  800dde:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800de1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800de7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dea:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ded:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800df0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800df3:	73 50                	jae    800e45 <memmove+0x6a>
  800df5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800df8:	8b 45 10             	mov    0x10(%ebp),%eax
  800dfb:	01 d0                	add    %edx,%eax
  800dfd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800e00:	76 43                	jbe    800e45 <memmove+0x6a>
		s += n;
  800e02:	8b 45 10             	mov    0x10(%ebp),%eax
  800e05:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800e08:	8b 45 10             	mov    0x10(%ebp),%eax
  800e0b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800e0e:	eb 10                	jmp    800e20 <memmove+0x45>
			*--d = *--s;
  800e10:	ff 4d f8             	decl   -0x8(%ebp)
  800e13:	ff 4d fc             	decl   -0x4(%ebp)
  800e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e19:	8a 10                	mov    (%eax),%dl
  800e1b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800e20:	8b 45 10             	mov    0x10(%ebp),%eax
  800e23:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e26:	89 55 10             	mov    %edx,0x10(%ebp)
  800e29:	85 c0                	test   %eax,%eax
  800e2b:	75 e3                	jne    800e10 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800e2d:	eb 23                	jmp    800e52 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800e2f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e32:	8d 50 01             	lea    0x1(%eax),%edx
  800e35:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e38:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800e3b:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e3e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800e41:	8a 12                	mov    (%edx),%dl
  800e43:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800e45:	8b 45 10             	mov    0x10(%ebp),%eax
  800e48:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e4b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e4e:	85 c0                	test   %eax,%eax
  800e50:	75 dd                	jne    800e2f <memmove+0x54>
			*d++ = *s++;

	return dst;
  800e52:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e55:	c9                   	leave  
  800e56:	c3                   	ret    

00800e57 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800e57:	55                   	push   %ebp
  800e58:	89 e5                	mov    %esp,%ebp
  800e5a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800e5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e60:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800e63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e66:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800e69:	eb 2a                	jmp    800e95 <memcmp+0x3e>
		if (*s1 != *s2)
  800e6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e6e:	8a 10                	mov    (%eax),%dl
  800e70:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e73:	8a 00                	mov    (%eax),%al
  800e75:	38 c2                	cmp    %al,%dl
  800e77:	74 16                	je     800e8f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800e79:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e7c:	8a 00                	mov    (%eax),%al
  800e7e:	0f b6 d0             	movzbl %al,%edx
  800e81:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e84:	8a 00                	mov    (%eax),%al
  800e86:	0f b6 c0             	movzbl %al,%eax
  800e89:	29 c2                	sub    %eax,%edx
  800e8b:	89 d0                	mov    %edx,%eax
  800e8d:	eb 18                	jmp    800ea7 <memcmp+0x50>
		s1++, s2++;
  800e8f:	ff 45 fc             	incl   -0x4(%ebp)
  800e92:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800e95:	8b 45 10             	mov    0x10(%ebp),%eax
  800e98:	8d 50 ff             	lea    -0x1(%eax),%edx
  800e9b:	89 55 10             	mov    %edx,0x10(%ebp)
  800e9e:	85 c0                	test   %eax,%eax
  800ea0:	75 c9                	jne    800e6b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ea2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800ea7:	c9                   	leave  
  800ea8:	c3                   	ret    

00800ea9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800ea9:	55                   	push   %ebp
  800eaa:	89 e5                	mov    %esp,%ebp
  800eac:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800eaf:	8b 55 08             	mov    0x8(%ebp),%edx
  800eb2:	8b 45 10             	mov    0x10(%ebp),%eax
  800eb5:	01 d0                	add    %edx,%eax
  800eb7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800eba:	eb 15                	jmp    800ed1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ebc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebf:	8a 00                	mov    (%eax),%al
  800ec1:	0f b6 d0             	movzbl %al,%edx
  800ec4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ec7:	0f b6 c0             	movzbl %al,%eax
  800eca:	39 c2                	cmp    %eax,%edx
  800ecc:	74 0d                	je     800edb <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800ece:	ff 45 08             	incl   0x8(%ebp)
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800ed7:	72 e3                	jb     800ebc <memfind+0x13>
  800ed9:	eb 01                	jmp    800edc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800edb:	90                   	nop
	return (void *) s;
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800edf:	c9                   	leave  
  800ee0:	c3                   	ret    

00800ee1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800ee1:	55                   	push   %ebp
  800ee2:	89 e5                	mov    %esp,%ebp
  800ee4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800ee7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800eee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ef5:	eb 03                	jmp    800efa <strtol+0x19>
		s++;
  800ef7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800efa:	8b 45 08             	mov    0x8(%ebp),%eax
  800efd:	8a 00                	mov    (%eax),%al
  800eff:	3c 20                	cmp    $0x20,%al
  800f01:	74 f4                	je     800ef7 <strtol+0x16>
  800f03:	8b 45 08             	mov    0x8(%ebp),%eax
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	3c 09                	cmp    $0x9,%al
  800f0a:	74 eb                	je     800ef7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800f0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0f:	8a 00                	mov    (%eax),%al
  800f11:	3c 2b                	cmp    $0x2b,%al
  800f13:	75 05                	jne    800f1a <strtol+0x39>
		s++;
  800f15:	ff 45 08             	incl   0x8(%ebp)
  800f18:	eb 13                	jmp    800f2d <strtol+0x4c>
	else if (*s == '-')
  800f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1d:	8a 00                	mov    (%eax),%al
  800f1f:	3c 2d                	cmp    $0x2d,%al
  800f21:	75 0a                	jne    800f2d <strtol+0x4c>
		s++, neg = 1;
  800f23:	ff 45 08             	incl   0x8(%ebp)
  800f26:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800f2d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f31:	74 06                	je     800f39 <strtol+0x58>
  800f33:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800f37:	75 20                	jne    800f59 <strtol+0x78>
  800f39:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3c:	8a 00                	mov    (%eax),%al
  800f3e:	3c 30                	cmp    $0x30,%al
  800f40:	75 17                	jne    800f59 <strtol+0x78>
  800f42:	8b 45 08             	mov    0x8(%ebp),%eax
  800f45:	40                   	inc    %eax
  800f46:	8a 00                	mov    (%eax),%al
  800f48:	3c 78                	cmp    $0x78,%al
  800f4a:	75 0d                	jne    800f59 <strtol+0x78>
		s += 2, base = 16;
  800f4c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800f50:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800f57:	eb 28                	jmp    800f81 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800f59:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f5d:	75 15                	jne    800f74 <strtol+0x93>
  800f5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f62:	8a 00                	mov    (%eax),%al
  800f64:	3c 30                	cmp    $0x30,%al
  800f66:	75 0c                	jne    800f74 <strtol+0x93>
		s++, base = 8;
  800f68:	ff 45 08             	incl   0x8(%ebp)
  800f6b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800f72:	eb 0d                	jmp    800f81 <strtol+0xa0>
	else if (base == 0)
  800f74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f78:	75 07                	jne    800f81 <strtol+0xa0>
		base = 10;
  800f7a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	8a 00                	mov    (%eax),%al
  800f86:	3c 2f                	cmp    $0x2f,%al
  800f88:	7e 19                	jle    800fa3 <strtol+0xc2>
  800f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	3c 39                	cmp    $0x39,%al
  800f91:	7f 10                	jg     800fa3 <strtol+0xc2>
			dig = *s - '0';
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	8a 00                	mov    (%eax),%al
  800f98:	0f be c0             	movsbl %al,%eax
  800f9b:	83 e8 30             	sub    $0x30,%eax
  800f9e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fa1:	eb 42                	jmp    800fe5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800fa3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa6:	8a 00                	mov    (%eax),%al
  800fa8:	3c 60                	cmp    $0x60,%al
  800faa:	7e 19                	jle    800fc5 <strtol+0xe4>
  800fac:	8b 45 08             	mov    0x8(%ebp),%eax
  800faf:	8a 00                	mov    (%eax),%al
  800fb1:	3c 7a                	cmp    $0x7a,%al
  800fb3:	7f 10                	jg     800fc5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	8a 00                	mov    (%eax),%al
  800fba:	0f be c0             	movsbl %al,%eax
  800fbd:	83 e8 57             	sub    $0x57,%eax
  800fc0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800fc3:	eb 20                	jmp    800fe5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800fc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc8:	8a 00                	mov    (%eax),%al
  800fca:	3c 40                	cmp    $0x40,%al
  800fcc:	7e 39                	jle    801007 <strtol+0x126>
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	8a 00                	mov    (%eax),%al
  800fd3:	3c 5a                	cmp    $0x5a,%al
  800fd5:	7f 30                	jg     801007 <strtol+0x126>
			dig = *s - 'A' + 10;
  800fd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fda:	8a 00                	mov    (%eax),%al
  800fdc:	0f be c0             	movsbl %al,%eax
  800fdf:	83 e8 37             	sub    $0x37,%eax
  800fe2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800fe5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800fe8:	3b 45 10             	cmp    0x10(%ebp),%eax
  800feb:	7d 19                	jge    801006 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800fed:	ff 45 08             	incl   0x8(%ebp)
  800ff0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800ff3:	0f af 45 10          	imul   0x10(%ebp),%eax
  800ff7:	89 c2                	mov    %eax,%edx
  800ff9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800ffc:	01 d0                	add    %edx,%eax
  800ffe:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801001:	e9 7b ff ff ff       	jmp    800f81 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801006:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801007:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80100b:	74 08                	je     801015 <strtol+0x134>
		*endptr = (char *) s;
  80100d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801010:	8b 55 08             	mov    0x8(%ebp),%edx
  801013:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801015:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801019:	74 07                	je     801022 <strtol+0x141>
  80101b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80101e:	f7 d8                	neg    %eax
  801020:	eb 03                	jmp    801025 <strtol+0x144>
  801022:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801025:	c9                   	leave  
  801026:	c3                   	ret    

00801027 <ltostr>:

void
ltostr(long value, char *str)
{
  801027:	55                   	push   %ebp
  801028:	89 e5                	mov    %esp,%ebp
  80102a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80102d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801034:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80103b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80103f:	79 13                	jns    801054 <ltostr+0x2d>
	{
		neg = 1;
  801041:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801048:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80104e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801051:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801054:	8b 45 08             	mov    0x8(%ebp),%eax
  801057:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80105c:	99                   	cltd   
  80105d:	f7 f9                	idiv   %ecx
  80105f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801062:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801065:	8d 50 01             	lea    0x1(%eax),%edx
  801068:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80106b:	89 c2                	mov    %eax,%edx
  80106d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801070:	01 d0                	add    %edx,%eax
  801072:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801075:	83 c2 30             	add    $0x30,%edx
  801078:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80107a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80107d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801082:	f7 e9                	imul   %ecx
  801084:	c1 fa 02             	sar    $0x2,%edx
  801087:	89 c8                	mov    %ecx,%eax
  801089:	c1 f8 1f             	sar    $0x1f,%eax
  80108c:	29 c2                	sub    %eax,%edx
  80108e:	89 d0                	mov    %edx,%eax
  801090:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801093:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801096:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80109b:	f7 e9                	imul   %ecx
  80109d:	c1 fa 02             	sar    $0x2,%edx
  8010a0:	89 c8                	mov    %ecx,%eax
  8010a2:	c1 f8 1f             	sar    $0x1f,%eax
  8010a5:	29 c2                	sub    %eax,%edx
  8010a7:	89 d0                	mov    %edx,%eax
  8010a9:	c1 e0 02             	shl    $0x2,%eax
  8010ac:	01 d0                	add    %edx,%eax
  8010ae:	01 c0                	add    %eax,%eax
  8010b0:	29 c1                	sub    %eax,%ecx
  8010b2:	89 ca                	mov    %ecx,%edx
  8010b4:	85 d2                	test   %edx,%edx
  8010b6:	75 9c                	jne    801054 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8010b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8010bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c2:	48                   	dec    %eax
  8010c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8010c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8010ca:	74 3d                	je     801109 <ltostr+0xe2>
		start = 1 ;
  8010cc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8010d3:	eb 34                	jmp    801109 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8010d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010db:	01 d0                	add    %edx,%eax
  8010dd:	8a 00                	mov    (%eax),%al
  8010df:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8010e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8010e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e8:	01 c2                	add    %eax,%edx
  8010ea:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8010ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f0:	01 c8                	add    %ecx,%eax
  8010f2:	8a 00                	mov    (%eax),%al
  8010f4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8010f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8010f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010fc:	01 c2                	add    %eax,%edx
  8010fe:	8a 45 eb             	mov    -0x15(%ebp),%al
  801101:	88 02                	mov    %al,(%edx)
		start++ ;
  801103:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801106:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801109:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80110c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80110f:	7c c4                	jl     8010d5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801111:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801114:	8b 45 0c             	mov    0xc(%ebp),%eax
  801117:	01 d0                	add    %edx,%eax
  801119:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80111c:	90                   	nop
  80111d:	c9                   	leave  
  80111e:	c3                   	ret    

0080111f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80111f:	55                   	push   %ebp
  801120:	89 e5                	mov    %esp,%ebp
  801122:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801125:	ff 75 08             	pushl  0x8(%ebp)
  801128:	e8 54 fa ff ff       	call   800b81 <strlen>
  80112d:	83 c4 04             	add    $0x4,%esp
  801130:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801133:	ff 75 0c             	pushl  0xc(%ebp)
  801136:	e8 46 fa ff ff       	call   800b81 <strlen>
  80113b:	83 c4 04             	add    $0x4,%esp
  80113e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801141:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801148:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80114f:	eb 17                	jmp    801168 <strcconcat+0x49>
		final[s] = str1[s] ;
  801151:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801154:	8b 45 10             	mov    0x10(%ebp),%eax
  801157:	01 c2                	add    %eax,%edx
  801159:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80115c:	8b 45 08             	mov    0x8(%ebp),%eax
  80115f:	01 c8                	add    %ecx,%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801165:	ff 45 fc             	incl   -0x4(%ebp)
  801168:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80116b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80116e:	7c e1                	jl     801151 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801170:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801177:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80117e:	eb 1f                	jmp    80119f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801180:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801183:	8d 50 01             	lea    0x1(%eax),%edx
  801186:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801189:	89 c2                	mov    %eax,%edx
  80118b:	8b 45 10             	mov    0x10(%ebp),%eax
  80118e:	01 c2                	add    %eax,%edx
  801190:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801193:	8b 45 0c             	mov    0xc(%ebp),%eax
  801196:	01 c8                	add    %ecx,%eax
  801198:	8a 00                	mov    (%eax),%al
  80119a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80119c:	ff 45 f8             	incl   -0x8(%ebp)
  80119f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011a2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8011a5:	7c d9                	jl     801180 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8011a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8011aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ad:	01 d0                	add    %edx,%eax
  8011af:	c6 00 00             	movb   $0x0,(%eax)
}
  8011b2:	90                   	nop
  8011b3:	c9                   	leave  
  8011b4:	c3                   	ret    

008011b5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8011b5:	55                   	push   %ebp
  8011b6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8011b8:	8b 45 14             	mov    0x14(%ebp),%eax
  8011bb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8011c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8011c4:	8b 00                	mov    (%eax),%eax
  8011c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d0:	01 d0                	add    %edx,%eax
  8011d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011d8:	eb 0c                	jmp    8011e6 <strsplit+0x31>
			*string++ = 0;
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	8d 50 01             	lea    0x1(%eax),%edx
  8011e0:	89 55 08             	mov    %edx,0x8(%ebp)
  8011e3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	84 c0                	test   %al,%al
  8011ed:	74 18                	je     801207 <strsplit+0x52>
  8011ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f2:	8a 00                	mov    (%eax),%al
  8011f4:	0f be c0             	movsbl %al,%eax
  8011f7:	50                   	push   %eax
  8011f8:	ff 75 0c             	pushl  0xc(%ebp)
  8011fb:	e8 13 fb ff ff       	call   800d13 <strchr>
  801200:	83 c4 08             	add    $0x8,%esp
  801203:	85 c0                	test   %eax,%eax
  801205:	75 d3                	jne    8011da <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801207:	8b 45 08             	mov    0x8(%ebp),%eax
  80120a:	8a 00                	mov    (%eax),%al
  80120c:	84 c0                	test   %al,%al
  80120e:	74 5a                	je     80126a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801210:	8b 45 14             	mov    0x14(%ebp),%eax
  801213:	8b 00                	mov    (%eax),%eax
  801215:	83 f8 0f             	cmp    $0xf,%eax
  801218:	75 07                	jne    801221 <strsplit+0x6c>
		{
			return 0;
  80121a:	b8 00 00 00 00       	mov    $0x0,%eax
  80121f:	eb 66                	jmp    801287 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801221:	8b 45 14             	mov    0x14(%ebp),%eax
  801224:	8b 00                	mov    (%eax),%eax
  801226:	8d 48 01             	lea    0x1(%eax),%ecx
  801229:	8b 55 14             	mov    0x14(%ebp),%edx
  80122c:	89 0a                	mov    %ecx,(%edx)
  80122e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801235:	8b 45 10             	mov    0x10(%ebp),%eax
  801238:	01 c2                	add    %eax,%edx
  80123a:	8b 45 08             	mov    0x8(%ebp),%eax
  80123d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80123f:	eb 03                	jmp    801244 <strsplit+0x8f>
			string++;
  801241:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801244:	8b 45 08             	mov    0x8(%ebp),%eax
  801247:	8a 00                	mov    (%eax),%al
  801249:	84 c0                	test   %al,%al
  80124b:	74 8b                	je     8011d8 <strsplit+0x23>
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
  801250:	8a 00                	mov    (%eax),%al
  801252:	0f be c0             	movsbl %al,%eax
  801255:	50                   	push   %eax
  801256:	ff 75 0c             	pushl  0xc(%ebp)
  801259:	e8 b5 fa ff ff       	call   800d13 <strchr>
  80125e:	83 c4 08             	add    $0x8,%esp
  801261:	85 c0                	test   %eax,%eax
  801263:	74 dc                	je     801241 <strsplit+0x8c>
			string++;
	}
  801265:	e9 6e ff ff ff       	jmp    8011d8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80126a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80126b:	8b 45 14             	mov    0x14(%ebp),%eax
  80126e:	8b 00                	mov    (%eax),%eax
  801270:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801277:	8b 45 10             	mov    0x10(%ebp),%eax
  80127a:	01 d0                	add    %edx,%eax
  80127c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801282:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801287:	c9                   	leave  
  801288:	c3                   	ret    

00801289 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801289:	55                   	push   %ebp
  80128a:	89 e5                	mov    %esp,%ebp
  80128c:	57                   	push   %edi
  80128d:	56                   	push   %esi
  80128e:	53                   	push   %ebx
  80128f:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801292:	8b 45 08             	mov    0x8(%ebp),%eax
  801295:	8b 55 0c             	mov    0xc(%ebp),%edx
  801298:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80129b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80129e:	8b 7d 18             	mov    0x18(%ebp),%edi
  8012a1:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8012a4:	cd 30                	int    $0x30
  8012a6:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8012a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012ac:	83 c4 10             	add    $0x10,%esp
  8012af:	5b                   	pop    %ebx
  8012b0:	5e                   	pop    %esi
  8012b1:	5f                   	pop    %edi
  8012b2:	5d                   	pop    %ebp
  8012b3:	c3                   	ret    

008012b4 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8012b4:	55                   	push   %ebp
  8012b5:	89 e5                	mov    %esp,%ebp
  8012b7:	83 ec 04             	sub    $0x4,%esp
  8012ba:	8b 45 10             	mov    0x10(%ebp),%eax
  8012bd:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8012c0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8012c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c7:	6a 00                	push   $0x0
  8012c9:	6a 00                	push   $0x0
  8012cb:	52                   	push   %edx
  8012cc:	ff 75 0c             	pushl  0xc(%ebp)
  8012cf:	50                   	push   %eax
  8012d0:	6a 00                	push   $0x0
  8012d2:	e8 b2 ff ff ff       	call   801289 <syscall>
  8012d7:	83 c4 18             	add    $0x18,%esp
}
  8012da:	90                   	nop
  8012db:	c9                   	leave  
  8012dc:	c3                   	ret    

008012dd <sys_cgetc>:

int
sys_cgetc(void)
{
  8012dd:	55                   	push   %ebp
  8012de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8012e0:	6a 00                	push   $0x0
  8012e2:	6a 00                	push   $0x0
  8012e4:	6a 00                	push   $0x0
  8012e6:	6a 00                	push   $0x0
  8012e8:	6a 00                	push   $0x0
  8012ea:	6a 01                	push   $0x1
  8012ec:	e8 98 ff ff ff       	call   801289 <syscall>
  8012f1:	83 c4 18             	add    $0x18,%esp
}
  8012f4:	c9                   	leave  
  8012f5:	c3                   	ret    

008012f6 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8012f6:	55                   	push   %ebp
  8012f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8012f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fc:	6a 00                	push   $0x0
  8012fe:	6a 00                	push   $0x0
  801300:	6a 00                	push   $0x0
  801302:	6a 00                	push   $0x0
  801304:	50                   	push   %eax
  801305:	6a 05                	push   $0x5
  801307:	e8 7d ff ff ff       	call   801289 <syscall>
  80130c:	83 c4 18             	add    $0x18,%esp
}
  80130f:	c9                   	leave  
  801310:	c3                   	ret    

00801311 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801311:	55                   	push   %ebp
  801312:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801314:	6a 00                	push   $0x0
  801316:	6a 00                	push   $0x0
  801318:	6a 00                	push   $0x0
  80131a:	6a 00                	push   $0x0
  80131c:	6a 00                	push   $0x0
  80131e:	6a 02                	push   $0x2
  801320:	e8 64 ff ff ff       	call   801289 <syscall>
  801325:	83 c4 18             	add    $0x18,%esp
}
  801328:	c9                   	leave  
  801329:	c3                   	ret    

0080132a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80132a:	55                   	push   %ebp
  80132b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80132d:	6a 00                	push   $0x0
  80132f:	6a 00                	push   $0x0
  801331:	6a 00                	push   $0x0
  801333:	6a 00                	push   $0x0
  801335:	6a 00                	push   $0x0
  801337:	6a 03                	push   $0x3
  801339:	e8 4b ff ff ff       	call   801289 <syscall>
  80133e:	83 c4 18             	add    $0x18,%esp
}
  801341:	c9                   	leave  
  801342:	c3                   	ret    

00801343 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801343:	55                   	push   %ebp
  801344:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801346:	6a 00                	push   $0x0
  801348:	6a 00                	push   $0x0
  80134a:	6a 00                	push   $0x0
  80134c:	6a 00                	push   $0x0
  80134e:	6a 00                	push   $0x0
  801350:	6a 04                	push   $0x4
  801352:	e8 32 ff ff ff       	call   801289 <syscall>
  801357:	83 c4 18             	add    $0x18,%esp
}
  80135a:	c9                   	leave  
  80135b:	c3                   	ret    

0080135c <sys_env_exit>:


void sys_env_exit(void)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80135f:	6a 00                	push   $0x0
  801361:	6a 00                	push   $0x0
  801363:	6a 00                	push   $0x0
  801365:	6a 00                	push   $0x0
  801367:	6a 00                	push   $0x0
  801369:	6a 06                	push   $0x6
  80136b:	e8 19 ff ff ff       	call   801289 <syscall>
  801370:	83 c4 18             	add    $0x18,%esp
}
  801373:	90                   	nop
  801374:	c9                   	leave  
  801375:	c3                   	ret    

00801376 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801376:	55                   	push   %ebp
  801377:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801379:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137c:	8b 45 08             	mov    0x8(%ebp),%eax
  80137f:	6a 00                	push   $0x0
  801381:	6a 00                	push   $0x0
  801383:	6a 00                	push   $0x0
  801385:	52                   	push   %edx
  801386:	50                   	push   %eax
  801387:	6a 07                	push   $0x7
  801389:	e8 fb fe ff ff       	call   801289 <syscall>
  80138e:	83 c4 18             	add    $0x18,%esp
}
  801391:	c9                   	leave  
  801392:	c3                   	ret    

00801393 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801393:	55                   	push   %ebp
  801394:	89 e5                	mov    %esp,%ebp
  801396:	56                   	push   %esi
  801397:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801398:	8b 75 18             	mov    0x18(%ebp),%esi
  80139b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80139e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8013a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	56                   	push   %esi
  8013a8:	53                   	push   %ebx
  8013a9:	51                   	push   %ecx
  8013aa:	52                   	push   %edx
  8013ab:	50                   	push   %eax
  8013ac:	6a 08                	push   $0x8
  8013ae:	e8 d6 fe ff ff       	call   801289 <syscall>
  8013b3:	83 c4 18             	add    $0x18,%esp
}
  8013b6:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8013b9:	5b                   	pop    %ebx
  8013ba:	5e                   	pop    %esi
  8013bb:	5d                   	pop    %ebp
  8013bc:	c3                   	ret    

008013bd <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8013bd:	55                   	push   %ebp
  8013be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8013c0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c6:	6a 00                	push   $0x0
  8013c8:	6a 00                	push   $0x0
  8013ca:	6a 00                	push   $0x0
  8013cc:	52                   	push   %edx
  8013cd:	50                   	push   %eax
  8013ce:	6a 09                	push   $0x9
  8013d0:	e8 b4 fe ff ff       	call   801289 <syscall>
  8013d5:	83 c4 18             	add    $0x18,%esp
}
  8013d8:	c9                   	leave  
  8013d9:	c3                   	ret    

008013da <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8013da:	55                   	push   %ebp
  8013db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	ff 75 0c             	pushl  0xc(%ebp)
  8013e6:	ff 75 08             	pushl  0x8(%ebp)
  8013e9:	6a 0a                	push   $0xa
  8013eb:	e8 99 fe ff ff       	call   801289 <syscall>
  8013f0:	83 c4 18             	add    $0x18,%esp
}
  8013f3:	c9                   	leave  
  8013f4:	c3                   	ret    

008013f5 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8013f5:	55                   	push   %ebp
  8013f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8013f8:	6a 00                	push   $0x0
  8013fa:	6a 00                	push   $0x0
  8013fc:	6a 00                	push   $0x0
  8013fe:	6a 00                	push   $0x0
  801400:	6a 00                	push   $0x0
  801402:	6a 0b                	push   $0xb
  801404:	e8 80 fe ff ff       	call   801289 <syscall>
  801409:	83 c4 18             	add    $0x18,%esp
}
  80140c:	c9                   	leave  
  80140d:	c3                   	ret    

0080140e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80140e:	55                   	push   %ebp
  80140f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801411:	6a 00                	push   $0x0
  801413:	6a 00                	push   $0x0
  801415:	6a 00                	push   $0x0
  801417:	6a 00                	push   $0x0
  801419:	6a 00                	push   $0x0
  80141b:	6a 0c                	push   $0xc
  80141d:	e8 67 fe ff ff       	call   801289 <syscall>
  801422:	83 c4 18             	add    $0x18,%esp
}
  801425:	c9                   	leave  
  801426:	c3                   	ret    

00801427 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801427:	55                   	push   %ebp
  801428:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 00                	push   $0x0
  801432:	6a 00                	push   $0x0
  801434:	6a 0d                	push   $0xd
  801436:	e8 4e fe ff ff       	call   801289 <syscall>
  80143b:	83 c4 18             	add    $0x18,%esp
}
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801443:	6a 00                	push   $0x0
  801445:	6a 00                	push   $0x0
  801447:	6a 00                	push   $0x0
  801449:	ff 75 0c             	pushl  0xc(%ebp)
  80144c:	ff 75 08             	pushl  0x8(%ebp)
  80144f:	6a 11                	push   $0x11
  801451:	e8 33 fe ff ff       	call   801289 <syscall>
  801456:	83 c4 18             	add    $0x18,%esp
	return;
  801459:	90                   	nop
}
  80145a:	c9                   	leave  
  80145b:	c3                   	ret    

0080145c <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80145c:	55                   	push   %ebp
  80145d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80145f:	6a 00                	push   $0x0
  801461:	6a 00                	push   $0x0
  801463:	6a 00                	push   $0x0
  801465:	ff 75 0c             	pushl  0xc(%ebp)
  801468:	ff 75 08             	pushl  0x8(%ebp)
  80146b:	6a 12                	push   $0x12
  80146d:	e8 17 fe ff ff       	call   801289 <syscall>
  801472:	83 c4 18             	add    $0x18,%esp
	return ;
  801475:	90                   	nop
}
  801476:	c9                   	leave  
  801477:	c3                   	ret    

00801478 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801478:	55                   	push   %ebp
  801479:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80147b:	6a 00                	push   $0x0
  80147d:	6a 00                	push   $0x0
  80147f:	6a 00                	push   $0x0
  801481:	6a 00                	push   $0x0
  801483:	6a 00                	push   $0x0
  801485:	6a 0e                	push   $0xe
  801487:	e8 fd fd ff ff       	call   801289 <syscall>
  80148c:	83 c4 18             	add    $0x18,%esp
}
  80148f:	c9                   	leave  
  801490:	c3                   	ret    

00801491 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801491:	55                   	push   %ebp
  801492:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	6a 00                	push   $0x0
  80149c:	ff 75 08             	pushl  0x8(%ebp)
  80149f:	6a 0f                	push   $0xf
  8014a1:	e8 e3 fd ff ff       	call   801289 <syscall>
  8014a6:	83 c4 18             	add    $0x18,%esp
}
  8014a9:	c9                   	leave  
  8014aa:	c3                   	ret    

008014ab <sys_scarce_memory>:

void sys_scarce_memory()
{
  8014ab:	55                   	push   %ebp
  8014ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8014ae:	6a 00                	push   $0x0
  8014b0:	6a 00                	push   $0x0
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	6a 10                	push   $0x10
  8014ba:	e8 ca fd ff ff       	call   801289 <syscall>
  8014bf:	83 c4 18             	add    $0x18,%esp
}
  8014c2:	90                   	nop
  8014c3:	c9                   	leave  
  8014c4:	c3                   	ret    

008014c5 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8014c5:	55                   	push   %ebp
  8014c6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8014c8:	6a 00                	push   $0x0
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 14                	push   $0x14
  8014d4:	e8 b0 fd ff ff       	call   801289 <syscall>
  8014d9:	83 c4 18             	add    $0x18,%esp
}
  8014dc:	90                   	nop
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8014e2:	6a 00                	push   $0x0
  8014e4:	6a 00                	push   $0x0
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 15                	push   $0x15
  8014ee:	e8 96 fd ff ff       	call   801289 <syscall>
  8014f3:	83 c4 18             	add    $0x18,%esp
}
  8014f6:	90                   	nop
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <sys_cputc>:


void
sys_cputc(const char c)
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
  8014fc:	83 ec 04             	sub    $0x4,%esp
  8014ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801502:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801505:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801509:	6a 00                	push   $0x0
  80150b:	6a 00                	push   $0x0
  80150d:	6a 00                	push   $0x0
  80150f:	6a 00                	push   $0x0
  801511:	50                   	push   %eax
  801512:	6a 16                	push   $0x16
  801514:	e8 70 fd ff ff       	call   801289 <syscall>
  801519:	83 c4 18             	add    $0x18,%esp
}
  80151c:	90                   	nop
  80151d:	c9                   	leave  
  80151e:	c3                   	ret    

0080151f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80151f:	55                   	push   %ebp
  801520:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801522:	6a 00                	push   $0x0
  801524:	6a 00                	push   $0x0
  801526:	6a 00                	push   $0x0
  801528:	6a 00                	push   $0x0
  80152a:	6a 00                	push   $0x0
  80152c:	6a 17                	push   $0x17
  80152e:	e8 56 fd ff ff       	call   801289 <syscall>
  801533:	83 c4 18             	add    $0x18,%esp
}
  801536:	90                   	nop
  801537:	c9                   	leave  
  801538:	c3                   	ret    

00801539 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801539:	55                   	push   %ebp
  80153a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	ff 75 0c             	pushl  0xc(%ebp)
  801548:	50                   	push   %eax
  801549:	6a 18                	push   $0x18
  80154b:	e8 39 fd ff ff       	call   801289 <syscall>
  801550:	83 c4 18             	add    $0x18,%esp
}
  801553:	c9                   	leave  
  801554:	c3                   	ret    

00801555 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801555:	55                   	push   %ebp
  801556:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801558:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155b:	8b 45 08             	mov    0x8(%ebp),%eax
  80155e:	6a 00                	push   $0x0
  801560:	6a 00                	push   $0x0
  801562:	6a 00                	push   $0x0
  801564:	52                   	push   %edx
  801565:	50                   	push   %eax
  801566:	6a 1b                	push   $0x1b
  801568:	e8 1c fd ff ff       	call   801289 <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801575:	8b 55 0c             	mov    0xc(%ebp),%edx
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	52                   	push   %edx
  801582:	50                   	push   %eax
  801583:	6a 19                	push   $0x19
  801585:	e8 ff fc ff ff       	call   801289 <syscall>
  80158a:	83 c4 18             	add    $0x18,%esp
}
  80158d:	90                   	nop
  80158e:	c9                   	leave  
  80158f:	c3                   	ret    

00801590 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801590:	55                   	push   %ebp
  801591:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801593:	8b 55 0c             	mov    0xc(%ebp),%edx
  801596:	8b 45 08             	mov    0x8(%ebp),%eax
  801599:	6a 00                	push   $0x0
  80159b:	6a 00                	push   $0x0
  80159d:	6a 00                	push   $0x0
  80159f:	52                   	push   %edx
  8015a0:	50                   	push   %eax
  8015a1:	6a 1a                	push   $0x1a
  8015a3:	e8 e1 fc ff ff       	call   801289 <syscall>
  8015a8:	83 c4 18             	add    $0x18,%esp
}
  8015ab:	90                   	nop
  8015ac:	c9                   	leave  
  8015ad:	c3                   	ret    

008015ae <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8015ae:	55                   	push   %ebp
  8015af:	89 e5                	mov    %esp,%ebp
  8015b1:	83 ec 04             	sub    $0x4,%esp
  8015b4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b7:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8015ba:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8015bd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8015c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c4:	6a 00                	push   $0x0
  8015c6:	51                   	push   %ecx
  8015c7:	52                   	push   %edx
  8015c8:	ff 75 0c             	pushl  0xc(%ebp)
  8015cb:	50                   	push   %eax
  8015cc:	6a 1c                	push   $0x1c
  8015ce:	e8 b6 fc ff ff       	call   801289 <syscall>
  8015d3:	83 c4 18             	add    $0x18,%esp
}
  8015d6:	c9                   	leave  
  8015d7:	c3                   	ret    

008015d8 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8015d8:	55                   	push   %ebp
  8015d9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8015db:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	6a 00                	push   $0x0
  8015e3:	6a 00                	push   $0x0
  8015e5:	6a 00                	push   $0x0
  8015e7:	52                   	push   %edx
  8015e8:	50                   	push   %eax
  8015e9:	6a 1d                	push   $0x1d
  8015eb:	e8 99 fc ff ff       	call   801289 <syscall>
  8015f0:	83 c4 18             	add    $0x18,%esp
}
  8015f3:	c9                   	leave  
  8015f4:	c3                   	ret    

008015f5 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8015f5:	55                   	push   %ebp
  8015f6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8015f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	51                   	push   %ecx
  801606:	52                   	push   %edx
  801607:	50                   	push   %eax
  801608:	6a 1e                	push   $0x1e
  80160a:	e8 7a fc ff ff       	call   801289 <syscall>
  80160f:	83 c4 18             	add    $0x18,%esp
}
  801612:	c9                   	leave  
  801613:	c3                   	ret    

00801614 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801614:	55                   	push   %ebp
  801615:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801617:	8b 55 0c             	mov    0xc(%ebp),%edx
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
  80161d:	6a 00                	push   $0x0
  80161f:	6a 00                	push   $0x0
  801621:	6a 00                	push   $0x0
  801623:	52                   	push   %edx
  801624:	50                   	push   %eax
  801625:	6a 1f                	push   $0x1f
  801627:	e8 5d fc ff ff       	call   801289 <syscall>
  80162c:	83 c4 18             	add    $0x18,%esp
}
  80162f:	c9                   	leave  
  801630:	c3                   	ret    

00801631 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801631:	55                   	push   %ebp
  801632:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801634:	6a 00                	push   $0x0
  801636:	6a 00                	push   $0x0
  801638:	6a 00                	push   $0x0
  80163a:	6a 00                	push   $0x0
  80163c:	6a 00                	push   $0x0
  80163e:	6a 20                	push   $0x20
  801640:	e8 44 fc ff ff       	call   801289 <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
}
  801648:	c9                   	leave  
  801649:	c3                   	ret    

0080164a <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80164a:	55                   	push   %ebp
  80164b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	6a 00                	push   $0x0
  801652:	ff 75 14             	pushl  0x14(%ebp)
  801655:	ff 75 10             	pushl  0x10(%ebp)
  801658:	ff 75 0c             	pushl  0xc(%ebp)
  80165b:	50                   	push   %eax
  80165c:	6a 21                	push   $0x21
  80165e:	e8 26 fc ff ff       	call   801289 <syscall>
  801663:	83 c4 18             	add    $0x18,%esp
}
  801666:	c9                   	leave  
  801667:	c3                   	ret    

00801668 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801668:	55                   	push   %ebp
  801669:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	6a 00                	push   $0x0
  801670:	6a 00                	push   $0x0
  801672:	6a 00                	push   $0x0
  801674:	6a 00                	push   $0x0
  801676:	50                   	push   %eax
  801677:	6a 22                	push   $0x22
  801679:	e8 0b fc ff ff       	call   801289 <syscall>
  80167e:	83 c4 18             	add    $0x18,%esp
}
  801681:	90                   	nop
  801682:	c9                   	leave  
  801683:	c3                   	ret    

00801684 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801684:	55                   	push   %ebp
  801685:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801687:	8b 45 08             	mov    0x8(%ebp),%eax
  80168a:	6a 00                	push   $0x0
  80168c:	6a 00                	push   $0x0
  80168e:	6a 00                	push   $0x0
  801690:	6a 00                	push   $0x0
  801692:	50                   	push   %eax
  801693:	6a 23                	push   $0x23
  801695:	e8 ef fb ff ff       	call   801289 <syscall>
  80169a:	83 c4 18             	add    $0x18,%esp
}
  80169d:	90                   	nop
  80169e:	c9                   	leave  
  80169f:	c3                   	ret    

008016a0 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8016a0:	55                   	push   %ebp
  8016a1:	89 e5                	mov    %esp,%ebp
  8016a3:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8016a6:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016a9:	8d 50 04             	lea    0x4(%eax),%edx
  8016ac:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8016af:	6a 00                	push   $0x0
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	52                   	push   %edx
  8016b6:	50                   	push   %eax
  8016b7:	6a 24                	push   $0x24
  8016b9:	e8 cb fb ff ff       	call   801289 <syscall>
  8016be:	83 c4 18             	add    $0x18,%esp
	return result;
  8016c1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8016c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ca:	89 01                	mov    %eax,(%ecx)
  8016cc:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	c9                   	leave  
  8016d3:	c2 04 00             	ret    $0x4

008016d6 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8016d6:	55                   	push   %ebp
  8016d7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 00                	push   $0x0
  8016dd:	ff 75 10             	pushl  0x10(%ebp)
  8016e0:	ff 75 0c             	pushl  0xc(%ebp)
  8016e3:	ff 75 08             	pushl  0x8(%ebp)
  8016e6:	6a 13                	push   $0x13
  8016e8:	e8 9c fb ff ff       	call   801289 <syscall>
  8016ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8016f0:	90                   	nop
}
  8016f1:	c9                   	leave  
  8016f2:	c3                   	ret    

008016f3 <sys_rcr2>:
uint32 sys_rcr2()
{
  8016f3:	55                   	push   %ebp
  8016f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8016f6:	6a 00                	push   $0x0
  8016f8:	6a 00                	push   $0x0
  8016fa:	6a 00                	push   $0x0
  8016fc:	6a 00                	push   $0x0
  8016fe:	6a 00                	push   $0x0
  801700:	6a 25                	push   $0x25
  801702:	e8 82 fb ff ff       	call   801289 <syscall>
  801707:	83 c4 18             	add    $0x18,%esp
}
  80170a:	c9                   	leave  
  80170b:	c3                   	ret    

0080170c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80170c:	55                   	push   %ebp
  80170d:	89 e5                	mov    %esp,%ebp
  80170f:	83 ec 04             	sub    $0x4,%esp
  801712:	8b 45 08             	mov    0x8(%ebp),%eax
  801715:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801718:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80171c:	6a 00                	push   $0x0
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	50                   	push   %eax
  801725:	6a 26                	push   $0x26
  801727:	e8 5d fb ff ff       	call   801289 <syscall>
  80172c:	83 c4 18             	add    $0x18,%esp
	return ;
  80172f:	90                   	nop
}
  801730:	c9                   	leave  
  801731:	c3                   	ret    

00801732 <rsttst>:
void rsttst()
{
  801732:	55                   	push   %ebp
  801733:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801735:	6a 00                	push   $0x0
  801737:	6a 00                	push   $0x0
  801739:	6a 00                	push   $0x0
  80173b:	6a 00                	push   $0x0
  80173d:	6a 00                	push   $0x0
  80173f:	6a 28                	push   $0x28
  801741:	e8 43 fb ff ff       	call   801289 <syscall>
  801746:	83 c4 18             	add    $0x18,%esp
	return ;
  801749:	90                   	nop
}
  80174a:	c9                   	leave  
  80174b:	c3                   	ret    

0080174c <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80174c:	55                   	push   %ebp
  80174d:	89 e5                	mov    %esp,%ebp
  80174f:	83 ec 04             	sub    $0x4,%esp
  801752:	8b 45 14             	mov    0x14(%ebp),%eax
  801755:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801758:	8b 55 18             	mov    0x18(%ebp),%edx
  80175b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80175f:	52                   	push   %edx
  801760:	50                   	push   %eax
  801761:	ff 75 10             	pushl  0x10(%ebp)
  801764:	ff 75 0c             	pushl  0xc(%ebp)
  801767:	ff 75 08             	pushl  0x8(%ebp)
  80176a:	6a 27                	push   $0x27
  80176c:	e8 18 fb ff ff       	call   801289 <syscall>
  801771:	83 c4 18             	add    $0x18,%esp
	return ;
  801774:	90                   	nop
}
  801775:	c9                   	leave  
  801776:	c3                   	ret    

00801777 <chktst>:
void chktst(uint32 n)
{
  801777:	55                   	push   %ebp
  801778:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	ff 75 08             	pushl  0x8(%ebp)
  801785:	6a 29                	push   $0x29
  801787:	e8 fd fa ff ff       	call   801289 <syscall>
  80178c:	83 c4 18             	add    $0x18,%esp
	return ;
  80178f:	90                   	nop
}
  801790:	c9                   	leave  
  801791:	c3                   	ret    

00801792 <inctst>:

void inctst()
{
  801792:	55                   	push   %ebp
  801793:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 00                	push   $0x0
  80179f:	6a 2a                	push   $0x2a
  8017a1:	e8 e3 fa ff ff       	call   801289 <syscall>
  8017a6:	83 c4 18             	add    $0x18,%esp
	return ;
  8017a9:	90                   	nop
}
  8017aa:	c9                   	leave  
  8017ab:	c3                   	ret    

008017ac <gettst>:
uint32 gettst()
{
  8017ac:	55                   	push   %ebp
  8017ad:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	6a 00                	push   $0x0
  8017b9:	6a 2b                	push   $0x2b
  8017bb:	e8 c9 fa ff ff       	call   801289 <syscall>
  8017c0:	83 c4 18             	add    $0x18,%esp
}
  8017c3:	c9                   	leave  
  8017c4:	c3                   	ret    

008017c5 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8017c5:	55                   	push   %ebp
  8017c6:	89 e5                	mov    %esp,%ebp
  8017c8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 2c                	push   $0x2c
  8017d7:	e8 ad fa ff ff       	call   801289 <syscall>
  8017dc:	83 c4 18             	add    $0x18,%esp
  8017df:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8017e2:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8017e6:	75 07                	jne    8017ef <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8017e8:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ed:	eb 05                	jmp    8017f4 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8017ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
  8017f9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017fc:	6a 00                	push   $0x0
  8017fe:	6a 00                	push   $0x0
  801800:	6a 00                	push   $0x0
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 2c                	push   $0x2c
  801808:	e8 7c fa ff ff       	call   801289 <syscall>
  80180d:	83 c4 18             	add    $0x18,%esp
  801810:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801813:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801817:	75 07                	jne    801820 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801819:	b8 01 00 00 00       	mov    $0x1,%eax
  80181e:	eb 05                	jmp    801825 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801820:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
  80182a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80182d:	6a 00                	push   $0x0
  80182f:	6a 00                	push   $0x0
  801831:	6a 00                	push   $0x0
  801833:	6a 00                	push   $0x0
  801835:	6a 00                	push   $0x0
  801837:	6a 2c                	push   $0x2c
  801839:	e8 4b fa ff ff       	call   801289 <syscall>
  80183e:	83 c4 18             	add    $0x18,%esp
  801841:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801844:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801848:	75 07                	jne    801851 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80184a:	b8 01 00 00 00       	mov    $0x1,%eax
  80184f:	eb 05                	jmp    801856 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801851:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801856:	c9                   	leave  
  801857:	c3                   	ret    

00801858 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801858:	55                   	push   %ebp
  801859:	89 e5                	mov    %esp,%ebp
  80185b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80185e:	6a 00                	push   $0x0
  801860:	6a 00                	push   $0x0
  801862:	6a 00                	push   $0x0
  801864:	6a 00                	push   $0x0
  801866:	6a 00                	push   $0x0
  801868:	6a 2c                	push   $0x2c
  80186a:	e8 1a fa ff ff       	call   801289 <syscall>
  80186f:	83 c4 18             	add    $0x18,%esp
  801872:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801875:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801879:	75 07                	jne    801882 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80187b:	b8 01 00 00 00       	mov    $0x1,%eax
  801880:	eb 05                	jmp    801887 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801882:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	ff 75 08             	pushl  0x8(%ebp)
  801897:	6a 2d                	push   $0x2d
  801899:	e8 eb f9 ff ff       	call   801289 <syscall>
  80189e:	83 c4 18             	add    $0x18,%esp
	return ;
  8018a1:	90                   	nop
}
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
  8018a7:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8018a8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8018ab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8018ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b4:	6a 00                	push   $0x0
  8018b6:	53                   	push   %ebx
  8018b7:	51                   	push   %ecx
  8018b8:	52                   	push   %edx
  8018b9:	50                   	push   %eax
  8018ba:	6a 2e                	push   $0x2e
  8018bc:	e8 c8 f9 ff ff       	call   801289 <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
}
  8018c4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8018c7:	c9                   	leave  
  8018c8:	c3                   	ret    

008018c9 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8018c9:	55                   	push   %ebp
  8018ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8018cc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8018cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d2:	6a 00                	push   $0x0
  8018d4:	6a 00                	push   $0x0
  8018d6:	6a 00                	push   $0x0
  8018d8:	52                   	push   %edx
  8018d9:	50                   	push   %eax
  8018da:	6a 2f                	push   $0x2f
  8018dc:	e8 a8 f9 ff ff       	call   801289 <syscall>
  8018e1:	83 c4 18             	add    $0x18,%esp
}
  8018e4:	c9                   	leave  
  8018e5:	c3                   	ret    

008018e6 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8018e6:	55                   	push   %ebp
  8018e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8018e9:	6a 00                	push   $0x0
  8018eb:	6a 00                	push   $0x0
  8018ed:	6a 00                	push   $0x0
  8018ef:	ff 75 0c             	pushl  0xc(%ebp)
  8018f2:	ff 75 08             	pushl  0x8(%ebp)
  8018f5:	6a 30                	push   $0x30
  8018f7:	e8 8d f9 ff ff       	call   801289 <syscall>
  8018fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8018ff:	90                   	nop
}
  801900:	c9                   	leave  
  801901:	c3                   	ret    
  801902:	66 90                	xchg   %ax,%ax

00801904 <__udivdi3>:
  801904:	55                   	push   %ebp
  801905:	57                   	push   %edi
  801906:	56                   	push   %esi
  801907:	53                   	push   %ebx
  801908:	83 ec 1c             	sub    $0x1c,%esp
  80190b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80190f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801913:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801917:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80191b:	89 ca                	mov    %ecx,%edx
  80191d:	89 f8                	mov    %edi,%eax
  80191f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801923:	85 f6                	test   %esi,%esi
  801925:	75 2d                	jne    801954 <__udivdi3+0x50>
  801927:	39 cf                	cmp    %ecx,%edi
  801929:	77 65                	ja     801990 <__udivdi3+0x8c>
  80192b:	89 fd                	mov    %edi,%ebp
  80192d:	85 ff                	test   %edi,%edi
  80192f:	75 0b                	jne    80193c <__udivdi3+0x38>
  801931:	b8 01 00 00 00       	mov    $0x1,%eax
  801936:	31 d2                	xor    %edx,%edx
  801938:	f7 f7                	div    %edi
  80193a:	89 c5                	mov    %eax,%ebp
  80193c:	31 d2                	xor    %edx,%edx
  80193e:	89 c8                	mov    %ecx,%eax
  801940:	f7 f5                	div    %ebp
  801942:	89 c1                	mov    %eax,%ecx
  801944:	89 d8                	mov    %ebx,%eax
  801946:	f7 f5                	div    %ebp
  801948:	89 cf                	mov    %ecx,%edi
  80194a:	89 fa                	mov    %edi,%edx
  80194c:	83 c4 1c             	add    $0x1c,%esp
  80194f:	5b                   	pop    %ebx
  801950:	5e                   	pop    %esi
  801951:	5f                   	pop    %edi
  801952:	5d                   	pop    %ebp
  801953:	c3                   	ret    
  801954:	39 ce                	cmp    %ecx,%esi
  801956:	77 28                	ja     801980 <__udivdi3+0x7c>
  801958:	0f bd fe             	bsr    %esi,%edi
  80195b:	83 f7 1f             	xor    $0x1f,%edi
  80195e:	75 40                	jne    8019a0 <__udivdi3+0x9c>
  801960:	39 ce                	cmp    %ecx,%esi
  801962:	72 0a                	jb     80196e <__udivdi3+0x6a>
  801964:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801968:	0f 87 9e 00 00 00    	ja     801a0c <__udivdi3+0x108>
  80196e:	b8 01 00 00 00       	mov    $0x1,%eax
  801973:	89 fa                	mov    %edi,%edx
  801975:	83 c4 1c             	add    $0x1c,%esp
  801978:	5b                   	pop    %ebx
  801979:	5e                   	pop    %esi
  80197a:	5f                   	pop    %edi
  80197b:	5d                   	pop    %ebp
  80197c:	c3                   	ret    
  80197d:	8d 76 00             	lea    0x0(%esi),%esi
  801980:	31 ff                	xor    %edi,%edi
  801982:	31 c0                	xor    %eax,%eax
  801984:	89 fa                	mov    %edi,%edx
  801986:	83 c4 1c             	add    $0x1c,%esp
  801989:	5b                   	pop    %ebx
  80198a:	5e                   	pop    %esi
  80198b:	5f                   	pop    %edi
  80198c:	5d                   	pop    %ebp
  80198d:	c3                   	ret    
  80198e:	66 90                	xchg   %ax,%ax
  801990:	89 d8                	mov    %ebx,%eax
  801992:	f7 f7                	div    %edi
  801994:	31 ff                	xor    %edi,%edi
  801996:	89 fa                	mov    %edi,%edx
  801998:	83 c4 1c             	add    $0x1c,%esp
  80199b:	5b                   	pop    %ebx
  80199c:	5e                   	pop    %esi
  80199d:	5f                   	pop    %edi
  80199e:	5d                   	pop    %ebp
  80199f:	c3                   	ret    
  8019a0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8019a5:	89 eb                	mov    %ebp,%ebx
  8019a7:	29 fb                	sub    %edi,%ebx
  8019a9:	89 f9                	mov    %edi,%ecx
  8019ab:	d3 e6                	shl    %cl,%esi
  8019ad:	89 c5                	mov    %eax,%ebp
  8019af:	88 d9                	mov    %bl,%cl
  8019b1:	d3 ed                	shr    %cl,%ebp
  8019b3:	89 e9                	mov    %ebp,%ecx
  8019b5:	09 f1                	or     %esi,%ecx
  8019b7:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8019bb:	89 f9                	mov    %edi,%ecx
  8019bd:	d3 e0                	shl    %cl,%eax
  8019bf:	89 c5                	mov    %eax,%ebp
  8019c1:	89 d6                	mov    %edx,%esi
  8019c3:	88 d9                	mov    %bl,%cl
  8019c5:	d3 ee                	shr    %cl,%esi
  8019c7:	89 f9                	mov    %edi,%ecx
  8019c9:	d3 e2                	shl    %cl,%edx
  8019cb:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019cf:	88 d9                	mov    %bl,%cl
  8019d1:	d3 e8                	shr    %cl,%eax
  8019d3:	09 c2                	or     %eax,%edx
  8019d5:	89 d0                	mov    %edx,%eax
  8019d7:	89 f2                	mov    %esi,%edx
  8019d9:	f7 74 24 0c          	divl   0xc(%esp)
  8019dd:	89 d6                	mov    %edx,%esi
  8019df:	89 c3                	mov    %eax,%ebx
  8019e1:	f7 e5                	mul    %ebp
  8019e3:	39 d6                	cmp    %edx,%esi
  8019e5:	72 19                	jb     801a00 <__udivdi3+0xfc>
  8019e7:	74 0b                	je     8019f4 <__udivdi3+0xf0>
  8019e9:	89 d8                	mov    %ebx,%eax
  8019eb:	31 ff                	xor    %edi,%edi
  8019ed:	e9 58 ff ff ff       	jmp    80194a <__udivdi3+0x46>
  8019f2:	66 90                	xchg   %ax,%ax
  8019f4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8019f8:	89 f9                	mov    %edi,%ecx
  8019fa:	d3 e2                	shl    %cl,%edx
  8019fc:	39 c2                	cmp    %eax,%edx
  8019fe:	73 e9                	jae    8019e9 <__udivdi3+0xe5>
  801a00:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801a03:	31 ff                	xor    %edi,%edi
  801a05:	e9 40 ff ff ff       	jmp    80194a <__udivdi3+0x46>
  801a0a:	66 90                	xchg   %ax,%ax
  801a0c:	31 c0                	xor    %eax,%eax
  801a0e:	e9 37 ff ff ff       	jmp    80194a <__udivdi3+0x46>
  801a13:	90                   	nop

00801a14 <__umoddi3>:
  801a14:	55                   	push   %ebp
  801a15:	57                   	push   %edi
  801a16:	56                   	push   %esi
  801a17:	53                   	push   %ebx
  801a18:	83 ec 1c             	sub    $0x1c,%esp
  801a1b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801a1f:	8b 74 24 34          	mov    0x34(%esp),%esi
  801a23:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a27:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801a2b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801a2f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801a33:	89 f3                	mov    %esi,%ebx
  801a35:	89 fa                	mov    %edi,%edx
  801a37:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a3b:	89 34 24             	mov    %esi,(%esp)
  801a3e:	85 c0                	test   %eax,%eax
  801a40:	75 1a                	jne    801a5c <__umoddi3+0x48>
  801a42:	39 f7                	cmp    %esi,%edi
  801a44:	0f 86 a2 00 00 00    	jbe    801aec <__umoddi3+0xd8>
  801a4a:	89 c8                	mov    %ecx,%eax
  801a4c:	89 f2                	mov    %esi,%edx
  801a4e:	f7 f7                	div    %edi
  801a50:	89 d0                	mov    %edx,%eax
  801a52:	31 d2                	xor    %edx,%edx
  801a54:	83 c4 1c             	add    $0x1c,%esp
  801a57:	5b                   	pop    %ebx
  801a58:	5e                   	pop    %esi
  801a59:	5f                   	pop    %edi
  801a5a:	5d                   	pop    %ebp
  801a5b:	c3                   	ret    
  801a5c:	39 f0                	cmp    %esi,%eax
  801a5e:	0f 87 ac 00 00 00    	ja     801b10 <__umoddi3+0xfc>
  801a64:	0f bd e8             	bsr    %eax,%ebp
  801a67:	83 f5 1f             	xor    $0x1f,%ebp
  801a6a:	0f 84 ac 00 00 00    	je     801b1c <__umoddi3+0x108>
  801a70:	bf 20 00 00 00       	mov    $0x20,%edi
  801a75:	29 ef                	sub    %ebp,%edi
  801a77:	89 fe                	mov    %edi,%esi
  801a79:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801a7d:	89 e9                	mov    %ebp,%ecx
  801a7f:	d3 e0                	shl    %cl,%eax
  801a81:	89 d7                	mov    %edx,%edi
  801a83:	89 f1                	mov    %esi,%ecx
  801a85:	d3 ef                	shr    %cl,%edi
  801a87:	09 c7                	or     %eax,%edi
  801a89:	89 e9                	mov    %ebp,%ecx
  801a8b:	d3 e2                	shl    %cl,%edx
  801a8d:	89 14 24             	mov    %edx,(%esp)
  801a90:	89 d8                	mov    %ebx,%eax
  801a92:	d3 e0                	shl    %cl,%eax
  801a94:	89 c2                	mov    %eax,%edx
  801a96:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a9a:	d3 e0                	shl    %cl,%eax
  801a9c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801aa0:	8b 44 24 08          	mov    0x8(%esp),%eax
  801aa4:	89 f1                	mov    %esi,%ecx
  801aa6:	d3 e8                	shr    %cl,%eax
  801aa8:	09 d0                	or     %edx,%eax
  801aaa:	d3 eb                	shr    %cl,%ebx
  801aac:	89 da                	mov    %ebx,%edx
  801aae:	f7 f7                	div    %edi
  801ab0:	89 d3                	mov    %edx,%ebx
  801ab2:	f7 24 24             	mull   (%esp)
  801ab5:	89 c6                	mov    %eax,%esi
  801ab7:	89 d1                	mov    %edx,%ecx
  801ab9:	39 d3                	cmp    %edx,%ebx
  801abb:	0f 82 87 00 00 00    	jb     801b48 <__umoddi3+0x134>
  801ac1:	0f 84 91 00 00 00    	je     801b58 <__umoddi3+0x144>
  801ac7:	8b 54 24 04          	mov    0x4(%esp),%edx
  801acb:	29 f2                	sub    %esi,%edx
  801acd:	19 cb                	sbb    %ecx,%ebx
  801acf:	89 d8                	mov    %ebx,%eax
  801ad1:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801ad5:	d3 e0                	shl    %cl,%eax
  801ad7:	89 e9                	mov    %ebp,%ecx
  801ad9:	d3 ea                	shr    %cl,%edx
  801adb:	09 d0                	or     %edx,%eax
  801add:	89 e9                	mov    %ebp,%ecx
  801adf:	d3 eb                	shr    %cl,%ebx
  801ae1:	89 da                	mov    %ebx,%edx
  801ae3:	83 c4 1c             	add    $0x1c,%esp
  801ae6:	5b                   	pop    %ebx
  801ae7:	5e                   	pop    %esi
  801ae8:	5f                   	pop    %edi
  801ae9:	5d                   	pop    %ebp
  801aea:	c3                   	ret    
  801aeb:	90                   	nop
  801aec:	89 fd                	mov    %edi,%ebp
  801aee:	85 ff                	test   %edi,%edi
  801af0:	75 0b                	jne    801afd <__umoddi3+0xe9>
  801af2:	b8 01 00 00 00       	mov    $0x1,%eax
  801af7:	31 d2                	xor    %edx,%edx
  801af9:	f7 f7                	div    %edi
  801afb:	89 c5                	mov    %eax,%ebp
  801afd:	89 f0                	mov    %esi,%eax
  801aff:	31 d2                	xor    %edx,%edx
  801b01:	f7 f5                	div    %ebp
  801b03:	89 c8                	mov    %ecx,%eax
  801b05:	f7 f5                	div    %ebp
  801b07:	89 d0                	mov    %edx,%eax
  801b09:	e9 44 ff ff ff       	jmp    801a52 <__umoddi3+0x3e>
  801b0e:	66 90                	xchg   %ax,%ax
  801b10:	89 c8                	mov    %ecx,%eax
  801b12:	89 f2                	mov    %esi,%edx
  801b14:	83 c4 1c             	add    $0x1c,%esp
  801b17:	5b                   	pop    %ebx
  801b18:	5e                   	pop    %esi
  801b19:	5f                   	pop    %edi
  801b1a:	5d                   	pop    %ebp
  801b1b:	c3                   	ret    
  801b1c:	3b 04 24             	cmp    (%esp),%eax
  801b1f:	72 06                	jb     801b27 <__umoddi3+0x113>
  801b21:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801b25:	77 0f                	ja     801b36 <__umoddi3+0x122>
  801b27:	89 f2                	mov    %esi,%edx
  801b29:	29 f9                	sub    %edi,%ecx
  801b2b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801b2f:	89 14 24             	mov    %edx,(%esp)
  801b32:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b36:	8b 44 24 04          	mov    0x4(%esp),%eax
  801b3a:	8b 14 24             	mov    (%esp),%edx
  801b3d:	83 c4 1c             	add    $0x1c,%esp
  801b40:	5b                   	pop    %ebx
  801b41:	5e                   	pop    %esi
  801b42:	5f                   	pop    %edi
  801b43:	5d                   	pop    %ebp
  801b44:	c3                   	ret    
  801b45:	8d 76 00             	lea    0x0(%esi),%esi
  801b48:	2b 04 24             	sub    (%esp),%eax
  801b4b:	19 fa                	sbb    %edi,%edx
  801b4d:	89 d1                	mov    %edx,%ecx
  801b4f:	89 c6                	mov    %eax,%esi
  801b51:	e9 71 ff ff ff       	jmp    801ac7 <__umoddi3+0xb3>
  801b56:	66 90                	xchg   %ax,%ax
  801b58:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801b5c:	72 ea                	jb     801b48 <__umoddi3+0x134>
  801b5e:	89 d9                	mov    %ebx,%ecx
  801b60:	e9 62 ff ff ff       	jmp    801ac7 <__umoddi3+0xb3>
