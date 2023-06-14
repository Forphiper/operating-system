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
    struct thread *t1 = thread_create(f, NULL, 6, 60, 10);
    thread_add_at(t1, 25);
    struct thread *t2 = thread_create(f, NULL, 15, 75, 1);
    thread_add_at(t2, 31);
    struct thread *t3 = thread_create(f, NULL, 11, 56, 1);
    thread_add_at(t3, 32);
    struct thread *t4 = thread_create(f, NULL, 4, 77, 4);
    thread_add_at(t4, 38);
    struct thread *t5 = thread_create(f, NULL, 8, 74, 2);
    thread_add_at(t5, 40);
    struct thread *t6 = thread_create(f, NULL, 9, 45, 8);
    thread_add_at(t6, 41);
    struct thread *t7 = thread_create(f, NULL, 5, 75, 2);
    thread_add_at(t7, 42);
    struct thread *t8 = thread_create(f, NULL, 1, 28, 10);
    thread_add_at(t8, 54);
    struct thread *t9 = thread_create(f, NULL, 5, 91, 3);
    thread_add_at(t9, 57);
    struct thread *t10 = thread_create(f, NULL, 4, 83, 7);
    thread_add_at(t10, 77);
    struct thread *t11 = thread_create(f, NULL, 1, 7, 2);
    thread_add_at(t11, 80);
    struct thread *t12 = thread_create(f, NULL, 1, 59, 2);
    thread_add_at(t12, 83);
    struct thread *t13 = thread_create(f, NULL, 2, 20, 10);
    thread_add_at(t13, 91);
    struct thread *t14 = thread_create(f, NULL, 2, 16, 2);
    thread_add_at(t14, 93);
    struct thread *t15 = thread_create(f, NULL, 1, 7, 3);
    thread_add_at(t15, 94);

    thread_start_threading();
    printf("\nexited\n");
    exit(0);
}
