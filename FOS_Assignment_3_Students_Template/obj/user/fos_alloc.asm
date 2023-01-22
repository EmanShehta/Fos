
obj/user/fos_alloc:     file format elf32-i386


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
  800031:	e8 02 01 00 00       	call   800138 <libmain>
1:      jmp 1b
  800036:	eb fe                	jmp    800036 <args_exist+0x5>

00800038 <_main>:
#include <inc/lib.h>


void _main(void)
{	
  800038:	55                   	push   %ebp
  800039:	89 e5                	mov    %esp,%ebp
  80003b:	83 ec 18             	sub    $0x18,%esp
	//uint32 size = 2*1024*1024 +120*4096+1;
	//uint32 size = 1*1024*1024 + 256*1024;
	//uint32 size = 1*1024*1024;
	uint32 size = 100;
  80003e:	c7 45 f0 64 00 00 00 	movl   $0x64,-0x10(%ebp)

	unsigned char *x = malloc(sizeof(unsigned char)*size) ;
  800045:	83 ec 0c             	sub    $0xc,%esp
  800048:	ff 75 f0             	pushl  -0x10(%ebp)
  80004b:	e8 62 10 00 00       	call   8010b2 <malloc>
  800050:	83 c4 10             	add    $0x10,%esp
  800053:	89 45 ec             	mov    %eax,-0x14(%ebp)
	atomic_cprintf("x allocated at %x\n",x);
  800056:	83 ec 08             	sub    $0x8,%esp
  800059:	ff 75 ec             	pushl  -0x14(%ebp)
  80005c:	68 60 1c 80 00       	push   $0x801c60
  800061:	e8 ef 02 00 00       	call   800355 <atomic_cprintf>
  800066:	83 c4 10             	add    $0x10,%esp

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  800069:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  800070:	eb 20                	jmp    800092 <_main+0x5a>
	{
		x[i] = i%256 ;
  800072:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800075:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800078:	01 c2                	add    %eax,%edx
  80007a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  80007d:	25 ff 00 00 80       	and    $0x800000ff,%eax
  800082:	85 c0                	test   %eax,%eax
  800084:	79 07                	jns    80008d <_main+0x55>
  800086:	48                   	dec    %eax
  800087:	0d 00 ff ff ff       	or     $0xffffff00,%eax
  80008c:	40                   	inc    %eax
  80008d:	88 02                	mov    %al,(%edx)

	//unsigned char *z = malloc(sizeof(unsigned char)*size) ;
	//cprintf("z allocated at %x\n",z);
	
	int i ;
	for (i = 0 ; i < size ; i++)
  80008f:	ff 45 f4             	incl   -0xc(%ebp)
  800092:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800095:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800098:	72 d8                	jb     800072 <_main+0x3a>
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  80009a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80009d:	83 e8 07             	sub    $0x7,%eax
  8000a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000a3:	eb 24                	jmp    8000c9 <_main+0x91>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
  8000a5:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000a8:	8b 45 ec             	mov    -0x14(%ebp),%eax
  8000ab:	01 d0                	add    %edx,%eax
  8000ad:	8a 00                	mov    (%eax),%al
  8000af:	0f b6 c0             	movzbl %al,%eax
  8000b2:	83 ec 04             	sub    $0x4,%esp
  8000b5:	50                   	push   %eax
  8000b6:	ff 75 f4             	pushl  -0xc(%ebp)
  8000b9:	68 73 1c 80 00       	push   $0x801c73
  8000be:	e8 92 02 00 00       	call   800355 <atomic_cprintf>
  8000c3:	83 c4 10             	add    $0x10,%esp
		////z[i] = (int)(x[i]  * y[i]);
		////z[i] = i%256;
	}

	
	for (i = size-7 ; i < size ; i++)
  8000c6:	ff 45 f4             	incl   -0xc(%ebp)
  8000c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8000cc:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8000cf:	72 d4                	jb     8000a5 <_main+0x6d>
		atomic_cprintf("x[%d] = %d\n",i, x[i]);
	
	free(x);
  8000d1:	83 ec 0c             	sub    $0xc,%esp
  8000d4:	ff 75 ec             	pushl  -0x14(%ebp)
  8000d7:	e8 f0 0f 00 00       	call   8010cc <free>
  8000dc:	83 c4 10             	add    $0x10,%esp

	x = malloc(sizeof(unsigned char)*size) ;
  8000df:	83 ec 0c             	sub    $0xc,%esp
  8000e2:	ff 75 f0             	pushl  -0x10(%ebp)
  8000e5:	e8 c8 0f 00 00       	call   8010b2 <malloc>
  8000ea:	83 c4 10             	add    $0x10,%esp
  8000ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
	
	for (i = size-7 ; i < size ; i++)
  8000f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8000f3:	83 e8 07             	sub    $0x7,%eax
  8000f6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  8000f9:	eb 24                	jmp    80011f <_main+0xe7>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
  8000fb:	8b 55 f4             	mov    -0xc(%ebp),%edx
  8000fe:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800101:	01 d0                	add    %edx,%eax
  800103:	8a 00                	mov    (%eax),%al
  800105:	0f b6 c0             	movzbl %al,%eax
  800108:	83 ec 04             	sub    $0x4,%esp
  80010b:	50                   	push   %eax
  80010c:	ff 75 f4             	pushl  -0xc(%ebp)
  80010f:	68 73 1c 80 00       	push   $0x801c73
  800114:	e8 3c 02 00 00       	call   800355 <atomic_cprintf>
  800119:	83 c4 10             	add    $0x10,%esp
	
	free(x);

	x = malloc(sizeof(unsigned char)*size) ;
	
	for (i = size-7 ; i < size ; i++)
  80011c:	ff 45 f4             	incl   -0xc(%ebp)
  80011f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800122:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800125:	72 d4                	jb     8000fb <_main+0xc3>
	{
		atomic_cprintf("x[%d] = %d\n",i,x[i]);
	}

	free(x);
  800127:	83 ec 0c             	sub    $0xc,%esp
  80012a:	ff 75 ec             	pushl  -0x14(%ebp)
  80012d:	e8 9a 0f 00 00       	call   8010cc <free>
  800132:	83 c4 10             	add    $0x10,%esp
	
	return;	
  800135:	90                   	nop
}
  800136:	c9                   	leave  
  800137:	c3                   	ret    

00800138 <libmain>:
volatile struct Env *myEnv = NULL;
volatile char *binaryname = "(PROGRAM NAME UNKNOWN)";

void
libmain(int argc, char **argv)
{
  800138:	55                   	push   %ebp
  800139:	89 e5                	mov    %esp,%ebp
  80013b:	83 ec 18             	sub    $0x18,%esp
	int envIndex = sys_getenvindex();
  80013e:	e8 00 11 00 00       	call   801243 <sys_getenvindex>
  800143:	89 45 f4             	mov    %eax,-0xc(%ebp)
	myEnv = &(envs[envIndex]);
  800146:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800149:	89 d0                	mov    %edx,%eax
  80014b:	01 c0                	add    %eax,%eax
  80014d:	01 d0                	add    %edx,%eax
  80014f:	c1 e0 04             	shl    $0x4,%eax
  800152:	29 d0                	sub    %edx,%eax
  800154:	c1 e0 03             	shl    $0x3,%eax
  800157:	01 d0                	add    %edx,%eax
  800159:	c1 e0 02             	shl    $0x2,%eax
  80015c:	05 00 00 c0 ee       	add    $0xeec00000,%eax
  800161:	a3 20 30 80 00       	mov    %eax,0x803020

	//SET THE PROGRAM NAME
	if (myEnv->prog_name[0] != '\0')
  800166:	a1 20 30 80 00       	mov    0x803020,%eax
  80016b:	8a 80 5c 05 00 00    	mov    0x55c(%eax),%al
  800171:	84 c0                	test   %al,%al
  800173:	74 0f                	je     800184 <libmain+0x4c>
		binaryname = myEnv->prog_name;
  800175:	a1 20 30 80 00       	mov    0x803020,%eax
  80017a:	05 5c 05 00 00       	add    $0x55c,%eax
  80017f:	a3 00 30 80 00       	mov    %eax,0x803000

	// set env to point at our env structure in envs[].
	// env = envs;

	// save the name of the program so that panic() can use it
	if (argc > 0)
  800184:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800188:	7e 0a                	jle    800194 <libmain+0x5c>
		binaryname = argv[0];
  80018a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80018d:	8b 00                	mov    (%eax),%eax
  80018f:	a3 00 30 80 00       	mov    %eax,0x803000

	// call user main routine
	_main(argc, argv);
  800194:	83 ec 08             	sub    $0x8,%esp
  800197:	ff 75 0c             	pushl  0xc(%ebp)
  80019a:	ff 75 08             	pushl  0x8(%ebp)
  80019d:	e8 96 fe ff ff       	call   800038 <_main>
  8001a2:	83 c4 10             	add    $0x10,%esp



	sys_disable_interrupt();
  8001a5:	e8 34 12 00 00       	call   8013de <sys_disable_interrupt>
	cprintf("**************************************\n");
  8001aa:	83 ec 0c             	sub    $0xc,%esp
  8001ad:	68 98 1c 80 00       	push   $0x801c98
  8001b2:	e8 71 01 00 00       	call   800328 <cprintf>
  8001b7:	83 c4 10             	add    $0x10,%esp
	cprintf("Num of PAGE faults = %d, modif = %d\n", myEnv->pageFaultsCounter, myEnv->nModifiedPages);
  8001ba:	a1 20 30 80 00       	mov    0x803020,%eax
  8001bf:	8b 90 44 05 00 00    	mov    0x544(%eax),%edx
  8001c5:	a1 20 30 80 00       	mov    0x803020,%eax
  8001ca:	8b 80 34 05 00 00    	mov    0x534(%eax),%eax
  8001d0:	83 ec 04             	sub    $0x4,%esp
  8001d3:	52                   	push   %edx
  8001d4:	50                   	push   %eax
  8001d5:	68 c0 1c 80 00       	push   $0x801cc0
  8001da:	e8 49 01 00 00       	call   800328 <cprintf>
  8001df:	83 c4 10             	add    $0x10,%esp
	cprintf("# PAGE IN (from disk) = %d, # PAGE OUT (on disk) = %d, # NEW PAGE ADDED (on disk) = %d\n", myEnv->nPageIn, myEnv->nPageOut, myEnv->nNewPageAdded);
  8001e2:	a1 20 30 80 00       	mov    0x803020,%eax
  8001e7:	8b 88 54 05 00 00    	mov    0x554(%eax),%ecx
  8001ed:	a1 20 30 80 00       	mov    0x803020,%eax
  8001f2:	8b 90 50 05 00 00    	mov    0x550(%eax),%edx
  8001f8:	a1 20 30 80 00       	mov    0x803020,%eax
  8001fd:	8b 80 4c 05 00 00    	mov    0x54c(%eax),%eax
  800203:	51                   	push   %ecx
  800204:	52                   	push   %edx
  800205:	50                   	push   %eax
  800206:	68 e8 1c 80 00       	push   $0x801ce8
  80020b:	e8 18 01 00 00       	call   800328 <cprintf>
  800210:	83 c4 10             	add    $0x10,%esp
	//cprintf("Num of freeing scarce memory = %d, freeing full working set = %d\n", myEnv->freeingScarceMemCounter, myEnv->freeingFullWSCounter);
	//cprintf("Num of clocks = %d\n", myEnv->nClocks);
	cprintf("**************************************\n");
  800213:	83 ec 0c             	sub    $0xc,%esp
  800216:	68 98 1c 80 00       	push   $0x801c98
  80021b:	e8 08 01 00 00       	call   800328 <cprintf>
  800220:	83 c4 10             	add    $0x10,%esp
	sys_enable_interrupt();
  800223:	e8 d0 11 00 00       	call   8013f8 <sys_enable_interrupt>

	// exit gracefully
	exit();
  800228:	e8 19 00 00 00       	call   800246 <exit>
}
  80022d:	90                   	nop
  80022e:	c9                   	leave  
  80022f:	c3                   	ret    

00800230 <destroy>:

#include <inc/lib.h>

void
destroy(void)
{
  800230:	55                   	push   %ebp
  800231:	89 e5                	mov    %esp,%ebp
  800233:	83 ec 08             	sub    $0x8,%esp
	sys_env_destroy(0);
  800236:	83 ec 0c             	sub    $0xc,%esp
  800239:	6a 00                	push   $0x0
  80023b:	e8 cf 0f 00 00       	call   80120f <sys_env_destroy>
  800240:	83 c4 10             	add    $0x10,%esp
}
  800243:	90                   	nop
  800244:	c9                   	leave  
  800245:	c3                   	ret    

00800246 <exit>:

void
exit(void)
{
  800246:	55                   	push   %ebp
  800247:	89 e5                	mov    %esp,%ebp
  800249:	83 ec 08             	sub    $0x8,%esp
	sys_env_exit();
  80024c:	e8 24 10 00 00       	call   801275 <sys_env_exit>
}
  800251:	90                   	nop
  800252:	c9                   	leave  
  800253:	c3                   	ret    

00800254 <putch>:
};

//2017:
uint8 printProgName = 0;

static void putch(int ch, struct printbuf *b) {
  800254:	55                   	push   %ebp
  800255:	89 e5                	mov    %esp,%ebp
  800257:	83 ec 08             	sub    $0x8,%esp
	b->buf[b->idx++] = ch;
  80025a:	8b 45 0c             	mov    0xc(%ebp),%eax
  80025d:	8b 00                	mov    (%eax),%eax
  80025f:	8d 48 01             	lea    0x1(%eax),%ecx
  800262:	8b 55 0c             	mov    0xc(%ebp),%edx
  800265:	89 0a                	mov    %ecx,(%edx)
  800267:	8b 55 08             	mov    0x8(%ebp),%edx
  80026a:	88 d1                	mov    %dl,%cl
  80026c:	8b 55 0c             	mov    0xc(%ebp),%edx
  80026f:	88 4c 02 08          	mov    %cl,0x8(%edx,%eax,1)
	if (b->idx == 256 - 1) {
  800273:	8b 45 0c             	mov    0xc(%ebp),%eax
  800276:	8b 00                	mov    (%eax),%eax
  800278:	3d ff 00 00 00       	cmp    $0xff,%eax
  80027d:	75 2c                	jne    8002ab <putch+0x57>
		sys_cputs(b->buf, b->idx, printProgName);
  80027f:	a0 24 30 80 00       	mov    0x803024,%al
  800284:	0f b6 c0             	movzbl %al,%eax
  800287:	8b 55 0c             	mov    0xc(%ebp),%edx
  80028a:	8b 12                	mov    (%edx),%edx
  80028c:	89 d1                	mov    %edx,%ecx
  80028e:	8b 55 0c             	mov    0xc(%ebp),%edx
  800291:	83 c2 08             	add    $0x8,%edx
  800294:	83 ec 04             	sub    $0x4,%esp
  800297:	50                   	push   %eax
  800298:	51                   	push   %ecx
  800299:	52                   	push   %edx
  80029a:	e8 2e 0f 00 00       	call   8011cd <sys_cputs>
  80029f:	83 c4 10             	add    $0x10,%esp
		b->idx = 0;
  8002a2:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	}
	b->cnt++;
  8002ab:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002ae:	8b 40 04             	mov    0x4(%eax),%eax
  8002b1:	8d 50 01             	lea    0x1(%eax),%edx
  8002b4:	8b 45 0c             	mov    0xc(%ebp),%eax
  8002b7:	89 50 04             	mov    %edx,0x4(%eax)
}
  8002ba:	90                   	nop
  8002bb:	c9                   	leave  
  8002bc:	c3                   	ret    

008002bd <vcprintf>:

int vcprintf(const char *fmt, va_list ap) {
  8002bd:	55                   	push   %ebp
  8002be:	89 e5                	mov    %esp,%ebp
  8002c0:	81 ec 18 01 00 00    	sub    $0x118,%esp
	struct printbuf b;

	b.idx = 0;
  8002c6:	c7 85 f0 fe ff ff 00 	movl   $0x0,-0x110(%ebp)
  8002cd:	00 00 00 
	b.cnt = 0;
  8002d0:	c7 85 f4 fe ff ff 00 	movl   $0x0,-0x10c(%ebp)
  8002d7:	00 00 00 
	vprintfmt((void*) putch, &b, fmt, ap);
  8002da:	ff 75 0c             	pushl  0xc(%ebp)
  8002dd:	ff 75 08             	pushl  0x8(%ebp)
  8002e0:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  8002e6:	50                   	push   %eax
  8002e7:	68 54 02 80 00       	push   $0x800254
  8002ec:	e8 11 02 00 00       	call   800502 <vprintfmt>
  8002f1:	83 c4 10             	add    $0x10,%esp
	sys_cputs(b.buf, b.idx, printProgName);
  8002f4:	a0 24 30 80 00       	mov    0x803024,%al
  8002f9:	0f b6 c0             	movzbl %al,%eax
  8002fc:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
  800302:	83 ec 04             	sub    $0x4,%esp
  800305:	50                   	push   %eax
  800306:	52                   	push   %edx
  800307:	8d 85 f0 fe ff ff    	lea    -0x110(%ebp),%eax
  80030d:	83 c0 08             	add    $0x8,%eax
  800310:	50                   	push   %eax
  800311:	e8 b7 0e 00 00       	call   8011cd <sys_cputs>
  800316:	83 c4 10             	add    $0x10,%esp

	printProgName = 0;
  800319:	c6 05 24 30 80 00 00 	movb   $0x0,0x803024
	return b.cnt;
  800320:	8b 85 f4 fe ff ff    	mov    -0x10c(%ebp),%eax
}
  800326:	c9                   	leave  
  800327:	c3                   	ret    

00800328 <cprintf>:

int cprintf(const char *fmt, ...) {
  800328:	55                   	push   %ebp
  800329:	89 e5                	mov    %esp,%ebp
  80032b:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int cnt;
	printProgName = 1 ;
  80032e:	c6 05 24 30 80 00 01 	movb   $0x1,0x803024
	va_start(ap, fmt);
  800335:	8d 45 0c             	lea    0xc(%ebp),%eax
  800338:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  80033b:	8b 45 08             	mov    0x8(%ebp),%eax
  80033e:	83 ec 08             	sub    $0x8,%esp
  800341:	ff 75 f4             	pushl  -0xc(%ebp)
  800344:	50                   	push   %eax
  800345:	e8 73 ff ff ff       	call   8002bd <vcprintf>
  80034a:	83 c4 10             	add    $0x10,%esp
  80034d:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return cnt;
  800350:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800353:	c9                   	leave  
  800354:	c3                   	ret    

00800355 <atomic_cprintf>:

int atomic_cprintf(const char *fmt, ...) {
  800355:	55                   	push   %ebp
  800356:	89 e5                	mov    %esp,%ebp
  800358:	83 ec 18             	sub    $0x18,%esp
	sys_disable_interrupt();
  80035b:	e8 7e 10 00 00       	call   8013de <sys_disable_interrupt>
	va_list ap;
	int cnt;

	va_start(ap, fmt);
  800360:	8d 45 0c             	lea    0xc(%ebp),%eax
  800363:	89 45 f4             	mov    %eax,-0xc(%ebp)
	cnt = vcprintf(fmt, ap);
  800366:	8b 45 08             	mov    0x8(%ebp),%eax
  800369:	83 ec 08             	sub    $0x8,%esp
  80036c:	ff 75 f4             	pushl  -0xc(%ebp)
  80036f:	50                   	push   %eax
  800370:	e8 48 ff ff ff       	call   8002bd <vcprintf>
  800375:	83 c4 10             	add    $0x10,%esp
  800378:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	sys_enable_interrupt();
  80037b:	e8 78 10 00 00       	call   8013f8 <sys_enable_interrupt>
	return cnt;
  800380:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  800383:	c9                   	leave  
  800384:	c3                   	ret    

00800385 <printnum>:
 * using specified putch function and associated pointer putdat.
 */
static void
printnum(void (*putch)(int, void*), void *putdat,
	 unsigned long long num, unsigned base, int width, int padc)
{
  800385:	55                   	push   %ebp
  800386:	89 e5                	mov    %esp,%ebp
  800388:	53                   	push   %ebx
  800389:	83 ec 14             	sub    $0x14,%esp
  80038c:	8b 45 10             	mov    0x10(%ebp),%eax
  80038f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800392:	8b 45 14             	mov    0x14(%ebp),%eax
  800395:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
  800398:	8b 45 18             	mov    0x18(%ebp),%eax
  80039b:	ba 00 00 00 00       	mov    $0x0,%edx
  8003a0:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003a3:	77 55                	ja     8003fa <printnum+0x75>
  8003a5:	3b 55 f4             	cmp    -0xc(%ebp),%edx
  8003a8:	72 05                	jb     8003af <printnum+0x2a>
  8003aa:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  8003ad:	77 4b                	ja     8003fa <printnum+0x75>
		printnum(putch, putdat, num / base, base, width - 1, padc);
  8003af:	8b 45 1c             	mov    0x1c(%ebp),%eax
  8003b2:	8d 58 ff             	lea    -0x1(%eax),%ebx
  8003b5:	8b 45 18             	mov    0x18(%ebp),%eax
  8003b8:	ba 00 00 00 00       	mov    $0x0,%edx
  8003bd:	52                   	push   %edx
  8003be:	50                   	push   %eax
  8003bf:	ff 75 f4             	pushl  -0xc(%ebp)
  8003c2:	ff 75 f0             	pushl  -0x10(%ebp)
  8003c5:	e8 32 16 00 00       	call   8019fc <__udivdi3>
  8003ca:	83 c4 10             	add    $0x10,%esp
  8003cd:	83 ec 04             	sub    $0x4,%esp
  8003d0:	ff 75 20             	pushl  0x20(%ebp)
  8003d3:	53                   	push   %ebx
  8003d4:	ff 75 18             	pushl  0x18(%ebp)
  8003d7:	52                   	push   %edx
  8003d8:	50                   	push   %eax
  8003d9:	ff 75 0c             	pushl  0xc(%ebp)
  8003dc:	ff 75 08             	pushl  0x8(%ebp)
  8003df:	e8 a1 ff ff ff       	call   800385 <printnum>
  8003e4:	83 c4 20             	add    $0x20,%esp
  8003e7:	eb 1a                	jmp    800403 <printnum+0x7e>
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
			putch(padc, putdat);
  8003e9:	83 ec 08             	sub    $0x8,%esp
  8003ec:	ff 75 0c             	pushl  0xc(%ebp)
  8003ef:	ff 75 20             	pushl  0x20(%ebp)
  8003f2:	8b 45 08             	mov    0x8(%ebp),%eax
  8003f5:	ff d0                	call   *%eax
  8003f7:	83 c4 10             	add    $0x10,%esp
	// first recursively print all preceding (more significant) digits
	if (num >= base) {
		printnum(putch, putdat, num / base, base, width - 1, padc);
	} else {
		// print any needed pad characters before first digit
		while (--width > 0)
  8003fa:	ff 4d 1c             	decl   0x1c(%ebp)
  8003fd:	83 7d 1c 00          	cmpl   $0x0,0x1c(%ebp)
  800401:	7f e6                	jg     8003e9 <printnum+0x64>
			putch(padc, putdat);
	}

	// then print this (the least significant) digit
	putch("0123456789abcdef"[num % base], putdat);
  800403:	8b 4d 18             	mov    0x18(%ebp),%ecx
  800406:	bb 00 00 00 00       	mov    $0x0,%ebx
  80040b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80040e:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800411:	53                   	push   %ebx
  800412:	51                   	push   %ecx
  800413:	52                   	push   %edx
  800414:	50                   	push   %eax
  800415:	e8 f2 16 00 00       	call   801b0c <__umoddi3>
  80041a:	83 c4 10             	add    $0x10,%esp
  80041d:	05 54 1f 80 00       	add    $0x801f54,%eax
  800422:	8a 00                	mov    (%eax),%al
  800424:	0f be c0             	movsbl %al,%eax
  800427:	83 ec 08             	sub    $0x8,%esp
  80042a:	ff 75 0c             	pushl  0xc(%ebp)
  80042d:	50                   	push   %eax
  80042e:	8b 45 08             	mov    0x8(%ebp),%eax
  800431:	ff d0                	call   *%eax
  800433:	83 c4 10             	add    $0x10,%esp
}
  800436:	90                   	nop
  800437:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  80043a:	c9                   	leave  
  80043b:	c3                   	ret    

0080043c <getuint>:

// Get an unsigned int of various possible sizes from a varargs list,
// depending on the lflag parameter.
static unsigned long long
getuint(va_list *ap, int lflag)
{
  80043c:	55                   	push   %ebp
  80043d:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  80043f:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  800443:	7e 1c                	jle    800461 <getuint+0x25>
		return va_arg(*ap, unsigned long long);
  800445:	8b 45 08             	mov    0x8(%ebp),%eax
  800448:	8b 00                	mov    (%eax),%eax
  80044a:	8d 50 08             	lea    0x8(%eax),%edx
  80044d:	8b 45 08             	mov    0x8(%ebp),%eax
  800450:	89 10                	mov    %edx,(%eax)
  800452:	8b 45 08             	mov    0x8(%ebp),%eax
  800455:	8b 00                	mov    (%eax),%eax
  800457:	83 e8 08             	sub    $0x8,%eax
  80045a:	8b 50 04             	mov    0x4(%eax),%edx
  80045d:	8b 00                	mov    (%eax),%eax
  80045f:	eb 40                	jmp    8004a1 <getuint+0x65>
	else if (lflag)
  800461:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800465:	74 1e                	je     800485 <getuint+0x49>
		return va_arg(*ap, unsigned long);
  800467:	8b 45 08             	mov    0x8(%ebp),%eax
  80046a:	8b 00                	mov    (%eax),%eax
  80046c:	8d 50 04             	lea    0x4(%eax),%edx
  80046f:	8b 45 08             	mov    0x8(%ebp),%eax
  800472:	89 10                	mov    %edx,(%eax)
  800474:	8b 45 08             	mov    0x8(%ebp),%eax
  800477:	8b 00                	mov    (%eax),%eax
  800479:	83 e8 04             	sub    $0x4,%eax
  80047c:	8b 00                	mov    (%eax),%eax
  80047e:	ba 00 00 00 00       	mov    $0x0,%edx
  800483:	eb 1c                	jmp    8004a1 <getuint+0x65>
	else
		return va_arg(*ap, unsigned int);
  800485:	8b 45 08             	mov    0x8(%ebp),%eax
  800488:	8b 00                	mov    (%eax),%eax
  80048a:	8d 50 04             	lea    0x4(%eax),%edx
  80048d:	8b 45 08             	mov    0x8(%ebp),%eax
  800490:	89 10                	mov    %edx,(%eax)
  800492:	8b 45 08             	mov    0x8(%ebp),%eax
  800495:	8b 00                	mov    (%eax),%eax
  800497:	83 e8 04             	sub    $0x4,%eax
  80049a:	8b 00                	mov    (%eax),%eax
  80049c:	ba 00 00 00 00       	mov    $0x0,%edx
}
  8004a1:	5d                   	pop    %ebp
  8004a2:	c3                   	ret    

008004a3 <getint>:

// Same as getuint but signed - can't use getuint
// because of sign extension
static long long
getint(va_list *ap, int lflag)
{
  8004a3:	55                   	push   %ebp
  8004a4:	89 e5                	mov    %esp,%ebp
	if (lflag >= 2)
  8004a6:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
  8004aa:	7e 1c                	jle    8004c8 <getint+0x25>
		return va_arg(*ap, long long);
  8004ac:	8b 45 08             	mov    0x8(%ebp),%eax
  8004af:	8b 00                	mov    (%eax),%eax
  8004b1:	8d 50 08             	lea    0x8(%eax),%edx
  8004b4:	8b 45 08             	mov    0x8(%ebp),%eax
  8004b7:	89 10                	mov    %edx,(%eax)
  8004b9:	8b 45 08             	mov    0x8(%ebp),%eax
  8004bc:	8b 00                	mov    (%eax),%eax
  8004be:	83 e8 08             	sub    $0x8,%eax
  8004c1:	8b 50 04             	mov    0x4(%eax),%edx
  8004c4:	8b 00                	mov    (%eax),%eax
  8004c6:	eb 38                	jmp    800500 <getint+0x5d>
	else if (lflag)
  8004c8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8004cc:	74 1a                	je     8004e8 <getint+0x45>
		return va_arg(*ap, long);
  8004ce:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d1:	8b 00                	mov    (%eax),%eax
  8004d3:	8d 50 04             	lea    0x4(%eax),%edx
  8004d6:	8b 45 08             	mov    0x8(%ebp),%eax
  8004d9:	89 10                	mov    %edx,(%eax)
  8004db:	8b 45 08             	mov    0x8(%ebp),%eax
  8004de:	8b 00                	mov    (%eax),%eax
  8004e0:	83 e8 04             	sub    $0x4,%eax
  8004e3:	8b 00                	mov    (%eax),%eax
  8004e5:	99                   	cltd   
  8004e6:	eb 18                	jmp    800500 <getint+0x5d>
	else
		return va_arg(*ap, int);
  8004e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8004eb:	8b 00                	mov    (%eax),%eax
  8004ed:	8d 50 04             	lea    0x4(%eax),%edx
  8004f0:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f3:	89 10                	mov    %edx,(%eax)
  8004f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8004f8:	8b 00                	mov    (%eax),%eax
  8004fa:	83 e8 04             	sub    $0x4,%eax
  8004fd:	8b 00                	mov    (%eax),%eax
  8004ff:	99                   	cltd   
}
  800500:	5d                   	pop    %ebp
  800501:	c3                   	ret    

00800502 <vprintfmt>:
// Main function to format and print a string.
void printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...);

void
vprintfmt(void (*putch)(int, void*), void *putdat, const char *fmt, va_list ap)
{
  800502:	55                   	push   %ebp
  800503:	89 e5                	mov    %esp,%ebp
  800505:	56                   	push   %esi
  800506:	53                   	push   %ebx
  800507:	83 ec 20             	sub    $0x20,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  80050a:	eb 17                	jmp    800523 <vprintfmt+0x21>
			if (ch == '\0')
  80050c:	85 db                	test   %ebx,%ebx
  80050e:	0f 84 af 03 00 00    	je     8008c3 <vprintfmt+0x3c1>
				return;
			putch(ch, putdat);
  800514:	83 ec 08             	sub    $0x8,%esp
  800517:	ff 75 0c             	pushl  0xc(%ebp)
  80051a:	53                   	push   %ebx
  80051b:	8b 45 08             	mov    0x8(%ebp),%eax
  80051e:	ff d0                	call   *%eax
  800520:	83 c4 10             	add    $0x10,%esp
	unsigned long long num;
	int base, lflag, width, precision, altflag;
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
  800523:	8b 45 10             	mov    0x10(%ebp),%eax
  800526:	8d 50 01             	lea    0x1(%eax),%edx
  800529:	89 55 10             	mov    %edx,0x10(%ebp)
  80052c:	8a 00                	mov    (%eax),%al
  80052e:	0f b6 d8             	movzbl %al,%ebx
  800531:	83 fb 25             	cmp    $0x25,%ebx
  800534:	75 d6                	jne    80050c <vprintfmt+0xa>
				return;
			putch(ch, putdat);
		}

		// Process a %-escape sequence
		padc = ' ';
  800536:	c6 45 db 20          	movb   $0x20,-0x25(%ebp)
		width = -1;
  80053a:	c7 45 e4 ff ff ff ff 	movl   $0xffffffff,-0x1c(%ebp)
		precision = -1;
  800541:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
		lflag = 0;
  800548:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
		altflag = 0;
  80054f:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
	reswitch:
		switch (ch = *(unsigned char *) fmt++) {
  800556:	8b 45 10             	mov    0x10(%ebp),%eax
  800559:	8d 50 01             	lea    0x1(%eax),%edx
  80055c:	89 55 10             	mov    %edx,0x10(%ebp)
  80055f:	8a 00                	mov    (%eax),%al
  800561:	0f b6 d8             	movzbl %al,%ebx
  800564:	8d 43 dd             	lea    -0x23(%ebx),%eax
  800567:	83 f8 55             	cmp    $0x55,%eax
  80056a:	0f 87 2b 03 00 00    	ja     80089b <vprintfmt+0x399>
  800570:	8b 04 85 78 1f 80 00 	mov    0x801f78(,%eax,4),%eax
  800577:	ff e0                	jmp    *%eax

		// flag to pad on the right
		case '-':
			padc = '-';
  800579:	c6 45 db 2d          	movb   $0x2d,-0x25(%ebp)
			goto reswitch;
  80057d:	eb d7                	jmp    800556 <vprintfmt+0x54>

		// flag to pad with 0's instead of spaces
		case '0':
			padc = '0';
  80057f:	c6 45 db 30          	movb   $0x30,-0x25(%ebp)
			goto reswitch;
  800583:	eb d1                	jmp    800556 <vprintfmt+0x54>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  800585:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
				precision = precision * 10 + ch - '0';
  80058c:	8b 55 e0             	mov    -0x20(%ebp),%edx
  80058f:	89 d0                	mov    %edx,%eax
  800591:	c1 e0 02             	shl    $0x2,%eax
  800594:	01 d0                	add    %edx,%eax
  800596:	01 c0                	add    %eax,%eax
  800598:	01 d8                	add    %ebx,%eax
  80059a:	83 e8 30             	sub    $0x30,%eax
  80059d:	89 45 e0             	mov    %eax,-0x20(%ebp)
				ch = *fmt;
  8005a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8005a3:	8a 00                	mov    (%eax),%al
  8005a5:	0f be d8             	movsbl %al,%ebx
				if (ch < '0' || ch > '9')
  8005a8:	83 fb 2f             	cmp    $0x2f,%ebx
  8005ab:	7e 3e                	jle    8005eb <vprintfmt+0xe9>
  8005ad:	83 fb 39             	cmp    $0x39,%ebx
  8005b0:	7f 39                	jg     8005eb <vprintfmt+0xe9>
		case '5':
		case '6':
		case '7':
		case '8':
		case '9':
			for (precision = 0; ; ++fmt) {
  8005b2:	ff 45 10             	incl   0x10(%ebp)
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
  8005b5:	eb d5                	jmp    80058c <vprintfmt+0x8a>
			goto process_precision;

		case '*':
			precision = va_arg(ap, int);
  8005b7:	8b 45 14             	mov    0x14(%ebp),%eax
  8005ba:	83 c0 04             	add    $0x4,%eax
  8005bd:	89 45 14             	mov    %eax,0x14(%ebp)
  8005c0:	8b 45 14             	mov    0x14(%ebp),%eax
  8005c3:	83 e8 04             	sub    $0x4,%eax
  8005c6:	8b 00                	mov    (%eax),%eax
  8005c8:	89 45 e0             	mov    %eax,-0x20(%ebp)
			goto process_precision;
  8005cb:	eb 1f                	jmp    8005ec <vprintfmt+0xea>

		case '.':
			if (width < 0)
  8005cd:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005d1:	79 83                	jns    800556 <vprintfmt+0x54>
				width = 0;
  8005d3:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
			goto reswitch;
  8005da:	e9 77 ff ff ff       	jmp    800556 <vprintfmt+0x54>

		case '#':
			altflag = 1;
  8005df:	c7 45 dc 01 00 00 00 	movl   $0x1,-0x24(%ebp)
			goto reswitch;
  8005e6:	e9 6b ff ff ff       	jmp    800556 <vprintfmt+0x54>
				precision = precision * 10 + ch - '0';
				ch = *fmt;
				if (ch < '0' || ch > '9')
					break;
			}
			goto process_precision;
  8005eb:	90                   	nop
		case '#':
			altflag = 1;
			goto reswitch;

		process_precision:
			if (width < 0)
  8005ec:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8005f0:	0f 89 60 ff ff ff    	jns    800556 <vprintfmt+0x54>
				width = precision, precision = -1;
  8005f6:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8005f9:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8005fc:	c7 45 e0 ff ff ff ff 	movl   $0xffffffff,-0x20(%ebp)
			goto reswitch;
  800603:	e9 4e ff ff ff       	jmp    800556 <vprintfmt+0x54>

		// long flag (doubled for long long)
		case 'l':
			lflag++;
  800608:	ff 45 e8             	incl   -0x18(%ebp)
			goto reswitch;
  80060b:	e9 46 ff ff ff       	jmp    800556 <vprintfmt+0x54>

		// character
		case 'c':
			putch(va_arg(ap, int), putdat);
  800610:	8b 45 14             	mov    0x14(%ebp),%eax
  800613:	83 c0 04             	add    $0x4,%eax
  800616:	89 45 14             	mov    %eax,0x14(%ebp)
  800619:	8b 45 14             	mov    0x14(%ebp),%eax
  80061c:	83 e8 04             	sub    $0x4,%eax
  80061f:	8b 00                	mov    (%eax),%eax
  800621:	83 ec 08             	sub    $0x8,%esp
  800624:	ff 75 0c             	pushl  0xc(%ebp)
  800627:	50                   	push   %eax
  800628:	8b 45 08             	mov    0x8(%ebp),%eax
  80062b:	ff d0                	call   *%eax
  80062d:	83 c4 10             	add    $0x10,%esp
			break;
  800630:	e9 89 02 00 00       	jmp    8008be <vprintfmt+0x3bc>

		// error message
		case 'e':
			err = va_arg(ap, int);
  800635:	8b 45 14             	mov    0x14(%ebp),%eax
  800638:	83 c0 04             	add    $0x4,%eax
  80063b:	89 45 14             	mov    %eax,0x14(%ebp)
  80063e:	8b 45 14             	mov    0x14(%ebp),%eax
  800641:	83 e8 04             	sub    $0x4,%eax
  800644:	8b 18                	mov    (%eax),%ebx
			if (err < 0)
  800646:	85 db                	test   %ebx,%ebx
  800648:	79 02                	jns    80064c <vprintfmt+0x14a>
				err = -err;
  80064a:	f7 db                	neg    %ebx
			if (err > MAXERROR || (p = error_string[err]) == NULL)
  80064c:	83 fb 64             	cmp    $0x64,%ebx
  80064f:	7f 0b                	jg     80065c <vprintfmt+0x15a>
  800651:	8b 34 9d c0 1d 80 00 	mov    0x801dc0(,%ebx,4),%esi
  800658:	85 f6                	test   %esi,%esi
  80065a:	75 19                	jne    800675 <vprintfmt+0x173>
				printfmt(putch, putdat, "error %d", err);
  80065c:	53                   	push   %ebx
  80065d:	68 65 1f 80 00       	push   $0x801f65
  800662:	ff 75 0c             	pushl  0xc(%ebp)
  800665:	ff 75 08             	pushl  0x8(%ebp)
  800668:	e8 5e 02 00 00       	call   8008cb <printfmt>
  80066d:	83 c4 10             	add    $0x10,%esp
			else
				printfmt(putch, putdat, "%s", p);
			break;
  800670:	e9 49 02 00 00       	jmp    8008be <vprintfmt+0x3bc>
			if (err < 0)
				err = -err;
			if (err > MAXERROR || (p = error_string[err]) == NULL)
				printfmt(putch, putdat, "error %d", err);
			else
				printfmt(putch, putdat, "%s", p);
  800675:	56                   	push   %esi
  800676:	68 6e 1f 80 00       	push   $0x801f6e
  80067b:	ff 75 0c             	pushl  0xc(%ebp)
  80067e:	ff 75 08             	pushl  0x8(%ebp)
  800681:	e8 45 02 00 00       	call   8008cb <printfmt>
  800686:	83 c4 10             	add    $0x10,%esp
			break;
  800689:	e9 30 02 00 00       	jmp    8008be <vprintfmt+0x3bc>

		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
  80068e:	8b 45 14             	mov    0x14(%ebp),%eax
  800691:	83 c0 04             	add    $0x4,%eax
  800694:	89 45 14             	mov    %eax,0x14(%ebp)
  800697:	8b 45 14             	mov    0x14(%ebp),%eax
  80069a:	83 e8 04             	sub    $0x4,%eax
  80069d:	8b 30                	mov    (%eax),%esi
  80069f:	85 f6                	test   %esi,%esi
  8006a1:	75 05                	jne    8006a8 <vprintfmt+0x1a6>
				p = "(null)";
  8006a3:	be 71 1f 80 00       	mov    $0x801f71,%esi
			if (width > 0 && padc != '-')
  8006a8:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006ac:	7e 6d                	jle    80071b <vprintfmt+0x219>
  8006ae:	80 7d db 2d          	cmpb   $0x2d,-0x25(%ebp)
  8006b2:	74 67                	je     80071b <vprintfmt+0x219>
				for (width -= strnlen(p, precision); width > 0; width--)
  8006b4:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8006b7:	83 ec 08             	sub    $0x8,%esp
  8006ba:	50                   	push   %eax
  8006bb:	56                   	push   %esi
  8006bc:	e8 0c 03 00 00       	call   8009cd <strnlen>
  8006c1:	83 c4 10             	add    $0x10,%esp
  8006c4:	29 45 e4             	sub    %eax,-0x1c(%ebp)
  8006c7:	eb 16                	jmp    8006df <vprintfmt+0x1dd>
					putch(padc, putdat);
  8006c9:	0f be 45 db          	movsbl -0x25(%ebp),%eax
  8006cd:	83 ec 08             	sub    $0x8,%esp
  8006d0:	ff 75 0c             	pushl  0xc(%ebp)
  8006d3:	50                   	push   %eax
  8006d4:	8b 45 08             	mov    0x8(%ebp),%eax
  8006d7:	ff d0                	call   *%eax
  8006d9:	83 c4 10             	add    $0x10,%esp
		// string
		case 's':
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
  8006dc:	ff 4d e4             	decl   -0x1c(%ebp)
  8006df:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  8006e3:	7f e4                	jg     8006c9 <vprintfmt+0x1c7>
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  8006e5:	eb 34                	jmp    80071b <vprintfmt+0x219>
				if (altflag && (ch < ' ' || ch > '~'))
  8006e7:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
  8006eb:	74 1c                	je     800709 <vprintfmt+0x207>
  8006ed:	83 fb 1f             	cmp    $0x1f,%ebx
  8006f0:	7e 05                	jle    8006f7 <vprintfmt+0x1f5>
  8006f2:	83 fb 7e             	cmp    $0x7e,%ebx
  8006f5:	7e 12                	jle    800709 <vprintfmt+0x207>
					putch('?', putdat);
  8006f7:	83 ec 08             	sub    $0x8,%esp
  8006fa:	ff 75 0c             	pushl  0xc(%ebp)
  8006fd:	6a 3f                	push   $0x3f
  8006ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800702:	ff d0                	call   *%eax
  800704:	83 c4 10             	add    $0x10,%esp
  800707:	eb 0f                	jmp    800718 <vprintfmt+0x216>
				else
					putch(ch, putdat);
  800709:	83 ec 08             	sub    $0x8,%esp
  80070c:	ff 75 0c             	pushl  0xc(%ebp)
  80070f:	53                   	push   %ebx
  800710:	8b 45 08             	mov    0x8(%ebp),%eax
  800713:	ff d0                	call   *%eax
  800715:	83 c4 10             	add    $0x10,%esp
			if ((p = va_arg(ap, char *)) == NULL)
				p = "(null)";
			if (width > 0 && padc != '-')
				for (width -= strnlen(p, precision); width > 0; width--)
					putch(padc, putdat);
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
  800718:	ff 4d e4             	decl   -0x1c(%ebp)
  80071b:	89 f0                	mov    %esi,%eax
  80071d:	8d 70 01             	lea    0x1(%eax),%esi
  800720:	8a 00                	mov    (%eax),%al
  800722:	0f be d8             	movsbl %al,%ebx
  800725:	85 db                	test   %ebx,%ebx
  800727:	74 24                	je     80074d <vprintfmt+0x24b>
  800729:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  80072d:	78 b8                	js     8006e7 <vprintfmt+0x1e5>
  80072f:	ff 4d e0             	decl   -0x20(%ebp)
  800732:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  800736:	79 af                	jns    8006e7 <vprintfmt+0x1e5>
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  800738:	eb 13                	jmp    80074d <vprintfmt+0x24b>
				putch(' ', putdat);
  80073a:	83 ec 08             	sub    $0x8,%esp
  80073d:	ff 75 0c             	pushl  0xc(%ebp)
  800740:	6a 20                	push   $0x20
  800742:	8b 45 08             	mov    0x8(%ebp),%eax
  800745:	ff d0                	call   *%eax
  800747:	83 c4 10             	add    $0x10,%esp
			for (; (ch = *p++) != '\0' && (precision < 0 || --precision >= 0); width--)
				if (altflag && (ch < ' ' || ch > '~'))
					putch('?', putdat);
				else
					putch(ch, putdat);
			for (; width > 0; width--)
  80074a:	ff 4d e4             	decl   -0x1c(%ebp)
  80074d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  800751:	7f e7                	jg     80073a <vprintfmt+0x238>
				putch(' ', putdat);
			break;
  800753:	e9 66 01 00 00       	jmp    8008be <vprintfmt+0x3bc>

		// (signed) decimal
		case 'd':
			num = getint(&ap, lflag);
  800758:	83 ec 08             	sub    $0x8,%esp
  80075b:	ff 75 e8             	pushl  -0x18(%ebp)
  80075e:	8d 45 14             	lea    0x14(%ebp),%eax
  800761:	50                   	push   %eax
  800762:	e8 3c fd ff ff       	call   8004a3 <getint>
  800767:	83 c4 10             	add    $0x10,%esp
  80076a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80076d:	89 55 f4             	mov    %edx,-0xc(%ebp)
			if ((long long) num < 0) {
  800770:	8b 45 f0             	mov    -0x10(%ebp),%eax
  800773:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800776:	85 d2                	test   %edx,%edx
  800778:	79 23                	jns    80079d <vprintfmt+0x29b>
				putch('-', putdat);
  80077a:	83 ec 08             	sub    $0x8,%esp
  80077d:	ff 75 0c             	pushl  0xc(%ebp)
  800780:	6a 2d                	push   $0x2d
  800782:	8b 45 08             	mov    0x8(%ebp),%eax
  800785:	ff d0                	call   *%eax
  800787:	83 c4 10             	add    $0x10,%esp
				num = -(long long) num;
  80078a:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80078d:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800790:	f7 d8                	neg    %eax
  800792:	83 d2 00             	adc    $0x0,%edx
  800795:	f7 da                	neg    %edx
  800797:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80079a:	89 55 f4             	mov    %edx,-0xc(%ebp)
			}
			base = 10;
  80079d:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007a4:	e9 bc 00 00 00       	jmp    800865 <vprintfmt+0x363>

		// unsigned decimal
		case 'u':
			num = getuint(&ap, lflag);
  8007a9:	83 ec 08             	sub    $0x8,%esp
  8007ac:	ff 75 e8             	pushl  -0x18(%ebp)
  8007af:	8d 45 14             	lea    0x14(%ebp),%eax
  8007b2:	50                   	push   %eax
  8007b3:	e8 84 fc ff ff       	call   80043c <getuint>
  8007b8:	83 c4 10             	add    $0x10,%esp
  8007bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
  8007be:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 10;
  8007c1:	c7 45 ec 0a 00 00 00 	movl   $0xa,-0x14(%ebp)
			goto number;
  8007c8:	e9 98 00 00 00       	jmp    800865 <vprintfmt+0x363>

		// (unsigned) octal
		case 'o':
			// Replace this with your code.
			putch('X', putdat);
  8007cd:	83 ec 08             	sub    $0x8,%esp
  8007d0:	ff 75 0c             	pushl  0xc(%ebp)
  8007d3:	6a 58                	push   $0x58
  8007d5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007d8:	ff d0                	call   *%eax
  8007da:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007dd:	83 ec 08             	sub    $0x8,%esp
  8007e0:	ff 75 0c             	pushl  0xc(%ebp)
  8007e3:	6a 58                	push   $0x58
  8007e5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007e8:	ff d0                	call   *%eax
  8007ea:	83 c4 10             	add    $0x10,%esp
			putch('X', putdat);
  8007ed:	83 ec 08             	sub    $0x8,%esp
  8007f0:	ff 75 0c             	pushl  0xc(%ebp)
  8007f3:	6a 58                	push   $0x58
  8007f5:	8b 45 08             	mov    0x8(%ebp),%eax
  8007f8:	ff d0                	call   *%eax
  8007fa:	83 c4 10             	add    $0x10,%esp
			break;
  8007fd:	e9 bc 00 00 00       	jmp    8008be <vprintfmt+0x3bc>

		// pointer
		case 'p':
			putch('0', putdat);
  800802:	83 ec 08             	sub    $0x8,%esp
  800805:	ff 75 0c             	pushl  0xc(%ebp)
  800808:	6a 30                	push   $0x30
  80080a:	8b 45 08             	mov    0x8(%ebp),%eax
  80080d:	ff d0                	call   *%eax
  80080f:	83 c4 10             	add    $0x10,%esp
			putch('x', putdat);
  800812:	83 ec 08             	sub    $0x8,%esp
  800815:	ff 75 0c             	pushl  0xc(%ebp)
  800818:	6a 78                	push   $0x78
  80081a:	8b 45 08             	mov    0x8(%ebp),%eax
  80081d:	ff d0                	call   *%eax
  80081f:	83 c4 10             	add    $0x10,%esp
			num = (unsigned long long)
				(uint32) va_arg(ap, void *);
  800822:	8b 45 14             	mov    0x14(%ebp),%eax
  800825:	83 c0 04             	add    $0x4,%eax
  800828:	89 45 14             	mov    %eax,0x14(%ebp)
  80082b:	8b 45 14             	mov    0x14(%ebp),%eax
  80082e:	83 e8 04             	sub    $0x4,%eax
  800831:	8b 00                	mov    (%eax),%eax

		// pointer
		case 'p':
			putch('0', putdat);
			putch('x', putdat);
			num = (unsigned long long)
  800833:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800836:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
				(uint32) va_arg(ap, void *);
			base = 16;
  80083d:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
			goto number;
  800844:	eb 1f                	jmp    800865 <vprintfmt+0x363>

		// (unsigned) hexadecimal
		case 'x':
			num = getuint(&ap, lflag);
  800846:	83 ec 08             	sub    $0x8,%esp
  800849:	ff 75 e8             	pushl  -0x18(%ebp)
  80084c:	8d 45 14             	lea    0x14(%ebp),%eax
  80084f:	50                   	push   %eax
  800850:	e8 e7 fb ff ff       	call   80043c <getuint>
  800855:	83 c4 10             	add    $0x10,%esp
  800858:	89 45 f0             	mov    %eax,-0x10(%ebp)
  80085b:	89 55 f4             	mov    %edx,-0xc(%ebp)
			base = 16;
  80085e:	c7 45 ec 10 00 00 00 	movl   $0x10,-0x14(%ebp)
		number:
			printnum(putch, putdat, num, base, width, padc);
  800865:	0f be 55 db          	movsbl -0x25(%ebp),%edx
  800869:	8b 45 ec             	mov    -0x14(%ebp),%eax
  80086c:	83 ec 04             	sub    $0x4,%esp
  80086f:	52                   	push   %edx
  800870:	ff 75 e4             	pushl  -0x1c(%ebp)
  800873:	50                   	push   %eax
  800874:	ff 75 f4             	pushl  -0xc(%ebp)
  800877:	ff 75 f0             	pushl  -0x10(%ebp)
  80087a:	ff 75 0c             	pushl  0xc(%ebp)
  80087d:	ff 75 08             	pushl  0x8(%ebp)
  800880:	e8 00 fb ff ff       	call   800385 <printnum>
  800885:	83 c4 20             	add    $0x20,%esp
			break;
  800888:	eb 34                	jmp    8008be <vprintfmt+0x3bc>

		// escaped '%' character
		case '%':
			putch(ch, putdat);
  80088a:	83 ec 08             	sub    $0x8,%esp
  80088d:	ff 75 0c             	pushl  0xc(%ebp)
  800890:	53                   	push   %ebx
  800891:	8b 45 08             	mov    0x8(%ebp),%eax
  800894:	ff d0                	call   *%eax
  800896:	83 c4 10             	add    $0x10,%esp
			break;
  800899:	eb 23                	jmp    8008be <vprintfmt+0x3bc>

		// unrecognized escape sequence - just print it literally
		default:
			putch('%', putdat);
  80089b:	83 ec 08             	sub    $0x8,%esp
  80089e:	ff 75 0c             	pushl  0xc(%ebp)
  8008a1:	6a 25                	push   $0x25
  8008a3:	8b 45 08             	mov    0x8(%ebp),%eax
  8008a6:	ff d0                	call   *%eax
  8008a8:	83 c4 10             	add    $0x10,%esp
			for (fmt--; fmt[-1] != '%'; fmt--)
  8008ab:	ff 4d 10             	decl   0x10(%ebp)
  8008ae:	eb 03                	jmp    8008b3 <vprintfmt+0x3b1>
  8008b0:	ff 4d 10             	decl   0x10(%ebp)
  8008b3:	8b 45 10             	mov    0x10(%ebp),%eax
  8008b6:	48                   	dec    %eax
  8008b7:	8a 00                	mov    (%eax),%al
  8008b9:	3c 25                	cmp    $0x25,%al
  8008bb:	75 f3                	jne    8008b0 <vprintfmt+0x3ae>
				/* do nothing */;
			break;
  8008bd:	90                   	nop
		}
	}
  8008be:	e9 47 fc ff ff       	jmp    80050a <vprintfmt+0x8>
	char padc;

	while (1) {
		while ((ch = *(unsigned char *) fmt++) != '%') {
			if (ch == '\0')
				return;
  8008c3:	90                   	nop
			for (fmt--; fmt[-1] != '%'; fmt--)
				/* do nothing */;
			break;
		}
	}
}
  8008c4:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8008c7:	5b                   	pop    %ebx
  8008c8:	5e                   	pop    %esi
  8008c9:	5d                   	pop    %ebp
  8008ca:	c3                   	ret    

