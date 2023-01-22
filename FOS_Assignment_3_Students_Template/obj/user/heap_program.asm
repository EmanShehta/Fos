
obj/user/heap_program:     file format elf32-i386


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
  800031:	e8 f3 01 00 00       	call   800229 <libmain>
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
  80003e:	83 ec 5c             	sub    $0x5c,%esp
	int kilo = 1024;
  800041:	c7 45 d8 00 04 00 00 	movl   $0x400,-0x28(%ebp)
	int Mega = 1024*1024;
  800048:	c7 45 d4 00 00 10 00 	movl   $0x100000,-0x2c(%ebp)

	/// testing freeHeap()
	{
		uint32 size = 13*Mega;
  80004f:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800052:	89 d0                	mov    %edx,%eax
  800054:	01 c0                	add    %eax,%eax
  800056:	01 d0                	add    %edx,%eax
  800058:	c1 e0 02             	shl    $0x2,%eax
  80005b:	01 d0                	add    %edx,%eax
  80005d:	89 45 d0             	mov    %eax,-0x30(%ebp)
		char *x = malloc(sizeof( char)*size) ;
  800060:	83 ec 0c             	sub    $0xc,%esp
  800063:	ff 75 d0             	pushl  -0x30(%ebp)
  800066:	e8 18 13 00 00       	call   801383 <malloc>
  80006b:	83 c4 10             	add    $0x10,%esp
  80006e:	89 45 cc             	mov    %eax,-0x34(%ebp)

		char *y = malloc(sizeof( char)*size) ;
  800071:	83 ec 0c             	sub    $0xc,%esp
  800074:	ff 75 d0             	pushl  -0x30(%ebp)
  800077:	e8 07 13 00 00       	call   801383 <malloc>
  80007c:	83 c4 10             	add    $0x10,%esp
  80007f:	89 45 c8             	mov    %eax,-0x38(%ebp)


		int usedDiskPages = sys_pf_calculate_allocated_pages() ;
  800082:	e8 db 15 00 00       	call   801662 <sys_pf_calculate_allocated_pages>
  800087:	89 45 c4             	mov    %eax,-0x3c(%ebp)

		x[1]=-1;
  80008a:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80008d:	40                   	inc    %eax
  80008e:	c6 00 ff             	movb   $0xff,(%eax)

		x[5*Mega]=-1;
  800091:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  800094:	89 d0                	mov    %edx,%eax
  800096:	c1 e0 02             	shl    $0x2,%eax
  800099:	01 d0                	add    %edx,%eax
  80009b:	89 c2                	mov    %eax,%edx
  80009d:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000a0:	01 d0                	add    %edx,%eax
  8000a2:	c6 00 ff             	movb   $0xff,(%eax)

		x[8*Mega] = -1;
  8000a5:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  8000a8:	c1 e0 03             	shl    $0x3,%eax
  8000ab:	89 c2                	mov    %eax,%edx
  8000ad:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000b0:	01 d0                	add    %edx,%eax
  8000b2:	c6 00 ff             	movb   $0xff,(%eax)

		x[12*Mega]=-1;
  8000b5:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  8000b8:	89 d0                	mov    %edx,%eax
  8000ba:	01 c0                	add    %eax,%eax
  8000bc:	01 d0                	add    %edx,%eax
  8000be:	c1 e0 02             	shl    $0x2,%eax
  8000c1:	89 c2                	mov    %eax,%edx
  8000c3:	8b 45 cc             	mov    -0x34(%ebp),%eax
  8000c6:	01 d0                	add    %edx,%eax
  8000c8:	c6 00 ff             	movb   $0xff,(%eax)

		//int usedDiskPages = sys_pf_calculate_allocated_pages() ;

		free(x);
  8000cb:	83 ec 0c             	sub    $0xc,%esp
  8000ce:	ff 75 cc             	pushl  -0x34(%ebp)
  8000d1:	e8 c7 12 00 00       	call   80139d <free>
  8000d6:	83 c4 10             	add    $0x10,%esp
		free(y);
  8000d9:	83 ec 0c             	sub    $0xc,%esp
  8000dc:	ff 75 c8             	pushl  -0x38(%ebp)
  8000df:	e8 b9 12 00 00       	call   80139d <free>
  8000e4:	83 c4 10             	add    $0x10,%esp

		///		cprintf("%d\n",sys_pf_calculate_allocated_pages() - usedDiskPages);
		///assert((sys_pf_calculate_allocated_pages() - usedDiskPages) == 5 ); //4 pages + 1 table, that was not in WS

		int freePages = sys_calculate_free_frames();
  8000e7:	e8 f3 14 00 00       	call   8015df <sys_calculate_free_frames>
  8000ec:	89 45 c0             	mov    %eax,-0x40(%ebp)

		x = malloc(sizeof(char)*size) ;
  8000ef:	83 ec 0c             	sub    $0xc,%esp
  8000f2:	ff 75 d0             	pushl  -0x30(%ebp)
  8000f5:	e8 89 12 00 00       	call   801383 <malloc>
  8000fa:	83 c4 10             	add    $0x10,%esp
  8000fd:	89 45 cc             	mov    %eax,-0x34(%ebp)

		x[1]=-2;
  800100:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800103:	40                   	inc    %eax
  800104:	c6 00 fe             	movb   $0xfe,(%eax)

		x[5*Mega]=-2;
  800107:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80010a:	89 d0                	mov    %edx,%eax
  80010c:	c1 e0 02             	shl    $0x2,%eax
  80010f:	01 d0                	add    %edx,%eax
  800111:	89 c2                	mov    %eax,%edx
  800113:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800116:	01 d0                	add    %edx,%eax
  800118:	c6 00 fe             	movb   $0xfe,(%eax)

		x[8*Mega] = -2;
  80011b:	8b 45 d4             	mov    -0x2c(%ebp),%eax
  80011e:	c1 e0 03             	shl    $0x3,%eax
  800121:	89 c2                	mov    %eax,%edx
  800123:	8b 45 cc             	mov    -0x34(%ebp),%eax
  800126:	01 d0                	add    %edx,%eax
  800128:	c6 00 fe             	movb   $0xfe,(%eax)

		x[12*Mega]=-2;
  80012b:	8b 55 d4             	mov    -0x2c(%ebp),%edx
  80012e:	89 d0                	mov    %edx,%eax
  800130:	01 c0                	add    %eax,%eax
  800132:	01 d0                	add    %edx,%eax
  800134:	c1 e0 02             	shl    $0x2,%eax
  800137:	89 c2                	mov    %eax,%edx
  800139:	8b 45 cc             	mov    -0x34(%ebp),%eax
  80013c:	01 d0                	add    %edx,%eax
  80013e:	c6 00 fe             	movb   $0xfe,(%eax)

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};
  800141:	8d 45 9c             	lea    -0x64(%ebp),%eax
  800144:	bb 20 1e 80 00       	mov    $0x801e20,%ebx
  800149:	ba 08 00 00 00       	mov    $0x8,%edx
  80014e:	89 c7                	mov    %eax,%edi
  800150:	89 de                	mov    %ebx,%esi
  800152:	89 d1                	mov    %edx,%ecx
  800154:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

		int i = 0, j ;
  800156:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
		for (; i < (myEnv->page_WS_max_size); i++)
  80015d:	eb 79                	jmp    8001d8 <_main+0x1a0>
		{
			int found = 0 ;
  80015f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  800166:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  80016d:	eb 3d                	jmp    8001ac <_main+0x174>
			{
				if (pageWSEntries[i] == ROUNDDOWN(myEnv->__uptr_pws[j].virtual_address,PAGE_SIZE) )
  80016f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  800172:	8b 4c 85 9c          	mov    -0x64(%ebp,%eax,4),%ecx
  800176:	a1 20 30 80 00       	mov    0x803020,%eax
  80017b:	8b 98 9c 05 00 00    	mov    0x59c(%eax),%ebx
  800181:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800184:	89 d0                	mov    %edx,%eax
  800186:	01 c0                	add    %eax,%eax
  800188:	01 d0                	add    %edx,%eax
  80018a:	c1 e0 03             	shl    $0x3,%eax
  80018d:	01 d8                	add    %ebx,%eax
  80018f:	8b 00                	mov    (%eax),%eax
  800191:	89 45 bc             	mov    %eax,-0x44(%ebp)
  800194:	8b 45 bc             	mov    -0x44(%ebp),%eax
  800197:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80019c:	39 c1                	cmp    %eax,%ecx
  80019e:	75 09                	jne    8001a9 <_main+0x171>
				{
					found = 1 ;
  8001a0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
					break;
  8001a7:	eb 12                	jmp    8001bb <_main+0x183>

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
		{
			int found = 0 ;
			for (j=0; j < (myEnv->page_WS_max_size); j++)
  8001a9:	ff 45 e0             	incl   -0x20(%ebp)
  8001ac:	a1 20 30 80 00       	mov    0x803020,%eax
  8001b1:	8b 50 74             	mov    0x74(%eax),%edx
  8001b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8001b7:	39 c2                	cmp    %eax,%edx
  8001b9:	77 b4                	ja     80016f <_main+0x137>
				{
					found = 1 ;
					break;
				}
			}
			if (!found)
  8001bb:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8001bf:	75 14                	jne    8001d5 <_main+0x19d>
				panic("PAGE Placement algorithm failed after applying freeHeap");
  8001c1:	83 ec 04             	sub    $0x4,%esp
  8001c4:	68 60 1d 80 00       	push   $0x801d60
  8001c9:	6a 41                	push   $0x41
  8001cb:	68 98 1d 80 00       	push   $0x801d98
  8001d0:	e8 70 01 00 00       	call   800345 <_panic>
		x[12*Mega]=-2;

		uint32 pageWSEntries[8] = {0x802000, 0x80500000, 0x80800000, 0x80c00000, 0x80000000, 0x801000, 0x800000, 0xeebfd000};

		int i = 0, j ;
		for (; i < (myEnv->page_WS_max_size); i++)
  8001d5:	ff 45 e4             	incl   -0x1c(%ebp)
  8001d8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001dd:	8b 50 74             	mov    0x74(%eax),%edx
  8001e0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  8001e3:	39 c2                	cmp    %eax,%edx
  8001e5:	0f 87 74 ff ff ff    	ja     80015f <_main+0x127>
			if (!found)
				panic("PAGE Placement algorithm failed after applying freeHeap");
		}


		if( (freePages - sys_calculate_free_frames() ) != 8 ) panic("Extra/Less memory are wrongly allocated");
  8001eb:	8b 5d c0             	mov    -0x40(%ebp),%ebx
  8001ee:	e8 ec 13 00 00       	call   8015df <sys_calculate_free_frames>
  8001f3:	29 c3                	sub    %eax,%ebx
  8001f5:	89 d8                	mov    %ebx,%eax
  8001f7:	83 f8 08             	cmp    $0x8,%eax
  8001fa:	74 14                	je     800210 <_main+0x1d8>
  8001fc:	83 ec 04             	sub    $0x4,%esp
  8001ff:	68 ac 1d 80 00       	push   $0x801dac
  800204:	6a 45                	push   $0x45
  800206:	68 98 1d 80 00       	push   $0x801d98
  80020b:	e8 35 01 00 00       	call   800345 <_panic>
	}

	cprintf("Congratulations!! test HEAP_PROGRAM completed successfully.\n");
  800210:	83 ec 0c             	sub    $0xc,%esp
  800213:	68 d4 1d 80 00       	push   $0x801dd4
  800218:	e8 dc 03 00 00       	call   8005f9 <cprintf>
  80021d:	83 c4 10             	add    $0x10,%esp


	return;
  800220:	90                   	nop
}
  800221:	8d 65 f4             	lea    -0xc(%ebp),%esp
  800224:	5b                   	pop    %ebx
  800225:	5e                   	pop    %esi
  800226:	5f                   	pop    %edi
  800227:	5d                   	pop    %ebp
  800228:	c3                   	ret    

00800229 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800229:	55                   	push   %ebp
  80022a:	89 e5                	mov    %esp,%ebp
  80022c:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80022f:	e8 e0 12 00 00       	call   801514 <sys_getenvindex>
  800234:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800237:	8b 55 f4             	mov    -0xc(%ebp),%edx
  80023a:	89 d0                	mov    %edx,%eax
  80023c:	01 c0                	add    %eax,%eax
  80023e:	01 d0                	add    %edx,%eax
  800240:	c1 e0 04             	shl    $0x4,%eax
  800243:	29 d0                	sub    %edx,%eax
  800245:	c1 e0 03             	shl    $0x3,%eax
  800248:	01 d0                	add    %edx,%eax
  80024a:	c1 e0 02             	shl    $0x2,%eax
  80024d:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800252:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800257:	a1 20 30 80 00       	mov    0x803020,%eax
  80025c:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800262:	84 c0                	test   %al,%al
  800264:	74 0f                	je     800275 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800266:	a1 20 30 80 00       	mov    0x803020,%eax
  80026b:	05 5c 05 00 00       	add    $0x55c,%eax
  800270:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800275:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800279:	7e 0a                	jle    800285 <libmain+0x5c>
		binaryname = argv[0];
  80027b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80027e:	8b 00                	mov    (%eax),%eax
  800280:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800285:	83 ec 08             	sub    $0x8,%esp
  800288:	ff 75 0c             	pushl  0xc(%ebp)
  80028b:	ff 75 08             	pushl  0x8(%ebp)
  80028e:	e8 a5 fd ff ff       	call   800038 <_main>
  800293:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  800296:	e8 14 14 00 00       	call   8016af <sys_disable_interrupt>
	cprintf("**************************************\n");
  80029b:	83 ec 0c             	sub    $0xc,%esp
  80029e:	68 58 1e 80 00       	push   $0x801e58
  8002a3:	e8 51 03 00 00       	call   8005f9 <cprintf>
  8002a8:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8002ab:	a1 20 30 80 00       	mov    0x803020,%eax
  8002b0:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8002b6:	a1 20 30 80 00       	mov    0x803020,%eax
  8002bb:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8002c1:	83 ec 04             	sub    $0x4,%esp
  8002c4:	52                   	push   %edx
  8002c5:	50                   	push   %eax
  8002c6:	68 80 1e 80 00       	push   $0x801e80
  8002cb:	e8 29 03 00 00       	call   8005f9 <cprintf>
  8002d0:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8002d3:	a1 20 30 80 00       	mov    0x803020,%eax
  8002d8:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8002de:	a1 20 30 80 00       	mov    0x803020,%eax
  8002e3:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8002e9:	a1 20 30 80 00       	mov    0x803020,%eax
  8002ee:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  8002f4:	51                   	push   %ecx
  8002f5:	52                   	push   %edx
  8002f6:	50                   	push   %eax
  8002f7:	68 a8 1e 80 00       	push   $0x801ea8
  8002fc:	e8 f8 02 00 00       	call   8005f9 <cprintf>
  800301:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800304:	83 ec 0c             	sub    $0xc,%esp
  800307:	68 58 1e 80 00       	push   $0x801e58
  80030c:	e8 e8 02 00 00       	call   8005f9 <cprintf>
  800311:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800314:	e8 b0 13 00 00       	call   8016c9 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800319:	e8 19 00 00 00       	call   800337 <exit>
}
  80031e:	90                   	nop
  80031f:	c9                   	leave  
  800320:	c3                   	ret    

00800321 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800321:	55                   	push   %ebp
  800322:	89 e5                	mov    %esp,%ebp
  800324:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800327:	83 ec 0c             	sub    $0xc,%esp
  80032a:	6a 00                	push   $0x0
  80032c:	e8 af 11 00 00       	call   8014e0 <sys_env_destroy>
  800331:	83 c4 10             	add    $0x10,%esp
}
  800334:	90                   	nop
  800335:	c9                   	leave  
  800336:	c3                   	ret    

00800337 <exit>:

void
exit(void)
{
  800337:	55                   	push   %ebp
  800338:	89 e5                	mov    %esp,%ebp
  80033a:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80033d:	e8 04 12 00 00       	call   801546 <sys_env_exit>
}
  800342:	90                   	nop
  800343:	c9                   	leave  
  800344:	c3                   	ret    

00800345 <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  800345:	55                   	push   %ebp
  800346:	89 e5                	mov    %esp,%ebp
  800348:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  80034b:	8d 45 10             	lea    0x10(%ebp),%eax
  80034e:	83 c0 04             	add    $0x4,%eax
  800351:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  800354:	a1 18 31 80 00       	mov    0x803118,%eax
  800359:	85 c0                	test   %eax,%eax
  80035b:	74 16                	je     800373 <_panic+0x2e>
		cprintf("%s: ", argv0);
  80035d:	a1 18 31 80 00       	mov    0x803118,%eax
  800362:	83 ec 08             	sub    $0x8,%esp
  800365:	50                   	push   %eax
  800366:	68 00 1f 80 00       	push   $0x801f00
  80036b:	e8 89 02 00 00       	call   8005f9 <cprintf>
  800370:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  800373:	a1 00 30 80 00       	mov    0x803000,%eax
  800378:	ff 75 0c             	pushl  0xc(%ebp)
  80037b:	ff 75 08             	pushl  0x8(%ebp)
  80037e:	50                   	push   %eax
  80037f:	68 05 1f 80 00       	push   $0x801f05
  800384:	e8 70 02 00 00       	call   8005f9 <cprintf>
  800389:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  80038c:	8b 45 10             	mov    0x10(%ebp),%eax
  80038f:	83 ec 08             	sub    $0x8,%esp
  800392:	ff 75 f4             	pushl  -0xc(%ebp)
  800395:	50                   	push   %eax
  800396:	e8 f3 01 00 00       	call   80058e <vcprintf>
  80039b:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  80039e:	83 ec 08             	sub    $0x8,%esp
  8003a1:	6a 00                	push   $0x0
  8003a3:	68 21 1f 80 00       	push   $0x801f21
  8003a8:	e8 e1 01 00 00       	call   80058e <vcprintf>
  8003ad:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  8003b0:	e8 82 ff ff ff       	call   800337 <exit>

	// should not return here
	while (1) ;
  8003b5:	eb fe                	jmp    8003b5 <_panic+0x70>

