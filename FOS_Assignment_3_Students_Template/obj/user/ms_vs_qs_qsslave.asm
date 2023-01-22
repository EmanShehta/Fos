
obj/user/ms_vs_qs_qsslave:     file format elf32-i386


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
  800031:	e8 46 06 00 00       	call   80067c <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void QuickSort(int *Elements, int NumOfElements);
void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex);
uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec c8 63 00 00    	sub    $0x63c8,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[25500] ;
	char Chose ;
	int Iteration = 0 ;
  800041:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)

	int32 envID = sys_getenvid();
  800048:	e8 c8 1b 00 00       	call   801c15 <sys_getenvid>
  80004d:	89 45 e8             	mov    %eax,-0x18(%ebp)
	int32 parentID = myEnv->env_parent_id ;
  800050:	a1 24 30 80 00       	mov    0x803024,%eax
  800055:	8b 40 50             	mov    0x50(%eax),%eax
  800058:	89 45 e4             	mov    %eax,-0x1c(%ebp)
	do
	{
//	sys_disable_interrupt();
		sys_waitSemaphore(parentID, "cs1");
  80005b:	83 ec 08             	sub    $0x8,%esp
  80005e:	68 80 24 80 00       	push   $0x802480
  800063:	ff 75 e4             	pushl  -0x1c(%ebp)
  800066:	e8 0b 1e 00 00       	call   801e76 <sys_waitSemaphore>
  80006b:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80006e:	83 ec 08             	sub    $0x8,%esp
  800071:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800077:	50                   	push   %eax
  800078:	68 84 24 80 00       	push   $0x802484
  80007d:	e8 4c 10 00 00       	call   8010ce <readline>
  800082:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800085:	83 ec 04             	sub    $0x4,%esp
  800088:	6a 0a                	push   $0xa
  80008a:	6a 00                	push   $0x0
  80008c:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800092:	50                   	push   %eax
  800093:	e8 9c 15 00 00       	call   801634 <strtol>
  800098:	83 c4 10             	add    $0x10,%esp
  80009b:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = __new(sizeof(int) * NumOfElements) ;
  80009e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000a1:	c1 e0 02             	shl    $0x2,%eax
  8000a4:	83 ec 0c             	sub    $0xc,%esp
  8000a7:	50                   	push   %eax
  8000a8:	e8 85 1a 00 00       	call   801b32 <__new>
  8000ad:	83 c4 10             	add    $0x10,%esp
  8000b0:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000b3:	83 ec 0c             	sub    $0xc,%esp
  8000b6:	68 a4 24 80 00       	push   $0x8024a4
  8000bb:	e8 8c 09 00 00       	call   800a4c <cprintf>
  8000c0:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000c3:	83 ec 0c             	sub    $0xc,%esp
  8000c6:	68 c7 24 80 00       	push   $0x8024c7
  8000cb:	e8 7c 09 00 00       	call   800a4c <cprintf>
  8000d0:	83 c4 10             	add    $0x10,%esp
		int ii, j = 0 ;
  8000d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
		for (ii = 0 ; ii < 100000; ii++)
  8000da:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8000e1:	eb 09                	jmp    8000ec <_main+0xb4>
		{
			j+= ii;
  8000e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000e6:	01 45 f0             	add    %eax,-0x10(%ebp)
		int *Elements = __new(sizeof(int) * NumOfElements) ;
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
		cprintf("a) Ascending\n") ;
		int ii, j = 0 ;
		for (ii = 0 ; ii < 100000; ii++)
  8000e9:	ff 45 f4             	incl   -0xc(%ebp)
  8000ec:	81 7d f4 9f 86 01 00 	cmpl   $0x1869f,-0xc(%ebp)
  8000f3:	7e ee                	jle    8000e3 <_main+0xab>
		{
			j+= ii;
		}
		cprintf("b) Descending\n") ;
  8000f5:	83 ec 0c             	sub    $0xc,%esp
  8000f8:	68 d5 24 80 00       	push   $0x8024d5
  8000fd:	e8 4a 09 00 00       	call   800a4c <cprintf>
  800102:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800105:	83 ec 0c             	sub    $0xc,%esp
  800108:	68 e4 24 80 00       	push   $0x8024e4
  80010d:	e8 3a 09 00 00       	call   800a4c <cprintf>
  800112:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800115:	83 ec 0c             	sub    $0xc,%esp
  800118:	68 f4 24 80 00       	push   $0x8024f4
  80011d:	e8 2a 09 00 00       	call   800a4c <cprintf>
  800122:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800125:	e8 fa 04 00 00       	call   800624 <getchar>
  80012a:	88 45 db             	mov    %al,-0x25(%ebp)
			cputchar(Chose);
  80012d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	50                   	push   %eax
  800135:	e8 a2 04 00 00       	call   8005dc <cputchar>
  80013a:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80013d:	83 ec 0c             	sub    $0xc,%esp
  800140:	6a 0a                	push   $0xa
  800142:	e8 95 04 00 00       	call   8005dc <cputchar>
  800147:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80014a:	80 7d db 61          	cmpb   $0x61,-0x25(%ebp)
  80014e:	74 0c                	je     80015c <_main+0x124>
  800150:	80 7d db 62          	cmpb   $0x62,-0x25(%ebp)
  800154:	74 06                	je     80015c <_main+0x124>
  800156:	80 7d db 63          	cmpb   $0x63,-0x25(%ebp)
  80015a:	75 b9                	jne    800115 <_main+0xdd>
		sys_signalSemaphore(parentID, "cs1");
  80015c:	83 ec 08             	sub    $0x8,%esp
  80015f:	68 80 24 80 00       	push   $0x802480
  800164:	ff 75 e4             	pushl  -0x1c(%ebp)
  800167:	e8 28 1d 00 00       	call   801e94 <sys_signalSemaphore>
  80016c:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  80016f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800173:	83 f8 62             	cmp    $0x62,%eax
  800176:	74 1d                	je     800195 <_main+0x15d>
  800178:	83 f8 63             	cmp    $0x63,%eax
  80017b:	74 2b                	je     8001a8 <_main+0x170>
  80017d:	83 f8 61             	cmp    $0x61,%eax
  800180:	75 39                	jne    8001bb <_main+0x183>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800182:	83 ec 08             	sub    $0x8,%esp
  800185:	ff 75 e0             	pushl  -0x20(%ebp)
  800188:	ff 75 dc             	pushl  -0x24(%ebp)
  80018b:	e8 14 03 00 00       	call   8004a4 <InitializeAscending>
  800190:	83 c4 10             	add    $0x10,%esp
			break ;
  800193:	eb 37                	jmp    8001cc <_main+0x194>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  800195:	83 ec 08             	sub    $0x8,%esp
  800198:	ff 75 e0             	pushl  -0x20(%ebp)
  80019b:	ff 75 dc             	pushl  -0x24(%ebp)
  80019e:	e8 32 03 00 00       	call   8004d5 <InitializeDescending>
  8001a3:	83 c4 10             	add    $0x10,%esp
			break ;
  8001a6:	eb 24                	jmp    8001cc <_main+0x194>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a8:	83 ec 08             	sub    $0x8,%esp
  8001ab:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ae:	ff 75 dc             	pushl  -0x24(%ebp)
  8001b1:	e8 54 03 00 00       	call   80050a <InitializeSemiRandom>
  8001b6:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b9:	eb 11                	jmp    8001cc <_main+0x194>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001bb:	83 ec 08             	sub    $0x8,%esp
  8001be:	ff 75 e0             	pushl  -0x20(%ebp)
  8001c1:	ff 75 dc             	pushl  -0x24(%ebp)
  8001c4:	e8 41 03 00 00       	call   80050a <InitializeSemiRandom>
  8001c9:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001cc:	83 ec 08             	sub    $0x8,%esp
  8001cf:	ff 75 e0             	pushl  -0x20(%ebp)
  8001d2:	ff 75 dc             	pushl  -0x24(%ebp)
  8001d5:	e8 0f 01 00 00       	call   8002e9 <QuickSort>
  8001da:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001dd:	83 ec 08             	sub    $0x8,%esp
  8001e0:	ff 75 e0             	pushl  -0x20(%ebp)
  8001e3:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e6:	e8 0f 02 00 00       	call   8003fa <CheckSorted>
  8001eb:	83 c4 10             	add    $0x10,%esp
  8001ee:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001f1:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  8001f5:	75 14                	jne    80020b <_main+0x1d3>
  8001f7:	83 ec 04             	sub    $0x4,%esp
  8001fa:	68 00 25 80 00       	push   $0x802500
  8001ff:	6a 4a                	push   $0x4a
  800201:	68 22 25 80 00       	push   $0x802522
  800206:	e8 8d 05 00 00       	call   800798 <_panic>
		else
		{
			sys_waitSemaphore(parentID, "cs1");
  80020b:	83 ec 08             	sub    $0x8,%esp
  80020e:	68 80 24 80 00       	push   $0x802480
  800213:	ff 75 e4             	pushl  -0x1c(%ebp)
  800216:	e8 5b 1c 00 00       	call   801e76 <sys_waitSemaphore>
  80021b:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80021e:	83 ec 0c             	sub    $0xc,%esp
  800221:	68 3c 25 80 00       	push   $0x80253c
  800226:	e8 21 08 00 00       	call   800a4c <cprintf>
  80022b:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80022e:	83 ec 0c             	sub    $0xc,%esp
  800231:	68 70 25 80 00       	push   $0x802570
  800236:	e8 11 08 00 00       	call   800a4c <cprintf>
  80023b:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80023e:	83 ec 0c             	sub    $0xc,%esp
  800241:	68 a4 25 80 00       	push   $0x8025a4
  800246:	e8 01 08 00 00       	call   800a4c <cprintf>
  80024b:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(parentID, "cs1");
  80024e:	83 ec 08             	sub    $0x8,%esp
  800251:	68 80 24 80 00       	push   $0x802480
  800256:	ff 75 e4             	pushl  -0x1c(%ebp)
  800259:	e8 36 1c 00 00       	call   801e94 <sys_signalSemaphore>
  80025e:	83 c4 10             	add    $0x10,%esp
//		free(Elements) ;


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(parentID, "cs1");
  800261:	83 ec 08             	sub    $0x8,%esp
  800264:	68 80 24 80 00       	push   $0x802480
  800269:	ff 75 e4             	pushl  -0x1c(%ebp)
  80026c:	e8 05 1c 00 00       	call   801e76 <sys_waitSemaphore>
  800271:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  800274:	83 ec 0c             	sub    $0xc,%esp
  800277:	68 d6 25 80 00       	push   $0x8025d6
  80027c:	e8 cb 07 00 00       	call   800a4c <cprintf>
  800281:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  800284:	e8 9b 03 00 00       	call   800624 <getchar>
  800289:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  80028c:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	50                   	push   %eax
  800294:	e8 43 03 00 00       	call   8005dc <cputchar>
  800299:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80029c:	83 ec 0c             	sub    $0xc,%esp
  80029f:	6a 0a                	push   $0xa
  8002a1:	e8 36 03 00 00       	call   8005dc <cputchar>
  8002a6:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002a9:	83 ec 0c             	sub    $0xc,%esp
  8002ac:	6a 0a                	push   $0xa
  8002ae:	e8 29 03 00 00       	call   8005dc <cputchar>
  8002b3:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(parentID,"cs1");
  8002b6:	83 ec 08             	sub    $0x8,%esp
  8002b9:	68 80 24 80 00       	push   $0x802480
  8002be:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002c1:	e8 ce 1b 00 00       	call   801e94 <sys_signalSemaphore>
  8002c6:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  8002c9:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  8002cd:	0f 84 88 fd ff ff    	je     80005b <_main+0x23>
	sys_signalSemaphore(parentID, "dep1");
  8002d3:	83 ec 08             	sub    $0x8,%esp
  8002d6:	68 f4 25 80 00       	push   $0x8025f4
  8002db:	ff 75 e4             	pushl  -0x1c(%ebp)
  8002de:	e8 b1 1b 00 00       	call   801e94 <sys_signalSemaphore>
  8002e3:	83 c4 10             	add    $0x10,%esp
}
  8002e6:	90                   	nop
  8002e7:	c9                   	leave  
  8002e8:	c3                   	ret    

008002e9 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002e9:	55                   	push   %ebp
  8002ea:	89 e5                	mov    %esp,%ebp
  8002ec:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002f2:	48                   	dec    %eax
  8002f3:	50                   	push   %eax
  8002f4:	6a 00                	push   $0x0
  8002f6:	ff 75 0c             	pushl  0xc(%ebp)
  8002f9:	ff 75 08             	pushl  0x8(%ebp)
  8002fc:	e8 06 00 00 00       	call   800307 <QSort>
  800301:	83 c4 10             	add    $0x10,%esp
}
  800304:	90                   	nop
  800305:	c9                   	leave  
  800306:	c3                   	ret    

00800307 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800307:	55                   	push   %ebp
  800308:	89 e5                	mov    %esp,%ebp
  80030a:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80030d:	8b 45 10             	mov    0x10(%ebp),%eax
  800310:	3b 45 14             	cmp    0x14(%ebp),%eax
  800313:	0f 8d de 00 00 00    	jge    8003f7 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800319:	8b 45 10             	mov    0x10(%ebp),%eax
  80031c:	40                   	inc    %eax
  80031d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800320:	8b 45 14             	mov    0x14(%ebp),%eax
  800323:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800326:	e9 80 00 00 00       	jmp    8003ab <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80032b:	ff 45 f4             	incl   -0xc(%ebp)
  80032e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800331:	3b 45 14             	cmp    0x14(%ebp),%eax
  800334:	7f 2b                	jg     800361 <QSort+0x5a>
  800336:	8b 45 10             	mov    0x10(%ebp),%eax
  800339:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800340:	8b 45 08             	mov    0x8(%ebp),%eax
  800343:	01 d0                	add    %edx,%eax
  800345:	8b 10                	mov    (%eax),%edx
  800347:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80034a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800351:	8b 45 08             	mov    0x8(%ebp),%eax
  800354:	01 c8                	add    %ecx,%eax
  800356:	8b 00                	mov    (%eax),%eax
  800358:	39 c2                	cmp    %eax,%edx
  80035a:	7d cf                	jge    80032b <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  80035c:	eb 03                	jmp    800361 <QSort+0x5a>
  80035e:	ff 4d f0             	decl   -0x10(%ebp)
  800361:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800364:	3b 45 10             	cmp    0x10(%ebp),%eax
  800367:	7e 26                	jle    80038f <QSort+0x88>
  800369:	8b 45 10             	mov    0x10(%ebp),%eax
  80036c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800373:	8b 45 08             	mov    0x8(%ebp),%eax
  800376:	01 d0                	add    %edx,%eax
  800378:	8b 10                	mov    (%eax),%edx
  80037a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80037d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800384:	8b 45 08             	mov    0x8(%ebp),%eax
  800387:	01 c8                	add    %ecx,%eax
  800389:	8b 00                	mov    (%eax),%eax
  80038b:	39 c2                	cmp    %eax,%edx
  80038d:	7e cf                	jle    80035e <QSort+0x57>

		if (i <= j)
  80038f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800392:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800395:	7f 14                	jg     8003ab <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800397:	83 ec 04             	sub    $0x4,%esp
  80039a:	ff 75 f0             	pushl  -0x10(%ebp)
  80039d:	ff 75 f4             	pushl  -0xc(%ebp)
  8003a0:	ff 75 08             	pushl  0x8(%ebp)
  8003a3:	e8 a9 00 00 00       	call   800451 <Swap>
  8003a8:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ae:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003b1:	0f 8e 77 ff ff ff    	jle    80032e <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003b7:	83 ec 04             	sub    $0x4,%esp
  8003ba:	ff 75 f0             	pushl  -0x10(%ebp)
  8003bd:	ff 75 10             	pushl  0x10(%ebp)
  8003c0:	ff 75 08             	pushl  0x8(%ebp)
  8003c3:	e8 89 00 00 00       	call   800451 <Swap>
  8003c8:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003ce:	48                   	dec    %eax
  8003cf:	50                   	push   %eax
  8003d0:	ff 75 10             	pushl  0x10(%ebp)
  8003d3:	ff 75 0c             	pushl  0xc(%ebp)
  8003d6:	ff 75 08             	pushl  0x8(%ebp)
  8003d9:	e8 29 ff ff ff       	call   800307 <QSort>
  8003de:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003e1:	ff 75 14             	pushl  0x14(%ebp)
  8003e4:	ff 75 f4             	pushl  -0xc(%ebp)
  8003e7:	ff 75 0c             	pushl  0xc(%ebp)
  8003ea:	ff 75 08             	pushl  0x8(%ebp)
  8003ed:	e8 15 ff ff ff       	call   800307 <QSort>
  8003f2:	83 c4 10             	add    $0x10,%esp
  8003f5:	eb 01                	jmp    8003f8 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003f7:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  8003f8:	c9                   	leave  
  8003f9:	c3                   	ret    

008003fa <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003fa:	55                   	push   %ebp
  8003fb:	89 e5                	mov    %esp,%ebp
  8003fd:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800400:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800407:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80040e:	eb 33                	jmp    800443 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800410:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800413:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80041a:	8b 45 08             	mov    0x8(%ebp),%eax
  80041d:	01 d0                	add    %edx,%eax
  80041f:	8b 10                	mov    (%eax),%edx
  800421:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800424:	40                   	inc    %eax
  800425:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80042c:	8b 45 08             	mov    0x8(%ebp),%eax
  80042f:	01 c8                	add    %ecx,%eax
  800431:	8b 00                	mov    (%eax),%eax
  800433:	39 c2                	cmp    %eax,%edx
  800435:	7e 09                	jle    800440 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800437:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80043e:	eb 0c                	jmp    80044c <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800440:	ff 45 f8             	incl   -0x8(%ebp)
  800443:	8b 45 0c             	mov    0xc(%ebp),%eax
  800446:	48                   	dec    %eax
  800447:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80044a:	7f c4                	jg     800410 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80044c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80044f:	c9                   	leave  
  800450:	c3                   	ret    

00800451 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800451:	55                   	push   %ebp
  800452:	89 e5                	mov    %esp,%ebp
  800454:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800457:	8b 45 0c             	mov    0xc(%ebp),%eax
  80045a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800461:	8b 45 08             	mov    0x8(%ebp),%eax
  800464:	01 d0                	add    %edx,%eax
  800466:	8b 00                	mov    (%eax),%eax
  800468:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  80046b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80046e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800475:	8b 45 08             	mov    0x8(%ebp),%eax
  800478:	01 c2                	add    %eax,%edx
  80047a:	8b 45 10             	mov    0x10(%ebp),%eax
  80047d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800484:	8b 45 08             	mov    0x8(%ebp),%eax
  800487:	01 c8                	add    %ecx,%eax
  800489:	8b 00                	mov    (%eax),%eax
  80048b:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  80048d:	8b 45 10             	mov    0x10(%ebp),%eax
  800490:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800497:	8b 45 08             	mov    0x8(%ebp),%eax
  80049a:	01 c2                	add    %eax,%edx
  80049c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049f:	89 02                	mov    %eax,(%edx)
}
  8004a1:	90                   	nop
  8004a2:	c9                   	leave  
  8004a3:	c3                   	ret    

