
obj/user/tst_page_replacement_lru:     file format elf32-i386


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
  800031:	e8 fc 02 00 00       	call   800332 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
char arr[PAGE_SIZE*12];
char* ptr = (char* )0x0801000 ;
char* ptr2 = (char* )0x0804000 ;

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	83 ec 6c             	sub    $0x6c,%esp
//	cprintf("envID = %d\n",envID);


	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800041:	a1 20 30 80 00       	mov    0x803020,%eax
  800046:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80004c:	8b 00                	mov    (%eax),%eax
  80004e:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800051:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800054:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800059:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005e:	74 14                	je     800074 <_main+0x3c>
  800060:	83 ec 04             	sub    $0x4,%esp
  800063:	68 80 1d 80 00       	push   $0x801d80
  800068:	6a 13                	push   $0x13
  80006a:	68 c4 1d 80 00       	push   $0x801dc4
  80006f:	e8 da 03 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800074:	a1 20 30 80 00       	mov    0x803020,%eax
  800079:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80007f:	83 c0 18             	add    $0x18,%eax
  800082:	8b 00                	mov    (%eax),%eax
  800084:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800087:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80008a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008f:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800094:	74 14                	je     8000aa <_main+0x72>
  800096:	83 ec 04             	sub    $0x4,%esp
  800099:	68 80 1d 80 00       	push   $0x801d80
  80009e:	6a 14                	push   $0x14
  8000a0:	68 c4 1d 80 00       	push   $0x801dc4
  8000a5:	e8 a4 03 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000aa:	a1 20 30 80 00       	mov    0x803020,%eax
  8000af:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000b5:	83 c0 30             	add    $0x30,%eax
  8000b8:	8b 00                	mov    (%eax),%eax
  8000ba:	89 45 d8             	mov    %eax,-0x28(%ebp)
  8000bd:	8b 45 d8             	mov    -0x28(%ebp),%eax
  8000c0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c5:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000ca:	74 14                	je     8000e0 <_main+0xa8>
  8000cc:	83 ec 04             	sub    $0x4,%esp
  8000cf:	68 80 1d 80 00       	push   $0x801d80
  8000d4:	6a 15                	push   $0x15
  8000d6:	68 c4 1d 80 00       	push   $0x801dc4
  8000db:	e8 6e 03 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e0:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e5:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000eb:	83 c0 48             	add    $0x48,%eax
  8000ee:	8b 00                	mov    (%eax),%eax
  8000f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000f3:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000f6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fb:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800100:	74 14                	je     800116 <_main+0xde>
  800102:	83 ec 04             	sub    $0x4,%esp
  800105:	68 80 1d 80 00       	push   $0x801d80
  80010a:	6a 16                	push   $0x16
  80010c:	68 c4 1d 80 00       	push   $0x801dc4
  800111:	e8 38 03 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800116:	a1 20 30 80 00       	mov    0x803020,%eax
  80011b:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800121:	83 c0 60             	add    $0x60,%eax
  800124:	8b 00                	mov    (%eax),%eax
  800126:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800129:	8b 45 d0             	mov    -0x30(%ebp),%eax
  80012c:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800131:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800136:	74 14                	je     80014c <_main+0x114>
  800138:	83 ec 04             	sub    $0x4,%esp
  80013b:	68 80 1d 80 00       	push   $0x801d80
  800140:	6a 17                	push   $0x17
  800142:	68 c4 1d 80 00       	push   $0x801dc4
  800147:	e8 02 03 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014c:	a1 20 30 80 00       	mov    0x803020,%eax
  800151:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800157:	83 c0 78             	add    $0x78,%eax
  80015a:	8b 00                	mov    (%eax),%eax
  80015c:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80015f:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800162:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800167:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016c:	74 14                	je     800182 <_main+0x14a>
  80016e:	83 ec 04             	sub    $0x4,%esp
  800171:	68 80 1d 80 00       	push   $0x801d80
  800176:	6a 18                	push   $0x18
  800178:	68 c4 1d 80 00       	push   $0x801dc4
  80017d:	e8 cc 02 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800182:	a1 20 30 80 00       	mov    0x803020,%eax
  800187:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80018d:	05 90 00 00 00       	add    $0x90,%eax
  800192:	8b 00                	mov    (%eax),%eax
  800194:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800197:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80019a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019f:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a4:	74 14                	je     8001ba <_main+0x182>
  8001a6:	83 ec 04             	sub    $0x4,%esp
  8001a9:	68 80 1d 80 00       	push   $0x801d80
  8001ae:	6a 19                	push   $0x19
  8001b0:	68 c4 1d 80 00       	push   $0x801dc4
  8001b5:	e8 94 02 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bf:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8001c5:	05 a8 00 00 00       	add    $0xa8,%eax
  8001ca:	8b 00                	mov    (%eax),%eax
  8001cc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  8001cf:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  8001d2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d7:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001dc:	74 14                	je     8001f2 <_main+0x1ba>
  8001de:	83 ec 04             	sub    $0x4,%esp
  8001e1:	68 80 1d 80 00       	push   $0x801d80
  8001e6:	6a 1a                	push   $0x1a
  8001e8:	68 c4 1d 80 00       	push   $0x801dc4
  8001ed:	e8 5c 02 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f7:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8001fd:	05 c0 00 00 00       	add    $0xc0,%eax
  800202:	8b 00                	mov    (%eax),%eax
  800204:	89 45 c0             	mov    %eax,-0x40(%ebp)
  800207:	8b 45 c0             	mov    -0x40(%ebp),%eax
  80020a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020f:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800214:	74 14                	je     80022a <_main+0x1f2>
  800216:	83 ec 04             	sub    $0x4,%esp
  800219:	68 80 1d 80 00       	push   $0x801d80
  80021e:	6a 1b                	push   $0x1b
  800220:	68 c4 1d 80 00       	push   $0x801dc4
  800225:	e8 24 02 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80022a:	a1 20 30 80 00       	mov    0x803020,%eax
  80022f:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800235:	05 d8 00 00 00       	add    $0xd8,%eax
  80023a:	8b 00                	mov    (%eax),%eax
  80023c:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80023f:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800242:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800247:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80024c:	74 14                	je     800262 <_main+0x22a>
  80024e:	83 ec 04             	sub    $0x4,%esp
  800251:	68 80 1d 80 00       	push   $0x801d80
  800256:	6a 1c                	push   $0x1c
  800258:	68 c4 1d 80 00       	push   $0x801dc4
  80025d:	e8 ec 01 00 00       	call   80044e <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800262:	a1 20 30 80 00       	mov    0x803020,%eax
  800267:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80026d:	05 f0 00 00 00       	add    $0xf0,%eax
  800272:	8b 00                	mov    (%eax),%eax
  800274:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800277:	8b 45 b8             	mov    -0x48(%ebp),%eax
  80027a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027f:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800284:	74 14                	je     80029a <_main+0x262>
  800286:	83 ec 04             	sub    $0x4,%esp
  800289:	68 80 1d 80 00       	push   $0x801d80
  80028e:	6a 1d                	push   $0x1d
  800290:	68 c4 1d 80 00       	push   $0x801dc4
  800295:	e8 b4 01 00 00       	call   80044e <_panic>
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
	}

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  80029a:	a0 3f e0 80 00       	mov    0x80e03f,%al
  80029f:	88 45 b7             	mov    %al,-0x49(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002a2:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002a7:	88 45 b6             	mov    %al,-0x4a(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002aa:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  8002b1:	eb 37                	jmp    8002ea <_main+0x2b2>
	{
		arr[i] = -1 ;
  8002b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8002b6:	05 40 30 80 00       	add    $0x803040,%eax
  8002bb:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002be:	a1 04 30 80 00       	mov    0x803004,%eax
  8002c3:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002c9:	8a 12                	mov    (%edx),%dl
  8002cb:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002cd:	a1 00 30 80 00       	mov    0x803000,%eax
  8002d2:	40                   	inc    %eax
  8002d3:	a3 00 30 80 00       	mov    %eax,0x803000
  8002d8:	a1 04 30 80 00       	mov    0x803004,%eax
  8002dd:	40                   	inc    %eax
  8002de:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002e3:	81 45 e4 00 08 00 00 	addl   $0x800,-0x1c(%ebp)
  8002ea:	81 7d e4 ff 9f 00 00 	cmpl   $0x9fff,-0x1c(%ebp)
  8002f1:	7e c0                	jle    8002b3 <_main+0x27b>
		ptr++ ; ptr2++ ;
	}

	//===================

	uint32 expectedPages[11] = {0x809000,0x80a000,0x804000,0x80b000,0x80c000,0x807000,0x800000,0x801000,0x808000,0x803000,0xeebfd000};
  8002f3:	8d 45 88             	lea    -0x78(%ebp),%eax
  8002f6:	bb 40 1e 80 00       	mov    $0x801e40,%ebx
  8002fb:	ba 0b 00 00 00       	mov    $0xb,%edx
  800300:	89 c7                	mov    %eax,%edi
  800302:	89 de                	mov    %ebx,%esi
  800304:	89 d1                	mov    %edx,%ecx
  800306:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	//cprintf("Checking PAGE LRU algorithm... \n");
	{
		CheckWSWithoutLastIndex(expectedPages, 11);
  800308:	83 ec 08             	sub    $0x8,%esp
  80030b:	6a 0b                	push   $0xb
  80030d:	8d 45 88             	lea    -0x78(%ebp),%eax
  800310:	50                   	push   %eax
  800311:	e8 aa 01 00 00       	call   8004c0 <CheckWSWithoutLastIndex>
  800316:	83 c4 10             	add    $0x10,%esp
		/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
		//if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");

	}

	cprintf("Congratulations!! test PAGE replacement [LRU Alg.] is completed successfully.\n");
  800319:	83 ec 0c             	sub    $0xc,%esp
  80031c:	68 e4 1d 80 00       	push   $0x801de4
  800321:	e8 dc 03 00 00       	call   800702 <cprintf>
  800326:	83 c4 10             	add    $0x10,%esp
	return;
  800329:	90                   	nop
}
  80032a:	8d 65 f4             	lea    -0xc(%ebp),%esp
  80032d:	5b                   	pop    %ebx
  80032e:	5e                   	pop    %esi
  80032f:	5f                   	pop    %edi
  800330:	5d                   	pop    %ebp
  800331:	c3                   	ret    

00800332 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800332:	55                   	push   %ebp
  800333:	89 e5                	mov    %esp,%ebp
  800335:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  800338:	e8 f0 11 00 00       	call   80152d <sys_getenvindex>
  80033d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800340:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800343:	89 d0                	mov    %edx,%eax
  800345:	01 c0                	add    %eax,%eax
  800347:	01 d0                	add    %edx,%eax
  800349:	c1 e0 04             	shl    $0x4,%eax
  80034c:	29 d0                	sub    %edx,%eax
  80034e:	c1 e0 03             	shl    $0x3,%eax
  800351:	01 d0                	add    %edx,%eax
  800353:	c1 e0 02             	shl    $0x2,%eax
  800356:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80035b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800360:	a1 20 30 80 00       	mov    0x803020,%eax
  800365:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80036b:	84 c0                	test   %al,%al
  80036d:	74 0f                	je     80037e <libmain+0x4c>
		binaryname = myEnv->prog_name;
  80036f:	a1 20 30 80 00       	mov    0x803020,%eax
  800374:	05 5c 05 00 00       	add    $0x55c,%eax
  800379:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80037e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800382:	7e 0a                	jle    80038e <libmain+0x5c>
		binaryname = argv[0];
  800384:	8b 45 0c             	mov    0xc(%ebp),%eax
  800387:	8b 00                	mov    (%eax),%eax
  800389:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80038e:	83 ec 08             	sub    $0x8,%esp
  800391:	ff 75 0c             	pushl  0xc(%ebp)
  800394:	ff 75 08             	pushl  0x8(%ebp)
  800397:	e8 9c fc ff ff       	call   800038 <_main>
  80039c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80039f:	e8 24 13 00 00       	call   8016c8 <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003a4:	83 ec 0c             	sub    $0xc,%esp
  8003a7:	68 84 1e 80 00       	push   $0x801e84
  8003ac:	e8 51 03 00 00       	call   800702 <cprintf>
  8003b1:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8003b4:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b9:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8003bf:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c4:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8003ca:	83 ec 04             	sub    $0x4,%esp
  8003cd:	52                   	push   %edx
  8003ce:	50                   	push   %eax
  8003cf:	68 ac 1e 80 00       	push   $0x801eac
  8003d4:	e8 29 03 00 00       	call   800702 <cprintf>
  8003d9:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8003dc:	a1 20 30 80 00       	mov    0x803020,%eax
  8003e1:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8003e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ec:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8003f2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003f7:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8003fd:	51                   	push   %ecx
  8003fe:	52                   	push   %edx
  8003ff:	50                   	push   %eax
  800400:	68 d4 1e 80 00       	push   $0x801ed4
  800405:	e8 f8 02 00 00       	call   800702 <cprintf>
  80040a:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  80040d:	83 ec 0c             	sub    $0xc,%esp
  800410:	68 84 1e 80 00       	push   $0x801e84
  800415:	e8 e8 02 00 00       	call   800702 <cprintf>
  80041a:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  80041d:	e8 c0 12 00 00       	call   8016e2 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800422:	e8 19 00 00 00       	call   800440 <exit>
}
  800427:	90                   	nop
  800428:	c9                   	leave  
  800429:	c3                   	ret    

0080042a <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80042a:	55                   	push   %ebp
  80042b:	89 e5                	mov    %esp,%ebp
  80042d:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800430:	83 ec 0c             	sub    $0xc,%esp
  800433:	6a 00                	push   $0x0
  800435:	e8 bf 10 00 00       	call   8014f9 <sys_env_destroy>
  80043a:	83 c4 10             	add    $0x10,%esp
}
  80043d:	90                   	nop
  80043e:	c9                   	leave  
  80043f:	c3                   	ret    

00800440 <exit>:

void
exit(void)
{
  800440:	55                   	push   %ebp
  800441:	89 e5                	mov    %esp,%ebp
  800443:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800446:	e8 14 11 00 00       	call   80155f <sys_env_exit>
}
  80044b:	90                   	nop
  80044c:	c9                   	leave  
  80044d:	c3                   	ret    

0080044e <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80044e:	55                   	push   %ebp
  80044f:	89 e5                	mov    %esp,%ebp
  800451:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800454:	8d 45 10             	lea    0x10(%ebp),%eax
  800457:	83 c0 04             	add    $0x4,%eax
  80045a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80045d:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800462:	85 c0                	test   %eax,%eax
  800464:	74 16                	je     80047c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800466:	a1 18 f1 80 00       	mov    0x80f118,%eax
  80046b:	83 ec 08             	sub    $0x8,%esp
  80046e:	50                   	push   %eax
  80046f:	68 2c 1f 80 00       	push   $0x801f2c
  800474:	e8 89 02 00 00       	call   800702 <cprintf>
  800479:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80047c:	a1 08 30 80 00       	mov    0x803008,%eax
  800481:	ff 75 0c             	pushl  0xc(%ebp)
  800484:	ff 75 08             	pushl  0x8(%ebp)
  800487:	50                   	push   %eax
  800488:	68 31 1f 80 00       	push   $0x801f31
  80048d:	e8 70 02 00 00       	call   800702 <cprintf>
  800492:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800495:	8b 45 10             	mov    0x10(%ebp),%eax
  800498:	83 ec 08             	sub    $0x8,%esp
  80049b:	ff 75 f4             	pushl  -0xc(%ebp)
  80049e:	50                   	push   %eax
  80049f:	e8 f3 01 00 00       	call   800697 <vcprintf>
  8004a4:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004a7:	83 ec 08             	sub    $0x8,%esp
  8004aa:	6a 00                	push   $0x0
  8004ac:	68 4d 1f 80 00       	push   $0x801f4d
  8004b1:	e8 e1 01 00 00       	call   800697 <vcprintf>
  8004b6:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8004b9:	e8 82 ff ff ff       	call   800440 <exit>

	// should not return here
	while (1) ;
  8004be:	eb fe                	jmp    8004be <_panic+0x70>

