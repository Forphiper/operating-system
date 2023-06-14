#include "kernel/types.h"
#include "user/setjmp.h"
#include "user/threads.h"
#include "user/user.h"
#define NULL 0


static struct thread* current_thread = NULL;
static int id = 1;
static jmp_buf env_st;
static jmp_buf env_tmp;

struct thread *thread_create(void (*f)(void *), void *arg){
    struct thread *t = (struct thread*) malloc(sizeof(struct thread));
    unsigned long new_stack_p;
    unsigned long new_stack;
    new_stack = (unsigned long) malloc(sizeof(unsigned long)*0x100);
    new_stack_p = new_stack +0x100*8-0x2*8;
    t->fp = f;
    t->arg = arg;
    t->ID  = id;
    t->buf_set = 0;
    t->stack = (void*) new_stack;
    t->stack_p = (void*) new_stack_p;
    id++;

    // part 2
    t->sig_handler[0] = NULL_FUNC;
    t->sig_handler[1] = NULL_FUNC;
    t->signo = -1;
    t->handler_buf_set = 0;
    return t;
}
void thread_add_runqueue(struct thread *t){
    if(current_thread == NULL){
        // TODO
        // add the thread to the empty runqueue
        t->previous = t;
        t->next = t;
        current_thread = t;
    }
    else{
        // TODO
        // add the thread to the non-empty runqueue
        current_thread->previous->next = t;
        t->previous = current_thread->previous;
        
        t->next = current_thread;
        current_thread->previous = t;

        // inherit signal handler from parent thread
        if(current_thread->sig_handler[0] != NULL_FUNC){
            t->sig_handler[0] = current_thread->sig_handler[0];
        }
        if(current_thread->sig_handler[1] != NULL_FUNC){
            t->sig_handler[1] = current_thread->sig_handler[1];
        }
    }
}
void thread_yield(void){
    // TODO
    if(current_thread->signo == 0 || current_thread->signo == 1){
        // handler func
        int sj_handler_ret;
        sj_handler_ret = setjmp(current_thread->handler_env);
        if(sj_handler_ret == 0){
            current_thread->handler_buf_set = 1;
            schedule();
            dispatch();
        }
    }
    else{
        // thread func
        int sj_ret;
        sj_ret = setjmp(current_thread->env);
        if(sj_ret == 0){
            current_thread->buf_set = 1;
            schedule();
            dispatch();
        }
    }
}
void dispatch(void){
    // TODO
    if(current_thread->signo == 0 || current_thread->signo == 1){
        if(current_thread->sig_handler[current_thread->signo] == NULL_FUNC){
            thread_exit();
        }

        if(current_thread->handler_buf_set == 0){
            int sj_ret;
            
            // handler func not executed before, so do some initialization
            sj_ret = setjmp(env_tmp);
            if(sj_ret == 0){
                if(current_thread->buf_set == 0){
                    // thread func not executed before
                    env_tmp->sp = (unsigned long)current_thread->stack_p;
                }
                else{
                    // thread func executed before
                    env_tmp->sp = current_thread->env->sp;
                }
                
                longjmp(env_tmp, 1);
            }
            else{
                current_thread->sig_handler[current_thread->signo](current_thread->signo);
                
                // return from handler function
                current_thread->signo = -1;
                
                if(current_thread->buf_set == 1){
                    // thread func executed before, so longjmp
                    longjmp(current_thread->env, 1);
                }
                else{
                    // thread func not executed before, so execute the thread func
                    sj_ret = setjmp(env_tmp);
                    if(sj_ret == 0){
                        env_tmp->sp = (unsigned long)current_thread->stack_p;
                        longjmp(env_tmp, 1);
                    }
                    else{
                        current_thread->fp(current_thread->arg);
                        thread_exit();
                    }
                }
            }
        }
        else{
            // signal handler was executed before
            longjmp(current_thread->handler_env, 1);
        }
    }
    else{
        if(current_thread->buf_set == 0){
            // current thread never run before
            int sj_ret;
            sj_ret = setjmp(env_tmp);
            if(sj_ret == 0){
                env_tmp->sp = (unsigned long)current_thread->stack_p;
                longjmp(env_tmp, 1);
            }
            else{
                current_thread->fp(current_thread->arg);
                thread_exit();
            }
        }
        else{
            // current thread was executed before
            longjmp(current_thread->env, 1);
        }
    }
}
void schedule(void){
    // TODO
    current_thread = current_thread->next;
}
void thread_exit(void){
    if(current_thread->next != current_thread){
        // TODO
        // at least one thread remaining to be executed
        // remove calling thread from runqueue and update current thread
        current_thread->previous->next = current_thread->next;
        current_thread->next->previous = current_thread->previous;
        
        struct thread *curr = current_thread;
        current_thread = current_thread->next;
        
        free(curr->stack);
        free(curr);

        dispatch();
    }
    else{
        // TODO
        // Hint: No more thread to execute
        // current thread is the last thread exits
        free(current_thread->stack);
        free(current_thread);
        current_thread = NULL;
        longjmp(env_st, 1);
    }
}
void thread_start_threading(void){
    // TODO
    // return only if all threads have exited
    int sj_ret;
    sj_ret = setjmp(env_st);
    if(sj_ret == 0){
        dispatch();
    }
}
// part 2
void thread_register_handler(int signo, void (*handler)(int)){
    // TODO
    // register handler according to signal
    if(signo == 0){
        current_thread->sig_handler[0] = handler;
    }
    else if(signo == 1){
        current_thread->sig_handler[1] = handler;
    }
}
void thread_kill(struct thread *t, int signo){
    // TODO
    t->signo = signo;
}
