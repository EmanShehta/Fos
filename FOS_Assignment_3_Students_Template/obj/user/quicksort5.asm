
obj/user/quicksort5:     file format elf32-i386


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
  800031:	e8 96 06 00 00       	call   8006cc <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	81 ec c4 63 00 00    	sub    $0x63c4,%esp
	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[25500] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int32 envID = sys_getenvid();
  800049:	e8 56 1b 00 00       	call   801ba4 <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("cs1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 00 24 80 00       	push   $0x802400
  80005b:	e8 6c 1d 00 00       	call   801dcc <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 20 1c 00 00       	call   801c88 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 32 1c 00 00       	call   801ca1 <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 00 24 80 00       	push   $0x802400
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 7e 1d 00 00       	call   801e05 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 04 24 80 00       	push   $0x802404
  800099:	e8 80 10 00 00       	call   80111e <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 d0 15 00 00       	call   801684 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 63 19 00 00       	call   801a2c <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 24 24 80 00       	push   $0x802424
  8000d7:	e8 c0 09 00 00       	call   800a9c <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 47 24 80 00       	push   $0x802447
  8000e7:	e8 b0 09 00 00       	call   800a9c <cprintf>
  8000ec:	83 c4 10             	add    $0x10,%esp
		int ii, j = 0 ;
  8000ef:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (ii = 0 ; ii < 100000; ii++)
  8000f6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8000fd:	eb 09                	jmp    800108 <_main+0xd0>
		{
			j+= ii;
  8000ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800102:	01 45 ec             	add    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
		cprintf("a) Ascending\n") ;
		int ii, j = 0 ;
		for (ii = 0 ; ii < 100000; ii++)
  800105:	ff 45 f0             	incl   -0x10(%ebp)
  800108:	81 7d f0 9f 86 01 00 	cmpl   $0x1869f,-0x10(%ebp)
  80010f:	7e ee                	jle    8000ff <_main+0xc7>
		{
			j+= ii;
		}
		cprintf("b) Descending\n") ;
  800111:	83 ec 0c             	sub    $0xc,%esp
  800114:	68 55 24 80 00       	push   $0x802455
  800119:	e8 7e 09 00 00       	call   800a9c <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 64 24 80 00       	push   $0x802464
  800129:	e8 6e 09 00 00       	call   800a9c <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 74 24 80 00       	push   $0x802474
  800139:	e8 5e 09 00 00       	call   800a9c <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800141:	e8 2e 05 00 00       	call   800674 <getchar>
  800146:	88 45 db             	mov    %al,-0x25(%ebp)
			cputchar(Chose);
  800149:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	50                   	push   %eax
  800151:	e8 d6 04 00 00       	call   80062c <cputchar>
  800156:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800159:	83 ec 0c             	sub    $0xc,%esp
  80015c:	6a 0a                	push   $0xa
  80015e:	e8 c9 04 00 00       	call   80062c <cputchar>
  800163:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800166:	80 7d db 61          	cmpb   $0x61,-0x25(%ebp)
  80016a:	74 0c                	je     800178 <_main+0x140>
  80016c:	80 7d db 62          	cmpb   $0x62,-0x25(%ebp)
  800170:	74 06                	je     800178 <_main+0x140>
  800172:	80 7d db 63          	cmpb   $0x63,-0x25(%ebp)
  800176:	75 b9                	jne    800131 <_main+0xf9>
		sys_signalSemaphore(envID, "cs1");
  800178:	83 ec 08             	sub    $0x8,%esp
  80017b:	68 00 24 80 00       	push   $0x802400
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 9b 1c 00 00       	call   801e23 <sys_signalSemaphore>
  800188:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  80018b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80018f:	83 f8 62             	cmp    $0x62,%eax
  800192:	74 1d                	je     8001b1 <_main+0x179>
  800194:	83 f8 63             	cmp    $0x63,%eax
  800197:	74 2b                	je     8001c4 <_main+0x18c>
  800199:	83 f8 61             	cmp    $0x61,%eax
  80019c:	75 39                	jne    8001d7 <_main+0x19f>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80019e:	83 ec 08             	sub    $0x8,%esp
  8001a1:	ff 75 e0             	pushl  -0x20(%ebp)
  8001a4:	ff 75 dc             	pushl  -0x24(%ebp)
  8001a7:	e8 48 03 00 00       	call   8004f4 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
			break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ba:	e8 66 03 00 00       	call   800525 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ca:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cd:	e8 88 03 00 00       	call   80055a <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 75 03 00 00       	call   80055a <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ee:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f1:	e8 43 01 00 00       	call   800339 <QuickSort>
  8001f6:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ff:	ff 75 dc             	pushl  -0x24(%ebp)
  800202:	e8 43 02 00 00       	call   80044a <CheckSorted>
  800207:	83 c4 10             	add    $0x10,%esp
  80020a:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80020d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  800211:	75 14                	jne    800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 80 24 80 00       	push   $0x802480
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 a2 24 80 00       	push   $0x8024a2
  800222:	e8 c1 05 00 00       	call   8007e8 <_panic>
		else
		{
			sys_waitSemaphore(envID, "cs1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 00 24 80 00       	push   $0x802400
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 ce 1b 00 00       	call   801e05 <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 b4 24 80 00       	push   $0x8024b4
  800242:	e8 55 08 00 00       	call   800a9c <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 e8 24 80 00       	push   $0x8024e8
  800252:	e8 45 08 00 00       	call   800a9c <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 1c 25 80 00       	push   $0x80251c
  800262:	e8 35 08 00 00       	call   800a9c <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "cs1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 00 24 80 00       	push   $0x802400
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 a9 1b 00 00       	call   801e23 <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		sys_waitSemaphore(envID, "cs1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 00 24 80 00       	push   $0x802400
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 78 1b 00 00       	call   801e05 <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Freeing the Heap...\n\n") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 4e 25 80 00       	push   $0x80254e
  800298:	e8 ff 07 00 00       	call   800a9c <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp
		sys_signalSemaphore(envID,"cs1");
  8002a0:	83 ec 08             	sub    $0x8,%esp
  8002a3:	68 00 24 80 00       	push   $0x802400
  8002a8:	ff 75 e8             	pushl  -0x18(%ebp)
  8002ab:	e8 73 1b 00 00       	call   801e23 <sys_signalSemaphore>
  8002b0:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  8002b3:	83 ec 0c             	sub    $0xc,%esp
  8002b6:	ff 75 dc             	pushl  -0x24(%ebp)
  8002b9:	e8 88 17 00 00       	call   801a46 <free>
  8002be:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  8002c1:	83 ec 08             	sub    $0x8,%esp
  8002c4:	68 00 24 80 00       	push   $0x802400
  8002c9:	ff 75 e8             	pushl  -0x18(%ebp)
  8002cc:	e8 34 1b 00 00       	call   801e05 <sys_waitSemaphore>
  8002d1:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  8002d4:	83 ec 0c             	sub    $0xc,%esp
  8002d7:	68 64 25 80 00       	push   $0x802564
  8002dc:	e8 bb 07 00 00       	call   800a9c <cprintf>
  8002e1:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002e4:	e8 8b 03 00 00       	call   800674 <getchar>
  8002e9:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002ec:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002f0:	83 ec 0c             	sub    $0xc,%esp
  8002f3:	50                   	push   %eax
  8002f4:	e8 33 03 00 00       	call   80062c <cputchar>
  8002f9:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002fc:	83 ec 0c             	sub    $0xc,%esp
  8002ff:	6a 0a                	push   $0xa
  800301:	e8 26 03 00 00       	call   80062c <cputchar>
  800306:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800309:	83 ec 0c             	sub    $0xc,%esp
  80030c:	6a 0a                	push   $0xa
  80030e:	e8 19 03 00 00       	call   80062c <cputchar>
  800313:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID,"cs1");
  800316:	83 ec 08             	sub    $0x8,%esp
  800319:	68 00 24 80 00       	push   $0x802400
  80031e:	ff 75 e8             	pushl  -0x18(%ebp)
  800321:	e8 fd 1a 00 00       	call   801e23 <sys_signalSemaphore>
  800326:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  800329:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  80032d:	0f 84 30 fd ff ff    	je     800063 <_main+0x2b>

}
  800333:	90                   	nop
  800334:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800337:	c9                   	leave  
  800338:	c3                   	ret    

00800339 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  800339:	55                   	push   %ebp
  80033a:	89 e5                	mov    %esp,%ebp
  80033c:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80033f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800342:	48                   	dec    %eax
  800343:	50                   	push   %eax
  800344:	6a 00                	push   $0x0
  800346:	ff 75 0c             	pushl  0xc(%ebp)
  800349:	ff 75 08             	pushl  0x8(%ebp)
  80034c:	e8 06 00 00 00       	call   800357 <QSort>
  800351:	83 c4 10             	add    $0x10,%esp
}
  800354:	90                   	nop
  800355:	c9                   	leave  
  800356:	c3                   	ret    

00800357 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800357:	55                   	push   %ebp
  800358:	89 e5                	mov    %esp,%ebp
  80035a:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80035d:	8b 45 10             	mov    0x10(%ebp),%eax
  800360:	3b 45 14             	cmp    0x14(%ebp),%eax
  800363:	0f 8d de 00 00 00    	jge    800447 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800369:	8b 45 10             	mov    0x10(%ebp),%eax
  80036c:	40                   	inc    %eax
  80036d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800370:	8b 45 14             	mov    0x14(%ebp),%eax
  800373:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800376:	e9 80 00 00 00       	jmp    8003fb <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  80037b:	ff 45 f4             	incl   -0xc(%ebp)
  80037e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800381:	3b 45 14             	cmp    0x14(%ebp),%eax
  800384:	7f 2b                	jg     8003b1 <QSort+0x5a>
  800386:	8b 45 10             	mov    0x10(%ebp),%eax
  800389:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	01 d0                	add    %edx,%eax
  800395:	8b 10                	mov    (%eax),%edx
  800397:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80039a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003a4:	01 c8                	add    %ecx,%eax
  8003a6:	8b 00                	mov    (%eax),%eax
  8003a8:	39 c2                	cmp    %eax,%edx
  8003aa:	7d cf                	jge    80037b <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8003ac:	eb 03                	jmp    8003b1 <QSort+0x5a>
  8003ae:	ff 4d f0             	decl   -0x10(%ebp)
  8003b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003b4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8003b7:	7e 26                	jle    8003df <QSort+0x88>
  8003b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8003bc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c6:	01 d0                	add    %edx,%eax
  8003c8:	8b 10                	mov    (%eax),%edx
  8003ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d7:	01 c8                	add    %ecx,%eax
  8003d9:	8b 00                	mov    (%eax),%eax
  8003db:	39 c2                	cmp    %eax,%edx
  8003dd:	7e cf                	jle    8003ae <QSort+0x57>

		if (i <= j)
  8003df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003e2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003e5:	7f 14                	jg     8003fb <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003e7:	83 ec 04             	sub    $0x4,%esp
  8003ea:	ff 75 f0             	pushl  -0x10(%ebp)
  8003ed:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f0:	ff 75 08             	pushl  0x8(%ebp)
  8003f3:	e8 a9 00 00 00       	call   8004a1 <Swap>
  8003f8:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003fe:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800401:	0f 8e 77 ff ff ff    	jle    80037e <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800407:	83 ec 04             	sub    $0x4,%esp
  80040a:	ff 75 f0             	pushl  -0x10(%ebp)
  80040d:	ff 75 10             	pushl  0x10(%ebp)
  800410:	ff 75 08             	pushl  0x8(%ebp)
  800413:	e8 89 00 00 00       	call   8004a1 <Swap>
  800418:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  80041b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80041e:	48                   	dec    %eax
  80041f:	50                   	push   %eax
  800420:	ff 75 10             	pushl  0x10(%ebp)
  800423:	ff 75 0c             	pushl  0xc(%ebp)
  800426:	ff 75 08             	pushl  0x8(%ebp)
  800429:	e8 29 ff ff ff       	call   800357 <QSort>
  80042e:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  800431:	ff 75 14             	pushl  0x14(%ebp)
  800434:	ff 75 f4             	pushl  -0xc(%ebp)
  800437:	ff 75 0c             	pushl  0xc(%ebp)
  80043a:	ff 75 08             	pushl  0x8(%ebp)
  80043d:	e8 15 ff ff ff       	call   800357 <QSort>
  800442:	83 c4 10             	add    $0x10,%esp
  800445:	eb 01                	jmp    800448 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800447:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800448:	c9                   	leave  
  800449:	c3                   	ret    

0080044a <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  80044a:	55                   	push   %ebp
  80044b:	89 e5                	mov    %esp,%ebp
  80044d:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800450:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800457:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80045e:	eb 33                	jmp    800493 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800460:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800463:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	01 d0                	add    %edx,%eax
  80046f:	8b 10                	mov    (%eax),%edx
  800471:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800474:	40                   	inc    %eax
  800475:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80047c:	8b 45 08             	mov    0x8(%ebp),%eax
  80047f:	01 c8                	add    %ecx,%eax
  800481:	8b 00                	mov    (%eax),%eax
  800483:	39 c2                	cmp    %eax,%edx
  800485:	7e 09                	jle    800490 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800487:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80048e:	eb 0c                	jmp    80049c <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800490:	ff 45 f8             	incl   -0x8(%ebp)
  800493:	8b 45 0c             	mov    0xc(%ebp),%eax
  800496:	48                   	dec    %eax
  800497:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80049a:	7f c4                	jg     800460 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  80049c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80049f:	c9                   	leave  
  8004a0:	c3                   	ret    

008004a1 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8004a1:	55                   	push   %ebp
  8004a2:	89 e5                	mov    %esp,%ebp
  8004a4:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8004a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004aa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b4:	01 d0                	add    %edx,%eax
  8004b6:	8b 00                	mov    (%eax),%eax
  8004b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004c8:	01 c2                	add    %eax,%edx
  8004ca:	8b 45 10             	mov    0x10(%ebp),%eax
  8004cd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8004d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d7:	01 c8                	add    %ecx,%eax
  8004d9:	8b 00                	mov    (%eax),%eax
  8004db:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8004dd:	8b 45 10             	mov    0x10(%ebp),%eax
  8004e0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ea:	01 c2                	add    %eax,%edx
  8004ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ef:	89 02                	mov    %eax,(%edx)
}
  8004f1:	90                   	nop
  8004f2:	c9                   	leave  
  8004f3:	c3                   	ret    

008004f4 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004f4:	55                   	push   %ebp
  8004f5:	89 e5                	mov    %esp,%ebp
  8004f7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004fa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800501:	eb 17                	jmp    80051a <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800503:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800506:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050d:	8b 45 08             	mov    0x8(%ebp),%eax
  800510:	01 c2                	add    %eax,%edx
  800512:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800515:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800517:	ff 45 fc             	incl   -0x4(%ebp)
  80051a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80051d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800520:	7c e1                	jl     800503 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800522:	90                   	nop
  800523:	c9                   	leave  
  800524:	c3                   	ret    

00800525 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800525:	55                   	push   %ebp
  800526:	89 e5                	mov    %esp,%ebp
  800528:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80052b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800532:	eb 1b                	jmp    80054f <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800534:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800537:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053e:	8b 45 08             	mov    0x8(%ebp),%eax
  800541:	01 c2                	add    %eax,%edx
  800543:	8b 45 0c             	mov    0xc(%ebp),%eax
  800546:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800549:	48                   	dec    %eax
  80054a:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80054c:	ff 45 fc             	incl   -0x4(%ebp)
  80054f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800552:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800555:	7c dd                	jl     800534 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800557:	90                   	nop
  800558:	c9                   	leave  
  800559:	c3                   	ret    

0080055a <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  80055a:	55                   	push   %ebp
  80055b:	89 e5                	mov    %esp,%ebp
  80055d:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800560:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800563:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800568:	f7 e9                	imul   %ecx
  80056a:	c1 f9 1f             	sar    $0x1f,%ecx
  80056d:	89 d0                	mov    %edx,%eax
  80056f:	29 c8                	sub    %ecx,%eax
  800571:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800574:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80057b:	eb 1e                	jmp    80059b <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80057d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800580:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800587:	8b 45 08             	mov    0x8(%ebp),%eax
  80058a:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80058d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800590:	99                   	cltd   
  800591:	f7 7d f8             	idivl  -0x8(%ebp)
  800594:	89 d0                	mov    %edx,%eax
  800596:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800598:	ff 45 fc             	incl   -0x4(%ebp)
  80059b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80059e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005a1:	7c da                	jl     80057d <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8005a3:	90                   	nop
  8005a4:	c9                   	leave  
  8005a5:	c3                   	ret    

008005a6 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8005a6:	55                   	push   %ebp
  8005a7:	89 e5                	mov    %esp,%ebp
  8005a9:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8005ac:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005b3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8005ba:	eb 42                	jmp    8005fe <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8005bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005bf:	99                   	cltd   
  8005c0:	f7 7d f0             	idivl  -0x10(%ebp)
  8005c3:	89 d0                	mov    %edx,%eax
  8005c5:	85 c0                	test   %eax,%eax
  8005c7:	75 10                	jne    8005d9 <PrintElements+0x33>
			cprintf("\n");
  8005c9:	83 ec 0c             	sub    $0xc,%esp
  8005cc:	68 82 25 80 00       	push   $0x802582
  8005d1:	e8 c6 04 00 00       	call   800a9c <cprintf>
  8005d6:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8005d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e6:	01 d0                	add    %edx,%eax
  8005e8:	8b 00                	mov    (%eax),%eax
  8005ea:	83 ec 08             	sub    $0x8,%esp
  8005ed:	50                   	push   %eax
  8005ee:	68 84 25 80 00       	push   $0x802584
  8005f3:	e8 a4 04 00 00       	call   800a9c <cprintf>
  8005f8:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005fb:	ff 45 f4             	incl   -0xc(%ebp)
  8005fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800601:	48                   	dec    %eax
  800602:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800605:	7f b5                	jg     8005bc <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800607:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800611:	8b 45 08             	mov    0x8(%ebp),%eax
  800614:	01 d0                	add    %edx,%eax
  800616:	8b 00                	mov    (%eax),%eax
  800618:	83 ec 08             	sub    $0x8,%esp
  80061b:	50                   	push   %eax
  80061c:	68 89 25 80 00       	push   $0x802589
  800621:	e8 76 04 00 00       	call   800a9c <cprintf>
  800626:	83 c4 10             	add    $0x10,%esp

}
  800629:	90                   	nop
  80062a:	c9                   	leave  
  80062b:	c3                   	ret    