008008cb <printfmt>:

void
printfmt(void (*putch)(int, void*), void *putdat, const char *fmt, ...)
{
  8008cb:	55                   	push   %ebp
  8008cc:	89 e5                	mov    %esp,%ebp
  8008ce:	83 ec 18             	sub    $0x18,%esp
	va_list ap;

	va_start(ap, fmt);
  8008d1:	8d 45 10             	lea    0x10(%ebp),%eax
  8008d4:	83 c0 04             	add    $0x4,%eax
  8008d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
	vprintfmt(putch, putdat, fmt, ap);
  8008da:	8b 45 10             	mov    0x10(%ebp),%eax
  8008dd:	ff 75 f4             	pushl  -0xc(%ebp)
  8008e0:	50                   	push   %eax
  8008e1:	ff 75 0c             	pushl  0xc(%ebp)
  8008e4:	ff 75 08             	pushl  0x8(%ebp)
  8008e7:	e8 16 fc ff ff       	call   800502 <vprintfmt>
  8008ec:	83 c4 10             	add    $0x10,%esp
	va_end(ap);
}
  8008ef:	90                   	nop
  8008f0:	c9                   	leave  
  8008f1:	c3                   	ret    

008008f2 <sprintputch>:
	int cnt;
};

static void
sprintputch(int ch, struct sprintbuf *b)
{
  8008f2:	55                   	push   %ebp
  8008f3:	89 e5                	mov    %esp,%ebp
	b->cnt++;
  8008f5:	8b 45 0c             	mov    0xc(%ebp),%eax
  8008f8:	8b 40 08             	mov    0x8(%eax),%eax
  8008fb:	8d 50 01             	lea    0x1(%eax),%edx
  8008fe:	8b 45 0c             	mov    0xc(%ebp),%eax
  800901:	89 50 08             	mov    %edx,0x8(%eax)
	if (b->buf < b->ebuf)
  800904:	8b 45 0c             	mov    0xc(%ebp),%eax
  800907:	8b 10                	mov    (%eax),%edx
  800909:	8b 45 0c             	mov    0xc(%ebp),%eax
  80090c:	8b 40 04             	mov    0x4(%eax),%eax
  80090f:	39 c2                	cmp    %eax,%edx
  800911:	73 12                	jae    800925 <sprintputch+0x33>
		*b->buf++ = ch;
  800913:	8b 45 0c             	mov    0xc(%ebp),%eax
  800916:	8b 00                	mov    (%eax),%eax
  800918:	8d 48 01             	lea    0x1(%eax),%ecx
  80091b:	8b 55 0c             	mov    0xc(%ebp),%edx
  80091e:	89 0a                	mov    %ecx,(%edx)
  800920:	8b 55 08             	mov    0x8(%ebp),%edx
  800923:	88 10                	mov    %dl,(%eax)
}
  800925:	90                   	nop
  800926:	5d                   	pop    %ebp
  800927:	c3                   	ret    

00800928 <vsnprintf>:

int
vsnprintf(char *buf, int n, const char *fmt, va_list ap)
{
  800928:	55                   	push   %ebp
  800929:	89 e5                	mov    %esp,%ebp
  80092b:	83 ec 18             	sub    $0x18,%esp
	struct sprintbuf b = {buf, buf+n-1, 0};
  80092e:	8b 45 08             	mov    0x8(%ebp),%eax
  800931:	89 45 ec             	mov    %eax,-0x14(%ebp)
  800934:	8b 45 0c             	mov    0xc(%ebp),%eax
  800937:	8d 50 ff             	lea    -0x1(%eax),%edx
  80093a:	8b 45 08             	mov    0x8(%ebp),%eax
  80093d:	01 d0                	add    %edx,%eax
  80093f:	89 45 f0             	mov    %eax,-0x10(%ebp)
  800942:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

	if (buf == NULL || n < 1)
  800949:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  80094d:	74 06                	je     800955 <vsnprintf+0x2d>
  80094f:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800953:	7f 07                	jg     80095c <vsnprintf+0x34>
		return -E_INVAL;
  800955:	b8 03 00 00 00       	mov    $0x3,%eax
  80095a:	eb 20                	jmp    80097c <vsnprintf+0x54>

	// print the string to the buffer
	vprintfmt((void*)sprintputch, &b, fmt, ap);
  80095c:	ff 75 14             	pushl  0x14(%ebp)
  80095f:	ff 75 10             	pushl  0x10(%ebp)
  800962:	8d 45 ec             	lea    -0x14(%ebp),%eax
  800965:	50                   	push   %eax
  800966:	68 f2 08 80 00       	push   $0x8008f2
  80096b:	e8 92 fb ff ff       	call   800502 <vprintfmt>
  800970:	83 c4 10             	add    $0x10,%esp

	// null terminate the buffer
	*b.buf = '\0';
  800973:	8b 45 ec             	mov    -0x14(%ebp),%eax
  800976:	c6 00 00             	movb   $0x0,(%eax)

	return b.cnt;
  800979:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
  80097c:	c9                   	leave  
  80097d:	c3                   	ret    

0080097e <snprintf>:

int
snprintf(char *buf, int n, const char *fmt, ...)
{
  80097e:	55                   	push   %ebp
  80097f:	89 e5                	mov    %esp,%ebp
  800981:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	int rc;

	va_start(ap, fmt);
  800984:	8d 45 10             	lea    0x10(%ebp),%eax
  800987:	83 c0 04             	add    $0x4,%eax
  80098a:	89 45 f4             	mov    %eax,-0xc(%ebp)
	rc = vsnprintf(buf, n, fmt, ap);
  80098d:	8b 45 10             	mov    0x10(%ebp),%eax
  800990:	ff 75 f4             	pushl  -0xc(%ebp)
  800993:	50                   	push   %eax
  800994:	ff 75 0c             	pushl  0xc(%ebp)
  800997:	ff 75 08             	pushl  0x8(%ebp)
  80099a:	e8 89 ff ff ff       	call   800928 <vsnprintf>
  80099f:	83 c4 10             	add    $0x10,%esp
  8009a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
	va_end(ap);

	return rc;
  8009a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8009a8:	c9                   	leave  
  8009a9:	c3                   	ret    

008009aa <strlen>:

#include <inc/string.h>

int
strlen(const char *s)
{
  8009aa:	55                   	push   %ebp
  8009ab:	89 e5                	mov    %esp,%ebp
  8009ad:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; *s != '\0'; s++)
  8009b0:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009b7:	eb 06                	jmp    8009bf <strlen+0x15>
		n++;
  8009b9:	ff 45 fc             	incl   -0x4(%ebp)
int
strlen(const char *s)
{
	int n;

	for (n = 0; *s != '\0'; s++)
  8009bc:	ff 45 08             	incl   0x8(%ebp)
  8009bf:	8b 45 08             	mov    0x8(%ebp),%eax
  8009c2:	8a 00                	mov    (%eax),%al
  8009c4:	84 c0                	test   %al,%al
  8009c6:	75 f1                	jne    8009b9 <strlen+0xf>
		n++;
	return n;
  8009c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009cb:	c9                   	leave  
  8009cc:	c3                   	ret    

008009cd <strnlen>:

int
strnlen(const char *s, uint32 size)
{
  8009cd:	55                   	push   %ebp
  8009ce:	89 e5                	mov    %esp,%ebp
  8009d0:	83 ec 10             	sub    $0x10,%esp
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  8009da:	eb 09                	jmp    8009e5 <strnlen+0x18>
		n++;
  8009dc:	ff 45 fc             	incl   -0x4(%ebp)
int
strnlen(const char *s, uint32 size)
{
	int n;

	for (n = 0; size > 0 && *s != '\0'; s++, size--)
  8009df:	ff 45 08             	incl   0x8(%ebp)
  8009e2:	ff 4d 0c             	decl   0xc(%ebp)
  8009e5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  8009e9:	74 09                	je     8009f4 <strnlen+0x27>
  8009eb:	8b 45 08             	mov    0x8(%ebp),%eax
  8009ee:	8a 00                	mov    (%eax),%al
  8009f0:	84 c0                	test   %al,%al
  8009f2:	75 e8                	jne    8009dc <strnlen+0xf>
		n++;
	return n;
  8009f4:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8009f7:	c9                   	leave  
  8009f8:	c3                   	ret    

008009f9 <strcpy>:

char *
strcpy(char *dst, const char *src)
{
  8009f9:	55                   	push   %ebp
  8009fa:	89 e5                	mov    %esp,%ebp
  8009fc:	83 ec 10             	sub    $0x10,%esp
	char *ret;

	ret = dst;
  8009ff:	8b 45 08             	mov    0x8(%ebp),%eax
  800a02:	89 45 fc             	mov    %eax,-0x4(%ebp)
	while ((*dst++ = *src++) != '\0')
  800a05:	90                   	nop
  800a06:	8b 45 08             	mov    0x8(%ebp),%eax
  800a09:	8d 50 01             	lea    0x1(%eax),%edx
  800a0c:	89 55 08             	mov    %edx,0x8(%ebp)
  800a0f:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a12:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a15:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a18:	8a 12                	mov    (%edx),%dl
  800a1a:	88 10                	mov    %dl,(%eax)
  800a1c:	8a 00                	mov    (%eax),%al
  800a1e:	84 c0                	test   %al,%al
  800a20:	75 e4                	jne    800a06 <strcpy+0xd>
		/* do nothing */;
	return ret;
  800a22:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  800a25:	c9                   	leave  
  800a26:	c3                   	ret    

00800a27 <strncpy>:

char *
strncpy(char *dst, const char *src, uint32 size) {
  800a27:	55                   	push   %ebp
  800a28:	89 e5                	mov    %esp,%ebp
  800a2a:	83 ec 10             	sub    $0x10,%esp
	uint32 i;
	char *ret;

	ret = dst;
  800a2d:	8b 45 08             	mov    0x8(%ebp),%eax
  800a30:	89 45 f8             	mov    %eax,-0x8(%ebp)
	for (i = 0; i < size; i++) {
  800a33:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800a3a:	eb 1f                	jmp    800a5b <strncpy+0x34>
		*dst++ = *src;
  800a3c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a3f:	8d 50 01             	lea    0x1(%eax),%edx
  800a42:	89 55 08             	mov    %edx,0x8(%ebp)
  800a45:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a48:	8a 12                	mov    (%edx),%dl
  800a4a:	88 10                	mov    %dl,(%eax)
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
  800a4c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a4f:	8a 00                	mov    (%eax),%al
  800a51:	84 c0                	test   %al,%al
  800a53:	74 03                	je     800a58 <strncpy+0x31>
			src++;
  800a55:	ff 45 0c             	incl   0xc(%ebp)
strncpy(char *dst, const char *src, uint32 size) {
	uint32 i;
	char *ret;

	ret = dst;
	for (i = 0; i < size; i++) {
  800a58:	ff 45 fc             	incl   -0x4(%ebp)
  800a5b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800a5e:	3b 45 10             	cmp    0x10(%ebp),%eax
  800a61:	72 d9                	jb     800a3c <strncpy+0x15>
		*dst++ = *src;
		// If strlen(src) < size, null-pad 'dst' out to 'size' chars
		if (*src != '\0')
			src++;
	}
	return ret;
  800a63:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800a66:	c9                   	leave  
  800a67:	c3                   	ret    

00800a68 <strlcpy>:

uint32
strlcpy(char *dst, const char *src, uint32 size)
{
  800a68:	55                   	push   %ebp
  800a69:	89 e5                	mov    %esp,%ebp
  800a6b:	83 ec 10             	sub    $0x10,%esp
	char *dst_in;

	dst_in = dst;
  800a6e:	8b 45 08             	mov    0x8(%ebp),%eax
  800a71:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (size > 0) {
  800a74:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a78:	74 30                	je     800aaa <strlcpy+0x42>
		while (--size > 0 && *src != '\0')
  800a7a:	eb 16                	jmp    800a92 <strlcpy+0x2a>
			*dst++ = *src++;
  800a7c:	8b 45 08             	mov    0x8(%ebp),%eax
  800a7f:	8d 50 01             	lea    0x1(%eax),%edx
  800a82:	89 55 08             	mov    %edx,0x8(%ebp)
  800a85:	8b 55 0c             	mov    0xc(%ebp),%edx
  800a88:	8d 4a 01             	lea    0x1(%edx),%ecx
  800a8b:	89 4d 0c             	mov    %ecx,0xc(%ebp)
  800a8e:	8a 12                	mov    (%edx),%dl
  800a90:	88 10                	mov    %dl,(%eax)
{
	char *dst_in;

	dst_in = dst;
	if (size > 0) {
		while (--size > 0 && *src != '\0')
  800a92:	ff 4d 10             	decl   0x10(%ebp)
  800a95:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800a99:	74 09                	je     800aa4 <strlcpy+0x3c>
  800a9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  800a9e:	8a 00                	mov    (%eax),%al
  800aa0:	84 c0                	test   %al,%al
  800aa2:	75 d8                	jne    800a7c <strlcpy+0x14>
			*dst++ = *src++;
		*dst = '\0';
  800aa4:	8b 45 08             	mov    0x8(%ebp),%eax
  800aa7:	c6 00 00             	movb   $0x0,(%eax)
	}
	return dst - dst_in;
  800aaa:	8b 55 08             	mov    0x8(%ebp),%edx
  800aad:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ab0:	29 c2                	sub    %eax,%edx
  800ab2:	89 d0                	mov    %edx,%eax
}
  800ab4:	c9                   	leave  
  800ab5:	c3                   	ret    

00800ab6 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  800ab6:	55                   	push   %ebp
  800ab7:	89 e5                	mov    %esp,%ebp
	while (*p && *p == *q)
  800ab9:	eb 06                	jmp    800ac1 <strcmp+0xb>
		p++, q++;
  800abb:	ff 45 08             	incl   0x8(%ebp)
  800abe:	ff 45 0c             	incl   0xc(%ebp)
}

int
strcmp(const char *p, const char *q)
{
	while (*p && *p == *q)
  800ac1:	8b 45 08             	mov    0x8(%ebp),%eax
  800ac4:	8a 00                	mov    (%eax),%al
  800ac6:	84 c0                	test   %al,%al
  800ac8:	74 0e                	je     800ad8 <strcmp+0x22>
  800aca:	8b 45 08             	mov    0x8(%ebp),%eax
  800acd:	8a 10                	mov    (%eax),%dl
  800acf:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ad2:	8a 00                	mov    (%eax),%al
  800ad4:	38 c2                	cmp    %al,%dl
  800ad6:	74 e3                	je     800abb <strcmp+0x5>
		p++, q++;
	return (int) ((unsigned char) *p - (unsigned char) *q);
  800ad8:	8b 45 08             	mov    0x8(%ebp),%eax
  800adb:	8a 00                	mov    (%eax),%al
  800add:	0f b6 d0             	movzbl %al,%edx
  800ae0:	8b 45 0c             	mov    0xc(%ebp),%eax
  800ae3:	8a 00                	mov    (%eax),%al
  800ae5:	0f b6 c0             	movzbl %al,%eax
  800ae8:	29 c2                	sub    %eax,%edx
  800aea:	89 d0                	mov    %edx,%eax
}
  800aec:	5d                   	pop    %ebp
  800aed:	c3                   	ret    

00800aee <strncmp>:

int
strncmp(const char *p, const char *q, uint32 n)
{
  800aee:	55                   	push   %ebp
  800aef:	89 e5                	mov    %esp,%ebp
	while (n > 0 && *p && *p == *q)
  800af1:	eb 09                	jmp    800afc <strncmp+0xe>
		n--, p++, q++;
  800af3:	ff 4d 10             	decl   0x10(%ebp)
  800af6:	ff 45 08             	incl   0x8(%ebp)
  800af9:	ff 45 0c             	incl   0xc(%ebp)
}

int
strncmp(const char *p, const char *q, uint32 n)
{
	while (n > 0 && *p && *p == *q)
  800afc:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b00:	74 17                	je     800b19 <strncmp+0x2b>
  800b02:	8b 45 08             	mov    0x8(%ebp),%eax
  800b05:	8a 00                	mov    (%eax),%al
  800b07:	84 c0                	test   %al,%al
  800b09:	74 0e                	je     800b19 <strncmp+0x2b>
  800b0b:	8b 45 08             	mov    0x8(%ebp),%eax
  800b0e:	8a 10                	mov    (%eax),%dl
  800b10:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b13:	8a 00                	mov    (%eax),%al
  800b15:	38 c2                	cmp    %al,%dl
  800b17:	74 da                	je     800af3 <strncmp+0x5>
		n--, p++, q++;
	if (n == 0)
  800b19:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800b1d:	75 07                	jne    800b26 <strncmp+0x38>
		return 0;
  800b1f:	b8 00 00 00 00       	mov    $0x0,%eax
  800b24:	eb 14                	jmp    800b3a <strncmp+0x4c>
	else
		return (int) ((unsigned char) *p - (unsigned char) *q);
  800b26:	8b 45 08             	mov    0x8(%ebp),%eax
  800b29:	8a 00                	mov    (%eax),%al
  800b2b:	0f b6 d0             	movzbl %al,%edx
  800b2e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b31:	8a 00                	mov    (%eax),%al
  800b33:	0f b6 c0             	movzbl %al,%eax
  800b36:	29 c2                	sub    %eax,%edx
  800b38:	89 d0                	mov    %edx,%eax
}
  800b3a:	5d                   	pop    %ebp
  800b3b:	c3                   	ret    

00800b3c <strchr>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
  800b3c:	55                   	push   %ebp
  800b3d:	89 e5                	mov    %esp,%ebp
  800b3f:	83 ec 04             	sub    $0x4,%esp
  800b42:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b45:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b48:	eb 12                	jmp    800b5c <strchr+0x20>
		if (*s == c)
  800b4a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b4d:	8a 00                	mov    (%eax),%al
  800b4f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b52:	75 05                	jne    800b59 <strchr+0x1d>
			return (char *) s;
  800b54:	8b 45 08             	mov    0x8(%ebp),%eax
  800b57:	eb 11                	jmp    800b6a <strchr+0x2e>
// Return a pointer to the first occurrence of 'c' in 's',
// or a null pointer if the string has no 'c'.
char *
strchr(const char *s, char c)
{
	for (; *s; s++)
  800b59:	ff 45 08             	incl   0x8(%ebp)
  800b5c:	8b 45 08             	mov    0x8(%ebp),%eax
  800b5f:	8a 00                	mov    (%eax),%al
  800b61:	84 c0                	test   %al,%al
  800b63:	75 e5                	jne    800b4a <strchr+0xe>
		if (*s == c)
			return (char *) s;
	return 0;
  800b65:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800b6a:	c9                   	leave  
  800b6b:	c3                   	ret    

00800b6c <strfind>:

// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
  800b6c:	55                   	push   %ebp
  800b6d:	89 e5                	mov    %esp,%ebp
  800b6f:	83 ec 04             	sub    $0x4,%esp
  800b72:	8b 45 0c             	mov    0xc(%ebp),%eax
  800b75:	88 45 fc             	mov    %al,-0x4(%ebp)
	for (; *s; s++)
  800b78:	eb 0d                	jmp    800b87 <strfind+0x1b>
		if (*s == c)
  800b7a:	8b 45 08             	mov    0x8(%ebp),%eax
  800b7d:	8a 00                	mov    (%eax),%al
  800b7f:	3a 45 fc             	cmp    -0x4(%ebp),%al
  800b82:	74 0e                	je     800b92 <strfind+0x26>
// Return a pointer to the first occurrence of 'c' in 's',
// or a pointer to the string-ending null character if the string has no 'c'.
char *
strfind(const char *s, char c)
{
	for (; *s; s++)
  800b84:	ff 45 08             	incl   0x8(%ebp)
  800b87:	8b 45 08             	mov    0x8(%ebp),%eax
  800b8a:	8a 00                	mov    (%eax),%al
  800b8c:	84 c0                	test   %al,%al
  800b8e:	75 ea                	jne    800b7a <strfind+0xe>
  800b90:	eb 01                	jmp    800b93 <strfind+0x27>
		if (*s == c)
			break;
  800b92:	90                   	nop
	return (char *) s;
  800b93:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800b96:	c9                   	leave  
  800b97:	c3                   	ret    

00800b98 <memset>:


void *
memset(void *v, int c, uint32 n)
{
  800b98:	55                   	push   %ebp
  800b99:	89 e5                	mov    %esp,%ebp
  800b9b:	83 ec 10             	sub    $0x10,%esp
	char *p;
	int m;

	p = v;
  800b9e:	8b 45 08             	mov    0x8(%ebp),%eax
  800ba1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	m = n;
  800ba4:	8b 45 10             	mov    0x10(%ebp),%eax
  800ba7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (--m >= 0)
  800baa:	eb 0e                	jmp    800bba <memset+0x22>
		*p++ = c;
  800bac:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800baf:	8d 50 01             	lea    0x1(%eax),%edx
  800bb2:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800bb5:	8b 55 0c             	mov    0xc(%ebp),%edx
  800bb8:	88 10                	mov    %dl,(%eax)
	char *p;
	int m;

	p = v;
	m = n;
	while (--m >= 0)
  800bba:	ff 4d f8             	decl   -0x8(%ebp)
  800bbd:	83 7d f8 00          	cmpl   $0x0,-0x8(%ebp)
  800bc1:	79 e9                	jns    800bac <memset+0x14>
		*p++ = c;

	return v;
  800bc3:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800bc6:	c9                   	leave  
  800bc7:	c3                   	ret    

00800bc8 <memcpy>:

void *
memcpy(void *dst, const void *src, uint32 n)
{
  800bc8:	55                   	push   %ebp
  800bc9:	89 e5                	mov    %esp,%ebp
  800bcb:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800bce:	8b 45 0c             	mov    0xc(%ebp),%eax
  800bd1:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800bd4:	8b 45 08             	mov    0x8(%ebp),%eax
  800bd7:	89 45 f8             	mov    %eax,-0x8(%ebp)
	while (n-- > 0)
  800bda:	eb 16                	jmp    800bf2 <memcpy+0x2a>
		*d++ = *s++;
  800bdc:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800bdf:	8d 50 01             	lea    0x1(%eax),%edx
  800be2:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800be5:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800be8:	8d 4a 01             	lea    0x1(%edx),%ecx
  800beb:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800bee:	8a 12                	mov    (%edx),%dl
  800bf0:	88 10                	mov    %dl,(%eax)
	const char *s;
	char *d;

	s = src;
	d = dst;
	while (n-- > 0)
  800bf2:	8b 45 10             	mov    0x10(%ebp),%eax
  800bf5:	8d 50 ff             	lea    -0x1(%eax),%edx
  800bf8:	89 55 10             	mov    %edx,0x10(%ebp)
  800bfb:	85 c0                	test   %eax,%eax
  800bfd:	75 dd                	jne    800bdc <memcpy+0x14>
		*d++ = *s++;

	return dst;
  800bff:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c02:	c9                   	leave  
  800c03:	c3                   	ret    

00800c04 <memmove>:

void *
memmove(void *dst, const void *src, uint32 n)
{
  800c04:	55                   	push   %ebp
  800c05:	89 e5                	mov    %esp,%ebp
  800c07:	83 ec 10             	sub    $0x10,%esp
	const char *s;
	char *d;

	s = src;
  800c0a:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c0d:	89 45 fc             	mov    %eax,-0x4(%ebp)
	d = dst;
  800c10:	8b 45 08             	mov    0x8(%ebp),%eax
  800c13:	89 45 f8             	mov    %eax,-0x8(%ebp)
	if (s < d && s + n > d) {
  800c16:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c19:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c1c:	73 50                	jae    800c6e <memmove+0x6a>
  800c1e:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c21:	8b 45 10             	mov    0x10(%ebp),%eax
  800c24:	01 d0                	add    %edx,%eax
  800c26:	3b 45 f8             	cmp    -0x8(%ebp),%eax
  800c29:	76 43                	jbe    800c6e <memmove+0x6a>
		s += n;
  800c2b:	8b 45 10             	mov    0x10(%ebp),%eax
  800c2e:	01 45 fc             	add    %eax,-0x4(%ebp)
		d += n;
  800c31:	8b 45 10             	mov    0x10(%ebp),%eax
  800c34:	01 45 f8             	add    %eax,-0x8(%ebp)
		while (n-- > 0)
  800c37:	eb 10                	jmp    800c49 <memmove+0x45>
			*--d = *--s;
  800c39:	ff 4d f8             	decl   -0x8(%ebp)
  800c3c:	ff 4d fc             	decl   -0x4(%ebp)
  800c3f:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c42:	8a 10                	mov    (%eax),%dl
  800c44:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c47:	88 10                	mov    %dl,(%eax)
	s = src;
	d = dst;
	if (s < d && s + n > d) {
		s += n;
		d += n;
		while (n-- > 0)
  800c49:	8b 45 10             	mov    0x10(%ebp),%eax
  800c4c:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c4f:	89 55 10             	mov    %edx,0x10(%ebp)
  800c52:	85 c0                	test   %eax,%eax
  800c54:	75 e3                	jne    800c39 <memmove+0x35>
	const char *s;
	char *d;

	s = src;
	d = dst;
	if (s < d && s + n > d) {
  800c56:	eb 23                	jmp    800c7b <memmove+0x77>
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
			*d++ = *s++;
  800c58:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c5b:	8d 50 01             	lea    0x1(%eax),%edx
  800c5e:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800c61:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800c64:	8d 4a 01             	lea    0x1(%edx),%ecx
  800c67:	89 4d fc             	mov    %ecx,-0x4(%ebp)
  800c6a:	8a 12                	mov    (%edx),%dl
  800c6c:	88 10                	mov    %dl,(%eax)
		s += n;
		d += n;
		while (n-- > 0)
			*--d = *--s;
	} else
		while (n-- > 0)
  800c6e:	8b 45 10             	mov    0x10(%ebp),%eax
  800c71:	8d 50 ff             	lea    -0x1(%eax),%edx
  800c74:	89 55 10             	mov    %edx,0x10(%ebp)
  800c77:	85 c0                	test   %eax,%eax
  800c79:	75 dd                	jne    800c58 <memmove+0x54>
			*d++ = *s++;

	return dst;
  800c7b:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800c7e:	c9                   	leave  
  800c7f:	c3                   	ret    

00800c80 <memcmp>:

int
memcmp(const void *v1, const void *v2, uint32 n)
{
  800c80:	55                   	push   %ebp
  800c81:	89 e5                	mov    %esp,%ebp
  800c83:	83 ec 10             	sub    $0x10,%esp
	const uint8 *s1 = (const uint8 *) v1;
  800c86:	8b 45 08             	mov    0x8(%ebp),%eax
  800c89:	89 45 fc             	mov    %eax,-0x4(%ebp)
	const uint8 *s2 = (const uint8 *) v2;
  800c8c:	8b 45 0c             	mov    0xc(%ebp),%eax
  800c8f:	89 45 f8             	mov    %eax,-0x8(%ebp)

	while (n-- > 0) {
  800c92:	eb 2a                	jmp    800cbe <memcmp+0x3e>
		if (*s1 != *s2)
  800c94:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800c97:	8a 10                	mov    (%eax),%dl
  800c99:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800c9c:	8a 00                	mov    (%eax),%al
  800c9e:	38 c2                	cmp    %al,%dl
  800ca0:	74 16                	je     800cb8 <memcmp+0x38>
			return (int) *s1 - (int) *s2;
  800ca2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800ca5:	8a 00                	mov    (%eax),%al
  800ca7:	0f b6 d0             	movzbl %al,%edx
  800caa:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800cad:	8a 00                	mov    (%eax),%al
  800caf:	0f b6 c0             	movzbl %al,%eax
  800cb2:	29 c2                	sub    %eax,%edx
  800cb4:	89 d0                	mov    %edx,%eax
  800cb6:	eb 18                	jmp    800cd0 <memcmp+0x50>
		s1++, s2++;
  800cb8:	ff 45 fc             	incl   -0x4(%ebp)
  800cbb:	ff 45 f8             	incl   -0x8(%ebp)
memcmp(const void *v1, const void *v2, uint32 n)
{
	const uint8 *s1 = (const uint8 *) v1;
	const uint8 *s2 = (const uint8 *) v2;

	while (n-- > 0) {
  800cbe:	8b 45 10             	mov    0x10(%ebp),%eax
  800cc1:	8d 50 ff             	lea    -0x1(%eax),%edx
  800cc4:	89 55 10             	mov    %edx,0x10(%ebp)
  800cc7:	85 c0                	test   %eax,%eax
  800cc9:	75 c9                	jne    800c94 <memcmp+0x14>
		if (*s1 != *s2)
			return (int) *s1 - (int) *s2;
		s1++, s2++;
	}

	return 0;
  800ccb:	b8 00 00 00 00       	mov    $0x0,%eax
}
  800cd0:	c9                   	leave  
  800cd1:	c3                   	ret    

00800cd2 <memfind>:

void *
memfind(const void *s, int c, uint32 n)
{
  800cd2:	55                   	push   %ebp
  800cd3:	89 e5                	mov    %esp,%ebp
  800cd5:	83 ec 10             	sub    $0x10,%esp
	const void *ends = (const char *) s + n;
  800cd8:	8b 55 08             	mov    0x8(%ebp),%edx
  800cdb:	8b 45 10             	mov    0x10(%ebp),%eax
  800cde:	01 d0                	add    %edx,%eax
  800ce0:	89 45 fc             	mov    %eax,-0x4(%ebp)
	for (; s < ends; s++)
  800ce3:	eb 15                	jmp    800cfa <memfind+0x28>
		if (*(const unsigned char *) s == (unsigned char) c)
  800ce5:	8b 45 08             	mov    0x8(%ebp),%eax
  800ce8:	8a 00                	mov    (%eax),%al
  800cea:	0f b6 d0             	movzbl %al,%edx
  800ced:	8b 45 0c             	mov    0xc(%ebp),%eax
  800cf0:	0f b6 c0             	movzbl %al,%eax
  800cf3:	39 c2                	cmp    %eax,%edx
  800cf5:	74 0d                	je     800d04 <memfind+0x32>

void *
memfind(const void *s, int c, uint32 n)
{
	const void *ends = (const char *) s + n;
	for (; s < ends; s++)
  800cf7:	ff 45 08             	incl   0x8(%ebp)
  800cfa:	8b 45 08             	mov    0x8(%ebp),%eax
  800cfd:	3b 45 fc             	cmp    -0x4(%ebp),%eax
  800d00:	72 e3                	jb     800ce5 <memfind+0x13>
  800d02:	eb 01                	jmp    800d05 <memfind+0x33>
		if (*(const unsigned char *) s == (unsigned char) c)
			break;
  800d04:	90                   	nop
	return (void *) s;
  800d05:	8b 45 08             	mov    0x8(%ebp),%eax
}
  800d08:	c9                   	leave  
  800d09:	c3                   	ret    

00800d0a <strtol>:

long
strtol(const char *s, char **endptr, int base)
{
  800d0a:	55                   	push   %ebp
  800d0b:	89 e5                	mov    %esp,%ebp
  800d0d:	83 ec 10             	sub    $0x10,%esp
	int neg = 0;
  800d10:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	long val = 0;
  800d17:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d1e:	eb 03                	jmp    800d23 <strtol+0x19>
		s++;
  800d20:	ff 45 08             	incl   0x8(%ebp)
{
	int neg = 0;
	long val = 0;

	// gobble initial whitespace
	while (*s == ' ' || *s == '\t')
  800d23:	8b 45 08             	mov    0x8(%ebp),%eax
  800d26:	8a 00                	mov    (%eax),%al
  800d28:	3c 20                	cmp    $0x20,%al
  800d2a:	74 f4                	je     800d20 <strtol+0x16>
  800d2c:	8b 45 08             	mov    0x8(%ebp),%eax
  800d2f:	8a 00                	mov    (%eax),%al
  800d31:	3c 09                	cmp    $0x9,%al
  800d33:	74 eb                	je     800d20 <strtol+0x16>
		s++;

	// plus/minus sign
	if (*s == '+')
  800d35:	8b 45 08             	mov    0x8(%ebp),%eax
  800d38:	8a 00                	mov    (%eax),%al
  800d3a:	3c 2b                	cmp    $0x2b,%al
  800d3c:	75 05                	jne    800d43 <strtol+0x39>
		s++;
  800d3e:	ff 45 08             	incl   0x8(%ebp)
  800d41:	eb 13                	jmp    800d56 <strtol+0x4c>
	else if (*s == '-')
  800d43:	8b 45 08             	mov    0x8(%ebp),%eax
  800d46:	8a 00                	mov    (%eax),%al
  800d48:	3c 2d                	cmp    $0x2d,%al
  800d4a:	75 0a                	jne    800d56 <strtol+0x4c>
		s++, neg = 1;
  800d4c:	ff 45 08             	incl   0x8(%ebp)
  800d4f:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)

	// hex or octal base prefix
	if ((base == 0 || base == 16) && (s[0] == '0' && s[1] == 'x'))
  800d56:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d5a:	74 06                	je     800d62 <strtol+0x58>
  800d5c:	83 7d 10 10          	cmpl   $0x10,0x10(%ebp)
  800d60:	75 20                	jne    800d82 <strtol+0x78>
  800d62:	8b 45 08             	mov    0x8(%ebp),%eax
  800d65:	8a 00                	mov    (%eax),%al
  800d67:	3c 30                	cmp    $0x30,%al
  800d69:	75 17                	jne    800d82 <strtol+0x78>
  800d6b:	8b 45 08             	mov    0x8(%ebp),%eax
  800d6e:	40                   	inc    %eax
  800d6f:	8a 00                	mov    (%eax),%al
  800d71:	3c 78                	cmp    $0x78,%al
  800d73:	75 0d                	jne    800d82 <strtol+0x78>
		s += 2, base = 16;
  800d75:	83 45 08 02          	addl   $0x2,0x8(%ebp)
  800d79:	c7 45 10 10 00 00 00 	movl   $0x10,0x10(%ebp)
  800d80:	eb 28                	jmp    800daa <strtol+0xa0>
	else if (base == 0 && s[0] == '0')
  800d82:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800d86:	75 15                	jne    800d9d <strtol+0x93>
  800d88:	8b 45 08             	mov    0x8(%ebp),%eax
  800d8b:	8a 00                	mov    (%eax),%al
  800d8d:	3c 30                	cmp    $0x30,%al
  800d8f:	75 0c                	jne    800d9d <strtol+0x93>
		s++, base = 8;
  800d91:	ff 45 08             	incl   0x8(%ebp)
  800d94:	c7 45 10 08 00 00 00 	movl   $0x8,0x10(%ebp)
  800d9b:	eb 0d                	jmp    800daa <strtol+0xa0>
	else if (base == 0)
  800d9d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
  800da1:	75 07                	jne    800daa <strtol+0xa0>
		base = 10;
  800da3:	c7 45 10 0a 00 00 00 	movl   $0xa,0x10(%ebp)

	// digits
	while (1) {
		int dig;

		if (*s >= '0' && *s <= '9')
  800daa:	8b 45 08             	mov    0x8(%ebp),%eax
  800dad:	8a 00                	mov    (%eax),%al
  800daf:	3c 2f                	cmp    $0x2f,%al
  800db1:	7e 19                	jle    800dcc <strtol+0xc2>
  800db3:	8b 45 08             	mov    0x8(%ebp),%eax
  800db6:	8a 00                	mov    (%eax),%al
  800db8:	3c 39                	cmp    $0x39,%al
  800dba:	7f 10                	jg     800dcc <strtol+0xc2>
			dig = *s - '0';
  800dbc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dbf:	8a 00                	mov    (%eax),%al
  800dc1:	0f be c0             	movsbl %al,%eax
  800dc4:	83 e8 30             	sub    $0x30,%eax
  800dc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dca:	eb 42                	jmp    800e0e <strtol+0x104>
		else if (*s >= 'a' && *s <= 'z')
  800dcc:	8b 45 08             	mov    0x8(%ebp),%eax
  800dcf:	8a 00                	mov    (%eax),%al
  800dd1:	3c 60                	cmp    $0x60,%al
  800dd3:	7e 19                	jle    800dee <strtol+0xe4>
  800dd5:	8b 45 08             	mov    0x8(%ebp),%eax
  800dd8:	8a 00                	mov    (%eax),%al
  800dda:	3c 7a                	cmp    $0x7a,%al
  800ddc:	7f 10                	jg     800dee <strtol+0xe4>
			dig = *s - 'a' + 10;
  800dde:	8b 45 08             	mov    0x8(%ebp),%eax
  800de1:	8a 00                	mov    (%eax),%al
  800de3:	0f be c0             	movsbl %al,%eax
  800de6:	83 e8 57             	sub    $0x57,%eax
  800de9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  800dec:	eb 20                	jmp    800e0e <strtol+0x104>
		else if (*s >= 'A' && *s <= 'Z')
  800dee:	8b 45 08             	mov    0x8(%ebp),%eax
  800df1:	8a 00                	mov    (%eax),%al
  800df3:	3c 40                	cmp    $0x40,%al
  800df5:	7e 39                	jle    800e30 <strtol+0x126>
  800df7:	8b 45 08             	mov    0x8(%ebp),%eax
  800dfa:	8a 00                	mov    (%eax),%al
  800dfc:	3c 5a                	cmp    $0x5a,%al
  800dfe:	7f 30                	jg     800e30 <strtol+0x126>
			dig = *s - 'A' + 10;
  800e00:	8b 45 08             	mov    0x8(%ebp),%eax
  800e03:	8a 00                	mov    (%eax),%al
  800e05:	0f be c0             	movsbl %al,%eax
  800e08:	83 e8 37             	sub    $0x37,%eax
  800e0b:	89 45 f4             	mov    %eax,-0xc(%ebp)
		else
			break;
		if (dig >= base)
  800e0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e11:	3b 45 10             	cmp    0x10(%ebp),%eax
  800e14:	7d 19                	jge    800e2f <strtol+0x125>
			break;
		s++, val = (val * base) + dig;
  800e16:	ff 45 08             	incl   0x8(%ebp)
  800e19:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e1c:	0f af 45 10          	imul   0x10(%ebp),%eax
  800e20:	89 c2                	mov    %eax,%edx
  800e22:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800e25:	01 d0                	add    %edx,%eax
  800e27:	89 45 f8             	mov    %eax,-0x8(%ebp)
		// we don't properly detect overflow!
	}
  800e2a:	e9 7b ff ff ff       	jmp    800daa <strtol+0xa0>
		else if (*s >= 'A' && *s <= 'Z')
			dig = *s - 'A' + 10;
		else
			break;
		if (dig >= base)
			break;
  800e2f:	90                   	nop
		s++, val = (val * base) + dig;
		// we don't properly detect overflow!
	}

	if (endptr)
  800e30:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
  800e34:	74 08                	je     800e3e <strtol+0x134>
		*endptr = (char *) s;
  800e36:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e39:	8b 55 08             	mov    0x8(%ebp),%edx
  800e3c:	89 10                	mov    %edx,(%eax)
	return (neg ? -val : val);
  800e3e:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800e42:	74 07                	je     800e4b <strtol+0x141>
  800e44:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e47:	f7 d8                	neg    %eax
  800e49:	eb 03                	jmp    800e4e <strtol+0x144>
  800e4b:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
  800e4e:	c9                   	leave  
  800e4f:	c3                   	ret    

00800e50 <ltostr>:

void
ltostr(long value, char *str)
{
  800e50:	55                   	push   %ebp
  800e51:	89 e5                	mov    %esp,%ebp
  800e53:	83 ec 20             	sub    $0x20,%esp
	int neg = 0;
  800e56:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	int s = 0 ;
  800e5d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)

	// plus/minus sign
	if (value < 0)
  800e64:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
  800e68:	79 13                	jns    800e7d <ltostr+0x2d>
	{
		neg = 1;
  800e6a:	c7 45 fc 01 00 00 00 	movl   $0x1,-0x4(%ebp)
		str[0] = '-';
  800e71:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e74:	c6 00 2d             	movb   $0x2d,(%eax)
		value = value * -1 ;
  800e77:	f7 5d 08             	negl   0x8(%ebp)
		s++ ;
  800e7a:	ff 45 f8             	incl   -0x8(%ebp)
	}
	do
	{
		int mod = value % 10 ;
  800e7d:	8b 45 08             	mov    0x8(%ebp),%eax
  800e80:	b9 0a 00 00 00       	mov    $0xa,%ecx
  800e85:	99                   	cltd   
  800e86:	f7 f9                	idiv   %ecx
  800e88:	89 55 ec             	mov    %edx,-0x14(%ebp)
		str[s++] = mod + '0' ;
  800e8b:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800e8e:	8d 50 01             	lea    0x1(%eax),%edx
  800e91:	89 55 f8             	mov    %edx,-0x8(%ebp)
  800e94:	89 c2                	mov    %eax,%edx
  800e96:	8b 45 0c             	mov    0xc(%ebp),%eax
  800e99:	01 d0                	add    %edx,%eax
  800e9b:	8b 55 ec             	mov    -0x14(%ebp),%edx
  800e9e:	83 c2 30             	add    $0x30,%edx
  800ea1:	88 10                	mov    %dl,(%eax)
		value = value / 10 ;
  800ea3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ea6:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800eab:	f7 e9                	imul   %ecx
  800ead:	c1 fa 02             	sar    $0x2,%edx
  800eb0:	89 c8                	mov    %ecx,%eax
  800eb2:	c1 f8 1f             	sar    $0x1f,%eax
  800eb5:	29 c2                	sub    %eax,%edx
  800eb7:	89 d0                	mov    %edx,%eax
  800eb9:	89 45 08             	mov    %eax,0x8(%ebp)
	} while (value % 10 != 0);
  800ebc:	8b 4d 08             	mov    0x8(%ebp),%ecx
  800ebf:	b8 67 66 66 66       	mov    $0x66666667,%eax
  800ec4:	f7 e9                	imul   %ecx
  800ec6:	c1 fa 02             	sar    $0x2,%edx
  800ec9:	89 c8                	mov    %ecx,%eax
  800ecb:	c1 f8 1f             	sar    $0x1f,%eax
  800ece:	29 c2                	sub    %eax,%edx
  800ed0:	89 d0                	mov    %edx,%eax
  800ed2:	c1 e0 02             	shl    $0x2,%eax
  800ed5:	01 d0                	add    %edx,%eax
  800ed7:	01 c0                	add    %eax,%eax
  800ed9:	29 c1                	sub    %eax,%ecx
  800edb:	89 ca                	mov    %ecx,%edx
  800edd:	85 d2                	test   %edx,%edx
  800edf:	75 9c                	jne    800e7d <ltostr+0x2d>

	//reverse the string
	int start = 0 ;
  800ee1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	int end = s-1 ;
  800ee8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800eeb:	48                   	dec    %eax
  800eec:	89 45 f0             	mov    %eax,-0x10(%ebp)
	if (neg)
  800eef:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
  800ef3:	74 3d                	je     800f32 <ltostr+0xe2>
		start = 1 ;
  800ef5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
	while(start<end)
  800efc:	eb 34                	jmp    800f32 <ltostr+0xe2>
	{
		char tmp = str[start] ;
  800efe:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f01:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f04:	01 d0                	add    %edx,%eax
  800f06:	8a 00                	mov    (%eax),%al
  800f08:	88 45 eb             	mov    %al,-0x15(%ebp)
		str[start] = str[end] ;
  800f0b:	8b 55 f4             	mov    -0xc(%ebp),%edx
  800f0e:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f11:	01 c2                	add    %eax,%edx
  800f13:	8b 4d f0             	mov    -0x10(%ebp),%ecx
  800f16:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f19:	01 c8                	add    %ecx,%eax
  800f1b:	8a 00                	mov    (%eax),%al
  800f1d:	88 02                	mov    %al,(%edx)
		str[end] = tmp;
  800f1f:	8b 55 f0             	mov    -0x10(%ebp),%edx
  800f22:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f25:	01 c2                	add    %eax,%edx
  800f27:	8a 45 eb             	mov    -0x15(%ebp),%al
  800f2a:	88 02                	mov    %al,(%edx)
		start++ ;
  800f2c:	ff 45 f4             	incl   -0xc(%ebp)
		end-- ;
  800f2f:	ff 4d f0             	decl   -0x10(%ebp)
	//reverse the string
	int start = 0 ;
	int end = s-1 ;
	if (neg)
		start = 1 ;
	while(start<end)
  800f32:	8b 45 f4             	mov    -0xc(%ebp),%eax
  800f35:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800f38:	7c c4                	jl     800efe <ltostr+0xae>
		str[end] = tmp;
		start++ ;
		end-- ;
	}

	str[s] = 0 ;
  800f3a:	8b 55 f8             	mov    -0x8(%ebp),%edx
  800f3d:	8b 45 0c             	mov    0xc(%ebp),%eax
  800f40:	01 d0                	add    %edx,%eax
  800f42:	c6 00 00             	movb   $0x0,(%eax)
	// we don't properly detect overflow!

}
  800f45:	90                   	nop
  800f46:	c9                   	leave  
  800f47:	c3                   	ret    

00800f48 <strcconcat>:

void
strcconcat(const char *str1, const char *str2, char *final)
{
  800f48:	55                   	push   %ebp
  800f49:	89 e5                	mov    %esp,%ebp
  800f4b:	83 ec 10             	sub    $0x10,%esp
	int len1 = strlen(str1);
  800f4e:	ff 75 08             	pushl  0x8(%ebp)
  800f51:	e8 54 fa ff ff       	call   8009aa <strlen>
  800f56:	83 c4 04             	add    $0x4,%esp
  800f59:	89 45 f4             	mov    %eax,-0xc(%ebp)
	int len2 = strlen(str2);
  800f5c:	ff 75 0c             	pushl  0xc(%ebp)
  800f5f:	e8 46 fa ff ff       	call   8009aa <strlen>
  800f64:	83 c4 04             	add    $0x4,%esp
  800f67:	89 45 f0             	mov    %eax,-0x10(%ebp)
	int s = 0 ;
  800f6a:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
	for (s=0 ; s < len1 ; s++)
  800f71:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  800f78:	eb 17                	jmp    800f91 <strcconcat+0x49>
		final[s] = str1[s] ;
  800f7a:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800f7d:	8b 45 10             	mov    0x10(%ebp),%eax
  800f80:	01 c2                	add    %eax,%edx
  800f82:	8b 4d fc             	mov    -0x4(%ebp),%ecx
  800f85:	8b 45 08             	mov    0x8(%ebp),%eax
  800f88:	01 c8                	add    %ecx,%eax
  800f8a:	8a 00                	mov    (%eax),%al
  800f8c:	88 02                	mov    %al,(%edx)
strcconcat(const char *str1, const char *str2, char *final)
{
	int len1 = strlen(str1);
	int len2 = strlen(str2);
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
  800f8e:	ff 45 fc             	incl   -0x4(%ebp)
  800f91:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800f94:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  800f97:	7c e1                	jl     800f7a <strcconcat+0x32>
		final[s] = str1[s] ;

	int i = 0 ;
  800f99:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
	for (i=0 ; i < len2 ; i++)
  800fa0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  800fa7:	eb 1f                	jmp    800fc8 <strcconcat+0x80>
		final[s++] = str2[i] ;
  800fa9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  800fac:	8d 50 01             	lea    0x1(%eax),%edx
  800faf:	89 55 fc             	mov    %edx,-0x4(%ebp)
  800fb2:	89 c2                	mov    %eax,%edx
  800fb4:	8b 45 10             	mov    0x10(%ebp),%eax
  800fb7:	01 c2                	add    %eax,%edx
  800fb9:	8b 4d f8             	mov    -0x8(%ebp),%ecx
  800fbc:	8b 45 0c             	mov    0xc(%ebp),%eax
  800fbf:	01 c8                	add    %ecx,%eax
  800fc1:	8a 00                	mov    (%eax),%al
  800fc3:	88 02                	mov    %al,(%edx)
	int s = 0 ;
	for (s=0 ; s < len1 ; s++)
		final[s] = str1[s] ;

	int i = 0 ;
	for (i=0 ; i < len2 ; i++)
  800fc5:	ff 45 f8             	incl   -0x8(%ebp)
  800fc8:	8b 45 f8             	mov    -0x8(%ebp),%eax
  800fcb:	3b 45 f0             	cmp    -0x10(%ebp),%eax
  800fce:	7c d9                	jl     800fa9 <strcconcat+0x61>
		final[s++] = str2[i] ;

	final[s] = 0;
  800fd0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  800fd3:	8b 45 10             	mov    0x10(%ebp),%eax
  800fd6:	01 d0                	add    %edx,%eax
  800fd8:	c6 00 00             	movb   $0x0,(%eax)
}
  800fdb:	90                   	nop
  800fdc:	c9                   	leave  
  800fdd:	c3                   	ret    

00800fde <strsplit>:
int strsplit(char *string, char *SPLIT_CHARS, char **argv, int * argc)
{
  800fde:	55                   	push   %ebp
  800fdf:	89 e5                	mov    %esp,%ebp
	// Parse the command string into splitchars-separated arguments
	*argc = 0;
  800fe1:	8b 45 14             	mov    0x14(%ebp),%eax
  800fe4:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	(argv)[*argc] = 0;
  800fea:	8b 45 14             	mov    0x14(%ebp),%eax
  800fed:	8b 00                	mov    (%eax),%eax
  800fef:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  800ff6:	8b 45 10             	mov    0x10(%ebp),%eax
  800ff9:	01 d0                	add    %edx,%eax
  800ffb:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  801001:	eb 0c                	jmp    80100f <strsplit+0x31>
			*string++ = 0;
  801003:	8b 45 08             	mov    0x8(%ebp),%eax
  801006:	8d 50 01             	lea    0x1(%eax),%edx
  801009:	89 55 08             	mov    %edx,0x8(%ebp)
  80100c:	c6 00 00             	movb   $0x0,(%eax)
	*argc = 0;
	(argv)[*argc] = 0;
	while (1)
	{
		// trim splitchars
		while (*string && strchr(SPLIT_CHARS, *string))
  80100f:	8b 45 08             	mov    0x8(%ebp),%eax
  801012:	8a 00                	mov    (%eax),%al
  801014:	84 c0                	test   %al,%al
  801016:	74 18                	je     801030 <strsplit+0x52>
  801018:	8b 45 08             	mov    0x8(%ebp),%eax
  80101b:	8a 00                	mov    (%eax),%al
  80101d:	0f be c0             	movsbl %al,%eax
  801020:	50                   	push   %eax
  801021:	ff 75 0c             	pushl  0xc(%ebp)
  801024:	e8 13 fb ff ff       	call   800b3c <strchr>
  801029:	83 c4 08             	add    $0x8,%esp
  80102c:	85 c0                	test   %eax,%eax
  80102e:	75 d3                	jne    801003 <strsplit+0x25>
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
  801030:	8b 45 08             	mov    0x8(%ebp),%eax
  801033:	8a 00                	mov    (%eax),%al
  801035:	84 c0                	test   %al,%al
  801037:	74 5a                	je     801093 <strsplit+0xb5>
			break;

		//check current number of arguments
		if (*argc == MAX_ARGUMENTS-1)
  801039:	8b 45 14             	mov    0x14(%ebp),%eax
  80103c:	8b 00                	mov    (%eax),%eax
  80103e:	83 f8 0f             	cmp    $0xf,%eax
  801041:	75 07                	jne    80104a <strsplit+0x6c>
		{
			return 0;
  801043:	b8 00 00 00 00       	mov    $0x0,%eax
  801048:	eb 66                	jmp    8010b0 <strsplit+0xd2>
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
  80104a:	8b 45 14             	mov    0x14(%ebp),%eax
  80104d:	8b 00                	mov    (%eax),%eax
  80104f:	8d 48 01             	lea    0x1(%eax),%ecx
  801052:	8b 55 14             	mov    0x14(%ebp),%edx
  801055:	89 0a                	mov    %ecx,(%edx)
  801057:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  80105e:	8b 45 10             	mov    0x10(%ebp),%eax
  801061:	01 c2                	add    %eax,%edx
  801063:	8b 45 08             	mov    0x8(%ebp),%eax
  801066:	89 02                	mov    %eax,(%edx)
		while (*string && !strchr(SPLIT_CHARS, *string))
  801068:	eb 03                	jmp    80106d <strsplit+0x8f>
			string++;
  80106a:	ff 45 08             	incl   0x8(%ebp)
			return 0;
		}

		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
  80106d:	8b 45 08             	mov    0x8(%ebp),%eax
  801070:	8a 00                	mov    (%eax),%al
  801072:	84 c0                	test   %al,%al
  801074:	74 8b                	je     801001 <strsplit+0x23>
  801076:	8b 45 08             	mov    0x8(%ebp),%eax
  801079:	8a 00                	mov    (%eax),%al
  80107b:	0f be c0             	movsbl %al,%eax
  80107e:	50                   	push   %eax
  80107f:	ff 75 0c             	pushl  0xc(%ebp)
  801082:	e8 b5 fa ff ff       	call   800b3c <strchr>
  801087:	83 c4 08             	add    $0x8,%esp
  80108a:	85 c0                	test   %eax,%eax
  80108c:	74 dc                	je     80106a <strsplit+0x8c>
			string++;
	}
  80108e:	e9 6e ff ff ff       	jmp    801001 <strsplit+0x23>
		while (*string && strchr(SPLIT_CHARS, *string))
			*string++ = 0;

		//if the command string is finished, then break the loop
		if (*string == 0)
			break;
  801093:	90                   	nop
		// save the previous argument and scan past next arg
		(argv)[(*argc)++] = string;
		while (*string && !strchr(SPLIT_CHARS, *string))
			string++;
	}
	(argv)[*argc] = 0;
  801094:	8b 45 14             	mov    0x14(%ebp),%eax
  801097:	8b 00                	mov    (%eax),%eax
  801099:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8010a0:	8b 45 10             	mov    0x10(%ebp),%eax
  8010a3:	01 d0                	add    %edx,%eax
  8010a5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
	return 1 ;
  8010ab:	b8 01 00 00 00       	mov    $0x1,%eax
}
  8010b0:	c9                   	leave  
  8010b1:	c3                   	ret    

008010b2 <malloc>:

//==================================================================================//
//============================ REQUIRED FUNCTIONS ==================================//
//==================================================================================//
void* malloc(uint32 size)
{
  8010b2:	55                   	push   %ebp
  8010b3:	89 e5                	mov    %esp,%ebp
  8010b5:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("malloc() is not implemented yet...!!");
  8010b8:	83 ec 04             	sub    $0x4,%esp
  8010bb:	68 d0 20 80 00       	push   $0x8020d0
  8010c0:	6a 15                	push   $0x15
  8010c2:	68 f5 20 80 00       	push   $0x8020f5
  8010c7:	e8 4f 07 00 00       	call   80181b <_panic>

008010cc <free>:
//		switches to the kernel mode, calls freeMem(struct Env* e, uint32 virtual_address, uint32 size) in
//		"memory_manager.c", then switch back to the user mode here
//	the freeMem function is empty, make sure to implement it.

void free(void* virtual_address)
{
  8010cc:	55                   	push   %ebp
  8010cd:	89 e5                	mov    %esp,%ebp
  8010cf:	83 ec 08             	sub    $0x8,%esp
	// Write your code here, remove the panic and write your code
	panic("free() is not implemented yet...!!");
  8010d2:	83 ec 04             	sub    $0x4,%esp
  8010d5:	68 04 21 80 00       	push   $0x802104
  8010da:	6a 2e                	push   $0x2e
  8010dc:	68 f5 20 80 00       	push   $0x8020f5
  8010e1:	e8 35 07 00 00       	call   80181b <_panic>

008010e6 <realloc>:
//		which switches to the kernel mode, calls moveMem(struct Env* e, uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
//		in "memory_manager.c", then switch back to the user mode here
//	the moveMem function is empty, make sure to implement it.

void *realloc(void *virtual_address, uint32 new_size)
{
  8010e6:	55                   	push   %ebp
  8010e7:	89 e5                	mov    %esp,%ebp
  8010e9:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  8010ec:	83 ec 04             	sub    $0x4,%esp
  8010ef:	68 28 21 80 00       	push   $0x802128
  8010f4:	6a 4c                	push   $0x4c
  8010f6:	68 f5 20 80 00       	push   $0x8020f5
  8010fb:	e8 1b 07 00 00       	call   80181b <_panic>

00801100 <smalloc>:
//==================================================================================//
//================================ OTHER FUNCTIONS =================================//
//==================================================================================//

void* smalloc(char *sharedVarName, uint32 size, uint8 isWritable)
{
  801100:	55                   	push   %ebp
  801101:	89 e5                	mov    %esp,%ebp
  801103:	83 ec 18             	sub    $0x18,%esp
  801106:	8b 45 10             	mov    0x10(%ebp),%eax
  801109:	88 45 f4             	mov    %al,-0xc(%ebp)
	panic("this function is not required...!!");
  80110c:	83 ec 04             	sub    $0x4,%esp
  80110f:	68 28 21 80 00       	push   $0x802128
  801114:	6a 57                	push   $0x57
  801116:	68 f5 20 80 00       	push   $0x8020f5
  80111b:	e8 fb 06 00 00       	call   80181b <_panic>

00801120 <sget>:
	return 0;
}

void* sget(int32 ownerEnvID, char *sharedVarName)
{
  801120:	55                   	push   %ebp
  801121:	89 e5                	mov    %esp,%ebp
  801123:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801126:	83 ec 04             	sub    $0x4,%esp
  801129:	68 28 21 80 00       	push   $0x802128
  80112e:	6a 5d                	push   $0x5d
  801130:	68 f5 20 80 00       	push   $0x8020f5
  801135:	e8 e1 06 00 00       	call   80181b <_panic>

0080113a <sfree>:
	return 0;
}

void sfree(void* virtual_address)
{
  80113a:	55                   	push   %ebp
  80113b:	89 e5                	mov    %esp,%ebp
  80113d:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801140:	83 ec 04             	sub    $0x4,%esp
  801143:	68 28 21 80 00       	push   $0x802128
  801148:	6a 63                	push   $0x63
  80114a:	68 f5 20 80 00       	push   $0x8020f5
  80114f:	e8 c7 06 00 00       	call   80181b <_panic>

00801154 <expand>:
}

void expand(uint32 newSize)
{
  801154:	55                   	push   %ebp
  801155:	89 e5                	mov    %esp,%ebp
  801157:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80115a:	83 ec 04             	sub    $0x4,%esp
  80115d:	68 28 21 80 00       	push   $0x802128
  801162:	6a 68                	push   $0x68
  801164:	68 f5 20 80 00       	push   $0x8020f5
  801169:	e8 ad 06 00 00       	call   80181b <_panic>

0080116e <shrink>:
}
void shrink(uint32 newSize)
{
  80116e:	55                   	push   %ebp
  80116f:	89 e5                	mov    %esp,%ebp
  801171:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  801174:	83 ec 04             	sub    $0x4,%esp
  801177:	68 28 21 80 00       	push   $0x802128
  80117c:	6a 6c                	push   $0x6c
  80117e:	68 f5 20 80 00       	push   $0x8020f5
  801183:	e8 93 06 00 00       	call   80181b <_panic>

00801188 <freeHeap>:
}

void freeHeap(void* virtual_address)
{
  801188:	55                   	push   %ebp
  801189:	89 e5                	mov    %esp,%ebp
  80118b:	83 ec 08             	sub    $0x8,%esp
	panic("this function is not required...!!");
  80118e:	83 ec 04             	sub    $0x4,%esp
  801191:	68 28 21 80 00       	push   $0x802128
  801196:	6a 71                	push   $0x71
  801198:	68 f5 20 80 00       	push   $0x8020f5
  80119d:	e8 79 06 00 00       	call   80181b <_panic>

008011a2 <syscall>:
#include <inc/syscall.h>
#include <inc/lib.h>

static inline uint32
syscall(int num, uint32 a1, uint32 a2, uint32 a3, uint32 a4, uint32 a5)
{
  8011a2:	55                   	push   %ebp
  8011a3:	89 e5                	mov    %esp,%ebp
  8011a5:	57                   	push   %edi
  8011a6:	56                   	push   %esi
  8011a7:	53                   	push   %ebx
  8011a8:	83 ec 10             	sub    $0x10,%esp
	//
	// The last clause tells the assembler that this can
	// potentially change the condition codes and arbitrary
	// memory locations.

	asm volatile("int %1\n"
  8011ab:	8b 45 08             	mov    0x8(%ebp),%eax
  8011ae:	8b 55 0c             	mov    0xc(%ebp),%edx
  8011b1:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8011b4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8011b7:	8b 7d 18             	mov    0x18(%ebp),%edi
  8011ba:	8b 75 1c             	mov    0x1c(%ebp),%esi
  8011bd:	cd 30                	int    $0x30
  8011bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
		  "b" (a3),
		  "D" (a4),
		  "S" (a5)
		: "cc", "memory");

	return ret;
  8011c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
  8011c5:	83 c4 10             	add    $0x10,%esp
  8011c8:	5b                   	pop    %ebx
  8011c9:	5e                   	pop    %esi
  8011ca:	5f                   	pop    %edi
  8011cb:	5d                   	pop    %ebp
  8011cc:	c3                   	ret    

008011cd <sys_cputs>:

void
sys_cputs(const char *s, uint32 len, uint8 printProgName)
{
  8011cd:	55                   	push   %ebp
  8011ce:	89 e5                	mov    %esp,%ebp
  8011d0:	83 ec 04             	sub    $0x4,%esp
  8011d3:	8b 45 10             	mov    0x10(%ebp),%eax
  8011d6:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputs, (uint32) s, len, (uint32)printProgName, 0, 0);
  8011d9:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8011dd:	8b 45 08             	mov    0x8(%ebp),%eax
  8011e0:	6a 00                	push   $0x0
  8011e2:	6a 00                	push   $0x0
  8011e4:	52                   	push   %edx
  8011e5:	ff 75 0c             	pushl  0xc(%ebp)
  8011e8:	50                   	push   %eax
  8011e9:	6a 00                	push   $0x0
  8011eb:	e8 b2 ff ff ff       	call   8011a2 <syscall>
  8011f0:	83 c4 18             	add    $0x18,%esp
}
  8011f3:	90                   	nop
  8011f4:	c9                   	leave  
  8011f5:	c3                   	ret    

008011f6 <sys_cgetc>:

int
sys_cgetc(void)
{
  8011f6:	55                   	push   %ebp
  8011f7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_cgetc, 0, 0, 0, 0, 0);
  8011f9:	6a 00                	push   $0x0
  8011fb:	6a 00                	push   $0x0
  8011fd:	6a 00                	push   $0x0
  8011ff:	6a 00                	push   $0x0
  801201:	6a 00                	push   $0x0
  801203:	6a 01                	push   $0x1
  801205:	e8 98 ff ff ff       	call   8011a2 <syscall>
  80120a:	83 c4 18             	add    $0x18,%esp
}
  80120d:	c9                   	leave  
  80120e:	c3                   	ret    

0080120f <sys_env_destroy>:

int sys_env_destroy(int32  envid)
{
  80120f:	55                   	push   %ebp
  801210:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_env_destroy, envid, 0, 0, 0, 0);
  801212:	8b 45 08             	mov    0x8(%ebp),%eax
  801215:	6a 00                	push   $0x0
  801217:	6a 00                	push   $0x0
  801219:	6a 00                	push   $0x0
  80121b:	6a 00                	push   $0x0
  80121d:	50                   	push   %eax
  80121e:	6a 05                	push   $0x5
  801220:	e8 7d ff ff ff       	call   8011a2 <syscall>
  801225:	83 c4 18             	add    $0x18,%esp
}
  801228:	c9                   	leave  
  801229:	c3                   	ret    

0080122a <sys_getenvid>:

int32 sys_getenvid(void)
{
  80122a:	55                   	push   %ebp
  80122b:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvid, 0, 0, 0, 0, 0);
  80122d:	6a 00                	push   $0x0
  80122f:	6a 00                	push   $0x0
  801231:	6a 00                	push   $0x0
  801233:	6a 00                	push   $0x0
  801235:	6a 00                	push   $0x0
  801237:	6a 02                	push   $0x2
  801239:	e8 64 ff ff ff       	call   8011a2 <syscall>
  80123e:	83 c4 18             	add    $0x18,%esp
}
  801241:	c9                   	leave  
  801242:	c3                   	ret    

00801243 <sys_getenvindex>:

//2017
int32 sys_getenvindex(void)
{
  801243:	55                   	push   %ebp
  801244:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getenvindex, 0, 0, 0, 0, 0);
  801246:	6a 00                	push   $0x0
  801248:	6a 00                	push   $0x0
  80124a:	6a 00                	push   $0x0
  80124c:	6a 00                	push   $0x0
  80124e:	6a 00                	push   $0x0
  801250:	6a 03                	push   $0x3
  801252:	e8 4b ff ff ff       	call   8011a2 <syscall>
  801257:	83 c4 18             	add    $0x18,%esp
}
  80125a:	c9                   	leave  
  80125b:	c3                   	ret    

0080125c <sys_getparentenvid>:

int32 sys_getparentenvid(void)
{
  80125c:	55                   	push   %ebp
  80125d:	89 e5                	mov    %esp,%ebp
	 return syscall(SYS_getparentenvid, 0, 0, 0, 0, 0);
  80125f:	6a 00                	push   $0x0
  801261:	6a 00                	push   $0x0
  801263:	6a 00                	push   $0x0
  801265:	6a 00                	push   $0x0
  801267:	6a 00                	push   $0x0
  801269:	6a 04                	push   $0x4
  80126b:	e8 32 ff ff ff       	call   8011a2 <syscall>
  801270:	83 c4 18             	add    $0x18,%esp
}
  801273:	c9                   	leave  
  801274:	c3                   	ret    

00801275 <sys_env_exit>:


void sys_env_exit(void)
{
  801275:	55                   	push   %ebp
  801276:	89 e5                	mov    %esp,%ebp
	syscall(SYS_env_exit, 0, 0, 0, 0, 0);
  801278:	6a 00                	push   $0x0
  80127a:	6a 00                	push   $0x0
  80127c:	6a 00                	push   $0x0
  80127e:	6a 00                	push   $0x0
  801280:	6a 00                	push   $0x0
  801282:	6a 06                	push   $0x6
  801284:	e8 19 ff ff ff       	call   8011a2 <syscall>
  801289:	83 c4 18             	add    $0x18,%esp
}
  80128c:	90                   	nop
  80128d:	c9                   	leave  
  80128e:	c3                   	ret    

0080128f <__sys_allocate_page>:


int __sys_allocate_page(void *va, int perm)
{
  80128f:	55                   	push   %ebp
  801290:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_allocate_page, (uint32) va, perm, 0 , 0, 0);
  801292:	8b 55 0c             	mov    0xc(%ebp),%edx
  801295:	8b 45 08             	mov    0x8(%ebp),%eax
  801298:	6a 00                	push   $0x0
  80129a:	6a 00                	push   $0x0
  80129c:	6a 00                	push   $0x0
  80129e:	52                   	push   %edx
  80129f:	50                   	push   %eax
  8012a0:	6a 07                	push   $0x7
  8012a2:	e8 fb fe ff ff       	call   8011a2 <syscall>
  8012a7:	83 c4 18             	add    $0x18,%esp
}
  8012aa:	c9                   	leave  
  8012ab:	c3                   	ret    

008012ac <__sys_map_frame>:

int __sys_map_frame(int32 srcenv, void *srcva, int32 dstenv, void *dstva, int perm)
{
  8012ac:	55                   	push   %ebp
  8012ad:	89 e5                	mov    %esp,%ebp
  8012af:	56                   	push   %esi
  8012b0:	53                   	push   %ebx
	return syscall(SYS_map_frame, srcenv, (uint32) srcva, dstenv, (uint32) dstva, perm);
  8012b1:	8b 75 18             	mov    0x18(%ebp),%esi
  8012b4:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8012b7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8012ba:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012bd:	8b 45 08             	mov    0x8(%ebp),%eax
  8012c0:	56                   	push   %esi
  8012c1:	53                   	push   %ebx
  8012c2:	51                   	push   %ecx
  8012c3:	52                   	push   %edx
  8012c4:	50                   	push   %eax
  8012c5:	6a 08                	push   $0x8
  8012c7:	e8 d6 fe ff ff       	call   8011a2 <syscall>
  8012cc:	83 c4 18             	add    $0x18,%esp
}
  8012cf:	8d 65 f8             	lea    -0x8(%ebp),%esp
  8012d2:	5b                   	pop    %ebx
  8012d3:	5e                   	pop    %esi
  8012d4:	5d                   	pop    %ebp
  8012d5:	c3                   	ret    

008012d6 <__sys_unmap_frame>:

int __sys_unmap_frame(int32 envid, void *va)
{
  8012d6:	55                   	push   %ebp
  8012d7:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_unmap_frame, envid, (uint32) va, 0, 0, 0);
  8012d9:	8b 55 0c             	mov    0xc(%ebp),%edx
  8012dc:	8b 45 08             	mov    0x8(%ebp),%eax
  8012df:	6a 00                	push   $0x0
  8012e1:	6a 00                	push   $0x0
  8012e3:	6a 00                	push   $0x0
  8012e5:	52                   	push   %edx
  8012e6:	50                   	push   %eax
  8012e7:	6a 09                	push   $0x9
  8012e9:	e8 b4 fe ff ff       	call   8011a2 <syscall>
  8012ee:	83 c4 18             	add    $0x18,%esp
}
  8012f1:	c9                   	leave  
  8012f2:	c3                   	ret    

008012f3 <sys_calculate_required_frames>:

uint32 sys_calculate_required_frames(uint32 start_virtual_address, uint32 size)
{
  8012f3:	55                   	push   %ebp
  8012f4:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_req_frames, start_virtual_address, (uint32) size, 0, 0, 0);
  8012f6:	6a 00                	push   $0x0
  8012f8:	6a 00                	push   $0x0
  8012fa:	6a 00                	push   $0x0
  8012fc:	ff 75 0c             	pushl  0xc(%ebp)
  8012ff:	ff 75 08             	pushl  0x8(%ebp)
  801302:	6a 0a                	push   $0xa
  801304:	e8 99 fe ff ff       	call   8011a2 <syscall>
  801309:	83 c4 18             	add    $0x18,%esp
}
  80130c:	c9                   	leave  
  80130d:	c3                   	ret    

0080130e <sys_calculate_free_frames>:

uint32 sys_calculate_free_frames()
{
  80130e:	55                   	push   %ebp
  80130f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_free_frames, 0, 0, 0, 0, 0);
  801311:	6a 00                	push   $0x0
  801313:	6a 00                	push   $0x0
  801315:	6a 00                	push   $0x0
  801317:	6a 00                	push   $0x0
  801319:	6a 00                	push   $0x0
  80131b:	6a 0b                	push   $0xb
  80131d:	e8 80 fe ff ff       	call   8011a2 <syscall>
  801322:	83 c4 18             	add    $0x18,%esp
}
  801325:	c9                   	leave  
  801326:	c3                   	ret    

00801327 <sys_calculate_modified_frames>:
uint32 sys_calculate_modified_frames()
{
  801327:	55                   	push   %ebp
  801328:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_modified_frames, 0, 0, 0, 0, 0);
  80132a:	6a 00                	push   $0x0
  80132c:	6a 00                	push   $0x0
  80132e:	6a 00                	push   $0x0
  801330:	6a 00                	push   $0x0
  801332:	6a 00                	push   $0x0
  801334:	6a 0c                	push   $0xc
  801336:	e8 67 fe ff ff       	call   8011a2 <syscall>
  80133b:	83 c4 18             	add    $0x18,%esp
}
  80133e:	c9                   	leave  
  80133f:	c3                   	ret    

00801340 <sys_calculate_notmod_frames>:

uint32 sys_calculate_notmod_frames()
{
  801340:	55                   	push   %ebp
  801341:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calc_notmod_frames, 0, 0, 0, 0, 0);
  801343:	6a 00                	push   $0x0
  801345:	6a 00                	push   $0x0
  801347:	6a 00                	push   $0x0
  801349:	6a 00                	push   $0x0
  80134b:	6a 00                	push   $0x0
  80134d:	6a 0d                	push   $0xd
  80134f:	e8 4e fe ff ff       	call   8011a2 <syscall>
  801354:	83 c4 18             	add    $0x18,%esp
}
  801357:	c9                   	leave  
  801358:	c3                   	ret    

00801359 <sys_freeMem>:

void sys_freeMem(uint32 virtual_address, uint32 size)
{
  801359:	55                   	push   %ebp
  80135a:	89 e5                	mov    %esp,%ebp
	syscall(SYS_freeMem, virtual_address, size, 0, 0, 0);
  80135c:	6a 00                	push   $0x0
  80135e:	6a 00                	push   $0x0
  801360:	6a 00                	push   $0x0
  801362:	ff 75 0c             	pushl  0xc(%ebp)
  801365:	ff 75 08             	pushl  0x8(%ebp)
  801368:	6a 11                	push   $0x11
  80136a:	e8 33 fe ff ff       	call   8011a2 <syscall>
  80136f:	83 c4 18             	add    $0x18,%esp
	return;
  801372:	90                   	nop
}
  801373:	c9                   	leave  
  801374:	c3                   	ret    

00801375 <sys_allocateMem>:

void sys_allocateMem(uint32 virtual_address, uint32 size)
{
  801375:	55                   	push   %ebp
  801376:	89 e5                	mov    %esp,%ebp
	syscall(SYS_allocateMem, virtual_address, size, 0, 0, 0);
  801378:	6a 00                	push   $0x0
  80137a:	6a 00                	push   $0x0
  80137c:	6a 00                	push   $0x0
  80137e:	ff 75 0c             	pushl  0xc(%ebp)
  801381:	ff 75 08             	pushl  0x8(%ebp)
  801384:	6a 12                	push   $0x12
  801386:	e8 17 fe ff ff       	call   8011a2 <syscall>
  80138b:	83 c4 18             	add    $0x18,%esp
	return ;
  80138e:	90                   	nop
}
  80138f:	c9                   	leave  
  801390:	c3                   	ret    

00801391 <sys_pf_calculate_allocated_pages>:

int sys_pf_calculate_allocated_pages()
{
  801391:	55                   	push   %ebp
  801392:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_pf_calc_allocated_pages, 0,0,0,0,0);
  801394:	6a 00                	push   $0x0
  801396:	6a 00                	push   $0x0
  801398:	6a 00                	push   $0x0
  80139a:	6a 00                	push   $0x0
  80139c:	6a 00                	push   $0x0
  80139e:	6a 0e                	push   $0xe
  8013a0:	e8 fd fd ff ff       	call   8011a2 <syscall>
  8013a5:	83 c4 18             	add    $0x18,%esp
}
  8013a8:	c9                   	leave  
  8013a9:	c3                   	ret    

008013aa <sys_calculate_pages_tobe_removed_ready_exit>:

int sys_calculate_pages_tobe_removed_ready_exit(uint32 WS_or_MEMORY_flag)
{
  8013aa:	55                   	push   %ebp
  8013ab:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_calculate_pages_tobe_removed_ready_exit, WS_or_MEMORY_flag,0,0,0,0);
  8013ad:	6a 00                	push   $0x0
  8013af:	6a 00                	push   $0x0
  8013b1:	6a 00                	push   $0x0
  8013b3:	6a 00                	push   $0x0
  8013b5:	ff 75 08             	pushl  0x8(%ebp)
  8013b8:	6a 0f                	push   $0xf
  8013ba:	e8 e3 fd ff ff       	call   8011a2 <syscall>
  8013bf:	83 c4 18             	add    $0x18,%esp
}
  8013c2:	c9                   	leave  
  8013c3:	c3                   	ret    

008013c4 <sys_scarce_memory>:

void sys_scarce_memory()
{
  8013c4:	55                   	push   %ebp
  8013c5:	89 e5                	mov    %esp,%ebp
	syscall(SYS_scarce_memory,0,0,0,0,0);
  8013c7:	6a 00                	push   $0x0
  8013c9:	6a 00                	push   $0x0
  8013cb:	6a 00                	push   $0x0
  8013cd:	6a 00                	push   $0x0
  8013cf:	6a 00                	push   $0x0
  8013d1:	6a 10                	push   $0x10
  8013d3:	e8 ca fd ff ff       	call   8011a2 <syscall>
  8013d8:	83 c4 18             	add    $0x18,%esp
}
  8013db:	90                   	nop
  8013dc:	c9                   	leave  
  8013dd:	c3                   	ret    

008013de <sys_disable_interrupt>:

//NEW !! 2012...
void
sys_disable_interrupt()
{
  8013de:	55                   	push   %ebp
  8013df:	89 e5                	mov    %esp,%ebp
	syscall(SYS_disableINTR,0, 0, 0, 0, 0);
  8013e1:	6a 00                	push   $0x0
  8013e3:	6a 00                	push   $0x0
  8013e5:	6a 00                	push   $0x0
  8013e7:	6a 00                	push   $0x0
  8013e9:	6a 00                	push   $0x0
  8013eb:	6a 14                	push   $0x14
  8013ed:	e8 b0 fd ff ff       	call   8011a2 <syscall>
  8013f2:	83 c4 18             	add    $0x18,%esp
}
  8013f5:	90                   	nop
  8013f6:	c9                   	leave  
  8013f7:	c3                   	ret    

008013f8 <sys_enable_interrupt>:


void
sys_enable_interrupt()
{
  8013f8:	55                   	push   %ebp
  8013f9:	89 e5                	mov    %esp,%ebp
	syscall(SYS_enableINTR,0, 0, 0, 0, 0);
  8013fb:	6a 00                	push   $0x0
  8013fd:	6a 00                	push   $0x0
  8013ff:	6a 00                	push   $0x0
  801401:	6a 00                	push   $0x0
  801403:	6a 00                	push   $0x0
  801405:	6a 15                	push   $0x15
  801407:	e8 96 fd ff ff       	call   8011a2 <syscall>
  80140c:	83 c4 18             	add    $0x18,%esp
}
  80140f:	90                   	nop
  801410:	c9                   	leave  
  801411:	c3                   	ret    

00801412 <sys_cputc>:


void
sys_cputc(const char c)
{
  801412:	55                   	push   %ebp
  801413:	89 e5                	mov    %esp,%ebp
  801415:	83 ec 04             	sub    $0x4,%esp
  801418:	8b 45 08             	mov    0x8(%ebp),%eax
  80141b:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_cputc, (uint32) c, 0, 0, 0, 0);
  80141e:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801422:	6a 00                	push   $0x0
  801424:	6a 00                	push   $0x0
  801426:	6a 00                	push   $0x0
  801428:	6a 00                	push   $0x0
  80142a:	50                   	push   %eax
  80142b:	6a 16                	push   $0x16
  80142d:	e8 70 fd ff ff       	call   8011a2 <syscall>
  801432:	83 c4 18             	add    $0x18,%esp
}
  801435:	90                   	nop
  801436:	c9                   	leave  
  801437:	c3                   	ret    

00801438 <sys_clear_ffl>:


//NEW'12: BONUS2 Testing
void
sys_clear_ffl()
{
  801438:	55                   	push   %ebp
  801439:	89 e5                	mov    %esp,%ebp
	syscall(SYS_clearFFL,0, 0, 0, 0, 0);
  80143b:	6a 00                	push   $0x0
  80143d:	6a 00                	push   $0x0
  80143f:	6a 00                	push   $0x0
  801441:	6a 00                	push   $0x0
  801443:	6a 00                	push   $0x0
  801445:	6a 17                	push   $0x17
  801447:	e8 56 fd ff ff       	call   8011a2 <syscall>
  80144c:	83 c4 18             	add    $0x18,%esp
}
  80144f:	90                   	nop
  801450:	c9                   	leave  
  801451:	c3                   	ret    

00801452 <sys_createSemaphore>:

int
sys_createSemaphore(char* semaphoreName, uint32 initialValue)
{
  801452:	55                   	push   %ebp
  801453:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_semaphore,(uint32)semaphoreName, (uint32)initialValue, 0, 0, 0);
  801455:	8b 45 08             	mov    0x8(%ebp),%eax
  801458:	6a 00                	push   $0x0
  80145a:	6a 00                	push   $0x0
  80145c:	6a 00                	push   $0x0
  80145e:	ff 75 0c             	pushl  0xc(%ebp)
  801461:	50                   	push   %eax
  801462:	6a 18                	push   $0x18
  801464:	e8 39 fd ff ff       	call   8011a2 <syscall>
  801469:	83 c4 18             	add    $0x18,%esp
}
  80146c:	c9                   	leave  
  80146d:	c3                   	ret    

0080146e <sys_getSemaphoreValue>:

int
sys_getSemaphoreValue(int32 ownerEnvID, char* semaphoreName)
{
  80146e:	55                   	push   %ebp
  80146f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_semaphore_value,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  801471:	8b 55 0c             	mov    0xc(%ebp),%edx
  801474:	8b 45 08             	mov    0x8(%ebp),%eax
  801477:	6a 00                	push   $0x0
  801479:	6a 00                	push   $0x0
  80147b:	6a 00                	push   $0x0
  80147d:	52                   	push   %edx
  80147e:	50                   	push   %eax
  80147f:	6a 1b                	push   $0x1b
  801481:	e8 1c fd ff ff       	call   8011a2 <syscall>
  801486:	83 c4 18             	add    $0x18,%esp
}
  801489:	c9                   	leave  
  80148a:	c3                   	ret    

0080148b <sys_waitSemaphore>:

void
sys_waitSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  80148b:	55                   	push   %ebp
  80148c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_wait_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  80148e:	8b 55 0c             	mov    0xc(%ebp),%edx
  801491:	8b 45 08             	mov    0x8(%ebp),%eax
  801494:	6a 00                	push   $0x0
  801496:	6a 00                	push   $0x0
  801498:	6a 00                	push   $0x0
  80149a:	52                   	push   %edx
  80149b:	50                   	push   %eax
  80149c:	6a 19                	push   $0x19
  80149e:	e8 ff fc ff ff       	call   8011a2 <syscall>
  8014a3:	83 c4 18             	add    $0x18,%esp
}
  8014a6:	90                   	nop
  8014a7:	c9                   	leave  
  8014a8:	c3                   	ret    

008014a9 <sys_signalSemaphore>:

void
sys_signalSemaphore(int32 ownerEnvID, char* semaphoreName)
{
  8014a9:	55                   	push   %ebp
  8014aa:	89 e5                	mov    %esp,%ebp
	syscall(SYS_signal_semaphore,(uint32) ownerEnvID, (uint32)semaphoreName, 0, 0, 0);
  8014ac:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014af:	8b 45 08             	mov    0x8(%ebp),%eax
  8014b2:	6a 00                	push   $0x0
  8014b4:	6a 00                	push   $0x0
  8014b6:	6a 00                	push   $0x0
  8014b8:	52                   	push   %edx
  8014b9:	50                   	push   %eax
  8014ba:	6a 1a                	push   $0x1a
  8014bc:	e8 e1 fc ff ff       	call   8011a2 <syscall>
  8014c1:	83 c4 18             	add    $0x18,%esp
}
  8014c4:	90                   	nop
  8014c5:	c9                   	leave  
  8014c6:	c3                   	ret    

008014c7 <sys_createSharedObject>:

int
sys_createSharedObject(char* shareName, uint32 size, uint8 isWritable, void* virtual_address)
{
  8014c7:	55                   	push   %ebp
  8014c8:	89 e5                	mov    %esp,%ebp
  8014ca:	83 ec 04             	sub    $0x4,%esp
  8014cd:	8b 45 10             	mov    0x10(%ebp),%eax
  8014d0:	88 45 fc             	mov    %al,-0x4(%ebp)
	return syscall(SYS_create_shared_object,(uint32)shareName, (uint32)size, isWritable, (uint32)virtual_address,  0);
  8014d3:	8b 4d 14             	mov    0x14(%ebp),%ecx
  8014d6:	0f b6 55 fc          	movzbl -0x4(%ebp),%edx
  8014da:	8b 45 08             	mov    0x8(%ebp),%eax
  8014dd:	6a 00                	push   $0x0
  8014df:	51                   	push   %ecx
  8014e0:	52                   	push   %edx
  8014e1:	ff 75 0c             	pushl  0xc(%ebp)
  8014e4:	50                   	push   %eax
  8014e5:	6a 1c                	push   $0x1c
  8014e7:	e8 b6 fc ff ff       	call   8011a2 <syscall>
  8014ec:	83 c4 18             	add    $0x18,%esp
}
  8014ef:	c9                   	leave  
  8014f0:	c3                   	ret    

008014f1 <sys_getSizeOfSharedObject>:

//2017:
int
sys_getSizeOfSharedObject(int32 ownerID, char* shareName)
{
  8014f1:	55                   	push   %ebp
  8014f2:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_size_of_shared_object,(uint32) ownerID, (uint32)shareName, 0, 0, 0);
  8014f4:	8b 55 0c             	mov    0xc(%ebp),%edx
  8014f7:	8b 45 08             	mov    0x8(%ebp),%eax
  8014fa:	6a 00                	push   $0x0
  8014fc:	6a 00                	push   $0x0
  8014fe:	6a 00                	push   $0x0
  801500:	52                   	push   %edx
  801501:	50                   	push   %eax
  801502:	6a 1d                	push   $0x1d
  801504:	e8 99 fc ff ff       	call   8011a2 <syscall>
  801509:	83 c4 18             	add    $0x18,%esp
}
  80150c:	c9                   	leave  
  80150d:	c3                   	ret    

0080150e <sys_getSharedObject>:
//==========

int
sys_getSharedObject(int32 ownerID, char* shareName, void* virtual_address)
{
  80150e:	55                   	push   %ebp
  80150f:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_shared_object,(uint32) ownerID, (uint32)shareName, (uint32)virtual_address, 0, 0);
  801511:	8b 4d 10             	mov    0x10(%ebp),%ecx
  801514:	8b 55 0c             	mov    0xc(%ebp),%edx
  801517:	8b 45 08             	mov    0x8(%ebp),%eax
  80151a:	6a 00                	push   $0x0
  80151c:	6a 00                	push   $0x0
  80151e:	51                   	push   %ecx
  80151f:	52                   	push   %edx
  801520:	50                   	push   %eax
  801521:	6a 1e                	push   $0x1e
  801523:	e8 7a fc ff ff       	call   8011a2 <syscall>
  801528:	83 c4 18             	add    $0x18,%esp
}
  80152b:	c9                   	leave  
  80152c:	c3                   	ret    

0080152d <sys_freeSharedObject>:

int
sys_freeSharedObject(int32 sharedObjectID, void *startVA)
{
  80152d:	55                   	push   %ebp
  80152e:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_free_shared_object,(uint32) sharedObjectID, (uint32) startVA, 0, 0, 0);
  801530:	8b 55 0c             	mov    0xc(%ebp),%edx
  801533:	8b 45 08             	mov    0x8(%ebp),%eax
  801536:	6a 00                	push   $0x0
  801538:	6a 00                	push   $0x0
  80153a:	6a 00                	push   $0x0
  80153c:	52                   	push   %edx
  80153d:	50                   	push   %eax
  80153e:	6a 1f                	push   $0x1f
  801540:	e8 5d fc ff ff       	call   8011a2 <syscall>
  801545:	83 c4 18             	add    $0x18,%esp
}
  801548:	c9                   	leave  
  801549:	c3                   	ret    

0080154a <sys_getMaxShares>:

uint32 	sys_getMaxShares()
{
  80154a:	55                   	push   %ebp
  80154b:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_get_max_shares,0, 0, 0, 0, 0);
  80154d:	6a 00                	push   $0x0
  80154f:	6a 00                	push   $0x0
  801551:	6a 00                	push   $0x0
  801553:	6a 00                	push   $0x0
  801555:	6a 00                	push   $0x0
  801557:	6a 20                	push   $0x20
  801559:	e8 44 fc ff ff       	call   8011a2 <syscall>
  80155e:	83 c4 18             	add    $0x18,%esp
}
  801561:	c9                   	leave  
  801562:	c3                   	ret    

00801563 <sys_create_env>:

int sys_create_env(char* programName, unsigned int page_WS_size,unsigned int LRU_second_list_size,unsigned int percent_WS_pages_to_remove)
{
  801563:	55                   	push   %ebp
  801564:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_create_env,(uint32)programName, (uint32)page_WS_size,(uint32)LRU_second_list_size, (uint32)percent_WS_pages_to_remove, 0);
  801566:	8b 45 08             	mov    0x8(%ebp),%eax
  801569:	6a 00                	push   $0x0
  80156b:	ff 75 14             	pushl  0x14(%ebp)
  80156e:	ff 75 10             	pushl  0x10(%ebp)
  801571:	ff 75 0c             	pushl  0xc(%ebp)
  801574:	50                   	push   %eax
  801575:	6a 21                	push   $0x21
  801577:	e8 26 fc ff ff       	call   8011a2 <syscall>
  80157c:	83 c4 18             	add    $0x18,%esp
}
  80157f:	c9                   	leave  
  801580:	c3                   	ret    

00801581 <sys_run_env>:


void
sys_run_env(int32 envId)
{
  801581:	55                   	push   %ebp
  801582:	89 e5                	mov    %esp,%ebp
	syscall(SYS_run_env, (int32)envId, 0, 0, 0, 0);
  801584:	8b 45 08             	mov    0x8(%ebp),%eax
  801587:	6a 00                	push   $0x0
  801589:	6a 00                	push   $0x0
  80158b:	6a 00                	push   $0x0
  80158d:	6a 00                	push   $0x0
  80158f:	50                   	push   %eax
  801590:	6a 22                	push   $0x22
  801592:	e8 0b fc ff ff       	call   8011a2 <syscall>
  801597:	83 c4 18             	add    $0x18,%esp
}
  80159a:	90                   	nop
  80159b:	c9                   	leave  
  80159c:	c3                   	ret    

0080159d <sys_free_env>:

void
sys_free_env(int32 envId)
{
  80159d:	55                   	push   %ebp
  80159e:	89 e5                	mov    %esp,%ebp
	syscall(SYS_free_env, (int32)envId, 0, 0, 0, 0);
  8015a0:	8b 45 08             	mov    0x8(%ebp),%eax
  8015a3:	6a 00                	push   $0x0
  8015a5:	6a 00                	push   $0x0
  8015a7:	6a 00                	push   $0x0
  8015a9:	6a 00                	push   $0x0
  8015ab:	50                   	push   %eax
  8015ac:	6a 23                	push   $0x23
  8015ae:	e8 ef fb ff ff       	call   8011a2 <syscall>
  8015b3:	83 c4 18             	add    $0x18,%esp
}
  8015b6:	90                   	nop
  8015b7:	c9                   	leave  
  8015b8:	c3                   	ret    

008015b9 <sys_get_virtual_time>:

struct uint64
sys_get_virtual_time()
{
  8015b9:	55                   	push   %ebp
  8015ba:	89 e5                	mov    %esp,%ebp
  8015bc:	83 ec 10             	sub    $0x10,%esp
	struct uint64 result;
	syscall(SYS_get_virtual_time, (uint32)&(result.low), (uint32)&(result.hi), 0, 0, 0);
  8015bf:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015c2:	8d 50 04             	lea    0x4(%eax),%edx
  8015c5:	8d 45 f8             	lea    -0x8(%ebp),%eax
  8015c8:	6a 00                	push   $0x0
  8015ca:	6a 00                	push   $0x0
  8015cc:	6a 00                	push   $0x0
  8015ce:	52                   	push   %edx
  8015cf:	50                   	push   %eax
  8015d0:	6a 24                	push   $0x24
  8015d2:	e8 cb fb ff ff       	call   8011a2 <syscall>
  8015d7:	83 c4 18             	add    $0x18,%esp
	return result;
  8015da:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8015dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
  8015e0:	8b 55 fc             	mov    -0x4(%ebp),%edx
  8015e3:	89 01                	mov    %eax,(%ecx)
  8015e5:	89 51 04             	mov    %edx,0x4(%ecx)
}
  8015e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8015eb:	c9                   	leave  
  8015ec:	c2 04 00             	ret    $0x4

008015ef <sys_moveMem>:

// 2014
void sys_moveMem(uint32 src_virtual_address, uint32 dst_virtual_address, uint32 size)
{
  8015ef:	55                   	push   %ebp
  8015f0:	89 e5                	mov    %esp,%ebp
	syscall(SYS_moveMem, src_virtual_address, dst_virtual_address, size, 0, 0);
  8015f2:	6a 00                	push   $0x0
  8015f4:	6a 00                	push   $0x0
  8015f6:	ff 75 10             	pushl  0x10(%ebp)
  8015f9:	ff 75 0c             	pushl  0xc(%ebp)
  8015fc:	ff 75 08             	pushl  0x8(%ebp)
  8015ff:	6a 13                	push   $0x13
  801601:	e8 9c fb ff ff       	call   8011a2 <syscall>
  801606:	83 c4 18             	add    $0x18,%esp
	return ;
  801609:	90                   	nop
}
  80160a:	c9                   	leave  
  80160b:	c3                   	ret    

0080160c <sys_rcr2>:
uint32 sys_rcr2()
{
  80160c:	55                   	push   %ebp
  80160d:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_rcr2, 0, 0, 0, 0, 0);
  80160f:	6a 00                	push   $0x0
  801611:	6a 00                	push   $0x0
  801613:	6a 00                	push   $0x0
  801615:	6a 00                	push   $0x0
  801617:	6a 00                	push   $0x0
  801619:	6a 25                	push   $0x25
  80161b:	e8 82 fb ff ff       	call   8011a2 <syscall>
  801620:	83 c4 18             	add    $0x18,%esp
}
  801623:	c9                   	leave  
  801624:	c3                   	ret    

00801625 <sys_bypassPageFault>:
void sys_bypassPageFault(uint8 instrLength)
{
  801625:	55                   	push   %ebp
  801626:	89 e5                	mov    %esp,%ebp
  801628:	83 ec 04             	sub    $0x4,%esp
  80162b:	8b 45 08             	mov    0x8(%ebp),%eax
  80162e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_bypassPageFault, instrLength, 0, 0, 0, 0);
  801631:	0f b6 45 fc          	movzbl -0x4(%ebp),%eax
  801635:	6a 00                	push   $0x0
  801637:	6a 00                	push   $0x0
  801639:	6a 00                	push   $0x0
  80163b:	6a 00                	push   $0x0
  80163d:	50                   	push   %eax
  80163e:	6a 26                	push   $0x26
  801640:	e8 5d fb ff ff       	call   8011a2 <syscall>
  801645:	83 c4 18             	add    $0x18,%esp
	return ;
  801648:	90                   	nop
}
  801649:	c9                   	leave  
  80164a:	c3                   	ret    

0080164b <rsttst>:
void rsttst()
{
  80164b:	55                   	push   %ebp
  80164c:	89 e5                	mov    %esp,%ebp
	syscall(SYS_rsttst, 0, 0, 0, 0, 0);
  80164e:	6a 00                	push   $0x0
  801650:	6a 00                	push   $0x0
  801652:	6a 00                	push   $0x0
  801654:	6a 00                	push   $0x0
  801656:	6a 00                	push   $0x0
  801658:	6a 28                	push   $0x28
  80165a:	e8 43 fb ff ff       	call   8011a2 <syscall>
  80165f:	83 c4 18             	add    $0x18,%esp
	return ;
  801662:	90                   	nop
}
  801663:	c9                   	leave  
  801664:	c3                   	ret    

00801665 <tst>:
void tst(uint32 n, uint32 v1, uint32 v2, char c, int inv)
{
  801665:	55                   	push   %ebp
  801666:	89 e5                	mov    %esp,%ebp
  801668:	83 ec 04             	sub    $0x4,%esp
  80166b:	8b 45 14             	mov    0x14(%ebp),%eax
  80166e:	88 45 fc             	mov    %al,-0x4(%ebp)
	syscall(SYS_testNum, n, v1, v2, c, inv);
  801671:	8b 55 18             	mov    0x18(%ebp),%edx
  801674:	0f be 45 fc          	movsbl -0x4(%ebp),%eax
  801678:	52                   	push   %edx
  801679:	50                   	push   %eax
  80167a:	ff 75 10             	pushl  0x10(%ebp)
  80167d:	ff 75 0c             	pushl  0xc(%ebp)
  801680:	ff 75 08             	pushl  0x8(%ebp)
  801683:	6a 27                	push   $0x27
  801685:	e8 18 fb ff ff       	call   8011a2 <syscall>
  80168a:	83 c4 18             	add    $0x18,%esp
	return ;
  80168d:	90                   	nop
}
  80168e:	c9                   	leave  
  80168f:	c3                   	ret    

00801690 <chktst>:
void chktst(uint32 n)
{
  801690:	55                   	push   %ebp
  801691:	89 e5                	mov    %esp,%ebp
	syscall(SYS_chktst, n, 0, 0, 0, 0);
  801693:	6a 00                	push   $0x0
  801695:	6a 00                	push   $0x0
  801697:	6a 00                	push   $0x0
  801699:	6a 00                	push   $0x0
  80169b:	ff 75 08             	pushl  0x8(%ebp)
  80169e:	6a 29                	push   $0x29
  8016a0:	e8 fd fa ff ff       	call   8011a2 <syscall>
  8016a5:	83 c4 18             	add    $0x18,%esp
	return ;
  8016a8:	90                   	nop
}
  8016a9:	c9                   	leave  
  8016aa:	c3                   	ret    

008016ab <inctst>:

void inctst()
{
  8016ab:	55                   	push   %ebp
  8016ac:	89 e5                	mov    %esp,%ebp
	syscall(SYS_inctst, 0, 0, 0, 0, 0);
  8016ae:	6a 00                	push   $0x0
  8016b0:	6a 00                	push   $0x0
  8016b2:	6a 00                	push   $0x0
  8016b4:	6a 00                	push   $0x0
  8016b6:	6a 00                	push   $0x0
  8016b8:	6a 2a                	push   $0x2a
  8016ba:	e8 e3 fa ff ff       	call   8011a2 <syscall>
  8016bf:	83 c4 18             	add    $0x18,%esp
	return ;
  8016c2:	90                   	nop
}
  8016c3:	c9                   	leave  
  8016c4:	c3                   	ret    

008016c5 <gettst>:
uint32 gettst()
{
  8016c5:	55                   	push   %ebp
  8016c6:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_gettst, 0, 0, 0, 0, 0);
  8016c8:	6a 00                	push   $0x0
  8016ca:	6a 00                	push   $0x0
  8016cc:	6a 00                	push   $0x0
  8016ce:	6a 00                	push   $0x0
  8016d0:	6a 00                	push   $0x0
  8016d2:	6a 2b                	push   $0x2b
  8016d4:	e8 c9 fa ff ff       	call   8011a2 <syscall>
  8016d9:	83 c4 18             	add    $0x18,%esp
}
  8016dc:	c9                   	leave  
  8016dd:	c3                   	ret    

