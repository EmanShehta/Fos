
obj/user/quicksort:     file format elf32-i386


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
  800031:	e8 c2 05 00 00       	call   8005f8 <libmain>
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
  800049:	e8 66 1b 00 00       	call   801bb4 <sys_calculate_free_frames>
  80004e:	89 c3                	mov    %eax,%ebx
  800050:	e8 78 1b 00 00       	call   801bcd <sys_calculate_modified_frames>
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
  800067:	68 40 23 80 00       	push   $0x802340
  80006c:	e8 d9 0f 00 00       	call   80104a <readline>
  800071:	83 c4 10             	add    $0x10,%esp
			int NumOfElements = strtol(Line, NULL, 10) ;
  800074:	83 ec 04             	sub    $0x4,%esp
  800077:	6a 0a                	push   $0xa
  800079:	6a 00                	push   $0x0
  80007b:	8d 85 e1 fe ff ff    	lea    -0x11f(%ebp),%eax
  800081:	50                   	push   %eax
  800082:	e8 29 15 00 00       	call   8015b0 <strtol>
  800087:	83 c4 10             	add    $0x10,%esp
  80008a:	89 45 ec             	mov    %eax,-0x14(%ebp)
			int *Elements = malloc(sizeof(int) * NumOfElements) ;
  80008d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800090:	c1 e0 02             	shl    $0x2,%eax
  800093:	83 ec 0c             	sub    $0xc,%esp
  800096:	50                   	push   %eax
  800097:	e8 bc 18 00 00       	call   801958 <malloc>
  80009c:	83 c4 10             	add    $0x10,%esp
  80009f:	89 45 e8             	mov    %eax,-0x18(%ebp)
			cprintf("Choose the initialization method:\n") ;
  8000a2:	83 ec 0c             	sub    $0xc,%esp
  8000a5:	68 60 23 80 00       	push   $0x802360
  8000aa:	e8 19 09 00 00       	call   8009c8 <cprintf>
  8000af:	83 c4 10             	add    $0x10,%esp
			cprintf("a) Ascending\n") ;
  8000b2:	83 ec 0c             	sub    $0xc,%esp
  8000b5:	68 83 23 80 00       	push   $0x802383
  8000ba:	e8 09 09 00 00       	call   8009c8 <cprintf>
  8000bf:	83 c4 10             	add    $0x10,%esp
			cprintf("b) Descending\n") ;
  8000c2:	83 ec 0c             	sub    $0xc,%esp
  8000c5:	68 91 23 80 00       	push   $0x802391
  8000ca:	e8 f9 08 00 00       	call   8009c8 <cprintf>
  8000cf:	83 c4 10             	add    $0x10,%esp
			cprintf("c) Semi random\n");
  8000d2:	83 ec 0c             	sub    $0xc,%esp
  8000d5:	68 a0 23 80 00       	push   $0x8023a0
  8000da:	e8 e9 08 00 00       	call   8009c8 <cprintf>
  8000df:	83 c4 10             	add    $0x10,%esp
			do
			{
				cprintf("Select: ") ;
  8000e2:	83 ec 0c             	sub    $0xc,%esp
  8000e5:	68 b0 23 80 00       	push   $0x8023b0
  8000ea:	e8 d9 08 00 00       	call   8009c8 <cprintf>
  8000ef:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  8000f2:	e8 a9 04 00 00       	call   8005a0 <getchar>
  8000f7:	88 45 e7             	mov    %al,-0x19(%ebp)
				cputchar(Chose);
  8000fa:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  8000fe:	83 ec 0c             	sub    $0xc,%esp
  800101:	50                   	push   %eax
  800102:	e8 51 04 00 00       	call   800558 <cputchar>
  800107:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80010a:	83 ec 0c             	sub    $0xc,%esp
  80010d:	6a 0a                	push   $0xa
  80010f:	e8 44 04 00 00       	call   800558 <cputchar>
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
  800145:	e8 d6 02 00 00       	call   800420 <InitializeAscending>
  80014a:	83 c4 10             	add    $0x10,%esp
			break ;
  80014d:	eb 37                	jmp    800186 <_main+0x14e>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80014f:	83 ec 08             	sub    $0x8,%esp
  800152:	ff 75 ec             	pushl  -0x14(%ebp)
  800155:	ff 75 e8             	pushl  -0x18(%ebp)
  800158:	e8 f4 02 00 00       	call   800451 <InitializeDescending>
  80015d:	83 c4 10             	add    $0x10,%esp
			break ;
  800160:	eb 24                	jmp    800186 <_main+0x14e>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  800162:	83 ec 08             	sub    $0x8,%esp
  800165:	ff 75 ec             	pushl  -0x14(%ebp)
  800168:	ff 75 e8             	pushl  -0x18(%ebp)
  80016b:	e8 16 03 00 00       	call   800486 <InitializeSemiRandom>
  800170:	83 c4 10             	add    $0x10,%esp
			break ;
  800173:	eb 11                	jmp    800186 <_main+0x14e>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  800175:	83 ec 08             	sub    $0x8,%esp
  800178:	ff 75 ec             	pushl  -0x14(%ebp)
  80017b:	ff 75 e8             	pushl  -0x18(%ebp)
  80017e:	e8 03 03 00 00       	call   800486 <InitializeSemiRandom>
  800183:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  800186:	83 ec 08             	sub    $0x8,%esp
  800189:	ff 75 ec             	pushl  -0x14(%ebp)
  80018c:	ff 75 e8             	pushl  -0x18(%ebp)
  80018f:	e8 d1 00 00 00       	call   800265 <QuickSort>
  800194:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800197:	83 ec 08             	sub    $0x8,%esp
  80019a:	ff 75 ec             	pushl  -0x14(%ebp)
  80019d:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a0:	e8 d1 01 00 00       	call   800376 <CheckSorted>
  8001a5:	83 c4 10             	add    $0x10,%esp
  8001a8:	89 45 e0             	mov    %eax,-0x20(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001ab:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8001af:	75 14                	jne    8001c5 <_main+0x18d>
  8001b1:	83 ec 04             	sub    $0x4,%esp
  8001b4:	68 bc 23 80 00       	push   $0x8023bc
  8001b9:	6a 46                	push   $0x46
  8001bb:	68 de 23 80 00       	push   $0x8023de
  8001c0:	e8 4f 05 00 00       	call   800714 <_panic>
		else
		{ 
				cprintf("\n===============================================\n") ;
  8001c5:	83 ec 0c             	sub    $0xc,%esp
  8001c8:	68 f0 23 80 00       	push   $0x8023f0
  8001cd:	e8 f6 07 00 00       	call   8009c8 <cprintf>
  8001d2:	83 c4 10             	add    $0x10,%esp
				cprintf("Congratulations!! The array is sorted correctly\n") ;
  8001d5:	83 ec 0c             	sub    $0xc,%esp
  8001d8:	68 24 24 80 00       	push   $0x802424
  8001dd:	e8 e6 07 00 00       	call   8009c8 <cprintf>
  8001e2:	83 c4 10             	add    $0x10,%esp
				cprintf("===============================================\n\n") ;
  8001e5:	83 ec 0c             	sub    $0xc,%esp
  8001e8:	68 58 24 80 00       	push   $0x802458
  8001ed:	e8 d6 07 00 00       	call   8009c8 <cprintf>
  8001f2:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

			cprintf("Freeing the Heap...\n\n") ;
  8001f5:	83 ec 0c             	sub    $0xc,%esp
  8001f8:	68 8a 24 80 00       	push   $0x80248a
  8001fd:	e8 c6 07 00 00       	call   8009c8 <cprintf>
  800202:	83 c4 10             	add    $0x10,%esp

			free(Elements) ;
  800205:	83 ec 0c             	sub    $0xc,%esp
  800208:	ff 75 e8             	pushl  -0x18(%ebp)
  80020b:	e8 62 17 00 00       	call   801972 <free>
  800210:	83 c4 10             	add    $0x10,%esp


		///========================================================================
	//sys_disable_interrupt();
			cprintf("Do you want to repeat (y/n): ") ;
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 a0 24 80 00       	push   $0x8024a0
  80021b:	e8 a8 07 00 00       	call   8009c8 <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800223:	e8 78 03 00 00       	call   8005a0 <getchar>
  800228:	88 45 e7             	mov    %al,-0x19(%ebp)
			cputchar(Chose);
  80022b:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
  80022f:	83 ec 0c             	sub    $0xc,%esp
  800232:	50                   	push   %eax
  800233:	e8 20 03 00 00       	call   800558 <cputchar>
  800238:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80023b:	83 ec 0c             	sub    $0xc,%esp
  80023e:	6a 0a                	push   $0xa
  800240:	e8 13 03 00 00       	call   800558 <cputchar>
  800245:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800248:	83 ec 0c             	sub    $0xc,%esp
  80024b:	6a 0a                	push   $0xa
  80024d:	e8 06 03 00 00       	call   800558 <cputchar>
  800252:	83 c4 10             	add    $0x10,%esp
	//sys_enable_interrupt();

	} while (Chose == 'y');
  800255:	80 7d e7 79          	cmpb   $0x79,-0x19(%ebp)
  800259:	0f 84 ea fd ff ff    	je     800049 <_main+0x11>

}
  80025f:	90                   	nop
  800260:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800263:	c9                   	leave  
  800264:	c3                   	ret    

00800265 <QuickSort>:

///Quick sort 
void QuickSort(int *Elements, int NumOfElements)
{
  800265:	55                   	push   %ebp
  800266:	89 e5                	mov    %esp,%ebp
  800268:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  80026b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80026e:	48                   	dec    %eax
  80026f:	50                   	push   %eax
  800270:	6a 00                	push   $0x0
  800272:	ff 75 0c             	pushl  0xc(%ebp)
  800275:	ff 75 08             	pushl  0x8(%ebp)
  800278:	e8 06 00 00 00       	call   800283 <QSort>
  80027d:	83 c4 10             	add    $0x10,%esp
}
  800280:	90                   	nop
  800281:	c9                   	leave  
  800282:	c3                   	ret    

00800283 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  800283:	55                   	push   %ebp
  800284:	89 e5                	mov    %esp,%ebp
  800286:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  800289:	8b 45 10             	mov    0x10(%ebp),%eax
  80028c:	3b 45 14             	cmp    0x14(%ebp),%eax
  80028f:	0f 8d de 00 00 00    	jge    800373 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  800295:	8b 45 10             	mov    0x10(%ebp),%eax
  800298:	40                   	inc    %eax
  800299:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80029c:	8b 45 14             	mov    0x14(%ebp),%eax
  80029f:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002a2:	e9 80 00 00 00       	jmp    800327 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002a7:	ff 45 f4             	incl   -0xc(%ebp)
  8002aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002ad:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002b0:	7f 2b                	jg     8002dd <QSort+0x5a>
  8002b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002b5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8002bf:	01 d0                	add    %edx,%eax
  8002c1:	8b 10                	mov    (%eax),%edx
  8002c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002c6:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8002cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8002d0:	01 c8                	add    %ecx,%eax
  8002d2:	8b 00                	mov    (%eax),%eax
  8002d4:	39 c2                	cmp    %eax,%edx
  8002d6:	7d cf                	jge    8002a7 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  8002d8:	eb 03                	jmp    8002dd <QSort+0x5a>
  8002da:	ff 4d f0             	decl   -0x10(%ebp)
  8002dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e0:	3b 45 10             	cmp    0x10(%ebp),%eax
  8002e3:	7e 26                	jle    80030b <QSort+0x88>
  8002e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f2:	01 d0                	add    %edx,%eax
  8002f4:	8b 10                	mov    (%eax),%edx
  8002f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002f9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800300:	8b 45 08             	mov    0x8(%ebp),%eax
  800303:	01 c8                	add    %ecx,%eax
  800305:	8b 00                	mov    (%eax),%eax
  800307:	39 c2                	cmp    %eax,%edx
  800309:	7e cf                	jle    8002da <QSort+0x57>

		if (i <= j)
  80030b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800311:	7f 14                	jg     800327 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800313:	83 ec 04             	sub    $0x4,%esp
  800316:	ff 75 f0             	pushl  -0x10(%ebp)
  800319:	ff 75 f4             	pushl  -0xc(%ebp)
  80031c:	ff 75 08             	pushl  0x8(%ebp)
  80031f:	e8 a9 00 00 00       	call   8003cd <Swap>
  800324:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800327:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80032a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80032d:	0f 8e 77 ff ff ff    	jle    8002aa <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800333:	83 ec 04             	sub    $0x4,%esp
  800336:	ff 75 f0             	pushl  -0x10(%ebp)
  800339:	ff 75 10             	pushl  0x10(%ebp)
  80033c:	ff 75 08             	pushl  0x8(%ebp)
  80033f:	e8 89 00 00 00       	call   8003cd <Swap>
  800344:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800347:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80034a:	48                   	dec    %eax
  80034b:	50                   	push   %eax
  80034c:	ff 75 10             	pushl  0x10(%ebp)
  80034f:	ff 75 0c             	pushl  0xc(%ebp)
  800352:	ff 75 08             	pushl  0x8(%ebp)
  800355:	e8 29 ff ff ff       	call   800283 <QSort>
  80035a:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  80035d:	ff 75 14             	pushl  0x14(%ebp)
  800360:	ff 75 f4             	pushl  -0xc(%ebp)
  800363:	ff 75 0c             	pushl  0xc(%ebp)
  800366:	ff 75 08             	pushl  0x8(%ebp)
  800369:	e8 15 ff ff ff       	call   800283 <QSort>
  80036e:	83 c4 10             	add    $0x10,%esp
  800371:	eb 01                	jmp    800374 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  800373:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  800374:	c9                   	leave  
  800375:	c3                   	ret    

00800376 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800376:	55                   	push   %ebp
  800377:	89 e5                	mov    %esp,%ebp
  800379:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  80037c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800383:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80038a:	eb 33                	jmp    8003bf <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  80038c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80038f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800396:	8b 45 08             	mov    0x8(%ebp),%eax
  800399:	01 d0                	add    %edx,%eax
  80039b:	8b 10                	mov    (%eax),%edx
  80039d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003a0:	40                   	inc    %eax
  8003a1:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8003ab:	01 c8                	add    %ecx,%eax
  8003ad:	8b 00                	mov    (%eax),%eax
  8003af:	39 c2                	cmp    %eax,%edx
  8003b1:	7e 09                	jle    8003bc <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  8003ba:	eb 0c                	jmp    8003c8 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003bc:	ff 45 f8             	incl   -0x8(%ebp)
  8003bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c2:	48                   	dec    %eax
  8003c3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003c6:	7f c4                	jg     80038c <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003cb:	c9                   	leave  
  8003cc:	c3                   	ret    

008003cd <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003cd:	55                   	push   %ebp
  8003ce:	89 e5                	mov    %esp,%ebp
  8003d0:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003d6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e0:	01 d0                	add    %edx,%eax
  8003e2:	8b 00                	mov    (%eax),%eax
  8003e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ea:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f4:	01 c2                	add    %eax,%edx
  8003f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8003f9:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800400:	8b 45 08             	mov    0x8(%ebp),%eax
  800403:	01 c8                	add    %ecx,%eax
  800405:	8b 00                	mov    (%eax),%eax
  800407:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800409:	8b 45 10             	mov    0x10(%ebp),%eax
  80040c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800413:	8b 45 08             	mov    0x8(%ebp),%eax
  800416:	01 c2                	add    %eax,%edx
  800418:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041b:	89 02                	mov    %eax,(%edx)
}
  80041d:	90                   	nop
  80041e:	c9                   	leave  
  80041f:	c3                   	ret    

00800420 <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  800420:	55                   	push   %ebp
  800421:	89 e5                	mov    %esp,%ebp
  800423:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800426:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80042d:	eb 17                	jmp    800446 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80042f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800432:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	01 c2                	add    %eax,%edx
  80043e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800441:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800443:	ff 45 fc             	incl   -0x4(%ebp)
  800446:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800449:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80044c:	7c e1                	jl     80042f <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80044e:	90                   	nop
  80044f:	c9                   	leave  
  800450:	c3                   	ret    

00800451 <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  800451:	55                   	push   %ebp
  800452:	89 e5                	mov    %esp,%ebp
  800454:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800457:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80045e:	eb 1b                	jmp    80047b <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  800460:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800463:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046a:	8b 45 08             	mov    0x8(%ebp),%eax
  80046d:	01 c2                	add    %eax,%edx
  80046f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800472:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800475:	48                   	dec    %eax
  800476:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800478:	ff 45 fc             	incl   -0x4(%ebp)
  80047b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800481:	7c dd                	jl     800460 <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  800483:	90                   	nop
  800484:	c9                   	leave  
  800485:	c3                   	ret    

00800486 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800486:	55                   	push   %ebp
  800487:	89 e5                	mov    %esp,%ebp
  800489:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  80048c:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80048f:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800494:	f7 e9                	imul   %ecx
  800496:	c1 f9 1f             	sar    $0x1f,%ecx
  800499:	89 d0                	mov    %edx,%eax
  80049b:	29 c8                	sub    %ecx,%eax
  80049d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004a7:	eb 1e                	jmp    8004c7 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ac:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b6:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8004b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004bc:	99                   	cltd   
  8004bd:	f7 7d f8             	idivl  -0x8(%ebp)
  8004c0:	89 d0                	mov    %edx,%eax
  8004c2:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c4:	ff 45 fc             	incl   -0x4(%ebp)
  8004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004cd:	7c da                	jl     8004a9 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 18             	sub    $0x18,%esp
		int i ;
		int NumsPerLine = 20 ;
  8004d8:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
		for (i = 0 ; i < NumOfElements-1 ; i++)
  8004df:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004e6:	eb 42                	jmp    80052a <PrintElements+0x58>
		{
			if (i%NumsPerLine == 0)
  8004e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004eb:	99                   	cltd   
  8004ec:	f7 7d f0             	idivl  -0x10(%ebp)
  8004ef:	89 d0                	mov    %edx,%eax
  8004f1:	85 c0                	test   %eax,%eax
  8004f3:	75 10                	jne    800505 <PrintElements+0x33>
				cprintf("\n");
  8004f5:	83 ec 0c             	sub    $0xc,%esp
  8004f8:	68 be 24 80 00       	push   $0x8024be
  8004fd:	e8 c6 04 00 00       	call   8009c8 <cprintf>
  800502:	83 c4 10             	add    $0x10,%esp
			cprintf("%d, ",Elements[i]);
  800505:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800508:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80050f:	8b 45 08             	mov    0x8(%ebp),%eax
  800512:	01 d0                	add    %edx,%eax
  800514:	8b 00                	mov    (%eax),%eax
  800516:	83 ec 08             	sub    $0x8,%esp
  800519:	50                   	push   %eax
  80051a:	68 c0 24 80 00       	push   $0x8024c0
  80051f:	e8 a4 04 00 00       	call   8009c8 <cprintf>
  800524:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
		int i ;
		int NumsPerLine = 20 ;
		for (i = 0 ; i < NumOfElements-1 ; i++)
  800527:	ff 45 f4             	incl   -0xc(%ebp)
  80052a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052d:	48                   	dec    %eax
  80052e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800531:	7f b5                	jg     8004e8 <PrintElements+0x16>
		{
			if (i%NumsPerLine == 0)
				cprintf("\n");
			cprintf("%d, ",Elements[i]);
		}
		cprintf("%d\n",Elements[i]);
  800533:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800536:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80053d:	8b 45 08             	mov    0x8(%ebp),%eax
  800540:	01 d0                	add    %edx,%eax
  800542:	8b 00                	mov    (%eax),%eax
  800544:	83 ec 08             	sub    $0x8,%esp
  800547:	50                   	push   %eax
  800548:	68 c5 24 80 00       	push   $0x8024c5
  80054d:	e8 76 04 00 00       	call   8009c8 <cprintf>
  800552:	83 c4 10             	add    $0x10,%esp
}
  800555:	90                   	nop
  800556:	c9                   	leave  
  800557:	c3                   	ret    

