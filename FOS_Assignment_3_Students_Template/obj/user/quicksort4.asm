
obj/user/quicksort4:     file format elf32-i386


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
  800031:	e8 52 06 00 00       	call   800688 <libmain>
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
  800049:	e8 12 1b 00 00       	call   801b60 <sys_getenvid>
  80004e:	89 45 e8             	mov    %eax,-0x18(%ebp)
	sys_createSemaphore("cs1", 1);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	6a 01                	push   $0x1
  800056:	68 c0 23 80 00       	push   $0x8023c0
  80005b:	e8 28 1d 00 00       	call   801d88 <sys_createSemaphore>
  800060:	83 c4 10             	add    $0x10,%esp
	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800063:	e8 dc 1b 00 00       	call   801c44 <sys_calculate_free_frames>
  800068:	89 c3                	mov    %eax,%ebx
  80006a:	e8 ee 1b 00 00       	call   801c5d <sys_calculate_modified_frames>
  80006f:	01 d8                	add    %ebx,%eax
  800071:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		Iteration++ ;
  800074:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

//	sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  800077:	83 ec 08             	sub    $0x8,%esp
  80007a:	68 c0 23 80 00       	push   $0x8023c0
  80007f:	ff 75 e8             	pushl  -0x18(%ebp)
  800082:	e8 3a 1d 00 00       	call   801dc1 <sys_waitSemaphore>
  800087:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  80008a:	83 ec 08             	sub    $0x8,%esp
  80008d:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  800093:	50                   	push   %eax
  800094:	68 c4 23 80 00       	push   $0x8023c4
  800099:	e8 3c 10 00 00       	call   8010da <readline>
  80009e:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000a1:	83 ec 04             	sub    $0x4,%esp
  8000a4:	6a 0a                	push   $0xa
  8000a6:	6a 00                	push   $0x0
  8000a8:	8d 85 38 9c ff ff    	lea    -0x63c8(%ebp),%eax
  8000ae:	50                   	push   %eax
  8000af:	e8 8c 15 00 00       	call   801640 <strtol>
  8000b4:	83 c4 10             	add    $0x10,%esp
  8000b7:	89 45 e0             	mov    %eax,-0x20(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000ba:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000bd:	c1 e0 02             	shl    $0x2,%eax
  8000c0:	83 ec 0c             	sub    $0xc,%esp
  8000c3:	50                   	push   %eax
  8000c4:	e8 1f 19 00 00       	call   8019e8 <malloc>
  8000c9:	83 c4 10             	add    $0x10,%esp
  8000cc:	89 45 dc             	mov    %eax,-0x24(%ebp)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000cf:	83 ec 0c             	sub    $0xc,%esp
  8000d2:	68 e4 23 80 00       	push   $0x8023e4
  8000d7:	e8 7c 09 00 00       	call   800a58 <cprintf>
  8000dc:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	68 07 24 80 00       	push   $0x802407
  8000e7:	e8 6c 09 00 00       	call   800a58 <cprintf>
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
  800114:	68 15 24 80 00       	push   $0x802415
  800119:	e8 3a 09 00 00       	call   800a58 <cprintf>
  80011e:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800121:	83 ec 0c             	sub    $0xc,%esp
  800124:	68 24 24 80 00       	push   $0x802424
  800129:	e8 2a 09 00 00       	call   800a58 <cprintf>
  80012e:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800131:	83 ec 0c             	sub    $0xc,%esp
  800134:	68 34 24 80 00       	push   $0x802434
  800139:	e8 1a 09 00 00       	call   800a58 <cprintf>
  80013e:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800141:	e8 ea 04 00 00       	call   800630 <getchar>
  800146:	88 45 db             	mov    %al,-0x25(%ebp)
			cputchar(Chose);
  800149:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80014d:	83 ec 0c             	sub    $0xc,%esp
  800150:	50                   	push   %eax
  800151:	e8 92 04 00 00       	call   8005e8 <cputchar>
  800156:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800159:	83 ec 0c             	sub    $0xc,%esp
  80015c:	6a 0a                	push   $0xa
  80015e:	e8 85 04 00 00       	call   8005e8 <cputchar>
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
  80017b:	68 c0 23 80 00       	push   $0x8023c0
  800180:	ff 75 e8             	pushl  -0x18(%ebp)
  800183:	e8 57 1c 00 00       	call   801ddf <sys_signalSemaphore>
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
  8001a7:	e8 04 03 00 00       	call   8004b0 <InitializeAscending>
  8001ac:	83 c4 10             	add    $0x10,%esp
			break ;
  8001af:	eb 37                	jmp    8001e8 <_main+0x1b0>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b1:	83 ec 08             	sub    $0x8,%esp
  8001b4:	ff 75 e0             	pushl  -0x20(%ebp)
  8001b7:	ff 75 dc             	pushl  -0x24(%ebp)
  8001ba:	e8 22 03 00 00       	call   8004e1 <InitializeDescending>
  8001bf:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c2:	eb 24                	jmp    8001e8 <_main+0x1b0>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ca:	ff 75 dc             	pushl  -0x24(%ebp)
  8001cd:	e8 44 03 00 00       	call   800516 <InitializeSemiRandom>
  8001d2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d5:	eb 11                	jmp    8001e8 <_main+0x1b0>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001d7:	83 ec 08             	sub    $0x8,%esp
  8001da:	ff 75 e0             	pushl  -0x20(%ebp)
  8001dd:	ff 75 dc             	pushl  -0x24(%ebp)
  8001e0:	e8 31 03 00 00       	call   800516 <InitializeSemiRandom>
  8001e5:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001e8:	83 ec 08             	sub    $0x8,%esp
  8001eb:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ee:	ff 75 dc             	pushl  -0x24(%ebp)
  8001f1:	e8 ff 00 00 00       	call   8002f5 <QuickSort>
  8001f6:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f9:	83 ec 08             	sub    $0x8,%esp
  8001fc:	ff 75 e0             	pushl  -0x20(%ebp)
  8001ff:	ff 75 dc             	pushl  -0x24(%ebp)
  800202:	e8 ff 01 00 00       	call   800406 <CheckSorted>
  800207:	83 c4 10             	add    $0x10,%esp
  80020a:	89 45 d4             	mov    %eax,-0x2c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  80020d:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
  800211:	75 14                	jne    800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 40 24 80 00       	push   $0x802440
  80021b:	6a 4f                	push   $0x4f
  80021d:	68 62 24 80 00       	push   $0x802462
  800222:	e8 7d 05 00 00       	call   8007a4 <_panic>
		else
		{
			sys_waitSemaphore(envID, "cs1");
  800227:	83 ec 08             	sub    $0x8,%esp
  80022a:	68 c0 23 80 00       	push   $0x8023c0
  80022f:	ff 75 e8             	pushl  -0x18(%ebp)
  800232:	e8 8a 1b 00 00       	call   801dc1 <sys_waitSemaphore>
  800237:	83 c4 10             	add    $0x10,%esp
			cprintf("\n===============================================\n") ;
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	68 74 24 80 00       	push   $0x802474
  800242:	e8 11 08 00 00       	call   800a58 <cprintf>
  800247:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  80024a:	83 ec 0c             	sub    $0xc,%esp
  80024d:	68 a8 24 80 00       	push   $0x8024a8
  800252:	e8 01 08 00 00       	call   800a58 <cprintf>
  800257:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  80025a:	83 ec 0c             	sub    $0xc,%esp
  80025d:	68 dc 24 80 00       	push   $0x8024dc
  800262:	e8 f1 07 00 00       	call   800a58 <cprintf>
  800267:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(envID, "cs1");
  80026a:	83 ec 08             	sub    $0x8,%esp
  80026d:	68 c0 23 80 00       	push   $0x8023c0
  800272:	ff 75 e8             	pushl  -0x18(%ebp)
  800275:	e8 65 1b 00 00       	call   801ddf <sys_signalSemaphore>
  80027a:	83 c4 10             	add    $0x10,%esp
//		free(Elements) ;


		///========================================================================
	//sys_disable_interrupt();
		sys_waitSemaphore(envID, "cs1");
  80027d:	83 ec 08             	sub    $0x8,%esp
  800280:	68 c0 23 80 00       	push   $0x8023c0
  800285:	ff 75 e8             	pushl  -0x18(%ebp)
  800288:	e8 34 1b 00 00       	call   801dc1 <sys_waitSemaphore>
  80028d:	83 c4 10             	add    $0x10,%esp
		cprintf("Do you want to repeat (y/n): ") ;
  800290:	83 ec 0c             	sub    $0xc,%esp
  800293:	68 0e 25 80 00       	push   $0x80250e
  800298:	e8 bb 07 00 00       	call   800a58 <cprintf>
  80029d:	83 c4 10             	add    $0x10,%esp

		Chose = getchar() ;
  8002a0:	e8 8b 03 00 00       	call   800630 <getchar>
  8002a5:	88 45 db             	mov    %al,-0x25(%ebp)
		cputchar(Chose);
  8002a8:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8002ac:	83 ec 0c             	sub    $0xc,%esp
  8002af:	50                   	push   %eax
  8002b0:	e8 33 03 00 00       	call   8005e8 <cputchar>
  8002b5:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002b8:	83 ec 0c             	sub    $0xc,%esp
  8002bb:	6a 0a                	push   $0xa
  8002bd:	e8 26 03 00 00       	call   8005e8 <cputchar>
  8002c2:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  8002c5:	83 ec 0c             	sub    $0xc,%esp
  8002c8:	6a 0a                	push   $0xa
  8002ca:	e8 19 03 00 00       	call   8005e8 <cputchar>
  8002cf:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();
		sys_signalSemaphore(envID,"cs1");
  8002d2:	83 ec 08             	sub    $0x8,%esp
  8002d5:	68 c0 23 80 00       	push   $0x8023c0
  8002da:	ff 75 e8             	pushl  -0x18(%ebp)
  8002dd:	e8 fd 1a 00 00       	call   801ddf <sys_signalSemaphore>
  8002e2:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  8002e5:	80 7d db 79          	cmpb   $0x79,-0x25(%ebp)
  8002e9:	0f 84 74 fd ff ff    	je     800063 <_main+0x2b>

}
  8002ef:	90                   	nop
  8002f0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8002f3:	c9                   	leave  
  8002f4:	c3                   	ret    

008002f5 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002f5:	55                   	push   %ebp
  8002f6:	89 e5                	mov    %esp,%ebp
  8002f8:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002fe:	48                   	dec    %eax
  8002ff:	50                   	push   %eax
  800300:	6a 00                	push   $0x0
  800302:	ff 75 0c             	pushl  0xc(%ebp)
  800305:	ff 75 08             	pushl  0x8(%ebp)
  800308:	e8 06 00 00 00       	call   800313 <QSort>
  80030d:	83 c4 10             	add    $0x10,%esp
}
  800310:	90                   	nop
  800311:	c9                   	leave  
  800312:	c3                   	ret    

00800313 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800313:	55                   	push   %ebp
  800314:	89 e5                	mov    %esp,%ebp
  800316:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800319:	8b 45 10             	mov    0x10(%ebp),%eax
  80031c:	3b 45 14             	cmp    0x14(%ebp),%eax
  80031f:	0f 8d de 00 00 00    	jge    800403 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800325:	8b 45 10             	mov    0x10(%ebp),%eax
  800328:	40                   	inc    %eax
  800329:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80032c:	8b 45 14             	mov    0x14(%ebp),%eax
  80032f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800332:	e9 80 00 00 00       	jmp    8003b7 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800337:	ff 45 f4             	incl   -0xc(%ebp)
  80033a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80033d:	3b 45 14             	cmp    0x14(%ebp),%eax
  800340:	7f 2b                	jg     80036d <QSort+0x5a>
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	8b 10                	mov    (%eax),%edx
  800353:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800356:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	01 c8                	add    %ecx,%eax
  800362:	8b 00                	mov    (%eax),%eax
  800364:	39 c2                	cmp    %eax,%edx
  800366:	7d cf                	jge    800337 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800368:	eb 03                	jmp    80036d <QSort+0x5a>
  80036a:	ff 4d f0             	decl   -0x10(%ebp)
  80036d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800370:	3b 45 10             	cmp    0x10(%ebp),%eax
  800373:	7e 26                	jle    80039b <QSort+0x88>
  800375:	8b 45 10             	mov    0x10(%ebp),%eax
  800378:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80037f:	8b 45 08             	mov    0x8(%ebp),%eax
  800382:	01 d0                	add    %edx,%eax
  800384:	8b 10                	mov    (%eax),%edx
  800386:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800389:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800390:	8b 45 08             	mov    0x8(%ebp),%eax
  800393:	01 c8                	add    %ecx,%eax
  800395:	8b 00                	mov    (%eax),%eax
  800397:	39 c2                	cmp    %eax,%edx
  800399:	7e cf                	jle    80036a <QSort+0x57>

		if (i <= j)
  80039b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80039e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003a1:	7f 14                	jg     8003b7 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  8003a3:	83 ec 04             	sub    $0x4,%esp
  8003a6:	ff 75 f0             	pushl  -0x10(%ebp)
  8003a9:	ff 75 f4             	pushl  -0xc(%ebp)
  8003ac:	ff 75 08             	pushl  0x8(%ebp)
  8003af:	e8 a9 00 00 00       	call   80045d <Swap>
  8003b4:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  8003b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8003ba:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003bd:	0f 8e 77 ff ff ff    	jle    80033a <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  8003c3:	83 ec 04             	sub    $0x4,%esp
  8003c6:	ff 75 f0             	pushl  -0x10(%ebp)
  8003c9:	ff 75 10             	pushl  0x10(%ebp)
  8003cc:	ff 75 08             	pushl  0x8(%ebp)
  8003cf:	e8 89 00 00 00       	call   80045d <Swap>
  8003d4:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003d7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003da:	48                   	dec    %eax
  8003db:	50                   	push   %eax
  8003dc:	ff 75 10             	pushl  0x10(%ebp)
  8003df:	ff 75 0c             	pushl  0xc(%ebp)
  8003e2:	ff 75 08             	pushl  0x8(%ebp)
  8003e5:	e8 29 ff ff ff       	call   800313 <QSort>
  8003ea:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003ed:	ff 75 14             	pushl  0x14(%ebp)
  8003f0:	ff 75 f4             	pushl  -0xc(%ebp)
  8003f3:	ff 75 0c             	pushl  0xc(%ebp)
  8003f6:	ff 75 08             	pushl  0x8(%ebp)
  8003f9:	e8 15 ff ff ff       	call   800313 <QSort>
  8003fe:	83 c4 10             	add    $0x10,%esp
  800401:	eb 01                	jmp    800404 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800403:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800404:	c9                   	leave  
  800405:	c3                   	ret    

00800406 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800406:	55                   	push   %ebp
  800407:	89 e5                	mov    %esp,%ebp
  800409:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80040c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800413:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80041a:	eb 33                	jmp    80044f <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80041c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80041f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800426:	8b 45 08             	mov    0x8(%ebp),%eax
  800429:	01 d0                	add    %edx,%eax
  80042b:	8b 10                	mov    (%eax),%edx
  80042d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800430:	40                   	inc    %eax
  800431:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800438:	8b 45 08             	mov    0x8(%ebp),%eax
  80043b:	01 c8                	add    %ecx,%eax
  80043d:	8b 00                	mov    (%eax),%eax
  80043f:	39 c2                	cmp    %eax,%edx
  800441:	7e 09                	jle    80044c <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800443:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  80044a:	eb 0c                	jmp    800458 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80044c:	ff 45 f8             	incl   -0x8(%ebp)
  80044f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800452:	48                   	dec    %eax
  800453:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800456:	7f c4                	jg     80041c <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800458:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80045b:	c9                   	leave  
  80045c:	c3                   	ret    

0080045d <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80045d:	55                   	push   %ebp
  80045e:	89 e5                	mov    %esp,%ebp
  800460:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800463:	8b 45 0c             	mov    0xc(%ebp),%eax
  800466:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046d:	8b 45 08             	mov    0x8(%ebp),%eax
  800470:	01 d0                	add    %edx,%eax
  800472:	8b 00                	mov    (%eax),%eax
  800474:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800477:	8b 45 0c             	mov    0xc(%ebp),%eax
  80047a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800481:	8b 45 08             	mov    0x8(%ebp),%eax
  800484:	01 c2                	add    %eax,%edx
  800486:	8b 45 10             	mov    0x10(%ebp),%eax
  800489:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800490:	8b 45 08             	mov    0x8(%ebp),%eax
  800493:	01 c8                	add    %ecx,%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800499:	8b 45 10             	mov    0x10(%ebp),%eax
  80049c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a6:	01 c2                	add    %eax,%edx
  8004a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ab:	89 02                	mov    %eax,(%edx)
}
  8004ad:	90                   	nop
  8004ae:	c9                   	leave  
  8004af:	c3                   	ret    

008004b0 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8004b0:	55                   	push   %ebp
  8004b1:	89 e5                	mov    %esp,%ebp
  8004b3:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004bd:	eb 17                	jmp    8004d6 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  8004bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004cc:	01 c2                	add    %eax,%edx
  8004ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d1:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d3:	ff 45 fc             	incl   -0x4(%ebp)
  8004d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004d9:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004dc:	7c e1                	jl     8004bf <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004de:	90                   	nop
  8004df:	c9                   	leave  
  8004e0:	c3                   	ret    

008004e1 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004e1:	55                   	push   %ebp
  8004e2:	89 e5                	mov    %esp,%ebp
  8004e4:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004ee:	eb 1b                	jmp    80050b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8004fd:	01 c2                	add    %eax,%edx
  8004ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800502:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800505:	48                   	dec    %eax
  800506:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800508:	ff 45 fc             	incl   -0x4(%ebp)
  80050b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80050e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800511:	7c dd                	jl     8004f0 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800513:	90                   	nop
  800514:	c9                   	leave  
  800515:	c3                   	ret    

00800516 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800516:	55                   	push   %ebp
  800517:	89 e5                	mov    %esp,%ebp
  800519:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80051c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80051f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800524:	f7 e9                	imul   %ecx
  800526:	c1 f9 1f             	sar    $0x1f,%ecx
  800529:	89 d0                	mov    %edx,%eax
  80052b:	29 c8                	sub    %ecx,%eax
  80052d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800530:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800537:	eb 1e                	jmp    800557 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800539:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80053c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800543:	8b 45 08             	mov    0x8(%ebp),%eax
  800546:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800549:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80054c:	99                   	cltd   
  80054d:	f7 7d f8             	idivl  -0x8(%ebp)
  800550:	89 d0                	mov    %edx,%eax
  800552:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800554:	ff 45 fc             	incl   -0x4(%ebp)
  800557:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80055a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80055d:	7c da                	jl     800539 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80055f:	90                   	nop
  800560:	c9                   	leave  
  800561:	c3                   	ret    