008004c0 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8004c0:	55                   	push   %ebp
  8004c1:	89 e5                	mov    %esp,%ebp
  8004c3:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8004c6:	a1 20 30 80 00       	mov    0x803020,%eax
  8004cb:	8b 50 74             	mov    0x74(%eax),%edx
  8004ce:	8b 45 0c             	mov    0xc(%ebp),%eax
  8004d1:	39 c2                	cmp    %eax,%edx
  8004d3:	74 14                	je     8004e9 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8004d5:	83 ec 04             	sub    $0x4,%esp
  8004d8:	68 50 1f 80 00       	push   $0x801f50
  8004dd:	6a 26                	push   $0x26
  8004df:	68 9c 1f 80 00       	push   $0x801f9c
  8004e4:	e8 65 ff ff ff       	call   80044e <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8004e9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8004f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8004f7:	e9 c2 00 00 00       	jmp    8005be <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8004fc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004ff:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800506:	8b 45 08             	mov    0x8(%ebp),%eax
  800509:	01 d0                	add    %edx,%eax
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	85 c0                	test   %eax,%eax
  80050f:	75 08                	jne    800519 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800511:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800514:	e9 a2 00 00 00       	jmp    8005bb <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800519:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800520:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  800527:	eb 69                	jmp    800592 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800529:	a1 20 30 80 00       	mov    0x803020,%eax
  80052e:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800534:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800537:	89 d0                	mov    %edx,%eax
  800539:	01 c0                	add    %eax,%eax
  80053b:	01 d0                	add    %edx,%eax
  80053d:	c1 e0 03             	shl    $0x3,%eax
  800540:	01 c8                	add    %ecx,%eax
  800542:	8a 40 04             	mov    0x4(%eax),%al
  800545:	84 c0                	test   %al,%al
  800547:	75 46                	jne    80058f <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800549:	a1 20 30 80 00       	mov    0x803020,%eax
  80054e:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800554:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800557:	89 d0                	mov    %edx,%eax
  800559:	01 c0                	add    %eax,%eax
  80055b:	01 d0                	add    %edx,%eax
  80055d:	c1 e0 03             	shl    $0x3,%eax
  800560:	01 c8                	add    %ecx,%eax
  800562:	8b 00                	mov    (%eax),%eax
  800564:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800567:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80056a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80056f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800571:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800574:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80057b:	8b 45 08             	mov    0x8(%ebp),%eax
  80057e:	01 c8                	add    %ecx,%eax
  800580:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800582:	39 c2                	cmp    %eax,%edx
  800584:	75 09                	jne    80058f <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800586:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80058d:	eb 12                	jmp    8005a1 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80058f:	ff 45 e8             	incl   -0x18(%ebp)
  800592:	a1 20 30 80 00       	mov    0x803020,%eax
  800597:	8b 50 74             	mov    0x74(%eax),%edx
  80059a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80059d:	39 c2                	cmp    %eax,%edx
  80059f:	77 88                	ja     800529 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005a1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005a5:	75 14                	jne    8005bb <CheckWSWithoutLastIndex+0xfb>
			panic(
  8005a7:	83 ec 04             	sub    $0x4,%esp
  8005aa:	68 a8 1f 80 00       	push   $0x801fa8
  8005af:	6a 3a                	push   $0x3a
  8005b1:	68 9c 1f 80 00       	push   $0x801f9c
  8005b6:	e8 93 fe ff ff       	call   80044e <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8005bb:	ff 45 f0             	incl   -0x10(%ebp)
  8005be:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005c1:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8005c4:	0f 8c 32 ff ff ff    	jl     8004fc <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8005ca:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005d1:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8005d8:	eb 26                	jmp    800600 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8005da:	a1 20 30 80 00       	mov    0x803020,%eax
  8005df:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8005e5:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8005e8:	89 d0                	mov    %edx,%eax
  8005ea:	01 c0                	add    %eax,%eax
  8005ec:	01 d0                	add    %edx,%eax
  8005ee:	c1 e0 03             	shl    $0x3,%eax
  8005f1:	01 c8                	add    %ecx,%eax
  8005f3:	8a 40 04             	mov    0x4(%eax),%al
  8005f6:	3c 01                	cmp    $0x1,%al
  8005f8:	75 03                	jne    8005fd <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8005fa:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005fd:	ff 45 e0             	incl   -0x20(%ebp)
  800600:	a1 20 30 80 00       	mov    0x803020,%eax
  800605:	8b 50 74             	mov    0x74(%eax),%edx
  800608:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80060b:	39 c2                	cmp    %eax,%edx
  80060d:	77 cb                	ja     8005da <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  80060f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800612:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800615:	74 14                	je     80062b <CheckWSWithoutLastIndex+0x16b>
		panic(
  800617:	83 ec 04             	sub    $0x4,%esp
  80061a:	68 fc 1f 80 00       	push   $0x801ffc
  80061f:	6a 44                	push   $0x44
  800621:	68 9c 1f 80 00       	push   $0x801f9c
  800626:	e8 23 fe ff ff       	call   80044e <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80062b:	90                   	nop
  80062c:	c9                   	leave  
  80062d:	c3                   	ret    

0080062e <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  80062e:	55                   	push   %ebp
  80062f:	89 e5                	mov    %esp,%ebp
  800631:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800634:	8b 45 0c             	mov    0xc(%ebp),%eax
  800637:	8b 00                	mov    (%eax),%eax
  800639:	8d 48 01             	lea    0x1(%eax),%ecx
  80063c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80063f:	89 0a                	mov    %ecx,(%edx)
  800641:	8b 55 08             	mov    0x8(%ebp),%edx
  800644:	88 d1                	mov    %dl,%cl
  800646:	8b 55 0c             	mov    0xc(%ebp),%edx
  800649:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  80064d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800650:	8b 00                	mov    (%eax),%eax
  800652:	3d ff 00 00 00       	cmp    $0xff,%eax
  800657:	75 2c                	jne    800685 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800659:	a0 24 30 80 00       	mov    0x803024,%al
  80065e:	0f b6 c0             	movzbl %al,%eax
  800661:	8b 55 0c             	mov    0xc(%ebp),%edx
  800664:	8b 12                	mov    (%edx),%edx
  800666:	89 d1                	mov    %edx,%ecx
  800668:	8b 55 0c             	mov    0xc(%ebp),%edx
  80066b:	83 c2 08             	add    $0x8,%edx
  80066e:	83 ec 04             	sub    $0x4,%esp
  800671:	50                   	push   %eax
  800672:	51                   	push   %ecx
  800673:	52                   	push   %edx
  800674:	e8 3e 0e 00 00       	call   8014b7 <sys_cputs>
  800679:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80067c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80067f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800685:	8b 45 0c             	mov    0xc(%ebp),%eax
  800688:	8b 40 04             	mov    0x4(%eax),%eax
  80068b:	8d 50 01             	lea    0x1(%eax),%edx
  80068e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800691:	89 50 04             	mov    %edx,0x4(%eax)
}
  800694:	90                   	nop
  800695:	c9                   	leave  
  800696:	c3                   	ret    

00800697 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800697:	55                   	push   %ebp
  800698:	89 e5                	mov    %esp,%ebp
  80069a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006a0:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006a7:	00 00 00 
	b.cnt = 0;
  8006aa:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8006b1:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8006b4:	ff 75 0c             	pushl  0xc(%ebp)
  8006b7:	ff 75 08             	pushl  0x8(%ebp)
  8006ba:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006c0:	50                   	push   %eax
  8006c1:	68 2e 06 80 00       	push   $0x80062e
  8006c6:	e8 11 02 00 00       	call   8008dc <vprintfmt>
  8006cb:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8006ce:	a0 24 30 80 00       	mov    0x803024,%al
  8006d3:	0f b6 c0             	movzbl %al,%eax
  8006d6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8006dc:	83 ec 04             	sub    $0x4,%esp
  8006df:	50                   	push   %eax
  8006e0:	52                   	push   %edx
  8006e1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8006e7:	83 c0 08             	add    $0x8,%eax
  8006ea:	50                   	push   %eax
  8006eb:	e8 c7 0d 00 00       	call   8014b7 <sys_cputs>
  8006f0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8006f3:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8006fa:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800700:	c9                   	leave  
  800701:	c3                   	ret    

00800702 <cprintf>:

int cprintf(const char *fmt, ...) {
  800702:	55                   	push   %ebp
  800703:	89 e5                	mov    %esp,%ebp
  800705:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  800708:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  80070f:	8d 45 0c             	lea    0xc(%ebp),%eax
  800712:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800715:	8b 45 08             	mov    0x8(%ebp),%eax
  800718:	83 ec 08             	sub    $0x8,%esp
  80071b:	ff 75 f4             	pushl  -0xc(%ebp)
  80071e:	50                   	push   %eax
  80071f:	e8 73 ff ff ff       	call   800697 <vcprintf>
  800724:	83 c4 10             	add    $0x10,%esp
  800727:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80072a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80072d:	c9                   	leave  
  80072e:	c3                   	ret    

0080072f <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  80072f:	55                   	push   %ebp
  800730:	89 e5                	mov    %esp,%ebp
  800732:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800735:	e8 8e 0f 00 00       	call   8016c8 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80073a:	8d 45 0c             	lea    0xc(%ebp),%eax
  80073d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800740:	8b 45 08             	mov    0x8(%ebp),%eax
  800743:	83 ec 08             	sub    $0x8,%esp
  800746:	ff 75 f4             	pushl  -0xc(%ebp)
  800749:	50                   	push   %eax
  80074a:	e8 48 ff ff ff       	call   800697 <vcprintf>
  80074f:	83 c4 10             	add    $0x10,%esp
  800752:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800755:	e8 88 0f 00 00       	call   8016e2 <sys_enable_interrupt>
	return cnt;
  80075a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80075d:	c9                   	leave  
  80075e:	c3                   	ret    

0080075f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  80075f:	55                   	push   %ebp
  800760:	89 e5                	mov    %esp,%ebp
  800762:	53                   	push   %ebx
  800763:	83 ec 14             	sub    $0x14,%esp
  800766:	8b 45 10             	mov    0x10(%ebp),%eax
  800769:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076c:	8b 45 14             	mov    0x14(%ebp),%eax
  80076f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800772:	8b 45 18             	mov    0x18(%ebp),%eax
  800775:	ba 00 00 00 00       	mov    $0x0,%edx
  80077a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  80077d:	77 55                	ja     8007d4 <printnum+0x75>
  80077f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800782:	72 05                	jb     800789 <printnum+0x2a>
  800784:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800787:	77 4b                	ja     8007d4 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800789:	8b 45 1c             	mov    0x1c(%ebp),%eax
  80078c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  80078f:	8b 45 18             	mov    0x18(%ebp),%eax
  800792:	ba 00 00 00 00       	mov    $0x0,%edx
  800797:	52                   	push   %edx
  800798:	50                   	push   %eax
  800799:	ff 75 f4             	pushl  -0xc(%ebp)
  80079c:	ff 75 f0             	pushl  -0x10(%ebp)
  80079f:	e8 64 13 00 00       	call   801b08 <__udivdi3>
  8007a4:	83 c4 10             	add    $0x10,%esp
  8007a7:	83 ec 04             	sub    $0x4,%esp
  8007aa:	ff 75 20             	pushl  0x20(%ebp)
  8007ad:	53                   	push   %ebx
  8007ae:	ff 75 18             	pushl  0x18(%ebp)
  8007b1:	52                   	push   %edx
  8007b2:	50                   	push   %eax
  8007b3:	ff 75 0c             	pushl  0xc(%ebp)
  8007b6:	ff 75 08             	pushl  0x8(%ebp)
  8007b9:	e8 a1 ff ff ff       	call   80075f <printnum>
  8007be:	83 c4 20             	add    $0x20,%esp
  8007c1:	eb 1a                	jmp    8007dd <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8007c3:	83 ec 08             	sub    $0x8,%esp
  8007c6:	ff 75 0c             	pushl  0xc(%ebp)
  8007c9:	ff 75 20             	pushl  0x20(%ebp)
  8007cc:	8b 45 08             	mov    0x8(%ebp),%eax
  8007cf:	ff d0                	call   *%eax
  8007d1:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8007d4:	ff 4d 1c             	decl   0x1c(%ebp)
  8007d7:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8007db:	7f e6                	jg     8007c3 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8007dd:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8007e0:	bb 00 00 00 00       	mov    $0x0,%ebx
  8007e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007e8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8007eb:	53                   	push   %ebx
  8007ec:	51                   	push   %ecx
  8007ed:	52                   	push   %edx
  8007ee:	50                   	push   %eax
  8007ef:	e8 24 14 00 00       	call   801c18 <__umoddi3>
  8007f4:	83 c4 10             	add    $0x10,%esp
  8007f7:	05 74 22 80 00       	add    $0x802274,%eax
  8007fc:	8a 00                	mov    (%eax),%al
  8007fe:	0f be c0             	movsbl %al,%eax
  800801:	83 ec 08             	sub    $0x8,%esp
  800804:	ff 75 0c             	pushl  0xc(%ebp)
  800807:	50                   	push   %eax
  800808:	8b 45 08             	mov    0x8(%ebp),%eax
  80080b:	ff d0                	call   *%eax
  80080d:	83 c4 10             	add    $0x10,%esp
}
  800810:	90                   	nop
  800811:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800814:	c9                   	leave  
  800815:	c3                   	ret    

00800816 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800816:	55                   	push   %ebp
  800817:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800819:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80081d:	7e 1c                	jle    80083b <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  80081f:	8b 45 08             	mov    0x8(%ebp),%eax
  800822:	8b 00                	mov    (%eax),%eax
  800824:	8d 50 08             	lea    0x8(%eax),%edx
  800827:	8b 45 08             	mov    0x8(%ebp),%eax
  80082a:	89 10                	mov    %edx,(%eax)
  80082c:	8b 45 08             	mov    0x8(%ebp),%eax
  80082f:	8b 00                	mov    (%eax),%eax
  800831:	83 e8 08             	sub    $0x8,%eax
  800834:	8b 50 04             	mov    0x4(%eax),%edx
  800837:	8b 00                	mov    (%eax),%eax
  800839:	eb 40                	jmp    80087b <getuint+0x65>
	else if (lflag)
  80083b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80083f:	74 1e                	je     80085f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800841:	8b 45 08             	mov    0x8(%ebp),%eax
  800844:	8b 00                	mov    (%eax),%eax
  800846:	8d 50 04             	lea    0x4(%eax),%edx
  800849:	8b 45 08             	mov    0x8(%ebp),%eax
  80084c:	89 10                	mov    %edx,(%eax)
  80084e:	8b 45 08             	mov    0x8(%ebp),%eax
  800851:	8b 00                	mov    (%eax),%eax
  800853:	83 e8 04             	sub    $0x4,%eax
  800856:	8b 00                	mov    (%eax),%eax
  800858:	ba 00 00 00 00       	mov    $0x0,%edx
  80085d:	eb 1c                	jmp    80087b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  80085f:	8b 45 08             	mov    0x8(%ebp),%eax
  800862:	8b 00                	mov    (%eax),%eax
  800864:	8d 50 04             	lea    0x4(%eax),%edx
  800867:	8b 45 08             	mov    0x8(%ebp),%eax
  80086a:	89 10                	mov    %edx,(%eax)
  80086c:	8b 45 08             	mov    0x8(%ebp),%eax
  80086f:	8b 00                	mov    (%eax),%eax
  800871:	83 e8 04             	sub    $0x4,%eax
  800874:	8b 00                	mov    (%eax),%eax
  800876:	ba 00 00 00 00       	mov    $0x0,%edx
}
  80087b:	5d                   	pop    %ebp
  80087c:	c3                   	ret    

