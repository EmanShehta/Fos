
obj/user/tst_quicksort_freeHeap:     file format elf32-i386


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
  800031:	e8 20 08 00 00       	call   800856 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
uint32 CheckSorted(int *Elements, int NumOfElements);

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv);

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	53                   	push   %ebx
  80003c:	81 ec 34 01 00 00    	sub    $0x134,%esp


	//int InitFreeFrames = sys_calculate_free_frames() ;
	char Line[255] ;
	char Chose ;
	int Iteration = 0 ;
  800042:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
	do
	{

		Iteration++ ;
  800049:	ff 45 f0             	incl   -0x10(%ebp)
		//		cprintf("Free Frames Before Allocation = %d\n", sys_calculate_free_frames()) ;

	sys_disable_interrupt();
  80004c:	e8 91 1e 00 00       	call   801ee2 <sys_disable_interrupt>
		readline("Enter the number of elements: ", Line);
  800051:	83 ec 08             	sub    $0x8,%esp
  800054:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  80005a:	50                   	push   %eax
  80005b:	68 a0 25 80 00       	push   $0x8025a0
  800060:	e8 43 12 00 00       	call   8012a8 <readline>
  800065:	83 c4 10             	add    $0x10,%esp
		int NumOfElements = strtol(Line, NULL, 10) ;
  800068:	83 ec 04             	sub    $0x4,%esp
  80006b:	6a 0a                	push   $0xa
  80006d:	6a 00                	push   $0x0
  80006f:	8d 85 c9 fe ff ff    	lea    -0x137(%ebp),%eax
  800075:	50                   	push   %eax
  800076:	e8 93 17 00 00       	call   80180e <strtol>
  80007b:	83 c4 10             	add    $0x10,%esp
  80007e:	89 45 ec             	mov    %eax,-0x14(%ebp)

		int *Elements = malloc(sizeof(int) * NumOfElements) ;
  800081:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800084:	c1 e0 02             	shl    $0x2,%eax
  800087:	83 ec 0c             	sub    $0xc,%esp
  80008a:	50                   	push   %eax
  80008b:	e8 26 1b 00 00       	call   801bb6 <malloc>
  800090:	83 c4 10             	add    $0x10,%esp
  800093:	89 45 e8             	mov    %eax,-0x18(%ebp)

		int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800096:	a1 24 30 80 00       	mov    0x803024,%eax
  80009b:	83 ec 0c             	sub    $0xc,%esp
  80009e:	50                   	push   %eax
  80009f:	e8 7f 03 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8000a4:	83 c4 10             	add    $0x10,%esp
  8000a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
		int InitFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS ;
  8000aa:	e8 63 1d 00 00       	call   801e12 <sys_calculate_free_frames>
  8000af:	89 c3                	mov    %eax,%ebx
  8000b1:	e8 75 1d 00 00       	call   801e2b <sys_calculate_modified_frames>
  8000b6:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  8000b9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bc:	29 c2                	sub    %eax,%edx
  8000be:	89 d0                	mov    %edx,%eax
  8000c0:	89 45 e0             	mov    %eax,-0x20(%ebp)

		Elements[NumOfElements] = 10 ;
  8000c3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8000cd:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000d0:	01 d0                	add    %edx,%eax
  8000d2:	c7 00 0a 00 00 00    	movl   $0xa,(%eax)
		//		cprintf("Free Frames After Allocation = %d\n", sys_calculate_free_frames()) ;
		cprintf("Choose the initialization method:\n") ;
  8000d8:	83 ec 0c             	sub    $0xc,%esp
  8000db:	68 c0 25 80 00       	push   $0x8025c0
  8000e0:	e8 41 0b 00 00       	call   800c26 <cprintf>
  8000e5:	83 c4 10             	add    $0x10,%esp
		cprintf("a) Ascending\n") ;
  8000e8:	83 ec 0c             	sub    $0xc,%esp
  8000eb:	68 e3 25 80 00       	push   $0x8025e3
  8000f0:	e8 31 0b 00 00       	call   800c26 <cprintf>
  8000f5:	83 c4 10             	add    $0x10,%esp
		cprintf("b) Descending\n") ;
  8000f8:	83 ec 0c             	sub    $0xc,%esp
  8000fb:	68 f1 25 80 00       	push   $0x8025f1
  800100:	e8 21 0b 00 00       	call   800c26 <cprintf>
  800105:	83 c4 10             	add    $0x10,%esp
		cprintf("c) Semi random\n") ;
  800108:	83 ec 0c             	sub    $0xc,%esp
  80010b:	68 00 26 80 00       	push   $0x802600
  800110:	e8 11 0b 00 00       	call   800c26 <cprintf>
  800115:	83 c4 10             	add    $0x10,%esp
		do
		{
			cprintf("Select: ") ;
  800118:	83 ec 0c             	sub    $0xc,%esp
  80011b:	68 10 26 80 00       	push   $0x802610
  800120:	e8 01 0b 00 00       	call   800c26 <cprintf>
  800125:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  800128:	e8 d1 06 00 00       	call   8007fe <getchar>
  80012d:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  800130:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800134:	83 ec 0c             	sub    $0xc,%esp
  800137:	50                   	push   %eax
  800138:	e8 79 06 00 00       	call   8007b6 <cputchar>
  80013d:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  800140:	83 ec 0c             	sub    $0xc,%esp
  800143:	6a 0a                	push   $0xa
  800145:	e8 6c 06 00 00       	call   8007b6 <cputchar>
  80014a:	83 c4 10             	add    $0x10,%esp
		} while (Chose != 'a' && Chose != 'b' && Chose != 'c');
  80014d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800151:	74 0c                	je     80015f <_main+0x127>
  800153:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  800157:	74 06                	je     80015f <_main+0x127>
  800159:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  80015d:	75 b9                	jne    800118 <_main+0xe0>
	sys_enable_interrupt();
  80015f:	e8 98 1d 00 00       	call   801efc <sys_enable_interrupt>
		int  i ;
		switch (Chose)
  800164:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  800168:	83 f8 62             	cmp    $0x62,%eax
  80016b:	74 1d                	je     80018a <_main+0x152>
  80016d:	83 f8 63             	cmp    $0x63,%eax
  800170:	74 2b                	je     80019d <_main+0x165>
  800172:	83 f8 61             	cmp    $0x61,%eax
  800175:	75 39                	jne    8001b0 <_main+0x178>
		{
		case 'a':
			InitializeAscending(Elements, NumOfElements);
  800177:	83 ec 08             	sub    $0x8,%esp
  80017a:	ff 75 ec             	pushl  -0x14(%ebp)
  80017d:	ff 75 e8             	pushl  -0x18(%ebp)
  800180:	e8 f9 04 00 00       	call   80067e <InitializeAscending>
  800185:	83 c4 10             	add    $0x10,%esp
			break ;
  800188:	eb 37                	jmp    8001c1 <_main+0x189>
		case 'b':
			InitializeDescending(Elements, NumOfElements);
  80018a:	83 ec 08             	sub    $0x8,%esp
  80018d:	ff 75 ec             	pushl  -0x14(%ebp)
  800190:	ff 75 e8             	pushl  -0x18(%ebp)
  800193:	e8 17 05 00 00       	call   8006af <InitializeDescending>
  800198:	83 c4 10             	add    $0x10,%esp
			break ;
  80019b:	eb 24                	jmp    8001c1 <_main+0x189>
		case 'c':
			InitializeSemiRandom(Elements, NumOfElements);
  80019d:	83 ec 08             	sub    $0x8,%esp
  8001a0:	ff 75 ec             	pushl  -0x14(%ebp)
  8001a3:	ff 75 e8             	pushl  -0x18(%ebp)
  8001a6:	e8 39 05 00 00       	call   8006e4 <InitializeSemiRandom>
  8001ab:	83 c4 10             	add    $0x10,%esp
			break ;
  8001ae:	eb 11                	jmp    8001c1 <_main+0x189>
		default:
			InitializeSemiRandom(Elements, NumOfElements);
  8001b0:	83 ec 08             	sub    $0x8,%esp
  8001b3:	ff 75 ec             	pushl  -0x14(%ebp)
  8001b6:	ff 75 e8             	pushl  -0x18(%ebp)
  8001b9:	e8 26 05 00 00       	call   8006e4 <InitializeSemiRandom>
  8001be:	83 c4 10             	add    $0x10,%esp
		}

		QuickSort(Elements, NumOfElements);
  8001c1:	83 ec 08             	sub    $0x8,%esp
  8001c4:	ff 75 ec             	pushl  -0x14(%ebp)
  8001c7:	ff 75 e8             	pushl  -0x18(%ebp)
  8001ca:	e8 f4 02 00 00       	call   8004c3 <QuickSort>
  8001cf:	83 c4 10             	add    $0x10,%esp

		//		PrintElements(Elements, NumOfElements);

		uint32 Sorted = CheckSorted(Elements, NumOfElements);
  8001d2:	83 ec 08             	sub    $0x8,%esp
  8001d5:	ff 75 ec             	pushl  -0x14(%ebp)
  8001d8:	ff 75 e8             	pushl  -0x18(%ebp)
  8001db:	e8 f4 03 00 00       	call   8005d4 <CheckSorted>
  8001e0:	83 c4 10             	add    $0x10,%esp
  8001e3:	89 45 dc             	mov    %eax,-0x24(%ebp)

		if(Sorted == 0) panic("The array is NOT sorted correctly") ;
  8001e6:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001ea:	75 14                	jne    800200 <_main+0x1c8>
  8001ec:	83 ec 04             	sub    $0x4,%esp
  8001ef:	68 1c 26 80 00       	push   $0x80261c
  8001f4:	6a 57                	push   $0x57
  8001f6:	68 3e 26 80 00       	push   $0x80263e
  8001fb:	e8 72 07 00 00       	call   800972 <_panic>
		else
		{
			cprintf("===============================================\n") ;
  800200:	83 ec 0c             	sub    $0xc,%esp
  800203:	68 5c 26 80 00       	push   $0x80265c
  800208:	e8 19 0a 00 00       	call   800c26 <cprintf>
  80020d:	83 c4 10             	add    $0x10,%esp
			cprintf("Congratulations!! The array is sorted correctly\n") ;
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 90 26 80 00       	push   $0x802690
  800218:	e8 09 0a 00 00       	call   800c26 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp
			cprintf("===============================================\n\n") ;
  800220:	83 ec 0c             	sub    $0xc,%esp
  800223:	68 c4 26 80 00       	push   $0x8026c4
  800228:	e8 f9 09 00 00       	call   800c26 <cprintf>
  80022d:	83 c4 10             	add    $0x10,%esp
		}

		//		cprintf("Free Frames After Calculation = %d\n", sys_calculate_free_frames()) ;

		cprintf("Freeing the Heap...\n\n") ;
  800230:	83 ec 0c             	sub    $0xc,%esp
  800233:	68 f6 26 80 00       	push   $0x8026f6
  800238:	e8 e9 09 00 00       	call   800c26 <cprintf>
  80023d:	83 c4 10             	add    $0x10,%esp
		free(Elements) ;
  800240:	83 ec 0c             	sub    $0xc,%esp
  800243:	ff 75 e8             	pushl  -0x18(%ebp)
  800246:	e8 85 19 00 00       	call   801bd0 <free>
  80024b:	83 c4 10             	add    $0x10,%esp


		///Testing the freeHeap according to the specified scenario
		if (Iteration == 1)
  80024e:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
  800252:	75 72                	jne    8002c6 <_main+0x28e>
		{
			if (!(NumOfElements == 1000 && Chose == 'a'))
  800254:	81 7d ec e8 03 00 00 	cmpl   $0x3e8,-0x14(%ebp)
  80025b:	75 06                	jne    800263 <_main+0x22b>
  80025d:	80 7d f7 61          	cmpb   $0x61,-0x9(%ebp)
  800261:	74 14                	je     800277 <_main+0x23f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800263:	83 ec 04             	sub    $0x4,%esp
  800266:	68 0c 27 80 00       	push   $0x80270c
  80026b:	6a 69                	push   $0x69
  80026d:	68 3e 26 80 00       	push   $0x80263e
  800272:	e8 fb 06 00 00       	call   800972 <_panic>

			numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800277:	a1 24 30 80 00       	mov    0x803024,%eax
  80027c:	83 ec 0c             	sub    $0xc,%esp
  80027f:	50                   	push   %eax
  800280:	e8 9e 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800285:	83 c4 10             	add    $0x10,%esp
  800288:	89 45 e4             	mov    %eax,-0x1c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80028b:	e8 82 1b 00 00       	call   801e12 <sys_calculate_free_frames>
  800290:	89 c3                	mov    %eax,%ebx
  800292:	e8 94 1b 00 00       	call   801e2b <sys_calculate_modified_frames>
  800297:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80029a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  80029d:	29 c2                	sub    %eax,%edx
  80029f:	89 d0                	mov    %edx,%eax
  8002a1:	89 45 d8             	mov    %eax,-0x28(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  8002a4:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8002a7:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  8002aa:	0f 84 05 01 00 00    	je     8003b5 <_main+0x37d>
  8002b0:	68 5c 27 80 00       	push   $0x80275c
  8002b5:	68 81 27 80 00       	push   $0x802781
  8002ba:	6a 6d                	push   $0x6d
  8002bc:	68 3e 26 80 00       	push   $0x80263e
  8002c1:	e8 ac 06 00 00       	call   800972 <_panic>
		}
		else if (Iteration == 2 )
  8002c6:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
  8002ca:	75 72                	jne    80033e <_main+0x306>
		{
			if (!(NumOfElements == 5000 && Chose == 'b'))
  8002cc:	81 7d ec 88 13 00 00 	cmpl   $0x1388,-0x14(%ebp)
  8002d3:	75 06                	jne    8002db <_main+0x2a3>
  8002d5:	80 7d f7 62          	cmpb   $0x62,-0x9(%ebp)
  8002d9:	74 14                	je     8002ef <_main+0x2b7>
				panic("Please ensure the number of elements and the initialization method of this test");
  8002db:	83 ec 04             	sub    $0x4,%esp
  8002de:	68 0c 27 80 00       	push   $0x80270c
  8002e3:	6a 72                	push   $0x72
  8002e5:	68 3e 26 80 00       	push   $0x80263e
  8002ea:	e8 83 06 00 00       	call   800972 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  8002ef:	a1 24 30 80 00       	mov    0x803024,%eax
  8002f4:	83 ec 0c             	sub    $0xc,%esp
  8002f7:	50                   	push   %eax
  8002f8:	e8 26 01 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  8002fd:	83 c4 10             	add    $0x10,%esp
  800300:	89 45 d4             	mov    %eax,-0x2c(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  800303:	e8 0a 1b 00 00       	call   801e12 <sys_calculate_free_frames>
  800308:	89 c3                	mov    %eax,%ebx
  80030a:	e8 1c 1b 00 00       	call   801e2b <sys_calculate_modified_frames>
  80030f:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  800312:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800315:	29 c2                	sub    %eax,%edx
  800317:	89 d0                	mov    %edx,%eax
  800319:	89 45 d0             	mov    %eax,-0x30(%ebp)
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  80031c:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80031f:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  800322:	0f 84 8d 00 00 00    	je     8003b5 <_main+0x37d>
  800328:	68 5c 27 80 00       	push   $0x80275c
  80032d:	68 81 27 80 00       	push   $0x802781
  800332:	6a 76                	push   $0x76
  800334:	68 3e 26 80 00       	push   $0x80263e
  800339:	e8 34 06 00 00       	call   800972 <_panic>
		}
		else if (Iteration == 3 )
  80033e:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
  800342:	75 71                	jne    8003b5 <_main+0x37d>
		{
			if (!(NumOfElements == 300000 && Chose == 'c'))
  800344:	81 7d ec e0 93 04 00 	cmpl   $0x493e0,-0x14(%ebp)
  80034b:	75 06                	jne    800353 <_main+0x31b>
  80034d:	80 7d f7 63          	cmpb   $0x63,-0x9(%ebp)
  800351:	74 14                	je     800367 <_main+0x32f>
				panic("Please ensure the number of elements and the initialization method of this test");
  800353:	83 ec 04             	sub    $0x4,%esp
  800356:	68 0c 27 80 00       	push   $0x80270c
  80035b:	6a 7b                	push   $0x7b
  80035d:	68 3e 26 80 00       	push   $0x80263e
  800362:	e8 0b 06 00 00       	call   800972 <_panic>

			int numOFEmptyLocInWS = CheckAndCountEmptyLocInWS(myEnv);
  800367:	a1 24 30 80 00       	mov    0x803024,%eax
  80036c:	83 ec 0c             	sub    $0xc,%esp
  80036f:	50                   	push   %eax
  800370:	e8 ae 00 00 00       	call   800423 <CheckAndCountEmptyLocInWS>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	89 45 cc             	mov    %eax,-0x34(%ebp)
			int CurrFreeFrames = sys_calculate_free_frames() + sys_calculate_modified_frames() - numOFEmptyLocInWS;
  80037b:	e8 92 1a 00 00       	call   801e12 <sys_calculate_free_frames>
  800380:	89 c3                	mov    %eax,%ebx
  800382:	e8 a4 1a 00 00       	call   801e2b <sys_calculate_modified_frames>
  800387:	8d 14 03             	lea    (%ebx,%eax,1),%edx
  80038a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80038d:	29 c2                	sub    %eax,%edx
  80038f:	89 d0                	mov    %edx,%eax
  800391:	89 45 c8             	mov    %eax,-0x38(%ebp)
			//cprintf("numOFEmptyLocInWS = %d\n", numOFEmptyLocInWS );
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
  800394:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800397:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  80039a:	74 19                	je     8003b5 <_main+0x37d>
  80039c:	68 5c 27 80 00       	push   $0x80275c
  8003a1:	68 81 27 80 00       	push   $0x802781
  8003a6:	68 80 00 00 00       	push   $0x80
  8003ab:	68 3e 26 80 00       	push   $0x80263e
  8003b0:	e8 bd 05 00 00       	call   800972 <_panic>
		}
		///========================================================================
	sys_disable_interrupt();
  8003b5:	e8 28 1b 00 00       	call   801ee2 <sys_disable_interrupt>
		Chose = 0 ;
  8003ba:	c6 45 f7 00          	movb   $0x0,-0x9(%ebp)
		while (Chose != 'y' && Chose != 'n')
  8003be:	eb 42                	jmp    800402 <_main+0x3ca>
		{
			cprintf("Do you want to repeat (y/n): ") ;
  8003c0:	83 ec 0c             	sub    $0xc,%esp
  8003c3:	68 96 27 80 00       	push   $0x802796
  8003c8:	e8 59 08 00 00       	call   800c26 <cprintf>
  8003cd:	83 c4 10             	add    $0x10,%esp
			Chose = getchar() ;
  8003d0:	e8 29 04 00 00       	call   8007fe <getchar>
  8003d5:	88 45 f7             	mov    %al,-0x9(%ebp)
			cputchar(Chose);
  8003d8:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8003dc:	83 ec 0c             	sub    $0xc,%esp
  8003df:	50                   	push   %eax
  8003e0:	e8 d1 03 00 00       	call   8007b6 <cputchar>
  8003e5:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003e8:	83 ec 0c             	sub    $0xc,%esp
  8003eb:	6a 0a                	push   $0xa
  8003ed:	e8 c4 03 00 00       	call   8007b6 <cputchar>
  8003f2:	83 c4 10             	add    $0x10,%esp
			cputchar('\n');
  8003f5:	83 ec 0c             	sub    $0xc,%esp
  8003f8:	6a 0a                	push   $0xa
  8003fa:	e8 b7 03 00 00       	call   8007b6 <cputchar>
  8003ff:	83 c4 10             	add    $0x10,%esp
			assert(CurrFreeFrames - InitFreeFrames == 0) ;
		}
		///========================================================================
	sys_disable_interrupt();
		Chose = 0 ;
		while (Chose != 'y' && Chose != 'n')
  800402:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800406:	74 06                	je     80040e <_main+0x3d6>
  800408:	80 7d f7 6e          	cmpb   $0x6e,-0x9(%ebp)
  80040c:	75 b2                	jne    8003c0 <_main+0x388>
			Chose = getchar() ;
			cputchar(Chose);
			cputchar('\n');
			cputchar('\n');
		}
	sys_enable_interrupt();
  80040e:	e8 e9 1a 00 00       	call   801efc <sys_enable_interrupt>

	} while (Chose == 'y');
  800413:	80 7d f7 79          	cmpb   $0x79,-0x9(%ebp)
  800417:	0f 84 2c fc ff ff    	je     800049 <_main+0x11>
}
  80041d:	90                   	nop
  80041e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800421:	c9                   	leave  
  800422:	c3                   	ret    

00800423 <CheckAndCountEmptyLocInWS>:

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
  800423:	55                   	push   %ebp
  800424:	89 e5                	mov    %esp,%ebp
  800426:	83 ec 18             	sub    $0x18,%esp
	int numOFEmptyLocInWS = 0, i;
  800429:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  800430:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800437:	eb 74                	jmp    8004ad <CheckAndCountEmptyLocInWS+0x8a>
	{
		if (myEnv->__uptr_pws[i].empty)
  800439:	8b 45 08             	mov    0x8(%ebp),%eax
  80043c:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800442:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800445:	89 d0                	mov    %edx,%eax
  800447:	01 c0                	add    %eax,%eax
  800449:	01 d0                	add    %edx,%eax
  80044b:	c1 e0 03             	shl    $0x3,%eax
  80044e:	01 c8                	add    %ecx,%eax
  800450:	8a 40 04             	mov    0x4(%eax),%al
  800453:	84 c0                	test   %al,%al
  800455:	74 05                	je     80045c <CheckAndCountEmptyLocInWS+0x39>
		{
			numOFEmptyLocInWS++;
  800457:	ff 45 f4             	incl   -0xc(%ebp)
  80045a:	eb 4e                	jmp    8004aa <CheckAndCountEmptyLocInWS+0x87>
		}
		else
		{
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
  80045c:	8b 45 08             	mov    0x8(%ebp),%eax
  80045f:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800465:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800468:	89 d0                	mov    %edx,%eax
  80046a:	01 c0                	add    %eax,%eax
  80046c:	01 d0                	add    %edx,%eax
  80046e:	c1 e0 03             	shl    $0x3,%eax
  800471:	01 c8                	add    %ecx,%eax
  800473:	8b 00                	mov    (%eax),%eax
  800475:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800478:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80047b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800480:	89 45 e8             	mov    %eax,-0x18(%ebp)
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
  800483:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800486:	85 c0                	test   %eax,%eax
  800488:	79 20                	jns    8004aa <CheckAndCountEmptyLocInWS+0x87>
  80048a:	81 7d e8 ff ff ff 9f 	cmpl   $0x9fffffff,-0x18(%ebp)
  800491:	77 17                	ja     8004aa <CheckAndCountEmptyLocInWS+0x87>
				panic("freeMem didn't remove its page(s) from the WS");
  800493:	83 ec 04             	sub    $0x4,%esp
  800496:	68 b4 27 80 00       	push   $0x8027b4
  80049b:	68 9f 00 00 00       	push   $0x9f
  8004a0:	68 3e 26 80 00       	push   $0x80263e
  8004a5:	e8 c8 04 00 00       	call   800972 <_panic>
}

int CheckAndCountEmptyLocInWS(volatile struct Env *myEnv)
{
	int numOFEmptyLocInWS = 0, i;
	for (i = 0 ; i < myEnv->page_WS_max_size; i++)
  8004aa:	ff 45 f0             	incl   -0x10(%ebp)
  8004ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b0:	8b 50 74             	mov    0x74(%eax),%edx
  8004b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004b6:	39 c2                	cmp    %eax,%edx
  8004b8:	0f 87 7b ff ff ff    	ja     800439 <CheckAndCountEmptyLocInWS+0x16>
			uint32 va = ROUNDDOWN(myEnv->__uptr_pws[i].virtual_address,PAGE_SIZE) ;
			if (va >= USER_HEAP_START && va < (USER_HEAP_MAX))
				panic("freeMem didn't remove its page(s) from the WS");
		}
	}
	return numOFEmptyLocInWS;
  8004be:	8b 45 f4             	mov    -0xc(%ebp),%eax

}
  8004c1:	c9                   	leave  
  8004c2:	c3                   	ret    