00800562 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800562:	55                   	push   %ebp
  800563:	89 e5                	mov    %esp,%ebp
  800565:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800568:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80056f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800576:	eb 42                	jmp    8005ba <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800578:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80057b:	99                   	cltd   
  80057c:	f7 7d f0             	idivl  -0x10(%ebp)
  80057f:	89 d0                	mov    %edx,%eax
  800581:	85 c0                	test   %eax,%eax
  800583:	75 10                	jne    800595 <PrintElements+0x33>
			cprintf("\n");
  800585:	83 ec 0c             	sub    $0xc,%esp
  800588:	68 2c 25 80 00       	push   $0x80252c
  80058d:	e8 c6 04 00 00       	call   800a58 <cprintf>
  800592:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800595:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800598:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059f:	8b 45 08             	mov    0x8(%ebp),%eax
  8005a2:	01 d0                	add    %edx,%eax
  8005a4:	8b 00                	mov    (%eax),%eax
  8005a6:	83 ec 08             	sub    $0x8,%esp
  8005a9:	50                   	push   %eax
  8005aa:	68 2e 25 80 00       	push   $0x80252e
  8005af:	e8 a4 04 00 00       	call   800a58 <cprintf>
  8005b4:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8005b7:	ff 45 f4             	incl   -0xc(%ebp)
  8005ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005bd:	48                   	dec    %eax
  8005be:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8005c1:	7f b5                	jg     800578 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  8005c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d0:	01 d0                	add    %edx,%eax
  8005d2:	8b 00                	mov    (%eax),%eax
  8005d4:	83 ec 08             	sub    $0x8,%esp
  8005d7:	50                   	push   %eax
  8005d8:	68 33 25 80 00       	push   $0x802533
  8005dd:	e8 76 04 00 00       	call   800a58 <cprintf>
  8005e2:	83 c4 10             	add    $0x10,%esp

}
  8005e5:	90                   	nop
  8005e6:	c9                   	leave  
  8005e7:	c3                   	ret    

008005e8 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005e8:	55                   	push   %ebp
  8005e9:	89 e5                	mov    %esp,%ebp
  8005eb:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005f4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005f8:	83 ec 0c             	sub    $0xc,%esp
  8005fb:	50                   	push   %eax
  8005fc:	e8 47 17 00 00       	call   801d48 <sys_cputc>
  800601:	83 c4 10             	add    $0x10,%esp
}
  800604:	90                   	nop
  800605:	c9                   	leave  
  800606:	c3                   	ret    

00800607 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800607:	55                   	push   %ebp
  800608:	89 e5                	mov    %esp,%ebp
  80060a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80060d:	e8 02 17 00 00       	call   801d14 <sys_disable_interrupt>
	char c = ch;
  800612:	8b 45 08             	mov    0x8(%ebp),%eax
  800615:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800618:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80061c:	83 ec 0c             	sub    $0xc,%esp
  80061f:	50                   	push   %eax
  800620:	e8 23 17 00 00       	call   801d48 <sys_cputc>
  800625:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800628:	e8 01 17 00 00       	call   801d2e <sys_enable_interrupt>
}
  80062d:	90                   	nop
  80062e:	c9                   	leave  
  80062f:	c3                   	ret    

00800630 <getchar>:

int
getchar(void)
{
  800630:	55                   	push   %ebp
  800631:	89 e5                	mov    %esp,%ebp
  800633:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800636:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80063d:	eb 08                	jmp    800647 <getchar+0x17>
	{
		c = sys_cgetc();
  80063f:	e8 e8 14 00 00       	call   801b2c <sys_cgetc>
  800644:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800647:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80064b:	74 f2                	je     80063f <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80064d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800650:	c9                   	leave  
  800651:	c3                   	ret    

00800652 <atomic_getchar>:

int
atomic_getchar(void)
{
  800652:	55                   	push   %ebp
  800653:	89 e5                	mov    %esp,%ebp
  800655:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800658:	e8 b7 16 00 00       	call   801d14 <sys_disable_interrupt>
	int c=0;
  80065d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800664:	eb 08                	jmp    80066e <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800666:	e8 c1 14 00 00       	call   801b2c <sys_cgetc>
  80066b:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80066e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800672:	74 f2                	je     800666 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800674:	e8 b5 16 00 00       	call   801d2e <sys_enable_interrupt>
	return c;
  800679:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80067c:	c9                   	leave  
  80067d:	c3                   	ret    

0080067e <iscons>:

int iscons(int fdnum)
{
  80067e:	55                   	push   %ebp
  80067f:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800681:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800686:	5d                   	pop    %ebp
  800687:	c3                   	ret    

00800688 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800688:	55                   	push   %ebp
  800689:	89 e5                	mov    %esp,%ebp
  80068b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80068e:	e8 e6 14 00 00       	call   801b79 <sys_getenvindex>
  800693:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800696:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800699:	89 d0                	mov    %edx,%eax
  80069b:	01 c0                	add    %eax,%eax
  80069d:	01 d0                	add    %edx,%eax
  80069f:	c1 e0 04             	shl    $0x4,%eax
  8006a2:	29 d0                	sub    %edx,%eax
  8006a4:	c1 e0 03             	shl    $0x3,%eax
  8006a7:	01 d0                	add    %edx,%eax
  8006a9:	c1 e0 02             	shl    $0x2,%eax
  8006ac:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8006b1:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8006b6:	a1 24 30 80 00       	mov    0x803024,%eax
  8006bb:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8006c1:	84 c0                	test   %al,%al
  8006c3:	74 0f                	je     8006d4 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8006c5:	a1 24 30 80 00       	mov    0x803024,%eax
  8006ca:	05 5c 05 00 00       	add    $0x55c,%eax
  8006cf:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006d4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006d8:	7e 0a                	jle    8006e4 <libmain+0x5c>
		binaryname = argv[0];
  8006da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006dd:	8b 00                	mov    (%eax),%eax
  8006df:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006e4:	83 ec 08             	sub    $0x8,%esp
  8006e7:	ff 75 0c             	pushl  0xc(%ebp)
  8006ea:	ff 75 08             	pushl  0x8(%ebp)
  8006ed:	e8 46 f9 ff ff       	call   800038 <_main>
  8006f2:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006f5:	e8 1a 16 00 00       	call   801d14 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006fa:	83 ec 0c             	sub    $0xc,%esp
  8006fd:	68 50 25 80 00       	push   $0x802550
  800702:	e8 51 03 00 00       	call   800a58 <cprintf>
  800707:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80070a:	a1 24 30 80 00       	mov    0x803024,%eax
  80070f:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800715:	a1 24 30 80 00       	mov    0x803024,%eax
  80071a:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800720:	83 ec 04             	sub    $0x4,%esp
  800723:	52                   	push   %edx
  800724:	50                   	push   %eax
  800725:	68 78 25 80 00       	push   $0x802578
  80072a:	e8 29 03 00 00       	call   800a58 <cprintf>
  80072f:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800732:	a1 24 30 80 00       	mov    0x803024,%eax
  800737:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80073d:	a1 24 30 80 00       	mov    0x803024,%eax
  800742:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800748:	a1 24 30 80 00       	mov    0x803024,%eax
  80074d:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800753:	51                   	push   %ecx
  800754:	52                   	push   %edx
  800755:	50                   	push   %eax
  800756:	68 a0 25 80 00       	push   $0x8025a0
  80075b:	e8 f8 02 00 00       	call   800a58 <cprintf>
  800760:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800763:	83 ec 0c             	sub    $0xc,%esp
  800766:	68 50 25 80 00       	push   $0x802550
  80076b:	e8 e8 02 00 00       	call   800a58 <cprintf>
  800770:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800773:	e8 b6 15 00 00       	call   801d2e <sys_enable_interrupt>

	// exit gracefully
	exit();
  800778:	e8 19 00 00 00       	call   800796 <exit>
}
  80077d:	90                   	nop
  80077e:	c9                   	leave  
  80077f:	c3                   	ret    

00800780 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800780:	55                   	push   %ebp
  800781:	89 e5                	mov    %esp,%ebp
  800783:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800786:	83 ec 0c             	sub    $0xc,%esp
  800789:	6a 00                	push   $0x0
  80078b:	e8 b5 13 00 00       	call   801b45 <sys_env_destroy>
  800790:	83 c4 10             	add    $0x10,%esp
}
  800793:	90                   	nop
  800794:	c9                   	leave  
  800795:	c3                   	ret    

00800796 <exit>:

void
exit(void)
{
  800796:	55                   	push   %ebp
  800797:	89 e5                	mov    %esp,%ebp
  800799:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80079c:	e8 0a 14 00 00       	call   801bab <sys_env_exit>
}
  8007a1:	90                   	nop
  8007a2:	c9                   	leave  
  8007a3:	c3                   	ret    

008007a4 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8007a4:	55                   	push   %ebp
  8007a5:	89 e5                	mov    %esp,%ebp
  8007a7:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8007aa:	8d 45 10             	lea    0x10(%ebp),%eax
  8007ad:	83 c0 04             	add    $0x4,%eax
  8007b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8007b3:	a1 18 31 80 00       	mov    0x803118,%eax
  8007b8:	85 c0                	test   %eax,%eax
  8007ba:	74 16                	je     8007d2 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8007bc:	a1 18 31 80 00       	mov    0x803118,%eax
  8007c1:	83 ec 08             	sub    $0x8,%esp
  8007c4:	50                   	push   %eax
  8007c5:	68 f8 25 80 00       	push   $0x8025f8
  8007ca:	e8 89 02 00 00       	call   800a58 <cprintf>
  8007cf:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8007d2:	a1 00 30 80 00       	mov    0x803000,%eax
  8007d7:	ff 75 0c             	pushl  0xc(%ebp)
  8007da:	ff 75 08             	pushl  0x8(%ebp)
  8007dd:	50                   	push   %eax
  8007de:	68 fd 25 80 00       	push   $0x8025fd
  8007e3:	e8 70 02 00 00       	call   800a58 <cprintf>
  8007e8:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8007ee:	83 ec 08             	sub    $0x8,%esp
  8007f1:	ff 75 f4             	pushl  -0xc(%ebp)
  8007f4:	50                   	push   %eax
  8007f5:	e8 f3 01 00 00       	call   8009ed <vcprintf>
  8007fa:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007fd:	83 ec 08             	sub    $0x8,%esp
  800800:	6a 00                	push   $0x0
  800802:	68 19 26 80 00       	push   $0x802619
  800807:	e8 e1 01 00 00       	call   8009ed <vcprintf>
  80080c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80080f:	e8 82 ff ff ff       	call   800796 <exit>

	// should not return here
	while (1) ;
  800814:	eb fe                	jmp    800814 <_panic+0x70>

00800816 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800816:	55                   	push   %ebp
  800817:	89 e5                	mov    %esp,%ebp
  800819:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80081c:	a1 24 30 80 00       	mov    0x803024,%eax
  800821:	8b 50 74             	mov    0x74(%eax),%edx
  800824:	8b 45 0c             	mov    0xc(%ebp),%eax
  800827:	39 c2                	cmp    %eax,%edx
  800829:	74 14                	je     80083f <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80082b:	83 ec 04             	sub    $0x4,%esp
  80082e:	68 1c 26 80 00       	push   $0x80261c
  800833:	6a 26                	push   $0x26
  800835:	68 68 26 80 00       	push   $0x802668
  80083a:	e8 65 ff ff ff       	call   8007a4 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80083f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800846:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80084d:	e9 c2 00 00 00       	jmp    800914 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800852:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800855:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80085c:	8b 45 08             	mov    0x8(%ebp),%eax
  80085f:	01 d0                	add    %edx,%eax
  800861:	8b 00                	mov    (%eax),%eax
  800863:	85 c0                	test   %eax,%eax
  800865:	75 08                	jne    80086f <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800867:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80086a:	e9 a2 00 00 00       	jmp    800911 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80086f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800876:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80087d:	eb 69                	jmp    8008e8 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80087f:	a1 24 30 80 00       	mov    0x803024,%eax
  800884:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80088a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80088d:	89 d0                	mov    %edx,%eax
  80088f:	01 c0                	add    %eax,%eax
  800891:	01 d0                	add    %edx,%eax
  800893:	c1 e0 03             	shl    $0x3,%eax
  800896:	01 c8                	add    %ecx,%eax
  800898:	8a 40 04             	mov    0x4(%eax),%al
  80089b:	84 c0                	test   %al,%al
  80089d:	75 46                	jne    8008e5 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80089f:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a4:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8008aa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8008ad:	89 d0                	mov    %edx,%eax
  8008af:	01 c0                	add    %eax,%eax
  8008b1:	01 d0                	add    %edx,%eax
  8008b3:	c1 e0 03             	shl    $0x3,%eax
  8008b6:	01 c8                	add    %ecx,%eax
  8008b8:	8b 00                	mov    (%eax),%eax
  8008ba:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8008bd:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8008c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8008c5:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8008c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8008d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d4:	01 c8                	add    %ecx,%eax
  8008d6:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008d8:	39 c2                	cmp    %eax,%edx
  8008da:	75 09                	jne    8008e5 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008dc:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008e3:	eb 12                	jmp    8008f7 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e5:	ff 45 e8             	incl   -0x18(%ebp)
  8008e8:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ed:	8b 50 74             	mov    0x74(%eax),%edx
  8008f0:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008f3:	39 c2                	cmp    %eax,%edx
  8008f5:	77 88                	ja     80087f <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008f7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008fb:	75 14                	jne    800911 <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008fd:	83 ec 04             	sub    $0x4,%esp
  800900:	68 74 26 80 00       	push   $0x802674
  800905:	6a 3a                	push   $0x3a
  800907:	68 68 26 80 00       	push   $0x802668
  80090c:	e8 93 fe ff ff       	call   8007a4 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800911:	ff 45 f0             	incl   -0x10(%ebp)
  800914:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800917:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80091a:	0f 8c 32 ff ff ff    	jl     800852 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800920:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800927:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80092e:	eb 26                	jmp    800956 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800930:	a1 24 30 80 00       	mov    0x803024,%eax
  800935:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80093b:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80093e:	89 d0                	mov    %edx,%eax
  800940:	01 c0                	add    %eax,%eax
  800942:	01 d0                	add    %edx,%eax
  800944:	c1 e0 03             	shl    $0x3,%eax
  800947:	01 c8                	add    %ecx,%eax
  800949:	8a 40 04             	mov    0x4(%eax),%al
  80094c:	3c 01                	cmp    $0x1,%al
  80094e:	75 03                	jne    800953 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800950:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800953:	ff 45 e0             	incl   -0x20(%ebp)
  800956:	a1 24 30 80 00       	mov    0x803024,%eax
  80095b:	8b 50 74             	mov    0x74(%eax),%edx
  80095e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800961:	39 c2                	cmp    %eax,%edx
  800963:	77 cb                	ja     800930 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800965:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800968:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80096b:	74 14                	je     800981 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80096d:	83 ec 04             	sub    $0x4,%esp
  800970:	68 c8 26 80 00       	push   $0x8026c8
  800975:	6a 44                	push   $0x44
  800977:	68 68 26 80 00       	push   $0x802668
  80097c:	e8 23 fe ff ff       	call   8007a4 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800981:	90                   	nop
  800982:	c9                   	leave  
  800983:	c3                   	ret    

00800984 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800984:	55                   	push   %ebp
  800985:	89 e5                	mov    %esp,%ebp
  800987:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80098a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80098d:	8b 00                	mov    (%eax),%eax
  80098f:	8d 48 01             	lea    0x1(%eax),%ecx
  800992:	8b 55 0c             	mov    0xc(%ebp),%edx
  800995:	89 0a                	mov    %ecx,(%edx)
  800997:	8b 55 08             	mov    0x8(%ebp),%edx
  80099a:	88 d1                	mov    %dl,%cl
  80099c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80099f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8009a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a6:	8b 00                	mov    (%eax),%eax
  8009a8:	3d ff 00 00 00       	cmp    $0xff,%eax
  8009ad:	75 2c                	jne    8009db <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8009af:	a0 28 30 80 00       	mov    0x803028,%al
  8009b4:	0f b6 c0             	movzbl %al,%eax
  8009b7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009ba:	8b 12                	mov    (%edx),%edx
  8009bc:	89 d1                	mov    %edx,%ecx
  8009be:	8b 55 0c             	mov    0xc(%ebp),%edx
  8009c1:	83 c2 08             	add    $0x8,%edx
  8009c4:	83 ec 04             	sub    $0x4,%esp
  8009c7:	50                   	push   %eax
  8009c8:	51                   	push   %ecx
  8009c9:	52                   	push   %edx
  8009ca:	e8 34 11 00 00       	call   801b03 <sys_cputs>
  8009cf:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8009d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009de:	8b 40 04             	mov    0x4(%eax),%eax
  8009e1:	8d 50 01             	lea    0x1(%eax),%edx
  8009e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009e7:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009ea:	90                   	nop
  8009eb:	c9                   	leave  
  8009ec:	c3                   	ret    

008009ed <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009ed:	55                   	push   %ebp
  8009ee:	89 e5                	mov    %esp,%ebp
  8009f0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009f6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009fd:	00 00 00 
	b.cnt = 0;
  800a00:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800a07:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800a0a:	ff 75 0c             	pushl  0xc(%ebp)
  800a0d:	ff 75 08             	pushl  0x8(%ebp)
  800a10:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a16:	50                   	push   %eax
  800a17:	68 84 09 80 00       	push   $0x800984
  800a1c:	e8 11 02 00 00       	call   800c32 <vprintfmt>
  800a21:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800a24:	a0 28 30 80 00       	mov    0x803028,%al
  800a29:	0f b6 c0             	movzbl %al,%eax
  800a2c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800a32:	83 ec 04             	sub    $0x4,%esp
  800a35:	50                   	push   %eax
  800a36:	52                   	push   %edx
  800a37:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a3d:	83 c0 08             	add    $0x8,%eax
  800a40:	50                   	push   %eax
  800a41:	e8 bd 10 00 00       	call   801b03 <sys_cputs>
  800a46:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a49:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a50:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a56:	c9                   	leave  
  800a57:	c3                   	ret    

00800a58 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a58:	55                   	push   %ebp
  800a59:	89 e5                	mov    %esp,%ebp
  800a5b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a5e:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a65:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a68:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800a6e:	83 ec 08             	sub    $0x8,%esp
  800a71:	ff 75 f4             	pushl  -0xc(%ebp)
  800a74:	50                   	push   %eax
  800a75:	e8 73 ff ff ff       	call   8009ed <vcprintf>
  800a7a:	83 c4 10             	add    $0x10,%esp
  800a7d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a80:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a83:	c9                   	leave  
  800a84:	c3                   	ret    

00800a85 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a85:	55                   	push   %ebp
  800a86:	89 e5                	mov    %esp,%ebp
  800a88:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a8b:	e8 84 12 00 00       	call   801d14 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a90:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a93:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a96:	8b 45 08             	mov    0x8(%ebp),%eax
  800a99:	83 ec 08             	sub    $0x8,%esp
  800a9c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a9f:	50                   	push   %eax
  800aa0:	e8 48 ff ff ff       	call   8009ed <vcprintf>
  800aa5:	83 c4 10             	add    $0x10,%esp
  800aa8:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800aab:	e8 7e 12 00 00       	call   801d2e <sys_enable_interrupt>
	return cnt;
  800ab0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ab3:	c9                   	leave  
  800ab4:	c3                   	ret    

00800ab5 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800ab5:	55                   	push   %ebp
  800ab6:	89 e5                	mov    %esp,%ebp
  800ab8:	53                   	push   %ebx
  800ab9:	83 ec 14             	sub    $0x14,%esp
  800abc:	8b 45 10             	mov    0x10(%ebp),%eax
  800abf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ac2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800ac8:	8b 45 18             	mov    0x18(%ebp),%eax
  800acb:	ba 00 00 00 00       	mov    $0x0,%edx
  800ad0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ad3:	77 55                	ja     800b2a <printnum+0x75>
  800ad5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ad8:	72 05                	jb     800adf <printnum+0x2a>
  800ada:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800add:	77 4b                	ja     800b2a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800adf:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800ae2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ae5:	8b 45 18             	mov    0x18(%ebp),%eax
  800ae8:	ba 00 00 00 00       	mov    $0x0,%edx
  800aed:	52                   	push   %edx
  800aee:	50                   	push   %eax
  800aef:	ff 75 f4             	pushl  -0xc(%ebp)
  800af2:	ff 75 f0             	pushl  -0x10(%ebp)
  800af5:	e8 5a 16 00 00       	call   802154 <__udivdi3>
  800afa:	83 c4 10             	add    $0x10,%esp
  800afd:	83 ec 04             	sub    $0x4,%esp
  800b00:	ff 75 20             	pushl  0x20(%ebp)
  800b03:	53                   	push   %ebx
  800b04:	ff 75 18             	pushl  0x18(%ebp)
  800b07:	52                   	push   %edx
  800b08:	50                   	push   %eax
  800b09:	ff 75 0c             	pushl  0xc(%ebp)
  800b0c:	ff 75 08             	pushl  0x8(%ebp)
  800b0f:	e8 a1 ff ff ff       	call   800ab5 <printnum>
  800b14:	83 c4 20             	add    $0x20,%esp
  800b17:	eb 1a                	jmp    800b33 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800b19:	83 ec 08             	sub    $0x8,%esp
  800b1c:	ff 75 0c             	pushl  0xc(%ebp)
  800b1f:	ff 75 20             	pushl  0x20(%ebp)
  800b22:	8b 45 08             	mov    0x8(%ebp),%eax
  800b25:	ff d0                	call   *%eax
  800b27:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800b2a:	ff 4d 1c             	decl   0x1c(%ebp)
  800b2d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800b31:	7f e6                	jg     800b19 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b33:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b36:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b3b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b3e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b41:	53                   	push   %ebx
  800b42:	51                   	push   %ecx
  800b43:	52                   	push   %edx
  800b44:	50                   	push   %eax
  800b45:	e8 1a 17 00 00       	call   802264 <__umoddi3>
  800b4a:	83 c4 10             	add    $0x10,%esp
  800b4d:	05 34 29 80 00       	add    $0x802934,%eax
  800b52:	8a 00                	mov    (%eax),%al
  800b54:	0f be c0             	movsbl %al,%eax
  800b57:	83 ec 08             	sub    $0x8,%esp
  800b5a:	ff 75 0c             	pushl  0xc(%ebp)
  800b5d:	50                   	push   %eax
  800b5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b61:	ff d0                	call   *%eax
  800b63:	83 c4 10             	add    $0x10,%esp
}
  800b66:	90                   	nop
  800b67:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b6a:	c9                   	leave  
  800b6b:	c3                   	ret    

00800b6c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b6c:	55                   	push   %ebp
  800b6d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b6f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b73:	7e 1c                	jle    800b91 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b75:	8b 45 08             	mov    0x8(%ebp),%eax
  800b78:	8b 00                	mov    (%eax),%eax
  800b7a:	8d 50 08             	lea    0x8(%eax),%edx
  800b7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b80:	89 10                	mov    %edx,(%eax)
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	83 e8 08             	sub    $0x8,%eax
  800b8a:	8b 50 04             	mov    0x4(%eax),%edx
  800b8d:	8b 00                	mov    (%eax),%eax
  800b8f:	eb 40                	jmp    800bd1 <getuint+0x65>
	else if (lflag)
  800b91:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b95:	74 1e                	je     800bb5 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b97:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9a:	8b 00                	mov    (%eax),%eax
  800b9c:	8d 50 04             	lea    0x4(%eax),%edx
  800b9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba2:	89 10                	mov    %edx,(%eax)
  800ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba7:	8b 00                	mov    (%eax),%eax
  800ba9:	83 e8 04             	sub    $0x4,%eax
  800bac:	8b 00                	mov    (%eax),%eax
  800bae:	ba 00 00 00 00       	mov    $0x0,%edx
  800bb3:	eb 1c                	jmp    800bd1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800bb5:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb8:	8b 00                	mov    (%eax),%eax
  800bba:	8d 50 04             	lea    0x4(%eax),%edx
  800bbd:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc0:	89 10                	mov    %edx,(%eax)
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	8b 00                	mov    (%eax),%eax
  800bc7:	83 e8 04             	sub    $0x4,%eax
  800bca:	8b 00                	mov    (%eax),%eax
  800bcc:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800bd1:	5d                   	pop    %ebp
  800bd2:	c3                   	ret    

00800bd3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800bd3:	55                   	push   %ebp
  800bd4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800bd6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800bda:	7e 1c                	jle    800bf8 <getint+0x25>
		return va_arg(*ap, long long);
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	8b 00                	mov    (%eax),%eax
  800be1:	8d 50 08             	lea    0x8(%eax),%edx
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	89 10                	mov    %edx,(%eax)
  800be9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bec:	8b 00                	mov    (%eax),%eax
  800bee:	83 e8 08             	sub    $0x8,%eax
  800bf1:	8b 50 04             	mov    0x4(%eax),%edx
  800bf4:	8b 00                	mov    (%eax),%eax
  800bf6:	eb 38                	jmp    800c30 <getint+0x5d>
	else if (lflag)
  800bf8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bfc:	74 1a                	je     800c18 <getint+0x45>
		return va_arg(*ap, long);
  800bfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800c01:	8b 00                	mov    (%eax),%eax
  800c03:	8d 50 04             	lea    0x4(%eax),%edx
  800c06:	8b 45 08             	mov    0x8(%ebp),%eax
  800c09:	89 10                	mov    %edx,(%eax)
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	8b 00                	mov    (%eax),%eax
  800c10:	83 e8 04             	sub    $0x4,%eax
  800c13:	8b 00                	mov    (%eax),%eax
  800c15:	99                   	cltd   
  800c16:	eb 18                	jmp    800c30 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	8b 00                	mov    (%eax),%eax
  800c1d:	8d 50 04             	lea    0x4(%eax),%edx
  800c20:	8b 45 08             	mov    0x8(%ebp),%eax
  800c23:	89 10                	mov    %edx,(%eax)
  800c25:	8b 45 08             	mov    0x8(%ebp),%eax
  800c28:	8b 00                	mov    (%eax),%eax
  800c2a:	83 e8 04             	sub    $0x4,%eax
  800c2d:	8b 00                	mov    (%eax),%eax
  800c2f:	99                   	cltd   
}
  800c30:	5d                   	pop    %ebp
  800c31:	c3                   	ret    

