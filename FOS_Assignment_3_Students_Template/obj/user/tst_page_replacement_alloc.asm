
obj/user/tst_page_replacement_alloc:     file format elf32-i386


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
  800031:	e8 4f 03 00 00       	call   800385 <libmain>
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
  80003b:	53                   	push   %ebx
  80003c:	83 ec 44             	sub    $0x44,%esp

//	cprintf("envID = %d\n",envID);

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80003f:	a1 20 30 80 00       	mov    0x803020,%eax
  800044:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80004a:	8b 00                	mov    (%eax),%eax
  80004c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80004f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800052:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800057:	3d 00 00 20 00       	cmp    $0x200000,%eax
  80005c:	74 14                	je     800072 <_main+0x3a>
  80005e:	83 ec 04             	sub    $0x4,%esp
  800061:	68 c0 1d 80 00       	push   $0x801dc0
  800066:	6a 12                	push   $0x12
  800068:	68 04 1e 80 00       	push   $0x801e04
  80006d:	e8 2f 04 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800072:	a1 20 30 80 00       	mov    0x803020,%eax
  800077:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80007d:	83 c0 18             	add    $0x18,%eax
  800080:	8b 00                	mov    (%eax),%eax
  800082:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800085:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800088:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80008d:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800092:	74 14                	je     8000a8 <_main+0x70>
  800094:	83 ec 04             	sub    $0x4,%esp
  800097:	68 c0 1d 80 00       	push   $0x801dc0
  80009c:	6a 13                	push   $0x13
  80009e:	68 04 1e 80 00       	push   $0x801e04
  8000a3:	e8 f9 03 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000a8:	a1 20 30 80 00       	mov    0x803020,%eax
  8000ad:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000b3:	83 c0 30             	add    $0x30,%eax
  8000b6:	8b 00                	mov    (%eax),%eax
  8000b8:	89 45 e8             	mov    %eax,-0x18(%ebp)
  8000bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8000be:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c3:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000c8:	74 14                	je     8000de <_main+0xa6>
  8000ca:	83 ec 04             	sub    $0x4,%esp
  8000cd:	68 c0 1d 80 00       	push   $0x801dc0
  8000d2:	6a 14                	push   $0x14
  8000d4:	68 04 1e 80 00       	push   $0x801e04
  8000d9:	e8 c3 03 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000de:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e3:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000e9:	83 c0 48             	add    $0x48,%eax
  8000ec:	8b 00                	mov    (%eax),%eax
  8000ee:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8000f1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8000f4:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000f9:	3d 00 30 20 00       	cmp    $0x203000,%eax
  8000fe:	74 14                	je     800114 <_main+0xdc>
  800100:	83 ec 04             	sub    $0x4,%esp
  800103:	68 c0 1d 80 00       	push   $0x801dc0
  800108:	6a 15                	push   $0x15
  80010a:	68 04 1e 80 00       	push   $0x801e04
  80010f:	e8 8d 03 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800114:	a1 20 30 80 00       	mov    0x803020,%eax
  800119:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80011f:	83 c0 60             	add    $0x60,%eax
  800122:	8b 00                	mov    (%eax),%eax
  800124:	89 45 e0             	mov    %eax,-0x20(%ebp)
  800127:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80012a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80012f:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800134:	74 14                	je     80014a <_main+0x112>
  800136:	83 ec 04             	sub    $0x4,%esp
  800139:	68 c0 1d 80 00       	push   $0x801dc0
  80013e:	6a 16                	push   $0x16
  800140:	68 04 1e 80 00       	push   $0x801e04
  800145:	e8 57 03 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014a:	a1 20 30 80 00       	mov    0x803020,%eax
  80014f:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800155:	83 c0 78             	add    $0x78,%eax
  800158:	8b 00                	mov    (%eax),%eax
  80015a:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80015d:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800160:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800165:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016a:	74 14                	je     800180 <_main+0x148>
  80016c:	83 ec 04             	sub    $0x4,%esp
  80016f:	68 c0 1d 80 00       	push   $0x801dc0
  800174:	6a 17                	push   $0x17
  800176:	68 04 1e 80 00       	push   $0x801e04
  80017b:	e8 21 03 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800180:	a1 20 30 80 00       	mov    0x803020,%eax
  800185:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80018b:	05 90 00 00 00       	add    $0x90,%eax
  800190:	8b 00                	mov    (%eax),%eax
  800192:	89 45 d8             	mov    %eax,-0x28(%ebp)
  800195:	8b 45 d8             	mov    -0x28(%ebp),%eax
  800198:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019d:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001a2:	74 14                	je     8001b8 <_main+0x180>
  8001a4:	83 ec 04             	sub    $0x4,%esp
  8001a7:	68 c0 1d 80 00       	push   $0x801dc0
  8001ac:	6a 18                	push   $0x18
  8001ae:	68 04 1e 80 00       	push   $0x801e04
  8001b3:	e8 e9 02 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001b8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bd:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8001c3:	05 a8 00 00 00       	add    $0xa8,%eax
  8001c8:	8b 00                	mov    (%eax),%eax
  8001ca:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8001cd:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8001d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001d5:	3d 00 10 80 00       	cmp    $0x801000,%eax
  8001da:	74 14                	je     8001f0 <_main+0x1b8>
  8001dc:	83 ec 04             	sub    $0x4,%esp
  8001df:	68 c0 1d 80 00       	push   $0x801dc0
  8001e4:	6a 19                	push   $0x19
  8001e6:	68 04 1e 80 00       	push   $0x801e04
  8001eb:	e8 b1 02 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f0:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f5:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8001fb:	05 c0 00 00 00       	add    $0xc0,%eax
  800200:	8b 00                	mov    (%eax),%eax
  800202:	89 45 d0             	mov    %eax,-0x30(%ebp)
  800205:	8b 45 d0             	mov    -0x30(%ebp),%eax
  800208:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80020d:	3d 00 20 80 00       	cmp    $0x802000,%eax
  800212:	74 14                	je     800228 <_main+0x1f0>
  800214:	83 ec 04             	sub    $0x4,%esp
  800217:	68 c0 1d 80 00       	push   $0x801dc0
  80021c:	6a 1a                	push   $0x1a
  80021e:	68 04 1e 80 00       	push   $0x801e04
  800223:	e8 79 02 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800228:	a1 20 30 80 00       	mov    0x803020,%eax
  80022d:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800233:	05 d8 00 00 00       	add    $0xd8,%eax
  800238:	8b 00                	mov    (%eax),%eax
  80023a:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80023d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800240:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800245:	3d 00 30 80 00       	cmp    $0x803000,%eax
  80024a:	74 14                	je     800260 <_main+0x228>
  80024c:	83 ec 04             	sub    $0x4,%esp
  80024f:	68 c0 1d 80 00       	push   $0x801dc0
  800254:	6a 1b                	push   $0x1b
  800256:	68 04 1e 80 00       	push   $0x801e04
  80025b:	e8 41 02 00 00       	call   8004a1 <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800260:	a1 20 30 80 00       	mov    0x803020,%eax
  800265:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80026b:	05 f0 00 00 00       	add    $0xf0,%eax
  800270:	8b 00                	mov    (%eax),%eax
  800272:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800275:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800278:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80027d:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  800282:	74 14                	je     800298 <_main+0x260>
  800284:	83 ec 04             	sub    $0x4,%esp
  800287:	68 c0 1d 80 00       	push   $0x801dc0
  80028c:	6a 1c                	push   $0x1c
  80028e:	68 04 1e 80 00       	push   $0x801e04
  800293:	e8 09 02 00 00       	call   8004a1 <_panic>
		if( myEnv->page_last_WS_index !=  0)  										panic("INITIAL PAGE WS last index checking failed! Review size of the WS..!!");
  800298:	a1 20 30 80 00       	mov    0x803020,%eax
  80029d:	8b 80 2c 05 00 00    	mov    0x52c(%eax),%eax
  8002a3:	85 c0                	test   %eax,%eax
  8002a5:	74 14                	je     8002bb <_main+0x283>
  8002a7:	83 ec 04             	sub    $0x4,%esp
  8002aa:	68 28 1e 80 00       	push   $0x801e28
  8002af:	6a 1d                	push   $0x1d
  8002b1:	68 04 1e 80 00       	push   $0x801e04
  8002b6:	e8 e6 01 00 00       	call   8004a1 <_panic>
	}

	int freePages = sys_calculate_free_frames();
  8002bb:	e8 8b 13 00 00       	call   80164b <sys_calculate_free_frames>
  8002c0:	89 45 c4             	mov    %eax,-0x3c(%ebp)
	int usedDiskPages = sys_pf_calculate_allocated_pages();
  8002c3:	e8 06 14 00 00       	call   8016ce <sys_pf_calculate_allocated_pages>
  8002c8:	89 45 c0             	mov    %eax,-0x40(%ebp)

	//Reading (Not Modified)
	char garbage1 = arr[PAGE_SIZE*11-1] ;
  8002cb:	a0 3f e0 80 00       	mov    0x80e03f,%al
  8002d0:	88 45 bf             	mov    %al,-0x41(%ebp)
	char garbage2 = arr[PAGE_SIZE*12-1] ;
  8002d3:	a0 3f f0 80 00       	mov    0x80f03f,%al
  8002d8:	88 45 be             	mov    %al,-0x42(%ebp)

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  8002db:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  8002e2:	eb 37                	jmp    80031b <_main+0x2e3>
	{
		arr[i] = -1 ;
  8002e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8002e7:	05 40 30 80 00       	add    $0x803040,%eax
  8002ec:	c6 00 ff             	movb   $0xff,(%eax)
		/*2016: this BUGGY line is REMOVED el7! it overwrites the KERNEL CODE :( !!!*/
		//*ptr = *ptr2 ;
		/*==========================================================================*/
		//always use pages at 0x801000 and 0x804000
		*ptr2 = *ptr ;
  8002ef:	a1 04 30 80 00       	mov    0x803004,%eax
  8002f4:	8b 15 00 30 80 00    	mov    0x803000,%edx
  8002fa:	8a 12                	mov    (%edx),%dl
  8002fc:	88 10                	mov    %dl,(%eax)
		ptr++ ; ptr2++ ;
  8002fe:	a1 00 30 80 00       	mov    0x803000,%eax
  800303:	40                   	inc    %eax
  800304:	a3 00 30 80 00       	mov    %eax,0x803000
  800309:	a1 04 30 80 00       	mov    0x803004,%eax
  80030e:	40                   	inc    %eax
  80030f:	a3 04 30 80 00       	mov    %eax,0x803004
	char garbage1 = arr[PAGE_SIZE*11-1] ;
	char garbage2 = arr[PAGE_SIZE*12-1] ;

	//Writing (Modified)
	int i ;
	for (i = 0 ; i < PAGE_SIZE*10 ; i+=PAGE_SIZE/2)
  800314:	81 45 f4 00 08 00 00 	addl   $0x800,-0xc(%ebp)
  80031b:	81 7d f4 ff 9f 00 00 	cmpl   $0x9fff,-0xc(%ebp)
  800322:	7e c0                	jle    8002e4 <_main+0x2ac>

	//===================

	//cprintf("Checking Allocation in Mem & Page File... \n");
	{
		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  0) panic("Unexpected extra/less pages have been added to page file.. NOT Expected to add new pages to the page file");
  800324:	e8 a5 13 00 00       	call   8016ce <sys_pf_calculate_allocated_pages>
  800329:	3b 45 c0             	cmp    -0x40(%ebp),%eax
  80032c:	74 14                	je     800342 <_main+0x30a>
  80032e:	83 ec 04             	sub    $0x4,%esp
  800331:	68 70 1e 80 00       	push   $0x801e70
  800336:	6a 38                	push   $0x38
  800338:	68 04 1e 80 00       	push   $0x801e04
  80033d:	e8 5f 01 00 00       	call   8004a1 <_panic>

		uint32 freePagesAfter = (sys_calculate_free_frames() + sys_calculate_modified_frames());
  800342:	e8 04 13 00 00       	call   80164b <sys_calculate_free_frames>
  800347:	89 c3                	mov    %eax,%ebx
  800349:	e8 16 13 00 00       	call   801664 <sys_calculate_modified_frames>
  80034e:	01 d8                	add    %ebx,%eax
  800350:	89 45 b8             	mov    %eax,-0x48(%ebp)
		if( (freePages - freePagesAfter) != 0 )
  800353:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  800356:	3b 45 b8             	cmp    -0x48(%ebp),%eax
  800359:	74 14                	je     80036f <_main+0x337>
			panic("Extra memory are wrongly allocated... It's REplacement: expected that no extra frames are allocated");
  80035b:	83 ec 04             	sub    $0x4,%esp
  80035e:	68 dc 1e 80 00       	push   $0x801edc
  800363:	6a 3c                	push   $0x3c
  800365:	68 04 1e 80 00       	push   $0x801e04
  80036a:	e8 32 01 00 00       	call   8004a1 <_panic>

	}

	cprintf("Congratulations!! test PAGE replacement [ALLOCATION] by REMOVING ONLY ONE PAGE is completed successfully.\n");
  80036f:	83 ec 0c             	sub    $0xc,%esp
  800372:	68 40 1f 80 00       	push   $0x801f40
  800377:	e8 d9 03 00 00       	call   800755 <cprintf>
  80037c:	83 c4 10             	add    $0x10,%esp
	return;
  80037f:	90                   	nop
}
  800380:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800383:	c9                   	leave  
  800384:	c3                   	ret    

00800385 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800385:	55                   	push   %ebp
  800386:	89 e5                	mov    %esp,%ebp
  800388:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80038b:	e8 f0 11 00 00       	call   801580 <sys_getenvindex>
  800390:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800393:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800396:	89 d0                	mov    %edx,%eax
  800398:	01 c0                	add    %eax,%eax
  80039a:	01 d0                	add    %edx,%eax
  80039c:	c1 e0 04             	shl    $0x4,%eax
  80039f:	29 d0                	sub    %edx,%eax
  8003a1:	c1 e0 03             	shl    $0x3,%eax
  8003a4:	01 d0                	add    %edx,%eax
  8003a6:	c1 e0 02             	shl    $0x2,%eax
  8003a9:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  8003ae:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  8003b3:	a1 20 30 80 00       	mov    0x803020,%eax
  8003b8:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  8003be:	84 c0                	test   %al,%al
  8003c0:	74 0f                	je     8003d1 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  8003c2:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c7:	05 5c 05 00 00       	add    $0x55c,%eax
  8003cc:	a3 08 30 80 00       	mov    %eax,0x803008

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  8003d1:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8003d5:	7e 0a                	jle    8003e1 <libmain+0x5c>
		binaryname = argv[0];
  8003d7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003da:	8b 00                	mov    (%eax),%eax
  8003dc:	a3 08 30 80 00       	mov    %eax,0x803008

	// call user main routine
	_main(argc, argv);
  8003e1:	83 ec 08             	sub    $0x8,%esp
  8003e4:	ff 75 0c             	pushl  0xc(%ebp)
  8003e7:	ff 75 08             	pushl  0x8(%ebp)
  8003ea:	e8 49 fc ff ff       	call   800038 <_main>
  8003ef:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8003f2:	e8 24 13 00 00       	call   80171b <sys_disable_interrupt>
	cprintf("**************************************\n");
  8003f7:	83 ec 0c             	sub    $0xc,%esp
  8003fa:	68 c4 1f 80 00       	push   $0x801fc4
  8003ff:	e8 51 03 00 00       	call   800755 <cprintf>
  800404:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800407:	a1 20 30 80 00       	mov    0x803020,%eax
  80040c:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  800412:	a1 20 30 80 00       	mov    0x803020,%eax
  800417:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  80041d:	83 ec 04             	sub    $0x4,%esp
  800420:	52                   	push   %edx
  800421:	50                   	push   %eax
  800422:	68 ec 1f 80 00       	push   $0x801fec
  800427:	e8 29 03 00 00       	call   800755 <cprintf>
  80042c:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  80042f:	a1 20 30 80 00       	mov    0x803020,%eax
  800434:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  80043a:	a1 20 30 80 00       	mov    0x803020,%eax
  80043f:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  800445:	a1 20 30 80 00       	mov    0x803020,%eax
  80044a:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800450:	51                   	push   %ecx
  800451:	52                   	push   %edx
  800452:	50                   	push   %eax
  800453:	68 14 20 80 00       	push   $0x802014
  800458:	e8 f8 02 00 00       	call   800755 <cprintf>
  80045d:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800460:	83 ec 0c             	sub    $0xc,%esp
  800463:	68 c4 1f 80 00       	push   $0x801fc4
  800468:	e8 e8 02 00 00       	call   800755 <cprintf>
  80046d:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800470:	e8 c0 12 00 00       	call   801735 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800475:	e8 19 00 00 00       	call   800493 <exit>
}
  80047a:	90                   	nop
  80047b:	c9                   	leave  
  80047c:	c3                   	ret    

0080047d <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  80047d:	55                   	push   %ebp
  80047e:	89 e5                	mov    %esp,%ebp
  800480:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800483:	83 ec 0c             	sub    $0xc,%esp
  800486:	6a 00                	push   $0x0
  800488:	e8 bf 10 00 00       	call   80154c <sys_env_destroy>
  80048d:	83 c4 10             	add    $0x10,%esp
}
  800490:	90                   	nop
  800491:	c9                   	leave  
  800492:	c3                   	ret    