008004c3 <QuickSort>:

///Quick sort
void QuickSort(int *Elements, int NumOfElements)
{
  8004c3:	55                   	push   %ebp
  8004c4:	89 e5                	mov    %esp,%ebp
  8004c6:	83 ec 08             	sub    $0x8,%esp
	QSort(Elements, NumOfElements, 0, NumOfElements-1) ;
  8004c9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004cc:	48                   	dec    %eax
  8004cd:	50                   	push   %eax
  8004ce:	6a 00                	push   $0x0
  8004d0:	ff 75 0c             	pushl  0xc(%ebp)
  8004d3:	ff 75 08             	pushl  0x8(%ebp)
  8004d6:	e8 06 00 00 00       	call   8004e1 <QSort>
  8004db:	83 c4 10             	add    $0x10,%esp
}
  8004de:	90                   	nop
  8004df:	c9                   	leave  
  8004e0:	c3                   	ret    

008004e1 <QSort>:


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
  8004e1:	55                   	push   %ebp
  8004e2:	89 e5                	mov    %esp,%ebp
  8004e4:	83 ec 18             	sub    $0x18,%esp
	if (startIndex >= finalIndex) return;
  8004e7:	8b 45 10             	mov    0x10(%ebp),%eax
  8004ea:	3b 45 14             	cmp    0x14(%ebp),%eax
  8004ed:	0f 8d de 00 00 00    	jge    8005d1 <QSort+0xf0>

	int i = startIndex+1, j = finalIndex;
  8004f3:	8b 45 10             	mov    0x10(%ebp),%eax
  8004f6:	40                   	inc    %eax
  8004f7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8004fa:	8b 45 14             	mov    0x14(%ebp),%eax
  8004fd:	89 45 f0             	mov    %eax,-0x10(%ebp)

	while (i <= j)
  800500:	e9 80 00 00 00       	jmp    800585 <QSort+0xa4>
	{
		while (i <= finalIndex && Elements[startIndex] >= Elements[i]) i++;
  800505:	ff 45 f4             	incl   -0xc(%ebp)
  800508:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80050b:	3b 45 14             	cmp    0x14(%ebp),%eax
  80050e:	7f 2b                	jg     80053b <QSort+0x5a>
  800510:	8b 45 10             	mov    0x10(%ebp),%eax
  800513:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80051a:	8b 45 08             	mov    0x8(%ebp),%eax
  80051d:	01 d0                	add    %edx,%eax
  80051f:	8b 10                	mov    (%eax),%edx
  800521:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800524:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80052b:	8b 45 08             	mov    0x8(%ebp),%eax
  80052e:	01 c8                	add    %ecx,%eax
  800530:	8b 00                	mov    (%eax),%eax
  800532:	39 c2                	cmp    %eax,%edx
  800534:	7d cf                	jge    800505 <QSort+0x24>
		while (j > startIndex && Elements[startIndex] <= Elements[j]) j--;
  800536:	eb 03                	jmp    80053b <QSort+0x5a>
  800538:	ff 4d f0             	decl   -0x10(%ebp)
  80053b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80053e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800541:	7e 26                	jle    800569 <QSort+0x88>
  800543:	8b 45 10             	mov    0x10(%ebp),%eax
  800546:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80054d:	8b 45 08             	mov    0x8(%ebp),%eax
  800550:	01 d0                	add    %edx,%eax
  800552:	8b 10                	mov    (%eax),%edx
  800554:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800557:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80055e:	8b 45 08             	mov    0x8(%ebp),%eax
  800561:	01 c8                	add    %ecx,%eax
  800563:	8b 00                	mov    (%eax),%eax
  800565:	39 c2                	cmp    %eax,%edx
  800567:	7e cf                	jle    800538 <QSort+0x57>

		if (i <= j)
  800569:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80056c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80056f:	7f 14                	jg     800585 <QSort+0xa4>
		{
			Swap(Elements, i, j);
  800571:	83 ec 04             	sub    $0x4,%esp
  800574:	ff 75 f0             	pushl  -0x10(%ebp)
  800577:	ff 75 f4             	pushl  -0xc(%ebp)
  80057a:	ff 75 08             	pushl  0x8(%ebp)
  80057d:	e8 a9 00 00 00       	call   80062b <Swap>
  800582:	83 c4 10             	add    $0x10,%esp
{
	if (startIndex >= finalIndex) return;

	int i = startIndex+1, j = finalIndex;

	while (i <= j)
  800585:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800588:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80058b:	0f 8e 77 ff ff ff    	jle    800508 <QSort+0x27>
		{
			Swap(Elements, i, j);
		}
	}

	Swap( Elements, startIndex, j);
  800591:	83 ec 04             	sub    $0x4,%esp
  800594:	ff 75 f0             	pushl  -0x10(%ebp)
  800597:	ff 75 10             	pushl  0x10(%ebp)
  80059a:	ff 75 08             	pushl  0x8(%ebp)
  80059d:	e8 89 00 00 00       	call   80062b <Swap>
  8005a2:	83 c4 10             	add    $0x10,%esp

	QSort(Elements, NumOfElements, startIndex, j - 1);
  8005a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005a8:	48                   	dec    %eax
  8005a9:	50                   	push   %eax
  8005aa:	ff 75 10             	pushl  0x10(%ebp)
  8005ad:	ff 75 0c             	pushl  0xc(%ebp)
  8005b0:	ff 75 08             	pushl  0x8(%ebp)
  8005b3:	e8 29 ff ff ff       	call   8004e1 <QSort>
  8005b8:	83 c4 10             	add    $0x10,%esp
	QSort(Elements, NumOfElements, i, finalIndex);
  8005bb:	ff 75 14             	pushl  0x14(%ebp)
  8005be:	ff 75 f4             	pushl  -0xc(%ebp)
  8005c1:	ff 75 0c             	pushl  0xc(%ebp)
  8005c4:	ff 75 08             	pushl  0x8(%ebp)
  8005c7:	e8 15 ff ff ff       	call   8004e1 <QSort>
  8005cc:	83 c4 10             	add    $0x10,%esp
  8005cf:	eb 01                	jmp    8005d2 <QSort+0xf1>
}


void QSort(int *Elements,int NumOfElements, int startIndex, int finalIndex)
{
	if (startIndex >= finalIndex) return;
  8005d1:	90                   	nop

	Swap( Elements, startIndex, j);

	QSort(Elements, NumOfElements, startIndex, j - 1);
	QSort(Elements, NumOfElements, i, finalIndex);
}
  8005d2:	c9                   	leave  
  8005d3:	c3                   	ret    

008005d4 <CheckSorted>:

uint32 CheckSorted(int *Elements, int NumOfElements)
{
  8005d4:	55                   	push   %ebp
  8005d5:	89 e5                	mov    %esp,%ebp
  8005d7:	83 ec 10             	sub    $0x10,%esp
	uint32 Sorted = 1 ;
  8005da:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  8005e1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8005e8:	eb 33                	jmp    80061d <CheckSorted+0x49>
	{
		if (Elements[i] > Elements[i+1])
  8005ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005ed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8005f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8005f7:	01 d0                	add    %edx,%eax
  8005f9:	8b 10                	mov    (%eax),%edx
  8005fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8005fe:	40                   	inc    %eax
  8005ff:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800606:	8b 45 08             	mov    0x8(%ebp),%eax
  800609:	01 c8                	add    %ecx,%eax
  80060b:	8b 00                	mov    (%eax),%eax
  80060d:	39 c2                	cmp    %eax,%edx
  80060f:	7e 09                	jle    80061a <CheckSorted+0x46>
		{
			Sorted = 0 ;
  800611:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
			break;
  800618:	eb 0c                	jmp    800626 <CheckSorted+0x52>

uint32 CheckSorted(int *Elements, int NumOfElements)
{
	uint32 Sorted = 1 ;
	int i ;
	for (i = 0 ; i < NumOfElements - 1; i++)
  80061a:	ff 45 f8             	incl   -0x8(%ebp)
  80061d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800620:	48                   	dec    %eax
  800621:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800624:	7f c4                	jg     8005ea <CheckSorted+0x16>
		{
			Sorted = 0 ;
			break;
		}
	}
	return Sorted ;
  800626:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800629:	c9                   	leave  
  80062a:	c3                   	ret    

0080062b <Swap>:

///Private Functions


void Swap(int *Elements, int First, int Second)
{
  80062b:	55                   	push   %ebp
  80062c:	89 e5                	mov    %esp,%ebp
  80062e:	83 ec 10             	sub    $0x10,%esp
	int Tmp = Elements[First] ;
  800631:	8b 45 0c             	mov    0xc(%ebp),%eax
  800634:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80063b:	8b 45 08             	mov    0x8(%ebp),%eax
  80063e:	01 d0                	add    %edx,%eax
  800640:	8b 00                	mov    (%eax),%eax
  800642:	89 45 fc             	mov    %eax,-0x4(%ebp)
	Elements[First] = Elements[Second] ;
  800645:	8b 45 0c             	mov    0xc(%ebp),%eax
  800648:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80064f:	8b 45 08             	mov    0x8(%ebp),%eax
  800652:	01 c2                	add    %eax,%edx
  800654:	8b 45 10             	mov    0x10(%ebp),%eax
  800657:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80065e:	8b 45 08             	mov    0x8(%ebp),%eax
  800661:	01 c8                	add    %ecx,%eax
  800663:	8b 00                	mov    (%eax),%eax
  800665:	89 02                	mov    %eax,(%edx)
	Elements[Second] = Tmp ;
  800667:	8b 45 10             	mov    0x10(%ebp),%eax
  80066a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800671:	8b 45 08             	mov    0x8(%ebp),%eax
  800674:	01 c2                	add    %eax,%edx
  800676:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800679:	89 02                	mov    %eax,(%edx)
}
  80067b:	90                   	nop
  80067c:	c9                   	leave  
  80067d:	c3                   	ret    

0080067e <InitializeAscending>:

void InitializeAscending(int *Elements, int NumOfElements)
{
  80067e:	55                   	push   %ebp
  80067f:	89 e5                	mov    %esp,%ebp
  800681:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  800684:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80068b:	eb 17                	jmp    8006a4 <InitializeAscending+0x26>
	{
		(Elements)[i] = i ;
  80068d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800690:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800697:	8b 45 08             	mov    0x8(%ebp),%eax
  80069a:	01 c2                	add    %eax,%edx
  80069c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80069f:	89 02                	mov    %eax,(%edx)
}

void InitializeAscending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006a1:	ff 45 fc             	incl   -0x4(%ebp)
  8006a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006a7:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006aa:	7c e1                	jl     80068d <InitializeAscending+0xf>
	{
		(Elements)[i] = i ;
	}

}
  8006ac:	90                   	nop
  8006ad:	c9                   	leave  
  8006ae:	c3                   	ret    

008006af <InitializeDescending>:

void InitializeDescending(int *Elements, int NumOfElements)
{
  8006af:	55                   	push   %ebp
  8006b0:	89 e5                	mov    %esp,%ebp
  8006b2:	83 ec 10             	sub    $0x10,%esp
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006b5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8006bc:	eb 1b                	jmp    8006d9 <InitializeDescending+0x2a>
	{
		Elements[i] = NumOfElements - i - 1 ;
  8006be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006c1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8006c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8006cb:	01 c2                	add    %eax,%edx
  8006cd:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d0:	2b 45 fc             	sub    -0x4(%ebp),%eax
  8006d3:	48                   	dec    %eax
  8006d4:	89 02                	mov    %eax,(%edx)
}

void InitializeDescending(int *Elements, int NumOfElements)
{
	int i ;
	for (i = 0 ; i < NumOfElements ; i++)
  8006d6:	ff 45 fc             	incl   -0x4(%ebp)
  8006d9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8006dc:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8006df:	7c dd                	jl     8006be <InitializeDescending+0xf>
	{
		Elements[i] = NumOfElements - i - 1 ;
	}

}
  8006e1:	90                   	nop
  8006e2:	c9                   	leave  
  8006e3:	c3                   	ret    

008006e4 <InitializeSemiRandom>:

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
  8006e4:	55                   	push   %ebp
  8006e5:	89 e5                	mov    %esp,%ebp
  8006e7:	83 ec 10             	sub    $0x10,%esp
	int i ;
	int Repetition = NumOfElements / 3 ;
  8006ea:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  8006ed:	b8 56 55 55 55       	mov    $0x55555556,%eax
  8006f2:	f7 e9                	imul   %ecx
  8006f4:	c1 f9 1f             	sar    $0x1f,%ecx
  8006f7:	89 d0                	mov    %edx,%eax
  8006f9:	29 c8                	sub    %ecx,%eax
  8006fb:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0 ; i < NumOfElements ; i++)
  8006fe:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800705:	eb 1e                	jmp    800725 <InitializeSemiRandom+0x41>
	{
		Elements[i] = i % Repetition ;
  800707:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80070a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800711:	8b 45 08             	mov    0x8(%ebp),%eax
  800714:	8d 0c 02             	lea    (%edx,%eax,1),%ecx
  800717:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80071a:	99                   	cltd   
  80071b:	f7 7d f8             	idivl  -0x8(%ebp)
  80071e:	89 d0                	mov    %edx,%eax
  800720:	89 01                	mov    %eax,(%ecx)

void InitializeSemiRandom(int *Elements, int NumOfElements)
{
	int i ;
	int Repetition = NumOfElements / 3 ;
	for (i = 0 ; i < NumOfElements ; i++)
  800722:	ff 45 fc             	incl   -0x4(%ebp)
  800725:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800728:	3b 45 0c             	cmp    0xc(%ebp),%eax
  80072b:	7c da                	jl     800707 <InitializeSemiRandom+0x23>
	{
		Elements[i] = i % Repetition ;
	}

}
  80072d:	90                   	nop
  80072e:	c9                   	leave  
  80072f:	c3                   	ret    

00800730 <PrintElements>:

void PrintElements(int *Elements, int NumOfElements)
{
  800730:	55                   	push   %ebp
  800731:	89 e5                	mov    %esp,%ebp
  800733:	83 ec 18             	sub    $0x18,%esp
	int i ;
	int NumsPerLine = 20 ;
  800736:	c7 45 f0 14 00 00 00 	movl   $0x14,-0x10(%ebp)
	for (i = 0 ; i < NumOfElements-1 ; i++)
  80073d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800744:	eb 42                	jmp    800788 <PrintElements+0x58>
	{
		if (i%NumsPerLine == 0)
  800746:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800749:	99                   	cltd   
  80074a:	f7 7d f0             	idivl  -0x10(%ebp)
  80074d:	89 d0                	mov    %edx,%eax
  80074f:	85 c0                	test   %eax,%eax
  800751:	75 10                	jne    800763 <PrintElements+0x33>
			cprintf("\n");
  800753:	83 ec 0c             	sub    $0xc,%esp
  800756:	68 e2 27 80 00       	push   $0x8027e2
  80075b:	e8 c6 04 00 00       	call   800c26 <cprintf>
  800760:	83 c4 10             	add    $0x10,%esp
		cprintf("%d, ",Elements[i]);
  800763:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800766:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80076d:	8b 45 08             	mov    0x8(%ebp),%eax
  800770:	01 d0                	add    %edx,%eax
  800772:	8b 00                	mov    (%eax),%eax
  800774:	83 ec 08             	sub    $0x8,%esp
  800777:	50                   	push   %eax
  800778:	68 e4 27 80 00       	push   $0x8027e4
  80077d:	e8 a4 04 00 00       	call   800c26 <cprintf>
  800782:	83 c4 10             	add    $0x10,%esp

void PrintElements(int *Elements, int NumOfElements)
{
	int i ;
	int NumsPerLine = 20 ;
	for (i = 0 ; i < NumOfElements-1 ; i++)
  800785:	ff 45 f4             	incl   -0xc(%ebp)
  800788:	8b 45 0c             	mov    0xc(%ebp),%eax
  80078b:	48                   	dec    %eax
  80078c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80078f:	7f b5                	jg     800746 <PrintElements+0x16>
	{
		if (i%NumsPerLine == 0)
			cprintf("\n");
		cprintf("%d, ",Elements[i]);
	}
	cprintf("%d\n",Elements[i]);
  800791:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800794:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80079b:	8b 45 08             	mov    0x8(%ebp),%eax
  80079e:	01 d0                	add    %edx,%eax
  8007a0:	8b 00                	mov    (%eax),%eax
  8007a2:	83 ec 08             	sub    $0x8,%esp
  8007a5:	50                   	push   %eax
  8007a6:	68 e9 27 80 00       	push   $0x8027e9
  8007ab:	e8 76 04 00 00       	call   800c26 <cprintf>
  8007b0:	83 c4 10             	add    $0x10,%esp

}
  8007b3:	90                   	nop
  8007b4:	c9                   	leave  
  8007b5:	c3                   	ret    

008007b6 <cputchar>:
#include <inc/lib.h>


void
cputchar(int ch)
{
  8007b6:	55                   	push   %ebp
  8007b7:	89 e5                	mov    %esp,%ebp
  8007b9:	83 ec 18             	sub    $0x18,%esp
	char c = ch;
  8007bc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bf:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007c2:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007c6:	83 ec 0c             	sub    $0xc,%esp
  8007c9:	50                   	push   %eax
  8007ca:	e8 47 17 00 00       	call   801f16 <sys_cputc>
  8007cf:	83 c4 10             	add    $0x10,%esp
}
  8007d2:	90                   	nop
  8007d3:	c9                   	leave  
  8007d4:	c3                   	ret    

008007d5 <atomic_cputchar>:


void
atomic_cputchar(int ch)
{
  8007d5:	55                   	push   %ebp
  8007d6:	89 e5                	mov    %esp,%ebp
  8007d8:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8007db:	e8 02 17 00 00       	call   801ee2 <sys_disable_interrupt>
	char c = ch;
  8007e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e3:	88 45 f7             	mov    %al,-0x9(%ebp)

	// Unlike standard Unix's putchar,
	// the cputchar function _always_ outputs to the system console.
	//sys_cputs(&c, 1);

	sys_cputc(c);
  8007e6:	0f be 45 f7          	movsbl -0x9(%ebp),%eax
  8007ea:	83 ec 0c             	sub    $0xc,%esp
  8007ed:	50                   	push   %eax
  8007ee:	e8 23 17 00 00       	call   801f16 <sys_cputc>
  8007f3:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8007f6:	e8 01 17 00 00       	call   801efc <sys_enable_interrupt>
}
  8007fb:	90                   	nop
  8007fc:	c9                   	leave  
  8007fd:	c3                   	ret    

008007fe <getchar>:

int
getchar(void)
{
  8007fe:	55                   	push   %ebp
  8007ff:	89 e5                	mov    %esp,%ebp
  800801:	83 ec 18             	sub    $0x18,%esp

	//return sys_cgetc();
	int c=0;
  800804:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  80080b:	eb 08                	jmp    800815 <getchar+0x17>
	{
		c = sys_cgetc();
  80080d:	e8 e8 14 00 00       	call   801cfa <sys_cgetc>
  800812:	89 45 f4             	mov    %eax,-0xc(%ebp)
getchar(void)
{

	//return sys_cgetc();
	int c=0;
	while(c == 0)
  800815:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800819:	74 f2                	je     80080d <getchar+0xf>
	{
		c = sys_cgetc();
	}
	return c;
  80081b:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80081e:	c9                   	leave  
  80081f:	c3                   	ret    

00800820 <atomic_getchar>:

int
atomic_getchar(void)
{
  800820:	55                   	push   %ebp
  800821:	89 e5                	mov    %esp,%ebp
  800823:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800826:	e8 b7 16 00 00       	call   801ee2 <sys_disable_interrupt>
	int c=0;
  80082b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	while(c == 0)
  800832:	eb 08                	jmp    80083c <atomic_getchar+0x1c>
	{
		c = sys_cgetc();
  800834:	e8 c1 14 00 00       	call   801cfa <sys_cgetc>
  800839:	89 45 f4             	mov    %eax,-0xc(%ebp)
int
atomic_getchar(void)
{
	sys_disable_interrupt();
	int c=0;
	while(c == 0)
  80083c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  800840:	74 f2                	je     800834 <atomic_getchar+0x14>
	{
		c = sys_cgetc();
	}
	sys_enable_interrupt();
  800842:	e8 b5 16 00 00       	call   801efc <sys_enable_interrupt>
	return c;
  800847:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80084a:	c9                   	leave  
  80084b:	c3                   	ret    

0080084c <iscons>:

int iscons(int fdnum)
{
  80084c:	55                   	push   %ebp
  80084d:	89 e5                	mov    %esp,%ebp
	// used by readline
	return 1;
  80084f:	b8 01 00 00 00       	mov    $0x1,%eax
}
  800854:	5d                   	pop    %ebp
  800855:	c3                   	ret    

00800856 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800856:	55                   	push   %ebp
  800857:	89 e5                	mov    %esp,%ebp
  800859:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80085c:	e8 e6 14 00 00       	call   801d47 <sys_getenvindex>
  800861:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800864:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800867:	89 d0                	mov    %edx,%eax
  800869:	01 c0                	add    %eax,%eax
  80086b:	01 d0                	add    %edx,%eax
  80086d:	c1 e0 04             	shl    $0x4,%eax
  800870:	29 d0                	sub    %edx,%eax
  800872:	c1 e0 03             	shl    $0x3,%eax
  800875:	01 d0                	add    %edx,%eax
  800877:	c1 e0 02             	shl    $0x2,%eax
  80087a:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80087f:	a3 24 30 80 00       	mov    %eax,0x803024

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800884:	a1 24 30 80 00       	mov    0x803024,%eax
  800889:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80088f:	84 c0                	test   %al,%al
  800891:	74 0f                	je     8008a2 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800893:	a1 24 30 80 00       	mov    0x803024,%eax
  800898:	05 5c 05 00 00       	add    $0x55c,%eax
  80089d:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8008a2:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8008a6:	7e 0a                	jle    8008b2 <libmain+0x5c>
		binaryname = argv[0];
  8008a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008ab:	8b 00                	mov    (%eax),%eax
  8008ad:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  8008b2:	83 ec 08             	sub    $0x8,%esp
  8008b5:	ff 75 0c             	pushl  0xc(%ebp)
  8008b8:	ff 75 08             	pushl  0x8(%ebp)
  8008bb:	e8 78 f7 ff ff       	call   800038 <_main>
  8008c0:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8008c3:	e8 1a 16 00 00       	call   801ee2 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8008c8:	83 ec 0c             	sub    $0xc,%esp
  8008cb:	68 08 28 80 00       	push   $0x802808
  8008d0:	e8 51 03 00 00       	call   800c26 <cprintf>
  8008d5:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8008d8:	a1 24 30 80 00       	mov    0x803024,%eax
  8008dd:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8008e3:	a1 24 30 80 00       	mov    0x803024,%eax
  8008e8:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8008ee:	83 ec 04             	sub    $0x4,%esp
  8008f1:	52                   	push   %edx
  8008f2:	50                   	push   %eax
  8008f3:	68 30 28 80 00       	push   $0x802830
  8008f8:	e8 29 03 00 00       	call   800c26 <cprintf>
  8008fd:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800900:	a1 24 30 80 00       	mov    0x803024,%eax
  800905:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80090b:	a1 24 30 80 00       	mov    0x803024,%eax
  800910:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800916:	a1 24 30 80 00       	mov    0x803024,%eax
  80091b:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800921:	51                   	push   %ecx
  800922:	52                   	push   %edx
  800923:	50                   	push   %eax
  800924:	68 58 28 80 00       	push   $0x802858
  800929:	e8 f8 02 00 00       	call   800c26 <cprintf>
  80092e:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800931:	83 ec 0c             	sub    $0xc,%esp
  800934:	68 08 28 80 00       	push   $0x802808
  800939:	e8 e8 02 00 00       	call   800c26 <cprintf>
  80093e:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800941:	e8 b6 15 00 00       	call   801efc <sys_enable_interrupt>

	// exit gracefully
	exit();
  800946:	e8 19 00 00 00       	call   800964 <exit>
}
  80094b:	90                   	nop
  80094c:	c9                   	leave  
  80094d:	c3                   	ret    

0080094e <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80094e:	55                   	push   %ebp
  80094f:	89 e5                	mov    %esp,%ebp
  800951:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800954:	83 ec 0c             	sub    $0xc,%esp
  800957:	6a 00                	push   $0x0
  800959:	e8 b5 13 00 00       	call   801d13 <sys_env_destroy>
  80095e:	83 c4 10             	add    $0x10,%esp
}
  800961:	90                   	nop
  800962:	c9                   	leave  
  800963:	c3                   	ret    

00800964 <exit>:

void
exit(void)
{
  800964:	55                   	push   %ebp
  800965:	89 e5                	mov    %esp,%ebp
  800967:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80096a:	e8 0a 14 00 00       	call   801d79 <sys_env_exit>
}
  80096f:	90                   	nop
  800970:	c9                   	leave  
  800971:	c3                   	ret    

00800972 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800972:	55                   	push   %ebp
  800973:	89 e5                	mov    %esp,%ebp
  800975:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800978:	8d 45 10             	lea    0x10(%ebp),%eax
  80097b:	83 c0 04             	add    $0x4,%eax
  80097e:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800981:	a1 18 31 80 00       	mov    0x803118,%eax
  800986:	85 c0                	test   %eax,%eax
  800988:	74 16                	je     8009a0 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80098a:	a1 18 31 80 00       	mov    0x803118,%eax
  80098f:	83 ec 08             	sub    $0x8,%esp
  800992:	50                   	push   %eax
  800993:	68 b0 28 80 00       	push   $0x8028b0
  800998:	e8 89 02 00 00       	call   800c26 <cprintf>
  80099d:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8009a0:	a1 00 30 80 00       	mov    0x803000,%eax
  8009a5:	ff 75 0c             	pushl  0xc(%ebp)
  8009a8:	ff 75 08             	pushl  0x8(%ebp)
  8009ab:	50                   	push   %eax
  8009ac:	68 b5 28 80 00       	push   $0x8028b5
  8009b1:	e8 70 02 00 00       	call   800c26 <cprintf>
  8009b6:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8009b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8009bc:	83 ec 08             	sub    $0x8,%esp
  8009bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8009c2:	50                   	push   %eax
  8009c3:	e8 f3 01 00 00       	call   800bbb <vcprintf>
  8009c8:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8009cb:	83 ec 08             	sub    $0x8,%esp
  8009ce:	6a 00                	push   $0x0
  8009d0:	68 d1 28 80 00       	push   $0x8028d1
  8009d5:	e8 e1 01 00 00       	call   800bbb <vcprintf>
  8009da:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8009dd:	e8 82 ff ff ff       	call   800964 <exit>

	// should not return here
	while (1) ;
  8009e2:	eb fe                	jmp    8009e2 <_panic+0x70>

008009e4 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8009e4:	55                   	push   %ebp
  8009e5:	89 e5                	mov    %esp,%ebp
  8009e7:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8009ea:	a1 24 30 80 00       	mov    0x803024,%eax
  8009ef:	8b 50 74             	mov    0x74(%eax),%edx
  8009f2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8009f5:	39 c2                	cmp    %eax,%edx
  8009f7:	74 14                	je     800a0d <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8009f9:	83 ec 04             	sub    $0x4,%esp
  8009fc:	68 d4 28 80 00       	push   $0x8028d4
  800a01:	6a 26                	push   $0x26
  800a03:	68 20 29 80 00       	push   $0x802920
  800a08:	e8 65 ff ff ff       	call   800972 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800a0d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800a14:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  800a1b:	e9 c2 00 00 00       	jmp    800ae2 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  800a20:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a23:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800a2a:	8b 45 08             	mov    0x8(%ebp),%eax
  800a2d:	01 d0                	add    %edx,%eax
  800a2f:	8b 00                	mov    (%eax),%eax
  800a31:	85 c0                	test   %eax,%eax
  800a33:	75 08                	jne    800a3d <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800a35:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800a38:	e9 a2 00 00 00       	jmp    800adf <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800a3d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800a44:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800a4b:	eb 69                	jmp    800ab6 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800a4d:	a1 24 30 80 00       	mov    0x803024,%eax
  800a52:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800a58:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a5b:	89 d0                	mov    %edx,%eax
  800a5d:	01 c0                	add    %eax,%eax
  800a5f:	01 d0                	add    %edx,%eax
  800a61:	c1 e0 03             	shl    $0x3,%eax
  800a64:	01 c8                	add    %ecx,%eax
  800a66:	8a 40 04             	mov    0x4(%eax),%al
  800a69:	84 c0                	test   %al,%al
  800a6b:	75 46                	jne    800ab3 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800a6d:	a1 24 30 80 00       	mov    0x803024,%eax
  800a72:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800a78:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800a7b:	89 d0                	mov    %edx,%eax
  800a7d:	01 c0                	add    %eax,%eax
  800a7f:	01 d0                	add    %edx,%eax
  800a81:	c1 e0 03             	shl    $0x3,%eax
  800a84:	01 c8                	add    %ecx,%eax
  800a86:	8b 00                	mov    (%eax),%eax
  800a88:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800a8b:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800a8e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800a93:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800a95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a98:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800a9f:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa2:	01 c8                	add    %ecx,%eax
  800aa4:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800aa6:	39 c2                	cmp    %eax,%edx
  800aa8:	75 09                	jne    800ab3 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800aaa:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800ab1:	eb 12                	jmp    800ac5 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800ab3:	ff 45 e8             	incl   -0x18(%ebp)
  800ab6:	a1 24 30 80 00       	mov    0x803024,%eax
  800abb:	8b 50 74             	mov    0x74(%eax),%edx
  800abe:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800ac1:	39 c2                	cmp    %eax,%edx
  800ac3:	77 88                	ja     800a4d <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800ac5:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800ac9:	75 14                	jne    800adf <CheckWSWithoutLastIndex+0xfb>
			panic(
  800acb:	83 ec 04             	sub    $0x4,%esp
  800ace:	68 2c 29 80 00       	push   $0x80292c
  800ad3:	6a 3a                	push   $0x3a
  800ad5:	68 20 29 80 00       	push   $0x802920
  800ada:	e8 93 fe ff ff       	call   800972 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800adf:	ff 45 f0             	incl   -0x10(%ebp)
  800ae2:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ae5:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800ae8:	0f 8c 32 ff ff ff    	jl     800a20 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800aee:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800af5:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800afc:	eb 26                	jmp    800b24 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800afe:	a1 24 30 80 00       	mov    0x803024,%eax
  800b03:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800b09:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800b0c:	89 d0                	mov    %edx,%eax
  800b0e:	01 c0                	add    %eax,%eax
  800b10:	01 d0                	add    %edx,%eax
  800b12:	c1 e0 03             	shl    $0x3,%eax
  800b15:	01 c8                	add    %ecx,%eax
  800b17:	8a 40 04             	mov    0x4(%eax),%al
  800b1a:	3c 01                	cmp    $0x1,%al
  800b1c:	75 03                	jne    800b21 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  800b1e:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800b21:	ff 45 e0             	incl   -0x20(%ebp)
  800b24:	a1 24 30 80 00       	mov    0x803024,%eax
  800b29:	8b 50 74             	mov    0x74(%eax),%edx
  800b2c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800b2f:	39 c2                	cmp    %eax,%edx
  800b31:	77 cb                	ja     800afe <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800b36:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800b39:	74 14                	je     800b4f <CheckWSWithoutLastIndex+0x16b>
		panic(
  800b3b:	83 ec 04             	sub    $0x4,%esp
  800b3e:	68 80 29 80 00       	push   $0x802980
  800b43:	6a 44                	push   $0x44
  800b45:	68 20 29 80 00       	push   $0x802920
  800b4a:	e8 23 fe ff ff       	call   800972 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800b4f:	90                   	nop
  800b50:	c9                   	leave  
  800b51:	c3                   	ret    

00800b52 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800b52:	55                   	push   %ebp
  800b53:	89 e5                	mov    %esp,%ebp
  800b55:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800b58:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b5b:	8b 00                	mov    (%eax),%eax
  800b5d:	8d 48 01             	lea    0x1(%eax),%ecx
  800b60:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b63:	89 0a                	mov    %ecx,(%edx)
  800b65:	8b 55 08             	mov    0x8(%ebp),%edx
  800b68:	88 d1                	mov    %dl,%cl
  800b6a:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b6d:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800b71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b74:	8b 00                	mov    (%eax),%eax
  800b76:	3d ff 00 00 00       	cmp    $0xff,%eax
  800b7b:	75 2c                	jne    800ba9 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800b7d:	a0 28 30 80 00       	mov    0x803028,%al
  800b82:	0f b6 c0             	movzbl %al,%eax
  800b85:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b88:	8b 12                	mov    (%edx),%edx
  800b8a:	89 d1                	mov    %edx,%ecx
  800b8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800b8f:	83 c2 08             	add    $0x8,%edx
  800b92:	83 ec 04             	sub    $0x4,%esp
  800b95:	50                   	push   %eax
  800b96:	51                   	push   %ecx
  800b97:	52                   	push   %edx
  800b98:	e8 34 11 00 00       	call   801cd1 <sys_cputs>
  800b9d:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800ba0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ba3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800ba9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bac:	8b 40 04             	mov    0x4(%eax),%eax
  800baf:	8d 50 01             	lea    0x1(%eax),%edx
  800bb2:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bb5:	89 50 04             	mov    %edx,0x4(%eax)
}
  800bb8:	90                   	nop
  800bb9:	c9                   	leave  
  800bba:	c3                   	ret    

00800bbb <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800bbb:	55                   	push   %ebp
  800bbc:	89 e5                	mov    %esp,%ebp
  800bbe:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800bc4:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800bcb:	00 00 00 
	b.cnt = 0;
  800bce:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800bd5:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800bd8:	ff 75 0c             	pushl  0xc(%ebp)
  800bdb:	ff 75 08             	pushl  0x8(%ebp)
  800bde:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800be4:	50                   	push   %eax
  800be5:	68 52 0b 80 00       	push   $0x800b52
  800bea:	e8 11 02 00 00       	call   800e00 <vprintfmt>
  800bef:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800bf2:	a0 28 30 80 00       	mov    0x803028,%al
  800bf7:	0f b6 c0             	movzbl %al,%eax
  800bfa:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800c00:	83 ec 04             	sub    $0x4,%esp
  800c03:	50                   	push   %eax
  800c04:	52                   	push   %edx
  800c05:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800c0b:	83 c0 08             	add    $0x8,%eax
  800c0e:	50                   	push   %eax
  800c0f:	e8 bd 10 00 00       	call   801cd1 <sys_cputs>
  800c14:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800c17:	c6 05 28 30 80 00 00 	movb   $0x0,0x803028
	return b.cnt;
  800c1e:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800c24:	c9                   	leave  
  800c25:	c3                   	ret    

00800c26 <cprintf>:

int cprintf(const char *fmt, ...) {
  800c26:	55                   	push   %ebp
  800c27:	89 e5                	mov    %esp,%ebp
  800c29:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800c2c:	c6 05 28 30 80 00 01 	movb   $0x1,0x803028
	va_start(ap, fmt);
  800c33:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c36:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c39:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3c:	83 ec 08             	sub    $0x8,%esp
  800c3f:	ff 75 f4             	pushl  -0xc(%ebp)
  800c42:	50                   	push   %eax
  800c43:	e8 73 ff ff ff       	call   800bbb <vcprintf>
  800c48:	83 c4 10             	add    $0x10,%esp
  800c4b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800c4e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c51:	c9                   	leave  
  800c52:	c3                   	ret    

00800c53 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800c53:	55                   	push   %ebp
  800c54:	89 e5                	mov    %esp,%ebp
  800c56:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800c59:	e8 84 12 00 00       	call   801ee2 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800c5e:	8d 45 0c             	lea    0xc(%ebp),%eax
  800c61:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800c64:	8b 45 08             	mov    0x8(%ebp),%eax
  800c67:	83 ec 08             	sub    $0x8,%esp
  800c6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800c6d:	50                   	push   %eax
  800c6e:	e8 48 ff ff ff       	call   800bbb <vcprintf>
  800c73:	83 c4 10             	add    $0x10,%esp
  800c76:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800c79:	e8 7e 12 00 00       	call   801efc <sys_enable_interrupt>
	return cnt;
  800c7e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c81:	c9                   	leave  
  800c82:	c3                   	ret    

00800c83 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800c83:	55                   	push   %ebp
  800c84:	89 e5                	mov    %esp,%ebp
  800c86:	53                   	push   %ebx
  800c87:	83 ec 14             	sub    $0x14,%esp
  800c8a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c8d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c90:	8b 45 14             	mov    0x14(%ebp),%eax
  800c93:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800c96:	8b 45 18             	mov    0x18(%ebp),%eax
  800c99:	ba 00 00 00 00       	mov    $0x0,%edx
  800c9e:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ca1:	77 55                	ja     800cf8 <printnum+0x75>
  800ca3:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800ca6:	72 05                	jb     800cad <printnum+0x2a>
  800ca8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800cab:	77 4b                	ja     800cf8 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800cad:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800cb0:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800cb3:	8b 45 18             	mov    0x18(%ebp),%eax
  800cb6:	ba 00 00 00 00       	mov    $0x0,%edx
  800cbb:	52                   	push   %edx
  800cbc:	50                   	push   %eax
  800cbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800cc0:	ff 75 f0             	pushl  -0x10(%ebp)
  800cc3:	e8 58 16 00 00       	call   802320 <__udivdi3>
  800cc8:	83 c4 10             	add    $0x10,%esp
  800ccb:	83 ec 04             	sub    $0x4,%esp
  800cce:	ff 75 20             	pushl  0x20(%ebp)
  800cd1:	53                   	push   %ebx
  800cd2:	ff 75 18             	pushl  0x18(%ebp)
  800cd5:	52                   	push   %edx
  800cd6:	50                   	push   %eax
  800cd7:	ff 75 0c             	pushl  0xc(%ebp)
  800cda:	ff 75 08             	pushl  0x8(%ebp)
  800cdd:	e8 a1 ff ff ff       	call   800c83 <printnum>
  800ce2:	83 c4 20             	add    $0x20,%esp
  800ce5:	eb 1a                	jmp    800d01 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800ce7:	83 ec 08             	sub    $0x8,%esp
  800cea:	ff 75 0c             	pushl  0xc(%ebp)
  800ced:	ff 75 20             	pushl  0x20(%ebp)
  800cf0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cf3:	ff d0                	call   *%eax
  800cf5:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800cf8:	ff 4d 1c             	decl   0x1c(%ebp)
  800cfb:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800cff:	7f e6                	jg     800ce7 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800d01:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800d04:	bb 00 00 00 00       	mov    $0x0,%ebx
  800d09:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800d0c:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800d0f:	53                   	push   %ebx
  800d10:	51                   	push   %ecx
  800d11:	52                   	push   %edx
  800d12:	50                   	push   %eax
  800d13:	e8 18 17 00 00       	call   802430 <__umoddi3>
  800d18:	83 c4 10             	add    $0x10,%esp
  800d1b:	05 f4 2b 80 00       	add    $0x802bf4,%eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	0f be c0             	movsbl %al,%eax
  800d25:	83 ec 08             	sub    $0x8,%esp
  800d28:	ff 75 0c             	pushl  0xc(%ebp)
  800d2b:	50                   	push   %eax
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	ff d0                	call   *%eax
  800d31:	83 c4 10             	add    $0x10,%esp
}
  800d34:	90                   	nop
  800d35:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800d38:	c9                   	leave  
  800d39:	c3                   	ret    

00800d3a <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800d3a:	55                   	push   %ebp
  800d3b:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800d3d:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800d41:	7e 1c                	jle    800d5f <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8b 00                	mov    (%eax),%eax
  800d48:	8d 50 08             	lea    0x8(%eax),%edx
  800d4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d4e:	89 10                	mov    %edx,(%eax)
  800d50:	8b 45 08             	mov    0x8(%ebp),%eax
  800d53:	8b 00                	mov    (%eax),%eax
  800d55:	83 e8 08             	sub    $0x8,%eax
  800d58:	8b 50 04             	mov    0x4(%eax),%edx
  800d5b:	8b 00                	mov    (%eax),%eax
  800d5d:	eb 40                	jmp    800d9f <getuint+0x65>
	else if (lflag)
  800d5f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d63:	74 1e                	je     800d83 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800d65:	8b 45 08             	mov    0x8(%ebp),%eax
  800d68:	8b 00                	mov    (%eax),%eax
  800d6a:	8d 50 04             	lea    0x4(%eax),%edx
  800d6d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d70:	89 10                	mov    %edx,(%eax)
  800d72:	8b 45 08             	mov    0x8(%ebp),%eax
  800d75:	8b 00                	mov    (%eax),%eax
  800d77:	83 e8 04             	sub    $0x4,%eax
  800d7a:	8b 00                	mov    (%eax),%eax
  800d7c:	ba 00 00 00 00       	mov    $0x0,%edx
  800d81:	eb 1c                	jmp    800d9f <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800d83:	8b 45 08             	mov    0x8(%ebp),%eax
  800d86:	8b 00                	mov    (%eax),%eax
  800d88:	8d 50 04             	lea    0x4(%eax),%edx
  800d8b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8e:	89 10                	mov    %edx,(%eax)
  800d90:	8b 45 08             	mov    0x8(%ebp),%eax
  800d93:	8b 00                	mov    (%eax),%eax
  800d95:	83 e8 04             	sub    $0x4,%eax
  800d98:	8b 00                	mov    (%eax),%eax
  800d9a:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800d9f:	5d                   	pop    %ebp
  800da0:	c3                   	ret    

00800da1 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800da1:	55                   	push   %ebp
  800da2:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800da4:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800da8:	7e 1c                	jle    800dc6 <getint+0x25>
		return va_arg(*ap, long long);
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	8b 00                	mov    (%eax),%eax
  800daf:	8d 50 08             	lea    0x8(%eax),%edx
  800db2:	8b 45 08             	mov    0x8(%ebp),%eax
  800db5:	89 10                	mov    %edx,(%eax)
  800db7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dba:	8b 00                	mov    (%eax),%eax
  800dbc:	83 e8 08             	sub    $0x8,%eax
  800dbf:	8b 50 04             	mov    0x4(%eax),%edx
  800dc2:	8b 00                	mov    (%eax),%eax
  800dc4:	eb 38                	jmp    800dfe <getint+0x5d>
	else if (lflag)
  800dc6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dca:	74 1a                	je     800de6 <getint+0x45>
		return va_arg(*ap, long);
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	8b 00                	mov    (%eax),%eax
  800dd1:	8d 50 04             	lea    0x4(%eax),%edx
  800dd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd7:	89 10                	mov    %edx,(%eax)
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	8b 00                	mov    (%eax),%eax
  800dde:	83 e8 04             	sub    $0x4,%eax
  800de1:	8b 00                	mov    (%eax),%eax
  800de3:	99                   	cltd   
  800de4:	eb 18                	jmp    800dfe <getint+0x5d>
	else
		return va_arg(*ap, int);
  800de6:	8b 45 08             	mov    0x8(%ebp),%eax
  800de9:	8b 00                	mov    (%eax),%eax
  800deb:	8d 50 04             	lea    0x4(%eax),%edx
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	89 10                	mov    %edx,(%eax)
  800df3:	8b 45 08             	mov    0x8(%ebp),%eax
  800df6:	8b 00                	mov    (%eax),%eax
  800df8:	83 e8 04             	sub    $0x4,%eax
  800dfb:	8b 00                	mov    (%eax),%eax
  800dfd:	99                   	cltd   
}
  800dfe:	5d                   	pop    %ebp
  800dff:	c3                   	ret    

00800e00 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800e00:	55                   	push   %ebp
  800e01:	89 e5                	mov    %esp,%ebp
  800e03:	56                   	push   %esi
  800e04:	53                   	push   %ebx
  800e05:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e08:	eb 17                	jmp    800e21 <vprintfmt+0x21>
			if (ch == '\0')
  800e0a:	85 db                	test   %ebx,%ebx
  800e0c:	0f 84 af 03 00 00    	je     8011c1 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800e12:	83 ec 08             	sub    $0x8,%esp
  800e15:	ff 75 0c             	pushl  0xc(%ebp)
  800e18:	53                   	push   %ebx
  800e19:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1c:	ff d0                	call   *%eax
  800e1e:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800e21:	8b 45 10             	mov    0x10(%ebp),%eax
  800e24:	8d 50 01             	lea    0x1(%eax),%edx
  800e27:	89 55 10             	mov    %edx,0x10(%ebp)
  800e2a:	8a 00                	mov    (%eax),%al
  800e2c:	0f b6 d8             	movzbl %al,%ebx
  800e2f:	83 fb 25             	cmp    $0x25,%ebx
  800e32:	75 d6                	jne    800e0a <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800e34:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800e38:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800e3f:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800e46:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800e4d:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800e54:	8b 45 10             	mov    0x10(%ebp),%eax
  800e57:	8d 50 01             	lea    0x1(%eax),%edx
  800e5a:	89 55 10             	mov    %edx,0x10(%ebp)
  800e5d:	8a 00                	mov    (%eax),%al
  800e5f:	0f b6 d8             	movzbl %al,%ebx
  800e62:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800e65:	83 f8 55             	cmp    $0x55,%eax
  800e68:	0f 87 2b 03 00 00    	ja     801199 <vprintfmt+0x399>
  800e6e:	8b 04 85 18 2c 80 00 	mov    0x802c18(,%eax,4),%eax
  800e75:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800e77:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800e7b:	eb d7                	jmp    800e54 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800e7d:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800e81:	eb d1                	jmp    800e54 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800e83:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800e8a:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800e8d:	89 d0                	mov    %edx,%eax
  800e8f:	c1 e0 02             	shl    $0x2,%eax
  800e92:	01 d0                	add    %edx,%eax
  800e94:	01 c0                	add    %eax,%eax
  800e96:	01 d8                	add    %ebx,%eax
  800e98:	83 e8 30             	sub    $0x30,%eax
  800e9b:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800e9e:	8b 45 10             	mov    0x10(%ebp),%eax
  800ea1:	8a 00                	mov    (%eax),%al
  800ea3:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800ea6:	83 fb 2f             	cmp    $0x2f,%ebx
  800ea9:	7e 3e                	jle    800ee9 <vprintfmt+0xe9>
  800eab:	83 fb 39             	cmp    $0x39,%ebx
  800eae:	7f 39                	jg     800ee9 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800eb0:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800eb3:	eb d5                	jmp    800e8a <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800eb5:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb8:	83 c0 04             	add    $0x4,%eax
  800ebb:	89 45 14             	mov    %eax,0x14(%ebp)
  800ebe:	8b 45 14             	mov    0x14(%ebp),%eax
  800ec1:	83 e8 04             	sub    $0x4,%eax
  800ec4:	8b 00                	mov    (%eax),%eax
  800ec6:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800ec9:	eb 1f                	jmp    800eea <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800ecb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ecf:	79 83                	jns    800e54 <vprintfmt+0x54>
				width = 0;
  800ed1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800ed8:	e9 77 ff ff ff       	jmp    800e54 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800edd:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800ee4:	e9 6b ff ff ff       	jmp    800e54 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800ee9:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800eea:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800eee:	0f 89 60 ff ff ff    	jns    800e54 <vprintfmt+0x54>
				width = precision, precision = -1;
  800ef4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ef7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800efa:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800f01:	e9 4e ff ff ff       	jmp    800e54 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800f06:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800f09:	e9 46 ff ff ff       	jmp    800e54 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800f0e:	8b 45 14             	mov    0x14(%ebp),%eax
  800f11:	83 c0 04             	add    $0x4,%eax
  800f14:	89 45 14             	mov    %eax,0x14(%ebp)
  800f17:	8b 45 14             	mov    0x14(%ebp),%eax
  800f1a:	83 e8 04             	sub    $0x4,%eax
  800f1d:	8b 00                	mov    (%eax),%eax
  800f1f:	83 ec 08             	sub    $0x8,%esp
  800f22:	ff 75 0c             	pushl  0xc(%ebp)
  800f25:	50                   	push   %eax
  800f26:	8b 45 08             	mov    0x8(%ebp),%eax
  800f29:	ff d0                	call   *%eax
  800f2b:	83 c4 10             	add    $0x10,%esp
			break;
  800f2e:	e9 89 02 00 00       	jmp    8011bc <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800f33:	8b 45 14             	mov    0x14(%ebp),%eax
  800f36:	83 c0 04             	add    $0x4,%eax
  800f39:	89 45 14             	mov    %eax,0x14(%ebp)
  800f3c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f3f:	83 e8 04             	sub    $0x4,%eax
  800f42:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800f44:	85 db                	test   %ebx,%ebx
  800f46:	79 02                	jns    800f4a <vprintfmt+0x14a>
				err = -err;
  800f48:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800f4a:	83 fb 64             	cmp    $0x64,%ebx
  800f4d:	7f 0b                	jg     800f5a <vprintfmt+0x15a>
  800f4f:	8b 34 9d 60 2a 80 00 	mov    0x802a60(,%ebx,4),%esi
  800f56:	85 f6                	test   %esi,%esi
  800f58:	75 19                	jne    800f73 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800f5a:	53                   	push   %ebx
  800f5b:	68 05 2c 80 00       	push   $0x802c05
  800f60:	ff 75 0c             	pushl  0xc(%ebp)
  800f63:	ff 75 08             	pushl  0x8(%ebp)
  800f66:	e8 5e 02 00 00       	call   8011c9 <printfmt>
  800f6b:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800f6e:	e9 49 02 00 00       	jmp    8011bc <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800f73:	56                   	push   %esi
  800f74:	68 0e 2c 80 00       	push   $0x802c0e
  800f79:	ff 75 0c             	pushl  0xc(%ebp)
  800f7c:	ff 75 08             	pushl  0x8(%ebp)
  800f7f:	e8 45 02 00 00       	call   8011c9 <printfmt>
  800f84:	83 c4 10             	add    $0x10,%esp
			break;
  800f87:	e9 30 02 00 00       	jmp    8011bc <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800f8c:	8b 45 14             	mov    0x14(%ebp),%eax
  800f8f:	83 c0 04             	add    $0x4,%eax
  800f92:	89 45 14             	mov    %eax,0x14(%ebp)
  800f95:	8b 45 14             	mov    0x14(%ebp),%eax
  800f98:	83 e8 04             	sub    $0x4,%eax
  800f9b:	8b 30                	mov    (%eax),%esi
  800f9d:	85 f6                	test   %esi,%esi
  800f9f:	75 05                	jne    800fa6 <vprintfmt+0x1a6>
				p = "(null)";
  800fa1:	be 11 2c 80 00       	mov    $0x802c11,%esi
			if (width > 0 && padc != '-')
  800fa6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800faa:	7e 6d                	jle    801019 <vprintfmt+0x219>
  800fac:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800fb0:	74 67                	je     801019 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800fb2:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800fb5:	83 ec 08             	sub    $0x8,%esp
  800fb8:	50                   	push   %eax
  800fb9:	56                   	push   %esi
  800fba:	e8 12 05 00 00       	call   8014d1 <strnlen>
  800fbf:	83 c4 10             	add    $0x10,%esp
  800fc2:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800fc5:	eb 16                	jmp    800fdd <vprintfmt+0x1dd>
					putch(padc, putdat);
  800fc7:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800fcb:	83 ec 08             	sub    $0x8,%esp
  800fce:	ff 75 0c             	pushl  0xc(%ebp)
  800fd1:	50                   	push   %eax
  800fd2:	8b 45 08             	mov    0x8(%ebp),%eax
  800fd5:	ff d0                	call   *%eax
  800fd7:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800fda:	ff 4d e4             	decl   -0x1c(%ebp)
  800fdd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800fe1:	7f e4                	jg     800fc7 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800fe3:	eb 34                	jmp    801019 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800fe5:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800fe9:	74 1c                	je     801007 <vprintfmt+0x207>
  800feb:	83 fb 1f             	cmp    $0x1f,%ebx
  800fee:	7e 05                	jle    800ff5 <vprintfmt+0x1f5>
  800ff0:	83 fb 7e             	cmp    $0x7e,%ebx
  800ff3:	7e 12                	jle    801007 <vprintfmt+0x207>
					putch('?', putdat);
  800ff5:	83 ec 08             	sub    $0x8,%esp
  800ff8:	ff 75 0c             	pushl  0xc(%ebp)
  800ffb:	6a 3f                	push   $0x3f
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	ff d0                	call   *%eax
  801002:	83 c4 10             	add    $0x10,%esp
  801005:	eb 0f                	jmp    801016 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  801007:	83 ec 08             	sub    $0x8,%esp
  80100a:	ff 75 0c             	pushl  0xc(%ebp)
  80100d:	53                   	push   %ebx
  80100e:	8b 45 08             	mov    0x8(%ebp),%eax
  801011:	ff d0                	call   *%eax
  801013:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  801016:	ff 4d e4             	decl   -0x1c(%ebp)
  801019:	89 f0                	mov    %esi,%eax
  80101b:	8d 70 01             	lea    0x1(%eax),%esi
  80101e:	8a 00                	mov    (%eax),%al
  801020:	0f be d8             	movsbl %al,%ebx
  801023:	85 db                	test   %ebx,%ebx
  801025:	74 24                	je     80104b <vprintfmt+0x24b>
  801027:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80102b:	78 b8                	js     800fe5 <vprintfmt+0x1e5>
  80102d:	ff 4d e0             	decl   -0x20(%ebp)
  801030:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  801034:	79 af                	jns    800fe5 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801036:	eb 13                	jmp    80104b <vprintfmt+0x24b>
				putch(' ', putdat);
  801038:	83 ec 08             	sub    $0x8,%esp
  80103b:	ff 75 0c             	pushl  0xc(%ebp)
  80103e:	6a 20                	push   $0x20
  801040:	8b 45 08             	mov    0x8(%ebp),%eax
  801043:	ff d0                	call   *%eax
  801045:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  801048:	ff 4d e4             	decl   -0x1c(%ebp)
  80104b:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80104f:	7f e7                	jg     801038 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  801051:	e9 66 01 00 00       	jmp    8011bc <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  801056:	83 ec 08             	sub    $0x8,%esp
  801059:	ff 75 e8             	pushl  -0x18(%ebp)
  80105c:	8d 45 14             	lea    0x14(%ebp),%eax
  80105f:	50                   	push   %eax
  801060:	e8 3c fd ff ff       	call   800da1 <getint>
  801065:	83 c4 10             	add    $0x10,%esp
  801068:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80106b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  80106e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801071:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801074:	85 d2                	test   %edx,%edx
  801076:	79 23                	jns    80109b <vprintfmt+0x29b>
				putch('-', putdat);
  801078:	83 ec 08             	sub    $0x8,%esp
  80107b:	ff 75 0c             	pushl  0xc(%ebp)
  80107e:	6a 2d                	push   $0x2d
  801080:	8b 45 08             	mov    0x8(%ebp),%eax
  801083:	ff d0                	call   *%eax
  801085:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  801088:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80108b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80108e:	f7 d8                	neg    %eax
  801090:	83 d2 00             	adc    $0x0,%edx
  801093:	f7 da                	neg    %edx
  801095:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801098:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80109b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010a2:	e9 bc 00 00 00       	jmp    801163 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8010a7:	83 ec 08             	sub    $0x8,%esp
  8010aa:	ff 75 e8             	pushl  -0x18(%ebp)
  8010ad:	8d 45 14             	lea    0x14(%ebp),%eax
  8010b0:	50                   	push   %eax
  8010b1:	e8 84 fc ff ff       	call   800d3a <getuint>
  8010b6:	83 c4 10             	add    $0x10,%esp
  8010b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8010bc:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8010bf:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8010c6:	e9 98 00 00 00       	jmp    801163 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8010cb:	83 ec 08             	sub    $0x8,%esp
  8010ce:	ff 75 0c             	pushl  0xc(%ebp)
  8010d1:	6a 58                	push   $0x58
  8010d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d6:	ff d0                	call   *%eax
  8010d8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010db:	83 ec 08             	sub    $0x8,%esp
  8010de:	ff 75 0c             	pushl  0xc(%ebp)
  8010e1:	6a 58                	push   $0x58
  8010e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010e6:	ff d0                	call   *%eax
  8010e8:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8010eb:	83 ec 08             	sub    $0x8,%esp
  8010ee:	ff 75 0c             	pushl  0xc(%ebp)
  8010f1:	6a 58                	push   $0x58
  8010f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f6:	ff d0                	call   *%eax
  8010f8:	83 c4 10             	add    $0x10,%esp
			break;
  8010fb:	e9 bc 00 00 00       	jmp    8011bc <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  801100:	83 ec 08             	sub    $0x8,%esp
  801103:	ff 75 0c             	pushl  0xc(%ebp)
  801106:	6a 30                	push   $0x30
  801108:	8b 45 08             	mov    0x8(%ebp),%eax
  80110b:	ff d0                	call   *%eax
  80110d:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  801110:	83 ec 08             	sub    $0x8,%esp
  801113:	ff 75 0c             	pushl  0xc(%ebp)
  801116:	6a 78                	push   $0x78
  801118:	8b 45 08             	mov    0x8(%ebp),%eax
  80111b:	ff d0                	call   *%eax
  80111d:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  801120:	8b 45 14             	mov    0x14(%ebp),%eax
  801123:	83 c0 04             	add    $0x4,%eax
  801126:	89 45 14             	mov    %eax,0x14(%ebp)
  801129:	8b 45 14             	mov    0x14(%ebp),%eax
  80112c:	83 e8 04             	sub    $0x4,%eax
  80112f:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  801131:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801134:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80113b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  801142:	eb 1f                	jmp    801163 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  801144:	83 ec 08             	sub    $0x8,%esp
  801147:	ff 75 e8             	pushl  -0x18(%ebp)
  80114a:	8d 45 14             	lea    0x14(%ebp),%eax
  80114d:	50                   	push   %eax
  80114e:	e8 e7 fb ff ff       	call   800d3a <getuint>
  801153:	83 c4 10             	add    $0x10,%esp
  801156:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801159:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80115c:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  801163:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  801167:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80116a:	83 ec 04             	sub    $0x4,%esp
  80116d:	52                   	push   %edx
  80116e:	ff 75 e4             	pushl  -0x1c(%ebp)
  801171:	50                   	push   %eax
  801172:	ff 75 f4             	pushl  -0xc(%ebp)
  801175:	ff 75 f0             	pushl  -0x10(%ebp)
  801178:	ff 75 0c             	pushl  0xc(%ebp)
  80117b:	ff 75 08             	pushl  0x8(%ebp)
  80117e:	e8 00 fb ff ff       	call   800c83 <printnum>
  801183:	83 c4 20             	add    $0x20,%esp
			break;
  801186:	eb 34                	jmp    8011bc <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  801188:	83 ec 08             	sub    $0x8,%esp
  80118b:	ff 75 0c             	pushl  0xc(%ebp)
  80118e:	53                   	push   %ebx
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	ff d0                	call   *%eax
  801194:	83 c4 10             	add    $0x10,%esp
			break;
  801197:	eb 23                	jmp    8011bc <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  801199:	83 ec 08             	sub    $0x8,%esp
  80119c:	ff 75 0c             	pushl  0xc(%ebp)
  80119f:	6a 25                	push   $0x25
  8011a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a4:	ff d0                	call   *%eax
  8011a6:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8011a9:	ff 4d 10             	decl   0x10(%ebp)
  8011ac:	eb 03                	jmp    8011b1 <vprintfmt+0x3b1>
  8011ae:	ff 4d 10             	decl   0x10(%ebp)
  8011b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8011b4:	48                   	dec    %eax
  8011b5:	8a 00                	mov    (%eax),%al
  8011b7:	3c 25                	cmp    $0x25,%al
  8011b9:	75 f3                	jne    8011ae <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8011bb:	90                   	nop
		}
	}
  8011bc:	e9 47 fc ff ff       	jmp    800e08 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8011c1:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8011c2:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8011c5:	5b                   	pop    %ebx
  8011c6:	5e                   	pop    %esi
  8011c7:	5d                   	pop    %ebp
  8011c8:	c3                   	ret    

008011c9 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8011c9:	55                   	push   %ebp
  8011ca:	89 e5                	mov    %esp,%ebp
  8011cc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8011cf:	8d 45 10             	lea    0x10(%ebp),%eax
  8011d2:	83 c0 04             	add    $0x4,%eax
  8011d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8011d8:	8b 45 10             	mov    0x10(%ebp),%eax
  8011db:	ff 75 f4             	pushl  -0xc(%ebp)
  8011de:	50                   	push   %eax
  8011df:	ff 75 0c             	pushl  0xc(%ebp)
  8011e2:	ff 75 08             	pushl  0x8(%ebp)
  8011e5:	e8 16 fc ff ff       	call   800e00 <vprintfmt>
  8011ea:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8011ed:	90                   	nop
  8011ee:	c9                   	leave  
  8011ef:	c3                   	ret    

008011f0 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8011f0:	55                   	push   %ebp
  8011f1:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8011f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f6:	8b 40 08             	mov    0x8(%eax),%eax
  8011f9:	8d 50 01             	lea    0x1(%eax),%edx
  8011fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ff:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  801202:	8b 45 0c             	mov    0xc(%ebp),%eax
  801205:	8b 10                	mov    (%eax),%edx
  801207:	8b 45 0c             	mov    0xc(%ebp),%eax
  80120a:	8b 40 04             	mov    0x4(%eax),%eax
  80120d:	39 c2                	cmp    %eax,%edx
  80120f:	73 12                	jae    801223 <sprintputch+0x33>
		*b->buf++ = ch;
  801211:	8b 45 0c             	mov    0xc(%ebp),%eax
  801214:	8b 00                	mov    (%eax),%eax
  801216:	8d 48 01             	lea    0x1(%eax),%ecx
  801219:	8b 55 0c             	mov    0xc(%ebp),%edx
  80121c:	89 0a                	mov    %ecx,(%edx)
  80121e:	8b 55 08             	mov    0x8(%ebp),%edx
  801221:	88 10                	mov    %dl,(%eax)
}
  801223:	90                   	nop
  801224:	5d                   	pop    %ebp
  801225:	c3                   	ret    

00801226 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  801226:	55                   	push   %ebp
  801227:	89 e5                	mov    %esp,%ebp
  801229:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80122c:	8b 45 08             	mov    0x8(%ebp),%eax
  80122f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  801232:	8b 45 0c             	mov    0xc(%ebp),%eax
  801235:	8d 50 ff             	lea    -0x1(%eax),%edx
  801238:	8b 45 08             	mov    0x8(%ebp),%eax
  80123b:	01 d0                	add    %edx,%eax
  80123d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  801240:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  801247:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80124b:	74 06                	je     801253 <vsnprintf+0x2d>
  80124d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801251:	7f 07                	jg     80125a <vsnprintf+0x34>
		return -E_INVAL;
  801253:	b8 03 00 00 00       	mov    $0x3,%eax
  801258:	eb 20                	jmp    80127a <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80125a:	ff 75 14             	pushl  0x14(%ebp)
  80125d:	ff 75 10             	pushl  0x10(%ebp)
  801260:	8d 45 ec             	lea    -0x14(%ebp),%eax
  801263:	50                   	push   %eax
  801264:	68 f0 11 80 00       	push   $0x8011f0
  801269:	e8 92 fb ff ff       	call   800e00 <vprintfmt>
  80126e:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  801271:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801274:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801277:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80127a:	c9                   	leave  
  80127b:	c3                   	ret    

0080127c <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80127c:	55                   	push   %ebp
  80127d:	89 e5                	mov    %esp,%ebp
  80127f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  801282:	8d 45 10             	lea    0x10(%ebp),%eax
  801285:	83 c0 04             	add    $0x4,%eax
  801288:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80128b:	8b 45 10             	mov    0x10(%ebp),%eax
  80128e:	ff 75 f4             	pushl  -0xc(%ebp)
  801291:	50                   	push   %eax
  801292:	ff 75 0c             	pushl  0xc(%ebp)
  801295:	ff 75 08             	pushl  0x8(%ebp)
  801298:	e8 89 ff ff ff       	call   801226 <vsnprintf>
  80129d:	83 c4 10             	add    $0x10,%esp
  8012a0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8012a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8012a6:	c9                   	leave  
  8012a7:	c3                   	ret    

008012a8 <readline>:
#include <inc/lib.h>

//static char buf[BUFLEN];

void readline(const char *prompt, char* buf)
{
  8012a8:	55                   	push   %ebp
  8012a9:	89 e5                	mov    %esp,%ebp
  8012ab:	83 ec 18             	sub    $0x18,%esp
		int i, c, echoing;

	if (prompt != NULL)
  8012ae:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8012b2:	74 13                	je     8012c7 <readline+0x1f>
		cprintf("%s", prompt);
  8012b4:	83 ec 08             	sub    $0x8,%esp
  8012b7:	ff 75 08             	pushl  0x8(%ebp)
  8012ba:	68 70 2d 80 00       	push   $0x802d70
  8012bf:	e8 62 f9 ff ff       	call   800c26 <cprintf>
  8012c4:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8012c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8012ce:	83 ec 0c             	sub    $0xc,%esp
  8012d1:	6a 00                	push   $0x0
  8012d3:	e8 74 f5 ff ff       	call   80084c <iscons>
  8012d8:	83 c4 10             	add    $0x10,%esp
  8012db:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8012de:	e8 1b f5 ff ff       	call   8007fe <getchar>
  8012e3:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8012e6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8012ea:	79 22                	jns    80130e <readline+0x66>
			if (c != -E_EOF)
  8012ec:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8012f0:	0f 84 ad 00 00 00    	je     8013a3 <readline+0xfb>
				cprintf("read error: %e\n", c);
  8012f6:	83 ec 08             	sub    $0x8,%esp
  8012f9:	ff 75 ec             	pushl  -0x14(%ebp)
  8012fc:	68 73 2d 80 00       	push   $0x802d73
  801301:	e8 20 f9 ff ff       	call   800c26 <cprintf>
  801306:	83 c4 10             	add    $0x10,%esp
			return;
  801309:	e9 95 00 00 00       	jmp    8013a3 <readline+0xfb>
		} else if (c >= ' ' && i < BUFLEN-1) {
  80130e:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801312:	7e 34                	jle    801348 <readline+0xa0>
  801314:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80131b:	7f 2b                	jg     801348 <readline+0xa0>
			if (echoing)
  80131d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801321:	74 0e                	je     801331 <readline+0x89>
				cputchar(c);
  801323:	83 ec 0c             	sub    $0xc,%esp
  801326:	ff 75 ec             	pushl  -0x14(%ebp)
  801329:	e8 88 f4 ff ff       	call   8007b6 <cputchar>
  80132e:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801331:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801334:	8d 50 01             	lea    0x1(%eax),%edx
  801337:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80133a:	89 c2                	mov    %eax,%edx
  80133c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133f:	01 d0                	add    %edx,%eax
  801341:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801344:	88 10                	mov    %dl,(%eax)
  801346:	eb 56                	jmp    80139e <readline+0xf6>
		} else if (c == '\b' && i > 0) {
  801348:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  80134c:	75 1f                	jne    80136d <readline+0xc5>
  80134e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801352:	7e 19                	jle    80136d <readline+0xc5>
			if (echoing)
  801354:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801358:	74 0e                	je     801368 <readline+0xc0>
				cputchar(c);
  80135a:	83 ec 0c             	sub    $0xc,%esp
  80135d:	ff 75 ec             	pushl  -0x14(%ebp)
  801360:	e8 51 f4 ff ff       	call   8007b6 <cputchar>
  801365:	83 c4 10             	add    $0x10,%esp

			i--;
  801368:	ff 4d f4             	decl   -0xc(%ebp)
  80136b:	eb 31                	jmp    80139e <readline+0xf6>
		} else if (c == '\n' || c == '\r') {
  80136d:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801371:	74 0a                	je     80137d <readline+0xd5>
  801373:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  801377:	0f 85 61 ff ff ff    	jne    8012de <readline+0x36>
			if (echoing)
  80137d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801381:	74 0e                	je     801391 <readline+0xe9>
				cputchar(c);
  801383:	83 ec 0c             	sub    $0xc,%esp
  801386:	ff 75 ec             	pushl  -0x14(%ebp)
  801389:	e8 28 f4 ff ff       	call   8007b6 <cputchar>
  80138e:	83 c4 10             	add    $0x10,%esp

			buf[i] = 0;
  801391:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801394:	8b 45 0c             	mov    0xc(%ebp),%eax
  801397:	01 d0                	add    %edx,%eax
  801399:	c6 00 00             	movb   $0x0,(%eax)
			return;
  80139c:	eb 06                	jmp    8013a4 <readline+0xfc>
		}
	}
  80139e:	e9 3b ff ff ff       	jmp    8012de <readline+0x36>
	while (1) {
		c = getchar();
		if (c < 0) {
			if (c != -E_EOF)
				cprintf("read error: %e\n", c);
			return;
  8013a3:	90                   	nop
			buf[i] = 0;
			return;
		}
	}

}
  8013a4:	c9                   	leave  
  8013a5:	c3                   	ret    

008013a6 <atomic_readline>:

void atomic_readline(const char *prompt, char* buf)
{
  8013a6:	55                   	push   %ebp
  8013a7:	89 e5                	mov    %esp,%ebp
  8013a9:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8013ac:	e8 31 0b 00 00       	call   801ee2 <sys_disable_interrupt>
	int i, c, echoing;

	if (prompt != NULL)
  8013b1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8013b5:	74 13                	je     8013ca <atomic_readline+0x24>
		cprintf("%s", prompt);
  8013b7:	83 ec 08             	sub    $0x8,%esp
  8013ba:	ff 75 08             	pushl  0x8(%ebp)
  8013bd:	68 70 2d 80 00       	push   $0x802d70
  8013c2:	e8 5f f8 ff ff       	call   800c26 <cprintf>
  8013c7:	83 c4 10             	add    $0x10,%esp

	i = 0;
  8013ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	echoing = iscons(0);
  8013d1:	83 ec 0c             	sub    $0xc,%esp
  8013d4:	6a 00                	push   $0x0
  8013d6:	e8 71 f4 ff ff       	call   80084c <iscons>
  8013db:	83 c4 10             	add    $0x10,%esp
  8013de:	89 45 f0             	mov    %eax,-0x10(%ebp)
	while (1) {
		c = getchar();
  8013e1:	e8 18 f4 ff ff       	call   8007fe <getchar>
  8013e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
		if (c < 0) {
  8013e9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8013ed:	79 23                	jns    801412 <atomic_readline+0x6c>
			if (c != -E_EOF)
  8013ef:	83 7d ec 07          	cmpl   $0x7,-0x14(%ebp)
  8013f3:	74 13                	je     801408 <atomic_readline+0x62>
				cprintf("read error: %e\n", c);
  8013f5:	83 ec 08             	sub    $0x8,%esp
  8013f8:	ff 75 ec             	pushl  -0x14(%ebp)
  8013fb:	68 73 2d 80 00       	push   $0x802d73
  801400:	e8 21 f8 ff ff       	call   800c26 <cprintf>
  801405:	83 c4 10             	add    $0x10,%esp
			sys_enable_interrupt();
  801408:	e8 ef 0a 00 00       	call   801efc <sys_enable_interrupt>
			return;
  80140d:	e9 9a 00 00 00       	jmp    8014ac <atomic_readline+0x106>
		} else if (c >= ' ' && i < BUFLEN-1) {
  801412:	83 7d ec 1f          	cmpl   $0x1f,-0x14(%ebp)
  801416:	7e 34                	jle    80144c <atomic_readline+0xa6>
  801418:	81 7d f4 fe 03 00 00 	cmpl   $0x3fe,-0xc(%ebp)
  80141f:	7f 2b                	jg     80144c <atomic_readline+0xa6>
			if (echoing)
  801421:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801425:	74 0e                	je     801435 <atomic_readline+0x8f>
				cputchar(c);
  801427:	83 ec 0c             	sub    $0xc,%esp
  80142a:	ff 75 ec             	pushl  -0x14(%ebp)
  80142d:	e8 84 f3 ff ff       	call   8007b6 <cputchar>
  801432:	83 c4 10             	add    $0x10,%esp
			buf[i++] = c;
  801435:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801438:	8d 50 01             	lea    0x1(%eax),%edx
  80143b:	89 55 f4             	mov    %edx,-0xc(%ebp)
  80143e:	89 c2                	mov    %eax,%edx
  801440:	8b 45 0c             	mov    0xc(%ebp),%eax
  801443:	01 d0                	add    %edx,%eax
  801445:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801448:	88 10                	mov    %dl,(%eax)
  80144a:	eb 5b                	jmp    8014a7 <atomic_readline+0x101>
		} else if (c == '\b' && i > 0) {
  80144c:	83 7d ec 08          	cmpl   $0x8,-0x14(%ebp)
  801450:	75 1f                	jne    801471 <atomic_readline+0xcb>
  801452:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  801456:	7e 19                	jle    801471 <atomic_readline+0xcb>
			if (echoing)
  801458:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  80145c:	74 0e                	je     80146c <atomic_readline+0xc6>
				cputchar(c);
  80145e:	83 ec 0c             	sub    $0xc,%esp
  801461:	ff 75 ec             	pushl  -0x14(%ebp)
  801464:	e8 4d f3 ff ff       	call   8007b6 <cputchar>
  801469:	83 c4 10             	add    $0x10,%esp
			i--;
  80146c:	ff 4d f4             	decl   -0xc(%ebp)
  80146f:	eb 36                	jmp    8014a7 <atomic_readline+0x101>
		} else if (c == '\n' || c == '\r') {
  801471:	83 7d ec 0a          	cmpl   $0xa,-0x14(%ebp)
  801475:	74 0a                	je     801481 <atomic_readline+0xdb>
  801477:	83 7d ec 0d          	cmpl   $0xd,-0x14(%ebp)
  80147b:	0f 85 60 ff ff ff    	jne    8013e1 <atomic_readline+0x3b>
			if (echoing)
  801481:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  801485:	74 0e                	je     801495 <atomic_readline+0xef>
				cputchar(c);
  801487:	83 ec 0c             	sub    $0xc,%esp
  80148a:	ff 75 ec             	pushl  -0x14(%ebp)
  80148d:	e8 24 f3 ff ff       	call   8007b6 <cputchar>
  801492:	83 c4 10             	add    $0x10,%esp
			buf[i] = 0;
  801495:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801498:	8b 45 0c             	mov    0xc(%ebp),%eax
  80149b:	01 d0                	add    %edx,%eax
  80149d:	c6 00 00             	movb   $0x0,(%eax)
			sys_enable_interrupt();
  8014a0:	e8 57 0a 00 00       	call   801efc <sys_enable_interrupt>
			return;
  8014a5:	eb 05                	jmp    8014ac <atomic_readline+0x106>
		}
	}
  8014a7:	e9 35 ff ff ff       	jmp    8013e1 <atomic_readline+0x3b>
}
  8014ac:	c9                   	leave  
  8014ad:	c3                   	ret    

008014ae <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8014ae:	55                   	push   %ebp
  8014af:	89 e5                	mov    %esp,%ebp
  8014b1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8014b4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014bb:	eb 06                	jmp    8014c3 <strlen+0x15>
		n++;
  8014bd:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8014c0:	ff 45 08             	incl   0x8(%ebp)
  8014c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014c6:	8a 00                	mov    (%eax),%al
  8014c8:	84 c0                	test   %al,%al
  8014ca:	75 f1                	jne    8014bd <strlen+0xf>
		n++;
	return n;
  8014cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014cf:	c9                   	leave  
  8014d0:	c3                   	ret    

008014d1 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8014d1:	55                   	push   %ebp
  8014d2:	89 e5                	mov    %esp,%ebp
  8014d4:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014d7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8014de:	eb 09                	jmp    8014e9 <strnlen+0x18>
		n++;
  8014e0:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8014e3:	ff 45 08             	incl   0x8(%ebp)
  8014e6:	ff 4d 0c             	decl   0xc(%ebp)
  8014e9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014ed:	74 09                	je     8014f8 <strnlen+0x27>
  8014ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8014f2:	8a 00                	mov    (%eax),%al
  8014f4:	84 c0                	test   %al,%al
  8014f6:	75 e8                	jne    8014e0 <strnlen+0xf>
		n++;
	return n;
  8014f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8014fb:	c9                   	leave  
  8014fc:	c3                   	ret    

008014fd <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8014fd:	55                   	push   %ebp
  8014fe:	89 e5                	mov    %esp,%ebp
  801500:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  801509:	90                   	nop
  80150a:	8b 45 08             	mov    0x8(%ebp),%eax
  80150d:	8d 50 01             	lea    0x1(%eax),%edx
  801510:	89 55 08             	mov    %edx,0x8(%ebp)
  801513:	8b 55 0c             	mov    0xc(%ebp),%edx
  801516:	8d 4a 01             	lea    0x1(%edx),%ecx
  801519:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80151c:	8a 12                	mov    (%edx),%dl
  80151e:	88 10                	mov    %dl,(%eax)
  801520:	8a 00                	mov    (%eax),%al
  801522:	84 c0                	test   %al,%al
  801524:	75 e4                	jne    80150a <strcpy+0xd>
		/* do nothing */;
	return ret;
  801526:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801529:	c9                   	leave  
  80152a:	c3                   	ret    

0080152b <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  80152b:	55                   	push   %ebp
  80152c:	89 e5                	mov    %esp,%ebp
  80152e:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  801531:	8b 45 08             	mov    0x8(%ebp),%eax
  801534:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  801537:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80153e:	eb 1f                	jmp    80155f <strncpy+0x34>
		*dst++ = *src;
  801540:	8b 45 08             	mov    0x8(%ebp),%eax
  801543:	8d 50 01             	lea    0x1(%eax),%edx
  801546:	89 55 08             	mov    %edx,0x8(%ebp)
  801549:	8b 55 0c             	mov    0xc(%ebp),%edx
  80154c:	8a 12                	mov    (%edx),%dl
  80154e:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  801550:	8b 45 0c             	mov    0xc(%ebp),%eax
  801553:	8a 00                	mov    (%eax),%al
  801555:	84 c0                	test   %al,%al
  801557:	74 03                	je     80155c <strncpy+0x31>
			src++;
  801559:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  80155c:	ff 45 fc             	incl   -0x4(%ebp)
  80155f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801562:	3b 45 10             	cmp    0x10(%ebp),%eax
  801565:	72 d9                	jb     801540 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  801567:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80156a:	c9                   	leave  
  80156b:	c3                   	ret    

0080156c <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  80156c:	55                   	push   %ebp
  80156d:	89 e5                	mov    %esp,%ebp
  80156f:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  801572:	8b 45 08             	mov    0x8(%ebp),%eax
  801575:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  801578:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80157c:	74 30                	je     8015ae <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  80157e:	eb 16                	jmp    801596 <strlcpy+0x2a>
			*dst++ = *src++;
  801580:	8b 45 08             	mov    0x8(%ebp),%eax
  801583:	8d 50 01             	lea    0x1(%eax),%edx
  801586:	89 55 08             	mov    %edx,0x8(%ebp)
  801589:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80158f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801592:	8a 12                	mov    (%edx),%dl
  801594:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801596:	ff 4d 10             	decl   0x10(%ebp)
  801599:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80159d:	74 09                	je     8015a8 <strlcpy+0x3c>
  80159f:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a2:	8a 00                	mov    (%eax),%al
  8015a4:	84 c0                	test   %al,%al
  8015a6:	75 d8                	jne    801580 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  8015a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015ab:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  8015ae:	8b 55 08             	mov    0x8(%ebp),%edx
  8015b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8015b4:	29 c2                	sub    %eax,%edx
  8015b6:	89 d0                	mov    %edx,%eax
}
  8015b8:	c9                   	leave  
  8015b9:	c3                   	ret    

008015ba <strcmp>:

int
strcmp(const char *p, const char *q)
{
  8015ba:	55                   	push   %ebp
  8015bb:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  8015bd:	eb 06                	jmp    8015c5 <strcmp+0xb>
		p++, q++;
  8015bf:	ff 45 08             	incl   0x8(%ebp)
  8015c2:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  8015c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c8:	8a 00                	mov    (%eax),%al
  8015ca:	84 c0                	test   %al,%al
  8015cc:	74 0e                	je     8015dc <strcmp+0x22>
  8015ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d1:	8a 10                	mov    (%eax),%dl
  8015d3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015d6:	8a 00                	mov    (%eax),%al
  8015d8:	38 c2                	cmp    %al,%dl
  8015da:	74 e3                	je     8015bf <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  8015dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8015df:	8a 00                	mov    (%eax),%al
  8015e1:	0f b6 d0             	movzbl %al,%edx
  8015e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015e7:	8a 00                	mov    (%eax),%al
  8015e9:	0f b6 c0             	movzbl %al,%eax
  8015ec:	29 c2                	sub    %eax,%edx
  8015ee:	89 d0                	mov    %edx,%eax
}
  8015f0:	5d                   	pop    %ebp
  8015f1:	c3                   	ret    

008015f2 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  8015f2:	55                   	push   %ebp
  8015f3:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  8015f5:	eb 09                	jmp    801600 <strncmp+0xe>
		n--, p++, q++;
  8015f7:	ff 4d 10             	decl   0x10(%ebp)
  8015fa:	ff 45 08             	incl   0x8(%ebp)
  8015fd:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801600:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801604:	74 17                	je     80161d <strncmp+0x2b>
  801606:	8b 45 08             	mov    0x8(%ebp),%eax
  801609:	8a 00                	mov    (%eax),%al
  80160b:	84 c0                	test   %al,%al
  80160d:	74 0e                	je     80161d <strncmp+0x2b>
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	8a 10                	mov    (%eax),%dl
  801614:	8b 45 0c             	mov    0xc(%ebp),%eax
  801617:	8a 00                	mov    (%eax),%al
  801619:	38 c2                	cmp    %al,%dl
  80161b:	74 da                	je     8015f7 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80161d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801621:	75 07                	jne    80162a <strncmp+0x38>
		return 0;
  801623:	b8 00 00 00 00       	mov    $0x0,%eax
  801628:	eb 14                	jmp    80163e <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  80162a:	8b 45 08             	mov    0x8(%ebp),%eax
  80162d:	8a 00                	mov    (%eax),%al
  80162f:	0f b6 d0             	movzbl %al,%edx
  801632:	8b 45 0c             	mov    0xc(%ebp),%eax
  801635:	8a 00                	mov    (%eax),%al
  801637:	0f b6 c0             	movzbl %al,%eax
  80163a:	29 c2                	sub    %eax,%edx
  80163c:	89 d0                	mov    %edx,%eax
}
  80163e:	5d                   	pop    %ebp
  80163f:	c3                   	ret    

00801640 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  801640:	55                   	push   %ebp
  801641:	89 e5                	mov    %esp,%ebp
  801643:	83 ec 04             	sub    $0x4,%esp
  801646:	8b 45 0c             	mov    0xc(%ebp),%eax
  801649:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80164c:	eb 12                	jmp    801660 <strchr+0x20>
		if (*s == c)
  80164e:	8b 45 08             	mov    0x8(%ebp),%eax
  801651:	8a 00                	mov    (%eax),%al
  801653:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801656:	75 05                	jne    80165d <strchr+0x1d>
			return (char *) s;
  801658:	8b 45 08             	mov    0x8(%ebp),%eax
  80165b:	eb 11                	jmp    80166e <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  80165d:	ff 45 08             	incl   0x8(%ebp)
  801660:	8b 45 08             	mov    0x8(%ebp),%eax
  801663:	8a 00                	mov    (%eax),%al
  801665:	84 c0                	test   %al,%al
  801667:	75 e5                	jne    80164e <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  801669:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80166e:	c9                   	leave  
  80166f:	c3                   	ret    

00801670 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  801670:	55                   	push   %ebp
  801671:	89 e5                	mov    %esp,%ebp
  801673:	83 ec 04             	sub    $0x4,%esp
  801676:	8b 45 0c             	mov    0xc(%ebp),%eax
  801679:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  80167c:	eb 0d                	jmp    80168b <strfind+0x1b>
		if (*s == c)
  80167e:	8b 45 08             	mov    0x8(%ebp),%eax
  801681:	8a 00                	mov    (%eax),%al
  801683:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801686:	74 0e                	je     801696 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  801688:	ff 45 08             	incl   0x8(%ebp)
  80168b:	8b 45 08             	mov    0x8(%ebp),%eax
  80168e:	8a 00                	mov    (%eax),%al
  801690:	84 c0                	test   %al,%al
  801692:	75 ea                	jne    80167e <strfind+0xe>
  801694:	eb 01                	jmp    801697 <strfind+0x27>
		if (*s == c)
			break;
  801696:	90                   	nop
	return (char *) s;
  801697:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80169a:	c9                   	leave  
  80169b:	c3                   	ret    

0080169c <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80169c:	55                   	push   %ebp
  80169d:	89 e5                	mov    %esp,%ebp
  80169f:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  8016a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  8016a8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  8016ae:	eb 0e                	jmp    8016be <memset+0x22>
		*p++ = c;
  8016b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8016b3:	8d 50 01             	lea    0x1(%eax),%edx
  8016b6:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8016b9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8016bc:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  8016be:	ff 4d f8             	decl   -0x8(%ebp)
  8016c1:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  8016c5:	79 e9                	jns    8016b0 <memset+0x14>
		*p++ = c;

	return v;
  8016c7:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8016ca:	c9                   	leave  
  8016cb:	c3                   	ret    

008016cc <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  8016cc:	55                   	push   %ebp
  8016cd:	89 e5                	mov    %esp,%ebp
  8016cf:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  8016d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8016d5:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  8016d8:	8b 45 08             	mov    0x8(%ebp),%eax
  8016db:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  8016de:	eb 16                	jmp    8016f6 <memcpy+0x2a>
		*d++ = *s++;
  8016e0:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8016e3:	8d 50 01             	lea    0x1(%eax),%edx
  8016e6:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8016e9:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8016ec:	8d 4a 01             	lea    0x1(%edx),%ecx
  8016ef:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8016f2:	8a 12                	mov    (%edx),%dl
  8016f4:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  8016f6:	8b 45 10             	mov    0x10(%ebp),%eax
  8016f9:	8d 50 ff             	lea    -0x1(%eax),%edx
  8016fc:	89 55 10             	mov    %edx,0x10(%ebp)
  8016ff:	85 c0                	test   %eax,%eax
  801701:	75 dd                	jne    8016e0 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801703:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801706:	c9                   	leave  
  801707:	c3                   	ret    

00801708 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801708:	55                   	push   %ebp
  801709:	89 e5                	mov    %esp,%ebp
  80170b:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  80170e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801711:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801714:	8b 45 08             	mov    0x8(%ebp),%eax
  801717:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80171a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80171d:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801720:	73 50                	jae    801772 <memmove+0x6a>
  801722:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801725:	8b 45 10             	mov    0x10(%ebp),%eax
  801728:	01 d0                	add    %edx,%eax
  80172a:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  80172d:	76 43                	jbe    801772 <memmove+0x6a>
		s += n;
  80172f:	8b 45 10             	mov    0x10(%ebp),%eax
  801732:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  801735:	8b 45 10             	mov    0x10(%ebp),%eax
  801738:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  80173b:	eb 10                	jmp    80174d <memmove+0x45>
			*--d = *--s;
  80173d:	ff 4d f8             	decl   -0x8(%ebp)
  801740:	ff 4d fc             	decl   -0x4(%ebp)
  801743:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801746:	8a 10                	mov    (%eax),%dl
  801748:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80174b:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  80174d:	8b 45 10             	mov    0x10(%ebp),%eax
  801750:	8d 50 ff             	lea    -0x1(%eax),%edx
  801753:	89 55 10             	mov    %edx,0x10(%ebp)
  801756:	85 c0                	test   %eax,%eax
  801758:	75 e3                	jne    80173d <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  80175a:	eb 23                	jmp    80177f <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  80175c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80175f:	8d 50 01             	lea    0x1(%eax),%edx
  801762:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801765:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801768:	8d 4a 01             	lea    0x1(%edx),%ecx
  80176b:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80176e:	8a 12                	mov    (%edx),%dl
  801770:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801772:	8b 45 10             	mov    0x10(%ebp),%eax
  801775:	8d 50 ff             	lea    -0x1(%eax),%edx
  801778:	89 55 10             	mov    %edx,0x10(%ebp)
  80177b:	85 c0                	test   %eax,%eax
  80177d:	75 dd                	jne    80175c <memmove+0x54>
			*d++ = *s++;

	return dst;
  80177f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801782:	c9                   	leave  
  801783:	c3                   	ret    

00801784 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801784:	55                   	push   %ebp
  801785:	89 e5                	mov    %esp,%ebp
  801787:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80178a:	8b 45 08             	mov    0x8(%ebp),%eax
  80178d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801790:	8b 45 0c             	mov    0xc(%ebp),%eax
  801793:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801796:	eb 2a                	jmp    8017c2 <memcmp+0x3e>
		if (*s1 != *s2)
  801798:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80179b:	8a 10                	mov    (%eax),%dl
  80179d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017a0:	8a 00                	mov    (%eax),%al
  8017a2:	38 c2                	cmp    %al,%dl
  8017a4:	74 16                	je     8017bc <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8017a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8017a9:	8a 00                	mov    (%eax),%al
  8017ab:	0f b6 d0             	movzbl %al,%edx
  8017ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8017b1:	8a 00                	mov    (%eax),%al
  8017b3:	0f b6 c0             	movzbl %al,%eax
  8017b6:	29 c2                	sub    %eax,%edx
  8017b8:	89 d0                	mov    %edx,%eax
  8017ba:	eb 18                	jmp    8017d4 <memcmp+0x50>
		s1++, s2++;
  8017bc:	ff 45 fc             	incl   -0x4(%ebp)
  8017bf:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8017c2:	8b 45 10             	mov    0x10(%ebp),%eax
  8017c5:	8d 50 ff             	lea    -0x1(%eax),%edx
  8017c8:	89 55 10             	mov    %edx,0x10(%ebp)
  8017cb:	85 c0                	test   %eax,%eax
  8017cd:	75 c9                	jne    801798 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8017cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017d4:	c9                   	leave  
  8017d5:	c3                   	ret    

008017d6 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8017d6:	55                   	push   %ebp
  8017d7:	89 e5                	mov    %esp,%ebp
  8017d9:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8017dc:	8b 55 08             	mov    0x8(%ebp),%edx
  8017df:	8b 45 10             	mov    0x10(%ebp),%eax
  8017e2:	01 d0                	add    %edx,%eax
  8017e4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8017e7:	eb 15                	jmp    8017fe <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8017e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ec:	8a 00                	mov    (%eax),%al
  8017ee:	0f b6 d0             	movzbl %al,%edx
  8017f1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8017f4:	0f b6 c0             	movzbl %al,%eax
  8017f7:	39 c2                	cmp    %eax,%edx
  8017f9:	74 0d                	je     801808 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8017fb:	ff 45 08             	incl   0x8(%ebp)
  8017fe:	8b 45 08             	mov    0x8(%ebp),%eax
  801801:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801804:	72 e3                	jb     8017e9 <memfind+0x13>
  801806:	eb 01                	jmp    801809 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801808:	90                   	nop
	return (void *) s;
  801809:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80180c:	c9                   	leave  
  80180d:	c3                   	ret    

0080180e <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  80180e:	55                   	push   %ebp
  80180f:	89 e5                	mov    %esp,%ebp
  801811:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801814:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80181b:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801822:	eb 03                	jmp    801827 <strtol+0x19>
		s++;
  801824:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801827:	8b 45 08             	mov    0x8(%ebp),%eax
  80182a:	8a 00                	mov    (%eax),%al
  80182c:	3c 20                	cmp    $0x20,%al
  80182e:	74 f4                	je     801824 <strtol+0x16>
  801830:	8b 45 08             	mov    0x8(%ebp),%eax
  801833:	8a 00                	mov    (%eax),%al
  801835:	3c 09                	cmp    $0x9,%al
  801837:	74 eb                	je     801824 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801839:	8b 45 08             	mov    0x8(%ebp),%eax
  80183c:	8a 00                	mov    (%eax),%al
  80183e:	3c 2b                	cmp    $0x2b,%al
  801840:	75 05                	jne    801847 <strtol+0x39>
		s++;
  801842:	ff 45 08             	incl   0x8(%ebp)
  801845:	eb 13                	jmp    80185a <strtol+0x4c>
	else if (*s == '-')
  801847:	8b 45 08             	mov    0x8(%ebp),%eax
  80184a:	8a 00                	mov    (%eax),%al
  80184c:	3c 2d                	cmp    $0x2d,%al
  80184e:	75 0a                	jne    80185a <strtol+0x4c>
		s++, neg = 1;
  801850:	ff 45 08             	incl   0x8(%ebp)
  801853:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  80185a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80185e:	74 06                	je     801866 <strtol+0x58>
  801860:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801864:	75 20                	jne    801886 <strtol+0x78>
  801866:	8b 45 08             	mov    0x8(%ebp),%eax
  801869:	8a 00                	mov    (%eax),%al
  80186b:	3c 30                	cmp    $0x30,%al
  80186d:	75 17                	jne    801886 <strtol+0x78>
  80186f:	8b 45 08             	mov    0x8(%ebp),%eax
  801872:	40                   	inc    %eax
  801873:	8a 00                	mov    (%eax),%al
  801875:	3c 78                	cmp    $0x78,%al
  801877:	75 0d                	jne    801886 <strtol+0x78>
		s += 2, base = 16;
  801879:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80187d:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801884:	eb 28                	jmp    8018ae <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801886:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80188a:	75 15                	jne    8018a1 <strtol+0x93>
  80188c:	8b 45 08             	mov    0x8(%ebp),%eax
  80188f:	8a 00                	mov    (%eax),%al
  801891:	3c 30                	cmp    $0x30,%al
  801893:	75 0c                	jne    8018a1 <strtol+0x93>
		s++, base = 8;
  801895:	ff 45 08             	incl   0x8(%ebp)
  801898:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80189f:	eb 0d                	jmp    8018ae <strtol+0xa0>
	else if (base == 0)
  8018a1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8018a5:	75 07                	jne    8018ae <strtol+0xa0>
		base = 10;
  8018a7:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8018ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8018b1:	8a 00                	mov    (%eax),%al
  8018b3:	3c 2f                	cmp    $0x2f,%al
  8018b5:	7e 19                	jle    8018d0 <strtol+0xc2>
  8018b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ba:	8a 00                	mov    (%eax),%al
  8018bc:	3c 39                	cmp    $0x39,%al
  8018be:	7f 10                	jg     8018d0 <strtol+0xc2>
			dig = *s - '0';
  8018c0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c3:	8a 00                	mov    (%eax),%al
  8018c5:	0f be c0             	movsbl %al,%eax
  8018c8:	83 e8 30             	sub    $0x30,%eax
  8018cb:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018ce:	eb 42                	jmp    801912 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8018d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d3:	8a 00                	mov    (%eax),%al
  8018d5:	3c 60                	cmp    $0x60,%al
  8018d7:	7e 19                	jle    8018f2 <strtol+0xe4>
  8018d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018dc:	8a 00                	mov    (%eax),%al
  8018de:	3c 7a                	cmp    $0x7a,%al
  8018e0:	7f 10                	jg     8018f2 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8018e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e5:	8a 00                	mov    (%eax),%al
  8018e7:	0f be c0             	movsbl %al,%eax
  8018ea:	83 e8 57             	sub    $0x57,%eax
  8018ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8018f0:	eb 20                	jmp    801912 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8018f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018f5:	8a 00                	mov    (%eax),%al
  8018f7:	3c 40                	cmp    $0x40,%al
  8018f9:	7e 39                	jle    801934 <strtol+0x126>
  8018fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8018fe:	8a 00                	mov    (%eax),%al
  801900:	3c 5a                	cmp    $0x5a,%al
  801902:	7f 30                	jg     801934 <strtol+0x126>
			dig = *s - 'A' + 10;
  801904:	8b 45 08             	mov    0x8(%ebp),%eax
  801907:	8a 00                	mov    (%eax),%al
  801909:	0f be c0             	movsbl %al,%eax
  80190c:	83 e8 37             	sub    $0x37,%eax
  80190f:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801912:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801915:	3b 45 10             	cmp    0x10(%ebp),%eax
  801918:	7d 19                	jge    801933 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80191a:	ff 45 08             	incl   0x8(%ebp)
  80191d:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801920:	0f af 45 10          	imul   0x10(%ebp),%eax
  801924:	89 c2                	mov    %eax,%edx
  801926:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801929:	01 d0                	add    %edx,%eax
  80192b:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  80192e:	e9 7b ff ff ff       	jmp    8018ae <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801933:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801934:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801938:	74 08                	je     801942 <strtol+0x134>
		*endptr = (char *) s;
  80193a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80193d:	8b 55 08             	mov    0x8(%ebp),%edx
  801940:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801942:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801946:	74 07                	je     80194f <strtol+0x141>
  801948:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80194b:	f7 d8                	neg    %eax
  80194d:	eb 03                	jmp    801952 <strtol+0x144>
  80194f:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801952:	c9                   	leave  
  801953:	c3                   	ret    

00801954 <ltostr>:

void
ltostr(long value, char *str)
{
  801954:	55                   	push   %ebp
  801955:	89 e5                	mov    %esp,%ebp
  801957:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  80195a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801961:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801968:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80196c:	79 13                	jns    801981 <ltostr+0x2d>
	{
		neg = 1;
  80196e:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801975:	8b 45 0c             	mov    0xc(%ebp),%eax
  801978:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  80197b:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80197e:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801981:	8b 45 08             	mov    0x8(%ebp),%eax
  801984:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801989:	99                   	cltd   
  80198a:	f7 f9                	idiv   %ecx
  80198c:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80198f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801992:	8d 50 01             	lea    0x1(%eax),%edx
  801995:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801998:	89 c2                	mov    %eax,%edx
  80199a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80199d:	01 d0                	add    %edx,%eax
  80199f:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8019a2:	83 c2 30             	add    $0x30,%edx
  8019a5:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8019a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019aa:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019af:	f7 e9                	imul   %ecx
  8019b1:	c1 fa 02             	sar    $0x2,%edx
  8019b4:	89 c8                	mov    %ecx,%eax
  8019b6:	c1 f8 1f             	sar    $0x1f,%eax
  8019b9:	29 c2                	sub    %eax,%edx
  8019bb:	89 d0                	mov    %edx,%eax
  8019bd:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8019c0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8019c3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8019c8:	f7 e9                	imul   %ecx
  8019ca:	c1 fa 02             	sar    $0x2,%edx
  8019cd:	89 c8                	mov    %ecx,%eax
  8019cf:	c1 f8 1f             	sar    $0x1f,%eax
  8019d2:	29 c2                	sub    %eax,%edx
  8019d4:	89 d0                	mov    %edx,%eax
  8019d6:	c1 e0 02             	shl    $0x2,%eax
  8019d9:	01 d0                	add    %edx,%eax
  8019db:	01 c0                	add    %eax,%eax
  8019dd:	29 c1                	sub    %eax,%ecx
  8019df:	89 ca                	mov    %ecx,%edx
  8019e1:	85 d2                	test   %edx,%edx
  8019e3:	75 9c                	jne    801981 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8019e5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8019ec:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8019ef:	48                   	dec    %eax
  8019f0:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8019f3:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8019f7:	74 3d                	je     801a36 <ltostr+0xe2>
		start = 1 ;
  8019f9:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801a00:	eb 34                	jmp    801a36 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801a02:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a05:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a08:	01 d0                	add    %edx,%eax
  801a0a:	8a 00                	mov    (%eax),%al
  801a0c:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801a0f:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801a12:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a15:	01 c2                	add    %eax,%edx
  801a17:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801a1a:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a1d:	01 c8                	add    %ecx,%eax
  801a1f:	8a 00                	mov    (%eax),%al
  801a21:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  801a23:	8b 55 f0             	mov    -0x10(%ebp),%edx
  801a26:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a29:	01 c2                	add    %eax,%edx
  801a2b:	8a 45 eb             	mov    -0x15(%ebp),%al
  801a2e:	88 02                	mov    %al,(%edx)
		start++ ;
  801a30:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801a33:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801a36:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801a39:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801a3c:	7c c4                	jl     801a02 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801a3e:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801a41:	8b 45 0c             	mov    0xc(%ebp),%eax
  801a44:	01 d0                	add    %edx,%eax
  801a46:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801a49:	90                   	nop
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
  801a4f:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801a52:	ff 75 08             	pushl  0x8(%ebp)
  801a55:	e8 54 fa ff ff       	call   8014ae <strlen>
  801a5a:	83 c4 04             	add    $0x4,%esp
  801a5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801a60:	ff 75 0c             	pushl  0xc(%ebp)
  801a63:	e8 46 fa ff ff       	call   8014ae <strlen>
  801a68:	83 c4 04             	add    $0x4,%esp
  801a6b:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801a6e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801a75:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801a7c:	eb 17                	jmp    801a95 <strcconcat+0x49>
		final[s] = str1[s] ;
  801a7e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801a81:	8b 45 10             	mov    0x10(%ebp),%eax
  801a84:	01 c2                	add    %eax,%edx
  801a86:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801a89:	8b 45 08             	mov    0x8(%ebp),%eax
  801a8c:	01 c8                	add    %ecx,%eax
  801a8e:	8a 00                	mov    (%eax),%al
  801a90:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801a92:	ff 45 fc             	incl   -0x4(%ebp)
  801a95:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801a98:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801a9b:	7c e1                	jl     801a7e <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801a9d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801aa4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801aab:	eb 1f                	jmp    801acc <strcconcat+0x80>
		final[s++] = str2[i] ;
  801aad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801ab0:	8d 50 01             	lea    0x1(%eax),%edx
  801ab3:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801ab6:	89 c2                	mov    %eax,%edx
  801ab8:	8b 45 10             	mov    0x10(%ebp),%eax
  801abb:	01 c2                	add    %eax,%edx
  801abd:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801ac0:	8b 45 0c             	mov    0xc(%ebp),%eax
  801ac3:	01 c8                	add    %ecx,%eax
  801ac5:	8a 00                	mov    (%eax),%al
  801ac7:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801ac9:	ff 45 f8             	incl   -0x8(%ebp)
  801acc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801acf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801ad2:	7c d9                	jl     801aad <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801ad4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801ad7:	8b 45 10             	mov    0x10(%ebp),%eax
  801ada:	01 d0                	add    %edx,%eax
  801adc:	c6 00 00             	movb   $0x0,(%eax)
}
  801adf:	90                   	nop
  801ae0:	c9                   	leave  
  801ae1:	c3                   	ret    

00801ae2 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801ae2:	55                   	push   %ebp
  801ae3:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801ae5:	8b 45 14             	mov    0x14(%ebp),%eax
  801ae8:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801aee:	8b 45 14             	mov    0x14(%ebp),%eax
  801af1:	8b 00                	mov    (%eax),%eax
  801af3:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801afa:	8b 45 10             	mov    0x10(%ebp),%eax
  801afd:	01 d0                	add    %edx,%eax
  801aff:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b05:	eb 0c                	jmp    801b13 <strsplit+0x31>
			*string++ = 0;
  801b07:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0a:	8d 50 01             	lea    0x1(%eax),%edx
  801b0d:	89 55 08             	mov    %edx,0x8(%ebp)
  801b10:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801b13:	8b 45 08             	mov    0x8(%ebp),%eax
  801b16:	8a 00                	mov    (%eax),%al
  801b18:	84 c0                	test   %al,%al
  801b1a:	74 18                	je     801b34 <strsplit+0x52>
  801b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1f:	8a 00                	mov    (%eax),%al
  801b21:	0f be c0             	movsbl %al,%eax
  801b24:	50                   	push   %eax
  801b25:	ff 75 0c             	pushl  0xc(%ebp)
  801b28:	e8 13 fb ff ff       	call   801640 <strchr>
  801b2d:	83 c4 08             	add    $0x8,%esp
  801b30:	85 c0                	test   %eax,%eax
  801b32:	75 d3                	jne    801b07 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801b34:	8b 45 08             	mov    0x8(%ebp),%eax
  801b37:	8a 00                	mov    (%eax),%al
  801b39:	84 c0                	test   %al,%al
  801b3b:	74 5a                	je     801b97 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801b3d:	8b 45 14             	mov    0x14(%ebp),%eax
  801b40:	8b 00                	mov    (%eax),%eax
  801b42:	83 f8 0f             	cmp    $0xf,%eax
  801b45:	75 07                	jne    801b4e <strsplit+0x6c>
		{
			return 0;
  801b47:	b8 00 00 00 00       	mov    $0x0,%eax
  801b4c:	eb 66                	jmp    801bb4 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801b4e:	8b 45 14             	mov    0x14(%ebp),%eax
  801b51:	8b 00                	mov    (%eax),%eax
  801b53:	8d 48 01             	lea    0x1(%eax),%ecx
  801b56:	8b 55 14             	mov    0x14(%ebp),%edx
  801b59:	89 0a                	mov    %ecx,(%edx)
  801b5b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801b62:	8b 45 10             	mov    0x10(%ebp),%eax
  801b65:	01 c2                	add    %eax,%edx
  801b67:	8b 45 08             	mov    0x8(%ebp),%eax
  801b6a:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b6c:	eb 03                	jmp    801b71 <strsplit+0x8f>
			string++;
  801b6e:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801b71:	8b 45 08             	mov    0x8(%ebp),%eax
  801b74:	8a 00                	mov    (%eax),%al
  801b76:	84 c0                	test   %al,%al
  801b78:	74 8b                	je     801b05 <strsplit+0x23>
  801b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b7d:	8a 00                	mov    (%eax),%al
  801b7f:	0f be c0             	movsbl %al,%eax
  801b82:	50                   	push   %eax
  801b83:	ff 75 0c             	pushl  0xc(%ebp)
  801b86:	e8 b5 fa ff ff       	call   801640 <strchr>
  801b8b:	83 c4 08             	add    $0x8,%esp
  801b8e:	85 c0                	test   %eax,%eax
  801b90:	74 dc                	je     801b6e <strsplit+0x8c>
			string++;
	}
  801b92:	e9 6e ff ff ff       	jmp    801b05 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801b97:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801b98:	8b 45 14             	mov    0x14(%ebp),%eax
  801b9b:	8b 00                	mov    (%eax),%eax
  801b9d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801ba4:	8b 45 10             	mov    0x10(%ebp),%eax
  801ba7:	01 d0                	add    %edx,%eax
  801ba9:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801baf:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801bb4:	c9                   	leave  
  801bb5:	c3                   	ret    

00801bb6 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801bb6:	55                   	push   %ebp
  801bb7:	89 e5                	mov    %esp,%ebp
  801bb9:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801bbc:	83 ec 04             	sub    $0x4,%esp
  801bbf:	68 84 2d 80 00       	push   $0x802d84
  801bc4:	6a 15                	push   $0x15
  801bc6:	68 a9 2d 80 00       	push   $0x802da9
  801bcb:	e8 a2 ed ff ff       	call   800972 <_panic>

00801bd0 <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  801bd0:	55                   	push   %ebp
  801bd1:	89 e5                	mov    %esp,%ebp
  801bd3:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  801bd6:	83 ec 04             	sub    $0x4,%esp
  801bd9:	68 b8 2d 80 00       	push   $0x802db8
  801bde:	6a 2e                	push   $0x2e
  801be0:	68 a9 2d 80 00       	push   $0x802da9
  801be5:	e8 88 ed ff ff       	call   800972 <_panic>

00801bea <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  801bea:	55                   	push   %ebp
  801beb:	89 e5                	mov    %esp,%ebp
  801bed:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801bf0:	83 ec 04             	sub    $0x4,%esp
  801bf3:	68 dc 2d 80 00       	push   $0x802ddc
  801bf8:	6a 4c                	push   $0x4c
  801bfa:	68 a9 2d 80 00       	push   $0x802da9
  801bff:	e8 6e ed ff ff       	call   800972 <_panic>

00801c04 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801c04:	55                   	push   %ebp
  801c05:	89 e5                	mov    %esp,%ebp
  801c07:	83 ec 18             	sub    $0x18,%esp
  801c0a:	8b 45 10             	mov    0x10(%ebp),%eax
  801c0d:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  801c10:	83 ec 04             	sub    $0x4,%esp
  801c13:	68 dc 2d 80 00       	push   $0x802ddc
  801c18:	6a 57                	push   $0x57
  801c1a:	68 a9 2d 80 00       	push   $0x802da9
  801c1f:	e8 4e ed ff ff       	call   800972 <_panic>

00801c24 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801c24:	55                   	push   %ebp
  801c25:	89 e5                	mov    %esp,%ebp
  801c27:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c2a:	83 ec 04             	sub    $0x4,%esp
  801c2d:	68 dc 2d 80 00       	push   $0x802ddc
  801c32:	6a 5d                	push   $0x5d
  801c34:	68 a9 2d 80 00       	push   $0x802da9
  801c39:	e8 34 ed ff ff       	call   800972 <_panic>

00801c3e <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  801c3e:	55                   	push   %ebp
  801c3f:	89 e5                	mov    %esp,%ebp
  801c41:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c44:	83 ec 04             	sub    $0x4,%esp
  801c47:	68 dc 2d 80 00       	push   $0x802ddc
  801c4c:	6a 63                	push   $0x63
  801c4e:	68 a9 2d 80 00       	push   $0x802da9
  801c53:	e8 1a ed ff ff       	call   800972 <_panic>

00801c58 <expand>:
}

void expand(uint32 newSize)
{
  801c58:	55                   	push   %ebp
  801c59:	89 e5                	mov    %esp,%ebp
  801c5b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c5e:	83 ec 04             	sub    $0x4,%esp
  801c61:	68 dc 2d 80 00       	push   $0x802ddc
  801c66:	6a 68                	push   $0x68
  801c68:	68 a9 2d 80 00       	push   $0x802da9
  801c6d:	e8 00 ed ff ff       	call   800972 <_panic>

00801c72 <shrink>:
}
void shrink(uint32 newSize)
{
  801c72:	55                   	push   %ebp
  801c73:	89 e5                	mov    %esp,%ebp
  801c75:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c78:	83 ec 04             	sub    $0x4,%esp
  801c7b:	68 dc 2d 80 00       	push   $0x802ddc
  801c80:	6a 6c                	push   $0x6c
  801c82:	68 a9 2d 80 00       	push   $0x802da9
  801c87:	e8 e6 ec ff ff       	call   800972 <_panic>

00801c8c <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801c8c:	55                   	push   %ebp
  801c8d:	89 e5                	mov    %esp,%ebp
  801c8f:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801c92:	83 ec 04             	sub    $0x4,%esp
  801c95:	68 dc 2d 80 00       	push   $0x802ddc
  801c9a:	6a 71                	push   $0x71
  801c9c:	68 a9 2d 80 00       	push   $0x802da9
  801ca1:	e8 cc ec ff ff       	call   800972 <_panic>

00801ca6 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801ca6:	55                   	push   %ebp
  801ca7:	89 e5                	mov    %esp,%ebp
  801ca9:	57                   	push   %edi
  801caa:	56                   	push   %esi
  801cab:	53                   	push   %ebx
  801cac:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801caf:	8b 45 08             	mov    0x8(%ebp),%eax
  801cb2:	8b 55 0c             	mov    0xc(%ebp),%edx
  801cb5:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801cb8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801cbb:	8b 7d 18             	mov    0x18(%ebp),%edi
  801cbe:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801cc1:	cd 30                	int    $0x30
  801cc3:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801cc6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801cc9:	83 c4 10             	add    $0x10,%esp
  801ccc:	5b                   	pop    %ebx
  801ccd:	5e                   	pop    %esi
  801cce:	5f                   	pop    %edi
  801ccf:	5d                   	pop    %ebp
  801cd0:	c3                   	ret    

00801cd1 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801cd1:	55                   	push   %ebp
  801cd2:	89 e5                	mov    %esp,%ebp
  801cd4:	83 ec 04             	sub    $0x4,%esp
  801cd7:	8b 45 10             	mov    0x10(%ebp),%eax
  801cda:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801cdd:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801ce1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	52                   	push   %edx
  801ce9:	ff 75 0c             	pushl  0xc(%ebp)
  801cec:	50                   	push   %eax
  801ced:	6a 00                	push   $0x0
  801cef:	e8 b2 ff ff ff       	call   801ca6 <syscall>
  801cf4:	83 c4 18             	add    $0x18,%esp
}
  801cf7:	90                   	nop
  801cf8:	c9                   	leave  
  801cf9:	c3                   	ret    

00801cfa <sys_cgetc>:

int
sys_cgetc(void)
{
  801cfa:	55                   	push   %ebp
  801cfb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801cfd:	6a 00                	push   $0x0
  801cff:	6a 00                	push   $0x0
  801d01:	6a 00                	push   $0x0
  801d03:	6a 00                	push   $0x0
  801d05:	6a 00                	push   $0x0
  801d07:	6a 01                	push   $0x1
  801d09:	e8 98 ff ff ff       	call   801ca6 <syscall>
  801d0e:	83 c4 18             	add    $0x18,%esp
}
  801d11:	c9                   	leave  
  801d12:	c3                   	ret    

00801d13 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  801d13:	55                   	push   %ebp
  801d14:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801d16:	8b 45 08             	mov    0x8(%ebp),%eax
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 00                	push   $0x0
  801d1d:	6a 00                	push   $0x0
  801d1f:	6a 00                	push   $0x0
  801d21:	50                   	push   %eax
  801d22:	6a 05                	push   $0x5
  801d24:	e8 7d ff ff ff       	call   801ca6 <syscall>
  801d29:	83 c4 18             	add    $0x18,%esp
}
  801d2c:	c9                   	leave  
  801d2d:	c3                   	ret    

00801d2e <sys_getenvid>:

int32 sys_getenvid(void)
{
  801d2e:	55                   	push   %ebp
  801d2f:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801d31:	6a 00                	push   $0x0
  801d33:	6a 00                	push   $0x0
  801d35:	6a 00                	push   $0x0
  801d37:	6a 00                	push   $0x0
  801d39:	6a 00                	push   $0x0
  801d3b:	6a 02                	push   $0x2
  801d3d:	e8 64 ff ff ff       	call   801ca6 <syscall>
  801d42:	83 c4 18             	add    $0x18,%esp
}
  801d45:	c9                   	leave  
  801d46:	c3                   	ret    

00801d47 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801d47:	55                   	push   %ebp
  801d48:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801d4a:	6a 00                	push   $0x0
  801d4c:	6a 00                	push   $0x0
  801d4e:	6a 00                	push   $0x0
  801d50:	6a 00                	push   $0x0
  801d52:	6a 00                	push   $0x0
  801d54:	6a 03                	push   $0x3
  801d56:	e8 4b ff ff ff       	call   801ca6 <syscall>
  801d5b:	83 c4 18             	add    $0x18,%esp
}
  801d5e:	c9                   	leave  
  801d5f:	c3                   	ret    

00801d60 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801d60:	55                   	push   %ebp
  801d61:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801d63:	6a 00                	push   $0x0
  801d65:	6a 00                	push   $0x0
  801d67:	6a 00                	push   $0x0
  801d69:	6a 00                	push   $0x0
  801d6b:	6a 00                	push   $0x0
  801d6d:	6a 04                	push   $0x4
  801d6f:	e8 32 ff ff ff       	call   801ca6 <syscall>
  801d74:	83 c4 18             	add    $0x18,%esp
}
  801d77:	c9                   	leave  
  801d78:	c3                   	ret    

00801d79 <sys_env_exit>:


void sys_env_exit(void)
{
  801d79:	55                   	push   %ebp
  801d7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801d7c:	6a 00                	push   $0x0
  801d7e:	6a 00                	push   $0x0
  801d80:	6a 00                	push   $0x0
  801d82:	6a 00                	push   $0x0
  801d84:	6a 00                	push   $0x0
  801d86:	6a 06                	push   $0x6
  801d88:	e8 19 ff ff ff       	call   801ca6 <syscall>
  801d8d:	83 c4 18             	add    $0x18,%esp
}
  801d90:	90                   	nop
  801d91:	c9                   	leave  
  801d92:	c3                   	ret    

00801d93 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801d93:	55                   	push   %ebp
  801d94:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801d96:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d99:	8b 45 08             	mov    0x8(%ebp),%eax
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	52                   	push   %edx
  801da3:	50                   	push   %eax
  801da4:	6a 07                	push   $0x7
  801da6:	e8 fb fe ff ff       	call   801ca6 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
}
  801dae:	c9                   	leave  
  801daf:	c3                   	ret    