00800c32 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800c32:	55                   	push   %ebp
  800c33:	89 e5                	mov    %esp,%ebp
  800c35:	56                   	push   %esi
  800c36:	53                   	push   %ebx
  800c37:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c3a:	eb 17                	jmp    800c53 <vprintfmt+0x21>
			if (ch == '\0')
  800c3c:	85 db                	test   %ebx,%ebx
  800c3e:	0f 84 af 03 00 00    	je     800ff3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c44:	83 ec 08             	sub    $0x8,%esp
  800c47:	ff 75 0c             	pushl  0xc(%ebp)
  800c4a:	53                   	push   %ebx
  800c4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4e:	ff d0                	call   *%eax
  800c50:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c53:	8b 45 10             	mov    0x10(%ebp),%eax
  800c56:	8d 50 01             	lea    0x1(%eax),%edx
  800c59:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5c:	8a 00                	mov    (%eax),%al
  800c5e:	0f b6 d8             	movzbl %al,%ebx
  800c61:	83 fb 25             	cmp    $0x25,%ebx
  800c64:	75 d6                	jne    800c3c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c66:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c6a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c71:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c78:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c7f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c86:	8b 45 10             	mov    0x10(%ebp),%eax
  800c89:	8d 50 01             	lea    0x1(%eax),%edx
  800c8c:	89 55 10             	mov    %edx,0x10(%ebp)
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	0f b6 d8             	movzbl %al,%ebx
  800c94:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c97:	83 f8 55             	cmp    $0x55,%eax
  800c9a:	0f 87 2b 03 00 00    	ja     800fcb <vprintfmt+0x399>
  800ca0:	8b 04 85 58 29 80 00 	mov    0x802958(,%eax,4),%eax
  800ca7:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800ca9:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800cad:	eb d7                	jmp    800c86 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800caf:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800cb3:	eb d1                	jmp    800c86 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800cb5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800cbc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800cbf:	89 d0                	mov    %edx,%eax
  800cc1:	c1 e0 02             	shl    $0x2,%eax
  800cc4:	01 d0                	add    %edx,%eax
  800cc6:	01 c0                	add    %eax,%eax
  800cc8:	01 d8                	add    %ebx,%eax
  800cca:	83 e8 30             	sub    $0x30,%eax
  800ccd:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800cd0:	8b 45 10             	mov    0x10(%ebp),%eax
  800cd3:	8a 00                	mov    (%eax),%al
  800cd5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800cd8:	83 fb 2f             	cmp    $0x2f,%ebx
  800cdb:	7e 3e                	jle    800d1b <vprintfmt+0xe9>
  800cdd:	83 fb 39             	cmp    $0x39,%ebx
  800ce0:	7f 39                	jg     800d1b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800ce2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ce5:	eb d5                	jmp    800cbc <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ce7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cea:	83 c0 04             	add    $0x4,%eax
  800ced:	89 45 14             	mov    %eax,0x14(%ebp)
  800cf0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cf3:	83 e8 04             	sub    $0x4,%eax
  800cf6:	8b 00                	mov    (%eax),%eax
  800cf8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cfb:	eb 1f                	jmp    800d1c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cfd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d01:	79 83                	jns    800c86 <vprintfmt+0x54>
				width = 0;
  800d03:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800d0a:	e9 77 ff ff ff       	jmp    800c86 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800d0f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800d16:	e9 6b ff ff ff       	jmp    800c86 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800d1b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800d1c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d20:	0f 89 60 ff ff ff    	jns    800c86 <vprintfmt+0x54>
				width = precision, precision = -1;
  800d26:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d29:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800d2c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d33:	e9 4e ff ff ff       	jmp    800c86 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d38:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d3b:	e9 46 ff ff ff       	jmp    800c86 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d40:	8b 45 14             	mov    0x14(%ebp),%eax
  800d43:	83 c0 04             	add    $0x4,%eax
  800d46:	89 45 14             	mov    %eax,0x14(%ebp)
  800d49:	8b 45 14             	mov    0x14(%ebp),%eax
  800d4c:	83 e8 04             	sub    $0x4,%eax
  800d4f:	8b 00                	mov    (%eax),%eax
  800d51:	83 ec 08             	sub    $0x8,%esp
  800d54:	ff 75 0c             	pushl  0xc(%ebp)
  800d57:	50                   	push   %eax
  800d58:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5b:	ff d0                	call   *%eax
  800d5d:	83 c4 10             	add    $0x10,%esp
			break;
  800d60:	e9 89 02 00 00       	jmp    800fee <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d65:	8b 45 14             	mov    0x14(%ebp),%eax
  800d68:	83 c0 04             	add    $0x4,%eax
  800d6b:	89 45 14             	mov    %eax,0x14(%ebp)
  800d6e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d71:	83 e8 04             	sub    $0x4,%eax
  800d74:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d76:	85 db                	test   %ebx,%ebx
  800d78:	79 02                	jns    800d7c <vprintfmt+0x14a>
				err = -err;
  800d7a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d7c:	83 fb 64             	cmp    $0x64,%ebx
  800d7f:	7f 0b                	jg     800d8c <vprintfmt+0x15a>
  800d81:	8b 34 9d a0 27 80 00 	mov    0x8027a0(,%ebx,4),%esi
  800d88:	85 f6                	test   %esi,%esi
  800d8a:	75 19                	jne    800da5 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d8c:	53                   	push   %ebx
  800d8d:	68 45 29 80 00       	push   $0x802945
  800d92:	ff 75 0c             	pushl  0xc(%ebp)
  800d95:	ff 75 08             	pushl  0x8(%ebp)
  800d98:	e8 5e 02 00 00       	call   800ffb <printfmt>
  800d9d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800da0:	e9 49 02 00 00       	jmp    800fee <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800da5:	56                   	push   %esi
  800da6:	68 4e 29 80 00       	push   $0x80294e
  800dab:	ff 75 0c             	pushl  0xc(%ebp)
  800dae:	ff 75 08             	pushl  0x8(%ebp)
  800db1:	e8 45 02 00 00       	call   800ffb <printfmt>
  800db6:	83 c4 10             	add    $0x10,%esp
			break;
  800db9:	e9 30 02 00 00       	jmp    800fee <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800dbe:	8b 45 14             	mov    0x14(%ebp),%eax
  800dc1:	83 c0 04             	add    $0x4,%eax
  800dc4:	89 45 14             	mov    %eax,0x14(%ebp)
  800dc7:	8b 45 14             	mov    0x14(%ebp),%eax
  800dca:	83 e8 04             	sub    $0x4,%eax
  800dcd:	8b 30                	mov    (%eax),%esi
  800dcf:	85 f6                	test   %esi,%esi
  800dd1:	75 05                	jne    800dd8 <vprintfmt+0x1a6>
				p = "(null)";
  800dd3:	be 51 29 80 00       	mov    $0x802951,%esi
			if (width > 0 && padc != '-')
  800dd8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ddc:	7e 6d                	jle    800e4b <vprintfmt+0x219>
  800dde:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800de2:	74 67                	je     800e4b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800de4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800de7:	83 ec 08             	sub    $0x8,%esp
  800dea:	50                   	push   %eax
  800deb:	56                   	push   %esi
  800dec:	e8 12 05 00 00       	call   801303 <strnlen>
  800df1:	83 c4 10             	add    $0x10,%esp
  800df4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800df7:	eb 16                	jmp    800e0f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800df9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dfd:	83 ec 08             	sub    $0x8,%esp
  800e00:	ff 75 0c             	pushl  0xc(%ebp)
  800e03:	50                   	push   %eax
  800e04:	8b 45 08             	mov    0x8(%ebp),%eax
  800e07:	ff d0                	call   *%eax
  800e09:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800e0c:	ff 4d e4             	decl   -0x1c(%ebp)
  800e0f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e13:	7f e4                	jg     800df9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e15:	eb 34                	jmp    800e4b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800e17:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800e1b:	74 1c                	je     800e39 <vprintfmt+0x207>
  800e1d:	83 fb 1f             	cmp    $0x1f,%ebx
  800e20:	7e 05                	jle    800e27 <vprintfmt+0x1f5>
  800e22:	83 fb 7e             	cmp    $0x7e,%ebx
  800e25:	7e 12                	jle    800e39 <vprintfmt+0x207>
					putch('?', putdat);
  800e27:	83 ec 08             	sub    $0x8,%esp
  800e2a:	ff 75 0c             	pushl  0xc(%ebp)
  800e2d:	6a 3f                	push   $0x3f
  800e2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e32:	ff d0                	call   *%eax
  800e34:	83 c4 10             	add    $0x10,%esp
  800e37:	eb 0f                	jmp    800e48 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e39:	83 ec 08             	sub    $0x8,%esp
  800e3c:	ff 75 0c             	pushl  0xc(%ebp)
  800e3f:	53                   	push   %ebx
  800e40:	8b 45 08             	mov    0x8(%ebp),%eax
  800e43:	ff d0                	call   *%eax
  800e45:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e48:	ff 4d e4             	decl   -0x1c(%ebp)
  800e4b:	89 f0                	mov    %esi,%eax
  800e4d:	8d 70 01             	lea    0x1(%eax),%esi
  800e50:	8a 00                	mov    (%eax),%al
  800e52:	0f be d8             	movsbl %al,%ebx
  800e55:	85 db                	test   %ebx,%ebx
  800e57:	74 24                	je     800e7d <vprintfmt+0x24b>
  800e59:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e5d:	78 b8                	js     800e17 <vprintfmt+0x1e5>
  800e5f:	ff 4d e0             	decl   -0x20(%ebp)
  800e62:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e66:	79 af                	jns    800e17 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e68:	eb 13                	jmp    800e7d <vprintfmt+0x24b>
				putch(' ', putdat);
  800e6a:	83 ec 08             	sub    $0x8,%esp
  800e6d:	ff 75 0c             	pushl  0xc(%ebp)
  800e70:	6a 20                	push   $0x20
  800e72:	8b 45 08             	mov    0x8(%ebp),%eax
  800e75:	ff d0                	call   *%eax
  800e77:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e7a:	ff 4d e4             	decl   -0x1c(%ebp)
  800e7d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e81:	7f e7                	jg     800e6a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e83:	e9 66 01 00 00       	jmp    800fee <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e88:	83 ec 08             	sub    $0x8,%esp
  800e8b:	ff 75 e8             	pushl  -0x18(%ebp)
  800e8e:	8d 45 14             	lea    0x14(%ebp),%eax
  800e91:	50                   	push   %eax
  800e92:	e8 3c fd ff ff       	call   800bd3 <getint>
  800e97:	83 c4 10             	add    $0x10,%esp
  800e9a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e9d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800ea0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ea3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ea6:	85 d2                	test   %edx,%edx
  800ea8:	79 23                	jns    800ecd <vprintfmt+0x29b>
				putch('-', putdat);
  800eaa:	83 ec 08             	sub    $0x8,%esp
  800ead:	ff 75 0c             	pushl  0xc(%ebp)
  800eb0:	6a 2d                	push   $0x2d
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	ff d0                	call   *%eax
  800eb7:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800eba:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ebd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ec0:	f7 d8                	neg    %eax
  800ec2:	83 d2 00             	adc    $0x0,%edx
  800ec5:	f7 da                	neg    %edx
  800ec7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eca:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800ecd:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ed4:	e9 bc 00 00 00       	jmp    800f95 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ed9:	83 ec 08             	sub    $0x8,%esp
  800edc:	ff 75 e8             	pushl  -0x18(%ebp)
  800edf:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee2:	50                   	push   %eax
  800ee3:	e8 84 fc ff ff       	call   800b6c <getuint>
  800ee8:	83 c4 10             	add    $0x10,%esp
  800eeb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eee:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ef1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ef8:	e9 98 00 00 00       	jmp    800f95 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800efd:	83 ec 08             	sub    $0x8,%esp
  800f00:	ff 75 0c             	pushl  0xc(%ebp)
  800f03:	6a 58                	push   $0x58
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	ff d0                	call   *%eax
  800f0a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f0d:	83 ec 08             	sub    $0x8,%esp
  800f10:	ff 75 0c             	pushl  0xc(%ebp)
  800f13:	6a 58                	push   $0x58
  800f15:	8b 45 08             	mov    0x8(%ebp),%eax
  800f18:	ff d0                	call   *%eax
  800f1a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800f1d:	83 ec 08             	sub    $0x8,%esp
  800f20:	ff 75 0c             	pushl  0xc(%ebp)
  800f23:	6a 58                	push   $0x58
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	ff d0                	call   *%eax
  800f2a:	83 c4 10             	add    $0x10,%esp
			break;
  800f2d:	e9 bc 00 00 00       	jmp    800fee <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800f32:	83 ec 08             	sub    $0x8,%esp
  800f35:	ff 75 0c             	pushl  0xc(%ebp)
  800f38:	6a 30                	push   $0x30
  800f3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3d:	ff d0                	call   *%eax
  800f3f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f42:	83 ec 08             	sub    $0x8,%esp
  800f45:	ff 75 0c             	pushl  0xc(%ebp)
  800f48:	6a 78                	push   $0x78
  800f4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800f4d:	ff d0                	call   *%eax
  800f4f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f52:	8b 45 14             	mov    0x14(%ebp),%eax
  800f55:	83 c0 04             	add    $0x4,%eax
  800f58:	89 45 14             	mov    %eax,0x14(%ebp)
  800f5b:	8b 45 14             	mov    0x14(%ebp),%eax
  800f5e:	83 e8 04             	sub    $0x4,%eax
  800f61:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f63:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f66:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f6d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f74:	eb 1f                	jmp    800f95 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 e8             	pushl  -0x18(%ebp)
  800f7c:	8d 45 14             	lea    0x14(%ebp),%eax
  800f7f:	50                   	push   %eax
  800f80:	e8 e7 fb ff ff       	call   800b6c <getuint>
  800f85:	83 c4 10             	add    $0x10,%esp
  800f88:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f8b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f8e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f95:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f99:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f9c:	83 ec 04             	sub    $0x4,%esp
  800f9f:	52                   	push   %edx
  800fa0:	ff 75 e4             	pushl  -0x1c(%ebp)
  800fa3:	50                   	push   %eax
  800fa4:	ff 75 f4             	pushl  -0xc(%ebp)
  800fa7:	ff 75 f0             	pushl  -0x10(%ebp)
  800faa:	ff 75 0c             	pushl  0xc(%ebp)
  800fad:	ff 75 08             	pushl  0x8(%ebp)
  800fb0:	e8 00 fb ff ff       	call   800ab5 <printnum>
  800fb5:	83 c4 20             	add    $0x20,%esp
			break;
  800fb8:	eb 34                	jmp    800fee <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800fba:	83 ec 08             	sub    $0x8,%esp
  800fbd:	ff 75 0c             	pushl  0xc(%ebp)
  800fc0:	53                   	push   %ebx
  800fc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc4:	ff d0                	call   *%eax
  800fc6:	83 c4 10             	add    $0x10,%esp
			break;
  800fc9:	eb 23                	jmp    800fee <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800fcb:	83 ec 08             	sub    $0x8,%esp
  800fce:	ff 75 0c             	pushl  0xc(%ebp)
  800fd1:	6a 25                	push   $0x25
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	ff d0                	call   *%eax
  800fd8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fdb:	ff 4d 10             	decl   0x10(%ebp)
  800fde:	eb 03                	jmp    800fe3 <vprintfmt+0x3b1>
  800fe0:	ff 4d 10             	decl   0x10(%ebp)
  800fe3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fe6:	48                   	dec    %eax
  800fe7:	8a 00                	mov    (%eax),%al
  800fe9:	3c 25                	cmp    $0x25,%al
  800feb:	75 f3                	jne    800fe0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fed:	90                   	nop
		}
	}
  800fee:	e9 47 fc ff ff       	jmp    800c3a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800ff3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800ff4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ff7:	5b                   	pop    %ebx
  800ff8:	5e                   	pop    %esi
  800ff9:	5d                   	pop    %ebp
  800ffa:	c3                   	ret    

