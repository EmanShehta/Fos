
obj/user/tst_invalid_access:     file format elf32-i386


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
  800031:	e8 57 00 00 00       	call   80008d <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/************************************************************/

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp

	uint32 kilo = 1024;
  80003e:	c7 45 f0 00 04 00 00 	movl   $0x400,-0x10(%ebp)
	
	

	/// testing illegal memory access
	{
		uint32 size = 4*kilo;
  800045:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800048:	c1 e0 02             	shl    $0x2,%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)


		unsigned char *x = (unsigned char *)0x80000000;
  80004e:	c7 45 e8 00 00 00 80 	movl   $0x80000000,-0x18(%ebp)

		int i=0;
  800055:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
		for(;i< size+20;i++)
  80005c:	eb 0e                	jmp    80006c <_main+0x34>
		{
			x[i]=-1;
  80005e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800061:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800064:	01 d0                	add    %edx,%eax
  800066:	c6 00 ff             	movb   $0xff,(%eax)


		unsigned char *x = (unsigned char *)0x80000000;

		int i=0;
		for(;i< size+20;i++)
  800069:	ff 45 f4             	incl   -0xc(%ebp)
  80006c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80006f:	8d 50 14             	lea    0x14(%eax),%edx
  800072:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800075:	39 c2                	cmp    %eax,%edx
  800077:	77 e5                	ja     80005e <_main+0x26>
		{
			x[i]=-1;
		}

		panic("ERROR: FOS SHOULD NOT panic here, it should panic earlier in page_fault_handler(), since we have illegal access to page that is NOT EXIST in PF and NOT BELONGS to STACK. REMEMBER: creating new page in page file shouldn't be allowed except ONLY for new stack pages\n");
  800079:	83 ec 04             	sub    $0x4,%esp
  80007c:	68 e0 1a 80 00       	push   $0x801ae0
  800081:	6a 1f                	push   $0x1f
  800083:	68 e9 1b 80 00       	push   $0x801be9
  800088:	e8 1c 01 00 00       	call   8001a9 <_panic>

0080008d <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80008d:	55                   	push   %ebp
  80008e:	89 e5                	mov    %esp,%ebp
  800090:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800093:	e8 f0 11 00 00       	call   801288 <sys_getenvindex>
  800098:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80009b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80009e:	89 d0                	mov    %edx,%eax
  8000a0:	01 c0                	add    %eax,%eax
  8000a2:	01 d0                	add    %edx,%eax
  8000a4:	c1 e0 04             	shl    $0x4,%eax
  8000a7:	29 d0                	sub    %edx,%eax
  8000a9:	c1 e0 03             	shl    $0x3,%eax
  8000ac:	01 d0                	add    %edx,%eax
  8000ae:	c1 e0 02             	shl    $0x2,%eax
  8000b1:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8000b6:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8000bb:	a1 20 30 80 00       	mov    0x803020,%eax
  8000c0:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8000c6:	84 c0                	test   %al,%al
  8000c8:	74 0f                	je     8000d9 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8000ca:	a1 20 30 80 00       	mov    0x803020,%eax
  8000cf:	05 5c 05 00 00       	add    $0x55c,%eax
  8000d4:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8000d9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8000dd:	7e 0a                	jle    8000e9 <libmain+0x5c>
		binaryname = argv[0];
  8000df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8000e2:	8b 00                	mov    (%eax),%eax
  8000e4:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8000e9:	83 ec 08             	sub    $0x8,%esp
  8000ec:	ff 75 0c             	pushl  0xc(%ebp)
  8000ef:	ff 75 08             	pushl  0x8(%ebp)
  8000f2:	e8 41 ff ff ff       	call   800038 <_main>
  8000f7:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8000fa:	e8 24 13 00 00       	call   801423 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8000ff:	83 ec 0c             	sub    $0xc,%esp
  800102:	68 1c 1c 80 00       	push   $0x801c1c
  800107:	e8 51 03 00 00       	call   80045d <cprintf>
  80010c:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80010f:	a1 20 30 80 00       	mov    0x803020,%eax
  800114:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  80011a:	a1 20 30 80 00       	mov    0x803020,%eax
  80011f:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800125:	83 ec 04             	sub    $0x4,%esp
  800128:	52                   	push   %edx
  800129:	50                   	push   %eax
  80012a:	68 44 1c 80 00       	push   $0x801c44
  80012f:	e8 29 03 00 00       	call   80045d <cprintf>
  800134:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800137:	a1 20 30 80 00       	mov    0x803020,%eax
  80013c:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800142:	a1 20 30 80 00       	mov    0x803020,%eax
  800147:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  80014d:	a1 20 30 80 00       	mov    0x803020,%eax
  800152:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800158:	51                   	push   %ecx
  800159:	52                   	push   %edx
  80015a:	50                   	push   %eax
  80015b:	68 6c 1c 80 00       	push   $0x801c6c
  800160:	e8 f8 02 00 00       	call   80045d <cprintf>
  800165:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800168:	83 ec 0c             	sub    $0xc,%esp
  80016b:	68 1c 1c 80 00       	push   $0x801c1c
  800170:	e8 e8 02 00 00       	call   80045d <cprintf>
  800175:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800178:	e8 c0 12 00 00       	call   80143d <sys_enable_interrupt>

	// exit gracefully
	exit();
  80017d:	e8 19 00 00 00       	call   80019b <exit>
}
  800182:	90                   	nop
  800183:	c9                   	leave  
  800184:	c3                   	ret    

00800185 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800185:	55                   	push   %ebp
  800186:	89 e5                	mov    %esp,%ebp
  800188:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80018b:	83 ec 0c             	sub    $0xc,%esp
  80018e:	6a 00                	push   $0x0
  800190:	e8 bf 10 00 00       	call   801254 <sys_env_destroy>
  800195:	83 c4 10             	add    $0x10,%esp
}
  800198:	90                   	nop
  800199:	c9                   	leave  
  80019a:	c3                   	ret    

0080019b <exit>:

void
exit(void)
{
  80019b:	55                   	push   %ebp
  80019c:	89 e5                	mov    %esp,%ebp
  80019e:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8001a1:	e8 14 11 00 00       	call   8012ba <sys_env_exit>
}
  8001a6:	90                   	nop
  8001a7:	c9                   	leave  
  8001a8:	c3                   	ret    

008001a9 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8001a9:	55                   	push   %ebp
  8001aa:	89 e5                	mov    %esp,%ebp
  8001ac:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8001af:	8d 45 10             	lea    0x10(%ebp),%eax
  8001b2:	83 c0 04             	add    $0x4,%eax
  8001b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8001b8:	a1 18 31 80 00       	mov    0x803118,%eax
  8001bd:	85 c0                	test   %eax,%eax
  8001bf:	74 16                	je     8001d7 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8001c1:	a1 18 31 80 00       	mov    0x803118,%eax
  8001c6:	83 ec 08             	sub    $0x8,%esp
  8001c9:	50                   	push   %eax
  8001ca:	68 c4 1c 80 00       	push   $0x801cc4
  8001cf:	e8 89 02 00 00       	call   80045d <cprintf>
  8001d4:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8001d7:	a1 00 30 80 00       	mov    0x803000,%eax
  8001dc:	ff 75 0c             	pushl  0xc(%ebp)
  8001df:	ff 75 08             	pushl  0x8(%ebp)
  8001e2:	50                   	push   %eax
  8001e3:	68 c9 1c 80 00       	push   $0x801cc9
  8001e8:	e8 70 02 00 00       	call   80045d <cprintf>
  8001ed:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8001f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8001f3:	83 ec 08             	sub    $0x8,%esp
  8001f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8001f9:	50                   	push   %eax
  8001fa:	e8 f3 01 00 00       	call   8003f2 <vcprintf>
  8001ff:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800202:	83 ec 08             	sub    $0x8,%esp
  800205:	6a 00                	push   $0x0
  800207:	68 e5 1c 80 00       	push   $0x801ce5
  80020c:	e8 e1 01 00 00       	call   8003f2 <vcprintf>
  800211:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800214:	e8 82 ff ff ff       	call   80019b <exit>

	// should not return here
	while (1) ;
  800219:	eb fe                	jmp    800219 <_panic+0x70>

0080021b <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80021b:	55                   	push   %ebp
  80021c:	89 e5                	mov    %esp,%ebp
  80021e:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800221:	a1 20 30 80 00       	mov    0x803020,%eax
  800226:	8b 50 74             	mov    0x74(%eax),%edx
  800229:	8b 45 0c             	mov    0xc(%ebp),%eax
  80022c:	39 c2                	cmp    %eax,%edx
  80022e:	74 14                	je     800244 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800230:	83 ec 04             	sub    $0x4,%esp
  800233:	68 e8 1c 80 00       	push   $0x801ce8
  800238:	6a 26                	push   $0x26
  80023a:	68 34 1d 80 00       	push   $0x801d34
  80023f:	e8 65 ff ff ff       	call   8001a9 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800244:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80024b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800252:	e9 c2 00 00 00       	jmp    800319 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800257:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80025a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800261:	8b 45 08             	mov    0x8(%ebp),%eax
  800264:	01 d0                	add    %edx,%eax
  800266:	8b 00                	mov    (%eax),%eax
  800268:	85 c0                	test   %eax,%eax
  80026a:	75 08                	jne    800274 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80026c:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80026f:	e9 a2 00 00 00       	jmp    800316 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800274:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80027b:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800282:	eb 69                	jmp    8002ed <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800284:	a1 20 30 80 00       	mov    0x803020,%eax
  800289:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80028f:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800292:	89 d0                	mov    %edx,%eax
  800294:	01 c0                	add    %eax,%eax
  800296:	01 d0                	add    %edx,%eax
  800298:	c1 e0 03             	shl    $0x3,%eax
  80029b:	01 c8                	add    %ecx,%eax
  80029d:	8a 40 04             	mov    0x4(%eax),%al
  8002a0:	84 c0                	test   %al,%al
  8002a2:	75 46                	jne    8002ea <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002a4:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a9:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8002af:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8002b2:	89 d0                	mov    %edx,%eax
  8002b4:	01 c0                	add    %eax,%eax
  8002b6:	01 d0                	add    %edx,%eax
  8002b8:	c1 e0 03             	shl    $0x3,%eax
  8002bb:	01 c8                	add    %ecx,%eax
  8002bd:	8b 00                	mov    (%eax),%eax
  8002bf:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8002c2:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8002c5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002ca:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8002cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002cf:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d9:	01 c8                	add    %ecx,%eax
  8002db:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8002dd:	39 c2                	cmp    %eax,%edx
  8002df:	75 09                	jne    8002ea <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8002e1:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8002e8:	eb 12                	jmp    8002fc <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8002ea:	ff 45 e8             	incl   -0x18(%ebp)
  8002ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8002f2:	8b 50 74             	mov    0x74(%eax),%edx
  8002f5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8002f8:	39 c2                	cmp    %eax,%edx
  8002fa:	77 88                	ja     800284 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8002fc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800300:	75 14                	jne    800316 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800302:	83 ec 04             	sub    $0x4,%esp
  800305:	68 40 1d 80 00       	push   $0x801d40
  80030a:	6a 3a                	push   $0x3a
  80030c:	68 34 1d 80 00       	push   $0x801d34
  800311:	e8 93 fe ff ff       	call   8001a9 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800316:	ff 45 f0             	incl   -0x10(%ebp)
  800319:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80031c:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80031f:	0f 8c 32 ff ff ff    	jl     800257 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800325:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80032c:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800333:	eb 26                	jmp    80035b <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800335:	a1 20 30 80 00       	mov    0x803020,%eax
  80033a:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800340:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800343:	89 d0                	mov    %edx,%eax
  800345:	01 c0                	add    %eax,%eax
  800347:	01 d0                	add    %edx,%eax
  800349:	c1 e0 03             	shl    $0x3,%eax
  80034c:	01 c8                	add    %ecx,%eax
  80034e:	8a 40 04             	mov    0x4(%eax),%al
  800351:	3c 01                	cmp    $0x1,%al
  800353:	75 03                	jne    800358 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800355:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800358:	ff 45 e0             	incl   -0x20(%ebp)
  80035b:	a1 20 30 80 00       	mov    0x803020,%eax
  800360:	8b 50 74             	mov    0x74(%eax),%edx
  800363:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800366:	39 c2                	cmp    %eax,%edx
  800368:	77 cb                	ja     800335 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80036a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036d:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800370:	74 14                	je     800386 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800372:	83 ec 04             	sub    $0x4,%esp
  800375:	68 94 1d 80 00       	push   $0x801d94
  80037a:	6a 44                	push   $0x44
  80037c:	68 34 1d 80 00       	push   $0x801d34
  800381:	e8 23 fe ff ff       	call   8001a9 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800386:	90                   	nop
  800387:	c9                   	leave  
  800388:	c3                   	ret    

00800389 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800389:	55                   	push   %ebp
  80038a:	89 e5                	mov    %esp,%ebp
  80038c:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80038f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800392:	8b 00                	mov    (%eax),%eax
  800394:	8d 48 01             	lea    0x1(%eax),%ecx
  800397:	8b 55 0c             	mov    0xc(%ebp),%edx
  80039a:	89 0a                	mov    %ecx,(%edx)
  80039c:	8b 55 08             	mov    0x8(%ebp),%edx
  80039f:	88 d1                	mov    %dl,%cl
  8003a1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003a4:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8003a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ab:	8b 00                	mov    (%eax),%eax
  8003ad:	3d ff 00 00 00       	cmp    $0xff,%eax
  8003b2:	75 2c                	jne    8003e0 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8003b4:	a0 24 30 80 00       	mov    0x803024,%al
  8003b9:	0f b6 c0             	movzbl %al,%eax
  8003bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003bf:	8b 12                	mov    (%edx),%edx
  8003c1:	89 d1                	mov    %edx,%ecx
  8003c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8003c6:	83 c2 08             	add    $0x8,%edx
  8003c9:	83 ec 04             	sub    $0x4,%esp
  8003cc:	50                   	push   %eax
  8003cd:	51                   	push   %ecx
  8003ce:	52                   	push   %edx
  8003cf:	e8 3e 0e 00 00       	call   801212 <sys_cputs>
  8003d4:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8003d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003da:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8003e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003e3:	8b 40 04             	mov    0x4(%eax),%eax
  8003e6:	8d 50 01             	lea    0x1(%eax),%edx
  8003e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ec:	89 50 04             	mov    %edx,0x4(%eax)
}
  8003ef:	90                   	nop
  8003f0:	c9                   	leave  
  8003f1:	c3                   	ret    

