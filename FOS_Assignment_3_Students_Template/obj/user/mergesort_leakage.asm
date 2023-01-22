
obj/user/mergesort_leakage:     file format elf32-i386


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
  800031:	e8 73 07 00 00       	call   8007a9 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

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
  800041:	e8 ef 1d 00 00       	call   801e35 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 e0 24 80 00       	push   $0x8024e0
  80004e:	e8 26 0b 00 00       	call   800b79 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 e2 24 80 00       	push   $0x8024e2
  80005e:	e8 16 0b 00 00       	call   800b79 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 f8 24 80 00       	push   $0x8024f8
  80006e:	e8 06 0b 00 00       	call   800b79 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 e2 24 80 00       	push   $0x8024e2
  80007e:	e8 f6 0a 00 00       	call   800b79 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 e0 24 80 00       	push   $0x8024e0
  80008e:	e8 e6 0a 00 00       	call   800b79 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 10 25 80 00       	push   $0x802510
  8000a5:	e8 51 11 00 00       	call   8011fb <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 a1 16 00 00       	call   801761 <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 34 1a 00 00       	call   801b09 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 30 25 80 00       	push   $0x802530
  8000e3:	e8 91 0a 00 00       	call   800b79 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 52 25 80 00       	push   $0x802552
  8000f3:	e8 81 0a 00 00       	call   800b79 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 60 25 80 00       	push   $0x802560
  800103:	e8 71 0a 00 00       	call   800b79 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 6f 25 80 00       	push   $0x80256f
  800113:	e8 61 0a 00 00       	call   800b79 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 7f 25 80 00       	push   $0x80257f
  800123:	e8 51 0a 00 00       	call   800b79 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 21 06 00 00       	call   800751 <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 c9 05 00 00       	call   800709 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 bc 05 00 00       	call   800709 <cputchar>
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
  800162:	e8 e8 1c 00 00       	call   801e4f <sys_enable_interrupt>

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
  800183:	e8 f4 01 00 00       	call   80037c <InitializeAscending>
  800188:	83 c4 10             	add    $0x10,%esp
			break ;
  80018b:	eb 37                	jmp    8001c4 <_main+0x18c>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018d:	83 ec 08             	sub    $0x8,%esp
  800190:	ff 75 f0             	pushl  -0x10(%ebp)
  800193:	ff 75 ec             	pushl  -0x14(%ebp)
  800196:	e8 12 02 00 00       	call   8003ad <InitializeDescending>
  80019b:	83 c4 10             	add    $0x10,%esp
			break ;
  80019e:	eb 24                	jmp    8001c4 <_main+0x18c>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001a0:	83 ec 08             	sub    $0x8,%esp
  8001a3:	ff 75 f0             	pushl  -0x10(%ebp)
  8001a6:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a9:	e8 34 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001ae:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b1:	eb 11                	jmp    8001c4 <_main+0x18c>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b3:	83 ec 08             	sub    $0x8,%esp
  8001b6:	ff 75 f0             	pushl  -0x10(%ebp)
  8001b9:	ff 75 ec             	pushl  -0x14(%ebp)
  8001bc:	e8 21 02 00 00       	call   8003e2 <InitializeSemiRandom>
  8001c1:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001c4:	83 ec 04             	sub    $0x4,%esp
  8001c7:	ff 75 f0             	pushl  -0x10(%ebp)
  8001ca:	6a 01                	push   $0x1
  8001cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cf:	e8 e0 02 00 00       	call   8004b4 <MSort>
  8001d4:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  8001d7:	e8 59 1c 00 00       	call   801e35 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 88 25 80 00       	push   $0x802588
  8001e4:	e8 90 09 00 00       	call   800b79 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 5e 1c 00 00       	call   801e4f <sys_enable_interrupt>

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001f1:	83 ec 08             	sub    $0x8,%esp
  8001f4:	ff 75 f0             	pushl  -0x10(%ebp)
  8001f7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001fa:	e8 d3 00 00 00       	call   8002d2 <CheckSorted>
  8001ff:	83 c4 10             	add    $0x10,%esp
  800202:	89 45 e8             	mov    %eax,-0x18(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800205:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  800209:	75 14                	jne    80021f <_main+0x1e7>
  80020b:	83 ec 04             	sub    $0x4,%esp
  80020e:	68 bc 25 80 00       	push   $0x8025bc
  800213:	6a 4a                	push   $0x4a
  800215:	68 de 25 80 00       	push   $0x8025de
  80021a:	e8 a6 06 00 00       	call   8008c5 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 11 1c 00 00       	call   801e35 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 f8 25 80 00       	push   $0x8025f8
  80022c:	e8 48 09 00 00       	call   800b79 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 2c 26 80 00       	push   $0x80262c
  80023c:	e8 38 09 00 00       	call   800b79 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 60 26 80 00       	push   $0x802660
  80024c:	e8 28 09 00 00       	call   800b79 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 f6 1b 00 00       	call   801e4f <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 bf 18 00 00       	call   801b23 <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 c9 1b 00 00       	call   801e35 <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 92 26 80 00       	push   $0x802692
  80027a:	e8 fa 08 00 00       	call   800b79 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 ca 04 00 00       	call   800751 <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 72 04 00 00       	call   800709 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 65 04 00 00       	call   800709 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 58 04 00 00       	call   800709 <cputchar>
  8002b1:	83 c4 10             	add    $0x10,%esp

		free(Elements) ;

		sys_disable_interrupt();
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  8002b4:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002b8:	74 06                	je     8002c0 <_main+0x288>
  8002ba:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  8002be:	75 b2                	jne    800272 <_main+0x23a>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_enable_interrupt();
  8002c0:	e8 8a 1b 00 00       	call   801e4f <sys_enable_interrupt>

	} while (Chose == 'y');
  8002c5:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  8002c9:	0f 84 72 fd ff ff    	je     800041 <_main+0x9>

}
  8002cf:	90                   	nop
  8002d0:	c9                   	leave  
  8002d1:	c3                   	ret    

008002d2 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8002d2:	55                   	push   %ebp
  8002d3:	89 e5                	mov    %esp,%ebp
  8002d5:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8002d8:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8002df:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8002e6:	eb 33                	jmp    80031b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8002e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002eb:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8002f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8002f5:	01 d0                	add    %edx,%eax
  8002f7:	8b 10                	mov    (%eax),%edx
  8002f9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8002fc:	40                   	inc    %eax
  8002fd:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800304:	8b 45 08             	mov    0x8(%ebp),%eax
  800307:	01 c8                	add    %ecx,%eax
  800309:	8b 00                	mov    (%eax),%eax
  80030b:	39 c2                	cmp    %eax,%edx
  80030d:	7e 09                	jle    800318 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80030f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800316:	eb 0c                	jmp    800324 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800318:	ff 45 f8             	incl   -0x8(%ebp)
  80031b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80031e:	48                   	dec    %eax
  80031f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800322:	7f c4                	jg     8002e8 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800324:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800327:	c9                   	leave  
  800328:	c3                   	ret    

00800329 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  800329:	55                   	push   %ebp
  80032a:	89 e5                	mov    %esp,%ebp
  80032c:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  80032f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800332:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800339:	8b 45 08             	mov    0x8(%ebp),%eax
  80033c:	01 d0                	add    %edx,%eax
  80033e:	8b 00                	mov    (%eax),%eax
  800340:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800343:	8b 45 0c             	mov    0xc(%ebp),%eax
  800346:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80034d:	8b 45 08             	mov    0x8(%ebp),%eax
  800350:	01 c2                	add    %eax,%edx
  800352:	8b 45 10             	mov    0x10(%ebp),%eax
  800355:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80035c:	8b 45 08             	mov    0x8(%ebp),%eax
  80035f:	01 c8                	add    %ecx,%eax
  800361:	8b 00                	mov    (%eax),%eax
  800363:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800365:	8b 45 10             	mov    0x10(%ebp),%eax
  800368:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80036f:	8b 45 08             	mov    0x8(%ebp),%eax
  800372:	01 c2                	add    %eax,%edx
  800374:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800377:	89 02                	mov    %eax,(%edx)
}
  800379:	90                   	nop
  80037a:	c9                   	leave  
  80037b:	c3                   	ret    

0080037c <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80037c:	55                   	push   %ebp
  80037d:	89 e5                	mov    %esp,%ebp
  80037f:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800382:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800389:	eb 17                	jmp    8003a2 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80038b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80038e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800395:	8b 45 08             	mov    0x8(%ebp),%eax
  800398:	01 c2                	add    %eax,%edx
  80039a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80039d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80039f:	ff 45 fc             	incl   -0x4(%ebp)
  8003a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003a5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003a8:	7c e1                	jl     80038b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8003aa:	90                   	nop
  8003ab:	c9                   	leave  
  8003ac:	c3                   	ret    

008003ad <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8003ad:	55                   	push   %ebp
  8003ae:	89 e5                	mov    %esp,%ebp
  8003b0:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003b3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8003ba:	eb 1b                	jmp    8003d7 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8003bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003bf:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8003c9:	01 c2                	add    %eax,%edx
  8003cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003ce:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8003d1:	48                   	dec    %eax
  8003d2:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8003d4:	ff 45 fc             	incl   -0x4(%ebp)
  8003d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003da:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8003dd:	7c dd                	jl     8003bc <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8003df:	90                   	nop
  8003e0:	c9                   	leave  
  8003e1:	c3                   	ret    

008003e2 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8003e2:	55                   	push   %ebp
  8003e3:	89 e5                	mov    %esp,%ebp
  8003e5:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8003e8:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8003eb:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8003f0:	f7 e9                	imul   %ecx
  8003f2:	c1 f9 1f             	sar    $0x1f,%ecx
  8003f5:	89 d0                	mov    %edx,%eax
  8003f7:	29 c8                	sub    %ecx,%eax
  8003f9:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8003fc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800403:	eb 1e                	jmp    800423 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800405:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800408:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80040f:	8b 45 08             	mov    0x8(%ebp),%eax
  800412:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800415:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800418:	99                   	cltd   
  800419:	f7 7d f8             	idivl  -0x8(%ebp)
  80041c:	89 d0                	mov    %edx,%eax
  80041e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800420:	ff 45 fc             	incl   -0x4(%ebp)
  800423:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800426:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800429:	7c da                	jl     800405 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  80042b:	90                   	nop
  80042c:	c9                   	leave  
  80042d:	c3                   	ret    

0080042e <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  80042e:	55                   	push   %ebp
  80042f:	89 e5                	mov    %esp,%ebp
  800431:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800434:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80043b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800442:	eb 42                	jmp    800486 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800444:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800447:	99                   	cltd   
  800448:	f7 7d f0             	idivl  -0x10(%ebp)
  80044b:	89 d0                	mov    %edx,%eax
  80044d:	85 c0                	test   %eax,%eax
  80044f:	75 10                	jne    800461 <PrintElements+0x33>
			cprintf("\n");
  800451:	83 ec 0c             	sub    $0xc,%esp
  800454:	68 e0 24 80 00       	push   $0x8024e0
  800459:	e8 1b 07 00 00       	call   800b79 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 b0 26 80 00       	push   $0x8026b0
  80047b:	e8 f9 06 00 00       	call   800b79 <cprintf>
  800480:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800483:	ff 45 f4             	incl   -0xc(%ebp)
  800486:	8b 45 0c             	mov    0xc(%ebp),%eax
  800489:	48                   	dec    %eax
  80048a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80048d:	7f b5                	jg     800444 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80048f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800492:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800499:	8b 45 08             	mov    0x8(%ebp),%eax
  80049c:	01 d0                	add    %edx,%eax
  80049e:	8b 00                	mov    (%eax),%eax
  8004a0:	83 ec 08             	sub    $0x8,%esp
  8004a3:	50                   	push   %eax
  8004a4:	68 b5 26 80 00       	push   $0x8026b5
  8004a9:	e8 cb 06 00 00       	call   800b79 <cprintf>
  8004ae:	83 c4 10             	add    $0x10,%esp

}
  8004b1:	90                   	nop
  8004b2:	c9                   	leave  
  8004b3:	c3                   	ret    

008004b4 <MSort>:


void MSort(int* A, int p, int r)
{
  8004b4:	55                   	push   %ebp
  8004b5:	89 e5                	mov    %esp,%ebp
  8004b7:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  8004ba:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004bd:	3b 45 10             	cmp    0x10(%ebp),%eax
  8004c0:	7d 54                	jge    800516 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  8004c2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8004c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8004c8:	01 d0                	add    %edx,%eax
  8004ca:	89 c2                	mov    %eax,%edx
  8004cc:	c1 ea 1f             	shr    $0x1f,%edx
  8004cf:	01 d0                	add    %edx,%eax
  8004d1:	d1 f8                	sar    %eax
  8004d3:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  8004d6:	83 ec 04             	sub    $0x4,%esp
  8004d9:	ff 75 f4             	pushl  -0xc(%ebp)
  8004dc:	ff 75 0c             	pushl  0xc(%ebp)
  8004df:	ff 75 08             	pushl  0x8(%ebp)
  8004e2:	e8 cd ff ff ff       	call   8004b4 <MSort>
  8004e7:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  8004ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004ed:	40                   	inc    %eax
  8004ee:	83 ec 04             	sub    $0x4,%esp
  8004f1:	ff 75 10             	pushl  0x10(%ebp)
  8004f4:	50                   	push   %eax
  8004f5:	ff 75 08             	pushl  0x8(%ebp)
  8004f8:	e8 b7 ff ff ff       	call   8004b4 <MSort>
  8004fd:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800500:	ff 75 10             	pushl  0x10(%ebp)
  800503:	ff 75 f4             	pushl  -0xc(%ebp)
  800506:	ff 75 0c             	pushl  0xc(%ebp)
  800509:	ff 75 08             	pushl  0x8(%ebp)
  80050c:	e8 08 00 00 00       	call   800519 <Merge>
  800511:	83 c4 10             	add    $0x10,%esp
  800514:	eb 01                	jmp    800517 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800516:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800517:	c9                   	leave  
  800518:	c3                   	ret    

00800519 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800519:	55                   	push   %ebp
  80051a:	89 e5                	mov    %esp,%ebp
  80051c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80051f:	8b 45 10             	mov    0x10(%ebp),%eax
  800522:	2b 45 0c             	sub    0xc(%ebp),%eax
  800525:	40                   	inc    %eax
  800526:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  800529:	8b 45 14             	mov    0x14(%ebp),%eax
  80052c:	2b 45 10             	sub    0x10(%ebp),%eax
  80052f:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  800532:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  800539:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 ba 15 00 00       	call   801b09 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 a5 15 00 00       	call   801b09 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80056a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  800571:	eb 2f                	jmp    8005a2 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  800573:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800576:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80057d:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800580:	01 c2                	add    %eax,%edx
  800582:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800585:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800588:	01 c8                	add    %ecx,%eax
  80058a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80058f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800596:	8b 45 08             	mov    0x8(%ebp),%eax
  800599:	01 c8                	add    %ecx,%eax
  80059b:	8b 00                	mov    (%eax),%eax
  80059d:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80059f:	ff 45 ec             	incl   -0x14(%ebp)
  8005a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005a5:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005a8:	7c c9                	jl     800573 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005aa:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8005b1:	eb 2a                	jmp    8005dd <Merge+0xc4>
	{
		Right[j] = A[q + j];
  8005b3:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005bd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8005c0:	01 c2                	add    %eax,%edx
  8005c2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8005c5:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005c8:	01 c8                	add    %ecx,%eax
  8005ca:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d4:	01 c8                	add    %ecx,%eax
  8005d6:	8b 00                	mov    (%eax),%eax
  8005d8:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  8005da:	ff 45 e8             	incl   -0x18(%ebp)
  8005dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005e0:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  8005e3:	7c ce                	jl     8005b3 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8005e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8005e8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005eb:	e9 0a 01 00 00       	jmp    8006fa <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  8005f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8005f3:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8005f6:	0f 8d 95 00 00 00    	jge    800691 <Merge+0x178>
  8005fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005ff:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800602:	0f 8d 89 00 00 00    	jge    800691 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800608:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80060b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800612:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800615:	01 d0                	add    %edx,%eax
  800617:	8b 10                	mov    (%eax),%edx
  800619:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80061c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800623:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800626:	01 c8                	add    %ecx,%eax
  800628:	8b 00                	mov    (%eax),%eax
  80062a:	39 c2                	cmp    %eax,%edx
  80062c:	7d 33                	jge    800661 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  80062e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800631:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 08             	mov    0x8(%ebp),%eax
  800640:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800643:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800646:	8d 50 01             	lea    0x1(%eax),%edx
  800649:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80064c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800653:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800656:	01 d0                	add    %edx,%eax
  800658:	8b 00                	mov    (%eax),%eax
  80065a:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80065c:	e9 96 00 00 00       	jmp    8006f7 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  800661:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800664:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800669:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800670:	8b 45 08             	mov    0x8(%ebp),%eax
  800673:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800676:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800679:	8d 50 01             	lea    0x1(%eax),%edx
  80067c:	89 55 f0             	mov    %edx,-0x10(%ebp)
  80067f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800686:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800689:	01 d0                	add    %edx,%eax
  80068b:	8b 00                	mov    (%eax),%eax
  80068d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80068f:	eb 66                	jmp    8006f7 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800691:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800694:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800697:	7d 30                	jge    8006c9 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800699:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80069c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006a1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006ab:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006b1:	8d 50 01             	lea    0x1(%eax),%edx
  8006b4:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006b7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006be:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006c1:	01 d0                	add    %edx,%eax
  8006c3:	8b 00                	mov    (%eax),%eax
  8006c5:	89 01                	mov    %eax,(%ecx)
  8006c7:	eb 2e                	jmp    8006f7 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  8006c9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006cc:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006d1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006db:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006de:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006e1:	8d 50 01             	lea    0x1(%eax),%edx
  8006e4:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006e7:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006ee:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006f1:	01 d0                	add    %edx,%eax
  8006f3:	8b 00                	mov    (%eax),%eax
  8006f5:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  8006f7:	ff 45 e4             	incl   -0x1c(%ebp)
  8006fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006fd:	3b 45 14             	cmp    0x14(%ebp),%eax
  800700:	0f 8e ea fe ff ff    	jle    8005f0 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  800706:	90                   	nop
  800707:	c9                   	leave  
  800708:	c3                   	ret    

00800709 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800709:	55                   	push   %ebp
  80070a:	89 e5                	mov    %esp,%ebp
  80070c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80070f:	8b 45 08             	mov    0x8(%ebp),%eax
  800712:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800715:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800719:	83 ec 0c             	sub    $0xc,%esp
  80071c:	50                   	push   %eax
  80071d:	e8 47 17 00 00       	call   801e69 <sys_cputc>
  800722:	83 c4 10             	add    $0x10,%esp
}
  800725:	90                   	nop
  800726:	c9                   	leave  
  800727:	c3                   	ret    

00800728 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800728:	55                   	push   %ebp
  800729:	89 e5                	mov    %esp,%ebp
  80072b:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80072e:	e8 02 17 00 00       	call   801e35 <sys_disable_interrupt>
	char c = ch;
  800733:	8b 45 08             	mov    0x8(%ebp),%eax
  800736:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800739:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80073d:	83 ec 0c             	sub    $0xc,%esp
  800740:	50                   	push   %eax
  800741:	e8 23 17 00 00       	call   801e69 <sys_cputc>
  800746:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800749:	e8 01 17 00 00       	call   801e4f <sys_enable_interrupt>
}
  80074e:	90                   	nop
  80074f:	c9                   	leave  
  800750:	c3                   	ret    

