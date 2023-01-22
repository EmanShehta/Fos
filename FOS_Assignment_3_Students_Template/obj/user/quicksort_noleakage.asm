
obj/user/quicksort_noleakage:     file format elf32-i386


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
  800031:	e8 0e 06 00 00       	call   800644 <libmain>
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
  80003b:	81 ec 18 01 00 00    	sub    $0x118,%esp
	char Line[255] ;
	char Chose ;
	do
	{
		//2012: lock the interrupt
		sys_disable_interrupt();
  800041:	e8 8a 1c 00 00       	call   801cd0 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 80 23 80 00       	push   $0x802380
  80004e:	e8 c1 09 00 00       	call   800a14 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 82 23 80 00       	push   $0x802382
  80005e:	e8 b1 09 00 00       	call   800a14 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT    !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 9b 23 80 00       	push   $0x80239b
  80006e:	e8 a1 09 00 00       	call   800a14 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 82 23 80 00       	push   $0x802382
  80007e:	e8 91 09 00 00       	call   800a14 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 80 23 80 00       	push   $0x802380
  80008e:	e8 81 09 00 00       	call   800a14 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 b4 23 80 00       	push   $0x8023b4
  8000a5:	e8 ec 0f 00 00       	call   801096 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 3c 15 00 00       	call   8015fc <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 cf 18 00 00       	call   8019a4 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 f0             	mov    %eax,-0x10(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 d4 23 80 00       	push   $0x8023d4
  8000e3:	e8 2c 09 00 00       	call   800a14 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 f6 23 80 00       	push   $0x8023f6
  8000f3:	e8 1c 09 00 00       	call   800a14 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 04 24 80 00       	push   $0x802404
  800103:	e8 0c 09 00 00       	call   800a14 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 13 24 80 00       	push   $0x802413
  800113:	e8 fc 08 00 00       	call   800a14 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 23 24 80 00       	push   $0x802423
  800123:	e8 ec 08 00 00       	call   800a14 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 bc 04 00 00       	call   8005ec <getchar>
  800130:	88 45 ef             	mov    %al,-0x11(%ebp)
			cputchar(Chose);
  800133:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 64 04 00 00       	call   8005a4 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 57 04 00 00       	call   8005a4 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d ef 61          	cmpb   $0x61,-0x11(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d ef 62          	cmpb   $0x62,-0x11(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d ef 63          	cmpb   $0x63,-0x11(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>

		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 83 1b 00 00       	call   801cea <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  80016b:	83 f8 62             	cmp    $0x62,%eax
  80016e:	74 1d                	je     80018d <_main+0x155>
  800170:	83 f8 63             	cmp    $0x63,%eax
  800173:	74 2b                	je     8001a0 <_main+0x168>
  800175:	83 f8 61             	cmp    $0x61,%eax
  800178:	75 39                	jne    8001b3 <_main+0x17b>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  80017a:	83 ec 08             	sub    $0x8,%esp
  80017d:	ff 75 f4             	pushl  -0xc(%ebp)
  800180:	ff 75 f0             	pushl  -0x10(%ebp)
  800183:	e8 e4 02 00 00       	call   80046c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f4             	pushl  -0xc(%ebp)
  800193:	ff 75 f0             	pushl  -0x10(%ebp)
  800196:	e8 02 03 00 00       	call   80049d <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f4             	pushl  -0xc(%ebp)
  8001a6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a9:	e8 24 03 00 00       	call   8004d2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8001b9:	ff 75 f0             	pushl  -0x10(%ebp)
  8001bc:	e8 11 03 00 00       	call   8004d2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8001ca:	ff 75 f0             	pushl  -0x10(%ebp)
  8001cd:	e8 df 00 00 00       	call   8002b1 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d5:	e8 f6 1a 00 00       	call   801cd0 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 2c 24 80 00       	push   $0x80242c
  8001e2:	e8 2d 08 00 00       	call   800a14 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 fb 1a 00 00       	call   801cea <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8001f5:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f8:	e8 c5 01 00 00       	call   8003c2 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 60 24 80 00       	push   $0x802460
  800211:	6a 49                	push   $0x49
  800213:	68 82 24 80 00       	push   $0x802482
  800218:	e8 43 05 00 00       	call   800760 <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 ae 1a 00 00       	call   801cd0 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 a0 24 80 00       	push   $0x8024a0
  80022a:	e8 e5 07 00 00       	call   800a14 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 d4 24 80 00       	push   $0x8024d4
  80023a:	e8 d5 07 00 00       	call   800a14 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 08 25 80 00       	push   $0x802508
  80024a:	e8 c5 07 00 00       	call   800a14 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 93 1a 00 00       	call   801cea <sys_enable_interrupt>

		}

		free(Elements) ;
  800257:	83 ec 0c             	sub    $0xc,%esp
  80025a:	ff 75 f0             	pushl  -0x10(%ebp)
  80025d:	e8 5c 17 00 00       	call   8019be <free>
  800262:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800265:	e8 66 1a 00 00       	call   801cd0 <sys_disable_interrupt>

		cprintf("Do you want to repeat (y/n): ") ;
  80026a:	83 ec 0c             	sub    $0xc,%esp
  80026d:	68 3a 25 80 00       	push   $0x80253a
  800272:	e8 9d 07 00 00       	call   800a14 <cprintf>
  800277:	83 c4 10             	add    $0x10,%esp
		Chose = getchar() ;
  80027a:	e8 6d 03 00 00       	call   8005ec <getchar>
  80027f:	88 45 ef             	mov    %al,-0x11(%ebp)
		cputchar(Chose);
  800282:	0f be 45 ef          	movsbl -0x11(%ebp),%eax
  800286:	83 ec 0c             	sub    $0xc,%esp
  800289:	50                   	push   %eax
  80028a:	e8 15 03 00 00       	call   8005a4 <cputchar>
  80028f:	83 c4 10             	add    $0x10,%esp
		cputchar('\n');
  800292:	83 ec 0c             	sub    $0xc,%esp
  800295:	6a 0a                	push   $0xa
  800297:	e8 08 03 00 00       	call   8005a4 <cputchar>
  80029c:	83 c4 10             	add    $0x10,%esp

		sys_enable_interrupt();
  80029f:	e8 46 1a 00 00       	call   801cea <sys_enable_interrupt>

	} while (Chose == 'y');
  8002a4:	80 7d ef 79          	cmpb   $0x79,-0x11(%ebp)
  8002a8:	0f 84 93 fd ff ff    	je     800041 <_main+0x9>

}
  8002ae:	90                   	nop
  8002af:	c9                   	leave  
  8002b0:	c3                   	ret    

008002b1 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002b1:	55                   	push   %ebp
  8002b2:	89 e5                	mov    %esp,%ebp
  8002b4:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ba:	48                   	dec    %eax
  8002bb:	50                   	push   %eax
  8002bc:	6a 00                	push   $0x0
  8002be:	ff 75 0c             	pushl  0xc(%ebp)
  8002c1:	ff 75 08             	pushl  0x8(%ebp)
  8002c4:	e8 06 00 00 00       	call   8002cf <QSort>
  8002c9:	83 c4 10             	add    $0x10,%esp
}
  8002cc:	90                   	nop
  8002cd:	c9                   	leave  
  8002ce:	c3                   	ret    

008002cf <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002cf:	55                   	push   %ebp
  8002d0:	89 e5                	mov    %esp,%ebp
  8002d2:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002d5:	8b 45 10             	mov    0x10(%ebp),%eax
  8002d8:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002db:	0f 8d de 00 00 00    	jge    8003bf <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e4:	40                   	inc    %eax
  8002e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002e8:	8b 45 14             	mov    0x14(%ebp),%eax
  8002eb:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ee:	e9 80 00 00 00       	jmp    800373 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  8002f3:	ff 45 f4             	incl   -0xc(%ebp)
  8002f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002f9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002fc:	7f 2b                	jg     800329 <QSort+0x5a>
  8002fe:	8b 45 10             	mov    0x10(%ebp),%eax
  800301:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800308:	8b 45 08             	mov    0x8(%ebp),%eax
  80030b:	01 d0                	add    %edx,%eax
  80030d:	8b 10                	mov    (%eax),%edx
  80030f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800312:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 c8                	add    %ecx,%eax
  80031e:	8b 00                	mov    (%eax),%eax
  800320:	39 c2                	cmp    %eax,%edx
  800322:	7d cf                	jge    8002f3 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800324:	eb 03                	jmp    800329 <QSort+0x5a>
  800326:	ff 4d f0             	decl   -0x10(%ebp)
  800329:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80032c:	3b 45 10             	cmp    0x10(%ebp),%eax
  80032f:	7e 26                	jle    800357 <QSort+0x88>
  800331:	8b 45 10             	mov    0x10(%ebp),%eax
  800334:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	01 d0                	add    %edx,%eax
  800340:	8b 10                	mov    (%eax),%edx
  800342:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800345:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 c8                	add    %ecx,%eax
  800351:	8b 00                	mov    (%eax),%eax
  800353:	39 c2                	cmp    %eax,%edx
  800355:	7e cf                	jle    800326 <QSort+0x57>

		if (i <= j)
  800357:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80035a:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80035d:	7f 14                	jg     800373 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  80035f:	83 ec 04             	sub    $0x4,%esp
  800362:	ff 75 f0             	pushl  -0x10(%ebp)
  800365:	ff 75 f4             	pushl  -0xc(%ebp)
  800368:	ff 75 08             	pushl  0x8(%ebp)
  80036b:	e8 a9 00 00 00       	call   800419 <Swap>
  800370:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800373:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800376:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800379:	0f 8e 77 ff ff ff    	jle    8002f6 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  80037f:	83 ec 04             	sub    $0x4,%esp
  800382:	ff 75 f0             	pushl  -0x10(%ebp)
  800385:	ff 75 10             	pushl  0x10(%ebp)
  800388:	ff 75 08             	pushl  0x8(%ebp)
  80038b:	e8 89 00 00 00       	call   800419 <Swap>
  800390:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  800393:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800396:	48                   	dec    %eax
  800397:	50                   	push   %eax
  800398:	ff 75 10             	pushl  0x10(%ebp)
  80039b:	ff 75 0c             	pushl  0xc(%ebp)
  80039e:	ff 75 08             	pushl  0x8(%ebp)
  8003a1:	e8 29 ff ff ff       	call   8002cf <QSort>
  8003a6:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003a9:	ff 75 14             	pushl  0x14(%ebp)
  8003ac:	ff 75 f4             	pushl  -0xc(%ebp)
  8003af:	ff 75 0c             	pushl  0xc(%ebp)
  8003b2:	ff 75 08             	pushl  0x8(%ebp)
  8003b5:	e8 15 ff ff ff       	call   8002cf <QSort>
  8003ba:	83 c4 10             	add    $0x10,%esp
  8003bd:	eb 01                	jmp    8003c0 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003bf:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003c0:	c9                   	leave  
  8003c1:	c3                   	ret    

008003c2 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003c2:	55                   	push   %ebp
  8003c3:	89 e5                	mov    %esp,%ebp
  8003c5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003c8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003cf:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003d6:	eb 33                	jmp    80040b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003d8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003db:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003e5:	01 d0                	add    %edx,%eax
  8003e7:	8b 10                	mov    (%eax),%edx
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	40                   	inc    %eax
  8003ed:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f7:	01 c8                	add    %ecx,%eax
  8003f9:	8b 00                	mov    (%eax),%eax
  8003fb:	39 c2                	cmp    %eax,%edx
  8003fd:	7e 09                	jle    800408 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  8003ff:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800406:	eb 0c                	jmp    800414 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800408:	ff 45 f8             	incl   -0x8(%ebp)
  80040b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80040e:	48                   	dec    %eax
  80040f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800412:	7f c4                	jg     8003d8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800414:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800417:	c9                   	leave  
  800418:	c3                   	ret    

00800419 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800419:	55                   	push   %ebp
  80041a:	89 e5                	mov    %esp,%ebp
  80041c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80041f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800422:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800429:	8b 45 08             	mov    0x8(%ebp),%eax
  80042c:	01 d0                	add    %edx,%eax
  80042e:	8b 00                	mov    (%eax),%eax
  800430:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800433:	8b 45 0c             	mov    0xc(%ebp),%eax
  800436:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043d:	8b 45 08             	mov    0x8(%ebp),%eax
  800440:	01 c2                	add    %eax,%edx
  800442:	8b 45 10             	mov    0x10(%ebp),%eax
  800445:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80044c:	8b 45 08             	mov    0x8(%ebp),%eax
  80044f:	01 c8                	add    %ecx,%eax
  800451:	8b 00                	mov    (%eax),%eax
  800453:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800455:	8b 45 10             	mov    0x10(%ebp),%eax
  800458:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80045f:	8b 45 08             	mov    0x8(%ebp),%eax
  800462:	01 c2                	add    %eax,%edx
  800464:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800467:	89 02                	mov    %eax,(%edx)
}
  800469:	90                   	nop
  80046a:	c9                   	leave  
  80046b:	c3                   	ret    

0080046c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80046c:	55                   	push   %ebp
  80046d:	89 e5                	mov    %esp,%ebp
  80046f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800472:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800479:	eb 17                	jmp    800492 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80047b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80047e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	01 c2                	add    %eax,%edx
  80048a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80048f:	ff 45 fc             	incl   -0x4(%ebp)
  800492:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800495:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800498:	7c e1                	jl     80047b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80049a:	90                   	nop
  80049b:	c9                   	leave  
  80049c:	c3                   	ret    

0080049d <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80049d:	55                   	push   %ebp
  80049e:	89 e5                	mov    %esp,%ebp
  8004a0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004aa:	eb 1b                	jmp    8004c7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b9:	01 c2                	add    %eax,%edx
  8004bb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004be:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004c1:	48                   	dec    %eax
  8004c2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004c4:	ff 45 fc             	incl   -0x4(%ebp)
  8004c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004ca:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004cd:	7c dd                	jl     8004ac <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004cf:	90                   	nop
  8004d0:	c9                   	leave  
  8004d1:	c3                   	ret    

008004d2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004d2:	55                   	push   %ebp
  8004d3:	89 e5                	mov    %esp,%ebp
  8004d5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004d8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004db:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004e0:	f7 e9                	imul   %ecx
  8004e2:	c1 f9 1f             	sar    $0x1f,%ecx
  8004e5:	89 d0                	mov    %edx,%eax
  8004e7:	29 c8                	sub    %ecx,%eax
  8004e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004f3:	eb 1e                	jmp    800513 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  8004f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004f8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800502:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800505:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800508:	99                   	cltd   
  800509:	f7 7d f8             	idivl  -0x8(%ebp)
  80050c:	89 d0                	mov    %edx,%eax
  80050e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800510:	ff 45 fc             	incl   -0x4(%ebp)
  800513:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800516:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800519:	7c da                	jl     8004f5 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80051b:	90                   	nop
  80051c:	c9                   	leave  
  80051d:	c3                   	ret    

0080051e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80051e:	55                   	push   %ebp
  80051f:	89 e5                	mov    %esp,%ebp
  800521:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800524:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80052b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800532:	eb 42                	jmp    800576 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800534:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800537:	99                   	cltd   
  800538:	f7 7d f0             	idivl  -0x10(%ebp)
  80053b:	89 d0                	mov    %edx,%eax
  80053d:	85 c0                	test   %eax,%eax
  80053f:	75 10                	jne    800551 <PrintElements+0x33>
			cprintf("\n");
  800541:	83 ec 0c             	sub    $0xc,%esp
  800544:	68 80 23 80 00       	push   $0x802380
  800549:	e8 c6 04 00 00       	call   800a14 <cprintf>
  80054e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800551:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800554:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80055b:	8b 45 08             	mov    0x8(%ebp),%eax
  80055e:	01 d0                	add    %edx,%eax
  800560:	8b 00                	mov    (%eax),%eax
  800562:	83 ec 08             	sub    $0x8,%esp
  800565:	50                   	push   %eax
  800566:	68 58 25 80 00       	push   $0x802558
  80056b:	e8 a4 04 00 00       	call   800a14 <cprintf>
  800570:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800573:	ff 45 f4             	incl   -0xc(%ebp)
  800576:	8b 45 0c             	mov    0xc(%ebp),%eax
  800579:	48                   	dec    %eax
  80057a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80057d:	7f b5                	jg     800534 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80057f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800582:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800589:	8b 45 08             	mov    0x8(%ebp),%eax
  80058c:	01 d0                	add    %edx,%eax
  80058e:	8b 00                	mov    (%eax),%eax
  800590:	83 ec 08             	sub    $0x8,%esp
  800593:	50                   	push   %eax
  800594:	68 5d 25 80 00       	push   $0x80255d
  800599:	e8 76 04 00 00       	call   800a14 <cprintf>
  80059e:	83 c4 10             	add    $0x10,%esp

}
  8005a1:	90                   	nop
  8005a2:	c9                   	leave  
  8005a3:	c3                   	ret    

008005a4 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005a4:	55                   	push   %ebp
  8005a5:	89 e5                	mov    %esp,%ebp
  8005a7:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8005ad:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005b0:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005b4:	83 ec 0c             	sub    $0xc,%esp
  8005b7:	50                   	push   %eax
  8005b8:	e8 47 17 00 00       	call   801d04 <sys_cputc>
  8005bd:	83 c4 10             	add    $0x10,%esp
}
  8005c0:	90                   	nop
  8005c1:	c9                   	leave  
  8005c2:	c3                   	ret    

008005c3 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005c3:	55                   	push   %ebp
  8005c4:	89 e5                	mov    %esp,%ebp
  8005c6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005c9:	e8 02 17 00 00       	call   801cd0 <sys_disable_interrupt>
	char c = ch;
  8005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d1:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005d4:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005d8:	83 ec 0c             	sub    $0xc,%esp
  8005db:	50                   	push   %eax
  8005dc:	e8 23 17 00 00       	call   801d04 <sys_cputc>
  8005e1:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005e4:	e8 01 17 00 00       	call   801cea <sys_enable_interrupt>
}
  8005e9:	90                   	nop
  8005ea:	c9                   	leave  
  8005eb:	c3                   	ret    

008005ec <getchar>:

int
getchar(void)
{
  8005ec:	55                   	push   %ebp
  8005ed:	89 e5                	mov    %esp,%ebp
  8005ef:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8005f2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8005f9:	eb 08                	jmp    800603 <getchar+0x17>
	{
		c = sys_cgetc();
  8005fb:	e8 e8 14 00 00       	call   801ae8 <sys_cgetc>
  800600:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800603:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800607:	74 f2                	je     8005fb <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  800609:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80060c:	c9                   	leave  
  80060d:	c3                   	ret    

0080060e <atomic_getchar>:

int
atomic_getchar(void)
{
  80060e:	55                   	push   %ebp
  80060f:	89 e5                	mov    %esp,%ebp
  800611:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800614:	e8 b7 16 00 00       	call   801cd0 <sys_disable_interrupt>
	int c=0;
  800619:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800620:	eb 08                	jmp    80062a <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800622:	e8 c1 14 00 00       	call   801ae8 <sys_cgetc>
  800627:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80062a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80062e:	74 f2                	je     800622 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800630:	e8 b5 16 00 00       	call   801cea <sys_enable_interrupt>
	return c;
  800635:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800638:	c9                   	leave  
  800639:	c3                   	ret    

0080063a <iscons>:

int iscons(int fdnum)
{
  80063a:	55                   	push   %ebp
  80063b:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80063d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800642:	5d                   	pop    %ebp
  800643:	c3                   	ret    

00800644 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800644:	55                   	push   %ebp
  800645:	89 e5                	mov    %esp,%ebp
  800647:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80064a:	e8 e6 14 00 00       	call   801b35 <sys_getenvindex>
  80064f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800652:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800655:	89 d0                	mov    %edx,%eax
  800657:	01 c0                	add    %eax,%eax
  800659:	01 d0                	add    %edx,%eax
  80065b:	c1 e0 04             	shl    $0x4,%eax
  80065e:	29 d0                	sub    %edx,%eax
  800660:	c1 e0 03             	shl    $0x3,%eax
  800663:	01 d0                	add    %edx,%eax
  800665:	c1 e0 02             	shl    $0x2,%eax
  800668:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80066d:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800672:	a1 24 30 80 00       	mov    0x803024,%eax
  800677:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80067d:	84 c0                	test   %al,%al
  80067f:	74 0f                	je     800690 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800681:	a1 24 30 80 00       	mov    0x803024,%eax
  800686:	05 5c 05 00 00       	add    $0x55c,%eax
  80068b:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800690:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800694:	7e 0a                	jle    8006a0 <libmain+0x5c>
		binaryname = argv[0];
  800696:	8b 45 0c             	mov    0xc(%ebp),%eax
  800699:	8b 00                	mov    (%eax),%eax
  80069b:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006a0:	83 ec 08             	sub    $0x8,%esp
  8006a3:	ff 75 0c             	pushl  0xc(%ebp)
  8006a6:	ff 75 08             	pushl  0x8(%ebp)
  8006a9:	e8 8a f9 ff ff       	call   800038 <_main>
  8006ae:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006b1:	e8 1a 16 00 00       	call   801cd0 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006b6:	83 ec 0c             	sub    $0xc,%esp
  8006b9:	68 7c 25 80 00       	push   $0x80257c
  8006be:	e8 51 03 00 00       	call   800a14 <cprintf>
  8006c3:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006c6:	a1 24 30 80 00       	mov    0x803024,%eax
  8006cb:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8006d1:	a1 24 30 80 00       	mov    0x803024,%eax
  8006d6:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8006dc:	83 ec 04             	sub    $0x4,%esp
  8006df:	52                   	push   %edx
  8006e0:	50                   	push   %eax
  8006e1:	68 a4 25 80 00       	push   $0x8025a4
  8006e6:	e8 29 03 00 00       	call   800a14 <cprintf>
  8006eb:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006ee:	a1 24 30 80 00       	mov    0x803024,%eax
  8006f3:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8006f9:	a1 24 30 80 00       	mov    0x803024,%eax
  8006fe:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800704:	a1 24 30 80 00       	mov    0x803024,%eax
  800709:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  80070f:	51                   	push   %ecx
  800710:	52                   	push   %edx
  800711:	50                   	push   %eax
  800712:	68 cc 25 80 00       	push   $0x8025cc
  800717:	e8 f8 02 00 00       	call   800a14 <cprintf>
  80071c:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80071f:	83 ec 0c             	sub    $0xc,%esp
  800722:	68 7c 25 80 00       	push   $0x80257c
  800727:	e8 e8 02 00 00       	call   800a14 <cprintf>
  80072c:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80072f:	e8 b6 15 00 00       	call   801cea <sys_enable_interrupt>

	// exit gracefully
	exit();
  800734:	e8 19 00 00 00       	call   800752 <exit>
}
  800739:	90                   	nop
  80073a:	c9                   	leave  
  80073b:	c3                   	ret    

0080073c <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80073c:	55                   	push   %ebp
  80073d:	89 e5                	mov    %esp,%ebp
  80073f:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800742:	83 ec 0c             	sub    $0xc,%esp
  800745:	6a 00                	push   $0x0
  800747:	e8 b5 13 00 00       	call   801b01 <sys_env_destroy>
  80074c:	83 c4 10             	add    $0x10,%esp
}
  80074f:	90                   	nop
  800750:	c9                   	leave  
  800751:	c3                   	ret    

00800752 <exit>:

void
exit(void)
{
  800752:	55                   	push   %ebp
  800753:	89 e5                	mov    %esp,%ebp
  800755:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800758:	e8 0a 14 00 00       	call   801b67 <sys_env_exit>
}
  80075d:	90                   	nop
  80075e:	c9                   	leave  
  80075f:	c3                   	ret    

00800760 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800760:	55                   	push   %ebp
  800761:	89 e5                	mov    %esp,%ebp
  800763:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800766:	8d 45 10             	lea    0x10(%ebp),%eax
  800769:	83 c0 04             	add    $0x4,%eax
  80076c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80076f:	a1 18 31 80 00       	mov    0x803118,%eax
  800774:	85 c0                	test   %eax,%eax
  800776:	74 16                	je     80078e <_panic+0x2e>
		cprintf("%s: ", argv0);
  800778:	a1 18 31 80 00       	mov    0x803118,%eax
  80077d:	83 ec 08             	sub    $0x8,%esp
  800780:	50                   	push   %eax
  800781:	68 24 26 80 00       	push   $0x802624
  800786:	e8 89 02 00 00       	call   800a14 <cprintf>
  80078b:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80078e:	a1 00 30 80 00       	mov    0x803000,%eax
  800793:	ff 75 0c             	pushl  0xc(%ebp)
  800796:	ff 75 08             	pushl  0x8(%ebp)
  800799:	50                   	push   %eax
  80079a:	68 29 26 80 00       	push   $0x802629
  80079f:	e8 70 02 00 00       	call   800a14 <cprintf>
  8007a4:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8007aa:	83 ec 08             	sub    $0x8,%esp
  8007ad:	ff 75 f4             	pushl  -0xc(%ebp)
  8007b0:	50                   	push   %eax
  8007b1:	e8 f3 01 00 00       	call   8009a9 <vcprintf>
  8007b6:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007b9:	83 ec 08             	sub    $0x8,%esp
  8007bc:	6a 00                	push   $0x0
  8007be:	68 45 26 80 00       	push   $0x802645
  8007c3:	e8 e1 01 00 00       	call   8009a9 <vcprintf>
  8007c8:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007cb:	e8 82 ff ff ff       	call   800752 <exit>

	// should not return here
	while (1) ;
  8007d0:	eb fe                	jmp    8007d0 <_panic+0x70>

008007d2 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007d2:	55                   	push   %ebp
  8007d3:	89 e5                	mov    %esp,%ebp
  8007d5:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007d8:	a1 24 30 80 00       	mov    0x803024,%eax
  8007dd:	8b 50 74             	mov    0x74(%eax),%edx
  8007e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007e3:	39 c2                	cmp    %eax,%edx
  8007e5:	74 14                	je     8007fb <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007e7:	83 ec 04             	sub    $0x4,%esp
  8007ea:	68 48 26 80 00       	push   $0x802648
  8007ef:	6a 26                	push   $0x26
  8007f1:	68 94 26 80 00       	push   $0x802694
  8007f6:	e8 65 ff ff ff       	call   800760 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8007fb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800802:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800809:	e9 c2 00 00 00       	jmp    8008d0 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80080e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800811:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800818:	8b 45 08             	mov    0x8(%ebp),%eax
  80081b:	01 d0                	add    %edx,%eax
  80081d:	8b 00                	mov    (%eax),%eax
  80081f:	85 c0                	test   %eax,%eax
  800821:	75 08                	jne    80082b <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800823:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800826:	e9 a2 00 00 00       	jmp    8008cd <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80082b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800832:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800839:	eb 69                	jmp    8008a4 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80083b:	a1 24 30 80 00       	mov    0x803024,%eax
  800840:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800846:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800849:	89 d0                	mov    %edx,%eax
  80084b:	01 c0                	add    %eax,%eax
  80084d:	01 d0                	add    %edx,%eax
  80084f:	c1 e0 03             	shl    $0x3,%eax
  800852:	01 c8                	add    %ecx,%eax
  800854:	8a 40 04             	mov    0x4(%eax),%al
  800857:	84 c0                	test   %al,%al
  800859:	75 46                	jne    8008a1 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80085b:	a1 24 30 80 00       	mov    0x803024,%eax
  800860:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800866:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800869:	89 d0                	mov    %edx,%eax
  80086b:	01 c0                	add    %eax,%eax
  80086d:	01 d0                	add    %edx,%eax
  80086f:	c1 e0 03             	shl    $0x3,%eax
  800872:	01 c8                	add    %ecx,%eax
  800874:	8b 00                	mov    (%eax),%eax
  800876:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800879:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80087c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800881:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800883:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800886:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80088d:	8b 45 08             	mov    0x8(%ebp),%eax
  800890:	01 c8                	add    %ecx,%eax
  800892:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800894:	39 c2                	cmp    %eax,%edx
  800896:	75 09                	jne    8008a1 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800898:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80089f:	eb 12                	jmp    8008b3 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a1:	ff 45 e8             	incl   -0x18(%ebp)
  8008a4:	a1 24 30 80 00       	mov    0x803024,%eax
  8008a9:	8b 50 74             	mov    0x74(%eax),%edx
  8008ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008af:	39 c2                	cmp    %eax,%edx
  8008b1:	77 88                	ja     80083b <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008b3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008b7:	75 14                	jne    8008cd <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008b9:	83 ec 04             	sub    $0x4,%esp
  8008bc:	68 a0 26 80 00       	push   $0x8026a0
  8008c1:	6a 3a                	push   $0x3a
  8008c3:	68 94 26 80 00       	push   $0x802694
  8008c8:	e8 93 fe ff ff       	call   800760 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008cd:	ff 45 f0             	incl   -0x10(%ebp)
  8008d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008d3:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008d6:	0f 8c 32 ff ff ff    	jl     80080e <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008dc:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008e3:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008ea:	eb 26                	jmp    800912 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008ec:	a1 24 30 80 00       	mov    0x803024,%eax
  8008f1:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8008f7:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8008fa:	89 d0                	mov    %edx,%eax
  8008fc:	01 c0                	add    %eax,%eax
  8008fe:	01 d0                	add    %edx,%eax
  800900:	c1 e0 03             	shl    $0x3,%eax
  800903:	01 c8                	add    %ecx,%eax
  800905:	8a 40 04             	mov    0x4(%eax),%al
  800908:	3c 01                	cmp    $0x1,%al
  80090a:	75 03                	jne    80090f <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80090c:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80090f:	ff 45 e0             	incl   -0x20(%ebp)
  800912:	a1 24 30 80 00       	mov    0x803024,%eax
  800917:	8b 50 74             	mov    0x74(%eax),%edx
  80091a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80091d:	39 c2                	cmp    %eax,%edx
  80091f:	77 cb                	ja     8008ec <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800921:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800924:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800927:	74 14                	je     80093d <CheckWSWithoutLastIndex+0x16b>
		panic(
  800929:	83 ec 04             	sub    $0x4,%esp
  80092c:	68 f4 26 80 00       	push   $0x8026f4
  800931:	6a 44                	push   $0x44
  800933:	68 94 26 80 00       	push   $0x802694
  800938:	e8 23 fe ff ff       	call   800760 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80093d:	90                   	nop
  80093e:	c9                   	leave  
  80093f:	c3                   	ret    

00800940 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800940:	55                   	push   %ebp
  800941:	89 e5                	mov    %esp,%ebp
  800943:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800946:	8b 45 0c             	mov    0xc(%ebp),%eax
  800949:	8b 00                	mov    (%eax),%eax
  80094b:	8d 48 01             	lea    0x1(%eax),%ecx
  80094e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800951:	89 0a                	mov    %ecx,(%edx)
  800953:	8b 55 08             	mov    0x8(%ebp),%edx
  800956:	88 d1                	mov    %dl,%cl
  800958:	8b 55 0c             	mov    0xc(%ebp),%edx
  80095b:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80095f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800962:	8b 00                	mov    (%eax),%eax
  800964:	3d ff 00 00 00       	cmp    $0xff,%eax
  800969:	75 2c                	jne    800997 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80096b:	a0 28 30 80 00       	mov    0x803028,%al
  800970:	0f b6 c0             	movzbl %al,%eax
  800973:	8b 55 0c             	mov    0xc(%ebp),%edx
  800976:	8b 12                	mov    (%edx),%edx
  800978:	89 d1                	mov    %edx,%ecx
  80097a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80097d:	83 c2 08             	add    $0x8,%edx
  800980:	83 ec 04             	sub    $0x4,%esp
  800983:	50                   	push   %eax
  800984:	51                   	push   %ecx
  800985:	52                   	push   %edx
  800986:	e8 34 11 00 00       	call   801abf <sys_cputs>
  80098b:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80098e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800991:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800997:	8b 45 0c             	mov    0xc(%ebp),%eax
  80099a:	8b 40 04             	mov    0x4(%eax),%eax
  80099d:	8d 50 01             	lea    0x1(%eax),%edx
  8009a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a3:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009a6:	90                   	nop
  8009a7:	c9                   	leave  
  8009a8:	c3                   	ret    

008009a9 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009a9:	55                   	push   %ebp
  8009aa:	89 e5                	mov    %esp,%ebp
  8009ac:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009b2:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009b9:	00 00 00 
	b.cnt = 0;
  8009bc:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009c3:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009c6:	ff 75 0c             	pushl  0xc(%ebp)
  8009c9:	ff 75 08             	pushl  0x8(%ebp)
  8009cc:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009d2:	50                   	push   %eax
  8009d3:	68 40 09 80 00       	push   $0x800940
  8009d8:	e8 11 02 00 00       	call   800bee <vprintfmt>
  8009dd:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009e0:	a0 28 30 80 00       	mov    0x803028,%al
  8009e5:	0f b6 c0             	movzbl %al,%eax
  8009e8:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ee:	83 ec 04             	sub    $0x4,%esp
  8009f1:	50                   	push   %eax
  8009f2:	52                   	push   %edx
  8009f3:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009f9:	83 c0 08             	add    $0x8,%eax
  8009fc:	50                   	push   %eax
  8009fd:	e8 bd 10 00 00       	call   801abf <sys_cputs>
  800a02:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a05:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a0c:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a12:	c9                   	leave  
  800a13:	c3                   	ret    

00800a14 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a14:	55                   	push   %ebp
  800a15:	89 e5                	mov    %esp,%ebp
  800a17:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a1a:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a21:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a24:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a27:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2a:	83 ec 08             	sub    $0x8,%esp
  800a2d:	ff 75 f4             	pushl  -0xc(%ebp)
  800a30:	50                   	push   %eax
  800a31:	e8 73 ff ff ff       	call   8009a9 <vcprintf>
  800a36:	83 c4 10             	add    $0x10,%esp
  800a39:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a3c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a3f:	c9                   	leave  
  800a40:	c3                   	ret    

00800a41 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a41:	55                   	push   %ebp
  800a42:	89 e5                	mov    %esp,%ebp
  800a44:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a47:	e8 84 12 00 00       	call   801cd0 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a4c:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a4f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a52:	8b 45 08             	mov    0x8(%ebp),%eax
  800a55:	83 ec 08             	sub    $0x8,%esp
  800a58:	ff 75 f4             	pushl  -0xc(%ebp)
  800a5b:	50                   	push   %eax
  800a5c:	e8 48 ff ff ff       	call   8009a9 <vcprintf>
  800a61:	83 c4 10             	add    $0x10,%esp
  800a64:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a67:	e8 7e 12 00 00       	call   801cea <sys_enable_interrupt>
	return cnt;
  800a6c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a6f:	c9                   	leave  
  800a70:	c3                   	ret    

00800a71 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a71:	55                   	push   %ebp
  800a72:	89 e5                	mov    %esp,%ebp
  800a74:	53                   	push   %ebx
  800a75:	83 ec 14             	sub    $0x14,%esp
  800a78:	8b 45 10             	mov    0x10(%ebp),%eax
  800a7b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a7e:	8b 45 14             	mov    0x14(%ebp),%eax
  800a81:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a84:	8b 45 18             	mov    0x18(%ebp),%eax
  800a87:	ba 00 00 00 00       	mov    $0x0,%edx
  800a8c:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a8f:	77 55                	ja     800ae6 <printnum+0x75>
  800a91:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a94:	72 05                	jb     800a9b <printnum+0x2a>
  800a96:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a99:	77 4b                	ja     800ae6 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a9b:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a9e:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800aa1:	8b 45 18             	mov    0x18(%ebp),%eax
  800aa4:	ba 00 00 00 00       	mov    $0x0,%edx
  800aa9:	52                   	push   %edx
  800aaa:	50                   	push   %eax
  800aab:	ff 75 f4             	pushl  -0xc(%ebp)
  800aae:	ff 75 f0             	pushl  -0x10(%ebp)
  800ab1:	e8 5a 16 00 00       	call   802110 <__udivdi3>
  800ab6:	83 c4 10             	add    $0x10,%esp
  800ab9:	83 ec 04             	sub    $0x4,%esp
  800abc:	ff 75 20             	pushl  0x20(%ebp)
  800abf:	53                   	push   %ebx
  800ac0:	ff 75 18             	pushl  0x18(%ebp)
  800ac3:	52                   	push   %edx
  800ac4:	50                   	push   %eax
  800ac5:	ff 75 0c             	pushl  0xc(%ebp)
  800ac8:	ff 75 08             	pushl  0x8(%ebp)
  800acb:	e8 a1 ff ff ff       	call   800a71 <printnum>
  800ad0:	83 c4 20             	add    $0x20,%esp
  800ad3:	eb 1a                	jmp    800aef <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ad5:	83 ec 08             	sub    $0x8,%esp
  800ad8:	ff 75 0c             	pushl  0xc(%ebp)
  800adb:	ff 75 20             	pushl  0x20(%ebp)
  800ade:	8b 45 08             	mov    0x8(%ebp),%eax
  800ae1:	ff d0                	call   *%eax
  800ae3:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ae6:	ff 4d 1c             	decl   0x1c(%ebp)
  800ae9:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800aed:	7f e6                	jg     800ad5 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800aef:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800af2:	bb 00 00 00 00       	mov    $0x0,%ebx
  800af7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800afa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800afd:	53                   	push   %ebx
  800afe:	51                   	push   %ecx
  800aff:	52                   	push   %edx
  800b00:	50                   	push   %eax
  800b01:	e8 1a 17 00 00       	call   802220 <__umoddi3>
  800b06:	83 c4 10             	add    $0x10,%esp
  800b09:	05 54 29 80 00       	add    $0x802954,%eax
  800b0e:	8a 00                	mov    (%eax),%al
  800b10:	0f be c0             	movsbl %al,%eax
  800b13:	83 ec 08             	sub    $0x8,%esp
  800b16:	ff 75 0c             	pushl  0xc(%ebp)
  800b19:	50                   	push   %eax
  800b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1d:	ff d0                	call   *%eax
  800b1f:	83 c4 10             	add    $0x10,%esp
}
  800b22:	90                   	nop
  800b23:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b26:	c9                   	leave  
  800b27:	c3                   	ret    

00800b28 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b28:	55                   	push   %ebp
  800b29:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b2b:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b2f:	7e 1c                	jle    800b4d <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b31:	8b 45 08             	mov    0x8(%ebp),%eax
  800b34:	8b 00                	mov    (%eax),%eax
  800b36:	8d 50 08             	lea    0x8(%eax),%edx
  800b39:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3c:	89 10                	mov    %edx,(%eax)
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	8b 00                	mov    (%eax),%eax
  800b43:	83 e8 08             	sub    $0x8,%eax
  800b46:	8b 50 04             	mov    0x4(%eax),%edx
  800b49:	8b 00                	mov    (%eax),%eax
  800b4b:	eb 40                	jmp    800b8d <getuint+0x65>
	else if (lflag)
  800b4d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b51:	74 1e                	je     800b71 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b53:	8b 45 08             	mov    0x8(%ebp),%eax
  800b56:	8b 00                	mov    (%eax),%eax
  800b58:	8d 50 04             	lea    0x4(%eax),%edx
  800b5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5e:	89 10                	mov    %edx,(%eax)
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	8b 00                	mov    (%eax),%eax
  800b65:	83 e8 04             	sub    $0x4,%eax
  800b68:	8b 00                	mov    (%eax),%eax
  800b6a:	ba 00 00 00 00       	mov    $0x0,%edx
  800b6f:	eb 1c                	jmp    800b8d <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	8d 50 04             	lea    0x4(%eax),%edx
  800b79:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7c:	89 10                	mov    %edx,(%eax)
  800b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b81:	8b 00                	mov    (%eax),%eax
  800b83:	83 e8 04             	sub    $0x4,%eax
  800b86:	8b 00                	mov    (%eax),%eax
  800b88:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b8d:	5d                   	pop    %ebp
  800b8e:	c3                   	ret    

00800b8f <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b8f:	55                   	push   %ebp
  800b90:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b92:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b96:	7e 1c                	jle    800bb4 <getint+0x25>
		return va_arg(*ap, long long);
  800b98:	8b 45 08             	mov    0x8(%ebp),%eax
  800b9b:	8b 00                	mov    (%eax),%eax
  800b9d:	8d 50 08             	lea    0x8(%eax),%edx
  800ba0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba3:	89 10                	mov    %edx,(%eax)
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	8b 00                	mov    (%eax),%eax
  800baa:	83 e8 08             	sub    $0x8,%eax
  800bad:	8b 50 04             	mov    0x4(%eax),%edx
  800bb0:	8b 00                	mov    (%eax),%eax
  800bb2:	eb 38                	jmp    800bec <getint+0x5d>
	else if (lflag)
  800bb4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bb8:	74 1a                	je     800bd4 <getint+0x45>
		return va_arg(*ap, long);
  800bba:	8b 45 08             	mov    0x8(%ebp),%eax
  800bbd:	8b 00                	mov    (%eax),%eax
  800bbf:	8d 50 04             	lea    0x4(%eax),%edx
  800bc2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc5:	89 10                	mov    %edx,(%eax)
  800bc7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bca:	8b 00                	mov    (%eax),%eax
  800bcc:	83 e8 04             	sub    $0x4,%eax
  800bcf:	8b 00                	mov    (%eax),%eax
  800bd1:	99                   	cltd   
  800bd2:	eb 18                	jmp    800bec <getint+0x5d>
	else
		return va_arg(*ap, int);
  800bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd7:	8b 00                	mov    (%eax),%eax
  800bd9:	8d 50 04             	lea    0x4(%eax),%edx
  800bdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdf:	89 10                	mov    %edx,(%eax)
  800be1:	8b 45 08             	mov    0x8(%ebp),%eax
  800be4:	8b 00                	mov    (%eax),%eax
  800be6:	83 e8 04             	sub    $0x4,%eax
  800be9:	8b 00                	mov    (%eax),%eax
  800beb:	99                   	cltd   
}
  800bec:	5d                   	pop    %ebp
  800bed:	c3                   	ret    

00800bee <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bee:	55                   	push   %ebp
  800bef:	89 e5                	mov    %esp,%ebp
  800bf1:	56                   	push   %esi
  800bf2:	53                   	push   %ebx
  800bf3:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bf6:	eb 17                	jmp    800c0f <vprintfmt+0x21>
			if (ch == '\0')
  800bf8:	85 db                	test   %ebx,%ebx
  800bfa:	0f 84 af 03 00 00    	je     800faf <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c00:	83 ec 08             	sub    $0x8,%esp
  800c03:	ff 75 0c             	pushl  0xc(%ebp)
  800c06:	53                   	push   %ebx
  800c07:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0a:	ff d0                	call   *%eax
  800c0c:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c0f:	8b 45 10             	mov    0x10(%ebp),%eax
  800c12:	8d 50 01             	lea    0x1(%eax),%edx
  800c15:	89 55 10             	mov    %edx,0x10(%ebp)
  800c18:	8a 00                	mov    (%eax),%al
  800c1a:	0f b6 d8             	movzbl %al,%ebx
  800c1d:	83 fb 25             	cmp    $0x25,%ebx
  800c20:	75 d6                	jne    800bf8 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c22:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c26:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c2d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c34:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c3b:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c42:	8b 45 10             	mov    0x10(%ebp),%eax
  800c45:	8d 50 01             	lea    0x1(%eax),%edx
  800c48:	89 55 10             	mov    %edx,0x10(%ebp)
  800c4b:	8a 00                	mov    (%eax),%al
  800c4d:	0f b6 d8             	movzbl %al,%ebx
  800c50:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c53:	83 f8 55             	cmp    $0x55,%eax
  800c56:	0f 87 2b 03 00 00    	ja     800f87 <vprintfmt+0x399>
  800c5c:	8b 04 85 78 29 80 00 	mov    0x802978(,%eax,4),%eax
  800c63:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c65:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c69:	eb d7                	jmp    800c42 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c6b:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c6f:	eb d1                	jmp    800c42 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c71:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c78:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c7b:	89 d0                	mov    %edx,%eax
  800c7d:	c1 e0 02             	shl    $0x2,%eax
  800c80:	01 d0                	add    %edx,%eax
  800c82:	01 c0                	add    %eax,%eax
  800c84:	01 d8                	add    %ebx,%eax
  800c86:	83 e8 30             	sub    $0x30,%eax
  800c89:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c8c:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c94:	83 fb 2f             	cmp    $0x2f,%ebx
  800c97:	7e 3e                	jle    800cd7 <vprintfmt+0xe9>
  800c99:	83 fb 39             	cmp    $0x39,%ebx
  800c9c:	7f 39                	jg     800cd7 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c9e:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800ca1:	eb d5                	jmp    800c78 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800ca3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca6:	83 c0 04             	add    $0x4,%eax
  800ca9:	89 45 14             	mov    %eax,0x14(%ebp)
  800cac:	8b 45 14             	mov    0x14(%ebp),%eax
  800caf:	83 e8 04             	sub    $0x4,%eax
  800cb2:	8b 00                	mov    (%eax),%eax
  800cb4:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cb7:	eb 1f                	jmp    800cd8 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cb9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cbd:	79 83                	jns    800c42 <vprintfmt+0x54>
				width = 0;
  800cbf:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cc6:	e9 77 ff ff ff       	jmp    800c42 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800ccb:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800cd2:	e9 6b ff ff ff       	jmp    800c42 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800cd7:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800cd8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cdc:	0f 89 60 ff ff ff    	jns    800c42 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ce2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ce5:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ce8:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800cef:	e9 4e ff ff ff       	jmp    800c42 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800cf4:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800cf7:	e9 46 ff ff ff       	jmp    800c42 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800cfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800cff:	83 c0 04             	add    $0x4,%eax
  800d02:	89 45 14             	mov    %eax,0x14(%ebp)
  800d05:	8b 45 14             	mov    0x14(%ebp),%eax
  800d08:	83 e8 04             	sub    $0x4,%eax
  800d0b:	8b 00                	mov    (%eax),%eax
  800d0d:	83 ec 08             	sub    $0x8,%esp
  800d10:	ff 75 0c             	pushl  0xc(%ebp)
  800d13:	50                   	push   %eax
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	ff d0                	call   *%eax
  800d19:	83 c4 10             	add    $0x10,%esp
			break;
  800d1c:	e9 89 02 00 00       	jmp    800faa <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d21:	8b 45 14             	mov    0x14(%ebp),%eax
  800d24:	83 c0 04             	add    $0x4,%eax
  800d27:	89 45 14             	mov    %eax,0x14(%ebp)
  800d2a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d2d:	83 e8 04             	sub    $0x4,%eax
  800d30:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d32:	85 db                	test   %ebx,%ebx
  800d34:	79 02                	jns    800d38 <vprintfmt+0x14a>
				err = -err;
  800d36:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d38:	83 fb 64             	cmp    $0x64,%ebx
  800d3b:	7f 0b                	jg     800d48 <vprintfmt+0x15a>
  800d3d:	8b 34 9d c0 27 80 00 	mov    0x8027c0(,%ebx,4),%esi
  800d44:	85 f6                	test   %esi,%esi
  800d46:	75 19                	jne    800d61 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d48:	53                   	push   %ebx
  800d49:	68 65 29 80 00       	push   $0x802965
  800d4e:	ff 75 0c             	pushl  0xc(%ebp)
  800d51:	ff 75 08             	pushl  0x8(%ebp)
  800d54:	e8 5e 02 00 00       	call   800fb7 <printfmt>
  800d59:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d5c:	e9 49 02 00 00       	jmp    800faa <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d61:	56                   	push   %esi
  800d62:	68 6e 29 80 00       	push   $0x80296e
  800d67:	ff 75 0c             	pushl  0xc(%ebp)
  800d6a:	ff 75 08             	pushl  0x8(%ebp)
  800d6d:	e8 45 02 00 00       	call   800fb7 <printfmt>
  800d72:	83 c4 10             	add    $0x10,%esp
			break;
  800d75:	e9 30 02 00 00       	jmp    800faa <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d7a:	8b 45 14             	mov    0x14(%ebp),%eax
  800d7d:	83 c0 04             	add    $0x4,%eax
  800d80:	89 45 14             	mov    %eax,0x14(%ebp)
  800d83:	8b 45 14             	mov    0x14(%ebp),%eax
  800d86:	83 e8 04             	sub    $0x4,%eax
  800d89:	8b 30                	mov    (%eax),%esi
  800d8b:	85 f6                	test   %esi,%esi
  800d8d:	75 05                	jne    800d94 <vprintfmt+0x1a6>
				p = "(null)";
  800d8f:	be 71 29 80 00       	mov    $0x802971,%esi
			if (width > 0 && padc != '-')
  800d94:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d98:	7e 6d                	jle    800e07 <vprintfmt+0x219>
  800d9a:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d9e:	74 67                	je     800e07 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800da0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800da3:	83 ec 08             	sub    $0x8,%esp
  800da6:	50                   	push   %eax
  800da7:	56                   	push   %esi
  800da8:	e8 12 05 00 00       	call   8012bf <strnlen>
  800dad:	83 c4 10             	add    $0x10,%esp
  800db0:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800db3:	eb 16                	jmp    800dcb <vprintfmt+0x1dd>
					putch(padc, putdat);
  800db5:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800db9:	83 ec 08             	sub    $0x8,%esp
  800dbc:	ff 75 0c             	pushl  0xc(%ebp)
  800dbf:	50                   	push   %eax
  800dc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc3:	ff d0                	call   *%eax
  800dc5:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dc8:	ff 4d e4             	decl   -0x1c(%ebp)
  800dcb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dcf:	7f e4                	jg     800db5 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800dd1:	eb 34                	jmp    800e07 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800dd3:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800dd7:	74 1c                	je     800df5 <vprintfmt+0x207>
  800dd9:	83 fb 1f             	cmp    $0x1f,%ebx
  800ddc:	7e 05                	jle    800de3 <vprintfmt+0x1f5>
  800dde:	83 fb 7e             	cmp    $0x7e,%ebx
  800de1:	7e 12                	jle    800df5 <vprintfmt+0x207>
					putch('?', putdat);
  800de3:	83 ec 08             	sub    $0x8,%esp
  800de6:	ff 75 0c             	pushl  0xc(%ebp)
  800de9:	6a 3f                	push   $0x3f
  800deb:	8b 45 08             	mov    0x8(%ebp),%eax
  800dee:	ff d0                	call   *%eax
  800df0:	83 c4 10             	add    $0x10,%esp
  800df3:	eb 0f                	jmp    800e04 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800df5:	83 ec 08             	sub    $0x8,%esp
  800df8:	ff 75 0c             	pushl  0xc(%ebp)
  800dfb:	53                   	push   %ebx
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	ff d0                	call   *%eax
  800e01:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e04:	ff 4d e4             	decl   -0x1c(%ebp)
  800e07:	89 f0                	mov    %esi,%eax
  800e09:	8d 70 01             	lea    0x1(%eax),%esi
  800e0c:	8a 00                	mov    (%eax),%al
  800e0e:	0f be d8             	movsbl %al,%ebx
  800e11:	85 db                	test   %ebx,%ebx
  800e13:	74 24                	je     800e39 <vprintfmt+0x24b>
  800e15:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e19:	78 b8                	js     800dd3 <vprintfmt+0x1e5>
  800e1b:	ff 4d e0             	decl   -0x20(%ebp)
  800e1e:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e22:	79 af                	jns    800dd3 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e24:	eb 13                	jmp    800e39 <vprintfmt+0x24b>
				putch(' ', putdat);
  800e26:	83 ec 08             	sub    $0x8,%esp
  800e29:	ff 75 0c             	pushl  0xc(%ebp)
  800e2c:	6a 20                	push   $0x20
  800e2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e31:	ff d0                	call   *%eax
  800e33:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e36:	ff 4d e4             	decl   -0x1c(%ebp)
  800e39:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e3d:	7f e7                	jg     800e26 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e3f:	e9 66 01 00 00       	jmp    800faa <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e44:	83 ec 08             	sub    $0x8,%esp
  800e47:	ff 75 e8             	pushl  -0x18(%ebp)
  800e4a:	8d 45 14             	lea    0x14(%ebp),%eax
  800e4d:	50                   	push   %eax
  800e4e:	e8 3c fd ff ff       	call   800b8f <getint>
  800e53:	83 c4 10             	add    $0x10,%esp
  800e56:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e59:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e62:	85 d2                	test   %edx,%edx
  800e64:	79 23                	jns    800e89 <vprintfmt+0x29b>
				putch('-', putdat);
  800e66:	83 ec 08             	sub    $0x8,%esp
  800e69:	ff 75 0c             	pushl  0xc(%ebp)
  800e6c:	6a 2d                	push   $0x2d
  800e6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e71:	ff d0                	call   *%eax
  800e73:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e76:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e79:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e7c:	f7 d8                	neg    %eax
  800e7e:	83 d2 00             	adc    $0x0,%edx
  800e81:	f7 da                	neg    %edx
  800e83:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e86:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e89:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e90:	e9 bc 00 00 00       	jmp    800f51 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e95:	83 ec 08             	sub    $0x8,%esp
  800e98:	ff 75 e8             	pushl  -0x18(%ebp)
  800e9b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e9e:	50                   	push   %eax
  800e9f:	e8 84 fc ff ff       	call   800b28 <getuint>
  800ea4:	83 c4 10             	add    $0x10,%esp
  800ea7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800eaa:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ead:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800eb4:	e9 98 00 00 00       	jmp    800f51 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800eb9:	83 ec 08             	sub    $0x8,%esp
  800ebc:	ff 75 0c             	pushl  0xc(%ebp)
  800ebf:	6a 58                	push   $0x58
  800ec1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ec4:	ff d0                	call   *%eax
  800ec6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ec9:	83 ec 08             	sub    $0x8,%esp
  800ecc:	ff 75 0c             	pushl  0xc(%ebp)
  800ecf:	6a 58                	push   $0x58
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	ff d0                	call   *%eax
  800ed6:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800ed9:	83 ec 08             	sub    $0x8,%esp
  800edc:	ff 75 0c             	pushl  0xc(%ebp)
  800edf:	6a 58                	push   $0x58
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	ff d0                	call   *%eax
  800ee6:	83 c4 10             	add    $0x10,%esp
			break;
  800ee9:	e9 bc 00 00 00       	jmp    800faa <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eee:	83 ec 08             	sub    $0x8,%esp
  800ef1:	ff 75 0c             	pushl  0xc(%ebp)
  800ef4:	6a 30                	push   $0x30
  800ef6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef9:	ff d0                	call   *%eax
  800efb:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800efe:	83 ec 08             	sub    $0x8,%esp
  800f01:	ff 75 0c             	pushl  0xc(%ebp)
  800f04:	6a 78                	push   $0x78
  800f06:	8b 45 08             	mov    0x8(%ebp),%eax
  800f09:	ff d0                	call   *%eax
  800f0b:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f11:	83 c0 04             	add    $0x4,%eax
  800f14:	89 45 14             	mov    %eax,0x14(%ebp)
  800f17:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1a:	83 e8 04             	sub    $0x4,%eax
  800f1d:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f1f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f29:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f30:	eb 1f                	jmp    800f51 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f32:	83 ec 08             	sub    $0x8,%esp
  800f35:	ff 75 e8             	pushl  -0x18(%ebp)
  800f38:	8d 45 14             	lea    0x14(%ebp),%eax
  800f3b:	50                   	push   %eax
  800f3c:	e8 e7 fb ff ff       	call   800b28 <getuint>
  800f41:	83 c4 10             	add    $0x10,%esp
  800f44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f47:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f4a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f51:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f55:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f58:	83 ec 04             	sub    $0x4,%esp
  800f5b:	52                   	push   %edx
  800f5c:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f5f:	50                   	push   %eax
  800f60:	ff 75 f4             	pushl  -0xc(%ebp)
  800f63:	ff 75 f0             	pushl  -0x10(%ebp)
  800f66:	ff 75 0c             	pushl  0xc(%ebp)
  800f69:	ff 75 08             	pushl  0x8(%ebp)
  800f6c:	e8 00 fb ff ff       	call   800a71 <printnum>
  800f71:	83 c4 20             	add    $0x20,%esp
			break;
  800f74:	eb 34                	jmp    800faa <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	53                   	push   %ebx
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	ff d0                	call   *%eax
  800f82:	83 c4 10             	add    $0x10,%esp
			break;
  800f85:	eb 23                	jmp    800faa <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f87:	83 ec 08             	sub    $0x8,%esp
  800f8a:	ff 75 0c             	pushl  0xc(%ebp)
  800f8d:	6a 25                	push   $0x25
  800f8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f92:	ff d0                	call   *%eax
  800f94:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f97:	ff 4d 10             	decl   0x10(%ebp)
  800f9a:	eb 03                	jmp    800f9f <vprintfmt+0x3b1>
  800f9c:	ff 4d 10             	decl   0x10(%ebp)
  800f9f:	8b 45 10             	mov    0x10(%ebp),%eax
  800fa2:	48                   	dec    %eax
  800fa3:	8a 00                	mov    (%eax),%al
  800fa5:	3c 25                	cmp    $0x25,%al
  800fa7:	75 f3                	jne    800f9c <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fa9:	90                   	nop
		}
	}
  800faa:	e9 47 fc ff ff       	jmp    800bf6 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800faf:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fb0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fb3:	5b                   	pop    %ebx
  800fb4:	5e                   	pop    %esi
  800fb5:	5d                   	pop    %ebp
  800fb6:	c3                   	ret    

