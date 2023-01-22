
obj/user/quicksort_heap:     file format elf32-i386


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
  800031:	e8 1f 06 00 00       	call   800655 <libmain>
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
  800041:	e8 5c 1d 00 00       	call   801da2 <sys_disable_interrupt>
		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 60 24 80 00       	push   $0x802460
  80004e:	e8 d2 09 00 00       	call   800a25 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 62 24 80 00       	push   $0x802462
  80005e:	e8 c2 09 00 00       	call   800a25 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!   QUICK SORT   !!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 7b 24 80 00       	push   $0x80247b
  80006e:	e8 b2 09 00 00       	call   800a25 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 62 24 80 00       	push   $0x802462
  80007e:	e8 a2 09 00 00       	call   800a25 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 60 24 80 00       	push   $0x802460
  80008e:	e8 92 09 00 00       	call   800a25 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp

		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 94 24 80 00       	push   $0x802494
  8000a5:	e8 fd 0f 00 00       	call   8010a7 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 4d 15 00 00       	call   80160d <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = __new(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 36 1a 00 00       	call   801b0b <__new>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 b4 24 80 00       	push   $0x8024b4
  8000e3:	e8 3d 09 00 00       	call   800a25 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 d6 24 80 00       	push   $0x8024d6
  8000f3:	e8 2d 09 00 00       	call   800a25 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 e4 24 80 00       	push   $0x8024e4
  800103:	e8 1d 09 00 00       	call   800a25 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 f3 24 80 00       	push   $0x8024f3
  800113:	e8 0d 09 00 00       	call   800a25 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 03 25 80 00       	push   $0x802503
  800123:	e8 fd 08 00 00       	call   800a25 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 cd 04 00 00       	call   8005fd <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 75 04 00 00       	call   8005b5 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 68 04 00 00       	call   8005b5 <cputchar>
  80014d:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800150:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800154:	74 0c                	je     800162 <_main+0x12a>
  800156:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  80015a:	74 06                	je     800162 <_main+0x12a>
  80015c:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800160:	75 b9                	jne    80011b <_main+0xe3>
		//2012: lock the interrupt
		sys_enable_interrupt();
  800162:	e8 55 1c 00 00       	call   801dbc <sys_enable_interrupt>

		int  i ;
		switch (Chose)
  800167:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
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
  80017d:	ff 75 f0             	pushl  -0x10(%ebp)
  800180:	ff 75 ec             	pushl  -0x14(%ebp)
  800183:	e8 f5 02 00 00       	call   80047d <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 13 03 00 00       	call   8004ae <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 35 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 22 03 00 00       	call   8004e3 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c4:	83 ec 08             	sub    $0x8,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	e8 f0 00 00 00       	call   8002c2 <QuickSort>
  8001d2:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d5:	e8 c8 1b 00 00       	call   801da2 <sys_disable_interrupt>
			cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001da:	83 ec 0c             	sub    $0xc,%esp
  8001dd:	68 0c 25 80 00       	push   $0x80250c
  8001e2:	e8 3e 08 00 00       	call   800a25 <cprintf>
  8001e7:	83 c4 10             	add    $0x10,%esp
		//		PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ea:	e8 cd 1b 00 00       	call   801dbc <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001ef:	83 ec 08             	sub    $0x8,%esp
  8001f2:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f8:	e8 d6 01 00 00       	call   8003d3 <CheckSorted>
  8001fd:	83 c4 10             	add    $0x10,%esp
  800200:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800203:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800207:	75 14                	jne    80021d <_main+0x1e5>
  800209:	83 ec 04             	sub    $0x4,%esp
  80020c:	68 40 25 80 00       	push   $0x802540
  800211:	6a 48                	push   $0x48
  800213:	68 62 25 80 00       	push   $0x802562
  800218:	e8 54 05 00 00       	call   800771 <_panic>
		else
		{
			sys_disable_interrupt();
  80021d:	e8 80 1b 00 00       	call   801da2 <sys_disable_interrupt>
			cprintf("\n===============================================\n") ;
  800222:	83 ec 0c             	sub    $0xc,%esp
  800225:	68 78 25 80 00       	push   $0x802578
  80022a:	e8 f6 07 00 00       	call   800a25 <cprintf>
  80022f:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800232:	83 ec 0c             	sub    $0xc,%esp
  800235:	68 ac 25 80 00       	push   $0x8025ac
  80023a:	e8 e6 07 00 00       	call   800a25 <cprintf>
  80023f:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800242:	83 ec 0c             	sub    $0xc,%esp
  800245:	68 e0 25 80 00       	push   $0x8025e0
  80024a:	e8 d6 07 00 00       	call   800a25 <cprintf>
  80024f:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800252:	e8 65 1b 00 00       	call   801dbc <sys_enable_interrupt>
		}

		sys_disable_interrupt();
  800257:	e8 46 1b 00 00       	call   801da2 <sys_disable_interrupt>
			Chose = 0 ;
  80025c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800260:	eb 42                	jmp    8002a4 <_main+0x26c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800262:	83 ec 0c             	sub    $0xc,%esp
  800265:	68 12 26 80 00       	push   $0x802612
  80026a:	e8 b6 07 00 00       	call   800a25 <cprintf>
  80026f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800272:	e8 86 03 00 00       	call   8005fd <getchar>
  800277:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80027a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80027e:	83 ec 0c             	sub    $0xc,%esp
  800281:	50                   	push   %eax
  800282:	e8 2e 03 00 00       	call   8005b5 <cputchar>
  800287:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80028a:	83 ec 0c             	sub    $0xc,%esp
  80028d:	6a 0a                	push   $0xa
  80028f:	e8 21 03 00 00       	call   8005b5 <cputchar>
  800294:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800297:	83 ec 0c             	sub    $0xc,%esp
  80029a:	6a 0a                	push   $0xa
  80029c:	e8 14 03 00 00       	call   8005b5 <cputchar>
  8002a1:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
		}

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002a4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002a8:	74 06                	je     8002b0 <_main+0x278>
  8002aa:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002ae:	75 b2                	jne    800262 <_main+0x22a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002b0:	e8 07 1b 00 00       	call   801dbc <sys_enable_interrupt>

	} while (Chose == 'y');
  8002b5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b9:	0f 84 82 fd ff ff    	je     800041 <_main+0x9>

}
  8002bf:	90                   	nop
  8002c0:	c9                   	leave  
  8002c1:	c3                   	ret    

008002c2 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8002c2:	55                   	push   %ebp
  8002c3:	89 e5                	mov    %esp,%ebp
  8002c5:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8002c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002cb:	48                   	dec    %eax
  8002cc:	50                   	push   %eax
  8002cd:	6a 00                	push   $0x0
  8002cf:	ff 75 0c             	pushl  0xc(%ebp)
  8002d2:	ff 75 08             	pushl  0x8(%ebp)
  8002d5:	e8 06 00 00 00       	call   8002e0 <QSort>
  8002da:	83 c4 10             	add    $0x10,%esp
}
  8002dd:	90                   	nop
  8002de:	c9                   	leave  
  8002df:	c3                   	ret    

008002e0 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8002e0:	55                   	push   %ebp
  8002e1:	89 e5                	mov    %esp,%ebp
  8002e3:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8002e6:	8b 45 10             	mov    0x10(%ebp),%eax
  8002e9:	3b 45 14             	cmp    0x14(%ebp),%eax
  8002ec:	0f 8d de 00 00 00    	jge    8003d0 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8002f2:	8b 45 10             	mov    0x10(%ebp),%eax
  8002f5:	40                   	inc    %eax
  8002f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8002f9:	8b 45 14             	mov    0x14(%ebp),%eax
  8002fc:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  8002ff:	e9 80 00 00 00       	jmp    800384 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800304:	ff 45 f4             	incl   -0xc(%ebp)
  800307:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80030a:	3b 45 14             	cmp    0x14(%ebp),%eax
  80030d:	7f 2b                	jg     80033a <QSort+0x5a>
  80030f:	8b 45 10             	mov    0x10(%ebp),%eax
  800312:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800319:	8b 45 08             	mov    0x8(%ebp),%eax
  80031c:	01 d0                	add    %edx,%eax
  80031e:	8b 10                	mov    (%eax),%edx
  800320:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800323:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80032a:	8b 45 08             	mov    0x8(%ebp),%eax
  80032d:	01 c8                	add    %ecx,%eax
  80032f:	8b 00                	mov    (%eax),%eax
  800331:	39 c2                	cmp    %eax,%edx
  800333:	7d cf                	jge    800304 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800335:	eb 03                	jmp    80033a <QSort+0x5a>
  800337:	ff 4d f0             	decl   -0x10(%ebp)
  80033a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80033d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800340:	7e 26                	jle    800368 <QSort+0x88>
  800342:	8b 45 10             	mov    0x10(%ebp),%eax
  800345:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034c:	8b 45 08             	mov    0x8(%ebp),%eax
  80034f:	01 d0                	add    %edx,%eax
  800351:	8b 10                	mov    (%eax),%edx
  800353:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800356:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035d:	8b 45 08             	mov    0x8(%ebp),%eax
  800360:	01 c8                	add    %ecx,%eax
  800362:	8b 00                	mov    (%eax),%eax
  800364:	39 c2                	cmp    %eax,%edx
  800366:	7e cf                	jle    800337 <QSort+0x57>

		if (i <= j)
  800368:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80036b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80036e:	7f 14                	jg     800384 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800370:	83 ec 04             	sub    $0x4,%esp
  800373:	ff 75 f0             	pushl  -0x10(%ebp)
  800376:	ff 75 f4             	pushl  -0xc(%ebp)
  800379:	ff 75 08             	pushl  0x8(%ebp)
  80037c:	e8 a9 00 00 00       	call   80042a <Swap>
  800381:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800384:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800387:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80038a:	0f 8e 77 ff ff ff    	jle    800307 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800390:	83 ec 04             	sub    $0x4,%esp
  800393:	ff 75 f0             	pushl  -0x10(%ebp)
  800396:	ff 75 10             	pushl  0x10(%ebp)
  800399:	ff 75 08             	pushl  0x8(%ebp)
  80039c:	e8 89 00 00 00       	call   80042a <Swap>
  8003a1:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8003a4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003a7:	48                   	dec    %eax
  8003a8:	50                   	push   %eax
  8003a9:	ff 75 10             	pushl  0x10(%ebp)
  8003ac:	ff 75 0c             	pushl  0xc(%ebp)
  8003af:	ff 75 08             	pushl  0x8(%ebp)
  8003b2:	e8 29 ff ff ff       	call   8002e0 <QSort>
  8003b7:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8003ba:	ff 75 14             	pushl  0x14(%ebp)
  8003bd:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c0:	ff 75 0c             	pushl  0xc(%ebp)
  8003c3:	ff 75 08             	pushl  0x8(%ebp)
  8003c6:	e8 15 ff ff ff       	call   8002e0 <QSort>
  8003cb:	83 c4 10             	add    $0x10,%esp
  8003ce:	eb 01                	jmp    8003d1 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8003d0:	90                   	nop
	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);

	//cprintf("qs,after sorting: start = %d, end = %d\n", startIndex, finalIndex);

}
  8003d1:	c9                   	leave  
  8003d2:	c3                   	ret    

008003d3 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8003d3:	55                   	push   %ebp
  8003d4:	89 e5                	mov    %esp,%ebp
  8003d6:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8003d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8003e0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8003e7:	eb 33                	jmp    80041c <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8003e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003ec:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f6:	01 d0                	add    %edx,%eax
  8003f8:	8b 10                	mov    (%eax),%edx
  8003fa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8003fd:	40                   	inc    %eax
  8003fe:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800405:	8b 45 08             	mov    0x8(%ebp),%eax
  800408:	01 c8                	add    %ecx,%eax
  80040a:	8b 00                	mov    (%eax),%eax
  80040c:	39 c2                	cmp    %eax,%edx
  80040e:	7e 09                	jle    800419 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800410:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800417:	eb 0c                	jmp    800425 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800419:	ff 45 f8             	incl   -0x8(%ebp)
  80041c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80041f:	48                   	dec    %eax
  800420:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800423:	7f c4                	jg     8003e9 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800425:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800428:	c9                   	leave  
  800429:	c3                   	ret    

0080042a <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800430:	8b 45 0c             	mov    0xc(%ebp),%eax
  800433:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80043a:	8b 45 08             	mov    0x8(%ebp),%eax
  80043d:	01 d0                	add    %edx,%eax
  80043f:	8b 00                	mov    (%eax),%eax
  800441:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800444:	8b 45 0c             	mov    0xc(%ebp),%eax
  800447:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80044e:	8b 45 08             	mov    0x8(%ebp),%eax
  800451:	01 c2                	add    %eax,%edx
  800453:	8b 45 10             	mov    0x10(%ebp),%eax
  800456:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80045d:	8b 45 08             	mov    0x8(%ebp),%eax
  800460:	01 c8                	add    %ecx,%eax
  800462:	8b 00                	mov    (%eax),%eax
  800464:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800466:	8b 45 10             	mov    0x10(%ebp),%eax
  800469:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800470:	8b 45 08             	mov    0x8(%ebp),%eax
  800473:	01 c2                	add    %eax,%edx
  800475:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800478:	89 02                	mov    %eax,(%edx)
}
  80047a:	90                   	nop
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800483:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80048a:	eb 17                	jmp    8004a3 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80048c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80048f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800496:	8b 45 08             	mov    0x8(%ebp),%eax
  800499:	01 c2                	add    %eax,%edx
  80049b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80049e:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	ff 45 fc             	incl   -0x4(%ebp)
  8004a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a9:	7c e1                	jl     80048c <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8004ab:	90                   	nop
  8004ac:	c9                   	leave  
  8004ad:	c3                   	ret    

008004ae <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8004bb:	eb 1b                	jmp    8004d8 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8004bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ca:	01 c2                	add    %eax,%edx
  8004cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cf:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8004d2:	48                   	dec    %eax
  8004d3:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004d5:	ff 45 fc             	incl   -0x4(%ebp)
  8004d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004db:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004de:	7c dd                	jl     8004bd <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8004e0:	90                   	nop
  8004e1:	c9                   	leave  
  8004e2:	c3                   	ret    

008004e3 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8004e3:	55                   	push   %ebp
  8004e4:	89 e5                	mov    %esp,%ebp
  8004e6:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8004e9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8004ec:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8004f1:	f7 e9                	imul   %ecx
  8004f3:	c1 f9 1f             	sar    $0x1f,%ecx
  8004f6:	89 d0                	mov    %edx,%eax
  8004f8:	29 c8                	sub    %ecx,%eax
  8004fa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8004fd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800504:	eb 1e                	jmp    800524 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800506:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800509:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800510:	8b 45 08             	mov    0x8(%ebp),%eax
  800513:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800516:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800519:	99                   	cltd   
  80051a:	f7 7d f8             	idivl  -0x8(%ebp)
  80051d:	89 d0                	mov    %edx,%eax
  80051f:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800521:	ff 45 fc             	incl   -0x4(%ebp)
  800524:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800527:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80052a:	7c da                	jl     800506 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80052c:	90                   	nop
  80052d:	c9                   	leave  
  80052e:	c3                   	ret    

0080052f <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80052f:	55                   	push   %ebp
  800530:	89 e5                	mov    %esp,%ebp
  800532:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800535:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80053c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800543:	eb 42                	jmp    800587 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800545:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800548:	99                   	cltd   
  800549:	f7 7d f0             	idivl  -0x10(%ebp)
  80054c:	89 d0                	mov    %edx,%eax
  80054e:	85 c0                	test   %eax,%eax
  800550:	75 10                	jne    800562 <PrintElements+0x33>
			cprintf("\n");
  800552:	83 ec 0c             	sub    $0xc,%esp
  800555:	68 60 24 80 00       	push   $0x802460
  80055a:	e8 c6 04 00 00       	call   800a25 <cprintf>
  80055f:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800562:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800565:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80056c:	8b 45 08             	mov    0x8(%ebp),%eax
  80056f:	01 d0                	add    %edx,%eax
  800571:	8b 00                	mov    (%eax),%eax
  800573:	83 ec 08             	sub    $0x8,%esp
  800576:	50                   	push   %eax
  800577:	68 30 26 80 00       	push   $0x802630
  80057c:	e8 a4 04 00 00       	call   800a25 <cprintf>
  800581:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800584:	ff 45 f4             	incl   -0xc(%ebp)
  800587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80058a:	48                   	dec    %eax
  80058b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80058e:	7f b5                	jg     800545 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800590:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800593:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80059a:	8b 45 08             	mov    0x8(%ebp),%eax
  80059d:	01 d0                	add    %edx,%eax
  80059f:	8b 00                	mov    (%eax),%eax
  8005a1:	83 ec 08             	sub    $0x8,%esp
  8005a4:	50                   	push   %eax
  8005a5:	68 35 26 80 00       	push   $0x802635
  8005aa:	e8 76 04 00 00       	call   800a25 <cprintf>
  8005af:	83 c4 10             	add    $0x10,%esp

}
  8005b2:	90                   	nop
  8005b3:	c9                   	leave  
  8005b4:	c3                   	ret    

008005b5 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8005b5:	55                   	push   %ebp
  8005b6:	89 e5                	mov    %esp,%ebp
  8005b8:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8005bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8005be:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005c1:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005c5:	83 ec 0c             	sub    $0xc,%esp
  8005c8:	50                   	push   %eax
  8005c9:	e8 08 18 00 00       	call   801dd6 <sys_cputc>
  8005ce:	83 c4 10             	add    $0x10,%esp
}
  8005d1:	90                   	nop
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8005da:	e8 c3 17 00 00       	call   801da2 <sys_disable_interrupt>
	char c = ch;
  8005df:	8b 45 08             	mov    0x8(%ebp),%eax
  8005e2:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8005e5:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8005e9:	83 ec 0c             	sub    $0xc,%esp
  8005ec:	50                   	push   %eax
  8005ed:	e8 e4 17 00 00       	call   801dd6 <sys_cputc>
  8005f2:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8005f5:	e8 c2 17 00 00       	call   801dbc <sys_enable_interrupt>
}
  8005fa:	90                   	nop
  8005fb:	c9                   	leave  
  8005fc:	c3                   	ret    

008005fd <getchar>:

int
getchar(void)
{
  8005fd:	55                   	push   %ebp
  8005fe:	89 e5                	mov    %esp,%ebp
  800600:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800603:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80060a:	eb 08                	jmp    800614 <getchar+0x17>
	{
		c = sys_cgetc();
  80060c:	e8 a9 15 00 00       	call   801bba <sys_cgetc>
  800611:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800614:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800618:	74 f2                	je     80060c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80061a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80061d:	c9                   	leave  
  80061e:	c3                   	ret    

0080061f <atomic_getchar>:

int
atomic_getchar(void)
{
  80061f:	55                   	push   %ebp
  800620:	89 e5                	mov    %esp,%ebp
  800622:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800625:	e8 78 17 00 00       	call   801da2 <sys_disable_interrupt>
	int c=0;
  80062a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800631:	eb 08                	jmp    80063b <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800633:	e8 82 15 00 00       	call   801bba <sys_cgetc>
  800638:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80063b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80063f:	74 f2                	je     800633 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800641:	e8 76 17 00 00       	call   801dbc <sys_enable_interrupt>
	return c;
  800646:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800649:	c9                   	leave  
  80064a:	c3                   	ret    

0080064b <iscons>:

int iscons(int fdnum)
{
  80064b:	55                   	push   %ebp
  80064c:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80064e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800653:	5d                   	pop    %ebp
  800654:	c3                   	ret    

00800655 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800655:	55                   	push   %ebp
  800656:	89 e5                	mov    %esp,%ebp
  800658:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80065b:	e8 a7 15 00 00       	call   801c07 <sys_getenvindex>
  800660:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800663:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800666:	89 d0                	mov    %edx,%eax
  800668:	01 c0                	add    %eax,%eax
  80066a:	01 d0                	add    %edx,%eax
  80066c:	c1 e0 04             	shl    $0x4,%eax
  80066f:	29 d0                	sub    %edx,%eax
  800671:	c1 e0 03             	shl    $0x3,%eax
  800674:	01 d0                	add    %edx,%eax
  800676:	c1 e0 02             	shl    $0x2,%eax
  800679:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80067e:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800683:	a1 24 30 80 00       	mov    0x803024,%eax
  800688:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80068e:	84 c0                	test   %al,%al
  800690:	74 0f                	je     8006a1 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800692:	a1 24 30 80 00       	mov    0x803024,%eax
  800697:	05 5c 05 00 00       	add    $0x55c,%eax
  80069c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8006a1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8006a5:	7e 0a                	jle    8006b1 <libmain+0x5c>
		binaryname = argv[0];
  8006a7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006aa:	8b 00                	mov    (%eax),%eax
  8006ac:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8006b1:	83 ec 08             	sub    $0x8,%esp
  8006b4:	ff 75 0c             	pushl  0xc(%ebp)
  8006b7:	ff 75 08             	pushl  0x8(%ebp)
  8006ba:	e8 79 f9 ff ff       	call   800038 <_main>
  8006bf:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8006c2:	e8 db 16 00 00       	call   801da2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8006c7:	83 ec 0c             	sub    $0xc,%esp
  8006ca:	68 54 26 80 00       	push   $0x802654
  8006cf:	e8 51 03 00 00       	call   800a25 <cprintf>
  8006d4:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8006d7:	a1 24 30 80 00       	mov    0x803024,%eax
  8006dc:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8006e2:	a1 24 30 80 00       	mov    0x803024,%eax
  8006e7:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8006ed:	83 ec 04             	sub    $0x4,%esp
  8006f0:	52                   	push   %edx
  8006f1:	50                   	push   %eax
  8006f2:	68 7c 26 80 00       	push   $0x80267c
  8006f7:	e8 29 03 00 00       	call   800a25 <cprintf>
  8006fc:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8006ff:	a1 24 30 80 00       	mov    0x803024,%eax
  800704:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80070a:	a1 24 30 80 00       	mov    0x803024,%eax
  80070f:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800715:	a1 24 30 80 00       	mov    0x803024,%eax
  80071a:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800720:	51                   	push   %ecx
  800721:	52                   	push   %edx
  800722:	50                   	push   %eax
  800723:	68 a4 26 80 00       	push   $0x8026a4
  800728:	e8 f8 02 00 00       	call   800a25 <cprintf>
  80072d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800730:	83 ec 0c             	sub    $0xc,%esp
  800733:	68 54 26 80 00       	push   $0x802654
  800738:	e8 e8 02 00 00       	call   800a25 <cprintf>
  80073d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800740:	e8 77 16 00 00       	call   801dbc <sys_enable_interrupt>

	// exit gracefully
	exit();
  800745:	e8 19 00 00 00       	call   800763 <exit>
}
  80074a:	90                   	nop
  80074b:	c9                   	leave  
  80074c:	c3                   	ret    

0080074d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80074d:	55                   	push   %ebp
  80074e:	89 e5                	mov    %esp,%ebp
  800750:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800753:	83 ec 0c             	sub    $0xc,%esp
  800756:	6a 00                	push   $0x0
  800758:	e8 76 14 00 00       	call   801bd3 <sys_env_destroy>
  80075d:	83 c4 10             	add    $0x10,%esp
}
  800760:	90                   	nop
  800761:	c9                   	leave  
  800762:	c3                   	ret    

00800763 <exit>:

void
exit(void)
{
  800763:	55                   	push   %ebp
  800764:	89 e5                	mov    %esp,%ebp
  800766:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800769:	e8 cb 14 00 00       	call   801c39 <sys_env_exit>
}
  80076e:	90                   	nop
  80076f:	c9                   	leave  
  800770:	c3                   	ret    

00800771 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800771:	55                   	push   %ebp
  800772:	89 e5                	mov    %esp,%ebp
  800774:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800777:	8d 45 10             	lea    0x10(%ebp),%eax
  80077a:	83 c0 04             	add    $0x4,%eax
  80077d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800780:	a1 18 31 80 00       	mov    0x803118,%eax
  800785:	85 c0                	test   %eax,%eax
  800787:	74 16                	je     80079f <_panic+0x2e>
		cprintf("%s: ", argv0);
  800789:	a1 18 31 80 00       	mov    0x803118,%eax
  80078e:	83 ec 08             	sub    $0x8,%esp
  800791:	50                   	push   %eax
  800792:	68 fc 26 80 00       	push   $0x8026fc
  800797:	e8 89 02 00 00       	call   800a25 <cprintf>
  80079c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80079f:	a1 00 30 80 00       	mov    0x803000,%eax
  8007a4:	ff 75 0c             	pushl  0xc(%ebp)
  8007a7:	ff 75 08             	pushl  0x8(%ebp)
  8007aa:	50                   	push   %eax
  8007ab:	68 01 27 80 00       	push   $0x802701
  8007b0:	e8 70 02 00 00       	call   800a25 <cprintf>
  8007b5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8007b8:	8b 45 10             	mov    0x10(%ebp),%eax
  8007bb:	83 ec 08             	sub    $0x8,%esp
  8007be:	ff 75 f4             	pushl  -0xc(%ebp)
  8007c1:	50                   	push   %eax
  8007c2:	e8 f3 01 00 00       	call   8009ba <vcprintf>
  8007c7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8007ca:	83 ec 08             	sub    $0x8,%esp
  8007cd:	6a 00                	push   $0x0
  8007cf:	68 1d 27 80 00       	push   $0x80271d
  8007d4:	e8 e1 01 00 00       	call   8009ba <vcprintf>
  8007d9:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8007dc:	e8 82 ff ff ff       	call   800763 <exit>

	// should not return here
	while (1) ;
  8007e1:	eb fe                	jmp    8007e1 <_panic+0x70>

008007e3 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8007e3:	55                   	push   %ebp
  8007e4:	89 e5                	mov    %esp,%ebp
  8007e6:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8007e9:	a1 24 30 80 00       	mov    0x803024,%eax
  8007ee:	8b 50 74             	mov    0x74(%eax),%edx
  8007f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007f4:	39 c2                	cmp    %eax,%edx
  8007f6:	74 14                	je     80080c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8007f8:	83 ec 04             	sub    $0x4,%esp
  8007fb:	68 20 27 80 00       	push   $0x802720
  800800:	6a 26                	push   $0x26
  800802:	68 6c 27 80 00       	push   $0x80276c
  800807:	e8 65 ff ff ff       	call   800771 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80080c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800813:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80081a:	e9 c2 00 00 00       	jmp    8008e1 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80081f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800822:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800829:	8b 45 08             	mov    0x8(%ebp),%eax
  80082c:	01 d0                	add    %edx,%eax
  80082e:	8b 00                	mov    (%eax),%eax
  800830:	85 c0                	test   %eax,%eax
  800832:	75 08                	jne    80083c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800834:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800837:	e9 a2 00 00 00       	jmp    8008de <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80083c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800843:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80084a:	eb 69                	jmp    8008b5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80084c:	a1 24 30 80 00       	mov    0x803024,%eax
  800851:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800857:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80085a:	89 d0                	mov    %edx,%eax
  80085c:	01 c0                	add    %eax,%eax
  80085e:	01 d0                	add    %edx,%eax
  800860:	c1 e0 03             	shl    $0x3,%eax
  800863:	01 c8                	add    %ecx,%eax
  800865:	8a 40 04             	mov    0x4(%eax),%al
  800868:	84 c0                	test   %al,%al
  80086a:	75 46                	jne    8008b2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80086c:	a1 24 30 80 00       	mov    0x803024,%eax
  800871:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800877:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80087a:	89 d0                	mov    %edx,%eax
  80087c:	01 c0                	add    %eax,%eax
  80087e:	01 d0                	add    %edx,%eax
  800880:	c1 e0 03             	shl    $0x3,%eax
  800883:	01 c8                	add    %ecx,%eax
  800885:	8b 00                	mov    (%eax),%eax
  800887:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80088a:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80088d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800892:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800894:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800897:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80089e:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a1:	01 c8                	add    %ecx,%eax
  8008a3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8008a5:	39 c2                	cmp    %eax,%edx
  8008a7:	75 09                	jne    8008b2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8008a9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8008b0:	eb 12                	jmp    8008c4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008b2:	ff 45 e8             	incl   -0x18(%ebp)
  8008b5:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ba:	8b 50 74             	mov    0x74(%eax),%edx
  8008bd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8008c0:	39 c2                	cmp    %eax,%edx
  8008c2:	77 88                	ja     80084c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8008c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8008c8:	75 14                	jne    8008de <CheckWSWithoutLastIndex+0xfb>
			panic(
  8008ca:	83 ec 04             	sub    $0x4,%esp
  8008cd:	68 78 27 80 00       	push   $0x802778
  8008d2:	6a 3a                	push   $0x3a
  8008d4:	68 6c 27 80 00       	push   $0x80276c
  8008d9:	e8 93 fe ff ff       	call   800771 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8008de:	ff 45 f0             	incl   -0x10(%ebp)
  8008e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8008e4:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8008e7:	0f 8c 32 ff ff ff    	jl     80081f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8008ed:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008f4:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8008fb:	eb 26                	jmp    800923 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8008fd:	a1 24 30 80 00       	mov    0x803024,%eax
  800902:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800908:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80090b:	89 d0                	mov    %edx,%eax
  80090d:	01 c0                	add    %eax,%eax
  80090f:	01 d0                	add    %edx,%eax
  800911:	c1 e0 03             	shl    $0x3,%eax
  800914:	01 c8                	add    %ecx,%eax
  800916:	8a 40 04             	mov    0x4(%eax),%al
  800919:	3c 01                	cmp    $0x1,%al
  80091b:	75 03                	jne    800920 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80091d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800920:	ff 45 e0             	incl   -0x20(%ebp)
  800923:	a1 24 30 80 00       	mov    0x803024,%eax
  800928:	8b 50 74             	mov    0x74(%eax),%edx
  80092b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80092e:	39 c2                	cmp    %eax,%edx
  800930:	77 cb                	ja     8008fd <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800932:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800935:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800938:	74 14                	je     80094e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80093a:	83 ec 04             	sub    $0x4,%esp
  80093d:	68 cc 27 80 00       	push   $0x8027cc
  800942:	6a 44                	push   $0x44
  800944:	68 6c 27 80 00       	push   $0x80276c
  800949:	e8 23 fe ff ff       	call   800771 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80094e:	90                   	nop
  80094f:	c9                   	leave  
  800950:	c3                   	ret    

00800951 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800951:	55                   	push   %ebp
  800952:	89 e5                	mov    %esp,%ebp
  800954:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800957:	8b 45 0c             	mov    0xc(%ebp),%eax
  80095a:	8b 00                	mov    (%eax),%eax
  80095c:	8d 48 01             	lea    0x1(%eax),%ecx
  80095f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800962:	89 0a                	mov    %ecx,(%edx)
  800964:	8b 55 08             	mov    0x8(%ebp),%edx
  800967:	88 d1                	mov    %dl,%cl
  800969:	8b 55 0c             	mov    0xc(%ebp),%edx
  80096c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800970:	8b 45 0c             	mov    0xc(%ebp),%eax
  800973:	8b 00                	mov    (%eax),%eax
  800975:	3d ff 00 00 00       	cmp    $0xff,%eax
  80097a:	75 2c                	jne    8009a8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80097c:	a0 28 30 80 00       	mov    0x803028,%al
  800981:	0f b6 c0             	movzbl %al,%eax
  800984:	8b 55 0c             	mov    0xc(%ebp),%edx
  800987:	8b 12                	mov    (%edx),%edx
  800989:	89 d1                	mov    %edx,%ecx
  80098b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80098e:	83 c2 08             	add    $0x8,%edx
  800991:	83 ec 04             	sub    $0x4,%esp
  800994:	50                   	push   %eax
  800995:	51                   	push   %ecx
  800996:	52                   	push   %edx
  800997:	e8 f5 11 00 00       	call   801b91 <sys_cputs>
  80099c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80099f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009a2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8009a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009ab:	8b 40 04             	mov    0x4(%eax),%eax
  8009ae:	8d 50 01             	lea    0x1(%eax),%edx
  8009b1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009b4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8009b7:	90                   	nop
  8009b8:	c9                   	leave  
  8009b9:	c3                   	ret    

008009ba <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8009ba:	55                   	push   %ebp
  8009bb:	89 e5                	mov    %esp,%ebp
  8009bd:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8009c3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8009ca:	00 00 00 
	b.cnt = 0;
  8009cd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8009d4:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8009d7:	ff 75 0c             	pushl  0xc(%ebp)
  8009da:	ff 75 08             	pushl  0x8(%ebp)
  8009dd:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8009e3:	50                   	push   %eax
  8009e4:	68 51 09 80 00       	push   $0x800951
  8009e9:	e8 11 02 00 00       	call   800bff <vprintfmt>
  8009ee:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8009f1:	a0 28 30 80 00       	mov    0x803028,%al
  8009f6:	0f b6 c0             	movzbl %al,%eax
  8009f9:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8009ff:	83 ec 04             	sub    $0x4,%esp
  800a02:	50                   	push   %eax
  800a03:	52                   	push   %edx
  800a04:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800a0a:	83 c0 08             	add    $0x8,%eax
  800a0d:	50                   	push   %eax
  800a0e:	e8 7e 11 00 00       	call   801b91 <sys_cputs>
  800a13:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800a16:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800a1d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800a23:	c9                   	leave  
  800a24:	c3                   	ret    

00800a25 <cprintf>:

int cprintf(const char *fmt, ...) {
  800a25:	55                   	push   %ebp
  800a26:	89 e5                	mov    %esp,%ebp
  800a28:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800a2b:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800a32:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a35:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a38:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3b:	83 ec 08             	sub    $0x8,%esp
  800a3e:	ff 75 f4             	pushl  -0xc(%ebp)
  800a41:	50                   	push   %eax
  800a42:	e8 73 ff ff ff       	call   8009ba <vcprintf>
  800a47:	83 c4 10             	add    $0x10,%esp
  800a4a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800a4d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a50:	c9                   	leave  
  800a51:	c3                   	ret    

00800a52 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800a52:	55                   	push   %ebp
  800a53:	89 e5                	mov    %esp,%ebp
  800a55:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800a58:	e8 45 13 00 00       	call   801da2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800a5d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800a60:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800a63:	8b 45 08             	mov    0x8(%ebp),%eax
  800a66:	83 ec 08             	sub    $0x8,%esp
  800a69:	ff 75 f4             	pushl  -0xc(%ebp)
  800a6c:	50                   	push   %eax
  800a6d:	e8 48 ff ff ff       	call   8009ba <vcprintf>
  800a72:	83 c4 10             	add    $0x10,%esp
  800a75:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a78:	e8 3f 13 00 00       	call   801dbc <sys_enable_interrupt>
	return cnt;
  800a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a80:	c9                   	leave  
  800a81:	c3                   	ret    

00800a82 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a82:	55                   	push   %ebp
  800a83:	89 e5                	mov    %esp,%ebp
  800a85:	53                   	push   %ebx
  800a86:	83 ec 14             	sub    $0x14,%esp
  800a89:	8b 45 10             	mov    0x10(%ebp),%eax
  800a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a92:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a95:	8b 45 18             	mov    0x18(%ebp),%eax
  800a98:	ba 00 00 00 00       	mov    $0x0,%edx
  800a9d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aa0:	77 55                	ja     800af7 <printnum+0x75>
  800aa2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800aa5:	72 05                	jb     800aac <printnum+0x2a>
  800aa7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800aaa:	77 4b                	ja     800af7 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800aac:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800aaf:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800ab2:	8b 45 18             	mov    0x18(%ebp),%eax
  800ab5:	ba 00 00 00 00       	mov    $0x0,%edx
  800aba:	52                   	push   %edx
  800abb:	50                   	push   %eax
  800abc:	ff 75 f4             	pushl  -0xc(%ebp)
  800abf:	ff 75 f0             	pushl  -0x10(%ebp)
  800ac2:	e8 19 17 00 00       	call   8021e0 <__udivdi3>
  800ac7:	83 c4 10             	add    $0x10,%esp
  800aca:	83 ec 04             	sub    $0x4,%esp
  800acd:	ff 75 20             	pushl  0x20(%ebp)
  800ad0:	53                   	push   %ebx
  800ad1:	ff 75 18             	pushl  0x18(%ebp)
  800ad4:	52                   	push   %edx
  800ad5:	50                   	push   %eax
  800ad6:	ff 75 0c             	pushl  0xc(%ebp)
  800ad9:	ff 75 08             	pushl  0x8(%ebp)
  800adc:	e8 a1 ff ff ff       	call   800a82 <printnum>
  800ae1:	83 c4 20             	add    $0x20,%esp
  800ae4:	eb 1a                	jmp    800b00 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ae6:	83 ec 08             	sub    $0x8,%esp
  800ae9:	ff 75 0c             	pushl  0xc(%ebp)
  800aec:	ff 75 20             	pushl  0x20(%ebp)
  800aef:	8b 45 08             	mov    0x8(%ebp),%eax
  800af2:	ff d0                	call   *%eax
  800af4:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800af7:	ff 4d 1c             	decl   0x1c(%ebp)
  800afa:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800afe:	7f e6                	jg     800ae6 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800b00:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800b03:	bb 00 00 00 00       	mov    $0x0,%ebx
  800b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b0e:	53                   	push   %ebx
  800b0f:	51                   	push   %ecx
  800b10:	52                   	push   %edx
  800b11:	50                   	push   %eax
  800b12:	e8 d9 17 00 00       	call   8022f0 <__umoddi3>
  800b17:	83 c4 10             	add    $0x10,%esp
  800b1a:	05 34 2a 80 00       	add    $0x802a34,%eax
  800b1f:	8a 00                	mov    (%eax),%al
  800b21:	0f be c0             	movsbl %al,%eax
  800b24:	83 ec 08             	sub    $0x8,%esp
  800b27:	ff 75 0c             	pushl  0xc(%ebp)
  800b2a:	50                   	push   %eax
  800b2b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2e:	ff d0                	call   *%eax
  800b30:	83 c4 10             	add    $0x10,%esp
}
  800b33:	90                   	nop
  800b34:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800b37:	c9                   	leave  
  800b38:	c3                   	ret    

00800b39 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800b39:	55                   	push   %ebp
  800b3a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b3c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b40:	7e 1c                	jle    800b5e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800b42:	8b 45 08             	mov    0x8(%ebp),%eax
  800b45:	8b 00                	mov    (%eax),%eax
  800b47:	8d 50 08             	lea    0x8(%eax),%edx
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	89 10                	mov    %edx,(%eax)
  800b4f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b52:	8b 00                	mov    (%eax),%eax
  800b54:	83 e8 08             	sub    $0x8,%eax
  800b57:	8b 50 04             	mov    0x4(%eax),%edx
  800b5a:	8b 00                	mov    (%eax),%eax
  800b5c:	eb 40                	jmp    800b9e <getuint+0x65>
	else if (lflag)
  800b5e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b62:	74 1e                	je     800b82 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800b64:	8b 45 08             	mov    0x8(%ebp),%eax
  800b67:	8b 00                	mov    (%eax),%eax
  800b69:	8d 50 04             	lea    0x4(%eax),%edx
  800b6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b6f:	89 10                	mov    %edx,(%eax)
  800b71:	8b 45 08             	mov    0x8(%ebp),%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	83 e8 04             	sub    $0x4,%eax
  800b79:	8b 00                	mov    (%eax),%eax
  800b7b:	ba 00 00 00 00       	mov    $0x0,%edx
  800b80:	eb 1c                	jmp    800b9e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b82:	8b 45 08             	mov    0x8(%ebp),%eax
  800b85:	8b 00                	mov    (%eax),%eax
  800b87:	8d 50 04             	lea    0x4(%eax),%edx
  800b8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8d:	89 10                	mov    %edx,(%eax)
  800b8f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b92:	8b 00                	mov    (%eax),%eax
  800b94:	83 e8 04             	sub    $0x4,%eax
  800b97:	8b 00                	mov    (%eax),%eax
  800b99:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b9e:	5d                   	pop    %ebp
  800b9f:	c3                   	ret    

00800ba0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800ba0:	55                   	push   %ebp
  800ba1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ba3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ba7:	7e 1c                	jle    800bc5 <getint+0x25>
		return va_arg(*ap, long long);
  800ba9:	8b 45 08             	mov    0x8(%ebp),%eax
  800bac:	8b 00                	mov    (%eax),%eax
  800bae:	8d 50 08             	lea    0x8(%eax),%edx
  800bb1:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb4:	89 10                	mov    %edx,(%eax)
  800bb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb9:	8b 00                	mov    (%eax),%eax
  800bbb:	83 e8 08             	sub    $0x8,%eax
  800bbe:	8b 50 04             	mov    0x4(%eax),%edx
  800bc1:	8b 00                	mov    (%eax),%eax
  800bc3:	eb 38                	jmp    800bfd <getint+0x5d>
	else if (lflag)
  800bc5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800bc9:	74 1a                	je     800be5 <getint+0x45>
		return va_arg(*ap, long);
  800bcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800bce:	8b 00                	mov    (%eax),%eax
  800bd0:	8d 50 04             	lea    0x4(%eax),%edx
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	89 10                	mov    %edx,(%eax)
  800bd8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bdb:	8b 00                	mov    (%eax),%eax
  800bdd:	83 e8 04             	sub    $0x4,%eax
  800be0:	8b 00                	mov    (%eax),%eax
  800be2:	99                   	cltd   
  800be3:	eb 18                	jmp    800bfd <getint+0x5d>
	else
		return va_arg(*ap, int);
  800be5:	8b 45 08             	mov    0x8(%ebp),%eax
  800be8:	8b 00                	mov    (%eax),%eax
  800bea:	8d 50 04             	lea    0x4(%eax),%edx
  800bed:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf0:	89 10                	mov    %edx,(%eax)
  800bf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf5:	8b 00                	mov    (%eax),%eax
  800bf7:	83 e8 04             	sub    $0x4,%eax
  800bfa:	8b 00                	mov    (%eax),%eax
  800bfc:	99                   	cltd   
}
  800bfd:	5d                   	pop    %ebp
  800bfe:	c3                   	ret    

00800bff <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800bff:	55                   	push   %ebp
  800c00:	89 e5                	mov    %esp,%ebp
  800c02:	56                   	push   %esi
  800c03:	53                   	push   %ebx
  800c04:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c07:	eb 17                	jmp    800c20 <vprintfmt+0x21>
			if (ch == '\0')
  800c09:	85 db                	test   %ebx,%ebx
  800c0b:	0f 84 af 03 00 00    	je     800fc0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800c11:	83 ec 08             	sub    $0x8,%esp
  800c14:	ff 75 0c             	pushl  0xc(%ebp)
  800c17:	53                   	push   %ebx
  800c18:	8b 45 08             	mov    0x8(%ebp),%eax
  800c1b:	ff d0                	call   *%eax
  800c1d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800c20:	8b 45 10             	mov    0x10(%ebp),%eax
  800c23:	8d 50 01             	lea    0x1(%eax),%edx
  800c26:	89 55 10             	mov    %edx,0x10(%ebp)
  800c29:	8a 00                	mov    (%eax),%al
  800c2b:	0f b6 d8             	movzbl %al,%ebx
  800c2e:	83 fb 25             	cmp    $0x25,%ebx
  800c31:	75 d6                	jne    800c09 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800c33:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800c37:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800c3e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800c45:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800c4c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800c53:	8b 45 10             	mov    0x10(%ebp),%eax
  800c56:	8d 50 01             	lea    0x1(%eax),%edx
  800c59:	89 55 10             	mov    %edx,0x10(%ebp)
  800c5c:	8a 00                	mov    (%eax),%al
  800c5e:	0f b6 d8             	movzbl %al,%ebx
  800c61:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800c64:	83 f8 55             	cmp    $0x55,%eax
  800c67:	0f 87 2b 03 00 00    	ja     800f98 <vprintfmt+0x399>
  800c6d:	8b 04 85 58 2a 80 00 	mov    0x802a58(,%eax,4),%eax
  800c74:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c76:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c7a:	eb d7                	jmp    800c53 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c7c:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c80:	eb d1                	jmp    800c53 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c82:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c89:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c8c:	89 d0                	mov    %edx,%eax
  800c8e:	c1 e0 02             	shl    $0x2,%eax
  800c91:	01 d0                	add    %edx,%eax
  800c93:	01 c0                	add    %eax,%eax
  800c95:	01 d8                	add    %ebx,%eax
  800c97:	83 e8 30             	sub    $0x30,%eax
  800c9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c9d:	8b 45 10             	mov    0x10(%ebp),%eax
  800ca0:	8a 00                	mov    (%eax),%al
  800ca2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ca5:	83 fb 2f             	cmp    $0x2f,%ebx
  800ca8:	7e 3e                	jle    800ce8 <vprintfmt+0xe9>
  800caa:	83 fb 39             	cmp    $0x39,%ebx
  800cad:	7f 39                	jg     800ce8 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800caf:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800cb2:	eb d5                	jmp    800c89 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800cb4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cb7:	83 c0 04             	add    $0x4,%eax
  800cba:	89 45 14             	mov    %eax,0x14(%ebp)
  800cbd:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc0:	83 e8 04             	sub    $0x4,%eax
  800cc3:	8b 00                	mov    (%eax),%eax
  800cc5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800cc8:	eb 1f                	jmp    800ce9 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800cca:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800cce:	79 83                	jns    800c53 <vprintfmt+0x54>
				width = 0;
  800cd0:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800cd7:	e9 77 ff ff ff       	jmp    800c53 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800cdc:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ce3:	e9 6b ff ff ff       	jmp    800c53 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ce8:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ce9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ced:	0f 89 60 ff ff ff    	jns    800c53 <vprintfmt+0x54>
				width = precision, precision = -1;
  800cf3:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800cf6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800cf9:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800d00:	e9 4e ff ff ff       	jmp    800c53 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800d05:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800d08:	e9 46 ff ff ff       	jmp    800c53 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800d0d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d10:	83 c0 04             	add    $0x4,%eax
  800d13:	89 45 14             	mov    %eax,0x14(%ebp)
  800d16:	8b 45 14             	mov    0x14(%ebp),%eax
  800d19:	83 e8 04             	sub    $0x4,%eax
  800d1c:	8b 00                	mov    (%eax),%eax
  800d1e:	83 ec 08             	sub    $0x8,%esp
  800d21:	ff 75 0c             	pushl  0xc(%ebp)
  800d24:	50                   	push   %eax
  800d25:	8b 45 08             	mov    0x8(%ebp),%eax
  800d28:	ff d0                	call   *%eax
  800d2a:	83 c4 10             	add    $0x10,%esp
			break;
  800d2d:	e9 89 02 00 00       	jmp    800fbb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800d32:	8b 45 14             	mov    0x14(%ebp),%eax
  800d35:	83 c0 04             	add    $0x4,%eax
  800d38:	89 45 14             	mov    %eax,0x14(%ebp)
  800d3b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d3e:	83 e8 04             	sub    $0x4,%eax
  800d41:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800d43:	85 db                	test   %ebx,%ebx
  800d45:	79 02                	jns    800d49 <vprintfmt+0x14a>
				err = -err;
  800d47:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800d49:	83 fb 64             	cmp    $0x64,%ebx
  800d4c:	7f 0b                	jg     800d59 <vprintfmt+0x15a>
  800d4e:	8b 34 9d a0 28 80 00 	mov    0x8028a0(,%ebx,4),%esi
  800d55:	85 f6                	test   %esi,%esi
  800d57:	75 19                	jne    800d72 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800d59:	53                   	push   %ebx
  800d5a:	68 45 2a 80 00       	push   $0x802a45
  800d5f:	ff 75 0c             	pushl  0xc(%ebp)
  800d62:	ff 75 08             	pushl  0x8(%ebp)
  800d65:	e8 5e 02 00 00       	call   800fc8 <printfmt>
  800d6a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800d6d:	e9 49 02 00 00       	jmp    800fbb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800d72:	56                   	push   %esi
  800d73:	68 4e 2a 80 00       	push   $0x802a4e
  800d78:	ff 75 0c             	pushl  0xc(%ebp)
  800d7b:	ff 75 08             	pushl  0x8(%ebp)
  800d7e:	e8 45 02 00 00       	call   800fc8 <printfmt>
  800d83:	83 c4 10             	add    $0x10,%esp
			break;
  800d86:	e9 30 02 00 00       	jmp    800fbb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d8b:	8b 45 14             	mov    0x14(%ebp),%eax
  800d8e:	83 c0 04             	add    $0x4,%eax
  800d91:	89 45 14             	mov    %eax,0x14(%ebp)
  800d94:	8b 45 14             	mov    0x14(%ebp),%eax
  800d97:	83 e8 04             	sub    $0x4,%eax
  800d9a:	8b 30                	mov    (%eax),%esi
  800d9c:	85 f6                	test   %esi,%esi
  800d9e:	75 05                	jne    800da5 <vprintfmt+0x1a6>
				p = "(null)";
  800da0:	be 51 2a 80 00       	mov    $0x802a51,%esi
			if (width > 0 && padc != '-')
  800da5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800da9:	7e 6d                	jle    800e18 <vprintfmt+0x219>
  800dab:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800daf:	74 67                	je     800e18 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800db1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800db4:	83 ec 08             	sub    $0x8,%esp
  800db7:	50                   	push   %eax
  800db8:	56                   	push   %esi
  800db9:	e8 12 05 00 00       	call   8012d0 <strnlen>
  800dbe:	83 c4 10             	add    $0x10,%esp
  800dc1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800dc4:	eb 16                	jmp    800ddc <vprintfmt+0x1dd>
					putch(padc, putdat);
  800dc6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800dca:	83 ec 08             	sub    $0x8,%esp
  800dcd:	ff 75 0c             	pushl  0xc(%ebp)
  800dd0:	50                   	push   %eax
  800dd1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd4:	ff d0                	call   *%eax
  800dd6:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800dd9:	ff 4d e4             	decl   -0x1c(%ebp)
  800ddc:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800de0:	7f e4                	jg     800dc6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800de2:	eb 34                	jmp    800e18 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800de4:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800de8:	74 1c                	je     800e06 <vprintfmt+0x207>
  800dea:	83 fb 1f             	cmp    $0x1f,%ebx
  800ded:	7e 05                	jle    800df4 <vprintfmt+0x1f5>
  800def:	83 fb 7e             	cmp    $0x7e,%ebx
  800df2:	7e 12                	jle    800e06 <vprintfmt+0x207>
					putch('?', putdat);
  800df4:	83 ec 08             	sub    $0x8,%esp
  800df7:	ff 75 0c             	pushl  0xc(%ebp)
  800dfa:	6a 3f                	push   $0x3f
  800dfc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dff:	ff d0                	call   *%eax
  800e01:	83 c4 10             	add    $0x10,%esp
  800e04:	eb 0f                	jmp    800e15 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800e06:	83 ec 08             	sub    $0x8,%esp
  800e09:	ff 75 0c             	pushl  0xc(%ebp)
  800e0c:	53                   	push   %ebx
  800e0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e10:	ff d0                	call   *%eax
  800e12:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800e15:	ff 4d e4             	decl   -0x1c(%ebp)
  800e18:	89 f0                	mov    %esi,%eax
  800e1a:	8d 70 01             	lea    0x1(%eax),%esi
  800e1d:	8a 00                	mov    (%eax),%al
  800e1f:	0f be d8             	movsbl %al,%ebx
  800e22:	85 db                	test   %ebx,%ebx
  800e24:	74 24                	je     800e4a <vprintfmt+0x24b>
  800e26:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e2a:	78 b8                	js     800de4 <vprintfmt+0x1e5>
  800e2c:	ff 4d e0             	decl   -0x20(%ebp)
  800e2f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800e33:	79 af                	jns    800de4 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e35:	eb 13                	jmp    800e4a <vprintfmt+0x24b>
				putch(' ', putdat);
  800e37:	83 ec 08             	sub    $0x8,%esp
  800e3a:	ff 75 0c             	pushl  0xc(%ebp)
  800e3d:	6a 20                	push   $0x20
  800e3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e42:	ff d0                	call   *%eax
  800e44:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800e47:	ff 4d e4             	decl   -0x1c(%ebp)
  800e4a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e4e:	7f e7                	jg     800e37 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800e50:	e9 66 01 00 00       	jmp    800fbb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800e55:	83 ec 08             	sub    $0x8,%esp
  800e58:	ff 75 e8             	pushl  -0x18(%ebp)
  800e5b:	8d 45 14             	lea    0x14(%ebp),%eax
  800e5e:	50                   	push   %eax
  800e5f:	e8 3c fd ff ff       	call   800ba0 <getint>
  800e64:	83 c4 10             	add    $0x10,%esp
  800e67:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e6a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800e6d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e70:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e73:	85 d2                	test   %edx,%edx
  800e75:	79 23                	jns    800e9a <vprintfmt+0x29b>
				putch('-', putdat);
  800e77:	83 ec 08             	sub    $0x8,%esp
  800e7a:	ff 75 0c             	pushl  0xc(%ebp)
  800e7d:	6a 2d                	push   $0x2d
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	ff d0                	call   *%eax
  800e84:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e87:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e8a:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e8d:	f7 d8                	neg    %eax
  800e8f:	83 d2 00             	adc    $0x0,%edx
  800e92:	f7 da                	neg    %edx
  800e94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e97:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e9a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ea1:	e9 bc 00 00 00       	jmp    800f62 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ea6:	83 ec 08             	sub    $0x8,%esp
  800ea9:	ff 75 e8             	pushl  -0x18(%ebp)
  800eac:	8d 45 14             	lea    0x14(%ebp),%eax
  800eaf:	50                   	push   %eax
  800eb0:	e8 84 fc ff ff       	call   800b39 <getuint>
  800eb5:	83 c4 10             	add    $0x10,%esp
  800eb8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800ebe:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ec5:	e9 98 00 00 00       	jmp    800f62 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800eca:	83 ec 08             	sub    $0x8,%esp
  800ecd:	ff 75 0c             	pushl  0xc(%ebp)
  800ed0:	6a 58                	push   $0x58
  800ed2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed5:	ff d0                	call   *%eax
  800ed7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eda:	83 ec 08             	sub    $0x8,%esp
  800edd:	ff 75 0c             	pushl  0xc(%ebp)
  800ee0:	6a 58                	push   $0x58
  800ee2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee5:	ff d0                	call   *%eax
  800ee7:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800eea:	83 ec 08             	sub    $0x8,%esp
  800eed:	ff 75 0c             	pushl  0xc(%ebp)
  800ef0:	6a 58                	push   $0x58
  800ef2:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef5:	ff d0                	call   *%eax
  800ef7:	83 c4 10             	add    $0x10,%esp
			break;
  800efa:	e9 bc 00 00 00       	jmp    800fbb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800eff:	83 ec 08             	sub    $0x8,%esp
  800f02:	ff 75 0c             	pushl  0xc(%ebp)
  800f05:	6a 30                	push   $0x30
  800f07:	8b 45 08             	mov    0x8(%ebp),%eax
  800f0a:	ff d0                	call   *%eax
  800f0c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800f0f:	83 ec 08             	sub    $0x8,%esp
  800f12:	ff 75 0c             	pushl  0xc(%ebp)
  800f15:	6a 78                	push   $0x78
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	ff d0                	call   *%eax
  800f1c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800f1f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f22:	83 c0 04             	add    $0x4,%eax
  800f25:	89 45 14             	mov    %eax,0x14(%ebp)
  800f28:	8b 45 14             	mov    0x14(%ebp),%eax
  800f2b:	83 e8 04             	sub    $0x4,%eax
  800f2e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800f30:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f33:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800f3a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800f41:	eb 1f                	jmp    800f62 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800f43:	83 ec 08             	sub    $0x8,%esp
  800f46:	ff 75 e8             	pushl  -0x18(%ebp)
  800f49:	8d 45 14             	lea    0x14(%ebp),%eax
  800f4c:	50                   	push   %eax
  800f4d:	e8 e7 fb ff ff       	call   800b39 <getuint>
  800f52:	83 c4 10             	add    $0x10,%esp
  800f55:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800f58:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800f5b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800f62:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800f66:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800f69:	83 ec 04             	sub    $0x4,%esp
  800f6c:	52                   	push   %edx
  800f6d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800f70:	50                   	push   %eax
  800f71:	ff 75 f4             	pushl  -0xc(%ebp)
  800f74:	ff 75 f0             	pushl  -0x10(%ebp)
  800f77:	ff 75 0c             	pushl  0xc(%ebp)
  800f7a:	ff 75 08             	pushl  0x8(%ebp)
  800f7d:	e8 00 fb ff ff       	call   800a82 <printnum>
  800f82:	83 c4 20             	add    $0x20,%esp
			break;
  800f85:	eb 34                	jmp    800fbb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f87:	83 ec 08             	sub    $0x8,%esp
  800f8a:	ff 75 0c             	pushl  0xc(%ebp)
  800f8d:	53                   	push   %ebx
  800f8e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f91:	ff d0                	call   *%eax
  800f93:	83 c4 10             	add    $0x10,%esp
			break;
  800f96:	eb 23                	jmp    800fbb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f98:	83 ec 08             	sub    $0x8,%esp
  800f9b:	ff 75 0c             	pushl  0xc(%ebp)
  800f9e:	6a 25                	push   $0x25
  800fa0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa3:	ff d0                	call   *%eax
  800fa5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800fa8:	ff 4d 10             	decl   0x10(%ebp)
  800fab:	eb 03                	jmp    800fb0 <vprintfmt+0x3b1>
  800fad:	ff 4d 10             	decl   0x10(%ebp)
  800fb0:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb3:	48                   	dec    %eax
  800fb4:	8a 00                	mov    (%eax),%al
  800fb6:	3c 25                	cmp    $0x25,%al
  800fb8:	75 f3                	jne    800fad <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800fba:	90                   	nop
		}
	}
  800fbb:	e9 47 fc ff ff       	jmp    800c07 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800fc0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800fc1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800fc4:	5b                   	pop    %ebx
  800fc5:	5e                   	pop    %esi
  800fc6:	5d                   	pop    %ebp
  800fc7:	c3                   	ret    