008003f2 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8003f2:	55                   	push   %ebp
  8003f3:	89 e5                	mov    %esp,%ebp
  8003f5:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8003fb:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800402:	00 00 00 
	b.cnt = 0;
  800405:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80040c:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80040f:	ff 75 0c             	pushl  0xc(%ebp)
  800412:	ff 75 08             	pushl  0x8(%ebp)
  800415:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80041b:	50                   	push   %eax
  80041c:	68 89 03 80 00       	push   $0x800389
  800421:	e8 11 02 00 00       	call   800637 <vprintfmt>
  800426:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800429:	a0 24 30 80 00       	mov    0x803024,%al
  80042e:	0f b6 c0             	movzbl %al,%eax
  800431:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800437:	83 ec 04             	sub    $0x4,%esp
  80043a:	50                   	push   %eax
  80043b:	52                   	push   %edx
  80043c:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800442:	83 c0 08             	add    $0x8,%eax
  800445:	50                   	push   %eax
  800446:	e8 c7 0d 00 00       	call   801212 <sys_cputs>
  80044b:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80044e:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800455:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  80045b:	c9                   	leave  
  80045c:	c3                   	ret    

0080045d <cprintf>:

int cprintf(const char *fmt, ...) {
  80045d:	55                   	push   %ebp
  80045e:	89 e5                	mov    %esp,%ebp
  800460:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800463:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80046a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80046d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	83 ec 08             	sub    $0x8,%esp
  800476:	ff 75 f4             	pushl  -0xc(%ebp)
  800479:	50                   	push   %eax
  80047a:	e8 73 ff ff ff       	call   8003f2 <vcprintf>
  80047f:	83 c4 10             	add    $0x10,%esp
  800482:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800485:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800488:	c9                   	leave  
  800489:	c3                   	ret    

0080048a <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80048a:	55                   	push   %ebp
  80048b:	89 e5                	mov    %esp,%ebp
  80048d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800490:	e8 8e 0f 00 00       	call   801423 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800495:	8d 45 0c             	lea    0xc(%ebp),%eax
  800498:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80049b:	8b 45 08             	mov    0x8(%ebp),%eax
  80049e:	83 ec 08             	sub    $0x8,%esp
  8004a1:	ff 75 f4             	pushl  -0xc(%ebp)
  8004a4:	50                   	push   %eax
  8004a5:	e8 48 ff ff ff       	call   8003f2 <vcprintf>
  8004aa:	83 c4 10             	add    $0x10,%esp
  8004ad:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8004b0:	e8 88 0f 00 00       	call   80143d <sys_enable_interrupt>
	return cnt;
  8004b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8004b8:	c9                   	leave  
  8004b9:	c3                   	ret    

008004ba <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8004ba:	55                   	push   %ebp
  8004bb:	89 e5                	mov    %esp,%ebp
  8004bd:	53                   	push   %ebx
  8004be:	83 ec 14             	sub    $0x14,%esp
  8004c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8004c7:	8b 45 14             	mov    0x14(%ebp),%eax
  8004ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8004cd:	8b 45 18             	mov    0x18(%ebp),%eax
  8004d0:	ba 00 00 00 00       	mov    $0x0,%edx
  8004d5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004d8:	77 55                	ja     80052f <printnum+0x75>
  8004da:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8004dd:	72 05                	jb     8004e4 <printnum+0x2a>
  8004df:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8004e2:	77 4b                	ja     80052f <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8004e4:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8004e7:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8004ea:	8b 45 18             	mov    0x18(%ebp),%eax
  8004ed:	ba 00 00 00 00       	mov    $0x0,%edx
  8004f2:	52                   	push   %edx
  8004f3:	50                   	push   %eax
  8004f4:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f7:	ff 75 f0             	pushl  -0x10(%ebp)
  8004fa:	e8 61 13 00 00       	call   801860 <__udivdi3>
  8004ff:	83 c4 10             	add    $0x10,%esp
  800502:	83 ec 04             	sub    $0x4,%esp
  800505:	ff 75 20             	pushl  0x20(%ebp)
  800508:	53                   	push   %ebx
  800509:	ff 75 18             	pushl  0x18(%ebp)
  80050c:	52                   	push   %edx
  80050d:	50                   	push   %eax
  80050e:	ff 75 0c             	pushl  0xc(%ebp)
  800511:	ff 75 08             	pushl  0x8(%ebp)
  800514:	e8 a1 ff ff ff       	call   8004ba <printnum>
  800519:	83 c4 20             	add    $0x20,%esp
  80051c:	eb 1a                	jmp    800538 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  80051e:	83 ec 08             	sub    $0x8,%esp
  800521:	ff 75 0c             	pushl  0xc(%ebp)
  800524:	ff 75 20             	pushl  0x20(%ebp)
  800527:	8b 45 08             	mov    0x8(%ebp),%eax
  80052a:	ff d0                	call   *%eax
  80052c:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  80052f:	ff 4d 1c             	decl   0x1c(%ebp)
  800532:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800536:	7f e6                	jg     80051e <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800538:	8b 4d 18             	mov    0x18(%ebp),%ecx
  80053b:	bb 00 00 00 00       	mov    $0x0,%ebx
  800540:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800543:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800546:	53                   	push   %ebx
  800547:	51                   	push   %ecx
  800548:	52                   	push   %edx
  800549:	50                   	push   %eax
  80054a:	e8 21 14 00 00       	call   801970 <__umoddi3>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	05 f4 1f 80 00       	add    $0x801ff4,%eax
  800557:	8a 00                	mov    (%eax),%al
  800559:	0f be c0             	movsbl %al,%eax
  80055c:	83 ec 08             	sub    $0x8,%esp
  80055f:	ff 75 0c             	pushl  0xc(%ebp)
  800562:	50                   	push   %eax
  800563:	8b 45 08             	mov    0x8(%ebp),%eax
  800566:	ff d0                	call   *%eax
  800568:	83 c4 10             	add    $0x10,%esp
}
  80056b:	90                   	nop
  80056c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80056f:	c9                   	leave  
  800570:	c3                   	ret    

00800571 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800571:	55                   	push   %ebp
  800572:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800574:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800578:	7e 1c                	jle    800596 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80057a:	8b 45 08             	mov    0x8(%ebp),%eax
  80057d:	8b 00                	mov    (%eax),%eax
  80057f:	8d 50 08             	lea    0x8(%eax),%edx
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	89 10                	mov    %edx,(%eax)
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	8b 00                	mov    (%eax),%eax
  80058c:	83 e8 08             	sub    $0x8,%eax
  80058f:	8b 50 04             	mov    0x4(%eax),%edx
  800592:	8b 00                	mov    (%eax),%eax
  800594:	eb 40                	jmp    8005d6 <getuint+0x65>
	else if (lflag)
  800596:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80059a:	74 1e                	je     8005ba <getuint+0x49>
		return va_arg(*ap, unsigned long);
  80059c:	8b 45 08             	mov    0x8(%ebp),%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	8d 50 04             	lea    0x4(%eax),%edx
  8005a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a7:	89 10                	mov    %edx,(%eax)
  8005a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ac:	8b 00                	mov    (%eax),%eax
  8005ae:	83 e8 04             	sub    $0x4,%eax
  8005b1:	8b 00                	mov    (%eax),%eax
  8005b3:	ba 00 00 00 00       	mov    $0x0,%edx
  8005b8:	eb 1c                	jmp    8005d6 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8005ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8005bd:	8b 00                	mov    (%eax),%eax
  8005bf:	8d 50 04             	lea    0x4(%eax),%edx
  8005c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c5:	89 10                	mov    %edx,(%eax)
  8005c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ca:	8b 00                	mov    (%eax),%eax
  8005cc:	83 e8 04             	sub    $0x4,%eax
  8005cf:	8b 00                	mov    (%eax),%eax
  8005d1:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8005d6:	5d                   	pop    %ebp
  8005d7:	c3                   	ret    

008005d8 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8005d8:	55                   	push   %ebp
  8005d9:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8005db:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8005df:	7e 1c                	jle    8005fd <getint+0x25>
		return va_arg(*ap, long long);
  8005e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e4:	8b 00                	mov    (%eax),%eax
  8005e6:	8d 50 08             	lea    0x8(%eax),%edx
  8005e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ec:	89 10                	mov    %edx,(%eax)
  8005ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f1:	8b 00                	mov    (%eax),%eax
  8005f3:	83 e8 08             	sub    $0x8,%eax
  8005f6:	8b 50 04             	mov    0x4(%eax),%edx
  8005f9:	8b 00                	mov    (%eax),%eax
  8005fb:	eb 38                	jmp    800635 <getint+0x5d>
	else if (lflag)
  8005fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800601:	74 1a                	je     80061d <getint+0x45>
		return va_arg(*ap, long);
  800603:	8b 45 08             	mov    0x8(%ebp),%eax
  800606:	8b 00                	mov    (%eax),%eax
  800608:	8d 50 04             	lea    0x4(%eax),%edx
  80060b:	8b 45 08             	mov    0x8(%ebp),%eax
  80060e:	89 10                	mov    %edx,(%eax)
  800610:	8b 45 08             	mov    0x8(%ebp),%eax
  800613:	8b 00                	mov    (%eax),%eax
  800615:	83 e8 04             	sub    $0x4,%eax
  800618:	8b 00                	mov    (%eax),%eax
  80061a:	99                   	cltd   
  80061b:	eb 18                	jmp    800635 <getint+0x5d>
	else
		return va_arg(*ap, int);
  80061d:	8b 45 08             	mov    0x8(%ebp),%eax
  800620:	8b 00                	mov    (%eax),%eax
  800622:	8d 50 04             	lea    0x4(%eax),%edx
  800625:	8b 45 08             	mov    0x8(%ebp),%eax
  800628:	89 10                	mov    %edx,(%eax)
  80062a:	8b 45 08             	mov    0x8(%ebp),%eax
  80062d:	8b 00                	mov    (%eax),%eax
  80062f:	83 e8 04             	sub    $0x4,%eax
  800632:	8b 00                	mov    (%eax),%eax
  800634:	99                   	cltd   
}
  800635:	5d                   	pop    %ebp
  800636:	c3                   	ret    