00800751 <getchar>:

int
getchar(void)
{
  800751:	55                   	push   %ebp
  800752:	89 e5                	mov    %esp,%ebp
  800754:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800757:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80075e:	eb 08                	jmp    800768 <getchar+0x17>
	{
		c = sys_cgetc();
  800760:	e8 e8 14 00 00       	call   801c4d <sys_cgetc>
  800765:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800768:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  80076c:	74 f2                	je     800760 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80076e:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800771:	c9                   	leave  
  800772:	c3                   	ret    

00800773 <atomic_getchar>:

int
atomic_getchar(void)
{
  800773:	55                   	push   %ebp
  800774:	89 e5                	mov    %esp,%ebp
  800776:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800779:	e8 b7 16 00 00       	call   801e35 <sys_disable_interrupt>
	int c=0;
  80077e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800785:	eb 08                	jmp    80078f <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800787:	e8 c1 14 00 00       	call   801c4d <sys_cgetc>
  80078c:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80078f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800793:	74 f2                	je     800787 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800795:	e8 b5 16 00 00       	call   801e4f <sys_enable_interrupt>
	return c;
  80079a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80079d:	c9                   	leave  
  80079e:	c3                   	ret    

0080079f <iscons>:

int iscons(int fdnum)
{
  80079f:	55                   	push   %ebp
  8007a0:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007a2:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007a7:	5d                   	pop    %ebp
  8007a8:	c3                   	ret    

008007a9 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007a9:	55                   	push   %ebp
  8007aa:	89 e5                	mov    %esp,%ebp
  8007ac:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007af:	e8 e6 14 00 00       	call   801c9a <sys_getenvindex>
  8007b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007b7:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007ba:	89 d0                	mov    %edx,%eax
  8007bc:	01 c0                	add    %eax,%eax
  8007be:	01 d0                	add    %edx,%eax
  8007c0:	c1 e0 04             	shl    $0x4,%eax
  8007c3:	29 d0                	sub    %edx,%eax
  8007c5:	c1 e0 03             	shl    $0x3,%eax
  8007c8:	01 d0                	add    %edx,%eax
  8007ca:	c1 e0 02             	shl    $0x2,%eax
  8007cd:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007d2:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007d7:	a1 24 30 80 00       	mov    0x803024,%eax
  8007dc:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8007e2:	84 c0                	test   %al,%al
  8007e4:	74 0f                	je     8007f5 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8007e6:	a1 24 30 80 00       	mov    0x803024,%eax
  8007eb:	05 5c 05 00 00       	add    $0x55c,%eax
  8007f0:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8007f5:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8007f9:	7e 0a                	jle    800805 <libmain+0x5c>
		binaryname = argv[0];
  8007fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8007fe:	8b 00                	mov    (%eax),%eax
  800800:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800805:	83 ec 08             	sub    $0x8,%esp
  800808:	ff 75 0c             	pushl  0xc(%ebp)
  80080b:	ff 75 08             	pushl  0x8(%ebp)
  80080e:	e8 25 f8 ff ff       	call   800038 <_main>
  800813:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800816:	e8 1a 16 00 00       	call   801e35 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80081b:	83 ec 0c             	sub    $0xc,%esp
  80081e:	68 d4 26 80 00       	push   $0x8026d4
  800823:	e8 51 03 00 00       	call   800b79 <cprintf>
  800828:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  80082b:	a1 24 30 80 00       	mov    0x803024,%eax
  800830:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800836:	a1 24 30 80 00       	mov    0x803024,%eax
  80083b:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800841:	83 ec 04             	sub    $0x4,%esp
  800844:	52                   	push   %edx
  800845:	50                   	push   %eax
  800846:	68 fc 26 80 00       	push   $0x8026fc
  80084b:	e8 29 03 00 00       	call   800b79 <cprintf>
  800850:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800853:	a1 24 30 80 00       	mov    0x803024,%eax
  800858:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80085e:	a1 24 30 80 00       	mov    0x803024,%eax
  800863:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800869:	a1 24 30 80 00       	mov    0x803024,%eax
  80086e:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800874:	51                   	push   %ecx
  800875:	52                   	push   %edx
  800876:	50                   	push   %eax
  800877:	68 24 27 80 00       	push   $0x802724
  80087c:	e8 f8 02 00 00       	call   800b79 <cprintf>
  800881:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800884:	83 ec 0c             	sub    $0xc,%esp
  800887:	68 d4 26 80 00       	push   $0x8026d4
  80088c:	e8 e8 02 00 00       	call   800b79 <cprintf>
  800891:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800894:	e8 b6 15 00 00       	call   801e4f <sys_enable_interrupt>

	// exit gracefully
	exit();
  800899:	e8 19 00 00 00       	call   8008b7 <exit>
}
  80089e:	90                   	nop
  80089f:	c9                   	leave  
  8008a0:	c3                   	ret    

008008a1 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008a1:	55                   	push   %ebp
  8008a2:	89 e5                	mov    %esp,%ebp
  8008a4:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008a7:	83 ec 0c             	sub    $0xc,%esp
  8008aa:	6a 00                	push   $0x0
  8008ac:	e8 b5 13 00 00       	call   801c66 <sys_env_destroy>
  8008b1:	83 c4 10             	add    $0x10,%esp
}
  8008b4:	90                   	nop
  8008b5:	c9                   	leave  
  8008b6:	c3                   	ret    

008008b7 <exit>:

void
exit(void)
{
  8008b7:	55                   	push   %ebp
  8008b8:	89 e5                	mov    %esp,%ebp
  8008ba:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008bd:	e8 0a 14 00 00       	call   801ccc <sys_env_exit>
}
  8008c2:	90                   	nop
  8008c3:	c9                   	leave  
  8008c4:	c3                   	ret    

008008c5 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008c5:	55                   	push   %ebp
  8008c6:	89 e5                	mov    %esp,%ebp
  8008c8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008cb:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ce:	83 c0 04             	add    $0x4,%eax
  8008d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008d4:	a1 18 31 80 00       	mov    0x803118,%eax
  8008d9:	85 c0                	test   %eax,%eax
  8008db:	74 16                	je     8008f3 <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008dd:	a1 18 31 80 00       	mov    0x803118,%eax
  8008e2:	83 ec 08             	sub    $0x8,%esp
  8008e5:	50                   	push   %eax
  8008e6:	68 7c 27 80 00       	push   $0x80277c
  8008eb:	e8 89 02 00 00       	call   800b79 <cprintf>
  8008f0:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8008f3:	a1 00 30 80 00       	mov    0x803000,%eax
  8008f8:	ff 75 0c             	pushl  0xc(%ebp)
  8008fb:	ff 75 08             	pushl  0x8(%ebp)
  8008fe:	50                   	push   %eax
  8008ff:	68 81 27 80 00       	push   $0x802781
  800904:	e8 70 02 00 00       	call   800b79 <cprintf>
  800909:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80090c:	8b 45 10             	mov    0x10(%ebp),%eax
  80090f:	83 ec 08             	sub    $0x8,%esp
  800912:	ff 75 f4             	pushl  -0xc(%ebp)
  800915:	50                   	push   %eax
  800916:	e8 f3 01 00 00       	call   800b0e <vcprintf>
  80091b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80091e:	83 ec 08             	sub    $0x8,%esp
  800921:	6a 00                	push   $0x0
  800923:	68 9d 27 80 00       	push   $0x80279d
  800928:	e8 e1 01 00 00       	call   800b0e <vcprintf>
  80092d:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800930:	e8 82 ff ff ff       	call   8008b7 <exit>

	// should not return here
	while (1) ;
  800935:	eb fe                	jmp    800935 <_panic+0x70>

00800937 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800937:	55                   	push   %ebp
  800938:	89 e5                	mov    %esp,%ebp
  80093a:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  80093d:	a1 24 30 80 00       	mov    0x803024,%eax
  800942:	8b 50 74             	mov    0x74(%eax),%edx
  800945:	8b 45 0c             	mov    0xc(%ebp),%eax
  800948:	39 c2                	cmp    %eax,%edx
  80094a:	74 14                	je     800960 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  80094c:	83 ec 04             	sub    $0x4,%esp
  80094f:	68 a0 27 80 00       	push   $0x8027a0
  800954:	6a 26                	push   $0x26
  800956:	68 ec 27 80 00       	push   $0x8027ec
  80095b:	e8 65 ff ff ff       	call   8008c5 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800960:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800967:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80096e:	e9 c2 00 00 00       	jmp    800a35 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800973:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800976:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80097d:	8b 45 08             	mov    0x8(%ebp),%eax
  800980:	01 d0                	add    %edx,%eax
  800982:	8b 00                	mov    (%eax),%eax
  800984:	85 c0                	test   %eax,%eax
  800986:	75 08                	jne    800990 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800988:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80098b:	e9 a2 00 00 00       	jmp    800a32 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800990:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800997:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80099e:	eb 69                	jmp    800a09 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009a0:	a1 24 30 80 00       	mov    0x803024,%eax
  8009a5:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8009ab:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009ae:	89 d0                	mov    %edx,%eax
  8009b0:	01 c0                	add    %eax,%eax
  8009b2:	01 d0                	add    %edx,%eax
  8009b4:	c1 e0 03             	shl    $0x3,%eax
  8009b7:	01 c8                	add    %ecx,%eax
  8009b9:	8a 40 04             	mov    0x4(%eax),%al
  8009bc:	84 c0                	test   %al,%al
  8009be:	75 46                	jne    800a06 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009c0:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c5:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8009cb:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009ce:	89 d0                	mov    %edx,%eax
  8009d0:	01 c0                	add    %eax,%eax
  8009d2:	01 d0                	add    %edx,%eax
  8009d4:	c1 e0 03             	shl    $0x3,%eax
  8009d7:	01 c8                	add    %ecx,%eax
  8009d9:	8b 00                	mov    (%eax),%eax
  8009db:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009de:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009e1:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8009e6:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8009e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009eb:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8009f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f5:	01 c8                	add    %ecx,%eax
  8009f7:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009f9:	39 c2                	cmp    %eax,%edx
  8009fb:	75 09                	jne    800a06 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8009fd:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a04:	eb 12                	jmp    800a18 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a06:	ff 45 e8             	incl   -0x18(%ebp)
  800a09:	a1 24 30 80 00       	mov    0x803024,%eax
  800a0e:	8b 50 74             	mov    0x74(%eax),%edx
  800a11:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a14:	39 c2                	cmp    %eax,%edx
  800a16:	77 88                	ja     8009a0 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a18:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a1c:	75 14                	jne    800a32 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a1e:	83 ec 04             	sub    $0x4,%esp
  800a21:	68 f8 27 80 00       	push   $0x8027f8
  800a26:	6a 3a                	push   $0x3a
  800a28:	68 ec 27 80 00       	push   $0x8027ec
  800a2d:	e8 93 fe ff ff       	call   8008c5 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a32:	ff 45 f0             	incl   -0x10(%ebp)
  800a35:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a38:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a3b:	0f 8c 32 ff ff ff    	jl     800973 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a41:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a48:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a4f:	eb 26                	jmp    800a77 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a51:	a1 24 30 80 00       	mov    0x803024,%eax
  800a56:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800a5c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a5f:	89 d0                	mov    %edx,%eax
  800a61:	01 c0                	add    %eax,%eax
  800a63:	01 d0                	add    %edx,%eax
  800a65:	c1 e0 03             	shl    $0x3,%eax
  800a68:	01 c8                	add    %ecx,%eax
  800a6a:	8a 40 04             	mov    0x4(%eax),%al
  800a6d:	3c 01                	cmp    $0x1,%al
  800a6f:	75 03                	jne    800a74 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a71:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a74:	ff 45 e0             	incl   -0x20(%ebp)
  800a77:	a1 24 30 80 00       	mov    0x803024,%eax
  800a7c:	8b 50 74             	mov    0x74(%eax),%edx
  800a7f:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a82:	39 c2                	cmp    %eax,%edx
  800a84:	77 cb                	ja     800a51 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800a86:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800a89:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800a8c:	74 14                	je     800aa2 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800a8e:	83 ec 04             	sub    $0x4,%esp
  800a91:	68 4c 28 80 00       	push   $0x80284c
  800a96:	6a 44                	push   $0x44
  800a98:	68 ec 27 80 00       	push   $0x8027ec
  800a9d:	e8 23 fe ff ff       	call   8008c5 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800aa2:	90                   	nop
  800aa3:	c9                   	leave  
  800aa4:	c3                   	ret    

00800aa5 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800aa5:	55                   	push   %ebp
  800aa6:	89 e5                	mov    %esp,%ebp
  800aa8:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800aab:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aae:	8b 00                	mov    (%eax),%eax
  800ab0:	8d 48 01             	lea    0x1(%eax),%ecx
  800ab3:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ab6:	89 0a                	mov    %ecx,(%edx)
  800ab8:	8b 55 08             	mov    0x8(%ebp),%edx
  800abb:	88 d1                	mov    %dl,%cl
  800abd:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ac0:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ac4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ac7:	8b 00                	mov    (%eax),%eax
  800ac9:	3d ff 00 00 00       	cmp    $0xff,%eax
  800ace:	75 2c                	jne    800afc <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800ad0:	a0 28 30 80 00       	mov    0x803028,%al
  800ad5:	0f b6 c0             	movzbl %al,%eax
  800ad8:	8b 55 0c             	mov    0xc(%ebp),%edx
  800adb:	8b 12                	mov    (%edx),%edx
  800add:	89 d1                	mov    %edx,%ecx
  800adf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ae2:	83 c2 08             	add    $0x8,%edx
  800ae5:	83 ec 04             	sub    $0x4,%esp
  800ae8:	50                   	push   %eax
  800ae9:	51                   	push   %ecx
  800aea:	52                   	push   %edx
  800aeb:	e8 34 11 00 00       	call   801c24 <sys_cputs>
  800af0:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800af3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800af6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800afc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aff:	8b 40 04             	mov    0x4(%eax),%eax
  800b02:	8d 50 01             	lea    0x1(%eax),%edx
  800b05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b08:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b0b:	90                   	nop
  800b0c:	c9                   	leave  
  800b0d:	c3                   	ret    

00800b0e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b0e:	55                   	push   %ebp
  800b0f:	89 e5                	mov    %esp,%ebp
  800b11:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b17:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b1e:	00 00 00 
	b.cnt = 0;
  800b21:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b28:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b2b:	ff 75 0c             	pushl  0xc(%ebp)
  800b2e:	ff 75 08             	pushl  0x8(%ebp)
  800b31:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b37:	50                   	push   %eax
  800b38:	68 a5 0a 80 00       	push   $0x800aa5
  800b3d:	e8 11 02 00 00       	call   800d53 <vprintfmt>
  800b42:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b45:	a0 28 30 80 00       	mov    0x803028,%al
  800b4a:	0f b6 c0             	movzbl %al,%eax
  800b4d:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b53:	83 ec 04             	sub    $0x4,%esp
  800b56:	50                   	push   %eax
  800b57:	52                   	push   %edx
  800b58:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b5e:	83 c0 08             	add    $0x8,%eax
  800b61:	50                   	push   %eax
  800b62:	e8 bd 10 00 00       	call   801c24 <sys_cputs>
  800b67:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b6a:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b71:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b77:	c9                   	leave  
  800b78:	c3                   	ret    

00800b79 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b79:	55                   	push   %ebp
  800b7a:	89 e5                	mov    %esp,%ebp
  800b7c:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b7f:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800b86:	8d 45 0c             	lea    0xc(%ebp),%eax
  800b89:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8f:	83 ec 08             	sub    $0x8,%esp
  800b92:	ff 75 f4             	pushl  -0xc(%ebp)
  800b95:	50                   	push   %eax
  800b96:	e8 73 ff ff ff       	call   800b0e <vcprintf>
  800b9b:	83 c4 10             	add    $0x10,%esp
  800b9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800ba1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800ba4:	c9                   	leave  
  800ba5:	c3                   	ret    

00800ba6 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800ba6:	55                   	push   %ebp
  800ba7:	89 e5                	mov    %esp,%ebp
  800ba9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bac:	e8 84 12 00 00       	call   801e35 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bb1:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bb4:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bb7:	8b 45 08             	mov    0x8(%ebp),%eax
  800bba:	83 ec 08             	sub    $0x8,%esp
  800bbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800bc0:	50                   	push   %eax
  800bc1:	e8 48 ff ff ff       	call   800b0e <vcprintf>
  800bc6:	83 c4 10             	add    $0x10,%esp
  800bc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800bcc:	e8 7e 12 00 00       	call   801e4f <sys_enable_interrupt>
	return cnt;
  800bd1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bd4:	c9                   	leave  
  800bd5:	c3                   	ret    

00800bd6 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bd6:	55                   	push   %ebp
  800bd7:	89 e5                	mov    %esp,%ebp
  800bd9:	53                   	push   %ebx
  800bda:	83 ec 14             	sub    $0x14,%esp
  800bdd:	8b 45 10             	mov    0x10(%ebp),%eax
  800be0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800be3:	8b 45 14             	mov    0x14(%ebp),%eax
  800be6:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800be9:	8b 45 18             	mov    0x18(%ebp),%eax
  800bec:	ba 00 00 00 00       	mov    $0x0,%edx
  800bf1:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bf4:	77 55                	ja     800c4b <printnum+0x75>
  800bf6:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800bf9:	72 05                	jb     800c00 <printnum+0x2a>
  800bfb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800bfe:	77 4b                	ja     800c4b <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c00:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c03:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c06:	8b 45 18             	mov    0x18(%ebp),%eax
  800c09:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0e:	52                   	push   %edx
  800c0f:	50                   	push   %eax
  800c10:	ff 75 f4             	pushl  -0xc(%ebp)
  800c13:	ff 75 f0             	pushl  -0x10(%ebp)
  800c16:	e8 59 16 00 00       	call   802274 <__udivdi3>
  800c1b:	83 c4 10             	add    $0x10,%esp
  800c1e:	83 ec 04             	sub    $0x4,%esp
  800c21:	ff 75 20             	pushl  0x20(%ebp)
  800c24:	53                   	push   %ebx
  800c25:	ff 75 18             	pushl  0x18(%ebp)
  800c28:	52                   	push   %edx
  800c29:	50                   	push   %eax
  800c2a:	ff 75 0c             	pushl  0xc(%ebp)
  800c2d:	ff 75 08             	pushl  0x8(%ebp)
  800c30:	e8 a1 ff ff ff       	call   800bd6 <printnum>
  800c35:	83 c4 20             	add    $0x20,%esp
  800c38:	eb 1a                	jmp    800c54 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c3a:	83 ec 08             	sub    $0x8,%esp
  800c3d:	ff 75 0c             	pushl  0xc(%ebp)
  800c40:	ff 75 20             	pushl  0x20(%ebp)
  800c43:	8b 45 08             	mov    0x8(%ebp),%eax
  800c46:	ff d0                	call   *%eax
  800c48:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c4b:	ff 4d 1c             	decl   0x1c(%ebp)
  800c4e:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c52:	7f e6                	jg     800c3a <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c54:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c57:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c5c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c5f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c62:	53                   	push   %ebx
  800c63:	51                   	push   %ecx
  800c64:	52                   	push   %edx
  800c65:	50                   	push   %eax
  800c66:	e8 19 17 00 00       	call   802384 <__umoddi3>
  800c6b:	83 c4 10             	add    $0x10,%esp
  800c6e:	05 b4 2a 80 00       	add    $0x802ab4,%eax
  800c73:	8a 00                	mov    (%eax),%al
  800c75:	0f be c0             	movsbl %al,%eax
  800c78:	83 ec 08             	sub    $0x8,%esp
  800c7b:	ff 75 0c             	pushl  0xc(%ebp)
  800c7e:	50                   	push   %eax
  800c7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c82:	ff d0                	call   *%eax
  800c84:	83 c4 10             	add    $0x10,%esp
}
  800c87:	90                   	nop
  800c88:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800c8b:	c9                   	leave  
  800c8c:	c3                   	ret    

00800c8d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800c8d:	55                   	push   %ebp
  800c8e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800c90:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800c94:	7e 1c                	jle    800cb2 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800c96:	8b 45 08             	mov    0x8(%ebp),%eax
  800c99:	8b 00                	mov    (%eax),%eax
  800c9b:	8d 50 08             	lea    0x8(%eax),%edx
  800c9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca1:	89 10                	mov    %edx,(%eax)
  800ca3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ca6:	8b 00                	mov    (%eax),%eax
  800ca8:	83 e8 08             	sub    $0x8,%eax
  800cab:	8b 50 04             	mov    0x4(%eax),%edx
  800cae:	8b 00                	mov    (%eax),%eax
  800cb0:	eb 40                	jmp    800cf2 <getuint+0x65>
	else if (lflag)
  800cb2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cb6:	74 1e                	je     800cd6 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbb:	8b 00                	mov    (%eax),%eax
  800cbd:	8d 50 04             	lea    0x4(%eax),%edx
  800cc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc3:	89 10                	mov    %edx,(%eax)
  800cc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc8:	8b 00                	mov    (%eax),%eax
  800cca:	83 e8 04             	sub    $0x4,%eax
  800ccd:	8b 00                	mov    (%eax),%eax
  800ccf:	ba 00 00 00 00       	mov    $0x0,%edx
  800cd4:	eb 1c                	jmp    800cf2 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cd6:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd9:	8b 00                	mov    (%eax),%eax
  800cdb:	8d 50 04             	lea    0x4(%eax),%edx
  800cde:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce1:	89 10                	mov    %edx,(%eax)
  800ce3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce6:	8b 00                	mov    (%eax),%eax
  800ce8:	83 e8 04             	sub    $0x4,%eax
  800ceb:	8b 00                	mov    (%eax),%eax
  800ced:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800cf2:	5d                   	pop    %ebp
  800cf3:	c3                   	ret    

00800cf4 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800cf4:	55                   	push   %ebp
  800cf5:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cf7:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cfb:	7e 1c                	jle    800d19 <getint+0x25>
		return va_arg(*ap, long long);
  800cfd:	8b 45 08             	mov    0x8(%ebp),%eax
  800d00:	8b 00                	mov    (%eax),%eax
  800d02:	8d 50 08             	lea    0x8(%eax),%edx
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
  800d08:	89 10                	mov    %edx,(%eax)
  800d0a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0d:	8b 00                	mov    (%eax),%eax
  800d0f:	83 e8 08             	sub    $0x8,%eax
  800d12:	8b 50 04             	mov    0x4(%eax),%edx
  800d15:	8b 00                	mov    (%eax),%eax
  800d17:	eb 38                	jmp    800d51 <getint+0x5d>
	else if (lflag)
  800d19:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d1d:	74 1a                	je     800d39 <getint+0x45>
		return va_arg(*ap, long);
  800d1f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d22:	8b 00                	mov    (%eax),%eax
  800d24:	8d 50 04             	lea    0x4(%eax),%edx
  800d27:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2a:	89 10                	mov    %edx,(%eax)
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8b 00                	mov    (%eax),%eax
  800d31:	83 e8 04             	sub    $0x4,%eax
  800d34:	8b 00                	mov    (%eax),%eax
  800d36:	99                   	cltd   
  800d37:	eb 18                	jmp    800d51 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d39:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3c:	8b 00                	mov    (%eax),%eax
  800d3e:	8d 50 04             	lea    0x4(%eax),%edx
  800d41:	8b 45 08             	mov    0x8(%ebp),%eax
  800d44:	89 10                	mov    %edx,(%eax)
  800d46:	8b 45 08             	mov    0x8(%ebp),%eax
  800d49:	8b 00                	mov    (%eax),%eax
  800d4b:	83 e8 04             	sub    $0x4,%eax
  800d4e:	8b 00                	mov    (%eax),%eax
  800d50:	99                   	cltd   
}
  800d51:	5d                   	pop    %ebp
  800d52:	c3                   	ret    

