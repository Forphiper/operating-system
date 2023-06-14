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
    struct thread *t1 = thread_create(f, NULL, 1, 8, 8);
    thread_add_at(t1, 20);
    struct thread *t2 = thread_create(f, NULL, 2, 27, 4);
    thread_add_at(t2, 25);
    struct thread *t3 = thread_create(f, NULL, 3, 46, 3);
    thread_add_at(t3, 26);
    struct thread *t4 = thread_create(f, NULL, 3, 62, 7);
    thread_add_at(t4, 38);
    struct thread *t5 = thread_create(f, NULL, 8, 63, 6);
    thread_add_at(t5, 46);
    struct thread *t6 = thread_create(f, NULL, 3, 33, 3);
    thread_add_at(t6, 50);
    struct thread *t7 = thread_create(f, NULL, 7, 43, 5);
    thread_add_at(t7, 54);
    struct thread *t8 = thread_create(f, NULL, 10, 51, 2);
    thread_add_at(t8, 56);
    struct thread *t9 = thread_create(f, NULL, 1, 6, 2);
    thread_add_at(t9, 58);
    struct thread *t10 = thread_create(f, NULL, 2, 88, 5);
    thread_add_at(t10, 59);
    struct thread *t11 = thread_create(f, NULL, 4, 92, 5);
    thread_add_at(t11, 60);
    struct thread *t12 = thread_create(f, NULL, 2, 39, 4);
    thread_add_at(t12, 61);
    struct thread *t13 = thread_create(f, NULL, 2, 96, 1);
    thread_add_at(t13, 63);
    struct thread *t14 = thread_create(f, NULL, 2, 27, 1);
    thread_add_at(t14, 64);
    struct thread *t15 = thread_create(f, NULL, 1, 13, 1);
    thread_add_at(t15, 65);

    thread_start_threading();
    printf("\nexited\n");
    exit(0);
}
