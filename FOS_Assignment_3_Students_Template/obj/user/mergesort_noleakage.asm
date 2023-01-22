
obj/user/mergesort_noleakage:     file format elf32-i386


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
  800031:	e8 8f 07 00 00       	call   8007c5 <libmain>
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
  800041:	e8 0b 1e 00 00       	call   801e51 <sys_disable_interrupt>

		cprintf("\n");
  800046:	83 ec 0c             	sub    $0xc,%esp
  800049:	68 00 25 80 00       	push   $0x802500
  80004e:	e8 42 0b 00 00       	call   800b95 <cprintf>
  800053:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800056:	83 ec 0c             	sub    $0xc,%esp
  800059:	68 02 25 80 00       	push   $0x802502
  80005e:	e8 32 0b 00 00       	call   800b95 <cprintf>
  800063:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  800066:	83 ec 0c             	sub    $0xc,%esp
  800069:	68 18 25 80 00       	push   $0x802518
  80006e:	e8 22 0b 00 00       	call   800b95 <cprintf>
  800073:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  800076:	83 ec 0c             	sub    $0xc,%esp
  800079:	68 02 25 80 00       	push   $0x802502
  80007e:	e8 12 0b 00 00       	call   800b95 <cprintf>
  800083:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  800086:	83 ec 0c             	sub    $0xc,%esp
  800089:	68 00 25 80 00       	push   $0x802500
  80008e:	e8 02 0b 00 00       	call   800b95 <cprintf>
  800093:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  800096:	83 ec 08             	sub    $0x8,%esp
  800099:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  80009f:	50                   	push   %eax
  8000a0:	68 30 25 80 00       	push   $0x802530
  8000a5:	e8 6d 11 00 00       	call   801217 <readline>
  8000aa:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000ad:	83 ec 04             	sub    $0x4,%esp
  8000b0:	6a 0a                	push   $0xa
  8000b2:	6a 00                	push   $0x0
  8000b4:	8d 85 e9 fe ff ff    	lea    -0x117(%ebp),%eax
  8000ba:	50                   	push   %eax
  8000bb:	e8 bd 16 00 00       	call   80177d <strtol>
  8000c0:	83 c4 10             	add    $0x10,%esp
  8000c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  8000c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000c9:	c1 e0 02             	shl    $0x2,%eax
  8000cc:	83 ec 0c             	sub    $0xc,%esp
  8000cf:	50                   	push   %eax
  8000d0:	e8 50 1a 00 00       	call   801b25 <malloc>
  8000d5:	83 c4 10             	add    $0x10,%esp
  8000d8:	89 45 ec             	mov    %eax,-0x14(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000db:	83 ec 0c             	sub    $0xc,%esp
  8000de:	68 50 25 80 00       	push   $0x802550
  8000e3:	e8 ad 0a 00 00       	call   800b95 <cprintf>
  8000e8:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000eb:	83 ec 0c             	sub    $0xc,%esp
  8000ee:	68 72 25 80 00       	push   $0x802572
  8000f3:	e8 9d 0a 00 00       	call   800b95 <cprintf>
  8000f8:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000fb:	83 ec 0c             	sub    $0xc,%esp
  8000fe:	68 80 25 80 00       	push   $0x802580
  800103:	e8 8d 0a 00 00       	call   800b95 <cprintf>
  800108:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  80010b:	83 ec 0c             	sub    $0xc,%esp
  80010e:	68 8f 25 80 00       	push   $0x80258f
  800113:	e8 7d 0a 00 00       	call   800b95 <cprintf>
  800118:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  80011b:	83 ec 0c             	sub    $0xc,%esp
  80011e:	68 9f 25 80 00       	push   $0x80259f
  800123:	e8 6d 0a 00 00       	call   800b95 <cprintf>
  800128:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  80012b:	e8 3d 06 00 00       	call   80076d <getchar>
  800130:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800133:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800137:	83 ec 0c             	sub    $0xc,%esp
  80013a:	50                   	push   %eax
  80013b:	e8 e5 05 00 00       	call   800725 <cputchar>
  800140:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800143:	83 ec 0c             	sub    $0xc,%esp
  800146:	6a 0a                	push   $0xa
  800148:	e8 d8 05 00 00       	call   800725 <cputchar>
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
  800162:	e8 04 1d 00 00       	call   801e6b <sys_enable_interrupt>

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
  8001d7:	e8 75 1c 00 00       	call   801e51 <sys_disable_interrupt>
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  8001dc:	83 ec 0c             	sub    $0xc,%esp
  8001df:	68 a8 25 80 00       	push   $0x8025a8
  8001e4:	e8 ac 09 00 00       	call   800b95 <cprintf>
  8001e9:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_enable_interrupt();
  8001ec:	e8 7a 1c 00 00       	call   801e6b <sys_enable_interrupt>

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
  80020e:	68 dc 25 80 00       	push   $0x8025dc
  800213:	6a 4a                	push   $0x4a
  800215:	68 fe 25 80 00       	push   $0x8025fe
  80021a:	e8 c2 06 00 00       	call   8008e1 <_panic>
		else
		{
			sys_disable_interrupt();
  80021f:	e8 2d 1c 00 00       	call   801e51 <sys_disable_interrupt>
			cprintf("===============================================\n") ;
  800224:	83 ec 0c             	sub    $0xc,%esp
  800227:	68 1c 26 80 00       	push   $0x80261c
  80022c:	e8 64 09 00 00       	call   800b95 <cprintf>
  800231:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800234:	83 ec 0c             	sub    $0xc,%esp
  800237:	68 50 26 80 00       	push   $0x802650
  80023c:	e8 54 09 00 00       	call   800b95 <cprintf>
  800241:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800244:	83 ec 0c             	sub    $0xc,%esp
  800247:	68 84 26 80 00       	push   $0x802684
  80024c:	e8 44 09 00 00       	call   800b95 <cprintf>
  800251:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  800254:	e8 12 1c 00 00       	call   801e6b <sys_enable_interrupt>
		}

		free(Elements) ;
  800259:	83 ec 0c             	sub    $0xc,%esp
  80025c:	ff 75 ec             	pushl  -0x14(%ebp)
  80025f:	e8 db 18 00 00       	call   801b3f <free>
  800264:	83 c4 10             	add    $0x10,%esp

		sys_disable_interrupt();
  800267:	e8 e5 1b 00 00       	call   801e51 <sys_disable_interrupt>
			Chose = 0 ;
  80026c:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  800270:	eb 42                	jmp    8002b4 <_main+0x27c>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  800272:	83 ec 0c             	sub    $0xc,%esp
  800275:	68 b6 26 80 00       	push   $0x8026b6
  80027a:	e8 16 09 00 00       	call   800b95 <cprintf>
  80027f:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  800282:	e8 e6 04 00 00       	call   80076d <getchar>
  800287:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  80028a:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  80028e:	83 ec 0c             	sub    $0xc,%esp
  800291:	50                   	push   %eax
  800292:	e8 8e 04 00 00       	call   800725 <cputchar>
  800297:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  80029a:	83 ec 0c             	sub    $0xc,%esp
  80029d:	6a 0a                	push   $0xa
  80029f:	e8 81 04 00 00       	call   800725 <cputchar>
  8002a4:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002a7:	83 ec 0c             	sub    $0xc,%esp
  8002aa:	6a 0a                	push   $0xa
  8002ac:	e8 74 04 00 00       	call   800725 <cputchar>
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
  8002c0:	e8 a6 1b 00 00       	call   801e6b <sys_enable_interrupt>

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
  800454:	68 00 25 80 00       	push   $0x802500
  800459:	e8 37 07 00 00       	call   800b95 <cprintf>
  80045e:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800461:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800464:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80046b:	8b 45 08             	mov    0x8(%ebp),%eax
  80046e:	01 d0                	add    %edx,%eax
  800470:	8b 00                	mov    (%eax),%eax
  800472:	83 ec 08             	sub    $0x8,%esp
  800475:	50                   	push   %eax
  800476:	68 d4 26 80 00       	push   $0x8026d4
  80047b:	e8 15 07 00 00       	call   800b95 <cprintf>
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
  8004a4:	68 d9 26 80 00       	push   $0x8026d9
  8004a9:	e8 e7 06 00 00       	call   800b95 <cprintf>
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

	//cprintf("allocate LEFT\n");
	int* Left = malloc(sizeof(int) * leftCapacity);
  800540:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800543:	c1 e0 02             	shl    $0x2,%eax
  800546:	83 ec 0c             	sub    $0xc,%esp
  800549:	50                   	push   %eax
  80054a:	e8 d6 15 00 00       	call   801b25 <malloc>
  80054f:	83 c4 10             	add    $0x10,%esp
  800552:	89 45 d8             	mov    %eax,-0x28(%ebp)

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);
  800555:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800558:	c1 e0 02             	shl    $0x2,%eax
  80055b:	83 ec 0c             	sub    $0xc,%esp
  80055e:	50                   	push   %eax
  80055f:	e8 c1 15 00 00       	call   801b25 <malloc>
  800564:	83 c4 10             	add    $0x10,%esp
  800567:	89 45 d4             	mov    %eax,-0x2c(%ebp)

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

	//cprintf("allocate RIGHT\n");
	int* Right = malloc(sizeof(int) * rightCapacity);

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
			A[k - 1] = Right[rightIndex++];
		}
	}

	//cprintf("free LEFT\n");
	free(Left);
  800706:	83 ec 0c             	sub    $0xc,%esp
  800709:	ff 75 d8             	pushl  -0x28(%ebp)
  80070c:	e8 2e 14 00 00       	call   801b3f <free>
  800711:	83 c4 10             	add    $0x10,%esp
	//cprintf("free RIGHT\n");
	free(Right);
  800714:	83 ec 0c             	sub    $0xc,%esp
  800717:	ff 75 d4             	pushl  -0x2c(%ebp)
  80071a:	e8 20 14 00 00       	call   801b3f <free>
  80071f:	83 c4 10             	add    $0x10,%esp

}
  800722:	90                   	nop
  800723:	c9                   	leave  
  800724:	c3                   	ret    

00800725 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800725:	55                   	push   %ebp
  800726:	89 e5                	mov    %esp,%ebp
  800728:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80072b:	8b 45 08             	mov    0x8(%ebp),%eax
  80072e:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800731:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800735:	83 ec 0c             	sub    $0xc,%esp
  800738:	50                   	push   %eax
  800739:	e8 47 17 00 00       	call   801e85 <sys_cputc>
  80073e:	83 c4 10             	add    $0x10,%esp
}
  800741:	90                   	nop
  800742:	c9                   	leave  
  800743:	c3                   	ret    

00800744 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  800744:	55                   	push   %ebp
  800745:	89 e5                	mov    %esp,%ebp
  800747:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80074a:	e8 02 17 00 00       	call   801e51 <sys_disable_interrupt>
	char c = ch;
  80074f:	8b 45 08             	mov    0x8(%ebp),%eax
  800752:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800755:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800759:	83 ec 0c             	sub    $0xc,%esp
  80075c:	50                   	push   %eax
  80075d:	e8 23 17 00 00       	call   801e85 <sys_cputc>
  800762:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800765:	e8 01 17 00 00       	call   801e6b <sys_enable_interrupt>
}
  80076a:	90                   	nop
  80076b:	c9                   	leave  
  80076c:	c3                   	ret    

0080076d <getchar>:

int
getchar(void)
{
  80076d:	55                   	push   %ebp
  80076e:	89 e5                	mov    %esp,%ebp
  800770:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800773:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80077a:	eb 08                	jmp    800784 <getchar+0x17>
	{
		c = sys_cgetc();
  80077c:	e8 e8 14 00 00       	call   801c69 <sys_cgetc>
  800781:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800784:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800788:	74 f2                	je     80077c <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80078a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80078d:	c9                   	leave  
  80078e:	c3                   	ret    

0080078f <atomic_getchar>:

int
atomic_getchar(void)
{
  80078f:	55                   	push   %ebp
  800790:	89 e5                	mov    %esp,%ebp
  800792:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800795:	e8 b7 16 00 00       	call   801e51 <sys_disable_interrupt>
	int c=0;
  80079a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007a1:	eb 08                	jmp    8007ab <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  8007a3:	e8 c1 14 00 00       	call   801c69 <sys_cgetc>
  8007a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  8007ab:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007af:	74 f2                	je     8007a3 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  8007b1:	e8 b5 16 00 00       	call   801e6b <sys_enable_interrupt>
	return c;
  8007b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007b9:	c9                   	leave  
  8007ba:	c3                   	ret    

008007bb <iscons>:

int iscons(int fdnum)
{
  8007bb:	55                   	push   %ebp
  8007bc:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  8007be:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8007c3:	5d                   	pop    %ebp
  8007c4:	c3                   	ret    

008007c5 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8007c5:	55                   	push   %ebp
  8007c6:	89 e5                	mov    %esp,%ebp
  8007c8:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8007cb:	e8 e6 14 00 00       	call   801cb6 <sys_getenvindex>
  8007d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8007d3:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007d6:	89 d0                	mov    %edx,%eax
  8007d8:	01 c0                	add    %eax,%eax
  8007da:	01 d0                	add    %edx,%eax
  8007dc:	c1 e0 04             	shl    $0x4,%eax
  8007df:	29 d0                	sub    %edx,%eax
  8007e1:	c1 e0 03             	shl    $0x3,%eax
  8007e4:	01 d0                	add    %edx,%eax
  8007e6:	c1 e0 02             	shl    $0x2,%eax
  8007e9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8007ee:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8007f3:	a1 24 30 80 00       	mov    0x803024,%eax
  8007f8:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8007fe:	84 c0                	test   %al,%al
  800800:	74 0f                	je     800811 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800802:	a1 24 30 80 00       	mov    0x803024,%eax
  800807:	05 5c 05 00 00       	add    $0x55c,%eax
  80080c:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800811:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800815:	7e 0a                	jle    800821 <libmain+0x5c>
		binaryname = argv[0];
  800817:	8b 45 0c             	mov    0xc(%ebp),%eax
  80081a:	8b 00                	mov    (%eax),%eax
  80081c:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800821:	83 ec 08             	sub    $0x8,%esp
  800824:	ff 75 0c             	pushl  0xc(%ebp)
  800827:	ff 75 08             	pushl  0x8(%ebp)
  80082a:	e8 09 f8 ff ff       	call   800038 <_main>
  80082f:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800832:	e8 1a 16 00 00       	call   801e51 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800837:	83 ec 0c             	sub    $0xc,%esp
  80083a:	68 f8 26 80 00       	push   $0x8026f8
  80083f:	e8 51 03 00 00       	call   800b95 <cprintf>
  800844:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800847:	a1 24 30 80 00       	mov    0x803024,%eax
  80084c:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800852:	a1 24 30 80 00       	mov    0x803024,%eax
  800857:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80085d:	83 ec 04             	sub    $0x4,%esp
  800860:	52                   	push   %edx
  800861:	50                   	push   %eax
  800862:	68 20 27 80 00       	push   $0x802720
  800867:	e8 29 03 00 00       	call   800b95 <cprintf>
  80086c:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80086f:	a1 24 30 80 00       	mov    0x803024,%eax
  800874:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80087a:	a1 24 30 80 00       	mov    0x803024,%eax
  80087f:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800885:	a1 24 30 80 00       	mov    0x803024,%eax
  80088a:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800890:	51                   	push   %ecx
  800891:	52                   	push   %edx
  800892:	50                   	push   %eax
  800893:	68 48 27 80 00       	push   $0x802748
  800898:	e8 f8 02 00 00       	call   800b95 <cprintf>
  80089d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8008a0:	83 ec 0c             	sub    $0xc,%esp
  8008a3:	68 f8 26 80 00       	push   $0x8026f8
  8008a8:	e8 e8 02 00 00       	call   800b95 <cprintf>
  8008ad:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8008b0:	e8 b6 15 00 00       	call   801e6b <sys_enable_interrupt>

	// exit gracefully
	exit();
  8008b5:	e8 19 00 00 00       	call   8008d3 <exit>
}
  8008ba:	90                   	nop
  8008bb:	c9                   	leave  
  8008bc:	c3                   	ret    

008008bd <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8008bd:	55                   	push   %ebp
  8008be:	89 e5                	mov    %esp,%ebp
  8008c0:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8008c3:	83 ec 0c             	sub    $0xc,%esp
  8008c6:	6a 00                	push   $0x0
  8008c8:	e8 b5 13 00 00       	call   801c82 <sys_env_destroy>
  8008cd:	83 c4 10             	add    $0x10,%esp
}
  8008d0:	90                   	nop
  8008d1:	c9                   	leave  
  8008d2:	c3                   	ret    

008008d3 <exit>:

void
exit(void)
{
  8008d3:	55                   	push   %ebp
  8008d4:	89 e5                	mov    %esp,%ebp
  8008d6:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8008d9:	e8 0a 14 00 00       	call   801ce8 <sys_env_exit>
}
  8008de:	90                   	nop
  8008df:	c9                   	leave  
  8008e0:	c3                   	ret    

008008e1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8008e1:	55                   	push   %ebp
  8008e2:	89 e5                	mov    %esp,%ebp
  8008e4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8008e7:	8d 45 10             	lea    0x10(%ebp),%eax
  8008ea:	83 c0 04             	add    $0x4,%eax
  8008ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8008f0:	a1 18 31 80 00       	mov    0x803118,%eax
  8008f5:	85 c0                	test   %eax,%eax
  8008f7:	74 16                	je     80090f <_panic+0x2e>
		cprintf("%s: ", argv0);
  8008f9:	a1 18 31 80 00       	mov    0x803118,%eax
  8008fe:	83 ec 08             	sub    $0x8,%esp
  800901:	50                   	push   %eax
  800902:	68 a0 27 80 00       	push   $0x8027a0
  800907:	e8 89 02 00 00       	call   800b95 <cprintf>
  80090c:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80090f:	a1 00 30 80 00       	mov    0x803000,%eax
  800914:	ff 75 0c             	pushl  0xc(%ebp)
  800917:	ff 75 08             	pushl  0x8(%ebp)
  80091a:	50                   	push   %eax
  80091b:	68 a5 27 80 00       	push   $0x8027a5
  800920:	e8 70 02 00 00       	call   800b95 <cprintf>
  800925:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800928:	8b 45 10             	mov    0x10(%ebp),%eax
  80092b:	83 ec 08             	sub    $0x8,%esp
  80092e:	ff 75 f4             	pushl  -0xc(%ebp)
  800931:	50                   	push   %eax
  800932:	e8 f3 01 00 00       	call   800b2a <vcprintf>
  800937:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80093a:	83 ec 08             	sub    $0x8,%esp
  80093d:	6a 00                	push   $0x0
  80093f:	68 c1 27 80 00       	push   $0x8027c1
  800944:	e8 e1 01 00 00       	call   800b2a <vcprintf>
  800949:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80094c:	e8 82 ff ff ff       	call   8008d3 <exit>

	// should not return here
	while (1) ;
  800951:	eb fe                	jmp    800951 <_panic+0x70>

00800953 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800953:	55                   	push   %ebp
  800954:	89 e5                	mov    %esp,%ebp
  800956:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800959:	a1 24 30 80 00       	mov    0x803024,%eax
  80095e:	8b 50 74             	mov    0x74(%eax),%edx
  800961:	8b 45 0c             	mov    0xc(%ebp),%eax
  800964:	39 c2                	cmp    %eax,%edx
  800966:	74 14                	je     80097c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800968:	83 ec 04             	sub    $0x4,%esp
  80096b:	68 c4 27 80 00       	push   $0x8027c4
  800970:	6a 26                	push   $0x26
  800972:	68 10 28 80 00       	push   $0x802810
  800977:	e8 65 ff ff ff       	call   8008e1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80097c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800983:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80098a:	e9 c2 00 00 00       	jmp    800a51 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80098f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800992:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800999:	8b 45 08             	mov    0x8(%ebp),%eax
  80099c:	01 d0                	add    %edx,%eax
  80099e:	8b 00                	mov    (%eax),%eax
  8009a0:	85 c0                	test   %eax,%eax
  8009a2:	75 08                	jne    8009ac <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8009a4:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8009a7:	e9 a2 00 00 00       	jmp    800a4e <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8009ac:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8009b3:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8009ba:	eb 69                	jmp    800a25 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8009bc:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c1:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8009c7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009ca:	89 d0                	mov    %edx,%eax
  8009cc:	01 c0                	add    %eax,%eax
  8009ce:	01 d0                	add    %edx,%eax
  8009d0:	c1 e0 03             	shl    $0x3,%eax
  8009d3:	01 c8                	add    %ecx,%eax
  8009d5:	8a 40 04             	mov    0x4(%eax),%al
  8009d8:	84 c0                	test   %al,%al
  8009da:	75 46                	jne    800a22 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8009dc:	a1 24 30 80 00       	mov    0x803024,%eax
  8009e1:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8009e7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8009ea:	89 d0                	mov    %edx,%eax
  8009ec:	01 c0                	add    %eax,%eax
  8009ee:	01 d0                	add    %edx,%eax
  8009f0:	c1 e0 03             	shl    $0x3,%eax
  8009f3:	01 c8                	add    %ecx,%eax
  8009f5:	8b 00                	mov    (%eax),%eax
  8009f7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8009fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8009fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a02:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a04:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a07:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a11:	01 c8                	add    %ecx,%eax
  800a13:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a15:	39 c2                	cmp    %eax,%edx
  800a17:	75 09                	jne    800a22 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800a19:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a20:	eb 12                	jmp    800a34 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a22:	ff 45 e8             	incl   -0x18(%ebp)
  800a25:	a1 24 30 80 00       	mov    0x803024,%eax
  800a2a:	8b 50 74             	mov    0x74(%eax),%edx
  800a2d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a30:	39 c2                	cmp    %eax,%edx
  800a32:	77 88                	ja     8009bc <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a34:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a38:	75 14                	jne    800a4e <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a3a:	83 ec 04             	sub    $0x4,%esp
  800a3d:	68 1c 28 80 00       	push   $0x80281c
  800a42:	6a 3a                	push   $0x3a
  800a44:	68 10 28 80 00       	push   $0x802810
  800a49:	e8 93 fe ff ff       	call   8008e1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800a4e:	ff 45 f0             	incl   -0x10(%ebp)
  800a51:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a54:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800a57:	0f 8c 32 ff ff ff    	jl     80098f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800a5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a64:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800a6b:	eb 26                	jmp    800a93 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800a6d:	a1 24 30 80 00       	mov    0x803024,%eax
  800a72:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800a78:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800a7b:	89 d0                	mov    %edx,%eax
  800a7d:	01 c0                	add    %eax,%eax
  800a7f:	01 d0                	add    %edx,%eax
  800a81:	c1 e0 03             	shl    $0x3,%eax
  800a84:	01 c8                	add    %ecx,%eax
  800a86:	8a 40 04             	mov    0x4(%eax),%al
  800a89:	3c 01                	cmp    $0x1,%al
  800a8b:	75 03                	jne    800a90 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800a8d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a90:	ff 45 e0             	incl   -0x20(%ebp)
  800a93:	a1 24 30 80 00       	mov    0x803024,%eax
  800a98:	8b 50 74             	mov    0x74(%eax),%edx
  800a9b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a9e:	39 c2                	cmp    %eax,%edx
  800aa0:	77 cb                	ja     800a6d <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800aa2:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800aa5:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800aa8:	74 14                	je     800abe <CheckWSWithoutLastIndex+0x16b>
		panic(
  800aaa:	83 ec 04             	sub    $0x4,%esp
  800aad:	68 70 28 80 00       	push   $0x802870
  800ab2:	6a 44                	push   $0x44
  800ab4:	68 10 28 80 00       	push   $0x802810
  800ab9:	e8 23 fe ff ff       	call   8008e1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800abe:	90                   	nop
  800abf:	c9                   	leave  
  800ac0:	c3                   	ret    

00800ac1 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800ac1:	55                   	push   %ebp
  800ac2:	89 e5                	mov    %esp,%ebp
  800ac4:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800ac7:	8b 45 0c             	mov    0xc(%ebp),%eax
  800aca:	8b 00                	mov    (%eax),%eax
  800acc:	8d 48 01             	lea    0x1(%eax),%ecx
  800acf:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ad2:	89 0a                	mov    %ecx,(%edx)
  800ad4:	8b 55 08             	mov    0x8(%ebp),%edx
  800ad7:	88 d1                	mov    %dl,%cl
  800ad9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800adc:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800ae0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae3:	8b 00                	mov    (%eax),%eax
  800ae5:	3d ff 00 00 00       	cmp    $0xff,%eax
  800aea:	75 2c                	jne    800b18 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800aec:	a0 28 30 80 00       	mov    0x803028,%al
  800af1:	0f b6 c0             	movzbl %al,%eax
  800af4:	8b 55 0c             	mov    0xc(%ebp),%edx
  800af7:	8b 12                	mov    (%edx),%edx
  800af9:	89 d1                	mov    %edx,%ecx
  800afb:	8b 55 0c             	mov    0xc(%ebp),%edx
  800afe:	83 c2 08             	add    $0x8,%edx
  800b01:	83 ec 04             	sub    $0x4,%esp
  800b04:	50                   	push   %eax
  800b05:	51                   	push   %ecx
  800b06:	52                   	push   %edx
  800b07:	e8 34 11 00 00       	call   801c40 <sys_cputs>
  800b0c:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b0f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b12:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b18:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b1b:	8b 40 04             	mov    0x4(%eax),%eax
  800b1e:	8d 50 01             	lea    0x1(%eax),%edx
  800b21:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b24:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b27:	90                   	nop
  800b28:	c9                   	leave  
  800b29:	c3                   	ret    

00800b2a <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b2a:	55                   	push   %ebp
  800b2b:	89 e5                	mov    %esp,%ebp
  800b2d:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b33:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b3a:	00 00 00 
	b.cnt = 0;
  800b3d:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800b44:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800b47:	ff 75 0c             	pushl  0xc(%ebp)
  800b4a:	ff 75 08             	pushl  0x8(%ebp)
  800b4d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b53:	50                   	push   %eax
  800b54:	68 c1 0a 80 00       	push   $0x800ac1
  800b59:	e8 11 02 00 00       	call   800d6f <vprintfmt>
  800b5e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800b61:	a0 28 30 80 00       	mov    0x803028,%al
  800b66:	0f b6 c0             	movzbl %al,%eax
  800b69:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800b6f:	83 ec 04             	sub    $0x4,%esp
  800b72:	50                   	push   %eax
  800b73:	52                   	push   %edx
  800b74:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800b7a:	83 c0 08             	add    $0x8,%eax
  800b7d:	50                   	push   %eax
  800b7e:	e8 bd 10 00 00       	call   801c40 <sys_cputs>
  800b83:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800b86:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800b8d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800b93:	c9                   	leave  
  800b94:	c3                   	ret    

00800b95 <cprintf>:

int cprintf(const char *fmt, ...) {
  800b95:	55                   	push   %ebp
  800b96:	89 e5                	mov    %esp,%ebp
  800b98:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800b9b:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800ba2:	8d 45 0c             	lea    0xc(%ebp),%eax
  800ba5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800ba8:	8b 45 08             	mov    0x8(%ebp),%eax
  800bab:	83 ec 08             	sub    $0x8,%esp
  800bae:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb1:	50                   	push   %eax
  800bb2:	e8 73 ff ff ff       	call   800b2a <vcprintf>
  800bb7:	83 c4 10             	add    $0x10,%esp
  800bba:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800bbd:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bc0:	c9                   	leave  
  800bc1:	c3                   	ret    

00800bc2 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800bc2:	55                   	push   %ebp
  800bc3:	89 e5                	mov    %esp,%ebp
  800bc5:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800bc8:	e8 84 12 00 00       	call   801e51 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800bcd:	8d 45 0c             	lea    0xc(%ebp),%eax
  800bd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800bd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd6:	83 ec 08             	sub    $0x8,%esp
  800bd9:	ff 75 f4             	pushl  -0xc(%ebp)
  800bdc:	50                   	push   %eax
  800bdd:	e8 48 ff ff ff       	call   800b2a <vcprintf>
  800be2:	83 c4 10             	add    $0x10,%esp
  800be5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800be8:	e8 7e 12 00 00       	call   801e6b <sys_enable_interrupt>
	return cnt;
  800bed:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800bf0:	c9                   	leave  
  800bf1:	c3                   	ret    

00800bf2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800bf2:	55                   	push   %ebp
  800bf3:	89 e5                	mov    %esp,%ebp
  800bf5:	53                   	push   %ebx
  800bf6:	83 ec 14             	sub    $0x14,%esp
  800bf9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bfc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bff:	8b 45 14             	mov    0x14(%ebp),%eax
  800c02:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c05:	8b 45 18             	mov    0x18(%ebp),%eax
  800c08:	ba 00 00 00 00       	mov    $0x0,%edx
  800c0d:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c10:	77 55                	ja     800c67 <printnum+0x75>
  800c12:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c15:	72 05                	jb     800c1c <printnum+0x2a>
  800c17:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c1a:	77 4b                	ja     800c67 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c1c:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c1f:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c22:	8b 45 18             	mov    0x18(%ebp),%eax
  800c25:	ba 00 00 00 00       	mov    $0x0,%edx
  800c2a:	52                   	push   %edx
  800c2b:	50                   	push   %eax
  800c2c:	ff 75 f4             	pushl  -0xc(%ebp)
  800c2f:	ff 75 f0             	pushl  -0x10(%ebp)
  800c32:	e8 59 16 00 00       	call   802290 <__udivdi3>
  800c37:	83 c4 10             	add    $0x10,%esp
  800c3a:	83 ec 04             	sub    $0x4,%esp
  800c3d:	ff 75 20             	pushl  0x20(%ebp)
  800c40:	53                   	push   %ebx
  800c41:	ff 75 18             	pushl  0x18(%ebp)
  800c44:	52                   	push   %edx
  800c45:	50                   	push   %eax
  800c46:	ff 75 0c             	pushl  0xc(%ebp)
  800c49:	ff 75 08             	pushl  0x8(%ebp)
  800c4c:	e8 a1 ff ff ff       	call   800bf2 <printnum>
  800c51:	83 c4 20             	add    $0x20,%esp
  800c54:	eb 1a                	jmp    800c70 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800c56:	83 ec 08             	sub    $0x8,%esp
  800c59:	ff 75 0c             	pushl  0xc(%ebp)
  800c5c:	ff 75 20             	pushl  0x20(%ebp)
  800c5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800c62:	ff d0                	call   *%eax
  800c64:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800c67:	ff 4d 1c             	decl   0x1c(%ebp)
  800c6a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800c6e:	7f e6                	jg     800c56 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800c70:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800c73:	bb 00 00 00 00       	mov    $0x0,%ebx
  800c78:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800c7b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800c7e:	53                   	push   %ebx
  800c7f:	51                   	push   %ecx
  800c80:	52                   	push   %edx
  800c81:	50                   	push   %eax
  800c82:	e8 19 17 00 00       	call   8023a0 <__umoddi3>
  800c87:	83 c4 10             	add    $0x10,%esp
  800c8a:	05 d4 2a 80 00       	add    $0x802ad4,%eax
  800c8f:	8a 00                	mov    (%eax),%al
  800c91:	0f be c0             	movsbl %al,%eax
  800c94:	83 ec 08             	sub    $0x8,%esp
  800c97:	ff 75 0c             	pushl  0xc(%ebp)
  800c9a:	50                   	push   %eax
  800c9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c9e:	ff d0                	call   *%eax
  800ca0:	83 c4 10             	add    $0x10,%esp
}
  800ca3:	90                   	nop
  800ca4:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ca7:	c9                   	leave  
  800ca8:	c3                   	ret    

00800ca9 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ca9:	55                   	push   %ebp
  800caa:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800cac:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800cb0:	7e 1c                	jle    800cce <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	8b 00                	mov    (%eax),%eax
  800cb7:	8d 50 08             	lea    0x8(%eax),%edx
  800cba:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbd:	89 10                	mov    %edx,(%eax)
  800cbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc2:	8b 00                	mov    (%eax),%eax
  800cc4:	83 e8 08             	sub    $0x8,%eax
  800cc7:	8b 50 04             	mov    0x4(%eax),%edx
  800cca:	8b 00                	mov    (%eax),%eax
  800ccc:	eb 40                	jmp    800d0e <getuint+0x65>
	else if (lflag)
  800cce:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cd2:	74 1e                	je     800cf2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800cd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd7:	8b 00                	mov    (%eax),%eax
  800cd9:	8d 50 04             	lea    0x4(%eax),%edx
  800cdc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cdf:	89 10                	mov    %edx,(%eax)
  800ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce4:	8b 00                	mov    (%eax),%eax
  800ce6:	83 e8 04             	sub    $0x4,%eax
  800ce9:	8b 00                	mov    (%eax),%eax
  800ceb:	ba 00 00 00 00       	mov    $0x0,%edx
  800cf0:	eb 1c                	jmp    800d0e <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800cf2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf5:	8b 00                	mov    (%eax),%eax
  800cf7:	8d 50 04             	lea    0x4(%eax),%edx
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	89 10                	mov    %edx,(%eax)
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	8b 00                	mov    (%eax),%eax
  800d04:	83 e8 04             	sub    $0x4,%eax
  800d07:	8b 00                	mov    (%eax),%eax
  800d09:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d0e:	5d                   	pop    %ebp
  800d0f:	c3                   	ret    

00800d10 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d10:	55                   	push   %ebp
  800d11:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d13:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d17:	7e 1c                	jle    800d35 <getint+0x25>
		return va_arg(*ap, long long);
  800d19:	8b 45 08             	mov    0x8(%ebp),%eax
  800d1c:	8b 00                	mov    (%eax),%eax
  800d1e:	8d 50 08             	lea    0x8(%eax),%edx
  800d21:	8b 45 08             	mov    0x8(%ebp),%eax
  800d24:	89 10                	mov    %edx,(%eax)
  800d26:	8b 45 08             	mov    0x8(%ebp),%eax
  800d29:	8b 00                	mov    (%eax),%eax
  800d2b:	83 e8 08             	sub    $0x8,%eax
  800d2e:	8b 50 04             	mov    0x4(%eax),%edx
  800d31:	8b 00                	mov    (%eax),%eax
  800d33:	eb 38                	jmp    800d6d <getint+0x5d>
	else if (lflag)
  800d35:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d39:	74 1a                	je     800d55 <getint+0x45>
		return va_arg(*ap, long);
  800d3b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3e:	8b 00                	mov    (%eax),%eax
  800d40:	8d 50 04             	lea    0x4(%eax),%edx
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	89 10                	mov    %edx,(%eax)
  800d48:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4b:	8b 00                	mov    (%eax),%eax
  800d4d:	83 e8 04             	sub    $0x4,%eax
  800d50:	8b 00                	mov    (%eax),%eax
  800d52:	99                   	cltd   
  800d53:	eb 18                	jmp    800d6d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800d55:	8b 45 08             	mov    0x8(%ebp),%eax
  800d58:	8b 00                	mov    (%eax),%eax
  800d5a:	8d 50 04             	lea    0x4(%eax),%edx
  800d5d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d60:	89 10                	mov    %edx,(%eax)
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
  800d65:	8b 00                	mov    (%eax),%eax
  800d67:	83 e8 04             	sub    $0x4,%eax
  800d6a:	8b 00                	mov    (%eax),%eax
  800d6c:	99                   	cltd   
}
  800d6d:	5d                   	pop    %ebp
  800d6e:	c3                   	ret    

00800d6f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800d6f:	55                   	push   %ebp
  800d70:	89 e5                	mov    %esp,%ebp
  800d72:	56                   	push   %esi
  800d73:	53                   	push   %ebx
  800d74:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d77:	eb 17                	jmp    800d90 <vprintfmt+0x21>
			if (ch == '\0')
  800d79:	85 db                	test   %ebx,%ebx
  800d7b:	0f 84 af 03 00 00    	je     801130 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800d81:	83 ec 08             	sub    $0x8,%esp
  800d84:	ff 75 0c             	pushl  0xc(%ebp)
  800d87:	53                   	push   %ebx
  800d88:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8b:	ff d0                	call   *%eax
  800d8d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800d90:	8b 45 10             	mov    0x10(%ebp),%eax
  800d93:	8d 50 01             	lea    0x1(%eax),%edx
  800d96:	89 55 10             	mov    %edx,0x10(%ebp)
  800d99:	8a 00                	mov    (%eax),%al
  800d9b:	0f b6 d8             	movzbl %al,%ebx
  800d9e:	83 fb 25             	cmp    $0x25,%ebx
  800da1:	75 d6                	jne    800d79 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800da3:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800da7:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800dae:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800db5:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800dbc:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800dc3:	8b 45 10             	mov    0x10(%ebp),%eax
  800dc6:	8d 50 01             	lea    0x1(%eax),%edx
  800dc9:	89 55 10             	mov    %edx,0x10(%ebp)
  800dcc:	8a 00                	mov    (%eax),%al
  800dce:	0f b6 d8             	movzbl %al,%ebx
  800dd1:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800dd4:	83 f8 55             	cmp    $0x55,%eax
  800dd7:	0f 87 2b 03 00 00    	ja     801108 <vprintfmt+0x399>
  800ddd:	8b 04 85 f8 2a 80 00 	mov    0x802af8(,%eax,4),%eax
  800de4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800de6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800dea:	eb d7                	jmp    800dc3 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800dec:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800df0:	eb d1                	jmp    800dc3 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800df2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800df9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800dfc:	89 d0                	mov    %edx,%eax
  800dfe:	c1 e0 02             	shl    $0x2,%eax
  800e01:	01 d0                	add    %edx,%eax
  800e03:	01 c0                	add    %eax,%eax
  800e05:	01 d8                	add    %ebx,%eax
  800e07:	83 e8 30             	sub    $0x30,%eax
  800e0a:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e0d:	8b 45 10             	mov    0x10(%ebp),%eax
  800e10:	8a 00                	mov    (%eax),%al
  800e12:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e15:	83 fb 2f             	cmp    $0x2f,%ebx
  800e18:	7e 3e                	jle    800e58 <vprintfmt+0xe9>
  800e1a:	83 fb 39             	cmp    $0x39,%ebx
  800e1d:	7f 39                	jg     800e58 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e1f:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e22:	eb d5                	jmp    800df9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e24:	8b 45 14             	mov    0x14(%ebp),%eax
  800e27:	83 c0 04             	add    $0x4,%eax
  800e2a:	89 45 14             	mov    %eax,0x14(%ebp)
  800e2d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e30:	83 e8 04             	sub    $0x4,%eax
  800e33:	8b 00                	mov    (%eax),%eax
  800e35:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e38:	eb 1f                	jmp    800e59 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e3a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e3e:	79 83                	jns    800dc3 <vprintfmt+0x54>
				width = 0;
  800e40:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800e47:	e9 77 ff ff ff       	jmp    800dc3 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800e4c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800e53:	e9 6b ff ff ff       	jmp    800dc3 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800e58:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800e59:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800e5d:	0f 89 60 ff ff ff    	jns    800dc3 <vprintfmt+0x54>
				width = precision, precision = -1;
  800e63:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800e66:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800e69:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800e70:	e9 4e ff ff ff       	jmp    800dc3 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800e75:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800e78:	e9 46 ff ff ff       	jmp    800dc3 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800e7d:	8b 45 14             	mov    0x14(%ebp),%eax
  800e80:	83 c0 04             	add    $0x4,%eax
  800e83:	89 45 14             	mov    %eax,0x14(%ebp)
  800e86:	8b 45 14             	mov    0x14(%ebp),%eax
  800e89:	83 e8 04             	sub    $0x4,%eax
  800e8c:	8b 00                	mov    (%eax),%eax
  800e8e:	83 ec 08             	sub    $0x8,%esp
  800e91:	ff 75 0c             	pushl  0xc(%ebp)
  800e94:	50                   	push   %eax
  800e95:	8b 45 08             	mov    0x8(%ebp),%eax
  800e98:	ff d0                	call   *%eax
  800e9a:	83 c4 10             	add    $0x10,%esp
			break;
  800e9d:	e9 89 02 00 00       	jmp    80112b <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800ea2:	8b 45 14             	mov    0x14(%ebp),%eax
  800ea5:	83 c0 04             	add    $0x4,%eax
  800ea8:	89 45 14             	mov    %eax,0x14(%ebp)
  800eab:	8b 45 14             	mov    0x14(%ebp),%eax
  800eae:	83 e8 04             	sub    $0x4,%eax
  800eb1:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800eb3:	85 db                	test   %ebx,%ebx
  800eb5:	79 02                	jns    800eb9 <vprintfmt+0x14a>
				err = -err;
  800eb7:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800eb9:	83 fb 64             	cmp    $0x64,%ebx
  800ebc:	7f 0b                	jg     800ec9 <vprintfmt+0x15a>
  800ebe:	8b 34 9d 40 29 80 00 	mov    0x802940(,%ebx,4),%esi
  800ec5:	85 f6                	test   %esi,%esi
  800ec7:	75 19                	jne    800ee2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ec9:	53                   	push   %ebx
  800eca:	68 e5 2a 80 00       	push   $0x802ae5
  800ecf:	ff 75 0c             	pushl  0xc(%ebp)
  800ed2:	ff 75 08             	pushl  0x8(%ebp)
  800ed5:	e8 5e 02 00 00       	call   801138 <printfmt>
  800eda:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800edd:	e9 49 02 00 00       	jmp    80112b <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800ee2:	56                   	push   %esi
  800ee3:	68 ee 2a 80 00       	push   $0x802aee
  800ee8:	ff 75 0c             	pushl  0xc(%ebp)
  800eeb:	ff 75 08             	pushl  0x8(%ebp)
  800eee:	e8 45 02 00 00       	call   801138 <printfmt>
  800ef3:	83 c4 10             	add    $0x10,%esp
			break;
  800ef6:	e9 30 02 00 00       	jmp    80112b <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800efb:	8b 45 14             	mov    0x14(%ebp),%eax
  800efe:	83 c0 04             	add    $0x4,%eax
  800f01:	89 45 14             	mov    %eax,0x14(%ebp)
  800f04:	8b 45 14             	mov    0x14(%ebp),%eax
  800f07:	83 e8 04             	sub    $0x4,%eax
  800f0a:	8b 30                	mov    (%eax),%esi
  800f0c:	85 f6                	test   %esi,%esi
  800f0e:	75 05                	jne    800f15 <vprintfmt+0x1a6>
				p = "(null)";
  800f10:	be f1 2a 80 00       	mov    $0x802af1,%esi
			if (width > 0 && padc != '-')
  800f15:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f19:	7e 6d                	jle    800f88 <vprintfmt+0x219>
  800f1b:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f1f:	74 67                	je     800f88 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f21:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f24:	83 ec 08             	sub    $0x8,%esp
  800f27:	50                   	push   %eax
  800f28:	56                   	push   %esi
  800f29:	e8 12 05 00 00       	call   801440 <strnlen>
  800f2e:	83 c4 10             	add    $0x10,%esp
  800f31:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f34:	eb 16                	jmp    800f4c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f36:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f3a:	83 ec 08             	sub    $0x8,%esp
  800f3d:	ff 75 0c             	pushl  0xc(%ebp)
  800f40:	50                   	push   %eax
  800f41:	8b 45 08             	mov    0x8(%ebp),%eax
  800f44:	ff d0                	call   *%eax
  800f46:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800f49:	ff 4d e4             	decl   -0x1c(%ebp)
  800f4c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f50:	7f e4                	jg     800f36 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f52:	eb 34                	jmp    800f88 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800f54:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800f58:	74 1c                	je     800f76 <vprintfmt+0x207>
  800f5a:	83 fb 1f             	cmp    $0x1f,%ebx
  800f5d:	7e 05                	jle    800f64 <vprintfmt+0x1f5>
  800f5f:	83 fb 7e             	cmp    $0x7e,%ebx
  800f62:	7e 12                	jle    800f76 <vprintfmt+0x207>
					putch('?', putdat);
  800f64:	83 ec 08             	sub    $0x8,%esp
  800f67:	ff 75 0c             	pushl  0xc(%ebp)
  800f6a:	6a 3f                	push   $0x3f
  800f6c:	8b 45 08             	mov    0x8(%ebp),%eax
  800f6f:	ff d0                	call   *%eax
  800f71:	83 c4 10             	add    $0x10,%esp
  800f74:	eb 0f                	jmp    800f85 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800f76:	83 ec 08             	sub    $0x8,%esp
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	53                   	push   %ebx
  800f7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f80:	ff d0                	call   *%eax
  800f82:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800f85:	ff 4d e4             	decl   -0x1c(%ebp)
  800f88:	89 f0                	mov    %esi,%eax
  800f8a:	8d 70 01             	lea    0x1(%eax),%esi
  800f8d:	8a 00                	mov    (%eax),%al
  800f8f:	0f be d8             	movsbl %al,%ebx
  800f92:	85 db                	test   %ebx,%ebx
  800f94:	74 24                	je     800fba <vprintfmt+0x24b>
  800f96:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800f9a:	78 b8                	js     800f54 <vprintfmt+0x1e5>
  800f9c:	ff 4d e0             	decl   -0x20(%ebp)
  800f9f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800fa3:	79 af                	jns    800f54 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fa5:	eb 13                	jmp    800fba <vprintfmt+0x24b>
				putch(' ', putdat);
  800fa7:	83 ec 08             	sub    $0x8,%esp
  800faa:	ff 75 0c             	pushl  0xc(%ebp)
  800fad:	6a 20                	push   $0x20
  800faf:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb2:	ff d0                	call   *%eax
  800fb4:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800fb7:	ff 4d e4             	decl   -0x1c(%ebp)
  800fba:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fbe:	7f e7                	jg     800fa7 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800fc0:	e9 66 01 00 00       	jmp    80112b <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800fc5:	83 ec 08             	sub    $0x8,%esp
  800fc8:	ff 75 e8             	pushl  -0x18(%ebp)
  800fcb:	8d 45 14             	lea    0x14(%ebp),%eax
  800fce:	50                   	push   %eax
  800fcf:	e8 3c fd ff ff       	call   800d10 <getint>
  800fd4:	83 c4 10             	add    $0x10,%esp
  800fd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fda:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800fdd:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800fe0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800fe3:	85 d2                	test   %edx,%edx
  800fe5:	79 23                	jns    80100a <vprintfmt+0x29b>
				putch('-', putdat);
  800fe7:	83 ec 08             	sub    $0x8,%esp
  800fea:	ff 75 0c             	pushl  0xc(%ebp)
  800fed:	6a 2d                	push   $0x2d
  800fef:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff2:	ff d0                	call   *%eax
  800ff4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800ff7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ffa:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ffd:	f7 d8                	neg    %eax
  800fff:	83 d2 00             	adc    $0x0,%edx
  801002:	f7 da                	neg    %edx
  801004:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801007:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80100a:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801011:	e9 bc 00 00 00       	jmp    8010d2 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  801016:	83 ec 08             	sub    $0x8,%esp
  801019:	ff 75 e8             	pushl  -0x18(%ebp)
  80101c:	8d 45 14             	lea    0x14(%ebp),%eax
  80101f:	50                   	push   %eax
  801020:	e8 84 fc ff ff       	call   800ca9 <getuint>
  801025:	83 c4 10             	add    $0x10,%esp
  801028:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80102b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  80102e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801035:	e9 98 00 00 00       	jmp    8010d2 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80103a:	83 ec 08             	sub    $0x8,%esp
  80103d:	ff 75 0c             	pushl  0xc(%ebp)
  801040:	6a 58                	push   $0x58
  801042:	8b 45 08             	mov    0x8(%ebp),%eax
  801045:	ff d0                	call   *%eax
  801047:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80104a:	83 ec 08             	sub    $0x8,%esp
  80104d:	ff 75 0c             	pushl  0xc(%ebp)
  801050:	6a 58                	push   $0x58
  801052:	8b 45 08             	mov    0x8(%ebp),%eax
  801055:	ff d0                	call   *%eax
  801057:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  80105a:	83 ec 08             	sub    $0x8,%esp
  80105d:	ff 75 0c             	pushl  0xc(%ebp)
  801060:	6a 58                	push   $0x58
  801062:	8b 45 08             	mov    0x8(%ebp),%eax
  801065:	ff d0                	call   *%eax
  801067:	83 c4 10             	add    $0x10,%esp
			break;
  80106a:	e9 bc 00 00 00       	jmp    80112b <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  80106f:	83 ec 08             	sub    $0x8,%esp
  801072:	ff 75 0c             	pushl  0xc(%ebp)
  801075:	6a 30                	push   $0x30
  801077:	8b 45 08             	mov    0x8(%ebp),%eax
  80107a:	ff d0                	call   *%eax
  80107c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  80107f:	83 ec 08             	sub    $0x8,%esp
  801082:	ff 75 0c             	pushl  0xc(%ebp)
  801085:	6a 78                	push   $0x78
  801087:	8b 45 08             	mov    0x8(%ebp),%eax
  80108a:	ff d0                	call   *%eax
  80108c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  80108f:	8b 45 14             	mov    0x14(%ebp),%eax
  801092:	83 c0 04             	add    $0x4,%eax
  801095:	89 45 14             	mov    %eax,0x14(%ebp)
  801098:	8b 45 14             	mov    0x14(%ebp),%eax
  80109b:	83 e8 04             	sub    $0x4,%eax
  80109e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  8010a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010a3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  8010aa:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  8010b1:	eb 1f                	jmp    8010d2 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  8010b3:	83 ec 08             	sub    $0x8,%esp
  8010b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8010b9:	8d 45 14             	lea    0x14(%ebp),%eax
  8010bc:	50                   	push   %eax
  8010bd:	e8 e7 fb ff ff       	call   800ca9 <getuint>
  8010c2:	83 c4 10             	add    $0x10,%esp
  8010c5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010c8:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  8010cb:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  8010d2:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  8010d6:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8010d9:	83 ec 04             	sub    $0x4,%esp
  8010dc:	52                   	push   %edx
  8010dd:	ff 75 e4             	pushl  -0x1c(%ebp)
  8010e0:	50                   	push   %eax
  8010e1:	ff 75 f4             	pushl  -0xc(%ebp)
  8010e4:	ff 75 f0             	pushl  -0x10(%ebp)
  8010e7:	ff 75 0c             	pushl  0xc(%ebp)
  8010ea:	ff 75 08             	pushl  0x8(%ebp)
  8010ed:	e8 00 fb ff ff       	call   800bf2 <printnum>
  8010f2:	83 c4 20             	add    $0x20,%esp
			break;
  8010f5:	eb 34                	jmp    80112b <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  8010f7:	83 ec 08             	sub    $0x8,%esp
  8010fa:	ff 75 0c             	pushl  0xc(%ebp)
  8010fd:	53                   	push   %ebx
  8010fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801101:	ff d0                	call   *%eax
  801103:	83 c4 10             	add    $0x10,%esp
			break;
  801106:	eb 23                	jmp    80112b <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801108:	83 ec 08             	sub    $0x8,%esp
  80110b:	ff 75 0c             	pushl  0xc(%ebp)
  80110e:	6a 25                	push   $0x25
  801110:	8b 45 08             	mov    0x8(%ebp),%eax
  801113:	ff d0                	call   *%eax
  801115:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  801118:	ff 4d 10             	decl   0x10(%ebp)
  80111b:	eb 03                	jmp    801120 <vprintfmt+0x3b1>
  80111d:	ff 4d 10             	decl   0x10(%ebp)
  801120:	8b 45 10             	mov    0x10(%ebp),%eax
  801123:	48                   	dec    %eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	3c 25                	cmp    $0x25,%al
  801128:	75 f3                	jne    80111d <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80112a:	90                   	nop
		}
	}
  80112b:	e9 47 fc ff ff       	jmp    800d77 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801130:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801131:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801134:	5b                   	pop    %ebx
  801135:	5e                   	pop    %esi
  801136:	5d                   	pop    %ebp
  801137:	c3                   	ret    