00800558 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800558:	55                   	push   %ebp
  800559:	89 e5                	mov    %esp,%ebp
  80055b:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80055e:	8b 45 08             	mov    0x8(%ebp),%eax
  800561:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800564:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800568:	83 ec 0c             	sub    $0xc,%esp
  80056b:	50                   	push   %eax
  80056c:	e8 47 17 00 00       	call   801cb8 <sys_cputc>
  800571:	83 c4 10             	add    $0x10,%esp
}
  800574:	90                   	nop
  800575:	c9                   	leave  
  800576:	c3                   	ret    

00800577 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800577:	55                   	push   %ebp
  800578:	89 e5                	mov    %esp,%ebp
  80057a:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80057d:	e8 02 17 00 00       	call   801c84 <sys_disable_interrupt>
	char c = ch;
  800582:	8b 45 08             	mov    0x8(%ebp),%eax
  800585:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800588:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80058c:	83 ec 0c             	sub    $0xc,%esp
  80058f:	50                   	push   %eax
  800590:	e8 23 17 00 00       	call   801cb8 <sys_cputc>
  800595:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800598:	e8 01 17 00 00       	call   801c9e <sys_enable_interrupt>
}
  80059d:	90                   	nop
  80059e:	c9                   	leave  
  80059f:	c3                   	ret    

008005a0 <getchar>:

int
getchar(void)
{
  8005a0:	55                   	push   %ebp
  8005a1:	89 e5                	mov    %esp,%ebp
  8005a3:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005ad:	eb 08                	jmp    8005b7 <getchar+0x17>
	{
		c = sys_cgetc();
  8005af:	e8 e8 14 00 00       	call   801a9c <sys_cgetc>
  8005b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8005b7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005bb:	74 f2                	je     8005af <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8005bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005c0:	c9                   	leave  
  8005c1:	c3                   	ret    

008005c2 <atomic_getchar>:

int
atomic_getchar(void)
{
  8005c2:	55                   	push   %ebp
  8005c3:	89 e5                	mov    %esp,%ebp
  8005c5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c8:	e8 b7 16 00 00       	call   801c84 <sys_disable_interrupt>
	int c=0;
  8005cd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005d4:	eb 08                	jmp    8005de <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8005d6:	e8 c1 14 00 00       	call   801a9c <sys_cgetc>
  8005db:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8005de:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8005e2:	74 f2                	je     8005d6 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8005e4:	e8 b5 16 00 00       	call   801c9e <sys_enable_interrupt>
	return c;
  8005e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8005ec:	c9                   	leave  
  8005ed:	c3                   	ret    

008005ee <iscons>:

int iscons(int fdnum)
{
  8005ee:	55                   	push   %ebp
  8005ef:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8005f1:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8005f6:	5d                   	pop    %ebp
  8005f7:	c3                   	ret    

008005f8 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005f8:	55                   	push   %ebp
  8005f9:	89 e5                	mov    %esp,%ebp
  8005fb:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005fe:	e8 e6 14 00 00       	call   801ae9 <sys_getenvindex>
  800603:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800606:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800609:	89 d0                	mov    %edx,%eax
  80060b:	01 c0                	add    %eax,%eax
  80060d:	01 d0                	add    %edx,%eax
  80060f:	c1 e0 04             	shl    $0x4,%eax
  800612:	29 d0                	sub    %edx,%eax
  800614:	c1 e0 03             	shl    $0x3,%eax
  800617:	01 d0                	add    %edx,%eax
  800619:	c1 e0 02             	shl    $0x2,%eax
  80061c:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800621:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800626:	a1 24 30 80 00       	mov    0x803024,%eax
  80062b:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800631:	84 c0                	test   %al,%al
  800633:	74 0f                	je     800644 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800635:	a1 24 30 80 00       	mov    0x803024,%eax
  80063a:	05 5c 05 00 00       	add    $0x55c,%eax
  80063f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800644:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800648:	7e 0a                	jle    800654 <libmain+0x5c>
		binaryname = argv[0];
  80064a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80064d:	8b 00                	mov    (%eax),%eax
  80064f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800654:	83 ec 08             	sub    $0x8,%esp
  800657:	ff 75 0c             	pushl  0xc(%ebp)
  80065a:	ff 75 08             	pushl  0x8(%ebp)
  80065d:	e8 d6 f9 ff ff       	call   800038 <_main>
  800662:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800665:	e8 1a 16 00 00       	call   801c84 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80066a:	83 ec 0c             	sub    $0xc,%esp
  80066d:	68 e4 24 80 00       	push   $0x8024e4
  800672:	e8 51 03 00 00       	call   8009c8 <cprintf>
  800677:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80067a:	a1 24 30 80 00       	mov    0x803024,%eax
  80067f:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800685:	a1 24 30 80 00       	mov    0x803024,%eax
  80068a:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800690:	83 ec 04             	sub    $0x4,%esp
  800693:	52                   	push   %edx
  800694:	50                   	push   %eax
  800695:	68 0c 25 80 00       	push   $0x80250c
  80069a:	e8 29 03 00 00       	call   8009c8 <cprintf>
  80069f:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006a2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006a7:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8006ad:	a1 24 30 80 00       	mov    0x803024,%eax
  8006b2:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8006b8:	a1 24 30 80 00       	mov    0x803024,%eax
  8006bd:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8006c3:	51                   	push   %ecx
  8006c4:	52                   	push   %edx
  8006c5:	50                   	push   %eax
  8006c6:	68 34 25 80 00       	push   $0x802534
  8006cb:	e8 f8 02 00 00       	call   8009c8 <cprintf>
  8006d0:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006d3:	83 ec 0c             	sub    $0xc,%esp
  8006d6:	68 e4 24 80 00       	push   $0x8024e4
  8006db:	e8 e8 02 00 00       	call   8009c8 <cprintf>
  8006e0:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006e3:	e8 b6 15 00 00       	call   801c9e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006e8:	e8 19 00 00 00       	call   800706 <exit>
}
  8006ed:	90                   	nop
  8006ee:	c9                   	leave  
  8006ef:	c3                   	ret    

008006f0 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006f0:	55                   	push   %ebp
  8006f1:	89 e5                	mov    %esp,%ebp
  8006f3:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006f6:	83 ec 0c             	sub    $0xc,%esp
  8006f9:	6a 00                	push   $0x0
  8006fb:	e8 b5 13 00 00       	call   801ab5 <sys_env_destroy>
  800700:	83 c4 10             	add    $0x10,%esp
}
  800703:	90                   	nop
  800704:	c9                   	leave  
  800705:	c3                   	ret    

00800706 <exit>:

void
exit(void)
{
  800706:	55                   	push   %ebp
  800707:	89 e5                	mov    %esp,%ebp
  800709:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80070c:	e8 0a 14 00 00       	call   801b1b <sys_env_exit>
}
  800711:	90                   	nop
  800712:	c9                   	leave  
  800713:	c3                   	ret    

00800714 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800714:	55                   	push   %ebp
  800715:	89 e5                	mov    %esp,%ebp
  800717:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80071a:	8d 45 10             	lea    0x10(%ebp),%eax
  80071d:	83 c0 04             	add    $0x4,%eax
  800720:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800723:	a1 18 31 80 00       	mov    0x803118,%eax
  800728:	85 c0                	test   %eax,%eax
  80072a:	74 16                	je     800742 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80072c:	a1 18 31 80 00       	mov    0x803118,%eax
  800731:	83 ec 08             	sub    $0x8,%esp
  800734:	50                   	push   %eax
  800735:	68 8c 25 80 00       	push   $0x80258c
  80073a:	e8 89 02 00 00       	call   8009c8 <cprintf>
  80073f:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800742:	a1 00 30 80 00       	mov    0x803000,%eax
  800747:	ff 75 0c             	pushl  0xc(%ebp)
  80074a:	ff 75 08             	pushl  0x8(%ebp)
  80074d:	50                   	push   %eax
  80074e:	68 91 25 80 00       	push   $0x802591
  800753:	e8 70 02 00 00       	call   8009c8 <cprintf>
  800758:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80075b:	8b 45 10             	mov    0x10(%ebp),%eax
  80075e:	83 ec 08             	sub    $0x8,%esp
  800761:	ff 75 f4             	pushl  -0xc(%ebp)
  800764:	50                   	push   %eax
  800765:	e8 f3 01 00 00       	call   80095d <vcprintf>
  80076a:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80076d:	83 ec 08             	sub    $0x8,%esp
  800770:	6a 00                	push   $0x0
  800772:	68 ad 25 80 00       	push   $0x8025ad
  800777:	e8 e1 01 00 00       	call   80095d <vcprintf>
  80077c:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80077f:	e8 82 ff ff ff       	call   800706 <exit>

	// should not return here
	while (1) ;
  800784:	eb fe                	jmp    800784 <_panic+0x70>

00800786 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800786:	55                   	push   %ebp
  800787:	89 e5                	mov    %esp,%ebp
  800789:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80078c:	a1 24 30 80 00       	mov    0x803024,%eax
  800791:	8b 50 74             	mov    0x74(%eax),%edx
  800794:	8b 45 0c             	mov    0xc(%ebp),%eax
  800797:	39 c2                	cmp    %eax,%edx
  800799:	74 14                	je     8007af <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80079b:	83 ec 04             	sub    $0x4,%esp
  80079e:	68 b0 25 80 00       	push   $0x8025b0
  8007a3:	6a 26                	push   $0x26
  8007a5:	68 fc 25 80 00       	push   $0x8025fc
  8007aa:	e8 65 ff ff ff       	call   800714 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007bd:	e9 c2 00 00 00       	jmp    800884 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007c5:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	01 d0                	add    %edx,%eax
  8007d1:	8b 00                	mov    (%eax),%eax
  8007d3:	85 c0                	test   %eax,%eax
  8007d5:	75 08                	jne    8007df <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007d7:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007da:	e9 a2 00 00 00       	jmp    800881 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007df:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007e6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007ed:	eb 69                	jmp    800858 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f4:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8007fa:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007fd:	89 d0                	mov    %edx,%eax
  8007ff:	01 c0                	add    %eax,%eax
  800801:	01 d0                	add    %edx,%eax
  800803:	c1 e0 03             	shl    $0x3,%eax
  800806:	01 c8                	add    %ecx,%eax
  800808:	8a 40 04             	mov    0x4(%eax),%al
  80080b:	84 c0                	test   %al,%al
  80080d:	75 46                	jne    800855 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80080f:	a1 24 30 80 00       	mov    0x803024,%eax
  800814:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80081a:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80081d:	89 d0                	mov    %edx,%eax
  80081f:	01 c0                	add    %eax,%eax
  800821:	01 d0                	add    %edx,%eax
  800823:	c1 e0 03             	shl    $0x3,%eax
  800826:	01 c8                	add    %ecx,%eax
  800828:	8b 00                	mov    (%eax),%eax
  80082a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80082d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800830:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800835:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800837:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	01 c8                	add    %ecx,%eax
  800846:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800848:	39 c2                	cmp    %eax,%edx
  80084a:	75 09                	jne    800855 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80084c:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800853:	eb 12                	jmp    800867 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800855:	ff 45 e8             	incl   -0x18(%ebp)
  800858:	a1 24 30 80 00       	mov    0x803024,%eax
  80085d:	8b 50 74             	mov    0x74(%eax),%edx
  800860:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800863:	39 c2                	cmp    %eax,%edx
  800865:	77 88                	ja     8007ef <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800867:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80086b:	75 14                	jne    800881 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80086d:	83 ec 04             	sub    $0x4,%esp
  800870:	68 08 26 80 00       	push   $0x802608
  800875:	6a 3a                	push   $0x3a
  800877:	68 fc 25 80 00       	push   $0x8025fc
  80087c:	e8 93 fe ff ff       	call   800714 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800881:	ff 45 f0             	incl   -0x10(%ebp)
  800884:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800887:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80088a:	0f 8c 32 ff ff ff    	jl     8007c2 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800890:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800897:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80089e:	eb 26                	jmp    8008c6 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008a0:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a5:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8008ab:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008ae:	89 d0                	mov    %edx,%eax
  8008b0:	01 c0                	add    %eax,%eax
  8008b2:	01 d0                	add    %edx,%eax
  8008b4:	c1 e0 03             	shl    $0x3,%eax
  8008b7:	01 c8                	add    %ecx,%eax
  8008b9:	8a 40 04             	mov    0x4(%eax),%al
  8008bc:	3c 01                	cmp    $0x1,%al
  8008be:	75 03                	jne    8008c3 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008c0:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008c3:	ff 45 e0             	incl   -0x20(%ebp)
  8008c6:	a1 24 30 80 00       	mov    0x803024,%eax
  8008cb:	8b 50 74             	mov    0x74(%eax),%edx
  8008ce:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008d1:	39 c2                	cmp    %eax,%edx
  8008d3:	77 cb                	ja     8008a0 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008d8:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008db:	74 14                	je     8008f1 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008dd:	83 ec 04             	sub    $0x4,%esp
  8008e0:	68 5c 26 80 00       	push   $0x80265c
  8008e5:	6a 44                	push   $0x44
  8008e7:	68 fc 25 80 00       	push   $0x8025fc
  8008ec:	e8 23 fe ff ff       	call   800714 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008f1:	90                   	nop
  8008f2:	c9                   	leave  
  8008f3:	c3                   	ret    

008008f4 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008f4:	55                   	push   %ebp
  8008f5:	89 e5                	mov    %esp,%ebp
  8008f7:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fd:	8b 00                	mov    (%eax),%eax
  8008ff:	8d 48 01             	lea    0x1(%eax),%ecx
  800902:	8b 55 0c             	mov    0xc(%ebp),%edx
  800905:	89 0a                	mov    %ecx,(%edx)
  800907:	8b 55 08             	mov    0x8(%ebp),%edx
  80090a:	88 d1                	mov    %dl,%cl
  80090c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80090f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800913:	8b 45 0c             	mov    0xc(%ebp),%eax
  800916:	8b 00                	mov    (%eax),%eax
  800918:	3d ff 00 00 00       	cmp    $0xff,%eax
  80091d:	75 2c                	jne    80094b <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80091f:	a0 28 30 80 00       	mov    0x803028,%al
  800924:	0f b6 c0             	movzbl %al,%eax
  800927:	8b 55 0c             	mov    0xc(%ebp),%edx
  80092a:	8b 12                	mov    (%edx),%edx
  80092c:	89 d1                	mov    %edx,%ecx
  80092e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800931:	83 c2 08             	add    $0x8,%edx
  800934:	83 ec 04             	sub    $0x4,%esp
  800937:	50                   	push   %eax
  800938:	51                   	push   %ecx
  800939:	52                   	push   %edx
  80093a:	e8 34 11 00 00       	call   801a73 <sys_cputs>
  80093f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800942:	8b 45 0c             	mov    0xc(%ebp),%eax
  800945:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80094b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80094e:	8b 40 04             	mov    0x4(%eax),%eax
  800951:	8d 50 01             	lea    0x1(%eax),%edx
  800954:	8b 45 0c             	mov    0xc(%ebp),%eax
  800957:	89 50 04             	mov    %edx,0x4(%eax)
}
  80095a:	90                   	nop
  80095b:	c9                   	leave  
  80095c:	c3                   	ret    

0080095d <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80095d:	55                   	push   %ebp
  80095e:	89 e5                	mov    %esp,%ebp
  800960:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800966:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80096d:	00 00 00 
	b.cnt = 0;
  800970:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800977:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  80097a:	ff 75 0c             	pushl  0xc(%ebp)
  80097d:	ff 75 08             	pushl  0x8(%ebp)
  800980:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800986:	50                   	push   %eax
  800987:	68 f4 08 80 00       	push   $0x8008f4
  80098c:	e8 11 02 00 00       	call   800ba2 <vprintfmt>
  800991:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800994:	a0 28 30 80 00       	mov    0x803028,%al
  800999:	0f b6 c0             	movzbl %al,%eax
  80099c:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009a2:	83 ec 04             	sub    $0x4,%esp
  8009a5:	50                   	push   %eax
  8009a6:	52                   	push   %edx
  8009a7:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009ad:	83 c0 08             	add    $0x8,%eax
  8009b0:	50                   	push   %eax
  8009b1:	e8 bd 10 00 00       	call   801a73 <sys_cputs>
  8009b6:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009b9:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  8009c0:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009c6:	c9                   	leave  
  8009c7:	c3                   	ret    

008009c8 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009c8:	55                   	push   %ebp
  8009c9:	89 e5                	mov    %esp,%ebp
  8009cb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009ce:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  8009d5:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009db:	8b 45 08             	mov    0x8(%ebp),%eax
  8009de:	83 ec 08             	sub    $0x8,%esp
  8009e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8009e4:	50                   	push   %eax
  8009e5:	e8 73 ff ff ff       	call   80095d <vcprintf>
  8009ea:	83 c4 10             	add    $0x10,%esp
  8009ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009f3:	c9                   	leave  
  8009f4:	c3                   	ret    

008009f5 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009f5:	55                   	push   %ebp
  8009f6:	89 e5                	mov    %esp,%ebp
  8009f8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009fb:	e8 84 12 00 00       	call   801c84 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a00:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a03:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	83 ec 08             	sub    $0x8,%esp
  800a0c:	ff 75 f4             	pushl  -0xc(%ebp)
  800a0f:	50                   	push   %eax
  800a10:	e8 48 ff ff ff       	call   80095d <vcprintf>
  800a15:	83 c4 10             	add    $0x10,%esp
  800a18:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a1b:	e8 7e 12 00 00       	call   801c9e <sys_enable_interrupt>
	return cnt;
  800a20:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a23:	c9                   	leave  
  800a24:	c3                   	ret    

00800a25 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a25:	55                   	push   %ebp
  800a26:	89 e5                	mov    %esp,%ebp
  800a28:	53                   	push   %ebx
  800a29:	83 ec 14             	sub    $0x14,%esp
  800a2c:	8b 45 10             	mov    0x10(%ebp),%eax
  800a2f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a32:	8b 45 14             	mov    0x14(%ebp),%eax
  800a35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a38:	8b 45 18             	mov    0x18(%ebp),%eax
  800a3b:	ba 00 00 00 00       	mov    $0x0,%edx
  800a40:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a43:	77 55                	ja     800a9a <printnum+0x75>
  800a45:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a48:	72 05                	jb     800a4f <printnum+0x2a>
  800a4a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a4d:	77 4b                	ja     800a9a <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a4f:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a52:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a55:	8b 45 18             	mov    0x18(%ebp),%eax
  800a58:	ba 00 00 00 00       	mov    $0x0,%edx
  800a5d:	52                   	push   %edx
  800a5e:	50                   	push   %eax
  800a5f:	ff 75 f4             	pushl  -0xc(%ebp)
  800a62:	ff 75 f0             	pushl  -0x10(%ebp)
  800a65:	e8 5a 16 00 00       	call   8020c4 <__udivdi3>
  800a6a:	83 c4 10             	add    $0x10,%esp
  800a6d:	83 ec 04             	sub    $0x4,%esp
  800a70:	ff 75 20             	pushl  0x20(%ebp)
  800a73:	53                   	push   %ebx
  800a74:	ff 75 18             	pushl  0x18(%ebp)
  800a77:	52                   	push   %edx
  800a78:	50                   	push   %eax
  800a79:	ff 75 0c             	pushl  0xc(%ebp)
  800a7c:	ff 75 08             	pushl  0x8(%ebp)
  800a7f:	e8 a1 ff ff ff       	call   800a25 <printnum>
  800a84:	83 c4 20             	add    $0x20,%esp
  800a87:	eb 1a                	jmp    800aa3 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a89:	83 ec 08             	sub    $0x8,%esp
  800a8c:	ff 75 0c             	pushl  0xc(%ebp)
  800a8f:	ff 75 20             	pushl  0x20(%ebp)
  800a92:	8b 45 08             	mov    0x8(%ebp),%eax
  800a95:	ff d0                	call   *%eax
  800a97:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a9a:	ff 4d 1c             	decl   0x1c(%ebp)
  800a9d:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aa1:	7f e6                	jg     800a89 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aa3:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800aa6:	bb 00 00 00 00       	mov    $0x0,%ebx
  800aab:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800aae:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ab1:	53                   	push   %ebx
  800ab2:	51                   	push   %ecx
  800ab3:	52                   	push   %edx
  800ab4:	50                   	push   %eax
  800ab5:	e8 1a 17 00 00       	call   8021d4 <__umoddi3>
  800aba:	83 c4 10             	add    $0x10,%esp
  800abd:	05 d4 28 80 00       	add    $0x8028d4,%eax
  800ac2:	8a 00                	mov    (%eax),%al
  800ac4:	0f be c0             	movsbl %al,%eax
  800ac7:	83 ec 08             	sub    $0x8,%esp
  800aca:	ff 75 0c             	pushl  0xc(%ebp)
  800acd:	50                   	push   %eax
  800ace:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad1:	ff d0                	call   *%eax
  800ad3:	83 c4 10             	add    $0x10,%esp
}
  800ad6:	90                   	nop
  800ad7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ada:	c9                   	leave  
  800adb:	c3                   	ret    