00800ffb <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ffb:	55                   	push   %ebp
  800ffc:	89 e5                	mov    %esp,%ebp
  800ffe:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801001:	8d 45 10             	lea    0x10(%ebp),%eax
  801004:	83 c0 04             	add    $0x4,%eax
  801007:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80100a:	8b 45 10             	mov    0x10(%ebp),%eax
  80100d:	ff 75 f4             	pushl  -0xc(%ebp)
  801010:	50                   	push   %eax
  801011:	ff 75 0c             	pushl  0xc(%ebp)
  801014:	ff 75 08             	pushl  0x8(%ebp)
  801017:	e8 16 fc ff ff       	call   800c32 <vprintfmt>
  80101c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80101f:	90                   	nop
  801020:	c9                   	leave  
  801021:	c3                   	ret    

00801022 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801022:	55                   	push   %ebp
  801023:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801025:	8b 45 0c             	mov    0xc(%ebp),%eax
  801028:	8b 40 08             	mov    0x8(%eax),%eax
  80102b:	8d 50 01             	lea    0x1(%eax),%edx
  80102e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801031:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801034:	8b 45 0c             	mov    0xc(%ebp),%eax
  801037:	8b 10                	mov    (%eax),%edx
  801039:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103c:	8b 40 04             	mov    0x4(%eax),%eax
  80103f:	39 c2                	cmp    %eax,%edx
  801041:	73 12                	jae    801055 <sprintputch+0x33>
		*b->buf++ = ch;
  801043:	8b 45 0c             	mov    0xc(%ebp),%eax
  801046:	8b 00                	mov    (%eax),%eax
  801048:	8d 48 01             	lea    0x1(%eax),%ecx
  80104b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80104e:	89 0a                	mov    %ecx,(%edx)
  801050:	8b 55 08             	mov    0x8(%ebp),%edx
  801053:	88 10                	mov    %dl,(%eax)
}
  801055:	90                   	nop
  801056:	5d                   	pop    %ebp
  801057:	c3                   	ret    

00801058 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801058:	55                   	push   %ebp
  801059:	89 e5                	mov    %esp,%ebp
  80105b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80105e:	8b 45 08             	mov    0x8(%ebp),%eax
  801061:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801064:	8b 45 0c             	mov    0xc(%ebp),%eax
  801067:	8d 50 ff             	lea    -0x1(%eax),%edx
  80106a:	8b 45 08             	mov    0x8(%ebp),%eax
  80106d:	01 d0                	add    %edx,%eax
  80106f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801072:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801079:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80107d:	74 06                	je     801085 <vsnprintf+0x2d>
  80107f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801083:	7f 07                	jg     80108c <vsnprintf+0x34>
		return -E_INVAL;
  801085:	b8 03 00 00 00       	mov    $0x3,%eax
  80108a:	eb 20                	jmp    8010ac <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80108c:	ff 75 14             	pushl  0x14(%ebp)
  80108f:	ff 75 10             	pushl  0x10(%ebp)
  801092:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801095:	50                   	push   %eax
  801096:	68 22 10 80 00       	push   $0x801022
  80109b:	e8 92 fb ff ff       	call   800c32 <vprintfmt>
  8010a0:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8010a3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010a6:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8010a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8010ac:	c9                   	leave  
  8010ad:	c3                   	ret    

008010ae <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8010ae:	55                   	push   %ebp
  8010af:	89 e5                	mov    %esp,%ebp
  8010b1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8010b4:	8d 45 10             	lea    0x10(%ebp),%eax
  8010b7:	83 c0 04             	add    $0x4,%eax
  8010ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8010bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8010c0:	ff 75 f4             	pushl  -0xc(%ebp)
  8010c3:	50                   	push   %eax
  8010c4:	ff 75 0c             	pushl  0xc(%ebp)
  8010c7:	ff 75 08             	pushl  0x8(%ebp)
  8010ca:	e8 89 ff ff ff       	call   801058 <vsnprintf>
  8010cf:	83 c4 10             	add    $0x10,%esp
  8010d2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010d8:	c9                   	leave  
  8010d9:	c3                   	ret    

008010da <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010da:	55                   	push   %ebp
  8010db:	89 e5                	mov    %esp,%ebp
  8010dd:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010e0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010e4:	74 13                	je     8010f9 <readline+0x1f>
		cprintf("%s", prompt);
  8010e6:	83 ec 08             	sub    $0x8,%esp
  8010e9:	ff 75 08             	pushl  0x8(%ebp)
  8010ec:	68 b0 2a 80 00       	push   $0x802ab0
  8010f1:	e8 62 f9 ff ff       	call   800a58 <cprintf>
  8010f6:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801100:	83 ec 0c             	sub    $0xc,%esp
  801103:	6a 00                	push   $0x0
  801105:	e8 74 f5 ff ff       	call   80067e <iscons>
  80110a:	83 c4 10             	add    $0x10,%esp
  80110d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801110:	e8 1b f5 ff ff       	call   800630 <getchar>
  801115:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801118:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80111c:	79 22                	jns    801140 <readline+0x66>
			if (c != -E_EOF)
  80111e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801122:	0f 84 ad 00 00 00    	je     8011d5 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801128:	83 ec 08             	sub    $0x8,%esp
  80112b:	ff 75 ec             	pushl  -0x14(%ebp)
  80112e:	68 b3 2a 80 00       	push   $0x802ab3
  801133:	e8 20 f9 ff ff       	call   800a58 <cprintf>
  801138:	83 c4 10             	add    $0x10,%esp
			return;
  80113b:	e9 95 00 00 00       	jmp    8011d5 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801140:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801144:	7e 34                	jle    80117a <readline+0xa0>
  801146:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80114d:	7f 2b                	jg     80117a <readline+0xa0>
			if (echoing)
  80114f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801153:	74 0e                	je     801163 <readline+0x89>
				cputchar(c);
  801155:	83 ec 0c             	sub    $0xc,%esp
  801158:	ff 75 ec             	pushl  -0x14(%ebp)
  80115b:	e8 88 f4 ff ff       	call   8005e8 <cputchar>
  801160:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801163:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801166:	8d 50 01             	lea    0x1(%eax),%edx
  801169:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80116c:	89 c2                	mov    %eax,%edx
  80116e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801171:	01 d0                	add    %edx,%eax
  801173:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801176:	88 10                	mov    %dl,(%eax)
  801178:	eb 56                	jmp    8011d0 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80117a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80117e:	75 1f                	jne    80119f <readline+0xc5>
  801180:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801184:	7e 19                	jle    80119f <readline+0xc5>
			if (echoing)
  801186:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80118a:	74 0e                	je     80119a <readline+0xc0>
				cputchar(c);
  80118c:	83 ec 0c             	sub    $0xc,%esp
  80118f:	ff 75 ec             	pushl  -0x14(%ebp)
  801192:	e8 51 f4 ff ff       	call   8005e8 <cputchar>
  801197:	83 c4 10             	add    $0x10,%esp

			i--;
  80119a:	ff 4d f4             	decl   -0xc(%ebp)
  80119d:	eb 31                	jmp    8011d0 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80119f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8011a3:	74 0a                	je     8011af <readline+0xd5>
  8011a5:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8011a9:	0f 85 61 ff ff ff    	jne    801110 <readline+0x36>
			if (echoing)
  8011af:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011b3:	74 0e                	je     8011c3 <readline+0xe9>
				cputchar(c);
  8011b5:	83 ec 0c             	sub    $0xc,%esp
  8011b8:	ff 75 ec             	pushl  -0x14(%ebp)
  8011bb:	e8 28 f4 ff ff       	call   8005e8 <cputchar>
  8011c0:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8011c3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c9:	01 d0                	add    %edx,%eax
  8011cb:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8011ce:	eb 06                	jmp    8011d6 <readline+0xfc>
		}
	}
  8011d0:	e9 3b ff ff ff       	jmp    801110 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011d5:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011d6:	c9                   	leave  
  8011d7:	c3                   	ret    

008011d8 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011d8:	55                   	push   %ebp
  8011d9:	89 e5                	mov    %esp,%ebp
  8011db:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011de:	e8 31 0b 00 00       	call   801d14 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011e3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011e7:	74 13                	je     8011fc <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011e9:	83 ec 08             	sub    $0x8,%esp
  8011ec:	ff 75 08             	pushl  0x8(%ebp)
  8011ef:	68 b0 2a 80 00       	push   $0x802ab0
  8011f4:	e8 5f f8 ff ff       	call   800a58 <cprintf>
  8011f9:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011fc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801203:	83 ec 0c             	sub    $0xc,%esp
  801206:	6a 00                	push   $0x0
  801208:	e8 71 f4 ff ff       	call   80067e <iscons>
  80120d:	83 c4 10             	add    $0x10,%esp
  801210:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801213:	e8 18 f4 ff ff       	call   800630 <getchar>
  801218:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80121b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80121f:	79 23                	jns    801244 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801221:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801225:	74 13                	je     80123a <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801227:	83 ec 08             	sub    $0x8,%esp
  80122a:	ff 75 ec             	pushl  -0x14(%ebp)
  80122d:	68 b3 2a 80 00       	push   $0x802ab3
  801232:	e8 21 f8 ff ff       	call   800a58 <cprintf>
  801237:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80123a:	e8 ef 0a 00 00       	call   801d2e <sys_enable_interrupt>
			return;
  80123f:	e9 9a 00 00 00       	jmp    8012de <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801244:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801248:	7e 34                	jle    80127e <atomic_readline+0xa6>
  80124a:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801251:	7f 2b                	jg     80127e <atomic_readline+0xa6>
			if (echoing)
  801253:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801257:	74 0e                	je     801267 <atomic_readline+0x8f>
				cputchar(c);
  801259:	83 ec 0c             	sub    $0xc,%esp
  80125c:	ff 75 ec             	pushl  -0x14(%ebp)
  80125f:	e8 84 f3 ff ff       	call   8005e8 <cputchar>
  801264:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801267:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80126a:	8d 50 01             	lea    0x1(%eax),%edx
  80126d:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801270:	89 c2                	mov    %eax,%edx
  801272:	8b 45 0c             	mov    0xc(%ebp),%eax
  801275:	01 d0                	add    %edx,%eax
  801277:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80127a:	88 10                	mov    %dl,(%eax)
  80127c:	eb 5b                	jmp    8012d9 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80127e:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801282:	75 1f                	jne    8012a3 <atomic_readline+0xcb>
  801284:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801288:	7e 19                	jle    8012a3 <atomic_readline+0xcb>
			if (echoing)
  80128a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80128e:	74 0e                	je     80129e <atomic_readline+0xc6>
				cputchar(c);
  801290:	83 ec 0c             	sub    $0xc,%esp
  801293:	ff 75 ec             	pushl  -0x14(%ebp)
  801296:	e8 4d f3 ff ff       	call   8005e8 <cputchar>
  80129b:	83 c4 10             	add    $0x10,%esp
			i--;
  80129e:	ff 4d f4             	decl   -0xc(%ebp)
  8012a1:	eb 36                	jmp    8012d9 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8012a3:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012a7:	74 0a                	je     8012b3 <atomic_readline+0xdb>
  8012a9:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012ad:	0f 85 60 ff ff ff    	jne    801213 <atomic_readline+0x3b>
			if (echoing)
  8012b3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012b7:	74 0e                	je     8012c7 <atomic_readline+0xef>
				cputchar(c);
  8012b9:	83 ec 0c             	sub    $0xc,%esp
  8012bc:	ff 75 ec             	pushl  -0x14(%ebp)
  8012bf:	e8 24 f3 ff ff       	call   8005e8 <cputchar>
  8012c4:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8012c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012ca:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012cd:	01 d0                	add    %edx,%eax
  8012cf:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8012d2:	e8 57 0a 00 00       	call   801d2e <sys_enable_interrupt>
			return;
  8012d7:	eb 05                	jmp    8012de <atomic_readline+0x106>
		}
	}
  8012d9:	e9 35 ff ff ff       	jmp    801213 <atomic_readline+0x3b>
}
  8012de:	c9                   	leave  
  8012df:	c3                   	ret    

008012e0 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012e0:	55                   	push   %ebp
  8012e1:	89 e5                	mov    %esp,%ebp
  8012e3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012e6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ed:	eb 06                	jmp    8012f5 <strlen+0x15>
		n++;
  8012ef:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012f2:	ff 45 08             	incl   0x8(%ebp)
  8012f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f8:	8a 00                	mov    (%eax),%al
  8012fa:	84 c0                	test   %al,%al
  8012fc:	75 f1                	jne    8012ef <strlen+0xf>
		n++;
	return n;
  8012fe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801301:	c9                   	leave  
  801302:	c3                   	ret    

00801303 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801303:	55                   	push   %ebp
  801304:	89 e5                	mov    %esp,%ebp
  801306:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801309:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801310:	eb 09                	jmp    80131b <strnlen+0x18>
		n++;
  801312:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801315:	ff 45 08             	incl   0x8(%ebp)
  801318:	ff 4d 0c             	decl   0xc(%ebp)
  80131b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80131f:	74 09                	je     80132a <strnlen+0x27>
  801321:	8b 45 08             	mov    0x8(%ebp),%eax
  801324:	8a 00                	mov    (%eax),%al
  801326:	84 c0                	test   %al,%al
  801328:	75 e8                	jne    801312 <strnlen+0xf>
		n++;
	return n;
  80132a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80132d:	c9                   	leave  
  80132e:	c3                   	ret    

0080132f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80132f:	55                   	push   %ebp
  801330:	89 e5                	mov    %esp,%ebp
  801332:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801335:	8b 45 08             	mov    0x8(%ebp),%eax
  801338:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80133b:	90                   	nop
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	8d 50 01             	lea    0x1(%eax),%edx
  801342:	89 55 08             	mov    %edx,0x8(%ebp)
  801345:	8b 55 0c             	mov    0xc(%ebp),%edx
  801348:	8d 4a 01             	lea    0x1(%edx),%ecx
  80134b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80134e:	8a 12                	mov    (%edx),%dl
  801350:	88 10                	mov    %dl,(%eax)
  801352:	8a 00                	mov    (%eax),%al
  801354:	84 c0                	test   %al,%al
  801356:	75 e4                	jne    80133c <strcpy+0xd>
		/* do nothing */;
	return ret;
  801358:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80135b:	c9                   	leave  
  80135c:	c3                   	ret    