0080062c <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80062c:	55                   	push   %ebp
  80062d:	89 e5                	mov    %esp,%ebp
  80062f:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800632:	8b 45 08             	mov    0x8(%ebp),%eax
  800635:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800638:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80063c:	83 ec 0c             	sub    $0xc,%esp
  80063f:	50                   	push   %eax
  800640:	e8 47 17 00 00       	call   801d8c <sys_cputc>
  800645:	83 c4 10             	add    $0x10,%esp
}
  800648:	90                   	nop
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
  80064e:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800651:	e8 02 17 00 00       	call   801d58 <sys_disable_interrupt>
	char c = ch;
  800656:	8b 45 08             	mov    0x8(%ebp),%eax
  800659:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80065c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800660:	83 ec 0c             	sub    $0xc,%esp
  800663:	50                   	push   %eax
  800664:	e8 23 17 00 00       	call   801d8c <sys_cputc>
  800669:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80066c:	e8 01 17 00 00       	call   801d72 <sys_enable_interrupt>
}
  800671:	90                   	nop
  800672:	c9                   	leave  
  800673:	c3                   	ret    

00800674 <getchar>:

int
getchar(void)
{
  800674:	55                   	push   %ebp
  800675:	89 e5                	mov    %esp,%ebp
  800677:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  80067a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800681:	eb 08                	jmp    80068b <getchar+0x17>
	{
		c = sys_cgetc();
  800683:	e8 e8 14 00 00       	call   801b70 <sys_cgetc>
  800688:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  80068b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80068f:	74 f2                	je     800683 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800694:	c9                   	leave  
  800695:	c3                   	ret    

00800696 <atomic_getchar>:

int
atomic_getchar(void)
{
  800696:	55                   	push   %ebp
  800697:	89 e5                	mov    %esp,%ebp
  800699:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80069c:	e8 b7 16 00 00       	call   801d58 <sys_disable_interrupt>
	int c=0;
  8006a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8006a8:	eb 08                	jmp    8006b2 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8006aa:	e8 c1 14 00 00       	call   801b70 <sys_cgetc>
  8006af:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8006b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8006b6:	74 f2                	je     8006aa <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8006b8:	e8 b5 16 00 00       	call   801d72 <sys_enable_interrupt>
	return c;
  8006bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8006c0:	c9                   	leave  
  8006c1:	c3                   	ret    

008006c2 <iscons>:

int iscons(int fdnum)
{
  8006c2:	55                   	push   %ebp
  8006c3:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8006c5:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8006ca:	5d                   	pop    %ebp
  8006cb:	c3                   	ret    

008006cc <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8006cc:	55                   	push   %ebp
  8006cd:	89 e5                	mov    %esp,%ebp
  8006cf:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8006d2:	e8 e6 14 00 00       	call   801bbd <sys_getenvindex>
  8006d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8006da:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006dd:	89 d0                	mov    %edx,%eax
  8006df:	01 c0                	add    %eax,%eax
  8006e1:	01 d0                	add    %edx,%eax
  8006e3:	c1 e0 04             	shl    $0x4,%eax
  8006e6:	29 d0                	sub    %edx,%eax
  8006e8:	c1 e0 03             	shl    $0x3,%eax
  8006eb:	01 d0                	add    %edx,%eax
  8006ed:	c1 e0 02             	shl    $0x2,%eax
  8006f0:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006f5:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006fa:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ff:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800705:	84 c0                	test   %al,%al
  800707:	74 0f                	je     800718 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800709:	a1 24 30 80 00       	mov    0x803024,%eax
  80070e:	05 5c 05 00 00       	add    $0x55c,%eax
  800713:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800718:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80071c:	7e 0a                	jle    800728 <libmain+0x5c>
		binaryname = argv[0];
  80071e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800721:	8b 00                	mov    (%eax),%eax
  800723:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800728:	83 ec 08             	sub    $0x8,%esp
  80072b:	ff 75 0c             	pushl  0xc(%ebp)
  80072e:	ff 75 08             	pushl  0x8(%ebp)
  800731:	e8 02 f9 ff ff       	call   800038 <_main>
  800736:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800739:	e8 1a 16 00 00       	call   801d58 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80073e:	83 ec 0c             	sub    $0xc,%esp
  800741:	68 a8 25 80 00       	push   $0x8025a8
  800746:	e8 51 03 00 00       	call   800a9c <cprintf>
  80074b:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80074e:	a1 24 30 80 00       	mov    0x803024,%eax
  800753:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800759:	a1 24 30 80 00       	mov    0x803024,%eax
  80075e:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800764:	83 ec 04             	sub    $0x4,%esp
  800767:	52                   	push   %edx
  800768:	50                   	push   %eax
  800769:	68 d0 25 80 00       	push   $0x8025d0
  80076e:	e8 29 03 00 00       	call   800a9c <cprintf>
  800773:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800776:	a1 24 30 80 00       	mov    0x803024,%eax
  80077b:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800781:	a1 24 30 80 00       	mov    0x803024,%eax
  800786:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  80078c:	a1 24 30 80 00       	mov    0x803024,%eax
  800791:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800797:	51                   	push   %ecx
  800798:	52                   	push   %edx
  800799:	50                   	push   %eax
  80079a:	68 f8 25 80 00       	push   $0x8025f8
  80079f:	e8 f8 02 00 00       	call   800a9c <cprintf>
  8007a4:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8007a7:	83 ec 0c             	sub    $0xc,%esp
  8007aa:	68 a8 25 80 00       	push   $0x8025a8
  8007af:	e8 e8 02 00 00       	call   800a9c <cprintf>
  8007b4:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007b7:	e8 b6 15 00 00       	call   801d72 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8007bc:	e8 19 00 00 00       	call   8007da <exit>
}
  8007c1:	90                   	nop
  8007c2:	c9                   	leave  
  8007c3:	c3                   	ret    

008007c4 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8007c4:	55                   	push   %ebp
  8007c5:	89 e5                	mov    %esp,%ebp
  8007c7:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8007ca:	83 ec 0c             	sub    $0xc,%esp
  8007cd:	6a 00                	push   $0x0
  8007cf:	e8 b5 13 00 00       	call   801b89 <sys_env_destroy>
  8007d4:	83 c4 10             	add    $0x10,%esp
}
  8007d7:	90                   	nop
  8007d8:	c9                   	leave  
  8007d9:	c3                   	ret    

008007da <exit>:

void
exit(void)
{
  8007da:	55                   	push   %ebp
  8007db:	89 e5                	mov    %esp,%ebp
  8007dd:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8007e0:	e8 0a 14 00 00       	call   801bef <sys_env_exit>
}
  8007e5:	90                   	nop
  8007e6:	c9                   	leave  
  8007e7:	c3                   	ret    

008007e8 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007e8:	55                   	push   %ebp
  8007e9:	89 e5                	mov    %esp,%ebp
  8007eb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007ee:	8d 45 10             	lea    0x10(%ebp),%eax
  8007f1:	83 c0 04             	add    $0x4,%eax
  8007f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007f7:	a1 18 31 80 00       	mov    0x803118,%eax
  8007fc:	85 c0                	test   %eax,%eax
  8007fe:	74 16                	je     800816 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800800:	a1 18 31 80 00       	mov    0x803118,%eax
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	50                   	push   %eax
  800809:	68 50 26 80 00       	push   $0x802650
  80080e:	e8 89 02 00 00       	call   800a9c <cprintf>
  800813:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800816:	a1 00 30 80 00       	mov    0x803000,%eax
  80081b:	ff 75 0c             	pushl  0xc(%ebp)
  80081e:	ff 75 08             	pushl  0x8(%ebp)
  800821:	50                   	push   %eax
  800822:	68 55 26 80 00       	push   $0x802655
  800827:	e8 70 02 00 00       	call   800a9c <cprintf>
  80082c:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80082f:	8b 45 10             	mov    0x10(%ebp),%eax
  800832:	83 ec 08             	sub    $0x8,%esp
  800835:	ff 75 f4             	pushl  -0xc(%ebp)
  800838:	50                   	push   %eax
  800839:	e8 f3 01 00 00       	call   800a31 <vcprintf>
  80083e:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800841:	83 ec 08             	sub    $0x8,%esp
  800844:	6a 00                	push   $0x0
  800846:	68 71 26 80 00       	push   $0x802671
  80084b:	e8 e1 01 00 00       	call   800a31 <vcprintf>
  800850:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800853:	e8 82 ff ff ff       	call   8007da <exit>

	// should not return here
	while (1) ;
  800858:	eb fe                	jmp    800858 <_panic+0x70>

0080085a <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80085a:	55                   	push   %ebp
  80085b:	89 e5                	mov    %esp,%ebp
  80085d:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800860:	a1 24 30 80 00       	mov    0x803024,%eax
  800865:	8b 50 74             	mov    0x74(%eax),%edx
  800868:	8b 45 0c             	mov    0xc(%ebp),%eax
  80086b:	39 c2                	cmp    %eax,%edx
  80086d:	74 14                	je     800883 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80086f:	83 ec 04             	sub    $0x4,%esp
  800872:	68 74 26 80 00       	push   $0x802674
  800877:	6a 26                	push   $0x26
  800879:	68 c0 26 80 00       	push   $0x8026c0
  80087e:	e8 65 ff ff ff       	call   8007e8 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800883:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80088a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800891:	e9 c2 00 00 00       	jmp    800958 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800896:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800899:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8008a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a3:	01 d0                	add    %edx,%eax
  8008a5:	8b 00                	mov    (%eax),%eax
  8008a7:	85 c0                	test   %eax,%eax
  8008a9:	75 08                	jne    8008b3 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8008ab:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8008ae:	e9 a2 00 00 00       	jmp    800955 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8008b3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ba:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8008c1:	eb 69                	jmp    80092c <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8008c3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008c8:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8008ce:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008d1:	89 d0                	mov    %edx,%eax
  8008d3:	01 c0                	add    %eax,%eax
  8008d5:	01 d0                	add    %edx,%eax
  8008d7:	c1 e0 03             	shl    $0x3,%eax
  8008da:	01 c8                	add    %ecx,%eax
  8008dc:	8a 40 04             	mov    0x4(%eax),%al
  8008df:	84 c0                	test   %al,%al
  8008e1:	75 46                	jne    800929 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008e3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e8:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8008ee:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008f1:	89 d0                	mov    %edx,%eax
  8008f3:	01 c0                	add    %eax,%eax
  8008f5:	01 d0                	add    %edx,%eax
  8008f7:	c1 e0 03             	shl    $0x3,%eax
  8008fa:	01 c8                	add    %ecx,%eax
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800901:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800904:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800909:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80090b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80090e:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	01 c8                	add    %ecx,%eax
  80091a:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80091c:	39 c2                	cmp    %eax,%edx
  80091e:	75 09                	jne    800929 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800920:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800927:	eb 12                	jmp    80093b <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800929:	ff 45 e8             	incl   -0x18(%ebp)
  80092c:	a1 24 30 80 00       	mov    0x803024,%eax
  800931:	8b 50 74             	mov    0x74(%eax),%edx
  800934:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800937:	39 c2                	cmp    %eax,%edx
  800939:	77 88                	ja     8008c3 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80093b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80093f:	75 14                	jne    800955 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800941:	83 ec 04             	sub    $0x4,%esp
  800944:	68 cc 26 80 00       	push   $0x8026cc
  800949:	6a 3a                	push   $0x3a
  80094b:	68 c0 26 80 00       	push   $0x8026c0
  800950:	e8 93 fe ff ff       	call   8007e8 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800955:	ff 45 f0             	incl   -0x10(%ebp)
  800958:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80095b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80095e:	0f 8c 32 ff ff ff    	jl     800896 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800964:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80096b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800972:	eb 26                	jmp    80099a <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800974:	a1 24 30 80 00       	mov    0x803024,%eax
  800979:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80097f:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800982:	89 d0                	mov    %edx,%eax
  800984:	01 c0                	add    %eax,%eax
  800986:	01 d0                	add    %edx,%eax
  800988:	c1 e0 03             	shl    $0x3,%eax
  80098b:	01 c8                	add    %ecx,%eax
  80098d:	8a 40 04             	mov    0x4(%eax),%al
  800990:	3c 01                	cmp    $0x1,%al
  800992:	75 03                	jne    800997 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800994:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800997:	ff 45 e0             	incl   -0x20(%ebp)
  80099a:	a1 24 30 80 00       	mov    0x803024,%eax
  80099f:	8b 50 74             	mov    0x74(%eax),%edx
  8009a2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009a5:	39 c2                	cmp    %eax,%edx
  8009a7:	77 cb                	ja     800974 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8009a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8009ac:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8009af:	74 14                	je     8009c5 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8009b1:	83 ec 04             	sub    $0x4,%esp
  8009b4:	68 20 27 80 00       	push   $0x802720
  8009b9:	6a 44                	push   $0x44
  8009bb:	68 c0 26 80 00       	push   $0x8026c0
  8009c0:	e8 23 fe ff ff       	call   8007e8 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8009c5:	90                   	nop
  8009c6:	c9                   	leave  
  8009c7:	c3                   	ret    

008009c8 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8009c8:	55                   	push   %ebp
  8009c9:	89 e5                	mov    %esp,%ebp
  8009cb:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8009ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d1:	8b 00                	mov    (%eax),%eax
  8009d3:	8d 48 01             	lea    0x1(%eax),%ecx
  8009d6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009d9:	89 0a                	mov    %ecx,(%edx)
  8009db:	8b 55 08             	mov    0x8(%ebp),%edx
  8009de:	88 d1                	mov    %dl,%cl
  8009e0:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009e3:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ea:	8b 00                	mov    (%eax),%eax
  8009ec:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009f1:	75 2c                	jne    800a1f <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009f3:	a0 28 30 80 00       	mov    0x803028,%al
  8009f8:	0f b6 c0             	movzbl %al,%eax
  8009fb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009fe:	8b 12                	mov    (%edx),%edx
  800a00:	89 d1                	mov    %edx,%ecx
  800a02:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a05:	83 c2 08             	add    $0x8,%edx
  800a08:	83 ec 04             	sub    $0x4,%esp
  800a0b:	50                   	push   %eax
  800a0c:	51                   	push   %ecx
  800a0d:	52                   	push   %edx
  800a0e:	e8 34 11 00 00       	call   801b47 <sys_cputs>
  800a13:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800a16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a19:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800a1f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a22:	8b 40 04             	mov    0x4(%eax),%eax
  800a25:	8d 50 01             	lea    0x1(%eax),%edx
  800a28:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a2b:	89 50 04             	mov    %edx,0x4(%eax)
}
  800a2e:	90                   	nop
  800a2f:	c9                   	leave  
  800a30:	c3                   	ret    

00800a31 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800a31:	55                   	push   %ebp
  800a32:	89 e5                	mov    %esp,%ebp
  800a34:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800a3a:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800a41:	00 00 00 
	b.cnt = 0;
  800a44:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a4b:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a4e:	ff 75 0c             	pushl  0xc(%ebp)
  800a51:	ff 75 08             	pushl  0x8(%ebp)
  800a54:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a5a:	50                   	push   %eax
  800a5b:	68 c8 09 80 00       	push   $0x8009c8
  800a60:	e8 11 02 00 00       	call   800c76 <vprintfmt>
  800a65:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a68:	a0 28 30 80 00       	mov    0x803028,%al
  800a6d:	0f b6 c0             	movzbl %al,%eax
  800a70:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a76:	83 ec 04             	sub    $0x4,%esp
  800a79:	50                   	push   %eax
  800a7a:	52                   	push   %edx
  800a7b:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a81:	83 c0 08             	add    $0x8,%eax
  800a84:	50                   	push   %eax
  800a85:	e8 bd 10 00 00       	call   801b47 <sys_cputs>
  800a8a:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a8d:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a94:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a9a:	c9                   	leave  
  800a9b:	c3                   	ret    

00800a9c <cprintf>:

int cprintf(const char *fmt, ...) {
  800a9c:	55                   	push   %ebp
  800a9d:	89 e5                	mov    %esp,%ebp
  800a9f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800aa2:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800aa9:	8d 45 0c             	lea    0xc(%ebp),%eax
  800aac:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800aaf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab2:	83 ec 08             	sub    $0x8,%esp
  800ab5:	ff 75 f4             	pushl  -0xc(%ebp)
  800ab8:	50                   	push   %eax
  800ab9:	e8 73 ff ff ff       	call   800a31 <vcprintf>
  800abe:	83 c4 10             	add    $0x10,%esp
  800ac1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ac4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ac7:	c9                   	leave  
  800ac8:	c3                   	ret    

00800ac9 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ac9:	55                   	push   %ebp
  800aca:	89 e5                	mov    %esp,%ebp
  800acc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800acf:	e8 84 12 00 00       	call   801d58 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800ad4:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ad7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ada:	8b 45 08             	mov    0x8(%ebp),%eax
  800add:	83 ec 08             	sub    $0x8,%esp
  800ae0:	ff 75 f4             	pushl  -0xc(%ebp)
  800ae3:	50                   	push   %eax
  800ae4:	e8 48 ff ff ff       	call   800a31 <vcprintf>
  800ae9:	83 c4 10             	add    $0x10,%esp
  800aec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800aef:	e8 7e 12 00 00       	call   801d72 <sys_enable_interrupt>
	return cnt;
  800af4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800af7:	c9                   	leave  
  800af8:	c3                   	ret    

00800af9 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800af9:	55                   	push   %ebp
  800afa:	89 e5                	mov    %esp,%ebp
  800afc:	53                   	push   %ebx
  800afd:	83 ec 14             	sub    $0x14,%esp
  800b00:	8b 45 10             	mov    0x10(%ebp),%eax
  800b03:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b06:	8b 45 14             	mov    0x14(%ebp),%eax
  800b09:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800b0c:	8b 45 18             	mov    0x18(%ebp),%eax
  800b0f:	ba 00 00 00 00       	mov    $0x0,%edx
  800b14:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b17:	77 55                	ja     800b6e <printnum+0x75>
  800b19:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800b1c:	72 05                	jb     800b23 <printnum+0x2a>
  800b1e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800b21:	77 4b                	ja     800b6e <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800b23:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800b26:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800b29:	8b 45 18             	mov    0x18(%ebp),%eax
  800b2c:	ba 00 00 00 00       	mov    $0x0,%edx
  800b31:	52                   	push   %edx
  800b32:	50                   	push   %eax
  800b33:	ff 75 f4             	pushl  -0xc(%ebp)
  800b36:	ff 75 f0             	pushl  -0x10(%ebp)
  800b39:	e8 5a 16 00 00       	call   802198 <__udivdi3>
  800b3e:	83 c4 10             	add    $0x10,%esp
  800b41:	83 ec 04             	sub    $0x4,%esp
  800b44:	ff 75 20             	pushl  0x20(%ebp)
  800b47:	53                   	push   %ebx
  800b48:	ff 75 18             	pushl  0x18(%ebp)
  800b4b:	52                   	push   %edx
  800b4c:	50                   	push   %eax
  800b4d:	ff 75 0c             	pushl  0xc(%ebp)
  800b50:	ff 75 08             	pushl  0x8(%ebp)
  800b53:	e8 a1 ff ff ff       	call   800af9 <printnum>
  800b58:	83 c4 20             	add    $0x20,%esp
  800b5b:	eb 1a                	jmp    800b77 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b5d:	83 ec 08             	sub    $0x8,%esp
  800b60:	ff 75 0c             	pushl  0xc(%ebp)
  800b63:	ff 75 20             	pushl  0x20(%ebp)
  800b66:	8b 45 08             	mov    0x8(%ebp),%eax
  800b69:	ff d0                	call   *%eax
  800b6b:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b6e:	ff 4d 1c             	decl   0x1c(%ebp)
  800b71:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b75:	7f e6                	jg     800b5d <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b77:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b7a:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b82:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b85:	53                   	push   %ebx
  800b86:	51                   	push   %ecx
  800b87:	52                   	push   %edx
  800b88:	50                   	push   %eax
  800b89:	e8 1a 17 00 00       	call   8022a8 <__umoddi3>
  800b8e:	83 c4 10             	add    $0x10,%esp
  800b91:	05 94 29 80 00       	add    $0x802994,%eax
  800b96:	8a 00                	mov    (%eax),%al
  800b98:	0f be c0             	movsbl %al,%eax
  800b9b:	83 ec 08             	sub    $0x8,%esp
  800b9e:	ff 75 0c             	pushl  0xc(%ebp)
  800ba1:	50                   	push   %eax
  800ba2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba5:	ff d0                	call   *%eax
  800ba7:	83 c4 10             	add    $0x10,%esp
}
  800baa:	90                   	nop
  800bab:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800bae:	c9                   	leave  
  800baf:	c3                   	ret    

00800bb0 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800bb0:	55                   	push   %ebp
  800bb1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bb3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bb7:	7e 1c                	jle    800bd5 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800bb9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbc:	8b 00                	mov    (%eax),%eax
  800bbe:	8d 50 08             	lea    0x8(%eax),%edx
  800bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc4:	89 10                	mov    %edx,(%eax)
  800bc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc9:	8b 00                	mov    (%eax),%eax
  800bcb:	83 e8 08             	sub    $0x8,%eax
  800bce:	8b 50 04             	mov    0x4(%eax),%edx
  800bd1:	8b 00                	mov    (%eax),%eax
  800bd3:	eb 40                	jmp    800c15 <getuint+0x65>
	else if (lflag)
  800bd5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bd9:	74 1e                	je     800bf9 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800bdb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bde:	8b 00                	mov    (%eax),%eax
  800be0:	8d 50 04             	lea    0x4(%eax),%edx
  800be3:	8b 45 08             	mov    0x8(%ebp),%eax
  800be6:	89 10                	mov    %edx,(%eax)
  800be8:	8b 45 08             	mov    0x8(%ebp),%eax
  800beb:	8b 00                	mov    (%eax),%eax
  800bed:	83 e8 04             	sub    $0x4,%eax
  800bf0:	8b 00                	mov    (%eax),%eax
  800bf2:	ba 00 00 00 00       	mov    $0x0,%edx
  800bf7:	eb 1c                	jmp    800c15 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bf9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bfc:	8b 00                	mov    (%eax),%eax
  800bfe:	8d 50 04             	lea    0x4(%eax),%edx
  800c01:	8b 45 08             	mov    0x8(%ebp),%eax
  800c04:	89 10                	mov    %edx,(%eax)
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	8b 00                	mov    (%eax),%eax
  800c0b:	83 e8 04             	sub    $0x4,%eax
  800c0e:	8b 00                	mov    (%eax),%eax
  800c10:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800c15:	5d                   	pop    %ebp
  800c16:	c3                   	ret    

00800c17 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800c17:	55                   	push   %ebp
  800c18:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c1a:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c1e:	7e 1c                	jle    800c3c <getint+0x25>
		return va_arg(*ap, long long);
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	8b 00                	mov    (%eax),%eax
  800c25:	8d 50 08             	lea    0x8(%eax),%edx
  800c28:	8b 45 08             	mov    0x8(%ebp),%eax
  800c2b:	89 10                	mov    %edx,(%eax)
  800c2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c30:	8b 00                	mov    (%eax),%eax
  800c32:	83 e8 08             	sub    $0x8,%eax
  800c35:	8b 50 04             	mov    0x4(%eax),%edx
  800c38:	8b 00                	mov    (%eax),%eax
  800c3a:	eb 38                	jmp    800c74 <getint+0x5d>
	else if (lflag)
  800c3c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c40:	74 1a                	je     800c5c <getint+0x45>
		return va_arg(*ap, long);
  800c42:	8b 45 08             	mov    0x8(%ebp),%eax
  800c45:	8b 00                	mov    (%eax),%eax
  800c47:	8d 50 04             	lea    0x4(%eax),%edx
  800c4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4d:	89 10                	mov    %edx,(%eax)
  800c4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c52:	8b 00                	mov    (%eax),%eax
  800c54:	83 e8 04             	sub    $0x4,%eax
  800c57:	8b 00                	mov    (%eax),%eax
  800c59:	99                   	cltd   
  800c5a:	eb 18                	jmp    800c74 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c5f:	8b 00                	mov    (%eax),%eax
  800c61:	8d 50 04             	lea    0x4(%eax),%edx
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	89 10                	mov    %edx,(%eax)
  800c69:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6c:	8b 00                	mov    (%eax),%eax
  800c6e:	83 e8 04             	sub    $0x4,%eax
  800c71:	8b 00                	mov    (%eax),%eax
  800c73:	99                   	cltd   
}
  800c74:	5d                   	pop    %ebp
  800c75:	c3                   	ret    