00800adc <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800adc:	55                   	push   %ebp
  800add:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800adf:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ae3:	7e 1c                	jle    800b01 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800ae5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae8:	8b 00                	mov    (%eax),%eax
  800aea:	8d 50 08             	lea    0x8(%eax),%edx
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	89 10                	mov    %edx,(%eax)
  800af2:	8b 45 08             	mov    0x8(%ebp),%eax
  800af5:	8b 00                	mov    (%eax),%eax
  800af7:	83 e8 08             	sub    $0x8,%eax
  800afa:	8b 50 04             	mov    0x4(%eax),%edx
  800afd:	8b 00                	mov    (%eax),%eax
  800aff:	eb 40                	jmp    800b41 <getuint+0x65>
	else if (lflag)
  800b01:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b05:	74 1e                	je     800b25 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b07:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0a:	8b 00                	mov    (%eax),%eax
  800b0c:	8d 50 04             	lea    0x4(%eax),%edx
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	89 10                	mov    %edx,(%eax)
  800b14:	8b 45 08             	mov    0x8(%ebp),%eax
  800b17:	8b 00                	mov    (%eax),%eax
  800b19:	83 e8 04             	sub    $0x4,%eax
  800b1c:	8b 00                	mov    (%eax),%eax
  800b1e:	ba 00 00 00 00       	mov    $0x0,%edx
  800b23:	eb 1c                	jmp    800b41 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b25:	8b 45 08             	mov    0x8(%ebp),%eax
  800b28:	8b 00                	mov    (%eax),%eax
  800b2a:	8d 50 04             	lea    0x4(%eax),%edx
  800b2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b30:	89 10                	mov    %edx,(%eax)
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	83 e8 04             	sub    $0x4,%eax
  800b3a:	8b 00                	mov    (%eax),%eax
  800b3c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b41:	5d                   	pop    %ebp
  800b42:	c3                   	ret    

00800b43 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b43:	55                   	push   %ebp
  800b44:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b46:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b4a:	7e 1c                	jle    800b68 <getint+0x25>
		return va_arg(*ap, long long);
  800b4c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4f:	8b 00                	mov    (%eax),%eax
  800b51:	8d 50 08             	lea    0x8(%eax),%edx
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	89 10                	mov    %edx,(%eax)
  800b59:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5c:	8b 00                	mov    (%eax),%eax
  800b5e:	83 e8 08             	sub    $0x8,%eax
  800b61:	8b 50 04             	mov    0x4(%eax),%edx
  800b64:	8b 00                	mov    (%eax),%eax
  800b66:	eb 38                	jmp    800ba0 <getint+0x5d>
	else if (lflag)
  800b68:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b6c:	74 1a                	je     800b88 <getint+0x45>
		return va_arg(*ap, long);
  800b6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b71:	8b 00                	mov    (%eax),%eax
  800b73:	8d 50 04             	lea    0x4(%eax),%edx
  800b76:	8b 45 08             	mov    0x8(%ebp),%eax
  800b79:	89 10                	mov    %edx,(%eax)
  800b7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7e:	8b 00                	mov    (%eax),%eax
  800b80:	83 e8 04             	sub    $0x4,%eax
  800b83:	8b 00                	mov    (%eax),%eax
  800b85:	99                   	cltd   
  800b86:	eb 18                	jmp    800ba0 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b88:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8b:	8b 00                	mov    (%eax),%eax
  800b8d:	8d 50 04             	lea    0x4(%eax),%edx
  800b90:	8b 45 08             	mov    0x8(%ebp),%eax
  800b93:	89 10                	mov    %edx,(%eax)
  800b95:	8b 45 08             	mov    0x8(%ebp),%eax
  800b98:	8b 00                	mov    (%eax),%eax
  800b9a:	83 e8 04             	sub    $0x4,%eax
  800b9d:	8b 00                	mov    (%eax),%eax
  800b9f:	99                   	cltd   
}
  800ba0:	5d                   	pop    %ebp
  800ba1:	c3                   	ret    

00800ba2 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800ba2:	55                   	push   %ebp
  800ba3:	89 e5                	mov    %esp,%ebp
  800ba5:	56                   	push   %esi
  800ba6:	53                   	push   %ebx
  800ba7:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800baa:	eb 17                	jmp    800bc3 <vprintfmt+0x21>
			if (ch == '\0')
  800bac:	85 db                	test   %ebx,%ebx
  800bae:	0f 84 af 03 00 00    	je     800f63 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800bb4:	83 ec 08             	sub    $0x8,%esp
  800bb7:	ff 75 0c             	pushl  0xc(%ebp)
  800bba:	53                   	push   %ebx
  800bbb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbe:	ff d0                	call   *%eax
  800bc0:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800bc6:	8d 50 01             	lea    0x1(%eax),%edx
  800bc9:	89 55 10             	mov    %edx,0x10(%ebp)
  800bcc:	8a 00                	mov    (%eax),%al
  800bce:	0f b6 d8             	movzbl %al,%ebx
  800bd1:	83 fb 25             	cmp    $0x25,%ebx
  800bd4:	75 d6                	jne    800bac <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bd6:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bda:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800be1:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800be8:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bef:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bf6:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf9:	8d 50 01             	lea    0x1(%eax),%edx
  800bfc:	89 55 10             	mov    %edx,0x10(%ebp)
  800bff:	8a 00                	mov    (%eax),%al
  800c01:	0f b6 d8             	movzbl %al,%ebx
  800c04:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c07:	83 f8 55             	cmp    $0x55,%eax
  800c0a:	0f 87 2b 03 00 00    	ja     800f3b <vprintfmt+0x399>
  800c10:	8b 04 85 f8 28 80 00 	mov    0x8028f8(,%eax,4),%eax
  800c17:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c19:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c1d:	eb d7                	jmp    800bf6 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c1f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c23:	eb d1                	jmp    800bf6 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c25:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c2c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c2f:	89 d0                	mov    %edx,%eax
  800c31:	c1 e0 02             	shl    $0x2,%eax
  800c34:	01 d0                	add    %edx,%eax
  800c36:	01 c0                	add    %eax,%eax
  800c38:	01 d8                	add    %ebx,%eax
  800c3a:	83 e8 30             	sub    $0x30,%eax
  800c3d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c40:	8b 45 10             	mov    0x10(%ebp),%eax
  800c43:	8a 00                	mov    (%eax),%al
  800c45:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c48:	83 fb 2f             	cmp    $0x2f,%ebx
  800c4b:	7e 3e                	jle    800c8b <vprintfmt+0xe9>
  800c4d:	83 fb 39             	cmp    $0x39,%ebx
  800c50:	7f 39                	jg     800c8b <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c52:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c55:	eb d5                	jmp    800c2c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c57:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5a:	83 c0 04             	add    $0x4,%eax
  800c5d:	89 45 14             	mov    %eax,0x14(%ebp)
  800c60:	8b 45 14             	mov    0x14(%ebp),%eax
  800c63:	83 e8 04             	sub    $0x4,%eax
  800c66:	8b 00                	mov    (%eax),%eax
  800c68:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c6b:	eb 1f                	jmp    800c8c <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c6d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c71:	79 83                	jns    800bf6 <vprintfmt+0x54>
				width = 0;
  800c73:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c7a:	e9 77 ff ff ff       	jmp    800bf6 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c7f:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c86:	e9 6b ff ff ff       	jmp    800bf6 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c8b:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c8c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c90:	0f 89 60 ff ff ff    	jns    800bf6 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c96:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c99:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c9c:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ca3:	e9 4e ff ff ff       	jmp    800bf6 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ca8:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cab:	e9 46 ff ff ff       	jmp    800bf6 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cb0:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb3:	83 c0 04             	add    $0x4,%eax
  800cb6:	89 45 14             	mov    %eax,0x14(%ebp)
  800cb9:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbc:	83 e8 04             	sub    $0x4,%eax
  800cbf:	8b 00                	mov    (%eax),%eax
  800cc1:	83 ec 08             	sub    $0x8,%esp
  800cc4:	ff 75 0c             	pushl  0xc(%ebp)
  800cc7:	50                   	push   %eax
  800cc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800ccb:	ff d0                	call   *%eax
  800ccd:	83 c4 10             	add    $0x10,%esp
			break;
  800cd0:	e9 89 02 00 00       	jmp    800f5e <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cd5:	8b 45 14             	mov    0x14(%ebp),%eax
  800cd8:	83 c0 04             	add    $0x4,%eax
  800cdb:	89 45 14             	mov    %eax,0x14(%ebp)
  800cde:	8b 45 14             	mov    0x14(%ebp),%eax
  800ce1:	83 e8 04             	sub    $0x4,%eax
  800ce4:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ce6:	85 db                	test   %ebx,%ebx
  800ce8:	79 02                	jns    800cec <vprintfmt+0x14a>
				err = -err;
  800cea:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cec:	83 fb 64             	cmp    $0x64,%ebx
  800cef:	7f 0b                	jg     800cfc <vprintfmt+0x15a>
  800cf1:	8b 34 9d 40 27 80 00 	mov    0x802740(,%ebx,4),%esi
  800cf8:	85 f6                	test   %esi,%esi
  800cfa:	75 19                	jne    800d15 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800cfc:	53                   	push   %ebx
  800cfd:	68 e5 28 80 00       	push   $0x8028e5
  800d02:	ff 75 0c             	pushl  0xc(%ebp)
  800d05:	ff 75 08             	pushl  0x8(%ebp)
  800d08:	e8 5e 02 00 00       	call   800f6b <printfmt>
  800d0d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d10:	e9 49 02 00 00       	jmp    800f5e <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d15:	56                   	push   %esi
  800d16:	68 ee 28 80 00       	push   $0x8028ee
  800d1b:	ff 75 0c             	pushl  0xc(%ebp)
  800d1e:	ff 75 08             	pushl  0x8(%ebp)
  800d21:	e8 45 02 00 00       	call   800f6b <printfmt>
  800d26:	83 c4 10             	add    $0x10,%esp
			break;
  800d29:	e9 30 02 00 00       	jmp    800f5e <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d2e:	8b 45 14             	mov    0x14(%ebp),%eax
  800d31:	83 c0 04             	add    $0x4,%eax
  800d34:	89 45 14             	mov    %eax,0x14(%ebp)
  800d37:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3a:	83 e8 04             	sub    $0x4,%eax
  800d3d:	8b 30                	mov    (%eax),%esi
  800d3f:	85 f6                	test   %esi,%esi
  800d41:	75 05                	jne    800d48 <vprintfmt+0x1a6>
				p = "(null)";
  800d43:	be f1 28 80 00       	mov    $0x8028f1,%esi
			if (width > 0 && padc != '-')
  800d48:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d4c:	7e 6d                	jle    800dbb <vprintfmt+0x219>
  800d4e:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d52:	74 67                	je     800dbb <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d54:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d57:	83 ec 08             	sub    $0x8,%esp
  800d5a:	50                   	push   %eax
  800d5b:	56                   	push   %esi
  800d5c:	e8 12 05 00 00       	call   801273 <strnlen>
  800d61:	83 c4 10             	add    $0x10,%esp
  800d64:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d67:	eb 16                	jmp    800d7f <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d69:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d6d:	83 ec 08             	sub    $0x8,%esp
  800d70:	ff 75 0c             	pushl  0xc(%ebp)
  800d73:	50                   	push   %eax
  800d74:	8b 45 08             	mov    0x8(%ebp),%eax
  800d77:	ff d0                	call   *%eax
  800d79:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d7c:	ff 4d e4             	decl   -0x1c(%ebp)
  800d7f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d83:	7f e4                	jg     800d69 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d85:	eb 34                	jmp    800dbb <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d87:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d8b:	74 1c                	je     800da9 <vprintfmt+0x207>
  800d8d:	83 fb 1f             	cmp    $0x1f,%ebx
  800d90:	7e 05                	jle    800d97 <vprintfmt+0x1f5>
  800d92:	83 fb 7e             	cmp    $0x7e,%ebx
  800d95:	7e 12                	jle    800da9 <vprintfmt+0x207>
					putch('?', putdat);
  800d97:	83 ec 08             	sub    $0x8,%esp
  800d9a:	ff 75 0c             	pushl  0xc(%ebp)
  800d9d:	6a 3f                	push   $0x3f
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	ff d0                	call   *%eax
  800da4:	83 c4 10             	add    $0x10,%esp
  800da7:	eb 0f                	jmp    800db8 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800da9:	83 ec 08             	sub    $0x8,%esp
  800dac:	ff 75 0c             	pushl  0xc(%ebp)
  800daf:	53                   	push   %ebx
  800db0:	8b 45 08             	mov    0x8(%ebp),%eax
  800db3:	ff d0                	call   *%eax
  800db5:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800db8:	ff 4d e4             	decl   -0x1c(%ebp)
  800dbb:	89 f0                	mov    %esi,%eax
  800dbd:	8d 70 01             	lea    0x1(%eax),%esi
  800dc0:	8a 00                	mov    (%eax),%al
  800dc2:	0f be d8             	movsbl %al,%ebx
  800dc5:	85 db                	test   %ebx,%ebx
  800dc7:	74 24                	je     800ded <vprintfmt+0x24b>
  800dc9:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dcd:	78 b8                	js     800d87 <vprintfmt+0x1e5>
  800dcf:	ff 4d e0             	decl   -0x20(%ebp)
  800dd2:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dd6:	79 af                	jns    800d87 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd8:	eb 13                	jmp    800ded <vprintfmt+0x24b>
				putch(' ', putdat);
  800dda:	83 ec 08             	sub    $0x8,%esp
  800ddd:	ff 75 0c             	pushl  0xc(%ebp)
  800de0:	6a 20                	push   $0x20
  800de2:	8b 45 08             	mov    0x8(%ebp),%eax
  800de5:	ff d0                	call   *%eax
  800de7:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dea:	ff 4d e4             	decl   -0x1c(%ebp)
  800ded:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800df1:	7f e7                	jg     800dda <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800df3:	e9 66 01 00 00       	jmp    800f5e <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800df8:	83 ec 08             	sub    $0x8,%esp
  800dfb:	ff 75 e8             	pushl  -0x18(%ebp)
  800dfe:	8d 45 14             	lea    0x14(%ebp),%eax
  800e01:	50                   	push   %eax
  800e02:	e8 3c fd ff ff       	call   800b43 <getint>
  800e07:	83 c4 10             	add    $0x10,%esp
  800e0a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e0d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e10:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e13:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e16:	85 d2                	test   %edx,%edx
  800e18:	79 23                	jns    800e3d <vprintfmt+0x29b>
				putch('-', putdat);
  800e1a:	83 ec 08             	sub    $0x8,%esp
  800e1d:	ff 75 0c             	pushl  0xc(%ebp)
  800e20:	6a 2d                	push   $0x2d
  800e22:	8b 45 08             	mov    0x8(%ebp),%eax
  800e25:	ff d0                	call   *%eax
  800e27:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e2a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e2d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e30:	f7 d8                	neg    %eax
  800e32:	83 d2 00             	adc    $0x0,%edx
  800e35:	f7 da                	neg    %edx
  800e37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e3a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e3d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e44:	e9 bc 00 00 00       	jmp    800f05 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e49:	83 ec 08             	sub    $0x8,%esp
  800e4c:	ff 75 e8             	pushl  -0x18(%ebp)
  800e4f:	8d 45 14             	lea    0x14(%ebp),%eax
  800e52:	50                   	push   %eax
  800e53:	e8 84 fc ff ff       	call   800adc <getuint>
  800e58:	83 c4 10             	add    $0x10,%esp
  800e5b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e5e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e61:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e68:	e9 98 00 00 00       	jmp    800f05 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e6d:	83 ec 08             	sub    $0x8,%esp
  800e70:	ff 75 0c             	pushl  0xc(%ebp)
  800e73:	6a 58                	push   $0x58
  800e75:	8b 45 08             	mov    0x8(%ebp),%eax
  800e78:	ff d0                	call   *%eax
  800e7a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e7d:	83 ec 08             	sub    $0x8,%esp
  800e80:	ff 75 0c             	pushl  0xc(%ebp)
  800e83:	6a 58                	push   $0x58
  800e85:	8b 45 08             	mov    0x8(%ebp),%eax
  800e88:	ff d0                	call   *%eax
  800e8a:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e8d:	83 ec 08             	sub    $0x8,%esp
  800e90:	ff 75 0c             	pushl  0xc(%ebp)
  800e93:	6a 58                	push   $0x58
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	ff d0                	call   *%eax
  800e9a:	83 c4 10             	add    $0x10,%esp
			break;
  800e9d:	e9 bc 00 00 00       	jmp    800f5e <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ea2:	83 ec 08             	sub    $0x8,%esp
  800ea5:	ff 75 0c             	pushl  0xc(%ebp)
  800ea8:	6a 30                	push   $0x30
  800eaa:	8b 45 08             	mov    0x8(%ebp),%eax
  800ead:	ff d0                	call   *%eax
  800eaf:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800eb2:	83 ec 08             	sub    $0x8,%esp
  800eb5:	ff 75 0c             	pushl  0xc(%ebp)
  800eb8:	6a 78                	push   $0x78
  800eba:	8b 45 08             	mov    0x8(%ebp),%eax
  800ebd:	ff d0                	call   *%eax
  800ebf:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ec2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec5:	83 c0 04             	add    $0x4,%eax
  800ec8:	89 45 14             	mov    %eax,0x14(%ebp)
  800ecb:	8b 45 14             	mov    0x14(%ebp),%eax
  800ece:	83 e8 04             	sub    $0x4,%eax
  800ed1:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ed3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ed6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800edd:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ee4:	eb 1f                	jmp    800f05 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ee6:	83 ec 08             	sub    $0x8,%esp
  800ee9:	ff 75 e8             	pushl  -0x18(%ebp)
  800eec:	8d 45 14             	lea    0x14(%ebp),%eax
  800eef:	50                   	push   %eax
  800ef0:	e8 e7 fb ff ff       	call   800adc <getuint>
  800ef5:	83 c4 10             	add    $0x10,%esp
  800ef8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800efb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800efe:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f05:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f09:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f0c:	83 ec 04             	sub    $0x4,%esp
  800f0f:	52                   	push   %edx
  800f10:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f13:	50                   	push   %eax
  800f14:	ff 75 f4             	pushl  -0xc(%ebp)
  800f17:	ff 75 f0             	pushl  -0x10(%ebp)
  800f1a:	ff 75 0c             	pushl  0xc(%ebp)
  800f1d:	ff 75 08             	pushl  0x8(%ebp)
  800f20:	e8 00 fb ff ff       	call   800a25 <printnum>
  800f25:	83 c4 20             	add    $0x20,%esp
			break;
  800f28:	eb 34                	jmp    800f5e <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f2a:	83 ec 08             	sub    $0x8,%esp
  800f2d:	ff 75 0c             	pushl  0xc(%ebp)
  800f30:	53                   	push   %ebx
  800f31:	8b 45 08             	mov    0x8(%ebp),%eax
  800f34:	ff d0                	call   *%eax
  800f36:	83 c4 10             	add    $0x10,%esp
			break;
  800f39:	eb 23                	jmp    800f5e <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f3b:	83 ec 08             	sub    $0x8,%esp
  800f3e:	ff 75 0c             	pushl  0xc(%ebp)
  800f41:	6a 25                	push   $0x25
  800f43:	8b 45 08             	mov    0x8(%ebp),%eax
  800f46:	ff d0                	call   *%eax
  800f48:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f4b:	ff 4d 10             	decl   0x10(%ebp)
  800f4e:	eb 03                	jmp    800f53 <vprintfmt+0x3b1>
  800f50:	ff 4d 10             	decl   0x10(%ebp)
  800f53:	8b 45 10             	mov    0x10(%ebp),%eax
  800f56:	48                   	dec    %eax
  800f57:	8a 00                	mov    (%eax),%al
  800f59:	3c 25                	cmp    $0x25,%al
  800f5b:	75 f3                	jne    800f50 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f5d:	90                   	nop
		}
	}
  800f5e:	e9 47 fc ff ff       	jmp    800baa <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f63:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f64:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f67:	5b                   	pop    %ebx
  800f68:	5e                   	pop    %esi
  800f69:	5d                   	pop    %ebp
  800f6a:	c3                   	ret    