00801138 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  801138:	55                   	push   %ebp
  801139:	89 e5                	mov    %esp,%ebp
  80113b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  80113e:	8d 45 10             	lea    0x10(%ebp),%eax
  801141:	83 c0 04             	add    $0x4,%eax
  801144:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  801147:	8b 45 10             	mov    0x10(%ebp),%eax
  80114a:	ff 75 f4             	pushl  -0xc(%ebp)
  80114d:	50                   	push   %eax
  80114e:	ff 75 0c             	pushl  0xc(%ebp)
  801151:	ff 75 08             	pushl  0x8(%ebp)
  801154:	e8 16 fc ff ff       	call   800d6f <vprintfmt>
  801159:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  80115c:	90                   	nop
  80115d:	c9                   	leave  
  80115e:	c3                   	ret    

0080115f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  80115f:	55                   	push   %ebp
  801160:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  801162:	8b 45 0c             	mov    0xc(%ebp),%eax
  801165:	8b 40 08             	mov    0x8(%eax),%eax
  801168:	8d 50 01             	lea    0x1(%eax),%edx
  80116b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801171:	8b 45 0c             	mov    0xc(%ebp),%eax
  801174:	8b 10                	mov    (%eax),%edx
  801176:	8b 45 0c             	mov    0xc(%ebp),%eax
  801179:	8b 40 04             	mov    0x4(%eax),%eax
  80117c:	39 c2                	cmp    %eax,%edx
  80117e:	73 12                	jae    801192 <sprintputch+0x33>
		*b->buf++ = ch;
  801180:	8b 45 0c             	mov    0xc(%ebp),%eax
  801183:	8b 00                	mov    (%eax),%eax
  801185:	8d 48 01             	lea    0x1(%eax),%ecx
  801188:	8b 55 0c             	mov    0xc(%ebp),%edx
  80118b:	89 0a                	mov    %ecx,(%edx)
  80118d:	8b 55 08             	mov    0x8(%ebp),%edx
  801190:	88 10                	mov    %dl,(%eax)
}
  801192:	90                   	nop
  801193:	5d                   	pop    %ebp
  801194:	c3                   	ret    

00801195 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801195:	55                   	push   %ebp
  801196:	89 e5                	mov    %esp,%ebp
  801198:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80119b:	8b 45 08             	mov    0x8(%ebp),%eax
  80119e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  8011a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011a4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8011a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011aa:	01 d0                	add    %edx,%eax
  8011ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8011af:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  8011b6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8011ba:	74 06                	je     8011c2 <vsnprintf+0x2d>
  8011bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8011c0:	7f 07                	jg     8011c9 <vsnprintf+0x34>
		return -E_INVAL;
  8011c2:	b8 03 00 00 00       	mov    $0x3,%eax
  8011c7:	eb 20                	jmp    8011e9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  8011c9:	ff 75 14             	pushl  0x14(%ebp)
  8011cc:	ff 75 10             	pushl  0x10(%ebp)
  8011cf:	8d 45 ec             	lea    -0x14(%ebp),%eax
  8011d2:	50                   	push   %eax
  8011d3:	68 5f 11 80 00       	push   $0x80115f
  8011d8:	e8 92 fb ff ff       	call   800d6f <vprintfmt>
  8011dd:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  8011e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8011e3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  8011e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8011e9:	c9                   	leave  
  8011ea:	c3                   	ret    

008011eb <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  8011eb:	55                   	push   %ebp
  8011ec:	89 e5                	mov    %esp,%ebp
  8011ee:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  8011f1:	8d 45 10             	lea    0x10(%ebp),%eax
  8011f4:	83 c0 04             	add    $0x4,%eax
  8011f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  8011fa:	8b 45 10             	mov    0x10(%ebp),%eax
  8011fd:	ff 75 f4             	pushl  -0xc(%ebp)
  801200:	50                   	push   %eax
  801201:	ff 75 0c             	pushl  0xc(%ebp)
  801204:	ff 75 08             	pushl  0x8(%ebp)
  801207:	e8 89 ff ff ff       	call   801195 <vsnprintf>
  80120c:	83 c4 10             	add    $0x10,%esp
  80120f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801212:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801215:	c9                   	leave  
  801216:	c3                   	ret    