00800637 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800637:	55                   	push   %ebp
  800638:	89 e5                	mov    %esp,%ebp
  80063a:	56                   	push   %esi
  80063b:	53                   	push   %ebx
  80063c:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80063f:	eb 17                	jmp    800658 <vprintfmt+0x21>
			if (ch == '\0')
  800641:	85 db                	test   %ebx,%ebx
  800643:	0f 84 af 03 00 00    	je     8009f8 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800649:	83 ec 08             	sub    $0x8,%esp
  80064c:	ff 75 0c             	pushl  0xc(%ebp)
  80064f:	53                   	push   %ebx
  800650:	8b 45 08             	mov    0x8(%ebp),%eax
  800653:	ff d0                	call   *%eax
  800655:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800658:	8b 45 10             	mov    0x10(%ebp),%eax
  80065b:	8d 50 01             	lea    0x1(%eax),%edx
  80065e:	89 55 10             	mov    %edx,0x10(%ebp)
  800661:	8a 00                	mov    (%eax),%al
  800663:	0f b6 d8             	movzbl %al,%ebx
  800666:	83 fb 25             	cmp    $0x25,%ebx
  800669:	75 d6                	jne    800641 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  80066b:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80066f:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800676:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  80067d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800684:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  80068b:	8b 45 10             	mov    0x10(%ebp),%eax
  80068e:	8d 50 01             	lea    0x1(%eax),%edx
  800691:	89 55 10             	mov    %edx,0x10(%ebp)
  800694:	8a 00                	mov    (%eax),%al
  800696:	0f b6 d8             	movzbl %al,%ebx
  800699:	8d 43 dd             	lea    -0x23(%ebx),%eax
  80069c:	83 f8 55             	cmp    $0x55,%eax
  80069f:	0f 87 2b 03 00 00    	ja     8009d0 <vprintfmt+0x399>
  8006a5:	8b 04 85 18 20 80 00 	mov    0x802018(,%eax,4),%eax
  8006ac:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8006ae:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8006b2:	eb d7                	jmp    80068b <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8006b4:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8006b8:	eb d1                	jmp    80068b <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006ba:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8006c1:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8006c4:	89 d0                	mov    %edx,%eax
  8006c6:	c1 e0 02             	shl    $0x2,%eax
  8006c9:	01 d0                	add    %edx,%eax
  8006cb:	01 c0                	add    %eax,%eax
  8006cd:	01 d8                	add    %ebx,%eax
  8006cf:	83 e8 30             	sub    $0x30,%eax
  8006d2:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8006d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8006d8:	8a 00                	mov    (%eax),%al
  8006da:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8006dd:	83 fb 2f             	cmp    $0x2f,%ebx
  8006e0:	7e 3e                	jle    800720 <vprintfmt+0xe9>
  8006e2:	83 fb 39             	cmp    $0x39,%ebx
  8006e5:	7f 39                	jg     800720 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8006e7:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8006ea:	eb d5                	jmp    8006c1 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8006ec:	8b 45 14             	mov    0x14(%ebp),%eax
  8006ef:	83 c0 04             	add    $0x4,%eax
  8006f2:	89 45 14             	mov    %eax,0x14(%ebp)
  8006f5:	8b 45 14             	mov    0x14(%ebp),%eax
  8006f8:	83 e8 04             	sub    $0x4,%eax
  8006fb:	8b 00                	mov    (%eax),%eax
  8006fd:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800700:	eb 1f                	jmp    800721 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800702:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800706:	79 83                	jns    80068b <vprintfmt+0x54>
				width = 0;
  800708:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  80070f:	e9 77 ff ff ff       	jmp    80068b <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800714:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  80071b:	e9 6b ff ff ff       	jmp    80068b <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800720:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800721:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800725:	0f 89 60 ff ff ff    	jns    80068b <vprintfmt+0x54>
				width = precision, precision = -1;
  80072b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80072e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800731:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800738:	e9 4e ff ff ff       	jmp    80068b <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  80073d:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800740:	e9 46 ff ff ff       	jmp    80068b <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800745:	8b 45 14             	mov    0x14(%ebp),%eax
  800748:	83 c0 04             	add    $0x4,%eax
  80074b:	89 45 14             	mov    %eax,0x14(%ebp)
  80074e:	8b 45 14             	mov    0x14(%ebp),%eax
  800751:	83 e8 04             	sub    $0x4,%eax
  800754:	8b 00                	mov    (%eax),%eax
  800756:	83 ec 08             	sub    $0x8,%esp
  800759:	ff 75 0c             	pushl  0xc(%ebp)
  80075c:	50                   	push   %eax
  80075d:	8b 45 08             	mov    0x8(%ebp),%eax
  800760:	ff d0                	call   *%eax
  800762:	83 c4 10             	add    $0x10,%esp
			break;
  800765:	e9 89 02 00 00       	jmp    8009f3 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  80076a:	8b 45 14             	mov    0x14(%ebp),%eax
  80076d:	83 c0 04             	add    $0x4,%eax
  800770:	89 45 14             	mov    %eax,0x14(%ebp)
  800773:	8b 45 14             	mov    0x14(%ebp),%eax
  800776:	83 e8 04             	sub    $0x4,%eax
  800779:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  80077b:	85 db                	test   %ebx,%ebx
  80077d:	79 02                	jns    800781 <vprintfmt+0x14a>
				err = -err;
  80077f:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800781:	83 fb 64             	cmp    $0x64,%ebx
  800784:	7f 0b                	jg     800791 <vprintfmt+0x15a>
  800786:	8b 34 9d 60 1e 80 00 	mov    0x801e60(,%ebx,4),%esi
  80078d:	85 f6                	test   %esi,%esi
  80078f:	75 19                	jne    8007aa <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800791:	53                   	push   %ebx
  800792:	68 05 20 80 00       	push   $0x802005
  800797:	ff 75 0c             	pushl  0xc(%ebp)
  80079a:	ff 75 08             	pushl  0x8(%ebp)
  80079d:	e8 5e 02 00 00       	call   800a00 <printfmt>
  8007a2:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  8007a5:	e9 49 02 00 00       	jmp    8009f3 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  8007aa:	56                   	push   %esi
  8007ab:	68 0e 20 80 00       	push   $0x80200e
  8007b0:	ff 75 0c             	pushl  0xc(%ebp)
  8007b3:	ff 75 08             	pushl  0x8(%ebp)
  8007b6:	e8 45 02 00 00       	call   800a00 <printfmt>
  8007bb:	83 c4 10             	add    $0x10,%esp
			break;
  8007be:	e9 30 02 00 00       	jmp    8009f3 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  8007c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c6:	83 c0 04             	add    $0x4,%eax
  8007c9:	89 45 14             	mov    %eax,0x14(%ebp)
  8007cc:	8b 45 14             	mov    0x14(%ebp),%eax
  8007cf:	83 e8 04             	sub    $0x4,%eax
  8007d2:	8b 30                	mov    (%eax),%esi
  8007d4:	85 f6                	test   %esi,%esi
  8007d6:	75 05                	jne    8007dd <vprintfmt+0x1a6>
				p = "(null)";
  8007d8:	be 11 20 80 00       	mov    $0x802011,%esi
			if (width > 0 && padc != '-')
  8007dd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8007e1:	7e 6d                	jle    800850 <vprintfmt+0x219>
  8007e3:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8007e7:	74 67                	je     800850 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8007e9:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8007ec:	83 ec 08             	sub    $0x8,%esp
  8007ef:	50                   	push   %eax
  8007f0:	56                   	push   %esi
  8007f1:	e8 0c 03 00 00       	call   800b02 <strnlen>
  8007f6:	83 c4 10             	add    $0x10,%esp
  8007f9:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8007fc:	eb 16                	jmp    800814 <vprintfmt+0x1dd>
					putch(padc, putdat);
  8007fe:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800802:	83 ec 08             	sub    $0x8,%esp
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	50                   	push   %eax
  800809:	8b 45 08             	mov    0x8(%ebp),%eax
  80080c:	ff d0                	call   *%eax
  80080e:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800811:	ff 4d e4             	decl   -0x1c(%ebp)
  800814:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800818:	7f e4                	jg     8007fe <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80081a:	eb 34                	jmp    800850 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  80081c:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800820:	74 1c                	je     80083e <vprintfmt+0x207>
  800822:	83 fb 1f             	cmp    $0x1f,%ebx
  800825:	7e 05                	jle    80082c <vprintfmt+0x1f5>
  800827:	83 fb 7e             	cmp    $0x7e,%ebx
  80082a:	7e 12                	jle    80083e <vprintfmt+0x207>
					putch('?', putdat);
  80082c:	83 ec 08             	sub    $0x8,%esp
  80082f:	ff 75 0c             	pushl  0xc(%ebp)
  800832:	6a 3f                	push   $0x3f
  800834:	8b 45 08             	mov    0x8(%ebp),%eax
  800837:	ff d0                	call   *%eax
  800839:	83 c4 10             	add    $0x10,%esp
  80083c:	eb 0f                	jmp    80084d <vprintfmt+0x216>
				else
					putch(ch, putdat);
  80083e:	83 ec 08             	sub    $0x8,%esp
  800841:	ff 75 0c             	pushl  0xc(%ebp)
  800844:	53                   	push   %ebx
  800845:	8b 45 08             	mov    0x8(%ebp),%eax
  800848:	ff d0                	call   *%eax
  80084a:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  80084d:	ff 4d e4             	decl   -0x1c(%ebp)
  800850:	89 f0                	mov    %esi,%eax
  800852:	8d 70 01             	lea    0x1(%eax),%esi
  800855:	8a 00                	mov    (%eax),%al
  800857:	0f be d8             	movsbl %al,%ebx
  80085a:	85 db                	test   %ebx,%ebx
  80085c:	74 24                	je     800882 <vprintfmt+0x24b>
  80085e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800862:	78 b8                	js     80081c <vprintfmt+0x1e5>
  800864:	ff 4d e0             	decl   -0x20(%ebp)
  800867:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80086b:	79 af                	jns    80081c <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80086d:	eb 13                	jmp    800882 <vprintfmt+0x24b>
				putch(' ', putdat);
  80086f:	83 ec 08             	sub    $0x8,%esp
  800872:	ff 75 0c             	pushl  0xc(%ebp)
  800875:	6a 20                	push   $0x20
  800877:	8b 45 08             	mov    0x8(%ebp),%eax
  80087a:	ff d0                	call   *%eax
  80087c:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80087f:	ff 4d e4             	decl   -0x1c(%ebp)
  800882:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800886:	7f e7                	jg     80086f <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800888:	e9 66 01 00 00       	jmp    8009f3 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  80088d:	83 ec 08             	sub    $0x8,%esp
  800890:	ff 75 e8             	pushl  -0x18(%ebp)
  800893:	8d 45 14             	lea    0x14(%ebp),%eax
  800896:	50                   	push   %eax
  800897:	e8 3c fd ff ff       	call   8005d8 <getint>
  80089c:	83 c4 10             	add    $0x10,%esp
  80089f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008a2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  8008a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008a8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008ab:	85 d2                	test   %edx,%edx
  8008ad:	79 23                	jns    8008d2 <vprintfmt+0x29b>
				putch('-', putdat);
  8008af:	83 ec 08             	sub    $0x8,%esp
  8008b2:	ff 75 0c             	pushl  0xc(%ebp)
  8008b5:	6a 2d                	push   $0x2d
  8008b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ba:	ff d0                	call   *%eax
  8008bc:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  8008bf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008c2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8008c5:	f7 d8                	neg    %eax
  8008c7:	83 d2 00             	adc    $0x0,%edx
  8008ca:	f7 da                	neg    %edx
  8008cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  8008d2:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008d9:	e9 bc 00 00 00       	jmp    80099a <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8008de:	83 ec 08             	sub    $0x8,%esp
  8008e1:	ff 75 e8             	pushl  -0x18(%ebp)
  8008e4:	8d 45 14             	lea    0x14(%ebp),%eax
  8008e7:	50                   	push   %eax
  8008e8:	e8 84 fc ff ff       	call   800571 <getuint>
  8008ed:	83 c4 10             	add    $0x10,%esp
  8008f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8008f3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8008f6:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8008fd:	e9 98 00 00 00       	jmp    80099a <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800902:	83 ec 08             	sub    $0x8,%esp
  800905:	ff 75 0c             	pushl  0xc(%ebp)
  800908:	6a 58                	push   $0x58
  80090a:	8b 45 08             	mov    0x8(%ebp),%eax
  80090d:	ff d0                	call   *%eax
  80090f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800912:	83 ec 08             	sub    $0x8,%esp
  800915:	ff 75 0c             	pushl  0xc(%ebp)
  800918:	6a 58                	push   $0x58
  80091a:	8b 45 08             	mov    0x8(%ebp),%eax
  80091d:	ff d0                	call   *%eax
  80091f:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800922:	83 ec 08             	sub    $0x8,%esp
  800925:	ff 75 0c             	pushl  0xc(%ebp)
  800928:	6a 58                	push   $0x58
  80092a:	8b 45 08             	mov    0x8(%ebp),%eax
  80092d:	ff d0                	call   *%eax
  80092f:	83 c4 10             	add    $0x10,%esp
			break;
  800932:	e9 bc 00 00 00       	jmp    8009f3 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800937:	83 ec 08             	sub    $0x8,%esp
  80093a:	ff 75 0c             	pushl  0xc(%ebp)
  80093d:	6a 30                	push   $0x30
  80093f:	8b 45 08             	mov    0x8(%ebp),%eax
  800942:	ff d0                	call   *%eax
  800944:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800947:	83 ec 08             	sub    $0x8,%esp
  80094a:	ff 75 0c             	pushl  0xc(%ebp)
  80094d:	6a 78                	push   $0x78
  80094f:	8b 45 08             	mov    0x8(%ebp),%eax
  800952:	ff d0                	call   *%eax
  800954:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800957:	8b 45 14             	mov    0x14(%ebp),%eax
  80095a:	83 c0 04             	add    $0x4,%eax
  80095d:	89 45 14             	mov    %eax,0x14(%ebp)
  800960:	8b 45 14             	mov    0x14(%ebp),%eax
  800963:	83 e8 04             	sub    $0x4,%eax
  800966:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800968:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80096b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800972:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800979:	eb 1f                	jmp    80099a <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  80097b:	83 ec 08             	sub    $0x8,%esp
  80097e:	ff 75 e8             	pushl  -0x18(%ebp)
  800981:	8d 45 14             	lea    0x14(%ebp),%eax
  800984:	50                   	push   %eax
  800985:	e8 e7 fb ff ff       	call   800571 <getuint>
  80098a:	83 c4 10             	add    $0x10,%esp
  80098d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800990:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800993:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  80099a:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80099e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8009a1:	83 ec 04             	sub    $0x4,%esp
  8009a4:	52                   	push   %edx
  8009a5:	ff 75 e4             	pushl  -0x1c(%ebp)
  8009a8:	50                   	push   %eax
  8009a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ac:	ff 75 f0             	pushl  -0x10(%ebp)
  8009af:	ff 75 0c             	pushl  0xc(%ebp)
  8009b2:	ff 75 08             	pushl  0x8(%ebp)
  8009b5:	e8 00 fb ff ff       	call   8004ba <printnum>
  8009ba:	83 c4 20             	add    $0x20,%esp
			break;
  8009bd:	eb 34                	jmp    8009f3 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8009bf:	83 ec 08             	sub    $0x8,%esp
  8009c2:	ff 75 0c             	pushl  0xc(%ebp)
  8009c5:	53                   	push   %ebx
  8009c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c9:	ff d0                	call   *%eax
  8009cb:	83 c4 10             	add    $0x10,%esp
			break;
  8009ce:	eb 23                	jmp    8009f3 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8009d0:	83 ec 08             	sub    $0x8,%esp
  8009d3:	ff 75 0c             	pushl  0xc(%ebp)
  8009d6:	6a 25                	push   $0x25
  8009d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009db:	ff d0                	call   *%eax
  8009dd:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8009e0:	ff 4d 10             	decl   0x10(%ebp)
  8009e3:	eb 03                	jmp    8009e8 <vprintfmt+0x3b1>
  8009e5:	ff 4d 10             	decl   0x10(%ebp)
  8009e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8009eb:	48                   	dec    %eax
  8009ec:	8a 00                	mov    (%eax),%al
  8009ee:	3c 25                	cmp    $0x25,%al
  8009f0:	75 f3                	jne    8009e5 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8009f2:	90                   	nop
		}
	}
  8009f3:	e9 47 fc ff ff       	jmp    80063f <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8009f8:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8009f9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8009fc:	5b                   	pop    %ebx
  8009fd:	5e                   	pop    %esi
  8009fe:	5d                   	pop    %ebp
  8009ff:	c3                   	ret    

00800a00 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800a00:	55                   	push   %ebp
  800a01:	89 e5                	mov    %esp,%ebp
  800a03:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800a06:	8d 45 10             	lea    0x10(%ebp),%eax
  800a09:	83 c0 04             	add    $0x4,%eax
  800a0c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800a0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800a12:	ff 75 f4             	pushl  -0xc(%ebp)
  800a15:	50                   	push   %eax
  800a16:	ff 75 0c             	pushl  0xc(%ebp)
  800a19:	ff 75 08             	pushl  0x8(%ebp)
  800a1c:	e8 16 fc ff ff       	call   800637 <vprintfmt>
  800a21:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800a24:	90                   	nop
  800a25:	c9                   	leave  
  800a26:	c3                   	ret    

00800a27 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800a27:	55                   	push   %ebp
  800a28:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800a2a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2d:	8b 40 08             	mov    0x8(%eax),%eax
  800a30:	8d 50 01             	lea    0x1(%eax),%edx
  800a33:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a36:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800a39:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a3c:	8b 10                	mov    (%eax),%edx
  800a3e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a41:	8b 40 04             	mov    0x4(%eax),%eax
  800a44:	39 c2                	cmp    %eax,%edx
  800a46:	73 12                	jae    800a5a <sprintputch+0x33>
		*b->buf++ = ch;
  800a48:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4b:	8b 00                	mov    (%eax),%eax
  800a4d:	8d 48 01             	lea    0x1(%eax),%ecx
  800a50:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a53:	89 0a                	mov    %ecx,(%edx)
  800a55:	8b 55 08             	mov    0x8(%ebp),%edx
  800a58:	88 10                	mov    %dl,(%eax)
}
  800a5a:	90                   	nop
  800a5b:	5d                   	pop    %ebp
  800a5c:	c3                   	ret    

00800a5d <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800a5d:	55                   	push   %ebp
  800a5e:	89 e5                	mov    %esp,%ebp
  800a60:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800a69:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a6c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a72:	01 d0                	add    %edx,%eax
  800a74:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a77:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800a7e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800a82:	74 06                	je     800a8a <vsnprintf+0x2d>
  800a84:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800a88:	7f 07                	jg     800a91 <vsnprintf+0x34>
		return -E_INVAL;
  800a8a:	b8 03 00 00 00       	mov    $0x3,%eax
  800a8f:	eb 20                	jmp    800ab1 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800a91:	ff 75 14             	pushl  0x14(%ebp)
  800a94:	ff 75 10             	pushl  0x10(%ebp)
  800a97:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800a9a:	50                   	push   %eax
  800a9b:	68 27 0a 80 00       	push   $0x800a27
  800aa0:	e8 92 fb ff ff       	call   800637 <vprintfmt>
  800aa5:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800aa8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800aab:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800aae:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800ab1:	c9                   	leave  
  800ab2:	c3                   	ret    

00800ab3 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800ab3:	55                   	push   %ebp
  800ab4:	89 e5                	mov    %esp,%ebp
  800ab6:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800ab9:	8d 45 10             	lea    0x10(%ebp),%eax
  800abc:	83 c0 04             	add    $0x4,%eax
  800abf:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800ac2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ac5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ac8:	50                   	push   %eax
  800ac9:	ff 75 0c             	pushl  0xc(%ebp)
  800acc:	ff 75 08             	pushl  0x8(%ebp)
  800acf:	e8 89 ff ff ff       	call   800a5d <vsnprintf>
  800ad4:	83 c4 10             	add    $0x10,%esp
  800ad7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800ada:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800add:	c9                   	leave  
  800ade:	c3                   	ret    

00800adf <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800adf:	55                   	push   %ebp
  800ae0:	89 e5                	mov    %esp,%ebp
  800ae2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ae5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800aec:	eb 06                	jmp    800af4 <strlen+0x15>
		n++;
  800aee:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800af1:	ff 45 08             	incl   0x8(%ebp)
  800af4:	8b 45 08             	mov    0x8(%ebp),%eax
  800af7:	8a 00                	mov    (%eax),%al
  800af9:	84 c0                	test   %al,%al
  800afb:	75 f1                	jne    800aee <strlen+0xf>
		n++;
	return n;
  800afd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b00:	c9                   	leave  
  800b01:	c3                   	ret    

