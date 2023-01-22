
obj/user/ms_vs_qs_msslave:     file format elf32-i386


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
  800031:	e8 f3 07 00 00       	call   800829 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
void Merge(int* A, int p, int q, int r);

uint32 CheckSorted(int *Elements, int NumOfElements);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	81 ec 28 01 00 00    	sub    $0x128,%esp
	int32 parentID = myEnv->env_parent_id ;
  800041:	a1 24 30 80 00       	mov    0x803024,%eax
  800046:	8b 40 50             	mov    0x50(%eax),%eax
  800049:	89 45 f0             	mov    %eax,-0x10(%ebp)

	char Line[255] ;
	char Chose ;
	do
	{
		sys_waitSemaphore(parentID, "cs1");
  80004c:	83 ec 08             	sub    $0x8,%esp
  80004f:	68 20 26 80 00       	push   $0x802620
  800054:	ff 75 f0             	pushl  -0x10(%ebp)
  800057:	e8 c7 1f 00 00       	call   802023 <sys_waitSemaphore>
  80005c:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  80005f:	83 ec 0c             	sub    $0xc,%esp
  800062:	68 24 26 80 00       	push   $0x802624
  800067:	e8 8d 0b 00 00       	call   800bf9 <cprintf>
  80006c:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  80006f:	83 ec 0c             	sub    $0xc,%esp
  800072:	68 26 26 80 00       	push   $0x802626
  800077:	e8 7d 0b 00 00       	call   800bf9 <cprintf>
  80007c:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!! MERGE SORT !!!!\n");
  80007f:	83 ec 0c             	sub    $0xc,%esp
  800082:	68 3c 26 80 00       	push   $0x80263c
  800087:	e8 6d 0b 00 00       	call   800bf9 <cprintf>
  80008c:	83 c4 10             	add    $0x10,%esp
		cprintf("!!!!!!!!!!!!!!!!!!!!\n");
  80008f:	83 ec 0c             	sub    $0xc,%esp
  800092:	68 26 26 80 00       	push   $0x802626
  800097:	e8 5d 0b 00 00       	call   800bf9 <cprintf>
  80009c:	83 c4 10             	add    $0x10,%esp
		cprintf("\n");
  80009f:	83 ec 0c             	sub    $0xc,%esp
  8000a2:	68 24 26 80 00       	push   $0x802624
  8000a7:	e8 4d 0b 00 00       	call   800bf9 <cprintf>
  8000ac:	83 c4 10             	add    $0x10,%esp
		readline("Enter the number of elements: ", Line);
  8000af:	83 ec 08             	sub    $0x8,%esp
  8000b2:	8d 85 e5 fe ff ff    	lea    -0x11b(%ebp),%eax
  8000b8:	50                   	push   %eax
  8000b9:	68 54 26 80 00       	push   $0x802654
  8000be:	e8 b8 11 00 00       	call   80127b <readline>
  8000c3:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  8000c6:	83 ec 04             	sub    $0x4,%esp
  8000c9:	6a 0a                	push   $0xa
  8000cb:	6a 00                	push   $0x0
  8000cd:	8d 85 e5 fe ff ff    	lea    -0x11b(%ebp),%eax
  8000d3:	50                   	push   %eax
  8000d4:	e8 08 17 00 00       	call   8017e1 <strtol>
  8000d9:	83 c4 10             	add    $0x10,%esp
  8000dc:	89 45 ec             	mov    %eax,-0x14(%ebp)
		int *Elements = __new(sizeof(int) * NumOfElements) ;
  8000df:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000e2:	c1 e0 02             	shl    $0x2,%eax
  8000e5:	83 ec 0c             	sub    $0xc,%esp
  8000e8:	50                   	push   %eax
  8000e9:	e8 f1 1b 00 00       	call   801cdf <__new>
  8000ee:	83 c4 10             	add    $0x10,%esp
  8000f1:	89 45 e8             	mov    %eax,-0x18(%ebp)
		cprintf("Chose the initialization method:\n") ;
  8000f4:	83 ec 0c             	sub    $0xc,%esp
  8000f7:	68 74 26 80 00       	push   $0x802674
  8000fc:	e8 f8 0a 00 00       	call   800bf9 <cprintf>
  800101:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  800104:	83 ec 0c             	sub    $0xc,%esp
  800107:	68 96 26 80 00       	push   $0x802696
  80010c:	e8 e8 0a 00 00       	call   800bf9 <cprintf>
  800111:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  800114:	83 ec 0c             	sub    $0xc,%esp
  800117:	68 a4 26 80 00       	push   $0x8026a4
  80011c:	e8 d8 0a 00 00       	call   800bf9 <cprintf>
  800121:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n");
  800124:	83 ec 0c             	sub    $0xc,%esp
  800127:	68 b3 26 80 00       	push   $0x8026b3
  80012c:	e8 c8 0a 00 00       	call   800bf9 <cprintf>
  800131:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	68 c3 26 80 00       	push   $0x8026c3
  80013c:	e8 b8 0a 00 00       	call   800bf9 <cprintf>
  800141:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800144:	e8 88 06 00 00       	call   8007d1 <getchar>
  800149:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  80014c:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800150:	83 ec 0c             	sub    $0xc,%esp
  800153:	50                   	push   %eax
  800154:	e8 30 06 00 00       	call   800789 <cputchar>
  800159:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  80015c:	83 ec 0c             	sub    $0xc,%esp
  80015f:	6a 0a                	push   $0xa
  800161:	e8 23 06 00 00       	call   800789 <cputchar>
  800166:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  800169:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  80016d:	74 0c                	je     80017b <_main+0x143>
  80016f:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800173:	74 06                	je     80017b <_main+0x143>
  800175:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800179:	75 b9                	jne    800134 <_main+0xfc>

		sys_signalSemaphore(parentID, "cs1");
  80017b:	83 ec 08             	sub    $0x8,%esp
  80017e:	68 20 26 80 00       	push   $0x802620
  800183:	ff 75 f0             	pushl  -0x10(%ebp)
  800186:	e8 b6 1e 00 00       	call   802041 <sys_signalSemaphore>
  80018b:	83 c4 10             	add    $0x10,%esp

		int  i ;
		switch (Chose)
  80018e:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800192:	83 f8 62             	cmp    $0x62,%eax
  800195:	74 1d                	je     8001b4 <_main+0x17c>
  800197:	83 f8 63             	cmp    $0x63,%eax
  80019a:	74 2b                	je     8001c7 <_main+0x18f>
  80019c:	83 f8 61             	cmp    $0x61,%eax
  80019f:	75 39                	jne    8001da <_main+0x1a2>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  8001a1:	83 ec 08             	sub    $0x8,%esp
  8001a4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001aa:	e8 4d 02 00 00       	call   8003fc <InitializeAscending>
  8001af:	83 c4 10             	add    $0x10,%esp
			break ;
  8001b2:	eb 37                	jmp    8001eb <_main+0x1b3>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  8001b4:	83 ec 08             	sub    $0x8,%esp
  8001b7:	ff 75 ec             	pushl  -0x14(%ebp)
  8001ba:	ff 75 e8             	pushl  -0x18(%ebp)
  8001bd:	e8 6b 02 00 00       	call   80042d <InitializeDescending>
  8001c2:	83 c4 10             	add    $0x10,%esp
			break ;
  8001c5:	eb 24                	jmp    8001eb <_main+0x1b3>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  8001c7:	83 ec 08             	sub    $0x8,%esp
  8001ca:	ff 75 ec             	pushl  -0x14(%ebp)
  8001cd:	ff 75 e8             	pushl  -0x18(%ebp)
  8001d0:	e8 8d 02 00 00       	call   800462 <InitializeSemiRandom>
  8001d5:	83 c4 10             	add    $0x10,%esp
			break ;
  8001d8:	eb 11                	jmp    8001eb <_main+0x1b3>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001da:	83 ec 08             	sub    $0x8,%esp
  8001dd:	ff 75 ec             	pushl  -0x14(%ebp)
  8001e0:	ff 75 e8             	pushl  -0x18(%ebp)
  8001e3:	e8 7a 02 00 00       	call   800462 <InitializeSemiRandom>
  8001e8:	83 c4 10             	add    $0x10,%esp
		}

		MSort(Elements, 1, NumOfElements);
  8001eb:	83 ec 04             	sub    $0x4,%esp
  8001ee:	ff 75 ec             	pushl  -0x14(%ebp)
  8001f1:	6a 01                	push   $0x1
  8001f3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001f6:	e8 39 03 00 00       	call   800534 <MSort>
  8001fb:	83 c4 10             	add    $0x10,%esp

		sys_waitSemaphore(parentID, "cs1");
  8001fe:	83 ec 08             	sub    $0x8,%esp
  800201:	68 20 26 80 00       	push   $0x802620
  800206:	ff 75 f0             	pushl  -0x10(%ebp)
  800209:	e8 15 1e 00 00       	call   802023 <sys_waitSemaphore>
  80020e:	83 c4 10             	add    $0x10,%esp
		cprintf("Sorting is Finished!!!!it'll be checked now....\n") ;
  800211:	83 ec 0c             	sub    $0xc,%esp
  800214:	68 cc 26 80 00       	push   $0x8026cc
  800219:	e8 db 09 00 00       	call   800bf9 <cprintf>
  80021e:	83 c4 10             	add    $0x10,%esp
		//PrintElements(Elements, NumOfElements);
		sys_signalSemaphore(parentID, "cs1");
  800221:	83 ec 08             	sub    $0x8,%esp
  800224:	68 20 26 80 00       	push   $0x802620
  800229:	ff 75 f0             	pushl  -0x10(%ebp)
  80022c:	e8 10 1e 00 00       	call   802041 <sys_signalSemaphore>
  800231:	83 c4 10             	add    $0x10,%esp


		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  800234:	83 ec 08             	sub    $0x8,%esp
  800237:	ff 75 ec             	pushl  -0x14(%ebp)
  80023a:	ff 75 e8             	pushl  -0x18(%ebp)
  80023d:	e8 10 01 00 00       	call   800352 <CheckSorted>
  800242:	83 c4 10             	add    $0x10,%esp
  800245:	89 45 e4             	mov    %eax,-0x1c(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  800248:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80024c:	75 14                	jne    800262 <_main+0x22a>
  80024e:	83 ec 04             	sub    $0x4,%esp
  800251:	68 00 27 80 00       	push   $0x802700
  800256:	6a 4a                	push   $0x4a
  800258:	68 22 27 80 00       	push   $0x802722
  80025d:	e8 e3 06 00 00       	call   800945 <_panic>
		else
		{
			sys_waitSemaphore(parentID, "cs1");
  800262:	83 ec 08             	sub    $0x8,%esp
  800265:	68 20 26 80 00       	push   $0x802620
  80026a:	ff 75 f0             	pushl  -0x10(%ebp)
  80026d:	e8 b1 1d 00 00       	call   802023 <sys_waitSemaphore>
  800272:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n") ;
  800275:	83 ec 0c             	sub    $0xc,%esp
  800278:	68 3c 27 80 00       	push   $0x80273c
  80027d:	e8 77 09 00 00       	call   800bf9 <cprintf>
  800282:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800285:	83 ec 0c             	sub    $0xc,%esp
  800288:	68 70 27 80 00       	push   $0x802770
  80028d:	e8 67 09 00 00       	call   800bf9 <cprintf>
  800292:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800295:	83 ec 0c             	sub    $0xc,%esp
  800298:	68 a4 27 80 00       	push   $0x8027a4
  80029d:	e8 57 09 00 00       	call   800bf9 <cprintf>
  8002a2:	83 c4 10             	add    $0x10,%esp
			sys_signalSemaphore(parentID, "cs1");
  8002a5:	83 ec 08             	sub    $0x8,%esp
  8002a8:	68 20 26 80 00       	push   $0x802620
  8002ad:	ff 75 f0             	pushl  -0x10(%ebp)
  8002b0:	e8 8c 1d 00 00       	call   802041 <sys_signalSemaphore>
  8002b5:	83 c4 10             	add    $0x10,%esp
		}


		sys_waitSemaphore(parentID, "cs1");
  8002b8:	83 ec 08             	sub    $0x8,%esp
  8002bb:	68 20 26 80 00       	push   $0x802620
  8002c0:	ff 75 f0             	pushl  -0x10(%ebp)
  8002c3:	e8 5b 1d 00 00       	call   802023 <sys_waitSemaphore>
  8002c8:	83 c4 10             	add    $0x10,%esp
			Chose = 0 ;
  8002cb:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
			while (Chose != 'y' && Chose != 'n')
  8002cf:	eb 42                	jmp    800313 <_main+0x2db>
			{
				cprintf("Do you want to repeat (y/n): ") ;
  8002d1:	83 ec 0c             	sub    $0xc,%esp
  8002d4:	68 d6 27 80 00       	push   $0x8027d6
  8002d9:	e8 1b 09 00 00       	call   800bf9 <cprintf>
  8002de:	83 c4 10             	add    $0x10,%esp
				Chose = getchar() ;
  8002e1:	e8 eb 04 00 00       	call   8007d1 <getchar>
  8002e6:	88 45 f7             	mov    %al,-0x9(%ebp)
				cputchar(Chose);
  8002e9:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8002ed:	83 ec 0c             	sub    $0xc,%esp
  8002f0:	50                   	push   %eax
  8002f1:	e8 93 04 00 00       	call   800789 <cputchar>
  8002f6:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  8002f9:	83 ec 0c             	sub    $0xc,%esp
  8002fc:	6a 0a                	push   $0xa
  8002fe:	e8 86 04 00 00       	call   800789 <cputchar>
  800303:	83 c4 10             	add    $0x10,%esp
				cputchar('\n');
  800306:	83 ec 0c             	sub    $0xc,%esp
  800309:	6a 0a                	push   $0xa
  80030b:	e8 79 04 00 00       	call   800789 <cputchar>
  800310:	83 c4 10             	add    $0x10,%esp
		}


		sys_waitSemaphore(parentID, "cs1");
			Chose = 0 ;
			while (Chose != 'y' && Chose != 'n')
  800313:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800317:	74 06                	je     80031f <_main+0x2e7>
  800319:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80031d:	75 b2                	jne    8002d1 <_main+0x299>
				Chose = getchar() ;
				cputchar(Chose);
				cputchar('\n');
				cputchar('\n');
			}
		sys_signalSemaphore(parentID, "cs1");
  80031f:	83 ec 08             	sub    $0x8,%esp
  800322:	68 20 26 80 00       	push   $0x802620
  800327:	ff 75 f0             	pushl  -0x10(%ebp)
  80032a:	e8 12 1d 00 00       	call   802041 <sys_signalSemaphore>
  80032f:	83 c4 10             	add    $0x10,%esp

	} while (Chose == 'y');
  800332:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800336:	0f 84 10 fd ff ff    	je     80004c <_main+0x14>

	sys_signalSemaphore(parentID, "dep1");
  80033c:	83 ec 08             	sub    $0x8,%esp
  80033f:	68 f4 27 80 00       	push   $0x8027f4
  800344:	ff 75 f0             	pushl  -0x10(%ebp)
  800347:	e8 f5 1c 00 00       	call   802041 <sys_signalSemaphore>
  80034c:	83 c4 10             	add    $0x10,%esp

}
  80034f:	90                   	nop
  800350:	c9                   	leave  
  800351:	c3                   	ret    

00800352 <CheckSorted>:


uint32 CheckSorted(int *Elements, int NumOfElements)
{
  800352:	55                   	push   %ebp
  800353:	89 e5                	mov    %esp,%ebp
  800355:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  800358:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80035f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800366:	eb 33                	jmp    80039b <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  800368:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80036b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800372:	8b 45 08             	mov    0x8(%ebp),%eax
  800375:	01 d0                	add    %edx,%eax
  800377:	8b 10                	mov    (%eax),%edx
  800379:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80037c:	40                   	inc    %eax
  80037d:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800384:	8b 45 08             	mov    0x8(%ebp),%eax
  800387:	01 c8                	add    %ecx,%eax
  800389:	8b 00                	mov    (%eax),%eax
  80038b:	39 c2                	cmp    %eax,%edx
  80038d:	7e 09                	jle    800398 <CheckSorted+0x46>
		{
			Sorted = 0 ;
  80038f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800396:	eb 0c                	jmp    8003a4 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  800398:	ff 45 f8             	incl   -0x8(%ebp)
  80039b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80039e:	48                   	dec    %eax
  80039f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8003a2:	7f c4                	jg     800368 <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  8003a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8003a7:	c9                   	leave  
  8003a8:	c3                   	ret    

008003a9 <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  8003a9:	55                   	push   %ebp
  8003aa:	89 e5                	mov    %esp,%ebp
  8003ac:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  8003af:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003b2:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8003bc:	01 d0                	add    %edx,%eax
  8003be:	8b 00                	mov    (%eax),%eax
  8003c0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  8003c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8003d0:	01 c2                	add    %eax,%edx
  8003d2:	8b 45 10             	mov    0x10(%ebp),%eax
  8003d5:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8003dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8003df:	01 c8                	add    %ecx,%eax
  8003e1:	8b 00                	mov    (%eax),%eax
  8003e3:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  8003e5:	8b 45 10             	mov    0x10(%ebp),%eax
  8003e8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f2:	01 c2                	add    %eax,%edx
  8003f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8003f7:	89 02                	mov    %eax,(%edx)
}
  8003f9:	90                   	nop
  8003fa:	c9                   	leave  
  8003fb:	c3                   	ret    

008003fc <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  8003fc:	55                   	push   %ebp
  8003fd:	89 e5                	mov    %esp,%ebp
  8003ff:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800402:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800409:	eb 17                	jmp    800422 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80040b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80040e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800415:	8b 45 08             	mov    0x8(%ebp),%eax
  800418:	01 c2                	add    %eax,%edx
  80041a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80041d:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  80041f:	ff 45 fc             	incl   -0x4(%ebp)
  800422:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800425:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800428:	7c e1                	jl     80040b <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  80042a:	90                   	nop
  80042b:	c9                   	leave  
  80042c:	c3                   	ret    

0080042d <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  80042d:	55                   	push   %ebp
  80042e:	89 e5                	mov    %esp,%ebp
  800430:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800433:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80043a:	eb 1b                	jmp    800457 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  80043c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80043f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800446:	8b 45 08             	mov    0x8(%ebp),%eax
  800449:	01 c2                	add    %eax,%edx
  80044b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80044e:	2b 45 fc             	sub    -0x4(%ebp),%eax
  800451:	48                   	dec    %eax
  800452:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800454:	ff 45 fc             	incl   -0x4(%ebp)
  800457:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80045a:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80045d:	7c dd                	jl     80043c <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  80045f:	90                   	nop
  800460:	c9                   	leave  
  800461:	c3                   	ret    

00800462 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  800462:	55                   	push   %ebp
  800463:	89 e5                	mov    %esp,%ebp
  800465:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  800468:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  80046b:	b8 56 55 55 55       	mov    $0x55555556,%eax
  800470:	f7 e9                	imul   %ecx
  800472:	c1 f9 1f             	sar    $0x1f,%ecx
  800475:	89 d0                	mov    %edx,%eax
  800477:	29 c8                	sub    %ecx,%eax
  800479:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  80047c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800483:	eb 1e                	jmp    8004a3 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800485:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800488:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80048f:	8b 45 08             	mov    0x8(%ebp),%eax
  800492:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800495:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800498:	99                   	cltd   
  800499:	f7 7d f8             	idivl  -0x8(%ebp)
  80049c:	89 d0                	mov    %edx,%eax
  80049e:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  8004a0:	ff 45 fc             	incl   -0x4(%ebp)
  8004a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8004a6:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004a9:	7c da                	jl     800485 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
		//	cprintf("i=%d\n",i);
	}

}
  8004ab:	90                   	nop
  8004ac:	c9                   	leave  
  8004ad:	c3                   	ret    

008004ae <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  8004ae:	55                   	push   %ebp
  8004af:	89 e5                	mov    %esp,%ebp
  8004b1:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  8004b4:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  8004bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8004c2:	eb 42                	jmp    800506 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  8004c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004c7:	99                   	cltd   
  8004c8:	f7 7d f0             	idivl  -0x10(%ebp)
  8004cb:	89 d0                	mov    %edx,%eax
  8004cd:	85 c0                	test   %eax,%eax
  8004cf:	75 10                	jne    8004e1 <PrintElements+0x33>
			cprintf("\n");
  8004d1:	83 ec 0c             	sub    $0xc,%esp
  8004d4:	68 24 26 80 00       	push   $0x802624
  8004d9:	e8 1b 07 00 00       	call   800bf9 <cprintf>
  8004de:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  8004e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8004e4:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8004eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8004ee:	01 d0                	add    %edx,%eax
  8004f0:	8b 00                	mov    (%eax),%eax
  8004f2:	83 ec 08             	sub    $0x8,%esp
  8004f5:	50                   	push   %eax
  8004f6:	68 f9 27 80 00       	push   $0x8027f9
  8004fb:	e8 f9 06 00 00       	call   800bf9 <cprintf>
  800500:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800503:	ff 45 f4             	incl   -0xc(%ebp)
  800506:	8b 45 0c             	mov    0xc(%ebp),%eax
  800509:	48                   	dec    %eax
  80050a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80050d:	7f b5                	jg     8004c4 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  80050f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800512:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800519:	8b 45 08             	mov    0x8(%ebp),%eax
  80051c:	01 d0                	add    %edx,%eax
  80051e:	8b 00                	mov    (%eax),%eax
  800520:	83 ec 08             	sub    $0x8,%esp
  800523:	50                   	push   %eax
  800524:	68 fe 27 80 00       	push   $0x8027fe
  800529:	e8 cb 06 00 00       	call   800bf9 <cprintf>
  80052e:	83 c4 10             	add    $0x10,%esp

}
  800531:	90                   	nop
  800532:	c9                   	leave  
  800533:	c3                   	ret    

