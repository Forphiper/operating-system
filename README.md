# Operating System Machine Problems

## MP0
* xv6 is an example kernel created by MIT for pedagogical purposes. 
* We will study xv6 to get familiar with the main concepts of operating systems. 
* We will learn to set up the environment for xv6 and develop a custom mp0 command in this MP

## MP1
* User-Level Thread Package: Implementing a user-level thread package using setjmp and longjmp.
* Thread Management: Functions for adding threads to the run queue, yielding execution, scheduling threads, and handling thread exits.
* Signal Handling: Parent thread can send signals to terminate or trigger signal handlers of child threads. Functions for registering handlers and killing threads.

## MP2
* Virtual Memory and Demand Paging: Implementing virtual memory management using demand paging to efficiently allocate and access memory.
* Swapping and Disk Storage: Adding swapping functionality to store memory pages on disk, optimizing memory usage.
* Enhancements to xv6: Integrating demand paging and swapping into the existing page table of the xv6 operating system, improving memory management and performance.

## MP3
* Preemptive User-Level Threading: Enable preemptive user-level threading by leveraging xv6's timer interrupts. Modify interrupt handling code and implement system calls to support a custom timer for preemptive scheduling.
* Real-Time Scheduling Algorithms: Implement Earliest-Deadline-First Scheduling and Rate-Monotonic Scheduling algorithms for efficient scheduling of periodic tasks. Avoid unnecessary overhead by allocating appropriate time to each thread.
* Enhancements to Thread Library: Extend the existing user-level threading library by integrating system calls for timer manipulation. Integrate a provided real-time threading library for real-time scheduling functionality.

## MP4
* Large Files: Enhance xv6 file system to support larger files by implementing "doubly-indirect" blocks, increasing the maximum file size to 66,666 blocks.
* Symbolic Links to Files: Add symbolic link functionality to xv6. Implement symlink(char *target, char *path) system call to create symbolic links, handle recursive linking, and support O NOFOLLOW flag for following or not following symbolic links.
* Symbolic Links to Directories: Extend symbolic link capability to directories. Enable path redirection and allow changing the working directory through symbolic links to directories.


