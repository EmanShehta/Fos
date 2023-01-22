
obj/user/quicksort_freeheap:     file format elf32-i386


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
  800031:	e8 b4 05 00 00       	call   8005ea <libmain>
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
  80003c:	81 ec 24 01 00 00    	sub    $0x124,%esp
	char Chose ;
	char Line[255] ;
	int Iteration = 0 ;
  800042:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	do
	{
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames();
  800049:	e8 58 1b 00 00       	call   801ba6 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 6a 1b 00 00       	call   801bbf <sys_calculate_modified_frames>
  800055:	01 d8                	add    %ebx,%eax
  800057:	89 45 f0             	mov    %eax,-0x10(%ebp)

		Iteration++ ;
  80005a:	ff 45 f4             	incl   -0xc(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

		//	sys_disable_interrupt();

		readline("Enter the number of elements: ", Line);
  80005d:	83 ec 08             	sub    $0x8,%esp
  800060:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800066:	50                   	push   %eax
  800067:	68 20 23 80 00       	push   $0x802320
  80006c:	e8 cb 0f 00 00       	call   80103c <readline>
  800071:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 1b 15 00 00       	call   8015a2 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 ae 18 00 00       	call   80194a <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 40 23 80 00       	push   $0x802340
  8000aa:	e8 0b 09 00 00       	call   8009ba <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 63 23 80 00       	push   $0x802363
  8000ba:	e8 fb 08 00 00       	call   8009ba <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 71 23 80 00       	push   $0x802371
  8000ca:	e8 eb 08 00 00       	call   8009ba <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 80 23 80 00       	push   $0x802380
  8000da:	e8 db 08 00 00       	call   8009ba <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 90 23 80 00       	push   $0x802390
  8000ea:	e8 cb 08 00 00       	call   8009ba <cprintf>
  8000ef:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8000f2:	e8 9b 04 00 00       	call   800592 <getchar>
  8000f7:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  8000fa:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 43 04 00 00       	call   80054a <cputchar>
  800107:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	6a 0a                	push   $0xa
  80010f:	e8 36 04 00 00       	call   80054a <cputchar>
  800114:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800117:	80 7d e7 61          	cmpb   $0x61,-0x19(%ebp)
  80011b:	74 0c                	je     800129 <_main+0xf1>
  80011d:	80 7d e7 62          	cmpb   $0x62,-0x19(%ebp)
  800121:	74 06                	je     800129 <_main+0xf1>
  800123:	80 7d e7 63          	cmpb   $0x63,-0x19(%ebp)
  800127:	75 b9                	jne    8000e2 <_main+0xaa>
		//sys_enable_interrupt();
		int  i ;
		switch (Chose)
  800129:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80012d:	83 f8 62             	cmp    $0x62,%eax
  800130:	74 1d                	je     80014f <_main+0x117>
  800132:	83 f8 63             	cmp    $0x63,%eax
  800135:	74 2b                	je     800162 <_main+0x12a>
  800137:	83 f8 61             	cmp    $0x61,%eax
  80013a:	75 39                	jne    800175 <_main+0x13d>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80013c:	83 ec 08             	sub    $0x8,%esp
  80013f:	ff 75 ec             	pushl  -0x14(%ebp)
  800142:	ff 75 e8             	pushl  -0x18(%ebp)
  800145:	e8 c8 02 00 00       	call   800412 <InitializeAscending>
  80014a:	83 c4 10             	add    $0x10,%esp
			break ;
  80014d:	eb 37                	jmp    800186 <_main+0x14e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014f:	83 ec 08             	sub    $0x8,%esp
  800152:	ff 75 ec             	pushl  -0x14(%ebp)
  800155:	ff 75 e8             	pushl  -0x18(%ebp)
  800158:	e8 e6 02 00 00       	call   800443 <InitializeDescending>
  80015d:	83 c4 10             	add    $0x10,%esp
			break ;
  800160:	eb 24                	jmp    800186 <_main+0x14e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800162:	83 ec 08             	sub    $0x8,%esp
  800165:	ff 75 ec             	pushl  -0x14(%ebp)
  800168:	ff 75 e8             	pushl  -0x18(%ebp)
  80016b:	e8 08 03 00 00       	call   800478 <InitializeSemiRandom>
  800170:	83 c4 10             	add    $0x10,%esp
			break ;
  800173:	eb 11                	jmp    800186 <_main+0x14e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 f5 02 00 00       	call   800478 <InitializeSemiRandom>
  800183:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	ff 75 e8             	pushl  -0x18(%ebp)
  80018f:	e8 c3 00 00 00       	call   800257 <QuickSort>
  800194:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800197:	83 ec 08             	sub    $0x8,%esp
  80019a:	ff 75 ec             	pushl  -0x14(%ebp)
  80019d:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a0:	e8 c3 01 00 00       	call   800368 <CheckSorted>
  8001a5:	83 c4 10             	add    $0x10,%esp
  8001a8:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001af:	75 14                	jne    8001c5 <_main+0x18d>
  8001b1:	83 ec 04             	sub    $0x4,%esp
  8001b4:	68 9c 23 80 00       	push   $0x80239c
  8001b9:	6a 45                	push   $0x45
  8001bb:	68 be 23 80 00       	push   $0x8023be
  8001c0:	e8 41 05 00 00       	call   800706 <_panic>
		else
		{ 
			cprintf("===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 d8 23 80 00       	push   $0x8023d8
  8001cd:	e8 e8 07 00 00       	call   8009ba <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 0c 24 80 00       	push   $0x80240c
  8001dd:	e8 d8 07 00 00       	call   8009ba <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 40 24 80 00       	push   $0x802440
  8001ed:	e8 c8 07 00 00       	call   8009ba <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 72 24 80 00       	push   $0x802472
  8001fd:	e8 b8 07 00 00       	call   8009ba <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

		//freeHeap() ;

		///========================================================================
		//sys_disable_interrupt();
		cprintf("Do you want to repeat (y/n): ") ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	68 88 24 80 00       	push   $0x802488
  80020d:	e8 a8 07 00 00       	call   8009ba <cprintf>
  800212:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  800215:	e8 78 03 00 00       	call   800592 <getchar>
  80021a:	88 45 e7             	mov    %al,-0x19(%ebp)
		cputchar(Chose);
  80021d:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  800221:	83 ec 0c             	sub    $0xc,%esp
  800224:	50                   	push   %eax
  800225:	e8 20 03 00 00       	call   80054a <cputchar>
  80022a:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80022d:	83 ec 0c             	sub    $0xc,%esp
  800230:	6a 0a                	push   $0xa
  800232:	e8 13 03 00 00       	call   80054a <cputchar>
  800237:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  80023a:	83 ec 0c             	sub    $0xc,%esp
  80023d:	6a 0a                	push   $0xa
  80023f:	e8 06 03 00 00       	call   80054a <cputchar>
  800244:	83 c4 10             	add    $0x10,%esp
		//sys_enable_interrupt();

	} while (Chose == 'y');
  800247:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  80024b:	0f 84 f8 fd ff ff    	je     800049 <_main+0x11>

}
  800251:	90                   	nop
  800252:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800255:	c9                   	leave  
  800256:	c3                   	ret    

00800257 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800257:	55                   	push   %ebp
  800258:	89 e5                	mov    %esp,%ebp
  80025a:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80025d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800260:	48                   	dec    %eax
  800261:	50                   	push   %eax
  800262:	6a 00                	push   $0x0
  800264:	ff 75 0c             	pushl  0xc(%ebp)
  800267:	ff 75 08             	pushl  0x8(%ebp)
  80026a:	e8 06 00 00 00       	call   800275 <QSort>
  80026f:	83 c4 10             	add    $0x10,%esp
}
  800272:	90                   	nop
  800273:	c9                   	leave  
  800274:	c3                   	ret    

00800275 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800275:	55                   	push   %ebp
  800276:	89 e5                	mov    %esp,%ebp
  800278:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  80027b:	8b 45 10             	mov    0x10(%ebp),%eax
  80027e:	3b 45 14             	cmp    0x14(%ebp),%eax
  800281:	0f 8d de 00 00 00    	jge    800365 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800287:	8b 45 10             	mov    0x10(%ebp),%eax
  80028a:	40                   	inc    %eax
  80028b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80028e:	8b 45 14             	mov    0x14(%ebp),%eax
  800291:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800294:	e9 80 00 00 00       	jmp    800319 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800299:	ff 45 f4             	incl   -0xc(%ebp)
  80029c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80029f:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002a2:	7f 2b                	jg     8002cf <QSort+0x5a>
  8002a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8002a7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8002b1:	01 d0                	add    %edx,%eax
  8002b3:	8b 10                	mov    (%eax),%edx
  8002b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002b8:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8002c2:	01 c8                	add    %ecx,%eax
  8002c4:	8b 00                	mov    (%eax),%eax
  8002c6:	39 c2                	cmp    %eax,%edx
  8002c8:	7d cf                	jge    800299 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002ca:	eb 03                	jmp    8002cf <QSort+0x5a>
  8002cc:	ff 4d f0             	decl   -0x10(%ebp)
  8002cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002d2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002d5:	7e 26                	jle    8002fd <QSort+0x88>
  8002d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8002da:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8002e4:	01 d0                	add    %edx,%eax
  8002e6:	8b 10                	mov    (%eax),%edx
  8002e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 c8                	add    %ecx,%eax
  8002f7:	8b 00                	mov    (%eax),%eax
  8002f9:	39 c2                	cmp    %eax,%edx
  8002fb:	7e cf                	jle    8002cc <QSort+0x57>

		if (i <= j)
  8002fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800300:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800303:	7f 14                	jg     800319 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800305:	83 ec 04             	sub    $0x4,%esp
  800308:	ff 75 f0             	pushl  -0x10(%ebp)
  80030b:	ff 75 f4             	pushl  -0xc(%ebp)
  80030e:	ff 75 08             	pushl  0x8(%ebp)
  800311:	e8 a9 00 00 00       	call   8003bf <Swap>
  800316:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800319:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80031c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80031f:	0f 8e 77 ff ff ff    	jle    80029c <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800325:	83 ec 04             	sub    $0x4,%esp
  800328:	ff 75 f0             	pushl  -0x10(%ebp)
  80032b:	ff 75 10             	pushl  0x10(%ebp)
  80032e:	ff 75 08             	pushl  0x8(%ebp)
  800331:	e8 89 00 00 00       	call   8003bf <Swap>
  800336:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800339:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033c:	48                   	dec    %eax
  80033d:	50                   	push   %eax
  80033e:	ff 75 10             	pushl  0x10(%ebp)
  800341:	ff 75 0c             	pushl  0xc(%ebp)
  800344:	ff 75 08             	pushl  0x8(%ebp)
  800347:	e8 29 ff ff ff       	call   800275 <QSort>
  80034c:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80034f:	ff 75 14             	pushl  0x14(%ebp)
  800352:	ff 75 f4             	pushl  -0xc(%ebp)
  800355:	ff 75 0c             	pushl  0xc(%ebp)
  800358:	ff 75 08             	pushl  0x8(%ebp)
  80035b:	e8 15 ff ff ff       	call   800275 <QSort>
  800360:	83 c4 10             	add    $0x10,%esp
  800363:	eb 01                	jmp    800366 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800365:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800366:	c9                   	leave  
  800367:	c3                   	ret    

00800368 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800368:	55                   	push   %ebp
  800369:	89 e5                	mov    %esp,%ebp
  80036b:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80036e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800375:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80037c:	eb 33                	jmp    8003b1 <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80037e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800381:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800388:	8b 45 08             	mov    0x8(%ebp),%eax
  80038b:	01 d0                	add    %edx,%eax
  80038d:	8b 10                	mov    (%eax),%edx
  80038f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800392:	40                   	inc    %eax
  800393:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80039a:	8b 45 08             	mov    0x8(%ebp),%eax
  80039d:	01 c8                	add    %ecx,%eax
  80039f:	8b 00                	mov    (%eax),%eax
  8003a1:	39 c2                	cmp    %eax,%edx
  8003a3:	7e 09                	jle    8003ae <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003a5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003ac:	eb 0c                	jmp    8003ba <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003ae:	ff 45 f8             	incl   -0x8(%ebp)
  8003b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b4:	48                   	dec    %eax
  8003b5:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003b8:	7f c4                	jg     80037e <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003bd:	c9                   	leave  
  8003be:	c3                   	ret    

008003bf <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003bf:	55                   	push   %ebp
  8003c0:	89 e5                	mov    %esp,%ebp
  8003c2:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d2:	01 d0                	add    %edx,%eax
  8003d4:	8b 00                	mov    (%eax),%eax
  8003d6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003d9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003dc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e6:	01 c2                	add    %eax,%edx
  8003e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8003eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	01 c8                	add    %ecx,%eax
  8003f7:	8b 00                	mov    (%eax),%eax
  8003f9:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8003fe:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c2                	add    %eax,%edx
  80040a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040d:	89 02                	mov    %eax,(%edx)
}
  80040f:	90                   	nop
  800410:	c9                   	leave  
  800411:	c3                   	ret    

00800412 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800412:	55                   	push   %ebp
  800413:	89 e5                	mov    %esp,%ebp
  800415:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800418:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80041f:	eb 17                	jmp    800438 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  800421:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800424:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80042b:	8b 45 08             	mov    0x8(%ebp),%eax
  80042e:	01 c2                	add    %eax,%edx
  800430:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800433:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800435:	ff 45 fc             	incl   -0x4(%ebp)
  800438:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043b:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80043e:	7c e1                	jl     800421 <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  800440:	90                   	nop
  800441:	c9                   	leave  
  800442:	c3                   	ret    

00800443 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800443:	55                   	push   %ebp
  800444:	89 e5                	mov    %esp,%ebp
  800446:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800449:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800450:	eb 1b                	jmp    80046d <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800452:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800455:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	01 c2                	add    %eax,%edx
  800461:	8b 45 0c             	mov    0xc(%ebp),%eax
  800464:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800467:	48                   	dec    %eax
  800468:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80046a:	ff 45 fc             	incl   -0x4(%ebp)
  80046d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800470:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800473:	7c dd                	jl     800452 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800475:	90                   	nop
  800476:	c9                   	leave  
  800477:	c3                   	ret    

00800478 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800478:	55                   	push   %ebp
  800479:	89 e5                	mov    %esp,%ebp
  80047b:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80047e:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800481:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800486:	f7 e9                	imul   %ecx
  800488:	c1 f9 1f             	sar    $0x1f,%ecx
  80048b:	89 d0                	mov    %edx,%eax
  80048d:	29 c8                	sub    %ecx,%eax
  80048f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  800492:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800499:	eb 1e                	jmp    8004b9 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004a8:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ae:	99                   	cltd   
  8004af:	f7 7d f8             	idivl  -0x8(%ebp)
  8004b2:	89 d0                	mov    %edx,%eax
  8004b4:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b6:	ff 45 fc             	incl   -0x4(%ebp)
  8004b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004bc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004bf:	7c da                	jl     80049b <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004c1:	90                   	nop
  8004c2:	c9                   	leave  
  8004c3:	c3                   	ret    

008004c4 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004c4:	55                   	push   %ebp
  8004c5:	89 e5                	mov    %esp,%ebp
  8004c7:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004ca:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004d8:	eb 42                	jmp    80051c <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004da:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004dd:	99                   	cltd   
  8004de:	f7 7d f0             	idivl  -0x10(%ebp)
  8004e1:	89 d0                	mov    %edx,%eax
  8004e3:	85 c0                	test   %eax,%eax
  8004e5:	75 10                	jne    8004f7 <PrintElements+0x33>
			cprintf("\n");
  8004e7:	83 ec 0c             	sub    $0xc,%esp
  8004ea:	68 a6 24 80 00       	push   $0x8024a6
  8004ef:	e8 c6 04 00 00       	call   8009ba <cprintf>
  8004f4:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8004f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004fa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800501:	8b 45 08             	mov    0x8(%ebp),%eax
  800504:	01 d0                	add    %edx,%eax
  800506:	8b 00                	mov    (%eax),%eax
  800508:	83 ec 08             	sub    $0x8,%esp
  80050b:	50                   	push   %eax
  80050c:	68 a8 24 80 00       	push   $0x8024a8
  800511:	e8 a4 04 00 00       	call   8009ba <cprintf>
  800516:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800519:	ff 45 f4             	incl   -0xc(%ebp)
  80051c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80051f:	48                   	dec    %eax
  800520:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800523:	7f b5                	jg     8004da <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800525:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800528:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80052f:	8b 45 08             	mov    0x8(%ebp),%eax
  800532:	01 d0                	add    %edx,%eax
  800534:	8b 00                	mov    (%eax),%eax
  800536:	83 ec 08             	sub    $0x8,%esp
  800539:	50                   	push   %eax
  80053a:	68 ad 24 80 00       	push   $0x8024ad
  80053f:	e8 76 04 00 00       	call   8009ba <cprintf>
  800544:	83 c4 10             	add    $0x10,%esp
}
  800547:	90                   	nop
  800548:	c9                   	leave  
  800549:	c3                   	ret    

0080054a <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  80054a:	55                   	push   %ebp
  80054b:	89 e5                	mov    %esp,%ebp
  80054d:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  800550:	8b 45 08             	mov    0x8(%ebp),%eax
  800553:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800556:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80055a:	83 ec 0c             	sub    $0xc,%esp
  80055d:	50                   	push   %eax
  80055e:	e8 47 17 00 00       	call   801caa <sys_cputc>
  800563:	83 c4 10             	add    $0x10,%esp
}
  800566:	90                   	nop
  800567:	c9                   	leave  
  800568:	c3                   	ret    

00800569 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800569:	55                   	push   %ebp
  80056a:	89 e5                	mov    %esp,%ebp
  80056c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80056f:	e8 02 17 00 00       	call   801c76 <sys_disable_interrupt>
	char c = ch;
  800574:	8b 45 08             	mov    0x8(%ebp),%eax
  800577:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  80057a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80057e:	83 ec 0c             	sub    $0xc,%esp
  800581:	50                   	push   %eax
  800582:	e8 23 17 00 00       	call   801caa <sys_cputc>
  800587:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80058a:	e8 01 17 00 00       	call   801c90 <sys_enable_interrupt>
}
  80058f:	90                   	nop
  800590:	c9                   	leave  
  800591:	c3                   	ret    

00800592 <getchar>:

int
getchar(void)
{
  800592:	55                   	push   %ebp
  800593:	89 e5                	mov    %esp,%ebp
  800595:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800598:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80059f:	eb 08                	jmp    8005a9 <getchar+0x17>
	{
		c = sys_cgetc();
  8005a1:	e8 e8 14 00 00       	call   801a8e <sys_cgetc>
  8005a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005a9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005ad:	74 f2                	je     8005a1 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005af:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005b2:	c9                   	leave  
  8005b3:	c3                   	ret    

008005b4 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005b4:	55                   	push   %ebp
  8005b5:	89 e5                	mov    %esp,%ebp
  8005b7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005ba:	e8 b7 16 00 00       	call   801c76 <sys_disable_interrupt>
	int c=0;
  8005bf:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005c6:	eb 08                	jmp    8005d0 <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005c8:	e8 c1 14 00 00       	call   801a8e <sys_cgetc>
  8005cd:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005d0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005d4:	74 f2                	je     8005c8 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005d6:	e8 b5 16 00 00       	call   801c90 <sys_enable_interrupt>
	return c;
  8005db:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005de:	c9                   	leave  
  8005df:	c3                   	ret    

008005e0 <iscons>:

int iscons(int fdnum)
{
  8005e0:	55                   	push   %ebp
  8005e1:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005e3:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005e8:	5d                   	pop    %ebp
  8005e9:	c3                   	ret    

008005ea <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005ea:	55                   	push   %ebp
  8005eb:	89 e5                	mov    %esp,%ebp
  8005ed:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005f0:	e8 e6 14 00 00       	call   801adb <sys_getenvindex>
  8005f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005fb:	89 d0                	mov    %edx,%eax
  8005fd:	01 c0                	add    %eax,%eax
  8005ff:	01 d0                	add    %edx,%eax
  800601:	c1 e0 04             	shl    $0x4,%eax
  800604:	29 d0                	sub    %edx,%eax
  800606:	c1 e0 03             	shl    $0x3,%eax
  800609:	01 d0                	add    %edx,%eax
  80060b:	c1 e0 02             	shl    $0x2,%eax
  80060e:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800613:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800618:	a1 24 30 80 00       	mov    0x803024,%eax
  80061d:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800623:	84 c0                	test   %al,%al
  800625:	74 0f                	je     800636 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800627:	a1 24 30 80 00       	mov    0x803024,%eax
  80062c:	05 5c 05 00 00       	add    $0x55c,%eax
  800631:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800636:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80063a:	7e 0a                	jle    800646 <libmain+0x5c>
		binaryname = argv[0];
  80063c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80063f:	8b 00                	mov    (%eax),%eax
  800641:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800646:	83 ec 08             	sub    $0x8,%esp
  800649:	ff 75 0c             	pushl  0xc(%ebp)
  80064c:	ff 75 08             	pushl  0x8(%ebp)
  80064f:	e8 e4 f9 ff ff       	call   800038 <_main>
  800654:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800657:	e8 1a 16 00 00       	call   801c76 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80065c:	83 ec 0c             	sub    $0xc,%esp
  80065f:	68 cc 24 80 00       	push   $0x8024cc
  800664:	e8 51 03 00 00       	call   8009ba <cprintf>
  800669:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80066c:	a1 24 30 80 00       	mov    0x803024,%eax
  800671:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800677:	a1 24 30 80 00       	mov    0x803024,%eax
  80067c:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800682:	83 ec 04             	sub    $0x4,%esp
  800685:	52                   	push   %edx
  800686:	50                   	push   %eax
  800687:	68 f4 24 80 00       	push   $0x8024f4
  80068c:	e8 29 03 00 00       	call   8009ba <cprintf>
  800691:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800694:	a1 24 30 80 00       	mov    0x803024,%eax
  800699:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80069f:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a4:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8006aa:	a1 24 30 80 00       	mov    0x803024,%eax
  8006af:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8006b5:	51                   	push   %ecx
  8006b6:	52                   	push   %edx
  8006b7:	50                   	push   %eax
  8006b8:	68 1c 25 80 00       	push   $0x80251c
  8006bd:	e8 f8 02 00 00       	call   8009ba <cprintf>
  8006c2:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006c5:	83 ec 0c             	sub    $0xc,%esp
  8006c8:	68 cc 24 80 00       	push   $0x8024cc
  8006cd:	e8 e8 02 00 00       	call   8009ba <cprintf>
  8006d2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006d5:	e8 b6 15 00 00       	call   801c90 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006da:	e8 19 00 00 00       	call   8006f8 <exit>
}
  8006df:	90                   	nop
  8006e0:	c9                   	leave  
  8006e1:	c3                   	ret    

008006e2 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006e2:	55                   	push   %ebp
  8006e3:	89 e5                	mov    %esp,%ebp
  8006e5:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006e8:	83 ec 0c             	sub    $0xc,%esp
  8006eb:	6a 00                	push   $0x0
  8006ed:	e8 b5 13 00 00       	call   801aa7 <sys_env_destroy>
  8006f2:	83 c4 10             	add    $0x10,%esp
}
  8006f5:	90                   	nop
  8006f6:	c9                   	leave  
  8006f7:	c3                   	ret    

008006f8 <exit>:

void
exit(void)
{
  8006f8:	55                   	push   %ebp
  8006f9:	89 e5                	mov    %esp,%ebp
  8006fb:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006fe:	e8 0a 14 00 00       	call   801b0d <sys_env_exit>
}
  800703:	90                   	nop
  800704:	c9                   	leave  
  800705:	c3                   	ret    

00800706 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800706:	55                   	push   %ebp
  800707:	89 e5                	mov    %esp,%ebp
  800709:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80070c:	8d 45 10             	lea    0x10(%ebp),%eax
  80070f:	83 c0 04             	add    $0x4,%eax
  800712:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800715:	a1 18 31 80 00       	mov    0x803118,%eax
  80071a:	85 c0                	test   %eax,%eax
  80071c:	74 16                	je     800734 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80071e:	a1 18 31 80 00       	mov    0x803118,%eax
  800723:	83 ec 08             	sub    $0x8,%esp
  800726:	50                   	push   %eax
  800727:	68 74 25 80 00       	push   $0x802574
  80072c:	e8 89 02 00 00       	call   8009ba <cprintf>
  800731:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800734:	a1 00 30 80 00       	mov    0x803000,%eax
  800739:	ff 75 0c             	pushl  0xc(%ebp)
  80073c:	ff 75 08             	pushl  0x8(%ebp)
  80073f:	50                   	push   %eax
  800740:	68 79 25 80 00       	push   $0x802579
  800745:	e8 70 02 00 00       	call   8009ba <cprintf>
  80074a:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80074d:	8b 45 10             	mov    0x10(%ebp),%eax
  800750:	83 ec 08             	sub    $0x8,%esp
  800753:	ff 75 f4             	pushl  -0xc(%ebp)
  800756:	50                   	push   %eax
  800757:	e8 f3 01 00 00       	call   80094f <vcprintf>
  80075c:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80075f:	83 ec 08             	sub    $0x8,%esp
  800762:	6a 00                	push   $0x0
  800764:	68 95 25 80 00       	push   $0x802595
  800769:	e8 e1 01 00 00       	call   80094f <vcprintf>
  80076e:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800771:	e8 82 ff ff ff       	call   8006f8 <exit>

	// should not return here
	while (1) ;
  800776:	eb fe                	jmp    800776 <_panic+0x70>

00800778 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800778:	55                   	push   %ebp
  800779:	89 e5                	mov    %esp,%ebp
  80077b:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80077e:	a1 24 30 80 00       	mov    0x803024,%eax
  800783:	8b 50 74             	mov    0x74(%eax),%edx
  800786:	8b 45 0c             	mov    0xc(%ebp),%eax
  800789:	39 c2                	cmp    %eax,%edx
  80078b:	74 14                	je     8007a1 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80078d:	83 ec 04             	sub    $0x4,%esp
  800790:	68 98 25 80 00       	push   $0x802598
  800795:	6a 26                	push   $0x26
  800797:	68 e4 25 80 00       	push   $0x8025e4
  80079c:	e8 65 ff ff ff       	call   800706 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007a1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007a8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007af:	e9 c2 00 00 00       	jmp    800876 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007be:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c1:	01 d0                	add    %edx,%eax
  8007c3:	8b 00                	mov    (%eax),%eax
  8007c5:	85 c0                	test   %eax,%eax
  8007c7:	75 08                	jne    8007d1 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007c9:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007cc:	e9 a2 00 00 00       	jmp    800873 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007df:	eb 69                	jmp    80084a <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007e1:	a1 24 30 80 00       	mov    0x803024,%eax
  8007e6:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8007ec:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007ef:	89 d0                	mov    %edx,%eax
  8007f1:	01 c0                	add    %eax,%eax
  8007f3:	01 d0                	add    %edx,%eax
  8007f5:	c1 e0 03             	shl    $0x3,%eax
  8007f8:	01 c8                	add    %ecx,%eax
  8007fa:	8a 40 04             	mov    0x4(%eax),%al
  8007fd:	84 c0                	test   %al,%al
  8007ff:	75 46                	jne    800847 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800801:	a1 24 30 80 00       	mov    0x803024,%eax
  800806:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80080c:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80080f:	89 d0                	mov    %edx,%eax
  800811:	01 c0                	add    %eax,%eax
  800813:	01 d0                	add    %edx,%eax
  800815:	c1 e0 03             	shl    $0x3,%eax
  800818:	01 c8                	add    %ecx,%eax
  80081a:	8b 00                	mov    (%eax),%eax
  80081c:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80081f:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800822:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800827:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800829:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80082c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800833:	8b 45 08             	mov    0x8(%ebp),%eax
  800836:	01 c8                	add    %ecx,%eax
  800838:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80083a:	39 c2                	cmp    %eax,%edx
  80083c:	75 09                	jne    800847 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80083e:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800845:	eb 12                	jmp    800859 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800847:	ff 45 e8             	incl   -0x18(%ebp)
  80084a:	a1 24 30 80 00       	mov    0x803024,%eax
  80084f:	8b 50 74             	mov    0x74(%eax),%edx
  800852:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800855:	39 c2                	cmp    %eax,%edx
  800857:	77 88                	ja     8007e1 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800859:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80085d:	75 14                	jne    800873 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80085f:	83 ec 04             	sub    $0x4,%esp
  800862:	68 f0 25 80 00       	push   $0x8025f0
  800867:	6a 3a                	push   $0x3a
  800869:	68 e4 25 80 00       	push   $0x8025e4
  80086e:	e8 93 fe ff ff       	call   800706 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800873:	ff 45 f0             	incl   -0x10(%ebp)
  800876:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800879:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80087c:	0f 8c 32 ff ff ff    	jl     8007b4 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800882:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800889:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800890:	eb 26                	jmp    8008b8 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800892:	a1 24 30 80 00       	mov    0x803024,%eax
  800897:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80089d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008a0:	89 d0                	mov    %edx,%eax
  8008a2:	01 c0                	add    %eax,%eax
  8008a4:	01 d0                	add    %edx,%eax
  8008a6:	c1 e0 03             	shl    $0x3,%eax
  8008a9:	01 c8                	add    %ecx,%eax
  8008ab:	8a 40 04             	mov    0x4(%eax),%al
  8008ae:	3c 01                	cmp    $0x1,%al
  8008b0:	75 03                	jne    8008b5 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008b2:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b5:	ff 45 e0             	incl   -0x20(%ebp)
  8008b8:	a1 24 30 80 00       	mov    0x803024,%eax
  8008bd:	8b 50 74             	mov    0x74(%eax),%edx
  8008c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008c3:	39 c2                	cmp    %eax,%edx
  8008c5:	77 cb                	ja     800892 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008ca:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008cd:	74 14                	je     8008e3 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008cf:	83 ec 04             	sub    $0x4,%esp
  8008d2:	68 44 26 80 00       	push   $0x802644
  8008d7:	6a 44                	push   $0x44
  8008d9:	68 e4 25 80 00       	push   $0x8025e4
  8008de:	e8 23 fe ff ff       	call   800706 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008e3:	90                   	nop
  8008e4:	c9                   	leave  
  8008e5:	c3                   	ret    

008008e6 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008e6:	55                   	push   %ebp
  8008e7:	89 e5                	mov    %esp,%ebp
  8008e9:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ef:	8b 00                	mov    (%eax),%eax
  8008f1:	8d 48 01             	lea    0x1(%eax),%ecx
  8008f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f7:	89 0a                	mov    %ecx,(%edx)
  8008f9:	8b 55 08             	mov    0x8(%ebp),%edx
  8008fc:	88 d1                	mov    %dl,%cl
  8008fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  800901:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800905:	8b 45 0c             	mov    0xc(%ebp),%eax
  800908:	8b 00                	mov    (%eax),%eax
  80090a:	3d ff 00 00 00       	cmp    $0xff,%eax
  80090f:	75 2c                	jne    80093d <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800911:	a0 28 30 80 00       	mov    0x803028,%al
  800916:	0f b6 c0             	movzbl %al,%eax
  800919:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091c:	8b 12                	mov    (%edx),%edx
  80091e:	89 d1                	mov    %edx,%ecx
  800920:	8b 55 0c             	mov    0xc(%ebp),%edx
  800923:	83 c2 08             	add    $0x8,%edx
  800926:	83 ec 04             	sub    $0x4,%esp
  800929:	50                   	push   %eax
  80092a:	51                   	push   %ecx
  80092b:	52                   	push   %edx
  80092c:	e8 34 11 00 00       	call   801a65 <sys_cputs>
  800931:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800934:	8b 45 0c             	mov    0xc(%ebp),%eax
  800937:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80093d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800940:	8b 40 04             	mov    0x4(%eax),%eax
  800943:	8d 50 01             	lea    0x1(%eax),%edx
  800946:	8b 45 0c             	mov    0xc(%ebp),%eax
  800949:	89 50 04             	mov    %edx,0x4(%eax)
}
  80094c:	90                   	nop
  80094d:	c9                   	leave  
  80094e:	c3                   	ret    

0080094f <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80094f:	55                   	push   %ebp
  800950:	89 e5                	mov    %esp,%ebp
  800952:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800958:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80095f:	00 00 00 
	b.cnt = 0;
  800962:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800969:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80096c:	ff 75 0c             	pushl  0xc(%ebp)
  80096f:	ff 75 08             	pushl  0x8(%ebp)
  800972:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800978:	50                   	push   %eax
  800979:	68 e6 08 80 00       	push   $0x8008e6
  80097e:	e8 11 02 00 00       	call   800b94 <vprintfmt>
  800983:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800986:	a0 28 30 80 00       	mov    0x803028,%al
  80098b:	0f b6 c0             	movzbl %al,%eax
  80098e:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800994:	83 ec 04             	sub    $0x4,%esp
  800997:	50                   	push   %eax
  800998:	52                   	push   %edx
  800999:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80099f:	83 c0 08             	add    $0x8,%eax
  8009a2:	50                   	push   %eax
  8009a3:	e8 bd 10 00 00       	call   801a65 <sys_cputs>
  8009a8:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009ab:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009b2:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009b8:	c9                   	leave  
  8009b9:	c3                   	ret    

008009ba <cprintf>:

int cprintf(const char *fmt, ...) {
  8009ba:	55                   	push   %ebp
  8009bb:	89 e5                	mov    %esp,%ebp
  8009bd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009c0:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009c7:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d0:	83 ec 08             	sub    $0x8,%esp
  8009d3:	ff 75 f4             	pushl  -0xc(%ebp)
  8009d6:	50                   	push   %eax
  8009d7:	e8 73 ff ff ff       	call   80094f <vcprintf>
  8009dc:	83 c4 10             	add    $0x10,%esp
  8009df:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009e5:	c9                   	leave  
  8009e6:	c3                   	ret    

008009e7 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009e7:	55                   	push   %ebp
  8009e8:	89 e5                	mov    %esp,%ebp
  8009ea:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009ed:	e8 84 12 00 00       	call   801c76 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009f2:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8009fb:	83 ec 08             	sub    $0x8,%esp
  8009fe:	ff 75 f4             	pushl  -0xc(%ebp)
  800a01:	50                   	push   %eax
  800a02:	e8 48 ff ff ff       	call   80094f <vcprintf>
  800a07:	83 c4 10             	add    $0x10,%esp
  800a0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a0d:	e8 7e 12 00 00       	call   801c90 <sys_enable_interrupt>
	return cnt;
  800a12:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a15:	c9                   	leave  
  800a16:	c3                   	ret    

00800a17 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a17:	55                   	push   %ebp
  800a18:	89 e5                	mov    %esp,%ebp
  800a1a:	53                   	push   %ebx
  800a1b:	83 ec 14             	sub    $0x14,%esp
  800a1e:	8b 45 10             	mov    0x10(%ebp),%eax
  800a21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a24:	8b 45 14             	mov    0x14(%ebp),%eax
  800a27:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a2a:	8b 45 18             	mov    0x18(%ebp),%eax
  800a2d:	ba 00 00 00 00       	mov    $0x0,%edx
  800a32:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a35:	77 55                	ja     800a8c <printnum+0x75>
  800a37:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a3a:	72 05                	jb     800a41 <printnum+0x2a>
  800a3c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a3f:	77 4b                	ja     800a8c <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a41:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a44:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a47:	8b 45 18             	mov    0x18(%ebp),%eax
  800a4a:	ba 00 00 00 00       	mov    $0x0,%edx
  800a4f:	52                   	push   %edx
  800a50:	50                   	push   %eax
  800a51:	ff 75 f4             	pushl  -0xc(%ebp)
  800a54:	ff 75 f0             	pushl  -0x10(%ebp)
  800a57:	e8 58 16 00 00       	call   8020b4 <__udivdi3>
  800a5c:	83 c4 10             	add    $0x10,%esp
  800a5f:	83 ec 04             	sub    $0x4,%esp
  800a62:	ff 75 20             	pushl  0x20(%ebp)
  800a65:	53                   	push   %ebx
  800a66:	ff 75 18             	pushl  0x18(%ebp)
  800a69:	52                   	push   %edx
  800a6a:	50                   	push   %eax
  800a6b:	ff 75 0c             	pushl  0xc(%ebp)
  800a6e:	ff 75 08             	pushl  0x8(%ebp)
  800a71:	e8 a1 ff ff ff       	call   800a17 <printnum>
  800a76:	83 c4 20             	add    $0x20,%esp
  800a79:	eb 1a                	jmp    800a95 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a7b:	83 ec 08             	sub    $0x8,%esp
  800a7e:	ff 75 0c             	pushl  0xc(%ebp)
  800a81:	ff 75 20             	pushl  0x20(%ebp)
  800a84:	8b 45 08             	mov    0x8(%ebp),%eax
  800a87:	ff d0                	call   *%eax
  800a89:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a8c:	ff 4d 1c             	decl   0x1c(%ebp)
  800a8f:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a93:	7f e6                	jg     800a7b <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a95:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a98:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aa0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800aa3:	53                   	push   %ebx
  800aa4:	51                   	push   %ecx
  800aa5:	52                   	push   %edx
  800aa6:	50                   	push   %eax
  800aa7:	e8 18 17 00 00       	call   8021c4 <__umoddi3>
  800aac:	83 c4 10             	add    $0x10,%esp
  800aaf:	05 b4 28 80 00       	add    $0x8028b4,%eax
  800ab4:	8a 00                	mov    (%eax),%al
  800ab6:	0f be c0             	movsbl %al,%eax
  800ab9:	83 ec 08             	sub    $0x8,%esp
  800abc:	ff 75 0c             	pushl  0xc(%ebp)
  800abf:	50                   	push   %eax
  800ac0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac3:	ff d0                	call   *%eax
  800ac5:	83 c4 10             	add    $0x10,%esp
}
  800ac8:	90                   	nop
  800ac9:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800acc:	c9                   	leave  
  800acd:	c3                   	ret    

