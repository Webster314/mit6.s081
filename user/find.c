
#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"
#include "kernel/fs.h"

char*
fmtname(char * path){
    static char buf[DIRSIZ+1];
    char *p;
    for(p = path+strlen(path); p >= path && *p != '/'; p--){
    }
    p++;
    if(strlen(p) >= DIRSIZ)
        return p;
    memmove(buf, p, strlen(p));
    memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
    return buf;
}

void
find(char * path, char * name){
    char buf[512], *p;
    int fd;
    struct stat st; 
    struct dirent de;
    if((fd = open(path, 0)) < 0){
        fprintf(2, "find: cannot open %s\n", path);
        return;
    }
    if(fstat(fd, &st) < 0){
        fprintf(2, "find: cannot stat %s\n", path);
        close(fd);
        return;
    }
    switch(st.type){
        case T_FILE:
            if(strcmp(fmtname(path), name) == 0){
                printf("%s\n", path);
            }
            break;
        case T_DIR:
            strcpy(buf, path);
            p = buf + strlen(path);
            *p++ = '/';
            while(read(fd, &de, sizeof(de)) == sizeof(de)){
                if(de.inum == 0 || strcmp(de.name, ".") == 0 || strcmp(de.name, "..") == 0)
                    continue;
                memmove(p, de.name, DIRSIZ);
                p[DIRSIZ] = 0;
                find(buf, name);
            }
            break;
    } 
    close(fd);
}

int main(int argc, char * argv[]){
    if(argc < 3){
        find(".", argv[1]);
        exit(0);
    }
    char namebuf[14];
    strcpy(namebuf, argv[2]);
    memset(namebuf+strlen(argv[2]), ' ', DIRSIZ-strlen(argv[2]));
    if(argc == 3){
        find(argv[1], namebuf);
        exit(0);
    }
    fprintf(2, "find: wrong arguments\n");
    exit(0);
}