00800b02 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800b02:	55                   	push   %ebp
  800b03:	89 e5                	mov    %esp,%ebp
  800b05:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b08:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b0f:	eb 09                	jmp    800b1a <strnlen+0x18>
		n++;
  800b11:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800b14:	ff 45 08             	incl   0x8(%ebp)
  800b17:	ff 4d 0c             	decl   0xc(%ebp)
  800b1a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b1e:	74 09                	je     800b29 <strnlen+0x27>
  800b20:	8b 45 08             	mov    0x8(%ebp),%eax
  800b23:	8a 00                	mov    (%eax),%al
  800b25:	84 c0                	test   %al,%al
  800b27:	75 e8                	jne    800b11 <strnlen+0xf>
		n++;
	return n;
  800b29:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b2c:	c9                   	leave  
  800b2d:	c3                   	ret    

00800b2e <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800b2e:	55                   	push   %ebp
  800b2f:	89 e5                	mov    %esp,%ebp
  800b31:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800b34:	8b 45 08             	mov    0x8(%ebp),%eax
  800b37:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800b3a:	90                   	nop
  800b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3e:	8d 50 01             	lea    0x1(%eax),%edx
  800b41:	89 55 08             	mov    %edx,0x8(%ebp)
  800b44:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b47:	8d 4a 01             	lea    0x1(%edx),%ecx
  800b4a:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800b4d:	8a 12                	mov    (%edx),%dl
  800b4f:	88 10                	mov    %dl,(%eax)
  800b51:	8a 00                	mov    (%eax),%al
  800b53:	84 c0                	test   %al,%al
  800b55:	75 e4                	jne    800b3b <strcpy+0xd>
		/* do nothing */;
	return ret;
  800b57:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800b5a:	c9                   	leave  
  800b5b:	c3                   	ret    

00800b5c <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800b5c:	55                   	push   %ebp
  800b5d:	89 e5                	mov    %esp,%ebp
  800b5f:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800b68:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800b6f:	eb 1f                	jmp    800b90 <strncpy+0x34>
		*dst++ = *src;
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	8d 50 01             	lea    0x1(%eax),%edx
  800b77:	89 55 08             	mov    %edx,0x8(%ebp)
  800b7a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b7d:	8a 12                	mov    (%edx),%dl
  800b7f:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800b81:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b84:	8a 00                	mov    (%eax),%al
  800b86:	84 c0                	test   %al,%al
  800b88:	74 03                	je     800b8d <strncpy+0x31>
			src++;
  800b8a:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800b8d:	ff 45 fc             	incl   -0x4(%ebp)
  800b90:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800b93:	3b 45 10             	cmp    0x10(%ebp),%eax
  800b96:	72 d9                	jb     800b71 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800b98:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800b9b:	c9                   	leave  
  800b9c:	c3                   	ret    

00800b9d <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800b9d:	55                   	push   %ebp
  800b9e:	89 e5                	mov    %esp,%ebp
  800ba0:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800ba3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ba9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bad:	74 30                	je     800bdf <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800baf:	eb 16                	jmp    800bc7 <strlcpy+0x2a>
			*dst++ = *src++;
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	8d 50 01             	lea    0x1(%eax),%edx
  800bb7:	89 55 08             	mov    %edx,0x8(%ebp)
  800bba:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bbd:	8d 4a 01             	lea    0x1(%edx),%ecx
  800bc0:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800bc3:	8a 12                	mov    (%edx),%dl
  800bc5:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800bc7:	ff 4d 10             	decl   0x10(%ebp)
  800bca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800bce:	74 09                	je     800bd9 <strlcpy+0x3c>
  800bd0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd3:	8a 00                	mov    (%eax),%al
  800bd5:	84 c0                	test   %al,%al
  800bd7:	75 d8                	jne    800bb1 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800bd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdc:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800bdf:	8b 55 08             	mov    0x8(%ebp),%edx
  800be2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800be5:	29 c2                	sub    %eax,%edx
  800be7:	89 d0                	mov    %edx,%eax
}
  800be9:	c9                   	leave  
  800bea:	c3                   	ret    

00800beb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800beb:	55                   	push   %ebp
  800bec:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800bee:	eb 06                	jmp    800bf6 <strcmp+0xb>
		p++, q++;
  800bf0:	ff 45 08             	incl   0x8(%ebp)
  800bf3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800bf6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf9:	8a 00                	mov    (%eax),%al
  800bfb:	84 c0                	test   %al,%al
  800bfd:	74 0e                	je     800c0d <strcmp+0x22>
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	8a 10                	mov    (%eax),%dl
  800c04:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c07:	8a 00                	mov    (%eax),%al
  800c09:	38 c2                	cmp    %al,%dl
  800c0b:	74 e3                	je     800bf0 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800c0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c10:	8a 00                	mov    (%eax),%al
  800c12:	0f b6 d0             	movzbl %al,%edx
  800c15:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c18:	8a 00                	mov    (%eax),%al
  800c1a:	0f b6 c0             	movzbl %al,%eax
  800c1d:	29 c2                	sub    %eax,%edx
  800c1f:	89 d0                	mov    %edx,%eax
}
  800c21:	5d                   	pop    %ebp
  800c22:	c3                   	ret    

00800c23 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800c23:	55                   	push   %ebp
  800c24:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800c26:	eb 09                	jmp    800c31 <strncmp+0xe>
		n--, p++, q++;
  800c28:	ff 4d 10             	decl   0x10(%ebp)
  800c2b:	ff 45 08             	incl   0x8(%ebp)
  800c2e:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800c31:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c35:	74 17                	je     800c4e <strncmp+0x2b>
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	8a 00                	mov    (%eax),%al
  800c3c:	84 c0                	test   %al,%al
  800c3e:	74 0e                	je     800c4e <strncmp+0x2b>
  800c40:	8b 45 08             	mov    0x8(%ebp),%eax
  800c43:	8a 10                	mov    (%eax),%dl
  800c45:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c48:	8a 00                	mov    (%eax),%al
  800c4a:	38 c2                	cmp    %al,%dl
  800c4c:	74 da                	je     800c28 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800c4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800c52:	75 07                	jne    800c5b <strncmp+0x38>
		return 0;
  800c54:	b8 00 00 00 00       	mov    $0x0,%eax
  800c59:	eb 14                	jmp    800c6f <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800c5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5e:	8a 00                	mov    (%eax),%al
  800c60:	0f b6 d0             	movzbl %al,%edx
  800c63:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c66:	8a 00                	mov    (%eax),%al
  800c68:	0f b6 c0             	movzbl %al,%eax
  800c6b:	29 c2                	sub    %eax,%edx
  800c6d:	89 d0                	mov    %edx,%eax
}
  800c6f:	5d                   	pop    %ebp
  800c70:	c3                   	ret    

00800c71 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800c71:	55                   	push   %ebp
  800c72:	89 e5                	mov    %esp,%ebp
  800c74:	83 ec 04             	sub    $0x4,%esp
  800c77:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c7a:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800c7d:	eb 12                	jmp    800c91 <strchr+0x20>
		if (*s == c)
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	8a 00                	mov    (%eax),%al
  800c84:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800c87:	75 05                	jne    800c8e <strchr+0x1d>
			return (char *) s;
  800c89:	8b 45 08             	mov    0x8(%ebp),%eax
  800c8c:	eb 11                	jmp    800c9f <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800c8e:	ff 45 08             	incl   0x8(%ebp)
  800c91:	8b 45 08             	mov    0x8(%ebp),%eax
  800c94:	8a 00                	mov    (%eax),%al
  800c96:	84 c0                	test   %al,%al
  800c98:	75 e5                	jne    800c7f <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800c9a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800c9f:	c9                   	leave  
  800ca0:	c3                   	ret    

00800ca1 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800ca1:	55                   	push   %ebp
  800ca2:	89 e5                	mov    %esp,%ebp
  800ca4:	83 ec 04             	sub    $0x4,%esp
  800ca7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800caa:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800cad:	eb 0d                	jmp    800cbc <strfind+0x1b>
		if (*s == c)
  800caf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb2:	8a 00                	mov    (%eax),%al
  800cb4:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800cb7:	74 0e                	je     800cc7 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800cb9:	ff 45 08             	incl   0x8(%ebp)
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	84 c0                	test   %al,%al
  800cc3:	75 ea                	jne    800caf <strfind+0xe>
  800cc5:	eb 01                	jmp    800cc8 <strfind+0x27>
		if (*s == c)
			break;
  800cc7:	90                   	nop
	return (char *) s;
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ccb:	c9                   	leave  
  800ccc:	c3                   	ret    

00800ccd <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800ccd:	55                   	push   %ebp
  800cce:	89 e5                	mov    %esp,%ebp
  800cd0:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800cd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800cd9:	8b 45 10             	mov    0x10(%ebp),%eax
  800cdc:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800cdf:	eb 0e                	jmp    800cef <memset+0x22>
		*p++ = c;
  800ce1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ce4:	8d 50 01             	lea    0x1(%eax),%edx
  800ce7:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800cea:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ced:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800cef:	ff 4d f8             	decl   -0x8(%ebp)
  800cf2:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800cf6:	79 e9                	jns    800ce1 <memset+0x14>
		*p++ = c;

	return v;
  800cf8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800cfb:	c9                   	leave  
  800cfc:	c3                   	ret    

00800cfd <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800cfd:	55                   	push   %ebp
  800cfe:	89 e5                	mov    %esp,%ebp
  800d00:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d03:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d06:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d09:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0c:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800d0f:	eb 16                	jmp    800d27 <memcpy+0x2a>
		*d++ = *s++;
  800d11:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d14:	8d 50 01             	lea    0x1(%eax),%edx
  800d17:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d1a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d1d:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d20:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d23:	8a 12                	mov    (%edx),%dl
  800d25:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800d27:	8b 45 10             	mov    0x10(%ebp),%eax
  800d2a:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d2d:	89 55 10             	mov    %edx,0x10(%ebp)
  800d30:	85 c0                	test   %eax,%eax
  800d32:	75 dd                	jne    800d11 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800d34:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d37:	c9                   	leave  
  800d38:	c3                   	ret    

00800d39 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800d39:	55                   	push   %ebp
  800d3a:	89 e5                	mov    %esp,%ebp
  800d3c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800d3f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800d4b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d4e:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d51:	73 50                	jae    800da3 <memmove+0x6a>
  800d53:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d56:	8b 45 10             	mov    0x10(%ebp),%eax
  800d59:	01 d0                	add    %edx,%eax
  800d5b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800d5e:	76 43                	jbe    800da3 <memmove+0x6a>
		s += n;
  800d60:	8b 45 10             	mov    0x10(%ebp),%eax
  800d63:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800d66:	8b 45 10             	mov    0x10(%ebp),%eax
  800d69:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800d6c:	eb 10                	jmp    800d7e <memmove+0x45>
			*--d = *--s;
  800d6e:	ff 4d f8             	decl   -0x8(%ebp)
  800d71:	ff 4d fc             	decl   -0x4(%ebp)
  800d74:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d77:	8a 10                	mov    (%eax),%dl
  800d79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d7c:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800d7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800d81:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d84:	89 55 10             	mov    %edx,0x10(%ebp)
  800d87:	85 c0                	test   %eax,%eax
  800d89:	75 e3                	jne    800d6e <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800d8b:	eb 23                	jmp    800db0 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800d8d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800d90:	8d 50 01             	lea    0x1(%eax),%edx
  800d93:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800d96:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800d99:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d9c:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800d9f:	8a 12                	mov    (%edx),%dl
  800da1:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800da3:	8b 45 10             	mov    0x10(%ebp),%eax
  800da6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800da9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dac:	85 c0                	test   %eax,%eax
  800dae:	75 dd                	jne    800d8d <memmove+0x54>
			*d++ = *s++;

	return dst;
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800db3:	c9                   	leave  
  800db4:	c3                   	ret    

00800db5 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800db5:	55                   	push   %ebp
  800db6:	89 e5                	mov    %esp,%ebp
  800db8:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800dbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800dc1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800dc4:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800dc7:	eb 2a                	jmp    800df3 <memcmp+0x3e>
		if (*s1 != *s2)
  800dc9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dcc:	8a 10                	mov    (%eax),%dl
  800dce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800dd1:	8a 00                	mov    (%eax),%al
  800dd3:	38 c2                	cmp    %al,%dl
  800dd5:	74 16                	je     800ded <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800dd7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800dda:	8a 00                	mov    (%eax),%al
  800ddc:	0f b6 d0             	movzbl %al,%edx
  800ddf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800de2:	8a 00                	mov    (%eax),%al
  800de4:	0f b6 c0             	movzbl %al,%eax
  800de7:	29 c2                	sub    %eax,%edx
  800de9:	89 d0                	mov    %edx,%eax
  800deb:	eb 18                	jmp    800e05 <memcmp+0x50>
		s1++, s2++;
  800ded:	ff 45 fc             	incl   -0x4(%ebp)
  800df0:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800df3:	8b 45 10             	mov    0x10(%ebp),%eax
  800df6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800df9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfc:	85 c0                	test   %eax,%eax
  800dfe:	75 c9                	jne    800dc9 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800e00:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e05:	c9                   	leave  
  800e06:	c3                   	ret    

00800e07 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800e07:	55                   	push   %ebp
  800e08:	89 e5                	mov    %esp,%ebp
  800e0a:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800e0d:	8b 55 08             	mov    0x8(%ebp),%edx
  800e10:	8b 45 10             	mov    0x10(%ebp),%eax
  800e13:	01 d0                	add    %edx,%eax
  800e15:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800e18:	eb 15                	jmp    800e2f <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800e1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1d:	8a 00                	mov    (%eax),%al
  800e1f:	0f b6 d0             	movzbl %al,%edx
  800e22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e25:	0f b6 c0             	movzbl %al,%eax
  800e28:	39 c2                	cmp    %eax,%edx
  800e2a:	74 0d                	je     800e39 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800e2c:	ff 45 08             	incl   0x8(%ebp)
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800e35:	72 e3                	jb     800e1a <memfind+0x13>
  800e37:	eb 01                	jmp    800e3a <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800e39:	90                   	nop
	return (void *) s;
  800e3a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e3d:	c9                   	leave  
  800e3e:	c3                   	ret    

