
user/_thrdtest4:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <thrdstop_handler>:
#define TIMEOUT_THRESHOLD 20

int main_id = -1;

void thrdstop_handler(void *arg)
{
       0:	7179                	addi	sp,sp,-48
       2:	f406                	sd	ra,40(sp)
       4:	f022                	sd	s0,32(sp)
       6:	1800                	addi	s0,sp,48
       8:	fca43c23          	sd	a0,-40(s0)
    int *flag_p = (int *)arg;
       c:	fd843783          	ld	a5,-40(s0)
      10:	fef43423          	sd	a5,-24(s0)
    *flag_p = 1;
      14:	fe843783          	ld	a5,-24(s0)
      18:	4705                	li	a4,1
      1a:	c398                	sw	a4,0(a5)
    thrdresume(main_id);
      1c:	00002797          	auipc	a5,0x2
      20:	05c78793          	addi	a5,a5,92 # 2078 <main_id>
      24:	439c                	lw	a5,0(a5)
      26:	853e                	mv	a0,a5
      28:	00000097          	auipc	ra,0x0
      2c:	622080e7          	jalr	1570(ra) # 64a <thrdresume>
}
      30:	0001                	nop
      32:	70a2                	ld	ra,40(sp)
      34:	7402                	ld	s0,32(sp)
      36:	6145                	addi	sp,sp,48
      38:	8082                	ret

000000000000003a <test_context_correctly_saved>:

int test_context_correctly_saved()
{
      3a:	1101                	addi	sp,sp,-32
      3c:	ec06                	sd	ra,24(sp)
      3e:	e822                	sd	s0,16(sp)
      40:	1000                	addi	s0,sp,32
    int flag = 0;
      42:	fe042623          	sw	zero,-20(s0)
    thrdstop(50, &main_id, thrdstop_handler, (void *)&flag);
      46:	fec40793          	addi	a5,s0,-20
      4a:	86be                	mv	a3,a5
      4c:	00000617          	auipc	a2,0x0
      50:	fb460613          	addi	a2,a2,-76 # 0 <thrdstop_handler>
      54:	00002597          	auipc	a1,0x2
      58:	02458593          	addi	a1,a1,36 # 2078 <main_id>
      5c:	03200513          	li	a0,50
      60:	00000097          	auipc	ra,0x0
      64:	5e2080e7          	jalr	1506(ra) # 642 <thrdstop>
    __asm__ volatile (
      68:	fec40793          	addi	a5,s0,-20
      6c:	82be                	mv	t0,a5
      6e:	45700593          	li	a1,1111
      72:	3f200813          	li	a6,1010
      76:	3e900893          	li	a7,1001

000000000000007a <loop>:
      7a:	0002a303          	lw	t1,0(t0)
      7e:	fe030ee3          	beqz	t1,7a <loop>
      82:	ba958593          	addi	a1,a1,-1111
      86:	e999                	bnez	a1,9c <failed>
      88:	c0e80813          	addi	a6,a6,-1010
      8c:	00081863          	bnez	a6,9c <failed>
      90:	c1788893          	addi	a7,a7,-1001
      94:	00089463          	bnez	a7,9c <failed>
      98:	00000763          	beqz	zero,a6 <success>

000000000000009c <failed>:
      9c:	60e2                	ld	ra,24(sp)
      9e:	6442                	ld	s0,16(sp)
      a0:	6105                	addi	sp,sp,32
      a2:	4505                	li	a0,1
      a4:	8082                	ret

00000000000000a6 <success>:
        "li a0,1\n"
        "ret\n"
        "success:\n"
        :
        : "r"(&flag));
    return 0;
      a6:	4781                	li	a5,0
}
      a8:	853e                	mv	a0,a5
      aa:	60e2                	ld	ra,24(sp)
      ac:	6442                	ld	s0,16(sp)
      ae:	6105                	addi	sp,sp,32
      b0:	8082                	ret

00000000000000b2 <main>:

int main(int argc, char **argv)
{
      b2:	7179                	addi	sp,sp,-48
      b4:	f406                	sd	ra,40(sp)
      b6:	f022                	sd	s0,32(sp)
      b8:	1800                	addi	s0,sp,48
      ba:	87aa                	mv	a5,a0
      bc:	fcb43823          	sd	a1,-48(s0)
      c0:	fcf42e23          	sw	a5,-36(s0)
    int result = test_context_correctly_saved();
      c4:	00000097          	auipc	ra,0x0
      c8:	f76080e7          	jalr	-138(ra) # 3a <test_context_correctly_saved>
      cc:	87aa                	mv	a5,a0
      ce:	fef42623          	sw	a5,-20(s0)
    fprintf(2, "[%s] %s\n", result ? "FAILED" : "OK", "test_context_correctly_saved");
      d2:	fec42783          	lw	a5,-20(s0)
      d6:	2781                	sext.w	a5,a5
      d8:	c791                	beqz	a5,e4 <main+0x32>
      da:	00002797          	auipc	a5,0x2
      de:	df678793          	addi	a5,a5,-522 # 1ed0 <schedule_rm+0x2b6>
      e2:	a029                	j	ec <main+0x3a>
      e4:	00002797          	auipc	a5,0x2
      e8:	df478793          	addi	a5,a5,-524 # 1ed8 <schedule_rm+0x2be>
      ec:	00002697          	auipc	a3,0x2
      f0:	df468693          	addi	a3,a3,-524 # 1ee0 <schedule_rm+0x2c6>
      f4:	863e                	mv	a2,a5
      f6:	00002597          	auipc	a1,0x2
      fa:	e0a58593          	addi	a1,a1,-502 # 1f00 <schedule_rm+0x2e6>
      fe:	4509                	li	a0,2
     100:	00001097          	auipc	ra,0x1
     104:	990080e7          	jalr	-1648(ra) # a90 <fprintf>

    exit(0);
     108:	4501                	li	a0,0
     10a:	00000097          	auipc	ra,0x0
     10e:	498080e7          	jalr	1176(ra) # 5a2 <exit>

0000000000000112 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
     112:	7179                	addi	sp,sp,-48
     114:	f422                	sd	s0,40(sp)
     116:	1800                	addi	s0,sp,48
     118:	fca43c23          	sd	a0,-40(s0)
     11c:	fcb43823          	sd	a1,-48(s0)
  char *os;

  os = s;
     120:	fd843783          	ld	a5,-40(s0)
     124:	fef43423          	sd	a5,-24(s0)
  while((*s++ = *t++) != 0)
     128:	0001                	nop
     12a:	fd043703          	ld	a4,-48(s0)
     12e:	00170793          	addi	a5,a4,1
     132:	fcf43823          	sd	a5,-48(s0)
     136:	fd843783          	ld	a5,-40(s0)
     13a:	00178693          	addi	a3,a5,1
     13e:	fcd43c23          	sd	a3,-40(s0)
     142:	00074703          	lbu	a4,0(a4)
     146:	00e78023          	sb	a4,0(a5)
     14a:	0007c783          	lbu	a5,0(a5)
     14e:	fff1                	bnez	a5,12a <strcpy+0x18>
    ;
  return os;
     150:	fe843783          	ld	a5,-24(s0)
}
     154:	853e                	mv	a0,a5
     156:	7422                	ld	s0,40(sp)
     158:	6145                	addi	sp,sp,48
     15a:	8082                	ret

000000000000015c <strcmp>:

int
strcmp(const char *p, const char *q)
{
     15c:	1101                	addi	sp,sp,-32
     15e:	ec22                	sd	s0,24(sp)
     160:	1000                	addi	s0,sp,32
     162:	fea43423          	sd	a0,-24(s0)
     166:	feb43023          	sd	a1,-32(s0)
  while(*p && *p == *q)
     16a:	a819                	j	180 <strcmp+0x24>
    p++, q++;
     16c:	fe843783          	ld	a5,-24(s0)
     170:	0785                	addi	a5,a5,1
     172:	fef43423          	sd	a5,-24(s0)
     176:	fe043783          	ld	a5,-32(s0)
     17a:	0785                	addi	a5,a5,1
     17c:	fef43023          	sd	a5,-32(s0)
  while(*p && *p == *q)
     180:	fe843783          	ld	a5,-24(s0)
     184:	0007c783          	lbu	a5,0(a5)
     188:	cb99                	beqz	a5,19e <strcmp+0x42>
     18a:	fe843783          	ld	a5,-24(s0)
     18e:	0007c703          	lbu	a4,0(a5)
     192:	fe043783          	ld	a5,-32(s0)
     196:	0007c783          	lbu	a5,0(a5)
     19a:	fcf709e3          	beq	a4,a5,16c <strcmp+0x10>
  return (uchar)*p - (uchar)*q;
     19e:	fe843783          	ld	a5,-24(s0)
     1a2:	0007c783          	lbu	a5,0(a5)
     1a6:	0007871b          	sext.w	a4,a5
     1aa:	fe043783          	ld	a5,-32(s0)
     1ae:	0007c783          	lbu	a5,0(a5)
     1b2:	2781                	sext.w	a5,a5
     1b4:	40f707bb          	subw	a5,a4,a5
     1b8:	2781                	sext.w	a5,a5
}
     1ba:	853e                	mv	a0,a5
     1bc:	6462                	ld	s0,24(sp)
     1be:	6105                	addi	sp,sp,32
     1c0:	8082                	ret

00000000000001c2 <strlen>:

uint
strlen(const char *s)
{
     1c2:	7179                	addi	sp,sp,-48
     1c4:	f422                	sd	s0,40(sp)
     1c6:	1800                	addi	s0,sp,48
     1c8:	fca43c23          	sd	a0,-40(s0)
  int n;

  for(n = 0; s[n]; n++)
     1cc:	fe042623          	sw	zero,-20(s0)
     1d0:	a031                	j	1dc <strlen+0x1a>
     1d2:	fec42783          	lw	a5,-20(s0)
     1d6:	2785                	addiw	a5,a5,1
     1d8:	fef42623          	sw	a5,-20(s0)
     1dc:	fec42783          	lw	a5,-20(s0)
     1e0:	fd843703          	ld	a4,-40(s0)
     1e4:	97ba                	add	a5,a5,a4
     1e6:	0007c783          	lbu	a5,0(a5)
     1ea:	f7e5                	bnez	a5,1d2 <strlen+0x10>
    ;
  return n;
     1ec:	fec42783          	lw	a5,-20(s0)
}
     1f0:	853e                	mv	a0,a5
     1f2:	7422                	ld	s0,40(sp)
     1f4:	6145                	addi	sp,sp,48
     1f6:	8082                	ret

00000000000001f8 <memset>:

void*
memset(void *dst, int c, uint n)
{
     1f8:	7179                	addi	sp,sp,-48
     1fa:	f422                	sd	s0,40(sp)
     1fc:	1800                	addi	s0,sp,48
     1fe:	fca43c23          	sd	a0,-40(s0)
     202:	87ae                	mv	a5,a1
     204:	8732                	mv	a4,a2
     206:	fcf42a23          	sw	a5,-44(s0)
     20a:	87ba                	mv	a5,a4
     20c:	fcf42823          	sw	a5,-48(s0)
  char *cdst = (char *) dst;
     210:	fd843783          	ld	a5,-40(s0)
     214:	fef43023          	sd	a5,-32(s0)
  int i;
  for(i = 0; i < n; i++){
     218:	fe042623          	sw	zero,-20(s0)
     21c:	a00d                	j	23e <memset+0x46>
    cdst[i] = c;
     21e:	fec42783          	lw	a5,-20(s0)
     222:	fe043703          	ld	a4,-32(s0)
     226:	97ba                	add	a5,a5,a4
     228:	fd442703          	lw	a4,-44(s0)
     22c:	0ff77713          	andi	a4,a4,255
     230:	00e78023          	sb	a4,0(a5)
  for(i = 0; i < n; i++){
     234:	fec42783          	lw	a5,-20(s0)
     238:	2785                	addiw	a5,a5,1
     23a:	fef42623          	sw	a5,-20(s0)
     23e:	fec42703          	lw	a4,-20(s0)
     242:	fd042783          	lw	a5,-48(s0)
     246:	2781                	sext.w	a5,a5
     248:	fcf76be3          	bltu	a4,a5,21e <memset+0x26>
  }
  return dst;
     24c:	fd843783          	ld	a5,-40(s0)
}
     250:	853e                	mv	a0,a5
     252:	7422                	ld	s0,40(sp)
     254:	6145                	addi	sp,sp,48
     256:	8082                	ret

0000000000000258 <strchr>:

char*
strchr(const char *s, char c)
{
     258:	1101                	addi	sp,sp,-32
     25a:	ec22                	sd	s0,24(sp)
     25c:	1000                	addi	s0,sp,32
     25e:	fea43423          	sd	a0,-24(s0)
     262:	87ae                	mv	a5,a1
     264:	fef403a3          	sb	a5,-25(s0)
  for(; *s; s++)
     268:	a01d                	j	28e <strchr+0x36>
    if(*s == c)
     26a:	fe843783          	ld	a5,-24(s0)
     26e:	0007c703          	lbu	a4,0(a5)
     272:	fe744783          	lbu	a5,-25(s0)
     276:	0ff7f793          	andi	a5,a5,255
     27a:	00e79563          	bne	a5,a4,284 <strchr+0x2c>
      return (char*)s;
     27e:	fe843783          	ld	a5,-24(s0)
     282:	a821                	j	29a <strchr+0x42>
  for(; *s; s++)
     284:	fe843783          	ld	a5,-24(s0)
     288:	0785                	addi	a5,a5,1
     28a:	fef43423          	sd	a5,-24(s0)
     28e:	fe843783          	ld	a5,-24(s0)
     292:	0007c783          	lbu	a5,0(a5)
     296:	fbf1                	bnez	a5,26a <strchr+0x12>
  return 0;
     298:	4781                	li	a5,0
}
     29a:	853e                	mv	a0,a5
     29c:	6462                	ld	s0,24(sp)
     29e:	6105                	addi	sp,sp,32
     2a0:	8082                	ret

00000000000002a2 <gets>:

char*
gets(char *buf, int max)
{
     2a2:	7179                	addi	sp,sp,-48
     2a4:	f406                	sd	ra,40(sp)
     2a6:	f022                	sd	s0,32(sp)
     2a8:	1800                	addi	s0,sp,48
     2aa:	fca43c23          	sd	a0,-40(s0)
     2ae:	87ae                	mv	a5,a1
     2b0:	fcf42a23          	sw	a5,-44(s0)
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     2b4:	fe042623          	sw	zero,-20(s0)
     2b8:	a8a1                	j	310 <gets+0x6e>
    cc = read(0, &c, 1);
     2ba:	fe740793          	addi	a5,s0,-25
     2be:	4605                	li	a2,1
     2c0:	85be                	mv	a1,a5
     2c2:	4501                	li	a0,0
     2c4:	00000097          	auipc	ra,0x0
     2c8:	2f6080e7          	jalr	758(ra) # 5ba <read>
     2cc:	87aa                	mv	a5,a0
     2ce:	fef42423          	sw	a5,-24(s0)
    if(cc < 1)
     2d2:	fe842783          	lw	a5,-24(s0)
     2d6:	2781                	sext.w	a5,a5
     2d8:	04f05763          	blez	a5,326 <gets+0x84>
      break;
    buf[i++] = c;
     2dc:	fec42783          	lw	a5,-20(s0)
     2e0:	0017871b          	addiw	a4,a5,1
     2e4:	fee42623          	sw	a4,-20(s0)
     2e8:	873e                	mv	a4,a5
     2ea:	fd843783          	ld	a5,-40(s0)
     2ee:	97ba                	add	a5,a5,a4
     2f0:	fe744703          	lbu	a4,-25(s0)
     2f4:	00e78023          	sb	a4,0(a5)
    if(c == '\n' || c == '\r')
     2f8:	fe744783          	lbu	a5,-25(s0)
     2fc:	873e                	mv	a4,a5
     2fe:	47a9                	li	a5,10
     300:	02f70463          	beq	a4,a5,328 <gets+0x86>
     304:	fe744783          	lbu	a5,-25(s0)
     308:	873e                	mv	a4,a5
     30a:	47b5                	li	a5,13
     30c:	00f70e63          	beq	a4,a5,328 <gets+0x86>
  for(i=0; i+1 < max; ){
     310:	fec42783          	lw	a5,-20(s0)
     314:	2785                	addiw	a5,a5,1
     316:	0007871b          	sext.w	a4,a5
     31a:	fd442783          	lw	a5,-44(s0)
     31e:	2781                	sext.w	a5,a5
     320:	f8f74de3          	blt	a4,a5,2ba <gets+0x18>
     324:	a011                	j	328 <gets+0x86>
      break;
     326:	0001                	nop
      break;
  }
  buf[i] = '\0';
     328:	fec42783          	lw	a5,-20(s0)
     32c:	fd843703          	ld	a4,-40(s0)
     330:	97ba                	add	a5,a5,a4
     332:	00078023          	sb	zero,0(a5)
  return buf;
     336:	fd843783          	ld	a5,-40(s0)
}
     33a:	853e                	mv	a0,a5
     33c:	70a2                	ld	ra,40(sp)
     33e:	7402                	ld	s0,32(sp)
     340:	6145                	addi	sp,sp,48
     342:	8082                	ret

0000000000000344 <stat>:

int
stat(const char *n, struct stat *st)
{
     344:	7179                	addi	sp,sp,-48
     346:	f406                	sd	ra,40(sp)
     348:	f022                	sd	s0,32(sp)
     34a:	1800                	addi	s0,sp,48
     34c:	fca43c23          	sd	a0,-40(s0)
     350:	fcb43823          	sd	a1,-48(s0)
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     354:	4581                	li	a1,0
     356:	fd843503          	ld	a0,-40(s0)
     35a:	00000097          	auipc	ra,0x0
     35e:	288080e7          	jalr	648(ra) # 5e2 <open>
     362:	87aa                	mv	a5,a0
     364:	fef42623          	sw	a5,-20(s0)
  if(fd < 0)
     368:	fec42783          	lw	a5,-20(s0)
     36c:	2781                	sext.w	a5,a5
     36e:	0007d463          	bgez	a5,376 <stat+0x32>
    return -1;
     372:	57fd                	li	a5,-1
     374:	a035                	j	3a0 <stat+0x5c>
  r = fstat(fd, st);
     376:	fec42783          	lw	a5,-20(s0)
     37a:	fd043583          	ld	a1,-48(s0)
     37e:	853e                	mv	a0,a5
     380:	00000097          	auipc	ra,0x0
     384:	27a080e7          	jalr	634(ra) # 5fa <fstat>
     388:	87aa                	mv	a5,a0
     38a:	fef42423          	sw	a5,-24(s0)
  close(fd);
     38e:	fec42783          	lw	a5,-20(s0)
     392:	853e                	mv	a0,a5
     394:	00000097          	auipc	ra,0x0
     398:	236080e7          	jalr	566(ra) # 5ca <close>
  return r;
     39c:	fe842783          	lw	a5,-24(s0)
}
     3a0:	853e                	mv	a0,a5
     3a2:	70a2                	ld	ra,40(sp)
     3a4:	7402                	ld	s0,32(sp)
     3a6:	6145                	addi	sp,sp,48
     3a8:	8082                	ret

00000000000003aa <atoi>:

int
atoi(const char *s)
{
     3aa:	7179                	addi	sp,sp,-48
     3ac:	f422                	sd	s0,40(sp)
     3ae:	1800                	addi	s0,sp,48
     3b0:	fca43c23          	sd	a0,-40(s0)
  int n;

  n = 0;
     3b4:	fe042623          	sw	zero,-20(s0)
  while('0' <= *s && *s <= '9')
     3b8:	a815                	j	3ec <atoi+0x42>
    n = n*10 + *s++ - '0';
     3ba:	fec42703          	lw	a4,-20(s0)
     3be:	87ba                	mv	a5,a4
     3c0:	0027979b          	slliw	a5,a5,0x2
     3c4:	9fb9                	addw	a5,a5,a4
     3c6:	0017979b          	slliw	a5,a5,0x1
     3ca:	0007871b          	sext.w	a4,a5
     3ce:	fd843783          	ld	a5,-40(s0)
     3d2:	00178693          	addi	a3,a5,1
     3d6:	fcd43c23          	sd	a3,-40(s0)
     3da:	0007c783          	lbu	a5,0(a5)
     3de:	2781                	sext.w	a5,a5
     3e0:	9fb9                	addw	a5,a5,a4
     3e2:	2781                	sext.w	a5,a5
     3e4:	fd07879b          	addiw	a5,a5,-48
     3e8:	fef42623          	sw	a5,-20(s0)
  while('0' <= *s && *s <= '9')
     3ec:	fd843783          	ld	a5,-40(s0)
     3f0:	0007c783          	lbu	a5,0(a5)
     3f4:	873e                	mv	a4,a5
     3f6:	02f00793          	li	a5,47
     3fa:	00e7fb63          	bgeu	a5,a4,410 <atoi+0x66>
     3fe:	fd843783          	ld	a5,-40(s0)
     402:	0007c783          	lbu	a5,0(a5)
     406:	873e                	mv	a4,a5
     408:	03900793          	li	a5,57
     40c:	fae7f7e3          	bgeu	a5,a4,3ba <atoi+0x10>
  return n;
     410:	fec42783          	lw	a5,-20(s0)
}
     414:	853e                	mv	a0,a5
     416:	7422                	ld	s0,40(sp)
     418:	6145                	addi	sp,sp,48
     41a:	8082                	ret

000000000000041c <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     41c:	7139                	addi	sp,sp,-64
     41e:	fc22                	sd	s0,56(sp)
     420:	0080                	addi	s0,sp,64
     422:	fca43c23          	sd	a0,-40(s0)
     426:	fcb43823          	sd	a1,-48(s0)
     42a:	87b2                	mv	a5,a2
     42c:	fcf42623          	sw	a5,-52(s0)
  char *dst;
  const char *src;

  dst = vdst;
     430:	fd843783          	ld	a5,-40(s0)
     434:	fef43423          	sd	a5,-24(s0)
  src = vsrc;
     438:	fd043783          	ld	a5,-48(s0)
     43c:	fef43023          	sd	a5,-32(s0)
  if (src > dst) {
     440:	fe043703          	ld	a4,-32(s0)
     444:	fe843783          	ld	a5,-24(s0)
     448:	02e7fc63          	bgeu	a5,a4,480 <memmove+0x64>
    while(n-- > 0)
     44c:	a00d                	j	46e <memmove+0x52>
      *dst++ = *src++;
     44e:	fe043703          	ld	a4,-32(s0)
     452:	00170793          	addi	a5,a4,1
     456:	fef43023          	sd	a5,-32(s0)
     45a:	fe843783          	ld	a5,-24(s0)
     45e:	00178693          	addi	a3,a5,1
     462:	fed43423          	sd	a3,-24(s0)
     466:	00074703          	lbu	a4,0(a4)
     46a:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     46e:	fcc42783          	lw	a5,-52(s0)
     472:	fff7871b          	addiw	a4,a5,-1
     476:	fce42623          	sw	a4,-52(s0)
     47a:	fcf04ae3          	bgtz	a5,44e <memmove+0x32>
     47e:	a891                	j	4d2 <memmove+0xb6>
  } else {
    dst += n;
     480:	fcc42783          	lw	a5,-52(s0)
     484:	fe843703          	ld	a4,-24(s0)
     488:	97ba                	add	a5,a5,a4
     48a:	fef43423          	sd	a5,-24(s0)
    src += n;
     48e:	fcc42783          	lw	a5,-52(s0)
     492:	fe043703          	ld	a4,-32(s0)
     496:	97ba                	add	a5,a5,a4
     498:	fef43023          	sd	a5,-32(s0)
    while(n-- > 0)
     49c:	a01d                	j	4c2 <memmove+0xa6>
      *--dst = *--src;
     49e:	fe043783          	ld	a5,-32(s0)
     4a2:	17fd                	addi	a5,a5,-1
     4a4:	fef43023          	sd	a5,-32(s0)
     4a8:	fe843783          	ld	a5,-24(s0)
     4ac:	17fd                	addi	a5,a5,-1
     4ae:	fef43423          	sd	a5,-24(s0)
     4b2:	fe043783          	ld	a5,-32(s0)
     4b6:	0007c703          	lbu	a4,0(a5)
     4ba:	fe843783          	ld	a5,-24(s0)
     4be:	00e78023          	sb	a4,0(a5)
    while(n-- > 0)
     4c2:	fcc42783          	lw	a5,-52(s0)
     4c6:	fff7871b          	addiw	a4,a5,-1
     4ca:	fce42623          	sw	a4,-52(s0)
     4ce:	fcf048e3          	bgtz	a5,49e <memmove+0x82>
  }
  return vdst;
     4d2:	fd843783          	ld	a5,-40(s0)
}
     4d6:	853e                	mv	a0,a5
     4d8:	7462                	ld	s0,56(sp)
     4da:	6121                	addi	sp,sp,64
     4dc:	8082                	ret

