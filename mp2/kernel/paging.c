#include "param.h"
#include "types.h"
#include "memlayout.h"
#include "riscv.h"
#include "spinlock.h"
#include "defs.h"
#include "proc.h"

/* NTU OS 2022 */
/* Page fault handler */
int handle_pgfault() {
  /* Find the address that caused the fault */
  /* uint64 va = r_stval(); */

  /* TODO */
  uint64 va = r_stval();
  va = PGROUNDDOWN(va);
  
  // myproc() return the current struct proc *, or zero if none
  struct proc *p = myproc();
  pte_t *ppte = walk(p->pagetable, va, 1);
  
  // allocate 4096-byte physical memory and initialize
  char *pa = kalloc();
  if(pa == 0) {
    p->killed = 1;
  }
  
  if(*ppte & PTE_S) {
    uint64 blockno = PTE2BLOCKNO(*ppte);

    // swap in the page on disk to physical memory
    begin_op(); // called at the start of each FS system call
    read_page_from_disk(ROOTDEV, pa ,blockno);
    bfree_page(ROOTDEV, blockno);
    end_op(); // called at the end of each FS system call
        
    // get the page table entry from physical address and set the flags 
    *ppte = PA2PTE(pa) | (PTE_U | PTE_R | PTE_W | PTE_X);
    // set the PTE_V bit     
    *ppte |= PTE_V;
    // cancel the PTE_S bit
    *ppte &= (~PTE_S);
  }
  else {
    memset(pa, 0, PGSIZE);
  
    // map virtual address to physical address
    if(mappages(p->pagetable, va, PGSIZE, (uint64)pa, PTE_R | PTE_W | PTE_X | PTE_U) != 0) {
      // deallocate physical memory page at pa
      kfree(pa);
      p->killed = 1;
    }
  }
  
  return 0;
}