008004a4 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004a4:	55                   	push   %ebp
  8004a5:	89 e5                	mov    %esp,%ebp
  8004a7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004b1:	eb 17                	jmp    8004ca <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c0:	01 c2                	add    %eax,%edx
  8004c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c5:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c7:	ff 45 fc             	incl   -0x4(%ebp)
  8004ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004cd:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004d0:	7c e1                	jl     8004b3 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004d2:	90                   	nop
  8004d3:	c9                   	leave  
  8004d4:	c3                   	ret    

008004d5 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004d5:	55                   	push   %ebp
  8004d6:	89 e5                	mov    %esp,%ebp
  8004d8:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004e2:	eb 1b                	jmp    8004ff <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f1:	01 c2                	add    %eax,%edx
  8004f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004f6:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004f9:	48                   	dec    %eax
  8004fa:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fc:	ff 45 fc             	incl   -0x4(%ebp)
  8004ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800502:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800505:	7c dd                	jl     8004e4 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800507:	90                   	nop
  800508:	c9                   	leave  
  800509:	c3                   	ret    

0080050a <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80050a:	55                   	push   %ebp
  80050b:	89 e5                	mov    %esp,%ebp
  80050d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800510:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800513:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800518:	f7 e9                	imul   %ecx
  80051a:	c1 f9 1f             	sar    $0x1f,%ecx
  80051d:	89 d0                	mov    %edx,%eax
  80051f:	29 c8                	sub    %ecx,%eax
  800521:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800524:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80052b:	eb 1e                	jmp    80054b <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80052d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800530:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800537:	8b 45 08             	mov    0x8(%ebp),%eax
  80053a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80053d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800540:	99                   	cltd   
  800541:	f7 7d f8             	idivl  -0x8(%ebp)
  800544:	89 d0                	mov    %edx,%eax
  800546:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800548:	ff 45 fc             	incl   -0x4(%ebp)
  80054b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80054e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800551:	7c da                	jl     80052d <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  800553:	90                   	nop
  800554:	c9                   	leave  
  800555:	c3                   	ret    

00800556 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800556:	55                   	push   %ebp
  800557:	89 e5                	mov    %esp,%ebp
  800559:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  80055c:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800563:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  80056a:	eb 42                	jmp    8005ae <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  80056c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80056f:	99                   	cltd   
  800570:	f7 7d f0             	idivl  -0x10(%ebp)
  800573:	89 d0                	mov    %edx,%eax
  800575:	85 c0                	test   %eax,%eax
  800577:	75 10                	jne    800589 <PrintElements+0x33>
			cprintf("\n");
  800579:	83 ec 0c             	sub    $0xc,%esp
  80057c:	68 f9 25 80 00       	push   $0x8025f9
  800581:	e8 c6 04 00 00       	call   800a4c <cprintf>
  800586:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800589:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80058c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800593:	8b 45 08             	mov    0x8(%ebp),%eax
  800596:	01 d0                	add    %edx,%eax
  800598:	8b 00                	mov    (%eax),%eax
  80059a:	83 ec 08             	sub    $0x8,%esp
  80059d:	50                   	push   %eax
  80059e:	68 fb 25 80 00       	push   $0x8025fb
  8005a3:	e8 a4 04 00 00       	call   800a4c <cprintf>
  8005a8:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005ab:	ff 45 f4             	incl   -0xc(%ebp)
  8005ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005b1:	48                   	dec    %eax
  8005b2:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005b5:	7f b5                	jg     80056c <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8005b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005ba:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005c4:	01 d0                	add    %edx,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	83 ec 08             	sub    $0x8,%esp
  8005cb:	50                   	push   %eax
  8005cc:	68 00 26 80 00       	push   $0x802600
  8005d1:	e8 76 04 00 00       	call   800a4c <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp

}
  8005d9:	90                   	nop
  8005da:	c9                   	leave  
  8005db:	c3                   	ret    

008005dc <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005dc:	55                   	push   %ebp
  8005dd:	89 e5                	mov    %esp,%ebp
  8005df:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e5:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005e8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005ec:	83 ec 0c             	sub    $0xc,%esp
  8005ef:	50                   	push   %eax
  8005f0:	e8 08 18 00 00       	call   801dfd <sys_cputc>
  8005f5:	83 c4 10             	add    $0x10,%esp
}
  8005f8:	90                   	nop
  8005f9:	c9                   	leave  
  8005fa:	c3                   	ret    

008005fb <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005fb:	55                   	push   %ebp
  8005fc:	89 e5                	mov    %esp,%ebp
  8005fe:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800601:	e8 c3 17 00 00       	call   801dc9 <sys_disable_interrupt>
	char c = ch;
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80060c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800610:	83 ec 0c             	sub    $0xc,%esp
  800613:	50                   	push   %eax
  800614:	e8 e4 17 00 00       	call   801dfd <sys_cputc>
  800619:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80061c:	e8 c2 17 00 00       	call   801de3 <sys_enable_interrupt>
}
  800621:	90                   	nop
  800622:	c9                   	leave  
  800623:	c3                   	ret    

00800624 <getchar>:

int
getchar(void)
{
  800624:	55                   	push   %ebp
  800625:	89 e5                	mov    %esp,%ebp
  800627:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80062a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800631:	eb 08                	jmp    80063b <getchar+0x17>
	{
		c = sys_cgetc();
  800633:	e8 a9 15 00 00       	call   801be1 <sys_cgetc>
  800638:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80063b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80063f:	74 f2                	je     800633 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800641:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800644:	c9                   	leave  
  800645:	c3                   	ret    

00800646 <atomic_getchar>:

int
atomic_getchar(void)
{
  800646:	55                   	push   %ebp
  800647:	89 e5                	mov    %esp,%ebp
  800649:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80064c:	e8 78 17 00 00       	call   801dc9 <sys_disable_interrupt>
	int c=0;
  800651:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800658:	eb 08                	jmp    800662 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  80065a:	e8 82 15 00 00       	call   801be1 <sys_cgetc>
  80065f:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  800662:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800666:	74 f2                	je     80065a <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800668:	e8 76 17 00 00       	call   801de3 <sys_enable_interrupt>
	return c;
  80066d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800670:	c9                   	leave  
  800671:	c3                   	ret    

00800672 <iscons>:

int iscons(int fdnum)
{
  800672:	55                   	push   %ebp
  800673:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800675:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80067a:	5d                   	pop    %ebp
  80067b:	c3                   	ret    

0080067c <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  80067c:	55                   	push   %ebp
  80067d:	89 e5                	mov    %esp,%ebp
  80067f:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800682:	e8 a7 15 00 00       	call   801c2e <sys_getenvindex>
  800687:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  80068a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80068d:	89 d0                	mov    %edx,%eax
  80068f:	01 c0                	add    %eax,%eax
  800691:	01 d0                	add    %edx,%eax
  800693:	c1 e0 04             	shl    $0x4,%eax
  800696:	29 d0                	sub    %edx,%eax
  800698:	c1 e0 03             	shl    $0x3,%eax
  80069b:	01 d0                	add    %edx,%eax
  80069d:	c1 e0 02             	shl    $0x2,%eax
  8006a0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006a5:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006aa:	a1 24 30 80 00       	mov    0x803024,%eax
  8006af:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8006b5:	84 c0                	test   %al,%al
  8006b7:	74 0f                	je     8006c8 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8006b9:	a1 24 30 80 00       	mov    0x803024,%eax
  8006be:	05 5c 05 00 00       	add    $0x55c,%eax
  8006c3:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006c8:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006cc:	7e 0a                	jle    8006d8 <libmain+0x5c>
		binaryname = argv[0];
  8006ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d1:	8b 00                	mov    (%eax),%eax
  8006d3:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006d8:	83 ec 08             	sub    $0x8,%esp
  8006db:	ff 75 0c             	pushl  0xc(%ebp)
  8006de:	ff 75 08             	pushl  0x8(%ebp)
  8006e1:	e8 52 f9 ff ff       	call   800038 <_main>
  8006e6:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006e9:	e8 db 16 00 00       	call   801dc9 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006ee:	83 ec 0c             	sub    $0xc,%esp
  8006f1:	68 1c 26 80 00       	push   $0x80261c
  8006f6:	e8 51 03 00 00       	call   800a4c <cprintf>
  8006fb:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006fe:	a1 24 30 80 00       	mov    0x803024,%eax
  800703:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800709:	a1 24 30 80 00       	mov    0x803024,%eax
  80070e:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800714:	83 ec 04             	sub    $0x4,%esp
  800717:	52                   	push   %edx
  800718:	50                   	push   %eax
  800719:	68 44 26 80 00       	push   $0x802644
  80071e:	e8 29 03 00 00       	call   800a4c <cprintf>
  800723:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800726:	a1 24 30 80 00       	mov    0x803024,%eax
  80072b:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800731:	a1 24 30 80 00       	mov    0x803024,%eax
  800736:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  80073c:	a1 24 30 80 00       	mov    0x803024,%eax
  800741:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800747:	51                   	push   %ecx
  800748:	52                   	push   %edx
  800749:	50                   	push   %eax
  80074a:	68 6c 26 80 00       	push   $0x80266c
  80074f:	e8 f8 02 00 00       	call   800a4c <cprintf>
  800754:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800757:	83 ec 0c             	sub    $0xc,%esp
  80075a:	68 1c 26 80 00       	push   $0x80261c
  80075f:	e8 e8 02 00 00       	call   800a4c <cprintf>
  800764:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800767:	e8 77 16 00 00       	call   801de3 <sys_enable_interrupt>

	// exit gracefully
	exit();
  80076c:	e8 19 00 00 00       	call   80078a <exit>
}
  800771:	90                   	nop
  800772:	c9                   	leave  
  800773:	c3                   	ret    

00800774 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800774:	55                   	push   %ebp
  800775:	89 e5                	mov    %esp,%ebp
  800777:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  80077a:	83 ec 0c             	sub    $0xc,%esp
  80077d:	6a 00                	push   $0x0
  80077f:	e8 76 14 00 00       	call   801bfa <sys_env_destroy>
  800784:	83 c4 10             	add    $0x10,%esp
}
  800787:	90                   	nop
  800788:	c9                   	leave  
  800789:	c3                   	ret    

0080078a <exit>:

void
exit(void)
{
  80078a:	55                   	push   %ebp
  80078b:	89 e5                	mov    %esp,%ebp
  80078d:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800790:	e8 cb 14 00 00       	call   801c60 <sys_env_exit>
}
  800795:	90                   	nop
  800796:	c9                   	leave  
  800797:	c3                   	ret    

00800798 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800798:	55                   	push   %ebp
  800799:	89 e5                	mov    %esp,%ebp
  80079b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80079e:	8d 45 10             	lea    0x10(%ebp),%eax
  8007a1:	83 c0 04             	add    $0x4,%eax
  8007a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007a7:	a1 18 31 80 00       	mov    0x803118,%eax
  8007ac:	85 c0                	test   %eax,%eax
  8007ae:	74 16                	je     8007c6 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007b0:	a1 18 31 80 00       	mov    0x803118,%eax
  8007b5:	83 ec 08             	sub    $0x8,%esp
  8007b8:	50                   	push   %eax
  8007b9:	68 c4 26 80 00       	push   $0x8026c4
  8007be:	e8 89 02 00 00       	call   800a4c <cprintf>
  8007c3:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007c6:	a1 00 30 80 00       	mov    0x803000,%eax
  8007cb:	ff 75 0c             	pushl  0xc(%ebp)
  8007ce:	ff 75 08             	pushl  0x8(%ebp)
  8007d1:	50                   	push   %eax
  8007d2:	68 c9 26 80 00       	push   $0x8026c9
  8007d7:	e8 70 02 00 00       	call   800a4c <cprintf>
  8007dc:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007df:	8b 45 10             	mov    0x10(%ebp),%eax
  8007e2:	83 ec 08             	sub    $0x8,%esp
  8007e5:	ff 75 f4             	pushl  -0xc(%ebp)
  8007e8:	50                   	push   %eax
  8007e9:	e8 f3 01 00 00       	call   8009e1 <vcprintf>
  8007ee:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007f1:	83 ec 08             	sub    $0x8,%esp
  8007f4:	6a 00                	push   $0x0
  8007f6:	68 e5 26 80 00       	push   $0x8026e5
  8007fb:	e8 e1 01 00 00       	call   8009e1 <vcprintf>
  800800:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800803:	e8 82 ff ff ff       	call   80078a <exit>

	// should not return here
	while (1) ;
  800808:	eb fe                	jmp    800808 <_panic+0x70>

0080080a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80080a:	55                   	push   %ebp
  80080b:	89 e5                	mov    %esp,%ebp
  80080d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800810:	a1 24 30 80 00       	mov    0x803024,%eax
  800815:	8b 50 74             	mov    0x74(%eax),%edx
  800818:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081b:	39 c2                	cmp    %eax,%edx
  80081d:	74 14                	je     800833 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80081f:	83 ec 04             	sub    $0x4,%esp
  800822:	68 e8 26 80 00       	push   $0x8026e8
  800827:	6a 26                	push   $0x26
  800829:	68 34 27 80 00       	push   $0x802734
  80082e:	e8 65 ff ff ff       	call   800798 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800833:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80083a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800841:	e9 c2 00 00 00       	jmp    800908 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800846:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800849:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800850:	8b 45 08             	mov    0x8(%ebp),%eax
  800853:	01 d0                	add    %edx,%eax
  800855:	8b 00                	mov    (%eax),%eax
  800857:	85 c0                	test   %eax,%eax
  800859:	75 08                	jne    800863 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  80085b:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80085e:	e9 a2 00 00 00       	jmp    800905 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800863:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80086a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800871:	eb 69                	jmp    8008dc <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800873:	a1 24 30 80 00       	mov    0x803024,%eax
  800878:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80087e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800881:	89 d0                	mov    %edx,%eax
  800883:	01 c0                	add    %eax,%eax
  800885:	01 d0                	add    %edx,%eax
  800887:	c1 e0 03             	shl    $0x3,%eax
  80088a:	01 c8                	add    %ecx,%eax
  80088c:	8a 40 04             	mov    0x4(%eax),%al
  80088f:	84 c0                	test   %al,%al
  800891:	75 46                	jne    8008d9 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800893:	a1 24 30 80 00       	mov    0x803024,%eax
  800898:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80089e:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008a1:	89 d0                	mov    %edx,%eax
  8008a3:	01 c0                	add    %eax,%eax
  8008a5:	01 d0                	add    %edx,%eax
  8008a7:	c1 e0 03             	shl    $0x3,%eax
  8008aa:	01 c8                	add    %ecx,%eax
  8008ac:	8b 00                	mov    (%eax),%eax
  8008ae:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008b4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008b9:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008be:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c8:	01 c8                	add    %ecx,%eax
  8008ca:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008cc:	39 c2                	cmp    %eax,%edx
  8008ce:	75 09                	jne    8008d9 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008d0:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008d7:	eb 12                	jmp    8008eb <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008d9:	ff 45 e8             	incl   -0x18(%ebp)
  8008dc:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e1:	8b 50 74             	mov    0x74(%eax),%edx
  8008e4:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008e7:	39 c2                	cmp    %eax,%edx
  8008e9:	77 88                	ja     800873 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008eb:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008ef:	75 14                	jne    800905 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008f1:	83 ec 04             	sub    $0x4,%esp
  8008f4:	68 40 27 80 00       	push   $0x802740
  8008f9:	6a 3a                	push   $0x3a
  8008fb:	68 34 27 80 00       	push   $0x802734
  800900:	e8 93 fe ff ff       	call   800798 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800905:	ff 45 f0             	incl   -0x10(%ebp)
  800908:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80090b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80090e:	0f 8c 32 ff ff ff    	jl     800846 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800914:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80091b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800922:	eb 26                	jmp    80094a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800924:	a1 24 30 80 00       	mov    0x803024,%eax
  800929:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80092f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800932:	89 d0                	mov    %edx,%eax
  800934:	01 c0                	add    %eax,%eax
  800936:	01 d0                	add    %edx,%eax
  800938:	c1 e0 03             	shl    $0x3,%eax
  80093b:	01 c8                	add    %ecx,%eax
  80093d:	8a 40 04             	mov    0x4(%eax),%al
  800940:	3c 01                	cmp    $0x1,%al
  800942:	75 03                	jne    800947 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800944:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800947:	ff 45 e0             	incl   -0x20(%ebp)
  80094a:	a1 24 30 80 00       	mov    0x803024,%eax
  80094f:	8b 50 74             	mov    0x74(%eax),%edx
  800952:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800955:	39 c2                	cmp    %eax,%edx
  800957:	77 cb                	ja     800924 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800959:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80095c:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80095f:	74 14                	je     800975 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800961:	83 ec 04             	sub    $0x4,%esp
  800964:	68 94 27 80 00       	push   $0x802794
  800969:	6a 44                	push   $0x44
  80096b:	68 34 27 80 00       	push   $0x802734
  800970:	e8 23 fe ff ff       	call   800798 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800975:	90                   	nop
  800976:	c9                   	leave  
  800977:	c3                   	ret    

00800978 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800978:	55                   	push   %ebp
  800979:	89 e5                	mov    %esp,%ebp
  80097b:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80097e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800981:	8b 00                	mov    (%eax),%eax
  800983:	8d 48 01             	lea    0x1(%eax),%ecx
  800986:	8b 55 0c             	mov    0xc(%ebp),%edx
  800989:	89 0a                	mov    %ecx,(%edx)
  80098b:	8b 55 08             	mov    0x8(%ebp),%edx
  80098e:	88 d1                	mov    %dl,%cl
  800990:	8b 55 0c             	mov    0xc(%ebp),%edx
  800993:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800997:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099a:	8b 00                	mov    (%eax),%eax
  80099c:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009a1:	75 2c                	jne    8009cf <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009a3:	a0 28 30 80 00       	mov    0x803028,%al
  8009a8:	0f b6 c0             	movzbl %al,%eax
  8009ab:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ae:	8b 12                	mov    (%edx),%edx
  8009b0:	89 d1                	mov    %edx,%ecx
  8009b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009b5:	83 c2 08             	add    $0x8,%edx
  8009b8:	83 ec 04             	sub    $0x4,%esp
  8009bb:	50                   	push   %eax
  8009bc:	51                   	push   %ecx
  8009bd:	52                   	push   %edx
  8009be:	e8 f5 11 00 00       	call   801bb8 <sys_cputs>
  8009c3:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d2:	8b 40 04             	mov    0x4(%eax),%eax
  8009d5:	8d 50 01             	lea    0x1(%eax),%edx
  8009d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009db:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009de:	90                   	nop
  8009df:	c9                   	leave  
  8009e0:	c3                   	ret    

008009e1 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009e1:	55                   	push   %ebp
  8009e2:	89 e5                	mov    %esp,%ebp
  8009e4:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009ea:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009f1:	00 00 00 
	b.cnt = 0;
  8009f4:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009fb:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009fe:	ff 75 0c             	pushl  0xc(%ebp)
  800a01:	ff 75 08             	pushl  0x8(%ebp)
  800a04:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a0a:	50                   	push   %eax
  800a0b:	68 78 09 80 00       	push   $0x800978
  800a10:	e8 11 02 00 00       	call   800c26 <vprintfmt>
  800a15:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a18:	a0 28 30 80 00       	mov    0x803028,%al
  800a1d:	0f b6 c0             	movzbl %al,%eax
  800a20:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a26:	83 ec 04             	sub    $0x4,%esp
  800a29:	50                   	push   %eax
  800a2a:	52                   	push   %edx
  800a2b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a31:	83 c0 08             	add    $0x8,%eax
  800a34:	50                   	push   %eax
  800a35:	e8 7e 11 00 00       	call   801bb8 <sys_cputs>
  800a3a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a3d:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a44:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a4a:	c9                   	leave  
  800a4b:	c3                   	ret    

00800a4c <cprintf>:

int cprintf(const char *fmt, ...) {
  800a4c:	55                   	push   %ebp
  800a4d:	89 e5                	mov    %esp,%ebp
  800a4f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a52:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a59:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a5c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800a62:	83 ec 08             	sub    $0x8,%esp
  800a65:	ff 75 f4             	pushl  -0xc(%ebp)
  800a68:	50                   	push   %eax
  800a69:	e8 73 ff ff ff       	call   8009e1 <vcprintf>
  800a6e:	83 c4 10             	add    $0x10,%esp
  800a71:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a74:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a77:	c9                   	leave  
  800a78:	c3                   	ret    

00800a79 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a79:	55                   	push   %ebp
  800a7a:	89 e5                	mov    %esp,%ebp
  800a7c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a7f:	e8 45 13 00 00       	call   801dc9 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a84:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a87:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a8d:	83 ec 08             	sub    $0x8,%esp
  800a90:	ff 75 f4             	pushl  -0xc(%ebp)
  800a93:	50                   	push   %eax
  800a94:	e8 48 ff ff ff       	call   8009e1 <vcprintf>
  800a99:	83 c4 10             	add    $0x10,%esp
  800a9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a9f:	e8 3f 13 00 00       	call   801de3 <sys_enable_interrupt>
	return cnt;
  800aa4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800aa7:	c9                   	leave  
  800aa8:	c3                   	ret    

00800aa9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800aa9:	55                   	push   %ebp
  800aaa:	89 e5                	mov    %esp,%ebp
  800aac:	53                   	push   %ebx
  800aad:	83 ec 14             	sub    $0x14,%esp
  800ab0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ab3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ab6:	8b 45 14             	mov    0x14(%ebp),%eax
  800ab9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800abc:	8b 45 18             	mov    0x18(%ebp),%eax
  800abf:	ba 00 00 00 00       	mov    $0x0,%edx
  800ac4:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ac7:	77 55                	ja     800b1e <printnum+0x75>
  800ac9:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800acc:	72 05                	jb     800ad3 <printnum+0x2a>
  800ace:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800ad1:	77 4b                	ja     800b1e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800ad3:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800ad6:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ad9:	8b 45 18             	mov    0x18(%ebp),%eax
  800adc:	ba 00 00 00 00       	mov    $0x0,%edx
  800ae1:	52                   	push   %edx
  800ae2:	50                   	push   %eax
  800ae3:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae6:	ff 75 f0             	pushl  -0x10(%ebp)
  800ae9:	e8 1a 17 00 00       	call   802208 <__udivdi3>
  800aee:	83 c4 10             	add    $0x10,%esp
  800af1:	83 ec 04             	sub    $0x4,%esp
  800af4:	ff 75 20             	pushl  0x20(%ebp)
  800af7:	53                   	push   %ebx
  800af8:	ff 75 18             	pushl  0x18(%ebp)
  800afb:	52                   	push   %edx
  800afc:	50                   	push   %eax
  800afd:	ff 75 0c             	pushl  0xc(%ebp)
  800b00:	ff 75 08             	pushl  0x8(%ebp)
  800b03:	e8 a1 ff ff ff       	call   800aa9 <printnum>
  800b08:	83 c4 20             	add    $0x20,%esp
  800b0b:	eb 1a                	jmp    800b27 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b0d:	83 ec 08             	sub    $0x8,%esp
  800b10:	ff 75 0c             	pushl  0xc(%ebp)
  800b13:	ff 75 20             	pushl  0x20(%ebp)
  800b16:	8b 45 08             	mov    0x8(%ebp),%eax
  800b19:	ff d0                	call   *%eax
  800b1b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b1e:	ff 4d 1c             	decl   0x1c(%ebp)
  800b21:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b25:	7f e6                	jg     800b0d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b27:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b2a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b32:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b35:	53                   	push   %ebx
  800b36:	51                   	push   %ecx
  800b37:	52                   	push   %edx
  800b38:	50                   	push   %eax
  800b39:	e8 da 17 00 00       	call   802318 <__umoddi3>
  800b3e:	83 c4 10             	add    $0x10,%esp
  800b41:	05 f4 29 80 00       	add    $0x8029f4,%eax
  800b46:	8a 00                	mov    (%eax),%al
  800b48:	0f be c0             	movsbl %al,%eax
  800b4b:	83 ec 08             	sub    $0x8,%esp
  800b4e:	ff 75 0c             	pushl  0xc(%ebp)
  800b51:	50                   	push   %eax
  800b52:	8b 45 08             	mov    0x8(%ebp),%eax
  800b55:	ff d0                	call   *%eax
  800b57:	83 c4 10             	add    $0x10,%esp
}
  800b5a:	90                   	nop
  800b5b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b5e:	c9                   	leave  
  800b5f:	c3                   	ret    

00800b60 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b60:	55                   	push   %ebp
  800b61:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b63:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b67:	7e 1c                	jle    800b85 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b69:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6c:	8b 00                	mov    (%eax),%eax
  800b6e:	8d 50 08             	lea    0x8(%eax),%edx
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	89 10                	mov    %edx,(%eax)
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
  800b79:	8b 00                	mov    (%eax),%eax
  800b7b:	83 e8 08             	sub    $0x8,%eax
  800b7e:	8b 50 04             	mov    0x4(%eax),%edx
  800b81:	8b 00                	mov    (%eax),%eax
  800b83:	eb 40                	jmp    800bc5 <getuint+0x65>
	else if (lflag)
  800b85:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b89:	74 1e                	je     800ba9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8e:	8b 00                	mov    (%eax),%eax
  800b90:	8d 50 04             	lea    0x4(%eax),%edx
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
  800b96:	89 10                	mov    %edx,(%eax)
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	8b 00                	mov    (%eax),%eax
  800b9d:	83 e8 04             	sub    $0x4,%eax
  800ba0:	8b 00                	mov    (%eax),%eax
  800ba2:	ba 00 00 00 00       	mov    $0x0,%edx
  800ba7:	eb 1c                	jmp    800bc5 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bac:	8b 00                	mov    (%eax),%eax
  800bae:	8d 50 04             	lea    0x4(%eax),%edx
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	89 10                	mov    %edx,(%eax)
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb9:	8b 00                	mov    (%eax),%eax
  800bbb:	83 e8 04             	sub    $0x4,%eax
  800bbe:	8b 00                	mov    (%eax),%eax
  800bc0:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800bc5:	5d                   	pop    %ebp
  800bc6:	c3                   	ret    

00800bc7 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800bc7:	55                   	push   %ebp
  800bc8:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bca:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bce:	7e 1c                	jle    800bec <getint+0x25>
		return va_arg(*ap, long long);
  800bd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd3:	8b 00                	mov    (%eax),%eax
  800bd5:	8d 50 08             	lea    0x8(%eax),%edx
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	89 10                	mov    %edx,(%eax)
  800bdd:	8b 45 08             	mov    0x8(%ebp),%eax
  800be0:	8b 00                	mov    (%eax),%eax
  800be2:	83 e8 08             	sub    $0x8,%eax
  800be5:	8b 50 04             	mov    0x4(%eax),%edx
  800be8:	8b 00                	mov    (%eax),%eax
  800bea:	eb 38                	jmp    800c24 <getint+0x5d>
	else if (lflag)
  800bec:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bf0:	74 1a                	je     800c0c <getint+0x45>
		return va_arg(*ap, long);
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	8b 00                	mov    (%eax),%eax
  800bf7:	8d 50 04             	lea    0x4(%eax),%edx
  800bfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfd:	89 10                	mov    %edx,(%eax)
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	8b 00                	mov    (%eax),%eax
  800c04:	83 e8 04             	sub    $0x4,%eax
  800c07:	8b 00                	mov    (%eax),%eax
  800c09:	99                   	cltd   
  800c0a:	eb 18                	jmp    800c24 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	8b 00                	mov    (%eax),%eax
  800c11:	8d 50 04             	lea    0x4(%eax),%edx
  800c14:	8b 45 08             	mov    0x8(%ebp),%eax
  800c17:	89 10                	mov    %edx,(%eax)
  800c19:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1c:	8b 00                	mov    (%eax),%eax
  800c1e:	83 e8 04             	sub    $0x4,%eax
  800c21:	8b 00                	mov    (%eax),%eax
  800c23:	99                   	cltd   
}
  800c24:	5d                   	pop    %ebp
  800c25:	c3                   	ret    

00800c26 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	56                   	push   %esi
  800c2a:	53                   	push   %ebx
  800c2b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c2e:	eb 17                	jmp    800c47 <vprintfmt+0x21>
			if (ch == '\0')
  800c30:	85 db                	test   %ebx,%ebx
  800c32:	0f 84 af 03 00 00    	je     800fe7 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c38:	83 ec 08             	sub    $0x8,%esp
  800c3b:	ff 75 0c             	pushl  0xc(%ebp)
  800c3e:	53                   	push   %ebx
  800c3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c42:	ff d0                	call   *%eax
  800c44:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c47:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4a:	8d 50 01             	lea    0x1(%eax),%edx
  800c4d:	89 55 10             	mov    %edx,0x10(%ebp)
  800c50:	8a 00                	mov    (%eax),%al
  800c52:	0f b6 d8             	movzbl %al,%ebx
  800c55:	83 fb 25             	cmp    $0x25,%ebx
  800c58:	75 d6                	jne    800c30 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c5a:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c5e:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c65:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c6c:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c73:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c7d:	8d 50 01             	lea    0x1(%eax),%edx
  800c80:	89 55 10             	mov    %edx,0x10(%ebp)
  800c83:	8a 00                	mov    (%eax),%al
  800c85:	0f b6 d8             	movzbl %al,%ebx
  800c88:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c8b:	83 f8 55             	cmp    $0x55,%eax
  800c8e:	0f 87 2b 03 00 00    	ja     800fbf <vprintfmt+0x399>
  800c94:	8b 04 85 18 2a 80 00 	mov    0x802a18(,%eax,4),%eax
  800c9b:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c9d:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800ca1:	eb d7                	jmp    800c7a <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800ca3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800ca7:	eb d1                	jmp    800c7a <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ca9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cb0:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cb3:	89 d0                	mov    %edx,%eax
  800cb5:	c1 e0 02             	shl    $0x2,%eax
  800cb8:	01 d0                	add    %edx,%eax
  800cba:	01 c0                	add    %eax,%eax
  800cbc:	01 d8                	add    %ebx,%eax
  800cbe:	83 e8 30             	sub    $0x30,%eax
  800cc1:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800cc4:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc7:	8a 00                	mov    (%eax),%al
  800cc9:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ccc:	83 fb 2f             	cmp    $0x2f,%ebx
  800ccf:	7e 3e                	jle    800d0f <vprintfmt+0xe9>
  800cd1:	83 fb 39             	cmp    $0x39,%ebx
  800cd4:	7f 39                	jg     800d0f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cd6:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cd9:	eb d5                	jmp    800cb0 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cdb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cde:	83 c0 04             	add    $0x4,%eax
  800ce1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ce4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce7:	83 e8 04             	sub    $0x4,%eax
  800cea:	8b 00                	mov    (%eax),%eax
  800cec:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cef:	eb 1f                	jmp    800d10 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cf1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cf5:	79 83                	jns    800c7a <vprintfmt+0x54>
				width = 0;
  800cf7:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cfe:	e9 77 ff ff ff       	jmp    800c7a <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d03:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d0a:	e9 6b ff ff ff       	jmp    800c7a <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d0f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d10:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d14:	0f 89 60 ff ff ff    	jns    800c7a <vprintfmt+0x54>
				width = precision, precision = -1;
  800d1a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d1d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d20:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d27:	e9 4e ff ff ff       	jmp    800c7a <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d2c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d2f:	e9 46 ff ff ff       	jmp    800c7a <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d34:	8b 45 14             	mov    0x14(%ebp),%eax
  800d37:	83 c0 04             	add    $0x4,%eax
  800d3a:	89 45 14             	mov    %eax,0x14(%ebp)
  800d3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d40:	83 e8 04             	sub    $0x4,%eax
  800d43:	8b 00                	mov    (%eax),%eax
  800d45:	83 ec 08             	sub    $0x8,%esp
  800d48:	ff 75 0c             	pushl  0xc(%ebp)
  800d4b:	50                   	push   %eax
  800d4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4f:	ff d0                	call   *%eax
  800d51:	83 c4 10             	add    $0x10,%esp
			break;
  800d54:	e9 89 02 00 00       	jmp    800fe2 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d59:	8b 45 14             	mov    0x14(%ebp),%eax
  800d5c:	83 c0 04             	add    $0x4,%eax
  800d5f:	89 45 14             	mov    %eax,0x14(%ebp)
  800d62:	8b 45 14             	mov    0x14(%ebp),%eax
  800d65:	83 e8 04             	sub    $0x4,%eax
  800d68:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d6a:	85 db                	test   %ebx,%ebx
  800d6c:	79 02                	jns    800d70 <vprintfmt+0x14a>
				err = -err;
  800d6e:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d70:	83 fb 64             	cmp    $0x64,%ebx
  800d73:	7f 0b                	jg     800d80 <vprintfmt+0x15a>
  800d75:	8b 34 9d 60 28 80 00 	mov    0x802860(,%ebx,4),%esi
  800d7c:	85 f6                	test   %esi,%esi
  800d7e:	75 19                	jne    800d99 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d80:	53                   	push   %ebx
  800d81:	68 05 2a 80 00       	push   $0x802a05
  800d86:	ff 75 0c             	pushl  0xc(%ebp)
  800d89:	ff 75 08             	pushl  0x8(%ebp)
  800d8c:	e8 5e 02 00 00       	call   800fef <printfmt>
  800d91:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d94:	e9 49 02 00 00       	jmp    800fe2 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d99:	56                   	push   %esi
  800d9a:	68 0e 2a 80 00       	push   $0x802a0e
  800d9f:	ff 75 0c             	pushl  0xc(%ebp)
  800da2:	ff 75 08             	pushl  0x8(%ebp)
  800da5:	e8 45 02 00 00       	call   800fef <printfmt>
  800daa:	83 c4 10             	add    $0x10,%esp
			break;
  800dad:	e9 30 02 00 00       	jmp    800fe2 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800db2:	8b 45 14             	mov    0x14(%ebp),%eax
  800db5:	83 c0 04             	add    $0x4,%eax
  800db8:	89 45 14             	mov    %eax,0x14(%ebp)
  800dbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800dbe:	83 e8 04             	sub    $0x4,%eax
  800dc1:	8b 30                	mov    (%eax),%esi
  800dc3:	85 f6                	test   %esi,%esi
  800dc5:	75 05                	jne    800dcc <vprintfmt+0x1a6>
				p = "(null)";
  800dc7:	be 11 2a 80 00       	mov    $0x802a11,%esi
			if (width > 0 && padc != '-')
  800dcc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd0:	7e 6d                	jle    800e3f <vprintfmt+0x219>
  800dd2:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800dd6:	74 67                	je     800e3f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800dd8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ddb:	83 ec 08             	sub    $0x8,%esp
  800dde:	50                   	push   %eax
  800ddf:	56                   	push   %esi
  800de0:	e8 12 05 00 00       	call   8012f7 <strnlen>
  800de5:	83 c4 10             	add    $0x10,%esp
  800de8:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800deb:	eb 16                	jmp    800e03 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800ded:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800df1:	83 ec 08             	sub    $0x8,%esp
  800df4:	ff 75 0c             	pushl  0xc(%ebp)
  800df7:	50                   	push   %eax
  800df8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfb:	ff d0                	call   *%eax
  800dfd:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e00:	ff 4d e4             	decl   -0x1c(%ebp)
  800e03:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e07:	7f e4                	jg     800ded <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e09:	eb 34                	jmp    800e3f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e0b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e0f:	74 1c                	je     800e2d <vprintfmt+0x207>
  800e11:	83 fb 1f             	cmp    $0x1f,%ebx
  800e14:	7e 05                	jle    800e1b <vprintfmt+0x1f5>
  800e16:	83 fb 7e             	cmp    $0x7e,%ebx
  800e19:	7e 12                	jle    800e2d <vprintfmt+0x207>
					putch('?', putdat);
  800e1b:	83 ec 08             	sub    $0x8,%esp
  800e1e:	ff 75 0c             	pushl  0xc(%ebp)
  800e21:	6a 3f                	push   $0x3f
  800e23:	8b 45 08             	mov    0x8(%ebp),%eax
  800e26:	ff d0                	call   *%eax
  800e28:	83 c4 10             	add    $0x10,%esp
  800e2b:	eb 0f                	jmp    800e3c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e2d:	83 ec 08             	sub    $0x8,%esp
  800e30:	ff 75 0c             	pushl  0xc(%ebp)
  800e33:	53                   	push   %ebx
  800e34:	8b 45 08             	mov    0x8(%ebp),%eax
  800e37:	ff d0                	call   *%eax
  800e39:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e3c:	ff 4d e4             	decl   -0x1c(%ebp)
  800e3f:	89 f0                	mov    %esi,%eax
  800e41:	8d 70 01             	lea    0x1(%eax),%esi
  800e44:	8a 00                	mov    (%eax),%al
  800e46:	0f be d8             	movsbl %al,%ebx
  800e49:	85 db                	test   %ebx,%ebx
  800e4b:	74 24                	je     800e71 <vprintfmt+0x24b>
  800e4d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e51:	78 b8                	js     800e0b <vprintfmt+0x1e5>
  800e53:	ff 4d e0             	decl   -0x20(%ebp)
  800e56:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e5a:	79 af                	jns    800e0b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e5c:	eb 13                	jmp    800e71 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e5e:	83 ec 08             	sub    $0x8,%esp
  800e61:	ff 75 0c             	pushl  0xc(%ebp)
  800e64:	6a 20                	push   $0x20
  800e66:	8b 45 08             	mov    0x8(%ebp),%eax
  800e69:	ff d0                	call   *%eax
  800e6b:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e6e:	ff 4d e4             	decl   -0x1c(%ebp)
  800e71:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e75:	7f e7                	jg     800e5e <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e77:	e9 66 01 00 00       	jmp    800fe2 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e7c:	83 ec 08             	sub    $0x8,%esp
  800e7f:	ff 75 e8             	pushl  -0x18(%ebp)
  800e82:	8d 45 14             	lea    0x14(%ebp),%eax
  800e85:	50                   	push   %eax
  800e86:	e8 3c fd ff ff       	call   800bc7 <getint>
  800e8b:	83 c4 10             	add    $0x10,%esp
  800e8e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e91:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e94:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e97:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e9a:	85 d2                	test   %edx,%edx
  800e9c:	79 23                	jns    800ec1 <vprintfmt+0x29b>
				putch('-', putdat);
  800e9e:	83 ec 08             	sub    $0x8,%esp
  800ea1:	ff 75 0c             	pushl  0xc(%ebp)
  800ea4:	6a 2d                	push   $0x2d
  800ea6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea9:	ff d0                	call   *%eax
  800eab:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800eae:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800eb1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eb4:	f7 d8                	neg    %eax
  800eb6:	83 d2 00             	adc    $0x0,%edx
  800eb9:	f7 da                	neg    %edx
  800ebb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ec1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ec8:	e9 bc 00 00 00       	jmp    800f89 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ecd:	83 ec 08             	sub    $0x8,%esp
  800ed0:	ff 75 e8             	pushl  -0x18(%ebp)
  800ed3:	8d 45 14             	lea    0x14(%ebp),%eax
  800ed6:	50                   	push   %eax
  800ed7:	e8 84 fc ff ff       	call   800b60 <getuint>
  800edc:	83 c4 10             	add    $0x10,%esp
  800edf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee2:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ee5:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800eec:	e9 98 00 00 00       	jmp    800f89 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ef1:	83 ec 08             	sub    $0x8,%esp
  800ef4:	ff 75 0c             	pushl  0xc(%ebp)
  800ef7:	6a 58                	push   $0x58
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	ff d0                	call   *%eax
  800efe:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f01:	83 ec 08             	sub    $0x8,%esp
  800f04:	ff 75 0c             	pushl  0xc(%ebp)
  800f07:	6a 58                	push   $0x58
  800f09:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0c:	ff d0                	call   *%eax
  800f0e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f11:	83 ec 08             	sub    $0x8,%esp
  800f14:	ff 75 0c             	pushl  0xc(%ebp)
  800f17:	6a 58                	push   $0x58
  800f19:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1c:	ff d0                	call   *%eax
  800f1e:	83 c4 10             	add    $0x10,%esp
			break;
  800f21:	e9 bc 00 00 00       	jmp    800fe2 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f26:	83 ec 08             	sub    $0x8,%esp
  800f29:	ff 75 0c             	pushl  0xc(%ebp)
  800f2c:	6a 30                	push   $0x30
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	ff d0                	call   *%eax
  800f33:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f36:	83 ec 08             	sub    $0x8,%esp
  800f39:	ff 75 0c             	pushl  0xc(%ebp)
  800f3c:	6a 78                	push   $0x78
  800f3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f41:	ff d0                	call   *%eax
  800f43:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f46:	8b 45 14             	mov    0x14(%ebp),%eax
  800f49:	83 c0 04             	add    $0x4,%eax
  800f4c:	89 45 14             	mov    %eax,0x14(%ebp)
  800f4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f52:	83 e8 04             	sub    $0x4,%eax
  800f55:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f57:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f5a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f61:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f68:	eb 1f                	jmp    800f89 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f6a:	83 ec 08             	sub    $0x8,%esp
  800f6d:	ff 75 e8             	pushl  -0x18(%ebp)
  800f70:	8d 45 14             	lea    0x14(%ebp),%eax
  800f73:	50                   	push   %eax
  800f74:	e8 e7 fb ff ff       	call   800b60 <getuint>
  800f79:	83 c4 10             	add    $0x10,%esp
  800f7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f7f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f82:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f89:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f8d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f90:	83 ec 04             	sub    $0x4,%esp
  800f93:	52                   	push   %edx
  800f94:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f97:	50                   	push   %eax
  800f98:	ff 75 f4             	pushl  -0xc(%ebp)
  800f9b:	ff 75 f0             	pushl  -0x10(%ebp)
  800f9e:	ff 75 0c             	pushl  0xc(%ebp)
  800fa1:	ff 75 08             	pushl  0x8(%ebp)
  800fa4:	e8 00 fb ff ff       	call   800aa9 <printnum>
  800fa9:	83 c4 20             	add    $0x20,%esp
			break;
  800fac:	eb 34                	jmp    800fe2 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fae:	83 ec 08             	sub    $0x8,%esp
  800fb1:	ff 75 0c             	pushl  0xc(%ebp)
  800fb4:	53                   	push   %ebx
  800fb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb8:	ff d0                	call   *%eax
  800fba:	83 c4 10             	add    $0x10,%esp
			break;
  800fbd:	eb 23                	jmp    800fe2 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fbf:	83 ec 08             	sub    $0x8,%esp
  800fc2:	ff 75 0c             	pushl  0xc(%ebp)
  800fc5:	6a 25                	push   $0x25
  800fc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800fca:	ff d0                	call   *%eax
  800fcc:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fcf:	ff 4d 10             	decl   0x10(%ebp)
  800fd2:	eb 03                	jmp    800fd7 <vprintfmt+0x3b1>
  800fd4:	ff 4d 10             	decl   0x10(%ebp)
  800fd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fda:	48                   	dec    %eax
  800fdb:	8a 00                	mov    (%eax),%al
  800fdd:	3c 25                	cmp    $0x25,%al
  800fdf:	75 f3                	jne    800fd4 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fe1:	90                   	nop
		}
	}
  800fe2:	e9 47 fc ff ff       	jmp    800c2e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fe7:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fe8:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800feb:	5b                   	pop    %ebx
  800fec:	5e                   	pop    %esi
  800fed:	5d                   	pop    %ebp
  800fee:	c3                   	ret    