00000000000004de <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
     4de:	7139                	addi	sp,sp,-64
     4e0:	fc22                	sd	s0,56(sp)
     4e2:	0080                	addi	s0,sp,64
     4e4:	fca43c23          	sd	a0,-40(s0)
     4e8:	fcb43823          	sd	a1,-48(s0)
     4ec:	87b2                	mv	a5,a2
     4ee:	fcf42623          	sw	a5,-52(s0)
  const char *p1 = s1, *p2 = s2;
     4f2:	fd843783          	ld	a5,-40(s0)
     4f6:	fef43423          	sd	a5,-24(s0)
     4fa:	fd043783          	ld	a5,-48(s0)
     4fe:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     502:	a0a1                	j	54a <memcmp+0x6c>
    if (*p1 != *p2) {
     504:	fe843783          	ld	a5,-24(s0)
     508:	0007c703          	lbu	a4,0(a5)
     50c:	fe043783          	ld	a5,-32(s0)
     510:	0007c783          	lbu	a5,0(a5)
     514:	02f70163          	beq	a4,a5,536 <memcmp+0x58>
      return *p1 - *p2;
     518:	fe843783          	ld	a5,-24(s0)
     51c:	0007c783          	lbu	a5,0(a5)
     520:	0007871b          	sext.w	a4,a5
     524:	fe043783          	ld	a5,-32(s0)
     528:	0007c783          	lbu	a5,0(a5)
     52c:	2781                	sext.w	a5,a5
     52e:	40f707bb          	subw	a5,a4,a5
     532:	2781                	sext.w	a5,a5
     534:	a01d                	j	55a <memcmp+0x7c>
    }
    p1++;
     536:	fe843783          	ld	a5,-24(s0)
     53a:	0785                	addi	a5,a5,1
     53c:	fef43423          	sd	a5,-24(s0)
    p2++;
     540:	fe043783          	ld	a5,-32(s0)
     544:	0785                	addi	a5,a5,1
     546:	fef43023          	sd	a5,-32(s0)
  while (n-- > 0) {
     54a:	fcc42783          	lw	a5,-52(s0)
     54e:	fff7871b          	addiw	a4,a5,-1
     552:	fce42623          	sw	a4,-52(s0)
     556:	f7dd                	bnez	a5,504 <memcmp+0x26>
  }
  return 0;
     558:	4781                	li	a5,0
}
     55a:	853e                	mv	a0,a5
     55c:	7462                	ld	s0,56(sp)
     55e:	6121                	addi	sp,sp,64
     560:	8082                	ret

0000000000000562 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
     562:	7179                	addi	sp,sp,-48
     564:	f406                	sd	ra,40(sp)
     566:	f022                	sd	s0,32(sp)
     568:	1800                	addi	s0,sp,48
     56a:	fea43423          	sd	a0,-24(s0)
     56e:	feb43023          	sd	a1,-32(s0)
     572:	87b2                	mv	a5,a2
     574:	fcf42e23          	sw	a5,-36(s0)
  return memmove(dst, src, n);
     578:	fdc42783          	lw	a5,-36(s0)
     57c:	863e                	mv	a2,a5
     57e:	fe043583          	ld	a1,-32(s0)
     582:	fe843503          	ld	a0,-24(s0)
     586:	00000097          	auipc	ra,0x0
     58a:	e96080e7          	jalr	-362(ra) # 41c <memmove>
     58e:	87aa                	mv	a5,a0
}
     590:	853e                	mv	a0,a5
     592:	70a2                	ld	ra,40(sp)
     594:	7402                	ld	s0,32(sp)
     596:	6145                	addi	sp,sp,48
     598:	8082                	ret

000000000000059a <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
     59a:	4885                	li	a7,1
 ecall
     59c:	00000073          	ecall
 ret
     5a0:	8082                	ret

00000000000005a2 <exit>:
.global exit
exit:
 li a7, SYS_exit
     5a2:	4889                	li	a7,2
 ecall
     5a4:	00000073          	ecall
 ret
     5a8:	8082                	ret

00000000000005aa <wait>:
.global wait
wait:
 li a7, SYS_wait
     5aa:	488d                	li	a7,3
 ecall
     5ac:	00000073          	ecall
 ret
     5b0:	8082                	ret

00000000000005b2 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
     5b2:	4891                	li	a7,4
 ecall
     5b4:	00000073          	ecall
 ret
     5b8:	8082                	ret

00000000000005ba <read>:
.global read
read:
 li a7, SYS_read
     5ba:	4895                	li	a7,5
 ecall
     5bc:	00000073          	ecall
 ret
     5c0:	8082                	ret

00000000000005c2 <write>:
.global write
write:
 li a7, SYS_write
     5c2:	48c1                	li	a7,16
 ecall
     5c4:	00000073          	ecall
 ret
     5c8:	8082                	ret

00000000000005ca <close>:
.global close
close:
 li a7, SYS_close
     5ca:	48d5                	li	a7,21
 ecall
     5cc:	00000073          	ecall
 ret
     5d0:	8082                	ret

00000000000005d2 <kill>:
.global kill
kill:
 li a7, SYS_kill
     5d2:	4899                	li	a7,6
 ecall
     5d4:	00000073          	ecall
 ret
     5d8:	8082                	ret

00000000000005da <exec>:
.global exec
exec:
 li a7, SYS_exec
     5da:	489d                	li	a7,7
 ecall
     5dc:	00000073          	ecall
 ret
     5e0:	8082                	ret

00000000000005e2 <open>:
.global open
open:
 li a7, SYS_open
     5e2:	48bd                	li	a7,15
 ecall
     5e4:	00000073          	ecall
 ret
     5e8:	8082                	ret

00000000000005ea <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
     5ea:	48c5                	li	a7,17
 ecall
     5ec:	00000073          	ecall
 ret
     5f0:	8082                	ret

00000000000005f2 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
     5f2:	48c9                	li	a7,18
 ecall
     5f4:	00000073          	ecall
 ret
     5f8:	8082                	ret

00000000000005fa <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
     5fa:	48a1                	li	a7,8
 ecall
     5fc:	00000073          	ecall
 ret
     600:	8082                	ret

0000000000000602 <link>:
.global link
link:
 li a7, SYS_link
     602:	48cd                	li	a7,19
 ecall
     604:	00000073          	ecall
 ret
     608:	8082                	ret

000000000000060a <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
     60a:	48d1                	li	a7,20
 ecall
     60c:	00000073          	ecall
 ret
     610:	8082                	ret

0000000000000612 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
     612:	48a5                	li	a7,9
 ecall
     614:	00000073          	ecall
 ret
     618:	8082                	ret

000000000000061a <dup>:
.global dup
dup:
 li a7, SYS_dup
     61a:	48a9                	li	a7,10
 ecall
     61c:	00000073          	ecall
 ret
     620:	8082                	ret

0000000000000622 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
     622:	48ad                	li	a7,11
 ecall
     624:	00000073          	ecall
 ret
     628:	8082                	ret

000000000000062a <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
     62a:	48b1                	li	a7,12
 ecall
     62c:	00000073          	ecall
 ret
     630:	8082                	ret

0000000000000632 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
     632:	48b5                	li	a7,13
 ecall
     634:	00000073          	ecall
 ret
     638:	8082                	ret

000000000000063a <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
     63a:	48b9                	li	a7,14
 ecall
     63c:	00000073          	ecall
 ret
     640:	8082                	ret

0000000000000642 <thrdstop>:
.global thrdstop
thrdstop:
 li a7, SYS_thrdstop
     642:	48d9                	li	a7,22
 ecall
     644:	00000073          	ecall
 ret
     648:	8082                	ret

000000000000064a <thrdresume>:
.global thrdresume
thrdresume:
 li a7, SYS_thrdresume
     64a:	48dd                	li	a7,23
 ecall
     64c:	00000073          	ecall
 ret
     650:	8082                	ret

0000000000000652 <cancelthrdstop>:
.global cancelthrdstop
cancelthrdstop:
 li a7, SYS_cancelthrdstop
     652:	48e1                	li	a7,24
 ecall
     654:	00000073          	ecall
 ret
     658:	8082                	ret

000000000000065a <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
     65a:	1101                	addi	sp,sp,-32
     65c:	ec06                	sd	ra,24(sp)
     65e:	e822                	sd	s0,16(sp)
     660:	1000                	addi	s0,sp,32
     662:	87aa                	mv	a5,a0
     664:	872e                	mv	a4,a1
     666:	fef42623          	sw	a5,-20(s0)
     66a:	87ba                	mv	a5,a4
     66c:	fef405a3          	sb	a5,-21(s0)
  write(fd, &c, 1);
     670:	feb40713          	addi	a4,s0,-21
     674:	fec42783          	lw	a5,-20(s0)
     678:	4605                	li	a2,1
     67a:	85ba                	mv	a1,a4
     67c:	853e                	mv	a0,a5
     67e:	00000097          	auipc	ra,0x0
     682:	f44080e7          	jalr	-188(ra) # 5c2 <write>
}
     686:	0001                	nop
     688:	60e2                	ld	ra,24(sp)
     68a:	6442                	ld	s0,16(sp)
     68c:	6105                	addi	sp,sp,32
     68e:	8082                	ret

0000000000000690 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
     690:	7139                	addi	sp,sp,-64
     692:	fc06                	sd	ra,56(sp)
     694:	f822                	sd	s0,48(sp)
     696:	0080                	addi	s0,sp,64
     698:	87aa                	mv	a5,a0
     69a:	8736                	mv	a4,a3
     69c:	fcf42623          	sw	a5,-52(s0)
     6a0:	87ae                	mv	a5,a1
     6a2:	fcf42423          	sw	a5,-56(s0)
     6a6:	87b2                	mv	a5,a2
     6a8:	fcf42223          	sw	a5,-60(s0)
     6ac:	87ba                	mv	a5,a4
     6ae:	fcf42023          	sw	a5,-64(s0)
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
     6b2:	fe042423          	sw	zero,-24(s0)
  if(sgn && xx < 0){
     6b6:	fc042783          	lw	a5,-64(s0)
     6ba:	2781                	sext.w	a5,a5
     6bc:	c38d                	beqz	a5,6de <printint+0x4e>
     6be:	fc842783          	lw	a5,-56(s0)
     6c2:	2781                	sext.w	a5,a5
     6c4:	0007dd63          	bgez	a5,6de <printint+0x4e>
    neg = 1;
     6c8:	4785                	li	a5,1
     6ca:	fef42423          	sw	a5,-24(s0)
    x = -xx;
     6ce:	fc842783          	lw	a5,-56(s0)
     6d2:	40f007bb          	negw	a5,a5
     6d6:	2781                	sext.w	a5,a5
     6d8:	fef42223          	sw	a5,-28(s0)
     6dc:	a029                	j	6e6 <printint+0x56>
  } else {
    x = xx;
     6de:	fc842783          	lw	a5,-56(s0)
     6e2:	fef42223          	sw	a5,-28(s0)
  }

  i = 0;
     6e6:	fe042623          	sw	zero,-20(s0)
  do{
    buf[i++] = digits[x % base];
     6ea:	fc442783          	lw	a5,-60(s0)
     6ee:	fe442703          	lw	a4,-28(s0)
     6f2:	02f777bb          	remuw	a5,a4,a5
     6f6:	0007861b          	sext.w	a2,a5
     6fa:	fec42783          	lw	a5,-20(s0)
     6fe:	0017871b          	addiw	a4,a5,1
     702:	fee42623          	sw	a4,-20(s0)
     706:	00002697          	auipc	a3,0x2
     70a:	93a68693          	addi	a3,a3,-1734 # 2040 <digits>
     70e:	02061713          	slli	a4,a2,0x20
     712:	9301                	srli	a4,a4,0x20
     714:	9736                	add	a4,a4,a3
     716:	00074703          	lbu	a4,0(a4)
     71a:	ff040693          	addi	a3,s0,-16
     71e:	97b6                	add	a5,a5,a3
     720:	fee78023          	sb	a4,-32(a5)
  }while((x /= base) != 0);
     724:	fc442783          	lw	a5,-60(s0)
     728:	fe442703          	lw	a4,-28(s0)
     72c:	02f757bb          	divuw	a5,a4,a5
     730:	fef42223          	sw	a5,-28(s0)
     734:	fe442783          	lw	a5,-28(s0)
     738:	2781                	sext.w	a5,a5
     73a:	fbc5                	bnez	a5,6ea <printint+0x5a>
  if(neg)
     73c:	fe842783          	lw	a5,-24(s0)
     740:	2781                	sext.w	a5,a5
     742:	cf95                	beqz	a5,77e <printint+0xee>
    buf[i++] = '-';
     744:	fec42783          	lw	a5,-20(s0)
     748:	0017871b          	addiw	a4,a5,1
     74c:	fee42623          	sw	a4,-20(s0)
     750:	ff040713          	addi	a4,s0,-16
     754:	97ba                	add	a5,a5,a4
     756:	02d00713          	li	a4,45
     75a:	fee78023          	sb	a4,-32(a5)

  while(--i >= 0)
     75e:	a005                	j	77e <printint+0xee>
    putc(fd, buf[i]);
     760:	fec42783          	lw	a5,-20(s0)
     764:	ff040713          	addi	a4,s0,-16
     768:	97ba                	add	a5,a5,a4
     76a:	fe07c703          	lbu	a4,-32(a5)
     76e:	fcc42783          	lw	a5,-52(s0)
     772:	85ba                	mv	a1,a4
     774:	853e                	mv	a0,a5
     776:	00000097          	auipc	ra,0x0
     77a:	ee4080e7          	jalr	-284(ra) # 65a <putc>
  while(--i >= 0)
     77e:	fec42783          	lw	a5,-20(s0)
     782:	37fd                	addiw	a5,a5,-1
     784:	fef42623          	sw	a5,-20(s0)
     788:	fec42783          	lw	a5,-20(s0)
     78c:	2781                	sext.w	a5,a5
     78e:	fc07d9e3          	bgez	a5,760 <printint+0xd0>
}
     792:	0001                	nop
     794:	0001                	nop
     796:	70e2                	ld	ra,56(sp)
     798:	7442                	ld	s0,48(sp)
     79a:	6121                	addi	sp,sp,64
     79c:	8082                	ret

000000000000079e <printptr>:

static void
printptr(int fd, uint64 x) {
     79e:	7179                	addi	sp,sp,-48
     7a0:	f406                	sd	ra,40(sp)
     7a2:	f022                	sd	s0,32(sp)
     7a4:	1800                	addi	s0,sp,48
     7a6:	87aa                	mv	a5,a0
     7a8:	fcb43823          	sd	a1,-48(s0)
     7ac:	fcf42e23          	sw	a5,-36(s0)
  int i;
  putc(fd, '0');
     7b0:	fdc42783          	lw	a5,-36(s0)
     7b4:	03000593          	li	a1,48
     7b8:	853e                	mv	a0,a5
     7ba:	00000097          	auipc	ra,0x0
     7be:	ea0080e7          	jalr	-352(ra) # 65a <putc>
  putc(fd, 'x');
     7c2:	fdc42783          	lw	a5,-36(s0)
     7c6:	07800593          	li	a1,120
     7ca:	853e                	mv	a0,a5
     7cc:	00000097          	auipc	ra,0x0
     7d0:	e8e080e7          	jalr	-370(ra) # 65a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7d4:	fe042623          	sw	zero,-20(s0)
     7d8:	a82d                	j	812 <printptr+0x74>
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
     7da:	fd043783          	ld	a5,-48(s0)
     7de:	93f1                	srli	a5,a5,0x3c
     7e0:	00002717          	auipc	a4,0x2
     7e4:	86070713          	addi	a4,a4,-1952 # 2040 <digits>
     7e8:	97ba                	add	a5,a5,a4
     7ea:	0007c703          	lbu	a4,0(a5)
     7ee:	fdc42783          	lw	a5,-36(s0)
     7f2:	85ba                	mv	a1,a4
     7f4:	853e                	mv	a0,a5
     7f6:	00000097          	auipc	ra,0x0
     7fa:	e64080e7          	jalr	-412(ra) # 65a <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
     7fe:	fec42783          	lw	a5,-20(s0)
     802:	2785                	addiw	a5,a5,1
     804:	fef42623          	sw	a5,-20(s0)
     808:	fd043783          	ld	a5,-48(s0)
     80c:	0792                	slli	a5,a5,0x4
     80e:	fcf43823          	sd	a5,-48(s0)
     812:	fec42783          	lw	a5,-20(s0)
     816:	873e                	mv	a4,a5
     818:	47bd                	li	a5,15
     81a:	fce7f0e3          	bgeu	a5,a4,7da <printptr+0x3c>
}
     81e:	0001                	nop
     820:	0001                	nop
     822:	70a2                	ld	ra,40(sp)
     824:	7402                	ld	s0,32(sp)
     826:	6145                	addi	sp,sp,48
     828:	8082                	ret