00800493 <exit>:

void
exit(void)
{
  800493:	55                   	push   %ebp
  800494:	89 e5                	mov    %esp,%ebp
  800496:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  800499:	e8 14 11 00 00       	call   8015b2 <sys_env_exit>
}
  80049e:	90                   	nop
  80049f:	c9                   	leave  
  8004a0:	c3                   	ret    

008004a1 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8004a1:	55                   	push   %ebp
  8004a2:	89 e5                	mov    %esp,%ebp
  8004a4:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  8004a7:	8d 45 10             	lea    0x10(%ebp),%eax
  8004aa:	83 c0 04             	add    $0x4,%eax
  8004ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  8004b0:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8004b5:	85 c0                	test   %eax,%eax
  8004b7:	74 16                	je     8004cf <_panic+0x2e>
		cprintf("%s: ", argv0);
  8004b9:	a1 18 f1 80 00       	mov    0x80f118,%eax
  8004be:	83 ec 08             	sub    $0x8,%esp
  8004c1:	50                   	push   %eax
  8004c2:	68 6c 20 80 00       	push   $0x80206c
  8004c7:	e8 89 02 00 00       	call   800755 <cprintf>
  8004cc:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  8004cf:	a1 08 30 80 00       	mov    0x803008,%eax
  8004d4:	ff 75 0c             	pushl  0xc(%ebp)
  8004d7:	ff 75 08             	pushl  0x8(%ebp)
  8004da:	50                   	push   %eax
  8004db:	68 71 20 80 00       	push   $0x802071
  8004e0:	e8 70 02 00 00       	call   800755 <cprintf>
  8004e5:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  8004e8:	8b 45 10             	mov    0x10(%ebp),%eax
  8004eb:	83 ec 08             	sub    $0x8,%esp
  8004ee:	ff 75 f4             	pushl  -0xc(%ebp)
  8004f1:	50                   	push   %eax
  8004f2:	e8 f3 01 00 00       	call   8006ea <vcprintf>
  8004f7:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  8004fa:	83 ec 08             	sub    $0x8,%esp
  8004fd:	6a 00                	push   $0x0
  8004ff:	68 8d 20 80 00       	push   $0x80208d
  800504:	e8 e1 01 00 00       	call   8006ea <vcprintf>
  800509:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  80050c:	e8 82 ff ff ff       	call   800493 <exit>

	// should not return here
	while (1) ;
  800511:	eb fe                	jmp    800511 <_panic+0x70>

00800513 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  800513:	55                   	push   %ebp
  800514:	89 e5                	mov    %esp,%ebp
  800516:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800519:	a1 20 30 80 00       	mov    0x803020,%eax
  80051e:	8b 50 74             	mov    0x74(%eax),%edx
  800521:	8b 45 0c             	mov    0xc(%ebp),%eax
  800524:	39 c2                	cmp    %eax,%edx
  800526:	74 14                	je     80053c <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800528:	83 ec 04             	sub    $0x4,%esp
  80052b:	68 90 20 80 00       	push   $0x802090
  800530:	6a 26                	push   $0x26
  800532:	68 dc 20 80 00       	push   $0x8020dc
  800537:	e8 65 ff ff ff       	call   8004a1 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  80053c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  800543:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  80054a:	e9 c2 00 00 00       	jmp    800611 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  80054f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800552:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800559:	8b 45 08             	mov    0x8(%ebp),%eax
  80055c:	01 d0                	add    %edx,%eax
  80055e:	8b 00                	mov    (%eax),%eax
  800560:	85 c0                	test   %eax,%eax
  800562:	75 08                	jne    80056c <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800564:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  800567:	e9 a2 00 00 00       	jmp    80060e <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  80056c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800573:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80057a:	eb 69                	jmp    8005e5 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  80057c:	a1 20 30 80 00       	mov    0x803020,%eax
  800581:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800587:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80058a:	89 d0                	mov    %edx,%eax
  80058c:	01 c0                	add    %eax,%eax
  80058e:	01 d0                	add    %edx,%eax
  800590:	c1 e0 03             	shl    $0x3,%eax
  800593:	01 c8                	add    %ecx,%eax
  800595:	8a 40 04             	mov    0x4(%eax),%al
  800598:	84 c0                	test   %al,%al
  80059a:	75 46                	jne    8005e2 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80059c:	a1 20 30 80 00       	mov    0x803020,%eax
  8005a1:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8005a7:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8005aa:	89 d0                	mov    %edx,%eax
  8005ac:	01 c0                	add    %eax,%eax
  8005ae:	01 d0                	add    %edx,%eax
  8005b0:	c1 e0 03             	shl    $0x3,%eax
  8005b3:	01 c8                	add    %ecx,%eax
  8005b5:	8b 00                	mov    (%eax),%eax
  8005b7:	89 45 dc             	mov    %eax,-0x24(%ebp)
  8005ba:	8b 45 dc             	mov    -0x24(%ebp),%eax
  8005bd:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8005c2:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  8005c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8005c7:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  8005ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8005d1:	01 c8                	add    %ecx,%eax
  8005d3:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8005d5:	39 c2                	cmp    %eax,%edx
  8005d7:	75 09                	jne    8005e2 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  8005d9:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  8005e0:	eb 12                	jmp    8005f4 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8005e2:	ff 45 e8             	incl   -0x18(%ebp)
  8005e5:	a1 20 30 80 00       	mov    0x803020,%eax
  8005ea:	8b 50 74             	mov    0x74(%eax),%edx
  8005ed:	8b 45 e8             	mov    -0x18(%ebp),%eax
  8005f0:	39 c2                	cmp    %eax,%edx
  8005f2:	77 88                	ja     80057c <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  8005f4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  8005f8:	75 14                	jne    80060e <CheckWSWithoutLastIndex+0xfb>
			panic(
  8005fa:	83 ec 04             	sub    $0x4,%esp
  8005fd:	68 e8 20 80 00       	push   $0x8020e8
  800602:	6a 3a                	push   $0x3a
  800604:	68 dc 20 80 00       	push   $0x8020dc
  800609:	e8 93 fe ff ff       	call   8004a1 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  80060e:	ff 45 f0             	incl   -0x10(%ebp)
  800611:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800614:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800617:	0f 8c 32 ff ff ff    	jl     80054f <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  80061d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800624:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80062b:	eb 26                	jmp    800653 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  80062d:	a1 20 30 80 00       	mov    0x803020,%eax
  800632:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800638:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80063b:	89 d0                	mov    %edx,%eax
  80063d:	01 c0                	add    %eax,%eax
  80063f:	01 d0                	add    %edx,%eax
  800641:	c1 e0 03             	shl    $0x3,%eax
  800644:	01 c8                	add    %ecx,%eax
  800646:	8a 40 04             	mov    0x4(%eax),%al
  800649:	3c 01                	cmp    $0x1,%al
  80064b:	75 03                	jne    800650 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  80064d:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800650:	ff 45 e0             	incl   -0x20(%ebp)
  800653:	a1 20 30 80 00       	mov    0x803020,%eax
  800658:	8b 50 74             	mov    0x74(%eax),%edx
  80065b:	8b 45 e0             	mov    -0x20(%ebp),%eax
  80065e:	39 c2                	cmp    %eax,%edx
  800660:	77 cb                	ja     80062d <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800662:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800665:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  800668:	74 14                	je     80067e <CheckWSWithoutLastIndex+0x16b>
		panic(
  80066a:	83 ec 04             	sub    $0x4,%esp
  80066d:	68 3c 21 80 00       	push   $0x80213c
  800672:	6a 44                	push   $0x44
  800674:	68 dc 20 80 00       	push   $0x8020dc
  800679:	e8 23 fe ff ff       	call   8004a1 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  80067e:	90                   	nop
  80067f:	c9                   	leave  
  800680:	c3                   	ret    

00800681 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800681:	55                   	push   %ebp
  800682:	89 e5                	mov    %esp,%ebp
  800684:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  800687:	8b 45 0c             	mov    0xc(%ebp),%eax
  80068a:	8b 00                	mov    (%eax),%eax
  80068c:	8d 48 01             	lea    0x1(%eax),%ecx
  80068f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800692:	89 0a                	mov    %ecx,(%edx)
  800694:	8b 55 08             	mov    0x8(%ebp),%edx
  800697:	88 d1                	mov    %dl,%cl
  800699:	8b 55 0c             	mov    0xc(%ebp),%edx
  80069c:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8006a0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006a3:	8b 00                	mov    (%eax),%eax
  8006a5:	3d ff 00 00 00       	cmp    $0xff,%eax
  8006aa:	75 2c                	jne    8006d8 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  8006ac:	a0 24 30 80 00       	mov    0x803024,%al
  8006b1:	0f b6 c0             	movzbl %al,%eax
  8006b4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006b7:	8b 12                	mov    (%edx),%edx
  8006b9:	89 d1                	mov    %edx,%ecx
  8006bb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8006be:	83 c2 08             	add    $0x8,%edx
  8006c1:	83 ec 04             	sub    $0x4,%esp
  8006c4:	50                   	push   %eax
  8006c5:	51                   	push   %ecx
  8006c6:	52                   	push   %edx
  8006c7:	e8 3e 0e 00 00       	call   80150a <sys_cputs>
  8006cc:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8006cf:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8006d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006db:	8b 40 04             	mov    0x4(%eax),%eax
  8006de:	8d 50 01             	lea    0x1(%eax),%edx
  8006e1:	8b 45 0c             	mov    0xc(%ebp),%eax
  8006e4:	89 50 04             	mov    %edx,0x4(%eax)
}
  8006e7:	90                   	nop
  8006e8:	c9                   	leave  
  8006e9:	c3                   	ret    

008006ea <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8006ea:	55                   	push   %ebp
  8006eb:	89 e5                	mov    %esp,%ebp
  8006ed:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8006f3:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8006fa:	00 00 00 
	b.cnt = 0;
  8006fd:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  800704:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800707:	ff 75 0c             	pushl  0xc(%ebp)
  80070a:	ff 75 08             	pushl  0x8(%ebp)
  80070d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800713:	50                   	push   %eax
  800714:	68 81 06 80 00       	push   $0x800681
  800719:	e8 11 02 00 00       	call   80092f <vprintfmt>
  80071e:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  800721:	a0 24 30 80 00       	mov    0x803024,%al
  800726:	0f b6 c0             	movzbl %al,%eax
  800729:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  80072f:	83 ec 04             	sub    $0x4,%esp
  800732:	50                   	push   %eax
  800733:	52                   	push   %edx
  800734:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80073a:	83 c0 08             	add    $0x8,%eax
  80073d:	50                   	push   %eax
  80073e:	e8 c7 0d 00 00       	call   80150a <sys_cputs>
  800743:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800746:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  80074d:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800753:	c9                   	leave  
  800754:	c3                   	ret    

00800755 <cprintf>:

int cprintf(const char *fmt, ...) {
  800755:	55                   	push   %ebp
  800756:	89 e5                	mov    %esp,%ebp
  800758:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80075b:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800762:	8d 45 0c             	lea    0xc(%ebp),%eax
  800765:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800768:	8b 45 08             	mov    0x8(%ebp),%eax
  80076b:	83 ec 08             	sub    $0x8,%esp
  80076e:	ff 75 f4             	pushl  -0xc(%ebp)
  800771:	50                   	push   %eax
  800772:	e8 73 ff ff ff       	call   8006ea <vcprintf>
  800777:	83 c4 10             	add    $0x10,%esp
  80077a:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  80077d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800780:	c9                   	leave  
  800781:	c3                   	ret    

00800782 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800782:	55                   	push   %ebp
  800783:	89 e5                	mov    %esp,%ebp
  800785:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  800788:	e8 8e 0f 00 00       	call   80171b <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  80078d:	8d 45 0c             	lea    0xc(%ebp),%eax
  800790:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800793:	8b 45 08             	mov    0x8(%ebp),%eax
  800796:	83 ec 08             	sub    $0x8,%esp
  800799:	ff 75 f4             	pushl  -0xc(%ebp)
  80079c:	50                   	push   %eax
  80079d:	e8 48 ff ff ff       	call   8006ea <vcprintf>
  8007a2:	83 c4 10             	add    $0x10,%esp
  8007a5:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  8007a8:	e8 88 0f 00 00       	call   801735 <sys_enable_interrupt>
	return cnt;
  8007ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8007b0:	c9                   	leave  
  8007b1:	c3                   	ret    

008007b2 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  8007b2:	55                   	push   %ebp
  8007b3:	89 e5                	mov    %esp,%ebp
  8007b5:	53                   	push   %ebx
  8007b6:	83 ec 14             	sub    $0x14,%esp
  8007b9:	8b 45 10             	mov    0x10(%ebp),%eax
  8007bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8007c2:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  8007c5:	8b 45 18             	mov    0x18(%ebp),%eax
  8007c8:	ba 00 00 00 00       	mov    $0x0,%edx
  8007cd:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007d0:	77 55                	ja     800827 <printnum+0x75>
  8007d2:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8007d5:	72 05                	jb     8007dc <printnum+0x2a>
  8007d7:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8007da:	77 4b                	ja     800827 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8007dc:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8007df:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8007e2:	8b 45 18             	mov    0x18(%ebp),%eax
  8007e5:	ba 00 00 00 00       	mov    $0x0,%edx
  8007ea:	52                   	push   %edx
  8007eb:	50                   	push   %eax
  8007ec:	ff 75 f4             	pushl  -0xc(%ebp)
  8007ef:	ff 75 f0             	pushl  -0x10(%ebp)
  8007f2:	e8 61 13 00 00       	call   801b58 <__udivdi3>
  8007f7:	83 c4 10             	add    $0x10,%esp
  8007fa:	83 ec 04             	sub    $0x4,%esp
  8007fd:	ff 75 20             	pushl  0x20(%ebp)
  800800:	53                   	push   %ebx
  800801:	ff 75 18             	pushl  0x18(%ebp)
  800804:	52                   	push   %edx
  800805:	50                   	push   %eax
  800806:	ff 75 0c             	pushl  0xc(%ebp)
  800809:	ff 75 08             	pushl  0x8(%ebp)
  80080c:	e8 a1 ff ff ff       	call   8007b2 <printnum>
  800811:	83 c4 20             	add    $0x20,%esp
  800814:	eb 1a                	jmp    800830 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800816:	83 ec 08             	sub    $0x8,%esp
  800819:	ff 75 0c             	pushl  0xc(%ebp)
  80081c:	ff 75 20             	pushl  0x20(%ebp)
  80081f:	8b 45 08             	mov    0x8(%ebp),%eax
  800822:	ff d0                	call   *%eax
  800824:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800827:	ff 4d 1c             	decl   0x1c(%ebp)
  80082a:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  80082e:	7f e6                	jg     800816 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800830:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800833:	bb 00 00 00 00       	mov    $0x0,%ebx
  800838:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80083b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80083e:	53                   	push   %ebx
  80083f:	51                   	push   %ecx
  800840:	52                   	push   %edx
  800841:	50                   	push   %eax
  800842:	e8 21 14 00 00       	call   801c68 <__umoddi3>
  800847:	83 c4 10             	add    $0x10,%esp
  80084a:	05 b4 23 80 00       	add    $0x8023b4,%eax
  80084f:	8a 00                	mov    (%eax),%al
  800851:	0f be c0             	movsbl %al,%eax
  800854:	83 ec 08             	sub    $0x8,%esp
  800857:	ff 75 0c             	pushl  0xc(%ebp)
  80085a:	50                   	push   %eax
  80085b:	8b 45 08             	mov    0x8(%ebp),%eax
  80085e:	ff d0                	call   *%eax
  800860:	83 c4 10             	add    $0x10,%esp
}
  800863:	90                   	nop
  800864:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800867:	c9                   	leave  
  800868:	c3                   	ret    

00800869 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800869:	55                   	push   %ebp
  80086a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80086c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800870:	7e 1c                	jle    80088e <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800872:	8b 45 08             	mov    0x8(%ebp),%eax
  800875:	8b 00                	mov    (%eax),%eax
  800877:	8d 50 08             	lea    0x8(%eax),%edx
  80087a:	8b 45 08             	mov    0x8(%ebp),%eax
  80087d:	89 10                	mov    %edx,(%eax)
  80087f:	8b 45 08             	mov    0x8(%ebp),%eax
  800882:	8b 00                	mov    (%eax),%eax
  800884:	83 e8 08             	sub    $0x8,%eax
  800887:	8b 50 04             	mov    0x4(%eax),%edx
  80088a:	8b 00                	mov    (%eax),%eax
  80088c:	eb 40                	jmp    8008ce <getuint+0x65>
	else if (lflag)
  80088e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800892:	74 1e                	je     8008b2 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800894:	8b 45 08             	mov    0x8(%ebp),%eax
  800897:	8b 00                	mov    (%eax),%eax
  800899:	8d 50 04             	lea    0x4(%eax),%edx
  80089c:	8b 45 08             	mov    0x8(%ebp),%eax
  80089f:	89 10                	mov    %edx,(%eax)
  8008a1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a4:	8b 00                	mov    (%eax),%eax
  8008a6:	83 e8 04             	sub    $0x4,%eax
  8008a9:	8b 00                	mov    (%eax),%eax
  8008ab:	ba 00 00 00 00       	mov    $0x0,%edx
  8008b0:	eb 1c                	jmp    8008ce <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  8008b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8008b5:	8b 00                	mov    (%eax),%eax
  8008b7:	8d 50 04             	lea    0x4(%eax),%edx
  8008ba:	8b 45 08             	mov    0x8(%ebp),%eax
  8008bd:	89 10                	mov    %edx,(%eax)
  8008bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8008c2:	8b 00                	mov    (%eax),%eax
  8008c4:	83 e8 04             	sub    $0x4,%eax
  8008c7:	8b 00                	mov    (%eax),%eax
  8008c9:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8008ce:	5d                   	pop    %ebp
  8008cf:	c3                   	ret    

008008d0 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8008d0:	55                   	push   %ebp
  8008d1:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8008d3:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8008d7:	7e 1c                	jle    8008f5 <getint+0x25>
		return va_arg(*ap, long long);
  8008d9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008dc:	8b 00                	mov    (%eax),%eax
  8008de:	8d 50 08             	lea    0x8(%eax),%edx
  8008e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e4:	89 10                	mov    %edx,(%eax)
  8008e6:	8b 45 08             	mov    0x8(%ebp),%eax
  8008e9:	8b 00                	mov    (%eax),%eax
  8008eb:	83 e8 08             	sub    $0x8,%eax
  8008ee:	8b 50 04             	mov    0x4(%eax),%edx
  8008f1:	8b 00                	mov    (%eax),%eax
  8008f3:	eb 38                	jmp    80092d <getint+0x5d>
	else if (lflag)
  8008f5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8008f9:	74 1a                	je     800915 <getint+0x45>
		return va_arg(*ap, long);
  8008fb:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fe:	8b 00                	mov    (%eax),%eax
  800900:	8d 50 04             	lea    0x4(%eax),%edx
  800903:	8b 45 08             	mov    0x8(%ebp),%eax
  800906:	89 10                	mov    %edx,(%eax)
  800908:	8b 45 08             	mov    0x8(%ebp),%eax
  80090b:	8b 00                	mov    (%eax),%eax
  80090d:	83 e8 04             	sub    $0x4,%eax
  800910:	8b 00                	mov    (%eax),%eax
  800912:	99                   	cltd   
  800913:	eb 18                	jmp    80092d <getint+0x5d>
	else
		return va_arg(*ap, int);
  800915:	8b 45 08             	mov    0x8(%ebp),%eax
  800918:	8b 00                	mov    (%eax),%eax
  80091a:	8d 50 04             	lea    0x4(%eax),%edx
  80091d:	8b 45 08             	mov    0x8(%ebp),%eax
  800920:	89 10                	mov    %edx,(%eax)
  800922:	8b 45 08             	mov    0x8(%ebp),%eax
  800925:	8b 00                	mov    (%eax),%eax
  800927:	83 e8 04             	sub    $0x4,%eax
  80092a:	8b 00                	mov    (%eax),%eax
  80092c:	99                   	cltd   
}
  80092d:	5d                   	pop    %ebp
  80092e:	c3                   	ret    