00800fef <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fef:	55                   	push   %ebp
  800ff0:	89 e5                	mov    %esp,%ebp
  800ff2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ff5:	8d 45 10             	lea    0x10(%ebp),%eax
  800ff8:	83 c0 04             	add    $0x4,%eax
  800ffb:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800ffe:	8b 45 10             	mov    0x10(%ebp),%eax
  801001:	ff 75 f4             	pushl  -0xc(%ebp)
  801004:	50                   	push   %eax
  801005:	ff 75 0c             	pushl  0xc(%ebp)
  801008:	ff 75 08             	pushl  0x8(%ebp)
  80100b:	e8 16 fc ff ff       	call   800c26 <vprintfmt>
  801010:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801013:	90                   	nop
  801014:	c9                   	leave  
  801015:	c3                   	ret    

00801016 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801016:	55                   	push   %ebp
  801017:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801019:	8b 45 0c             	mov    0xc(%ebp),%eax
  80101c:	8b 40 08             	mov    0x8(%eax),%eax
  80101f:	8d 50 01             	lea    0x1(%eax),%edx
  801022:	8b 45 0c             	mov    0xc(%ebp),%eax
  801025:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801028:	8b 45 0c             	mov    0xc(%ebp),%eax
  80102b:	8b 10                	mov    (%eax),%edx
  80102d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801030:	8b 40 04             	mov    0x4(%eax),%eax
  801033:	39 c2                	cmp    %eax,%edx
  801035:	73 12                	jae    801049 <sprintputch+0x33>
		*b->buf++ = ch;
  801037:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103a:	8b 00                	mov    (%eax),%eax
  80103c:	8d 48 01             	lea    0x1(%eax),%ecx
  80103f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801042:	89 0a                	mov    %ecx,(%edx)
  801044:	8b 55 08             	mov    0x8(%ebp),%edx
  801047:	88 10                	mov    %dl,(%eax)
}
  801049:	90                   	nop
  80104a:	5d                   	pop    %ebp
  80104b:	c3                   	ret    

0080104c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80104c:	55                   	push   %ebp
  80104d:	89 e5                	mov    %esp,%ebp
  80104f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801058:	8b 45 0c             	mov    0xc(%ebp),%eax
  80105b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	01 d0                	add    %edx,%eax
  801063:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801066:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80106d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801071:	74 06                	je     801079 <vsnprintf+0x2d>
  801073:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801077:	7f 07                	jg     801080 <vsnprintf+0x34>
		return -E_INVAL;
  801079:	b8 03 00 00 00       	mov    $0x3,%eax
  80107e:	eb 20                	jmp    8010a0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801080:	ff 75 14             	pushl  0x14(%ebp)
  801083:	ff 75 10             	pushl  0x10(%ebp)
  801086:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801089:	50                   	push   %eax
  80108a:	68 16 10 80 00       	push   $0x801016
  80108f:	e8 92 fb ff ff       	call   800c26 <vprintfmt>
  801094:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801097:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80109a:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80109d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010a0:	c9                   	leave  
  8010a1:	c3                   	ret    

008010a2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010a2:	55                   	push   %ebp
  8010a3:	89 e5                	mov    %esp,%ebp
  8010a5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010a8:	8d 45 10             	lea    0x10(%ebp),%eax
  8010ab:	83 c0 04             	add    $0x4,%eax
  8010ae:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b4:	ff 75 f4             	pushl  -0xc(%ebp)
  8010b7:	50                   	push   %eax
  8010b8:	ff 75 0c             	pushl  0xc(%ebp)
  8010bb:	ff 75 08             	pushl  0x8(%ebp)
  8010be:	e8 89 ff ff ff       	call   80104c <vsnprintf>
  8010c3:	83 c4 10             	add    $0x10,%esp
  8010c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010cc:	c9                   	leave  
  8010cd:	c3                   	ret    

008010ce <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010ce:	55                   	push   %ebp
  8010cf:	89 e5                	mov    %esp,%ebp
  8010d1:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010d8:	74 13                	je     8010ed <readline+0x1f>
		cprintf("%s", prompt);
  8010da:	83 ec 08             	sub    $0x8,%esp
  8010dd:	ff 75 08             	pushl  0x8(%ebp)
  8010e0:	68 70 2b 80 00       	push   $0x802b70
  8010e5:	e8 62 f9 ff ff       	call   800a4c <cprintf>
  8010ea:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010ed:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010f4:	83 ec 0c             	sub    $0xc,%esp
  8010f7:	6a 00                	push   $0x0
  8010f9:	e8 74 f5 ff ff       	call   800672 <iscons>
  8010fe:	83 c4 10             	add    $0x10,%esp
  801101:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801104:	e8 1b f5 ff ff       	call   800624 <getchar>
  801109:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80110c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801110:	79 22                	jns    801134 <readline+0x66>
			if (c != -E_EOF)
  801112:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801116:	0f 84 ad 00 00 00    	je     8011c9 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80111c:	83 ec 08             	sub    $0x8,%esp
  80111f:	ff 75 ec             	pushl  -0x14(%ebp)
  801122:	68 73 2b 80 00       	push   $0x802b73
  801127:	e8 20 f9 ff ff       	call   800a4c <cprintf>
  80112c:	83 c4 10             	add    $0x10,%esp
			return;
  80112f:	e9 95 00 00 00       	jmp    8011c9 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801134:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801138:	7e 34                	jle    80116e <readline+0xa0>
  80113a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801141:	7f 2b                	jg     80116e <readline+0xa0>
			if (echoing)
  801143:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801147:	74 0e                	je     801157 <readline+0x89>
				cputchar(c);
  801149:	83 ec 0c             	sub    $0xc,%esp
  80114c:	ff 75 ec             	pushl  -0x14(%ebp)
  80114f:	e8 88 f4 ff ff       	call   8005dc <cputchar>
  801154:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801157:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80115a:	8d 50 01             	lea    0x1(%eax),%edx
  80115d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801160:	89 c2                	mov    %eax,%edx
  801162:	8b 45 0c             	mov    0xc(%ebp),%eax
  801165:	01 d0                	add    %edx,%eax
  801167:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80116a:	88 10                	mov    %dl,(%eax)
  80116c:	eb 56                	jmp    8011c4 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80116e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801172:	75 1f                	jne    801193 <readline+0xc5>
  801174:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801178:	7e 19                	jle    801193 <readline+0xc5>
			if (echoing)
  80117a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80117e:	74 0e                	je     80118e <readline+0xc0>
				cputchar(c);
  801180:	83 ec 0c             	sub    $0xc,%esp
  801183:	ff 75 ec             	pushl  -0x14(%ebp)
  801186:	e8 51 f4 ff ff       	call   8005dc <cputchar>
  80118b:	83 c4 10             	add    $0x10,%esp

			i--;
  80118e:	ff 4d f4             	decl   -0xc(%ebp)
  801191:	eb 31                	jmp    8011c4 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801193:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801197:	74 0a                	je     8011a3 <readline+0xd5>
  801199:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80119d:	0f 85 61 ff ff ff    	jne    801104 <readline+0x36>
			if (echoing)
  8011a3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011a7:	74 0e                	je     8011b7 <readline+0xe9>
				cputchar(c);
  8011a9:	83 ec 0c             	sub    $0xc,%esp
  8011ac:	ff 75 ec             	pushl  -0x14(%ebp)
  8011af:	e8 28 f4 ff ff       	call   8005dc <cputchar>
  8011b4:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bd:	01 d0                	add    %edx,%eax
  8011bf:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011c2:	eb 06                	jmp    8011ca <readline+0xfc>
		}
	}
  8011c4:	e9 3b ff ff ff       	jmp    801104 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011c9:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011ca:	c9                   	leave  
  8011cb:	c3                   	ret    

008011cc <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011cc:	55                   	push   %ebp
  8011cd:	89 e5                	mov    %esp,%ebp
  8011cf:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011d2:	e8 f2 0b 00 00       	call   801dc9 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011db:	74 13                	je     8011f0 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011dd:	83 ec 08             	sub    $0x8,%esp
  8011e0:	ff 75 08             	pushl  0x8(%ebp)
  8011e3:	68 70 2b 80 00       	push   $0x802b70
  8011e8:	e8 5f f8 ff ff       	call   800a4c <cprintf>
  8011ed:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011f7:	83 ec 0c             	sub    $0xc,%esp
  8011fa:	6a 00                	push   $0x0
  8011fc:	e8 71 f4 ff ff       	call   800672 <iscons>
  801201:	83 c4 10             	add    $0x10,%esp
  801204:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801207:	e8 18 f4 ff ff       	call   800624 <getchar>
  80120c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80120f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801213:	79 23                	jns    801238 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801215:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801219:	74 13                	je     80122e <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80121b:	83 ec 08             	sub    $0x8,%esp
  80121e:	ff 75 ec             	pushl  -0x14(%ebp)
  801221:	68 73 2b 80 00       	push   $0x802b73
  801226:	e8 21 f8 ff ff       	call   800a4c <cprintf>
  80122b:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80122e:	e8 b0 0b 00 00       	call   801de3 <sys_enable_interrupt>
			return;
  801233:	e9 9a 00 00 00       	jmp    8012d2 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801238:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80123c:	7e 34                	jle    801272 <atomic_readline+0xa6>
  80123e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801245:	7f 2b                	jg     801272 <atomic_readline+0xa6>
			if (echoing)
  801247:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80124b:	74 0e                	je     80125b <atomic_readline+0x8f>
				cputchar(c);
  80124d:	83 ec 0c             	sub    $0xc,%esp
  801250:	ff 75 ec             	pushl  -0x14(%ebp)
  801253:	e8 84 f3 ff ff       	call   8005dc <cputchar>
  801258:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80125b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80125e:	8d 50 01             	lea    0x1(%eax),%edx
  801261:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801264:	89 c2                	mov    %eax,%edx
  801266:	8b 45 0c             	mov    0xc(%ebp),%eax
  801269:	01 d0                	add    %edx,%eax
  80126b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80126e:	88 10                	mov    %dl,(%eax)
  801270:	eb 5b                	jmp    8012cd <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  801272:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801276:	75 1f                	jne    801297 <atomic_readline+0xcb>
  801278:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80127c:	7e 19                	jle    801297 <atomic_readline+0xcb>
			if (echoing)
  80127e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801282:	74 0e                	je     801292 <atomic_readline+0xc6>
				cputchar(c);
  801284:	83 ec 0c             	sub    $0xc,%esp
  801287:	ff 75 ec             	pushl  -0x14(%ebp)
  80128a:	e8 4d f3 ff ff       	call   8005dc <cputchar>
  80128f:	83 c4 10             	add    $0x10,%esp
			i--;
  801292:	ff 4d f4             	decl   -0xc(%ebp)
  801295:	eb 36                	jmp    8012cd <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801297:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80129b:	74 0a                	je     8012a7 <atomic_readline+0xdb>
  80129d:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012a1:	0f 85 60 ff ff ff    	jne    801207 <atomic_readline+0x3b>
			if (echoing)
  8012a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012ab:	74 0e                	je     8012bb <atomic_readline+0xef>
				cputchar(c);
  8012ad:	83 ec 0c             	sub    $0xc,%esp
  8012b0:	ff 75 ec             	pushl  -0x14(%ebp)
  8012b3:	e8 24 f3 ff ff       	call   8005dc <cputchar>
  8012b8:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012bb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012be:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c1:	01 d0                	add    %edx,%eax
  8012c3:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012c6:	e8 18 0b 00 00       	call   801de3 <sys_enable_interrupt>
			return;
  8012cb:	eb 05                	jmp    8012d2 <atomic_readline+0x106>
		}
	}
  8012cd:	e9 35 ff ff ff       	jmp    801207 <atomic_readline+0x3b>
}
  8012d2:	c9                   	leave  
  8012d3:	c3                   	ret    

008012d4 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012d4:	55                   	push   %ebp
  8012d5:	89 e5                	mov    %esp,%ebp
  8012d7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012da:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012e1:	eb 06                	jmp    8012e9 <strlen+0x15>
		n++;
  8012e3:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012e6:	ff 45 08             	incl   0x8(%ebp)
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	84 c0                	test   %al,%al
  8012f0:	75 f1                	jne    8012e3 <strlen+0xf>
		n++;
	return n;
  8012f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012f5:	c9                   	leave  
  8012f6:	c3                   	ret    

008012f7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012f7:	55                   	push   %ebp
  8012f8:	89 e5                	mov    %esp,%ebp
  8012fa:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801304:	eb 09                	jmp    80130f <strnlen+0x18>
		n++;
  801306:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801309:	ff 45 08             	incl   0x8(%ebp)
  80130c:	ff 4d 0c             	decl   0xc(%ebp)
  80130f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801313:	74 09                	je     80131e <strnlen+0x27>
  801315:	8b 45 08             	mov    0x8(%ebp),%eax
  801318:	8a 00                	mov    (%eax),%al
  80131a:	84 c0                	test   %al,%al
  80131c:	75 e8                	jne    801306 <strnlen+0xf>
		n++;
	return n;
  80131e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801321:	c9                   	leave  
  801322:	c3                   	ret    

