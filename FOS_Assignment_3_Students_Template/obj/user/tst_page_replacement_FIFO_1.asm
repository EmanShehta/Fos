
obj/user/tst_page_replacement_FIFO_1:     file format elf32-i386


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
  800031:	e8 ac 05 00 00       	call   8005e2 <libmain>
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
  80003b:	83 ec 78             	sub    $0x78,%esp



	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003e:	a1 20 30 80 00       	mov    0x803020,%eax
  800043:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800049:	8b 00                	mov    (%eax),%eax
  80004b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  80004e:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800051:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800056:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005b:	74 14                	je     800071 <_main+0x39>
  80005d:	83 ec 04             	sub    $0x4,%esp
  800060:	68 20 20 80 00       	push   $0x802020
  800065:	6a 15                	push   $0x15
  800067:	68 64 20 80 00       	push   $0x802064
  80006c:	e8 8d 06 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800071:	a1 20 30 80 00       	mov    0x803020,%eax
  800076:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80007c:	83 c0 18             	add    $0x18,%eax
  80007f:	8b 00                	mov    (%eax),%eax
  800081:	89 45 e8             	mov    %eax,-0x18(%ebp)
  800084:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800087:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008c:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800091:	74 14                	je     8000a7 <_main+0x6f>
  800093:	83 ec 04             	sub    $0x4,%esp
  800096:	68 20 20 80 00       	push   $0x802020
  80009b:	6a 16                	push   $0x16
  80009d:	68 64 20 80 00       	push   $0x802064
  8000a2:	e8 57 06 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ac:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000b2:	83 c0 30             	add    $0x30,%eax
  8000b5:	8b 00                	mov    (%eax),%eax
  8000b7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000ba:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c2:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c7:	74 14                	je     8000dd <_main+0xa5>
  8000c9:	83 ec 04             	sub    $0x4,%esp
  8000cc:	68 20 20 80 00       	push   $0x802020
  8000d1:	6a 17                	push   $0x17
  8000d3:	68 64 20 80 00       	push   $0x802064
  8000d8:	e8 21 06 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000dd:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e2:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000e8:	83 c0 48             	add    $0x48,%eax
  8000eb:	8b 00                	mov    (%eax),%eax
  8000ed:	89 45 e0             	mov    %eax,-0x20(%ebp)
  8000f0:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8000f3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f8:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fd:	74 14                	je     800113 <_main+0xdb>
  8000ff:	83 ec 04             	sub    $0x4,%esp
  800102:	68 20 20 80 00       	push   $0x802020
  800107:	6a 18                	push   $0x18
  800109:	68 64 20 80 00       	push   $0x802064
  80010e:	e8 eb 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800113:	a1 20 30 80 00       	mov    0x803020,%eax
  800118:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80011e:	83 c0 60             	add    $0x60,%eax
  800121:	8b 00                	mov    (%eax),%eax
  800123:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800126:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800129:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012e:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800133:	74 14                	je     800149 <_main+0x111>
  800135:	83 ec 04             	sub    $0x4,%esp
  800138:	68 20 20 80 00       	push   $0x802020
  80013d:	6a 19                	push   $0x19
  80013f:	68 64 20 80 00       	push   $0x802064
  800144:	e8 b5 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800149:	a1 20 30 80 00       	mov    0x803020,%eax
  80014e:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800154:	83 c0 78             	add    $0x78,%eax
  800157:	8b 00                	mov    (%eax),%eax
  800159:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80015c:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80015f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800164:	3d 00 50 20 00       	cmp    $0x205000,%eax
  800169:	74 14                	je     80017f <_main+0x147>
  80016b:	83 ec 04             	sub    $0x4,%esp
  80016e:	68 20 20 80 00       	push   $0x802020
  800173:	6a 1a                	push   $0x1a
  800175:	68 64 20 80 00       	push   $0x802064
  80017a:	e8 7f 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80017f:	a1 20 30 80 00       	mov    0x803020,%eax
  800184:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80018a:	05 90 00 00 00       	add    $0x90,%eax
  80018f:	8b 00                	mov    (%eax),%eax
  800191:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  800194:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  800197:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019c:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a1:	74 14                	je     8001b7 <_main+0x17f>
  8001a3:	83 ec 04             	sub    $0x4,%esp
  8001a6:	68 20 20 80 00       	push   $0x802020
  8001ab:	6a 1b                	push   $0x1b
  8001ad:	68 64 20 80 00       	push   $0x802064
  8001b2:	e8 47 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b7:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bc:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8001c2:	05 a8 00 00 00       	add    $0xa8,%eax
  8001c7:	8b 00                	mov    (%eax),%eax
  8001c9:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8001cc:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8001cf:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d4:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001d9:	74 14                	je     8001ef <_main+0x1b7>
  8001db:	83 ec 04             	sub    $0x4,%esp
  8001de:	68 20 20 80 00       	push   $0x802020
  8001e3:	6a 1c                	push   $0x1c
  8001e5:	68 64 20 80 00       	push   $0x802064
  8001ea:	e8 0f 05 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001ef:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f4:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8001fa:	05 c0 00 00 00       	add    $0xc0,%eax
  8001ff:	8b 00                	mov    (%eax),%eax
  800201:	89 45 cc             	mov    %eax,-0x34(%ebp)
  800204:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800207:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020c:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800211:	74 14                	je     800227 <_main+0x1ef>
  800213:	83 ec 04             	sub    $0x4,%esp
  800216:	68 20 20 80 00       	push   $0x802020
  80021b:	6a 1d                	push   $0x1d
  80021d:	68 64 20 80 00       	push   $0x802064
  800222:	e8 d7 04 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800227:	a1 20 30 80 00       	mov    0x803020,%eax
  80022c:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800232:	05 d8 00 00 00       	add    $0xd8,%eax
  800237:	8b 00                	mov    (%eax),%eax
  800239:	89 45 c8             	mov    %eax,-0x38(%ebp)
  80023c:	8b 45 c8             	mov    -0x38(%ebp),%eax
  80023f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800244:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800249:	74 14                	je     80025f <_main+0x227>
  80024b:	83 ec 04             	sub    $0x4,%esp
  80024e:	68 20 20 80 00       	push   $0x802020
  800253:	6a 1e                	push   $0x1e
  800255:	68 64 20 80 00       	push   $0x802064
  80025a:	e8 9f 04 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80025f:	a1 20 30 80 00       	mov    0x803020,%eax
  800264:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80026a:	05 f0 00 00 00       	add    $0xf0,%eax
  80026f:	8b 00                	mov    (%eax),%eax
  800271:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  800274:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800277:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027c:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800281:	74 14                	je     800297 <_main+0x25f>
  800283:	83 ec 04             	sub    $0x4,%esp
  800286:	68 20 20 80 00       	push   $0x802020
  80028b:	6a 1f                	push   $0x1f
  80028d:	68 64 20 80 00       	push   $0x802064
  800292:	e8 67 04 00 00       	call   8006fe <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800297:	a1 20 30 80 00       	mov    0x803020,%eax
  80029c:	8b 80 2c 05 00 00    	mov    0x52c(%eax),%eax
  8002a2:	85 c0                	test   %eax,%eax
  8002a4:	74 14                	je     8002ba <_main+0x282>
  8002a6:	83 ec 04             	sub    $0x4,%esp
  8002a9:	68 88 20 80 00       	push   $0x802088
  8002ae:	6a 20                	push   $0x20
  8002b0:	68 64 20 80 00       	push   $0x802064
  8002b5:	e8 44 04 00 00       	call   8006fe <_panic>
	}


	int freePages = sys_calculate_free_frames();
  8002ba:	e8 e9 15 00 00       	call   8018a8 <sys_calculate_free_frames>
  8002bf:	89 45 c0             	mov    %eax,-0x40(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c2:	e8 64 16 00 00       	call   80192b <sys_pf_calculate_allocated_pages>
  8002c7:	89 45 bc             	mov    %eax,-0x44(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1];
  8002ca:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002cf:	88 45 bb             	mov    %al,-0x45(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1];
  8002d2:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002d7:	88 45 ba             	mov    %al,-0x46(%ebp)
	char garbage4,garbage5;
	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002da:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8002e1:	eb 26                	jmp    800309 <_main+0x2d1>
	{
		arr[i] = -1 ;
  8002e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8002e6:	05 40 30 80 00       	add    $0x803040,%eax
  8002eb:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		//ptr++ ; ptr2++ ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		garbage4 = *ptr ;
  8002ee:	a1 00 30 80 00       	mov    0x803000,%eax
  8002f3:	8a 00                	mov    (%eax),%al
  8002f5:	88 45 f7             	mov    %al,-0x9(%ebp)
		garbage5 = *ptr2 ;
  8002f8:	a1 04 30 80 00       	mov    0x803004,%eax
  8002fd:	8a 00                	mov    (%eax),%al
  8002ff:	88 45 f6             	mov    %al,-0xa(%ebp)
	char garbage1 = arr[PAGE_SIZE*11-1];
	char garbage2 = arr[PAGE_SIZE*12-1];
	char garbage4,garbage5;
	//Writing (Modified)
	int i;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800302:	81 45 f0 00 08 00 00 	addl   $0x800,-0x10(%ebp)
  800309:	81 7d f0 ff 9f 00 00 	cmpl   $0x9fff,-0x10(%ebp)
  800310:	7e d1                	jle    8002e3 <_main+0x2ab>
	}

	//===================
	//cprintf("Checking PAGE FIFO algorithm... \n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=  0xeebfd000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800312:	a1 20 30 80 00       	mov    0x803020,%eax
  800317:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80031d:	8b 00                	mov    (%eax),%eax
  80031f:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  800322:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  800325:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80032a:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  80032f:	74 14                	je     800345 <_main+0x30d>
  800331:	83 ec 04             	sub    $0x4,%esp
  800334:	68 d0 20 80 00       	push   $0x8020d0
  800339:	6a 3c                	push   $0x3c
  80033b:	68 64 20 80 00       	push   $0x802064
  800340:	e8 b9 03 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=  0x80a000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800345:	a1 20 30 80 00       	mov    0x803020,%eax
  80034a:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800350:	83 c0 18             	add    $0x18,%eax
  800353:	8b 00                	mov    (%eax),%eax
  800355:	89 45 b0             	mov    %eax,-0x50(%ebp)
  800358:	8b 45 b0             	mov    -0x50(%ebp),%eax
  80035b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800360:	3d 00 a0 80 00       	cmp    $0x80a000,%eax
  800365:	74 14                	je     80037b <_main+0x343>
  800367:	83 ec 04             	sub    $0x4,%esp
  80036a:	68 d0 20 80 00       	push   $0x8020d0
  80036f:	6a 3d                	push   $0x3d
  800371:	68 64 20 80 00       	push   $0x802064
  800376:	e8 83 03 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=  0x80b000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80037b:	a1 20 30 80 00       	mov    0x803020,%eax
  800380:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800386:	83 c0 30             	add    $0x30,%eax
  800389:	8b 00                	mov    (%eax),%eax
  80038b:	89 45 ac             	mov    %eax,-0x54(%ebp)
  80038e:	8b 45 ac             	mov    -0x54(%ebp),%eax
  800391:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800396:	3d 00 b0 80 00       	cmp    $0x80b000,%eax
  80039b:	74 14                	je     8003b1 <_main+0x379>
  80039d:	83 ec 04             	sub    $0x4,%esp
  8003a0:	68 d0 20 80 00       	push   $0x8020d0
  8003a5:	6a 3e                	push   $0x3e
  8003a7:	68 64 20 80 00       	push   $0x802064
  8003ac:	e8 4d 03 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=  0x804000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003b1:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b6:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8003bc:	83 c0 48             	add    $0x48,%eax
  8003bf:	8b 00                	mov    (%eax),%eax
  8003c1:	89 45 a8             	mov    %eax,-0x58(%ebp)
  8003c4:	8b 45 a8             	mov    -0x58(%ebp),%eax
  8003c7:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8003cc:	3d 00 40 80 00       	cmp    $0x804000,%eax
  8003d1:	74 14                	je     8003e7 <_main+0x3af>
  8003d3:	83 ec 04             	sub    $0x4,%esp
  8003d6:	68 d0 20 80 00       	push   $0x8020d0
  8003db:	6a 3f                	push   $0x3f
  8003dd:	68 64 20 80 00       	push   $0x802064
  8003e2:	e8 17 03 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=  0x80c000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8003e7:	a1 20 30 80 00       	mov    0x803020,%eax
  8003ec:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8003f2:	83 c0 60             	add    $0x60,%eax
  8003f5:	8b 00                	mov    (%eax),%eax
  8003f7:	89 45 a4             	mov    %eax,-0x5c(%ebp)
  8003fa:	8b 45 a4             	mov    -0x5c(%ebp),%eax
  8003fd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800402:	3d 00 c0 80 00       	cmp    $0x80c000,%eax
  800407:	74 14                	je     80041d <_main+0x3e5>
  800409:	83 ec 04             	sub    $0x4,%esp
  80040c:	68 d0 20 80 00       	push   $0x8020d0
  800411:	6a 40                	push   $0x40
  800413:	68 64 20 80 00       	push   $0x802064
  800418:	e8 e1 02 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=  0x807000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80041d:	a1 20 30 80 00       	mov    0x803020,%eax
  800422:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800428:	83 c0 78             	add    $0x78,%eax
  80042b:	8b 00                	mov    (%eax),%eax
  80042d:	89 45 a0             	mov    %eax,-0x60(%ebp)
  800430:	8b 45 a0             	mov    -0x60(%ebp),%eax
  800433:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800438:	3d 00 70 80 00       	cmp    $0x807000,%eax
  80043d:	74 14                	je     800453 <_main+0x41b>
  80043f:	83 ec 04             	sub    $0x4,%esp
  800442:	68 d0 20 80 00       	push   $0x8020d0
  800447:	6a 41                	push   $0x41
  800449:	68 64 20 80 00       	push   $0x802064
  80044e:	e8 ab 02 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=  0x808000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800453:	a1 20 30 80 00       	mov    0x803020,%eax
  800458:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80045e:	05 90 00 00 00       	add    $0x90,%eax
  800463:	8b 00                	mov    (%eax),%eax
  800465:	89 45 9c             	mov    %eax,-0x64(%ebp)
  800468:	8b 45 9c             	mov    -0x64(%ebp),%eax
  80046b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800470:	3d 00 80 80 00       	cmp    $0x808000,%eax
  800475:	74 14                	je     80048b <_main+0x453>
  800477:	83 ec 04             	sub    $0x4,%esp
  80047a:	68 d0 20 80 00       	push   $0x8020d0
  80047f:	6a 42                	push   $0x42
  800481:	68 64 20 80 00       	push   $0x802064
  800486:	e8 73 02 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=  0x800000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  80048b:	a1 20 30 80 00       	mov    0x803020,%eax
  800490:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800496:	05 a8 00 00 00       	add    $0xa8,%eax
  80049b:	8b 00                	mov    (%eax),%eax
  80049d:	89 45 98             	mov    %eax,-0x68(%ebp)
  8004a0:	8b 45 98             	mov    -0x68(%ebp),%eax
  8004a3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004a8:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8004ad:	74 14                	je     8004c3 <_main+0x48b>
  8004af:	83 ec 04             	sub    $0x4,%esp
  8004b2:	68 d0 20 80 00       	push   $0x8020d0
  8004b7:	6a 43                	push   $0x43
  8004b9:	68 64 20 80 00       	push   $0x802064
  8004be:	e8 3b 02 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=  0x801000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004c3:	a1 20 30 80 00       	mov    0x803020,%eax
  8004c8:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8004ce:	05 c0 00 00 00       	add    $0xc0,%eax
  8004d3:	8b 00                	mov    (%eax),%eax
  8004d5:	89 45 94             	mov    %eax,-0x6c(%ebp)
  8004d8:	8b 45 94             	mov    -0x6c(%ebp),%eax
  8004db:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8004e0:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8004e5:	74 14                	je     8004fb <_main+0x4c3>
  8004e7:	83 ec 04             	sub    $0x4,%esp
  8004ea:	68 d0 20 80 00       	push   $0x8020d0
  8004ef:	6a 44                	push   $0x44
  8004f1:	68 64 20 80 00       	push   $0x802064
  8004f6:	e8 03 02 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=  0x809000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  8004fb:	a1 20 30 80 00       	mov    0x803020,%eax
  800500:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800506:	05 d8 00 00 00       	add    $0xd8,%eax
  80050b:	8b 00                	mov    (%eax),%eax
  80050d:	89 45 90             	mov    %eax,-0x70(%ebp)
  800510:	8b 45 90             	mov    -0x70(%ebp),%eax
  800513:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800518:	3d 00 90 80 00       	cmp    $0x809000,%eax
  80051d:	74 14                	je     800533 <_main+0x4fb>
  80051f:	83 ec 04             	sub    $0x4,%esp
  800522:	68 d0 20 80 00       	push   $0x8020d0
  800527:	6a 45                	push   $0x45
  800529:	68 64 20 80 00       	push   $0x802064
  80052e:	e8 cb 01 00 00       	call   8006fe <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=  0x803000)  panic("Page FIFO algo failed.. trace it by printing WS before and after page fault");
  800533:	a1 20 30 80 00       	mov    0x803020,%eax
  800538:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80053e:	05 f0 00 00 00       	add    $0xf0,%eax
  800543:	8b 00                	mov    (%eax),%eax
  800545:	89 45 8c             	mov    %eax,-0x74(%ebp)
  800548:	8b 45 8c             	mov    -0x74(%ebp),%eax
  80054b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800550:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800555:	74 14                	je     80056b <_main+0x533>
  800557:	83 ec 04             	sub    $0x4,%esp
  80055a:	68 d0 20 80 00       	push   $0x8020d0
  80055f:	6a 46                	push   $0x46
  800561:	68 64 20 80 00       	push   $0x802064
  800566:	e8 93 01 00 00       	call   8006fe <_panic>

		if(myEnv->page_last_WS_index != 5) panic("wrong PAGE WS pointer location");
  80056b:	a1 20 30 80 00       	mov    0x803020,%eax
  800570:	8b 80 2c 05 00 00    	mov    0x52c(%eax),%eax
  800576:	83 f8 05             	cmp    $0x5,%eax
  800579:	74 14                	je     80058f <_main+0x557>
  80057b:	83 ec 04             	sub    $0x4,%esp
  80057e:	68 1c 21 80 00       	push   $0x80211c
  800583:	6a 48                	push   $0x48
  800585:	68 64 20 80 00       	push   $0x802064
  80058a:	e8 6f 01 00 00       	call   8006fe <_panic>

	}
	{
		if (garbage4 != *ptr) panic("test failed!");
  80058f:	a1 00 30 80 00       	mov    0x803000,%eax
  800594:	8a 00                	mov    (%eax),%al
  800596:	3a 45 f7             	cmp    -0x9(%ebp),%al
  800599:	74 14                	je     8005af <_main+0x577>
  80059b:	83 ec 04             	sub    $0x4,%esp
  80059e:	68 3b 21 80 00       	push   $0x80213b
  8005a3:	6a 4c                	push   $0x4c
  8005a5:	68 64 20 80 00       	push   $0x802064
  8005aa:	e8 4f 01 00 00       	call   8006fe <_panic>
		if (garbage5 != *ptr2) panic("test failed!");
  8005af:	a1 04 30 80 00       	mov    0x803004,%eax
  8005b4:	8a 00                	mov    (%eax),%al
  8005b6:	3a 45 f6             	cmp    -0xa(%ebp),%al
  8005b9:	74 14                	je     8005cf <_main+0x597>
  8005bb:	83 ec 04             	sub    $0x4,%esp
  8005be:	68 3b 21 80 00       	push   $0x80213b
  8005c3:	6a 4d                	push   $0x4d
  8005c5:	68 64 20 80 00       	push   $0x802064
  8005ca:	e8 2f 01 00 00       	call   8006fe <_panic>
	}
	cprintf("Congratulations!! test PAGE replacement [FIFO 1] is completed successfully.\n");
  8005cf:	83 ec 0c             	sub    $0xc,%esp
  8005d2:	68 48 21 80 00       	push   $0x802148
  8005d7:	e8 d6 03 00 00       	call   8009b2 <cprintf>
  8005dc:	83 c4 10             	add    $0x10,%esp
	return;
  8005df:	90                   	nop
}
  8005e0:	c9                   	leave  
  8005e1:	c3                   	ret    