00800d53 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d53:	55                   	push   %ebp
  800d54:	89 e5                	mov    %esp,%ebp
  800d56:	56                   	push   %esi
  800d57:	53                   	push   %ebx
  800d58:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d5b:	eb 17                	jmp    800d74 <vprintfmt+0x21>
			if (ch == '\0')
  800d5d:	85 db                	test   %ebx,%ebx
  800d5f:	0f 84 af 03 00 00    	je     801114 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d65:	83 ec 08             	sub    $0x8,%esp
  800d68:	ff 75 0c             	pushl  0xc(%ebp)
  800d6b:	53                   	push   %ebx
  800d6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6f:	ff d0                	call   *%eax
  800d71:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d74:	8b 45 10             	mov    0x10(%ebp),%eax
  800d77:	8d 50 01             	lea    0x1(%eax),%edx
  800d7a:	89 55 10             	mov    %edx,0x10(%ebp)
  800d7d:	8a 00                	mov    (%eax),%al
  800d7f:	0f b6 d8             	movzbl %al,%ebx
  800d82:	83 fb 25             	cmp    $0x25,%ebx
  800d85:	75 d6                	jne    800d5d <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800d87:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800d8b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800d92:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800d99:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800da0:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800da7:	8b 45 10             	mov    0x10(%ebp),%eax
  800daa:	8d 50 01             	lea    0x1(%eax),%edx
  800dad:	89 55 10             	mov    %edx,0x10(%ebp)
  800db0:	8a 00                	mov    (%eax),%al
  800db2:	0f b6 d8             	movzbl %al,%ebx
  800db5:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800db8:	83 f8 55             	cmp    $0x55,%eax
  800dbb:	0f 87 2b 03 00 00    	ja     8010ec <vprintfmt+0x399>
  800dc1:	8b 04 85 d8 2a 80 00 	mov    0x802ad8(,%eax,4),%eax
  800dc8:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800dca:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dce:	eb d7                	jmp    800da7 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dd0:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800dd4:	eb d1                	jmp    800da7 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800dd6:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800ddd:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800de0:	89 d0                	mov    %edx,%eax
  800de2:	c1 e0 02             	shl    $0x2,%eax
  800de5:	01 d0                	add    %edx,%eax
  800de7:	01 c0                	add    %eax,%eax
  800de9:	01 d8                	add    %ebx,%eax
  800deb:	83 e8 30             	sub    $0x30,%eax
  800dee:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800df1:	8b 45 10             	mov    0x10(%ebp),%eax
  800df4:	8a 00                	mov    (%eax),%al
  800df6:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800df9:	83 fb 2f             	cmp    $0x2f,%ebx
  800dfc:	7e 3e                	jle    800e3c <vprintfmt+0xe9>
  800dfe:	83 fb 39             	cmp    $0x39,%ebx
  800e01:	7f 39                	jg     800e3c <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e03:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e06:	eb d5                	jmp    800ddd <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e08:	8b 45 14             	mov    0x14(%ebp),%eax
  800e0b:	83 c0 04             	add    $0x4,%eax
  800e0e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e11:	8b 45 14             	mov    0x14(%ebp),%eax
  800e14:	83 e8 04             	sub    $0x4,%eax
  800e17:	8b 00                	mov    (%eax),%eax
  800e19:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e1c:	eb 1f                	jmp    800e3d <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e22:	79 83                	jns    800da7 <vprintfmt+0x54>
				width = 0;
  800e24:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e2b:	e9 77 ff ff ff       	jmp    800da7 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e30:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e37:	e9 6b ff ff ff       	jmp    800da7 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e3c:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e3d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e41:	0f 89 60 ff ff ff    	jns    800da7 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e47:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e4a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e4d:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e54:	e9 4e ff ff ff       	jmp    800da7 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e59:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e5c:	e9 46 ff ff ff       	jmp    800da7 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e61:	8b 45 14             	mov    0x14(%ebp),%eax
  800e64:	83 c0 04             	add    $0x4,%eax
  800e67:	89 45 14             	mov    %eax,0x14(%ebp)
  800e6a:	8b 45 14             	mov    0x14(%ebp),%eax
  800e6d:	83 e8 04             	sub    $0x4,%eax
  800e70:	8b 00                	mov    (%eax),%eax
  800e72:	83 ec 08             	sub    $0x8,%esp
  800e75:	ff 75 0c             	pushl  0xc(%ebp)
  800e78:	50                   	push   %eax
  800e79:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7c:	ff d0                	call   *%eax
  800e7e:	83 c4 10             	add    $0x10,%esp
			break;
  800e81:	e9 89 02 00 00       	jmp    80110f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800e86:	8b 45 14             	mov    0x14(%ebp),%eax
  800e89:	83 c0 04             	add    $0x4,%eax
  800e8c:	89 45 14             	mov    %eax,0x14(%ebp)
  800e8f:	8b 45 14             	mov    0x14(%ebp),%eax
  800e92:	83 e8 04             	sub    $0x4,%eax
  800e95:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800e97:	85 db                	test   %ebx,%ebx
  800e99:	79 02                	jns    800e9d <vprintfmt+0x14a>
				err = -err;
  800e9b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800e9d:	83 fb 64             	cmp    $0x64,%ebx
  800ea0:	7f 0b                	jg     800ead <vprintfmt+0x15a>
  800ea2:	8b 34 9d 20 29 80 00 	mov    0x802920(,%ebx,4),%esi
  800ea9:	85 f6                	test   %esi,%esi
  800eab:	75 19                	jne    800ec6 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ead:	53                   	push   %ebx
  800eae:	68 c5 2a 80 00       	push   $0x802ac5
  800eb3:	ff 75 0c             	pushl  0xc(%ebp)
  800eb6:	ff 75 08             	pushl  0x8(%ebp)
  800eb9:	e8 5e 02 00 00       	call   80111c <printfmt>
  800ebe:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800ec1:	e9 49 02 00 00       	jmp    80110f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ec6:	56                   	push   %esi
  800ec7:	68 ce 2a 80 00       	push   $0x802ace
  800ecc:	ff 75 0c             	pushl  0xc(%ebp)
  800ecf:	ff 75 08             	pushl  0x8(%ebp)
  800ed2:	e8 45 02 00 00       	call   80111c <printfmt>
  800ed7:	83 c4 10             	add    $0x10,%esp
			break;
  800eda:	e9 30 02 00 00       	jmp    80110f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800edf:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee2:	83 c0 04             	add    $0x4,%eax
  800ee5:	89 45 14             	mov    %eax,0x14(%ebp)
  800ee8:	8b 45 14             	mov    0x14(%ebp),%eax
  800eeb:	83 e8 04             	sub    $0x4,%eax
  800eee:	8b 30                	mov    (%eax),%esi
  800ef0:	85 f6                	test   %esi,%esi
  800ef2:	75 05                	jne    800ef9 <vprintfmt+0x1a6>
				p = "(null)";
  800ef4:	be d1 2a 80 00       	mov    $0x802ad1,%esi
			if (width > 0 && padc != '-')
  800ef9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800efd:	7e 6d                	jle    800f6c <vprintfmt+0x219>
  800eff:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f03:	74 67                	je     800f6c <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f05:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f08:	83 ec 08             	sub    $0x8,%esp
  800f0b:	50                   	push   %eax
  800f0c:	56                   	push   %esi
  800f0d:	e8 12 05 00 00       	call   801424 <strnlen>
  800f12:	83 c4 10             	add    $0x10,%esp
  800f15:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f18:	eb 16                	jmp    800f30 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f1a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f1e:	83 ec 08             	sub    $0x8,%esp
  800f21:	ff 75 0c             	pushl  0xc(%ebp)
  800f24:	50                   	push   %eax
  800f25:	8b 45 08             	mov    0x8(%ebp),%eax
  800f28:	ff d0                	call   *%eax
  800f2a:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f2d:	ff 4d e4             	decl   -0x1c(%ebp)
  800f30:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f34:	7f e4                	jg     800f1a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f36:	eb 34                	jmp    800f6c <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f38:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f3c:	74 1c                	je     800f5a <vprintfmt+0x207>
  800f3e:	83 fb 1f             	cmp    $0x1f,%ebx
  800f41:	7e 05                	jle    800f48 <vprintfmt+0x1f5>
  800f43:	83 fb 7e             	cmp    $0x7e,%ebx
  800f46:	7e 12                	jle    800f5a <vprintfmt+0x207>
					putch('?', putdat);
  800f48:	83 ec 08             	sub    $0x8,%esp
  800f4b:	ff 75 0c             	pushl  0xc(%ebp)
  800f4e:	6a 3f                	push   $0x3f
  800f50:	8b 45 08             	mov    0x8(%ebp),%eax
  800f53:	ff d0                	call   *%eax
  800f55:	83 c4 10             	add    $0x10,%esp
  800f58:	eb 0f                	jmp    800f69 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f5a:	83 ec 08             	sub    $0x8,%esp
  800f5d:	ff 75 0c             	pushl  0xc(%ebp)
  800f60:	53                   	push   %ebx
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	ff d0                	call   *%eax
  800f66:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f69:	ff 4d e4             	decl   -0x1c(%ebp)
  800f6c:	89 f0                	mov    %esi,%eax
  800f6e:	8d 70 01             	lea    0x1(%eax),%esi
  800f71:	8a 00                	mov    (%eax),%al
  800f73:	0f be d8             	movsbl %al,%ebx
  800f76:	85 db                	test   %ebx,%ebx
  800f78:	74 24                	je     800f9e <vprintfmt+0x24b>
  800f7a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f7e:	78 b8                	js     800f38 <vprintfmt+0x1e5>
  800f80:	ff 4d e0             	decl   -0x20(%ebp)
  800f83:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f87:	79 af                	jns    800f38 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f89:	eb 13                	jmp    800f9e <vprintfmt+0x24b>
				putch(' ', putdat);
  800f8b:	83 ec 08             	sub    $0x8,%esp
  800f8e:	ff 75 0c             	pushl  0xc(%ebp)
  800f91:	6a 20                	push   $0x20
  800f93:	8b 45 08             	mov    0x8(%ebp),%eax
  800f96:	ff d0                	call   *%eax
  800f98:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800f9b:	ff 4d e4             	decl   -0x1c(%ebp)
  800f9e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fa2:	7f e7                	jg     800f8b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fa4:	e9 66 01 00 00       	jmp    80110f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fa9:	83 ec 08             	sub    $0x8,%esp
  800fac:	ff 75 e8             	pushl  -0x18(%ebp)
  800faf:	8d 45 14             	lea    0x14(%ebp),%eax
  800fb2:	50                   	push   %eax
  800fb3:	e8 3c fd ff ff       	call   800cf4 <getint>
  800fb8:	83 c4 10             	add    $0x10,%esp
  800fbb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fbe:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fc1:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fc4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fc7:	85 d2                	test   %edx,%edx
  800fc9:	79 23                	jns    800fee <vprintfmt+0x29b>
				putch('-', putdat);
  800fcb:	83 ec 08             	sub    $0x8,%esp
  800fce:	ff 75 0c             	pushl  0xc(%ebp)
  800fd1:	6a 2d                	push   $0x2d
  800fd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd6:	ff d0                	call   *%eax
  800fd8:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800fdb:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fde:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe1:	f7 d8                	neg    %eax
  800fe3:	83 d2 00             	adc    $0x0,%edx
  800fe6:	f7 da                	neg    %edx
  800fe8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800feb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800fee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ff5:	e9 bc 00 00 00       	jmp    8010b6 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800ffa:	83 ec 08             	sub    $0x8,%esp
  800ffd:	ff 75 e8             	pushl  -0x18(%ebp)
  801000:	8d 45 14             	lea    0x14(%ebp),%eax
  801003:	50                   	push   %eax
  801004:	e8 84 fc ff ff       	call   800c8d <getuint>
  801009:	83 c4 10             	add    $0x10,%esp
  80100c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80100f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801012:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801019:	e9 98 00 00 00       	jmp    8010b6 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80101e:	83 ec 08             	sub    $0x8,%esp
  801021:	ff 75 0c             	pushl  0xc(%ebp)
  801024:	6a 58                	push   $0x58
  801026:	8b 45 08             	mov    0x8(%ebp),%eax
  801029:	ff d0                	call   *%eax
  80102b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80102e:	83 ec 08             	sub    $0x8,%esp
  801031:	ff 75 0c             	pushl  0xc(%ebp)
  801034:	6a 58                	push   $0x58
  801036:	8b 45 08             	mov    0x8(%ebp),%eax
  801039:	ff d0                	call   *%eax
  80103b:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80103e:	83 ec 08             	sub    $0x8,%esp
  801041:	ff 75 0c             	pushl  0xc(%ebp)
  801044:	6a 58                	push   $0x58
  801046:	8b 45 08             	mov    0x8(%ebp),%eax
  801049:	ff d0                	call   *%eax
  80104b:	83 c4 10             	add    $0x10,%esp
			break;
  80104e:	e9 bc 00 00 00       	jmp    80110f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801053:	83 ec 08             	sub    $0x8,%esp
  801056:	ff 75 0c             	pushl  0xc(%ebp)
  801059:	6a 30                	push   $0x30
  80105b:	8b 45 08             	mov    0x8(%ebp),%eax
  80105e:	ff d0                	call   *%eax
  801060:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801063:	83 ec 08             	sub    $0x8,%esp
  801066:	ff 75 0c             	pushl  0xc(%ebp)
  801069:	6a 78                	push   $0x78
  80106b:	8b 45 08             	mov    0x8(%ebp),%eax
  80106e:	ff d0                	call   *%eax
  801070:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801073:	8b 45 14             	mov    0x14(%ebp),%eax
  801076:	83 c0 04             	add    $0x4,%eax
  801079:	89 45 14             	mov    %eax,0x14(%ebp)
  80107c:	8b 45 14             	mov    0x14(%ebp),%eax
  80107f:	83 e8 04             	sub    $0x4,%eax
  801082:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801084:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801087:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80108e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801095:	eb 1f                	jmp    8010b6 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801097:	83 ec 08             	sub    $0x8,%esp
  80109a:	ff 75 e8             	pushl  -0x18(%ebp)
  80109d:	8d 45 14             	lea    0x14(%ebp),%eax
  8010a0:	50                   	push   %eax
  8010a1:	e8 e7 fb ff ff       	call   800c8d <getuint>
  8010a6:	83 c4 10             	add    $0x10,%esp
  8010a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010af:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010b6:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010bd:	83 ec 04             	sub    $0x4,%esp
  8010c0:	52                   	push   %edx
  8010c1:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010c4:	50                   	push   %eax
  8010c5:	ff 75 f4             	pushl  -0xc(%ebp)
  8010c8:	ff 75 f0             	pushl  -0x10(%ebp)
  8010cb:	ff 75 0c             	pushl  0xc(%ebp)
  8010ce:	ff 75 08             	pushl  0x8(%ebp)
  8010d1:	e8 00 fb ff ff       	call   800bd6 <printnum>
  8010d6:	83 c4 20             	add    $0x20,%esp
			break;
  8010d9:	eb 34                	jmp    80110f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010db:	83 ec 08             	sub    $0x8,%esp
  8010de:	ff 75 0c             	pushl  0xc(%ebp)
  8010e1:	53                   	push   %ebx
  8010e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e5:	ff d0                	call   *%eax
  8010e7:	83 c4 10             	add    $0x10,%esp
			break;
  8010ea:	eb 23                	jmp    80110f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  8010ec:	83 ec 08             	sub    $0x8,%esp
  8010ef:	ff 75 0c             	pushl  0xc(%ebp)
  8010f2:	6a 25                	push   $0x25
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	ff d0                	call   *%eax
  8010f9:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8010fc:	ff 4d 10             	decl   0x10(%ebp)
  8010ff:	eb 03                	jmp    801104 <vprintfmt+0x3b1>
  801101:	ff 4d 10             	decl   0x10(%ebp)
  801104:	8b 45 10             	mov    0x10(%ebp),%eax
  801107:	48                   	dec    %eax
  801108:	8a 00                	mov    (%eax),%al
  80110a:	3c 25                	cmp    $0x25,%al
  80110c:	75 f3                	jne    801101 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80110e:	90                   	nop
		}
	}
  80110f:	e9 47 fc ff ff       	jmp    800d5b <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801114:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801115:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801118:	5b                   	pop    %ebx
  801119:	5e                   	pop    %esi
  80111a:	5d                   	pop    %ebp
  80111b:	c3                   	ret    