00800f6b <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f6b:	55                   	push   %ebp
  800f6c:	89 e5                	mov    %esp,%ebp
  800f6e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f71:	8d 45 10             	lea    0x10(%ebp),%eax
  800f74:	83 c0 04             	add    $0x4,%eax
  800f77:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f7a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f7d:	ff 75 f4             	pushl  -0xc(%ebp)
  800f80:	50                   	push   %eax
  800f81:	ff 75 0c             	pushl  0xc(%ebp)
  800f84:	ff 75 08             	pushl  0x8(%ebp)
  800f87:	e8 16 fc ff ff       	call   800ba2 <vprintfmt>
  800f8c:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f8f:	90                   	nop
  800f90:	c9                   	leave  
  800f91:	c3                   	ret    

00800f92 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f92:	55                   	push   %ebp
  800f93:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f95:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f98:	8b 40 08             	mov    0x8(%eax),%eax
  800f9b:	8d 50 01             	lea    0x1(%eax),%edx
  800f9e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa1:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800fa4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa7:	8b 10                	mov    (%eax),%edx
  800fa9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fac:	8b 40 04             	mov    0x4(%eax),%eax
  800faf:	39 c2                	cmp    %eax,%edx
  800fb1:	73 12                	jae    800fc5 <sprintputch+0x33>
		*b->buf++ = ch;
  800fb3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fb6:	8b 00                	mov    (%eax),%eax
  800fb8:	8d 48 01             	lea    0x1(%eax),%ecx
  800fbb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fbe:	89 0a                	mov    %ecx,(%edx)
  800fc0:	8b 55 08             	mov    0x8(%ebp),%edx
  800fc3:	88 10                	mov    %dl,(%eax)
}
  800fc5:	90                   	nop
  800fc6:	5d                   	pop    %ebp
  800fc7:	c3                   	ret    

00800fc8 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fc8:	55                   	push   %ebp
  800fc9:	89 e5                	mov    %esp,%ebp
  800fcb:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fce:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd1:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fd7:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fda:	8b 45 08             	mov    0x8(%ebp),%eax
  800fdd:	01 d0                	add    %edx,%eax
  800fdf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fe2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fe9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fed:	74 06                	je     800ff5 <vsnprintf+0x2d>
  800fef:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800ff3:	7f 07                	jg     800ffc <vsnprintf+0x34>
		return -E_INVAL;
  800ff5:	b8 03 00 00 00       	mov    $0x3,%eax
  800ffa:	eb 20                	jmp    80101c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800ffc:	ff 75 14             	pushl  0x14(%ebp)
  800fff:	ff 75 10             	pushl  0x10(%ebp)
  801002:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801005:	50                   	push   %eax
  801006:	68 92 0f 80 00       	push   $0x800f92
  80100b:	e8 92 fb ff ff       	call   800ba2 <vprintfmt>
  801010:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801013:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801016:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801019:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80101c:	c9                   	leave  
  80101d:	c3                   	ret    

0080101e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80101e:	55                   	push   %ebp
  80101f:	89 e5                	mov    %esp,%ebp
  801021:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801024:	8d 45 10             	lea    0x10(%ebp),%eax
  801027:	83 c0 04             	add    $0x4,%eax
  80102a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80102d:	8b 45 10             	mov    0x10(%ebp),%eax
  801030:	ff 75 f4             	pushl  -0xc(%ebp)
  801033:	50                   	push   %eax
  801034:	ff 75 0c             	pushl  0xc(%ebp)
  801037:	ff 75 08             	pushl  0x8(%ebp)
  80103a:	e8 89 ff ff ff       	call   800fc8 <vsnprintf>
  80103f:	83 c4 10             	add    $0x10,%esp
  801042:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801045:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801048:	c9                   	leave  
  801049:	c3                   	ret    

0080104a <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80104a:	55                   	push   %ebp
  80104b:	89 e5                	mov    %esp,%ebp
  80104d:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801050:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801054:	74 13                	je     801069 <readline+0x1f>
		cprintf("%s", prompt);
  801056:	83 ec 08             	sub    $0x8,%esp
  801059:	ff 75 08             	pushl  0x8(%ebp)
  80105c:	68 50 2a 80 00       	push   $0x802a50
  801061:	e8 62 f9 ff ff       	call   8009c8 <cprintf>
  801066:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801069:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801070:	83 ec 0c             	sub    $0xc,%esp
  801073:	6a 00                	push   $0x0
  801075:	e8 74 f5 ff ff       	call   8005ee <iscons>
  80107a:	83 c4 10             	add    $0x10,%esp
  80107d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801080:	e8 1b f5 ff ff       	call   8005a0 <getchar>
  801085:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801088:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80108c:	79 22                	jns    8010b0 <readline+0x66>
			if (c != -E_EOF)
  80108e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801092:	0f 84 ad 00 00 00    	je     801145 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801098:	83 ec 08             	sub    $0x8,%esp
  80109b:	ff 75 ec             	pushl  -0x14(%ebp)
  80109e:	68 53 2a 80 00       	push   $0x802a53
  8010a3:	e8 20 f9 ff ff       	call   8009c8 <cprintf>
  8010a8:	83 c4 10             	add    $0x10,%esp
			return;
  8010ab:	e9 95 00 00 00       	jmp    801145 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010b0:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8010b4:	7e 34                	jle    8010ea <readline+0xa0>
  8010b6:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8010bd:	7f 2b                	jg     8010ea <readline+0xa0>
			if (echoing)
  8010bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010c3:	74 0e                	je     8010d3 <readline+0x89>
				cputchar(c);
  8010c5:	83 ec 0c             	sub    $0xc,%esp
  8010c8:	ff 75 ec             	pushl  -0x14(%ebp)
  8010cb:	e8 88 f4 ff ff       	call   800558 <cputchar>
  8010d0:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8010d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010d6:	8d 50 01             	lea    0x1(%eax),%edx
  8010d9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8010dc:	89 c2                	mov    %eax,%edx
  8010de:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010e1:	01 d0                	add    %edx,%eax
  8010e3:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8010e6:	88 10                	mov    %dl,(%eax)
  8010e8:	eb 56                	jmp    801140 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8010ea:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8010ee:	75 1f                	jne    80110f <readline+0xc5>
  8010f0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8010f4:	7e 19                	jle    80110f <readline+0xc5>
			if (echoing)
  8010f6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8010fa:	74 0e                	je     80110a <readline+0xc0>
				cputchar(c);
  8010fc:	83 ec 0c             	sub    $0xc,%esp
  8010ff:	ff 75 ec             	pushl  -0x14(%ebp)
  801102:	e8 51 f4 ff ff       	call   800558 <cputchar>
  801107:	83 c4 10             	add    $0x10,%esp

			i--;
  80110a:	ff 4d f4             	decl   -0xc(%ebp)
  80110d:	eb 31                	jmp    801140 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80110f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801113:	74 0a                	je     80111f <readline+0xd5>
  801115:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801119:	0f 85 61 ff ff ff    	jne    801080 <readline+0x36>
			if (echoing)
  80111f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801123:	74 0e                	je     801133 <readline+0xe9>
				cputchar(c);
  801125:	83 ec 0c             	sub    $0xc,%esp
  801128:	ff 75 ec             	pushl  -0x14(%ebp)
  80112b:	e8 28 f4 ff ff       	call   800558 <cputchar>
  801130:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801133:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801136:	8b 45 0c             	mov    0xc(%ebp),%eax
  801139:	01 d0                	add    %edx,%eax
  80113b:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80113e:	eb 06                	jmp    801146 <readline+0xfc>
		}
	}
  801140:	e9 3b ff ff ff       	jmp    801080 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801145:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801146:	c9                   	leave  
  801147:	c3                   	ret    

00801148 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801148:	55                   	push   %ebp
  801149:	89 e5                	mov    %esp,%ebp
  80114b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80114e:	e8 31 0b 00 00       	call   801c84 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801153:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801157:	74 13                	je     80116c <atomic_readline+0x24>
		cprintf("%s", prompt);
  801159:	83 ec 08             	sub    $0x8,%esp
  80115c:	ff 75 08             	pushl  0x8(%ebp)
  80115f:	68 50 2a 80 00       	push   $0x802a50
  801164:	e8 5f f8 ff ff       	call   8009c8 <cprintf>
  801169:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80116c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801173:	83 ec 0c             	sub    $0xc,%esp
  801176:	6a 00                	push   $0x0
  801178:	e8 71 f4 ff ff       	call   8005ee <iscons>
  80117d:	83 c4 10             	add    $0x10,%esp
  801180:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801183:	e8 18 f4 ff ff       	call   8005a0 <getchar>
  801188:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80118b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80118f:	79 23                	jns    8011b4 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801191:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801195:	74 13                	je     8011aa <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801197:	83 ec 08             	sub    $0x8,%esp
  80119a:	ff 75 ec             	pushl  -0x14(%ebp)
  80119d:	68 53 2a 80 00       	push   $0x802a53
  8011a2:	e8 21 f8 ff ff       	call   8009c8 <cprintf>
  8011a7:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011aa:	e8 ef 0a 00 00       	call   801c9e <sys_enable_interrupt>
			return;
  8011af:	e9 9a 00 00 00       	jmp    80124e <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8011b4:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8011b8:	7e 34                	jle    8011ee <atomic_readline+0xa6>
  8011ba:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8011c1:	7f 2b                	jg     8011ee <atomic_readline+0xa6>
			if (echoing)
  8011c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011c7:	74 0e                	je     8011d7 <atomic_readline+0x8f>
				cputchar(c);
  8011c9:	83 ec 0c             	sub    $0xc,%esp
  8011cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8011cf:	e8 84 f3 ff ff       	call   800558 <cputchar>
  8011d4:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8011d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011da:	8d 50 01             	lea    0x1(%eax),%edx
  8011dd:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8011e0:	89 c2                	mov    %eax,%edx
  8011e2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e5:	01 d0                	add    %edx,%eax
  8011e7:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8011ea:	88 10                	mov    %dl,(%eax)
  8011ec:	eb 5b                	jmp    801249 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8011ee:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8011f2:	75 1f                	jne    801213 <atomic_readline+0xcb>
  8011f4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8011f8:	7e 19                	jle    801213 <atomic_readline+0xcb>
			if (echoing)
  8011fa:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8011fe:	74 0e                	je     80120e <atomic_readline+0xc6>
				cputchar(c);
  801200:	83 ec 0c             	sub    $0xc,%esp
  801203:	ff 75 ec             	pushl  -0x14(%ebp)
  801206:	e8 4d f3 ff ff       	call   800558 <cputchar>
  80120b:	83 c4 10             	add    $0x10,%esp
			i--;
  80120e:	ff 4d f4             	decl   -0xc(%ebp)
  801211:	eb 36                	jmp    801249 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801213:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801217:	74 0a                	je     801223 <atomic_readline+0xdb>
  801219:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80121d:	0f 85 60 ff ff ff    	jne    801183 <atomic_readline+0x3b>
			if (echoing)
  801223:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801227:	74 0e                	je     801237 <atomic_readline+0xef>
				cputchar(c);
  801229:	83 ec 0c             	sub    $0xc,%esp
  80122c:	ff 75 ec             	pushl  -0x14(%ebp)
  80122f:	e8 24 f3 ff ff       	call   800558 <cputchar>
  801234:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801237:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80123a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80123d:	01 d0                	add    %edx,%eax
  80123f:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801242:	e8 57 0a 00 00       	call   801c9e <sys_enable_interrupt>
			return;
  801247:	eb 05                	jmp    80124e <atomic_readline+0x106>
		}
	}
  801249:	e9 35 ff ff ff       	jmp    801183 <atomic_readline+0x3b>
}
  80124e:	c9                   	leave  
  80124f:	c3                   	ret    

00801250 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801250:	55                   	push   %ebp
  801251:	89 e5                	mov    %esp,%ebp
  801253:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801256:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80125d:	eb 06                	jmp    801265 <strlen+0x15>
		n++;
  80125f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801262:	ff 45 08             	incl   0x8(%ebp)
  801265:	8b 45 08             	mov    0x8(%ebp),%eax
  801268:	8a 00                	mov    (%eax),%al
  80126a:	84 c0                	test   %al,%al
  80126c:	75 f1                	jne    80125f <strlen+0xf>
		n++;
	return n;
  80126e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801271:	c9                   	leave  
  801272:	c3                   	ret    

00801273 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801273:	55                   	push   %ebp
  801274:	89 e5                	mov    %esp,%ebp
  801276:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801279:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801280:	eb 09                	jmp    80128b <strnlen+0x18>
		n++;
  801282:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801285:	ff 45 08             	incl   0x8(%ebp)
  801288:	ff 4d 0c             	decl   0xc(%ebp)
  80128b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80128f:	74 09                	je     80129a <strnlen+0x27>
  801291:	8b 45 08             	mov    0x8(%ebp),%eax
  801294:	8a 00                	mov    (%eax),%al
  801296:	84 c0                	test   %al,%al
  801298:	75 e8                	jne    801282 <strnlen+0xf>
		n++;
	return n;
  80129a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80129d:	c9                   	leave  
  80129e:	c3                   	ret    

0080129f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80129f:	55                   	push   %ebp
  8012a0:	89 e5                	mov    %esp,%ebp
  8012a2:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8012a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012ab:	90                   	nop
  8012ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8012af:	8d 50 01             	lea    0x1(%eax),%edx
  8012b2:	89 55 08             	mov    %edx,0x8(%ebp)
  8012b5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012b8:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012bb:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8012be:	8a 12                	mov    (%edx),%dl
  8012c0:	88 10                	mov    %dl,(%eax)
  8012c2:	8a 00                	mov    (%eax),%al
  8012c4:	84 c0                	test   %al,%al
  8012c6:	75 e4                	jne    8012ac <strcpy+0xd>
		/* do nothing */;
	return ret;
  8012c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012cb:	c9                   	leave  
  8012cc:	c3                   	ret    

008012cd <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8012cd:	55                   	push   %ebp
  8012ce:	89 e5                	mov    %esp,%ebp
  8012d0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8012d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8012d9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012e0:	eb 1f                	jmp    801301 <strncpy+0x34>
		*dst++ = *src;
  8012e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e5:	8d 50 01             	lea    0x1(%eax),%edx
  8012e8:	89 55 08             	mov    %edx,0x8(%ebp)
  8012eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012ee:	8a 12                	mov    (%edx),%dl
  8012f0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8012f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f5:	8a 00                	mov    (%eax),%al
  8012f7:	84 c0                	test   %al,%al
  8012f9:	74 03                	je     8012fe <strncpy+0x31>
			src++;
  8012fb:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8012fe:	ff 45 fc             	incl   -0x4(%ebp)
  801301:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801304:	3b 45 10             	cmp    0x10(%ebp),%eax
  801307:	72 d9                	jb     8012e2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801309:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80130c:	c9                   	leave  
  80130d:	c3                   	ret    

