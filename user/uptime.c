#include <kernel/types.h>
#include <user/user.h>

int main(void){
    uint64 ticks = uptime();
    printf("%l\n", ticks); 
    exit(0);
}