008003b7 <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  8003b7:	55                   	push   %ebp
  8003b8:	89 e5                	mov    %esp,%ebp
  8003ba:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  8003bd:	a1 20 30 80 00       	mov    0x803020,%eax
  8003c2:	8b 50 74             	mov    0x74(%eax),%edx
  8003c5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8003c8:	39 c2                	cmp    %eax,%edx
  8003ca:	74 14                	je     8003e0 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8003cc:	83 ec 04             	sub    $0x4,%esp
  8003cf:	68 24 1f 80 00       	push   $0x801f24
  8003d4:	6a 26                	push   $0x26
  8003d6:	68 70 1f 80 00       	push   $0x801f70
  8003db:	e8 65 ff ff ff       	call   800345 <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8003e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8003e7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8003ee:	e9 c2 00 00 00       	jmp    8004b5 <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8003f3:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8003f6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8003fd:	8b 45 08             	mov    0x8(%ebp),%eax
  800400:	01 d0                	add    %edx,%eax
  800402:	8b 00                	mov    (%eax),%eax
  800404:	85 c0                	test   %eax,%eax
  800406:	75 08                	jne    800410 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  800408:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  80040b:	e9 a2 00 00 00       	jmp    8004b2 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  800410:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800417:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  80041e:	eb 69                	jmp    800489 <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  800420:	a1 20 30 80 00       	mov    0x803020,%eax
  800425:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80042b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80042e:	89 d0                	mov    %edx,%eax
  800430:	01 c0                	add    %eax,%eax
  800432:	01 d0                	add    %edx,%eax
  800434:	c1 e0 03             	shl    $0x3,%eax
  800437:	01 c8                	add    %ecx,%eax
  800439:	8a 40 04             	mov    0x4(%eax),%al
  80043c:	84 c0                	test   %al,%al
  80043e:	75 46                	jne    800486 <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800440:	a1 20 30 80 00       	mov    0x803020,%eax
  800445:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  80044b:	8b 55 e8             	mov    -0x18(%ebp),%edx
  80044e:	89 d0                	mov    %edx,%eax
  800450:	01 c0                	add    %eax,%eax
  800452:	01 d0                	add    %edx,%eax
  800454:	c1 e0 03             	shl    $0x3,%eax
  800457:	01 c8                	add    %ecx,%eax
  800459:	8b 00                	mov    (%eax),%eax
  80045b:	89 45 dc             	mov    %eax,-0x24(%ebp)
  80045e:	8b 45 dc             	mov    -0x24(%ebp),%eax
  800461:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  800466:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  800468:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80046b:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  800472:	8b 45 08             	mov    0x8(%ebp),%eax
  800475:	01 c8                	add    %ecx,%eax
  800477:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  800479:	39 c2                	cmp    %eax,%edx
  80047b:	75 09                	jne    800486 <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  80047d:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  800484:	eb 12                	jmp    800498 <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  800486:	ff 45 e8             	incl   -0x18(%ebp)
  800489:	a1 20 30 80 00       	mov    0x803020,%eax
  80048e:	8b 50 74             	mov    0x74(%eax),%edx
  800491:	8b 45 e8             	mov    -0x18(%ebp),%eax
  800494:	39 c2                	cmp    %eax,%edx
  800496:	77 88                	ja     800420 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  800498:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  80049c:	75 14                	jne    8004b2 <CheckWSWithoutLastIndex+0xfb>
			panic(
  80049e:	83 ec 04             	sub    $0x4,%esp
  8004a1:	68 7c 1f 80 00       	push   $0x801f7c
  8004a6:	6a 3a                	push   $0x3a
  8004a8:	68 70 1f 80 00       	push   $0x801f70
  8004ad:	e8 93 fe ff ff       	call   800345 <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  8004b2:	ff 45 f0             	incl   -0x10(%ebp)
  8004b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8004b8:	3b 45 0c             	cmp    0xc(%ebp),%eax
  8004bb:	0f 8c 32 ff ff ff    	jl     8003f3 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  8004c1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004c8:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8004cf:	eb 26                	jmp    8004f7 <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8004d1:	a1 20 30 80 00       	mov    0x803020,%eax
  8004d6:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8004dc:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8004df:	89 d0                	mov    %edx,%eax
  8004e1:	01 c0                	add    %eax,%eax
  8004e3:	01 d0                	add    %edx,%eax
  8004e5:	c1 e0 03             	shl    $0x3,%eax
  8004e8:	01 c8                	add    %ecx,%eax
  8004ea:	8a 40 04             	mov    0x4(%eax),%al
  8004ed:	3c 01                	cmp    $0x1,%al
  8004ef:	75 03                	jne    8004f4 <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8004f1:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8004f4:	ff 45 e0             	incl   -0x20(%ebp)
  8004f7:	a1 20 30 80 00       	mov    0x803020,%eax
  8004fc:	8b 50 74             	mov    0x74(%eax),%edx
  8004ff:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800502:	39 c2                	cmp    %eax,%edx
  800504:	77 cb                	ja     8004d1 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  800506:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800509:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  80050c:	74 14                	je     800522 <CheckWSWithoutLastIndex+0x16b>
		panic(
  80050e:	83 ec 04             	sub    $0x4,%esp
  800511:	68 d0 1f 80 00       	push   $0x801fd0
  800516:	6a 44                	push   $0x44
  800518:	68 70 1f 80 00       	push   $0x801f70
  80051d:	e8 23 fe ff ff       	call   800345 <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  800522:	90                   	nop
  800523:	c9                   	leave  
  800524:	c3                   	ret    

00800525 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800525:	55                   	push   %ebp
  800526:	89 e5                	mov    %esp,%ebp
  800528:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80052b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80052e:	8b 00                	mov    (%eax),%eax
  800530:	8d 48 01             	lea    0x1(%eax),%ecx
  800533:	8b 55 0c             	mov    0xc(%ebp),%edx
  800536:	89 0a                	mov    %ecx,(%edx)
  800538:	8b 55 08             	mov    0x8(%ebp),%edx
  80053b:	88 d1                	mov    %dl,%cl
  80053d:	8b 55 0c             	mov    0xc(%ebp),%edx
  800540:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800544:	8b 45 0c             	mov    0xc(%ebp),%eax
  800547:	8b 00                	mov    (%eax),%eax
  800549:	3d ff 00 00 00       	cmp    $0xff,%eax
  80054e:	75 2c                	jne    80057c <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  800550:	a0 24 30 80 00       	mov    0x803024,%al
  800555:	0f b6 c0             	movzbl %al,%eax
  800558:	8b 55 0c             	mov    0xc(%ebp),%edx
  80055b:	8b 12                	mov    (%edx),%edx
  80055d:	89 d1                	mov    %edx,%ecx
  80055f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800562:	83 c2 08             	add    $0x8,%edx
  800565:	83 ec 04             	sub    $0x4,%esp
  800568:	50                   	push   %eax
  800569:	51                   	push   %ecx
  80056a:	52                   	push   %edx
  80056b:	e8 2e 0f 00 00       	call   80149e <sys_cputs>
  800570:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  800573:	8b 45 0c             	mov    0xc(%ebp),%eax
  800576:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  80057c:	8b 45 0c             	mov    0xc(%ebp),%eax
  80057f:	8b 40 04             	mov    0x4(%eax),%eax
  800582:	8d 50 01             	lea    0x1(%eax),%edx
  800585:	8b 45 0c             	mov    0xc(%ebp),%eax
  800588:	89 50 04             	mov    %edx,0x4(%eax)
}
  80058b:	90                   	nop
  80058c:	c9                   	leave  
  80058d:	c3                   	ret    

0080058e <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  80058e:	55                   	push   %ebp
  80058f:	89 e5                	mov    %esp,%ebp
  800591:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  800597:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  80059e:	00 00 00 
	b.cnt = 0;
  8005a1:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8005a8:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8005ab:	ff 75 0c             	pushl  0xc(%ebp)
  8005ae:	ff 75 08             	pushl  0x8(%ebp)
  8005b1:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005b7:	50                   	push   %eax
  8005b8:	68 25 05 80 00       	push   $0x800525
  8005bd:	e8 11 02 00 00       	call   8007d3 <vprintfmt>
  8005c2:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8005c5:	a0 24 30 80 00       	mov    0x803024,%al
  8005ca:	0f b6 c0             	movzbl %al,%eax
  8005cd:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  8005d3:	83 ec 04             	sub    $0x4,%esp
  8005d6:	50                   	push   %eax
  8005d7:	52                   	push   %edx
  8005d8:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8005de:	83 c0 08             	add    $0x8,%eax
  8005e1:	50                   	push   %eax
  8005e2:	e8 b7 0e 00 00       	call   80149e <sys_cputs>
  8005e7:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  8005ea:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  8005f1:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  8005f7:	c9                   	leave  
  8005f8:	c3                   	ret    

008005f9 <cprintf>:

int cprintf(const char *fmt, ...) {
  8005f9:	55                   	push   %ebp
  8005fa:	89 e5                	mov    %esp,%ebp
  8005fc:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  8005ff:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800606:	8d 45 0c             	lea    0xc(%ebp),%eax
  800609:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80060c:	8b 45 08             	mov    0x8(%ebp),%eax
  80060f:	83 ec 08             	sub    $0x8,%esp
  800612:	ff 75 f4             	pushl  -0xc(%ebp)
  800615:	50                   	push   %eax
  800616:	e8 73 ff ff ff       	call   80058e <vcprintf>
  80061b:	83 c4 10             	add    $0x10,%esp
  80061e:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800621:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800624:	c9                   	leave  
  800625:	c3                   	ret    

00800626 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800626:	55                   	push   %ebp
  800627:	89 e5                	mov    %esp,%ebp
  800629:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80062c:	e8 7e 10 00 00       	call   8016af <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800631:	8d 45 0c             	lea    0xc(%ebp),%eax
  800634:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800637:	8b 45 08             	mov    0x8(%ebp),%eax
  80063a:	83 ec 08             	sub    $0x8,%esp
  80063d:	ff 75 f4             	pushl  -0xc(%ebp)
  800640:	50                   	push   %eax
  800641:	e8 48 ff ff ff       	call   80058e <vcprintf>
  800646:	83 c4 10             	add    $0x10,%esp
  800649:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80064c:	e8 78 10 00 00       	call   8016c9 <sys_enable_interrupt>
	return cnt;
  800651:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800654:	c9                   	leave  
  800655:	c3                   	ret    

00800656 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800656:	55                   	push   %ebp
  800657:	89 e5                	mov    %esp,%ebp
  800659:	53                   	push   %ebx
  80065a:	83 ec 14             	sub    $0x14,%esp
  80065d:	8b 45 10             	mov    0x10(%ebp),%eax
  800660:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800663:	8b 45 14             	mov    0x14(%ebp),%eax
  800666:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800669:	8b 45 18             	mov    0x18(%ebp),%eax
  80066c:	ba 00 00 00 00       	mov    $0x0,%edx
  800671:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800674:	77 55                	ja     8006cb <printnum+0x75>
  800676:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  800679:	72 05                	jb     800680 <printnum+0x2a>
  80067b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80067e:	77 4b                	ja     8006cb <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  800680:	8b 45 1c             	mov    0x1c(%ebp),%eax
  800683:	8d 58 ff             	lea    -0x1(%eax),%ebx
  800686:	8b 45 18             	mov    0x18(%ebp),%eax
  800689:	ba 00 00 00 00       	mov    $0x0,%edx
  80068e:	52                   	push   %edx
  80068f:	50                   	push   %eax
  800690:	ff 75 f4             	pushl  -0xc(%ebp)
  800693:	ff 75 f0             	pushl  -0x10(%ebp)
  800696:	e8 51 14 00 00       	call   801aec <__udivdi3>
  80069b:	83 c4 10             	add    $0x10,%esp
  80069e:	83 ec 04             	sub    $0x4,%esp
  8006a1:	ff 75 20             	pushl  0x20(%ebp)
  8006a4:	53                   	push   %ebx
  8006a5:	ff 75 18             	pushl  0x18(%ebp)
  8006a8:	52                   	push   %edx
  8006a9:	50                   	push   %eax
  8006aa:	ff 75 0c             	pushl  0xc(%ebp)
  8006ad:	ff 75 08             	pushl  0x8(%ebp)
  8006b0:	e8 a1 ff ff ff       	call   800656 <printnum>
  8006b5:	83 c4 20             	add    $0x20,%esp
  8006b8:	eb 1a                	jmp    8006d4 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8006ba:	83 ec 08             	sub    $0x8,%esp
  8006bd:	ff 75 0c             	pushl  0xc(%ebp)
  8006c0:	ff 75 20             	pushl  0x20(%ebp)
  8006c3:	8b 45 08             	mov    0x8(%ebp),%eax
  8006c6:	ff d0                	call   *%eax
  8006c8:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8006cb:	ff 4d 1c             	decl   0x1c(%ebp)
  8006ce:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  8006d2:	7f e6                	jg     8006ba <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  8006d4:	8b 4d 18             	mov    0x18(%ebp),%ecx
  8006d7:	bb 00 00 00 00       	mov    $0x0,%ebx
  8006dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8006df:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8006e2:	53                   	push   %ebx
  8006e3:	51                   	push   %ecx
  8006e4:	52                   	push   %edx
  8006e5:	50                   	push   %eax
  8006e6:	e8 11 15 00 00       	call   801bfc <__umoddi3>
  8006eb:	83 c4 10             	add    $0x10,%esp
  8006ee:	05 34 22 80 00       	add    $0x802234,%eax
  8006f3:	8a 00                	mov    (%eax),%al
  8006f5:	0f be c0             	movsbl %al,%eax
  8006f8:	83 ec 08             	sub    $0x8,%esp
  8006fb:	ff 75 0c             	pushl  0xc(%ebp)
  8006fe:	50                   	push   %eax
  8006ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800702:	ff d0                	call   *%eax
  800704:	83 c4 10             	add    $0x10,%esp
}
  800707:	90                   	nop
  800708:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80070b:	c9                   	leave  
  80070c:	c3                   	ret    

0080070d <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80070d:	55                   	push   %ebp
  80070e:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800710:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800714:	7e 1c                	jle    800732 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800716:	8b 45 08             	mov    0x8(%ebp),%eax
  800719:	8b 00                	mov    (%eax),%eax
  80071b:	8d 50 08             	lea    0x8(%eax),%edx
  80071e:	8b 45 08             	mov    0x8(%ebp),%eax
  800721:	89 10                	mov    %edx,(%eax)
  800723:	8b 45 08             	mov    0x8(%ebp),%eax
  800726:	8b 00                	mov    (%eax),%eax
  800728:	83 e8 08             	sub    $0x8,%eax
  80072b:	8b 50 04             	mov    0x4(%eax),%edx
  80072e:	8b 00                	mov    (%eax),%eax
  800730:	eb 40                	jmp    800772 <getuint+0x65>
	else if (lflag)
  800732:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800736:	74 1e                	je     800756 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800738:	8b 45 08             	mov    0x8(%ebp),%eax
  80073b:	8b 00                	mov    (%eax),%eax
  80073d:	8d 50 04             	lea    0x4(%eax),%edx
  800740:	8b 45 08             	mov    0x8(%ebp),%eax
  800743:	89 10                	mov    %edx,(%eax)
  800745:	8b 45 08             	mov    0x8(%ebp),%eax
  800748:	8b 00                	mov    (%eax),%eax
  80074a:	83 e8 04             	sub    $0x4,%eax
  80074d:	8b 00                	mov    (%eax),%eax
  80074f:	ba 00 00 00 00       	mov    $0x0,%edx
  800754:	eb 1c                	jmp    800772 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800756:	8b 45 08             	mov    0x8(%ebp),%eax
  800759:	8b 00                	mov    (%eax),%eax
  80075b:	8d 50 04             	lea    0x4(%eax),%edx
  80075e:	8b 45 08             	mov    0x8(%ebp),%eax
  800761:	89 10                	mov    %edx,(%eax)
  800763:	8b 45 08             	mov    0x8(%ebp),%eax
  800766:	8b 00                	mov    (%eax),%eax
  800768:	83 e8 04             	sub    $0x4,%eax
  80076b:	8b 00                	mov    (%eax),%eax
  80076d:	ba 00 00 00 00       	mov    $0x0,%edx
}
  800772:	5d                   	pop    %ebp
  800773:	c3                   	ret    

00800774 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  800774:	55                   	push   %ebp
  800775:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  800777:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  80077b:	7e 1c                	jle    800799 <getint+0x25>
		return va_arg(*ap, long long);
  80077d:	8b 45 08             	mov    0x8(%ebp),%eax
  800780:	8b 00                	mov    (%eax),%eax
  800782:	8d 50 08             	lea    0x8(%eax),%edx
  800785:	8b 45 08             	mov    0x8(%ebp),%eax
  800788:	89 10                	mov    %edx,(%eax)
  80078a:	8b 45 08             	mov    0x8(%ebp),%eax
  80078d:	8b 00                	mov    (%eax),%eax
  80078f:	83 e8 08             	sub    $0x8,%eax
  800792:	8b 50 04             	mov    0x4(%eax),%edx
  800795:	8b 00                	mov    (%eax),%eax
  800797:	eb 38                	jmp    8007d1 <getint+0x5d>
	else if (lflag)
  800799:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  80079d:	74 1a                	je     8007b9 <getint+0x45>
		return va_arg(*ap, long);
  80079f:	8b 45 08             	mov    0x8(%ebp),%eax
  8007a2:	8b 00                	mov    (%eax),%eax
  8007a4:	8d 50 04             	lea    0x4(%eax),%edx
  8007a7:	8b 45 08             	mov    0x8(%ebp),%eax
  8007aa:	89 10                	mov    %edx,(%eax)
  8007ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8007af:	8b 00                	mov    (%eax),%eax
  8007b1:	83 e8 04             	sub    $0x4,%eax
  8007b4:	8b 00                	mov    (%eax),%eax
  8007b6:	99                   	cltd   
  8007b7:	eb 18                	jmp    8007d1 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8007b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8007bc:	8b 00                	mov    (%eax),%eax
  8007be:	8d 50 04             	lea    0x4(%eax),%edx
  8007c1:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c4:	89 10                	mov    %edx,(%eax)
  8007c6:	8b 45 08             	mov    0x8(%ebp),%eax
  8007c9:	8b 00                	mov    (%eax),%eax
  8007cb:	83 e8 04             	sub    $0x4,%eax
  8007ce:	8b 00                	mov    (%eax),%eax
  8007d0:	99                   	cltd   
}
  8007d1:	5d                   	pop    %ebp
  8007d2:	c3                   	ret    