0080092f <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  80092f:	55                   	push   %ebp
  800930:	89 e5                	mov    %esp,%ebp
  800932:	56                   	push   %esi
  800933:	53                   	push   %ebx
  800934:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800937:	eb 17                	jmp    800950 <vprintfmt+0x21>
			if (ch == '\0')
  800939:	85 db                	test   %ebx,%ebx
  80093b:	0f 84 af 03 00 00    	je     800cf0 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800941:	83 ec 08             	sub    $0x8,%esp
  800944:	ff 75 0c             	pushl  0xc(%ebp)
  800947:	53                   	push   %ebx
  800948:	8b 45 08             	mov    0x8(%ebp),%eax
  80094b:	ff d0                	call   *%eax
  80094d:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800950:	8b 45 10             	mov    0x10(%ebp),%eax
  800953:	8d 50 01             	lea    0x1(%eax),%edx
  800956:	89 55 10             	mov    %edx,0x10(%ebp)
  800959:	8a 00                	mov    (%eax),%al
  80095b:	0f b6 d8             	movzbl %al,%ebx
  80095e:	83 fb 25             	cmp    $0x25,%ebx
  800961:	75 d6                	jne    800939 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800963:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800967:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  80096e:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800975:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80097c:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800983:	8b 45 10             	mov    0x10(%ebp),%eax
  800986:	8d 50 01             	lea    0x1(%eax),%edx
  800989:	89 55 10             	mov    %edx,0x10(%ebp)
  80098c:	8a 00                	mov    (%eax),%al
  80098e:	0f b6 d8             	movzbl %al,%ebx
  800991:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800994:	83 f8 55             	cmp    $0x55,%eax
  800997:	0f 87 2b 03 00 00    	ja     800cc8 <vprintfmt+0x399>
  80099d:	8b 04 85 d8 23 80 00 	mov    0x8023d8(,%eax,4),%eax
  8009a4:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  8009a6:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  8009aa:	eb d7                	jmp    800983 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  8009ac:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  8009b0:	eb d1                	jmp    800983 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  8009b9:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8009bc:	89 d0                	mov    %edx,%eax
  8009be:	c1 e0 02             	shl    $0x2,%eax
  8009c1:	01 d0                	add    %edx,%eax
  8009c3:	01 c0                	add    %eax,%eax
  8009c5:	01 d8                	add    %ebx,%eax
  8009c7:	83 e8 30             	sub    $0x30,%eax
  8009ca:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8009cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8009d0:	8a 00                	mov    (%eax),%al
  8009d2:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8009d5:	83 fb 2f             	cmp    $0x2f,%ebx
  8009d8:	7e 3e                	jle    800a18 <vprintfmt+0xe9>
  8009da:	83 fb 39             	cmp    $0x39,%ebx
  8009dd:	7f 39                	jg     800a18 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8009df:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8009e2:	eb d5                	jmp    8009b9 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8009e4:	8b 45 14             	mov    0x14(%ebp),%eax
  8009e7:	83 c0 04             	add    $0x4,%eax
  8009ea:	89 45 14             	mov    %eax,0x14(%ebp)
  8009ed:	8b 45 14             	mov    0x14(%ebp),%eax
  8009f0:	83 e8 04             	sub    $0x4,%eax
  8009f3:	8b 00                	mov    (%eax),%eax
  8009f5:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8009f8:	eb 1f                	jmp    800a19 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8009fa:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009fe:	79 83                	jns    800983 <vprintfmt+0x54>
				width = 0;
  800a00:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800a07:	e9 77 ff ff ff       	jmp    800983 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800a0c:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800a13:	e9 6b ff ff ff       	jmp    800983 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800a18:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800a19:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a1d:	0f 89 60 ff ff ff    	jns    800983 <vprintfmt+0x54>
				width = precision, precision = -1;
  800a23:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800a26:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800a29:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800a30:	e9 4e ff ff ff       	jmp    800983 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800a35:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800a38:	e9 46 ff ff ff       	jmp    800983 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800a3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800a40:	83 c0 04             	add    $0x4,%eax
  800a43:	89 45 14             	mov    %eax,0x14(%ebp)
  800a46:	8b 45 14             	mov    0x14(%ebp),%eax
  800a49:	83 e8 04             	sub    $0x4,%eax
  800a4c:	8b 00                	mov    (%eax),%eax
  800a4e:	83 ec 08             	sub    $0x8,%esp
  800a51:	ff 75 0c             	pushl  0xc(%ebp)
  800a54:	50                   	push   %eax
  800a55:	8b 45 08             	mov    0x8(%ebp),%eax
  800a58:	ff d0                	call   *%eax
  800a5a:	83 c4 10             	add    $0x10,%esp
			break;
  800a5d:	e9 89 02 00 00       	jmp    800ceb <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800a62:	8b 45 14             	mov    0x14(%ebp),%eax
  800a65:	83 c0 04             	add    $0x4,%eax
  800a68:	89 45 14             	mov    %eax,0x14(%ebp)
  800a6b:	8b 45 14             	mov    0x14(%ebp),%eax
  800a6e:	83 e8 04             	sub    $0x4,%eax
  800a71:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800a73:	85 db                	test   %ebx,%ebx
  800a75:	79 02                	jns    800a79 <vprintfmt+0x14a>
				err = -err;
  800a77:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800a79:	83 fb 64             	cmp    $0x64,%ebx
  800a7c:	7f 0b                	jg     800a89 <vprintfmt+0x15a>
  800a7e:	8b 34 9d 20 22 80 00 	mov    0x802220(,%ebx,4),%esi
  800a85:	85 f6                	test   %esi,%esi
  800a87:	75 19                	jne    800aa2 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800a89:	53                   	push   %ebx
  800a8a:	68 c5 23 80 00       	push   $0x8023c5
  800a8f:	ff 75 0c             	pushl  0xc(%ebp)
  800a92:	ff 75 08             	pushl  0x8(%ebp)
  800a95:	e8 5e 02 00 00       	call   800cf8 <printfmt>
  800a9a:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800a9d:	e9 49 02 00 00       	jmp    800ceb <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800aa2:	56                   	push   %esi
  800aa3:	68 ce 23 80 00       	push   $0x8023ce
  800aa8:	ff 75 0c             	pushl  0xc(%ebp)
  800aab:	ff 75 08             	pushl  0x8(%ebp)
  800aae:	e8 45 02 00 00       	call   800cf8 <printfmt>
  800ab3:	83 c4 10             	add    $0x10,%esp
			break;
  800ab6:	e9 30 02 00 00       	jmp    800ceb <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800abb:	8b 45 14             	mov    0x14(%ebp),%eax
  800abe:	83 c0 04             	add    $0x4,%eax
  800ac1:	89 45 14             	mov    %eax,0x14(%ebp)
  800ac4:	8b 45 14             	mov    0x14(%ebp),%eax
  800ac7:	83 e8 04             	sub    $0x4,%eax
  800aca:	8b 30                	mov    (%eax),%esi
  800acc:	85 f6                	test   %esi,%esi
  800ace:	75 05                	jne    800ad5 <vprintfmt+0x1a6>
				p = "(null)";
  800ad0:	be d1 23 80 00       	mov    $0x8023d1,%esi
			if (width > 0 && padc != '-')
  800ad5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800ad9:	7e 6d                	jle    800b48 <vprintfmt+0x219>
  800adb:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800adf:	74 67                	je     800b48 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800ae1:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800ae4:	83 ec 08             	sub    $0x8,%esp
  800ae7:	50                   	push   %eax
  800ae8:	56                   	push   %esi
  800ae9:	e8 0c 03 00 00       	call   800dfa <strnlen>
  800aee:	83 c4 10             	add    $0x10,%esp
  800af1:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800af4:	eb 16                	jmp    800b0c <vprintfmt+0x1dd>
					putch(padc, putdat);
  800af6:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800afa:	83 ec 08             	sub    $0x8,%esp
  800afd:	ff 75 0c             	pushl  0xc(%ebp)
  800b00:	50                   	push   %eax
  800b01:	8b 45 08             	mov    0x8(%ebp),%eax
  800b04:	ff d0                	call   *%eax
  800b06:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800b09:	ff 4d e4             	decl   -0x1c(%ebp)
  800b0c:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b10:	7f e4                	jg     800af6 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b12:	eb 34                	jmp    800b48 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800b14:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800b18:	74 1c                	je     800b36 <vprintfmt+0x207>
  800b1a:	83 fb 1f             	cmp    $0x1f,%ebx
  800b1d:	7e 05                	jle    800b24 <vprintfmt+0x1f5>
  800b1f:	83 fb 7e             	cmp    $0x7e,%ebx
  800b22:	7e 12                	jle    800b36 <vprintfmt+0x207>
					putch('?', putdat);
  800b24:	83 ec 08             	sub    $0x8,%esp
  800b27:	ff 75 0c             	pushl  0xc(%ebp)
  800b2a:	6a 3f                	push   $0x3f
  800b2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b2f:	ff d0                	call   *%eax
  800b31:	83 c4 10             	add    $0x10,%esp
  800b34:	eb 0f                	jmp    800b45 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800b36:	83 ec 08             	sub    $0x8,%esp
  800b39:	ff 75 0c             	pushl  0xc(%ebp)
  800b3c:	53                   	push   %ebx
  800b3d:	8b 45 08             	mov    0x8(%ebp),%eax
  800b40:	ff d0                	call   *%eax
  800b42:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800b45:	ff 4d e4             	decl   -0x1c(%ebp)
  800b48:	89 f0                	mov    %esi,%eax
  800b4a:	8d 70 01             	lea    0x1(%eax),%esi
  800b4d:	8a 00                	mov    (%eax),%al
  800b4f:	0f be d8             	movsbl %al,%ebx
  800b52:	85 db                	test   %ebx,%ebx
  800b54:	74 24                	je     800b7a <vprintfmt+0x24b>
  800b56:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b5a:	78 b8                	js     800b14 <vprintfmt+0x1e5>
  800b5c:	ff 4d e0             	decl   -0x20(%ebp)
  800b5f:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800b63:	79 af                	jns    800b14 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b65:	eb 13                	jmp    800b7a <vprintfmt+0x24b>
				putch(' ', putdat);
  800b67:	83 ec 08             	sub    $0x8,%esp
  800b6a:	ff 75 0c             	pushl  0xc(%ebp)
  800b6d:	6a 20                	push   $0x20
  800b6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b72:	ff d0                	call   *%eax
  800b74:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800b77:	ff 4d e4             	decl   -0x1c(%ebp)
  800b7a:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800b7e:	7f e7                	jg     800b67 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800b80:	e9 66 01 00 00       	jmp    800ceb <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800b85:	83 ec 08             	sub    $0x8,%esp
  800b88:	ff 75 e8             	pushl  -0x18(%ebp)
  800b8b:	8d 45 14             	lea    0x14(%ebp),%eax
  800b8e:	50                   	push   %eax
  800b8f:	e8 3c fd ff ff       	call   8008d0 <getint>
  800b94:	83 c4 10             	add    $0x10,%esp
  800b97:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b9a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800b9d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800ba0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800ba3:	85 d2                	test   %edx,%edx
  800ba5:	79 23                	jns    800bca <vprintfmt+0x29b>
				putch('-', putdat);
  800ba7:	83 ec 08             	sub    $0x8,%esp
  800baa:	ff 75 0c             	pushl  0xc(%ebp)
  800bad:	6a 2d                	push   $0x2d
  800baf:	8b 45 08             	mov    0x8(%ebp),%eax
  800bb2:	ff d0                	call   *%eax
  800bb4:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800bb7:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800bba:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800bbd:	f7 d8                	neg    %eax
  800bbf:	83 d2 00             	adc    $0x0,%edx
  800bc2:	f7 da                	neg    %edx
  800bc4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800bc7:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800bca:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bd1:	e9 bc 00 00 00       	jmp    800c92 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800bd6:	83 ec 08             	sub    $0x8,%esp
  800bd9:	ff 75 e8             	pushl  -0x18(%ebp)
  800bdc:	8d 45 14             	lea    0x14(%ebp),%eax
  800bdf:	50                   	push   %eax
  800be0:	e8 84 fc ff ff       	call   800869 <getuint>
  800be5:	83 c4 10             	add    $0x10,%esp
  800be8:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800beb:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800bee:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800bf5:	e9 98 00 00 00       	jmp    800c92 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800bfa:	83 ec 08             	sub    $0x8,%esp
  800bfd:	ff 75 0c             	pushl  0xc(%ebp)
  800c00:	6a 58                	push   $0x58
  800c02:	8b 45 08             	mov    0x8(%ebp),%eax
  800c05:	ff d0                	call   *%eax
  800c07:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c0a:	83 ec 08             	sub    $0x8,%esp
  800c0d:	ff 75 0c             	pushl  0xc(%ebp)
  800c10:	6a 58                	push   $0x58
  800c12:	8b 45 08             	mov    0x8(%ebp),%eax
  800c15:	ff d0                	call   *%eax
  800c17:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800c1a:	83 ec 08             	sub    $0x8,%esp
  800c1d:	ff 75 0c             	pushl  0xc(%ebp)
  800c20:	6a 58                	push   $0x58
  800c22:	8b 45 08             	mov    0x8(%ebp),%eax
  800c25:	ff d0                	call   *%eax
  800c27:	83 c4 10             	add    $0x10,%esp
			break;
  800c2a:	e9 bc 00 00 00       	jmp    800ceb <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800c2f:	83 ec 08             	sub    $0x8,%esp
  800c32:	ff 75 0c             	pushl  0xc(%ebp)
  800c35:	6a 30                	push   $0x30
  800c37:	8b 45 08             	mov    0x8(%ebp),%eax
  800c3a:	ff d0                	call   *%eax
  800c3c:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800c3f:	83 ec 08             	sub    $0x8,%esp
  800c42:	ff 75 0c             	pushl  0xc(%ebp)
  800c45:	6a 78                	push   $0x78
  800c47:	8b 45 08             	mov    0x8(%ebp),%eax
  800c4a:	ff d0                	call   *%eax
  800c4c:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800c4f:	8b 45 14             	mov    0x14(%ebp),%eax
  800c52:	83 c0 04             	add    $0x4,%eax
  800c55:	89 45 14             	mov    %eax,0x14(%ebp)
  800c58:	8b 45 14             	mov    0x14(%ebp),%eax
  800c5b:	83 e8 04             	sub    $0x4,%eax
  800c5e:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800c60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c63:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800c6a:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800c71:	eb 1f                	jmp    800c92 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800c73:	83 ec 08             	sub    $0x8,%esp
  800c76:	ff 75 e8             	pushl  -0x18(%ebp)
  800c79:	8d 45 14             	lea    0x14(%ebp),%eax
  800c7c:	50                   	push   %eax
  800c7d:	e8 e7 fb ff ff       	call   800869 <getuint>
  800c82:	83 c4 10             	add    $0x10,%esp
  800c85:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c88:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800c8b:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800c92:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800c96:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c99:	83 ec 04             	sub    $0x4,%esp
  800c9c:	52                   	push   %edx
  800c9d:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ca0:	50                   	push   %eax
  800ca1:	ff 75 f4             	pushl  -0xc(%ebp)
  800ca4:	ff 75 f0             	pushl  -0x10(%ebp)
  800ca7:	ff 75 0c             	pushl  0xc(%ebp)
  800caa:	ff 75 08             	pushl  0x8(%ebp)
  800cad:	e8 00 fb ff ff       	call   8007b2 <printnum>
  800cb2:	83 c4 20             	add    $0x20,%esp
			break;
  800cb5:	eb 34                	jmp    800ceb <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800cb7:	83 ec 08             	sub    $0x8,%esp
  800cba:	ff 75 0c             	pushl  0xc(%ebp)
  800cbd:	53                   	push   %ebx
  800cbe:	8b 45 08             	mov    0x8(%ebp),%eax
  800cc1:	ff d0                	call   *%eax
  800cc3:	83 c4 10             	add    $0x10,%esp
			break;
  800cc6:	eb 23                	jmp    800ceb <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800cc8:	83 ec 08             	sub    $0x8,%esp
  800ccb:	ff 75 0c             	pushl  0xc(%ebp)
  800cce:	6a 25                	push   $0x25
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	ff d0                	call   *%eax
  800cd5:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800cd8:	ff 4d 10             	decl   0x10(%ebp)
  800cdb:	eb 03                	jmp    800ce0 <vprintfmt+0x3b1>
  800cdd:	ff 4d 10             	decl   0x10(%ebp)
  800ce0:	8b 45 10             	mov    0x10(%ebp),%eax
  800ce3:	48                   	dec    %eax
  800ce4:	8a 00                	mov    (%eax),%al
  800ce6:	3c 25                	cmp    $0x25,%al
  800ce8:	75 f3                	jne    800cdd <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800cea:	90                   	nop
		}
	}
  800ceb:	e9 47 fc ff ff       	jmp    800937 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800cf0:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800cf1:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800cf4:	5b                   	pop    %ebx
  800cf5:	5e                   	pop    %esi
  800cf6:	5d                   	pop    %ebp
  800cf7:	c3                   	ret    