00800534 <MSort>:


void MSort(int* A, int p, int r)
{
  800534:	55                   	push   %ebp
  800535:	89 e5                	mov    %esp,%ebp
  800537:	83 ec 18             	sub    $0x18,%esp
	if (p >= r)
  80053a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80053d:	3b 45 10             	cmp    0x10(%ebp),%eax
  800540:	7d 54                	jge    800596 <MSort+0x62>
	{
		return;
	}

	int q = (p + r) / 2;
  800542:	8b 55 0c             	mov    0xc(%ebp),%edx
  800545:	8b 45 10             	mov    0x10(%ebp),%eax
  800548:	01 d0                	add    %edx,%eax
  80054a:	89 c2                	mov    %eax,%edx
  80054c:	c1 ea 1f             	shr    $0x1f,%edx
  80054f:	01 d0                	add    %edx,%eax
  800551:	d1 f8                	sar    %eax
  800553:	89 45 f4             	mov    %eax,-0xc(%ebp)

	MSort(A, p, q);
  800556:	83 ec 04             	sub    $0x4,%esp
  800559:	ff 75 f4             	pushl  -0xc(%ebp)
  80055c:	ff 75 0c             	pushl  0xc(%ebp)
  80055f:	ff 75 08             	pushl  0x8(%ebp)
  800562:	e8 cd ff ff ff       	call   800534 <MSort>
  800567:	83 c4 10             	add    $0x10,%esp

	MSort(A, q + 1, r);
  80056a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80056d:	40                   	inc    %eax
  80056e:	83 ec 04             	sub    $0x4,%esp
  800571:	ff 75 10             	pushl  0x10(%ebp)
  800574:	50                   	push   %eax
  800575:	ff 75 08             	pushl  0x8(%ebp)
  800578:	e8 b7 ff ff ff       	call   800534 <MSort>
  80057d:	83 c4 10             	add    $0x10,%esp

	Merge(A, p, q, r);
  800580:	ff 75 10             	pushl  0x10(%ebp)
  800583:	ff 75 f4             	pushl  -0xc(%ebp)
  800586:	ff 75 0c             	pushl  0xc(%ebp)
  800589:	ff 75 08             	pushl  0x8(%ebp)
  80058c:	e8 08 00 00 00       	call   800599 <Merge>
  800591:	83 c4 10             	add    $0x10,%esp
  800594:	eb 01                	jmp    800597 <MSort+0x63>

void MSort(int* A, int p, int r)
{
	if (p >= r)
	{
		return;
  800596:	90                   	nop

	MSort(A, q + 1, r);

	Merge(A, p, q, r);

}
  800597:	c9                   	leave  
  800598:	c3                   	ret    

00800599 <Merge>:

void Merge(int* A, int p, int q, int r)
{
  800599:	55                   	push   %ebp
  80059a:	89 e5                	mov    %esp,%ebp
  80059c:	83 ec 38             	sub    $0x38,%esp
	int leftCapacity = q - p + 1;
  80059f:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a2:	2b 45 0c             	sub    0xc(%ebp),%eax
  8005a5:	40                   	inc    %eax
  8005a6:	89 45 e0             	mov    %eax,-0x20(%ebp)

	int rightCapacity = r - q;
  8005a9:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ac:	2b 45 10             	sub    0x10(%ebp),%eax
  8005af:	89 45 dc             	mov    %eax,-0x24(%ebp)

	int leftIndex = 0;
  8005b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	int rightIndex = 0;
  8005b9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

	int* Left = __new(sizeof(int) * leftCapacity);
  8005c0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005c3:	c1 e0 02             	shl    $0x2,%eax
  8005c6:	83 ec 0c             	sub    $0xc,%esp
  8005c9:	50                   	push   %eax
  8005ca:	e8 10 17 00 00       	call   801cdf <__new>
  8005cf:	83 c4 10             	add    $0x10,%esp
  8005d2:	89 45 d8             	mov    %eax,-0x28(%ebp)

	int* Right = __new(sizeof(int) * rightCapacity);
  8005d5:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005d8:	c1 e0 02             	shl    $0x2,%eax
  8005db:	83 ec 0c             	sub    $0xc,%esp
  8005de:	50                   	push   %eax
  8005df:	e8 fb 16 00 00       	call   801cdf <__new>
  8005e4:	83 c4 10             	add    $0x10,%esp
  8005e7:	89 45 d4             	mov    %eax,-0x2c(%ebp)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  8005ea:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  8005f1:	eb 2f                	jmp    800622 <Merge+0x89>
	{
		Left[i] = A[p + i - 1];
  8005f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8005f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005fd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800600:	01 c2                	add    %eax,%edx
  800602:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  800605:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800608:	01 c8                	add    %ecx,%eax
  80060a:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  80060f:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800616:	8b 45 08             	mov    0x8(%ebp),%eax
  800619:	01 c8                	add    %ecx,%eax
  80061b:	8b 00                	mov    (%eax),%eax
  80061d:	89 02                	mov    %eax,(%edx)

	//	int Left[5000] ;
	//	int Right[5000] ;

	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
  80061f:	ff 45 ec             	incl   -0x14(%ebp)
  800622:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800625:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800628:	7c c9                	jl     8005f3 <Merge+0x5a>
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80062a:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800631:	eb 2a                	jmp    80065d <Merge+0xc4>
	{
		Right[j] = A[q + j];
  800633:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800636:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063d:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800640:	01 c2                	add    %eax,%edx
  800642:	8b 4d 10             	mov    0x10(%ebp),%ecx
  800645:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800648:	01 c8                	add    %ecx,%eax
  80064a:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800651:	8b 45 08             	mov    0x8(%ebp),%eax
  800654:	01 c8                	add    %ecx,%eax
  800656:	8b 00                	mov    (%eax),%eax
  800658:	89 02                	mov    %eax,(%edx)
	int i, j, k;
	for (i = 0; i < leftCapacity; i++)
	{
		Left[i] = A[p + i - 1];
	}
	for (j = 0; j < rightCapacity; j++)
  80065a:	ff 45 e8             	incl   -0x18(%ebp)
  80065d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800660:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800663:	7c ce                	jl     800633 <Merge+0x9a>
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800665:	8b 45 0c             	mov    0xc(%ebp),%eax
  800668:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  80066b:	e9 0a 01 00 00       	jmp    80077a <Merge+0x1e1>
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
  800670:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800673:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800676:	0f 8d 95 00 00 00    	jge    800711 <Merge+0x178>
  80067c:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80067f:	3b 45 dc             	cmp    -0x24(%ebp),%eax
  800682:	0f 8d 89 00 00 00    	jge    800711 <Merge+0x178>
		{
			if (Left[leftIndex] < Right[rightIndex] )
  800688:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80068b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800692:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800695:	01 d0                	add    %edx,%eax
  800697:	8b 10                	mov    (%eax),%edx
  800699:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80069c:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8006a3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8006a6:	01 c8                	add    %ecx,%eax
  8006a8:	8b 00                	mov    (%eax),%eax
  8006aa:	39 c2                	cmp    %eax,%edx
  8006ac:	7d 33                	jge    8006e1 <Merge+0x148>
			{
				A[k - 1] = Left[leftIndex++];
  8006ae:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006b1:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006b6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c0:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8006c6:	8d 50 01             	lea    0x1(%eax),%edx
  8006c9:	89 55 f4             	mov    %edx,-0xc(%ebp)
  8006cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006d3:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8006d6:	01 d0                	add    %edx,%eax
  8006d8:	8b 00                	mov    (%eax),%eax
  8006da:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  8006dc:	e9 96 00 00 00       	jmp    800777 <Merge+0x1de>
			{
				A[k - 1] = Left[leftIndex++];
			}
			else
			{
				A[k - 1] = Right[rightIndex++];
  8006e1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8006e4:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  8006e9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8006f3:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  8006f6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006f9:	8d 50 01             	lea    0x1(%eax),%edx
  8006fc:	89 55 f0             	mov    %edx,-0x10(%ebp)
  8006ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800706:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800709:	01 d0                	add    %edx,%eax
  80070b:	8b 00                	mov    (%eax),%eax
  80070d:	89 01                	mov    %eax,(%ecx)

	for ( k = p; k <= r; k++)
	{
		if (leftIndex < leftCapacity && rightIndex < rightCapacity)
		{
			if (Left[leftIndex] < Right[rightIndex] )
  80070f:	eb 66                	jmp    800777 <Merge+0x1de>
			else
			{
				A[k - 1] = Right[rightIndex++];
			}
		}
		else if (leftIndex < leftCapacity)
  800711:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800714:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800717:	7d 30                	jge    800749 <Merge+0x1b0>
		{
			A[k - 1] = Left[leftIndex++];
  800719:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80071c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800721:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800728:	8b 45 08             	mov    0x8(%ebp),%eax
  80072b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80072e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800731:	8d 50 01             	lea    0x1(%eax),%edx
  800734:	89 55 f4             	mov    %edx,-0xc(%ebp)
  800737:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80073e:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800741:	01 d0                	add    %edx,%eax
  800743:	8b 00                	mov    (%eax),%eax
  800745:	89 01                	mov    %eax,(%ecx)
  800747:	eb 2e                	jmp    800777 <Merge+0x1de>
		}
		else
		{
			A[k - 1] = Right[rightIndex++];
  800749:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80074c:	05 ff ff ff 3f       	add    $0x3fffffff,%eax
  800751:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800758:	8b 45 08             	mov    0x8(%ebp),%eax
  80075b:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  80075e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800761:	8d 50 01             	lea    0x1(%eax),%edx
  800764:	89 55 f0             	mov    %edx,-0x10(%ebp)
  800767:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076e:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800771:	01 d0                	add    %edx,%eax
  800773:	8b 00                	mov    (%eax),%eax
  800775:	89 01                	mov    %eax,(%ecx)
	for (j = 0; j < rightCapacity; j++)
	{
		Right[j] = A[q + j];
	}

	for ( k = p; k <= r; k++)
  800777:	ff 45 e4             	incl   -0x1c(%ebp)
  80077a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80077d:	3b 45 14             	cmp    0x14(%ebp),%eax
  800780:	0f 8e ea fe ff ff    	jle    800670 <Merge+0xd7>
		{
			A[k - 1] = Right[rightIndex++];
		}
	}

}
  800786:	90                   	nop
  800787:	c9                   	leave  
  800788:	c3                   	ret    

00800789 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  800789:	55                   	push   %ebp
  80078a:	89 e5                	mov    %esp,%ebp
  80078c:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  80078f:	8b 45 08             	mov    0x8(%ebp),%eax
  800792:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  800795:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800799:	83 ec 0c             	sub    $0xc,%esp
  80079c:	50                   	push   %eax
  80079d:	e8 08 18 00 00       	call   801faa <sys_cputc>
  8007a2:	83 c4 10             	add    $0x10,%esp
}
  8007a5:	90                   	nop
  8007a6:	c9                   	leave  
  8007a7:	c3                   	ret    

008007a8 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8007a8:	55                   	push   %ebp
  8007a9:	89 e5                	mov    %esp,%ebp
  8007ab:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007ae:	e8 c3 17 00 00       	call   801f76 <sys_disable_interrupt>
	char c = ch;
  8007b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b6:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007b9:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007bd:	83 ec 0c             	sub    $0xc,%esp
  8007c0:	50                   	push   %eax
  8007c1:	e8 e4 17 00 00       	call   801faa <sys_cputc>
  8007c6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007c9:	e8 c2 17 00 00       	call   801f90 <sys_enable_interrupt>
}
  8007ce:	90                   	nop
  8007cf:	c9                   	leave  
  8007d0:	c3                   	ret    

008007d1 <getchar>:

int
getchar(void)
{
  8007d1:	55                   	push   %ebp
  8007d2:	89 e5                	mov    %esp,%ebp
  8007d4:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  8007d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  8007de:	eb 08                	jmp    8007e8 <getchar+0x17>
	{
		c = sys_cgetc();
  8007e0:	e8 a9 15 00 00       	call   801d8e <sys_cgetc>
  8007e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  8007e8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  8007ec:	74 f2                	je     8007e0 <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  8007ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  8007f1:	c9                   	leave  
  8007f2:	c3                   	ret    

008007f3 <atomic_getchar>:

int
atomic_getchar(void)
{
  8007f3:	55                   	push   %ebp
  8007f4:	89 e5                	mov    %esp,%ebp
  8007f6:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007f9:	e8 78 17 00 00       	call   801f76 <sys_disable_interrupt>
	int c=0;
  8007fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800805:	eb 08                	jmp    80080f <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800807:	e8 82 15 00 00       	call   801d8e <sys_cgetc>
  80080c:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80080f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800813:	74 f2                	je     800807 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800815:	e8 76 17 00 00       	call   801f90 <sys_enable_interrupt>
	return c;
  80081a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80081d:	c9                   	leave  
  80081e:	c3                   	ret    

0080081f <iscons>:

int iscons(int fdnum)
{
  80081f:	55                   	push   %ebp
  800820:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  800822:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800827:	5d                   	pop    %ebp
  800828:	c3                   	ret    

00800829 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800829:	55                   	push   %ebp
  80082a:	89 e5                	mov    %esp,%ebp
  80082c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80082f:	e8 a7 15 00 00       	call   801ddb <sys_getenvindex>
  800834:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800837:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80083a:	89 d0                	mov    %edx,%eax
  80083c:	01 c0                	add    %eax,%eax
  80083e:	01 d0                	add    %edx,%eax
  800840:	c1 e0 04             	shl    $0x4,%eax
  800843:	29 d0                	sub    %edx,%eax
  800845:	c1 e0 03             	shl    $0x3,%eax
  800848:	01 d0                	add    %edx,%eax
  80084a:	c1 e0 02             	shl    $0x2,%eax
  80084d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800852:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800857:	a1 24 30 80 00       	mov    0x803024,%eax
  80085c:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800862:	84 c0                	test   %al,%al
  800864:	74 0f                	je     800875 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800866:	a1 24 30 80 00       	mov    0x803024,%eax
  80086b:	05 5c 05 00 00       	add    $0x55c,%eax
  800870:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800875:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800879:	7e 0a                	jle    800885 <libmain+0x5c>
		binaryname = argv[0];
  80087b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80087e:	8b 00                	mov    (%eax),%eax
  800880:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800885:	83 ec 08             	sub    $0x8,%esp
  800888:	ff 75 0c             	pushl  0xc(%ebp)
  80088b:	ff 75 08             	pushl  0x8(%ebp)
  80088e:	e8 a5 f7 ff ff       	call   800038 <_main>
  800893:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800896:	e8 db 16 00 00       	call   801f76 <sys_disable_interrupt>
	cprintf("**************************************\n");
  80089b:	83 ec 0c             	sub    $0xc,%esp
  80089e:	68 1c 28 80 00       	push   $0x80281c
  8008a3:	e8 51 03 00 00       	call   800bf9 <cprintf>
  8008a8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8008ab:	a1 24 30 80 00       	mov    0x803024,%eax
  8008b0:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8008b6:	a1 24 30 80 00       	mov    0x803024,%eax
  8008bb:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8008c1:	83 ec 04             	sub    $0x4,%esp
  8008c4:	52                   	push   %edx
  8008c5:	50                   	push   %eax
  8008c6:	68 44 28 80 00       	push   $0x802844
  8008cb:	e8 29 03 00 00       	call   800bf9 <cprintf>
  8008d0:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8008d3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008d8:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8008de:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e3:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8008e9:	a1 24 30 80 00       	mov    0x803024,%eax
  8008ee:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8008f4:	51                   	push   %ecx
  8008f5:	52                   	push   %edx
  8008f6:	50                   	push   %eax
  8008f7:	68 6c 28 80 00       	push   $0x80286c
  8008fc:	e8 f8 02 00 00       	call   800bf9 <cprintf>
  800901:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800904:	83 ec 0c             	sub    $0xc,%esp
  800907:	68 1c 28 80 00       	push   $0x80281c
  80090c:	e8 e8 02 00 00       	call   800bf9 <cprintf>
  800911:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800914:	e8 77 16 00 00       	call   801f90 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800919:	e8 19 00 00 00       	call   800937 <exit>
}
  80091e:	90                   	nop
  80091f:	c9                   	leave  
  800920:	c3                   	ret    

00800921 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800921:	55                   	push   %ebp
  800922:	89 e5                	mov    %esp,%ebp
  800924:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800927:	83 ec 0c             	sub    $0xc,%esp
  80092a:	6a 00                	push   $0x0
  80092c:	e8 76 14 00 00       	call   801da7 <sys_env_destroy>
  800931:	83 c4 10             	add    $0x10,%esp
}
  800934:	90                   	nop
  800935:	c9                   	leave  
  800936:	c3                   	ret    

00800937 <exit>:

void
exit(void)
{
  800937:	55                   	push   %ebp
  800938:	89 e5                	mov    %esp,%ebp
  80093a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80093d:	e8 cb 14 00 00       	call   801e0d <sys_env_exit>
}
  800942:	90                   	nop
  800943:	c9                   	leave  
  800944:	c3                   	ret    

00800945 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800945:	55                   	push   %ebp
  800946:	89 e5                	mov    %esp,%ebp
  800948:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80094b:	8d 45 10             	lea    0x10(%ebp),%eax
  80094e:	83 c0 04             	add    $0x4,%eax
  800951:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800954:	a1 18 31 80 00       	mov    0x803118,%eax
  800959:	85 c0                	test   %eax,%eax
  80095b:	74 16                	je     800973 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80095d:	a1 18 31 80 00       	mov    0x803118,%eax
  800962:	83 ec 08             	sub    $0x8,%esp
  800965:	50                   	push   %eax
  800966:	68 c4 28 80 00       	push   $0x8028c4
  80096b:	e8 89 02 00 00       	call   800bf9 <cprintf>
  800970:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800973:	a1 00 30 80 00       	mov    0x803000,%eax
  800978:	ff 75 0c             	pushl  0xc(%ebp)
  80097b:	ff 75 08             	pushl  0x8(%ebp)
  80097e:	50                   	push   %eax
  80097f:	68 c9 28 80 00       	push   $0x8028c9
  800984:	e8 70 02 00 00       	call   800bf9 <cprintf>
  800989:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80098c:	8b 45 10             	mov    0x10(%ebp),%eax
  80098f:	83 ec 08             	sub    $0x8,%esp
  800992:	ff 75 f4             	pushl  -0xc(%ebp)
  800995:	50                   	push   %eax
  800996:	e8 f3 01 00 00       	call   800b8e <vcprintf>
  80099b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80099e:	83 ec 08             	sub    $0x8,%esp
  8009a1:	6a 00                	push   $0x0
  8009a3:	68 e5 28 80 00       	push   $0x8028e5
  8009a8:	e8 e1 01 00 00       	call   800b8e <vcprintf>
  8009ad:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8009b0:	e8 82 ff ff ff       	call   800937 <exit>

	// should not return here
	while (1) ;
  8009b5:	eb fe                	jmp    8009b5 <_panic+0x70>

008009b7 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8009b7:	55                   	push   %ebp
  8009b8:	89 e5                	mov    %esp,%ebp
  8009ba:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8009bd:	a1 24 30 80 00       	mov    0x803024,%eax
  8009c2:	8b 50 74             	mov    0x74(%eax),%edx
  8009c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009c8:	39 c2                	cmp    %eax,%edx
  8009ca:	74 14                	je     8009e0 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8009cc:	83 ec 04             	sub    $0x4,%esp
  8009cf:	68 e8 28 80 00       	push   $0x8028e8
  8009d4:	6a 26                	push   $0x26
  8009d6:	68 34 29 80 00       	push   $0x802934
  8009db:	e8 65 ff ff ff       	call   800945 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8009e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8009e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8009ee:	e9 c2 00 00 00       	jmp    800ab5 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8009f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8009f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8009fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800a00:	01 d0                	add    %edx,%eax
  800a02:	8b 00                	mov    (%eax),%eax
  800a04:	85 c0                	test   %eax,%eax
  800a06:	75 08                	jne    800a10 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a08:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a0b:	e9 a2 00 00 00       	jmp    800ab2 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800a10:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a17:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a1e:	eb 69                	jmp    800a89 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a20:	a1 24 30 80 00       	mov    0x803024,%eax
  800a25:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800a2b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a2e:	89 d0                	mov    %edx,%eax
  800a30:	01 c0                	add    %eax,%eax
  800a32:	01 d0                	add    %edx,%eax
  800a34:	c1 e0 03             	shl    $0x3,%eax
  800a37:	01 c8                	add    %ecx,%eax
  800a39:	8a 40 04             	mov    0x4(%eax),%al
  800a3c:	84 c0                	test   %al,%al
  800a3e:	75 46                	jne    800a86 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a40:	a1 24 30 80 00       	mov    0x803024,%eax
  800a45:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800a4b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a4e:	89 d0                	mov    %edx,%eax
  800a50:	01 c0                	add    %eax,%eax
  800a52:	01 d0                	add    %edx,%eax
  800a54:	c1 e0 03             	shl    $0x3,%eax
  800a57:	01 c8                	add    %ecx,%eax
  800a59:	8b 00                	mov    (%eax),%eax
  800a5b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a5e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a61:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a66:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a68:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a6b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a72:	8b 45 08             	mov    0x8(%ebp),%eax
  800a75:	01 c8                	add    %ecx,%eax
  800a77:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a79:	39 c2                	cmp    %eax,%edx
  800a7b:	75 09                	jne    800a86 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800a7d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800a84:	eb 12                	jmp    800a98 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a86:	ff 45 e8             	incl   -0x18(%ebp)
  800a89:	a1 24 30 80 00       	mov    0x803024,%eax
  800a8e:	8b 50 74             	mov    0x74(%eax),%edx
  800a91:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800a94:	39 c2                	cmp    %eax,%edx
  800a96:	77 88                	ja     800a20 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800a98:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800a9c:	75 14                	jne    800ab2 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800a9e:	83 ec 04             	sub    $0x4,%esp
  800aa1:	68 40 29 80 00       	push   $0x802940
  800aa6:	6a 3a                	push   $0x3a
  800aa8:	68 34 29 80 00       	push   $0x802934
  800aad:	e8 93 fe ff ff       	call   800945 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800ab2:	ff 45 f0             	incl   -0x10(%ebp)
  800ab5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ab8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800abb:	0f 8c 32 ff ff ff    	jl     8009f3 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800ac1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ac8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800acf:	eb 26                	jmp    800af7 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800ad1:	a1 24 30 80 00       	mov    0x803024,%eax
  800ad6:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800adc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800adf:	89 d0                	mov    %edx,%eax
  800ae1:	01 c0                	add    %eax,%eax
  800ae3:	01 d0                	add    %edx,%eax
  800ae5:	c1 e0 03             	shl    $0x3,%eax
  800ae8:	01 c8                	add    %ecx,%eax
  800aea:	8a 40 04             	mov    0x4(%eax),%al
  800aed:	3c 01                	cmp    $0x1,%al
  800aef:	75 03                	jne    800af4 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800af1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800af4:	ff 45 e0             	incl   -0x20(%ebp)
  800af7:	a1 24 30 80 00       	mov    0x803024,%eax
  800afc:	8b 50 74             	mov    0x74(%eax),%edx
  800aff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b02:	39 c2                	cmp    %eax,%edx
  800b04:	77 cb                	ja     800ad1 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b06:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b09:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b0c:	74 14                	je     800b22 <CheckWSWithoutLastIndex+0x16b>
		panic(
  800b0e:	83 ec 04             	sub    $0x4,%esp
  800b11:	68 94 29 80 00       	push   $0x802994
  800b16:	6a 44                	push   $0x44
  800b18:	68 34 29 80 00       	push   $0x802934
  800b1d:	e8 23 fe ff ff       	call   800945 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b22:	90                   	nop
  800b23:	c9                   	leave  
  800b24:	c3                   	ret    

00800b25 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b25:	55                   	push   %ebp
  800b26:	89 e5                	mov    %esp,%ebp
  800b28:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b2e:	8b 00                	mov    (%eax),%eax
  800b30:	8d 48 01             	lea    0x1(%eax),%ecx
  800b33:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b36:	89 0a                	mov    %ecx,(%edx)
  800b38:	8b 55 08             	mov    0x8(%ebp),%edx
  800b3b:	88 d1                	mov    %dl,%cl
  800b3d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b40:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b44:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b47:	8b 00                	mov    (%eax),%eax
  800b49:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b4e:	75 2c                	jne    800b7c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b50:	a0 28 30 80 00       	mov    0x803028,%al
  800b55:	0f b6 c0             	movzbl %al,%eax
  800b58:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b5b:	8b 12                	mov    (%edx),%edx
  800b5d:	89 d1                	mov    %edx,%ecx
  800b5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b62:	83 c2 08             	add    $0x8,%edx
  800b65:	83 ec 04             	sub    $0x4,%esp
  800b68:	50                   	push   %eax
  800b69:	51                   	push   %ecx
  800b6a:	52                   	push   %edx
  800b6b:	e8 f5 11 00 00       	call   801d65 <sys_cputs>
  800b70:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800b73:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b76:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800b7c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b7f:	8b 40 04             	mov    0x4(%eax),%eax
  800b82:	8d 50 01             	lea    0x1(%eax),%edx
  800b85:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b88:	89 50 04             	mov    %edx,0x4(%eax)
}
  800b8b:	90                   	nop
  800b8c:	c9                   	leave  
  800b8d:	c3                   	ret    

00800b8e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800b8e:	55                   	push   %ebp
  800b8f:	89 e5                	mov    %esp,%ebp
  800b91:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800b97:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800b9e:	00 00 00 
	b.cnt = 0;
  800ba1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800ba8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800bab:	ff 75 0c             	pushl  0xc(%ebp)
  800bae:	ff 75 08             	pushl  0x8(%ebp)
  800bb1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bb7:	50                   	push   %eax
  800bb8:	68 25 0b 80 00       	push   $0x800b25
  800bbd:	e8 11 02 00 00       	call   800dd3 <vprintfmt>
  800bc2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800bc5:	a0 28 30 80 00       	mov    0x803028,%al
  800bca:	0f b6 c0             	movzbl %al,%eax
  800bcd:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800bd3:	83 ec 04             	sub    $0x4,%esp
  800bd6:	50                   	push   %eax
  800bd7:	52                   	push   %edx
  800bd8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800bde:	83 c0 08             	add    $0x8,%eax
  800be1:	50                   	push   %eax
  800be2:	e8 7e 11 00 00       	call   801d65 <sys_cputs>
  800be7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800bea:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800bf1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800bf7:	c9                   	leave  
  800bf8:	c3                   	ret    

00800bf9 <cprintf>:

int cprintf(const char *fmt, ...) {
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800bff:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800c06:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c09:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0f:	83 ec 08             	sub    $0x8,%esp
  800c12:	ff 75 f4             	pushl  -0xc(%ebp)
  800c15:	50                   	push   %eax
  800c16:	e8 73 ff ff ff       	call   800b8e <vcprintf>
  800c1b:	83 c4 10             	add    $0x10,%esp
  800c1e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c21:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c24:	c9                   	leave  
  800c25:	c3                   	ret    

00800c26 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c2c:	e8 45 13 00 00       	call   801f76 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c31:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c34:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	83 ec 08             	sub    $0x8,%esp
  800c3d:	ff 75 f4             	pushl  -0xc(%ebp)
  800c40:	50                   	push   %eax
  800c41:	e8 48 ff ff ff       	call   800b8e <vcprintf>
  800c46:	83 c4 10             	add    $0x10,%esp
  800c49:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c4c:	e8 3f 13 00 00       	call   801f90 <sys_enable_interrupt>
	return cnt;
  800c51:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c54:	c9                   	leave  
  800c55:	c3                   	ret    

00800c56 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c56:	55                   	push   %ebp
  800c57:	89 e5                	mov    %esp,%ebp
  800c59:	53                   	push   %ebx
  800c5a:	83 ec 14             	sub    $0x14,%esp
  800c5d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c63:	8b 45 14             	mov    0x14(%ebp),%eax
  800c66:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c69:	8b 45 18             	mov    0x18(%ebp),%eax
  800c6c:	ba 00 00 00 00       	mov    $0x0,%edx
  800c71:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c74:	77 55                	ja     800ccb <printnum+0x75>
  800c76:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800c79:	72 05                	jb     800c80 <printnum+0x2a>
  800c7b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800c7e:	77 4b                	ja     800ccb <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800c80:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800c83:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800c86:	8b 45 18             	mov    0x18(%ebp),%eax
  800c89:	ba 00 00 00 00       	mov    $0x0,%edx
  800c8e:	52                   	push   %edx
  800c8f:	50                   	push   %eax
  800c90:	ff 75 f4             	pushl  -0xc(%ebp)
  800c93:	ff 75 f0             	pushl  -0x10(%ebp)
  800c96:	e8 19 17 00 00       	call   8023b4 <__udivdi3>
  800c9b:	83 c4 10             	add    $0x10,%esp
  800c9e:	83 ec 04             	sub    $0x4,%esp
  800ca1:	ff 75 20             	pushl  0x20(%ebp)
  800ca4:	53                   	push   %ebx
  800ca5:	ff 75 18             	pushl  0x18(%ebp)
  800ca8:	52                   	push   %edx
  800ca9:	50                   	push   %eax
  800caa:	ff 75 0c             	pushl  0xc(%ebp)
  800cad:	ff 75 08             	pushl  0x8(%ebp)
  800cb0:	e8 a1 ff ff ff       	call   800c56 <printnum>
  800cb5:	83 c4 20             	add    $0x20,%esp
  800cb8:	eb 1a                	jmp    800cd4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800cba:	83 ec 08             	sub    $0x8,%esp
  800cbd:	ff 75 0c             	pushl  0xc(%ebp)
  800cc0:	ff 75 20             	pushl  0x20(%ebp)
  800cc3:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc6:	ff d0                	call   *%eax
  800cc8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800ccb:	ff 4d 1c             	decl   0x1c(%ebp)
  800cce:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800cd2:	7f e6                	jg     800cba <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800cd4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800cd7:	bb 00 00 00 00       	mov    $0x0,%ebx
  800cdc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800cdf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ce2:	53                   	push   %ebx
  800ce3:	51                   	push   %ecx
  800ce4:	52                   	push   %edx
  800ce5:	50                   	push   %eax
  800ce6:	e8 d9 17 00 00       	call   8024c4 <__umoddi3>
  800ceb:	83 c4 10             	add    $0x10,%esp
  800cee:	05 f4 2b 80 00       	add    $0x802bf4,%eax
  800cf3:	8a 00                	mov    (%eax),%al
  800cf5:	0f be c0             	movsbl %al,%eax
  800cf8:	83 ec 08             	sub    $0x8,%esp
  800cfb:	ff 75 0c             	pushl  0xc(%ebp)
  800cfe:	50                   	push   %eax
  800cff:	8b 45 08             	mov    0x8(%ebp),%eax
  800d02:	ff d0                	call   *%eax
  800d04:	83 c4 10             	add    $0x10,%esp
}
  800d07:	90                   	nop
  800d08:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d0b:	c9                   	leave  
  800d0c:	c3                   	ret    

00800d0d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d0d:	55                   	push   %ebp
  800d0e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d10:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d14:	7e 1c                	jle    800d32 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d16:	8b 45 08             	mov    0x8(%ebp),%eax
  800d19:	8b 00                	mov    (%eax),%eax
  800d1b:	8d 50 08             	lea    0x8(%eax),%edx
  800d1e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d21:	89 10                	mov    %edx,(%eax)
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8b 00                	mov    (%eax),%eax
  800d28:	83 e8 08             	sub    $0x8,%eax
  800d2b:	8b 50 04             	mov    0x4(%eax),%edx
  800d2e:	8b 00                	mov    (%eax),%eax
  800d30:	eb 40                	jmp    800d72 <getuint+0x65>
	else if (lflag)
  800d32:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d36:	74 1e                	je     800d56 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d38:	8b 45 08             	mov    0x8(%ebp),%eax
  800d3b:	8b 00                	mov    (%eax),%eax
  800d3d:	8d 50 04             	lea    0x4(%eax),%edx
  800d40:	8b 45 08             	mov    0x8(%ebp),%eax
  800d43:	89 10                	mov    %edx,(%eax)
  800d45:	8b 45 08             	mov    0x8(%ebp),%eax
  800d48:	8b 00                	mov    (%eax),%eax
  800d4a:	83 e8 04             	sub    $0x4,%eax
  800d4d:	8b 00                	mov    (%eax),%eax
  800d4f:	ba 00 00 00 00       	mov    $0x0,%edx
  800d54:	eb 1c                	jmp    800d72 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d56:	8b 45 08             	mov    0x8(%ebp),%eax
  800d59:	8b 00                	mov    (%eax),%eax
  800d5b:	8d 50 04             	lea    0x4(%eax),%edx
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	89 10                	mov    %edx,(%eax)
  800d63:	8b 45 08             	mov    0x8(%ebp),%eax
  800d66:	8b 00                	mov    (%eax),%eax
  800d68:	83 e8 04             	sub    $0x4,%eax
  800d6b:	8b 00                	mov    (%eax),%eax
  800d6d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d72:	5d                   	pop    %ebp
  800d73:	c3                   	ret    

00800d74 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800d74:	55                   	push   %ebp
  800d75:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d77:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d7b:	7e 1c                	jle    800d99 <getint+0x25>
		return va_arg(*ap, long long);
  800d7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d80:	8b 00                	mov    (%eax),%eax
  800d82:	8d 50 08             	lea    0x8(%eax),%edx
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	89 10                	mov    %edx,(%eax)
  800d8a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8d:	8b 00                	mov    (%eax),%eax
  800d8f:	83 e8 08             	sub    $0x8,%eax
  800d92:	8b 50 04             	mov    0x4(%eax),%edx
  800d95:	8b 00                	mov    (%eax),%eax
  800d97:	eb 38                	jmp    800dd1 <getint+0x5d>
	else if (lflag)
  800d99:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d9d:	74 1a                	je     800db9 <getint+0x45>
		return va_arg(*ap, long);
  800d9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800da2:	8b 00                	mov    (%eax),%eax
  800da4:	8d 50 04             	lea    0x4(%eax),%edx
  800da7:	8b 45 08             	mov    0x8(%ebp),%eax
  800daa:	89 10                	mov    %edx,(%eax)
  800dac:	8b 45 08             	mov    0x8(%ebp),%eax
  800daf:	8b 00                	mov    (%eax),%eax
  800db1:	83 e8 04             	sub    $0x4,%eax
  800db4:	8b 00                	mov    (%eax),%eax
  800db6:	99                   	cltd   
  800db7:	eb 18                	jmp    800dd1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  800db9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbc:	8b 00                	mov    (%eax),%eax
  800dbe:	8d 50 04             	lea    0x4(%eax),%edx
  800dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc4:	89 10                	mov    %edx,(%eax)
  800dc6:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc9:	8b 00                	mov    (%eax),%eax
  800dcb:	83 e8 04             	sub    $0x4,%eax
  800dce:	8b 00                	mov    (%eax),%eax
  800dd0:	99                   	cltd   
}
  800dd1:	5d                   	pop    %ebp
  800dd2:	c3                   	ret    

00800dd3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800dd3:	55                   	push   %ebp
  800dd4:	89 e5                	mov    %esp,%ebp
  800dd6:	56                   	push   %esi
  800dd7:	53                   	push   %ebx
  800dd8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ddb:	eb 17                	jmp    800df4 <vprintfmt+0x21>
			if (ch == '\0')
  800ddd:	85 db                	test   %ebx,%ebx
  800ddf:	0f 84 af 03 00 00    	je     801194 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800de5:	83 ec 08             	sub    $0x8,%esp
  800de8:	ff 75 0c             	pushl  0xc(%ebp)
  800deb:	53                   	push   %ebx
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	ff d0                	call   *%eax
  800df1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800df4:	8b 45 10             	mov    0x10(%ebp),%eax
  800df7:	8d 50 01             	lea    0x1(%eax),%edx
  800dfa:	89 55 10             	mov    %edx,0x10(%ebp)
  800dfd:	8a 00                	mov    (%eax),%al
  800dff:	0f b6 d8             	movzbl %al,%ebx
  800e02:	83 fb 25             	cmp    $0x25,%ebx
  800e05:	75 d6                	jne    800ddd <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e07:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e0b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e12:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e19:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e20:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e27:	8b 45 10             	mov    0x10(%ebp),%eax
  800e2a:	8d 50 01             	lea    0x1(%eax),%edx
  800e2d:	89 55 10             	mov    %edx,0x10(%ebp)
  800e30:	8a 00                	mov    (%eax),%al
  800e32:	0f b6 d8             	movzbl %al,%ebx
  800e35:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e38:	83 f8 55             	cmp    $0x55,%eax
  800e3b:	0f 87 2b 03 00 00    	ja     80116c <vprintfmt+0x399>
  800e41:	8b 04 85 18 2c 80 00 	mov    0x802c18(,%eax,4),%eax
  800e48:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e4a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e4e:	eb d7                	jmp    800e27 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e50:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e54:	eb d1                	jmp    800e27 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e56:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e5d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e60:	89 d0                	mov    %edx,%eax
  800e62:	c1 e0 02             	shl    $0x2,%eax
  800e65:	01 d0                	add    %edx,%eax
  800e67:	01 c0                	add    %eax,%eax
  800e69:	01 d8                	add    %ebx,%eax
  800e6b:	83 e8 30             	sub    $0x30,%eax
  800e6e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e71:	8b 45 10             	mov    0x10(%ebp),%eax
  800e74:	8a 00                	mov    (%eax),%al
  800e76:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800e79:	83 fb 2f             	cmp    $0x2f,%ebx
  800e7c:	7e 3e                	jle    800ebc <vprintfmt+0xe9>
  800e7e:	83 fb 39             	cmp    $0x39,%ebx
  800e81:	7f 39                	jg     800ebc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e83:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800e86:	eb d5                	jmp    800e5d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800e88:	8b 45 14             	mov    0x14(%ebp),%eax
  800e8b:	83 c0 04             	add    $0x4,%eax
  800e8e:	89 45 14             	mov    %eax,0x14(%ebp)
  800e91:	8b 45 14             	mov    0x14(%ebp),%eax
  800e94:	83 e8 04             	sub    $0x4,%eax
  800e97:	8b 00                	mov    (%eax),%eax
  800e99:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800e9c:	eb 1f                	jmp    800ebd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800e9e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ea2:	79 83                	jns    800e27 <vprintfmt+0x54>
				width = 0;
  800ea4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800eab:	e9 77 ff ff ff       	jmp    800e27 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800eb0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800eb7:	e9 6b ff ff ff       	jmp    800e27 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ebc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800ebd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ec1:	0f 89 60 ff ff ff    	jns    800e27 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ec7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800eca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800ecd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800ed4:	e9 4e ff ff ff       	jmp    800e27 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800ed9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800edc:	e9 46 ff ff ff       	jmp    800e27 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800ee1:	8b 45 14             	mov    0x14(%ebp),%eax
  800ee4:	83 c0 04             	add    $0x4,%eax
  800ee7:	89 45 14             	mov    %eax,0x14(%ebp)
  800eea:	8b 45 14             	mov    0x14(%ebp),%eax
  800eed:	83 e8 04             	sub    $0x4,%eax
  800ef0:	8b 00                	mov    (%eax),%eax
  800ef2:	83 ec 08             	sub    $0x8,%esp
  800ef5:	ff 75 0c             	pushl  0xc(%ebp)
  800ef8:	50                   	push   %eax
  800ef9:	8b 45 08             	mov    0x8(%ebp),%eax
  800efc:	ff d0                	call   *%eax
  800efe:	83 c4 10             	add    $0x10,%esp
			break;
  800f01:	e9 89 02 00 00       	jmp    80118f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f06:	8b 45 14             	mov    0x14(%ebp),%eax
  800f09:	83 c0 04             	add    $0x4,%eax
  800f0c:	89 45 14             	mov    %eax,0x14(%ebp)
  800f0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f12:	83 e8 04             	sub    $0x4,%eax
  800f15:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f17:	85 db                	test   %ebx,%ebx
  800f19:	79 02                	jns    800f1d <vprintfmt+0x14a>
				err = -err;
  800f1b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f1d:	83 fb 64             	cmp    $0x64,%ebx
  800f20:	7f 0b                	jg     800f2d <vprintfmt+0x15a>
  800f22:	8b 34 9d 60 2a 80 00 	mov    0x802a60(,%ebx,4),%esi
  800f29:	85 f6                	test   %esi,%esi
  800f2b:	75 19                	jne    800f46 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f2d:	53                   	push   %ebx
  800f2e:	68 05 2c 80 00       	push   $0x802c05
  800f33:	ff 75 0c             	pushl  0xc(%ebp)
  800f36:	ff 75 08             	pushl  0x8(%ebp)
  800f39:	e8 5e 02 00 00       	call   80119c <printfmt>
  800f3e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800f41:	e9 49 02 00 00       	jmp    80118f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f46:	56                   	push   %esi
  800f47:	68 0e 2c 80 00       	push   $0x802c0e
  800f4c:	ff 75 0c             	pushl  0xc(%ebp)
  800f4f:	ff 75 08             	pushl  0x8(%ebp)
  800f52:	e8 45 02 00 00       	call   80119c <printfmt>
  800f57:	83 c4 10             	add    $0x10,%esp
			break;
  800f5a:	e9 30 02 00 00       	jmp    80118f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f5f:	8b 45 14             	mov    0x14(%ebp),%eax
  800f62:	83 c0 04             	add    $0x4,%eax
  800f65:	89 45 14             	mov    %eax,0x14(%ebp)
  800f68:	8b 45 14             	mov    0x14(%ebp),%eax
  800f6b:	83 e8 04             	sub    $0x4,%eax
  800f6e:	8b 30                	mov    (%eax),%esi
  800f70:	85 f6                	test   %esi,%esi
  800f72:	75 05                	jne    800f79 <vprintfmt+0x1a6>
				p = "(null)";
  800f74:	be 11 2c 80 00       	mov    $0x802c11,%esi
			if (width > 0 && padc != '-')
  800f79:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800f7d:	7e 6d                	jle    800fec <vprintfmt+0x219>
  800f7f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800f83:	74 67                	je     800fec <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800f85:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800f88:	83 ec 08             	sub    $0x8,%esp
  800f8b:	50                   	push   %eax
  800f8c:	56                   	push   %esi
  800f8d:	e8 12 05 00 00       	call   8014a4 <strnlen>
  800f92:	83 c4 10             	add    $0x10,%esp
  800f95:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800f98:	eb 16                	jmp    800fb0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800f9a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800f9e:	83 ec 08             	sub    $0x8,%esp
  800fa1:	ff 75 0c             	pushl  0xc(%ebp)
  800fa4:	50                   	push   %eax
  800fa5:	8b 45 08             	mov    0x8(%ebp),%eax
  800fa8:	ff d0                	call   *%eax
  800faa:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800fad:	ff 4d e4             	decl   -0x1c(%ebp)
  800fb0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fb4:	7f e4                	jg     800f9a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800fb6:	eb 34                	jmp    800fec <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800fb8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800fbc:	74 1c                	je     800fda <vprintfmt+0x207>
  800fbe:	83 fb 1f             	cmp    $0x1f,%ebx
  800fc1:	7e 05                	jle    800fc8 <vprintfmt+0x1f5>
  800fc3:	83 fb 7e             	cmp    $0x7e,%ebx
  800fc6:	7e 12                	jle    800fda <vprintfmt+0x207>
					putch('?', putdat);
  800fc8:	83 ec 08             	sub    $0x8,%esp
  800fcb:	ff 75 0c             	pushl  0xc(%ebp)
  800fce:	6a 3f                	push   $0x3f
  800fd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd3:	ff d0                	call   *%eax
  800fd5:	83 c4 10             	add    $0x10,%esp
  800fd8:	eb 0f                	jmp    800fe9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800fda:	83 ec 08             	sub    $0x8,%esp
  800fdd:	ff 75 0c             	pushl  0xc(%ebp)
  800fe0:	53                   	push   %ebx
  800fe1:	8b 45 08             	mov    0x8(%ebp),%eax
  800fe4:	ff d0                	call   *%eax
  800fe6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800fe9:	ff 4d e4             	decl   -0x1c(%ebp)
  800fec:	89 f0                	mov    %esi,%eax
  800fee:	8d 70 01             	lea    0x1(%eax),%esi
  800ff1:	8a 00                	mov    (%eax),%al
  800ff3:	0f be d8             	movsbl %al,%ebx
  800ff6:	85 db                	test   %ebx,%ebx
  800ff8:	74 24                	je     80101e <vprintfmt+0x24b>
  800ffa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800ffe:	78 b8                	js     800fb8 <vprintfmt+0x1e5>
  801000:	ff 4d e0             	decl   -0x20(%ebp)
  801003:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801007:	79 af                	jns    800fb8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801009:	eb 13                	jmp    80101e <vprintfmt+0x24b>
				putch(' ', putdat);
  80100b:	83 ec 08             	sub    $0x8,%esp
  80100e:	ff 75 0c             	pushl  0xc(%ebp)
  801011:	6a 20                	push   $0x20
  801013:	8b 45 08             	mov    0x8(%ebp),%eax
  801016:	ff d0                	call   *%eax
  801018:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80101b:	ff 4d e4             	decl   -0x1c(%ebp)
  80101e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  801022:	7f e7                	jg     80100b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801024:	e9 66 01 00 00       	jmp    80118f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801029:	83 ec 08             	sub    $0x8,%esp
  80102c:	ff 75 e8             	pushl  -0x18(%ebp)
  80102f:	8d 45 14             	lea    0x14(%ebp),%eax
  801032:	50                   	push   %eax
  801033:	e8 3c fd ff ff       	call   800d74 <getint>
  801038:	83 c4 10             	add    $0x10,%esp
  80103b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80103e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  801041:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801044:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801047:	85 d2                	test   %edx,%edx
  801049:	79 23                	jns    80106e <vprintfmt+0x29b>
				putch('-', putdat);
  80104b:	83 ec 08             	sub    $0x8,%esp
  80104e:	ff 75 0c             	pushl  0xc(%ebp)
  801051:	6a 2d                	push   $0x2d
  801053:	8b 45 08             	mov    0x8(%ebp),%eax
  801056:	ff d0                	call   *%eax
  801058:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80105b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80105e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801061:	f7 d8                	neg    %eax
  801063:	83 d2 00             	adc    $0x0,%edx
  801066:	f7 da                	neg    %edx
  801068:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80106b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80106e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801075:	e9 bc 00 00 00       	jmp    801136 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  80107a:	83 ec 08             	sub    $0x8,%esp
  80107d:	ff 75 e8             	pushl  -0x18(%ebp)
  801080:	8d 45 14             	lea    0x14(%ebp),%eax
  801083:	50                   	push   %eax
  801084:	e8 84 fc ff ff       	call   800d0d <getuint>
  801089:	83 c4 10             	add    $0x10,%esp
  80108c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80108f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  801092:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  801099:	e9 98 00 00 00       	jmp    801136 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  80109e:	83 ec 08             	sub    $0x8,%esp
  8010a1:	ff 75 0c             	pushl  0xc(%ebp)
  8010a4:	6a 58                	push   $0x58
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	ff d0                	call   *%eax
  8010ab:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010ae:	83 ec 08             	sub    $0x8,%esp
  8010b1:	ff 75 0c             	pushl  0xc(%ebp)
  8010b4:	6a 58                	push   $0x58
  8010b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b9:	ff d0                	call   *%eax
  8010bb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010be:	83 ec 08             	sub    $0x8,%esp
  8010c1:	ff 75 0c             	pushl  0xc(%ebp)
  8010c4:	6a 58                	push   $0x58
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	ff d0                	call   *%eax
  8010cb:	83 c4 10             	add    $0x10,%esp
			break;
  8010ce:	e9 bc 00 00 00       	jmp    80118f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  8010d3:	83 ec 08             	sub    $0x8,%esp
  8010d6:	ff 75 0c             	pushl  0xc(%ebp)
  8010d9:	6a 30                	push   $0x30
  8010db:	8b 45 08             	mov    0x8(%ebp),%eax
  8010de:	ff d0                	call   *%eax
  8010e0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  8010e3:	83 ec 08             	sub    $0x8,%esp
  8010e6:	ff 75 0c             	pushl  0xc(%ebp)
  8010e9:	6a 78                	push   $0x78
  8010eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ee:	ff d0                	call   *%eax
  8010f0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  8010f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8010f6:	83 c0 04             	add    $0x4,%eax
  8010f9:	89 45 14             	mov    %eax,0x14(%ebp)
  8010fc:	8b 45 14             	mov    0x14(%ebp),%eax
  8010ff:	83 e8 04             	sub    $0x4,%eax
  801102:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801104:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801107:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80110e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801115:	eb 1f                	jmp    801136 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801117:	83 ec 08             	sub    $0x8,%esp
  80111a:	ff 75 e8             	pushl  -0x18(%ebp)
  80111d:	8d 45 14             	lea    0x14(%ebp),%eax
  801120:	50                   	push   %eax
  801121:	e8 e7 fb ff ff       	call   800d0d <getuint>
  801126:	83 c4 10             	add    $0x10,%esp
  801129:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80112c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80112f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801136:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  80113a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80113d:	83 ec 04             	sub    $0x4,%esp
  801140:	52                   	push   %edx
  801141:	ff 75 e4             	pushl  -0x1c(%ebp)
  801144:	50                   	push   %eax
  801145:	ff 75 f4             	pushl  -0xc(%ebp)
  801148:	ff 75 f0             	pushl  -0x10(%ebp)
  80114b:	ff 75 0c             	pushl  0xc(%ebp)
  80114e:	ff 75 08             	pushl  0x8(%ebp)
  801151:	e8 00 fb ff ff       	call   800c56 <printnum>
  801156:	83 c4 20             	add    $0x20,%esp
			break;
  801159:	eb 34                	jmp    80118f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80115b:	83 ec 08             	sub    $0x8,%esp
  80115e:	ff 75 0c             	pushl  0xc(%ebp)
  801161:	53                   	push   %ebx
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	ff d0                	call   *%eax
  801167:	83 c4 10             	add    $0x10,%esp
			break;
  80116a:	eb 23                	jmp    80118f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80116c:	83 ec 08             	sub    $0x8,%esp
  80116f:	ff 75 0c             	pushl  0xc(%ebp)
  801172:	6a 25                	push   $0x25
  801174:	8b 45 08             	mov    0x8(%ebp),%eax
  801177:	ff d0                	call   *%eax
  801179:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  80117c:	ff 4d 10             	decl   0x10(%ebp)
  80117f:	eb 03                	jmp    801184 <vprintfmt+0x3b1>
  801181:	ff 4d 10             	decl   0x10(%ebp)
  801184:	8b 45 10             	mov    0x10(%ebp),%eax
  801187:	48                   	dec    %eax
  801188:	8a 00                	mov    (%eax),%al
  80118a:	3c 25                	cmp    $0x25,%al
  80118c:	75 f3                	jne    801181 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  80118e:	90                   	nop
		}
	}
  80118f:	e9 47 fc ff ff       	jmp    800ddb <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  801194:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  801195:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801198:	5b                   	pop    %ebx
  801199:	5e                   	pop    %esi
  80119a:	5d                   	pop    %ebp
  80119b:	c3                   	ret    

0080119c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  80119c:	55                   	push   %ebp
  80119d:	89 e5                	mov    %esp,%ebp
  80119f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8011a2:	8d 45 10             	lea    0x10(%ebp),%eax
  8011a5:	83 c0 04             	add    $0x4,%eax
  8011a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8011ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8011ae:	ff 75 f4             	pushl  -0xc(%ebp)
  8011b1:	50                   	push   %eax
  8011b2:	ff 75 0c             	pushl  0xc(%ebp)
  8011b5:	ff 75 08             	pushl  0x8(%ebp)
  8011b8:	e8 16 fc ff ff       	call   800dd3 <vprintfmt>
  8011bd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8011c0:	90                   	nop
  8011c1:	c9                   	leave  
  8011c2:	c3                   	ret    

008011c3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8011c3:	55                   	push   %ebp
  8011c4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8011c6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011c9:	8b 40 08             	mov    0x8(%eax),%eax
  8011cc:	8d 50 01             	lea    0x1(%eax),%edx
  8011cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  8011d5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d8:	8b 10                	mov    (%eax),%edx
  8011da:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011dd:	8b 40 04             	mov    0x4(%eax),%eax
  8011e0:	39 c2                	cmp    %eax,%edx
  8011e2:	73 12                	jae    8011f6 <sprintputch+0x33>
		*b->buf++ = ch;
  8011e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e7:	8b 00                	mov    (%eax),%eax
  8011e9:	8d 48 01             	lea    0x1(%eax),%ecx
  8011ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011ef:	89 0a                	mov    %ecx,(%edx)
  8011f1:	8b 55 08             	mov    0x8(%ebp),%edx
  8011f4:	88 10                	mov    %dl,(%eax)
}
  8011f6:	90                   	nop
  8011f7:	5d                   	pop    %ebp
  8011f8:	c3                   	ret    

008011f9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  8011f9:	55                   	push   %ebp
  8011fa:	89 e5                	mov    %esp,%ebp
  8011fc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  8011ff:	8b 45 08             	mov    0x8(%ebp),%eax
  801202:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801205:	8b 45 0c             	mov    0xc(%ebp),%eax
  801208:	8d 50 ff             	lea    -0x1(%eax),%edx
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	01 d0                	add    %edx,%eax
  801210:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801213:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  80121a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80121e:	74 06                	je     801226 <vsnprintf+0x2d>
  801220:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801224:	7f 07                	jg     80122d <vsnprintf+0x34>
		return -E_INVAL;
  801226:	b8 03 00 00 00       	mov    $0x3,%eax
  80122b:	eb 20                	jmp    80124d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80122d:	ff 75 14             	pushl  0x14(%ebp)
  801230:	ff 75 10             	pushl  0x10(%ebp)
  801233:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801236:	50                   	push   %eax
  801237:	68 c3 11 80 00       	push   $0x8011c3
  80123c:	e8 92 fb ff ff       	call   800dd3 <vprintfmt>
  801241:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801244:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801247:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  80124a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80124d:	c9                   	leave  
  80124e:	c3                   	ret    

0080124f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80124f:	55                   	push   %ebp
  801250:	89 e5                	mov    %esp,%ebp
  801252:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801255:	8d 45 10             	lea    0x10(%ebp),%eax
  801258:	83 c0 04             	add    $0x4,%eax
  80125b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80125e:	8b 45 10             	mov    0x10(%ebp),%eax
  801261:	ff 75 f4             	pushl  -0xc(%ebp)
  801264:	50                   	push   %eax
  801265:	ff 75 0c             	pushl  0xc(%ebp)
  801268:	ff 75 08             	pushl  0x8(%ebp)
  80126b:	e8 89 ff ff ff       	call   8011f9 <vsnprintf>
  801270:	83 c4 10             	add    $0x10,%esp
  801273:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  801276:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801279:	c9                   	leave  
  80127a:	c3                   	ret    

0080127b <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  80127b:	55                   	push   %ebp
  80127c:	89 e5                	mov    %esp,%ebp
  80127e:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  801281:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801285:	74 13                	je     80129a <readline+0x1f>
		cprintf("%s", prompt);
  801287:	83 ec 08             	sub    $0x8,%esp
  80128a:	ff 75 08             	pushl  0x8(%ebp)
  80128d:	68 70 2d 80 00       	push   $0x802d70
  801292:	e8 62 f9 ff ff       	call   800bf9 <cprintf>
  801297:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80129a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8012a1:	83 ec 0c             	sub    $0xc,%esp
  8012a4:	6a 00                	push   $0x0
  8012a6:	e8 74 f5 ff ff       	call   80081f <iscons>
  8012ab:	83 c4 10             	add    $0x10,%esp
  8012ae:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8012b1:	e8 1b f5 ff ff       	call   8007d1 <getchar>
  8012b6:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8012b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8012bd:	79 22                	jns    8012e1 <readline+0x66>
			if (c != -E_EOF)
  8012bf:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8012c3:	0f 84 ad 00 00 00    	je     801376 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8012c9:	83 ec 08             	sub    $0x8,%esp
  8012cc:	ff 75 ec             	pushl  -0x14(%ebp)
  8012cf:	68 73 2d 80 00       	push   $0x802d73
  8012d4:	e8 20 f9 ff ff       	call   800bf9 <cprintf>
  8012d9:	83 c4 10             	add    $0x10,%esp
			return;
  8012dc:	e9 95 00 00 00       	jmp    801376 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8012e1:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8012e5:	7e 34                	jle    80131b <readline+0xa0>
  8012e7:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8012ee:	7f 2b                	jg     80131b <readline+0xa0>
			if (echoing)
  8012f0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8012f4:	74 0e                	je     801304 <readline+0x89>
				cputchar(c);
  8012f6:	83 ec 0c             	sub    $0xc,%esp
  8012f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8012fc:	e8 88 f4 ff ff       	call   800789 <cputchar>
  801301:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801304:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801307:	8d 50 01             	lea    0x1(%eax),%edx
  80130a:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80130d:	89 c2                	mov    %eax,%edx
  80130f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801312:	01 d0                	add    %edx,%eax
  801314:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801317:	88 10                	mov    %dl,(%eax)
  801319:	eb 56                	jmp    801371 <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  80131b:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80131f:	75 1f                	jne    801340 <readline+0xc5>
  801321:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801325:	7e 19                	jle    801340 <readline+0xc5>
			if (echoing)
  801327:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80132b:	74 0e                	je     80133b <readline+0xc0>
				cputchar(c);
  80132d:	83 ec 0c             	sub    $0xc,%esp
  801330:	ff 75 ec             	pushl  -0x14(%ebp)
  801333:	e8 51 f4 ff ff       	call   800789 <cputchar>
  801338:	83 c4 10             	add    $0x10,%esp

			i--;
  80133b:	ff 4d f4             	decl   -0xc(%ebp)
  80133e:	eb 31                	jmp    801371 <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  801340:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801344:	74 0a                	je     801350 <readline+0xd5>
  801346:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80134a:	0f 85 61 ff ff ff    	jne    8012b1 <readline+0x36>
			if (echoing)
  801350:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801354:	74 0e                	je     801364 <readline+0xe9>
				cputchar(c);
  801356:	83 ec 0c             	sub    $0xc,%esp
  801359:	ff 75 ec             	pushl  -0x14(%ebp)
  80135c:	e8 28 f4 ff ff       	call   800789 <cputchar>
  801361:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801364:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801367:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136a:	01 d0                	add    %edx,%eax
  80136c:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80136f:	eb 06                	jmp    801377 <readline+0xfc>
		}
	}
  801371:	e9 3b ff ff ff       	jmp    8012b1 <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  801376:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  801377:	c9                   	leave  
  801378:	c3                   	ret    

00801379 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  801379:	55                   	push   %ebp
  80137a:	89 e5                	mov    %esp,%ebp
  80137c:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80137f:	e8 f2 0b 00 00       	call   801f76 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  801384:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801388:	74 13                	je     80139d <atomic_readline+0x24>
		cprintf("%s", prompt);
  80138a:	83 ec 08             	sub    $0x8,%esp
  80138d:	ff 75 08             	pushl  0x8(%ebp)
  801390:	68 70 2d 80 00       	push   $0x802d70
  801395:	e8 5f f8 ff ff       	call   800bf9 <cprintf>
  80139a:	83 c4 10             	add    $0x10,%esp

	i = 0;
  80139d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8013a4:	83 ec 0c             	sub    $0xc,%esp
  8013a7:	6a 00                	push   $0x0
  8013a9:	e8 71 f4 ff ff       	call   80081f <iscons>
  8013ae:	83 c4 10             	add    $0x10,%esp
  8013b1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8013b4:	e8 18 f4 ff ff       	call   8007d1 <getchar>
  8013b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8013bc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013c0:	79 23                	jns    8013e5 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8013c2:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8013c6:	74 13                	je     8013db <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8013c8:	83 ec 08             	sub    $0x8,%esp
  8013cb:	ff 75 ec             	pushl  -0x14(%ebp)
  8013ce:	68 73 2d 80 00       	push   $0x802d73
  8013d3:	e8 21 f8 ff ff       	call   800bf9 <cprintf>
  8013d8:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  8013db:	e8 b0 0b 00 00       	call   801f90 <sys_enable_interrupt>
			return;
  8013e0:	e9 9a 00 00 00       	jmp    80147f <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  8013e5:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  8013e9:	7e 34                	jle    80141f <atomic_readline+0xa6>
  8013eb:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  8013f2:	7f 2b                	jg     80141f <atomic_readline+0xa6>
			if (echoing)
  8013f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  8013f8:	74 0e                	je     801408 <atomic_readline+0x8f>
				cputchar(c);
  8013fa:	83 ec 0c             	sub    $0xc,%esp
  8013fd:	ff 75 ec             	pushl  -0x14(%ebp)
  801400:	e8 84 f3 ff ff       	call   800789 <cputchar>
  801405:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801408:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80140b:	8d 50 01             	lea    0x1(%eax),%edx
  80140e:	89 55 f4             	mov    %edx,-0xc(%ebp)
  801411:	89 c2                	mov    %eax,%edx
  801413:	8b 45 0c             	mov    0xc(%ebp),%eax
  801416:	01 d0                	add    %edx,%eax
  801418:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80141b:	88 10                	mov    %dl,(%eax)
  80141d:	eb 5b                	jmp    80147a <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80141f:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801423:	75 1f                	jne    801444 <atomic_readline+0xcb>
  801425:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801429:	7e 19                	jle    801444 <atomic_readline+0xcb>
			if (echoing)
  80142b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80142f:	74 0e                	je     80143f <atomic_readline+0xc6>
				cputchar(c);
  801431:	83 ec 0c             	sub    $0xc,%esp
  801434:	ff 75 ec             	pushl  -0x14(%ebp)
  801437:	e8 4d f3 ff ff       	call   800789 <cputchar>
  80143c:	83 c4 10             	add    $0x10,%esp
			i--;
  80143f:	ff 4d f4             	decl   -0xc(%ebp)
  801442:	eb 36                	jmp    80147a <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801444:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801448:	74 0a                	je     801454 <atomic_readline+0xdb>
  80144a:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80144e:	0f 85 60 ff ff ff    	jne    8013b4 <atomic_readline+0x3b>
			if (echoing)
  801454:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801458:	74 0e                	je     801468 <atomic_readline+0xef>
				cputchar(c);
  80145a:	83 ec 0c             	sub    $0xc,%esp
  80145d:	ff 75 ec             	pushl  -0x14(%ebp)
  801460:	e8 24 f3 ff ff       	call   800789 <cputchar>
  801465:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801468:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80146b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80146e:	01 d0                	add    %edx,%eax
  801470:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  801473:	e8 18 0b 00 00       	call   801f90 <sys_enable_interrupt>
			return;
  801478:	eb 05                	jmp    80147f <atomic_readline+0x106>
		}
	}
  80147a:	e9 35 ff ff ff       	jmp    8013b4 <atomic_readline+0x3b>
}
  80147f:	c9                   	leave  
  801480:	c3                   	ret    

