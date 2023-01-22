
obj/user/tst_placement:     file format elf32-i386


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
  800031:	e8 a8 05 00 00       	call   8005de <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
/* *********************************************************** */

#include <inc/lib.h>

void _main(void)
{
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	57                   	push   %edi
  80003c:	56                   	push   %esi
  80003d:	53                   	push   %ebx
  80003e:	81 ec 9c 00 00 01    	sub    $0x100009c,%esp

	char arr[PAGE_SIZE*1024*4];

	//("STEP 0: checking Initial WS entries ...\n");
	{
		if( ROUNDDOWN(myEnv->__uptr_pws[0].virtual_address,PAGE_SIZE) !=   0x200000)  	panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800044:	a1 20 30 80 00       	mov    0x803020,%eax
  800049:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80004f:	8b 00                	mov    (%eax),%eax
  800051:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800054:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800057:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80005c:	3d 00 00 20 00       	cmp    $0x200000,%eax
  800061:	74 14                	je     800077 <_main+0x3f>
  800063:	83 ec 04             	sub    $0x4,%esp
  800066:	68 20 20 80 00       	push   $0x802020
  80006b:	6a 10                	push   $0x10
  80006d:	68 61 20 80 00       	push   $0x802061
  800072:	e8 83 06 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[1].virtual_address,PAGE_SIZE) !=   0x201000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800077:	a1 20 30 80 00       	mov    0x803020,%eax
  80007c:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800082:	83 c0 18             	add    $0x18,%eax
  800085:	8b 00                	mov    (%eax),%eax
  800087:	89 45 d8             	mov    %eax,-0x28(%ebp)
  80008a:	8b 45 d8             	mov    -0x28(%ebp),%eax
  80008d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800092:	3d 00 10 20 00       	cmp    $0x201000,%eax
  800097:	74 14                	je     8000ad <_main+0x75>
  800099:	83 ec 04             	sub    $0x4,%esp
  80009c:	68 20 20 80 00       	push   $0x802020
  8000a1:	6a 11                	push   $0x11
  8000a3:	68 61 20 80 00       	push   $0x802061
  8000a8:	e8 4d 06 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[2].virtual_address,PAGE_SIZE) !=   0x202000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000ad:	a1 20 30 80 00       	mov    0x803020,%eax
  8000b2:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000b8:	83 c0 30             	add    $0x30,%eax
  8000bb:	8b 00                	mov    (%eax),%eax
  8000bd:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  8000c0:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000c3:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000c8:	3d 00 20 20 00       	cmp    $0x202000,%eax
  8000cd:	74 14                	je     8000e3 <_main+0xab>
  8000cf:	83 ec 04             	sub    $0x4,%esp
  8000d2:	68 20 20 80 00       	push   $0x802020
  8000d7:	6a 12                	push   $0x12
  8000d9:	68 61 20 80 00       	push   $0x802061
  8000de:	e8 17 06 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[3].virtual_address,PAGE_SIZE) !=   0x203000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8000e3:	a1 20 30 80 00       	mov    0x803020,%eax
  8000e8:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8000ee:	83 c0 48             	add    $0x48,%eax
  8000f1:	8b 00                	mov    (%eax),%eax
  8000f3:	89 45 d0             	mov    %eax,-0x30(%ebp)
  8000f6:	8b 45 d0             	mov    -0x30(%ebp),%eax
  8000f9:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8000fe:	3d 00 30 20 00       	cmp    $0x203000,%eax
  800103:	74 14                	je     800119 <_main+0xe1>
  800105:	83 ec 04             	sub    $0x4,%esp
  800108:	68 20 20 80 00       	push   $0x802020
  80010d:	6a 13                	push   $0x13
  80010f:	68 61 20 80 00       	push   $0x802061
  800114:	e8 e1 05 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[4].virtual_address,PAGE_SIZE) !=   0x204000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800119:	a1 20 30 80 00       	mov    0x803020,%eax
  80011e:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800124:	83 c0 60             	add    $0x60,%eax
  800127:	8b 00                	mov    (%eax),%eax
  800129:	89 45 cc             	mov    %eax,-0x34(%ebp)
  80012c:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80012f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800134:	3d 00 40 20 00       	cmp    $0x204000,%eax
  800139:	74 14                	je     80014f <_main+0x117>
  80013b:	83 ec 04             	sub    $0x4,%esp
  80013e:	68 20 20 80 00       	push   $0x802020
  800143:	6a 14                	push   $0x14
  800145:	68 61 20 80 00       	push   $0x802061
  80014a:	e8 ab 05 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[5].virtual_address,PAGE_SIZE) !=   0x205000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80014f:	a1 20 30 80 00       	mov    0x803020,%eax
  800154:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  80015a:	83 c0 78             	add    $0x78,%eax
  80015d:	8b 00                	mov    (%eax),%eax
  80015f:	89 45 c8             	mov    %eax,-0x38(%ebp)
  800162:	8b 45 c8             	mov    -0x38(%ebp),%eax
  800165:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80016a:	3d 00 50 20 00       	cmp    $0x205000,%eax
  80016f:	74 14                	je     800185 <_main+0x14d>
  800171:	83 ec 04             	sub    $0x4,%esp
  800174:	68 20 20 80 00       	push   $0x802020
  800179:	6a 15                	push   $0x15
  80017b:	68 61 20 80 00       	push   $0x802061
  800180:	e8 75 05 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[6].virtual_address,PAGE_SIZE) !=   0x206000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800185:	a1 20 30 80 00       	mov    0x803020,%eax
  80018a:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800190:	05 90 00 00 00       	add    $0x90,%eax
  800195:	8b 00                	mov    (%eax),%eax
  800197:	89 45 c4             	mov    %eax,-0x3c(%ebp)
  80019a:	8b 45 c4             	mov    -0x3c(%ebp),%eax
  80019d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001a2:	3d 00 60 20 00       	cmp    $0x206000,%eax
  8001a7:	74 14                	je     8001bd <_main+0x185>
  8001a9:	83 ec 04             	sub    $0x4,%esp
  8001ac:	68 20 20 80 00       	push   $0x802020
  8001b1:	6a 16                	push   $0x16
  8001b3:	68 61 20 80 00       	push   $0x802061
  8001b8:	e8 3d 05 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[7].virtual_address,PAGE_SIZE) !=   0x800000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8001c2:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8001c8:	05 a8 00 00 00       	add    $0xa8,%eax
  8001cd:	8b 00                	mov    (%eax),%eax
  8001cf:	89 45 c0             	mov    %eax,-0x40(%ebp)
  8001d2:	8b 45 c0             	mov    -0x40(%ebp),%eax
  8001d5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8001da:	3d 00 00 80 00       	cmp    $0x800000,%eax
  8001df:	74 14                	je     8001f5 <_main+0x1bd>
  8001e1:	83 ec 04             	sub    $0x4,%esp
  8001e4:	68 20 20 80 00       	push   $0x802020
  8001e9:	6a 17                	push   $0x17
  8001eb:	68 61 20 80 00       	push   $0x802061
  8001f0:	e8 05 05 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8001f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fa:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800200:	05 c0 00 00 00       	add    $0xc0,%eax
  800205:	8b 00                	mov    (%eax),%eax
  800207:	89 45 bc             	mov    %eax,-0x44(%ebp)
  80020a:	8b 45 bc             	mov    -0x44(%ebp),%eax
  80020d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800212:	3d 00 10 80 00       	cmp    $0x801000,%eax
  800217:	74 14                	je     80022d <_main+0x1f5>
  800219:	83 ec 04             	sub    $0x4,%esp
  80021c:	68 20 20 80 00       	push   $0x802020
  800221:	6a 18                	push   $0x18
  800223:	68 61 20 80 00       	push   $0x802061
  800228:	e8 cd 04 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80022d:	a1 20 30 80 00       	mov    0x803020,%eax
  800232:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800238:	05 d8 00 00 00       	add    $0xd8,%eax
  80023d:	8b 00                	mov    (%eax),%eax
  80023f:	89 45 b8             	mov    %eax,-0x48(%ebp)
  800242:	8b 45 b8             	mov    -0x48(%ebp),%eax
  800245:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80024a:	3d 00 20 80 00       	cmp    $0x802000,%eax
  80024f:	74 14                	je     800265 <_main+0x22d>
  800251:	83 ec 04             	sub    $0x4,%esp
  800254:	68 20 20 80 00       	push   $0x802020
  800259:	6a 19                	push   $0x19
  80025b:	68 61 20 80 00       	push   $0x802061
  800260:	e8 95 04 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  800265:	a1 20 30 80 00       	mov    0x803020,%eax
  80026a:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  800270:	05 f0 00 00 00       	add    $0xf0,%eax
  800275:	8b 00                	mov    (%eax),%eax
  800277:	89 45 b4             	mov    %eax,-0x4c(%ebp)
  80027a:	8b 45 b4             	mov    -0x4c(%ebp),%eax
  80027d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800282:	3d 00 30 80 00       	cmp    $0x803000,%eax
  800287:	74 14                	je     80029d <_main+0x265>
  800289:	83 ec 04             	sub    $0x4,%esp
  80028c:	68 20 20 80 00       	push   $0x802020
  800291:	6a 1a                	push   $0x1a
  800293:	68 61 20 80 00       	push   $0x802061
  800298:	e8 5d 04 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  80029d:	a1 20 30 80 00       	mov    0x803020,%eax
  8002a2:	8b 80 9c 05 00 00    	mov    0x59c(%eax),%eax
  8002a8:	05 08 01 00 00       	add    $0x108,%eax
  8002ad:	8b 00                	mov    (%eax),%eax
  8002af:	89 45 b0             	mov    %eax,-0x50(%ebp)
  8002b2:	8b 45 b0             	mov    -0x50(%ebp),%eax
  8002b5:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  8002ba:	3d 00 d0 bf ee       	cmp    $0xeebfd000,%eax
  8002bf:	74 14                	je     8002d5 <_main+0x29d>
  8002c1:	83 ec 04             	sub    $0x4,%esp
  8002c4:	68 20 20 80 00       	push   $0x802020
  8002c9:	6a 1b                	push   $0x1b
  8002cb:	68 61 20 80 00       	push   $0x802061
  8002d0:	e8 25 04 00 00       	call   8006fa <_panic>

		for (int k = 12; k < 20; k++)
  8002d5:	c7 45 e4 0c 00 00 00 	movl   $0xc,-0x1c(%ebp)
  8002dc:	eb 37                	jmp    800315 <_main+0x2dd>
			if( myEnv->__uptr_pws[k].empty !=  1)
  8002de:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e3:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8002e9:	8b 55 e4             	mov    -0x1c(%ebp),%edx
  8002ec:	89 d0                	mov    %edx,%eax
  8002ee:	01 c0                	add    %eax,%eax
  8002f0:	01 d0                	add    %edx,%eax
  8002f2:	c1 e0 03             	shl    $0x3,%eax
  8002f5:	01 c8                	add    %ecx,%eax
  8002f7:	8a 40 04             	mov    0x4(%eax),%al
  8002fa:	3c 01                	cmp    $0x1,%al
  8002fc:	74 14                	je     800312 <_main+0x2da>
				panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
  8002fe:	83 ec 04             	sub    $0x4,%esp
  800301:	68 20 20 80 00       	push   $0x802020
  800306:	6a 1f                	push   $0x1f
  800308:	68 61 20 80 00       	push   $0x802061
  80030d:	e8 e8 03 00 00       	call   8006fa <_panic>
		if( ROUNDDOWN(myEnv->__uptr_pws[8].virtual_address,PAGE_SIZE) !=   0x801000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[9].virtual_address,PAGE_SIZE) !=   0x802000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[10].virtual_address,PAGE_SIZE) !=   0x803000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");
		if( ROUNDDOWN(myEnv->__uptr_pws[11].virtual_address,PAGE_SIZE) !=   0xeebfd000)  panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");

		for (int k = 12; k < 20; k++)
  800312:	ff 45 e4             	incl   -0x1c(%ebp)
  800315:	83 7d e4 13          	cmpl   $0x13,-0x1c(%ebp)
  800319:	7e c3                	jle    8002de <_main+0x2a6>
			if( myEnv->__uptr_pws[k].empty !=  1)
				panic("INITIAL PAGE WS entry checking failed! Review size of the WS..!!");

		if( myEnv->page_last_WS_index !=  12)  											panic("INITIAL PAGE last index checking failed! Review size of the WS..!!");
  80031b:	a1 20 30 80 00       	mov    0x803020,%eax
  800320:	8b 80 2c 05 00 00    	mov    0x52c(%eax),%eax
  800326:	83 f8 0c             	cmp    $0xc,%eax
  800329:	74 14                	je     80033f <_main+0x307>
  80032b:	83 ec 04             	sub    $0x4,%esp
  80032e:	68 78 20 80 00       	push   $0x802078
  800333:	6a 21                	push   $0x21
  800335:	68 61 20 80 00       	push   $0x802061
  80033a:	e8 bb 03 00 00       	call   8006fa <_panic>
		/*====================================*/
	}

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  80033f:	e8 e3 15 00 00       	call   801927 <sys_pf_calculate_allocated_pages>
  800344:	89 45 ac             	mov    %eax,-0x54(%ebp)
	int freePages = sys_calculate_free_frames();
  800347:	e8 58 15 00 00       	call   8018a4 <sys_calculate_free_frames>
  80034c:	89 45 a8             	mov    %eax,-0x58(%ebp)

	int i=0;
  80034f:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
	for(;i<=PAGE_SIZE;i++)
  800356:	eb 11                	jmp    800369 <_main+0x331>
	{
		arr[i] = -1;
  800358:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  80035e:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800361:	01 d0                	add    %edx,%eax
  800363:	c6 00 ff             	movb   $0xff,(%eax)

	int usedDiskPages = sys_pf_calculate_allocated_pages() ;
	int freePages = sys_calculate_free_frames();

	int i=0;
	for(;i<=PAGE_SIZE;i++)
  800366:	ff 45 e0             	incl   -0x20(%ebp)
  800369:	81 7d e0 00 10 00 00 	cmpl   $0x1000,-0x20(%ebp)
  800370:	7e e6                	jle    800358 <_main+0x320>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
  800372:	c7 45 e0 00 00 40 00 	movl   $0x400000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800379:	eb 11                	jmp    80038c <_main+0x354>
	{
		arr[i] = -1;
  80037b:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  800381:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800384:	01 d0                	add    %edx,%eax
  800386:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024;
	for(;i<=(PAGE_SIZE*1024 + PAGE_SIZE);i++)
  800389:	ff 45 e0             	incl   -0x20(%ebp)
  80038c:	81 7d e0 00 10 40 00 	cmpl   $0x401000,-0x20(%ebp)
  800393:	7e e6                	jle    80037b <_main+0x343>
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
  800395:	c7 45 e0 00 00 80 00 	movl   $0x800000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  80039c:	eb 11                	jmp    8003af <_main+0x377>
	{
		arr[i] = -1;
  80039e:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  8003a4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8003a7:	01 d0                	add    %edx,%eax
  8003a9:	c6 00 ff             	movb   $0xff,(%eax)
	{
		arr[i] = -1;
	}

	i=PAGE_SIZE*1024*2;
	for(;i<=(PAGE_SIZE*1024*2 + PAGE_SIZE);i++)
  8003ac:	ff 45 e0             	incl   -0x20(%ebp)
  8003af:	81 7d e0 00 10 80 00 	cmpl   $0x801000,-0x20(%ebp)
  8003b6:	7e e6                	jle    80039e <_main+0x366>
		arr[i] = -1;
	}



	cprintf("STEP A: checking PLACEMENT fault handling ... \n");
  8003b8:	83 ec 0c             	sub    $0xc,%esp
  8003bb:	68 bc 20 80 00       	push   $0x8020bc
  8003c0:	e8 e9 05 00 00       	call   8009ae <cprintf>
  8003c5:	83 c4 10             	add    $0x10,%esp
	{
		if( arr[0] !=  -1)  panic("PLACEMENT of stack page failed");
  8003c8:	8a 85 a8 ff ff fe    	mov    -0x1000058(%ebp),%al
  8003ce:	3c ff                	cmp    $0xff,%al
  8003d0:	74 14                	je     8003e6 <_main+0x3ae>
  8003d2:	83 ec 04             	sub    $0x4,%esp
  8003d5:	68 ec 20 80 00       	push   $0x8020ec
  8003da:	6a 3e                	push   $0x3e
  8003dc:	68 61 20 80 00       	push   $0x802061
  8003e1:	e8 14 03 00 00       	call   8006fa <_panic>
		if( arr[PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  8003e6:	8a 85 a8 0f 00 ff    	mov    -0xfff058(%ebp),%al
  8003ec:	3c ff                	cmp    $0xff,%al
  8003ee:	74 14                	je     800404 <_main+0x3cc>
  8003f0:	83 ec 04             	sub    $0x4,%esp
  8003f3:	68 ec 20 80 00       	push   $0x8020ec
  8003f8:	6a 3f                	push   $0x3f
  8003fa:	68 61 20 80 00       	push   $0x802061
  8003ff:	e8 f6 02 00 00       	call   8006fa <_panic>

		if( arr[PAGE_SIZE*1024] !=  -1)  panic("PLACEMENT of stack page failed");
  800404:	8a 85 a8 ff 3f ff    	mov    -0xc00058(%ebp),%al
  80040a:	3c ff                	cmp    $0xff,%al
  80040c:	74 14                	je     800422 <_main+0x3ea>
  80040e:	83 ec 04             	sub    $0x4,%esp
  800411:	68 ec 20 80 00       	push   $0x8020ec
  800416:	6a 41                	push   $0x41
  800418:	68 61 20 80 00       	push   $0x802061
  80041d:	e8 d8 02 00 00       	call   8006fa <_panic>
		if( arr[PAGE_SIZE*1025] !=  -1)  panic("PLACEMENT of stack page failed");
  800422:	8a 85 a8 0f 40 ff    	mov    -0xbff058(%ebp),%al
  800428:	3c ff                	cmp    $0xff,%al
  80042a:	74 14                	je     800440 <_main+0x408>
  80042c:	83 ec 04             	sub    $0x4,%esp
  80042f:	68 ec 20 80 00       	push   $0x8020ec
  800434:	6a 42                	push   $0x42
  800436:	68 61 20 80 00       	push   $0x802061
  80043b:	e8 ba 02 00 00       	call   8006fa <_panic>

		if( arr[PAGE_SIZE*1024*2] !=  -1)  panic("PLACEMENT of stack page failed");
  800440:	8a 85 a8 ff 7f ff    	mov    -0x800058(%ebp),%al
  800446:	3c ff                	cmp    $0xff,%al
  800448:	74 14                	je     80045e <_main+0x426>
  80044a:	83 ec 04             	sub    $0x4,%esp
  80044d:	68 ec 20 80 00       	push   $0x8020ec
  800452:	6a 44                	push   $0x44
  800454:	68 61 20 80 00       	push   $0x802061
  800459:	e8 9c 02 00 00       	call   8006fa <_panic>
		if( arr[PAGE_SIZE*1024*2 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  80045e:	8a 85 a8 0f 80 ff    	mov    -0x7ff058(%ebp),%al
  800464:	3c ff                	cmp    $0xff,%al
  800466:	74 14                	je     80047c <_main+0x444>
  800468:	83 ec 04             	sub    $0x4,%esp
  80046b:	68 ec 20 80 00       	push   $0x8020ec
  800470:	6a 45                	push   $0x45
  800472:	68 61 20 80 00       	push   $0x802061
  800477:	e8 7e 02 00 00       	call   8006fa <_panic>


		if( (sys_pf_calculate_allocated_pages() - usedDiskPages) !=  5) panic("new stack pages are not written to Page File");
  80047c:	e8 a6 14 00 00       	call   801927 <sys_pf_calculate_allocated_pages>
  800481:	2b 45 ac             	sub    -0x54(%ebp),%eax
  800484:	83 f8 05             	cmp    $0x5,%eax
  800487:	74 14                	je     80049d <_main+0x465>
  800489:	83 ec 04             	sub    $0x4,%esp
  80048c:	68 0c 21 80 00       	push   $0x80210c
  800491:	6a 48                	push   $0x48
  800493:	68 61 20 80 00       	push   $0x802061
  800498:	e8 5d 02 00 00       	call   8006fa <_panic>

		if( (freePages - sys_calculate_free_frames() ) != 9 ) panic("allocated memory size incorrect");
  80049d:	8b 5d a8             	mov    -0x58(%ebp),%ebx
  8004a0:	e8 ff 13 00 00       	call   8018a4 <sys_calculate_free_frames>
  8004a5:	29 c3                	sub    %eax,%ebx
  8004a7:	89 d8                	mov    %ebx,%eax
  8004a9:	83 f8 09             	cmp    $0x9,%eax
  8004ac:	74 14                	je     8004c2 <_main+0x48a>
  8004ae:	83 ec 04             	sub    $0x4,%esp
  8004b1:	68 3c 21 80 00       	push   $0x80213c
  8004b6:	6a 4a                	push   $0x4a
  8004b8:	68 61 20 80 00       	push   $0x802061
  8004bd:	e8 38 02 00 00       	call   8006fa <_panic>
	}
	cprintf("STEP A passed: PLACEMENT fault handling works!\n\n\n");
  8004c2:	83 ec 0c             	sub    $0xc,%esp
  8004c5:	68 5c 21 80 00       	push   $0x80215c
  8004ca:	e8 df 04 00 00       	call   8009ae <cprintf>
  8004cf:	83 c4 10             	add    $0x10,%esp


	uint32 expectedPages[20] = {0x200000,0x201000,0x202000,0x203000,0x204000,0x205000,0x206000,0x800000,0x801000,0x802000,0x803000,0xeebfd000,0xedbfd000,0xedbfe000,0xedffd000,0xedffe000,0xee3fd000,0xee3fe000, 0, 0};
  8004d2:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8004d8:	bb a0 22 80 00       	mov    $0x8022a0,%ebx
  8004dd:	ba 14 00 00 00       	mov    $0x14,%edx
  8004e2:	89 c7                	mov    %eax,%edi
  8004e4:	89 de                	mov    %ebx,%esi
  8004e6:	89 d1                	mov    %edx,%ecx
  8004e8:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

	cprintf("STEP B: checking WS entries ...\n");
  8004ea:	83 ec 0c             	sub    $0xc,%esp
  8004ed:	68 90 21 80 00       	push   $0x802190
  8004f2:	e8 b7 04 00 00       	call   8009ae <cprintf>
  8004f7:	83 c4 10             	add    $0x10,%esp
	{
		CheckWSWithoutLastIndex(expectedPages, 20);
  8004fa:	83 ec 08             	sub    $0x8,%esp
  8004fd:	6a 14                	push   $0x14
  8004ff:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  800505:	50                   	push   %eax
  800506:	e8 61 02 00 00       	call   80076c <CheckWSWithoutLastIndex>
  80050b:	83 c4 10             	add    $0x10,%esp
	//		if( ROUNDDOWN(myEnv->__uptr_pws[14].virtual_address,PAGE_SIZE) !=  0xedffd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[15].virtual_address,PAGE_SIZE) !=  0xedffe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[16].virtual_address,PAGE_SIZE) !=  0xee3fd000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	//		if( ROUNDDOWN(myEnv->__uptr_pws[17].virtual_address,PAGE_SIZE) !=  0xee3fe000)  panic("PAGE WS entry checking failed... trace it by printing page WS before & after fault");
}
cprintf("STEP B passed: WS entries test are correct\n\n\n");
  80050e:	83 ec 0c             	sub    $0xc,%esp
  800511:	68 b4 21 80 00       	push   $0x8021b4
  800516:	e8 93 04 00 00       	call   8009ae <cprintf>
  80051b:	83 c4 10             	add    $0x10,%esp

cprintf("STEP C: checking working sets WHEN BECOMES FULL...\n");
  80051e:	83 ec 0c             	sub    $0xc,%esp
  800521:	68 e4 21 80 00       	push   $0x8021e4
  800526:	e8 83 04 00 00       	call   8009ae <cprintf>
  80052b:	83 c4 10             	add    $0x10,%esp
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
  80052e:	c7 45 e0 00 00 c0 00 	movl   $0xc00000,-0x20(%ebp)
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800535:	eb 11                	jmp    800548 <_main+0x510>
	{
		arr[i] = -1;
  800537:	8d 95 a8 ff ff fe    	lea    -0x1000058(%ebp),%edx
  80053d:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800540:	01 d0                	add    %edx,%eax
  800542:	c6 00 ff             	movb   $0xff,(%eax)
{
	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 18) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

	i=PAGE_SIZE*1024*3;
	for(;i<=(PAGE_SIZE*1024*3+PAGE_SIZE);i++)
  800545:	ff 45 e0             	incl   -0x20(%ebp)
  800548:	81 7d e0 00 10 c0 00 	cmpl   $0xc01000,-0x20(%ebp)
  80054f:	7e e6                	jle    800537 <_main+0x4ff>
	{
		arr[i] = -1;
	}

	if( arr[PAGE_SIZE*1024*3] !=  -1)  panic("PLACEMENT of stack page failed");
  800551:	8a 85 a8 ff bf ff    	mov    -0x400058(%ebp),%al
  800557:	3c ff                	cmp    $0xff,%al
  800559:	74 14                	je     80056f <_main+0x537>
  80055b:	83 ec 04             	sub    $0x4,%esp
  80055e:	68 ec 20 80 00       	push   $0x8020ec
  800563:	6a 73                	push   $0x73
  800565:	68 61 20 80 00       	push   $0x802061
  80056a:	e8 8b 01 00 00       	call   8006fa <_panic>
	if( arr[PAGE_SIZE*1024*3 + PAGE_SIZE] !=  -1)  panic("PLACEMENT of stack page failed");
  80056f:	8a 85 a8 0f c0 ff    	mov    -0x3ff058(%ebp),%al
  800575:	3c ff                	cmp    $0xff,%al
  800577:	74 14                	je     80058d <_main+0x555>
  800579:	83 ec 04             	sub    $0x4,%esp
  80057c:	68 ec 20 80 00       	push   $0x8020ec
  800581:	6a 74                	push   $0x74
  800583:	68 61 20 80 00       	push   $0x802061
  800588:	e8 6d 01 00 00       	call   8006fa <_panic>

	expectedPages[18] = 0xee7fd000;
  80058d:	c7 85 a0 ff ff fe 00 	movl   $0xee7fd000,-0x1000060(%ebp)
  800594:	d0 7f ee 
	expectedPages[19] = 0xee7fe000;
  800597:	c7 85 a4 ff ff fe 00 	movl   $0xee7fe000,-0x100005c(%ebp)
  80059e:	e0 7f ee 

	CheckWSWithoutLastIndex(expectedPages, 20);
  8005a1:	83 ec 08             	sub    $0x8,%esp
  8005a4:	6a 14                	push   $0x14
  8005a6:	8d 85 58 ff ff fe    	lea    -0x10000a8(%ebp),%eax
  8005ac:	50                   	push   %eax
  8005ad:	e8 ba 01 00 00       	call   80076c <CheckWSWithoutLastIndex>
  8005b2:	83 c4 10             	add    $0x10,%esp

	/*NO NEED FOR THIS AS WE WORK ON "LRU"*/
	//if(myEnv->page_last_WS_index != 0) panic("wrong PAGE WS pointer location... trace it by printing page WS before & after fault");

}
cprintf("STEP C passed: WS is FULL now\n\n\n");
  8005b5:	83 ec 0c             	sub    $0xc,%esp
  8005b8:	68 18 22 80 00       	push   $0x802218
  8005bd:	e8 ec 03 00 00       	call   8009ae <cprintf>
  8005c2:	83 c4 10             	add    $0x10,%esp

cprintf("Congratulations!! Test of PAGE PLACEMENT completed successfully!!\n\n\n");
  8005c5:	83 ec 0c             	sub    $0xc,%esp
  8005c8:	68 3c 22 80 00       	push   $0x80223c
  8005cd:	e8 dc 03 00 00       	call   8009ae <cprintf>
  8005d2:	83 c4 10             	add    $0x10,%esp
return;
  8005d5:	90                   	nop
}
  8005d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
  8005d9:	5b                   	pop    %ebx
  8005da:	5e                   	pop    %esi
  8005db:	5f                   	pop    %edi
  8005dc:	5d                   	pop    %ebp
  8005dd:	c3                   	ret    

008005de <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  8005de:	55                   	push   %ebp
  8005df:	89 e5                	mov    %esp,%ebp
  8005e1:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  8005e4:	e8 f0 11 00 00       	call   8017d9 <sys_getenvindex>
  8005e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  8005ec:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8005ef:	89 d0                	mov    %edx,%eax
  8005f1:	01 c0                	add    %eax,%eax
  8005f3:	01 d0                	add    %edx,%eax
  8005f5:	c1 e0 04             	shl    $0x4,%eax
  8005f8:	29 d0                	sub    %edx,%eax
  8005fa:	c1 e0 03             	shl    $0x3,%eax
  8005fd:	01 d0                	add    %edx,%eax
  8005ff:	c1 e0 02             	shl    $0x2,%eax
  800602:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800607:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  80060c:	a1 20 30 80 00       	mov    0x803020,%eax
  800611:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800617:	84 c0                	test   %al,%al
  800619:	74 0f                	je     80062a <libmain+0x4c>
		binaryname = myEnv->prog_name;
  80061b:	a1 20 30 80 00       	mov    0x803020,%eax
  800620:	05 5c 05 00 00       	add    $0x55c,%eax
  800625:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  80062a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80062e:	7e 0a                	jle    80063a <libmain+0x5c>
		binaryname = argv[0];
  800630:	8b 45 0c             	mov    0xc(%ebp),%eax
  800633:	8b 00                	mov    (%eax),%eax
  800635:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  80063a:	83 ec 08             	sub    $0x8,%esp
  80063d:	ff 75 0c             	pushl  0xc(%ebp)
  800640:	ff 75 08             	pushl  0x8(%ebp)
  800643:	e8 f0 f9 ff ff       	call   800038 <_main>
  800648:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  80064b:	e8 24 13 00 00       	call   801974 <sys_disable_interrupt>
	cprintf("**************************************\n");
  800650:	83 ec 0c             	sub    $0xc,%esp
  800653:	68 08 23 80 00       	push   $0x802308
  800658:	e8 51 03 00 00       	call   8009ae <cprintf>
  80065d:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  800660:	a1 20 30 80 00       	mov    0x803020,%eax
  800665:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  80066b:	a1 20 30 80 00       	mov    0x803020,%eax
  800670:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  800676:	83 ec 04             	sub    $0x4,%esp
  800679:	52                   	push   %edx
  80067a:	50                   	push   %eax
  80067b:	68 30 23 80 00       	push   $0x802330
  800680:	e8 29 03 00 00       	call   8009ae <cprintf>
  800685:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  800688:	a1 20 30 80 00       	mov    0x803020,%eax
  80068d:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  800693:	a1 20 30 80 00       	mov    0x803020,%eax
  800698:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  80069e:	a1 20 30 80 00       	mov    0x803020,%eax
  8006a3:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8006a9:	51                   	push   %ecx
  8006aa:	52                   	push   %edx
  8006ab:	50                   	push   %eax
  8006ac:	68 58 23 80 00       	push   $0x802358
  8006b1:	e8 f8 02 00 00       	call   8009ae <cprintf>
  8006b6:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  8006b9:	83 ec 0c             	sub    $0xc,%esp
  8006bc:	68 08 23 80 00       	push   $0x802308
  8006c1:	e8 e8 02 00 00       	call   8009ae <cprintf>
  8006c6:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  8006c9:	e8 c0 12 00 00       	call   80198e <sys_enable_interrupt>

	// exit gracefully
	exit();
  8006ce:	e8 19 00 00 00       	call   8006ec <exit>
}
  8006d3:	90                   	nop
  8006d4:	c9                   	leave  
  8006d5:	c3                   	ret    

008006d6 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  8006d6:	55                   	push   %ebp
  8006d7:	89 e5                	mov    %esp,%ebp
  8006d9:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  8006dc:	83 ec 0c             	sub    $0xc,%esp
  8006df:	6a 00                	push   $0x0
  8006e1:	e8 bf 10 00 00       	call   8017a5 <sys_env_destroy>
  8006e6:	83 c4 10             	add    $0x10,%esp
}
  8006e9:	90                   	nop
  8006ea:	c9                   	leave  
  8006eb:	c3                   	ret    

008006ec <exit>:

void
exit(void)
{
  8006ec:	55                   	push   %ebp
  8006ed:	89 e5                	mov    %esp,%ebp
  8006ef:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  8006f2:	e8 14 11 00 00       	call   80180b <sys_env_exit>
}
  8006f7:	90                   	nop
  8006f8:	c9                   	leave  
  8006f9:	c3                   	ret    

008006fa <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  8006fa:	55                   	push   %ebp
  8006fb:	89 e5                	mov    %esp,%ebp
  8006fd:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  800700:	8d 45 10             	lea    0x10(%ebp),%eax
  800703:	83 c0 04             	add    $0x4,%eax
  800706:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800709:	a1 18 31 80 00       	mov    0x803118,%eax
  80070e:	85 c0                	test   %eax,%eax
  800710:	74 16                	je     800728 <_panic+0x2e>
		cprintf("%s: ", argv0);
  800712:	a1 18 31 80 00       	mov    0x803118,%eax
  800717:	83 ec 08             	sub    $0x8,%esp
  80071a:	50                   	push   %eax
  80071b:	68 b0 23 80 00       	push   $0x8023b0
  800720:	e8 89 02 00 00       	call   8009ae <cprintf>
  800725:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800728:	a1 00 30 80 00       	mov    0x803000,%eax
  80072d:	ff 75 0c             	pushl  0xc(%ebp)
  800730:	ff 75 08             	pushl  0x8(%ebp)
  800733:	50                   	push   %eax
  800734:	68 b5 23 80 00       	push   $0x8023b5
  800739:	e8 70 02 00 00       	call   8009ae <cprintf>
  80073e:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  800741:	8b 45 10             	mov    0x10(%ebp),%eax
  800744:	83 ec 08             	sub    $0x8,%esp
  800747:	ff 75 f4             	pushl  -0xc(%ebp)
  80074a:	50                   	push   %eax
  80074b:	e8 f3 01 00 00       	call   800943 <vcprintf>
  800750:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  800753:	83 ec 08             	sub    $0x8,%esp
  800756:	6a 00                	push   $0x0
  800758:	68 d1 23 80 00       	push   $0x8023d1
  80075d:	e8 e1 01 00 00       	call   800943 <vcprintf>
  800762:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  800765:	e8 82 ff ff ff       	call   8006ec <exit>

	// should not return here
	while (1) ;
  80076a:	eb fe                	jmp    80076a <_panic+0x70>

0080076c <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80076c:	55                   	push   %ebp
  80076d:	89 e5                	mov    %esp,%ebp
  80076f:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  800772:	a1 20 30 80 00       	mov    0x803020,%eax
  800777:	8b 50 74             	mov    0x74(%eax),%edx
  80077a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80077d:	39 c2                	cmp    %eax,%edx
  80077f:	74 14                	je     800795 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  800781:	83 ec 04             	sub    $0x4,%esp
  800784:	68 d4 23 80 00       	push   $0x8023d4
  800789:	6a 26                	push   $0x26
  80078b:	68 20 24 80 00       	push   $0x802420
  800790:	e8 65 ff ff ff       	call   8006fa <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  800795:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  80079c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8007a3:	e9 c2 00 00 00       	jmp    80086a <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8007a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8007ab:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8007b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8007b5:	01 d0                	add    %edx,%eax
  8007b7:	8b 00                	mov    (%eax),%eax
  8007b9:	85 c0                	test   %eax,%eax
  8007bb:	75 08                	jne    8007c5 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8007bd:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8007c0:	e9 a2 00 00 00       	jmp    800867 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8007c5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8007cc:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8007d3:	eb 69                	jmp    80083e <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8007d5:	a1 20 30 80 00       	mov    0x803020,%eax
  8007da:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8007e0:	8b 55 e8             	mov    -0x18(%ebp),%edx
  8007e3:	89 d0                	mov    %edx,%eax
  8007e5:	01 c0                	add    %eax,%eax
  8007e7:	01 d0                	add    %edx,%eax
  8007e9:	c1 e0 03             	shl    $0x3,%eax
  8007ec:	01 c8                	add    %ecx,%eax
  8007ee:	8a 40 04             	mov    0x4(%eax),%al
  8007f1:	84 c0                	test   %al,%al
  8007f3:	75 46                	jne    80083b <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  8007f5:	a1 20 30 80 00       	mov    0x803020,%eax
  8007fa:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800800:	8b 55 e8             	mov    -0x18(%ebp),%edx
  800803:	89 d0                	mov    %edx,%eax
  800805:	01 c0                	add    %eax,%eax
  800807:	01 d0                	add    %edx,%eax
  800809:	c1 e0 03             	shl    $0x3,%eax
  80080c:	01 c8                	add    %ecx,%eax
  80080e:	8b 00                	mov    (%eax),%eax
  800810:	89 45 dc             	mov    %eax,-0x24(%ebp)
  800813:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800816:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80081b:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80081d:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800820:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800827:	8b 45 08             	mov    0x8(%ebp),%eax
  80082a:	01 c8                	add    %ecx,%eax
  80082c:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80082e:	39 c2                	cmp    %eax,%edx
  800830:	75 09                	jne    80083b <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  800832:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800839:	eb 12                	jmp    80084d <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80083b:	ff 45 e8             	incl   -0x18(%ebp)
  80083e:	a1 20 30 80 00       	mov    0x803020,%eax
  800843:	8b 50 74             	mov    0x74(%eax),%edx
  800846:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800849:	39 c2                	cmp    %eax,%edx
  80084b:	77 88                	ja     8007d5 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80084d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  800851:	75 14                	jne    800867 <CheckWSWithoutLastIndex+0xfb>
			panic(
  800853:	83 ec 04             	sub    $0x4,%esp
  800856:	68 2c 24 80 00       	push   $0x80242c
  80085b:	6a 3a                	push   $0x3a
  80085d:	68 20 24 80 00       	push   $0x802420
  800862:	e8 93 fe ff ff       	call   8006fa <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  800867:	ff 45 f0             	incl   -0x10(%ebp)
  80086a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80086d:	3b 45 0c             	cmp    0xc(%ebp),%eax
  800870:	0f 8c 32 ff ff ff    	jl     8007a8 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  800876:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80087d:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  800884:	eb 26                	jmp    8008ac <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  800886:	a1 20 30 80 00       	mov    0x803020,%eax
  80088b:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  800891:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800894:	89 d0                	mov    %edx,%eax
  800896:	01 c0                	add    %eax,%eax
  800898:	01 d0                	add    %edx,%eax
  80089a:	c1 e0 03             	shl    $0x3,%eax
  80089d:	01 c8                	add    %ecx,%eax
  80089f:	8a 40 04             	mov    0x4(%eax),%al
  8008a2:	3c 01                	cmp    $0x1,%al
  8008a4:	75 03                	jne    8008a9 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8008a6:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8008a9:	ff 45 e0             	incl   -0x20(%ebp)
  8008ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8008b1:	8b 50 74             	mov    0x74(%eax),%edx
  8008b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008b7:	39 c2                	cmp    %eax,%edx
  8008b9:	77 cb                	ja     800886 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8008bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8008be:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8008c1:	74 14                	je     8008d7 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8008c3:	83 ec 04             	sub    $0x4,%esp
  8008c6:	68 80 24 80 00       	push   $0x802480
  8008cb:	6a 44                	push   $0x44
  8008cd:	68 20 24 80 00       	push   $0x802420
  8008d2:	e8 23 fe ff ff       	call   8006fa <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8008d7:	90                   	nop
  8008d8:	c9                   	leave  
  8008d9:	c3                   	ret    

008008da <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  8008da:	55                   	push   %ebp
  8008db:	89 e5                	mov    %esp,%ebp
  8008dd:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  8008e0:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008e3:	8b 00                	mov    (%eax),%eax
  8008e5:	8d 48 01             	lea    0x1(%eax),%ecx
  8008e8:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008eb:	89 0a                	mov    %ecx,(%edx)
  8008ed:	8b 55 08             	mov    0x8(%ebp),%edx
  8008f0:	88 d1                	mov    %dl,%cl
  8008f2:	8b 55 0c             	mov    0xc(%ebp),%edx
  8008f5:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  8008f9:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008fc:	8b 00                	mov    (%eax),%eax
  8008fe:	3d ff 00 00 00       	cmp    $0xff,%eax
  800903:	75 2c                	jne    800931 <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800905:	a0 24 30 80 00       	mov    0x803024,%al
  80090a:	0f b6 c0             	movzbl %al,%eax
  80090d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800910:	8b 12                	mov    (%edx),%edx
  800912:	89 d1                	mov    %edx,%ecx
  800914:	8b 55 0c             	mov    0xc(%ebp),%edx
  800917:	83 c2 08             	add    $0x8,%edx
  80091a:	83 ec 04             	sub    $0x4,%esp
  80091d:	50                   	push   %eax
  80091e:	51                   	push   %ecx
  80091f:	52                   	push   %edx
  800920:	e8 3e 0e 00 00       	call   801763 <sys_cputs>
  800925:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800928:	8b 45 0c             	mov    0xc(%ebp),%eax
  80092b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  800931:	8b 45 0c             	mov    0xc(%ebp),%eax
  800934:	8b 40 04             	mov    0x4(%eax),%eax
  800937:	8d 50 01             	lea    0x1(%eax),%edx
  80093a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80093d:	89 50 04             	mov    %edx,0x4(%eax)
}
  800940:	90                   	nop
  800941:	c9                   	leave  
  800942:	c3                   	ret    

00800943 <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  800943:	55                   	push   %ebp
  800944:	89 e5                	mov    %esp,%ebp
  800946:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  80094c:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  800953:	00 00 00 
	b.cnt = 0;
  800956:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  80095d:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  800960:	ff 75 0c             	pushl  0xc(%ebp)
  800963:	ff 75 08             	pushl  0x8(%ebp)
  800966:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80096c:	50                   	push   %eax
  80096d:	68 da 08 80 00       	push   $0x8008da
  800972:	e8 11 02 00 00       	call   800b88 <vprintfmt>
  800977:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  80097a:	a0 24 30 80 00       	mov    0x803024,%al
  80097f:	0f b6 c0             	movzbl %al,%eax
  800982:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800988:	83 ec 04             	sub    $0x4,%esp
  80098b:	50                   	push   %eax
  80098c:	52                   	push   %edx
  80098d:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  800993:	83 c0 08             	add    $0x8,%eax
  800996:	50                   	push   %eax
  800997:	e8 c7 0d 00 00       	call   801763 <sys_cputs>
  80099c:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  80099f:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8009a6:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8009ac:	c9                   	leave  
  8009ad:	c3                   	ret    

008009ae <cprintf>:

int cprintf(const char *fmt, ...) {
  8009ae:	55                   	push   %ebp
  8009af:	89 e5                	mov    %esp,%ebp
  8009b1:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8009b4:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  8009bb:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009be:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c4:	83 ec 08             	sub    $0x8,%esp
  8009c7:	ff 75 f4             	pushl  -0xc(%ebp)
  8009ca:	50                   	push   %eax
  8009cb:	e8 73 ff ff ff       	call   800943 <vcprintf>
  8009d0:	83 c4 10             	add    $0x10,%esp
  8009d3:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  8009d6:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009d9:	c9                   	leave  
  8009da:	c3                   	ret    

008009db <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  8009db:	55                   	push   %ebp
  8009dc:	89 e5                	mov    %esp,%ebp
  8009de:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  8009e1:	e8 8e 0f 00 00       	call   801974 <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  8009e6:	8d 45 0c             	lea    0xc(%ebp),%eax
  8009e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  8009ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ef:	83 ec 08             	sub    $0x8,%esp
  8009f2:	ff 75 f4             	pushl  -0xc(%ebp)
  8009f5:	50                   	push   %eax
  8009f6:	e8 48 ff ff ff       	call   800943 <vcprintf>
  8009fb:	83 c4 10             	add    $0x10,%esp
  8009fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  800a01:	e8 88 0f 00 00       	call   80198e <sys_enable_interrupt>
	return cnt;
  800a06:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800a09:	c9                   	leave  
  800a0a:	c3                   	ret    

00800a0b <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800a0b:	55                   	push   %ebp
  800a0c:	89 e5                	mov    %esp,%ebp
  800a0e:	53                   	push   %ebx
  800a0f:	83 ec 14             	sub    $0x14,%esp
  800a12:	8b 45 10             	mov    0x10(%ebp),%eax
  800a15:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a18:	8b 45 14             	mov    0x14(%ebp),%eax
  800a1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800a1e:	8b 45 18             	mov    0x18(%ebp),%eax
  800a21:	ba 00 00 00 00       	mov    $0x0,%edx
  800a26:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a29:	77 55                	ja     800a80 <printnum+0x75>
  800a2b:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800a2e:	72 05                	jb     800a35 <printnum+0x2a>
  800a30:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800a33:	77 4b                	ja     800a80 <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800a35:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800a38:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800a3b:	8b 45 18             	mov    0x18(%ebp),%eax
  800a3e:	ba 00 00 00 00       	mov    $0x0,%edx
  800a43:	52                   	push   %edx
  800a44:	50                   	push   %eax
  800a45:	ff 75 f4             	pushl  -0xc(%ebp)
  800a48:	ff 75 f0             	pushl  -0x10(%ebp)
  800a4b:	e8 64 13 00 00       	call   801db4 <__udivdi3>
  800a50:	83 c4 10             	add    $0x10,%esp
  800a53:	83 ec 04             	sub    $0x4,%esp
  800a56:	ff 75 20             	pushl  0x20(%ebp)
  800a59:	53                   	push   %ebx
  800a5a:	ff 75 18             	pushl  0x18(%ebp)
  800a5d:	52                   	push   %edx
  800a5e:	50                   	push   %eax
  800a5f:	ff 75 0c             	pushl  0xc(%ebp)
  800a62:	ff 75 08             	pushl  0x8(%ebp)
  800a65:	e8 a1 ff ff ff       	call   800a0b <printnum>
  800a6a:	83 c4 20             	add    $0x20,%esp
  800a6d:	eb 1a                	jmp    800a89 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  800a6f:	83 ec 08             	sub    $0x8,%esp
  800a72:	ff 75 0c             	pushl  0xc(%ebp)
  800a75:	ff 75 20             	pushl  0x20(%ebp)
  800a78:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7b:	ff d0                	call   *%eax
  800a7d:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  800a80:	ff 4d 1c             	decl   0x1c(%ebp)
  800a83:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800a87:	7f e6                	jg     800a6f <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800a89:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800a8c:	bb 00 00 00 00       	mov    $0x0,%ebx
  800a91:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a94:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a97:	53                   	push   %ebx
  800a98:	51                   	push   %ecx
  800a99:	52                   	push   %edx
  800a9a:	50                   	push   %eax
  800a9b:	e8 24 14 00 00       	call   801ec4 <__umoddi3>
  800aa0:	83 c4 10             	add    $0x10,%esp
  800aa3:	05 f4 26 80 00       	add    $0x8026f4,%eax
  800aa8:	8a 00                	mov    (%eax),%al
  800aaa:	0f be c0             	movsbl %al,%eax
  800aad:	83 ec 08             	sub    $0x8,%esp
  800ab0:	ff 75 0c             	pushl  0xc(%ebp)
  800ab3:	50                   	push   %eax
  800ab4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab7:	ff d0                	call   *%eax
  800ab9:	83 c4 10             	add    $0x10,%esp
}
  800abc:	90                   	nop
  800abd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  800ac0:	c9                   	leave  
  800ac1:	c3                   	ret    

00800ac2 <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  800ac2:	55                   	push   %ebp
  800ac3:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800ac5:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800ac9:	7e 1c                	jle    800ae7 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800acb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ace:	8b 00                	mov    (%eax),%eax
  800ad0:	8d 50 08             	lea    0x8(%eax),%edx
  800ad3:	8b 45 08             	mov    0x8(%ebp),%eax
  800ad6:	89 10                	mov    %edx,(%eax)
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8b 00                	mov    (%eax),%eax
  800add:	83 e8 08             	sub    $0x8,%eax
  800ae0:	8b 50 04             	mov    0x4(%eax),%edx
  800ae3:	8b 00                	mov    (%eax),%eax
  800ae5:	eb 40                	jmp    800b27 <getuint+0x65>
	else if (lflag)
  800ae7:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800aeb:	74 1e                	je     800b0b <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800aed:	8b 45 08             	mov    0x8(%ebp),%eax
  800af0:	8b 00                	mov    (%eax),%eax
  800af2:	8d 50 04             	lea    0x4(%eax),%edx
  800af5:	8b 45 08             	mov    0x8(%ebp),%eax
  800af8:	89 10                	mov    %edx,(%eax)
  800afa:	8b 45 08             	mov    0x8(%ebp),%eax
  800afd:	8b 00                	mov    (%eax),%eax
  800aff:	83 e8 04             	sub    $0x4,%eax
  800b02:	8b 00                	mov    (%eax),%eax
  800b04:	ba 00 00 00 00       	mov    $0x0,%edx
  800b09:	eb 1c                	jmp    800b27 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	8b 00                	mov    (%eax),%eax
  800b10:	8d 50 04             	lea    0x4(%eax),%edx
  800b13:	8b 45 08             	mov    0x8(%ebp),%eax
  800b16:	89 10                	mov    %edx,(%eax)
  800b18:	8b 45 08             	mov    0x8(%ebp),%eax
  800b1b:	8b 00                	mov    (%eax),%eax
  800b1d:	83 e8 04             	sub    $0x4,%eax
  800b20:	8b 00                	mov    (%eax),%eax
  800b22:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800b27:	5d                   	pop    %ebp
  800b28:	c3                   	ret    

00800b29 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800b29:	55                   	push   %ebp
  800b2a:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800b2c:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800b30:	7e 1c                	jle    800b4e <getint+0x25>
		return va_arg(*ap, long long);
  800b32:	8b 45 08             	mov    0x8(%ebp),%eax
  800b35:	8b 00                	mov    (%eax),%eax
  800b37:	8d 50 08             	lea    0x8(%eax),%edx
  800b3a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b3d:	89 10                	mov    %edx,(%eax)
  800b3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800b42:	8b 00                	mov    (%eax),%eax
  800b44:	83 e8 08             	sub    $0x8,%eax
  800b47:	8b 50 04             	mov    0x4(%eax),%edx
  800b4a:	8b 00                	mov    (%eax),%eax
  800b4c:	eb 38                	jmp    800b86 <getint+0x5d>
	else if (lflag)
  800b4e:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800b52:	74 1a                	je     800b6e <getint+0x45>
		return va_arg(*ap, long);
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	8b 00                	mov    (%eax),%eax
  800b59:	8d 50 04             	lea    0x4(%eax),%edx
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	89 10                	mov    %edx,(%eax)
  800b61:	8b 45 08             	mov    0x8(%ebp),%eax
  800b64:	8b 00                	mov    (%eax),%eax
  800b66:	83 e8 04             	sub    $0x4,%eax
  800b69:	8b 00                	mov    (%eax),%eax
  800b6b:	99                   	cltd   
  800b6c:	eb 18                	jmp    800b86 <getint+0x5d>
	else
		return va_arg(*ap, int);
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
}
  800b86:	5d                   	pop    %ebp
  800b87:	c3                   	ret    

00800b88 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800b88:	55                   	push   %ebp
  800b89:	89 e5                	mov    %esp,%ebp
  800b8b:	56                   	push   %esi
  800b8c:	53                   	push   %ebx
  800b8d:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800b90:	eb 17                	jmp    800ba9 <vprintfmt+0x21>
			if (ch == '\0')
  800b92:	85 db                	test   %ebx,%ebx
  800b94:	0f 84 af 03 00 00    	je     800f49 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800b9a:	83 ec 08             	sub    $0x8,%esp
  800b9d:	ff 75 0c             	pushl  0xc(%ebp)
  800ba0:	53                   	push   %ebx
  800ba1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba4:	ff d0                	call   *%eax
  800ba6:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800ba9:	8b 45 10             	mov    0x10(%ebp),%eax
  800bac:	8d 50 01             	lea    0x1(%eax),%edx
  800baf:	89 55 10             	mov    %edx,0x10(%ebp)
  800bb2:	8a 00                	mov    (%eax),%al
  800bb4:	0f b6 d8             	movzbl %al,%ebx
  800bb7:	83 fb 25             	cmp    $0x25,%ebx
  800bba:	75 d6                	jne    800b92 <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800bbc:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  800bc0:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800bc7:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800bce:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800bd5:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800bdc:	8b 45 10             	mov    0x10(%ebp),%eax
  800bdf:	8d 50 01             	lea    0x1(%eax),%edx
  800be2:	89 55 10             	mov    %edx,0x10(%ebp)
  800be5:	8a 00                	mov    (%eax),%al
  800be7:	0f b6 d8             	movzbl %al,%ebx
  800bea:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800bed:	83 f8 55             	cmp    $0x55,%eax
  800bf0:	0f 87 2b 03 00 00    	ja     800f21 <vprintfmt+0x399>
  800bf6:	8b 04 85 18 27 80 00 	mov    0x802718(,%eax,4),%eax
  800bfd:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800bff:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  800c03:	eb d7                	jmp    800bdc <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800c05:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800c09:	eb d1                	jmp    800bdc <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c0b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  800c12:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800c15:	89 d0                	mov    %edx,%eax
  800c17:	c1 e0 02             	shl    $0x2,%eax
  800c1a:	01 d0                	add    %edx,%eax
  800c1c:	01 c0                	add    %eax,%eax
  800c1e:	01 d8                	add    %ebx,%eax
  800c20:	83 e8 30             	sub    $0x30,%eax
  800c23:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800c26:	8b 45 10             	mov    0x10(%ebp),%eax
  800c29:	8a 00                	mov    (%eax),%al
  800c2b:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800c2e:	83 fb 2f             	cmp    $0x2f,%ebx
  800c31:	7e 3e                	jle    800c71 <vprintfmt+0xe9>
  800c33:	83 fb 39             	cmp    $0x39,%ebx
  800c36:	7f 39                	jg     800c71 <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800c38:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800c3b:	eb d5                	jmp    800c12 <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800c3d:	8b 45 14             	mov    0x14(%ebp),%eax
  800c40:	83 c0 04             	add    $0x4,%eax
  800c43:	89 45 14             	mov    %eax,0x14(%ebp)
  800c46:	8b 45 14             	mov    0x14(%ebp),%eax
  800c49:	83 e8 04             	sub    $0x4,%eax
  800c4c:	8b 00                	mov    (%eax),%eax
  800c4e:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  800c51:	eb 1f                	jmp    800c72 <vprintfmt+0xea>

		case '.':
			if (width < 0)
  800c53:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c57:	79 83                	jns    800bdc <vprintfmt+0x54>
				width = 0;
  800c59:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  800c60:	e9 77 ff ff ff       	jmp    800bdc <vprintfmt+0x54>

		case '#':
			altflag = 1;
  800c65:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  800c6c:	e9 6b ff ff ff       	jmp    800bdc <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  800c71:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  800c72:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800c76:	0f 89 60 ff ff ff    	jns    800bdc <vprintfmt+0x54>
				width = precision, precision = -1;
  800c7c:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800c7f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  800c82:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800c89:	e9 4e ff ff ff       	jmp    800bdc <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800c8e:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  800c91:	e9 46 ff ff ff       	jmp    800bdc <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800c96:	8b 45 14             	mov    0x14(%ebp),%eax
  800c99:	83 c0 04             	add    $0x4,%eax
  800c9c:	89 45 14             	mov    %eax,0x14(%ebp)
  800c9f:	8b 45 14             	mov    0x14(%ebp),%eax
  800ca2:	83 e8 04             	sub    $0x4,%eax
  800ca5:	8b 00                	mov    (%eax),%eax
  800ca7:	83 ec 08             	sub    $0x8,%esp
  800caa:	ff 75 0c             	pushl  0xc(%ebp)
  800cad:	50                   	push   %eax
  800cae:	8b 45 08             	mov    0x8(%ebp),%eax
  800cb1:	ff d0                	call   *%eax
  800cb3:	83 c4 10             	add    $0x10,%esp
			break;
  800cb6:	e9 89 02 00 00       	jmp    800f44 <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800cbb:	8b 45 14             	mov    0x14(%ebp),%eax
  800cbe:	83 c0 04             	add    $0x4,%eax
  800cc1:	89 45 14             	mov    %eax,0x14(%ebp)
  800cc4:	8b 45 14             	mov    0x14(%ebp),%eax
  800cc7:	83 e8 04             	sub    $0x4,%eax
  800cca:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800ccc:	85 db                	test   %ebx,%ebx
  800cce:	79 02                	jns    800cd2 <vprintfmt+0x14a>
				err = -err;
  800cd0:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  800cd2:	83 fb 64             	cmp    $0x64,%ebx
  800cd5:	7f 0b                	jg     800ce2 <vprintfmt+0x15a>
  800cd7:	8b 34 9d 60 25 80 00 	mov    0x802560(,%ebx,4),%esi
  800cde:	85 f6                	test   %esi,%esi
  800ce0:	75 19                	jne    800cfb <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  800ce2:	53                   	push   %ebx
  800ce3:	68 05 27 80 00       	push   $0x802705
  800ce8:	ff 75 0c             	pushl  0xc(%ebp)
  800ceb:	ff 75 08             	pushl  0x8(%ebp)
  800cee:	e8 5e 02 00 00       	call   800f51 <printfmt>
  800cf3:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800cf6:	e9 49 02 00 00       	jmp    800f44 <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800cfb:	56                   	push   %esi
  800cfc:	68 0e 27 80 00       	push   $0x80270e
  800d01:	ff 75 0c             	pushl  0xc(%ebp)
  800d04:	ff 75 08             	pushl  0x8(%ebp)
  800d07:	e8 45 02 00 00       	call   800f51 <printfmt>
  800d0c:	83 c4 10             	add    $0x10,%esp
			break;
  800d0f:	e9 30 02 00 00       	jmp    800f44 <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  800d14:	8b 45 14             	mov    0x14(%ebp),%eax
  800d17:	83 c0 04             	add    $0x4,%eax
  800d1a:	89 45 14             	mov    %eax,0x14(%ebp)
  800d1d:	8b 45 14             	mov    0x14(%ebp),%eax
  800d20:	83 e8 04             	sub    $0x4,%eax
  800d23:	8b 30                	mov    (%eax),%esi
  800d25:	85 f6                	test   %esi,%esi
  800d27:	75 05                	jne    800d2e <vprintfmt+0x1a6>
				p = "(null)";
  800d29:	be 11 27 80 00       	mov    $0x802711,%esi
			if (width > 0 && padc != '-')
  800d2e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d32:	7e 6d                	jle    800da1 <vprintfmt+0x219>
  800d34:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800d38:	74 67                	je     800da1 <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800d3a:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800d3d:	83 ec 08             	sub    $0x8,%esp
  800d40:	50                   	push   %eax
  800d41:	56                   	push   %esi
  800d42:	e8 0c 03 00 00       	call   801053 <strnlen>
  800d47:	83 c4 10             	add    $0x10,%esp
  800d4a:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800d4d:	eb 16                	jmp    800d65 <vprintfmt+0x1dd>
					putch(padc, putdat);
  800d4f:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  800d53:	83 ec 08             	sub    $0x8,%esp
  800d56:	ff 75 0c             	pushl  0xc(%ebp)
  800d59:	50                   	push   %eax
  800d5a:	8b 45 08             	mov    0x8(%ebp),%eax
  800d5d:	ff d0                	call   *%eax
  800d5f:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  800d62:	ff 4d e4             	decl   -0x1c(%ebp)
  800d65:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800d69:	7f e4                	jg     800d4f <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d6b:	eb 34                	jmp    800da1 <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  800d6d:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  800d71:	74 1c                	je     800d8f <vprintfmt+0x207>
  800d73:	83 fb 1f             	cmp    $0x1f,%ebx
  800d76:	7e 05                	jle    800d7d <vprintfmt+0x1f5>
  800d78:	83 fb 7e             	cmp    $0x7e,%ebx
  800d7b:	7e 12                	jle    800d8f <vprintfmt+0x207>
					putch('?', putdat);
  800d7d:	83 ec 08             	sub    $0x8,%esp
  800d80:	ff 75 0c             	pushl  0xc(%ebp)
  800d83:	6a 3f                	push   $0x3f
  800d85:	8b 45 08             	mov    0x8(%ebp),%eax
  800d88:	ff d0                	call   *%eax
  800d8a:	83 c4 10             	add    $0x10,%esp
  800d8d:	eb 0f                	jmp    800d9e <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800d8f:	83 ec 08             	sub    $0x8,%esp
  800d92:	ff 75 0c             	pushl  0xc(%ebp)
  800d95:	53                   	push   %ebx
  800d96:	8b 45 08             	mov    0x8(%ebp),%eax
  800d99:	ff d0                	call   *%eax
  800d9b:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800d9e:	ff 4d e4             	decl   -0x1c(%ebp)
  800da1:	89 f0                	mov    %esi,%eax
  800da3:	8d 70 01             	lea    0x1(%eax),%esi
  800da6:	8a 00                	mov    (%eax),%al
  800da8:	0f be d8             	movsbl %al,%ebx
  800dab:	85 db                	test   %ebx,%ebx
  800dad:	74 24                	je     800dd3 <vprintfmt+0x24b>
  800daf:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800db3:	78 b8                	js     800d6d <vprintfmt+0x1e5>
  800db5:	ff 4d e0             	decl   -0x20(%ebp)
  800db8:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800dbc:	79 af                	jns    800d6d <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dbe:	eb 13                	jmp    800dd3 <vprintfmt+0x24b>
				putch(' ', putdat);
  800dc0:	83 ec 08             	sub    $0x8,%esp
  800dc3:	ff 75 0c             	pushl  0xc(%ebp)
  800dc6:	6a 20                	push   $0x20
  800dc8:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcb:	ff d0                	call   *%eax
  800dcd:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800dd0:	ff 4d e4             	decl   -0x1c(%ebp)
  800dd3:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800dd7:	7f e7                	jg     800dc0 <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800dd9:	e9 66 01 00 00       	jmp    800f44 <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800dde:	83 ec 08             	sub    $0x8,%esp
  800de1:	ff 75 e8             	pushl  -0x18(%ebp)
  800de4:	8d 45 14             	lea    0x14(%ebp),%eax
  800de7:	50                   	push   %eax
  800de8:	e8 3c fd ff ff       	call   800b29 <getint>
  800ded:	83 c4 10             	add    $0x10,%esp
  800df0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800df3:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800df6:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800df9:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800dfc:	85 d2                	test   %edx,%edx
  800dfe:	79 23                	jns    800e23 <vprintfmt+0x29b>
				putch('-', putdat);
  800e00:	83 ec 08             	sub    $0x8,%esp
  800e03:	ff 75 0c             	pushl  0xc(%ebp)
  800e06:	6a 2d                	push   $0x2d
  800e08:	8b 45 08             	mov    0x8(%ebp),%eax
  800e0b:	ff d0                	call   *%eax
  800e0d:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800e10:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800e13:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800e16:	f7 d8                	neg    %eax
  800e18:	83 d2 00             	adc    $0x0,%edx
  800e1b:	f7 da                	neg    %edx
  800e1d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e20:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800e23:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e2a:	e9 bc 00 00 00       	jmp    800eeb <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800e2f:	83 ec 08             	sub    $0x8,%esp
  800e32:	ff 75 e8             	pushl  -0x18(%ebp)
  800e35:	8d 45 14             	lea    0x14(%ebp),%eax
  800e38:	50                   	push   %eax
  800e39:	e8 84 fc ff ff       	call   800ac2 <getuint>
  800e3e:	83 c4 10             	add    $0x10,%esp
  800e41:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800e44:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800e47:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800e4e:	e9 98 00 00 00       	jmp    800eeb <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800e53:	83 ec 08             	sub    $0x8,%esp
  800e56:	ff 75 0c             	pushl  0xc(%ebp)
  800e59:	6a 58                	push   $0x58
  800e5b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5e:	ff d0                	call   *%eax
  800e60:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e63:	83 ec 08             	sub    $0x8,%esp
  800e66:	ff 75 0c             	pushl  0xc(%ebp)
  800e69:	6a 58                	push   $0x58
  800e6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e6e:	ff d0                	call   *%eax
  800e70:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800e73:	83 ec 08             	sub    $0x8,%esp
  800e76:	ff 75 0c             	pushl  0xc(%ebp)
  800e79:	6a 58                	push   $0x58
  800e7b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e7e:	ff d0                	call   *%eax
  800e80:	83 c4 10             	add    $0x10,%esp
			break;
  800e83:	e9 bc 00 00 00       	jmp    800f44 <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800e88:	83 ec 08             	sub    $0x8,%esp
  800e8b:	ff 75 0c             	pushl  0xc(%ebp)
  800e8e:	6a 30                	push   $0x30
  800e90:	8b 45 08             	mov    0x8(%ebp),%eax
  800e93:	ff d0                	call   *%eax
  800e95:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800e98:	83 ec 08             	sub    $0x8,%esp
  800e9b:	ff 75 0c             	pushl  0xc(%ebp)
  800e9e:	6a 78                	push   $0x78
  800ea0:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea3:	ff d0                	call   *%eax
  800ea5:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800ea8:	8b 45 14             	mov    0x14(%ebp),%eax
  800eab:	83 c0 04             	add    $0x4,%eax
  800eae:	89 45 14             	mov    %eax,0x14(%ebp)
  800eb1:	8b 45 14             	mov    0x14(%ebp),%eax
  800eb4:	83 e8 04             	sub    $0x4,%eax
  800eb7:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800eb9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ebc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800ec3:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800eca:	eb 1f                	jmp    800eeb <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800ecc:	83 ec 08             	sub    $0x8,%esp
  800ecf:	ff 75 e8             	pushl  -0x18(%ebp)
  800ed2:	8d 45 14             	lea    0x14(%ebp),%eax
  800ed5:	50                   	push   %eax
  800ed6:	e8 e7 fb ff ff       	call   800ac2 <getuint>
  800edb:	83 c4 10             	add    $0x10,%esp
  800ede:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800ee1:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800ee4:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800eeb:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800eef:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ef2:	83 ec 04             	sub    $0x4,%esp
  800ef5:	52                   	push   %edx
  800ef6:	ff 75 e4             	pushl  -0x1c(%ebp)
  800ef9:	50                   	push   %eax
  800efa:	ff 75 f4             	pushl  -0xc(%ebp)
  800efd:	ff 75 f0             	pushl  -0x10(%ebp)
  800f00:	ff 75 0c             	pushl  0xc(%ebp)
  800f03:	ff 75 08             	pushl  0x8(%ebp)
  800f06:	e8 00 fb ff ff       	call   800a0b <printnum>
  800f0b:	83 c4 20             	add    $0x20,%esp
			break;
  800f0e:	eb 34                	jmp    800f44 <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800f10:	83 ec 08             	sub    $0x8,%esp
  800f13:	ff 75 0c             	pushl  0xc(%ebp)
  800f16:	53                   	push   %ebx
  800f17:	8b 45 08             	mov    0x8(%ebp),%eax
  800f1a:	ff d0                	call   *%eax
  800f1c:	83 c4 10             	add    $0x10,%esp
			break;
  800f1f:	eb 23                	jmp    800f44 <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800f21:	83 ec 08             	sub    $0x8,%esp
  800f24:	ff 75 0c             	pushl  0xc(%ebp)
  800f27:	6a 25                	push   $0x25
  800f29:	8b 45 08             	mov    0x8(%ebp),%eax
  800f2c:	ff d0                	call   *%eax
  800f2e:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800f31:	ff 4d 10             	decl   0x10(%ebp)
  800f34:	eb 03                	jmp    800f39 <vprintfmt+0x3b1>
  800f36:	ff 4d 10             	decl   0x10(%ebp)
  800f39:	8b 45 10             	mov    0x10(%ebp),%eax
  800f3c:	48                   	dec    %eax
  800f3d:	8a 00                	mov    (%eax),%al
  800f3f:	3c 25                	cmp    $0x25,%al
  800f41:	75 f3                	jne    800f36 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800f43:	90                   	nop
		}
	}
  800f44:	e9 47 fc ff ff       	jmp    800b90 <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800f49:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800f4a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800f4d:	5b                   	pop    %ebx
  800f4e:	5e                   	pop    %esi
  800f4f:	5d                   	pop    %ebp
  800f50:	c3                   	ret    