00800fb7 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fb7:	55                   	push   %ebp
  800fb8:	89 e5                	mov    %esp,%ebp
  800fba:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fbd:	8d 45 10             	lea    0x10(%ebp),%eax
  800fc0:	83 c0 04             	add    $0x4,%eax
  800fc3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fc6:	8b 45 10             	mov    0x10(%ebp),%eax
  800fc9:	ff 75 f4             	pushl  -0xc(%ebp)
  800fcc:	50                   	push   %eax
  800fcd:	ff 75 0c             	pushl  0xc(%ebp)
  800fd0:	ff 75 08             	pushl  0x8(%ebp)
  800fd3:	e8 16 fc ff ff       	call   800bee <vprintfmt>
  800fd8:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fdb:	90                   	nop
  800fdc:	c9                   	leave  
  800fdd:	c3                   	ret    

00800fde <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fde:	55                   	push   %ebp
  800fdf:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800fe1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe4:	8b 40 08             	mov    0x8(%eax),%eax
  800fe7:	8d 50 01             	lea    0x1(%eax),%edx
  800fea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fed:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800ff0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff3:	8b 10                	mov    (%eax),%edx
  800ff5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff8:	8b 40 04             	mov    0x4(%eax),%eax
  800ffb:	39 c2                	cmp    %eax,%edx
  800ffd:	73 12                	jae    801011 <sprintputch+0x33>
		*b->buf++ = ch;
  800fff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801002:	8b 00                	mov    (%eax),%eax
  801004:	8d 48 01             	lea    0x1(%eax),%ecx
  801007:	8b 55 0c             	mov    0xc(%ebp),%edx
  80100a:	89 0a                	mov    %ecx,(%edx)
  80100c:	8b 55 08             	mov    0x8(%ebp),%edx
  80100f:	88 10                	mov    %dl,(%eax)
}
  801011:	90                   	nop
  801012:	5d                   	pop    %ebp
  801013:	c3                   	ret    