0080087d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  80087d:	55                   	push   %ebp
  80087e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800880:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800884:	7e 1c                	jle    8008a2 <getint+0x25>
		return va_arg(*ap, long long);
  800886:	8b 45 08             	mov    0x8(%ebp),%eax
  800889:	8b 00                	mov    (%eax),%eax
  80088b:	8d 50 08             	lea    0x8(%eax),%edx
  80088e:	8b 45 08             	mov    0x8(%ebp),%eax
  800891:	89 10                	mov    %edx,(%eax)
  800893:	8b 45 08             	mov    0x8(%ebp),%eax
  800896:	8b 00                	mov    (%eax),%eax
  800898:	83 e8 08             	sub    $0x8,%eax
  80089b:	8b 50 04             	mov    0x4(%eax),%edx
  80089e:	8b 00                	mov    (%eax),%eax
  8008a0:	eb 38                	jmp    8008da <getint+0x5d>
	else if (lflag)
  8008a2:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008a6:	74 1a                	je     8008c2 <getint+0x45>
		return va_arg(*ap, long);
  8008a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8008ab:	8b 00                	mov    (%eax),%eax
  8008ad:	8d 50 04             	lea    0x4(%eax),%edx
  8008b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b3:	89 10                	mov    %edx,(%eax)
  8008b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b8:	8b 00                	mov    (%eax),%eax
  8008ba:	83 e8 04             	sub    $0x4,%eax
  8008bd:	8b 00                	mov    (%eax),%eax
  8008bf:	99                   	cltd   
  8008c0:	eb 18                	jmp    8008da <getint+0x5d>
	else
		return va_arg(*ap, int);
  8008c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c5:	8b 00                	mov    (%eax),%eax
  8008c7:	8d 50 04             	lea    0x4(%eax),%edx
  8008ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8008cd:	89 10                	mov    %edx,(%eax)
  8008cf:	8b 45 08             	mov    0x8(%ebp),%eax
  8008d2:	8b 00                	mov    (%eax),%eax
  8008d4:	83 e8 04             	sub    $0x4,%eax
  8008d7:	8b 00                	mov    (%eax),%eax
  8008d9:	99                   	cltd   
}
  8008da:	5d                   	pop    %ebp
  8008db:	c3                   	ret    

008008dc <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8008dc:	55                   	push   %ebp
  8008dd:	89 e5                	mov    %esp,%ebp
  8008df:	56                   	push   %esi
  8008e0:	53                   	push   %ebx
  8008e1:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008e4:	eb 17                	jmp    8008fd <vprintfmt+0x21>
			if (ch == '\0')
  8008e6:	85 db                	test   %ebx,%ebx
  8008e8:	0f 84 af 03 00 00    	je     800c9d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8008ee:	83 ec 08             	sub    $0x8,%esp
  8008f1:	ff 75 0c             	pushl  0xc(%ebp)
  8008f4:	53                   	push   %ebx
  8008f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8008f8:	ff d0                	call   *%eax
  8008fa:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8008fd:	8b 45 10             	mov    0x10(%ebp),%eax
  800900:	8d 50 01             	lea    0x1(%eax),%edx
  800903:	89 55 10             	mov    %edx,0x10(%ebp)
  800906:	8a 00                	mov    (%eax),%al
  800908:	0f b6 d8             	movzbl %al,%ebx
  80090b:	83 fb 25             	cmp    $0x25,%ebx
  80090e:	75 d6                	jne    8008e6 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800910:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800914:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80091b:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800922:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800929:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800930:	8b 45 10             	mov    0x10(%ebp),%eax
  800933:	8d 50 01             	lea    0x1(%eax),%edx
  800936:	89 55 10             	mov    %edx,0x10(%ebp)
  800939:	8a 00                	mov    (%eax),%al
  80093b:	0f b6 d8             	movzbl %al,%ebx
  80093e:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800941:	83 f8 55             	cmp    $0x55,%eax
  800944:	0f 87 2b 03 00 00    	ja     800c75 <vprintfmt+0x399>
  80094a:	8b 04 85 98 22 80 00 	mov    0x802298(,%eax,4),%eax
  800951:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800953:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800957:	eb d7                	jmp    800930 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800959:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  80095d:	eb d1                	jmp    800930 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80095f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800966:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800969:	89 d0                	mov    %edx,%eax
  80096b:	c1 e0 02             	shl    $0x2,%eax
  80096e:	01 d0                	add    %edx,%eax
  800970:	01 c0                	add    %eax,%eax
  800972:	01 d8                	add    %ebx,%eax
  800974:	83 e8 30             	sub    $0x30,%eax
  800977:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  80097a:	8b 45 10             	mov    0x10(%ebp),%eax
  80097d:	8a 00                	mov    (%eax),%al
  80097f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800982:	83 fb 2f             	cmp    $0x2f,%ebx
  800985:	7e 3e                	jle    8009c5 <vprintfmt+0xe9>
  800987:	83 fb 39             	cmp    $0x39,%ebx
  80098a:	7f 39                	jg     8009c5 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  80098c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  80098f:	eb d5                	jmp    800966 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800991:	8b 45 14             	mov    0x14(%ebp),%eax
  800994:	83 c0 04             	add    $0x4,%eax
  800997:	89 45 14             	mov    %eax,0x14(%ebp)
  80099a:	8b 45 14             	mov    0x14(%ebp),%eax
  80099d:	83 e8 04             	sub    $0x4,%eax
  8009a0:	8b 00                	mov    (%eax),%eax
  8009a2:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009a5:	eb 1f                	jmp    8009c6 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009a7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ab:	79 83                	jns    800930 <vprintfmt+0x54>
				width = 0;
  8009ad:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8009b4:	e9 77 ff ff ff       	jmp    800930 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8009b9:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8009c0:	e9 6b ff ff ff       	jmp    800930 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8009c5:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8009c6:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009ca:	0f 89 60 ff ff ff    	jns    800930 <vprintfmt+0x54>
				width = precision, precision = -1;
  8009d0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8009d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8009d6:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8009dd:	e9 4e ff ff ff       	jmp    800930 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8009e2:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8009e5:	e9 46 ff ff ff       	jmp    800930 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8009ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8009ed:	83 c0 04             	add    $0x4,%eax
  8009f0:	89 45 14             	mov    %eax,0x14(%ebp)
  8009f3:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f6:	83 e8 04             	sub    $0x4,%eax
  8009f9:	8b 00                	mov    (%eax),%eax
  8009fb:	83 ec 08             	sub    $0x8,%esp
  8009fe:	ff 75 0c             	pushl  0xc(%ebp)
  800a01:	50                   	push   %eax
  800a02:	8b 45 08             	mov    0x8(%ebp),%eax
  800a05:	ff d0                	call   *%eax
  800a07:	83 c4 10             	add    $0x10,%esp
			break;
  800a0a:	e9 89 02 00 00       	jmp    800c98 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a0f:	8b 45 14             	mov    0x14(%ebp),%eax
  800a12:	83 c0 04             	add    $0x4,%eax
  800a15:	89 45 14             	mov    %eax,0x14(%ebp)
  800a18:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1b:	83 e8 04             	sub    $0x4,%eax
  800a1e:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a20:	85 db                	test   %ebx,%ebx
  800a22:	79 02                	jns    800a26 <vprintfmt+0x14a>
				err = -err;
  800a24:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a26:	83 fb 64             	cmp    $0x64,%ebx
  800a29:	7f 0b                	jg     800a36 <vprintfmt+0x15a>
  800a2b:	8b 34 9d e0 20 80 00 	mov    0x8020e0(,%ebx,4),%esi
  800a32:	85 f6                	test   %esi,%esi
  800a34:	75 19                	jne    800a4f <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a36:	53                   	push   %ebx
  800a37:	68 85 22 80 00       	push   $0x802285
  800a3c:	ff 75 0c             	pushl  0xc(%ebp)
  800a3f:	ff 75 08             	pushl  0x8(%ebp)
  800a42:	e8 5e 02 00 00       	call   800ca5 <printfmt>
  800a47:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a4a:	e9 49 02 00 00       	jmp    800c98 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800a4f:	56                   	push   %esi
  800a50:	68 8e 22 80 00       	push   $0x80228e
  800a55:	ff 75 0c             	pushl  0xc(%ebp)
  800a58:	ff 75 08             	pushl  0x8(%ebp)
  800a5b:	e8 45 02 00 00       	call   800ca5 <printfmt>
  800a60:	83 c4 10             	add    $0x10,%esp
			break;
  800a63:	e9 30 02 00 00       	jmp    800c98 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800a68:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6b:	83 c0 04             	add    $0x4,%eax
  800a6e:	89 45 14             	mov    %eax,0x14(%ebp)
  800a71:	8b 45 14             	mov    0x14(%ebp),%eax
  800a74:	83 e8 04             	sub    $0x4,%eax
  800a77:	8b 30                	mov    (%eax),%esi
  800a79:	85 f6                	test   %esi,%esi
  800a7b:	75 05                	jne    800a82 <vprintfmt+0x1a6>
				p = "(null)";
  800a7d:	be 91 22 80 00       	mov    $0x802291,%esi
			if (width > 0 && padc != '-')
  800a82:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a86:	7e 6d                	jle    800af5 <vprintfmt+0x219>
  800a88:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800a8c:	74 67                	je     800af5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800a8e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a91:	83 ec 08             	sub    $0x8,%esp
  800a94:	50                   	push   %eax
  800a95:	56                   	push   %esi
  800a96:	e8 0c 03 00 00       	call   800da7 <strnlen>
  800a9b:	83 c4 10             	add    $0x10,%esp
  800a9e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800aa1:	eb 16                	jmp    800ab9 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800aa3:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800aa7:	83 ec 08             	sub    $0x8,%esp
  800aaa:	ff 75 0c             	pushl  0xc(%ebp)
  800aad:	50                   	push   %eax
  800aae:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab1:	ff d0                	call   *%eax
  800ab3:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800ab6:	ff 4d e4             	decl   -0x1c(%ebp)
  800ab9:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800abd:	7f e4                	jg     800aa3 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800abf:	eb 34                	jmp    800af5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800ac1:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800ac5:	74 1c                	je     800ae3 <vprintfmt+0x207>
  800ac7:	83 fb 1f             	cmp    $0x1f,%ebx
  800aca:	7e 05                	jle    800ad1 <vprintfmt+0x1f5>
  800acc:	83 fb 7e             	cmp    $0x7e,%ebx
  800acf:	7e 12                	jle    800ae3 <vprintfmt+0x207>
					putch('?', putdat);
  800ad1:	83 ec 08             	sub    $0x8,%esp
  800ad4:	ff 75 0c             	pushl  0xc(%ebp)
  800ad7:	6a 3f                	push   $0x3f
  800ad9:	8b 45 08             	mov    0x8(%ebp),%eax
  800adc:	ff d0                	call   *%eax
  800ade:	83 c4 10             	add    $0x10,%esp
  800ae1:	eb 0f                	jmp    800af2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	53                   	push   %ebx
  800aea:	8b 45 08             	mov    0x8(%ebp),%eax
  800aed:	ff d0                	call   *%eax
  800aef:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800af2:	ff 4d e4             	decl   -0x1c(%ebp)
  800af5:	89 f0                	mov    %esi,%eax
  800af7:	8d 70 01             	lea    0x1(%eax),%esi
  800afa:	8a 00                	mov    (%eax),%al
  800afc:	0f be d8             	movsbl %al,%ebx
  800aff:	85 db                	test   %ebx,%ebx
  800b01:	74 24                	je     800b27 <vprintfmt+0x24b>
  800b03:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b07:	78 b8                	js     800ac1 <vprintfmt+0x1e5>
  800b09:	ff 4d e0             	decl   -0x20(%ebp)
  800b0c:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b10:	79 af                	jns    800ac1 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b12:	eb 13                	jmp    800b27 <vprintfmt+0x24b>
				putch(' ', putdat);
  800b14:	83 ec 08             	sub    $0x8,%esp
  800b17:	ff 75 0c             	pushl  0xc(%ebp)
  800b1a:	6a 20                	push   $0x20
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	ff d0                	call   *%eax
  800b21:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b24:	ff 4d e4             	decl   -0x1c(%ebp)
  800b27:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b2b:	7f e7                	jg     800b14 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b2d:	e9 66 01 00 00       	jmp    800c98 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b32:	83 ec 08             	sub    $0x8,%esp
  800b35:	ff 75 e8             	pushl  -0x18(%ebp)
  800b38:	8d 45 14             	lea    0x14(%ebp),%eax
  800b3b:	50                   	push   %eax
  800b3c:	e8 3c fd ff ff       	call   80087d <getint>
  800b41:	83 c4 10             	add    $0x10,%esp
  800b44:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b47:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b4d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b50:	85 d2                	test   %edx,%edx
  800b52:	79 23                	jns    800b77 <vprintfmt+0x29b>
				putch('-', putdat);
  800b54:	83 ec 08             	sub    $0x8,%esp
  800b57:	ff 75 0c             	pushl  0xc(%ebp)
  800b5a:	6a 2d                	push   $0x2d
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	ff d0                	call   *%eax
  800b61:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800b64:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800b67:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800b6a:	f7 d8                	neg    %eax
  800b6c:	83 d2 00             	adc    $0x0,%edx
  800b6f:	f7 da                	neg    %edx
  800b71:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b74:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800b77:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800b7e:	e9 bc 00 00 00       	jmp    800c3f <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800b83:	83 ec 08             	sub    $0x8,%esp
  800b86:	ff 75 e8             	pushl  -0x18(%ebp)
  800b89:	8d 45 14             	lea    0x14(%ebp),%eax
  800b8c:	50                   	push   %eax
  800b8d:	e8 84 fc ff ff       	call   800816 <getuint>
  800b92:	83 c4 10             	add    $0x10,%esp
  800b95:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b98:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800b9b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800ba2:	e9 98 00 00 00       	jmp    800c3f <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800ba7:	83 ec 08             	sub    $0x8,%esp
  800baa:	ff 75 0c             	pushl  0xc(%ebp)
  800bad:	6a 58                	push   $0x58
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	ff d0                	call   *%eax
  800bb4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bb7:	83 ec 08             	sub    $0x8,%esp
  800bba:	ff 75 0c             	pushl  0xc(%ebp)
  800bbd:	6a 58                	push   $0x58
  800bbf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bc2:	ff d0                	call   *%eax
  800bc4:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800bc7:	83 ec 08             	sub    $0x8,%esp
  800bca:	ff 75 0c             	pushl  0xc(%ebp)
  800bcd:	6a 58                	push   $0x58
  800bcf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd2:	ff d0                	call   *%eax
  800bd4:	83 c4 10             	add    $0x10,%esp
			break;
  800bd7:	e9 bc 00 00 00       	jmp    800c98 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800bdc:	83 ec 08             	sub    $0x8,%esp
  800bdf:	ff 75 0c             	pushl  0xc(%ebp)
  800be2:	6a 30                	push   $0x30
  800be4:	8b 45 08             	mov    0x8(%ebp),%eax
  800be7:	ff d0                	call   *%eax
  800be9:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800bec:	83 ec 08             	sub    $0x8,%esp
  800bef:	ff 75 0c             	pushl  0xc(%ebp)
  800bf2:	6a 78                	push   $0x78
  800bf4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bf7:	ff d0                	call   *%eax
  800bf9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800bfc:	8b 45 14             	mov    0x14(%ebp),%eax
  800bff:	83 c0 04             	add    $0x4,%eax
  800c02:	89 45 14             	mov    %eax,0x14(%ebp)
  800c05:	8b 45 14             	mov    0x14(%ebp),%eax
  800c08:	83 e8 04             	sub    $0x4,%eax
  800c0b:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c0d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c10:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c17:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c1e:	eb 1f                	jmp    800c3f <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c20:	83 ec 08             	sub    $0x8,%esp
  800c23:	ff 75 e8             	pushl  -0x18(%ebp)
  800c26:	8d 45 14             	lea    0x14(%ebp),%eax
  800c29:	50                   	push   %eax
  800c2a:	e8 e7 fb ff ff       	call   800816 <getuint>
  800c2f:	83 c4 10             	add    $0x10,%esp
  800c32:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c35:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c38:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c3f:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c43:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c46:	83 ec 04             	sub    $0x4,%esp
  800c49:	52                   	push   %edx
  800c4a:	ff 75 e4             	pushl  -0x1c(%ebp)
  800c4d:	50                   	push   %eax
  800c4e:	ff 75 f4             	pushl  -0xc(%ebp)
  800c51:	ff 75 f0             	pushl  -0x10(%ebp)
  800c54:	ff 75 0c             	pushl  0xc(%ebp)
  800c57:	ff 75 08             	pushl  0x8(%ebp)
  800c5a:	e8 00 fb ff ff       	call   80075f <printnum>
  800c5f:	83 c4 20             	add    $0x20,%esp
			break;
  800c62:	eb 34                	jmp    800c98 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800c64:	83 ec 08             	sub    $0x8,%esp
  800c67:	ff 75 0c             	pushl  0xc(%ebp)
  800c6a:	53                   	push   %ebx
  800c6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c6e:	ff d0                	call   *%eax
  800c70:	83 c4 10             	add    $0x10,%esp
			break;
  800c73:	eb 23                	jmp    800c98 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800c75:	83 ec 08             	sub    $0x8,%esp
  800c78:	ff 75 0c             	pushl  0xc(%ebp)
  800c7b:	6a 25                	push   $0x25
  800c7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800c80:	ff d0                	call   *%eax
  800c82:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800c85:	ff 4d 10             	decl   0x10(%ebp)
  800c88:	eb 03                	jmp    800c8d <vprintfmt+0x3b1>
  800c8a:	ff 4d 10             	decl   0x10(%ebp)
  800c8d:	8b 45 10             	mov    0x10(%ebp),%eax
  800c90:	48                   	dec    %eax
  800c91:	8a 00                	mov    (%eax),%al
  800c93:	3c 25                	cmp    $0x25,%al
  800c95:	75 f3                	jne    800c8a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800c97:	90                   	nop
		}
	}
  800c98:	e9 47 fc ff ff       	jmp    8008e4 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800c9d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800c9e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800ca1:	5b                   	pop    %ebx
  800ca2:	5e                   	pop    %esi
  800ca3:	5d                   	pop    %ebp
  800ca4:	c3                   	ret    