00800f51 <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
  800f54:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800f57:	8d 45 10             	lea    0x10(%ebp),%eax
  800f5a:	83 c0 04             	add    $0x4,%eax
  800f5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800f60:	8b 45 10             	mov    0x10(%ebp),%eax
  800f63:	ff 75 f4             	pushl  -0xc(%ebp)
  800f66:	50                   	push   %eax
  800f67:	ff 75 0c             	pushl  0xc(%ebp)
  800f6a:	ff 75 08             	pushl  0x8(%ebp)
  800f6d:	e8 16 fc ff ff       	call   800b88 <vprintfmt>
  800f72:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800f75:	90                   	nop
  800f76:	c9                   	leave  
  800f77:	c3                   	ret    

00800f78 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800f78:	55                   	push   %ebp
  800f79:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800f7b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f7e:	8b 40 08             	mov    0x8(%eax),%eax
  800f81:	8d 50 01             	lea    0x1(%eax),%edx
  800f84:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f87:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800f8a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f8d:	8b 10                	mov    (%eax),%edx
  800f8f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f92:	8b 40 04             	mov    0x4(%eax),%eax
  800f95:	39 c2                	cmp    %eax,%edx
  800f97:	73 12                	jae    800fab <sprintputch+0x33>
		*b->buf++ = ch;
  800f99:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f9c:	8b 00                	mov    (%eax),%eax
  800f9e:	8d 48 01             	lea    0x1(%eax),%ecx
  800fa1:	8b 55 0c             	mov    0xc(%ebp),%edx
  800fa4:	89 0a                	mov    %ecx,(%edx)
  800fa6:	8b 55 08             	mov    0x8(%ebp),%edx
  800fa9:	88 10                	mov    %dl,(%eax)
}
  800fab:	90                   	nop
  800fac:	5d                   	pop    %ebp
  800fad:	c3                   	ret    