00801014 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801014:	55                   	push   %ebp
  801015:	89 e5                	mov    %esp,%ebp
  801017:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80101a:	8b 45 08             	mov    0x8(%ebp),%eax
  80101d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801020:	8b 45 0c             	mov    0xc(%ebp),%eax
  801023:	8d 50 ff             	lea    -0x1(%eax),%edx
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	01 d0                	add    %edx,%eax
  80102b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80102e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801035:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801039:	74 06                	je     801041 <vsnprintf+0x2d>
  80103b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80103f:	7f 07                	jg     801048 <vsnprintf+0x34>
		return -E_INVAL;
  801041:	b8 03 00 00 00       	mov    $0x3,%eax
  801046:	eb 20                	jmp    801068 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801048:	ff 75 14             	pushl  0x14(%ebp)
  80104b:	ff 75 10             	pushl  0x10(%ebp)
  80104e:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801051:	50                   	push   %eax
  801052:	68 de 0f 80 00       	push   $0x800fde
  801057:	e8 92 fb ff ff       	call   800bee <vprintfmt>
  80105c:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  80105f:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801062:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801065:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801068:	c9                   	leave  
  801069:	c3                   	ret    

0080106a <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80106a:	55                   	push   %ebp
  80106b:	89 e5                	mov    %esp,%ebp
  80106d:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801070:	8d 45 10             	lea    0x10(%ebp),%eax
  801073:	83 c0 04             	add    $0x4,%eax
  801076:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801079:	8b 45 10             	mov    0x10(%ebp),%eax
  80107c:	ff 75 f4             	pushl  -0xc(%ebp)
  80107f:	50                   	push   %eax
  801080:	ff 75 0c             	pushl  0xc(%ebp)
  801083:	ff 75 08             	pushl  0x8(%ebp)
  801086:	e8 89 ff ff ff       	call   801014 <vsnprintf>
  80108b:	83 c4 10             	add    $0x10,%esp
  80108e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801091:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801094:	c9                   	leave  
  801095:	c3                   	ret    

00801096 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801096:	55                   	push   %ebp
  801097:	89 e5                	mov    %esp,%ebp
  801099:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80109c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010a0:	74 13                	je     8010b5 <readline+0x1f>
		cprintf("%s", prompt);
  8010a2:	83 ec 08             	sub    $0x8,%esp
  8010a5:	ff 75 08             	pushl  0x8(%ebp)
  8010a8:	68 d0 2a 80 00       	push   $0x802ad0
  8010ad:	e8 62 f9 ff ff       	call   800a14 <cprintf>
  8010b2:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010b5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010bc:	83 ec 0c             	sub    $0xc,%esp
  8010bf:	6a 00                	push   $0x0
  8010c1:	e8 74 f5 ff ff       	call   80063a <iscons>
  8010c6:	83 c4 10             	add    $0x10,%esp
  8010c9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010cc:	e8 1b f5 ff ff       	call   8005ec <getchar>
  8010d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010d4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010d8:	79 22                	jns    8010fc <readline+0x66>
			if (c != -E_EOF)
  8010da:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010de:	0f 84 ad 00 00 00    	je     801191 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010e4:	83 ec 08             	sub    $0x8,%esp
  8010e7:	ff 75 ec             	pushl  -0x14(%ebp)
  8010ea:	68 d3 2a 80 00       	push   $0x802ad3
  8010ef:	e8 20 f9 ff ff       	call   800a14 <cprintf>
  8010f4:	83 c4 10             	add    $0x10,%esp
			return;
  8010f7:	e9 95 00 00 00       	jmp    801191 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8010fc:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801100:	7e 34                	jle    801136 <readline+0xa0>
  801102:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801109:	7f 2b                	jg     801136 <readline+0xa0>
			if (echoing)
  80110b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80110f:	74 0e                	je     80111f <readline+0x89>
				cputchar(c);
  801111:	83 ec 0c             	sub    $0xc,%esp
  801114:	ff 75 ec             	pushl  -0x14(%ebp)
  801117:	e8 88 f4 ff ff       	call   8005a4 <cputchar>
  80111c:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  80111f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801122:	8d 50 01             	lea    0x1(%eax),%edx
  801125:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801128:	89 c2                	mov    %eax,%edx
  80112a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80112d:	01 d0                	add    %edx,%eax
  80112f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801132:	88 10                	mov    %dl,(%eax)
  801134:	eb 56                	jmp    80118c <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801136:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80113a:	75 1f                	jne    80115b <readline+0xc5>
  80113c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801140:	7e 19                	jle    80115b <readline+0xc5>
			if (echoing)
  801142:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801146:	74 0e                	je     801156 <readline+0xc0>
				cputchar(c);
  801148:	83 ec 0c             	sub    $0xc,%esp
  80114b:	ff 75 ec             	pushl  -0x14(%ebp)
  80114e:	e8 51 f4 ff ff       	call   8005a4 <cputchar>
  801153:	83 c4 10             	add    $0x10,%esp

			i--;
  801156:	ff 4d f4             	decl   -0xc(%ebp)
  801159:	eb 31                	jmp    80118c <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80115b:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  80115f:	74 0a                	je     80116b <readline+0xd5>
  801161:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801165:	0f 85 61 ff ff ff    	jne    8010cc <readline+0x36>
			if (echoing)
  80116b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80116f:	74 0e                	je     80117f <readline+0xe9>
				cputchar(c);
  801171:	83 ec 0c             	sub    $0xc,%esp
  801174:	ff 75 ec             	pushl  -0x14(%ebp)
  801177:	e8 28 f4 ff ff       	call   8005a4 <cputchar>
  80117c:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  80117f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801182:	8b 45 0c             	mov    0xc(%ebp),%eax
  801185:	01 d0                	add    %edx,%eax
  801187:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80118a:	eb 06                	jmp    801192 <readline+0xfc>
		}
	}
  80118c:	e9 3b ff ff ff       	jmp    8010cc <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801191:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801192:	c9                   	leave  
  801193:	c3                   	ret    

00801194 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801194:	55                   	push   %ebp
  801195:	89 e5                	mov    %esp,%ebp
  801197:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80119a:	e8 31 0b 00 00       	call   801cd0 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  80119f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011a3:	74 13                	je     8011b8 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011a5:	83 ec 08             	sub    $0x8,%esp
  8011a8:	ff 75 08             	pushl  0x8(%ebp)
  8011ab:	68 d0 2a 80 00       	push   $0x802ad0
  8011b0:	e8 5f f8 ff ff       	call   800a14 <cprintf>
  8011b5:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011bf:	83 ec 0c             	sub    $0xc,%esp
  8011c2:	6a 00                	push   $0x0
  8011c4:	e8 71 f4 ff ff       	call   80063a <iscons>
  8011c9:	83 c4 10             	add    $0x10,%esp
  8011cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011cf:	e8 18 f4 ff ff       	call   8005ec <getchar>
  8011d4:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011d7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011db:	79 23                	jns    801200 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011dd:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011e1:	74 13                	je     8011f6 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011e3:	83 ec 08             	sub    $0x8,%esp
  8011e6:	ff 75 ec             	pushl  -0x14(%ebp)
  8011e9:	68 d3 2a 80 00       	push   $0x802ad3
  8011ee:	e8 21 f8 ff ff       	call   800a14 <cprintf>
  8011f3:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8011f6:	e8 ef 0a 00 00       	call   801cea <sys_enable_interrupt>
			return;
  8011fb:	e9 9a 00 00 00       	jmp    80129a <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801200:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801204:	7e 34                	jle    80123a <atomic_readline+0xa6>
  801206:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80120d:	7f 2b                	jg     80123a <atomic_readline+0xa6>
			if (echoing)
  80120f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801213:	74 0e                	je     801223 <atomic_readline+0x8f>
				cputchar(c);
  801215:	83 ec 0c             	sub    $0xc,%esp
  801218:	ff 75 ec             	pushl  -0x14(%ebp)
  80121b:	e8 84 f3 ff ff       	call   8005a4 <cputchar>
  801220:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801223:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801226:	8d 50 01             	lea    0x1(%eax),%edx
  801229:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80122c:	89 c2                	mov    %eax,%edx
  80122e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801231:	01 d0                	add    %edx,%eax
  801233:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801236:	88 10                	mov    %dl,(%eax)
  801238:	eb 5b                	jmp    801295 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80123a:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80123e:	75 1f                	jne    80125f <atomic_readline+0xcb>
  801240:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801244:	7e 19                	jle    80125f <atomic_readline+0xcb>
			if (echoing)
  801246:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80124a:	74 0e                	je     80125a <atomic_readline+0xc6>
				cputchar(c);
  80124c:	83 ec 0c             	sub    $0xc,%esp
  80124f:	ff 75 ec             	pushl  -0x14(%ebp)
  801252:	e8 4d f3 ff ff       	call   8005a4 <cputchar>
  801257:	83 c4 10             	add    $0x10,%esp
			i--;
  80125a:	ff 4d f4             	decl   -0xc(%ebp)
  80125d:	eb 36                	jmp    801295 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  80125f:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801263:	74 0a                	je     80126f <atomic_readline+0xdb>
  801265:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801269:	0f 85 60 ff ff ff    	jne    8011cf <atomic_readline+0x3b>
			if (echoing)
  80126f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801273:	74 0e                	je     801283 <atomic_readline+0xef>
				cputchar(c);
  801275:	83 ec 0c             	sub    $0xc,%esp
  801278:	ff 75 ec             	pushl  -0x14(%ebp)
  80127b:	e8 24 f3 ff ff       	call   8005a4 <cputchar>
  801280:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801283:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801286:	8b 45 0c             	mov    0xc(%ebp),%eax
  801289:	01 d0                	add    %edx,%eax
  80128b:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80128e:	e8 57 0a 00 00       	call   801cea <sys_enable_interrupt>
			return;
  801293:	eb 05                	jmp    80129a <atomic_readline+0x106>
		}
	}
  801295:	e9 35 ff ff ff       	jmp    8011cf <atomic_readline+0x3b>
}
  80129a:	c9                   	leave  
  80129b:	c3                   	ret    

0080129c <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80129c:	55                   	push   %ebp
  80129d:	89 e5                	mov    %esp,%ebp
  80129f:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012a2:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012a9:	eb 06                	jmp    8012b1 <strlen+0x15>
		n++;
  8012ab:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012ae:	ff 45 08             	incl   0x8(%ebp)
  8012b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012b4:	8a 00                	mov    (%eax),%al
  8012b6:	84 c0                	test   %al,%al
  8012b8:	75 f1                	jne    8012ab <strlen+0xf>
		n++;
	return n;
  8012ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012bd:	c9                   	leave  
  8012be:	c3                   	ret    

008012bf <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012bf:	55                   	push   %ebp
  8012c0:	89 e5                	mov    %esp,%ebp
  8012c2:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012c5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012cc:	eb 09                	jmp    8012d7 <strnlen+0x18>
		n++;
  8012ce:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012d1:	ff 45 08             	incl   0x8(%ebp)
  8012d4:	ff 4d 0c             	decl   0xc(%ebp)
  8012d7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012db:	74 09                	je     8012e6 <strnlen+0x27>
  8012dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e0:	8a 00                	mov    (%eax),%al
  8012e2:	84 c0                	test   %al,%al
  8012e4:	75 e8                	jne    8012ce <strnlen+0xf>
		n++;
	return n;
  8012e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012e9:	c9                   	leave  
  8012ea:	c3                   	ret    

008012eb <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012eb:	55                   	push   %ebp
  8012ec:	89 e5                	mov    %esp,%ebp
  8012ee:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8012f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8012f7:	90                   	nop
  8012f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8012fb:	8d 50 01             	lea    0x1(%eax),%edx
  8012fe:	89 55 08             	mov    %edx,0x8(%ebp)
  801301:	8b 55 0c             	mov    0xc(%ebp),%edx
  801304:	8d 4a 01             	lea    0x1(%edx),%ecx
  801307:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80130a:	8a 12                	mov    (%edx),%dl
  80130c:	88 10                	mov    %dl,(%eax)
  80130e:	8a 00                	mov    (%eax),%al
  801310:	84 c0                	test   %al,%al
  801312:	75 e4                	jne    8012f8 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801314:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801317:	c9                   	leave  
  801318:	c3                   	ret    

00801319 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  801319:	55                   	push   %ebp
  80131a:	89 e5                	mov    %esp,%ebp
  80131c:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  80131f:	8b 45 08             	mov    0x8(%ebp),%eax
  801322:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801325:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80132c:	eb 1f                	jmp    80134d <strncpy+0x34>
		*dst++ = *src;
  80132e:	8b 45 08             	mov    0x8(%ebp),%eax
  801331:	8d 50 01             	lea    0x1(%eax),%edx
  801334:	89 55 08             	mov    %edx,0x8(%ebp)
  801337:	8b 55 0c             	mov    0xc(%ebp),%edx
  80133a:	8a 12                	mov    (%edx),%dl
  80133c:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80133e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801341:	8a 00                	mov    (%eax),%al
  801343:	84 c0                	test   %al,%al
  801345:	74 03                	je     80134a <strncpy+0x31>
			src++;
  801347:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80134a:	ff 45 fc             	incl   -0x4(%ebp)
  80134d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801350:	3b 45 10             	cmp    0x10(%ebp),%eax
  801353:	72 d9                	jb     80132e <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801355:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801358:	c9                   	leave  
  801359:	c3                   	ret    

0080135a <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80135a:	55                   	push   %ebp
  80135b:	89 e5                	mov    %esp,%ebp
  80135d:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801360:	8b 45 08             	mov    0x8(%ebp),%eax
  801363:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801366:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80136a:	74 30                	je     80139c <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80136c:	eb 16                	jmp    801384 <strlcpy+0x2a>
			*dst++ = *src++;
  80136e:	8b 45 08             	mov    0x8(%ebp),%eax
  801371:	8d 50 01             	lea    0x1(%eax),%edx
  801374:	89 55 08             	mov    %edx,0x8(%ebp)
  801377:	8b 55 0c             	mov    0xc(%ebp),%edx
  80137a:	8d 4a 01             	lea    0x1(%edx),%ecx
  80137d:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801380:	8a 12                	mov    (%edx),%dl
  801382:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801384:	ff 4d 10             	decl   0x10(%ebp)
  801387:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80138b:	74 09                	je     801396 <strlcpy+0x3c>
  80138d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801390:	8a 00                	mov    (%eax),%al
  801392:	84 c0                	test   %al,%al
  801394:	75 d8                	jne    80136e <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801396:	8b 45 08             	mov    0x8(%ebp),%eax
  801399:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80139c:	8b 55 08             	mov    0x8(%ebp),%edx
  80139f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013a2:	29 c2                	sub    %eax,%edx
  8013a4:	89 d0                	mov    %edx,%eax
}
  8013a6:	c9                   	leave  
  8013a7:	c3                   	ret    