00800c76 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c76:	55                   	push   %ebp
  800c77:	89 e5                	mov    %esp,%ebp
  800c79:	56                   	push   %esi
  800c7a:	53                   	push   %ebx
  800c7b:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c7e:	eb 17                	jmp    800c97 <vprintfmt+0x21>
			if (ch == '\0')
  800c80:	85 db                	test   %ebx,%ebx
  800c82:	0f 84 af 03 00 00    	je     801037 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c88:	83 ec 08             	sub    $0x8,%esp
  800c8b:	ff 75 0c             	pushl  0xc(%ebp)
  800c8e:	53                   	push   %ebx
  800c8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c92:	ff d0                	call   *%eax
  800c94:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c97:	8b 45 10             	mov    0x10(%ebp),%eax
  800c9a:	8d 50 01             	lea    0x1(%eax),%edx
  800c9d:	89 55 10             	mov    %edx,0x10(%ebp)
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	0f b6 d8             	movzbl %al,%ebx
  800ca5:	83 fb 25             	cmp    $0x25,%ebx
  800ca8:	75 d6                	jne    800c80 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800caa:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800cae:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800cb5:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800cbc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800cc3:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800cca:	8b 45 10             	mov    0x10(%ebp),%eax
  800ccd:	8d 50 01             	lea    0x1(%eax),%edx
  800cd0:	89 55 10             	mov    %edx,0x10(%ebp)
  800cd3:	8a 00                	mov    (%eax),%al
  800cd5:	0f b6 d8             	movzbl %al,%ebx
  800cd8:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800cdb:	83 f8 55             	cmp    $0x55,%eax
  800cde:	0f 87 2b 03 00 00    	ja     80100f <vprintfmt+0x399>
  800ce4:	8b 04 85 b8 29 80 00 	mov    0x8029b8(,%eax,4),%eax
  800ceb:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ced:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cf1:	eb d7                	jmp    800cca <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800cf3:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cf7:	eb d1                	jmp    800cca <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cf9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800d00:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800d03:	89 d0                	mov    %edx,%eax
  800d05:	c1 e0 02             	shl    $0x2,%eax
  800d08:	01 d0                	add    %edx,%eax
  800d0a:	01 c0                	add    %eax,%eax
  800d0c:	01 d8                	add    %ebx,%eax
  800d0e:	83 e8 30             	sub    $0x30,%eax
  800d11:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800d14:	8b 45 10             	mov    0x10(%ebp),%eax
  800d17:	8a 00                	mov    (%eax),%al
  800d19:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800d1c:	83 fb 2f             	cmp    $0x2f,%ebx
  800d1f:	7e 3e                	jle    800d5f <vprintfmt+0xe9>
  800d21:	83 fb 39             	cmp    $0x39,%ebx
  800d24:	7f 39                	jg     800d5f <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800d26:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800d29:	eb d5                	jmp    800d00 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800d2b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2e:	83 c0 04             	add    $0x4,%eax
  800d31:	89 45 14             	mov    %eax,0x14(%ebp)
  800d34:	8b 45 14             	mov    0x14(%ebp),%eax
  800d37:	83 e8 04             	sub    $0x4,%eax
  800d3a:	8b 00                	mov    (%eax),%eax
  800d3c:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800d3f:	eb 1f                	jmp    800d60 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800d41:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d45:	79 83                	jns    800cca <vprintfmt+0x54>
				width = 0;
  800d47:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d4e:	e9 77 ff ff ff       	jmp    800cca <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d53:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d5a:	e9 6b ff ff ff       	jmp    800cca <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d5f:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d60:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d64:	0f 89 60 ff ff ff    	jns    800cca <vprintfmt+0x54>
				width = precision, precision = -1;
  800d6a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d6d:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d70:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d77:	e9 4e ff ff ff       	jmp    800cca <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d7c:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d7f:	e9 46 ff ff ff       	jmp    800cca <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d84:	8b 45 14             	mov    0x14(%ebp),%eax
  800d87:	83 c0 04             	add    $0x4,%eax
  800d8a:	89 45 14             	mov    %eax,0x14(%ebp)
  800d8d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d90:	83 e8 04             	sub    $0x4,%eax
  800d93:	8b 00                	mov    (%eax),%eax
  800d95:	83 ec 08             	sub    $0x8,%esp
  800d98:	ff 75 0c             	pushl  0xc(%ebp)
  800d9b:	50                   	push   %eax
  800d9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9f:	ff d0                	call   *%eax
  800da1:	83 c4 10             	add    $0x10,%esp
			break;
  800da4:	e9 89 02 00 00       	jmp    801032 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800da9:	8b 45 14             	mov    0x14(%ebp),%eax
  800dac:	83 c0 04             	add    $0x4,%eax
  800daf:	89 45 14             	mov    %eax,0x14(%ebp)
  800db2:	8b 45 14             	mov    0x14(%ebp),%eax
  800db5:	83 e8 04             	sub    $0x4,%eax
  800db8:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800dba:	85 db                	test   %ebx,%ebx
  800dbc:	79 02                	jns    800dc0 <vprintfmt+0x14a>
				err = -err;
  800dbe:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800dc0:	83 fb 64             	cmp    $0x64,%ebx
  800dc3:	7f 0b                	jg     800dd0 <vprintfmt+0x15a>
  800dc5:	8b 34 9d 00 28 80 00 	mov    0x802800(,%ebx,4),%esi
  800dcc:	85 f6                	test   %esi,%esi
  800dce:	75 19                	jne    800de9 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800dd0:	53                   	push   %ebx
  800dd1:	68 a5 29 80 00       	push   $0x8029a5
  800dd6:	ff 75 0c             	pushl  0xc(%ebp)
  800dd9:	ff 75 08             	pushl  0x8(%ebp)
  800ddc:	e8 5e 02 00 00       	call   80103f <printfmt>
  800de1:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800de4:	e9 49 02 00 00       	jmp    801032 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800de9:	56                   	push   %esi
  800dea:	68 ae 29 80 00       	push   $0x8029ae
  800def:	ff 75 0c             	pushl  0xc(%ebp)
  800df2:	ff 75 08             	pushl  0x8(%ebp)
  800df5:	e8 45 02 00 00       	call   80103f <printfmt>
  800dfa:	83 c4 10             	add    $0x10,%esp
			break;
  800dfd:	e9 30 02 00 00       	jmp    801032 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800e02:	8b 45 14             	mov    0x14(%ebp),%eax
  800e05:	83 c0 04             	add    $0x4,%eax
  800e08:	89 45 14             	mov    %eax,0x14(%ebp)
  800e0b:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0e:	83 e8 04             	sub    $0x4,%eax
  800e11:	8b 30                	mov    (%eax),%esi
  800e13:	85 f6                	test   %esi,%esi
  800e15:	75 05                	jne    800e1c <vprintfmt+0x1a6>
				p = "(null)";
  800e17:	be b1 29 80 00       	mov    $0x8029b1,%esi
			if (width > 0 && padc != '-')
  800e1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e20:	7e 6d                	jle    800e8f <vprintfmt+0x219>
  800e22:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800e26:	74 67                	je     800e8f <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800e28:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e2b:	83 ec 08             	sub    $0x8,%esp
  800e2e:	50                   	push   %eax
  800e2f:	56                   	push   %esi
  800e30:	e8 12 05 00 00       	call   801347 <strnlen>
  800e35:	83 c4 10             	add    $0x10,%esp
  800e38:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800e3b:	eb 16                	jmp    800e53 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800e3d:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800e41:	83 ec 08             	sub    $0x8,%esp
  800e44:	ff 75 0c             	pushl  0xc(%ebp)
  800e47:	50                   	push   %eax
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	ff d0                	call   *%eax
  800e4d:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e50:	ff 4d e4             	decl   -0x1c(%ebp)
  800e53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e57:	7f e4                	jg     800e3d <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e59:	eb 34                	jmp    800e8f <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e5b:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e5f:	74 1c                	je     800e7d <vprintfmt+0x207>
  800e61:	83 fb 1f             	cmp    $0x1f,%ebx
  800e64:	7e 05                	jle    800e6b <vprintfmt+0x1f5>
  800e66:	83 fb 7e             	cmp    $0x7e,%ebx
  800e69:	7e 12                	jle    800e7d <vprintfmt+0x207>
					putch('?', putdat);
  800e6b:	83 ec 08             	sub    $0x8,%esp
  800e6e:	ff 75 0c             	pushl  0xc(%ebp)
  800e71:	6a 3f                	push   $0x3f
  800e73:	8b 45 08             	mov    0x8(%ebp),%eax
  800e76:	ff d0                	call   *%eax
  800e78:	83 c4 10             	add    $0x10,%esp
  800e7b:	eb 0f                	jmp    800e8c <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e7d:	83 ec 08             	sub    $0x8,%esp
  800e80:	ff 75 0c             	pushl  0xc(%ebp)
  800e83:	53                   	push   %ebx
  800e84:	8b 45 08             	mov    0x8(%ebp),%eax
  800e87:	ff d0                	call   *%eax
  800e89:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e8c:	ff 4d e4             	decl   -0x1c(%ebp)
  800e8f:	89 f0                	mov    %esi,%eax
  800e91:	8d 70 01             	lea    0x1(%eax),%esi
  800e94:	8a 00                	mov    (%eax),%al
  800e96:	0f be d8             	movsbl %al,%ebx
  800e99:	85 db                	test   %ebx,%ebx
  800e9b:	74 24                	je     800ec1 <vprintfmt+0x24b>
  800e9d:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ea1:	78 b8                	js     800e5b <vprintfmt+0x1e5>
  800ea3:	ff 4d e0             	decl   -0x20(%ebp)
  800ea6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800eaa:	79 af                	jns    800e5b <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800eac:	eb 13                	jmp    800ec1 <vprintfmt+0x24b>
				putch(' ', putdat);
  800eae:	83 ec 08             	sub    $0x8,%esp
  800eb1:	ff 75 0c             	pushl  0xc(%ebp)
  800eb4:	6a 20                	push   $0x20
  800eb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb9:	ff d0                	call   *%eax
  800ebb:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ebe:	ff 4d e4             	decl   -0x1c(%ebp)
  800ec1:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ec5:	7f e7                	jg     800eae <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ec7:	e9 66 01 00 00       	jmp    801032 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800ecc:	83 ec 08             	sub    $0x8,%esp
  800ecf:	ff 75 e8             	pushl  -0x18(%ebp)
  800ed2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ed5:	50                   	push   %eax
  800ed6:	e8 3c fd ff ff       	call   800c17 <getint>
  800edb:	83 c4 10             	add    $0x10,%esp
  800ede:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ee4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ee7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800eea:	85 d2                	test   %edx,%edx
  800eec:	79 23                	jns    800f11 <vprintfmt+0x29b>
				putch('-', putdat);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	6a 2d                	push   $0x2d
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	ff d0                	call   *%eax
  800efb:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800efe:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800f01:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f04:	f7 d8                	neg    %eax
  800f06:	83 d2 00             	adc    $0x0,%edx
  800f09:	f7 da                	neg    %edx
  800f0b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f0e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800f11:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f18:	e9 bc 00 00 00       	jmp    800fd9 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800f1d:	83 ec 08             	sub    $0x8,%esp
  800f20:	ff 75 e8             	pushl  -0x18(%ebp)
  800f23:	8d 45 14             	lea    0x14(%ebp),%eax
  800f26:	50                   	push   %eax
  800f27:	e8 84 fc ff ff       	call   800bb0 <getuint>
  800f2c:	83 c4 10             	add    $0x10,%esp
  800f2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f32:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800f35:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800f3c:	e9 98 00 00 00       	jmp    800fd9 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800f41:	83 ec 08             	sub    $0x8,%esp
  800f44:	ff 75 0c             	pushl  0xc(%ebp)
  800f47:	6a 58                	push   $0x58
  800f49:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4c:	ff d0                	call   *%eax
  800f4e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f51:	83 ec 08             	sub    $0x8,%esp
  800f54:	ff 75 0c             	pushl  0xc(%ebp)
  800f57:	6a 58                	push   $0x58
  800f59:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5c:	ff d0                	call   *%eax
  800f5e:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f61:	83 ec 08             	sub    $0x8,%esp
  800f64:	ff 75 0c             	pushl  0xc(%ebp)
  800f67:	6a 58                	push   $0x58
  800f69:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6c:	ff d0                	call   *%eax
  800f6e:	83 c4 10             	add    $0x10,%esp
			break;
  800f71:	e9 bc 00 00 00       	jmp    801032 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	6a 30                	push   $0x30
  800f7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f81:	ff d0                	call   *%eax
  800f83:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f86:	83 ec 08             	sub    $0x8,%esp
  800f89:	ff 75 0c             	pushl  0xc(%ebp)
  800f8c:	6a 78                	push   $0x78
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	ff d0                	call   *%eax
  800f93:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f96:	8b 45 14             	mov    0x14(%ebp),%eax
  800f99:	83 c0 04             	add    $0x4,%eax
  800f9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800f9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800fa2:	83 e8 04             	sub    $0x4,%eax
  800fa5:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800fa7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800faa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800fb1:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800fb8:	eb 1f                	jmp    800fd9 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800fba:	83 ec 08             	sub    $0x8,%esp
  800fbd:	ff 75 e8             	pushl  -0x18(%ebp)
  800fc0:	8d 45 14             	lea    0x14(%ebp),%eax
  800fc3:	50                   	push   %eax
  800fc4:	e8 e7 fb ff ff       	call   800bb0 <getuint>
  800fc9:	83 c4 10             	add    $0x10,%esp
  800fcc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fcf:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800fd2:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800fd9:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800fdd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800fe0:	83 ec 04             	sub    $0x4,%esp
  800fe3:	52                   	push   %edx
  800fe4:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fe7:	50                   	push   %eax
  800fe8:	ff 75 f4             	pushl  -0xc(%ebp)
  800feb:	ff 75 f0             	pushl  -0x10(%ebp)
  800fee:	ff 75 0c             	pushl  0xc(%ebp)
  800ff1:	ff 75 08             	pushl  0x8(%ebp)
  800ff4:	e8 00 fb ff ff       	call   800af9 <printnum>
  800ff9:	83 c4 20             	add    $0x20,%esp
			break;
  800ffc:	eb 34                	jmp    801032 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800ffe:	83 ec 08             	sub    $0x8,%esp
  801001:	ff 75 0c             	pushl  0xc(%ebp)
  801004:	53                   	push   %ebx
  801005:	8b 45 08             	mov    0x8(%ebp),%eax
  801008:	ff d0                	call   *%eax
  80100a:	83 c4 10             	add    $0x10,%esp
			break;
  80100d:	eb 23                	jmp    801032 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80100f:	83 ec 08             	sub    $0x8,%esp
  801012:	ff 75 0c             	pushl  0xc(%ebp)
  801015:	6a 25                	push   $0x25
  801017:	8b 45 08             	mov    0x8(%ebp),%eax
  80101a:	ff d0                	call   *%eax
  80101c:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80101f:	ff 4d 10             	decl   0x10(%ebp)
  801022:	eb 03                	jmp    801027 <vprintfmt+0x3b1>
  801024:	ff 4d 10             	decl   0x10(%ebp)
  801027:	8b 45 10             	mov    0x10(%ebp),%eax
  80102a:	48                   	dec    %eax
  80102b:	8a 00                	mov    (%eax),%al
  80102d:	3c 25                	cmp    $0x25,%al
  80102f:	75 f3                	jne    801024 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  801031:	90                   	nop
		}
	}
  801032:	e9 47 fc ff ff       	jmp    800c7e <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801037:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801038:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80103b:	5b                   	pop    %ebx
  80103c:	5e                   	pop    %esi
  80103d:	5d                   	pop    %ebp
  80103e:	c3                   	ret    