00801db0 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801db0:	55                   	push   %ebp
  801db1:	89 e5                	mov    %esp,%ebp
  801db3:	56                   	push   %esi
  801db4:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801db5:	8b 75 18             	mov    0x18(%ebp),%esi
  801db8:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801dbb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801dbe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801dc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801dc4:	56                   	push   %esi
  801dc5:	53                   	push   %ebx
  801dc6:	51                   	push   %ecx
  801dc7:	52                   	push   %edx
  801dc8:	50                   	push   %eax
  801dc9:	6a 08                	push   $0x8
  801dcb:	e8 d6 fe ff ff       	call   801ca6 <syscall>
  801dd0:	83 c4 18             	add    $0x18,%esp
}
  801dd3:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801dd6:	5b                   	pop    %ebx
  801dd7:	5e                   	pop    %esi
  801dd8:	5d                   	pop    %ebp
  801dd9:	c3                   	ret    

00801dda <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801dda:	55                   	push   %ebp
  801ddb:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801ddd:	8b 55 0c             	mov    0xc(%ebp),%edx
  801de0:	8b 45 08             	mov    0x8(%ebp),%eax
  801de3:	6a 00                	push   $0x0
  801de5:	6a 00                	push   $0x0
  801de7:	6a 00                	push   $0x0
  801de9:	52                   	push   %edx
  801dea:	50                   	push   %eax
  801deb:	6a 09                	push   $0x9
  801ded:	e8 b4 fe ff ff       	call   801ca6 <syscall>
  801df2:	83 c4 18             	add    $0x18,%esp
}
  801df5:	c9                   	leave  
  801df6:	c3                   	ret    