0080135d <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80135d:	55                   	push   %ebp
  80135e:	89 e5                	mov    %esp,%ebp
  801360:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801363:	8b 45 08             	mov    0x8(%ebp),%eax
  801366:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801369:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801370:	eb 1f                	jmp    801391 <strncpy+0x34>
		*dst++ = *src;
  801372:	8b 45 08             	mov    0x8(%ebp),%eax
  801375:	8d 50 01             	lea    0x1(%eax),%edx
  801378:	89 55 08             	mov    %edx,0x8(%ebp)
  80137b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137e:	8a 12                	mov    (%edx),%dl
  801380:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801382:	8b 45 0c             	mov    0xc(%ebp),%eax
  801385:	8a 00                	mov    (%eax),%al
  801387:	84 c0                	test   %al,%al
  801389:	74 03                	je     80138e <strncpy+0x31>
			src++;
  80138b:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80138e:	ff 45 fc             	incl   -0x4(%ebp)
  801391:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801394:	3b 45 10             	cmp    0x10(%ebp),%eax
  801397:	72 d9                	jb     801372 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801399:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80139c:	c9                   	leave  
  80139d:	c3                   	ret    

0080139e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80139e:	55                   	push   %ebp
  80139f:	89 e5                	mov    %esp,%ebp
  8013a1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8013a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8013aa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013ae:	74 30                	je     8013e0 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8013b0:	eb 16                	jmp    8013c8 <strlcpy+0x2a>
			*dst++ = *src++;
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8d 50 01             	lea    0x1(%eax),%edx
  8013b8:	89 55 08             	mov    %edx,0x8(%ebp)
  8013bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8013be:	8d 4a 01             	lea    0x1(%edx),%ecx
  8013c1:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8013c4:	8a 12                	mov    (%edx),%dl
  8013c6:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8013c8:	ff 4d 10             	decl   0x10(%ebp)
  8013cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013cf:	74 09                	je     8013da <strlcpy+0x3c>
  8013d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d4:	8a 00                	mov    (%eax),%al
  8013d6:	84 c0                	test   %al,%al
  8013d8:	75 d8                	jne    8013b2 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013da:	8b 45 08             	mov    0x8(%ebp),%eax
  8013dd:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013e0:	8b 55 08             	mov    0x8(%ebp),%edx
  8013e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013e6:	29 c2                	sub    %eax,%edx
  8013e8:	89 d0                	mov    %edx,%eax
}
  8013ea:	c9                   	leave  
  8013eb:	c3                   	ret    

008013ec <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013ec:	55                   	push   %ebp
  8013ed:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013ef:	eb 06                	jmp    8013f7 <strcmp+0xb>
		p++, q++;
  8013f1:	ff 45 08             	incl   0x8(%ebp)
  8013f4:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fa:	8a 00                	mov    (%eax),%al
  8013fc:	84 c0                	test   %al,%al
  8013fe:	74 0e                	je     80140e <strcmp+0x22>
  801400:	8b 45 08             	mov    0x8(%ebp),%eax
  801403:	8a 10                	mov    (%eax),%dl
  801405:	8b 45 0c             	mov    0xc(%ebp),%eax
  801408:	8a 00                	mov    (%eax),%al
  80140a:	38 c2                	cmp    %al,%dl
  80140c:	74 e3                	je     8013f1 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	0f b6 d0             	movzbl %al,%edx
  801416:	8b 45 0c             	mov    0xc(%ebp),%eax
  801419:	8a 00                	mov    (%eax),%al
  80141b:	0f b6 c0             	movzbl %al,%eax
  80141e:	29 c2                	sub    %eax,%edx
  801420:	89 d0                	mov    %edx,%eax
}
  801422:	5d                   	pop    %ebp
  801423:	c3                   	ret    

00801424 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801427:	eb 09                	jmp    801432 <strncmp+0xe>
		n--, p++, q++;
  801429:	ff 4d 10             	decl   0x10(%ebp)
  80142c:	ff 45 08             	incl   0x8(%ebp)
  80142f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801432:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801436:	74 17                	je     80144f <strncmp+0x2b>
  801438:	8b 45 08             	mov    0x8(%ebp),%eax
  80143b:	8a 00                	mov    (%eax),%al
  80143d:	84 c0                	test   %al,%al
  80143f:	74 0e                	je     80144f <strncmp+0x2b>
  801441:	8b 45 08             	mov    0x8(%ebp),%eax
  801444:	8a 10                	mov    (%eax),%dl
  801446:	8b 45 0c             	mov    0xc(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	38 c2                	cmp    %al,%dl
  80144d:	74 da                	je     801429 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80144f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801453:	75 07                	jne    80145c <strncmp+0x38>
		return 0;
  801455:	b8 00 00 00 00       	mov    $0x0,%eax
  80145a:	eb 14                	jmp    801470 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80145c:	8b 45 08             	mov    0x8(%ebp),%eax
  80145f:	8a 00                	mov    (%eax),%al
  801461:	0f b6 d0             	movzbl %al,%edx
  801464:	8b 45 0c             	mov    0xc(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	0f b6 c0             	movzbl %al,%eax
  80146c:	29 c2                	sub    %eax,%edx
  80146e:	89 d0                	mov    %edx,%eax
}
  801470:	5d                   	pop    %ebp
  801471:	c3                   	ret    

00801472 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801472:	55                   	push   %ebp
  801473:	89 e5                	mov    %esp,%ebp
  801475:	83 ec 04             	sub    $0x4,%esp
  801478:	8b 45 0c             	mov    0xc(%ebp),%eax
  80147b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80147e:	eb 12                	jmp    801492 <strchr+0x20>
		if (*s == c)
  801480:	8b 45 08             	mov    0x8(%ebp),%eax
  801483:	8a 00                	mov    (%eax),%al
  801485:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801488:	75 05                	jne    80148f <strchr+0x1d>
			return (char *) s;
  80148a:	8b 45 08             	mov    0x8(%ebp),%eax
  80148d:	eb 11                	jmp    8014a0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80148f:	ff 45 08             	incl   0x8(%ebp)
  801492:	8b 45 08             	mov    0x8(%ebp),%eax
  801495:	8a 00                	mov    (%eax),%al
  801497:	84 c0                	test   %al,%al
  801499:	75 e5                	jne    801480 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80149b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8014a0:	c9                   	leave  
  8014a1:	c3                   	ret    

008014a2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8014a2:	55                   	push   %ebp
  8014a3:	89 e5                	mov    %esp,%ebp
  8014a5:	83 ec 04             	sub    $0x4,%esp
  8014a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8014ae:	eb 0d                	jmp    8014bd <strfind+0x1b>
		if (*s == c)
  8014b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b3:	8a 00                	mov    (%eax),%al
  8014b5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8014b8:	74 0e                	je     8014c8 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8014ba:	ff 45 08             	incl   0x8(%ebp)
  8014bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c0:	8a 00                	mov    (%eax),%al
  8014c2:	84 c0                	test   %al,%al
  8014c4:	75 ea                	jne    8014b0 <strfind+0xe>
  8014c6:	eb 01                	jmp    8014c9 <strfind+0x27>
		if (*s == c)
			break;
  8014c8:	90                   	nop
	return (char *) s;
  8014c9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014cc:	c9                   	leave  
  8014cd:	c3                   	ret    

008014ce <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8014ce:	55                   	push   %ebp
  8014cf:	89 e5                	mov    %esp,%ebp
  8014d1:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014da:	8b 45 10             	mov    0x10(%ebp),%eax
  8014dd:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014e0:	eb 0e                	jmp    8014f0 <memset+0x22>
		*p++ = c;
  8014e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e5:	8d 50 01             	lea    0x1(%eax),%edx
  8014e8:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ee:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014f0:	ff 4d f8             	decl   -0x8(%ebp)
  8014f3:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014f7:	79 e9                	jns    8014e2 <memset+0x14>
		*p++ = c;

	return v;
  8014f9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
  801501:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801504:	8b 45 0c             	mov    0xc(%ebp),%eax
  801507:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801510:	eb 16                	jmp    801528 <memcpy+0x2a>
		*d++ = *s++;
  801512:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801515:	8d 50 01             	lea    0x1(%eax),%edx
  801518:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80151b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80151e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801521:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801524:	8a 12                	mov    (%edx),%dl
  801526:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801528:	8b 45 10             	mov    0x10(%ebp),%eax
  80152b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80152e:	89 55 10             	mov    %edx,0x10(%ebp)
  801531:	85 c0                	test   %eax,%eax
  801533:	75 dd                	jne    801512 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801535:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801538:	c9                   	leave  
  801539:	c3                   	ret    

0080153a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80153a:	55                   	push   %ebp
  80153b:	89 e5                	mov    %esp,%ebp
  80153d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801540:	8b 45 0c             	mov    0xc(%ebp),%eax
  801543:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801546:	8b 45 08             	mov    0x8(%ebp),%eax
  801549:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80154c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801552:	73 50                	jae    8015a4 <memmove+0x6a>
  801554:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801557:	8b 45 10             	mov    0x10(%ebp),%eax
  80155a:	01 d0                	add    %edx,%eax
  80155c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80155f:	76 43                	jbe    8015a4 <memmove+0x6a>
		s += n;
  801561:	8b 45 10             	mov    0x10(%ebp),%eax
  801564:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801567:	8b 45 10             	mov    0x10(%ebp),%eax
  80156a:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80156d:	eb 10                	jmp    80157f <memmove+0x45>
			*--d = *--s;
  80156f:	ff 4d f8             	decl   -0x8(%ebp)
  801572:	ff 4d fc             	decl   -0x4(%ebp)
  801575:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801578:	8a 10                	mov    (%eax),%dl
  80157a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80157d:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80157f:	8b 45 10             	mov    0x10(%ebp),%eax
  801582:	8d 50 ff             	lea    -0x1(%eax),%edx
  801585:	89 55 10             	mov    %edx,0x10(%ebp)
  801588:	85 c0                	test   %eax,%eax
  80158a:	75 e3                	jne    80156f <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80158c:	eb 23                	jmp    8015b1 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80158e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801591:	8d 50 01             	lea    0x1(%eax),%edx
  801594:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801597:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80159a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80159d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8015a0:	8a 12                	mov    (%edx),%dl
  8015a2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8015a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015a7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015aa:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ad:	85 c0                	test   %eax,%eax
  8015af:	75 dd                	jne    80158e <memmove+0x54>
			*d++ = *s++;

	return dst;
  8015b1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015b4:	c9                   	leave  
  8015b5:	c3                   	ret    

008015b6 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8015b6:	55                   	push   %ebp
  8015b7:	89 e5                	mov    %esp,%ebp
  8015b9:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8015bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8015c2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c5:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8015c8:	eb 2a                	jmp    8015f4 <memcmp+0x3e>
		if (*s1 != *s2)
  8015ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015cd:	8a 10                	mov    (%eax),%dl
  8015cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015d2:	8a 00                	mov    (%eax),%al
  8015d4:	38 c2                	cmp    %al,%dl
  8015d6:	74 16                	je     8015ee <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015db:	8a 00                	mov    (%eax),%al
  8015dd:	0f b6 d0             	movzbl %al,%edx
  8015e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e3:	8a 00                	mov    (%eax),%al
  8015e5:	0f b6 c0             	movzbl %al,%eax
  8015e8:	29 c2                	sub    %eax,%edx
  8015ea:	89 d0                	mov    %edx,%eax
  8015ec:	eb 18                	jmp    801606 <memcmp+0x50>
		s1++, s2++;
  8015ee:	ff 45 fc             	incl   -0x4(%ebp)
  8015f1:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8015f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8015fd:	85 c0                	test   %eax,%eax
  8015ff:	75 c9                	jne    8015ca <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801601:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801606:	c9                   	leave  
  801607:	c3                   	ret    

00801608 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801608:	55                   	push   %ebp
  801609:	89 e5                	mov    %esp,%ebp
  80160b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80160e:	8b 55 08             	mov    0x8(%ebp),%edx
  801611:	8b 45 10             	mov    0x10(%ebp),%eax
  801614:	01 d0                	add    %edx,%eax
  801616:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801619:	eb 15                	jmp    801630 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80161b:	8b 45 08             	mov    0x8(%ebp),%eax
  80161e:	8a 00                	mov    (%eax),%al
  801620:	0f b6 d0             	movzbl %al,%edx
  801623:	8b 45 0c             	mov    0xc(%ebp),%eax
  801626:	0f b6 c0             	movzbl %al,%eax
  801629:	39 c2                	cmp    %eax,%edx
  80162b:	74 0d                	je     80163a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80162d:	ff 45 08             	incl   0x8(%ebp)
  801630:	8b 45 08             	mov    0x8(%ebp),%eax
  801633:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801636:	72 e3                	jb     80161b <memfind+0x13>
  801638:	eb 01                	jmp    80163b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80163a:	90                   	nop
	return (void *) s;
  80163b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80163e:	c9                   	leave  
  80163f:	c3                   	ret    

00801640 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
  801643:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801646:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80164d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801654:	eb 03                	jmp    801659 <strtol+0x19>
		s++;
  801656:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	8a 00                	mov    (%eax),%al
  80165e:	3c 20                	cmp    $0x20,%al
  801660:	74 f4                	je     801656 <strtol+0x16>
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	3c 09                	cmp    $0x9,%al
  801669:	74 eb                	je     801656 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80166b:	8b 45 08             	mov    0x8(%ebp),%eax
  80166e:	8a 00                	mov    (%eax),%al
  801670:	3c 2b                	cmp    $0x2b,%al
  801672:	75 05                	jne    801679 <strtol+0x39>
		s++;
  801674:	ff 45 08             	incl   0x8(%ebp)
  801677:	eb 13                	jmp    80168c <strtol+0x4c>
	else if (*s == '-')
  801679:	8b 45 08             	mov    0x8(%ebp),%eax
  80167c:	8a 00                	mov    (%eax),%al
  80167e:	3c 2d                	cmp    $0x2d,%al
  801680:	75 0a                	jne    80168c <strtol+0x4c>
		s++, neg = 1;
  801682:	ff 45 08             	incl   0x8(%ebp)
  801685:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80168c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801690:	74 06                	je     801698 <strtol+0x58>
  801692:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801696:	75 20                	jne    8016b8 <strtol+0x78>
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	8a 00                	mov    (%eax),%al
  80169d:	3c 30                	cmp    $0x30,%al
  80169f:	75 17                	jne    8016b8 <strtol+0x78>
  8016a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a4:	40                   	inc    %eax
  8016a5:	8a 00                	mov    (%eax),%al
  8016a7:	3c 78                	cmp    $0x78,%al
  8016a9:	75 0d                	jne    8016b8 <strtol+0x78>
		s += 2, base = 16;
  8016ab:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8016af:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8016b6:	eb 28                	jmp    8016e0 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8016b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016bc:	75 15                	jne    8016d3 <strtol+0x93>
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	8a 00                	mov    (%eax),%al
  8016c3:	3c 30                	cmp    $0x30,%al
  8016c5:	75 0c                	jne    8016d3 <strtol+0x93>
		s++, base = 8;
  8016c7:	ff 45 08             	incl   0x8(%ebp)
  8016ca:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8016d1:	eb 0d                	jmp    8016e0 <strtol+0xa0>
	else if (base == 0)
  8016d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016d7:	75 07                	jne    8016e0 <strtol+0xa0>
		base = 10;
  8016d9:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e3:	8a 00                	mov    (%eax),%al
  8016e5:	3c 2f                	cmp    $0x2f,%al
  8016e7:	7e 19                	jle    801702 <strtol+0xc2>
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	8a 00                	mov    (%eax),%al
  8016ee:	3c 39                	cmp    $0x39,%al
  8016f0:	7f 10                	jg     801702 <strtol+0xc2>
			dig = *s - '0';
  8016f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f5:	8a 00                	mov    (%eax),%al
  8016f7:	0f be c0             	movsbl %al,%eax
  8016fa:	83 e8 30             	sub    $0x30,%eax
  8016fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801700:	eb 42                	jmp    801744 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	8a 00                	mov    (%eax),%al
  801707:	3c 60                	cmp    $0x60,%al
  801709:	7e 19                	jle    801724 <strtol+0xe4>
  80170b:	8b 45 08             	mov    0x8(%ebp),%eax
  80170e:	8a 00                	mov    (%eax),%al
  801710:	3c 7a                	cmp    $0x7a,%al
  801712:	7f 10                	jg     801724 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	8a 00                	mov    (%eax),%al
  801719:	0f be c0             	movsbl %al,%eax
  80171c:	83 e8 57             	sub    $0x57,%eax
  80171f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801722:	eb 20                	jmp    801744 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801724:	8b 45 08             	mov    0x8(%ebp),%eax
  801727:	8a 00                	mov    (%eax),%al
  801729:	3c 40                	cmp    $0x40,%al
  80172b:	7e 39                	jle    801766 <strtol+0x126>
  80172d:	8b 45 08             	mov    0x8(%ebp),%eax
  801730:	8a 00                	mov    (%eax),%al
  801732:	3c 5a                	cmp    $0x5a,%al
  801734:	7f 30                	jg     801766 <strtol+0x126>
			dig = *s - 'A' + 10;
  801736:	8b 45 08             	mov    0x8(%ebp),%eax
  801739:	8a 00                	mov    (%eax),%al
  80173b:	0f be c0             	movsbl %al,%eax
  80173e:	83 e8 37             	sub    $0x37,%eax
  801741:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801744:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801747:	3b 45 10             	cmp    0x10(%ebp),%eax
  80174a:	7d 19                	jge    801765 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80174c:	ff 45 08             	incl   0x8(%ebp)
  80174f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801752:	0f af 45 10          	imul   0x10(%ebp),%eax
  801756:	89 c2                	mov    %eax,%edx
  801758:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80175b:	01 d0                	add    %edx,%eax
  80175d:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801760:	e9 7b ff ff ff       	jmp    8016e0 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801765:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801766:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80176a:	74 08                	je     801774 <strtol+0x134>
		*endptr = (char *) s;
  80176c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80176f:	8b 55 08             	mov    0x8(%ebp),%edx
  801772:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801774:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801778:	74 07                	je     801781 <strtol+0x141>
  80177a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80177d:	f7 d8                	neg    %eax
  80177f:	eb 03                	jmp    801784 <strtol+0x144>
  801781:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801784:	c9                   	leave  
  801785:	c3                   	ret    

00801786 <ltostr>:

void
ltostr(long value, char *str)
{
  801786:	55                   	push   %ebp
  801787:	89 e5                	mov    %esp,%ebp
  801789:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80178c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801793:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80179a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80179e:	79 13                	jns    8017b3 <ltostr+0x2d>
	{
		neg = 1;
  8017a0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8017a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017aa:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8017ad:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8017b0:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8017b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b6:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8017bb:	99                   	cltd   
  8017bc:	f7 f9                	idiv   %ecx
  8017be:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8017c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017c4:	8d 50 01             	lea    0x1(%eax),%edx
  8017c7:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8017ca:	89 c2                	mov    %eax,%edx
  8017cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cf:	01 d0                	add    %edx,%eax
  8017d1:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017d4:	83 c2 30             	add    $0x30,%edx
  8017d7:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017d9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017dc:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017e1:	f7 e9                	imul   %ecx
  8017e3:	c1 fa 02             	sar    $0x2,%edx
  8017e6:	89 c8                	mov    %ecx,%eax
  8017e8:	c1 f8 1f             	sar    $0x1f,%eax
  8017eb:	29 c2                	sub    %eax,%edx
  8017ed:	89 d0                	mov    %edx,%eax
  8017ef:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017f2:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017f5:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017fa:	f7 e9                	imul   %ecx
  8017fc:	c1 fa 02             	sar    $0x2,%edx
  8017ff:	89 c8                	mov    %ecx,%eax
  801801:	c1 f8 1f             	sar    $0x1f,%eax
  801804:	29 c2                	sub    %eax,%edx
  801806:	89 d0                	mov    %edx,%eax
  801808:	c1 e0 02             	shl    $0x2,%eax
  80180b:	01 d0                	add    %edx,%eax
  80180d:	01 c0                	add    %eax,%eax
  80180f:	29 c1                	sub    %eax,%ecx
  801811:	89 ca                	mov    %ecx,%edx
  801813:	85 d2                	test   %edx,%edx
  801815:	75 9c                	jne    8017b3 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801817:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80181e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801821:	48                   	dec    %eax
  801822:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801825:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801829:	74 3d                	je     801868 <ltostr+0xe2>
		start = 1 ;
  80182b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801832:	eb 34                	jmp    801868 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801834:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801837:	8b 45 0c             	mov    0xc(%ebp),%eax
  80183a:	01 d0                	add    %edx,%eax
  80183c:	8a 00                	mov    (%eax),%al
  80183e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801841:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801844:	8b 45 0c             	mov    0xc(%ebp),%eax
  801847:	01 c2                	add    %eax,%edx
  801849:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80184c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80184f:	01 c8                	add    %ecx,%eax
  801851:	8a 00                	mov    (%eax),%al
  801853:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801855:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801858:	8b 45 0c             	mov    0xc(%ebp),%eax
  80185b:	01 c2                	add    %eax,%edx
  80185d:	8a 45 eb             	mov    -0x15(%ebp),%al
  801860:	88 02                	mov    %al,(%edx)
		start++ ;
  801862:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801865:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801868:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80186b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80186e:	7c c4                	jl     801834 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801870:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801873:	8b 45 0c             	mov    0xc(%ebp),%eax
  801876:	01 d0                	add    %edx,%eax
  801878:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80187b:	90                   	nop
  80187c:	c9                   	leave  
  80187d:	c3                   	ret    

0080187e <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80187e:	55                   	push   %ebp
  80187f:	89 e5                	mov    %esp,%ebp
  801881:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801884:	ff 75 08             	pushl  0x8(%ebp)
  801887:	e8 54 fa ff ff       	call   8012e0 <strlen>
  80188c:	83 c4 04             	add    $0x4,%esp
  80188f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801892:	ff 75 0c             	pushl  0xc(%ebp)
  801895:	e8 46 fa ff ff       	call   8012e0 <strlen>
  80189a:	83 c4 04             	add    $0x4,%esp
  80189d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8018a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8018a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8018ae:	eb 17                	jmp    8018c7 <strcconcat+0x49>
		final[s] = str1[s] ;
  8018b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8018b6:	01 c2                	add    %eax,%edx
  8018b8:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8018bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018be:	01 c8                	add    %ecx,%eax
  8018c0:	8a 00                	mov    (%eax),%al
  8018c2:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8018c4:	ff 45 fc             	incl   -0x4(%ebp)
  8018c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018ca:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8018cd:	7c e1                	jl     8018b0 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8018cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018d6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018dd:	eb 1f                	jmp    8018fe <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018df:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018e2:	8d 50 01             	lea    0x1(%eax),%edx
  8018e5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018e8:	89 c2                	mov    %eax,%edx
  8018ea:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ed:	01 c2                	add    %eax,%edx
  8018ef:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f5:	01 c8                	add    %ecx,%eax
  8018f7:	8a 00                	mov    (%eax),%al
  8018f9:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018fb:	ff 45 f8             	incl   -0x8(%ebp)
  8018fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801901:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801904:	7c d9                	jl     8018df <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801906:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801909:	8b 45 10             	mov    0x10(%ebp),%eax
  80190c:	01 d0                	add    %edx,%eax
  80190e:	c6 00 00             	movb   $0x0,(%eax)
}
  801911:	90                   	nop
  801912:	c9                   	leave  
  801913:	c3                   	ret    

00801914 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801914:	55                   	push   %ebp
  801915:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801917:	8b 45 14             	mov    0x14(%ebp),%eax
  80191a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801920:	8b 45 14             	mov    0x14(%ebp),%eax
  801923:	8b 00                	mov    (%eax),%eax
  801925:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80192c:	8b 45 10             	mov    0x10(%ebp),%eax
  80192f:	01 d0                	add    %edx,%eax
  801931:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801937:	eb 0c                	jmp    801945 <strsplit+0x31>
			*string++ = 0;
  801939:	8b 45 08             	mov    0x8(%ebp),%eax
  80193c:	8d 50 01             	lea    0x1(%eax),%edx
  80193f:	89 55 08             	mov    %edx,0x8(%ebp)
  801942:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801945:	8b 45 08             	mov    0x8(%ebp),%eax
  801948:	8a 00                	mov    (%eax),%al
  80194a:	84 c0                	test   %al,%al
  80194c:	74 18                	je     801966 <strsplit+0x52>
  80194e:	8b 45 08             	mov    0x8(%ebp),%eax
  801951:	8a 00                	mov    (%eax),%al
  801953:	0f be c0             	movsbl %al,%eax
  801956:	50                   	push   %eax
  801957:	ff 75 0c             	pushl  0xc(%ebp)
  80195a:	e8 13 fb ff ff       	call   801472 <strchr>
  80195f:	83 c4 08             	add    $0x8,%esp
  801962:	85 c0                	test   %eax,%eax
  801964:	75 d3                	jne    801939 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	8a 00                	mov    (%eax),%al
  80196b:	84 c0                	test   %al,%al
  80196d:	74 5a                	je     8019c9 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80196f:	8b 45 14             	mov    0x14(%ebp),%eax
  801972:	8b 00                	mov    (%eax),%eax
  801974:	83 f8 0f             	cmp    $0xf,%eax
  801977:	75 07                	jne    801980 <strsplit+0x6c>
		{
			return 0;
  801979:	b8 00 00 00 00       	mov    $0x0,%eax
  80197e:	eb 66                	jmp    8019e6 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801980:	8b 45 14             	mov    0x14(%ebp),%eax
  801983:	8b 00                	mov    (%eax),%eax
  801985:	8d 48 01             	lea    0x1(%eax),%ecx
  801988:	8b 55 14             	mov    0x14(%ebp),%edx
  80198b:	89 0a                	mov    %ecx,(%edx)
  80198d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801994:	8b 45 10             	mov    0x10(%ebp),%eax
  801997:	01 c2                	add    %eax,%edx
  801999:	8b 45 08             	mov    0x8(%ebp),%eax
  80199c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80199e:	eb 03                	jmp    8019a3 <strsplit+0x8f>
			string++;
  8019a0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8019a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8019a6:	8a 00                	mov    (%eax),%al
  8019a8:	84 c0                	test   %al,%al
  8019aa:	74 8b                	je     801937 <strsplit+0x23>
  8019ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8019af:	8a 00                	mov    (%eax),%al
  8019b1:	0f be c0             	movsbl %al,%eax
  8019b4:	50                   	push   %eax
  8019b5:	ff 75 0c             	pushl  0xc(%ebp)
  8019b8:	e8 b5 fa ff ff       	call   801472 <strchr>
  8019bd:	83 c4 08             	add    $0x8,%esp
  8019c0:	85 c0                	test   %eax,%eax
  8019c2:	74 dc                	je     8019a0 <strsplit+0x8c>
			string++;
	}
  8019c4:	e9 6e ff ff ff       	jmp    801937 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8019c9:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8019ca:	8b 45 14             	mov    0x14(%ebp),%eax
  8019cd:	8b 00                	mov    (%eax),%eax
  8019cf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d9:	01 d0                	add    %edx,%eax
  8019db:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019e1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
  8019eb:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8019ee:	83 ec 04             	sub    $0x4,%esp
  8019f1:	68 c4 2a 80 00       	push   $0x802ac4
  8019f6:	6a 15                	push   $0x15
  8019f8:	68 e9 2a 80 00       	push   $0x802ae9
  8019fd:	e8 a2 ed ff ff       	call   8007a4 <_panic>

00801a02 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
  801a05:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801a08:	83 ec 04             	sub    $0x4,%esp
  801a0b:	68 f8 2a 80 00       	push   $0x802af8
  801a10:	6a 2e                	push   $0x2e
  801a12:	68 e9 2a 80 00       	push   $0x802ae9
  801a17:	e8 88 ed ff ff       	call   8007a4 <_panic>

00801a1c <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801a1c:	55                   	push   %ebp
  801a1d:	89 e5                	mov    %esp,%ebp
  801a1f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a22:	83 ec 04             	sub    $0x4,%esp
  801a25:	68 1c 2b 80 00       	push   $0x802b1c
  801a2a:	6a 4c                	push   $0x4c
  801a2c:	68 e9 2a 80 00       	push   $0x802ae9
  801a31:	e8 6e ed ff ff       	call   8007a4 <_panic>

00801a36 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801a36:	55                   	push   %ebp
  801a37:	89 e5                	mov    %esp,%ebp
  801a39:	83 ec 18             	sub    $0x18,%esp
  801a3c:	8b 45 10             	mov    0x10(%ebp),%eax
  801a3f:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801a42:	83 ec 04             	sub    $0x4,%esp
  801a45:	68 1c 2b 80 00       	push   $0x802b1c
  801a4a:	6a 57                	push   $0x57
  801a4c:	68 e9 2a 80 00       	push   $0x802ae9
  801a51:	e8 4e ed ff ff       	call   8007a4 <_panic>

00801a56 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a56:	55                   	push   %ebp
  801a57:	89 e5                	mov    %esp,%ebp
  801a59:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a5c:	83 ec 04             	sub    $0x4,%esp
  801a5f:	68 1c 2b 80 00       	push   $0x802b1c
  801a64:	6a 5d                	push   $0x5d
  801a66:	68 e9 2a 80 00       	push   $0x802ae9
  801a6b:	e8 34 ed ff ff       	call   8007a4 <_panic>

00801a70 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801a70:	55                   	push   %ebp
  801a71:	89 e5                	mov    %esp,%ebp
  801a73:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a76:	83 ec 04             	sub    $0x4,%esp
  801a79:	68 1c 2b 80 00       	push   $0x802b1c
  801a7e:	6a 63                	push   $0x63
  801a80:	68 e9 2a 80 00       	push   $0x802ae9
  801a85:	e8 1a ed ff ff       	call   8007a4 <_panic>

00801a8a <expand>:
}

void expand(uint32 newSize)
{
  801a8a:	55                   	push   %ebp
  801a8b:	89 e5                	mov    %esp,%ebp
  801a8d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a90:	83 ec 04             	sub    $0x4,%esp
  801a93:	68 1c 2b 80 00       	push   $0x802b1c
  801a98:	6a 68                	push   $0x68
  801a9a:	68 e9 2a 80 00       	push   $0x802ae9
  801a9f:	e8 00 ed ff ff       	call   8007a4 <_panic>

00801aa4 <shrink>:
}
void shrink(uint32 newSize)
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
  801aa7:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801aaa:	83 ec 04             	sub    $0x4,%esp
  801aad:	68 1c 2b 80 00       	push   $0x802b1c
  801ab2:	6a 6c                	push   $0x6c
  801ab4:	68 e9 2a 80 00       	push   $0x802ae9
  801ab9:	e8 e6 ec ff ff       	call   8007a4 <_panic>

00801abe <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801abe:	55                   	push   %ebp
  801abf:	89 e5                	mov    %esp,%ebp
  801ac1:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801ac4:	83 ec 04             	sub    $0x4,%esp
  801ac7:	68 1c 2b 80 00       	push   $0x802b1c
  801acc:	6a 71                	push   $0x71
  801ace:	68 e9 2a 80 00       	push   $0x802ae9
  801ad3:	e8 cc ec ff ff       	call   8007a4 <_panic>

00801ad8 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ad8:	55                   	push   %ebp
  801ad9:	89 e5                	mov    %esp,%ebp
  801adb:	57                   	push   %edi
  801adc:	56                   	push   %esi
  801add:	53                   	push   %ebx
  801ade:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801ae1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ae7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aea:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aed:	8b 7d 18             	mov    0x18(%ebp),%edi
  801af0:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801af3:	cd 30                	int    $0x30
  801af5:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801af8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801afb:	83 c4 10             	add    $0x10,%esp
  801afe:	5b                   	pop    %ebx
  801aff:	5e                   	pop    %esi
  801b00:	5f                   	pop    %edi
  801b01:	5d                   	pop    %ebp
  801b02:	c3                   	ret    

00801b03 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b03:	55                   	push   %ebp
  801b04:	89 e5                	mov    %esp,%ebp
  801b06:	83 ec 04             	sub    $0x4,%esp
  801b09:	8b 45 10             	mov    0x10(%ebp),%eax
  801b0c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b0f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801b13:	8b 45 08             	mov    0x8(%ebp),%eax
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	52                   	push   %edx
  801b1b:	ff 75 0c             	pushl  0xc(%ebp)
  801b1e:	50                   	push   %eax
  801b1f:	6a 00                	push   $0x0
  801b21:	e8 b2 ff ff ff       	call   801ad8 <syscall>
  801b26:	83 c4 18             	add    $0x18,%esp
}
  801b29:	90                   	nop
  801b2a:	c9                   	leave  
  801b2b:	c3                   	ret    

