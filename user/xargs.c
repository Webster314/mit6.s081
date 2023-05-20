#include "kernel/types.h"
#include "user/user.h"
#include "kernel/param.h"
#define LINE_MAX_LEN  512
#define ARG_MAX_LEN 32 

char *
readline(int fd){
    static char buf[LINE_MAX_LEN];
    char * p = buf;
    while((read(fd, p, 1) > 0 && *p != '\n')){
        p++;
    }
    if(p == buf)
        return 0;       // return NULL; ?
    *p = 0;
    return buf;
}

int
main(int argc, char * argv[]){
    char * buf;
    while((buf = readline(0)) != 0){
        int buf_len = strlen(buf);
        char split[MAXARG][ARG_MAX_LEN] = {0};
        char * exec_args[MAXARG];
        exec_args[0] = argc > 1 ? argv[1] : "echo";
        int index = 1;
        for(int i = 2; i < argc; i++){
            exec_args[index++] = argv[i];
        }
        int cur = 0;
        for(int i = 0; i < buf_len; i++){
            if(buf[i] != ' '){
                split[index][cur++] = buf[i];
            }else{
                split[index][cur] = 0;
                exec_args[index] = split[index];
                index++;
                cur = 0; 
                if(index >= MAXARG && i < buf_len){
                    fprintf(2, "error: too many arguments.\n");
                }
            }
        }
        exec_args[index] = split[index];

        int childpid = fork();
        if(childpid == -1){         // fork error.
            fprintf(2, "error: unable to fork().\n");
            exit(-1);
        }else if(childpid == 0){    // child proc.
            exec(exec_args[0], exec_args);
        }else{                      // father proc.
            wait(0);
        }
    }
    exit(0);
}