0080130e <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
  801311:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801314:	8b 45 08             	mov    0x8(%ebp),%eax
  801317:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80131a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80131e:	74 30                	je     801350 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801320:	eb 16                	jmp    801338 <strlcpy+0x2a>
			*dst++ = *src++;
  801322:	8b 45 08             	mov    0x8(%ebp),%eax
  801325:	8d 50 01             	lea    0x1(%eax),%edx
  801328:	89 55 08             	mov    %edx,0x8(%ebp)
  80132b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80132e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801331:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801334:	8a 12                	mov    (%edx),%dl
  801336:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801338:	ff 4d 10             	decl   0x10(%ebp)
  80133b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80133f:	74 09                	je     80134a <strlcpy+0x3c>
  801341:	8b 45 0c             	mov    0xc(%ebp),%eax
  801344:	8a 00                	mov    (%eax),%al
  801346:	84 c0                	test   %al,%al
  801348:	75 d8                	jne    801322 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80134a:	8b 45 08             	mov    0x8(%ebp),%eax
  80134d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801350:	8b 55 08             	mov    0x8(%ebp),%edx
  801353:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801356:	29 c2                	sub    %eax,%edx
  801358:	89 d0                	mov    %edx,%eax
}
  80135a:	c9                   	leave  
  80135b:	c3                   	ret    

0080135c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80135f:	eb 06                	jmp    801367 <strcmp+0xb>
		p++, q++;
  801361:	ff 45 08             	incl   0x8(%ebp)
  801364:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801367:	8b 45 08             	mov    0x8(%ebp),%eax
  80136a:	8a 00                	mov    (%eax),%al
  80136c:	84 c0                	test   %al,%al
  80136e:	74 0e                	je     80137e <strcmp+0x22>
  801370:	8b 45 08             	mov    0x8(%ebp),%eax
  801373:	8a 10                	mov    (%eax),%dl
  801375:	8b 45 0c             	mov    0xc(%ebp),%eax
  801378:	8a 00                	mov    (%eax),%al
  80137a:	38 c2                	cmp    %al,%dl
  80137c:	74 e3                	je     801361 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80137e:	8b 45 08             	mov    0x8(%ebp),%eax
  801381:	8a 00                	mov    (%eax),%al
  801383:	0f b6 d0             	movzbl %al,%edx
  801386:	8b 45 0c             	mov    0xc(%ebp),%eax
  801389:	8a 00                	mov    (%eax),%al
  80138b:	0f b6 c0             	movzbl %al,%eax
  80138e:	29 c2                	sub    %eax,%edx
  801390:	89 d0                	mov    %edx,%eax
}
  801392:	5d                   	pop    %ebp
  801393:	c3                   	ret    

00801394 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801397:	eb 09                	jmp    8013a2 <strncmp+0xe>
		n--, p++, q++;
  801399:	ff 4d 10             	decl   0x10(%ebp)
  80139c:	ff 45 08             	incl   0x8(%ebp)
  80139f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013a2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013a6:	74 17                	je     8013bf <strncmp+0x2b>
  8013a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ab:	8a 00                	mov    (%eax),%al
  8013ad:	84 c0                	test   %al,%al
  8013af:	74 0e                	je     8013bf <strncmp+0x2b>
  8013b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b4:	8a 10                	mov    (%eax),%dl
  8013b6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b9:	8a 00                	mov    (%eax),%al
  8013bb:	38 c2                	cmp    %al,%dl
  8013bd:	74 da                	je     801399 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8013bf:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013c3:	75 07                	jne    8013cc <strncmp+0x38>
		return 0;
  8013c5:	b8 00 00 00 00       	mov    $0x0,%eax
  8013ca:	eb 14                	jmp    8013e0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8013cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cf:	8a 00                	mov    (%eax),%al
  8013d1:	0f b6 d0             	movzbl %al,%edx
  8013d4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d7:	8a 00                	mov    (%eax),%al
  8013d9:	0f b6 c0             	movzbl %al,%eax
  8013dc:	29 c2                	sub    %eax,%edx
  8013de:	89 d0                	mov    %edx,%eax
}
  8013e0:	5d                   	pop    %ebp
  8013e1:	c3                   	ret    

008013e2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8013e2:	55                   	push   %ebp
  8013e3:	89 e5                	mov    %esp,%ebp
  8013e5:	83 ec 04             	sub    $0x4,%esp
  8013e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013eb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8013ee:	eb 12                	jmp    801402 <strchr+0x20>
		if (*s == c)
  8013f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f3:	8a 00                	mov    (%eax),%al
  8013f5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8013f8:	75 05                	jne    8013ff <strchr+0x1d>
			return (char *) s;
  8013fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8013fd:	eb 11                	jmp    801410 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8013ff:	ff 45 08             	incl   0x8(%ebp)
  801402:	8b 45 08             	mov    0x8(%ebp),%eax
  801405:	8a 00                	mov    (%eax),%al
  801407:	84 c0                	test   %al,%al
  801409:	75 e5                	jne    8013f0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80140b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
  801415:	83 ec 04             	sub    $0x4,%esp
  801418:	8b 45 0c             	mov    0xc(%ebp),%eax
  80141b:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80141e:	eb 0d                	jmp    80142d <strfind+0x1b>
		if (*s == c)
  801420:	8b 45 08             	mov    0x8(%ebp),%eax
  801423:	8a 00                	mov    (%eax),%al
  801425:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801428:	74 0e                	je     801438 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80142a:	ff 45 08             	incl   0x8(%ebp)
  80142d:	8b 45 08             	mov    0x8(%ebp),%eax
  801430:	8a 00                	mov    (%eax),%al
  801432:	84 c0                	test   %al,%al
  801434:	75 ea                	jne    801420 <strfind+0xe>
  801436:	eb 01                	jmp    801439 <strfind+0x27>
		if (*s == c)
			break;
  801438:	90                   	nop
	return (char *) s;
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80143c:	c9                   	leave  
  80143d:	c3                   	ret    

0080143e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80143e:	55                   	push   %ebp
  80143f:	89 e5                	mov    %esp,%ebp
  801441:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801444:	8b 45 08             	mov    0x8(%ebp),%eax
  801447:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80144a:	8b 45 10             	mov    0x10(%ebp),%eax
  80144d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801450:	eb 0e                	jmp    801460 <memset+0x22>
		*p++ = c;
  801452:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801455:	8d 50 01             	lea    0x1(%eax),%edx
  801458:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80145b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80145e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801460:	ff 4d f8             	decl   -0x8(%ebp)
  801463:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801467:	79 e9                	jns    801452 <memset+0x14>
		*p++ = c;

	return v;
  801469:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
  801471:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801474:	8b 45 0c             	mov    0xc(%ebp),%eax
  801477:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80147a:	8b 45 08             	mov    0x8(%ebp),%eax
  80147d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801480:	eb 16                	jmp    801498 <memcpy+0x2a>
		*d++ = *s++;
  801482:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801485:	8d 50 01             	lea    0x1(%eax),%edx
  801488:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80148b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80148e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801491:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801494:	8a 12                	mov    (%edx),%dl
  801496:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801498:	8b 45 10             	mov    0x10(%ebp),%eax
  80149b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80149e:	89 55 10             	mov    %edx,0x10(%ebp)
  8014a1:	85 c0                	test   %eax,%eax
  8014a3:	75 dd                	jne    801482 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014a5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014a8:	c9                   	leave  
  8014a9:	c3                   	ret    

008014aa <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014aa:	55                   	push   %ebp
  8014ab:	89 e5                	mov    %esp,%ebp
  8014ad:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8014bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014bf:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014c2:	73 50                	jae    801514 <memmove+0x6a>
  8014c4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014ca:	01 d0                	add    %edx,%eax
  8014cc:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8014cf:	76 43                	jbe    801514 <memmove+0x6a>
		s += n;
  8014d1:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8014d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014da:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8014dd:	eb 10                	jmp    8014ef <memmove+0x45>
			*--d = *--s;
  8014df:	ff 4d f8             	decl   -0x8(%ebp)
  8014e2:	ff 4d fc             	decl   -0x4(%ebp)
  8014e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014e8:	8a 10                	mov    (%eax),%dl
  8014ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014ed:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8014ef:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014f5:	89 55 10             	mov    %edx,0x10(%ebp)
  8014f8:	85 c0                	test   %eax,%eax
  8014fa:	75 e3                	jne    8014df <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8014fc:	eb 23                	jmp    801521 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8014fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801501:	8d 50 01             	lea    0x1(%eax),%edx
  801504:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801507:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80150a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80150d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801510:	8a 12                	mov    (%edx),%dl
  801512:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801514:	8b 45 10             	mov    0x10(%ebp),%eax
  801517:	8d 50 ff             	lea    -0x1(%eax),%edx
  80151a:	89 55 10             	mov    %edx,0x10(%ebp)
  80151d:	85 c0                	test   %eax,%eax
  80151f:	75 dd                	jne    8014fe <memmove+0x54>
			*d++ = *s++;

	return dst;
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801524:	c9                   	leave  
  801525:	c3                   	ret    

00801526 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801526:	55                   	push   %ebp
  801527:	89 e5                	mov    %esp,%ebp
  801529:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80152c:	8b 45 08             	mov    0x8(%ebp),%eax
  80152f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801532:	8b 45 0c             	mov    0xc(%ebp),%eax
  801535:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801538:	eb 2a                	jmp    801564 <memcmp+0x3e>
		if (*s1 != *s2)
  80153a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80153d:	8a 10                	mov    (%eax),%dl
  80153f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801542:	8a 00                	mov    (%eax),%al
  801544:	38 c2                	cmp    %al,%dl
  801546:	74 16                	je     80155e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801548:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80154b:	8a 00                	mov    (%eax),%al
  80154d:	0f b6 d0             	movzbl %al,%edx
  801550:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801553:	8a 00                	mov    (%eax),%al
  801555:	0f b6 c0             	movzbl %al,%eax
  801558:	29 c2                	sub    %eax,%edx
  80155a:	89 d0                	mov    %edx,%eax
  80155c:	eb 18                	jmp    801576 <memcmp+0x50>
		s1++, s2++;
  80155e:	ff 45 fc             	incl   -0x4(%ebp)
  801561:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801564:	8b 45 10             	mov    0x10(%ebp),%eax
  801567:	8d 50 ff             	lea    -0x1(%eax),%edx
  80156a:	89 55 10             	mov    %edx,0x10(%ebp)
  80156d:	85 c0                	test   %eax,%eax
  80156f:	75 c9                	jne    80153a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801571:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801576:	c9                   	leave  
  801577:	c3                   	ret    

00801578 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801578:	55                   	push   %ebp
  801579:	89 e5                	mov    %esp,%ebp
  80157b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80157e:	8b 55 08             	mov    0x8(%ebp),%edx
  801581:	8b 45 10             	mov    0x10(%ebp),%eax
  801584:	01 d0                	add    %edx,%eax
  801586:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801589:	eb 15                	jmp    8015a0 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80158b:	8b 45 08             	mov    0x8(%ebp),%eax
  80158e:	8a 00                	mov    (%eax),%al
  801590:	0f b6 d0             	movzbl %al,%edx
  801593:	8b 45 0c             	mov    0xc(%ebp),%eax
  801596:	0f b6 c0             	movzbl %al,%eax
  801599:	39 c2                	cmp    %eax,%edx
  80159b:	74 0d                	je     8015aa <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80159d:	ff 45 08             	incl   0x8(%ebp)
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015a6:	72 e3                	jb     80158b <memfind+0x13>
  8015a8:	eb 01                	jmp    8015ab <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015aa:	90                   	nop
	return (void *) s;
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ae:	c9                   	leave  
  8015af:	c3                   	ret    

008015b0 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015b0:	55                   	push   %ebp
  8015b1:	89 e5                	mov    %esp,%ebp
  8015b3:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8015b6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8015bd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015c4:	eb 03                	jmp    8015c9 <strtol+0x19>
		s++;
  8015c6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8015c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015cc:	8a 00                	mov    (%eax),%al
  8015ce:	3c 20                	cmp    $0x20,%al
  8015d0:	74 f4                	je     8015c6 <strtol+0x16>
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	8a 00                	mov    (%eax),%al
  8015d7:	3c 09                	cmp    $0x9,%al
  8015d9:	74 eb                	je     8015c6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8015db:	8b 45 08             	mov    0x8(%ebp),%eax
  8015de:	8a 00                	mov    (%eax),%al
  8015e0:	3c 2b                	cmp    $0x2b,%al
  8015e2:	75 05                	jne    8015e9 <strtol+0x39>
		s++;
  8015e4:	ff 45 08             	incl   0x8(%ebp)
  8015e7:	eb 13                	jmp    8015fc <strtol+0x4c>
	else if (*s == '-')
  8015e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ec:	8a 00                	mov    (%eax),%al
  8015ee:	3c 2d                	cmp    $0x2d,%al
  8015f0:	75 0a                	jne    8015fc <strtol+0x4c>
		s++, neg = 1;
  8015f2:	ff 45 08             	incl   0x8(%ebp)
  8015f5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8015fc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801600:	74 06                	je     801608 <strtol+0x58>
  801602:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801606:	75 20                	jne    801628 <strtol+0x78>
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
  80160b:	8a 00                	mov    (%eax),%al
  80160d:	3c 30                	cmp    $0x30,%al
  80160f:	75 17                	jne    801628 <strtol+0x78>
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	40                   	inc    %eax
  801615:	8a 00                	mov    (%eax),%al
  801617:	3c 78                	cmp    $0x78,%al
  801619:	75 0d                	jne    801628 <strtol+0x78>
		s += 2, base = 16;
  80161b:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80161f:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801626:	eb 28                	jmp    801650 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801628:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80162c:	75 15                	jne    801643 <strtol+0x93>
  80162e:	8b 45 08             	mov    0x8(%ebp),%eax
  801631:	8a 00                	mov    (%eax),%al
  801633:	3c 30                	cmp    $0x30,%al
  801635:	75 0c                	jne    801643 <strtol+0x93>
		s++, base = 8;
  801637:	ff 45 08             	incl   0x8(%ebp)
  80163a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801641:	eb 0d                	jmp    801650 <strtol+0xa0>
	else if (base == 0)
  801643:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801647:	75 07                	jne    801650 <strtol+0xa0>
		base = 10;
  801649:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801650:	8b 45 08             	mov    0x8(%ebp),%eax
  801653:	8a 00                	mov    (%eax),%al
  801655:	3c 2f                	cmp    $0x2f,%al
  801657:	7e 19                	jle    801672 <strtol+0xc2>
  801659:	8b 45 08             	mov    0x8(%ebp),%eax
  80165c:	8a 00                	mov    (%eax),%al
  80165e:	3c 39                	cmp    $0x39,%al
  801660:	7f 10                	jg     801672 <strtol+0xc2>
			dig = *s - '0';
  801662:	8b 45 08             	mov    0x8(%ebp),%eax
  801665:	8a 00                	mov    (%eax),%al
  801667:	0f be c0             	movsbl %al,%eax
  80166a:	83 e8 30             	sub    $0x30,%eax
  80166d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801670:	eb 42                	jmp    8016b4 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
  801675:	8a 00                	mov    (%eax),%al
  801677:	3c 60                	cmp    $0x60,%al
  801679:	7e 19                	jle    801694 <strtol+0xe4>
  80167b:	8b 45 08             	mov    0x8(%ebp),%eax
  80167e:	8a 00                	mov    (%eax),%al
  801680:	3c 7a                	cmp    $0x7a,%al
  801682:	7f 10                	jg     801694 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801684:	8b 45 08             	mov    0x8(%ebp),%eax
  801687:	8a 00                	mov    (%eax),%al
  801689:	0f be c0             	movsbl %al,%eax
  80168c:	83 e8 57             	sub    $0x57,%eax
  80168f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801692:	eb 20                	jmp    8016b4 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801694:	8b 45 08             	mov    0x8(%ebp),%eax
  801697:	8a 00                	mov    (%eax),%al
  801699:	3c 40                	cmp    $0x40,%al
  80169b:	7e 39                	jle    8016d6 <strtol+0x126>
  80169d:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a0:	8a 00                	mov    (%eax),%al
  8016a2:	3c 5a                	cmp    $0x5a,%al
  8016a4:	7f 30                	jg     8016d6 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a9:	8a 00                	mov    (%eax),%al
  8016ab:	0f be c0             	movsbl %al,%eax
  8016ae:	83 e8 37             	sub    $0x37,%eax
  8016b1:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8016b4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016b7:	3b 45 10             	cmp    0x10(%ebp),%eax
  8016ba:	7d 19                	jge    8016d5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8016bc:	ff 45 08             	incl   0x8(%ebp)
  8016bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016c2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8016c6:	89 c2                	mov    %eax,%edx
  8016c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8016cb:	01 d0                	add    %edx,%eax
  8016cd:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8016d0:	e9 7b ff ff ff       	jmp    801650 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8016d5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8016d6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8016da:	74 08                	je     8016e4 <strtol+0x134>
		*endptr = (char *) s;
  8016dc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016df:	8b 55 08             	mov    0x8(%ebp),%edx
  8016e2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8016e4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8016e8:	74 07                	je     8016f1 <strtol+0x141>
  8016ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ed:	f7 d8                	neg    %eax
  8016ef:	eb 03                	jmp    8016f4 <strtol+0x144>
  8016f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8016f4:	c9                   	leave  
  8016f5:	c3                   	ret    

008016f6 <ltostr>:

void
ltostr(long value, char *str)
{
  8016f6:	55                   	push   %ebp
  8016f7:	89 e5                	mov    %esp,%ebp
  8016f9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8016fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801703:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80170a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80170e:	79 13                	jns    801723 <ltostr+0x2d>
	{
		neg = 1;
  801710:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801717:	8b 45 0c             	mov    0xc(%ebp),%eax
  80171a:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80171d:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801720:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801723:	8b 45 08             	mov    0x8(%ebp),%eax
  801726:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80172b:	99                   	cltd   
  80172c:	f7 f9                	idiv   %ecx
  80172e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801731:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801734:	8d 50 01             	lea    0x1(%eax),%edx
  801737:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80173a:	89 c2                	mov    %eax,%edx
  80173c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173f:	01 d0                	add    %edx,%eax
  801741:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801744:	83 c2 30             	add    $0x30,%edx
  801747:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801749:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80174c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801751:	f7 e9                	imul   %ecx
  801753:	c1 fa 02             	sar    $0x2,%edx
  801756:	89 c8                	mov    %ecx,%eax
  801758:	c1 f8 1f             	sar    $0x1f,%eax
  80175b:	29 c2                	sub    %eax,%edx
  80175d:	89 d0                	mov    %edx,%eax
  80175f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801762:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801765:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80176a:	f7 e9                	imul   %ecx
  80176c:	c1 fa 02             	sar    $0x2,%edx
  80176f:	89 c8                	mov    %ecx,%eax
  801771:	c1 f8 1f             	sar    $0x1f,%eax
  801774:	29 c2                	sub    %eax,%edx
  801776:	89 d0                	mov    %edx,%eax
  801778:	c1 e0 02             	shl    $0x2,%eax
  80177b:	01 d0                	add    %edx,%eax
  80177d:	01 c0                	add    %eax,%eax
  80177f:	29 c1                	sub    %eax,%ecx
  801781:	89 ca                	mov    %ecx,%edx
  801783:	85 d2                	test   %edx,%edx
  801785:	75 9c                	jne    801723 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801787:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80178e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801791:	48                   	dec    %eax
  801792:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801795:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801799:	74 3d                	je     8017d8 <ltostr+0xe2>
		start = 1 ;
  80179b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017a2:	eb 34                	jmp    8017d8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017a4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017aa:	01 d0                	add    %edx,%eax
  8017ac:	8a 00                	mov    (%eax),%al
  8017ae:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017b1:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017b7:	01 c2                	add    %eax,%edx
  8017b9:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8017bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017bf:	01 c8                	add    %ecx,%eax
  8017c1:	8a 00                	mov    (%eax),%al
  8017c3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8017c5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8017c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017cb:	01 c2                	add    %eax,%edx
  8017cd:	8a 45 eb             	mov    -0x15(%ebp),%al
  8017d0:	88 02                	mov    %al,(%edx)
		start++ ;
  8017d2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8017d5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8017d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8017db:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8017de:	7c c4                	jl     8017a4 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8017e0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8017e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017e6:	01 d0                	add    %edx,%eax
  8017e8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8017eb:	90                   	nop
  8017ec:	c9                   	leave  
  8017ed:	c3                   	ret    

008017ee <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8017ee:	55                   	push   %ebp
  8017ef:	89 e5                	mov    %esp,%ebp
  8017f1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8017f4:	ff 75 08             	pushl  0x8(%ebp)
  8017f7:	e8 54 fa ff ff       	call   801250 <strlen>
  8017fc:	83 c4 04             	add    $0x4,%esp
  8017ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801802:	ff 75 0c             	pushl  0xc(%ebp)
  801805:	e8 46 fa ff ff       	call   801250 <strlen>
  80180a:	83 c4 04             	add    $0x4,%esp
  80180d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801810:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801817:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80181e:	eb 17                	jmp    801837 <strcconcat+0x49>
		final[s] = str1[s] ;
  801820:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801823:	8b 45 10             	mov    0x10(%ebp),%eax
  801826:	01 c2                	add    %eax,%edx
  801828:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
  80182e:	01 c8                	add    %ecx,%eax
  801830:	8a 00                	mov    (%eax),%al
  801832:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801834:	ff 45 fc             	incl   -0x4(%ebp)
  801837:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80183a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80183d:	7c e1                	jl     801820 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80183f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801846:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80184d:	eb 1f                	jmp    80186e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80184f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801852:	8d 50 01             	lea    0x1(%eax),%edx
  801855:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801858:	89 c2                	mov    %eax,%edx
  80185a:	8b 45 10             	mov    0x10(%ebp),%eax
  80185d:	01 c2                	add    %eax,%edx
  80185f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801862:	8b 45 0c             	mov    0xc(%ebp),%eax
  801865:	01 c8                	add    %ecx,%eax
  801867:	8a 00                	mov    (%eax),%al
  801869:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80186b:	ff 45 f8             	incl   -0x8(%ebp)
  80186e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801871:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801874:	7c d9                	jl     80184f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801876:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801879:	8b 45 10             	mov    0x10(%ebp),%eax
  80187c:	01 d0                	add    %edx,%eax
  80187e:	c6 00 00             	movb   $0x0,(%eax)
}
  801881:	90                   	nop
  801882:	c9                   	leave  
  801883:	c3                   	ret    

00801884 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801884:	55                   	push   %ebp
  801885:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801887:	8b 45 14             	mov    0x14(%ebp),%eax
  80188a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801890:	8b 45 14             	mov    0x14(%ebp),%eax
  801893:	8b 00                	mov    (%eax),%eax
  801895:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80189c:	8b 45 10             	mov    0x10(%ebp),%eax
  80189f:	01 d0                	add    %edx,%eax
  8018a1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018a7:	eb 0c                	jmp    8018b5 <strsplit+0x31>
			*string++ = 0;
  8018a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ac:	8d 50 01             	lea    0x1(%eax),%edx
  8018af:	89 55 08             	mov    %edx,0x8(%ebp)
  8018b2:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	8a 00                	mov    (%eax),%al
  8018ba:	84 c0                	test   %al,%al
  8018bc:	74 18                	je     8018d6 <strsplit+0x52>
  8018be:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c1:	8a 00                	mov    (%eax),%al
  8018c3:	0f be c0             	movsbl %al,%eax
  8018c6:	50                   	push   %eax
  8018c7:	ff 75 0c             	pushl  0xc(%ebp)
  8018ca:	e8 13 fb ff ff       	call   8013e2 <strchr>
  8018cf:	83 c4 08             	add    $0x8,%esp
  8018d2:	85 c0                	test   %eax,%eax
  8018d4:	75 d3                	jne    8018a9 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8018d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d9:	8a 00                	mov    (%eax),%al
  8018db:	84 c0                	test   %al,%al
  8018dd:	74 5a                	je     801939 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8018df:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e2:	8b 00                	mov    (%eax),%eax
  8018e4:	83 f8 0f             	cmp    $0xf,%eax
  8018e7:	75 07                	jne    8018f0 <strsplit+0x6c>
		{
			return 0;
  8018e9:	b8 00 00 00 00       	mov    $0x0,%eax
  8018ee:	eb 66                	jmp    801956 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8018f0:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f3:	8b 00                	mov    (%eax),%eax
  8018f5:	8d 48 01             	lea    0x1(%eax),%ecx
  8018f8:	8b 55 14             	mov    0x14(%ebp),%edx
  8018fb:	89 0a                	mov    %ecx,(%edx)
  8018fd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801904:	8b 45 10             	mov    0x10(%ebp),%eax
  801907:	01 c2                	add    %eax,%edx
  801909:	8b 45 08             	mov    0x8(%ebp),%eax
  80190c:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80190e:	eb 03                	jmp    801913 <strsplit+0x8f>
			string++;
  801910:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801913:	8b 45 08             	mov    0x8(%ebp),%eax
  801916:	8a 00                	mov    (%eax),%al
  801918:	84 c0                	test   %al,%al
  80191a:	74 8b                	je     8018a7 <strsplit+0x23>
  80191c:	8b 45 08             	mov    0x8(%ebp),%eax
  80191f:	8a 00                	mov    (%eax),%al
  801921:	0f be c0             	movsbl %al,%eax
  801924:	50                   	push   %eax
  801925:	ff 75 0c             	pushl  0xc(%ebp)
  801928:	e8 b5 fa ff ff       	call   8013e2 <strchr>
  80192d:	83 c4 08             	add    $0x8,%esp
  801930:	85 c0                	test   %eax,%eax
  801932:	74 dc                	je     801910 <strsplit+0x8c>
			string++;
	}
  801934:	e9 6e ff ff ff       	jmp    8018a7 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801939:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80193a:	8b 45 14             	mov    0x14(%ebp),%eax
  80193d:	8b 00                	mov    (%eax),%eax
  80193f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801946:	8b 45 10             	mov    0x10(%ebp),%eax
  801949:	01 d0                	add    %edx,%eax
  80194b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801951:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801956:	c9                   	leave  
  801957:	c3                   	ret    

00801958 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801958:	55                   	push   %ebp
  801959:	89 e5                	mov    %esp,%ebp
  80195b:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  80195e:	83 ec 04             	sub    $0x4,%esp
  801961:	68 64 2a 80 00       	push   $0x802a64
  801966:	6a 15                	push   $0x15
  801968:	68 89 2a 80 00       	push   $0x802a89
  80196d:	e8 a2 ed ff ff       	call   800714 <_panic>

00801972 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801972:	55                   	push   %ebp
  801973:	89 e5                	mov    %esp,%ebp
  801975:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801978:	83 ec 04             	sub    $0x4,%esp
  80197b:	68 98 2a 80 00       	push   $0x802a98
  801980:	6a 2e                	push   $0x2e
  801982:	68 89 2a 80 00       	push   $0x802a89
  801987:	e8 88 ed ff ff       	call   800714 <_panic>

0080198c <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  80198c:	55                   	push   %ebp
  80198d:	89 e5                	mov    %esp,%ebp
  80198f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801992:	83 ec 04             	sub    $0x4,%esp
  801995:	68 bc 2a 80 00       	push   $0x802abc
  80199a:	6a 4c                	push   $0x4c
  80199c:	68 89 2a 80 00       	push   $0x802a89
  8019a1:	e8 6e ed ff ff       	call   800714 <_panic>

008019a6 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019a6:	55                   	push   %ebp
  8019a7:	89 e5                	mov    %esp,%ebp
  8019a9:	83 ec 18             	sub    $0x18,%esp
  8019ac:	8b 45 10             	mov    0x10(%ebp),%eax
  8019af:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8019b2:	83 ec 04             	sub    $0x4,%esp
  8019b5:	68 bc 2a 80 00       	push   $0x802abc
  8019ba:	6a 57                	push   $0x57
  8019bc:	68 89 2a 80 00       	push   $0x802a89
  8019c1:	e8 4e ed ff ff       	call   800714 <_panic>

008019c6 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8019c6:	55                   	push   %ebp
  8019c7:	89 e5                	mov    %esp,%ebp
  8019c9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019cc:	83 ec 04             	sub    $0x4,%esp
  8019cf:	68 bc 2a 80 00       	push   $0x802abc
  8019d4:	6a 5d                	push   $0x5d
  8019d6:	68 89 2a 80 00       	push   $0x802a89
  8019db:	e8 34 ed ff ff       	call   800714 <_panic>

008019e0 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
  8019e3:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019e6:	83 ec 04             	sub    $0x4,%esp
  8019e9:	68 bc 2a 80 00       	push   $0x802abc
  8019ee:	6a 63                	push   $0x63
  8019f0:	68 89 2a 80 00       	push   $0x802a89
  8019f5:	e8 1a ed ff ff       	call   800714 <_panic>

008019fa <expand>:
}

void expand(uint32 newSize)
{
  8019fa:	55                   	push   %ebp
  8019fb:	89 e5                	mov    %esp,%ebp
  8019fd:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a00:	83 ec 04             	sub    $0x4,%esp
  801a03:	68 bc 2a 80 00       	push   $0x802abc
  801a08:	6a 68                	push   $0x68
  801a0a:	68 89 2a 80 00       	push   $0x802a89
  801a0f:	e8 00 ed ff ff       	call   800714 <_panic>

00801a14 <shrink>:
}
void shrink(uint32 newSize)
{
  801a14:	55                   	push   %ebp
  801a15:	89 e5                	mov    %esp,%ebp
  801a17:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a1a:	83 ec 04             	sub    $0x4,%esp
  801a1d:	68 bc 2a 80 00       	push   $0x802abc
  801a22:	6a 6c                	push   $0x6c
  801a24:	68 89 2a 80 00       	push   $0x802a89
  801a29:	e8 e6 ec ff ff       	call   800714 <_panic>

00801a2e <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801a2e:	55                   	push   %ebp
  801a2f:	89 e5                	mov    %esp,%ebp
  801a31:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a34:	83 ec 04             	sub    $0x4,%esp
  801a37:	68 bc 2a 80 00       	push   $0x802abc
  801a3c:	6a 71                	push   $0x71
  801a3e:	68 89 2a 80 00       	push   $0x802a89
  801a43:	e8 cc ec ff ff       	call   800714 <_panic>

00801a48 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a48:	55                   	push   %ebp
  801a49:	89 e5                	mov    %esp,%ebp
  801a4b:	57                   	push   %edi
  801a4c:	56                   	push   %esi
  801a4d:	53                   	push   %ebx
  801a4e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a51:	8b 45 08             	mov    0x8(%ebp),%eax
  801a54:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a57:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a5a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a5d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801a60:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801a63:	cd 30                	int    $0x30
  801a65:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801a6b:	83 c4 10             	add    $0x10,%esp
  801a6e:	5b                   	pop    %ebx
  801a6f:	5e                   	pop    %esi
  801a70:	5f                   	pop    %edi
  801a71:	5d                   	pop    %ebp
  801a72:	c3                   	ret    

00801a73 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
  801a76:	83 ec 04             	sub    $0x4,%esp
  801a79:	8b 45 10             	mov    0x10(%ebp),%eax
  801a7c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801a7f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a83:	8b 45 08             	mov    0x8(%ebp),%eax
  801a86:	6a 00                	push   $0x0
  801a88:	6a 00                	push   $0x0
  801a8a:	52                   	push   %edx
  801a8b:	ff 75 0c             	pushl  0xc(%ebp)
  801a8e:	50                   	push   %eax
  801a8f:	6a 00                	push   $0x0
  801a91:	e8 b2 ff ff ff       	call   801a48 <syscall>
  801a96:	83 c4 18             	add    $0x18,%esp
}
  801a99:	90                   	nop
  801a9a:	c9                   	leave  
  801a9b:	c3                   	ret    

00801a9c <sys_cgetc>:

int
sys_cgetc(void)
{
  801a9c:	55                   	push   %ebp
  801a9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801a9f:	6a 00                	push   $0x0
  801aa1:	6a 00                	push   $0x0
  801aa3:	6a 00                	push   $0x0
  801aa5:	6a 00                	push   $0x0
  801aa7:	6a 00                	push   $0x0
  801aa9:	6a 01                	push   $0x1
  801aab:	e8 98 ff ff ff       	call   801a48 <syscall>
  801ab0:	83 c4 18             	add    $0x18,%esp
}
  801ab3:	c9                   	leave  
  801ab4:	c3                   	ret    

00801ab5 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801ab5:	55                   	push   %ebp
  801ab6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  801abb:	6a 00                	push   $0x0
  801abd:	6a 00                	push   $0x0
  801abf:	6a 00                	push   $0x0
  801ac1:	6a 00                	push   $0x0
  801ac3:	50                   	push   %eax
  801ac4:	6a 05                	push   $0x5
  801ac6:	e8 7d ff ff ff       	call   801a48 <syscall>
  801acb:	83 c4 18             	add    $0x18,%esp
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	6a 00                	push   $0x0
  801add:	6a 02                	push   $0x2
  801adf:	e8 64 ff ff ff       	call   801a48 <syscall>
  801ae4:	83 c4 18             	add    $0x18,%esp
}
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	6a 00                	push   $0x0
  801af4:	6a 00                	push   $0x0
  801af6:	6a 03                	push   $0x3
  801af8:	e8 4b ff ff ff       	call   801a48 <syscall>
  801afd:	83 c4 18             	add    $0x18,%esp
}
  801b00:	c9                   	leave  
  801b01:	c3                   	ret    

00801b02 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b02:	55                   	push   %ebp
  801b03:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b05:	6a 00                	push   $0x0
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	6a 04                	push   $0x4
  801b11:	e8 32 ff ff ff       	call   801a48 <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
}
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <sys_env_exit>:


void sys_env_exit(void)
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b1e:	6a 00                	push   $0x0
  801b20:	6a 00                	push   $0x0
  801b22:	6a 00                	push   $0x0
  801b24:	6a 00                	push   $0x0
  801b26:	6a 00                	push   $0x0
  801b28:	6a 06                	push   $0x6
  801b2a:	e8 19 ff ff ff       	call   801a48 <syscall>
  801b2f:	83 c4 18             	add    $0x18,%esp
}
  801b32:	90                   	nop
  801b33:	c9                   	leave  
  801b34:	c3                   	ret    

00801b35 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b35:	55                   	push   %ebp
  801b36:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b38:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b3b:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 00                	push   $0x0
  801b44:	52                   	push   %edx
  801b45:	50                   	push   %eax
  801b46:	6a 07                	push   $0x7
  801b48:	e8 fb fe ff ff       	call   801a48 <syscall>
  801b4d:	83 c4 18             	add    $0x18,%esp
}
  801b50:	c9                   	leave  
  801b51:	c3                   	ret    

00801b52 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b52:	55                   	push   %ebp
  801b53:	89 e5                	mov    %esp,%ebp
  801b55:	56                   	push   %esi
  801b56:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801b57:	8b 75 18             	mov    0x18(%ebp),%esi
  801b5a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b5d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b60:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b63:	8b 45 08             	mov    0x8(%ebp),%eax
  801b66:	56                   	push   %esi
  801b67:	53                   	push   %ebx
  801b68:	51                   	push   %ecx
  801b69:	52                   	push   %edx
  801b6a:	50                   	push   %eax
  801b6b:	6a 08                	push   $0x8
  801b6d:	e8 d6 fe ff ff       	call   801a48 <syscall>
  801b72:	83 c4 18             	add    $0x18,%esp
}
  801b75:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801b78:	5b                   	pop    %ebx
  801b79:	5e                   	pop    %esi
  801b7a:	5d                   	pop    %ebp
  801b7b:	c3                   	ret    

00801b7c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801b7c:	55                   	push   %ebp
  801b7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801b7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b82:	8b 45 08             	mov    0x8(%ebp),%eax
  801b85:	6a 00                	push   $0x0
  801b87:	6a 00                	push   $0x0
  801b89:	6a 00                	push   $0x0
  801b8b:	52                   	push   %edx
  801b8c:	50                   	push   %eax
  801b8d:	6a 09                	push   $0x9
  801b8f:	e8 b4 fe ff ff       	call   801a48 <syscall>
  801b94:	83 c4 18             	add    $0x18,%esp
}
  801b97:	c9                   	leave  
  801b98:	c3                   	ret    

00801b99 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801b99:	55                   	push   %ebp
  801b9a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801b9c:	6a 00                	push   $0x0
  801b9e:	6a 00                	push   $0x0
  801ba0:	6a 00                	push   $0x0
  801ba2:	ff 75 0c             	pushl  0xc(%ebp)
  801ba5:	ff 75 08             	pushl  0x8(%ebp)
  801ba8:	6a 0a                	push   $0xa
  801baa:	e8 99 fe ff ff       	call   801a48 <syscall>
  801baf:	83 c4 18             	add    $0x18,%esp
}
  801bb2:	c9                   	leave  
  801bb3:	c3                   	ret    

00801bb4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801bb4:	55                   	push   %ebp
  801bb5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801bb7:	6a 00                	push   $0x0
  801bb9:	6a 00                	push   $0x0
  801bbb:	6a 00                	push   $0x0
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 0b                	push   $0xb
  801bc3:	e8 80 fe ff ff       	call   801a48 <syscall>
  801bc8:	83 c4 18             	add    $0x18,%esp
}
  801bcb:	c9                   	leave  
  801bcc:	c3                   	ret    