00800e3f <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800e3f:	55                   	push   %ebp
  800e40:	89 e5                	mov    %esp,%ebp
  800e42:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800e45:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800e4c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e53:	eb 03                	jmp    800e58 <strtol+0x19>
		s++;
  800e55:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800e58:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5b:	8a 00                	mov    (%eax),%al
  800e5d:	3c 20                	cmp    $0x20,%al
  800e5f:	74 f4                	je     800e55 <strtol+0x16>
  800e61:	8b 45 08             	mov    0x8(%ebp),%eax
  800e64:	8a 00                	mov    (%eax),%al
  800e66:	3c 09                	cmp    $0x9,%al
  800e68:	74 eb                	je     800e55 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800e6a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6d:	8a 00                	mov    (%eax),%al
  800e6f:	3c 2b                	cmp    $0x2b,%al
  800e71:	75 05                	jne    800e78 <strtol+0x39>
		s++;
  800e73:	ff 45 08             	incl   0x8(%ebp)
  800e76:	eb 13                	jmp    800e8b <strtol+0x4c>
	else if (*s == '-')
  800e78:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7b:	8a 00                	mov    (%eax),%al
  800e7d:	3c 2d                	cmp    $0x2d,%al
  800e7f:	75 0a                	jne    800e8b <strtol+0x4c>
		s++, neg = 1;
  800e81:	ff 45 08             	incl   0x8(%ebp)
  800e84:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800e8b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e8f:	74 06                	je     800e97 <strtol+0x58>
  800e91:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800e95:	75 20                	jne    800eb7 <strtol+0x78>
  800e97:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9a:	8a 00                	mov    (%eax),%al
  800e9c:	3c 30                	cmp    $0x30,%al
  800e9e:	75 17                	jne    800eb7 <strtol+0x78>
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	40                   	inc    %eax
  800ea4:	8a 00                	mov    (%eax),%al
  800ea6:	3c 78                	cmp    $0x78,%al
  800ea8:	75 0d                	jne    800eb7 <strtol+0x78>
		s += 2, base = 16;
  800eaa:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800eae:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800eb5:	eb 28                	jmp    800edf <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800eb7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ebb:	75 15                	jne    800ed2 <strtol+0x93>
  800ebd:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec0:	8a 00                	mov    (%eax),%al
  800ec2:	3c 30                	cmp    $0x30,%al
  800ec4:	75 0c                	jne    800ed2 <strtol+0x93>
		s++, base = 8;
  800ec6:	ff 45 08             	incl   0x8(%ebp)
  800ec9:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800ed0:	eb 0d                	jmp    800edf <strtol+0xa0>
	else if (base == 0)
  800ed2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ed6:	75 07                	jne    800edf <strtol+0xa0>
		base = 10;
  800ed8:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800edf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee2:	8a 00                	mov    (%eax),%al
  800ee4:	3c 2f                	cmp    $0x2f,%al
  800ee6:	7e 19                	jle    800f01 <strtol+0xc2>
  800ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  800eeb:	8a 00                	mov    (%eax),%al
  800eed:	3c 39                	cmp    $0x39,%al
  800eef:	7f 10                	jg     800f01 <strtol+0xc2>
			dig = *s - '0';
  800ef1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef4:	8a 00                	mov    (%eax),%al
  800ef6:	0f be c0             	movsbl %al,%eax
  800ef9:	83 e8 30             	sub    $0x30,%eax
  800efc:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800eff:	eb 42                	jmp    800f43 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800f01:	8b 45 08             	mov    0x8(%ebp),%eax
  800f04:	8a 00                	mov    (%eax),%al
  800f06:	3c 60                	cmp    $0x60,%al
  800f08:	7e 19                	jle    800f23 <strtol+0xe4>
  800f0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0d:	8a 00                	mov    (%eax),%al
  800f0f:	3c 7a                	cmp    $0x7a,%al
  800f11:	7f 10                	jg     800f23 <strtol+0xe4>
			dig = *s - 'a' + 10;
  800f13:	8b 45 08             	mov    0x8(%ebp),%eax
  800f16:	8a 00                	mov    (%eax),%al
  800f18:	0f be c0             	movsbl %al,%eax
  800f1b:	83 e8 57             	sub    $0x57,%eax
  800f1e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800f21:	eb 20                	jmp    800f43 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	8a 00                	mov    (%eax),%al
  800f28:	3c 40                	cmp    $0x40,%al
  800f2a:	7e 39                	jle    800f65 <strtol+0x126>
  800f2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2f:	8a 00                	mov    (%eax),%al
  800f31:	3c 5a                	cmp    $0x5a,%al
  800f33:	7f 30                	jg     800f65 <strtol+0x126>
			dig = *s - 'A' + 10;
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	8a 00                	mov    (%eax),%al
  800f3a:	0f be c0             	movsbl %al,%eax
  800f3d:	83 e8 37             	sub    $0x37,%eax
  800f40:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800f43:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f46:	3b 45 10             	cmp    0x10(%ebp),%eax
  800f49:	7d 19                	jge    800f64 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800f4b:	ff 45 08             	incl   0x8(%ebp)
  800f4e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f51:	0f af 45 10          	imul   0x10(%ebp),%eax
  800f55:	89 c2                	mov    %eax,%edx
  800f57:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f5a:	01 d0                	add    %edx,%eax
  800f5c:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800f5f:	e9 7b ff ff ff       	jmp    800edf <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800f64:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800f65:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800f69:	74 08                	je     800f73 <strtol+0x134>
		*endptr = (char *) s;
  800f6b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f6e:	8b 55 08             	mov    0x8(%ebp),%edx
  800f71:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800f73:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800f77:	74 07                	je     800f80 <strtol+0x141>
  800f79:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7c:	f7 d8                	neg    %eax
  800f7e:	eb 03                	jmp    800f83 <strtol+0x144>
  800f80:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800f83:	c9                   	leave  
  800f84:	c3                   	ret    

00800f85 <ltostr>:

void
ltostr(long value, char *str)
{
  800f85:	55                   	push   %ebp
  800f86:	89 e5                	mov    %esp,%ebp
  800f88:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800f8b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800f92:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800f99:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800f9d:	79 13                	jns    800fb2 <ltostr+0x2d>
	{
		neg = 1;
  800f9f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800fa6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa9:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800fac:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800faf:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800fb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb5:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800fba:	99                   	cltd   
  800fbb:	f7 f9                	idiv   %ecx
  800fbd:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800fc0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fc3:	8d 50 01             	lea    0x1(%eax),%edx
  800fc6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fc9:	89 c2                	mov    %eax,%edx
  800fcb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fce:	01 d0                	add    %edx,%eax
  800fd0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800fd3:	83 c2 30             	add    $0x30,%edx
  800fd6:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800fd8:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800fdb:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800fe0:	f7 e9                	imul   %ecx
  800fe2:	c1 fa 02             	sar    $0x2,%edx
  800fe5:	89 c8                	mov    %ecx,%eax
  800fe7:	c1 f8 1f             	sar    $0x1f,%eax
  800fea:	29 c2                	sub    %eax,%edx
  800fec:	89 d0                	mov    %edx,%eax
  800fee:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ff1:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ff4:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ff9:	f7 e9                	imul   %ecx
  800ffb:	c1 fa 02             	sar    $0x2,%edx
  800ffe:	89 c8                	mov    %ecx,%eax
  801000:	c1 f8 1f             	sar    $0x1f,%eax
  801003:	29 c2                	sub    %eax,%edx
  801005:	89 d0                	mov    %edx,%eax
  801007:	c1 e0 02             	shl    $0x2,%eax
  80100a:	01 d0                	add    %edx,%eax
  80100c:	01 c0                	add    %eax,%eax
  80100e:	29 c1                	sub    %eax,%ecx
  801010:	89 ca                	mov    %ecx,%edx
  801012:	85 d2                	test   %edx,%edx
  801014:	75 9c                	jne    800fb2 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801016:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80101d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801020:	48                   	dec    %eax
  801021:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801024:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801028:	74 3d                	je     801067 <ltostr+0xe2>
		start = 1 ;
  80102a:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801031:	eb 34                	jmp    801067 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801033:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801036:	8b 45 0c             	mov    0xc(%ebp),%eax
  801039:	01 d0                	add    %edx,%eax
  80103b:	8a 00                	mov    (%eax),%al
  80103d:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801040:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	01 c2                	add    %eax,%edx
  801048:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80104b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80104e:	01 c8                	add    %ecx,%eax
  801050:	8a 00                	mov    (%eax),%al
  801052:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801054:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801057:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105a:	01 c2                	add    %eax,%edx
  80105c:	8a 45 eb             	mov    -0x15(%ebp),%al
  80105f:	88 02                	mov    %al,(%edx)
		start++ ;
  801061:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801064:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801067:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80106a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80106d:	7c c4                	jl     801033 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80106f:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801072:	8b 45 0c             	mov    0xc(%ebp),%eax
  801075:	01 d0                	add    %edx,%eax
  801077:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80107a:	90                   	nop
  80107b:	c9                   	leave  
  80107c:	c3                   	ret    

0080107d <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80107d:	55                   	push   %ebp
  80107e:	89 e5                	mov    %esp,%ebp
  801080:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801083:	ff 75 08             	pushl  0x8(%ebp)
  801086:	e8 54 fa ff ff       	call   800adf <strlen>
  80108b:	83 c4 04             	add    $0x4,%esp
  80108e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801091:	ff 75 0c             	pushl  0xc(%ebp)
  801094:	e8 46 fa ff ff       	call   800adf <strlen>
  801099:	83 c4 04             	add    $0x4,%esp
  80109c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80109f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8010a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010ad:	eb 17                	jmp    8010c6 <strcconcat+0x49>
		final[s] = str1[s] ;
  8010af:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8010b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b5:	01 c2                	add    %eax,%edx
  8010b7:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8010ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8010bd:	01 c8                	add    %ecx,%eax
  8010bf:	8a 00                	mov    (%eax),%al
  8010c1:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8010c3:	ff 45 fc             	incl   -0x4(%ebp)
  8010c6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8010cc:	7c e1                	jl     8010af <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8010ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8010d5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8010dc:	eb 1f                	jmp    8010fd <strcconcat+0x80>
		final[s++] = str2[i] ;
  8010de:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e1:	8d 50 01             	lea    0x1(%eax),%edx
  8010e4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8010e7:	89 c2                	mov    %eax,%edx
  8010e9:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ec:	01 c2                	add    %eax,%edx
  8010ee:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8010f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010f4:	01 c8                	add    %ecx,%eax
  8010f6:	8a 00                	mov    (%eax),%al
  8010f8:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8010fa:	ff 45 f8             	incl   -0x8(%ebp)
  8010fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801100:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801103:	7c d9                	jl     8010de <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801105:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801108:	8b 45 10             	mov    0x10(%ebp),%eax
  80110b:	01 d0                	add    %edx,%eax
  80110d:	c6 00 00             	movb   $0x0,(%eax)
}
  801110:	90                   	nop
  801111:	c9                   	leave  
  801112:	c3                   	ret    

00801113 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801113:	55                   	push   %ebp
  801114:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801116:	8b 45 14             	mov    0x14(%ebp),%eax
  801119:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  80111f:	8b 45 14             	mov    0x14(%ebp),%eax
  801122:	8b 00                	mov    (%eax),%eax
  801124:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80112b:	8b 45 10             	mov    0x10(%ebp),%eax
  80112e:	01 d0                	add    %edx,%eax
  801130:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801136:	eb 0c                	jmp    801144 <strsplit+0x31>
			*string++ = 0;
  801138:	8b 45 08             	mov    0x8(%ebp),%eax
  80113b:	8d 50 01             	lea    0x1(%eax),%edx
  80113e:	89 55 08             	mov    %edx,0x8(%ebp)
  801141:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801144:	8b 45 08             	mov    0x8(%ebp),%eax
  801147:	8a 00                	mov    (%eax),%al
  801149:	84 c0                	test   %al,%al
  80114b:	74 18                	je     801165 <strsplit+0x52>
  80114d:	8b 45 08             	mov    0x8(%ebp),%eax
  801150:	8a 00                	mov    (%eax),%al
  801152:	0f be c0             	movsbl %al,%eax
  801155:	50                   	push   %eax
  801156:	ff 75 0c             	pushl  0xc(%ebp)
  801159:	e8 13 fb ff ff       	call   800c71 <strchr>
  80115e:	83 c4 08             	add    $0x8,%esp
  801161:	85 c0                	test   %eax,%eax
  801163:	75 d3                	jne    801138 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801165:	8b 45 08             	mov    0x8(%ebp),%eax
  801168:	8a 00                	mov    (%eax),%al
  80116a:	84 c0                	test   %al,%al
  80116c:	74 5a                	je     8011c8 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80116e:	8b 45 14             	mov    0x14(%ebp),%eax
  801171:	8b 00                	mov    (%eax),%eax
  801173:	83 f8 0f             	cmp    $0xf,%eax
  801176:	75 07                	jne    80117f <strsplit+0x6c>
		{
			return 0;
  801178:	b8 00 00 00 00       	mov    $0x0,%eax
  80117d:	eb 66                	jmp    8011e5 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80117f:	8b 45 14             	mov    0x14(%ebp),%eax
  801182:	8b 00                	mov    (%eax),%eax
  801184:	8d 48 01             	lea    0x1(%eax),%ecx
  801187:	8b 55 14             	mov    0x14(%ebp),%edx
  80118a:	89 0a                	mov    %ecx,(%edx)
  80118c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801193:	8b 45 10             	mov    0x10(%ebp),%eax
  801196:	01 c2                	add    %eax,%edx
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80119d:	eb 03                	jmp    8011a2 <strsplit+0x8f>
			string++;
  80119f:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8011a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a5:	8a 00                	mov    (%eax),%al
  8011a7:	84 c0                	test   %al,%al
  8011a9:	74 8b                	je     801136 <strsplit+0x23>
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8a 00                	mov    (%eax),%al
  8011b0:	0f be c0             	movsbl %al,%eax
  8011b3:	50                   	push   %eax
  8011b4:	ff 75 0c             	pushl  0xc(%ebp)
  8011b7:	e8 b5 fa ff ff       	call   800c71 <strchr>
  8011bc:	83 c4 08             	add    $0x8,%esp
  8011bf:	85 c0                	test   %eax,%eax
  8011c1:	74 dc                	je     80119f <strsplit+0x8c>
			string++;
	}
  8011c3:	e9 6e ff ff ff       	jmp    801136 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8011c8:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8011c9:	8b 45 14             	mov    0x14(%ebp),%eax
  8011cc:	8b 00                	mov    (%eax),%eax
  8011ce:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8011d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d8:	01 d0                	add    %edx,%eax
  8011da:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8011e0:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8011e5:	c9                   	leave  
  8011e6:	c3                   	ret    

008011e7 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011e7:	55                   	push   %ebp
  8011e8:	89 e5                	mov    %esp,%ebp
  8011ea:	57                   	push   %edi
  8011eb:	56                   	push   %esi
  8011ec:	53                   	push   %ebx
  8011ed:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8011f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011f3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011f6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011fc:	8b 7d 18             	mov    0x18(%ebp),%edi
  8011ff:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801202:	cd 30                	int    $0x30
  801204:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801207:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80120a:	83 c4 10             	add    $0x10,%esp
  80120d:	5b                   	pop    %ebx
  80120e:	5e                   	pop    %esi
  80120f:	5f                   	pop    %edi
  801210:	5d                   	pop    %ebp
  801211:	c3                   	ret    

00801212 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801212:	55                   	push   %ebp
  801213:	89 e5                	mov    %esp,%ebp
  801215:	83 ec 04             	sub    $0x4,%esp
  801218:	8b 45 10             	mov    0x10(%ebp),%eax
  80121b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80121e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801222:	8b 45 08             	mov    0x8(%ebp),%eax
  801225:	6a 00                	push   $0x0
  801227:	6a 00                	push   $0x0
  801229:	52                   	push   %edx
  80122a:	ff 75 0c             	pushl  0xc(%ebp)
  80122d:	50                   	push   %eax
  80122e:	6a 00                	push   $0x0
  801230:	e8 b2 ff ff ff       	call   8011e7 <syscall>
  801235:	83 c4 18             	add    $0x18,%esp
}
  801238:	90                   	nop
  801239:	c9                   	leave  
  80123a:	c3                   	ret    