00800fc8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800fc8:	55                   	push   %ebp
  800fc9:	89 e5                	mov    %esp,%ebp
  800fcb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800fce:	8d 45 10             	lea    0x10(%ebp),%eax
  800fd1:	83 c0 04             	add    $0x4,%eax
  800fd4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800fd7:	8b 45 10             	mov    0x10(%ebp),%eax
  800fda:	ff 75 f4             	pushl  -0xc(%ebp)
  800fdd:	50                   	push   %eax
  800fde:	ff 75 0c             	pushl  0xc(%ebp)
  800fe1:	ff 75 08             	pushl  0x8(%ebp)
  800fe4:	e8 16 fc ff ff       	call   800bff <vprintfmt>
  800fe9:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800fec:	90                   	nop
  800fed:	c9                   	leave  
  800fee:	c3                   	ret    

00800fef <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800fef:	55                   	push   %ebp
  800ff0:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ff2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ff5:	8b 40 08             	mov    0x8(%eax),%eax
  800ff8:	8d 50 01             	lea    0x1(%eax),%edx
  800ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffe:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801001:	8b 45 0c             	mov    0xc(%ebp),%eax
  801004:	8b 10                	mov    (%eax),%edx
  801006:	8b 45 0c             	mov    0xc(%ebp),%eax
  801009:	8b 40 04             	mov    0x4(%eax),%eax
  80100c:	39 c2                	cmp    %eax,%edx
  80100e:	73 12                	jae    801022 <sprintputch+0x33>
		*b->buf++ = ch;
  801010:	8b 45 0c             	mov    0xc(%ebp),%eax
  801013:	8b 00                	mov    (%eax),%eax
  801015:	8d 48 01             	lea    0x1(%eax),%ecx
  801018:	8b 55 0c             	mov    0xc(%ebp),%edx
  80101b:	89 0a                	mov    %ecx,(%edx)
  80101d:	8b 55 08             	mov    0x8(%ebp),%edx
  801020:	88 10                	mov    %dl,(%eax)
}
  801022:	90                   	nop
  801023:	5d                   	pop    %ebp
  801024:	c3                   	ret    