00801481 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801481:	55                   	push   %ebp
  801482:	89 e5                	mov    %esp,%ebp
  801484:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801487:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80148e:	eb 06                	jmp    801496 <strlen+0x15>
		n++;
  801490:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801493:	ff 45 08             	incl   0x8(%ebp)
  801496:	8b 45 08             	mov    0x8(%ebp),%eax
  801499:	8a 00                	mov    (%eax),%al
  80149b:	84 c0                	test   %al,%al
  80149d:	75 f1                	jne    801490 <strlen+0xf>
		n++;
	return n;
  80149f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014a2:	c9                   	leave  
  8014a3:	c3                   	ret    

008014a4 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8014a4:	55                   	push   %ebp
  8014a5:	89 e5                	mov    %esp,%ebp
  8014a7:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014aa:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014b1:	eb 09                	jmp    8014bc <strnlen+0x18>
		n++;
  8014b3:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014b6:	ff 45 08             	incl   0x8(%ebp)
  8014b9:	ff 4d 0c             	decl   0xc(%ebp)
  8014bc:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014c0:	74 09                	je     8014cb <strnlen+0x27>
  8014c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c5:	8a 00                	mov    (%eax),%al
  8014c7:	84 c0                	test   %al,%al
  8014c9:	75 e8                	jne    8014b3 <strnlen+0xf>
		n++;
	return n;
  8014cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014ce:	c9                   	leave  
  8014cf:	c3                   	ret    