00800ace <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ace:	55                   	push   %ebp
  800acf:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ad1:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ad5:	7e 1c                	jle    800af3 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	8b 00                	mov    (%eax),%eax
  800adc:	8d 50 08             	lea    0x8(%eax),%edx
  800adf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae2:	89 10                	mov    %edx,(%eax)
  800ae4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae7:	8b 00                	mov    (%eax),%eax
  800ae9:	83 e8 08             	sub    $0x8,%eax
  800aec:	8b 50 04             	mov    0x4(%eax),%edx
  800aef:	8b 00                	mov    (%eax),%eax
  800af1:	eb 40                	jmp    800b33 <getuint+0x65>
	else if (lflag)
  800af3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800af7:	74 1e                	je     800b17 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	8b 00                	mov    (%eax),%eax
  800afe:	8d 50 04             	lea    0x4(%eax),%edx
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	89 10                	mov    %edx,(%eax)
  800b06:	8b 45 08             	mov    0x8(%ebp),%eax
  800b09:	8b 00                	mov    (%eax),%eax
  800b0b:	83 e8 04             	sub    $0x4,%eax
  800b0e:	8b 00                	mov    (%eax),%eax
  800b10:	ba 00 00 00 00       	mov    $0x0,%edx
  800b15:	eb 1c                	jmp    800b33 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	8b 00                	mov    (%eax),%eax
  800b1c:	8d 50 04             	lea    0x4(%eax),%edx
  800b1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b22:	89 10                	mov    %edx,(%eax)
  800b24:	8b 45 08             	mov    0x8(%ebp),%eax
  800b27:	8b 00                	mov    (%eax),%eax
  800b29:	83 e8 04             	sub    $0x4,%eax
  800b2c:	8b 00                	mov    (%eax),%eax
  800b2e:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b33:	5d                   	pop    %ebp
  800b34:	c3                   	ret    

00800b35 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b35:	55                   	push   %ebp
  800b36:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b38:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b3c:	7e 1c                	jle    800b5a <getint+0x25>
		return va_arg(*ap, long long);
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	8d 50 08             	lea    0x8(%eax),%edx
  800b46:	8b 45 08             	mov    0x8(%ebp),%eax
  800b49:	89 10                	mov    %edx,(%eax)
  800b4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4e:	8b 00                	mov    (%eax),%eax
  800b50:	83 e8 08             	sub    $0x8,%eax
  800b53:	8b 50 04             	mov    0x4(%eax),%edx
  800b56:	8b 00                	mov    (%eax),%eax
  800b58:	eb 38                	jmp    800b92 <getint+0x5d>
	else if (lflag)
  800b5a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b5e:	74 1a                	je     800b7a <getint+0x45>
		return va_arg(*ap, long);
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	8b 00                	mov    (%eax),%eax
  800b65:	8d 50 04             	lea    0x4(%eax),%edx
  800b68:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6b:	89 10                	mov    %edx,(%eax)
  800b6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b70:	8b 00                	mov    (%eax),%eax
  800b72:	83 e8 04             	sub    $0x4,%eax
  800b75:	8b 00                	mov    (%eax),%eax
  800b77:	99                   	cltd   
  800b78:	eb 18                	jmp    800b92 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	8b 00                	mov    (%eax),%eax
  800b7f:	8d 50 04             	lea    0x4(%eax),%edx
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	89 10                	mov    %edx,(%eax)
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	8b 00                	mov    (%eax),%eax
  800b8c:	83 e8 04             	sub    $0x4,%eax
  800b8f:	8b 00                	mov    (%eax),%eax
  800b91:	99                   	cltd   
}
  800b92:	5d                   	pop    %ebp
  800b93:	c3                   	ret    

00800b94 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b94:	55                   	push   %ebp
  800b95:	89 e5                	mov    %esp,%ebp
  800b97:	56                   	push   %esi
  800b98:	53                   	push   %ebx
  800b99:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b9c:	eb 17                	jmp    800bb5 <vprintfmt+0x21>
			if (ch == '\0')
  800b9e:	85 db                	test   %ebx,%ebx
  800ba0:	0f 84 af 03 00 00    	je     800f55 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800ba6:	83 ec 08             	sub    $0x8,%esp
  800ba9:	ff 75 0c             	pushl  0xc(%ebp)
  800bac:	53                   	push   %ebx
  800bad:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb0:	ff d0                	call   *%eax
  800bb2:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bb5:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb8:	8d 50 01             	lea    0x1(%eax),%edx
  800bbb:	89 55 10             	mov    %edx,0x10(%ebp)
  800bbe:	8a 00                	mov    (%eax),%al
  800bc0:	0f b6 d8             	movzbl %al,%ebx
  800bc3:	83 fb 25             	cmp    $0x25,%ebx
  800bc6:	75 d6                	jne    800b9e <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bc8:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bcc:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bd3:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bda:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800be1:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800be8:	8b 45 10             	mov    0x10(%ebp),%eax
  800beb:	8d 50 01             	lea    0x1(%eax),%edx
  800bee:	89 55 10             	mov    %edx,0x10(%ebp)
  800bf1:	8a 00                	mov    (%eax),%al
  800bf3:	0f b6 d8             	movzbl %al,%ebx
  800bf6:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bf9:	83 f8 55             	cmp    $0x55,%eax
  800bfc:	0f 87 2b 03 00 00    	ja     800f2d <vprintfmt+0x399>
  800c02:	8b 04 85 d8 28 80 00 	mov    0x8028d8(,%eax,4),%eax
  800c09:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c0b:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c0f:	eb d7                	jmp    800be8 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c11:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c15:	eb d1                	jmp    800be8 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c17:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c1e:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c21:	89 d0                	mov    %edx,%eax
  800c23:	c1 e0 02             	shl    $0x2,%eax
  800c26:	01 d0                	add    %edx,%eax
  800c28:	01 c0                	add    %eax,%eax
  800c2a:	01 d8                	add    %ebx,%eax
  800c2c:	83 e8 30             	sub    $0x30,%eax
  800c2f:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c32:	8b 45 10             	mov    0x10(%ebp),%eax
  800c35:	8a 00                	mov    (%eax),%al
  800c37:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c3a:	83 fb 2f             	cmp    $0x2f,%ebx
  800c3d:	7e 3e                	jle    800c7d <vprintfmt+0xe9>
  800c3f:	83 fb 39             	cmp    $0x39,%ebx
  800c42:	7f 39                	jg     800c7d <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c44:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c47:	eb d5                	jmp    800c1e <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c49:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4c:	83 c0 04             	add    $0x4,%eax
  800c4f:	89 45 14             	mov    %eax,0x14(%ebp)
  800c52:	8b 45 14             	mov    0x14(%ebp),%eax
  800c55:	83 e8 04             	sub    $0x4,%eax
  800c58:	8b 00                	mov    (%eax),%eax
  800c5a:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c5d:	eb 1f                	jmp    800c7e <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c5f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c63:	79 83                	jns    800be8 <vprintfmt+0x54>
				width = 0;
  800c65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c6c:	e9 77 ff ff ff       	jmp    800be8 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c71:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c78:	e9 6b ff ff ff       	jmp    800be8 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c7d:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c7e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c82:	0f 89 60 ff ff ff    	jns    800be8 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c88:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c8b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c8e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c95:	e9 4e ff ff ff       	jmp    800be8 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c9a:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c9d:	e9 46 ff ff ff       	jmp    800be8 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ca2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca5:	83 c0 04             	add    $0x4,%eax
  800ca8:	89 45 14             	mov    %eax,0x14(%ebp)
  800cab:	8b 45 14             	mov    0x14(%ebp),%eax
  800cae:	83 e8 04             	sub    $0x4,%eax
  800cb1:	8b 00                	mov    (%eax),%eax
  800cb3:	83 ec 08             	sub    $0x8,%esp
  800cb6:	ff 75 0c             	pushl  0xc(%ebp)
  800cb9:	50                   	push   %eax
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	ff d0                	call   *%eax
  800cbf:	83 c4 10             	add    $0x10,%esp
			break;
  800cc2:	e9 89 02 00 00       	jmp    800f50 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cc7:	8b 45 14             	mov    0x14(%ebp),%eax
  800cca:	83 c0 04             	add    $0x4,%eax
  800ccd:	89 45 14             	mov    %eax,0x14(%ebp)
  800cd0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd3:	83 e8 04             	sub    $0x4,%eax
  800cd6:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cd8:	85 db                	test   %ebx,%ebx
  800cda:	79 02                	jns    800cde <vprintfmt+0x14a>
				err = -err;
  800cdc:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cde:	83 fb 64             	cmp    $0x64,%ebx
  800ce1:	7f 0b                	jg     800cee <vprintfmt+0x15a>
  800ce3:	8b 34 9d 20 27 80 00 	mov    0x802720(,%ebx,4),%esi
  800cea:	85 f6                	test   %esi,%esi
  800cec:	75 19                	jne    800d07 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cee:	53                   	push   %ebx
  800cef:	68 c5 28 80 00       	push   $0x8028c5
  800cf4:	ff 75 0c             	pushl  0xc(%ebp)
  800cf7:	ff 75 08             	pushl  0x8(%ebp)
  800cfa:	e8 5e 02 00 00       	call   800f5d <printfmt>
  800cff:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d02:	e9 49 02 00 00       	jmp    800f50 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d07:	56                   	push   %esi
  800d08:	68 ce 28 80 00       	push   $0x8028ce
  800d0d:	ff 75 0c             	pushl  0xc(%ebp)
  800d10:	ff 75 08             	pushl  0x8(%ebp)
  800d13:	e8 45 02 00 00       	call   800f5d <printfmt>
  800d18:	83 c4 10             	add    $0x10,%esp
			break;
  800d1b:	e9 30 02 00 00       	jmp    800f50 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d20:	8b 45 14             	mov    0x14(%ebp),%eax
  800d23:	83 c0 04             	add    $0x4,%eax
  800d26:	89 45 14             	mov    %eax,0x14(%ebp)
  800d29:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2c:	83 e8 04             	sub    $0x4,%eax
  800d2f:	8b 30                	mov    (%eax),%esi
  800d31:	85 f6                	test   %esi,%esi
  800d33:	75 05                	jne    800d3a <vprintfmt+0x1a6>
				p = "(null)";
  800d35:	be d1 28 80 00       	mov    $0x8028d1,%esi
			if (width > 0 && padc != '-')
  800d3a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d3e:	7e 6d                	jle    800dad <vprintfmt+0x219>
  800d40:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d44:	74 67                	je     800dad <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d46:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d49:	83 ec 08             	sub    $0x8,%esp
  800d4c:	50                   	push   %eax
  800d4d:	56                   	push   %esi
  800d4e:	e8 12 05 00 00       	call   801265 <strnlen>
  800d53:	83 c4 10             	add    $0x10,%esp
  800d56:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d59:	eb 16                	jmp    800d71 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d5b:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d5f:	83 ec 08             	sub    $0x8,%esp
  800d62:	ff 75 0c             	pushl  0xc(%ebp)
  800d65:	50                   	push   %eax
  800d66:	8b 45 08             	mov    0x8(%ebp),%eax
  800d69:	ff d0                	call   *%eax
  800d6b:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d6e:	ff 4d e4             	decl   -0x1c(%ebp)
  800d71:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d75:	7f e4                	jg     800d5b <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d77:	eb 34                	jmp    800dad <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d79:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d7d:	74 1c                	je     800d9b <vprintfmt+0x207>
  800d7f:	83 fb 1f             	cmp    $0x1f,%ebx
  800d82:	7e 05                	jle    800d89 <vprintfmt+0x1f5>
  800d84:	83 fb 7e             	cmp    $0x7e,%ebx
  800d87:	7e 12                	jle    800d9b <vprintfmt+0x207>
					putch('?', putdat);
  800d89:	83 ec 08             	sub    $0x8,%esp
  800d8c:	ff 75 0c             	pushl  0xc(%ebp)
  800d8f:	6a 3f                	push   $0x3f
  800d91:	8b 45 08             	mov    0x8(%ebp),%eax
  800d94:	ff d0                	call   *%eax
  800d96:	83 c4 10             	add    $0x10,%esp
  800d99:	eb 0f                	jmp    800daa <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d9b:	83 ec 08             	sub    $0x8,%esp
  800d9e:	ff 75 0c             	pushl  0xc(%ebp)
  800da1:	53                   	push   %ebx
  800da2:	8b 45 08             	mov    0x8(%ebp),%eax
  800da5:	ff d0                	call   *%eax
  800da7:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800daa:	ff 4d e4             	decl   -0x1c(%ebp)
  800dad:	89 f0                	mov    %esi,%eax
  800daf:	8d 70 01             	lea    0x1(%eax),%esi
  800db2:	8a 00                	mov    (%eax),%al
  800db4:	0f be d8             	movsbl %al,%ebx
  800db7:	85 db                	test   %ebx,%ebx
  800db9:	74 24                	je     800ddf <vprintfmt+0x24b>
  800dbb:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dbf:	78 b8                	js     800d79 <vprintfmt+0x1e5>
  800dc1:	ff 4d e0             	decl   -0x20(%ebp)
  800dc4:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc8:	79 af                	jns    800d79 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dca:	eb 13                	jmp    800ddf <vprintfmt+0x24b>
				putch(' ', putdat);
  800dcc:	83 ec 08             	sub    $0x8,%esp
  800dcf:	ff 75 0c             	pushl  0xc(%ebp)
  800dd2:	6a 20                	push   $0x20
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	ff d0                	call   *%eax
  800dd9:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800ddc:	ff 4d e4             	decl   -0x1c(%ebp)
  800ddf:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de3:	7f e7                	jg     800dcc <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800de5:	e9 66 01 00 00       	jmp    800f50 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dea:	83 ec 08             	sub    $0x8,%esp
  800ded:	ff 75 e8             	pushl  -0x18(%ebp)
  800df0:	8d 45 14             	lea    0x14(%ebp),%eax
  800df3:	50                   	push   %eax
  800df4:	e8 3c fd ff ff       	call   800b35 <getint>
  800df9:	83 c4 10             	add    $0x10,%esp
  800dfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800dff:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e02:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e05:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e08:	85 d2                	test   %edx,%edx
  800e0a:	79 23                	jns    800e2f <vprintfmt+0x29b>
				putch('-', putdat);
  800e0c:	83 ec 08             	sub    $0x8,%esp
  800e0f:	ff 75 0c             	pushl  0xc(%ebp)
  800e12:	6a 2d                	push   $0x2d
  800e14:	8b 45 08             	mov    0x8(%ebp),%eax
  800e17:	ff d0                	call   *%eax
  800e19:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e1c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e1f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e22:	f7 d8                	neg    %eax
  800e24:	83 d2 00             	adc    $0x0,%edx
  800e27:	f7 da                	neg    %edx
  800e29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e2c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e2f:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e36:	e9 bc 00 00 00       	jmp    800ef7 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e3b:	83 ec 08             	sub    $0x8,%esp
  800e3e:	ff 75 e8             	pushl  -0x18(%ebp)
  800e41:	8d 45 14             	lea    0x14(%ebp),%eax
  800e44:	50                   	push   %eax
  800e45:	e8 84 fc ff ff       	call   800ace <getuint>
  800e4a:	83 c4 10             	add    $0x10,%esp
  800e4d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e50:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e53:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e5a:	e9 98 00 00 00       	jmp    800ef7 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e5f:	83 ec 08             	sub    $0x8,%esp
  800e62:	ff 75 0c             	pushl  0xc(%ebp)
  800e65:	6a 58                	push   $0x58
  800e67:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6a:	ff d0                	call   *%eax
  800e6c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e6f:	83 ec 08             	sub    $0x8,%esp
  800e72:	ff 75 0c             	pushl  0xc(%ebp)
  800e75:	6a 58                	push   $0x58
  800e77:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7a:	ff d0                	call   *%eax
  800e7c:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7f:	83 ec 08             	sub    $0x8,%esp
  800e82:	ff 75 0c             	pushl  0xc(%ebp)
  800e85:	6a 58                	push   $0x58
  800e87:	8b 45 08             	mov    0x8(%ebp),%eax
  800e8a:	ff d0                	call   *%eax
  800e8c:	83 c4 10             	add    $0x10,%esp
			break;
  800e8f:	e9 bc 00 00 00       	jmp    800f50 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e94:	83 ec 08             	sub    $0x8,%esp
  800e97:	ff 75 0c             	pushl  0xc(%ebp)
  800e9a:	6a 30                	push   $0x30
  800e9c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9f:	ff d0                	call   *%eax
  800ea1:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ea4:	83 ec 08             	sub    $0x8,%esp
  800ea7:	ff 75 0c             	pushl  0xc(%ebp)
  800eaa:	6a 78                	push   $0x78
  800eac:	8b 45 08             	mov    0x8(%ebp),%eax
  800eaf:	ff d0                	call   *%eax
  800eb1:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb7:	83 c0 04             	add    $0x4,%eax
  800eba:	89 45 14             	mov    %eax,0x14(%ebp)
  800ebd:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec0:	83 e8 04             	sub    $0x4,%eax
  800ec3:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ec5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ecf:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ed6:	eb 1f                	jmp    800ef7 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ed8:	83 ec 08             	sub    $0x8,%esp
  800edb:	ff 75 e8             	pushl  -0x18(%ebp)
  800ede:	8d 45 14             	lea    0x14(%ebp),%eax
  800ee1:	50                   	push   %eax
  800ee2:	e8 e7 fb ff ff       	call   800ace <getuint>
  800ee7:	83 c4 10             	add    $0x10,%esp
  800eea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eed:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ef0:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800ef7:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800efb:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800efe:	83 ec 04             	sub    $0x4,%esp
  800f01:	52                   	push   %edx
  800f02:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f05:	50                   	push   %eax
  800f06:	ff 75 f4             	pushl  -0xc(%ebp)
  800f09:	ff 75 f0             	pushl  -0x10(%ebp)
  800f0c:	ff 75 0c             	pushl  0xc(%ebp)
  800f0f:	ff 75 08             	pushl  0x8(%ebp)
  800f12:	e8 00 fb ff ff       	call   800a17 <printnum>
  800f17:	83 c4 20             	add    $0x20,%esp
			break;
  800f1a:	eb 34                	jmp    800f50 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f1c:	83 ec 08             	sub    $0x8,%esp
  800f1f:	ff 75 0c             	pushl  0xc(%ebp)
  800f22:	53                   	push   %ebx
  800f23:	8b 45 08             	mov    0x8(%ebp),%eax
  800f26:	ff d0                	call   *%eax
  800f28:	83 c4 10             	add    $0x10,%esp
			break;
  800f2b:	eb 23                	jmp    800f50 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f2d:	83 ec 08             	sub    $0x8,%esp
  800f30:	ff 75 0c             	pushl  0xc(%ebp)
  800f33:	6a 25                	push   $0x25
  800f35:	8b 45 08             	mov    0x8(%ebp),%eax
  800f38:	ff d0                	call   *%eax
  800f3a:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f3d:	ff 4d 10             	decl   0x10(%ebp)
  800f40:	eb 03                	jmp    800f45 <vprintfmt+0x3b1>
  800f42:	ff 4d 10             	decl   0x10(%ebp)
  800f45:	8b 45 10             	mov    0x10(%ebp),%eax
  800f48:	48                   	dec    %eax
  800f49:	8a 00                	mov    (%eax),%al
  800f4b:	3c 25                	cmp    $0x25,%al
  800f4d:	75 f3                	jne    800f42 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f4f:	90                   	nop
		}
	}
  800f50:	e9 47 fc ff ff       	jmp    800b9c <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f55:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f56:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f59:	5b                   	pop    %ebx
  800f5a:	5e                   	pop    %esi
  800f5b:	5d                   	pop    %ebp
  800f5c:	c3                   	ret    