00801df7 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801df7:	55                   	push   %ebp
  801df8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801dfa:	6a 00                	push   $0x0
  801dfc:	6a 00                	push   $0x0
  801dfe:	6a 00                	push   $0x0
  801e00:	ff 75 0c             	pushl  0xc(%ebp)
  801e03:	ff 75 08             	pushl  0x8(%ebp)
  801e06:	6a 0a                	push   $0xa
  801e08:	e8 99 fe ff ff       	call   801ca6 <syscall>
  801e0d:	83 c4 18             	add    $0x18,%esp
}
  801e10:	c9                   	leave  
  801e11:	c3                   	ret    

00801e12 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  801e12:	55                   	push   %ebp
  801e13:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801e15:	6a 00                	push   $0x0
  801e17:	6a 00                	push   $0x0
  801e19:	6a 00                	push   $0x0
  801e1b:	6a 00                	push   $0x0
  801e1d:	6a 00                	push   $0x0
  801e1f:	6a 0b                	push   $0xb
  801e21:	e8 80 fe ff ff       	call   801ca6 <syscall>
  801e26:	83 c4 18             	add    $0x18,%esp
}
  801e29:	c9                   	leave  
  801e2a:	c3                   	ret    

00801e2b <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801e2b:	55                   	push   %ebp
  801e2c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801e2e:	6a 00                	push   $0x0
  801e30:	6a 00                	push   $0x0
  801e32:	6a 00                	push   $0x0
  801e34:	6a 00                	push   $0x0
  801e36:	6a 00                	push   $0x0
  801e38:	6a 0c                	push   $0xc
  801e3a:	e8 67 fe ff ff       	call   801ca6 <syscall>
  801e3f:	83 c4 18             	add    $0x18,%esp
}
  801e42:	c9                   	leave  
  801e43:	c3                   	ret    