008014d0 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8014d0:	55                   	push   %ebp
  8014d1:	89 e5                	mov    %esp,%ebp
  8014d3:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8014d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8014d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  8014dc:	90                   	nop
  8014dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e0:	8d 50 01             	lea    0x1(%eax),%edx
  8014e3:	89 55 08             	mov    %edx,0x8(%ebp)
  8014e6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014e9:	8d 4a 01             	lea    0x1(%edx),%ecx
  8014ec:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8014ef:	8a 12                	mov    (%edx),%dl
  8014f1:	88 10                	mov    %dl,(%eax)
  8014f3:	8a 00                	mov    (%eax),%al
  8014f5:	84 c0                	test   %al,%al
  8014f7:	75 e4                	jne    8014dd <strcpy+0xd>
		/* do nothing */;
	return ret;
  8014f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014fc:	c9                   	leave  
  8014fd:	c3                   	ret    

008014fe <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8014fe:	55                   	push   %ebp
  8014ff:	89 e5                	mov    %esp,%ebp
  801501:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801504:	8b 45 08             	mov    0x8(%ebp),%eax
  801507:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  80150a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801511:	eb 1f                	jmp    801532 <strncpy+0x34>
		*dst++ = *src;
  801513:	8b 45 08             	mov    0x8(%ebp),%eax
  801516:	8d 50 01             	lea    0x1(%eax),%edx
  801519:	89 55 08             	mov    %edx,0x8(%ebp)
  80151c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80151f:	8a 12                	mov    (%edx),%dl
  801521:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801523:	8b 45 0c             	mov    0xc(%ebp),%eax
  801526:	8a 00                	mov    (%eax),%al
  801528:	84 c0                	test   %al,%al
  80152a:	74 03                	je     80152f <strncpy+0x31>
			src++;
  80152c:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80152f:	ff 45 fc             	incl   -0x4(%ebp)
  801532:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801535:	3b 45 10             	cmp    0x10(%ebp),%eax
  801538:	72 d9                	jb     801513 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  80153a:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80153d:	c9                   	leave  
  80153e:	c3                   	ret    