00801323 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801323:	55                   	push   %ebp
  801324:	89 e5                	mov    %esp,%ebp
  801326:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801329:	8b 45 08             	mov    0x8(%ebp),%eax
  80132c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80132f:	90                   	nop
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	8d 50 01             	lea    0x1(%eax),%edx
  801336:	89 55 08             	mov    %edx,0x8(%ebp)
  801339:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80133f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801342:	8a 12                	mov    (%edx),%dl
  801344:	88 10                	mov    %dl,(%eax)
  801346:	8a 00                	mov    (%eax),%al
  801348:	84 c0                	test   %al,%al
  80134a:	75 e4                	jne    801330 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80134c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80134f:	c9                   	leave  
  801350:	c3                   	ret    

00801351 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801351:	55                   	push   %ebp
  801352:	89 e5                	mov    %esp,%ebp
  801354:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801357:	8b 45 08             	mov    0x8(%ebp),%eax
  80135a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80135d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801364:	eb 1f                	jmp    801385 <strncpy+0x34>
		*dst++ = *src;
  801366:	8b 45 08             	mov    0x8(%ebp),%eax
  801369:	8d 50 01             	lea    0x1(%eax),%edx
  80136c:	89 55 08             	mov    %edx,0x8(%ebp)
  80136f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801372:	8a 12                	mov    (%edx),%dl
  801374:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801376:	8b 45 0c             	mov    0xc(%ebp),%eax
  801379:	8a 00                	mov    (%eax),%al
  80137b:	84 c0                	test   %al,%al
  80137d:	74 03                	je     801382 <strncpy+0x31>
			src++;
  80137f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  801382:	ff 45 fc             	incl   -0x4(%ebp)
  801385:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801388:	3b 45 10             	cmp    0x10(%ebp),%eax
  80138b:	72 d9                	jb     801366 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80138d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801390:	c9                   	leave  
  801391:	c3                   	ret    

00801392 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801392:	55                   	push   %ebp
  801393:	89 e5                	mov    %esp,%ebp
  801395:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801398:	8b 45 08             	mov    0x8(%ebp),%eax
  80139b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80139e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a2:	74 30                	je     8013d4 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013a4:	eb 16                	jmp    8013bc <strlcpy+0x2a>
			*dst++ = *src++;
  8013a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a9:	8d 50 01             	lea    0x1(%eax),%edx
  8013ac:	89 55 08             	mov    %edx,0x8(%ebp)
  8013af:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013b2:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013b5:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013b8:	8a 12                	mov    (%edx),%dl
  8013ba:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013bc:	ff 4d 10             	decl   0x10(%ebp)
  8013bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c3:	74 09                	je     8013ce <strlcpy+0x3c>
  8013c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c8:	8a 00                	mov    (%eax),%al
  8013ca:	84 c0                	test   %al,%al
  8013cc:	75 d8                	jne    8013a6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d1:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013d4:	8b 55 08             	mov    0x8(%ebp),%edx
  8013d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013da:	29 c2                	sub    %eax,%edx
  8013dc:	89 d0                	mov    %edx,%eax
}
  8013de:	c9                   	leave  
  8013df:	c3                   	ret    

008013e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013e3:	eb 06                	jmp    8013eb <strcmp+0xb>
		p++, q++;
  8013e5:	ff 45 08             	incl   0x8(%ebp)
  8013e8:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ee:	8a 00                	mov    (%eax),%al
  8013f0:	84 c0                	test   %al,%al
  8013f2:	74 0e                	je     801402 <strcmp+0x22>
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8a 10                	mov    (%eax),%dl
  8013f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013fc:	8a 00                	mov    (%eax),%al
  8013fe:	38 c2                	cmp    %al,%dl
  801400:	74 e3                	je     8013e5 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801402:	8b 45 08             	mov    0x8(%ebp),%eax
  801405:	8a 00                	mov    (%eax),%al
  801407:	0f b6 d0             	movzbl %al,%edx
  80140a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140d:	8a 00                	mov    (%eax),%al
  80140f:	0f b6 c0             	movzbl %al,%eax
  801412:	29 c2                	sub    %eax,%edx
  801414:	89 d0                	mov    %edx,%eax
}
  801416:	5d                   	pop    %ebp
  801417:	c3                   	ret    

00801418 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801418:	55                   	push   %ebp
  801419:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80141b:	eb 09                	jmp    801426 <strncmp+0xe>
		n--, p++, q++;
  80141d:	ff 4d 10             	decl   0x10(%ebp)
  801420:	ff 45 08             	incl   0x8(%ebp)
  801423:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801426:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142a:	74 17                	je     801443 <strncmp+0x2b>
  80142c:	8b 45 08             	mov    0x8(%ebp),%eax
  80142f:	8a 00                	mov    (%eax),%al
  801431:	84 c0                	test   %al,%al
  801433:	74 0e                	je     801443 <strncmp+0x2b>
  801435:	8b 45 08             	mov    0x8(%ebp),%eax
  801438:	8a 10                	mov    (%eax),%dl
  80143a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80143d:	8a 00                	mov    (%eax),%al
  80143f:	38 c2                	cmp    %al,%dl
  801441:	74 da                	je     80141d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801443:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801447:	75 07                	jne    801450 <strncmp+0x38>
		return 0;
  801449:	b8 00 00 00 00       	mov    $0x0,%eax
  80144e:	eb 14                	jmp    801464 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 00                	mov    (%eax),%al
  801455:	0f b6 d0             	movzbl %al,%edx
  801458:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145b:	8a 00                	mov    (%eax),%al
  80145d:	0f b6 c0             	movzbl %al,%eax
  801460:	29 c2                	sub    %eax,%edx
  801462:	89 d0                	mov    %edx,%eax
}
  801464:	5d                   	pop    %ebp
  801465:	c3                   	ret    

00801466 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801466:	55                   	push   %ebp
  801467:	89 e5                	mov    %esp,%ebp
  801469:	83 ec 04             	sub    $0x4,%esp
  80146c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801472:	eb 12                	jmp    801486 <strchr+0x20>
		if (*s == c)
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	8a 00                	mov    (%eax),%al
  801479:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80147c:	75 05                	jne    801483 <strchr+0x1d>
			return (char *) s;
  80147e:	8b 45 08             	mov    0x8(%ebp),%eax
  801481:	eb 11                	jmp    801494 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801483:	ff 45 08             	incl   0x8(%ebp)
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	84 c0                	test   %al,%al
  80148d:	75 e5                	jne    801474 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80148f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801494:	c9                   	leave  
  801495:	c3                   	ret    

00801496 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801496:	55                   	push   %ebp
  801497:	89 e5                	mov    %esp,%ebp
  801499:	83 ec 04             	sub    $0x4,%esp
  80149c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014a2:	eb 0d                	jmp    8014b1 <strfind+0x1b>
		if (*s == c)
  8014a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a7:	8a 00                	mov    (%eax),%al
  8014a9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014ac:	74 0e                	je     8014bc <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014ae:	ff 45 08             	incl   0x8(%ebp)
  8014b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b4:	8a 00                	mov    (%eax),%al
  8014b6:	84 c0                	test   %al,%al
  8014b8:	75 ea                	jne    8014a4 <strfind+0xe>
  8014ba:	eb 01                	jmp    8014bd <strfind+0x27>
		if (*s == c)
			break;
  8014bc:	90                   	nop
	return (char *) s;
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c0:	c9                   	leave  
  8014c1:	c3                   	ret    

008014c2 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014c2:	55                   	push   %ebp
  8014c3:	89 e5                	mov    %esp,%ebp
  8014c5:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014cb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014ce:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014d4:	eb 0e                	jmp    8014e4 <memset+0x22>
		*p++ = c;
  8014d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d9:	8d 50 01             	lea    0x1(%eax),%edx
  8014dc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014df:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e2:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014e4:	ff 4d f8             	decl   -0x8(%ebp)
  8014e7:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014eb:	79 e9                	jns    8014d6 <memset+0x14>
		*p++ = c;

	return v;
  8014ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f0:	c9                   	leave  
  8014f1:	c3                   	ret    

008014f2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014f2:	55                   	push   %ebp
  8014f3:	89 e5                	mov    %esp,%ebp
  8014f5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801501:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801504:	eb 16                	jmp    80151c <memcpy+0x2a>
		*d++ = *s++;
  801506:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801509:	8d 50 01             	lea    0x1(%eax),%edx
  80150c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80150f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801512:	8d 4a 01             	lea    0x1(%edx),%ecx
  801515:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801518:	8a 12                	mov    (%edx),%dl
  80151a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80151c:	8b 45 10             	mov    0x10(%ebp),%eax
  80151f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801522:	89 55 10             	mov    %edx,0x10(%ebp)
  801525:	85 c0                	test   %eax,%eax
  801527:	75 dd                	jne    801506 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801529:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80152c:	c9                   	leave  
  80152d:	c3                   	ret    

0080152e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80152e:	55                   	push   %ebp
  80152f:	89 e5                	mov    %esp,%ebp
  801531:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801534:	8b 45 0c             	mov    0xc(%ebp),%eax
  801537:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80153a:	8b 45 08             	mov    0x8(%ebp),%eax
  80153d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801540:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801543:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801546:	73 50                	jae    801598 <memmove+0x6a>
  801548:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80154b:	8b 45 10             	mov    0x10(%ebp),%eax
  80154e:	01 d0                	add    %edx,%eax
  801550:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801553:	76 43                	jbe    801598 <memmove+0x6a>
		s += n;
  801555:	8b 45 10             	mov    0x10(%ebp),%eax
  801558:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80155b:	8b 45 10             	mov    0x10(%ebp),%eax
  80155e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801561:	eb 10                	jmp    801573 <memmove+0x45>
			*--d = *--s;
  801563:	ff 4d f8             	decl   -0x8(%ebp)
  801566:	ff 4d fc             	decl   -0x4(%ebp)
  801569:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80156c:	8a 10                	mov    (%eax),%dl
  80156e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801571:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801573:	8b 45 10             	mov    0x10(%ebp),%eax
  801576:	8d 50 ff             	lea    -0x1(%eax),%edx
  801579:	89 55 10             	mov    %edx,0x10(%ebp)
  80157c:	85 c0                	test   %eax,%eax
  80157e:	75 e3                	jne    801563 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801580:	eb 23                	jmp    8015a5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801582:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801585:	8d 50 01             	lea    0x1(%eax),%edx
  801588:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80158b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80158e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801591:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801594:	8a 12                	mov    (%edx),%dl
  801596:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801598:	8b 45 10             	mov    0x10(%ebp),%eax
  80159b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80159e:	89 55 10             	mov    %edx,0x10(%ebp)
  8015a1:	85 c0                	test   %eax,%eax
  8015a3:	75 dd                	jne    801582 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015a8:	c9                   	leave  
  8015a9:	c3                   	ret    

008015aa <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015aa:	55                   	push   %ebp
  8015ab:	89 e5                	mov    %esp,%ebp
  8015ad:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b9:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015bc:	eb 2a                	jmp    8015e8 <memcmp+0x3e>
		if (*s1 != *s2)
  8015be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015c1:	8a 10                	mov    (%eax),%dl
  8015c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c6:	8a 00                	mov    (%eax),%al
  8015c8:	38 c2                	cmp    %al,%dl
  8015ca:	74 16                	je     8015e2 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015cf:	8a 00                	mov    (%eax),%al
  8015d1:	0f b6 d0             	movzbl %al,%edx
  8015d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d7:	8a 00                	mov    (%eax),%al
  8015d9:	0f b6 c0             	movzbl %al,%eax
  8015dc:	29 c2                	sub    %eax,%edx
  8015de:	89 d0                	mov    %edx,%eax
  8015e0:	eb 18                	jmp    8015fa <memcmp+0x50>
		s1++, s2++;
  8015e2:	ff 45 fc             	incl   -0x4(%ebp)
  8015e5:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015ee:	89 55 10             	mov    %edx,0x10(%ebp)
  8015f1:	85 c0                	test   %eax,%eax
  8015f3:	75 c9                	jne    8015be <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015fa:	c9                   	leave  
  8015fb:	c3                   	ret    

008015fc <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
  8015ff:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801602:	8b 55 08             	mov    0x8(%ebp),%edx
  801605:	8b 45 10             	mov    0x10(%ebp),%eax
  801608:	01 d0                	add    %edx,%eax
  80160a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80160d:	eb 15                	jmp    801624 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	8a 00                	mov    (%eax),%al
  801614:	0f b6 d0             	movzbl %al,%edx
  801617:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161a:	0f b6 c0             	movzbl %al,%eax
  80161d:	39 c2                	cmp    %eax,%edx
  80161f:	74 0d                	je     80162e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801621:	ff 45 08             	incl   0x8(%ebp)
  801624:	8b 45 08             	mov    0x8(%ebp),%eax
  801627:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80162a:	72 e3                	jb     80160f <memfind+0x13>
  80162c:	eb 01                	jmp    80162f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80162e:	90                   	nop
	return (void *) s;
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801632:	c9                   	leave  
  801633:	c3                   	ret    

00801634 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801634:	55                   	push   %ebp
  801635:	89 e5                	mov    %esp,%ebp
  801637:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80163a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801641:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801648:	eb 03                	jmp    80164d <strtol+0x19>
		s++;
  80164a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80164d:	8b 45 08             	mov    0x8(%ebp),%eax
  801650:	8a 00                	mov    (%eax),%al
  801652:	3c 20                	cmp    $0x20,%al
  801654:	74 f4                	je     80164a <strtol+0x16>
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
  801659:	8a 00                	mov    (%eax),%al
  80165b:	3c 09                	cmp    $0x9,%al
  80165d:	74 eb                	je     80164a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	3c 2b                	cmp    $0x2b,%al
  801666:	75 05                	jne    80166d <strtol+0x39>
		s++;
  801668:	ff 45 08             	incl   0x8(%ebp)
  80166b:	eb 13                	jmp    801680 <strtol+0x4c>
	else if (*s == '-')
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	3c 2d                	cmp    $0x2d,%al
  801674:	75 0a                	jne    801680 <strtol+0x4c>
		s++, neg = 1;
  801676:	ff 45 08             	incl   0x8(%ebp)
  801679:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801680:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801684:	74 06                	je     80168c <strtol+0x58>
  801686:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80168a:	75 20                	jne    8016ac <strtol+0x78>
  80168c:	8b 45 08             	mov    0x8(%ebp),%eax
  80168f:	8a 00                	mov    (%eax),%al
  801691:	3c 30                	cmp    $0x30,%al
  801693:	75 17                	jne    8016ac <strtol+0x78>
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	40                   	inc    %eax
  801699:	8a 00                	mov    (%eax),%al
  80169b:	3c 78                	cmp    $0x78,%al
  80169d:	75 0d                	jne    8016ac <strtol+0x78>
		s += 2, base = 16;
  80169f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016a3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016aa:	eb 28                	jmp    8016d4 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016ac:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016b0:	75 15                	jne    8016c7 <strtol+0x93>
  8016b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b5:	8a 00                	mov    (%eax),%al
  8016b7:	3c 30                	cmp    $0x30,%al
  8016b9:	75 0c                	jne    8016c7 <strtol+0x93>
		s++, base = 8;
  8016bb:	ff 45 08             	incl   0x8(%ebp)
  8016be:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016c5:	eb 0d                	jmp    8016d4 <strtol+0xa0>
	else if (base == 0)
  8016c7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016cb:	75 07                	jne    8016d4 <strtol+0xa0>
		base = 10;
  8016cd:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d7:	8a 00                	mov    (%eax),%al
  8016d9:	3c 2f                	cmp    $0x2f,%al
  8016db:	7e 19                	jle    8016f6 <strtol+0xc2>
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	8a 00                	mov    (%eax),%al
  8016e2:	3c 39                	cmp    $0x39,%al
  8016e4:	7f 10                	jg     8016f6 <strtol+0xc2>
			dig = *s - '0';
  8016e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e9:	8a 00                	mov    (%eax),%al
  8016eb:	0f be c0             	movsbl %al,%eax
  8016ee:	83 e8 30             	sub    $0x30,%eax
  8016f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016f4:	eb 42                	jmp    801738 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f9:	8a 00                	mov    (%eax),%al
  8016fb:	3c 60                	cmp    $0x60,%al
  8016fd:	7e 19                	jle    801718 <strtol+0xe4>
  8016ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801702:	8a 00                	mov    (%eax),%al
  801704:	3c 7a                	cmp    $0x7a,%al
  801706:	7f 10                	jg     801718 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801708:	8b 45 08             	mov    0x8(%ebp),%eax
  80170b:	8a 00                	mov    (%eax),%al
  80170d:	0f be c0             	movsbl %al,%eax
  801710:	83 e8 57             	sub    $0x57,%eax
  801713:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801716:	eb 20                	jmp    801738 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801718:	8b 45 08             	mov    0x8(%ebp),%eax
  80171b:	8a 00                	mov    (%eax),%al
  80171d:	3c 40                	cmp    $0x40,%al
  80171f:	7e 39                	jle    80175a <strtol+0x126>
  801721:	8b 45 08             	mov    0x8(%ebp),%eax
  801724:	8a 00                	mov    (%eax),%al
  801726:	3c 5a                	cmp    $0x5a,%al
  801728:	7f 30                	jg     80175a <strtol+0x126>
			dig = *s - 'A' + 10;
  80172a:	8b 45 08             	mov    0x8(%ebp),%eax
  80172d:	8a 00                	mov    (%eax),%al
  80172f:	0f be c0             	movsbl %al,%eax
  801732:	83 e8 37             	sub    $0x37,%eax
  801735:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801738:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80173b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80173e:	7d 19                	jge    801759 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801740:	ff 45 08             	incl   0x8(%ebp)
  801743:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801746:	0f af 45 10          	imul   0x10(%ebp),%eax
  80174a:	89 c2                	mov    %eax,%edx
  80174c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80174f:	01 d0                	add    %edx,%eax
  801751:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801754:	e9 7b ff ff ff       	jmp    8016d4 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801759:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80175a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80175e:	74 08                	je     801768 <strtol+0x134>
		*endptr = (char *) s;
  801760:	8b 45 0c             	mov    0xc(%ebp),%eax
  801763:	8b 55 08             	mov    0x8(%ebp),%edx
  801766:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801768:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80176c:	74 07                	je     801775 <strtol+0x141>
  80176e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801771:	f7 d8                	neg    %eax
  801773:	eb 03                	jmp    801778 <strtol+0x144>
  801775:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <ltostr>:

void
ltostr(long value, char *str)
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
  80177d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801780:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801787:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80178e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801792:	79 13                	jns    8017a7 <ltostr+0x2d>
	{
		neg = 1;
  801794:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80179b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017a1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017a4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017aa:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017af:	99                   	cltd   
  8017b0:	f7 f9                	idiv   %ecx
  8017b2:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b8:	8d 50 01             	lea    0x1(%eax),%edx
  8017bb:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017be:	89 c2                	mov    %eax,%edx
  8017c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c3:	01 d0                	add    %edx,%eax
  8017c5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017c8:	83 c2 30             	add    $0x30,%edx
  8017cb:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017cd:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017d0:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017d5:	f7 e9                	imul   %ecx
  8017d7:	c1 fa 02             	sar    $0x2,%edx
  8017da:	89 c8                	mov    %ecx,%eax
  8017dc:	c1 f8 1f             	sar    $0x1f,%eax
  8017df:	29 c2                	sub    %eax,%edx
  8017e1:	89 d0                	mov    %edx,%eax
  8017e3:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017e6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017e9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017ee:	f7 e9                	imul   %ecx
  8017f0:	c1 fa 02             	sar    $0x2,%edx
  8017f3:	89 c8                	mov    %ecx,%eax
  8017f5:	c1 f8 1f             	sar    $0x1f,%eax
  8017f8:	29 c2                	sub    %eax,%edx
  8017fa:	89 d0                	mov    %edx,%eax
  8017fc:	c1 e0 02             	shl    $0x2,%eax
  8017ff:	01 d0                	add    %edx,%eax
  801801:	01 c0                	add    %eax,%eax
  801803:	29 c1                	sub    %eax,%ecx
  801805:	89 ca                	mov    %ecx,%edx
  801807:	85 d2                	test   %edx,%edx
  801809:	75 9c                	jne    8017a7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80180b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801812:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801815:	48                   	dec    %eax
  801816:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801819:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80181d:	74 3d                	je     80185c <ltostr+0xe2>
		start = 1 ;
  80181f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801826:	eb 34                	jmp    80185c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801828:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80182b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80182e:	01 d0                	add    %edx,%eax
  801830:	8a 00                	mov    (%eax),%al
  801832:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801835:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801838:	8b 45 0c             	mov    0xc(%ebp),%eax
  80183b:	01 c2                	add    %eax,%edx
  80183d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801840:	8b 45 0c             	mov    0xc(%ebp),%eax
  801843:	01 c8                	add    %ecx,%eax
  801845:	8a 00                	mov    (%eax),%al
  801847:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801849:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80184c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184f:	01 c2                	add    %eax,%edx
  801851:	8a 45 eb             	mov    -0x15(%ebp),%al
  801854:	88 02                	mov    %al,(%edx)
		start++ ;
  801856:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801859:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80185c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80185f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801862:	7c c4                	jl     801828 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801864:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801867:	8b 45 0c             	mov    0xc(%ebp),%eax
  80186a:	01 d0                	add    %edx,%eax
  80186c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80186f:	90                   	nop
  801870:	c9                   	leave  
  801871:	c3                   	ret    

00801872 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801872:	55                   	push   %ebp
  801873:	89 e5                	mov    %esp,%ebp
  801875:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801878:	ff 75 08             	pushl  0x8(%ebp)
  80187b:	e8 54 fa ff ff       	call   8012d4 <strlen>
  801880:	83 c4 04             	add    $0x4,%esp
  801883:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801886:	ff 75 0c             	pushl  0xc(%ebp)
  801889:	e8 46 fa ff ff       	call   8012d4 <strlen>
  80188e:	83 c4 04             	add    $0x4,%esp
  801891:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801894:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80189b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018a2:	eb 17                	jmp    8018bb <strcconcat+0x49>
		final[s] = str1[s] ;
  8018a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018aa:	01 c2                	add    %eax,%edx
  8018ac:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018af:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b2:	01 c8                	add    %ecx,%eax
  8018b4:	8a 00                	mov    (%eax),%al
  8018b6:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018b8:	ff 45 fc             	incl   -0x4(%ebp)
  8018bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018c1:	7c e1                	jl     8018a4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018c3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018ca:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018d1:	eb 1f                	jmp    8018f2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018d6:	8d 50 01             	lea    0x1(%eax),%edx
  8018d9:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018dc:	89 c2                	mov    %eax,%edx
  8018de:	8b 45 10             	mov    0x10(%ebp),%eax
  8018e1:	01 c2                	add    %eax,%edx
  8018e3:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018e6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e9:	01 c8                	add    %ecx,%eax
  8018eb:	8a 00                	mov    (%eax),%al
  8018ed:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018ef:	ff 45 f8             	incl   -0x8(%ebp)
  8018f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018f5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018f8:	7c d9                	jl     8018d3 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018fd:	8b 45 10             	mov    0x10(%ebp),%eax
  801900:	01 d0                	add    %edx,%eax
  801902:	c6 00 00             	movb   $0x0,(%eax)
}
  801905:	90                   	nop
  801906:	c9                   	leave  
  801907:	c3                   	ret    

00801908 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801908:	55                   	push   %ebp
  801909:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80190b:	8b 45 14             	mov    0x14(%ebp),%eax
  80190e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801914:	8b 45 14             	mov    0x14(%ebp),%eax
  801917:	8b 00                	mov    (%eax),%eax
  801919:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801920:	8b 45 10             	mov    0x10(%ebp),%eax
  801923:	01 d0                	add    %edx,%eax
  801925:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80192b:	eb 0c                	jmp    801939 <strsplit+0x31>
			*string++ = 0;
  80192d:	8b 45 08             	mov    0x8(%ebp),%eax
  801930:	8d 50 01             	lea    0x1(%eax),%edx
  801933:	89 55 08             	mov    %edx,0x8(%ebp)
  801936:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	8a 00                	mov    (%eax),%al
  80193e:	84 c0                	test   %al,%al
  801940:	74 18                	je     80195a <strsplit+0x52>
  801942:	8b 45 08             	mov    0x8(%ebp),%eax
  801945:	8a 00                	mov    (%eax),%al
  801947:	0f be c0             	movsbl %al,%eax
  80194a:	50                   	push   %eax
  80194b:	ff 75 0c             	pushl  0xc(%ebp)
  80194e:	e8 13 fb ff ff       	call   801466 <strchr>
  801953:	83 c4 08             	add    $0x8,%esp
  801956:	85 c0                	test   %eax,%eax
  801958:	75 d3                	jne    80192d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80195a:	8b 45 08             	mov    0x8(%ebp),%eax
  80195d:	8a 00                	mov    (%eax),%al
  80195f:	84 c0                	test   %al,%al
  801961:	74 5a                	je     8019bd <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801963:	8b 45 14             	mov    0x14(%ebp),%eax
  801966:	8b 00                	mov    (%eax),%eax
  801968:	83 f8 0f             	cmp    $0xf,%eax
  80196b:	75 07                	jne    801974 <strsplit+0x6c>
		{
			return 0;
  80196d:	b8 00 00 00 00       	mov    $0x0,%eax
  801972:	eb 66                	jmp    8019da <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801974:	8b 45 14             	mov    0x14(%ebp),%eax
  801977:	8b 00                	mov    (%eax),%eax
  801979:	8d 48 01             	lea    0x1(%eax),%ecx
  80197c:	8b 55 14             	mov    0x14(%ebp),%edx
  80197f:	89 0a                	mov    %ecx,(%edx)
  801981:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801988:	8b 45 10             	mov    0x10(%ebp),%eax
  80198b:	01 c2                	add    %eax,%edx
  80198d:	8b 45 08             	mov    0x8(%ebp),%eax
  801990:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801992:	eb 03                	jmp    801997 <strsplit+0x8f>
			string++;
  801994:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801997:	8b 45 08             	mov    0x8(%ebp),%eax
  80199a:	8a 00                	mov    (%eax),%al
  80199c:	84 c0                	test   %al,%al
  80199e:	74 8b                	je     80192b <strsplit+0x23>
  8019a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a3:	8a 00                	mov    (%eax),%al
  8019a5:	0f be c0             	movsbl %al,%eax
  8019a8:	50                   	push   %eax
  8019a9:	ff 75 0c             	pushl  0xc(%ebp)
  8019ac:	e8 b5 fa ff ff       	call   801466 <strchr>
  8019b1:	83 c4 08             	add    $0x8,%esp
  8019b4:	85 c0                	test   %eax,%eax
  8019b6:	74 dc                	je     801994 <strsplit+0x8c>
			string++;
	}
  8019b8:	e9 6e ff ff ff       	jmp    80192b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019bd:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019be:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c1:	8b 00                	mov    (%eax),%eax
  8019c3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8019cd:	01 d0                	add    %edx,%eax
  8019cf:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019d5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019da:	c9                   	leave  
  8019db:	c3                   	ret    

008019dc <ClearNodeData>:
 * inside the user heap
 */

struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  8019dc:	55                   	push   %ebp
  8019dd:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  8019df:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e2:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  8019e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e9:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  8019ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f0:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  8019f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fa:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  801a01:	8b 45 08             	mov    0x8(%ebp),%eax
  801a04:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  801a0b:	90                   	nop
  801a0c:	5d                   	pop    %ebp
  801a0d:	c3                   	ret    

00801a0e <initialize_buddy>:

void initialize_buddy()
{
  801a0e:	55                   	push   %ebp
  801a0f:	89 e5                	mov    %esp,%ebp
  801a11:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801a14:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a1b:	e9 b7 00 00 00       	jmp    801ad7 <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  801a20:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801a26:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a29:	89 c8                	mov    %ecx,%eax
  801a2b:	01 c0                	add    %eax,%eax
  801a2d:	01 c8                	add    %ecx,%eax
  801a2f:	c1 e0 03             	shl    $0x3,%eax
  801a32:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a37:	89 10                	mov    %edx,(%eax)
  801a39:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a3c:	89 d0                	mov    %edx,%eax
  801a3e:	01 c0                	add    %eax,%eax
  801a40:	01 d0                	add    %edx,%eax
  801a42:	c1 e0 03             	shl    $0x3,%eax
  801a45:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a4a:	8b 00                	mov    (%eax),%eax
  801a4c:	85 c0                	test   %eax,%eax
  801a4e:	74 1c                	je     801a6c <initialize_buddy+0x5e>
  801a50:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801a56:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a59:	89 c8                	mov    %ecx,%eax
  801a5b:	01 c0                	add    %eax,%eax
  801a5d:	01 c8                	add    %ecx,%eax
  801a5f:	c1 e0 03             	shl    $0x3,%eax
  801a62:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a67:	89 42 04             	mov    %eax,0x4(%edx)
  801a6a:	eb 16                	jmp    801a82 <initialize_buddy+0x74>
  801a6c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a6f:	89 d0                	mov    %edx,%eax
  801a71:	01 c0                	add    %eax,%eax
  801a73:	01 d0                	add    %edx,%eax
  801a75:	c1 e0 03             	shl    $0x3,%eax
  801a78:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a7d:	a3 08 31 80 00       	mov    %eax,0x803108
  801a82:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a85:	89 d0                	mov    %edx,%eax
  801a87:	01 c0                	add    %eax,%eax
  801a89:	01 d0                	add    %edx,%eax
  801a8b:	c1 e0 03             	shl    $0x3,%eax
  801a8e:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a93:	a3 04 31 80 00       	mov    %eax,0x803104
  801a98:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a9b:	89 d0                	mov    %edx,%eax
  801a9d:	01 c0                	add    %eax,%eax
  801a9f:	01 d0                	add    %edx,%eax
  801aa1:	c1 e0 03             	shl    $0x3,%eax
  801aa4:	05 20 31 80 00       	add    $0x803120,%eax
  801aa9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801aaf:	a1 10 31 80 00       	mov    0x803110,%eax
  801ab4:	40                   	inc    %eax
  801ab5:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  801aba:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801abd:	89 d0                	mov    %edx,%eax
  801abf:	01 c0                	add    %eax,%eax
  801ac1:	01 d0                	add    %edx,%eax
  801ac3:	c1 e0 03             	shl    $0x3,%eax
  801ac6:	05 1c 31 80 00       	add    $0x80311c,%eax
  801acb:	50                   	push   %eax
  801acc:	e8 0b ff ff ff       	call   8019dc <ClearNodeData>
  801ad1:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801ad4:	ff 45 fc             	incl   -0x4(%ebp)
  801ad7:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801adb:	0f 8e 3f ff ff ff    	jle    801a20 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801ae1:	90                   	nop
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <CreateNewBuddySpace>:

/*===============================================================*/

void CreateNewBuddySpace()
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
  801ae7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801aea:	83 ec 04             	sub    $0x4,%esp
  801aed:	68 84 2b 80 00       	push   $0x802b84
  801af2:	6a 1f                	push   $0x1f
  801af4:	68 b6 2b 80 00       	push   $0x802bb6
  801af9:	e8 9a ec ff ff       	call   800798 <_panic>

00801afe <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801afe:	55                   	push   %ebp
  801aff:	89 e5                	mov    %esp,%ebp
  801b01:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  801b04:	83 ec 04             	sub    $0x4,%esp
  801b07:	68 c4 2b 80 00       	push   $0x802bc4
  801b0c:	6a 26                	push   $0x26
  801b0e:	68 b6 2b 80 00       	push   $0x802bb6
  801b13:	e8 80 ec ff ff       	call   800798 <_panic>

00801b18 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801b18:	55                   	push   %ebp
  801b19:	89 e5                	mov    %esp,%ebp
  801b1b:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801b1e:	83 ec 04             	sub    $0x4,%esp
  801b21:	68 fc 2b 80 00       	push   $0x802bfc
  801b26:	6a 2c                	push   $0x2c
  801b28:	68 b6 2b 80 00       	push   $0x802bb6
  801b2d:	e8 66 ec ff ff       	call   800798 <_panic>

00801b32 <__new>:

}
/*===============================================================*/
void* lastAlloc = (void*) USER_HEAP_START ;
void* __new(uint32 size)
{
  801b32:	55                   	push   %ebp
  801b33:	89 e5                	mov    %esp,%ebp
  801b35:	83 ec 18             	sub    $0x18,%esp
	void* va = lastAlloc;
  801b38:	a1 04 30 80 00       	mov    0x803004,%eax
  801b3d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	size = ROUNDUP(size, PAGE_SIZE) ;
  801b40:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
  801b47:	8b 55 08             	mov    0x8(%ebp),%edx
  801b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b4d:	01 d0                	add    %edx,%eax
  801b4f:	48                   	dec    %eax
  801b50:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b53:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b56:	ba 00 00 00 00       	mov    $0x0,%edx
  801b5b:	f7 75 f0             	divl   -0x10(%ebp)
  801b5e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b61:	29 d0                	sub    %edx,%eax
  801b63:	89 45 08             	mov    %eax,0x8(%ebp)
	sys_new((uint32)va, size) ;
  801b66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b69:	83 ec 08             	sub    $0x8,%esp
  801b6c:	ff 75 08             	pushl  0x8(%ebp)
  801b6f:	50                   	push   %eax
  801b70:	e8 75 06 00 00       	call   8021ea <sys_new>
  801b75:	83 c4 10             	add    $0x10,%esp
	lastAlloc += size ;
  801b78:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b81:	01 d0                	add    %edx,%eax
  801b83:	a3 04 30 80 00       	mov    %eax,0x803004
	return va ;
  801b88:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801b8b:	c9                   	leave  
  801b8c:	c3                   	ret    

00801b8d <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b8d:	55                   	push   %ebp
  801b8e:	89 e5                	mov    %esp,%ebp
  801b90:	57                   	push   %edi
  801b91:	56                   	push   %esi
  801b92:	53                   	push   %ebx
  801b93:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b96:	8b 45 08             	mov    0x8(%ebp),%eax
  801b99:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b9c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b9f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ba2:	8b 7d 18             	mov    0x18(%ebp),%edi
  801ba5:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801ba8:	cd 30                	int    $0x30
  801baa:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801bad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801bb0:	83 c4 10             	add    $0x10,%esp
  801bb3:	5b                   	pop    %ebx
  801bb4:	5e                   	pop    %esi
  801bb5:	5f                   	pop    %edi
  801bb6:	5d                   	pop    %ebp
  801bb7:	c3                   	ret    

00801bb8 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801bb8:	55                   	push   %ebp
  801bb9:	89 e5                	mov    %esp,%ebp
  801bbb:	83 ec 04             	sub    $0x4,%esp
  801bbe:	8b 45 10             	mov    0x10(%ebp),%eax
  801bc1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801bc4:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801bc8:	8b 45 08             	mov    0x8(%ebp),%eax
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	52                   	push   %edx
  801bd0:	ff 75 0c             	pushl  0xc(%ebp)
  801bd3:	50                   	push   %eax
  801bd4:	6a 00                	push   $0x0
  801bd6:	e8 b2 ff ff ff       	call   801b8d <syscall>
  801bdb:	83 c4 18             	add    $0x18,%esp
}
  801bde:	90                   	nop
  801bdf:	c9                   	leave  
  801be0:	c3                   	ret    

00801be1 <sys_cgetc>:

int
sys_cgetc(void)
{
  801be1:	55                   	push   %ebp
  801be2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 01                	push   $0x1
  801bf0:	e8 98 ff ff ff       	call   801b8d <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
}
  801bf8:	c9                   	leave  
  801bf9:	c3                   	ret    

00801bfa <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bfa:	55                   	push   %ebp
  801bfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bfd:	8b 45 08             	mov    0x8(%ebp),%eax
  801c00:	6a 00                	push   $0x0
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	50                   	push   %eax
  801c09:	6a 05                	push   $0x5
  801c0b:	e8 7d ff ff ff       	call   801b8d <syscall>
  801c10:	83 c4 18             	add    $0x18,%esp
}
  801c13:	c9                   	leave  
  801c14:	c3                   	ret    

00801c15 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c15:	55                   	push   %ebp
  801c16:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c18:	6a 00                	push   $0x0
  801c1a:	6a 00                	push   $0x0
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 02                	push   $0x2
  801c24:	e8 64 ff ff ff       	call   801b8d <syscall>
  801c29:	83 c4 18             	add    $0x18,%esp
}
  801c2c:	c9                   	leave  
  801c2d:	c3                   	ret    

00801c2e <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c2e:	55                   	push   %ebp
  801c2f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 03                	push   $0x3
  801c3d:	e8 4b ff ff ff       	call   801b8d <syscall>
  801c42:	83 c4 18             	add    $0x18,%esp
}
  801c45:	c9                   	leave  
  801c46:	c3                   	ret    

00801c47 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c47:	55                   	push   %ebp
  801c48:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 04                	push   $0x4
  801c56:	e8 32 ff ff ff       	call   801b8d <syscall>
  801c5b:	83 c4 18             	add    $0x18,%esp
}
  801c5e:	c9                   	leave  
  801c5f:	c3                   	ret    

00801c60 <sys_env_exit>:


void sys_env_exit(void)
{
  801c60:	55                   	push   %ebp
  801c61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 00                	push   $0x0
  801c6b:	6a 00                	push   $0x0
  801c6d:	6a 06                	push   $0x6
  801c6f:	e8 19 ff ff ff       	call   801b8d <syscall>
  801c74:	83 c4 18             	add    $0x18,%esp
}
  801c77:	90                   	nop
  801c78:	c9                   	leave  
  801c79:	c3                   	ret    

00801c7a <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c7a:	55                   	push   %ebp
  801c7b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c7d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c80:	8b 45 08             	mov    0x8(%ebp),%eax
  801c83:	6a 00                	push   $0x0
  801c85:	6a 00                	push   $0x0
  801c87:	6a 00                	push   $0x0
  801c89:	52                   	push   %edx
  801c8a:	50                   	push   %eax
  801c8b:	6a 07                	push   $0x7
  801c8d:	e8 fb fe ff ff       	call   801b8d <syscall>
  801c92:	83 c4 18             	add    $0x18,%esp
}
  801c95:	c9                   	leave  
  801c96:	c3                   	ret    