008007d3 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  8007d3:	55                   	push   %ebp
  8007d4:	89 e5                	mov    %esp,%ebp
  8007d6:	56                   	push   %esi
  8007d7:	53                   	push   %ebx
  8007d8:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007db:	eb 17                	jmp    8007f4 <vprintfmt+0x21>
			if (ch == '\0')
  8007dd:	85 db                	test   %ebx,%ebx
  8007df:	0f 84 af 03 00 00    	je     800b94 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  8007e5:	83 ec 08             	sub    $0x8,%esp
  8007e8:	ff 75 0c             	pushl  0xc(%ebp)
  8007eb:	53                   	push   %ebx
  8007ec:	8b 45 08             	mov    0x8(%ebp),%eax
  8007ef:	ff d0                	call   *%eax
  8007f1:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  8007f4:	8b 45 10             	mov    0x10(%ebp),%eax
  8007f7:	8d 50 01             	lea    0x1(%eax),%edx
  8007fa:	89 55 10             	mov    %edx,0x10(%ebp)
  8007fd:	8a 00                	mov    (%eax),%al
  8007ff:	0f b6 d8             	movzbl %al,%ebx
  800802:	83 fb 25             	cmp    $0x25,%ebx
  800805:	75 d6                	jne    8007dd <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800807:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80080b:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800812:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800819:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  800820:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800827:	8b 45 10             	mov    0x10(%ebp),%eax
  80082a:	8d 50 01             	lea    0x1(%eax),%edx
  80082d:	89 55 10             	mov    %edx,0x10(%ebp)
  800830:	8a 00                	mov    (%eax),%al
  800832:	0f b6 d8             	movzbl %al,%ebx
  800835:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800838:	83 f8 55             	cmp    $0x55,%eax
  80083b:	0f 87 2b 03 00 00    	ja     800b6c <vprintfmt+0x399>
  800841:	8b 04 85 58 22 80 00 	mov    0x802258(,%eax,4),%eax
  800848:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  80084a:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80084e:	eb d7                	jmp    800827 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  800850:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800854:	eb d1                	jmp    800827 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800856:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80085d:	8b 55 e0             	mov    -0x20(%ebp),%edx
  800860:	89 d0                	mov    %edx,%eax
  800862:	c1 e0 02             	shl    $0x2,%eax
  800865:	01 d0                	add    %edx,%eax
  800867:	01 c0                	add    %eax,%eax
  800869:	01 d8                	add    %ebx,%eax
  80086b:	83 e8 30             	sub    $0x30,%eax
  80086e:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  800871:	8b 45 10             	mov    0x10(%ebp),%eax
  800874:	8a 00                	mov    (%eax),%al
  800876:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  800879:	83 fb 2f             	cmp    $0x2f,%ebx
  80087c:	7e 3e                	jle    8008bc <vprintfmt+0xe9>
  80087e:	83 fb 39             	cmp    $0x39,%ebx
  800881:	7f 39                	jg     8008bc <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800883:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  800886:	eb d5                	jmp    80085d <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  800888:	8b 45 14             	mov    0x14(%ebp),%eax
  80088b:	83 c0 04             	add    $0x4,%eax
  80088e:	89 45 14             	mov    %eax,0x14(%ebp)
  800891:	8b 45 14             	mov    0x14(%ebp),%eax
  800894:	83 e8 04             	sub    $0x4,%eax
  800897:	8b 00                	mov    (%eax),%eax
  800899:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  80089c:	eb 1f                	jmp    8008bd <vprintfmt+0xea>

		case '.':
			if (width < 0)
  80089e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008a2:	79 83                	jns    800827 <vprintfmt+0x54>
				width = 0;
  8008a4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8008ab:	e9 77 ff ff ff       	jmp    800827 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8008b0:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8008b7:	e9 6b ff ff ff       	jmp    800827 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8008bc:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8008bd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8008c1:	0f 89 60 ff ff ff    	jns    800827 <vprintfmt+0x54>
				width = precision, precision = -1;
  8008c7:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8008ca:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8008cd:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  8008d4:	e9 4e ff ff ff       	jmp    800827 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  8008d9:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  8008dc:	e9 46 ff ff ff       	jmp    800827 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  8008e1:	8b 45 14             	mov    0x14(%ebp),%eax
  8008e4:	83 c0 04             	add    $0x4,%eax
  8008e7:	89 45 14             	mov    %eax,0x14(%ebp)
  8008ea:	8b 45 14             	mov    0x14(%ebp),%eax
  8008ed:	83 e8 04             	sub    $0x4,%eax
  8008f0:	8b 00                	mov    (%eax),%eax
  8008f2:	83 ec 08             	sub    $0x8,%esp
  8008f5:	ff 75 0c             	pushl  0xc(%ebp)
  8008f8:	50                   	push   %eax
  8008f9:	8b 45 08             	mov    0x8(%ebp),%eax
  8008fc:	ff d0                	call   *%eax
  8008fe:	83 c4 10             	add    $0x10,%esp
			break;
  800901:	e9 89 02 00 00       	jmp    800b8f <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800906:	8b 45 14             	mov    0x14(%ebp),%eax
  800909:	83 c0 04             	add    $0x4,%eax
  80090c:	89 45 14             	mov    %eax,0x14(%ebp)
  80090f:	8b 45 14             	mov    0x14(%ebp),%eax
  800912:	83 e8 04             	sub    $0x4,%eax
  800915:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800917:	85 db                	test   %ebx,%ebx
  800919:	79 02                	jns    80091d <vprintfmt+0x14a>
				err = -err;
  80091b:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80091d:	83 fb 64             	cmp    $0x64,%ebx
  800920:	7f 0b                	jg     80092d <vprintfmt+0x15a>
  800922:	8b 34 9d a0 20 80 00 	mov    0x8020a0(,%ebx,4),%esi
  800929:	85 f6                	test   %esi,%esi
  80092b:	75 19                	jne    800946 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80092d:	53                   	push   %ebx
  80092e:	68 45 22 80 00       	push   $0x802245
  800933:	ff 75 0c             	pushl  0xc(%ebp)
  800936:	ff 75 08             	pushl  0x8(%ebp)
  800939:	e8 5e 02 00 00       	call   800b9c <printfmt>
  80093e:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800941:	e9 49 02 00 00       	jmp    800b8f <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800946:	56                   	push   %esi
  800947:	68 4e 22 80 00       	push   $0x80224e
  80094c:	ff 75 0c             	pushl  0xc(%ebp)
  80094f:	ff 75 08             	pushl  0x8(%ebp)
  800952:	e8 45 02 00 00       	call   800b9c <printfmt>
  800957:	83 c4 10             	add    $0x10,%esp
			break;
  80095a:	e9 30 02 00 00       	jmp    800b8f <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80095f:	8b 45 14             	mov    0x14(%ebp),%eax
  800962:	83 c0 04             	add    $0x4,%eax
  800965:	89 45 14             	mov    %eax,0x14(%ebp)
  800968:	8b 45 14             	mov    0x14(%ebp),%eax
  80096b:	83 e8 04             	sub    $0x4,%eax
  80096e:	8b 30                	mov    (%eax),%esi
  800970:	85 f6                	test   %esi,%esi
  800972:	75 05                	jne    800979 <vprintfmt+0x1a6>
				p = "(null)";
  800974:	be 51 22 80 00       	mov    $0x802251,%esi
			if (width > 0 && padc != '-')
  800979:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  80097d:	7e 6d                	jle    8009ec <vprintfmt+0x219>
  80097f:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  800983:	74 67                	je     8009ec <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  800985:	8b 45 e0             	mov    -0x20(%ebp),%eax
  800988:	83 ec 08             	sub    $0x8,%esp
  80098b:	50                   	push   %eax
  80098c:	56                   	push   %esi
  80098d:	e8 0c 03 00 00       	call   800c9e <strnlen>
  800992:	83 c4 10             	add    $0x10,%esp
  800995:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  800998:	eb 16                	jmp    8009b0 <vprintfmt+0x1dd>
					putch(padc, putdat);
  80099a:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  80099e:	83 ec 08             	sub    $0x8,%esp
  8009a1:	ff 75 0c             	pushl  0xc(%ebp)
  8009a4:	50                   	push   %eax
  8009a5:	8b 45 08             	mov    0x8(%ebp),%eax
  8009a8:	ff d0                	call   *%eax
  8009aa:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8009ad:	ff 4d e4             	decl   -0x1c(%ebp)
  8009b0:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8009b4:	7f e4                	jg     80099a <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009b6:	eb 34                	jmp    8009ec <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8009b8:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8009bc:	74 1c                	je     8009da <vprintfmt+0x207>
  8009be:	83 fb 1f             	cmp    $0x1f,%ebx
  8009c1:	7e 05                	jle    8009c8 <vprintfmt+0x1f5>
  8009c3:	83 fb 7e             	cmp    $0x7e,%ebx
  8009c6:	7e 12                	jle    8009da <vprintfmt+0x207>
					putch('?', putdat);
  8009c8:	83 ec 08             	sub    $0x8,%esp
  8009cb:	ff 75 0c             	pushl  0xc(%ebp)
  8009ce:	6a 3f                	push   $0x3f
  8009d0:	8b 45 08             	mov    0x8(%ebp),%eax
  8009d3:	ff d0                	call   *%eax
  8009d5:	83 c4 10             	add    $0x10,%esp
  8009d8:	eb 0f                	jmp    8009e9 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  8009da:	83 ec 08             	sub    $0x8,%esp
  8009dd:	ff 75 0c             	pushl  0xc(%ebp)
  8009e0:	53                   	push   %ebx
  8009e1:	8b 45 08             	mov    0x8(%ebp),%eax
  8009e4:	ff d0                	call   *%eax
  8009e6:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8009e9:	ff 4d e4             	decl   -0x1c(%ebp)
  8009ec:	89 f0                	mov    %esi,%eax
  8009ee:	8d 70 01             	lea    0x1(%eax),%esi
  8009f1:	8a 00                	mov    (%eax),%al
  8009f3:	0f be d8             	movsbl %al,%ebx
  8009f6:	85 db                	test   %ebx,%ebx
  8009f8:	74 24                	je     800a1e <vprintfmt+0x24b>
  8009fa:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  8009fe:	78 b8                	js     8009b8 <vprintfmt+0x1e5>
  800a00:	ff 4d e0             	decl   -0x20(%ebp)
  800a03:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800a07:	79 af                	jns    8009b8 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a09:	eb 13                	jmp    800a1e <vprintfmt+0x24b>
				putch(' ', putdat);
  800a0b:	83 ec 08             	sub    $0x8,%esp
  800a0e:	ff 75 0c             	pushl  0xc(%ebp)
  800a11:	6a 20                	push   $0x20
  800a13:	8b 45 08             	mov    0x8(%ebp),%eax
  800a16:	ff d0                	call   *%eax
  800a18:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800a1b:	ff 4d e4             	decl   -0x1c(%ebp)
  800a1e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800a22:	7f e7                	jg     800a0b <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800a24:	e9 66 01 00 00       	jmp    800b8f <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800a29:	83 ec 08             	sub    $0x8,%esp
  800a2c:	ff 75 e8             	pushl  -0x18(%ebp)
  800a2f:	8d 45 14             	lea    0x14(%ebp),%eax
  800a32:	50                   	push   %eax
  800a33:	e8 3c fd ff ff       	call   800774 <getint>
  800a38:	83 c4 10             	add    $0x10,%esp
  800a3b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a3e:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800a41:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a44:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a47:	85 d2                	test   %edx,%edx
  800a49:	79 23                	jns    800a6e <vprintfmt+0x29b>
				putch('-', putdat);
  800a4b:	83 ec 08             	sub    $0x8,%esp
  800a4e:	ff 75 0c             	pushl  0xc(%ebp)
  800a51:	6a 2d                	push   $0x2d
  800a53:	8b 45 08             	mov    0x8(%ebp),%eax
  800a56:	ff d0                	call   *%eax
  800a58:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  800a5b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800a5e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800a61:	f7 d8                	neg    %eax
  800a63:	83 d2 00             	adc    $0x0,%edx
  800a66:	f7 da                	neg    %edx
  800a68:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a6b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  800a6e:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a75:	e9 bc 00 00 00       	jmp    800b36 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  800a7a:	83 ec 08             	sub    $0x8,%esp
  800a7d:	ff 75 e8             	pushl  -0x18(%ebp)
  800a80:	8d 45 14             	lea    0x14(%ebp),%eax
  800a83:	50                   	push   %eax
  800a84:	e8 84 fc ff ff       	call   80070d <getuint>
  800a89:	83 c4 10             	add    $0x10,%esp
  800a8c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800a8f:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  800a92:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  800a99:	e9 98 00 00 00       	jmp    800b36 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  800a9e:	83 ec 08             	sub    $0x8,%esp
  800aa1:	ff 75 0c             	pushl  0xc(%ebp)
  800aa4:	6a 58                	push   $0x58
  800aa6:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa9:	ff d0                	call   *%eax
  800aab:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800aae:	83 ec 08             	sub    $0x8,%esp
  800ab1:	ff 75 0c             	pushl  0xc(%ebp)
  800ab4:	6a 58                	push   $0x58
  800ab6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ab9:	ff d0                	call   *%eax
  800abb:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  800abe:	83 ec 08             	sub    $0x8,%esp
  800ac1:	ff 75 0c             	pushl  0xc(%ebp)
  800ac4:	6a 58                	push   $0x58
  800ac6:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac9:	ff d0                	call   *%eax
  800acb:	83 c4 10             	add    $0x10,%esp
			break;
  800ace:	e9 bc 00 00 00       	jmp    800b8f <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800ad3:	83 ec 08             	sub    $0x8,%esp
  800ad6:	ff 75 0c             	pushl  0xc(%ebp)
  800ad9:	6a 30                	push   $0x30
  800adb:	8b 45 08             	mov    0x8(%ebp),%eax
  800ade:	ff d0                	call   *%eax
  800ae0:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800ae3:	83 ec 08             	sub    $0x8,%esp
  800ae6:	ff 75 0c             	pushl  0xc(%ebp)
  800ae9:	6a 78                	push   $0x78
  800aeb:	8b 45 08             	mov    0x8(%ebp),%eax
  800aee:	ff d0                	call   *%eax
  800af0:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800af3:	8b 45 14             	mov    0x14(%ebp),%eax
  800af6:	83 c0 04             	add    $0x4,%eax
  800af9:	89 45 14             	mov    %eax,0x14(%ebp)
  800afc:	8b 45 14             	mov    0x14(%ebp),%eax
  800aff:	83 e8 04             	sub    $0x4,%eax
  800b02:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800b04:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b07:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  800b0e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800b15:	eb 1f                	jmp    800b36 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800b17:	83 ec 08             	sub    $0x8,%esp
  800b1a:	ff 75 e8             	pushl  -0x18(%ebp)
  800b1d:	8d 45 14             	lea    0x14(%ebp),%eax
  800b20:	50                   	push   %eax
  800b21:	e8 e7 fb ff ff       	call   80070d <getuint>
  800b26:	83 c4 10             	add    $0x10,%esp
  800b29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800b2c:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  800b2f:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800b36:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800b3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800b3d:	83 ec 04             	sub    $0x4,%esp
  800b40:	52                   	push   %edx
  800b41:	ff 75 e4             	pushl  -0x1c(%ebp)
  800b44:	50                   	push   %eax
  800b45:	ff 75 f4             	pushl  -0xc(%ebp)
  800b48:	ff 75 f0             	pushl  -0x10(%ebp)
  800b4b:	ff 75 0c             	pushl  0xc(%ebp)
  800b4e:	ff 75 08             	pushl  0x8(%ebp)
  800b51:	e8 00 fb ff ff       	call   800656 <printnum>
  800b56:	83 c4 20             	add    $0x20,%esp
			break;
  800b59:	eb 34                	jmp    800b8f <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  800b5b:	83 ec 08             	sub    $0x8,%esp
  800b5e:	ff 75 0c             	pushl  0xc(%ebp)
  800b61:	53                   	push   %ebx
  800b62:	8b 45 08             	mov    0x8(%ebp),%eax
  800b65:	ff d0                	call   *%eax
  800b67:	83 c4 10             	add    $0x10,%esp
			break;
  800b6a:	eb 23                	jmp    800b8f <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  800b6c:	83 ec 08             	sub    $0x8,%esp
  800b6f:	ff 75 0c             	pushl  0xc(%ebp)
  800b72:	6a 25                	push   $0x25
  800b74:	8b 45 08             	mov    0x8(%ebp),%eax
  800b77:	ff d0                	call   *%eax
  800b79:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  800b7c:	ff 4d 10             	decl   0x10(%ebp)
  800b7f:	eb 03                	jmp    800b84 <vprintfmt+0x3b1>
  800b81:	ff 4d 10             	decl   0x10(%ebp)
  800b84:	8b 45 10             	mov    0x10(%ebp),%eax
  800b87:	48                   	dec    %eax
  800b88:	8a 00                	mov    (%eax),%al
  800b8a:	3c 25                	cmp    $0x25,%al
  800b8c:	75 f3                	jne    800b81 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  800b8e:	90                   	nop
		}
	}
  800b8f:	e9 47 fc ff ff       	jmp    8007db <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  800b94:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  800b95:	8d 65 f8             	lea    -0x8(%ebp),%esp
  800b98:	5b                   	pop    %ebx
  800b99:	5e                   	pop    %esi
  800b9a:	5d                   	pop    %ebp
  800b9b:	c3                   	ret    

