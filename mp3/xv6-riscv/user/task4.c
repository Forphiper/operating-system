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
    struct thread *t1 = thread_create(f, NULL, 7, 54, 10);
    thread_add_at(t1, 9);
    struct thread *t2 = thread_create(f, NULL, 5, 62, 4);
    thread_add_at(t2, 11);
    struct thread *t3 = thread_create(f, NULL, 1, 45, 1);
    thread_add_at(t3, 13);
    struct thread *t4 = thread_create(f, NULL, 1, 74, 7);
    thread_add_at(t4, 14);
    struct thread *t5 = thread_create(f, NULL, 10, 85, 2);
    thread_add_at(t5, 30);
    struct thread *t6 = thread_create(f, NULL, 8, 41, 9);
    thread_add_at(t6, 38);
    struct thread *t7 = thread_create(f, NULL, 6, 90, 6);
    thread_add_at(t7, 43);
    struct thread *t8 = thread_create(f, NULL, 11, 61, 9);
    thread_add_at(t8, 47);
    struct thread *t9 = thread_create(f, NULL, 5, 25, 7);
    thread_add_at(t9, 48);
    struct thread *t10 = thread_create(f, NULL, 1, 98, 8);
    thread_add_at(t10, 49);
    struct thread *t11 = thread_create(f, NULL, 19, 95, 10);
    thread_add_at(t11, 50);
    struct thread *t12 = thread_create(f, NULL, 2, 26, 9);
    thread_add_at(t12, 51);
    struct thread *t13 = thread_create(f, NULL, 1, 6, 9);
    thread_add_at(t13, 52);
    struct thread *t14 = thread_create(f, NULL, 6, 49, 8);
    thread_add_at(t14, 55);
    struct thread *t15 = thread_create(f, NULL, 17, 99, 3);
    thread_add_at(t15, 60);

    thread_start_threading();
    printf("\nexited\n");
    exit(0);
}
