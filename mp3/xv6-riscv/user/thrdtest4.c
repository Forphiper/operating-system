#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0
#define TOLERENCE 1
#define REC_DEPTH 3

#define THRDSTOP_DELAY 3
#define TIMEOUT_THRESHOLD 20

int main_id = -1;

void thrdstop_handler(void *arg)
{
    int *flag_p = (int *)arg;
    *flag_p = 1;
    thrdresume(main_id);
}

int test_context_correctly_saved()
{
    int flag = 0;
    thrdstop(50, &main_id, thrdstop_handler, (void *)&flag);
    __asm__ volatile (
        "mv t0,%0\n"
        "li a1,1111\n"
        "li a6,1010\n"
        "li a7,1001\n"
        "loop:\n"
        "lw t1,0(t0)\n"
        "beqz t1,loop\n"
        "addi a1,a1,-1111\n"
        "bnez a1,failed\n"
        "addi a6,a6,-1010\n"
        "bnez a6,failed\n"
        "addi a7,a7,-1001\n"
        "bnez a7,failed\n"
        "beqz zero,success\n"
        "failed:\n"
        "ld ra,24(sp)\n"
        "ld s0,16(sp)\n"
        "addi sp,sp,32\n"
        "li a0,1\n"
        "ret\n"
        "success:\n"
        :
        : "r"(&flag));
    return 0;
}

int main(int argc, char **argv)
{
    int result = test_context_correctly_saved();
    fprintf(2, "[%s] %s\n", result ? "FAILED" : "OK", "test_context_correctly_saved");

    exit(0);
}