00801bcd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801bcd:	55                   	push   %ebp
  801bce:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801bd0:	6a 00                	push   $0x0
  801bd2:	6a 00                	push   $0x0
  801bd4:	6a 00                	push   $0x0
  801bd6:	6a 00                	push   $0x0
  801bd8:	6a 00                	push   $0x0
  801bda:	6a 0c                	push   $0xc
  801bdc:	e8 67 fe ff ff       	call   801a48 <syscall>
  801be1:	83 c4 18             	add    $0x18,%esp
}
  801be4:	c9                   	leave  
  801be5:	c3                   	ret    

00801be6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801be6:	55                   	push   %ebp
  801be7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801be9:	6a 00                	push   $0x0
  801beb:	6a 00                	push   $0x0
  801bed:	6a 00                	push   $0x0
  801bef:	6a 00                	push   $0x0
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 0d                	push   $0xd
  801bf5:	e8 4e fe ff ff       	call   801a48 <syscall>
  801bfa:	83 c4 18             	add    $0x18,%esp
}
  801bfd:	c9                   	leave  
  801bfe:	c3                   	ret    

00801bff <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c02:	6a 00                	push   $0x0
  801c04:	6a 00                	push   $0x0
  801c06:	6a 00                	push   $0x0
  801c08:	ff 75 0c             	pushl  0xc(%ebp)
  801c0b:	ff 75 08             	pushl  0x8(%ebp)
  801c0e:	6a 11                	push   $0x11
  801c10:	e8 33 fe ff ff       	call   801a48 <syscall>
  801c15:	83 c4 18             	add    $0x18,%esp
	return;
  801c18:	90                   	nop
}
  801c19:	c9                   	leave  
  801c1a:	c3                   	ret    

00801c1b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c1b:	55                   	push   %ebp
  801c1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	ff 75 0c             	pushl  0xc(%ebp)
  801c27:	ff 75 08             	pushl  0x8(%ebp)
  801c2a:	6a 12                	push   $0x12
  801c2c:	e8 17 fe ff ff       	call   801a48 <syscall>
  801c31:	83 c4 18             	add    $0x18,%esp
	return ;
  801c34:	90                   	nop
}
  801c35:	c9                   	leave  
  801c36:	c3                   	ret    

00801c37 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c37:	55                   	push   %ebp
  801c38:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c3a:	6a 00                	push   $0x0
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 0e                	push   $0xe
  801c46:	e8 fd fd ff ff       	call   801a48 <syscall>
  801c4b:	83 c4 18             	add    $0x18,%esp
}
  801c4e:	c9                   	leave  
  801c4f:	c3                   	ret    

00801c50 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c50:	55                   	push   %ebp
  801c51:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	6a 00                	push   $0x0
  801c59:	6a 00                	push   $0x0
  801c5b:	ff 75 08             	pushl  0x8(%ebp)
  801c5e:	6a 0f                	push   $0xf
  801c60:	e8 e3 fd ff ff       	call   801a48 <syscall>
  801c65:	83 c4 18             	add    $0x18,%esp
}
  801c68:	c9                   	leave  
  801c69:	c3                   	ret    

00801c6a <sys_scarce_memory>:

void sys_scarce_memory()
{
  801c6a:	55                   	push   %ebp
  801c6b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801c6d:	6a 00                	push   $0x0
  801c6f:	6a 00                	push   $0x0
  801c71:	6a 00                	push   $0x0
  801c73:	6a 00                	push   $0x0
  801c75:	6a 00                	push   $0x0
  801c77:	6a 10                	push   $0x10
  801c79:	e8 ca fd ff ff       	call   801a48 <syscall>
  801c7e:	83 c4 18             	add    $0x18,%esp
}
  801c81:	90                   	nop
  801c82:	c9                   	leave  
  801c83:	c3                   	ret    

00801c84 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801c84:	55                   	push   %ebp
  801c85:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801c87:	6a 00                	push   $0x0
  801c89:	6a 00                	push   $0x0
  801c8b:	6a 00                	push   $0x0
  801c8d:	6a 00                	push   $0x0
  801c8f:	6a 00                	push   $0x0
  801c91:	6a 14                	push   $0x14
  801c93:	e8 b0 fd ff ff       	call   801a48 <syscall>
  801c98:	83 c4 18             	add    $0x18,%esp
}
  801c9b:	90                   	nop
  801c9c:	c9                   	leave  
  801c9d:	c3                   	ret    

00801c9e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801c9e:	55                   	push   %ebp
  801c9f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	6a 00                	push   $0x0
  801cab:	6a 15                	push   $0x15
  801cad:	e8 96 fd ff ff       	call   801a48 <syscall>
  801cb2:	83 c4 18             	add    $0x18,%esp
}
  801cb5:	90                   	nop
  801cb6:	c9                   	leave  
  801cb7:	c3                   	ret    

00801cb8 <sys_cputc>:


void
sys_cputc(const char c)
{
  801cb8:	55                   	push   %ebp
  801cb9:	89 e5                	mov    %esp,%ebp
  801cbb:	83 ec 04             	sub    $0x4,%esp
  801cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  801cc1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801cc4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801cc8:	6a 00                	push   $0x0
  801cca:	6a 00                	push   $0x0
  801ccc:	6a 00                	push   $0x0
  801cce:	6a 00                	push   $0x0
  801cd0:	50                   	push   %eax
  801cd1:	6a 16                	push   $0x16
  801cd3:	e8 70 fd ff ff       	call   801a48 <syscall>
  801cd8:	83 c4 18             	add    $0x18,%esp
}
  801cdb:	90                   	nop
  801cdc:	c9                   	leave  
  801cdd:	c3                   	ret    

00801cde <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801cde:	55                   	push   %ebp
  801cdf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801ce1:	6a 00                	push   $0x0
  801ce3:	6a 00                	push   $0x0
  801ce5:	6a 00                	push   $0x0
  801ce7:	6a 00                	push   $0x0
  801ce9:	6a 00                	push   $0x0
  801ceb:	6a 17                	push   $0x17
  801ced:	e8 56 fd ff ff       	call   801a48 <syscall>
  801cf2:	83 c4 18             	add    $0x18,%esp
}
  801cf5:	90                   	nop
  801cf6:	c9                   	leave  
  801cf7:	c3                   	ret    

00801cf8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801cf8:	55                   	push   %ebp
  801cf9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801cfb:	8b 45 08             	mov    0x8(%ebp),%eax
  801cfe:	6a 00                	push   $0x0
  801d00:	6a 00                	push   $0x0
  801d02:	6a 00                	push   $0x0
  801d04:	ff 75 0c             	pushl  0xc(%ebp)
  801d07:	50                   	push   %eax
  801d08:	6a 18                	push   $0x18
  801d0a:	e8 39 fd ff ff       	call   801a48 <syscall>
  801d0f:	83 c4 18             	add    $0x18,%esp
}
  801d12:	c9                   	leave  
  801d13:	c3                   	ret    

00801d14 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d14:	55                   	push   %ebp
  801d15:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d17:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	6a 00                	push   $0x0
  801d23:	52                   	push   %edx
  801d24:	50                   	push   %eax
  801d25:	6a 1b                	push   $0x1b
  801d27:	e8 1c fd ff ff       	call   801a48 <syscall>
  801d2c:	83 c4 18             	add    $0x18,%esp
}
  801d2f:	c9                   	leave  
  801d30:	c3                   	ret    

00801d31 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d31:	55                   	push   %ebp
  801d32:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d34:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d37:	8b 45 08             	mov    0x8(%ebp),%eax
  801d3a:	6a 00                	push   $0x0
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	52                   	push   %edx
  801d41:	50                   	push   %eax
  801d42:	6a 19                	push   $0x19
  801d44:	e8 ff fc ff ff       	call   801a48 <syscall>
  801d49:	83 c4 18             	add    $0x18,%esp
}
  801d4c:	90                   	nop
  801d4d:	c9                   	leave  
  801d4e:	c3                   	ret    

00801d4f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d4f:	55                   	push   %ebp
  801d50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d55:	8b 45 08             	mov    0x8(%ebp),%eax
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	52                   	push   %edx
  801d5f:	50                   	push   %eax
  801d60:	6a 1a                	push   $0x1a
  801d62:	e8 e1 fc ff ff       	call   801a48 <syscall>
  801d67:	83 c4 18             	add    $0x18,%esp
}
  801d6a:	90                   	nop
  801d6b:	c9                   	leave  
  801d6c:	c3                   	ret    

00801d6d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801d6d:	55                   	push   %ebp
  801d6e:	89 e5                	mov    %esp,%ebp
  801d70:	83 ec 04             	sub    $0x4,%esp
  801d73:	8b 45 10             	mov    0x10(%ebp),%eax
  801d76:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801d79:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801d7c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d80:	8b 45 08             	mov    0x8(%ebp),%eax
  801d83:	6a 00                	push   $0x0
  801d85:	51                   	push   %ecx
  801d86:	52                   	push   %edx
  801d87:	ff 75 0c             	pushl  0xc(%ebp)
  801d8a:	50                   	push   %eax
  801d8b:	6a 1c                	push   $0x1c
  801d8d:	e8 b6 fc ff ff       	call   801a48 <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801d9a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 00                	push   $0x0
  801da6:	52                   	push   %edx
  801da7:	50                   	push   %eax
  801da8:	6a 1d                	push   $0x1d
  801daa:	e8 99 fc ff ff       	call   801a48 <syscall>
  801daf:	83 c4 18             	add    $0x18,%esp
}
  801db2:	c9                   	leave  
  801db3:	c3                   	ret    

00801db4 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801db4:	55                   	push   %ebp
  801db5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801db7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dba:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc0:	6a 00                	push   $0x0
  801dc2:	6a 00                	push   $0x0
  801dc4:	51                   	push   %ecx
  801dc5:	52                   	push   %edx
  801dc6:	50                   	push   %eax
  801dc7:	6a 1e                	push   $0x1e
  801dc9:	e8 7a fc ff ff       	call   801a48 <syscall>
  801dce:	83 c4 18             	add    $0x18,%esp
}
  801dd1:	c9                   	leave  
  801dd2:	c3                   	ret    

00801dd3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801dd3:	55                   	push   %ebp
  801dd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801dd6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddc:	6a 00                	push   $0x0
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	52                   	push   %edx
  801de3:	50                   	push   %eax
  801de4:	6a 1f                	push   $0x1f
  801de6:	e8 5d fc ff ff       	call   801a48 <syscall>
  801deb:	83 c4 18             	add    $0x18,%esp
}
  801dee:	c9                   	leave  
  801def:	c3                   	ret    

00801df0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801df0:	55                   	push   %ebp
  801df1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801df3:	6a 00                	push   $0x0
  801df5:	6a 00                	push   $0x0
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 20                	push   $0x20
  801dff:	e8 44 fc ff ff       	call   801a48 <syscall>
  801e04:	83 c4 18             	add    $0x18,%esp
}
  801e07:	c9                   	leave  
  801e08:	c3                   	ret    

00801e09 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e09:	55                   	push   %ebp
  801e0a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0f:	6a 00                	push   $0x0
  801e11:	ff 75 14             	pushl  0x14(%ebp)
  801e14:	ff 75 10             	pushl  0x10(%ebp)
  801e17:	ff 75 0c             	pushl  0xc(%ebp)
  801e1a:	50                   	push   %eax
  801e1b:	6a 21                	push   $0x21
  801e1d:	e8 26 fc ff ff       	call   801a48 <syscall>
  801e22:	83 c4 18             	add    $0x18,%esp
}
  801e25:	c9                   	leave  
  801e26:	c3                   	ret    

00801e27 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801e27:	55                   	push   %ebp
  801e28:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801e2d:	6a 00                	push   $0x0
  801e2f:	6a 00                	push   $0x0
  801e31:	6a 00                	push   $0x0
  801e33:	6a 00                	push   $0x0
  801e35:	50                   	push   %eax
  801e36:	6a 22                	push   $0x22
  801e38:	e8 0b fc ff ff       	call   801a48 <syscall>
  801e3d:	83 c4 18             	add    $0x18,%esp
}
  801e40:	90                   	nop
  801e41:	c9                   	leave  
  801e42:	c3                   	ret    

00801e43 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e43:	55                   	push   %ebp
  801e44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e46:	8b 45 08             	mov    0x8(%ebp),%eax
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	50                   	push   %eax
  801e52:	6a 23                	push   $0x23
  801e54:	e8 ef fb ff ff       	call   801a48 <syscall>
  801e59:	83 c4 18             	add    $0x18,%esp
}
  801e5c:	90                   	nop
  801e5d:	c9                   	leave  
  801e5e:	c3                   	ret    

00801e5f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801e5f:	55                   	push   %ebp
  801e60:	89 e5                	mov    %esp,%ebp
  801e62:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801e65:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e68:	8d 50 04             	lea    0x4(%eax),%edx
  801e6b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	52                   	push   %edx
  801e75:	50                   	push   %eax
  801e76:	6a 24                	push   $0x24
  801e78:	e8 cb fb ff ff       	call   801a48 <syscall>
  801e7d:	83 c4 18             	add    $0x18,%esp
	return result;
  801e80:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801e83:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801e86:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801e89:	89 01                	mov    %eax,(%ecx)
  801e8b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801e8e:	8b 45 08             	mov    0x8(%ebp),%eax
  801e91:	c9                   	leave  
  801e92:	c2 04 00             	ret    $0x4

00801e95 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	ff 75 10             	pushl  0x10(%ebp)
  801e9f:	ff 75 0c             	pushl  0xc(%ebp)
  801ea2:	ff 75 08             	pushl  0x8(%ebp)
  801ea5:	6a 13                	push   $0x13
  801ea7:	e8 9c fb ff ff       	call   801a48 <syscall>
  801eac:	83 c4 18             	add    $0x18,%esp
	return ;
  801eaf:	90                   	nop
}
  801eb0:	c9                   	leave  
  801eb1:	c3                   	ret    

00801eb2 <sys_rcr2>:
uint32 sys_rcr2()
{
  801eb2:	55                   	push   %ebp
  801eb3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	6a 00                	push   $0x0
  801ebb:	6a 00                	push   $0x0
  801ebd:	6a 00                	push   $0x0
  801ebf:	6a 25                	push   $0x25
  801ec1:	e8 82 fb ff ff       	call   801a48 <syscall>
  801ec6:	83 c4 18             	add    $0x18,%esp
}
  801ec9:	c9                   	leave  
  801eca:	c3                   	ret    

00801ecb <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801ecb:	55                   	push   %ebp
  801ecc:	89 e5                	mov    %esp,%ebp
  801ece:	83 ec 04             	sub    $0x4,%esp
  801ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ed4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ed7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	50                   	push   %eax
  801ee4:	6a 26                	push   $0x26
  801ee6:	e8 5d fb ff ff       	call   801a48 <syscall>
  801eeb:	83 c4 18             	add    $0x18,%esp
	return ;
  801eee:	90                   	nop
}
  801eef:	c9                   	leave  
  801ef0:	c3                   	ret    

00801ef1 <rsttst>:
void rsttst()
{
  801ef1:	55                   	push   %ebp
  801ef2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 28                	push   $0x28
  801f00:	e8 43 fb ff ff       	call   801a48 <syscall>
  801f05:	83 c4 18             	add    $0x18,%esp
	return ;
  801f08:	90                   	nop
}
  801f09:	c9                   	leave  
  801f0a:	c3                   	ret    

00801f0b <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f0b:	55                   	push   %ebp
  801f0c:	89 e5                	mov    %esp,%ebp
  801f0e:	83 ec 04             	sub    $0x4,%esp
  801f11:	8b 45 14             	mov    0x14(%ebp),%eax
  801f14:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f17:	8b 55 18             	mov    0x18(%ebp),%edx
  801f1a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f1e:	52                   	push   %edx
  801f1f:	50                   	push   %eax
  801f20:	ff 75 10             	pushl  0x10(%ebp)
  801f23:	ff 75 0c             	pushl  0xc(%ebp)
  801f26:	ff 75 08             	pushl  0x8(%ebp)
  801f29:	6a 27                	push   $0x27
  801f2b:	e8 18 fb ff ff       	call   801a48 <syscall>
  801f30:	83 c4 18             	add    $0x18,%esp
	return ;
  801f33:	90                   	nop
}
  801f34:	c9                   	leave  
  801f35:	c3                   	ret    

00801f36 <chktst>:
void chktst(uint32 n)
{
  801f36:	55                   	push   %ebp
  801f37:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f39:	6a 00                	push   $0x0
  801f3b:	6a 00                	push   $0x0
  801f3d:	6a 00                	push   $0x0
  801f3f:	6a 00                	push   $0x0
  801f41:	ff 75 08             	pushl  0x8(%ebp)
  801f44:	6a 29                	push   $0x29
  801f46:	e8 fd fa ff ff       	call   801a48 <syscall>
  801f4b:	83 c4 18             	add    $0x18,%esp
	return ;
  801f4e:	90                   	nop
}
  801f4f:	c9                   	leave  
  801f50:	c3                   	ret    

00801f51 <inctst>:

void inctst()
{
  801f51:	55                   	push   %ebp
  801f52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801f54:	6a 00                	push   $0x0
  801f56:	6a 00                	push   $0x0
  801f58:	6a 00                	push   $0x0
  801f5a:	6a 00                	push   $0x0
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 2a                	push   $0x2a
  801f60:	e8 e3 fa ff ff       	call   801a48 <syscall>
  801f65:	83 c4 18             	add    $0x18,%esp
	return ;
  801f68:	90                   	nop
}
  801f69:	c9                   	leave  
  801f6a:	c3                   	ret    

00801f6b <gettst>:
uint32 gettst()
{
  801f6b:	55                   	push   %ebp
  801f6c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801f6e:	6a 00                	push   $0x0
  801f70:	6a 00                	push   $0x0
  801f72:	6a 00                	push   $0x0
  801f74:	6a 00                	push   $0x0
  801f76:	6a 00                	push   $0x0
  801f78:	6a 2b                	push   $0x2b
  801f7a:	e8 c9 fa ff ff       	call   801a48 <syscall>
  801f7f:	83 c4 18             	add    $0x18,%esp
}
  801f82:	c9                   	leave  
  801f83:	c3                   	ret    

00801f84 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801f84:	55                   	push   %ebp
  801f85:	89 e5                	mov    %esp,%ebp
  801f87:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801f8a:	6a 00                	push   $0x0
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	6a 00                	push   $0x0
  801f94:	6a 2c                	push   $0x2c
  801f96:	e8 ad fa ff ff       	call   801a48 <syscall>
  801f9b:	83 c4 18             	add    $0x18,%esp
  801f9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801fa1:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801fa5:	75 07                	jne    801fae <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801fa7:	b8 01 00 00 00       	mov    $0x1,%eax
  801fac:	eb 05                	jmp    801fb3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801fae:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fb3:	c9                   	leave  
  801fb4:	c3                   	ret    