0080103f <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80103f:	55                   	push   %ebp
  801040:	89 e5                	mov    %esp,%ebp
  801042:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801045:	8d 45 10             	lea    0x10(%ebp),%eax
  801048:	83 c0 04             	add    $0x4,%eax
  80104b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80104e:	8b 45 10             	mov    0x10(%ebp),%eax
  801051:	ff 75 f4             	pushl  -0xc(%ebp)
  801054:	50                   	push   %eax
  801055:	ff 75 0c             	pushl  0xc(%ebp)
  801058:	ff 75 08             	pushl  0x8(%ebp)
  80105b:	e8 16 fc ff ff       	call   800c76 <vprintfmt>
  801060:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801063:	90                   	nop
  801064:	c9                   	leave  
  801065:	c3                   	ret    

00801066 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801066:	55                   	push   %ebp
  801067:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801069:	8b 45 0c             	mov    0xc(%ebp),%eax
  80106c:	8b 40 08             	mov    0x8(%eax),%eax
  80106f:	8d 50 01             	lea    0x1(%eax),%edx
  801072:	8b 45 0c             	mov    0xc(%ebp),%eax
  801075:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801078:	8b 45 0c             	mov    0xc(%ebp),%eax
  80107b:	8b 10                	mov    (%eax),%edx
  80107d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801080:	8b 40 04             	mov    0x4(%eax),%eax
  801083:	39 c2                	cmp    %eax,%edx
  801085:	73 12                	jae    801099 <sprintputch+0x33>
		*b->buf++ = ch;
  801087:	8b 45 0c             	mov    0xc(%ebp),%eax
  80108a:	8b 00                	mov    (%eax),%eax
  80108c:	8d 48 01             	lea    0x1(%eax),%ecx
  80108f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801092:	89 0a                	mov    %ecx,(%edx)
  801094:	8b 55 08             	mov    0x8(%ebp),%edx
  801097:	88 10                	mov    %dl,(%eax)
}
  801099:	90                   	nop
  80109a:	5d                   	pop    %ebp
  80109b:	c3                   	ret    

0080109c <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  80109c:	55                   	push   %ebp
  80109d:	89 e5                	mov    %esp,%ebp
  80109f:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8010a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8010a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ab:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b1:	01 d0                	add    %edx,%eax
  8010b3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8010bd:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010c1:	74 06                	je     8010c9 <vsnprintf+0x2d>
  8010c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8010c7:	7f 07                	jg     8010d0 <vsnprintf+0x34>
		return -E_INVAL;
  8010c9:	b8 03 00 00 00       	mov    $0x3,%eax
  8010ce:	eb 20                	jmp    8010f0 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8010d0:	ff 75 14             	pushl  0x14(%ebp)
  8010d3:	ff 75 10             	pushl  0x10(%ebp)
  8010d6:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8010d9:	50                   	push   %eax
  8010da:	68 66 10 80 00       	push   $0x801066
  8010df:	e8 92 fb ff ff       	call   800c76 <vprintfmt>
  8010e4:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010e7:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010ea:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010f0:	c9                   	leave  
  8010f1:	c3                   	ret    

008010f2 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
  8010f5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010f8:	8d 45 10             	lea    0x10(%ebp),%eax
  8010fb:	83 c0 04             	add    $0x4,%eax
  8010fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801101:	8b 45 10             	mov    0x10(%ebp),%eax
  801104:	ff 75 f4             	pushl  -0xc(%ebp)
  801107:	50                   	push   %eax
  801108:	ff 75 0c             	pushl  0xc(%ebp)
  80110b:	ff 75 08             	pushl  0x8(%ebp)
  80110e:	e8 89 ff ff ff       	call   80109c <vsnprintf>
  801113:	83 c4 10             	add    $0x10,%esp
  801116:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801119:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80111c:	c9                   	leave  
  80111d:	c3                   	ret    

0080111e <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80111e:	55                   	push   %ebp
  80111f:	89 e5                	mov    %esp,%ebp
  801121:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801124:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801128:	74 13                	je     80113d <readline+0x1f>
		cprintf("%s", prompt);
  80112a:	83 ec 08             	sub    $0x8,%esp
  80112d:	ff 75 08             	pushl  0x8(%ebp)
  801130:	68 10 2b 80 00       	push   $0x802b10
  801135:	e8 62 f9 ff ff       	call   800a9c <cprintf>
  80113a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80113d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801144:	83 ec 0c             	sub    $0xc,%esp
  801147:	6a 00                	push   $0x0
  801149:	e8 74 f5 ff ff       	call   8006c2 <iscons>
  80114e:	83 c4 10             	add    $0x10,%esp
  801151:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801154:	e8 1b f5 ff ff       	call   800674 <getchar>
  801159:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80115c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801160:	79 22                	jns    801184 <readline+0x66>
			if (c != -E_EOF)
  801162:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801166:	0f 84 ad 00 00 00    	je     801219 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80116c:	83 ec 08             	sub    $0x8,%esp
  80116f:	ff 75 ec             	pushl  -0x14(%ebp)
  801172:	68 13 2b 80 00       	push   $0x802b13
  801177:	e8 20 f9 ff ff       	call   800a9c <cprintf>
  80117c:	83 c4 10             	add    $0x10,%esp
			return;
  80117f:	e9 95 00 00 00       	jmp    801219 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801184:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801188:	7e 34                	jle    8011be <readline+0xa0>
  80118a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801191:	7f 2b                	jg     8011be <readline+0xa0>
			if (echoing)
  801193:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801197:	74 0e                	je     8011a7 <readline+0x89>
				cputchar(c);
  801199:	83 ec 0c             	sub    $0xc,%esp
  80119c:	ff 75 ec             	pushl  -0x14(%ebp)
  80119f:	e8 88 f4 ff ff       	call   80062c <cputchar>
  8011a4:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011aa:	8d 50 01             	lea    0x1(%eax),%edx
  8011ad:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011b0:	89 c2                	mov    %eax,%edx
  8011b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b5:	01 d0                	add    %edx,%eax
  8011b7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011ba:	88 10                	mov    %dl,(%eax)
  8011bc:	eb 56                	jmp    801214 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8011be:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011c2:	75 1f                	jne    8011e3 <readline+0xc5>
  8011c4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011c8:	7e 19                	jle    8011e3 <readline+0xc5>
			if (echoing)
  8011ca:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011ce:	74 0e                	je     8011de <readline+0xc0>
				cputchar(c);
  8011d0:	83 ec 0c             	sub    $0xc,%esp
  8011d3:	ff 75 ec             	pushl  -0x14(%ebp)
  8011d6:	e8 51 f4 ff ff       	call   80062c <cputchar>
  8011db:	83 c4 10             	add    $0x10,%esp

			i--;
  8011de:	ff 4d f4             	decl   -0xc(%ebp)
  8011e1:	eb 31                	jmp    801214 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8011e3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011e7:	74 0a                	je     8011f3 <readline+0xd5>
  8011e9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011ed:	0f 85 61 ff ff ff    	jne    801154 <readline+0x36>
			if (echoing)
  8011f3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011f7:	74 0e                	je     801207 <readline+0xe9>
				cputchar(c);
  8011f9:	83 ec 0c             	sub    $0xc,%esp
  8011fc:	ff 75 ec             	pushl  -0x14(%ebp)
  8011ff:	e8 28 f4 ff ff       	call   80062c <cputchar>
  801204:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801207:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80120a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120d:	01 d0                	add    %edx,%eax
  80120f:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801212:	eb 06                	jmp    80121a <readline+0xfc>
		}
	}
  801214:	e9 3b ff ff ff       	jmp    801154 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801219:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  80121a:	c9                   	leave  
  80121b:	c3                   	ret    

0080121c <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80121c:	55                   	push   %ebp
  80121d:	89 e5                	mov    %esp,%ebp
  80121f:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801222:	e8 31 0b 00 00       	call   801d58 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801227:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80122b:	74 13                	je     801240 <atomic_readline+0x24>
		cprintf("%s", prompt);
  80122d:	83 ec 08             	sub    $0x8,%esp
  801230:	ff 75 08             	pushl  0x8(%ebp)
  801233:	68 10 2b 80 00       	push   $0x802b10
  801238:	e8 5f f8 ff ff       	call   800a9c <cprintf>
  80123d:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801240:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801247:	83 ec 0c             	sub    $0xc,%esp
  80124a:	6a 00                	push   $0x0
  80124c:	e8 71 f4 ff ff       	call   8006c2 <iscons>
  801251:	83 c4 10             	add    $0x10,%esp
  801254:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801257:	e8 18 f4 ff ff       	call   800674 <getchar>
  80125c:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80125f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801263:	79 23                	jns    801288 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801265:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801269:	74 13                	je     80127e <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  80126b:	83 ec 08             	sub    $0x8,%esp
  80126e:	ff 75 ec             	pushl  -0x14(%ebp)
  801271:	68 13 2b 80 00       	push   $0x802b13
  801276:	e8 21 f8 ff ff       	call   800a9c <cprintf>
  80127b:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80127e:	e8 ef 0a 00 00       	call   801d72 <sys_enable_interrupt>
			return;
  801283:	e9 9a 00 00 00       	jmp    801322 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801288:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  80128c:	7e 34                	jle    8012c2 <atomic_readline+0xa6>
  80128e:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801295:	7f 2b                	jg     8012c2 <atomic_readline+0xa6>
			if (echoing)
  801297:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80129b:	74 0e                	je     8012ab <atomic_readline+0x8f>
				cputchar(c);
  80129d:	83 ec 0c             	sub    $0xc,%esp
  8012a0:	ff 75 ec             	pushl  -0x14(%ebp)
  8012a3:	e8 84 f3 ff ff       	call   80062c <cputchar>
  8012a8:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012ae:	8d 50 01             	lea    0x1(%eax),%edx
  8012b1:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012b4:	89 c2                	mov    %eax,%edx
  8012b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012b9:	01 d0                	add    %edx,%eax
  8012bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012be:	88 10                	mov    %dl,(%eax)
  8012c0:	eb 5b                	jmp    80131d <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8012c2:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012c6:	75 1f                	jne    8012e7 <atomic_readline+0xcb>
  8012c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012cc:	7e 19                	jle    8012e7 <atomic_readline+0xcb>
			if (echoing)
  8012ce:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012d2:	74 0e                	je     8012e2 <atomic_readline+0xc6>
				cputchar(c);
  8012d4:	83 ec 0c             	sub    $0xc,%esp
  8012d7:	ff 75 ec             	pushl  -0x14(%ebp)
  8012da:	e8 4d f3 ff ff       	call   80062c <cputchar>
  8012df:	83 c4 10             	add    $0x10,%esp
			i--;
  8012e2:	ff 4d f4             	decl   -0xc(%ebp)
  8012e5:	eb 36                	jmp    80131d <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012e7:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012eb:	74 0a                	je     8012f7 <atomic_readline+0xdb>
  8012ed:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012f1:	0f 85 60 ff ff ff    	jne    801257 <atomic_readline+0x3b>
			if (echoing)
  8012f7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012fb:	74 0e                	je     80130b <atomic_readline+0xef>
				cputchar(c);
  8012fd:	83 ec 0c             	sub    $0xc,%esp
  801300:	ff 75 ec             	pushl  -0x14(%ebp)
  801303:	e8 24 f3 ff ff       	call   80062c <cputchar>
  801308:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  80130b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80130e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801311:	01 d0                	add    %edx,%eax
  801313:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801316:	e8 57 0a 00 00       	call   801d72 <sys_enable_interrupt>
			return;
  80131b:	eb 05                	jmp    801322 <atomic_readline+0x106>
		}
	}
  80131d:	e9 35 ff ff ff       	jmp    801257 <atomic_readline+0x3b>
}
  801322:	c9                   	leave  
  801323:	c3                   	ret    

00801324 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801324:	55                   	push   %ebp
  801325:	89 e5                	mov    %esp,%ebp
  801327:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80132a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801331:	eb 06                	jmp    801339 <strlen+0x15>
		n++;
  801333:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801336:	ff 45 08             	incl   0x8(%ebp)
  801339:	8b 45 08             	mov    0x8(%ebp),%eax
  80133c:	8a 00                	mov    (%eax),%al
  80133e:	84 c0                	test   %al,%al
  801340:	75 f1                	jne    801333 <strlen+0xf>
		n++;
	return n;
  801342:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801345:	c9                   	leave  
  801346:	c3                   	ret    

00801347 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801347:	55                   	push   %ebp
  801348:	89 e5                	mov    %esp,%ebp
  80134a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80134d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801354:	eb 09                	jmp    80135f <strnlen+0x18>
		n++;
  801356:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801359:	ff 45 08             	incl   0x8(%ebp)
  80135c:	ff 4d 0c             	decl   0xc(%ebp)
  80135f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801363:	74 09                	je     80136e <strnlen+0x27>
  801365:	8b 45 08             	mov    0x8(%ebp),%eax
  801368:	8a 00                	mov    (%eax),%al
  80136a:	84 c0                	test   %al,%al
  80136c:	75 e8                	jne    801356 <strnlen+0xf>
		n++;
	return n;
  80136e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801371:	c9                   	leave  
  801372:	c3                   	ret    

00801373 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801373:	55                   	push   %ebp
  801374:	89 e5                	mov    %esp,%ebp
  801376:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801379:	8b 45 08             	mov    0x8(%ebp),%eax
  80137c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80137f:	90                   	nop
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	8d 50 01             	lea    0x1(%eax),%edx
  801386:	89 55 08             	mov    %edx,0x8(%ebp)
  801389:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80138f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801392:	8a 12                	mov    (%edx),%dl
  801394:	88 10                	mov    %dl,(%eax)
  801396:	8a 00                	mov    (%eax),%al
  801398:	84 c0                	test   %al,%al
  80139a:	75 e4                	jne    801380 <strcpy+0xd>
		/* do nothing */;
	return ret;
  80139c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80139f:	c9                   	leave  
  8013a0:	c3                   	ret    

008013a1 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8013a1:	55                   	push   %ebp
  8013a2:	89 e5                	mov    %esp,%ebp
  8013a4:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8013ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013b4:	eb 1f                	jmp    8013d5 <strncpy+0x34>
		*dst++ = *src;
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	8d 50 01             	lea    0x1(%eax),%edx
  8013bc:	89 55 08             	mov    %edx,0x8(%ebp)
  8013bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013c2:	8a 12                	mov    (%edx),%dl
  8013c4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8013c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	84 c0                	test   %al,%al
  8013cd:	74 03                	je     8013d2 <strncpy+0x31>
			src++;
  8013cf:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8013d2:	ff 45 fc             	incl   -0x4(%ebp)
  8013d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013d8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8013db:	72 d9                	jb     8013b6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8013dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8013e0:	c9                   	leave  
  8013e1:	c3                   	ret    