00801b2c <sys_cgetc>:

int
sys_cgetc(void)
{
  801b2c:	55                   	push   %ebp
  801b2d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801b2f:	6a 00                	push   $0x0
  801b31:	6a 00                	push   $0x0
  801b33:	6a 00                	push   $0x0
  801b35:	6a 00                	push   $0x0
  801b37:	6a 00                	push   $0x0
  801b39:	6a 01                	push   $0x1
  801b3b:	e8 98 ff ff ff       	call   801ad8 <syscall>
  801b40:	83 c4 18             	add    $0x18,%esp
}
  801b43:	c9                   	leave  
  801b44:	c3                   	ret    

00801b45 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b45:	55                   	push   %ebp
  801b46:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b48:	8b 45 08             	mov    0x8(%ebp),%eax
  801b4b:	6a 00                	push   $0x0
  801b4d:	6a 00                	push   $0x0
  801b4f:	6a 00                	push   $0x0
  801b51:	6a 00                	push   $0x0
  801b53:	50                   	push   %eax
  801b54:	6a 05                	push   $0x5
  801b56:	e8 7d ff ff ff       	call   801ad8 <syscall>
  801b5b:	83 c4 18             	add    $0x18,%esp
}
  801b5e:	c9                   	leave  
  801b5f:	c3                   	ret    

00801b60 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b60:	55                   	push   %ebp
  801b61:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b63:	6a 00                	push   $0x0
  801b65:	6a 00                	push   $0x0
  801b67:	6a 00                	push   $0x0
  801b69:	6a 00                	push   $0x0
  801b6b:	6a 00                	push   $0x0
  801b6d:	6a 02                	push   $0x2
  801b6f:	e8 64 ff ff ff       	call   801ad8 <syscall>
  801b74:	83 c4 18             	add    $0x18,%esp
}
  801b77:	c9                   	leave  
  801b78:	c3                   	ret    

00801b79 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b79:	55                   	push   %ebp
  801b7a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b7c:	6a 00                	push   $0x0
  801b7e:	6a 00                	push   $0x0
  801b80:	6a 00                	push   $0x0
  801b82:	6a 00                	push   $0x0
  801b84:	6a 00                	push   $0x0
  801b86:	6a 03                	push   $0x3
  801b88:	e8 4b ff ff ff       	call   801ad8 <syscall>
  801b8d:	83 c4 18             	add    $0x18,%esp
}
  801b90:	c9                   	leave  
  801b91:	c3                   	ret    

00801b92 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b92:	55                   	push   %ebp
  801b93:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b95:	6a 00                	push   $0x0
  801b97:	6a 00                	push   $0x0
  801b99:	6a 00                	push   $0x0
  801b9b:	6a 00                	push   $0x0
  801b9d:	6a 00                	push   $0x0
  801b9f:	6a 04                	push   $0x4
  801ba1:	e8 32 ff ff ff       	call   801ad8 <syscall>
  801ba6:	83 c4 18             	add    $0x18,%esp
}
  801ba9:	c9                   	leave  
  801baa:	c3                   	ret    

00801bab <sys_env_exit>:


void sys_env_exit(void)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801bae:	6a 00                	push   $0x0
  801bb0:	6a 00                	push   $0x0
  801bb2:	6a 00                	push   $0x0
  801bb4:	6a 00                	push   $0x0
  801bb6:	6a 00                	push   $0x0
  801bb8:	6a 06                	push   $0x6
  801bba:	e8 19 ff ff ff       	call   801ad8 <syscall>
  801bbf:	83 c4 18             	add    $0x18,%esp
}
  801bc2:	90                   	nop
  801bc3:	c9                   	leave  
  801bc4:	c3                   	ret    

00801bc5 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801bc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801bce:	6a 00                	push   $0x0
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	52                   	push   %edx
  801bd5:	50                   	push   %eax
  801bd6:	6a 07                	push   $0x7
  801bd8:	e8 fb fe ff ff       	call   801ad8 <syscall>
  801bdd:	83 c4 18             	add    $0x18,%esp
}
  801be0:	c9                   	leave  
  801be1:	c3                   	ret    