008016de <sys_isUHeapPlacementStrategyFIRSTFIT>:


//2015
uint32 sys_isUHeapPlacementStrategyFIRSTFIT()
{
  8016de:	55                   	push   %ebp
  8016df:	89 e5                	mov    %esp,%ebp
  8016e1:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  8016e4:	6a 00                	push   $0x0
  8016e6:	6a 00                	push   $0x0
  8016e8:	6a 00                	push   $0x0
  8016ea:	6a 00                	push   $0x0
  8016ec:	6a 00                	push   $0x0
  8016ee:	6a 2c                	push   $0x2c
  8016f0:	e8 ad fa ff ff       	call   8011a2 <syscall>
  8016f5:	83 c4 18             	add    $0x18,%esp
  8016f8:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_FIRSTFIT)
  8016fb:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
  8016ff:	75 07                	jne    801708 <sys_isUHeapPlacementStrategyFIRSTFIT+0x2a>
		return 1;
  801701:	b8 01 00 00 00       	mov    $0x1,%eax
  801706:	eb 05                	jmp    80170d <sys_isUHeapPlacementStrategyFIRSTFIT+0x2f>
	else
		return 0;
  801708:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80170d:	c9                   	leave  
  80170e:	c3                   	ret    

0080170f <sys_isUHeapPlacementStrategyBESTFIT>:
uint32 sys_isUHeapPlacementStrategyBESTFIT()
{
  80170f:	55                   	push   %ebp
  801710:	89 e5                	mov    %esp,%ebp
  801712:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801715:	6a 00                	push   $0x0
  801717:	6a 00                	push   $0x0
  801719:	6a 00                	push   $0x0
  80171b:	6a 00                	push   $0x0
  80171d:	6a 00                	push   $0x0
  80171f:	6a 2c                	push   $0x2c
  801721:	e8 7c fa ff ff       	call   8011a2 <syscall>
  801726:	83 c4 18             	add    $0x18,%esp
  801729:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_BESTFIT)
  80172c:	83 7d fc 02          	cmpl   $0x2,-0x4(%ebp)
  801730:	75 07                	jne    801739 <sys_isUHeapPlacementStrategyBESTFIT+0x2a>
		return 1;
  801732:	b8 01 00 00 00       	mov    $0x1,%eax
  801737:	eb 05                	jmp    80173e <sys_isUHeapPlacementStrategyBESTFIT+0x2f>
	else
		return 0;
  801739:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80173e:	c9                   	leave  
  80173f:	c3                   	ret    

