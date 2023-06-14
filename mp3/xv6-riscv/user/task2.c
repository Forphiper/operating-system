#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0

int k = 0;

void f(void *arg)
{
    while (1) {
        k++;
    }
}

int main(int argc, char **argv)
{
    struct thread *t1 = thread_create(f, NULL, 5, 20, 2);
    thread_add_at(t1, 13);
    struct thread *t2 = thread_create(f, NULL, 10, 30, 2);
    thread_add_at(t2, 3);
    struct thread *t3 = thread_create(f, NULL, 3, 30, 1);
    thread_add_at(t3, 5);
    struct thread *t4 = thread_create(f, NULL, 7, 20, 1);
    thread_add_at(t4, 13);

    thread_start_threading();
    printf("\nexited\n");
    exit(0);
}