00801e44 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801e44:	55                   	push   %ebp
  801e45:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801e47:	6a 00                	push   $0x0
  801e49:	6a 00                	push   $0x0
  801e4b:	6a 00                	push   $0x0
  801e4d:	6a 00                	push   $0x0
  801e4f:	6a 00                	push   $0x0
  801e51:	6a 0d                	push   $0xd
  801e53:	e8 4e fe ff ff       	call   801ca6 <syscall>
  801e58:	83 c4 18             	add    $0x18,%esp
}
  801e5b:	c9                   	leave  
  801e5c:	c3                   	ret    

00801e5d <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801e5d:	55                   	push   %ebp
  801e5e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801e60:	6a 00                	push   $0x0
  801e62:	6a 00                	push   $0x0
  801e64:	6a 00                	push   $0x0
  801e66:	ff 75 0c             	pushl  0xc(%ebp)
  801e69:	ff 75 08             	pushl  0x8(%ebp)
  801e6c:	6a 11                	push   $0x11
  801e6e:	e8 33 fe ff ff       	call   801ca6 <syscall>
  801e73:	83 c4 18             	add    $0x18,%esp
	return;
  801e76:	90                   	nop
}
  801e77:	c9                   	leave  
  801e78:	c3                   	ret    

00801e79 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801e79:	55                   	push   %ebp
  801e7a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801e7c:	6a 00                	push   $0x0
  801e7e:	6a 00                	push   $0x0
  801e80:	6a 00                	push   $0x0
  801e82:	ff 75 0c             	pushl  0xc(%ebp)
  801e85:	ff 75 08             	pushl  0x8(%ebp)
  801e88:	6a 12                	push   $0x12
  801e8a:	e8 17 fe ff ff       	call   801ca6 <syscall>
  801e8f:	83 c4 18             	add    $0x18,%esp
	return ;
  801e92:	90                   	nop
}
  801e93:	c9                   	leave  
  801e94:	c3                   	ret    