00800b9c <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  800b9c:	55                   	push   %ebp
  800b9d:	89 e5                	mov    %esp,%ebp
  800b9f:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  800ba2:	8d 45 10             	lea    0x10(%ebp),%eax
  800ba5:	83 c0 04             	add    $0x4,%eax
  800ba8:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  800bab:	8b 45 10             	mov    0x10(%ebp),%eax
  800bae:	ff 75 f4             	pushl  -0xc(%ebp)
  800bb1:	50                   	push   %eax
  800bb2:	ff 75 0c             	pushl  0xc(%ebp)
  800bb5:	ff 75 08             	pushl  0x8(%ebp)
  800bb8:	e8 16 fc ff ff       	call   8007d3 <vprintfmt>
  800bbd:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  800bc0:	90                   	nop
  800bc1:	c9                   	leave  
  800bc2:	c3                   	ret    

00800bc3 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  800bc3:	55                   	push   %ebp
  800bc4:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  800bc6:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bc9:	8b 40 08             	mov    0x8(%eax),%eax
  800bcc:	8d 50 01             	lea    0x1(%eax),%edx
  800bcf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd2:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800bd5:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd8:	8b 10                	mov    (%eax),%edx
  800bda:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bdd:	8b 40 04             	mov    0x4(%eax),%eax
  800be0:	39 c2                	cmp    %eax,%edx
  800be2:	73 12                	jae    800bf6 <sprintputch+0x33>
		*b->buf++ = ch;
  800be4:	8b 45 0c             	mov    0xc(%ebp),%eax
  800be7:	8b 00                	mov    (%eax),%eax
  800be9:	8d 48 01             	lea    0x1(%eax),%ecx
  800bec:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bef:	89 0a                	mov    %ecx,(%edx)
  800bf1:	8b 55 08             	mov    0x8(%ebp),%edx
  800bf4:	88 10                	mov    %dl,(%eax)
}
  800bf6:	90                   	nop
  800bf7:	5d                   	pop    %ebp
  800bf8:	c3                   	ret    

00800bf9 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800bf9:	55                   	push   %ebp
  800bfa:	89 e5                	mov    %esp,%ebp
  800bfc:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
  800c02:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800c05:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c08:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800c0e:	01 d0                	add    %edx,%eax
  800c10:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800c13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800c1a:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800c1e:	74 06                	je     800c26 <vsnprintf+0x2d>
  800c20:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800c24:	7f 07                	jg     800c2d <vsnprintf+0x34>
		return -E_INVAL;
  800c26:	b8 03 00 00 00       	mov    $0x3,%eax
  800c2b:	eb 20                	jmp    800c4d <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  800c2d:	ff 75 14             	pushl  0x14(%ebp)
  800c30:	ff 75 10             	pushl  0x10(%ebp)
  800c33:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800c36:	50                   	push   %eax
  800c37:	68 c3 0b 80 00       	push   $0x800bc3
  800c3c:	e8 92 fb ff ff       	call   8007d3 <vprintfmt>
  800c41:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800c44:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800c47:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800c4a:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  800c4d:	c9                   	leave  
  800c4e:	c3                   	ret    

00800c4f <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  800c4f:	55                   	push   %ebp
  800c50:	89 e5                	mov    %esp,%ebp
  800c52:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800c55:	8d 45 10             	lea    0x10(%ebp),%eax
  800c58:	83 c0 04             	add    $0x4,%eax
  800c5b:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  800c5e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c61:	ff 75 f4             	pushl  -0xc(%ebp)
  800c64:	50                   	push   %eax
  800c65:	ff 75 0c             	pushl  0xc(%ebp)
  800c68:	ff 75 08             	pushl  0x8(%ebp)
  800c6b:	e8 89 ff ff ff       	call   800bf9 <vsnprintf>
  800c70:	83 c4 10             	add    $0x10,%esp
  800c73:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  800c76:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800c79:	c9                   	leave  
  800c7a:	c3                   	ret    

00800c7b <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  800c7b:	55                   	push   %ebp
  800c7c:	89 e5                	mov    %esp,%ebp
  800c7e:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  800c81:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800c88:	eb 06                	jmp    800c90 <strlen+0x15>
		n++;
  800c8a:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  800c8d:	ff 45 08             	incl   0x8(%ebp)
  800c90:	8b 45 08             	mov    0x8(%ebp),%eax
  800c93:	8a 00                	mov    (%eax),%al
  800c95:	84 c0                	test   %al,%al
  800c97:	75 f1                	jne    800c8a <strlen+0xf>
		n++;
	return n;
  800c99:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800c9c:	c9                   	leave  
  800c9d:	c3                   	ret    

00800c9e <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  800c9e:	55                   	push   %ebp
  800c9f:	89 e5                	mov    %esp,%ebp
  800ca1:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800ca4:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800cab:	eb 09                	jmp    800cb6 <strnlen+0x18>
		n++;
  800cad:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  800cb0:	ff 45 08             	incl   0x8(%ebp)
  800cb3:	ff 4d 0c             	decl   0xc(%ebp)
  800cb6:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800cba:	74 09                	je     800cc5 <strnlen+0x27>
  800cbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800cbf:	8a 00                	mov    (%eax),%al
  800cc1:	84 c0                	test   %al,%al
  800cc3:	75 e8                	jne    800cad <strnlen+0xf>
		n++;
	return n;
  800cc5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cc8:	c9                   	leave  
  800cc9:	c3                   	ret    

00800cca <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  800cca:	55                   	push   %ebp
  800ccb:	89 e5                	mov    %esp,%ebp
  800ccd:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  800cd0:	8b 45 08             	mov    0x8(%ebp),%eax
  800cd3:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800cd6:	90                   	nop
  800cd7:	8b 45 08             	mov    0x8(%ebp),%eax
  800cda:	8d 50 01             	lea    0x1(%eax),%edx
  800cdd:	89 55 08             	mov    %edx,0x8(%ebp)
  800ce0:	8b 55 0c             	mov    0xc(%ebp),%edx
  800ce3:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ce6:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800ce9:	8a 12                	mov    (%edx),%dl
  800ceb:	88 10                	mov    %dl,(%eax)
  800ced:	8a 00                	mov    (%eax),%al
  800cef:	84 c0                	test   %al,%al
  800cf1:	75 e4                	jne    800cd7 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800cf3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800cf6:	c9                   	leave  
  800cf7:	c3                   	ret    

00800cf8 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800cf8:	55                   	push   %ebp
  800cf9:	89 e5                	mov    %esp,%ebp
  800cfb:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800cfe:	8b 45 08             	mov    0x8(%ebp),%eax
  800d01:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800d04:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800d0b:	eb 1f                	jmp    800d2c <strncpy+0x34>
		*dst++ = *src;
  800d0d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d10:	8d 50 01             	lea    0x1(%eax),%edx
  800d13:	89 55 08             	mov    %edx,0x8(%ebp)
  800d16:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d19:	8a 12                	mov    (%edx),%dl
  800d1b:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800d1d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d20:	8a 00                	mov    (%eax),%al
  800d22:	84 c0                	test   %al,%al
  800d24:	74 03                	je     800d29 <strncpy+0x31>
			src++;
  800d26:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800d29:	ff 45 fc             	incl   -0x4(%ebp)
  800d2c:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d2f:	3b 45 10             	cmp    0x10(%ebp),%eax
  800d32:	72 d9                	jb     800d0d <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800d34:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800d37:	c9                   	leave  
  800d38:	c3                   	ret    

00800d39 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800d39:	55                   	push   %ebp
  800d3a:	89 e5                	mov    %esp,%ebp
  800d3c:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800d3f:	8b 45 08             	mov    0x8(%ebp),%eax
  800d42:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800d45:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d49:	74 30                	je     800d7b <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800d4b:	eb 16                	jmp    800d63 <strlcpy+0x2a>
			*dst++ = *src++;
  800d4d:	8b 45 08             	mov    0x8(%ebp),%eax
  800d50:	8d 50 01             	lea    0x1(%eax),%edx
  800d53:	89 55 08             	mov    %edx,0x8(%ebp)
  800d56:	8b 55 0c             	mov    0xc(%ebp),%edx
  800d59:	8d 4a 01             	lea    0x1(%edx),%ecx
  800d5c:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800d5f:	8a 12                	mov    (%edx),%dl
  800d61:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800d63:	ff 4d 10             	decl   0x10(%ebp)
  800d66:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d6a:	74 09                	je     800d75 <strlcpy+0x3c>
  800d6c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	84 c0                	test   %al,%al
  800d73:	75 d8                	jne    800d4d <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800d75:	8b 45 08             	mov    0x8(%ebp),%eax
  800d78:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800d7b:	8b 55 08             	mov    0x8(%ebp),%edx
  800d7e:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800d81:	29 c2                	sub    %eax,%edx
  800d83:	89 d0                	mov    %edx,%eax
}
  800d85:	c9                   	leave  
  800d86:	c3                   	ret    

00800d87 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800d87:	55                   	push   %ebp
  800d88:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800d8a:	eb 06                	jmp    800d92 <strcmp+0xb>
		p++, q++;
  800d8c:	ff 45 08             	incl   0x8(%ebp)
  800d8f:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800d92:	8b 45 08             	mov    0x8(%ebp),%eax
  800d95:	8a 00                	mov    (%eax),%al
  800d97:	84 c0                	test   %al,%al
  800d99:	74 0e                	je     800da9 <strcmp+0x22>
  800d9b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d9e:	8a 10                	mov    (%eax),%dl
  800da0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800da3:	8a 00                	mov    (%eax),%al
  800da5:	38 c2                	cmp    %al,%dl
  800da7:	74 e3                	je     800d8c <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800da9:	8b 45 08             	mov    0x8(%ebp),%eax
  800dac:	8a 00                	mov    (%eax),%al
  800dae:	0f b6 d0             	movzbl %al,%edx
  800db1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800db4:	8a 00                	mov    (%eax),%al
  800db6:	0f b6 c0             	movzbl %al,%eax
  800db9:	29 c2                	sub    %eax,%edx
  800dbb:	89 d0                	mov    %edx,%eax
}
  800dbd:	5d                   	pop    %ebp
  800dbe:	c3                   	ret    

00800dbf <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800dbf:	55                   	push   %ebp
  800dc0:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800dc2:	eb 09                	jmp    800dcd <strncmp+0xe>
		n--, p++, q++;
  800dc4:	ff 4d 10             	decl   0x10(%ebp)
  800dc7:	ff 45 08             	incl   0x8(%ebp)
  800dca:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800dcd:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dd1:	74 17                	je     800dea <strncmp+0x2b>
  800dd3:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd6:	8a 00                	mov    (%eax),%al
  800dd8:	84 c0                	test   %al,%al
  800dda:	74 0e                	je     800dea <strncmp+0x2b>
  800ddc:	8b 45 08             	mov    0x8(%ebp),%eax
  800ddf:	8a 10                	mov    (%eax),%dl
  800de1:	8b 45 0c             	mov    0xc(%ebp),%eax
  800de4:	8a 00                	mov    (%eax),%al
  800de6:	38 c2                	cmp    %al,%dl
  800de8:	74 da                	je     800dc4 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800dea:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800dee:	75 07                	jne    800df7 <strncmp+0x38>
		return 0;
  800df0:	b8 00 00 00 00       	mov    $0x0,%eax
  800df5:	eb 14                	jmp    800e0b <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	8a 00                	mov    (%eax),%al
  800dfc:	0f b6 d0             	movzbl %al,%edx
  800dff:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e02:	8a 00                	mov    (%eax),%al
  800e04:	0f b6 c0             	movzbl %al,%eax
  800e07:	29 c2                	sub    %eax,%edx
  800e09:	89 d0                	mov    %edx,%eax
}
  800e0b:	5d                   	pop    %ebp
  800e0c:	c3                   	ret    

00800e0d <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800e0d:	55                   	push   %ebp
  800e0e:	89 e5                	mov    %esp,%ebp
  800e10:	83 ec 04             	sub    $0x4,%esp
  800e13:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e16:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e19:	eb 12                	jmp    800e2d <strchr+0x20>
		if (*s == c)
  800e1b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e1e:	8a 00                	mov    (%eax),%al
  800e20:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e23:	75 05                	jne    800e2a <strchr+0x1d>
			return (char *) s;
  800e25:	8b 45 08             	mov    0x8(%ebp),%eax
  800e28:	eb 11                	jmp    800e3b <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800e2a:	ff 45 08             	incl   0x8(%ebp)
  800e2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e30:	8a 00                	mov    (%eax),%al
  800e32:	84 c0                	test   %al,%al
  800e34:	75 e5                	jne    800e1b <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800e36:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800e3b:	c9                   	leave  
  800e3c:	c3                   	ret    

00800e3d <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800e3d:	55                   	push   %ebp
  800e3e:	89 e5                	mov    %esp,%ebp
  800e40:	83 ec 04             	sub    $0x4,%esp
  800e43:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e46:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800e49:	eb 0d                	jmp    800e58 <strfind+0x1b>
		if (*s == c)
  800e4b:	8b 45 08             	mov    0x8(%ebp),%eax
  800e4e:	8a 00                	mov    (%eax),%al
  800e50:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800e53:	74 0e                	je     800e63 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800e55:	ff 45 08             	incl   0x8(%ebp)
  800e58:	8b 45 08             	mov    0x8(%ebp),%eax
  800e5b:	8a 00                	mov    (%eax),%al
  800e5d:	84 c0                	test   %al,%al
  800e5f:	75 ea                	jne    800e4b <strfind+0xe>
  800e61:	eb 01                	jmp    800e64 <strfind+0x27>
		if (*s == c)
			break;
  800e63:	90                   	nop
	return (char *) s;
  800e64:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e67:	c9                   	leave  
  800e68:	c3                   	ret    

00800e69 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800e69:	55                   	push   %ebp
  800e6a:	89 e5                	mov    %esp,%ebp
  800e6c:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800e6f:	8b 45 08             	mov    0x8(%ebp),%eax
  800e72:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800e75:	8b 45 10             	mov    0x10(%ebp),%eax
  800e78:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800e7b:	eb 0e                	jmp    800e8b <memset+0x22>
		*p++ = c;
  800e7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800e80:	8d 50 01             	lea    0x1(%eax),%edx
  800e83:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800e86:	8b 55 0c             	mov    0xc(%ebp),%edx
  800e89:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800e8b:	ff 4d f8             	decl   -0x8(%ebp)
  800e8e:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800e92:	79 e9                	jns    800e7d <memset+0x14>
		*p++ = c;

	return v;
  800e94:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800e97:	c9                   	leave  
  800e98:	c3                   	ret    

00800e99 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800e99:	55                   	push   %ebp
  800e9a:	89 e5                	mov    %esp,%ebp
  800e9c:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800e9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ea2:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ea5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ea8:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800eab:	eb 16                	jmp    800ec3 <memcpy+0x2a>
		*d++ = *s++;
  800ead:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eb0:	8d 50 01             	lea    0x1(%eax),%edx
  800eb3:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800eb6:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800eb9:	8d 4a 01             	lea    0x1(%edx),%ecx
  800ebc:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800ebf:	8a 12                	mov    (%edx),%dl
  800ec1:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800ec3:	8b 45 10             	mov    0x10(%ebp),%eax
  800ec6:	8d 50 ff             	lea    -0x1(%eax),%edx
  800ec9:	89 55 10             	mov    %edx,0x10(%ebp)
  800ecc:	85 c0                	test   %eax,%eax
  800ece:	75 dd                	jne    800ead <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800ed0:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800ed3:	c9                   	leave  
  800ed4:	c3                   	ret    

00800ed5 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800ed5:	55                   	push   %ebp
  800ed6:	89 e5                	mov    %esp,%ebp
  800ed8:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800edb:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ede:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800ee1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ee4:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800ee7:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800eea:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800eed:	73 50                	jae    800f3f <memmove+0x6a>
  800eef:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800ef2:	8b 45 10             	mov    0x10(%ebp),%eax
  800ef5:	01 d0                	add    %edx,%eax
  800ef7:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800efa:	76 43                	jbe    800f3f <memmove+0x6a>
		s += n;
  800efc:	8b 45 10             	mov    0x10(%ebp),%eax
  800eff:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800f02:	8b 45 10             	mov    0x10(%ebp),%eax
  800f05:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800f08:	eb 10                	jmp    800f1a <memmove+0x45>
			*--d = *--s;
  800f0a:	ff 4d f8             	decl   -0x8(%ebp)
  800f0d:	ff 4d fc             	decl   -0x4(%ebp)
  800f10:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f13:	8a 10                	mov    (%eax),%dl
  800f15:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f18:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800f1a:	8b 45 10             	mov    0x10(%ebp),%eax
  800f1d:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f20:	89 55 10             	mov    %edx,0x10(%ebp)
  800f23:	85 c0                	test   %eax,%eax
  800f25:	75 e3                	jne    800f0a <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800f27:	eb 23                	jmp    800f4c <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800f29:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f2c:	8d 50 01             	lea    0x1(%eax),%edx
  800f2f:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800f32:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f35:	8d 4a 01             	lea    0x1(%edx),%ecx
  800f38:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800f3b:	8a 12                	mov    (%edx),%dl
  800f3d:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800f3f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f42:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f45:	89 55 10             	mov    %edx,0x10(%ebp)
  800f48:	85 c0                	test   %eax,%eax
  800f4a:	75 dd                	jne    800f29 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800f4c:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800f4f:	c9                   	leave  
  800f50:	c3                   	ret    

00800f51 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800f51:	55                   	push   %ebp
  800f52:	89 e5                	mov    %esp,%ebp
  800f54:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800f57:	8b 45 08             	mov    0x8(%ebp),%eax
  800f5a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800f5d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f60:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800f63:	eb 2a                	jmp    800f8f <memcmp+0x3e>
		if (*s1 != *s2)
  800f65:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f68:	8a 10                	mov    (%eax),%dl
  800f6a:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f6d:	8a 00                	mov    (%eax),%al
  800f6f:	38 c2                	cmp    %al,%dl
  800f71:	74 16                	je     800f89 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800f73:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f76:	8a 00                	mov    (%eax),%al
  800f78:	0f b6 d0             	movzbl %al,%edx
  800f7b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800f7e:	8a 00                	mov    (%eax),%al
  800f80:	0f b6 c0             	movzbl %al,%eax
  800f83:	29 c2                	sub    %eax,%edx
  800f85:	89 d0                	mov    %edx,%eax
  800f87:	eb 18                	jmp    800fa1 <memcmp+0x50>
		s1++, s2++;
  800f89:	ff 45 fc             	incl   -0x4(%ebp)
  800f8c:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800f8f:	8b 45 10             	mov    0x10(%ebp),%eax
  800f92:	8d 50 ff             	lea    -0x1(%eax),%edx
  800f95:	89 55 10             	mov    %edx,0x10(%ebp)
  800f98:	85 c0                	test   %eax,%eax
  800f9a:	75 c9                	jne    800f65 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800f9c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800fa1:	c9                   	leave  
  800fa2:	c3                   	ret    