00800cf8 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800cf8:	55                   	push   %ebp
  800cf9:	89 e5                	mov    %esp,%ebp
  800cfb:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800cfe:	8d 45 10             	lea    0x10(%ebp),%eax
  800d01:	83 c0 04             	add    $0x4,%eax
  800d04:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800d07:	8b 45 10             	mov    0x10(%ebp),%eax
  800d0a:	ff 75 f4             	pushl  -0xc(%ebp)
  800d0d:	50                   	push   %eax
  800d0e:	ff 75 0c             	pushl  0xc(%ebp)
  800d11:	ff 75 08             	pushl  0x8(%ebp)
  800d14:	e8 16 fc ff ff       	call   80092f <vprintfmt>
  800d19:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800d1c:	90                   	nop
  800d1d:	c9                   	leave  
  800d1e:	c3                   	ret    

00800d1f <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800d1f:	55                   	push   %ebp
  800d20:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800d22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d25:	8b 40 08             	mov    0x8(%eax),%eax
  800d28:	8d 50 01             	lea    0x1(%eax),%edx
  800d2b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d2e:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800d31:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d34:	8b 10                	mov    (%eax),%edx
  800d36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d39:	8b 40 04             	mov    0x4(%eax),%eax
  800d3c:	39 c2                	cmp    %eax,%edx
  800d3e:	73 12                	jae    800d52 <sprintputch+0x33>
		*b->buf++ = ch;
  800d40:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d43:	8b 00                	mov    (%eax),%eax
  800d45:	8d 48 01             	lea    0x1(%eax),%ecx
  800d48:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d4b:	89 0a                	mov    %ecx,(%edx)
  800d4d:	8b 55 08             	mov    0x8(%ebp),%edx
  800d50:	88 10                	mov    %dl,(%eax)
}
  800d52:	90                   	nop
  800d53:	5d                   	pop    %ebp
  800d54:	c3                   	ret    

00800d55 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800d55:	55                   	push   %ebp
  800d56:	89 e5                	mov    %esp,%ebp
  800d58:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800d5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800d61:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d64:	8d 50 ff             	lea    -0x1(%eax),%edx
  800d67:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6a:	01 d0                	add    %edx,%eax
  800d6c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800d6f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800d76:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800d7a:	74 06                	je     800d82 <vsnprintf+0x2d>
  800d7c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800d80:	7f 07                	jg     800d89 <vsnprintf+0x34>
		return -E_INVAL;
  800d82:	b8 03 00 00 00       	mov    $0x3,%eax
  800d87:	eb 20                	jmp    800da9 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800d89:	ff 75 14             	pushl  0x14(%ebp)
  800d8c:	ff 75 10             	pushl  0x10(%ebp)
  800d8f:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800d92:	50                   	push   %eax
  800d93:	68 1f 0d 80 00       	push   $0x800d1f
  800d98:	e8 92 fb ff ff       	call   80092f <vprintfmt>
  800d9d:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800da0:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800da3:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800da6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800da9:	c9                   	leave  
  800daa:	c3                   	ret    

00800dab <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800dab:	55                   	push   %ebp
  800dac:	89 e5                	mov    %esp,%ebp
  800dae:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800db1:	8d 45 10             	lea    0x10(%ebp),%eax
  800db4:	83 c0 04             	add    $0x4,%eax
  800db7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800dba:	8b 45 10             	mov    0x10(%ebp),%eax
  800dbd:	ff 75 f4             	pushl  -0xc(%ebp)
  800dc0:	50                   	push   %eax
  800dc1:	ff 75 0c             	pushl  0xc(%ebp)
  800dc4:	ff 75 08             	pushl  0x8(%ebp)
  800dc7:	e8 89 ff ff ff       	call   800d55 <vsnprintf>
  800dcc:	83 c4 10             	add    $0x10,%esp
  800dcf:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800dd2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800dd5:	c9                   	leave  
  800dd6:	c3                   	ret    

00800dd7 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800dd7:	55                   	push   %ebp
  800dd8:	89 e5                	mov    %esp,%ebp
  800dda:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800ddd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800de4:	eb 06                	jmp    800dec <strlen+0x15>
		n++;
  800de6:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800de9:	ff 45 08             	incl   0x8(%ebp)
  800dec:	8b 45 08             	mov    0x8(%ebp),%eax
  800def:	8a 00                	mov    (%eax),%al
  800df1:	84 c0                	test   %al,%al
  800df3:	75 f1                	jne    800de6 <strlen+0xf>
		n++;
	return n;
  800df5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800df8:	c9                   	leave  
  800df9:	c3                   	ret    

00800dfa <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800dfa:	55                   	push   %ebp
  800dfb:	89 e5                	mov    %esp,%ebp
  800dfd:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e00:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e07:	eb 09                	jmp    800e12 <strnlen+0x18>
		n++;
  800e09:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800e0c:	ff 45 08             	incl   0x8(%ebp)
  800e0f:	ff 4d 0c             	decl   0xc(%ebp)
  800e12:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e16:	74 09                	je     800e21 <strnlen+0x27>
  800e18:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1b:	8a 00                	mov    (%eax),%al
  800e1d:	84 c0                	test   %al,%al
  800e1f:	75 e8                	jne    800e09 <strnlen+0xf>
		n++;
	return n;
  800e21:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e24:	c9                   	leave  
  800e25:	c3                   	ret    

00800e26 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800e26:	55                   	push   %ebp
  800e27:	89 e5                	mov    %esp,%ebp
  800e29:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800e2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800e2f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800e32:	90                   	nop
  800e33:	8b 45 08             	mov    0x8(%ebp),%eax
  800e36:	8d 50 01             	lea    0x1(%eax),%edx
  800e39:	89 55 08             	mov    %edx,0x8(%ebp)
  800e3c:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e3f:	8d 4a 01             	lea    0x1(%edx),%ecx
  800e42:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800e45:	8a 12                	mov    (%edx),%dl
  800e47:	88 10                	mov    %dl,(%eax)
  800e49:	8a 00                	mov    (%eax),%al
  800e4b:	84 c0                	test   %al,%al
  800e4d:	75 e4                	jne    800e33 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800e4f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800e52:	c9                   	leave  
  800e53:	c3                   	ret    

00800e54 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800e54:	55                   	push   %ebp
  800e55:	89 e5                	mov    %esp,%ebp
  800e57:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800e5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800e60:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800e67:	eb 1f                	jmp    800e88 <strncpy+0x34>
		*dst++ = *src;
  800e69:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6c:	8d 50 01             	lea    0x1(%eax),%edx
  800e6f:	89 55 08             	mov    %edx,0x8(%ebp)
  800e72:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e75:	8a 12                	mov    (%edx),%dl
  800e77:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800e79:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e7c:	8a 00                	mov    (%eax),%al
  800e7e:	84 c0                	test   %al,%al
  800e80:	74 03                	je     800e85 <strncpy+0x31>
			src++;
  800e82:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800e85:	ff 45 fc             	incl   -0x4(%ebp)
  800e88:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e8b:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e8e:	72 d9                	jb     800e69 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800e90:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e93:	c9                   	leave  
  800e94:	c3                   	ret    

00800e95 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800e95:	55                   	push   %ebp
  800e96:	89 e5                	mov    %esp,%ebp
  800e98:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800e9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e9e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800ea1:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ea5:	74 30                	je     800ed7 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800ea7:	eb 16                	jmp    800ebf <strlcpy+0x2a>
			*dst++ = *src++;
  800ea9:	8b 45 08             	mov    0x8(%ebp),%eax
  800eac:	8d 50 01             	lea    0x1(%eax),%edx
  800eaf:	89 55 08             	mov    %edx,0x8(%ebp)
  800eb2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800eb5:	8d 4a 01             	lea    0x1(%edx),%ecx
  800eb8:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ebb:	8a 12                	mov    (%edx),%dl
  800ebd:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800ebf:	ff 4d 10             	decl   0x10(%ebp)
  800ec2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800ec6:	74 09                	je     800ed1 <strlcpy+0x3c>
  800ec8:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ecb:	8a 00                	mov    (%eax),%al
  800ecd:	84 c0                	test   %al,%al
  800ecf:	75 d8                	jne    800ea9 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800ed1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ed4:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800ed7:	8b 55 08             	mov    0x8(%ebp),%edx
  800eda:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800edd:	29 c2                	sub    %eax,%edx
  800edf:	89 d0                	mov    %edx,%eax
}
  800ee1:	c9                   	leave  
  800ee2:	c3                   	ret    

00800ee3 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ee3:	55                   	push   %ebp
  800ee4:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ee6:	eb 06                	jmp    800eee <strcmp+0xb>
		p++, q++;
  800ee8:	ff 45 08             	incl   0x8(%ebp)
  800eeb:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800eee:	8b 45 08             	mov    0x8(%ebp),%eax
  800ef1:	8a 00                	mov    (%eax),%al
  800ef3:	84 c0                	test   %al,%al
  800ef5:	74 0e                	je     800f05 <strcmp+0x22>
  800ef7:	8b 45 08             	mov    0x8(%ebp),%eax
  800efa:	8a 10                	mov    (%eax),%dl
  800efc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800eff:	8a 00                	mov    (%eax),%al
  800f01:	38 c2                	cmp    %al,%dl
  800f03:	74 e3                	je     800ee8 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800f05:	8b 45 08             	mov    0x8(%ebp),%eax
  800f08:	8a 00                	mov    (%eax),%al
  800f0a:	0f b6 d0             	movzbl %al,%edx
  800f0d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f10:	8a 00                	mov    (%eax),%al
  800f12:	0f b6 c0             	movzbl %al,%eax
  800f15:	29 c2                	sub    %eax,%edx
  800f17:	89 d0                	mov    %edx,%eax
}
  800f19:	5d                   	pop    %ebp
  800f1a:	c3                   	ret    

00800f1b <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800f1b:	55                   	push   %ebp
  800f1c:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800f1e:	eb 09                	jmp    800f29 <strncmp+0xe>
		n--, p++, q++;
  800f20:	ff 4d 10             	decl   0x10(%ebp)
  800f23:	ff 45 08             	incl   0x8(%ebp)
  800f26:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800f29:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f2d:	74 17                	je     800f46 <strncmp+0x2b>
  800f2f:	8b 45 08             	mov    0x8(%ebp),%eax
  800f32:	8a 00                	mov    (%eax),%al
  800f34:	84 c0                	test   %al,%al
  800f36:	74 0e                	je     800f46 <strncmp+0x2b>
  800f38:	8b 45 08             	mov    0x8(%ebp),%eax
  800f3b:	8a 10                	mov    (%eax),%dl
  800f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f40:	8a 00                	mov    (%eax),%al
  800f42:	38 c2                	cmp    %al,%dl
  800f44:	74 da                	je     800f20 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800f46:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800f4a:	75 07                	jne    800f53 <strncmp+0x38>
		return 0;
  800f4c:	b8 00 00 00 00       	mov    $0x0,%eax
  800f51:	eb 14                	jmp    800f67 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800f53:	8b 45 08             	mov    0x8(%ebp),%eax
  800f56:	8a 00                	mov    (%eax),%al
  800f58:	0f b6 d0             	movzbl %al,%edx
  800f5b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f5e:	8a 00                	mov    (%eax),%al
  800f60:	0f b6 c0             	movzbl %al,%eax
  800f63:	29 c2                	sub    %eax,%edx
  800f65:	89 d0                	mov    %edx,%eax
}
  800f67:	5d                   	pop    %ebp
  800f68:	c3                   	ret    

00800f69 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800f69:	55                   	push   %ebp
  800f6a:	89 e5                	mov    %esp,%ebp
  800f6c:	83 ec 04             	sub    $0x4,%esp
  800f6f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f72:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800f75:	eb 12                	jmp    800f89 <strchr+0x20>
		if (*s == c)
  800f77:	8b 45 08             	mov    0x8(%ebp),%eax
  800f7a:	8a 00                	mov    (%eax),%al
  800f7c:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800f7f:	75 05                	jne    800f86 <strchr+0x1d>
			return (char *) s;
  800f81:	8b 45 08             	mov    0x8(%ebp),%eax
  800f84:	eb 11                	jmp    800f97 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800f86:	ff 45 08             	incl   0x8(%ebp)
  800f89:	8b 45 08             	mov    0x8(%ebp),%eax
  800f8c:	8a 00                	mov    (%eax),%al
  800f8e:	84 c0                	test   %al,%al
  800f90:	75 e5                	jne    800f77 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800f92:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800f97:	c9                   	leave  
  800f98:	c3                   	ret    

00800f99 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800f99:	55                   	push   %ebp
  800f9a:	89 e5                	mov    %esp,%ebp
  800f9c:	83 ec 04             	sub    $0x4,%esp
  800f9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fa2:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800fa5:	eb 0d                	jmp    800fb4 <strfind+0x1b>
		if (*s == c)
  800fa7:	8b 45 08             	mov    0x8(%ebp),%eax
  800faa:	8a 00                	mov    (%eax),%al
  800fac:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800faf:	74 0e                	je     800fbf <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800fb1:	ff 45 08             	incl   0x8(%ebp)
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	8a 00                	mov    (%eax),%al
  800fb9:	84 c0                	test   %al,%al
  800fbb:	75 ea                	jne    800fa7 <strfind+0xe>
  800fbd:	eb 01                	jmp    800fc0 <strfind+0x27>
		if (*s == c)
			break;
  800fbf:	90                   	nop
	return (char *) s;
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fc3:	c9                   	leave  
  800fc4:	c3                   	ret    

00800fc5 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800fc5:	55                   	push   %ebp
  800fc6:	89 e5                	mov    %esp,%ebp
  800fc8:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fce:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800fd1:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800fd7:	eb 0e                	jmp    800fe7 <memset+0x22>
		*p++ = c;
  800fd9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fdc:	8d 50 01             	lea    0x1(%eax),%edx
  800fdf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fe2:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fe5:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800fe7:	ff 4d f8             	decl   -0x8(%ebp)
  800fea:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800fee:	79 e9                	jns    800fd9 <memset+0x14>
		*p++ = c;

	return v;
  800ff0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ff3:	c9                   	leave  
  800ff4:	c3                   	ret    