00801740 <sys_isUHeapPlacementStrategyNEXTFIT>:
uint32 sys_isUHeapPlacementStrategyNEXTFIT()
{
  801740:	55                   	push   %ebp
  801741:	89 e5                	mov    %esp,%ebp
  801743:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801746:	6a 00                	push   $0x0
  801748:	6a 00                	push   $0x0
  80174a:	6a 00                	push   $0x0
  80174c:	6a 00                	push   $0x0
  80174e:	6a 00                	push   $0x0
  801750:	6a 2c                	push   $0x2c
  801752:	e8 4b fa ff ff       	call   8011a2 <syscall>
  801757:	83 c4 18             	add    $0x18,%esp
  80175a:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_NEXTFIT)
  80175d:	83 7d fc 03          	cmpl   $0x3,-0x4(%ebp)
  801761:	75 07                	jne    80176a <sys_isUHeapPlacementStrategyNEXTFIT+0x2a>
		return 1;
  801763:	b8 01 00 00 00       	mov    $0x1,%eax
  801768:	eb 05                	jmp    80176f <sys_isUHeapPlacementStrategyNEXTFIT+0x2f>
	else
		return 0;
  80176a:	b8 00 00 00 00       	mov    $0x0,%eax
}
  80176f:	c9                   	leave  
  801770:	c3                   	ret    