00801025 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801025:	55                   	push   %ebp
  801026:	89 e5                	mov    %esp,%ebp
  801028:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80102b:	8b 45 08             	mov    0x8(%ebp),%eax
  80102e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801031:	8b 45 0c             	mov    0xc(%ebp),%eax
  801034:	8d 50 ff             	lea    -0x1(%eax),%edx
  801037:	8b 45 08             	mov    0x8(%ebp),%eax
  80103a:	01 d0                	add    %edx,%eax
  80103c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80103f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801046:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80104a:	74 06                	je     801052 <vsnprintf+0x2d>
  80104c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801050:	7f 07                	jg     801059 <vsnprintf+0x34>
		return -E_INVAL;
  801052:	b8 03 00 00 00       	mov    $0x3,%eax
  801057:	eb 20                	jmp    801079 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  801059:	ff 75 14             	pushl  0x14(%ebp)
  80105c:	ff 75 10             	pushl  0x10(%ebp)
  80105f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801062:	50                   	push   %eax
  801063:	68 ef 0f 80 00       	push   $0x800fef
  801068:	e8 92 fb ff ff       	call   800bff <vprintfmt>
  80106d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801070:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801073:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801076:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801079:	c9                   	leave  
  80107a:	c3                   	ret    

0080107b <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80107b:	55                   	push   %ebp
  80107c:	89 e5                	mov    %esp,%ebp
  80107e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801081:	8d 45 10             	lea    0x10(%ebp),%eax
  801084:	83 c0 04             	add    $0x4,%eax
  801087:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80108a:	8b 45 10             	mov    0x10(%ebp),%eax
  80108d:	ff 75 f4             	pushl  -0xc(%ebp)
  801090:	50                   	push   %eax
  801091:	ff 75 0c             	pushl  0xc(%ebp)
  801094:	ff 75 08             	pushl  0x8(%ebp)
  801097:	e8 89 ff ff ff       	call   801025 <vsnprintf>
  80109c:	83 c4 10             	add    $0x10,%esp
  80109f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8010a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8010a5:	c9                   	leave  
  8010a6:	c3                   	ret    

008010a7 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8010a7:	55                   	push   %ebp
  8010a8:	89 e5                	mov    %esp,%ebp
  8010aa:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8010ad:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8010b1:	74 13                	je     8010c6 <readline+0x1f>
		cprintf("%s", prompt);
  8010b3:	83 ec 08             	sub    $0x8,%esp
  8010b6:	ff 75 08             	pushl  0x8(%ebp)
  8010b9:	68 b0 2b 80 00       	push   $0x802bb0
  8010be:	e8 62 f9 ff ff       	call   800a25 <cprintf>
  8010c3:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8010c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8010cd:	83 ec 0c             	sub    $0xc,%esp
  8010d0:	6a 00                	push   $0x0
  8010d2:	e8 74 f5 ff ff       	call   80064b <iscons>
  8010d7:	83 c4 10             	add    $0x10,%esp
  8010da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8010dd:	e8 1b f5 ff ff       	call   8005fd <getchar>
  8010e2:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8010e5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8010e9:	79 22                	jns    80110d <readline+0x66>
			if (c != -E_EOF)
  8010eb:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8010ef:	0f 84 ad 00 00 00    	je     8011a2 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8010f5:	83 ec 08             	sub    $0x8,%esp
  8010f8:	ff 75 ec             	pushl  -0x14(%ebp)
  8010fb:	68 b3 2b 80 00       	push   $0x802bb3
  801100:	e8 20 f9 ff ff       	call   800a25 <cprintf>
  801105:	83 c4 10             	add    $0x10,%esp
			return;
  801108:	e9 95 00 00 00       	jmp    8011a2 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80110d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801111:	7e 34                	jle    801147 <readline+0xa0>
  801113:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80111a:	7f 2b                	jg     801147 <readline+0xa0>
			if (echoing)
  80111c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801120:	74 0e                	je     801130 <readline+0x89>
				cputchar(c);
  801122:	83 ec 0c             	sub    $0xc,%esp
  801125:	ff 75 ec             	pushl  -0x14(%ebp)
  801128:	e8 88 f4 ff ff       	call   8005b5 <cputchar>
  80112d:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801130:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801133:	8d 50 01             	lea    0x1(%eax),%edx
  801136:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801139:	89 c2                	mov    %eax,%edx
  80113b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80113e:	01 d0                	add    %edx,%eax
  801140:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801143:	88 10                	mov    %dl,(%eax)
  801145:	eb 56                	jmp    80119d <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801147:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80114b:	75 1f                	jne    80116c <readline+0xc5>
  80114d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801151:	7e 19                	jle    80116c <readline+0xc5>
			if (echoing)
  801153:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801157:	74 0e                	je     801167 <readline+0xc0>
				cputchar(c);
  801159:	83 ec 0c             	sub    $0xc,%esp
  80115c:	ff 75 ec             	pushl  -0x14(%ebp)
  80115f:	e8 51 f4 ff ff       	call   8005b5 <cputchar>
  801164:	83 c4 10             	add    $0x10,%esp

			i--;
  801167:	ff 4d f4             	decl   -0xc(%ebp)
  80116a:	eb 31                	jmp    80119d <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80116c:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801170:	74 0a                	je     80117c <readline+0xd5>
  801172:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801176:	0f 85 61 ff ff ff    	jne    8010dd <readline+0x36>
			if (echoing)
  80117c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801180:	74 0e                	je     801190 <readline+0xe9>
				cputchar(c);
  801182:	83 ec 0c             	sub    $0xc,%esp
  801185:	ff 75 ec             	pushl  -0x14(%ebp)
  801188:	e8 28 f4 ff ff       	call   8005b5 <cputchar>
  80118d:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801190:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801193:	8b 45 0c             	mov    0xc(%ebp),%eax
  801196:	01 d0                	add    %edx,%eax
  801198:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80119b:	eb 06                	jmp    8011a3 <readline+0xfc>
		}
	}
  80119d:	e9 3b ff ff ff       	jmp    8010dd <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8011a2:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8011a3:	c9                   	leave  
  8011a4:	c3                   	ret    

008011a5 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8011a5:	55                   	push   %ebp
  8011a6:	89 e5                	mov    %esp,%ebp
  8011a8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8011ab:	e8 f2 0b 00 00       	call   801da2 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8011b0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011b4:	74 13                	je     8011c9 <atomic_readline+0x24>
		cprintf("%s", prompt);
  8011b6:	83 ec 08             	sub    $0x8,%esp
  8011b9:	ff 75 08             	pushl  0x8(%ebp)
  8011bc:	68 b0 2b 80 00       	push   $0x802bb0
  8011c1:	e8 5f f8 ff ff       	call   800a25 <cprintf>
  8011c6:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8011c9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8011d0:	83 ec 0c             	sub    $0xc,%esp
  8011d3:	6a 00                	push   $0x0
  8011d5:	e8 71 f4 ff ff       	call   80064b <iscons>
  8011da:	83 c4 10             	add    $0x10,%esp
  8011dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8011e0:	e8 18 f4 ff ff       	call   8005fd <getchar>
  8011e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8011e8:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8011ec:	79 23                	jns    801211 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8011ee:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8011f2:	74 13                	je     801207 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8011f4:	83 ec 08             	sub    $0x8,%esp
  8011f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8011fa:	68 b3 2b 80 00       	push   $0x802bb3
  8011ff:	e8 21 f8 ff ff       	call   800a25 <cprintf>
  801204:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801207:	e8 b0 0b 00 00       	call   801dbc <sys_enable_interrupt>
			return;
  80120c:	e9 9a 00 00 00       	jmp    8012ab <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801211:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801215:	7e 34                	jle    80124b <atomic_readline+0xa6>
  801217:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80121e:	7f 2b                	jg     80124b <atomic_readline+0xa6>
			if (echoing)
  801220:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801224:	74 0e                	je     801234 <atomic_readline+0x8f>
				cputchar(c);
  801226:	83 ec 0c             	sub    $0xc,%esp
  801229:	ff 75 ec             	pushl  -0x14(%ebp)
  80122c:	e8 84 f3 ff ff       	call   8005b5 <cputchar>
  801231:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801234:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801237:	8d 50 01             	lea    0x1(%eax),%edx
  80123a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80123d:	89 c2                	mov    %eax,%edx
  80123f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801242:	01 d0                	add    %edx,%eax
  801244:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801247:	88 10                	mov    %dl,(%eax)
  801249:	eb 5b                	jmp    8012a6 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80124b:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80124f:	75 1f                	jne    801270 <atomic_readline+0xcb>
  801251:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801255:	7e 19                	jle    801270 <atomic_readline+0xcb>
			if (echoing)
  801257:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80125b:	74 0e                	je     80126b <atomic_readline+0xc6>
				cputchar(c);
  80125d:	83 ec 0c             	sub    $0xc,%esp
  801260:	ff 75 ec             	pushl  -0x14(%ebp)
  801263:	e8 4d f3 ff ff       	call   8005b5 <cputchar>
  801268:	83 c4 10             	add    $0x10,%esp
			i--;
  80126b:	ff 4d f4             	decl   -0xc(%ebp)
  80126e:	eb 36                	jmp    8012a6 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801270:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801274:	74 0a                	je     801280 <atomic_readline+0xdb>
  801276:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80127a:	0f 85 60 ff ff ff    	jne    8011e0 <atomic_readline+0x3b>
			if (echoing)
  801280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801284:	74 0e                	je     801294 <atomic_readline+0xef>
				cputchar(c);
  801286:	83 ec 0c             	sub    $0xc,%esp
  801289:	ff 75 ec             	pushl  -0x14(%ebp)
  80128c:	e8 24 f3 ff ff       	call   8005b5 <cputchar>
  801291:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801294:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801297:	8b 45 0c             	mov    0xc(%ebp),%eax
  80129a:	01 d0                	add    %edx,%eax
  80129c:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80129f:	e8 18 0b 00 00       	call   801dbc <sys_enable_interrupt>
			return;
  8012a4:	eb 05                	jmp    8012ab <atomic_readline+0x106>
		}
	}
  8012a6:	e9 35 ff ff ff       	jmp    8011e0 <atomic_readline+0x3b>
}
  8012ab:	c9                   	leave  
  8012ac:	c3                   	ret    

008012ad <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8012ad:	55                   	push   %ebp
  8012ae:	89 e5                	mov    %esp,%ebp
  8012b0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8012b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012ba:	eb 06                	jmp    8012c2 <strlen+0x15>
		n++;
  8012bc:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8012bf:	ff 45 08             	incl   0x8(%ebp)
  8012c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c5:	8a 00                	mov    (%eax),%al
  8012c7:	84 c0                	test   %al,%al
  8012c9:	75 f1                	jne    8012bc <strlen+0xf>
		n++;
	return n;
  8012cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012ce:	c9                   	leave  
  8012cf:	c3                   	ret    

008012d0 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8012d0:	55                   	push   %ebp
  8012d1:	89 e5                	mov    %esp,%ebp
  8012d3:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8012dd:	eb 09                	jmp    8012e8 <strnlen+0x18>
		n++;
  8012df:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8012e2:	ff 45 08             	incl   0x8(%ebp)
  8012e5:	ff 4d 0c             	decl   0xc(%ebp)
  8012e8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8012ec:	74 09                	je     8012f7 <strnlen+0x27>
  8012ee:	8b 45 08             	mov    0x8(%ebp),%eax
  8012f1:	8a 00                	mov    (%eax),%al
  8012f3:	84 c0                	test   %al,%al
  8012f5:	75 e8                	jne    8012df <strnlen+0xf>
		n++;
	return n;
  8012f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8012fa:	c9                   	leave  
  8012fb:	c3                   	ret    

008012fc <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8012fc:	55                   	push   %ebp
  8012fd:	89 e5                	mov    %esp,%ebp
  8012ff:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801302:	8b 45 08             	mov    0x8(%ebp),%eax
  801305:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801308:	90                   	nop
  801309:	8b 45 08             	mov    0x8(%ebp),%eax
  80130c:	8d 50 01             	lea    0x1(%eax),%edx
  80130f:	89 55 08             	mov    %edx,0x8(%ebp)
  801312:	8b 55 0c             	mov    0xc(%ebp),%edx
  801315:	8d 4a 01             	lea    0x1(%edx),%ecx
  801318:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80131b:	8a 12                	mov    (%edx),%dl
  80131d:	88 10                	mov    %dl,(%eax)
  80131f:	8a 00                	mov    (%eax),%al
  801321:	84 c0                	test   %al,%al
  801323:	75 e4                	jne    801309 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801325:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801328:	c9                   	leave  
  801329:	c3                   	ret    

0080132a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80132a:	55                   	push   %ebp
  80132b:	89 e5                	mov    %esp,%ebp
  80132d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801330:	8b 45 08             	mov    0x8(%ebp),%eax
  801333:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801336:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80133d:	eb 1f                	jmp    80135e <strncpy+0x34>
		*dst++ = *src;
  80133f:	8b 45 08             	mov    0x8(%ebp),%eax
  801342:	8d 50 01             	lea    0x1(%eax),%edx
  801345:	89 55 08             	mov    %edx,0x8(%ebp)
  801348:	8b 55 0c             	mov    0xc(%ebp),%edx
  80134b:	8a 12                	mov    (%edx),%dl
  80134d:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  80134f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801352:	8a 00                	mov    (%eax),%al
  801354:	84 c0                	test   %al,%al
  801356:	74 03                	je     80135b <strncpy+0x31>
			src++;
  801358:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80135b:	ff 45 fc             	incl   -0x4(%ebp)
  80135e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801361:	3b 45 10             	cmp    0x10(%ebp),%eax
  801364:	72 d9                	jb     80133f <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801366:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801369:	c9                   	leave  
  80136a:	c3                   	ret    

0080136b <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80136b:	55                   	push   %ebp
  80136c:	89 e5                	mov    %esp,%ebp
  80136e:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801371:	8b 45 08             	mov    0x8(%ebp),%eax
  801374:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801377:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80137b:	74 30                	je     8013ad <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80137d:	eb 16                	jmp    801395 <strlcpy+0x2a>
			*dst++ = *src++;
  80137f:	8b 45 08             	mov    0x8(%ebp),%eax
  801382:	8d 50 01             	lea    0x1(%eax),%edx
  801385:	89 55 08             	mov    %edx,0x8(%ebp)
  801388:	8b 55 0c             	mov    0xc(%ebp),%edx
  80138b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80138e:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801391:	8a 12                	mov    (%edx),%dl
  801393:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801395:	ff 4d 10             	decl   0x10(%ebp)
  801398:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80139c:	74 09                	je     8013a7 <strlcpy+0x3c>
  80139e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013a1:	8a 00                	mov    (%eax),%al
  8013a3:	84 c0                	test   %al,%al
  8013a5:	75 d8                	jne    80137f <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8013a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8013aa:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8013ad:	8b 55 08             	mov    0x8(%ebp),%edx
  8013b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013b3:	29 c2                	sub    %eax,%edx
  8013b5:	89 d0                	mov    %edx,%eax
}
  8013b7:	c9                   	leave  
  8013b8:	c3                   	ret    

008013b9 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8013b9:	55                   	push   %ebp
  8013ba:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8013bc:	eb 06                	jmp    8013c4 <strcmp+0xb>
		p++, q++;
  8013be:	ff 45 08             	incl   0x8(%ebp)
  8013c1:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8013c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c7:	8a 00                	mov    (%eax),%al
  8013c9:	84 c0                	test   %al,%al
  8013cb:	74 0e                	je     8013db <strcmp+0x22>
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8a 10                	mov    (%eax),%dl
  8013d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013d5:	8a 00                	mov    (%eax),%al
  8013d7:	38 c2                	cmp    %al,%dl
  8013d9:	74 e3                	je     8013be <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8013db:	8b 45 08             	mov    0x8(%ebp),%eax
  8013de:	8a 00                	mov    (%eax),%al
  8013e0:	0f b6 d0             	movzbl %al,%edx
  8013e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013e6:	8a 00                	mov    (%eax),%al
  8013e8:	0f b6 c0             	movzbl %al,%eax
  8013eb:	29 c2                	sub    %eax,%edx
  8013ed:	89 d0                	mov    %edx,%eax
}
  8013ef:	5d                   	pop    %ebp
  8013f0:	c3                   	ret    