00800ff5 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800ff5:	55                   	push   %ebp
  800ff6:	89 e5                	mov    %esp,%ebp
  800ff8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800ffb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ffe:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801001:	8b 45 08             	mov    0x8(%ebp),%eax
  801004:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801007:	eb 16                	jmp    80101f <memcpy+0x2a>
		*d++ = *s++;
  801009:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80100c:	8d 50 01             	lea    0x1(%eax),%edx
  80100f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801012:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801015:	8d 4a 01             	lea    0x1(%edx),%ecx
  801018:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  80101b:	8a 12                	mov    (%edx),%dl
  80101d:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  80101f:	8b 45 10             	mov    0x10(%ebp),%eax
  801022:	8d 50 ff             	lea    -0x1(%eax),%edx
  801025:	89 55 10             	mov    %edx,0x10(%ebp)
  801028:	85 c0                	test   %eax,%eax
  80102a:	75 dd                	jne    801009 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  80102c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80102f:	c9                   	leave  
  801030:	c3                   	ret    

00801031 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  801031:	55                   	push   %ebp
  801032:	89 e5                	mov    %esp,%ebp
  801034:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801037:	8b 45 0c             	mov    0xc(%ebp),%eax
  80103a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80103d:	8b 45 08             	mov    0x8(%ebp),%eax
  801040:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  801043:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801046:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801049:	73 50                	jae    80109b <memmove+0x6a>
  80104b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80104e:	8b 45 10             	mov    0x10(%ebp),%eax
  801051:	01 d0                	add    %edx,%eax
  801053:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  801056:	76 43                	jbe    80109b <memmove+0x6a>
		s += n;
  801058:	8b 45 10             	mov    0x10(%ebp),%eax
  80105b:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  80105e:	8b 45 10             	mov    0x10(%ebp),%eax
  801061:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  801064:	eb 10                	jmp    801076 <memmove+0x45>
			*--d = *--s;
  801066:	ff 4d f8             	decl   -0x8(%ebp)
  801069:	ff 4d fc             	decl   -0x4(%ebp)
  80106c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80106f:	8a 10                	mov    (%eax),%dl
  801071:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801074:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  801076:	8b 45 10             	mov    0x10(%ebp),%eax
  801079:	8d 50 ff             	lea    -0x1(%eax),%edx
  80107c:	89 55 10             	mov    %edx,0x10(%ebp)
  80107f:	85 c0                	test   %eax,%eax
  801081:	75 e3                	jne    801066 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  801083:	eb 23                	jmp    8010a8 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  801085:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801088:	8d 50 01             	lea    0x1(%eax),%edx
  80108b:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80108e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801091:	8d 4a 01             	lea    0x1(%edx),%ecx
  801094:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801097:	8a 12                	mov    (%edx),%dl
  801099:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  80109b:	8b 45 10             	mov    0x10(%ebp),%eax
  80109e:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010a1:	89 55 10             	mov    %edx,0x10(%ebp)
  8010a4:	85 c0                	test   %eax,%eax
  8010a6:	75 dd                	jne    801085 <memmove+0x54>
			*d++ = *s++;

	return dst;
  8010a8:	8b 45 08             	mov    0x8(%ebp),%eax
}
  8010ab:	c9                   	leave  
  8010ac:	c3                   	ret    

008010ad <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  8010ad:	55                   	push   %ebp
  8010ae:	89 e5                	mov    %esp,%ebp
  8010b0:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  8010b9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010bc:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  8010bf:	eb 2a                	jmp    8010eb <memcmp+0x3e>
		if (*s1 != *s2)
  8010c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010c4:	8a 10                	mov    (%eax),%dl
  8010c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010c9:	8a 00                	mov    (%eax),%al
  8010cb:	38 c2                	cmp    %al,%dl
  8010cd:	74 16                	je     8010e5 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  8010cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010d2:	8a 00                	mov    (%eax),%al
  8010d4:	0f b6 d0             	movzbl %al,%edx
  8010d7:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010da:	8a 00                	mov    (%eax),%al
  8010dc:	0f b6 c0             	movzbl %al,%eax
  8010df:	29 c2                	sub    %eax,%edx
  8010e1:	89 d0                	mov    %edx,%eax
  8010e3:	eb 18                	jmp    8010fd <memcmp+0x50>
		s1++, s2++;
  8010e5:	ff 45 fc             	incl   -0x4(%ebp)
  8010e8:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  8010eb:	8b 45 10             	mov    0x10(%ebp),%eax
  8010ee:	8d 50 ff             	lea    -0x1(%eax),%edx
  8010f1:	89 55 10             	mov    %edx,0x10(%ebp)
  8010f4:	85 c0                	test   %eax,%eax
  8010f6:	75 c9                	jne    8010c1 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  8010f8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8010fd:	c9                   	leave  
  8010fe:	c3                   	ret    

008010ff <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  8010ff:	55                   	push   %ebp
  801100:	89 e5                	mov    %esp,%ebp
  801102:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  801105:	8b 55 08             	mov    0x8(%ebp),%edx
  801108:	8b 45 10             	mov    0x10(%ebp),%eax
  80110b:	01 d0                	add    %edx,%eax
  80110d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801110:	eb 15                	jmp    801127 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  801112:	8b 45 08             	mov    0x8(%ebp),%eax
  801115:	8a 00                	mov    (%eax),%al
  801117:	0f b6 d0             	movzbl %al,%edx
  80111a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80111d:	0f b6 c0             	movzbl %al,%eax
  801120:	39 c2                	cmp    %eax,%edx
  801122:	74 0d                	je     801131 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  801124:	ff 45 08             	incl   0x8(%ebp)
  801127:	8b 45 08             	mov    0x8(%ebp),%eax
  80112a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  80112d:	72 e3                	jb     801112 <memfind+0x13>
  80112f:	eb 01                	jmp    801132 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  801131:	90                   	nop
	return (void *) s;
  801132:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801135:	c9                   	leave  
  801136:	c3                   	ret    

00801137 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801137:	55                   	push   %ebp
  801138:	89 e5                	mov    %esp,%ebp
  80113a:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  80113d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  801144:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  80114b:	eb 03                	jmp    801150 <strtol+0x19>
		s++;
  80114d:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	8a 00                	mov    (%eax),%al
  801155:	3c 20                	cmp    $0x20,%al
  801157:	74 f4                	je     80114d <strtol+0x16>
  801159:	8b 45 08             	mov    0x8(%ebp),%eax
  80115c:	8a 00                	mov    (%eax),%al
  80115e:	3c 09                	cmp    $0x9,%al
  801160:	74 eb                	je     80114d <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801162:	8b 45 08             	mov    0x8(%ebp),%eax
  801165:	8a 00                	mov    (%eax),%al
  801167:	3c 2b                	cmp    $0x2b,%al
  801169:	75 05                	jne    801170 <strtol+0x39>
		s++;
  80116b:	ff 45 08             	incl   0x8(%ebp)
  80116e:	eb 13                	jmp    801183 <strtol+0x4c>
	else if (*s == '-')
  801170:	8b 45 08             	mov    0x8(%ebp),%eax
  801173:	8a 00                	mov    (%eax),%al
  801175:	3c 2d                	cmp    $0x2d,%al
  801177:	75 0a                	jne    801183 <strtol+0x4c>
		s++, neg = 1;
  801179:	ff 45 08             	incl   0x8(%ebp)
  80117c:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801183:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801187:	74 06                	je     80118f <strtol+0x58>
  801189:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  80118d:	75 20                	jne    8011af <strtol+0x78>
  80118f:	8b 45 08             	mov    0x8(%ebp),%eax
  801192:	8a 00                	mov    (%eax),%al
  801194:	3c 30                	cmp    $0x30,%al
  801196:	75 17                	jne    8011af <strtol+0x78>
  801198:	8b 45 08             	mov    0x8(%ebp),%eax
  80119b:	40                   	inc    %eax
  80119c:	8a 00                	mov    (%eax),%al
  80119e:	3c 78                	cmp    $0x78,%al
  8011a0:	75 0d                	jne    8011af <strtol+0x78>
		s += 2, base = 16;
  8011a2:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8011a6:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  8011ad:	eb 28                	jmp    8011d7 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  8011af:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011b3:	75 15                	jne    8011ca <strtol+0x93>
  8011b5:	8b 45 08             	mov    0x8(%ebp),%eax
  8011b8:	8a 00                	mov    (%eax),%al
  8011ba:	3c 30                	cmp    $0x30,%al
  8011bc:	75 0c                	jne    8011ca <strtol+0x93>
		s++, base = 8;
  8011be:	ff 45 08             	incl   0x8(%ebp)
  8011c1:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  8011c8:	eb 0d                	jmp    8011d7 <strtol+0xa0>
	else if (base == 0)
  8011ca:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011ce:	75 07                	jne    8011d7 <strtol+0xa0>
		base = 10;
  8011d0:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  8011d7:	8b 45 08             	mov    0x8(%ebp),%eax
  8011da:	8a 00                	mov    (%eax),%al
  8011dc:	3c 2f                	cmp    $0x2f,%al
  8011de:	7e 19                	jle    8011f9 <strtol+0xc2>
  8011e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e3:	8a 00                	mov    (%eax),%al
  8011e5:	3c 39                	cmp    $0x39,%al
  8011e7:	7f 10                	jg     8011f9 <strtol+0xc2>
			dig = *s - '0';
  8011e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	0f be c0             	movsbl %al,%eax
  8011f1:	83 e8 30             	sub    $0x30,%eax
  8011f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8011f7:	eb 42                	jmp    80123b <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  8011f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8011fc:	8a 00                	mov    (%eax),%al
  8011fe:	3c 60                	cmp    $0x60,%al
  801200:	7e 19                	jle    80121b <strtol+0xe4>
  801202:	8b 45 08             	mov    0x8(%ebp),%eax
  801205:	8a 00                	mov    (%eax),%al
  801207:	3c 7a                	cmp    $0x7a,%al
  801209:	7f 10                	jg     80121b <strtol+0xe4>
			dig = *s - 'a' + 10;
  80120b:	8b 45 08             	mov    0x8(%ebp),%eax
  80120e:	8a 00                	mov    (%eax),%al
  801210:	0f be c0             	movsbl %al,%eax
  801213:	83 e8 57             	sub    $0x57,%eax
  801216:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801219:	eb 20                	jmp    80123b <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  80121b:	8b 45 08             	mov    0x8(%ebp),%eax
  80121e:	8a 00                	mov    (%eax),%al
  801220:	3c 40                	cmp    $0x40,%al
  801222:	7e 39                	jle    80125d <strtol+0x126>
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	8a 00                	mov    (%eax),%al
  801229:	3c 5a                	cmp    $0x5a,%al
  80122b:	7f 30                	jg     80125d <strtol+0x126>
			dig = *s - 'A' + 10;
  80122d:	8b 45 08             	mov    0x8(%ebp),%eax
  801230:	8a 00                	mov    (%eax),%al
  801232:	0f be c0             	movsbl %al,%eax
  801235:	83 e8 37             	sub    $0x37,%eax
  801238:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  80123b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80123e:	3b 45 10             	cmp    0x10(%ebp),%eax
  801241:	7d 19                	jge    80125c <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  801243:	ff 45 08             	incl   0x8(%ebp)
  801246:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801249:	0f af 45 10          	imul   0x10(%ebp),%eax
  80124d:	89 c2                	mov    %eax,%edx
  80124f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801252:	01 d0                	add    %edx,%eax
  801254:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  801257:	e9 7b ff ff ff       	jmp    8011d7 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  80125c:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  80125d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801261:	74 08                	je     80126b <strtol+0x134>
		*endptr = (char *) s;
  801263:	8b 45 0c             	mov    0xc(%ebp),%eax
  801266:	8b 55 08             	mov    0x8(%ebp),%edx
  801269:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80126b:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  80126f:	74 07                	je     801278 <strtol+0x141>
  801271:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801274:	f7 d8                	neg    %eax
  801276:	eb 03                	jmp    80127b <strtol+0x144>
  801278:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80127b:	c9                   	leave  
  80127c:	c3                   	ret    

0080127d <ltostr>:

void
ltostr(long value, char *str)
{
  80127d:	55                   	push   %ebp
  80127e:	89 e5                	mov    %esp,%ebp
  801280:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801283:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80128a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801291:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801295:	79 13                	jns    8012aa <ltostr+0x2d>
	{
		neg = 1;
  801297:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  80129e:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012a1:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8012a4:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  8012a7:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  8012aa:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ad:	b9 0a 00 00 00       	mov    $0xa,%ecx
  8012b2:	99                   	cltd   
  8012b3:	f7 f9                	idiv   %ecx
  8012b5:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  8012b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012bb:	8d 50 01             	lea    0x1(%eax),%edx
  8012be:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012c1:	89 c2                	mov    %eax,%edx
  8012c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8012c6:	01 d0                	add    %edx,%eax
  8012c8:	8b 55 ec             	mov    -0x14(%ebp),%edx
  8012cb:	83 c2 30             	add    $0x30,%edx
  8012ce:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  8012d0:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012d3:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012d8:	f7 e9                	imul   %ecx
  8012da:	c1 fa 02             	sar    $0x2,%edx
  8012dd:	89 c8                	mov    %ecx,%eax
  8012df:	c1 f8 1f             	sar    $0x1f,%eax
  8012e2:	29 c2                	sub    %eax,%edx
  8012e4:	89 d0                	mov    %edx,%eax
  8012e6:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  8012e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8012ec:	b8 67 66 66 66       	mov    $0x66666667,%eax
  8012f1:	f7 e9                	imul   %ecx
  8012f3:	c1 fa 02             	sar    $0x2,%edx
  8012f6:	89 c8                	mov    %ecx,%eax
  8012f8:	c1 f8 1f             	sar    $0x1f,%eax
  8012fb:	29 c2                	sub    %eax,%edx
  8012fd:	89 d0                	mov    %edx,%eax
  8012ff:	c1 e0 02             	shl    $0x2,%eax
  801302:	01 d0                	add    %edx,%eax
  801304:	01 c0                	add    %eax,%eax
  801306:	29 c1                	sub    %eax,%ecx
  801308:	89 ca                	mov    %ecx,%edx
  80130a:	85 d2                	test   %edx,%edx
  80130c:	75 9c                	jne    8012aa <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  80130e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  801315:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801318:	48                   	dec    %eax
  801319:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  80131c:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801320:	74 3d                	je     80135f <ltostr+0xe2>
		start = 1 ;
  801322:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801329:	eb 34                	jmp    80135f <ltostr+0xe2>
	{
		char tmp = str[start] ;
  80132b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80132e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801331:	01 d0                	add    %edx,%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801338:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80133b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80133e:	01 c2                	add    %eax,%edx
  801340:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  801343:	8b 45 0c             	mov    0xc(%ebp),%eax
  801346:	01 c8                	add    %ecx,%eax
  801348:	8a 00                	mov    (%eax),%al
  80134a:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  80134c:	8b 55 f0             	mov    -0x10(%ebp),%edx
  80134f:	8b 45 0c             	mov    0xc(%ebp),%eax
  801352:	01 c2                	add    %eax,%edx
  801354:	8a 45 eb             	mov    -0x15(%ebp),%al
  801357:	88 02                	mov    %al,(%edx)
		start++ ;
  801359:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  80135c:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  80135f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801362:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801365:	7c c4                	jl     80132b <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  801367:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80136a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80136d:	01 d0                	add    %edx,%eax
  80136f:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801372:	90                   	nop
  801373:	c9                   	leave  
  801374:	c3                   	ret    

00801375 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801375:	55                   	push   %ebp
  801376:	89 e5                	mov    %esp,%ebp
  801378:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80137b:	ff 75 08             	pushl  0x8(%ebp)
  80137e:	e8 54 fa ff ff       	call   800dd7 <strlen>
  801383:	83 c4 04             	add    $0x4,%esp
  801386:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  801389:	ff 75 0c             	pushl  0xc(%ebp)
  80138c:	e8 46 fa ff ff       	call   800dd7 <strlen>
  801391:	83 c4 04             	add    $0x4,%esp
  801394:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  801397:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  80139e:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8013a5:	eb 17                	jmp    8013be <strcconcat+0x49>
		final[s] = str1[s] ;
  8013a7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8013aa:	8b 45 10             	mov    0x10(%ebp),%eax
  8013ad:	01 c2                	add    %eax,%edx
  8013af:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	01 c8                	add    %ecx,%eax
  8013b7:	8a 00                	mov    (%eax),%al
  8013b9:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  8013bb:	ff 45 fc             	incl   -0x4(%ebp)
  8013be:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013c1:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  8013c4:	7c e1                	jl     8013a7 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  8013c6:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  8013cd:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  8013d4:	eb 1f                	jmp    8013f5 <strcconcat+0x80>
		final[s++] = str2[i] ;
  8013d6:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8013d9:	8d 50 01             	lea    0x1(%eax),%edx
  8013dc:	89 55 fc             	mov    %edx,-0x4(%ebp)
  8013df:	89 c2                	mov    %eax,%edx
  8013e1:	8b 45 10             	mov    0x10(%ebp),%eax
  8013e4:	01 c2                	add    %eax,%edx
  8013e6:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  8013e9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8013ec:	01 c8                	add    %ecx,%eax
  8013ee:	8a 00                	mov    (%eax),%al
  8013f0:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  8013f2:	ff 45 f8             	incl   -0x8(%ebp)
  8013f5:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8013f8:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8013fb:	7c d9                	jl     8013d6 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8013fd:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801400:	8b 45 10             	mov    0x10(%ebp),%eax
  801403:	01 d0                	add    %edx,%eax
  801405:	c6 00 00             	movb   $0x0,(%eax)
}
  801408:	90                   	nop
  801409:	c9                   	leave  
  80140a:	c3                   	ret    

0080140b <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  80140b:	55                   	push   %ebp
  80140c:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  80140e:	8b 45 14             	mov    0x14(%ebp),%eax
  801411:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801417:	8b 45 14             	mov    0x14(%ebp),%eax
  80141a:	8b 00                	mov    (%eax),%eax
  80141c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801423:	8b 45 10             	mov    0x10(%ebp),%eax
  801426:	01 d0                	add    %edx,%eax
  801428:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80142e:	eb 0c                	jmp    80143c <strsplit+0x31>
			*string++ = 0;
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	8d 50 01             	lea    0x1(%eax),%edx
  801436:	89 55 08             	mov    %edx,0x8(%ebp)
  801439:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80143c:	8b 45 08             	mov    0x8(%ebp),%eax
  80143f:	8a 00                	mov    (%eax),%al
  801441:	84 c0                	test   %al,%al
  801443:	74 18                	je     80145d <strsplit+0x52>
  801445:	8b 45 08             	mov    0x8(%ebp),%eax
  801448:	8a 00                	mov    (%eax),%al
  80144a:	0f be c0             	movsbl %al,%eax
  80144d:	50                   	push   %eax
  80144e:	ff 75 0c             	pushl  0xc(%ebp)
  801451:	e8 13 fb ff ff       	call   800f69 <strchr>
  801456:	83 c4 08             	add    $0x8,%esp
  801459:	85 c0                	test   %eax,%eax
  80145b:	75 d3                	jne    801430 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  80145d:	8b 45 08             	mov    0x8(%ebp),%eax
  801460:	8a 00                	mov    (%eax),%al
  801462:	84 c0                	test   %al,%al
  801464:	74 5a                	je     8014c0 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801466:	8b 45 14             	mov    0x14(%ebp),%eax
  801469:	8b 00                	mov    (%eax),%eax
  80146b:	83 f8 0f             	cmp    $0xf,%eax
  80146e:	75 07                	jne    801477 <strsplit+0x6c>
		{
			return 0;
  801470:	b8 00 00 00 00       	mov    $0x0,%eax
  801475:	eb 66                	jmp    8014dd <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  801477:	8b 45 14             	mov    0x14(%ebp),%eax
  80147a:	8b 00                	mov    (%eax),%eax
  80147c:	8d 48 01             	lea    0x1(%eax),%ecx
  80147f:	8b 55 14             	mov    0x14(%ebp),%edx
  801482:	89 0a                	mov    %ecx,(%edx)
  801484:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80148b:	8b 45 10             	mov    0x10(%ebp),%eax
  80148e:	01 c2                	add    %eax,%edx
  801490:	8b 45 08             	mov    0x8(%ebp),%eax
  801493:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801495:	eb 03                	jmp    80149a <strsplit+0x8f>
			string++;
  801497:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80149a:	8b 45 08             	mov    0x8(%ebp),%eax
  80149d:	8a 00                	mov    (%eax),%al
  80149f:	84 c0                	test   %al,%al
  8014a1:	74 8b                	je     80142e <strsplit+0x23>
  8014a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014a6:	8a 00                	mov    (%eax),%al
  8014a8:	0f be c0             	movsbl %al,%eax
  8014ab:	50                   	push   %eax
  8014ac:	ff 75 0c             	pushl  0xc(%ebp)
  8014af:	e8 b5 fa ff ff       	call   800f69 <strchr>
  8014b4:	83 c4 08             	add    $0x8,%esp
  8014b7:	85 c0                	test   %eax,%eax
  8014b9:	74 dc                	je     801497 <strsplit+0x8c>
			string++;
	}
  8014bb:	e9 6e ff ff ff       	jmp    80142e <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  8014c0:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  8014c1:	8b 45 14             	mov    0x14(%ebp),%eax
  8014c4:	8b 00                	mov    (%eax),%eax
  8014c6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8014cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d0:	01 d0                	add    %edx,%eax
  8014d2:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8014d8:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8014dd:	c9                   	leave  
  8014de:	c3                   	ret    

008014df <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8014df:	55                   	push   %ebp
  8014e0:	89 e5                	mov    %esp,%ebp
  8014e2:	57                   	push   %edi
  8014e3:	56                   	push   %esi
  8014e4:	53                   	push   %ebx
  8014e5:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8014e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8014eb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014ee:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8014f1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8014f4:	8b 7d 18             	mov    0x18(%ebp),%edi
  8014f7:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8014fa:	cd 30                	int    $0x30
  8014fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8014ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801502:	83 c4 10             	add    $0x10,%esp
  801505:	5b                   	pop    %ebx
  801506:	5e                   	pop    %esi
  801507:	5f                   	pop    %edi
  801508:	5d                   	pop    %ebp
  801509:	c3                   	ret    

0080150a <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80150a:	55                   	push   %ebp
  80150b:	89 e5                	mov    %esp,%ebp
  80150d:	83 ec 04             	sub    $0x4,%esp
  801510:	8b 45 10             	mov    0x10(%ebp),%eax
  801513:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  801516:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  80151a:	8b 45 08             	mov    0x8(%ebp),%eax
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	52                   	push   %edx
  801522:	ff 75 0c             	pushl  0xc(%ebp)
  801525:	50                   	push   %eax
  801526:	6a 00                	push   $0x0
  801528:	e8 b2 ff ff ff       	call   8014df <syscall>
  80152d:	83 c4 18             	add    $0x18,%esp
}
  801530:	90                   	nop
  801531:	c9                   	leave  
  801532:	c3                   	ret    

00801533 <sys_cgetc>:

int
sys_cgetc(void)
{
  801533:	55                   	push   %ebp
  801534:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	6a 00                	push   $0x0
  80153e:	6a 00                	push   $0x0
  801540:	6a 01                	push   $0x1
  801542:	e8 98 ff ff ff       	call   8014df <syscall>
  801547:	83 c4 18             	add    $0x18,%esp
}
  80154a:	c9                   	leave  
  80154b:	c3                   	ret    

0080154c <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80154c:	55                   	push   %ebp
  80154d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  80154f:	8b 45 08             	mov    0x8(%ebp),%eax
  801552:	6a 00                	push   $0x0
  801554:	6a 00                	push   $0x0
  801556:	6a 00                	push   $0x0
  801558:	6a 00                	push   $0x0
  80155a:	50                   	push   %eax
  80155b:	6a 05                	push   $0x5
  80155d:	e8 7d ff ff ff       	call   8014df <syscall>
  801562:	83 c4 18             	add    $0x18,%esp
}
  801565:	c9                   	leave  
  801566:	c3                   	ret    

00801567 <sys_getenvid>:

int32 sys_getenvid(void)
{
  801567:	55                   	push   %ebp
  801568:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80156a:	6a 00                	push   $0x0
  80156c:	6a 00                	push   $0x0
  80156e:	6a 00                	push   $0x0
  801570:	6a 00                	push   $0x0
  801572:	6a 00                	push   $0x0
  801574:	6a 02                	push   $0x2
  801576:	e8 64 ff ff ff       	call   8014df <syscall>
  80157b:	83 c4 18             	add    $0x18,%esp
}
  80157e:	c9                   	leave  
  80157f:	c3                   	ret    

00801580 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801580:	55                   	push   %ebp
  801581:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801583:	6a 00                	push   $0x0
  801585:	6a 00                	push   $0x0
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 03                	push   $0x3
  80158f:	e8 4b ff ff ff       	call   8014df <syscall>
  801594:	83 c4 18             	add    $0x18,%esp
}
  801597:	c9                   	leave  
  801598:	c3                   	ret    

00801599 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  801599:	55                   	push   %ebp
  80159a:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80159c:	6a 00                	push   $0x0
  80159e:	6a 00                	push   $0x0
  8015a0:	6a 00                	push   $0x0
  8015a2:	6a 00                	push   $0x0
  8015a4:	6a 00                	push   $0x0
  8015a6:	6a 04                	push   $0x4
  8015a8:	e8 32 ff ff ff       	call   8014df <syscall>
  8015ad:	83 c4 18             	add    $0x18,%esp
}
  8015b0:	c9                   	leave  
  8015b1:	c3                   	ret    

008015b2 <sys_env_exit>:


void sys_env_exit(void)
{
  8015b2:	55                   	push   %ebp
  8015b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  8015b5:	6a 00                	push   $0x0
  8015b7:	6a 00                	push   $0x0
  8015b9:	6a 00                	push   $0x0
  8015bb:	6a 00                	push   $0x0
  8015bd:	6a 00                	push   $0x0
  8015bf:	6a 06                	push   $0x6
  8015c1:	e8 19 ff ff ff       	call   8014df <syscall>
  8015c6:	83 c4 18             	add    $0x18,%esp
}
  8015c9:	90                   	nop
  8015ca:	c9                   	leave  
  8015cb:	c3                   	ret    

008015cc <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  8015cc:	55                   	push   %ebp
  8015cd:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  8015cf:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015d2:	8b 45 08             	mov    0x8(%ebp),%eax
  8015d5:	6a 00                	push   $0x0
  8015d7:	6a 00                	push   $0x0
  8015d9:	6a 00                	push   $0x0
  8015db:	52                   	push   %edx
  8015dc:	50                   	push   %eax
  8015dd:	6a 07                	push   $0x7
  8015df:	e8 fb fe ff ff       	call   8014df <syscall>
  8015e4:	83 c4 18             	add    $0x18,%esp
}
  8015e7:	c9                   	leave  
  8015e8:	c3                   	ret    

008015e9 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8015e9:	55                   	push   %ebp
  8015ea:	89 e5                	mov    %esp,%ebp
  8015ec:	56                   	push   %esi
  8015ed:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8015ee:	8b 75 18             	mov    0x18(%ebp),%esi
  8015f1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8015f4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8015f7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015fa:	8b 45 08             	mov    0x8(%ebp),%eax
  8015fd:	56                   	push   %esi
  8015fe:	53                   	push   %ebx
  8015ff:	51                   	push   %ecx
  801600:	52                   	push   %edx
  801601:	50                   	push   %eax
  801602:	6a 08                	push   $0x8
  801604:	e8 d6 fe ff ff       	call   8014df <syscall>
  801609:	83 c4 18             	add    $0x18,%esp
}
  80160c:	8d 65 f8             	lea    -0x8(%ebp),%esp
  80160f:	5b                   	pop    %ebx
  801610:	5e                   	pop    %esi
  801611:	5d                   	pop    %ebp
  801612:	c3                   	ret    

00801613 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  801613:	55                   	push   %ebp
  801614:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  801616:	8b 55 0c             	mov    0xc(%ebp),%edx
  801619:	8b 45 08             	mov    0x8(%ebp),%eax
  80161c:	6a 00                	push   $0x0
  80161e:	6a 00                	push   $0x0
  801620:	6a 00                	push   $0x0
  801622:	52                   	push   %edx
  801623:	50                   	push   %eax
  801624:	6a 09                	push   $0x9
  801626:	e8 b4 fe ff ff       	call   8014df <syscall>
  80162b:	83 c4 18             	add    $0x18,%esp
}
  80162e:	c9                   	leave  
  80162f:	c3                   	ret    

00801630 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801630:	55                   	push   %ebp
  801631:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  801633:	6a 00                	push   $0x0
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	ff 75 0c             	pushl  0xc(%ebp)
  80163c:	ff 75 08             	pushl  0x8(%ebp)
  80163f:	6a 0a                	push   $0xa
  801641:	e8 99 fe ff ff       	call   8014df <syscall>
  801646:	83 c4 18             	add    $0x18,%esp
}
  801649:	c9                   	leave  
  80164a:	c3                   	ret    

0080164b <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 0b                	push   $0xb
  80165a:	e8 80 fe ff ff       	call   8014df <syscall>
  80165f:	83 c4 18             	add    $0x18,%esp
}
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 00                	push   $0x0
  801671:	6a 0c                	push   $0xc
  801673:	e8 67 fe ff ff       	call   8014df <syscall>
  801678:	83 c4 18             	add    $0x18,%esp
}
  80167b:	c9                   	leave  
  80167c:	c3                   	ret    

0080167d <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  80167d:	55                   	push   %ebp
  80167e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	6a 00                	push   $0x0
  801688:	6a 00                	push   $0x0
  80168a:	6a 0d                	push   $0xd
  80168c:	e8 4e fe ff ff       	call   8014df <syscall>
  801691:	83 c4 18             	add    $0x18,%esp
}
  801694:	c9                   	leave  
  801695:	c3                   	ret    

00801696 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801696:	55                   	push   %ebp
  801697:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  801699:	6a 00                	push   $0x0
  80169b:	6a 00                	push   $0x0
  80169d:	6a 00                	push   $0x0
  80169f:	ff 75 0c             	pushl  0xc(%ebp)
  8016a2:	ff 75 08             	pushl  0x8(%ebp)
  8016a5:	6a 11                	push   $0x11
  8016a7:	e8 33 fe ff ff       	call   8014df <syscall>
  8016ac:	83 c4 18             	add    $0x18,%esp
	return;
  8016af:	90                   	nop
}
  8016b0:	c9                   	leave  
  8016b1:	c3                   	ret    

008016b2 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  8016b2:	55                   	push   %ebp
  8016b3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  8016b5:	6a 00                	push   $0x0
  8016b7:	6a 00                	push   $0x0
  8016b9:	6a 00                	push   $0x0
  8016bb:	ff 75 0c             	pushl  0xc(%ebp)
  8016be:	ff 75 08             	pushl  0x8(%ebp)
  8016c1:	6a 12                	push   $0x12
  8016c3:	e8 17 fe ff ff       	call   8014df <syscall>
  8016c8:	83 c4 18             	add    $0x18,%esp
	return ;
  8016cb:	90                   	nop
}
  8016cc:	c9                   	leave  
  8016cd:	c3                   	ret    

008016ce <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  8016ce:	55                   	push   %ebp
  8016cf:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  8016d1:	6a 00                	push   $0x0
  8016d3:	6a 00                	push   $0x0
  8016d5:	6a 00                	push   $0x0
  8016d7:	6a 00                	push   $0x0
  8016d9:	6a 00                	push   $0x0
  8016db:	6a 0e                	push   $0xe
  8016dd:	e8 fd fd ff ff       	call   8014df <syscall>
  8016e2:	83 c4 18             	add    $0x18,%esp
}
  8016e5:	c9                   	leave  
  8016e6:	c3                   	ret    

008016e7 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8016e7:	55                   	push   %ebp
  8016e8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 00                	push   $0x0
  8016f0:	6a 00                	push   $0x0
  8016f2:	ff 75 08             	pushl  0x8(%ebp)
  8016f5:	6a 0f                	push   $0xf
  8016f7:	e8 e3 fd ff ff       	call   8014df <syscall>
  8016fc:	83 c4 18             	add    $0x18,%esp
}
  8016ff:	c9                   	leave  
  801700:	c3                   	ret    

00801701 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801701:	55                   	push   %ebp
  801702:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801704:	6a 00                	push   $0x0
  801706:	6a 00                	push   $0x0
  801708:	6a 00                	push   $0x0
  80170a:	6a 00                	push   $0x0
  80170c:	6a 00                	push   $0x0
  80170e:	6a 10                	push   $0x10
  801710:	e8 ca fd ff ff       	call   8014df <syscall>
  801715:	83 c4 18             	add    $0x18,%esp
}
  801718:	90                   	nop
  801719:	c9                   	leave  
  80171a:	c3                   	ret    

0080171b <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  80171b:	55                   	push   %ebp
  80171c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  80171e:	6a 00                	push   $0x0
  801720:	6a 00                	push   $0x0
  801722:	6a 00                	push   $0x0
  801724:	6a 00                	push   $0x0
  801726:	6a 00                	push   $0x0
  801728:	6a 14                	push   $0x14
  80172a:	e8 b0 fd ff ff       	call   8014df <syscall>
  80172f:	83 c4 18             	add    $0x18,%esp
}
  801732:	90                   	nop
  801733:	c9                   	leave  
  801734:	c3                   	ret    

00801735 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  801735:	55                   	push   %ebp
  801736:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801738:	6a 00                	push   $0x0
  80173a:	6a 00                	push   $0x0
  80173c:	6a 00                	push   $0x0
  80173e:	6a 00                	push   $0x0
  801740:	6a 00                	push   $0x0
  801742:	6a 15                	push   $0x15
  801744:	e8 96 fd ff ff       	call   8014df <syscall>
  801749:	83 c4 18             	add    $0x18,%esp
}
  80174c:	90                   	nop
  80174d:	c9                   	leave  
  80174e:	c3                   	ret    

0080174f <sys_cputc>:


void
sys_cputc(const char c)
{
  80174f:	55                   	push   %ebp
  801750:	89 e5                	mov    %esp,%ebp
  801752:	83 ec 04             	sub    $0x4,%esp
  801755:	8b 45 08             	mov    0x8(%ebp),%eax
  801758:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80175b:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  80175f:	6a 00                	push   $0x0
  801761:	6a 00                	push   $0x0
  801763:	6a 00                	push   $0x0
  801765:	6a 00                	push   $0x0
  801767:	50                   	push   %eax
  801768:	6a 16                	push   $0x16
  80176a:	e8 70 fd ff ff       	call   8014df <syscall>
  80176f:	83 c4 18             	add    $0x18,%esp
}
  801772:	90                   	nop
  801773:	c9                   	leave  
  801774:	c3                   	ret    