008013e2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
  8013e5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f2:	74 30                	je     801424 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013f4:	eb 16                	jmp    80140c <strlcpy+0x2a>
			*dst++ = *src++;
  8013f6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f9:	8d 50 01             	lea    0x1(%eax),%edx
  8013fc:	89 55 08             	mov    %edx,0x8(%ebp)
  8013ff:	8b 55 0c             	mov    0xc(%ebp),%edx
  801402:	8d 4a 01             	lea    0x1(%edx),%ecx
  801405:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801408:	8a 12                	mov    (%edx),%dl
  80140a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80140c:	ff 4d 10             	decl   0x10(%ebp)
  80140f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801413:	74 09                	je     80141e <strlcpy+0x3c>
  801415:	8b 45 0c             	mov    0xc(%ebp),%eax
  801418:	8a 00                	mov    (%eax),%al
  80141a:	84 c0                	test   %al,%al
  80141c:	75 d8                	jne    8013f6 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80141e:	8b 45 08             	mov    0x8(%ebp),%eax
  801421:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801424:	8b 55 08             	mov    0x8(%ebp),%edx
  801427:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80142a:	29 c2                	sub    %eax,%edx
  80142c:	89 d0                	mov    %edx,%eax
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801433:	eb 06                	jmp    80143b <strcmp+0xb>
		p++, q++;
  801435:	ff 45 08             	incl   0x8(%ebp)
  801438:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80143b:	8b 45 08             	mov    0x8(%ebp),%eax
  80143e:	8a 00                	mov    (%eax),%al
  801440:	84 c0                	test   %al,%al
  801442:	74 0e                	je     801452 <strcmp+0x22>
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	8a 10                	mov    (%eax),%dl
  801449:	8b 45 0c             	mov    0xc(%ebp),%eax
  80144c:	8a 00                	mov    (%eax),%al
  80144e:	38 c2                	cmp    %al,%dl
  801450:	74 e3                	je     801435 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	0f b6 d0             	movzbl %al,%edx
  80145a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80145d:	8a 00                	mov    (%eax),%al
  80145f:	0f b6 c0             	movzbl %al,%eax
  801462:	29 c2                	sub    %eax,%edx
  801464:	89 d0                	mov    %edx,%eax
}
  801466:	5d                   	pop    %ebp
  801467:	c3                   	ret    

00801468 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801468:	55                   	push   %ebp
  801469:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80146b:	eb 09                	jmp    801476 <strncmp+0xe>
		n--, p++, q++;
  80146d:	ff 4d 10             	decl   0x10(%ebp)
  801470:	ff 45 08             	incl   0x8(%ebp)
  801473:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801476:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80147a:	74 17                	je     801493 <strncmp+0x2b>
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
  80147f:	8a 00                	mov    (%eax),%al
  801481:	84 c0                	test   %al,%al
  801483:	74 0e                	je     801493 <strncmp+0x2b>
  801485:	8b 45 08             	mov    0x8(%ebp),%eax
  801488:	8a 10                	mov    (%eax),%dl
  80148a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80148d:	8a 00                	mov    (%eax),%al
  80148f:	38 c2                	cmp    %al,%dl
  801491:	74 da                	je     80146d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801493:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801497:	75 07                	jne    8014a0 <strncmp+0x38>
		return 0;
  801499:	b8 00 00 00 00       	mov    $0x0,%eax
  80149e:	eb 14                	jmp    8014b4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	8a 00                	mov    (%eax),%al
  8014a5:	0f b6 d0             	movzbl %al,%edx
  8014a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ab:	8a 00                	mov    (%eax),%al
  8014ad:	0f b6 c0             	movzbl %al,%eax
  8014b0:	29 c2                	sub    %eax,%edx
  8014b2:	89 d0                	mov    %edx,%eax
}
  8014b4:	5d                   	pop    %ebp
  8014b5:	c3                   	ret    

008014b6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8014b6:	55                   	push   %ebp
  8014b7:	89 e5                	mov    %esp,%ebp
  8014b9:	83 ec 04             	sub    $0x4,%esp
  8014bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014c2:	eb 12                	jmp    8014d6 <strchr+0x20>
		if (*s == c)
  8014c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c7:	8a 00                	mov    (%eax),%al
  8014c9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014cc:	75 05                	jne    8014d3 <strchr+0x1d>
			return (char *) s;
  8014ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d1:	eb 11                	jmp    8014e4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8014d3:	ff 45 08             	incl   0x8(%ebp)
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	8a 00                	mov    (%eax),%al
  8014db:	84 c0                	test   %al,%al
  8014dd:	75 e5                	jne    8014c4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8014df:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014e4:	c9                   	leave  
  8014e5:	c3                   	ret    

008014e6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014e6:	55                   	push   %ebp
  8014e7:	89 e5                	mov    %esp,%ebp
  8014e9:	83 ec 04             	sub    $0x4,%esp
  8014ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ef:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014f2:	eb 0d                	jmp    801501 <strfind+0x1b>
		if (*s == c)
  8014f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f7:	8a 00                	mov    (%eax),%al
  8014f9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014fc:	74 0e                	je     80150c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014fe:	ff 45 08             	incl   0x8(%ebp)
  801501:	8b 45 08             	mov    0x8(%ebp),%eax
  801504:	8a 00                	mov    (%eax),%al
  801506:	84 c0                	test   %al,%al
  801508:	75 ea                	jne    8014f4 <strfind+0xe>
  80150a:	eb 01                	jmp    80150d <strfind+0x27>
		if (*s == c)
			break;
  80150c:	90                   	nop
	return (char *) s;
  80150d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801510:	c9                   	leave  
  801511:	c3                   	ret    

00801512 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801512:	55                   	push   %ebp
  801513:	89 e5                	mov    %esp,%ebp
  801515:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80151e:	8b 45 10             	mov    0x10(%ebp),%eax
  801521:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801524:	eb 0e                	jmp    801534 <memset+0x22>
		*p++ = c;
  801526:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801529:	8d 50 01             	lea    0x1(%eax),%edx
  80152c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80152f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801532:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801534:	ff 4d f8             	decl   -0x8(%ebp)
  801537:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80153b:	79 e9                	jns    801526 <memset+0x14>
		*p++ = c;

	return v;
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801540:	c9                   	leave  
  801541:	c3                   	ret    

00801542 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801542:	55                   	push   %ebp
  801543:	89 e5                	mov    %esp,%ebp
  801545:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801548:	8b 45 0c             	mov    0xc(%ebp),%eax
  80154b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80154e:	8b 45 08             	mov    0x8(%ebp),%eax
  801551:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801554:	eb 16                	jmp    80156c <memcpy+0x2a>
		*d++ = *s++;
  801556:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801559:	8d 50 01             	lea    0x1(%eax),%edx
  80155c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80155f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801562:	8d 4a 01             	lea    0x1(%edx),%ecx
  801565:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801568:	8a 12                	mov    (%edx),%dl
  80156a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80156c:	8b 45 10             	mov    0x10(%ebp),%eax
  80156f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801572:	89 55 10             	mov    %edx,0x10(%ebp)
  801575:	85 c0                	test   %eax,%eax
  801577:	75 dd                	jne    801556 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801579:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80157c:	c9                   	leave  
  80157d:	c3                   	ret    

0080157e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80157e:	55                   	push   %ebp
  80157f:	89 e5                	mov    %esp,%ebp
  801581:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801584:	8b 45 0c             	mov    0xc(%ebp),%eax
  801587:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80158a:	8b 45 08             	mov    0x8(%ebp),%eax
  80158d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801590:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801593:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801596:	73 50                	jae    8015e8 <memmove+0x6a>
  801598:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80159b:	8b 45 10             	mov    0x10(%ebp),%eax
  80159e:	01 d0                	add    %edx,%eax
  8015a0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8015a3:	76 43                	jbe    8015e8 <memmove+0x6a>
		s += n;
  8015a5:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8015ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8015ae:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8015b1:	eb 10                	jmp    8015c3 <memmove+0x45>
			*--d = *--s;
  8015b3:	ff 4d f8             	decl   -0x8(%ebp)
  8015b6:	ff 4d fc             	decl   -0x4(%ebp)
  8015b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015bc:	8a 10                	mov    (%eax),%dl
  8015be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015c1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8015c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015c9:	89 55 10             	mov    %edx,0x10(%ebp)
  8015cc:	85 c0                	test   %eax,%eax
  8015ce:	75 e3                	jne    8015b3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8015d0:	eb 23                	jmp    8015f5 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8015d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d5:	8d 50 01             	lea    0x1(%eax),%edx
  8015d8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8015db:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015de:	8d 4a 01             	lea    0x1(%edx),%ecx
  8015e1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015e4:	8a 12                	mov    (%edx),%dl
  8015e6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8015eb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015ee:	89 55 10             	mov    %edx,0x10(%ebp)
  8015f1:	85 c0                	test   %eax,%eax
  8015f3:	75 dd                	jne    8015d2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015f8:	c9                   	leave  
  8015f9:	c3                   	ret    

008015fa <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015fa:	55                   	push   %ebp
  8015fb:	89 e5                	mov    %esp,%ebp
  8015fd:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801600:	8b 45 08             	mov    0x8(%ebp),%eax
  801603:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801606:	8b 45 0c             	mov    0xc(%ebp),%eax
  801609:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80160c:	eb 2a                	jmp    801638 <memcmp+0x3e>
		if (*s1 != *s2)
  80160e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801611:	8a 10                	mov    (%eax),%dl
  801613:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801616:	8a 00                	mov    (%eax),%al
  801618:	38 c2                	cmp    %al,%dl
  80161a:	74 16                	je     801632 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80161c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80161f:	8a 00                	mov    (%eax),%al
  801621:	0f b6 d0             	movzbl %al,%edx
  801624:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801627:	8a 00                	mov    (%eax),%al
  801629:	0f b6 c0             	movzbl %al,%eax
  80162c:	29 c2                	sub    %eax,%edx
  80162e:	89 d0                	mov    %edx,%eax
  801630:	eb 18                	jmp    80164a <memcmp+0x50>
		s1++, s2++;
  801632:	ff 45 fc             	incl   -0x4(%ebp)
  801635:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801638:	8b 45 10             	mov    0x10(%ebp),%eax
  80163b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80163e:	89 55 10             	mov    %edx,0x10(%ebp)
  801641:	85 c0                	test   %eax,%eax
  801643:	75 c9                	jne    80160e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801645:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80164a:	c9                   	leave  
  80164b:	c3                   	ret    

0080164c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80164c:	55                   	push   %ebp
  80164d:	89 e5                	mov    %esp,%ebp
  80164f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801652:	8b 55 08             	mov    0x8(%ebp),%edx
  801655:	8b 45 10             	mov    0x10(%ebp),%eax
  801658:	01 d0                	add    %edx,%eax
  80165a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80165d:	eb 15                	jmp    801674 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80165f:	8b 45 08             	mov    0x8(%ebp),%eax
  801662:	8a 00                	mov    (%eax),%al
  801664:	0f b6 d0             	movzbl %al,%edx
  801667:	8b 45 0c             	mov    0xc(%ebp),%eax
  80166a:	0f b6 c0             	movzbl %al,%eax
  80166d:	39 c2                	cmp    %eax,%edx
  80166f:	74 0d                	je     80167e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801671:	ff 45 08             	incl   0x8(%ebp)
  801674:	8b 45 08             	mov    0x8(%ebp),%eax
  801677:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80167a:	72 e3                	jb     80165f <memfind+0x13>
  80167c:	eb 01                	jmp    80167f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80167e:	90                   	nop
	return (void *) s;
  80167f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801682:	c9                   	leave  
  801683:	c3                   	ret    

00801684 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801684:	55                   	push   %ebp
  801685:	89 e5                	mov    %esp,%ebp
  801687:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80168a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801691:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801698:	eb 03                	jmp    80169d <strtol+0x19>
		s++;
  80169a:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	3c 20                	cmp    $0x20,%al
  8016a4:	74 f4                	je     80169a <strtol+0x16>
  8016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a9:	8a 00                	mov    (%eax),%al
  8016ab:	3c 09                	cmp    $0x9,%al
  8016ad:	74 eb                	je     80169a <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8016af:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b2:	8a 00                	mov    (%eax),%al
  8016b4:	3c 2b                	cmp    $0x2b,%al
  8016b6:	75 05                	jne    8016bd <strtol+0x39>
		s++;
  8016b8:	ff 45 08             	incl   0x8(%ebp)
  8016bb:	eb 13                	jmp    8016d0 <strtol+0x4c>
	else if (*s == '-')
  8016bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c0:	8a 00                	mov    (%eax),%al
  8016c2:	3c 2d                	cmp    $0x2d,%al
  8016c4:	75 0a                	jne    8016d0 <strtol+0x4c>
		s++, neg = 1;
  8016c6:	ff 45 08             	incl   0x8(%ebp)
  8016c9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8016d0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016d4:	74 06                	je     8016dc <strtol+0x58>
  8016d6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8016da:	75 20                	jne    8016fc <strtol+0x78>
  8016dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016df:	8a 00                	mov    (%eax),%al
  8016e1:	3c 30                	cmp    $0x30,%al
  8016e3:	75 17                	jne    8016fc <strtol+0x78>
  8016e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e8:	40                   	inc    %eax
  8016e9:	8a 00                	mov    (%eax),%al
  8016eb:	3c 78                	cmp    $0x78,%al
  8016ed:	75 0d                	jne    8016fc <strtol+0x78>
		s += 2, base = 16;
  8016ef:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016f3:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016fa:	eb 28                	jmp    801724 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801700:	75 15                	jne    801717 <strtol+0x93>
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	3c 30                	cmp    $0x30,%al
  801709:	75 0c                	jne    801717 <strtol+0x93>
		s++, base = 8;
  80170b:	ff 45 08             	incl   0x8(%ebp)
  80170e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801715:	eb 0d                	jmp    801724 <strtol+0xa0>
	else if (base == 0)
  801717:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80171b:	75 07                	jne    801724 <strtol+0xa0>
		base = 10;
  80171d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	8a 00                	mov    (%eax),%al
  801729:	3c 2f                	cmp    $0x2f,%al
  80172b:	7e 19                	jle    801746 <strtol+0xc2>
  80172d:	8b 45 08             	mov    0x8(%ebp),%eax
  801730:	8a 00                	mov    (%eax),%al
  801732:	3c 39                	cmp    $0x39,%al
  801734:	7f 10                	jg     801746 <strtol+0xc2>
			dig = *s - '0';
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	8a 00                	mov    (%eax),%al
  80173b:	0f be c0             	movsbl %al,%eax
  80173e:	83 e8 30             	sub    $0x30,%eax
  801741:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801744:	eb 42                	jmp    801788 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801746:	8b 45 08             	mov    0x8(%ebp),%eax
  801749:	8a 00                	mov    (%eax),%al
  80174b:	3c 60                	cmp    $0x60,%al
  80174d:	7e 19                	jle    801768 <strtol+0xe4>
  80174f:	8b 45 08             	mov    0x8(%ebp),%eax
  801752:	8a 00                	mov    (%eax),%al
  801754:	3c 7a                	cmp    $0x7a,%al
  801756:	7f 10                	jg     801768 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	0f be c0             	movsbl %al,%eax
  801760:	83 e8 57             	sub    $0x57,%eax
  801763:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801766:	eb 20                	jmp    801788 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801768:	8b 45 08             	mov    0x8(%ebp),%eax
  80176b:	8a 00                	mov    (%eax),%al
  80176d:	3c 40                	cmp    $0x40,%al
  80176f:	7e 39                	jle    8017aa <strtol+0x126>
  801771:	8b 45 08             	mov    0x8(%ebp),%eax
  801774:	8a 00                	mov    (%eax),%al
  801776:	3c 5a                	cmp    $0x5a,%al
  801778:	7f 30                	jg     8017aa <strtol+0x126>
			dig = *s - 'A' + 10;
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	8a 00                	mov    (%eax),%al
  80177f:	0f be c0             	movsbl %al,%eax
  801782:	83 e8 37             	sub    $0x37,%eax
  801785:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801788:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80178b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80178e:	7d 19                	jge    8017a9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801790:	ff 45 08             	incl   0x8(%ebp)
  801793:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801796:	0f af 45 10          	imul   0x10(%ebp),%eax
  80179a:	89 c2                	mov    %eax,%edx
  80179c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80179f:	01 d0                	add    %edx,%eax
  8017a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8017a4:	e9 7b ff ff ff       	jmp    801724 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8017a9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8017aa:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8017ae:	74 08                	je     8017b8 <strtol+0x134>
		*endptr = (char *) s;
  8017b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b3:	8b 55 08             	mov    0x8(%ebp),%edx
  8017b6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8017b8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017bc:	74 07                	je     8017c5 <strtol+0x141>
  8017be:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017c1:	f7 d8                	neg    %eax
  8017c3:	eb 03                	jmp    8017c8 <strtol+0x144>
  8017c5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8017c8:	c9                   	leave  
  8017c9:	c3                   	ret    

008017ca <ltostr>:

void
ltostr(long value, char *str)
{
  8017ca:	55                   	push   %ebp
  8017cb:	89 e5                	mov    %esp,%ebp
  8017cd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8017d0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8017d7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8017de:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8017e2:	79 13                	jns    8017f7 <ltostr+0x2d>
	{
		neg = 1;
  8017e4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017ee:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017f1:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017f4:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fa:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017ff:	99                   	cltd   
  801800:	f7 f9                	idiv   %ecx
  801802:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801805:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801808:	8d 50 01             	lea    0x1(%eax),%edx
  80180b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80180e:	89 c2                	mov    %eax,%edx
  801810:	8b 45 0c             	mov    0xc(%ebp),%eax
  801813:	01 d0                	add    %edx,%eax
  801815:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801818:	83 c2 30             	add    $0x30,%edx
  80181b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80181d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801820:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801825:	f7 e9                	imul   %ecx
  801827:	c1 fa 02             	sar    $0x2,%edx
  80182a:	89 c8                	mov    %ecx,%eax
  80182c:	c1 f8 1f             	sar    $0x1f,%eax
  80182f:	29 c2                	sub    %eax,%edx
  801831:	89 d0                	mov    %edx,%eax
  801833:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801836:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801839:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80183e:	f7 e9                	imul   %ecx
  801840:	c1 fa 02             	sar    $0x2,%edx
  801843:	89 c8                	mov    %ecx,%eax
  801845:	c1 f8 1f             	sar    $0x1f,%eax
  801848:	29 c2                	sub    %eax,%edx
  80184a:	89 d0                	mov    %edx,%eax
  80184c:	c1 e0 02             	shl    $0x2,%eax
  80184f:	01 d0                	add    %edx,%eax
  801851:	01 c0                	add    %eax,%eax
  801853:	29 c1                	sub    %eax,%ecx
  801855:	89 ca                	mov    %ecx,%edx
  801857:	85 d2                	test   %edx,%edx
  801859:	75 9c                	jne    8017f7 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80185b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801862:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801865:	48                   	dec    %eax
  801866:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801869:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80186d:	74 3d                	je     8018ac <ltostr+0xe2>
		start = 1 ;
  80186f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801876:	eb 34                	jmp    8018ac <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801878:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80187b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80187e:	01 d0                	add    %edx,%eax
  801880:	8a 00                	mov    (%eax),%al
  801882:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801885:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801888:	8b 45 0c             	mov    0xc(%ebp),%eax
  80188b:	01 c2                	add    %eax,%edx
  80188d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801890:	8b 45 0c             	mov    0xc(%ebp),%eax
  801893:	01 c8                	add    %ecx,%eax
  801895:	8a 00                	mov    (%eax),%al
  801897:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801899:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80189c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189f:	01 c2                	add    %eax,%edx
  8018a1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8018a4:	88 02                	mov    %al,(%edx)
		start++ ;
  8018a6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8018a9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8018ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018af:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018b2:	7c c4                	jl     801878 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8018b4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8018b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ba:	01 d0                	add    %edx,%eax
  8018bc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8018bf:	90                   	nop
  8018c0:	c9                   	leave  
  8018c1:	c3                   	ret    

008018c2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8018c2:	55                   	push   %ebp
  8018c3:	89 e5                	mov    %esp,%ebp
  8018c5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8018c8:	ff 75 08             	pushl  0x8(%ebp)
  8018cb:	e8 54 fa ff ff       	call   801324 <strlen>
  8018d0:	83 c4 04             	add    $0x4,%esp
  8018d3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8018d6:	ff 75 0c             	pushl  0xc(%ebp)
  8018d9:	e8 46 fa ff ff       	call   801324 <strlen>
  8018de:	83 c4 04             	add    $0x4,%esp
  8018e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018eb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018f2:	eb 17                	jmp    80190b <strcconcat+0x49>
		final[s] = str1[s] ;
  8018f4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018f7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fa:	01 c2                	add    %eax,%edx
  8018fc:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801902:	01 c8                	add    %ecx,%eax
  801904:	8a 00                	mov    (%eax),%al
  801906:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801908:	ff 45 fc             	incl   -0x4(%ebp)
  80190b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80190e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801911:	7c e1                	jl     8018f4 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801913:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80191a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801921:	eb 1f                	jmp    801942 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801923:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801926:	8d 50 01             	lea    0x1(%eax),%edx
  801929:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80192c:	89 c2                	mov    %eax,%edx
  80192e:	8b 45 10             	mov    0x10(%ebp),%eax
  801931:	01 c2                	add    %eax,%edx
  801933:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801936:	8b 45 0c             	mov    0xc(%ebp),%eax
  801939:	01 c8                	add    %ecx,%eax
  80193b:	8a 00                	mov    (%eax),%al
  80193d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80193f:	ff 45 f8             	incl   -0x8(%ebp)
  801942:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801945:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801948:	7c d9                	jl     801923 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80194a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80194d:	8b 45 10             	mov    0x10(%ebp),%eax
  801950:	01 d0                	add    %edx,%eax
  801952:	c6 00 00             	movb   $0x0,(%eax)
}
  801955:	90                   	nop
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80195b:	8b 45 14             	mov    0x14(%ebp),%eax
  80195e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801964:	8b 45 14             	mov    0x14(%ebp),%eax
  801967:	8b 00                	mov    (%eax),%eax
  801969:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801970:	8b 45 10             	mov    0x10(%ebp),%eax
  801973:	01 d0                	add    %edx,%eax
  801975:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80197b:	eb 0c                	jmp    801989 <strsplit+0x31>
			*string++ = 0;
  80197d:	8b 45 08             	mov    0x8(%ebp),%eax
  801980:	8d 50 01             	lea    0x1(%eax),%edx
  801983:	89 55 08             	mov    %edx,0x8(%ebp)
  801986:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801989:	8b 45 08             	mov    0x8(%ebp),%eax
  80198c:	8a 00                	mov    (%eax),%al
  80198e:	84 c0                	test   %al,%al
  801990:	74 18                	je     8019aa <strsplit+0x52>
  801992:	8b 45 08             	mov    0x8(%ebp),%eax
  801995:	8a 00                	mov    (%eax),%al
  801997:	0f be c0             	movsbl %al,%eax
  80199a:	50                   	push   %eax
  80199b:	ff 75 0c             	pushl  0xc(%ebp)
  80199e:	e8 13 fb ff ff       	call   8014b6 <strchr>
  8019a3:	83 c4 08             	add    $0x8,%esp
  8019a6:	85 c0                	test   %eax,%eax
  8019a8:	75 d3                	jne    80197d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8019aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ad:	8a 00                	mov    (%eax),%al
  8019af:	84 c0                	test   %al,%al
  8019b1:	74 5a                	je     801a0d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8019b3:	8b 45 14             	mov    0x14(%ebp),%eax
  8019b6:	8b 00                	mov    (%eax),%eax
  8019b8:	83 f8 0f             	cmp    $0xf,%eax
  8019bb:	75 07                	jne    8019c4 <strsplit+0x6c>
		{
			return 0;
  8019bd:	b8 00 00 00 00       	mov    $0x0,%eax
  8019c2:	eb 66                	jmp    801a2a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8019c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8019c7:	8b 00                	mov    (%eax),%eax
  8019c9:	8d 48 01             	lea    0x1(%eax),%ecx
  8019cc:	8b 55 14             	mov    0x14(%ebp),%edx
  8019cf:	89 0a                	mov    %ecx,(%edx)
  8019d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8019db:	01 c2                	add    %eax,%edx
  8019dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8019e0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019e2:	eb 03                	jmp    8019e7 <strsplit+0x8f>
			string++;
  8019e4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ea:	8a 00                	mov    (%eax),%al
  8019ec:	84 c0                	test   %al,%al
  8019ee:	74 8b                	je     80197b <strsplit+0x23>
  8019f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f3:	8a 00                	mov    (%eax),%al
  8019f5:	0f be c0             	movsbl %al,%eax
  8019f8:	50                   	push   %eax
  8019f9:	ff 75 0c             	pushl  0xc(%ebp)
  8019fc:	e8 b5 fa ff ff       	call   8014b6 <strchr>
  801a01:	83 c4 08             	add    $0x8,%esp
  801a04:	85 c0                	test   %eax,%eax
  801a06:	74 dc                	je     8019e4 <strsplit+0x8c>
			string++;
	}
  801a08:	e9 6e ff ff ff       	jmp    80197b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801a0d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801a0e:	8b 45 14             	mov    0x14(%ebp),%eax
  801a11:	8b 00                	mov    (%eax),%eax
  801a13:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a1a:	8b 45 10             	mov    0x10(%ebp),%eax
  801a1d:	01 d0                	add    %edx,%eax
  801a1f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801a25:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801a2a:	c9                   	leave  
  801a2b:	c3                   	ret    

00801a2c <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801a2c:	55                   	push   %ebp
  801a2d:	89 e5                	mov    %esp,%ebp
  801a2f:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801a32:	83 ec 04             	sub    $0x4,%esp
  801a35:	68 24 2b 80 00       	push   $0x802b24
  801a3a:	6a 15                	push   $0x15
  801a3c:	68 49 2b 80 00       	push   $0x802b49
  801a41:	e8 a2 ed ff ff       	call   8007e8 <_panic>

00801a46 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a4c:	83 ec 04             	sub    $0x4,%esp
  801a4f:	68 58 2b 80 00       	push   $0x802b58
  801a54:	6a 2e                	push   $0x2e
  801a56:	68 49 2b 80 00       	push   $0x802b49
  801a5b:	e8 88 ed ff ff       	call   8007e8 <_panic>

00801a60 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
  801a63:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a66:	83 ec 04             	sub    $0x4,%esp
  801a69:	68 7c 2b 80 00       	push   $0x802b7c
  801a6e:	6a 4c                	push   $0x4c
  801a70:	68 49 2b 80 00       	push   $0x802b49
  801a75:	e8 6e ed ff ff       	call   8007e8 <_panic>

00801a7a <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
  801a7d:	83 ec 18             	sub    $0x18,%esp
  801a80:	8b 45 10             	mov    0x10(%ebp),%eax
  801a83:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a86:	83 ec 04             	sub    $0x4,%esp
  801a89:	68 7c 2b 80 00       	push   $0x802b7c
  801a8e:	6a 57                	push   $0x57
  801a90:	68 49 2b 80 00       	push   $0x802b49
  801a95:	e8 4e ed ff ff       	call   8007e8 <_panic>

00801a9a <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a9a:	55                   	push   %ebp
  801a9b:	89 e5                	mov    %esp,%ebp
  801a9d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aa0:	83 ec 04             	sub    $0x4,%esp
  801aa3:	68 7c 2b 80 00       	push   $0x802b7c
  801aa8:	6a 5d                	push   $0x5d
  801aaa:	68 49 2b 80 00       	push   $0x802b49
  801aaf:	e8 34 ed ff ff       	call   8007e8 <_panic>

00801ab4 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801ab4:	55                   	push   %ebp
  801ab5:	89 e5                	mov    %esp,%ebp
  801ab7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aba:	83 ec 04             	sub    $0x4,%esp
  801abd:	68 7c 2b 80 00       	push   $0x802b7c
  801ac2:	6a 63                	push   $0x63
  801ac4:	68 49 2b 80 00       	push   $0x802b49
  801ac9:	e8 1a ed ff ff       	call   8007e8 <_panic>

00801ace <expand>:
}

void expand(uint32 newSize)
{
  801ace:	55                   	push   %ebp
  801acf:	89 e5                	mov    %esp,%ebp
  801ad1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ad4:	83 ec 04             	sub    $0x4,%esp
  801ad7:	68 7c 2b 80 00       	push   $0x802b7c
  801adc:	6a 68                	push   $0x68
  801ade:	68 49 2b 80 00       	push   $0x802b49
  801ae3:	e8 00 ed ff ff       	call   8007e8 <_panic>

00801ae8 <shrink>:
}
void shrink(uint32 newSize)
{
  801ae8:	55                   	push   %ebp
  801ae9:	89 e5                	mov    %esp,%ebp
  801aeb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aee:	83 ec 04             	sub    $0x4,%esp
  801af1:	68 7c 2b 80 00       	push   $0x802b7c
  801af6:	6a 6c                	push   $0x6c
  801af8:	68 49 2b 80 00       	push   $0x802b49
  801afd:	e8 e6 ec ff ff       	call   8007e8 <_panic>

00801b02 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801b02:	55                   	push   %ebp
  801b03:	89 e5                	mov    %esp,%ebp
  801b05:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b08:	83 ec 04             	sub    $0x4,%esp
  801b0b:	68 7c 2b 80 00       	push   $0x802b7c
  801b10:	6a 71                	push   $0x71
  801b12:	68 49 2b 80 00       	push   $0x802b49
  801b17:	e8 cc ec ff ff       	call   8007e8 <_panic>

00801b1c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
  801b1f:	57                   	push   %edi
  801b20:	56                   	push   %esi
  801b21:	53                   	push   %ebx
  801b22:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b2e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b31:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b34:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b37:	cd 30                	int    $0x30
  801b39:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b3f:	83 c4 10             	add    $0x10,%esp
  801b42:	5b                   	pop    %ebx
  801b43:	5e                   	pop    %esi
  801b44:	5f                   	pop    %edi
  801b45:	5d                   	pop    %ebp
  801b46:	c3                   	ret    

00801b47 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b47:	55                   	push   %ebp
  801b48:	89 e5                	mov    %esp,%ebp
  801b4a:	83 ec 04             	sub    $0x4,%esp
  801b4d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b50:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b53:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	6a 00                	push   $0x0
  801b5c:	6a 00                	push   $0x0
  801b5e:	52                   	push   %edx
  801b5f:	ff 75 0c             	pushl  0xc(%ebp)
  801b62:	50                   	push   %eax
  801b63:	6a 00                	push   $0x0
  801b65:	e8 b2 ff ff ff       	call   801b1c <syscall>
  801b6a:	83 c4 18             	add    $0x18,%esp
}
  801b6d:	90                   	nop
  801b6e:	c9                   	leave  
  801b6f:	c3                   	ret    

00801b70 <sys_cgetc>:

int
sys_cgetc(void)
{
  801b70:	55                   	push   %ebp
  801b71:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b73:	6a 00                	push   $0x0
  801b75:	6a 00                	push   $0x0
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	6a 01                	push   $0x1
  801b7f:	e8 98 ff ff ff       	call   801b1c <syscall>
  801b84:	83 c4 18             	add    $0x18,%esp
}
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8f:	6a 00                	push   $0x0
  801b91:	6a 00                	push   $0x0
  801b93:	6a 00                	push   $0x0
  801b95:	6a 00                	push   $0x0
  801b97:	50                   	push   %eax
  801b98:	6a 05                	push   $0x5
  801b9a:	e8 7d ff ff ff       	call   801b1c <syscall>
  801b9f:	83 c4 18             	add    $0x18,%esp
}
  801ba2:	c9                   	leave  
  801ba3:	c3                   	ret    

00801ba4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ba4:	55                   	push   %ebp
  801ba5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 02                	push   $0x2
  801bb3:	e8 64 ff ff ff       	call   801b1c <syscall>
  801bb8:	83 c4 18             	add    $0x18,%esp
}
  801bbb:	c9                   	leave  
  801bbc:	c3                   	ret    

00801bbd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801bbd:	55                   	push   %ebp
  801bbe:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801bc0:	6a 00                	push   $0x0
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 03                	push   $0x3
  801bcc:	e8 4b ff ff ff       	call   801b1c <syscall>
  801bd1:	83 c4 18             	add    $0x18,%esp
}
  801bd4:	c9                   	leave  
  801bd5:	c3                   	ret    

00801bd6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801bd6:	55                   	push   %ebp
  801bd7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 04                	push   $0x4
  801be5:	e8 32 ff ff ff       	call   801b1c <syscall>
  801bea:	83 c4 18             	add    $0x18,%esp
}
  801bed:	c9                   	leave  
  801bee:	c3                   	ret    

00801bef <sys_env_exit>:


void sys_env_exit(void)
{
  801bef:	55                   	push   %ebp
  801bf0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801bf2:	6a 00                	push   $0x0
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	6a 00                	push   $0x0
  801bfc:	6a 06                	push   $0x6
  801bfe:	e8 19 ff ff ff       	call   801b1c <syscall>
  801c03:	83 c4 18             	add    $0x18,%esp
}
  801c06:	90                   	nop
  801c07:	c9                   	leave  
  801c08:	c3                   	ret    

00801c09 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c09:	55                   	push   %ebp
  801c0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c0c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c0f:	8b 45 08             	mov    0x8(%ebp),%eax
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	6a 00                	push   $0x0
  801c18:	52                   	push   %edx
  801c19:	50                   	push   %eax
  801c1a:	6a 07                	push   $0x7
  801c1c:	e8 fb fe ff ff       	call   801b1c <syscall>
  801c21:	83 c4 18             	add    $0x18,%esp
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
  801c29:	56                   	push   %esi
  801c2a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c2b:	8b 75 18             	mov    0x18(%ebp),%esi
  801c2e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c31:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c37:	8b 45 08             	mov    0x8(%ebp),%eax
  801c3a:	56                   	push   %esi
  801c3b:	53                   	push   %ebx
  801c3c:	51                   	push   %ecx
  801c3d:	52                   	push   %edx
  801c3e:	50                   	push   %eax
  801c3f:	6a 08                	push   $0x8
  801c41:	e8 d6 fe ff ff       	call   801b1c <syscall>
  801c46:	83 c4 18             	add    $0x18,%esp
}
  801c49:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c4c:	5b                   	pop    %ebx
  801c4d:	5e                   	pop    %esi
  801c4e:	5d                   	pop    %ebp
  801c4f:	c3                   	ret    

00801c50 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c50:	55                   	push   %ebp
  801c51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c53:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c56:	8b 45 08             	mov    0x8(%ebp),%eax
  801c59:	6a 00                	push   $0x0
  801c5b:	6a 00                	push   $0x0
  801c5d:	6a 00                	push   $0x0
  801c5f:	52                   	push   %edx
  801c60:	50                   	push   %eax
  801c61:	6a 09                	push   $0x9
  801c63:	e8 b4 fe ff ff       	call   801b1c <syscall>
  801c68:	83 c4 18             	add    $0x18,%esp
}
  801c6b:	c9                   	leave  
  801c6c:	c3                   	ret    

00801c6d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c6d:	55                   	push   %ebp
  801c6e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	ff 75 0c             	pushl  0xc(%ebp)
  801c79:	ff 75 08             	pushl  0x8(%ebp)
  801c7c:	6a 0a                	push   $0xa
  801c7e:	e8 99 fe ff ff       	call   801b1c <syscall>
  801c83:	83 c4 18             	add    $0x18,%esp
}
  801c86:	c9                   	leave  
  801c87:	c3                   	ret    

00801c88 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c88:	55                   	push   %ebp
  801c89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 00                	push   $0x0
  801c93:	6a 00                	push   $0x0
  801c95:	6a 0b                	push   $0xb
  801c97:	e8 80 fe ff ff       	call   801b1c <syscall>
  801c9c:	83 c4 18             	add    $0x18,%esp
}
  801c9f:	c9                   	leave  
  801ca0:	c3                   	ret    

00801ca1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ca1:	55                   	push   %ebp
  801ca2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 00                	push   $0x0
  801cac:	6a 00                	push   $0x0
  801cae:	6a 0c                	push   $0xc
  801cb0:	e8 67 fe ff ff       	call   801b1c <syscall>
  801cb5:	83 c4 18             	add    $0x18,%esp
}
  801cb8:	c9                   	leave  
  801cb9:	c3                   	ret    