000000000000082a <vprintf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
     82a:	715d                	addi	sp,sp,-80
     82c:	e486                	sd	ra,72(sp)
     82e:	e0a2                	sd	s0,64(sp)
     830:	0880                	addi	s0,sp,80
     832:	87aa                	mv	a5,a0
     834:	fcb43023          	sd	a1,-64(s0)
     838:	fac43c23          	sd	a2,-72(s0)
     83c:	fcf42623          	sw	a5,-52(s0)
  char *s;
  int c, i, state;

  state = 0;
     840:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     844:	fe042223          	sw	zero,-28(s0)
     848:	a42d                	j	a72 <vprintf+0x248>
    c = fmt[i] & 0xff;
     84a:	fe442783          	lw	a5,-28(s0)
     84e:	fc043703          	ld	a4,-64(s0)
     852:	97ba                	add	a5,a5,a4
     854:	0007c783          	lbu	a5,0(a5)
     858:	fcf42e23          	sw	a5,-36(s0)
    if(state == 0){
     85c:	fe042783          	lw	a5,-32(s0)
     860:	2781                	sext.w	a5,a5
     862:	eb9d                	bnez	a5,898 <vprintf+0x6e>
      if(c == '%'){
     864:	fdc42783          	lw	a5,-36(s0)
     868:	0007871b          	sext.w	a4,a5
     86c:	02500793          	li	a5,37
     870:	00f71763          	bne	a4,a5,87e <vprintf+0x54>
        state = '%';
     874:	02500793          	li	a5,37
     878:	fef42023          	sw	a5,-32(s0)
     87c:	a2f5                	j	a68 <vprintf+0x23e>
      } else {
        putc(fd, c);
     87e:	fdc42783          	lw	a5,-36(s0)
     882:	0ff7f713          	andi	a4,a5,255
     886:	fcc42783          	lw	a5,-52(s0)
     88a:	85ba                	mv	a1,a4
     88c:	853e                	mv	a0,a5
     88e:	00000097          	auipc	ra,0x0
     892:	dcc080e7          	jalr	-564(ra) # 65a <putc>
     896:	aac9                	j	a68 <vprintf+0x23e>
      }
    } else if(state == '%'){
     898:	fe042783          	lw	a5,-32(s0)
     89c:	0007871b          	sext.w	a4,a5
     8a0:	02500793          	li	a5,37
     8a4:	1cf71263          	bne	a4,a5,a68 <vprintf+0x23e>
      if(c == 'd'){
     8a8:	fdc42783          	lw	a5,-36(s0)
     8ac:	0007871b          	sext.w	a4,a5
     8b0:	06400793          	li	a5,100
     8b4:	02f71463          	bne	a4,a5,8dc <vprintf+0xb2>
        printint(fd, va_arg(ap, int), 10, 1);
     8b8:	fb843783          	ld	a5,-72(s0)
     8bc:	00878713          	addi	a4,a5,8
     8c0:	fae43c23          	sd	a4,-72(s0)
     8c4:	4398                	lw	a4,0(a5)
     8c6:	fcc42783          	lw	a5,-52(s0)
     8ca:	4685                	li	a3,1
     8cc:	4629                	li	a2,10
     8ce:	85ba                	mv	a1,a4
     8d0:	853e                	mv	a0,a5
     8d2:	00000097          	auipc	ra,0x0
     8d6:	dbe080e7          	jalr	-578(ra) # 690 <printint>
     8da:	a269                	j	a64 <vprintf+0x23a>
      } else if(c == 'l') {
     8dc:	fdc42783          	lw	a5,-36(s0)
     8e0:	0007871b          	sext.w	a4,a5
     8e4:	06c00793          	li	a5,108
     8e8:	02f71663          	bne	a4,a5,914 <vprintf+0xea>
        printint(fd, va_arg(ap, uint64), 10, 0);
     8ec:	fb843783          	ld	a5,-72(s0)
     8f0:	00878713          	addi	a4,a5,8
     8f4:	fae43c23          	sd	a4,-72(s0)
     8f8:	639c                	ld	a5,0(a5)
     8fa:	0007871b          	sext.w	a4,a5
     8fe:	fcc42783          	lw	a5,-52(s0)
     902:	4681                	li	a3,0
     904:	4629                	li	a2,10
     906:	85ba                	mv	a1,a4
     908:	853e                	mv	a0,a5
     90a:	00000097          	auipc	ra,0x0
     90e:	d86080e7          	jalr	-634(ra) # 690 <printint>
     912:	aa89                	j	a64 <vprintf+0x23a>
      } else if(c == 'x') {
     914:	fdc42783          	lw	a5,-36(s0)
     918:	0007871b          	sext.w	a4,a5
     91c:	07800793          	li	a5,120
     920:	02f71463          	bne	a4,a5,948 <vprintf+0x11e>
        printint(fd, va_arg(ap, int), 16, 0);
     924:	fb843783          	ld	a5,-72(s0)
     928:	00878713          	addi	a4,a5,8
     92c:	fae43c23          	sd	a4,-72(s0)
     930:	4398                	lw	a4,0(a5)
     932:	fcc42783          	lw	a5,-52(s0)
     936:	4681                	li	a3,0
     938:	4641                	li	a2,16
     93a:	85ba                	mv	a1,a4
     93c:	853e                	mv	a0,a5
     93e:	00000097          	auipc	ra,0x0
     942:	d52080e7          	jalr	-686(ra) # 690 <printint>
     946:	aa39                	j	a64 <vprintf+0x23a>
      } else if(c == 'p') {
     948:	fdc42783          	lw	a5,-36(s0)
     94c:	0007871b          	sext.w	a4,a5
     950:	07000793          	li	a5,112
     954:	02f71263          	bne	a4,a5,978 <vprintf+0x14e>
        printptr(fd, va_arg(ap, uint64));
     958:	fb843783          	ld	a5,-72(s0)
     95c:	00878713          	addi	a4,a5,8
     960:	fae43c23          	sd	a4,-72(s0)
     964:	6398                	ld	a4,0(a5)
     966:	fcc42783          	lw	a5,-52(s0)
     96a:	85ba                	mv	a1,a4
     96c:	853e                	mv	a0,a5
     96e:	00000097          	auipc	ra,0x0
     972:	e30080e7          	jalr	-464(ra) # 79e <printptr>
     976:	a0fd                	j	a64 <vprintf+0x23a>
      } else if(c == 's'){
     978:	fdc42783          	lw	a5,-36(s0)
     97c:	0007871b          	sext.w	a4,a5
     980:	07300793          	li	a5,115
     984:	04f71c63          	bne	a4,a5,9dc <vprintf+0x1b2>
        s = va_arg(ap, char*);
     988:	fb843783          	ld	a5,-72(s0)
     98c:	00878713          	addi	a4,a5,8
     990:	fae43c23          	sd	a4,-72(s0)
     994:	639c                	ld	a5,0(a5)
     996:	fef43423          	sd	a5,-24(s0)
        if(s == 0)
     99a:	fe843783          	ld	a5,-24(s0)
     99e:	eb8d                	bnez	a5,9d0 <vprintf+0x1a6>
          s = "(null)";
     9a0:	00001797          	auipc	a5,0x1
     9a4:	57078793          	addi	a5,a5,1392 # 1f10 <schedule_rm+0x2f6>
     9a8:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9ac:	a015                	j	9d0 <vprintf+0x1a6>
          putc(fd, *s);
     9ae:	fe843783          	ld	a5,-24(s0)
     9b2:	0007c703          	lbu	a4,0(a5)
     9b6:	fcc42783          	lw	a5,-52(s0)
     9ba:	85ba                	mv	a1,a4
     9bc:	853e                	mv	a0,a5
     9be:	00000097          	auipc	ra,0x0
     9c2:	c9c080e7          	jalr	-868(ra) # 65a <putc>
          s++;
     9c6:	fe843783          	ld	a5,-24(s0)
     9ca:	0785                	addi	a5,a5,1
     9cc:	fef43423          	sd	a5,-24(s0)
        while(*s != 0){
     9d0:	fe843783          	ld	a5,-24(s0)
     9d4:	0007c783          	lbu	a5,0(a5)
     9d8:	fbf9                	bnez	a5,9ae <vprintf+0x184>
     9da:	a069                	j	a64 <vprintf+0x23a>
        }
      } else if(c == 'c'){
     9dc:	fdc42783          	lw	a5,-36(s0)
     9e0:	0007871b          	sext.w	a4,a5
     9e4:	06300793          	li	a5,99
     9e8:	02f71463          	bne	a4,a5,a10 <vprintf+0x1e6>
        putc(fd, va_arg(ap, uint));
     9ec:	fb843783          	ld	a5,-72(s0)
     9f0:	00878713          	addi	a4,a5,8
     9f4:	fae43c23          	sd	a4,-72(s0)
     9f8:	439c                	lw	a5,0(a5)
     9fa:	0ff7f713          	andi	a4,a5,255
     9fe:	fcc42783          	lw	a5,-52(s0)
     a02:	85ba                	mv	a1,a4
     a04:	853e                	mv	a0,a5
     a06:	00000097          	auipc	ra,0x0
     a0a:	c54080e7          	jalr	-940(ra) # 65a <putc>
     a0e:	a899                	j	a64 <vprintf+0x23a>
      } else if(c == '%'){
     a10:	fdc42783          	lw	a5,-36(s0)
     a14:	0007871b          	sext.w	a4,a5
     a18:	02500793          	li	a5,37
     a1c:	00f71f63          	bne	a4,a5,a3a <vprintf+0x210>
        putc(fd, c);
     a20:	fdc42783          	lw	a5,-36(s0)
     a24:	0ff7f713          	andi	a4,a5,255
     a28:	fcc42783          	lw	a5,-52(s0)
     a2c:	85ba                	mv	a1,a4
     a2e:	853e                	mv	a0,a5
     a30:	00000097          	auipc	ra,0x0
     a34:	c2a080e7          	jalr	-982(ra) # 65a <putc>
     a38:	a035                	j	a64 <vprintf+0x23a>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
     a3a:	fcc42783          	lw	a5,-52(s0)
     a3e:	02500593          	li	a1,37
     a42:	853e                	mv	a0,a5
     a44:	00000097          	auipc	ra,0x0
     a48:	c16080e7          	jalr	-1002(ra) # 65a <putc>
        putc(fd, c);
     a4c:	fdc42783          	lw	a5,-36(s0)
     a50:	0ff7f713          	andi	a4,a5,255
     a54:	fcc42783          	lw	a5,-52(s0)
     a58:	85ba                	mv	a1,a4
     a5a:	853e                	mv	a0,a5
     a5c:	00000097          	auipc	ra,0x0
     a60:	bfe080e7          	jalr	-1026(ra) # 65a <putc>
      }
      state = 0;
     a64:	fe042023          	sw	zero,-32(s0)
  for(i = 0; fmt[i]; i++){
     a68:	fe442783          	lw	a5,-28(s0)
     a6c:	2785                	addiw	a5,a5,1
     a6e:	fef42223          	sw	a5,-28(s0)
     a72:	fe442783          	lw	a5,-28(s0)
     a76:	fc043703          	ld	a4,-64(s0)
     a7a:	97ba                	add	a5,a5,a4
     a7c:	0007c783          	lbu	a5,0(a5)
     a80:	dc0795e3          	bnez	a5,84a <vprintf+0x20>
    }
  }
}
     a84:	0001                	nop
     a86:	0001                	nop
     a88:	60a6                	ld	ra,72(sp)
     a8a:	6406                	ld	s0,64(sp)
     a8c:	6161                	addi	sp,sp,80
     a8e:	8082                	ret

0000000000000a90 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
     a90:	7159                	addi	sp,sp,-112
     a92:	fc06                	sd	ra,56(sp)
     a94:	f822                	sd	s0,48(sp)
     a96:	0080                	addi	s0,sp,64
     a98:	fcb43823          	sd	a1,-48(s0)
     a9c:	e010                	sd	a2,0(s0)
     a9e:	e414                	sd	a3,8(s0)
     aa0:	e818                	sd	a4,16(s0)
     aa2:	ec1c                	sd	a5,24(s0)
     aa4:	03043023          	sd	a6,32(s0)
     aa8:	03143423          	sd	a7,40(s0)
     aac:	87aa                	mv	a5,a0
     aae:	fcf42e23          	sw	a5,-36(s0)
  va_list ap;

  va_start(ap, fmt);
     ab2:	03040793          	addi	a5,s0,48
     ab6:	fcf43423          	sd	a5,-56(s0)
     aba:	fc843783          	ld	a5,-56(s0)
     abe:	fd078793          	addi	a5,a5,-48
     ac2:	fef43423          	sd	a5,-24(s0)
  vprintf(fd, fmt, ap);
     ac6:	fe843703          	ld	a4,-24(s0)
     aca:	fdc42783          	lw	a5,-36(s0)
     ace:	863a                	mv	a2,a4
     ad0:	fd043583          	ld	a1,-48(s0)
     ad4:	853e                	mv	a0,a5
     ad6:	00000097          	auipc	ra,0x0
     ada:	d54080e7          	jalr	-684(ra) # 82a <vprintf>
}
     ade:	0001                	nop
     ae0:	70e2                	ld	ra,56(sp)
     ae2:	7442                	ld	s0,48(sp)
     ae4:	6165                	addi	sp,sp,112
     ae6:	8082                	ret

0000000000000ae8 <printf>:

void
printf(const char *fmt, ...)
{
     ae8:	7159                	addi	sp,sp,-112
     aea:	f406                	sd	ra,40(sp)
     aec:	f022                	sd	s0,32(sp)
     aee:	1800                	addi	s0,sp,48
     af0:	fca43c23          	sd	a0,-40(s0)
     af4:	e40c                	sd	a1,8(s0)
     af6:	e810                	sd	a2,16(s0)
     af8:	ec14                	sd	a3,24(s0)
     afa:	f018                	sd	a4,32(s0)
     afc:	f41c                	sd	a5,40(s0)
     afe:	03043823          	sd	a6,48(s0)
     b02:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
     b06:	04040793          	addi	a5,s0,64
     b0a:	fcf43823          	sd	a5,-48(s0)
     b0e:	fd043783          	ld	a5,-48(s0)
     b12:	fc878793          	addi	a5,a5,-56
     b16:	fef43423          	sd	a5,-24(s0)
  vprintf(1, fmt, ap);
     b1a:	fe843783          	ld	a5,-24(s0)
     b1e:	863e                	mv	a2,a5
     b20:	fd843583          	ld	a1,-40(s0)
     b24:	4505                	li	a0,1
     b26:	00000097          	auipc	ra,0x0
     b2a:	d04080e7          	jalr	-764(ra) # 82a <vprintf>
}
     b2e:	0001                	nop
     b30:	70a2                	ld	ra,40(sp)
     b32:	7402                	ld	s0,32(sp)
     b34:	6165                	addi	sp,sp,112
     b36:	8082                	ret

0000000000000b38 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
     b38:	7179                	addi	sp,sp,-48
     b3a:	f422                	sd	s0,40(sp)
     b3c:	1800                	addi	s0,sp,48
     b3e:	fca43c23          	sd	a0,-40(s0)
  Header *bp, *p;

  bp = (Header*)ap - 1;
     b42:	fd843783          	ld	a5,-40(s0)
     b46:	17c1                	addi	a5,a5,-16
     b48:	fef43023          	sd	a5,-32(s0)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b4c:	00001797          	auipc	a5,0x1
     b50:	54c78793          	addi	a5,a5,1356 # 2098 <freep>
     b54:	639c                	ld	a5,0(a5)
     b56:	fef43423          	sd	a5,-24(s0)
     b5a:	a815                	j	b8e <free+0x56>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
     b5c:	fe843783          	ld	a5,-24(s0)
     b60:	639c                	ld	a5,0(a5)
     b62:	fe843703          	ld	a4,-24(s0)
     b66:	00f76f63          	bltu	a4,a5,b84 <free+0x4c>
     b6a:	fe043703          	ld	a4,-32(s0)
     b6e:	fe843783          	ld	a5,-24(s0)
     b72:	02e7eb63          	bltu	a5,a4,ba8 <free+0x70>
     b76:	fe843783          	ld	a5,-24(s0)
     b7a:	639c                	ld	a5,0(a5)
     b7c:	fe043703          	ld	a4,-32(s0)
     b80:	02f76463          	bltu	a4,a5,ba8 <free+0x70>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
     b84:	fe843783          	ld	a5,-24(s0)
     b88:	639c                	ld	a5,0(a5)
     b8a:	fef43423          	sd	a5,-24(s0)
     b8e:	fe043703          	ld	a4,-32(s0)
     b92:	fe843783          	ld	a5,-24(s0)
     b96:	fce7f3e3          	bgeu	a5,a4,b5c <free+0x24>
     b9a:	fe843783          	ld	a5,-24(s0)
     b9e:	639c                	ld	a5,0(a5)
     ba0:	fe043703          	ld	a4,-32(s0)
     ba4:	faf77ce3          	bgeu	a4,a5,b5c <free+0x24>
      break;
  if(bp + bp->s.size == p->s.ptr){
     ba8:	fe043783          	ld	a5,-32(s0)
     bac:	479c                	lw	a5,8(a5)
     bae:	1782                	slli	a5,a5,0x20
     bb0:	9381                	srli	a5,a5,0x20
     bb2:	0792                	slli	a5,a5,0x4
     bb4:	fe043703          	ld	a4,-32(s0)
     bb8:	973e                	add	a4,a4,a5
     bba:	fe843783          	ld	a5,-24(s0)
     bbe:	639c                	ld	a5,0(a5)
     bc0:	02f71763          	bne	a4,a5,bee <free+0xb6>
    bp->s.size += p->s.ptr->s.size;
     bc4:	fe043783          	ld	a5,-32(s0)
     bc8:	4798                	lw	a4,8(a5)
     bca:	fe843783          	ld	a5,-24(s0)
     bce:	639c                	ld	a5,0(a5)
     bd0:	479c                	lw	a5,8(a5)
     bd2:	9fb9                	addw	a5,a5,a4
     bd4:	0007871b          	sext.w	a4,a5
     bd8:	fe043783          	ld	a5,-32(s0)
     bdc:	c798                	sw	a4,8(a5)
    bp->s.ptr = p->s.ptr->s.ptr;
     bde:	fe843783          	ld	a5,-24(s0)
     be2:	639c                	ld	a5,0(a5)
     be4:	6398                	ld	a4,0(a5)
     be6:	fe043783          	ld	a5,-32(s0)
     bea:	e398                	sd	a4,0(a5)
     bec:	a039                	j	bfa <free+0xc2>
  } else
    bp->s.ptr = p->s.ptr;
     bee:	fe843783          	ld	a5,-24(s0)
     bf2:	6398                	ld	a4,0(a5)
     bf4:	fe043783          	ld	a5,-32(s0)
     bf8:	e398                	sd	a4,0(a5)
  if(p + p->s.size == bp){
     bfa:	fe843783          	ld	a5,-24(s0)
     bfe:	479c                	lw	a5,8(a5)
     c00:	1782                	slli	a5,a5,0x20
     c02:	9381                	srli	a5,a5,0x20
     c04:	0792                	slli	a5,a5,0x4
     c06:	fe843703          	ld	a4,-24(s0)
     c0a:	97ba                	add	a5,a5,a4
     c0c:	fe043703          	ld	a4,-32(s0)
     c10:	02f71563          	bne	a4,a5,c3a <free+0x102>
    p->s.size += bp->s.size;
     c14:	fe843783          	ld	a5,-24(s0)
     c18:	4798                	lw	a4,8(a5)
     c1a:	fe043783          	ld	a5,-32(s0)
     c1e:	479c                	lw	a5,8(a5)
     c20:	9fb9                	addw	a5,a5,a4
     c22:	0007871b          	sext.w	a4,a5
     c26:	fe843783          	ld	a5,-24(s0)
     c2a:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
     c2c:	fe043783          	ld	a5,-32(s0)
     c30:	6398                	ld	a4,0(a5)
     c32:	fe843783          	ld	a5,-24(s0)
     c36:	e398                	sd	a4,0(a5)
     c38:	a031                	j	c44 <free+0x10c>
  } else
    p->s.ptr = bp;
     c3a:	fe843783          	ld	a5,-24(s0)
     c3e:	fe043703          	ld	a4,-32(s0)
     c42:	e398                	sd	a4,0(a5)
  freep = p;
     c44:	00001797          	auipc	a5,0x1
     c48:	45478793          	addi	a5,a5,1108 # 2098 <freep>
     c4c:	fe843703          	ld	a4,-24(s0)
     c50:	e398                	sd	a4,0(a5)
}
     c52:	0001                	nop
     c54:	7422                	ld	s0,40(sp)
     c56:	6145                	addi	sp,sp,48
     c58:	8082                	ret