00800fae <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800fae:	55                   	push   %ebp
  800faf:	89 e5                	mov    %esp,%ebp
  800fb1:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800fb4:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb7:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800fba:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbd:	8d 50 ff             	lea    -0x1(%eax),%edx
  800fc0:	8b 45 08             	mov    0x8(%ebp),%eax
  800fc3:	01 d0                	add    %edx,%eax
  800fc5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800fc8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800fcf:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800fd3:	74 06                	je     800fdb <vsnprintf+0x2d>
  800fd5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800fd9:	7f 07                	jg     800fe2 <vsnprintf+0x34>
		return -E_INVAL;
  800fdb:	b8 03 00 00 00       	mov    $0x3,%eax
  800fe0:	eb 20                	jmp    801002 <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800fe2:	ff 75 14             	pushl  0x14(%ebp)
  800fe5:	ff 75 10             	pushl  0x10(%ebp)
  800fe8:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800feb:	50                   	push   %eax
  800fec:	68 78 0f 80 00       	push   $0x800f78
  800ff1:	e8 92 fb ff ff       	call   800b88 <vprintfmt>
  800ff6:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800ff9:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800ffc:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800fff:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  801002:	c9                   	leave  
  801003:	c3                   	ret    

00801004 <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  801004:	55                   	push   %ebp
  801005:	89 e5                	mov    %esp,%ebp
  801007:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  80100a:	8d 45 10             	lea    0x10(%ebp),%eax
  80100d:	83 c0 04             	add    $0x4,%eax
  801010:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  801013:	8b 45 10             	mov    0x10(%ebp),%eax
  801016:	ff 75 f4             	pushl  -0xc(%ebp)
  801019:	50                   	push   %eax
  80101a:	ff 75 0c             	pushl  0xc(%ebp)
  80101d:	ff 75 08             	pushl  0x8(%ebp)
  801020:	e8 89 ff ff ff       	call   800fae <vsnprintf>
  801025:	83 c4 10             	add    $0x10,%esp
  801028:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  80102b:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80102e:	c9                   	leave  
  80102f:	c3                   	ret    