0080123b <sys_cgetc>:

int
sys_cgetc(void)
{
  80123b:	55                   	push   %ebp
  80123c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80123e:	6a 00                	push   $0x0
  801240:	6a 00                	push   $0x0
  801242:	6a 00                	push   $0x0
  801244:	6a 00                	push   $0x0
  801246:	6a 00                	push   $0x0
  801248:	6a 01                	push   $0x1
  80124a:	e8 98 ff ff ff       	call   8011e7 <syscall>
  80124f:	83 c4 18             	add    $0x18,%esp
}
  801252:	c9                   	leave  
  801253:	c3                   	ret    

00801254 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801254:	55                   	push   %ebp
  801255:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	6a 00                	push   $0x0
  80125c:	6a 00                	push   $0x0
  80125e:	6a 00                	push   $0x0
  801260:	6a 00                	push   $0x0
  801262:	50                   	push   %eax
  801263:	6a 05                	push   $0x5
  801265:	e8 7d ff ff ff       	call   8011e7 <syscall>
  80126a:	83 c4 18             	add    $0x18,%esp
}
  80126d:	c9                   	leave  
  80126e:	c3                   	ret    

0080126f <sys_getenvid>:

int32 sys_getenvid(void)
{
  80126f:	55                   	push   %ebp
  801270:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801272:	6a 00                	push   $0x0
  801274:	6a 00                	push   $0x0
  801276:	6a 00                	push   $0x0
  801278:	6a 00                	push   $0x0
  80127a:	6a 00                	push   $0x0
  80127c:	6a 02                	push   $0x2
  80127e:	e8 64 ff ff ff       	call   8011e7 <syscall>
  801283:	83 c4 18             	add    $0x18,%esp
}
  801286:	c9                   	leave  
  801287:	c3                   	ret    

00801288 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801288:	55                   	push   %ebp
  801289:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  80128b:	6a 00                	push   $0x0
  80128d:	6a 00                	push   $0x0
  80128f:	6a 00                	push   $0x0
  801291:	6a 00                	push   $0x0
  801293:	6a 00                	push   $0x0
  801295:	6a 03                	push   $0x3
  801297:	e8 4b ff ff ff       	call   8011e7 <syscall>
  80129c:	83 c4 18             	add    $0x18,%esp
}
  80129f:	c9                   	leave  
  8012a0:	c3                   	ret    

008012a1 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8012a1:	55                   	push   %ebp
  8012a2:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8012a4:	6a 00                	push   $0x0
  8012a6:	6a 00                	push   $0x0
  8012a8:	6a 00                	push   $0x0
  8012aa:	6a 00                	push   $0x0
  8012ac:	6a 00                	push   $0x0
  8012ae:	6a 04                	push   $0x4
  8012b0:	e8 32 ff ff ff       	call   8011e7 <syscall>
  8012b5:	83 c4 18             	add    $0x18,%esp
}
  8012b8:	c9                   	leave  
  8012b9:	c3                   	ret    

008012ba <sys_env_exit>:


void sys_env_exit(void)
{
  8012ba:	55                   	push   %ebp
  8012bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8012bd:	6a 00                	push   $0x0
  8012bf:	6a 00                	push   $0x0
  8012c1:	6a 00                	push   $0x0
  8012c3:	6a 00                	push   $0x0
  8012c5:	6a 00                	push   $0x0
  8012c7:	6a 06                	push   $0x6
  8012c9:	e8 19 ff ff ff       	call   8011e7 <syscall>
  8012ce:	83 c4 18             	add    $0x18,%esp
}
  8012d1:	90                   	nop
  8012d2:	c9                   	leave  
  8012d3:	c3                   	ret    

008012d4 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8012d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012da:	8b 45 08             	mov    0x8(%ebp),%eax
  8012dd:	6a 00                	push   $0x0
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	52                   	push   %edx
  8012e4:	50                   	push   %eax
  8012e5:	6a 07                	push   $0x7
  8012e7:	e8 fb fe ff ff       	call   8011e7 <syscall>
  8012ec:	83 c4 18             	add    $0x18,%esp
}
  8012ef:	c9                   	leave  
  8012f0:	c3                   	ret    

008012f1 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8012f1:	55                   	push   %ebp
  8012f2:	89 e5                	mov    %esp,%ebp
  8012f4:	56                   	push   %esi
  8012f5:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8012f6:	8b 75 18             	mov    0x18(%ebp),%esi
  8012f9:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012fc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	56                   	push   %esi
  801306:	53                   	push   %ebx
  801307:	51                   	push   %ecx
  801308:	52                   	push   %edx
  801309:	50                   	push   %eax
  80130a:	6a 08                	push   $0x8
  80130c:	e8 d6 fe ff ff       	call   8011e7 <syscall>
  801311:	83 c4 18             	add    $0x18,%esp
}
  801314:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801317:	5b                   	pop    %ebx
  801318:	5e                   	pop    %esi
  801319:	5d                   	pop    %ebp
  80131a:	c3                   	ret    

0080131b <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80131b:	55                   	push   %ebp
  80131c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80131e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	6a 00                	push   $0x0
  801326:	6a 00                	push   $0x0
  801328:	6a 00                	push   $0x0
  80132a:	52                   	push   %edx
  80132b:	50                   	push   %eax
  80132c:	6a 09                	push   $0x9
  80132e:	e8 b4 fe ff ff       	call   8011e7 <syscall>
  801333:	83 c4 18             	add    $0x18,%esp
}
  801336:	c9                   	leave  
  801337:	c3                   	ret    

00801338 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801338:	55                   	push   %ebp
  801339:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80133b:	6a 00                	push   $0x0
  80133d:	6a 00                	push   $0x0
  80133f:	6a 00                	push   $0x0
  801341:	ff 75 0c             	pushl  0xc(%ebp)
  801344:	ff 75 08             	pushl  0x8(%ebp)
  801347:	6a 0a                	push   $0xa
  801349:	e8 99 fe ff ff       	call   8011e7 <syscall>
  80134e:	83 c4 18             	add    $0x18,%esp
}
  801351:	c9                   	leave  
  801352:	c3                   	ret    

00801353 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801353:	55                   	push   %ebp
  801354:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801356:	6a 00                	push   $0x0
  801358:	6a 00                	push   $0x0
  80135a:	6a 00                	push   $0x0
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 0b                	push   $0xb
  801362:	e8 80 fe ff ff       	call   8011e7 <syscall>
  801367:	83 c4 18             	add    $0x18,%esp
}
  80136a:	c9                   	leave  
  80136b:	c3                   	ret    

0080136c <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  80136c:	55                   	push   %ebp
  80136d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80136f:	6a 00                	push   $0x0
  801371:	6a 00                	push   $0x0
  801373:	6a 00                	push   $0x0
  801375:	6a 00                	push   $0x0
  801377:	6a 00                	push   $0x0
  801379:	6a 0c                	push   $0xc
  80137b:	e8 67 fe ff ff       	call   8011e7 <syscall>
  801380:	83 c4 18             	add    $0x18,%esp
}
  801383:	c9                   	leave  
  801384:	c3                   	ret    

00801385 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801385:	55                   	push   %ebp
  801386:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801388:	6a 00                	push   $0x0
  80138a:	6a 00                	push   $0x0
  80138c:	6a 00                	push   $0x0
  80138e:	6a 00                	push   $0x0
  801390:	6a 00                	push   $0x0
  801392:	6a 0d                	push   $0xd
  801394:	e8 4e fe ff ff       	call   8011e7 <syscall>
  801399:	83 c4 18             	add    $0x18,%esp
}
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8013a1:	6a 00                	push   $0x0
  8013a3:	6a 00                	push   $0x0
  8013a5:	6a 00                	push   $0x0
  8013a7:	ff 75 0c             	pushl  0xc(%ebp)
  8013aa:	ff 75 08             	pushl  0x8(%ebp)
  8013ad:	6a 11                	push   $0x11
  8013af:	e8 33 fe ff ff       	call   8011e7 <syscall>
  8013b4:	83 c4 18             	add    $0x18,%esp
	return;
  8013b7:	90                   	nop
}
  8013b8:	c9                   	leave  
  8013b9:	c3                   	ret    

008013ba <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8013ba:	55                   	push   %ebp
  8013bb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8013bd:	6a 00                	push   $0x0
  8013bf:	6a 00                	push   $0x0
  8013c1:	6a 00                	push   $0x0
  8013c3:	ff 75 0c             	pushl  0xc(%ebp)
  8013c6:	ff 75 08             	pushl  0x8(%ebp)
  8013c9:	6a 12                	push   $0x12
  8013cb:	e8 17 fe ff ff       	call   8011e7 <syscall>
  8013d0:	83 c4 18             	add    $0x18,%esp
	return ;
  8013d3:	90                   	nop
}
  8013d4:	c9                   	leave  
  8013d5:	c3                   	ret    

008013d6 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8013d6:	55                   	push   %ebp
  8013d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8013d9:	6a 00                	push   $0x0
  8013db:	6a 00                	push   $0x0
  8013dd:	6a 00                	push   $0x0
  8013df:	6a 00                	push   $0x0
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 0e                	push   $0xe
  8013e5:	e8 fd fd ff ff       	call   8011e7 <syscall>
  8013ea:	83 c4 18             	add    $0x18,%esp
}
  8013ed:	c9                   	leave  
  8013ee:	c3                   	ret    

008013ef <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013ef:	55                   	push   %ebp
  8013f0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013f2:	6a 00                	push   $0x0
  8013f4:	6a 00                	push   $0x0
  8013f6:	6a 00                	push   $0x0
  8013f8:	6a 00                	push   $0x0
  8013fa:	ff 75 08             	pushl  0x8(%ebp)
  8013fd:	6a 0f                	push   $0xf
  8013ff:	e8 e3 fd ff ff       	call   8011e7 <syscall>
  801404:	83 c4 18             	add    $0x18,%esp
}
  801407:	c9                   	leave  
  801408:	c3                   	ret    

00801409 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801409:	55                   	push   %ebp
  80140a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80140c:	6a 00                	push   $0x0
  80140e:	6a 00                	push   $0x0
  801410:	6a 00                	push   $0x0
  801412:	6a 00                	push   $0x0
  801414:	6a 00                	push   $0x0
  801416:	6a 10                	push   $0x10
  801418:	e8 ca fd ff ff       	call   8011e7 <syscall>
  80141d:	83 c4 18             	add    $0x18,%esp
}
  801420:	90                   	nop
  801421:	c9                   	leave  
  801422:	c3                   	ret    

00801423 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801423:	55                   	push   %ebp
  801424:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	6a 00                	push   $0x0
  80142c:	6a 00                	push   $0x0
  80142e:	6a 00                	push   $0x0
  801430:	6a 14                	push   $0x14
  801432:	e8 b0 fd ff ff       	call   8011e7 <syscall>
  801437:	83 c4 18             	add    $0x18,%esp
}
  80143a:	90                   	nop
  80143b:	c9                   	leave  
  80143c:	c3                   	ret    

0080143d <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80143d:	55                   	push   %ebp
  80143e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801440:	6a 00                	push   $0x0
  801442:	6a 00                	push   $0x0
  801444:	6a 00                	push   $0x0
  801446:	6a 00                	push   $0x0
  801448:	6a 00                	push   $0x0
  80144a:	6a 15                	push   $0x15
  80144c:	e8 96 fd ff ff       	call   8011e7 <syscall>
  801451:	83 c4 18             	add    $0x18,%esp
}
  801454:	90                   	nop
  801455:	c9                   	leave  
  801456:	c3                   	ret    

00801457 <sys_cputc>:


void
sys_cputc(const char c)
{
  801457:	55                   	push   %ebp
  801458:	89 e5                	mov    %esp,%ebp
  80145a:	83 ec 04             	sub    $0x4,%esp
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801463:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801467:	6a 00                	push   $0x0
  801469:	6a 00                	push   $0x0
  80146b:	6a 00                	push   $0x0
  80146d:	6a 00                	push   $0x0
  80146f:	50                   	push   %eax
  801470:	6a 16                	push   $0x16
  801472:	e8 70 fd ff ff       	call   8011e7 <syscall>
  801477:	83 c4 18             	add    $0x18,%esp
}
  80147a:	90                   	nop
  80147b:	c9                   	leave  
  80147c:	c3                   	ret    

0080147d <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  80147d:	55                   	push   %ebp
  80147e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801480:	6a 00                	push   $0x0
  801482:	6a 00                	push   $0x0
  801484:	6a 00                	push   $0x0
  801486:	6a 00                	push   $0x0
  801488:	6a 00                	push   $0x0
  80148a:	6a 17                	push   $0x17
  80148c:	e8 56 fd ff ff       	call   8011e7 <syscall>
  801491:	83 c4 18             	add    $0x18,%esp
}
  801494:	90                   	nop
  801495:	c9                   	leave  
  801496:	c3                   	ret    

00801497 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801497:	55                   	push   %ebp
  801498:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	6a 00                	push   $0x0
  80149f:	6a 00                	push   $0x0
  8014a1:	6a 00                	push   $0x0
  8014a3:	ff 75 0c             	pushl  0xc(%ebp)
  8014a6:	50                   	push   %eax
  8014a7:	6a 18                	push   $0x18
  8014a9:	e8 39 fd ff ff       	call   8011e7 <syscall>
  8014ae:	83 c4 18             	add    $0x18,%esp
}
  8014b1:	c9                   	leave  
  8014b2:	c3                   	ret    

008014b3 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8014b3:	55                   	push   %ebp
  8014b4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014b6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8014bc:	6a 00                	push   $0x0
  8014be:	6a 00                	push   $0x0
  8014c0:	6a 00                	push   $0x0
  8014c2:	52                   	push   %edx
  8014c3:	50                   	push   %eax
  8014c4:	6a 1b                	push   $0x1b
  8014c6:	e8 1c fd ff ff       	call   8011e7 <syscall>
  8014cb:	83 c4 18             	add    $0x18,%esp
}
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014d3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	6a 00                	push   $0x0
  8014db:	6a 00                	push   $0x0
  8014dd:	6a 00                	push   $0x0
  8014df:	52                   	push   %edx
  8014e0:	50                   	push   %eax
  8014e1:	6a 19                	push   $0x19
  8014e3:	e8 ff fc ff ff       	call   8011e7 <syscall>
  8014e8:	83 c4 18             	add    $0x18,%esp
}
  8014eb:	90                   	nop
  8014ec:	c9                   	leave  
  8014ed:	c3                   	ret    