0080153f <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80153f:	55                   	push   %ebp
  801540:	89 e5                	mov    %esp,%ebp
  801542:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801545:	8b 45 08             	mov    0x8(%ebp),%eax
  801548:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  80154b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80154f:	74 30                	je     801581 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801551:	eb 16                	jmp    801569 <strlcpy+0x2a>
			*dst++ = *src++;
  801553:	8b 45 08             	mov    0x8(%ebp),%eax
  801556:	8d 50 01             	lea    0x1(%eax),%edx
  801559:	89 55 08             	mov    %edx,0x8(%ebp)
  80155c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80155f:	8d 4a 01             	lea    0x1(%edx),%ecx
  801562:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801565:	8a 12                	mov    (%edx),%dl
  801567:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801569:	ff 4d 10             	decl   0x10(%ebp)
  80156c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801570:	74 09                	je     80157b <strlcpy+0x3c>
  801572:	8b 45 0c             	mov    0xc(%ebp),%eax
  801575:	8a 00                	mov    (%eax),%al
  801577:	84 c0                	test   %al,%al
  801579:	75 d8                	jne    801553 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80157b:	8b 45 08             	mov    0x8(%ebp),%eax
  80157e:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801581:	8b 55 08             	mov    0x8(%ebp),%edx
  801584:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801587:	29 c2                	sub    %eax,%edx
  801589:	89 d0                	mov    %edx,%eax
}
  80158b:	c9                   	leave  
  80158c:	c3                   	ret    

0080158d <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80158d:	55                   	push   %ebp
  80158e:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801590:	eb 06                	jmp    801598 <strcmp+0xb>
		p++, q++;
  801592:	ff 45 08             	incl   0x8(%ebp)
  801595:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801598:	8b 45 08             	mov    0x8(%ebp),%eax
  80159b:	8a 00                	mov    (%eax),%al
  80159d:	84 c0                	test   %al,%al
  80159f:	74 0e                	je     8015af <strcmp+0x22>
  8015a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a4:	8a 10                	mov    (%eax),%dl
  8015a6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a9:	8a 00                	mov    (%eax),%al
  8015ab:	38 c2                	cmp    %al,%dl
  8015ad:	74 e3                	je     801592 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8015af:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b2:	8a 00                	mov    (%eax),%al
  8015b4:	0f b6 d0             	movzbl %al,%edx
  8015b7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ba:	8a 00                	mov    (%eax),%al
  8015bc:	0f b6 c0             	movzbl %al,%eax
  8015bf:	29 c2                	sub    %eax,%edx
  8015c1:	89 d0                	mov    %edx,%eax
}
  8015c3:	5d                   	pop    %ebp
  8015c4:	c3                   	ret    

008015c5 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8015c5:	55                   	push   %ebp
  8015c6:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8015c8:	eb 09                	jmp    8015d3 <strncmp+0xe>
		n--, p++, q++;
  8015ca:	ff 4d 10             	decl   0x10(%ebp)
  8015cd:	ff 45 08             	incl   0x8(%ebp)
  8015d0:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  8015d3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015d7:	74 17                	je     8015f0 <strncmp+0x2b>
  8015d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8015dc:	8a 00                	mov    (%eax),%al
  8015de:	84 c0                	test   %al,%al
  8015e0:	74 0e                	je     8015f0 <strncmp+0x2b>
  8015e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015e5:	8a 10                	mov    (%eax),%dl
  8015e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ea:	8a 00                	mov    (%eax),%al
  8015ec:	38 c2                	cmp    %al,%dl
  8015ee:	74 da                	je     8015ca <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8015f0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8015f4:	75 07                	jne    8015fd <strncmp+0x38>
		return 0;
  8015f6:	b8 00 00 00 00       	mov    $0x0,%eax
  8015fb:	eb 14                	jmp    801611 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8015fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801600:	8a 00                	mov    (%eax),%al
  801602:	0f b6 d0             	movzbl %al,%edx
  801605:	8b 45 0c             	mov    0xc(%ebp),%eax
  801608:	8a 00                	mov    (%eax),%al
  80160a:	0f b6 c0             	movzbl %al,%eax
  80160d:	29 c2                	sub    %eax,%edx
  80160f:	89 d0                	mov    %edx,%eax
}
  801611:	5d                   	pop    %ebp
  801612:	c3                   	ret    

00801613 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
  801616:	83 ec 04             	sub    $0x4,%esp
  801619:	8b 45 0c             	mov    0xc(%ebp),%eax
  80161c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80161f:	eb 12                	jmp    801633 <strchr+0x20>
		if (*s == c)
  801621:	8b 45 08             	mov    0x8(%ebp),%eax
  801624:	8a 00                	mov    (%eax),%al
  801626:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801629:	75 05                	jne    801630 <strchr+0x1d>
			return (char *) s;
  80162b:	8b 45 08             	mov    0x8(%ebp),%eax
  80162e:	eb 11                	jmp    801641 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  801630:	ff 45 08             	incl   0x8(%ebp)
  801633:	8b 45 08             	mov    0x8(%ebp),%eax
  801636:	8a 00                	mov    (%eax),%al
  801638:	84 c0                	test   %al,%al
  80163a:	75 e5                	jne    801621 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  80163c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
  801646:	83 ec 04             	sub    $0x4,%esp
  801649:	8b 45 0c             	mov    0xc(%ebp),%eax
  80164c:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80164f:	eb 0d                	jmp    80165e <strfind+0x1b>
		if (*s == c)
  801651:	8b 45 08             	mov    0x8(%ebp),%eax
  801654:	8a 00                	mov    (%eax),%al
  801656:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801659:	74 0e                	je     801669 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80165b:	ff 45 08             	incl   0x8(%ebp)
  80165e:	8b 45 08             	mov    0x8(%ebp),%eax
  801661:	8a 00                	mov    (%eax),%al
  801663:	84 c0                	test   %al,%al
  801665:	75 ea                	jne    801651 <strfind+0xe>
  801667:	eb 01                	jmp    80166a <strfind+0x27>
		if (*s == c)
			break;
  801669:	90                   	nop
	return (char *) s;
  80166a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80166d:	c9                   	leave  
  80166e:	c3                   	ret    

0080166f <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80166f:	55                   	push   %ebp
  801670:	89 e5                	mov    %esp,%ebp
  801672:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801675:	8b 45 08             	mov    0x8(%ebp),%eax
  801678:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80167b:	8b 45 10             	mov    0x10(%ebp),%eax
  80167e:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801681:	eb 0e                	jmp    801691 <memset+0x22>
		*p++ = c;
  801683:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801686:	8d 50 01             	lea    0x1(%eax),%edx
  801689:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80168c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80168f:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801691:	ff 4d f8             	decl   -0x8(%ebp)
  801694:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801698:	79 e9                	jns    801683 <memset+0x14>
		*p++ = c;

	return v;
  80169a:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80169d:	c9                   	leave  
  80169e:	c3                   	ret    

0080169f <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80169f:	55                   	push   %ebp
  8016a0:	89 e5                	mov    %esp,%ebp
  8016a2:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016a5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016a8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ae:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8016b1:	eb 16                	jmp    8016c9 <memcpy+0x2a>
		*d++ = *s++;
  8016b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016b6:	8d 50 01             	lea    0x1(%eax),%edx
  8016b9:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016bc:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016bf:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016c2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016c5:	8a 12                	mov    (%edx),%dl
  8016c7:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8016c9:	8b 45 10             	mov    0x10(%ebp),%eax
  8016cc:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016cf:	89 55 10             	mov    %edx,0x10(%ebp)
  8016d2:	85 c0                	test   %eax,%eax
  8016d4:	75 dd                	jne    8016b3 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  8016d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016d9:	c9                   	leave  
  8016da:	c3                   	ret    

008016db <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  8016db:	55                   	push   %ebp
  8016dc:	89 e5                	mov    %esp,%ebp
  8016de:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016e7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ea:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8016ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016f0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8016f3:	73 50                	jae    801745 <memmove+0x6a>
  8016f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016fb:	01 d0                	add    %edx,%eax
  8016fd:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801700:	76 43                	jbe    801745 <memmove+0x6a>
		s += n;
  801702:	8b 45 10             	mov    0x10(%ebp),%eax
  801705:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801708:	8b 45 10             	mov    0x10(%ebp),%eax
  80170b:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80170e:	eb 10                	jmp    801720 <memmove+0x45>
			*--d = *--s;
  801710:	ff 4d f8             	decl   -0x8(%ebp)
  801713:	ff 4d fc             	decl   -0x4(%ebp)
  801716:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801719:	8a 10                	mov    (%eax),%dl
  80171b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80171e:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801720:	8b 45 10             	mov    0x10(%ebp),%eax
  801723:	8d 50 ff             	lea    -0x1(%eax),%edx
  801726:	89 55 10             	mov    %edx,0x10(%ebp)
  801729:	85 c0                	test   %eax,%eax
  80172b:	75 e3                	jne    801710 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80172d:	eb 23                	jmp    801752 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80172f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801732:	8d 50 01             	lea    0x1(%eax),%edx
  801735:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801738:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80173b:	8d 4a 01             	lea    0x1(%edx),%ecx
  80173e:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801741:	8a 12                	mov    (%edx),%dl
  801743:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801745:	8b 45 10             	mov    0x10(%ebp),%eax
  801748:	8d 50 ff             	lea    -0x1(%eax),%edx
  80174b:	89 55 10             	mov    %edx,0x10(%ebp)
  80174e:	85 c0                	test   %eax,%eax
  801750:	75 dd                	jne    80172f <memmove+0x54>
			*d++ = *s++;

	return dst;
  801752:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801755:	c9                   	leave  
  801756:	c3                   	ret    

00801757 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801757:	55                   	push   %ebp
  801758:	89 e5                	mov    %esp,%ebp
  80175a:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80175d:	8b 45 08             	mov    0x8(%ebp),%eax
  801760:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801763:	8b 45 0c             	mov    0xc(%ebp),%eax
  801766:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801769:	eb 2a                	jmp    801795 <memcmp+0x3e>
		if (*s1 != *s2)
  80176b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80176e:	8a 10                	mov    (%eax),%dl
  801770:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801773:	8a 00                	mov    (%eax),%al
  801775:	38 c2                	cmp    %al,%dl
  801777:	74 16                	je     80178f <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801779:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80177c:	8a 00                	mov    (%eax),%al
  80177e:	0f b6 d0             	movzbl %al,%edx
  801781:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801784:	8a 00                	mov    (%eax),%al
  801786:	0f b6 c0             	movzbl %al,%eax
  801789:	29 c2                	sub    %eax,%edx
  80178b:	89 d0                	mov    %edx,%eax
  80178d:	eb 18                	jmp    8017a7 <memcmp+0x50>
		s1++, s2++;
  80178f:	ff 45 fc             	incl   -0x4(%ebp)
  801792:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801795:	8b 45 10             	mov    0x10(%ebp),%eax
  801798:	8d 50 ff             	lea    -0x1(%eax),%edx
  80179b:	89 55 10             	mov    %edx,0x10(%ebp)
  80179e:	85 c0                	test   %eax,%eax
  8017a0:	75 c9                	jne    80176b <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017a2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
  8017ac:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017af:	8b 55 08             	mov    0x8(%ebp),%edx
  8017b2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017b5:	01 d0                	add    %edx,%eax
  8017b7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8017ba:	eb 15                	jmp    8017d1 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8017bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8017bf:	8a 00                	mov    (%eax),%al
  8017c1:	0f b6 d0             	movzbl %al,%edx
  8017c4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017c7:	0f b6 c0             	movzbl %al,%eax
  8017ca:	39 c2                	cmp    %eax,%edx
  8017cc:	74 0d                	je     8017db <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8017ce:	ff 45 08             	incl   0x8(%ebp)
  8017d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8017d7:	72 e3                	jb     8017bc <memfind+0x13>
  8017d9:	eb 01                	jmp    8017dc <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8017db:	90                   	nop
	return (void *) s;
  8017dc:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8017df:	c9                   	leave  
  8017e0:	c3                   	ret    

008017e1 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8017e1:	55                   	push   %ebp
  8017e2:	89 e5                	mov    %esp,%ebp
  8017e4:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8017e7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8017ee:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017f5:	eb 03                	jmp    8017fa <strtol+0x19>
		s++;
  8017f7:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8017fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8017fd:	8a 00                	mov    (%eax),%al
  8017ff:	3c 20                	cmp    $0x20,%al
  801801:	74 f4                	je     8017f7 <strtol+0x16>
  801803:	8b 45 08             	mov    0x8(%ebp),%eax
  801806:	8a 00                	mov    (%eax),%al
  801808:	3c 09                	cmp    $0x9,%al
  80180a:	74 eb                	je     8017f7 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80180c:	8b 45 08             	mov    0x8(%ebp),%eax
  80180f:	8a 00                	mov    (%eax),%al
  801811:	3c 2b                	cmp    $0x2b,%al
  801813:	75 05                	jne    80181a <strtol+0x39>
		s++;
  801815:	ff 45 08             	incl   0x8(%ebp)
  801818:	eb 13                	jmp    80182d <strtol+0x4c>
	else if (*s == '-')
  80181a:	8b 45 08             	mov    0x8(%ebp),%eax
  80181d:	8a 00                	mov    (%eax),%al
  80181f:	3c 2d                	cmp    $0x2d,%al
  801821:	75 0a                	jne    80182d <strtol+0x4c>
		s++, neg = 1;
  801823:	ff 45 08             	incl   0x8(%ebp)
  801826:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80182d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801831:	74 06                	je     801839 <strtol+0x58>
  801833:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801837:	75 20                	jne    801859 <strtol+0x78>
  801839:	8b 45 08             	mov    0x8(%ebp),%eax
  80183c:	8a 00                	mov    (%eax),%al
  80183e:	3c 30                	cmp    $0x30,%al
  801840:	75 17                	jne    801859 <strtol+0x78>
  801842:	8b 45 08             	mov    0x8(%ebp),%eax
  801845:	40                   	inc    %eax
  801846:	8a 00                	mov    (%eax),%al
  801848:	3c 78                	cmp    $0x78,%al
  80184a:	75 0d                	jne    801859 <strtol+0x78>
		s += 2, base = 16;
  80184c:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801850:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801857:	eb 28                	jmp    801881 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801859:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80185d:	75 15                	jne    801874 <strtol+0x93>
  80185f:	8b 45 08             	mov    0x8(%ebp),%eax
  801862:	8a 00                	mov    (%eax),%al
  801864:	3c 30                	cmp    $0x30,%al
  801866:	75 0c                	jne    801874 <strtol+0x93>
		s++, base = 8;
  801868:	ff 45 08             	incl   0x8(%ebp)
  80186b:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801872:	eb 0d                	jmp    801881 <strtol+0xa0>
	else if (base == 0)
  801874:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801878:	75 07                	jne    801881 <strtol+0xa0>
		base = 10;
  80187a:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801881:	8b 45 08             	mov    0x8(%ebp),%eax
  801884:	8a 00                	mov    (%eax),%al
  801886:	3c 2f                	cmp    $0x2f,%al
  801888:	7e 19                	jle    8018a3 <strtol+0xc2>
  80188a:	8b 45 08             	mov    0x8(%ebp),%eax
  80188d:	8a 00                	mov    (%eax),%al
  80188f:	3c 39                	cmp    $0x39,%al
  801891:	7f 10                	jg     8018a3 <strtol+0xc2>
			dig = *s - '0';
  801893:	8b 45 08             	mov    0x8(%ebp),%eax
  801896:	8a 00                	mov    (%eax),%al
  801898:	0f be c0             	movsbl %al,%eax
  80189b:	83 e8 30             	sub    $0x30,%eax
  80189e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018a1:	eb 42                	jmp    8018e5 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a6:	8a 00                	mov    (%eax),%al
  8018a8:	3c 60                	cmp    $0x60,%al
  8018aa:	7e 19                	jle    8018c5 <strtol+0xe4>
  8018ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8018af:	8a 00                	mov    (%eax),%al
  8018b1:	3c 7a                	cmp    $0x7a,%al
  8018b3:	7f 10                	jg     8018c5 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8018b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b8:	8a 00                	mov    (%eax),%al
  8018ba:	0f be c0             	movsbl %al,%eax
  8018bd:	83 e8 57             	sub    $0x57,%eax
  8018c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018c3:	eb 20                	jmp    8018e5 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8018c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c8:	8a 00                	mov    (%eax),%al
  8018ca:	3c 40                	cmp    $0x40,%al
  8018cc:	7e 39                	jle    801907 <strtol+0x126>
  8018ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d1:	8a 00                	mov    (%eax),%al
  8018d3:	3c 5a                	cmp    $0x5a,%al
  8018d5:	7f 30                	jg     801907 <strtol+0x126>
			dig = *s - 'A' + 10;
  8018d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018da:	8a 00                	mov    (%eax),%al
  8018dc:	0f be c0             	movsbl %al,%eax
  8018df:	83 e8 37             	sub    $0x37,%eax
  8018e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8018e5:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018e8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8018eb:	7d 19                	jge    801906 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8018ed:	ff 45 08             	incl   0x8(%ebp)
  8018f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018f3:	0f af 45 10          	imul   0x10(%ebp),%eax
  8018f7:	89 c2                	mov    %eax,%edx
  8018f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8018fc:	01 d0                	add    %edx,%eax
  8018fe:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801901:	e9 7b ff ff ff       	jmp    801881 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801906:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801907:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80190b:	74 08                	je     801915 <strtol+0x134>
		*endptr = (char *) s;
  80190d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801910:	8b 55 08             	mov    0x8(%ebp),%edx
  801913:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801915:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801919:	74 07                	je     801922 <strtol+0x141>
  80191b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80191e:	f7 d8                	neg    %eax
  801920:	eb 03                	jmp    801925 <strtol+0x144>
  801922:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <ltostr>:

void
ltostr(long value, char *str)
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
  80192a:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80192d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801934:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80193b:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80193f:	79 13                	jns    801954 <ltostr+0x2d>
	{
		neg = 1;
  801941:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801948:	8b 45 0c             	mov    0xc(%ebp),%eax
  80194b:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80194e:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801951:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801954:	8b 45 08             	mov    0x8(%ebp),%eax
  801957:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80195c:	99                   	cltd   
  80195d:	f7 f9                	idiv   %ecx
  80195f:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801962:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801965:	8d 50 01             	lea    0x1(%eax),%edx
  801968:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80196b:	89 c2                	mov    %eax,%edx
  80196d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801970:	01 d0                	add    %edx,%eax
  801972:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801975:	83 c2 30             	add    $0x30,%edx
  801978:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80197a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80197d:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801982:	f7 e9                	imul   %ecx
  801984:	c1 fa 02             	sar    $0x2,%edx
  801987:	89 c8                	mov    %ecx,%eax
  801989:	c1 f8 1f             	sar    $0x1f,%eax
  80198c:	29 c2                	sub    %eax,%edx
  80198e:	89 d0                	mov    %edx,%eax
  801990:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801993:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801996:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80199b:	f7 e9                	imul   %ecx
  80199d:	c1 fa 02             	sar    $0x2,%edx
  8019a0:	89 c8                	mov    %ecx,%eax
  8019a2:	c1 f8 1f             	sar    $0x1f,%eax
  8019a5:	29 c2                	sub    %eax,%edx
  8019a7:	89 d0                	mov    %edx,%eax
  8019a9:	c1 e0 02             	shl    $0x2,%eax
  8019ac:	01 d0                	add    %edx,%eax
  8019ae:	01 c0                	add    %eax,%eax
  8019b0:	29 c1                	sub    %eax,%ecx
  8019b2:	89 ca                	mov    %ecx,%edx
  8019b4:	85 d2                	test   %edx,%edx
  8019b6:	75 9c                	jne    801954 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019b8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019bf:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019c2:	48                   	dec    %eax
  8019c3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8019c6:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019ca:	74 3d                	je     801a09 <ltostr+0xe2>
		start = 1 ;
  8019cc:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8019d3:	eb 34                	jmp    801a09 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8019d5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019db:	01 d0                	add    %edx,%eax
  8019dd:	8a 00                	mov    (%eax),%al
  8019df:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8019e2:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8019e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019e8:	01 c2                	add    %eax,%edx
  8019ea:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8019ed:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019f0:	01 c8                	add    %ecx,%eax
  8019f2:	8a 00                	mov    (%eax),%al
  8019f4:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8019f6:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8019f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8019fc:	01 c2                	add    %eax,%edx
  8019fe:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a01:	88 02                	mov    %al,(%edx)
		start++ ;
  801a03:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a06:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a09:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a0c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a0f:	7c c4                	jl     8019d5 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a11:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a14:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a17:	01 d0                	add    %edx,%eax
  801a19:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a1c:	90                   	nop
  801a1d:	c9                   	leave  
  801a1e:	c3                   	ret    

00801a1f <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a1f:	55                   	push   %ebp
  801a20:	89 e5                	mov    %esp,%ebp
  801a22:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a25:	ff 75 08             	pushl  0x8(%ebp)
  801a28:	e8 54 fa ff ff       	call   801481 <strlen>
  801a2d:	83 c4 04             	add    $0x4,%esp
  801a30:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a33:	ff 75 0c             	pushl  0xc(%ebp)
  801a36:	e8 46 fa ff ff       	call   801481 <strlen>
  801a3b:	83 c4 04             	add    $0x4,%esp
  801a3e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a41:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a4f:	eb 17                	jmp    801a68 <strcconcat+0x49>
		final[s] = str1[s] ;
  801a51:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a54:	8b 45 10             	mov    0x10(%ebp),%eax
  801a57:	01 c2                	add    %eax,%edx
  801a59:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a5c:	8b 45 08             	mov    0x8(%ebp),%eax
  801a5f:	01 c8                	add    %ecx,%eax
  801a61:	8a 00                	mov    (%eax),%al
  801a63:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a65:	ff 45 fc             	incl   -0x4(%ebp)
  801a68:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a6b:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a6e:	7c e1                	jl     801a51 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a70:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801a77:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801a7e:	eb 1f                	jmp    801a9f <strcconcat+0x80>
		final[s++] = str2[i] ;
  801a80:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a83:	8d 50 01             	lea    0x1(%eax),%edx
  801a86:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801a89:	89 c2                	mov    %eax,%edx
  801a8b:	8b 45 10             	mov    0x10(%ebp),%eax
  801a8e:	01 c2                	add    %eax,%edx
  801a90:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801a93:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a96:	01 c8                	add    %ecx,%eax
  801a98:	8a 00                	mov    (%eax),%al
  801a9a:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801a9c:	ff 45 f8             	incl   -0x8(%ebp)
  801a9f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801aa2:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801aa5:	7c d9                	jl     801a80 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801aa7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801aaa:	8b 45 10             	mov    0x10(%ebp),%eax
  801aad:	01 d0                	add    %edx,%eax
  801aaf:	c6 00 00             	movb   $0x0,(%eax)
}
  801ab2:	90                   	nop
  801ab3:	c9                   	leave  
  801ab4:	c3                   	ret    