00801217 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  801217:	55                   	push   %ebp
  801218:	89 e5                	mov    %esp,%ebp
  80121a:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  80121d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801221:	74 13                	je     801236 <readline+0x1f>
		cprintf("%s", prompt);
  801223:	83 ec 08             	sub    $0x8,%esp
  801226:	ff 75 08             	pushl  0x8(%ebp)
  801229:	68 50 2c 80 00       	push   $0x802c50
  80122e:	e8 62 f9 ff ff       	call   800b95 <cprintf>
  801233:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801236:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  80123d:	83 ec 0c             	sub    $0xc,%esp
  801240:	6a 00                	push   $0x0
  801242:	e8 74 f5 ff ff       	call   8007bb <iscons>
  801247:	83 c4 10             	add    $0x10,%esp
  80124a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  80124d:	e8 1b f5 ff ff       	call   80076d <getchar>
  801252:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801255:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801259:	79 22                	jns    80127d <readline+0x66>
			if (c != -E_EOF)
  80125b:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  80125f:	0f 84 ad 00 00 00    	je     801312 <readline+0xfb>
				cprintf("read error: %e\n", c);
  801265:	83 ec 08             	sub    $0x8,%esp
  801268:	ff 75 ec             	pushl  -0x14(%ebp)
  80126b:	68 53 2c 80 00       	push   $0x802c53
  801270:	e8 20 f9 ff ff       	call   800b95 <cprintf>
  801275:	83 c4 10             	add    $0x10,%esp
			return;
  801278:	e9 95 00 00 00       	jmp    801312 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80127d:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801281:	7e 34                	jle    8012b7 <readline+0xa0>
  801283:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80128a:	7f 2b                	jg     8012b7 <readline+0xa0>
			if (echoing)
  80128c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801290:	74 0e                	je     8012a0 <readline+0x89>
				cputchar(c);
  801292:	83 ec 0c             	sub    $0xc,%esp
  801295:	ff 75 ec             	pushl  -0x14(%ebp)
  801298:	e8 88 f4 ff ff       	call   800725 <cputchar>
  80129d:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8012a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8012a3:	8d 50 01             	lea    0x1(%eax),%edx
  8012a6:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8012a9:	89 c2                	mov    %eax,%edx
  8012ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ae:	01 d0                	add    %edx,%eax
  8012b0:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012b3:	88 10                	mov    %dl,(%eax)
  8012b5:	eb 56                	jmp    80130d <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  8012b7:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8012bb:	75 1f                	jne    8012dc <readline+0xc5>
  8012bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8012c1:	7e 19                	jle    8012dc <readline+0xc5>
			if (echoing)
  8012c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012c7:	74 0e                	je     8012d7 <readline+0xc0>
				cputchar(c);
  8012c9:	83 ec 0c             	sub    $0xc,%esp
  8012cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8012cf:	e8 51 f4 ff ff       	call   800725 <cputchar>
  8012d4:	83 c4 10             	add    $0x10,%esp

			i--;
  8012d7:	ff 4d f4             	decl   -0xc(%ebp)
  8012da:	eb 31                	jmp    80130d <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  8012dc:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8012e0:	74 0a                	je     8012ec <readline+0xd5>
  8012e2:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8012e6:	0f 85 61 ff ff ff    	jne    80124d <readline+0x36>
			if (echoing)
  8012ec:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012f0:	74 0e                	je     801300 <readline+0xe9>
				cputchar(c);
  8012f2:	83 ec 0c             	sub    $0xc,%esp
  8012f5:	ff 75 ec             	pushl  -0x14(%ebp)
  8012f8:	e8 28 f4 ff ff       	call   800725 <cputchar>
  8012fd:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801300:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801303:	8b 45 0c             	mov    0xc(%ebp),%eax
  801306:	01 d0                	add    %edx,%eax
  801308:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80130b:	eb 06                	jmp    801313 <readline+0xfc>
		}
	}
  80130d:	e9 3b ff ff ff       	jmp    80124d <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801312:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801313:	c9                   	leave  
  801314:	c3                   	ret    

00801315 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801315:	55                   	push   %ebp
  801316:	89 e5                	mov    %esp,%ebp
  801318:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80131b:	e8 31 0b 00 00       	call   801e51 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801320:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801324:	74 13                	je     801339 <atomic_readline+0x24>
		cprintf("%s", prompt);
  801326:	83 ec 08             	sub    $0x8,%esp
  801329:	ff 75 08             	pushl  0x8(%ebp)
  80132c:	68 50 2c 80 00       	push   $0x802c50
  801331:	e8 5f f8 ff ff       	call   800b95 <cprintf>
  801336:	83 c4 10             	add    $0x10,%esp

	i = 0;
  801339:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  801340:	83 ec 0c             	sub    $0xc,%esp
  801343:	6a 00                	push   $0x0
  801345:	e8 71 f4 ff ff       	call   8007bb <iscons>
  80134a:	83 c4 10             	add    $0x10,%esp
  80134d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  801350:	e8 18 f4 ff ff       	call   80076d <getchar>
  801355:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  801358:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80135c:	79 23                	jns    801381 <atomic_readline+0x6c>
			if (c != -E_EOF)
  80135e:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  801362:	74 13                	je     801377 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  801364:	83 ec 08             	sub    $0x8,%esp
  801367:	ff 75 ec             	pushl  -0x14(%ebp)
  80136a:	68 53 2c 80 00       	push   $0x802c53
  80136f:	e8 21 f8 ff ff       	call   800b95 <cprintf>
  801374:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801377:	e8 ef 0a 00 00       	call   801e6b <sys_enable_interrupt>
			return;
  80137c:	e9 9a 00 00 00       	jmp    80141b <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801381:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801385:	7e 34                	jle    8013bb <atomic_readline+0xa6>
  801387:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80138e:	7f 2b                	jg     8013bb <atomic_readline+0xa6>
			if (echoing)
  801390:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801394:	74 0e                	je     8013a4 <atomic_readline+0x8f>
				cputchar(c);
  801396:	83 ec 0c             	sub    $0xc,%esp
  801399:	ff 75 ec             	pushl  -0x14(%ebp)
  80139c:	e8 84 f3 ff ff       	call   800725 <cputchar>
  8013a1:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  8013a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8013a7:	8d 50 01             	lea    0x1(%eax),%edx
  8013aa:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8013ad:	89 c2                	mov    %eax,%edx
  8013af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013b2:	01 d0                	add    %edx,%eax
  8013b4:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8013b7:	88 10                	mov    %dl,(%eax)
  8013b9:	eb 5b                	jmp    801416 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  8013bb:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  8013bf:	75 1f                	jne    8013e0 <atomic_readline+0xcb>
  8013c1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8013c5:	7e 19                	jle    8013e0 <atomic_readline+0xcb>
			if (echoing)
  8013c7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013cb:	74 0e                	je     8013db <atomic_readline+0xc6>
				cputchar(c);
  8013cd:	83 ec 0c             	sub    $0xc,%esp
  8013d0:	ff 75 ec             	pushl  -0x14(%ebp)
  8013d3:	e8 4d f3 ff ff       	call   800725 <cputchar>
  8013d8:	83 c4 10             	add    $0x10,%esp
			i--;
  8013db:	ff 4d f4             	decl   -0xc(%ebp)
  8013de:	eb 36                	jmp    801416 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  8013e0:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  8013e4:	74 0a                	je     8013f0 <atomic_readline+0xdb>
  8013e6:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  8013ea:	0f 85 60 ff ff ff    	jne    801350 <atomic_readline+0x3b>
			if (echoing)
  8013f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013f4:	74 0e                	je     801404 <atomic_readline+0xef>
				cputchar(c);
  8013f6:	83 ec 0c             	sub    $0xc,%esp
  8013f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8013fc:	e8 24 f3 ff ff       	call   800725 <cputchar>
  801401:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801404:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801407:	8b 45 0c             	mov    0xc(%ebp),%eax
  80140a:	01 d0                	add    %edx,%eax
  80140c:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  80140f:	e8 57 0a 00 00       	call   801e6b <sys_enable_interrupt>
			return;
  801414:	eb 05                	jmp    80141b <atomic_readline+0x106>
		}
	}
  801416:	e9 35 ff ff ff       	jmp    801350 <atomic_readline+0x3b>
}
  80141b:	c9                   	leave  
  80141c:	c3                   	ret    

0080141d <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  80141d:	55                   	push   %ebp
  80141e:	89 e5                	mov    %esp,%ebp
  801420:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801423:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80142a:	eb 06                	jmp    801432 <strlen+0x15>
		n++;
  80142c:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  80142f:	ff 45 08             	incl   0x8(%ebp)
  801432:	8b 45 08             	mov    0x8(%ebp),%eax
  801435:	8a 00                	mov    (%eax),%al
  801437:	84 c0                	test   %al,%al
  801439:	75 f1                	jne    80142c <strlen+0xf>
		n++;
	return n;
  80143b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80143e:	c9                   	leave  
  80143f:	c3                   	ret    

00801440 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801440:	55                   	push   %ebp
  801441:	89 e5                	mov    %esp,%ebp
  801443:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801446:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80144d:	eb 09                	jmp    801458 <strnlen+0x18>
		n++;
  80144f:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801452:	ff 45 08             	incl   0x8(%ebp)
  801455:	ff 4d 0c             	decl   0xc(%ebp)
  801458:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80145c:	74 09                	je     801467 <strnlen+0x27>
  80145e:	8b 45 08             	mov    0x8(%ebp),%eax
  801461:	8a 00                	mov    (%eax),%al
  801463:	84 c0                	test   %al,%al
  801465:	75 e8                	jne    80144f <strnlen+0xf>
		n++;
	return n;
  801467:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80146a:	c9                   	leave  
  80146b:	c3                   	ret    

0080146c <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80146c:	55                   	push   %ebp
  80146d:	89 e5                	mov    %esp,%ebp
  80146f:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801472:	8b 45 08             	mov    0x8(%ebp),%eax
  801475:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801478:	90                   	nop
  801479:	8b 45 08             	mov    0x8(%ebp),%eax
  80147c:	8d 50 01             	lea    0x1(%eax),%edx
  80147f:	89 55 08             	mov    %edx,0x8(%ebp)
  801482:	8b 55 0c             	mov    0xc(%ebp),%edx
  801485:	8d 4a 01             	lea    0x1(%edx),%ecx
  801488:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80148b:	8a 12                	mov    (%edx),%dl
  80148d:	88 10                	mov    %dl,(%eax)
  80148f:	8a 00                	mov    (%eax),%al
  801491:	84 c0                	test   %al,%al
  801493:	75 e4                	jne    801479 <strcpy+0xd>
		/* do nothing */;
	return ret;
  801495:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801498:	c9                   	leave  
  801499:	c3                   	ret    

0080149a <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80149a:	55                   	push   %ebp
  80149b:	89 e5                	mov    %esp,%ebp
  80149d:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8014a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a3:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8014a6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014ad:	eb 1f                	jmp    8014ce <strncpy+0x34>
		*dst++ = *src;
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	8d 50 01             	lea    0x1(%eax),%edx
  8014b5:	89 55 08             	mov    %edx,0x8(%ebp)
  8014b8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014bb:	8a 12                	mov    (%edx),%dl
  8014bd:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8014bf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c2:	8a 00                	mov    (%eax),%al
  8014c4:	84 c0                	test   %al,%al
  8014c6:	74 03                	je     8014cb <strncpy+0x31>
			src++;
  8014c8:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8014cb:	ff 45 fc             	incl   -0x4(%ebp)
  8014ce:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8014d1:	3b 45 10             	cmp    0x10(%ebp),%eax
  8014d4:	72 d9                	jb     8014af <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8014d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014d9:	c9                   	leave  
  8014da:	c3                   	ret    

008014db <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8014db:	55                   	push   %ebp
  8014dc:	89 e5                	mov    %esp,%ebp
  8014de:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8014e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8014e7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8014eb:	74 30                	je     80151d <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  8014ed:	eb 16                	jmp    801505 <strlcpy+0x2a>
			*dst++ = *src++;
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	8d 50 01             	lea    0x1(%eax),%edx
  8014f5:	89 55 08             	mov    %edx,0x8(%ebp)
  8014f8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014fb:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014fe:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801501:	8a 12                	mov    (%edx),%dl
  801503:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801505:	ff 4d 10             	decl   0x10(%ebp)
  801508:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80150c:	74 09                	je     801517 <strlcpy+0x3c>
  80150e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801511:	8a 00                	mov    (%eax),%al
  801513:	84 c0                	test   %al,%al
  801515:	75 d8                	jne    8014ef <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  80151d:	8b 55 08             	mov    0x8(%ebp),%edx
  801520:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801523:	29 c2                	sub    %eax,%edx
  801525:	89 d0                	mov    %edx,%eax
}
  801527:	c9                   	leave  
  801528:	c3                   	ret    

00801529 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801529:	55                   	push   %ebp
  80152a:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80152c:	eb 06                	jmp    801534 <strcmp+0xb>
		p++, q++;
  80152e:	ff 45 08             	incl   0x8(%ebp)
  801531:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801534:	8b 45 08             	mov    0x8(%ebp),%eax
  801537:	8a 00                	mov    (%eax),%al
  801539:	84 c0                	test   %al,%al
  80153b:	74 0e                	je     80154b <strcmp+0x22>
  80153d:	8b 45 08             	mov    0x8(%ebp),%eax
  801540:	8a 10                	mov    (%eax),%dl
  801542:	8b 45 0c             	mov    0xc(%ebp),%eax
  801545:	8a 00                	mov    (%eax),%al
  801547:	38 c2                	cmp    %al,%dl
  801549:	74 e3                	je     80152e <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80154b:	8b 45 08             	mov    0x8(%ebp),%eax
  80154e:	8a 00                	mov    (%eax),%al
  801550:	0f b6 d0             	movzbl %al,%edx
  801553:	8b 45 0c             	mov    0xc(%ebp),%eax
  801556:	8a 00                	mov    (%eax),%al
  801558:	0f b6 c0             	movzbl %al,%eax
  80155b:	29 c2                	sub    %eax,%edx
  80155d:	89 d0                	mov    %edx,%eax
}
  80155f:	5d                   	pop    %ebp
  801560:	c3                   	ret    

00801561 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801561:	55                   	push   %ebp
  801562:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801564:	eb 09                	jmp    80156f <strncmp+0xe>
		n--, p++, q++;
  801566:	ff 4d 10             	decl   0x10(%ebp)
  801569:	ff 45 08             	incl   0x8(%ebp)
  80156c:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  80156f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801573:	74 17                	je     80158c <strncmp+0x2b>
  801575:	8b 45 08             	mov    0x8(%ebp),%eax
  801578:	8a 00                	mov    (%eax),%al
  80157a:	84 c0                	test   %al,%al
  80157c:	74 0e                	je     80158c <strncmp+0x2b>
  80157e:	8b 45 08             	mov    0x8(%ebp),%eax
  801581:	8a 10                	mov    (%eax),%dl
  801583:	8b 45 0c             	mov    0xc(%ebp),%eax
  801586:	8a 00                	mov    (%eax),%al
  801588:	38 c2                	cmp    %al,%dl
  80158a:	74 da                	je     801566 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80158c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801590:	75 07                	jne    801599 <strncmp+0x38>
		return 0;
  801592:	b8 00 00 00 00       	mov    $0x0,%eax
  801597:	eb 14                	jmp    8015ad <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  801599:	8b 45 08             	mov    0x8(%ebp),%eax
  80159c:	8a 00                	mov    (%eax),%al
  80159e:	0f b6 d0             	movzbl %al,%edx
  8015a1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a4:	8a 00                	mov    (%eax),%al
  8015a6:	0f b6 c0             	movzbl %al,%eax
  8015a9:	29 c2                	sub    %eax,%edx
  8015ab:	89 d0                	mov    %edx,%eax
}
  8015ad:	5d                   	pop    %ebp
  8015ae:	c3                   	ret    

008015af <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8015af:	55                   	push   %ebp
  8015b0:	89 e5                	mov    %esp,%ebp
  8015b2:	83 ec 04             	sub    $0x4,%esp
  8015b5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015b8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015bb:	eb 12                	jmp    8015cf <strchr+0x20>
		if (*s == c)
  8015bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c0:	8a 00                	mov    (%eax),%al
  8015c2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015c5:	75 05                	jne    8015cc <strchr+0x1d>
			return (char *) s;
  8015c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ca:	eb 11                	jmp    8015dd <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8015cc:	ff 45 08             	incl   0x8(%ebp)
  8015cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d2:	8a 00                	mov    (%eax),%al
  8015d4:	84 c0                	test   %al,%al
  8015d6:	75 e5                	jne    8015bd <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8015d8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8015dd:	c9                   	leave  
  8015de:	c3                   	ret    

008015df <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
  8015e2:	83 ec 04             	sub    $0x4,%esp
  8015e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e8:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8015eb:	eb 0d                	jmp    8015fa <strfind+0x1b>
		if (*s == c)
  8015ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8015f0:	8a 00                	mov    (%eax),%al
  8015f2:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8015f5:	74 0e                	je     801605 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  8015f7:	ff 45 08             	incl   0x8(%ebp)
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	8a 00                	mov    (%eax),%al
  8015ff:	84 c0                	test   %al,%al
  801601:	75 ea                	jne    8015ed <strfind+0xe>
  801603:	eb 01                	jmp    801606 <strfind+0x27>
		if (*s == c)
			break;
  801605:	90                   	nop
	return (char *) s;
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801609:	c9                   	leave  
  80160a:	c3                   	ret    

0080160b <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80160b:	55                   	push   %ebp
  80160c:	89 e5                	mov    %esp,%ebp
  80160e:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801611:	8b 45 08             	mov    0x8(%ebp),%eax
  801614:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  801617:	8b 45 10             	mov    0x10(%ebp),%eax
  80161a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  80161d:	eb 0e                	jmp    80162d <memset+0x22>
		*p++ = c;
  80161f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801622:	8d 50 01             	lea    0x1(%eax),%edx
  801625:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801628:	8b 55 0c             	mov    0xc(%ebp),%edx
  80162b:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  80162d:	ff 4d f8             	decl   -0x8(%ebp)
  801630:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801634:	79 e9                	jns    80161f <memset+0x14>
		*p++ = c;

	return v;
  801636:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801639:	c9                   	leave  
  80163a:	c3                   	ret    