00801771 <sys_isUHeapPlacementStrategyWORSTFIT>:
uint32 sys_isUHeapPlacementStrategyWORSTFIT()
{
  801771:	55                   	push   %ebp
  801772:	89 e5                	mov    %esp,%ebp
  801774:	83 ec 10             	sub    $0x10,%esp
	uint32 ret = syscall(SYS_get_heap_strategy, 0, 0, 0, 0, 0);
  801777:	6a 00                	push   $0x0
  801779:	6a 00                	push   $0x0
  80177b:	6a 00                	push   $0x0
  80177d:	6a 00                	push   $0x0
  80177f:	6a 00                	push   $0x0
  801781:	6a 2c                	push   $0x2c
  801783:	e8 1a fa ff ff       	call   8011a2 <syscall>
  801788:	83 c4 18             	add    $0x18,%esp
  80178b:	89 45 fc             	mov    %eax,-0x4(%ebp)
	if (ret == UHP_PLACE_WORSTFIT)
  80178e:	83 7d fc 04          	cmpl   $0x4,-0x4(%ebp)
  801792:	75 07                	jne    80179b <sys_isUHeapPlacementStrategyWORSTFIT+0x2a>
		return 1;
  801794:	b8 01 00 00 00       	mov    $0x1,%eax
  801799:	eb 05                	jmp    8017a0 <sys_isUHeapPlacementStrategyWORSTFIT+0x2f>
	else
		return 0;
  80179b:	b8 00 00 00 00       	mov    $0x0,%eax
}
  8017a0:	c9                   	leave  
  8017a1:	c3                   	ret    

008017a2 <sys_set_uheap_strategy>:

void sys_set_uheap_strategy(uint32 heapStrategy)
{
  8017a2:	55                   	push   %ebp
  8017a3:	89 e5                	mov    %esp,%ebp
	syscall(SYS_set_heap_strategy, heapStrategy, 0, 0, 0, 0);
  8017a5:	6a 00                	push   $0x0
  8017a7:	6a 00                	push   $0x0
  8017a9:	6a 00                	push   $0x0
  8017ab:	6a 00                	push   $0x0
  8017ad:	ff 75 08             	pushl  0x8(%ebp)
  8017b0:	6a 2d                	push   $0x2d
  8017b2:	e8 eb f9 ff ff       	call   8011a2 <syscall>
  8017b7:	83 c4 18             	add    $0x18,%esp
	return ;
  8017ba:	90                   	nop
}
  8017bb:	c9                   	leave  
  8017bc:	c3                   	ret    

008017bd <sys_check_LRU_lists>:

//2020
int sys_check_LRU_lists(uint32* active_list_content, uint32* second_list_content, int actual_active_list_size, int actual_second_list_size)
{
  8017bd:	55                   	push   %ebp
  8017be:	89 e5                	mov    %esp,%ebp
  8017c0:	53                   	push   %ebx
	return syscall(SYS_check_LRU_lists, (uint32)active_list_content, (uint32)second_list_content, (uint32)actual_active_list_size, (uint32)actual_second_list_size, 0);
  8017c1:	8b 5d 14             	mov    0x14(%ebp),%ebx
  8017c4:	8b 4d 10             	mov    0x10(%ebp),%ecx
  8017c7:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017ca:	8b 45 08             	mov    0x8(%ebp),%eax
  8017cd:	6a 00                	push   $0x0
  8017cf:	53                   	push   %ebx
  8017d0:	51                   	push   %ecx
  8017d1:	52                   	push   %edx
  8017d2:	50                   	push   %eax
  8017d3:	6a 2e                	push   $0x2e
  8017d5:	e8 c8 f9 ff ff       	call   8011a2 <syscall>
  8017da:	83 c4 18             	add    $0x18,%esp
}
  8017dd:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  8017e0:	c9                   	leave  
  8017e1:	c3                   	ret    

008017e2 <sys_check_LRU_lists_free>:

int sys_check_LRU_lists_free(uint32* list_content, int list_size)
{
  8017e2:	55                   	push   %ebp
  8017e3:	89 e5                	mov    %esp,%ebp
	return syscall(SYS_check_LRU_lists_free, (uint32)list_content, (uint32)list_size , 0, 0, 0);
  8017e5:	8b 55 0c             	mov    0xc(%ebp),%edx
  8017e8:	8b 45 08             	mov    0x8(%ebp),%eax
  8017eb:	6a 00                	push   $0x0
  8017ed:	6a 00                	push   $0x0
  8017ef:	6a 00                	push   $0x0
  8017f1:	52                   	push   %edx
  8017f2:	50                   	push   %eax
  8017f3:	6a 2f                	push   $0x2f
  8017f5:	e8 a8 f9 ff ff       	call   8011a2 <syscall>
  8017fa:	83 c4 18             	add    $0x18,%esp
}
  8017fd:	c9                   	leave  
  8017fe:	c3                   	ret    

008017ff <sys_new>:


void sys_new(uint32 virtual_address, uint32 size)
{
  8017ff:	55                   	push   %ebp
  801800:	89 e5                	mov    %esp,%ebp
	syscall(SYS_new, virtual_address, size, 0, 0, 0);
  801802:	6a 00                	push   $0x0
  801804:	6a 00                	push   $0x0
  801806:	6a 00                	push   $0x0
  801808:	ff 75 0c             	pushl  0xc(%ebp)
  80180b:	ff 75 08             	pushl  0x8(%ebp)
  80180e:	6a 30                	push   $0x30
  801810:	e8 8d f9 ff ff       	call   8011a2 <syscall>
  801815:	83 c4 18             	add    $0x18,%esp
	return ;
  801818:	90                   	nop
}
  801819:	c9                   	leave  
  80181a:	c3                   	ret    

0080181b <_panic>:
 * It prints "panic: <message>", then causes a breakpoint exception,
 * which causes FOS to enter the FOS kernel monitor.
 */
void
_panic(const char *file, int line, const char *fmt,...)
{
  80181b:	55                   	push   %ebp
  80181c:	89 e5                	mov    %esp,%ebp
  80181e:	83 ec 18             	sub    $0x18,%esp
	va_list ap;
	va_start(ap, fmt);
  801821:	8d 45 10             	lea    0x10(%ebp),%eax
  801824:	83 c0 04             	add    $0x4,%eax
  801827:	89 45 f4             	mov    %eax,-0xc(%ebp)
	// Print the panic message
	if (argv0)
  80182a:	a1 18 31 80 00       	mov    0x803118,%eax
  80182f:	85 c0                	test   %eax,%eax
  801831:	74 16                	je     801849 <_panic+0x2e>
		cprintf("%s: ", argv0);
  801833:	a1 18 31 80 00       	mov    0x803118,%eax
  801838:	83 ec 08             	sub    $0x8,%esp
  80183b:	50                   	push   %eax
  80183c:	68 4c 21 80 00       	push   $0x80214c
  801841:	e8 e2 ea ff ff       	call   800328 <cprintf>
  801846:	83 c4 10             	add    $0x10,%esp
	cprintf("user panic in %s at %s:%d: ", binaryname, file, line);
  801849:	a1 00 30 80 00       	mov    0x803000,%eax
  80184e:	ff 75 0c             	pushl  0xc(%ebp)
  801851:	ff 75 08             	pushl  0x8(%ebp)
  801854:	50                   	push   %eax
  801855:	68 51 21 80 00       	push   $0x802151
  80185a:	e8 c9 ea ff ff       	call   800328 <cprintf>
  80185f:	83 c4 10             	add    $0x10,%esp
	vcprintf(fmt, ap);
  801862:	8b 45 10             	mov    0x10(%ebp),%eax
  801865:	83 ec 08             	sub    $0x8,%esp
  801868:	ff 75 f4             	pushl  -0xc(%ebp)
  80186b:	50                   	push   %eax
  80186c:	e8 4c ea ff ff       	call   8002bd <vcprintf>
  801871:	83 c4 10             	add    $0x10,%esp
	vcprintf("\n", NULL);
  801874:	83 ec 08             	sub    $0x8,%esp
  801877:	6a 00                	push   $0x0
  801879:	68 6d 21 80 00       	push   $0x80216d
  80187e:	e8 3a ea ff ff       	call   8002bd <vcprintf>
  801883:	83 c4 10             	add    $0x10,%esp
	// Cause a breakpoint exception
//	while (1);
//		asm volatile("int3");

	//2013: exit the panic env only
	exit() ;
  801886:	e8 bb e9 ff ff       	call   800246 <exit>

	// should not return here
	while (1) ;
  80188b:	eb fe                	jmp    80188b <_panic+0x70>

0080188d <CheckWSWithoutLastIndex>:
}