00801030 <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  801030:	55                   	push   %ebp
  801031:	89 e5                	mov    %esp,%ebp
  801033:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  801036:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  80103d:	eb 06                	jmp    801045 <strlen+0x15>
		n++;
  80103f:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  801042:	ff 45 08             	incl   0x8(%ebp)
  801045:	8b 45 08             	mov    0x8(%ebp),%eax
  801048:	8a 00                	mov    (%eax),%al
  80104a:	84 c0                	test   %al,%al
  80104c:	75 f1                	jne    80103f <strlen+0xf>
		n++;
	return n;
  80104e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  801051:	c9                   	leave  
  801052:	c3                   	ret    

00801053 <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  801053:	55                   	push   %ebp
  801054:	89 e5                	mov    %esp,%ebp
  801056:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801059:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801060:	eb 09                	jmp    80106b <strnlen+0x18>
		n++;
  801062:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  801065:	ff 45 08             	incl   0x8(%ebp)
  801068:	ff 4d 0c             	decl   0xc(%ebp)
  80106b:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80106f:	74 09                	je     80107a <strnlen+0x27>
  801071:	8b 45 08             	mov    0x8(%ebp),%eax
  801074:	8a 00                	mov    (%eax),%al
  801076:	84 c0                	test   %al,%al
  801078:	75 e8                	jne    801062 <strnlen+0xf>
		n++;
	return n;
  80107a:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80107d:	c9                   	leave  
  80107e:	c3                   	ret    

0080107f <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  80107f:	55                   	push   %ebp
  801080:	89 e5                	mov    %esp,%ebp
  801082:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  801085:	8b 45 08             	mov    0x8(%ebp),%eax
  801088:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  80108b:	90                   	nop
  80108c:	8b 45 08             	mov    0x8(%ebp),%eax
  80108f:	8d 50 01             	lea    0x1(%eax),%edx
  801092:	89 55 08             	mov    %edx,0x8(%ebp)
  801095:	8b 55 0c             	mov    0xc(%ebp),%edx
  801098:	8d 4a 01             	lea    0x1(%edx),%ecx
  80109b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  80109e:	8a 12                	mov    (%edx),%dl
  8010a0:	88 10                	mov    %dl,(%eax)
  8010a2:	8a 00                	mov    (%eax),%al
  8010a4:	84 c0                	test   %al,%al
  8010a6:	75 e4                	jne    80108c <strcpy+0xd>
		/* do nothing */;
	return ret;
  8010a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8010ab:	c9                   	leave  
  8010ac:	c3                   	ret    

008010ad <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  8010ad:	55                   	push   %ebp
  8010ae:	89 e5                	mov    %esp,%ebp
  8010b0:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  8010b3:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b6:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  8010b9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8010c0:	eb 1f                	jmp    8010e1 <strncpy+0x34>
		*dst++ = *src;
  8010c2:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c5:	8d 50 01             	lea    0x1(%eax),%edx
  8010c8:	89 55 08             	mov    %edx,0x8(%ebp)
  8010cb:	8b 55 0c             	mov    0xc(%ebp),%edx
  8010ce:	8a 12                	mov    (%edx),%dl
  8010d0:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  8010d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8010d5:	8a 00                	mov    (%eax),%al
  8010d7:	84 c0                	test   %al,%al
  8010d9:	74 03                	je     8010de <strncpy+0x31>
			src++;
  8010db:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  8010de:	ff 45 fc             	incl   -0x4(%ebp)
  8010e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8010e4:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010e7:	72 d9                	jb     8010c2 <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  8010e9:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8010ec:	c9                   	leave  
  8010ed:	c3                   	ret    

008010ee <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  8010ee:	55                   	push   %ebp
  8010ef:	89 e5                	mov    %esp,%ebp
  8010f1:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  8010f4:	8b 45 08             	mov    0x8(%ebp),%eax
  8010f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  8010fa:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8010fe:	74 30                	je     801130 <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  801100:	eb 16                	jmp    801118 <strlcpy+0x2a>
			*dst++ = *src++;
  801102:	8b 45 08             	mov    0x8(%ebp),%eax
  801105:	8d 50 01             	lea    0x1(%eax),%edx
  801108:	89 55 08             	mov    %edx,0x8(%ebp)
  80110b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80110e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801111:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  801114:	8a 12                	mov    (%edx),%dl
  801116:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  801118:	ff 4d 10             	decl   0x10(%ebp)
  80111b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80111f:	74 09                	je     80112a <strlcpy+0x3c>
  801121:	8b 45 0c             	mov    0xc(%ebp),%eax
  801124:	8a 00                	mov    (%eax),%al
  801126:	84 c0                	test   %al,%al
  801128:	75 d8                	jne    801102 <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  80112a:	8b 45 08             	mov    0x8(%ebp),%eax
  80112d:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  801130:	8b 55 08             	mov    0x8(%ebp),%edx
  801133:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801136:	29 c2                	sub    %eax,%edx
  801138:	89 d0                	mov    %edx,%eax
}
  80113a:	c9                   	leave  
  80113b:	c3                   	ret    

0080113c <strcmp>:

int
strcmp(const char *p, const char *q)
{
  80113c:	55                   	push   %ebp
  80113d:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  80113f:	eb 06                	jmp    801147 <strcmp+0xb>
		p++, q++;
  801141:	ff 45 08             	incl   0x8(%ebp)
  801144:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  801147:	8b 45 08             	mov    0x8(%ebp),%eax
  80114a:	8a 00                	mov    (%eax),%al
  80114c:	84 c0                	test   %al,%al
  80114e:	74 0e                	je     80115e <strcmp+0x22>
  801150:	8b 45 08             	mov    0x8(%ebp),%eax
  801153:	8a 10                	mov    (%eax),%dl
  801155:	8b 45 0c             	mov    0xc(%ebp),%eax
  801158:	8a 00                	mov    (%eax),%al
  80115a:	38 c2                	cmp    %al,%dl
  80115c:	74 e3                	je     801141 <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  80115e:	8b 45 08             	mov    0x8(%ebp),%eax
  801161:	8a 00                	mov    (%eax),%al
  801163:	0f b6 d0             	movzbl %al,%edx
  801166:	8b 45 0c             	mov    0xc(%ebp),%eax
  801169:	8a 00                	mov    (%eax),%al
  80116b:	0f b6 c0             	movzbl %al,%eax
  80116e:	29 c2                	sub    %eax,%edx
  801170:	89 d0                	mov    %edx,%eax
}
  801172:	5d                   	pop    %ebp
  801173:	c3                   	ret    

