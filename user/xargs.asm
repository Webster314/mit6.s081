
user/_xargs:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <readline>:
#include "kernel/param.h"
#define LINE_MAX_LEN  512
#define ARG_MAX_LEN 32 

char *
readline(int fd){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	892a                	mv	s2,a0
    static char buf[LINE_MAX_LEN];
    char * p = buf;
  10:	00001497          	auipc	s1,0x1
  14:	a1848493          	addi	s1,s1,-1512 # a28 <buf.1083>
    while((read(fd, p, 1) > 0 && *p != '\n')){
  18:	49a9                	li	s3,10
  1a:	4605                	li	a2,1
  1c:	85a6                	mv	a1,s1
  1e:	854a                	mv	a0,s2
  20:	00000097          	auipc	ra,0x0
  24:	492080e7          	jalr	1170(ra) # 4b2 <read>
  28:	00a05863          	blez	a0,38 <readline+0x38>
  2c:	0004c783          	lbu	a5,0(s1)
  30:	01378463          	beq	a5,s3,38 <readline+0x38>
        p++;
  34:	0485                	addi	s1,s1,1
  36:	b7d5                	j	1a <readline+0x1a>
    }
    if(p == buf)
  38:	00001797          	auipc	a5,0x1
  3c:	9f078793          	addi	a5,a5,-1552 # a28 <buf.1083>
  40:	00f48c63          	beq	s1,a5,58 <readline+0x58>
        return 0;       // return NULL; ?
    *p = 0;
  44:	00048023          	sb	zero,0(s1)
    return buf;
  48:	853e                	mv	a0,a5
}
  4a:	70a2                	ld	ra,40(sp)
  4c:	7402                	ld	s0,32(sp)
  4e:	64e2                	ld	s1,24(sp)
  50:	6942                	ld	s2,16(sp)
  52:	69a2                	ld	s3,8(sp)
  54:	6145                	addi	sp,sp,48
  56:	8082                	ret
        return 0;       // return NULL; ?
  58:	4501                	li	a0,0
  5a:	bfc5                	j	4a <readline+0x4a>

000000000000005c <main>:

int
main(int argc, char * argv[]){
  5c:	a8010113          	addi	sp,sp,-1408
  60:	56113c23          	sd	ra,1400(sp)
  64:	56813823          	sd	s0,1392(sp)
  68:	56913423          	sd	s1,1384(sp)
  6c:	57213023          	sd	s2,1376(sp)
  70:	55313c23          	sd	s3,1368(sp)
  74:	55413823          	sd	s4,1360(sp)
  78:	55513423          	sd	s5,1352(sp)
  7c:	55613023          	sd	s6,1344(sp)
  80:	53713c23          	sd	s7,1336(sp)
  84:	53813823          	sd	s8,1328(sp)
  88:	53913423          	sd	s9,1320(sp)
  8c:	53a13023          	sd	s10,1312(sp)
  90:	51b13c23          	sd	s11,1304(sp)
  94:	58010413          	addi	s0,sp,1408
  98:	8c2a                	mv	s8,a0
  9a:	8d2e                	mv	s10,a1
    char * buf;
    int childpid;
    printf("\n");
  9c:	00001517          	auipc	a0,0x1
  a0:	95c50513          	addi	a0,a0,-1700 # 9f8 <malloc+0x128>
  a4:	00000097          	auipc	ra,0x0
  a8:	76e080e7          	jalr	1902(ra) # 812 <printf>
    while((buf = readline(0)) != 0){
  ac:	ffdc0a9b          	addiw	s5,s8,-3
  b0:	1a82                	slli	s5,s5,0x20
  b2:	020ada93          	srli	s5,s5,0x20
  b6:	0a8e                	slli	s5,s5,0x3
  b8:	018d0793          	addi	a5,s10,24
  bc:	9abe                	add	s5,s5,a5
  be:	4709                	li	a4,2
  c0:	4785                	li	a5,1
  c2:	01875563          	bge	a4,s8,cc <main+0x70>
  c6:	fffc069b          	addiw	a3,s8,-1
  ca:	87b6                	mv	a5,a3
  cc:	2781                	sext.w	a5,a5
  ce:	a8f43423          	sd	a5,-1400(s0)
        int buf_len = strlen(buf);
        char split[MAXARG][ARG_MAX_LEN] = {0};
        char * exec_args[MAXARG];

        exec_args[0] = argc > 1 ? argv[1] : "echo";
  d2:	4d85                	li	s11,1
        int index = 1;
        for(int i = 2; i < argc; i++){
  d4:	4c89                	li	s9,2
            }else{
                split[index][cur] = 0;
                exec_args[index] = split[index];
                index++;
                cur = 0; 
                if(index >= MAXARG && i != buf_len){
  d6:	4bfd                	li	s7,31
    while((buf = readline(0)) != 0){
  d8:	a879                	j	176 <main+0x11a>
                split[index][cur++] = buf[i];
  da:	00591793          	slli	a5,s2,0x5
  de:	f9040613          	addi	a2,s0,-112
  e2:	97b2                	add	a5,a5,a2
  e4:	97ba                	add	a5,a5,a4
  e6:	c0d78023          	sb	a3,-1024(a5)
  ea:	2705                	addiw	a4,a4,1
        for(int i = 0; i < buf_len; i++){
  ec:	0485                	addi	s1,s1,1
  ee:	05348963          	beq	s1,s3,140 <main+0xe4>
            if(buf[i] != ' '){
  f2:	0004c683          	lbu	a3,0(s1)
  f6:	ff4692e3          	bne	a3,s4,da <main+0x7e>
                split[index][cur] = 0;
  fa:	00591793          	slli	a5,s2,0x5
  fe:	f9040693          	addi	a3,s0,-112
 102:	96be                	add	a3,a3,a5
 104:	9736                	add	a4,a4,a3
 106:	c0070023          	sb	zero,-1024(a4)
                exec_args[index] = split[index];
 10a:	00391713          	slli	a4,s2,0x3
 10e:	f9040693          	addi	a3,s0,-112
 112:	9736                	add	a4,a4,a3
 114:	b9040693          	addi	a3,s0,-1136
 118:	97b6                	add	a5,a5,a3
 11a:	b0f73023          	sd	a5,-1280(a4)
                index++;
 11e:	2905                	addiw	s2,s2,1
                cur = 0; 
 120:	875a                	mv	a4,s6
                if(index >= MAXARG && i != buf_len){
 122:	fd2bd5e3          	bge	s7,s2,ec <main+0x90>
                    fprintf(2, "error: too many arguments.\n");
 126:	00001597          	auipc	a1,0x1
 12a:	89a58593          	addi	a1,a1,-1894 # 9c0 <malloc+0xf0>
 12e:	8566                	mv	a0,s9
 130:	00000097          	auipc	ra,0x0
 134:	6b4080e7          	jalr	1716(ra) # 7e4 <fprintf>
                cur = 0; 
 138:	875a                	mv	a4,s6
 13a:	bf4d                	j	ec <main+0x90>
        for(int i = 0; i < buf_len; i++){
 13c:	a8843903          	ld	s2,-1400(s0)
                }
            }
        }
        exec_args[index] = split[index];
 140:	00391793          	slli	a5,s2,0x3
 144:	f9040713          	addi	a4,s0,-112
 148:	97ba                	add	a5,a5,a4
 14a:	0916                	slli	s2,s2,0x5
 14c:	b9040713          	addi	a4,s0,-1136
 150:	993a                	add	s2,s2,a4
 152:	b127b023          	sd	s2,-1280(a5)
        childpid = fork();
 156:	00000097          	auipc	ra,0x0
 15a:	33c080e7          	jalr	828(ra) # 492 <fork>
        if(childpid == -1){         // fork error.
 15e:	57fd                	li	a5,-1
 160:	08f50963          	beq	a0,a5,1f2 <main+0x196>
            fprintf(2, "error: unable to fork().\n");
            exit(-1);
        }else if(childpid == 0){    // child proc.
 164:	e54d                	bnez	a0,20e <main+0x1b2>
            exec(exec_args[0], exec_args);
 166:	a9040593          	addi	a1,s0,-1392
 16a:	a9043503          	ld	a0,-1392(s0)
 16e:	00000097          	auipc	ra,0x0
 172:	364080e7          	jalr	868(ra) # 4d2 <exec>
    while((buf = readline(0)) != 0){
 176:	4501                	li	a0,0
 178:	00000097          	auipc	ra,0x0
 17c:	e88080e7          	jalr	-376(ra) # 0 <readline>
 180:	892a                	mv	s2,a0
 182:	cd41                	beqz	a0,21a <main+0x1be>
        int buf_len = strlen(buf);
 184:	854a                	mv	a0,s2
 186:	00000097          	auipc	ra,0x0
 18a:	0e6080e7          	jalr	230(ra) # 26c <strlen>
 18e:	0005099b          	sext.w	s3,a0
 192:	84ce                	mv	s1,s3
        char split[MAXARG][ARG_MAX_LEN] = {0};
 194:	40000613          	li	a2,1024
 198:	4581                	li	a1,0
 19a:	b9040513          	addi	a0,s0,-1136
 19e:	00000097          	auipc	ra,0x0
 1a2:	0f8080e7          	jalr	248(ra) # 296 <memset>
        exec_args[0] = argc > 1 ? argv[1] : "echo";
 1a6:	00001797          	auipc	a5,0x1
 1aa:	81278793          	addi	a5,a5,-2030 # 9b8 <malloc+0xe8>
 1ae:	018dd463          	bge	s11,s8,1b6 <main+0x15a>
 1b2:	008d3783          	ld	a5,8(s10)
 1b6:	a8f43823          	sd	a5,-1392(s0)
        for(int i = 2; i < argc; i++){
 1ba:	018cdc63          	bge	s9,s8,1d2 <main+0x176>
 1be:	010d0793          	addi	a5,s10,16
 1c2:	a9840713          	addi	a4,s0,-1384
            exec_args[index++] = argv[i];
 1c6:	6394                	ld	a3,0(a5)
 1c8:	e314                	sd	a3,0(a4)
        for(int i = 2; i < argc; i++){
 1ca:	07a1                	addi	a5,a5,8
 1cc:	0721                	addi	a4,a4,8
 1ce:	ff579ce3          	bne	a5,s5,1c6 <main+0x16a>
        for(int i = 0; i < buf_len; i++){
 1d2:	f69055e3          	blez	s1,13c <main+0xe0>
 1d6:	84ca                	mv	s1,s2
 1d8:	39fd                	addiw	s3,s3,-1
 1da:	1982                	slli	s3,s3,0x20
 1dc:	0209d993          	srli	s3,s3,0x20
 1e0:	0905                	addi	s2,s2,1
 1e2:	99ca                	add	s3,s3,s2
 1e4:	a8843903          	ld	s2,-1400(s0)
        int cur = 0;
 1e8:	4701                	li	a4,0
            if(buf[i] != ' '){
 1ea:	02000a13          	li	s4,32
                cur = 0; 
 1ee:	4b01                	li	s6,0
 1f0:	b709                	j	f2 <main+0x96>
            fprintf(2, "error: unable to fork().\n");
 1f2:	00000597          	auipc	a1,0x0
 1f6:	7ee58593          	addi	a1,a1,2030 # 9e0 <malloc+0x110>
 1fa:	4509                	li	a0,2
 1fc:	00000097          	auipc	ra,0x0
 200:	5e8080e7          	jalr	1512(ra) # 7e4 <fprintf>
            exit(-1);
 204:	557d                	li	a0,-1
 206:	00000097          	auipc	ra,0x0
 20a:	294080e7          	jalr	660(ra) # 49a <exit>
        }else{                      // father proc.
            wait(0);
 20e:	4501                	li	a0,0
 210:	00000097          	auipc	ra,0x0
 214:	292080e7          	jalr	658(ra) # 4a2 <wait>
 218:	bfb9                	j	176 <main+0x11a>
        }
    }
    exit(0);
 21a:	4501                	li	a0,0
 21c:	00000097          	auipc	ra,0x0
 220:	27e080e7          	jalr	638(ra) # 49a <exit>

0000000000000224 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
 224:	1141                	addi	sp,sp,-16
 226:	e422                	sd	s0,8(sp)
 228:	0800                	addi	s0,sp,16
  char *os;
  os = s;
  while((*s++ = *t++) != 0)
 22a:	87aa                	mv	a5,a0
 22c:	0585                	addi	a1,a1,1
 22e:	0785                	addi	a5,a5,1
 230:	fff5c703          	lbu	a4,-1(a1)
 234:	fee78fa3          	sb	a4,-1(a5)
 238:	fb75                	bnez	a4,22c <strcpy+0x8>
    ;
  return os;
}
 23a:	6422                	ld	s0,8(sp)
 23c:	0141                	addi	sp,sp,16
 23e:	8082                	ret

0000000000000240 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 240:	1141                	addi	sp,sp,-16
 242:	e422                	sd	s0,8(sp)
 244:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
 246:	00054783          	lbu	a5,0(a0)
 24a:	cb91                	beqz	a5,25e <strcmp+0x1e>
 24c:	0005c703          	lbu	a4,0(a1)
 250:	00f71763          	bne	a4,a5,25e <strcmp+0x1e>
    p++, q++;
 254:	0505                	addi	a0,a0,1
 256:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
 258:	00054783          	lbu	a5,0(a0)
 25c:	fbe5                	bnez	a5,24c <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
 25e:	0005c503          	lbu	a0,0(a1)
}
 262:	40a7853b          	subw	a0,a5,a0
 266:	6422                	ld	s0,8(sp)
 268:	0141                	addi	sp,sp,16
 26a:	8082                	ret

000000000000026c <strlen>:

uint
strlen(const char *s)
{
 26c:	1141                	addi	sp,sp,-16
 26e:	e422                	sd	s0,8(sp)
 270:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
 272:	00054783          	lbu	a5,0(a0)
 276:	cf91                	beqz	a5,292 <strlen+0x26>
 278:	0505                	addi	a0,a0,1
 27a:	87aa                	mv	a5,a0
 27c:	4685                	li	a3,1
 27e:	9e89                	subw	a3,a3,a0
 280:	00f6853b          	addw	a0,a3,a5
 284:	0785                	addi	a5,a5,1
 286:	fff7c703          	lbu	a4,-1(a5)
 28a:	fb7d                	bnez	a4,280 <strlen+0x14>
    ;
  return n;
}
 28c:	6422                	ld	s0,8(sp)
 28e:	0141                	addi	sp,sp,16
 290:	8082                	ret
  for(n = 0; s[n]; n++)
 292:	4501                	li	a0,0
 294:	bfe5                	j	28c <strlen+0x20>

0000000000000296 <memset>:

void*
memset(void *dst, int c, uint n)
{
 296:	1141                	addi	sp,sp,-16
 298:	e422                	sd	s0,8(sp)
 29a:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
 29c:	ce09                	beqz	a2,2b6 <memset+0x20>
 29e:	87aa                	mv	a5,a0
 2a0:	fff6071b          	addiw	a4,a2,-1
 2a4:	1702                	slli	a4,a4,0x20
 2a6:	9301                	srli	a4,a4,0x20
 2a8:	0705                	addi	a4,a4,1
 2aa:	972a                	add	a4,a4,a0
    cdst[i] = c;
 2ac:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
 2b0:	0785                	addi	a5,a5,1
 2b2:	fee79de3          	bne	a5,a4,2ac <memset+0x16>
  }
  return dst;
}
 2b6:	6422                	ld	s0,8(sp)
 2b8:	0141                	addi	sp,sp,16
 2ba:	8082                	ret

00000000000002bc <strchr>:

char*
strchr(const char *s, char c)
{
 2bc:	1141                	addi	sp,sp,-16
 2be:	e422                	sd	s0,8(sp)
 2c0:	0800                	addi	s0,sp,16
  for(; *s; s++)
 2c2:	00054783          	lbu	a5,0(a0)
 2c6:	cb99                	beqz	a5,2dc <strchr+0x20>
    if(*s == c)
 2c8:	00f58763          	beq	a1,a5,2d6 <strchr+0x1a>
  for(; *s; s++)
 2cc:	0505                	addi	a0,a0,1
 2ce:	00054783          	lbu	a5,0(a0)
 2d2:	fbfd                	bnez	a5,2c8 <strchr+0xc>
      return (char*)s;
  return 0;
 2d4:	4501                	li	a0,0
}
 2d6:	6422                	ld	s0,8(sp)
 2d8:	0141                	addi	sp,sp,16
 2da:	8082                	ret
  return 0;
 2dc:	4501                	li	a0,0
 2de:	bfe5                	j	2d6 <strchr+0x1a>

00000000000002e0 <gets>:

char*
gets(char *buf, int max)
{
 2e0:	711d                	addi	sp,sp,-96
 2e2:	ec86                	sd	ra,88(sp)
 2e4:	e8a2                	sd	s0,80(sp)
 2e6:	e4a6                	sd	s1,72(sp)
 2e8:	e0ca                	sd	s2,64(sp)
 2ea:	fc4e                	sd	s3,56(sp)
 2ec:	f852                	sd	s4,48(sp)
 2ee:	f456                	sd	s5,40(sp)
 2f0:	f05a                	sd	s6,32(sp)
 2f2:	ec5e                	sd	s7,24(sp)
 2f4:	1080                	addi	s0,sp,96
 2f6:	8baa                	mv	s7,a0
 2f8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2fa:	892a                	mv	s2,a0
 2fc:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
 2fe:	4aa9                	li	s5,10
 300:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
 302:	89a6                	mv	s3,s1
 304:	2485                	addiw	s1,s1,1
 306:	0344d863          	bge	s1,s4,336 <gets+0x56>
    cc = read(0, &c, 1);
 30a:	4605                	li	a2,1
 30c:	faf40593          	addi	a1,s0,-81
 310:	4501                	li	a0,0
 312:	00000097          	auipc	ra,0x0
 316:	1a0080e7          	jalr	416(ra) # 4b2 <read>
    if(cc < 1)
 31a:	00a05e63          	blez	a0,336 <gets+0x56>
    buf[i++] = c;
 31e:	faf44783          	lbu	a5,-81(s0)
 322:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
 326:	01578763          	beq	a5,s5,334 <gets+0x54>
 32a:	0905                	addi	s2,s2,1
 32c:	fd679be3          	bne	a5,s6,302 <gets+0x22>
  for(i=0; i+1 < max; ){
 330:	89a6                	mv	s3,s1
 332:	a011                	j	336 <gets+0x56>
 334:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
 336:	99de                	add	s3,s3,s7
 338:	00098023          	sb	zero,0(s3)
  return buf;
}
 33c:	855e                	mv	a0,s7
 33e:	60e6                	ld	ra,88(sp)
 340:	6446                	ld	s0,80(sp)
 342:	64a6                	ld	s1,72(sp)
 344:	6906                	ld	s2,64(sp)
 346:	79e2                	ld	s3,56(sp)
 348:	7a42                	ld	s4,48(sp)
 34a:	7aa2                	ld	s5,40(sp)
 34c:	7b02                	ld	s6,32(sp)
 34e:	6be2                	ld	s7,24(sp)
 350:	6125                	addi	sp,sp,96
 352:	8082                	ret

0000000000000354 <stat>:

int
stat(const char *n, struct stat *st)
{
 354:	1101                	addi	sp,sp,-32
 356:	ec06                	sd	ra,24(sp)
 358:	e822                	sd	s0,16(sp)
 35a:	e426                	sd	s1,8(sp)
 35c:	e04a                	sd	s2,0(sp)
 35e:	1000                	addi	s0,sp,32
 360:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 362:	4581                	li	a1,0
 364:	00000097          	auipc	ra,0x0
 368:	176080e7          	jalr	374(ra) # 4da <open>
  if(fd < 0)
 36c:	02054563          	bltz	a0,396 <stat+0x42>
 370:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
 372:	85ca                	mv	a1,s2
 374:	00000097          	auipc	ra,0x0
 378:	17e080e7          	jalr	382(ra) # 4f2 <fstat>
 37c:	892a                	mv	s2,a0
  close(fd);
 37e:	8526                	mv	a0,s1
 380:	00000097          	auipc	ra,0x0
 384:	142080e7          	jalr	322(ra) # 4c2 <close>
  return r;
}
 388:	854a                	mv	a0,s2
 38a:	60e2                	ld	ra,24(sp)
 38c:	6442                	ld	s0,16(sp)
 38e:	64a2                	ld	s1,8(sp)
 390:	6902                	ld	s2,0(sp)
 392:	6105                	addi	sp,sp,32
 394:	8082                	ret
    return -1;
 396:	597d                	li	s2,-1
 398:	bfc5                	j	388 <stat+0x34>

000000000000039a <atoi>:

int
atoi(const char *s)
{
 39a:	1141                	addi	sp,sp,-16
 39c:	e422                	sd	s0,8(sp)
 39e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 3a0:	00054603          	lbu	a2,0(a0)
 3a4:	fd06079b          	addiw	a5,a2,-48
 3a8:	0ff7f793          	andi	a5,a5,255
 3ac:	4725                	li	a4,9
 3ae:	02f76963          	bltu	a4,a5,3e0 <atoi+0x46>
 3b2:	86aa                	mv	a3,a0
  n = 0;
 3b4:	4501                	li	a0,0
  while('0' <= *s && *s <= '9')
 3b6:	45a5                	li	a1,9
    n = n*10 + *s++ - '0';
 3b8:	0685                	addi	a3,a3,1
 3ba:	0025179b          	slliw	a5,a0,0x2
 3be:	9fa9                	addw	a5,a5,a0
 3c0:	0017979b          	slliw	a5,a5,0x1
 3c4:	9fb1                	addw	a5,a5,a2
 3c6:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
 3ca:	0006c603          	lbu	a2,0(a3)
 3ce:	fd06071b          	addiw	a4,a2,-48
 3d2:	0ff77713          	andi	a4,a4,255
 3d6:	fee5f1e3          	bgeu	a1,a4,3b8 <atoi+0x1e>
  return n;
}
 3da:	6422                	ld	s0,8(sp)
 3dc:	0141                	addi	sp,sp,16
 3de:	8082                	ret
  n = 0;
 3e0:	4501                	li	a0,0
 3e2:	bfe5                	j	3da <atoi+0x40>

00000000000003e4 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3e4:	1141                	addi	sp,sp,-16
 3e6:	e422                	sd	s0,8(sp)
 3e8:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;
  dst = vdst;
  src = vsrc;
  if (src > dst) {        // dst src 
 3ea:	02b57663          	bgeu	a0,a1,416 <memmove+0x32>
    while(n-- > 0)
 3ee:	02c05163          	blez	a2,410 <memmove+0x2c>
 3f2:	fff6079b          	addiw	a5,a2,-1
 3f6:	1782                	slli	a5,a5,0x20
 3f8:	9381                	srli	a5,a5,0x20
 3fa:	0785                	addi	a5,a5,1
 3fc:	97aa                	add	a5,a5,a0
  dst = vdst;
 3fe:	872a                	mv	a4,a0
      *dst++ = *src++;    
 400:	0585                	addi	a1,a1,1
 402:	0705                	addi	a4,a4,1
 404:	fff5c683          	lbu	a3,-1(a1)
 408:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
 40c:	fee79ae3          	bne	a5,a4,400 <memmove+0x1c>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
 410:	6422                	ld	s0,8(sp)
 412:	0141                	addi	sp,sp,16
 414:	8082                	ret
    dst += n;
 416:	00c50733          	add	a4,a0,a2
    src += n;
 41a:	95b2                	add	a1,a1,a2
    while(n-- > 0)
 41c:	fec05ae3          	blez	a2,410 <memmove+0x2c>
 420:	fff6079b          	addiw	a5,a2,-1
 424:	1782                	slli	a5,a5,0x20
 426:	9381                	srli	a5,a5,0x20
 428:	fff7c793          	not	a5,a5
 42c:	97ba                	add	a5,a5,a4
      *--dst = *--src;
 42e:	15fd                	addi	a1,a1,-1
 430:	177d                	addi	a4,a4,-1
 432:	0005c683          	lbu	a3,0(a1)
 436:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
 43a:	fee79ae3          	bne	a5,a4,42e <memmove+0x4a>
 43e:	bfc9                	j	410 <memmove+0x2c>

0000000000000440 <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
 440:	1141                	addi	sp,sp,-16
 442:	e422                	sd	s0,8(sp)
 444:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
 446:	ca05                	beqz	a2,476 <memcmp+0x36>
 448:	fff6069b          	addiw	a3,a2,-1
 44c:	1682                	slli	a3,a3,0x20
 44e:	9281                	srli	a3,a3,0x20
 450:	0685                	addi	a3,a3,1
 452:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
 454:	00054783          	lbu	a5,0(a0)
 458:	0005c703          	lbu	a4,0(a1)
 45c:	00e79863          	bne	a5,a4,46c <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
 460:	0505                	addi	a0,a0,1
    p2++;
 462:	0585                	addi	a1,a1,1
  while (n-- > 0) {
 464:	fed518e3          	bne	a0,a3,454 <memcmp+0x14>
  }
  return 0;
 468:	4501                	li	a0,0
 46a:	a019                	j	470 <memcmp+0x30>
      return *p1 - *p2;
 46c:	40e7853b          	subw	a0,a5,a4
}
 470:	6422                	ld	s0,8(sp)
 472:	0141                	addi	sp,sp,16
 474:	8082                	ret
  return 0;
 476:	4501                	li	a0,0
 478:	bfe5                	j	470 <memcmp+0x30>

000000000000047a <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
 47a:	1141                	addi	sp,sp,-16
 47c:	e406                	sd	ra,8(sp)
 47e:	e022                	sd	s0,0(sp)
 480:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
 482:	00000097          	auipc	ra,0x0
 486:	f62080e7          	jalr	-158(ra) # 3e4 <memmove>
}
 48a:	60a2                	ld	ra,8(sp)
 48c:	6402                	ld	s0,0(sp)
 48e:	0141                	addi	sp,sp,16
 490:	8082                	ret

0000000000000492 <fork>:
 492:	4885                	li	a7,1
 494:	00000073          	ecall
 498:	8082                	ret

000000000000049a <exit>:
 49a:	4889                	li	a7,2
 49c:	00000073          	ecall
 4a0:	8082                	ret

00000000000004a2 <wait>:
 4a2:	488d                	li	a7,3
 4a4:	00000073          	ecall
 4a8:	8082                	ret

00000000000004aa <pipe>:
 4aa:	4891                	li	a7,4
 4ac:	00000073          	ecall
 4b0:	8082                	ret

00000000000004b2 <read>:
 4b2:	4895                	li	a7,5
 4b4:	00000073          	ecall
 4b8:	8082                	ret

00000000000004ba <write>:
 4ba:	48c1                	li	a7,16
 4bc:	00000073          	ecall
 4c0:	8082                	ret

00000000000004c2 <close>:
 4c2:	48d5                	li	a7,21
 4c4:	00000073          	ecall
 4c8:	8082                	ret

00000000000004ca <kill>:
 4ca:	4899                	li	a7,6
 4cc:	00000073          	ecall
 4d0:	8082                	ret

00000000000004d2 <exec>:
 4d2:	489d                	li	a7,7
 4d4:	00000073          	ecall
 4d8:	8082                	ret

00000000000004da <open>:
 4da:	48bd                	li	a7,15
 4dc:	00000073          	ecall
 4e0:	8082                	ret

00000000000004e2 <mknod>:
 4e2:	48c5                	li	a7,17
 4e4:	00000073          	ecall
 4e8:	8082                	ret

00000000000004ea <unlink>:
 4ea:	48c9                	li	a7,18
 4ec:	00000073          	ecall
 4f0:	8082                	ret

00000000000004f2 <fstat>:
 4f2:	48a1                	li	a7,8
 4f4:	00000073          	ecall
 4f8:	8082                	ret

00000000000004fa <link>:
 4fa:	48cd                	li	a7,19
 4fc:	00000073          	ecall
 500:	8082                	ret

0000000000000502 <mkdir>:
 502:	48d1                	li	a7,20
 504:	00000073          	ecall
 508:	8082                	ret

000000000000050a <chdir>:
 50a:	48a5                	li	a7,9
 50c:	00000073          	ecall
 510:	8082                	ret

0000000000000512 <dup>:
 512:	48a9                	li	a7,10
 514:	00000073          	ecall
 518:	8082                	ret

000000000000051a <getpid>:
 51a:	48ad                	li	a7,11
 51c:	00000073          	ecall
 520:	8082                	ret

0000000000000522 <sbrk>:
 522:	48b1                	li	a7,12
 524:	00000073          	ecall
 528:	8082                	ret

000000000000052a <sleep>:
 52a:	48b5                	li	a7,13
 52c:	00000073          	ecall
 530:	8082                	ret

0000000000000532 <uptime>:
 532:	48b9                	li	a7,14
 534:	00000073          	ecall
 538:	8082                	ret

000000000000053a <putc>:
 53a:	1101                	addi	sp,sp,-32
 53c:	ec06                	sd	ra,24(sp)
 53e:	e822                	sd	s0,16(sp)
 540:	1000                	addi	s0,sp,32
 542:	feb407a3          	sb	a1,-17(s0)
 546:	4605                	li	a2,1
 548:	fef40593          	addi	a1,s0,-17
 54c:	00000097          	auipc	ra,0x0
 550:	f6e080e7          	jalr	-146(ra) # 4ba <write>
 554:	60e2                	ld	ra,24(sp)
 556:	6442                	ld	s0,16(sp)
 558:	6105                	addi	sp,sp,32
 55a:	8082                	ret

000000000000055c <printint>:
 55c:	7139                	addi	sp,sp,-64
 55e:	fc06                	sd	ra,56(sp)
 560:	f822                	sd	s0,48(sp)
 562:	f426                	sd	s1,40(sp)
 564:	f04a                	sd	s2,32(sp)
 566:	ec4e                	sd	s3,24(sp)
 568:	0080                	addi	s0,sp,64
 56a:	84aa                	mv	s1,a0
 56c:	c299                	beqz	a3,572 <printint+0x16>
 56e:	0805c863          	bltz	a1,5fe <printint+0xa2>
 572:	2581                	sext.w	a1,a1
 574:	4881                	li	a7,0
 576:	fc040693          	addi	a3,s0,-64
 57a:	4701                	li	a4,0
 57c:	2601                	sext.w	a2,a2
 57e:	00000517          	auipc	a0,0x0
 582:	48a50513          	addi	a0,a0,1162 # a08 <digits>
 586:	883a                	mv	a6,a4
 588:	2705                	addiw	a4,a4,1
 58a:	02c5f7bb          	remuw	a5,a1,a2
 58e:	1782                	slli	a5,a5,0x20
 590:	9381                	srli	a5,a5,0x20
 592:	97aa                	add	a5,a5,a0
 594:	0007c783          	lbu	a5,0(a5)
 598:	00f68023          	sb	a5,0(a3)
 59c:	0005879b          	sext.w	a5,a1
 5a0:	02c5d5bb          	divuw	a1,a1,a2
 5a4:	0685                	addi	a3,a3,1
 5a6:	fec7f0e3          	bgeu	a5,a2,586 <printint+0x2a>
 5aa:	00088b63          	beqz	a7,5c0 <printint+0x64>
 5ae:	fd040793          	addi	a5,s0,-48
 5b2:	973e                	add	a4,a4,a5
 5b4:	02d00793          	li	a5,45
 5b8:	fef70823          	sb	a5,-16(a4)
 5bc:	0028071b          	addiw	a4,a6,2
 5c0:	02e05863          	blez	a4,5f0 <printint+0x94>
 5c4:	fc040793          	addi	a5,s0,-64
 5c8:	00e78933          	add	s2,a5,a4
 5cc:	fff78993          	addi	s3,a5,-1
 5d0:	99ba                	add	s3,s3,a4
 5d2:	377d                	addiw	a4,a4,-1
 5d4:	1702                	slli	a4,a4,0x20
 5d6:	9301                	srli	a4,a4,0x20
 5d8:	40e989b3          	sub	s3,s3,a4
 5dc:	fff94583          	lbu	a1,-1(s2)
 5e0:	8526                	mv	a0,s1
 5e2:	00000097          	auipc	ra,0x0
 5e6:	f58080e7          	jalr	-168(ra) # 53a <putc>
 5ea:	197d                	addi	s2,s2,-1
 5ec:	ff3918e3          	bne	s2,s3,5dc <printint+0x80>
 5f0:	70e2                	ld	ra,56(sp)
 5f2:	7442                	ld	s0,48(sp)
 5f4:	74a2                	ld	s1,40(sp)
 5f6:	7902                	ld	s2,32(sp)
 5f8:	69e2                	ld	s3,24(sp)
 5fa:	6121                	addi	sp,sp,64
 5fc:	8082                	ret
 5fe:	40b005bb          	negw	a1,a1
 602:	4885                	li	a7,1
 604:	bf8d                	j	576 <printint+0x1a>

0000000000000606 <vprintf>:
 606:	7119                	addi	sp,sp,-128
 608:	fc86                	sd	ra,120(sp)
 60a:	f8a2                	sd	s0,112(sp)
 60c:	f4a6                	sd	s1,104(sp)
 60e:	f0ca                	sd	s2,96(sp)
 610:	ecce                	sd	s3,88(sp)
 612:	e8d2                	sd	s4,80(sp)
 614:	e4d6                	sd	s5,72(sp)
 616:	e0da                	sd	s6,64(sp)
 618:	fc5e                	sd	s7,56(sp)
 61a:	f862                	sd	s8,48(sp)
 61c:	f466                	sd	s9,40(sp)
 61e:	f06a                	sd	s10,32(sp)
 620:	ec6e                	sd	s11,24(sp)
 622:	0100                	addi	s0,sp,128
 624:	0005c903          	lbu	s2,0(a1)
 628:	18090f63          	beqz	s2,7c6 <vprintf+0x1c0>
 62c:	8aaa                	mv	s5,a0
 62e:	8b32                	mv	s6,a2
 630:	00158493          	addi	s1,a1,1
 634:	4981                	li	s3,0
 636:	02500a13          	li	s4,37
 63a:	06400c13          	li	s8,100
 63e:	06c00c93          	li	s9,108
 642:	07800d13          	li	s10,120
 646:	07000d93          	li	s11,112
 64a:	00000b97          	auipc	s7,0x0
 64e:	3beb8b93          	addi	s7,s7,958 # a08 <digits>
 652:	a839                	j	670 <vprintf+0x6a>
 654:	85ca                	mv	a1,s2
 656:	8556                	mv	a0,s5
 658:	00000097          	auipc	ra,0x0
 65c:	ee2080e7          	jalr	-286(ra) # 53a <putc>
 660:	a019                	j	666 <vprintf+0x60>
 662:	01498f63          	beq	s3,s4,680 <vprintf+0x7a>
 666:	0485                	addi	s1,s1,1
 668:	fff4c903          	lbu	s2,-1(s1)
 66c:	14090d63          	beqz	s2,7c6 <vprintf+0x1c0>
 670:	0009079b          	sext.w	a5,s2
 674:	fe0997e3          	bnez	s3,662 <vprintf+0x5c>
 678:	fd479ee3          	bne	a5,s4,654 <vprintf+0x4e>
 67c:	89be                	mv	s3,a5
 67e:	b7e5                	j	666 <vprintf+0x60>
 680:	05878063          	beq	a5,s8,6c0 <vprintf+0xba>
 684:	05978c63          	beq	a5,s9,6dc <vprintf+0xd6>
 688:	07a78863          	beq	a5,s10,6f8 <vprintf+0xf2>
 68c:	09b78463          	beq	a5,s11,714 <vprintf+0x10e>
 690:	07300713          	li	a4,115
 694:	0ce78663          	beq	a5,a4,760 <vprintf+0x15a>
 698:	06300713          	li	a4,99
 69c:	0ee78e63          	beq	a5,a4,798 <vprintf+0x192>
 6a0:	11478863          	beq	a5,s4,7b0 <vprintf+0x1aa>
 6a4:	85d2                	mv	a1,s4
 6a6:	8556                	mv	a0,s5
 6a8:	00000097          	auipc	ra,0x0
 6ac:	e92080e7          	jalr	-366(ra) # 53a <putc>
 6b0:	85ca                	mv	a1,s2
 6b2:	8556                	mv	a0,s5
 6b4:	00000097          	auipc	ra,0x0
 6b8:	e86080e7          	jalr	-378(ra) # 53a <putc>
 6bc:	4981                	li	s3,0
 6be:	b765                	j	666 <vprintf+0x60>
 6c0:	008b0913          	addi	s2,s6,8
 6c4:	4685                	li	a3,1
 6c6:	4629                	li	a2,10
 6c8:	000b2583          	lw	a1,0(s6)
 6cc:	8556                	mv	a0,s5
 6ce:	00000097          	auipc	ra,0x0
 6d2:	e8e080e7          	jalr	-370(ra) # 55c <printint>
 6d6:	8b4a                	mv	s6,s2
 6d8:	4981                	li	s3,0
 6da:	b771                	j	666 <vprintf+0x60>
 6dc:	008b0913          	addi	s2,s6,8
 6e0:	4681                	li	a3,0
 6e2:	4629                	li	a2,10
 6e4:	000b2583          	lw	a1,0(s6)
 6e8:	8556                	mv	a0,s5
 6ea:	00000097          	auipc	ra,0x0
 6ee:	e72080e7          	jalr	-398(ra) # 55c <printint>
 6f2:	8b4a                	mv	s6,s2
 6f4:	4981                	li	s3,0
 6f6:	bf85                	j	666 <vprintf+0x60>
 6f8:	008b0913          	addi	s2,s6,8
 6fc:	4681                	li	a3,0
 6fe:	4641                	li	a2,16
 700:	000b2583          	lw	a1,0(s6)
 704:	8556                	mv	a0,s5
 706:	00000097          	auipc	ra,0x0
 70a:	e56080e7          	jalr	-426(ra) # 55c <printint>
 70e:	8b4a                	mv	s6,s2
 710:	4981                	li	s3,0
 712:	bf91                	j	666 <vprintf+0x60>
 714:	008b0793          	addi	a5,s6,8
 718:	f8f43423          	sd	a5,-120(s0)
 71c:	000b3983          	ld	s3,0(s6)
 720:	03000593          	li	a1,48
 724:	8556                	mv	a0,s5
 726:	00000097          	auipc	ra,0x0
 72a:	e14080e7          	jalr	-492(ra) # 53a <putc>
 72e:	85ea                	mv	a1,s10
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	e08080e7          	jalr	-504(ra) # 53a <putc>
 73a:	4941                	li	s2,16
 73c:	03c9d793          	srli	a5,s3,0x3c
 740:	97de                	add	a5,a5,s7
 742:	0007c583          	lbu	a1,0(a5)
 746:	8556                	mv	a0,s5
 748:	00000097          	auipc	ra,0x0
 74c:	df2080e7          	jalr	-526(ra) # 53a <putc>
 750:	0992                	slli	s3,s3,0x4
 752:	397d                	addiw	s2,s2,-1
 754:	fe0914e3          	bnez	s2,73c <vprintf+0x136>
 758:	f8843b03          	ld	s6,-120(s0)
 75c:	4981                	li	s3,0
 75e:	b721                	j	666 <vprintf+0x60>
 760:	008b0993          	addi	s3,s6,8
 764:	000b3903          	ld	s2,0(s6)
 768:	02090163          	beqz	s2,78a <vprintf+0x184>
 76c:	00094583          	lbu	a1,0(s2)
 770:	c9a1                	beqz	a1,7c0 <vprintf+0x1ba>
 772:	8556                	mv	a0,s5
 774:	00000097          	auipc	ra,0x0
 778:	dc6080e7          	jalr	-570(ra) # 53a <putc>
 77c:	0905                	addi	s2,s2,1
 77e:	00094583          	lbu	a1,0(s2)
 782:	f9e5                	bnez	a1,772 <vprintf+0x16c>
 784:	8b4e                	mv	s6,s3
 786:	4981                	li	s3,0
 788:	bdf9                	j	666 <vprintf+0x60>
 78a:	00000917          	auipc	s2,0x0
 78e:	27690913          	addi	s2,s2,630 # a00 <malloc+0x130>
 792:	02800593          	li	a1,40
 796:	bff1                	j	772 <vprintf+0x16c>
 798:	008b0913          	addi	s2,s6,8
 79c:	000b4583          	lbu	a1,0(s6)
 7a0:	8556                	mv	a0,s5
 7a2:	00000097          	auipc	ra,0x0
 7a6:	d98080e7          	jalr	-616(ra) # 53a <putc>
 7aa:	8b4a                	mv	s6,s2
 7ac:	4981                	li	s3,0
 7ae:	bd65                	j	666 <vprintf+0x60>
 7b0:	85d2                	mv	a1,s4
 7b2:	8556                	mv	a0,s5
 7b4:	00000097          	auipc	ra,0x0
 7b8:	d86080e7          	jalr	-634(ra) # 53a <putc>
 7bc:	4981                	li	s3,0
 7be:	b565                	j	666 <vprintf+0x60>
 7c0:	8b4e                	mv	s6,s3
 7c2:	4981                	li	s3,0
 7c4:	b54d                	j	666 <vprintf+0x60>
 7c6:	70e6                	ld	ra,120(sp)
 7c8:	7446                	ld	s0,112(sp)
 7ca:	74a6                	ld	s1,104(sp)
 7cc:	7906                	ld	s2,96(sp)
 7ce:	69e6                	ld	s3,88(sp)
 7d0:	6a46                	ld	s4,80(sp)
 7d2:	6aa6                	ld	s5,72(sp)
 7d4:	6b06                	ld	s6,64(sp)
 7d6:	7be2                	ld	s7,56(sp)
 7d8:	7c42                	ld	s8,48(sp)
 7da:	7ca2                	ld	s9,40(sp)
 7dc:	7d02                	ld	s10,32(sp)
 7de:	6de2                	ld	s11,24(sp)
 7e0:	6109                	addi	sp,sp,128
 7e2:	8082                	ret

00000000000007e4 <fprintf>:
 7e4:	715d                	addi	sp,sp,-80
 7e6:	ec06                	sd	ra,24(sp)
 7e8:	e822                	sd	s0,16(sp)
 7ea:	1000                	addi	s0,sp,32
 7ec:	e010                	sd	a2,0(s0)
 7ee:	e414                	sd	a3,8(s0)
 7f0:	e818                	sd	a4,16(s0)
 7f2:	ec1c                	sd	a5,24(s0)
 7f4:	03043023          	sd	a6,32(s0)
 7f8:	03143423          	sd	a7,40(s0)
 7fc:	fe843423          	sd	s0,-24(s0)
 800:	8622                	mv	a2,s0
 802:	00000097          	auipc	ra,0x0
 806:	e04080e7          	jalr	-508(ra) # 606 <vprintf>
 80a:	60e2                	ld	ra,24(sp)
 80c:	6442                	ld	s0,16(sp)
 80e:	6161                	addi	sp,sp,80
 810:	8082                	ret

0000000000000812 <printf>:
 812:	711d                	addi	sp,sp,-96
 814:	ec06                	sd	ra,24(sp)
 816:	e822                	sd	s0,16(sp)
 818:	1000                	addi	s0,sp,32
 81a:	e40c                	sd	a1,8(s0)
 81c:	e810                	sd	a2,16(s0)
 81e:	ec14                	sd	a3,24(s0)
 820:	f018                	sd	a4,32(s0)
 822:	f41c                	sd	a5,40(s0)
 824:	03043823          	sd	a6,48(s0)
 828:	03143c23          	sd	a7,56(s0)
 82c:	00840613          	addi	a2,s0,8
 830:	fec43423          	sd	a2,-24(s0)
 834:	85aa                	mv	a1,a0
 836:	4505                	li	a0,1
 838:	00000097          	auipc	ra,0x0
 83c:	dce080e7          	jalr	-562(ra) # 606 <vprintf>
 840:	60e2                	ld	ra,24(sp)
 842:	6442                	ld	s0,16(sp)
 844:	6125                	addi	sp,sp,96
 846:	8082                	ret

0000000000000848 <free>:
 848:	1141                	addi	sp,sp,-16
 84a:	e422                	sd	s0,8(sp)
 84c:	0800                	addi	s0,sp,16
 84e:	ff050693          	addi	a3,a0,-16
 852:	00000797          	auipc	a5,0x0
 856:	1ce7b783          	ld	a5,462(a5) # a20 <freep>
 85a:	a805                	j	88a <free+0x42>
 85c:	4618                	lw	a4,8(a2)
 85e:	9db9                	addw	a1,a1,a4
 860:	feb52c23          	sw	a1,-8(a0)
 864:	6398                	ld	a4,0(a5)
 866:	6318                	ld	a4,0(a4)
 868:	fee53823          	sd	a4,-16(a0)
 86c:	a091                	j	8b0 <free+0x68>
 86e:	ff852703          	lw	a4,-8(a0)
 872:	9e39                	addw	a2,a2,a4
 874:	c790                	sw	a2,8(a5)
 876:	ff053703          	ld	a4,-16(a0)
 87a:	e398                	sd	a4,0(a5)
 87c:	a099                	j	8c2 <free+0x7a>
 87e:	6398                	ld	a4,0(a5)
 880:	00e7e463          	bltu	a5,a4,888 <free+0x40>
 884:	00e6ea63          	bltu	a3,a4,898 <free+0x50>
 888:	87ba                	mv	a5,a4
 88a:	fed7fae3          	bgeu	a5,a3,87e <free+0x36>
 88e:	6398                	ld	a4,0(a5)
 890:	00e6e463          	bltu	a3,a4,898 <free+0x50>
 894:	fee7eae3          	bltu	a5,a4,888 <free+0x40>
 898:	ff852583          	lw	a1,-8(a0)
 89c:	6390                	ld	a2,0(a5)
 89e:	02059713          	slli	a4,a1,0x20
 8a2:	9301                	srli	a4,a4,0x20
 8a4:	0712                	slli	a4,a4,0x4
 8a6:	9736                	add	a4,a4,a3
 8a8:	fae60ae3          	beq	a2,a4,85c <free+0x14>
 8ac:	fec53823          	sd	a2,-16(a0)
 8b0:	4790                	lw	a2,8(a5)
 8b2:	02061713          	slli	a4,a2,0x20
 8b6:	9301                	srli	a4,a4,0x20
 8b8:	0712                	slli	a4,a4,0x4
 8ba:	973e                	add	a4,a4,a5
 8bc:	fae689e3          	beq	a3,a4,86e <free+0x26>
 8c0:	e394                	sd	a3,0(a5)
 8c2:	00000717          	auipc	a4,0x0
 8c6:	14f73f23          	sd	a5,350(a4) # a20 <freep>
 8ca:	6422                	ld	s0,8(sp)
 8cc:	0141                	addi	sp,sp,16
 8ce:	8082                	ret

00000000000008d0 <malloc>:
 8d0:	7139                	addi	sp,sp,-64
 8d2:	fc06                	sd	ra,56(sp)
 8d4:	f822                	sd	s0,48(sp)
 8d6:	f426                	sd	s1,40(sp)
 8d8:	f04a                	sd	s2,32(sp)
 8da:	ec4e                	sd	s3,24(sp)
 8dc:	e852                	sd	s4,16(sp)
 8de:	e456                	sd	s5,8(sp)
 8e0:	e05a                	sd	s6,0(sp)
 8e2:	0080                	addi	s0,sp,64
 8e4:	02051493          	slli	s1,a0,0x20
 8e8:	9081                	srli	s1,s1,0x20
 8ea:	04bd                	addi	s1,s1,15
 8ec:	8091                	srli	s1,s1,0x4
 8ee:	0014899b          	addiw	s3,s1,1
 8f2:	0485                	addi	s1,s1,1
 8f4:	00000517          	auipc	a0,0x0
 8f8:	12c53503          	ld	a0,300(a0) # a20 <freep>
 8fc:	c515                	beqz	a0,928 <malloc+0x58>
 8fe:	611c                	ld	a5,0(a0)
 900:	4798                	lw	a4,8(a5)
 902:	02977f63          	bgeu	a4,s1,940 <malloc+0x70>
 906:	8a4e                	mv	s4,s3
 908:	0009871b          	sext.w	a4,s3
 90c:	6685                	lui	a3,0x1
 90e:	00d77363          	bgeu	a4,a3,914 <malloc+0x44>
 912:	6a05                	lui	s4,0x1
 914:	000a0b1b          	sext.w	s6,s4
 918:	004a1a1b          	slliw	s4,s4,0x4
 91c:	00000917          	auipc	s2,0x0
 920:	10490913          	addi	s2,s2,260 # a20 <freep>
 924:	5afd                	li	s5,-1
 926:	a88d                	j	998 <malloc+0xc8>
 928:	00000797          	auipc	a5,0x0
 92c:	30078793          	addi	a5,a5,768 # c28 <base>
 930:	00000717          	auipc	a4,0x0
 934:	0ef73823          	sd	a5,240(a4) # a20 <freep>
 938:	e39c                	sd	a5,0(a5)
 93a:	0007a423          	sw	zero,8(a5)
 93e:	b7e1                	j	906 <malloc+0x36>
 940:	02e48b63          	beq	s1,a4,976 <malloc+0xa6>
 944:	4137073b          	subw	a4,a4,s3
 948:	c798                	sw	a4,8(a5)
 94a:	1702                	slli	a4,a4,0x20
 94c:	9301                	srli	a4,a4,0x20
 94e:	0712                	slli	a4,a4,0x4
 950:	97ba                	add	a5,a5,a4
 952:	0137a423          	sw	s3,8(a5)
 956:	00000717          	auipc	a4,0x0
 95a:	0ca73523          	sd	a0,202(a4) # a20 <freep>
 95e:	01078513          	addi	a0,a5,16
 962:	70e2                	ld	ra,56(sp)
 964:	7442                	ld	s0,48(sp)
 966:	74a2                	ld	s1,40(sp)
 968:	7902                	ld	s2,32(sp)
 96a:	69e2                	ld	s3,24(sp)
 96c:	6a42                	ld	s4,16(sp)
 96e:	6aa2                	ld	s5,8(sp)
 970:	6b02                	ld	s6,0(sp)
 972:	6121                	addi	sp,sp,64
 974:	8082                	ret
 976:	6398                	ld	a4,0(a5)
 978:	e118                	sd	a4,0(a0)
 97a:	bff1                	j	956 <malloc+0x86>
 97c:	01652423          	sw	s6,8(a0)
 980:	0541                	addi	a0,a0,16
 982:	00000097          	auipc	ra,0x0
 986:	ec6080e7          	jalr	-314(ra) # 848 <free>
 98a:	00093503          	ld	a0,0(s2)
 98e:	d971                	beqz	a0,962 <malloc+0x92>
 990:	611c                	ld	a5,0(a0)
 992:	4798                	lw	a4,8(a5)
 994:	fa9776e3          	bgeu	a4,s1,940 <malloc+0x70>
 998:	00093703          	ld	a4,0(s2)
 99c:	853e                	mv	a0,a5
 99e:	fef719e3          	bne	a4,a5,990 <malloc+0xc0>
 9a2:	8552                	mv	a0,s4
 9a4:	00000097          	auipc	ra,0x0
 9a8:	b7e080e7          	jalr	-1154(ra) # 522 <sbrk>
 9ac:	fd5518e3          	bne	a0,s5,97c <malloc+0xac>
 9b0:	4501                	li	a0,0
 9b2:	bf45                	j	962 <malloc+0x92>