00800ca5 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800ca5:	55                   	push   %ebp
  800ca6:	89 e5                	mov    %esp,%ebp
  800ca8:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cab:	8d 45 10             	lea    0x10(%ebp),%eax
  800cae:	83 c0 04             	add    $0x4,%eax
  800cb1:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800cb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800cb7:	ff 75 f4             	pushl  -0xc(%ebp)
  800cba:	50                   	push   %eax
  800cbb:	ff 75 0c             	pushl  0xc(%ebp)
  800cbe:	ff 75 08             	pushl  0x8(%ebp)
  800cc1:	e8 16 fc ff ff       	call   8008dc <vprintfmt>
  800cc6:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800cc9:	90                   	nop
  800cca:	c9                   	leave  
  800ccb:	c3                   	ret    

00800ccc <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800ccc:	55                   	push   %ebp
  800ccd:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800ccf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cd2:	8b 40 08             	mov    0x8(%eax),%eax
  800cd5:	8d 50 01             	lea    0x1(%eax),%edx
  800cd8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cdb:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800cde:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce1:	8b 10                	mov    (%eax),%edx
  800ce3:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ce6:	8b 40 04             	mov    0x4(%eax),%eax
  800ce9:	39 c2                	cmp    %eax,%edx
  800ceb:	73 12                	jae    800cff <sprintputch+0x33>
		*b->buf++ = ch;
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	8b 00                	mov    (%eax),%eax
  800cf2:	8d 48 01             	lea    0x1(%eax),%ecx
  800cf5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800cf8:	89 0a                	mov    %ecx,(%edx)
  800cfa:	8b 55 08             	mov    0x8(%ebp),%edx
  800cfd:	88 10                	mov    %dl,(%eax)
}
  800cff:	90                   	nop
  800d00:	5d                   	pop    %ebp
  800d01:	c3                   	ret    

00800d02 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d02:	55                   	push   %ebp
  800d03:	89 e5                	mov    %esp,%ebp
  800d05:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d08:	8b 45 08             	mov    0x8(%ebp),%eax
  800d0b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d11:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d14:	8b 45 08             	mov    0x8(%ebp),%eax
  800d17:	01 d0                	add    %edx,%eax
  800d19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d1c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d23:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d27:	74 06                	je     800d2f <vsnprintf+0x2d>
  800d29:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d2d:	7f 07                	jg     800d36 <vsnprintf+0x34>
		return -E_INVAL;
  800d2f:	b8 03 00 00 00       	mov    $0x3,%eax
  800d34:	eb 20                	jmp    800d56 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d36:	ff 75 14             	pushl  0x14(%ebp)
  800d39:	ff 75 10             	pushl  0x10(%ebp)
  800d3c:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d3f:	50                   	push   %eax
  800d40:	68 cc 0c 80 00       	push   $0x800ccc
  800d45:	e8 92 fb ff ff       	call   8008dc <vprintfmt>
  800d4a:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800d4d:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800d50:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800d53:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800d56:	c9                   	leave  
  800d57:	c3                   	ret    

00800d58 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800d58:	55                   	push   %ebp
  800d59:	89 e5                	mov    %esp,%ebp
  800d5b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800d5e:	8d 45 10             	lea    0x10(%ebp),%eax
  800d61:	83 c0 04             	add    $0x4,%eax
  800d64:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800d67:	8b 45 10             	mov    0x10(%ebp),%eax
  800d6a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d6d:	50                   	push   %eax
  800d6e:	ff 75 0c             	pushl  0xc(%ebp)
  800d71:	ff 75 08             	pushl  0x8(%ebp)
  800d74:	e8 89 ff ff ff       	call   800d02 <vsnprintf>
  800d79:	83 c4 10             	add    $0x10,%esp
  800d7c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800d7f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800d82:	c9                   	leave  
  800d83:	c3                   	ret    

00800d84 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800d84:	55                   	push   %ebp
  800d85:	89 e5                	mov    %esp,%ebp
  800d87:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800d8a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d91:	eb 06                	jmp    800d99 <strlen+0x15>
		n++;
  800d93:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800d96:	ff 45 08             	incl   0x8(%ebp)
  800d99:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9c:	8a 00                	mov    (%eax),%al
  800d9e:	84 c0                	test   %al,%al
  800da0:	75 f1                	jne    800d93 <strlen+0xf>
		n++;
	return n;
  800da2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800da5:	c9                   	leave  
  800da6:	c3                   	ret    

00800da7 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800da7:	55                   	push   %ebp
  800da8:	89 e5                	mov    %esp,%ebp
  800daa:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800dad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800db4:	eb 09                	jmp    800dbf <strnlen+0x18>
		n++;
  800db6:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800db9:	ff 45 08             	incl   0x8(%ebp)
  800dbc:	ff 4d 0c             	decl   0xc(%ebp)
  800dbf:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800dc3:	74 09                	je     800dce <strnlen+0x27>
  800dc5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dc8:	8a 00                	mov    (%eax),%al
  800dca:	84 c0                	test   %al,%al
  800dcc:	75 e8                	jne    800db6 <strnlen+0xf>
		n++;
	return n;
  800dce:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dd1:	c9                   	leave  
  800dd2:	c3                   	ret    

00800dd3 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800dd3:	55                   	push   %ebp
  800dd4:	89 e5                	mov    %esp,%ebp
  800dd6:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800dd9:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddc:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800ddf:	90                   	nop
  800de0:	8b 45 08             	mov    0x8(%ebp),%eax
  800de3:	8d 50 01             	lea    0x1(%eax),%edx
  800de6:	89 55 08             	mov    %edx,0x8(%ebp)
  800de9:	8b 55 0c             	mov    0xc(%ebp),%edx
  800dec:	8d 4a 01             	lea    0x1(%edx),%ecx
  800def:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800df2:	8a 12                	mov    (%edx),%dl
  800df4:	88 10                	mov    %dl,(%eax)
  800df6:	8a 00                	mov    (%eax),%al
  800df8:	84 c0                	test   %al,%al
  800dfa:	75 e4                	jne    800de0 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800dfc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800dff:	c9                   	leave  
  800e00:	c3                   	ret    

00800e01 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e01:	55                   	push   %ebp
  800e02:	89 e5                	mov    %esp,%ebp
  800e04:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e07:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0a:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e0d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e14:	eb 1f                	jmp    800e35 <strncpy+0x34>
		*dst++ = *src;
  800e16:	8b 45 08             	mov    0x8(%ebp),%eax
  800e19:	8d 50 01             	lea    0x1(%eax),%edx
  800e1c:	89 55 08             	mov    %edx,0x8(%ebp)
  800e1f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e22:	8a 12                	mov    (%edx),%dl
  800e24:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e26:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e29:	8a 00                	mov    (%eax),%al
  800e2b:	84 c0                	test   %al,%al
  800e2d:	74 03                	je     800e32 <strncpy+0x31>
			src++;
  800e2f:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e32:	ff 45 fc             	incl   -0x4(%ebp)
  800e35:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e38:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e3b:	72 d9                	jb     800e16 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e3d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e40:	c9                   	leave  
  800e41:	c3                   	ret    

00800e42 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e42:	55                   	push   %ebp
  800e43:	89 e5                	mov    %esp,%ebp
  800e45:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e48:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800e4e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e52:	74 30                	je     800e84 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800e54:	eb 16                	jmp    800e6c <strlcpy+0x2a>
			*dst++ = *src++;
  800e56:	8b 45 08             	mov    0x8(%ebp),%eax
  800e59:	8d 50 01             	lea    0x1(%eax),%edx
  800e5c:	89 55 08             	mov    %edx,0x8(%ebp)
  800e5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e62:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e65:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e68:	8a 12                	mov    (%edx),%dl
  800e6a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800e6c:	ff 4d 10             	decl   0x10(%ebp)
  800e6f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800e73:	74 09                	je     800e7e <strlcpy+0x3c>
  800e75:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e78:	8a 00                	mov    (%eax),%al
  800e7a:	84 c0                	test   %al,%al
  800e7c:	75 d8                	jne    800e56 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800e7e:	8b 45 08             	mov    0x8(%ebp),%eax
  800e81:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800e84:	8b 55 08             	mov    0x8(%ebp),%edx
  800e87:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8a:	29 c2                	sub    %eax,%edx
  800e8c:	89 d0                	mov    %edx,%eax
}
  800e8e:	c9                   	leave  
  800e8f:	c3                   	ret    

00800e90 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800e90:	55                   	push   %ebp
  800e91:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800e93:	eb 06                	jmp    800e9b <strcmp+0xb>
		p++, q++;
  800e95:	ff 45 08             	incl   0x8(%ebp)
  800e98:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	8a 00                	mov    (%eax),%al
  800ea0:	84 c0                	test   %al,%al
  800ea2:	74 0e                	je     800eb2 <strcmp+0x22>
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	8a 10                	mov    (%eax),%dl
  800ea9:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eac:	8a 00                	mov    (%eax),%al
  800eae:	38 c2                	cmp    %al,%dl
  800eb0:	74 e3                	je     800e95 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800eb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800eb5:	8a 00                	mov    (%eax),%al
  800eb7:	0f b6 d0             	movzbl %al,%edx
  800eba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ebd:	8a 00                	mov    (%eax),%al
  800ebf:	0f b6 c0             	movzbl %al,%eax
  800ec2:	29 c2                	sub    %eax,%edx
  800ec4:	89 d0                	mov    %edx,%eax
}
  800ec6:	5d                   	pop    %ebp
  800ec7:	c3                   	ret    

00800ec8 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800ec8:	55                   	push   %ebp
  800ec9:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800ecb:	eb 09                	jmp    800ed6 <strncmp+0xe>
		n--, p++, q++;
  800ecd:	ff 4d 10             	decl   0x10(%ebp)
  800ed0:	ff 45 08             	incl   0x8(%ebp)
  800ed3:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800ed6:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800eda:	74 17                	je     800ef3 <strncmp+0x2b>
  800edc:	8b 45 08             	mov    0x8(%ebp),%eax
  800edf:	8a 00                	mov    (%eax),%al
  800ee1:	84 c0                	test   %al,%al
  800ee3:	74 0e                	je     800ef3 <strncmp+0x2b>
  800ee5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee8:	8a 10                	mov    (%eax),%dl
  800eea:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eed:	8a 00                	mov    (%eax),%al
  800eef:	38 c2                	cmp    %al,%dl
  800ef1:	74 da                	je     800ecd <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800ef3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ef7:	75 07                	jne    800f00 <strncmp+0x38>
		return 0;
  800ef9:	b8 00 00 00 00       	mov    $0x0,%eax
  800efe:	eb 14                	jmp    800f14 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f00:	8b 45 08             	mov    0x8(%ebp),%eax
  800f03:	8a 00                	mov    (%eax),%al
  800f05:	0f b6 d0             	movzbl %al,%edx
  800f08:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f0b:	8a 00                	mov    (%eax),%al
  800f0d:	0f b6 c0             	movzbl %al,%eax
  800f10:	29 c2                	sub    %eax,%edx
  800f12:	89 d0                	mov    %edx,%eax
}
  800f14:	5d                   	pop    %ebp
  800f15:	c3                   	ret    

00800f16 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f16:	55                   	push   %ebp
  800f17:	89 e5                	mov    %esp,%ebp
  800f19:	83 ec 04             	sub    $0x4,%esp
  800f1c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f1f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f22:	eb 12                	jmp    800f36 <strchr+0x20>
		if (*s == c)
  800f24:	8b 45 08             	mov    0x8(%ebp),%eax
  800f27:	8a 00                	mov    (%eax),%al
  800f29:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f2c:	75 05                	jne    800f33 <strchr+0x1d>
			return (char *) s;
  800f2e:	8b 45 08             	mov    0x8(%ebp),%eax
  800f31:	eb 11                	jmp    800f44 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f33:	ff 45 08             	incl   0x8(%ebp)
  800f36:	8b 45 08             	mov    0x8(%ebp),%eax
  800f39:	8a 00                	mov    (%eax),%al
  800f3b:	84 c0                	test   %al,%al
  800f3d:	75 e5                	jne    800f24 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f3f:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f44:	c9                   	leave  
  800f45:	c3                   	ret    

00800f46 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f46:	55                   	push   %ebp
  800f47:	89 e5                	mov    %esp,%ebp
  800f49:	83 ec 04             	sub    $0x4,%esp
  800f4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f4f:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f52:	eb 0d                	jmp    800f61 <strfind+0x1b>
		if (*s == c)
  800f54:	8b 45 08             	mov    0x8(%ebp),%eax
  800f57:	8a 00                	mov    (%eax),%al
  800f59:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f5c:	74 0e                	je     800f6c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800f5e:	ff 45 08             	incl   0x8(%ebp)
  800f61:	8b 45 08             	mov    0x8(%ebp),%eax
  800f64:	8a 00                	mov    (%eax),%al
  800f66:	84 c0                	test   %al,%al
  800f68:	75 ea                	jne    800f54 <strfind+0xe>
  800f6a:	eb 01                	jmp    800f6d <strfind+0x27>
		if (*s == c)
			break;
  800f6c:	90                   	nop
	return (char *) s;
  800f6d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f70:	c9                   	leave  
  800f71:	c3                   	ret    

