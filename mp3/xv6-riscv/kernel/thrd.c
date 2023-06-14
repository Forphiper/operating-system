#include "types.h"
#include "riscv.h"
#include "defs.h"
#include "date.h"
#include "param.h"
#include "memlayout.h"
#include "spinlock.h"
#include "proc.h"

// for mp3
uint64
sys_thrdstop(void)
{
  int delay;
  uint64 context_id_ptr;
  uint64 handler, handler_arg;
  if (argint(0, &delay) < 0)
    return -1;
  if (argaddr(1, &context_id_ptr) < 0)
    return -1;
  if (argaddr(2, &handler) < 0)
    return -1;
  if (argaddr(3, &handler_arg) < 0)
    return -1;

  struct proc *proc = myproc();

  int context_id;
  // copy from user to kernel
  copyin(proc->pagetable, (char *)&context_id, context_id_ptr, sizeof(int));

  if(context_id == -1) {
    for(int i = 0; i < MAX_THRD_NUM; i++) {
      if(proc->context_id_is_used[i] == 0) {
        context_id = i;
        // copy from kernel to user
        copyout(proc->pagetable, context_id_ptr, (char *)&context_id, sizeof(int));
        break;
      }
    }
    if(context_id == -1)
      // no free space
      return -1;
  }
  else if(context_id < -1 || context_id >= MAX_THRD_NUM) {
    return -1;
  }
  
  proc->ticks = 0;
  proc->delay = delay;
  proc->handler_ptr = handler;
  proc->handler_arg = handler_arg;
  proc->context_id = context_id;
  proc->context_id_is_used[context_id] = 1;

  //printf("[thrdstop] proc->handler_arg= %d\n", proc->handler_arg);
  
  return 0;
}

// for mp3
uint64
sys_cancelthrdstop(void)
{
  int context_id, is_exit;
  if (argint(0, &context_id) < 0)
    return -1;
  if (argint(1, &is_exit) < 0)
    return -1;

  if (context_id < 0 || context_id >= MAX_THRD_NUM) {
    return -1;
  }

  struct proc *proc = myproc();

  if(is_exit == 0) {
    // Store the current context
    proc->thrd_contexts[context_id].epc = proc->trapframe->epc;
    proc->thrd_contexts[context_id].ra = proc->trapframe->ra;
    proc->thrd_contexts[context_id].sp = proc->trapframe->sp;
    proc->thrd_contexts[context_id].gp = proc->trapframe->gp;
    proc->thrd_contexts[context_id].tp = proc->trapframe->tp;
    proc->thrd_contexts[context_id].s_regs[0] = proc->trapframe->s0;
    proc->thrd_contexts[context_id].s_regs[1] = proc->trapframe->s1;
    proc->thrd_contexts[context_id].s_regs[2] = proc->trapframe->s2;
    proc->thrd_contexts[context_id].s_regs[3] = proc->trapframe->s3;
    proc->thrd_contexts[context_id].s_regs[4] = proc->trapframe->s4;
    proc->thrd_contexts[context_id].s_regs[5] = proc->trapframe->s5;
    proc->thrd_contexts[context_id].s_regs[6] = proc->trapframe->s6;
    proc->thrd_contexts[context_id].s_regs[7] = proc->trapframe->s7;
    proc->thrd_contexts[context_id].s_regs[8] = proc->trapframe->s8;
    proc->thrd_contexts[context_id].s_regs[9] = proc->trapframe->s9;
    proc->thrd_contexts[context_id].s_regs[10] = proc->trapframe->s10;
    proc->thrd_contexts[context_id].s_regs[11] = proc->trapframe->s11;
    proc->thrd_contexts[context_id].t_regs[0] = proc->trapframe->t0;
    proc->thrd_contexts[context_id].t_regs[1] = proc->trapframe->t1;
    proc->thrd_contexts[context_id].t_regs[2] = proc->trapframe->t2;
    proc->thrd_contexts[context_id].t_regs[3] = proc->trapframe->t3;
    proc->thrd_contexts[context_id].t_regs[4] = proc->trapframe->t4;
    proc->thrd_contexts[context_id].t_regs[5] = proc->trapframe->t5;
    proc->thrd_contexts[context_id].t_regs[6] = proc->trapframe->t6;
    proc->thrd_contexts[context_id].a_regs[0] = proc->trapframe->a0;
    proc->thrd_contexts[context_id].a_regs[1] = proc->trapframe->a1;
    proc->thrd_contexts[context_id].a_regs[2] = proc->trapframe->a2;
    proc->thrd_contexts[context_id].a_regs[3] = proc->trapframe->a3;
    proc->thrd_contexts[context_id].a_regs[4] = proc->trapframe->a4;
    proc->thrd_contexts[context_id].a_regs[5] = proc->trapframe->a5; 
    proc->thrd_contexts[context_id].a_regs[6] = proc->trapframe->a6;
    proc->thrd_contexts[context_id].a_regs[7] = proc->trapframe->a7;
  }
  else if(is_exit == 1) {
    // Release the current context and recycle this ID
    proc->context_id_is_used[context_id] = 0;
    proc->delay = -1;
  }

  return proc->ticks;
}