00801ab5 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ab5:	55                   	push   %ebp
  801ab6:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801ab8:	8b 45 14             	mov    0x14(%ebp),%eax
  801abb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801ac1:	8b 45 14             	mov    0x14(%ebp),%eax
  801ac4:	8b 00                	mov    (%eax),%eax
  801ac6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801acd:	8b 45 10             	mov    0x10(%ebp),%eax
  801ad0:	01 d0                	add    %edx,%eax
  801ad2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801ad8:	eb 0c                	jmp    801ae6 <strsplit+0x31>
			*string++ = 0;
  801ada:	8b 45 08             	mov    0x8(%ebp),%eax
  801add:	8d 50 01             	lea    0x1(%eax),%edx
  801ae0:	89 55 08             	mov    %edx,0x8(%ebp)
  801ae3:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801ae6:	8b 45 08             	mov    0x8(%ebp),%eax
  801ae9:	8a 00                	mov    (%eax),%al
  801aeb:	84 c0                	test   %al,%al
  801aed:	74 18                	je     801b07 <strsplit+0x52>
  801aef:	8b 45 08             	mov    0x8(%ebp),%eax
  801af2:	8a 00                	mov    (%eax),%al
  801af4:	0f be c0             	movsbl %al,%eax
  801af7:	50                   	push   %eax
  801af8:	ff 75 0c             	pushl  0xc(%ebp)
  801afb:	e8 13 fb ff ff       	call   801613 <strchr>
  801b00:	83 c4 08             	add    $0x8,%esp
  801b03:	85 c0                	test   %eax,%eax
  801b05:	75 d3                	jne    801ada <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801b07:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0a:	8a 00                	mov    (%eax),%al
  801b0c:	84 c0                	test   %al,%al
  801b0e:	74 5a                	je     801b6a <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801b10:	8b 45 14             	mov    0x14(%ebp),%eax
  801b13:	8b 00                	mov    (%eax),%eax
  801b15:	83 f8 0f             	cmp    $0xf,%eax
  801b18:	75 07                	jne    801b21 <strsplit+0x6c>
		{
			return 0;
  801b1a:	b8 00 00 00 00       	mov    $0x0,%eax
  801b1f:	eb 66                	jmp    801b87 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b21:	8b 45 14             	mov    0x14(%ebp),%eax
  801b24:	8b 00                	mov    (%eax),%eax
  801b26:	8d 48 01             	lea    0x1(%eax),%ecx
  801b29:	8b 55 14             	mov    0x14(%ebp),%edx
  801b2c:	89 0a                	mov    %ecx,(%edx)
  801b2e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b35:	8b 45 10             	mov    0x10(%ebp),%eax
  801b38:	01 c2                	add    %eax,%edx
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b3f:	eb 03                	jmp    801b44 <strsplit+0x8f>
			string++;
  801b41:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b44:	8b 45 08             	mov    0x8(%ebp),%eax
  801b47:	8a 00                	mov    (%eax),%al
  801b49:	84 c0                	test   %al,%al
  801b4b:	74 8b                	je     801ad8 <strsplit+0x23>
  801b4d:	8b 45 08             	mov    0x8(%ebp),%eax
  801b50:	8a 00                	mov    (%eax),%al
  801b52:	0f be c0             	movsbl %al,%eax
  801b55:	50                   	push   %eax
  801b56:	ff 75 0c             	pushl  0xc(%ebp)
  801b59:	e8 b5 fa ff ff       	call   801613 <strchr>
  801b5e:	83 c4 08             	add    $0x8,%esp
  801b61:	85 c0                	test   %eax,%eax
  801b63:	74 dc                	je     801b41 <strsplit+0x8c>
			string++;
	}
  801b65:	e9 6e ff ff ff       	jmp    801ad8 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b6a:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b6b:	8b 45 14             	mov    0x14(%ebp),%eax
  801b6e:	8b 00                	mov    (%eax),%eax
  801b70:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b77:	8b 45 10             	mov    0x10(%ebp),%eax
  801b7a:	01 d0                	add    %edx,%eax
  801b7c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801b82:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801b87:	c9                   	leave  
  801b88:	c3                   	ret    

00801b89 <ClearNodeData>:
 * inside the user heap
 */

struct BuddyNode FreeNodes[BUDDY_NUM_FREE_NODES];
void ClearNodeData(struct BuddyNode* node)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
	node->level = 0;
  801b8c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b8f:	c6 40 11 00          	movb   $0x0,0x11(%eax)
	node->status = FREE;
  801b93:	8b 45 08             	mov    0x8(%ebp),%eax
  801b96:	c6 40 10 00          	movb   $0x0,0x10(%eax)
	node->va = 0;
  801b9a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b9d:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
	node->parent = NULL;
  801ba4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ba7:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
	node->myBuddy = NULL;
  801bae:	8b 45 08             	mov    0x8(%ebp),%eax
  801bb1:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
}
  801bb8:	90                   	nop
  801bb9:	5d                   	pop    %ebp
  801bba:	c3                   	ret    

00801bbb <initialize_buddy>:

void initialize_buddy()
{
  801bbb:	55                   	push   %ebp
  801bbc:	89 e5                	mov    %esp,%ebp
  801bbe:	83 ec 10             	sub    $0x10,%esp
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801bc1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801bc8:	e9 b7 00 00 00       	jmp    801c84 <initialize_buddy+0xc9>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
  801bcd:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801bd3:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801bd6:	89 c8                	mov    %ecx,%eax
  801bd8:	01 c0                	add    %eax,%eax
  801bda:	01 c8                	add    %ecx,%eax
  801bdc:	c1 e0 03             	shl    $0x3,%eax
  801bdf:	05 1c 31 80 00       	add    $0x80311c,%eax
  801be4:	89 10                	mov    %edx,(%eax)
  801be6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801be9:	89 d0                	mov    %edx,%eax
  801beb:	01 c0                	add    %eax,%eax
  801bed:	01 d0                	add    %edx,%eax
  801bef:	c1 e0 03             	shl    $0x3,%eax
  801bf2:	05 1c 31 80 00       	add    $0x80311c,%eax
  801bf7:	8b 00                	mov    (%eax),%eax
  801bf9:	85 c0                	test   %eax,%eax
  801bfb:	74 1c                	je     801c19 <initialize_buddy+0x5e>
  801bfd:	8b 15 04 31 80 00    	mov    0x803104,%edx
  801c03:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801c06:	89 c8                	mov    %ecx,%eax
  801c08:	01 c0                	add    %eax,%eax
  801c0a:	01 c8                	add    %ecx,%eax
  801c0c:	c1 e0 03             	shl    $0x3,%eax
  801c0f:	05 1c 31 80 00       	add    $0x80311c,%eax
  801c14:	89 42 04             	mov    %eax,0x4(%edx)
  801c17:	eb 16                	jmp    801c2f <initialize_buddy+0x74>
  801c19:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c1c:	89 d0                	mov    %edx,%eax
  801c1e:	01 c0                	add    %eax,%eax
  801c20:	01 d0                	add    %edx,%eax
  801c22:	c1 e0 03             	shl    $0x3,%eax
  801c25:	05 1c 31 80 00       	add    $0x80311c,%eax
  801c2a:	a3 08 31 80 00       	mov    %eax,0x803108
  801c2f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c32:	89 d0                	mov    %edx,%eax
  801c34:	01 c0                	add    %eax,%eax
  801c36:	01 d0                	add    %edx,%eax
  801c38:	c1 e0 03             	shl    $0x3,%eax
  801c3b:	05 1c 31 80 00       	add    $0x80311c,%eax
  801c40:	a3 04 31 80 00       	mov    %eax,0x803104
  801c45:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c48:	89 d0                	mov    %edx,%eax
  801c4a:	01 c0                	add    %eax,%eax
  801c4c:	01 d0                	add    %edx,%eax
  801c4e:	c1 e0 03             	shl    $0x3,%eax
  801c51:	05 20 31 80 00       	add    $0x803120,%eax
  801c56:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  801c5c:	a1 10 31 80 00       	mov    0x803110,%eax
  801c61:	40                   	inc    %eax
  801c62:	a3 10 31 80 00       	mov    %eax,0x803110
		ClearNodeData(&(FreeNodes[i]));
  801c67:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801c6a:	89 d0                	mov    %edx,%eax
  801c6c:	01 c0                	add    %eax,%eax
  801c6e:	01 d0                	add    %edx,%eax
  801c70:	c1 e0 03             	shl    $0x3,%eax
  801c73:	05 1c 31 80 00       	add    $0x80311c,%eax
  801c78:	50                   	push   %eax
  801c79:	e8 0b ff ff ff       	call   801b89 <ClearNodeData>
  801c7e:	83 c4 04             	add    $0x4,%esp
	node->myBuddy = NULL;
}

void initialize_buddy()
{
	for (int i = 0; i < BUDDY_NUM_FREE_NODES; ++i)
  801c81:	ff 45 fc             	incl   -0x4(%ebp)
  801c84:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801c88:	0f 8e 3f ff ff ff    	jle    801bcd <initialize_buddy+0x12>
	{
		LIST_INSERT_HEAD(&BuddyFreeNodesList, &(FreeNodes[i]));
		ClearNodeData(&(FreeNodes[i]));
	}
}
  801c8e:	90                   	nop
  801c8f:	c9                   	leave  
  801c90:	c3                   	ret    

00801c91 <CreateNewBuddySpace>:

/*===============================================================*/

void CreateNewBuddySpace()
{
  801c91:	55                   	push   %ebp
  801c92:	89 e5                	mov    %esp,%ebp
  801c94:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("CreateNewBuddySpace() is not implemented yet...!!");
  801c97:	83 ec 04             	sub    $0x4,%esp
  801c9a:	68 84 2d 80 00       	push   $0x802d84
  801c9f:	6a 1f                	push   $0x1f
  801ca1:	68 b6 2d 80 00       	push   $0x802db6
  801ca6:	e8 9a ec ff ff       	call   800945 <_panic>

00801cab <FindAllocationUsingBuddy>:

}

void* FindAllocationUsingBuddy(int size)
{
  801cab:	55                   	push   %ebp
  801cac:	89 e5                	mov    %esp,%ebp
  801cae:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FindAllocationUsingBuddy() is not implemented yet...!!");
  801cb1:	83 ec 04             	sub    $0x4,%esp
  801cb4:	68 c4 2d 80 00       	push   $0x802dc4
  801cb9:	6a 26                	push   $0x26
  801cbb:	68 b6 2d 80 00       	push   $0x802db6
  801cc0:	e8 80 ec ff ff       	call   800945 <_panic>

00801cc5 <FreeAllocationUsingBuddy>:
}

void FreeAllocationUsingBuddy(uint32 va)
{
  801cc5:	55                   	push   %ebp
  801cc6:	89 e5                	mov    %esp,%ebp
  801cc8:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("FreeAllocationUsingBuddy() is not implemented yet...!!");
  801ccb:	83 ec 04             	sub    $0x4,%esp
  801cce:	68 fc 2d 80 00       	push   $0x802dfc
  801cd3:	6a 2c                	push   $0x2c
  801cd5:	68 b6 2d 80 00       	push   $0x802db6
  801cda:	e8 66 ec ff ff       	call   800945 <_panic>

00801cdf <__new>:

}
/*===============================================================*/
void* lastAlloc = (void*) USER_HEAP_START ;
void* __new(uint32 size)
{
  801cdf:	55                   	push   %ebp
  801ce0:	89 e5                	mov    %esp,%ebp
  801ce2:	83 ec 18             	sub    $0x18,%esp
	void* va = lastAlloc;
  801ce5:	a1 04 30 80 00       	mov    0x803004,%eax
  801cea:	89 45 f4             	mov    %eax,-0xc(%ebp)
	size = ROUNDUP(size, PAGE_SIZE) ;
  801ced:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
  801cf4:	8b 55 08             	mov    0x8(%ebp),%edx
  801cf7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801cfa:	01 d0                	add    %edx,%eax
  801cfc:	48                   	dec    %eax
  801cfd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801d00:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d03:	ba 00 00 00 00       	mov    $0x0,%edx
  801d08:	f7 75 f0             	divl   -0x10(%ebp)
  801d0b:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801d0e:	29 d0                	sub    %edx,%eax
  801d10:	89 45 08             	mov    %eax,0x8(%ebp)
	sys_new((uint32)va, size) ;
  801d13:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801d16:	83 ec 08             	sub    $0x8,%esp
  801d19:	ff 75 08             	pushl  0x8(%ebp)
  801d1c:	50                   	push   %eax
  801d1d:	e8 75 06 00 00       	call   802397 <sys_new>
  801d22:	83 c4 10             	add    $0x10,%esp
	lastAlloc += size ;
  801d25:	8b 15 04 30 80 00    	mov    0x803004,%edx
  801d2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801d2e:	01 d0                	add    %edx,%eax
  801d30:	a3 04 30 80 00       	mov    %eax,0x803004
	return va ;
  801d35:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801d38:	c9                   	leave  
  801d39:	c3                   	ret    

00801d3a <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801d3a:	55                   	push   %ebp
  801d3b:	89 e5                	mov    %esp,%ebp
  801d3d:	57                   	push   %edi
  801d3e:	56                   	push   %esi
  801d3f:	53                   	push   %ebx
  801d40:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801d43:	8b 45 08             	mov    0x8(%ebp),%eax
  801d46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d49:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d4c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d4f:	8b 7d 18             	mov    0x18(%ebp),%edi
  801d52:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801d55:	cd 30                	int    $0x30
  801d57:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801d5a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801d5d:	83 c4 10             	add    $0x10,%esp
  801d60:	5b                   	pop    %ebx
  801d61:	5e                   	pop    %esi
  801d62:	5f                   	pop    %edi
  801d63:	5d                   	pop    %ebp
  801d64:	c3                   	ret    

00801d65 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801d65:	55                   	push   %ebp
  801d66:	89 e5                	mov    %esp,%ebp
  801d68:	83 ec 04             	sub    $0x4,%esp
  801d6b:	8b 45 10             	mov    0x10(%ebp),%eax
  801d6e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801d71:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801d75:	8b 45 08             	mov    0x8(%ebp),%eax
  801d78:	6a 00                	push   $0x0
  801d7a:	6a 00                	push   $0x0
  801d7c:	52                   	push   %edx
  801d7d:	ff 75 0c             	pushl  0xc(%ebp)
  801d80:	50                   	push   %eax
  801d81:	6a 00                	push   $0x0
  801d83:	e8 b2 ff ff ff       	call   801d3a <syscall>
  801d88:	83 c4 18             	add    $0x18,%esp
}
  801d8b:	90                   	nop
  801d8c:	c9                   	leave  
  801d8d:	c3                   	ret    

00801d8e <sys_cgetc>:

int
sys_cgetc(void)
{
  801d8e:	55                   	push   %ebp
  801d8f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801d91:	6a 00                	push   $0x0
  801d93:	6a 00                	push   $0x0
  801d95:	6a 00                	push   $0x0
  801d97:	6a 00                	push   $0x0
  801d99:	6a 00                	push   $0x0
  801d9b:	6a 01                	push   $0x1
  801d9d:	e8 98 ff ff ff       	call   801d3a <syscall>
  801da2:	83 c4 18             	add    $0x18,%esp
}
  801da5:	c9                   	leave  
  801da6:	c3                   	ret    

00801da7 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801da7:	55                   	push   %ebp
  801da8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801daa:	8b 45 08             	mov    0x8(%ebp),%eax
  801dad:	6a 00                	push   $0x0
  801daf:	6a 00                	push   $0x0
  801db1:	6a 00                	push   $0x0
  801db3:	6a 00                	push   $0x0
  801db5:	50                   	push   %eax
  801db6:	6a 05                	push   $0x5
  801db8:	e8 7d ff ff ff       	call   801d3a <syscall>
  801dbd:	83 c4 18             	add    $0x18,%esp
}
  801dc0:	c9                   	leave  
  801dc1:	c3                   	ret    

00801dc2 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801dc2:	55                   	push   %ebp
  801dc3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801dc5:	6a 00                	push   $0x0
  801dc7:	6a 00                	push   $0x0
  801dc9:	6a 00                	push   $0x0
  801dcb:	6a 00                	push   $0x0
  801dcd:	6a 00                	push   $0x0
  801dcf:	6a 02                	push   $0x2
  801dd1:	e8 64 ff ff ff       	call   801d3a <syscall>
  801dd6:	83 c4 18             	add    $0x18,%esp
}
  801dd9:	c9                   	leave  
  801dda:	c3                   	ret    

00801ddb <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801ddb:	55                   	push   %ebp
  801ddc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801dde:	6a 00                	push   $0x0
  801de0:	6a 00                	push   $0x0
  801de2:	6a 00                	push   $0x0
  801de4:	6a 00                	push   $0x0
  801de6:	6a 00                	push   $0x0
  801de8:	6a 03                	push   $0x3
  801dea:	e8 4b ff ff ff       	call   801d3a <syscall>
  801def:	83 c4 18             	add    $0x18,%esp
}
  801df2:	c9                   	leave  
  801df3:	c3                   	ret    

00801df4 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801df4:	55                   	push   %ebp
  801df5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801df7:	6a 00                	push   $0x0
  801df9:	6a 00                	push   $0x0
  801dfb:	6a 00                	push   $0x0
  801dfd:	6a 00                	push   $0x0
  801dff:	6a 00                	push   $0x0
  801e01:	6a 04                	push   $0x4
  801e03:	e8 32 ff ff ff       	call   801d3a <syscall>
  801e08:	83 c4 18             	add    $0x18,%esp
}
  801e0b:	c9                   	leave  
  801e0c:	c3                   	ret    

00801e0d <sys_env_exit>:


void sys_env_exit(void)
{
  801e0d:	55                   	push   %ebp
  801e0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801e10:	6a 00                	push   $0x0
  801e12:	6a 00                	push   $0x0
  801e14:	6a 00                	push   $0x0
  801e16:	6a 00                	push   $0x0
  801e18:	6a 00                	push   $0x0
  801e1a:	6a 06                	push   $0x6
  801e1c:	e8 19 ff ff ff       	call   801d3a <syscall>
  801e21:	83 c4 18             	add    $0x18,%esp
}
  801e24:	90                   	nop
  801e25:	c9                   	leave  
  801e26:	c3                   	ret    

00801e27 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801e27:	55                   	push   %ebp
  801e28:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801e2a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	52                   	push   %edx
  801e37:	50                   	push   %eax
  801e38:	6a 07                	push   $0x7
  801e3a:	e8 fb fe ff ff       	call   801d3a <syscall>
  801e3f:	83 c4 18             	add    $0x18,%esp
}
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
  801e47:	56                   	push   %esi
  801e48:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801e49:	8b 75 18             	mov    0x18(%ebp),%esi
  801e4c:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801e4f:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801e52:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e55:	8b 45 08             	mov    0x8(%ebp),%eax
  801e58:	56                   	push   %esi
  801e59:	53                   	push   %ebx
  801e5a:	51                   	push   %ecx
  801e5b:	52                   	push   %edx
  801e5c:	50                   	push   %eax
  801e5d:	6a 08                	push   $0x8
  801e5f:	e8 d6 fe ff ff       	call   801d3a <syscall>
  801e64:	83 c4 18             	add    $0x18,%esp
}
  801e67:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801e6a:	5b                   	pop    %ebx
  801e6b:	5e                   	pop    %esi
  801e6c:	5d                   	pop    %ebp
  801e6d:	c3                   	ret    