00800f72 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800f72:	55                   	push   %ebp
  800f73:	89 e5                	mov    %esp,%ebp
  800f75:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800f78:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800f7e:	8b 45 10             	mov    0x10(%ebp),%eax
  800f81:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800f84:	eb 0e                	jmp    800f94 <memset+0x22>
		*p++ = c;
  800f86:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f89:	8d 50 01             	lea    0x1(%eax),%edx
  800f8c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800f8f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800f92:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800f94:	ff 4d f8             	decl   -0x8(%ebp)
  800f97:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800f9b:	79 e9                	jns    800f86 <memset+0x14>
		*p++ = c;

	return v;
  800f9d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fa0:	c9                   	leave  
  800fa1:	c3                   	ret    

00800fa2 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800fa2:	55                   	push   %ebp
  800fa3:	89 e5                	mov    %esp,%ebp
  800fa5:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fa8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fab:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fae:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb1:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800fb4:	eb 16                	jmp    800fcc <memcpy+0x2a>
		*d++ = *s++;
  800fb6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fb9:	8d 50 01             	lea    0x1(%eax),%edx
  800fbc:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800fbf:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fc2:	8d 4a 01             	lea    0x1(%edx),%ecx
  800fc5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800fc8:	8a 12                	mov    (%edx),%dl
  800fca:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800fcc:	8b 45 10             	mov    0x10(%ebp),%eax
  800fcf:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fd2:	89 55 10             	mov    %edx,0x10(%ebp)
  800fd5:	85 c0                	test   %eax,%eax
  800fd7:	75 dd                	jne    800fb6 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800fd9:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fdc:	c9                   	leave  
  800fdd:	c3                   	ret    

00800fde <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800fde:	55                   	push   %ebp
  800fdf:	89 e5                	mov    %esp,%ebp
  800fe1:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800fe4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fe7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800fea:	8b 45 08             	mov    0x8(%ebp),%eax
  800fed:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ff0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ff3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800ff6:	73 50                	jae    801048 <memmove+0x6a>
  800ff8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ffb:	8b 45 10             	mov    0x10(%ebp),%eax
  800ffe:	01 d0                	add    %edx,%eax
  801000:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801003:	76 43                	jbe    801048 <memmove+0x6a>
		s += n;
  801005:	8b 45 10             	mov    0x10(%ebp),%eax
  801008:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80100b:	8b 45 10             	mov    0x10(%ebp),%eax
  80100e:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801011:	eb 10                	jmp    801023 <memmove+0x45>
			*--d = *--s;
  801013:	ff 4d f8             	decl   -0x8(%ebp)
  801016:	ff 4d fc             	decl   -0x4(%ebp)
  801019:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80101c:	8a 10                	mov    (%eax),%dl
  80101e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801021:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801023:	8b 45 10             	mov    0x10(%ebp),%eax
  801026:	8d 50 ff             	lea    -0x1(%eax),%edx
  801029:	89 55 10             	mov    %edx,0x10(%ebp)
  80102c:	85 c0                	test   %eax,%eax
  80102e:	75 e3                	jne    801013 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801030:	eb 23                	jmp    801055 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801032:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801035:	8d 50 01             	lea    0x1(%eax),%edx
  801038:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80103b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80103e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801041:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801044:	8a 12                	mov    (%edx),%dl
  801046:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  801048:	8b 45 10             	mov    0x10(%ebp),%eax
  80104b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80104e:	89 55 10             	mov    %edx,0x10(%ebp)
  801051:	85 c0                	test   %eax,%eax
  801053:	75 dd                	jne    801032 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801055:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801058:	c9                   	leave  
  801059:	c3                   	ret    

0080105a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80105a:	55                   	push   %ebp
  80105b:	89 e5                	mov    %esp,%ebp
  80105d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801060:	8b 45 08             	mov    0x8(%ebp),%eax
  801063:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801066:	8b 45 0c             	mov    0xc(%ebp),%eax
  801069:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80106c:	eb 2a                	jmp    801098 <memcmp+0x3e>
		if (*s1 != *s2)
  80106e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801071:	8a 10                	mov    (%eax),%dl
  801073:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801076:	8a 00                	mov    (%eax),%al
  801078:	38 c2                	cmp    %al,%dl
  80107a:	74 16                	je     801092 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80107c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80107f:	8a 00                	mov    (%eax),%al
  801081:	0f b6 d0             	movzbl %al,%edx
  801084:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801087:	8a 00                	mov    (%eax),%al
  801089:	0f b6 c0             	movzbl %al,%eax
  80108c:	29 c2                	sub    %eax,%edx
  80108e:	89 d0                	mov    %edx,%eax
  801090:	eb 18                	jmp    8010aa <memcmp+0x50>
		s1++, s2++;
  801092:	ff 45 fc             	incl   -0x4(%ebp)
  801095:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801098:	8b 45 10             	mov    0x10(%ebp),%eax
  80109b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80109e:	89 55 10             	mov    %edx,0x10(%ebp)
  8010a1:	85 c0                	test   %eax,%eax
  8010a3:	75 c9                	jne    80106e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010a5:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010aa:	c9                   	leave  
  8010ab:	c3                   	ret    

008010ac <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010ac:	55                   	push   %ebp
  8010ad:	89 e5                	mov    %esp,%ebp
  8010af:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  8010b2:	8b 55 08             	mov    0x8(%ebp),%edx
  8010b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8010b8:	01 d0                	add    %edx,%eax
  8010ba:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  8010bd:	eb 15                	jmp    8010d4 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  8010bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c2:	8a 00                	mov    (%eax),%al
  8010c4:	0f b6 d0             	movzbl %al,%edx
  8010c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010ca:	0f b6 c0             	movzbl %al,%eax
  8010cd:	39 c2                	cmp    %eax,%edx
  8010cf:	74 0d                	je     8010de <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  8010d1:	ff 45 08             	incl   0x8(%ebp)
  8010d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d7:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  8010da:	72 e3                	jb     8010bf <memfind+0x13>
  8010dc:	eb 01                	jmp    8010df <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  8010de:	90                   	nop
	return (void *) s;
  8010df:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010e2:	c9                   	leave  
  8010e3:	c3                   	ret    

008010e4 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  8010e4:	55                   	push   %ebp
  8010e5:	89 e5                	mov    %esp,%ebp
  8010e7:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  8010ea:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8010f1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010f8:	eb 03                	jmp    8010fd <strtol+0x19>
		s++;
  8010fa:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8010fd:	8b 45 08             	mov    0x8(%ebp),%eax
  801100:	8a 00                	mov    (%eax),%al
  801102:	3c 20                	cmp    $0x20,%al
  801104:	74 f4                	je     8010fa <strtol+0x16>
  801106:	8b 45 08             	mov    0x8(%ebp),%eax
  801109:	8a 00                	mov    (%eax),%al
  80110b:	3c 09                	cmp    $0x9,%al
  80110d:	74 eb                	je     8010fa <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  80110f:	8b 45 08             	mov    0x8(%ebp),%eax
  801112:	8a 00                	mov    (%eax),%al
  801114:	3c 2b                	cmp    $0x2b,%al
  801116:	75 05                	jne    80111d <strtol+0x39>
		s++;
  801118:	ff 45 08             	incl   0x8(%ebp)
  80111b:	eb 13                	jmp    801130 <strtol+0x4c>
	else if (*s == '-')
  80111d:	8b 45 08             	mov    0x8(%ebp),%eax
  801120:	8a 00                	mov    (%eax),%al
  801122:	3c 2d                	cmp    $0x2d,%al
  801124:	75 0a                	jne    801130 <strtol+0x4c>
		s++, neg = 1;
  801126:	ff 45 08             	incl   0x8(%ebp)
  801129:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801130:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801134:	74 06                	je     80113c <strtol+0x58>
  801136:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80113a:	75 20                	jne    80115c <strtol+0x78>
  80113c:	8b 45 08             	mov    0x8(%ebp),%eax
  80113f:	8a 00                	mov    (%eax),%al
  801141:	3c 30                	cmp    $0x30,%al
  801143:	75 17                	jne    80115c <strtol+0x78>
  801145:	8b 45 08             	mov    0x8(%ebp),%eax
  801148:	40                   	inc    %eax
  801149:	8a 00                	mov    (%eax),%al
  80114b:	3c 78                	cmp    $0x78,%al
  80114d:	75 0d                	jne    80115c <strtol+0x78>
		s += 2, base = 16;
  80114f:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801153:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80115a:	eb 28                	jmp    801184 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80115c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801160:	75 15                	jne    801177 <strtol+0x93>
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	3c 30                	cmp    $0x30,%al
  801169:	75 0c                	jne    801177 <strtol+0x93>
		s++, base = 8;
  80116b:	ff 45 08             	incl   0x8(%ebp)
  80116e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801175:	eb 0d                	jmp    801184 <strtol+0xa0>
	else if (base == 0)
  801177:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80117b:	75 07                	jne    801184 <strtol+0xa0>
		base = 10;
  80117d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801184:	8b 45 08             	mov    0x8(%ebp),%eax
  801187:	8a 00                	mov    (%eax),%al
  801189:	3c 2f                	cmp    $0x2f,%al
  80118b:	7e 19                	jle    8011a6 <strtol+0xc2>
  80118d:	8b 45 08             	mov    0x8(%ebp),%eax
  801190:	8a 00                	mov    (%eax),%al
  801192:	3c 39                	cmp    $0x39,%al
  801194:	7f 10                	jg     8011a6 <strtol+0xc2>
			dig = *s - '0';
  801196:	8b 45 08             	mov    0x8(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	0f be c0             	movsbl %al,%eax
  80119e:	83 e8 30             	sub    $0x30,%eax
  8011a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011a4:	eb 42                	jmp    8011e8 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011a9:	8a 00                	mov    (%eax),%al
  8011ab:	3c 60                	cmp    $0x60,%al
  8011ad:	7e 19                	jle    8011c8 <strtol+0xe4>
  8011af:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b2:	8a 00                	mov    (%eax),%al
  8011b4:	3c 7a                	cmp    $0x7a,%al
  8011b6:	7f 10                	jg     8011c8 <strtol+0xe4>
			dig = *s - 'a' + 10;
  8011b8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	0f be c0             	movsbl %al,%eax
  8011c0:	83 e8 57             	sub    $0x57,%eax
  8011c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011c6:	eb 20                	jmp    8011e8 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8011c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8011cb:	8a 00                	mov    (%eax),%al
  8011cd:	3c 40                	cmp    $0x40,%al
  8011cf:	7e 39                	jle    80120a <strtol+0x126>
  8011d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d4:	8a 00                	mov    (%eax),%al
  8011d6:	3c 5a                	cmp    $0x5a,%al
  8011d8:	7f 30                	jg     80120a <strtol+0x126>
			dig = *s - 'A' + 10;
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	8a 00                	mov    (%eax),%al
  8011df:	0f be c0             	movsbl %al,%eax
  8011e2:	83 e8 37             	sub    $0x37,%eax
  8011e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8011e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011eb:	3b 45 10             	cmp    0x10(%ebp),%eax
  8011ee:	7d 19                	jge    801209 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8011f0:	ff 45 08             	incl   0x8(%ebp)
  8011f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011f6:	0f af 45 10          	imul   0x10(%ebp),%eax
  8011fa:	89 c2                	mov    %eax,%edx
  8011fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8011ff:	01 d0                	add    %edx,%eax
  801201:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801204:	e9 7b ff ff ff       	jmp    801184 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801209:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80120a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80120e:	74 08                	je     801218 <strtol+0x134>
		*endptr = (char *) s;
  801210:	8b 45 0c             	mov    0xc(%ebp),%eax
  801213:	8b 55 08             	mov    0x8(%ebp),%edx
  801216:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  801218:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80121c:	74 07                	je     801225 <strtol+0x141>
  80121e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801221:	f7 d8                	neg    %eax
  801223:	eb 03                	jmp    801228 <strtol+0x144>
  801225:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  801228:	c9                   	leave  
  801229:	c3                   	ret    

0080122a <ltostr>:

void
ltostr(long value, char *str)
{
  80122a:	55                   	push   %ebp
  80122b:	89 e5                	mov    %esp,%ebp
  80122d:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  801237:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  80123e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801242:	79 13                	jns    801257 <ltostr+0x2d>
	{
		neg = 1;
  801244:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80124b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80124e:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801251:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801254:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801257:	8b 45 08             	mov    0x8(%ebp),%eax
  80125a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80125f:	99                   	cltd   
  801260:	f7 f9                	idiv   %ecx
  801262:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801265:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801268:	8d 50 01             	lea    0x1(%eax),%edx
  80126b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80126e:	89 c2                	mov    %eax,%edx
  801270:	8b 45 0c             	mov    0xc(%ebp),%eax
  801273:	01 d0                	add    %edx,%eax
  801275:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801278:	83 c2 30             	add    $0x30,%edx
  80127b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80127d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801280:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801285:	f7 e9                	imul   %ecx
  801287:	c1 fa 02             	sar    $0x2,%edx
  80128a:	89 c8                	mov    %ecx,%eax
  80128c:	c1 f8 1f             	sar    $0x1f,%eax
  80128f:	29 c2                	sub    %eax,%edx
  801291:	89 d0                	mov    %edx,%eax
  801293:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801296:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801299:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80129e:	f7 e9                	imul   %ecx
  8012a0:	c1 fa 02             	sar    $0x2,%edx
  8012a3:	89 c8                	mov    %ecx,%eax
  8012a5:	c1 f8 1f             	sar    $0x1f,%eax
  8012a8:	29 c2                	sub    %eax,%edx
  8012aa:	89 d0                	mov    %edx,%eax
  8012ac:	c1 e0 02             	shl    $0x2,%eax
  8012af:	01 d0                	add    %edx,%eax
  8012b1:	01 c0                	add    %eax,%eax
  8012b3:	29 c1                	sub    %eax,%ecx
  8012b5:	89 ca                	mov    %ecx,%edx
  8012b7:	85 d2                	test   %edx,%edx
  8012b9:	75 9c                	jne    801257 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8012bb:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8012c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012c5:	48                   	dec    %eax
  8012c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8012c9:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8012cd:	74 3d                	je     80130c <ltostr+0xe2>
		start = 1 ;
  8012cf:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8012d6:	eb 34                	jmp    80130c <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8012d8:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012db:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012de:	01 d0                	add    %edx,%eax
  8012e0:	8a 00                	mov    (%eax),%al
  8012e2:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8012e5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8012e8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012eb:	01 c2                	add    %eax,%edx
  8012ed:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8012f0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012f3:	01 c8                	add    %ecx,%eax
  8012f5:	8a 00                	mov    (%eax),%al
  8012f7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8012f9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8012fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012ff:	01 c2                	add    %eax,%edx
  801301:	8a 45 eb             	mov    -0x15(%ebp),%al
  801304:	88 02                	mov    %al,(%edx)
		start++ ;
  801306:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801309:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80130c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80130f:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801312:	7c c4                	jl     8012d8 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801314:	8b 55 f8             	mov    -0x8(%ebp),%edx
  801317:	8b 45 0c             	mov    0xc(%ebp),%eax
  80131a:	01 d0                	add    %edx,%eax
  80131c:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  80131f:	90                   	nop
  801320:	c9                   	leave  
  801321:	c3                   	ret    

00801322 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801322:	55                   	push   %ebp
  801323:	89 e5                	mov    %esp,%ebp
  801325:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  801328:	ff 75 08             	pushl  0x8(%ebp)
  80132b:	e8 54 fa ff ff       	call   800d84 <strlen>
  801330:	83 c4 04             	add    $0x4,%esp
  801333:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801336:	ff 75 0c             	pushl  0xc(%ebp)
  801339:	e8 46 fa ff ff       	call   800d84 <strlen>
  80133e:	83 c4 04             	add    $0x4,%esp
  801341:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801344:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80134b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801352:	eb 17                	jmp    80136b <strcconcat+0x49>
		final[s] = str1[s] ;
  801354:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801357:	8b 45 10             	mov    0x10(%ebp),%eax
  80135a:	01 c2                	add    %eax,%edx
  80135c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80135f:	8b 45 08             	mov    0x8(%ebp),%eax
  801362:	01 c8                	add    %ecx,%eax
  801364:	8a 00                	mov    (%eax),%al
  801366:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801368:	ff 45 fc             	incl   -0x4(%ebp)
  80136b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80136e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801371:	7c e1                	jl     801354 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801373:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80137a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801381:	eb 1f                	jmp    8013a2 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801383:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801386:	8d 50 01             	lea    0x1(%eax),%edx
  801389:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80138c:	89 c2                	mov    %eax,%edx
  80138e:	8b 45 10             	mov    0x10(%ebp),%eax
  801391:	01 c2                	add    %eax,%edx
  801393:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801396:	8b 45 0c             	mov    0xc(%ebp),%eax
  801399:	01 c8                	add    %ecx,%eax
  80139b:	8a 00                	mov    (%eax),%al
  80139d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80139f:	ff 45 f8             	incl   -0x8(%ebp)
  8013a2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013a5:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013a8:	7c d9                	jl     801383 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013aa:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013ad:	8b 45 10             	mov    0x10(%ebp),%eax
  8013b0:	01 d0                	add    %edx,%eax
  8013b2:	c6 00 00             	movb   $0x0,(%eax)
}
  8013b5:	90                   	nop
  8013b6:	c9                   	leave  
  8013b7:	c3                   	ret    

008013b8 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8013b8:	55                   	push   %ebp
  8013b9:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8013bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8013be:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8013c4:	8b 45 14             	mov    0x14(%ebp),%eax
  8013c7:	8b 00                	mov    (%eax),%eax
  8013c9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8013d0:	8b 45 10             	mov    0x10(%ebp),%eax
  8013d3:	01 d0                	add    %edx,%eax
  8013d5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013db:	eb 0c                	jmp    8013e9 <strsplit+0x31>
			*string++ = 0;
  8013dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013e0:	8d 50 01             	lea    0x1(%eax),%edx
  8013e3:	89 55 08             	mov    %edx,0x8(%ebp)
  8013e6:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8013e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ec:	8a 00                	mov    (%eax),%al
  8013ee:	84 c0                	test   %al,%al
  8013f0:	74 18                	je     80140a <strsplit+0x52>
  8013f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f5:	8a 00                	mov    (%eax),%al
  8013f7:	0f be c0             	movsbl %al,%eax
  8013fa:	50                   	push   %eax
  8013fb:	ff 75 0c             	pushl  0xc(%ebp)
  8013fe:	e8 13 fb ff ff       	call   800f16 <strchr>
  801403:	83 c4 08             	add    $0x8,%esp
  801406:	85 c0                	test   %eax,%eax
  801408:	75 d3                	jne    8013dd <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80140a:	8b 45 08             	mov    0x8(%ebp),%eax
  80140d:	8a 00                	mov    (%eax),%al
  80140f:	84 c0                	test   %al,%al
  801411:	74 5a                	je     80146d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801413:	8b 45 14             	mov    0x14(%ebp),%eax
  801416:	8b 00                	mov    (%eax),%eax
  801418:	83 f8 0f             	cmp    $0xf,%eax
  80141b:	75 07                	jne    801424 <strsplit+0x6c>
		{
			return 0;
  80141d:	b8 00 00 00 00       	mov    $0x0,%eax
  801422:	eb 66                	jmp    80148a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801424:	8b 45 14             	mov    0x14(%ebp),%eax
  801427:	8b 00                	mov    (%eax),%eax
  801429:	8d 48 01             	lea    0x1(%eax),%ecx
  80142c:	8b 55 14             	mov    0x14(%ebp),%edx
  80142f:	89 0a                	mov    %ecx,(%edx)
  801431:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801438:	8b 45 10             	mov    0x10(%ebp),%eax
  80143b:	01 c2                	add    %eax,%edx
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801442:	eb 03                	jmp    801447 <strsplit+0x8f>
			string++;
  801444:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  801447:	8b 45 08             	mov    0x8(%ebp),%eax
  80144a:	8a 00                	mov    (%eax),%al
  80144c:	84 c0                	test   %al,%al
  80144e:	74 8b                	je     8013db <strsplit+0x23>
  801450:	8b 45 08             	mov    0x8(%ebp),%eax
  801453:	8a 00                	mov    (%eax),%al
  801455:	0f be c0             	movsbl %al,%eax
  801458:	50                   	push   %eax
  801459:	ff 75 0c             	pushl  0xc(%ebp)
  80145c:	e8 b5 fa ff ff       	call   800f16 <strchr>
  801461:	83 c4 08             	add    $0x8,%esp
  801464:	85 c0                	test   %eax,%eax
  801466:	74 dc                	je     801444 <strsplit+0x8c>
			string++;
	}
  801468:	e9 6e ff ff ff       	jmp    8013db <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80146d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80146e:	8b 45 14             	mov    0x14(%ebp),%eax
  801471:	8b 00                	mov    (%eax),%eax
  801473:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80147a:	8b 45 10             	mov    0x10(%ebp),%eax
  80147d:	01 d0                	add    %edx,%eax
  80147f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801485:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80148a:	c9                   	leave  
  80148b:	c3                   	ret    

0080148c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80148c:	55                   	push   %ebp
  80148d:	89 e5                	mov    %esp,%ebp
  80148f:	57                   	push   %edi
  801490:	56                   	push   %esi
  801491:	53                   	push   %ebx
  801492:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801495:	8b 45 08             	mov    0x8(%ebp),%eax
  801498:	8b 55 0c             	mov    0xc(%ebp),%edx
  80149b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80149e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014a1:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014a4:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014a7:	cd 30                	int    $0x30
  8014a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8014af:	83 c4 10             	add    $0x10,%esp
  8014b2:	5b                   	pop    %ebx
  8014b3:	5e                   	pop    %esi
  8014b4:	5f                   	pop    %edi
  8014b5:	5d                   	pop    %ebp
  8014b6:	c3                   	ret    

008014b7 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8014b7:	55                   	push   %ebp
  8014b8:	89 e5                	mov    %esp,%ebp
  8014ba:	83 ec 04             	sub    $0x4,%esp
  8014bd:	8b 45 10             	mov    0x10(%ebp),%eax
  8014c0:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014c3:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014c7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	52                   	push   %edx
  8014cf:	ff 75 0c             	pushl  0xc(%ebp)
  8014d2:	50                   	push   %eax
  8014d3:	6a 00                	push   $0x0
  8014d5:	e8 b2 ff ff ff       	call   80148c <syscall>
  8014da:	83 c4 18             	add    $0x18,%esp
}
  8014dd:	90                   	nop
  8014de:	c9                   	leave  
  8014df:	c3                   	ret    

008014e0 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014e0:	55                   	push   %ebp
  8014e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014e3:	6a 00                	push   $0x0
  8014e5:	6a 00                	push   $0x0
  8014e7:	6a 00                	push   $0x0
  8014e9:	6a 00                	push   $0x0
  8014eb:	6a 00                	push   $0x0
  8014ed:	6a 01                	push   $0x1
  8014ef:	e8 98 ff ff ff       	call   80148c <syscall>
  8014f4:	83 c4 18             	add    $0x18,%esp
}
  8014f7:	c9                   	leave  
  8014f8:	c3                   	ret    