00801be2 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801be2:	55                   	push   %ebp
  801be3:	89 e5                	mov    %esp,%ebp
  801be5:	56                   	push   %esi
  801be6:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801be7:	8b 75 18             	mov    0x18(%ebp),%esi
  801bea:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801bed:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bf0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bf3:	8b 45 08             	mov    0x8(%ebp),%eax
  801bf6:	56                   	push   %esi
  801bf7:	53                   	push   %ebx
  801bf8:	51                   	push   %ecx
  801bf9:	52                   	push   %edx
  801bfa:	50                   	push   %eax
  801bfb:	6a 08                	push   $0x8
  801bfd:	e8 d6 fe ff ff       	call   801ad8 <syscall>
  801c02:	83 c4 18             	add    $0x18,%esp
}
  801c05:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c08:	5b                   	pop    %ebx
  801c09:	5e                   	pop    %esi
  801c0a:	5d                   	pop    %ebp
  801c0b:	c3                   	ret    

00801c0c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c0c:	55                   	push   %ebp
  801c0d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c12:	8b 45 08             	mov    0x8(%ebp),%eax
  801c15:	6a 00                	push   $0x0
  801c17:	6a 00                	push   $0x0
  801c19:	6a 00                	push   $0x0
  801c1b:	52                   	push   %edx
  801c1c:	50                   	push   %eax
  801c1d:	6a 09                	push   $0x9
  801c1f:	e8 b4 fe ff ff       	call   801ad8 <syscall>
  801c24:	83 c4 18             	add    $0x18,%esp
}
  801c27:	c9                   	leave  
  801c28:	c3                   	ret    

00801c29 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	ff 75 0c             	pushl  0xc(%ebp)
  801c35:	ff 75 08             	pushl  0x8(%ebp)
  801c38:	6a 0a                	push   $0xa
  801c3a:	e8 99 fe ff ff       	call   801ad8 <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
}
  801c42:	c9                   	leave  
  801c43:	c3                   	ret    

00801c44 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c44:	55                   	push   %ebp
  801c45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	6a 00                	push   $0x0
  801c4f:	6a 00                	push   $0x0
  801c51:	6a 0b                	push   $0xb
  801c53:	e8 80 fe ff ff       	call   801ad8 <syscall>
  801c58:	83 c4 18             	add    $0x18,%esp
}
  801c5b:	c9                   	leave  
  801c5c:	c3                   	ret    

00801c5d <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c5d:	55                   	push   %ebp
  801c5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 0c                	push   $0xc
  801c6c:	e8 67 fe ff ff       	call   801ad8 <syscall>
  801c71:	83 c4 18             	add    $0x18,%esp
}
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 0d                	push   $0xd
  801c85:	e8 4e fe ff ff       	call   801ad8 <syscall>
  801c8a:	83 c4 18             	add    $0x18,%esp
}
  801c8d:	c9                   	leave  
  801c8e:	c3                   	ret    

00801c8f <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c8f:	55                   	push   %ebp
  801c90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c92:	6a 00                	push   $0x0
  801c94:	6a 00                	push   $0x0
  801c96:	6a 00                	push   $0x0
  801c98:	ff 75 0c             	pushl  0xc(%ebp)
  801c9b:	ff 75 08             	pushl  0x8(%ebp)
  801c9e:	6a 11                	push   $0x11
  801ca0:	e8 33 fe ff ff       	call   801ad8 <syscall>
  801ca5:	83 c4 18             	add    $0x18,%esp
	return;
  801ca8:	90                   	nop
}
  801ca9:	c9                   	leave  
  801caa:	c3                   	ret    

00801cab <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801cae:	6a 00                	push   $0x0
  801cb0:	6a 00                	push   $0x0
  801cb2:	6a 00                	push   $0x0
  801cb4:	ff 75 0c             	pushl  0xc(%ebp)
  801cb7:	ff 75 08             	pushl  0x8(%ebp)
  801cba:	6a 12                	push   $0x12
  801cbc:	e8 17 fe ff ff       	call   801ad8 <syscall>
  801cc1:	83 c4 18             	add    $0x18,%esp
	return ;
  801cc4:	90                   	nop
}
  801cc5:	c9                   	leave  
  801cc6:	c3                   	ret    

00801cc7 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801cc7:	55                   	push   %ebp
  801cc8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	6a 00                	push   $0x0
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 0e                	push   $0xe
  801cd6:	e8 fd fd ff ff       	call   801ad8 <syscall>
  801cdb:	83 c4 18             	add    $0x18,%esp
}
  801cde:	c9                   	leave  
  801cdf:	c3                   	ret    

00801ce0 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801ce0:	55                   	push   %ebp
  801ce1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	ff 75 08             	pushl  0x8(%ebp)
  801cee:	6a 0f                	push   $0xf
  801cf0:	e8 e3 fd ff ff       	call   801ad8 <syscall>
  801cf5:	83 c4 18             	add    $0x18,%esp
}
  801cf8:	c9                   	leave  
  801cf9:	c3                   	ret    

00801cfa <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cfa:	55                   	push   %ebp
  801cfb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 10                	push   $0x10
  801d09:	e8 ca fd ff ff       	call   801ad8 <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	90                   	nop
  801d12:	c9                   	leave  
  801d13:	c3                   	ret    

00801d14 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801d14:	55                   	push   %ebp
  801d15:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 14                	push   $0x14
  801d23:	e8 b0 fd ff ff       	call   801ad8 <syscall>
  801d28:	83 c4 18             	add    $0x18,%esp
}
  801d2b:	90                   	nop
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 15                	push   $0x15
  801d3d:	e8 96 fd ff ff       	call   801ad8 <syscall>
  801d42:	83 c4 18             	add    $0x18,%esp
}
  801d45:	90                   	nop
  801d46:	c9                   	leave  
  801d47:	c3                   	ret    

00801d48 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d48:	55                   	push   %ebp
  801d49:	89 e5                	mov    %esp,%ebp
  801d4b:	83 ec 04             	sub    $0x4,%esp
  801d4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d51:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d54:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	50                   	push   %eax
  801d61:	6a 16                	push   $0x16
  801d63:	e8 70 fd ff ff       	call   801ad8 <syscall>
  801d68:	83 c4 18             	add    $0x18,%esp
}
  801d6b:	90                   	nop
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	6a 00                	push   $0x0
  801d7b:	6a 17                	push   $0x17
  801d7d:	e8 56 fd ff ff       	call   801ad8 <syscall>
  801d82:	83 c4 18             	add    $0x18,%esp
}
  801d85:	90                   	nop
  801d86:	c9                   	leave  
  801d87:	c3                   	ret    

00801d88 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d88:	55                   	push   %ebp
  801d89:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d8e:	6a 00                	push   $0x0
  801d90:	6a 00                	push   $0x0
  801d92:	6a 00                	push   $0x0
  801d94:	ff 75 0c             	pushl  0xc(%ebp)
  801d97:	50                   	push   %eax
  801d98:	6a 18                	push   $0x18
  801d9a:	e8 39 fd ff ff       	call   801ad8 <syscall>
  801d9f:	83 c4 18             	add    $0x18,%esp
}
  801da2:	c9                   	leave  
  801da3:	c3                   	ret    

00801da4 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801da4:	55                   	push   %ebp
  801da5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801da7:	8b 55 0c             	mov    0xc(%ebp),%edx
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	52                   	push   %edx
  801db4:	50                   	push   %eax
  801db5:	6a 1b                	push   $0x1b
  801db7:	e8 1c fd ff ff       	call   801ad8 <syscall>
  801dbc:	83 c4 18             	add    $0x18,%esp
}
  801dbf:	c9                   	leave  
  801dc0:	c3                   	ret    

00801dc1 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801dc1:	55                   	push   %ebp
  801dc2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801dc4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc7:	8b 45 08             	mov    0x8(%ebp),%eax
  801dca:	6a 00                	push   $0x0
  801dcc:	6a 00                	push   $0x0
  801dce:	6a 00                	push   $0x0
  801dd0:	52                   	push   %edx
  801dd1:	50                   	push   %eax
  801dd2:	6a 19                	push   $0x19
  801dd4:	e8 ff fc ff ff       	call   801ad8 <syscall>
  801dd9:	83 c4 18             	add    $0x18,%esp
}
  801ddc:	90                   	nop
  801ddd:	c9                   	leave  
  801dde:	c3                   	ret    

00801ddf <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ddf:	55                   	push   %ebp
  801de0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801de2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de5:	8b 45 08             	mov    0x8(%ebp),%eax
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	52                   	push   %edx
  801def:	50                   	push   %eax
  801df0:	6a 1a                	push   $0x1a
  801df2:	e8 e1 fc ff ff       	call   801ad8 <syscall>
  801df7:	83 c4 18             	add    $0x18,%esp
}
  801dfa:	90                   	nop
  801dfb:	c9                   	leave  
  801dfc:	c3                   	ret    

00801dfd <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801dfd:	55                   	push   %ebp
  801dfe:	89 e5                	mov    %esp,%ebp
  801e00:	83 ec 04             	sub    $0x4,%esp
  801e03:	8b 45 10             	mov    0x10(%ebp),%eax
  801e06:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e09:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e0c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e10:	8b 45 08             	mov    0x8(%ebp),%eax
  801e13:	6a 00                	push   $0x0
  801e15:	51                   	push   %ecx
  801e16:	52                   	push   %edx
  801e17:	ff 75 0c             	pushl  0xc(%ebp)
  801e1a:	50                   	push   %eax
  801e1b:	6a 1c                	push   $0x1c
  801e1d:	e8 b6 fc ff ff       	call   801ad8 <syscall>
  801e22:	83 c4 18             	add    $0x18,%esp
}
  801e25:	c9                   	leave  
  801e26:	c3                   	ret    

00801e27 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801e27:	55                   	push   %ebp
  801e28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801e2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	52                   	push   %edx
  801e37:	50                   	push   %eax
  801e38:	6a 1d                	push   $0x1d
  801e3a:	e8 99 fc ff ff       	call   801ad8 <syscall>
  801e3f:	83 c4 18             	add    $0x18,%esp
}
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e47:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e4a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e50:	6a 00                	push   $0x0
  801e52:	6a 00                	push   $0x0
  801e54:	51                   	push   %ecx
  801e55:	52                   	push   %edx
  801e56:	50                   	push   %eax
  801e57:	6a 1e                	push   $0x1e
  801e59:	e8 7a fc ff ff       	call   801ad8 <syscall>
  801e5e:	83 c4 18             	add    $0x18,%esp
}
  801e61:	c9                   	leave  
  801e62:	c3                   	ret    

00801e63 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e63:	55                   	push   %ebp
  801e64:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e66:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e69:	8b 45 08             	mov    0x8(%ebp),%eax
  801e6c:	6a 00                	push   $0x0
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	52                   	push   %edx
  801e73:	50                   	push   %eax
  801e74:	6a 1f                	push   $0x1f
  801e76:	e8 5d fc ff ff       	call   801ad8 <syscall>
  801e7b:	83 c4 18             	add    $0x18,%esp
}
  801e7e:	c9                   	leave  
  801e7f:	c3                   	ret    

00801e80 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e80:	55                   	push   %ebp
  801e81:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e83:	6a 00                	push   $0x0
  801e85:	6a 00                	push   $0x0
  801e87:	6a 00                	push   $0x0
  801e89:	6a 00                	push   $0x0
  801e8b:	6a 00                	push   $0x0
  801e8d:	6a 20                	push   $0x20
  801e8f:	e8 44 fc ff ff       	call   801ad8 <syscall>
  801e94:	83 c4 18             	add    $0x18,%esp
}
  801e97:	c9                   	leave  
  801e98:	c3                   	ret    

00801e99 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e99:	55                   	push   %ebp
  801e9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e9f:	6a 00                	push   $0x0
  801ea1:	ff 75 14             	pushl  0x14(%ebp)
  801ea4:	ff 75 10             	pushl  0x10(%ebp)
  801ea7:	ff 75 0c             	pushl  0xc(%ebp)
  801eaa:	50                   	push   %eax
  801eab:	6a 21                	push   $0x21
  801ead:	e8 26 fc ff ff       	call   801ad8 <syscall>
  801eb2:	83 c4 18             	add    $0x18,%esp
}
  801eb5:	c9                   	leave  
  801eb6:	c3                   	ret    

00801eb7 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801eb7:	55                   	push   %ebp
  801eb8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801eba:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 00                	push   $0x0
  801ec1:	6a 00                	push   $0x0
  801ec3:	6a 00                	push   $0x0
  801ec5:	50                   	push   %eax
  801ec6:	6a 22                	push   $0x22
  801ec8:	e8 0b fc ff ff       	call   801ad8 <syscall>
  801ecd:	83 c4 18             	add    $0x18,%esp
}
  801ed0:	90                   	nop
  801ed1:	c9                   	leave  
  801ed2:	c3                   	ret    

00801ed3 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ed3:	55                   	push   %ebp
  801ed4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ed6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed9:	6a 00                	push   $0x0
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	50                   	push   %eax
  801ee2:	6a 23                	push   $0x23
  801ee4:	e8 ef fb ff ff       	call   801ad8 <syscall>
  801ee9:	83 c4 18             	add    $0x18,%esp
}
  801eec:	90                   	nop
  801eed:	c9                   	leave  
  801eee:	c3                   	ret    

00801eef <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801eef:	55                   	push   %ebp
  801ef0:	89 e5                	mov    %esp,%ebp
  801ef2:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801ef5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801ef8:	8d 50 04             	lea    0x4(%eax),%edx
  801efb:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801efe:	6a 00                	push   $0x0
  801f00:	6a 00                	push   $0x0
  801f02:	6a 00                	push   $0x0
  801f04:	52                   	push   %edx
  801f05:	50                   	push   %eax
  801f06:	6a 24                	push   $0x24
  801f08:	e8 cb fb ff ff       	call   801ad8 <syscall>
  801f0d:	83 c4 18             	add    $0x18,%esp
	return result;
  801f10:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801f13:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801f16:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801f19:	89 01                	mov    %eax,(%ecx)
  801f1b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801f1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f21:	c9                   	leave  
  801f22:	c2 04 00             	ret    $0x4

00801f25 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801f25:	55                   	push   %ebp
  801f26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	ff 75 10             	pushl  0x10(%ebp)
  801f2f:	ff 75 0c             	pushl  0xc(%ebp)
  801f32:	ff 75 08             	pushl  0x8(%ebp)
  801f35:	6a 13                	push   $0x13
  801f37:	e8 9c fb ff ff       	call   801ad8 <syscall>
  801f3c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f3f:	90                   	nop
}
  801f40:	c9                   	leave  
  801f41:	c3                   	ret    

00801f42 <sys_rcr2>:
uint32 sys_rcr2()
{
  801f42:	55                   	push   %ebp
  801f43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 25                	push   $0x25
  801f51:	e8 82 fb ff ff       	call   801ad8 <syscall>
  801f56:	83 c4 18             	add    $0x18,%esp
}
  801f59:	c9                   	leave  
  801f5a:	c3                   	ret    

00801f5b <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f5b:	55                   	push   %ebp
  801f5c:	89 e5                	mov    %esp,%ebp
  801f5e:	83 ec 04             	sub    $0x4,%esp
  801f61:	8b 45 08             	mov    0x8(%ebp),%eax
  801f64:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f67:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 00                	push   $0x0
  801f73:	50                   	push   %eax
  801f74:	6a 26                	push   $0x26
  801f76:	e8 5d fb ff ff       	call   801ad8 <syscall>
  801f7b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f7e:	90                   	nop
}
  801f7f:	c9                   	leave  
  801f80:	c3                   	ret    

00801f81 <rsttst>:
void rsttst()
{
  801f81:	55                   	push   %ebp
  801f82:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f84:	6a 00                	push   $0x0
  801f86:	6a 00                	push   $0x0
  801f88:	6a 00                	push   $0x0
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 28                	push   $0x28
  801f90:	e8 43 fb ff ff       	call   801ad8 <syscall>
  801f95:	83 c4 18             	add    $0x18,%esp
	return ;
  801f98:	90                   	nop
}
  801f99:	c9                   	leave  
  801f9a:	c3                   	ret    

00801f9b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f9b:	55                   	push   %ebp
  801f9c:	89 e5                	mov    %esp,%ebp
  801f9e:	83 ec 04             	sub    $0x4,%esp
  801fa1:	8b 45 14             	mov    0x14(%ebp),%eax
  801fa4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801fa7:	8b 55 18             	mov    0x18(%ebp),%edx
  801faa:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fae:	52                   	push   %edx
  801faf:	50                   	push   %eax
  801fb0:	ff 75 10             	pushl  0x10(%ebp)
  801fb3:	ff 75 0c             	pushl  0xc(%ebp)
  801fb6:	ff 75 08             	pushl  0x8(%ebp)
  801fb9:	6a 27                	push   $0x27
  801fbb:	e8 18 fb ff ff       	call   801ad8 <syscall>
  801fc0:	83 c4 18             	add    $0x18,%esp
	return ;
  801fc3:	90                   	nop
}
  801fc4:	c9                   	leave  
  801fc5:	c3                   	ret    

00801fc6 <chktst>:
void chktst(uint32 n)
{
  801fc6:	55                   	push   %ebp
  801fc7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801fc9:	6a 00                	push   $0x0
  801fcb:	6a 00                	push   $0x0
  801fcd:	6a 00                	push   $0x0
  801fcf:	6a 00                	push   $0x0
  801fd1:	ff 75 08             	pushl  0x8(%ebp)
  801fd4:	6a 29                	push   $0x29
  801fd6:	e8 fd fa ff ff       	call   801ad8 <syscall>
  801fdb:	83 c4 18             	add    $0x18,%esp
	return ;
  801fde:	90                   	nop
}
  801fdf:	c9                   	leave  
  801fe0:	c3                   	ret    

00801fe1 <inctst>:

void inctst()
{
  801fe1:	55                   	push   %ebp
  801fe2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 00                	push   $0x0
  801fea:	6a 00                	push   $0x0
  801fec:	6a 00                	push   $0x0
  801fee:	6a 2a                	push   $0x2a
  801ff0:	e8 e3 fa ff ff       	call   801ad8 <syscall>
  801ff5:	83 c4 18             	add    $0x18,%esp
	return ;
  801ff8:	90                   	nop
}
  801ff9:	c9                   	leave  
  801ffa:	c3                   	ret    

00801ffb <gettst>:
uint32 gettst()
{
  801ffb:	55                   	push   %ebp
  801ffc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	6a 00                	push   $0x0
  802006:	6a 00                	push   $0x0
  802008:	6a 2b                	push   $0x2b
  80200a:	e8 c9 fa ff ff       	call   801ad8 <syscall>
  80200f:	83 c4 18             	add    $0x18,%esp
}
  802012:	c9                   	leave  
  802013:	c3                   	ret    

