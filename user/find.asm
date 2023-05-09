
user/_find:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <fmtname>:
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char * path){
   0:	7179                	addi	sp,sp,-48
   2:	f406                	sd	ra,40(sp)
   4:	f022                	sd	s0,32(sp)
   6:	ec26                	sd	s1,24(sp)
   8:	e84a                	sd	s2,16(sp)
   a:	e44e                	sd	s3,8(sp)
   c:	1800                	addi	s0,sp,48
   e:	84aa                	mv	s1,a0
    static char buf[DIRSIZ+1];
    char *p;
    for(p = path+strlen(path); p >= path && *p != '/'; p--){
  10:	00000097          	auipc	ra,0x0
  14:	336080e7          	jalr	822(ra) # 346 <strlen>
  18:	02051793          	slli	a5,a0,0x20
  1c:	9381                	srli	a5,a5,0x20
  1e:	97a6                	add	a5,a5,s1
  20:	02f00693          	li	a3,47
  24:	0097e963          	bltu	a5,s1,36 <fmtname+0x36>
  28:	0007c703          	lbu	a4,0(a5)
  2c:	00d70563          	beq	a4,a3,36 <fmtname+0x36>
  30:	17fd                	addi	a5,a5,-1
  32:	fe97fbe3          	bgeu	a5,s1,28 <fmtname+0x28>
    }
    p++;
  36:	00178493          	addi	s1,a5,1
    if(strlen(p) >= DIRSIZ)
  3a:	8526                	mv	a0,s1
  3c:	00000097          	auipc	ra,0x0
  40:	30a080e7          	jalr	778(ra) # 346 <strlen>
  44:	2501                	sext.w	a0,a0
  46:	47b5                	li	a5,13
  48:	00a7fa63          	bgeu	a5,a0,5c <fmtname+0x5c>
        return p;
    memmove(buf, p, strlen(p));
    memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    return buf;
}
  4c:	8526                	mv	a0,s1
  4e:	70a2                	ld	ra,40(sp)
  50:	7402                	ld	s0,32(sp)
  52:	64e2                	ld	s1,24(sp)
  54:	6942                	ld	s2,16(sp)
  56:	69a2                	ld	s3,8(sp)
  58:	6145                	addi	sp,sp,48
  5a:	8082                	ret
    memmove(buf, p, strlen(p));
  5c:	8526                	mv	a0,s1
  5e:	00000097          	auipc	ra,0x0
  62:	2e8080e7          	jalr	744(ra) # 346 <strlen>
  66:	00001997          	auipc	s3,0x1
  6a:	ab298993          	addi	s3,s3,-1358 # b18 <buf.1107>
  6e:	0005061b          	sext.w	a2,a0
  72:	85a6                	mv	a1,s1
  74:	854e                	mv	a0,s3
  76:	00000097          	auipc	ra,0x0
  7a:	448080e7          	jalr	1096(ra) # 4be <memmove>
    memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  7e:	8526                	mv	a0,s1
  80:	00000097          	auipc	ra,0x0
  84:	2c6080e7          	jalr	710(ra) # 346 <strlen>
  88:	0005091b          	sext.w	s2,a0
  8c:	8526                	mv	a0,s1
  8e:	00000097          	auipc	ra,0x0
  92:	2b8080e7          	jalr	696(ra) # 346 <strlen>
  96:	1902                	slli	s2,s2,0x20
  98:	02095913          	srli	s2,s2,0x20
  9c:	4639                	li	a2,14
  9e:	9e09                	subw	a2,a2,a0
  a0:	02000593          	li	a1,32
  a4:	01298533          	add	a0,s3,s2
  a8:	00000097          	auipc	ra,0x0
  ac:	2c8080e7          	jalr	712(ra) # 370 <memset>
    return buf;
  b0:	84ce                	mv	s1,s3
  b2:	bf69                	j	4c <fmtname+0x4c>

00000000000000b4 <find>:

void
find(char * path, char * name){
  b4:	d8010113          	addi	sp,sp,-640
  b8:	26113c23          	sd	ra,632(sp)
  bc:	26813823          	sd	s0,624(sp)
  c0:	26913423          	sd	s1,616(sp)
  c4:	27213023          	sd	s2,608(sp)
  c8:	25313c23          	sd	s3,600(sp)
  cc:	25413823          	sd	s4,592(sp)
  d0:	25513423          	sd	s5,584(sp)
  d4:	25613023          	sd	s6,576(sp)
  d8:	23713c23          	sd	s7,568(sp)
  dc:	0500                	addi	s0,sp,640
  de:	892a                	mv	s2,a0
  e0:	89ae                	mv	s3,a1
    char buf[512], *p;
    int fd;
    struct stat st; 
    struct dirent de;
    if((fd = open(path, 0)) < 0){
  e2:	4581                	li	a1,0
  e4:	00000097          	auipc	ra,0x0
  e8:	4d0080e7          	jalr	1232(ra) # 5b4 <open>
  ec:	06054a63          	bltz	a0,160 <find+0xac>
  f0:	84aa                	mv	s1,a0
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if(fstat(fd, &st) < 0){
  f2:	d9840593          	addi	a1,s0,-616
  f6:	00000097          	auipc	ra,0x0
  fa:	4d6080e7          	jalr	1238(ra) # 5cc <fstat>
  fe:	06054c63          	bltz	a0,176 <find+0xc2>
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    switch(st.type){
 102:	da041783          	lh	a5,-608(s0)
 106:	0007869b          	sext.w	a3,a5
 10a:	4705                	li	a4,1
 10c:	08e68f63          	beq	a3,a4,1aa <find+0xf6>
 110:	4709                	li	a4,2
 112:	00e69d63          	bne	a3,a4,12c <find+0x78>
        case T_FILE:
            if(strcmp(fmtname(path), name) == 0){
 116:	854a                	mv	a0,s2
 118:	00000097          	auipc	ra,0x0
 11c:	ee8080e7          	jalr	-280(ra) # 0 <fmtname>
 120:	85ce                	mv	a1,s3
 122:	00000097          	auipc	ra,0x0
 126:	1f8080e7          	jalr	504(ra) # 31a <strcmp>
 12a:	c535                	beqz	a0,196 <find+0xe2>
                p[DIRSIZ] = 0;
                find(buf, name);
            }
            break;
    } 
    close(fd);
 12c:	8526                	mv	a0,s1
 12e:	00000097          	auipc	ra,0x0
 132:	46e080e7          	jalr	1134(ra) # 59c <close>
}
 136:	27813083          	ld	ra,632(sp)
 13a:	27013403          	ld	s0,624(sp)
 13e:	26813483          	ld	s1,616(sp)
 142:	26013903          	ld	s2,608(sp)
 146:	25813983          	ld	s3,600(sp)
 14a:	25013a03          	ld	s4,592(sp)
 14e:	24813a83          	ld	s5,584(sp)
 152:	24013b03          	ld	s6,576(sp)
 156:	23813b83          	ld	s7,568(sp)
 15a:	28010113          	addi	sp,sp,640
 15e:	8082                	ret
        fprintf(2, "find: cannot open %s\n", path);
 160:	864a                	mv	a2,s2
 162:	00001597          	auipc	a1,0x1
 166:	92e58593          	addi	a1,a1,-1746 # a90 <malloc+0xe6>
 16a:	4509                	li	a0,2
 16c:	00000097          	auipc	ra,0x0
 170:	752080e7          	jalr	1874(ra) # 8be <fprintf>
        return;
 174:	b7c9                	j	136 <find+0x82>
        fprintf(2, "find: cannot stat %s\n", path);
 176:	864a                	mv	a2,s2
 178:	00001597          	auipc	a1,0x1
 17c:	93058593          	addi	a1,a1,-1744 # aa8 <malloc+0xfe>
 180:	4509                	li	a0,2
 182:	00000097          	auipc	ra,0x0
 186:	73c080e7          	jalr	1852(ra) # 8be <fprintf>
        close(fd);
 18a:	8526                	mv	a0,s1
 18c:	00000097          	auipc	ra,0x0
 190:	410080e7          	jalr	1040(ra) # 59c <close>
        return;
 194:	b74d                	j	136 <find+0x82>
                printf("%s\n", path);
 196:	85ca                	mv	a1,s2
 198:	00001517          	auipc	a0,0x1
 19c:	92850513          	addi	a0,a0,-1752 # ac0 <malloc+0x116>
 1a0:	00000097          	auipc	ra,0x0
 1a4:	74c080e7          	jalr	1868(ra) # 8ec <printf>
 1a8:	b751                	j	12c <find+0x78>
            strcpy(buf, path);
 1aa:	85ca                	mv	a1,s2
 1ac:	db040513          	addi	a0,s0,-592
 1b0:	00000097          	auipc	ra,0x0
 1b4:	14e080e7          	jalr	334(ra) # 2fe <strcpy>
            p = buf + strlen(path);
 1b8:	854a                	mv	a0,s2
 1ba:	00000097          	auipc	ra,0x0
 1be:	18c080e7          	jalr	396(ra) # 346 <strlen>
 1c2:	02051913          	slli	s2,a0,0x20
 1c6:	02095913          	srli	s2,s2,0x20
 1ca:	db040793          	addi	a5,s0,-592
 1ce:	993e                	add	s2,s2,a5
            *p++ = '/';
 1d0:	00190b13          	addi	s6,s2,1
 1d4:	02f00793          	li	a5,47
 1d8:	00f90023          	sb	a5,0(s2)
                if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 1dc:	00001a97          	auipc	s5,0x1
 1e0:	8eca8a93          	addi	s5,s5,-1812 # ac8 <malloc+0x11e>
 1e4:	00001b97          	auipc	s7,0x1
 1e8:	8ecb8b93          	addi	s7,s7,-1812 # ad0 <malloc+0x126>
 1ec:	d8a40a13          	addi	s4,s0,-630
            while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f0:	4641                	li	a2,16
 1f2:	d8840593          	addi	a1,s0,-632
 1f6:	8526                	mv	a0,s1
 1f8:	00000097          	auipc	ra,0x0
 1fc:	394080e7          	jalr	916(ra) # 58c <read>
 200:	47c1                	li	a5,16
 202:	f2f515e3          	bne	a0,a5,12c <find+0x78>
                if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
 206:	d8845783          	lhu	a5,-632(s0)
 20a:	d3fd                	beqz	a5,1f0 <find+0x13c>
 20c:	85d6                	mv	a1,s5
 20e:	8552                	mv	a0,s4
 210:	00000097          	auipc	ra,0x0
 214:	10a080e7          	jalr	266(ra) # 31a <strcmp>
 218:	dd61                	beqz	a0,1f0 <find+0x13c>
 21a:	85de                	mv	a1,s7
 21c:	8552                	mv	a0,s4
 21e:	00000097          	auipc	ra,0x0
 222:	0fc080e7          	jalr	252(ra) # 31a <strcmp>
 226:	d569                	beqz	a0,1f0 <find+0x13c>
                memmove(p, de.name, DIRSIZ);
 228:	4639                	li	a2,14
 22a:	d8a40593          	addi	a1,s0,-630
 22e:	855a                	mv	a0,s6
 230:	00000097          	auipc	ra,0x0
 234:	28e080e7          	jalr	654(ra) # 4be <memmove>
                p[DIRSIZ] = 0;
 238:	000907a3          	sb	zero,15(s2)
                find(buf, name);
 23c:	85ce                	mv	a1,s3
 23e:	db040513          	addi	a0,s0,-592
 242:	00000097          	auipc	ra,0x0
 246:	e72080e7          	jalr	-398(ra) # b4 <find>
 24a:	b75d                	j	1f0 <find+0x13c>

000000000000024c <main>:

int main(int argc, char * argv[]){
 24c:	7139                	addi	sp,sp,-64
 24e:	fc06                	sd	ra,56(sp)
 250:	f822                	sd	s0,48(sp)
 252:	f426                	sd	s1,40(sp)
 254:	f04a                	sd	s2,32(sp)
 256:	ec4e                	sd	s3,24(sp)
 258:	0080                	addi	s0,sp,64
 25a:	84ae                	mv	s1,a1
    if(argc < 3){
 25c:	4789                	li	a5,2
 25e:	02a7c063          	blt	a5,a0,27e <main+0x32>
        find(".", argv[1]);
 262:	658c                	ld	a1,8(a1)
 264:	00001517          	auipc	a0,0x1
 268:	86450513          	addi	a0,a0,-1948 # ac8 <malloc+0x11e>
 26c:	00000097          	auipc	ra,0x0
 270:	e48080e7          	jalr	-440(ra) # b4 <find>
        exit(0);
 274:	4501                	li	a0,0
 276:	00000097          	auipc	ra,0x0
 27a:	2fe080e7          	jalr	766(ra) # 574 <exit>
 27e:	892a                	mv	s2,a0
    }
    char namebuf[14];
    strcpy(namebuf, argv[2]);
 280:	698c                	ld	a1,16(a1)
 282:	fc040513          	addi	a0,s0,-64
 286:	00000097          	auipc	ra,0x0
 28a:	078080e7          	jalr	120(ra) # 2fe <strcpy>
    memset(namebuf+strlen(argv[2]), ' ', DIRSIZ-strlen(argv[2]));
 28e:	6888                	ld	a0,16(s1)
 290:	00000097          	auipc	ra,0x0
 294:	0b6080e7          	jalr	182(ra) # 346 <strlen>
 298:	0005099b          	sext.w	s3,a0
 29c:	6888                	ld	a0,16(s1)
 29e:	00000097          	auipc	ra,0x0
 2a2:	0a8080e7          	jalr	168(ra) # 346 <strlen>
 2a6:	1982                	slli	s3,s3,0x20
 2a8:	0209d993          	srli	s3,s3,0x20
 2ac:	4639                	li	a2,14
 2ae:	9e09                	subw	a2,a2,a0
 2b0:	02000593          	li	a1,32
 2b4:	fc040793          	addi	a5,s0,-64
 2b8:	01378533          	add	a0,a5,s3
 2bc:	00000097          	auipc	ra,0x0
 2c0:	0b4080e7          	jalr	180(ra) # 370 <memset>
    if(argc == 3){
 2c4:	478d                	li	a5,3
 2c6:	02f90063          	beq	s2,a5,2e6 <main+0x9a>
        find(argv[1], namebuf);
        exit(0);
    }
    fprintf(2, "find: wrong arguments\n");
 2ca:	00001597          	auipc	a1,0x1
 2ce:	80e58593          	addi	a1,a1,-2034 # ad8 <malloc+0x12e>
 2d2:	4509                	li	a0,2
 2d4:	00000097          	auipc	ra,0x0
 2d8:	5ea080e7          	jalr	1514(ra) # 8be <fprintf>
    exit(0);
 2dc:	4501                	li	a0,0
 2de:	00000097          	auipc	ra,0x0
 2e2:	296080e7          	jalr	662(ra) # 574 <exit>
        find(argv[1], namebuf);
 2e6:	fc040593          	addi	a1,s0,-64
 2ea:	6488                	ld	a0,8(s1)
 2ec:	00000097          	auipc	ra,0x0
 2f0:	dc8080e7          	jalr	-568(ra) # b4 <find>
        exit(0);
 2f4:	4501                	li	a0,0
 2f6:	00000097          	auipc	ra,0x0
 2fa:	27e080e7          	jalr	638(ra) # 574 <exit>

00000000000002fe <strcpy>:
 2fe:	1141                	addi	sp,sp,-16
 300:	e422                	sd	s0,8(sp)
 302:	0800                	addi	s0,sp,16
 304:	87aa                	mv	a5,a0
 306:	0585                	addi	a1,a1,1
 308:	0785                	addi	a5,a5,1
 30a:	fff5c703          	lbu	a4,-1(a1)
 30e:	fee78fa3          	sb	a4,-1(a5)
 312:	fb75                	bnez	a4,306 <strcpy+0x8>
 314:	6422                	ld	s0,8(sp)
 316:	0141                	addi	sp,sp,16
 318:	8082                	ret

000000000000031a <strcmp>:
 31a:	1141                	addi	sp,sp,-16
 31c:	e422                	sd	s0,8(sp)
 31e:	0800                	addi	s0,sp,16
 320:	00054783          	lbu	a5,0(a0)
 324:	cb91                	beqz	a5,338 <strcmp+0x1e>
 326:	0005c703          	lbu	a4,0(a1)
 32a:	00f71763          	bne	a4,a5,338 <strcmp+0x1e>
 32e:	0505                	addi	a0,a0,1
 330:	0585                	addi	a1,a1,1
 332:	00054783          	lbu	a5,0(a0)
 336:	fbe5                	bnez	a5,326 <strcmp+0xc>
 338:	0005c503          	lbu	a0,0(a1)
 33c:	40a7853b          	subw	a0,a5,a0
 340:	6422                	ld	s0,8(sp)
 342:	0141                	addi	sp,sp,16
 344:	8082                	ret

0000000000000346 <strlen>:
 346:	1141                	addi	sp,sp,-16
 348:	e422                	sd	s0,8(sp)
 34a:	0800                	addi	s0,sp,16
 34c:	00054783          	lbu	a5,0(a0)
 350:	cf91                	beqz	a5,36c <strlen+0x26>
 352:	0505                	addi	a0,a0,1
 354:	87aa                	mv	a5,a0
 356:	4685                	li	a3,1
 358:	9e89                	subw	a3,a3,a0
 35a:	00f6853b          	addw	a0,a3,a5
 35e:	0785                	addi	a5,a5,1
 360:	fff7c703          	lbu	a4,-1(a5)
 364:	fb7d                	bnez	a4,35a <strlen+0x14>
 366:	6422                	ld	s0,8(sp)
 368:	0141                	addi	sp,sp,16
 36a:	8082                	ret
 36c:	4501                	li	a0,0
 36e:	bfe5                	j	366 <strlen+0x20>

0000000000000370 <memset>:
 370:	1141                	addi	sp,sp,-16
 372:	e422                	sd	s0,8(sp)
 374:	0800                	addi	s0,sp,16
 376:	ce09                	beqz	a2,390 <memset+0x20>
 378:	87aa                	mv	a5,a0
 37a:	fff6071b          	addiw	a4,a2,-1
 37e:	1702                	slli	a4,a4,0x20
 380:	9301                	srli	a4,a4,0x20
 382:	0705                	addi	a4,a4,1
 384:	972a                	add	a4,a4,a0
 386:	00b78023          	sb	a1,0(a5)
 38a:	0785                	addi	a5,a5,1
 38c:	fee79de3          	bne	a5,a4,386 <memset+0x16>
 390:	6422                	ld	s0,8(sp)
 392:	0141                	addi	sp,sp,16
 394:	8082                	ret

0000000000000396 <strchr>:
 396:	1141                	addi	sp,sp,-16
 398:	e422                	sd	s0,8(sp)
 39a:	0800                	addi	s0,sp,16
 39c:	00054783          	lbu	a5,0(a0)
 3a0:	cb99                	beqz	a5,3b6 <strchr+0x20>
 3a2:	00f58763          	beq	a1,a5,3b0 <strchr+0x1a>
 3a6:	0505                	addi	a0,a0,1
 3a8:	00054783          	lbu	a5,0(a0)
 3ac:	fbfd                	bnez	a5,3a2 <strchr+0xc>
 3ae:	4501                	li	a0,0
 3b0:	6422                	ld	s0,8(sp)
 3b2:	0141                	addi	sp,sp,16
 3b4:	8082                	ret
 3b6:	4501                	li	a0,0
 3b8:	bfe5                	j	3b0 <strchr+0x1a>

00000000000003ba <gets>:
 3ba:	711d                	addi	sp,sp,-96
 3bc:	ec86                	sd	ra,88(sp)
 3be:	e8a2                	sd	s0,80(sp)
 3c0:	e4a6                	sd	s1,72(sp)
 3c2:	e0ca                	sd	s2,64(sp)
 3c4:	fc4e                	sd	s3,56(sp)
 3c6:	f852                	sd	s4,48(sp)
 3c8:	f456                	sd	s5,40(sp)
 3ca:	f05a                	sd	s6,32(sp)
 3cc:	ec5e                	sd	s7,24(sp)
 3ce:	1080                	addi	s0,sp,96
 3d0:	8baa                	mv	s7,a0
 3d2:	8a2e                	mv	s4,a1
 3d4:	892a                	mv	s2,a0
 3d6:	4481                	li	s1,0
 3d8:	4aa9                	li	s5,10
 3da:	4b35                	li	s6,13
 3dc:	89a6                	mv	s3,s1
 3de:	2485                	addiw	s1,s1,1
 3e0:	0344d863          	bge	s1,s4,410 <gets+0x56>
 3e4:	4605                	li	a2,1
 3e6:	faf40593          	addi	a1,s0,-81
 3ea:	4501                	li	a0,0
 3ec:	00000097          	auipc	ra,0x0
 3f0:	1a0080e7          	jalr	416(ra) # 58c <read>
 3f4:	00a05e63          	blez	a0,410 <gets+0x56>
 3f8:	faf44783          	lbu	a5,-81(s0)
 3fc:	00f90023          	sb	a5,0(s2)
 400:	01578763          	beq	a5,s5,40e <gets+0x54>
 404:	0905                	addi	s2,s2,1
 406:	fd679be3          	bne	a5,s6,3dc <gets+0x22>
 40a:	89a6                	mv	s3,s1
 40c:	a011                	j	410 <gets+0x56>
 40e:	89a6                	mv	s3,s1
 410:	99de                	add	s3,s3,s7
 412:	00098023          	sb	zero,0(s3)
 416:	855e                	mv	a0,s7
 418:	60e6                	ld	ra,88(sp)
 41a:	6446                	ld	s0,80(sp)
 41c:	64a6                	ld	s1,72(sp)
 41e:	6906                	ld	s2,64(sp)
 420:	79e2                	ld	s3,56(sp)
 422:	7a42                	ld	s4,48(sp)
 424:	7aa2                	ld	s5,40(sp)
 426:	7b02                	ld	s6,32(sp)
 428:	6be2                	ld	s7,24(sp)
 42a:	6125                	addi	sp,sp,96
 42c:	8082                	ret

000000000000042e <stat>:
 42e:	1101                	addi	sp,sp,-32
 430:	ec06                	sd	ra,24(sp)
 432:	e822                	sd	s0,16(sp)
 434:	e426                	sd	s1,8(sp)
 436:	e04a                	sd	s2,0(sp)
 438:	1000                	addi	s0,sp,32
 43a:	892e                	mv	s2,a1
 43c:	4581                	li	a1,0
 43e:	00000097          	auipc	ra,0x0
 442:	176080e7          	jalr	374(ra) # 5b4 <open>
 446:	02054563          	bltz	a0,470 <stat+0x42>
 44a:	84aa                	mv	s1,a0
 44c:	85ca                	mv	a1,s2
 44e:	00000097          	auipc	ra,0x0
 452:	17e080e7          	jalr	382(ra) # 5cc <fstat>
 456:	892a                	mv	s2,a0
 458:	8526                	mv	a0,s1
 45a:	00000097          	auipc	ra,0x0
 45e:	142080e7          	jalr	322(ra) # 59c <close>
 462:	854a                	mv	a0,s2
 464:	60e2                	ld	ra,24(sp)
 466:	6442                	ld	s0,16(sp)
 468:	64a2                	ld	s1,8(sp)
 46a:	6902                	ld	s2,0(sp)
 46c:	6105                	addi	sp,sp,32
 46e:	8082                	ret
 470:	597d                	li	s2,-1
 472:	bfc5                	j	462 <stat+0x34>

0000000000000474 <atoi>:
 474:	1141                	addi	sp,sp,-16
 476:	e422                	sd	s0,8(sp)
 478:	0800                	addi	s0,sp,16
 47a:	00054603          	lbu	a2,0(a0)
 47e:	fd06079b          	addiw	a5,a2,-48
 482:	0ff7f793          	andi	a5,a5,255
 486:	4725                	li	a4,9
 488:	02f76963          	bltu	a4,a5,4ba <atoi+0x46>
 48c:	86aa                	mv	a3,a0
 48e:	4501                	li	a0,0
 490:	45a5                	li	a1,9
 492:	0685                	addi	a3,a3,1
 494:	0025179b          	slliw	a5,a0,0x2
 498:	9fa9                	addw	a5,a5,a0
 49a:	0017979b          	slliw	a5,a5,0x1
 49e:	9fb1                	addw	a5,a5,a2
 4a0:	fd07851b          	addiw	a0,a5,-48
 4a4:	0006c603          	lbu	a2,0(a3)
 4a8:	fd06071b          	addiw	a4,a2,-48
 4ac:	0ff77713          	andi	a4,a4,255
 4b0:	fee5f1e3          	bgeu	a1,a4,492 <atoi+0x1e>
 4b4:	6422                	ld	s0,8(sp)
 4b6:	0141                	addi	sp,sp,16
 4b8:	8082                	ret
 4ba:	4501                	li	a0,0
 4bc:	bfe5                	j	4b4 <atoi+0x40>

00000000000004be <memmove>:
 4be:	1141                	addi	sp,sp,-16
 4c0:	e422                	sd	s0,8(sp)
 4c2:	0800                	addi	s0,sp,16
 4c4:	02b57663          	bgeu	a0,a1,4f0 <memmove+0x32>
 4c8:	02c05163          	blez	a2,4ea <memmove+0x2c>
 4cc:	fff6079b          	addiw	a5,a2,-1
 4d0:	1782                	slli	a5,a5,0x20
 4d2:	9381                	srli	a5,a5,0x20
 4d4:	0785                	addi	a5,a5,1
 4d6:	97aa                	add	a5,a5,a0
 4d8:	872a                	mv	a4,a0
 4da:	0585                	addi	a1,a1,1
 4dc:	0705                	addi	a4,a4,1
 4de:	fff5c683          	lbu	a3,-1(a1)
 4e2:	fed70fa3          	sb	a3,-1(a4)
 4e6:	fee79ae3          	bne	a5,a4,4da <memmove+0x1c>
 4ea:	6422                	ld	s0,8(sp)
 4ec:	0141                	addi	sp,sp,16
 4ee:	8082                	ret
 4f0:	00c50733          	add	a4,a0,a2
 4f4:	95b2                	add	a1,a1,a2
 4f6:	fec05ae3          	blez	a2,4ea <memmove+0x2c>
 4fa:	fff6079b          	addiw	a5,a2,-1
 4fe:	1782                	slli	a5,a5,0x20
 500:	9381                	srli	a5,a5,0x20
 502:	fff7c793          	not	a5,a5
 506:	97ba                	add	a5,a5,a4
 508:	15fd                	addi	a1,a1,-1
 50a:	177d                	addi	a4,a4,-1
 50c:	0005c683          	lbu	a3,0(a1)
 510:	00d70023          	sb	a3,0(a4)
 514:	fee79ae3          	bne	a5,a4,508 <memmove+0x4a>
 518:	bfc9                	j	4ea <memmove+0x2c>

000000000000051a <memcmp>:
 51a:	1141                	addi	sp,sp,-16
 51c:	e422                	sd	s0,8(sp)
 51e:	0800                	addi	s0,sp,16
 520:	ca05                	beqz	a2,550 <memcmp+0x36>
 522:	fff6069b          	addiw	a3,a2,-1
 526:	1682                	slli	a3,a3,0x20
 528:	9281                	srli	a3,a3,0x20
 52a:	0685                	addi	a3,a3,1
 52c:	96aa                	add	a3,a3,a0
 52e:	00054783          	lbu	a5,0(a0)
 532:	0005c703          	lbu	a4,0(a1)
 536:	00e79863          	bne	a5,a4,546 <memcmp+0x2c>
 53a:	0505                	addi	a0,a0,1
 53c:	0585                	addi	a1,a1,1
 53e:	fed518e3          	bne	a0,a3,52e <memcmp+0x14>
 542:	4501                	li	a0,0
 544:	a019                	j	54a <memcmp+0x30>
 546:	40e7853b          	subw	a0,a5,a4
 54a:	6422                	ld	s0,8(sp)
 54c:	0141                	addi	sp,sp,16
 54e:	8082                	ret
 550:	4501                	li	a0,0
 552:	bfe5                	j	54a <memcmp+0x30>

0000000000000554 <memcpy>:
 554:	1141                	addi	sp,sp,-16
 556:	e406                	sd	ra,8(sp)
 558:	e022                	sd	s0,0(sp)
 55a:	0800                	addi	s0,sp,16
 55c:	00000097          	auipc	ra,0x0
 560:	f62080e7          	jalr	-158(ra) # 4be <memmove>
 564:	60a2                	ld	ra,8(sp)
 566:	6402                	ld	s0,0(sp)
 568:	0141                	addi	sp,sp,16
 56a:	8082                	ret

000000000000056c <fork>:
 56c:	4885                	li	a7,1
 56e:	00000073          	ecall
 572:	8082                	ret

0000000000000574 <exit>:
 574:	4889                	li	a7,2
 576:	00000073          	ecall
 57a:	8082                	ret

000000000000057c <wait>:
 57c:	488d                	li	a7,3
 57e:	00000073          	ecall
 582:	8082                	ret

0000000000000584 <pipe>:
 584:	4891                	li	a7,4
 586:	00000073          	ecall
 58a:	8082                	ret

000000000000058c <read>:
 58c:	4895                	li	a7,5
 58e:	00000073          	ecall
 592:	8082                	ret

0000000000000594 <write>:
 594:	48c1                	li	a7,16
 596:	00000073          	ecall
 59a:	8082                	ret

000000000000059c <close>:
 59c:	48d5                	li	a7,21
 59e:	00000073          	ecall
 5a2:	8082                	ret

00000000000005a4 <kill>:
 5a4:	4899                	li	a7,6
 5a6:	00000073          	ecall
 5aa:	8082                	ret

00000000000005ac <exec>:
 5ac:	489d                	li	a7,7
 5ae:	00000073          	ecall
 5b2:	8082                	ret

00000000000005b4 <open>:
 5b4:	48bd                	li	a7,15
 5b6:	00000073          	ecall
 5ba:	8082                	ret

00000000000005bc <mknod>:
 5bc:	48c5                	li	a7,17
 5be:	00000073          	ecall
 5c2:	8082                	ret

00000000000005c4 <unlink>:
 5c4:	48c9                	li	a7,18
 5c6:	00000073          	ecall
 5ca:	8082                	ret

00000000000005cc <fstat>:
 5cc:	48a1                	li	a7,8
 5ce:	00000073          	ecall
 5d2:	8082                	ret

00000000000005d4 <link>:
 5d4:	48cd                	li	a7,19
 5d6:	00000073          	ecall
 5da:	8082                	ret

00000000000005dc <mkdir>:
 5dc:	48d1                	li	a7,20
 5de:	00000073          	ecall
 5e2:	8082                	ret

00000000000005e4 <chdir>:
 5e4:	48a5                	li	a7,9
 5e6:	00000073          	ecall
 5ea:	8082                	ret

00000000000005ec <dup>:
 5ec:	48a9                	li	a7,10
 5ee:	00000073          	ecall
 5f2:	8082                	ret

00000000000005f4 <getpid>:
 5f4:	48ad                	li	a7,11
 5f6:	00000073          	ecall
 5fa:	8082                	ret

00000000000005fc <sbrk>:
 5fc:	48b1                	li	a7,12
 5fe:	00000073          	ecall
 602:	8082                	ret

0000000000000604 <sleep>:
 604:	48b5                	li	a7,13
 606:	00000073          	ecall
 60a:	8082                	ret

000000000000060c <uptime>:
 60c:	48b9                	li	a7,14
 60e:	00000073          	ecall
 612:	8082                	ret

0000000000000614 <putc>:
 614:	1101                	addi	sp,sp,-32
 616:	ec06                	sd	ra,24(sp)
 618:	e822                	sd	s0,16(sp)
 61a:	1000                	addi	s0,sp,32
 61c:	feb407a3          	sb	a1,-17(s0)
 620:	4605                	li	a2,1
 622:	fef40593          	addi	a1,s0,-17
 626:	00000097          	auipc	ra,0x0
 62a:	f6e080e7          	jalr	-146(ra) # 594 <write>
 62e:	60e2                	ld	ra,24(sp)
 630:	6442                	ld	s0,16(sp)
 632:	6105                	addi	sp,sp,32
 634:	8082                	ret

0000000000000636 <printint>:
 636:	7139                	addi	sp,sp,-64
 638:	fc06                	sd	ra,56(sp)
 63a:	f822                	sd	s0,48(sp)
 63c:	f426                	sd	s1,40(sp)
 63e:	f04a                	sd	s2,32(sp)
 640:	ec4e                	sd	s3,24(sp)
 642:	0080                	addi	s0,sp,64
 644:	84aa                	mv	s1,a0
 646:	c299                	beqz	a3,64c <printint+0x16>
 648:	0805c863          	bltz	a1,6d8 <printint+0xa2>
 64c:	2581                	sext.w	a1,a1
 64e:	4881                	li	a7,0
 650:	fc040693          	addi	a3,s0,-64
 654:	4701                	li	a4,0
 656:	2601                	sext.w	a2,a2
 658:	00000517          	auipc	a0,0x0
 65c:	4a050513          	addi	a0,a0,1184 # af8 <digits>
 660:	883a                	mv	a6,a4
 662:	2705                	addiw	a4,a4,1
 664:	02c5f7bb          	remuw	a5,a1,a2
 668:	1782                	slli	a5,a5,0x20
 66a:	9381                	srli	a5,a5,0x20
 66c:	97aa                	add	a5,a5,a0
 66e:	0007c783          	lbu	a5,0(a5)
 672:	00f68023          	sb	a5,0(a3)
 676:	0005879b          	sext.w	a5,a1
 67a:	02c5d5bb          	divuw	a1,a1,a2
 67e:	0685                	addi	a3,a3,1
 680:	fec7f0e3          	bgeu	a5,a2,660 <printint+0x2a>
 684:	00088b63          	beqz	a7,69a <printint+0x64>
 688:	fd040793          	addi	a5,s0,-48
 68c:	973e                	add	a4,a4,a5
 68e:	02d00793          	li	a5,45
 692:	fef70823          	sb	a5,-16(a4)
 696:	0028071b          	addiw	a4,a6,2
 69a:	02e05863          	blez	a4,6ca <printint+0x94>
 69e:	fc040793          	addi	a5,s0,-64
 6a2:	00e78933          	add	s2,a5,a4
 6a6:	fff78993          	addi	s3,a5,-1
 6aa:	99ba                	add	s3,s3,a4
 6ac:	377d                	addiw	a4,a4,-1
 6ae:	1702                	slli	a4,a4,0x20
 6b0:	9301                	srli	a4,a4,0x20
 6b2:	40e989b3          	sub	s3,s3,a4
 6b6:	fff94583          	lbu	a1,-1(s2)
 6ba:	8526                	mv	a0,s1
 6bc:	00000097          	auipc	ra,0x0
 6c0:	f58080e7          	jalr	-168(ra) # 614 <putc>
 6c4:	197d                	addi	s2,s2,-1
 6c6:	ff3918e3          	bne	s2,s3,6b6 <printint+0x80>
 6ca:	70e2                	ld	ra,56(sp)
 6cc:	7442                	ld	s0,48(sp)
 6ce:	74a2                	ld	s1,40(sp)
 6d0:	7902                	ld	s2,32(sp)
 6d2:	69e2                	ld	s3,24(sp)
 6d4:	6121                	addi	sp,sp,64
 6d6:	8082                	ret
 6d8:	40b005bb          	negw	a1,a1
 6dc:	4885                	li	a7,1
 6de:	bf8d                	j	650 <printint+0x1a>

00000000000006e0 <vprintf>:
 6e0:	7119                	addi	sp,sp,-128
 6e2:	fc86                	sd	ra,120(sp)
 6e4:	f8a2                	sd	s0,112(sp)
 6e6:	f4a6                	sd	s1,104(sp)
 6e8:	f0ca                	sd	s2,96(sp)
 6ea:	ecce                	sd	s3,88(sp)
 6ec:	e8d2                	sd	s4,80(sp)
 6ee:	e4d6                	sd	s5,72(sp)
 6f0:	e0da                	sd	s6,64(sp)
 6f2:	fc5e                	sd	s7,56(sp)
 6f4:	f862                	sd	s8,48(sp)
 6f6:	f466                	sd	s9,40(sp)
 6f8:	f06a                	sd	s10,32(sp)
 6fa:	ec6e                	sd	s11,24(sp)
 6fc:	0100                	addi	s0,sp,128
 6fe:	0005c903          	lbu	s2,0(a1)
 702:	18090f63          	beqz	s2,8a0 <vprintf+0x1c0>
 706:	8aaa                	mv	s5,a0
 708:	8b32                	mv	s6,a2
 70a:	00158493          	addi	s1,a1,1
 70e:	4981                	li	s3,0
 710:	02500a13          	li	s4,37
 714:	06400c13          	li	s8,100
 718:	06c00c93          	li	s9,108
 71c:	07800d13          	li	s10,120
 720:	07000d93          	li	s11,112
 724:	00000b97          	auipc	s7,0x0
 728:	3d4b8b93          	addi	s7,s7,980 # af8 <digits>
 72c:	a839                	j	74a <vprintf+0x6a>
 72e:	85ca                	mv	a1,s2
 730:	8556                	mv	a0,s5
 732:	00000097          	auipc	ra,0x0
 736:	ee2080e7          	jalr	-286(ra) # 614 <putc>
 73a:	a019                	j	740 <vprintf+0x60>
 73c:	01498f63          	beq	s3,s4,75a <vprintf+0x7a>
 740:	0485                	addi	s1,s1,1
 742:	fff4c903          	lbu	s2,-1(s1)
 746:	14090d63          	beqz	s2,8a0 <vprintf+0x1c0>
 74a:	0009079b          	sext.w	a5,s2
 74e:	fe0997e3          	bnez	s3,73c <vprintf+0x5c>
 752:	fd479ee3          	bne	a5,s4,72e <vprintf+0x4e>
 756:	89be                	mv	s3,a5
 758:	b7e5                	j	740 <vprintf+0x60>
 75a:	05878063          	beq	a5,s8,79a <vprintf+0xba>
 75e:	05978c63          	beq	a5,s9,7b6 <vprintf+0xd6>
 762:	07a78863          	beq	a5,s10,7d2 <vprintf+0xf2>
 766:	09b78463          	beq	a5,s11,7ee <vprintf+0x10e>
 76a:	07300713          	li	a4,115
 76e:	0ce78663          	beq	a5,a4,83a <vprintf+0x15a>
 772:	06300713          	li	a4,99
 776:	0ee78e63          	beq	a5,a4,872 <vprintf+0x192>
 77a:	11478863          	beq	a5,s4,88a <vprintf+0x1aa>
 77e:	85d2                	mv	a1,s4
 780:	8556                	mv	a0,s5
 782:	00000097          	auipc	ra,0x0
 786:	e92080e7          	jalr	-366(ra) # 614 <putc>
 78a:	85ca                	mv	a1,s2
 78c:	8556                	mv	a0,s5
 78e:	00000097          	auipc	ra,0x0
 792:	e86080e7          	jalr	-378(ra) # 614 <putc>
 796:	4981                	li	s3,0
 798:	b765                	j	740 <vprintf+0x60>
 79a:	008b0913          	addi	s2,s6,8
 79e:	4685                	li	a3,1
 7a0:	4629                	li	a2,10
 7a2:	000b2583          	lw	a1,0(s6)
 7a6:	8556                	mv	a0,s5
 7a8:	00000097          	auipc	ra,0x0
 7ac:	e8e080e7          	jalr	-370(ra) # 636 <printint>
 7b0:	8b4a                	mv	s6,s2
 7b2:	4981                	li	s3,0
 7b4:	b771                	j	740 <vprintf+0x60>
 7b6:	008b0913          	addi	s2,s6,8
 7ba:	4681                	li	a3,0
 7bc:	4629                	li	a2,10
 7be:	000b2583          	lw	a1,0(s6)
 7c2:	8556                	mv	a0,s5
 7c4:	00000097          	auipc	ra,0x0
 7c8:	e72080e7          	jalr	-398(ra) # 636 <printint>
 7cc:	8b4a                	mv	s6,s2
 7ce:	4981                	li	s3,0
 7d0:	bf85                	j	740 <vprintf+0x60>
 7d2:	008b0913          	addi	s2,s6,8
 7d6:	4681                	li	a3,0
 7d8:	4641                	li	a2,16
 7da:	000b2583          	lw	a1,0(s6)
 7de:	8556                	mv	a0,s5
 7e0:	00000097          	auipc	ra,0x0
 7e4:	e56080e7          	jalr	-426(ra) # 636 <printint>
 7e8:	8b4a                	mv	s6,s2
 7ea:	4981                	li	s3,0
 7ec:	bf91                	j	740 <vprintf+0x60>
 7ee:	008b0793          	addi	a5,s6,8
 7f2:	f8f43423          	sd	a5,-120(s0)
 7f6:	000b3983          	ld	s3,0(s6)
 7fa:	03000593          	li	a1,48
 7fe:	8556                	mv	a0,s5
 800:	00000097          	auipc	ra,0x0
 804:	e14080e7          	jalr	-492(ra) # 614 <putc>
 808:	85ea                	mv	a1,s10
 80a:	8556                	mv	a0,s5
 80c:	00000097          	auipc	ra,0x0
 810:	e08080e7          	jalr	-504(ra) # 614 <putc>
 814:	4941                	li	s2,16
 816:	03c9d793          	srli	a5,s3,0x3c
 81a:	97de                	add	a5,a5,s7
 81c:	0007c583          	lbu	a1,0(a5)
 820:	8556                	mv	a0,s5
 822:	00000097          	auipc	ra,0x0
 826:	df2080e7          	jalr	-526(ra) # 614 <putc>
 82a:	0992                	slli	s3,s3,0x4
 82c:	397d                	addiw	s2,s2,-1
 82e:	fe0914e3          	bnez	s2,816 <vprintf+0x136>
 832:	f8843b03          	ld	s6,-120(s0)
 836:	4981                	li	s3,0
 838:	b721                	j	740 <vprintf+0x60>
 83a:	008b0993          	addi	s3,s6,8
 83e:	000b3903          	ld	s2,0(s6)
 842:	02090163          	beqz	s2,864 <vprintf+0x184>
 846:	00094583          	lbu	a1,0(s2)
 84a:	c9a1                	beqz	a1,89a <vprintf+0x1ba>
 84c:	8556                	mv	a0,s5
 84e:	00000097          	auipc	ra,0x0
 852:	dc6080e7          	jalr	-570(ra) # 614 <putc>
 856:	0905                	addi	s2,s2,1
 858:	00094583          	lbu	a1,0(s2)
 85c:	f9e5                	bnez	a1,84c <vprintf+0x16c>
 85e:	8b4e                	mv	s6,s3
 860:	4981                	li	s3,0
 862:	bdf9                	j	740 <vprintf+0x60>
 864:	00000917          	auipc	s2,0x0
 868:	28c90913          	addi	s2,s2,652 # af0 <malloc+0x146>
 86c:	02800593          	li	a1,40
 870:	bff1                	j	84c <vprintf+0x16c>
 872:	008b0913          	addi	s2,s6,8
 876:	000b4583          	lbu	a1,0(s6)
 87a:	8556                	mv	a0,s5
 87c:	00000097          	auipc	ra,0x0
 880:	d98080e7          	jalr	-616(ra) # 614 <putc>
 884:	8b4a                	mv	s6,s2
 886:	4981                	li	s3,0
 888:	bd65                	j	740 <vprintf+0x60>
 88a:	85d2                	mv	a1,s4
 88c:	8556                	mv	a0,s5
 88e:	00000097          	auipc	ra,0x0
 892:	d86080e7          	jalr	-634(ra) # 614 <putc>
 896:	4981                	li	s3,0
 898:	b565                	j	740 <vprintf+0x60>
 89a:	8b4e                	mv	s6,s3
 89c:	4981                	li	s3,0
 89e:	b54d                	j	740 <vprintf+0x60>
 8a0:	70e6                	ld	ra,120(sp)
 8a2:	7446                	ld	s0,112(sp)
 8a4:	74a6                	ld	s1,104(sp)
 8a6:	7906                	ld	s2,96(sp)
 8a8:	69e6                	ld	s3,88(sp)
 8aa:	6a46                	ld	s4,80(sp)
 8ac:	6aa6                	ld	s5,72(sp)
 8ae:	6b06                	ld	s6,64(sp)
 8b0:	7be2                	ld	s7,56(sp)
 8b2:	7c42                	ld	s8,48(sp)
 8b4:	7ca2                	ld	s9,40(sp)
 8b6:	7d02                	ld	s10,32(sp)
 8b8:	6de2                	ld	s11,24(sp)
 8ba:	6109                	addi	sp,sp,128
 8bc:	8082                	ret

00000000000008be <fprintf>:
 8be:	715d                	addi	sp,sp,-80
 8c0:	ec06                	sd	ra,24(sp)
 8c2:	e822                	sd	s0,16(sp)
 8c4:	1000                	addi	s0,sp,32
 8c6:	e010                	sd	a2,0(s0)
 8c8:	e414                	sd	a3,8(s0)
 8ca:	e818                	sd	a4,16(s0)
 8cc:	ec1c                	sd	a5,24(s0)
 8ce:	03043023          	sd	a6,32(s0)
 8d2:	03143423          	sd	a7,40(s0)
 8d6:	fe843423          	sd	s0,-24(s0)
 8da:	8622                	mv	a2,s0
 8dc:	00000097          	auipc	ra,0x0
 8e0:	e04080e7          	jalr	-508(ra) # 6e0 <vprintf>
 8e4:	60e2                	ld	ra,24(sp)
 8e6:	6442                	ld	s0,16(sp)
 8e8:	6161                	addi	sp,sp,80
 8ea:	8082                	ret

00000000000008ec <printf>:
 8ec:	711d                	addi	sp,sp,-96
 8ee:	ec06                	sd	ra,24(sp)
 8f0:	e822                	sd	s0,16(sp)
 8f2:	1000                	addi	s0,sp,32
 8f4:	e40c                	sd	a1,8(s0)
 8f6:	e810                	sd	a2,16(s0)
 8f8:	ec14                	sd	a3,24(s0)
 8fa:	f018                	sd	a4,32(s0)
 8fc:	f41c                	sd	a5,40(s0)
 8fe:	03043823          	sd	a6,48(s0)
 902:	03143c23          	sd	a7,56(s0)
 906:	00840613          	addi	a2,s0,8
 90a:	fec43423          	sd	a2,-24(s0)
 90e:	85aa                	mv	a1,a0
 910:	4505                	li	a0,1
 912:	00000097          	auipc	ra,0x0
 916:	dce080e7          	jalr	-562(ra) # 6e0 <vprintf>
 91a:	60e2                	ld	ra,24(sp)
 91c:	6442                	ld	s0,16(sp)
 91e:	6125                	addi	sp,sp,96
 920:	8082                	ret

0000000000000922 <free>:
 922:	1141                	addi	sp,sp,-16
 924:	e422                	sd	s0,8(sp)
 926:	0800                	addi	s0,sp,16
 928:	ff050693          	addi	a3,a0,-16
 92c:	00000797          	auipc	a5,0x0
 930:	1e47b783          	ld	a5,484(a5) # b10 <freep>
 934:	a805                	j	964 <free+0x42>
 936:	4618                	lw	a4,8(a2)
 938:	9db9                	addw	a1,a1,a4
 93a:	feb52c23          	sw	a1,-8(a0)
 93e:	6398                	ld	a4,0(a5)
 940:	6318                	ld	a4,0(a4)
 942:	fee53823          	sd	a4,-16(a0)
 946:	a091                	j	98a <free+0x68>
 948:	ff852703          	lw	a4,-8(a0)
 94c:	9e39                	addw	a2,a2,a4
 94e:	c790                	sw	a2,8(a5)
 950:	ff053703          	ld	a4,-16(a0)
 954:	e398                	sd	a4,0(a5)
 956:	a099                	j	99c <free+0x7a>
 958:	6398                	ld	a4,0(a5)
 95a:	00e7e463          	bltu	a5,a4,962 <free+0x40>
 95e:	00e6ea63          	bltu	a3,a4,972 <free+0x50>
 962:	87ba                	mv	a5,a4
 964:	fed7fae3          	bgeu	a5,a3,958 <free+0x36>
 968:	6398                	ld	a4,0(a5)
 96a:	00e6e463          	bltu	a3,a4,972 <free+0x50>
 96e:	fee7eae3          	bltu	a5,a4,962 <free+0x40>
 972:	ff852583          	lw	a1,-8(a0)
 976:	6390                	ld	a2,0(a5)
 978:	02059713          	slli	a4,a1,0x20
 97c:	9301                	srli	a4,a4,0x20
 97e:	0712                	slli	a4,a4,0x4
 980:	9736                	add	a4,a4,a3
 982:	fae60ae3          	beq	a2,a4,936 <free+0x14>
 986:	fec53823          	sd	a2,-16(a0)
 98a:	4790                	lw	a2,8(a5)
 98c:	02061713          	slli	a4,a2,0x20
 990:	9301                	srli	a4,a4,0x20
 992:	0712                	slli	a4,a4,0x4
 994:	973e                	add	a4,a4,a5
 996:	fae689e3          	beq	a3,a4,948 <free+0x26>
 99a:	e394                	sd	a3,0(a5)
 99c:	00000717          	auipc	a4,0x0
 9a0:	16f73a23          	sd	a5,372(a4) # b10 <freep>
 9a4:	6422                	ld	s0,8(sp)
 9a6:	0141                	addi	sp,sp,16
 9a8:	8082                	ret

00000000000009aa <malloc>:
 9aa:	7139                	addi	sp,sp,-64
 9ac:	fc06                	sd	ra,56(sp)
 9ae:	f822                	sd	s0,48(sp)
 9b0:	f426                	sd	s1,40(sp)
 9b2:	f04a                	sd	s2,32(sp)
 9b4:	ec4e                	sd	s3,24(sp)
 9b6:	e852                	sd	s4,16(sp)
 9b8:	e456                	sd	s5,8(sp)
 9ba:	e05a                	sd	s6,0(sp)
 9bc:	0080                	addi	s0,sp,64
 9be:	02051493          	slli	s1,a0,0x20
 9c2:	9081                	srli	s1,s1,0x20
 9c4:	04bd                	addi	s1,s1,15
 9c6:	8091                	srli	s1,s1,0x4
 9c8:	0014899b          	addiw	s3,s1,1
 9cc:	0485                	addi	s1,s1,1
 9ce:	00000517          	auipc	a0,0x0
 9d2:	14253503          	ld	a0,322(a0) # b10 <freep>
 9d6:	c515                	beqz	a0,a02 <malloc+0x58>
 9d8:	611c                	ld	a5,0(a0)
 9da:	4798                	lw	a4,8(a5)
 9dc:	02977f63          	bgeu	a4,s1,a1a <malloc+0x70>
 9e0:	8a4e                	mv	s4,s3
 9e2:	0009871b          	sext.w	a4,s3
 9e6:	6685                	lui	a3,0x1
 9e8:	00d77363          	bgeu	a4,a3,9ee <malloc+0x44>
 9ec:	6a05                	lui	s4,0x1
 9ee:	000a0b1b          	sext.w	s6,s4
 9f2:	004a1a1b          	slliw	s4,s4,0x4
 9f6:	00000917          	auipc	s2,0x0
 9fa:	11a90913          	addi	s2,s2,282 # b10 <freep>
 9fe:	5afd                	li	s5,-1
 a00:	a88d                	j	a72 <malloc+0xc8>
 a02:	00000797          	auipc	a5,0x0
 a06:	12678793          	addi	a5,a5,294 # b28 <base>
 a0a:	00000717          	auipc	a4,0x0
 a0e:	10f73323          	sd	a5,262(a4) # b10 <freep>
 a12:	e39c                	sd	a5,0(a5)
 a14:	0007a423          	sw	zero,8(a5)
 a18:	b7e1                	j	9e0 <malloc+0x36>
 a1a:	02e48b63          	beq	s1,a4,a50 <malloc+0xa6>
 a1e:	4137073b          	subw	a4,a4,s3
 a22:	c798                	sw	a4,8(a5)
 a24:	1702                	slli	a4,a4,0x20
 a26:	9301                	srli	a4,a4,0x20
 a28:	0712                	slli	a4,a4,0x4
 a2a:	97ba                	add	a5,a5,a4
 a2c:	0137a423          	sw	s3,8(a5)
 a30:	00000717          	auipc	a4,0x0
 a34:	0ea73023          	sd	a0,224(a4) # b10 <freep>
 a38:	01078513          	addi	a0,a5,16
 a3c:	70e2                	ld	ra,56(sp)
 a3e:	7442                	ld	s0,48(sp)
 a40:	74a2                	ld	s1,40(sp)
 a42:	7902                	ld	s2,32(sp)
 a44:	69e2                	ld	s3,24(sp)
 a46:	6a42                	ld	s4,16(sp)
 a48:	6aa2                	ld	s5,8(sp)
 a4a:	6b02                	ld	s6,0(sp)
 a4c:	6121                	addi	sp,sp,64
 a4e:	8082                	ret
 a50:	6398                	ld	a4,0(a5)
 a52:	e118                	sd	a4,0(a0)
 a54:	bff1                	j	a30 <malloc+0x86>
 a56:	01652423          	sw	s6,8(a0)
 a5a:	0541                	addi	a0,a0,16
 a5c:	00000097          	auipc	ra,0x0
 a60:	ec6080e7          	jalr	-314(ra) # 922 <free>
 a64:	00093503          	ld	a0,0(s2)
 a68:	d971                	beqz	a0,a3c <malloc+0x92>
 a6a:	611c                	ld	a5,0(a0)
 a6c:	4798                	lw	a4,8(a5)
 a6e:	fa9776e3          	bgeu	a4,s1,a1a <malloc+0x70>
 a72:	00093703          	ld	a4,0(s2)
 a76:	853e                	mv	a0,a5
 a78:	fef719e3          	bne	a4,a5,a6a <malloc+0xc0>
 a7c:	8552                	mv	a0,s4
 a7e:	00000097          	auipc	ra,0x0
 a82:	b7e080e7          	jalr	-1154(ra) # 5fc <sbrk>
 a86:	fd5518e3          	bne	a0,s5,a56 <malloc+0xac>
 a8a:	4501                	li	a0,0
 a8c:	bf45                	j	a3c <malloc+0x92>