0080163b <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80163b:	55                   	push   %ebp
  80163c:	89 e5                	mov    %esp,%ebp
  80163e:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801641:	8b 45 0c             	mov    0xc(%ebp),%eax
  801644:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801647:	8b 45 08             	mov    0x8(%ebp),%eax
  80164a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  80164d:	eb 16                	jmp    801665 <memcpy+0x2a>
		*d++ = *s++;
  80164f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801652:	8d 50 01             	lea    0x1(%eax),%edx
  801655:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801658:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80165b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80165e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801661:	8a 12                	mov    (%edx),%dl
  801663:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801665:	8b 45 10             	mov    0x10(%ebp),%eax
  801668:	8d 50 ff             	lea    -0x1(%eax),%edx
  80166b:	89 55 10             	mov    %edx,0x10(%ebp)
  80166e:	85 c0                	test   %eax,%eax
  801670:	75 dd                	jne    80164f <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801672:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801675:	c9                   	leave  
  801676:	c3                   	ret    

00801677 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801677:	55                   	push   %ebp
  801678:	89 e5                	mov    %esp,%ebp
  80167a:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80167d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801680:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801683:	8b 45 08             	mov    0x8(%ebp),%eax
  801686:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801689:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80168c:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80168f:	73 50                	jae    8016e1 <memmove+0x6a>
  801691:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801694:	8b 45 10             	mov    0x10(%ebp),%eax
  801697:	01 d0                	add    %edx,%eax
  801699:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80169c:	76 43                	jbe    8016e1 <memmove+0x6a>
		s += n;
  80169e:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a1:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8016a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8016a7:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8016aa:	eb 10                	jmp    8016bc <memmove+0x45>
			*--d = *--s;
  8016ac:	ff 4d f8             	decl   -0x8(%ebp)
  8016af:	ff 4d fc             	decl   -0x4(%ebp)
  8016b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016b5:	8a 10                	mov    (%eax),%dl
  8016b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ba:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8016bc:	8b 45 10             	mov    0x10(%ebp),%eax
  8016bf:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016c2:	89 55 10             	mov    %edx,0x10(%ebp)
  8016c5:	85 c0                	test   %eax,%eax
  8016c7:	75 e3                	jne    8016ac <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8016c9:	eb 23                	jmp    8016ee <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8016cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016ce:	8d 50 01             	lea    0x1(%eax),%edx
  8016d1:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016d7:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016da:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016dd:	8a 12                	mov    (%edx),%dl
  8016df:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8016e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e4:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016e7:	89 55 10             	mov    %edx,0x10(%ebp)
  8016ea:	85 c0                	test   %eax,%eax
  8016ec:	75 dd                	jne    8016cb <memmove+0x54>
			*d++ = *s++;

	return dst;
  8016ee:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016f1:	c9                   	leave  
  8016f2:	c3                   	ret    

008016f3 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8016f3:	55                   	push   %ebp
  8016f4:	89 e5                	mov    %esp,%ebp
  8016f6:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8016f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8016ff:	8b 45 0c             	mov    0xc(%ebp),%eax
  801702:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801705:	eb 2a                	jmp    801731 <memcmp+0x3e>
		if (*s1 != *s2)
  801707:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80170a:	8a 10                	mov    (%eax),%dl
  80170c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80170f:	8a 00                	mov    (%eax),%al
  801711:	38 c2                	cmp    %al,%dl
  801713:	74 16                	je     80172b <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801715:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801718:	8a 00                	mov    (%eax),%al
  80171a:	0f b6 d0             	movzbl %al,%edx
  80171d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801720:	8a 00                	mov    (%eax),%al
  801722:	0f b6 c0             	movzbl %al,%eax
  801725:	29 c2                	sub    %eax,%edx
  801727:	89 d0                	mov    %edx,%eax
  801729:	eb 18                	jmp    801743 <memcmp+0x50>
		s1++, s2++;
  80172b:	ff 45 fc             	incl   -0x4(%ebp)
  80172e:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801731:	8b 45 10             	mov    0x10(%ebp),%eax
  801734:	8d 50 ff             	lea    -0x1(%eax),%edx
  801737:	89 55 10             	mov    %edx,0x10(%ebp)
  80173a:	85 c0                	test   %eax,%eax
  80173c:	75 c9                	jne    801707 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  80173e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801743:	c9                   	leave  
  801744:	c3                   	ret    

00801745 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801745:	55                   	push   %ebp
  801746:	89 e5                	mov    %esp,%ebp
  801748:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80174b:	8b 55 08             	mov    0x8(%ebp),%edx
  80174e:	8b 45 10             	mov    0x10(%ebp),%eax
  801751:	01 d0                	add    %edx,%eax
  801753:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801756:	eb 15                	jmp    80176d <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801758:	8b 45 08             	mov    0x8(%ebp),%eax
  80175b:	8a 00                	mov    (%eax),%al
  80175d:	0f b6 d0             	movzbl %al,%edx
  801760:	8b 45 0c             	mov    0xc(%ebp),%eax
  801763:	0f b6 c0             	movzbl %al,%eax
  801766:	39 c2                	cmp    %eax,%edx
  801768:	74 0d                	je     801777 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80176a:	ff 45 08             	incl   0x8(%ebp)
  80176d:	8b 45 08             	mov    0x8(%ebp),%eax
  801770:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801773:	72 e3                	jb     801758 <memfind+0x13>
  801775:	eb 01                	jmp    801778 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801777:	90                   	nop
	return (void *) s;
  801778:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80177b:	c9                   	leave  
  80177c:	c3                   	ret    

0080177d <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80177d:	55                   	push   %ebp
  80177e:	89 e5                	mov    %esp,%ebp
  801780:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801783:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80178a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801791:	eb 03                	jmp    801796 <strtol+0x19>
		s++;
  801793:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801796:	8b 45 08             	mov    0x8(%ebp),%eax
  801799:	8a 00                	mov    (%eax),%al
  80179b:	3c 20                	cmp    $0x20,%al
  80179d:	74 f4                	je     801793 <strtol+0x16>
  80179f:	8b 45 08             	mov    0x8(%ebp),%eax
  8017a2:	8a 00                	mov    (%eax),%al
  8017a4:	3c 09                	cmp    $0x9,%al
  8017a6:	74 eb                	je     801793 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8017a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ab:	8a 00                	mov    (%eax),%al
  8017ad:	3c 2b                	cmp    $0x2b,%al
  8017af:	75 05                	jne    8017b6 <strtol+0x39>
		s++;
  8017b1:	ff 45 08             	incl   0x8(%ebp)
  8017b4:	eb 13                	jmp    8017c9 <strtol+0x4c>
	else if (*s == '-')
  8017b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b9:	8a 00                	mov    (%eax),%al
  8017bb:	3c 2d                	cmp    $0x2d,%al
  8017bd:	75 0a                	jne    8017c9 <strtol+0x4c>
		s++, neg = 1;
  8017bf:	ff 45 08             	incl   0x8(%ebp)
  8017c2:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8017c9:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017cd:	74 06                	je     8017d5 <strtol+0x58>
  8017cf:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8017d3:	75 20                	jne    8017f5 <strtol+0x78>
  8017d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d8:	8a 00                	mov    (%eax),%al
  8017da:	3c 30                	cmp    $0x30,%al
  8017dc:	75 17                	jne    8017f5 <strtol+0x78>
  8017de:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e1:	40                   	inc    %eax
  8017e2:	8a 00                	mov    (%eax),%al
  8017e4:	3c 78                	cmp    $0x78,%al
  8017e6:	75 0d                	jne    8017f5 <strtol+0x78>
		s += 2, base = 16;
  8017e8:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8017ec:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8017f3:	eb 28                	jmp    80181d <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8017f5:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8017f9:	75 15                	jne    801810 <strtol+0x93>
  8017fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fe:	8a 00                	mov    (%eax),%al
  801800:	3c 30                	cmp    $0x30,%al
  801802:	75 0c                	jne    801810 <strtol+0x93>
		s++, base = 8;
  801804:	ff 45 08             	incl   0x8(%ebp)
  801807:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80180e:	eb 0d                	jmp    80181d <strtol+0xa0>
	else if (base == 0)
  801810:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801814:	75 07                	jne    80181d <strtol+0xa0>
		base = 10;
  801816:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	8a 00                	mov    (%eax),%al
  801822:	3c 2f                	cmp    $0x2f,%al
  801824:	7e 19                	jle    80183f <strtol+0xc2>
  801826:	8b 45 08             	mov    0x8(%ebp),%eax
  801829:	8a 00                	mov    (%eax),%al
  80182b:	3c 39                	cmp    $0x39,%al
  80182d:	7f 10                	jg     80183f <strtol+0xc2>
			dig = *s - '0';
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	8a 00                	mov    (%eax),%al
  801834:	0f be c0             	movsbl %al,%eax
  801837:	83 e8 30             	sub    $0x30,%eax
  80183a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80183d:	eb 42                	jmp    801881 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80183f:	8b 45 08             	mov    0x8(%ebp),%eax
  801842:	8a 00                	mov    (%eax),%al
  801844:	3c 60                	cmp    $0x60,%al
  801846:	7e 19                	jle    801861 <strtol+0xe4>
  801848:	8b 45 08             	mov    0x8(%ebp),%eax
  80184b:	8a 00                	mov    (%eax),%al
  80184d:	3c 7a                	cmp    $0x7a,%al
  80184f:	7f 10                	jg     801861 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801851:	8b 45 08             	mov    0x8(%ebp),%eax
  801854:	8a 00                	mov    (%eax),%al
  801856:	0f be c0             	movsbl %al,%eax
  801859:	83 e8 57             	sub    $0x57,%eax
  80185c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80185f:	eb 20                	jmp    801881 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801861:	8b 45 08             	mov    0x8(%ebp),%eax
  801864:	8a 00                	mov    (%eax),%al
  801866:	3c 40                	cmp    $0x40,%al
  801868:	7e 39                	jle    8018a3 <strtol+0x126>
  80186a:	8b 45 08             	mov    0x8(%ebp),%eax
  80186d:	8a 00                	mov    (%eax),%al
  80186f:	3c 5a                	cmp    $0x5a,%al
  801871:	7f 30                	jg     8018a3 <strtol+0x126>
			dig = *s - 'A' + 10;
  801873:	8b 45 08             	mov    0x8(%ebp),%eax
  801876:	8a 00                	mov    (%eax),%al
  801878:	0f be c0             	movsbl %al,%eax
  80187b:	83 e8 37             	sub    $0x37,%eax
  80187e:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801881:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801884:	3b 45 10             	cmp    0x10(%ebp),%eax
  801887:	7d 19                	jge    8018a2 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801889:	ff 45 08             	incl   0x8(%ebp)
  80188c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80188f:	0f af 45 10          	imul   0x10(%ebp),%eax
  801893:	89 c2                	mov    %eax,%edx
  801895:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801898:	01 d0                	add    %edx,%eax
  80189a:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80189d:	e9 7b ff ff ff       	jmp    80181d <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8018a2:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8018a3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8018a7:	74 08                	je     8018b1 <strtol+0x134>
		*endptr = (char *) s;
  8018a9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018ac:	8b 55 08             	mov    0x8(%ebp),%edx
  8018af:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8018b1:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8018b5:	74 07                	je     8018be <strtol+0x141>
  8018b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ba:	f7 d8                	neg    %eax
  8018bc:	eb 03                	jmp    8018c1 <strtol+0x144>
  8018be:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8018c1:	c9                   	leave  
  8018c2:	c3                   	ret    

008018c3 <ltostr>:

void
ltostr(long value, char *str)
{
  8018c3:	55                   	push   %ebp
  8018c4:	89 e5                	mov    %esp,%ebp
  8018c6:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8018c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8018d0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8018d7:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8018db:	79 13                	jns    8018f0 <ltostr+0x2d>
	{
		neg = 1;
  8018dd:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8018e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8018e7:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8018ea:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8018ed:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8018f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f3:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8018f8:	99                   	cltd   
  8018f9:	f7 f9                	idiv   %ecx
  8018fb:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8018fe:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801901:	8d 50 01             	lea    0x1(%eax),%edx
  801904:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801907:	89 c2                	mov    %eax,%edx
  801909:	8b 45 0c             	mov    0xc(%ebp),%eax
  80190c:	01 d0                	add    %edx,%eax
  80190e:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801911:	83 c2 30             	add    $0x30,%edx
  801914:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801916:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801919:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80191e:	f7 e9                	imul   %ecx
  801920:	c1 fa 02             	sar    $0x2,%edx
  801923:	89 c8                	mov    %ecx,%eax
  801925:	c1 f8 1f             	sar    $0x1f,%eax
  801928:	29 c2                	sub    %eax,%edx
  80192a:	89 d0                	mov    %edx,%eax
  80192c:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80192f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801932:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801937:	f7 e9                	imul   %ecx
  801939:	c1 fa 02             	sar    $0x2,%edx
  80193c:	89 c8                	mov    %ecx,%eax
  80193e:	c1 f8 1f             	sar    $0x1f,%eax
  801941:	29 c2                	sub    %eax,%edx
  801943:	89 d0                	mov    %edx,%eax
  801945:	c1 e0 02             	shl    $0x2,%eax
  801948:	01 d0                	add    %edx,%eax
  80194a:	01 c0                	add    %eax,%eax
  80194c:	29 c1                	sub    %eax,%ecx
  80194e:	89 ca                	mov    %ecx,%edx
  801950:	85 d2                	test   %edx,%edx
  801952:	75 9c                	jne    8018f0 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801954:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80195b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80195e:	48                   	dec    %eax
  80195f:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801962:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801966:	74 3d                	je     8019a5 <ltostr+0xe2>
		start = 1 ;
  801968:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  80196f:	eb 34                	jmp    8019a5 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801971:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801974:	8b 45 0c             	mov    0xc(%ebp),%eax
  801977:	01 d0                	add    %edx,%eax
  801979:	8a 00                	mov    (%eax),%al
  80197b:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  80197e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801981:	8b 45 0c             	mov    0xc(%ebp),%eax
  801984:	01 c2                	add    %eax,%edx
  801986:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801989:	8b 45 0c             	mov    0xc(%ebp),%eax
  80198c:	01 c8                	add    %ecx,%eax
  80198e:	8a 00                	mov    (%eax),%al
  801990:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801992:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801995:	8b 45 0c             	mov    0xc(%ebp),%eax
  801998:	01 c2                	add    %eax,%edx
  80199a:	8a 45 eb             	mov    -0x15(%ebp),%al
  80199d:	88 02                	mov    %al,(%edx)
		start++ ;
  80199f:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8019a2:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8019a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019a8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8019ab:	7c c4                	jl     801971 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8019ad:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8019b0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019b3:	01 d0                	add    %edx,%eax
  8019b5:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8019b8:	90                   	nop
  8019b9:	c9                   	leave  
  8019ba:	c3                   	ret    

008019bb <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8019bb:	55                   	push   %ebp
  8019bc:	89 e5                	mov    %esp,%ebp
  8019be:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8019c1:	ff 75 08             	pushl  0x8(%ebp)
  8019c4:	e8 54 fa ff ff       	call   80141d <strlen>
  8019c9:	83 c4 04             	add    $0x4,%esp
  8019cc:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8019cf:	ff 75 0c             	pushl  0xc(%ebp)
  8019d2:	e8 46 fa ff ff       	call   80141d <strlen>
  8019d7:	83 c4 04             	add    $0x4,%esp
  8019da:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8019dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8019e4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8019eb:	eb 17                	jmp    801a04 <strcconcat+0x49>
		final[s] = str1[s] ;
  8019ed:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8019f0:	8b 45 10             	mov    0x10(%ebp),%eax
  8019f3:	01 c2                	add    %eax,%edx
  8019f5:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8019f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8019fb:	01 c8                	add    %ecx,%eax
  8019fd:	8a 00                	mov    (%eax),%al
  8019ff:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a01:	ff 45 fc             	incl   -0x4(%ebp)
  801a04:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a07:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a0a:	7c e1                	jl     8019ed <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a0c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a13:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a1a:	eb 1f                	jmp    801a3b <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a1c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a1f:	8d 50 01             	lea    0x1(%eax),%edx
  801a22:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a25:	89 c2                	mov    %eax,%edx
  801a27:	8b 45 10             	mov    0x10(%ebp),%eax
  801a2a:	01 c2                	add    %eax,%edx
  801a2c:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a2f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a32:	01 c8                	add    %ecx,%eax
  801a34:	8a 00                	mov    (%eax),%al
  801a36:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a38:	ff 45 f8             	incl   -0x8(%ebp)
  801a3b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801a3e:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a41:	7c d9                	jl     801a1c <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801a43:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a46:	8b 45 10             	mov    0x10(%ebp),%eax
  801a49:	01 d0                	add    %edx,%eax
  801a4b:	c6 00 00             	movb   $0x0,(%eax)
}
  801a4e:	90                   	nop
  801a4f:	c9                   	leave  
  801a50:	c3                   	ret    

00801a51 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801a51:	55                   	push   %ebp
  801a52:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801a54:	8b 45 14             	mov    0x14(%ebp),%eax
  801a57:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801a5d:	8b 45 14             	mov    0x14(%ebp),%eax
  801a60:	8b 00                	mov    (%eax),%eax
  801a62:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801a69:	8b 45 10             	mov    0x10(%ebp),%eax
  801a6c:	01 d0                	add    %edx,%eax
  801a6e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a74:	eb 0c                	jmp    801a82 <strsplit+0x31>
			*string++ = 0;
  801a76:	8b 45 08             	mov    0x8(%ebp),%eax
  801a79:	8d 50 01             	lea    0x1(%eax),%edx
  801a7c:	89 55 08             	mov    %edx,0x8(%ebp)
  801a7f:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801a82:	8b 45 08             	mov    0x8(%ebp),%eax
  801a85:	8a 00                	mov    (%eax),%al
  801a87:	84 c0                	test   %al,%al
  801a89:	74 18                	je     801aa3 <strsplit+0x52>
  801a8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8e:	8a 00                	mov    (%eax),%al
  801a90:	0f be c0             	movsbl %al,%eax
  801a93:	50                   	push   %eax
  801a94:	ff 75 0c             	pushl  0xc(%ebp)
  801a97:	e8 13 fb ff ff       	call   8015af <strchr>
  801a9c:	83 c4 08             	add    $0x8,%esp
  801a9f:	85 c0                	test   %eax,%eax
  801aa1:	75 d3                	jne    801a76 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801aa3:	8b 45 08             	mov    0x8(%ebp),%eax
  801aa6:	8a 00                	mov    (%eax),%al
  801aa8:	84 c0                	test   %al,%al
  801aaa:	74 5a                	je     801b06 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801aac:	8b 45 14             	mov    0x14(%ebp),%eax
  801aaf:	8b 00                	mov    (%eax),%eax
  801ab1:	83 f8 0f             	cmp    $0xf,%eax
  801ab4:	75 07                	jne    801abd <strsplit+0x6c>
		{
			return 0;
  801ab6:	b8 00 00 00 00       	mov    $0x0,%eax
  801abb:	eb 66                	jmp    801b23 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801abd:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac0:	8b 00                	mov    (%eax),%eax
  801ac2:	8d 48 01             	lea    0x1(%eax),%ecx
  801ac5:	8b 55 14             	mov    0x14(%ebp),%edx
  801ac8:	89 0a                	mov    %ecx,(%edx)
  801aca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ad1:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad4:	01 c2                	add    %eax,%edx
  801ad6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad9:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801adb:	eb 03                	jmp    801ae0 <strsplit+0x8f>
			string++;
  801add:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801ae0:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae3:	8a 00                	mov    (%eax),%al
  801ae5:	84 c0                	test   %al,%al
  801ae7:	74 8b                	je     801a74 <strsplit+0x23>
  801ae9:	8b 45 08             	mov    0x8(%ebp),%eax
  801aec:	8a 00                	mov    (%eax),%al
  801aee:	0f be c0             	movsbl %al,%eax
  801af1:	50                   	push   %eax
  801af2:	ff 75 0c             	pushl  0xc(%ebp)
  801af5:	e8 b5 fa ff ff       	call   8015af <strchr>
  801afa:	83 c4 08             	add    $0x8,%esp
  801afd:	85 c0                	test   %eax,%eax
  801aff:	74 dc                	je     801add <strsplit+0x8c>
			string++;
	}
  801b01:	e9 6e ff ff ff       	jmp    801a74 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b06:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b07:	8b 45 14             	mov    0x14(%ebp),%eax
  801b0a:	8b 00                	mov    (%eax),%eax
  801b0c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b13:	8b 45 10             	mov    0x10(%ebp),%eax
  801b16:	01 d0                	add    %edx,%eax
  801b18:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b1e:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b23:	c9                   	leave  
  801b24:	c3                   	ret    

00801b25 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801b25:	55                   	push   %ebp
  801b26:	89 e5                	mov    %esp,%ebp
  801b28:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801b2b:	83 ec 04             	sub    $0x4,%esp
  801b2e:	68 64 2c 80 00       	push   $0x802c64
  801b33:	6a 15                	push   $0x15
  801b35:	68 89 2c 80 00       	push   $0x802c89
  801b3a:	e8 a2 ed ff ff       	call   8008e1 <_panic>

00801b3f <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801b3f:	55                   	push   %ebp
  801b40:	89 e5                	mov    %esp,%ebp
  801b42:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801b45:	83 ec 04             	sub    $0x4,%esp
  801b48:	68 98 2c 80 00       	push   $0x802c98
  801b4d:	6a 2e                	push   $0x2e
  801b4f:	68 89 2c 80 00       	push   $0x802c89
  801b54:	e8 88 ed ff ff       	call   8008e1 <_panic>

00801b59 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801b59:	55                   	push   %ebp
  801b5a:	89 e5                	mov    %esp,%ebp
  801b5c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b5f:	83 ec 04             	sub    $0x4,%esp
  801b62:	68 bc 2c 80 00       	push   $0x802cbc
  801b67:	6a 4c                	push   $0x4c
  801b69:	68 89 2c 80 00       	push   $0x802c89
  801b6e:	e8 6e ed ff ff       	call   8008e1 <_panic>

00801b73 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801b73:	55                   	push   %ebp
  801b74:	89 e5                	mov    %esp,%ebp
  801b76:	83 ec 18             	sub    $0x18,%esp
  801b79:	8b 45 10             	mov    0x10(%ebp),%eax
  801b7c:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801b7f:	83 ec 04             	sub    $0x4,%esp
  801b82:	68 bc 2c 80 00       	push   $0x802cbc
  801b87:	6a 57                	push   $0x57
  801b89:	68 89 2c 80 00       	push   $0x802c89
  801b8e:	e8 4e ed ff ff       	call   8008e1 <_panic>

00801b93 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801b93:	55                   	push   %ebp
  801b94:	89 e5                	mov    %esp,%ebp
  801b96:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801b99:	83 ec 04             	sub    $0x4,%esp
  801b9c:	68 bc 2c 80 00       	push   $0x802cbc
  801ba1:	6a 5d                	push   $0x5d
  801ba3:	68 89 2c 80 00       	push   $0x802c89
  801ba8:	e8 34 ed ff ff       	call   8008e1 <_panic>

00801bad <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801bad:	55                   	push   %ebp
  801bae:	89 e5                	mov    %esp,%ebp
  801bb0:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bb3:	83 ec 04             	sub    $0x4,%esp
  801bb6:	68 bc 2c 80 00       	push   $0x802cbc
  801bbb:	6a 63                	push   $0x63
  801bbd:	68 89 2c 80 00       	push   $0x802c89
  801bc2:	e8 1a ed ff ff       	call   8008e1 <_panic>

00801bc7 <expand>:
}