008005e2 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005e2:	55                   	push   %ebp
  8005e3:	89 e5                	mov    %esp,%ebp
  8005e5:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e8:	e8 f0 11 00 00       	call   8017dd <sys_getenvindex>
  8005ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005f0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005f3:	89 d0                	mov    %edx,%eax
  8005f5:	01 c0                	add    %eax,%eax
  8005f7:	01 d0                	add    %edx,%eax
  8005f9:	c1 e0 04             	shl    $0x4,%eax
  8005fc:	29 d0                	sub    %edx,%eax
  8005fe:	c1 e0 03             	shl    $0x3,%eax
  800601:	01 d0                	add    %edx,%eax
  800603:	c1 e0 02             	shl    $0x2,%eax
  800606:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  80060b:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800610:	a1 20 30 80 00       	mov    0x803020,%eax
  800615:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  80061b:	84 c0                	test   %al,%al
  80061d:	74 0f                	je     80062e <libmain+0x4c>
		binaryname = myEnv->prog_name;
  80061f:	a1 20 30 80 00       	mov    0x803020,%eax
  800624:	05 5c 05 00 00       	add    $0x55c,%eax
  800629:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80062e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800632:	7e 0a                	jle    80063e <libmain+0x5c>
		binaryname = argv[0];
  800634:	8b 45 0c             	mov    0xc(%ebp),%eax
  800637:	8b 00                	mov    (%eax),%eax
  800639:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  80063e:	83 ec 08             	sub    $0x8,%esp
  800641:	ff 75 0c             	pushl  0xc(%ebp)
  800644:	ff 75 08             	pushl  0x8(%ebp)
  800647:	e8 ec f9 ff ff       	call   800038 <_main>
  80064c:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80064f:	e8 24 13 00 00       	call   801978 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800654:	83 ec 0c             	sub    $0xc,%esp
  800657:	68 b0 21 80 00       	push   $0x8021b0
  80065c:	e8 51 03 00 00       	call   8009b2 <cprintf>
  800661:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800664:	a1 20 30 80 00       	mov    0x803020,%eax
  800669:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  80066f:	a1 20 30 80 00       	mov    0x803020,%eax
  800674:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80067a:	83 ec 04             	sub    $0x4,%esp
  80067d:	52                   	push   %edx
  80067e:	50                   	push   %eax
  80067f:	68 d8 21 80 00       	push   $0x8021d8
  800684:	e8 29 03 00 00       	call   8009b2 <cprintf>
  800689:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80068c:	a1 20 30 80 00       	mov    0x803020,%eax
  800691:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800697:	a1 20 30 80 00       	mov    0x803020,%eax
  80069c:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8006a2:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a7:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8006ad:	51                   	push   %ecx
  8006ae:	52                   	push   %edx
  8006af:	50                   	push   %eax
  8006b0:	68 00 22 80 00       	push   $0x802200
  8006b5:	e8 f8 02 00 00       	call   8009b2 <cprintf>
  8006ba:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006bd:	83 ec 0c             	sub    $0xc,%esp
  8006c0:	68 b0 21 80 00       	push   $0x8021b0
  8006c5:	e8 e8 02 00 00       	call   8009b2 <cprintf>
  8006ca:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006cd:	e8 c0 12 00 00       	call   801992 <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006d2:	e8 19 00 00 00       	call   8006f0 <exit>
}
  8006d7:	90                   	nop
  8006d8:	c9                   	leave  
  8006d9:	c3                   	ret    

008006da <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006da:	55                   	push   %ebp
  8006db:	89 e5                	mov    %esp,%ebp
  8006dd:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006e0:	83 ec 0c             	sub    $0xc,%esp
  8006e3:	6a 00                	push   $0x0
  8006e5:	e8 bf 10 00 00       	call   8017a9 <sys_env_destroy>
  8006ea:	83 c4 10             	add    $0x10,%esp
}
  8006ed:	90                   	nop
  8006ee:	c9                   	leave  
  8006ef:	c3                   	ret    

008006f0 <exit>:

void
exit(void)
{
  8006f0:	55                   	push   %ebp
  8006f1:	89 e5                	mov    %esp,%ebp
  8006f3:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006f6:	e8 14 11 00 00       	call   80180f <sys_env_exit>
}
  8006fb:	90                   	nop
  8006fc:	c9                   	leave  
  8006fd:	c3                   	ret    

008006fe <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006fe:	55                   	push   %ebp
  8006ff:	89 e5                	mov    %esp,%ebp
  800701:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800704:	8d 45 10             	lea    0x10(%ebp),%eax
  800707:	83 c0 04             	add    $0x4,%eax
  80070a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80070d:	a1 18 f1 80 00       	mov    0x80f118,%eax
  800712:	85 c0                	test   %eax,%eax
  800714:	74 16                	je     80072c <_panic+0x2e>
		cprintf("%s: ", argv0);
  800716:	a1 18 f1 80 00       	mov    0x80f118,%eax
  80071b:	83 ec 08             	sub    $0x8,%esp
  80071e:	50                   	push   %eax
  80071f:	68 58 22 80 00       	push   $0x802258
  800724:	e8 89 02 00 00       	call   8009b2 <cprintf>
  800729:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  80072c:	a1 08 30 80 00       	mov    0x803008,%eax
  800731:	ff 75 0c             	pushl  0xc(%ebp)
  800734:	ff 75 08             	pushl  0x8(%ebp)
  800737:	50                   	push   %eax
  800738:	68 5d 22 80 00       	push   $0x80225d
  80073d:	e8 70 02 00 00       	call   8009b2 <cprintf>
  800742:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800745:	8b 45 10             	mov    0x10(%ebp),%eax
  800748:	83 ec 08             	sub    $0x8,%esp
  80074b:	ff 75 f4             	pushl  -0xc(%ebp)
  80074e:	50                   	push   %eax
  80074f:	e8 f3 01 00 00       	call   800947 <vcprintf>
  800754:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800757:	83 ec 08             	sub    $0x8,%esp
  80075a:	6a 00                	push   $0x0
  80075c:	68 79 22 80 00       	push   $0x802279
  800761:	e8 e1 01 00 00       	call   800947 <vcprintf>
  800766:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800769:	e8 82 ff ff ff       	call   8006f0 <exit>

	// should not return here
	while (1) ;
  80076e:	eb fe                	jmp    80076e <_panic+0x70>

00800770 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800770:	55                   	push   %ebp
  800771:	89 e5                	mov    %esp,%ebp
  800773:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800776:	a1 20 30 80 00       	mov    0x803020,%eax
  80077b:	8b 50 74             	mov    0x74(%eax),%edx
  80077e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800781:	39 c2                	cmp    %eax,%edx
  800783:	74 14                	je     800799 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800785:	83 ec 04             	sub    $0x4,%esp
  800788:	68 7c 22 80 00       	push   $0x80227c
  80078d:	6a 26                	push   $0x26
  80078f:	68 c8 22 80 00       	push   $0x8022c8
  800794:	e8 65 ff ff ff       	call   8006fe <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800799:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8007a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007a7:	e9 c2 00 00 00       	jmp    80086e <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007ac:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007af:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b9:	01 d0                	add    %edx,%eax
  8007bb:	8b 00                	mov    (%eax),%eax
  8007bd:	85 c0                	test   %eax,%eax
  8007bf:	75 08                	jne    8007c9 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007c1:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007c4:	e9 a2 00 00 00       	jmp    80086b <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007c9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007d0:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007d7:	eb 69                	jmp    800842 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007d9:	a1 20 30 80 00       	mov    0x803020,%eax
  8007de:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8007e4:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e7:	89 d0                	mov    %edx,%eax
  8007e9:	01 c0                	add    %eax,%eax
  8007eb:	01 d0                	add    %edx,%eax
  8007ed:	c1 e0 03             	shl    $0x3,%eax
  8007f0:	01 c8                	add    %ecx,%eax
  8007f2:	8a 40 04             	mov    0x4(%eax),%al
  8007f5:	84 c0                	test   %al,%al
  8007f7:	75 46                	jne    80083f <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f9:	a1 20 30 80 00       	mov    0x803020,%eax
  8007fe:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800804:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800807:	89 d0                	mov    %edx,%eax
  800809:	01 c0                	add    %eax,%eax
  80080b:	01 d0                	add    %edx,%eax
  80080d:	c1 e0 03             	shl    $0x3,%eax
  800810:	01 c8                	add    %ecx,%eax
  800812:	8b 00                	mov    (%eax),%eax
  800814:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800817:	8b 45 dc             	mov    -0x24(%ebp),%eax
  80081a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80081f:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800821:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800824:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  80082b:	8b 45 08             	mov    0x8(%ebp),%eax
  80082e:	01 c8                	add    %ecx,%eax
  800830:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800832:	39 c2                	cmp    %eax,%edx
  800834:	75 09                	jne    80083f <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800836:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80083d:	eb 12                	jmp    800851 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80083f:	ff 45 e8             	incl   -0x18(%ebp)
  800842:	a1 20 30 80 00       	mov    0x803020,%eax
  800847:	8b 50 74             	mov    0x74(%eax),%edx
  80084a:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80084d:	39 c2                	cmp    %eax,%edx
  80084f:	77 88                	ja     8007d9 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800851:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800855:	75 14                	jne    80086b <CheckWSWithoutLastIndex+0xfb>
			panic(
  800857:	83 ec 04             	sub    $0x4,%esp
  80085a:	68 d4 22 80 00       	push   $0x8022d4
  80085f:	6a 3a                	push   $0x3a
  800861:	68 c8 22 80 00       	push   $0x8022c8
  800866:	e8 93 fe ff ff       	call   8006fe <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80086b:	ff 45 f0             	incl   -0x10(%ebp)
  80086e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800871:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800874:	0f 8c 32 ff ff ff    	jl     8007ac <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80087a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800881:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800888:	eb 26                	jmp    8008b0 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80088a:	a1 20 30 80 00       	mov    0x803020,%eax
  80088f:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800895:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800898:	89 d0                	mov    %edx,%eax
  80089a:	01 c0                	add    %eax,%eax
  80089c:	01 d0                	add    %edx,%eax
  80089e:	c1 e0 03             	shl    $0x3,%eax
  8008a1:	01 c8                	add    %ecx,%eax
  8008a3:	8a 40 04             	mov    0x4(%eax),%al
  8008a6:	3c 01                	cmp    $0x1,%al
  8008a8:	75 03                	jne    8008ad <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008aa:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008ad:	ff 45 e0             	incl   -0x20(%ebp)
  8008b0:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b5:	8b 50 74             	mov    0x74(%eax),%edx
  8008b8:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008bb:	39 c2                	cmp    %eax,%edx
  8008bd:	77 cb                	ja     80088a <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008c2:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008c5:	74 14                	je     8008db <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008c7:	83 ec 04             	sub    $0x4,%esp
  8008ca:	68 28 23 80 00       	push   $0x802328
  8008cf:	6a 44                	push   $0x44
  8008d1:	68 c8 22 80 00       	push   $0x8022c8
  8008d6:	e8 23 fe ff ff       	call   8006fe <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008db:	90                   	nop
  8008dc:	c9                   	leave  
  8008dd:	c3                   	ret    

008008de <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008de:	55                   	push   %ebp
  8008df:	89 e5                	mov    %esp,%ebp
  8008e1:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008e4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e7:	8b 00                	mov    (%eax),%eax
  8008e9:	8d 48 01             	lea    0x1(%eax),%ecx
  8008ec:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008ef:	89 0a                	mov    %ecx,(%edx)
  8008f1:	8b 55 08             	mov    0x8(%ebp),%edx
  8008f4:	88 d1                	mov    %dl,%cl
  8008f6:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f9:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008fd:	8b 45 0c             	mov    0xc(%ebp),%eax
  800900:	8b 00                	mov    (%eax),%eax
  800902:	3d ff 00 00 00       	cmp    $0xff,%eax
  800907:	75 2c                	jne    800935 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800909:	a0 24 30 80 00       	mov    0x803024,%al
  80090e:	0f b6 c0             	movzbl %al,%eax
  800911:	8b 55 0c             	mov    0xc(%ebp),%edx
  800914:	8b 12                	mov    (%edx),%edx
  800916:	89 d1                	mov    %edx,%ecx
  800918:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091b:	83 c2 08             	add    $0x8,%edx
  80091e:	83 ec 04             	sub    $0x4,%esp
  800921:	50                   	push   %eax
  800922:	51                   	push   %ecx
  800923:	52                   	push   %edx
  800924:	e8 3e 0e 00 00       	call   801767 <sys_cputs>
  800929:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  80092c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800935:	8b 45 0c             	mov    0xc(%ebp),%eax
  800938:	8b 40 04             	mov    0x4(%eax),%eax
  80093b:	8d 50 01             	lea    0x1(%eax),%edx
  80093e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800941:	89 50 04             	mov    %edx,0x4(%eax)
}
  800944:	90                   	nop
  800945:	c9                   	leave  
  800946:	c3                   	ret    

00800947 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800947:	55                   	push   %ebp
  800948:	89 e5                	mov    %esp,%ebp
  80094a:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800950:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800957:	00 00 00 
	b.cnt = 0;
  80095a:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800961:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800964:	ff 75 0c             	pushl  0xc(%ebp)
  800967:	ff 75 08             	pushl  0x8(%ebp)
  80096a:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800970:	50                   	push   %eax
  800971:	68 de 08 80 00       	push   $0x8008de
  800976:	e8 11 02 00 00       	call   800b8c <vprintfmt>
  80097b:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80097e:	a0 24 30 80 00       	mov    0x803024,%al
  800983:	0f b6 c0             	movzbl %al,%eax
  800986:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80098c:	83 ec 04             	sub    $0x4,%esp
  80098f:	50                   	push   %eax
  800990:	52                   	push   %edx
  800991:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800997:	83 c0 08             	add    $0x8,%eax
  80099a:	50                   	push   %eax
  80099b:	e8 c7 0d 00 00       	call   801767 <sys_cputs>
  8009a0:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8009a3:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009aa:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009b0:	c9                   	leave  
  8009b1:	c3                   	ret    

008009b2 <cprintf>:

int cprintf(const char *fmt, ...) {
  8009b2:	55                   	push   %ebp
  8009b3:	89 e5                	mov    %esp,%ebp
  8009b5:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009b8:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009bf:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c8:	83 ec 08             	sub    $0x8,%esp
  8009cb:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ce:	50                   	push   %eax
  8009cf:	e8 73 ff ff ff       	call   800947 <vcprintf>
  8009d4:	83 c4 10             	add    $0x10,%esp
  8009d7:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009da:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009dd:	c9                   	leave  
  8009de:	c3                   	ret    

008009df <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009df:	55                   	push   %ebp
  8009e0:	89 e5                	mov    %esp,%ebp
  8009e2:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009e5:	e8 8e 0f 00 00       	call   801978 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009ea:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009ed:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009f3:	83 ec 08             	sub    $0x8,%esp
  8009f6:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f9:	50                   	push   %eax
  8009fa:	e8 48 ff ff ff       	call   800947 <vcprintf>
  8009ff:	83 c4 10             	add    $0x10,%esp
  800a02:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a05:	e8 88 0f 00 00       	call   801992 <sys_enable_interrupt>
	return cnt;
  800a0a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a0d:	c9                   	leave  
  800a0e:	c3                   	ret    

00800a0f <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a0f:	55                   	push   %ebp
  800a10:	89 e5                	mov    %esp,%ebp
  800a12:	53                   	push   %ebx
  800a13:	83 ec 14             	sub    $0x14,%esp
  800a16:	8b 45 10             	mov    0x10(%ebp),%eax
  800a19:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a1c:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1f:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a22:	8b 45 18             	mov    0x18(%ebp),%eax
  800a25:	ba 00 00 00 00       	mov    $0x0,%edx
  800a2a:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a2d:	77 55                	ja     800a84 <printnum+0x75>
  800a2f:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a32:	72 05                	jb     800a39 <printnum+0x2a>
  800a34:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a37:	77 4b                	ja     800a84 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a39:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a3c:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a3f:	8b 45 18             	mov    0x18(%ebp),%eax
  800a42:	ba 00 00 00 00       	mov    $0x0,%edx
  800a47:	52                   	push   %edx
  800a48:	50                   	push   %eax
  800a49:	ff 75 f4             	pushl  -0xc(%ebp)
  800a4c:	ff 75 f0             	pushl  -0x10(%ebp)
  800a4f:	e8 64 13 00 00       	call   801db8 <__udivdi3>
  800a54:	83 c4 10             	add    $0x10,%esp
  800a57:	83 ec 04             	sub    $0x4,%esp
  800a5a:	ff 75 20             	pushl  0x20(%ebp)
  800a5d:	53                   	push   %ebx
  800a5e:	ff 75 18             	pushl  0x18(%ebp)
  800a61:	52                   	push   %edx
  800a62:	50                   	push   %eax
  800a63:	ff 75 0c             	pushl  0xc(%ebp)
  800a66:	ff 75 08             	pushl  0x8(%ebp)
  800a69:	e8 a1 ff ff ff       	call   800a0f <printnum>
  800a6e:	83 c4 20             	add    $0x20,%esp
  800a71:	eb 1a                	jmp    800a8d <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a73:	83 ec 08             	sub    $0x8,%esp
  800a76:	ff 75 0c             	pushl  0xc(%ebp)
  800a79:	ff 75 20             	pushl  0x20(%ebp)
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	ff d0                	call   *%eax
  800a81:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a84:	ff 4d 1c             	decl   0x1c(%ebp)
  800a87:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a8b:	7f e6                	jg     800a73 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a8d:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a90:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a95:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a98:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a9b:	53                   	push   %ebx
  800a9c:	51                   	push   %ecx
  800a9d:	52                   	push   %edx
  800a9e:	50                   	push   %eax
  800a9f:	e8 24 14 00 00       	call   801ec8 <__umoddi3>
  800aa4:	83 c4 10             	add    $0x10,%esp
  800aa7:	05 94 25 80 00       	add    $0x802594,%eax
  800aac:	8a 00                	mov    (%eax),%al
  800aae:	0f be c0             	movsbl %al,%eax
  800ab1:	83 ec 08             	sub    $0x8,%esp
  800ab4:	ff 75 0c             	pushl  0xc(%ebp)
  800ab7:	50                   	push   %eax
  800ab8:	8b 45 08             	mov    0x8(%ebp),%eax
  800abb:	ff d0                	call   *%eax
  800abd:	83 c4 10             	add    $0x10,%esp
}
  800ac0:	90                   	nop
  800ac1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ac4:	c9                   	leave  
  800ac5:	c3                   	ret    

00800ac6 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ac6:	55                   	push   %ebp
  800ac7:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ac9:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800acd:	7e 1c                	jle    800aeb <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800acf:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad2:	8b 00                	mov    (%eax),%eax
  800ad4:	8d 50 08             	lea    0x8(%eax),%edx
  800ad7:	8b 45 08             	mov    0x8(%ebp),%eax
  800ada:	89 10                	mov    %edx,(%eax)
  800adc:	8b 45 08             	mov    0x8(%ebp),%eax
  800adf:	8b 00                	mov    (%eax),%eax
  800ae1:	83 e8 08             	sub    $0x8,%eax
  800ae4:	8b 50 04             	mov    0x4(%eax),%edx
  800ae7:	8b 00                	mov    (%eax),%eax
  800ae9:	eb 40                	jmp    800b2b <getuint+0x65>
	else if (lflag)
  800aeb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aef:	74 1e                	je     800b0f <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800af1:	8b 45 08             	mov    0x8(%ebp),%eax
  800af4:	8b 00                	mov    (%eax),%eax
  800af6:	8d 50 04             	lea    0x4(%eax),%edx
  800af9:	8b 45 08             	mov    0x8(%ebp),%eax
  800afc:	89 10                	mov    %edx,(%eax)
  800afe:	8b 45 08             	mov    0x8(%ebp),%eax
  800b01:	8b 00                	mov    (%eax),%eax
  800b03:	83 e8 04             	sub    $0x4,%eax
  800b06:	8b 00                	mov    (%eax),%eax
  800b08:	ba 00 00 00 00       	mov    $0x0,%edx
  800b0d:	eb 1c                	jmp    800b2b <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b0f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b12:	8b 00                	mov    (%eax),%eax
  800b14:	8d 50 04             	lea    0x4(%eax),%edx
  800b17:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1a:	89 10                	mov    %edx,(%eax)
  800b1c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1f:	8b 00                	mov    (%eax),%eax
  800b21:	83 e8 04             	sub    $0x4,%eax
  800b24:	8b 00                	mov    (%eax),%eax
  800b26:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b2b:	5d                   	pop    %ebp
  800b2c:	c3                   	ret    

00800b2d <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b2d:	55                   	push   %ebp
  800b2e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b30:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b34:	7e 1c                	jle    800b52 <getint+0x25>
		return va_arg(*ap, long long);
  800b36:	8b 45 08             	mov    0x8(%ebp),%eax
  800b39:	8b 00                	mov    (%eax),%eax
  800b3b:	8d 50 08             	lea    0x8(%eax),%edx
  800b3e:	8b 45 08             	mov    0x8(%ebp),%eax
  800b41:	89 10                	mov    %edx,(%eax)
  800b43:	8b 45 08             	mov    0x8(%ebp),%eax
  800b46:	8b 00                	mov    (%eax),%eax
  800b48:	83 e8 08             	sub    $0x8,%eax
  800b4b:	8b 50 04             	mov    0x4(%eax),%edx
  800b4e:	8b 00                	mov    (%eax),%eax
  800b50:	eb 38                	jmp    800b8a <getint+0x5d>
	else if (lflag)
  800b52:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b56:	74 1a                	je     800b72 <getint+0x45>
		return va_arg(*ap, long);
  800b58:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5b:	8b 00                	mov    (%eax),%eax
  800b5d:	8d 50 04             	lea    0x4(%eax),%edx
  800b60:	8b 45 08             	mov    0x8(%ebp),%eax
  800b63:	89 10                	mov    %edx,(%eax)
  800b65:	8b 45 08             	mov    0x8(%ebp),%eax
  800b68:	8b 00                	mov    (%eax),%eax
  800b6a:	83 e8 04             	sub    $0x4,%eax
  800b6d:	8b 00                	mov    (%eax),%eax
  800b6f:	99                   	cltd   
  800b70:	eb 18                	jmp    800b8a <getint+0x5d>
	else
		return va_arg(*ap, int);
  800b72:	8b 45 08             	mov    0x8(%ebp),%eax
  800b75:	8b 00                	mov    (%eax),%eax
  800b77:	8d 50 04             	lea    0x4(%eax),%edx
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	89 10                	mov    %edx,(%eax)
  800b7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b82:	8b 00                	mov    (%eax),%eax
  800b84:	83 e8 04             	sub    $0x4,%eax
  800b87:	8b 00                	mov    (%eax),%eax
  800b89:	99                   	cltd   
}
  800b8a:	5d                   	pop    %ebp
  800b8b:	c3                   	ret    

00800b8c <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b8c:	55                   	push   %ebp
  800b8d:	89 e5                	mov    %esp,%ebp
  800b8f:	56                   	push   %esi
  800b90:	53                   	push   %ebx
  800b91:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b94:	eb 17                	jmp    800bad <vprintfmt+0x21>
			if (ch == '\0')
  800b96:	85 db                	test   %ebx,%ebx
  800b98:	0f 84 af 03 00 00    	je     800f4d <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b9e:	83 ec 08             	sub    $0x8,%esp
  800ba1:	ff 75 0c             	pushl  0xc(%ebp)
  800ba4:	53                   	push   %ebx
  800ba5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba8:	ff d0                	call   *%eax
  800baa:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800bad:	8b 45 10             	mov    0x10(%ebp),%eax
  800bb0:	8d 50 01             	lea    0x1(%eax),%edx
  800bb3:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb6:	8a 00                	mov    (%eax),%al
  800bb8:	0f b6 d8             	movzbl %al,%ebx
  800bbb:	83 fb 25             	cmp    $0x25,%ebx
  800bbe:	75 d6                	jne    800b96 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bc0:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bc4:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bcb:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bd2:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bd9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800be0:	8b 45 10             	mov    0x10(%ebp),%eax
  800be3:	8d 50 01             	lea    0x1(%eax),%edx
  800be6:	89 55 10             	mov    %edx,0x10(%ebp)
  800be9:	8a 00                	mov    (%eax),%al
  800beb:	0f b6 d8             	movzbl %al,%ebx
  800bee:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bf1:	83 f8 55             	cmp    $0x55,%eax
  800bf4:	0f 87 2b 03 00 00    	ja     800f25 <vprintfmt+0x399>
  800bfa:	8b 04 85 b8 25 80 00 	mov    0x8025b8(,%eax,4),%eax
  800c01:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800c03:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c07:	eb d7                	jmp    800be0 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c09:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c0d:	eb d1                	jmp    800be0 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c0f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c16:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c19:	89 d0                	mov    %edx,%eax
  800c1b:	c1 e0 02             	shl    $0x2,%eax
  800c1e:	01 d0                	add    %edx,%eax
  800c20:	01 c0                	add    %eax,%eax
  800c22:	01 d8                	add    %ebx,%eax
  800c24:	83 e8 30             	sub    $0x30,%eax
  800c27:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c2a:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2d:	8a 00                	mov    (%eax),%al
  800c2f:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c32:	83 fb 2f             	cmp    $0x2f,%ebx
  800c35:	7e 3e                	jle    800c75 <vprintfmt+0xe9>
  800c37:	83 fb 39             	cmp    $0x39,%ebx
  800c3a:	7f 39                	jg     800c75 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c3c:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c3f:	eb d5                	jmp    800c16 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c41:	8b 45 14             	mov    0x14(%ebp),%eax
  800c44:	83 c0 04             	add    $0x4,%eax
  800c47:	89 45 14             	mov    %eax,0x14(%ebp)
  800c4a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c4d:	83 e8 04             	sub    $0x4,%eax
  800c50:	8b 00                	mov    (%eax),%eax
  800c52:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c55:	eb 1f                	jmp    800c76 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c57:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c5b:	79 83                	jns    800be0 <vprintfmt+0x54>
				width = 0;
  800c5d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c64:	e9 77 ff ff ff       	jmp    800be0 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c69:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c70:	e9 6b ff ff ff       	jmp    800be0 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c75:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c76:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c7a:	0f 89 60 ff ff ff    	jns    800be0 <vprintfmt+0x54>
				width = precision, precision = -1;
  800c80:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c83:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c86:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c8d:	e9 4e ff ff ff       	jmp    800be0 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c92:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c95:	e9 46 ff ff ff       	jmp    800be0 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c9a:	8b 45 14             	mov    0x14(%ebp),%eax
  800c9d:	83 c0 04             	add    $0x4,%eax
  800ca0:	89 45 14             	mov    %eax,0x14(%ebp)
  800ca3:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca6:	83 e8 04             	sub    $0x4,%eax
  800ca9:	8b 00                	mov    (%eax),%eax
  800cab:	83 ec 08             	sub    $0x8,%esp
  800cae:	ff 75 0c             	pushl  0xc(%ebp)
  800cb1:	50                   	push   %eax
  800cb2:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb5:	ff d0                	call   *%eax
  800cb7:	83 c4 10             	add    $0x10,%esp
			break;
  800cba:	e9 89 02 00 00       	jmp    800f48 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cbf:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc2:	83 c0 04             	add    $0x4,%eax
  800cc5:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc8:	8b 45 14             	mov    0x14(%ebp),%eax
  800ccb:	83 e8 04             	sub    $0x4,%eax
  800cce:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800cd0:	85 db                	test   %ebx,%ebx
  800cd2:	79 02                	jns    800cd6 <vprintfmt+0x14a>
				err = -err;
  800cd4:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cd6:	83 fb 64             	cmp    $0x64,%ebx
  800cd9:	7f 0b                	jg     800ce6 <vprintfmt+0x15a>
  800cdb:	8b 34 9d 00 24 80 00 	mov    0x802400(,%ebx,4),%esi
  800ce2:	85 f6                	test   %esi,%esi
  800ce4:	75 19                	jne    800cff <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ce6:	53                   	push   %ebx
  800ce7:	68 a5 25 80 00       	push   $0x8025a5
  800cec:	ff 75 0c             	pushl  0xc(%ebp)
  800cef:	ff 75 08             	pushl  0x8(%ebp)
  800cf2:	e8 5e 02 00 00       	call   800f55 <printfmt>
  800cf7:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cfa:	e9 49 02 00 00       	jmp    800f48 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cff:	56                   	push   %esi
  800d00:	68 ae 25 80 00       	push   $0x8025ae
  800d05:	ff 75 0c             	pushl  0xc(%ebp)
  800d08:	ff 75 08             	pushl  0x8(%ebp)
  800d0b:	e8 45 02 00 00       	call   800f55 <printfmt>
  800d10:	83 c4 10             	add    $0x10,%esp
			break;
  800d13:	e9 30 02 00 00       	jmp    800f48 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d18:	8b 45 14             	mov    0x14(%ebp),%eax
  800d1b:	83 c0 04             	add    $0x4,%eax
  800d1e:	89 45 14             	mov    %eax,0x14(%ebp)
  800d21:	8b 45 14             	mov    0x14(%ebp),%eax
  800d24:	83 e8 04             	sub    $0x4,%eax
  800d27:	8b 30                	mov    (%eax),%esi
  800d29:	85 f6                	test   %esi,%esi
  800d2b:	75 05                	jne    800d32 <vprintfmt+0x1a6>
				p = "(null)";
  800d2d:	be b1 25 80 00       	mov    $0x8025b1,%esi
			if (width > 0 && padc != '-')
  800d32:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d36:	7e 6d                	jle    800da5 <vprintfmt+0x219>
  800d38:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d3c:	74 67                	je     800da5 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d3e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d41:	83 ec 08             	sub    $0x8,%esp
  800d44:	50                   	push   %eax
  800d45:	56                   	push   %esi
  800d46:	e8 0c 03 00 00       	call   801057 <strnlen>
  800d4b:	83 c4 10             	add    $0x10,%esp
  800d4e:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d51:	eb 16                	jmp    800d69 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d53:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d57:	83 ec 08             	sub    $0x8,%esp
  800d5a:	ff 75 0c             	pushl  0xc(%ebp)
  800d5d:	50                   	push   %eax
  800d5e:	8b 45 08             	mov    0x8(%ebp),%eax
  800d61:	ff d0                	call   *%eax
  800d63:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d66:	ff 4d e4             	decl   -0x1c(%ebp)
  800d69:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d6d:	7f e4                	jg     800d53 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6f:	eb 34                	jmp    800da5 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d71:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d75:	74 1c                	je     800d93 <vprintfmt+0x207>
  800d77:	83 fb 1f             	cmp    $0x1f,%ebx
  800d7a:	7e 05                	jle    800d81 <vprintfmt+0x1f5>
  800d7c:	83 fb 7e             	cmp    $0x7e,%ebx
  800d7f:	7e 12                	jle    800d93 <vprintfmt+0x207>
					putch('?', putdat);
  800d81:	83 ec 08             	sub    $0x8,%esp
  800d84:	ff 75 0c             	pushl  0xc(%ebp)
  800d87:	6a 3f                	push   $0x3f
  800d89:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8c:	ff d0                	call   *%eax
  800d8e:	83 c4 10             	add    $0x10,%esp
  800d91:	eb 0f                	jmp    800da2 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d93:	83 ec 08             	sub    $0x8,%esp
  800d96:	ff 75 0c             	pushl  0xc(%ebp)
  800d99:	53                   	push   %ebx
  800d9a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9d:	ff d0                	call   *%eax
  800d9f:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800da2:	ff 4d e4             	decl   -0x1c(%ebp)
  800da5:	89 f0                	mov    %esi,%eax
  800da7:	8d 70 01             	lea    0x1(%eax),%esi
  800daa:	8a 00                	mov    (%eax),%al
  800dac:	0f be d8             	movsbl %al,%ebx
  800daf:	85 db                	test   %ebx,%ebx
  800db1:	74 24                	je     800dd7 <vprintfmt+0x24b>
  800db3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800db7:	78 b8                	js     800d71 <vprintfmt+0x1e5>
  800db9:	ff 4d e0             	decl   -0x20(%ebp)
  800dbc:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dc0:	79 af                	jns    800d71 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dc2:	eb 13                	jmp    800dd7 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dc4:	83 ec 08             	sub    $0x8,%esp
  800dc7:	ff 75 0c             	pushl  0xc(%ebp)
  800dca:	6a 20                	push   $0x20
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	ff d0                	call   *%eax
  800dd1:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd4:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd7:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ddb:	7f e7                	jg     800dc4 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800ddd:	e9 66 01 00 00       	jmp    800f48 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800de2:	83 ec 08             	sub    $0x8,%esp
  800de5:	ff 75 e8             	pushl  -0x18(%ebp)
  800de8:	8d 45 14             	lea    0x14(%ebp),%eax
  800deb:	50                   	push   %eax
  800dec:	e8 3c fd ff ff       	call   800b2d <getint>
  800df1:	83 c4 10             	add    $0x10,%esp
  800df4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800dfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800dfd:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e00:	85 d2                	test   %edx,%edx
  800e02:	79 23                	jns    800e27 <vprintfmt+0x29b>
				putch('-', putdat);
  800e04:	83 ec 08             	sub    $0x8,%esp
  800e07:	ff 75 0c             	pushl  0xc(%ebp)
  800e0a:	6a 2d                	push   $0x2d
  800e0c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0f:	ff d0                	call   *%eax
  800e11:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e14:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e17:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e1a:	f7 d8                	neg    %eax
  800e1c:	83 d2 00             	adc    $0x0,%edx
  800e1f:	f7 da                	neg    %edx
  800e21:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e24:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e27:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e2e:	e9 bc 00 00 00       	jmp    800eef <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e33:	83 ec 08             	sub    $0x8,%esp
  800e36:	ff 75 e8             	pushl  -0x18(%ebp)
  800e39:	8d 45 14             	lea    0x14(%ebp),%eax
  800e3c:	50                   	push   %eax
  800e3d:	e8 84 fc ff ff       	call   800ac6 <getuint>
  800e42:	83 c4 10             	add    $0x10,%esp
  800e45:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e48:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e4b:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e52:	e9 98 00 00 00       	jmp    800eef <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e57:	83 ec 08             	sub    $0x8,%esp
  800e5a:	ff 75 0c             	pushl  0xc(%ebp)
  800e5d:	6a 58                	push   $0x58
  800e5f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e62:	ff d0                	call   *%eax
  800e64:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e67:	83 ec 08             	sub    $0x8,%esp
  800e6a:	ff 75 0c             	pushl  0xc(%ebp)
  800e6d:	6a 58                	push   $0x58
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	ff d0                	call   *%eax
  800e74:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e77:	83 ec 08             	sub    $0x8,%esp
  800e7a:	ff 75 0c             	pushl  0xc(%ebp)
  800e7d:	6a 58                	push   $0x58
  800e7f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e82:	ff d0                	call   *%eax
  800e84:	83 c4 10             	add    $0x10,%esp
			break;
  800e87:	e9 bc 00 00 00       	jmp    800f48 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e8c:	83 ec 08             	sub    $0x8,%esp
  800e8f:	ff 75 0c             	pushl  0xc(%ebp)
  800e92:	6a 30                	push   $0x30
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
  800e97:	ff d0                	call   *%eax
  800e99:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e9c:	83 ec 08             	sub    $0x8,%esp
  800e9f:	ff 75 0c             	pushl  0xc(%ebp)
  800ea2:	6a 78                	push   $0x78
  800ea4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea7:	ff d0                	call   *%eax
  800ea9:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800eac:	8b 45 14             	mov    0x14(%ebp),%eax
  800eaf:	83 c0 04             	add    $0x4,%eax
  800eb2:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb5:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb8:	83 e8 04             	sub    $0x4,%eax
  800ebb:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800ebd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ec0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ec7:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800ece:	eb 1f                	jmp    800eef <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ed0:	83 ec 08             	sub    $0x8,%esp
  800ed3:	ff 75 e8             	pushl  -0x18(%ebp)
  800ed6:	8d 45 14             	lea    0x14(%ebp),%eax
  800ed9:	50                   	push   %eax
  800eda:	e8 e7 fb ff ff       	call   800ac6 <getuint>
  800edf:	83 c4 10             	add    $0x10,%esp
  800ee2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee5:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ee8:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eef:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800ef3:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ef6:	83 ec 04             	sub    $0x4,%esp
  800ef9:	52                   	push   %edx
  800efa:	ff 75 e4             	pushl  -0x1c(%ebp)
  800efd:	50                   	push   %eax
  800efe:	ff 75 f4             	pushl  -0xc(%ebp)
  800f01:	ff 75 f0             	pushl  -0x10(%ebp)
  800f04:	ff 75 0c             	pushl  0xc(%ebp)
  800f07:	ff 75 08             	pushl  0x8(%ebp)
  800f0a:	e8 00 fb ff ff       	call   800a0f <printnum>
  800f0f:	83 c4 20             	add    $0x20,%esp
			break;
  800f12:	eb 34                	jmp    800f48 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f14:	83 ec 08             	sub    $0x8,%esp
  800f17:	ff 75 0c             	pushl  0xc(%ebp)
  800f1a:	53                   	push   %ebx
  800f1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1e:	ff d0                	call   *%eax
  800f20:	83 c4 10             	add    $0x10,%esp
			break;
  800f23:	eb 23                	jmp    800f48 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f25:	83 ec 08             	sub    $0x8,%esp
  800f28:	ff 75 0c             	pushl  0xc(%ebp)
  800f2b:	6a 25                	push   $0x25
  800f2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800f30:	ff d0                	call   *%eax
  800f32:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f35:	ff 4d 10             	decl   0x10(%ebp)
  800f38:	eb 03                	jmp    800f3d <vprintfmt+0x3b1>
  800f3a:	ff 4d 10             	decl   0x10(%ebp)
  800f3d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f40:	48                   	dec    %eax
  800f41:	8a 00                	mov    (%eax),%al
  800f43:	3c 25                	cmp    $0x25,%al
  800f45:	75 f3                	jne    800f3a <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f47:	90                   	nop
		}
	}
  800f48:	e9 47 fc ff ff       	jmp    800b94 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f4d:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f4e:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f51:	5b                   	pop    %ebx
  800f52:	5e                   	pop    %esi
  800f53:	5d                   	pop    %ebp
  800f54:	c3                   	ret    