008013f1 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8013f4:	eb 09                	jmp    8013ff <strncmp+0xe>
		n--, p++, q++;
  8013f6:	ff 4d 10             	decl   0x10(%ebp)
  8013f9:	ff 45 08             	incl   0x8(%ebp)
  8013fc:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8013ff:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801403:	74 17                	je     80141c <strncmp+0x2b>
  801405:	8b 45 08             	mov    0x8(%ebp),%eax
  801408:	8a 00                	mov    (%eax),%al
  80140a:	84 c0                	test   %al,%al
  80140c:	74 0e                	je     80141c <strncmp+0x2b>
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 10                	mov    (%eax),%dl
  801413:	8b 45 0c             	mov    0xc(%ebp),%eax
  801416:	8a 00                	mov    (%eax),%al
  801418:	38 c2                	cmp    %al,%dl
  80141a:	74 da                	je     8013f6 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80141c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801420:	75 07                	jne    801429 <strncmp+0x38>
		return 0;
  801422:	b8 00 00 00 00       	mov    $0x0,%eax
  801427:	eb 14                	jmp    80143d <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801429:	8b 45 08             	mov    0x8(%ebp),%eax
  80142c:	8a 00                	mov    (%eax),%al
  80142e:	0f b6 d0             	movzbl %al,%edx
  801431:	8b 45 0c             	mov    0xc(%ebp),%eax
  801434:	8a 00                	mov    (%eax),%al
  801436:	0f b6 c0             	movzbl %al,%eax
  801439:	29 c2                	sub    %eax,%edx
  80143b:	89 d0                	mov    %edx,%eax
}
  80143d:	5d                   	pop    %ebp
  80143e:	c3                   	ret    

0080143f <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
  801442:	83 ec 04             	sub    $0x4,%esp
  801445:	8b 45 0c             	mov    0xc(%ebp),%eax
  801448:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80144b:	eb 12                	jmp    80145f <strchr+0x20>
		if (*s == c)
  80144d:	8b 45 08             	mov    0x8(%ebp),%eax
  801450:	8a 00                	mov    (%eax),%al
  801452:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801455:	75 05                	jne    80145c <strchr+0x1d>
			return (char *) s;
  801457:	8b 45 08             	mov    0x8(%ebp),%eax
  80145a:	eb 11                	jmp    80146d <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80145c:	ff 45 08             	incl   0x8(%ebp)
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	84 c0                	test   %al,%al
  801466:	75 e5                	jne    80144d <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801468:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80146d:	c9                   	leave  
  80146e:	c3                   	ret    

0080146f <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  80146f:	55                   	push   %ebp
  801470:	89 e5                	mov    %esp,%ebp
  801472:	83 ec 04             	sub    $0x4,%esp
  801475:	8b 45 0c             	mov    0xc(%ebp),%eax
  801478:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80147b:	eb 0d                	jmp    80148a <strfind+0x1b>
		if (*s == c)
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801485:	74 0e                	je     801495 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801487:	ff 45 08             	incl   0x8(%ebp)
  80148a:	8b 45 08             	mov    0x8(%ebp),%eax
  80148d:	8a 00                	mov    (%eax),%al
  80148f:	84 c0                	test   %al,%al
  801491:	75 ea                	jne    80147d <strfind+0xe>
  801493:	eb 01                	jmp    801496 <strfind+0x27>
		if (*s == c)
			break;
  801495:	90                   	nop
	return (char *) s;
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801499:	c9                   	leave  
  80149a:	c3                   	ret    

0080149b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80149b:	55                   	push   %ebp
  80149c:	89 e5                	mov    %esp,%ebp
  80149e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8014a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8014a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8014aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8014ad:	eb 0e                	jmp    8014bd <memset+0x22>
		*p++ = c;
  8014af:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b2:	8d 50 01             	lea    0x1(%eax),%edx
  8014b5:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8014b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bb:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8014bd:	ff 4d f8             	decl   -0x8(%ebp)
  8014c0:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8014c4:	79 e9                	jns    8014af <memset+0x14>
		*p++ = c;

	return v;
  8014c6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8014c9:	c9                   	leave  
  8014ca:	c3                   	ret    

008014cb <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8014cb:	55                   	push   %ebp
  8014cc:	89 e5                	mov    %esp,%ebp
  8014ce:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8014d1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014d4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8014d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014da:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8014dd:	eb 16                	jmp    8014f5 <memcpy+0x2a>
		*d++ = *s++;
  8014df:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014e2:	8d 50 01             	lea    0x1(%eax),%edx
  8014e5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8014e8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8014eb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ee:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8014f1:	8a 12                	mov    (%edx),%dl
  8014f3:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8014f5:	8b 45 10             	mov    0x10(%ebp),%eax
  8014f8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8014fb:	89 55 10             	mov    %edx,0x10(%ebp)
  8014fe:	85 c0                	test   %eax,%eax
  801500:	75 dd                	jne    8014df <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801502:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801505:	c9                   	leave  
  801506:	c3                   	ret    

00801507 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801507:	55                   	push   %ebp
  801508:	89 e5                	mov    %esp,%ebp
  80150a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80150d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801510:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
  801516:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801519:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80151c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80151f:	73 50                	jae    801571 <memmove+0x6a>
  801521:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801524:	8b 45 10             	mov    0x10(%ebp),%eax
  801527:	01 d0                	add    %edx,%eax
  801529:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80152c:	76 43                	jbe    801571 <memmove+0x6a>
		s += n;
  80152e:	8b 45 10             	mov    0x10(%ebp),%eax
  801531:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801534:	8b 45 10             	mov    0x10(%ebp),%eax
  801537:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80153a:	eb 10                	jmp    80154c <memmove+0x45>
			*--d = *--s;
  80153c:	ff 4d f8             	decl   -0x8(%ebp)
  80153f:	ff 4d fc             	decl   -0x4(%ebp)
  801542:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801545:	8a 10                	mov    (%eax),%dl
  801547:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80154a:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80154c:	8b 45 10             	mov    0x10(%ebp),%eax
  80154f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801552:	89 55 10             	mov    %edx,0x10(%ebp)
  801555:	85 c0                	test   %eax,%eax
  801557:	75 e3                	jne    80153c <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801559:	eb 23                	jmp    80157e <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80155b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80155e:	8d 50 01             	lea    0x1(%eax),%edx
  801561:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801564:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801567:	8d 4a 01             	lea    0x1(%edx),%ecx
  80156a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80156d:	8a 12                	mov    (%edx),%dl
  80156f:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801571:	8b 45 10             	mov    0x10(%ebp),%eax
  801574:	8d 50 ff             	lea    -0x1(%eax),%edx
  801577:	89 55 10             	mov    %edx,0x10(%ebp)
  80157a:	85 c0                	test   %eax,%eax
  80157c:	75 dd                	jne    80155b <memmove+0x54>
			*d++ = *s++;

	return dst;
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801581:	c9                   	leave  
  801582:	c3                   	ret    

00801583 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801583:	55                   	push   %ebp
  801584:	89 e5                	mov    %esp,%ebp
  801586:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801589:	8b 45 08             	mov    0x8(%ebp),%eax
  80158c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  80158f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801592:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801595:	eb 2a                	jmp    8015c1 <memcmp+0x3e>
		if (*s1 != *s2)
  801597:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80159a:	8a 10                	mov    (%eax),%dl
  80159c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80159f:	8a 00                	mov    (%eax),%al
  8015a1:	38 c2                	cmp    %al,%dl
  8015a3:	74 16                	je     8015bb <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8015a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015a8:	8a 00                	mov    (%eax),%al
  8015aa:	0f b6 d0             	movzbl %al,%edx
  8015ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015b0:	8a 00                	mov    (%eax),%al
  8015b2:	0f b6 c0             	movzbl %al,%eax
  8015b5:	29 c2                	sub    %eax,%edx
  8015b7:	89 d0                	mov    %edx,%eax
  8015b9:	eb 18                	jmp    8015d3 <memcmp+0x50>
		s1++, s2++;
  8015bb:	ff 45 fc             	incl   -0x4(%ebp)
  8015be:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8015c1:	8b 45 10             	mov    0x10(%ebp),%eax
  8015c4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8015c7:	89 55 10             	mov    %edx,0x10(%ebp)
  8015ca:	85 c0                	test   %eax,%eax
  8015cc:	75 c9                	jne    801597 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8015ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015d3:	c9                   	leave  
  8015d4:	c3                   	ret    

008015d5 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8015d5:	55                   	push   %ebp
  8015d6:	89 e5                	mov    %esp,%ebp
  8015d8:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8015db:	8b 55 08             	mov    0x8(%ebp),%edx
  8015de:	8b 45 10             	mov    0x10(%ebp),%eax
  8015e1:	01 d0                	add    %edx,%eax
  8015e3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8015e6:	eb 15                	jmp    8015fd <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	8a 00                	mov    (%eax),%al
  8015ed:	0f b6 d0             	movzbl %al,%edx
  8015f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015f3:	0f b6 c0             	movzbl %al,%eax
  8015f6:	39 c2                	cmp    %eax,%edx
  8015f8:	74 0d                	je     801607 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8015fa:	ff 45 08             	incl   0x8(%ebp)
  8015fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801600:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801603:	72 e3                	jb     8015e8 <memfind+0x13>
  801605:	eb 01                	jmp    801608 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801607:	90                   	nop
	return (void *) s;
  801608:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80160b:	c9                   	leave  
  80160c:	c3                   	ret    

0080160d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80160d:	55                   	push   %ebp
  80160e:	89 e5                	mov    %esp,%ebp
  801610:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801613:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80161a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801621:	eb 03                	jmp    801626 <strtol+0x19>
		s++;
  801623:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801626:	8b 45 08             	mov    0x8(%ebp),%eax
  801629:	8a 00                	mov    (%eax),%al
  80162b:	3c 20                	cmp    $0x20,%al
  80162d:	74 f4                	je     801623 <strtol+0x16>
  80162f:	8b 45 08             	mov    0x8(%ebp),%eax
  801632:	8a 00                	mov    (%eax),%al
  801634:	3c 09                	cmp    $0x9,%al
  801636:	74 eb                	je     801623 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801638:	8b 45 08             	mov    0x8(%ebp),%eax
  80163b:	8a 00                	mov    (%eax),%al
  80163d:	3c 2b                	cmp    $0x2b,%al
  80163f:	75 05                	jne    801646 <strtol+0x39>
		s++;
  801641:	ff 45 08             	incl   0x8(%ebp)
  801644:	eb 13                	jmp    801659 <strtol+0x4c>
	else if (*s == '-')
  801646:	8b 45 08             	mov    0x8(%ebp),%eax
  801649:	8a 00                	mov    (%eax),%al
  80164b:	3c 2d                	cmp    $0x2d,%al
  80164d:	75 0a                	jne    801659 <strtol+0x4c>
		s++, neg = 1;
  80164f:	ff 45 08             	incl   0x8(%ebp)
  801652:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801659:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80165d:	74 06                	je     801665 <strtol+0x58>
  80165f:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801663:	75 20                	jne    801685 <strtol+0x78>
  801665:	8b 45 08             	mov    0x8(%ebp),%eax
  801668:	8a 00                	mov    (%eax),%al
  80166a:	3c 30                	cmp    $0x30,%al
  80166c:	75 17                	jne    801685 <strtol+0x78>
  80166e:	8b 45 08             	mov    0x8(%ebp),%eax
  801671:	40                   	inc    %eax
  801672:	8a 00                	mov    (%eax),%al
  801674:	3c 78                	cmp    $0x78,%al
  801676:	75 0d                	jne    801685 <strtol+0x78>
		s += 2, base = 16;
  801678:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80167c:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801683:	eb 28                	jmp    8016ad <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801685:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801689:	75 15                	jne    8016a0 <strtol+0x93>
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	8a 00                	mov    (%eax),%al
  801690:	3c 30                	cmp    $0x30,%al
  801692:	75 0c                	jne    8016a0 <strtol+0x93>
		s++, base = 8;
  801694:	ff 45 08             	incl   0x8(%ebp)
  801697:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80169e:	eb 0d                	jmp    8016ad <strtol+0xa0>
	else if (base == 0)
  8016a0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8016a4:	75 07                	jne    8016ad <strtol+0xa0>
		base = 10;
  8016a6:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8016ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b0:	8a 00                	mov    (%eax),%al
  8016b2:	3c 2f                	cmp    $0x2f,%al
  8016b4:	7e 19                	jle    8016cf <strtol+0xc2>
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	8a 00                	mov    (%eax),%al
  8016bb:	3c 39                	cmp    $0x39,%al
  8016bd:	7f 10                	jg     8016cf <strtol+0xc2>
			dig = *s - '0';
  8016bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016c2:	8a 00                	mov    (%eax),%al
  8016c4:	0f be c0             	movsbl %al,%eax
  8016c7:	83 e8 30             	sub    $0x30,%eax
  8016ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016cd:	eb 42                	jmp    801711 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8016cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8016d2:	8a 00                	mov    (%eax),%al
  8016d4:	3c 60                	cmp    $0x60,%al
  8016d6:	7e 19                	jle    8016f1 <strtol+0xe4>
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	8a 00                	mov    (%eax),%al
  8016dd:	3c 7a                	cmp    $0x7a,%al
  8016df:	7f 10                	jg     8016f1 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8016e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e4:	8a 00                	mov    (%eax),%al
  8016e6:	0f be c0             	movsbl %al,%eax
  8016e9:	83 e8 57             	sub    $0x57,%eax
  8016ec:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8016ef:	eb 20                	jmp    801711 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8016f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f4:	8a 00                	mov    (%eax),%al
  8016f6:	3c 40                	cmp    $0x40,%al
  8016f8:	7e 39                	jle    801733 <strtol+0x126>
  8016fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fd:	8a 00                	mov    (%eax),%al
  8016ff:	3c 5a                	cmp    $0x5a,%al
  801701:	7f 30                	jg     801733 <strtol+0x126>
			dig = *s - 'A' + 10;
  801703:	8b 45 08             	mov    0x8(%ebp),%eax
  801706:	8a 00                	mov    (%eax),%al
  801708:	0f be c0             	movsbl %al,%eax
  80170b:	83 e8 37             	sub    $0x37,%eax
  80170e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801711:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801714:	3b 45 10             	cmp    0x10(%ebp),%eax
  801717:	7d 19                	jge    801732 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801719:	ff 45 08             	incl   0x8(%ebp)
  80171c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801723:	89 c2                	mov    %eax,%edx
  801725:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801728:	01 d0                	add    %edx,%eax
  80172a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80172d:	e9 7b ff ff ff       	jmp    8016ad <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801732:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801733:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801737:	74 08                	je     801741 <strtol+0x134>
		*endptr = (char *) s;
  801739:	8b 45 0c             	mov    0xc(%ebp),%eax
  80173c:	8b 55 08             	mov    0x8(%ebp),%edx
  80173f:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801741:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801745:	74 07                	je     80174e <strtol+0x141>
  801747:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80174a:	f7 d8                	neg    %eax
  80174c:	eb 03                	jmp    801751 <strtol+0x144>
  80174e:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801751:	c9                   	leave  
  801752:	c3                   	ret    

00801753 <ltostr>:

void
ltostr(long value, char *str)
{
  801753:	55                   	push   %ebp
  801754:	89 e5                	mov    %esp,%ebp
  801756:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801759:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801760:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801767:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80176b:	79 13                	jns    801780 <ltostr+0x2d>
	{
		neg = 1;
  80176d:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801774:	8b 45 0c             	mov    0xc(%ebp),%eax
  801777:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80177a:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80177d:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801788:	99                   	cltd   
  801789:	f7 f9                	idiv   %ecx
  80178b:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80178e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801791:	8d 50 01             	lea    0x1(%eax),%edx
  801794:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801797:	89 c2                	mov    %eax,%edx
  801799:	8b 45 0c             	mov    0xc(%ebp),%eax
  80179c:	01 d0                	add    %edx,%eax
  80179e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8017a1:	83 c2 30             	add    $0x30,%edx
  8017a4:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8017a6:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017a9:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017ae:	f7 e9                	imul   %ecx
  8017b0:	c1 fa 02             	sar    $0x2,%edx
  8017b3:	89 c8                	mov    %ecx,%eax
  8017b5:	c1 f8 1f             	sar    $0x1f,%eax
  8017b8:	29 c2                	sub    %eax,%edx
  8017ba:	89 d0                	mov    %edx,%eax
  8017bc:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8017bf:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8017c2:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8017c7:	f7 e9                	imul   %ecx
  8017c9:	c1 fa 02             	sar    $0x2,%edx
  8017cc:	89 c8                	mov    %ecx,%eax
  8017ce:	c1 f8 1f             	sar    $0x1f,%eax
  8017d1:	29 c2                	sub    %eax,%edx
  8017d3:	89 d0                	mov    %edx,%eax
  8017d5:	c1 e0 02             	shl    $0x2,%eax
  8017d8:	01 d0                	add    %edx,%eax
  8017da:	01 c0                	add    %eax,%eax
  8017dc:	29 c1                	sub    %eax,%ecx
  8017de:	89 ca                	mov    %ecx,%edx
  8017e0:	85 d2                	test   %edx,%edx
  8017e2:	75 9c                	jne    801780 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8017e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8017eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017ee:	48                   	dec    %eax
  8017ef:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8017f2:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8017f6:	74 3d                	je     801835 <ltostr+0xe2>
		start = 1 ;
  8017f8:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8017ff:	eb 34                	jmp    801835 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801801:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801804:	8b 45 0c             	mov    0xc(%ebp),%eax
  801807:	01 d0                	add    %edx,%eax
  801809:	8a 00                	mov    (%eax),%al
  80180b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80180e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801811:	8b 45 0c             	mov    0xc(%ebp),%eax
  801814:	01 c2                	add    %eax,%edx
  801816:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801819:	8b 45 0c             	mov    0xc(%ebp),%eax
  80181c:	01 c8                	add    %ecx,%eax
  80181e:	8a 00                	mov    (%eax),%al
  801820:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801822:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801825:	8b 45 0c             	mov    0xc(%ebp),%eax
  801828:	01 c2                	add    %eax,%edx
  80182a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80182d:	88 02                	mov    %al,(%edx)
		start++ ;
  80182f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801832:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801835:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801838:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80183b:	7c c4                	jl     801801 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80183d:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801840:	8b 45 0c             	mov    0xc(%ebp),%eax
  801843:	01 d0                	add    %edx,%eax
  801845:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801848:	90                   	nop
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
  80184e:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801851:	ff 75 08             	pushl  0x8(%ebp)
  801854:	e8 54 fa ff ff       	call   8012ad <strlen>
  801859:	83 c4 04             	add    $0x4,%esp
  80185c:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80185f:	ff 75 0c             	pushl  0xc(%ebp)
  801862:	e8 46 fa ff ff       	call   8012ad <strlen>
  801867:	83 c4 04             	add    $0x4,%esp
  80186a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80186d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801874:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80187b:	eb 17                	jmp    801894 <strcconcat+0x49>
		final[s] = str1[s] ;
  80187d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801880:	8b 45 10             	mov    0x10(%ebp),%eax
  801883:	01 c2                	add    %eax,%edx
  801885:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801888:	8b 45 08             	mov    0x8(%ebp),%eax
  80188b:	01 c8                	add    %ecx,%eax
  80188d:	8a 00                	mov    (%eax),%al
  80188f:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801891:	ff 45 fc             	incl   -0x4(%ebp)
  801894:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801897:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80189a:	7c e1                	jl     80187d <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80189c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8018a3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8018aa:	eb 1f                	jmp    8018cb <strcconcat+0x80>
		final[s++] = str2[i] ;
  8018ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8018af:	8d 50 01             	lea    0x1(%eax),%edx
  8018b2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8018b5:	89 c2                	mov    %eax,%edx
  8018b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8018ba:	01 c2                	add    %eax,%edx
  8018bc:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8018bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018c2:	01 c8                	add    %ecx,%eax
  8018c4:	8a 00                	mov    (%eax),%al
  8018c6:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8018c8:	ff 45 f8             	incl   -0x8(%ebp)
  8018cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ce:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8018d1:	7c d9                	jl     8018ac <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8018d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018d6:	8b 45 10             	mov    0x10(%ebp),%eax
  8018d9:	01 d0                	add    %edx,%eax
  8018db:	c6 00 00             	movb   $0x0,(%eax)
}
  8018de:	90                   	nop
  8018df:	c9                   	leave  
  8018e0:	c3                   	ret    

008018e1 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8018e1:	55                   	push   %ebp
  8018e2:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8018e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8018e7:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8018ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8018f0:	8b 00                	mov    (%eax),%eax
  8018f2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018f9:	8b 45 10             	mov    0x10(%ebp),%eax
  8018fc:	01 d0                	add    %edx,%eax
  8018fe:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801904:	eb 0c                	jmp    801912 <strsplit+0x31>
			*string++ = 0;
  801906:	8b 45 08             	mov    0x8(%ebp),%eax
  801909:	8d 50 01             	lea    0x1(%eax),%edx
  80190c:	89 55 08             	mov    %edx,0x8(%ebp)
  80190f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801912:	8b 45 08             	mov    0x8(%ebp),%eax
  801915:	8a 00                	mov    (%eax),%al
  801917:	84 c0                	test   %al,%al
  801919:	74 18                	je     801933 <strsplit+0x52>
  80191b:	8b 45 08             	mov    0x8(%ebp),%eax
  80191e:	8a 00                	mov    (%eax),%al
  801920:	0f be c0             	movsbl %al,%eax
  801923:	50                   	push   %eax
  801924:	ff 75 0c             	pushl  0xc(%ebp)
  801927:	e8 13 fb ff ff       	call   80143f <strchr>
  80192c:	83 c4 08             	add    $0x8,%esp
  80192f:	85 c0                	test   %eax,%eax
  801931:	75 d3                	jne    801906 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801933:	8b 45 08             	mov    0x8(%ebp),%eax
  801936:	8a 00                	mov    (%eax),%al
  801938:	84 c0                	test   %al,%al
  80193a:	74 5a                	je     801996 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80193c:	8b 45 14             	mov    0x14(%ebp),%eax
  80193f:	8b 00                	mov    (%eax),%eax
  801941:	83 f8 0f             	cmp    $0xf,%eax
  801944:	75 07                	jne    80194d <strsplit+0x6c>
		{
			return 0;
  801946:	b8 00 00 00 00       	mov    $0x0,%eax
  80194b:	eb 66                	jmp    8019b3 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80194d:	8b 45 14             	mov    0x14(%ebp),%eax
  801950:	8b 00                	mov    (%eax),%eax
  801952:	8d 48 01             	lea    0x1(%eax),%ecx
  801955:	8b 55 14             	mov    0x14(%ebp),%edx
  801958:	89 0a                	mov    %ecx,(%edx)
  80195a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801961:	8b 45 10             	mov    0x10(%ebp),%eax
  801964:	01 c2                	add    %eax,%edx
  801966:	8b 45 08             	mov    0x8(%ebp),%eax
  801969:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  80196b:	eb 03                	jmp    801970 <strsplit+0x8f>
			string++;
  80196d:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801970:	8b 45 08             	mov    0x8(%ebp),%eax
  801973:	8a 00                	mov    (%eax),%al
  801975:	84 c0                	test   %al,%al
  801977:	74 8b                	je     801904 <strsplit+0x23>
  801979:	8b 45 08             	mov    0x8(%ebp),%eax
  80197c:	8a 00                	mov    (%eax),%al
  80197e:	0f be c0             	movsbl %al,%eax
  801981:	50                   	push   %eax
  801982:	ff 75 0c             	pushl  0xc(%ebp)
  801985:	e8 b5 fa ff ff       	call   80143f <strchr>
  80198a:	83 c4 08             	add    $0x8,%esp
  80198d:	85 c0                	test   %eax,%eax
  80198f:	74 dc                	je     80196d <strsplit+0x8c>
			string++;
	}
  801991:	e9 6e ff ff ff       	jmp    801904 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801996:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801997:	8b 45 14             	mov    0x14(%ebp),%eax
  80199a:	8b 00                	mov    (%eax),%eax
  80199c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8019a3:	8b 45 10             	mov    0x10(%ebp),%eax
  8019a6:	01 d0                	add    %edx,%eax
  8019a8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8019ae:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8019b3:	c9                   	leave  
  8019b4:	c3                   	ret    

008019b5 <ClearNodeData>:
 * inside the user heap
 */

struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  8019b5:	55                   	push   %ebp
  8019b6:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  8019b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019bb:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  8019bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c2:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  8019c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8019c9:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  8019d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8019d3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  8019da:	8b 45 08             	mov    0x8(%ebp),%eax
  8019dd:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  8019e4:	90                   	nop
  8019e5:	5d                   	pop    %ebp
  8019e6:	c3                   	ret    

008019e7 <initialize_buddy>:

void initialize_buddy()
{
  8019e7:	55                   	push   %ebp
  8019e8:	89 e5                	mov    %esp,%ebp
  8019ea:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  8019ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019f4:	e9 b7 00 00 00       	jmp    801ab0 <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  8019f9:	8b 15 04 31 80 00    	mov    0x803104,%edx
  8019ff:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a02:	89 c8                	mov    %ecx,%eax
  801a04:	01 c0                	add    %eax,%eax
  801a06:	01 c8                	add    %ecx,%eax
  801a08:	c1 e0 03             	shl    $0x3,%eax
  801a0b:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a10:	89 10                	mov    %edx,(%eax)
  801a12:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a15:	89 d0                	mov    %edx,%eax
  801a17:	01 c0                	add    %eax,%eax
  801a19:	01 d0                	add    %edx,%eax
  801a1b:	c1 e0 03             	shl    $0x3,%eax
  801a1e:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a23:	8b 00                	mov    (%eax),%eax
  801a25:	85 c0                	test   %eax,%eax
  801a27:	74 1c                	je     801a45 <initialize_buddy+0x5e>
  801a29:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801a2f:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a32:	89 c8                	mov    %ecx,%eax
  801a34:	01 c0                	add    %eax,%eax
  801a36:	01 c8                	add    %ecx,%eax
  801a38:	c1 e0 03             	shl    $0x3,%eax
  801a3b:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a40:	89 42 04             	mov    %eax,0x4(%edx)
  801a43:	eb 16                	jmp    801a5b <initialize_buddy+0x74>
  801a45:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a48:	89 d0                	mov    %edx,%eax
  801a4a:	01 c0                	add    %eax,%eax
  801a4c:	01 d0                	add    %edx,%eax
  801a4e:	c1 e0 03             	shl    $0x3,%eax
  801a51:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a56:	a3 08 31 80 00       	mov    %eax,0x803108
  801a5b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a5e:	89 d0                	mov    %edx,%eax
  801a60:	01 c0                	add    %eax,%eax
  801a62:	01 d0                	add    %edx,%eax
  801a64:	c1 e0 03             	shl    $0x3,%eax
  801a67:	05 1c 31 80 00       	add    $0x80311c,%eax
  801a6c:	a3 04 31 80 00       	mov    %eax,0x803104
  801a71:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a74:	89 d0                	mov    %edx,%eax
  801a76:	01 c0                	add    %eax,%eax
  801a78:	01 d0                	add    %edx,%eax
  801a7a:	c1 e0 03             	shl    $0x3,%eax
  801a7d:	05 20 31 80 00       	add    $0x803120,%eax
  801a82:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801a88:	a1 10 31 80 00       	mov    0x803110,%eax
  801a8d:	40                   	inc    %eax
  801a8e:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  801a93:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a96:	89 d0                	mov    %edx,%eax
  801a98:	01 c0                	add    %eax,%eax
  801a9a:	01 d0                	add    %edx,%eax
  801a9c:	c1 e0 03             	shl    $0x3,%eax
  801a9f:	05 1c 31 80 00       	add    $0x80311c,%eax
  801aa4:	50                   	push   %eax
  801aa5:	e8 0b ff ff ff       	call   8019b5 <ClearNodeData>
  801aaa:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801aad:	ff 45 fc             	incl   -0x4(%ebp)
  801ab0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801ab4:	0f 8e 3f ff ff ff    	jle    8019f9 <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801aba:	90                   	nop
  801abb:	c9                   	leave  
  801abc:	c3                   	ret    

00801abd <CreateNewBuddySpace>:

/*===============================================================*/

void CreateNewBuddySpace()
{
  801abd:	55                   	push   %ebp
  801abe:	89 e5                	mov    %esp,%ebp
  801ac0:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801ac3:	83 ec 04             	sub    $0x4,%esp
  801ac6:	68 c4 2b 80 00       	push   $0x802bc4
  801acb:	6a 1f                	push   $0x1f
  801acd:	68 f6 2b 80 00       	push   $0x802bf6
  801ad2:	e8 9a ec ff ff       	call   800771 <_panic>

00801ad7 <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801ad7:	55                   	push   %ebp
  801ad8:	89 e5                	mov    %esp,%ebp
  801ada:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  801add:	83 ec 04             	sub    $0x4,%esp
  801ae0:	68 04 2c 80 00       	push   $0x802c04
  801ae5:	6a 26                	push   $0x26
  801ae7:	68 f6 2b 80 00       	push   $0x802bf6
  801aec:	e8 80 ec ff ff       	call   800771 <_panic>

00801af1 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801af1:	55                   	push   %ebp
  801af2:	89 e5                	mov    %esp,%ebp
  801af4:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801af7:	83 ec 04             	sub    $0x4,%esp
  801afa:	68 3c 2c 80 00       	push   $0x802c3c
  801aff:	6a 2c                	push   $0x2c
  801b01:	68 f6 2b 80 00       	push   $0x802bf6
  801b06:	e8 66 ec ff ff       	call   800771 <_panic>

00801b0b <__new>:

}
/*===============================================================*/
void* lastAlloc = (void*) USER_HEAP_START ;
void* __new(uint32 size)
{
  801b0b:	55                   	push   %ebp
  801b0c:	89 e5                	mov    %esp,%ebp
  801b0e:	83 ec 18             	sub    $0x18,%esp
	void* va = lastAlloc;
  801b11:	a1 04 30 80 00       	mov    0x803004,%eax
  801b16:	89 45 f4             	mov    %eax,-0xc(%ebp)
	size = ROUNDUP(size, PAGE_SIZE) ;
  801b19:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
  801b20:	8b 55 08             	mov    0x8(%ebp),%edx
  801b23:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801b26:	01 d0                	add    %edx,%eax
  801b28:	48                   	dec    %eax
  801b29:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801b2c:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b2f:	ba 00 00 00 00       	mov    $0x0,%edx
  801b34:	f7 75 f0             	divl   -0x10(%ebp)
  801b37:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801b3a:	29 d0                	sub    %edx,%eax
  801b3c:	89 45 08             	mov    %eax,0x8(%ebp)
	sys_new((uint32)va, size) ;
  801b3f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801b42:	83 ec 08             	sub    $0x8,%esp
  801b45:	ff 75 08             	pushl  0x8(%ebp)
  801b48:	50                   	push   %eax
  801b49:	e8 75 06 00 00       	call   8021c3 <sys_new>
  801b4e:	83 c4 10             	add    $0x10,%esp
	lastAlloc += size ;
  801b51:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801b57:	8b 45 08             	mov    0x8(%ebp),%eax
  801b5a:	01 d0                	add    %edx,%eax
  801b5c:	a3 04 30 80 00       	mov    %eax,0x803004
	return va ;
  801b61:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801b64:	c9                   	leave  
  801b65:	c3                   	ret    

00801b66 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801b66:	55                   	push   %ebp
  801b67:	89 e5                	mov    %esp,%ebp
  801b69:	57                   	push   %edi
  801b6a:	56                   	push   %esi
  801b6b:	53                   	push   %ebx
  801b6c:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801b72:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b75:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b78:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b7b:	8b 7d 18             	mov    0x18(%ebp),%edi
  801b7e:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801b81:	cd 30                	int    $0x30
  801b83:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801b86:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801b89:	83 c4 10             	add    $0x10,%esp
  801b8c:	5b                   	pop    %ebx
  801b8d:	5e                   	pop    %esi
  801b8e:	5f                   	pop    %edi
  801b8f:	5d                   	pop    %ebp
  801b90:	c3                   	ret    

00801b91 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
  801b94:	83 ec 04             	sub    $0x4,%esp
  801b97:	8b 45 10             	mov    0x10(%ebp),%eax
  801b9a:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801b9d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba4:	6a 00                	push   $0x0
  801ba6:	6a 00                	push   $0x0
  801ba8:	52                   	push   %edx
  801ba9:	ff 75 0c             	pushl  0xc(%ebp)
  801bac:	50                   	push   %eax
  801bad:	6a 00                	push   $0x0
  801baf:	e8 b2 ff ff ff       	call   801b66 <syscall>
  801bb4:	83 c4 18             	add    $0x18,%esp
}
  801bb7:	90                   	nop
  801bb8:	c9                   	leave  
  801bb9:	c3                   	ret    

00801bba <sys_cgetc>:

int
sys_cgetc(void)
{
  801bba:	55                   	push   %ebp
  801bbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801bbd:	6a 00                	push   $0x0
  801bbf:	6a 00                	push   $0x0
  801bc1:	6a 00                	push   $0x0
  801bc3:	6a 00                	push   $0x0
  801bc5:	6a 00                	push   $0x0
  801bc7:	6a 01                	push   $0x1
  801bc9:	e8 98 ff ff ff       	call   801b66 <syscall>
  801bce:	83 c4 18             	add    $0x18,%esp
}
  801bd1:	c9                   	leave  
  801bd2:	c3                   	ret    

00801bd3 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801bd3:	55                   	push   %ebp
  801bd4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801bd6:	8b 45 08             	mov    0x8(%ebp),%eax
  801bd9:	6a 00                	push   $0x0
  801bdb:	6a 00                	push   $0x0
  801bdd:	6a 00                	push   $0x0
  801bdf:	6a 00                	push   $0x0
  801be1:	50                   	push   %eax
  801be2:	6a 05                	push   $0x5
  801be4:	e8 7d ff ff ff       	call   801b66 <syscall>
  801be9:	83 c4 18             	add    $0x18,%esp
}
  801bec:	c9                   	leave  
  801bed:	c3                   	ret    

00801bee <sys_getenvid>:

int32 sys_getenvid(void)
{
  801bee:	55                   	push   %ebp
  801bef:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801bf1:	6a 00                	push   $0x0
  801bf3:	6a 00                	push   $0x0
  801bf5:	6a 00                	push   $0x0
  801bf7:	6a 00                	push   $0x0
  801bf9:	6a 00                	push   $0x0
  801bfb:	6a 02                	push   $0x2
  801bfd:	e8 64 ff ff ff       	call   801b66 <syscall>
  801c02:	83 c4 18             	add    $0x18,%esp
}
  801c05:	c9                   	leave  
  801c06:	c3                   	ret    

00801c07 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c07:	55                   	push   %ebp
  801c08:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c0a:	6a 00                	push   $0x0
  801c0c:	6a 00                	push   $0x0
  801c0e:	6a 00                	push   $0x0
  801c10:	6a 00                	push   $0x0
  801c12:	6a 00                	push   $0x0
  801c14:	6a 03                	push   $0x3
  801c16:	e8 4b ff ff ff       	call   801b66 <syscall>
  801c1b:	83 c4 18             	add    $0x18,%esp
}
  801c1e:	c9                   	leave  
  801c1f:	c3                   	ret    

00801c20 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801c20:	55                   	push   %ebp
  801c21:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801c23:	6a 00                	push   $0x0
  801c25:	6a 00                	push   $0x0
  801c27:	6a 00                	push   $0x0
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 04                	push   $0x4
  801c2f:	e8 32 ff ff ff       	call   801b66 <syscall>
  801c34:	83 c4 18             	add    $0x18,%esp
}
  801c37:	c9                   	leave  
  801c38:	c3                   	ret    

00801c39 <sys_env_exit>:


void sys_env_exit(void)
{
  801c39:	55                   	push   %ebp
  801c3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801c3c:	6a 00                	push   $0x0
  801c3e:	6a 00                	push   $0x0
  801c40:	6a 00                	push   $0x0
  801c42:	6a 00                	push   $0x0
  801c44:	6a 00                	push   $0x0
  801c46:	6a 06                	push   $0x6
  801c48:	e8 19 ff ff ff       	call   801b66 <syscall>
  801c4d:	83 c4 18             	add    $0x18,%esp
}
  801c50:	90                   	nop
  801c51:	c9                   	leave  
  801c52:	c3                   	ret    

00801c53 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801c53:	55                   	push   %ebp
  801c54:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801c56:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c59:	8b 45 08             	mov    0x8(%ebp),%eax
  801c5c:	6a 00                	push   $0x0
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	52                   	push   %edx
  801c63:	50                   	push   %eax
  801c64:	6a 07                	push   $0x7
  801c66:	e8 fb fe ff ff       	call   801b66 <syscall>
  801c6b:	83 c4 18             	add    $0x18,%esp
}
  801c6e:	c9                   	leave  
  801c6f:	c3                   	ret    

00801c70 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801c70:	55                   	push   %ebp
  801c71:	89 e5                	mov    %esp,%ebp
  801c73:	56                   	push   %esi
  801c74:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801c75:	8b 75 18             	mov    0x18(%ebp),%esi
  801c78:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c7b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c7e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c81:	8b 45 08             	mov    0x8(%ebp),%eax
  801c84:	56                   	push   %esi
  801c85:	53                   	push   %ebx
  801c86:	51                   	push   %ecx
  801c87:	52                   	push   %edx
  801c88:	50                   	push   %eax
  801c89:	6a 08                	push   $0x8
  801c8b:	e8 d6 fe ff ff       	call   801b66 <syscall>
  801c90:	83 c4 18             	add    $0x18,%esp
}
  801c93:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801c96:	5b                   	pop    %ebx
  801c97:	5e                   	pop    %esi
  801c98:	5d                   	pop    %ebp
  801c99:	c3                   	ret    

00801c9a <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801c9d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ca0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 00                	push   $0x0
  801ca9:	52                   	push   %edx
  801caa:	50                   	push   %eax
  801cab:	6a 09                	push   $0x9
  801cad:	e8 b4 fe ff ff       	call   801b66 <syscall>
  801cb2:	83 c4 18             	add    $0x18,%esp
}
  801cb5:	c9                   	leave  
  801cb6:	c3                   	ret    

00801cb7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801cb7:	55                   	push   %ebp
  801cb8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	ff 75 0c             	pushl  0xc(%ebp)
  801cc3:	ff 75 08             	pushl  0x8(%ebp)
  801cc6:	6a 0a                	push   $0xa
  801cc8:	e8 99 fe ff ff       	call   801b66 <syscall>
  801ccd:	83 c4 18             	add    $0x18,%esp
}
  801cd0:	c9                   	leave  
  801cd1:	c3                   	ret    

00801cd2 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801cd2:	55                   	push   %ebp
  801cd3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 00                	push   $0x0
  801cdb:	6a 00                	push   $0x0
  801cdd:	6a 00                	push   $0x0
  801cdf:	6a 0b                	push   $0xb
  801ce1:	e8 80 fe ff ff       	call   801b66 <syscall>
  801ce6:	83 c4 18             	add    $0x18,%esp
}
  801ce9:	c9                   	leave  
  801cea:	c3                   	ret    