008014f9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014f9:	55                   	push   %ebp
  8014fa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8014ff:	6a 00                	push   $0x0
  801501:	6a 00                	push   $0x0
  801503:	6a 00                	push   $0x0
  801505:	6a 00                	push   $0x0
  801507:	50                   	push   %eax
  801508:	6a 05                	push   $0x5
  80150a:	e8 7d ff ff ff       	call   80148c <syscall>
  80150f:	83 c4 18             	add    $0x18,%esp
}
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 02                	push   $0x2
  801523:	e8 64 ff ff ff       	call   80148c <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 03                	push   $0x3
  80153c:	e8 4b ff ff ff       	call   80148c <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 04                	push   $0x4
  801555:	e8 32 ff ff ff       	call   80148c <syscall>
  80155a:	83 c4 18             	add    $0x18,%esp
}
  80155d:	c9                   	leave  
  80155e:	c3                   	ret    

0080155f <sys_env_exit>:


void sys_env_exit(void)
{
  80155f:	55                   	push   %ebp
  801560:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801562:	6a 00                	push   $0x0
  801564:	6a 00                	push   $0x0
  801566:	6a 00                	push   $0x0
  801568:	6a 00                	push   $0x0
  80156a:	6a 00                	push   $0x0
  80156c:	6a 06                	push   $0x6
  80156e:	e8 19 ff ff ff       	call   80148c <syscall>
  801573:	83 c4 18             	add    $0x18,%esp
}
  801576:	90                   	nop
  801577:	c9                   	leave  
  801578:	c3                   	ret    

00801579 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801579:	55                   	push   %ebp
  80157a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80157c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80157f:	8b 45 08             	mov    0x8(%ebp),%eax
  801582:	6a 00                	push   $0x0
  801584:	6a 00                	push   $0x0
  801586:	6a 00                	push   $0x0
  801588:	52                   	push   %edx
  801589:	50                   	push   %eax
  80158a:	6a 07                	push   $0x7
  80158c:	e8 fb fe ff ff       	call   80148c <syscall>
  801591:	83 c4 18             	add    $0x18,%esp
}
  801594:	c9                   	leave  
  801595:	c3                   	ret    

00801596 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801596:	55                   	push   %ebp
  801597:	89 e5                	mov    %esp,%ebp
  801599:	56                   	push   %esi
  80159a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80159b:	8b 75 18             	mov    0x18(%ebp),%esi
  80159e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015a4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8015aa:	56                   	push   %esi
  8015ab:	53                   	push   %ebx
  8015ac:	51                   	push   %ecx
  8015ad:	52                   	push   %edx
  8015ae:	50                   	push   %eax
  8015af:	6a 08                	push   $0x8
  8015b1:	e8 d6 fe ff ff       	call   80148c <syscall>
  8015b6:	83 c4 18             	add    $0x18,%esp
}
  8015b9:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015bc:	5b                   	pop    %ebx
  8015bd:	5e                   	pop    %esi
  8015be:	5d                   	pop    %ebp
  8015bf:	c3                   	ret    

008015c0 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015c0:	55                   	push   %ebp
  8015c1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	6a 00                	push   $0x0
  8015cf:	52                   	push   %edx
  8015d0:	50                   	push   %eax
  8015d1:	6a 09                	push   $0x9
  8015d3:	e8 b4 fe ff ff       	call   80148c <syscall>
  8015d8:	83 c4 18             	add    $0x18,%esp
}
  8015db:	c9                   	leave  
  8015dc:	c3                   	ret    

008015dd <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015dd:	55                   	push   %ebp
  8015de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015e0:	6a 00                	push   $0x0
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	ff 75 0c             	pushl  0xc(%ebp)
  8015e9:	ff 75 08             	pushl  0x8(%ebp)
  8015ec:	6a 0a                	push   $0xa
  8015ee:	e8 99 fe ff ff       	call   80148c <syscall>
  8015f3:	83 c4 18             	add    $0x18,%esp
}
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 0b                	push   $0xb
  801607:	e8 80 fe ff ff       	call   80148c <syscall>
  80160c:	83 c4 18             	add    $0x18,%esp
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 0c                	push   $0xc
  801620:	e8 67 fe ff ff       	call   80148c <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
}
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 0d                	push   $0xd
  801639:	e8 4e fe ff ff       	call   80148c <syscall>
  80163e:	83 c4 18             	add    $0x18,%esp
}
  801641:	c9                   	leave  
  801642:	c3                   	ret    

00801643 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801643:	55                   	push   %ebp
  801644:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801646:	6a 00                	push   $0x0
  801648:	6a 00                	push   $0x0
  80164a:	6a 00                	push   $0x0
  80164c:	ff 75 0c             	pushl  0xc(%ebp)
  80164f:	ff 75 08             	pushl  0x8(%ebp)
  801652:	6a 11                	push   $0x11
  801654:	e8 33 fe ff ff       	call   80148c <syscall>
  801659:	83 c4 18             	add    $0x18,%esp
	return;
  80165c:	90                   	nop
}
  80165d:	c9                   	leave  
  80165e:	c3                   	ret    

0080165f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80165f:	55                   	push   %ebp
  801660:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801662:	6a 00                	push   $0x0
  801664:	6a 00                	push   $0x0
  801666:	6a 00                	push   $0x0
  801668:	ff 75 0c             	pushl  0xc(%ebp)
  80166b:	ff 75 08             	pushl  0x8(%ebp)
  80166e:	6a 12                	push   $0x12
  801670:	e8 17 fe ff ff       	call   80148c <syscall>
  801675:	83 c4 18             	add    $0x18,%esp
	return ;
  801678:	90                   	nop
}
  801679:	c9                   	leave  
  80167a:	c3                   	ret    

0080167b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80167b:	55                   	push   %ebp
  80167c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 0e                	push   $0xe
  80168a:	e8 fd fd ff ff       	call   80148c <syscall>
  80168f:	83 c4 18             	add    $0x18,%esp
}
  801692:	c9                   	leave  
  801693:	c3                   	ret    

00801694 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801694:	55                   	push   %ebp
  801695:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	ff 75 08             	pushl  0x8(%ebp)
  8016a2:	6a 0f                	push   $0xf
  8016a4:	e8 e3 fd ff ff       	call   80148c <syscall>
  8016a9:	83 c4 18             	add    $0x18,%esp
}
  8016ac:	c9                   	leave  
  8016ad:	c3                   	ret    

008016ae <sys_scarce_memory>:

void sys_scarce_memory()
{
  8016ae:	55                   	push   %ebp
  8016af:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8016b1:	6a 00                	push   $0x0
  8016b3:	6a 00                	push   $0x0
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	6a 10                	push   $0x10
  8016bd:	e8 ca fd ff ff       	call   80148c <syscall>
  8016c2:	83 c4 18             	add    $0x18,%esp
}
  8016c5:	90                   	nop
  8016c6:	c9                   	leave  
  8016c7:	c3                   	ret    

008016c8 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8016c8:	55                   	push   %ebp
  8016c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8016cb:	6a 00                	push   $0x0
  8016cd:	6a 00                	push   $0x0
  8016cf:	6a 00                	push   $0x0
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 14                	push   $0x14
  8016d7:	e8 b0 fd ff ff       	call   80148c <syscall>
  8016dc:	83 c4 18             	add    $0x18,%esp
}
  8016df:	90                   	nop
  8016e0:	c9                   	leave  
  8016e1:	c3                   	ret    

008016e2 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8016e2:	55                   	push   %ebp
  8016e3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016e5:	6a 00                	push   $0x0
  8016e7:	6a 00                	push   $0x0
  8016e9:	6a 00                	push   $0x0
  8016eb:	6a 00                	push   $0x0
  8016ed:	6a 00                	push   $0x0
  8016ef:	6a 15                	push   $0x15
  8016f1:	e8 96 fd ff ff       	call   80148c <syscall>
  8016f6:	83 c4 18             	add    $0x18,%esp
}
  8016f9:	90                   	nop
  8016fa:	c9                   	leave  
  8016fb:	c3                   	ret    

008016fc <sys_cputc>:


void
sys_cputc(const char c)
{
  8016fc:	55                   	push   %ebp
  8016fd:	89 e5                	mov    %esp,%ebp
  8016ff:	83 ec 04             	sub    $0x4,%esp
  801702:	8b 45 08             	mov    0x8(%ebp),%eax
  801705:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  801708:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	50                   	push   %eax
  801715:	6a 16                	push   $0x16
  801717:	e8 70 fd ff ff       	call   80148c <syscall>
  80171c:	83 c4 18             	add    $0x18,%esp
}
  80171f:	90                   	nop
  801720:	c9                   	leave  
  801721:	c3                   	ret    