00800fa3 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800fa3:	55                   	push   %ebp
  800fa4:	89 e5                	mov    %esp,%ebp
  800fa6:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800fa9:	8b 55 08             	mov    0x8(%ebp),%edx
  800fac:	8b 45 10             	mov    0x10(%ebp),%eax
  800faf:	01 d0                	add    %edx,%eax
  800fb1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800fb4:	eb 15                	jmp    800fcb <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800fb6:	8b 45 08             	mov    0x8(%ebp),%eax
  800fb9:	8a 00                	mov    (%eax),%al
  800fbb:	0f b6 d0             	movzbl %al,%edx
  800fbe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fc1:	0f b6 c0             	movzbl %al,%eax
  800fc4:	39 c2                	cmp    %eax,%edx
  800fc6:	74 0d                	je     800fd5 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800fc8:	ff 45 08             	incl   0x8(%ebp)
  800fcb:	8b 45 08             	mov    0x8(%ebp),%eax
  800fce:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800fd1:	72 e3                	jb     800fb6 <memfind+0x13>
  800fd3:	eb 01                	jmp    800fd6 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800fd5:	90                   	nop
	return (void *) s;
  800fd6:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800fd9:	c9                   	leave  
  800fda:	c3                   	ret    

00800fdb <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800fdb:	55                   	push   %ebp
  800fdc:	89 e5                	mov    %esp,%ebp
  800fde:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800fe1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800fe8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800fef:	eb 03                	jmp    800ff4 <strtol+0x19>
		s++;
  800ff1:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800ff4:	8b 45 08             	mov    0x8(%ebp),%eax
  800ff7:	8a 00                	mov    (%eax),%al
  800ff9:	3c 20                	cmp    $0x20,%al
  800ffb:	74 f4                	je     800ff1 <strtol+0x16>
  800ffd:	8b 45 08             	mov    0x8(%ebp),%eax
  801000:	8a 00                	mov    (%eax),%al
  801002:	3c 09                	cmp    $0x9,%al
  801004:	74 eb                	je     800ff1 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  801006:	8b 45 08             	mov    0x8(%ebp),%eax
  801009:	8a 00                	mov    (%eax),%al
  80100b:	3c 2b                	cmp    $0x2b,%al
  80100d:	75 05                	jne    801014 <strtol+0x39>
		s++;
  80100f:	ff 45 08             	incl   0x8(%ebp)
  801012:	eb 13                	jmp    801027 <strtol+0x4c>
	else if (*s == '-')
  801014:	8b 45 08             	mov    0x8(%ebp),%eax
  801017:	8a 00                	mov    (%eax),%al
  801019:	3c 2d                	cmp    $0x2d,%al
  80101b:	75 0a                	jne    801027 <strtol+0x4c>
		s++, neg = 1;
  80101d:	ff 45 08             	incl   0x8(%ebp)
  801020:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  801027:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  80102b:	74 06                	je     801033 <strtol+0x58>
  80102d:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  801031:	75 20                	jne    801053 <strtol+0x78>
  801033:	8b 45 08             	mov    0x8(%ebp),%eax
  801036:	8a 00                	mov    (%eax),%al
  801038:	3c 30                	cmp    $0x30,%al
  80103a:	75 17                	jne    801053 <strtol+0x78>
  80103c:	8b 45 08             	mov    0x8(%ebp),%eax
  80103f:	40                   	inc    %eax
  801040:	8a 00                	mov    (%eax),%al
  801042:	3c 78                	cmp    $0x78,%al
  801044:	75 0d                	jne    801053 <strtol+0x78>
		s += 2, base = 16;
  801046:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  80104a:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  801051:	eb 28                	jmp    80107b <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  801053:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801057:	75 15                	jne    80106e <strtol+0x93>
  801059:	8b 45 08             	mov    0x8(%ebp),%eax
  80105c:	8a 00                	mov    (%eax),%al
  80105e:	3c 30                	cmp    $0x30,%al
  801060:	75 0c                	jne    80106e <strtol+0x93>
		s++, base = 8;
  801062:	ff 45 08             	incl   0x8(%ebp)
  801065:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  80106c:	eb 0d                	jmp    80107b <strtol+0xa0>
	else if (base == 0)
  80106e:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  801072:	75 07                	jne    80107b <strtol+0xa0>
		base = 10;
  801074:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  80107b:	8b 45 08             	mov    0x8(%ebp),%eax
  80107e:	8a 00                	mov    (%eax),%al
  801080:	3c 2f                	cmp    $0x2f,%al
  801082:	7e 19                	jle    80109d <strtol+0xc2>
  801084:	8b 45 08             	mov    0x8(%ebp),%eax
  801087:	8a 00                	mov    (%eax),%al
  801089:	3c 39                	cmp    $0x39,%al
  80108b:	7f 10                	jg     80109d <strtol+0xc2>
			dig = *s - '0';
  80108d:	8b 45 08             	mov    0x8(%ebp),%eax
  801090:	8a 00                	mov    (%eax),%al
  801092:	0f be c0             	movsbl %al,%eax
  801095:	83 e8 30             	sub    $0x30,%eax
  801098:	89 45 f4             	mov    %eax,-0xc(%ebp)
  80109b:	eb 42                	jmp    8010df <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  80109d:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a0:	8a 00                	mov    (%eax),%al
  8010a2:	3c 60                	cmp    $0x60,%al
  8010a4:	7e 19                	jle    8010bf <strtol+0xe4>
  8010a6:	8b 45 08             	mov    0x8(%ebp),%eax
  8010a9:	8a 00                	mov    (%eax),%al
  8010ab:	3c 7a                	cmp    $0x7a,%al
  8010ad:	7f 10                	jg     8010bf <strtol+0xe4>
			dig = *s - 'a' + 10;
  8010af:	8b 45 08             	mov    0x8(%ebp),%eax
  8010b2:	8a 00                	mov    (%eax),%al
  8010b4:	0f be c0             	movsbl %al,%eax
  8010b7:	83 e8 57             	sub    $0x57,%eax
  8010ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8010bd:	eb 20                	jmp    8010df <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  8010bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8010c2:	8a 00                	mov    (%eax),%al
  8010c4:	3c 40                	cmp    $0x40,%al
  8010c6:	7e 39                	jle    801101 <strtol+0x126>
  8010c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8010cb:	8a 00                	mov    (%eax),%al
  8010cd:	3c 5a                	cmp    $0x5a,%al
  8010cf:	7f 30                	jg     801101 <strtol+0x126>
			dig = *s - 'A' + 10;
  8010d1:	8b 45 08             	mov    0x8(%ebp),%eax
  8010d4:	8a 00                	mov    (%eax),%al
  8010d6:	0f be c0             	movsbl %al,%eax
  8010d9:	83 e8 37             	sub    $0x37,%eax
  8010dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  8010df:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010e2:	3b 45 10             	cmp    0x10(%ebp),%eax
  8010e5:	7d 19                	jge    801100 <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  8010e7:	ff 45 08             	incl   0x8(%ebp)
  8010ea:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8010ed:	0f af 45 10          	imul   0x10(%ebp),%eax
  8010f1:	89 c2                	mov    %eax,%edx
  8010f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8010f6:	01 d0                	add    %edx,%eax
  8010f8:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  8010fb:	e9 7b ff ff ff       	jmp    80107b <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  801100:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  801101:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  801105:	74 08                	je     80110f <strtol+0x134>
		*endptr = (char *) s;
  801107:	8b 45 0c             	mov    0xc(%ebp),%eax
  80110a:	8b 55 08             	mov    0x8(%ebp),%edx
  80110d:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  80110f:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  801113:	74 07                	je     80111c <strtol+0x141>
  801115:	8b 45 f8             	mov    -0x8(%ebp),%eax
  801118:	f7 d8                	neg    %eax
  80111a:	eb 03                	jmp    80111f <strtol+0x144>
  80111c:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  80111f:	c9                   	leave  
  801120:	c3                   	ret    

00801121 <ltostr>:

void
ltostr(long value, char *str)
{
  801121:	55                   	push   %ebp
  801122:	89 e5                	mov    %esp,%ebp
  801124:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  801127:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  80112e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  801135:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  801139:	79 13                	jns    80114e <ltostr+0x2d>
	{
		neg = 1;
  80113b:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  801142:	8b 45 0c             	mov    0xc(%ebp),%eax
  801145:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  801148:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  80114b:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  80114e:	8b 45 08             	mov    0x8(%ebp),%eax
  801151:	b9 0a 00 00 00       	mov    $0xa,%ecx
  801156:	99                   	cltd   
  801157:	f7 f9                	idiv   %ecx
  801159:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  80115c:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80115f:	8d 50 01             	lea    0x1(%eax),%edx
  801162:	89 55 f8             	mov    %edx,-0x8(%ebp)
  801165:	89 c2                	mov    %eax,%edx
  801167:	8b 45 0c             	mov    0xc(%ebp),%eax
  80116a:	01 d0                	add    %edx,%eax
  80116c:	8b 55 ec             	mov    -0x14(%ebp),%edx
  80116f:	83 c2 30             	add    $0x30,%edx
  801172:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  801174:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801177:	b8 67 66 66 66       	mov    $0x66666667,%eax
  80117c:	f7 e9                	imul   %ecx
  80117e:	c1 fa 02             	sar    $0x2,%edx
  801181:	89 c8                	mov    %ecx,%eax
  801183:	c1 f8 1f             	sar    $0x1f,%eax
  801186:	29 c2                	sub    %eax,%edx
  801188:	89 d0                	mov    %edx,%eax
  80118a:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  80118d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  801190:	b8 67 66 66 66       	mov    $0x66666667,%eax
  801195:	f7 e9                	imul   %ecx
  801197:	c1 fa 02             	sar    $0x2,%edx
  80119a:	89 c8                	mov    %ecx,%eax
  80119c:	c1 f8 1f             	sar    $0x1f,%eax
  80119f:	29 c2                	sub    %eax,%edx
  8011a1:	89 d0                	mov    %edx,%eax
  8011a3:	c1 e0 02             	shl    $0x2,%eax
  8011a6:	01 d0                	add    %edx,%eax
  8011a8:	01 c0                	add    %eax,%eax
  8011aa:	29 c1                	sub    %eax,%ecx
  8011ac:	89 ca                	mov    %ecx,%edx
  8011ae:	85 d2                	test   %edx,%edx
  8011b0:	75 9c                	jne    80114e <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  8011b2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  8011b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8011bc:	48                   	dec    %eax
  8011bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  8011c0:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  8011c4:	74 3d                	je     801203 <ltostr+0xe2>
		start = 1 ;
  8011c6:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  8011cd:	eb 34                	jmp    801203 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  8011cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011d2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011d5:	01 d0                	add    %edx,%eax
  8011d7:	8a 00                	mov    (%eax),%al
  8011d9:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  8011dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8011df:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011e2:	01 c2                	add    %eax,%edx
  8011e4:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  8011e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011ea:	01 c8                	add    %ecx,%eax
  8011ec:	8a 00                	mov    (%eax),%al
  8011ee:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  8011f0:	8b 55 f0             	mov    -0x10(%ebp),%edx
  8011f3:	8b 45 0c             	mov    0xc(%ebp),%eax
  8011f6:	01 c2                	add    %eax,%edx
  8011f8:	8a 45 eb             	mov    -0x15(%ebp),%al
  8011fb:	88 02                	mov    %al,(%edx)
		start++ ;
  8011fd:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  801200:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  801203:	8b 45 f4             	mov    -0xc(%ebp),%eax
  801206:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  801209:	7c c4                	jl     8011cf <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  80120b:	8b 55 f8             	mov    -0x8(%ebp),%edx
  80120e:	8b 45 0c             	mov    0xc(%ebp),%eax
  801211:	01 d0                	add    %edx,%eax
  801213:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  801216:	90                   	nop
  801217:	c9                   	leave  
  801218:	c3                   	ret    

00801219 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  801219:	55                   	push   %ebp
  80121a:	89 e5                	mov    %esp,%ebp
  80121c:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  80121f:	ff 75 08             	pushl  0x8(%ebp)
  801222:	e8 54 fa ff ff       	call   800c7b <strlen>
  801227:	83 c4 04             	add    $0x4,%esp
  80122a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  80122d:	ff 75 0c             	pushl  0xc(%ebp)
  801230:	e8 46 fa ff ff       	call   800c7b <strlen>
  801235:	83 c4 04             	add    $0x4,%esp
  801238:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  80123b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  801242:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  801249:	eb 17                	jmp    801262 <strcconcat+0x49>
		final[s] = str1[s] ;
  80124b:	8b 55 fc             	mov    -0x4(%ebp),%edx
  80124e:	8b 45 10             	mov    0x10(%ebp),%eax
  801251:	01 c2                	add    %eax,%edx
  801253:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  801256:	8b 45 08             	mov    0x8(%ebp),%eax
  801259:	01 c8                	add    %ecx,%eax
  80125b:	8a 00                	mov    (%eax),%al
  80125d:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  80125f:	ff 45 fc             	incl   -0x4(%ebp)
  801262:	8b 45 fc             	mov    -0x4(%ebp),%eax
  801265:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  801268:	7c e1                	jl     80124b <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  80126a:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  801271:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  801278:	eb 1f                	jmp    801299 <strcconcat+0x80>
		final[s++] = str2[i] ;
  80127a:	8b 45 fc             	mov    -0x4(%ebp),%eax
  80127d:	8d 50 01             	lea    0x1(%eax),%edx
  801280:	89 55 fc             	mov    %edx,-0x4(%ebp)
  801283:	89 c2                	mov    %eax,%edx
  801285:	8b 45 10             	mov    0x10(%ebp),%eax
  801288:	01 c2                	add    %eax,%edx
  80128a:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  80128d:	8b 45 0c             	mov    0xc(%ebp),%eax
  801290:	01 c8                	add    %ecx,%eax
  801292:	8a 00                	mov    (%eax),%al
  801294:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  801296:	ff 45 f8             	incl   -0x8(%ebp)
  801299:	8b 45 f8             	mov    -0x8(%ebp),%eax
  80129c:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  80129f:	7c d9                	jl     80127a <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  8012a1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8012a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8012a7:	01 d0                	add    %edx,%eax
  8012a9:	c6 00 00             	movb   $0x0,(%eax)
}
  8012ac:	90                   	nop
  8012ad:	c9                   	leave  
  8012ae:	c3                   	ret    

008012af <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  8012af:	55                   	push   %ebp
  8012b0:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  8012b2:	8b 45 14             	mov    0x14(%ebp),%eax
  8012b5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  8012bb:	8b 45 14             	mov    0x14(%ebp),%eax
  8012be:	8b 00                	mov    (%eax),%eax
  8012c0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8012c7:	8b 45 10             	mov    0x10(%ebp),%eax
  8012ca:	01 d0                	add    %edx,%eax
  8012cc:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012d2:	eb 0c                	jmp    8012e0 <strsplit+0x31>
			*string++ = 0;
  8012d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8012d7:	8d 50 01             	lea    0x1(%eax),%edx
  8012da:	89 55 08             	mov    %edx,0x8(%ebp)
  8012dd:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  8012e0:	8b 45 08             	mov    0x8(%ebp),%eax
  8012e3:	8a 00                	mov    (%eax),%al
  8012e5:	84 c0                	test   %al,%al
  8012e7:	74 18                	je     801301 <strsplit+0x52>
  8012e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8012ec:	8a 00                	mov    (%eax),%al
  8012ee:	0f be c0             	movsbl %al,%eax
  8012f1:	50                   	push   %eax
  8012f2:	ff 75 0c             	pushl  0xc(%ebp)
  8012f5:	e8 13 fb ff ff       	call   800e0d <strchr>
  8012fa:	83 c4 08             	add    $0x8,%esp
  8012fd:	85 c0                	test   %eax,%eax
  8012ff:	75 d3                	jne    8012d4 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801301:	8b 45 08             	mov    0x8(%ebp),%eax
  801304:	8a 00                	mov    (%eax),%al
  801306:	84 c0                	test   %al,%al
  801308:	74 5a                	je     801364 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  80130a:	8b 45 14             	mov    0x14(%ebp),%eax
  80130d:	8b 00                	mov    (%eax),%eax
  80130f:	83 f8 0f             	cmp    $0xf,%eax
  801312:	75 07                	jne    80131b <strsplit+0x6c>
		{
			return 0;
  801314:	b8 00 00 00 00       	mov    $0x0,%eax
  801319:	eb 66                	jmp    801381 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80131b:	8b 45 14             	mov    0x14(%ebp),%eax
  80131e:	8b 00                	mov    (%eax),%eax
  801320:	8d 48 01             	lea    0x1(%eax),%ecx
  801323:	8b 55 14             	mov    0x14(%ebp),%edx
  801326:	89 0a                	mov    %ecx,(%edx)
  801328:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80132f:	8b 45 10             	mov    0x10(%ebp),%eax
  801332:	01 c2                	add    %eax,%edx
  801334:	8b 45 08             	mov    0x8(%ebp),%eax
  801337:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801339:	eb 03                	jmp    80133e <strsplit+0x8f>
			string++;
  80133b:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80133e:	8b 45 08             	mov    0x8(%ebp),%eax
  801341:	8a 00                	mov    (%eax),%al
  801343:	84 c0                	test   %al,%al
  801345:	74 8b                	je     8012d2 <strsplit+0x23>
  801347:	8b 45 08             	mov    0x8(%ebp),%eax
  80134a:	8a 00                	mov    (%eax),%al
  80134c:	0f be c0             	movsbl %al,%eax
  80134f:	50                   	push   %eax
  801350:	ff 75 0c             	pushl  0xc(%ebp)
  801353:	e8 b5 fa ff ff       	call   800e0d <strchr>
  801358:	83 c4 08             	add    $0x8,%esp
  80135b:	85 c0                	test   %eax,%eax
  80135d:	74 dc                	je     80133b <strsplit+0x8c>
			string++;
	}
  80135f:	e9 6e ff ff ff       	jmp    8012d2 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801364:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801365:	8b 45 14             	mov    0x14(%ebp),%eax
  801368:	8b 00                	mov    (%eax),%eax
  80136a:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  801371:	8b 45 10             	mov    0x10(%ebp),%eax
  801374:	01 d0                	add    %edx,%eax
  801376:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  80137c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  801381:	c9                   	leave  
  801382:	c3                   	ret    

00801383 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  801383:	55                   	push   %ebp
  801384:	89 e5                	mov    %esp,%ebp
  801386:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  801389:	83 ec 04             	sub    $0x4,%esp
  80138c:	68 b0 23 80 00       	push   $0x8023b0
  801391:	6a 15                	push   $0x15
  801393:	68 d5 23 80 00       	push   $0x8023d5
  801398:	e8 a8 ef ff ff       	call   800345 <_panic>

0080139d <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  80139d:	55                   	push   %ebp
  80139e:	89 e5                	mov    %esp,%ebp
  8013a0:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8013a3:	83 ec 04             	sub    $0x4,%esp
  8013a6:	68 e4 23 80 00       	push   $0x8023e4
  8013ab:	6a 2e                	push   $0x2e
  8013ad:	68 d5 23 80 00       	push   $0x8023d5
  8013b2:	e8 8e ef ff ff       	call   800345 <_panic>

008013b7 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8013b7:	55                   	push   %ebp
  8013b8:	89 e5                	mov    %esp,%ebp
  8013ba:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013bd:	83 ec 04             	sub    $0x4,%esp
  8013c0:	68 08 24 80 00       	push   $0x802408
  8013c5:	6a 4c                	push   $0x4c
  8013c7:	68 d5 23 80 00       	push   $0x8023d5
  8013cc:	e8 74 ef ff ff       	call   800345 <_panic>

008013d1 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  8013d1:	55                   	push   %ebp
  8013d2:	89 e5                	mov    %esp,%ebp
  8013d4:	83 ec 18             	sub    $0x18,%esp
  8013d7:	8b 45 10             	mov    0x10(%ebp),%eax
  8013da:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  8013dd:	83 ec 04             	sub    $0x4,%esp
  8013e0:	68 08 24 80 00       	push   $0x802408
  8013e5:	6a 57                	push   $0x57
  8013e7:	68 d5 23 80 00       	push   $0x8023d5
  8013ec:	e8 54 ef ff ff       	call   800345 <_panic>

008013f1 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  8013f1:	55                   	push   %ebp
  8013f2:	89 e5                	mov    %esp,%ebp
  8013f4:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8013f7:	83 ec 04             	sub    $0x4,%esp
  8013fa:	68 08 24 80 00       	push   $0x802408
  8013ff:	6a 5d                	push   $0x5d
  801401:	68 d5 23 80 00       	push   $0x8023d5
  801406:	e8 3a ef ff ff       	call   800345 <_panic>

0080140b <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80140b:	55                   	push   %ebp
  80140c:	89 e5                	mov    %esp,%ebp
  80140e:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801411:	83 ec 04             	sub    $0x4,%esp
  801414:	68 08 24 80 00       	push   $0x802408
  801419:	6a 63                	push   $0x63
  80141b:	68 d5 23 80 00       	push   $0x8023d5
  801420:	e8 20 ef ff ff       	call   800345 <_panic>

00801425 <expand>:
}