00801ceb <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ceb:	55                   	push   %ebp
  801cec:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801cee:	6a 00                	push   $0x0
  801cf0:	6a 00                	push   $0x0
  801cf2:	6a 00                	push   $0x0
  801cf4:	6a 00                	push   $0x0
  801cf6:	6a 00                	push   $0x0
  801cf8:	6a 0c                	push   $0xc
  801cfa:	e8 67 fe ff ff       	call   801b66 <syscall>
  801cff:	83 c4 18             	add    $0x18,%esp
}
  801d02:	c9                   	leave  
  801d03:	c3                   	ret    

00801d04 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d04:	55                   	push   %ebp
  801d05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d07:	6a 00                	push   $0x0
  801d09:	6a 00                	push   $0x0
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 0d                	push   $0xd
  801d13:	e8 4e fe ff ff       	call   801b66 <syscall>
  801d18:	83 c4 18             	add    $0x18,%esp
}
  801d1b:	c9                   	leave  
  801d1c:	c3                   	ret    

00801d1d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801d1d:	55                   	push   %ebp
  801d1e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801d20:	6a 00                	push   $0x0
  801d22:	6a 00                	push   $0x0
  801d24:	6a 00                	push   $0x0
  801d26:	ff 75 0c             	pushl  0xc(%ebp)
  801d29:	ff 75 08             	pushl  0x8(%ebp)
  801d2c:	6a 11                	push   $0x11
  801d2e:	e8 33 fe ff ff       	call   801b66 <syscall>
  801d33:	83 c4 18             	add    $0x18,%esp
	return;
  801d36:	90                   	nop
}
  801d37:	c9                   	leave  
  801d38:	c3                   	ret    

00801d39 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801d39:	55                   	push   %ebp
  801d3a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801d3c:	6a 00                	push   $0x0
  801d3e:	6a 00                	push   $0x0
  801d40:	6a 00                	push   $0x0
  801d42:	ff 75 0c             	pushl  0xc(%ebp)
  801d45:	ff 75 08             	pushl  0x8(%ebp)
  801d48:	6a 12                	push   $0x12
  801d4a:	e8 17 fe ff ff       	call   801b66 <syscall>
  801d4f:	83 c4 18             	add    $0x18,%esp
	return ;
  801d52:	90                   	nop
}
  801d53:	c9                   	leave  
  801d54:	c3                   	ret    

00801d55 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801d55:	55                   	push   %ebp
  801d56:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801d58:	6a 00                	push   $0x0
  801d5a:	6a 00                	push   $0x0
  801d5c:	6a 00                	push   $0x0
  801d5e:	6a 00                	push   $0x0
  801d60:	6a 00                	push   $0x0
  801d62:	6a 0e                	push   $0xe
  801d64:	e8 fd fd ff ff       	call   801b66 <syscall>
  801d69:	83 c4 18             	add    $0x18,%esp
}
  801d6c:	c9                   	leave  
  801d6d:	c3                   	ret    

00801d6e <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801d6e:	55                   	push   %ebp
  801d6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801d71:	6a 00                	push   $0x0
  801d73:	6a 00                	push   $0x0
  801d75:	6a 00                	push   $0x0
  801d77:	6a 00                	push   $0x0
  801d79:	ff 75 08             	pushl  0x8(%ebp)
  801d7c:	6a 0f                	push   $0xf
  801d7e:	e8 e3 fd ff ff       	call   801b66 <syscall>
  801d83:	83 c4 18             	add    $0x18,%esp
}
  801d86:	c9                   	leave  
  801d87:	c3                   	ret    

00801d88 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801d88:	55                   	push   %ebp
  801d89:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801d8b:	6a 00                	push   $0x0
  801d8d:	6a 00                	push   $0x0
  801d8f:	6a 00                	push   $0x0
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 10                	push   $0x10
  801d97:	e8 ca fd ff ff       	call   801b66 <syscall>
  801d9c:	83 c4 18             	add    $0x18,%esp
}
  801d9f:	90                   	nop
  801da0:	c9                   	leave  
  801da1:	c3                   	ret    

00801da2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801da2:	55                   	push   %ebp
  801da3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801da5:	6a 00                	push   $0x0
  801da7:	6a 00                	push   $0x0
  801da9:	6a 00                	push   $0x0
  801dab:	6a 00                	push   $0x0
  801dad:	6a 00                	push   $0x0
  801daf:	6a 14                	push   $0x14
  801db1:	e8 b0 fd ff ff       	call   801b66 <syscall>
  801db6:	83 c4 18             	add    $0x18,%esp
}
  801db9:	90                   	nop
  801dba:	c9                   	leave  
  801dbb:	c3                   	ret    

00801dbc <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801dbc:	55                   	push   %ebp
  801dbd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801dbf:	6a 00                	push   $0x0
  801dc1:	6a 00                	push   $0x0
  801dc3:	6a 00                	push   $0x0
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 15                	push   $0x15
  801dcb:	e8 96 fd ff ff       	call   801b66 <syscall>
  801dd0:	83 c4 18             	add    $0x18,%esp
}
  801dd3:	90                   	nop
  801dd4:	c9                   	leave  
  801dd5:	c3                   	ret    

00801dd6 <sys_cputc>:


void
sys_cputc(const char c)
{
  801dd6:	55                   	push   %ebp
  801dd7:	89 e5                	mov    %esp,%ebp
  801dd9:	83 ec 04             	sub    $0x4,%esp
  801ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  801ddf:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801de2:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801de6:	6a 00                	push   $0x0
  801de8:	6a 00                	push   $0x0
  801dea:	6a 00                	push   $0x0
  801dec:	6a 00                	push   $0x0
  801dee:	50                   	push   %eax
  801def:	6a 16                	push   $0x16
  801df1:	e8 70 fd ff ff       	call   801b66 <syscall>
  801df6:	83 c4 18             	add    $0x18,%esp
}
  801df9:	90                   	nop
  801dfa:	c9                   	leave  
  801dfb:	c3                   	ret    

00801dfc <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801dfc:	55                   	push   %ebp
  801dfd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801dff:	6a 00                	push   $0x0
  801e01:	6a 00                	push   $0x0
  801e03:	6a 00                	push   $0x0
  801e05:	6a 00                	push   $0x0
  801e07:	6a 00                	push   $0x0
  801e09:	6a 17                	push   $0x17
  801e0b:	e8 56 fd ff ff       	call   801b66 <syscall>
  801e10:	83 c4 18             	add    $0x18,%esp
}
  801e13:	90                   	nop
  801e14:	c9                   	leave  
  801e15:	c3                   	ret    

00801e16 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801e16:	55                   	push   %ebp
  801e17:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801e19:	8b 45 08             	mov    0x8(%ebp),%eax
  801e1c:	6a 00                	push   $0x0
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	ff 75 0c             	pushl  0xc(%ebp)
  801e25:	50                   	push   %eax
  801e26:	6a 18                	push   $0x18
  801e28:	e8 39 fd ff ff       	call   801b66 <syscall>
  801e2d:	83 c4 18             	add    $0x18,%esp
}
  801e30:	c9                   	leave  
  801e31:	c3                   	ret    

00801e32 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801e32:	55                   	push   %ebp
  801e33:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e35:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e38:	8b 45 08             	mov    0x8(%ebp),%eax
  801e3b:	6a 00                	push   $0x0
  801e3d:	6a 00                	push   $0x0
  801e3f:	6a 00                	push   $0x0
  801e41:	52                   	push   %edx
  801e42:	50                   	push   %eax
  801e43:	6a 1b                	push   $0x1b
  801e45:	e8 1c fd ff ff       	call   801b66 <syscall>
  801e4a:	83 c4 18             	add    $0x18,%esp
}
  801e4d:	c9                   	leave  
  801e4e:	c3                   	ret    

00801e4f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e4f:	55                   	push   %ebp
  801e50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e55:	8b 45 08             	mov    0x8(%ebp),%eax
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	52                   	push   %edx
  801e5f:	50                   	push   %eax
  801e60:	6a 19                	push   $0x19
  801e62:	e8 ff fc ff ff       	call   801b66 <syscall>
  801e67:	83 c4 18             	add    $0x18,%esp
}
  801e6a:	90                   	nop
  801e6b:	c9                   	leave  
  801e6c:	c3                   	ret    

00801e6d <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801e6d:	55                   	push   %ebp
  801e6e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801e70:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e73:	8b 45 08             	mov    0x8(%ebp),%eax
  801e76:	6a 00                	push   $0x0
  801e78:	6a 00                	push   $0x0
  801e7a:	6a 00                	push   $0x0
  801e7c:	52                   	push   %edx
  801e7d:	50                   	push   %eax
  801e7e:	6a 1a                	push   $0x1a
  801e80:	e8 e1 fc ff ff       	call   801b66 <syscall>
  801e85:	83 c4 18             	add    $0x18,%esp
}
  801e88:	90                   	nop
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
  801e8e:	83 ec 04             	sub    $0x4,%esp
  801e91:	8b 45 10             	mov    0x10(%ebp),%eax
  801e94:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801e97:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801e9a:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801e9e:	8b 45 08             	mov    0x8(%ebp),%eax
  801ea1:	6a 00                	push   $0x0
  801ea3:	51                   	push   %ecx
  801ea4:	52                   	push   %edx
  801ea5:	ff 75 0c             	pushl  0xc(%ebp)
  801ea8:	50                   	push   %eax
  801ea9:	6a 1c                	push   $0x1c
  801eab:	e8 b6 fc ff ff       	call   801b66 <syscall>
  801eb0:	83 c4 18             	add    $0x18,%esp
}
  801eb3:	c9                   	leave  
  801eb4:	c3                   	ret    

00801eb5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801eb5:	55                   	push   %ebp
  801eb6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801eb8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ebb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ebe:	6a 00                	push   $0x0
  801ec0:	6a 00                	push   $0x0
  801ec2:	6a 00                	push   $0x0
  801ec4:	52                   	push   %edx
  801ec5:	50                   	push   %eax
  801ec6:	6a 1d                	push   $0x1d
  801ec8:	e8 99 fc ff ff       	call   801b66 <syscall>
  801ecd:	83 c4 18             	add    $0x18,%esp
}
  801ed0:	c9                   	leave  
  801ed1:	c3                   	ret    

00801ed2 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801ed2:	55                   	push   %ebp
  801ed3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801ed5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ed8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801edb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ede:	6a 00                	push   $0x0
  801ee0:	6a 00                	push   $0x0
  801ee2:	51                   	push   %ecx
  801ee3:	52                   	push   %edx
  801ee4:	50                   	push   %eax
  801ee5:	6a 1e                	push   $0x1e
  801ee7:	e8 7a fc ff ff       	call   801b66 <syscall>
  801eec:	83 c4 18             	add    $0x18,%esp
}
  801eef:	c9                   	leave  
  801ef0:	c3                   	ret    

00801ef1 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ef1:	55                   	push   %ebp
  801ef2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ef4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  801efa:	6a 00                	push   $0x0
  801efc:	6a 00                	push   $0x0
  801efe:	6a 00                	push   $0x0
  801f00:	52                   	push   %edx
  801f01:	50                   	push   %eax
  801f02:	6a 1f                	push   $0x1f
  801f04:	e8 5d fc ff ff       	call   801b66 <syscall>
  801f09:	83 c4 18             	add    $0x18,%esp
}
  801f0c:	c9                   	leave  
  801f0d:	c3                   	ret    

00801f0e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801f0e:	55                   	push   %ebp
  801f0f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801f11:	6a 00                	push   $0x0
  801f13:	6a 00                	push   $0x0
  801f15:	6a 00                	push   $0x0
  801f17:	6a 00                	push   $0x0
  801f19:	6a 00                	push   $0x0
  801f1b:	6a 20                	push   $0x20
  801f1d:	e8 44 fc ff ff       	call   801b66 <syscall>
  801f22:	83 c4 18             	add    $0x18,%esp
}
  801f25:	c9                   	leave  
  801f26:	c3                   	ret    

00801f27 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801f27:	55                   	push   %ebp
  801f28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801f2a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f2d:	6a 00                	push   $0x0
  801f2f:	ff 75 14             	pushl  0x14(%ebp)
  801f32:	ff 75 10             	pushl  0x10(%ebp)
  801f35:	ff 75 0c             	pushl  0xc(%ebp)
  801f38:	50                   	push   %eax
  801f39:	6a 21                	push   $0x21
  801f3b:	e8 26 fc ff ff       	call   801b66 <syscall>
  801f40:	83 c4 18             	add    $0x18,%esp
}
  801f43:	c9                   	leave  
  801f44:	c3                   	ret    

00801f45 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801f45:	55                   	push   %ebp
  801f46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801f48:	8b 45 08             	mov    0x8(%ebp),%eax
  801f4b:	6a 00                	push   $0x0
  801f4d:	6a 00                	push   $0x0
  801f4f:	6a 00                	push   $0x0
  801f51:	6a 00                	push   $0x0
  801f53:	50                   	push   %eax
  801f54:	6a 22                	push   $0x22
  801f56:	e8 0b fc ff ff       	call   801b66 <syscall>
  801f5b:	83 c4 18             	add    $0x18,%esp
}
  801f5e:	90                   	nop
  801f5f:	c9                   	leave  
  801f60:	c3                   	ret    

00801f61 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801f61:	55                   	push   %ebp
  801f62:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801f64:	8b 45 08             	mov    0x8(%ebp),%eax
  801f67:	6a 00                	push   $0x0
  801f69:	6a 00                	push   $0x0
  801f6b:	6a 00                	push   $0x0
  801f6d:	6a 00                	push   $0x0
  801f6f:	50                   	push   %eax
  801f70:	6a 23                	push   $0x23
  801f72:	e8 ef fb ff ff       	call   801b66 <syscall>
  801f77:	83 c4 18             	add    $0x18,%esp
}
  801f7a:	90                   	nop
  801f7b:	c9                   	leave  
  801f7c:	c3                   	ret    

00801f7d <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801f7d:	55                   	push   %ebp
  801f7e:	89 e5                	mov    %esp,%ebp
  801f80:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801f83:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f86:	8d 50 04             	lea    0x4(%eax),%edx
  801f89:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801f8c:	6a 00                	push   $0x0
  801f8e:	6a 00                	push   $0x0
  801f90:	6a 00                	push   $0x0
  801f92:	52                   	push   %edx
  801f93:	50                   	push   %eax
  801f94:	6a 24                	push   $0x24
  801f96:	e8 cb fb ff ff       	call   801b66 <syscall>
  801f9b:	83 c4 18             	add    $0x18,%esp
	return result;
  801f9e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801fa1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801fa4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801fa7:	89 01                	mov    %eax,(%ecx)
  801fa9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801fac:	8b 45 08             	mov    0x8(%ebp),%eax
  801faf:	c9                   	leave  
  801fb0:	c2 04 00             	ret    $0x4

00801fb3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801fb3:	55                   	push   %ebp
  801fb4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	ff 75 10             	pushl  0x10(%ebp)
  801fbd:	ff 75 0c             	pushl  0xc(%ebp)
  801fc0:	ff 75 08             	pushl  0x8(%ebp)
  801fc3:	6a 13                	push   $0x13
  801fc5:	e8 9c fb ff ff       	call   801b66 <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
	return ;
  801fcd:	90                   	nop
}
  801fce:	c9                   	leave  
  801fcf:	c3                   	ret    

00801fd0 <sys_rcr2>:
uint32 sys_rcr2()
{
  801fd0:	55                   	push   %ebp
  801fd1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 25                	push   $0x25
  801fdf:	e8 82 fb ff ff       	call   801b66 <syscall>
  801fe4:	83 c4 18             	add    $0x18,%esp
}
  801fe7:	c9                   	leave  
  801fe8:	c3                   	ret    

00801fe9 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801fe9:	55                   	push   %ebp
  801fea:	89 e5                	mov    %esp,%ebp
  801fec:	83 ec 04             	sub    $0x4,%esp
  801fef:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff2:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801ff5:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801ff9:	6a 00                	push   $0x0
  801ffb:	6a 00                	push   $0x0
  801ffd:	6a 00                	push   $0x0
  801fff:	6a 00                	push   $0x0
  802001:	50                   	push   %eax
  802002:	6a 26                	push   $0x26
  802004:	e8 5d fb ff ff       	call   801b66 <syscall>
  802009:	83 c4 18             	add    $0x18,%esp
	return ;
  80200c:	90                   	nop
}
  80200d:	c9                   	leave  
  80200e:	c3                   	ret    

0080200f <rsttst>:
void rsttst()
{
  80200f:	55                   	push   %ebp
  802010:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802012:	6a 00                	push   $0x0
  802014:	6a 00                	push   $0x0
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 28                	push   $0x28
  80201e:	e8 43 fb ff ff       	call   801b66 <syscall>
  802023:	83 c4 18             	add    $0x18,%esp
	return ;
  802026:	90                   	nop
}
  802027:	c9                   	leave  
  802028:	c3                   	ret    

00802029 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802029:	55                   	push   %ebp
  80202a:	89 e5                	mov    %esp,%ebp
  80202c:	83 ec 04             	sub    $0x4,%esp
  80202f:	8b 45 14             	mov    0x14(%ebp),%eax
  802032:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802035:	8b 55 18             	mov    0x18(%ebp),%edx
  802038:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80203c:	52                   	push   %edx
  80203d:	50                   	push   %eax
  80203e:	ff 75 10             	pushl  0x10(%ebp)
  802041:	ff 75 0c             	pushl  0xc(%ebp)
  802044:	ff 75 08             	pushl  0x8(%ebp)
  802047:	6a 27                	push   $0x27
  802049:	e8 18 fb ff ff       	call   801b66 <syscall>
  80204e:	83 c4 18             	add    $0x18,%esp
	return ;
  802051:	90                   	nop
}
  802052:	c9                   	leave  
  802053:	c3                   	ret    

00802054 <chktst>:
void chktst(uint32 n)
{
  802054:	55                   	push   %ebp
  802055:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 00                	push   $0x0
  80205d:	6a 00                	push   $0x0
  80205f:	ff 75 08             	pushl  0x8(%ebp)
  802062:	6a 29                	push   $0x29
  802064:	e8 fd fa ff ff       	call   801b66 <syscall>
  802069:	83 c4 18             	add    $0x18,%esp
	return ;
  80206c:	90                   	nop
}
  80206d:	c9                   	leave  
  80206e:	c3                   	ret    

0080206f <inctst>:

void inctst()
{
  80206f:	55                   	push   %ebp
  802070:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802072:	6a 00                	push   $0x0
  802074:	6a 00                	push   $0x0
  802076:	6a 00                	push   $0x0
  802078:	6a 00                	push   $0x0
  80207a:	6a 00                	push   $0x0
  80207c:	6a 2a                	push   $0x2a
  80207e:	e8 e3 fa ff ff       	call   801b66 <syscall>
  802083:	83 c4 18             	add    $0x18,%esp
	return ;
  802086:	90                   	nop
}
  802087:	c9                   	leave  
  802088:	c3                   	ret    

00802089 <gettst>:
uint32 gettst()
{
  802089:	55                   	push   %ebp
  80208a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 2b                	push   $0x2b
  802098:	e8 c9 fa ff ff       	call   801b66 <syscall>
  80209d:	83 c4 18             	add    $0x18,%esp
}
  8020a0:	c9                   	leave  
  8020a1:	c3                   	ret    