00801775 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801775:	55                   	push   %ebp
  801776:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  801778:	6a 00                	push   $0x0
  80177a:	6a 00                	push   $0x0
  80177c:	6a 00                	push   $0x0
  80177e:	6a 00                	push   $0x0
  801780:	6a 00                	push   $0x0
  801782:	6a 17                	push   $0x17
  801784:	e8 56 fd ff ff       	call   8014df <syscall>
  801789:	83 c4 18             	add    $0x18,%esp
}
  80178c:	90                   	nop
  80178d:	c9                   	leave  
  80178e:	c3                   	ret    

0080178f <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  80178f:	55                   	push   %ebp
  801790:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801792:	8b 45 08             	mov    0x8(%ebp),%eax
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 00                	push   $0x0
  80179b:	ff 75 0c             	pushl  0xc(%ebp)
  80179e:	50                   	push   %eax
  80179f:	6a 18                	push   $0x18
  8017a1:	e8 39 fd ff ff       	call   8014df <syscall>
  8017a6:	83 c4 18             	add    $0x18,%esp
}
  8017a9:	c9                   	leave  
  8017aa:	c3                   	ret    

008017ab <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  8017ab:	55                   	push   %ebp
  8017ac:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017b1:	8b 45 08             	mov    0x8(%ebp),%eax
  8017b4:	6a 00                	push   $0x0
  8017b6:	6a 00                	push   $0x0
  8017b8:	6a 00                	push   $0x0
  8017ba:	52                   	push   %edx
  8017bb:	50                   	push   %eax
  8017bc:	6a 1b                	push   $0x1b
  8017be:	e8 1c fd ff ff       	call   8014df <syscall>
  8017c3:	83 c4 18             	add    $0x18,%esp
}
  8017c6:	c9                   	leave  
  8017c7:	c3                   	ret    

008017c8 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017c8:	55                   	push   %ebp
  8017c9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8017d1:	6a 00                	push   $0x0
  8017d3:	6a 00                	push   $0x0
  8017d5:	6a 00                	push   $0x0
  8017d7:	52                   	push   %edx
  8017d8:	50                   	push   %eax
  8017d9:	6a 19                	push   $0x19
  8017db:	e8 ff fc ff ff       	call   8014df <syscall>
  8017e0:	83 c4 18             	add    $0x18,%esp
}
  8017e3:	90                   	nop
  8017e4:	c9                   	leave  
  8017e5:	c3                   	ret    

008017e6 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8017e6:	55                   	push   %ebp
  8017e7:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8017e9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ef:	6a 00                	push   $0x0
  8017f1:	6a 00                	push   $0x0
  8017f3:	6a 00                	push   $0x0
  8017f5:	52                   	push   %edx
  8017f6:	50                   	push   %eax
  8017f7:	6a 1a                	push   $0x1a
  8017f9:	e8 e1 fc ff ff       	call   8014df <syscall>
  8017fe:	83 c4 18             	add    $0x18,%esp
}
  801801:	90                   	nop
  801802:	c9                   	leave  
  801803:	c3                   	ret    

00801804 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801804:	55                   	push   %ebp
  801805:	89 e5                	mov    %esp,%ebp
  801807:	83 ec 04             	sub    $0x4,%esp
  80180a:	8b 45 10             	mov    0x10(%ebp),%eax
  80180d:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801810:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801813:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801817:	8b 45 08             	mov    0x8(%ebp),%eax
  80181a:	6a 00                	push   $0x0
  80181c:	51                   	push   %ecx
  80181d:	52                   	push   %edx
  80181e:	ff 75 0c             	pushl  0xc(%ebp)
  801821:	50                   	push   %eax
  801822:	6a 1c                	push   $0x1c
  801824:	e8 b6 fc ff ff       	call   8014df <syscall>
  801829:	83 c4 18             	add    $0x18,%esp
}
  80182c:	c9                   	leave  
  80182d:	c3                   	ret    

0080182e <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  80182e:	55                   	push   %ebp
  80182f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801831:	8b 55 0c             	mov    0xc(%ebp),%edx
  801834:	8b 45 08             	mov    0x8(%ebp),%eax
  801837:	6a 00                	push   $0x0
  801839:	6a 00                	push   $0x0
  80183b:	6a 00                	push   $0x0
  80183d:	52                   	push   %edx
  80183e:	50                   	push   %eax
  80183f:	6a 1d                	push   $0x1d
  801841:	e8 99 fc ff ff       	call   8014df <syscall>
  801846:	83 c4 18             	add    $0x18,%esp
}
  801849:	c9                   	leave  
  80184a:	c3                   	ret    

0080184b <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80184b:	55                   	push   %ebp
  80184c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  80184e:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801851:	8b 55 0c             	mov    0xc(%ebp),%edx
  801854:	8b 45 08             	mov    0x8(%ebp),%eax
  801857:	6a 00                	push   $0x0
  801859:	6a 00                	push   $0x0
  80185b:	51                   	push   %ecx
  80185c:	52                   	push   %edx
  80185d:	50                   	push   %eax
  80185e:	6a 1e                	push   $0x1e
  801860:	e8 7a fc ff ff       	call   8014df <syscall>
  801865:	83 c4 18             	add    $0x18,%esp
}
  801868:	c9                   	leave  
  801869:	c3                   	ret    

0080186a <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80186a:	55                   	push   %ebp
  80186b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  80186d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801870:	8b 45 08             	mov    0x8(%ebp),%eax
  801873:	6a 00                	push   $0x0
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	52                   	push   %edx
  80187a:	50                   	push   %eax
  80187b:	6a 1f                	push   $0x1f
  80187d:	e8 5d fc ff ff       	call   8014df <syscall>
  801882:	83 c4 18             	add    $0x18,%esp
}
  801885:	c9                   	leave  
  801886:	c3                   	ret    

00801887 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801887:	55                   	push   %ebp
  801888:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80188a:	6a 00                	push   $0x0
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	6a 00                	push   $0x0
  801894:	6a 20                	push   $0x20
  801896:	e8 44 fc ff ff       	call   8014df <syscall>
  80189b:	83 c4 18             	add    $0x18,%esp
}
  80189e:	c9                   	leave  
  80189f:	c3                   	ret    

008018a0 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  8018a0:	55                   	push   %ebp
  8018a1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  8018a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018a6:	6a 00                	push   $0x0
  8018a8:	ff 75 14             	pushl  0x14(%ebp)
  8018ab:	ff 75 10             	pushl  0x10(%ebp)
  8018ae:	ff 75 0c             	pushl  0xc(%ebp)
  8018b1:	50                   	push   %eax
  8018b2:	6a 21                	push   $0x21
  8018b4:	e8 26 fc ff ff       	call   8014df <syscall>
  8018b9:	83 c4 18             	add    $0x18,%esp
}
  8018bc:	c9                   	leave  
  8018bd:	c3                   	ret    

008018be <sys_run_env>:


void
sys_run_env(int32 envId)
{
  8018be:	55                   	push   %ebp
  8018bf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  8018c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 00                	push   $0x0
  8018cc:	50                   	push   %eax
  8018cd:	6a 22                	push   $0x22
  8018cf:	e8 0b fc ff ff       	call   8014df <syscall>
  8018d4:	83 c4 18             	add    $0x18,%esp
}
  8018d7:	90                   	nop
  8018d8:	c9                   	leave  
  8018d9:	c3                   	ret    

008018da <sys_free_env>:

void
sys_free_env(int32 envId)
{
  8018da:	55                   	push   %ebp
  8018db:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8018dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	50                   	push   %eax
  8018e9:	6a 23                	push   $0x23
  8018eb:	e8 ef fb ff ff       	call   8014df <syscall>
  8018f0:	83 c4 18             	add    $0x18,%esp
}
  8018f3:	90                   	nop
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
  8018f9:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8018fc:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8018ff:	8d 50 04             	lea    0x4(%eax),%edx
  801902:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801905:	6a 00                	push   $0x0
  801907:	6a 00                	push   $0x0
  801909:	6a 00                	push   $0x0
  80190b:	52                   	push   %edx
  80190c:	50                   	push   %eax
  80190d:	6a 24                	push   $0x24
  80190f:	e8 cb fb ff ff       	call   8014df <syscall>
  801914:	83 c4 18             	add    $0x18,%esp
	return result;
  801917:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80191a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80191d:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801920:	89 01                	mov    %eax,(%ecx)
  801922:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801925:	8b 45 08             	mov    0x8(%ebp),%eax
  801928:	c9                   	leave  
  801929:	c2 04 00             	ret    $0x4

0080192c <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  80192c:	55                   	push   %ebp
  80192d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  80192f:	6a 00                	push   $0x0
  801931:	6a 00                	push   $0x0
  801933:	ff 75 10             	pushl  0x10(%ebp)
  801936:	ff 75 0c             	pushl  0xc(%ebp)
  801939:	ff 75 08             	pushl  0x8(%ebp)
  80193c:	6a 13                	push   $0x13
  80193e:	e8 9c fb ff ff       	call   8014df <syscall>
  801943:	83 c4 18             	add    $0x18,%esp
	return ;
  801946:	90                   	nop
}
  801947:	c9                   	leave  
  801948:	c3                   	ret    

00801949 <sys_rcr2>:
uint32 sys_rcr2()
{
  801949:	55                   	push   %ebp
  80194a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80194c:	6a 00                	push   $0x0
  80194e:	6a 00                	push   $0x0
  801950:	6a 00                	push   $0x0
  801952:	6a 00                	push   $0x0
  801954:	6a 00                	push   $0x0
  801956:	6a 25                	push   $0x25
  801958:	e8 82 fb ff ff       	call   8014df <syscall>
  80195d:	83 c4 18             	add    $0x18,%esp
}
  801960:	c9                   	leave  
  801961:	c3                   	ret    

00801962 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801962:	55                   	push   %ebp
  801963:	89 e5                	mov    %esp,%ebp
  801965:	83 ec 04             	sub    $0x4,%esp
  801968:	8b 45 08             	mov    0x8(%ebp),%eax
  80196b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  80196e:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801972:	6a 00                	push   $0x0
  801974:	6a 00                	push   $0x0
  801976:	6a 00                	push   $0x0
  801978:	6a 00                	push   $0x0
  80197a:	50                   	push   %eax
  80197b:	6a 26                	push   $0x26
  80197d:	e8 5d fb ff ff       	call   8014df <syscall>
  801982:	83 c4 18             	add    $0x18,%esp
	return ;
  801985:	90                   	nop
}
  801986:	c9                   	leave  
  801987:	c3                   	ret    

00801988 <rsttst>:
void rsttst()
{
  801988:	55                   	push   %ebp
  801989:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80198b:	6a 00                	push   $0x0
  80198d:	6a 00                	push   $0x0
  80198f:	6a 00                	push   $0x0
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 28                	push   $0x28
  801997:	e8 43 fb ff ff       	call   8014df <syscall>
  80199c:	83 c4 18             	add    $0x18,%esp
	return ;
  80199f:	90                   	nop
}
  8019a0:	c9                   	leave  
  8019a1:	c3                   	ret    

008019a2 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  8019a2:	55                   	push   %ebp
  8019a3:	89 e5                	mov    %esp,%ebp
  8019a5:	83 ec 04             	sub    $0x4,%esp
  8019a8:	8b 45 14             	mov    0x14(%ebp),%eax
  8019ab:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  8019ae:	8b 55 18             	mov    0x18(%ebp),%edx
  8019b1:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019b5:	52                   	push   %edx
  8019b6:	50                   	push   %eax
  8019b7:	ff 75 10             	pushl  0x10(%ebp)
  8019ba:	ff 75 0c             	pushl  0xc(%ebp)
  8019bd:	ff 75 08             	pushl  0x8(%ebp)
  8019c0:	6a 27                	push   $0x27
  8019c2:	e8 18 fb ff ff       	call   8014df <syscall>
  8019c7:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ca:	90                   	nop
}
  8019cb:	c9                   	leave  
  8019cc:	c3                   	ret    

008019cd <chktst>:
void chktst(uint32 n)
{
  8019cd:	55                   	push   %ebp
  8019ce:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  8019d0:	6a 00                	push   $0x0
  8019d2:	6a 00                	push   $0x0
  8019d4:	6a 00                	push   $0x0
  8019d6:	6a 00                	push   $0x0
  8019d8:	ff 75 08             	pushl  0x8(%ebp)
  8019db:	6a 29                	push   $0x29
  8019dd:	e8 fd fa ff ff       	call   8014df <syscall>
  8019e2:	83 c4 18             	add    $0x18,%esp
	return ;
  8019e5:	90                   	nop
}
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <inctst>:

void inctst()
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8019eb:	6a 00                	push   $0x0
  8019ed:	6a 00                	push   $0x0
  8019ef:	6a 00                	push   $0x0
  8019f1:	6a 00                	push   $0x0
  8019f3:	6a 00                	push   $0x0
  8019f5:	6a 2a                	push   $0x2a
  8019f7:	e8 e3 fa ff ff       	call   8014df <syscall>
  8019fc:	83 c4 18             	add    $0x18,%esp
	return ;
  8019ff:	90                   	nop
}
  801a00:	c9                   	leave  
  801a01:	c3                   	ret    

00801a02 <gettst>:
uint32 gettst()
{
  801a02:	55                   	push   %ebp
  801a03:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801a05:	6a 00                	push   $0x0
  801a07:	6a 00                	push   $0x0
  801a09:	6a 00                	push   $0x0
  801a0b:	6a 00                	push   $0x0
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 2b                	push   $0x2b
  801a11:	e8 c9 fa ff ff       	call   8014df <syscall>
  801a16:	83 c4 18             	add    $0x18,%esp
}
  801a19:	c9                   	leave  
  801a1a:	c3                   	ret    

00801a1b <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801a1b:	55                   	push   %ebp
  801a1c:	89 e5                	mov    %esp,%ebp
  801a1e:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a21:	6a 00                	push   $0x0
  801a23:	6a 00                	push   $0x0
  801a25:	6a 00                	push   $0x0
  801a27:	6a 00                	push   $0x0
  801a29:	6a 00                	push   $0x0
  801a2b:	6a 2c                	push   $0x2c
  801a2d:	e8 ad fa ff ff       	call   8014df <syscall>
  801a32:	83 c4 18             	add    $0x18,%esp
  801a35:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801a38:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801a3c:	75 07                	jne    801a45 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801a3e:	b8 01 00 00 00       	mov    $0x1,%eax
  801a43:	eb 05                	jmp    801a4a <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801a45:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a4a:	c9                   	leave  
  801a4b:	c3                   	ret    

00801a4c <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801a4c:	55                   	push   %ebp
  801a4d:	89 e5                	mov    %esp,%ebp
  801a4f:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a52:	6a 00                	push   $0x0
  801a54:	6a 00                	push   $0x0
  801a56:	6a 00                	push   $0x0
  801a58:	6a 00                	push   $0x0
  801a5a:	6a 00                	push   $0x0
  801a5c:	6a 2c                	push   $0x2c
  801a5e:	e8 7c fa ff ff       	call   8014df <syscall>
  801a63:	83 c4 18             	add    $0x18,%esp
  801a66:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801a69:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a6d:	75 07                	jne    801a76 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a6f:	b8 01 00 00 00       	mov    $0x1,%eax
  801a74:	eb 05                	jmp    801a7b <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a76:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a7b:	c9                   	leave  
  801a7c:	c3                   	ret    

00801a7d <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a7d:	55                   	push   %ebp
  801a7e:	89 e5                	mov    %esp,%ebp
  801a80:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a83:	6a 00                	push   $0x0
  801a85:	6a 00                	push   $0x0
  801a87:	6a 00                	push   $0x0
  801a89:	6a 00                	push   $0x0
  801a8b:	6a 00                	push   $0x0
  801a8d:	6a 2c                	push   $0x2c
  801a8f:	e8 4b fa ff ff       	call   8014df <syscall>
  801a94:	83 c4 18             	add    $0x18,%esp
  801a97:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a9a:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a9e:	75 07                	jne    801aa7 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801aa0:	b8 01 00 00 00       	mov    $0x1,%eax
  801aa5:	eb 05                	jmp    801aac <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801aa7:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801aac:	c9                   	leave  
  801aad:	c3                   	ret    

00801aae <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801aae:	55                   	push   %ebp
  801aaf:	89 e5                	mov    %esp,%ebp
  801ab1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801ab4:	6a 00                	push   $0x0
  801ab6:	6a 00                	push   $0x0
  801ab8:	6a 00                	push   $0x0
  801aba:	6a 00                	push   $0x0
  801abc:	6a 00                	push   $0x0
  801abe:	6a 2c                	push   $0x2c
  801ac0:	e8 1a fa ff ff       	call   8014df <syscall>
  801ac5:	83 c4 18             	add    $0x18,%esp
  801ac8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801acb:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801acf:	75 07                	jne    801ad8 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801ad1:	b8 01 00 00 00       	mov    $0x1,%eax
  801ad6:	eb 05                	jmp    801add <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801ad8:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801add:	c9                   	leave  
  801ade:	c3                   	ret    