void expand(uint32 newSize)
{
  801bc7:	55                   	push   %ebp
  801bc8:	89 e5                	mov    %esp,%ebp
  801bca:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bcd:	83 ec 04             	sub    $0x4,%esp
  801bd0:	68 bc 2c 80 00       	push   $0x802cbc
  801bd5:	6a 68                	push   $0x68
  801bd7:	68 89 2c 80 00       	push   $0x802c89
  801bdc:	e8 00 ed ff ff       	call   8008e1 <_panic>

00801be1 <shrink>:
}
void shrink(uint32 newSize)
{
  801be1:	55                   	push   %ebp
  801be2:	89 e5                	mov    %esp,%ebp
  801be4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801be7:	83 ec 04             	sub    $0x4,%esp
  801bea:	68 bc 2c 80 00       	push   $0x802cbc
  801bef:	6a 6c                	push   $0x6c
  801bf1:	68 89 2c 80 00       	push   $0x802c89
  801bf6:	e8 e6 ec ff ff       	call   8008e1 <_panic>

00801bfb <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
  801bfe:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c01:	83 ec 04             	sub    $0x4,%esp
  801c04:	68 bc 2c 80 00       	push   $0x802cbc
  801c09:	6a 71                	push   $0x71
  801c0b:	68 89 2c 80 00       	push   $0x802c89
  801c10:	e8 cc ec ff ff       	call   8008e1 <_panic>

00801c15 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801c15:	55                   	push   %ebp
  801c16:	89 e5                	mov    %esp,%ebp
  801c18:	57                   	push   %edi
  801c19:	56                   	push   %esi
  801c1a:	53                   	push   %ebx
  801c1b:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801c1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801c21:	8b 55 0c             	mov    0xc(%ebp),%edx
  801c24:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801c27:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801c2a:	8b 7d 18             	mov    0x18(%ebp),%edi
  801c2d:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801c30:	cd 30                	int    $0x30
  801c32:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801c35:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801c38:	83 c4 10             	add    $0x10,%esp
  801c3b:	5b                   	pop    %ebx
  801c3c:	5e                   	pop    %esi
  801c3d:	5f                   	pop    %edi
  801c3e:	5d                   	pop    %ebp
  801c3f:	c3                   	ret    

00801c40 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801c40:	55                   	push   %ebp
  801c41:	89 e5                	mov    %esp,%ebp
  801c43:	83 ec 04             	sub    $0x4,%esp
  801c46:	8b 45 10             	mov    0x10(%ebp),%eax
  801c49:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801c4c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801c50:	8b 45 08             	mov    0x8(%ebp),%eax
  801c53:	6a 00                	push   $0x0
  801c55:	6a 00                	push   $0x0
  801c57:	52                   	push   %edx
  801c58:	ff 75 0c             	pushl  0xc(%ebp)
  801c5b:	50                   	push   %eax
  801c5c:	6a 00                	push   $0x0
  801c5e:	e8 b2 ff ff ff       	call   801c15 <syscall>
  801c63:	83 c4 18             	add    $0x18,%esp
}
  801c66:	90                   	nop
  801c67:	c9                   	leave  
  801c68:	c3                   	ret    

00801c69 <sys_cgetc>:

int
sys_cgetc(void)
{
  801c69:	55                   	push   %ebp
  801c6a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801c6c:	6a 00                	push   $0x0
  801c6e:	6a 00                	push   $0x0
  801c70:	6a 00                	push   $0x0
  801c72:	6a 00                	push   $0x0
  801c74:	6a 00                	push   $0x0
  801c76:	6a 01                	push   $0x1
  801c78:	e8 98 ff ff ff       	call   801c15 <syscall>
  801c7d:	83 c4 18             	add    $0x18,%esp
}
  801c80:	c9                   	leave  
  801c81:	c3                   	ret    

00801c82 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801c82:	55                   	push   %ebp
  801c83:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801c85:	8b 45 08             	mov    0x8(%ebp),%eax
  801c88:	6a 00                	push   $0x0
  801c8a:	6a 00                	push   $0x0
  801c8c:	6a 00                	push   $0x0
  801c8e:	6a 00                	push   $0x0
  801c90:	50                   	push   %eax
  801c91:	6a 05                	push   $0x5
  801c93:	e8 7d ff ff ff       	call   801c15 <syscall>
  801c98:	83 c4 18             	add    $0x18,%esp
}
  801c9b:	c9                   	leave  
  801c9c:	c3                   	ret    

00801c9d <sys_getenvid>:

int32 sys_getenvid(void)
{
  801c9d:	55                   	push   %ebp
  801c9e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801ca0:	6a 00                	push   $0x0
  801ca2:	6a 00                	push   $0x0
  801ca4:	6a 00                	push   $0x0
  801ca6:	6a 00                	push   $0x0
  801ca8:	6a 00                	push   $0x0
  801caa:	6a 02                	push   $0x2
  801cac:	e8 64 ff ff ff       	call   801c15 <syscall>
  801cb1:	83 c4 18             	add    $0x18,%esp
}
  801cb4:	c9                   	leave  
  801cb5:	c3                   	ret    

00801cb6 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801cb6:	55                   	push   %ebp
  801cb7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801cb9:	6a 00                	push   $0x0
  801cbb:	6a 00                	push   $0x0
  801cbd:	6a 00                	push   $0x0
  801cbf:	6a 00                	push   $0x0
  801cc1:	6a 00                	push   $0x0
  801cc3:	6a 03                	push   $0x3
  801cc5:	e8 4b ff ff ff       	call   801c15 <syscall>
  801cca:	83 c4 18             	add    $0x18,%esp
}
  801ccd:	c9                   	leave  
  801cce:	c3                   	ret    

00801ccf <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801ccf:	55                   	push   %ebp
  801cd0:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801cd2:	6a 00                	push   $0x0
  801cd4:	6a 00                	push   $0x0
  801cd6:	6a 00                	push   $0x0
  801cd8:	6a 00                	push   $0x0
  801cda:	6a 00                	push   $0x0
  801cdc:	6a 04                	push   $0x4
  801cde:	e8 32 ff ff ff       	call   801c15 <syscall>
  801ce3:	83 c4 18             	add    $0x18,%esp
}
  801ce6:	c9                   	leave  
  801ce7:	c3                   	ret    

00801ce8 <sys_env_exit>:


void sys_env_exit(void)
{
  801ce8:	55                   	push   %ebp
  801ce9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801ceb:	6a 00                	push   $0x0
  801ced:	6a 00                	push   $0x0
  801cef:	6a 00                	push   $0x0
  801cf1:	6a 00                	push   $0x0
  801cf3:	6a 00                	push   $0x0
  801cf5:	6a 06                	push   $0x6
  801cf7:	e8 19 ff ff ff       	call   801c15 <syscall>
  801cfc:	83 c4 18             	add    $0x18,%esp
}
  801cff:	90                   	nop
  801d00:	c9                   	leave  
  801d01:	c3                   	ret    

00801d02 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d02:	55                   	push   %ebp
  801d03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d05:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d08:	8b 45 08             	mov    0x8(%ebp),%eax
  801d0b:	6a 00                	push   $0x0
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	52                   	push   %edx
  801d12:	50                   	push   %eax
  801d13:	6a 07                	push   $0x7
  801d15:	e8 fb fe ff ff       	call   801c15 <syscall>
  801d1a:	83 c4 18             	add    $0x18,%esp
}
  801d1d:	c9                   	leave  
  801d1e:	c3                   	ret    

00801d1f <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801d1f:	55                   	push   %ebp
  801d20:	89 e5                	mov    %esp,%ebp
  801d22:	56                   	push   %esi
  801d23:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801d24:	8b 75 18             	mov    0x18(%ebp),%esi
  801d27:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d2a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d2d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d30:	8b 45 08             	mov    0x8(%ebp),%eax
  801d33:	56                   	push   %esi
  801d34:	53                   	push   %ebx
  801d35:	51                   	push   %ecx
  801d36:	52                   	push   %edx
  801d37:	50                   	push   %eax
  801d38:	6a 08                	push   $0x8
  801d3a:	e8 d6 fe ff ff       	call   801c15 <syscall>
  801d3f:	83 c4 18             	add    $0x18,%esp
}
  801d42:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801d45:	5b                   	pop    %ebx
  801d46:	5e                   	pop    %esi
  801d47:	5d                   	pop    %ebp
  801d48:	c3                   	ret    

00801d49 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801d49:	55                   	push   %ebp
  801d4a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801d4c:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d4f:	8b 45 08             	mov    0x8(%ebp),%eax
  801d52:	6a 00                	push   $0x0
  801d54:	6a 00                	push   $0x0
  801d56:	6a 00                	push   $0x0
  801d58:	52                   	push   %edx
  801d59:	50                   	push   %eax
  801d5a:	6a 09                	push   $0x9
  801d5c:	e8 b4 fe ff ff       	call   801c15 <syscall>
  801d61:	83 c4 18             	add    $0x18,%esp
}
  801d64:	c9                   	leave  
  801d65:	c3                   	ret    

00801d66 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801d66:	55                   	push   %ebp
  801d67:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 00                	push   $0x0
  801d6f:	ff 75 0c             	pushl  0xc(%ebp)
  801d72:	ff 75 08             	pushl  0x8(%ebp)
  801d75:	6a 0a                	push   $0xa
  801d77:	e8 99 fe ff ff       	call   801c15 <syscall>
  801d7c:	83 c4 18             	add    $0x18,%esp
}
  801d7f:	c9                   	leave  
  801d80:	c3                   	ret    

00801d81 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801d81:	55                   	push   %ebp
  801d82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801d84:	6a 00                	push   $0x0
  801d86:	6a 00                	push   $0x0
  801d88:	6a 00                	push   $0x0
  801d8a:	6a 00                	push   $0x0
  801d8c:	6a 00                	push   $0x0
  801d8e:	6a 0b                	push   $0xb
  801d90:	e8 80 fe ff ff       	call   801c15 <syscall>
  801d95:	83 c4 18             	add    $0x18,%esp
}
  801d98:	c9                   	leave  
  801d99:	c3                   	ret    

00801d9a <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801d9a:	55                   	push   %ebp
  801d9b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801d9d:	6a 00                	push   $0x0
  801d9f:	6a 00                	push   $0x0
  801da1:	6a 00                	push   $0x0
  801da3:	6a 00                	push   $0x0
  801da5:	6a 00                	push   $0x0
  801da7:	6a 0c                	push   $0xc
  801da9:	e8 67 fe ff ff       	call   801c15 <syscall>
  801dae:	83 c4 18             	add    $0x18,%esp
}
  801db1:	c9                   	leave  
  801db2:	c3                   	ret    

00801db3 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801db3:	55                   	push   %ebp
  801db4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801db6:	6a 00                	push   $0x0
  801db8:	6a 00                	push   $0x0
  801dba:	6a 00                	push   $0x0
  801dbc:	6a 00                	push   $0x0
  801dbe:	6a 00                	push   $0x0
  801dc0:	6a 0d                	push   $0xd
  801dc2:	e8 4e fe ff ff       	call   801c15 <syscall>
  801dc7:	83 c4 18             	add    $0x18,%esp
}
  801dca:	c9                   	leave  
  801dcb:	c3                   	ret    

00801dcc <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801dcc:	55                   	push   %ebp
  801dcd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801dcf:	6a 00                	push   $0x0
  801dd1:	6a 00                	push   $0x0
  801dd3:	6a 00                	push   $0x0
  801dd5:	ff 75 0c             	pushl  0xc(%ebp)
  801dd8:	ff 75 08             	pushl  0x8(%ebp)
  801ddb:	6a 11                	push   $0x11
  801ddd:	e8 33 fe ff ff       	call   801c15 <syscall>
  801de2:	83 c4 18             	add    $0x18,%esp
	return;
  801de5:	90                   	nop
}
  801de6:	c9                   	leave  
  801de7:	c3                   	ret    

00801de8 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801de8:	55                   	push   %ebp
  801de9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801deb:	6a 00                	push   $0x0
  801ded:	6a 00                	push   $0x0
  801def:	6a 00                	push   $0x0
  801df1:	ff 75 0c             	pushl  0xc(%ebp)
  801df4:	ff 75 08             	pushl  0x8(%ebp)
  801df7:	6a 12                	push   $0x12
  801df9:	e8 17 fe ff ff       	call   801c15 <syscall>
  801dfe:	83 c4 18             	add    $0x18,%esp
	return ;
  801e01:	90                   	nop
}
  801e02:	c9                   	leave  
  801e03:	c3                   	ret    

00801e04 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e04:	55                   	push   %ebp
  801e05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e07:	6a 00                	push   $0x0
  801e09:	6a 00                	push   $0x0
  801e0b:	6a 00                	push   $0x0
  801e0d:	6a 00                	push   $0x0
  801e0f:	6a 00                	push   $0x0
  801e11:	6a 0e                	push   $0xe
  801e13:	e8 fd fd ff ff       	call   801c15 <syscall>
  801e18:	83 c4 18             	add    $0x18,%esp
}
  801e1b:	c9                   	leave  
  801e1c:	c3                   	ret    

00801e1d <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801e1d:	55                   	push   %ebp
  801e1e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801e20:	6a 00                	push   $0x0
  801e22:	6a 00                	push   $0x0
  801e24:	6a 00                	push   $0x0
  801e26:	6a 00                	push   $0x0
  801e28:	ff 75 08             	pushl  0x8(%ebp)
  801e2b:	6a 0f                	push   $0xf
  801e2d:	e8 e3 fd ff ff       	call   801c15 <syscall>
  801e32:	83 c4 18             	add    $0x18,%esp
}
  801e35:	c9                   	leave  
  801e36:	c3                   	ret    