00800f55 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f55:	55                   	push   %ebp
  800f56:	89 e5                	mov    %esp,%ebp
  800f58:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f5b:	8d 45 10             	lea    0x10(%ebp),%eax
  800f5e:	83 c0 04             	add    $0x4,%eax
  800f61:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f64:	8b 45 10             	mov    0x10(%ebp),%eax
  800f67:	ff 75 f4             	pushl  -0xc(%ebp)
  800f6a:	50                   	push   %eax
  800f6b:	ff 75 0c             	pushl  0xc(%ebp)
  800f6e:	ff 75 08             	pushl  0x8(%ebp)
  800f71:	e8 16 fc ff ff       	call   800b8c <vprintfmt>
  800f76:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f79:	90                   	nop
  800f7a:	c9                   	leave  
  800f7b:	c3                   	ret    

00800f7c <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f7c:	55                   	push   %ebp
  800f7d:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f82:	8b 40 08             	mov    0x8(%eax),%eax
  800f85:	8d 50 01             	lea    0x1(%eax),%edx
  800f88:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8b:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f8e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f91:	8b 10                	mov    (%eax),%edx
  800f93:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f96:	8b 40 04             	mov    0x4(%eax),%eax
  800f99:	39 c2                	cmp    %eax,%edx
  800f9b:	73 12                	jae    800faf <sprintputch+0x33>
		*b->buf++ = ch;
  800f9d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa0:	8b 00                	mov    (%eax),%eax
  800fa2:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa8:	89 0a                	mov    %ecx,(%edx)
  800faa:	8b 55 08             	mov    0x8(%ebp),%edx
  800fad:	88 10                	mov    %dl,(%eax)
}
  800faf:	90                   	nop
  800fb0:	5d                   	pop    %ebp
  800fb1:	c3                   	ret    

00800fb2 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fb2:	55                   	push   %ebp
  800fb3:	89 e5                	mov    %esp,%ebp
  800fb5:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fb8:	8b 45 08             	mov    0x8(%ebp),%eax
  800fbb:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc7:	01 d0                	add    %edx,%eax
  800fc9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fcc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fd3:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fd7:	74 06                	je     800fdf <vsnprintf+0x2d>
  800fd9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fdd:	7f 07                	jg     800fe6 <vsnprintf+0x34>
		return -E_INVAL;
  800fdf:	b8 03 00 00 00       	mov    $0x3,%eax
  800fe4:	eb 20                	jmp    801006 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fe6:	ff 75 14             	pushl  0x14(%ebp)
  800fe9:	ff 75 10             	pushl  0x10(%ebp)
  800fec:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800fef:	50                   	push   %eax
  800ff0:	68 7c 0f 80 00       	push   $0x800f7c
  800ff5:	e8 92 fb ff ff       	call   800b8c <vprintfmt>
  800ffa:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ffd:	8b 45 ec             	mov    -0x14(%ebp),%eax
  801000:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  801003:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801006:	c9                   	leave  
  801007:	c3                   	ret    

00801008 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801008:	55                   	push   %ebp
  801009:	89 e5                	mov    %esp,%ebp
  80100b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80100e:	8d 45 10             	lea    0x10(%ebp),%eax
  801011:	83 c0 04             	add    $0x4,%eax
  801014:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801017:	8b 45 10             	mov    0x10(%ebp),%eax
  80101a:	ff 75 f4             	pushl  -0xc(%ebp)
  80101d:	50                   	push   %eax
  80101e:	ff 75 0c             	pushl  0xc(%ebp)
  801021:	ff 75 08             	pushl  0x8(%ebp)
  801024:	e8 89 ff ff ff       	call   800fb2 <vsnprintf>
  801029:	83 c4 10             	add    $0x10,%esp
  80102c:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80102f:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801032:	c9                   	leave  
  801033:	c3                   	ret    

00801034 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801034:	55                   	push   %ebp
  801035:	89 e5                	mov    %esp,%ebp
  801037:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  80103a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801041:	eb 06                	jmp    801049 <strlen+0x15>
		n++;
  801043:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801046:	ff 45 08             	incl   0x8(%ebp)
  801049:	8b 45 08             	mov    0x8(%ebp),%eax
  80104c:	8a 00                	mov    (%eax),%al
  80104e:	84 c0                	test   %al,%al
  801050:	75 f1                	jne    801043 <strlen+0xf>
		n++;
	return n;
  801052:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801055:	c9                   	leave  
  801056:	c3                   	ret    

00801057 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801057:	55                   	push   %ebp
  801058:	89 e5                	mov    %esp,%ebp
  80105a:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  80105d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801064:	eb 09                	jmp    80106f <strnlen+0x18>
		n++;
  801066:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801069:	ff 45 08             	incl   0x8(%ebp)
  80106c:	ff 4d 0c             	decl   0xc(%ebp)
  80106f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801073:	74 09                	je     80107e <strnlen+0x27>
  801075:	8b 45 08             	mov    0x8(%ebp),%eax
  801078:	8a 00                	mov    (%eax),%al
  80107a:	84 c0                	test   %al,%al
  80107c:	75 e8                	jne    801066 <strnlen+0xf>
		n++;
	return n;
  80107e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801081:	c9                   	leave  
  801082:	c3                   	ret    

00801083 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  801083:	55                   	push   %ebp
  801084:	89 e5                	mov    %esp,%ebp
  801086:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801089:	8b 45 08             	mov    0x8(%ebp),%eax
  80108c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80108f:	90                   	nop
  801090:	8b 45 08             	mov    0x8(%ebp),%eax
  801093:	8d 50 01             	lea    0x1(%eax),%edx
  801096:	89 55 08             	mov    %edx,0x8(%ebp)
  801099:	8b 55 0c             	mov    0xc(%ebp),%edx
  80109c:	8d 4a 01             	lea    0x1(%edx),%ecx
  80109f:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  8010a2:	8a 12                	mov    (%edx),%dl
  8010a4:	88 10                	mov    %dl,(%eax)
  8010a6:	8a 00                	mov    (%eax),%al
  8010a8:	84 c0                	test   %al,%al
  8010aa:	75 e4                	jne    801090 <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010af:	c9                   	leave  
  8010b0:	c3                   	ret    

008010b1 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010b1:	55                   	push   %ebp
  8010b2:	89 e5                	mov    %esp,%ebp
  8010b4:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010b7:	8b 45 08             	mov    0x8(%ebp),%eax
  8010ba:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010bd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010c4:	eb 1f                	jmp    8010e5 <strncpy+0x34>
		*dst++ = *src;
  8010c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c9:	8d 50 01             	lea    0x1(%eax),%edx
  8010cc:	89 55 08             	mov    %edx,0x8(%ebp)
  8010cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010d2:	8a 12                	mov    (%edx),%dl
  8010d4:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010d6:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d9:	8a 00                	mov    (%eax),%al
  8010db:	84 c0                	test   %al,%al
  8010dd:	74 03                	je     8010e2 <strncpy+0x31>
			src++;
  8010df:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010e2:	ff 45 fc             	incl   -0x4(%ebp)
  8010e5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e8:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010eb:	72 d9                	jb     8010c6 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010ed:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010f0:	c9                   	leave  
  8010f1:	c3                   	ret    

008010f2 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010f2:	55                   	push   %ebp
  8010f3:	89 e5                	mov    %esp,%ebp
  8010f5:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010f8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010fb:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010fe:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801102:	74 30                	je     801134 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801104:	eb 16                	jmp    80111c <strlcpy+0x2a>
			*dst++ = *src++;
  801106:	8b 45 08             	mov    0x8(%ebp),%eax
  801109:	8d 50 01             	lea    0x1(%eax),%edx
  80110c:	89 55 08             	mov    %edx,0x8(%ebp)
  80110f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801112:	8d 4a 01             	lea    0x1(%edx),%ecx
  801115:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801118:	8a 12                	mov    (%edx),%dl
  80111a:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  80111c:	ff 4d 10             	decl   0x10(%ebp)
  80111f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801123:	74 09                	je     80112e <strlcpy+0x3c>
  801125:	8b 45 0c             	mov    0xc(%ebp),%eax
  801128:	8a 00                	mov    (%eax),%al
  80112a:	84 c0                	test   %al,%al
  80112c:	75 d8                	jne    801106 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80112e:	8b 45 08             	mov    0x8(%ebp),%eax
  801131:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801134:	8b 55 08             	mov    0x8(%ebp),%edx
  801137:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80113a:	29 c2                	sub    %eax,%edx
  80113c:	89 d0                	mov    %edx,%eax
}
  80113e:	c9                   	leave  
  80113f:	c3                   	ret    

00801140 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  801140:	55                   	push   %ebp
  801141:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  801143:	eb 06                	jmp    80114b <strcmp+0xb>
		p++, q++;
  801145:	ff 45 08             	incl   0x8(%ebp)
  801148:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  80114b:	8b 45 08             	mov    0x8(%ebp),%eax
  80114e:	8a 00                	mov    (%eax),%al
  801150:	84 c0                	test   %al,%al
  801152:	74 0e                	je     801162 <strcmp+0x22>
  801154:	8b 45 08             	mov    0x8(%ebp),%eax
  801157:	8a 10                	mov    (%eax),%dl
  801159:	8b 45 0c             	mov    0xc(%ebp),%eax
  80115c:	8a 00                	mov    (%eax),%al
  80115e:	38 c2                	cmp    %al,%dl
  801160:	74 e3                	je     801145 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	0f b6 d0             	movzbl %al,%edx
  80116a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116d:	8a 00                	mov    (%eax),%al
  80116f:	0f b6 c0             	movzbl %al,%eax
  801172:	29 c2                	sub    %eax,%edx
  801174:	89 d0                	mov    %edx,%eax
}
  801176:	5d                   	pop    %ebp
  801177:	c3                   	ret    