008013a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013a8:	55                   	push   %ebp
  8013a9:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013ab:	eb 06                	jmp    8013b3 <strcmp+0xb>
		p++, q++;
  8013ad:	ff 45 08             	incl   0x8(%ebp)
  8013b0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b6:	8a 00                	mov    (%eax),%al
  8013b8:	84 c0                	test   %al,%al
  8013ba:	74 0e                	je     8013ca <strcmp+0x22>
  8013bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8013bf:	8a 10                	mov    (%eax),%dl
  8013c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013c4:	8a 00                	mov    (%eax),%al
  8013c6:	38 c2                	cmp    %al,%dl
  8013c8:	74 e3                	je     8013ad <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cd:	8a 00                	mov    (%eax),%al
  8013cf:	0f b6 d0             	movzbl %al,%edx
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	0f b6 c0             	movzbl %al,%eax
  8013da:	29 c2                	sub    %eax,%edx
  8013dc:	89 d0                	mov    %edx,%eax
}
  8013de:	5d                   	pop    %ebp
  8013df:	c3                   	ret    

008013e0 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013e0:	55                   	push   %ebp
  8013e1:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013e3:	eb 09                	jmp    8013ee <strncmp+0xe>
		n--, p++, q++;
  8013e5:	ff 4d 10             	decl   0x10(%ebp)
  8013e8:	ff 45 08             	incl   0x8(%ebp)
  8013eb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013ee:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013f2:	74 17                	je     80140b <strncmp+0x2b>
  8013f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f7:	8a 00                	mov    (%eax),%al
  8013f9:	84 c0                	test   %al,%al
  8013fb:	74 0e                	je     80140b <strncmp+0x2b>
  8013fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801400:	8a 10                	mov    (%eax),%dl
  801402:	8b 45 0c             	mov    0xc(%ebp),%eax
  801405:	8a 00                	mov    (%eax),%al
  801407:	38 c2                	cmp    %al,%dl
  801409:	74 da                	je     8013e5 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80140b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140f:	75 07                	jne    801418 <strncmp+0x38>
		return 0;
  801411:	b8 00 00 00 00       	mov    $0x0,%eax
  801416:	eb 14                	jmp    80142c <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	8a 00                	mov    (%eax),%al
  80141d:	0f b6 d0             	movzbl %al,%edx
  801420:	8b 45 0c             	mov    0xc(%ebp),%eax
  801423:	8a 00                	mov    (%eax),%al
  801425:	0f b6 c0             	movzbl %al,%eax
  801428:	29 c2                	sub    %eax,%edx
  80142a:	89 d0                	mov    %edx,%eax
}
  80142c:	5d                   	pop    %ebp
  80142d:	c3                   	ret    

0080142e <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80142e:	55                   	push   %ebp
  80142f:	89 e5                	mov    %esp,%ebp
  801431:	83 ec 04             	sub    $0x4,%esp
  801434:	8b 45 0c             	mov    0xc(%ebp),%eax
  801437:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80143a:	eb 12                	jmp    80144e <strchr+0x20>
		if (*s == c)
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801444:	75 05                	jne    80144b <strchr+0x1d>
			return (char *) s;
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	eb 11                	jmp    80145c <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80144b:	ff 45 08             	incl   0x8(%ebp)
  80144e:	8b 45 08             	mov    0x8(%ebp),%eax
  801451:	8a 00                	mov    (%eax),%al
  801453:	84 c0                	test   %al,%al
  801455:	75 e5                	jne    80143c <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801457:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80145c:	c9                   	leave  
  80145d:	c3                   	ret    

0080145e <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80145e:	55                   	push   %ebp
  80145f:	89 e5                	mov    %esp,%ebp
  801461:	83 ec 04             	sub    $0x4,%esp
  801464:	8b 45 0c             	mov    0xc(%ebp),%eax
  801467:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80146a:	eb 0d                	jmp    801479 <strfind+0x1b>
		if (*s == c)
  80146c:	8b 45 08             	mov    0x8(%ebp),%eax
  80146f:	8a 00                	mov    (%eax),%al
  801471:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801474:	74 0e                	je     801484 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801476:	ff 45 08             	incl   0x8(%ebp)
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	8a 00                	mov    (%eax),%al
  80147e:	84 c0                	test   %al,%al
  801480:	75 ea                	jne    80146c <strfind+0xe>
  801482:	eb 01                	jmp    801485 <strfind+0x27>
		if (*s == c)
			break;
  801484:	90                   	nop
	return (char *) s;
  801485:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801488:	c9                   	leave  
  801489:	c3                   	ret    

0080148a <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80148a:	55                   	push   %ebp
  80148b:	89 e5                	mov    %esp,%ebp
  80148d:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801496:	8b 45 10             	mov    0x10(%ebp),%eax
  801499:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80149c:	eb 0e                	jmp    8014ac <memset+0x22>
		*p++ = c;
  80149e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014a1:	8d 50 01             	lea    0x1(%eax),%edx
  8014a4:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014aa:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014ac:	ff 4d f8             	decl   -0x8(%ebp)
  8014af:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014b3:	79 e9                	jns    80149e <memset+0x14>
		*p++ = c;

	return v;
  8014b5:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014b8:	c9                   	leave  
  8014b9:	c3                   	ret    

008014ba <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014ba:	55                   	push   %ebp
  8014bb:	89 e5                	mov    %esp,%ebp
  8014bd:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014cc:	eb 16                	jmp    8014e4 <memcpy+0x2a>
		*d++ = *s++;
  8014ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d1:	8d 50 01             	lea    0x1(%eax),%edx
  8014d4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014d7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014da:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014dd:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014e0:	8a 12                	mov    (%edx),%dl
  8014e2:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014e7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014ea:	89 55 10             	mov    %edx,0x10(%ebp)
  8014ed:	85 c0                	test   %eax,%eax
  8014ef:	75 dd                	jne    8014ce <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8014f1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014f4:	c9                   	leave  
  8014f5:	c3                   	ret    

008014f6 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8014f6:	55                   	push   %ebp
  8014f7:	89 e5                	mov    %esp,%ebp
  8014f9:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014ff:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
  801505:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801508:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80150b:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80150e:	73 50                	jae    801560 <memmove+0x6a>
  801510:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801513:	8b 45 10             	mov    0x10(%ebp),%eax
  801516:	01 d0                	add    %edx,%eax
  801518:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80151b:	76 43                	jbe    801560 <memmove+0x6a>
		s += n;
  80151d:	8b 45 10             	mov    0x10(%ebp),%eax
  801520:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801523:	8b 45 10             	mov    0x10(%ebp),%eax
  801526:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801529:	eb 10                	jmp    80153b <memmove+0x45>
			*--d = *--s;
  80152b:	ff 4d f8             	decl   -0x8(%ebp)
  80152e:	ff 4d fc             	decl   -0x4(%ebp)
  801531:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801534:	8a 10                	mov    (%eax),%dl
  801536:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801539:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80153b:	8b 45 10             	mov    0x10(%ebp),%eax
  80153e:	8d 50 ff             	lea    -0x1(%eax),%edx
  801541:	89 55 10             	mov    %edx,0x10(%ebp)
  801544:	85 c0                	test   %eax,%eax
  801546:	75 e3                	jne    80152b <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801548:	eb 23                	jmp    80156d <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80154a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154d:	8d 50 01             	lea    0x1(%eax),%edx
  801550:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801553:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801556:	8d 4a 01             	lea    0x1(%edx),%ecx
  801559:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80155c:	8a 12                	mov    (%edx),%dl
  80155e:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801560:	8b 45 10             	mov    0x10(%ebp),%eax
  801563:	8d 50 ff             	lea    -0x1(%eax),%edx
  801566:	89 55 10             	mov    %edx,0x10(%ebp)
  801569:	85 c0                	test   %eax,%eax
  80156b:	75 dd                	jne    80154a <memmove+0x54>
			*d++ = *s++;

	return dst;
  80156d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801570:	c9                   	leave  
  801571:	c3                   	ret    

00801572 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801572:	55                   	push   %ebp
  801573:	89 e5                	mov    %esp,%ebp
  801575:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801578:	8b 45 08             	mov    0x8(%ebp),%eax
  80157b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80157e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801581:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801584:	eb 2a                	jmp    8015b0 <memcmp+0x3e>
		if (*s1 != *s2)
  801586:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801589:	8a 10                	mov    (%eax),%dl
  80158b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80158e:	8a 00                	mov    (%eax),%al
  801590:	38 c2                	cmp    %al,%dl
  801592:	74 16                	je     8015aa <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801594:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801597:	8a 00                	mov    (%eax),%al
  801599:	0f b6 d0             	movzbl %al,%edx
  80159c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	0f b6 c0             	movzbl %al,%eax
  8015a4:	29 c2                	sub    %eax,%edx
  8015a6:	89 d0                	mov    %edx,%eax
  8015a8:	eb 18                	jmp    8015c2 <memcmp+0x50>
		s1++, s2++;
  8015aa:	ff 45 fc             	incl   -0x4(%ebp)
  8015ad:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015b0:	8b 45 10             	mov    0x10(%ebp),%eax
  8015b3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015b6:	89 55 10             	mov    %edx,0x10(%ebp)
  8015b9:	85 c0                	test   %eax,%eax
  8015bb:	75 c9                	jne    801586 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015bd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
  8015c7:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015ca:	8b 55 08             	mov    0x8(%ebp),%edx
  8015cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8015d0:	01 d0                	add    %edx,%eax
  8015d2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015d5:	eb 15                	jmp    8015ec <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015da:	8a 00                	mov    (%eax),%al
  8015dc:	0f b6 d0             	movzbl %al,%edx
  8015df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e2:	0f b6 c0             	movzbl %al,%eax
  8015e5:	39 c2                	cmp    %eax,%edx
  8015e7:	74 0d                	je     8015f6 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015e9:	ff 45 08             	incl   0x8(%ebp)
  8015ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ef:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8015f2:	72 e3                	jb     8015d7 <memfind+0x13>
  8015f4:	eb 01                	jmp    8015f7 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8015f6:	90                   	nop
	return (void *) s;
  8015f7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015fa:	c9                   	leave  
  8015fb:	c3                   	ret    

008015fc <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8015fc:	55                   	push   %ebp
  8015fd:	89 e5                	mov    %esp,%ebp
  8015ff:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801602:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801609:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801610:	eb 03                	jmp    801615 <strtol+0x19>
		s++;
  801612:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801615:	8b 45 08             	mov    0x8(%ebp),%eax
  801618:	8a 00                	mov    (%eax),%al
  80161a:	3c 20                	cmp    $0x20,%al
  80161c:	74 f4                	je     801612 <strtol+0x16>
  80161e:	8b 45 08             	mov    0x8(%ebp),%eax
  801621:	8a 00                	mov    (%eax),%al
  801623:	3c 09                	cmp    $0x9,%al
  801625:	74 eb                	je     801612 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801627:	8b 45 08             	mov    0x8(%ebp),%eax
  80162a:	8a 00                	mov    (%eax),%al
  80162c:	3c 2b                	cmp    $0x2b,%al
  80162e:	75 05                	jne    801635 <strtol+0x39>
		s++;
  801630:	ff 45 08             	incl   0x8(%ebp)
  801633:	eb 13                	jmp    801648 <strtol+0x4c>
	else if (*s == '-')
  801635:	8b 45 08             	mov    0x8(%ebp),%eax
  801638:	8a 00                	mov    (%eax),%al
  80163a:	3c 2d                	cmp    $0x2d,%al
  80163c:	75 0a                	jne    801648 <strtol+0x4c>
		s++, neg = 1;
  80163e:	ff 45 08             	incl   0x8(%ebp)
  801641:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801648:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80164c:	74 06                	je     801654 <strtol+0x58>
  80164e:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801652:	75 20                	jne    801674 <strtol+0x78>
  801654:	8b 45 08             	mov    0x8(%ebp),%eax
  801657:	8a 00                	mov    (%eax),%al
  801659:	3c 30                	cmp    $0x30,%al
  80165b:	75 17                	jne    801674 <strtol+0x78>
  80165d:	8b 45 08             	mov    0x8(%ebp),%eax
  801660:	40                   	inc    %eax
  801661:	8a 00                	mov    (%eax),%al
  801663:	3c 78                	cmp    $0x78,%al
  801665:	75 0d                	jne    801674 <strtol+0x78>
		s += 2, base = 16;
  801667:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80166b:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801672:	eb 28                	jmp    80169c <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801674:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801678:	75 15                	jne    80168f <strtol+0x93>
  80167a:	8b 45 08             	mov    0x8(%ebp),%eax
  80167d:	8a 00                	mov    (%eax),%al
  80167f:	3c 30                	cmp    $0x30,%al
  801681:	75 0c                	jne    80168f <strtol+0x93>
		s++, base = 8;
  801683:	ff 45 08             	incl   0x8(%ebp)
  801686:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80168d:	eb 0d                	jmp    80169c <strtol+0xa0>
	else if (base == 0)
  80168f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801693:	75 07                	jne    80169c <strtol+0xa0>
		base = 10;
  801695:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80169c:	8b 45 08             	mov    0x8(%ebp),%eax
  80169f:	8a 00                	mov    (%eax),%al
  8016a1:	3c 2f                	cmp    $0x2f,%al
  8016a3:	7e 19                	jle    8016be <strtol+0xc2>
  8016a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a8:	8a 00                	mov    (%eax),%al
  8016aa:	3c 39                	cmp    $0x39,%al
  8016ac:	7f 10                	jg     8016be <strtol+0xc2>
			dig = *s - '0';
  8016ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b1:	8a 00                	mov    (%eax),%al
  8016b3:	0f be c0             	movsbl %al,%eax
  8016b6:	83 e8 30             	sub    $0x30,%eax
  8016b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016bc:	eb 42                	jmp    801700 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016be:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c1:	8a 00                	mov    (%eax),%al
  8016c3:	3c 60                	cmp    $0x60,%al
  8016c5:	7e 19                	jle    8016e0 <strtol+0xe4>
  8016c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ca:	8a 00                	mov    (%eax),%al
  8016cc:	3c 7a                	cmp    $0x7a,%al
  8016ce:	7f 10                	jg     8016e0 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d3:	8a 00                	mov    (%eax),%al
  8016d5:	0f be c0             	movsbl %al,%eax
  8016d8:	83 e8 57             	sub    $0x57,%eax
  8016db:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016de:	eb 20                	jmp    801700 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e3:	8a 00                	mov    (%eax),%al
  8016e5:	3c 40                	cmp    $0x40,%al
  8016e7:	7e 39                	jle    801722 <strtol+0x126>
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	8a 00                	mov    (%eax),%al
  8016ee:	3c 5a                	cmp    $0x5a,%al
  8016f0:	7f 30                	jg     801722 <strtol+0x126>
			dig = *s - 'A' + 10;
  8016f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f5:	8a 00                	mov    (%eax),%al
  8016f7:	0f be c0             	movsbl %al,%eax
  8016fa:	83 e8 37             	sub    $0x37,%eax
  8016fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801700:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801703:	3b 45 10             	cmp    0x10(%ebp),%eax
  801706:	7d 19                	jge    801721 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801708:	ff 45 08             	incl   0x8(%ebp)
  80170b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170e:	0f af 45 10          	imul   0x10(%ebp),%eax
  801712:	89 c2                	mov    %eax,%edx
  801714:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801717:	01 d0                	add    %edx,%eax
  801719:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80171c:	e9 7b ff ff ff       	jmp    80169c <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801721:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801722:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801726:	74 08                	je     801730 <strtol+0x134>
		*endptr = (char *) s;
  801728:	8b 45 0c             	mov    0xc(%ebp),%eax
  80172b:	8b 55 08             	mov    0x8(%ebp),%edx
  80172e:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801730:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801734:	74 07                	je     80173d <strtol+0x141>
  801736:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801739:	f7 d8                	neg    %eax
  80173b:	eb 03                	jmp    801740 <strtol+0x144>
  80173d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801740:	c9                   	leave  
  801741:	c3                   	ret    

00801742 <ltostr>:

void
ltostr(long value, char *str)
{
  801742:	55                   	push   %ebp
  801743:	89 e5                	mov    %esp,%ebp
  801745:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801748:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80174f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801756:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80175a:	79 13                	jns    80176f <ltostr+0x2d>
	{
		neg = 1;
  80175c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801763:	8b 45 0c             	mov    0xc(%ebp),%eax
  801766:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801769:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80176c:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80176f:	8b 45 08             	mov    0x8(%ebp),%eax
  801772:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801777:	99                   	cltd   
  801778:	f7 f9                	idiv   %ecx
  80177a:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80177d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801780:	8d 50 01             	lea    0x1(%eax),%edx
  801783:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801786:	89 c2                	mov    %eax,%edx
  801788:	8b 45 0c             	mov    0xc(%ebp),%eax
  80178b:	01 d0                	add    %edx,%eax
  80178d:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801790:	83 c2 30             	add    $0x30,%edx
  801793:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801795:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801798:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80179d:	f7 e9                	imul   %ecx
  80179f:	c1 fa 02             	sar    $0x2,%edx
  8017a2:	89 c8                	mov    %ecx,%eax
  8017a4:	c1 f8 1f             	sar    $0x1f,%eax
  8017a7:	29 c2                	sub    %eax,%edx
  8017a9:	89 d0                	mov    %edx,%eax
  8017ab:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017ae:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017b1:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017b6:	f7 e9                	imul   %ecx
  8017b8:	c1 fa 02             	sar    $0x2,%edx
  8017bb:	89 c8                	mov    %ecx,%eax
  8017bd:	c1 f8 1f             	sar    $0x1f,%eax
  8017c0:	29 c2                	sub    %eax,%edx
  8017c2:	89 d0                	mov    %edx,%eax
  8017c4:	c1 e0 02             	shl    $0x2,%eax
  8017c7:	01 d0                	add    %edx,%eax
  8017c9:	01 c0                	add    %eax,%eax
  8017cb:	29 c1                	sub    %eax,%ecx
  8017cd:	89 ca                	mov    %ecx,%edx
  8017cf:	85 d2                	test   %edx,%edx
  8017d1:	75 9c                	jne    80176f <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017d3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017da:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017dd:	48                   	dec    %eax
  8017de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017e1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017e5:	74 3d                	je     801824 <ltostr+0xe2>
		start = 1 ;
  8017e7:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017ee:	eb 34                	jmp    801824 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8017f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8017f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f6:	01 d0                	add    %edx,%eax
  8017f8:	8a 00                	mov    (%eax),%al
  8017fa:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8017fd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801800:	8b 45 0c             	mov    0xc(%ebp),%eax
  801803:	01 c2                	add    %eax,%edx
  801805:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801808:	8b 45 0c             	mov    0xc(%ebp),%eax
  80180b:	01 c8                	add    %ecx,%eax
  80180d:	8a 00                	mov    (%eax),%al
  80180f:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801811:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801814:	8b 45 0c             	mov    0xc(%ebp),%eax
  801817:	01 c2                	add    %eax,%edx
  801819:	8a 45 eb             	mov    -0x15(%ebp),%al
  80181c:	88 02                	mov    %al,(%edx)
		start++ ;
  80181e:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801821:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801824:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801827:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80182a:	7c c4                	jl     8017f0 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80182c:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80182f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801832:	01 d0                	add    %edx,%eax
  801834:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801837:	90                   	nop
  801838:	c9                   	leave  
  801839:	c3                   	ret    

0080183a <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80183a:	55                   	push   %ebp
  80183b:	89 e5                	mov    %esp,%ebp
  80183d:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801840:	ff 75 08             	pushl  0x8(%ebp)
  801843:	e8 54 fa ff ff       	call   80129c <strlen>
  801848:	83 c4 04             	add    $0x4,%esp
  80184b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80184e:	ff 75 0c             	pushl  0xc(%ebp)
  801851:	e8 46 fa ff ff       	call   80129c <strlen>
  801856:	83 c4 04             	add    $0x4,%esp
  801859:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80185c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801863:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80186a:	eb 17                	jmp    801883 <strcconcat+0x49>
		final[s] = str1[s] ;
  80186c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80186f:	8b 45 10             	mov    0x10(%ebp),%eax
  801872:	01 c2                	add    %eax,%edx
  801874:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801877:	8b 45 08             	mov    0x8(%ebp),%eax
  80187a:	01 c8                	add    %ecx,%eax
  80187c:	8a 00                	mov    (%eax),%al
  80187e:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801880:	ff 45 fc             	incl   -0x4(%ebp)
  801883:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801886:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801889:	7c e1                	jl     80186c <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80188b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801892:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801899:	eb 1f                	jmp    8018ba <strcconcat+0x80>
		final[s++] = str2[i] ;
  80189b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80189e:	8d 50 01             	lea    0x1(%eax),%edx
  8018a1:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018a4:	89 c2                	mov    %eax,%edx
  8018a6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018a9:	01 c2                	add    %eax,%edx
  8018ab:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018b1:	01 c8                	add    %ecx,%eax
  8018b3:	8a 00                	mov    (%eax),%al
  8018b5:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018b7:	ff 45 f8             	incl   -0x8(%ebp)
  8018ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018bd:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018c0:	7c d9                	jl     80189b <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018c2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8018c8:	01 d0                	add    %edx,%eax
  8018ca:	c6 00 00             	movb   $0x0,(%eax)
}
  8018cd:	90                   	nop
  8018ce:	c9                   	leave  
  8018cf:	c3                   	ret    

008018d0 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018d0:	55                   	push   %ebp
  8018d1:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018d3:	8b 45 14             	mov    0x14(%ebp),%eax
  8018d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018dc:	8b 45 14             	mov    0x14(%ebp),%eax
  8018df:	8b 00                	mov    (%eax),%eax
  8018e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8018eb:	01 d0                	add    %edx,%eax
  8018ed:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8018f3:	eb 0c                	jmp    801901 <strsplit+0x31>
			*string++ = 0;
  8018f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f8:	8d 50 01             	lea    0x1(%eax),%edx
  8018fb:	89 55 08             	mov    %edx,0x8(%ebp)
  8018fe:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801901:	8b 45 08             	mov    0x8(%ebp),%eax
  801904:	8a 00                	mov    (%eax),%al
  801906:	84 c0                	test   %al,%al
  801908:	74 18                	je     801922 <strsplit+0x52>
  80190a:	8b 45 08             	mov    0x8(%ebp),%eax
  80190d:	8a 00                	mov    (%eax),%al
  80190f:	0f be c0             	movsbl %al,%eax
  801912:	50                   	push   %eax
  801913:	ff 75 0c             	pushl  0xc(%ebp)
  801916:	e8 13 fb ff ff       	call   80142e <strchr>
  80191b:	83 c4 08             	add    $0x8,%esp
  80191e:	85 c0                	test   %eax,%eax
  801920:	75 d3                	jne    8018f5 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801922:	8b 45 08             	mov    0x8(%ebp),%eax
  801925:	8a 00                	mov    (%eax),%al
  801927:	84 c0                	test   %al,%al
  801929:	74 5a                	je     801985 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80192b:	8b 45 14             	mov    0x14(%ebp),%eax
  80192e:	8b 00                	mov    (%eax),%eax
  801930:	83 f8 0f             	cmp    $0xf,%eax
  801933:	75 07                	jne    80193c <strsplit+0x6c>
		{
			return 0;
  801935:	b8 00 00 00 00       	mov    $0x0,%eax
  80193a:	eb 66                	jmp    8019a2 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80193c:	8b 45 14             	mov    0x14(%ebp),%eax
  80193f:	8b 00                	mov    (%eax),%eax
  801941:	8d 48 01             	lea    0x1(%eax),%ecx
  801944:	8b 55 14             	mov    0x14(%ebp),%edx
  801947:	89 0a                	mov    %ecx,(%edx)
  801949:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801950:	8b 45 10             	mov    0x10(%ebp),%eax
  801953:	01 c2                	add    %eax,%edx
  801955:	8b 45 08             	mov    0x8(%ebp),%eax
  801958:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80195a:	eb 03                	jmp    80195f <strsplit+0x8f>
			string++;
  80195c:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80195f:	8b 45 08             	mov    0x8(%ebp),%eax
  801962:	8a 00                	mov    (%eax),%al
  801964:	84 c0                	test   %al,%al
  801966:	74 8b                	je     8018f3 <strsplit+0x23>
  801968:	8b 45 08             	mov    0x8(%ebp),%eax
  80196b:	8a 00                	mov    (%eax),%al
  80196d:	0f be c0             	movsbl %al,%eax
  801970:	50                   	push   %eax
  801971:	ff 75 0c             	pushl  0xc(%ebp)
  801974:	e8 b5 fa ff ff       	call   80142e <strchr>
  801979:	83 c4 08             	add    $0x8,%esp
  80197c:	85 c0                	test   %eax,%eax
  80197e:	74 dc                	je     80195c <strsplit+0x8c>
			string++;
	}
  801980:	e9 6e ff ff ff       	jmp    8018f3 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801985:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801986:	8b 45 14             	mov    0x14(%ebp),%eax
  801989:	8b 00                	mov    (%eax),%eax
  80198b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801992:	8b 45 10             	mov    0x10(%ebp),%eax
  801995:	01 d0                	add    %edx,%eax
  801997:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80199d:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019a2:	c9                   	leave  
  8019a3:	c3                   	ret    

008019a4 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8019a4:	55                   	push   %ebp
  8019a5:	89 e5                	mov    %esp,%ebp
  8019a7:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8019aa:	83 ec 04             	sub    $0x4,%esp
  8019ad:	68 e4 2a 80 00       	push   $0x802ae4
  8019b2:	6a 15                	push   $0x15
  8019b4:	68 09 2b 80 00       	push   $0x802b09
  8019b9:	e8 a2 ed ff ff       	call   800760 <_panic>

008019be <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8019be:	55                   	push   %ebp
  8019bf:	89 e5                	mov    %esp,%ebp
  8019c1:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8019c4:	83 ec 04             	sub    $0x4,%esp
  8019c7:	68 18 2b 80 00       	push   $0x802b18
  8019cc:	6a 2e                	push   $0x2e
  8019ce:	68 09 2b 80 00       	push   $0x802b09
  8019d3:	e8 88 ed ff ff       	call   800760 <_panic>

008019d8 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8019d8:	55                   	push   %ebp
  8019d9:	89 e5                	mov    %esp,%ebp
  8019db:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8019de:	83 ec 04             	sub    $0x4,%esp
  8019e1:	68 3c 2b 80 00       	push   $0x802b3c
  8019e6:	6a 4c                	push   $0x4c
  8019e8:	68 09 2b 80 00       	push   $0x802b09
  8019ed:	e8 6e ed ff ff       	call   800760 <_panic>

008019f2 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8019f2:	55                   	push   %ebp
  8019f3:	89 e5                	mov    %esp,%ebp
  8019f5:	83 ec 18             	sub    $0x18,%esp
  8019f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8019fb:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8019fe:	83 ec 04             	sub    $0x4,%esp
  801a01:	68 3c 2b 80 00       	push   $0x802b3c
  801a06:	6a 57                	push   $0x57
  801a08:	68 09 2b 80 00       	push   $0x802b09
  801a0d:	e8 4e ed ff ff       	call   800760 <_panic>

00801a12 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801a12:	55                   	push   %ebp
  801a13:	89 e5                	mov    %esp,%ebp
  801a15:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a18:	83 ec 04             	sub    $0x4,%esp
  801a1b:	68 3c 2b 80 00       	push   $0x802b3c
  801a20:	6a 5d                	push   $0x5d
  801a22:	68 09 2b 80 00       	push   $0x802b09
  801a27:	e8 34 ed ff ff       	call   800760 <_panic>

00801a2c <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801a2c:	55                   	push   %ebp
  801a2d:	89 e5                	mov    %esp,%ebp
  801a2f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a32:	83 ec 04             	sub    $0x4,%esp
  801a35:	68 3c 2b 80 00       	push   $0x802b3c
  801a3a:	6a 63                	push   $0x63
  801a3c:	68 09 2b 80 00       	push   $0x802b09
  801a41:	e8 1a ed ff ff       	call   800760 <_panic>

00801a46 <expand>:
}

void expand(uint32 newSize)
{
  801a46:	55                   	push   %ebp
  801a47:	89 e5                	mov    %esp,%ebp
  801a49:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a4c:	83 ec 04             	sub    $0x4,%esp
  801a4f:	68 3c 2b 80 00       	push   $0x802b3c
  801a54:	6a 68                	push   $0x68
  801a56:	68 09 2b 80 00       	push   $0x802b09
  801a5b:	e8 00 ed ff ff       	call   800760 <_panic>

00801a60 <shrink>:
}
void shrink(uint32 newSize)
{
  801a60:	55                   	push   %ebp
  801a61:	89 e5                	mov    %esp,%ebp
  801a63:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a66:	83 ec 04             	sub    $0x4,%esp
  801a69:	68 3c 2b 80 00       	push   $0x802b3c
  801a6e:	6a 6c                	push   $0x6c
  801a70:	68 09 2b 80 00       	push   $0x802b09
  801a75:	e8 e6 ec ff ff       	call   800760 <_panic>

00801a7a <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801a7a:	55                   	push   %ebp
  801a7b:	89 e5                	mov    %esp,%ebp
  801a7d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801a80:	83 ec 04             	sub    $0x4,%esp
  801a83:	68 3c 2b 80 00       	push   $0x802b3c
  801a88:	6a 71                	push   $0x71
  801a8a:	68 09 2b 80 00       	push   $0x802b09
  801a8f:	e8 cc ec ff ff       	call   800760 <_panic>

00801a94 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801a94:	55                   	push   %ebp
  801a95:	89 e5                	mov    %esp,%ebp
  801a97:	57                   	push   %edi
  801a98:	56                   	push   %esi
  801a99:	53                   	push   %ebx
  801a9a:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801a9d:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aa3:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aa6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aa9:	8b 7d 18             	mov    0x18(%ebp),%edi
  801aac:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801aaf:	cd 30                	int    $0x30
  801ab1:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801ab4:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801ab7:	83 c4 10             	add    $0x10,%esp
  801aba:	5b                   	pop    %ebx
  801abb:	5e                   	pop    %esi
  801abc:	5f                   	pop    %edi
  801abd:	5d                   	pop    %ebp
  801abe:	c3                   	ret    

00801abf <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801abf:	55                   	push   %ebp
  801ac0:	89 e5                	mov    %esp,%ebp
  801ac2:	83 ec 04             	sub    $0x4,%esp
  801ac5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ac8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801acb:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801acf:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	52                   	push   %edx
  801ad7:	ff 75 0c             	pushl  0xc(%ebp)
  801ada:	50                   	push   %eax
  801adb:	6a 00                	push   $0x0
  801add:	e8 b2 ff ff ff       	call   801a94 <syscall>
  801ae2:	83 c4 18             	add    $0x18,%esp
}
  801ae5:	90                   	nop
  801ae6:	c9                   	leave  
  801ae7:	c3                   	ret    

00801ae8 <sys_cgetc>:

int
sys_cgetc(void)
{
  801ae8:	55                   	push   %ebp
  801ae9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 00                	push   $0x0
  801af3:	6a 00                	push   $0x0
  801af5:	6a 01                	push   $0x1
  801af7:	e8 98 ff ff ff       	call   801a94 <syscall>
  801afc:	83 c4 18             	add    $0x18,%esp
}
  801aff:	c9                   	leave  
  801b00:	c3                   	ret    

00801b01 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801b01:	55                   	push   %ebp
  801b02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801b04:	8b 45 08             	mov    0x8(%ebp),%eax
  801b07:	6a 00                	push   $0x0
  801b09:	6a 00                	push   $0x0
  801b0b:	6a 00                	push   $0x0
  801b0d:	6a 00                	push   $0x0
  801b0f:	50                   	push   %eax
  801b10:	6a 05                	push   $0x5
  801b12:	e8 7d ff ff ff       	call   801a94 <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
}
  801b1a:	c9                   	leave  
  801b1b:	c3                   	ret    

00801b1c <sys_getenvid>:

int32 sys_getenvid(void)
{
  801b1c:	55                   	push   %ebp
  801b1d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	6a 02                	push   $0x2
  801b2b:	e8 64 ff ff ff       	call   801a94 <syscall>
  801b30:	83 c4 18             	add    $0x18,%esp
}
  801b33:	c9                   	leave  
  801b34:	c3                   	ret    

00801b35 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801b35:	55                   	push   %ebp
  801b36:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801b38:	6a 00                	push   $0x0
  801b3a:	6a 00                	push   $0x0
  801b3c:	6a 00                	push   $0x0
  801b3e:	6a 00                	push   $0x0
  801b40:	6a 00                	push   $0x0
  801b42:	6a 03                	push   $0x3
  801b44:	e8 4b ff ff ff       	call   801a94 <syscall>
  801b49:	83 c4 18             	add    $0x18,%esp
}
  801b4c:	c9                   	leave  
  801b4d:	c3                   	ret    

00801b4e <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801b4e:	55                   	push   %ebp
  801b4f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801b51:	6a 00                	push   $0x0
  801b53:	6a 00                	push   $0x0
  801b55:	6a 00                	push   $0x0
  801b57:	6a 00                	push   $0x0
  801b59:	6a 00                	push   $0x0
  801b5b:	6a 04                	push   $0x4
  801b5d:	e8 32 ff ff ff       	call   801a94 <syscall>
  801b62:	83 c4 18             	add    $0x18,%esp
}
  801b65:	c9                   	leave  
  801b66:	c3                   	ret    

00801b67 <sys_env_exit>:


void sys_env_exit(void)
{
  801b67:	55                   	push   %ebp
  801b68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801b6a:	6a 00                	push   $0x0
  801b6c:	6a 00                	push   $0x0
  801b6e:	6a 00                	push   $0x0
  801b70:	6a 00                	push   $0x0
  801b72:	6a 00                	push   $0x0
  801b74:	6a 06                	push   $0x6
  801b76:	e8 19 ff ff ff       	call   801a94 <syscall>
  801b7b:	83 c4 18             	add    $0x18,%esp
}
  801b7e:	90                   	nop
  801b7f:	c9                   	leave  
  801b80:	c3                   	ret    

00801b81 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801b81:	55                   	push   %ebp
  801b82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801b84:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b87:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8a:	6a 00                	push   $0x0
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	52                   	push   %edx
  801b91:	50                   	push   %eax
  801b92:	6a 07                	push   $0x7
  801b94:	e8 fb fe ff ff       	call   801a94 <syscall>
  801b99:	83 c4 18             	add    $0x18,%esp
}
  801b9c:	c9                   	leave  
  801b9d:	c3                   	ret    

00801b9e <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801b9e:	55                   	push   %ebp
  801b9f:	89 e5                	mov    %esp,%ebp
  801ba1:	56                   	push   %esi
  801ba2:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801ba3:	8b 75 18             	mov    0x18(%ebp),%esi
  801ba6:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801ba9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801bac:	8b 55 0c             	mov    0xc(%ebp),%edx
  801baf:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb2:	56                   	push   %esi
  801bb3:	53                   	push   %ebx
  801bb4:	51                   	push   %ecx
  801bb5:	52                   	push   %edx
  801bb6:	50                   	push   %eax
  801bb7:	6a 08                	push   $0x8
  801bb9:	e8 d6 fe ff ff       	call   801a94 <syscall>
  801bbe:	83 c4 18             	add    $0x18,%esp
}
  801bc1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801bc4:	5b                   	pop    %ebx
  801bc5:	5e                   	pop    %esi
  801bc6:	5d                   	pop    %ebp
  801bc7:	c3                   	ret    

00801bc8 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801bc8:	55                   	push   %ebp
  801bc9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801bcb:	8b 55 0c             	mov    0xc(%ebp),%edx
  801bce:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	52                   	push   %edx
  801bd8:	50                   	push   %eax
  801bd9:	6a 09                	push   $0x9
  801bdb:	e8 b4 fe ff ff       	call   801a94 <syscall>
  801be0:	83 c4 18             	add    $0x18,%esp
}
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	ff 75 0c             	pushl  0xc(%ebp)
  801bf1:	ff 75 08             	pushl  0x8(%ebp)
  801bf4:	6a 0a                	push   $0xa
  801bf6:	e8 99 fe ff ff       	call   801a94 <syscall>
  801bfb:	83 c4 18             	add    $0x18,%esp
}
  801bfe:	c9                   	leave  
  801bff:	c3                   	ret    

00801c00 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801c00:	55                   	push   %ebp
  801c01:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801c03:	6a 00                	push   $0x0
  801c05:	6a 00                	push   $0x0
  801c07:	6a 00                	push   $0x0
  801c09:	6a 00                	push   $0x0
  801c0b:	6a 00                	push   $0x0
  801c0d:	6a 0b                	push   $0xb
  801c0f:	e8 80 fe ff ff       	call   801a94 <syscall>
  801c14:	83 c4 18             	add    $0x18,%esp
}
  801c17:	c9                   	leave  
  801c18:	c3                   	ret    