00800f5d <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f5d:	55                   	push   %ebp
  800f5e:	89 e5                	mov    %esp,%ebp
  800f60:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f63:	8d 45 10             	lea    0x10(%ebp),%eax
  800f66:	83 c0 04             	add    $0x4,%eax
  800f69:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f6c:	8b 45 10             	mov    0x10(%ebp),%eax
  800f6f:	ff 75 f4             	pushl  -0xc(%ebp)
  800f72:	50                   	push   %eax
  800f73:	ff 75 0c             	pushl  0xc(%ebp)
  800f76:	ff 75 08             	pushl  0x8(%ebp)
  800f79:	e8 16 fc ff ff       	call   800b94 <vprintfmt>
  800f7e:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f81:	90                   	nop
  800f82:	c9                   	leave  
  800f83:	c3                   	ret    

00800f84 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f84:	55                   	push   %ebp
  800f85:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f87:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8a:	8b 40 08             	mov    0x8(%eax),%eax
  800f8d:	8d 50 01             	lea    0x1(%eax),%edx
  800f90:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f93:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f99:	8b 10                	mov    (%eax),%edx
  800f9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9e:	8b 40 04             	mov    0x4(%eax),%eax
  800fa1:	39 c2                	cmp    %eax,%edx
  800fa3:	73 12                	jae    800fb7 <sprintputch+0x33>
		*b->buf++ = ch;
  800fa5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa8:	8b 00                	mov    (%eax),%eax
  800faa:	8d 48 01             	lea    0x1(%eax),%ecx
  800fad:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fb0:	89 0a                	mov    %ecx,(%edx)
  800fb2:	8b 55 08             	mov    0x8(%ebp),%edx
  800fb5:	88 10                	mov    %dl,(%eax)
}
  800fb7:	90                   	nop
  800fb8:	5d                   	pop    %ebp
  800fb9:	c3                   	ret    

00800fba <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fba:	55                   	push   %ebp
  800fbb:	89 e5                	mov    %esp,%ebp
  800fbd:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc9:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800fcf:	01 d0                	add    %edx,%eax
  800fd1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fd4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fdb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fdf:	74 06                	je     800fe7 <vsnprintf+0x2d>
  800fe1:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fe5:	7f 07                	jg     800fee <vsnprintf+0x34>
		return -E_INVAL;
  800fe7:	b8 03 00 00 00       	mov    $0x3,%eax
  800fec:	eb 20                	jmp    80100e <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fee:	ff 75 14             	pushl  0x14(%ebp)
  800ff1:	ff 75 10             	pushl  0x10(%ebp)
  800ff4:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800ff7:	50                   	push   %eax
  800ff8:	68 84 0f 80 00       	push   $0x800f84
  800ffd:	e8 92 fb ff ff       	call   800b94 <vprintfmt>
  801002:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801005:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801008:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80100b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80100e:	c9                   	leave  
  80100f:	c3                   	ret    

00801010 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801010:	55                   	push   %ebp
  801011:	89 e5                	mov    %esp,%ebp
  801013:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801016:	8d 45 10             	lea    0x10(%ebp),%eax
  801019:	83 c0 04             	add    $0x4,%eax
  80101c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80101f:	8b 45 10             	mov    0x10(%ebp),%eax
  801022:	ff 75 f4             	pushl  -0xc(%ebp)
  801025:	50                   	push   %eax
  801026:	ff 75 0c             	pushl  0xc(%ebp)
  801029:	ff 75 08             	pushl  0x8(%ebp)
  80102c:	e8 89 ff ff ff       	call   800fba <vsnprintf>
  801031:	83 c4 10             	add    $0x10,%esp
  801034:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801037:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80103a:	c9                   	leave  
  80103b:	c3                   	ret    

0080103c <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80103c:	55                   	push   %ebp
  80103d:	89 e5                	mov    %esp,%ebp
  80103f:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801042:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801046:	74 13                	je     80105b <readline+0x1f>
		cprintf("%s", prompt);
  801048:	83 ec 08             	sub    $0x8,%esp
  80104b:	ff 75 08             	pushl  0x8(%ebp)
  80104e:	68 30 2a 80 00       	push   $0x802a30
  801053:	e8 62 f9 ff ff       	call   8009ba <cprintf>
  801058:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80105b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801062:	83 ec 0c             	sub    $0xc,%esp
  801065:	6a 00                	push   $0x0
  801067:	e8 74 f5 ff ff       	call   8005e0 <iscons>
  80106c:	83 c4 10             	add    $0x10,%esp
  80106f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801072:	e8 1b f5 ff ff       	call   800592 <getchar>
  801077:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80107a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80107e:	79 22                	jns    8010a2 <readline+0x66>
			if (c != -E_EOF)
  801080:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801084:	0f 84 ad 00 00 00    	je     801137 <readline+0xfb>
				cprintf("read error: %e\n", c);
  80108a:	83 ec 08             	sub    $0x8,%esp
  80108d:	ff 75 ec             	pushl  -0x14(%ebp)
  801090:	68 33 2a 80 00       	push   $0x802a33
  801095:	e8 20 f9 ff ff       	call   8009ba <cprintf>
  80109a:	83 c4 10             	add    $0x10,%esp
			return;
  80109d:	e9 95 00 00 00       	jmp    801137 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010a2:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010a6:	7e 34                	jle    8010dc <readline+0xa0>
  8010a8:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010af:	7f 2b                	jg     8010dc <readline+0xa0>
			if (echoing)
  8010b1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010b5:	74 0e                	je     8010c5 <readline+0x89>
				cputchar(c);
  8010b7:	83 ec 0c             	sub    $0xc,%esp
  8010ba:	ff 75 ec             	pushl  -0x14(%ebp)
  8010bd:	e8 88 f4 ff ff       	call   80054a <cputchar>
  8010c2:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010c8:	8d 50 01             	lea    0x1(%eax),%edx
  8010cb:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010ce:	89 c2                	mov    %eax,%edx
  8010d0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d3:	01 d0                	add    %edx,%eax
  8010d5:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010d8:	88 10                	mov    %dl,(%eax)
  8010da:	eb 56                	jmp    801132 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010dc:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010e0:	75 1f                	jne    801101 <readline+0xc5>
  8010e2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010e6:	7e 19                	jle    801101 <readline+0xc5>
			if (echoing)
  8010e8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010ec:	74 0e                	je     8010fc <readline+0xc0>
				cputchar(c);
  8010ee:	83 ec 0c             	sub    $0xc,%esp
  8010f1:	ff 75 ec             	pushl  -0x14(%ebp)
  8010f4:	e8 51 f4 ff ff       	call   80054a <cputchar>
  8010f9:	83 c4 10             	add    $0x10,%esp

			i--;
  8010fc:	ff 4d f4             	decl   -0xc(%ebp)
  8010ff:	eb 31                	jmp    801132 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801101:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801105:	74 0a                	je     801111 <readline+0xd5>
  801107:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80110b:	0f 85 61 ff ff ff    	jne    801072 <readline+0x36>
			if (echoing)
  801111:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801115:	74 0e                	je     801125 <readline+0xe9>
				cputchar(c);
  801117:	83 ec 0c             	sub    $0xc,%esp
  80111a:	ff 75 ec             	pushl  -0x14(%ebp)
  80111d:	e8 28 f4 ff ff       	call   80054a <cputchar>
  801122:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801125:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801128:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112b:	01 d0                	add    %edx,%eax
  80112d:	c6 00 00             	movb   $0x0,(%eax)
			return;
  801130:	eb 06                	jmp    801138 <readline+0xfc>
		}
	}
  801132:	e9 3b ff ff ff       	jmp    801072 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801137:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801138:	c9                   	leave  
  801139:	c3                   	ret    

0080113a <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
  80113d:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  801140:	e8 31 0b 00 00       	call   801c76 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801145:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801149:	74 13                	je     80115e <atomic_readline+0x24>
		cprintf("%s", prompt);
  80114b:	83 ec 08             	sub    $0x8,%esp
  80114e:	ff 75 08             	pushl  0x8(%ebp)
  801151:	68 30 2a 80 00       	push   $0x802a30
  801156:	e8 5f f8 ff ff       	call   8009ba <cprintf>
  80115b:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80115e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801165:	83 ec 0c             	sub    $0xc,%esp
  801168:	6a 00                	push   $0x0
  80116a:	e8 71 f4 ff ff       	call   8005e0 <iscons>
  80116f:	83 c4 10             	add    $0x10,%esp
  801172:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801175:	e8 18 f4 ff ff       	call   800592 <getchar>
  80117a:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80117d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801181:	79 23                	jns    8011a6 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801183:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801187:	74 13                	je     80119c <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801189:	83 ec 08             	sub    $0x8,%esp
  80118c:	ff 75 ec             	pushl  -0x14(%ebp)
  80118f:	68 33 2a 80 00       	push   $0x802a33
  801194:	e8 21 f8 ff ff       	call   8009ba <cprintf>
  801199:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80119c:	e8 ef 0a 00 00       	call   801c90 <sys_enable_interrupt>
			return;
  8011a1:	e9 9a 00 00 00       	jmp    801240 <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011a6:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011aa:	7e 34                	jle    8011e0 <atomic_readline+0xa6>
  8011ac:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011b3:	7f 2b                	jg     8011e0 <atomic_readline+0xa6>
			if (echoing)
  8011b5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011b9:	74 0e                	je     8011c9 <atomic_readline+0x8f>
				cputchar(c);
  8011bb:	83 ec 0c             	sub    $0xc,%esp
  8011be:	ff 75 ec             	pushl  -0x14(%ebp)
  8011c1:	e8 84 f3 ff ff       	call   80054a <cputchar>
  8011c6:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011cc:	8d 50 01             	lea    0x1(%eax),%edx
  8011cf:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011d2:	89 c2                	mov    %eax,%edx
  8011d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d7:	01 d0                	add    %edx,%eax
  8011d9:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011dc:	88 10                	mov    %dl,(%eax)
  8011de:	eb 5b                	jmp    80123b <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011e0:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011e4:	75 1f                	jne    801205 <atomic_readline+0xcb>
  8011e6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011ea:	7e 19                	jle    801205 <atomic_readline+0xcb>
			if (echoing)
  8011ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011f0:	74 0e                	je     801200 <atomic_readline+0xc6>
				cputchar(c);
  8011f2:	83 ec 0c             	sub    $0xc,%esp
  8011f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8011f8:	e8 4d f3 ff ff       	call   80054a <cputchar>
  8011fd:	83 c4 10             	add    $0x10,%esp
			i--;
  801200:	ff 4d f4             	decl   -0xc(%ebp)
  801203:	eb 36                	jmp    80123b <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801205:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801209:	74 0a                	je     801215 <atomic_readline+0xdb>
  80120b:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80120f:	0f 85 60 ff ff ff    	jne    801175 <atomic_readline+0x3b>
			if (echoing)
  801215:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801219:	74 0e                	je     801229 <atomic_readline+0xef>
				cputchar(c);
  80121b:	83 ec 0c             	sub    $0xc,%esp
  80121e:	ff 75 ec             	pushl  -0x14(%ebp)
  801221:	e8 24 f3 ff ff       	call   80054a <cputchar>
  801226:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801229:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80122c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80122f:	01 d0                	add    %edx,%eax
  801231:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801234:	e8 57 0a 00 00       	call   801c90 <sys_enable_interrupt>
			return;
  801239:	eb 05                	jmp    801240 <atomic_readline+0x106>
		}
	}
  80123b:	e9 35 ff ff ff       	jmp    801175 <atomic_readline+0x3b>
}
  801240:	c9                   	leave  
  801241:	c3                   	ret    

00801242 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801242:	55                   	push   %ebp
  801243:	89 e5                	mov    %esp,%ebp
  801245:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801248:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80124f:	eb 06                	jmp    801257 <strlen+0x15>
		n++;
  801251:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801254:	ff 45 08             	incl   0x8(%ebp)
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	8a 00                	mov    (%eax),%al
  80125c:	84 c0                	test   %al,%al
  80125e:	75 f1                	jne    801251 <strlen+0xf>
		n++;
	return n;
  801260:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801263:	c9                   	leave  
  801264:	c3                   	ret    

00801265 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801265:	55                   	push   %ebp
  801266:	89 e5                	mov    %esp,%ebp
  801268:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80126b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801272:	eb 09                	jmp    80127d <strnlen+0x18>
		n++;
  801274:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801277:	ff 45 08             	incl   0x8(%ebp)
  80127a:	ff 4d 0c             	decl   0xc(%ebp)
  80127d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801281:	74 09                	je     80128c <strnlen+0x27>
  801283:	8b 45 08             	mov    0x8(%ebp),%eax
  801286:	8a 00                	mov    (%eax),%al
  801288:	84 c0                	test   %al,%al
  80128a:	75 e8                	jne    801274 <strnlen+0xf>
		n++;
	return n;
  80128c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80128f:	c9                   	leave  
  801290:	c3                   	ret    

00801291 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801291:	55                   	push   %ebp
  801292:	89 e5                	mov    %esp,%ebp
  801294:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801297:	8b 45 08             	mov    0x8(%ebp),%eax
  80129a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80129d:	90                   	nop
  80129e:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a1:	8d 50 01             	lea    0x1(%eax),%edx
  8012a4:	89 55 08             	mov    %edx,0x8(%ebp)
  8012a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012aa:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012ad:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012b0:	8a 12                	mov    (%edx),%dl
  8012b2:	88 10                	mov    %dl,(%eax)
  8012b4:	8a 00                	mov    (%eax),%al
  8012b6:	84 c0                	test   %al,%al
  8012b8:	75 e4                	jne    80129e <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
  8012c2:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012cb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012d2:	eb 1f                	jmp    8012f3 <strncpy+0x34>
		*dst++ = *src;
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	8d 50 01             	lea    0x1(%eax),%edx
  8012da:	89 55 08             	mov    %edx,0x8(%ebp)
  8012dd:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012e0:	8a 12                	mov    (%edx),%dl
  8012e2:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012e7:	8a 00                	mov    (%eax),%al
  8012e9:	84 c0                	test   %al,%al
  8012eb:	74 03                	je     8012f0 <strncpy+0x31>
			src++;
  8012ed:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012f0:	ff 45 fc             	incl   -0x4(%ebp)
  8012f3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012f6:	3b 45 10             	cmp    0x10(%ebp),%eax
  8012f9:	72 d9                	jb     8012d4 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8012fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8012fe:	c9                   	leave  
  8012ff:	c3                   	ret    

00801300 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  801300:	55                   	push   %ebp
  801301:	89 e5                	mov    %esp,%ebp
  801303:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801306:	8b 45 08             	mov    0x8(%ebp),%eax
  801309:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80130c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801310:	74 30                	je     801342 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801312:	eb 16                	jmp    80132a <strlcpy+0x2a>
			*dst++ = *src++;
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	8d 50 01             	lea    0x1(%eax),%edx
  80131a:	89 55 08             	mov    %edx,0x8(%ebp)
  80131d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801320:	8d 4a 01             	lea    0x1(%edx),%ecx
  801323:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801326:	8a 12                	mov    (%edx),%dl
  801328:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80132a:	ff 4d 10             	decl   0x10(%ebp)
  80132d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801331:	74 09                	je     80133c <strlcpy+0x3c>
  801333:	8b 45 0c             	mov    0xc(%ebp),%eax
  801336:	8a 00                	mov    (%eax),%al
  801338:	84 c0                	test   %al,%al
  80133a:	75 d8                	jne    801314 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80133c:	8b 45 08             	mov    0x8(%ebp),%eax
  80133f:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801342:	8b 55 08             	mov    0x8(%ebp),%edx
  801345:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801348:	29 c2                	sub    %eax,%edx
  80134a:	89 d0                	mov    %edx,%eax
}
  80134c:	c9                   	leave  
  80134d:	c3                   	ret    