00801174 <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  801174:	55                   	push   %ebp
  801175:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  801177:	eb 09                	jmp    801182 <strncmp+0xe>
		n--, p++, q++;
  801179:	ff 4d 10             	decl   0x10(%ebp)
  80117c:	ff 45 08             	incl   0x8(%ebp)
  80117f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  801182:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801186:	74 17                	je     80119f <strncmp+0x2b>
  801188:	8b 45 08             	mov    0x8(%ebp),%eax
  80118b:	8a 00                	mov    (%eax),%al
  80118d:	84 c0                	test   %al,%al
  80118f:	74 0e                	je     80119f <strncmp+0x2b>
  801191:	8b 45 08             	mov    0x8(%ebp),%eax
  801194:	8a 10                	mov    (%eax),%dl
  801196:	8b 45 0c             	mov    0xc(%ebp),%eax
  801199:	8a 00                	mov    (%eax),%al
  80119b:	38 c2                	cmp    %al,%dl
  80119d:	74 da                	je     801179 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  80119f:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8011a3:	75 07                	jne    8011ac <strncmp+0x38>
		return 0;
  8011a5:	b8 00 00 00 00       	mov    $0x0,%eax
  8011aa:	eb 14                	jmp    8011c0 <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  8011ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8011af:	8a 00                	mov    (%eax),%al
  8011b1:	0f b6 d0             	movzbl %al,%edx
  8011b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011b7:	8a 00                	mov    (%eax),%al
  8011b9:	0f b6 c0             	movzbl %al,%eax
  8011bc:	29 c2                	sub    %eax,%edx
  8011be:	89 d0                	mov    %edx,%eax
}
  8011c0:	5d                   	pop    %ebp
  8011c1:	c3                   	ret    

008011c2 <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  8011c2:	55                   	push   %ebp
  8011c3:	89 e5                	mov    %esp,%ebp
  8011c5:	83 ec 04             	sub    $0x4,%esp
  8011c8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011cb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011ce:	eb 12                	jmp    8011e2 <strchr+0x20>
		if (*s == c)
  8011d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8011d3:	8a 00                	mov    (%eax),%al
  8011d5:	3a 45 fc             	cmp    -0x4(%ebp),%al
  8011d8:	75 05                	jne    8011df <strchr+0x1d>
			return (char *) s;
  8011da:	8b 45 08             	mov    0x8(%ebp),%eax
  8011dd:	eb 11                	jmp    8011f0 <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  8011df:	ff 45 08             	incl   0x8(%ebp)
  8011e2:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e5:	8a 00                	mov    (%eax),%al
  8011e7:	84 c0                	test   %al,%al
  8011e9:	75 e5                	jne    8011d0 <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  8011eb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8011f0:	c9                   	leave  
  8011f1:	c3                   	ret    

008011f2 <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  8011f2:	55                   	push   %ebp
  8011f3:	89 e5                	mov    %esp,%ebp
  8011f5:	83 ec 04             	sub    $0x4,%esp
  8011f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011fb:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  8011fe:	eb 0d                	jmp    80120d <strfind+0x1b>
		if (*s == c)
  801200:	8b 45 08             	mov    0x8(%ebp),%eax
  801203:	8a 00                	mov    (%eax),%al
  801205:	3a 45 fc             	cmp    -0x4(%ebp),%al
  801208:	74 0e                	je     801218 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  80120a:	ff 45 08             	incl   0x8(%ebp)
  80120d:	8b 45 08             	mov    0x8(%ebp),%eax
  801210:	8a 00                	mov    (%eax),%al
  801212:	84 c0                	test   %al,%al
  801214:	75 ea                	jne    801200 <strfind+0xe>
  801216:	eb 01                	jmp    801219 <strfind+0x27>
		if (*s == c)
			break;
  801218:	90                   	nop
	return (char *) s;
  801219:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80121c:	c9                   	leave  
  80121d:	c3                   	ret    

0080121e <memset>:


void *
memset(void *v, int c, uint32 n)
{
  80121e:	55                   	push   %ebp
  80121f:	89 e5                	mov    %esp,%ebp
  801221:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  801224:	8b 45 08             	mov    0x8(%ebp),%eax
  801227:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  80122a:	8b 45 10             	mov    0x10(%ebp),%eax
  80122d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  801230:	eb 0e                	jmp    801240 <memset+0x22>
		*p++ = c;
  801232:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801235:	8d 50 01             	lea    0x1(%eax),%edx
  801238:	89 55 fc             	mov    %edx,-0x4(%ebp)
  80123b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80123e:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  801240:	ff 4d f8             	decl   -0x8(%ebp)
  801243:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  801247:	79 e9                	jns    801232 <memset+0x14>
		*p++ = c;

	return v;
  801249:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80124c:	c9                   	leave  
  80124d:	c3                   	ret    

0080124e <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  80124e:	55                   	push   %ebp
  80124f:	89 e5                	mov    %esp,%ebp
  801251:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801254:	8b 45 0c             	mov    0xc(%ebp),%eax
  801257:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  80125a:	8b 45 08             	mov    0x8(%ebp),%eax
  80125d:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  801260:	eb 16                	jmp    801278 <memcpy+0x2a>
		*d++ = *s++;
  801262:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801265:	8d 50 01             	lea    0x1(%eax),%edx
  801268:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80126b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80126e:	8d 4a 01             	lea    0x1(%edx),%ecx
  801271:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  801274:	8a 12                	mov    (%edx),%dl
  801276:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  801278:	8b 45 10             	mov    0x10(%ebp),%eax
  80127b:	8d 50 ff             	lea    -0x1(%eax),%edx
  80127e:	89 55 10             	mov    %edx,0x10(%ebp)
  801281:	85 c0                	test   %eax,%eax
  801283:	75 dd                	jne    801262 <memcpy+0x14>
		*d++ = *s++;

	return dst;
  801285:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801288:	c9                   	leave  
  801289:	c3                   	ret    

0080128a <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  80128a:	55                   	push   %ebp
  80128b:	89 e5                	mov    %esp,%ebp
  80128d:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  801290:	8b 45 0c             	mov    0xc(%ebp),%eax
  801293:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  801296:	8b 45 08             	mov    0x8(%ebp),%eax
  801299:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  80129c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80129f:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012a2:	73 50                	jae    8012f4 <memmove+0x6a>
  8012a4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012aa:	01 d0                	add    %edx,%eax
  8012ac:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  8012af:	76 43                	jbe    8012f4 <memmove+0x6a>
		s += n;
  8012b1:	8b 45 10             	mov    0x10(%ebp),%eax
  8012b4:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  8012b7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ba:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  8012bd:	eb 10                	jmp    8012cf <memmove+0x45>
			*--d = *--s;
  8012bf:	ff 4d f8             	decl   -0x8(%ebp)
  8012c2:	ff 4d fc             	decl   -0x4(%ebp)
  8012c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  8012c8:	8a 10                	mov    (%eax),%dl
  8012ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012cd:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  8012cf:	8b 45 10             	mov    0x10(%ebp),%eax
  8012d2:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012d5:	89 55 10             	mov    %edx,0x10(%ebp)
  8012d8:	85 c0                	test   %eax,%eax
  8012da:	75 e3                	jne    8012bf <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  8012dc:	eb 23                	jmp    801301 <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  8012de:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8012e1:	8d 50 01             	lea    0x1(%eax),%edx
  8012e4:	89 55 f8             	mov    %edx,-0x8(%ebp)
  8012e7:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012ea:	8d 4a 01             	lea    0x1(%edx),%ecx
  8012ed:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  8012f0:	8a 12                	mov    (%edx),%dl
  8012f2:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  8012f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012f7:	8d 50 ff             	lea    -0x1(%eax),%edx
  8012fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8012fd:	85 c0                	test   %eax,%eax
  8012ff:	75 dd                	jne    8012de <memmove+0x54>
			*d++ = *s++;

	return dst;
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
}
  801304:	c9                   	leave  
  801305:	c3                   	ret    

00801306 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  801306:	55                   	push   %ebp
  801307:	89 e5                	mov    %esp,%ebp
  801309:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  80130c:	8b 45 08             	mov    0x8(%ebp),%eax
  80130f:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  801312:	8b 45 0c             	mov    0xc(%ebp),%eax
  801315:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  801318:	eb 2a                	jmp    801344 <memcmp+0x3e>
		if (*s1 != *s2)
  80131a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80131d:	8a 10                	mov    (%eax),%dl
  80131f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801322:	8a 00                	mov    (%eax),%al
  801324:	38 c2                	cmp    %al,%dl
  801326:	74 16                	je     80133e <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  801328:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80132b:	8a 00                	mov    (%eax),%al
  80132d:	0f b6 d0             	movzbl %al,%edx
  801330:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801333:	8a 00                	mov    (%eax),%al
  801335:	0f b6 c0             	movzbl %al,%eax
  801338:	29 c2                	sub    %eax,%edx
  80133a:	89 d0                	mov    %edx,%eax
  80133c:	eb 18                	jmp    801356 <memcmp+0x50>
		s1++, s2++;
  80133e:	ff 45 fc             	incl   -0x4(%ebp)
  801341:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  801344:	8b 45 10             	mov    0x10(%ebp),%eax
  801347:	8d 50 ff             	lea    -0x1(%eax),%edx
  80134a:	89 55 10             	mov    %edx,0x10(%ebp)
  80134d:	85 c0                	test   %eax,%eax
  80134f:	75 c9                	jne    80131a <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  801351:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801356:	c9                   	leave  
  801357:	c3                   	ret    

00801358 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  801358:	55                   	push   %ebp
  801359:	89 e5                	mov    %esp,%ebp
  80135b:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  80135e:	8b 55 08             	mov    0x8(%ebp),%edx
  801361:	8b 45 10             	mov    0x10(%ebp),%eax
  801364:	01 d0                	add    %edx,%eax
  801366:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  801369:	eb 15                	jmp    801380 <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  80136b:	8b 45 08             	mov    0x8(%ebp),%eax
  80136e:	8a 00                	mov    (%eax),%al
  801370:	0f b6 d0             	movzbl %al,%edx
  801373:	8b 45 0c             	mov    0xc(%ebp),%eax
  801376:	0f b6 c0             	movzbl %al,%eax
  801379:	39 c2                	cmp    %eax,%edx
  80137b:	74 0d                	je     80138a <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  80137d:	ff 45 08             	incl   0x8(%ebp)
  801380:	8b 45 08             	mov    0x8(%ebp),%eax
  801383:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  801386:	72 e3                	jb     80136b <memfind+0x13>
  801388:	eb 01                	jmp    80138b <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  80138a:	90                   	nop
	return (void *) s;
  80138b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  80138e:	c9                   	leave  
  80138f:	c3                   	ret    

00801390 <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  801390:	55                   	push   %ebp
  801391:	89 e5                	mov    %esp,%ebp
  801393:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  801396:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  80139d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013a4:	eb 03                	jmp    8013a9 <strtol+0x19>
		s++;
  8013a6:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  8013a9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013ac:	8a 00                	mov    (%eax),%al
  8013ae:	3c 20                	cmp    $0x20,%al
  8013b0:	74 f4                	je     8013a6 <strtol+0x16>
  8013b2:	8b 45 08             	mov    0x8(%ebp),%eax
  8013b5:	8a 00                	mov    (%eax),%al
  8013b7:	3c 09                	cmp    $0x9,%al
  8013b9:	74 eb                	je     8013a6 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  8013bb:	8b 45 08             	mov    0x8(%ebp),%eax
  8013be:	8a 00                	mov    (%eax),%al
  8013c0:	3c 2b                	cmp    $0x2b,%al
  8013c2:	75 05                	jne    8013c9 <strtol+0x39>
		s++;
  8013c4:	ff 45 08             	incl   0x8(%ebp)
  8013c7:	eb 13                	jmp    8013dc <strtol+0x4c>
	else if (*s == '-')
  8013c9:	8b 45 08             	mov    0x8(%ebp),%eax
  8013cc:	8a 00                	mov    (%eax),%al
  8013ce:	3c 2d                	cmp    $0x2d,%al
  8013d0:	75 0a                	jne    8013dc <strtol+0x4c>
		s++, neg = 1;
  8013d2:	ff 45 08             	incl   0x8(%ebp)
  8013d5:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  8013dc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  8013e0:	74 06                	je     8013e8 <strtol+0x58>
  8013e2:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  8013e6:	75 20                	jne    801408 <strtol+0x78>
  8013e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8013eb:	8a 00                	mov    (%eax),%al
  8013ed:	3c 30                	cmp    $0x30,%al
  8013ef:	75 17                	jne    801408 <strtol+0x78>
  8013f1:	8b 45 08             	mov    0x8(%ebp),%eax
  8013f4:	40                   	inc    %eax
  8013f5:	8a 00                	mov    (%eax),%al
  8013f7:	3c 78                	cmp    $0x78,%al
  8013f9:	75 0d                	jne    801408 <strtol+0x78>
		s += 2, base = 16;
  8013fb:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  8013ff:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801406:	eb 28                	jmp    801430 <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801408:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80140c:	75 15                	jne    801423 <strtol+0x93>
  80140e:	8b 45 08             	mov    0x8(%ebp),%eax
  801411:	8a 00                	mov    (%eax),%al
  801413:	3c 30                	cmp    $0x30,%al
  801415:	75 0c                	jne    801423 <strtol+0x93>
		s++, base = 8;
  801417:	ff 45 08             	incl   0x8(%ebp)
  80141a:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  801421:	eb 0d                	jmp    801430 <strtol+0xa0>
	else if (base == 0)
  801423:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801427:	75 07                	jne    801430 <strtol+0xa0>
		base = 10;
  801429:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  801430:	8b 45 08             	mov    0x8(%ebp),%eax
  801433:	8a 00                	mov    (%eax),%al
  801435:	3c 2f                	cmp    $0x2f,%al
  801437:	7e 19                	jle    801452 <strtol+0xc2>
  801439:	8b 45 08             	mov    0x8(%ebp),%eax
  80143c:	8a 00                	mov    (%eax),%al
  80143e:	3c 39                	cmp    $0x39,%al
  801440:	7f 10                	jg     801452 <strtol+0xc2>
			dig = *s - '0';
  801442:	8b 45 08             	mov    0x8(%ebp),%eax
  801445:	8a 00                	mov    (%eax),%al
  801447:	0f be c0             	movsbl %al,%eax
  80144a:	83 e8 30             	sub    $0x30,%eax
  80144d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801450:	eb 42                	jmp    801494 <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  801452:	8b 45 08             	mov    0x8(%ebp),%eax
  801455:	8a 00                	mov    (%eax),%al
  801457:	3c 60                	cmp    $0x60,%al
  801459:	7e 19                	jle    801474 <strtol+0xe4>
  80145b:	8b 45 08             	mov    0x8(%ebp),%eax
  80145e:	8a 00                	mov    (%eax),%al
  801460:	3c 7a                	cmp    $0x7a,%al
  801462:	7f 10                	jg     801474 <strtol+0xe4>
			dig = *s - 'a' + 10;
  801464:	8b 45 08             	mov    0x8(%ebp),%eax
  801467:	8a 00                	mov    (%eax),%al
  801469:	0f be c0             	movsbl %al,%eax
  80146c:	83 e8 57             	sub    $0x57,%eax
  80146f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  801472:	eb 20                	jmp    801494 <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	8a 00                	mov    (%eax),%al
  801479:	3c 40                	cmp    $0x40,%al
  80147b:	7e 39                	jle    8014b6 <strtol+0x126>
  80147d:	8b 45 08             	mov    0x8(%ebp),%eax
  801480:	8a 00                	mov    (%eax),%al
  801482:	3c 5a                	cmp    $0x5a,%al
  801484:	7f 30                	jg     8014b6 <strtol+0x126>
			dig = *s - 'A' + 10;
  801486:	8b 45 08             	mov    0x8(%ebp),%eax
  801489:	8a 00                	mov    (%eax),%al
  80148b:	0f be c0             	movsbl %al,%eax
  80148e:	83 e8 37             	sub    $0x37,%eax
  801491:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  801494:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801497:	3b 45 10             	cmp    0x10(%ebp),%eax
  80149a:	7d 19                	jge    8014b5 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  80149c:	ff 45 08             	incl   0x8(%ebp)
  80149f:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014a2:	0f af 45 10          	imul   0x10(%ebp),%eax
  8014a6:	89 c2                	mov    %eax,%edx
  8014a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8014ab:	01 d0                	add    %edx,%eax
  8014ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8014b0:	e9 7b ff ff ff       	jmp    801430 <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  8014b5:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  8014b6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8014ba:	74 08                	je     8014c4 <strtol+0x134>
		*endptr = (char *) s;
  8014bc:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014bf:	8b 55 08             	mov    0x8(%ebp),%edx
  8014c2:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  8014c4:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8014c8:	74 07                	je     8014d1 <strtol+0x141>
  8014ca:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8014cd:	f7 d8                	neg    %eax
  8014cf:	eb 03                	jmp    8014d4 <strtol+0x144>
  8014d1:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  8014d4:	c9                   	leave  
  8014d5:	c3                   	ret    

008014d6 <ltostr>:

void
ltostr(long value, char *str)
{
  8014d6:	55                   	push   %ebp
  8014d7:	89 e5                	mov    %esp,%ebp
  8014d9:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  8014dc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  8014e3:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  8014ea:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  8014ee:	79 13                	jns    801503 <ltostr+0x2d>
	{
		neg = 1;
  8014f0:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  8014f7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8014fa:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  8014fd:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  801500:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  801503:	8b 45 08             	mov    0x8(%ebp),%eax
  801506:	b9 0a 00 00 00       	mov    $0xa,%ecx
  80150b:	99                   	cltd   
  80150c:	f7 f9                	idiv   %ecx
  80150e:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  801511:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801514:	8d 50 01             	lea    0x1(%eax),%edx
  801517:	89 55 f8             	mov    %edx,-0x8(%ebp)
  80151a:	89 c2                	mov    %eax,%edx
  80151c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80151f:	01 d0                	add    %edx,%eax
  801521:	8b 55 ec             	mov    -0x14(%ebp),%edx
  801524:	83 c2 30             	add    $0x30,%edx
  801527:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801529:	8b 4d 08             	mov    0x8(%ebp),%ecx
  80152c:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801531:	f7 e9                	imul   %ecx
  801533:	c1 fa 02             	sar    $0x2,%edx
  801536:	89 c8                	mov    %ecx,%eax
  801538:	c1 f8 1f             	sar    $0x1f,%eax
  80153b:	29 c2                	sub    %eax,%edx
  80153d:	89 d0                	mov    %edx,%eax
  80153f:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  801542:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801545:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80154a:	f7 e9                	imul   %ecx
  80154c:	c1 fa 02             	sar    $0x2,%edx
  80154f:	89 c8                	mov    %ecx,%eax
  801551:	c1 f8 1f             	sar    $0x1f,%eax
  801554:	29 c2                	sub    %eax,%edx
  801556:	89 d0                	mov    %edx,%eax
  801558:	c1 e0 02             	shl    $0x2,%eax
  80155b:	01 d0                	add    %edx,%eax
  80155d:	01 c0                	add    %eax,%eax
  80155f:	29 c1                	sub    %eax,%ecx
  801561:	89 ca                	mov    %ecx,%edx
  801563:	85 d2                	test   %edx,%edx
  801565:	75 9c                	jne    801503 <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  801567:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  80156e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801571:	48                   	dec    %eax
  801572:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  801575:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801579:	74 3d                	je     8015b8 <ltostr+0xe2>
		start = 1 ;
  80157b:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  801582:	eb 34                	jmp    8015b8 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  801584:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801587:	8b 45 0c             	mov    0xc(%ebp),%eax
  80158a:	01 d0                	add    %edx,%eax
  80158c:	8a 00                	mov    (%eax),%al
  80158e:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  801591:	8b 55 f4             	mov    -0xc(%ebp),%edx
  801594:	8b 45 0c             	mov    0xc(%ebp),%eax
  801597:	01 c2                	add    %eax,%edx
  801599:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  80159c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80159f:	01 c8                	add    %ecx,%eax
  8015a1:	8a 00                	mov    (%eax),%al
  8015a3:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8015a5:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8015a8:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015ab:	01 c2                	add    %eax,%edx
  8015ad:	8a 45 eb             	mov    -0x15(%ebp),%al
  8015b0:	88 02                	mov    %al,(%edx)
		start++ ;
  8015b2:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  8015b5:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  8015b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8015bb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8015be:	7c c4                	jl     801584 <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  8015c0:	8b 55 f8             	mov    -0x8(%ebp),%edx
  8015c3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8015c6:	01 d0                	add    %edx,%eax
  8015c8:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  8015cb:	90                   	nop
  8015cc:	c9                   	leave  
  8015cd:	c3                   	ret    

008015ce <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  8015ce:	55                   	push   %ebp
  8015cf:	89 e5                	mov    %esp,%ebp
  8015d1:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  8015d4:	ff 75 08             	pushl  0x8(%ebp)
  8015d7:	e8 54 fa ff ff       	call   801030 <strlen>
  8015dc:	83 c4 04             	add    $0x4,%esp
  8015df:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  8015e2:	ff 75 0c             	pushl  0xc(%ebp)
  8015e5:	e8 46 fa ff ff       	call   801030 <strlen>
  8015ea:	83 c4 04             	add    $0x4,%esp
  8015ed:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  8015f0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  8015f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8015fe:	eb 17                	jmp    801617 <strcconcat+0x49>
		final[s] = str1[s] ;
  801600:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801603:	8b 45 10             	mov    0x10(%ebp),%eax
  801606:	01 c2                	add    %eax,%edx
  801608:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  80160b:	8b 45 08             	mov    0x8(%ebp),%eax
  80160e:	01 c8                	add    %ecx,%eax
  801610:	8a 00                	mov    (%eax),%al
  801612:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  801614:	ff 45 fc             	incl   -0x4(%ebp)
  801617:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80161a:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  80161d:	7c e1                	jl     801600 <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80161f:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801626:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  80162d:	eb 1f                	jmp    80164e <strcconcat+0x80>
		final[s++] = str2[i] ;
  80162f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801632:	8d 50 01             	lea    0x1(%eax),%edx
  801635:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801638:	89 c2                	mov    %eax,%edx
  80163a:	8b 45 10             	mov    0x10(%ebp),%eax
  80163d:	01 c2                	add    %eax,%edx
  80163f:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  801642:	8b 45 0c             	mov    0xc(%ebp),%eax
  801645:	01 c8                	add    %ecx,%eax
  801647:	8a 00                	mov    (%eax),%al
  801649:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  80164b:	ff 45 f8             	incl   -0x8(%ebp)
  80164e:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801651:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801654:	7c d9                	jl     80162f <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  801656:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801659:	8b 45 10             	mov    0x10(%ebp),%eax
  80165c:	01 d0                	add    %edx,%eax
  80165e:	c6 00 00             	movb   $0x0,(%eax)
}
  801661:	90                   	nop
  801662:	c9                   	leave  
  801663:	c3                   	ret    

00801664 <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  801664:	55                   	push   %ebp
  801665:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  801667:	8b 45 14             	mov    0x14(%ebp),%eax
  80166a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  801670:	8b 45 14             	mov    0x14(%ebp),%eax
  801673:	8b 00                	mov    (%eax),%eax
  801675:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80167c:	8b 45 10             	mov    0x10(%ebp),%eax
  80167f:	01 d0                	add    %edx,%eax
  801681:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801687:	eb 0c                	jmp    801695 <strsplit+0x31>
			*string++ = 0;
  801689:	8b 45 08             	mov    0x8(%ebp),%eax
  80168c:	8d 50 01             	lea    0x1(%eax),%edx
  80168f:	89 55 08             	mov    %edx,0x8(%ebp)
  801692:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801695:	8b 45 08             	mov    0x8(%ebp),%eax
  801698:	8a 00                	mov    (%eax),%al
  80169a:	84 c0                	test   %al,%al
  80169c:	74 18                	je     8016b6 <strsplit+0x52>
  80169e:	8b 45 08             	mov    0x8(%ebp),%eax
  8016a1:	8a 00                	mov    (%eax),%al
  8016a3:	0f be c0             	movsbl %al,%eax
  8016a6:	50                   	push   %eax
  8016a7:	ff 75 0c             	pushl  0xc(%ebp)
  8016aa:	e8 13 fb ff ff       	call   8011c2 <strchr>
  8016af:	83 c4 08             	add    $0x8,%esp
  8016b2:	85 c0                	test   %eax,%eax
  8016b4:	75 d3                	jne    801689 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  8016b6:	8b 45 08             	mov    0x8(%ebp),%eax
  8016b9:	8a 00                	mov    (%eax),%al
  8016bb:	84 c0                	test   %al,%al
  8016bd:	74 5a                	je     801719 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  8016bf:	8b 45 14             	mov    0x14(%ebp),%eax
  8016c2:	8b 00                	mov    (%eax),%eax
  8016c4:	83 f8 0f             	cmp    $0xf,%eax
  8016c7:	75 07                	jne    8016d0 <strsplit+0x6c>
		{
			return 0;
  8016c9:	b8 00 00 00 00       	mov    $0x0,%eax
  8016ce:	eb 66                	jmp    801736 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  8016d0:	8b 45 14             	mov    0x14(%ebp),%eax
  8016d3:	8b 00                	mov    (%eax),%eax
  8016d5:	8d 48 01             	lea    0x1(%eax),%ecx
  8016d8:	8b 55 14             	mov    0x14(%ebp),%edx
  8016db:	89 0a                	mov    %ecx,(%edx)
  8016dd:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8016e4:	8b 45 10             	mov    0x10(%ebp),%eax
  8016e7:	01 c2                	add    %eax,%edx
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016ee:	eb 03                	jmp    8016f3 <strsplit+0x8f>
			string++;
  8016f0:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  8016f3:	8b 45 08             	mov    0x8(%ebp),%eax
  8016f6:	8a 00                	mov    (%eax),%al
  8016f8:	84 c0                	test   %al,%al
  8016fa:	74 8b                	je     801687 <strsplit+0x23>
  8016fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ff:	8a 00                	mov    (%eax),%al
  801701:	0f be c0             	movsbl %al,%eax
  801704:	50                   	push   %eax
  801705:	ff 75 0c             	pushl  0xc(%ebp)
  801708:	e8 b5 fa ff ff       	call   8011c2 <strchr>
  80170d:	83 c4 08             	add    $0x8,%esp
  801710:	85 c0                	test   %eax,%eax
  801712:	74 dc                	je     8016f0 <strsplit+0x8c>
			string++;
	}
  801714:	e9 6e ff ff ff       	jmp    801687 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801719:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  80171a:	8b 45 14             	mov    0x14(%ebp),%eax
  80171d:	8b 00                	mov    (%eax),%eax
  80171f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801726:	8b 45 10             	mov    0x10(%ebp),%eax
  801729:	01 d0                	add    %edx,%eax
  80172b:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  801731:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801736:	c9                   	leave  
  801737:	c3                   	ret    

00801738 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801738:	55                   	push   %ebp
  801739:	89 e5                	mov    %esp,%ebp
  80173b:	57                   	push   %edi
  80173c:	56                   	push   %esi
  80173d:	53                   	push   %ebx
  80173e:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  801741:	8b 45 08             	mov    0x8(%ebp),%eax
  801744:	8b 55 0c             	mov    0xc(%ebp),%edx
  801747:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80174a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80174d:	8b 7d 18             	mov    0x18(%ebp),%edi
  801750:	8b 75 1c             	mov    0x1c(%ebp),%esi
  801753:	cd 30                	int    $0x30
  801755:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801758:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  80175b:	83 c4 10             	add    $0x10,%esp
  80175e:	5b                   	pop    %ebx
  80175f:	5e                   	pop    %esi
  801760:	5f                   	pop    %edi
  801761:	5d                   	pop    %ebp
  801762:	c3                   	ret    

00801763 <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  801763:	55                   	push   %ebp
  801764:	89 e5                	mov    %esp,%ebp
  801766:	83 ec 04             	sub    $0x4,%esp
  801769:	8b 45 10             	mov    0x10(%ebp),%eax
  80176c:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  80176f:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801773:	8b 45 08             	mov    0x8(%ebp),%eax
  801776:	6a 00                	push   $0x0
  801778:	6a 00                	push   $0x0
  80177a:	52                   	push   %edx
  80177b:	ff 75 0c             	pushl  0xc(%ebp)
  80177e:	50                   	push   %eax
  80177f:	6a 00                	push   $0x0
  801781:	e8 b2 ff ff ff       	call   801738 <syscall>
  801786:	83 c4 18             	add    $0x18,%esp
}
  801789:	90                   	nop
  80178a:	c9                   	leave  
  80178b:	c3                   	ret    

0080178c <sys_cgetc>:

int
sys_cgetc(void)
{
  80178c:	55                   	push   %ebp
  80178d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  80178f:	6a 00                	push   $0x0
  801791:	6a 00                	push   $0x0
  801793:	6a 00                	push   $0x0
  801795:	6a 00                	push   $0x0
  801797:	6a 00                	push   $0x0
  801799:	6a 01                	push   $0x1
  80179b:	e8 98 ff ff ff       	call   801738 <syscall>
  8017a0:	83 c4 18             	add    $0x18,%esp
}
  8017a3:	c9                   	leave  
  8017a4:	c3                   	ret    

008017a5 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8017a5:	55                   	push   %ebp
  8017a6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8017a8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ab:	6a 00                	push   $0x0
  8017ad:	6a 00                	push   $0x0
  8017af:	6a 00                	push   $0x0
  8017b1:	6a 00                	push   $0x0
  8017b3:	50                   	push   %eax
  8017b4:	6a 05                	push   $0x5
  8017b6:	e8 7d ff ff ff       	call   801738 <syscall>
  8017bb:	83 c4 18             	add    $0x18,%esp
}
  8017be:	c9                   	leave  
  8017bf:	c3                   	ret    

008017c0 <sys_getenvid>:

int32 sys_getenvid(void)
{
  8017c0:	55                   	push   %ebp
  8017c1:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8017c3:	6a 00                	push   $0x0
  8017c5:	6a 00                	push   $0x0
  8017c7:	6a 00                	push   $0x0
  8017c9:	6a 00                	push   $0x0
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 02                	push   $0x2
  8017cf:	e8 64 ff ff ff       	call   801738 <syscall>
  8017d4:	83 c4 18             	add    $0x18,%esp
}
  8017d7:	c9                   	leave  
  8017d8:	c3                   	ret    

008017d9 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  8017d9:	55                   	push   %ebp
  8017da:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  8017dc:	6a 00                	push   $0x0
  8017de:	6a 00                	push   $0x0
  8017e0:	6a 00                	push   $0x0
  8017e2:	6a 00                	push   $0x0
  8017e4:	6a 00                	push   $0x0
  8017e6:	6a 03                	push   $0x3
  8017e8:	e8 4b ff ff ff       	call   801738 <syscall>
  8017ed:	83 c4 18             	add    $0x18,%esp
}
  8017f0:	c9                   	leave  
  8017f1:	c3                   	ret    

008017f2 <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  8017f2:	55                   	push   %ebp
  8017f3:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  8017f5:	6a 00                	push   $0x0
  8017f7:	6a 00                	push   $0x0
  8017f9:	6a 00                	push   $0x0
  8017fb:	6a 00                	push   $0x0
  8017fd:	6a 00                	push   $0x0
  8017ff:	6a 04                	push   $0x4
  801801:	e8 32 ff ff ff       	call   801738 <syscall>
  801806:	83 c4 18             	add    $0x18,%esp
}
  801809:	c9                   	leave  
  80180a:	c3                   	ret    

0080180b <sys_env_exit>:


void sys_env_exit(void)
{
  80180b:	55                   	push   %ebp
  80180c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  80180e:	6a 00                	push   $0x0
  801810:	6a 00                	push   $0x0
  801812:	6a 00                	push   $0x0
  801814:	6a 00                	push   $0x0
  801816:	6a 00                	push   $0x0
  801818:	6a 06                	push   $0x6
  80181a:	e8 19 ff ff ff       	call   801738 <syscall>
  80181f:	83 c4 18             	add    $0x18,%esp
}
  801822:	90                   	nop
  801823:	c9                   	leave  
  801824:	c3                   	ret    

00801825 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801825:	55                   	push   %ebp
  801826:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801828:	8b 55 0c             	mov    0xc(%ebp),%edx
  80182b:	8b 45 08             	mov    0x8(%ebp),%eax
  80182e:	6a 00                	push   $0x0
  801830:	6a 00                	push   $0x0
  801832:	6a 00                	push   $0x0
  801834:	52                   	push   %edx
  801835:	50                   	push   %eax
  801836:	6a 07                	push   $0x7
  801838:	e8 fb fe ff ff       	call   801738 <syscall>
  80183d:	83 c4 18             	add    $0x18,%esp
}
  801840:	c9                   	leave  
  801841:	c3                   	ret    

00801842 <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  801842:	55                   	push   %ebp
  801843:	89 e5                	mov    %esp,%ebp
  801845:	56                   	push   %esi
  801846:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801847:	8b 75 18             	mov    0x18(%ebp),%esi
  80184a:	8b 5d 14             	mov    0x14(%ebp),%ebx
  80184d:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801850:	8b 55 0c             	mov    0xc(%ebp),%edx
  801853:	8b 45 08             	mov    0x8(%ebp),%eax
  801856:	56                   	push   %esi
  801857:	53                   	push   %ebx
  801858:	51                   	push   %ecx
  801859:	52                   	push   %edx
  80185a:	50                   	push   %eax
  80185b:	6a 08                	push   $0x8
  80185d:	e8 d6 fe ff ff       	call   801738 <syscall>
  801862:	83 c4 18             	add    $0x18,%esp
}
  801865:	8d 65 f8             	lea    -0x8(%ebp),%esp
  801868:	5b                   	pop    %ebx
  801869:	5e                   	pop    %esi
  80186a:	5d                   	pop    %ebp
  80186b:	c3                   	ret    

0080186c <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  80186c:	55                   	push   %ebp
  80186d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  80186f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801872:	8b 45 08             	mov    0x8(%ebp),%eax
  801875:	6a 00                	push   $0x0
  801877:	6a 00                	push   $0x0
  801879:	6a 00                	push   $0x0
  80187b:	52                   	push   %edx
  80187c:	50                   	push   %eax
  80187d:	6a 09                	push   $0x9
  80187f:	e8 b4 fe ff ff       	call   801738 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	c9                   	leave  
  801888:	c3                   	ret    

00801889 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  801889:	55                   	push   %ebp
  80188a:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  80188c:	6a 00                	push   $0x0
  80188e:	6a 00                	push   $0x0
  801890:	6a 00                	push   $0x0
  801892:	ff 75 0c             	pushl  0xc(%ebp)
  801895:	ff 75 08             	pushl  0x8(%ebp)
  801898:	6a 0a                	push   $0xa
  80189a:	e8 99 fe ff ff       	call   801738 <syscall>
  80189f:	83 c4 18             	add    $0x18,%esp
}
  8018a2:	c9                   	leave  
  8018a3:	c3                   	ret    

008018a4 <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8018a4:	55                   	push   %ebp
  8018a5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8018a7:	6a 00                	push   $0x0
  8018a9:	6a 00                	push   $0x0
  8018ab:	6a 00                	push   $0x0
  8018ad:	6a 00                	push   $0x0
  8018af:	6a 00                	push   $0x0
  8018b1:	6a 0b                	push   $0xb
  8018b3:	e8 80 fe ff ff       	call   801738 <syscall>
  8018b8:	83 c4 18             	add    $0x18,%esp
}
  8018bb:	c9                   	leave  
  8018bc:	c3                   	ret    

008018bd <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8018bd:	55                   	push   %ebp
  8018be:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8018c0:	6a 00                	push   $0x0
  8018c2:	6a 00                	push   $0x0
  8018c4:	6a 00                	push   $0x0
  8018c6:	6a 00                	push   $0x0
  8018c8:	6a 00                	push   $0x0
  8018ca:	6a 0c                	push   $0xc
  8018cc:	e8 67 fe ff ff       	call   801738 <syscall>
  8018d1:	83 c4 18             	add    $0x18,%esp
}
  8018d4:	c9                   	leave  
  8018d5:	c3                   	ret    

008018d6 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  8018d6:	55                   	push   %ebp
  8018d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  8018d9:	6a 00                	push   $0x0
  8018db:	6a 00                	push   $0x0
  8018dd:	6a 00                	push   $0x0
  8018df:	6a 00                	push   $0x0
  8018e1:	6a 00                	push   $0x0
  8018e3:	6a 0d                	push   $0xd
  8018e5:	e8 4e fe ff ff       	call   801738 <syscall>
  8018ea:	83 c4 18             	add    $0x18,%esp
}
  8018ed:	c9                   	leave  
  8018ee:	c3                   	ret    

008018ef <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  8018ef:	55                   	push   %ebp
  8018f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  8018f2:	6a 00                	push   $0x0
  8018f4:	6a 00                	push   $0x0
  8018f6:	6a 00                	push   $0x0
  8018f8:	ff 75 0c             	pushl  0xc(%ebp)
  8018fb:	ff 75 08             	pushl  0x8(%ebp)
  8018fe:	6a 11                	push   $0x11
  801900:	e8 33 fe ff ff       	call   801738 <syscall>
  801905:	83 c4 18             	add    $0x18,%esp
	return;
  801908:	90                   	nop
}
  801909:	c9                   	leave  
  80190a:	c3                   	ret    

0080190b <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  80190b:	55                   	push   %ebp
  80190c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  80190e:	6a 00                	push   $0x0
  801910:	6a 00                	push   $0x0
  801912:	6a 00                	push   $0x0
  801914:	ff 75 0c             	pushl  0xc(%ebp)
  801917:	ff 75 08             	pushl  0x8(%ebp)
  80191a:	6a 12                	push   $0x12
  80191c:	e8 17 fe ff ff       	call   801738 <syscall>
  801921:	83 c4 18             	add    $0x18,%esp
	return ;
  801924:	90                   	nop
}
  801925:	c9                   	leave  
  801926:	c3                   	ret    

00801927 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801927:	55                   	push   %ebp
  801928:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  80192a:	6a 00                	push   $0x0
  80192c:	6a 00                	push   $0x0
  80192e:	6a 00                	push   $0x0
  801930:	6a 00                	push   $0x0
  801932:	6a 00                	push   $0x0
  801934:	6a 0e                	push   $0xe
  801936:	e8 fd fd ff ff       	call   801738 <syscall>
  80193b:	83 c4 18             	add    $0x18,%esp
}
  80193e:	c9                   	leave  
  80193f:	c3                   	ret    