00801c19 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801c19:	55                   	push   %ebp
  801c1a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801c1c:	6a 00                	push   $0x0
  801c1e:	6a 00                	push   $0x0
  801c20:	6a 00                	push   $0x0
  801c22:	6a 00                	push   $0x0
  801c24:	6a 00                	push   $0x0
  801c26:	6a 0c                	push   $0xc
  801c28:	e8 67 fe ff ff       	call   801a94 <syscall>
  801c2d:	83 c4 18             	add    $0x18,%esp
}
  801c30:	c9                   	leave  
  801c31:	c3                   	ret    

00801c32 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801c32:	55                   	push   %ebp
  801c33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801c35:	6a 00                	push   $0x0
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	6a 00                	push   $0x0
  801c3d:	6a 00                	push   $0x0
  801c3f:	6a 0d                	push   $0xd
  801c41:	e8 4e fe ff ff       	call   801a94 <syscall>
  801c46:	83 c4 18             	add    $0x18,%esp
}
  801c49:	c9                   	leave  
  801c4a:	c3                   	ret    

00801c4b <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801c4b:	55                   	push   %ebp
  801c4c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	ff 75 0c             	pushl  0xc(%ebp)
  801c57:	ff 75 08             	pushl  0x8(%ebp)
  801c5a:	6a 11                	push   $0x11
  801c5c:	e8 33 fe ff ff       	call   801a94 <syscall>
  801c61:	83 c4 18             	add    $0x18,%esp
	return;
  801c64:	90                   	nop
}
  801c65:	c9                   	leave  
  801c66:	c3                   	ret    

00801c67 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801c67:	55                   	push   %ebp
  801c68:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	ff 75 0c             	pushl  0xc(%ebp)
  801c73:	ff 75 08             	pushl  0x8(%ebp)
  801c76:	6a 12                	push   $0x12
  801c78:	e8 17 fe ff ff       	call   801a94 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
	return ;
  801c80:	90                   	nop
}
  801c81:	c9                   	leave  
  801c82:	c3                   	ret    

00801c83 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801c83:	55                   	push   %ebp
  801c84:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	6a 0e                	push   $0xe
  801c92:	e8 fd fd ff ff       	call   801a94 <syscall>
  801c97:	83 c4 18             	add    $0x18,%esp
}
  801c9a:	c9                   	leave  
  801c9b:	c3                   	ret    

00801c9c <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801c9c:	55                   	push   %ebp
  801c9d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	ff 75 08             	pushl  0x8(%ebp)
  801caa:	6a 0f                	push   $0xf
  801cac:	e8 e3 fd ff ff       	call   801a94 <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
}
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 10                	push   $0x10
  801cc5:	e8 ca fd ff ff       	call   801a94 <syscall>
  801cca:	83 c4 18             	add    $0x18,%esp
}
  801ccd:	90                   	nop
  801cce:	c9                   	leave  
  801ccf:	c3                   	ret    

00801cd0 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801cd0:	55                   	push   %ebp
  801cd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 14                	push   $0x14
  801cdf:	e8 b0 fd ff ff       	call   801a94 <syscall>
  801ce4:	83 c4 18             	add    $0x18,%esp
}
  801ce7:	90                   	nop
  801ce8:	c9                   	leave  
  801ce9:	c3                   	ret    

00801cea <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801cea:	55                   	push   %ebp
  801ceb:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 00                	push   $0x0
  801cf7:	6a 15                	push   $0x15
  801cf9:	e8 96 fd ff ff       	call   801a94 <syscall>
  801cfe:	83 c4 18             	add    $0x18,%esp
}
  801d01:	90                   	nop
  801d02:	c9                   	leave  
  801d03:	c3                   	ret    

00801d04 <sys_cputc>:


void
sys_cputc(const char c)
{
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
  801d07:	83 ec 04             	sub    $0x4,%esp
  801d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801d10:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801d14:	6a 00                	push   $0x0
  801d16:	6a 00                	push   $0x0
  801d18:	6a 00                	push   $0x0
  801d1a:	6a 00                	push   $0x0
  801d1c:	50                   	push   %eax
  801d1d:	6a 16                	push   $0x16
  801d1f:	e8 70 fd ff ff       	call   801a94 <syscall>
  801d24:	83 c4 18             	add    $0x18,%esp
}
  801d27:	90                   	nop
  801d28:	c9                   	leave  
  801d29:	c3                   	ret    

00801d2a <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801d2a:	55                   	push   %ebp
  801d2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801d2d:	6a 00                	push   $0x0
  801d2f:	6a 00                	push   $0x0
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 17                	push   $0x17
  801d39:	e8 56 fd ff ff       	call   801a94 <syscall>
  801d3e:	83 c4 18             	add    $0x18,%esp
}
  801d41:	90                   	nop
  801d42:	c9                   	leave  
  801d43:	c3                   	ret    

00801d44 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801d44:	55                   	push   %ebp
  801d45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801d47:	8b 45 08             	mov    0x8(%ebp),%eax
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	ff 75 0c             	pushl  0xc(%ebp)
  801d53:	50                   	push   %eax
  801d54:	6a 18                	push   $0x18
  801d56:	e8 39 fd ff ff       	call   801a94 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
}
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d63:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d66:	8b 45 08             	mov    0x8(%ebp),%eax
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	52                   	push   %edx
  801d70:	50                   	push   %eax
  801d71:	6a 1b                	push   $0x1b
  801d73:	e8 1c fd ff ff       	call   801a94 <syscall>
  801d78:	83 c4 18             	add    $0x18,%esp
}
  801d7b:	c9                   	leave  
  801d7c:	c3                   	ret    

00801d7d <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d7d:	55                   	push   %ebp
  801d7e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d80:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d83:	8b 45 08             	mov    0x8(%ebp),%eax
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 00                	push   $0x0
  801d8c:	52                   	push   %edx
  801d8d:	50                   	push   %eax
  801d8e:	6a 19                	push   $0x19
  801d90:	e8 ff fc ff ff       	call   801a94 <syscall>
  801d95:	83 c4 18             	add    $0x18,%esp
}
  801d98:	90                   	nop
  801d99:	c9                   	leave  
  801d9a:	c3                   	ret    

00801d9b <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801d9b:	55                   	push   %ebp
  801d9c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801d9e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801da1:	8b 45 08             	mov    0x8(%ebp),%eax
  801da4:	6a 00                	push   $0x0
  801da6:	6a 00                	push   $0x0
  801da8:	6a 00                	push   $0x0
  801daa:	52                   	push   %edx
  801dab:	50                   	push   %eax
  801dac:	6a 1a                	push   $0x1a
  801dae:	e8 e1 fc ff ff       	call   801a94 <syscall>
  801db3:	83 c4 18             	add    $0x18,%esp
}
  801db6:	90                   	nop
  801db7:	c9                   	leave  
  801db8:	c3                   	ret    

00801db9 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801db9:	55                   	push   %ebp
  801dba:	89 e5                	mov    %esp,%ebp
  801dbc:	83 ec 04             	sub    $0x4,%esp
  801dbf:	8b 45 10             	mov    0x10(%ebp),%eax
  801dc2:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801dc5:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801dc8:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  801dcf:	6a 00                	push   $0x0
  801dd1:	51                   	push   %ecx
  801dd2:	52                   	push   %edx
  801dd3:	ff 75 0c             	pushl  0xc(%ebp)
  801dd6:	50                   	push   %eax
  801dd7:	6a 1c                	push   $0x1c
  801dd9:	e8 b6 fc ff ff       	call   801a94 <syscall>
  801dde:	83 c4 18             	add    $0x18,%esp
}
  801de1:	c9                   	leave  
  801de2:	c3                   	ret    

00801de3 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801de3:	55                   	push   %ebp
  801de4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801de6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de9:	8b 45 08             	mov    0x8(%ebp),%eax
  801dec:	6a 00                	push   $0x0
  801dee:	6a 00                	push   $0x0
  801df0:	6a 00                	push   $0x0
  801df2:	52                   	push   %edx
  801df3:	50                   	push   %eax
  801df4:	6a 1d                	push   $0x1d
  801df6:	e8 99 fc ff ff       	call   801a94 <syscall>
  801dfb:	83 c4 18             	add    $0x18,%esp
}
  801dfe:	c9                   	leave  
  801dff:	c3                   	ret    

00801e00 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801e00:	55                   	push   %ebp
  801e01:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801e03:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e06:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e09:	8b 45 08             	mov    0x8(%ebp),%eax
  801e0c:	6a 00                	push   $0x0
  801e0e:	6a 00                	push   $0x0
  801e10:	51                   	push   %ecx
  801e11:	52                   	push   %edx
  801e12:	50                   	push   %eax
  801e13:	6a 1e                	push   $0x1e
  801e15:	e8 7a fc ff ff       	call   801a94 <syscall>
  801e1a:	83 c4 18             	add    $0x18,%esp
}
  801e1d:	c9                   	leave  
  801e1e:	c3                   	ret    

00801e1f <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801e1f:	55                   	push   %ebp
  801e20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801e22:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e25:	8b 45 08             	mov    0x8(%ebp),%eax
  801e28:	6a 00                	push   $0x0
  801e2a:	6a 00                	push   $0x0
  801e2c:	6a 00                	push   $0x0
  801e2e:	52                   	push   %edx
  801e2f:	50                   	push   %eax
  801e30:	6a 1f                	push   $0x1f
  801e32:	e8 5d fc ff ff       	call   801a94 <syscall>
  801e37:	83 c4 18             	add    $0x18,%esp
}
  801e3a:	c9                   	leave  
  801e3b:	c3                   	ret    

00801e3c <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801e3c:	55                   	push   %ebp
  801e3d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801e3f:	6a 00                	push   $0x0
  801e41:	6a 00                	push   $0x0
  801e43:	6a 00                	push   $0x0
  801e45:	6a 00                	push   $0x0
  801e47:	6a 00                	push   $0x0
  801e49:	6a 20                	push   $0x20
  801e4b:	e8 44 fc ff ff       	call   801a94 <syscall>
  801e50:	83 c4 18             	add    $0x18,%esp
}
  801e53:	c9                   	leave  
  801e54:	c3                   	ret    

00801e55 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801e55:	55                   	push   %ebp
  801e56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801e58:	8b 45 08             	mov    0x8(%ebp),%eax
  801e5b:	6a 00                	push   $0x0
  801e5d:	ff 75 14             	pushl  0x14(%ebp)
  801e60:	ff 75 10             	pushl  0x10(%ebp)
  801e63:	ff 75 0c             	pushl  0xc(%ebp)
  801e66:	50                   	push   %eax
  801e67:	6a 21                	push   $0x21
  801e69:	e8 26 fc ff ff       	call   801a94 <syscall>
  801e6e:	83 c4 18             	add    $0x18,%esp
}
  801e71:	c9                   	leave  
  801e72:	c3                   	ret    

00801e73 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801e73:	55                   	push   %ebp
  801e74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801e76:	8b 45 08             	mov    0x8(%ebp),%eax
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 00                	push   $0x0
  801e81:	50                   	push   %eax
  801e82:	6a 22                	push   $0x22
  801e84:	e8 0b fc ff ff       	call   801a94 <syscall>
  801e89:	83 c4 18             	add    $0x18,%esp
}
  801e8c:	90                   	nop
  801e8d:	c9                   	leave  
  801e8e:	c3                   	ret    

00801e8f <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801e8f:	55                   	push   %ebp
  801e90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801e92:	8b 45 08             	mov    0x8(%ebp),%eax
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	50                   	push   %eax
  801e9e:	6a 23                	push   $0x23
  801ea0:	e8 ef fb ff ff       	call   801a94 <syscall>
  801ea5:	83 c4 18             	add    $0x18,%esp
}
  801ea8:	90                   	nop
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
  801eae:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801eb1:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801eb4:	8d 50 04             	lea    0x4(%eax),%edx
  801eb7:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801eba:	6a 00                	push   $0x0
  801ebc:	6a 00                	push   $0x0
  801ebe:	6a 00                	push   $0x0
  801ec0:	52                   	push   %edx
  801ec1:	50                   	push   %eax
  801ec2:	6a 24                	push   $0x24
  801ec4:	e8 cb fb ff ff       	call   801a94 <syscall>
  801ec9:	83 c4 18             	add    $0x18,%esp
	return result;
  801ecc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801ecf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801ed2:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ed5:	89 01                	mov    %eax,(%ecx)
  801ed7:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801eda:	8b 45 08             	mov    0x8(%ebp),%eax
  801edd:	c9                   	leave  
  801ede:	c2 04 00             	ret    $0x4

00801ee1 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801ee1:	55                   	push   %ebp
  801ee2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801ee4:	6a 00                	push   $0x0
  801ee6:	6a 00                	push   $0x0
  801ee8:	ff 75 10             	pushl  0x10(%ebp)
  801eeb:	ff 75 0c             	pushl  0xc(%ebp)
  801eee:	ff 75 08             	pushl  0x8(%ebp)
  801ef1:	6a 13                	push   $0x13
  801ef3:	e8 9c fb ff ff       	call   801a94 <syscall>
  801ef8:	83 c4 18             	add    $0x18,%esp
	return ;
  801efb:	90                   	nop
}
  801efc:	c9                   	leave  
  801efd:	c3                   	ret    

00801efe <sys_rcr2>:
uint32 sys_rcr2()
{
  801efe:	55                   	push   %ebp
  801eff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 00                	push   $0x0
  801f07:	6a 00                	push   $0x0
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 25                	push   $0x25
  801f0d:	e8 82 fb ff ff       	call   801a94 <syscall>
  801f12:	83 c4 18             	add    $0x18,%esp
}
  801f15:	c9                   	leave  
  801f16:	c3                   	ret    

00801f17 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801f17:	55                   	push   %ebp
  801f18:	89 e5                	mov    %esp,%ebp
  801f1a:	83 ec 04             	sub    $0x4,%esp
  801f1d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f20:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801f23:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	6a 00                	push   $0x0
  801f2d:	6a 00                	push   $0x0
  801f2f:	50                   	push   %eax
  801f30:	6a 26                	push   $0x26
  801f32:	e8 5d fb ff ff       	call   801a94 <syscall>
  801f37:	83 c4 18             	add    $0x18,%esp
	return ;
  801f3a:	90                   	nop
}
  801f3b:	c9                   	leave  
  801f3c:	c3                   	ret    

00801f3d <rsttst>:
void rsttst()
{
  801f3d:	55                   	push   %ebp
  801f3e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801f40:	6a 00                	push   $0x0
  801f42:	6a 00                	push   $0x0
  801f44:	6a 00                	push   $0x0
  801f46:	6a 00                	push   $0x0
  801f48:	6a 00                	push   $0x0
  801f4a:	6a 28                	push   $0x28
  801f4c:	e8 43 fb ff ff       	call   801a94 <syscall>
  801f51:	83 c4 18             	add    $0x18,%esp
	return ;
  801f54:	90                   	nop
}
  801f55:	c9                   	leave  
  801f56:	c3                   	ret    

00801f57 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801f57:	55                   	push   %ebp
  801f58:	89 e5                	mov    %esp,%ebp
  801f5a:	83 ec 04             	sub    $0x4,%esp
  801f5d:	8b 45 14             	mov    0x14(%ebp),%eax
  801f60:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801f63:	8b 55 18             	mov    0x18(%ebp),%edx
  801f66:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f6a:	52                   	push   %edx
  801f6b:	50                   	push   %eax
  801f6c:	ff 75 10             	pushl  0x10(%ebp)
  801f6f:	ff 75 0c             	pushl  0xc(%ebp)
  801f72:	ff 75 08             	pushl  0x8(%ebp)
  801f75:	6a 27                	push   $0x27
  801f77:	e8 18 fb ff ff       	call   801a94 <syscall>
  801f7c:	83 c4 18             	add    $0x18,%esp
	return ;
  801f7f:	90                   	nop
}
  801f80:	c9                   	leave  
  801f81:	c3                   	ret    

00801f82 <chktst>:
void chktst(uint32 n)
{
  801f82:	55                   	push   %ebp
  801f83:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801f85:	6a 00                	push   $0x0
  801f87:	6a 00                	push   $0x0
  801f89:	6a 00                	push   $0x0
  801f8b:	6a 00                	push   $0x0
  801f8d:	ff 75 08             	pushl  0x8(%ebp)
  801f90:	6a 29                	push   $0x29
  801f92:	e8 fd fa ff ff       	call   801a94 <syscall>
  801f97:	83 c4 18             	add    $0x18,%esp
	return ;
  801f9a:	90                   	nop
}
  801f9b:	c9                   	leave  
  801f9c:	c3                   	ret    

00801f9d <inctst>:

void inctst()
{
  801f9d:	55                   	push   %ebp
  801f9e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801fa0:	6a 00                	push   $0x0
  801fa2:	6a 00                	push   $0x0
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 2a                	push   $0x2a
  801fac:	e8 e3 fa ff ff       	call   801a94 <syscall>
  801fb1:	83 c4 18             	add    $0x18,%esp
	return ;
  801fb4:	90                   	nop
}
  801fb5:	c9                   	leave  
  801fb6:	c3                   	ret    

00801fb7 <gettst>:
uint32 gettst()
{
  801fb7:	55                   	push   %ebp
  801fb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 2b                	push   $0x2b
  801fc6:	e8 c9 fa ff ff       	call   801a94 <syscall>
  801fcb:	83 c4 18             	add    $0x18,%esp
}
  801fce:	c9                   	leave  
  801fcf:	c3                   	ret    

00801fd0 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801fd0:	55                   	push   %ebp
  801fd1:	89 e5                	mov    %esp,%ebp
  801fd3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801fd6:	6a 00                	push   $0x0
  801fd8:	6a 00                	push   $0x0
  801fda:	6a 00                	push   $0x0
  801fdc:	6a 00                	push   $0x0
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 2c                	push   $0x2c
  801fe2:	e8 ad fa ff ff       	call   801a94 <syscall>
  801fe7:	83 c4 18             	add    $0x18,%esp
  801fea:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801fed:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801ff1:	75 07                	jne    801ffa <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801ff3:	b8 01 00 00 00       	mov    $0x1,%eax
  801ff8:	eb 05                	jmp    801fff <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ffa:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801fff:	c9                   	leave  
  802000:	c3                   	ret    