00801cba <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801cba:	55                   	push   %ebp
  801cbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 00                	push   $0x0
  801cc5:	6a 00                	push   $0x0
  801cc7:	6a 0d                	push   $0xd
  801cc9:	e8 4e fe ff ff       	call   801b1c <syscall>
  801cce:	83 c4 18             	add    $0x18,%esp
}
  801cd1:	c9                   	leave  
  801cd2:	c3                   	ret    

00801cd3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801cd3:	55                   	push   %ebp
  801cd4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	ff 75 0c             	pushl  0xc(%ebp)
  801cdf:	ff 75 08             	pushl  0x8(%ebp)
  801ce2:	6a 11                	push   $0x11
  801ce4:	e8 33 fe ff ff       	call   801b1c <syscall>
  801ce9:	83 c4 18             	add    $0x18,%esp
	return;
  801cec:	90                   	nop
}
  801ced:	c9                   	leave  
  801cee:	c3                   	ret    

00801cef <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801cef:	55                   	push   %ebp
  801cf0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	ff 75 0c             	pushl  0xc(%ebp)
  801cfb:	ff 75 08             	pushl  0x8(%ebp)
  801cfe:	6a 12                	push   $0x12
  801d00:	e8 17 fe ff ff       	call   801b1c <syscall>
  801d05:	83 c4 18             	add    $0x18,%esp
	return ;
  801d08:	90                   	nop
}
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d0e:	6a 00                	push   $0x0
  801d10:	6a 00                	push   $0x0
  801d12:	6a 00                	push   $0x0
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 0e                	push   $0xe
  801d1a:	e8 fd fd ff ff       	call   801b1c <syscall>
  801d1f:	83 c4 18             	add    $0x18,%esp
}
  801d22:	c9                   	leave  
  801d23:	c3                   	ret    

00801d24 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d24:	55                   	push   %ebp
  801d25:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d27:	6a 00                	push   $0x0
  801d29:	6a 00                	push   $0x0
  801d2b:	6a 00                	push   $0x0
  801d2d:	6a 00                	push   $0x0
  801d2f:	ff 75 08             	pushl  0x8(%ebp)
  801d32:	6a 0f                	push   $0xf
  801d34:	e8 e3 fd ff ff       	call   801b1c <syscall>
  801d39:	83 c4 18             	add    $0x18,%esp
}
  801d3c:	c9                   	leave  
  801d3d:	c3                   	ret    

00801d3e <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d3e:	55                   	push   %ebp
  801d3f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	6a 00                	push   $0x0
  801d49:	6a 00                	push   $0x0
  801d4b:	6a 10                	push   $0x10
  801d4d:	e8 ca fd ff ff       	call   801b1c <syscall>
  801d52:	83 c4 18             	add    $0x18,%esp
}
  801d55:	90                   	nop
  801d56:	c9                   	leave  
  801d57:	c3                   	ret    

00801d58 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d58:	55                   	push   %ebp
  801d59:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d5b:	6a 00                	push   $0x0
  801d5d:	6a 00                	push   $0x0
  801d5f:	6a 00                	push   $0x0
  801d61:	6a 00                	push   $0x0
  801d63:	6a 00                	push   $0x0
  801d65:	6a 14                	push   $0x14
  801d67:	e8 b0 fd ff ff       	call   801b1c <syscall>
  801d6c:	83 c4 18             	add    $0x18,%esp
}
  801d6f:	90                   	nop
  801d70:	c9                   	leave  
  801d71:	c3                   	ret    

00801d72 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d72:	55                   	push   %ebp
  801d73:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 00                	push   $0x0
  801d7d:	6a 00                	push   $0x0
  801d7f:	6a 15                	push   $0x15
  801d81:	e8 96 fd ff ff       	call   801b1c <syscall>
  801d86:	83 c4 18             	add    $0x18,%esp
}
  801d89:	90                   	nop
  801d8a:	c9                   	leave  
  801d8b:	c3                   	ret    

00801d8c <sys_cputc>:


void
sys_cputc(const char c)
{
  801d8c:	55                   	push   %ebp
  801d8d:	89 e5                	mov    %esp,%ebp
  801d8f:	83 ec 04             	sub    $0x4,%esp
  801d92:	8b 45 08             	mov    0x8(%ebp),%eax
  801d95:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d98:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	50                   	push   %eax
  801da5:	6a 16                	push   $0x16
  801da7:	e8 70 fd ff ff       	call   801b1c <syscall>
  801dac:	83 c4 18             	add    $0x18,%esp
}
  801daf:	90                   	nop
  801db0:	c9                   	leave  
  801db1:	c3                   	ret    

00801db2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801db2:	55                   	push   %ebp
  801db3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	6a 00                	push   $0x0
  801dbb:	6a 00                	push   $0x0
  801dbd:	6a 00                	push   $0x0
  801dbf:	6a 17                	push   $0x17
  801dc1:	e8 56 fd ff ff       	call   801b1c <syscall>
  801dc6:	83 c4 18             	add    $0x18,%esp
}
  801dc9:	90                   	nop
  801dca:	c9                   	leave  
  801dcb:	c3                   	ret    

00801dcc <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801dcc:	55                   	push   %ebp
  801dcd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801dcf:	8b 45 08             	mov    0x8(%ebp),%eax
  801dd2:	6a 00                	push   $0x0
  801dd4:	6a 00                	push   $0x0
  801dd6:	6a 00                	push   $0x0
  801dd8:	ff 75 0c             	pushl  0xc(%ebp)
  801ddb:	50                   	push   %eax
  801ddc:	6a 18                	push   $0x18
  801dde:	e8 39 fd ff ff       	call   801b1c <syscall>
  801de3:	83 c4 18             	add    $0x18,%esp
}
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801deb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dee:	8b 45 08             	mov    0x8(%ebp),%eax
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	52                   	push   %edx
  801df8:	50                   	push   %eax
  801df9:	6a 1b                	push   $0x1b
  801dfb:	e8 1c fd ff ff       	call   801b1c <syscall>
  801e00:	83 c4 18             	add    $0x18,%esp
}
  801e03:	c9                   	leave  
  801e04:	c3                   	ret    

00801e05 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e05:	55                   	push   %ebp
  801e06:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e08:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e0b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0e:	6a 00                	push   $0x0
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	52                   	push   %edx
  801e15:	50                   	push   %eax
  801e16:	6a 19                	push   $0x19
  801e18:	e8 ff fc ff ff       	call   801b1c <syscall>
  801e1d:	83 c4 18             	add    $0x18,%esp
}
  801e20:	90                   	nop
  801e21:	c9                   	leave  
  801e22:	c3                   	ret    

00801e23 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e23:	55                   	push   %ebp
  801e24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e29:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2c:	6a 00                	push   $0x0
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	52                   	push   %edx
  801e33:	50                   	push   %eax
  801e34:	6a 1a                	push   $0x1a
  801e36:	e8 e1 fc ff ff       	call   801b1c <syscall>
  801e3b:	83 c4 18             	add    $0x18,%esp
}
  801e3e:	90                   	nop
  801e3f:	c9                   	leave  
  801e40:	c3                   	ret    

00801e41 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e41:	55                   	push   %ebp
  801e42:	89 e5                	mov    %esp,%ebp
  801e44:	83 ec 04             	sub    $0x4,%esp
  801e47:	8b 45 10             	mov    0x10(%ebp),%eax
  801e4a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e4d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e50:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e54:	8b 45 08             	mov    0x8(%ebp),%eax
  801e57:	6a 00                	push   $0x0
  801e59:	51                   	push   %ecx
  801e5a:	52                   	push   %edx
  801e5b:	ff 75 0c             	pushl  0xc(%ebp)
  801e5e:	50                   	push   %eax
  801e5f:	6a 1c                	push   $0x1c
  801e61:	e8 b6 fc ff ff       	call   801b1c <syscall>
  801e66:	83 c4 18             	add    $0x18,%esp
}
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e71:	8b 45 08             	mov    0x8(%ebp),%eax
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	52                   	push   %edx
  801e7b:	50                   	push   %eax
  801e7c:	6a 1d                	push   $0x1d
  801e7e:	e8 99 fc ff ff       	call   801b1c <syscall>
  801e83:	83 c4 18             	add    $0x18,%esp
}
  801e86:	c9                   	leave  
  801e87:	c3                   	ret    

00801e88 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e88:	55                   	push   %ebp
  801e89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e8b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e91:	8b 45 08             	mov    0x8(%ebp),%eax
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	51                   	push   %ecx
  801e99:	52                   	push   %edx
  801e9a:	50                   	push   %eax
  801e9b:	6a 1e                	push   $0x1e
  801e9d:	e8 7a fc ff ff       	call   801b1c <syscall>
  801ea2:	83 c4 18             	add    $0x18,%esp
}
  801ea5:	c9                   	leave  
  801ea6:	c3                   	ret    

00801ea7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ea7:	55                   	push   %ebp
  801ea8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801eaa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ead:	8b 45 08             	mov    0x8(%ebp),%eax
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	52                   	push   %edx
  801eb7:	50                   	push   %eax
  801eb8:	6a 1f                	push   $0x1f
  801eba:	e8 5d fc ff ff       	call   801b1c <syscall>
  801ebf:	83 c4 18             	add    $0x18,%esp
}
  801ec2:	c9                   	leave  
  801ec3:	c3                   	ret    

00801ec4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ec4:	55                   	push   %ebp
  801ec5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ec7:	6a 00                	push   $0x0
  801ec9:	6a 00                	push   $0x0
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 20                	push   $0x20
  801ed3:	e8 44 fc ff ff       	call   801b1c <syscall>
  801ed8:	83 c4 18             	add    $0x18,%esp
}
  801edb:	c9                   	leave  
  801edc:	c3                   	ret    

00801edd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801edd:	55                   	push   %ebp
  801ede:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801ee0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ee3:	6a 00                	push   $0x0
  801ee5:	ff 75 14             	pushl  0x14(%ebp)
  801ee8:	ff 75 10             	pushl  0x10(%ebp)
  801eeb:	ff 75 0c             	pushl  0xc(%ebp)
  801eee:	50                   	push   %eax
  801eef:	6a 21                	push   $0x21
  801ef1:	e8 26 fc ff ff       	call   801b1c <syscall>
  801ef6:	83 c4 18             	add    $0x18,%esp
}
  801ef9:	c9                   	leave  
  801efa:	c3                   	ret    

00801efb <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801efb:	55                   	push   %ebp
  801efc:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801efe:	8b 45 08             	mov    0x8(%ebp),%eax
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 00                	push   $0x0
  801f07:	6a 00                	push   $0x0
  801f09:	50                   	push   %eax
  801f0a:	6a 22                	push   $0x22
  801f0c:	e8 0b fc ff ff       	call   801b1c <syscall>
  801f11:	83 c4 18             	add    $0x18,%esp
}
  801f14:	90                   	nop
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1d:	6a 00                	push   $0x0
  801f1f:	6a 00                	push   $0x0
  801f21:	6a 00                	push   $0x0
  801f23:	6a 00                	push   $0x0
  801f25:	50                   	push   %eax
  801f26:	6a 23                	push   $0x23
  801f28:	e8 ef fb ff ff       	call   801b1c <syscall>
  801f2d:	83 c4 18             	add    $0x18,%esp
}
  801f30:	90                   	nop
  801f31:	c9                   	leave  
  801f32:	c3                   	ret    

00801f33 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f33:	55                   	push   %ebp
  801f34:	89 e5                	mov    %esp,%ebp
  801f36:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f39:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f3c:	8d 50 04             	lea    0x4(%eax),%edx
  801f3f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	52                   	push   %edx
  801f49:	50                   	push   %eax
  801f4a:	6a 24                	push   $0x24
  801f4c:	e8 cb fb ff ff       	call   801b1c <syscall>
  801f51:	83 c4 18             	add    $0x18,%esp
	return result;
  801f54:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f57:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f5a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f5d:	89 01                	mov    %eax,(%ecx)
  801f5f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f62:	8b 45 08             	mov    0x8(%ebp),%eax
  801f65:	c9                   	leave  
  801f66:	c2 04 00             	ret    $0x4

00801f69 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f69:	55                   	push   %ebp
  801f6a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f6c:	6a 00                	push   $0x0
  801f6e:	6a 00                	push   $0x0
  801f70:	ff 75 10             	pushl  0x10(%ebp)
  801f73:	ff 75 0c             	pushl  0xc(%ebp)
  801f76:	ff 75 08             	pushl  0x8(%ebp)
  801f79:	6a 13                	push   $0x13
  801f7b:	e8 9c fb ff ff       	call   801b1c <syscall>
  801f80:	83 c4 18             	add    $0x18,%esp
	return ;
  801f83:	90                   	nop
}
  801f84:	c9                   	leave  
  801f85:	c3                   	ret    

00801f86 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f86:	55                   	push   %ebp
  801f87:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	6a 25                	push   $0x25
  801f95:	e8 82 fb ff ff       	call   801b1c <syscall>
  801f9a:	83 c4 18             	add    $0x18,%esp
}
  801f9d:	c9                   	leave  
  801f9e:	c3                   	ret    

00801f9f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f9f:	55                   	push   %ebp
  801fa0:	89 e5                	mov    %esp,%ebp
  801fa2:	83 ec 04             	sub    $0x4,%esp
  801fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801fab:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	50                   	push   %eax
  801fb8:	6a 26                	push   $0x26
  801fba:	e8 5d fb ff ff       	call   801b1c <syscall>
  801fbf:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc2:	90                   	nop
}
  801fc3:	c9                   	leave  
  801fc4:	c3                   	ret    

00801fc5 <rsttst>:
void rsttst()
{
  801fc5:	55                   	push   %ebp
  801fc6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 00                	push   $0x0
  801fcc:	6a 00                	push   $0x0
  801fce:	6a 00                	push   $0x0
  801fd0:	6a 00                	push   $0x0
  801fd2:	6a 28                	push   $0x28
  801fd4:	e8 43 fb ff ff       	call   801b1c <syscall>
  801fd9:	83 c4 18             	add    $0x18,%esp
	return ;
  801fdc:	90                   	nop
}
  801fdd:	c9                   	leave  
  801fde:	c3                   	ret    

00801fdf <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801fdf:	55                   	push   %ebp
  801fe0:	89 e5                	mov    %esp,%ebp
  801fe2:	83 ec 04             	sub    $0x4,%esp
  801fe5:	8b 45 14             	mov    0x14(%ebp),%eax
  801fe8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801feb:	8b 55 18             	mov    0x18(%ebp),%edx
  801fee:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801ff2:	52                   	push   %edx
  801ff3:	50                   	push   %eax
  801ff4:	ff 75 10             	pushl  0x10(%ebp)
  801ff7:	ff 75 0c             	pushl  0xc(%ebp)
  801ffa:	ff 75 08             	pushl  0x8(%ebp)
  801ffd:	6a 27                	push   $0x27
  801fff:	e8 18 fb ff ff       	call   801b1c <syscall>
  802004:	83 c4 18             	add    $0x18,%esp
	return ;
  802007:	90                   	nop
}
  802008:	c9                   	leave  
  802009:	c3                   	ret    

0080200a <chktst>:
void chktst(uint32 n)
{
  80200a:	55                   	push   %ebp
  80200b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	ff 75 08             	pushl  0x8(%ebp)
  802018:	6a 29                	push   $0x29
  80201a:	e8 fd fa ff ff       	call   801b1c <syscall>
  80201f:	83 c4 18             	add    $0x18,%esp
	return ;
  802022:	90                   	nop
}
  802023:	c9                   	leave  
  802024:	c3                   	ret    

00802025 <inctst>:

void inctst()
{
  802025:	55                   	push   %ebp
  802026:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802028:	6a 00                	push   $0x0
  80202a:	6a 00                	push   $0x0
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	6a 2a                	push   $0x2a
  802034:	e8 e3 fa ff ff       	call   801b1c <syscall>
  802039:	83 c4 18             	add    $0x18,%esp
	return ;
  80203c:	90                   	nop
}
  80203d:	c9                   	leave  
  80203e:	c3                   	ret    

0080203f <gettst>:
uint32 gettst()
{
  80203f:	55                   	push   %ebp
  802040:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802042:	6a 00                	push   $0x0
  802044:	6a 00                	push   $0x0
  802046:	6a 00                	push   $0x0
  802048:	6a 00                	push   $0x0
  80204a:	6a 00                	push   $0x0
  80204c:	6a 2b                	push   $0x2b
  80204e:	e8 c9 fa ff ff       	call   801b1c <syscall>
  802053:	83 c4 18             	add    $0x18,%esp
}
  802056:	c9                   	leave  
  802057:	c3                   	ret    

00802058 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802058:	55                   	push   %ebp
  802059:	89 e5                	mov    %esp,%ebp
  80205b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80205e:	6a 00                	push   $0x0
  802060:	6a 00                	push   $0x0
  802062:	6a 00                	push   $0x0
  802064:	6a 00                	push   $0x0
  802066:	6a 00                	push   $0x0
  802068:	6a 2c                	push   $0x2c
  80206a:	e8 ad fa ff ff       	call   801b1c <syscall>
  80206f:	83 c4 18             	add    $0x18,%esp
  802072:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802075:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802079:	75 07                	jne    802082 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  80207b:	b8 01 00 00 00       	mov    $0x1,%eax
  802080:	eb 05                	jmp    802087 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  802082:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802087:	c9                   	leave  
  802088:	c3                   	ret    

00802089 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802089:	55                   	push   %ebp
  80208a:	89 e5                	mov    %esp,%ebp
  80208c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	6a 00                	push   $0x0
  802099:	6a 2c                	push   $0x2c
  80209b:	e8 7c fa ff ff       	call   801b1c <syscall>
  8020a0:	83 c4 18             	add    $0x18,%esp
  8020a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020a6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020aa:	75 07                	jne    8020b3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020ac:	b8 01 00 00 00       	mov    $0x1,%eax
  8020b1:	eb 05                	jmp    8020b8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020b8:	c9                   	leave  
  8020b9:	c3                   	ret    