00802014 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802014:	55                   	push   %ebp
  802015:	89 e5                	mov    %esp,%ebp
  802017:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	6a 00                	push   $0x0
  802024:	6a 2c                	push   $0x2c
  802026:	e8 ad fa ff ff       	call   801ad8 <syscall>
  80202b:	83 c4 18             	add    $0x18,%esp
  80202e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802031:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802035:	75 07                	jne    80203e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802037:	b8 01 00 00 00       	mov    $0x1,%eax
  80203c:	eb 05                	jmp    802043 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80203e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802043:	c9                   	leave  
  802044:	c3                   	ret    

00802045 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802045:	55                   	push   %ebp
  802046:	89 e5                	mov    %esp,%ebp
  802048:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 2c                	push   $0x2c
  802057:	e8 7c fa ff ff       	call   801ad8 <syscall>
  80205c:	83 c4 18             	add    $0x18,%esp
  80205f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802062:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802066:	75 07                	jne    80206f <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802068:	b8 01 00 00 00       	mov    $0x1,%eax
  80206d:	eb 05                	jmp    802074 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80206f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802074:	c9                   	leave  
  802075:	c3                   	ret    

00802076 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802076:	55                   	push   %ebp
  802077:	89 e5                	mov    %esp,%ebp
  802079:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80207c:	6a 00                	push   $0x0
  80207e:	6a 00                	push   $0x0
  802080:	6a 00                	push   $0x0
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 2c                	push   $0x2c
  802088:	e8 4b fa ff ff       	call   801ad8 <syscall>
  80208d:	83 c4 18             	add    $0x18,%esp
  802090:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802093:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802097:	75 07                	jne    8020a0 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802099:	b8 01 00 00 00       	mov    $0x1,%eax
  80209e:	eb 05                	jmp    8020a5 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8020a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020a5:	c9                   	leave  
  8020a6:	c3                   	ret    

008020a7 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8020a7:	55                   	push   %ebp
  8020a8:	89 e5                	mov    %esp,%ebp
  8020aa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 00                	push   $0x0
  8020b1:	6a 00                	push   $0x0
  8020b3:	6a 00                	push   $0x0
  8020b5:	6a 00                	push   $0x0
  8020b7:	6a 2c                	push   $0x2c
  8020b9:	e8 1a fa ff ff       	call   801ad8 <syscall>
  8020be:	83 c4 18             	add    $0x18,%esp
  8020c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8020c4:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8020c8:	75 07                	jne    8020d1 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8020ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8020cf:	eb 05                	jmp    8020d6 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8020d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020d6:	c9                   	leave  
  8020d7:	c3                   	ret    

008020d8 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8020d8:	55                   	push   %ebp
  8020d9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	ff 75 08             	pushl  0x8(%ebp)
  8020e6:	6a 2d                	push   $0x2d
  8020e8:	e8 eb f9 ff ff       	call   801ad8 <syscall>
  8020ed:	83 c4 18             	add    $0x18,%esp
	return ;
  8020f0:	90                   	nop
}
  8020f1:	c9                   	leave  
  8020f2:	c3                   	ret    

008020f3 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020f3:	55                   	push   %ebp
  8020f4:	89 e5                	mov    %esp,%ebp
  8020f6:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020f7:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020fa:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020fd:	8b 55 0c             	mov    0xc(%ebp),%edx
  802100:	8b 45 08             	mov    0x8(%ebp),%eax
  802103:	6a 00                	push   $0x0
  802105:	53                   	push   %ebx
  802106:	51                   	push   %ecx
  802107:	52                   	push   %edx
  802108:	50                   	push   %eax
  802109:	6a 2e                	push   $0x2e
  80210b:	e8 c8 f9 ff ff       	call   801ad8 <syscall>
  802110:	83 c4 18             	add    $0x18,%esp
}
  802113:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802116:	c9                   	leave  
  802117:	c3                   	ret    

00802118 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802118:	55                   	push   %ebp
  802119:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80211b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80211e:	8b 45 08             	mov    0x8(%ebp),%eax
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	52                   	push   %edx
  802128:	50                   	push   %eax
  802129:	6a 2f                	push   $0x2f
  80212b:	e8 a8 f9 ff ff       	call   801ad8 <syscall>
  802130:	83 c4 18             	add    $0x18,%esp
}
  802133:	c9                   	leave  
  802134:	c3                   	ret    

00802135 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802135:	55                   	push   %ebp
  802136:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802138:	6a 00                	push   $0x0
  80213a:	6a 00                	push   $0x0
  80213c:	6a 00                	push   $0x0
  80213e:	ff 75 0c             	pushl  0xc(%ebp)
  802141:	ff 75 08             	pushl  0x8(%ebp)
  802144:	6a 30                	push   $0x30
  802146:	e8 8d f9 ff ff       	call   801ad8 <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
	return ;
  80214e:	90                   	nop
}
  80214f:	c9                   	leave  
  802150:	c3                   	ret    
  802151:	66 90                	xchg   %ax,%ax
  802153:	90                   	nop

00802154 <__udivdi3>:
  802154:	55                   	push   %ebp
  802155:	57                   	push   %edi
  802156:	56                   	push   %esi
  802157:	53                   	push   %ebx
  802158:	83 ec 1c             	sub    $0x1c,%esp
  80215b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80215f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802163:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802167:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80216b:	89 ca                	mov    %ecx,%edx
  80216d:	89 f8                	mov    %edi,%eax
  80216f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802173:	85 f6                	test   %esi,%esi
  802175:	75 2d                	jne    8021a4 <__udivdi3+0x50>
  802177:	39 cf                	cmp    %ecx,%edi
  802179:	77 65                	ja     8021e0 <__udivdi3+0x8c>
  80217b:	89 fd                	mov    %edi,%ebp
  80217d:	85 ff                	test   %edi,%edi
  80217f:	75 0b                	jne    80218c <__udivdi3+0x38>
  802181:	b8 01 00 00 00       	mov    $0x1,%eax
  802186:	31 d2                	xor    %edx,%edx
  802188:	f7 f7                	div    %edi
  80218a:	89 c5                	mov    %eax,%ebp
  80218c:	31 d2                	xor    %edx,%edx
  80218e:	89 c8                	mov    %ecx,%eax
  802190:	f7 f5                	div    %ebp
  802192:	89 c1                	mov    %eax,%ecx
  802194:	89 d8                	mov    %ebx,%eax
  802196:	f7 f5                	div    %ebp
  802198:	89 cf                	mov    %ecx,%edi
  80219a:	89 fa                	mov    %edi,%edx
  80219c:	83 c4 1c             	add    $0x1c,%esp
  80219f:	5b                   	pop    %ebx
  8021a0:	5e                   	pop    %esi
  8021a1:	5f                   	pop    %edi
  8021a2:	5d                   	pop    %ebp
  8021a3:	c3                   	ret    
  8021a4:	39 ce                	cmp    %ecx,%esi
  8021a6:	77 28                	ja     8021d0 <__udivdi3+0x7c>
  8021a8:	0f bd fe             	bsr    %esi,%edi
  8021ab:	83 f7 1f             	xor    $0x1f,%edi
  8021ae:	75 40                	jne    8021f0 <__udivdi3+0x9c>
  8021b0:	39 ce                	cmp    %ecx,%esi
  8021b2:	72 0a                	jb     8021be <__udivdi3+0x6a>
  8021b4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8021b8:	0f 87 9e 00 00 00    	ja     80225c <__udivdi3+0x108>
  8021be:	b8 01 00 00 00       	mov    $0x1,%eax
  8021c3:	89 fa                	mov    %edi,%edx
  8021c5:	83 c4 1c             	add    $0x1c,%esp
  8021c8:	5b                   	pop    %ebx
  8021c9:	5e                   	pop    %esi
  8021ca:	5f                   	pop    %edi
  8021cb:	5d                   	pop    %ebp
  8021cc:	c3                   	ret    
  8021cd:	8d 76 00             	lea    0x0(%esi),%esi
  8021d0:	31 ff                	xor    %edi,%edi
  8021d2:	31 c0                	xor    %eax,%eax
  8021d4:	89 fa                	mov    %edi,%edx
  8021d6:	83 c4 1c             	add    $0x1c,%esp
  8021d9:	5b                   	pop    %ebx
  8021da:	5e                   	pop    %esi
  8021db:	5f                   	pop    %edi
  8021dc:	5d                   	pop    %ebp
  8021dd:	c3                   	ret    
  8021de:	66 90                	xchg   %ax,%ax
  8021e0:	89 d8                	mov    %ebx,%eax
  8021e2:	f7 f7                	div    %edi
  8021e4:	31 ff                	xor    %edi,%edi
  8021e6:	89 fa                	mov    %edi,%edx
  8021e8:	83 c4 1c             	add    $0x1c,%esp
  8021eb:	5b                   	pop    %ebx
  8021ec:	5e                   	pop    %esi
  8021ed:	5f                   	pop    %edi
  8021ee:	5d                   	pop    %ebp
  8021ef:	c3                   	ret    
  8021f0:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021f5:	89 eb                	mov    %ebp,%ebx
  8021f7:	29 fb                	sub    %edi,%ebx
  8021f9:	89 f9                	mov    %edi,%ecx
  8021fb:	d3 e6                	shl    %cl,%esi
  8021fd:	89 c5                	mov    %eax,%ebp
  8021ff:	88 d9                	mov    %bl,%cl
  802201:	d3 ed                	shr    %cl,%ebp
  802203:	89 e9                	mov    %ebp,%ecx
  802205:	09 f1                	or     %esi,%ecx
  802207:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80220b:	89 f9                	mov    %edi,%ecx
  80220d:	d3 e0                	shl    %cl,%eax
  80220f:	89 c5                	mov    %eax,%ebp
  802211:	89 d6                	mov    %edx,%esi
  802213:	88 d9                	mov    %bl,%cl
  802215:	d3 ee                	shr    %cl,%esi
  802217:	89 f9                	mov    %edi,%ecx
  802219:	d3 e2                	shl    %cl,%edx
  80221b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80221f:	88 d9                	mov    %bl,%cl
  802221:	d3 e8                	shr    %cl,%eax
  802223:	09 c2                	or     %eax,%edx
  802225:	89 d0                	mov    %edx,%eax
  802227:	89 f2                	mov    %esi,%edx
  802229:	f7 74 24 0c          	divl   0xc(%esp)
  80222d:	89 d6                	mov    %edx,%esi
  80222f:	89 c3                	mov    %eax,%ebx
  802231:	f7 e5                	mul    %ebp
  802233:	39 d6                	cmp    %edx,%esi
  802235:	72 19                	jb     802250 <__udivdi3+0xfc>
  802237:	74 0b                	je     802244 <__udivdi3+0xf0>
  802239:	89 d8                	mov    %ebx,%eax
  80223b:	31 ff                	xor    %edi,%edi
  80223d:	e9 58 ff ff ff       	jmp    80219a <__udivdi3+0x46>
  802242:	66 90                	xchg   %ax,%ax
  802244:	8b 54 24 08          	mov    0x8(%esp),%edx
  802248:	89 f9                	mov    %edi,%ecx
  80224a:	d3 e2                	shl    %cl,%edx
  80224c:	39 c2                	cmp    %eax,%edx
  80224e:	73 e9                	jae    802239 <__udivdi3+0xe5>
  802250:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802253:	31 ff                	xor    %edi,%edi
  802255:	e9 40 ff ff ff       	jmp    80219a <__udivdi3+0x46>
  80225a:	66 90                	xchg   %ax,%ax
  80225c:	31 c0                	xor    %eax,%eax
  80225e:	e9 37 ff ff ff       	jmp    80219a <__udivdi3+0x46>
  802263:	90                   	nop

00802264 <__umoddi3>:
  802264:	55                   	push   %ebp
  802265:	57                   	push   %edi
  802266:	56                   	push   %esi
  802267:	53                   	push   %ebx
  802268:	83 ec 1c             	sub    $0x1c,%esp
  80226b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80226f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802273:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802277:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80227b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80227f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  802283:	89 f3                	mov    %esi,%ebx
  802285:	89 fa                	mov    %edi,%edx
  802287:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  80228b:	89 34 24             	mov    %esi,(%esp)
  80228e:	85 c0                	test   %eax,%eax
  802290:	75 1a                	jne    8022ac <__umoddi3+0x48>
  802292:	39 f7                	cmp    %esi,%edi
  802294:	0f 86 a2 00 00 00    	jbe    80233c <__umoddi3+0xd8>
  80229a:	89 c8                	mov    %ecx,%eax
  80229c:	89 f2                	mov    %esi,%edx
  80229e:	f7 f7                	div    %edi
  8022a0:	89 d0                	mov    %edx,%eax
  8022a2:	31 d2                	xor    %edx,%edx
  8022a4:	83 c4 1c             	add    $0x1c,%esp
  8022a7:	5b                   	pop    %ebx
  8022a8:	5e                   	pop    %esi
  8022a9:	5f                   	pop    %edi
  8022aa:	5d                   	pop    %ebp
  8022ab:	c3                   	ret    
  8022ac:	39 f0                	cmp    %esi,%eax
  8022ae:	0f 87 ac 00 00 00    	ja     802360 <__umoddi3+0xfc>
  8022b4:	0f bd e8             	bsr    %eax,%ebp
  8022b7:	83 f5 1f             	xor    $0x1f,%ebp
  8022ba:	0f 84 ac 00 00 00    	je     80236c <__umoddi3+0x108>
  8022c0:	bf 20 00 00 00       	mov    $0x20,%edi
  8022c5:	29 ef                	sub    %ebp,%edi
  8022c7:	89 fe                	mov    %edi,%esi
  8022c9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8022cd:	89 e9                	mov    %ebp,%ecx
  8022cf:	d3 e0                	shl    %cl,%eax
  8022d1:	89 d7                	mov    %edx,%edi
  8022d3:	89 f1                	mov    %esi,%ecx
  8022d5:	d3 ef                	shr    %cl,%edi
  8022d7:	09 c7                	or     %eax,%edi
  8022d9:	89 e9                	mov    %ebp,%ecx
  8022db:	d3 e2                	shl    %cl,%edx
  8022dd:	89 14 24             	mov    %edx,(%esp)
  8022e0:	89 d8                	mov    %ebx,%eax
  8022e2:	d3 e0                	shl    %cl,%eax
  8022e4:	89 c2                	mov    %eax,%edx
  8022e6:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ea:	d3 e0                	shl    %cl,%eax
  8022ec:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022f0:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022f4:	89 f1                	mov    %esi,%ecx
  8022f6:	d3 e8                	shr    %cl,%eax
  8022f8:	09 d0                	or     %edx,%eax
  8022fa:	d3 eb                	shr    %cl,%ebx
  8022fc:	89 da                	mov    %ebx,%edx
  8022fe:	f7 f7                	div    %edi
  802300:	89 d3                	mov    %edx,%ebx
  802302:	f7 24 24             	mull   (%esp)
  802305:	89 c6                	mov    %eax,%esi
  802307:	89 d1                	mov    %edx,%ecx
  802309:	39 d3                	cmp    %edx,%ebx
  80230b:	0f 82 87 00 00 00    	jb     802398 <__umoddi3+0x134>
  802311:	0f 84 91 00 00 00    	je     8023a8 <__umoddi3+0x144>
  802317:	8b 54 24 04          	mov    0x4(%esp),%edx
  80231b:	29 f2                	sub    %esi,%edx
  80231d:	19 cb                	sbb    %ecx,%ebx
  80231f:	89 d8                	mov    %ebx,%eax
  802321:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802325:	d3 e0                	shl    %cl,%eax
  802327:	89 e9                	mov    %ebp,%ecx
  802329:	d3 ea                	shr    %cl,%edx
  80232b:	09 d0                	or     %edx,%eax
  80232d:	89 e9                	mov    %ebp,%ecx
  80232f:	d3 eb                	shr    %cl,%ebx
  802331:	89 da                	mov    %ebx,%edx
  802333:	83 c4 1c             	add    $0x1c,%esp
  802336:	5b                   	pop    %ebx
  802337:	5e                   	pop    %esi
  802338:	5f                   	pop    %edi
  802339:	5d                   	pop    %ebp
  80233a:	c3                   	ret    
  80233b:	90                   	nop
  80233c:	89 fd                	mov    %edi,%ebp
  80233e:	85 ff                	test   %edi,%edi
  802340:	75 0b                	jne    80234d <__umoddi3+0xe9>
  802342:	b8 01 00 00 00       	mov    $0x1,%eax
  802347:	31 d2                	xor    %edx,%edx
  802349:	f7 f7                	div    %edi
  80234b:	89 c5                	mov    %eax,%ebp
  80234d:	89 f0                	mov    %esi,%eax
  80234f:	31 d2                	xor    %edx,%edx
  802351:	f7 f5                	div    %ebp
  802353:	89 c8                	mov    %ecx,%eax
  802355:	f7 f5                	div    %ebp
  802357:	89 d0                	mov    %edx,%eax
  802359:	e9 44 ff ff ff       	jmp    8022a2 <__umoddi3+0x3e>
  80235e:	66 90                	xchg   %ax,%ax
  802360:	89 c8                	mov    %ecx,%eax
  802362:	89 f2                	mov    %esi,%edx
  802364:	83 c4 1c             	add    $0x1c,%esp
  802367:	5b                   	pop    %ebx
  802368:	5e                   	pop    %esi
  802369:	5f                   	pop    %edi
  80236a:	5d                   	pop    %ebp
  80236b:	c3                   	ret    
  80236c:	3b 04 24             	cmp    (%esp),%eax
  80236f:	72 06                	jb     802377 <__umoddi3+0x113>
  802371:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802375:	77 0f                	ja     802386 <__umoddi3+0x122>
  802377:	89 f2                	mov    %esi,%edx
  802379:	29 f9                	sub    %edi,%ecx
  80237b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80237f:	89 14 24             	mov    %edx,(%esp)
  802382:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802386:	8b 44 24 04          	mov    0x4(%esp),%eax
  80238a:	8b 14 24             	mov    (%esp),%edx
  80238d:	83 c4 1c             	add    $0x1c,%esp
  802390:	5b                   	pop    %ebx
  802391:	5e                   	pop    %esi
  802392:	5f                   	pop    %edi
  802393:	5d                   	pop    %ebp
  802394:	c3                   	ret    
  802395:	8d 76 00             	lea    0x0(%esi),%esi
  802398:	2b 04 24             	sub    (%esp),%eax
  80239b:	19 fa                	sbb    %edi,%edx
  80239d:	89 d1                	mov    %edx,%ecx
  80239f:	89 c6                	mov    %eax,%esi
  8023a1:	e9 71 ff ff ff       	jmp    802317 <__umoddi3+0xb3>
  8023a6:	66 90                	xchg   %ax,%ax
  8023a8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8023ac:	72 ea                	jb     802398 <__umoddi3+0x134>
  8023ae:	89 d9                	mov    %ebx,%ecx
  8023b0:	e9 62 ff ff ff       	jmp    802317 <__umoddi3+0xb3>