0080111c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80111c:	55                   	push   %ebp
  80111d:	89 e5                	mov    %esp,%ebp
  80111f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  801122:	8d 45 10             	lea    0x10(%ebp),%eax
  801125:	83 c0 04             	add    $0x4,%eax
  801128:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  80112b:	8b 45 10             	mov    0x10(%ebp),%eax
  80112e:	ff 75 f4             	pushl  -0xc(%ebp)
  801131:	50                   	push   %eax
  801132:	ff 75 0c             	pushl  0xc(%ebp)
  801135:	ff 75 08             	pushl  0x8(%ebp)
  801138:	e8 16 fc ff ff       	call   800d53 <vprintfmt>
  80113d:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  801140:	90                   	nop
  801141:	c9                   	leave  
  801142:	c3                   	ret    

00801143 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  801143:	55                   	push   %ebp
  801144:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801146:	8b 45 0c             	mov    0xc(%ebp),%eax
  801149:	8b 40 08             	mov    0x8(%eax),%eax
  80114c:	8d 50 01             	lea    0x1(%eax),%edx
  80114f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801152:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	8b 10                	mov    (%eax),%edx
  80115a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115d:	8b 40 04             	mov    0x4(%eax),%eax
  801160:	39 c2                	cmp    %eax,%edx
  801162:	73 12                	jae    801176 <sprintputch+0x33>
		*b->buf++ = ch;
  801164:	8b 45 0c             	mov    0xc(%ebp),%eax
  801167:	8b 00                	mov    (%eax),%eax
  801169:	8d 48 01             	lea    0x1(%eax),%ecx
  80116c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80116f:	89 0a                	mov    %ecx,(%edx)
  801171:	8b 55 08             	mov    0x8(%ebp),%edx
  801174:	88 10                	mov    %dl,(%eax)
}
  801176:	90                   	nop
  801177:	5d                   	pop    %ebp
  801178:	c3                   	ret    

00801179 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801179:	55                   	push   %ebp
  80117a:	89 e5                	mov    %esp,%ebp
  80117c:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80117f:	8b 45 08             	mov    0x8(%ebp),%eax
  801182:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801185:	8b 45 0c             	mov    0xc(%ebp),%eax
  801188:	8d 50 ff             	lea    -0x1(%eax),%edx
  80118b:	8b 45 08             	mov    0x8(%ebp),%eax
  80118e:	01 d0                	add    %edx,%eax
  801190:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801193:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80119a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80119e:	74 06                	je     8011a6 <vsnprintf+0x2d>
  8011a0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011a4:	7f 07                	jg     8011ad <vsnprintf+0x34>
		return -E_INVAL;
  8011a6:	b8 03 00 00 00       	mov    $0x3,%eax
  8011ab:	eb 20                	jmp    8011cd <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011ad:	ff 75 14             	pushl  0x14(%ebp)
  8011b0:	ff 75 10             	pushl  0x10(%ebp)
  8011b3:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011b6:	50                   	push   %eax
  8011b7:	68 43 11 80 00       	push   $0x801143
  8011bc:	e8 92 fb ff ff       	call   800d53 <vprintfmt>
  8011c1:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011c4:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011c7:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011cd:	c9                   	leave  
  8011ce:	c3                   	ret    

008011cf <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011cf:	55                   	push   %ebp
  8011d0:	89 e5                	mov    %esp,%ebp
  8011d2:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011d5:	8d 45 10             	lea    0x10(%ebp),%eax
  8011d8:	83 c0 04             	add    $0x4,%eax
  8011db:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011de:	8b 45 10             	mov    0x10(%ebp),%eax
  8011e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8011e4:	50                   	push   %eax
  8011e5:	ff 75 0c             	pushl  0xc(%ebp)
  8011e8:	ff 75 08             	pushl  0x8(%ebp)
  8011eb:	e8 89 ff ff ff       	call   801179 <vsnprintf>
  8011f0:	83 c4 10             	add    $0x10,%esp
  8011f3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8011f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011f9:	c9                   	leave  
  8011fa:	c3                   	ret    

008011fb <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8011fb:	55                   	push   %ebp
  8011fc:	89 e5                	mov    %esp,%ebp
  8011fe:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801201:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801205:	74 13                	je     80121a <readline+0x1f>
		cprintf("%s", prompt);
  801207:	83 ec 08             	sub    $0x8,%esp
  80120a:	ff 75 08             	pushl  0x8(%ebp)
  80120d:	68 30 2c 80 00       	push   $0x802c30
  801212:	e8 62 f9 ff ff       	call   800b79 <cprintf>
  801217:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80121a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801221:	83 ec 0c             	sub    $0xc,%esp
  801224:	6a 00                	push   $0x0
  801226:	e8 74 f5 ff ff       	call   80079f <iscons>
  80122b:	83 c4 10             	add    $0x10,%esp
  80122e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801231:	e8 1b f5 ff ff       	call   800751 <getchar>
  801236:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801239:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80123d:	79 22                	jns    801261 <readline+0x66>
			if (c != -E_EOF)
  80123f:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801243:	0f 84 ad 00 00 00    	je     8012f6 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801249:	83 ec 08             	sub    $0x8,%esp
  80124c:	ff 75 ec             	pushl  -0x14(%ebp)
  80124f:	68 33 2c 80 00       	push   $0x802c33
  801254:	e8 20 f9 ff ff       	call   800b79 <cprintf>
  801259:	83 c4 10             	add    $0x10,%esp
			return;
  80125c:	e9 95 00 00 00       	jmp    8012f6 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801261:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801265:	7e 34                	jle    80129b <readline+0xa0>
  801267:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80126e:	7f 2b                	jg     80129b <readline+0xa0>
			if (echoing)
  801270:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801274:	74 0e                	je     801284 <readline+0x89>
				cputchar(c);
  801276:	83 ec 0c             	sub    $0xc,%esp
  801279:	ff 75 ec             	pushl  -0x14(%ebp)
  80127c:	e8 88 f4 ff ff       	call   800709 <cputchar>
  801281:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801284:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801287:	8d 50 01             	lea    0x1(%eax),%edx
  80128a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80128d:	89 c2                	mov    %eax,%edx
  80128f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801292:	01 d0                	add    %edx,%eax
  801294:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801297:	88 10                	mov    %dl,(%eax)
  801299:	eb 56                	jmp    8012f1 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80129b:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80129f:	75 1f                	jne    8012c0 <readline+0xc5>
  8012a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012a5:	7e 19                	jle    8012c0 <readline+0xc5>
			if (echoing)
  8012a7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012ab:	74 0e                	je     8012bb <readline+0xc0>
				cputchar(c);
  8012ad:	83 ec 0c             	sub    $0xc,%esp
  8012b0:	ff 75 ec             	pushl  -0x14(%ebp)
  8012b3:	e8 51 f4 ff ff       	call   800709 <cputchar>
  8012b8:	83 c4 10             	add    $0x10,%esp

			i--;
  8012bb:	ff 4d f4             	decl   -0xc(%ebp)
  8012be:	eb 31                	jmp    8012f1 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012c0:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012c4:	74 0a                	je     8012d0 <readline+0xd5>
  8012c6:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012ca:	0f 85 61 ff ff ff    	jne    801231 <readline+0x36>
			if (echoing)
  8012d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012d4:	74 0e                	je     8012e4 <readline+0xe9>
				cputchar(c);
  8012d6:	83 ec 0c             	sub    $0xc,%esp
  8012d9:	ff 75 ec             	pushl  -0x14(%ebp)
  8012dc:	e8 28 f4 ff ff       	call   800709 <cputchar>
  8012e1:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  8012e4:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ea:	01 d0                	add    %edx,%eax
  8012ec:	c6 00 00             	movb   $0x0,(%eax)
			return;
  8012ef:	eb 06                	jmp    8012f7 <readline+0xfc>
		}
	}
  8012f1:	e9 3b ff ff ff       	jmp    801231 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8012f6:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8012f7:	c9                   	leave  
  8012f8:	c3                   	ret    

008012f9 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8012f9:	55                   	push   %ebp
  8012fa:	89 e5                	mov    %esp,%ebp
  8012fc:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8012ff:	e8 31 0b 00 00       	call   801e35 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801304:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801308:	74 13                	je     80131d <atomic_readline+0x24>
		cprintf("%s", prompt);
  80130a:	83 ec 08             	sub    $0x8,%esp
  80130d:	ff 75 08             	pushl  0x8(%ebp)
  801310:	68 30 2c 80 00       	push   $0x802c30
  801315:	e8 5f f8 ff ff       	call   800b79 <cprintf>
  80131a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80131d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801324:	83 ec 0c             	sub    $0xc,%esp
  801327:	6a 00                	push   $0x0
  801329:	e8 71 f4 ff ff       	call   80079f <iscons>
  80132e:	83 c4 10             	add    $0x10,%esp
  801331:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801334:	e8 18 f4 ff ff       	call   800751 <getchar>
  801339:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  80133c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801340:	79 23                	jns    801365 <atomic_readline+0x6c>
			if (c != -E_EOF)
  801342:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801346:	74 13                	je     80135b <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801348:	83 ec 08             	sub    $0x8,%esp
  80134b:	ff 75 ec             	pushl  -0x14(%ebp)
  80134e:	68 33 2c 80 00       	push   $0x802c33
  801353:	e8 21 f8 ff ff       	call   800b79 <cprintf>
  801358:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  80135b:	e8 ef 0a 00 00       	call   801e4f <sys_enable_interrupt>
			return;
  801360:	e9 9a 00 00 00       	jmp    8013ff <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801365:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801369:	7e 34                	jle    80139f <atomic_readline+0xa6>
  80136b:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  801372:	7f 2b                	jg     80139f <atomic_readline+0xa6>
			if (echoing)
  801374:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801378:	74 0e                	je     801388 <atomic_readline+0x8f>
				cputchar(c);
  80137a:	83 ec 0c             	sub    $0xc,%esp
  80137d:	ff 75 ec             	pushl  -0x14(%ebp)
  801380:	e8 84 f3 ff ff       	call   800709 <cputchar>
  801385:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801388:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80138b:	8d 50 01             	lea    0x1(%eax),%edx
  80138e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801391:	89 c2                	mov    %eax,%edx
  801393:	8b 45 0c             	mov    0xc(%ebp),%eax
  801396:	01 d0                	add    %edx,%eax
  801398:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80139b:	88 10                	mov    %dl,(%eax)
  80139d:	eb 5b                	jmp    8013fa <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80139f:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013a3:	75 1f                	jne    8013c4 <atomic_readline+0xcb>
  8013a5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013a9:	7e 19                	jle    8013c4 <atomic_readline+0xcb>
			if (echoing)
  8013ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013af:	74 0e                	je     8013bf <atomic_readline+0xc6>
				cputchar(c);
  8013b1:	83 ec 0c             	sub    $0xc,%esp
  8013b4:	ff 75 ec             	pushl  -0x14(%ebp)
  8013b7:	e8 4d f3 ff ff       	call   800709 <cputchar>
  8013bc:	83 c4 10             	add    $0x10,%esp
			i--;
  8013bf:	ff 4d f4             	decl   -0xc(%ebp)
  8013c2:	eb 36                	jmp    8013fa <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013c4:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013c8:	74 0a                	je     8013d4 <atomic_readline+0xdb>
  8013ca:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013ce:	0f 85 60 ff ff ff    	jne    801334 <atomic_readline+0x3b>
			if (echoing)
  8013d4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013d8:	74 0e                	je     8013e8 <atomic_readline+0xef>
				cputchar(c);
  8013da:	83 ec 0c             	sub    $0xc,%esp
  8013dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8013e0:	e8 24 f3 ff ff       	call   800709 <cputchar>
  8013e5:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  8013e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8013eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ee:	01 d0                	add    %edx,%eax
  8013f0:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8013f3:	e8 57 0a 00 00       	call   801e4f <sys_enable_interrupt>
			return;
  8013f8:	eb 05                	jmp    8013ff <atomic_readline+0x106>
		}
	}
  8013fa:	e9 35 ff ff ff       	jmp    801334 <atomic_readline+0x3b>
}
  8013ff:	c9                   	leave  
  801400:	c3                   	ret    

00801401 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801401:	55                   	push   %ebp
  801402:	89 e5                	mov    %esp,%ebp
  801404:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801407:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80140e:	eb 06                	jmp    801416 <strlen+0x15>
		n++;
  801410:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801413:	ff 45 08             	incl   0x8(%ebp)
  801416:	8b 45 08             	mov    0x8(%ebp),%eax
  801419:	8a 00                	mov    (%eax),%al
  80141b:	84 c0                	test   %al,%al
  80141d:	75 f1                	jne    801410 <strlen+0xf>
		n++;
	return n;
  80141f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801422:	c9                   	leave  
  801423:	c3                   	ret    

00801424 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801424:	55                   	push   %ebp
  801425:	89 e5                	mov    %esp,%ebp
  801427:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80142a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801431:	eb 09                	jmp    80143c <strnlen+0x18>
		n++;
  801433:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801436:	ff 45 08             	incl   0x8(%ebp)
  801439:	ff 4d 0c             	decl   0xc(%ebp)
  80143c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801440:	74 09                	je     80144b <strnlen+0x27>
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	8a 00                	mov    (%eax),%al
  801447:	84 c0                	test   %al,%al
  801449:	75 e8                	jne    801433 <strnlen+0xf>
		n++;
	return n;
  80144b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80144e:	c9                   	leave  
  80144f:	c3                   	ret    

00801450 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801450:	55                   	push   %ebp
  801451:	89 e5                	mov    %esp,%ebp
  801453:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80145c:	90                   	nop
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8d 50 01             	lea    0x1(%eax),%edx
  801463:	89 55 08             	mov    %edx,0x8(%ebp)
  801466:	8b 55 0c             	mov    0xc(%ebp),%edx
  801469:	8d 4a 01             	lea    0x1(%edx),%ecx
  80146c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80146f:	8a 12                	mov    (%edx),%dl
  801471:	88 10                	mov    %dl,(%eax)
  801473:	8a 00                	mov    (%eax),%al
  801475:	84 c0                	test   %al,%al
  801477:	75 e4                	jne    80145d <strcpy+0xd>
		/* do nothing */;
	return ret;
  801479:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80147c:	c9                   	leave  
  80147d:	c3                   	ret    

0080147e <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80147e:	55                   	push   %ebp
  80147f:	89 e5                	mov    %esp,%ebp
  801481:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801484:	8b 45 08             	mov    0x8(%ebp),%eax
  801487:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80148a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801491:	eb 1f                	jmp    8014b2 <strncpy+0x34>
		*dst++ = *src;
  801493:	8b 45 08             	mov    0x8(%ebp),%eax
  801496:	8d 50 01             	lea    0x1(%eax),%edx
  801499:	89 55 08             	mov    %edx,0x8(%ebp)
  80149c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149f:	8a 12                	mov    (%edx),%dl
  8014a1:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014a3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014a6:	8a 00                	mov    (%eax),%al
  8014a8:	84 c0                	test   %al,%al
  8014aa:	74 03                	je     8014af <strncpy+0x31>
			src++;
  8014ac:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014af:	ff 45 fc             	incl   -0x4(%ebp)
  8014b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014b5:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014b8:	72 d9                	jb     801493 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014ba:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014bd:	c9                   	leave  
  8014be:	c3                   	ret    

008014bf <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014bf:	55                   	push   %ebp
  8014c0:	89 e5                	mov    %esp,%ebp
  8014c2:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014cb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014cf:	74 30                	je     801501 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014d1:	eb 16                	jmp    8014e9 <strlcpy+0x2a>
			*dst++ = *src++;
  8014d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d6:	8d 50 01             	lea    0x1(%eax),%edx
  8014d9:	89 55 08             	mov    %edx,0x8(%ebp)
  8014dc:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014df:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014e2:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014e5:	8a 12                	mov    (%edx),%dl
  8014e7:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  8014e9:	ff 4d 10             	decl   0x10(%ebp)
  8014ec:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014f0:	74 09                	je     8014fb <strlcpy+0x3c>
  8014f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014f5:	8a 00                	mov    (%eax),%al
  8014f7:	84 c0                	test   %al,%al
  8014f9:	75 d8                	jne    8014d3 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8014fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fe:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801501:	8b 55 08             	mov    0x8(%ebp),%edx
  801504:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801507:	29 c2                	sub    %eax,%edx
  801509:	89 d0                	mov    %edx,%eax
}
  80150b:	c9                   	leave  
  80150c:	c3                   	ret    