0080134e <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80134e:	55                   	push   %ebp
  80134f:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801351:	eb 06                	jmp    801359 <strcmp+0xb>
		p++, q++;
  801353:	ff 45 08             	incl   0x8(%ebp)
  801356:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801359:	8b 45 08             	mov    0x8(%ebp),%eax
  80135c:	8a 00                	mov    (%eax),%al
  80135e:	84 c0                	test   %al,%al
  801360:	74 0e                	je     801370 <strcmp+0x22>
  801362:	8b 45 08             	mov    0x8(%ebp),%eax
  801365:	8a 10                	mov    (%eax),%dl
  801367:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136a:	8a 00                	mov    (%eax),%al
  80136c:	38 c2                	cmp    %al,%dl
  80136e:	74 e3                	je     801353 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	8a 00                	mov    (%eax),%al
  801375:	0f b6 d0             	movzbl %al,%edx
  801378:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137b:	8a 00                	mov    (%eax),%al
  80137d:	0f b6 c0             	movzbl %al,%eax
  801380:	29 c2                	sub    %eax,%edx
  801382:	89 d0                	mov    %edx,%eax
}
  801384:	5d                   	pop    %ebp
  801385:	c3                   	ret    

00801386 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801386:	55                   	push   %ebp
  801387:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801389:	eb 09                	jmp    801394 <strncmp+0xe>
		n--, p++, q++;
  80138b:	ff 4d 10             	decl   0x10(%ebp)
  80138e:	ff 45 08             	incl   0x8(%ebp)
  801391:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801394:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801398:	74 17                	je     8013b1 <strncmp+0x2b>
  80139a:	8b 45 08             	mov    0x8(%ebp),%eax
  80139d:	8a 00                	mov    (%eax),%al
  80139f:	84 c0                	test   %al,%al
  8013a1:	74 0e                	je     8013b1 <strncmp+0x2b>
  8013a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013a6:	8a 10                	mov    (%eax),%dl
  8013a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	38 c2                	cmp    %al,%dl
  8013af:	74 da                	je     80138b <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013b1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013b5:	75 07                	jne    8013be <strncmp+0x38>
		return 0;
  8013b7:	b8 00 00 00 00       	mov    $0x0,%eax
  8013bc:	eb 14                	jmp    8013d2 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013be:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c1:	8a 00                	mov    (%eax),%al
  8013c3:	0f b6 d0             	movzbl %al,%edx
  8013c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c9:	8a 00                	mov    (%eax),%al
  8013cb:	0f b6 c0             	movzbl %al,%eax
  8013ce:	29 c2                	sub    %eax,%edx
  8013d0:	89 d0                	mov    %edx,%eax
}
  8013d2:	5d                   	pop    %ebp
  8013d3:	c3                   	ret    

008013d4 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013d4:	55                   	push   %ebp
  8013d5:	89 e5                	mov    %esp,%ebp
  8013d7:	83 ec 04             	sub    $0x4,%esp
  8013da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013dd:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013e0:	eb 12                	jmp    8013f4 <strchr+0x20>
		if (*s == c)
  8013e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e5:	8a 00                	mov    (%eax),%al
  8013e7:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013ea:	75 05                	jne    8013f1 <strchr+0x1d>
			return (char *) s;
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	eb 11                	jmp    801402 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013f1:	ff 45 08             	incl   0x8(%ebp)
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8a 00                	mov    (%eax),%al
  8013f9:	84 c0                	test   %al,%al
  8013fb:	75 e5                	jne    8013e2 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8013fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801402:	c9                   	leave  
  801403:	c3                   	ret    

00801404 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801404:	55                   	push   %ebp
  801405:	89 e5                	mov    %esp,%ebp
  801407:	83 ec 04             	sub    $0x4,%esp
  80140a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140d:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801410:	eb 0d                	jmp    80141f <strfind+0x1b>
		if (*s == c)
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	8a 00                	mov    (%eax),%al
  801417:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80141a:	74 0e                	je     80142a <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80141c:	ff 45 08             	incl   0x8(%ebp)
  80141f:	8b 45 08             	mov    0x8(%ebp),%eax
  801422:	8a 00                	mov    (%eax),%al
  801424:	84 c0                	test   %al,%al
  801426:	75 ea                	jne    801412 <strfind+0xe>
  801428:	eb 01                	jmp    80142b <strfind+0x27>
		if (*s == c)
			break;
  80142a:	90                   	nop
	return (char *) s;
  80142b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80142e:	c9                   	leave  
  80142f:	c3                   	ret    

00801430 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801430:	55                   	push   %ebp
  801431:	89 e5                	mov    %esp,%ebp
  801433:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801436:	8b 45 08             	mov    0x8(%ebp),%eax
  801439:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80143c:	8b 45 10             	mov    0x10(%ebp),%eax
  80143f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801442:	eb 0e                	jmp    801452 <memset+0x22>
		*p++ = c;
  801444:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801447:	8d 50 01             	lea    0x1(%eax),%edx
  80144a:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80144d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801450:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801452:	ff 4d f8             	decl   -0x8(%ebp)
  801455:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801459:	79 e9                	jns    801444 <memset+0x14>
		*p++ = c;

	return v;
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80145e:	c9                   	leave  
  80145f:	c3                   	ret    

00801460 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801460:	55                   	push   %ebp
  801461:	89 e5                	mov    %esp,%ebp
  801463:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801466:	8b 45 0c             	mov    0xc(%ebp),%eax
  801469:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801472:	eb 16                	jmp    80148a <memcpy+0x2a>
		*d++ = *s++;
  801474:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801477:	8d 50 01             	lea    0x1(%eax),%edx
  80147a:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80147d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801480:	8d 4a 01             	lea    0x1(%edx),%ecx
  801483:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801486:	8a 12                	mov    (%edx),%dl
  801488:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80148a:	8b 45 10             	mov    0x10(%ebp),%eax
  80148d:	8d 50 ff             	lea    -0x1(%eax),%edx
  801490:	89 55 10             	mov    %edx,0x10(%ebp)
  801493:	85 c0                	test   %eax,%eax
  801495:	75 dd                	jne    801474 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801497:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80149a:	c9                   	leave  
  80149b:	c3                   	ret    

0080149c <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80149c:	55                   	push   %ebp
  80149d:	89 e5                	mov    %esp,%ebp
  80149f:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b1:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014b4:	73 50                	jae    801506 <memmove+0x6a>
  8014b6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014bc:	01 d0                	add    %edx,%eax
  8014be:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014c1:	76 43                	jbe    801506 <memmove+0x6a>
		s += n;
  8014c3:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c6:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8014cc:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014cf:	eb 10                	jmp    8014e1 <memmove+0x45>
			*--d = *--s;
  8014d1:	ff 4d f8             	decl   -0x8(%ebp)
  8014d4:	ff 4d fc             	decl   -0x4(%ebp)
  8014d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014da:	8a 10                	mov    (%eax),%dl
  8014dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014df:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ea:	85 c0                	test   %eax,%eax
  8014ec:	75 e3                	jne    8014d1 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014ee:	eb 23                	jmp    801513 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014f3:	8d 50 01             	lea    0x1(%eax),%edx
  8014f6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014f9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014fc:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ff:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801502:	8a 12                	mov    (%edx),%dl
  801504:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801506:	8b 45 10             	mov    0x10(%ebp),%eax
  801509:	8d 50 ff             	lea    -0x1(%eax),%edx
  80150c:	89 55 10             	mov    %edx,0x10(%ebp)
  80150f:	85 c0                	test   %eax,%eax
  801511:	75 dd                	jne    8014f0 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801516:	c9                   	leave  
  801517:	c3                   	ret    

00801518 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801518:	55                   	push   %ebp
  801519:	89 e5                	mov    %esp,%ebp
  80151b:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80151e:	8b 45 08             	mov    0x8(%ebp),%eax
  801521:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801524:	8b 45 0c             	mov    0xc(%ebp),%eax
  801527:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80152a:	eb 2a                	jmp    801556 <memcmp+0x3e>
		if (*s1 != *s2)
  80152c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80152f:	8a 10                	mov    (%eax),%dl
  801531:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801534:	8a 00                	mov    (%eax),%al
  801536:	38 c2                	cmp    %al,%dl
  801538:	74 16                	je     801550 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80153a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153d:	8a 00                	mov    (%eax),%al
  80153f:	0f b6 d0             	movzbl %al,%edx
  801542:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	0f b6 c0             	movzbl %al,%eax
  80154a:	29 c2                	sub    %eax,%edx
  80154c:	89 d0                	mov    %edx,%eax
  80154e:	eb 18                	jmp    801568 <memcmp+0x50>
		s1++, s2++;
  801550:	ff 45 fc             	incl   -0x4(%ebp)
  801553:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801556:	8b 45 10             	mov    0x10(%ebp),%eax
  801559:	8d 50 ff             	lea    -0x1(%eax),%edx
  80155c:	89 55 10             	mov    %edx,0x10(%ebp)
  80155f:	85 c0                	test   %eax,%eax
  801561:	75 c9                	jne    80152c <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801563:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801568:	c9                   	leave  
  801569:	c3                   	ret    

0080156a <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80156a:	55                   	push   %ebp
  80156b:	89 e5                	mov    %esp,%ebp
  80156d:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801570:	8b 55 08             	mov    0x8(%ebp),%edx
  801573:	8b 45 10             	mov    0x10(%ebp),%eax
  801576:	01 d0                	add    %edx,%eax
  801578:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80157b:	eb 15                	jmp    801592 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80157d:	8b 45 08             	mov    0x8(%ebp),%eax
  801580:	8a 00                	mov    (%eax),%al
  801582:	0f b6 d0             	movzbl %al,%edx
  801585:	8b 45 0c             	mov    0xc(%ebp),%eax
  801588:	0f b6 c0             	movzbl %al,%eax
  80158b:	39 c2                	cmp    %eax,%edx
  80158d:	74 0d                	je     80159c <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80158f:	ff 45 08             	incl   0x8(%ebp)
  801592:	8b 45 08             	mov    0x8(%ebp),%eax
  801595:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801598:	72 e3                	jb     80157d <memfind+0x13>
  80159a:	eb 01                	jmp    80159d <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80159c:	90                   	nop
	return (void *) s;
  80159d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015a0:	c9                   	leave  
  8015a1:	c3                   	ret    

008015a2 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015a2:	55                   	push   %ebp
  8015a3:	89 e5                	mov    %esp,%ebp
  8015a5:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015a8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015af:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015b6:	eb 03                	jmp    8015bb <strtol+0x19>
		s++;
  8015b8:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8015be:	8a 00                	mov    (%eax),%al
  8015c0:	3c 20                	cmp    $0x20,%al
  8015c2:	74 f4                	je     8015b8 <strtol+0x16>
  8015c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c7:	8a 00                	mov    (%eax),%al
  8015c9:	3c 09                	cmp    $0x9,%al
  8015cb:	74 eb                	je     8015b8 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d0:	8a 00                	mov    (%eax),%al
  8015d2:	3c 2b                	cmp    $0x2b,%al
  8015d4:	75 05                	jne    8015db <strtol+0x39>
		s++;
  8015d6:	ff 45 08             	incl   0x8(%ebp)
  8015d9:	eb 13                	jmp    8015ee <strtol+0x4c>
	else if (*s == '-')
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	3c 2d                	cmp    $0x2d,%al
  8015e2:	75 0a                	jne    8015ee <strtol+0x4c>
		s++, neg = 1;
  8015e4:	ff 45 08             	incl   0x8(%ebp)
  8015e7:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f2:	74 06                	je     8015fa <strtol+0x58>
  8015f4:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8015f8:	75 20                	jne    80161a <strtol+0x78>
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	3c 30                	cmp    $0x30,%al
  801601:	75 17                	jne    80161a <strtol+0x78>
  801603:	8b 45 08             	mov    0x8(%ebp),%eax
  801606:	40                   	inc    %eax
  801607:	8a 00                	mov    (%eax),%al
  801609:	3c 78                	cmp    $0x78,%al
  80160b:	75 0d                	jne    80161a <strtol+0x78>
		s += 2, base = 16;
  80160d:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801611:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801618:	eb 28                	jmp    801642 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80161a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80161e:	75 15                	jne    801635 <strtol+0x93>
  801620:	8b 45 08             	mov    0x8(%ebp),%eax
  801623:	8a 00                	mov    (%eax),%al
  801625:	3c 30                	cmp    $0x30,%al
  801627:	75 0c                	jne    801635 <strtol+0x93>
		s++, base = 8;
  801629:	ff 45 08             	incl   0x8(%ebp)
  80162c:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801633:	eb 0d                	jmp    801642 <strtol+0xa0>
	else if (base == 0)
  801635:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801639:	75 07                	jne    801642 <strtol+0xa0>
		base = 10;
  80163b:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801642:	8b 45 08             	mov    0x8(%ebp),%eax
  801645:	8a 00                	mov    (%eax),%al
  801647:	3c 2f                	cmp    $0x2f,%al
  801649:	7e 19                	jle    801664 <strtol+0xc2>
  80164b:	8b 45 08             	mov    0x8(%ebp),%eax
  80164e:	8a 00                	mov    (%eax),%al
  801650:	3c 39                	cmp    $0x39,%al
  801652:	7f 10                	jg     801664 <strtol+0xc2>
			dig = *s - '0';
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	8a 00                	mov    (%eax),%al
  801659:	0f be c0             	movsbl %al,%eax
  80165c:	83 e8 30             	sub    $0x30,%eax
  80165f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801662:	eb 42                	jmp    8016a6 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801664:	8b 45 08             	mov    0x8(%ebp),%eax
  801667:	8a 00                	mov    (%eax),%al
  801669:	3c 60                	cmp    $0x60,%al
  80166b:	7e 19                	jle    801686 <strtol+0xe4>
  80166d:	8b 45 08             	mov    0x8(%ebp),%eax
  801670:	8a 00                	mov    (%eax),%al
  801672:	3c 7a                	cmp    $0x7a,%al
  801674:	7f 10                	jg     801686 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801676:	8b 45 08             	mov    0x8(%ebp),%eax
  801679:	8a 00                	mov    (%eax),%al
  80167b:	0f be c0             	movsbl %al,%eax
  80167e:	83 e8 57             	sub    $0x57,%eax
  801681:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801684:	eb 20                	jmp    8016a6 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801686:	8b 45 08             	mov    0x8(%ebp),%eax
  801689:	8a 00                	mov    (%eax),%al
  80168b:	3c 40                	cmp    $0x40,%al
  80168d:	7e 39                	jle    8016c8 <strtol+0x126>
  80168f:	8b 45 08             	mov    0x8(%ebp),%eax
  801692:	8a 00                	mov    (%eax),%al
  801694:	3c 5a                	cmp    $0x5a,%al
  801696:	7f 30                	jg     8016c8 <strtol+0x126>
			dig = *s - 'A' + 10;
  801698:	8b 45 08             	mov    0x8(%ebp),%eax
  80169b:	8a 00                	mov    (%eax),%al
  80169d:	0f be c0             	movsbl %al,%eax
  8016a0:	83 e8 37             	sub    $0x37,%eax
  8016a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016a9:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016ac:	7d 19                	jge    8016c7 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016ae:	ff 45 08             	incl   0x8(%ebp)
  8016b1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b4:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016b8:	89 c2                	mov    %eax,%edx
  8016ba:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016bd:	01 d0                	add    %edx,%eax
  8016bf:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016c2:	e9 7b ff ff ff       	jmp    801642 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016c7:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016cc:	74 08                	je     8016d6 <strtol+0x134>
		*endptr = (char *) s;
  8016ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d1:	8b 55 08             	mov    0x8(%ebp),%edx
  8016d4:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016d6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016da:	74 07                	je     8016e3 <strtol+0x141>
  8016dc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016df:	f7 d8                	neg    %eax
  8016e1:	eb 03                	jmp    8016e6 <strtol+0x144>
  8016e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016e6:	c9                   	leave  
  8016e7:	c3                   	ret    

008016e8 <ltostr>:

void
ltostr(long value, char *str)
{
  8016e8:	55                   	push   %ebp
  8016e9:	89 e5                	mov    %esp,%ebp
  8016eb:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016ee:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8016f5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8016fc:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801700:	79 13                	jns    801715 <ltostr+0x2d>
	{
		neg = 1;
  801702:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801709:	8b 45 0c             	mov    0xc(%ebp),%eax
  80170c:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80170f:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801712:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801715:	8b 45 08             	mov    0x8(%ebp),%eax
  801718:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80171d:	99                   	cltd   
  80171e:	f7 f9                	idiv   %ecx
  801720:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801723:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801726:	8d 50 01             	lea    0x1(%eax),%edx
  801729:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80172c:	89 c2                	mov    %eax,%edx
  80172e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801731:	01 d0                	add    %edx,%eax
  801733:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801736:	83 c2 30             	add    $0x30,%edx
  801739:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80173b:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80173e:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801743:	f7 e9                	imul   %ecx
  801745:	c1 fa 02             	sar    $0x2,%edx
  801748:	89 c8                	mov    %ecx,%eax
  80174a:	c1 f8 1f             	sar    $0x1f,%eax
  80174d:	29 c2                	sub    %eax,%edx
  80174f:	89 d0                	mov    %edx,%eax
  801751:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801754:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801757:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80175c:	f7 e9                	imul   %ecx
  80175e:	c1 fa 02             	sar    $0x2,%edx
  801761:	89 c8                	mov    %ecx,%eax
  801763:	c1 f8 1f             	sar    $0x1f,%eax
  801766:	29 c2                	sub    %eax,%edx
  801768:	89 d0                	mov    %edx,%eax
  80176a:	c1 e0 02             	shl    $0x2,%eax
  80176d:	01 d0                	add    %edx,%eax
  80176f:	01 c0                	add    %eax,%eax
  801771:	29 c1                	sub    %eax,%ecx
  801773:	89 ca                	mov    %ecx,%edx
  801775:	85 d2                	test   %edx,%edx
  801777:	75 9c                	jne    801715 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801779:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801780:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801783:	48                   	dec    %eax
  801784:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801787:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80178b:	74 3d                	je     8017ca <ltostr+0xe2>
		start = 1 ;
  80178d:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801794:	eb 34                	jmp    8017ca <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801796:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801799:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179c:	01 d0                	add    %edx,%eax
  80179e:	8a 00                	mov    (%eax),%al
  8017a0:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017a9:	01 c2                	add    %eax,%edx
  8017ab:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b1:	01 c8                	add    %ecx,%eax
  8017b3:	8a 00                	mov    (%eax),%al
  8017b5:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017b7:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bd:	01 c2                	add    %eax,%edx
  8017bf:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017c2:	88 02                	mov    %al,(%edx)
		start++ ;
  8017c4:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017c7:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017cd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017d0:	7c c4                	jl     801796 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017d2:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017d8:	01 d0                	add    %edx,%eax
  8017da:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017dd:	90                   	nop
  8017de:	c9                   	leave  
  8017df:	c3                   	ret    

008017e0 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017e0:	55                   	push   %ebp
  8017e1:	89 e5                	mov    %esp,%ebp
  8017e3:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017e6:	ff 75 08             	pushl  0x8(%ebp)
  8017e9:	e8 54 fa ff ff       	call   801242 <strlen>
  8017ee:	83 c4 04             	add    $0x4,%esp
  8017f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8017f4:	ff 75 0c             	pushl  0xc(%ebp)
  8017f7:	e8 46 fa ff ff       	call   801242 <strlen>
  8017fc:	83 c4 04             	add    $0x4,%esp
  8017ff:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801802:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801809:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801810:	eb 17                	jmp    801829 <strcconcat+0x49>
		final[s] = str1[s] ;
  801812:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801815:	8b 45 10             	mov    0x10(%ebp),%eax
  801818:	01 c2                	add    %eax,%edx
  80181a:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	01 c8                	add    %ecx,%eax
  801822:	8a 00                	mov    (%eax),%al
  801824:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801826:	ff 45 fc             	incl   -0x4(%ebp)
  801829:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80182c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80182f:	7c e1                	jl     801812 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801831:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801838:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80183f:	eb 1f                	jmp    801860 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801841:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801844:	8d 50 01             	lea    0x1(%eax),%edx
  801847:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80184a:	89 c2                	mov    %eax,%edx
  80184c:	8b 45 10             	mov    0x10(%ebp),%eax
  80184f:	01 c2                	add    %eax,%edx
  801851:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801854:	8b 45 0c             	mov    0xc(%ebp),%eax
  801857:	01 c8                	add    %ecx,%eax
  801859:	8a 00                	mov    (%eax),%al
  80185b:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80185d:	ff 45 f8             	incl   -0x8(%ebp)
  801860:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801863:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801866:	7c d9                	jl     801841 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801868:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80186b:	8b 45 10             	mov    0x10(%ebp),%eax
  80186e:	01 d0                	add    %edx,%eax
  801870:	c6 00 00             	movb   $0x0,(%eax)
}
  801873:	90                   	nop
  801874:	c9                   	leave  
  801875:	c3                   	ret    

00801876 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801876:	55                   	push   %ebp
  801877:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801879:	8b 45 14             	mov    0x14(%ebp),%eax
  80187c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801882:	8b 45 14             	mov    0x14(%ebp),%eax
  801885:	8b 00                	mov    (%eax),%eax
  801887:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80188e:	8b 45 10             	mov    0x10(%ebp),%eax
  801891:	01 d0                	add    %edx,%eax
  801893:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801899:	eb 0c                	jmp    8018a7 <strsplit+0x31>
			*string++ = 0;
  80189b:	8b 45 08             	mov    0x8(%ebp),%eax
  80189e:	8d 50 01             	lea    0x1(%eax),%edx
  8018a1:	89 55 08             	mov    %edx,0x8(%ebp)
  8018a4:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018aa:	8a 00                	mov    (%eax),%al
  8018ac:	84 c0                	test   %al,%al
  8018ae:	74 18                	je     8018c8 <strsplit+0x52>
  8018b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b3:	8a 00                	mov    (%eax),%al
  8018b5:	0f be c0             	movsbl %al,%eax
  8018b8:	50                   	push   %eax
  8018b9:	ff 75 0c             	pushl  0xc(%ebp)
  8018bc:	e8 13 fb ff ff       	call   8013d4 <strchr>
  8018c1:	83 c4 08             	add    $0x8,%esp
  8018c4:	85 c0                	test   %eax,%eax
  8018c6:	75 d3                	jne    80189b <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8018cb:	8a 00                	mov    (%eax),%al
  8018cd:	84 c0                	test   %al,%al
  8018cf:	74 5a                	je     80192b <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018d1:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d4:	8b 00                	mov    (%eax),%eax
  8018d6:	83 f8 0f             	cmp    $0xf,%eax
  8018d9:	75 07                	jne    8018e2 <strsplit+0x6c>
		{
			return 0;
  8018db:	b8 00 00 00 00       	mov    $0x0,%eax
  8018e0:	eb 66                	jmp    801948 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018e2:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e5:	8b 00                	mov    (%eax),%eax
  8018e7:	8d 48 01             	lea    0x1(%eax),%ecx
  8018ea:	8b 55 14             	mov    0x14(%ebp),%edx
  8018ed:	89 0a                	mov    %ecx,(%edx)
  8018ef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018f9:	01 c2                	add    %eax,%edx
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801900:	eb 03                	jmp    801905 <strsplit+0x8f>
			string++;
  801902:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801905:	8b 45 08             	mov    0x8(%ebp),%eax
  801908:	8a 00                	mov    (%eax),%al
  80190a:	84 c0                	test   %al,%al
  80190c:	74 8b                	je     801899 <strsplit+0x23>
  80190e:	8b 45 08             	mov    0x8(%ebp),%eax
  801911:	8a 00                	mov    (%eax),%al
  801913:	0f be c0             	movsbl %al,%eax
  801916:	50                   	push   %eax
  801917:	ff 75 0c             	pushl  0xc(%ebp)
  80191a:	e8 b5 fa ff ff       	call   8013d4 <strchr>
  80191f:	83 c4 08             	add    $0x8,%esp
  801922:	85 c0                	test   %eax,%eax
  801924:	74 dc                	je     801902 <strsplit+0x8c>
			string++;
	}
  801926:	e9 6e ff ff ff       	jmp    801899 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80192b:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80192c:	8b 45 14             	mov    0x14(%ebp),%eax
  80192f:	8b 00                	mov    (%eax),%eax
  801931:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801938:	8b 45 10             	mov    0x10(%ebp),%eax
  80193b:	01 d0                	add    %edx,%eax
  80193d:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801943:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801948:	c9                   	leave  
  801949:	c3                   	ret    

0080194a <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  80194a:	55                   	push   %ebp
  80194b:	89 e5                	mov    %esp,%ebp
  80194d:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801950:	83 ec 04             	sub    $0x4,%esp
  801953:	68 44 2a 80 00       	push   $0x802a44
  801958:	6a 15                	push   $0x15
  80195a:	68 69 2a 80 00       	push   $0x802a69
  80195f:	e8 a2 ed ff ff       	call   800706 <_panic>

00801964 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801964:	55                   	push   %ebp
  801965:	89 e5                	mov    %esp,%ebp
  801967:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  80196a:	83 ec 04             	sub    $0x4,%esp
  80196d:	68 78 2a 80 00       	push   $0x802a78
  801972:	6a 2e                	push   $0x2e
  801974:	68 69 2a 80 00       	push   $0x802a69
  801979:	e8 88 ed ff ff       	call   800706 <_panic>

0080197e <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80197e:	55                   	push   %ebp
  80197f:	89 e5                	mov    %esp,%ebp
  801981:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801984:	83 ec 04             	sub    $0x4,%esp
  801987:	68 9c 2a 80 00       	push   $0x802a9c
  80198c:	6a 4c                	push   $0x4c
  80198e:	68 69 2a 80 00       	push   $0x802a69
  801993:	e8 6e ed ff ff       	call   800706 <_panic>

00801998 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801998:	55                   	push   %ebp
  801999:	89 e5                	mov    %esp,%ebp
  80199b:	83 ec 18             	sub    $0x18,%esp
  80199e:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a1:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8019a4:	83 ec 04             	sub    $0x4,%esp
  8019a7:	68 9c 2a 80 00       	push   $0x802a9c
  8019ac:	6a 57                	push   $0x57
  8019ae:	68 69 2a 80 00       	push   $0x802a69
  8019b3:	e8 4e ed ff ff       	call   800706 <_panic>

008019b8 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019b8:	55                   	push   %ebp
  8019b9:	89 e5                	mov    %esp,%ebp
  8019bb:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019be:	83 ec 04             	sub    $0x4,%esp
  8019c1:	68 9c 2a 80 00       	push   $0x802a9c
  8019c6:	6a 5d                	push   $0x5d
  8019c8:	68 69 2a 80 00       	push   $0x802a69
  8019cd:	e8 34 ed ff ff       	call   800706 <_panic>

008019d2 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
  8019d5:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019d8:	83 ec 04             	sub    $0x4,%esp
  8019db:	68 9c 2a 80 00       	push   $0x802a9c
  8019e0:	6a 63                	push   $0x63
  8019e2:	68 69 2a 80 00       	push   $0x802a69
  8019e7:	e8 1a ed ff ff       	call   800706 <_panic>

008019ec <expand>:
}

void expand(uint32 newSize)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
  8019ef:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019f2:	83 ec 04             	sub    $0x4,%esp
  8019f5:	68 9c 2a 80 00       	push   $0x802a9c
  8019fa:	6a 68                	push   $0x68
  8019fc:	68 69 2a 80 00       	push   $0x802a69
  801a01:	e8 00 ed ff ff       	call   800706 <_panic>

00801a06 <shrink>:
}
void shrink(uint32 newSize)
{
  801a06:	55                   	push   %ebp
  801a07:	89 e5                	mov    %esp,%ebp
  801a09:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a0c:	83 ec 04             	sub    $0x4,%esp
  801a0f:	68 9c 2a 80 00       	push   $0x802a9c
  801a14:	6a 6c                	push   $0x6c
  801a16:	68 69 2a 80 00       	push   $0x802a69
  801a1b:	e8 e6 ec ff ff       	call   800706 <_panic>

00801a20 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801a20:	55                   	push   %ebp
  801a21:	89 e5                	mov    %esp,%ebp
  801a23:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a26:	83 ec 04             	sub    $0x4,%esp
  801a29:	68 9c 2a 80 00       	push   $0x802a9c
  801a2e:	6a 71                	push   $0x71
  801a30:	68 69 2a 80 00       	push   $0x802a69
  801a35:	e8 cc ec ff ff       	call   800706 <_panic>

00801a3a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a3a:	55                   	push   %ebp
  801a3b:	89 e5                	mov    %esp,%ebp
  801a3d:	57                   	push   %edi
  801a3e:	56                   	push   %esi
  801a3f:	53                   	push   %ebx
  801a40:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a43:	8b 45 08             	mov    0x8(%ebp),%eax
  801a46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a49:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a4c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a4f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a52:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a55:	cd 30                	int    $0x30
  801a57:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a5d:	83 c4 10             	add    $0x10,%esp
  801a60:	5b                   	pop    %ebx
  801a61:	5e                   	pop    %esi
  801a62:	5f                   	pop    %edi
  801a63:	5d                   	pop    %ebp
  801a64:	c3                   	ret    

00801a65 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a65:	55                   	push   %ebp
  801a66:	89 e5                	mov    %esp,%ebp
  801a68:	83 ec 04             	sub    $0x4,%esp
  801a6b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a6e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a71:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a75:	8b 45 08             	mov    0x8(%ebp),%eax
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	52                   	push   %edx
  801a7d:	ff 75 0c             	pushl  0xc(%ebp)
  801a80:	50                   	push   %eax
  801a81:	6a 00                	push   $0x0
  801a83:	e8 b2 ff ff ff       	call   801a3a <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
}
  801a8b:	90                   	nop
  801a8c:	c9                   	leave  
  801a8d:	c3                   	ret    

00801a8e <sys_cgetc>:

int
sys_cgetc(void)
{
  801a8e:	55                   	push   %ebp
  801a8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	6a 00                	push   $0x0
  801a99:	6a 00                	push   $0x0
  801a9b:	6a 01                	push   $0x1
  801a9d:	e8 98 ff ff ff       	call   801a3a <syscall>
  801aa2:	83 c4 18             	add    $0x18,%esp
}
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801aaa:	8b 45 08             	mov    0x8(%ebp),%eax
  801aad:	6a 00                	push   $0x0
  801aaf:	6a 00                	push   $0x0
  801ab1:	6a 00                	push   $0x0
  801ab3:	6a 00                	push   $0x0
  801ab5:	50                   	push   %eax
  801ab6:	6a 05                	push   $0x5
  801ab8:	e8 7d ff ff ff       	call   801a3a <syscall>
  801abd:	83 c4 18             	add    $0x18,%esp
}
  801ac0:	c9                   	leave  
  801ac1:	c3                   	ret    

00801ac2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ac2:	55                   	push   %ebp
  801ac3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ac5:	6a 00                	push   $0x0
  801ac7:	6a 00                	push   $0x0
  801ac9:	6a 00                	push   $0x0
  801acb:	6a 00                	push   $0x0
  801acd:	6a 00                	push   $0x0
  801acf:	6a 02                	push   $0x2
  801ad1:	e8 64 ff ff ff       	call   801a3a <syscall>
  801ad6:	83 c4 18             	add    $0x18,%esp
}
  801ad9:	c9                   	leave  
  801ada:	c3                   	ret    

00801adb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801adb:	55                   	push   %ebp
  801adc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801ade:	6a 00                	push   $0x0
  801ae0:	6a 00                	push   $0x0
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 03                	push   $0x3
  801aea:	e8 4b ff ff ff       	call   801a3a <syscall>
  801aef:	83 c4 18             	add    $0x18,%esp
}
  801af2:	c9                   	leave  
  801af3:	c3                   	ret    

00801af4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801af4:	55                   	push   %ebp
  801af5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801af7:	6a 00                	push   $0x0
  801af9:	6a 00                	push   $0x0
  801afb:	6a 00                	push   $0x0
  801afd:	6a 00                	push   $0x0
  801aff:	6a 00                	push   $0x0
  801b01:	6a 04                	push   $0x4
  801b03:	e8 32 ff ff ff       	call   801a3a <syscall>
  801b08:	83 c4 18             	add    $0x18,%esp
}
  801b0b:	c9                   	leave  
  801b0c:	c3                   	ret    

00801b0d <sys_env_exit>:


void sys_env_exit(void)
{
  801b0d:	55                   	push   %ebp
  801b0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b10:	6a 00                	push   $0x0
  801b12:	6a 00                	push   $0x0
  801b14:	6a 00                	push   $0x0
  801b16:	6a 00                	push   $0x0
  801b18:	6a 00                	push   $0x0
  801b1a:	6a 06                	push   $0x6
  801b1c:	e8 19 ff ff ff       	call   801a3a <syscall>
  801b21:	83 c4 18             	add    $0x18,%esp
}
  801b24:	90                   	nop
  801b25:	c9                   	leave  
  801b26:	c3                   	ret    

00801b27 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b27:	55                   	push   %ebp
  801b28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b30:	6a 00                	push   $0x0
  801b32:	6a 00                	push   $0x0
  801b34:	6a 00                	push   $0x0
  801b36:	52                   	push   %edx
  801b37:	50                   	push   %eax
  801b38:	6a 07                	push   $0x7
  801b3a:	e8 fb fe ff ff       	call   801a3a <syscall>
  801b3f:	83 c4 18             	add    $0x18,%esp
}
  801b42:	c9                   	leave  
  801b43:	c3                   	ret    

00801b44 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b44:	55                   	push   %ebp
  801b45:	89 e5                	mov    %esp,%ebp
  801b47:	56                   	push   %esi
  801b48:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b49:	8b 75 18             	mov    0x18(%ebp),%esi
  801b4c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b4f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b55:	8b 45 08             	mov    0x8(%ebp),%eax
  801b58:	56                   	push   %esi
  801b59:	53                   	push   %ebx
  801b5a:	51                   	push   %ecx
  801b5b:	52                   	push   %edx
  801b5c:	50                   	push   %eax
  801b5d:	6a 08                	push   $0x8
  801b5f:	e8 d6 fe ff ff       	call   801a3a <syscall>
  801b64:	83 c4 18             	add    $0x18,%esp
}
  801b67:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b6a:	5b                   	pop    %ebx
  801b6b:	5e                   	pop    %esi
  801b6c:	5d                   	pop    %ebp
  801b6d:	c3                   	ret    

00801b6e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b6e:	55                   	push   %ebp
  801b6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b74:	8b 45 08             	mov    0x8(%ebp),%eax
  801b77:	6a 00                	push   $0x0
  801b79:	6a 00                	push   $0x0
  801b7b:	6a 00                	push   $0x0
  801b7d:	52                   	push   %edx
  801b7e:	50                   	push   %eax
  801b7f:	6a 09                	push   $0x9
  801b81:	e8 b4 fe ff ff       	call   801a3a <syscall>
  801b86:	83 c4 18             	add    $0x18,%esp
}
  801b89:	c9                   	leave  
  801b8a:	c3                   	ret    

00801b8b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b8b:	55                   	push   %ebp
  801b8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b8e:	6a 00                	push   $0x0
  801b90:	6a 00                	push   $0x0
  801b92:	6a 00                	push   $0x0
  801b94:	ff 75 0c             	pushl  0xc(%ebp)
  801b97:	ff 75 08             	pushl  0x8(%ebp)
  801b9a:	6a 0a                	push   $0xa
  801b9c:	e8 99 fe ff ff       	call   801a3a <syscall>
  801ba1:	83 c4 18             	add    $0x18,%esp
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 0b                	push   $0xb
  801bb5:	e8 80 fe ff ff       	call   801a3a <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
}
  801bbd:	c9                   	leave  
  801bbe:	c3                   	ret    

00801bbf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bbf:	55                   	push   %ebp
  801bc0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bc2:	6a 00                	push   $0x0
  801bc4:	6a 00                	push   $0x0
  801bc6:	6a 00                	push   $0x0
  801bc8:	6a 00                	push   $0x0
  801bca:	6a 00                	push   $0x0
  801bcc:	6a 0c                	push   $0xc
  801bce:	e8 67 fe ff ff       	call   801a3a <syscall>
  801bd3:	83 c4 18             	add    $0x18,%esp
}
  801bd6:	c9                   	leave  
  801bd7:	c3                   	ret    

00801bd8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801bd8:	55                   	push   %ebp
  801bd9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	6a 00                	push   $0x0
  801be3:	6a 00                	push   $0x0
  801be5:	6a 0d                	push   $0xd
  801be7:	e8 4e fe ff ff       	call   801a3a <syscall>
  801bec:	83 c4 18             	add    $0x18,%esp
}
  801bef:	c9                   	leave  
  801bf0:	c3                   	ret    