00801178 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801178:	55                   	push   %ebp
  801179:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  80117b:	eb 09                	jmp    801186 <strncmp+0xe>
		n--, p++, q++;
  80117d:	ff 4d 10             	decl   0x10(%ebp)
  801180:	ff 45 08             	incl   0x8(%ebp)
  801183:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801186:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80118a:	74 17                	je     8011a3 <strncmp+0x2b>
  80118c:	8b 45 08             	mov    0x8(%ebp),%eax
  80118f:	8a 00                	mov    (%eax),%al
  801191:	84 c0                	test   %al,%al
  801193:	74 0e                	je     8011a3 <strncmp+0x2b>
  801195:	8b 45 08             	mov    0x8(%ebp),%eax
  801198:	8a 10                	mov    (%eax),%dl
  80119a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80119d:	8a 00                	mov    (%eax),%al
  80119f:	38 c2                	cmp    %al,%dl
  8011a1:	74 da                	je     80117d <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  8011a3:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a7:	75 07                	jne    8011b0 <strncmp+0x38>
		return 0;
  8011a9:	b8 00 00 00 00       	mov    $0x0,%eax
  8011ae:	eb 14                	jmp    8011c4 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011b0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b3:	8a 00                	mov    (%eax),%al
  8011b5:	0f b6 d0             	movzbl %al,%edx
  8011b8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011bb:	8a 00                	mov    (%eax),%al
  8011bd:	0f b6 c0             	movzbl %al,%eax
  8011c0:	29 c2                	sub    %eax,%edx
  8011c2:	89 d0                	mov    %edx,%eax
}
  8011c4:	5d                   	pop    %ebp
  8011c5:	c3                   	ret    

008011c6 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011c6:	55                   	push   %ebp
  8011c7:	89 e5                	mov    %esp,%ebp
  8011c9:	83 ec 04             	sub    $0x4,%esp
  8011cc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cf:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011d2:	eb 12                	jmp    8011e6 <strchr+0x20>
		if (*s == c)
  8011d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d7:	8a 00                	mov    (%eax),%al
  8011d9:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011dc:	75 05                	jne    8011e3 <strchr+0x1d>
			return (char *) s;
  8011de:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e1:	eb 11                	jmp    8011f4 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011e3:	ff 45 08             	incl   0x8(%ebp)
  8011e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e9:	8a 00                	mov    (%eax),%al
  8011eb:	84 c0                	test   %al,%al
  8011ed:	75 e5                	jne    8011d4 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011f4:	c9                   	leave  
  8011f5:	c3                   	ret    

008011f6 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011f6:	55                   	push   %ebp
  8011f7:	89 e5                	mov    %esp,%ebp
  8011f9:	83 ec 04             	sub    $0x4,%esp
  8011fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ff:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  801202:	eb 0d                	jmp    801211 <strfind+0x1b>
		if (*s == c)
  801204:	8b 45 08             	mov    0x8(%ebp),%eax
  801207:	8a 00                	mov    (%eax),%al
  801209:	3a 45 fc             	cmp    -0x4(%ebp),%al
  80120c:	74 0e                	je     80121c <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80120e:	ff 45 08             	incl   0x8(%ebp)
  801211:	8b 45 08             	mov    0x8(%ebp),%eax
  801214:	8a 00                	mov    (%eax),%al
  801216:	84 c0                	test   %al,%al
  801218:	75 ea                	jne    801204 <strfind+0xe>
  80121a:	eb 01                	jmp    80121d <strfind+0x27>
		if (*s == c)
			break;
  80121c:	90                   	nop
	return (char *) s;
  80121d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801220:	c9                   	leave  
  801221:	c3                   	ret    

00801222 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  801222:	55                   	push   %ebp
  801223:	89 e5                	mov    %esp,%ebp
  801225:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801228:	8b 45 08             	mov    0x8(%ebp),%eax
  80122b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80122e:	8b 45 10             	mov    0x10(%ebp),%eax
  801231:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801234:	eb 0e                	jmp    801244 <memset+0x22>
		*p++ = c;
  801236:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801239:	8d 50 01             	lea    0x1(%eax),%edx
  80123c:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80123f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801242:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801244:	ff 4d f8             	decl   -0x8(%ebp)
  801247:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  80124b:	79 e9                	jns    801236 <memset+0x14>
		*p++ = c;

	return v;
  80124d:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801250:	c9                   	leave  
  801251:	c3                   	ret    

00801252 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  801252:	55                   	push   %ebp
  801253:	89 e5                	mov    %esp,%ebp
  801255:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801258:	8b 45 0c             	mov    0xc(%ebp),%eax
  80125b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80125e:	8b 45 08             	mov    0x8(%ebp),%eax
  801261:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801264:	eb 16                	jmp    80127c <memcpy+0x2a>
		*d++ = *s++;
  801266:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801269:	8d 50 01             	lea    0x1(%eax),%edx
  80126c:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80126f:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801272:	8d 4a 01             	lea    0x1(%edx),%ecx
  801275:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801278:	8a 12                	mov    (%edx),%dl
  80127a:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80127c:	8b 45 10             	mov    0x10(%ebp),%eax
  80127f:	8d 50 ff             	lea    -0x1(%eax),%edx
  801282:	89 55 10             	mov    %edx,0x10(%ebp)
  801285:	85 c0                	test   %eax,%eax
  801287:	75 dd                	jne    801266 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801289:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80128c:	c9                   	leave  
  80128d:	c3                   	ret    

0080128e <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80128e:	55                   	push   %ebp
  80128f:	89 e5                	mov    %esp,%ebp
  801291:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801294:	8b 45 0c             	mov    0xc(%ebp),%eax
  801297:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80129a:	8b 45 08             	mov    0x8(%ebp),%eax
  80129d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  8012a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012a3:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012a6:	73 50                	jae    8012f8 <memmove+0x6a>
  8012a8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ab:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ae:	01 d0                	add    %edx,%eax
  8012b0:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012b3:	76 43                	jbe    8012f8 <memmove+0x6a>
		s += n;
  8012b5:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b8:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012bb:	8b 45 10             	mov    0x10(%ebp),%eax
  8012be:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012c1:	eb 10                	jmp    8012d3 <memmove+0x45>
			*--d = *--s;
  8012c3:	ff 4d f8             	decl   -0x8(%ebp)
  8012c6:	ff 4d fc             	decl   -0x4(%ebp)
  8012c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012cc:	8a 10                	mov    (%eax),%dl
  8012ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012d1:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d6:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d9:	89 55 10             	mov    %edx,0x10(%ebp)
  8012dc:	85 c0                	test   %eax,%eax
  8012de:	75 e3                	jne    8012c3 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012e0:	eb 23                	jmp    801305 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e5:	8d 50 01             	lea    0x1(%eax),%edx
  8012e8:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012eb:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ee:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012f1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012f4:	8a 12                	mov    (%edx),%dl
  8012f6:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012f8:	8b 45 10             	mov    0x10(%ebp),%eax
  8012fb:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012fe:	89 55 10             	mov    %edx,0x10(%ebp)
  801301:	85 c0                	test   %eax,%eax
  801303:	75 dd                	jne    8012e2 <memmove+0x54>
			*d++ = *s++;

	return dst;
  801305:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801308:	c9                   	leave  
  801309:	c3                   	ret    

0080130a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  80130a:	55                   	push   %ebp
  80130b:	89 e5                	mov    %esp,%ebp
  80130d:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  801310:	8b 45 08             	mov    0x8(%ebp),%eax
  801313:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801316:	8b 45 0c             	mov    0xc(%ebp),%eax
  801319:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  80131c:	eb 2a                	jmp    801348 <memcmp+0x3e>
		if (*s1 != *s2)
  80131e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801321:	8a 10                	mov    (%eax),%dl
  801323:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801326:	8a 00                	mov    (%eax),%al
  801328:	38 c2                	cmp    %al,%dl
  80132a:	74 16                	je     801342 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  80132c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132f:	8a 00                	mov    (%eax),%al
  801331:	0f b6 d0             	movzbl %al,%edx
  801334:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801337:	8a 00                	mov    (%eax),%al
  801339:	0f b6 c0             	movzbl %al,%eax
  80133c:	29 c2                	sub    %eax,%edx
  80133e:	89 d0                	mov    %edx,%eax
  801340:	eb 18                	jmp    80135a <memcmp+0x50>
		s1++, s2++;
  801342:	ff 45 fc             	incl   -0x4(%ebp)
  801345:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801348:	8b 45 10             	mov    0x10(%ebp),%eax
  80134b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80134e:	89 55 10             	mov    %edx,0x10(%ebp)
  801351:	85 c0                	test   %eax,%eax
  801353:	75 c9                	jne    80131e <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801355:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80135a:	c9                   	leave  
  80135b:	c3                   	ret    

0080135c <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  80135c:	55                   	push   %ebp
  80135d:	89 e5                	mov    %esp,%ebp
  80135f:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801362:	8b 55 08             	mov    0x8(%ebp),%edx
  801365:	8b 45 10             	mov    0x10(%ebp),%eax
  801368:	01 d0                	add    %edx,%eax
  80136a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  80136d:	eb 15                	jmp    801384 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80136f:	8b 45 08             	mov    0x8(%ebp),%eax
  801372:	8a 00                	mov    (%eax),%al
  801374:	0f b6 d0             	movzbl %al,%edx
  801377:	8b 45 0c             	mov    0xc(%ebp),%eax
  80137a:	0f b6 c0             	movzbl %al,%eax
  80137d:	39 c2                	cmp    %eax,%edx
  80137f:	74 0d                	je     80138e <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801381:	ff 45 08             	incl   0x8(%ebp)
  801384:	8b 45 08             	mov    0x8(%ebp),%eax
  801387:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80138a:	72 e3                	jb     80136f <memfind+0x13>
  80138c:	eb 01                	jmp    80138f <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80138e:	90                   	nop
	return (void *) s;
  80138f:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801392:	c9                   	leave  
  801393:	c3                   	ret    

00801394 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801394:	55                   	push   %ebp
  801395:	89 e5                	mov    %esp,%ebp
  801397:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80139a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  8013a1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013a8:	eb 03                	jmp    8013ad <strtol+0x19>
		s++;
  8013aa:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b0:	8a 00                	mov    (%eax),%al
  8013b2:	3c 20                	cmp    $0x20,%al
  8013b4:	74 f4                	je     8013aa <strtol+0x16>
  8013b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b9:	8a 00                	mov    (%eax),%al
  8013bb:	3c 09                	cmp    $0x9,%al
  8013bd:	74 eb                	je     8013aa <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8013c2:	8a 00                	mov    (%eax),%al
  8013c4:	3c 2b                	cmp    $0x2b,%al
  8013c6:	75 05                	jne    8013cd <strtol+0x39>
		s++;
  8013c8:	ff 45 08             	incl   0x8(%ebp)
  8013cb:	eb 13                	jmp    8013e0 <strtol+0x4c>
	else if (*s == '-')
  8013cd:	8b 45 08             	mov    0x8(%ebp),%eax
  8013d0:	8a 00                	mov    (%eax),%al
  8013d2:	3c 2d                	cmp    $0x2d,%al
  8013d4:	75 0a                	jne    8013e0 <strtol+0x4c>
		s++, neg = 1;
  8013d6:	ff 45 08             	incl   0x8(%ebp)
  8013d9:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013e0:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e4:	74 06                	je     8013ec <strtol+0x58>
  8013e6:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013ea:	75 20                	jne    80140c <strtol+0x78>
  8013ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ef:	8a 00                	mov    (%eax),%al
  8013f1:	3c 30                	cmp    $0x30,%al
  8013f3:	75 17                	jne    80140c <strtol+0x78>
  8013f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f8:	40                   	inc    %eax
  8013f9:	8a 00                	mov    (%eax),%al
  8013fb:	3c 78                	cmp    $0x78,%al
  8013fd:	75 0d                	jne    80140c <strtol+0x78>
		s += 2, base = 16;
  8013ff:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  801403:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  80140a:	eb 28                	jmp    801434 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  80140c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801410:	75 15                	jne    801427 <strtol+0x93>
  801412:	8b 45 08             	mov    0x8(%ebp),%eax
  801415:	8a 00                	mov    (%eax),%al
  801417:	3c 30                	cmp    $0x30,%al
  801419:	75 0c                	jne    801427 <strtol+0x93>
		s++, base = 8;
  80141b:	ff 45 08             	incl   0x8(%ebp)
  80141e:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801425:	eb 0d                	jmp    801434 <strtol+0xa0>
	else if (base == 0)
  801427:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80142b:	75 07                	jne    801434 <strtol+0xa0>
		base = 10;
  80142d:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801434:	8b 45 08             	mov    0x8(%ebp),%eax
  801437:	8a 00                	mov    (%eax),%al
  801439:	3c 2f                	cmp    $0x2f,%al
  80143b:	7e 19                	jle    801456 <strtol+0xc2>
  80143d:	8b 45 08             	mov    0x8(%ebp),%eax
  801440:	8a 00                	mov    (%eax),%al
  801442:	3c 39                	cmp    $0x39,%al
  801444:	7f 10                	jg     801456 <strtol+0xc2>
			dig = *s - '0';
  801446:	8b 45 08             	mov    0x8(%ebp),%eax
  801449:	8a 00                	mov    (%eax),%al
  80144b:	0f be c0             	movsbl %al,%eax
  80144e:	83 e8 30             	sub    $0x30,%eax
  801451:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801454:	eb 42                	jmp    801498 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801456:	8b 45 08             	mov    0x8(%ebp),%eax
  801459:	8a 00                	mov    (%eax),%al
  80145b:	3c 60                	cmp    $0x60,%al
  80145d:	7e 19                	jle    801478 <strtol+0xe4>
  80145f:	8b 45 08             	mov    0x8(%ebp),%eax
  801462:	8a 00                	mov    (%eax),%al
  801464:	3c 7a                	cmp    $0x7a,%al
  801466:	7f 10                	jg     801478 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801468:	8b 45 08             	mov    0x8(%ebp),%eax
  80146b:	8a 00                	mov    (%eax),%al
  80146d:	0f be c0             	movsbl %al,%eax
  801470:	83 e8 57             	sub    $0x57,%eax
  801473:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801476:	eb 20                	jmp    801498 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801478:	8b 45 08             	mov    0x8(%ebp),%eax
  80147b:	8a 00                	mov    (%eax),%al
  80147d:	3c 40                	cmp    $0x40,%al
  80147f:	7e 39                	jle    8014ba <strtol+0x126>
  801481:	8b 45 08             	mov    0x8(%ebp),%eax
  801484:	8a 00                	mov    (%eax),%al
  801486:	3c 5a                	cmp    $0x5a,%al
  801488:	7f 30                	jg     8014ba <strtol+0x126>
			dig = *s - 'A' + 10;
  80148a:	8b 45 08             	mov    0x8(%ebp),%eax
  80148d:	8a 00                	mov    (%eax),%al
  80148f:	0f be c0             	movsbl %al,%eax
  801492:	83 e8 37             	sub    $0x37,%eax
  801495:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801498:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80149b:	3b 45 10             	cmp    0x10(%ebp),%eax
  80149e:	7d 19                	jge    8014b9 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8014a0:	ff 45 08             	incl   0x8(%ebp)
  8014a3:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a6:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014aa:	89 c2                	mov    %eax,%edx
  8014ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014af:	01 d0                	add    %edx,%eax
  8014b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014b4:	e9 7b ff ff ff       	jmp    801434 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014b9:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014ba:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014be:	74 08                	je     8014c8 <strtol+0x134>
		*endptr = (char *) s;
  8014c0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014c3:	8b 55 08             	mov    0x8(%ebp),%edx
  8014c6:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014c8:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014cc:	74 07                	je     8014d5 <strtol+0x141>
  8014ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014d1:	f7 d8                	neg    %eax
  8014d3:	eb 03                	jmp    8014d8 <strtol+0x144>
  8014d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014d8:	c9                   	leave  
  8014d9:	c3                   	ret    

008014da <ltostr>:

void
ltostr(long value, char *str)
{
  8014da:	55                   	push   %ebp
  8014db:	89 e5                	mov    %esp,%ebp
  8014dd:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014e0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014e7:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014ee:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014f2:	79 13                	jns    801507 <ltostr+0x2d>
	{
		neg = 1;
  8014f4:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014fb:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fe:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801501:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801504:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801507:	8b 45 08             	mov    0x8(%ebp),%eax
  80150a:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80150f:	99                   	cltd   
  801510:	f7 f9                	idiv   %ecx
  801512:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801515:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801518:	8d 50 01             	lea    0x1(%eax),%edx
  80151b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80151e:	89 c2                	mov    %eax,%edx
  801520:	8b 45 0c             	mov    0xc(%ebp),%eax
  801523:	01 d0                	add    %edx,%eax
  801525:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801528:	83 c2 30             	add    $0x30,%edx
  80152b:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  80152d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801530:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801535:	f7 e9                	imul   %ecx
  801537:	c1 fa 02             	sar    $0x2,%edx
  80153a:	89 c8                	mov    %ecx,%eax
  80153c:	c1 f8 1f             	sar    $0x1f,%eax
  80153f:	29 c2                	sub    %eax,%edx
  801541:	89 d0                	mov    %edx,%eax
  801543:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801546:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801549:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80154e:	f7 e9                	imul   %ecx
  801550:	c1 fa 02             	sar    $0x2,%edx
  801553:	89 c8                	mov    %ecx,%eax
  801555:	c1 f8 1f             	sar    $0x1f,%eax
  801558:	29 c2                	sub    %eax,%edx
  80155a:	89 d0                	mov    %edx,%eax
  80155c:	c1 e0 02             	shl    $0x2,%eax
  80155f:	01 d0                	add    %edx,%eax
  801561:	01 c0                	add    %eax,%eax
  801563:	29 c1                	sub    %eax,%ecx
  801565:	89 ca                	mov    %ecx,%edx
  801567:	85 d2                	test   %edx,%edx
  801569:	75 9c                	jne    801507 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80156b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801572:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801575:	48                   	dec    %eax
  801576:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801579:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80157d:	74 3d                	je     8015bc <ltostr+0xe2>
		start = 1 ;
  80157f:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801586:	eb 34                	jmp    8015bc <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801588:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80158b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158e:	01 d0                	add    %edx,%eax
  801590:	8a 00                	mov    (%eax),%al
  801592:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801595:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801598:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159b:	01 c2                	add    %eax,%edx
  80159d:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8015a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015a3:	01 c8                	add    %ecx,%eax
  8015a5:	8a 00                	mov    (%eax),%al
  8015a7:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015a9:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015af:	01 c2                	add    %eax,%edx
  8015b1:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015b4:	88 02                	mov    %al,(%edx)
		start++ ;
  8015b6:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015b9:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015bc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015bf:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015c2:	7c c4                	jl     801588 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015c4:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015c7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ca:	01 d0                	add    %edx,%eax
  8015cc:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015cf:	90                   	nop
  8015d0:	c9                   	leave  
  8015d1:	c3                   	ret    

008015d2 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015d2:	55                   	push   %ebp
  8015d3:	89 e5                	mov    %esp,%ebp
  8015d5:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015d8:	ff 75 08             	pushl  0x8(%ebp)
  8015db:	e8 54 fa ff ff       	call   801034 <strlen>
  8015e0:	83 c4 04             	add    $0x4,%esp
  8015e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015e6:	ff 75 0c             	pushl  0xc(%ebp)
  8015e9:	e8 46 fa ff ff       	call   801034 <strlen>
  8015ee:	83 c4 04             	add    $0x4,%esp
  8015f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015f4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015fb:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801602:	eb 17                	jmp    80161b <strcconcat+0x49>
		final[s] = str1[s] ;
  801604:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801607:	8b 45 10             	mov    0x10(%ebp),%eax
  80160a:	01 c2                	add    %eax,%edx
  80160c:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80160f:	8b 45 08             	mov    0x8(%ebp),%eax
  801612:	01 c8                	add    %ecx,%eax
  801614:	8a 00                	mov    (%eax),%al
  801616:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801618:	ff 45 fc             	incl   -0x4(%ebp)
  80161b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80161e:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801621:	7c e1                	jl     801604 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  801623:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  80162a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801631:	eb 1f                	jmp    801652 <strcconcat+0x80>
		final[s++] = str2[i] ;
  801633:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801636:	8d 50 01             	lea    0x1(%eax),%edx
  801639:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80163c:	89 c2                	mov    %eax,%edx
  80163e:	8b 45 10             	mov    0x10(%ebp),%eax
  801641:	01 c2                	add    %eax,%edx
  801643:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801646:	8b 45 0c             	mov    0xc(%ebp),%eax
  801649:	01 c8                	add    %ecx,%eax
  80164b:	8a 00                	mov    (%eax),%al
  80164d:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80164f:	ff 45 f8             	incl   -0x8(%ebp)
  801652:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801655:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801658:	7c d9                	jl     801633 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  80165a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80165d:	8b 45 10             	mov    0x10(%ebp),%eax
  801660:	01 d0                	add    %edx,%eax
  801662:	c6 00 00             	movb   $0x0,(%eax)
}
  801665:	90                   	nop
  801666:	c9                   	leave  
  801667:	c3                   	ret    

00801668 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801668:	55                   	push   %ebp
  801669:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80166b:	8b 45 14             	mov    0x14(%ebp),%eax
  80166e:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801674:	8b 45 14             	mov    0x14(%ebp),%eax
  801677:	8b 00                	mov    (%eax),%eax
  801679:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801680:	8b 45 10             	mov    0x10(%ebp),%eax
  801683:	01 d0                	add    %edx,%eax
  801685:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80168b:	eb 0c                	jmp    801699 <strsplit+0x31>
			*string++ = 0;
  80168d:	8b 45 08             	mov    0x8(%ebp),%eax
  801690:	8d 50 01             	lea    0x1(%eax),%edx
  801693:	89 55 08             	mov    %edx,0x8(%ebp)
  801696:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801699:	8b 45 08             	mov    0x8(%ebp),%eax
  80169c:	8a 00                	mov    (%eax),%al
  80169e:	84 c0                	test   %al,%al
  8016a0:	74 18                	je     8016ba <strsplit+0x52>
  8016a2:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a5:	8a 00                	mov    (%eax),%al
  8016a7:	0f be c0             	movsbl %al,%eax
  8016aa:	50                   	push   %eax
  8016ab:	ff 75 0c             	pushl  0xc(%ebp)
  8016ae:	e8 13 fb ff ff       	call   8011c6 <strchr>
  8016b3:	83 c4 08             	add    $0x8,%esp
  8016b6:	85 c0                	test   %eax,%eax
  8016b8:	75 d3                	jne    80168d <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8016bd:	8a 00                	mov    (%eax),%al
  8016bf:	84 c0                	test   %al,%al
  8016c1:	74 5a                	je     80171d <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016c3:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c6:	8b 00                	mov    (%eax),%eax
  8016c8:	83 f8 0f             	cmp    $0xf,%eax
  8016cb:	75 07                	jne    8016d4 <strsplit+0x6c>
		{
			return 0;
  8016cd:	b8 00 00 00 00       	mov    $0x0,%eax
  8016d2:	eb 66                	jmp    80173a <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016d4:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d7:	8b 00                	mov    (%eax),%eax
  8016d9:	8d 48 01             	lea    0x1(%eax),%ecx
  8016dc:	8b 55 14             	mov    0x14(%ebp),%edx
  8016df:	89 0a                	mov    %ecx,(%edx)
  8016e1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8016eb:	01 c2                	add    %eax,%edx
  8016ed:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f0:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016f2:	eb 03                	jmp    8016f7 <strsplit+0x8f>
			string++;
  8016f4:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8016fa:	8a 00                	mov    (%eax),%al
  8016fc:	84 c0                	test   %al,%al
  8016fe:	74 8b                	je     80168b <strsplit+0x23>
  801700:	8b 45 08             	mov    0x8(%ebp),%eax
  801703:	8a 00                	mov    (%eax),%al
  801705:	0f be c0             	movsbl %al,%eax
  801708:	50                   	push   %eax
  801709:	ff 75 0c             	pushl  0xc(%ebp)
  80170c:	e8 b5 fa ff ff       	call   8011c6 <strchr>
  801711:	83 c4 08             	add    $0x8,%esp
  801714:	85 c0                	test   %eax,%eax
  801716:	74 dc                	je     8016f4 <strsplit+0x8c>
			string++;
	}
  801718:	e9 6e ff ff ff       	jmp    80168b <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  80171d:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80171e:	8b 45 14             	mov    0x14(%ebp),%eax
  801721:	8b 00                	mov    (%eax),%eax
  801723:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80172a:	8b 45 10             	mov    0x10(%ebp),%eax
  80172d:	01 d0                	add    %edx,%eax
  80172f:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801735:	b8 01 00 00 00       	mov    $0x1,%eax
}
  80173a:	c9                   	leave  
  80173b:	c3                   	ret    

0080173c <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  80173c:	55                   	push   %ebp
  80173d:	89 e5                	mov    %esp,%ebp
  80173f:	57                   	push   %edi
  801740:	56                   	push   %esi
  801741:	53                   	push   %ebx
  801742:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801745:	8b 45 08             	mov    0x8(%ebp),%eax
  801748:	8b 55 0c             	mov    0xc(%ebp),%edx
  80174b:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80174e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801751:	8b 7d 18             	mov    0x18(%ebp),%edi
  801754:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801757:	cd 30                	int    $0x30
  801759:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  80175c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80175f:	83 c4 10             	add    $0x10,%esp
  801762:	5b                   	pop    %ebx
  801763:	5e                   	pop    %esi
  801764:	5f                   	pop    %edi
  801765:	5d                   	pop    %ebp
  801766:	c3                   	ret    

00801767 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801767:	55                   	push   %ebp
  801768:	89 e5                	mov    %esp,%ebp
  80176a:	83 ec 04             	sub    $0x4,%esp
  80176d:	8b 45 10             	mov    0x10(%ebp),%eax
  801770:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801773:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801777:	8b 45 08             	mov    0x8(%ebp),%eax
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	52                   	push   %edx
  80177f:	ff 75 0c             	pushl  0xc(%ebp)
  801782:	50                   	push   %eax
  801783:	6a 00                	push   $0x0
  801785:	e8 b2 ff ff ff       	call   80173c <syscall>
  80178a:	83 c4 18             	add    $0x18,%esp
}
  80178d:	90                   	nop
  80178e:	c9                   	leave  
  80178f:	c3                   	ret    

00801790 <sys_cgetc>:

int
sys_cgetc(void)
{
  801790:	55                   	push   %ebp
  801791:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	6a 00                	push   $0x0
  80179d:	6a 01                	push   $0x1
  80179f:	e8 98 ff ff ff       	call   80173c <syscall>
  8017a4:	83 c4 18             	add    $0x18,%esp
}
  8017a7:	c9                   	leave  
  8017a8:	c3                   	ret    

008017a9 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017a9:	55                   	push   %ebp
  8017aa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	6a 00                	push   $0x0
  8017b5:	6a 00                	push   $0x0
  8017b7:	50                   	push   %eax
  8017b8:	6a 05                	push   $0x5
  8017ba:	e8 7d ff ff ff       	call   80173c <syscall>
  8017bf:	83 c4 18             	add    $0x18,%esp
}
  8017c2:	c9                   	leave  
  8017c3:	c3                   	ret    

008017c4 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017c4:	55                   	push   %ebp
  8017c5:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	6a 02                	push   $0x2
  8017d3:	e8 64 ff ff ff       	call   80173c <syscall>
  8017d8:	83 c4 18             	add    $0x18,%esp
}
  8017db:	c9                   	leave  
  8017dc:	c3                   	ret    

008017dd <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017dd:	55                   	push   %ebp
  8017de:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 00                	push   $0x0
  8017e8:	6a 00                	push   $0x0
  8017ea:	6a 03                	push   $0x3
  8017ec:	e8 4b ff ff ff       	call   80173c <syscall>
  8017f1:	83 c4 18             	add    $0x18,%esp
}
  8017f4:	c9                   	leave  
  8017f5:	c3                   	ret    

008017f6 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017f6:	55                   	push   %ebp
  8017f7:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 00                	push   $0x0
  801801:	6a 00                	push   $0x0
  801803:	6a 04                	push   $0x4
  801805:	e8 32 ff ff ff       	call   80173c <syscall>
  80180a:	83 c4 18             	add    $0x18,%esp
}
  80180d:	c9                   	leave  
  80180e:	c3                   	ret    

0080180f <sys_env_exit>:


void sys_env_exit(void)
{
  80180f:	55                   	push   %ebp
  801810:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 00                	push   $0x0
  80181a:	6a 00                	push   $0x0
  80181c:	6a 06                	push   $0x6
  80181e:	e8 19 ff ff ff       	call   80173c <syscall>
  801823:	83 c4 18             	add    $0x18,%esp
}
  801826:	90                   	nop
  801827:	c9                   	leave  
  801828:	c3                   	ret    

00801829 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801829:	55                   	push   %ebp
  80182a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  80182c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182f:	8b 45 08             	mov    0x8(%ebp),%eax
  801832:	6a 00                	push   $0x0
  801834:	6a 00                	push   $0x0
  801836:	6a 00                	push   $0x0
  801838:	52                   	push   %edx
  801839:	50                   	push   %eax
  80183a:	6a 07                	push   $0x7
  80183c:	e8 fb fe ff ff       	call   80173c <syscall>
  801841:	83 c4 18             	add    $0x18,%esp
}
  801844:	c9                   	leave  
  801845:	c3                   	ret    

00801846 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801846:	55                   	push   %ebp
  801847:	89 e5                	mov    %esp,%ebp
  801849:	56                   	push   %esi
  80184a:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  80184b:	8b 75 18             	mov    0x18(%ebp),%esi
  80184e:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801851:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801854:	8b 55 0c             	mov    0xc(%ebp),%edx
  801857:	8b 45 08             	mov    0x8(%ebp),%eax
  80185a:	56                   	push   %esi
  80185b:	53                   	push   %ebx
  80185c:	51                   	push   %ecx
  80185d:	52                   	push   %edx
  80185e:	50                   	push   %eax
  80185f:	6a 08                	push   $0x8
  801861:	e8 d6 fe ff ff       	call   80173c <syscall>
  801866:	83 c4 18             	add    $0x18,%esp
}
  801869:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80186c:	5b                   	pop    %ebx
  80186d:	5e                   	pop    %esi
  80186e:	5d                   	pop    %ebp
  80186f:	c3                   	ret    

00801870 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801870:	55                   	push   %ebp
  801871:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801873:	8b 55 0c             	mov    0xc(%ebp),%edx
  801876:	8b 45 08             	mov    0x8(%ebp),%eax
  801879:	6a 00                	push   $0x0
  80187b:	6a 00                	push   $0x0
  80187d:	6a 00                	push   $0x0
  80187f:	52                   	push   %edx
  801880:	50                   	push   %eax
  801881:	6a 09                	push   $0x9
  801883:	e8 b4 fe ff ff       	call   80173c <syscall>
  801888:	83 c4 18             	add    $0x18,%esp
}
  80188b:	c9                   	leave  
  80188c:	c3                   	ret    

0080188d <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 00                	push   $0x0
  801896:	ff 75 0c             	pushl  0xc(%ebp)
  801899:	ff 75 08             	pushl  0x8(%ebp)
  80189c:	6a 0a                	push   $0xa
  80189e:	e8 99 fe ff ff       	call   80173c <syscall>
  8018a3:	83 c4 18             	add    $0x18,%esp
}
  8018a6:	c9                   	leave  
  8018a7:	c3                   	ret    

008018a8 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018a8:	55                   	push   %ebp
  8018a9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 00                	push   $0x0
  8018b3:	6a 00                	push   $0x0
  8018b5:	6a 0b                	push   $0xb
  8018b7:	e8 80 fe ff ff       	call   80173c <syscall>
  8018bc:	83 c4 18             	add    $0x18,%esp
}
  8018bf:	c9                   	leave  
  8018c0:	c3                   	ret    

008018c1 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018c1:	55                   	push   %ebp
  8018c2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	6a 00                	push   $0x0
  8018ce:	6a 0c                	push   $0xc
  8018d0:	e8 67 fe ff ff       	call   80173c <syscall>
  8018d5:	83 c4 18             	add    $0x18,%esp
}
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 00                	push   $0x0
  8018e5:	6a 00                	push   $0x0
  8018e7:	6a 0d                	push   $0xd
  8018e9:	e8 4e fe ff ff       	call   80173c <syscall>
  8018ee:	83 c4 18             	add    $0x18,%esp
}
  8018f1:	c9                   	leave  
  8018f2:	c3                   	ret    

008018f3 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018f3:	55                   	push   %ebp
  8018f4:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018f6:	6a 00                	push   $0x0
  8018f8:	6a 00                	push   $0x0
  8018fa:	6a 00                	push   $0x0
  8018fc:	ff 75 0c             	pushl  0xc(%ebp)
  8018ff:	ff 75 08             	pushl  0x8(%ebp)
  801902:	6a 11                	push   $0x11
  801904:	e8 33 fe ff ff       	call   80173c <syscall>
  801909:	83 c4 18             	add    $0x18,%esp
	return;
  80190c:	90                   	nop
}
  80190d:	c9                   	leave  
  80190e:	c3                   	ret    

0080190f <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80190f:	55                   	push   %ebp
  801910:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801912:	6a 00                	push   $0x0
  801914:	6a 00                	push   $0x0
  801916:	6a 00                	push   $0x0
  801918:	ff 75 0c             	pushl  0xc(%ebp)
  80191b:	ff 75 08             	pushl  0x8(%ebp)
  80191e:	6a 12                	push   $0x12
  801920:	e8 17 fe ff ff       	call   80173c <syscall>
  801925:	83 c4 18             	add    $0x18,%esp
	return ;
  801928:	90                   	nop
}
  801929:	c9                   	leave  
  80192a:	c3                   	ret    

0080192b <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  80192b:	55                   	push   %ebp
  80192c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 00                	push   $0x0
  801936:	6a 00                	push   $0x0
  801938:	6a 0e                	push   $0xe
  80193a:	e8 fd fd ff ff       	call   80173c <syscall>
  80193f:	83 c4 18             	add    $0x18,%esp
}
  801942:	c9                   	leave  
  801943:	c3                   	ret    

00801944 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801944:	55                   	push   %ebp
  801945:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	6a 00                	push   $0x0
  80194d:	6a 00                	push   $0x0
  80194f:	ff 75 08             	pushl  0x8(%ebp)
  801952:	6a 0f                	push   $0xf
  801954:	e8 e3 fd ff ff       	call   80173c <syscall>
  801959:	83 c4 18             	add    $0x18,%esp
}
  80195c:	c9                   	leave  
  80195d:	c3                   	ret    

0080195e <sys_scarce_memory>:

void sys_scarce_memory()
{
  80195e:	55                   	push   %ebp
  80195f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 00                	push   $0x0
  801969:	6a 00                	push   $0x0
  80196b:	6a 10                	push   $0x10
  80196d:	e8 ca fd ff ff       	call   80173c <syscall>
  801972:	83 c4 18             	add    $0x18,%esp
}
  801975:	90                   	nop
  801976:	c9                   	leave  
  801977:	c3                   	ret    

00801978 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801978:	55                   	push   %ebp
  801979:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 14                	push   $0x14
  801987:	e8 b0 fd ff ff       	call   80173c <syscall>
  80198c:	83 c4 18             	add    $0x18,%esp
}
  80198f:	90                   	nop
  801990:	c9                   	leave  
  801991:	c3                   	ret    

00801992 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801992:	55                   	push   %ebp
  801993:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 15                	push   $0x15
  8019a1:	e8 96 fd ff ff       	call   80173c <syscall>
  8019a6:	83 c4 18             	add    $0x18,%esp
}
  8019a9:	90                   	nop
  8019aa:	c9                   	leave  
  8019ab:	c3                   	ret    

008019ac <sys_cputc>:


void
sys_cputc(const char c)
{
  8019ac:	55                   	push   %ebp
  8019ad:	89 e5                	mov    %esp,%ebp
  8019af:	83 ec 04             	sub    $0x4,%esp
  8019b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b5:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019b8:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	6a 00                	push   $0x0
  8019c2:	6a 00                	push   $0x0
  8019c4:	50                   	push   %eax
  8019c5:	6a 16                	push   $0x16
  8019c7:	e8 70 fd ff ff       	call   80173c <syscall>
  8019cc:	83 c4 18             	add    $0x18,%esp
}
  8019cf:	90                   	nop
  8019d0:	c9                   	leave  
  8019d1:	c3                   	ret    

008019d2 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019d2:	55                   	push   %ebp
  8019d3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 00                	push   $0x0
  8019dd:	6a 00                	push   $0x0
  8019df:	6a 17                	push   $0x17
  8019e1:	e8 56 fd ff ff       	call   80173c <syscall>
  8019e6:	83 c4 18             	add    $0x18,%esp
}
  8019e9:	90                   	nop
  8019ea:	c9                   	leave  
  8019eb:	c3                   	ret    

008019ec <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019ec:	55                   	push   %ebp
  8019ed:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019ef:	8b 45 08             	mov    0x8(%ebp),%eax
  8019f2:	6a 00                	push   $0x0
  8019f4:	6a 00                	push   $0x0
  8019f6:	6a 00                	push   $0x0
  8019f8:	ff 75 0c             	pushl  0xc(%ebp)
  8019fb:	50                   	push   %eax
  8019fc:	6a 18                	push   $0x18
  8019fe:	e8 39 fd ff ff       	call   80173c <syscall>
  801a03:	83 c4 18             	add    $0x18,%esp
}
  801a06:	c9                   	leave  
  801a07:	c3                   	ret    

00801a08 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a08:	55                   	push   %ebp
  801a09:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a0b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0e:	8b 45 08             	mov    0x8(%ebp),%eax
  801a11:	6a 00                	push   $0x0
  801a13:	6a 00                	push   $0x0
  801a15:	6a 00                	push   $0x0
  801a17:	52                   	push   %edx
  801a18:	50                   	push   %eax
  801a19:	6a 1b                	push   $0x1b
  801a1b:	e8 1c fd ff ff       	call   80173c <syscall>
  801a20:	83 c4 18             	add    $0x18,%esp
}
  801a23:	c9                   	leave  
  801a24:	c3                   	ret    

00801a25 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a25:	55                   	push   %ebp
  801a26:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a28:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a2b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2e:	6a 00                	push   $0x0
  801a30:	6a 00                	push   $0x0
  801a32:	6a 00                	push   $0x0
  801a34:	52                   	push   %edx
  801a35:	50                   	push   %eax
  801a36:	6a 19                	push   $0x19
  801a38:	e8 ff fc ff ff       	call   80173c <syscall>
  801a3d:	83 c4 18             	add    $0x18,%esp
}
  801a40:	90                   	nop
  801a41:	c9                   	leave  
  801a42:	c3                   	ret    

00801a43 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a43:	55                   	push   %ebp
  801a44:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a46:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a49:	8b 45 08             	mov    0x8(%ebp),%eax
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	52                   	push   %edx
  801a53:	50                   	push   %eax
  801a54:	6a 1a                	push   $0x1a
  801a56:	e8 e1 fc ff ff       	call   80173c <syscall>
  801a5b:	83 c4 18             	add    $0x18,%esp
}
  801a5e:	90                   	nop
  801a5f:	c9                   	leave  
  801a60:	c3                   	ret    

00801a61 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a61:	55                   	push   %ebp
  801a62:	89 e5                	mov    %esp,%ebp
  801a64:	83 ec 04             	sub    $0x4,%esp
  801a67:	8b 45 10             	mov    0x10(%ebp),%eax
  801a6a:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a6d:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a70:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a74:	8b 45 08             	mov    0x8(%ebp),%eax
  801a77:	6a 00                	push   $0x0
  801a79:	51                   	push   %ecx
  801a7a:	52                   	push   %edx
  801a7b:	ff 75 0c             	pushl  0xc(%ebp)
  801a7e:	50                   	push   %eax
  801a7f:	6a 1c                	push   $0x1c
  801a81:	e8 b6 fc ff ff       	call   80173c <syscall>
  801a86:	83 c4 18             	add    $0x18,%esp
}
  801a89:	c9                   	leave  
  801a8a:	c3                   	ret    

00801a8b <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a8b:	55                   	push   %ebp
  801a8c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a8e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a91:	8b 45 08             	mov    0x8(%ebp),%eax
  801a94:	6a 00                	push   $0x0
  801a96:	6a 00                	push   $0x0
  801a98:	6a 00                	push   $0x0
  801a9a:	52                   	push   %edx
  801a9b:	50                   	push   %eax
  801a9c:	6a 1d                	push   $0x1d
  801a9e:	e8 99 fc ff ff       	call   80173c <syscall>
  801aa3:	83 c4 18             	add    $0x18,%esp
}
  801aa6:	c9                   	leave  
  801aa7:	c3                   	ret    

00801aa8 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801aa8:	55                   	push   %ebp
  801aa9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801aab:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aae:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab1:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	51                   	push   %ecx
  801ab9:	52                   	push   %edx
  801aba:	50                   	push   %eax
  801abb:	6a 1e                	push   $0x1e
  801abd:	e8 7a fc ff ff       	call   80173c <syscall>
  801ac2:	83 c4 18             	add    $0x18,%esp
}
  801ac5:	c9                   	leave  
  801ac6:	c3                   	ret    

00801ac7 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ac7:	55                   	push   %ebp
  801ac8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801aca:	8b 55 0c             	mov    0xc(%ebp),%edx
  801acd:	8b 45 08             	mov    0x8(%ebp),%eax
  801ad0:	6a 00                	push   $0x0
  801ad2:	6a 00                	push   $0x0
  801ad4:	6a 00                	push   $0x0
  801ad6:	52                   	push   %edx
  801ad7:	50                   	push   %eax
  801ad8:	6a 1f                	push   $0x1f
  801ada:	e8 5d fc ff ff       	call   80173c <syscall>
  801adf:	83 c4 18             	add    $0x18,%esp
}
  801ae2:	c9                   	leave  
  801ae3:	c3                   	ret    

00801ae4 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ae4:	55                   	push   %ebp
  801ae5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 00                	push   $0x0
  801aef:	6a 00                	push   $0x0
  801af1:	6a 20                	push   $0x20
  801af3:	e8 44 fc ff ff       	call   80173c <syscall>
  801af8:	83 c4 18             	add    $0x18,%esp
}
  801afb:	c9                   	leave  
  801afc:	c3                   	ret    

00801afd <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801afd:	55                   	push   %ebp
  801afe:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801b00:	8b 45 08             	mov    0x8(%ebp),%eax
  801b03:	6a 00                	push   $0x0
  801b05:	ff 75 14             	pushl  0x14(%ebp)
  801b08:	ff 75 10             	pushl  0x10(%ebp)
  801b0b:	ff 75 0c             	pushl  0xc(%ebp)
  801b0e:	50                   	push   %eax
  801b0f:	6a 21                	push   $0x21
  801b11:	e8 26 fc ff ff       	call   80173c <syscall>
  801b16:	83 c4 18             	add    $0x18,%esp
}
  801b19:	c9                   	leave  
  801b1a:	c3                   	ret    

00801b1b <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801b1b:	55                   	push   %ebp
  801b1c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b1e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	6a 00                	push   $0x0
  801b27:	6a 00                	push   $0x0
  801b29:	50                   	push   %eax
  801b2a:	6a 22                	push   $0x22
  801b2c:	e8 0b fc ff ff       	call   80173c <syscall>
  801b31:	83 c4 18             	add    $0x18,%esp
}
  801b34:	90                   	nop
  801b35:	c9                   	leave  
  801b36:	c3                   	ret    

00801b37 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b37:	55                   	push   %ebp
  801b38:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	50                   	push   %eax
  801b46:	6a 23                	push   $0x23
  801b48:	e8 ef fb ff ff       	call   80173c <syscall>
  801b4d:	83 c4 18             	add    $0x18,%esp
}
  801b50:	90                   	nop
  801b51:	c9                   	leave  
  801b52:	c3                   	ret    

00801b53 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b53:	55                   	push   %ebp
  801b54:	89 e5                	mov    %esp,%ebp
  801b56:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b59:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b5c:	8d 50 04             	lea    0x4(%eax),%edx
  801b5f:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b62:	6a 00                	push   $0x0
  801b64:	6a 00                	push   $0x0
  801b66:	6a 00                	push   $0x0
  801b68:	52                   	push   %edx
  801b69:	50                   	push   %eax
  801b6a:	6a 24                	push   $0x24
  801b6c:	e8 cb fb ff ff       	call   80173c <syscall>
  801b71:	83 c4 18             	add    $0x18,%esp
	return result;
  801b74:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b77:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b7d:	89 01                	mov    %eax,(%ecx)
  801b7f:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b82:	8b 45 08             	mov    0x8(%ebp),%eax
  801b85:	c9                   	leave  
  801b86:	c2 04 00             	ret    $0x4

00801b89 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b89:	55                   	push   %ebp
  801b8a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b8c:	6a 00                	push   $0x0
  801b8e:	6a 00                	push   $0x0
  801b90:	ff 75 10             	pushl  0x10(%ebp)
  801b93:	ff 75 0c             	pushl  0xc(%ebp)
  801b96:	ff 75 08             	pushl  0x8(%ebp)
  801b99:	6a 13                	push   $0x13
  801b9b:	e8 9c fb ff ff       	call   80173c <syscall>
  801ba0:	83 c4 18             	add    $0x18,%esp
	return ;
  801ba3:	90                   	nop
}
  801ba4:	c9                   	leave  
  801ba5:	c3                   	ret    

00801ba6 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ba6:	55                   	push   %ebp
  801ba7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 00                	push   $0x0
  801bb1:	6a 00                	push   $0x0
  801bb3:	6a 25                	push   $0x25
  801bb5:	e8 82 fb ff ff       	call   80173c <syscall>
  801bba:	83 c4 18             	add    $0x18,%esp
}
  801bbd:	c9                   	leave  
  801bbe:	c3                   	ret    

00801bbf <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bbf:	55                   	push   %ebp
  801bc0:	89 e5                	mov    %esp,%ebp
  801bc2:	83 ec 04             	sub    $0x4,%esp
  801bc5:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc8:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bcb:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	6a 00                	push   $0x0
  801bd5:	6a 00                	push   $0x0
  801bd7:	50                   	push   %eax
  801bd8:	6a 26                	push   $0x26
  801bda:	e8 5d fb ff ff       	call   80173c <syscall>
  801bdf:	83 c4 18             	add    $0x18,%esp
	return ;
  801be2:	90                   	nop
}
  801be3:	c9                   	leave  
  801be4:	c3                   	ret    

00801be5 <rsttst>:
void rsttst()
{
  801be5:	55                   	push   %ebp
  801be6:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 00                	push   $0x0
  801bf0:	6a 00                	push   $0x0
  801bf2:	6a 28                	push   $0x28
  801bf4:	e8 43 fb ff ff       	call   80173c <syscall>
  801bf9:	83 c4 18             	add    $0x18,%esp
	return ;
  801bfc:	90                   	nop
}
  801bfd:	c9                   	leave  
  801bfe:	c3                   	ret    

00801bff <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bff:	55                   	push   %ebp
  801c00:	89 e5                	mov    %esp,%ebp
  801c02:	83 ec 04             	sub    $0x4,%esp
  801c05:	8b 45 14             	mov    0x14(%ebp),%eax
  801c08:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c0b:	8b 55 18             	mov    0x18(%ebp),%edx
  801c0e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c12:	52                   	push   %edx
  801c13:	50                   	push   %eax
  801c14:	ff 75 10             	pushl  0x10(%ebp)
  801c17:	ff 75 0c             	pushl  0xc(%ebp)
  801c1a:	ff 75 08             	pushl  0x8(%ebp)
  801c1d:	6a 27                	push   $0x27
  801c1f:	e8 18 fb ff ff       	call   80173c <syscall>
  801c24:	83 c4 18             	add    $0x18,%esp
	return ;
  801c27:	90                   	nop
}
  801c28:	c9                   	leave  
  801c29:	c3                   	ret    

00801c2a <chktst>:
void chktst(uint32 n)
{
  801c2a:	55                   	push   %ebp
  801c2b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	6a 00                	push   $0x0
  801c33:	6a 00                	push   $0x0
  801c35:	ff 75 08             	pushl  0x8(%ebp)
  801c38:	6a 29                	push   $0x29
  801c3a:	e8 fd fa ff ff       	call   80173c <syscall>
  801c3f:	83 c4 18             	add    $0x18,%esp
	return ;
  801c42:	90                   	nop
}
  801c43:	c9                   	leave  
  801c44:	c3                   	ret    

00801c45 <inctst>:

void inctst()
{
  801c45:	55                   	push   %ebp
  801c46:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 00                	push   $0x0
  801c50:	6a 00                	push   $0x0
  801c52:	6a 2a                	push   $0x2a
  801c54:	e8 e3 fa ff ff       	call   80173c <syscall>
  801c59:	83 c4 18             	add    $0x18,%esp
	return ;
  801c5c:	90                   	nop
}
  801c5d:	c9                   	leave  
  801c5e:	c3                   	ret    

00801c5f <gettst>:
uint32 gettst()
{
  801c5f:	55                   	push   %ebp
  801c60:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 00                	push   $0x0
  801c6a:	6a 00                	push   $0x0
  801c6c:	6a 2b                	push   $0x2b
  801c6e:	e8 c9 fa ff ff       	call   80173c <syscall>
  801c73:	83 c4 18             	add    $0x18,%esp
}
  801c76:	c9                   	leave  
  801c77:	c3                   	ret    

00801c78 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c78:	55                   	push   %ebp
  801c79:	89 e5                	mov    %esp,%ebp
  801c7b:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	6a 00                	push   $0x0
  801c86:	6a 00                	push   $0x0
  801c88:	6a 2c                	push   $0x2c
  801c8a:	e8 ad fa ff ff       	call   80173c <syscall>
  801c8f:	83 c4 18             	add    $0x18,%esp
  801c92:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c95:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c99:	75 07                	jne    801ca2 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c9b:	b8 01 00 00 00       	mov    $0x1,%eax
  801ca0:	eb 05                	jmp    801ca7 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801ca2:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca7:	c9                   	leave  
  801ca8:	c3                   	ret    

00801ca9 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ca9:	55                   	push   %ebp
  801caa:	89 e5                	mov    %esp,%ebp
  801cac:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 00                	push   $0x0
  801cb7:	6a 00                	push   $0x0
  801cb9:	6a 2c                	push   $0x2c
  801cbb:	e8 7c fa ff ff       	call   80173c <syscall>
  801cc0:	83 c4 18             	add    $0x18,%esp
  801cc3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cc6:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cca:	75 07                	jne    801cd3 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801ccc:	b8 01 00 00 00       	mov    $0x1,%eax
  801cd1:	eb 05                	jmp    801cd8 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801cd3:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd8:	c9                   	leave  
  801cd9:	c3                   	ret    

00801cda <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cda:	55                   	push   %ebp
  801cdb:	89 e5                	mov    %esp,%ebp
  801cdd:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 00                	push   $0x0
  801ce8:	6a 00                	push   $0x0
  801cea:	6a 2c                	push   $0x2c
  801cec:	e8 4b fa ff ff       	call   80173c <syscall>
  801cf1:	83 c4 18             	add    $0x18,%esp
  801cf4:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cf7:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cfb:	75 07                	jne    801d04 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cfd:	b8 01 00 00 00       	mov    $0x1,%eax
  801d02:	eb 05                	jmp    801d09 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d04:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d09:	c9                   	leave  
  801d0a:	c3                   	ret    