0080150d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80150d:	55                   	push   %ebp
  80150e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801510:	eb 06                	jmp    801518 <strcmp+0xb>
		p++, q++;
  801512:	ff 45 08             	incl   0x8(%ebp)
  801515:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801518:	8b 45 08             	mov    0x8(%ebp),%eax
  80151b:	8a 00                	mov    (%eax),%al
  80151d:	84 c0                	test   %al,%al
  80151f:	74 0e                	je     80152f <strcmp+0x22>
  801521:	8b 45 08             	mov    0x8(%ebp),%eax
  801524:	8a 10                	mov    (%eax),%dl
  801526:	8b 45 0c             	mov    0xc(%ebp),%eax
  801529:	8a 00                	mov    (%eax),%al
  80152b:	38 c2                	cmp    %al,%dl
  80152d:	74 e3                	je     801512 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80152f:	8b 45 08             	mov    0x8(%ebp),%eax
  801532:	8a 00                	mov    (%eax),%al
  801534:	0f b6 d0             	movzbl %al,%edx
  801537:	8b 45 0c             	mov    0xc(%ebp),%eax
  80153a:	8a 00                	mov    (%eax),%al
  80153c:	0f b6 c0             	movzbl %al,%eax
  80153f:	29 c2                	sub    %eax,%edx
  801541:	89 d0                	mov    %edx,%eax
}
  801543:	5d                   	pop    %ebp
  801544:	c3                   	ret    

00801545 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801545:	55                   	push   %ebp
  801546:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801548:	eb 09                	jmp    801553 <strncmp+0xe>
		n--, p++, q++;
  80154a:	ff 4d 10             	decl   0x10(%ebp)
  80154d:	ff 45 08             	incl   0x8(%ebp)
  801550:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801553:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801557:	74 17                	je     801570 <strncmp+0x2b>
  801559:	8b 45 08             	mov    0x8(%ebp),%eax
  80155c:	8a 00                	mov    (%eax),%al
  80155e:	84 c0                	test   %al,%al
  801560:	74 0e                	je     801570 <strncmp+0x2b>
  801562:	8b 45 08             	mov    0x8(%ebp),%eax
  801565:	8a 10                	mov    (%eax),%dl
  801567:	8b 45 0c             	mov    0xc(%ebp),%eax
  80156a:	8a 00                	mov    (%eax),%al
  80156c:	38 c2                	cmp    %al,%dl
  80156e:	74 da                	je     80154a <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  801570:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801574:	75 07                	jne    80157d <strncmp+0x38>
		return 0;
  801576:	b8 00 00 00 00       	mov    $0x0,%eax
  80157b:	eb 14                	jmp    801591 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80157d:	8b 45 08             	mov    0x8(%ebp),%eax
  801580:	8a 00                	mov    (%eax),%al
  801582:	0f b6 d0             	movzbl %al,%edx
  801585:	8b 45 0c             	mov    0xc(%ebp),%eax
  801588:	8a 00                	mov    (%eax),%al
  80158a:	0f b6 c0             	movzbl %al,%eax
  80158d:	29 c2                	sub    %eax,%edx
  80158f:	89 d0                	mov    %edx,%eax
}
  801591:	5d                   	pop    %ebp
  801592:	c3                   	ret    

00801593 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801593:	55                   	push   %ebp
  801594:	89 e5                	mov    %esp,%ebp
  801596:	83 ec 04             	sub    $0x4,%esp
  801599:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80159f:	eb 12                	jmp    8015b3 <strchr+0x20>
		if (*s == c)
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	8a 00                	mov    (%eax),%al
  8015a6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015a9:	75 05                	jne    8015b0 <strchr+0x1d>
			return (char *) s;
  8015ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ae:	eb 11                	jmp    8015c1 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015b0:	ff 45 08             	incl   0x8(%ebp)
  8015b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b6:	8a 00                	mov    (%eax),%al
  8015b8:	84 c0                	test   %al,%al
  8015ba:	75 e5                	jne    8015a1 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015bc:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015c1:	c9                   	leave  
  8015c2:	c3                   	ret    

008015c3 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015c3:	55                   	push   %ebp
  8015c4:	89 e5                	mov    %esp,%ebp
  8015c6:	83 ec 04             	sub    $0x4,%esp
  8015c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015cc:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015cf:	eb 0d                	jmp    8015de <strfind+0x1b>
		if (*s == c)
  8015d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d4:	8a 00                	mov    (%eax),%al
  8015d6:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015d9:	74 0e                	je     8015e9 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015db:	ff 45 08             	incl   0x8(%ebp)
  8015de:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e1:	8a 00                	mov    (%eax),%al
  8015e3:	84 c0                	test   %al,%al
  8015e5:	75 ea                	jne    8015d1 <strfind+0xe>
  8015e7:	eb 01                	jmp    8015ea <strfind+0x27>
		if (*s == c)
			break;
  8015e9:	90                   	nop
	return (char *) s;
  8015ea:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8015ed:	c9                   	leave  
  8015ee:	c3                   	ret    

008015ef <memset>:


void *
memset(void *v, int c, uint32 n)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
  8015f2:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8015f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8015fb:	8b 45 10             	mov    0x10(%ebp),%eax
  8015fe:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801601:	eb 0e                	jmp    801611 <memset+0x22>
		*p++ = c;
  801603:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801606:	8d 50 01             	lea    0x1(%eax),%edx
  801609:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80160c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80160f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801611:	ff 4d f8             	decl   -0x8(%ebp)
  801614:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801618:	79 e9                	jns    801603 <memset+0x14>
		*p++ = c;

	return v;
  80161a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80161d:	c9                   	leave  
  80161e:	c3                   	ret    

0080161f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80161f:	55                   	push   %ebp
  801620:	89 e5                	mov    %esp,%ebp
  801622:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801625:	8b 45 0c             	mov    0xc(%ebp),%eax
  801628:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80162b:	8b 45 08             	mov    0x8(%ebp),%eax
  80162e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801631:	eb 16                	jmp    801649 <memcpy+0x2a>
		*d++ = *s++;
  801633:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801636:	8d 50 01             	lea    0x1(%eax),%edx
  801639:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80163c:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80163f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801642:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801645:	8a 12                	mov    (%edx),%dl
  801647:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801649:	8b 45 10             	mov    0x10(%ebp),%eax
  80164c:	8d 50 ff             	lea    -0x1(%eax),%edx
  80164f:	89 55 10             	mov    %edx,0x10(%ebp)
  801652:	85 c0                	test   %eax,%eax
  801654:	75 dd                	jne    801633 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801656:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801659:	c9                   	leave  
  80165a:	c3                   	ret    

0080165b <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80165b:	55                   	push   %ebp
  80165c:	89 e5                	mov    %esp,%ebp
  80165e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801661:	8b 45 0c             	mov    0xc(%ebp),%eax
  801664:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801667:	8b 45 08             	mov    0x8(%ebp),%eax
  80166a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80166d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801670:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801673:	73 50                	jae    8016c5 <memmove+0x6a>
  801675:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801678:	8b 45 10             	mov    0x10(%ebp),%eax
  80167b:	01 d0                	add    %edx,%eax
  80167d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801680:	76 43                	jbe    8016c5 <memmove+0x6a>
		s += n;
  801682:	8b 45 10             	mov    0x10(%ebp),%eax
  801685:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801688:	8b 45 10             	mov    0x10(%ebp),%eax
  80168b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80168e:	eb 10                	jmp    8016a0 <memmove+0x45>
			*--d = *--s;
  801690:	ff 4d f8             	decl   -0x8(%ebp)
  801693:	ff 4d fc             	decl   -0x4(%ebp)
  801696:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801699:	8a 10                	mov    (%eax),%dl
  80169b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80169e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a3:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016a6:	89 55 10             	mov    %edx,0x10(%ebp)
  8016a9:	85 c0                	test   %eax,%eax
  8016ab:	75 e3                	jne    801690 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016ad:	eb 23                	jmp    8016d2 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016af:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b2:	8d 50 01             	lea    0x1(%eax),%edx
  8016b5:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016bb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016be:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016c1:	8a 12                	mov    (%edx),%dl
  8016c3:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016c5:	8b 45 10             	mov    0x10(%ebp),%eax
  8016c8:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016cb:	89 55 10             	mov    %edx,0x10(%ebp)
  8016ce:	85 c0                	test   %eax,%eax
  8016d0:	75 dd                	jne    8016af <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016d5:	c9                   	leave  
  8016d6:	c3                   	ret    

008016d7 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016d7:	55                   	push   %ebp
  8016d8:	89 e5                	mov    %esp,%ebp
  8016da:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8016e0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016e3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e6:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8016e9:	eb 2a                	jmp    801715 <memcmp+0x3e>
		if (*s1 != *s2)
  8016eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016ee:	8a 10                	mov    (%eax),%dl
  8016f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016f3:	8a 00                	mov    (%eax),%al
  8016f5:	38 c2                	cmp    %al,%dl
  8016f7:	74 16                	je     80170f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8016f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016fc:	8a 00                	mov    (%eax),%al
  8016fe:	0f b6 d0             	movzbl %al,%edx
  801701:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801704:	8a 00                	mov    (%eax),%al
  801706:	0f b6 c0             	movzbl %al,%eax
  801709:	29 c2                	sub    %eax,%edx
  80170b:	89 d0                	mov    %edx,%eax
  80170d:	eb 18                	jmp    801727 <memcmp+0x50>
		s1++, s2++;
  80170f:	ff 45 fc             	incl   -0x4(%ebp)
  801712:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801715:	8b 45 10             	mov    0x10(%ebp),%eax
  801718:	8d 50 ff             	lea    -0x1(%eax),%edx
  80171b:	89 55 10             	mov    %edx,0x10(%ebp)
  80171e:	85 c0                	test   %eax,%eax
  801720:	75 c9                	jne    8016eb <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801722:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801727:	c9                   	leave  
  801728:	c3                   	ret    

00801729 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801729:	55                   	push   %ebp
  80172a:	89 e5                	mov    %esp,%ebp
  80172c:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80172f:	8b 55 08             	mov    0x8(%ebp),%edx
  801732:	8b 45 10             	mov    0x10(%ebp),%eax
  801735:	01 d0                	add    %edx,%eax
  801737:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80173a:	eb 15                	jmp    801751 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80173c:	8b 45 08             	mov    0x8(%ebp),%eax
  80173f:	8a 00                	mov    (%eax),%al
  801741:	0f b6 d0             	movzbl %al,%edx
  801744:	8b 45 0c             	mov    0xc(%ebp),%eax
  801747:	0f b6 c0             	movzbl %al,%eax
  80174a:	39 c2                	cmp    %eax,%edx
  80174c:	74 0d                	je     80175b <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80174e:	ff 45 08             	incl   0x8(%ebp)
  801751:	8b 45 08             	mov    0x8(%ebp),%eax
  801754:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801757:	72 e3                	jb     80173c <memfind+0x13>
  801759:	eb 01                	jmp    80175c <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80175b:	90                   	nop
	return (void *) s;
  80175c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80175f:	c9                   	leave  
  801760:	c3                   	ret    

00801761 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801761:	55                   	push   %ebp
  801762:	89 e5                	mov    %esp,%ebp
  801764:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801767:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80176e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801775:	eb 03                	jmp    80177a <strtol+0x19>
		s++;
  801777:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80177a:	8b 45 08             	mov    0x8(%ebp),%eax
  80177d:	8a 00                	mov    (%eax),%al
  80177f:	3c 20                	cmp    $0x20,%al
  801781:	74 f4                	je     801777 <strtol+0x16>
  801783:	8b 45 08             	mov    0x8(%ebp),%eax
  801786:	8a 00                	mov    (%eax),%al
  801788:	3c 09                	cmp    $0x9,%al
  80178a:	74 eb                	je     801777 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80178c:	8b 45 08             	mov    0x8(%ebp),%eax
  80178f:	8a 00                	mov    (%eax),%al
  801791:	3c 2b                	cmp    $0x2b,%al
  801793:	75 05                	jne    80179a <strtol+0x39>
		s++;
  801795:	ff 45 08             	incl   0x8(%ebp)
  801798:	eb 13                	jmp    8017ad <strtol+0x4c>
	else if (*s == '-')
  80179a:	8b 45 08             	mov    0x8(%ebp),%eax
  80179d:	8a 00                	mov    (%eax),%al
  80179f:	3c 2d                	cmp    $0x2d,%al
  8017a1:	75 0a                	jne    8017ad <strtol+0x4c>
		s++, neg = 1;
  8017a3:	ff 45 08             	incl   0x8(%ebp)
  8017a6:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017ad:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017b1:	74 06                	je     8017b9 <strtol+0x58>
  8017b3:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017b7:	75 20                	jne    8017d9 <strtol+0x78>
  8017b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bc:	8a 00                	mov    (%eax),%al
  8017be:	3c 30                	cmp    $0x30,%al
  8017c0:	75 17                	jne    8017d9 <strtol+0x78>
  8017c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c5:	40                   	inc    %eax
  8017c6:	8a 00                	mov    (%eax),%al
  8017c8:	3c 78                	cmp    $0x78,%al
  8017ca:	75 0d                	jne    8017d9 <strtol+0x78>
		s += 2, base = 16;
  8017cc:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017d0:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017d7:	eb 28                	jmp    801801 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017d9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017dd:	75 15                	jne    8017f4 <strtol+0x93>
  8017df:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e2:	8a 00                	mov    (%eax),%al
  8017e4:	3c 30                	cmp    $0x30,%al
  8017e6:	75 0c                	jne    8017f4 <strtol+0x93>
		s++, base = 8;
  8017e8:	ff 45 08             	incl   0x8(%ebp)
  8017eb:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8017f2:	eb 0d                	jmp    801801 <strtol+0xa0>
	else if (base == 0)
  8017f4:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017f8:	75 07                	jne    801801 <strtol+0xa0>
		base = 10;
  8017fa:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	8a 00                	mov    (%eax),%al
  801806:	3c 2f                	cmp    $0x2f,%al
  801808:	7e 19                	jle    801823 <strtol+0xc2>
  80180a:	8b 45 08             	mov    0x8(%ebp),%eax
  80180d:	8a 00                	mov    (%eax),%al
  80180f:	3c 39                	cmp    $0x39,%al
  801811:	7f 10                	jg     801823 <strtol+0xc2>
			dig = *s - '0';
  801813:	8b 45 08             	mov    0x8(%ebp),%eax
  801816:	8a 00                	mov    (%eax),%al
  801818:	0f be c0             	movsbl %al,%eax
  80181b:	83 e8 30             	sub    $0x30,%eax
  80181e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801821:	eb 42                	jmp    801865 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801823:	8b 45 08             	mov    0x8(%ebp),%eax
  801826:	8a 00                	mov    (%eax),%al
  801828:	3c 60                	cmp    $0x60,%al
  80182a:	7e 19                	jle    801845 <strtol+0xe4>
  80182c:	8b 45 08             	mov    0x8(%ebp),%eax
  80182f:	8a 00                	mov    (%eax),%al
  801831:	3c 7a                	cmp    $0x7a,%al
  801833:	7f 10                	jg     801845 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801835:	8b 45 08             	mov    0x8(%ebp),%eax
  801838:	8a 00                	mov    (%eax),%al
  80183a:	0f be c0             	movsbl %al,%eax
  80183d:	83 e8 57             	sub    $0x57,%eax
  801840:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801843:	eb 20                	jmp    801865 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801845:	8b 45 08             	mov    0x8(%ebp),%eax
  801848:	8a 00                	mov    (%eax),%al
  80184a:	3c 40                	cmp    $0x40,%al
  80184c:	7e 39                	jle    801887 <strtol+0x126>
  80184e:	8b 45 08             	mov    0x8(%ebp),%eax
  801851:	8a 00                	mov    (%eax),%al
  801853:	3c 5a                	cmp    $0x5a,%al
  801855:	7f 30                	jg     801887 <strtol+0x126>
			dig = *s - 'A' + 10;
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	8a 00                	mov    (%eax),%al
  80185c:	0f be c0             	movsbl %al,%eax
  80185f:	83 e8 37             	sub    $0x37,%eax
  801862:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801865:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801868:	3b 45 10             	cmp    0x10(%ebp),%eax
  80186b:	7d 19                	jge    801886 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80186d:	ff 45 08             	incl   0x8(%ebp)
  801870:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801873:	0f af 45 10          	imul   0x10(%ebp),%eax
  801877:	89 c2                	mov    %eax,%edx
  801879:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80187c:	01 d0                	add    %edx,%eax
  80187e:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801881:	e9 7b ff ff ff       	jmp    801801 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801886:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801887:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80188b:	74 08                	je     801895 <strtol+0x134>
		*endptr = (char *) s;
  80188d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801890:	8b 55 08             	mov    0x8(%ebp),%edx
  801893:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801895:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801899:	74 07                	je     8018a2 <strtol+0x141>
  80189b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80189e:	f7 d8                	neg    %eax
  8018a0:	eb 03                	jmp    8018a5 <strtol+0x144>
  8018a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018a5:	c9                   	leave  
  8018a6:	c3                   	ret    

008018a7 <ltostr>:

void
ltostr(long value, char *str)
{
  8018a7:	55                   	push   %ebp
  8018a8:	89 e5                	mov    %esp,%ebp
  8018aa:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018bb:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018bf:	79 13                	jns    8018d4 <ltostr+0x2d>
	{
		neg = 1;
  8018c1:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018cb:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018ce:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018d1:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d7:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018dc:	99                   	cltd   
  8018dd:	f7 f9                	idiv   %ecx
  8018df:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018e5:	8d 50 01             	lea    0x1(%eax),%edx
  8018e8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8018eb:	89 c2                	mov    %eax,%edx
  8018ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018f0:	01 d0                	add    %edx,%eax
  8018f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8018f5:	83 c2 30             	add    $0x30,%edx
  8018f8:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8018fa:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018fd:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801902:	f7 e9                	imul   %ecx
  801904:	c1 fa 02             	sar    $0x2,%edx
  801907:	89 c8                	mov    %ecx,%eax
  801909:	c1 f8 1f             	sar    $0x1f,%eax
  80190c:	29 c2                	sub    %eax,%edx
  80190e:	89 d0                	mov    %edx,%eax
  801910:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801913:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801916:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80191b:	f7 e9                	imul   %ecx
  80191d:	c1 fa 02             	sar    $0x2,%edx
  801920:	89 c8                	mov    %ecx,%eax
  801922:	c1 f8 1f             	sar    $0x1f,%eax
  801925:	29 c2                	sub    %eax,%edx
  801927:	89 d0                	mov    %edx,%eax
  801929:	c1 e0 02             	shl    $0x2,%eax
  80192c:	01 d0                	add    %edx,%eax
  80192e:	01 c0                	add    %eax,%eax
  801930:	29 c1                	sub    %eax,%ecx
  801932:	89 ca                	mov    %ecx,%edx
  801934:	85 d2                	test   %edx,%edx
  801936:	75 9c                	jne    8018d4 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801938:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80193f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801942:	48                   	dec    %eax
  801943:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801946:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80194a:	74 3d                	je     801989 <ltostr+0xe2>
		start = 1 ;
  80194c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801953:	eb 34                	jmp    801989 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801955:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801958:	8b 45 0c             	mov    0xc(%ebp),%eax
  80195b:	01 d0                	add    %edx,%eax
  80195d:	8a 00                	mov    (%eax),%al
  80195f:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801962:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801965:	8b 45 0c             	mov    0xc(%ebp),%eax
  801968:	01 c2                	add    %eax,%edx
  80196a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80196d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801970:	01 c8                	add    %ecx,%eax
  801972:	8a 00                	mov    (%eax),%al
  801974:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801976:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801979:	8b 45 0c             	mov    0xc(%ebp),%eax
  80197c:	01 c2                	add    %eax,%edx
  80197e:	8a 45 eb             	mov    -0x15(%ebp),%al
  801981:	88 02                	mov    %al,(%edx)
		start++ ;
  801983:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801986:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801989:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80198c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80198f:	7c c4                	jl     801955 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801991:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801994:	8b 45 0c             	mov    0xc(%ebp),%eax
  801997:	01 d0                	add    %edx,%eax
  801999:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80199c:	90                   	nop
  80199d:	c9                   	leave  
  80199e:	c3                   	ret    

0080199f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  80199f:	55                   	push   %ebp
  8019a0:	89 e5                	mov    %esp,%ebp
  8019a2:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019a5:	ff 75 08             	pushl  0x8(%ebp)
  8019a8:	e8 54 fa ff ff       	call   801401 <strlen>
  8019ad:	83 c4 04             	add    $0x4,%esp
  8019b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019b3:	ff 75 0c             	pushl  0xc(%ebp)
  8019b6:	e8 46 fa ff ff       	call   801401 <strlen>
  8019bb:	83 c4 04             	add    $0x4,%esp
  8019be:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019c1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019cf:	eb 17                	jmp    8019e8 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019d1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019d4:	8b 45 10             	mov    0x10(%ebp),%eax
  8019d7:	01 c2                	add    %eax,%edx
  8019d9:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8019df:	01 c8                	add    %ecx,%eax
  8019e1:	8a 00                	mov    (%eax),%al
  8019e3:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8019e5:	ff 45 fc             	incl   -0x4(%ebp)
  8019e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8019eb:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8019ee:	7c e1                	jl     8019d1 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8019f0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8019f7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8019fe:	eb 1f                	jmp    801a1f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a00:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a03:	8d 50 01             	lea    0x1(%eax),%edx
  801a06:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a09:	89 c2                	mov    %eax,%edx
  801a0b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a0e:	01 c2                	add    %eax,%edx
  801a10:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a13:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a16:	01 c8                	add    %ecx,%eax
  801a18:	8a 00                	mov    (%eax),%al
  801a1a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a1c:	ff 45 f8             	incl   -0x8(%ebp)
  801a1f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a22:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a25:	7c d9                	jl     801a00 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a27:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a2a:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2d:	01 d0                	add    %edx,%eax
  801a2f:	c6 00 00             	movb   $0x0,(%eax)
}
  801a32:	90                   	nop
  801a33:	c9                   	leave  
  801a34:	c3                   	ret    

00801a35 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a35:	55                   	push   %ebp
  801a36:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a38:	8b 45 14             	mov    0x14(%ebp),%eax
  801a3b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a41:	8b 45 14             	mov    0x14(%ebp),%eax
  801a44:	8b 00                	mov    (%eax),%eax
  801a46:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a4d:	8b 45 10             	mov    0x10(%ebp),%eax
  801a50:	01 d0                	add    %edx,%eax
  801a52:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a58:	eb 0c                	jmp    801a66 <strsplit+0x31>
			*string++ = 0;
  801a5a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5d:	8d 50 01             	lea    0x1(%eax),%edx
  801a60:	89 55 08             	mov    %edx,0x8(%ebp)
  801a63:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a66:	8b 45 08             	mov    0x8(%ebp),%eax
  801a69:	8a 00                	mov    (%eax),%al
  801a6b:	84 c0                	test   %al,%al
  801a6d:	74 18                	je     801a87 <strsplit+0x52>
  801a6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801a72:	8a 00                	mov    (%eax),%al
  801a74:	0f be c0             	movsbl %al,%eax
  801a77:	50                   	push   %eax
  801a78:	ff 75 0c             	pushl  0xc(%ebp)
  801a7b:	e8 13 fb ff ff       	call   801593 <strchr>
  801a80:	83 c4 08             	add    $0x8,%esp
  801a83:	85 c0                	test   %eax,%eax
  801a85:	75 d3                	jne    801a5a <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801a87:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8a:	8a 00                	mov    (%eax),%al
  801a8c:	84 c0                	test   %al,%al
  801a8e:	74 5a                	je     801aea <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801a90:	8b 45 14             	mov    0x14(%ebp),%eax
  801a93:	8b 00                	mov    (%eax),%eax
  801a95:	83 f8 0f             	cmp    $0xf,%eax
  801a98:	75 07                	jne    801aa1 <strsplit+0x6c>
		{
			return 0;
  801a9a:	b8 00 00 00 00       	mov    $0x0,%eax
  801a9f:	eb 66                	jmp    801b07 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801aa1:	8b 45 14             	mov    0x14(%ebp),%eax
  801aa4:	8b 00                	mov    (%eax),%eax
  801aa6:	8d 48 01             	lea    0x1(%eax),%ecx
  801aa9:	8b 55 14             	mov    0x14(%ebp),%edx
  801aac:	89 0a                	mov    %ecx,(%edx)
  801aae:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ab5:	8b 45 10             	mov    0x10(%ebp),%eax
  801ab8:	01 c2                	add    %eax,%edx
  801aba:	8b 45 08             	mov    0x8(%ebp),%eax
  801abd:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801abf:	eb 03                	jmp    801ac4 <strsplit+0x8f>
			string++;
  801ac1:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ac4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ac7:	8a 00                	mov    (%eax),%al
  801ac9:	84 c0                	test   %al,%al
  801acb:	74 8b                	je     801a58 <strsplit+0x23>
  801acd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad0:	8a 00                	mov    (%eax),%al
  801ad2:	0f be c0             	movsbl %al,%eax
  801ad5:	50                   	push   %eax
  801ad6:	ff 75 0c             	pushl  0xc(%ebp)
  801ad9:	e8 b5 fa ff ff       	call   801593 <strchr>
  801ade:	83 c4 08             	add    $0x8,%esp
  801ae1:	85 c0                	test   %eax,%eax
  801ae3:	74 dc                	je     801ac1 <strsplit+0x8c>
			string++;
	}
  801ae5:	e9 6e ff ff ff       	jmp    801a58 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801aea:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801aeb:	8b 45 14             	mov    0x14(%ebp),%eax
  801aee:	8b 00                	mov    (%eax),%eax
  801af0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801af7:	8b 45 10             	mov    0x10(%ebp),%eax
  801afa:	01 d0                	add    %edx,%eax
  801afc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b02:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b07:	c9                   	leave  
  801b08:	c3                   	ret    

00801b09 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801b09:	55                   	push   %ebp
  801b0a:	89 e5                	mov    %esp,%ebp
  801b0c:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801b0f:	83 ec 04             	sub    $0x4,%esp
  801b12:	68 44 2c 80 00       	push   $0x802c44
  801b17:	6a 15                	push   $0x15
  801b19:	68 69 2c 80 00       	push   $0x802c69
  801b1e:	e8 a2 ed ff ff       	call   8008c5 <_panic>

00801b23 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b23:	55                   	push   %ebp
  801b24:	89 e5                	mov    %esp,%ebp
  801b26:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b29:	83 ec 04             	sub    $0x4,%esp
  801b2c:	68 78 2c 80 00       	push   $0x802c78
  801b31:	6a 2e                	push   $0x2e
  801b33:	68 69 2c 80 00       	push   $0x802c69
  801b38:	e8 88 ed ff ff       	call   8008c5 <_panic>

00801b3d <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b3d:	55                   	push   %ebp
  801b3e:	89 e5                	mov    %esp,%ebp
  801b40:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b43:	83 ec 04             	sub    $0x4,%esp
  801b46:	68 9c 2c 80 00       	push   $0x802c9c
  801b4b:	6a 4c                	push   $0x4c
  801b4d:	68 69 2c 80 00       	push   $0x802c69
  801b52:	e8 6e ed ff ff       	call   8008c5 <_panic>

00801b57 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b57:	55                   	push   %ebp
  801b58:	89 e5                	mov    %esp,%ebp
  801b5a:	83 ec 18             	sub    $0x18,%esp
  801b5d:	8b 45 10             	mov    0x10(%ebp),%eax
  801b60:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b63:	83 ec 04             	sub    $0x4,%esp
  801b66:	68 9c 2c 80 00       	push   $0x802c9c
  801b6b:	6a 57                	push   $0x57
  801b6d:	68 69 2c 80 00       	push   $0x802c69
  801b72:	e8 4e ed ff ff       	call   8008c5 <_panic>

00801b77 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b77:	55                   	push   %ebp
  801b78:	89 e5                	mov    %esp,%ebp
  801b7a:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b7d:	83 ec 04             	sub    $0x4,%esp
  801b80:	68 9c 2c 80 00       	push   $0x802c9c
  801b85:	6a 5d                	push   $0x5d
  801b87:	68 69 2c 80 00       	push   $0x802c69
  801b8c:	e8 34 ed ff ff       	call   8008c5 <_panic>

00801b91 <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801b91:	55                   	push   %ebp
  801b92:	89 e5                	mov    %esp,%ebp
  801b94:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b97:	83 ec 04             	sub    $0x4,%esp
  801b9a:	68 9c 2c 80 00       	push   $0x802c9c
  801b9f:	6a 63                	push   $0x63
  801ba1:	68 69 2c 80 00       	push   $0x802c69
  801ba6:	e8 1a ed ff ff       	call   8008c5 <_panic>

00801bab <expand>:
}

void expand(uint32 newSize)
{
  801bab:	55                   	push   %ebp
  801bac:	89 e5                	mov    %esp,%ebp
  801bae:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bb1:	83 ec 04             	sub    $0x4,%esp
  801bb4:	68 9c 2c 80 00       	push   $0x802c9c
  801bb9:	6a 68                	push   $0x68
  801bbb:	68 69 2c 80 00       	push   $0x802c69
  801bc0:	e8 00 ed ff ff       	call   8008c5 <_panic>

00801bc5 <shrink>:
}
void shrink(uint32 newSize)
{
  801bc5:	55                   	push   %ebp
  801bc6:	89 e5                	mov    %esp,%ebp
  801bc8:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bcb:	83 ec 04             	sub    $0x4,%esp
  801bce:	68 9c 2c 80 00       	push   $0x802c9c
  801bd3:	6a 6c                	push   $0x6c
  801bd5:	68 69 2c 80 00       	push   $0x802c69
  801bda:	e8 e6 ec ff ff       	call   8008c5 <_panic>

00801bdf <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801bdf:	55                   	push   %ebp
  801be0:	89 e5                	mov    %esp,%ebp
  801be2:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801be5:	83 ec 04             	sub    $0x4,%esp
  801be8:	68 9c 2c 80 00       	push   $0x802c9c
  801bed:	6a 71                	push   $0x71
  801bef:	68 69 2c 80 00       	push   $0x802c69
  801bf4:	e8 cc ec ff ff       	call   8008c5 <_panic>

00801bf9 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801bf9:	55                   	push   %ebp
  801bfa:	89 e5                	mov    %esp,%ebp
  801bfc:	57                   	push   %edi
  801bfd:	56                   	push   %esi
  801bfe:	53                   	push   %ebx
  801bff:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c02:	8b 45 08             	mov    0x8(%ebp),%eax
  801c05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c08:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c0b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c0e:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c11:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c14:	cd 30                	int    $0x30
  801c16:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c19:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c1c:	83 c4 10             	add    $0x10,%esp
  801c1f:	5b                   	pop    %ebx
  801c20:	5e                   	pop    %esi
  801c21:	5f                   	pop    %edi
  801c22:	5d                   	pop    %ebp
  801c23:	c3                   	ret    

00801c24 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
  801c27:	83 ec 04             	sub    $0x4,%esp
  801c2a:	8b 45 10             	mov    0x10(%ebp),%eax
  801c2d:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c30:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c34:	8b 45 08             	mov    0x8(%ebp),%eax
  801c37:	6a 00                	push   $0x0
  801c39:	6a 00                	push   $0x0
  801c3b:	52                   	push   %edx
  801c3c:	ff 75 0c             	pushl  0xc(%ebp)
  801c3f:	50                   	push   %eax
  801c40:	6a 00                	push   $0x0
  801c42:	e8 b2 ff ff ff       	call   801bf9 <syscall>
  801c47:	83 c4 18             	add    $0x18,%esp
}
  801c4a:	90                   	nop
  801c4b:	c9                   	leave  
  801c4c:	c3                   	ret    

00801c4d <sys_cgetc>:

int
sys_cgetc(void)
{
  801c4d:	55                   	push   %ebp
  801c4e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c50:	6a 00                	push   $0x0
  801c52:	6a 00                	push   $0x0
  801c54:	6a 00                	push   $0x0
  801c56:	6a 00                	push   $0x0
  801c58:	6a 00                	push   $0x0
  801c5a:	6a 01                	push   $0x1
  801c5c:	e8 98 ff ff ff       	call   801bf9 <syscall>
  801c61:	83 c4 18             	add    $0x18,%esp
}
  801c64:	c9                   	leave  
  801c65:	c3                   	ret    

00801c66 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c66:	55                   	push   %ebp
  801c67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c69:	8b 45 08             	mov    0x8(%ebp),%eax
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	50                   	push   %eax
  801c75:	6a 05                	push   $0x5
  801c77:	e8 7d ff ff ff       	call   801bf9 <syscall>
  801c7c:	83 c4 18             	add    $0x18,%esp
}
  801c7f:	c9                   	leave  
  801c80:	c3                   	ret    

00801c81 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c81:	55                   	push   %ebp
  801c82:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 02                	push   $0x2
  801c90:	e8 64 ff ff ff       	call   801bf9 <syscall>
  801c95:	83 c4 18             	add    $0x18,%esp
}
  801c98:	c9                   	leave  
  801c99:	c3                   	ret    

00801c9a <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801c9a:	55                   	push   %ebp
  801c9b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801c9d:	6a 00                	push   $0x0
  801c9f:	6a 00                	push   $0x0
  801ca1:	6a 00                	push   $0x0
  801ca3:	6a 00                	push   $0x0
  801ca5:	6a 00                	push   $0x0
  801ca7:	6a 03                	push   $0x3
  801ca9:	e8 4b ff ff ff       	call   801bf9 <syscall>
  801cae:	83 c4 18             	add    $0x18,%esp
}
  801cb1:	c9                   	leave  
  801cb2:	c3                   	ret    

00801cb3 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801cb3:	55                   	push   %ebp
  801cb4:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cb6:	6a 00                	push   $0x0
  801cb8:	6a 00                	push   $0x0
  801cba:	6a 00                	push   $0x0
  801cbc:	6a 00                	push   $0x0
  801cbe:	6a 00                	push   $0x0
  801cc0:	6a 04                	push   $0x4
  801cc2:	e8 32 ff ff ff       	call   801bf9 <syscall>
  801cc7:	83 c4 18             	add    $0x18,%esp
}
  801cca:	c9                   	leave  
  801ccb:	c3                   	ret    

00801ccc <sys_env_exit>:


void sys_env_exit(void)
{
  801ccc:	55                   	push   %ebp
  801ccd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ccf:	6a 00                	push   $0x0
  801cd1:	6a 00                	push   $0x0
  801cd3:	6a 00                	push   $0x0
  801cd5:	6a 00                	push   $0x0
  801cd7:	6a 00                	push   $0x0
  801cd9:	6a 06                	push   $0x6
  801cdb:	e8 19 ff ff ff       	call   801bf9 <syscall>
  801ce0:	83 c4 18             	add    $0x18,%esp
}
  801ce3:	90                   	nop
  801ce4:	c9                   	leave  
  801ce5:	c3                   	ret    

00801ce6 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801ce6:	55                   	push   %ebp
  801ce7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801ce9:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cec:	8b 45 08             	mov    0x8(%ebp),%eax
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	52                   	push   %edx
  801cf6:	50                   	push   %eax
  801cf7:	6a 07                	push   $0x7
  801cf9:	e8 fb fe ff ff       	call   801bf9 <syscall>
  801cfe:	83 c4 18             	add    $0x18,%esp
}
  801d01:	c9                   	leave  
  801d02:	c3                   	ret    

00801d03 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d03:	55                   	push   %ebp
  801d04:	89 e5                	mov    %esp,%ebp
  801d06:	56                   	push   %esi
  801d07:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d08:	8b 75 18             	mov    0x18(%ebp),%esi
  801d0b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d0e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d11:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d14:	8b 45 08             	mov    0x8(%ebp),%eax
  801d17:	56                   	push   %esi
  801d18:	53                   	push   %ebx
  801d19:	51                   	push   %ecx
  801d1a:	52                   	push   %edx
  801d1b:	50                   	push   %eax
  801d1c:	6a 08                	push   $0x8
  801d1e:	e8 d6 fe ff ff       	call   801bf9 <syscall>
  801d23:	83 c4 18             	add    $0x18,%esp
}
  801d26:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d29:	5b                   	pop    %ebx
  801d2a:	5e                   	pop    %esi
  801d2b:	5d                   	pop    %ebp
  801d2c:	c3                   	ret    

00801d2d <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d2d:	55                   	push   %ebp
  801d2e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d30:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d33:	8b 45 08             	mov    0x8(%ebp),%eax
  801d36:	6a 00                	push   $0x0
  801d38:	6a 00                	push   $0x0
  801d3a:	6a 00                	push   $0x0
  801d3c:	52                   	push   %edx
  801d3d:	50                   	push   %eax
  801d3e:	6a 09                	push   $0x9
  801d40:	e8 b4 fe ff ff       	call   801bf9 <syscall>
  801d45:	83 c4 18             	add    $0x18,%esp
}
  801d48:	c9                   	leave  
  801d49:	c3                   	ret    

00801d4a <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d4a:	55                   	push   %ebp
  801d4b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d4d:	6a 00                	push   $0x0
  801d4f:	6a 00                	push   $0x0
  801d51:	6a 00                	push   $0x0
  801d53:	ff 75 0c             	pushl  0xc(%ebp)
  801d56:	ff 75 08             	pushl  0x8(%ebp)
  801d59:	6a 0a                	push   $0xa
  801d5b:	e8 99 fe ff ff       	call   801bf9 <syscall>
  801d60:	83 c4 18             	add    $0x18,%esp
}
  801d63:	c9                   	leave  
  801d64:	c3                   	ret    