00801c97 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c97:	55                   	push   %ebp
  801c98:	89 e5                	mov    %esp,%ebp
  801c9a:	56                   	push   %esi
  801c9b:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c9c:	8b 75 18             	mov    0x18(%ebp),%esi
  801c9f:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ca2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ca5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca8:	8b 45 08             	mov    0x8(%ebp),%eax
  801cab:	56                   	push   %esi
  801cac:	53                   	push   %ebx
  801cad:	51                   	push   %ecx
  801cae:	52                   	push   %edx
  801caf:	50                   	push   %eax
  801cb0:	6a 08                	push   $0x8
  801cb2:	e8 d6 fe ff ff       	call   801b8d <syscall>
  801cb7:	83 c4 18             	add    $0x18,%esp
}
  801cba:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801cbd:	5b                   	pop    %ebx
  801cbe:	5e                   	pop    %esi
  801cbf:	5d                   	pop    %ebp
  801cc0:	c3                   	ret    

00801cc1 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801cc1:	55                   	push   %ebp
  801cc2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801cc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	52                   	push   %edx
  801cd1:	50                   	push   %eax
  801cd2:	6a 09                	push   $0x9
  801cd4:	e8 b4 fe ff ff       	call   801b8d <syscall>
  801cd9:	83 c4 18             	add    $0x18,%esp
}
  801cdc:	c9                   	leave  
  801cdd:	c3                   	ret    

00801cde <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	ff 75 0c             	pushl  0xc(%ebp)
  801cea:	ff 75 08             	pushl  0x8(%ebp)
  801ced:	6a 0a                	push   $0xa
  801cef:	e8 99 fe ff ff       	call   801b8d <syscall>
  801cf4:	83 c4 18             	add    $0x18,%esp
}
  801cf7:	c9                   	leave  
  801cf8:	c3                   	ret    

00801cf9 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801cf9:	55                   	push   %ebp
  801cfa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cfc:	6a 00                	push   $0x0
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	6a 00                	push   $0x0
  801d06:	6a 0b                	push   $0xb
  801d08:	e8 80 fe ff ff       	call   801b8d <syscall>
  801d0d:	83 c4 18             	add    $0x18,%esp
}
  801d10:	c9                   	leave  
  801d11:	c3                   	ret    

00801d12 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d12:	55                   	push   %ebp
  801d13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 0c                	push   $0xc
  801d21:	e8 67 fe ff ff       	call   801b8d <syscall>
  801d26:	83 c4 18             	add    $0x18,%esp
}
  801d29:	c9                   	leave  
  801d2a:	c3                   	ret    

00801d2b <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d2b:	55                   	push   %ebp
  801d2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	6a 00                	push   $0x0
  801d34:	6a 00                	push   $0x0
  801d36:	6a 00                	push   $0x0
  801d38:	6a 0d                	push   $0xd
  801d3a:	e8 4e fe ff ff       	call   801b8d <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
}
  801d42:	c9                   	leave  
  801d43:	c3                   	ret    

00801d44 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 00                	push   $0x0
  801d4d:	ff 75 0c             	pushl  0xc(%ebp)
  801d50:	ff 75 08             	pushl  0x8(%ebp)
  801d53:	6a 11                	push   $0x11
  801d55:	e8 33 fe ff ff       	call   801b8d <syscall>
  801d5a:	83 c4 18             	add    $0x18,%esp
	return;
  801d5d:	90                   	nop
}
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	ff 75 0c             	pushl  0xc(%ebp)
  801d6c:	ff 75 08             	pushl  0x8(%ebp)
  801d6f:	6a 12                	push   $0x12
  801d71:	e8 17 fe ff ff       	call   801b8d <syscall>
  801d76:	83 c4 18             	add    $0x18,%esp
	return ;
  801d79:	90                   	nop
}
  801d7a:	c9                   	leave  
  801d7b:	c3                   	ret    

00801d7c <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d7f:	6a 00                	push   $0x0
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 0e                	push   $0xe
  801d8b:	e8 fd fd ff ff       	call   801b8d <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	ff 75 08             	pushl  0x8(%ebp)
  801da3:	6a 0f                	push   $0xf
  801da5:	e8 e3 fd ff ff       	call   801b8d <syscall>
  801daa:	83 c4 18             	add    $0x18,%esp
}
  801dad:	c9                   	leave  
  801dae:	c3                   	ret    

00801daf <sys_scarce_memory>:

void sys_scarce_memory()
{
  801daf:	55                   	push   %ebp
  801db0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801db2:	6a 00                	push   $0x0
  801db4:	6a 00                	push   $0x0
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 10                	push   $0x10
  801dbe:	e8 ca fd ff ff       	call   801b8d <syscall>
  801dc3:	83 c4 18             	add    $0x18,%esp
}
  801dc6:	90                   	nop
  801dc7:	c9                   	leave  
  801dc8:	c3                   	ret    

00801dc9 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801dc9:	55                   	push   %ebp
  801dca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 14                	push   $0x14
  801dd8:	e8 b0 fd ff ff       	call   801b8d <syscall>
  801ddd:	83 c4 18             	add    $0x18,%esp
}
  801de0:	90                   	nop
  801de1:	c9                   	leave  
  801de2:	c3                   	ret    

00801de3 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801de3:	55                   	push   %ebp
  801de4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 15                	push   $0x15
  801df2:	e8 96 fd ff ff       	call   801b8d <syscall>
  801df7:	83 c4 18             	add    $0x18,%esp
}
  801dfa:	90                   	nop
  801dfb:	c9                   	leave  
  801dfc:	c3                   	ret    

00801dfd <sys_cputc>:


void
sys_cputc(const char c)
{
  801dfd:	55                   	push   %ebp
  801dfe:	89 e5                	mov    %esp,%ebp
  801e00:	83 ec 04             	sub    $0x4,%esp
  801e03:	8b 45 08             	mov    0x8(%ebp),%eax
  801e06:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e09:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 00                	push   $0x0
  801e13:	6a 00                	push   $0x0
  801e15:	50                   	push   %eax
  801e16:	6a 16                	push   $0x16
  801e18:	e8 70 fd ff ff       	call   801b8d <syscall>
  801e1d:	83 c4 18             	add    $0x18,%esp
}
  801e20:	90                   	nop
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e26:	6a 00                	push   $0x0
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 17                	push   $0x17
  801e32:	e8 56 fd ff ff       	call   801b8d <syscall>
  801e37:	83 c4 18             	add    $0x18,%esp
}
  801e3a:	90                   	nop
  801e3b:	c9                   	leave  
  801e3c:	c3                   	ret    

00801e3d <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e3d:	55                   	push   %ebp
  801e3e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e40:	8b 45 08             	mov    0x8(%ebp),%eax
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	ff 75 0c             	pushl  0xc(%ebp)
  801e4c:	50                   	push   %eax
  801e4d:	6a 18                	push   $0x18
  801e4f:	e8 39 fd ff ff       	call   801b8d <syscall>
  801e54:	83 c4 18             	add    $0x18,%esp
}
  801e57:	c9                   	leave  
  801e58:	c3                   	ret    

00801e59 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e59:	55                   	push   %ebp
  801e5a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e5c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	6a 00                	push   $0x0
  801e68:	52                   	push   %edx
  801e69:	50                   	push   %eax
  801e6a:	6a 1b                	push   $0x1b
  801e6c:	e8 1c fd ff ff       	call   801b8d <syscall>
  801e71:	83 c4 18             	add    $0x18,%esp
}
  801e74:	c9                   	leave  
  801e75:	c3                   	ret    

00801e76 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e76:	55                   	push   %ebp
  801e77:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e79:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e7c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e7f:	6a 00                	push   $0x0
  801e81:	6a 00                	push   $0x0
  801e83:	6a 00                	push   $0x0
  801e85:	52                   	push   %edx
  801e86:	50                   	push   %eax
  801e87:	6a 19                	push   $0x19
  801e89:	e8 ff fc ff ff       	call   801b8d <syscall>
  801e8e:	83 c4 18             	add    $0x18,%esp
}
  801e91:	90                   	nop
  801e92:	c9                   	leave  
  801e93:	c3                   	ret    

00801e94 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e94:	55                   	push   %ebp
  801e95:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e97:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9d:	6a 00                	push   $0x0
  801e9f:	6a 00                	push   $0x0
  801ea1:	6a 00                	push   $0x0
  801ea3:	52                   	push   %edx
  801ea4:	50                   	push   %eax
  801ea5:	6a 1a                	push   $0x1a
  801ea7:	e8 e1 fc ff ff       	call   801b8d <syscall>
  801eac:	83 c4 18             	add    $0x18,%esp
}
  801eaf:	90                   	nop
  801eb0:	c9                   	leave  
  801eb1:	c3                   	ret    

00801eb2 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801eb2:	55                   	push   %ebp
  801eb3:	89 e5                	mov    %esp,%ebp
  801eb5:	83 ec 04             	sub    $0x4,%esp
  801eb8:	8b 45 10             	mov    0x10(%ebp),%eax
  801ebb:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801ebe:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801ec1:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ec5:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec8:	6a 00                	push   $0x0
  801eca:	51                   	push   %ecx
  801ecb:	52                   	push   %edx
  801ecc:	ff 75 0c             	pushl  0xc(%ebp)
  801ecf:	50                   	push   %eax
  801ed0:	6a 1c                	push   $0x1c
  801ed2:	e8 b6 fc ff ff       	call   801b8d <syscall>
  801ed7:	83 c4 18             	add    $0x18,%esp
}
  801eda:	c9                   	leave  
  801edb:	c3                   	ret    

00801edc <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801edc:	55                   	push   %ebp
  801edd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801edf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	52                   	push   %edx
  801eec:	50                   	push   %eax
  801eed:	6a 1d                	push   $0x1d
  801eef:	e8 99 fc ff ff       	call   801b8d <syscall>
  801ef4:	83 c4 18             	add    $0x18,%esp
}
  801ef7:	c9                   	leave  
  801ef8:	c3                   	ret    

00801ef9 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ef9:	55                   	push   %ebp
  801efa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801efc:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801eff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f02:	8b 45 08             	mov    0x8(%ebp),%eax
  801f05:	6a 00                	push   $0x0
  801f07:	6a 00                	push   $0x0
  801f09:	51                   	push   %ecx
  801f0a:	52                   	push   %edx
  801f0b:	50                   	push   %eax
  801f0c:	6a 1e                	push   $0x1e
  801f0e:	e8 7a fc ff ff       	call   801b8d <syscall>
  801f13:	83 c4 18             	add    $0x18,%esp
}
  801f16:	c9                   	leave  
  801f17:	c3                   	ret    

00801f18 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f18:	55                   	push   %ebp
  801f19:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f1b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	6a 00                	push   $0x0
  801f27:	52                   	push   %edx
  801f28:	50                   	push   %eax
  801f29:	6a 1f                	push   $0x1f
  801f2b:	e8 5d fc ff ff       	call   801b8d <syscall>
  801f30:	83 c4 18             	add    $0x18,%esp
}
  801f33:	c9                   	leave  
  801f34:	c3                   	ret    

00801f35 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f35:	55                   	push   %ebp
  801f36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f38:	6a 00                	push   $0x0
  801f3a:	6a 00                	push   $0x0
  801f3c:	6a 00                	push   $0x0
  801f3e:	6a 00                	push   $0x0
  801f40:	6a 00                	push   $0x0
  801f42:	6a 20                	push   $0x20
  801f44:	e8 44 fc ff ff       	call   801b8d <syscall>
  801f49:	83 c4 18             	add    $0x18,%esp
}
  801f4c:	c9                   	leave  
  801f4d:	c3                   	ret    

00801f4e <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f4e:	55                   	push   %ebp
  801f4f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f51:	8b 45 08             	mov    0x8(%ebp),%eax
  801f54:	6a 00                	push   $0x0
  801f56:	ff 75 14             	pushl  0x14(%ebp)
  801f59:	ff 75 10             	pushl  0x10(%ebp)
  801f5c:	ff 75 0c             	pushl  0xc(%ebp)
  801f5f:	50                   	push   %eax
  801f60:	6a 21                	push   $0x21
  801f62:	e8 26 fc ff ff       	call   801b8d <syscall>
  801f67:	83 c4 18             	add    $0x18,%esp
}
  801f6a:	c9                   	leave  
  801f6b:	c3                   	ret    

00801f6c <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801f6c:	55                   	push   %ebp
  801f6d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 00                	push   $0x0
  801f7a:	50                   	push   %eax
  801f7b:	6a 22                	push   $0x22
  801f7d:	e8 0b fc ff ff       	call   801b8d <syscall>
  801f82:	83 c4 18             	add    $0x18,%esp
}
  801f85:	90                   	nop
  801f86:	c9                   	leave  
  801f87:	c3                   	ret    

00801f88 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f88:	55                   	push   %ebp
  801f89:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 00                	push   $0x0
  801f96:	50                   	push   %eax
  801f97:	6a 23                	push   $0x23
  801f99:	e8 ef fb ff ff       	call   801b8d <syscall>
  801f9e:	83 c4 18             	add    $0x18,%esp
}
  801fa1:	90                   	nop
  801fa2:	c9                   	leave  
  801fa3:	c3                   	ret    

00801fa4 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801fa4:	55                   	push   %ebp
  801fa5:	89 e5                	mov    %esp,%ebp
  801fa7:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801faa:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fad:	8d 50 04             	lea    0x4(%eax),%edx
  801fb0:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 00                	push   $0x0
  801fb9:	52                   	push   %edx
  801fba:	50                   	push   %eax
  801fbb:	6a 24                	push   $0x24
  801fbd:	e8 cb fb ff ff       	call   801b8d <syscall>
  801fc2:	83 c4 18             	add    $0x18,%esp
	return result;
  801fc5:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fcb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fce:	89 01                	mov    %eax,(%ecx)
  801fd0:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fd6:	c9                   	leave  
  801fd7:	c2 04 00             	ret    $0x4

00801fda <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fda:	55                   	push   %ebp
  801fdb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fdd:	6a 00                	push   $0x0
  801fdf:	6a 00                	push   $0x0
  801fe1:	ff 75 10             	pushl  0x10(%ebp)
  801fe4:	ff 75 0c             	pushl  0xc(%ebp)
  801fe7:	ff 75 08             	pushl  0x8(%ebp)
  801fea:	6a 13                	push   $0x13
  801fec:	e8 9c fb ff ff       	call   801b8d <syscall>
  801ff1:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff4:	90                   	nop
}
  801ff5:	c9                   	leave  
  801ff6:	c3                   	ret    

00801ff7 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ff7:	55                   	push   %ebp
  801ff8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 25                	push   $0x25
  802006:	e8 82 fb ff ff       	call   801b8d <syscall>
  80200b:	83 c4 18             	add    $0x18,%esp
}
  80200e:	c9                   	leave  
  80200f:	c3                   	ret    

00802010 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802010:	55                   	push   %ebp
  802011:	89 e5                	mov    %esp,%ebp
  802013:	83 ec 04             	sub    $0x4,%esp
  802016:	8b 45 08             	mov    0x8(%ebp),%eax
  802019:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80201c:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 00                	push   $0x0
  802026:	6a 00                	push   $0x0
  802028:	50                   	push   %eax
  802029:	6a 26                	push   $0x26
  80202b:	e8 5d fb ff ff       	call   801b8d <syscall>
  802030:	83 c4 18             	add    $0x18,%esp
	return ;
  802033:	90                   	nop
}
  802034:	c9                   	leave  
  802035:	c3                   	ret    

00802036 <rsttst>:
void rsttst()
{
  802036:	55                   	push   %ebp
  802037:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802039:	6a 00                	push   $0x0
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 28                	push   $0x28
  802045:	e8 43 fb ff ff       	call   801b8d <syscall>
  80204a:	83 c4 18             	add    $0x18,%esp
	return ;
  80204d:	90                   	nop
}
  80204e:	c9                   	leave  
  80204f:	c3                   	ret    

00802050 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802050:	55                   	push   %ebp
  802051:	89 e5                	mov    %esp,%ebp
  802053:	83 ec 04             	sub    $0x4,%esp
  802056:	8b 45 14             	mov    0x14(%ebp),%eax
  802059:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80205c:	8b 55 18             	mov    0x18(%ebp),%edx
  80205f:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802063:	52                   	push   %edx
  802064:	50                   	push   %eax
  802065:	ff 75 10             	pushl  0x10(%ebp)
  802068:	ff 75 0c             	pushl  0xc(%ebp)
  80206b:	ff 75 08             	pushl  0x8(%ebp)
  80206e:	6a 27                	push   $0x27
  802070:	e8 18 fb ff ff       	call   801b8d <syscall>
  802075:	83 c4 18             	add    $0x18,%esp
	return ;
  802078:	90                   	nop
}
  802079:	c9                   	leave  
  80207a:	c3                   	ret    

0080207b <chktst>:
void chktst(uint32 n)
{
  80207b:	55                   	push   %ebp
  80207c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	ff 75 08             	pushl  0x8(%ebp)
  802089:	6a 29                	push   $0x29
  80208b:	e8 fd fa ff ff       	call   801b8d <syscall>
  802090:	83 c4 18             	add    $0x18,%esp
	return ;
  802093:	90                   	nop
}
  802094:	c9                   	leave  
  802095:	c3                   	ret    

00802096 <inctst>:

void inctst()
{
  802096:	55                   	push   %ebp
  802097:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	6a 00                	push   $0x0
  8020a1:	6a 00                	push   $0x0
  8020a3:	6a 2a                	push   $0x2a
  8020a5:	e8 e3 fa ff ff       	call   801b8d <syscall>
  8020aa:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ad:	90                   	nop
}
  8020ae:	c9                   	leave  
  8020af:	c3                   	ret    

008020b0 <gettst>:
uint32 gettst()
{
  8020b0:	55                   	push   %ebp
  8020b1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 00                	push   $0x0
  8020b9:	6a 00                	push   $0x0
  8020bb:	6a 00                	push   $0x0
  8020bd:	6a 2b                	push   $0x2b
  8020bf:	e8 c9 fa ff ff       	call   801b8d <syscall>
  8020c4:	83 c4 18             	add    $0x18,%esp
}
  8020c7:	c9                   	leave  
  8020c8:	c3                   	ret    

008020c9 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020c9:	55                   	push   %ebp
  8020ca:	89 e5                	mov    %esp,%ebp
  8020cc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020cf:	6a 00                	push   $0x0
  8020d1:	6a 00                	push   $0x0
  8020d3:	6a 00                	push   $0x0
  8020d5:	6a 00                	push   $0x0
  8020d7:	6a 00                	push   $0x0
  8020d9:	6a 2c                	push   $0x2c
  8020db:	e8 ad fa ff ff       	call   801b8d <syscall>
  8020e0:	83 c4 18             	add    $0x18,%esp
  8020e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020e6:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020ea:	75 07                	jne    8020f3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020ec:	b8 01 00 00 00       	mov    $0x1,%eax
  8020f1:	eb 05                	jmp    8020f8 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020f3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020f8:	c9                   	leave  
  8020f9:	c3                   	ret    