00801e6e <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801e6e:	55                   	push   %ebp
  801e6f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801e71:	8b 55 0c             	mov    0xc(%ebp),%edx
  801e74:	8b 45 08             	mov    0x8(%ebp),%eax
  801e77:	6a 00                	push   $0x0
  801e79:	6a 00                	push   $0x0
  801e7b:	6a 00                	push   $0x0
  801e7d:	52                   	push   %edx
  801e7e:	50                   	push   %eax
  801e7f:	6a 09                	push   $0x9
  801e81:	e8 b4 fe ff ff       	call   801d3a <syscall>
  801e86:	83 c4 18             	add    $0x18,%esp
}
  801e89:	c9                   	leave  
  801e8a:	c3                   	ret    

00801e8b <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801e8b:	55                   	push   %ebp
  801e8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801e8e:	6a 00                	push   $0x0
  801e90:	6a 00                	push   $0x0
  801e92:	6a 00                	push   $0x0
  801e94:	ff 75 0c             	pushl  0xc(%ebp)
  801e97:	ff 75 08             	pushl  0x8(%ebp)
  801e9a:	6a 0a                	push   $0xa
  801e9c:	e8 99 fe ff ff       	call   801d3a <syscall>
  801ea1:	83 c4 18             	add    $0x18,%esp
}
  801ea4:	c9                   	leave  
  801ea5:	c3                   	ret    

00801ea6 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801ea6:	55                   	push   %ebp
  801ea7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801ea9:	6a 00                	push   $0x0
  801eab:	6a 00                	push   $0x0
  801ead:	6a 00                	push   $0x0
  801eaf:	6a 00                	push   $0x0
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 0b                	push   $0xb
  801eb5:	e8 80 fe ff ff       	call   801d3a <syscall>
  801eba:	83 c4 18             	add    $0x18,%esp
}
  801ebd:	c9                   	leave  
  801ebe:	c3                   	ret    

00801ebf <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801ebf:	55                   	push   %ebp
  801ec0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801ec2:	6a 00                	push   $0x0
  801ec4:	6a 00                	push   $0x0
  801ec6:	6a 00                	push   $0x0
  801ec8:	6a 00                	push   $0x0
  801eca:	6a 00                	push   $0x0
  801ecc:	6a 0c                	push   $0xc
  801ece:	e8 67 fe ff ff       	call   801d3a <syscall>
  801ed3:	83 c4 18             	add    $0x18,%esp
}
  801ed6:	c9                   	leave  
  801ed7:	c3                   	ret    

00801ed8 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801ed8:	55                   	push   %ebp
  801ed9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801edb:	6a 00                	push   $0x0
  801edd:	6a 00                	push   $0x0
  801edf:	6a 00                	push   $0x0
  801ee1:	6a 00                	push   $0x0
  801ee3:	6a 00                	push   $0x0
  801ee5:	6a 0d                	push   $0xd
  801ee7:	e8 4e fe ff ff       	call   801d3a <syscall>
  801eec:	83 c4 18             	add    $0x18,%esp
}
  801eef:	c9                   	leave  
  801ef0:	c3                   	ret    

00801ef1 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801ef1:	55                   	push   %ebp
  801ef2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801ef4:	6a 00                	push   $0x0
  801ef6:	6a 00                	push   $0x0
  801ef8:	6a 00                	push   $0x0
  801efa:	ff 75 0c             	pushl  0xc(%ebp)
  801efd:	ff 75 08             	pushl  0x8(%ebp)
  801f00:	6a 11                	push   $0x11
  801f02:	e8 33 fe ff ff       	call   801d3a <syscall>
  801f07:	83 c4 18             	add    $0x18,%esp
	return;
  801f0a:	90                   	nop
}
  801f0b:	c9                   	leave  
  801f0c:	c3                   	ret    

00801f0d <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801f0d:	55                   	push   %ebp
  801f0e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801f10:	6a 00                	push   $0x0
  801f12:	6a 00                	push   $0x0
  801f14:	6a 00                	push   $0x0
  801f16:	ff 75 0c             	pushl  0xc(%ebp)
  801f19:	ff 75 08             	pushl  0x8(%ebp)
  801f1c:	6a 12                	push   $0x12
  801f1e:	e8 17 fe ff ff       	call   801d3a <syscall>
  801f23:	83 c4 18             	add    $0x18,%esp
	return ;
  801f26:	90                   	nop
}
  801f27:	c9                   	leave  
  801f28:	c3                   	ret    

00801f29 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801f29:	55                   	push   %ebp
  801f2a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801f2c:	6a 00                	push   $0x0
  801f2e:	6a 00                	push   $0x0
  801f30:	6a 00                	push   $0x0
  801f32:	6a 00                	push   $0x0
  801f34:	6a 00                	push   $0x0
  801f36:	6a 0e                	push   $0xe
  801f38:	e8 fd fd ff ff       	call   801d3a <syscall>
  801f3d:	83 c4 18             	add    $0x18,%esp
}
  801f40:	c9                   	leave  
  801f41:	c3                   	ret    

00801f42 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801f42:	55                   	push   %ebp
  801f43:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 00                	push   $0x0
  801f4b:	6a 00                	push   $0x0
  801f4d:	ff 75 08             	pushl  0x8(%ebp)
  801f50:	6a 0f                	push   $0xf
  801f52:	e8 e3 fd ff ff       	call   801d3a <syscall>
  801f57:	83 c4 18             	add    $0x18,%esp
}
  801f5a:	c9                   	leave  
  801f5b:	c3                   	ret    

00801f5c <sys_scarce_memory>:

void sys_scarce_memory()
{
  801f5c:	55                   	push   %ebp
  801f5d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801f5f:	6a 00                	push   $0x0
  801f61:	6a 00                	push   $0x0
  801f63:	6a 00                	push   $0x0
  801f65:	6a 00                	push   $0x0
  801f67:	6a 00                	push   $0x0
  801f69:	6a 10                	push   $0x10
  801f6b:	e8 ca fd ff ff       	call   801d3a <syscall>
  801f70:	83 c4 18             	add    $0x18,%esp
}
  801f73:	90                   	nop
  801f74:	c9                   	leave  
  801f75:	c3                   	ret    

00801f76 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801f76:	55                   	push   %ebp
  801f77:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801f79:	6a 00                	push   $0x0
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	6a 00                	push   $0x0
  801f83:	6a 14                	push   $0x14
  801f85:	e8 b0 fd ff ff       	call   801d3a <syscall>
  801f8a:	83 c4 18             	add    $0x18,%esp
}
  801f8d:	90                   	nop
  801f8e:	c9                   	leave  
  801f8f:	c3                   	ret    

00801f90 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801f90:	55                   	push   %ebp
  801f91:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801f93:	6a 00                	push   $0x0
  801f95:	6a 00                	push   $0x0
  801f97:	6a 00                	push   $0x0
  801f99:	6a 00                	push   $0x0
  801f9b:	6a 00                	push   $0x0
  801f9d:	6a 15                	push   $0x15
  801f9f:	e8 96 fd ff ff       	call   801d3a <syscall>
  801fa4:	83 c4 18             	add    $0x18,%esp
}
  801fa7:	90                   	nop
  801fa8:	c9                   	leave  
  801fa9:	c3                   	ret    

00801faa <sys_cputc>:


void
sys_cputc(const char c)
{
  801faa:	55                   	push   %ebp
  801fab:	89 e5                	mov    %esp,%ebp
  801fad:	83 ec 04             	sub    $0x4,%esp
  801fb0:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb3:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801fb6:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801fba:	6a 00                	push   $0x0
  801fbc:	6a 00                	push   $0x0
  801fbe:	6a 00                	push   $0x0
  801fc0:	6a 00                	push   $0x0
  801fc2:	50                   	push   %eax
  801fc3:	6a 16                	push   $0x16
  801fc5:	e8 70 fd ff ff       	call   801d3a <syscall>
  801fca:	83 c4 18             	add    $0x18,%esp
}
  801fcd:	90                   	nop
  801fce:	c9                   	leave  
  801fcf:	c3                   	ret    

00801fd0 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801fd0:	55                   	push   %ebp
  801fd1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801fd3:	6a 00                	push   $0x0
  801fd5:	6a 00                	push   $0x0
  801fd7:	6a 00                	push   $0x0
  801fd9:	6a 00                	push   $0x0
  801fdb:	6a 00                	push   $0x0
  801fdd:	6a 17                	push   $0x17
  801fdf:	e8 56 fd ff ff       	call   801d3a <syscall>
  801fe4:	83 c4 18             	add    $0x18,%esp
}
  801fe7:	90                   	nop
  801fe8:	c9                   	leave  
  801fe9:	c3                   	ret    

00801fea <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801fea:	55                   	push   %ebp
  801feb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801fed:	8b 45 08             	mov    0x8(%ebp),%eax
  801ff0:	6a 00                	push   $0x0
  801ff2:	6a 00                	push   $0x0
  801ff4:	6a 00                	push   $0x0
  801ff6:	ff 75 0c             	pushl  0xc(%ebp)
  801ff9:	50                   	push   %eax
  801ffa:	6a 18                	push   $0x18
  801ffc:	e8 39 fd ff ff       	call   801d3a <syscall>
  802001:	83 c4 18             	add    $0x18,%esp
}
  802004:	c9                   	leave  
  802005:	c3                   	ret    

00802006 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  802006:	55                   	push   %ebp
  802007:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802009:	8b 55 0c             	mov    0xc(%ebp),%edx
  80200c:	8b 45 08             	mov    0x8(%ebp),%eax
  80200f:	6a 00                	push   $0x0
  802011:	6a 00                	push   $0x0
  802013:	6a 00                	push   $0x0
  802015:	52                   	push   %edx
  802016:	50                   	push   %eax
  802017:	6a 1b                	push   $0x1b
  802019:	e8 1c fd ff ff       	call   801d3a <syscall>
  80201e:	83 c4 18             	add    $0x18,%esp
}
  802021:	c9                   	leave  
  802022:	c3                   	ret    

00802023 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802023:	55                   	push   %ebp
  802024:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802026:	8b 55 0c             	mov    0xc(%ebp),%edx
  802029:	8b 45 08             	mov    0x8(%ebp),%eax
  80202c:	6a 00                	push   $0x0
  80202e:	6a 00                	push   $0x0
  802030:	6a 00                	push   $0x0
  802032:	52                   	push   %edx
  802033:	50                   	push   %eax
  802034:	6a 19                	push   $0x19
  802036:	e8 ff fc ff ff       	call   801d3a <syscall>
  80203b:	83 c4 18             	add    $0x18,%esp
}
  80203e:	90                   	nop
  80203f:	c9                   	leave  
  802040:	c3                   	ret    

00802041 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  802041:	55                   	push   %ebp
  802042:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  802044:	8b 55 0c             	mov    0xc(%ebp),%edx
  802047:	8b 45 08             	mov    0x8(%ebp),%eax
  80204a:	6a 00                	push   $0x0
  80204c:	6a 00                	push   $0x0
  80204e:	6a 00                	push   $0x0
  802050:	52                   	push   %edx
  802051:	50                   	push   %eax
  802052:	6a 1a                	push   $0x1a
  802054:	e8 e1 fc ff ff       	call   801d3a <syscall>
  802059:	83 c4 18             	add    $0x18,%esp
}
  80205c:	90                   	nop
  80205d:	c9                   	leave  
  80205e:	c3                   	ret    

0080205f <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  80205f:	55                   	push   %ebp
  802060:	89 e5                	mov    %esp,%ebp
  802062:	83 ec 04             	sub    $0x4,%esp
  802065:	8b 45 10             	mov    0x10(%ebp),%eax
  802068:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  80206b:	8b 4d 14             	mov    0x14(%ebp),%ecx
  80206e:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  802072:	8b 45 08             	mov    0x8(%ebp),%eax
  802075:	6a 00                	push   $0x0
  802077:	51                   	push   %ecx
  802078:	52                   	push   %edx
  802079:	ff 75 0c             	pushl  0xc(%ebp)
  80207c:	50                   	push   %eax
  80207d:	6a 1c                	push   $0x1c
  80207f:	e8 b6 fc ff ff       	call   801d3a <syscall>
  802084:	83 c4 18             	add    $0x18,%esp
}
  802087:	c9                   	leave  
  802088:	c3                   	ret    

00802089 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  802089:	55                   	push   %ebp
  80208a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  80208c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80208f:	8b 45 08             	mov    0x8(%ebp),%eax
  802092:	6a 00                	push   $0x0
  802094:	6a 00                	push   $0x0
  802096:	6a 00                	push   $0x0
  802098:	52                   	push   %edx
  802099:	50                   	push   %eax
  80209a:	6a 1d                	push   $0x1d
  80209c:	e8 99 fc ff ff       	call   801d3a <syscall>
  8020a1:	83 c4 18             	add    $0x18,%esp
}
  8020a4:	c9                   	leave  
  8020a5:	c3                   	ret    

008020a6 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8020a6:	55                   	push   %ebp
  8020a7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8020a9:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8020ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020af:	8b 45 08             	mov    0x8(%ebp),%eax
  8020b2:	6a 00                	push   $0x0
  8020b4:	6a 00                	push   $0x0
  8020b6:	51                   	push   %ecx
  8020b7:	52                   	push   %edx
  8020b8:	50                   	push   %eax
  8020b9:	6a 1e                	push   $0x1e
  8020bb:	e8 7a fc ff ff       	call   801d3a <syscall>
  8020c0:	83 c4 18             	add    $0x18,%esp
}
  8020c3:	c9                   	leave  
  8020c4:	c3                   	ret    

008020c5 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8020c5:	55                   	push   %ebp
  8020c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  8020c8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8020cb:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	6a 00                	push   $0x0
  8020d4:	52                   	push   %edx
  8020d5:	50                   	push   %eax
  8020d6:	6a 1f                	push   $0x1f
  8020d8:	e8 5d fc ff ff       	call   801d3a <syscall>
  8020dd:	83 c4 18             	add    $0x18,%esp
}
  8020e0:	c9                   	leave  
  8020e1:	c3                   	ret    

008020e2 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  8020e2:	55                   	push   %ebp
  8020e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  8020e5:	6a 00                	push   $0x0
  8020e7:	6a 00                	push   $0x0
  8020e9:	6a 00                	push   $0x0
  8020eb:	6a 00                	push   $0x0
  8020ed:	6a 00                	push   $0x0
  8020ef:	6a 20                	push   $0x20
  8020f1:	e8 44 fc ff ff       	call   801d3a <syscall>
  8020f6:	83 c4 18             	add    $0x18,%esp
}
  8020f9:	c9                   	leave  
  8020fa:	c3                   	ret    

008020fb <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8020fb:	55                   	push   %ebp
  8020fc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8020fe:	8b 45 08             	mov    0x8(%ebp),%eax
  802101:	6a 00                	push   $0x0
  802103:	ff 75 14             	pushl  0x14(%ebp)
  802106:	ff 75 10             	pushl  0x10(%ebp)
  802109:	ff 75 0c             	pushl  0xc(%ebp)
  80210c:	50                   	push   %eax
  80210d:	6a 21                	push   $0x21
  80210f:	e8 26 fc ff ff       	call   801d3a <syscall>
  802114:	83 c4 18             	add    $0x18,%esp
}
  802117:	c9                   	leave  
  802118:	c3                   	ret    

00802119 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802119:	55                   	push   %ebp
  80211a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80211c:	8b 45 08             	mov    0x8(%ebp),%eax
  80211f:	6a 00                	push   $0x0
  802121:	6a 00                	push   $0x0
  802123:	6a 00                	push   $0x0
  802125:	6a 00                	push   $0x0
  802127:	50                   	push   %eax
  802128:	6a 22                	push   $0x22
  80212a:	e8 0b fc ff ff       	call   801d3a <syscall>
  80212f:	83 c4 18             	add    $0x18,%esp
}
  802132:	90                   	nop
  802133:	c9                   	leave  
  802134:	c3                   	ret    

00802135 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  802135:	55                   	push   %ebp
  802136:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  802138:	8b 45 08             	mov    0x8(%ebp),%eax
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	6a 00                	push   $0x0
  802143:	50                   	push   %eax
  802144:	6a 23                	push   $0x23
  802146:	e8 ef fb ff ff       	call   801d3a <syscall>
  80214b:	83 c4 18             	add    $0x18,%esp
}
  80214e:	90                   	nop
  80214f:	c9                   	leave  
  802150:	c3                   	ret    

00802151 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  802151:	55                   	push   %ebp
  802152:	89 e5                	mov    %esp,%ebp
  802154:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  802157:	8d 45 f8             	lea    -0x8(%ebp),%eax
  80215a:	8d 50 04             	lea    0x4(%eax),%edx
  80215d:	8d 45 f8             	lea    -0x8(%ebp),%eax
  802160:	6a 00                	push   $0x0
  802162:	6a 00                	push   $0x0
  802164:	6a 00                	push   $0x0
  802166:	52                   	push   %edx
  802167:	50                   	push   %eax
  802168:	6a 24                	push   $0x24
  80216a:	e8 cb fb ff ff       	call   801d3a <syscall>
  80216f:	83 c4 18             	add    $0x18,%esp
	return result;
  802172:	8b 4d 08             	mov    0x8(%ebp),%ecx
  802175:	8b 45 f8             	mov    -0x8(%ebp),%eax
  802178:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80217b:	89 01                	mov    %eax,(%ecx)
  80217d:	89 51 04             	mov    %edx,0x4(%ecx)
}
  802180:	8b 45 08             	mov    0x8(%ebp),%eax
  802183:	c9                   	leave  
  802184:	c2 04 00             	ret    $0x4

00802187 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  802187:	55                   	push   %ebp
  802188:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80218a:	6a 00                	push   $0x0
  80218c:	6a 00                	push   $0x0
  80218e:	ff 75 10             	pushl  0x10(%ebp)
  802191:	ff 75 0c             	pushl  0xc(%ebp)
  802194:	ff 75 08             	pushl  0x8(%ebp)
  802197:	6a 13                	push   $0x13
  802199:	e8 9c fb ff ff       	call   801d3a <syscall>
  80219e:	83 c4 18             	add    $0x18,%esp
	return ;
  8021a1:	90                   	nop
}
  8021a2:	c9                   	leave  
  8021a3:	c3                   	ret    

008021a4 <sys_rcr2>:
uint32 sys_rcr2()
{
  8021a4:	55                   	push   %ebp
  8021a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8021a7:	6a 00                	push   $0x0
  8021a9:	6a 00                	push   $0x0
  8021ab:	6a 00                	push   $0x0
  8021ad:	6a 00                	push   $0x0
  8021af:	6a 00                	push   $0x0
  8021b1:	6a 25                	push   $0x25
  8021b3:	e8 82 fb ff ff       	call   801d3a <syscall>
  8021b8:	83 c4 18             	add    $0x18,%esp
}
  8021bb:	c9                   	leave  
  8021bc:	c3                   	ret    

008021bd <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8021bd:	55                   	push   %ebp
  8021be:	89 e5                	mov    %esp,%ebp
  8021c0:	83 ec 04             	sub    $0x4,%esp
  8021c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8021c6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  8021c9:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  8021cd:	6a 00                	push   $0x0
  8021cf:	6a 00                	push   $0x0
  8021d1:	6a 00                	push   $0x0
  8021d3:	6a 00                	push   $0x0
  8021d5:	50                   	push   %eax
  8021d6:	6a 26                	push   $0x26
  8021d8:	e8 5d fb ff ff       	call   801d3a <syscall>
  8021dd:	83 c4 18             	add    $0x18,%esp
	return ;
  8021e0:	90                   	nop
}
  8021e1:	c9                   	leave  
  8021e2:	c3                   	ret    

008021e3 <rsttst>:
void rsttst()
{
  8021e3:	55                   	push   %ebp
  8021e4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  8021e6:	6a 00                	push   $0x0
  8021e8:	6a 00                	push   $0x0
  8021ea:	6a 00                	push   $0x0
  8021ec:	6a 00                	push   $0x0
  8021ee:	6a 00                	push   $0x0
  8021f0:	6a 28                	push   $0x28
  8021f2:	e8 43 fb ff ff       	call   801d3a <syscall>
  8021f7:	83 c4 18             	add    $0x18,%esp
	return ;
  8021fa:	90                   	nop
}
  8021fb:	c9                   	leave  
  8021fc:	c3                   	ret    

008021fd <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8021fd:	55                   	push   %ebp
  8021fe:	89 e5                	mov    %esp,%ebp
  802200:	83 ec 04             	sub    $0x4,%esp
  802203:	8b 45 14             	mov    0x14(%ebp),%eax
  802206:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802209:	8b 55 18             	mov    0x18(%ebp),%edx
  80220c:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  802210:	52                   	push   %edx
  802211:	50                   	push   %eax
  802212:	ff 75 10             	pushl  0x10(%ebp)
  802215:	ff 75 0c             	pushl  0xc(%ebp)
  802218:	ff 75 08             	pushl  0x8(%ebp)
  80221b:	6a 27                	push   $0x27
  80221d:	e8 18 fb ff ff       	call   801d3a <syscall>
  802222:	83 c4 18             	add    $0x18,%esp
	return ;
  802225:	90                   	nop
}
  802226:	c9                   	leave  
  802227:	c3                   	ret    

00802228 <chktst>:
void chktst(uint32 n)
{
  802228:	55                   	push   %ebp
  802229:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80222b:	6a 00                	push   $0x0
  80222d:	6a 00                	push   $0x0
  80222f:	6a 00                	push   $0x0
  802231:	6a 00                	push   $0x0
  802233:	ff 75 08             	pushl  0x8(%ebp)
  802236:	6a 29                	push   $0x29
  802238:	e8 fd fa ff ff       	call   801d3a <syscall>
  80223d:	83 c4 18             	add    $0x18,%esp
	return ;
  802240:	90                   	nop
}
  802241:	c9                   	leave  
  802242:	c3                   	ret    