008014ee <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014ee:	55                   	push   %ebp
  8014ef:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014f1:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f7:	6a 00                	push   $0x0
  8014f9:	6a 00                	push   $0x0
  8014fb:	6a 00                	push   $0x0
  8014fd:	52                   	push   %edx
  8014fe:	50                   	push   %eax
  8014ff:	6a 1a                	push   $0x1a
  801501:	e8 e1 fc ff ff       	call   8011e7 <syscall>
  801506:	83 c4 18             	add    $0x18,%esp
}
  801509:	90                   	nop
  80150a:	c9                   	leave  
  80150b:	c3                   	ret    

0080150c <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80150c:	55                   	push   %ebp
  80150d:	89 e5                	mov    %esp,%ebp
  80150f:	83 ec 04             	sub    $0x4,%esp
  801512:	8b 45 10             	mov    0x10(%ebp),%eax
  801515:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801518:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80151b:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80151f:	8b 45 08             	mov    0x8(%ebp),%eax
  801522:	6a 00                	push   $0x0
  801524:	51                   	push   %ecx
  801525:	52                   	push   %edx
  801526:	ff 75 0c             	pushl  0xc(%ebp)
  801529:	50                   	push   %eax
  80152a:	6a 1c                	push   $0x1c
  80152c:	e8 b6 fc ff ff       	call   8011e7 <syscall>
  801531:	83 c4 18             	add    $0x18,%esp
}
  801534:	c9                   	leave  
  801535:	c3                   	ret    

00801536 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801536:	55                   	push   %ebp
  801537:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801539:	8b 55 0c             	mov    0xc(%ebp),%edx
  80153c:	8b 45 08             	mov    0x8(%ebp),%eax
  80153f:	6a 00                	push   $0x0
  801541:	6a 00                	push   $0x0
  801543:	6a 00                	push   $0x0
  801545:	52                   	push   %edx
  801546:	50                   	push   %eax
  801547:	6a 1d                	push   $0x1d
  801549:	e8 99 fc ff ff       	call   8011e7 <syscall>
  80154e:	83 c4 18             	add    $0x18,%esp
}
  801551:	c9                   	leave  
  801552:	c3                   	ret    

00801553 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801553:	55                   	push   %ebp
  801554:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801556:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801559:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155c:	8b 45 08             	mov    0x8(%ebp),%eax
  80155f:	6a 00                	push   $0x0
  801561:	6a 00                	push   $0x0
  801563:	51                   	push   %ecx
  801564:	52                   	push   %edx
  801565:	50                   	push   %eax
  801566:	6a 1e                	push   $0x1e
  801568:	e8 7a fc ff ff       	call   8011e7 <syscall>
  80156d:	83 c4 18             	add    $0x18,%esp
}
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801575:	8b 55 0c             	mov    0xc(%ebp),%edx
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	6a 00                	push   $0x0
  80157d:	6a 00                	push   $0x0
  80157f:	6a 00                	push   $0x0
  801581:	52                   	push   %edx
  801582:	50                   	push   %eax
  801583:	6a 1f                	push   $0x1f
  801585:	e8 5d fc ff ff       	call   8011e7 <syscall>
  80158a:	83 c4 18             	add    $0x18,%esp
}
  80158d:	c9                   	leave  
  80158e:	c3                   	ret    

0080158f <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80158f:	55                   	push   %ebp
  801590:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801592:	6a 00                	push   $0x0
  801594:	6a 00                	push   $0x0
  801596:	6a 00                	push   $0x0
  801598:	6a 00                	push   $0x0
  80159a:	6a 00                	push   $0x0
  80159c:	6a 20                	push   $0x20
  80159e:	e8 44 fc ff ff       	call   8011e7 <syscall>
  8015a3:	83 c4 18             	add    $0x18,%esp
}
  8015a6:	c9                   	leave  
  8015a7:	c3                   	ret    

008015a8 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8015a8:	55                   	push   %ebp
  8015a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	6a 00                	push   $0x0
  8015b0:	ff 75 14             	pushl  0x14(%ebp)
  8015b3:	ff 75 10             	pushl  0x10(%ebp)
  8015b6:	ff 75 0c             	pushl  0xc(%ebp)
  8015b9:	50                   	push   %eax
  8015ba:	6a 21                	push   $0x21
  8015bc:	e8 26 fc ff ff       	call   8011e7 <syscall>
  8015c1:	83 c4 18             	add    $0x18,%esp
}
  8015c4:	c9                   	leave  
  8015c5:	c3                   	ret    

008015c6 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8015c6:	55                   	push   %ebp
  8015c7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	6a 00                	push   $0x0
  8015ce:	6a 00                	push   $0x0
  8015d0:	6a 00                	push   $0x0
  8015d2:	6a 00                	push   $0x0
  8015d4:	50                   	push   %eax
  8015d5:	6a 22                	push   $0x22
  8015d7:	e8 0b fc ff ff       	call   8011e7 <syscall>
  8015dc:	83 c4 18             	add    $0x18,%esp
}
  8015df:	90                   	nop
  8015e0:	c9                   	leave  
  8015e1:	c3                   	ret    

008015e2 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8015e2:	55                   	push   %ebp
  8015e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 00                	push   $0x0
  8015ee:	6a 00                	push   $0x0
  8015f0:	50                   	push   %eax
  8015f1:	6a 23                	push   $0x23
  8015f3:	e8 ef fb ff ff       	call   8011e7 <syscall>
  8015f8:	83 c4 18             	add    $0x18,%esp
}
  8015fb:	90                   	nop
  8015fc:	c9                   	leave  
  8015fd:	c3                   	ret    

008015fe <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8015fe:	55                   	push   %ebp
  8015ff:	89 e5                	mov    %esp,%ebp
  801601:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801604:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801607:	8d 50 04             	lea    0x4(%eax),%edx
  80160a:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80160d:	6a 00                	push   $0x0
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	52                   	push   %edx
  801614:	50                   	push   %eax
  801615:	6a 24                	push   $0x24
  801617:	e8 cb fb ff ff       	call   8011e7 <syscall>
  80161c:	83 c4 18             	add    $0x18,%esp
	return result;
  80161f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801622:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801625:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801628:	89 01                	mov    %eax,(%ecx)
  80162a:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80162d:	8b 45 08             	mov    0x8(%ebp),%eax
  801630:	c9                   	leave  
  801631:	c2 04 00             	ret    $0x4

00801634 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	ff 75 10             	pushl  0x10(%ebp)
  80163e:	ff 75 0c             	pushl  0xc(%ebp)
  801641:	ff 75 08             	pushl  0x8(%ebp)
  801644:	6a 13                	push   $0x13
  801646:	e8 9c fb ff ff       	call   8011e7 <syscall>
  80164b:	83 c4 18             	add    $0x18,%esp
	return ;
  80164e:	90                   	nop
}
  80164f:	c9                   	leave  
  801650:	c3                   	ret    

00801651 <sys_rcr2>:
uint32 sys_rcr2()
{
  801651:	55                   	push   %ebp
  801652:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 00                	push   $0x0
  80165a:	6a 00                	push   $0x0
  80165c:	6a 00                	push   $0x0
  80165e:	6a 25                	push   $0x25
  801660:	e8 82 fb ff ff       	call   8011e7 <syscall>
  801665:	83 c4 18             	add    $0x18,%esp
}
  801668:	c9                   	leave  
  801669:	c3                   	ret    

0080166a <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80166a:	55                   	push   %ebp
  80166b:	89 e5                	mov    %esp,%ebp
  80166d:	83 ec 04             	sub    $0x4,%esp
  801670:	8b 45 08             	mov    0x8(%ebp),%eax
  801673:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801676:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80167a:	6a 00                	push   $0x0
  80167c:	6a 00                	push   $0x0
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	50                   	push   %eax
  801683:	6a 26                	push   $0x26
  801685:	e8 5d fb ff ff       	call   8011e7 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
	return ;
  80168d:	90                   	nop
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <rsttst>:
void rsttst()
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 28                	push   $0x28
  80169f:	e8 43 fb ff ff       	call   8011e7 <syscall>
  8016a4:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a7:	90                   	nop
}
  8016a8:	c9                   	leave  
  8016a9:	c3                   	ret    

008016aa <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8016aa:	55                   	push   %ebp
  8016ab:	89 e5                	mov    %esp,%ebp
  8016ad:	83 ec 04             	sub    $0x4,%esp
  8016b0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016b3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8016b6:	8b 55 18             	mov    0x18(%ebp),%edx
  8016b9:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016bd:	52                   	push   %edx
  8016be:	50                   	push   %eax
  8016bf:	ff 75 10             	pushl  0x10(%ebp)
  8016c2:	ff 75 0c             	pushl  0xc(%ebp)
  8016c5:	ff 75 08             	pushl  0x8(%ebp)
  8016c8:	6a 27                	push   $0x27
  8016ca:	e8 18 fb ff ff       	call   8011e7 <syscall>
  8016cf:	83 c4 18             	add    $0x18,%esp
	return ;
  8016d2:	90                   	nop
}
  8016d3:	c9                   	leave  
  8016d4:	c3                   	ret    

008016d5 <chktst>:
void chktst(uint32 n)
{
  8016d5:	55                   	push   %ebp
  8016d6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8016d8:	6a 00                	push   $0x0
  8016da:	6a 00                	push   $0x0
  8016dc:	6a 00                	push   $0x0
  8016de:	6a 00                	push   $0x0
  8016e0:	ff 75 08             	pushl  0x8(%ebp)
  8016e3:	6a 29                	push   $0x29
  8016e5:	e8 fd fa ff ff       	call   8011e7 <syscall>
  8016ea:	83 c4 18             	add    $0x18,%esp
	return ;
  8016ed:	90                   	nop
}
  8016ee:	c9                   	leave  
  8016ef:	c3                   	ret    

008016f0 <inctst>:

void inctst()
{
  8016f0:	55                   	push   %ebp
  8016f1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	6a 00                	push   $0x0
  8016fd:	6a 2a                	push   $0x2a
  8016ff:	e8 e3 fa ff ff       	call   8011e7 <syscall>
  801704:	83 c4 18             	add    $0x18,%esp
	return ;
  801707:	90                   	nop
}
  801708:	c9                   	leave  
  801709:	c3                   	ret    

0080170a <gettst>:
uint32 gettst()
{
  80170a:	55                   	push   %ebp
  80170b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80170d:	6a 00                	push   $0x0
  80170f:	6a 00                	push   $0x0
  801711:	6a 00                	push   $0x0
  801713:	6a 00                	push   $0x0
  801715:	6a 00                	push   $0x0
  801717:	6a 2b                	push   $0x2b
  801719:	e8 c9 fa ff ff       	call   8011e7 <syscall>
  80171e:	83 c4 18             	add    $0x18,%esp
}
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
  801726:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 00                	push   $0x0
  801731:	6a 00                	push   $0x0
  801733:	6a 2c                	push   $0x2c
  801735:	e8 ad fa ff ff       	call   8011e7 <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
  80173d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801740:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801744:	75 07                	jne    80174d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801746:	b8 01 00 00 00       	mov    $0x1,%eax
  80174b:	eb 05                	jmp    801752 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80174d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801752:	c9                   	leave  
  801753:	c3                   	ret    

00801754 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801754:	55                   	push   %ebp
  801755:	89 e5                	mov    %esp,%ebp
  801757:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80175a:	6a 00                	push   $0x0
  80175c:	6a 00                	push   $0x0
  80175e:	6a 00                	push   $0x0
  801760:	6a 00                	push   $0x0
  801762:	6a 00                	push   $0x0
  801764:	6a 2c                	push   $0x2c
  801766:	e8 7c fa ff ff       	call   8011e7 <syscall>
  80176b:	83 c4 18             	add    $0x18,%esp
  80176e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801771:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801775:	75 07                	jne    80177e <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801777:	b8 01 00 00 00       	mov    $0x1,%eax
  80177c:	eb 05                	jmp    801783 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80177e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801783:	c9                   	leave  
  801784:	c3                   	ret    

00801785 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801785:	55                   	push   %ebp
  801786:	89 e5                	mov    %esp,%ebp
  801788:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80178b:	6a 00                	push   $0x0
  80178d:	6a 00                	push   $0x0
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 2c                	push   $0x2c
  801797:	e8 4b fa ff ff       	call   8011e7 <syscall>
  80179c:	83 c4 18             	add    $0x18,%esp
  80179f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8017a2:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8017a6:	75 07                	jne    8017af <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8017a8:	b8 01 00 00 00       	mov    $0x1,%eax
  8017ad:	eb 05                	jmp    8017b4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8017af:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017b4:	c9                   	leave  
  8017b5:	c3                   	ret    

008017b6 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8017b6:	55                   	push   %ebp
  8017b7:	89 e5                	mov    %esp,%ebp
  8017b9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8017bc:	6a 00                	push   $0x0
  8017be:	6a 00                	push   $0x0
  8017c0:	6a 00                	push   $0x0
  8017c2:	6a 00                	push   $0x0
  8017c4:	6a 00                	push   $0x0
  8017c6:	6a 2c                	push   $0x2c
  8017c8:	e8 1a fa ff ff       	call   8011e7 <syscall>
  8017cd:	83 c4 18             	add    $0x18,%esp
  8017d0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8017d3:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8017d7:	75 07                	jne    8017e0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8017d9:	b8 01 00 00 00       	mov    $0x1,%eax
  8017de:	eb 05                	jmp    8017e5 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8017e0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017e5:	c9                   	leave  
  8017e6:	c3                   	ret    

008017e7 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017e7:	55                   	push   %ebp
  8017e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8017ea:	6a 00                	push   $0x0
  8017ec:	6a 00                	push   $0x0
  8017ee:	6a 00                	push   $0x0
  8017f0:	6a 00                	push   $0x0
  8017f2:	ff 75 08             	pushl  0x8(%ebp)
  8017f5:	6a 2d                	push   $0x2d
  8017f7:	e8 eb f9 ff ff       	call   8011e7 <syscall>
  8017fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ff:	90                   	nop
}
  801800:	c9                   	leave  
  801801:	c3                   	ret    

00801802 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801802:	55                   	push   %ebp
  801803:	89 e5                	mov    %esp,%ebp
  801805:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801806:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801809:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80180c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80180f:	8b 45 08             	mov    0x8(%ebp),%eax
  801812:	6a 00                	push   $0x0
  801814:	53                   	push   %ebx
  801815:	51                   	push   %ecx
  801816:	52                   	push   %edx
  801817:	50                   	push   %eax
  801818:	6a 2e                	push   $0x2e
  80181a:	e8 c8 f9 ff ff       	call   8011e7 <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801825:	c9                   	leave  
  801826:	c3                   	ret    

00801827 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801827:	55                   	push   %ebp
  801828:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80182a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182d:	8b 45 08             	mov    0x8(%ebp),%eax
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	52                   	push   %edx
  801837:	50                   	push   %eax
  801838:	6a 2f                	push   $0x2f
  80183a:	e8 a8 f9 ff ff       	call   8011e7 <syscall>
  80183f:	83 c4 18             	add    $0x18,%esp
}
  801842:	c9                   	leave  
  801843:	c3                   	ret    