00802001 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802001:	55                   	push   %ebp
  802002:	89 e5                	mov    %esp,%ebp
  802004:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802007:	6a 00                	push   $0x0
  802009:	6a 00                	push   $0x0
  80200b:	6a 00                	push   $0x0
  80200d:	6a 00                	push   $0x0
  80200f:	6a 00                	push   $0x0
  802011:	6a 2c                	push   $0x2c
  802013:	e8 7c fa ff ff       	call   801a94 <syscall>
  802018:	83 c4 18             	add    $0x18,%esp
  80201b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80201e:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802022:	75 07                	jne    80202b <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802024:	b8 01 00 00 00       	mov    $0x1,%eax
  802029:	eb 05                	jmp    802030 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80202b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802030:	c9                   	leave  
  802031:	c3                   	ret    

00802032 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802032:	55                   	push   %ebp
  802033:	89 e5                	mov    %esp,%ebp
  802035:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802038:	6a 00                	push   $0x0
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	6a 00                	push   $0x0
  802042:	6a 2c                	push   $0x2c
  802044:	e8 4b fa ff ff       	call   801a94 <syscall>
  802049:	83 c4 18             	add    $0x18,%esp
  80204c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80204f:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802053:	75 07                	jne    80205c <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802055:	b8 01 00 00 00       	mov    $0x1,%eax
  80205a:	eb 05                	jmp    802061 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80205c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802061:	c9                   	leave  
  802062:	c3                   	ret    

00802063 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802063:	55                   	push   %ebp
  802064:	89 e5                	mov    %esp,%ebp
  802066:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802069:	6a 00                	push   $0x0
  80206b:	6a 00                	push   $0x0
  80206d:	6a 00                	push   $0x0
  80206f:	6a 00                	push   $0x0
  802071:	6a 00                	push   $0x0
  802073:	6a 2c                	push   $0x2c
  802075:	e8 1a fa ff ff       	call   801a94 <syscall>
  80207a:	83 c4 18             	add    $0x18,%esp
  80207d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802080:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802084:	75 07                	jne    80208d <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802086:	b8 01 00 00 00       	mov    $0x1,%eax
  80208b:	eb 05                	jmp    802092 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80208d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802092:	c9                   	leave  
  802093:	c3                   	ret    

00802094 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802094:	55                   	push   %ebp
  802095:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802097:	6a 00                	push   $0x0
  802099:	6a 00                	push   $0x0
  80209b:	6a 00                	push   $0x0
  80209d:	6a 00                	push   $0x0
  80209f:	ff 75 08             	pushl  0x8(%ebp)
  8020a2:	6a 2d                	push   $0x2d
  8020a4:	e8 eb f9 ff ff       	call   801a94 <syscall>
  8020a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ac:	90                   	nop
}
  8020ad:	c9                   	leave  
  8020ae:	c3                   	ret    

008020af <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8020af:	55                   	push   %ebp
  8020b0:	89 e5                	mov    %esp,%ebp
  8020b2:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8020b3:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8020b6:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8020bf:	6a 00                	push   $0x0
  8020c1:	53                   	push   %ebx
  8020c2:	51                   	push   %ecx
  8020c3:	52                   	push   %edx
  8020c4:	50                   	push   %eax
  8020c5:	6a 2e                	push   $0x2e
  8020c7:	e8 c8 f9 ff ff       	call   801a94 <syscall>
  8020cc:	83 c4 18             	add    $0x18,%esp
}
  8020cf:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8020d2:	c9                   	leave  
  8020d3:	c3                   	ret    

008020d4 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8020d4:	55                   	push   %ebp
  8020d5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8020d7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020da:	8b 45 08             	mov    0x8(%ebp),%eax
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	52                   	push   %edx
  8020e4:	50                   	push   %eax
  8020e5:	6a 2f                	push   $0x2f
  8020e7:	e8 a8 f9 ff ff       	call   801a94 <syscall>
  8020ec:	83 c4 18             	add    $0x18,%esp
}
  8020ef:	c9                   	leave  
  8020f0:	c3                   	ret    

008020f1 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8020f1:	55                   	push   %ebp
  8020f2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8020f4:	6a 00                	push   $0x0
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	ff 75 0c             	pushl  0xc(%ebp)
  8020fd:	ff 75 08             	pushl  0x8(%ebp)
  802100:	6a 30                	push   $0x30
  802102:	e8 8d f9 ff ff       	call   801a94 <syscall>
  802107:	83 c4 18             	add    $0x18,%esp
	return ;
  80210a:	90                   	nop
}
  80210b:	c9                   	leave  
  80210c:	c3                   	ret    
  80210d:	66 90                	xchg   %ax,%ax
  80210f:	90                   	nop

00802110 <__udivdi3>:
  802110:	55                   	push   %ebp
  802111:	57                   	push   %edi
  802112:	56                   	push   %esi
  802113:	53                   	push   %ebx
  802114:	83 ec 1c             	sub    $0x1c,%esp
  802117:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80211b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80211f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802123:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802127:	89 ca                	mov    %ecx,%edx
  802129:	89 f8                	mov    %edi,%eax
  80212b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80212f:	85 f6                	test   %esi,%esi
  802131:	75 2d                	jne    802160 <__udivdi3+0x50>
  802133:	39 cf                	cmp    %ecx,%edi
  802135:	77 65                	ja     80219c <__udivdi3+0x8c>
  802137:	89 fd                	mov    %edi,%ebp
  802139:	85 ff                	test   %edi,%edi
  80213b:	75 0b                	jne    802148 <__udivdi3+0x38>
  80213d:	b8 01 00 00 00       	mov    $0x1,%eax
  802142:	31 d2                	xor    %edx,%edx
  802144:	f7 f7                	div    %edi
  802146:	89 c5                	mov    %eax,%ebp
  802148:	31 d2                	xor    %edx,%edx
  80214a:	89 c8                	mov    %ecx,%eax
  80214c:	f7 f5                	div    %ebp
  80214e:	89 c1                	mov    %eax,%ecx
  802150:	89 d8                	mov    %ebx,%eax
  802152:	f7 f5                	div    %ebp
  802154:	89 cf                	mov    %ecx,%edi
  802156:	89 fa                	mov    %edi,%edx
  802158:	83 c4 1c             	add    $0x1c,%esp
  80215b:	5b                   	pop    %ebx
  80215c:	5e                   	pop    %esi
  80215d:	5f                   	pop    %edi
  80215e:	5d                   	pop    %ebp
  80215f:	c3                   	ret    
  802160:	39 ce                	cmp    %ecx,%esi
  802162:	77 28                	ja     80218c <__udivdi3+0x7c>
  802164:	0f bd fe             	bsr    %esi,%edi
  802167:	83 f7 1f             	xor    $0x1f,%edi
  80216a:	75 40                	jne    8021ac <__udivdi3+0x9c>
  80216c:	39 ce                	cmp    %ecx,%esi
  80216e:	72 0a                	jb     80217a <__udivdi3+0x6a>
  802170:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802174:	0f 87 9e 00 00 00    	ja     802218 <__udivdi3+0x108>
  80217a:	b8 01 00 00 00       	mov    $0x1,%eax
  80217f:	89 fa                	mov    %edi,%edx
  802181:	83 c4 1c             	add    $0x1c,%esp
  802184:	5b                   	pop    %ebx
  802185:	5e                   	pop    %esi
  802186:	5f                   	pop    %edi
  802187:	5d                   	pop    %ebp
  802188:	c3                   	ret    
  802189:	8d 76 00             	lea    0x0(%esi),%esi
  80218c:	31 ff                	xor    %edi,%edi
  80218e:	31 c0                	xor    %eax,%eax
  802190:	89 fa                	mov    %edi,%edx
  802192:	83 c4 1c             	add    $0x1c,%esp
  802195:	5b                   	pop    %ebx
  802196:	5e                   	pop    %esi
  802197:	5f                   	pop    %edi
  802198:	5d                   	pop    %ebp
  802199:	c3                   	ret    
  80219a:	66 90                	xchg   %ax,%ax
  80219c:	89 d8                	mov    %ebx,%eax
  80219e:	f7 f7                	div    %edi
  8021a0:	31 ff                	xor    %edi,%edi
  8021a2:	89 fa                	mov    %edi,%edx
  8021a4:	83 c4 1c             	add    $0x1c,%esp
  8021a7:	5b                   	pop    %ebx
  8021a8:	5e                   	pop    %esi
  8021a9:	5f                   	pop    %edi
  8021aa:	5d                   	pop    %ebp
  8021ab:	c3                   	ret    
  8021ac:	bd 20 00 00 00       	mov    $0x20,%ebp
  8021b1:	89 eb                	mov    %ebp,%ebx
  8021b3:	29 fb                	sub    %edi,%ebx
  8021b5:	89 f9                	mov    %edi,%ecx
  8021b7:	d3 e6                	shl    %cl,%esi
  8021b9:	89 c5                	mov    %eax,%ebp
  8021bb:	88 d9                	mov    %bl,%cl
  8021bd:	d3 ed                	shr    %cl,%ebp
  8021bf:	89 e9                	mov    %ebp,%ecx
  8021c1:	09 f1                	or     %esi,%ecx
  8021c3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8021c7:	89 f9                	mov    %edi,%ecx
  8021c9:	d3 e0                	shl    %cl,%eax
  8021cb:	89 c5                	mov    %eax,%ebp
  8021cd:	89 d6                	mov    %edx,%esi
  8021cf:	88 d9                	mov    %bl,%cl
  8021d1:	d3 ee                	shr    %cl,%esi
  8021d3:	89 f9                	mov    %edi,%ecx
  8021d5:	d3 e2                	shl    %cl,%edx
  8021d7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8021db:	88 d9                	mov    %bl,%cl
  8021dd:	d3 e8                	shr    %cl,%eax
  8021df:	09 c2                	or     %eax,%edx
  8021e1:	89 d0                	mov    %edx,%eax
  8021e3:	89 f2                	mov    %esi,%edx
  8021e5:	f7 74 24 0c          	divl   0xc(%esp)
  8021e9:	89 d6                	mov    %edx,%esi
  8021eb:	89 c3                	mov    %eax,%ebx
  8021ed:	f7 e5                	mul    %ebp
  8021ef:	39 d6                	cmp    %edx,%esi
  8021f1:	72 19                	jb     80220c <__udivdi3+0xfc>
  8021f3:	74 0b                	je     802200 <__udivdi3+0xf0>
  8021f5:	89 d8                	mov    %ebx,%eax
  8021f7:	31 ff                	xor    %edi,%edi
  8021f9:	e9 58 ff ff ff       	jmp    802156 <__udivdi3+0x46>
  8021fe:	66 90                	xchg   %ax,%ax
  802200:	8b 54 24 08          	mov    0x8(%esp),%edx
  802204:	89 f9                	mov    %edi,%ecx
  802206:	d3 e2                	shl    %cl,%edx
  802208:	39 c2                	cmp    %eax,%edx
  80220a:	73 e9                	jae    8021f5 <__udivdi3+0xe5>
  80220c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80220f:	31 ff                	xor    %edi,%edi
  802211:	e9 40 ff ff ff       	jmp    802156 <__udivdi3+0x46>
  802216:	66 90                	xchg   %ax,%ax
  802218:	31 c0                	xor    %eax,%eax
  80221a:	e9 37 ff ff ff       	jmp    802156 <__udivdi3+0x46>
  80221f:	90                   	nop

00802220 <__umoddi3>:
  802220:	55                   	push   %ebp
  802221:	57                   	push   %edi
  802222:	56                   	push   %esi
  802223:	53                   	push   %ebx
  802224:	83 ec 1c             	sub    $0x1c,%esp
  802227:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80222b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80222f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802233:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802237:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80223b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80223f:	89 f3                	mov    %esi,%ebx
  802241:	89 fa                	mov    %edi,%edx
  802243:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802247:	89 34 24             	mov    %esi,(%esp)
  80224a:	85 c0                	test   %eax,%eax
  80224c:	75 1a                	jne    802268 <__umoddi3+0x48>
  80224e:	39 f7                	cmp    %esi,%edi
  802250:	0f 86 a2 00 00 00    	jbe    8022f8 <__umoddi3+0xd8>
  802256:	89 c8                	mov    %ecx,%eax
  802258:	89 f2                	mov    %esi,%edx
  80225a:	f7 f7                	div    %edi
  80225c:	89 d0                	mov    %edx,%eax
  80225e:	31 d2                	xor    %edx,%edx
  802260:	83 c4 1c             	add    $0x1c,%esp
  802263:	5b                   	pop    %ebx
  802264:	5e                   	pop    %esi
  802265:	5f                   	pop    %edi
  802266:	5d                   	pop    %ebp
  802267:	c3                   	ret    
  802268:	39 f0                	cmp    %esi,%eax
  80226a:	0f 87 ac 00 00 00    	ja     80231c <__umoddi3+0xfc>
  802270:	0f bd e8             	bsr    %eax,%ebp
  802273:	83 f5 1f             	xor    $0x1f,%ebp
  802276:	0f 84 ac 00 00 00    	je     802328 <__umoddi3+0x108>
  80227c:	bf 20 00 00 00       	mov    $0x20,%edi
  802281:	29 ef                	sub    %ebp,%edi
  802283:	89 fe                	mov    %edi,%esi
  802285:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802289:	89 e9                	mov    %ebp,%ecx
  80228b:	d3 e0                	shl    %cl,%eax
  80228d:	89 d7                	mov    %edx,%edi
  80228f:	89 f1                	mov    %esi,%ecx
  802291:	d3 ef                	shr    %cl,%edi
  802293:	09 c7                	or     %eax,%edi
  802295:	89 e9                	mov    %ebp,%ecx
  802297:	d3 e2                	shl    %cl,%edx
  802299:	89 14 24             	mov    %edx,(%esp)
  80229c:	89 d8                	mov    %ebx,%eax
  80229e:	d3 e0                	shl    %cl,%eax
  8022a0:	89 c2                	mov    %eax,%edx
  8022a2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022a6:	d3 e0                	shl    %cl,%eax
  8022a8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8022ac:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022b0:	89 f1                	mov    %esi,%ecx
  8022b2:	d3 e8                	shr    %cl,%eax
  8022b4:	09 d0                	or     %edx,%eax
  8022b6:	d3 eb                	shr    %cl,%ebx
  8022b8:	89 da                	mov    %ebx,%edx
  8022ba:	f7 f7                	div    %edi
  8022bc:	89 d3                	mov    %edx,%ebx
  8022be:	f7 24 24             	mull   (%esp)
  8022c1:	89 c6                	mov    %eax,%esi
  8022c3:	89 d1                	mov    %edx,%ecx
  8022c5:	39 d3                	cmp    %edx,%ebx
  8022c7:	0f 82 87 00 00 00    	jb     802354 <__umoddi3+0x134>
  8022cd:	0f 84 91 00 00 00    	je     802364 <__umoddi3+0x144>
  8022d3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8022d7:	29 f2                	sub    %esi,%edx
  8022d9:	19 cb                	sbb    %ecx,%ebx
  8022db:	89 d8                	mov    %ebx,%eax
  8022dd:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8022e1:	d3 e0                	shl    %cl,%eax
  8022e3:	89 e9                	mov    %ebp,%ecx
  8022e5:	d3 ea                	shr    %cl,%edx
  8022e7:	09 d0                	or     %edx,%eax
  8022e9:	89 e9                	mov    %ebp,%ecx
  8022eb:	d3 eb                	shr    %cl,%ebx
  8022ed:	89 da                	mov    %ebx,%edx
  8022ef:	83 c4 1c             	add    $0x1c,%esp
  8022f2:	5b                   	pop    %ebx
  8022f3:	5e                   	pop    %esi
  8022f4:	5f                   	pop    %edi
  8022f5:	5d                   	pop    %ebp
  8022f6:	c3                   	ret    
  8022f7:	90                   	nop
  8022f8:	89 fd                	mov    %edi,%ebp
  8022fa:	85 ff                	test   %edi,%edi
  8022fc:	75 0b                	jne    802309 <__umoddi3+0xe9>
  8022fe:	b8 01 00 00 00       	mov    $0x1,%eax
  802303:	31 d2                	xor    %edx,%edx
  802305:	f7 f7                	div    %edi
  802307:	89 c5                	mov    %eax,%ebp
  802309:	89 f0                	mov    %esi,%eax
  80230b:	31 d2                	xor    %edx,%edx
  80230d:	f7 f5                	div    %ebp
  80230f:	89 c8                	mov    %ecx,%eax
  802311:	f7 f5                	div    %ebp
  802313:	89 d0                	mov    %edx,%eax
  802315:	e9 44 ff ff ff       	jmp    80225e <__umoddi3+0x3e>
  80231a:	66 90                	xchg   %ax,%ax
  80231c:	89 c8                	mov    %ecx,%eax
  80231e:	89 f2                	mov    %esi,%edx
  802320:	83 c4 1c             	add    $0x1c,%esp
  802323:	5b                   	pop    %ebx
  802324:	5e                   	pop    %esi
  802325:	5f                   	pop    %edi
  802326:	5d                   	pop    %ebp
  802327:	c3                   	ret    
  802328:	3b 04 24             	cmp    (%esp),%eax
  80232b:	72 06                	jb     802333 <__umoddi3+0x113>
  80232d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802331:	77 0f                	ja     802342 <__umoddi3+0x122>
  802333:	89 f2                	mov    %esi,%edx
  802335:	29 f9                	sub    %edi,%ecx
  802337:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80233b:	89 14 24             	mov    %edx,(%esp)
  80233e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802342:	8b 44 24 04          	mov    0x4(%esp),%eax
  802346:	8b 14 24             	mov    (%esp),%edx
  802349:	83 c4 1c             	add    $0x1c,%esp
  80234c:	5b                   	pop    %ebx
  80234d:	5e                   	pop    %esi
  80234e:	5f                   	pop    %edi
  80234f:	5d                   	pop    %ebp
  802350:	c3                   	ret    
  802351:	8d 76 00             	lea    0x0(%esi),%esi
  802354:	2b 04 24             	sub    (%esp),%eax
  802357:	19 fa                	sbb    %edi,%edx
  802359:	89 d1                	mov    %edx,%ecx
  80235b:	89 c6                	mov    %eax,%esi
  80235d:	e9 71 ff ff ff       	jmp    8022d3 <__umoddi3+0xb3>
  802362:	66 90                	xchg   %ax,%ax
  802364:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802368:	72 ea                	jb     802354 <__umoddi3+0x134>
  80236a:	89 d9                	mov    %ebx,%ecx
  80236c:	e9 62 ff ff ff       	jmp    8022d3 <__umoddi3+0xb3>