00801e37 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801e37:	55                   	push   %ebp
  801e38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801e3a:	6a 00                	push   $0x0
  801e3c:	6a 00                	push   $0x0
  801e3e:	6a 00                	push   $0x0
  801e40:	6a 00                	push   $0x0
  801e42:	6a 00                	push   $0x0
  801e44:	6a 10                	push   $0x10
  801e46:	e8 ca fd ff ff       	call   801c15 <syscall>
  801e4b:	83 c4 18             	add    $0x18,%esp
}
  801e4e:	90                   	nop
  801e4f:	c9                   	leave  
  801e50:	c3                   	ret    

00801e51 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801e51:	55                   	push   %ebp
  801e52:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801e54:	6a 00                	push   $0x0
  801e56:	6a 00                	push   $0x0
  801e58:	6a 00                	push   $0x0
  801e5a:	6a 00                	push   $0x0
  801e5c:	6a 00                	push   $0x0
  801e5e:	6a 14                	push   $0x14
  801e60:	e8 b0 fd ff ff       	call   801c15 <syscall>
  801e65:	83 c4 18             	add    $0x18,%esp
}
  801e68:	90                   	nop
  801e69:	c9                   	leave  
  801e6a:	c3                   	ret    

00801e6b <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801e6b:	55                   	push   %ebp
  801e6c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801e6e:	6a 00                	push   $0x0
  801e70:	6a 00                	push   $0x0
  801e72:	6a 00                	push   $0x0
  801e74:	6a 00                	push   $0x0
  801e76:	6a 00                	push   $0x0
  801e78:	6a 15                	push   $0x15
  801e7a:	e8 96 fd ff ff       	call   801c15 <syscall>
  801e7f:	83 c4 18             	add    $0x18,%esp
}
  801e82:	90                   	nop
  801e83:	c9                   	leave  
  801e84:	c3                   	ret    

00801e85 <sys_cputc>:


void
sys_cputc(const char c)
{
  801e85:	55                   	push   %ebp
  801e86:	89 e5                	mov    %esp,%ebp
  801e88:	83 ec 04             	sub    $0x4,%esp
  801e8b:	8b 45 08             	mov    0x8(%ebp),%eax
  801e8e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801e91:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801e95:	6a 00                	push   $0x0
  801e97:	6a 00                	push   $0x0
  801e99:	6a 00                	push   $0x0
  801e9b:	6a 00                	push   $0x0
  801e9d:	50                   	push   %eax
  801e9e:	6a 16                	push   $0x16
  801ea0:	e8 70 fd ff ff       	call   801c15 <syscall>
  801ea5:	83 c4 18             	add    $0x18,%esp
}
  801ea8:	90                   	nop
  801ea9:	c9                   	leave  
  801eaa:	c3                   	ret    

00801eab <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801eab:	55                   	push   %ebp
  801eac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801eae:	6a 00                	push   $0x0
  801eb0:	6a 00                	push   $0x0
  801eb2:	6a 00                	push   $0x0
  801eb4:	6a 00                	push   $0x0
  801eb6:	6a 00                	push   $0x0
  801eb8:	6a 17                	push   $0x17
  801eba:	e8 56 fd ff ff       	call   801c15 <syscall>
  801ebf:	83 c4 18             	add    $0x18,%esp
}
  801ec2:	90                   	nop
  801ec3:	c9                   	leave  
  801ec4:	c3                   	ret    

00801ec5 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801ec5:	55                   	push   %ebp
  801ec6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801ec8:	8b 45 08             	mov    0x8(%ebp),%eax
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	ff 75 0c             	pushl  0xc(%ebp)
  801ed4:	50                   	push   %eax
  801ed5:	6a 18                	push   $0x18
  801ed7:	e8 39 fd ff ff       	call   801c15 <syscall>
  801edc:	83 c4 18             	add    $0x18,%esp
}
  801edf:	c9                   	leave  
  801ee0:	c3                   	ret    

00801ee1 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801ee1:	55                   	push   %ebp
  801ee2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801ee4:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ee7:	8b 45 08             	mov    0x8(%ebp),%eax
  801eea:	6a 00                	push   $0x0
  801eec:	6a 00                	push   $0x0
  801eee:	6a 00                	push   $0x0
  801ef0:	52                   	push   %edx
  801ef1:	50                   	push   %eax
  801ef2:	6a 1b                	push   $0x1b
  801ef4:	e8 1c fd ff ff       	call   801c15 <syscall>
  801ef9:	83 c4 18             	add    $0x18,%esp
}
  801efc:	c9                   	leave  
  801efd:	c3                   	ret    

00801efe <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801efe:	55                   	push   %ebp
  801eff:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f01:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f04:	8b 45 08             	mov    0x8(%ebp),%eax
  801f07:	6a 00                	push   $0x0
  801f09:	6a 00                	push   $0x0
  801f0b:	6a 00                	push   $0x0
  801f0d:	52                   	push   %edx
  801f0e:	50                   	push   %eax
  801f0f:	6a 19                	push   $0x19
  801f11:	e8 ff fc ff ff       	call   801c15 <syscall>
  801f16:	83 c4 18             	add    $0x18,%esp
}
  801f19:	90                   	nop
  801f1a:	c9                   	leave  
  801f1b:	c3                   	ret    

00801f1c <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f1c:	55                   	push   %ebp
  801f1d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f22:	8b 45 08             	mov    0x8(%ebp),%eax
  801f25:	6a 00                	push   $0x0
  801f27:	6a 00                	push   $0x0
  801f29:	6a 00                	push   $0x0
  801f2b:	52                   	push   %edx
  801f2c:	50                   	push   %eax
  801f2d:	6a 1a                	push   $0x1a
  801f2f:	e8 e1 fc ff ff       	call   801c15 <syscall>
  801f34:	83 c4 18             	add    $0x18,%esp
}
  801f37:	90                   	nop
  801f38:	c9                   	leave  
  801f39:	c3                   	ret    

00801f3a <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801f3a:	55                   	push   %ebp
  801f3b:	89 e5                	mov    %esp,%ebp
  801f3d:	83 ec 04             	sub    $0x4,%esp
  801f40:	8b 45 10             	mov    0x10(%ebp),%eax
  801f43:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801f46:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801f49:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801f4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801f50:	6a 00                	push   $0x0
  801f52:	51                   	push   %ecx
  801f53:	52                   	push   %edx
  801f54:	ff 75 0c             	pushl  0xc(%ebp)
  801f57:	50                   	push   %eax
  801f58:	6a 1c                	push   $0x1c
  801f5a:	e8 b6 fc ff ff       	call   801c15 <syscall>
  801f5f:	83 c4 18             	add    $0x18,%esp
}
  801f62:	c9                   	leave  
  801f63:	c3                   	ret    

00801f64 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801f64:	55                   	push   %ebp
  801f65:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801f67:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f6a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f6d:	6a 00                	push   $0x0
  801f6f:	6a 00                	push   $0x0
  801f71:	6a 00                	push   $0x0
  801f73:	52                   	push   %edx
  801f74:	50                   	push   %eax
  801f75:	6a 1d                	push   $0x1d
  801f77:	e8 99 fc ff ff       	call   801c15 <syscall>
  801f7c:	83 c4 18             	add    $0x18,%esp
}
  801f7f:	c9                   	leave  
  801f80:	c3                   	ret    

00801f81 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801f81:	55                   	push   %ebp
  801f82:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801f84:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801f87:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f8a:	8b 45 08             	mov    0x8(%ebp),%eax
  801f8d:	6a 00                	push   $0x0
  801f8f:	6a 00                	push   $0x0
  801f91:	51                   	push   %ecx
  801f92:	52                   	push   %edx
  801f93:	50                   	push   %eax
  801f94:	6a 1e                	push   $0x1e
  801f96:	e8 7a fc ff ff       	call   801c15 <syscall>
  801f9b:	83 c4 18             	add    $0x18,%esp
}
  801f9e:	c9                   	leave  
  801f9f:	c3                   	ret    

00801fa0 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801fa0:	55                   	push   %ebp
  801fa1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801fa3:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fa6:	8b 45 08             	mov    0x8(%ebp),%eax
  801fa9:	6a 00                	push   $0x0
  801fab:	6a 00                	push   $0x0
  801fad:	6a 00                	push   $0x0
  801faf:	52                   	push   %edx
  801fb0:	50                   	push   %eax
  801fb1:	6a 1f                	push   $0x1f
  801fb3:	e8 5d fc ff ff       	call   801c15 <syscall>
  801fb8:	83 c4 18             	add    $0x18,%esp
}
  801fbb:	c9                   	leave  
  801fbc:	c3                   	ret    

00801fbd <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801fbd:	55                   	push   %ebp
  801fbe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801fc0:	6a 00                	push   $0x0
  801fc2:	6a 00                	push   $0x0
  801fc4:	6a 00                	push   $0x0
  801fc6:	6a 00                	push   $0x0
  801fc8:	6a 00                	push   $0x0
  801fca:	6a 20                	push   $0x20
  801fcc:	e8 44 fc ff ff       	call   801c15 <syscall>
  801fd1:	83 c4 18             	add    $0x18,%esp
}
  801fd4:	c9                   	leave  
  801fd5:	c3                   	ret    

00801fd6 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801fd6:	55                   	push   %ebp
  801fd7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801fd9:	8b 45 08             	mov    0x8(%ebp),%eax
  801fdc:	6a 00                	push   $0x0
  801fde:	ff 75 14             	pushl  0x14(%ebp)
  801fe1:	ff 75 10             	pushl  0x10(%ebp)
  801fe4:	ff 75 0c             	pushl  0xc(%ebp)
  801fe7:	50                   	push   %eax
  801fe8:	6a 21                	push   $0x21
  801fea:	e8 26 fc ff ff       	call   801c15 <syscall>
  801fef:	83 c4 18             	add    $0x18,%esp
}
  801ff2:	c9                   	leave  
  801ff3:	c3                   	ret    

00801ff4 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801ff4:	55                   	push   %ebp
  801ff5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801ff7:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffa:	6a 00                	push   $0x0
  801ffc:	6a 00                	push   $0x0
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	50                   	push   %eax
  802003:	6a 22                	push   $0x22
  802005:	e8 0b fc ff ff       	call   801c15 <syscall>
  80200a:	83 c4 18             	add    $0x18,%esp
}
  80200d:	90                   	nop
  80200e:	c9                   	leave  
  80200f:	c3                   	ret    

00802010 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802010:	55                   	push   %ebp
  802011:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802013:	8b 45 08             	mov    0x8(%ebp),%eax
  802016:	6a 00                	push   $0x0
  802018:	6a 00                	push   $0x0
  80201a:	6a 00                	push   $0x0
  80201c:	6a 00                	push   $0x0
  80201e:	50                   	push   %eax
  80201f:	6a 23                	push   $0x23
  802021:	e8 ef fb ff ff       	call   801c15 <syscall>
  802026:	83 c4 18             	add    $0x18,%esp
}
  802029:	90                   	nop
  80202a:	c9                   	leave  
  80202b:	c3                   	ret    

0080202c <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80202c:	55                   	push   %ebp
  80202d:	89 e5                	mov    %esp,%ebp
  80202f:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802032:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802035:	8d 50 04             	lea    0x4(%eax),%edx
  802038:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80203b:	6a 00                	push   $0x0
  80203d:	6a 00                	push   $0x0
  80203f:	6a 00                	push   $0x0
  802041:	52                   	push   %edx
  802042:	50                   	push   %eax
  802043:	6a 24                	push   $0x24
  802045:	e8 cb fb ff ff       	call   801c15 <syscall>
  80204a:	83 c4 18             	add    $0x18,%esp
	return result;
  80204d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802050:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802053:	8b 55 fc             	mov    -0x4(%ebp),%edx
  802056:	89 01                	mov    %eax,(%ecx)
  802058:	89 51 04             	mov    %edx,0x4(%ecx)
}
  80205b:	8b 45 08             	mov    0x8(%ebp),%eax
  80205e:	c9                   	leave  
  80205f:	c2 04 00             	ret    $0x4

00802062 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802062:	55                   	push   %ebp
  802063:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  802065:	6a 00                	push   $0x0
  802067:	6a 00                	push   $0x0
  802069:	ff 75 10             	pushl  0x10(%ebp)
  80206c:	ff 75 0c             	pushl  0xc(%ebp)
  80206f:	ff 75 08             	pushl  0x8(%ebp)
  802072:	6a 13                	push   $0x13
  802074:	e8 9c fb ff ff       	call   801c15 <syscall>
  802079:	83 c4 18             	add    $0x18,%esp
	return ;
  80207c:	90                   	nop
}
  80207d:	c9                   	leave  
  80207e:	c3                   	ret    

0080207f <sys_rcr2>:
uint32 sys_rcr2()
{
  80207f:	55                   	push   %ebp
  802080:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802082:	6a 00                	push   $0x0
  802084:	6a 00                	push   $0x0
  802086:	6a 00                	push   $0x0
  802088:	6a 00                	push   $0x0
  80208a:	6a 00                	push   $0x0
  80208c:	6a 25                	push   $0x25
  80208e:	e8 82 fb ff ff       	call   801c15 <syscall>
  802093:	83 c4 18             	add    $0x18,%esp
}
  802096:	c9                   	leave  
  802097:	c3                   	ret    

00802098 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802098:	55                   	push   %ebp
  802099:	89 e5                	mov    %esp,%ebp
  80209b:	83 ec 04             	sub    $0x4,%esp
  80209e:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8020a4:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8020a8:	6a 00                	push   $0x0
  8020aa:	6a 00                	push   $0x0
  8020ac:	6a 00                	push   $0x0
  8020ae:	6a 00                	push   $0x0
  8020b0:	50                   	push   %eax
  8020b1:	6a 26                	push   $0x26
  8020b3:	e8 5d fb ff ff       	call   801c15 <syscall>
  8020b8:	83 c4 18             	add    $0x18,%esp
	return ;
  8020bb:	90                   	nop
}
  8020bc:	c9                   	leave  
  8020bd:	c3                   	ret    

008020be <rsttst>:
void rsttst()
{
  8020be:	55                   	push   %ebp
  8020bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8020c1:	6a 00                	push   $0x0
  8020c3:	6a 00                	push   $0x0
  8020c5:	6a 00                	push   $0x0
  8020c7:	6a 00                	push   $0x0
  8020c9:	6a 00                	push   $0x0
  8020cb:	6a 28                	push   $0x28
  8020cd:	e8 43 fb ff ff       	call   801c15 <syscall>
  8020d2:	83 c4 18             	add    $0x18,%esp
	return ;
  8020d5:	90                   	nop
}
  8020d6:	c9                   	leave  
  8020d7:	c3                   	ret    

008020d8 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8020d8:	55                   	push   %ebp
  8020d9:	89 e5                	mov    %esp,%ebp
  8020db:	83 ec 04             	sub    $0x4,%esp
  8020de:	8b 45 14             	mov    0x14(%ebp),%eax
  8020e1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8020e4:	8b 55 18             	mov    0x18(%ebp),%edx
  8020e7:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8020eb:	52                   	push   %edx
  8020ec:	50                   	push   %eax
  8020ed:	ff 75 10             	pushl  0x10(%ebp)
  8020f0:	ff 75 0c             	pushl  0xc(%ebp)
  8020f3:	ff 75 08             	pushl  0x8(%ebp)
  8020f6:	6a 27                	push   $0x27
  8020f8:	e8 18 fb ff ff       	call   801c15 <syscall>
  8020fd:	83 c4 18             	add    $0x18,%esp
	return ;
  802100:	90                   	nop
}
  802101:	c9                   	leave  
  802102:	c3                   	ret    

00802103 <chktst>:
void chktst(uint32 n)
{
  802103:	55                   	push   %ebp
  802104:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802106:	6a 00                	push   $0x0
  802108:	6a 00                	push   $0x0
  80210a:	6a 00                	push   $0x0
  80210c:	6a 00                	push   $0x0
  80210e:	ff 75 08             	pushl  0x8(%ebp)
  802111:	6a 29                	push   $0x29
  802113:	e8 fd fa ff ff       	call   801c15 <syscall>
  802118:	83 c4 18             	add    $0x18,%esp
	return ;
  80211b:	90                   	nop
}
  80211c:	c9                   	leave  
  80211d:	c3                   	ret    

0080211e <inctst>:

void inctst()
{
  80211e:	55                   	push   %ebp
  80211f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	6a 00                	push   $0x0
  802129:	6a 00                	push   $0x0
  80212b:	6a 2a                	push   $0x2a
  80212d:	e8 e3 fa ff ff       	call   801c15 <syscall>
  802132:	83 c4 18             	add    $0x18,%esp
	return ;
  802135:	90                   	nop
}
  802136:	c9                   	leave  
  802137:	c3                   	ret    

00802138 <gettst>:
uint32 gettst()
{
  802138:	55                   	push   %ebp
  802139:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	6a 00                	push   $0x0
  802145:	6a 2b                	push   $0x2b
  802147:	e8 c9 fa ff ff       	call   801c15 <syscall>
  80214c:	83 c4 18             	add    $0x18,%esp
}
  80214f:	c9                   	leave  
  802150:	c3                   	ret    

00802151 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
  802154:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802157:	6a 00                	push   $0x0
  802159:	6a 00                	push   $0x0
  80215b:	6a 00                	push   $0x0
  80215d:	6a 00                	push   $0x0
  80215f:	6a 00                	push   $0x0
  802161:	6a 2c                	push   $0x2c
  802163:	e8 ad fa ff ff       	call   801c15 <syscall>
  802168:	83 c4 18             	add    $0x18,%esp
  80216b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  80216e:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802172:	75 07                	jne    80217b <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802174:	b8 01 00 00 00       	mov    $0x1,%eax
  802179:	eb 05                	jmp    802180 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80217b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802180:	c9                   	leave  
  802181:	c3                   	ret    

00802182 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802182:	55                   	push   %ebp
  802183:	89 e5                	mov    %esp,%ebp
  802185:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802188:	6a 00                	push   $0x0
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	6a 00                	push   $0x0
  802190:	6a 00                	push   $0x0
  802192:	6a 2c                	push   $0x2c
  802194:	e8 7c fa ff ff       	call   801c15 <syscall>
  802199:	83 c4 18             	add    $0x18,%esp
  80219c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80219f:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8021a3:	75 07                	jne    8021ac <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8021a5:	b8 01 00 00 00       	mov    $0x1,%eax
  8021aa:	eb 05                	jmp    8021b1 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8021ac:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021b1:	c9                   	leave  
  8021b2:	c3                   	ret    