00801bf1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bf1:	55                   	push   %ebp
  801bf2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801bf4:	6a 00                	push   $0x0
  801bf6:	6a 00                	push   $0x0
  801bf8:	6a 00                	push   $0x0
  801bfa:	ff 75 0c             	pushl  0xc(%ebp)
  801bfd:	ff 75 08             	pushl  0x8(%ebp)
  801c00:	6a 11                	push   $0x11
  801c02:	e8 33 fe ff ff       	call   801a3a <syscall>
  801c07:	83 c4 18             	add    $0x18,%esp
	return;
  801c0a:	90                   	nop
}
  801c0b:	c9                   	leave  
  801c0c:	c3                   	ret    

00801c0d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c0d:	55                   	push   %ebp
  801c0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 00                	push   $0x0
  801c16:	ff 75 0c             	pushl  0xc(%ebp)
  801c19:	ff 75 08             	pushl  0x8(%ebp)
  801c1c:	6a 12                	push   $0x12
  801c1e:	e8 17 fe ff ff       	call   801a3a <syscall>
  801c23:	83 c4 18             	add    $0x18,%esp
	return ;
  801c26:	90                   	nop
}
  801c27:	c9                   	leave  
  801c28:	c3                   	ret    

00801c29 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c29:	55                   	push   %ebp
  801c2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c2c:	6a 00                	push   $0x0
  801c2e:	6a 00                	push   $0x0
  801c30:	6a 00                	push   $0x0
  801c32:	6a 00                	push   $0x0
  801c34:	6a 00                	push   $0x0
  801c36:	6a 0e                	push   $0xe
  801c38:	e8 fd fd ff ff       	call   801a3a <syscall>
  801c3d:	83 c4 18             	add    $0x18,%esp
}
  801c40:	c9                   	leave  
  801c41:	c3                   	ret    

00801c42 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c42:	55                   	push   %ebp
  801c43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c45:	6a 00                	push   $0x0
  801c47:	6a 00                	push   $0x0
  801c49:	6a 00                	push   $0x0
  801c4b:	6a 00                	push   $0x0
  801c4d:	ff 75 08             	pushl  0x8(%ebp)
  801c50:	6a 0f                	push   $0xf
  801c52:	e8 e3 fd ff ff       	call   801a3a <syscall>
  801c57:	83 c4 18             	add    $0x18,%esp
}
  801c5a:	c9                   	leave  
  801c5b:	c3                   	ret    

00801c5c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c5c:	55                   	push   %ebp
  801c5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c5f:	6a 00                	push   $0x0
  801c61:	6a 00                	push   $0x0
  801c63:	6a 00                	push   $0x0
  801c65:	6a 00                	push   $0x0
  801c67:	6a 00                	push   $0x0
  801c69:	6a 10                	push   $0x10
  801c6b:	e8 ca fd ff ff       	call   801a3a <syscall>
  801c70:	83 c4 18             	add    $0x18,%esp
}
  801c73:	90                   	nop
  801c74:	c9                   	leave  
  801c75:	c3                   	ret    

00801c76 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c76:	55                   	push   %ebp
  801c77:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c79:	6a 00                	push   $0x0
  801c7b:	6a 00                	push   $0x0
  801c7d:	6a 00                	push   $0x0
  801c7f:	6a 00                	push   $0x0
  801c81:	6a 00                	push   $0x0
  801c83:	6a 14                	push   $0x14
  801c85:	e8 b0 fd ff ff       	call   801a3a <syscall>
  801c8a:	83 c4 18             	add    $0x18,%esp
}
  801c8d:	90                   	nop
  801c8e:	c9                   	leave  
  801c8f:	c3                   	ret    

00801c90 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c90:	55                   	push   %ebp
  801c91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801c93:	6a 00                	push   $0x0
  801c95:	6a 00                	push   $0x0
  801c97:	6a 00                	push   $0x0
  801c99:	6a 00                	push   $0x0
  801c9b:	6a 00                	push   $0x0
  801c9d:	6a 15                	push   $0x15
  801c9f:	e8 96 fd ff ff       	call   801a3a <syscall>
  801ca4:	83 c4 18             	add    $0x18,%esp
}
  801ca7:	90                   	nop
  801ca8:	c9                   	leave  
  801ca9:	c3                   	ret    

00801caa <sys_cputc>:


void
sys_cputc(const char c)
{
  801caa:	55                   	push   %ebp
  801cab:	89 e5                	mov    %esp,%ebp
  801cad:	83 ec 04             	sub    $0x4,%esp
  801cb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cb6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 00                	push   $0x0
  801cc2:	50                   	push   %eax
  801cc3:	6a 16                	push   $0x16
  801cc5:	e8 70 fd ff ff       	call   801a3a <syscall>
  801cca:	83 c4 18             	add    $0x18,%esp
}
  801ccd:	90                   	nop
  801cce:	c9                   	leave  
  801ccf:	c3                   	ret    

00801cd0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cd0:	55                   	push   %ebp
  801cd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 17                	push   $0x17
  801cdf:	e8 56 fd ff ff       	call   801a3a <syscall>
  801ce4:	83 c4 18             	add    $0x18,%esp
}
  801ce7:	90                   	nop
  801ce8:	c9                   	leave  
  801ce9:	c3                   	ret    

00801cea <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ced:	8b 45 08             	mov    0x8(%ebp),%eax
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	ff 75 0c             	pushl  0xc(%ebp)
  801cf9:	50                   	push   %eax
  801cfa:	6a 18                	push   $0x18
  801cfc:	e8 39 fd ff ff       	call   801a3a <syscall>
  801d01:	83 c4 18             	add    $0x18,%esp
}
  801d04:	c9                   	leave  
  801d05:	c3                   	ret    

00801d06 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d06:	55                   	push   %ebp
  801d07:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d09:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	52                   	push   %edx
  801d16:	50                   	push   %eax
  801d17:	6a 1b                	push   $0x1b
  801d19:	e8 1c fd ff ff       	call   801a3a <syscall>
  801d1e:	83 c4 18             	add    $0x18,%esp
}
  801d21:	c9                   	leave  
  801d22:	c3                   	ret    

00801d23 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d23:	55                   	push   %ebp
  801d24:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d26:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d29:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2c:	6a 00                	push   $0x0
  801d2e:	6a 00                	push   $0x0
  801d30:	6a 00                	push   $0x0
  801d32:	52                   	push   %edx
  801d33:	50                   	push   %eax
  801d34:	6a 19                	push   $0x19
  801d36:	e8 ff fc ff ff       	call   801a3a <syscall>
  801d3b:	83 c4 18             	add    $0x18,%esp
}
  801d3e:	90                   	nop
  801d3f:	c9                   	leave  
  801d40:	c3                   	ret    

00801d41 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d41:	55                   	push   %ebp
  801d42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d44:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d47:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	52                   	push   %edx
  801d51:	50                   	push   %eax
  801d52:	6a 1a                	push   $0x1a
  801d54:	e8 e1 fc ff ff       	call   801a3a <syscall>
  801d59:	83 c4 18             	add    $0x18,%esp
}
  801d5c:	90                   	nop
  801d5d:	c9                   	leave  
  801d5e:	c3                   	ret    

00801d5f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d5f:	55                   	push   %ebp
  801d60:	89 e5                	mov    %esp,%ebp
  801d62:	83 ec 04             	sub    $0x4,%esp
  801d65:	8b 45 10             	mov    0x10(%ebp),%eax
  801d68:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d6b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d6e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d72:	8b 45 08             	mov    0x8(%ebp),%eax
  801d75:	6a 00                	push   $0x0
  801d77:	51                   	push   %ecx
  801d78:	52                   	push   %edx
  801d79:	ff 75 0c             	pushl  0xc(%ebp)
  801d7c:	50                   	push   %eax
  801d7d:	6a 1c                	push   $0x1c
  801d7f:	e8 b6 fc ff ff       	call   801a3a <syscall>
  801d84:	83 c4 18             	add    $0x18,%esp
}
  801d87:	c9                   	leave  
  801d88:	c3                   	ret    

00801d89 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d89:	55                   	push   %ebp
  801d8a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d8f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d92:	6a 00                	push   $0x0
  801d94:	6a 00                	push   $0x0
  801d96:	6a 00                	push   $0x0
  801d98:	52                   	push   %edx
  801d99:	50                   	push   %eax
  801d9a:	6a 1d                	push   $0x1d
  801d9c:	e8 99 fc ff ff       	call   801a3a <syscall>
  801da1:	83 c4 18             	add    $0x18,%esp
}
  801da4:	c9                   	leave  
  801da5:	c3                   	ret    

00801da6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801da6:	55                   	push   %ebp
  801da7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801da9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dac:	8b 55 0c             	mov    0xc(%ebp),%edx
  801daf:	8b 45 08             	mov    0x8(%ebp),%eax
  801db2:	6a 00                	push   $0x0
  801db4:	6a 00                	push   $0x0
  801db6:	51                   	push   %ecx
  801db7:	52                   	push   %edx
  801db8:	50                   	push   %eax
  801db9:	6a 1e                	push   $0x1e
  801dbb:	e8 7a fc ff ff       	call   801a3a <syscall>
  801dc0:	83 c4 18             	add    $0x18,%esp
}
  801dc3:	c9                   	leave  
  801dc4:	c3                   	ret    

00801dc5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801dc5:	55                   	push   %ebp
  801dc6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801dc8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dcb:	8b 45 08             	mov    0x8(%ebp),%eax
  801dce:	6a 00                	push   $0x0
  801dd0:	6a 00                	push   $0x0
  801dd2:	6a 00                	push   $0x0
  801dd4:	52                   	push   %edx
  801dd5:	50                   	push   %eax
  801dd6:	6a 1f                	push   $0x1f
  801dd8:	e8 5d fc ff ff       	call   801a3a <syscall>
  801ddd:	83 c4 18             	add    $0x18,%esp
}
  801de0:	c9                   	leave  
  801de1:	c3                   	ret    

00801de2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801de2:	55                   	push   %ebp
  801de3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	6a 00                	push   $0x0
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 20                	push   $0x20
  801df1:	e8 44 fc ff ff       	call   801a3a <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
}
  801df9:	c9                   	leave  
  801dfa:	c3                   	ret    

00801dfb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801dfb:	55                   	push   %ebp
  801dfc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801dfe:	8b 45 08             	mov    0x8(%ebp),%eax
  801e01:	6a 00                	push   $0x0
  801e03:	ff 75 14             	pushl  0x14(%ebp)
  801e06:	ff 75 10             	pushl  0x10(%ebp)
  801e09:	ff 75 0c             	pushl  0xc(%ebp)
  801e0c:	50                   	push   %eax
  801e0d:	6a 21                	push   $0x21
  801e0f:	e8 26 fc ff ff       	call   801a3a <syscall>
  801e14:	83 c4 18             	add    $0x18,%esp
}
  801e17:	c9                   	leave  
  801e18:	c3                   	ret    

00801e19 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801e19:	55                   	push   %ebp
  801e1a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1f:	6a 00                	push   $0x0
  801e21:	6a 00                	push   $0x0
  801e23:	6a 00                	push   $0x0
  801e25:	6a 00                	push   $0x0
  801e27:	50                   	push   %eax
  801e28:	6a 22                	push   $0x22
  801e2a:	e8 0b fc ff ff       	call   801a3a <syscall>
  801e2f:	83 c4 18             	add    $0x18,%esp
}
  801e32:	90                   	nop
  801e33:	c9                   	leave  
  801e34:	c3                   	ret    

00801e35 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e35:	55                   	push   %ebp
  801e36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e38:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	50                   	push   %eax
  801e44:	6a 23                	push   $0x23
  801e46:	e8 ef fb ff ff       	call   801a3a <syscall>
  801e4b:	83 c4 18             	add    $0x18,%esp
}
  801e4e:	90                   	nop
  801e4f:	c9                   	leave  
  801e50:	c3                   	ret    

00801e51 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e51:	55                   	push   %ebp
  801e52:	89 e5                	mov    %esp,%ebp
  801e54:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e57:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e5a:	8d 50 04             	lea    0x4(%eax),%edx
  801e5d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	52                   	push   %edx
  801e67:	50                   	push   %eax
  801e68:	6a 24                	push   $0x24
  801e6a:	e8 cb fb ff ff       	call   801a3a <syscall>
  801e6f:	83 c4 18             	add    $0x18,%esp
	return result;
  801e72:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e75:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e78:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e7b:	89 01                	mov    %eax,(%ecx)
  801e7d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e80:	8b 45 08             	mov    0x8(%ebp),%eax
  801e83:	c9                   	leave  
  801e84:	c2 04 00             	ret    $0x4

00801e87 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e87:	55                   	push   %ebp
  801e88:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e8a:	6a 00                	push   $0x0
  801e8c:	6a 00                	push   $0x0
  801e8e:	ff 75 10             	pushl  0x10(%ebp)
  801e91:	ff 75 0c             	pushl  0xc(%ebp)
  801e94:	ff 75 08             	pushl  0x8(%ebp)
  801e97:	6a 13                	push   $0x13
  801e99:	e8 9c fb ff ff       	call   801a3a <syscall>
  801e9e:	83 c4 18             	add    $0x18,%esp
	return ;
  801ea1:	90                   	nop
}
  801ea2:	c9                   	leave  
  801ea3:	c3                   	ret    

00801ea4 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ea4:	55                   	push   %ebp
  801ea5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ea7:	6a 00                	push   $0x0
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 25                	push   $0x25
  801eb3:	e8 82 fb ff ff       	call   801a3a <syscall>
  801eb8:	83 c4 18             	add    $0x18,%esp
}
  801ebb:	c9                   	leave  
  801ebc:	c3                   	ret    

00801ebd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ebd:	55                   	push   %ebp
  801ebe:	89 e5                	mov    %esp,%ebp
  801ec0:	83 ec 04             	sub    $0x4,%esp
  801ec3:	8b 45 08             	mov    0x8(%ebp),%eax
  801ec6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ec9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	50                   	push   %eax
  801ed6:	6a 26                	push   $0x26
  801ed8:	e8 5d fb ff ff       	call   801a3a <syscall>
  801edd:	83 c4 18             	add    $0x18,%esp
	return ;
  801ee0:	90                   	nop
}
  801ee1:	c9                   	leave  
  801ee2:	c3                   	ret    

00801ee3 <rsttst>:
void rsttst()
{
  801ee3:	55                   	push   %ebp
  801ee4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ee6:	6a 00                	push   $0x0
  801ee8:	6a 00                	push   $0x0
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	6a 28                	push   $0x28
  801ef2:	e8 43 fb ff ff       	call   801a3a <syscall>
  801ef7:	83 c4 18             	add    $0x18,%esp
	return ;
  801efa:	90                   	nop
}
  801efb:	c9                   	leave  
  801efc:	c3                   	ret    

00801efd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801efd:	55                   	push   %ebp
  801efe:	89 e5                	mov    %esp,%ebp
  801f00:	83 ec 04             	sub    $0x4,%esp
  801f03:	8b 45 14             	mov    0x14(%ebp),%eax
  801f06:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f09:	8b 55 18             	mov    0x18(%ebp),%edx
  801f0c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f10:	52                   	push   %edx
  801f11:	50                   	push   %eax
  801f12:	ff 75 10             	pushl  0x10(%ebp)
  801f15:	ff 75 0c             	pushl  0xc(%ebp)
  801f18:	ff 75 08             	pushl  0x8(%ebp)
  801f1b:	6a 27                	push   $0x27
  801f1d:	e8 18 fb ff ff       	call   801a3a <syscall>
  801f22:	83 c4 18             	add    $0x18,%esp
	return ;
  801f25:	90                   	nop
}
  801f26:	c9                   	leave  
  801f27:	c3                   	ret    

00801f28 <chktst>:
void chktst(uint32 n)
{
  801f28:	55                   	push   %ebp
  801f29:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	6a 00                	push   $0x0
  801f31:	6a 00                	push   $0x0
  801f33:	ff 75 08             	pushl  0x8(%ebp)
  801f36:	6a 29                	push   $0x29
  801f38:	e8 fd fa ff ff       	call   801a3a <syscall>
  801f3d:	83 c4 18             	add    $0x18,%esp
	return ;
  801f40:	90                   	nop
}
  801f41:	c9                   	leave  
  801f42:	c3                   	ret    

00801f43 <inctst>:

void inctst()
{
  801f43:	55                   	push   %ebp
  801f44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 00                	push   $0x0
  801f4c:	6a 00                	push   $0x0
  801f4e:	6a 00                	push   $0x0
  801f50:	6a 2a                	push   $0x2a
  801f52:	e8 e3 fa ff ff       	call   801a3a <syscall>
  801f57:	83 c4 18             	add    $0x18,%esp
	return ;
  801f5a:	90                   	nop
}
  801f5b:	c9                   	leave  
  801f5c:	c3                   	ret    

00801f5d <gettst>:
uint32 gettst()
{
  801f5d:	55                   	push   %ebp
  801f5e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f60:	6a 00                	push   $0x0
  801f62:	6a 00                	push   $0x0
  801f64:	6a 00                	push   $0x0
  801f66:	6a 00                	push   $0x0
  801f68:	6a 00                	push   $0x0
  801f6a:	6a 2b                	push   $0x2b
  801f6c:	e8 c9 fa ff ff       	call   801a3a <syscall>
  801f71:	83 c4 18             	add    $0x18,%esp
}
  801f74:	c9                   	leave  
  801f75:	c3                   	ret    

00801f76 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f76:	55                   	push   %ebp
  801f77:	89 e5                	mov    %esp,%ebp
  801f79:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f7c:	6a 00                	push   $0x0
  801f7e:	6a 00                	push   $0x0
  801f80:	6a 00                	push   $0x0
  801f82:	6a 00                	push   $0x0
  801f84:	6a 00                	push   $0x0
  801f86:	6a 2c                	push   $0x2c
  801f88:	e8 ad fa ff ff       	call   801a3a <syscall>
  801f8d:	83 c4 18             	add    $0x18,%esp
  801f90:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801f93:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801f97:	75 07                	jne    801fa0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801f99:	b8 01 00 00 00       	mov    $0x1,%eax
  801f9e:	eb 05                	jmp    801fa5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801fa0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fa5:	c9                   	leave  
  801fa6:	c3                   	ret    