00801844 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801844:	55                   	push   %ebp
  801845:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801847:	6a 00                	push   $0x0
  801849:	6a 00                	push   $0x0
  80184b:	6a 00                	push   $0x0
  80184d:	ff 75 0c             	pushl  0xc(%ebp)
  801850:	ff 75 08             	pushl  0x8(%ebp)
  801853:	6a 30                	push   $0x30
  801855:	e8 8d f9 ff ff       	call   8011e7 <syscall>
  80185a:	83 c4 18             	add    $0x18,%esp
	return ;
  80185d:	90                   	nop
}
  80185e:	c9                   	leave  
  80185f:	c3                   	ret    

00801860 <__udivdi3>:
  801860:	55                   	push   %ebp
  801861:	57                   	push   %edi
  801862:	56                   	push   %esi
  801863:	53                   	push   %ebx
  801864:	83 ec 1c             	sub    $0x1c,%esp
  801867:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80186b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80186f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801873:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801877:	89 ca                	mov    %ecx,%edx
  801879:	89 f8                	mov    %edi,%eax
  80187b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80187f:	85 f6                	test   %esi,%esi
  801881:	75 2d                	jne    8018b0 <__udivdi3+0x50>
  801883:	39 cf                	cmp    %ecx,%edi
  801885:	77 65                	ja     8018ec <__udivdi3+0x8c>
  801887:	89 fd                	mov    %edi,%ebp
  801889:	85 ff                	test   %edi,%edi
  80188b:	75 0b                	jne    801898 <__udivdi3+0x38>
  80188d:	b8 01 00 00 00       	mov    $0x1,%eax
  801892:	31 d2                	xor    %edx,%edx
  801894:	f7 f7                	div    %edi
  801896:	89 c5                	mov    %eax,%ebp
  801898:	31 d2                	xor    %edx,%edx
  80189a:	89 c8                	mov    %ecx,%eax
  80189c:	f7 f5                	div    %ebp
  80189e:	89 c1                	mov    %eax,%ecx
  8018a0:	89 d8                	mov    %ebx,%eax
  8018a2:	f7 f5                	div    %ebp
  8018a4:	89 cf                	mov    %ecx,%edi
  8018a6:	89 fa                	mov    %edi,%edx
  8018a8:	83 c4 1c             	add    $0x1c,%esp
  8018ab:	5b                   	pop    %ebx
  8018ac:	5e                   	pop    %esi
  8018ad:	5f                   	pop    %edi
  8018ae:	5d                   	pop    %ebp
  8018af:	c3                   	ret    
  8018b0:	39 ce                	cmp    %ecx,%esi
  8018b2:	77 28                	ja     8018dc <__udivdi3+0x7c>
  8018b4:	0f bd fe             	bsr    %esi,%edi
  8018b7:	83 f7 1f             	xor    $0x1f,%edi
  8018ba:	75 40                	jne    8018fc <__udivdi3+0x9c>
  8018bc:	39 ce                	cmp    %ecx,%esi
  8018be:	72 0a                	jb     8018ca <__udivdi3+0x6a>
  8018c0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8018c4:	0f 87 9e 00 00 00    	ja     801968 <__udivdi3+0x108>
  8018ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8018cf:	89 fa                	mov    %edi,%edx
  8018d1:	83 c4 1c             	add    $0x1c,%esp
  8018d4:	5b                   	pop    %ebx
  8018d5:	5e                   	pop    %esi
  8018d6:	5f                   	pop    %edi
  8018d7:	5d                   	pop    %ebp
  8018d8:	c3                   	ret    
  8018d9:	8d 76 00             	lea    0x0(%esi),%esi
  8018dc:	31 ff                	xor    %edi,%edi
  8018de:	31 c0                	xor    %eax,%eax
  8018e0:	89 fa                	mov    %edi,%edx
  8018e2:	83 c4 1c             	add    $0x1c,%esp
  8018e5:	5b                   	pop    %ebx
  8018e6:	5e                   	pop    %esi
  8018e7:	5f                   	pop    %edi
  8018e8:	5d                   	pop    %ebp
  8018e9:	c3                   	ret    
  8018ea:	66 90                	xchg   %ax,%ax
  8018ec:	89 d8                	mov    %ebx,%eax
  8018ee:	f7 f7                	div    %edi
  8018f0:	31 ff                	xor    %edi,%edi
  8018f2:	89 fa                	mov    %edi,%edx
  8018f4:	83 c4 1c             	add    $0x1c,%esp
  8018f7:	5b                   	pop    %ebx
  8018f8:	5e                   	pop    %esi
  8018f9:	5f                   	pop    %edi
  8018fa:	5d                   	pop    %ebp
  8018fb:	c3                   	ret    
  8018fc:	bd 20 00 00 00       	mov    $0x20,%ebp
  801901:	89 eb                	mov    %ebp,%ebx
  801903:	29 fb                	sub    %edi,%ebx
  801905:	89 f9                	mov    %edi,%ecx
  801907:	d3 e6                	shl    %cl,%esi
  801909:	89 c5                	mov    %eax,%ebp
  80190b:	88 d9                	mov    %bl,%cl
  80190d:	d3 ed                	shr    %cl,%ebp
  80190f:	89 e9                	mov    %ebp,%ecx
  801911:	09 f1                	or     %esi,%ecx
  801913:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801917:	89 f9                	mov    %edi,%ecx
  801919:	d3 e0                	shl    %cl,%eax
  80191b:	89 c5                	mov    %eax,%ebp
  80191d:	89 d6                	mov    %edx,%esi
  80191f:	88 d9                	mov    %bl,%cl
  801921:	d3 ee                	shr    %cl,%esi
  801923:	89 f9                	mov    %edi,%ecx
  801925:	d3 e2                	shl    %cl,%edx
  801927:	8b 44 24 08          	mov    0x8(%esp),%eax
  80192b:	88 d9                	mov    %bl,%cl
  80192d:	d3 e8                	shr    %cl,%eax
  80192f:	09 c2                	or     %eax,%edx
  801931:	89 d0                	mov    %edx,%eax
  801933:	89 f2                	mov    %esi,%edx
  801935:	f7 74 24 0c          	divl   0xc(%esp)
  801939:	89 d6                	mov    %edx,%esi
  80193b:	89 c3                	mov    %eax,%ebx
  80193d:	f7 e5                	mul    %ebp
  80193f:	39 d6                	cmp    %edx,%esi
  801941:	72 19                	jb     80195c <__udivdi3+0xfc>
  801943:	74 0b                	je     801950 <__udivdi3+0xf0>
  801945:	89 d8                	mov    %ebx,%eax
  801947:	31 ff                	xor    %edi,%edi
  801949:	e9 58 ff ff ff       	jmp    8018a6 <__udivdi3+0x46>
  80194e:	66 90                	xchg   %ax,%ax
  801950:	8b 54 24 08          	mov    0x8(%esp),%edx
  801954:	89 f9                	mov    %edi,%ecx
  801956:	d3 e2                	shl    %cl,%edx
  801958:	39 c2                	cmp    %eax,%edx
  80195a:	73 e9                	jae    801945 <__udivdi3+0xe5>
  80195c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80195f:	31 ff                	xor    %edi,%edi
  801961:	e9 40 ff ff ff       	jmp    8018a6 <__udivdi3+0x46>
  801966:	66 90                	xchg   %ax,%ax
  801968:	31 c0                	xor    %eax,%eax
  80196a:	e9 37 ff ff ff       	jmp    8018a6 <__udivdi3+0x46>
  80196f:	90                   	nop

00801970 <__umoddi3>:
  801970:	55                   	push   %ebp
  801971:	57                   	push   %edi
  801972:	56                   	push   %esi
  801973:	53                   	push   %ebx
  801974:	83 ec 1c             	sub    $0x1c,%esp
  801977:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80197b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80197f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801983:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801987:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80198b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80198f:	89 f3                	mov    %esi,%ebx
  801991:	89 fa                	mov    %edi,%edx
  801993:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801997:	89 34 24             	mov    %esi,(%esp)
  80199a:	85 c0                	test   %eax,%eax
  80199c:	75 1a                	jne    8019b8 <__umoddi3+0x48>
  80199e:	39 f7                	cmp    %esi,%edi
  8019a0:	0f 86 a2 00 00 00    	jbe    801a48 <__umoddi3+0xd8>
  8019a6:	89 c8                	mov    %ecx,%eax
  8019a8:	89 f2                	mov    %esi,%edx
  8019aa:	f7 f7                	div    %edi
  8019ac:	89 d0                	mov    %edx,%eax
  8019ae:	31 d2                	xor    %edx,%edx
  8019b0:	83 c4 1c             	add    $0x1c,%esp
  8019b3:	5b                   	pop    %ebx
  8019b4:	5e                   	pop    %esi
  8019b5:	5f                   	pop    %edi
  8019b6:	5d                   	pop    %ebp
  8019b7:	c3                   	ret    
  8019b8:	39 f0                	cmp    %esi,%eax
  8019ba:	0f 87 ac 00 00 00    	ja     801a6c <__umoddi3+0xfc>
  8019c0:	0f bd e8             	bsr    %eax,%ebp
  8019c3:	83 f5 1f             	xor    $0x1f,%ebp
  8019c6:	0f 84 ac 00 00 00    	je     801a78 <__umoddi3+0x108>
  8019cc:	bf 20 00 00 00       	mov    $0x20,%edi
  8019d1:	29 ef                	sub    %ebp,%edi
  8019d3:	89 fe                	mov    %edi,%esi
  8019d5:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8019d9:	89 e9                	mov    %ebp,%ecx
  8019db:	d3 e0                	shl    %cl,%eax
  8019dd:	89 d7                	mov    %edx,%edi
  8019df:	89 f1                	mov    %esi,%ecx
  8019e1:	d3 ef                	shr    %cl,%edi
  8019e3:	09 c7                	or     %eax,%edi
  8019e5:	89 e9                	mov    %ebp,%ecx
  8019e7:	d3 e2                	shl    %cl,%edx
  8019e9:	89 14 24             	mov    %edx,(%esp)
  8019ec:	89 d8                	mov    %ebx,%eax
  8019ee:	d3 e0                	shl    %cl,%eax
  8019f0:	89 c2                	mov    %eax,%edx
  8019f2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8019f6:	d3 e0                	shl    %cl,%eax
  8019f8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8019fc:	8b 44 24 08          	mov    0x8(%esp),%eax
  801a00:	89 f1                	mov    %esi,%ecx
  801a02:	d3 e8                	shr    %cl,%eax
  801a04:	09 d0                	or     %edx,%eax
  801a06:	d3 eb                	shr    %cl,%ebx
  801a08:	89 da                	mov    %ebx,%edx
  801a0a:	f7 f7                	div    %edi
  801a0c:	89 d3                	mov    %edx,%ebx
  801a0e:	f7 24 24             	mull   (%esp)
  801a11:	89 c6                	mov    %eax,%esi
  801a13:	89 d1                	mov    %edx,%ecx
  801a15:	39 d3                	cmp    %edx,%ebx
  801a17:	0f 82 87 00 00 00    	jb     801aa4 <__umoddi3+0x134>
  801a1d:	0f 84 91 00 00 00    	je     801ab4 <__umoddi3+0x144>
  801a23:	8b 54 24 04          	mov    0x4(%esp),%edx
  801a27:	29 f2                	sub    %esi,%edx
  801a29:	19 cb                	sbb    %ecx,%ebx
  801a2b:	89 d8                	mov    %ebx,%eax
  801a2d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801a31:	d3 e0                	shl    %cl,%eax
  801a33:	89 e9                	mov    %ebp,%ecx
  801a35:	d3 ea                	shr    %cl,%edx
  801a37:	09 d0                	or     %edx,%eax
  801a39:	89 e9                	mov    %ebp,%ecx
  801a3b:	d3 eb                	shr    %cl,%ebx
  801a3d:	89 da                	mov    %ebx,%edx
  801a3f:	83 c4 1c             	add    $0x1c,%esp
  801a42:	5b                   	pop    %ebx
  801a43:	5e                   	pop    %esi
  801a44:	5f                   	pop    %edi
  801a45:	5d                   	pop    %ebp
  801a46:	c3                   	ret    
  801a47:	90                   	nop
  801a48:	89 fd                	mov    %edi,%ebp
  801a4a:	85 ff                	test   %edi,%edi
  801a4c:	75 0b                	jne    801a59 <__umoddi3+0xe9>
  801a4e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a53:	31 d2                	xor    %edx,%edx
  801a55:	f7 f7                	div    %edi
  801a57:	89 c5                	mov    %eax,%ebp
  801a59:	89 f0                	mov    %esi,%eax
  801a5b:	31 d2                	xor    %edx,%edx
  801a5d:	f7 f5                	div    %ebp
  801a5f:	89 c8                	mov    %ecx,%eax
  801a61:	f7 f5                	div    %ebp
  801a63:	89 d0                	mov    %edx,%eax
  801a65:	e9 44 ff ff ff       	jmp    8019ae <__umoddi3+0x3e>
  801a6a:	66 90                	xchg   %ax,%ax
  801a6c:	89 c8                	mov    %ecx,%eax
  801a6e:	89 f2                	mov    %esi,%edx
  801a70:	83 c4 1c             	add    $0x1c,%esp
  801a73:	5b                   	pop    %ebx
  801a74:	5e                   	pop    %esi
  801a75:	5f                   	pop    %edi
  801a76:	5d                   	pop    %ebp
  801a77:	c3                   	ret    
  801a78:	3b 04 24             	cmp    (%esp),%eax
  801a7b:	72 06                	jb     801a83 <__umoddi3+0x113>
  801a7d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801a81:	77 0f                	ja     801a92 <__umoddi3+0x122>
  801a83:	89 f2                	mov    %esi,%edx
  801a85:	29 f9                	sub    %edi,%ecx
  801a87:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801a8b:	89 14 24             	mov    %edx,(%esp)
  801a8e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801a92:	8b 44 24 04          	mov    0x4(%esp),%eax
  801a96:	8b 14 24             	mov    (%esp),%edx
  801a99:	83 c4 1c             	add    $0x1c,%esp
  801a9c:	5b                   	pop    %ebx
  801a9d:	5e                   	pop    %esi
  801a9e:	5f                   	pop    %edi
  801a9f:	5d                   	pop    %ebp
  801aa0:	c3                   	ret    
  801aa1:	8d 76 00             	lea    0x0(%esi),%esi
  801aa4:	2b 04 24             	sub    (%esp),%eax
  801aa7:	19 fa                	sbb    %edi,%edx
  801aa9:	89 d1                	mov    %edx,%ecx
  801aab:	89 c6                	mov    %eax,%esi
  801aad:	e9 71 ff ff ff       	jmp    801a23 <__umoddi3+0xb3>
  801ab2:	66 90                	xchg   %ax,%ax
  801ab4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801ab8:	72 ea                	jb     801aa4 <__umoddi3+0x134>
  801aba:	89 d9                	mov    %ebx,%ecx
  801abc:	e9 62 ff ff ff       	jmp    801a23 <__umoddi3+0xb3>