0000000000000c5a <morecore>:

static Header*
morecore(uint nu)
{
     c5a:	7179                	addi	sp,sp,-48
     c5c:	f406                	sd	ra,40(sp)
     c5e:	f022                	sd	s0,32(sp)
     c60:	1800                	addi	s0,sp,48
     c62:	87aa                	mv	a5,a0
     c64:	fcf42e23          	sw	a5,-36(s0)
  char *p;
  Header *hp;

  if(nu < 4096)
     c68:	fdc42783          	lw	a5,-36(s0)
     c6c:	0007871b          	sext.w	a4,a5
     c70:	6785                	lui	a5,0x1
     c72:	00f77563          	bgeu	a4,a5,c7c <morecore+0x22>
    nu = 4096;
     c76:	6785                	lui	a5,0x1
     c78:	fcf42e23          	sw	a5,-36(s0)
  p = sbrk(nu * sizeof(Header));
     c7c:	fdc42783          	lw	a5,-36(s0)
     c80:	0047979b          	slliw	a5,a5,0x4
     c84:	2781                	sext.w	a5,a5
     c86:	2781                	sext.w	a5,a5
     c88:	853e                	mv	a0,a5
     c8a:	00000097          	auipc	ra,0x0
     c8e:	9a0080e7          	jalr	-1632(ra) # 62a <sbrk>
     c92:	fea43423          	sd	a0,-24(s0)
  if(p == (char*)-1)
     c96:	fe843703          	ld	a4,-24(s0)
     c9a:	57fd                	li	a5,-1
     c9c:	00f71463          	bne	a4,a5,ca4 <morecore+0x4a>
    return 0;
     ca0:	4781                	li	a5,0
     ca2:	a03d                	j	cd0 <morecore+0x76>
  hp = (Header*)p;
     ca4:	fe843783          	ld	a5,-24(s0)
     ca8:	fef43023          	sd	a5,-32(s0)
  hp->s.size = nu;
     cac:	fe043783          	ld	a5,-32(s0)
     cb0:	fdc42703          	lw	a4,-36(s0)
     cb4:	c798                	sw	a4,8(a5)
  free((void*)(hp + 1));
     cb6:	fe043783          	ld	a5,-32(s0)
     cba:	07c1                	addi	a5,a5,16
     cbc:	853e                	mv	a0,a5
     cbe:	00000097          	auipc	ra,0x0
     cc2:	e7a080e7          	jalr	-390(ra) # b38 <free>
  return freep;
     cc6:	00001797          	auipc	a5,0x1
     cca:	3d278793          	addi	a5,a5,978 # 2098 <freep>
     cce:	639c                	ld	a5,0(a5)
}
     cd0:	853e                	mv	a0,a5
     cd2:	70a2                	ld	ra,40(sp)
     cd4:	7402                	ld	s0,32(sp)
     cd6:	6145                	addi	sp,sp,48
     cd8:	8082                	ret

0000000000000cda <malloc>:

void*
malloc(uint nbytes)
{
     cda:	7139                	addi	sp,sp,-64
     cdc:	fc06                	sd	ra,56(sp)
     cde:	f822                	sd	s0,48(sp)
     ce0:	0080                	addi	s0,sp,64
     ce2:	87aa                	mv	a5,a0
     ce4:	fcf42623          	sw	a5,-52(s0)
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
     ce8:	fcc46783          	lwu	a5,-52(s0)
     cec:	07bd                	addi	a5,a5,15
     cee:	8391                	srli	a5,a5,0x4
     cf0:	2781                	sext.w	a5,a5
     cf2:	2785                	addiw	a5,a5,1
     cf4:	fcf42e23          	sw	a5,-36(s0)
  if((prevp = freep) == 0){
     cf8:	00001797          	auipc	a5,0x1
     cfc:	3a078793          	addi	a5,a5,928 # 2098 <freep>
     d00:	639c                	ld	a5,0(a5)
     d02:	fef43023          	sd	a5,-32(s0)
     d06:	fe043783          	ld	a5,-32(s0)
     d0a:	ef95                	bnez	a5,d46 <malloc+0x6c>
    base.s.ptr = freep = prevp = &base;
     d0c:	00001797          	auipc	a5,0x1
     d10:	37c78793          	addi	a5,a5,892 # 2088 <base>
     d14:	fef43023          	sd	a5,-32(s0)
     d18:	00001797          	auipc	a5,0x1
     d1c:	38078793          	addi	a5,a5,896 # 2098 <freep>
     d20:	fe043703          	ld	a4,-32(s0)
     d24:	e398                	sd	a4,0(a5)
     d26:	00001797          	auipc	a5,0x1
     d2a:	37278793          	addi	a5,a5,882 # 2098 <freep>
     d2e:	6398                	ld	a4,0(a5)
     d30:	00001797          	auipc	a5,0x1
     d34:	35878793          	addi	a5,a5,856 # 2088 <base>
     d38:	e398                	sd	a4,0(a5)
    base.s.size = 0;
     d3a:	00001797          	auipc	a5,0x1
     d3e:	34e78793          	addi	a5,a5,846 # 2088 <base>
     d42:	0007a423          	sw	zero,8(a5)
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     d46:	fe043783          	ld	a5,-32(s0)
     d4a:	639c                	ld	a5,0(a5)
     d4c:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     d50:	fe843783          	ld	a5,-24(s0)
     d54:	4798                	lw	a4,8(a5)
     d56:	fdc42783          	lw	a5,-36(s0)
     d5a:	2781                	sext.w	a5,a5
     d5c:	06f76863          	bltu	a4,a5,dcc <malloc+0xf2>
      if(p->s.size == nunits)
     d60:	fe843783          	ld	a5,-24(s0)
     d64:	4798                	lw	a4,8(a5)
     d66:	fdc42783          	lw	a5,-36(s0)
     d6a:	2781                	sext.w	a5,a5
     d6c:	00e79963          	bne	a5,a4,d7e <malloc+0xa4>
        prevp->s.ptr = p->s.ptr;
     d70:	fe843783          	ld	a5,-24(s0)
     d74:	6398                	ld	a4,0(a5)
     d76:	fe043783          	ld	a5,-32(s0)
     d7a:	e398                	sd	a4,0(a5)
     d7c:	a82d                	j	db6 <malloc+0xdc>
      else {
        p->s.size -= nunits;
     d7e:	fe843783          	ld	a5,-24(s0)
     d82:	4798                	lw	a4,8(a5)
     d84:	fdc42783          	lw	a5,-36(s0)
     d88:	40f707bb          	subw	a5,a4,a5
     d8c:	0007871b          	sext.w	a4,a5
     d90:	fe843783          	ld	a5,-24(s0)
     d94:	c798                	sw	a4,8(a5)
        p += p->s.size;
     d96:	fe843783          	ld	a5,-24(s0)
     d9a:	479c                	lw	a5,8(a5)
     d9c:	1782                	slli	a5,a5,0x20
     d9e:	9381                	srli	a5,a5,0x20
     da0:	0792                	slli	a5,a5,0x4
     da2:	fe843703          	ld	a4,-24(s0)
     da6:	97ba                	add	a5,a5,a4
     da8:	fef43423          	sd	a5,-24(s0)
        p->s.size = nunits;
     dac:	fe843783          	ld	a5,-24(s0)
     db0:	fdc42703          	lw	a4,-36(s0)
     db4:	c798                	sw	a4,8(a5)
      }
      freep = prevp;
     db6:	00001797          	auipc	a5,0x1
     dba:	2e278793          	addi	a5,a5,738 # 2098 <freep>
     dbe:	fe043703          	ld	a4,-32(s0)
     dc2:	e398                	sd	a4,0(a5)
      return (void*)(p + 1);
     dc4:	fe843783          	ld	a5,-24(s0)
     dc8:	07c1                	addi	a5,a5,16
     dca:	a091                	j	e0e <malloc+0x134>
    }
    if(p == freep)
     dcc:	00001797          	auipc	a5,0x1
     dd0:	2cc78793          	addi	a5,a5,716 # 2098 <freep>
     dd4:	639c                	ld	a5,0(a5)
     dd6:	fe843703          	ld	a4,-24(s0)
     dda:	02f71063          	bne	a4,a5,dfa <malloc+0x120>
      if((p = morecore(nunits)) == 0)
     dde:	fdc42783          	lw	a5,-36(s0)
     de2:	853e                	mv	a0,a5
     de4:	00000097          	auipc	ra,0x0
     de8:	e76080e7          	jalr	-394(ra) # c5a <morecore>
     dec:	fea43423          	sd	a0,-24(s0)
     df0:	fe843783          	ld	a5,-24(s0)
     df4:	e399                	bnez	a5,dfa <malloc+0x120>
        return 0;
     df6:	4781                	li	a5,0
     df8:	a819                	j	e0e <malloc+0x134>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
     dfa:	fe843783          	ld	a5,-24(s0)
     dfe:	fef43023          	sd	a5,-32(s0)
     e02:	fe843783          	ld	a5,-24(s0)
     e06:	639c                	ld	a5,0(a5)
     e08:	fef43423          	sd	a5,-24(s0)
    if(p->s.size >= nunits){
     e0c:	b791                	j	d50 <malloc+0x76>
  }
}
     e0e:	853e                	mv	a0,a5
     e10:	70e2                	ld	ra,56(sp)
     e12:	7442                	ld	s0,48(sp)
     e14:	6121                	addi	sp,sp,64
     e16:	8082                	ret

0000000000000e18 <setjmp>:
     e18:	e100                	sd	s0,0(a0)
     e1a:	e504                	sd	s1,8(a0)
     e1c:	01253823          	sd	s2,16(a0)
     e20:	01353c23          	sd	s3,24(a0)
     e24:	03453023          	sd	s4,32(a0)
     e28:	03553423          	sd	s5,40(a0)
     e2c:	03653823          	sd	s6,48(a0)
     e30:	03753c23          	sd	s7,56(a0)
     e34:	05853023          	sd	s8,64(a0)
     e38:	05953423          	sd	s9,72(a0)
     e3c:	05a53823          	sd	s10,80(a0)
     e40:	05b53c23          	sd	s11,88(a0)
     e44:	06153023          	sd	ra,96(a0)
     e48:	06253423          	sd	sp,104(a0)
     e4c:	4501                	li	a0,0
     e4e:	8082                	ret

0000000000000e50 <longjmp>:
     e50:	6100                	ld	s0,0(a0)
     e52:	6504                	ld	s1,8(a0)
     e54:	01053903          	ld	s2,16(a0)
     e58:	01853983          	ld	s3,24(a0)
     e5c:	02053a03          	ld	s4,32(a0)
     e60:	02853a83          	ld	s5,40(a0)
     e64:	03053b03          	ld	s6,48(a0)
     e68:	03853b83          	ld	s7,56(a0)
     e6c:	04053c03          	ld	s8,64(a0)
     e70:	04853c83          	ld	s9,72(a0)
     e74:	05053d03          	ld	s10,80(a0)
     e78:	05853d83          	ld	s11,88(a0)
     e7c:	06053083          	ld	ra,96(a0)
     e80:	06853103          	ld	sp,104(a0)
     e84:	c199                	beqz	a1,e8a <longjmp_1>
     e86:	852e                	mv	a0,a1
     e88:	8082                	ret

0000000000000e8a <longjmp_1>:
     e8a:	4505                	li	a0,1
     e8c:	8082                	ret

0000000000000e8e <__list_add>:
 * the prev/next entries already!
 */
static inline void __list_add(struct list_head *new_entry,
                              struct list_head *prev,
                              struct list_head *next)
{
     e8e:	7179                	addi	sp,sp,-48
     e90:	f422                	sd	s0,40(sp)
     e92:	1800                	addi	s0,sp,48
     e94:	fea43423          	sd	a0,-24(s0)
     e98:	feb43023          	sd	a1,-32(s0)
     e9c:	fcc43c23          	sd	a2,-40(s0)
    next->prev = new_entry;
     ea0:	fd843783          	ld	a5,-40(s0)
     ea4:	fe843703          	ld	a4,-24(s0)
     ea8:	e798                	sd	a4,8(a5)
    new_entry->next = next;
     eaa:	fe843783          	ld	a5,-24(s0)
     eae:	fd843703          	ld	a4,-40(s0)
     eb2:	e398                	sd	a4,0(a5)
    new_entry->prev = prev;
     eb4:	fe843783          	ld	a5,-24(s0)
     eb8:	fe043703          	ld	a4,-32(s0)
     ebc:	e798                	sd	a4,8(a5)
    prev->next = new_entry;
     ebe:	fe043783          	ld	a5,-32(s0)
     ec2:	fe843703          	ld	a4,-24(s0)
     ec6:	e398                	sd	a4,0(a5)
}
     ec8:	0001                	nop
     eca:	7422                	ld	s0,40(sp)
     ecc:	6145                	addi	sp,sp,48
     ece:	8082                	ret

0000000000000ed0 <list_add_tail>:
 *
 * Insert a new entry before the specified head.
 * This is useful for implementing queues.
 */
static inline void list_add_tail(struct list_head *new_entry, struct list_head *head)
{
     ed0:	1101                	addi	sp,sp,-32
     ed2:	ec06                	sd	ra,24(sp)
     ed4:	e822                	sd	s0,16(sp)
     ed6:	1000                	addi	s0,sp,32
     ed8:	fea43423          	sd	a0,-24(s0)
     edc:	feb43023          	sd	a1,-32(s0)
    __list_add(new_entry, head->prev, head);
     ee0:	fe043783          	ld	a5,-32(s0)
     ee4:	679c                	ld	a5,8(a5)
     ee6:	fe043603          	ld	a2,-32(s0)
     eea:	85be                	mv	a1,a5
     eec:	fe843503          	ld	a0,-24(s0)
     ef0:	00000097          	auipc	ra,0x0
     ef4:	f9e080e7          	jalr	-98(ra) # e8e <__list_add>
}
     ef8:	0001                	nop
     efa:	60e2                	ld	ra,24(sp)
     efc:	6442                	ld	s0,16(sp)
     efe:	6105                	addi	sp,sp,32
     f00:	8082                	ret

0000000000000f02 <__list_del>:
 *
 * This is only for internal list manipulation where we know
 * the prev/next entries already!
 */
static inline void __list_del(struct list_head *prev, struct list_head *next)
{
     f02:	1101                	addi	sp,sp,-32
     f04:	ec22                	sd	s0,24(sp)
     f06:	1000                	addi	s0,sp,32
     f08:	fea43423          	sd	a0,-24(s0)
     f0c:	feb43023          	sd	a1,-32(s0)
    next->prev = prev;
     f10:	fe043783          	ld	a5,-32(s0)
     f14:	fe843703          	ld	a4,-24(s0)
     f18:	e798                	sd	a4,8(a5)
    prev->next = next;
     f1a:	fe843783          	ld	a5,-24(s0)
     f1e:	fe043703          	ld	a4,-32(s0)
     f22:	e398                	sd	a4,0(a5)
}
     f24:	0001                	nop
     f26:	6462                	ld	s0,24(sp)
     f28:	6105                	addi	sp,sp,32
     f2a:	8082                	ret

0000000000000f2c <list_del>:
 * @entry: the element to delete from the list.
 * Note: list_empty on entry does not return true after this, the entry is
 * in an undefined state.
 */
static inline void list_del(struct list_head *entry)
{
     f2c:	1101                	addi	sp,sp,-32
     f2e:	ec06                	sd	ra,24(sp)
     f30:	e822                	sd	s0,16(sp)
     f32:	1000                	addi	s0,sp,32
     f34:	fea43423          	sd	a0,-24(s0)
    __list_del(entry->prev, entry->next);
     f38:	fe843783          	ld	a5,-24(s0)
     f3c:	6798                	ld	a4,8(a5)
     f3e:	fe843783          	ld	a5,-24(s0)
     f42:	639c                	ld	a5,0(a5)
     f44:	85be                	mv	a1,a5
     f46:	853a                	mv	a0,a4
     f48:	00000097          	auipc	ra,0x0
     f4c:	fba080e7          	jalr	-70(ra) # f02 <__list_del>
    entry->next = LIST_POISON1;
     f50:	fe843783          	ld	a5,-24(s0)
     f54:	00100737          	lui	a4,0x100
     f58:	10070713          	addi	a4,a4,256 # 100100 <__global_pointer$+0xfd8c0>
     f5c:	e398                	sd	a4,0(a5)
    entry->prev = LIST_POISON2;
     f5e:	fe843783          	ld	a5,-24(s0)
     f62:	00200737          	lui	a4,0x200
     f66:	20070713          	addi	a4,a4,512 # 200200 <__global_pointer$+0x1fd9c0>
     f6a:	e798                	sd	a4,8(a5)
}
     f6c:	0001                	nop
     f6e:	60e2                	ld	ra,24(sp)
     f70:	6442                	ld	s0,16(sp)
     f72:	6105                	addi	sp,sp,32
     f74:	8082                	ret

0000000000000f76 <list_empty>:
/**
 * list_empty - tests whether a list is empty
 * @head: the list to test.
 */
static inline int list_empty(const struct list_head *head)
{
     f76:	1101                	addi	sp,sp,-32
     f78:	ec22                	sd	s0,24(sp)
     f7a:	1000                	addi	s0,sp,32
     f7c:	fea43423          	sd	a0,-24(s0)
    return head->next == head;
     f80:	fe843783          	ld	a5,-24(s0)
     f84:	639c                	ld	a5,0(a5)
     f86:	fe843703          	ld	a4,-24(s0)
     f8a:	40f707b3          	sub	a5,a4,a5
     f8e:	0017b793          	seqz	a5,a5
     f92:	0ff7f793          	andi	a5,a5,255
     f96:	2781                	sext.w	a5,a5
}
     f98:	853e                	mv	a0,a5
     f9a:	6462                	ld	s0,24(sp)
     f9c:	6105                	addi	sp,sp,32
     f9e:	8082                	ret

0000000000000fa0 <thread_create>:

void __dispatch(void);
void __schedule(void);

struct thread *thread_create(void (*f)(void *), void *arg, int processing_time, int period, int n)
{
     fa0:	715d                	addi	sp,sp,-80
     fa2:	e486                	sd	ra,72(sp)
     fa4:	e0a2                	sd	s0,64(sp)
     fa6:	0880                	addi	s0,sp,80
     fa8:	fca43423          	sd	a0,-56(s0)
     fac:	fcb43023          	sd	a1,-64(s0)
     fb0:	87b2                	mv	a5,a2
     fb2:	faf42e23          	sw	a5,-68(s0)
     fb6:	87b6                	mv	a5,a3
     fb8:	faf42c23          	sw	a5,-72(s0)
     fbc:	87ba                	mv	a5,a4
     fbe:	faf42a23          	sw	a5,-76(s0)
    static int _id = 1;
    struct thread *t = (struct thread *)malloc(sizeof(struct thread));
     fc2:	05800513          	li	a0,88
     fc6:	00000097          	auipc	ra,0x0
     fca:	d14080e7          	jalr	-748(ra) # cda <malloc>
     fce:	fea43423          	sd	a0,-24(s0)
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long)malloc(sizeof(unsigned long) * 0x200);
     fd2:	6505                	lui	a0,0x1
     fd4:	00000097          	auipc	ra,0x0
     fd8:	d06080e7          	jalr	-762(ra) # cda <malloc>
     fdc:	87aa                	mv	a5,a0
     fde:	fef43023          	sd	a5,-32(s0)
    new_stack_p = new_stack + 0x200 * 8 - 0x2 * 8;
     fe2:	fe043703          	ld	a4,-32(s0)
     fe6:	6785                	lui	a5,0x1
     fe8:	17c1                	addi	a5,a5,-16
     fea:	97ba                	add	a5,a5,a4
     fec:	fcf43c23          	sd	a5,-40(s0)
    t->fp = f;
     ff0:	fe843783          	ld	a5,-24(s0)
     ff4:	fc843703          	ld	a4,-56(s0)
     ff8:	e398                	sd	a4,0(a5)
    t->arg = arg;
     ffa:	fe843783          	ld	a5,-24(s0)
     ffe:	fc043703          	ld	a4,-64(s0)
    1002:	e798                	sd	a4,8(a5)
    t->ID = _id++;
    1004:	00001797          	auipc	a5,0x1
    1008:	07c78793          	addi	a5,a5,124 # 2080 <_id.0>
    100c:	439c                	lw	a5,0(a5)
    100e:	0017871b          	addiw	a4,a5,1
    1012:	0007069b          	sext.w	a3,a4
    1016:	00001717          	auipc	a4,0x1
    101a:	06a70713          	addi	a4,a4,106 # 2080 <_id.0>
    101e:	c314                	sw	a3,0(a4)
    1020:	fe843703          	ld	a4,-24(s0)
    1024:	d31c                	sw	a5,32(a4)
    t->buf_set = 0;
    1026:	fe843783          	ld	a5,-24(s0)
    102a:	0207ac23          	sw	zero,56(a5)
    t->stack = (void *)new_stack;
    102e:	fe043703          	ld	a4,-32(s0)
    1032:	fe843783          	ld	a5,-24(s0)
    1036:	eb98                	sd	a4,16(a5)
    t->stack_p = (void *)new_stack_p;
    1038:	fd843703          	ld	a4,-40(s0)
    103c:	fe843783          	ld	a5,-24(s0)
    1040:	ef98                	sd	a4,24(a5)

    t->processing_time = processing_time;
    1042:	fe843783          	ld	a5,-24(s0)
    1046:	fbc42703          	lw	a4,-68(s0)
    104a:	c3b8                	sw	a4,64(a5)
    t->period = period;
    104c:	fe843783          	ld	a5,-24(s0)
    1050:	fb842703          	lw	a4,-72(s0)
    1054:	c3f8                	sw	a4,68(a5)
    t->n = n;
    1056:	fe843783          	ld	a5,-24(s0)
    105a:	fb442703          	lw	a4,-76(s0)
    105e:	c7b8                	sw	a4,72(a5)
    t->remaining_time = 0;
    1060:	fe843783          	ld	a5,-24(s0)
    1064:	0407a623          	sw	zero,76(a5)
    t->current_deadline = 0;
    1068:	fe843783          	ld	a5,-24(s0)
    106c:	0407a823          	sw	zero,80(a5)
    return t;
    1070:	fe843783          	ld	a5,-24(s0)
}
    1074:	853e                	mv	a0,a5
    1076:	60a6                	ld	ra,72(sp)
    1078:	6406                	ld	s0,64(sp)
    107a:	6161                	addi	sp,sp,80
    107c:	8082                	ret