00802243 <inctst>:

void inctst()
{
  802243:	55                   	push   %ebp
  802244:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  802246:	6a 00                	push   $0x0
  802248:	6a 00                	push   $0x0
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	6a 00                	push   $0x0
  802250:	6a 2a                	push   $0x2a
  802252:	e8 e3 fa ff ff       	call   801d3a <syscall>
  802257:	83 c4 18             	add    $0x18,%esp
	return ;
  80225a:	90                   	nop
}
  80225b:	c9                   	leave  
  80225c:	c3                   	ret    

0080225d <gettst>:
uint32 gettst()
{
  80225d:	55                   	push   %ebp
  80225e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  802260:	6a 00                	push   $0x0
  802262:	6a 00                	push   $0x0
  802264:	6a 00                	push   $0x0
  802266:	6a 00                	push   $0x0
  802268:	6a 00                	push   $0x0
  80226a:	6a 2b                	push   $0x2b
  80226c:	e8 c9 fa ff ff       	call   801d3a <syscall>
  802271:	83 c4 18             	add    $0x18,%esp
}
  802274:	c9                   	leave  
  802275:	c3                   	ret    

00802276 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  802276:	55                   	push   %ebp
  802277:	89 e5                	mov    %esp,%ebp
  802279:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80227c:	6a 00                	push   $0x0
  80227e:	6a 00                	push   $0x0
  802280:	6a 00                	push   $0x0
  802282:	6a 00                	push   $0x0
  802284:	6a 00                	push   $0x0
  802286:	6a 2c                	push   $0x2c
  802288:	e8 ad fa ff ff       	call   801d3a <syscall>
  80228d:	83 c4 18             	add    $0x18,%esp
  802290:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  802293:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802297:	75 07                	jne    8022a0 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802299:	b8 01 00 00 00       	mov    $0x1,%eax
  80229e:	eb 05                	jmp    8022a5 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8022a0:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a5:	c9                   	leave  
  8022a6:	c3                   	ret    

008022a7 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8022a7:	55                   	push   %ebp
  8022a8:	89 e5                	mov    %esp,%ebp
  8022aa:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	6a 00                	push   $0x0
  8022b3:	6a 00                	push   $0x0
  8022b5:	6a 00                	push   $0x0
  8022b7:	6a 2c                	push   $0x2c
  8022b9:	e8 7c fa ff ff       	call   801d3a <syscall>
  8022be:	83 c4 18             	add    $0x18,%esp
  8022c1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8022c4:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  8022c8:	75 07                	jne    8022d1 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  8022ca:	b8 01 00 00 00       	mov    $0x1,%eax
  8022cf:	eb 05                	jmp    8022d6 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  8022d1:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022d6:	c9                   	leave  
  8022d7:	c3                   	ret    

008022d8 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  8022d8:	55                   	push   %ebp
  8022d9:	89 e5                	mov    %esp,%ebp
  8022db:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8022de:	6a 00                	push   $0x0
  8022e0:	6a 00                	push   $0x0
  8022e2:	6a 00                	push   $0x0
  8022e4:	6a 00                	push   $0x0
  8022e6:	6a 00                	push   $0x0
  8022e8:	6a 2c                	push   $0x2c
  8022ea:	e8 4b fa ff ff       	call   801d3a <syscall>
  8022ef:	83 c4 18             	add    $0x18,%esp
  8022f2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  8022f5:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  8022f9:	75 07                	jne    802302 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  8022fb:	b8 01 00 00 00       	mov    $0x1,%eax
  802300:	eb 05                	jmp    802307 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  802302:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802307:	c9                   	leave  
  802308:	c3                   	ret    

00802309 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802309:	55                   	push   %ebp
  80230a:	89 e5                	mov    %esp,%ebp
  80230c:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80230f:	6a 00                	push   $0x0
  802311:	6a 00                	push   $0x0
  802313:	6a 00                	push   $0x0
  802315:	6a 00                	push   $0x0
  802317:	6a 00                	push   $0x0
  802319:	6a 2c                	push   $0x2c
  80231b:	e8 1a fa ff ff       	call   801d3a <syscall>
  802320:	83 c4 18             	add    $0x18,%esp
  802323:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802326:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  80232a:	75 07                	jne    802333 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  80232c:	b8 01 00 00 00       	mov    $0x1,%eax
  802331:	eb 05                	jmp    802338 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  802333:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802338:	c9                   	leave  
  802339:	c3                   	ret    

0080233a <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  80233a:	55                   	push   %ebp
  80233b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  80233d:	6a 00                	push   $0x0
  80233f:	6a 00                	push   $0x0
  802341:	6a 00                	push   $0x0
  802343:	6a 00                	push   $0x0
  802345:	ff 75 08             	pushl  0x8(%ebp)
  802348:	6a 2d                	push   $0x2d
  80234a:	e8 eb f9 ff ff       	call   801d3a <syscall>
  80234f:	83 c4 18             	add    $0x18,%esp
	return ;
  802352:	90                   	nop
}
  802353:	c9                   	leave  
  802354:	c3                   	ret    

00802355 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  802355:	55                   	push   %ebp
  802356:	89 e5                	mov    %esp,%ebp
  802358:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  802359:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80235c:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80235f:	8b 55 0c             	mov    0xc(%ebp),%edx
  802362:	8b 45 08             	mov    0x8(%ebp),%eax
  802365:	6a 00                	push   $0x0
  802367:	53                   	push   %ebx
  802368:	51                   	push   %ecx
  802369:	52                   	push   %edx
  80236a:	50                   	push   %eax
  80236b:	6a 2e                	push   $0x2e
  80236d:	e8 c8 f9 ff ff       	call   801d3a <syscall>
  802372:	83 c4 18             	add    $0x18,%esp
}
  802375:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  802378:	c9                   	leave  
  802379:	c3                   	ret    

0080237a <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  80237a:	55                   	push   %ebp
  80237b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  80237d:	8b 55 0c             	mov    0xc(%ebp),%edx
  802380:	8b 45 08             	mov    0x8(%ebp),%eax
  802383:	6a 00                	push   $0x0
  802385:	6a 00                	push   $0x0
  802387:	6a 00                	push   $0x0
  802389:	52                   	push   %edx
  80238a:	50                   	push   %eax
  80238b:	6a 2f                	push   $0x2f
  80238d:	e8 a8 f9 ff ff       	call   801d3a <syscall>
  802392:	83 c4 18             	add    $0x18,%esp
}
  802395:	c9                   	leave  
  802396:	c3                   	ret    

00802397 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802397:	55                   	push   %ebp
  802398:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  80239a:	6a 00                	push   $0x0
  80239c:	6a 00                	push   $0x0
  80239e:	6a 00                	push   $0x0
  8023a0:	ff 75 0c             	pushl  0xc(%ebp)
  8023a3:	ff 75 08             	pushl  0x8(%ebp)
  8023a6:	6a 30                	push   $0x30
  8023a8:	e8 8d f9 ff ff       	call   801d3a <syscall>
  8023ad:	83 c4 18             	add    $0x18,%esp
	return ;
  8023b0:	90                   	nop
}
  8023b1:	c9                   	leave  
  8023b2:	c3                   	ret    
  8023b3:	90                   	nop

008023b4 <__udivdi3>:
  8023b4:	55                   	push   %ebp
  8023b5:	57                   	push   %edi
  8023b6:	56                   	push   %esi
  8023b7:	53                   	push   %ebx
  8023b8:	83 ec 1c             	sub    $0x1c,%esp
  8023bb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  8023bf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  8023c3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8023c7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  8023cb:	89 ca                	mov    %ecx,%edx
  8023cd:	89 f8                	mov    %edi,%eax
  8023cf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  8023d3:	85 f6                	test   %esi,%esi
  8023d5:	75 2d                	jne    802404 <__udivdi3+0x50>
  8023d7:	39 cf                	cmp    %ecx,%edi
  8023d9:	77 65                	ja     802440 <__udivdi3+0x8c>
  8023db:	89 fd                	mov    %edi,%ebp
  8023dd:	85 ff                	test   %edi,%edi
  8023df:	75 0b                	jne    8023ec <__udivdi3+0x38>
  8023e1:	b8 01 00 00 00       	mov    $0x1,%eax
  8023e6:	31 d2                	xor    %edx,%edx
  8023e8:	f7 f7                	div    %edi
  8023ea:	89 c5                	mov    %eax,%ebp
  8023ec:	31 d2                	xor    %edx,%edx
  8023ee:	89 c8                	mov    %ecx,%eax
  8023f0:	f7 f5                	div    %ebp
  8023f2:	89 c1                	mov    %eax,%ecx
  8023f4:	89 d8                	mov    %ebx,%eax
  8023f6:	f7 f5                	div    %ebp
  8023f8:	89 cf                	mov    %ecx,%edi
  8023fa:	89 fa                	mov    %edi,%edx
  8023fc:	83 c4 1c             	add    $0x1c,%esp
  8023ff:	5b                   	pop    %ebx
  802400:	5e                   	pop    %esi
  802401:	5f                   	pop    %edi
  802402:	5d                   	pop    %ebp
  802403:	c3                   	ret    
  802404:	39 ce                	cmp    %ecx,%esi
  802406:	77 28                	ja     802430 <__udivdi3+0x7c>
  802408:	0f bd fe             	bsr    %esi,%edi
  80240b:	83 f7 1f             	xor    $0x1f,%edi
  80240e:	75 40                	jne    802450 <__udivdi3+0x9c>
  802410:	39 ce                	cmp    %ecx,%esi
  802412:	72 0a                	jb     80241e <__udivdi3+0x6a>
  802414:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802418:	0f 87 9e 00 00 00    	ja     8024bc <__udivdi3+0x108>
  80241e:	b8 01 00 00 00       	mov    $0x1,%eax
  802423:	89 fa                	mov    %edi,%edx
  802425:	83 c4 1c             	add    $0x1c,%esp
  802428:	5b                   	pop    %ebx
  802429:	5e                   	pop    %esi
  80242a:	5f                   	pop    %edi
  80242b:	5d                   	pop    %ebp
  80242c:	c3                   	ret    
  80242d:	8d 76 00             	lea    0x0(%esi),%esi
  802430:	31 ff                	xor    %edi,%edi
  802432:	31 c0                	xor    %eax,%eax
  802434:	89 fa                	mov    %edi,%edx
  802436:	83 c4 1c             	add    $0x1c,%esp
  802439:	5b                   	pop    %ebx
  80243a:	5e                   	pop    %esi
  80243b:	5f                   	pop    %edi
  80243c:	5d                   	pop    %ebp
  80243d:	c3                   	ret    
  80243e:	66 90                	xchg   %ax,%ax
  802440:	89 d8                	mov    %ebx,%eax
  802442:	f7 f7                	div    %edi
  802444:	31 ff                	xor    %edi,%edi
  802446:	89 fa                	mov    %edi,%edx
  802448:	83 c4 1c             	add    $0x1c,%esp
  80244b:	5b                   	pop    %ebx
  80244c:	5e                   	pop    %esi
  80244d:	5f                   	pop    %edi
  80244e:	5d                   	pop    %ebp
  80244f:	c3                   	ret    
  802450:	bd 20 00 00 00       	mov    $0x20,%ebp
  802455:	89 eb                	mov    %ebp,%ebx
  802457:	29 fb                	sub    %edi,%ebx
  802459:	89 f9                	mov    %edi,%ecx
  80245b:	d3 e6                	shl    %cl,%esi
  80245d:	89 c5                	mov    %eax,%ebp
  80245f:	88 d9                	mov    %bl,%cl
  802461:	d3 ed                	shr    %cl,%ebp
  802463:	89 e9                	mov    %ebp,%ecx
  802465:	09 f1                	or     %esi,%ecx
  802467:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  80246b:	89 f9                	mov    %edi,%ecx
  80246d:	d3 e0                	shl    %cl,%eax
  80246f:	89 c5                	mov    %eax,%ebp
  802471:	89 d6                	mov    %edx,%esi
  802473:	88 d9                	mov    %bl,%cl
  802475:	d3 ee                	shr    %cl,%esi
  802477:	89 f9                	mov    %edi,%ecx
  802479:	d3 e2                	shl    %cl,%edx
  80247b:	8b 44 24 08          	mov    0x8(%esp),%eax
  80247f:	88 d9                	mov    %bl,%cl
  802481:	d3 e8                	shr    %cl,%eax
  802483:	09 c2                	or     %eax,%edx
  802485:	89 d0                	mov    %edx,%eax
  802487:	89 f2                	mov    %esi,%edx
  802489:	f7 74 24 0c          	divl   0xc(%esp)
  80248d:	89 d6                	mov    %edx,%esi
  80248f:	89 c3                	mov    %eax,%ebx
  802491:	f7 e5                	mul    %ebp
  802493:	39 d6                	cmp    %edx,%esi
  802495:	72 19                	jb     8024b0 <__udivdi3+0xfc>
  802497:	74 0b                	je     8024a4 <__udivdi3+0xf0>
  802499:	89 d8                	mov    %ebx,%eax
  80249b:	31 ff                	xor    %edi,%edi
  80249d:	e9 58 ff ff ff       	jmp    8023fa <__udivdi3+0x46>
  8024a2:	66 90                	xchg   %ax,%ax
  8024a4:	8b 54 24 08          	mov    0x8(%esp),%edx
  8024a8:	89 f9                	mov    %edi,%ecx
  8024aa:	d3 e2                	shl    %cl,%edx
  8024ac:	39 c2                	cmp    %eax,%edx
  8024ae:	73 e9                	jae    802499 <__udivdi3+0xe5>
  8024b0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  8024b3:	31 ff                	xor    %edi,%edi
  8024b5:	e9 40 ff ff ff       	jmp    8023fa <__udivdi3+0x46>
  8024ba:	66 90                	xchg   %ax,%ax
  8024bc:	31 c0                	xor    %eax,%eax
  8024be:	e9 37 ff ff ff       	jmp    8023fa <__udivdi3+0x46>
  8024c3:	90                   	nop

008024c4 <__umoddi3>:
  8024c4:	55                   	push   %ebp
  8024c5:	57                   	push   %edi
  8024c6:	56                   	push   %esi
  8024c7:	53                   	push   %ebx
  8024c8:	83 ec 1c             	sub    $0x1c,%esp
  8024cb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  8024cf:	8b 74 24 34          	mov    0x34(%esp),%esi
  8024d3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  8024d7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  8024db:	89 44 24 0c          	mov    %eax,0xc(%esp)
  8024df:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  8024e3:	89 f3                	mov    %esi,%ebx
  8024e5:	89 fa                	mov    %edi,%edx
  8024e7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8024eb:	89 34 24             	mov    %esi,(%esp)
  8024ee:	85 c0                	test   %eax,%eax
  8024f0:	75 1a                	jne    80250c <__umoddi3+0x48>
  8024f2:	39 f7                	cmp    %esi,%edi
  8024f4:	0f 86 a2 00 00 00    	jbe    80259c <__umoddi3+0xd8>
  8024fa:	89 c8                	mov    %ecx,%eax
  8024fc:	89 f2                	mov    %esi,%edx
  8024fe:	f7 f7                	div    %edi
  802500:	89 d0                	mov    %edx,%eax
  802502:	31 d2                	xor    %edx,%edx
  802504:	83 c4 1c             	add    $0x1c,%esp
  802507:	5b                   	pop    %ebx
  802508:	5e                   	pop    %esi
  802509:	5f                   	pop    %edi
  80250a:	5d                   	pop    %ebp
  80250b:	c3                   	ret    
  80250c:	39 f0                	cmp    %esi,%eax
  80250e:	0f 87 ac 00 00 00    	ja     8025c0 <__umoddi3+0xfc>
  802514:	0f bd e8             	bsr    %eax,%ebp
  802517:	83 f5 1f             	xor    $0x1f,%ebp
  80251a:	0f 84 ac 00 00 00    	je     8025cc <__umoddi3+0x108>
  802520:	bf 20 00 00 00       	mov    $0x20,%edi
  802525:	29 ef                	sub    %ebp,%edi
  802527:	89 fe                	mov    %edi,%esi
  802529:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  80252d:	89 e9                	mov    %ebp,%ecx
  80252f:	d3 e0                	shl    %cl,%eax
  802531:	89 d7                	mov    %edx,%edi
  802533:	89 f1                	mov    %esi,%ecx
  802535:	d3 ef                	shr    %cl,%edi
  802537:	09 c7                	or     %eax,%edi
  802539:	89 e9                	mov    %ebp,%ecx
  80253b:	d3 e2                	shl    %cl,%edx
  80253d:	89 14 24             	mov    %edx,(%esp)
  802540:	89 d8                	mov    %ebx,%eax
  802542:	d3 e0                	shl    %cl,%eax
  802544:	89 c2                	mov    %eax,%edx
  802546:	8b 44 24 08          	mov    0x8(%esp),%eax
  80254a:	d3 e0                	shl    %cl,%eax
  80254c:	89 44 24 04          	mov    %eax,0x4(%esp)
  802550:	8b 44 24 08          	mov    0x8(%esp),%eax
  802554:	89 f1                	mov    %esi,%ecx
  802556:	d3 e8                	shr    %cl,%eax
  802558:	09 d0                	or     %edx,%eax
  80255a:	d3 eb                	shr    %cl,%ebx
  80255c:	89 da                	mov    %ebx,%edx
  80255e:	f7 f7                	div    %edi
  802560:	89 d3                	mov    %edx,%ebx
  802562:	f7 24 24             	mull   (%esp)
  802565:	89 c6                	mov    %eax,%esi
  802567:	89 d1                	mov    %edx,%ecx
  802569:	39 d3                	cmp    %edx,%ebx
  80256b:	0f 82 87 00 00 00    	jb     8025f8 <__umoddi3+0x134>
  802571:	0f 84 91 00 00 00    	je     802608 <__umoddi3+0x144>
  802577:	8b 54 24 04          	mov    0x4(%esp),%edx
  80257b:	29 f2                	sub    %esi,%edx
  80257d:	19 cb                	sbb    %ecx,%ebx
  80257f:	89 d8                	mov    %ebx,%eax
  802581:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  802585:	d3 e0                	shl    %cl,%eax
  802587:	89 e9                	mov    %ebp,%ecx
  802589:	d3 ea                	shr    %cl,%edx
  80258b:	09 d0                	or     %edx,%eax
  80258d:	89 e9                	mov    %ebp,%ecx
  80258f:	d3 eb                	shr    %cl,%ebx
  802591:	89 da                	mov    %ebx,%edx
  802593:	83 c4 1c             	add    $0x1c,%esp
  802596:	5b                   	pop    %ebx
  802597:	5e                   	pop    %esi
  802598:	5f                   	pop    %edi
  802599:	5d                   	pop    %ebp
  80259a:	c3                   	ret    
  80259b:	90                   	nop
  80259c:	89 fd                	mov    %edi,%ebp
  80259e:	85 ff                	test   %edi,%edi
  8025a0:	75 0b                	jne    8025ad <__umoddi3+0xe9>
  8025a2:	b8 01 00 00 00       	mov    $0x1,%eax
  8025a7:	31 d2                	xor    %edx,%edx
  8025a9:	f7 f7                	div    %edi
  8025ab:	89 c5                	mov    %eax,%ebp
  8025ad:	89 f0                	mov    %esi,%eax
  8025af:	31 d2                	xor    %edx,%edx
  8025b1:	f7 f5                	div    %ebp
  8025b3:	89 c8                	mov    %ecx,%eax
  8025b5:	f7 f5                	div    %ebp
  8025b7:	89 d0                	mov    %edx,%eax
  8025b9:	e9 44 ff ff ff       	jmp    802502 <__umoddi3+0x3e>
  8025be:	66 90                	xchg   %ax,%ax
  8025c0:	89 c8                	mov    %ecx,%eax
  8025c2:	89 f2                	mov    %esi,%edx
  8025c4:	83 c4 1c             	add    $0x1c,%esp
  8025c7:	5b                   	pop    %ebx
  8025c8:	5e                   	pop    %esi
  8025c9:	5f                   	pop    %edi
  8025ca:	5d                   	pop    %ebp
  8025cb:	c3                   	ret    
  8025cc:	3b 04 24             	cmp    (%esp),%eax
  8025cf:	72 06                	jb     8025d7 <__umoddi3+0x113>
  8025d1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  8025d5:	77 0f                	ja     8025e6 <__umoddi3+0x122>
  8025d7:	89 f2                	mov    %esi,%edx
  8025d9:	29 f9                	sub    %edi,%ecx
  8025db:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  8025df:	89 14 24             	mov    %edx,(%esp)
  8025e2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  8025e6:	8b 44 24 04          	mov    0x4(%esp),%eax
  8025ea:	8b 14 24             	mov    (%esp),%edx
  8025ed:	83 c4 1c             	add    $0x1c,%esp
  8025f0:	5b                   	pop    %ebx
  8025f1:	5e                   	pop    %esi
  8025f2:	5f                   	pop    %edi
  8025f3:	5d                   	pop    %ebp
  8025f4:	c3                   	ret    
  8025f5:	8d 76 00             	lea    0x0(%esi),%esi
  8025f8:	2b 04 24             	sub    (%esp),%eax
  8025fb:	19 fa                	sbb    %edi,%edx
  8025fd:	89 d1                	mov    %edx,%ecx
  8025ff:	89 c6                	mov    %eax,%esi
  802601:	e9 71 ff ff ff       	jmp    802577 <__umoddi3+0xb3>
  802606:	66 90                	xchg   %ax,%ax
  802608:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80260c:	72 ea                	jb     8025f8 <__umoddi3+0x134>
  80260e:	89 d9                	mov    %ebx,%ecx
  802610:	e9 62 ff ff ff       	jmp    802577 <__umoddi3+0xb3>