008021b3 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8021b3:	55                   	push   %ebp
  8021b4:	89 e5                	mov    %esp,%ebp
  8021b6:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021b9:	6a 00                	push   $0x0
  8021bb:	6a 00                	push   $0x0
  8021bd:	6a 00                	push   $0x0
  8021bf:	6a 00                	push   $0x0
  8021c1:	6a 00                	push   $0x0
  8021c3:	6a 2c                	push   $0x2c
  8021c5:	e8 4b fa ff ff       	call   801c15 <syscall>
  8021ca:	83 c4 18             	add    $0x18,%esp
  8021cd:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8021d0:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8021d4:	75 07                	jne    8021dd <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8021d6:	b8 01 00 00 00       	mov    $0x1,%eax
  8021db:	eb 05                	jmp    8021e2 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  8021dd:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8021e2:	c9                   	leave  
  8021e3:	c3                   	ret    

008021e4 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  8021e4:	55                   	push   %ebp
  8021e5:	89 e5                	mov    %esp,%ebp
  8021e7:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021ea:	6a 00                	push   $0x0
  8021ec:	6a 00                	push   $0x0
  8021ee:	6a 00                	push   $0x0
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 00                	push   $0x0
  8021f4:	6a 2c                	push   $0x2c
  8021f6:	e8 1a fa ff ff       	call   801c15 <syscall>
  8021fb:	83 c4 18             	add    $0x18,%esp
  8021fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802201:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802205:	75 07                	jne    80220e <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802207:	b8 01 00 00 00       	mov    $0x1,%eax
  80220c:	eb 05                	jmp    802213 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80220e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802213:	c9                   	leave  
  802214:	c3                   	ret    

00802215 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  802215:	55                   	push   %ebp
  802216:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  802218:	6a 00                	push   $0x0
  80221a:	6a 00                	push   $0x0
  80221c:	6a 00                	push   $0x0
  80221e:	6a 00                	push   $0x0
  802220:	ff 75 08             	pushl  0x8(%ebp)
  802223:	6a 2d                	push   $0x2d
  802225:	e8 eb f9 ff ff       	call   801c15 <syscall>
  80222a:	83 c4 18             	add    $0x18,%esp
	return ;
  80222d:	90                   	nop
}
  80222e:	c9                   	leave  
  80222f:	c3                   	ret    

00802230 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802230:	55                   	push   %ebp
  802231:	89 e5                	mov    %esp,%ebp
  802233:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802234:	8b 5d 14             	mov    0x14(%ebp),%ebx
  802237:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80223a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80223d:	8b 45 08             	mov    0x8(%ebp),%eax
  802240:	6a 00                	push   $0x0
  802242:	53                   	push   %ebx
  802243:	51                   	push   %ecx
  802244:	52                   	push   %edx
  802245:	50                   	push   %eax
  802246:	6a 2e                	push   $0x2e
  802248:	e8 c8 f9 ff ff       	call   801c15 <syscall>
  80224d:	83 c4 18             	add    $0x18,%esp
}
  802250:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802253:	c9                   	leave  
  802254:	c3                   	ret    

00802255 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  802255:	55                   	push   %ebp
  802256:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  802258:	8b 55 0c             	mov    0xc(%ebp),%edx
  80225b:	8b 45 08             	mov    0x8(%ebp),%eax
  80225e:	6a 00                	push   $0x0
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	52                   	push   %edx
  802265:	50                   	push   %eax
  802266:	6a 2f                	push   $0x2f
  802268:	e8 a8 f9 ff ff       	call   801c15 <syscall>
  80226d:	83 c4 18             	add    $0x18,%esp
}
  802270:	c9                   	leave  
  802271:	c3                   	ret    

00802272 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802272:	55                   	push   %ebp
  802273:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802275:	6a 00                	push   $0x0
  802277:	6a 00                	push   $0x0
  802279:	6a 00                	push   $0x0
  80227b:	ff 75 0c             	pushl  0xc(%ebp)
  80227e:	ff 75 08             	pushl  0x8(%ebp)
  802281:	6a 30                	push   $0x30
  802283:	e8 8d f9 ff ff       	call   801c15 <syscall>
  802288:	83 c4 18             	add    $0x18,%esp
	return ;
  80228b:	90                   	nop
}
  80228c:	c9                   	leave  
  80228d:	c3                   	ret    
  80228e:	66 90                	xchg   %ax,%ax

00802290 <__udivdi3>:
  802290:	55                   	push   %ebp
  802291:	57                   	push   %edi
  802292:	56                   	push   %esi
  802293:	53                   	push   %ebx
  802294:	83 ec 1c             	sub    $0x1c,%esp
  802297:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80229b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80229f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8022a3:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8022a7:	89 ca                	mov    %ecx,%edx
  8022a9:	89 f8                	mov    %edi,%eax
  8022ab:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8022af:	85 f6                	test   %esi,%esi
  8022b1:	75 2d                	jne    8022e0 <__udivdi3+0x50>
  8022b3:	39 cf                	cmp    %ecx,%edi
  8022b5:	77 65                	ja     80231c <__udivdi3+0x8c>
  8022b7:	89 fd                	mov    %edi,%ebp
  8022b9:	85 ff                	test   %edi,%edi
  8022bb:	75 0b                	jne    8022c8 <__udivdi3+0x38>
  8022bd:	b8 01 00 00 00       	mov    $0x1,%eax
  8022c2:	31 d2                	xor    %edx,%edx
  8022c4:	f7 f7                	div    %edi
  8022c6:	89 c5                	mov    %eax,%ebp
  8022c8:	31 d2                	xor    %edx,%edx
  8022ca:	89 c8                	mov    %ecx,%eax
  8022cc:	f7 f5                	div    %ebp
  8022ce:	89 c1                	mov    %eax,%ecx
  8022d0:	89 d8                	mov    %ebx,%eax
  8022d2:	f7 f5                	div    %ebp
  8022d4:	89 cf                	mov    %ecx,%edi
  8022d6:	89 fa                	mov    %edi,%edx
  8022d8:	83 c4 1c             	add    $0x1c,%esp
  8022db:	5b                   	pop    %ebx
  8022dc:	5e                   	pop    %esi
  8022dd:	5f                   	pop    %edi
  8022de:	5d                   	pop    %ebp
  8022df:	c3                   	ret    
  8022e0:	39 ce                	cmp    %ecx,%esi
  8022e2:	77 28                	ja     80230c <__udivdi3+0x7c>
  8022e4:	0f bd fe             	bsr    %esi,%edi
  8022e7:	83 f7 1f             	xor    $0x1f,%edi
  8022ea:	75 40                	jne    80232c <__udivdi3+0x9c>
  8022ec:	39 ce                	cmp    %ecx,%esi
  8022ee:	72 0a                	jb     8022fa <__udivdi3+0x6a>
  8022f0:	3b 44 24 08          	cmp    0x8(%esp),%eax
  8022f4:	0f 87 9e 00 00 00    	ja     802398 <__udivdi3+0x108>
  8022fa:	b8 01 00 00 00       	mov    $0x1,%eax
  8022ff:	89 fa                	mov    %edi,%edx
  802301:	83 c4 1c             	add    $0x1c,%esp
  802304:	5b                   	pop    %ebx
  802305:	5e                   	pop    %esi
  802306:	5f                   	pop    %edi
  802307:	5d                   	pop    %ebp
  802308:	c3                   	ret    
  802309:	8d 76 00             	lea    0x0(%esi),%esi
  80230c:	31 ff                	xor    %edi,%edi
  80230e:	31 c0                	xor    %eax,%eax
  802310:	89 fa                	mov    %edi,%edx
  802312:	83 c4 1c             	add    $0x1c,%esp
  802315:	5b                   	pop    %ebx
  802316:	5e                   	pop    %esi
  802317:	5f                   	pop    %edi
  802318:	5d                   	pop    %ebp
  802319:	c3                   	ret    
  80231a:	66 90                	xchg   %ax,%ax
  80231c:	89 d8                	mov    %ebx,%eax
  80231e:	f7 f7                	div    %edi
  802320:	31 ff                	xor    %edi,%edi
  802322:	89 fa                	mov    %edi,%edx
  802324:	83 c4 1c             	add    $0x1c,%esp
  802327:	5b                   	pop    %ebx
  802328:	5e                   	pop    %esi
  802329:	5f                   	pop    %edi
  80232a:	5d                   	pop    %ebp
  80232b:	c3                   	ret    
  80232c:	bd 20 00 00 00       	mov    $0x20,%ebp
  802331:	89 eb                	mov    %ebp,%ebx
  802333:	29 fb                	sub    %edi,%ebx
  802335:	89 f9                	mov    %edi,%ecx
  802337:	d3 e6                	shl    %cl,%esi
  802339:	89 c5                	mov    %eax,%ebp
  80233b:	88 d9                	mov    %bl,%cl
  80233d:	d3 ed                	shr    %cl,%ebp
  80233f:	89 e9                	mov    %ebp,%ecx
  802341:	09 f1                	or     %esi,%ecx
  802343:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  802347:	89 f9                	mov    %edi,%ecx
  802349:	d3 e0                	shl    %cl,%eax
  80234b:	89 c5                	mov    %eax,%ebp
  80234d:	89 d6                	mov    %edx,%esi
  80234f:	88 d9                	mov    %bl,%cl
  802351:	d3 ee                	shr    %cl,%esi
  802353:	89 f9                	mov    %edi,%ecx
  802355:	d3 e2                	shl    %cl,%edx
  802357:	8b 44 24 08          	mov    0x8(%esp),%eax
  80235b:	88 d9                	mov    %bl,%cl
  80235d:	d3 e8                	shr    %cl,%eax
  80235f:	09 c2                	or     %eax,%edx
  802361:	89 d0                	mov    %edx,%eax
  802363:	89 f2                	mov    %esi,%edx
  802365:	f7 74 24 0c          	divl   0xc(%esp)
  802369:	89 d6                	mov    %edx,%esi
  80236b:	89 c3                	mov    %eax,%ebx
  80236d:	f7 e5                	mul    %ebp
  80236f:	39 d6                	cmp    %edx,%esi
  802371:	72 19                	jb     80238c <__udivdi3+0xfc>
  802373:	74 0b                	je     802380 <__udivdi3+0xf0>
  802375:	89 d8                	mov    %ebx,%eax
  802377:	31 ff                	xor    %edi,%edi
  802379:	e9 58 ff ff ff       	jmp    8022d6 <__udivdi3+0x46>
  80237e:	66 90                	xchg   %ax,%ax
  802380:	8b 54 24 08          	mov    0x8(%esp),%edx
  802384:	89 f9                	mov    %edi,%ecx
  802386:	d3 e2                	shl    %cl,%edx
  802388:	39 c2                	cmp    %eax,%edx
  80238a:	73 e9                	jae    802375 <__udivdi3+0xe5>
  80238c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80238f:	31 ff                	xor    %edi,%edi
  802391:	e9 40 ff ff ff       	jmp    8022d6 <__udivdi3+0x46>
  802396:	66 90                	xchg   %ax,%ax
  802398:	31 c0                	xor    %eax,%eax
  80239a:	e9 37 ff ff ff       	jmp    8022d6 <__udivdi3+0x46>
  80239f:	90                   	nop

008023a0 <__umoddi3>:
  8023a0:	55                   	push   %ebp
  8023a1:	57                   	push   %edi
  8023a2:	56                   	push   %esi
  8023a3:	53                   	push   %ebx
  8023a4:	83 ec 1c             	sub    $0x1c,%esp
  8023a7:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8023ab:	8b 74 24 34          	mov    0x34(%esp),%esi
  8023af:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023b3:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8023b7:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8023bb:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8023bf:	89 f3                	mov    %esi,%ebx
  8023c1:	89 fa                	mov    %edi,%edx
  8023c3:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8023c7:	89 34 24             	mov    %esi,(%esp)
  8023ca:	85 c0                	test   %eax,%eax
  8023cc:	75 1a                	jne    8023e8 <__umoddi3+0x48>
  8023ce:	39 f7                	cmp    %esi,%edi
  8023d0:	0f 86 a2 00 00 00    	jbe    802478 <__umoddi3+0xd8>
  8023d6:	89 c8                	mov    %ecx,%eax
  8023d8:	89 f2                	mov    %esi,%edx
  8023da:	f7 f7                	div    %edi
  8023dc:	89 d0                	mov    %edx,%eax
  8023de:	31 d2                	xor    %edx,%edx
  8023e0:	83 c4 1c             	add    $0x1c,%esp
  8023e3:	5b                   	pop    %ebx
  8023e4:	5e                   	pop    %esi
  8023e5:	5f                   	pop    %edi
  8023e6:	5d                   	pop    %ebp
  8023e7:	c3                   	ret    
  8023e8:	39 f0                	cmp    %esi,%eax
  8023ea:	0f 87 ac 00 00 00    	ja     80249c <__umoddi3+0xfc>
  8023f0:	0f bd e8             	bsr    %eax,%ebp
  8023f3:	83 f5 1f             	xor    $0x1f,%ebp
  8023f6:	0f 84 ac 00 00 00    	je     8024a8 <__umoddi3+0x108>
  8023fc:	bf 20 00 00 00       	mov    $0x20,%edi
  802401:	29 ef                	sub    %ebp,%edi
  802403:	89 fe                	mov    %edi,%esi
  802405:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802409:	89 e9                	mov    %ebp,%ecx
  80240b:	d3 e0                	shl    %cl,%eax
  80240d:	89 d7                	mov    %edx,%edi
  80240f:	89 f1                	mov    %esi,%ecx
  802411:	d3 ef                	shr    %cl,%edi
  802413:	09 c7                	or     %eax,%edi
  802415:	89 e9                	mov    %ebp,%ecx
  802417:	d3 e2                	shl    %cl,%edx
  802419:	89 14 24             	mov    %edx,(%esp)
  80241c:	89 d8                	mov    %ebx,%eax
  80241e:	d3 e0                	shl    %cl,%eax
  802420:	89 c2                	mov    %eax,%edx
  802422:	8b 44 24 08          	mov    0x8(%esp),%eax
  802426:	d3 e0                	shl    %cl,%eax
  802428:	89 44 24 04          	mov    %eax,0x4(%esp)
  80242c:	8b 44 24 08          	mov    0x8(%esp),%eax
  802430:	89 f1                	mov    %esi,%ecx
  802432:	d3 e8                	shr    %cl,%eax
  802434:	09 d0                	or     %edx,%eax
  802436:	d3 eb                	shr    %cl,%ebx
  802438:	89 da                	mov    %ebx,%edx
  80243a:	f7 f7                	div    %edi
  80243c:	89 d3                	mov    %edx,%ebx
  80243e:	f7 24 24             	mull   (%esp)
  802441:	89 c6                	mov    %eax,%esi
  802443:	89 d1                	mov    %edx,%ecx
  802445:	39 d3                	cmp    %edx,%ebx
  802447:	0f 82 87 00 00 00    	jb     8024d4 <__umoddi3+0x134>
  80244d:	0f 84 91 00 00 00    	je     8024e4 <__umoddi3+0x144>
  802453:	8b 54 24 04          	mov    0x4(%esp),%edx
  802457:	29 f2                	sub    %esi,%edx
  802459:	19 cb                	sbb    %ecx,%ebx
  80245b:	89 d8                	mov    %ebx,%eax
  80245d:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802461:	d3 e0                	shl    %cl,%eax
  802463:	89 e9                	mov    %ebp,%ecx
  802465:	d3 ea                	shr    %cl,%edx
  802467:	09 d0                	or     %edx,%eax
  802469:	89 e9                	mov    %ebp,%ecx
  80246b:	d3 eb                	shr    %cl,%ebx
  80246d:	89 da                	mov    %ebx,%edx
  80246f:	83 c4 1c             	add    $0x1c,%esp
  802472:	5b                   	pop    %ebx
  802473:	5e                   	pop    %esi
  802474:	5f                   	pop    %edi
  802475:	5d                   	pop    %ebp
  802476:	c3                   	ret    
  802477:	90                   	nop
  802478:	89 fd                	mov    %edi,%ebp
  80247a:	85 ff                	test   %edi,%edi
  80247c:	75 0b                	jne    802489 <__umoddi3+0xe9>
  80247e:	b8 01 00 00 00       	mov    $0x1,%eax
  802483:	31 d2                	xor    %edx,%edx
  802485:	f7 f7                	div    %edi
  802487:	89 c5                	mov    %eax,%ebp
  802489:	89 f0                	mov    %esi,%eax
  80248b:	31 d2                	xor    %edx,%edx
  80248d:	f7 f5                	div    %ebp
  80248f:	89 c8                	mov    %ecx,%eax
  802491:	f7 f5                	div    %ebp
  802493:	89 d0                	mov    %edx,%eax
  802495:	e9 44 ff ff ff       	jmp    8023de <__umoddi3+0x3e>
  80249a:	66 90                	xchg   %ax,%ax
  80249c:	89 c8                	mov    %ecx,%eax
  80249e:	89 f2                	mov    %esi,%edx
  8024a0:	83 c4 1c             	add    $0x1c,%esp
  8024a3:	5b                   	pop    %ebx
  8024a4:	5e                   	pop    %esi
  8024a5:	5f                   	pop    %edi
  8024a6:	5d                   	pop    %ebp
  8024a7:	c3                   	ret    
  8024a8:	3b 04 24             	cmp    (%esp),%eax
  8024ab:	72 06                	jb     8024b3 <__umoddi3+0x113>
  8024ad:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8024b1:	77 0f                	ja     8024c2 <__umoddi3+0x122>
  8024b3:	89 f2                	mov    %esi,%edx
  8024b5:	29 f9                	sub    %edi,%ecx
  8024b7:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8024bb:	89 14 24             	mov    %edx,(%esp)
  8024be:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024c2:	8b 44 24 04          	mov    0x4(%esp),%eax
  8024c6:	8b 14 24             	mov    (%esp),%edx
  8024c9:	83 c4 1c             	add    $0x1c,%esp
  8024cc:	5b                   	pop    %ebx
  8024cd:	5e                   	pop    %esi
  8024ce:	5f                   	pop    %edi
  8024cf:	5d                   	pop    %ebp
  8024d0:	c3                   	ret    
  8024d1:	8d 76 00             	lea    0x0(%esi),%esi
  8024d4:	2b 04 24             	sub    (%esp),%eax
  8024d7:	19 fa                	sbb    %edi,%edx
  8024d9:	89 d1                	mov    %edx,%ecx
  8024db:	89 c6                	mov    %eax,%esi
  8024dd:	e9 71 ff ff ff       	jmp    802453 <__umoddi3+0xb3>
  8024e2:	66 90                	xchg   %ax,%ax
  8024e4:	39 44 24 04          	cmp    %eax,0x4(%esp)
  8024e8:	72 ea                	jb     8024d4 <__umoddi3+0x134>
  8024ea:	89 d9                	mov    %ebx,%ecx
  8024ec:	e9 62 ff ff ff       	jmp    802453 <__umoddi3+0xb3>