void expand(uint32 newSize)
{
  801425:	55                   	push   %ebp
  801426:	89 e5                	mov    %esp,%ebp
  801428:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80142b:	83 ec 04             	sub    $0x4,%esp
  80142e:	68 08 24 80 00       	push   $0x802408
  801433:	6a 68                	push   $0x68
  801435:	68 d5 23 80 00       	push   $0x8023d5
  80143a:	e8 06 ef ff ff       	call   800345 <_panic>

0080143f <shrink>:
}
void shrink(uint32 newSize)
{
  80143f:	55                   	push   %ebp
  801440:	89 e5                	mov    %esp,%ebp
  801442:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801445:	83 ec 04             	sub    $0x4,%esp
  801448:	68 08 24 80 00       	push   $0x802408
  80144d:	6a 6c                	push   $0x6c
  80144f:	68 d5 23 80 00       	push   $0x8023d5
  801454:	e8 ec ee ff ff       	call   800345 <_panic>

00801459 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801459:	55                   	push   %ebp
  80145a:	89 e5                	mov    %esp,%ebp
  80145c:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80145f:	83 ec 04             	sub    $0x4,%esp
  801462:	68 08 24 80 00       	push   $0x802408
  801467:	6a 71                	push   $0x71
  801469:	68 d5 23 80 00       	push   $0x8023d5
  80146e:	e8 d2 ee ff ff       	call   800345 <_panic>

00801473 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  801473:	55                   	push   %ebp
  801474:	89 e5                	mov    %esp,%ebp
  801476:	57                   	push   %edi
  801477:	56                   	push   %esi
  801478:	53                   	push   %ebx
  801479:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  80147c:	8b 45 08             	mov    0x8(%ebp),%eax
  80147f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801482:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801485:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801488:	8b 7d 18             	mov    0x18(%ebp),%edi
  80148b:	8b 75 1c             	mov    0x1c(%ebp),%esi
  80148e:	cd 30                	int    $0x30
  801490:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  801493:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  801496:	83 c4 10             	add    $0x10,%esp
  801499:	5b                   	pop    %ebx
  80149a:	5e                   	pop    %esi
  80149b:	5f                   	pop    %edi
  80149c:	5d                   	pop    %ebp
  80149d:	c3                   	ret    

0080149e <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  80149e:	55                   	push   %ebp
  80149f:	89 e5                	mov    %esp,%ebp
  8014a1:	83 ec 04             	sub    $0x4,%esp
  8014a4:	8b 45 10             	mov    0x10(%ebp),%eax
  8014a7:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8014aa:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014ae:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b1:	6a 00                	push   $0x0
  8014b3:	6a 00                	push   $0x0
  8014b5:	52                   	push   %edx
  8014b6:	ff 75 0c             	pushl  0xc(%ebp)
  8014b9:	50                   	push   %eax
  8014ba:	6a 00                	push   $0x0
  8014bc:	e8 b2 ff ff ff       	call   801473 <syscall>
  8014c1:	83 c4 18             	add    $0x18,%esp
}
  8014c4:	90                   	nop
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <sys_cgetc>:

int
sys_cgetc(void)
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8014ca:	6a 00                	push   $0x0
  8014cc:	6a 00                	push   $0x0
  8014ce:	6a 00                	push   $0x0
  8014d0:	6a 00                	push   $0x0
  8014d2:	6a 00                	push   $0x0
  8014d4:	6a 01                	push   $0x1
  8014d6:	e8 98 ff ff ff       	call   801473 <syscall>
  8014db:	83 c4 18             	add    $0x18,%esp
}
  8014de:	c9                   	leave  
  8014df:	c3                   	ret    

008014e0 <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  8014e0:	55                   	push   %ebp
  8014e1:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  8014e3:	8b 45 08             	mov    0x8(%ebp),%eax
  8014e6:	6a 00                	push   $0x0
  8014e8:	6a 00                	push   $0x0
  8014ea:	6a 00                	push   $0x0
  8014ec:	6a 00                	push   $0x0
  8014ee:	50                   	push   %eax
  8014ef:	6a 05                	push   $0x5
  8014f1:	e8 7d ff ff ff       	call   801473 <syscall>
  8014f6:	83 c4 18             	add    $0x18,%esp
}
  8014f9:	c9                   	leave  
  8014fa:	c3                   	ret    

008014fb <sys_getenvid>:

int32 sys_getenvid(void)
{
  8014fb:	55                   	push   %ebp
  8014fc:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  8014fe:	6a 00                	push   $0x0
  801500:	6a 00                	push   $0x0
  801502:	6a 00                	push   $0x0
  801504:	6a 00                	push   $0x0
  801506:	6a 00                	push   $0x0
  801508:	6a 02                	push   $0x2
  80150a:	e8 64 ff ff ff       	call   801473 <syscall>
  80150f:	83 c4 18             	add    $0x18,%esp
}
  801512:	c9                   	leave  
  801513:	c3                   	ret    

00801514 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801514:	55                   	push   %ebp
  801515:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801517:	6a 00                	push   $0x0
  801519:	6a 00                	push   $0x0
  80151b:	6a 00                	push   $0x0
  80151d:	6a 00                	push   $0x0
  80151f:	6a 00                	push   $0x0
  801521:	6a 03                	push   $0x3
  801523:	e8 4b ff ff ff       	call   801473 <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  801530:	6a 00                	push   $0x0
  801532:	6a 00                	push   $0x0
  801534:	6a 00                	push   $0x0
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 04                	push   $0x4
  80153c:	e8 32 ff ff ff       	call   801473 <syscall>
  801541:	83 c4 18             	add    $0x18,%esp
}
  801544:	c9                   	leave  
  801545:	c3                   	ret    

00801546 <sys_env_exit>:


void sys_env_exit(void)
{
  801546:	55                   	push   %ebp
  801547:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801549:	6a 00                	push   $0x0
  80154b:	6a 00                	push   $0x0
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 06                	push   $0x6
  801555:	e8 19 ff ff ff       	call   801473 <syscall>
  80155a:	83 c4 18             	add    $0x18,%esp
}
  80155d:	90                   	nop
  80155e:	c9                   	leave  
  80155f:	c3                   	ret    

00801560 <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  801560:	55                   	push   %ebp
  801561:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801563:	8b 55 0c             	mov    0xc(%ebp),%edx
  801566:	8b 45 08             	mov    0x8(%ebp),%eax
  801569:	6a 00                	push   $0x0
  80156b:	6a 00                	push   $0x0
  80156d:	6a 00                	push   $0x0
  80156f:	52                   	push   %edx
  801570:	50                   	push   %eax
  801571:	6a 07                	push   $0x7
  801573:	e8 fb fe ff ff       	call   801473 <syscall>
  801578:	83 c4 18             	add    $0x18,%esp
}
  80157b:	c9                   	leave  
  80157c:	c3                   	ret    

0080157d <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  80157d:	55                   	push   %ebp
  80157e:	89 e5                	mov    %esp,%ebp
  801580:	56                   	push   %esi
  801581:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  801582:	8b 75 18             	mov    0x18(%ebp),%esi
  801585:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801588:	8b 4d 10             	mov    0x10(%ebp),%ecx
  80158b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80158e:	8b 45 08             	mov    0x8(%ebp),%eax
  801591:	56                   	push   %esi
  801592:	53                   	push   %ebx
  801593:	51                   	push   %ecx
  801594:	52                   	push   %edx
  801595:	50                   	push   %eax
  801596:	6a 08                	push   $0x8
  801598:	e8 d6 fe ff ff       	call   801473 <syscall>
  80159d:	83 c4 18             	add    $0x18,%esp
}
  8015a0:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8015a3:	5b                   	pop    %ebx
  8015a4:	5e                   	pop    %esi
  8015a5:	5d                   	pop    %ebp
  8015a6:	c3                   	ret    

008015a7 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8015a7:	55                   	push   %ebp
  8015a8:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8015aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  8015ad:	8b 45 08             	mov    0x8(%ebp),%eax
  8015b0:	6a 00                	push   $0x0
  8015b2:	6a 00                	push   $0x0
  8015b4:	6a 00                	push   $0x0
  8015b6:	52                   	push   %edx
  8015b7:	50                   	push   %eax
  8015b8:	6a 09                	push   $0x9
  8015ba:	e8 b4 fe ff ff       	call   801473 <syscall>
  8015bf:	83 c4 18             	add    $0x18,%esp
}
  8015c2:	c9                   	leave  
  8015c3:	c3                   	ret    

008015c4 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8015c4:	55                   	push   %ebp
  8015c5:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8015c7:	6a 00                	push   $0x0
  8015c9:	6a 00                	push   $0x0
  8015cb:	6a 00                	push   $0x0
  8015cd:	ff 75 0c             	pushl  0xc(%ebp)
  8015d0:	ff 75 08             	pushl  0x8(%ebp)
  8015d3:	6a 0a                	push   $0xa
  8015d5:	e8 99 fe ff ff       	call   801473 <syscall>
  8015da:	83 c4 18             	add    $0x18,%esp
}
  8015dd:	c9                   	leave  
  8015de:	c3                   	ret    

008015df <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  8015df:	55                   	push   %ebp
  8015e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  8015e2:	6a 00                	push   $0x0
  8015e4:	6a 00                	push   $0x0
  8015e6:	6a 00                	push   $0x0
  8015e8:	6a 00                	push   $0x0
  8015ea:	6a 00                	push   $0x0
  8015ec:	6a 0b                	push   $0xb
  8015ee:	e8 80 fe ff ff       	call   801473 <syscall>
  8015f3:	83 c4 18             	add    $0x18,%esp
}
  8015f6:	c9                   	leave  
  8015f7:	c3                   	ret    

008015f8 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  8015f8:	55                   	push   %ebp
  8015f9:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  8015fb:	6a 00                	push   $0x0
  8015fd:	6a 00                	push   $0x0
  8015ff:	6a 00                	push   $0x0
  801601:	6a 00                	push   $0x0
  801603:	6a 00                	push   $0x0
  801605:	6a 0c                	push   $0xc
  801607:	e8 67 fe ff ff       	call   801473 <syscall>
  80160c:	83 c4 18             	add    $0x18,%esp
}
  80160f:	c9                   	leave  
  801610:	c3                   	ret    

00801611 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801611:	55                   	push   %ebp
  801612:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801614:	6a 00                	push   $0x0
  801616:	6a 00                	push   $0x0
  801618:	6a 00                	push   $0x0
  80161a:	6a 00                	push   $0x0
  80161c:	6a 00                	push   $0x0
  80161e:	6a 0d                	push   $0xd
  801620:	e8 4e fe ff ff       	call   801473 <syscall>
  801625:	83 c4 18             	add    $0x18,%esp
}
  801628:	c9                   	leave  
  801629:	c3                   	ret    

0080162a <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  80162a:	55                   	push   %ebp
  80162b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80162d:	6a 00                	push   $0x0
  80162f:	6a 00                	push   $0x0
  801631:	6a 00                	push   $0x0
  801633:	ff 75 0c             	pushl  0xc(%ebp)
  801636:	ff 75 08             	pushl  0x8(%ebp)
  801639:	6a 11                	push   $0x11
  80163b:	e8 33 fe ff ff       	call   801473 <syscall>
  801640:	83 c4 18             	add    $0x18,%esp
	return;
  801643:	90                   	nop
}
  801644:	c9                   	leave  
  801645:	c3                   	ret    

00801646 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801646:	55                   	push   %ebp
  801647:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801649:	6a 00                	push   $0x0
  80164b:	6a 00                	push   $0x0
  80164d:	6a 00                	push   $0x0
  80164f:	ff 75 0c             	pushl  0xc(%ebp)
  801652:	ff 75 08             	pushl  0x8(%ebp)
  801655:	6a 12                	push   $0x12
  801657:	e8 17 fe ff ff       	call   801473 <syscall>
  80165c:	83 c4 18             	add    $0x18,%esp
	return ;
  80165f:	90                   	nop
}
  801660:	c9                   	leave  
  801661:	c3                   	ret    

00801662 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801662:	55                   	push   %ebp
  801663:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801665:	6a 00                	push   $0x0
  801667:	6a 00                	push   $0x0
  801669:	6a 00                	push   $0x0
  80166b:	6a 00                	push   $0x0
  80166d:	6a 00                	push   $0x0
  80166f:	6a 0e                	push   $0xe
  801671:	e8 fd fd ff ff       	call   801473 <syscall>
  801676:	83 c4 18             	add    $0x18,%esp
}
  801679:	c9                   	leave  
  80167a:	c3                   	ret    

0080167b <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  80167b:	55                   	push   %ebp
  80167c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  80167e:	6a 00                	push   $0x0
  801680:	6a 00                	push   $0x0
  801682:	6a 00                	push   $0x0
  801684:	6a 00                	push   $0x0
  801686:	ff 75 08             	pushl  0x8(%ebp)
  801689:	6a 0f                	push   $0xf
  80168b:	e8 e3 fd ff ff       	call   801473 <syscall>
  801690:	83 c4 18             	add    $0x18,%esp
}
  801693:	c9                   	leave  
  801694:	c3                   	ret    

00801695 <sys_scarce_memory>:

void sys_scarce_memory()
{
  801695:	55                   	push   %ebp
  801696:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  801698:	6a 00                	push   $0x0
  80169a:	6a 00                	push   $0x0
  80169c:	6a 00                	push   $0x0
  80169e:	6a 00                	push   $0x0
  8016a0:	6a 00                	push   $0x0
  8016a2:	6a 10                	push   $0x10
  8016a4:	e8 ca fd ff ff       	call   801473 <syscall>
  8016a9:	83 c4 18             	add    $0x18,%esp
}
  8016ac:	90                   	nop
  8016ad:	c9                   	leave  
  8016ae:	c3                   	ret    

008016af <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8016af:	55                   	push   %ebp
  8016b0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 00                	push   $0x0
  8016ba:	6a 00                	push   $0x0
  8016bc:	6a 14                	push   $0x14
  8016be:	e8 b0 fd ff ff       	call   801473 <syscall>
  8016c3:	83 c4 18             	add    $0x18,%esp
}
  8016c6:	90                   	nop
  8016c7:	c9                   	leave  
  8016c8:	c3                   	ret    

008016c9 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8016c9:	55                   	push   %ebp
  8016ca:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 00                	push   $0x0
  8016d4:	6a 00                	push   $0x0
  8016d6:	6a 15                	push   $0x15
  8016d8:	e8 96 fd ff ff       	call   801473 <syscall>
  8016dd:	83 c4 18             	add    $0x18,%esp
}
  8016e0:	90                   	nop
  8016e1:	c9                   	leave  
  8016e2:	c3                   	ret    