void CheckWSWithoutLastIndex(uint32 *expectedPages, int arraySize)
{
  80188d:	55                   	push   %ebp
  80188e:	89 e5                	mov    %esp,%ebp
  801890:	83 ec 28             	sub    $0x28,%esp
	if (arraySize != myEnv->page_WS_max_size)
  801893:	a1 20 30 80 00       	mov    0x803020,%eax
  801898:	8b 50 74             	mov    0x74(%eax),%edx
  80189b:	8b 45 0c             	mov    0xc(%ebp),%eax
  80189e:	39 c2                	cmp    %eax,%edx
  8018a0:	74 14                	je     8018b6 <CheckWSWithoutLastIndex+0x29>
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
  8018a2:	83 ec 04             	sub    $0x4,%esp
  8018a5:	68 70 21 80 00       	push   $0x802170
  8018aa:	6a 26                	push   $0x26
  8018ac:	68 bc 21 80 00       	push   $0x8021bc
  8018b1:	e8 65 ff ff ff       	call   80181b <_panic>
	}
	int expectedNumOfEmptyLocs = 0;
  8018b6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
	for (int e = 0; e < arraySize; e++) {
  8018bd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  8018c4:	e9 c2 00 00 00       	jmp    80198b <CheckWSWithoutLastIndex+0xfe>
		if (expectedPages[e] == 0) {
  8018c9:	8b 45 f0             	mov    -0x10(%ebp),%eax
  8018cc:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  8018d3:	8b 45 08             	mov    0x8(%ebp),%eax
  8018d6:	01 d0                	add    %edx,%eax
  8018d8:	8b 00                	mov    (%eax),%eax
  8018da:	85 c0                	test   %eax,%eax
  8018dc:	75 08                	jne    8018e6 <CheckWSWithoutLastIndex+0x59>
			expectedNumOfEmptyLocs++;
  8018de:	ff 45 f4             	incl   -0xc(%ebp)
			continue;
  8018e1:	e9 a2 00 00 00       	jmp    801988 <CheckWSWithoutLastIndex+0xfb>
		}
		int found = 0;
  8018e6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8018ed:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
  8018f4:	eb 69                	jmp    80195f <CheckWSWithoutLastIndex+0xd2>
			if (myEnv->__uptr_pws[w].empty == 0) {
  8018f6:	a1 20 30 80 00       	mov    0x803020,%eax
  8018fb:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  801901:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801904:	89 d0                	mov    %edx,%eax
  801906:	01 c0                	add    %eax,%eax
  801908:	01 d0                	add    %edx,%eax
  80190a:	c1 e0 03             	shl    $0x3,%eax
  80190d:	01 c8                	add    %ecx,%eax
  80190f:	8a 40 04             	mov    0x4(%eax),%al
  801912:	84 c0                	test   %al,%al
  801914:	75 46                	jne    80195c <CheckWSWithoutLastIndex+0xcf>
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  801916:	a1 20 30 80 00       	mov    0x803020,%eax
  80191b:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  801921:	8b 55 e8             	mov    -0x18(%ebp),%edx
  801924:	89 d0                	mov    %edx,%eax
  801926:	01 c0                	add    %eax,%eax
  801928:	01 d0                	add    %edx,%eax
  80192a:	c1 e0 03             	shl    $0x3,%eax
  80192d:	01 c8                	add    %ecx,%eax
  80192f:	8b 00                	mov    (%eax),%eax
  801931:	89 45 dc             	mov    %eax,-0x24(%ebp)
  801934:	8b 45 dc             	mov    -0x24(%ebp),%eax
  801937:	25 00 f0 ff ff       	and    $0xfffff000,%eax
  80193c:	89 c2                	mov    %eax,%edx
						== expectedPages[e]) {
  80193e:	8b 45 f0             	mov    -0x10(%ebp),%eax
  801941:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  801948:	8b 45 08             	mov    0x8(%ebp),%eax
  80194b:	01 c8                	add    %ecx,%eax
  80194d:	8b 00                	mov    (%eax),%eax
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
			if (myEnv->__uptr_pws[w].empty == 0) {
				if (ROUNDDOWN(myEnv->__uptr_pws[w].virtual_address, PAGE_SIZE)
  80194f:	39 c2                	cmp    %eax,%edx
  801951:	75 09                	jne    80195c <CheckWSWithoutLastIndex+0xcf>
						== expectedPages[e]) {
					found = 1;
  801953:	c7 45 ec 01 00 00 00 	movl   $0x1,-0x14(%ebp)
					break;
  80195a:	eb 12                	jmp    80196e <CheckWSWithoutLastIndex+0xe1>
		if (expectedPages[e] == 0) {
			expectedNumOfEmptyLocs++;
			continue;
		}
		int found = 0;
		for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80195c:	ff 45 e8             	incl   -0x18(%ebp)
  80195f:	a1 20 30 80 00       	mov    0x803020,%eax
  801964:	8b 50 74             	mov    0x74(%eax),%edx
  801967:	8b 45 e8             	mov    -0x18(%ebp),%eax
  80196a:	39 c2                	cmp    %eax,%edx
  80196c:	77 88                	ja     8018f6 <CheckWSWithoutLastIndex+0x69>
					found = 1;
					break;
				}
			}
		}
		if (!found)
  80196e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  801972:	75 14                	jne    801988 <CheckWSWithoutLastIndex+0xfb>
			panic(
  801974:	83 ec 04             	sub    $0x4,%esp
  801977:	68 c8 21 80 00       	push   $0x8021c8
  80197c:	6a 3a                	push   $0x3a
  80197e:	68 bc 21 80 00       	push   $0x8021bc
  801983:	e8 93 fe ff ff       	call   80181b <_panic>
	if (arraySize != myEnv->page_WS_max_size)
	{
		panic("number of expected pages SHOULD BE EQUAL to max WS size... review your TA!!");
	}
	int expectedNumOfEmptyLocs = 0;
	for (int e = 0; e < arraySize; e++) {
  801988:	ff 45 f0             	incl   -0x10(%ebp)
  80198b:	8b 45 f0             	mov    -0x10(%ebp),%eax
  80198e:	3b 45 0c             	cmp    0xc(%ebp),%eax
  801991:	0f 8c 32 ff ff ff    	jl     8018c9 <CheckWSWithoutLastIndex+0x3c>
		}
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
  801997:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  80199e:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  8019a5:	eb 26                	jmp    8019cd <CheckWSWithoutLastIndex+0x140>
		if (myEnv->__uptr_pws[w].empty == 1) {
  8019a7:	a1 20 30 80 00       	mov    0x803020,%eax
  8019ac:	8b 88 9c 05 00 00    	mov    0x59c(%eax),%ecx
  8019b2:	8b 55 e0             	mov    -0x20(%ebp),%edx
  8019b5:	89 d0                	mov    %edx,%eax
  8019b7:	01 c0                	add    %eax,%eax
  8019b9:	01 d0                	add    %edx,%eax
  8019bb:	c1 e0 03             	shl    $0x3,%eax
  8019be:	01 c8                	add    %ecx,%eax
  8019c0:	8a 40 04             	mov    0x4(%eax),%al
  8019c3:	3c 01                	cmp    $0x1,%al
  8019c5:	75 03                	jne    8019ca <CheckWSWithoutLastIndex+0x13d>
			actualNumOfEmptyLocs++;
  8019c7:	ff 45 e4             	incl   -0x1c(%ebp)
		if (!found)
			panic(
					"PAGE WS entry checking failed... trace it by printing page WS before & after fault");
	}
	int actualNumOfEmptyLocs = 0;
	for (int w = 0; w < myEnv->page_WS_max_size; w++) {
  8019ca:	ff 45 e0             	incl   -0x20(%ebp)
  8019cd:	a1 20 30 80 00       	mov    0x803020,%eax
  8019d2:	8b 50 74             	mov    0x74(%eax),%edx
  8019d5:	8b 45 e0             	mov    -0x20(%ebp),%eax
  8019d8:	39 c2                	cmp    %eax,%edx
  8019da:	77 cb                	ja     8019a7 <CheckWSWithoutLastIndex+0x11a>
		if (myEnv->__uptr_pws[w].empty == 1) {
			actualNumOfEmptyLocs++;
		}
	}
	if (expectedNumOfEmptyLocs != actualNumOfEmptyLocs)
  8019dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  8019df:	3b 45 e4             	cmp    -0x1c(%ebp),%eax
  8019e2:	74 14                	je     8019f8 <CheckWSWithoutLastIndex+0x16b>
		panic(
  8019e4:	83 ec 04             	sub    $0x4,%esp
  8019e7:	68 1c 22 80 00       	push   $0x80221c
  8019ec:	6a 44                	push   $0x44
  8019ee:	68 bc 21 80 00       	push   $0x8021bc
  8019f3:	e8 23 fe ff ff       	call   80181b <_panic>
				"PAGE WS entry checking failed... number of empty locations is not correct");
}
  8019f8:	90                   	nop
  8019f9:	c9                   	leave  
  8019fa:	c3                   	ret    
  8019fb:	90                   	nop

008019fc <__udivdi3>:
  8019fc:	55                   	push   %ebp
  8019fd:	57                   	push   %edi
  8019fe:	56                   	push   %esi
  8019ff:	53                   	push   %ebx
  801a00:	83 ec 1c             	sub    $0x1c,%esp
  801a03:	8b 5c 24 30          	mov    0x30(%esp),%ebx
  801a07:	8b 4c 24 34          	mov    0x34(%esp),%ecx
  801a0b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801a0f:	89 5c 24 08          	mov    %ebx,0x8(%esp)
  801a13:	89 ca                	mov    %ecx,%edx
  801a15:	89 f8                	mov    %edi,%eax
  801a17:	8b 74 24 3c          	mov    0x3c(%esp),%esi
  801a1b:	85 f6                	test   %esi,%esi
  801a1d:	75 2d                	jne    801a4c <__udivdi3+0x50>
  801a1f:	39 cf                	cmp    %ecx,%edi
  801a21:	77 65                	ja     801a88 <__udivdi3+0x8c>
  801a23:	89 fd                	mov    %edi,%ebp
  801a25:	85 ff                	test   %edi,%edi
  801a27:	75 0b                	jne    801a34 <__udivdi3+0x38>
  801a29:	b8 01 00 00 00       	mov    $0x1,%eax
  801a2e:	31 d2                	xor    %edx,%edx
  801a30:	f7 f7                	div    %edi
  801a32:	89 c5                	mov    %eax,%ebp
  801a34:	31 d2                	xor    %edx,%edx
  801a36:	89 c8                	mov    %ecx,%eax
  801a38:	f7 f5                	div    %ebp
  801a3a:	89 c1                	mov    %eax,%ecx
  801a3c:	89 d8                	mov    %ebx,%eax
  801a3e:	f7 f5                	div    %ebp
  801a40:	89 cf                	mov    %ecx,%edi
  801a42:	89 fa                	mov    %edi,%edx
  801a44:	83 c4 1c             	add    $0x1c,%esp
  801a47:	5b                   	pop    %ebx
  801a48:	5e                   	pop    %esi
  801a49:	5f                   	pop    %edi
  801a4a:	5d                   	pop    %ebp
  801a4b:	c3                   	ret    
  801a4c:	39 ce                	cmp    %ecx,%esi
  801a4e:	77 28                	ja     801a78 <__udivdi3+0x7c>
  801a50:	0f bd fe             	bsr    %esi,%edi
  801a53:	83 f7 1f             	xor    $0x1f,%edi
  801a56:	75 40                	jne    801a98 <__udivdi3+0x9c>
  801a58:	39 ce                	cmp    %ecx,%esi
  801a5a:	72 0a                	jb     801a66 <__udivdi3+0x6a>
  801a5c:	3b 44 24 08          	cmp    0x8(%esp),%eax
  801a60:	0f 87 9e 00 00 00    	ja     801b04 <__udivdi3+0x108>
  801a66:	b8 01 00 00 00       	mov    $0x1,%eax
  801a6b:	89 fa                	mov    %edi,%edx
  801a6d:	83 c4 1c             	add    $0x1c,%esp
  801a70:	5b                   	pop    %ebx
  801a71:	5e                   	pop    %esi
  801a72:	5f                   	pop    %edi
  801a73:	5d                   	pop    %ebp
  801a74:	c3                   	ret    
  801a75:	8d 76 00             	lea    0x0(%esi),%esi
  801a78:	31 ff                	xor    %edi,%edi
  801a7a:	31 c0                	xor    %eax,%eax
  801a7c:	89 fa                	mov    %edi,%edx
  801a7e:	83 c4 1c             	add    $0x1c,%esp
  801a81:	5b                   	pop    %ebx
  801a82:	5e                   	pop    %esi
  801a83:	5f                   	pop    %edi
  801a84:	5d                   	pop    %ebp
  801a85:	c3                   	ret    
  801a86:	66 90                	xchg   %ax,%ax
  801a88:	89 d8                	mov    %ebx,%eax
  801a8a:	f7 f7                	div    %edi
  801a8c:	31 ff                	xor    %edi,%edi
  801a8e:	89 fa                	mov    %edi,%edx
  801a90:	83 c4 1c             	add    $0x1c,%esp
  801a93:	5b                   	pop    %ebx
  801a94:	5e                   	pop    %esi
  801a95:	5f                   	pop    %edi
  801a96:	5d                   	pop    %ebp
  801a97:	c3                   	ret    
  801a98:	bd 20 00 00 00       	mov    $0x20,%ebp
  801a9d:	89 eb                	mov    %ebp,%ebx
  801a9f:	29 fb                	sub    %edi,%ebx
  801aa1:	89 f9                	mov    %edi,%ecx
  801aa3:	d3 e6                	shl    %cl,%esi
  801aa5:	89 c5                	mov    %eax,%ebp
  801aa7:	88 d9                	mov    %bl,%cl
  801aa9:	d3 ed                	shr    %cl,%ebp
  801aab:	89 e9                	mov    %ebp,%ecx
  801aad:	09 f1                	or     %esi,%ecx
  801aaf:	89 4c 24 0c          	mov    %ecx,0xc(%esp)
  801ab3:	89 f9                	mov    %edi,%ecx
  801ab5:	d3 e0                	shl    %cl,%eax
  801ab7:	89 c5                	mov    %eax,%ebp
  801ab9:	89 d6                	mov    %edx,%esi
  801abb:	88 d9                	mov    %bl,%cl
  801abd:	d3 ee                	shr    %cl,%esi
  801abf:	89 f9                	mov    %edi,%ecx
  801ac1:	d3 e2                	shl    %cl,%edx
  801ac3:	8b 44 24 08          	mov    0x8(%esp),%eax
  801ac7:	88 d9                	mov    %bl,%cl
  801ac9:	d3 e8                	shr    %cl,%eax
  801acb:	09 c2                	or     %eax,%edx
  801acd:	89 d0                	mov    %edx,%eax
  801acf:	89 f2                	mov    %esi,%edx
  801ad1:	f7 74 24 0c          	divl   0xc(%esp)
  801ad5:	89 d6                	mov    %edx,%esi
  801ad7:	89 c3                	mov    %eax,%ebx
  801ad9:	f7 e5                	mul    %ebp
  801adb:	39 d6                	cmp    %edx,%esi
  801add:	72 19                	jb     801af8 <__udivdi3+0xfc>
  801adf:	74 0b                	je     801aec <__udivdi3+0xf0>
  801ae1:	89 d8                	mov    %ebx,%eax
  801ae3:	31 ff                	xor    %edi,%edi
  801ae5:	e9 58 ff ff ff       	jmp    801a42 <__udivdi3+0x46>
  801aea:	66 90                	xchg   %ax,%ax
  801aec:	8b 54 24 08          	mov    0x8(%esp),%edx
  801af0:	89 f9                	mov    %edi,%ecx
  801af2:	d3 e2                	shl    %cl,%edx
  801af4:	39 c2                	cmp    %eax,%edx
  801af6:	73 e9                	jae    801ae1 <__udivdi3+0xe5>
  801af8:	8d 43 ff             	lea    -0x1(%ebx),%eax
  801afb:	31 ff                	xor    %edi,%edi
  801afd:	e9 40 ff ff ff       	jmp    801a42 <__udivdi3+0x46>
  801b02:	66 90                	xchg   %ax,%ax
  801b04:	31 c0                	xor    %eax,%eax
  801b06:	e9 37 ff ff ff       	jmp    801a42 <__udivdi3+0x46>
  801b0b:	90                   	nop

00801b0c <__umoddi3>:
  801b0c:	55                   	push   %ebp
  801b0d:	57                   	push   %edi
  801b0e:	56                   	push   %esi
  801b0f:	53                   	push   %ebx
  801b10:	83 ec 1c             	sub    $0x1c,%esp
  801b13:	8b 4c 24 30          	mov    0x30(%esp),%ecx
  801b17:	8b 74 24 34          	mov    0x34(%esp),%esi
  801b1b:	8b 7c 24 38          	mov    0x38(%esp),%edi
  801b1f:	8b 44 24 3c          	mov    0x3c(%esp),%eax
  801b23:	89 44 24 0c          	mov    %eax,0xc(%esp)
  801b27:	89 4c 24 08          	mov    %ecx,0x8(%esp)
  801b2b:	89 f3                	mov    %esi,%ebx
  801b2d:	89 fa                	mov    %edi,%edx
  801b2f:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801b33:	89 34 24             	mov    %esi,(%esp)
  801b36:	85 c0                	test   %eax,%eax
  801b38:	75 1a                	jne    801b54 <__umoddi3+0x48>
  801b3a:	39 f7                	cmp    %esi,%edi
  801b3c:	0f 86 a2 00 00 00    	jbe    801be4 <__umoddi3+0xd8>
  801b42:	89 c8                	mov    %ecx,%eax
  801b44:	89 f2                	mov    %esi,%edx
  801b46:	f7 f7                	div    %edi
  801b48:	89 d0                	mov    %edx,%eax
  801b4a:	31 d2                	xor    %edx,%edx
  801b4c:	83 c4 1c             	add    $0x1c,%esp
  801b4f:	5b                   	pop    %ebx
  801b50:	5e                   	pop    %esi
  801b51:	5f                   	pop    %edi
  801b52:	5d                   	pop    %ebp
  801b53:	c3                   	ret    
  801b54:	39 f0                	cmp    %esi,%eax
  801b56:	0f 87 ac 00 00 00    	ja     801c08 <__umoddi3+0xfc>
  801b5c:	0f bd e8             	bsr    %eax,%ebp
  801b5f:	83 f5 1f             	xor    $0x1f,%ebp
  801b62:	0f 84 ac 00 00 00    	je     801c14 <__umoddi3+0x108>
  801b68:	bf 20 00 00 00       	mov    $0x20,%edi
  801b6d:	29 ef                	sub    %ebp,%edi
  801b6f:	89 fe                	mov    %edi,%esi
  801b71:	89 7c 24 0c          	mov    %edi,0xc(%esp)
  801b75:	89 e9                	mov    %ebp,%ecx
  801b77:	d3 e0                	shl    %cl,%eax
  801b79:	89 d7                	mov    %edx,%edi
  801b7b:	89 f1                	mov    %esi,%ecx
  801b7d:	d3 ef                	shr    %cl,%edi
  801b7f:	09 c7                	or     %eax,%edi
  801b81:	89 e9                	mov    %ebp,%ecx
  801b83:	d3 e2                	shl    %cl,%edx
  801b85:	89 14 24             	mov    %edx,(%esp)
  801b88:	89 d8                	mov    %ebx,%eax
  801b8a:	d3 e0                	shl    %cl,%eax
  801b8c:	89 c2                	mov    %eax,%edx
  801b8e:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b92:	d3 e0                	shl    %cl,%eax
  801b94:	89 44 24 04          	mov    %eax,0x4(%esp)
  801b98:	8b 44 24 08          	mov    0x8(%esp),%eax
  801b9c:	89 f1                	mov    %esi,%ecx
  801b9e:	d3 e8                	shr    %cl,%eax
  801ba0:	09 d0                	or     %edx,%eax
  801ba2:	d3 eb                	shr    %cl,%ebx
  801ba4:	89 da                	mov    %ebx,%edx
  801ba6:	f7 f7                	div    %edi
  801ba8:	89 d3                	mov    %edx,%ebx
  801baa:	f7 24 24             	mull   (%esp)
  801bad:	89 c6                	mov    %eax,%esi
  801baf:	89 d1                	mov    %edx,%ecx
  801bb1:	39 d3                	cmp    %edx,%ebx
  801bb3:	0f 82 87 00 00 00    	jb     801c40 <__umoddi3+0x134>
  801bb9:	0f 84 91 00 00 00    	je     801c50 <__umoddi3+0x144>
  801bbf:	8b 54 24 04          	mov    0x4(%esp),%edx
  801bc3:	29 f2                	sub    %esi,%edx
  801bc5:	19 cb                	sbb    %ecx,%ebx
  801bc7:	89 d8                	mov    %ebx,%eax
  801bc9:	8a 4c 24 0c          	mov    0xc(%esp),%cl
  801bcd:	d3 e0                	shl    %cl,%eax
  801bcf:	89 e9                	mov    %ebp,%ecx
  801bd1:	d3 ea                	shr    %cl,%edx
  801bd3:	09 d0                	or     %edx,%eax
  801bd5:	89 e9                	mov    %ebp,%ecx
  801bd7:	d3 eb                	shr    %cl,%ebx
  801bd9:	89 da                	mov    %ebx,%edx
  801bdb:	83 c4 1c             	add    $0x1c,%esp
  801bde:	5b                   	pop    %ebx
  801bdf:	5e                   	pop    %esi
  801be0:	5f                   	pop    %edi
  801be1:	5d                   	pop    %ebp
  801be2:	c3                   	ret    
  801be3:	90                   	nop
  801be4:	89 fd                	mov    %edi,%ebp
  801be6:	85 ff                	test   %edi,%edi
  801be8:	75 0b                	jne    801bf5 <__umoddi3+0xe9>
  801bea:	b8 01 00 00 00       	mov    $0x1,%eax
  801bef:	31 d2                	xor    %edx,%edx
  801bf1:	f7 f7                	div    %edi
  801bf3:	89 c5                	mov    %eax,%ebp
  801bf5:	89 f0                	mov    %esi,%eax
  801bf7:	31 d2                	xor    %edx,%edx
  801bf9:	f7 f5                	div    %ebp
  801bfb:	89 c8                	mov    %ecx,%eax
  801bfd:	f7 f5                	div    %ebp
  801bff:	89 d0                	mov    %edx,%eax
  801c01:	e9 44 ff ff ff       	jmp    801b4a <__umoddi3+0x3e>
  801c06:	66 90                	xchg   %ax,%ax
  801c08:	89 c8                	mov    %ecx,%eax
  801c0a:	89 f2                	mov    %esi,%edx
  801c0c:	83 c4 1c             	add    $0x1c,%esp
  801c0f:	5b                   	pop    %ebx
  801c10:	5e                   	pop    %esi
  801c11:	5f                   	pop    %edi
  801c12:	5d                   	pop    %ebp
  801c13:	c3                   	ret    
  801c14:	3b 04 24             	cmp    (%esp),%eax
  801c17:	72 06                	jb     801c1f <__umoddi3+0x113>
  801c19:	3b 7c 24 04          	cmp    0x4(%esp),%edi
  801c1d:	77 0f                	ja     801c2e <__umoddi3+0x122>
  801c1f:	89 f2                	mov    %esi,%edx
  801c21:	29 f9                	sub    %edi,%ecx
  801c23:	1b 54 24 0c          	sbb    0xc(%esp),%edx
  801c27:	89 14 24             	mov    %edx,(%esp)
  801c2a:	89 4c 24 04          	mov    %ecx,0x4(%esp)
  801c2e:	8b 44 24 04          	mov    0x4(%esp),%eax
  801c32:	8b 14 24             	mov    (%esp),%edx
  801c35:	83 c4 1c             	add    $0x1c,%esp
  801c38:	5b                   	pop    %ebx
  801c39:	5e                   	pop    %esi
  801c3a:	5f                   	pop    %edi
  801c3b:	5d                   	pop    %ebp
  801c3c:	c3                   	ret    
  801c3d:	8d 76 00             	lea    0x0(%esi),%esi
  801c40:	2b 04 24             	sub    (%esp),%eax
  801c43:	19 fa                	sbb    %edi,%edx
  801c45:	89 d1                	mov    %edx,%ecx
  801c47:	89 c6                	mov    %eax,%esi
  801c49:	e9 71 ff ff ff       	jmp    801bbf <__umoddi3+0xb3>
  801c4e:	66 90                	xchg   %ax,%ax
  801c50:	39 44 24 04          	cmp    %eax,0x4(%esp)
  801c54:	72 ea                	jb     801c40 <__umoddi3+0x134>
  801c56:	89 d9                	mov    %ebx,%ecx
  801c58:	e9 62 ff ff ff       	jmp    801bbf <__umoddi3+0xb3>