000000000000107e <thread_add_at>:

void thread_add_at(struct thread *t, int arrival_time)
{
    107e:	7179                	addi	sp,sp,-48
    1080:	f406                	sd	ra,40(sp)
    1082:	f022                	sd	s0,32(sp)
    1084:	1800                	addi	s0,sp,48
    1086:	fca43c23          	sd	a0,-40(s0)
    108a:	87ae                	mv	a5,a1
    108c:	fcf42a23          	sw	a5,-44(s0)
    struct release_queue_entry *new_entry = (struct release_queue_entry *)malloc(sizeof(struct release_queue_entry));
    1090:	02000513          	li	a0,32
    1094:	00000097          	auipc	ra,0x0
    1098:	c46080e7          	jalr	-954(ra) # cda <malloc>
    109c:	fea43423          	sd	a0,-24(s0)
    new_entry->thrd = t;
    10a0:	fe843783          	ld	a5,-24(s0)
    10a4:	fd843703          	ld	a4,-40(s0)
    10a8:	e398                	sd	a4,0(a5)
    new_entry->release_time = arrival_time;
    10aa:	fe843783          	ld	a5,-24(s0)
    10ae:	fd442703          	lw	a4,-44(s0)
    10b2:	cf98                	sw	a4,24(a5)
    t->current_deadline = arrival_time;
    10b4:	fd843783          	ld	a5,-40(s0)
    10b8:	fd442703          	lw	a4,-44(s0)
    10bc:	cbb8                	sw	a4,80(a5)
    list_add_tail(&new_entry->thread_list, &release_queue);
    10be:	fe843783          	ld	a5,-24(s0)
    10c2:	07a1                	addi	a5,a5,8
    10c4:	00001597          	auipc	a1,0x1
    10c8:	fa458593          	addi	a1,a1,-92 # 2068 <release_queue>
    10cc:	853e                	mv	a0,a5
    10ce:	00000097          	auipc	ra,0x0
    10d2:	e02080e7          	jalr	-510(ra) # ed0 <list_add_tail>
}
    10d6:	0001                	nop
    10d8:	70a2                	ld	ra,40(sp)
    10da:	7402                	ld	s0,32(sp)
    10dc:	6145                	addi	sp,sp,48
    10de:	8082                	ret

00000000000010e0 <__release>:

void __release()
{
    10e0:	7139                	addi	sp,sp,-64
    10e2:	fc06                	sd	ra,56(sp)
    10e4:	f822                	sd	s0,48(sp)
    10e6:	0080                	addi	s0,sp,64
    struct release_queue_entry *cur, *nxt;
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    10e8:	00001797          	auipc	a5,0x1
    10ec:	f8078793          	addi	a5,a5,-128 # 2068 <release_queue>
    10f0:	639c                	ld	a5,0(a5)
    10f2:	fcf43c23          	sd	a5,-40(s0)
    10f6:	fd843783          	ld	a5,-40(s0)
    10fa:	17e1                	addi	a5,a5,-8
    10fc:	fef43423          	sd	a5,-24(s0)
    1100:	fe843783          	ld	a5,-24(s0)
    1104:	679c                	ld	a5,8(a5)
    1106:	fcf43823          	sd	a5,-48(s0)
    110a:	fd043783          	ld	a5,-48(s0)
    110e:	17e1                	addi	a5,a5,-8
    1110:	fef43023          	sd	a5,-32(s0)
    1114:	a851                	j	11a8 <__release+0xc8>
        if (threading_system_time >= cur->release_time) {
    1116:	fe843783          	ld	a5,-24(s0)
    111a:	4f98                	lw	a4,24(a5)
    111c:	00001797          	auipc	a5,0x1
    1120:	f8c78793          	addi	a5,a5,-116 # 20a8 <threading_system_time>
    1124:	439c                	lw	a5,0(a5)
    1126:	06e7c363          	blt	a5,a4,118c <__release+0xac>
            cur->thrd->remaining_time = cur->thrd->processing_time;
    112a:	fe843783          	ld	a5,-24(s0)
    112e:	6398                	ld	a4,0(a5)
    1130:	fe843783          	ld	a5,-24(s0)
    1134:	639c                	ld	a5,0(a5)
    1136:	4338                	lw	a4,64(a4)
    1138:	c7f8                	sw	a4,76(a5)
            cur->thrd->current_deadline = cur->release_time + cur->thrd->period;
    113a:	fe843783          	ld	a5,-24(s0)
    113e:	4f94                	lw	a3,24(a5)
    1140:	fe843783          	ld	a5,-24(s0)
    1144:	639c                	ld	a5,0(a5)
    1146:	43f8                	lw	a4,68(a5)
    1148:	fe843783          	ld	a5,-24(s0)
    114c:	639c                	ld	a5,0(a5)
    114e:	9f35                	addw	a4,a4,a3
    1150:	2701                	sext.w	a4,a4
    1152:	cbb8                	sw	a4,80(a5)
            list_add_tail(&cur->thrd->thread_list, &run_queue);
    1154:	fe843783          	ld	a5,-24(s0)
    1158:	639c                	ld	a5,0(a5)
    115a:	02878793          	addi	a5,a5,40
    115e:	00001597          	auipc	a1,0x1
    1162:	efa58593          	addi	a1,a1,-262 # 2058 <run_queue>
    1166:	853e                	mv	a0,a5
    1168:	00000097          	auipc	ra,0x0
    116c:	d68080e7          	jalr	-664(ra) # ed0 <list_add_tail>
            list_del(&cur->thread_list);
    1170:	fe843783          	ld	a5,-24(s0)
    1174:	07a1                	addi	a5,a5,8
    1176:	853e                	mv	a0,a5
    1178:	00000097          	auipc	ra,0x0
    117c:	db4080e7          	jalr	-588(ra) # f2c <list_del>
            free(cur);
    1180:	fe843503          	ld	a0,-24(s0)
    1184:	00000097          	auipc	ra,0x0
    1188:	9b4080e7          	jalr	-1612(ra) # b38 <free>
    list_for_each_entry_safe(cur, nxt, &release_queue, thread_list) {
    118c:	fe043783          	ld	a5,-32(s0)
    1190:	fef43423          	sd	a5,-24(s0)
    1194:	fe043783          	ld	a5,-32(s0)
    1198:	679c                	ld	a5,8(a5)
    119a:	fcf43423          	sd	a5,-56(s0)
    119e:	fc843783          	ld	a5,-56(s0)
    11a2:	17e1                	addi	a5,a5,-8
    11a4:	fef43023          	sd	a5,-32(s0)
    11a8:	fe843783          	ld	a5,-24(s0)
    11ac:	00878713          	addi	a4,a5,8
    11b0:	00001797          	auipc	a5,0x1
    11b4:	eb878793          	addi	a5,a5,-328 # 2068 <release_queue>
    11b8:	f4f71fe3          	bne	a4,a5,1116 <__release+0x36>
        }
    }
}
    11bc:	0001                	nop
    11be:	0001                	nop
    11c0:	70e2                	ld	ra,56(sp)
    11c2:	7442                	ld	s0,48(sp)
    11c4:	6121                	addi	sp,sp,64
    11c6:	8082                	ret

00000000000011c8 <__thread_exit>:

void __thread_exit(struct thread *to_remove)
{
    11c8:	1101                	addi	sp,sp,-32
    11ca:	ec06                	sd	ra,24(sp)
    11cc:	e822                	sd	s0,16(sp)
    11ce:	1000                	addi	s0,sp,32
    11d0:	fea43423          	sd	a0,-24(s0)
    current = to_remove->thread_list.prev;
    11d4:	fe843783          	ld	a5,-24(s0)
    11d8:	7b98                	ld	a4,48(a5)
    11da:	00001797          	auipc	a5,0x1
    11de:	ec678793          	addi	a5,a5,-314 # 20a0 <current>
    11e2:	e398                	sd	a4,0(a5)
    list_del(&to_remove->thread_list);
    11e4:	fe843783          	ld	a5,-24(s0)
    11e8:	02878793          	addi	a5,a5,40
    11ec:	853e                	mv	a0,a5
    11ee:	00000097          	auipc	ra,0x0
    11f2:	d3e080e7          	jalr	-706(ra) # f2c <list_del>

    free(to_remove->stack);
    11f6:	fe843783          	ld	a5,-24(s0)
    11fa:	6b9c                	ld	a5,16(a5)
    11fc:	853e                	mv	a0,a5
    11fe:	00000097          	auipc	ra,0x0
    1202:	93a080e7          	jalr	-1734(ra) # b38 <free>
    free(to_remove);
    1206:	fe843503          	ld	a0,-24(s0)
    120a:	00000097          	auipc	ra,0x0
    120e:	92e080e7          	jalr	-1746(ra) # b38 <free>

    __schedule();
    1212:	00000097          	auipc	ra,0x0
    1216:	446080e7          	jalr	1094(ra) # 1658 <__schedule>
    __dispatch();
    121a:	00000097          	auipc	ra,0x0
    121e:	2b6080e7          	jalr	694(ra) # 14d0 <__dispatch>
    thrdresume(main_thrd_id);
    1222:	00001797          	auipc	a5,0x1
    1226:	e5a78793          	addi	a5,a5,-422 # 207c <main_thrd_id>
    122a:	439c                	lw	a5,0(a5)
    122c:	853e                	mv	a0,a5
    122e:	fffff097          	auipc	ra,0xfffff
    1232:	41c080e7          	jalr	1052(ra) # 64a <thrdresume>
}
    1236:	0001                	nop
    1238:	60e2                	ld	ra,24(sp)
    123a:	6442                	ld	s0,16(sp)
    123c:	6105                	addi	sp,sp,32
    123e:	8082                	ret

0000000000001240 <thread_exit>:

void thread_exit(void)
{
    1240:	7179                	addi	sp,sp,-48
    1242:	f406                	sd	ra,40(sp)
    1244:	f022                	sd	s0,32(sp)
    1246:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    1248:	00001797          	auipc	a5,0x1
    124c:	e5878793          	addi	a5,a5,-424 # 20a0 <current>
    1250:	6398                	ld	a4,0(a5)
    1252:	00001797          	auipc	a5,0x1
    1256:	e0678793          	addi	a5,a5,-506 # 2058 <run_queue>
    125a:	02f71063          	bne	a4,a5,127a <thread_exit+0x3a>
        fprintf(2, "[FATAL] thread_exit is called on a nonexistent thread\n");
    125e:	00001597          	auipc	a1,0x1
    1262:	cba58593          	addi	a1,a1,-838 # 1f18 <schedule_rm+0x2fe>
    1266:	4509                	li	a0,2
    1268:	00000097          	auipc	ra,0x0
    126c:	828080e7          	jalr	-2008(ra) # a90 <fprintf>
        exit(1);
    1270:	4505                	li	a0,1
    1272:	fffff097          	auipc	ra,0xfffff
    1276:	330080e7          	jalr	816(ra) # 5a2 <exit>
    }

    struct thread *to_remove = list_entry(current, struct thread, thread_list);
    127a:	00001797          	auipc	a5,0x1
    127e:	e2678793          	addi	a5,a5,-474 # 20a0 <current>
    1282:	639c                	ld	a5,0(a5)
    1284:	fef43423          	sd	a5,-24(s0)
    1288:	fe843783          	ld	a5,-24(s0)
    128c:	fd878793          	addi	a5,a5,-40
    1290:	fef43023          	sd	a5,-32(s0)
    int consume_ticks = cancelthrdstop(to_remove->thrdstop_context_id, 1);
    1294:	fe043783          	ld	a5,-32(s0)
    1298:	5fdc                	lw	a5,60(a5)
    129a:	4585                	li	a1,1
    129c:	853e                	mv	a0,a5
    129e:	fffff097          	auipc	ra,0xfffff
    12a2:	3b4080e7          	jalr	948(ra) # 652 <cancelthrdstop>
    12a6:	87aa                	mv	a5,a0
    12a8:	fcf42e23          	sw	a5,-36(s0)
    threading_system_time += consume_ticks;
    12ac:	00001797          	auipc	a5,0x1
    12b0:	dfc78793          	addi	a5,a5,-516 # 20a8 <threading_system_time>
    12b4:	439c                	lw	a5,0(a5)
    12b6:	fdc42703          	lw	a4,-36(s0)
    12ba:	9fb9                	addw	a5,a5,a4
    12bc:	0007871b          	sext.w	a4,a5
    12c0:	00001797          	auipc	a5,0x1
    12c4:	de878793          	addi	a5,a5,-536 # 20a8 <threading_system_time>
    12c8:	c398                	sw	a4,0(a5)

    __release();
    12ca:	00000097          	auipc	ra,0x0
    12ce:	e16080e7          	jalr	-490(ra) # 10e0 <__release>
    __thread_exit(to_remove);
    12d2:	fe043503          	ld	a0,-32(s0)
    12d6:	00000097          	auipc	ra,0x0
    12da:	ef2080e7          	jalr	-270(ra) # 11c8 <__thread_exit>
}
    12de:	0001                	nop
    12e0:	70a2                	ld	ra,40(sp)
    12e2:	7402                	ld	s0,32(sp)
    12e4:	6145                	addi	sp,sp,48
    12e6:	8082                	ret

00000000000012e8 <__finish_current>:

void __finish_current()
{
    12e8:	7179                	addi	sp,sp,-48
    12ea:	f406                	sd	ra,40(sp)
    12ec:	f022                	sd	s0,32(sp)
    12ee:	1800                	addi	s0,sp,48
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    12f0:	00001797          	auipc	a5,0x1
    12f4:	db078793          	addi	a5,a5,-592 # 20a0 <current>
    12f8:	639c                	ld	a5,0(a5)
    12fa:	fef43423          	sd	a5,-24(s0)
    12fe:	fe843783          	ld	a5,-24(s0)
    1302:	fd878793          	addi	a5,a5,-40
    1306:	fef43023          	sd	a5,-32(s0)
    --current_thread->n;
    130a:	fe043783          	ld	a5,-32(s0)
    130e:	47bc                	lw	a5,72(a5)
    1310:	37fd                	addiw	a5,a5,-1
    1312:	0007871b          	sext.w	a4,a5
    1316:	fe043783          	ld	a5,-32(s0)
    131a:	c7b8                	sw	a4,72(a5)

    printf("thread#%d finish one cycle at %d: %d cycles left\n",
    131c:	fe043783          	ld	a5,-32(s0)
    1320:	5398                	lw	a4,32(a5)
    1322:	00001797          	auipc	a5,0x1
    1326:	d8678793          	addi	a5,a5,-634 # 20a8 <threading_system_time>
    132a:	4390                	lw	a2,0(a5)
    132c:	fe043783          	ld	a5,-32(s0)
    1330:	47bc                	lw	a5,72(a5)
    1332:	86be                	mv	a3,a5
    1334:	85ba                	mv	a1,a4
    1336:	00001517          	auipc	a0,0x1
    133a:	c1a50513          	addi	a0,a0,-998 # 1f50 <schedule_rm+0x336>
    133e:	fffff097          	auipc	ra,0xfffff
    1342:	7aa080e7          	jalr	1962(ra) # ae8 <printf>
           current_thread->ID, threading_system_time, current_thread->n);

    if (current_thread->n > 0) {
    1346:	fe043783          	ld	a5,-32(s0)
    134a:	47bc                	lw	a5,72(a5)
    134c:	04f05563          	blez	a5,1396 <__finish_current+0xae>
        struct list_head *to_remove = current;
    1350:	00001797          	auipc	a5,0x1
    1354:	d5078793          	addi	a5,a5,-688 # 20a0 <current>
    1358:	639c                	ld	a5,0(a5)
    135a:	fcf43c23          	sd	a5,-40(s0)
        current = current->prev;
    135e:	00001797          	auipc	a5,0x1
    1362:	d4278793          	addi	a5,a5,-702 # 20a0 <current>
    1366:	639c                	ld	a5,0(a5)
    1368:	6798                	ld	a4,8(a5)
    136a:	00001797          	auipc	a5,0x1
    136e:	d3678793          	addi	a5,a5,-714 # 20a0 <current>
    1372:	e398                	sd	a4,0(a5)
        list_del(to_remove);
    1374:	fd843503          	ld	a0,-40(s0)
    1378:	00000097          	auipc	ra,0x0
    137c:	bb4080e7          	jalr	-1100(ra) # f2c <list_del>
        thread_add_at(current_thread, current_thread->current_deadline);
    1380:	fe043783          	ld	a5,-32(s0)
    1384:	4bbc                	lw	a5,80(a5)
    1386:	85be                	mv	a1,a5
    1388:	fe043503          	ld	a0,-32(s0)
    138c:	00000097          	auipc	ra,0x0
    1390:	cf2080e7          	jalr	-782(ra) # 107e <thread_add_at>
    } else {
        __thread_exit(current_thread);
    }
}
    1394:	a039                	j	13a2 <__finish_current+0xba>
        __thread_exit(current_thread);
    1396:	fe043503          	ld	a0,-32(s0)
    139a:	00000097          	auipc	ra,0x0
    139e:	e2e080e7          	jalr	-466(ra) # 11c8 <__thread_exit>
}
    13a2:	0001                	nop
    13a4:	70a2                	ld	ra,40(sp)
    13a6:	7402                	ld	s0,32(sp)
    13a8:	6145                	addi	sp,sp,48
    13aa:	8082                	ret

00000000000013ac <switch_handler>:

void switch_handler(void *arg)
{
    13ac:	7139                	addi	sp,sp,-64
    13ae:	fc06                	sd	ra,56(sp)
    13b0:	f822                	sd	s0,48(sp)
    13b2:	0080                	addi	s0,sp,64
    13b4:	fca43423          	sd	a0,-56(s0)
    uint64 elapsed_time = (uint64)arg;
    13b8:	fc843783          	ld	a5,-56(s0)
    13bc:	fef43423          	sd	a5,-24(s0)
    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    13c0:	00001797          	auipc	a5,0x1
    13c4:	ce078793          	addi	a5,a5,-800 # 20a0 <current>
    13c8:	639c                	ld	a5,0(a5)
    13ca:	fef43023          	sd	a5,-32(s0)
    13ce:	fe043783          	ld	a5,-32(s0)
    13d2:	fd878793          	addi	a5,a5,-40
    13d6:	fcf43c23          	sd	a5,-40(s0)

    threading_system_time += elapsed_time;
    13da:	fe843783          	ld	a5,-24(s0)
    13de:	0007871b          	sext.w	a4,a5
    13e2:	00001797          	auipc	a5,0x1
    13e6:	cc678793          	addi	a5,a5,-826 # 20a8 <threading_system_time>
    13ea:	439c                	lw	a5,0(a5)
    13ec:	2781                	sext.w	a5,a5
    13ee:	9fb9                	addw	a5,a5,a4
    13f0:	2781                	sext.w	a5,a5
    13f2:	0007871b          	sext.w	a4,a5
    13f6:	00001797          	auipc	a5,0x1
    13fa:	cb278793          	addi	a5,a5,-846 # 20a8 <threading_system_time>
    13fe:	c398                	sw	a4,0(a5)
     __release();
    1400:	00000097          	auipc	ra,0x0
    1404:	ce0080e7          	jalr	-800(ra) # 10e0 <__release>
    current_thread->remaining_time -= elapsed_time;
    1408:	fd843783          	ld	a5,-40(s0)
    140c:	47fc                	lw	a5,76(a5)
    140e:	0007871b          	sext.w	a4,a5
    1412:	fe843783          	ld	a5,-24(s0)
    1416:	2781                	sext.w	a5,a5
    1418:	40f707bb          	subw	a5,a4,a5
    141c:	2781                	sext.w	a5,a5
    141e:	0007871b          	sext.w	a4,a5
    1422:	fd843783          	ld	a5,-40(s0)
    1426:	c7f8                	sw	a4,76(a5)

    if (threading_system_time > current_thread->current_deadline || 
    1428:	fd843783          	ld	a5,-40(s0)
    142c:	4bb8                	lw	a4,80(a5)
    142e:	00001797          	auipc	a5,0x1
    1432:	c7a78793          	addi	a5,a5,-902 # 20a8 <threading_system_time>
    1436:	439c                	lw	a5,0(a5)
    1438:	02f74163          	blt	a4,a5,145a <switch_handler+0xae>
        (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    143c:	fd843783          	ld	a5,-40(s0)
    1440:	4bb8                	lw	a4,80(a5)
    1442:	00001797          	auipc	a5,0x1
    1446:	c6678793          	addi	a5,a5,-922 # 20a8 <threading_system_time>
    144a:	439c                	lw	a5,0(a5)
    if (threading_system_time > current_thread->current_deadline || 
    144c:	02f71e63          	bne	a4,a5,1488 <switch_handler+0xdc>
        (threading_system_time == current_thread->current_deadline && current_thread->remaining_time > 0)) {
    1450:	fd843783          	ld	a5,-40(s0)
    1454:	47fc                	lw	a5,76(a5)
    1456:	02f05963          	blez	a5,1488 <switch_handler+0xdc>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, threading_system_time);
    145a:	fd843783          	ld	a5,-40(s0)
    145e:	5398                	lw	a4,32(a5)
    1460:	00001797          	auipc	a5,0x1
    1464:	c4878793          	addi	a5,a5,-952 # 20a8 <threading_system_time>
    1468:	439c                	lw	a5,0(a5)
    146a:	863e                	mv	a2,a5
    146c:	85ba                	mv	a1,a4
    146e:	00001517          	auipc	a0,0x1
    1472:	b1a50513          	addi	a0,a0,-1254 # 1f88 <schedule_rm+0x36e>
    1476:	fffff097          	auipc	ra,0xfffff
    147a:	672080e7          	jalr	1650(ra) # ae8 <printf>
        exit(0);
    147e:	4501                	li	a0,0
    1480:	fffff097          	auipc	ra,0xfffff
    1484:	122080e7          	jalr	290(ra) # 5a2 <exit>
    }

    if (current_thread->remaining_time <= 0) {
    1488:	fd843783          	ld	a5,-40(s0)
    148c:	47fc                	lw	a5,76(a5)
    148e:	00f04663          	bgtz	a5,149a <switch_handler+0xee>
        __finish_current();
    1492:	00000097          	auipc	ra,0x0
    1496:	e56080e7          	jalr	-426(ra) # 12e8 <__finish_current>
    }

    __release();
    149a:	00000097          	auipc	ra,0x0
    149e:	c46080e7          	jalr	-954(ra) # 10e0 <__release>
    __schedule();
    14a2:	00000097          	auipc	ra,0x0
    14a6:	1b6080e7          	jalr	438(ra) # 1658 <__schedule>
    __dispatch();
    14aa:	00000097          	auipc	ra,0x0
    14ae:	026080e7          	jalr	38(ra) # 14d0 <__dispatch>
    thrdresume(main_thrd_id);
    14b2:	00001797          	auipc	a5,0x1
    14b6:	bca78793          	addi	a5,a5,-1078 # 207c <main_thrd_id>
    14ba:	439c                	lw	a5,0(a5)
    14bc:	853e                	mv	a0,a5
    14be:	fffff097          	auipc	ra,0xfffff
    14c2:	18c080e7          	jalr	396(ra) # 64a <thrdresume>
}
    14c6:	0001                	nop
    14c8:	70e2                	ld	ra,56(sp)
    14ca:	7442                	ld	s0,48(sp)
    14cc:	6121                	addi	sp,sp,64
    14ce:	8082                	ret

00000000000014d0 <__dispatch>:

void __dispatch()
{
    14d0:	7179                	addi	sp,sp,-48
    14d2:	f406                	sd	ra,40(sp)
    14d4:	f022                	sd	s0,32(sp)
    14d6:	1800                	addi	s0,sp,48
    if (current == &run_queue) {
    14d8:	00001797          	auipc	a5,0x1
    14dc:	bc878793          	addi	a5,a5,-1080 # 20a0 <current>
    14e0:	6398                	ld	a4,0(a5)
    14e2:	00001797          	auipc	a5,0x1
    14e6:	b7678793          	addi	a5,a5,-1162 # 2058 <run_queue>
    14ea:	16f70263          	beq	a4,a5,164e <__dispatch+0x17e>
    if (allocated_time < 0) {
        fprintf(2, "[FATAL] allocated_time is negative\n");
        exit(1);
    }

    struct thread *current_thread = list_entry(current, struct thread, thread_list);
    14ee:	00001797          	auipc	a5,0x1
    14f2:	bb278793          	addi	a5,a5,-1102 # 20a0 <current>
    14f6:	639c                	ld	a5,0(a5)
    14f8:	fef43423          	sd	a5,-24(s0)
    14fc:	fe843783          	ld	a5,-24(s0)
    1500:	fd878793          	addi	a5,a5,-40
    1504:	fef43023          	sd	a5,-32(s0)
     if (allocated_time == 0) { // miss deadline, abort
    1508:	00001797          	auipc	a5,0x1
    150c:	ba878793          	addi	a5,a5,-1112 # 20b0 <allocated_time>
    1510:	639c                	ld	a5,0(a5)
    1512:	e795                	bnez	a5,153e <__dispatch+0x6e>
        printf("thread#%d misses a deadline at %d\n", current_thread->ID, current_thread->current_deadline);
    1514:	fe043783          	ld	a5,-32(s0)
    1518:	5398                	lw	a4,32(a5)
    151a:	fe043783          	ld	a5,-32(s0)
    151e:	4bbc                	lw	a5,80(a5)
    1520:	863e                	mv	a2,a5
    1522:	85ba                	mv	a1,a4
    1524:	00001517          	auipc	a0,0x1
    1528:	a6450513          	addi	a0,a0,-1436 # 1f88 <schedule_rm+0x36e>
    152c:	fffff097          	auipc	ra,0xfffff
    1530:	5bc080e7          	jalr	1468(ra) # ae8 <printf>
        exit(0);
    1534:	4501                	li	a0,0
    1536:	fffff097          	auipc	ra,0xfffff
    153a:	06c080e7          	jalr	108(ra) # 5a2 <exit>
    }

    printf("dispatch thread#%d at %d: allocated_time=%d\n", current_thread->ID, threading_system_time, allocated_time);
    153e:	fe043783          	ld	a5,-32(s0)
    1542:	5398                	lw	a4,32(a5)
    1544:	00001797          	auipc	a5,0x1
    1548:	b6478793          	addi	a5,a5,-1180 # 20a8 <threading_system_time>
    154c:	4390                	lw	a2,0(a5)
    154e:	00001797          	auipc	a5,0x1
    1552:	b6278793          	addi	a5,a5,-1182 # 20b0 <allocated_time>
    1556:	639c                	ld	a5,0(a5)
    1558:	86be                	mv	a3,a5
    155a:	85ba                	mv	a1,a4
    155c:	00001517          	auipc	a0,0x1
    1560:	a5450513          	addi	a0,a0,-1452 # 1fb0 <schedule_rm+0x396>
    1564:	fffff097          	auipc	ra,0xfffff
    1568:	584080e7          	jalr	1412(ra) # ae8 <printf>

    if (current_thread->buf_set) {
    156c:	fe043783          	ld	a5,-32(s0)
    1570:	5f9c                	lw	a5,56(a5)
    1572:	c7a1                	beqz	a5,15ba <__dispatch+0xea>
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    1574:	00001797          	auipc	a5,0x1
    1578:	b3c78793          	addi	a5,a5,-1220 # 20b0 <allocated_time>
    157c:	639c                	ld	a5,0(a5)
    157e:	0007871b          	sext.w	a4,a5
    1582:	fe043783          	ld	a5,-32(s0)
    1586:	03c78593          	addi	a1,a5,60
    158a:	00001797          	auipc	a5,0x1
    158e:	b2678793          	addi	a5,a5,-1242 # 20b0 <allocated_time>
    1592:	639c                	ld	a5,0(a5)
    1594:	86be                	mv	a3,a5
    1596:	00000617          	auipc	a2,0x0
    159a:	e1660613          	addi	a2,a2,-490 # 13ac <switch_handler>
    159e:	853a                	mv	a0,a4
    15a0:	fffff097          	auipc	ra,0xfffff
    15a4:	0a2080e7          	jalr	162(ra) # 642 <thrdstop>
        thrdresume(current_thread->thrdstop_context_id);
    15a8:	fe043783          	ld	a5,-32(s0)
    15ac:	5fdc                	lw	a5,60(a5)
    15ae:	853e                	mv	a0,a5
    15b0:	fffff097          	auipc	ra,0xfffff
    15b4:	09a080e7          	jalr	154(ra) # 64a <thrdresume>
    15b8:	a071                	j	1644 <__dispatch+0x174>
    } else {
        current_thread->buf_set = 1;
    15ba:	fe043783          	ld	a5,-32(s0)
    15be:	4705                	li	a4,1
    15c0:	df98                	sw	a4,56(a5)
        unsigned long new_stack_p = (unsigned long)current_thread->stack_p;
    15c2:	fe043783          	ld	a5,-32(s0)
    15c6:	6f9c                	ld	a5,24(a5)
    15c8:	fcf43c23          	sd	a5,-40(s0)
        current_thread->thrdstop_context_id = -1;
    15cc:	fe043783          	ld	a5,-32(s0)
    15d0:	577d                	li	a4,-1
    15d2:	dfd8                	sw	a4,60(a5)
        thrdstop(allocated_time, &(current_thread->thrdstop_context_id), switch_handler, (void *)allocated_time);
    15d4:	00001797          	auipc	a5,0x1
    15d8:	adc78793          	addi	a5,a5,-1316 # 20b0 <allocated_time>
    15dc:	639c                	ld	a5,0(a5)
    15de:	0007871b          	sext.w	a4,a5
    15e2:	fe043783          	ld	a5,-32(s0)
    15e6:	03c78593          	addi	a1,a5,60
    15ea:	00001797          	auipc	a5,0x1
    15ee:	ac678793          	addi	a5,a5,-1338 # 20b0 <allocated_time>
    15f2:	639c                	ld	a5,0(a5)
    15f4:	86be                	mv	a3,a5
    15f6:	00000617          	auipc	a2,0x0
    15fa:	db660613          	addi	a2,a2,-586 # 13ac <switch_handler>
    15fe:	853a                	mv	a0,a4
    1600:	fffff097          	auipc	ra,0xfffff
    1604:	042080e7          	jalr	66(ra) # 642 <thrdstop>
        if (current_thread->thrdstop_context_id < 0) {
    1608:	fe043783          	ld	a5,-32(s0)
    160c:	5fdc                	lw	a5,60(a5)
    160e:	0207d063          	bgez	a5,162e <__dispatch+0x15e>
            fprintf(2, "[ERROR] number of threads may exceed MAX_THRD_NUM\n");
    1612:	00001597          	auipc	a1,0x1
    1616:	9ce58593          	addi	a1,a1,-1586 # 1fe0 <schedule_rm+0x3c6>
    161a:	4509                	li	a0,2
    161c:	fffff097          	auipc	ra,0xfffff
    1620:	474080e7          	jalr	1140(ra) # a90 <fprintf>
            exit(1);
    1624:	4505                	li	a0,1
    1626:	fffff097          	auipc	ra,0xfffff
    162a:	f7c080e7          	jalr	-132(ra) # 5a2 <exit>
        }

        // set sp to stack pointer of current thread.
        asm volatile("mv sp, %0"
    162e:	fd843783          	ld	a5,-40(s0)
    1632:	813e                	mv	sp,a5
                     :
                     : "r"(new_stack_p));
        current_thread->fp(current_thread->arg);
    1634:	fe043783          	ld	a5,-32(s0)
    1638:	6398                	ld	a4,0(a5)
    163a:	fe043783          	ld	a5,-32(s0)
    163e:	679c                	ld	a5,8(a5)
    1640:	853e                	mv	a0,a5
    1642:	9702                	jalr	a4
    }
    thread_exit();
    1644:	00000097          	auipc	ra,0x0
    1648:	bfc080e7          	jalr	-1028(ra) # 1240 <thread_exit>
    164c:	a011                	j	1650 <__dispatch+0x180>
        return;
    164e:	0001                	nop
}
    1650:	70a2                	ld	ra,40(sp)
    1652:	7402                	ld	s0,32(sp)
    1654:	6145                	addi	sp,sp,48
    1656:	8082                	ret

0000000000001658 <__schedule>:

void __schedule(void)
{
    1658:	711d                	addi	sp,sp,-96
    165a:	ec86                	sd	ra,88(sp)
    165c:	e8a2                	sd	s0,80(sp)
    165e:	1080                	addi	s0,sp,96
    struct threads_sched_args args = {
    1660:	00001797          	auipc	a5,0x1
    1664:	a4878793          	addi	a5,a5,-1464 # 20a8 <threading_system_time>
    1668:	439c                	lw	a5,0(a5)
    166a:	fcf42c23          	sw	a5,-40(s0)
    166e:	00001797          	auipc	a5,0x1
    1672:	9ea78793          	addi	a5,a5,-1558 # 2058 <run_queue>
    1676:	fef43023          	sd	a5,-32(s0)
    167a:	00001797          	auipc	a5,0x1
    167e:	9ee78793          	addi	a5,a5,-1554 # 2068 <release_queue>
    1682:	fef43423          	sd	a5,-24(s0)
#ifdef THREAD_SCHEDULER_EDF
    r = schedule_edf(args);
#endif

#ifdef THREAD_SCHEDULER_RM
    r = schedule_rm(args);
    1686:	fd843783          	ld	a5,-40(s0)
    168a:	faf43023          	sd	a5,-96(s0)
    168e:	fe043783          	ld	a5,-32(s0)
    1692:	faf43423          	sd	a5,-88(s0)
    1696:	fe843783          	ld	a5,-24(s0)
    169a:	faf43823          	sd	a5,-80(s0)
    169e:	fa040793          	addi	a5,s0,-96
    16a2:	853e                	mv	a0,a5
    16a4:	00000097          	auipc	ra,0x0
    16a8:	576080e7          	jalr	1398(ra) # 1c1a <schedule_rm>
    16ac:	872a                	mv	a4,a0
    16ae:	87ae                	mv	a5,a1
    16b0:	fce43423          	sd	a4,-56(s0)
    16b4:	fcf43823          	sd	a5,-48(s0)
#endif

    current = r.scheduled_thread_list_member;
    16b8:	fc843703          	ld	a4,-56(s0)
    16bc:	00001797          	auipc	a5,0x1
    16c0:	9e478793          	addi	a5,a5,-1564 # 20a0 <current>
    16c4:	e398                	sd	a4,0(a5)
    allocated_time = r.allocated_time;
    16c6:	fd042783          	lw	a5,-48(s0)
    16ca:	873e                	mv	a4,a5
    16cc:	00001797          	auipc	a5,0x1
    16d0:	9e478793          	addi	a5,a5,-1564 # 20b0 <allocated_time>
    16d4:	e398                	sd	a4,0(a5)
}
    16d6:	0001                	nop
    16d8:	60e6                	ld	ra,88(sp)
    16da:	6446                	ld	s0,80(sp)
    16dc:	6125                	addi	sp,sp,96
    16de:	8082                	ret

00000000000016e0 <back_to_main_handler>:

void back_to_main_handler(void *arg)
{
    16e0:	1101                	addi	sp,sp,-32
    16e2:	ec06                	sd	ra,24(sp)
    16e4:	e822                	sd	s0,16(sp)
    16e6:	1000                	addi	s0,sp,32
    16e8:	fea43423          	sd	a0,-24(s0)
    sleeping = 0;
    16ec:	00001797          	auipc	a5,0x1
    16f0:	9c078793          	addi	a5,a5,-1600 # 20ac <sleeping>
    16f4:	0007a023          	sw	zero,0(a5)
    threading_system_time += (uint64)arg;
    16f8:	fe843783          	ld	a5,-24(s0)
    16fc:	0007871b          	sext.w	a4,a5
    1700:	00001797          	auipc	a5,0x1
    1704:	9a878793          	addi	a5,a5,-1624 # 20a8 <threading_system_time>
    1708:	439c                	lw	a5,0(a5)
    170a:	2781                	sext.w	a5,a5
    170c:	9fb9                	addw	a5,a5,a4
    170e:	2781                	sext.w	a5,a5
    1710:	0007871b          	sext.w	a4,a5
    1714:	00001797          	auipc	a5,0x1
    1718:	99478793          	addi	a5,a5,-1644 # 20a8 <threading_system_time>
    171c:	c398                	sw	a4,0(a5)
    thrdresume(main_thrd_id);
    171e:	00001797          	auipc	a5,0x1
    1722:	95e78793          	addi	a5,a5,-1698 # 207c <main_thrd_id>
    1726:	439c                	lw	a5,0(a5)
    1728:	853e                	mv	a0,a5
    172a:	fffff097          	auipc	ra,0xfffff
    172e:	f20080e7          	jalr	-224(ra) # 64a <thrdresume>
}
    1732:	0001                	nop
    1734:	60e2                	ld	ra,24(sp)
    1736:	6442                	ld	s0,16(sp)
    1738:	6105                	addi	sp,sp,32
    173a:	8082                	ret

000000000000173c <thread_start_threading>:

void thread_start_threading()
{
    173c:	1141                	addi	sp,sp,-16
    173e:	e406                	sd	ra,8(sp)
    1740:	e022                	sd	s0,0(sp)
    1742:	0800                	addi	s0,sp,16
    threading_system_time = 0;
    1744:	00001797          	auipc	a5,0x1
    1748:	96478793          	addi	a5,a5,-1692 # 20a8 <threading_system_time>
    174c:	0007a023          	sw	zero,0(a5)
    current = &run_queue;
    1750:	00001797          	auipc	a5,0x1
    1754:	95078793          	addi	a5,a5,-1712 # 20a0 <current>
    1758:	00001717          	auipc	a4,0x1
    175c:	90070713          	addi	a4,a4,-1792 # 2058 <run_queue>
    1760:	e398                	sd	a4,0(a5)

    // call thrdstop just for obtain an ID
    thrdstop(1000, &main_thrd_id, back_to_main_handler, (void *)0);
    1762:	4681                	li	a3,0
    1764:	00000617          	auipc	a2,0x0
    1768:	f7c60613          	addi	a2,a2,-132 # 16e0 <back_to_main_handler>
    176c:	00001597          	auipc	a1,0x1
    1770:	91058593          	addi	a1,a1,-1776 # 207c <main_thrd_id>
    1774:	3e800513          	li	a0,1000
    1778:	fffff097          	auipc	ra,0xfffff
    177c:	eca080e7          	jalr	-310(ra) # 642 <thrdstop>
    cancelthrdstop(main_thrd_id, 0);
    1780:	00001797          	auipc	a5,0x1
    1784:	8fc78793          	addi	a5,a5,-1796 # 207c <main_thrd_id>
    1788:	439c                	lw	a5,0(a5)
    178a:	4581                	li	a1,0
    178c:	853e                	mv	a0,a5
    178e:	fffff097          	auipc	ra,0xfffff
    1792:	ec4080e7          	jalr	-316(ra) # 652 <cancelthrdstop>

    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    1796:	a0c9                	j	1858 <thread_start_threading+0x11c>
        __release();
    1798:	00000097          	auipc	ra,0x0
    179c:	948080e7          	jalr	-1720(ra) # 10e0 <__release>
        __schedule();
    17a0:	00000097          	auipc	ra,0x0
    17a4:	eb8080e7          	jalr	-328(ra) # 1658 <__schedule>
        cancelthrdstop(main_thrd_id, 0);
    17a8:	00001797          	auipc	a5,0x1
    17ac:	8d478793          	addi	a5,a5,-1836 # 207c <main_thrd_id>
    17b0:	439c                	lw	a5,0(a5)
    17b2:	4581                	li	a1,0
    17b4:	853e                	mv	a0,a5
    17b6:	fffff097          	auipc	ra,0xfffff
    17ba:	e9c080e7          	jalr	-356(ra) # 652 <cancelthrdstop>
        __dispatch();
    17be:	00000097          	auipc	ra,0x0
    17c2:	d12080e7          	jalr	-750(ra) # 14d0 <__dispatch>

        if (list_empty(&run_queue) && list_empty(&release_queue)) {
    17c6:	00001517          	auipc	a0,0x1
    17ca:	89250513          	addi	a0,a0,-1902 # 2058 <run_queue>
    17ce:	fffff097          	auipc	ra,0xfffff
    17d2:	7a8080e7          	jalr	1960(ra) # f76 <list_empty>
    17d6:	87aa                	mv	a5,a0
    17d8:	cb99                	beqz	a5,17ee <thread_start_threading+0xb2>
    17da:	00001517          	auipc	a0,0x1
    17de:	88e50513          	addi	a0,a0,-1906 # 2068 <release_queue>
    17e2:	fffff097          	auipc	ra,0xfffff
    17e6:	794080e7          	jalr	1940(ra) # f76 <list_empty>
    17ea:	87aa                	mv	a5,a0
    17ec:	ebd9                	bnez	a5,1882 <thread_start_threading+0x146>
            break;
        }

        // no thread in run_queue, release_queue not empty
        printf("run_queue is empty, sleep for %d ticks\n", allocated_time);
    17ee:	00001797          	auipc	a5,0x1
    17f2:	8c278793          	addi	a5,a5,-1854 # 20b0 <allocated_time>
    17f6:	639c                	ld	a5,0(a5)
    17f8:	85be                	mv	a1,a5
    17fa:	00001517          	auipc	a0,0x1
    17fe:	81e50513          	addi	a0,a0,-2018 # 2018 <schedule_rm+0x3fe>
    1802:	fffff097          	auipc	ra,0xfffff
    1806:	2e6080e7          	jalr	742(ra) # ae8 <printf>
        sleeping = 1;
    180a:	00001797          	auipc	a5,0x1
    180e:	8a278793          	addi	a5,a5,-1886 # 20ac <sleeping>
    1812:	4705                	li	a4,1
    1814:	c398                	sw	a4,0(a5)
        thrdstop(allocated_time, &main_thrd_id, back_to_main_handler, (void *)allocated_time);
    1816:	00001797          	auipc	a5,0x1
    181a:	89a78793          	addi	a5,a5,-1894 # 20b0 <allocated_time>
    181e:	639c                	ld	a5,0(a5)
    1820:	0007871b          	sext.w	a4,a5
    1824:	00001797          	auipc	a5,0x1
    1828:	88c78793          	addi	a5,a5,-1908 # 20b0 <allocated_time>
    182c:	639c                	ld	a5,0(a5)
    182e:	86be                	mv	a3,a5
    1830:	00000617          	auipc	a2,0x0
    1834:	eb060613          	addi	a2,a2,-336 # 16e0 <back_to_main_handler>
    1838:	00001597          	auipc	a1,0x1
    183c:	84458593          	addi	a1,a1,-1980 # 207c <main_thrd_id>
    1840:	853a                	mv	a0,a4
    1842:	fffff097          	auipc	ra,0xfffff
    1846:	e00080e7          	jalr	-512(ra) # 642 <thrdstop>
        while (sleeping) {
    184a:	0001                	nop
    184c:	00001797          	auipc	a5,0x1
    1850:	86078793          	addi	a5,a5,-1952 # 20ac <sleeping>
    1854:	439c                	lw	a5,0(a5)
    1856:	fbfd                	bnez	a5,184c <thread_start_threading+0x110>
    while (!list_empty(&run_queue) || !list_empty(&release_queue)) {
    1858:	00001517          	auipc	a0,0x1
    185c:	80050513          	addi	a0,a0,-2048 # 2058 <run_queue>
    1860:	fffff097          	auipc	ra,0xfffff
    1864:	716080e7          	jalr	1814(ra) # f76 <list_empty>
    1868:	87aa                	mv	a5,a0
    186a:	d79d                	beqz	a5,1798 <thread_start_threading+0x5c>
    186c:	00000517          	auipc	a0,0x0
    1870:	7fc50513          	addi	a0,a0,2044 # 2068 <release_queue>
    1874:	fffff097          	auipc	ra,0xfffff
    1878:	702080e7          	jalr	1794(ra) # f76 <list_empty>
    187c:	87aa                	mv	a5,a0
    187e:	df89                	beqz	a5,1798 <thread_start_threading+0x5c>
            // zzz...
        }
    }
}
    1880:	a011                	j	1884 <thread_start_threading+0x148>
            break;
    1882:	0001                	nop
}
    1884:	0001                	nop
    1886:	60a2                	ld	ra,8(sp)
    1888:	6402                	ld	s0,0(sp)
    188a:	0141                	addi	sp,sp,16
    188c:	8082                	ret

000000000000188e <schedule_default>:

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    188e:	715d                	addi	sp,sp,-80
    1890:	e4a2                	sd	s0,72(sp)
    1892:	e0a6                	sd	s1,64(sp)
    1894:	0880                	addi	s0,sp,80
    1896:	84aa                	mv	s1,a0
    struct thread *thread_with_smallest_id = NULL;
    1898:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    189c:	fe043023          	sd	zero,-32(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    18a0:	649c                	ld	a5,8(s1)
    18a2:	639c                	ld	a5,0(a5)
    18a4:	fcf43c23          	sd	a5,-40(s0)
    18a8:	fd843783          	ld	a5,-40(s0)
    18ac:	fd878793          	addi	a5,a5,-40
    18b0:	fef43023          	sd	a5,-32(s0)
    18b4:	a81d                	j	18ea <schedule_default+0x5c>
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
    18b6:	fe843783          	ld	a5,-24(s0)
    18ba:	cb89                	beqz	a5,18cc <schedule_default+0x3e>
    18bc:	fe043783          	ld	a5,-32(s0)
    18c0:	5398                	lw	a4,32(a5)
    18c2:	fe843783          	ld	a5,-24(s0)
    18c6:	539c                	lw	a5,32(a5)
    18c8:	00f75663          	bge	a4,a5,18d4 <schedule_default+0x46>
            thread_with_smallest_id = th;
    18cc:	fe043783          	ld	a5,-32(s0)
    18d0:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    18d4:	fe043783          	ld	a5,-32(s0)
    18d8:	779c                	ld	a5,40(a5)
    18da:	fcf43823          	sd	a5,-48(s0)
    18de:	fd043783          	ld	a5,-48(s0)
    18e2:	fd878793          	addi	a5,a5,-40
    18e6:	fef43023          	sd	a5,-32(s0)
    18ea:	fe043783          	ld	a5,-32(s0)
    18ee:	02878713          	addi	a4,a5,40
    18f2:	649c                	ld	a5,8(s1)
    18f4:	fcf711e3          	bne	a4,a5,18b6 <schedule_default+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
    18f8:	fe843783          	ld	a5,-24(s0)
    18fc:	cf89                	beqz	a5,1916 <schedule_default+0x88>
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
    18fe:	fe843783          	ld	a5,-24(s0)
    1902:	02878793          	addi	a5,a5,40
    1906:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = thread_with_smallest_id->remaining_time;
    190a:	fe843783          	ld	a5,-24(s0)
    190e:	47fc                	lw	a5,76(a5)
    1910:	faf42c23          	sw	a5,-72(s0)
    1914:	a039                	j	1922 <schedule_default+0x94>
    } else {
        r.scheduled_thread_list_member = args.run_queue;
    1916:	649c                	ld	a5,8(s1)
    1918:	faf43823          	sd	a5,-80(s0)
        r.allocated_time = 1;
    191c:	4785                	li	a5,1
    191e:	faf42c23          	sw	a5,-72(s0)
    }

    return r;
    1922:	fb043783          	ld	a5,-80(s0)
    1926:	fcf43023          	sd	a5,-64(s0)
    192a:	fb843783          	ld	a5,-72(s0)
    192e:	fcf43423          	sd	a5,-56(s0)
    1932:	fc043703          	ld	a4,-64(s0)
    1936:	fc843783          	ld	a5,-56(s0)
    193a:	863a                	mv	a2,a4
    193c:	86be                	mv	a3,a5
    193e:	8732                	mv	a4,a2
    1940:	87b6                	mv	a5,a3
}
    1942:	853a                	mv	a0,a4
    1944:	85be                	mv	a1,a5
    1946:	6426                	ld	s0,72(sp)
    1948:	6486                	ld	s1,64(sp)
    194a:	6161                	addi	sp,sp,80
    194c:	8082                	ret

000000000000194e <schedule_edf>:

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    194e:	7131                	addi	sp,sp,-192
    1950:	fd22                	sd	s0,184(sp)
    1952:	f926                	sd	s1,176(sp)
    1954:	0180                	addi	s0,sp,192
    1956:	84aa                	mv	s1,a0
    struct thread *thread_with_earliest_deadline = NULL;
    1958:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    195c:	fe043023          	sd	zero,-32(s0)
    // iterate through run quene and select the thread with earliest deadline
    list_for_each_entry(th, args.run_queue, thread_list) {
    1960:	649c                	ld	a5,8(s1)
    1962:	639c                	ld	a5,0(a5)
    1964:	faf43c23          	sd	a5,-72(s0)
    1968:	fb843783          	ld	a5,-72(s0)
    196c:	fd878793          	addi	a5,a5,-40
    1970:	fef43023          	sd	a5,-32(s0)
    1974:	a899                	j	19ca <schedule_edf+0x7c>
        if (thread_with_earliest_deadline == NULL || th->current_deadline < thread_with_earliest_deadline->current_deadline ||
    1976:	fe843783          	ld	a5,-24(s0)
    197a:	cb8d                	beqz	a5,19ac <schedule_edf+0x5e>
    197c:	fe043783          	ld	a5,-32(s0)
    1980:	4bb8                	lw	a4,80(a5)
    1982:	fe843783          	ld	a5,-24(s0)
    1986:	4bbc                	lw	a5,80(a5)
    1988:	02f74263          	blt	a4,a5,19ac <schedule_edf+0x5e>
            (th->current_deadline == thread_with_earliest_deadline->current_deadline && th->ID < thread_with_earliest_deadline->ID)) {
    198c:	fe043783          	ld	a5,-32(s0)
    1990:	4bb8                	lw	a4,80(a5)
    1992:	fe843783          	ld	a5,-24(s0)
    1996:	4bbc                	lw	a5,80(a5)
        if (thread_with_earliest_deadline == NULL || th->current_deadline < thread_with_earliest_deadline->current_deadline ||
    1998:	00f71e63          	bne	a4,a5,19b4 <schedule_edf+0x66>
            (th->current_deadline == thread_with_earliest_deadline->current_deadline && th->ID < thread_with_earliest_deadline->ID)) {
    199c:	fe043783          	ld	a5,-32(s0)
    19a0:	5398                	lw	a4,32(a5)
    19a2:	fe843783          	ld	a5,-24(s0)
    19a6:	539c                	lw	a5,32(a5)
    19a8:	00f75663          	bge	a4,a5,19b4 <schedule_edf+0x66>
            thread_with_earliest_deadline = th;
    19ac:	fe043783          	ld	a5,-32(s0)
    19b0:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    19b4:	fe043783          	ld	a5,-32(s0)
    19b8:	779c                	ld	a5,40(a5)
    19ba:	f6f43423          	sd	a5,-152(s0)
    19be:	f6843783          	ld	a5,-152(s0)
    19c2:	fd878793          	addi	a5,a5,-40
    19c6:	fef43023          	sd	a5,-32(s0)
    19ca:	fe043783          	ld	a5,-32(s0)
    19ce:	02878713          	addi	a4,a5,40
    19d2:	649c                	ld	a5,8(s1)
    19d4:	faf711e3          	bne	a4,a5,1976 <schedule_edf+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_earliest_deadline != NULL) {
    19d8:	fe843783          	ld	a5,-24(s0)
    19dc:	1a078263          	beqz	a5,1b80 <schedule_edf+0x232>
        struct thread *th = NULL;
    19e0:	fc043c23          	sd	zero,-40(s0)
        int miss_min_ID = -1;
    19e4:	57fd                	li	a5,-1
    19e6:	fcf42a23          	sw	a5,-44(s0)
        // iterate through runqueue to check if any thread misses deadline
        list_for_each_entry(th, args.run_queue, thread_list) {
    19ea:	649c                	ld	a5,8(s1)
    19ec:	639c                	ld	a5,0(a5)
    19ee:	f8f43c23          	sd	a5,-104(s0)
    19f2:	f9843783          	ld	a5,-104(s0)
    19f6:	fd878793          	addi	a5,a5,-40
    19fa:	fcf43c23          	sd	a5,-40(s0)
    19fe:	a0a5                	j	1a66 <schedule_edf+0x118>
            if ((th->current_deadline <= args.current_time && miss_min_ID == -1) ||
    1a00:	fd843783          	ld	a5,-40(s0)
    1a04:	4bb8                	lw	a4,80(a5)
    1a06:	409c                	lw	a5,0(s1)
    1a08:	00e7c963          	blt	a5,a4,1a1a <schedule_edf+0xcc>
    1a0c:	fd442783          	lw	a5,-44(s0)
    1a10:	0007871b          	sext.w	a4,a5
    1a14:	57fd                	li	a5,-1
    1a16:	02f70063          	beq	a4,a5,1a36 <schedule_edf+0xe8>
                (th->current_deadline <= args.current_time && th->ID < miss_min_ID)) {
    1a1a:	fd843783          	ld	a5,-40(s0)
    1a1e:	4bb8                	lw	a4,80(a5)
    1a20:	409c                	lw	a5,0(s1)
            if ((th->current_deadline <= args.current_time && miss_min_ID == -1) ||
    1a22:	02e7c763          	blt	a5,a4,1a50 <schedule_edf+0x102>
                (th->current_deadline <= args.current_time && th->ID < miss_min_ID)) {
    1a26:	fd843783          	ld	a5,-40(s0)
    1a2a:	5398                	lw	a4,32(a5)
    1a2c:	fd442783          	lw	a5,-44(s0)
    1a30:	2781                	sext.w	a5,a5
    1a32:	00f75f63          	bge	a4,a5,1a50 <schedule_edf+0x102>
                miss_min_ID = th->ID;
    1a36:	fd843783          	ld	a5,-40(s0)
    1a3a:	539c                	lw	a5,32(a5)
    1a3c:	fcf42a23          	sw	a5,-44(s0)
                r.scheduled_thread_list_member = &th->thread_list;
    1a40:	fd843783          	ld	a5,-40(s0)
    1a44:	02878793          	addi	a5,a5,40
    1a48:	f4f43423          	sd	a5,-184(s0)
                r.allocated_time = 0;
    1a4c:	f4042823          	sw	zero,-176(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1a50:	fd843783          	ld	a5,-40(s0)
    1a54:	779c                	ld	a5,40(a5)
    1a56:	f6f43823          	sd	a5,-144(s0)
    1a5a:	f7043783          	ld	a5,-144(s0)
    1a5e:	fd878793          	addi	a5,a5,-40
    1a62:	fcf43c23          	sd	a5,-40(s0)
    1a66:	fd843783          	ld	a5,-40(s0)
    1a6a:	02878713          	addi	a4,a5,40
    1a6e:	649c                	ld	a5,8(s1)
    1a70:	f8f718e3          	bne	a4,a5,1a00 <schedule_edf+0xb2>
            }
        }
        
        if(miss_min_ID != -1) {
    1a74:	fd442783          	lw	a5,-44(s0)
    1a78:	0007871b          	sext.w	a4,a5
    1a7c:	57fd                	li	a5,-1
    1a7e:	00f70b63          	beq	a4,a5,1a94 <schedule_edf+0x146>
            // there's at least one thread misses deadline
            return r;
    1a82:	f4843783          	ld	a5,-184(s0)
    1a86:	f4f43c23          	sd	a5,-168(s0)
    1a8a:	f5043783          	ld	a5,-176(s0)
    1a8e:	f6f43023          	sd	a5,-160(s0)
    1a92:	a2b5                	j	1bfe <schedule_edf+0x2b0>
        }
        
        r.scheduled_thread_list_member = &thread_with_earliest_deadline->thread_list;
    1a94:	fe843783          	ld	a5,-24(s0)
    1a98:	02878793          	addi	a5,a5,40
    1a9c:	f4f43423          	sd	a5,-184(s0)
        int remaining_time_to_deadline = thread_with_earliest_deadline->current_deadline - args.current_time;
    1aa0:	fe843783          	ld	a5,-24(s0)
    1aa4:	4bb8                	lw	a4,80(a5)
    1aa6:	409c                	lw	a5,0(s1)
    1aa8:	40f707bb          	subw	a5,a4,a5
    1aac:	f8f42a23          	sw	a5,-108(s0)
        
        // run until meets/misses deadline or gets preempted by higher priority
        r.allocated_time = thread_with_earliest_deadline->remaining_time <= remaining_time_to_deadline ? thread_with_earliest_deadline->remaining_time : remaining_time_to_deadline;
    1ab0:	fe843783          	ld	a5,-24(s0)
    1ab4:	47fc                	lw	a5,76(a5)
    1ab6:	853e                	mv	a0,a5
    1ab8:	f9442783          	lw	a5,-108(s0)
    1abc:	0007859b          	sext.w	a1,a5
    1ac0:	0005071b          	sext.w	a4,a0
    1ac4:	00b75363          	bge	a4,a1,1aca <schedule_edf+0x17c>
    1ac8:	87aa                	mv	a5,a0
    1aca:	2781                	sext.w	a5,a5
    1acc:	f4f42823          	sw	a5,-176(s0)
        struct release_queue_entry *entry = NULL;
    1ad0:	fc043423          	sd	zero,-56(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1ad4:	689c                	ld	a5,16(s1)
    1ad6:	639c                	ld	a5,0(a5)
    1ad8:	f8f43423          	sd	a5,-120(s0)
    1adc:	f8843783          	ld	a5,-120(s0)
    1ae0:	17e1                	addi	a5,a5,-8
    1ae2:	fcf43423          	sd	a5,-56(s0)
    1ae6:	a069                	j	1b70 <schedule_edf+0x222>
            if (entry->release_time + entry->thrd->period < thread_with_earliest_deadline->current_deadline ||
    1ae8:	fc843783          	ld	a5,-56(s0)
    1aec:	4f98                	lw	a4,24(a5)
    1aee:	fc843783          	ld	a5,-56(s0)
    1af2:	639c                	ld	a5,0(a5)
    1af4:	43fc                	lw	a5,68(a5)
    1af6:	9fb9                	addw	a5,a5,a4
    1af8:	0007871b          	sext.w	a4,a5
    1afc:	fe843783          	ld	a5,-24(s0)
    1b00:	4bbc                	lw	a5,80(a5)
    1b02:	02f74a63          	blt	a4,a5,1b36 <schedule_edf+0x1e8>
                (entry->release_time + entry->thrd->period == thread_with_earliest_deadline->current_deadline && entry->thrd->ID < thread_with_earliest_deadline->ID)) {
    1b06:	fc843783          	ld	a5,-56(s0)
    1b0a:	4f98                	lw	a4,24(a5)
    1b0c:	fc843783          	ld	a5,-56(s0)
    1b10:	639c                	ld	a5,0(a5)
    1b12:	43fc                	lw	a5,68(a5)
    1b14:	9fb9                	addw	a5,a5,a4
    1b16:	0007871b          	sext.w	a4,a5
    1b1a:	fe843783          	ld	a5,-24(s0)
    1b1e:	4bbc                	lw	a5,80(a5)
            if (entry->release_time + entry->thrd->period < thread_with_earliest_deadline->current_deadline ||
    1b20:	02f71e63          	bne	a4,a5,1b5c <schedule_edf+0x20e>
                (entry->release_time + entry->thrd->period == thread_with_earliest_deadline->current_deadline && entry->thrd->ID < thread_with_earliest_deadline->ID)) {
    1b24:	fc843783          	ld	a5,-56(s0)
    1b28:	639c                	ld	a5,0(a5)
    1b2a:	5398                	lw	a4,32(a5)
    1b2c:	fe843783          	ld	a5,-24(s0)
    1b30:	539c                	lw	a5,32(a5)
    1b32:	02f75563          	bge	a4,a5,1b5c <schedule_edf+0x20e>
                int remaining_time_to_next_release = entry->release_time - args.current_time;
    1b36:	fc843783          	ld	a5,-56(s0)
    1b3a:	4f98                	lw	a4,24(a5)
    1b3c:	409c                	lw	a5,0(s1)
    1b3e:	40f707bb          	subw	a5,a4,a5
    1b42:	f8f42223          	sw	a5,-124(s0)
                if (remaining_time_to_next_release < r.allocated_time) {
    1b46:	f5042703          	lw	a4,-176(s0)
    1b4a:	f8442783          	lw	a5,-124(s0)
    1b4e:	2781                	sext.w	a5,a5
    1b50:	00e7d663          	bge	a5,a4,1b5c <schedule_edf+0x20e>
                    r.allocated_time = remaining_time_to_next_release;
    1b54:	f8442783          	lw	a5,-124(s0)
    1b58:	f4f42823          	sw	a5,-176(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1b5c:	fc843783          	ld	a5,-56(s0)
    1b60:	679c                	ld	a5,8(a5)
    1b62:	f6f43c23          	sd	a5,-136(s0)
    1b66:	f7843783          	ld	a5,-136(s0)
    1b6a:	17e1                	addi	a5,a5,-8
    1b6c:	fcf43423          	sd	a5,-56(s0)
    1b70:	fc843783          	ld	a5,-56(s0)
    1b74:	00878713          	addi	a4,a5,8
    1b78:	689c                	ld	a5,16(s1)
    1b7a:	f6f717e3          	bne	a4,a5,1ae8 <schedule_edf+0x19a>
    1b7e:	a885                	j	1bee <schedule_edf+0x2a0>
            }
        }
    } 
    else {
        // run queue is empty, allocate time for sleeping
        r.scheduled_thread_list_member = args.run_queue;
    1b80:	649c                	ld	a5,8(s1)
    1b82:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = 100;  
    1b86:	06400793          	li	a5,100
    1b8a:	f4f42823          	sw	a5,-176(s0)
        struct release_queue_entry *entry = NULL;
    1b8e:	fc043023          	sd	zero,-64(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1b92:	689c                	ld	a5,16(s1)
    1b94:	639c                	ld	a5,0(a5)
    1b96:	faf43823          	sd	a5,-80(s0)
    1b9a:	fb043783          	ld	a5,-80(s0)
    1b9e:	17e1                	addi	a5,a5,-8
    1ba0:	fcf43023          	sd	a5,-64(s0)
    1ba4:	a835                	j	1be0 <schedule_edf+0x292>
            int remaining_time_to_next_release = entry->release_time - args.current_time;
    1ba6:	fc043783          	ld	a5,-64(s0)
    1baa:	4f98                	lw	a4,24(a5)
    1bac:	409c                	lw	a5,0(s1)
    1bae:	40f707bb          	subw	a5,a4,a5
    1bb2:	faf42623          	sw	a5,-84(s0)
            if (remaining_time_to_next_release < r.allocated_time) {
    1bb6:	f5042703          	lw	a4,-176(s0)
    1bba:	fac42783          	lw	a5,-84(s0)
    1bbe:	2781                	sext.w	a5,a5
    1bc0:	00e7d663          	bge	a5,a4,1bcc <schedule_edf+0x27e>
                r.allocated_time = remaining_time_to_next_release;
    1bc4:	fac42783          	lw	a5,-84(s0)
    1bc8:	f4f42823          	sw	a5,-176(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1bcc:	fc043783          	ld	a5,-64(s0)
    1bd0:	679c                	ld	a5,8(a5)
    1bd2:	faf43023          	sd	a5,-96(s0)
    1bd6:	fa043783          	ld	a5,-96(s0)
    1bda:	17e1                	addi	a5,a5,-8
    1bdc:	fcf43023          	sd	a5,-64(s0)
    1be0:	fc043783          	ld	a5,-64(s0)
    1be4:	00878713          	addi	a4,a5,8
    1be8:	689c                	ld	a5,16(s1)
    1bea:	faf71ee3          	bne	a4,a5,1ba6 <schedule_edf+0x258>
            }
        }
    }

    return r;
    1bee:	f4843783          	ld	a5,-184(s0)
    1bf2:	f4f43c23          	sd	a5,-168(s0)
    1bf6:	f5043783          	ld	a5,-176(s0)
    1bfa:	f6f43023          	sd	a5,-160(s0)
}
    1bfe:	f5843703          	ld	a4,-168(s0)
    1c02:	f6043783          	ld	a5,-160(s0)
    1c06:	863a                	mv	a2,a4
    1c08:	86be                	mv	a3,a5
    1c0a:	8732                	mv	a4,a2
    1c0c:	87b6                	mv	a5,a3
    1c0e:	853a                	mv	a0,a4
    1c10:	85be                	mv	a1,a5
    1c12:	746a                	ld	s0,184(sp)
    1c14:	74ca                	ld	s1,176(sp)
    1c16:	6129                	addi	sp,sp,192
    1c18:	8082                	ret

0000000000001c1a <schedule_rm>:

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    1c1a:	7131                	addi	sp,sp,-192
    1c1c:	fd22                	sd	s0,184(sp)
    1c1e:	f926                	sd	s1,176(sp)
    1c20:	0180                	addi	s0,sp,192
    1c22:	84aa                	mv	s1,a0
    struct thread *thread_with_shortest_period = NULL;
    1c24:	fe043423          	sd	zero,-24(s0)
    struct thread *th = NULL;
    1c28:	fe043023          	sd	zero,-32(s0)
    // iterate through run queue to get the thread with the shortest period, i.e., the highest priority
    list_for_each_entry(th, args.run_queue, thread_list) {
    1c2c:	649c                	ld	a5,8(s1)
    1c2e:	639c                	ld	a5,0(a5)
    1c30:	faf43c23          	sd	a5,-72(s0)
    1c34:	fb843783          	ld	a5,-72(s0)
    1c38:	fd878793          	addi	a5,a5,-40
    1c3c:	fef43023          	sd	a5,-32(s0)
    1c40:	a899                	j	1c96 <schedule_rm+0x7c>
        if (thread_with_shortest_period == NULL || th->period < thread_with_shortest_period->period ||
    1c42:	fe843783          	ld	a5,-24(s0)
    1c46:	cb8d                	beqz	a5,1c78 <schedule_rm+0x5e>
    1c48:	fe043783          	ld	a5,-32(s0)
    1c4c:	43f8                	lw	a4,68(a5)
    1c4e:	fe843783          	ld	a5,-24(s0)
    1c52:	43fc                	lw	a5,68(a5)
    1c54:	02f74263          	blt	a4,a5,1c78 <schedule_rm+0x5e>
            (th->period == thread_with_shortest_period->period && th->ID < thread_with_shortest_period->ID)) {
    1c58:	fe043783          	ld	a5,-32(s0)
    1c5c:	43f8                	lw	a4,68(a5)
    1c5e:	fe843783          	ld	a5,-24(s0)
    1c62:	43fc                	lw	a5,68(a5)
        if (thread_with_shortest_period == NULL || th->period < thread_with_shortest_period->period ||
    1c64:	00f71e63          	bne	a4,a5,1c80 <schedule_rm+0x66>
            (th->period == thread_with_shortest_period->period && th->ID < thread_with_shortest_period->ID)) {
    1c68:	fe043783          	ld	a5,-32(s0)
    1c6c:	5398                	lw	a4,32(a5)
    1c6e:	fe843783          	ld	a5,-24(s0)
    1c72:	539c                	lw	a5,32(a5)
    1c74:	00f75663          	bge	a4,a5,1c80 <schedule_rm+0x66>
            thread_with_shortest_period = th;
    1c78:	fe043783          	ld	a5,-32(s0)
    1c7c:	fef43423          	sd	a5,-24(s0)
    list_for_each_entry(th, args.run_queue, thread_list) {
    1c80:	fe043783          	ld	a5,-32(s0)
    1c84:	779c                	ld	a5,40(a5)
    1c86:	f6f43423          	sd	a5,-152(s0)
    1c8a:	f6843783          	ld	a5,-152(s0)
    1c8e:	fd878793          	addi	a5,a5,-40
    1c92:	fef43023          	sd	a5,-32(s0)
    1c96:	fe043783          	ld	a5,-32(s0)
    1c9a:	02878713          	addi	a4,a5,40
    1c9e:	649c                	ld	a5,8(s1)
    1ca0:	faf711e3          	bne	a4,a5,1c42 <schedule_rm+0x28>
        }
    }

    struct threads_sched_result r;
    if (thread_with_shortest_period != NULL) {
    1ca4:	fe843783          	ld	a5,-24(s0)
    1ca8:	18078663          	beqz	a5,1e34 <schedule_rm+0x21a>
        struct thread *th = NULL;
    1cac:	fc043c23          	sd	zero,-40(s0)
        int miss_min_ID = -1;
    1cb0:	57fd                	li	a5,-1
    1cb2:	fcf42a23          	sw	a5,-44(s0)
        // iterate through runqueue to check if any thread misses deadline
        list_for_each_entry(th, args.run_queue, thread_list) {
    1cb6:	649c                	ld	a5,8(s1)
    1cb8:	639c                	ld	a5,0(a5)
    1cba:	f8f43c23          	sd	a5,-104(s0)
    1cbe:	f9843783          	ld	a5,-104(s0)
    1cc2:	fd878793          	addi	a5,a5,-40
    1cc6:	fcf43c23          	sd	a5,-40(s0)
    1cca:	a0a5                	j	1d32 <schedule_rm+0x118>
            if ((th->current_deadline <= args.current_time && miss_min_ID == -1) ||
    1ccc:	fd843783          	ld	a5,-40(s0)
    1cd0:	4bb8                	lw	a4,80(a5)
    1cd2:	409c                	lw	a5,0(s1)
    1cd4:	00e7c963          	blt	a5,a4,1ce6 <schedule_rm+0xcc>
    1cd8:	fd442783          	lw	a5,-44(s0)
    1cdc:	0007871b          	sext.w	a4,a5
    1ce0:	57fd                	li	a5,-1
    1ce2:	02f70063          	beq	a4,a5,1d02 <schedule_rm+0xe8>
                (th->current_deadline <= args.current_time && th->ID < miss_min_ID)) {
    1ce6:	fd843783          	ld	a5,-40(s0)
    1cea:	4bb8                	lw	a4,80(a5)
    1cec:	409c                	lw	a5,0(s1)
            if ((th->current_deadline <= args.current_time && miss_min_ID == -1) ||
    1cee:	02e7c763          	blt	a5,a4,1d1c <schedule_rm+0x102>
                (th->current_deadline <= args.current_time && th->ID < miss_min_ID)) {
    1cf2:	fd843783          	ld	a5,-40(s0)
    1cf6:	5398                	lw	a4,32(a5)
    1cf8:	fd442783          	lw	a5,-44(s0)
    1cfc:	2781                	sext.w	a5,a5
    1cfe:	00f75f63          	bge	a4,a5,1d1c <schedule_rm+0x102>
                miss_min_ID = th->ID;
    1d02:	fd843783          	ld	a5,-40(s0)
    1d06:	539c                	lw	a5,32(a5)
    1d08:	fcf42a23          	sw	a5,-44(s0)
                r.scheduled_thread_list_member = &th->thread_list;
    1d0c:	fd843783          	ld	a5,-40(s0)
    1d10:	02878793          	addi	a5,a5,40
    1d14:	f4f43423          	sd	a5,-184(s0)
                r.allocated_time = 0;
    1d18:	f4042823          	sw	zero,-176(s0)
        list_for_each_entry(th, args.run_queue, thread_list) {
    1d1c:	fd843783          	ld	a5,-40(s0)
    1d20:	779c                	ld	a5,40(a5)
    1d22:	f6f43823          	sd	a5,-144(s0)
    1d26:	f7043783          	ld	a5,-144(s0)
    1d2a:	fd878793          	addi	a5,a5,-40
    1d2e:	fcf43c23          	sd	a5,-40(s0)
    1d32:	fd843783          	ld	a5,-40(s0)
    1d36:	02878713          	addi	a4,a5,40
    1d3a:	649c                	ld	a5,8(s1)
    1d3c:	f8f718e3          	bne	a4,a5,1ccc <schedule_rm+0xb2>
            }
        }

        if(miss_min_ID != -1) {
    1d40:	fd442783          	lw	a5,-44(s0)
    1d44:	0007871b          	sext.w	a4,a5
    1d48:	57fd                	li	a5,-1
    1d4a:	00f70b63          	beq	a4,a5,1d60 <schedule_rm+0x146>
            // there's at least one thread misses deadline
            return r;
    1d4e:	f4843783          	ld	a5,-184(s0)
    1d52:	f4f43c23          	sd	a5,-168(s0)
    1d56:	f5043783          	ld	a5,-176(s0)
    1d5a:	f6f43023          	sd	a5,-160(s0)
    1d5e:	aa91                	j	1eb2 <schedule_rm+0x298>
        }

        r.scheduled_thread_list_member = &thread_with_shortest_period->thread_list;
    1d60:	fe843783          	ld	a5,-24(s0)
    1d64:	02878793          	addi	a5,a5,40
    1d68:	f4f43423          	sd	a5,-184(s0)
        int remaining_time_to_deadline = thread_with_shortest_period->current_deadline - args.current_time;
    1d6c:	fe843783          	ld	a5,-24(s0)
    1d70:	4bb8                	lw	a4,80(a5)
    1d72:	409c                	lw	a5,0(s1)
    1d74:	40f707bb          	subw	a5,a4,a5
    1d78:	f8f42a23          	sw	a5,-108(s0)
        
        // run until meets/misses deadline or gets preempted by higher priority
        r.allocated_time = thread_with_shortest_period->remaining_time <= remaining_time_to_deadline ? thread_with_shortest_period->remaining_time : remaining_time_to_deadline;
    1d7c:	fe843783          	ld	a5,-24(s0)
    1d80:	47fc                	lw	a5,76(a5)
    1d82:	853e                	mv	a0,a5
    1d84:	f9442783          	lw	a5,-108(s0)
    1d88:	0007859b          	sext.w	a1,a5
    1d8c:	0005071b          	sext.w	a4,a0
    1d90:	00b75363          	bge	a4,a1,1d96 <schedule_rm+0x17c>
    1d94:	87aa                	mv	a5,a0
    1d96:	2781                	sext.w	a5,a5
    1d98:	f4f42823          	sw	a5,-176(s0)
        struct release_queue_entry *entry = NULL;
    1d9c:	fc043423          	sd	zero,-56(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1da0:	689c                	ld	a5,16(s1)
    1da2:	639c                	ld	a5,0(a5)
    1da4:	f8f43423          	sd	a5,-120(s0)
    1da8:	f8843783          	ld	a5,-120(s0)
    1dac:	17e1                	addi	a5,a5,-8
    1dae:	fcf43423          	sd	a5,-56(s0)
    1db2:	a88d                	j	1e24 <schedule_rm+0x20a>
            if (entry->thrd->period < thread_with_shortest_period->period ||
    1db4:	fc843783          	ld	a5,-56(s0)
    1db8:	639c                	ld	a5,0(a5)
    1dba:	43f8                	lw	a4,68(a5)
    1dbc:	fe843783          	ld	a5,-24(s0)
    1dc0:	43fc                	lw	a5,68(a5)
    1dc2:	02f74463          	blt	a4,a5,1dea <schedule_rm+0x1d0>
                (entry->thrd->period == thread_with_shortest_period->period && entry->thrd->ID < thread_with_shortest_period->ID)) {
    1dc6:	fc843783          	ld	a5,-56(s0)
    1dca:	639c                	ld	a5,0(a5)
    1dcc:	43f8                	lw	a4,68(a5)
    1dce:	fe843783          	ld	a5,-24(s0)
    1dd2:	43fc                	lw	a5,68(a5)
            if (entry->thrd->period < thread_with_shortest_period->period ||
    1dd4:	02f71e63          	bne	a4,a5,1e10 <schedule_rm+0x1f6>
                (entry->thrd->period == thread_with_shortest_period->period && entry->thrd->ID < thread_with_shortest_period->ID)) {
    1dd8:	fc843783          	ld	a5,-56(s0)
    1ddc:	639c                	ld	a5,0(a5)
    1dde:	5398                	lw	a4,32(a5)
    1de0:	fe843783          	ld	a5,-24(s0)
    1de4:	539c                	lw	a5,32(a5)
    1de6:	02f75563          	bge	a4,a5,1e10 <schedule_rm+0x1f6>
                int remaining_time_to_next_release = entry->release_time - args.current_time;
    1dea:	fc843783          	ld	a5,-56(s0)
    1dee:	4f98                	lw	a4,24(a5)
    1df0:	409c                	lw	a5,0(s1)
    1df2:	40f707bb          	subw	a5,a4,a5
    1df6:	f8f42223          	sw	a5,-124(s0)
                if (remaining_time_to_next_release < r.allocated_time) {
    1dfa:	f5042703          	lw	a4,-176(s0)
    1dfe:	f8442783          	lw	a5,-124(s0)
    1e02:	2781                	sext.w	a5,a5
    1e04:	00e7d663          	bge	a5,a4,1e10 <schedule_rm+0x1f6>
                    r.allocated_time = remaining_time_to_next_release;
    1e08:	f8442783          	lw	a5,-124(s0)
    1e0c:	f4f42823          	sw	a5,-176(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1e10:	fc843783          	ld	a5,-56(s0)
    1e14:	679c                	ld	a5,8(a5)
    1e16:	f6f43c23          	sd	a5,-136(s0)
    1e1a:	f7843783          	ld	a5,-136(s0)
    1e1e:	17e1                	addi	a5,a5,-8
    1e20:	fcf43423          	sd	a5,-56(s0)
    1e24:	fc843783          	ld	a5,-56(s0)
    1e28:	00878713          	addi	a4,a5,8
    1e2c:	689c                	ld	a5,16(s1)
    1e2e:	f8f713e3          	bne	a4,a5,1db4 <schedule_rm+0x19a>
    1e32:	a885                	j	1ea2 <schedule_rm+0x288>
                }
            }
        }
    } else {
        // run queue is empty, allocate time for sleeping
        r.scheduled_thread_list_member = args.run_queue;
    1e34:	649c                	ld	a5,8(s1)
    1e36:	f4f43423          	sd	a5,-184(s0)
        r.allocated_time = 100;
    1e3a:	06400793          	li	a5,100
    1e3e:	f4f42823          	sw	a5,-176(s0)
        struct release_queue_entry *entry = NULL;
    1e42:	fc043023          	sd	zero,-64(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1e46:	689c                	ld	a5,16(s1)
    1e48:	639c                	ld	a5,0(a5)
    1e4a:	faf43823          	sd	a5,-80(s0)
    1e4e:	fb043783          	ld	a5,-80(s0)
    1e52:	17e1                	addi	a5,a5,-8
    1e54:	fcf43023          	sd	a5,-64(s0)
    1e58:	a835                	j	1e94 <schedule_rm+0x27a>
            int remaining_time_to_next_release = entry->release_time - args.current_time;
    1e5a:	fc043783          	ld	a5,-64(s0)
    1e5e:	4f98                	lw	a4,24(a5)
    1e60:	409c                	lw	a5,0(s1)
    1e62:	40f707bb          	subw	a5,a4,a5
    1e66:	faf42623          	sw	a5,-84(s0)
            if (remaining_time_to_next_release < r.allocated_time) {
    1e6a:	f5042703          	lw	a4,-176(s0)
    1e6e:	fac42783          	lw	a5,-84(s0)
    1e72:	2781                	sext.w	a5,a5
    1e74:	00e7d663          	bge	a5,a4,1e80 <schedule_rm+0x266>
                r.allocated_time = remaining_time_to_next_release;
    1e78:	fac42783          	lw	a5,-84(s0)
    1e7c:	f4f42823          	sw	a5,-176(s0)
        list_for_each_entry(entry, args.release_queue, thread_list) {
    1e80:	fc043783          	ld	a5,-64(s0)
    1e84:	679c                	ld	a5,8(a5)
    1e86:	faf43023          	sd	a5,-96(s0)
    1e8a:	fa043783          	ld	a5,-96(s0)
    1e8e:	17e1                	addi	a5,a5,-8
    1e90:	fcf43023          	sd	a5,-64(s0)
    1e94:	fc043783          	ld	a5,-64(s0)
    1e98:	00878713          	addi	a4,a5,8
    1e9c:	689c                	ld	a5,16(s1)
    1e9e:	faf71ee3          	bne	a4,a5,1e5a <schedule_rm+0x240>
            }
        }
    }

    return r;
    1ea2:	f4843783          	ld	a5,-184(s0)
    1ea6:	f4f43c23          	sd	a5,-168(s0)
    1eaa:	f5043783          	ld	a5,-176(s0)
    1eae:	f6f43023          	sd	a5,-160(s0)
}
    1eb2:	f5843703          	ld	a4,-168(s0)
    1eb6:	f6043783          	ld	a5,-160(s0)
    1eba:	863a                	mv	a2,a4
    1ebc:	86be                	mv	a3,a5
    1ebe:	8732                	mv	a4,a2
    1ec0:	87b6                	mv	a5,a3
    1ec2:	853a                	mv	a0,a4
    1ec4:	85be                	mv	a1,a5
    1ec6:	746a                	ld	s0,184(sp)
    1ec8:	74ca                	ld	s1,176(sp)
    1eca:	6129                	addi	sp,sp,192
    1ecc:	8082                	ret