008020ba <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8020ba:	55                   	push   %ebp
  8020bb:	89 e5                	mov    %esp,%ebp
  8020bd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020c0:	6a 00                	push   $0x0
  8020c2:	6a 00                	push   $0x0
  8020c4:	6a 00                	push   $0x0
  8020c6:	6a 00                	push   $0x0
  8020c8:	6a 00                	push   $0x0
  8020ca:	6a 2c                	push   $0x2c
  8020cc:	e8 4b fa ff ff       	call   801b1c <syscall>
  8020d1:	83 c4 18             	add    $0x18,%esp
  8020d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8020d7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8020db:	75 07                	jne    8020e4 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8020dd:	b8 01 00 00 00       	mov    $0x1,%eax
  8020e2:	eb 05                	jmp    8020e9 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8020e4:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020e9:	c9                   	leave  
  8020ea:	c3                   	ret    

008020eb <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8020eb:	55                   	push   %ebp
  8020ec:	89 e5                	mov    %esp,%ebp
  8020ee:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020f1:	6a 00                	push   $0x0
  8020f3:	6a 00                	push   $0x0
  8020f5:	6a 00                	push   $0x0
  8020f7:	6a 00                	push   $0x0
  8020f9:	6a 00                	push   $0x0
  8020fb:	6a 2c                	push   $0x2c
  8020fd:	e8 1a fa ff ff       	call   801b1c <syscall>
  802102:	83 c4 18             	add    $0x18,%esp
  802105:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802108:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80210c:	75 07                	jne    802115 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80210e:	b8 01 00 00 00       	mov    $0x1,%eax
  802113:	eb 05                	jmp    80211a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802115:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80211a:	c9                   	leave  
  80211b:	c3                   	ret    

0080211c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80211c:	55                   	push   %ebp
  80211d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	ff 75 08             	pushl  0x8(%ebp)
  80212a:	6a 2d                	push   $0x2d
  80212c:	e8 eb f9 ff ff       	call   801b1c <syscall>
  802131:	83 c4 18             	add    $0x18,%esp
	return ;
  802134:	90                   	nop
}
  802135:	c9                   	leave  
  802136:	c3                   	ret    

00802137 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802137:	55                   	push   %ebp
  802138:	89 e5                	mov    %esp,%ebp
  80213a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  80213b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80213e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802141:	8b 55 0c             	mov    0xc(%ebp),%edx
  802144:	8b 45 08             	mov    0x8(%ebp),%eax
  802147:	6a 00                	push   $0x0
  802149:	53                   	push   %ebx
  80214a:	51                   	push   %ecx
  80214b:	52                   	push   %edx
  80214c:	50                   	push   %eax
  80214d:	6a 2e                	push   $0x2e
  80214f:	e8 c8 f9 ff ff       	call   801b1c <syscall>
  802154:	83 c4 18             	add    $0x18,%esp
}
  802157:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80215a:	c9                   	leave  
  80215b:	c3                   	ret    

0080215c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80215c:	55                   	push   %ebp
  80215d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80215f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802162:	8b 45 08             	mov    0x8(%ebp),%eax
  802165:	6a 00                	push   $0x0
  802167:	6a 00                	push   $0x0
  802169:	6a 00                	push   $0x0
  80216b:	52                   	push   %edx
  80216c:	50                   	push   %eax
  80216d:	6a 2f                	push   $0x2f
  80216f:	e8 a8 f9 ff ff       	call   801b1c <syscall>
  802174:	83 c4 18             	add    $0x18,%esp
}
  802177:	c9                   	leave  
  802178:	c3                   	ret    

00802179 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802179:	55                   	push   %ebp
  80217a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80217c:	6a 00                	push   $0x0
  80217e:	6a 00                	push   $0x0
  802180:	6a 00                	push   $0x0
  802182:	ff 75 0c             	pushl  0xc(%ebp)
  802185:	ff 75 08             	pushl  0x8(%ebp)
  802188:	6a 30                	push   $0x30
  80218a:	e8 8d f9 ff ff       	call   801b1c <syscall>
  80218f:	83 c4 18             	add    $0x18,%esp
	return ;
  802192:	90                   	nop
}
  802193:	c9                   	leave  
  802194:	c3                   	ret    
  802195:	66 90                	xchg   %ax,%ax
  802197:	90                   	nop

00802198 <__udivdi3>:
  802198:	55                   	push   %ebp
  802199:	57                   	push   %edi
  80219a:	56                   	push   %esi
  80219b:	53                   	push   %ebx
  80219c:	83 ec 1c             	sub    $0x1c,%esp
  80219f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021a3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021a7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021ab:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021af:	89 ca                	mov    %ecx,%edx
  8021b1:	89 f8                	mov    %edi,%eax
  8021b3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021b7:	85 f6                	test   %esi,%esi
  8021b9:	75 2d                	jne    8021e8 <__udivdi3+0x50>
  8021bb:	39 cf                	cmp    %ecx,%edi
  8021bd:	77 65                	ja     802224 <__udivdi3+0x8c>
  8021bf:	89 fd                	mov    %edi,%ebp
  8021c1:	85 ff                	test   %edi,%edi
  8021c3:	75 0b                	jne    8021d0 <__udivdi3+0x38>
  8021c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021ca:	31 d2                	xor    %edx,%edx
  8021cc:	f7 f7                	div    %edi
  8021ce:	89 c5                	mov    %eax,%ebp
  8021d0:	31 d2                	xor    %edx,%edx
  8021d2:	89 c8                	mov    %ecx,%eax
  8021d4:	f7 f5                	div    %ebp
  8021d6:	89 c1                	mov    %eax,%ecx
  8021d8:	89 d8                	mov    %ebx,%eax
  8021da:	f7 f5                	div    %ebp
  8021dc:	89 cf                	mov    %ecx,%edi
  8021de:	89 fa                	mov    %edi,%edx
  8021e0:	83 c4 1c             	add    $0x1c,%esp
  8021e3:	5b                   	pop    %ebx
  8021e4:	5e                   	pop    %esi
  8021e5:	5f                   	pop    %edi
  8021e6:	5d                   	pop    %ebp
  8021e7:	c3                   	ret    
  8021e8:	39 ce                	cmp    %ecx,%esi
  8021ea:	77 28                	ja     802214 <__udivdi3+0x7c>
  8021ec:	0f bd fe             	bsr    %esi,%edi
  8021ef:	83 f7 1f             	xor    $0x1f,%edi
  8021f2:	75 40                	jne    802234 <__udivdi3+0x9c>
  8021f4:	39 ce                	cmp    %ecx,%esi
  8021f6:	72 0a                	jb     802202 <__udivdi3+0x6a>
  8021f8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021fc:	0f 87 9e 00 00 00    	ja     8022a0 <__udivdi3+0x108>
  802202:	b8 01 00 00 00       	mov    $0x1,%eax
  802207:	89 fa                	mov    %edi,%edx
  802209:	83 c4 1c             	add    $0x1c,%esp
  80220c:	5b                   	pop    %ebx
  80220d:	5e                   	pop    %esi
  80220e:	5f                   	pop    %edi
  80220f:	5d                   	pop    %ebp
  802210:	c3                   	ret    
  802211:	8d 76 00             	lea    0x0(%esi),%esi
  802214:	31 ff                	xor    %edi,%edi
  802216:	31 c0                	xor    %eax,%eax
  802218:	89 fa                	mov    %edi,%edx
  80221a:	83 c4 1c             	add    $0x1c,%esp
  80221d:	5b                   	pop    %ebx
  80221e:	5e                   	pop    %esi
  80221f:	5f                   	pop    %edi
  802220:	5d                   	pop    %ebp
  802221:	c3                   	ret    
  802222:	66 90                	xchg   %ax,%ax
  802224:	89 d8                	mov    %ebx,%eax
  802226:	f7 f7                	div    %edi
  802228:	31 ff                	xor    %edi,%edi
  80222a:	89 fa                	mov    %edi,%edx
  80222c:	83 c4 1c             	add    $0x1c,%esp
  80222f:	5b                   	pop    %ebx
  802230:	5e                   	pop    %esi
  802231:	5f                   	pop    %edi
  802232:	5d                   	pop    %ebp
  802233:	c3                   	ret    
  802234:	bd 20 00 00 00       	mov    $0x20,%ebp
  802239:	89 eb                	mov    %ebp,%ebx
  80223b:	29 fb                	sub    %edi,%ebx
  80223d:	89 f9                	mov    %edi,%ecx
  80223f:	d3 e6                	shl    %cl,%esi
  802241:	89 c5                	mov    %eax,%ebp
  802243:	88 d9                	mov    %bl,%cl
  802245:	d3 ed                	shr    %cl,%ebp
  802247:	89 e9                	mov    %ebp,%ecx
  802249:	09 f1                	or     %esi,%ecx
  80224b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80224f:	89 f9                	mov    %edi,%ecx
  802251:	d3 e0                	shl    %cl,%eax
  802253:	89 c5                	mov    %eax,%ebp
  802255:	89 d6                	mov    %edx,%esi
  802257:	88 d9                	mov    %bl,%cl
  802259:	d3 ee                	shr    %cl,%esi
  80225b:	89 f9                	mov    %edi,%ecx
  80225d:	d3 e2                	shl    %cl,%edx
  80225f:	8b 44 24 08          	mov    0x8(%esp),%eax
  802263:	88 d9                	mov    %bl,%cl
  802265:	d3 e8                	shr    %cl,%eax
  802267:	09 c2                	or     %eax,%edx
  802269:	89 d0                	mov    %edx,%eax
  80226b:	89 f2                	mov    %esi,%edx
  80226d:	f7 74 24 0c          	divl   0xc(%esp)
  802271:	89 d6                	mov    %edx,%esi
  802273:	89 c3                	mov    %eax,%ebx
  802275:	f7 e5                	mul    %ebp
  802277:	39 d6                	cmp    %edx,%esi
  802279:	72 19                	jb     802294 <__udivdi3+0xfc>
  80227b:	74 0b                	je     802288 <__udivdi3+0xf0>
  80227d:	89 d8                	mov    %ebx,%eax
  80227f:	31 ff                	xor    %edi,%edi
  802281:	e9 58 ff ff ff       	jmp    8021de <__udivdi3+0x46>
  802286:	66 90                	xchg   %ax,%ax
  802288:	8b 54 24 08          	mov    0x8(%esp),%edx
  80228c:	89 f9                	mov    %edi,%ecx
  80228e:	d3 e2                	shl    %cl,%edx
  802290:	39 c2                	cmp    %eax,%edx
  802292:	73 e9                	jae    80227d <__udivdi3+0xe5>
  802294:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802297:	31 ff                	xor    %edi,%edi
  802299:	e9 40 ff ff ff       	jmp    8021de <__udivdi3+0x46>
  80229e:	66 90                	xchg   %ax,%ax
  8022a0:	31 c0                	xor    %eax,%eax
  8022a2:	e9 37 ff ff ff       	jmp    8021de <__udivdi3+0x46>
  8022a7:	90                   	nop

008022a8 <__umoddi3>:
  8022a8:	55                   	push   %ebp
  8022a9:	57                   	push   %edi
  8022aa:	56                   	push   %esi
  8022ab:	53                   	push   %ebx
  8022ac:	83 ec 1c             	sub    $0x1c,%esp
  8022af:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022b3:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022b7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022bb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8022bf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8022c3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8022c7:	89 f3                	mov    %esi,%ebx
  8022c9:	89 fa                	mov    %edi,%edx
  8022cb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022cf:	89 34 24             	mov    %esi,(%esp)
  8022d2:	85 c0                	test   %eax,%eax
  8022d4:	75 1a                	jne    8022f0 <__umoddi3+0x48>
  8022d6:	39 f7                	cmp    %esi,%edi
  8022d8:	0f 86 a2 00 00 00    	jbe    802380 <__umoddi3+0xd8>
  8022de:	89 c8                	mov    %ecx,%eax
  8022e0:	89 f2                	mov    %esi,%edx
  8022e2:	f7 f7                	div    %edi
  8022e4:	89 d0                	mov    %edx,%eax
  8022e6:	31 d2                	xor    %edx,%edx
  8022e8:	83 c4 1c             	add    $0x1c,%esp
  8022eb:	5b                   	pop    %ebx
  8022ec:	5e                   	pop    %esi
  8022ed:	5f                   	pop    %edi
  8022ee:	5d                   	pop    %ebp
  8022ef:	c3                   	ret    
  8022f0:	39 f0                	cmp    %esi,%eax
  8022f2:	0f 87 ac 00 00 00    	ja     8023a4 <__umoddi3+0xfc>
  8022f8:	0f bd e8             	bsr    %eax,%ebp
  8022fb:	83 f5 1f             	xor    $0x1f,%ebp
  8022fe:	0f 84 ac 00 00 00    	je     8023b0 <__umoddi3+0x108>
  802304:	bf 20 00 00 00       	mov    $0x20,%edi
  802309:	29 ef                	sub    %ebp,%edi
  80230b:	89 fe                	mov    %edi,%esi
  80230d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802311:	89 e9                	mov    %ebp,%ecx
  802313:	d3 e0                	shl    %cl,%eax
  802315:	89 d7                	mov    %edx,%edi
  802317:	89 f1                	mov    %esi,%ecx
  802319:	d3 ef                	shr    %cl,%edi
  80231b:	09 c7                	or     %eax,%edi
  80231d:	89 e9                	mov    %ebp,%ecx
  80231f:	d3 e2                	shl    %cl,%edx
  802321:	89 14 24             	mov    %edx,(%esp)
  802324:	89 d8                	mov    %ebx,%eax
  802326:	d3 e0                	shl    %cl,%eax
  802328:	89 c2                	mov    %eax,%edx
  80232a:	8b 44 24 08          	mov    0x8(%esp),%eax
  80232e:	d3 e0                	shl    %cl,%eax
  802330:	89 44 24 04          	mov    %eax,0x4(%esp)
  802334:	8b 44 24 08          	mov    0x8(%esp),%eax
  802338:	89 f1                	mov    %esi,%ecx
  80233a:	d3 e8                	shr    %cl,%eax
  80233c:	09 d0                	or     %edx,%eax
  80233e:	d3 eb                	shr    %cl,%ebx
  802340:	89 da                	mov    %ebx,%edx
  802342:	f7 f7                	div    %edi
  802344:	89 d3                	mov    %edx,%ebx
  802346:	f7 24 24             	mull   (%esp)
  802349:	89 c6                	mov    %eax,%esi
  80234b:	89 d1                	mov    %edx,%ecx
  80234d:	39 d3                	cmp    %edx,%ebx
  80234f:	0f 82 87 00 00 00    	jb     8023dc <__umoddi3+0x134>
  802355:	0f 84 91 00 00 00    	je     8023ec <__umoddi3+0x144>
  80235b:	8b 54 24 04          	mov    0x4(%esp),%edx
  80235f:	29 f2                	sub    %esi,%edx
  802361:	19 cb                	sbb    %ecx,%ebx
  802363:	89 d8                	mov    %ebx,%eax
  802365:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802369:	d3 e0                	shl    %cl,%eax
  80236b:	89 e9                	mov    %ebp,%ecx
  80236d:	d3 ea                	shr    %cl,%edx
  80236f:	09 d0                	or     %edx,%eax
  802371:	89 e9                	mov    %ebp,%ecx
  802373:	d3 eb                	shr    %cl,%ebx
  802375:	89 da                	mov    %ebx,%edx
  802377:	83 c4 1c             	add    $0x1c,%esp
  80237a:	5b                   	pop    %ebx
  80237b:	5e                   	pop    %esi
  80237c:	5f                   	pop    %edi
  80237d:	5d                   	pop    %ebp
  80237e:	c3                   	ret    
  80237f:	90                   	nop
  802380:	89 fd                	mov    %edi,%ebp
  802382:	85 ff                	test   %edi,%edi
  802384:	75 0b                	jne    802391 <__umoddi3+0xe9>
  802386:	b8 01 00 00 00       	mov    $0x1,%eax
  80238b:	31 d2                	xor    %edx,%edx
  80238d:	f7 f7                	div    %edi
  80238f:	89 c5                	mov    %eax,%ebp
  802391:	89 f0                	mov    %esi,%eax
  802393:	31 d2                	xor    %edx,%edx
  802395:	f7 f5                	div    %ebp
  802397:	89 c8                	mov    %ecx,%eax
  802399:	f7 f5                	div    %ebp
  80239b:	89 d0                	mov    %edx,%eax
  80239d:	e9 44 ff ff ff       	jmp    8022e6 <__umoddi3+0x3e>
  8023a2:	66 90                	xchg   %ax,%ax
  8023a4:	89 c8                	mov    %ecx,%eax
  8023a6:	89 f2                	mov    %esi,%edx
  8023a8:	83 c4 1c             	add    $0x1c,%esp
  8023ab:	5b                   	pop    %ebx
  8023ac:	5e                   	pop    %esi
  8023ad:	5f                   	pop    %edi
  8023ae:	5d                   	pop    %ebp
  8023af:	c3                   	ret    
  8023b0:	3b 04 24             	cmp    (%esp),%eax
  8023b3:	72 06                	jb     8023bb <__umoddi3+0x113>
  8023b5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8023b9:	77 0f                	ja     8023ca <__umoddi3+0x122>
  8023bb:	89 f2                	mov    %esi,%edx
  8023bd:	29 f9                	sub    %edi,%ecx
  8023bf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8023c3:	89 14 24             	mov    %edx,(%esp)
  8023c6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ca:	8b 44 24 04          	mov    0x4(%esp),%eax
  8023ce:	8b 14 24             	mov    (%esp),%edx
  8023d1:	83 c4 1c             	add    $0x1c,%esp
  8023d4:	5b                   	pop    %ebx
  8023d5:	5e                   	pop    %esi
  8023d6:	5f                   	pop    %edi
  8023d7:	5d                   	pop    %ebp
  8023d8:	c3                   	ret    
  8023d9:	8d 76 00             	lea    0x0(%esi),%esi
  8023dc:	2b 04 24             	sub    (%esp),%eax
  8023df:	19 fa                	sbb    %edi,%edx
  8023e1:	89 d1                	mov    %edx,%ecx
  8023e3:	89 c6                	mov    %eax,%esi
  8023e5:	e9 71 ff ff ff       	jmp    80235b <__umoddi3+0xb3>
  8023ea:	66 90                	xchg   %ax,%ax
  8023ec:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023f0:	72 ea                	jb     8023dc <__umoddi3+0x134>
  8023f2:	89 d9                	mov    %ebx,%ecx
  8023f4:	e9 62 ff ff ff       	jmp    80235b <__umoddi3+0xb3>