00801e95 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801e95:	55                   	push   %ebp
  801e96:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801e98:	6a 00                	push   $0x0
  801e9a:	6a 00                	push   $0x0
  801e9c:	6a 00                	push   $0x0
  801e9e:	6a 00                	push   $0x0
  801ea0:	6a 00                	push   $0x0
  801ea2:	6a 0e                	push   $0xe
  801ea4:	e8 fd fd ff ff       	call   801ca6 <syscall>
  801ea9:	83 c4 18             	add    $0x18,%esp
}
  801eac:	c9                   	leave  
  801ead:	c3                   	ret    

00801eae <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801eae:	55                   	push   %ebp
  801eaf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801eb1:	6a 00                	push   $0x0
  801eb3:	6a 00                	push   $0x0
  801eb5:	6a 00                	push   $0x0
  801eb7:	6a 00                	push   $0x0
  801eb9:	ff 75 08             	pushl  0x8(%ebp)
  801ebc:	6a 0f                	push   $0xf
  801ebe:	e8 e3 fd ff ff       	call   801ca6 <syscall>
  801ec3:	83 c4 18             	add    $0x18,%esp
}
  801ec6:	c9                   	leave  
  801ec7:	c3                   	ret    

00801ec8 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801ec8:	55                   	push   %ebp
  801ec9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801ecb:	6a 00                	push   $0x0
  801ecd:	6a 00                	push   $0x0
  801ecf:	6a 00                	push   $0x0
  801ed1:	6a 00                	push   $0x0
  801ed3:	6a 00                	push   $0x0
  801ed5:	6a 10                	push   $0x10
  801ed7:	e8 ca fd ff ff       	call   801ca6 <syscall>
  801edc:	83 c4 18             	add    $0x18,%esp
}
  801edf:	90                   	nop
  801ee0:	c9                   	leave  
  801ee1:	c3                   	ret    