// for mp3
uint64
sys_thrdresume(void)
{
  int context_id;
  if (argint(0, &context_id) < 0)
    return -1;

  struct proc *proc = myproc();
  
  //printf("[thrdresume] thrdresume start context_id= %d\n", context_id);
  if(context_id < 0 || context_id >= MAX_THRD_NUM)
    return -1;
  if(proc->context_id_is_used[context_id] == 0)
    return -1;
  
  // Restore the context 
  proc->trapframe->epc = proc->thrd_contexts[context_id].epc;
  proc->trapframe->ra = proc->thrd_contexts[context_id].ra;
  proc->trapframe->sp = proc->thrd_contexts[context_id].sp;
  proc->trapframe->gp = proc->thrd_contexts[context_id].gp;
  proc->trapframe->tp = proc->thrd_contexts[context_id].tp;
  proc->trapframe->s0 = proc->thrd_contexts[context_id].s_regs[0];
  proc->trapframe->s1 = proc->thrd_contexts[context_id].s_regs[1];
  proc->trapframe->s2 = proc->thrd_contexts[context_id].s_regs[2];
  proc->trapframe->s3 = proc->thrd_contexts[context_id].s_regs[3];
  proc->trapframe->s4 = proc->thrd_contexts[context_id].s_regs[4];
  proc->trapframe->s5 = proc->thrd_contexts[context_id].s_regs[5];
  proc->trapframe->s6 = proc->thrd_contexts[context_id].s_regs[6];
  proc->trapframe->s7 = proc->thrd_contexts[context_id].s_regs[7];
  proc->trapframe->s8 = proc->thrd_contexts[context_id].s_regs[8];
  proc->trapframe->s9 = proc->thrd_contexts[context_id].s_regs[9];
  proc->trapframe->s10 = proc->thrd_contexts[context_id].s_regs[10];
  proc->trapframe->s11 = proc->thrd_contexts[context_id].s_regs[11];
  proc->trapframe->t0 = proc->thrd_contexts[context_id].t_regs[0];
  proc->trapframe->t1 = proc->thrd_contexts[context_id].t_regs[1];
  proc->trapframe->t2 = proc->thrd_contexts[context_id].t_regs[2];
  proc->trapframe->t3 = proc->thrd_contexts[context_id].t_regs[3];
  proc->trapframe->t4 = proc->thrd_contexts[context_id].t_regs[4];
  proc->trapframe->t5 = proc->thrd_contexts[context_id].t_regs[5];
  proc->trapframe->t6 = proc->thrd_contexts[context_id].t_regs[6];
  proc->trapframe->a0 = proc->thrd_contexts[context_id].a_regs[0];
  proc->trapframe->a1 = proc->thrd_contexts[context_id].a_regs[1];
  proc->trapframe->a2 = proc->thrd_contexts[context_id].a_regs[2];
  proc->trapframe->a3 = proc->thrd_contexts[context_id].a_regs[3];
  proc->trapframe->a4 = proc->thrd_contexts[context_id].a_regs[4];
  proc->trapframe->a5 = proc->thrd_contexts[context_id].a_regs[5];
  proc->trapframe->a6 = proc->thrd_contexts[context_id].a_regs[6];
  proc->trapframe->a7 = proc->thrd_contexts[context_id].a_regs[7];
    
  //proc->context_id_is_used[context_id] = 0;

  return 0;
}