00801940 <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  801940:	55                   	push   %ebp
  801941:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  801943:	6a 00                	push   $0x0
  801945:	6a 00                	push   $0x0
  801947:	6a 00                	push   $0x0
  801949:	6a 00                	push   $0x0
  80194b:	ff 75 08             	pushl  0x8(%ebp)
  80194e:	6a 0f                	push   $0xf
  801950:	e8 e3 fd ff ff       	call   801738 <syscall>
  801955:	83 c4 18             	add    $0x18,%esp
}
  801958:	c9                   	leave  
  801959:	c3                   	ret    

0080195a <sys_scarce_memory>:

void sys_scarce_memory()
{
  80195a:	55                   	push   %ebp
  80195b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  80195d:	6a 00                	push   $0x0
  80195f:	6a 00                	push   $0x0
  801961:	6a 00                	push   $0x0
  801963:	6a 00                	push   $0x0
  801965:	6a 00                	push   $0x0
  801967:	6a 10                	push   $0x10
  801969:	e8 ca fd ff ff       	call   801738 <syscall>
  80196e:	83 c4 18             	add    $0x18,%esp
}
  801971:	90                   	nop
  801972:	c9                   	leave  
  801973:	c3                   	ret    

00801974 <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  801974:	55                   	push   %ebp
  801975:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  801977:	6a 00                	push   $0x0
  801979:	6a 00                	push   $0x0
  80197b:	6a 00                	push   $0x0
  80197d:	6a 00                	push   $0x0
  80197f:	6a 00                	push   $0x0
  801981:	6a 14                	push   $0x14
  801983:	e8 b0 fd ff ff       	call   801738 <syscall>
  801988:	83 c4 18             	add    $0x18,%esp
}
  80198b:	90                   	nop
  80198c:	c9                   	leave  
  80198d:	c3                   	ret    

0080198e <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  80198e:	55                   	push   %ebp
  80198f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  801991:	6a 00                	push   $0x0
  801993:	6a 00                	push   $0x0
  801995:	6a 00                	push   $0x0
  801997:	6a 00                	push   $0x0
  801999:	6a 00                	push   $0x0
  80199b:	6a 15                	push   $0x15
  80199d:	e8 96 fd ff ff       	call   801738 <syscall>
  8019a2:	83 c4 18             	add    $0x18,%esp
}
  8019a5:	90                   	nop
  8019a6:	c9                   	leave  
  8019a7:	c3                   	ret    

008019a8 <sys_cputc>:


void
sys_cputc(const char c)
{
  8019a8:	55                   	push   %ebp
  8019a9:	89 e5                	mov    %esp,%ebp
  8019ab:	83 ec 04             	sub    $0x4,%esp
  8019ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8019b1:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8019b4:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8019b8:	6a 00                	push   $0x0
  8019ba:	6a 00                	push   $0x0
  8019bc:	6a 00                	push   $0x0
  8019be:	6a 00                	push   $0x0
  8019c0:	50                   	push   %eax
  8019c1:	6a 16                	push   $0x16
  8019c3:	e8 70 fd ff ff       	call   801738 <syscall>
  8019c8:	83 c4 18             	add    $0x18,%esp
}
  8019cb:	90                   	nop
  8019cc:	c9                   	leave  
  8019cd:	c3                   	ret    

008019ce <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  8019ce:	55                   	push   %ebp
  8019cf:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  8019d1:	6a 00                	push   $0x0
  8019d3:	6a 00                	push   $0x0
  8019d5:	6a 00                	push   $0x0
  8019d7:	6a 00                	push   $0x0
  8019d9:	6a 00                	push   $0x0
  8019db:	6a 17                	push   $0x17
  8019dd:	e8 56 fd ff ff       	call   801738 <syscall>
  8019e2:	83 c4 18             	add    $0x18,%esp
}
  8019e5:	90                   	nop
  8019e6:	c9                   	leave  
  8019e7:	c3                   	ret    

008019e8 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  8019e8:	55                   	push   %ebp
  8019e9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  8019eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 00                	push   $0x0
  8019f2:	6a 00                	push   $0x0
  8019f4:	ff 75 0c             	pushl  0xc(%ebp)
  8019f7:	50                   	push   %eax
  8019f8:	6a 18                	push   $0x18
  8019fa:	e8 39 fd ff ff       	call   801738 <syscall>
  8019ff:	83 c4 18             	add    $0x18,%esp
}
  801a02:	c9                   	leave  
  801a03:	c3                   	ret    

00801a04 <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  801a04:	55                   	push   %ebp
  801a05:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a07:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a0a:	8b 45 08             	mov    0x8(%ebp),%eax
  801a0d:	6a 00                	push   $0x0
  801a0f:	6a 00                	push   $0x0
  801a11:	6a 00                	push   $0x0
  801a13:	52                   	push   %edx
  801a14:	50                   	push   %eax
  801a15:	6a 1b                	push   $0x1b
  801a17:	e8 1c fd ff ff       	call   801738 <syscall>
  801a1c:	83 c4 18             	add    $0x18,%esp
}
  801a1f:	c9                   	leave  
  801a20:	c3                   	ret    

00801a21 <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a21:	55                   	push   %ebp
  801a22:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a24:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a27:	8b 45 08             	mov    0x8(%ebp),%eax
  801a2a:	6a 00                	push   $0x0
  801a2c:	6a 00                	push   $0x0
  801a2e:	6a 00                	push   $0x0
  801a30:	52                   	push   %edx
  801a31:	50                   	push   %eax
  801a32:	6a 19                	push   $0x19
  801a34:	e8 ff fc ff ff       	call   801738 <syscall>
  801a39:	83 c4 18             	add    $0x18,%esp
}
  801a3c:	90                   	nop
  801a3d:	c9                   	leave  
  801a3e:	c3                   	ret    

00801a3f <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  801a3f:	55                   	push   %ebp
  801a40:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801a42:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a45:	8b 45 08             	mov    0x8(%ebp),%eax
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	52                   	push   %edx
  801a4f:	50                   	push   %eax
  801a50:	6a 1a                	push   $0x1a
  801a52:	e8 e1 fc ff ff       	call   801738 <syscall>
  801a57:	83 c4 18             	add    $0x18,%esp
}
  801a5a:	90                   	nop
  801a5b:	c9                   	leave  
  801a5c:	c3                   	ret    

00801a5d <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801a5d:	55                   	push   %ebp
  801a5e:	89 e5                	mov    %esp,%ebp
  801a60:	83 ec 04             	sub    $0x4,%esp
  801a63:	8b 45 10             	mov    0x10(%ebp),%eax
  801a66:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  801a69:	8b 4d 14             	mov    0x14(%ebp),%ecx
  801a6c:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  801a70:	8b 45 08             	mov    0x8(%ebp),%eax
  801a73:	6a 00                	push   $0x0
  801a75:	51                   	push   %ecx
  801a76:	52                   	push   %edx
  801a77:	ff 75 0c             	pushl  0xc(%ebp)
  801a7a:	50                   	push   %eax
  801a7b:	6a 1c                	push   $0x1c
  801a7d:	e8 b6 fc ff ff       	call   801738 <syscall>
  801a82:	83 c4 18             	add    $0x18,%esp
}
  801a85:	c9                   	leave  
  801a86:	c3                   	ret    

00801a87 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  801a87:	55                   	push   %ebp
  801a88:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  801a8a:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a8d:	8b 45 08             	mov    0x8(%ebp),%eax
  801a90:	6a 00                	push   $0x0
  801a92:	6a 00                	push   $0x0
  801a94:	6a 00                	push   $0x0
  801a96:	52                   	push   %edx
  801a97:	50                   	push   %eax
  801a98:	6a 1d                	push   $0x1d
  801a9a:	e8 99 fc ff ff       	call   801738 <syscall>
  801a9f:	83 c4 18             	add    $0x18,%esp
}
  801aa2:	c9                   	leave  
  801aa3:	c3                   	ret    

00801aa4 <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  801aa4:	55                   	push   %ebp
  801aa5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801aa7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801aaa:	8b 55 0c             	mov    0xc(%ebp),%edx
  801aad:	8b 45 08             	mov    0x8(%ebp),%eax
  801ab0:	6a 00                	push   $0x0
  801ab2:	6a 00                	push   $0x0
  801ab4:	51                   	push   %ecx
  801ab5:	52                   	push   %edx
  801ab6:	50                   	push   %eax
  801ab7:	6a 1e                	push   $0x1e
  801ab9:	e8 7a fc ff ff       	call   801738 <syscall>
  801abe:	83 c4 18             	add    $0x18,%esp
}
  801ac1:	c9                   	leave  
  801ac2:	c3                   	ret    

00801ac3 <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  801ac3:	55                   	push   %ebp
  801ac4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801ac6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ac9:	8b 45 08             	mov    0x8(%ebp),%eax
  801acc:	6a 00                	push   $0x0
  801ace:	6a 00                	push   $0x0
  801ad0:	6a 00                	push   $0x0
  801ad2:	52                   	push   %edx
  801ad3:	50                   	push   %eax
  801ad4:	6a 1f                	push   $0x1f
  801ad6:	e8 5d fc ff ff       	call   801738 <syscall>
  801adb:	83 c4 18             	add    $0x18,%esp
}
  801ade:	c9                   	leave  
  801adf:	c3                   	ret    

00801ae0 <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  801ae0:	55                   	push   %ebp
  801ae1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  801ae3:	6a 00                	push   $0x0
  801ae5:	6a 00                	push   $0x0
  801ae7:	6a 00                	push   $0x0
  801ae9:	6a 00                	push   $0x0
  801aeb:	6a 00                	push   $0x0
  801aed:	6a 20                	push   $0x20
  801aef:	e8 44 fc ff ff       	call   801738 <syscall>
  801af4:	83 c4 18             	add    $0x18,%esp
}
  801af7:	c9                   	leave  
  801af8:	c3                   	ret    

00801af9 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801af9:	55                   	push   %ebp
  801afa:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801afc:	8b 45 08             	mov    0x8(%ebp),%eax
  801aff:	6a 00                	push   $0x0
  801b01:	ff 75 14             	pushl  0x14(%ebp)
  801b04:	ff 75 10             	pushl  0x10(%ebp)
  801b07:	ff 75 0c             	pushl  0xc(%ebp)
  801b0a:	50                   	push   %eax
  801b0b:	6a 21                	push   $0x21
  801b0d:	e8 26 fc ff ff       	call   801738 <syscall>
  801b12:	83 c4 18             	add    $0x18,%esp
}
  801b15:	c9                   	leave  
  801b16:	c3                   	ret    

00801b17 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801b17:	55                   	push   %ebp
  801b18:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801b1a:	8b 45 08             	mov    0x8(%ebp),%eax
  801b1d:	6a 00                	push   $0x0
  801b1f:	6a 00                	push   $0x0
  801b21:	6a 00                	push   $0x0
  801b23:	6a 00                	push   $0x0
  801b25:	50                   	push   %eax
  801b26:	6a 22                	push   $0x22
  801b28:	e8 0b fc ff ff       	call   801738 <syscall>
  801b2d:	83 c4 18             	add    $0x18,%esp
}
  801b30:	90                   	nop
  801b31:	c9                   	leave  
  801b32:	c3                   	ret    

00801b33 <sys_free_env>:

void
sys_free_env(int32 envId)
{
  801b33:	55                   	push   %ebp
  801b34:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801b36:	8b 45 08             	mov    0x8(%ebp),%eax
  801b39:	6a 00                	push   $0x0
  801b3b:	6a 00                	push   $0x0
  801b3d:	6a 00                	push   $0x0
  801b3f:	6a 00                	push   $0x0
  801b41:	50                   	push   %eax
  801b42:	6a 23                	push   $0x23
  801b44:	e8 ef fb ff ff       	call   801738 <syscall>
  801b49:	83 c4 18             	add    $0x18,%esp
}
  801b4c:	90                   	nop
  801b4d:	c9                   	leave  
  801b4e:	c3                   	ret    

00801b4f <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  801b4f:	55                   	push   %ebp
  801b50:	89 e5                	mov    %esp,%ebp
  801b52:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801b55:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b58:	8d 50 04             	lea    0x4(%eax),%edx
  801b5b:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801b5e:	6a 00                	push   $0x0
  801b60:	6a 00                	push   $0x0
  801b62:	6a 00                	push   $0x0
  801b64:	52                   	push   %edx
  801b65:	50                   	push   %eax
  801b66:	6a 24                	push   $0x24
  801b68:	e8 cb fb ff ff       	call   801738 <syscall>
  801b6d:	83 c4 18             	add    $0x18,%esp
	return result;
  801b70:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801b73:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801b76:	8b 55 fc             	mov    -0x4(%ebp),%edx
  801b79:	89 01                	mov    %eax,(%ecx)
  801b7b:	89 51 04             	mov    %edx,0x4(%ecx)
}
  801b7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801b81:	c9                   	leave  
  801b82:	c2 04 00             	ret    $0x4

00801b85 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  801b85:	55                   	push   %ebp
  801b86:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  801b88:	6a 00                	push   $0x0
  801b8a:	6a 00                	push   $0x0
  801b8c:	ff 75 10             	pushl  0x10(%ebp)
  801b8f:	ff 75 0c             	pushl  0xc(%ebp)
  801b92:	ff 75 08             	pushl  0x8(%ebp)
  801b95:	6a 13                	push   $0x13
  801b97:	e8 9c fb ff ff       	call   801738 <syscall>
  801b9c:	83 c4 18             	add    $0x18,%esp
	return ;
  801b9f:	90                   	nop
}
  801ba0:	c9                   	leave  
  801ba1:	c3                   	ret    

00801ba2 <sys_rcr2>:
uint32 sys_rcr2()
{
  801ba2:	55                   	push   %ebp
  801ba3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  801ba5:	6a 00                	push   $0x0
  801ba7:	6a 00                	push   $0x0
  801ba9:	6a 00                	push   $0x0
  801bab:	6a 00                	push   $0x0
  801bad:	6a 00                	push   $0x0
  801baf:	6a 25                	push   $0x25
  801bb1:	e8 82 fb ff ff       	call   801738 <syscall>
  801bb6:	83 c4 18             	add    $0x18,%esp
}
  801bb9:	c9                   	leave  
  801bba:	c3                   	ret    

00801bbb <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801bbb:	55                   	push   %ebp
  801bbc:	89 e5                	mov    %esp,%ebp
  801bbe:	83 ec 04             	sub    $0x4,%esp
  801bc1:	8b 45 08             	mov    0x8(%ebp),%eax
  801bc4:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801bc7:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801bcb:	6a 00                	push   $0x0
  801bcd:	6a 00                	push   $0x0
  801bcf:	6a 00                	push   $0x0
  801bd1:	6a 00                	push   $0x0
  801bd3:	50                   	push   %eax
  801bd4:	6a 26                	push   $0x26
  801bd6:	e8 5d fb ff ff       	call   801738 <syscall>
  801bdb:	83 c4 18             	add    $0x18,%esp
	return ;
  801bde:	90                   	nop
}
  801bdf:	c9                   	leave  
  801be0:	c3                   	ret    

00801be1 <rsttst>:
void rsttst()
{
  801be1:	55                   	push   %ebp
  801be2:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  801be4:	6a 00                	push   $0x0
  801be6:	6a 00                	push   $0x0
  801be8:	6a 00                	push   $0x0
  801bea:	6a 00                	push   $0x0
  801bec:	6a 00                	push   $0x0
  801bee:	6a 28                	push   $0x28
  801bf0:	e8 43 fb ff ff       	call   801738 <syscall>
  801bf5:	83 c4 18             	add    $0x18,%esp
	return ;
  801bf8:	90                   	nop
}
  801bf9:	c9                   	leave  
  801bfa:	c3                   	ret    

00801bfb <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801bfb:	55                   	push   %ebp
  801bfc:	89 e5                	mov    %esp,%ebp
  801bfe:	83 ec 04             	sub    $0x4,%esp
  801c01:	8b 45 14             	mov    0x14(%ebp),%eax
  801c04:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801c07:	8b 55 18             	mov    0x18(%ebp),%edx
  801c0a:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801c0e:	52                   	push   %edx
  801c0f:	50                   	push   %eax
  801c10:	ff 75 10             	pushl  0x10(%ebp)
  801c13:	ff 75 0c             	pushl  0xc(%ebp)
  801c16:	ff 75 08             	pushl  0x8(%ebp)
  801c19:	6a 27                	push   $0x27
  801c1b:	e8 18 fb ff ff       	call   801738 <syscall>
  801c20:	83 c4 18             	add    $0x18,%esp
	return ;
  801c23:	90                   	nop
}
  801c24:	c9                   	leave  
  801c25:	c3                   	ret    

00801c26 <chktst>:
void chktst(uint32 n)
{
  801c26:	55                   	push   %ebp
  801c27:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801c29:	6a 00                	push   $0x0
  801c2b:	6a 00                	push   $0x0
  801c2d:	6a 00                	push   $0x0
  801c2f:	6a 00                	push   $0x0
  801c31:	ff 75 08             	pushl  0x8(%ebp)
  801c34:	6a 29                	push   $0x29
  801c36:	e8 fd fa ff ff       	call   801738 <syscall>
  801c3b:	83 c4 18             	add    $0x18,%esp
	return ;
  801c3e:	90                   	nop
}
  801c3f:	c9                   	leave  
  801c40:	c3                   	ret    

00801c41 <inctst>:

void inctst()
{
  801c41:	55                   	push   %ebp
  801c42:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  801c44:	6a 00                	push   $0x0
  801c46:	6a 00                	push   $0x0
  801c48:	6a 00                	push   $0x0
  801c4a:	6a 00                	push   $0x0
  801c4c:	6a 00                	push   $0x0
  801c4e:	6a 2a                	push   $0x2a
  801c50:	e8 e3 fa ff ff       	call   801738 <syscall>
  801c55:	83 c4 18             	add    $0x18,%esp
	return ;
  801c58:	90                   	nop
}
  801c59:	c9                   	leave  
  801c5a:	c3                   	ret    

00801c5b <gettst>:
uint32 gettst()
{
  801c5b:	55                   	push   %ebp
  801c5c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801c5e:	6a 00                	push   $0x0
  801c60:	6a 00                	push   $0x0
  801c62:	6a 00                	push   $0x0
  801c64:	6a 00                	push   $0x0
  801c66:	6a 00                	push   $0x0
  801c68:	6a 2b                	push   $0x2b
  801c6a:	e8 c9 fa ff ff       	call   801738 <syscall>
  801c6f:	83 c4 18             	add    $0x18,%esp
}
  801c72:	c9                   	leave  
  801c73:	c3                   	ret    

00801c74 <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  801c74:	55                   	push   %ebp
  801c75:	89 e5                	mov    %esp,%ebp
  801c77:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801c7a:	6a 00                	push   $0x0
  801c7c:	6a 00                	push   $0x0
  801c7e:	6a 00                	push   $0x0
  801c80:	6a 00                	push   $0x0
  801c82:	6a 00                	push   $0x0
  801c84:	6a 2c                	push   $0x2c
  801c86:	e8 ad fa ff ff       	call   801738 <syscall>
  801c8b:	83 c4 18             	add    $0x18,%esp
  801c8e:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  801c91:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  801c95:	75 07                	jne    801c9e <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801c97:	b8 01 00 00 00       	mov    $0x1,%eax
  801c9c:	eb 05                	jmp    801ca3 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801c9e:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801ca3:	c9                   	leave  
  801ca4:	c3                   	ret    

00801ca5 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  801ca5:	55                   	push   %ebp
  801ca6:	89 e5                	mov    %esp,%ebp
  801ca8:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cab:	6a 00                	push   $0x0
  801cad:	6a 00                	push   $0x0
  801caf:	6a 00                	push   $0x0
  801cb1:	6a 00                	push   $0x0
  801cb3:	6a 00                	push   $0x0
  801cb5:	6a 2c                	push   $0x2c
  801cb7:	e8 7c fa ff ff       	call   801738 <syscall>
  801cbc:	83 c4 18             	add    $0x18,%esp
  801cbf:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  801cc2:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801cc6:	75 07                	jne    801ccf <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801cc8:	b8 01 00 00 00       	mov    $0x1,%eax
  801ccd:	eb 05                	jmp    801cd4 <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801ccf:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801cd4:	c9                   	leave  
  801cd5:	c3                   	ret    