00801fb5 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801fb5:	55                   	push   %ebp
  801fb6:	89 e5                	mov    %esp,%ebp
  801fb8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fbb:	6a 00                	push   $0x0
  801fbd:	6a 00                	push   $0x0
  801fbf:	6a 00                	push   $0x0
  801fc1:	6a 00                	push   $0x0
  801fc3:	6a 00                	push   $0x0
  801fc5:	6a 2c                	push   $0x2c
  801fc7:	e8 7c fa ff ff       	call   801a48 <syscall>
  801fcc:	83 c4 18             	add    $0x18,%esp
  801fcf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801fd2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801fd6:	75 07                	jne    801fdf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801fd8:	b8 01 00 00 00       	mov    $0x1,%eax
  801fdd:	eb 05                	jmp    801fe4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801fdf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fe4:	c9                   	leave  
  801fe5:	c3                   	ret    

00801fe6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801fe6:	55                   	push   %ebp
  801fe7:	89 e5                	mov    %esp,%ebp
  801fe9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fec:	6a 00                	push   $0x0
  801fee:	6a 00                	push   $0x0
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	6a 2c                	push   $0x2c
  801ff8:	e8 4b fa ff ff       	call   801a48 <syscall>
  801ffd:	83 c4 18             	add    $0x18,%esp
  802000:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802003:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802007:	75 07                	jne    802010 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802009:	b8 01 00 00 00       	mov    $0x1,%eax
  80200e:	eb 05                	jmp    802015 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802010:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802015:	c9                   	leave  
  802016:	c3                   	ret    

00802017 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802017:	55                   	push   %ebp
  802018:	89 e5                	mov    %esp,%ebp
  80201a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80201d:	6a 00                	push   $0x0
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	6a 00                	push   $0x0
  802025:	6a 00                	push   $0x0
  802027:	6a 2c                	push   $0x2c
  802029:	e8 1a fa ff ff       	call   801a48 <syscall>
  80202e:	83 c4 18             	add    $0x18,%esp
  802031:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802034:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802038:	75 07                	jne    802041 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80203a:	b8 01 00 00 00       	mov    $0x1,%eax
  80203f:	eb 05                	jmp    802046 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802041:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802046:	c9                   	leave  
  802047:	c3                   	ret    

00802048 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802048:	55                   	push   %ebp
  802049:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80204b:	6a 00                	push   $0x0
  80204d:	6a 00                	push   $0x0
  80204f:	6a 00                	push   $0x0
  802051:	6a 00                	push   $0x0
  802053:	ff 75 08             	pushl  0x8(%ebp)
  802056:	6a 2d                	push   $0x2d
  802058:	e8 eb f9 ff ff       	call   801a48 <syscall>
  80205d:	83 c4 18             	add    $0x18,%esp
	return ;
  802060:	90                   	nop
}
  802061:	c9                   	leave  
  802062:	c3                   	ret    

00802063 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802063:	55                   	push   %ebp
  802064:	89 e5                	mov    %esp,%ebp
  802066:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802067:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80206a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80206d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802070:	8b 45 08             	mov    0x8(%ebp),%eax
  802073:	6a 00                	push   $0x0
  802075:	53                   	push   %ebx
  802076:	51                   	push   %ecx
  802077:	52                   	push   %edx
  802078:	50                   	push   %eax
  802079:	6a 2e                	push   $0x2e
  80207b:	e8 c8 f9 ff ff       	call   801a48 <syscall>
  802080:	83 c4 18             	add    $0x18,%esp
}
  802083:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802086:	c9                   	leave  
  802087:	c3                   	ret    

00802088 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802088:	55                   	push   %ebp
  802089:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80208b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80208e:	8b 45 08             	mov    0x8(%ebp),%eax
  802091:	6a 00                	push   $0x0
  802093:	6a 00                	push   $0x0
  802095:	6a 00                	push   $0x0
  802097:	52                   	push   %edx
  802098:	50                   	push   %eax
  802099:	6a 2f                	push   $0x2f
  80209b:	e8 a8 f9 ff ff       	call   801a48 <syscall>
  8020a0:	83 c4 18             	add    $0x18,%esp
}
  8020a3:	c9                   	leave  
  8020a4:	c3                   	ret    

008020a5 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8020a5:	55                   	push   %ebp
  8020a6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	ff 75 0c             	pushl  0xc(%ebp)
  8020b1:	ff 75 08             	pushl  0x8(%ebp)
  8020b4:	6a 30                	push   $0x30
  8020b6:	e8 8d f9 ff ff       	call   801a48 <syscall>
  8020bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8020be:	90                   	nop
}
  8020bf:	c9                   	leave  
  8020c0:	c3                   	ret    
  8020c1:	66 90                	xchg   %ax,%ax
  8020c3:	90                   	nop

008020c4 <__udivdi3>:
  8020c4:	55                   	push   %ebp
  8020c5:	57                   	push   %edi
  8020c6:	56                   	push   %esi
  8020c7:	53                   	push   %ebx
  8020c8:	83 ec 1c             	sub    $0x1c,%esp
  8020cb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8020cf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8020d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8020d7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8020db:	89 ca                	mov    %ecx,%edx
  8020dd:	89 f8                	mov    %edi,%eax
  8020df:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8020e3:	85 f6                	test   %esi,%esi
  8020e5:	75 2d                	jne    802114 <__udivdi3+0x50>
  8020e7:	39 cf                	cmp    %ecx,%edi
  8020e9:	77 65                	ja     802150 <__udivdi3+0x8c>
  8020eb:	89 fd                	mov    %edi,%ebp
  8020ed:	85 ff                	test   %edi,%edi
  8020ef:	75 0b                	jne    8020fc <__udivdi3+0x38>
  8020f1:	b8 01 00 00 00       	mov    $0x1,%eax
  8020f6:	31 d2                	xor    %edx,%edx
  8020f8:	f7 f7                	div    %edi
  8020fa:	89 c5                	mov    %eax,%ebp
  8020fc:	31 d2                	xor    %edx,%edx
  8020fe:	89 c8                	mov    %ecx,%eax
  802100:	f7 f5                	div    %ebp
  802102:	89 c1                	mov    %eax,%ecx
  802104:	89 d8                	mov    %ebx,%eax
  802106:	f7 f5                	div    %ebp
  802108:	89 cf                	mov    %ecx,%edi
  80210a:	89 fa                	mov    %edi,%edx
  80210c:	83 c4 1c             	add    $0x1c,%esp
  80210f:	5b                   	pop    %ebx
  802110:	5e                   	pop    %esi
  802111:	5f                   	pop    %edi
  802112:	5d                   	pop    %ebp
  802113:	c3                   	ret    
  802114:	39 ce                	cmp    %ecx,%esi
  802116:	77 28                	ja     802140 <__udivdi3+0x7c>
  802118:	0f bd fe             	bsr    %esi,%edi
  80211b:	83 f7 1f             	xor    $0x1f,%edi
  80211e:	75 40                	jne    802160 <__udivdi3+0x9c>
  802120:	39 ce                	cmp    %ecx,%esi
  802122:	72 0a                	jb     80212e <__udivdi3+0x6a>
  802124:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802128:	0f 87 9e 00 00 00    	ja     8021cc <__udivdi3+0x108>
  80212e:	b8 01 00 00 00       	mov    $0x1,%eax
  802133:	89 fa                	mov    %edi,%edx
  802135:	83 c4 1c             	add    $0x1c,%esp
  802138:	5b                   	pop    %ebx
  802139:	5e                   	pop    %esi
  80213a:	5f                   	pop    %edi
  80213b:	5d                   	pop    %ebp
  80213c:	c3                   	ret    
  80213d:	8d 76 00             	lea    0x0(%esi),%esi
  802140:	31 ff                	xor    %edi,%edi
  802142:	31 c0                	xor    %eax,%eax
  802144:	89 fa                	mov    %edi,%edx
  802146:	83 c4 1c             	add    $0x1c,%esp
  802149:	5b                   	pop    %ebx
  80214a:	5e                   	pop    %esi
  80214b:	5f                   	pop    %edi
  80214c:	5d                   	pop    %ebp
  80214d:	c3                   	ret    
  80214e:	66 90                	xchg   %ax,%ax
  802150:	89 d8                	mov    %ebx,%eax
  802152:	f7 f7                	div    %edi
  802154:	31 ff                	xor    %edi,%edi
  802156:	89 fa                	mov    %edi,%edx
  802158:	83 c4 1c             	add    $0x1c,%esp
  80215b:	5b                   	pop    %ebx
  80215c:	5e                   	pop    %esi
  80215d:	5f                   	pop    %edi
  80215e:	5d                   	pop    %ebp
  80215f:	c3                   	ret    
  802160:	bd 20 00 00 00       	mov    $0x20,%ebp
  802165:	89 eb                	mov    %ebp,%ebx
  802167:	29 fb                	sub    %edi,%ebx
  802169:	89 f9                	mov    %edi,%ecx
  80216b:	d3 e6                	shl    %cl,%esi
  80216d:	89 c5                	mov    %eax,%ebp
  80216f:	88 d9                	mov    %bl,%cl
  802171:	d3 ed                	shr    %cl,%ebp
  802173:	89 e9                	mov    %ebp,%ecx
  802175:	09 f1                	or     %esi,%ecx
  802177:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80217b:	89 f9                	mov    %edi,%ecx
  80217d:	d3 e0                	shl    %cl,%eax
  80217f:	89 c5                	mov    %eax,%ebp
  802181:	89 d6                	mov    %edx,%esi
  802183:	88 d9                	mov    %bl,%cl
  802185:	d3 ee                	shr    %cl,%esi
  802187:	89 f9                	mov    %edi,%ecx
  802189:	d3 e2                	shl    %cl,%edx
  80218b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80218f:	88 d9                	mov    %bl,%cl
  802191:	d3 e8                	shr    %cl,%eax
  802193:	09 c2                	or     %eax,%edx
  802195:	89 d0                	mov    %edx,%eax
  802197:	89 f2                	mov    %esi,%edx
  802199:	f7 74 24 0c          	divl   0xc(%esp)
  80219d:	89 d6                	mov    %edx,%esi
  80219f:	89 c3                	mov    %eax,%ebx
  8021a1:	f7 e5                	mul    %ebp
  8021a3:	39 d6                	cmp    %edx,%esi
  8021a5:	72 19                	jb     8021c0 <__udivdi3+0xfc>
  8021a7:	74 0b                	je     8021b4 <__udivdi3+0xf0>
  8021a9:	89 d8                	mov    %ebx,%eax
  8021ab:	31 ff                	xor    %edi,%edi
  8021ad:	e9 58 ff ff ff       	jmp    80210a <__udivdi3+0x46>
  8021b2:	66 90                	xchg   %ax,%ax
  8021b4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8021b8:	89 f9                	mov    %edi,%ecx
  8021ba:	d3 e2                	shl    %cl,%edx
  8021bc:	39 c2                	cmp    %eax,%edx
  8021be:	73 e9                	jae    8021a9 <__udivdi3+0xe5>
  8021c0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8021c3:	31 ff                	xor    %edi,%edi
  8021c5:	e9 40 ff ff ff       	jmp    80210a <__udivdi3+0x46>
  8021ca:	66 90                	xchg   %ax,%ax
  8021cc:	31 c0                	xor    %eax,%eax
  8021ce:	e9 37 ff ff ff       	jmp    80210a <__udivdi3+0x46>
  8021d3:	90                   	nop

008021d4 <__umoddi3>:
  8021d4:	55                   	push   %ebp
  8021d5:	57                   	push   %edi
  8021d6:	56                   	push   %esi
  8021d7:	53                   	push   %ebx
  8021d8:	83 ec 1c             	sub    $0x1c,%esp
  8021db:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8021df:	8b 74 24 34          	mov    0x34(%esp),%esi
  8021e3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021e7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8021eb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8021ef:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8021f3:	89 f3                	mov    %esi,%ebx
  8021f5:	89 fa                	mov    %edi,%edx
  8021f7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8021fb:	89 34 24             	mov    %esi,(%esp)
  8021fe:	85 c0                	test   %eax,%eax
  802200:	75 1a                	jne    80221c <__umoddi3+0x48>
  802202:	39 f7                	cmp    %esi,%edi
  802204:	0f 86 a2 00 00 00    	jbe    8022ac <__umoddi3+0xd8>
  80220a:	89 c8                	mov    %ecx,%eax
  80220c:	89 f2                	mov    %esi,%edx
  80220e:	f7 f7                	div    %edi
  802210:	89 d0                	mov    %edx,%eax
  802212:	31 d2                	xor    %edx,%edx
  802214:	83 c4 1c             	add    $0x1c,%esp
  802217:	5b                   	pop    %ebx
  802218:	5e                   	pop    %esi
  802219:	5f                   	pop    %edi
  80221a:	5d                   	pop    %ebp
  80221b:	c3                   	ret    
  80221c:	39 f0                	cmp    %esi,%eax
  80221e:	0f 87 ac 00 00 00    	ja     8022d0 <__umoddi3+0xfc>
  802224:	0f bd e8             	bsr    %eax,%ebp
  802227:	83 f5 1f             	xor    $0x1f,%ebp
  80222a:	0f 84 ac 00 00 00    	je     8022dc <__umoddi3+0x108>
  802230:	bf 20 00 00 00       	mov    $0x20,%edi
  802235:	29 ef                	sub    %ebp,%edi
  802237:	89 fe                	mov    %edi,%esi
  802239:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80223d:	89 e9                	mov    %ebp,%ecx
  80223f:	d3 e0                	shl    %cl,%eax
  802241:	89 d7                	mov    %edx,%edi
  802243:	89 f1                	mov    %esi,%ecx
  802245:	d3 ef                	shr    %cl,%edi
  802247:	09 c7                	or     %eax,%edi
  802249:	89 e9                	mov    %ebp,%ecx
  80224b:	d3 e2                	shl    %cl,%edx
  80224d:	89 14 24             	mov    %edx,(%esp)
  802250:	89 d8                	mov    %ebx,%eax
  802252:	d3 e0                	shl    %cl,%eax
  802254:	89 c2                	mov    %eax,%edx
  802256:	8b 44 24 08          	mov    0x8(%esp),%eax
  80225a:	d3 e0                	shl    %cl,%eax
  80225c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802260:	8b 44 24 08          	mov    0x8(%esp),%eax
  802264:	89 f1                	mov    %esi,%ecx
  802266:	d3 e8                	shr    %cl,%eax
  802268:	09 d0                	or     %edx,%eax
  80226a:	d3 eb                	shr    %cl,%ebx
  80226c:	89 da                	mov    %ebx,%edx
  80226e:	f7 f7                	div    %edi
  802270:	89 d3                	mov    %edx,%ebx
  802272:	f7 24 24             	mull   (%esp)
  802275:	89 c6                	mov    %eax,%esi
  802277:	89 d1                	mov    %edx,%ecx
  802279:	39 d3                	cmp    %edx,%ebx
  80227b:	0f 82 87 00 00 00    	jb     802308 <__umoddi3+0x134>
  802281:	0f 84 91 00 00 00    	je     802318 <__umoddi3+0x144>
  802287:	8b 54 24 04          	mov    0x4(%esp),%edx
  80228b:	29 f2                	sub    %esi,%edx
  80228d:	19 cb                	sbb    %ecx,%ebx
  80228f:	89 d8                	mov    %ebx,%eax
  802291:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802295:	d3 e0                	shl    %cl,%eax
  802297:	89 e9                	mov    %ebp,%ecx
  802299:	d3 ea                	shr    %cl,%edx
  80229b:	09 d0                	or     %edx,%eax
  80229d:	89 e9                	mov    %ebp,%ecx
  80229f:	d3 eb                	shr    %cl,%ebx
  8022a1:	89 da                	mov    %ebx,%edx
  8022a3:	83 c4 1c             	add    $0x1c,%esp
  8022a6:	5b                   	pop    %ebx
  8022a7:	5e                   	pop    %esi
  8022a8:	5f                   	pop    %edi
  8022a9:	5d                   	pop    %ebp
  8022aa:	c3                   	ret    
  8022ab:	90                   	nop
  8022ac:	89 fd                	mov    %edi,%ebp
  8022ae:	85 ff                	test   %edi,%edi
  8022b0:	75 0b                	jne    8022bd <__umoddi3+0xe9>
  8022b2:	b8 01 00 00 00       	mov    $0x1,%eax
  8022b7:	31 d2                	xor    %edx,%edx
  8022b9:	f7 f7                	div    %edi
  8022bb:	89 c5                	mov    %eax,%ebp
  8022bd:	89 f0                	mov    %esi,%eax
  8022bf:	31 d2                	xor    %edx,%edx
  8022c1:	f7 f5                	div    %ebp
  8022c3:	89 c8                	mov    %ecx,%eax
  8022c5:	f7 f5                	div    %ebp
  8022c7:	89 d0                	mov    %edx,%eax
  8022c9:	e9 44 ff ff ff       	jmp    802212 <__umoddi3+0x3e>
  8022ce:	66 90                	xchg   %ax,%ax
  8022d0:	89 c8                	mov    %ecx,%eax
  8022d2:	89 f2                	mov    %esi,%edx
  8022d4:	83 c4 1c             	add    $0x1c,%esp
  8022d7:	5b                   	pop    %ebx
  8022d8:	5e                   	pop    %esi
  8022d9:	5f                   	pop    %edi
  8022da:	5d                   	pop    %ebp
  8022db:	c3                   	ret    
  8022dc:	3b 04 24             	cmp    (%esp),%eax
  8022df:	72 06                	jb     8022e7 <__umoddi3+0x113>
  8022e1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8022e5:	77 0f                	ja     8022f6 <__umoddi3+0x122>
  8022e7:	89 f2                	mov    %esi,%edx
  8022e9:	29 f9                	sub    %edi,%ecx
  8022eb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8022ef:	89 14 24             	mov    %edx,(%esp)
  8022f2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8022f6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8022fa:	8b 14 24             	mov    (%esp),%edx
  8022fd:	83 c4 1c             	add    $0x1c,%esp
  802300:	5b                   	pop    %ebx
  802301:	5e                   	pop    %esi
  802302:	5f                   	pop    %edi
  802303:	5d                   	pop    %ebp
  802304:	c3                   	ret    
  802305:	8d 76 00             	lea    0x0(%esi),%esi
  802308:	2b 04 24             	sub    (%esp),%eax
  80230b:	19 fa                	sbb    %edi,%edx
  80230d:	89 d1                	mov    %edx,%ecx
  80230f:	89 c6                	mov    %eax,%esi
  802311:	e9 71 ff ff ff       	jmp    802287 <__umoddi3+0xb3>
  802316:	66 90                	xchg   %ax,%ax
  802318:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80231c:	72 ea                	jb     802308 <__umoddi3+0x134>
  80231e:	89 d9                	mov    %ebx,%ecx
  802320:	e9 62 ff ff ff       	jmp    802287 <__umoddi3+0xb3>