008020fa <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020fa:	55                   	push   %ebp
  8020fb:	89 e5                	mov    %esp,%ebp
  8020fd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802100:	6a 00                	push   $0x0
  802102:	6a 00                	push   $0x0
  802104:	6a 00                	push   $0x0
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	6a 2c                	push   $0x2c
  80210c:	e8 7c fa ff ff       	call   801b8d <syscall>
  802111:	83 c4 18             	add    $0x18,%esp
  802114:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802117:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  80211b:	75 07                	jne    802124 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  80211d:	b8 01 00 00 00       	mov    $0x1,%eax
  802122:	eb 05                	jmp    802129 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802124:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802129:	c9                   	leave  
  80212a:	c3                   	ret    

0080212b <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  80212b:	55                   	push   %ebp
  80212c:	89 e5                	mov    %esp,%ebp
  80212e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802131:	6a 00                	push   $0x0
  802133:	6a 00                	push   $0x0
  802135:	6a 00                	push   $0x0
  802137:	6a 00                	push   $0x0
  802139:	6a 00                	push   $0x0
  80213b:	6a 2c                	push   $0x2c
  80213d:	e8 4b fa ff ff       	call   801b8d <syscall>
  802142:	83 c4 18             	add    $0x18,%esp
  802145:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802148:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  80214c:	75 07                	jne    802155 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  80214e:	b8 01 00 00 00       	mov    $0x1,%eax
  802153:	eb 05                	jmp    80215a <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802155:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80215a:	c9                   	leave  
  80215b:	c3                   	ret    

0080215c <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  80215c:	55                   	push   %ebp
  80215d:	89 e5                	mov    %esp,%ebp
  80215f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	6a 00                	push   $0x0
  802168:	6a 00                	push   $0x0
  80216a:	6a 00                	push   $0x0
  80216c:	6a 2c                	push   $0x2c
  80216e:	e8 1a fa ff ff       	call   801b8d <syscall>
  802173:	83 c4 18             	add    $0x18,%esp
  802176:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802179:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80217d:	75 07                	jne    802186 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80217f:	b8 01 00 00 00       	mov    $0x1,%eax
  802184:	eb 05                	jmp    80218b <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802186:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80218b:	c9                   	leave  
  80218c:	c3                   	ret    

0080218d <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80218d:	55                   	push   %ebp
  80218e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802190:	6a 00                	push   $0x0
  802192:	6a 00                	push   $0x0
  802194:	6a 00                	push   $0x0
  802196:	6a 00                	push   $0x0
  802198:	ff 75 08             	pushl  0x8(%ebp)
  80219b:	6a 2d                	push   $0x2d
  80219d:	e8 eb f9 ff ff       	call   801b8d <syscall>
  8021a2:	83 c4 18             	add    $0x18,%esp
	return ;
  8021a5:	90                   	nop
}
  8021a6:	c9                   	leave  
  8021a7:	c3                   	ret    

008021a8 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8021a8:	55                   	push   %ebp
  8021a9:	89 e5                	mov    %esp,%ebp
  8021ab:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8021ac:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8021af:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8021b2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8021b8:	6a 00                	push   $0x0
  8021ba:	53                   	push   %ebx
  8021bb:	51                   	push   %ecx
  8021bc:	52                   	push   %edx
  8021bd:	50                   	push   %eax
  8021be:	6a 2e                	push   $0x2e
  8021c0:	e8 c8 f9 ff ff       	call   801b8d <syscall>
  8021c5:	83 c4 18             	add    $0x18,%esp
}
  8021c8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021cb:	c9                   	leave  
  8021cc:	c3                   	ret    

008021cd <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021cd:	55                   	push   %ebp
  8021ce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021d0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 00                	push   $0x0
  8021da:	6a 00                	push   $0x0
  8021dc:	52                   	push   %edx
  8021dd:	50                   	push   %eax
  8021de:	6a 2f                	push   $0x2f
  8021e0:	e8 a8 f9 ff ff       	call   801b8d <syscall>
  8021e5:	83 c4 18             	add    $0x18,%esp
}
  8021e8:	c9                   	leave  
  8021e9:	c3                   	ret    

008021ea <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8021ea:	55                   	push   %ebp
  8021eb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8021ed:	6a 00                	push   $0x0
  8021ef:	6a 00                	push   $0x0
  8021f1:	6a 00                	push   $0x0
  8021f3:	ff 75 0c             	pushl  0xc(%ebp)
  8021f6:	ff 75 08             	pushl  0x8(%ebp)
  8021f9:	6a 30                	push   $0x30
  8021fb:	e8 8d f9 ff ff       	call   801b8d <syscall>
  802200:	83 c4 18             	add    $0x18,%esp
	return ;
  802203:	90                   	nop
}
  802204:	c9                   	leave  
  802205:	c3                   	ret    
  802206:	66 90                	xchg   %ax,%ax

00802208 <__udivdi3>:
  802208:	55                   	push   %ebp
  802209:	57                   	push   %edi
  80220a:	56                   	push   %esi
  80220b:	53                   	push   %ebx
  80220c:	83 ec 1c             	sub    $0x1c,%esp
  80220f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  802213:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802217:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80221b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80221f:	89 ca                	mov    %ecx,%edx
  802221:	89 f8                	mov    %edi,%eax
  802223:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802227:	85 f6                	test   %esi,%esi
  802229:	75 2d                	jne    802258 <__udivdi3+0x50>
  80222b:	39 cf                	cmp    %ecx,%edi
  80222d:	77 65                	ja     802294 <__udivdi3+0x8c>
  80222f:	89 fd                	mov    %edi,%ebp
  802231:	85 ff                	test   %edi,%edi
  802233:	75 0b                	jne    802240 <__udivdi3+0x38>
  802235:	b8 01 00 00 00       	mov    $0x1,%eax
  80223a:	31 d2                	xor    %edx,%edx
  80223c:	f7 f7                	div    %edi
  80223e:	89 c5                	mov    %eax,%ebp
  802240:	31 d2                	xor    %edx,%edx
  802242:	89 c8                	mov    %ecx,%eax
  802244:	f7 f5                	div    %ebp
  802246:	89 c1                	mov    %eax,%ecx
  802248:	89 d8                	mov    %ebx,%eax
  80224a:	f7 f5                	div    %ebp
  80224c:	89 cf                	mov    %ecx,%edi
  80224e:	89 fa                	mov    %edi,%edx
  802250:	83 c4 1c             	add    $0x1c,%esp
  802253:	5b                   	pop    %ebx
  802254:	5e                   	pop    %esi
  802255:	5f                   	pop    %edi
  802256:	5d                   	pop    %ebp
  802257:	c3                   	ret    
  802258:	39 ce                	cmp    %ecx,%esi
  80225a:	77 28                	ja     802284 <__udivdi3+0x7c>
  80225c:	0f bd fe             	bsr    %esi,%edi
  80225f:	83 f7 1f             	xor    $0x1f,%edi
  802262:	75 40                	jne    8022a4 <__udivdi3+0x9c>
  802264:	39 ce                	cmp    %ecx,%esi
  802266:	72 0a                	jb     802272 <__udivdi3+0x6a>
  802268:	3b 44 24 08          	cmp    0x8(%esp),%eax
  80226c:	0f 87 9e 00 00 00    	ja     802310 <__udivdi3+0x108>
  802272:	b8 01 00 00 00       	mov    $0x1,%eax
  802277:	89 fa                	mov    %edi,%edx
  802279:	83 c4 1c             	add    $0x1c,%esp
  80227c:	5b                   	pop    %ebx
  80227d:	5e                   	pop    %esi
  80227e:	5f                   	pop    %edi
  80227f:	5d                   	pop    %ebp
  802280:	c3                   	ret    
  802281:	8d 76 00             	lea    0x0(%esi),%esi
  802284:	31 ff                	xor    %edi,%edi
  802286:	31 c0                	xor    %eax,%eax
  802288:	89 fa                	mov    %edi,%edx
  80228a:	83 c4 1c             	add    $0x1c,%esp
  80228d:	5b                   	pop    %ebx
  80228e:	5e                   	pop    %esi
  80228f:	5f                   	pop    %edi
  802290:	5d                   	pop    %ebp
  802291:	c3                   	ret    
  802292:	66 90                	xchg   %ax,%ax
  802294:	89 d8                	mov    %ebx,%eax
  802296:	f7 f7                	div    %edi
  802298:	31 ff                	xor    %edi,%edi
  80229a:	89 fa                	mov    %edi,%edx
  80229c:	83 c4 1c             	add    $0x1c,%esp
  80229f:	5b                   	pop    %ebx
  8022a0:	5e                   	pop    %esi
  8022a1:	5f                   	pop    %edi
  8022a2:	5d                   	pop    %ebp
  8022a3:	c3                   	ret    
  8022a4:	bd 20 00 00 00       	mov    $0x20,%ebp
  8022a9:	89 eb                	mov    %ebp,%ebx
  8022ab:	29 fb                	sub    %edi,%ebx
  8022ad:	89 f9                	mov    %edi,%ecx
  8022af:	d3 e6                	shl    %cl,%esi
  8022b1:	89 c5                	mov    %eax,%ebp
  8022b3:	88 d9                	mov    %bl,%cl
  8022b5:	d3 ed                	shr    %cl,%ebp
  8022b7:	89 e9                	mov    %ebp,%ecx
  8022b9:	09 f1                	or     %esi,%ecx
  8022bb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8022bf:	89 f9                	mov    %edi,%ecx
  8022c1:	d3 e0                	shl    %cl,%eax
  8022c3:	89 c5                	mov    %eax,%ebp
  8022c5:	89 d6                	mov    %edx,%esi
  8022c7:	88 d9                	mov    %bl,%cl
  8022c9:	d3 ee                	shr    %cl,%esi
  8022cb:	89 f9                	mov    %edi,%ecx
  8022cd:	d3 e2                	shl    %cl,%edx
  8022cf:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022d3:	88 d9                	mov    %bl,%cl
  8022d5:	d3 e8                	shr    %cl,%eax
  8022d7:	09 c2                	or     %eax,%edx
  8022d9:	89 d0                	mov    %edx,%eax
  8022db:	89 f2                	mov    %esi,%edx
  8022dd:	f7 74 24 0c          	divl   0xc(%esp)
  8022e1:	89 d6                	mov    %edx,%esi
  8022e3:	89 c3                	mov    %eax,%ebx
  8022e5:	f7 e5                	mul    %ebp
  8022e7:	39 d6                	cmp    %edx,%esi
  8022e9:	72 19                	jb     802304 <__udivdi3+0xfc>
  8022eb:	74 0b                	je     8022f8 <__udivdi3+0xf0>
  8022ed:	89 d8                	mov    %ebx,%eax
  8022ef:	31 ff                	xor    %edi,%edi
  8022f1:	e9 58 ff ff ff       	jmp    80224e <__udivdi3+0x46>
  8022f6:	66 90                	xchg   %ax,%ax
  8022f8:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022fc:	89 f9                	mov    %edi,%ecx
  8022fe:	d3 e2                	shl    %cl,%edx
  802300:	39 c2                	cmp    %eax,%edx
  802302:	73 e9                	jae    8022ed <__udivdi3+0xe5>
  802304:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802307:	31 ff                	xor    %edi,%edi
  802309:	e9 40 ff ff ff       	jmp    80224e <__udivdi3+0x46>
  80230e:	66 90                	xchg   %ax,%ax
  802310:	31 c0                	xor    %eax,%eax
  802312:	e9 37 ff ff ff       	jmp    80224e <__udivdi3+0x46>
  802317:	90                   	nop

00802318 <__umoddi3>:
  802318:	55                   	push   %ebp
  802319:	57                   	push   %edi
  80231a:	56                   	push   %esi
  80231b:	53                   	push   %ebx
  80231c:	83 ec 1c             	sub    $0x1c,%esp
  80231f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  802323:	8b 74 24 34          	mov    0x34(%esp),%esi
  802327:	8b 7c 24 38          	mov    0x38(%esp),%edi
  80232b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80232f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  802333:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802337:	89 f3                	mov    %esi,%ebx
  802339:	89 fa                	mov    %edi,%edx
  80233b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80233f:	89 34 24             	mov    %esi,(%esp)
  802342:	85 c0                	test   %eax,%eax
  802344:	75 1a                	jne    802360 <__umoddi3+0x48>
  802346:	39 f7                	cmp    %esi,%edi
  802348:	0f 86 a2 00 00 00    	jbe    8023f0 <__umoddi3+0xd8>
  80234e:	89 c8                	mov    %ecx,%eax
  802350:	89 f2                	mov    %esi,%edx
  802352:	f7 f7                	div    %edi
  802354:	89 d0                	mov    %edx,%eax
  802356:	31 d2                	xor    %edx,%edx
  802358:	83 c4 1c             	add    $0x1c,%esp
  80235b:	5b                   	pop    %ebx
  80235c:	5e                   	pop    %esi
  80235d:	5f                   	pop    %edi
  80235e:	5d                   	pop    %ebp
  80235f:	c3                   	ret    
  802360:	39 f0                	cmp    %esi,%eax
  802362:	0f 87 ac 00 00 00    	ja     802414 <__umoddi3+0xfc>
  802368:	0f bd e8             	bsr    %eax,%ebp
  80236b:	83 f5 1f             	xor    $0x1f,%ebp
  80236e:	0f 84 ac 00 00 00    	je     802420 <__umoddi3+0x108>
  802374:	bf 20 00 00 00       	mov    $0x20,%edi
  802379:	29 ef                	sub    %ebp,%edi
  80237b:	89 fe                	mov    %edi,%esi
  80237d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802381:	89 e9                	mov    %ebp,%ecx
  802383:	d3 e0                	shl    %cl,%eax
  802385:	89 d7                	mov    %edx,%edi
  802387:	89 f1                	mov    %esi,%ecx
  802389:	d3 ef                	shr    %cl,%edi
  80238b:	09 c7                	or     %eax,%edi
  80238d:	89 e9                	mov    %ebp,%ecx
  80238f:	d3 e2                	shl    %cl,%edx
  802391:	89 14 24             	mov    %edx,(%esp)
  802394:	89 d8                	mov    %ebx,%eax
  802396:	d3 e0                	shl    %cl,%eax
  802398:	89 c2                	mov    %eax,%edx
  80239a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80239e:	d3 e0                	shl    %cl,%eax
  8023a0:	89 44 24 04          	mov    %eax,0x4(%esp)
  8023a4:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023a8:	89 f1                	mov    %esi,%ecx
  8023aa:	d3 e8                	shr    %cl,%eax
  8023ac:	09 d0                	or     %edx,%eax
  8023ae:	d3 eb                	shr    %cl,%ebx
  8023b0:	89 da                	mov    %ebx,%edx
  8023b2:	f7 f7                	div    %edi
  8023b4:	89 d3                	mov    %edx,%ebx
  8023b6:	f7 24 24             	mull   (%esp)
  8023b9:	89 c6                	mov    %eax,%esi
  8023bb:	89 d1                	mov    %edx,%ecx
  8023bd:	39 d3                	cmp    %edx,%ebx
  8023bf:	0f 82 87 00 00 00    	jb     80244c <__umoddi3+0x134>
  8023c5:	0f 84 91 00 00 00    	je     80245c <__umoddi3+0x144>
  8023cb:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023cf:	29 f2                	sub    %esi,%edx
  8023d1:	19 cb                	sbb    %ecx,%ebx
  8023d3:	89 d8                	mov    %ebx,%eax
  8023d5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023d9:	d3 e0                	shl    %cl,%eax
  8023db:	89 e9                	mov    %ebp,%ecx
  8023dd:	d3 ea                	shr    %cl,%edx
  8023df:	09 d0                	or     %edx,%eax
  8023e1:	89 e9                	mov    %ebp,%ecx
  8023e3:	d3 eb                	shr    %cl,%ebx
  8023e5:	89 da                	mov    %ebx,%edx
  8023e7:	83 c4 1c             	add    $0x1c,%esp
  8023ea:	5b                   	pop    %ebx
  8023eb:	5e                   	pop    %esi
  8023ec:	5f                   	pop    %edi
  8023ed:	5d                   	pop    %ebp
  8023ee:	c3                   	ret    
  8023ef:	90                   	nop
  8023f0:	89 fd                	mov    %edi,%ebp
  8023f2:	85 ff                	test   %edi,%edi
  8023f4:	75 0b                	jne    802401 <__umoddi3+0xe9>
  8023f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8023fb:	31 d2                	xor    %edx,%edx
  8023fd:	f7 f7                	div    %edi
  8023ff:	89 c5                	mov    %eax,%ebp
  802401:	89 f0                	mov    %esi,%eax
  802403:	31 d2                	xor    %edx,%edx
  802405:	f7 f5                	div    %ebp
  802407:	89 c8                	mov    %ecx,%eax
  802409:	f7 f5                	div    %ebp
  80240b:	89 d0                	mov    %edx,%eax
  80240d:	e9 44 ff ff ff       	jmp    802356 <__umoddi3+0x3e>
  802412:	66 90                	xchg   %ax,%ax
  802414:	89 c8                	mov    %ecx,%eax
  802416:	89 f2                	mov    %esi,%edx
  802418:	83 c4 1c             	add    $0x1c,%esp
  80241b:	5b                   	pop    %ebx
  80241c:	5e                   	pop    %esi
  80241d:	5f                   	pop    %edi
  80241e:	5d                   	pop    %ebp
  80241f:	c3                   	ret    
  802420:	3b 04 24             	cmp    (%esp),%eax
  802423:	72 06                	jb     80242b <__umoddi3+0x113>
  802425:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802429:	77 0f                	ja     80243a <__umoddi3+0x122>
  80242b:	89 f2                	mov    %esi,%edx
  80242d:	29 f9                	sub    %edi,%ecx
  80242f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  802433:	89 14 24             	mov    %edx,(%esp)
  802436:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80243a:	8b 44 24 04          	mov    0x4(%esp),%eax
  80243e:	8b 14 24             	mov    (%esp),%edx
  802441:	83 c4 1c             	add    $0x1c,%esp
  802444:	5b                   	pop    %ebx
  802445:	5e                   	pop    %esi
  802446:	5f                   	pop    %edi
  802447:	5d                   	pop    %ebp
  802448:	c3                   	ret    
  802449:	8d 76 00             	lea    0x0(%esi),%esi
  80244c:	2b 04 24             	sub    (%esp),%eax
  80244f:	19 fa                	sbb    %edi,%edx
  802451:	89 d1                	mov    %edx,%ecx
  802453:	89 c6                	mov    %eax,%esi
  802455:	e9 71 ff ff ff       	jmp    8023cb <__umoddi3+0xb3>
  80245a:	66 90                	xchg   %ax,%ax
  80245c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802460:	72 ea                	jb     80244c <__umoddi3+0x134>
  802462:	89 d9                	mov    %ebx,%ecx
  802464:	e9 62 ff ff ff       	jmp    8023cb <__umoddi3+0xb3>