008016e3 <sys_cputc>:


void
sys_cputc(const char c)
{
  8016e3:	55                   	push   %ebp
  8016e4:	89 e5                	mov    %esp,%ebp
  8016e6:	83 ec 04             	sub    $0x4,%esp
  8016e9:	8b 45 08             	mov    0x8(%ebp),%eax
  8016ec:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  8016ef:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  8016f3:	6a 00                	push   $0x0
  8016f5:	6a 00                	push   $0x0
  8016f7:	6a 00                	push   $0x0
  8016f9:	6a 00                	push   $0x0
  8016fb:	50                   	push   %eax
  8016fc:	6a 16                	push   $0x16
  8016fe:	e8 70 fd ff ff       	call   801473 <syscall>
  801703:	83 c4 18             	add    $0x18,%esp
}
  801706:	90                   	nop
  801707:	c9                   	leave  
  801708:	c3                   	ret    

00801709 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801709:	55                   	push   %ebp
  80170a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80170c:	6a 00                	push   $0x0
  80170e:	6a 00                	push   $0x0
  801710:	6a 00                	push   $0x0
  801712:	6a 00                	push   $0x0
  801714:	6a 00                	push   $0x0
  801716:	6a 17                	push   $0x17
  801718:	e8 56 fd ff ff       	call   801473 <syscall>
  80171d:	83 c4 18             	add    $0x18,%esp
}
  801720:	90                   	nop
  801721:	c9                   	leave  
  801722:	c3                   	ret    

00801723 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801723:	55                   	push   %ebp
  801724:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801726:	8b 45 08             	mov    0x8(%ebp),%eax
  801729:	6a 00                	push   $0x0
  80172b:	6a 00                	push   $0x0
  80172d:	6a 00                	push   $0x0
  80172f:	ff 75 0c             	pushl  0xc(%ebp)
  801732:	50                   	push   %eax
  801733:	6a 18                	push   $0x18
  801735:	e8 39 fd ff ff       	call   801473 <syscall>
  80173a:	83 c4 18             	add    $0x18,%esp
}
  80173d:	c9                   	leave  
  80173e:	c3                   	ret    

0080173f <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80173f:	55                   	push   %ebp
  801740:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801742:	8b 55 0c             	mov    0xc(%ebp),%edx
  801745:	8b 45 08             	mov    0x8(%ebp),%eax
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	52                   	push   %edx
  80174f:	50                   	push   %eax
  801750:	6a 1b                	push   $0x1b
  801752:	e8 1c fd ff ff       	call   801473 <syscall>
  801757:	83 c4 18             	add    $0x18,%esp
}
  80175a:	c9                   	leave  
  80175b:	c3                   	ret    

0080175c <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80175c:	55                   	push   %ebp
  80175d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80175f:	8b 55 0c             	mov    0xc(%ebp),%edx
  801762:	8b 45 08             	mov    0x8(%ebp),%eax
  801765:	6a 00                	push   $0x0
  801767:	6a 00                	push   $0x0
  801769:	6a 00                	push   $0x0
  80176b:	52                   	push   %edx
  80176c:	50                   	push   %eax
  80176d:	6a 19                	push   $0x19
  80176f:	e8 ff fc ff ff       	call   801473 <syscall>
  801774:	83 c4 18             	add    $0x18,%esp
}
  801777:	90                   	nop
  801778:	c9                   	leave  
  801779:	c3                   	ret    

0080177a <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80177a:	55                   	push   %ebp
  80177b:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80177d:	8b 55 0c             	mov    0xc(%ebp),%edx
  801780:	8b 45 08             	mov    0x8(%ebp),%eax
  801783:	6a 00                	push   $0x0
  801785:	6a 00                	push   $0x0
  801787:	6a 00                	push   $0x0
  801789:	52                   	push   %edx
  80178a:	50                   	push   %eax
  80178b:	6a 1a                	push   $0x1a
  80178d:	e8 e1 fc ff ff       	call   801473 <syscall>
  801792:	83 c4 18             	add    $0x18,%esp
}
  801795:	90                   	nop
  801796:	c9                   	leave  
  801797:	c3                   	ret    

00801798 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  801798:	55                   	push   %ebp
  801799:	89 e5                	mov    %esp,%ebp
  80179b:	83 ec 04             	sub    $0x4,%esp
  80179e:	8b 45 10             	mov    0x10(%ebp),%eax
  8017a1:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8017a4:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8017a7:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8017ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8017ae:	6a 00                	push   $0x0
  8017b0:	51                   	push   %ecx
  8017b1:	52                   	push   %edx
  8017b2:	ff 75 0c             	pushl  0xc(%ebp)
  8017b5:	50                   	push   %eax
  8017b6:	6a 1c                	push   $0x1c
  8017b8:	e8 b6 fc ff ff       	call   801473 <syscall>
  8017bd:	83 c4 18             	add    $0x18,%esp
}
  8017c0:	c9                   	leave  
  8017c1:	c3                   	ret    

008017c2 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8017c2:	55                   	push   %ebp
  8017c3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8017c5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017c8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cb:	6a 00                	push   $0x0
  8017cd:	6a 00                	push   $0x0
  8017cf:	6a 00                	push   $0x0
  8017d1:	52                   	push   %edx
  8017d2:	50                   	push   %eax
  8017d3:	6a 1d                	push   $0x1d
  8017d5:	e8 99 fc ff ff       	call   801473 <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
}
  8017dd:	c9                   	leave  
  8017de:	c3                   	ret    

008017df <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  8017df:	55                   	push   %ebp
  8017e0:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  8017e2:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	51                   	push   %ecx
  8017f0:	52                   	push   %edx
  8017f1:	50                   	push   %eax
  8017f2:	6a 1e                	push   $0x1e
  8017f4:	e8 7a fc ff ff       	call   801473 <syscall>
  8017f9:	83 c4 18             	add    $0x18,%esp
}
  8017fc:	c9                   	leave  
  8017fd:	c3                   	ret    

008017fe <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  8017fe:	55                   	push   %ebp
  8017ff:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801801:	8b 55 0c             	mov    0xc(%ebp),%edx
  801804:	8b 45 08             	mov    0x8(%ebp),%eax
  801807:	6a 00                	push   $0x0
  801809:	6a 00                	push   $0x0
  80180b:	6a 00                	push   $0x0
  80180d:	52                   	push   %edx
  80180e:	50                   	push   %eax
  80180f:	6a 1f                	push   $0x1f
  801811:	e8 5d fc ff ff       	call   801473 <syscall>
  801816:	83 c4 18             	add    $0x18,%esp
}
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80181e:	6a 00                	push   $0x0
  801820:	6a 00                	push   $0x0
  801822:	6a 00                	push   $0x0
  801824:	6a 00                	push   $0x0
  801826:	6a 00                	push   $0x0
  801828:	6a 20                	push   $0x20
  80182a:	e8 44 fc ff ff       	call   801473 <syscall>
  80182f:	83 c4 18             	add    $0x18,%esp
}
  801832:	c9                   	leave  
  801833:	c3                   	ret    

00801834 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801834:	55                   	push   %ebp
  801835:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801837:	8b 45 08             	mov    0x8(%ebp),%eax
  80183a:	6a 00                	push   $0x0
  80183c:	ff 75 14             	pushl  0x14(%ebp)
  80183f:	ff 75 10             	pushl  0x10(%ebp)
  801842:	ff 75 0c             	pushl  0xc(%ebp)
  801845:	50                   	push   %eax
  801846:	6a 21                	push   $0x21
  801848:	e8 26 fc ff ff       	call   801473 <syscall>
  80184d:	83 c4 18             	add    $0x18,%esp
}
  801850:	c9                   	leave  
  801851:	c3                   	ret    

00801852 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801852:	55                   	push   %ebp
  801853:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801855:	8b 45 08             	mov    0x8(%ebp),%eax
  801858:	6a 00                	push   $0x0
  80185a:	6a 00                	push   $0x0
  80185c:	6a 00                	push   $0x0
  80185e:	6a 00                	push   $0x0
  801860:	50                   	push   %eax
  801861:	6a 22                	push   $0x22
  801863:	e8 0b fc ff ff       	call   801473 <syscall>
  801868:	83 c4 18             	add    $0x18,%esp
}
  80186b:	90                   	nop
  80186c:	c9                   	leave  
  80186d:	c3                   	ret    

0080186e <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80186e:	55                   	push   %ebp
  80186f:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  801871:	8b 45 08             	mov    0x8(%ebp),%eax
  801874:	6a 00                	push   $0x0
  801876:	6a 00                	push   $0x0
  801878:	6a 00                	push   $0x0
  80187a:	6a 00                	push   $0x0
  80187c:	50                   	push   %eax
  80187d:	6a 23                	push   $0x23
  80187f:	e8 ef fb ff ff       	call   801473 <syscall>
  801884:	83 c4 18             	add    $0x18,%esp
}
  801887:	90                   	nop
  801888:	c9                   	leave  
  801889:	c3                   	ret    

0080188a <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  80188a:	55                   	push   %ebp
  80188b:	89 e5                	mov    %esp,%ebp
  80188d:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  801890:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801893:	8d 50 04             	lea    0x4(%eax),%edx
  801896:	8d 45 f8             	lea    -0x8(%ebp),%eax
  801899:	6a 00                	push   $0x0
  80189b:	6a 00                	push   $0x0
  80189d:	6a 00                	push   $0x0
  80189f:	52                   	push   %edx
  8018a0:	50                   	push   %eax
  8018a1:	6a 24                	push   $0x24
  8018a3:	e8 cb fb ff ff       	call   801473 <syscall>
  8018a8:	83 c4 18             	add    $0x18,%esp
	return result;
  8018ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8018ae:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8018b1:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8018b4:	89 01                	mov    %eax,(%ecx)
  8018b6:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8018b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8018bc:	c9                   	leave  
  8018bd:	c2 04 00             	ret    $0x4

008018c0 <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8018c0:	55                   	push   %ebp
  8018c1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8018c3:	6a 00                	push   $0x0
  8018c5:	6a 00                	push   $0x0
  8018c7:	ff 75 10             	pushl  0x10(%ebp)
  8018ca:	ff 75 0c             	pushl  0xc(%ebp)
  8018cd:	ff 75 08             	pushl  0x8(%ebp)
  8018d0:	6a 13                	push   $0x13
  8018d2:	e8 9c fb ff ff       	call   801473 <syscall>
  8018d7:	83 c4 18             	add    $0x18,%esp
	return ;
  8018da:	90                   	nop
}
  8018db:	c9                   	leave  
  8018dc:	c3                   	ret    

008018dd <sys_rcr2>:
uint32 sys_rcr2()
{
  8018dd:	55                   	push   %ebp
  8018de:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  8018e0:	6a 00                	push   $0x0
  8018e2:	6a 00                	push   $0x0
  8018e4:	6a 00                	push   $0x0
  8018e6:	6a 00                	push   $0x0
  8018e8:	6a 00                	push   $0x0
  8018ea:	6a 25                	push   $0x25
  8018ec:	e8 82 fb ff ff       	call   801473 <syscall>
  8018f1:	83 c4 18             	add    $0x18,%esp
}
  8018f4:	c9                   	leave  
  8018f5:	c3                   	ret    

008018f6 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  8018f6:	55                   	push   %ebp
  8018f7:	89 e5                	mov    %esp,%ebp
  8018f9:	83 ec 04             	sub    $0x4,%esp
  8018fc:	8b 45 08             	mov    0x8(%ebp),%eax
  8018ff:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801902:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801906:	6a 00                	push   $0x0
  801908:	6a 00                	push   $0x0
  80190a:	6a 00                	push   $0x0
  80190c:	6a 00                	push   $0x0
  80190e:	50                   	push   %eax
  80190f:	6a 26                	push   $0x26
  801911:	e8 5d fb ff ff       	call   801473 <syscall>
  801916:	83 c4 18             	add    $0x18,%esp
	return ;
  801919:	90                   	nop
}
  80191a:	c9                   	leave  
  80191b:	c3                   	ret    

0080191c <rsttst>:
void rsttst()
{
  80191c:	55                   	push   %ebp
  80191d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80191f:	6a 00                	push   $0x0
  801921:	6a 00                	push   $0x0
  801923:	6a 00                	push   $0x0
  801925:	6a 00                	push   $0x0
  801927:	6a 00                	push   $0x0
  801929:	6a 28                	push   $0x28
  80192b:	e8 43 fb ff ff       	call   801473 <syscall>
  801930:	83 c4 18             	add    $0x18,%esp
	return ;
  801933:	90                   	nop
}
  801934:	c9                   	leave  
  801935:	c3                   	ret    

00801936 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801936:	55                   	push   %ebp
  801937:	89 e5                	mov    %esp,%ebp
  801939:	83 ec 04             	sub    $0x4,%esp
  80193c:	8b 45 14             	mov    0x14(%ebp),%eax
  80193f:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801942:	8b 55 18             	mov    0x18(%ebp),%edx
  801945:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801949:	52                   	push   %edx
  80194a:	50                   	push   %eax
  80194b:	ff 75 10             	pushl  0x10(%ebp)
  80194e:	ff 75 0c             	pushl  0xc(%ebp)
  801951:	ff 75 08             	pushl  0x8(%ebp)
  801954:	6a 27                	push   $0x27
  801956:	e8 18 fb ff ff       	call   801473 <syscall>
  80195b:	83 c4 18             	add    $0x18,%esp
	return ;
  80195e:	90                   	nop
}
  80195f:	c9                   	leave  
  801960:	c3                   	ret    

00801961 <chktst>:
void chktst(uint32 n)
{
  801961:	55                   	push   %ebp
  801962:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801964:	6a 00                	push   $0x0
  801966:	6a 00                	push   $0x0
  801968:	6a 00                	push   $0x0
  80196a:	6a 00                	push   $0x0
  80196c:	ff 75 08             	pushl  0x8(%ebp)
  80196f:	6a 29                	push   $0x29
  801971:	e8 fd fa ff ff       	call   801473 <syscall>
  801976:	83 c4 18             	add    $0x18,%esp
	return ;
  801979:	90                   	nop
}
  80197a:	c9                   	leave  
  80197b:	c3                   	ret    

0080197c <inctst>:

void inctst()
{
  80197c:	55                   	push   %ebp
  80197d:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  80197f:	6a 00                	push   $0x0
  801981:	6a 00                	push   $0x0
  801983:	6a 00                	push   $0x0
  801985:	6a 00                	push   $0x0
  801987:	6a 00                	push   $0x0
  801989:	6a 2a                	push   $0x2a
  80198b:	e8 e3 fa ff ff       	call   801473 <syscall>
  801990:	83 c4 18             	add    $0x18,%esp
	return ;
  801993:	90                   	nop
}
  801994:	c9                   	leave  
  801995:	c3                   	ret    

00801996 <gettst>:
uint32 gettst()
{
  801996:	55                   	push   %ebp
  801997:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  801999:	6a 00                	push   $0x0
  80199b:	6a 00                	push   $0x0
  80199d:	6a 00                	push   $0x0
  80199f:	6a 00                	push   $0x0
  8019a1:	6a 00                	push   $0x0
  8019a3:	6a 2b                	push   $0x2b
  8019a5:	e8 c9 fa ff ff       	call   801473 <syscall>
  8019aa:	83 c4 18             	add    $0x18,%esp
}
  8019ad:	c9                   	leave  
  8019ae:	c3                   	ret    

008019af <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8019af:	55                   	push   %ebp
  8019b0:	89 e5                	mov    %esp,%ebp
  8019b2:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019b5:	6a 00                	push   $0x0
  8019b7:	6a 00                	push   $0x0
  8019b9:	6a 00                	push   $0x0
  8019bb:	6a 00                	push   $0x0
  8019bd:	6a 00                	push   $0x0
  8019bf:	6a 2c                	push   $0x2c
  8019c1:	e8 ad fa ff ff       	call   801473 <syscall>
  8019c6:	83 c4 18             	add    $0x18,%esp
  8019c9:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8019cc:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8019d0:	75 07                	jne    8019d9 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  8019d2:	b8 01 00 00 00       	mov    $0x1,%eax
  8019d7:	eb 05                	jmp    8019de <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  8019d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8019de:	c9                   	leave  
  8019df:	c3                   	ret    

008019e0 <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  8019e0:	55                   	push   %ebp
  8019e1:	89 e5                	mov    %esp,%ebp
  8019e3:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8019e6:	6a 00                	push   $0x0
  8019e8:	6a 00                	push   $0x0
  8019ea:	6a 00                	push   $0x0
  8019ec:	6a 00                	push   $0x0
  8019ee:	6a 00                	push   $0x0
  8019f0:	6a 2c                	push   $0x2c
  8019f2:	e8 7c fa ff ff       	call   801473 <syscall>
  8019f7:	83 c4 18             	add    $0x18,%esp
  8019fa:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  8019fd:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801a01:	75 07                	jne    801a0a <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801a03:	b8 01 00 00 00       	mov    $0x1,%eax
  801a08:	eb 05                	jmp    801a0f <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801a0a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a0f:	c9                   	leave  
  801a10:	c3                   	ret    

00801a11 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801a11:	55                   	push   %ebp
  801a12:	89 e5                	mov    %esp,%ebp
  801a14:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a17:	6a 00                	push   $0x0
  801a19:	6a 00                	push   $0x0
  801a1b:	6a 00                	push   $0x0
  801a1d:	6a 00                	push   $0x0
  801a1f:	6a 00                	push   $0x0
  801a21:	6a 2c                	push   $0x2c
  801a23:	e8 4b fa ff ff       	call   801473 <syscall>
  801a28:	83 c4 18             	add    $0x18,%esp
  801a2b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  801a2e:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801a32:	75 07                	jne    801a3b <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801a34:	b8 01 00 00 00       	mov    $0x1,%eax
  801a39:	eb 05                	jmp    801a40 <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  801a3b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a40:	c9                   	leave  
  801a41:	c3                   	ret    