00801ee2 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801ee2:	55                   	push   %ebp
  801ee3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801ee5:	6a 00                	push   $0x0
  801ee7:	6a 00                	push   $0x0
  801ee9:	6a 00                	push   $0x0
  801eeb:	6a 00                	push   $0x0
  801eed:	6a 00                	push   $0x0
  801eef:	6a 14                	push   $0x14
  801ef1:	e8 b0 fd ff ff       	call   801ca6 <syscall>
  801ef6:	83 c4 18             	add    $0x18,%esp
}
  801ef9:	90                   	nop
  801efa:	c9                   	leave  
  801efb:	c3                   	ret    

00801efc <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801efc:	55                   	push   %ebp
  801efd:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801eff:	6a 00                	push   $0x0
  801f01:	6a 00                	push   $0x0
  801f03:	6a 00                	push   $0x0
  801f05:	6a 00                	push   $0x0
  801f07:	6a 00                	push   $0x0
  801f09:	6a 15                	push   $0x15
  801f0b:	e8 96 fd ff ff       	call   801ca6 <syscall>
  801f10:	83 c4 18             	add    $0x18,%esp
}
  801f13:	90                   	nop
  801f14:	c9                   	leave  
  801f15:	c3                   	ret    

00801f16 <sys_cputc>:


void
sys_cputc(const char c)
{
  801f16:	55                   	push   %ebp
  801f17:	89 e5                	mov    %esp,%ebp
  801f19:	83 ec 04             	sub    $0x4,%esp
  801f1c:	8b 45 08             	mov    0x8(%ebp),%eax
  801f1f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801f22:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801f26:	6a 00                	push   $0x0
  801f28:	6a 00                	push   $0x0
  801f2a:	6a 00                	push   $0x0
  801f2c:	6a 00                	push   $0x0
  801f2e:	50                   	push   %eax
  801f2f:	6a 16                	push   $0x16
  801f31:	e8 70 fd ff ff       	call   801ca6 <syscall>
  801f36:	83 c4 18             	add    $0x18,%esp
}
  801f39:	90                   	nop
  801f3a:	c9                   	leave  
  801f3b:	c3                   	ret    

00801f3c <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801f3c:	55                   	push   %ebp
  801f3d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801f3f:	6a 00                	push   $0x0
  801f41:	6a 00                	push   $0x0
  801f43:	6a 00                	push   $0x0
  801f45:	6a 00                	push   $0x0
  801f47:	6a 00                	push   $0x0
  801f49:	6a 17                	push   $0x17
  801f4b:	e8 56 fd ff ff       	call   801ca6 <syscall>
  801f50:	83 c4 18             	add    $0x18,%esp
}
  801f53:	90                   	nop
  801f54:	c9                   	leave  
  801f55:	c3                   	ret    

00801f56 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801f56:	55                   	push   %ebp
  801f57:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801f59:	8b 45 08             	mov    0x8(%ebp),%eax
  801f5c:	6a 00                	push   $0x0
  801f5e:	6a 00                	push   $0x0
  801f60:	6a 00                	push   $0x0
  801f62:	ff 75 0c             	pushl  0xc(%ebp)
  801f65:	50                   	push   %eax
  801f66:	6a 18                	push   $0x18
  801f68:	e8 39 fd ff ff       	call   801ca6 <syscall>
  801f6d:	83 c4 18             	add    $0x18,%esp
}
  801f70:	c9                   	leave  
  801f71:	c3                   	ret    

00801f72 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801f72:	55                   	push   %ebp
  801f73:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f75:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f78:	8b 45 08             	mov    0x8(%ebp),%eax
  801f7b:	6a 00                	push   $0x0
  801f7d:	6a 00                	push   $0x0
  801f7f:	6a 00                	push   $0x0
  801f81:	52                   	push   %edx
  801f82:	50                   	push   %eax
  801f83:	6a 1b                	push   $0x1b
  801f85:	e8 1c fd ff ff       	call   801ca6 <syscall>
  801f8a:	83 c4 18             	add    $0x18,%esp
}
  801f8d:	c9                   	leave  
  801f8e:	c3                   	ret    

00801f8f <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801f8f:	55                   	push   %ebp
  801f90:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801f92:	8b 55 0c             	mov    0xc(%ebp),%edx
  801f95:	8b 45 08             	mov    0x8(%ebp),%eax
  801f98:	6a 00                	push   $0x0
  801f9a:	6a 00                	push   $0x0
  801f9c:	6a 00                	push   $0x0
  801f9e:	52                   	push   %edx
  801f9f:	50                   	push   %eax
  801fa0:	6a 19                	push   $0x19
  801fa2:	e8 ff fc ff ff       	call   801ca6 <syscall>
  801fa7:	83 c4 18             	add    $0x18,%esp
}
  801faa:	90                   	nop
  801fab:	c9                   	leave  
  801fac:	c3                   	ret    

00801fad <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801fad:	55                   	push   %ebp
  801fae:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801fb0:	8b 55 0c             	mov    0xc(%ebp),%edx
  801fb3:	8b 45 08             	mov    0x8(%ebp),%eax
  801fb6:	6a 00                	push   $0x0
  801fb8:	6a 00                	push   $0x0
  801fba:	6a 00                	push   $0x0
  801fbc:	52                   	push   %edx
  801fbd:	50                   	push   %eax
  801fbe:	6a 1a                	push   $0x1a
  801fc0:	e8 e1 fc ff ff       	call   801ca6 <syscall>
  801fc5:	83 c4 18             	add    $0x18,%esp
}
  801fc8:	90                   	nop
  801fc9:	c9                   	leave  
  801fca:	c3                   	ret    

00801fcb <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801fcb:	55                   	push   %ebp
  801fcc:	89 e5                	mov    %esp,%ebp
  801fce:	83 ec 04             	sub    $0x4,%esp
  801fd1:	8b 45 10             	mov    0x10(%ebp),%eax
  801fd4:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801fd7:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801fda:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801fde:	8b 45 08             	mov    0x8(%ebp),%eax
  801fe1:	6a 00                	push   $0x0
  801fe3:	51                   	push   %ecx
  801fe4:	52                   	push   %edx
  801fe5:	ff 75 0c             	pushl  0xc(%ebp)
  801fe8:	50                   	push   %eax
  801fe9:	6a 1c                	push   $0x1c
  801feb:	e8 b6 fc ff ff       	call   801ca6 <syscall>
  801ff0:	83 c4 18             	add    $0x18,%esp
}
  801ff3:	c9                   	leave  
  801ff4:	c3                   	ret    

00801ff5 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801ff5:	55                   	push   %ebp
  801ff6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801ff8:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ffb:	8b 45 08             	mov    0x8(%ebp),%eax
  801ffe:	6a 00                	push   $0x0
  802000:	6a 00                	push   $0x0
  802002:	6a 00                	push   $0x0
  802004:	52                   	push   %edx
  802005:	50                   	push   %eax
  802006:	6a 1d                	push   $0x1d
  802008:	e8 99 fc ff ff       	call   801ca6 <syscall>
  80200d:	83 c4 18             	add    $0x18,%esp
}
  802010:	c9                   	leave  
  802011:	c3                   	ret    

00802012 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  802012:	55                   	push   %ebp
  802013:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  802015:	8b 4d 10             	mov    0x10(%ebp),%ecx
  802018:	8b 55 0c             	mov    0xc(%ebp),%edx
  80201b:	8b 45 08             	mov    0x8(%ebp),%eax
  80201e:	6a 00                	push   $0x0
  802020:	6a 00                	push   $0x0
  802022:	51                   	push   %ecx
  802023:	52                   	push   %edx
  802024:	50                   	push   %eax
  802025:	6a 1e                	push   $0x1e
  802027:	e8 7a fc ff ff       	call   801ca6 <syscall>
  80202c:	83 c4 18             	add    $0x18,%esp
}
  80202f:	c9                   	leave  
  802030:	c3                   	ret    

00802031 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  802031:	55                   	push   %ebp
  802032:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  802034:	8b 55 0c             	mov    0xc(%ebp),%edx
  802037:	8b 45 08             	mov    0x8(%ebp),%eax
  80203a:	6a 00                	push   $0x0
  80203c:	6a 00                	push   $0x0
  80203e:	6a 00                	push   $0x0
  802040:	52                   	push   %edx
  802041:	50                   	push   %eax
  802042:	6a 1f                	push   $0x1f
  802044:	e8 5d fc ff ff       	call   801ca6 <syscall>
  802049:	83 c4 18             	add    $0x18,%esp
}
  80204c:	c9                   	leave  
  80204d:	c3                   	ret    

0080204e <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80204e:	55                   	push   %ebp
  80204f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  802051:	6a 00                	push   $0x0
  802053:	6a 00                	push   $0x0
  802055:	6a 00                	push   $0x0
  802057:	6a 00                	push   $0x0
  802059:	6a 00                	push   $0x0
  80205b:	6a 20                	push   $0x20
  80205d:	e8 44 fc ff ff       	call   801ca6 <syscall>
  802062:	83 c4 18             	add    $0x18,%esp
}
  802065:	c9                   	leave  
  802066:	c3                   	ret    

00802067 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  802067:	55                   	push   %ebp
  802068:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  80206a:	8b 45 08             	mov    0x8(%ebp),%eax
  80206d:	6a 00                	push   $0x0
  80206f:	ff 75 14             	pushl  0x14(%ebp)
  802072:	ff 75 10             	pushl  0x10(%ebp)
  802075:	ff 75 0c             	pushl  0xc(%ebp)
  802078:	50                   	push   %eax
  802079:	6a 21                	push   $0x21
  80207b:	e8 26 fc ff ff       	call   801ca6 <syscall>
  802080:	83 c4 18             	add    $0x18,%esp
}
  802083:	c9                   	leave  
  802084:	c3                   	ret    

00802085 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  802085:	55                   	push   %ebp
  802086:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  802088:	8b 45 08             	mov    0x8(%ebp),%eax
  80208b:	6a 00                	push   $0x0
  80208d:	6a 00                	push   $0x0
  80208f:	6a 00                	push   $0x0
  802091:	6a 00                	push   $0x0
  802093:	50                   	push   %eax
  802094:	6a 22                	push   $0x22
  802096:	e8 0b fc ff ff       	call   801ca6 <syscall>
  80209b:	83 c4 18             	add    $0x18,%esp
}
  80209e:	90                   	nop
  80209f:	c9                   	leave  
  8020a0:	c3                   	ret    

008020a1 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8020a1:	55                   	push   %ebp
  8020a2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8020a4:	8b 45 08             	mov    0x8(%ebp),%eax
  8020a7:	6a 00                	push   $0x0
  8020a9:	6a 00                	push   $0x0
  8020ab:	6a 00                	push   $0x0
  8020ad:	6a 00                	push   $0x0
  8020af:	50                   	push   %eax
  8020b0:	6a 23                	push   $0x23
  8020b2:	e8 ef fb ff ff       	call   801ca6 <syscall>
  8020b7:	83 c4 18             	add    $0x18,%esp
}
  8020ba:	90                   	nop
  8020bb:	c9                   	leave  
  8020bc:	c3                   	ret    

008020bd <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8020bd:	55                   	push   %ebp
  8020be:	89 e5                	mov    %esp,%ebp
  8020c0:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8020c3:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020c6:	8d 50 04             	lea    0x4(%eax),%edx
  8020c9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8020cc:	6a 00                	push   $0x0
  8020ce:	6a 00                	push   $0x0
  8020d0:	6a 00                	push   $0x0
  8020d2:	52                   	push   %edx
  8020d3:	50                   	push   %eax
  8020d4:	6a 24                	push   $0x24
  8020d6:	e8 cb fb ff ff       	call   801ca6 <syscall>
  8020db:	83 c4 18             	add    $0x18,%esp
	return result;
  8020de:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8020e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8020e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8020e7:	89 01                	mov    %eax,(%ecx)
  8020e9:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8020ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8020ef:	c9                   	leave  
  8020f0:	c2 04 00             	ret    $0x4

008020f3 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8020f3:	55                   	push   %ebp
  8020f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8020f6:	6a 00                	push   $0x0
  8020f8:	6a 00                	push   $0x0
  8020fa:	ff 75 10             	pushl  0x10(%ebp)
  8020fd:	ff 75 0c             	pushl  0xc(%ebp)
  802100:	ff 75 08             	pushl  0x8(%ebp)
  802103:	6a 13                	push   $0x13
  802105:	e8 9c fb ff ff       	call   801ca6 <syscall>
  80210a:	83 c4 18             	add    $0x18,%esp
	return ;
  80210d:	90                   	nop
}
  80210e:	c9                   	leave  
  80210f:	c3                   	ret    

00802110 <sys_rcr2>:
uint32 sys_rcr2()
{
  802110:	55                   	push   %ebp
  802111:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  802113:	6a 00                	push   $0x0
  802115:	6a 00                	push   $0x0
  802117:	6a 00                	push   $0x0
  802119:	6a 00                	push   $0x0
  80211b:	6a 00                	push   $0x0
  80211d:	6a 25                	push   $0x25
  80211f:	e8 82 fb ff ff       	call   801ca6 <syscall>
  802124:	83 c4 18             	add    $0x18,%esp
}
  802127:	c9                   	leave  
  802128:	c3                   	ret    

00802129 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  802129:	55                   	push   %ebp
  80212a:	89 e5                	mov    %esp,%ebp
  80212c:	83 ec 04             	sub    $0x4,%esp
  80212f:	8b 45 08             	mov    0x8(%ebp),%eax
  802132:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  802135:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  802139:	6a 00                	push   $0x0
  80213b:	6a 00                	push   $0x0
  80213d:	6a 00                	push   $0x0
  80213f:	6a 00                	push   $0x0
  802141:	50                   	push   %eax
  802142:	6a 26                	push   $0x26
  802144:	e8 5d fb ff ff       	call   801ca6 <syscall>
  802149:	83 c4 18             	add    $0x18,%esp
	return ;
  80214c:	90                   	nop
}
  80214d:	c9                   	leave  
  80214e:	c3                   	ret    

0080214f <rsttst>:
void rsttst()
{
  80214f:	55                   	push   %ebp
  802150:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  802152:	6a 00                	push   $0x0
  802154:	6a 00                	push   $0x0
  802156:	6a 00                	push   $0x0
  802158:	6a 00                	push   $0x0
  80215a:	6a 00                	push   $0x0
  80215c:	6a 28                	push   $0x28
  80215e:	e8 43 fb ff ff       	call   801ca6 <syscall>
  802163:	83 c4 18             	add    $0x18,%esp
	return ;
  802166:	90                   	nop
}
  802167:	c9                   	leave  
  802168:	c3                   	ret    