00801fa7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801fa7:	55                   	push   %ebp
  801fa8:	89 e5                	mov    %esp,%ebp
  801faa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fad:	6a 00                	push   $0x0
  801faf:	6a 00                	push   $0x0
  801fb1:	6a 00                	push   $0x0
  801fb3:	6a 00                	push   $0x0
  801fb5:	6a 00                	push   $0x0
  801fb7:	6a 2c                	push   $0x2c
  801fb9:	e8 7c fa ff ff       	call   801a3a <syscall>
  801fbe:	83 c4 18             	add    $0x18,%esp
  801fc1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fc4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fc8:	75 07                	jne    801fd1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fca:	b8 01 00 00 00       	mov    $0x1,%eax
  801fcf:	eb 05                	jmp    801fd6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fd1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fd6:	c9                   	leave  
  801fd7:	c3                   	ret    

00801fd8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fd8:	55                   	push   %ebp
  801fd9:	89 e5                	mov    %esp,%ebp
  801fdb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	6a 00                	push   $0x0
  801fe8:	6a 2c                	push   $0x2c
  801fea:	e8 4b fa ff ff       	call   801a3a <syscall>
  801fef:	83 c4 18             	add    $0x18,%esp
  801ff2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801ff5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801ff9:	75 07                	jne    802002 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801ffb:	b8 01 00 00 00       	mov    $0x1,%eax
  802000:	eb 05                	jmp    802007 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802002:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802007:	c9                   	leave  
  802008:	c3                   	ret    

00802009 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802009:	55                   	push   %ebp
  80200a:	89 e5                	mov    %esp,%ebp
  80200c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	6a 00                	push   $0x0
  802017:	6a 00                	push   $0x0
  802019:	6a 2c                	push   $0x2c
  80201b:	e8 1a fa ff ff       	call   801a3a <syscall>
  802020:	83 c4 18             	add    $0x18,%esp
  802023:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802026:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80202a:	75 07                	jne    802033 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80202c:	b8 01 00 00 00       	mov    $0x1,%eax
  802031:	eb 05                	jmp    802038 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802033:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802038:	c9                   	leave  
  802039:	c3                   	ret    

0080203a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80203a:	55                   	push   %ebp
  80203b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	6a 00                	push   $0x0
  802043:	6a 00                	push   $0x0
  802045:	ff 75 08             	pushl  0x8(%ebp)
  802048:	6a 2d                	push   $0x2d
  80204a:	e8 eb f9 ff ff       	call   801a3a <syscall>
  80204f:	83 c4 18             	add    $0x18,%esp
	return ;
  802052:	90                   	nop
}
  802053:	c9                   	leave  
  802054:	c3                   	ret    

00802055 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802055:	55                   	push   %ebp
  802056:	89 e5                	mov    %esp,%ebp
  802058:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802059:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80205c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80205f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802062:	8b 45 08             	mov    0x8(%ebp),%eax
  802065:	6a 00                	push   $0x0
  802067:	53                   	push   %ebx
  802068:	51                   	push   %ecx
  802069:	52                   	push   %edx
  80206a:	50                   	push   %eax
  80206b:	6a 2e                	push   $0x2e
  80206d:	e8 c8 f9 ff ff       	call   801a3a <syscall>
  802072:	83 c4 18             	add    $0x18,%esp
}
  802075:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802078:	c9                   	leave  
  802079:	c3                   	ret    

0080207a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80207a:	55                   	push   %ebp
  80207b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80207d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802080:	8b 45 08             	mov    0x8(%ebp),%eax
  802083:	6a 00                	push   $0x0
  802085:	6a 00                	push   $0x0
  802087:	6a 00                	push   $0x0
  802089:	52                   	push   %edx
  80208a:	50                   	push   %eax
  80208b:	6a 2f                	push   $0x2f
  80208d:	e8 a8 f9 ff ff       	call   801a3a <syscall>
  802092:	83 c4 18             	add    $0x18,%esp
}
  802095:	c9                   	leave  
  802096:	c3                   	ret    

00802097 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802097:	55                   	push   %ebp
  802098:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80209a:	6a 00                	push   $0x0
  80209c:	6a 00                	push   $0x0
  80209e:	6a 00                	push   $0x0
  8020a0:	ff 75 0c             	pushl  0xc(%ebp)
  8020a3:	ff 75 08             	pushl  0x8(%ebp)
  8020a6:	6a 30                	push   $0x30
  8020a8:	e8 8d f9 ff ff       	call   801a3a <syscall>
  8020ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b0:	90                   	nop
}
  8020b1:	c9                   	leave  
  8020b2:	c3                   	ret    
  8020b3:	90                   	nop

008020b4 <__udivdi3>:
  8020b4:	55                   	push   %ebp
  8020b5:	57                   	push   %edi
  8020b6:	56                   	push   %esi
  8020b7:	53                   	push   %ebx
  8020b8:	83 ec 1c             	sub    $0x1c,%esp
  8020bb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020bf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020c7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020cb:	89 ca                	mov    %ecx,%edx
  8020cd:	89 f8                	mov    %edi,%eax
  8020cf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020d3:	85 f6                	test   %esi,%esi
  8020d5:	75 2d                	jne    802104 <__udivdi3+0x50>
  8020d7:	39 cf                	cmp    %ecx,%edi
  8020d9:	77 65                	ja     802140 <__udivdi3+0x8c>
  8020db:	89 fd                	mov    %edi,%ebp
  8020dd:	85 ff                	test   %edi,%edi
  8020df:	75 0b                	jne    8020ec <__udivdi3+0x38>
  8020e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8020e6:	31 d2                	xor    %edx,%edx
  8020e8:	f7 f7                	div    %edi
  8020ea:	89 c5                	mov    %eax,%ebp
  8020ec:	31 d2                	xor    %edx,%edx
  8020ee:	89 c8                	mov    %ecx,%eax
  8020f0:	f7 f5                	div    %ebp
  8020f2:	89 c1                	mov    %eax,%ecx
  8020f4:	89 d8                	mov    %ebx,%eax
  8020f6:	f7 f5                	div    %ebp
  8020f8:	89 cf                	mov    %ecx,%edi
  8020fa:	89 fa                	mov    %edi,%edx
  8020fc:	83 c4 1c             	add    $0x1c,%esp
  8020ff:	5b                   	pop    %ebx
  802100:	5e                   	pop    %esi
  802101:	5f                   	pop    %edi
  802102:	5d                   	pop    %ebp
  802103:	c3                   	ret    
  802104:	39 ce                	cmp    %ecx,%esi
  802106:	77 28                	ja     802130 <__udivdi3+0x7c>
  802108:	0f bd fe             	bsr    %esi,%edi
  80210b:	83 f7 1f             	xor    $0x1f,%edi
  80210e:	75 40                	jne    802150 <__udivdi3+0x9c>
  802110:	39 ce                	cmp    %ecx,%esi
  802112:	72 0a                	jb     80211e <__udivdi3+0x6a>
  802114:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802118:	0f 87 9e 00 00 00    	ja     8021bc <__udivdi3+0x108>
  80211e:	b8 01 00 00 00       	mov    $0x1,%eax
  802123:	89 fa                	mov    %edi,%edx
  802125:	83 c4 1c             	add    $0x1c,%esp
  802128:	5b                   	pop    %ebx
  802129:	5e                   	pop    %esi
  80212a:	5f                   	pop    %edi
  80212b:	5d                   	pop    %ebp
  80212c:	c3                   	ret    
  80212d:	8d 76 00             	lea    0x0(%esi),%esi
  802130:	31 ff                	xor    %edi,%edi
  802132:	31 c0                	xor    %eax,%eax
  802134:	89 fa                	mov    %edi,%edx
  802136:	83 c4 1c             	add    $0x1c,%esp
  802139:	5b                   	pop    %ebx
  80213a:	5e                   	pop    %esi
  80213b:	5f                   	pop    %edi
  80213c:	5d                   	pop    %ebp
  80213d:	c3                   	ret    
  80213e:	66 90                	xchg   %ax,%ax
  802140:	89 d8                	mov    %ebx,%eax
  802142:	f7 f7                	div    %edi
  802144:	31 ff                	xor    %edi,%edi
  802146:	89 fa                	mov    %edi,%edx
  802148:	83 c4 1c             	add    $0x1c,%esp
  80214b:	5b                   	pop    %ebx
  80214c:	5e                   	pop    %esi
  80214d:	5f                   	pop    %edi
  80214e:	5d                   	pop    %ebp
  80214f:	c3                   	ret    
  802150:	bd 20 00 00 00       	mov    $0x20,%ebp
  802155:	89 eb                	mov    %ebp,%ebx
  802157:	29 fb                	sub    %edi,%ebx
  802159:	89 f9                	mov    %edi,%ecx
  80215b:	d3 e6                	shl    %cl,%esi
  80215d:	89 c5                	mov    %eax,%ebp
  80215f:	88 d9                	mov    %bl,%cl
  802161:	d3 ed                	shr    %cl,%ebp
  802163:	89 e9                	mov    %ebp,%ecx
  802165:	09 f1                	or     %esi,%ecx
  802167:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80216b:	89 f9                	mov    %edi,%ecx
  80216d:	d3 e0                	shl    %cl,%eax
  80216f:	89 c5                	mov    %eax,%ebp
  802171:	89 d6                	mov    %edx,%esi
  802173:	88 d9                	mov    %bl,%cl
  802175:	d3 ee                	shr    %cl,%esi
  802177:	89 f9                	mov    %edi,%ecx
  802179:	d3 e2                	shl    %cl,%edx
  80217b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80217f:	88 d9                	mov    %bl,%cl
  802181:	d3 e8                	shr    %cl,%eax
  802183:	09 c2                	or     %eax,%edx
  802185:	89 d0                	mov    %edx,%eax
  802187:	89 f2                	mov    %esi,%edx
  802189:	f7 74 24 0c          	divl   0xc(%esp)
  80218d:	89 d6                	mov    %edx,%esi
  80218f:	89 c3                	mov    %eax,%ebx
  802191:	f7 e5                	mul    %ebp
  802193:	39 d6                	cmp    %edx,%esi
  802195:	72 19                	jb     8021b0 <__udivdi3+0xfc>
  802197:	74 0b                	je     8021a4 <__udivdi3+0xf0>
  802199:	89 d8                	mov    %ebx,%eax
  80219b:	31 ff                	xor    %edi,%edi
  80219d:	e9 58 ff ff ff       	jmp    8020fa <__udivdi3+0x46>
  8021a2:	66 90                	xchg   %ax,%ax
  8021a4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021a8:	89 f9                	mov    %edi,%ecx
  8021aa:	d3 e2                	shl    %cl,%edx
  8021ac:	39 c2                	cmp    %eax,%edx
  8021ae:	73 e9                	jae    802199 <__udivdi3+0xe5>
  8021b0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021b3:	31 ff                	xor    %edi,%edi
  8021b5:	e9 40 ff ff ff       	jmp    8020fa <__udivdi3+0x46>
  8021ba:	66 90                	xchg   %ax,%ax
  8021bc:	31 c0                	xor    %eax,%eax
  8021be:	e9 37 ff ff ff       	jmp    8020fa <__udivdi3+0x46>
  8021c3:	90                   	nop

008021c4 <__umoddi3>:
  8021c4:	55                   	push   %ebp
  8021c5:	57                   	push   %edi
  8021c6:	56                   	push   %esi
  8021c7:	53                   	push   %ebx
  8021c8:	83 ec 1c             	sub    $0x1c,%esp
  8021cb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021cf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021d7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021db:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021df:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021e3:	89 f3                	mov    %esi,%ebx
  8021e5:	89 fa                	mov    %edi,%edx
  8021e7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021eb:	89 34 24             	mov    %esi,(%esp)
  8021ee:	85 c0                	test   %eax,%eax
  8021f0:	75 1a                	jne    80220c <__umoddi3+0x48>
  8021f2:	39 f7                	cmp    %esi,%edi
  8021f4:	0f 86 a2 00 00 00    	jbe    80229c <__umoddi3+0xd8>
  8021fa:	89 c8                	mov    %ecx,%eax
  8021fc:	89 f2                	mov    %esi,%edx
  8021fe:	f7 f7                	div    %edi
  802200:	89 d0                	mov    %edx,%eax
  802202:	31 d2                	xor    %edx,%edx
  802204:	83 c4 1c             	add    $0x1c,%esp
  802207:	5b                   	pop    %ebx
  802208:	5e                   	pop    %esi
  802209:	5f                   	pop    %edi
  80220a:	5d                   	pop    %ebp
  80220b:	c3                   	ret    
  80220c:	39 f0                	cmp    %esi,%eax
  80220e:	0f 87 ac 00 00 00    	ja     8022c0 <__umoddi3+0xfc>
  802214:	0f bd e8             	bsr    %eax,%ebp
  802217:	83 f5 1f             	xor    $0x1f,%ebp
  80221a:	0f 84 ac 00 00 00    	je     8022cc <__umoddi3+0x108>
  802220:	bf 20 00 00 00       	mov    $0x20,%edi
  802225:	29 ef                	sub    %ebp,%edi
  802227:	89 fe                	mov    %edi,%esi
  802229:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80222d:	89 e9                	mov    %ebp,%ecx
  80222f:	d3 e0                	shl    %cl,%eax
  802231:	89 d7                	mov    %edx,%edi
  802233:	89 f1                	mov    %esi,%ecx
  802235:	d3 ef                	shr    %cl,%edi
  802237:	09 c7                	or     %eax,%edi
  802239:	89 e9                	mov    %ebp,%ecx
  80223b:	d3 e2                	shl    %cl,%edx
  80223d:	89 14 24             	mov    %edx,(%esp)
  802240:	89 d8                	mov    %ebx,%eax
  802242:	d3 e0                	shl    %cl,%eax
  802244:	89 c2                	mov    %eax,%edx
  802246:	8b 44 24 08          	mov    0x8(%esp),%eax
  80224a:	d3 e0                	shl    %cl,%eax
  80224c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802250:	8b 44 24 08          	mov    0x8(%esp),%eax
  802254:	89 f1                	mov    %esi,%ecx
  802256:	d3 e8                	shr    %cl,%eax
  802258:	09 d0                	or     %edx,%eax
  80225a:	d3 eb                	shr    %cl,%ebx
  80225c:	89 da                	mov    %ebx,%edx
  80225e:	f7 f7                	div    %edi
  802260:	89 d3                	mov    %edx,%ebx
  802262:	f7 24 24             	mull   (%esp)
  802265:	89 c6                	mov    %eax,%esi
  802267:	89 d1                	mov    %edx,%ecx
  802269:	39 d3                	cmp    %edx,%ebx
  80226b:	0f 82 87 00 00 00    	jb     8022f8 <__umoddi3+0x134>
  802271:	0f 84 91 00 00 00    	je     802308 <__umoddi3+0x144>
  802277:	8b 54 24 04          	mov    0x4(%esp),%edx
  80227b:	29 f2                	sub    %esi,%edx
  80227d:	19 cb                	sbb    %ecx,%ebx
  80227f:	89 d8                	mov    %ebx,%eax
  802281:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802285:	d3 e0                	shl    %cl,%eax
  802287:	89 e9                	mov    %ebp,%ecx
  802289:	d3 ea                	shr    %cl,%edx
  80228b:	09 d0                	or     %edx,%eax
  80228d:	89 e9                	mov    %ebp,%ecx
  80228f:	d3 eb                	shr    %cl,%ebx
  802291:	89 da                	mov    %ebx,%edx
  802293:	83 c4 1c             	add    $0x1c,%esp
  802296:	5b                   	pop    %ebx
  802297:	5e                   	pop    %esi
  802298:	5f                   	pop    %edi
  802299:	5d                   	pop    %ebp
  80229a:	c3                   	ret    
  80229b:	90                   	nop
  80229c:	89 fd                	mov    %edi,%ebp
  80229e:	85 ff                	test   %edi,%edi
  8022a0:	75 0b                	jne    8022ad <__umoddi3+0xe9>
  8022a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022a7:	31 d2                	xor    %edx,%edx
  8022a9:	f7 f7                	div    %edi
  8022ab:	89 c5                	mov    %eax,%ebp
  8022ad:	89 f0                	mov    %esi,%eax
  8022af:	31 d2                	xor    %edx,%edx
  8022b1:	f7 f5                	div    %ebp
  8022b3:	89 c8                	mov    %ecx,%eax
  8022b5:	f7 f5                	div    %ebp
  8022b7:	89 d0                	mov    %edx,%eax
  8022b9:	e9 44 ff ff ff       	jmp    802202 <__umoddi3+0x3e>
  8022be:	66 90                	xchg   %ax,%ax
  8022c0:	89 c8                	mov    %ecx,%eax
  8022c2:	89 f2                	mov    %esi,%edx
  8022c4:	83 c4 1c             	add    $0x1c,%esp
  8022c7:	5b                   	pop    %ebx
  8022c8:	5e                   	pop    %esi
  8022c9:	5f                   	pop    %edi
  8022ca:	5d                   	pop    %ebp
  8022cb:	c3                   	ret    
  8022cc:	3b 04 24             	cmp    (%esp),%eax
  8022cf:	72 06                	jb     8022d7 <__umoddi3+0x113>
  8022d1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022d5:	77 0f                	ja     8022e6 <__umoddi3+0x122>
  8022d7:	89 f2                	mov    %esi,%edx
  8022d9:	29 f9                	sub    %edi,%ecx
  8022db:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022df:	89 14 24             	mov    %edx,(%esp)
  8022e2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022e6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022ea:	8b 14 24             	mov    (%esp),%edx
  8022ed:	83 c4 1c             	add    $0x1c,%esp
  8022f0:	5b                   	pop    %ebx
  8022f1:	5e                   	pop    %esi
  8022f2:	5f                   	pop    %edi
  8022f3:	5d                   	pop    %ebp
  8022f4:	c3                   	ret    
  8022f5:	8d 76 00             	lea    0x0(%esi),%esi
  8022f8:	2b 04 24             	sub    (%esp),%eax
  8022fb:	19 fa                	sbb    %edi,%edx
  8022fd:	89 d1                	mov    %edx,%ecx
  8022ff:	89 c6                	mov    %eax,%esi
  802301:	e9 71 ff ff ff       	jmp    802277 <__umoddi3+0xb3>
  802306:	66 90                	xchg   %ax,%ax
  802308:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80230c:	72 ea                	jb     8022f8 <__umoddi3+0x134>
  80230e:	89 d9                	mov    %ebx,%ecx
  802310:	e9 62 ff ff ff       	jmp    802277 <__umoddi3+0xb3>