00801adf <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801adf:	55                   	push   %ebp
  801ae0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801ae2:	6a 00                	push   $0x0
  801ae4:	6a 00                	push   $0x0
  801ae6:	6a 00                	push   $0x0
  801ae8:	6a 00                	push   $0x0
  801aea:	ff 75 08             	pushl  0x8(%ebp)
  801aed:	6a 2d                	push   $0x2d
  801aef:	e8 eb f9 ff ff       	call   8014df <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
	return ;
  801af7:	90                   	nop
}
  801af8:	c9                   	leave  
  801af9:	c3                   	ret    

00801afa <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801afa:	55                   	push   %ebp
  801afb:	89 e5                	mov    %esp,%ebp
  801afd:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801afe:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801b01:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801b04:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b07:	8b 45 08             	mov    0x8(%ebp),%eax
  801b0a:	6a 00                	push   $0x0
  801b0c:	53                   	push   %ebx
  801b0d:	51                   	push   %ecx
  801b0e:	52                   	push   %edx
  801b0f:	50                   	push   %eax
  801b10:	6a 2e                	push   $0x2e
  801b12:	e8 c8 f9 ff ff       	call   8014df <syscall>
  801b17:	83 c4 18             	add    $0x18,%esp
}
  801b1a:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801b1d:	c9                   	leave  
  801b1e:	c3                   	ret    

00801b1f <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801b1f:	55                   	push   %ebp
  801b20:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801b22:	8b 55 0c             	mov    0xc(%ebp),%edx
  801b25:	8b 45 08             	mov    0x8(%ebp),%eax
  801b28:	6a 00                	push   $0x0
  801b2a:	6a 00                	push   $0x0
  801b2c:	6a 00                	push   $0x0
  801b2e:	52                   	push   %edx
  801b2f:	50                   	push   %eax
  801b30:	6a 2f                	push   $0x2f
  801b32:	e8 a8 f9 ff ff       	call   8014df <syscall>
  801b37:	83 c4 18             	add    $0x18,%esp
}
  801b3a:	c9                   	leave  
  801b3b:	c3                   	ret    

00801b3c <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801b3c:	55                   	push   %ebp
  801b3d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801b3f:	6a 00                	push   $0x0
  801b41:	6a 00                	push   $0x0
  801b43:	6a 00                	push   $0x0
  801b45:	ff 75 0c             	pushl  0xc(%ebp)
  801b48:	ff 75 08             	pushl  0x8(%ebp)
  801b4b:	6a 30                	push   $0x30
  801b4d:	e8 8d f9 ff ff       	call   8014df <syscall>
  801b52:	83 c4 18             	add    $0x18,%esp
	return ;
  801b55:	90                   	nop
}
  801b56:	c9                   	leave  
  801b57:	c3                   	ret    

00801b58 <__udivdi3>:
  801b58:	55                   	push   %ebp
  801b59:	57                   	push   %edi
  801b5a:	56                   	push   %esi
  801b5b:	53                   	push   %ebx
  801b5c:	83 ec 1c             	sub    $0x1c,%esp
  801b5f:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801b63:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801b67:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b6b:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b6f:	89 ca                	mov    %ecx,%edx
  801b71:	89 f8                	mov    %edi,%eax
  801b73:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b77:	85 f6                	test   %esi,%esi
  801b79:	75 2d                	jne    801ba8 <__udivdi3+0x50>
  801b7b:	39 cf                	cmp    %ecx,%edi
  801b7d:	77 65                	ja     801be4 <__udivdi3+0x8c>
  801b7f:	89 fd                	mov    %edi,%ebp
  801b81:	85 ff                	test   %edi,%edi
  801b83:	75 0b                	jne    801b90 <__udivdi3+0x38>
  801b85:	b8 01 00 00 00       	mov    $0x1,%eax
  801b8a:	31 d2                	xor    %edx,%edx
  801b8c:	f7 f7                	div    %edi
  801b8e:	89 c5                	mov    %eax,%ebp
  801b90:	31 d2                	xor    %edx,%edx
  801b92:	89 c8                	mov    %ecx,%eax
  801b94:	f7 f5                	div    %ebp
  801b96:	89 c1                	mov    %eax,%ecx
  801b98:	89 d8                	mov    %ebx,%eax
  801b9a:	f7 f5                	div    %ebp
  801b9c:	89 cf                	mov    %ecx,%edi
  801b9e:	89 fa                	mov    %edi,%edx
  801ba0:	83 c4 1c             	add    $0x1c,%esp
  801ba3:	5b                   	pop    %ebx
  801ba4:	5e                   	pop    %esi
  801ba5:	5f                   	pop    %edi
  801ba6:	5d                   	pop    %ebp
  801ba7:	c3                   	ret    
  801ba8:	39 ce                	cmp    %ecx,%esi
  801baa:	77 28                	ja     801bd4 <__udivdi3+0x7c>
  801bac:	0f bd fe             	bsr    %esi,%edi
  801baf:	83 f7 1f             	xor    $0x1f,%edi
  801bb2:	75 40                	jne    801bf4 <__udivdi3+0x9c>
  801bb4:	39 ce                	cmp    %ecx,%esi
  801bb6:	72 0a                	jb     801bc2 <__udivdi3+0x6a>
  801bb8:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801bbc:	0f 87 9e 00 00 00    	ja     801c60 <__udivdi3+0x108>
  801bc2:	b8 01 00 00 00       	mov    $0x1,%eax
  801bc7:	89 fa                	mov    %edi,%edx
  801bc9:	83 c4 1c             	add    $0x1c,%esp
  801bcc:	5b                   	pop    %ebx
  801bcd:	5e                   	pop    %esi
  801bce:	5f                   	pop    %edi
  801bcf:	5d                   	pop    %ebp
  801bd0:	c3                   	ret    
  801bd1:	8d 76 00             	lea    0x0(%esi),%esi
  801bd4:	31 ff                	xor    %edi,%edi
  801bd6:	31 c0                	xor    %eax,%eax
  801bd8:	89 fa                	mov    %edi,%edx
  801bda:	83 c4 1c             	add    $0x1c,%esp
  801bdd:	5b                   	pop    %ebx
  801bde:	5e                   	pop    %esi
  801bdf:	5f                   	pop    %edi
  801be0:	5d                   	pop    %ebp
  801be1:	c3                   	ret    
  801be2:	66 90                	xchg   %ax,%ax
  801be4:	89 d8                	mov    %ebx,%eax
  801be6:	f7 f7                	div    %edi
  801be8:	31 ff                	xor    %edi,%edi
  801bea:	89 fa                	mov    %edi,%edx
  801bec:	83 c4 1c             	add    $0x1c,%esp
  801bef:	5b                   	pop    %ebx
  801bf0:	5e                   	pop    %esi
  801bf1:	5f                   	pop    %edi
  801bf2:	5d                   	pop    %ebp
  801bf3:	c3                   	ret    
  801bf4:	bd 20 00 00 00       	mov    $0x20,%ebp
  801bf9:	89 eb                	mov    %ebp,%ebx
  801bfb:	29 fb                	sub    %edi,%ebx
  801bfd:	89 f9                	mov    %edi,%ecx
  801bff:	d3 e6                	shl    %cl,%esi
  801c01:	89 c5                	mov    %eax,%ebp
  801c03:	88 d9                	mov    %bl,%cl
  801c05:	d3 ed                	shr    %cl,%ebp
  801c07:	89 e9                	mov    %ebp,%ecx
  801c09:	09 f1                	or     %esi,%ecx
  801c0b:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801c0f:	89 f9                	mov    %edi,%ecx
  801c11:	d3 e0                	shl    %cl,%eax
  801c13:	89 c5                	mov    %eax,%ebp
  801c15:	89 d6                	mov    %edx,%esi
  801c17:	88 d9                	mov    %bl,%cl
  801c19:	d3 ee                	shr    %cl,%esi
  801c1b:	89 f9                	mov    %edi,%ecx
  801c1d:	d3 e2                	shl    %cl,%edx
  801c1f:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c23:	88 d9                	mov    %bl,%cl
  801c25:	d3 e8                	shr    %cl,%eax
  801c27:	09 c2                	or     %eax,%edx
  801c29:	89 d0                	mov    %edx,%eax
  801c2b:	89 f2                	mov    %esi,%edx
  801c2d:	f7 74 24 0c          	divl   0xc(%esp)
  801c31:	89 d6                	mov    %edx,%esi
  801c33:	89 c3                	mov    %eax,%ebx
  801c35:	f7 e5                	mul    %ebp
  801c37:	39 d6                	cmp    %edx,%esi
  801c39:	72 19                	jb     801c54 <__udivdi3+0xfc>
  801c3b:	74 0b                	je     801c48 <__udivdi3+0xf0>
  801c3d:	89 d8                	mov    %ebx,%eax
  801c3f:	31 ff                	xor    %edi,%edi
  801c41:	e9 58 ff ff ff       	jmp    801b9e <__udivdi3+0x46>
  801c46:	66 90                	xchg   %ax,%ax
  801c48:	8b 54 24 08          	mov    0x8(%esp),%edx
  801c4c:	89 f9                	mov    %edi,%ecx
  801c4e:	d3 e2                	shl    %cl,%edx
  801c50:	39 c2                	cmp    %eax,%edx
  801c52:	73 e9                	jae    801c3d <__udivdi3+0xe5>
  801c54:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801c57:	31 ff                	xor    %edi,%edi
  801c59:	e9 40 ff ff ff       	jmp    801b9e <__udivdi3+0x46>
  801c5e:	66 90                	xchg   %ax,%ax
  801c60:	31 c0                	xor    %eax,%eax
  801c62:	e9 37 ff ff ff       	jmp    801b9e <__udivdi3+0x46>
  801c67:	90                   	nop

00801c68 <__umoddi3>:
  801c68:	55                   	push   %ebp
  801c69:	57                   	push   %edi
  801c6a:	56                   	push   %esi
  801c6b:	53                   	push   %ebx
  801c6c:	83 ec 1c             	sub    $0x1c,%esp
  801c6f:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c73:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c77:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c7b:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c7f:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c83:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c87:	89 f3                	mov    %esi,%ebx
  801c89:	89 fa                	mov    %edi,%edx
  801c8b:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c8f:	89 34 24             	mov    %esi,(%esp)
  801c92:	85 c0                	test   %eax,%eax
  801c94:	75 1a                	jne    801cb0 <__umoddi3+0x48>
  801c96:	39 f7                	cmp    %esi,%edi
  801c98:	0f 86 a2 00 00 00    	jbe    801d40 <__umoddi3+0xd8>
  801c9e:	89 c8                	mov    %ecx,%eax
  801ca0:	89 f2                	mov    %esi,%edx
  801ca2:	f7 f7                	div    %edi
  801ca4:	89 d0                	mov    %edx,%eax
  801ca6:	31 d2                	xor    %edx,%edx
  801ca8:	83 c4 1c             	add    $0x1c,%esp
  801cab:	5b                   	pop    %ebx
  801cac:	5e                   	pop    %esi
  801cad:	5f                   	pop    %edi
  801cae:	5d                   	pop    %ebp
  801caf:	c3                   	ret    
  801cb0:	39 f0                	cmp    %esi,%eax
  801cb2:	0f 87 ac 00 00 00    	ja     801d64 <__umoddi3+0xfc>
  801cb8:	0f bd e8             	bsr    %eax,%ebp
  801cbb:	83 f5 1f             	xor    $0x1f,%ebp
  801cbe:	0f 84 ac 00 00 00    	je     801d70 <__umoddi3+0x108>
  801cc4:	bf 20 00 00 00       	mov    $0x20,%edi
  801cc9:	29 ef                	sub    %ebp,%edi
  801ccb:	89 fe                	mov    %edi,%esi
  801ccd:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801cd1:	89 e9                	mov    %ebp,%ecx
  801cd3:	d3 e0                	shl    %cl,%eax
  801cd5:	89 d7                	mov    %edx,%edi
  801cd7:	89 f1                	mov    %esi,%ecx
  801cd9:	d3 ef                	shr    %cl,%edi
  801cdb:	09 c7                	or     %eax,%edi
  801cdd:	89 e9                	mov    %ebp,%ecx
  801cdf:	d3 e2                	shl    %cl,%edx
  801ce1:	89 14 24             	mov    %edx,(%esp)
  801ce4:	89 d8                	mov    %ebx,%eax
  801ce6:	d3 e0                	shl    %cl,%eax
  801ce8:	89 c2                	mov    %eax,%edx
  801cea:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cee:	d3 e0                	shl    %cl,%eax
  801cf0:	89 44 24 04          	mov    %eax,0x4(%esp)
  801cf4:	8b 44 24 08          	mov    0x8(%esp),%eax
  801cf8:	89 f1                	mov    %esi,%ecx
  801cfa:	d3 e8                	shr    %cl,%eax
  801cfc:	09 d0                	or     %edx,%eax
  801cfe:	d3 eb                	shr    %cl,%ebx
  801d00:	89 da                	mov    %ebx,%edx
  801d02:	f7 f7                	div    %edi
  801d04:	89 d3                	mov    %edx,%ebx
  801d06:	f7 24 24             	mull   (%esp)
  801d09:	89 c6                	mov    %eax,%esi
  801d0b:	89 d1                	mov    %edx,%ecx
  801d0d:	39 d3                	cmp    %edx,%ebx
  801d0f:	0f 82 87 00 00 00    	jb     801d9c <__umoddi3+0x134>
  801d15:	0f 84 91 00 00 00    	je     801dac <__umoddi3+0x144>
  801d1b:	8b 54 24 04          	mov    0x4(%esp),%edx
  801d1f:	29 f2                	sub    %esi,%edx
  801d21:	19 cb                	sbb    %ecx,%ebx
  801d23:	89 d8                	mov    %ebx,%eax
  801d25:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801d29:	d3 e0                	shl    %cl,%eax
  801d2b:	89 e9                	mov    %ebp,%ecx
  801d2d:	d3 ea                	shr    %cl,%edx
  801d2f:	09 d0                	or     %edx,%eax
  801d31:	89 e9                	mov    %ebp,%ecx
  801d33:	d3 eb                	shr    %cl,%ebx
  801d35:	89 da                	mov    %ebx,%edx
  801d37:	83 c4 1c             	add    $0x1c,%esp
  801d3a:	5b                   	pop    %ebx
  801d3b:	5e                   	pop    %esi
  801d3c:	5f                   	pop    %edi
  801d3d:	5d                   	pop    %ebp
  801d3e:	c3                   	ret    
  801d3f:	90                   	nop
  801d40:	89 fd                	mov    %edi,%ebp
  801d42:	85 ff                	test   %edi,%edi
  801d44:	75 0b                	jne    801d51 <__umoddi3+0xe9>
  801d46:	b8 01 00 00 00       	mov    $0x1,%eax
  801d4b:	31 d2                	xor    %edx,%edx
  801d4d:	f7 f7                	div    %edi
  801d4f:	89 c5                	mov    %eax,%ebp
  801d51:	89 f0                	mov    %esi,%eax
  801d53:	31 d2                	xor    %edx,%edx
  801d55:	f7 f5                	div    %ebp
  801d57:	89 c8                	mov    %ecx,%eax
  801d59:	f7 f5                	div    %ebp
  801d5b:	89 d0                	mov    %edx,%eax
  801d5d:	e9 44 ff ff ff       	jmp    801ca6 <__umoddi3+0x3e>
  801d62:	66 90                	xchg   %ax,%ax
  801d64:	89 c8                	mov    %ecx,%eax
  801d66:	89 f2                	mov    %esi,%edx
  801d68:	83 c4 1c             	add    $0x1c,%esp
  801d6b:	5b                   	pop    %ebx
  801d6c:	5e                   	pop    %esi
  801d6d:	5f                   	pop    %edi
  801d6e:	5d                   	pop    %ebp
  801d6f:	c3                   	ret    
  801d70:	3b 04 24             	cmp    (%esp),%eax
  801d73:	72 06                	jb     801d7b <__umoddi3+0x113>
  801d75:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d79:	77 0f                	ja     801d8a <__umoddi3+0x122>
  801d7b:	89 f2                	mov    %esi,%edx
  801d7d:	29 f9                	sub    %edi,%ecx
  801d7f:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d83:	89 14 24             	mov    %edx,(%esp)
  801d86:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d8a:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d8e:	8b 14 24             	mov    (%esp),%edx
  801d91:	83 c4 1c             	add    $0x1c,%esp
  801d94:	5b                   	pop    %ebx
  801d95:	5e                   	pop    %esi
  801d96:	5f                   	pop    %edi
  801d97:	5d                   	pop    %ebp
  801d98:	c3                   	ret    
  801d99:	8d 76 00             	lea    0x0(%esi),%esi
  801d9c:	2b 04 24             	sub    (%esp),%eax
  801d9f:	19 fa                	sbb    %edi,%edx
  801da1:	89 d1                	mov    %edx,%ecx
  801da3:	89 c6                	mov    %eax,%esi
  801da5:	e9 71 ff ff ff       	jmp    801d1b <__umoddi3+0xb3>
  801daa:	66 90                	xchg   %ax,%ax
  801dac:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801db0:	72 ea                	jb     801d9c <__umoddi3+0x134>
  801db2:	89 d9                	mov    %ebx,%ecx
  801db4:	e9 62 ff ff ff       	jmp    801d1b <__umoddi3+0xb3>