00801722 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801722:	55                   	push   %ebp
  801723:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801725:	6a 00                	push   $0x0
  801727:	6a 00                	push   $0x0
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	6a 17                	push   $0x17
  801731:	e8 56 fd ff ff       	call   80148c <syscall>
  801736:	83 c4 18             	add    $0x18,%esp
}
  801739:	90                   	nop
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  80173f:	8b 45 08             	mov    0x8(%ebp),%eax
  801742:	6a 00                	push   $0x0
  801744:	6a 00                	push   $0x0
  801746:	6a 00                	push   $0x0
  801748:	ff 75 0c             	pushl  0xc(%ebp)
  80174b:	50                   	push   %eax
  80174c:	6a 18                	push   $0x18
  80174e:	e8 39 fd ff ff       	call   80148c <syscall>
  801753:	83 c4 18             	add    $0x18,%esp
}
  801756:	c9                   	leave  
  801757:	c3                   	ret    

00801758 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801758:	55                   	push   %ebp
  801759:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80175b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80175e:	8b 45 08             	mov    0x8(%ebp),%eax
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	52                   	push   %edx
  801768:	50                   	push   %eax
  801769:	6a 1b                	push   $0x1b
  80176b:	e8 1c fd ff ff       	call   80148c <syscall>
  801770:	83 c4 18             	add    $0x18,%esp
}
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801778:	8b 55 0c             	mov    0xc(%ebp),%edx
  80177b:	8b 45 08             	mov    0x8(%ebp),%eax
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 00                	push   $0x0
  801784:	52                   	push   %edx
  801785:	50                   	push   %eax
  801786:	6a 19                	push   $0x19
  801788:	e8 ff fc ff ff       	call   80148c <syscall>
  80178d:	83 c4 18             	add    $0x18,%esp
}
  801790:	90                   	nop
  801791:	c9                   	leave  
  801792:	c3                   	ret    

00801793 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801793:	55                   	push   %ebp
  801794:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801796:	8b 55 0c             	mov    0xc(%ebp),%edx
  801799:	8b 45 08             	mov    0x8(%ebp),%eax
  80179c:	6a 00                	push   $0x0
  80179e:	6a 00                	push   $0x0
  8017a0:	6a 00                	push   $0x0
  8017a2:	52                   	push   %edx
  8017a3:	50                   	push   %eax
  8017a4:	6a 1a                	push   $0x1a
  8017a6:	e8 e1 fc ff ff       	call   80148c <syscall>
  8017ab:	83 c4 18             	add    $0x18,%esp
}
  8017ae:	90                   	nop
  8017af:	c9                   	leave  
  8017b0:	c3                   	ret    

008017b1 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8017b1:	55                   	push   %ebp
  8017b2:	89 e5                	mov    %esp,%ebp
  8017b4:	83 ec 04             	sub    $0x4,%esp
  8017b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8017ba:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017bd:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017c0:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017c4:	8b 45 08             	mov    0x8(%ebp),%eax
  8017c7:	6a 00                	push   $0x0
  8017c9:	51                   	push   %ecx
  8017ca:	52                   	push   %edx
  8017cb:	ff 75 0c             	pushl  0xc(%ebp)
  8017ce:	50                   	push   %eax
  8017cf:	6a 1c                	push   $0x1c
  8017d1:	e8 b6 fc ff ff       	call   80148c <syscall>
  8017d6:	83 c4 18             	add    $0x18,%esp
}
  8017d9:	c9                   	leave  
  8017da:	c3                   	ret    

008017db <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8017db:	55                   	push   %ebp
  8017dc:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8017de:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	52                   	push   %edx
  8017eb:	50                   	push   %eax
  8017ec:	6a 1d                	push   $0x1d
  8017ee:	e8 99 fc ff ff       	call   80148c <syscall>
  8017f3:	83 c4 18             	add    $0x18,%esp
}
  8017f6:	c9                   	leave  
  8017f7:	c3                   	ret    

008017f8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017f8:	55                   	push   %ebp
  8017f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017fb:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017fe:	8b 55 0c             	mov    0xc(%ebp),%edx
  801801:	8b 45 08             	mov    0x8(%ebp),%eax
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	51                   	push   %ecx
  801809:	52                   	push   %edx
  80180a:	50                   	push   %eax
  80180b:	6a 1e                	push   $0x1e
  80180d:	e8 7a fc ff ff       	call   80148c <syscall>
  801812:	83 c4 18             	add    $0x18,%esp
}
  801815:	c9                   	leave  
  801816:	c3                   	ret    

00801817 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801817:	55                   	push   %ebp
  801818:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80181a:	8b 55 0c             	mov    0xc(%ebp),%edx
  80181d:	8b 45 08             	mov    0x8(%ebp),%eax
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	52                   	push   %edx
  801827:	50                   	push   %eax
  801828:	6a 1f                	push   $0x1f
  80182a:	e8 5d fc ff ff       	call   80148c <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	6a 00                	push   $0x0
  80183f:	6a 00                	push   $0x0
  801841:	6a 20                	push   $0x20
  801843:	e8 44 fc ff ff       	call   80148c <syscall>
  801848:	83 c4 18             	add    $0x18,%esp
}
  80184b:	c9                   	leave  
  80184c:	c3                   	ret    

0080184d <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  80184d:	55                   	push   %ebp
  80184e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801850:	8b 45 08             	mov    0x8(%ebp),%eax
  801853:	6a 00                	push   $0x0
  801855:	ff 75 14             	pushl  0x14(%ebp)
  801858:	ff 75 10             	pushl  0x10(%ebp)
  80185b:	ff 75 0c             	pushl  0xc(%ebp)
  80185e:	50                   	push   %eax
  80185f:	6a 21                	push   $0x21
  801861:	e8 26 fc ff ff       	call   80148c <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	c9                   	leave  
  80186a:	c3                   	ret    

0080186b <sys_run_env>:


void
sys_run_env(int32 envId)
{
  80186b:	55                   	push   %ebp
  80186c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  80186e:	8b 45 08             	mov    0x8(%ebp),%eax
  801871:	6a 00                	push   $0x0
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	50                   	push   %eax
  80187a:	6a 22                	push   $0x22
  80187c:	e8 0b fc ff ff       	call   80148c <syscall>
  801881:	83 c4 18             	add    $0x18,%esp
}
  801884:	90                   	nop
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  80188a:	8b 45 08             	mov    0x8(%ebp),%eax
  80188d:	6a 00                	push   $0x0
  80188f:	6a 00                	push   $0x0
  801891:	6a 00                	push   $0x0
  801893:	6a 00                	push   $0x0
  801895:	50                   	push   %eax
  801896:	6a 23                	push   $0x23
  801898:	e8 ef fb ff ff       	call   80148c <syscall>
  80189d:	83 c4 18             	add    $0x18,%esp
}
  8018a0:	90                   	nop
  8018a1:	c9                   	leave  
  8018a2:	c3                   	ret    

008018a3 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018a3:	55                   	push   %ebp
  8018a4:	89 e5                	mov    %esp,%ebp
  8018a6:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018a9:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018ac:	8d 50 04             	lea    0x4(%eax),%edx
  8018af:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018b2:	6a 00                	push   $0x0
  8018b4:	6a 00                	push   $0x0
  8018b6:	6a 00                	push   $0x0
  8018b8:	52                   	push   %edx
  8018b9:	50                   	push   %eax
  8018ba:	6a 24                	push   $0x24
  8018bc:	e8 cb fb ff ff       	call   80148c <syscall>
  8018c1:	83 c4 18             	add    $0x18,%esp
	return result;
  8018c4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018ca:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018cd:	89 01                	mov    %eax,(%ecx)
  8018cf:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8018d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d5:	c9                   	leave  
  8018d6:	c2 04 00             	ret    $0x4

008018d9 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8018d9:	55                   	push   %ebp
  8018da:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8018dc:	6a 00                	push   $0x0
  8018de:	6a 00                	push   $0x0
  8018e0:	ff 75 10             	pushl  0x10(%ebp)
  8018e3:	ff 75 0c             	pushl  0xc(%ebp)
  8018e6:	ff 75 08             	pushl  0x8(%ebp)
  8018e9:	6a 13                	push   $0x13
  8018eb:	e8 9c fb ff ff       	call   80148c <syscall>
  8018f0:	83 c4 18             	add    $0x18,%esp
	return ;
  8018f3:	90                   	nop
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_rcr2>:
uint32 sys_rcr2()
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018f9:	6a 00                	push   $0x0
  8018fb:	6a 00                	push   $0x0
  8018fd:	6a 00                	push   $0x0
  8018ff:	6a 00                	push   $0x0
  801901:	6a 00                	push   $0x0
  801903:	6a 25                	push   $0x25
  801905:	e8 82 fb ff ff       	call   80148c <syscall>
  80190a:	83 c4 18             	add    $0x18,%esp
}
  80190d:	c9                   	leave  
  80190e:	c3                   	ret    

0080190f <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  80190f:	55                   	push   %ebp
  801910:	89 e5                	mov    %esp,%ebp
  801912:	83 ec 04             	sub    $0x4,%esp
  801915:	8b 45 08             	mov    0x8(%ebp),%eax
  801918:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80191b:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	50                   	push   %eax
  801928:	6a 26                	push   $0x26
  80192a:	e8 5d fb ff ff       	call   80148c <syscall>
  80192f:	83 c4 18             	add    $0x18,%esp
	return ;
  801932:	90                   	nop
}
  801933:	c9                   	leave  
  801934:	c3                   	ret    

00801935 <rsttst>:
void rsttst()
{
  801935:	55                   	push   %ebp
  801936:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801938:	6a 00                	push   $0x0
  80193a:	6a 00                	push   $0x0
  80193c:	6a 00                	push   $0x0
  80193e:	6a 00                	push   $0x0
  801940:	6a 00                	push   $0x0
  801942:	6a 28                	push   $0x28
  801944:	e8 43 fb ff ff       	call   80148c <syscall>
  801949:	83 c4 18             	add    $0x18,%esp
	return ;
  80194c:	90                   	nop
}
  80194d:	c9                   	leave  
  80194e:	c3                   	ret    

0080194f <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  80194f:	55                   	push   %ebp
  801950:	89 e5                	mov    %esp,%ebp
  801952:	83 ec 04             	sub    $0x4,%esp
  801955:	8b 45 14             	mov    0x14(%ebp),%eax
  801958:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  80195b:	8b 55 18             	mov    0x18(%ebp),%edx
  80195e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801962:	52                   	push   %edx
  801963:	50                   	push   %eax
  801964:	ff 75 10             	pushl  0x10(%ebp)
  801967:	ff 75 0c             	pushl  0xc(%ebp)
  80196a:	ff 75 08             	pushl  0x8(%ebp)
  80196d:	6a 27                	push   $0x27
  80196f:	e8 18 fb ff ff       	call   80148c <syscall>
  801974:	83 c4 18             	add    $0x18,%esp
	return ;
  801977:	90                   	nop
}
  801978:	c9                   	leave  
  801979:	c3                   	ret    

0080197a <chktst>:
void chktst(uint32 n)
{
  80197a:	55                   	push   %ebp
  80197b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	ff 75 08             	pushl  0x8(%ebp)
  801988:	6a 29                	push   $0x29
  80198a:	e8 fd fa ff ff       	call   80148c <syscall>
  80198f:	83 c4 18             	add    $0x18,%esp
	return ;
  801992:	90                   	nop
}
  801993:	c9                   	leave  
  801994:	c3                   	ret    

00801995 <inctst>:

void inctst()
{
  801995:	55                   	push   %ebp
  801996:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801998:	6a 00                	push   $0x0
  80199a:	6a 00                	push   $0x0
  80199c:	6a 00                	push   $0x0
  80199e:	6a 00                	push   $0x0
  8019a0:	6a 00                	push   $0x0
  8019a2:	6a 2a                	push   $0x2a
  8019a4:	e8 e3 fa ff ff       	call   80148c <syscall>
  8019a9:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ac:	90                   	nop
}
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <gettst>:
uint32 gettst()
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8019b2:	6a 00                	push   $0x0
  8019b4:	6a 00                	push   $0x0
  8019b6:	6a 00                	push   $0x0
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 2b                	push   $0x2b
  8019be:	e8 c9 fa ff ff       	call   80148c <syscall>
  8019c3:	83 c4 18             	add    $0x18,%esp
}
  8019c6:	c9                   	leave  
  8019c7:	c3                   	ret    

008019c8 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8019c8:	55                   	push   %ebp
  8019c9:	89 e5                	mov    %esp,%ebp
  8019cb:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ce:	6a 00                	push   $0x0
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	6a 2c                	push   $0x2c
  8019da:	e8 ad fa ff ff       	call   80148c <syscall>
  8019df:	83 c4 18             	add    $0x18,%esp
  8019e2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019e5:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019e9:	75 07                	jne    8019f2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019eb:	b8 01 00 00 00       	mov    $0x1,%eax
  8019f0:	eb 05                	jmp    8019f7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019f2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019f7:	c9                   	leave  
  8019f8:	c3                   	ret    

008019f9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019f9:	55                   	push   %ebp
  8019fa:	89 e5                	mov    %esp,%ebp
  8019fc:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019ff:	6a 00                	push   $0x0
  801a01:	6a 00                	push   $0x0
  801a03:	6a 00                	push   $0x0
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 2c                	push   $0x2c
  801a0b:	e8 7c fa ff ff       	call   80148c <syscall>
  801a10:	83 c4 18             	add    $0x18,%esp
  801a13:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a16:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a1a:	75 07                	jne    801a23 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a1c:	b8 01 00 00 00       	mov    $0x1,%eax
  801a21:	eb 05                	jmp    801a28 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a23:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a28:	c9                   	leave  
  801a29:	c3                   	ret    

00801a2a <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a2a:	55                   	push   %ebp
  801a2b:	89 e5                	mov    %esp,%ebp
  801a2d:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	6a 00                	push   $0x0
  801a36:	6a 00                	push   $0x0
  801a38:	6a 00                	push   $0x0
  801a3a:	6a 2c                	push   $0x2c
  801a3c:	e8 4b fa ff ff       	call   80148c <syscall>
  801a41:	83 c4 18             	add    $0x18,%esp
  801a44:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a47:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a4b:	75 07                	jne    801a54 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a4d:	b8 01 00 00 00       	mov    $0x1,%eax
  801a52:	eb 05                	jmp    801a59 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a54:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a59:	c9                   	leave  
  801a5a:	c3                   	ret    

00801a5b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a5b:	55                   	push   %ebp
  801a5c:	89 e5                	mov    %esp,%ebp
  801a5e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a61:	6a 00                	push   $0x0
  801a63:	6a 00                	push   $0x0
  801a65:	6a 00                	push   $0x0
  801a67:	6a 00                	push   $0x0
  801a69:	6a 00                	push   $0x0
  801a6b:	6a 2c                	push   $0x2c
  801a6d:	e8 1a fa ff ff       	call   80148c <syscall>
  801a72:	83 c4 18             	add    $0x18,%esp
  801a75:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a78:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a7c:	75 07                	jne    801a85 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a7e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a83:	eb 05                	jmp    801a8a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a85:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a8a:	c9                   	leave  
  801a8b:	c3                   	ret    

00801a8c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a8c:	55                   	push   %ebp
  801a8d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a8f:	6a 00                	push   $0x0
  801a91:	6a 00                	push   $0x0
  801a93:	6a 00                	push   $0x0
  801a95:	6a 00                	push   $0x0
  801a97:	ff 75 08             	pushl  0x8(%ebp)
  801a9a:	6a 2d                	push   $0x2d
  801a9c:	e8 eb f9 ff ff       	call   80148c <syscall>
  801aa1:	83 c4 18             	add    $0x18,%esp
	return ;
  801aa4:	90                   	nop
}
  801aa5:	c9                   	leave  
  801aa6:	c3                   	ret    