008020a2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8020a2:	55                   	push   %ebp
  8020a3:	89 e5                	mov    %esp,%ebp
  8020a5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	6a 00                	push   $0x0
  8020b2:	6a 2c                	push   $0x2c
  8020b4:	e8 ad fa ff ff       	call   801b66 <syscall>
  8020b9:	83 c4 18             	add    $0x18,%esp
  8020bc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8020bf:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8020c3:	75 07                	jne    8020cc <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8020c5:	b8 01 00 00 00       	mov    $0x1,%eax
  8020ca:	eb 05                	jmp    8020d1 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8020cc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8020d1:	c9                   	leave  
  8020d2:	c3                   	ret    

008020d3 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8020d3:	55                   	push   %ebp
  8020d4:	89 e5                	mov    %esp,%ebp
  8020d6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8020d9:	6a 00                	push   $0x0
  8020db:	6a 00                	push   $0x0
  8020dd:	6a 00                	push   $0x0
  8020df:	6a 00                	push   $0x0
  8020e1:	6a 00                	push   $0x0
  8020e3:	6a 2c                	push   $0x2c
  8020e5:	e8 7c fa ff ff       	call   801b66 <syscall>
  8020ea:	83 c4 18             	add    $0x18,%esp
  8020ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8020f0:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8020f4:	75 07                	jne    8020fd <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8020f6:	b8 01 00 00 00       	mov    $0x1,%eax
  8020fb:	eb 05                	jmp    802102 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8020fd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802102:	c9                   	leave  
  802103:	c3                   	ret    

00802104 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802104:	55                   	push   %ebp
  802105:	89 e5                	mov    %esp,%ebp
  802107:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	6a 00                	push   $0x0
  802110:	6a 00                	push   $0x0
  802112:	6a 00                	push   $0x0
  802114:	6a 2c                	push   $0x2c
  802116:	e8 4b fa ff ff       	call   801b66 <syscall>
  80211b:	83 c4 18             	add    $0x18,%esp
  80211e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802121:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802125:	75 07                	jne    80212e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802127:	b8 01 00 00 00       	mov    $0x1,%eax
  80212c:	eb 05                	jmp    802133 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80212e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802133:	c9                   	leave  
  802134:	c3                   	ret    

00802135 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802135:	55                   	push   %ebp
  802136:	89 e5                	mov    %esp,%ebp
  802138:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 2c                	push   $0x2c
  802147:	e8 1a fa ff ff       	call   801b66 <syscall>
  80214c:	83 c4 18             	add    $0x18,%esp
  80214f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802152:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802156:	75 07                	jne    80215f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802158:	b8 01 00 00 00       	mov    $0x1,%eax
  80215d:	eb 05                	jmp    802164 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80215f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802169:	6a 00                	push   $0x0
  80216b:	6a 00                	push   $0x0
  80216d:	6a 00                	push   $0x0
  80216f:	6a 00                	push   $0x0
  802171:	ff 75 08             	pushl  0x8(%ebp)
  802174:	6a 2d                	push   $0x2d
  802176:	e8 eb f9 ff ff       	call   801b66 <syscall>
  80217b:	83 c4 18             	add    $0x18,%esp
	return ;
  80217e:	90                   	nop
}
  80217f:	c9                   	leave  
  802180:	c3                   	ret    

00802181 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802181:	55                   	push   %ebp
  802182:	89 e5                	mov    %esp,%ebp
  802184:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802185:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802188:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80218b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80218e:	8b 45 08             	mov    0x8(%ebp),%eax
  802191:	6a 00                	push   $0x0
  802193:	53                   	push   %ebx
  802194:	51                   	push   %ecx
  802195:	52                   	push   %edx
  802196:	50                   	push   %eax
  802197:	6a 2e                	push   $0x2e
  802199:	e8 c8 f9 ff ff       	call   801b66 <syscall>
  80219e:	83 c4 18             	add    $0x18,%esp
}
  8021a1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8021a4:	c9                   	leave  
  8021a5:	c3                   	ret    

008021a6 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8021a6:	55                   	push   %ebp
  8021a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8021a9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8021ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 00                	push   $0x0
  8021b3:	6a 00                	push   $0x0
  8021b5:	52                   	push   %edx
  8021b6:	50                   	push   %eax
  8021b7:	6a 2f                	push   $0x2f
  8021b9:	e8 a8 f9 ff ff       	call   801b66 <syscall>
  8021be:	83 c4 18             	add    $0x18,%esp
}
  8021c1:	c9                   	leave  
  8021c2:	c3                   	ret    

008021c3 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8021c3:	55                   	push   %ebp
  8021c4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  8021c6:	6a 00                	push   $0x0
  8021c8:	6a 00                	push   $0x0
  8021ca:	6a 00                	push   $0x0
  8021cc:	ff 75 0c             	pushl  0xc(%ebp)
  8021cf:	ff 75 08             	pushl  0x8(%ebp)
  8021d2:	6a 30                	push   $0x30
  8021d4:	e8 8d f9 ff ff       	call   801b66 <syscall>
  8021d9:	83 c4 18             	add    $0x18,%esp
	return ;
  8021dc:	90                   	nop
}
  8021dd:	c9                   	leave  
  8021de:	c3                   	ret    
  8021df:	90                   	nop

008021e0 <__udivdi3>:
  8021e0:	55                   	push   %ebp
  8021e1:	57                   	push   %edi
  8021e2:	56                   	push   %esi
  8021e3:	53                   	push   %ebx
  8021e4:	83 ec 1c             	sub    $0x1c,%esp
  8021e7:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8021eb:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8021ef:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8021f3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8021f7:	89 ca                	mov    %ecx,%edx
  8021f9:	89 f8                	mov    %edi,%eax
  8021fb:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8021ff:	85 f6                	test   %esi,%esi
  802201:	75 2d                	jne    802230 <__udivdi3+0x50>
  802203:	39 cf                	cmp    %ecx,%edi
  802205:	77 65                	ja     80226c <__udivdi3+0x8c>
  802207:	89 fd                	mov    %edi,%ebp
  802209:	85 ff                	test   %edi,%edi
  80220b:	75 0b                	jne    802218 <__udivdi3+0x38>
  80220d:	b8 01 00 00 00       	mov    $0x1,%eax
  802212:	31 d2                	xor    %edx,%edx
  802214:	f7 f7                	div    %edi
  802216:	89 c5                	mov    %eax,%ebp
  802218:	31 d2                	xor    %edx,%edx
  80221a:	89 c8                	mov    %ecx,%eax
  80221c:	f7 f5                	div    %ebp
  80221e:	89 c1                	mov    %eax,%ecx
  802220:	89 d8                	mov    %ebx,%eax
  802222:	f7 f5                	div    %ebp
  802224:	89 cf                	mov    %ecx,%edi
  802226:	89 fa                	mov    %edi,%edx
  802228:	83 c4 1c             	add    $0x1c,%esp
  80222b:	5b                   	pop    %ebx
  80222c:	5e                   	pop    %esi
  80222d:	5f                   	pop    %edi
  80222e:	5d                   	pop    %ebp
  80222f:	c3                   	ret    
  802230:	39 ce                	cmp    %ecx,%esi
  802232:	77 28                	ja     80225c <__udivdi3+0x7c>
  802234:	0f bd fe             	bsr    %esi,%edi
  802237:	83 f7 1f             	xor    $0x1f,%edi
  80223a:	75 40                	jne    80227c <__udivdi3+0x9c>
  80223c:	39 ce                	cmp    %ecx,%esi
  80223e:	72 0a                	jb     80224a <__udivdi3+0x6a>
  802240:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802244:	0f 87 9e 00 00 00    	ja     8022e8 <__udivdi3+0x108>
  80224a:	b8 01 00 00 00       	mov    $0x1,%eax
  80224f:	89 fa                	mov    %edi,%edx
  802251:	83 c4 1c             	add    $0x1c,%esp
  802254:	5b                   	pop    %ebx
  802255:	5e                   	pop    %esi
  802256:	5f                   	pop    %edi
  802257:	5d                   	pop    %ebp
  802258:	c3                   	ret    
  802259:	8d 76 00             	lea    0x0(%esi),%esi
  80225c:	31 ff                	xor    %edi,%edi
  80225e:	31 c0                	xor    %eax,%eax
  802260:	89 fa                	mov    %edi,%edx
  802262:	83 c4 1c             	add    $0x1c,%esp
  802265:	5b                   	pop    %ebx
  802266:	5e                   	pop    %esi
  802267:	5f                   	pop    %edi
  802268:	5d                   	pop    %ebp
  802269:	c3                   	ret    
  80226a:	66 90                	xchg   %ax,%ax
  80226c:	89 d8                	mov    %ebx,%eax
  80226e:	f7 f7                	div    %edi
  802270:	31 ff                	xor    %edi,%edi
  802272:	89 fa                	mov    %edi,%edx
  802274:	83 c4 1c             	add    $0x1c,%esp
  802277:	5b                   	pop    %ebx
  802278:	5e                   	pop    %esi
  802279:	5f                   	pop    %edi
  80227a:	5d                   	pop    %ebp
  80227b:	c3                   	ret    
  80227c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802281:	89 eb                	mov    %ebp,%ebx
  802283:	29 fb                	sub    %edi,%ebx
  802285:	89 f9                	mov    %edi,%ecx
  802287:	d3 e6                	shl    %cl,%esi
  802289:	89 c5                	mov    %eax,%ebp
  80228b:	88 d9                	mov    %bl,%cl
  80228d:	d3 ed                	shr    %cl,%ebp
  80228f:	89 e9                	mov    %ebp,%ecx
  802291:	09 f1                	or     %esi,%ecx
  802293:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802297:	89 f9                	mov    %edi,%ecx
  802299:	d3 e0                	shl    %cl,%eax
  80229b:	89 c5                	mov    %eax,%ebp
  80229d:	89 d6                	mov    %edx,%esi
  80229f:	88 d9                	mov    %bl,%cl
  8022a1:	d3 ee                	shr    %cl,%esi
  8022a3:	89 f9                	mov    %edi,%ecx
  8022a5:	d3 e2                	shl    %cl,%edx
  8022a7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8022ab:	88 d9                	mov    %bl,%cl
  8022ad:	d3 e8                	shr    %cl,%eax
  8022af:	09 c2                	or     %eax,%edx
  8022b1:	89 d0                	mov    %edx,%eax
  8022b3:	89 f2                	mov    %esi,%edx
  8022b5:	f7 74 24 0c          	divl   0xc(%esp)
  8022b9:	89 d6                	mov    %edx,%esi
  8022bb:	89 c3                	mov    %eax,%ebx
  8022bd:	f7 e5                	mul    %ebp
  8022bf:	39 d6                	cmp    %edx,%esi
  8022c1:	72 19                	jb     8022dc <__udivdi3+0xfc>
  8022c3:	74 0b                	je     8022d0 <__udivdi3+0xf0>
  8022c5:	89 d8                	mov    %ebx,%eax
  8022c7:	31 ff                	xor    %edi,%edi
  8022c9:	e9 58 ff ff ff       	jmp    802226 <__udivdi3+0x46>
  8022ce:	66 90                	xchg   %ax,%ax
  8022d0:	8b 54 24 08          	mov    0x8(%esp),%edx
  8022d4:	89 f9                	mov    %edi,%ecx
  8022d6:	d3 e2                	shl    %cl,%edx
  8022d8:	39 c2                	cmp    %eax,%edx
  8022da:	73 e9                	jae    8022c5 <__udivdi3+0xe5>
  8022dc:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8022df:	31 ff                	xor    %edi,%edi
  8022e1:	e9 40 ff ff ff       	jmp    802226 <__udivdi3+0x46>
  8022e6:	66 90                	xchg   %ax,%ax
  8022e8:	31 c0                	xor    %eax,%eax
  8022ea:	e9 37 ff ff ff       	jmp    802226 <__udivdi3+0x46>
  8022ef:	90                   	nop

008022f0 <__umoddi3>:
  8022f0:	55                   	push   %ebp
  8022f1:	57                   	push   %edi
  8022f2:	56                   	push   %esi
  8022f3:	53                   	push   %ebx
  8022f4:	83 ec 1c             	sub    $0x1c,%esp
  8022f7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8022fb:	8b 74 24 34          	mov    0x34(%esp),%esi
  8022ff:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802303:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802307:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80230b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80230f:	89 f3                	mov    %esi,%ebx
  802311:	89 fa                	mov    %edi,%edx
  802313:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802317:	89 34 24             	mov    %esi,(%esp)
  80231a:	85 c0                	test   %eax,%eax
  80231c:	75 1a                	jne    802338 <__umoddi3+0x48>
  80231e:	39 f7                	cmp    %esi,%edi
  802320:	0f 86 a2 00 00 00    	jbe    8023c8 <__umoddi3+0xd8>
  802326:	89 c8                	mov    %ecx,%eax
  802328:	89 f2                	mov    %esi,%edx
  80232a:	f7 f7                	div    %edi
  80232c:	89 d0                	mov    %edx,%eax
  80232e:	31 d2                	xor    %edx,%edx
  802330:	83 c4 1c             	add    $0x1c,%esp
  802333:	5b                   	pop    %ebx
  802334:	5e                   	pop    %esi
  802335:	5f                   	pop    %edi
  802336:	5d                   	pop    %ebp
  802337:	c3                   	ret    
  802338:	39 f0                	cmp    %esi,%eax
  80233a:	0f 87 ac 00 00 00    	ja     8023ec <__umoddi3+0xfc>
  802340:	0f bd e8             	bsr    %eax,%ebp
  802343:	83 f5 1f             	xor    $0x1f,%ebp
  802346:	0f 84 ac 00 00 00    	je     8023f8 <__umoddi3+0x108>
  80234c:	bf 20 00 00 00       	mov    $0x20,%edi
  802351:	29 ef                	sub    %ebp,%edi
  802353:	89 fe                	mov    %edi,%esi
  802355:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802359:	89 e9                	mov    %ebp,%ecx
  80235b:	d3 e0                	shl    %cl,%eax
  80235d:	89 d7                	mov    %edx,%edi
  80235f:	89 f1                	mov    %esi,%ecx
  802361:	d3 ef                	shr    %cl,%edi
  802363:	09 c7                	or     %eax,%edi
  802365:	89 e9                	mov    %ebp,%ecx
  802367:	d3 e2                	shl    %cl,%edx
  802369:	89 14 24             	mov    %edx,(%esp)
  80236c:	89 d8                	mov    %ebx,%eax
  80236e:	d3 e0                	shl    %cl,%eax
  802370:	89 c2                	mov    %eax,%edx
  802372:	8b 44 24 08          	mov    0x8(%esp),%eax
  802376:	d3 e0                	shl    %cl,%eax
  802378:	89 44 24 04          	mov    %eax,0x4(%esp)
  80237c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802380:	89 f1                	mov    %esi,%ecx
  802382:	d3 e8                	shr    %cl,%eax
  802384:	09 d0                	or     %edx,%eax
  802386:	d3 eb                	shr    %cl,%ebx
  802388:	89 da                	mov    %ebx,%edx
  80238a:	f7 f7                	div    %edi
  80238c:	89 d3                	mov    %edx,%ebx
  80238e:	f7 24 24             	mull   (%esp)
  802391:	89 c6                	mov    %eax,%esi
  802393:	89 d1                	mov    %edx,%ecx
  802395:	39 d3                	cmp    %edx,%ebx
  802397:	0f 82 87 00 00 00    	jb     802424 <__umoddi3+0x134>
  80239d:	0f 84 91 00 00 00    	je     802434 <__umoddi3+0x144>
  8023a3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8023a7:	29 f2                	sub    %esi,%edx
  8023a9:	19 cb                	sbb    %ecx,%ebx
  8023ab:	89 d8                	mov    %ebx,%eax
  8023ad:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8023b1:	d3 e0                	shl    %cl,%eax
  8023b3:	89 e9                	mov    %ebp,%ecx
  8023b5:	d3 ea                	shr    %cl,%edx
  8023b7:	09 d0                	or     %edx,%eax
  8023b9:	89 e9                	mov    %ebp,%ecx
  8023bb:	d3 eb                	shr    %cl,%ebx
  8023bd:	89 da                	mov    %ebx,%edx
  8023bf:	83 c4 1c             	add    $0x1c,%esp
  8023c2:	5b                   	pop    %ebx
  8023c3:	5e                   	pop    %esi
  8023c4:	5f                   	pop    %edi
  8023c5:	5d                   	pop    %ebp
  8023c6:	c3                   	ret    
  8023c7:	90                   	nop
  8023c8:	89 fd                	mov    %edi,%ebp
  8023ca:	85 ff                	test   %edi,%edi
  8023cc:	75 0b                	jne    8023d9 <__umoddi3+0xe9>
  8023ce:	b8 01 00 00 00       	mov    $0x1,%eax
  8023d3:	31 d2                	xor    %edx,%edx
  8023d5:	f7 f7                	div    %edi
  8023d7:	89 c5                	mov    %eax,%ebp
  8023d9:	89 f0                	mov    %esi,%eax
  8023db:	31 d2                	xor    %edx,%edx
  8023dd:	f7 f5                	div    %ebp
  8023df:	89 c8                	mov    %ecx,%eax
  8023e1:	f7 f5                	div    %ebp
  8023e3:	89 d0                	mov    %edx,%eax
  8023e5:	e9 44 ff ff ff       	jmp    80232e <__umoddi3+0x3e>
  8023ea:	66 90                	xchg   %ax,%ax
  8023ec:	89 c8                	mov    %ecx,%eax
  8023ee:	89 f2                	mov    %esi,%edx
  8023f0:	83 c4 1c             	add    $0x1c,%esp
  8023f3:	5b                   	pop    %ebx
  8023f4:	5e                   	pop    %esi
  8023f5:	5f                   	pop    %edi
  8023f6:	5d                   	pop    %ebp
  8023f7:	c3                   	ret    
  8023f8:	3b 04 24             	cmp    (%esp),%eax
  8023fb:	72 06                	jb     802403 <__umoddi3+0x113>
  8023fd:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802401:	77 0f                	ja     802412 <__umoddi3+0x122>
  802403:	89 f2                	mov    %esi,%edx
  802405:	29 f9                	sub    %edi,%ecx
  802407:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80240b:	89 14 24             	mov    %edx,(%esp)
  80240e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802412:	8b 44 24 04          	mov    0x4(%esp),%eax
  802416:	8b 14 24             	mov    (%esp),%edx
  802419:	83 c4 1c             	add    $0x1c,%esp
  80241c:	5b                   	pop    %ebx
  80241d:	5e                   	pop    %esi
  80241e:	5f                   	pop    %edi
  80241f:	5d                   	pop    %ebp
  802420:	c3                   	ret    
  802421:	8d 76 00             	lea    0x0(%esi),%esi
  802424:	2b 04 24             	sub    (%esp),%eax
  802427:	19 fa                	sbb    %edi,%edx
  802429:	89 d1                	mov    %edx,%ecx
  80242b:	89 c6                	mov    %eax,%esi
  80242d:	e9 71 ff ff ff       	jmp    8023a3 <__umoddi3+0xb3>
  802432:	66 90                	xchg   %ax,%ax
  802434:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802438:	72 ea                	jb     802424 <__umoddi3+0x134>
  80243a:	89 d9                	mov    %ebx,%ecx
  80243c:	e9 62 ff ff ff       	jmp    8023a3 <__umoddi3+0xb3>