00801cd6 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801cd6:	55                   	push   %ebp
  801cd7:	89 e5                	mov    %esp,%ebp
  801cd9:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801cdc:	6a 00                	push   $0x0
  801cde:	6a 00                	push   $0x0
  801ce0:	6a 00                	push   $0x0
  801ce2:	6a 00                	push   $0x0
  801ce4:	6a 00                	push   $0x0
  801ce6:	6a 2c                	push   $0x2c
  801ce8:	e8 4b fa ff ff       	call   801738 <syscall>
  801ced:	83 c4 18             	add    $0x18,%esp
  801cf0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801cf3:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801cf7:	75 07                	jne    801d00 <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801cf9:	b8 01 00 00 00       	mov    $0x1,%eax
  801cfe:	eb 05                	jmp    801d05 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801d00:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d05:	c9                   	leave  
  801d06:	c3                   	ret    

00801d07 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801d07:	55                   	push   %ebp
  801d08:	89 e5                	mov    %esp,%ebp
  801d0a:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801d0d:	6a 00                	push   $0x0
  801d0f:	6a 00                	push   $0x0
  801d11:	6a 00                	push   $0x0
  801d13:	6a 00                	push   $0x0
  801d15:	6a 00                	push   $0x0
  801d17:	6a 2c                	push   $0x2c
  801d19:	e8 1a fa ff ff       	call   801738 <syscall>
  801d1e:	83 c4 18             	add    $0x18,%esp
  801d21:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801d24:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801d28:	75 07                	jne    801d31 <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801d2a:	b8 01 00 00 00       	mov    $0x1,%eax
  801d2f:	eb 05                	jmp    801d36 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801d31:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801d36:	c9                   	leave  
  801d37:	c3                   	ret    

00801d38 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801d38:	55                   	push   %ebp
  801d39:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801d3b:	6a 00                	push   $0x0
  801d3d:	6a 00                	push   $0x0
  801d3f:	6a 00                	push   $0x0
  801d41:	6a 00                	push   $0x0
  801d43:	ff 75 08             	pushl  0x8(%ebp)
  801d46:	6a 2d                	push   $0x2d
  801d48:	e8 eb f9 ff ff       	call   801738 <syscall>
  801d4d:	83 c4 18             	add    $0x18,%esp
	return ;
  801d50:	90                   	nop
}
  801d51:	c9                   	leave  
  801d52:	c3                   	ret    

00801d53 <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801d53:	55                   	push   %ebp
  801d54:	89 e5                	mov    %esp,%ebp
  801d56:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801d57:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801d5a:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801d5d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d60:	8b 45 08             	mov    0x8(%ebp),%eax
  801d63:	6a 00                	push   $0x0
  801d65:	53                   	push   %ebx
  801d66:	51                   	push   %ecx
  801d67:	52                   	push   %edx
  801d68:	50                   	push   %eax
  801d69:	6a 2e                	push   $0x2e
  801d6b:	e8 c8 f9 ff ff       	call   801738 <syscall>
  801d70:	83 c4 18             	add    $0x18,%esp
}
  801d73:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801d76:	c9                   	leave  
  801d77:	c3                   	ret    

00801d78 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801d78:	55                   	push   %ebp
  801d79:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801d7b:	8b 55 0c             	mov    0xc(%ebp),%edx
  801d7e:	8b 45 08             	mov    0x8(%ebp),%eax
  801d81:	6a 00                	push   $0x0
  801d83:	6a 00                	push   $0x0
  801d85:	6a 00                	push   $0x0
  801d87:	52                   	push   %edx
  801d88:	50                   	push   %eax
  801d89:	6a 2f                	push   $0x2f
  801d8b:	e8 a8 f9 ff ff       	call   801738 <syscall>
  801d90:	83 c4 18             	add    $0x18,%esp
}
  801d93:	c9                   	leave  
  801d94:	c3                   	ret    

00801d95 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801d95:	55                   	push   %ebp
  801d96:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801d98:	6a 00                	push   $0x0
  801d9a:	6a 00                	push   $0x0
  801d9c:	6a 00                	push   $0x0
  801d9e:	ff 75 0c             	pushl  0xc(%ebp)
  801da1:	ff 75 08             	pushl  0x8(%ebp)
  801da4:	6a 30                	push   $0x30
  801da6:	e8 8d f9 ff ff       	call   801738 <syscall>
  801dab:	83 c4 18             	add    $0x18,%esp
	return ;
  801dae:	90                   	nop
}
  801daf:	c9                   	leave  
  801db0:	c3                   	ret    
  801db1:	66 90                	xchg   %ax,%ax
  801db3:	90                   	nop

00801db4 <__udivdi3>:
  801db4:	55                   	push   %ebp
  801db5:	57                   	push   %edi
  801db6:	56                   	push   %esi
  801db7:	53                   	push   %ebx
  801db8:	83 ec 1c             	sub    $0x1c,%esp
  801dbb:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801dbf:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801dc3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801dc7:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801dcb:	89 ca                	mov    %ecx,%edx
  801dcd:	89 f8                	mov    %edi,%eax
  801dcf:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801dd3:	85 f6                	test   %esi,%esi
  801dd5:	75 2d                	jne    801e04 <__udivdi3+0x50>
  801dd7:	39 cf                	cmp    %ecx,%edi
  801dd9:	77 65                	ja     801e40 <__udivdi3+0x8c>
  801ddb:	89 fd                	mov    %edi,%ebp
  801ddd:	85 ff                	test   %edi,%edi
  801ddf:	75 0b                	jne    801dec <__udivdi3+0x38>
  801de1:	b8 01 00 00 00       	mov    $0x1,%eax
  801de6:	31 d2                	xor    %edx,%edx
  801de8:	f7 f7                	div    %edi
  801dea:	89 c5                	mov    %eax,%ebp
  801dec:	31 d2                	xor    %edx,%edx
  801dee:	89 c8                	mov    %ecx,%eax
  801df0:	f7 f5                	div    %ebp
  801df2:	89 c1                	mov    %eax,%ecx
  801df4:	89 d8                	mov    %ebx,%eax
  801df6:	f7 f5                	div    %ebp
  801df8:	89 cf                	mov    %ecx,%edi
  801dfa:	89 fa                	mov    %edi,%edx
  801dfc:	83 c4 1c             	add    $0x1c,%esp
  801dff:	5b                   	pop    %ebx
  801e00:	5e                   	pop    %esi
  801e01:	5f                   	pop    %edi
  801e02:	5d                   	pop    %ebp
  801e03:	c3                   	ret    
  801e04:	39 ce                	cmp    %ecx,%esi
  801e06:	77 28                	ja     801e30 <__udivdi3+0x7c>
  801e08:	0f bd fe             	bsr    %esi,%edi
  801e0b:	83 f7 1f             	xor    $0x1f,%edi
  801e0e:	75 40                	jne    801e50 <__udivdi3+0x9c>
  801e10:	39 ce                	cmp    %ecx,%esi
  801e12:	72 0a                	jb     801e1e <__udivdi3+0x6a>
  801e14:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801e18:	0f 87 9e 00 00 00    	ja     801ebc <__udivdi3+0x108>
  801e1e:	b8 01 00 00 00       	mov    $0x1,%eax
  801e23:	89 fa                	mov    %edi,%edx
  801e25:	83 c4 1c             	add    $0x1c,%esp
  801e28:	5b                   	pop    %ebx
  801e29:	5e                   	pop    %esi
  801e2a:	5f                   	pop    %edi
  801e2b:	5d                   	pop    %ebp
  801e2c:	c3                   	ret    
  801e2d:	8d 76 00             	lea    0x0(%esi),%esi
  801e30:	31 ff                	xor    %edi,%edi
  801e32:	31 c0                	xor    %eax,%eax
  801e34:	89 fa                	mov    %edi,%edx
  801e36:	83 c4 1c             	add    $0x1c,%esp
  801e39:	5b                   	pop    %ebx
  801e3a:	5e                   	pop    %esi
  801e3b:	5f                   	pop    %edi
  801e3c:	5d                   	pop    %ebp
  801e3d:	c3                   	ret    
  801e3e:	66 90                	xchg   %ax,%ax
  801e40:	89 d8                	mov    %ebx,%eax
  801e42:	f7 f7                	div    %edi
  801e44:	31 ff                	xor    %edi,%edi
  801e46:	89 fa                	mov    %edi,%edx
  801e48:	83 c4 1c             	add    $0x1c,%esp
  801e4b:	5b                   	pop    %ebx
  801e4c:	5e                   	pop    %esi
  801e4d:	5f                   	pop    %edi
  801e4e:	5d                   	pop    %ebp
  801e4f:	c3                   	ret    
  801e50:	bd 20 00 00 00       	mov    $0x20,%ebp
  801e55:	89 eb                	mov    %ebp,%ebx
  801e57:	29 fb                	sub    %edi,%ebx
  801e59:	89 f9                	mov    %edi,%ecx
  801e5b:	d3 e6                	shl    %cl,%esi
  801e5d:	89 c5                	mov    %eax,%ebp
  801e5f:	88 d9                	mov    %bl,%cl
  801e61:	d3 ed                	shr    %cl,%ebp
  801e63:	89 e9                	mov    %ebp,%ecx
  801e65:	09 f1                	or     %esi,%ecx
  801e67:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801e6b:	89 f9                	mov    %edi,%ecx
  801e6d:	d3 e0                	shl    %cl,%eax
  801e6f:	89 c5                	mov    %eax,%ebp
  801e71:	89 d6                	mov    %edx,%esi
  801e73:	88 d9                	mov    %bl,%cl
  801e75:	d3 ee                	shr    %cl,%esi
  801e77:	89 f9                	mov    %edi,%ecx
  801e79:	d3 e2                	shl    %cl,%edx
  801e7b:	8b 44 24 08          	mov    0x8(%esp),%eax
  801e7f:	88 d9                	mov    %bl,%cl
  801e81:	d3 e8                	shr    %cl,%eax
  801e83:	09 c2                	or     %eax,%edx
  801e85:	89 d0                	mov    %edx,%eax
  801e87:	89 f2                	mov    %esi,%edx
  801e89:	f7 74 24 0c          	divl   0xc(%esp)
  801e8d:	89 d6                	mov    %edx,%esi
  801e8f:	89 c3                	mov    %eax,%ebx
  801e91:	f7 e5                	mul    %ebp
  801e93:	39 d6                	cmp    %edx,%esi
  801e95:	72 19                	jb     801eb0 <__udivdi3+0xfc>
  801e97:	74 0b                	je     801ea4 <__udivdi3+0xf0>
  801e99:	89 d8                	mov    %ebx,%eax
  801e9b:	31 ff                	xor    %edi,%edi
  801e9d:	e9 58 ff ff ff       	jmp    801dfa <__udivdi3+0x46>
  801ea2:	66 90                	xchg   %ax,%ax
  801ea4:	8b 54 24 08          	mov    0x8(%esp),%edx
  801ea8:	89 f9                	mov    %edi,%ecx
  801eaa:	d3 e2                	shl    %cl,%edx
  801eac:	39 c2                	cmp    %eax,%edx
  801eae:	73 e9                	jae    801e99 <__udivdi3+0xe5>
  801eb0:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801eb3:	31 ff                	xor    %edi,%edi
  801eb5:	e9 40 ff ff ff       	jmp    801dfa <__udivdi3+0x46>
  801eba:	66 90                	xchg   %ax,%ax
  801ebc:	31 c0                	xor    %eax,%eax
  801ebe:	e9 37 ff ff ff       	jmp    801dfa <__udivdi3+0x46>
  801ec3:	90                   	nop

00801ec4 <__umoddi3>:
  801ec4:	55                   	push   %ebp
  801ec5:	57                   	push   %edi
  801ec6:	56                   	push   %esi
  801ec7:	53                   	push   %ebx
  801ec8:	83 ec 1c             	sub    $0x1c,%esp
  801ecb:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801ecf:	8b 74 24 34          	mov    0x34(%esp),%esi
  801ed3:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801ed7:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801edb:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801edf:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801ee3:	89 f3                	mov    %esi,%ebx
  801ee5:	89 fa                	mov    %edi,%edx
  801ee7:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801eeb:	89 34 24             	mov    %esi,(%esp)
  801eee:	85 c0                	test   %eax,%eax
  801ef0:	75 1a                	jne    801f0c <__umoddi3+0x48>
  801ef2:	39 f7                	cmp    %esi,%edi
  801ef4:	0f 86 a2 00 00 00    	jbe    801f9c <__umoddi3+0xd8>
  801efa:	89 c8                	mov    %ecx,%eax
  801efc:	89 f2                	mov    %esi,%edx
  801efe:	f7 f7                	div    %edi
  801f00:	89 d0                	mov    %edx,%eax
  801f02:	31 d2                	xor    %edx,%edx
  801f04:	83 c4 1c             	add    $0x1c,%esp
  801f07:	5b                   	pop    %ebx
  801f08:	5e                   	pop    %esi
  801f09:	5f                   	pop    %edi
  801f0a:	5d                   	pop    %ebp
  801f0b:	c3                   	ret    
  801f0c:	39 f0                	cmp    %esi,%eax
  801f0e:	0f 87 ac 00 00 00    	ja     801fc0 <__umoddi3+0xfc>
  801f14:	0f bd e8             	bsr    %eax,%ebp
  801f17:	83 f5 1f             	xor    $0x1f,%ebp
  801f1a:	0f 84 ac 00 00 00    	je     801fcc <__umoddi3+0x108>
  801f20:	bf 20 00 00 00       	mov    $0x20,%edi
  801f25:	29 ef                	sub    %ebp,%edi
  801f27:	89 fe                	mov    %edi,%esi
  801f29:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801f2d:	89 e9                	mov    %ebp,%ecx
  801f2f:	d3 e0                	shl    %cl,%eax
  801f31:	89 d7                	mov    %edx,%edi
  801f33:	89 f1                	mov    %esi,%ecx
  801f35:	d3 ef                	shr    %cl,%edi
  801f37:	09 c7                	or     %eax,%edi
  801f39:	89 e9                	mov    %ebp,%ecx
  801f3b:	d3 e2                	shl    %cl,%edx
  801f3d:	89 14 24             	mov    %edx,(%esp)
  801f40:	89 d8                	mov    %ebx,%eax
  801f42:	d3 e0                	shl    %cl,%eax
  801f44:	89 c2                	mov    %eax,%edx
  801f46:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f4a:	d3 e0                	shl    %cl,%eax
  801f4c:	89 44 24 04          	mov    %eax,0x4(%esp)
  801f50:	8b 44 24 08          	mov    0x8(%esp),%eax
  801f54:	89 f1                	mov    %esi,%ecx
  801f56:	d3 e8                	shr    %cl,%eax
  801f58:	09 d0                	or     %edx,%eax
  801f5a:	d3 eb                	shr    %cl,%ebx
  801f5c:	89 da                	mov    %ebx,%edx
  801f5e:	f7 f7                	div    %edi
  801f60:	89 d3                	mov    %edx,%ebx
  801f62:	f7 24 24             	mull   (%esp)
  801f65:	89 c6                	mov    %eax,%esi
  801f67:	89 d1                	mov    %edx,%ecx
  801f69:	39 d3                	cmp    %edx,%ebx
  801f6b:	0f 82 87 00 00 00    	jb     801ff8 <__umoddi3+0x134>
  801f71:	0f 84 91 00 00 00    	je     802008 <__umoddi3+0x144>
  801f77:	8b 54 24 04          	mov    0x4(%esp),%edx
  801f7b:	29 f2                	sub    %esi,%edx
  801f7d:	19 cb                	sbb    %ecx,%ebx
  801f7f:	89 d8                	mov    %ebx,%eax
  801f81:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801f85:	d3 e0                	shl    %cl,%eax
  801f87:	89 e9                	mov    %ebp,%ecx
  801f89:	d3 ea                	shr    %cl,%edx
  801f8b:	09 d0                	or     %edx,%eax
  801f8d:	89 e9                	mov    %ebp,%ecx
  801f8f:	d3 eb                	shr    %cl,%ebx
  801f91:	89 da                	mov    %ebx,%edx
  801f93:	83 c4 1c             	add    $0x1c,%esp
  801f96:	5b                   	pop    %ebx
  801f97:	5e                   	pop    %esi
  801f98:	5f                   	pop    %edi
  801f99:	5d                   	pop    %ebp
  801f9a:	c3                   	ret    
  801f9b:	90                   	nop
  801f9c:	89 fd                	mov    %edi,%ebp
  801f9e:	85 ff                	test   %edi,%edi
  801fa0:	75 0b                	jne    801fad <__umoddi3+0xe9>
  801fa2:	b8 01 00 00 00       	mov    $0x1,%eax
  801fa7:	31 d2                	xor    %edx,%edx
  801fa9:	f7 f7                	div    %edi
  801fab:	89 c5                	mov    %eax,%ebp
  801fad:	89 f0                	mov    %esi,%eax
  801faf:	31 d2                	xor    %edx,%edx
  801fb1:	f7 f5                	div    %ebp
  801fb3:	89 c8                	mov    %ecx,%eax
  801fb5:	f7 f5                	div    %ebp
  801fb7:	89 d0                	mov    %edx,%eax
  801fb9:	e9 44 ff ff ff       	jmp    801f02 <__umoddi3+0x3e>
  801fbe:	66 90                	xchg   %ax,%ax
  801fc0:	89 c8                	mov    %ecx,%eax
  801fc2:	89 f2                	mov    %esi,%edx
  801fc4:	83 c4 1c             	add    $0x1c,%esp
  801fc7:	5b                   	pop    %ebx
  801fc8:	5e                   	pop    %esi
  801fc9:	5f                   	pop    %edi
  801fca:	5d                   	pop    %ebp
  801fcb:	c3                   	ret    
  801fcc:	3b 04 24             	cmp    (%esp),%eax
  801fcf:	72 06                	jb     801fd7 <__umoddi3+0x113>
  801fd1:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801fd5:	77 0f                	ja     801fe6 <__umoddi3+0x122>
  801fd7:	89 f2                	mov    %esi,%edx
  801fd9:	29 f9                	sub    %edi,%ecx
  801fdb:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801fdf:	89 14 24             	mov    %edx,(%esp)
  801fe2:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801fe6:	8b 44 24 04          	mov    0x4(%esp),%eax
  801fea:	8b 14 24             	mov    (%esp),%edx
  801fed:	83 c4 1c             	add    $0x1c,%esp
  801ff0:	5b                   	pop    %ebx
  801ff1:	5e                   	pop    %esi
  801ff2:	5f                   	pop    %edi
  801ff3:	5d                   	pop    %ebp
  801ff4:	c3                   	ret    
  801ff5:	8d 76 00             	lea    0x0(%esi),%esi
  801ff8:	2b 04 24             	sub    (%esp),%eax
  801ffb:	19 fa                	sbb    %edi,%edx
  801ffd:	89 d1                	mov    %edx,%ecx
  801fff:	89 c6                	mov    %eax,%esi
  802001:	e9 71 ff ff ff       	jmp    801f77 <__umoddi3+0xb3>
  802006:	66 90                	xchg   %ax,%ax
  802008:	39 44 24 04          	cmp    %eax,0x4(%esp)
  80200c:	72 ea                	jb     801ff8 <__umoddi3+0x134>
  80200e:	89 d9                	mov    %ebx,%ecx
  802010:	e9 62 ff ff ff       	jmp    801f77 <__umoddi3+0xb3>