00801aa7 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801aa7:	55                   	push   %ebp
  801aa8:	89 e5                	mov    %esp,%ebp
  801aaa:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801aab:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801aae:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801ab1:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab7:	6a 00                	push   $0x0
  801ab9:	53                   	push   %ebx
  801aba:	51                   	push   %ecx
  801abb:	52                   	push   %edx
  801abc:	50                   	push   %eax
  801abd:	6a 2e                	push   $0x2e
  801abf:	e8 c8 f9 ff ff       	call   80148c <syscall>
  801ac4:	83 c4 18             	add    $0x18,%esp
}
  801ac7:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801aca:	c9                   	leave  
  801acb:	c3                   	ret    

00801acc <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801acc:	55                   	push   %ebp
  801acd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801acf:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ad2:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	6a 00                	push   $0x0
  801adb:	52                   	push   %edx
  801adc:	50                   	push   %eax
  801add:	6a 2f                	push   $0x2f
  801adf:	e8 a8 f9 ff ff       	call   80148c <syscall>
  801ae4:	83 c4 18             	add    $0x18,%esp
}
  801ae7:	c9                   	leave  
  801ae8:	c3                   	ret    

00801ae9 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801ae9:	55                   	push   %ebp
  801aea:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801aec:	6a 00                	push   $0x0
  801aee:	6a 00                	push   $0x0
  801af0:	6a 00                	push   $0x0
  801af2:	ff 75 0c             	pushl  0xc(%ebp)
  801af5:	ff 75 08             	pushl  0x8(%ebp)
  801af8:	6a 30                	push   $0x30
  801afa:	e8 8d f9 ff ff       	call   80148c <syscall>
  801aff:	83 c4 18             	add    $0x18,%esp
	return ;
  801b02:	90                   	nop
}
  801b03:	c9                   	leave  
  801b04:	c3                   	ret    
  801b05:	66 90                	xchg   %ax,%ax
  801b07:	90                   	nop

00801b08 <__udivdi3>:
  801b08:	55                   	push   %ebp
  801b09:	57                   	push   %edi
  801b0a:	56                   	push   %esi
  801b0b:	53                   	push   %ebx
  801b0c:	83 ec 1c             	sub    $0x1c,%esp
  801b0f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b13:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b17:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b1b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b1f:	89 ca                	mov    %ecx,%edx
  801b21:	89 f8                	mov    %edi,%eax
  801b23:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b27:	85 f6                	test   %esi,%esi
  801b29:	75 2d                	jne    801b58 <__udivdi3+0x50>
  801b2b:	39 cf                	cmp    %ecx,%edi
  801b2d:	77 65                	ja     801b94 <__udivdi3+0x8c>
  801b2f:	89 fd                	mov    %edi,%ebp
  801b31:	85 ff                	test   %edi,%edi
  801b33:	75 0b                	jne    801b40 <__udivdi3+0x38>
  801b35:	b8 01 00 00 00       	mov    $0x1,%eax
  801b3a:	31 d2                	xor    %edx,%edx
  801b3c:	f7 f7                	div    %edi
  801b3e:	89 c5                	mov    %eax,%ebp
  801b40:	31 d2                	xor    %edx,%edx
  801b42:	89 c8                	mov    %ecx,%eax
  801b44:	f7 f5                	div    %ebp
  801b46:	89 c1                	mov    %eax,%ecx
  801b48:	89 d8                	mov    %ebx,%eax
  801b4a:	f7 f5                	div    %ebp
  801b4c:	89 cf                	mov    %ecx,%edi
  801b4e:	89 fa                	mov    %edi,%edx
  801b50:	83 c4 1c             	add    $0x1c,%esp
  801b53:	5b                   	pop    %ebx
  801b54:	5e                   	pop    %esi
  801b55:	5f                   	pop    %edi
  801b56:	5d                   	pop    %ebp
  801b57:	c3                   	ret    
  801b58:	39 ce                	cmp    %ecx,%esi
  801b5a:	77 28                	ja     801b84 <__udivdi3+0x7c>
  801b5c:	0f bd fe             	bsr    %esi,%edi
  801b5f:	83 f7 1f             	xor    $0x1f,%edi
  801b62:	75 40                	jne    801ba4 <__udivdi3+0x9c>
  801b64:	39 ce                	cmp    %ecx,%esi
  801b66:	72 0a                	jb     801b72 <__udivdi3+0x6a>
  801b68:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b6c:	0f 87 9e 00 00 00    	ja     801c10 <__udivdi3+0x108>
  801b72:	b8 01 00 00 00       	mov    $0x1,%eax
  801b77:	89 fa                	mov    %edi,%edx
  801b79:	83 c4 1c             	add    $0x1c,%esp
  801b7c:	5b                   	pop    %ebx
  801b7d:	5e                   	pop    %esi
  801b7e:	5f                   	pop    %edi
  801b7f:	5d                   	pop    %ebp
  801b80:	c3                   	ret    
  801b81:	8d 76 00             	lea    0x0(%esi),%esi
  801b84:	31 ff                	xor    %edi,%edi
  801b86:	31 c0                	xor    %eax,%eax
  801b88:	89 fa                	mov    %edi,%edx
  801b8a:	83 c4 1c             	add    $0x1c,%esp
  801b8d:	5b                   	pop    %ebx
  801b8e:	5e                   	pop    %esi
  801b8f:	5f                   	pop    %edi
  801b90:	5d                   	pop    %ebp
  801b91:	c3                   	ret    
  801b92:	66 90                	xchg   %ax,%ax
  801b94:	89 d8                	mov    %ebx,%eax
  801b96:	f7 f7                	div    %edi
  801b98:	31 ff                	xor    %edi,%edi
  801b9a:	89 fa                	mov    %edi,%edx
  801b9c:	83 c4 1c             	add    $0x1c,%esp
  801b9f:	5b                   	pop    %ebx
  801ba0:	5e                   	pop    %esi
  801ba1:	5f                   	pop    %edi
  801ba2:	5d                   	pop    %ebp
  801ba3:	c3                   	ret    
  801ba4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801ba9:	89 eb                	mov    %ebp,%ebx
  801bab:	29 fb                	sub    %edi,%ebx
  801bad:	89 f9                	mov    %edi,%ecx
  801baf:	d3 e6                	shl    %cl,%esi
  801bb1:	89 c5                	mov    %eax,%ebp
  801bb3:	88 d9                	mov    %bl,%cl
  801bb5:	d3 ed                	shr    %cl,%ebp
  801bb7:	89 e9                	mov    %ebp,%ecx
  801bb9:	09 f1                	or     %esi,%ecx
  801bbb:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801bbf:	89 f9                	mov    %edi,%ecx
  801bc1:	d3 e0                	shl    %cl,%eax
  801bc3:	89 c5                	mov    %eax,%ebp
  801bc5:	89 d6                	mov    %edx,%esi
  801bc7:	88 d9                	mov    %bl,%cl
  801bc9:	d3 ee                	shr    %cl,%esi
  801bcb:	89 f9                	mov    %edi,%ecx
  801bcd:	d3 e2                	shl    %cl,%edx
  801bcf:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bd3:	88 d9                	mov    %bl,%cl
  801bd5:	d3 e8                	shr    %cl,%eax
  801bd7:	09 c2                	or     %eax,%edx
  801bd9:	89 d0                	mov    %edx,%eax
  801bdb:	89 f2                	mov    %esi,%edx
  801bdd:	f7 74 24 0c          	divl   0xc(%esp)
  801be1:	89 d6                	mov    %edx,%esi
  801be3:	89 c3                	mov    %eax,%ebx
  801be5:	f7 e5                	mul    %ebp
  801be7:	39 d6                	cmp    %edx,%esi
  801be9:	72 19                	jb     801c04 <__udivdi3+0xfc>
  801beb:	74 0b                	je     801bf8 <__udivdi3+0xf0>
  801bed:	89 d8                	mov    %ebx,%eax
  801bef:	31 ff                	xor    %edi,%edi
  801bf1:	e9 58 ff ff ff       	jmp    801b4e <__udivdi3+0x46>
  801bf6:	66 90                	xchg   %ax,%ax
  801bf8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801bfc:	89 f9                	mov    %edi,%ecx
  801bfe:	d3 e2                	shl    %cl,%edx
  801c00:	39 c2                	cmp    %eax,%edx
  801c02:	73 e9                	jae    801bed <__udivdi3+0xe5>
  801c04:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c07:	31 ff                	xor    %edi,%edi
  801c09:	e9 40 ff ff ff       	jmp    801b4e <__udivdi3+0x46>
  801c0e:	66 90                	xchg   %ax,%ax
  801c10:	31 c0                	xor    %eax,%eax
  801c12:	e9 37 ff ff ff       	jmp    801b4e <__udivdi3+0x46>
  801c17:	90                   	nop

00801c18 <__umoddi3>:
  801c18:	55                   	push   %ebp
  801c19:	57                   	push   %edi
  801c1a:	56                   	push   %esi
  801c1b:	53                   	push   %ebx
  801c1c:	83 ec 1c             	sub    $0x1c,%esp
  801c1f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c23:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c27:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c2b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c2f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c33:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c37:	89 f3                	mov    %esi,%ebx
  801c39:	89 fa                	mov    %edi,%edx
  801c3b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c3f:	89 34 24             	mov    %esi,(%esp)
  801c42:	85 c0                	test   %eax,%eax
  801c44:	75 1a                	jne    801c60 <__umoddi3+0x48>
  801c46:	39 f7                	cmp    %esi,%edi
  801c48:	0f 86 a2 00 00 00    	jbe    801cf0 <__umoddi3+0xd8>
  801c4e:	89 c8                	mov    %ecx,%eax
  801c50:	89 f2                	mov    %esi,%edx
  801c52:	f7 f7                	div    %edi
  801c54:	89 d0                	mov    %edx,%eax
  801c56:	31 d2                	xor    %edx,%edx
  801c58:	83 c4 1c             	add    $0x1c,%esp
  801c5b:	5b                   	pop    %ebx
  801c5c:	5e                   	pop    %esi
  801c5d:	5f                   	pop    %edi
  801c5e:	5d                   	pop    %ebp
  801c5f:	c3                   	ret    
  801c60:	39 f0                	cmp    %esi,%eax
  801c62:	0f 87 ac 00 00 00    	ja     801d14 <__umoddi3+0xfc>
  801c68:	0f bd e8             	bsr    %eax,%ebp
  801c6b:	83 f5 1f             	xor    $0x1f,%ebp
  801c6e:	0f 84 ac 00 00 00    	je     801d20 <__umoddi3+0x108>
  801c74:	bf 20 00 00 00       	mov    $0x20,%edi
  801c79:	29 ef                	sub    %ebp,%edi
  801c7b:	89 fe                	mov    %edi,%esi
  801c7d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c81:	89 e9                	mov    %ebp,%ecx
  801c83:	d3 e0                	shl    %cl,%eax
  801c85:	89 d7                	mov    %edx,%edi
  801c87:	89 f1                	mov    %esi,%ecx
  801c89:	d3 ef                	shr    %cl,%edi
  801c8b:	09 c7                	or     %eax,%edi
  801c8d:	89 e9                	mov    %ebp,%ecx
  801c8f:	d3 e2                	shl    %cl,%edx
  801c91:	89 14 24             	mov    %edx,(%esp)
  801c94:	89 d8                	mov    %ebx,%eax
  801c96:	d3 e0                	shl    %cl,%eax
  801c98:	89 c2                	mov    %eax,%edx
  801c9a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c9e:	d3 e0                	shl    %cl,%eax
  801ca0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801ca4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ca8:	89 f1                	mov    %esi,%ecx
  801caa:	d3 e8                	shr    %cl,%eax
  801cac:	09 d0                	or     %edx,%eax
  801cae:	d3 eb                	shr    %cl,%ebx
  801cb0:	89 da                	mov    %ebx,%edx
  801cb2:	f7 f7                	div    %edi
  801cb4:	89 d3                	mov    %edx,%ebx
  801cb6:	f7 24 24             	mull   (%esp)
  801cb9:	89 c6                	mov    %eax,%esi
  801cbb:	89 d1                	mov    %edx,%ecx
  801cbd:	39 d3                	cmp    %edx,%ebx
  801cbf:	0f 82 87 00 00 00    	jb     801d4c <__umoddi3+0x134>
  801cc5:	0f 84 91 00 00 00    	je     801d5c <__umoddi3+0x144>
  801ccb:	8b 54 24 04          	mov    0x4(%esp),%edx
  801ccf:	29 f2                	sub    %esi,%edx
  801cd1:	19 cb                	sbb    %ecx,%ebx
  801cd3:	89 d8                	mov    %ebx,%eax
  801cd5:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cd9:	d3 e0                	shl    %cl,%eax
  801cdb:	89 e9                	mov    %ebp,%ecx
  801cdd:	d3 ea                	shr    %cl,%edx
  801cdf:	09 d0                	or     %edx,%eax
  801ce1:	89 e9                	mov    %ebp,%ecx
  801ce3:	d3 eb                	shr    %cl,%ebx
  801ce5:	89 da                	mov    %ebx,%edx
  801ce7:	83 c4 1c             	add    $0x1c,%esp
  801cea:	5b                   	pop    %ebx
  801ceb:	5e                   	pop    %esi
  801cec:	5f                   	pop    %edi
  801ced:	5d                   	pop    %ebp
  801cee:	c3                   	ret    
  801cef:	90                   	nop
  801cf0:	89 fd                	mov    %edi,%ebp
  801cf2:	85 ff                	test   %edi,%edi
  801cf4:	75 0b                	jne    801d01 <__umoddi3+0xe9>
  801cf6:	b8 01 00 00 00       	mov    $0x1,%eax
  801cfb:	31 d2                	xor    %edx,%edx
  801cfd:	f7 f7                	div    %edi
  801cff:	89 c5                	mov    %eax,%ebp
  801d01:	89 f0                	mov    %esi,%eax
  801d03:	31 d2                	xor    %edx,%edx
  801d05:	f7 f5                	div    %ebp
  801d07:	89 c8                	mov    %ecx,%eax
  801d09:	f7 f5                	div    %ebp
  801d0b:	89 d0                	mov    %edx,%eax
  801d0d:	e9 44 ff ff ff       	jmp    801c56 <__umoddi3+0x3e>
  801d12:	66 90                	xchg   %ax,%ax
  801d14:	89 c8                	mov    %ecx,%eax
  801d16:	89 f2                	mov    %esi,%edx
  801d18:	83 c4 1c             	add    $0x1c,%esp
  801d1b:	5b                   	pop    %ebx
  801d1c:	5e                   	pop    %esi
  801d1d:	5f                   	pop    %edi
  801d1e:	5d                   	pop    %ebp
  801d1f:	c3                   	ret    
  801d20:	3b 04 24             	cmp    (%esp),%eax
  801d23:	72 06                	jb     801d2b <__umoddi3+0x113>
  801d25:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d29:	77 0f                	ja     801d3a <__umoddi3+0x122>
  801d2b:	89 f2                	mov    %esi,%edx
  801d2d:	29 f9                	sub    %edi,%ecx
  801d2f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d33:	89 14 24             	mov    %edx,(%esp)
  801d36:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d3a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d3e:	8b 14 24             	mov    (%esp),%edx
  801d41:	83 c4 1c             	add    $0x1c,%esp
  801d44:	5b                   	pop    %ebx
  801d45:	5e                   	pop    %esi
  801d46:	5f                   	pop    %edi
  801d47:	5d                   	pop    %ebp
  801d48:	c3                   	ret    
  801d49:	8d 76 00             	lea    0x0(%esi),%esi
  801d4c:	2b 04 24             	sub    (%esp),%eax
  801d4f:	19 fa                	sbb    %edi,%edx
  801d51:	89 d1                	mov    %edx,%ecx
  801d53:	89 c6                	mov    %eax,%esi
  801d55:	e9 71 ff ff ff       	jmp    801ccb <__umoddi3+0xb3>
  801d5a:	66 90                	xchg   %ax,%ax
  801d5c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d60:	72 ea                	jb     801d4c <__umoddi3+0x134>
  801d62:	89 d9                	mov    %ebx,%ecx
  801d64:	e9 62 ff ff ff       	jmp    801ccb <__umoddi3+0xb3>