00801d65 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d68:	6a 00                	push   $0x0
  801d6a:	6a 00                	push   $0x0
  801d6c:	6a 00                	push   $0x0
  801d6e:	6a 00                	push   $0x0
  801d70:	6a 00                	push   $0x0
  801d72:	6a 0b                	push   $0xb
  801d74:	e8 80 fe ff ff       	call   801bf9 <syscall>
  801d79:	83 c4 18             	add    $0x18,%esp
}
  801d7c:	c9                   	leave  
  801d7d:	c3                   	ret    

00801d7e <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d7e:	55                   	push   %ebp
  801d7f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	6a 0c                	push   $0xc
  801d8d:	e8 67 fe ff ff       	call   801bf9 <syscall>
  801d92:	83 c4 18             	add    $0x18,%esp
}
  801d95:	c9                   	leave  
  801d96:	c3                   	ret    

00801d97 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801d97:	55                   	push   %ebp
  801d98:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	6a 00                	push   $0x0
  801da4:	6a 0d                	push   $0xd
  801da6:	e8 4e fe ff ff       	call   801bf9 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	c9                   	leave  
  801daf:	c3                   	ret    

00801db0 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801db3:	6a 00                	push   $0x0
  801db5:	6a 00                	push   $0x0
  801db7:	6a 00                	push   $0x0
  801db9:	ff 75 0c             	pushl  0xc(%ebp)
  801dbc:	ff 75 08             	pushl  0x8(%ebp)
  801dbf:	6a 11                	push   $0x11
  801dc1:	e8 33 fe ff ff       	call   801bf9 <syscall>
  801dc6:	83 c4 18             	add    $0x18,%esp
	return;
  801dc9:	90                   	nop
}
  801dca:	c9                   	leave  
  801dcb:	c3                   	ret    

00801dcc <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801dcc:	55                   	push   %ebp
  801dcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	ff 75 0c             	pushl  0xc(%ebp)
  801dd8:	ff 75 08             	pushl  0x8(%ebp)
  801ddb:	6a 12                	push   $0x12
  801ddd:	e8 17 fe ff ff       	call   801bf9 <syscall>
  801de2:	83 c4 18             	add    $0x18,%esp
	return ;
  801de5:	90                   	nop
}
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	6a 00                	push   $0x0
  801df3:	6a 00                	push   $0x0
  801df5:	6a 0e                	push   $0xe
  801df7:	e8 fd fd ff ff       	call   801bf9 <syscall>
  801dfc:	83 c4 18             	add    $0x18,%esp
}
  801dff:	c9                   	leave  
  801e00:	c3                   	ret    

00801e01 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e01:	55                   	push   %ebp
  801e02:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e04:	6a 00                	push   $0x0
  801e06:	6a 00                	push   $0x0
  801e08:	6a 00                	push   $0x0
  801e0a:	6a 00                	push   $0x0
  801e0c:	ff 75 08             	pushl  0x8(%ebp)
  801e0f:	6a 0f                	push   $0xf
  801e11:	e8 e3 fd ff ff       	call   801bf9 <syscall>
  801e16:	83 c4 18             	add    $0x18,%esp
}
  801e19:	c9                   	leave  
  801e1a:	c3                   	ret    

00801e1b <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e1b:	55                   	push   %ebp
  801e1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e1e:	6a 00                	push   $0x0
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	6a 10                	push   $0x10
  801e2a:	e8 ca fd ff ff       	call   801bf9 <syscall>
  801e2f:	83 c4 18             	add    $0x18,%esp
}
  801e32:	90                   	nop
  801e33:	c9                   	leave  
  801e34:	c3                   	ret    

00801e35 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e35:	55                   	push   %ebp
  801e36:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e38:	6a 00                	push   $0x0
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 14                	push   $0x14
  801e44:	e8 b0 fd ff ff       	call   801bf9 <syscall>
  801e49:	83 c4 18             	add    $0x18,%esp
}
  801e4c:	90                   	nop
  801e4d:	c9                   	leave  
  801e4e:	c3                   	ret    

00801e4f <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e4f:	55                   	push   %ebp
  801e50:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e52:	6a 00                	push   $0x0
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 15                	push   $0x15
  801e5e:	e8 96 fd ff ff       	call   801bf9 <syscall>
  801e63:	83 c4 18             	add    $0x18,%esp
}
  801e66:	90                   	nop
  801e67:	c9                   	leave  
  801e68:	c3                   	ret    

00801e69 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e69:	55                   	push   %ebp
  801e6a:	89 e5                	mov    %esp,%ebp
  801e6c:	83 ec 04             	sub    $0x4,%esp
  801e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  801e72:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e75:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	6a 00                	push   $0x0
  801e7f:	6a 00                	push   $0x0
  801e81:	50                   	push   %eax
  801e82:	6a 16                	push   $0x16
  801e84:	e8 70 fd ff ff       	call   801bf9 <syscall>
  801e89:	83 c4 18             	add    $0x18,%esp
}
  801e8c:	90                   	nop
  801e8d:	c9                   	leave  
  801e8e:	c3                   	ret    

00801e8f <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801e8f:	55                   	push   %ebp
  801e90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801e92:	6a 00                	push   $0x0
  801e94:	6a 00                	push   $0x0
  801e96:	6a 00                	push   $0x0
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 17                	push   $0x17
  801e9e:	e8 56 fd ff ff       	call   801bf9 <syscall>
  801ea3:	83 c4 18             	add    $0x18,%esp
}
  801ea6:	90                   	nop
  801ea7:	c9                   	leave  
  801ea8:	c3                   	ret    

00801ea9 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ea9:	55                   	push   %ebp
  801eaa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801eac:	8b 45 08             	mov    0x8(%ebp),%eax
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	ff 75 0c             	pushl  0xc(%ebp)
  801eb8:	50                   	push   %eax
  801eb9:	6a 18                	push   $0x18
  801ebb:	e8 39 fd ff ff       	call   801bf9 <syscall>
  801ec0:	83 c4 18             	add    $0x18,%esp
}
  801ec3:	c9                   	leave  
  801ec4:	c3                   	ret    

00801ec5 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ec5:	55                   	push   %ebp
  801ec6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ec8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ecb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ece:	6a 00                	push   $0x0
  801ed0:	6a 00                	push   $0x0
  801ed2:	6a 00                	push   $0x0
  801ed4:	52                   	push   %edx
  801ed5:	50                   	push   %eax
  801ed6:	6a 1b                	push   $0x1b
  801ed8:	e8 1c fd ff ff       	call   801bf9 <syscall>
  801edd:	83 c4 18             	add    $0x18,%esp
}
  801ee0:	c9                   	leave  
  801ee1:	c3                   	ret    

00801ee2 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801ee2:	55                   	push   %ebp
  801ee3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ee5:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee8:	8b 45 08             	mov    0x8(%ebp),%eax
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 00                	push   $0x0
  801ef1:	52                   	push   %edx
  801ef2:	50                   	push   %eax
  801ef3:	6a 19                	push   $0x19
  801ef5:	e8 ff fc ff ff       	call   801bf9 <syscall>
  801efa:	83 c4 18             	add    $0x18,%esp
}
  801efd:	90                   	nop
  801efe:	c9                   	leave  
  801eff:	c3                   	ret    

00801f00 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f00:	55                   	push   %ebp
  801f01:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f03:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f06:	8b 45 08             	mov    0x8(%ebp),%eax
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	6a 00                	push   $0x0
  801f0f:	52                   	push   %edx
  801f10:	50                   	push   %eax
  801f11:	6a 1a                	push   $0x1a
  801f13:	e8 e1 fc ff ff       	call   801bf9 <syscall>
  801f18:	83 c4 18             	add    $0x18,%esp
}
  801f1b:	90                   	nop
  801f1c:	c9                   	leave  
  801f1d:	c3                   	ret    

00801f1e <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f1e:	55                   	push   %ebp
  801f1f:	89 e5                	mov    %esp,%ebp
  801f21:	83 ec 04             	sub    $0x4,%esp
  801f24:	8b 45 10             	mov    0x10(%ebp),%eax
  801f27:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f2a:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f2d:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f31:	8b 45 08             	mov    0x8(%ebp),%eax
  801f34:	6a 00                	push   $0x0
  801f36:	51                   	push   %ecx
  801f37:	52                   	push   %edx
  801f38:	ff 75 0c             	pushl  0xc(%ebp)
  801f3b:	50                   	push   %eax
  801f3c:	6a 1c                	push   $0x1c
  801f3e:	e8 b6 fc ff ff       	call   801bf9 <syscall>
  801f43:	83 c4 18             	add    $0x18,%esp
}
  801f46:	c9                   	leave  
  801f47:	c3                   	ret    

00801f48 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f48:	55                   	push   %ebp
  801f49:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f4b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f4e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f51:	6a 00                	push   $0x0
  801f53:	6a 00                	push   $0x0
  801f55:	6a 00                	push   $0x0
  801f57:	52                   	push   %edx
  801f58:	50                   	push   %eax
  801f59:	6a 1d                	push   $0x1d
  801f5b:	e8 99 fc ff ff       	call   801bf9 <syscall>
  801f60:	83 c4 18             	add    $0x18,%esp
}
  801f63:	c9                   	leave  
  801f64:	c3                   	ret    

00801f65 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f65:	55                   	push   %ebp
  801f66:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f68:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f6b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6e:	8b 45 08             	mov    0x8(%ebp),%eax
  801f71:	6a 00                	push   $0x0
  801f73:	6a 00                	push   $0x0
  801f75:	51                   	push   %ecx
  801f76:	52                   	push   %edx
  801f77:	50                   	push   %eax
  801f78:	6a 1e                	push   $0x1e
  801f7a:	e8 7a fc ff ff       	call   801bf9 <syscall>
  801f7f:	83 c4 18             	add    $0x18,%esp
}
  801f82:	c9                   	leave  
  801f83:	c3                   	ret    

00801f84 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801f84:	55                   	push   %ebp
  801f85:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801f87:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	6a 00                	push   $0x0
  801f93:	52                   	push   %edx
  801f94:	50                   	push   %eax
  801f95:	6a 1f                	push   $0x1f
  801f97:	e8 5d fc ff ff       	call   801bf9 <syscall>
  801f9c:	83 c4 18             	add    $0x18,%esp
}
  801f9f:	c9                   	leave  
  801fa0:	c3                   	ret    

00801fa1 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fa1:	55                   	push   %ebp
  801fa2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fa4:	6a 00                	push   $0x0
  801fa6:	6a 00                	push   $0x0
  801fa8:	6a 00                	push   $0x0
  801faa:	6a 00                	push   $0x0
  801fac:	6a 00                	push   $0x0
  801fae:	6a 20                	push   $0x20
  801fb0:	e8 44 fc ff ff       	call   801bf9 <syscall>
  801fb5:	83 c4 18             	add    $0x18,%esp
}
  801fb8:	c9                   	leave  
  801fb9:	c3                   	ret    

00801fba <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fba:	55                   	push   %ebp
  801fbb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fbd:	8b 45 08             	mov    0x8(%ebp),%eax
  801fc0:	6a 00                	push   $0x0
  801fc2:	ff 75 14             	pushl  0x14(%ebp)
  801fc5:	ff 75 10             	pushl  0x10(%ebp)
  801fc8:	ff 75 0c             	pushl  0xc(%ebp)
  801fcb:	50                   	push   %eax
  801fcc:	6a 21                	push   $0x21
  801fce:	e8 26 fc ff ff       	call   801bf9 <syscall>
  801fd3:	83 c4 18             	add    $0x18,%esp
}
  801fd6:	c9                   	leave  
  801fd7:	c3                   	ret    

00801fd8 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801fd8:	55                   	push   %ebp
  801fd9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801fdb:	8b 45 08             	mov    0x8(%ebp),%eax
  801fde:	6a 00                	push   $0x0
  801fe0:	6a 00                	push   $0x0
  801fe2:	6a 00                	push   $0x0
  801fe4:	6a 00                	push   $0x0
  801fe6:	50                   	push   %eax
  801fe7:	6a 22                	push   $0x22
  801fe9:	e8 0b fc ff ff       	call   801bf9 <syscall>
  801fee:	83 c4 18             	add    $0x18,%esp
}
  801ff1:	90                   	nop
  801ff2:	c9                   	leave  
  801ff3:	c3                   	ret    

00801ff4 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801ff4:	55                   	push   %ebp
  801ff5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	50                   	push   %eax
  802003:	6a 23                	push   $0x23
  802005:	e8 ef fb ff ff       	call   801bf9 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
}
  80200d:	90                   	nop
  80200e:	c9                   	leave  
  80200f:	c3                   	ret    

00802010 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802010:	55                   	push   %ebp
  802011:	89 e5                	mov    %esp,%ebp
  802013:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802016:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802019:	8d 50 04             	lea    0x4(%eax),%edx
  80201c:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80201f:	6a 00                	push   $0x0
  802021:	6a 00                	push   $0x0
  802023:	6a 00                	push   $0x0
  802025:	52                   	push   %edx
  802026:	50                   	push   %eax
  802027:	6a 24                	push   $0x24
  802029:	e8 cb fb ff ff       	call   801bf9 <syscall>
  80202e:	83 c4 18             	add    $0x18,%esp
	return result;
  802031:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802034:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802037:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80203a:	89 01                	mov    %eax,(%ecx)
  80203c:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80203f:	8b 45 08             	mov    0x8(%ebp),%eax
  802042:	c9                   	leave  
  802043:	c2 04 00             	ret    $0x4

00802046 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802046:	55                   	push   %ebp
  802047:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802049:	6a 00                	push   $0x0
  80204b:	6a 00                	push   $0x0
  80204d:	ff 75 10             	pushl  0x10(%ebp)
  802050:	ff 75 0c             	pushl  0xc(%ebp)
  802053:	ff 75 08             	pushl  0x8(%ebp)
  802056:	6a 13                	push   $0x13
  802058:	e8 9c fb ff ff       	call   801bf9 <syscall>
  80205d:	83 c4 18             	add    $0x18,%esp
	return ;
  802060:	90                   	nop
}
  802061:	c9                   	leave  
  802062:	c3                   	ret    

00802063 <sys_rcr2>:
uint32 sys_rcr2()
{
  802063:	55                   	push   %ebp
  802064:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802066:	6a 00                	push   $0x0
  802068:	6a 00                	push   $0x0
  80206a:	6a 00                	push   $0x0
  80206c:	6a 00                	push   $0x0
  80206e:	6a 00                	push   $0x0
  802070:	6a 25                	push   $0x25
  802072:	e8 82 fb ff ff       	call   801bf9 <syscall>
  802077:	83 c4 18             	add    $0x18,%esp
}
  80207a:	c9                   	leave  
  80207b:	c3                   	ret    

0080207c <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80207c:	55                   	push   %ebp
  80207d:	89 e5                	mov    %esp,%ebp
  80207f:	83 ec 04             	sub    $0x4,%esp
  802082:	8b 45 08             	mov    0x8(%ebp),%eax
  802085:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802088:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80208c:	6a 00                	push   $0x0
  80208e:	6a 00                	push   $0x0
  802090:	6a 00                	push   $0x0
  802092:	6a 00                	push   $0x0
  802094:	50                   	push   %eax
  802095:	6a 26                	push   $0x26
  802097:	e8 5d fb ff ff       	call   801bf9 <syscall>
  80209c:	83 c4 18             	add    $0x18,%esp
	return ;
  80209f:	90                   	nop
}
  8020a0:	c9                   	leave  
  8020a1:	c3                   	ret    

008020a2 <rsttst>:
void rsttst()
{
  8020a2:	55                   	push   %ebp
  8020a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020a5:	6a 00                	push   $0x0
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	6a 28                	push   $0x28
  8020b1:	e8 43 fb ff ff       	call   801bf9 <syscall>
  8020b6:	83 c4 18             	add    $0x18,%esp
	return ;
  8020b9:	90                   	nop
}
  8020ba:	c9                   	leave  
  8020bb:	c3                   	ret    

008020bc <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020bc:	55                   	push   %ebp
  8020bd:	89 e5                	mov    %esp,%ebp
  8020bf:	83 ec 04             	sub    $0x4,%esp
  8020c2:	8b 45 14             	mov    0x14(%ebp),%eax
  8020c5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020c8:	8b 55 18             	mov    0x18(%ebp),%edx
  8020cb:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020cf:	52                   	push   %edx
  8020d0:	50                   	push   %eax
  8020d1:	ff 75 10             	pushl  0x10(%ebp)
  8020d4:	ff 75 0c             	pushl  0xc(%ebp)
  8020d7:	ff 75 08             	pushl  0x8(%ebp)
  8020da:	6a 27                	push   $0x27
  8020dc:	e8 18 fb ff ff       	call   801bf9 <syscall>
  8020e1:	83 c4 18             	add    $0x18,%esp
	return ;
  8020e4:	90                   	nop
}
  8020e5:	c9                   	leave  
  8020e6:	c3                   	ret    

008020e7 <chktst>:
void chktst(uint32 n)
{
  8020e7:	55                   	push   %ebp
  8020e8:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8020ea:	6a 00                	push   $0x0
  8020ec:	6a 00                	push   $0x0
  8020ee:	6a 00                	push   $0x0
  8020f0:	6a 00                	push   $0x0
  8020f2:	ff 75 08             	pushl  0x8(%ebp)
  8020f5:	6a 29                	push   $0x29
  8020f7:	e8 fd fa ff ff       	call   801bf9 <syscall>
  8020fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8020ff:	90                   	nop
}
  802100:	c9                   	leave  
  802101:	c3                   	ret    

00802102 <inctst>:

void inctst()
{
  802102:	55                   	push   %ebp
  802103:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802105:	6a 00                	push   $0x0
  802107:	6a 00                	push   $0x0
  802109:	6a 00                	push   $0x0
  80210b:	6a 00                	push   $0x0
  80210d:	6a 00                	push   $0x0
  80210f:	6a 2a                	push   $0x2a
  802111:	e8 e3 fa ff ff       	call   801bf9 <syscall>
  802116:	83 c4 18             	add    $0x18,%esp
	return ;
  802119:	90                   	nop
}
  80211a:	c9                   	leave  
  80211b:	c3                   	ret    

0080211c <gettst>:
uint32 gettst()
{
  80211c:	55                   	push   %ebp
  80211d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	6a 2b                	push   $0x2b
  80212b:	e8 c9 fa ff ff       	call   801bf9 <syscall>
  802130:	83 c4 18             	add    $0x18,%esp
}
  802133:	c9                   	leave  
  802134:	c3                   	ret    

00802135 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
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
  802147:	e8 ad fa ff ff       	call   801bf9 <syscall>
  80214c:	83 c4 18             	add    $0x18,%esp
  80214f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802152:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802156:	75 07                	jne    80215f <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802158:	b8 01 00 00 00       	mov    $0x1,%eax
  80215d:	eb 05                	jmp    802164 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80215f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802164:	c9                   	leave  
  802165:	c3                   	ret    