00802169 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  802169:	55                   	push   %ebp
  80216a:	89 e5                	mov    %esp,%ebp
  80216c:	83 ec 04             	sub    $0x4,%esp
  80216f:	8b 45 14             	mov    0x14(%ebp),%eax
  802172:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  802175:	8b 55 18             	mov    0x18(%ebp),%edx
  802178:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80217c:	52                   	push   %edx
  80217d:	50                   	push   %eax
  80217e:	ff 75 10             	pushl  0x10(%ebp)
  802181:	ff 75 0c             	pushl  0xc(%ebp)
  802184:	ff 75 08             	pushl  0x8(%ebp)
  802187:	6a 27                	push   $0x27
  802189:	e8 18 fb ff ff       	call   801ca6 <syscall>
  80218e:	83 c4 18             	add    $0x18,%esp
	return ;
  802191:	90                   	nop
}
  802192:	c9                   	leave  
  802193:	c3                   	ret    

00802194 <chktst>:
void chktst(uint32 n)
{
  802194:	55                   	push   %ebp
  802195:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  802197:	6a 00                	push   $0x0
  802199:	6a 00                	push   $0x0
  80219b:	6a 00                	push   $0x0
  80219d:	6a 00                	push   $0x0
  80219f:	ff 75 08             	pushl  0x8(%ebp)
  8021a2:	6a 29                	push   $0x29
  8021a4:	e8 fd fa ff ff       	call   801ca6 <syscall>
  8021a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8021ac:	90                   	nop
}
  8021ad:	c9                   	leave  
  8021ae:	c3                   	ret    

008021af <inctst>:

void inctst()
{
  8021af:	55                   	push   %ebp
  8021b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8021b2:	6a 00                	push   $0x0
  8021b4:	6a 00                	push   $0x0
  8021b6:	6a 00                	push   $0x0
  8021b8:	6a 00                	push   $0x0
  8021ba:	6a 00                	push   $0x0
  8021bc:	6a 2a                	push   $0x2a
  8021be:	e8 e3 fa ff ff       	call   801ca6 <syscall>
  8021c3:	83 c4 18             	add    $0x18,%esp
	return ;
  8021c6:	90                   	nop
}
  8021c7:	c9                   	leave  
  8021c8:	c3                   	ret    

008021c9 <gettst>:
uint32 gettst()
{
  8021c9:	55                   	push   %ebp
  8021ca:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8021cc:	6a 00                	push   $0x0
  8021ce:	6a 00                	push   $0x0
  8021d0:	6a 00                	push   $0x0
  8021d2:	6a 00                	push   $0x0
  8021d4:	6a 00                	push   $0x0
  8021d6:	6a 2b                	push   $0x2b
  8021d8:	e8 c9 fa ff ff       	call   801ca6 <syscall>
  8021dd:	83 c4 18             	add    $0x18,%esp
}
  8021e0:	c9                   	leave  
  8021e1:	c3                   	ret    

008021e2 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8021e2:	55                   	push   %ebp
  8021e3:	89 e5                	mov    %esp,%ebp
  8021e5:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8021e8:	6a 00                	push   $0x0
  8021ea:	6a 00                	push   $0x0
  8021ec:	6a 00                	push   $0x0
  8021ee:	6a 00                	push   $0x0
  8021f0:	6a 00                	push   $0x0
  8021f2:	6a 2c                	push   $0x2c
  8021f4:	e8 ad fa ff ff       	call   801ca6 <syscall>
  8021f9:	83 c4 18             	add    $0x18,%esp
  8021fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8021ff:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  802203:	75 07                	jne    80220c <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  802205:	b8 01 00 00 00       	mov    $0x1,%eax
  80220a:	eb 05                	jmp    802211 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  80220c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802211:	c9                   	leave  
  802212:	c3                   	ret    

00802213 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  802213:	55                   	push   %ebp
  802214:	89 e5                	mov    %esp,%ebp
  802216:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  802219:	6a 00                	push   $0x0
  80221b:	6a 00                	push   $0x0
  80221d:	6a 00                	push   $0x0
  80221f:	6a 00                	push   $0x0
  802221:	6a 00                	push   $0x0
  802223:	6a 2c                	push   $0x2c
  802225:	e8 7c fa ff ff       	call   801ca6 <syscall>
  80222a:	83 c4 18             	add    $0x18,%esp
  80222d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  802230:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  802234:	75 07                	jne    80223d <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  802236:	b8 01 00 00 00       	mov    $0x1,%eax
  80223b:	eb 05                	jmp    802242 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  80223d:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802242:	c9                   	leave  
  802243:	c3                   	ret    

00802244 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  802244:	55                   	push   %ebp
  802245:	89 e5                	mov    %esp,%ebp
  802247:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80224a:	6a 00                	push   $0x0
  80224c:	6a 00                	push   $0x0
  80224e:	6a 00                	push   $0x0
  802250:	6a 00                	push   $0x0
  802252:	6a 00                	push   $0x0
  802254:	6a 2c                	push   $0x2c
  802256:	e8 4b fa ff ff       	call   801ca6 <syscall>
  80225b:	83 c4 18             	add    $0x18,%esp
  80225e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  802261:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  802265:	75 07                	jne    80226e <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  802267:	b8 01 00 00 00       	mov    $0x1,%eax
  80226c:	eb 05                	jmp    802273 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80226e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  802273:	c9                   	leave  
  802274:	c3                   	ret    

00802275 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  802275:	55                   	push   %ebp
  802276:	89 e5                	mov    %esp,%ebp
  802278:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  80227b:	6a 00                	push   $0x0
  80227d:	6a 00                	push   $0x0
  80227f:	6a 00                	push   $0x0
  802281:	6a 00                	push   $0x0
  802283:	6a 00                	push   $0x0
  802285:	6a 2c                	push   $0x2c
  802287:	e8 1a fa ff ff       	call   801ca6 <syscall>
  80228c:	83 c4 18             	add    $0x18,%esp
  80228f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  802292:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  802296:	75 07                	jne    80229f <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  802298:	b8 01 00 00 00       	mov    $0x1,%eax
  80229d:	eb 05                	jmp    8022a4 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80229f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8022a4:	c9                   	leave  
  8022a5:	c3                   	ret    

008022a6 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8022a6:	55                   	push   %ebp
  8022a7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8022a9:	6a 00                	push   $0x0
  8022ab:	6a 00                	push   $0x0
  8022ad:	6a 00                	push   $0x0
  8022af:	6a 00                	push   $0x0
  8022b1:	ff 75 08             	pushl  0x8(%ebp)
  8022b4:	6a 2d                	push   $0x2d
  8022b6:	e8 eb f9 ff ff       	call   801ca6 <syscall>
  8022bb:	83 c4 18             	add    $0x18,%esp
	return ;
  8022be:	90                   	nop
}
  8022bf:	c9                   	leave  
  8022c0:	c3                   	ret    

008022c1 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8022c1:	55                   	push   %ebp
  8022c2:	89 e5                	mov    %esp,%ebp
  8022c4:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8022c5:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8022c8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8022cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8022d1:	6a 00                	push   $0x0
  8022d3:	53                   	push   %ebx
  8022d4:	51                   	push   %ecx
  8022d5:	52                   	push   %edx
  8022d6:	50                   	push   %eax
  8022d7:	6a 2e                	push   $0x2e
  8022d9:	e8 c8 f9 ff ff       	call   801ca6 <syscall>
  8022de:	83 c4 18             	add    $0x18,%esp
}
  8022e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8022e4:	c9                   	leave  
  8022e5:	c3                   	ret    

008022e6 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8022e6:	55                   	push   %ebp
  8022e7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8022e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8022ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8022ef:	6a 00                	push   $0x0
  8022f1:	6a 00                	push   $0x0
  8022f3:	6a 00                	push   $0x0
  8022f5:	52                   	push   %edx
  8022f6:	50                   	push   %eax
  8022f7:	6a 2f                	push   $0x2f
  8022f9:	e8 a8 f9 ff ff       	call   801ca6 <syscall>
  8022fe:	83 c4 18             	add    $0x18,%esp
}
  802301:	c9                   	leave  
  802302:	c3                   	ret    

00802303 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  802303:	55                   	push   %ebp
  802304:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  802306:	6a 00                	push   $0x0
  802308:	6a 00                	push   $0x0
  80230a:	6a 00                	push   $0x0
  80230c:	ff 75 0c             	pushl  0xc(%ebp)
  80230f:	ff 75 08             	pushl  0x8(%ebp)
  802312:	6a 30                	push   $0x30
  802314:	e8 8d f9 ff ff       	call   801ca6 <syscall>
  802319:	83 c4 18             	add    $0x18,%esp
	return ;
  80231c:	90                   	nop
}
  80231d:	c9                   	leave  
  80231e:	c3                   	ret    
  80231f:	90                   	nop

00802320 <__udivdi3>:
  802320:	55                   	push   %ebp
  802321:	57                   	push   %edi
  802322:	56                   	push   %esi
  802323:	53                   	push   %ebx
  802324:	83 ec 1c             	sub    $0x1c,%esp
  802327:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  80232b:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  80232f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802333:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  802337:	89 ca                	mov    %ecx,%edx
  802339:	89 f8                	mov    %edi,%eax
  80233b:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  80233f:	85 f6                	test   %esi,%esi
  802341:	75 2d                	jne    802370 <__udivdi3+0x50>
  802343:	39 cf                	cmp    %ecx,%edi
  802345:	77 65                	ja     8023ac <__udivdi3+0x8c>
  802347:	89 fd                	mov    %edi,%ebp
  802349:	85 ff                	test   %edi,%edi
  80234b:	75 0b                	jne    802358 <__udivdi3+0x38>
  80234d:	b8 01 00 00 00       	mov    $0x1,%eax
  802352:	31 d2                	xor    %edx,%edx
  802354:	f7 f7                	div    %edi
  802356:	89 c5                	mov    %eax,%ebp
  802358:	31 d2                	xor    %edx,%edx
  80235a:	89 c8                	mov    %ecx,%eax
  80235c:	f7 f5                	div    %ebp
  80235e:	89 c1                	mov    %eax,%ecx
  802360:	89 d8                	mov    %ebx,%eax
  802362:	f7 f5                	div    %ebp
  802364:	89 cf                	mov    %ecx,%edi
  802366:	89 fa                	mov    %edi,%edx
  802368:	83 c4 1c             	add    $0x1c,%esp
  80236b:	5b                   	pop    %ebx
  80236c:	5e                   	pop    %esi
  80236d:	5f                   	pop    %edi
  80236e:	5d                   	pop    %ebp
  80236f:	c3                   	ret    
  802370:	39 ce                	cmp    %ecx,%esi
  802372:	77 28                	ja     80239c <__udivdi3+0x7c>
  802374:	0f bd fe             	bsr    %esi,%edi
  802377:	83 f7 1f             	xor    $0x1f,%edi
  80237a:	75 40                	jne    8023bc <__udivdi3+0x9c>
  80237c:	39 ce                	cmp    %ecx,%esi
  80237e:	72 0a                	jb     80238a <__udivdi3+0x6a>
  802380:	3b 44 24 08          	cmp    0x8(%esp),%eax
  802384:	0f 87 9e 00 00 00    	ja     802428 <__udivdi3+0x108>
  80238a:	b8 01 00 00 00       	mov    $0x1,%eax
  80238f:	89 fa                	mov    %edi,%edx
  802391:	83 c4 1c             	add    $0x1c,%esp
  802394:	5b                   	pop    %ebx
  802395:	5e                   	pop    %esi
  802396:	5f                   	pop    %edi
  802397:	5d                   	pop    %ebp
  802398:	c3                   	ret    
  802399:	8d 76 00             	lea    0x0(%esi),%esi
  80239c:	31 ff                	xor    %edi,%edi
  80239e:	31 c0                	xor    %eax,%eax
  8023a0:	89 fa                	mov    %edi,%edx
  8023a2:	83 c4 1c             	add    $0x1c,%esp
  8023a5:	5b                   	pop    %ebx
  8023a6:	5e                   	pop    %esi
  8023a7:	5f                   	pop    %edi
  8023a8:	5d                   	pop    %ebp
  8023a9:	c3                   	ret    
  8023aa:	66 90                	xchg   %ax,%ax
  8023ac:	89 d8                	mov    %ebx,%eax
  8023ae:	f7 f7                	div    %edi
  8023b0:	31 ff                	xor    %edi,%edi
  8023b2:	89 fa                	mov    %edi,%edx
  8023b4:	83 c4 1c             	add    $0x1c,%esp
  8023b7:	5b                   	pop    %ebx
  8023b8:	5e                   	pop    %esi
  8023b9:	5f                   	pop    %edi
  8023ba:	5d                   	pop    %ebp
  8023bb:	c3                   	ret    
  8023bc:	bd 20 00 00 00       	mov    $0x20,%ebp
  8023c1:	89 eb                	mov    %ebp,%ebx
  8023c3:	29 fb                	sub    %edi,%ebx
  8023c5:	89 f9                	mov    %edi,%ecx
  8023c7:	d3 e6                	shl    %cl,%esi
  8023c9:	89 c5                	mov    %eax,%ebp
  8023cb:	88 d9                	mov    %bl,%cl
  8023cd:	d3 ed                	shr    %cl,%ebp
  8023cf:	89 e9                	mov    %ebp,%ecx
  8023d1:	09 f1                	or     %esi,%ecx
  8023d3:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  8023d7:	89 f9                	mov    %edi,%ecx
  8023d9:	d3 e0                	shl    %cl,%eax
  8023db:	89 c5                	mov    %eax,%ebp
  8023dd:	89 d6                	mov    %edx,%esi
  8023df:	88 d9                	mov    %bl,%cl
  8023e1:	d3 ee                	shr    %cl,%esi
  8023e3:	89 f9                	mov    %edi,%ecx
  8023e5:	d3 e2                	shl    %cl,%edx
  8023e7:	8b 44 24 08          	mov    0x8(%esp),%eax
  8023eb:	88 d9                	mov    %bl,%cl
  8023ed:	d3 e8                	shr    %cl,%eax
  8023ef:	09 c2                	or     %eax,%edx
  8023f1:	89 d0                	mov    %edx,%eax
  8023f3:	89 f2                	mov    %esi,%edx
  8023f5:	f7 74 24 0c          	divl   0xc(%esp)
  8023f9:	89 d6                	mov    %edx,%esi
  8023fb:	89 c3                	mov    %eax,%ebx
  8023fd:	f7 e5                	mul    %ebp
  8023ff:	39 d6                	cmp    %edx,%esi
  802401:	72 19                	jb     80241c <__udivdi3+0xfc>
  802403:	74 0b                	je     802410 <__udivdi3+0xf0>
  802405:	89 d8                	mov    %ebx,%eax
  802407:	31 ff                	xor    %edi,%edi
  802409:	e9 58 ff ff ff       	jmp    802366 <__udivdi3+0x46>
  80240e:	66 90                	xchg   %ax,%ax
  802410:	8b 54 24 08          	mov    0x8(%esp),%edx
  802414:	89 f9                	mov    %edi,%ecx
  802416:	d3 e2                	shl    %cl,%edx
  802418:	39 c2                	cmp    %eax,%edx
  80241a:	73 e9                	jae    802405 <__udivdi3+0xe5>
  80241c:	8d 43 ff             	lea    -0x1(%ebx),%eax
  80241f:	31 ff                	xor    %edi,%edi
  802421:	e9 40 ff ff ff       	jmp    802366 <__udivdi3+0x46>
  802426:	66 90                	xchg   %ax,%ax
  802428:	31 c0                	xor    %eax,%eax
  80242a:	e9 37 ff ff ff       	jmp    802366 <__udivdi3+0x46>
  80242f:	90                   	nop

00802430 <__umoddi3>:
  802430:	55                   	push   %ebp
  802431:	57                   	push   %edi
  802432:	56                   	push   %esi
  802433:	53                   	push   %ebx
  802434:	83 ec 1c             	sub    $0x1c,%esp
  802437:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  80243b:	8b 74 24 34          	mov    0x34(%esp),%esi
  80243f:	8b 7c 24 38          	mov    0x38(%esp),%edi
  802443:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  802447:	89 44 24 0c          	mov    %eax,0xc(%esp)
  80244b:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  80244f:	89 f3                	mov    %esi,%ebx
  802451:	89 fa                	mov    %edi,%edx
  802453:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802457:	89 34 24             	mov    %esi,(%esp)
  80245a:	85 c0                	test   %eax,%eax
  80245c:	75 1a                	jne    802478 <__umoddi3+0x48>
  80245e:	39 f7                	cmp    %esi,%edi
  802460:	0f 86 a2 00 00 00    	jbe    802508 <__umoddi3+0xd8>
  802466:	89 c8                	mov    %ecx,%eax
  802468:	89 f2                	mov    %esi,%edx
  80246a:	f7 f7                	div    %edi
  80246c:	89 d0                	mov    %edx,%eax
  80246e:	31 d2                	xor    %edx,%edx
  802470:	83 c4 1c             	add    $0x1c,%esp
  802473:	5b                   	pop    %ebx
  802474:	5e                   	pop    %esi
  802475:	5f                   	pop    %edi
  802476:	5d                   	pop    %ebp
  802477:	c3                   	ret    
  802478:	39 f0                	cmp    %esi,%eax
  80247a:	0f 87 ac 00 00 00    	ja     80252c <__umoddi3+0xfc>
  802480:	0f bd e8             	bsr    %eax,%ebp
  802483:	83 f5 1f             	xor    $0x1f,%ebp
  802486:	0f 84 ac 00 00 00    	je     802538 <__umoddi3+0x108>
  80248c:	bf 20 00 00 00       	mov    $0x20,%edi
  802491:	29 ef                	sub    %ebp,%edi
  802493:	89 fe                	mov    %edi,%esi
  802495:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  802499:	89 e9                	mov    %ebp,%ecx
  80249b:	d3 e0                	shl    %cl,%eax
  80249d:	89 d7                	mov    %edx,%edi
  80249f:	89 f1                	mov    %esi,%ecx
  8024a1:	d3 ef                	shr    %cl,%edi
  8024a3:	09 c7                	or     %eax,%edi
  8024a5:	89 e9                	mov    %ebp,%ecx
  8024a7:	d3 e2                	shl    %cl,%edx
  8024a9:	89 14 24             	mov    %edx,(%esp)
  8024ac:	89 d8                	mov    %ebx,%eax
  8024ae:	d3 e0                	shl    %cl,%eax
  8024b0:	89 c2                	mov    %eax,%edx
  8024b2:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024b6:	d3 e0                	shl    %cl,%eax
  8024b8:	89 44 24 04          	mov    %eax,0x4(%esp)
  8024bc:	8b 44 24 08          	mov    0x8(%esp),%eax
  8024c0:	89 f1                	mov    %esi,%ecx
  8024c2:	d3 e8                	shr    %cl,%eax
  8024c4:	09 d0                	or     %edx,%eax
  8024c6:	d3 eb                	shr    %cl,%ebx
  8024c8:	89 da                	mov    %ebx,%edx
  8024ca:	f7 f7                	div    %edi
  8024cc:	89 d3                	mov    %edx,%ebx
  8024ce:	f7 24 24             	mull   (%esp)
  8024d1:	89 c6                	mov    %eax,%esi
  8024d3:	89 d1                	mov    %edx,%ecx
  8024d5:	39 d3                	cmp    %edx,%ebx
  8024d7:	0f 82 87 00 00 00    	jb     802564 <__umoddi3+0x134>
  8024dd:	0f 84 91 00 00 00    	je     802574 <__umoddi3+0x144>
  8024e3:	8b 54 24 04          	mov    0x4(%esp),%edx
  8024e7:	29 f2                	sub    %esi,%edx
  8024e9:	19 cb                	sbb    %ecx,%ebx
  8024eb:	89 d8                	mov    %ebx,%eax
  8024ed:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  8024f1:	d3 e0                	shl    %cl,%eax
  8024f3:	89 e9                	mov    %ebp,%ecx
  8024f5:	d3 ea                	shr    %cl,%edx
  8024f7:	09 d0                	or     %edx,%eax
  8024f9:	89 e9                	mov    %ebp,%ecx
  8024fb:	d3 eb                	shr    %cl,%ebx
  8024fd:	89 da                	mov    %ebx,%edx
  8024ff:	83 c4 1c             	add    $0x1c,%esp
  802502:	5b                   	pop    %ebx
  802503:	5e                   	pop    %esi
  802504:	5f                   	pop    %edi
  802505:	5d                   	pop    %ebp
  802506:	c3                   	ret    
  802507:	90                   	nop
  802508:	89 fd                	mov    %edi,%ebp
  80250a:	85 ff                	test   %edi,%edi
  80250c:	75 0b                	jne    802519 <__umoddi3+0xe9>
  80250e:	b8 01 00 00 00       	mov    $0x1,%eax
  802513:	31 d2                	xor    %edx,%edx
  802515:	f7 f7                	div    %edi
  802517:	89 c5                	mov    %eax,%ebp
  802519:	89 f0                	mov    %esi,%eax
  80251b:	31 d2                	xor    %edx,%edx
  80251d:	f7 f5                	div    %ebp
  80251f:	89 c8                	mov    %ecx,%eax
  802521:	f7 f5                	div    %ebp
  802523:	89 d0                	mov    %edx,%eax
  802525:	e9 44 ff ff ff       	jmp    80246e <__umoddi3+0x3e>
  80252a:	66 90                	xchg   %ax,%ax
  80252c:	89 c8                	mov    %ecx,%eax
  80252e:	89 f2                	mov    %esi,%edx
  802530:	83 c4 1c             	add    $0x1c,%esp
  802533:	5b                   	pop    %ebx
  802534:	5e                   	pop    %esi
  802535:	5f                   	pop    %edi
  802536:	5d                   	pop    %ebp
  802537:	c3                   	ret    
  802538:	3b 04 24             	cmp    (%esp),%eax
  80253b:	72 06                	jb     802543 <__umoddi3+0x113>
  80253d:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  802541:	77 0f                	ja     802552 <__umoddi3+0x122>
  802543:	89 f2                	mov    %esi,%edx
  802545:	29 f9                	sub    %edi,%ecx
  802547:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  80254b:	89 14 24             	mov    %edx,(%esp)
  80254e:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  802552:	8b 44 24 04          	mov    0x4(%esp),%eax
  802556:	8b 14 24             	mov    (%esp),%edx
  802559:	83 c4 1c             	add    $0x1c,%esp
  80255c:	5b                   	pop    %ebx
  80255d:	5e                   	pop    %esi
  80255e:	5f                   	pop    %edi
  80255f:	5d                   	pop    %ebp
  802560:	c3                   	ret    
  802561:	8d 76 00             	lea    0x0(%esi),%esi
  802564:	2b 04 24             	sub    (%esp),%eax
  802567:	19 fa                	sbb    %edi,%edx
  802569:	89 d1                	mov    %edx,%ecx
  80256b:	89 c6                	mov    %eax,%esi
  80256d:	e9 71 ff ff ff       	jmp    8024e3 <__umoddi3+0xb3>
  802572:	66 90                	xchg   %ax,%ax
  802574:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802578:	72 ea                	jb     802564 <__umoddi3+0x134>
  80257a:	89 d9                	mov    %ebx,%ecx
  80257c:	e9 62 ff ff ff       	jmp    8024e3 <__umoddi3+0xb3>