00801d0b <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d0b:	55                   	push   %ebp
  801d0c:	89 e5                	mov    %esp,%ebp
  801d0e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 00                	push   $0x0
  801d19:	6a 00                	push   $0x0
  801d1b:	6a 2c                	push   $0x2c
  801d1d:	e8 1a fa ff ff       	call   80173c <syscall>
  801d22:	83 c4 18             	add    $0x18,%esp
  801d25:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d28:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d2c:	75 07                	jne    801d35 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d2e:	b8 01 00 00 00       	mov    $0x1,%eax
  801d33:	eb 05                	jmp    801d3a <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d35:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d3a:	c9                   	leave  
  801d3b:	c3                   	ret    

00801d3c <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d3c:	55                   	push   %ebp
  801d3d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	6a 00                	push   $0x0
  801d45:	6a 00                	push   $0x0
  801d47:	ff 75 08             	pushl  0x8(%ebp)
  801d4a:	6a 2d                	push   $0x2d
  801d4c:	e8 eb f9 ff ff       	call   80173c <syscall>
  801d51:	83 c4 18             	add    $0x18,%esp
	return ;
  801d54:	90                   	nop
}
  801d55:	c9                   	leave  
  801d56:	c3                   	ret    

00801d57 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d57:	55                   	push   %ebp
  801d58:	89 e5                	mov    %esp,%ebp
  801d5a:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d5b:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d5e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d61:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d64:	8b 45 08             	mov    0x8(%ebp),%eax
  801d67:	6a 00                	push   $0x0
  801d69:	53                   	push   %ebx
  801d6a:	51                   	push   %ecx
  801d6b:	52                   	push   %edx
  801d6c:	50                   	push   %eax
  801d6d:	6a 2e                	push   $0x2e
  801d6f:	e8 c8 f9 ff ff       	call   80173c <syscall>
  801d74:	83 c4 18             	add    $0x18,%esp
}
  801d77:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d7a:	c9                   	leave  
  801d7b:	c3                   	ret    

00801d7c <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d7c:	55                   	push   %ebp
  801d7d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d7f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d82:	8b 45 08             	mov    0x8(%ebp),%eax
  801d85:	6a 00                	push   $0x0
  801d87:	6a 00                	push   $0x0
  801d89:	6a 00                	push   $0x0
  801d8b:	52                   	push   %edx
  801d8c:	50                   	push   %eax
  801d8d:	6a 2f                	push   $0x2f
  801d8f:	e8 a8 f9 ff ff       	call   80173c <syscall>
  801d94:	83 c4 18             	add    $0x18,%esp
}
  801d97:	c9                   	leave  
  801d98:	c3                   	ret    

00801d99 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801d99:	55                   	push   %ebp
  801d9a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801d9c:	6a 00                	push   $0x0
  801d9e:	6a 00                	push   $0x0
  801da0:	6a 00                	push   $0x0
  801da2:	ff 75 0c             	pushl  0xc(%ebp)
  801da5:	ff 75 08             	pushl  0x8(%ebp)
  801da8:	6a 30                	push   $0x30
  801daa:	e8 8d f9 ff ff       	call   80173c <syscall>
  801daf:	83 c4 18             	add    $0x18,%esp
	return ;
  801db2:	90                   	nop
}
  801db3:	c9                   	leave  
  801db4:	c3                   	ret    
  801db5:	66 90                	xchg   %ax,%ax
  801db7:	90                   	nop

00801db8 <__udivdi3>:
  801db8:	55                   	push   %ebp
  801db9:	57                   	push   %edi
  801dba:	56                   	push   %esi
  801dbb:	53                   	push   %ebx
  801dbc:	83 ec 1c             	sub    $0x1c,%esp
  801dbf:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dc3:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dc7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dcb:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dcf:	89 ca                	mov    %ecx,%edx
  801dd1:	89 f8                	mov    %edi,%eax
  801dd3:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dd7:	85 f6                	test   %esi,%esi
  801dd9:	75 2d                	jne    801e08 <__udivdi3+0x50>
  801ddb:	39 cf                	cmp    %ecx,%edi
  801ddd:	77 65                	ja     801e44 <__udivdi3+0x8c>
  801ddf:	89 fd                	mov    %edi,%ebp
  801de1:	85 ff                	test   %edi,%edi
  801de3:	75 0b                	jne    801df0 <__udivdi3+0x38>
  801de5:	b8 01 00 00 00       	mov    $0x1,%eax
  801dea:	31 d2                	xor    %edx,%edx
  801dec:	f7 f7                	div    %edi
  801dee:	89 c5                	mov    %eax,%ebp
  801df0:	31 d2                	xor    %edx,%edx
  801df2:	89 c8                	mov    %ecx,%eax
  801df4:	f7 f5                	div    %ebp
  801df6:	89 c1                	mov    %eax,%ecx
  801df8:	89 d8                	mov    %ebx,%eax
  801dfa:	f7 f5                	div    %ebp
  801dfc:	89 cf                	mov    %ecx,%edi
  801dfe:	89 fa                	mov    %edi,%edx
  801e00:	83 c4 1c             	add    $0x1c,%esp
  801e03:	5b                   	pop    %ebx
  801e04:	5e                   	pop    %esi
  801e05:	5f                   	pop    %edi
  801e06:	5d                   	pop    %ebp
  801e07:	c3                   	ret    
  801e08:	39 ce                	cmp    %ecx,%esi
  801e0a:	77 28                	ja     801e34 <__udivdi3+0x7c>
  801e0c:	0f bd fe             	bsr    %esi,%edi
  801e0f:	83 f7 1f             	xor    $0x1f,%edi
  801e12:	75 40                	jne    801e54 <__udivdi3+0x9c>
  801e14:	39 ce                	cmp    %ecx,%esi
  801e16:	72 0a                	jb     801e22 <__udivdi3+0x6a>
  801e18:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e1c:	0f 87 9e 00 00 00    	ja     801ec0 <__udivdi3+0x108>
  801e22:	b8 01 00 00 00       	mov    $0x1,%eax
  801e27:	89 fa                	mov    %edi,%edx
  801e29:	83 c4 1c             	add    $0x1c,%esp
  801e2c:	5b                   	pop    %ebx
  801e2d:	5e                   	pop    %esi
  801e2e:	5f                   	pop    %edi
  801e2f:	5d                   	pop    %ebp
  801e30:	c3                   	ret    
  801e31:	8d 76 00             	lea    0x0(%esi),%esi
  801e34:	31 ff                	xor    %edi,%edi
  801e36:	31 c0                	xor    %eax,%eax
  801e38:	89 fa                	mov    %edi,%edx
  801e3a:	83 c4 1c             	add    $0x1c,%esp
  801e3d:	5b                   	pop    %ebx
  801e3e:	5e                   	pop    %esi
  801e3f:	5f                   	pop    %edi
  801e40:	5d                   	pop    %ebp
  801e41:	c3                   	ret    
  801e42:	66 90                	xchg   %ax,%ax
  801e44:	89 d8                	mov    %ebx,%eax
  801e46:	f7 f7                	div    %edi
  801e48:	31 ff                	xor    %edi,%edi
  801e4a:	89 fa                	mov    %edi,%edx
  801e4c:	83 c4 1c             	add    $0x1c,%esp
  801e4f:	5b                   	pop    %ebx
  801e50:	5e                   	pop    %esi
  801e51:	5f                   	pop    %edi
  801e52:	5d                   	pop    %ebp
  801e53:	c3                   	ret    
  801e54:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e59:	89 eb                	mov    %ebp,%ebx
  801e5b:	29 fb                	sub    %edi,%ebx
  801e5d:	89 f9                	mov    %edi,%ecx
  801e5f:	d3 e6                	shl    %cl,%esi
  801e61:	89 c5                	mov    %eax,%ebp
  801e63:	88 d9                	mov    %bl,%cl
  801e65:	d3 ed                	shr    %cl,%ebp
  801e67:	89 e9                	mov    %ebp,%ecx
  801e69:	09 f1                	or     %esi,%ecx
  801e6b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e6f:	89 f9                	mov    %edi,%ecx
  801e71:	d3 e0                	shl    %cl,%eax
  801e73:	89 c5                	mov    %eax,%ebp
  801e75:	89 d6                	mov    %edx,%esi
  801e77:	88 d9                	mov    %bl,%cl
  801e79:	d3 ee                	shr    %cl,%esi
  801e7b:	89 f9                	mov    %edi,%ecx
  801e7d:	d3 e2                	shl    %cl,%edx
  801e7f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e83:	88 d9                	mov    %bl,%cl
  801e85:	d3 e8                	shr    %cl,%eax
  801e87:	09 c2                	or     %eax,%edx
  801e89:	89 d0                	mov    %edx,%eax
  801e8b:	89 f2                	mov    %esi,%edx
  801e8d:	f7 74 24 0c          	divl   0xc(%esp)
  801e91:	89 d6                	mov    %edx,%esi
  801e93:	89 c3                	mov    %eax,%ebx
  801e95:	f7 e5                	mul    %ebp
  801e97:	39 d6                	cmp    %edx,%esi
  801e99:	72 19                	jb     801eb4 <__udivdi3+0xfc>
  801e9b:	74 0b                	je     801ea8 <__udivdi3+0xf0>
  801e9d:	89 d8                	mov    %ebx,%eax
  801e9f:	31 ff                	xor    %edi,%edi
  801ea1:	e9 58 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ea6:	66 90                	xchg   %ax,%ax
  801ea8:	8b 54 24 08          	mov    0x8(%esp),%edx
  801eac:	89 f9                	mov    %edi,%ecx
  801eae:	d3 e2                	shl    %cl,%edx
  801eb0:	39 c2                	cmp    %eax,%edx
  801eb2:	73 e9                	jae    801e9d <__udivdi3+0xe5>
  801eb4:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801eb7:	31 ff                	xor    %edi,%edi
  801eb9:	e9 40 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ebe:	66 90                	xchg   %ax,%ax
  801ec0:	31 c0                	xor    %eax,%eax
  801ec2:	e9 37 ff ff ff       	jmp    801dfe <__udivdi3+0x46>
  801ec7:	90                   	nop

00801ec8 <__umoddi3>:
  801ec8:	55                   	push   %ebp
  801ec9:	57                   	push   %edi
  801eca:	56                   	push   %esi
  801ecb:	53                   	push   %ebx
  801ecc:	83 ec 1c             	sub    $0x1c,%esp
  801ecf:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ed3:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ed7:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801edb:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801edf:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801ee3:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ee7:	89 f3                	mov    %esi,%ebx
  801ee9:	89 fa                	mov    %edi,%edx
  801eeb:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eef:	89 34 24             	mov    %esi,(%esp)
  801ef2:	85 c0                	test   %eax,%eax
  801ef4:	75 1a                	jne    801f10 <__umoddi3+0x48>
  801ef6:	39 f7                	cmp    %esi,%edi
  801ef8:	0f 86 a2 00 00 00    	jbe    801fa0 <__umoddi3+0xd8>
  801efe:	89 c8                	mov    %ecx,%eax
  801f00:	89 f2                	mov    %esi,%edx
  801f02:	f7 f7                	div    %edi
  801f04:	89 d0                	mov    %edx,%eax
  801f06:	31 d2                	xor    %edx,%edx
  801f08:	83 c4 1c             	add    $0x1c,%esp
  801f0b:	5b                   	pop    %ebx
  801f0c:	5e                   	pop    %esi
  801f0d:	5f                   	pop    %edi
  801f0e:	5d                   	pop    %ebp
  801f0f:	c3                   	ret    
  801f10:	39 f0                	cmp    %esi,%eax
  801f12:	0f 87 ac 00 00 00    	ja     801fc4 <__umoddi3+0xfc>
  801f18:	0f bd e8             	bsr    %eax,%ebp
  801f1b:	83 f5 1f             	xor    $0x1f,%ebp
  801f1e:	0f 84 ac 00 00 00    	je     801fd0 <__umoddi3+0x108>
  801f24:	bf 20 00 00 00       	mov    $0x20,%edi
  801f29:	29 ef                	sub    %ebp,%edi
  801f2b:	89 fe                	mov    %edi,%esi
  801f2d:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f31:	89 e9                	mov    %ebp,%ecx
  801f33:	d3 e0                	shl    %cl,%eax
  801f35:	89 d7                	mov    %edx,%edi
  801f37:	89 f1                	mov    %esi,%ecx
  801f39:	d3 ef                	shr    %cl,%edi
  801f3b:	09 c7                	or     %eax,%edi
  801f3d:	89 e9                	mov    %ebp,%ecx
  801f3f:	d3 e2                	shl    %cl,%edx
  801f41:	89 14 24             	mov    %edx,(%esp)
  801f44:	89 d8                	mov    %ebx,%eax
  801f46:	d3 e0                	shl    %cl,%eax
  801f48:	89 c2                	mov    %eax,%edx
  801f4a:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f4e:	d3 e0                	shl    %cl,%eax
  801f50:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f54:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f58:	89 f1                	mov    %esi,%ecx
  801f5a:	d3 e8                	shr    %cl,%eax
  801f5c:	09 d0                	or     %edx,%eax
  801f5e:	d3 eb                	shr    %cl,%ebx
  801f60:	89 da                	mov    %ebx,%edx
  801f62:	f7 f7                	div    %edi
  801f64:	89 d3                	mov    %edx,%ebx
  801f66:	f7 24 24             	mull   (%esp)
  801f69:	89 c6                	mov    %eax,%esi
  801f6b:	89 d1                	mov    %edx,%ecx
  801f6d:	39 d3                	cmp    %edx,%ebx
  801f6f:	0f 82 87 00 00 00    	jb     801ffc <__umoddi3+0x134>
  801f75:	0f 84 91 00 00 00    	je     80200c <__umoddi3+0x144>
  801f7b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f7f:	29 f2                	sub    %esi,%edx
  801f81:	19 cb                	sbb    %ecx,%ebx
  801f83:	89 d8                	mov    %ebx,%eax
  801f85:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f89:	d3 e0                	shl    %cl,%eax
  801f8b:	89 e9                	mov    %ebp,%ecx
  801f8d:	d3 ea                	shr    %cl,%edx
  801f8f:	09 d0                	or     %edx,%eax
  801f91:	89 e9                	mov    %ebp,%ecx
  801f93:	d3 eb                	shr    %cl,%ebx
  801f95:	89 da                	mov    %ebx,%edx
  801f97:	83 c4 1c             	add    $0x1c,%esp
  801f9a:	5b                   	pop    %ebx
  801f9b:	5e                   	pop    %esi
  801f9c:	5f                   	pop    %edi
  801f9d:	5d                   	pop    %ebp
  801f9e:	c3                   	ret    
  801f9f:	90                   	nop
  801fa0:	89 fd                	mov    %edi,%ebp
  801fa2:	85 ff                	test   %edi,%edi
  801fa4:	75 0b                	jne    801fb1 <__umoddi3+0xe9>
  801fa6:	b8 01 00 00 00       	mov    $0x1,%eax
  801fab:	31 d2                	xor    %edx,%edx
  801fad:	f7 f7                	div    %edi
  801faf:	89 c5                	mov    %eax,%ebp
  801fb1:	89 f0                	mov    %esi,%eax
  801fb3:	31 d2                	xor    %edx,%edx
  801fb5:	f7 f5                	div    %ebp
  801fb7:	89 c8                	mov    %ecx,%eax
  801fb9:	f7 f5                	div    %ebp
  801fbb:	89 d0                	mov    %edx,%eax
  801fbd:	e9 44 ff ff ff       	jmp    801f06 <__umoddi3+0x3e>
  801fc2:	66 90                	xchg   %ax,%ax
  801fc4:	89 c8                	mov    %ecx,%eax
  801fc6:	89 f2                	mov    %esi,%edx
  801fc8:	83 c4 1c             	add    $0x1c,%esp
  801fcb:	5b                   	pop    %ebx
  801fcc:	5e                   	pop    %esi
  801fcd:	5f                   	pop    %edi
  801fce:	5d                   	pop    %ebp
  801fcf:	c3                   	ret    
  801fd0:	3b 04 24             	cmp    (%esp),%eax
  801fd3:	72 06                	jb     801fdb <__umoddi3+0x113>
  801fd5:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fd9:	77 0f                	ja     801fea <__umoddi3+0x122>
  801fdb:	89 f2                	mov    %esi,%edx
  801fdd:	29 f9                	sub    %edi,%ecx
  801fdf:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fe3:	89 14 24             	mov    %edx,(%esp)
  801fe6:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fea:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fee:	8b 14 24             	mov    (%esp),%edx
  801ff1:	83 c4 1c             	add    $0x1c,%esp
  801ff4:	5b                   	pop    %ebx
  801ff5:	5e                   	pop    %esi
  801ff6:	5f                   	pop    %edi
  801ff7:	5d                   	pop    %ebp
  801ff8:	c3                   	ret    
  801ff9:	8d 76 00             	lea    0x0(%esi),%esi
  801ffc:	2b 04 24             	sub    (%esp),%eax
  801fff:	19 fa                	sbb    %edi,%edx
  802001:	89 d1                	mov    %edx,%ecx
  802003:	89 c6                	mov    %eax,%esi
  802005:	e9 71 ff ff ff       	jmp    801f7b <__umoddi3+0xb3>
  80200a:	66 90                	xchg   %ax,%ax
  80200c:	39 44 24 04          	cmp    %eax,0x4(%esp)
  802010:	72 ea                	jb     801ffc <__umoddi3+0x134>
  802012:	89 d9                	mov    %ebx,%ecx
  802014:	e9 62 ff ff ff       	jmp    801f7b <__umoddi3+0xb3>