00802166 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802166:	55                   	push   %ebp
  802167:	89 e5                	mov    %esp,%ebp
  802169:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80216c:	6a 00                	push   $0x0
  80216e:	6a 00                	push   $0x0
  802170:	6a 00                	push   $0x0
  802172:	6a 00                	push   $0x0
  802174:	6a 00                	push   $0x0
  802176:	6a 2c                	push   $0x2c
  802178:	e8 7c fa ff ff       	call   801bf9 <syscall>
  80217d:	83 c4 18             	add    $0x18,%esp
  802180:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802183:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802187:	75 07                	jne    802190 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802189:	b8 01 00 00 00       	mov    $0x1,%eax
  80218e:	eb 05                	jmp    802195 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  802190:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802195:	c9                   	leave  
  802196:	c3                   	ret    

00802197 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802197:	55                   	push   %ebp
  802198:	89 e5                	mov    %esp,%ebp
  80219a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80219d:	6a 00                	push   $0x0
  80219f:	6a 00                	push   $0x0
  8021a1:	6a 00                	push   $0x0
  8021a3:	6a 00                	push   $0x0
  8021a5:	6a 00                	push   $0x0
  8021a7:	6a 2c                	push   $0x2c
  8021a9:	e8 4b fa ff ff       	call   801bf9 <syscall>
  8021ae:	83 c4 18             	add    $0x18,%esp
  8021b1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021b4:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021b8:	75 07                	jne    8021c1 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021ba:	b8 01 00 00 00       	mov    $0x1,%eax
  8021bf:	eb 05                	jmp    8021c6 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021c1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021c6:	c9                   	leave  
  8021c7:	c3                   	ret    

008021c8 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021c8:	55                   	push   %ebp
  8021c9:	89 e5                	mov    %esp,%ebp
  8021cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 00                	push   $0x0
  8021d8:	6a 2c                	push   $0x2c
  8021da:	e8 1a fa ff ff       	call   801bf9 <syscall>
  8021df:	83 c4 18             	add    $0x18,%esp
  8021e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  8021e5:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  8021e9:	75 07                	jne    8021f2 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  8021eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8021f0:	eb 05                	jmp    8021f7 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  8021f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021f7:	c9                   	leave  
  8021f8:	c3                   	ret    

008021f9 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8021f9:	55                   	push   %ebp
  8021fa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8021fc:	6a 00                	push   $0x0
  8021fe:	6a 00                	push   $0x0
  802200:	6a 00                	push   $0x0
  802202:	6a 00                	push   $0x0
  802204:	ff 75 08             	pushl  0x8(%ebp)
  802207:	6a 2d                	push   $0x2d
  802209:	e8 eb f9 ff ff       	call   801bf9 <syscall>
  80220e:	83 c4 18             	add    $0x18,%esp
	return ;
  802211:	90                   	nop
}
  802212:	c9                   	leave  
  802213:	c3                   	ret    

00802214 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802214:	55                   	push   %ebp
  802215:	89 e5                	mov    %esp,%ebp
  802217:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802218:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80221b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80221e:	8b 55 0c             	mov    0xc(%ebp),%edx
  802221:	8b 45 08             	mov    0x8(%ebp),%eax
  802224:	6a 00                	push   $0x0
  802226:	53                   	push   %ebx
  802227:	51                   	push   %ecx
  802228:	52                   	push   %edx
  802229:	50                   	push   %eax
  80222a:	6a 2e                	push   $0x2e
  80222c:	e8 c8 f9 ff ff       	call   801bf9 <syscall>
  802231:	83 c4 18             	add    $0x18,%esp
}
  802234:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802237:	c9                   	leave  
  802238:	c3                   	ret    

00802239 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802239:	55                   	push   %ebp
  80223a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80223c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223f:	8b 45 08             	mov    0x8(%ebp),%eax
  802242:	6a 00                	push   $0x0
  802244:	6a 00                	push   $0x0
  802246:	6a 00                	push   $0x0
  802248:	52                   	push   %edx
  802249:	50                   	push   %eax
  80224a:	6a 2f                	push   $0x2f
  80224c:	e8 a8 f9 ff ff       	call   801bf9 <syscall>
  802251:	83 c4 18             	add    $0x18,%esp
}
  802254:	c9                   	leave  
  802255:	c3                   	ret    

00802256 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802256:	55                   	push   %ebp
  802257:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802259:	6a 00                	push   $0x0
  80225b:	6a 00                	push   $0x0
  80225d:	6a 00                	push   $0x0
  80225f:	ff 75 0c             	pushl  0xc(%ebp)
  802262:	ff 75 08             	pushl  0x8(%ebp)
  802265:	6a 30                	push   $0x30
  802267:	e8 8d f9 ff ff       	call   801bf9 <syscall>
  80226c:	83 c4 18             	add    $0x18,%esp
	return ;
  80226f:	90                   	nop
}
  802270:	c9                   	leave  
  802271:	c3                   	ret    
  802272:	66 90                	xchg   %ax,%ax

00802274 <__udivdi3>:
  802274:	55                   	push   %ebp
  802275:	57                   	push   %edi
  802276:	56                   	push   %esi
  802277:	53                   	push   %ebx
  802278:	83 ec 1c             	sub    $0x1c,%esp
  80227b:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80227f:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  802283:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802287:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  80228b:	89 ca                	mov    %ecx,%edx
  80228d:	89 f8                	mov    %edi,%eax
  80228f:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  802293:	85 f6                	test   %esi,%esi
  802295:	75 2d                	jne    8022c4 <__udivdi3+0x50>
  802297:	39 cf                	cmp    %ecx,%edi
  802299:	77 65                	ja     802300 <__udivdi3+0x8c>
  80229b:	89 fd                	mov    %edi,%ebp
  80229d:	85 ff                	test   %edi,%edi
  80229f:	75 0b                	jne    8022ac <__udivdi3+0x38>
  8022a1:	b8 01 00 00 00       	mov    $0x1,%eax
  8022a6:	31 d2                	xor    %edx,%edx
  8022a8:	f7 f7                	div    %edi
  8022aa:	89 c5                	mov    %eax,%ebp
  8022ac:	31 d2                	xor    %edx,%edx
  8022ae:	89 c8                	mov    %ecx,%eax
  8022b0:	f7 f5                	div    %ebp
  8022b2:	89 c1                	mov    %eax,%ecx
  8022b4:	89 d8                	mov    %ebx,%eax
  8022b6:	f7 f5                	div    %ebp
  8022b8:	89 cf                	mov    %ecx,%edi
  8022ba:	89 fa                	mov    %edi,%edx
  8022bc:	83 c4 1c             	add    $0x1c,%esp
  8022bf:	5b                   	pop    %ebx
  8022c0:	5e                   	pop    %esi
  8022c1:	5f                   	pop    %edi
  8022c2:	5d                   	pop    %ebp
  8022c3:	c3                   	ret    
  8022c4:	39 ce                	cmp    %ecx,%esi
  8022c6:	77 28                	ja     8022f0 <__udivdi3+0x7c>
  8022c8:	0f bd fe             	bsr    %esi,%edi
  8022cb:	83 f7 1f             	xor    $0x1f,%edi
  8022ce:	75 40                	jne    802310 <__udivdi3+0x9c>
  8022d0:	39 ce                	cmp    %ecx,%esi
  8022d2:	72 0a                	jb     8022de <__udivdi3+0x6a>
  8022d4:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022d8:	0f 87 9e 00 00 00    	ja     80237c <__udivdi3+0x108>
  8022de:	b8 01 00 00 00       	mov    $0x1,%eax
  8022e3:	89 fa                	mov    %edi,%edx
  8022e5:	83 c4 1c             	add    $0x1c,%esp
  8022e8:	5b                   	pop    %ebx
  8022e9:	5e                   	pop    %esi
  8022ea:	5f                   	pop    %edi
  8022eb:	5d                   	pop    %ebp
  8022ec:	c3                   	ret    
  8022ed:	8d 76 00             	lea    0x0(%esi),%esi
  8022f0:	31 ff                	xor    %edi,%edi
  8022f2:	31 c0                	xor    %eax,%eax
  8022f4:	89 fa                	mov    %edi,%edx
  8022f6:	83 c4 1c             	add    $0x1c,%esp
  8022f9:	5b                   	pop    %ebx
  8022fa:	5e                   	pop    %esi
  8022fb:	5f                   	pop    %edi
  8022fc:	5d                   	pop    %ebp
  8022fd:	c3                   	ret    
  8022fe:	66 90                	xchg   %ax,%ax
  802300:	89 d8                	mov    %ebx,%eax
  802302:	f7 f7                	div    %edi
  802304:	31 ff                	xor    %edi,%edi
  802306:	89 fa                	mov    %edi,%edx
  802308:	83 c4 1c             	add    $0x1c,%esp
  80230b:	5b                   	pop    %ebx
  80230c:	5e                   	pop    %esi
  80230d:	5f                   	pop    %edi
  80230e:	5d                   	pop    %ebp
  80230f:	c3                   	ret    
  802310:	bd 20 00 00 00       	mov    $0x20,%ebp
  802315:	89 eb                	mov    %ebp,%ebx
  802317:	29 fb                	sub    %edi,%ebx
  802319:	89 f9                	mov    %edi,%ecx
  80231b:	d3 e6                	shl    %cl,%esi
  80231d:	89 c5                	mov    %eax,%ebp
  80231f:	88 d9                	mov    %bl,%cl
  802321:	d3 ed                	shr    %cl,%ebp
  802323:	89 e9                	mov    %ebp,%ecx
  802325:	09 f1                	or     %esi,%ecx
  802327:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80232b:	89 f9                	mov    %edi,%ecx
  80232d:	d3 e0                	shl    %cl,%eax
  80232f:	89 c5                	mov    %eax,%ebp
  802331:	89 d6                	mov    %edx,%esi
  802333:	88 d9                	mov    %bl,%cl
  802335:	d3 ee                	shr    %cl,%esi
  802337:	89 f9                	mov    %edi,%ecx
  802339:	d3 e2                	shl    %cl,%edx
  80233b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80233f:	88 d9                	mov    %bl,%cl
  802341:	d3 e8                	shr    %cl,%eax
  802343:	09 c2                	or     %eax,%edx
  802345:	89 d0                	mov    %edx,%eax
  802347:	89 f2                	mov    %esi,%edx
  802349:	f7 74 24 0c          	divl   0xc(%esp)
  80234d:	89 d6                	mov    %edx,%esi
  80234f:	89 c3                	mov    %eax,%ebx
  802351:	f7 e5                	mul    %ebp
  802353:	39 d6                	cmp    %edx,%esi
  802355:	72 19                	jb     802370 <__udivdi3+0xfc>
  802357:	74 0b                	je     802364 <__udivdi3+0xf0>
  802359:	89 d8                	mov    %ebx,%eax
  80235b:	31 ff                	xor    %edi,%edi
  80235d:	e9 58 ff ff ff       	jmp    8022ba <__udivdi3+0x46>
  802362:	66 90                	xchg   %ax,%ax
  802364:	8b 54 24 08          	mov    0x8(%esp),%edx
  802368:	89 f9                	mov    %edi,%ecx
  80236a:	d3 e2                	shl    %cl,%edx
  80236c:	39 c2                	cmp    %eax,%edx
  80236e:	73 e9                	jae    802359 <__udivdi3+0xe5>
  802370:	8d 43 ff             	lea    -0x1(%ebx),%eax
  802373:	31 ff                	xor    %edi,%edi
  802375:	e9 40 ff ff ff       	jmp    8022ba <__udivdi3+0x46>
  80237a:	66 90                	xchg   %ax,%ax
  80237c:	31 c0                	xor    %eax,%eax
  80237e:	e9 37 ff ff ff       	jmp    8022ba <__udivdi3+0x46>
  802383:	90                   	nop

00802384 <__umoddi3>:
  802384:	55                   	push   %ebp
  802385:	57                   	push   %edi
  802386:	56                   	push   %esi
  802387:	53                   	push   %ebx
  802388:	83 ec 1c             	sub    $0x1c,%esp
  80238b:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80238f:	8b 74 24 34          	mov    0x34(%esp),%esi
  802393:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802397:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  80239b:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80239f:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023a3:	89 f3                	mov    %esi,%ebx
  8023a5:	89 fa                	mov    %edi,%edx
  8023a7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023ab:	89 34 24             	mov    %esi,(%esp)
  8023ae:	85 c0                	test   %eax,%eax
  8023b0:	75 1a                	jne    8023cc <__umoddi3+0x48>
  8023b2:	39 f7                	cmp    %esi,%edi
  8023b4:	0f 86 a2 00 00 00    	jbe    80245c <__umoddi3+0xd8>
  8023ba:	89 c8                	mov    %ecx,%eax
  8023bc:	89 f2                	mov    %esi,%edx
  8023be:	f7 f7                	div    %edi
  8023c0:	89 d0                	mov    %edx,%eax
  8023c2:	31 d2                	xor    %edx,%edx
  8023c4:	83 c4 1c             	add    $0x1c,%esp
  8023c7:	5b                   	pop    %ebx
  8023c8:	5e                   	pop    %esi
  8023c9:	5f                   	pop    %edi
  8023ca:	5d                   	pop    %ebp
  8023cb:	c3                   	ret    
  8023cc:	39 f0                	cmp    %esi,%eax
  8023ce:	0f 87 ac 00 00 00    	ja     802480 <__umoddi3+0xfc>
  8023d4:	0f bd e8             	bsr    %eax,%ebp
  8023d7:	83 f5 1f             	xor    $0x1f,%ebp
  8023da:	0f 84 ac 00 00 00    	je     80248c <__umoddi3+0x108>
  8023e0:	bf 20 00 00 00       	mov    $0x20,%edi
  8023e5:	29 ef                	sub    %ebp,%edi
  8023e7:	89 fe                	mov    %edi,%esi
  8023e9:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  8023ed:	89 e9                	mov    %ebp,%ecx
  8023ef:	d3 e0                	shl    %cl,%eax
  8023f1:	89 d7                	mov    %edx,%edi
  8023f3:	89 f1                	mov    %esi,%ecx
  8023f5:	d3 ef                	shr    %cl,%edi
  8023f7:	09 c7                	or     %eax,%edi
  8023f9:	89 e9                	mov    %ebp,%ecx
  8023fb:	d3 e2                	shl    %cl,%edx
  8023fd:	89 14 24             	mov    %edx,(%esp)
  802400:	89 d8                	mov    %ebx,%eax
  802402:	d3 e0                	shl    %cl,%eax
  802404:	89 c2                	mov    %eax,%edx
  802406:	8b 44 24 08          	mov    0x8(%esp),%eax
  80240a:	d3 e0                	shl    %cl,%eax
  80240c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802410:	8b 44 24 08          	mov    0x8(%esp),%eax
  802414:	89 f1                	mov    %esi,%ecx
  802416:	d3 e8                	shr    %cl,%eax
  802418:	09 d0                	or     %edx,%eax
  80241a:	d3 eb                	shr    %cl,%ebx
  80241c:	89 da                	mov    %ebx,%edx
  80241e:	f7 f7                	div    %edi
  802420:	89 d3                	mov    %edx,%ebx
  802422:	f7 24 24             	mull   (%esp)
  802425:	89 c6                	mov    %eax,%esi
  802427:	89 d1                	mov    %edx,%ecx
  802429:	39 d3                	cmp    %edx,%ebx
  80242b:	0f 82 87 00 00 00    	jb     8024b8 <__umoddi3+0x134>
  802431:	0f 84 91 00 00 00    	je     8024c8 <__umoddi3+0x144>
  802437:	8b 54 24 04          	mov    0x4(%esp),%edx
  80243b:	29 f2                	sub    %esi,%edx
  80243d:	19 cb                	sbb    %ecx,%ebx
  80243f:	89 d8                	mov    %ebx,%eax
  802441:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802445:	d3 e0                	shl    %cl,%eax
  802447:	89 e9                	mov    %ebp,%ecx
  802449:	d3 ea                	shr    %cl,%edx
  80244b:	09 d0                	or     %edx,%eax
  80244d:	89 e9                	mov    %ebp,%ecx
  80244f:	d3 eb                	shr    %cl,%ebx
  802451:	89 da                	mov    %ebx,%edx
  802453:	83 c4 1c             	add    $0x1c,%esp
  802456:	5b                   	pop    %ebx
  802457:	5e                   	pop    %esi
  802458:	5f                   	pop    %edi
  802459:	5d                   	pop    %ebp
  80245a:	c3                   	ret    
  80245b:	90                   	nop
  80245c:	89 fd                	mov    %edi,%ebp
  80245e:	85 ff                	test   %edi,%edi
  802460:	75 0b                	jne    80246d <__umoddi3+0xe9>
  802462:	b8 01 00 00 00       	mov    $0x1,%eax
  802467:	31 d2                	xor    %edx,%edx
  802469:	f7 f7                	div    %edi
  80246b:	89 c5                	mov    %eax,%ebp
  80246d:	89 f0                	mov    %esi,%eax
  80246f:	31 d2                	xor    %edx,%edx
  802471:	f7 f5                	div    %ebp
  802473:	89 c8                	mov    %ecx,%eax
  802475:	f7 f5                	div    %ebp
  802477:	89 d0                	mov    %edx,%eax
  802479:	e9 44 ff ff ff       	jmp    8023c2 <__umoddi3+0x3e>
  80247e:	66 90                	xchg   %ax,%ax
  802480:	89 c8                	mov    %ecx,%eax
  802482:	89 f2                	mov    %esi,%edx
  802484:	83 c4 1c             	add    $0x1c,%esp
  802487:	5b                   	pop    %ebx
  802488:	5e                   	pop    %esi
  802489:	5f                   	pop    %edi
  80248a:	5d                   	pop    %ebp
  80248b:	c3                   	ret    
  80248c:	3b 04 24             	cmp    (%esp),%eax
  80248f:	72 06                	jb     802497 <__umoddi3+0x113>
  802491:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802495:	77 0f                	ja     8024a6 <__umoddi3+0x122>
  802497:	89 f2                	mov    %esi,%edx
  802499:	29 f9                	sub    %edi,%ecx
  80249b:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80249f:	89 14 24             	mov    %edx,(%esp)
  8024a2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024a6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024aa:	8b 14 24             	mov    (%esp),%edx
  8024ad:	83 c4 1c             	add    $0x1c,%esp
  8024b0:	5b                   	pop    %ebx
  8024b1:	5e                   	pop    %esi
  8024b2:	5f                   	pop    %edi
  8024b3:	5d                   	pop    %ebp
  8024b4:	c3                   	ret    
  8024b5:	8d 76 00             	lea    0x0(%esi),%esi
  8024b8:	2b 04 24             	sub    (%esp),%eax
  8024bb:	19 fa                	sbb    %edi,%edx
  8024bd:	89 d1                	mov    %edx,%ecx
  8024bf:	89 c6                	mov    %eax,%esi
  8024c1:	e9 71 ff ff ff       	jmp    802437 <__umoddi3+0xb3>
  8024c6:	66 90                	xchg   %ax,%ax
  8024c8:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024cc:	72 ea                	jb     8024b8 <__umoddi3+0x134>
  8024ce:	89 d9                	mov    %ebx,%ecx
  8024d0:	e9 62 ff ff ff       	jmp    802437 <__umoddi3+0xb3>
