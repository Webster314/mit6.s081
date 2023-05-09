#include "kernel/types.h"
#include "user/user.h"

// existing bug
//
int main(int argc, char * argv[]){
    int p[2];
    pipe(p);
    int pid = fork();
    char buf;
    if(pid == 0){
        read(p[0], &buf, 1);
        close(p[0]);
        printf("%d: received ping\n", getpid());
        write(p[1], " ", 1);
        close(p[1]);
    }else if(pid > 0){
        write(p[1], " ", 1);
        close(p[1]);
        read(p[0], &buf, 1);
        close(p[0]);
        printf("%d: received pong\n", getpid());
    }else{
        exit(-1); 
    }
    return 0;
}