00801a42 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801a42:	55                   	push   %ebp
  801a43:	89 e5                	mov    %esp,%ebp
  801a45:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801a48:	6a 00                	push   $0x0
  801a4a:	6a 00                	push   $0x0
  801a4c:	6a 00                	push   $0x0
  801a4e:	6a 00                	push   $0x0
  801a50:	6a 00                	push   $0x0
  801a52:	6a 2c                	push   $0x2c
  801a54:	e8 1a fa ff ff       	call   801473 <syscall>
  801a59:	83 c4 18             	add    $0x18,%esp
  801a5c:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  801a5f:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801a63:	75 07                	jne    801a6c <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801a65:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6a:	eb 05                	jmp    801a71 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  801a6c:	b8 00 00 00 00       	mov    $0x0,%eax
}
  801a71:	c9                   	leave  
  801a72:	c3                   	ret    

00801a73 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  801a73:	55                   	push   %ebp
  801a74:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  801a76:	6a 00                	push   $0x0
  801a78:	6a 00                	push   $0x0
  801a7a:	6a 00                	push   $0x0
  801a7c:	6a 00                	push   $0x0
  801a7e:	ff 75 08             	pushl  0x8(%ebp)
  801a81:	6a 2d                	push   $0x2d
  801a83:	e8 eb f9 ff ff       	call   801473 <syscall>
  801a88:	83 c4 18             	add    $0x18,%esp
	return ;
  801a8b:	90                   	nop
}
  801a8c:	c9                   	leave  
  801a8d:	c3                   	ret    

00801a8e <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  801a8e:	55                   	push   %ebp
  801a8f:	89 e5                	mov    %esp,%ebp
  801a91:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  801a92:	8b 5d 14             	mov    0x14(%ebp),%ebx
  801a95:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801a98:	8b 55 0c             	mov    0xc(%ebp),%edx
  801a9b:	8b 45 08             	mov    0x8(%ebp),%eax
  801a9e:	6a 00                	push   $0x0
  801aa0:	53                   	push   %ebx
  801aa1:	51                   	push   %ecx
  801aa2:	52                   	push   %edx
  801aa3:	50                   	push   %eax
  801aa4:	6a 2e                	push   $0x2e
  801aa6:	e8 c8 f9 ff ff       	call   801473 <syscall>
  801aab:	83 c4 18             	add    $0x18,%esp
}
  801aae:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  801ab1:	c9                   	leave  
  801ab2:	c3                   	ret    

00801ab3 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  801ab3:	55                   	push   %ebp
  801ab4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  801ab6:	8b 55 0c             	mov    0xc(%ebp),%edx
  801ab9:	8b 45 08             	mov    0x8(%ebp),%eax
  801abc:	6a 00                	push   $0x0
  801abe:	6a 00                	push   $0x0
  801ac0:	6a 00                	push   $0x0
  801ac2:	52                   	push   %edx
  801ac3:	50                   	push   %eax
  801ac4:	6a 2f                	push   $0x2f
  801ac6:	e8 a8 f9 ff ff       	call   801473 <syscall>
  801acb:	83 c4 18             	add    $0x18,%esp
}
  801ace:	c9                   	leave  
  801acf:	c3                   	ret    

00801ad0 <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  801ad0:	55                   	push   %ebp
  801ad1:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801ad3:	6a 00                	push   $0x0
  801ad5:	6a 00                	push   $0x0
  801ad7:	6a 00                	push   $0x0
  801ad9:	ff 75 0c             	pushl  0xc(%ebp)
  801adc:	ff 75 08             	pushl  0x8(%ebp)
  801adf:	6a 30                	push   $0x30
  801ae1:	e8 8d f9 ff ff       	call   801473 <syscall>
  801ae6:	83 c4 18             	add    $0x18,%esp
	return ;
  801ae9:	90                   	nop
}
  801aea:	c9                   	leave  
  801aeb:	c3                   	ret    

00801aec <__udivdi3>:
  801aec:	55                   	push   %ebp
  801aed:	57                   	push   %edi
  801aee:	56                   	push   %esi
  801aef:	53                   	push   %ebx
  801af0:	83 ec 1c             	sub    $0x1c,%esp
  801af3:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801af7:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801afb:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801aff:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801b03:	89 ca                	mov    %ecx,%edx
  801b05:	89 f8                	mov    %edi,%eax
  801b07:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801b0b:	85 f6                	test   %esi,%esi
  801b0d:	75 2d                	jne    801b3c <__udivdi3+0x50>
  801b0f:	39 cf                	cmp    %ecx,%edi
  801b11:	77 65                	ja     801b78 <__udivdi3+0x8c>
  801b13:	89 fd                	mov    %edi,%ebp
  801b15:	85 ff                	test   %edi,%edi
  801b17:	75 0b                	jne    801b24 <__udivdi3+0x38>
  801b19:	b8 01 00 00 00       	mov    $0x1,%eax
  801b1e:	31 d2                	xor    %edx,%edx
  801b20:	f7 f7                	div    %edi
  801b22:	89 c5                	mov    %eax,%ebp
  801b24:	31 d2                	xor    %edx,%edx
  801b26:	89 c8                	mov    %ecx,%eax
  801b28:	f7 f5                	div    %ebp
  801b2a:	89 c1                	mov    %eax,%ecx
  801b2c:	89 d8                	mov    %ebx,%eax
  801b2e:	f7 f5                	div    %ebp
  801b30:	89 cf                	mov    %ecx,%edi
  801b32:	89 fa                	mov    %edi,%edx
  801b34:	83 c4 1c             	add    $0x1c,%esp
  801b37:	5b                   	pop    %ebx
  801b38:	5e                   	pop    %esi
  801b39:	5f                   	pop    %edi
  801b3a:	5d                   	pop    %ebp
  801b3b:	c3                   	ret    
  801b3c:	39 ce                	cmp    %ecx,%esi
  801b3e:	77 28                	ja     801b68 <__udivdi3+0x7c>
  801b40:	0f bd fe             	bsr    %esi,%edi
  801b43:	83 f7 1f             	xor    $0x1f,%edi
  801b46:	75 40                	jne    801b88 <__udivdi3+0x9c>
  801b48:	39 ce                	cmp    %ecx,%esi
  801b4a:	72 0a                	jb     801b56 <__udivdi3+0x6a>
  801b4c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801b50:	0f 87 9e 00 00 00    	ja     801bf4 <__udivdi3+0x108>
  801b56:	b8 01 00 00 00       	mov    $0x1,%eax
  801b5b:	89 fa                	mov    %edi,%edx
  801b5d:	83 c4 1c             	add    $0x1c,%esp
  801b60:	5b                   	pop    %ebx
  801b61:	5e                   	pop    %esi
  801b62:	5f                   	pop    %edi
  801b63:	5d                   	pop    %ebp
  801b64:	c3                   	ret    
  801b65:	8d 76 00             	lea    0x0(%esi),%esi
  801b68:	31 ff                	xor    %edi,%edi
  801b6a:	31 c0                	xor    %eax,%eax
  801b6c:	89 fa                	mov    %edi,%edx
  801b6e:	83 c4 1c             	add    $0x1c,%esp
  801b71:	5b                   	pop    %ebx
  801b72:	5e                   	pop    %esi
  801b73:	5f                   	pop    %edi
  801b74:	5d                   	pop    %ebp
  801b75:	c3                   	ret    
  801b76:	66 90                	xchg   %ax,%ax
  801b78:	89 d8                	mov    %ebx,%eax
  801b7a:	f7 f7                	div    %edi
  801b7c:	31 ff                	xor    %edi,%edi
  801b7e:	89 fa                	mov    %edi,%edx
  801b80:	83 c4 1c             	add    $0x1c,%esp
  801b83:	5b                   	pop    %ebx
  801b84:	5e                   	pop    %esi
  801b85:	5f                   	pop    %edi
  801b86:	5d                   	pop    %ebp
  801b87:	c3                   	ret    
  801b88:	bd 20 00 00 00       	mov    $0x20,%ebp
  801b8d:	89 eb                	mov    %ebp,%ebx
  801b8f:	29 fb                	sub    %edi,%ebx
  801b91:	89 f9                	mov    %edi,%ecx
  801b93:	d3 e6                	shl    %cl,%esi
  801b95:	89 c5                	mov    %eax,%ebp
  801b97:	88 d9                	mov    %bl,%cl
  801b99:	d3 ed                	shr    %cl,%ebp
  801b9b:	89 e9                	mov    %ebp,%ecx
  801b9d:	09 f1                	or     %esi,%ecx
  801b9f:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ba3:	89 f9                	mov    %edi,%ecx
  801ba5:	d3 e0                	shl    %cl,%eax
  801ba7:	89 c5                	mov    %eax,%ebp
  801ba9:	89 d6                	mov    %edx,%esi
  801bab:	88 d9                	mov    %bl,%cl
  801bad:	d3 ee                	shr    %cl,%esi
  801baf:	89 f9                	mov    %edi,%ecx
  801bb1:	d3 e2                	shl    %cl,%edx
  801bb3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801bb7:	88 d9                	mov    %bl,%cl
  801bb9:	d3 e8                	shr    %cl,%eax
  801bbb:	09 c2                	or     %eax,%edx
  801bbd:	89 d0                	mov    %edx,%eax
  801bbf:	89 f2                	mov    %esi,%edx
  801bc1:	f7 74 24 0c          	divl   0xc(%esp)
  801bc5:	89 d6                	mov    %edx,%esi
  801bc7:	89 c3                	mov    %eax,%ebx
  801bc9:	f7 e5                	mul    %ebp
  801bcb:	39 d6                	cmp    %edx,%esi
  801bcd:	72 19                	jb     801be8 <__udivdi3+0xfc>
  801bcf:	74 0b                	je     801bdc <__udivdi3+0xf0>
  801bd1:	89 d8                	mov    %ebx,%eax
  801bd3:	31 ff                	xor    %edi,%edi
  801bd5:	e9 58 ff ff ff       	jmp    801b32 <__udivdi3+0x46>
  801bda:	66 90                	xchg   %ax,%ax
  801bdc:	8b 54 24 08          	mov    0x8(%esp),%edx
  801be0:	89 f9                	mov    %edi,%ecx
  801be2:	d3 e2                	shl    %cl,%edx
  801be4:	39 c2                	cmp    %eax,%edx
  801be6:	73 e9                	jae    801bd1 <__udivdi3+0xe5>
  801be8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801beb:	31 ff                	xor    %edi,%edi
  801bed:	e9 40 ff ff ff       	jmp    801b32 <__udivdi3+0x46>
  801bf2:	66 90                	xchg   %ax,%ax
  801bf4:	31 c0                	xor    %eax,%eax
  801bf6:	e9 37 ff ff ff       	jmp    801b32 <__udivdi3+0x46>
  801bfb:	90                   	nop

00801bfc <__umoddi3>:
  801bfc:	55                   	push   %ebp
  801bfd:	57                   	push   %edi
  801bfe:	56                   	push   %esi
  801bff:	53                   	push   %ebx
  801c00:	83 ec 1c             	sub    $0x1c,%esp
  801c03:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801c07:	8b 74 24 34          	mov    0x34(%esp),%esi
  801c0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801c0f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801c13:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801c17:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801c1b:	89 f3                	mov    %esi,%ebx
  801c1d:	89 fa                	mov    %edi,%edx
  801c1f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c23:	89 34 24             	mov    %esi,(%esp)
  801c26:	85 c0                	test   %eax,%eax
  801c28:	75 1a                	jne    801c44 <__umoddi3+0x48>
  801c2a:	39 f7                	cmp    %esi,%edi
  801c2c:	0f 86 a2 00 00 00    	jbe    801cd4 <__umoddi3+0xd8>
  801c32:	89 c8                	mov    %ecx,%eax
  801c34:	89 f2                	mov    %esi,%edx
  801c36:	f7 f7                	div    %edi
  801c38:	89 d0                	mov    %edx,%eax
  801c3a:	31 d2                	xor    %edx,%edx
  801c3c:	83 c4 1c             	add    $0x1c,%esp
  801c3f:	5b                   	pop    %ebx
  801c40:	5e                   	pop    %esi
  801c41:	5f                   	pop    %edi
  801c42:	5d                   	pop    %ebp
  801c43:	c3                   	ret    
  801c44:	39 f0                	cmp    %esi,%eax
  801c46:	0f 87 ac 00 00 00    	ja     801cf8 <__umoddi3+0xfc>
  801c4c:	0f bd e8             	bsr    %eax,%ebp
  801c4f:	83 f5 1f             	xor    $0x1f,%ebp
  801c52:	0f 84 ac 00 00 00    	je     801d04 <__umoddi3+0x108>
  801c58:	bf 20 00 00 00       	mov    $0x20,%edi
  801c5d:	29 ef                	sub    %ebp,%edi
  801c5f:	89 fe                	mov    %edi,%esi
  801c61:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801c65:	89 e9                	mov    %ebp,%ecx
  801c67:	d3 e0                	shl    %cl,%eax
  801c69:	89 d7                	mov    %edx,%edi
  801c6b:	89 f1                	mov    %esi,%ecx
  801c6d:	d3 ef                	shr    %cl,%edi
  801c6f:	09 c7                	or     %eax,%edi
  801c71:	89 e9                	mov    %ebp,%ecx
  801c73:	d3 e2                	shl    %cl,%edx
  801c75:	89 14 24             	mov    %edx,(%esp)
  801c78:	89 d8                	mov    %ebx,%eax
  801c7a:	d3 e0                	shl    %cl,%eax
  801c7c:	89 c2                	mov    %eax,%edx
  801c7e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c82:	d3 e0                	shl    %cl,%eax
  801c84:	89 44 24 04          	mov    %eax,0x4(%esp)
  801c88:	8b 44 24 08          	mov    0x8(%esp),%eax
  801c8c:	89 f1                	mov    %esi,%ecx
  801c8e:	d3 e8                	shr    %cl,%eax
  801c90:	09 d0                	or     %edx,%eax
  801c92:	d3 eb                	shr    %cl,%ebx
  801c94:	89 da                	mov    %ebx,%edx
  801c96:	f7 f7                	div    %edi
  801c98:	89 d3                	mov    %edx,%ebx
  801c9a:	f7 24 24             	mull   (%esp)
  801c9d:	89 c6                	mov    %eax,%esi
  801c9f:	89 d1                	mov    %edx,%ecx
  801ca1:	39 d3                	cmp    %edx,%ebx
  801ca3:	0f 82 87 00 00 00    	jb     801d30 <__umoddi3+0x134>
  801ca9:	0f 84 91 00 00 00    	je     801d40 <__umoddi3+0x144>
  801caf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801cb3:	29 f2                	sub    %esi,%edx
  801cb5:	19 cb                	sbb    %ecx,%ebx
  801cb7:	89 d8                	mov    %ebx,%eax
  801cb9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801cbd:	d3 e0                	shl    %cl,%eax
  801cbf:	89 e9                	mov    %ebp,%ecx
  801cc1:	d3 ea                	shr    %cl,%edx
  801cc3:	09 d0                	or     %edx,%eax
  801cc5:	89 e9                	mov    %ebp,%ecx
  801cc7:	d3 eb                	shr    %cl,%ebx
  801cc9:	89 da                	mov    %ebx,%edx
  801ccb:	83 c4 1c             	add    $0x1c,%esp
  801cce:	5b                   	pop    %ebx
  801ccf:	5e                   	pop    %esi
  801cd0:	5f                   	pop    %edi
  801cd1:	5d                   	pop    %ebp
  801cd2:	c3                   	ret    
  801cd3:	90                   	nop
  801cd4:	89 fd                	mov    %edi,%ebp
  801cd6:	85 ff                	test   %edi,%edi
  801cd8:	75 0b                	jne    801ce5 <__umoddi3+0xe9>
  801cda:	b8 01 00 00 00       	mov    $0x1,%eax
  801cdf:	31 d2                	xor    %edx,%edx
  801ce1:	f7 f7                	div    %edi
  801ce3:	89 c5                	mov    %eax,%ebp
  801ce5:	89 f0                	mov    %esi,%eax
  801ce7:	31 d2                	xor    %edx,%edx
  801ce9:	f7 f5                	div    %ebp
  801ceb:	89 c8                	mov    %ecx,%eax
  801ced:	f7 f5                	div    %ebp
  801cef:	89 d0                	mov    %edx,%eax
  801cf1:	e9 44 ff ff ff       	jmp    801c3a <__umoddi3+0x3e>
  801cf6:	66 90                	xchg   %ax,%ax
  801cf8:	89 c8                	mov    %ecx,%eax
  801cfa:	89 f2                	mov    %esi,%edx
  801cfc:	83 c4 1c             	add    $0x1c,%esp
  801cff:	5b                   	pop    %ebx
  801d00:	5e                   	pop    %esi
  801d01:	5f                   	pop    %edi
  801d02:	5d                   	pop    %ebp
  801d03:	c3                   	ret    
  801d04:	3b 04 24             	cmp    (%esp),%eax
  801d07:	72 06                	jb     801d0f <__umoddi3+0x113>
  801d09:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801d0d:	77 0f                	ja     801d1e <__umoddi3+0x122>
  801d0f:	89 f2                	mov    %esi,%edx
  801d11:	29 f9                	sub    %edi,%ecx
  801d13:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801d17:	89 14 24             	mov    %edx,(%esp)
  801d1a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801d1e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801d22:	8b 14 24             	mov    (%esp),%edx
  801d25:	83 c4 1c             	add    $0x1c,%esp
  801d28:	5b                   	pop    %ebx
  801d29:	5e                   	pop    %esi
  801d2a:	5f                   	pop    %edi
  801d2b:	5d                   	pop    %ebp
  801d2c:	c3                   	ret    
  801d2d:	8d 76 00             	lea    0x0(%esi),%esi
  801d30:	2b 04 24             	sub    (%esp),%eax
  801d33:	19 fa                	sbb    %edi,%edx
  801d35:	89 d1                	mov    %edx,%ecx
  801d37:	89 c6                	mov    %eax,%esi
  801d39:	e9 71 ff ff ff       	jmp    801caf <__umoddi3+0xb3>
  801d3e:	66 90                	xchg   %ax,%ax
  801d40:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801d44:	72 ea                	jb     801d30 <__umoddi3+0x134>
  801d46:	89 d9                	mov    %ebx,%ecx
  801d48:	e9 62 ff ff ff       	jmp    801caf <__umoddi3+0xb3>
