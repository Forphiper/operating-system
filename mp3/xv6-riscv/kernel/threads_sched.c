#include "kernel/types.h"
#include "user/user.h"
#include "user/list.h"
#include "user/threads.h"
#include "user/threads_sched.h"

#define NULL 0

/* default scheduling algorithm */
struct threads_sched_result schedule_default(struct threads_sched_args args)
{
    struct thread *thread_with_smallest_id = NULL;
    struct thread *th = NULL;
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (thread_with_smallest_id == NULL || th->ID < thread_with_smallest_id->ID) {
            thread_with_smallest_id = th;
        }
    }

    struct threads_sched_result r;
    if (thread_with_smallest_id != NULL) {
        r.scheduled_thread_list_member = &thread_with_smallest_id->thread_list;
        r.allocated_time = thread_with_smallest_id->remaining_time;
    } else {
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 1;
    }

    return r;
}

/* Earliest-Deadline-First scheduling */
struct threads_sched_result schedule_edf(struct threads_sched_args args)
{
    struct thread *thread_with_earliest_deadline = NULL;
    struct thread *th = NULL;
    // iterate through run quene and select the thread with earliest deadline
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (thread_with_earliest_deadline == NULL || th->current_deadline < thread_with_earliest_deadline->current_deadline ||
            (th->current_deadline == thread_with_earliest_deadline->current_deadline && th->ID < thread_with_earliest_deadline->ID)) {
            thread_with_earliest_deadline = th;
        }
    }

    struct threads_sched_result r;
    if (thread_with_earliest_deadline != NULL) {
        r.scheduled_thread_list_member = &thread_with_earliest_deadline->thread_list;
        int remaining_time_to_deadline = thread_with_earliest_deadline->current_deadline - args.current_time;

        if (remaining_time_to_deadline <= 0) {
            // the current earliest deadline thread already misses deadline
            r.allocated_time = 0;
            struct thread *th = NULL;
            // check if there are any other threads already miss deadline
            // and should choose the one with smallest ID
            list_for_each_entry(th, args.run_queue, thread_list) {
                if (th->ID < thread_with_earliest_deadline->ID &&
                    th->current_deadline >= args.current_time) {
                    r.scheduled_thread_list_member = &th->thread_list;
                }
            }
        }
        else {
            // run until meets/misses deadline or gets preempted by higher priority
            r.allocated_time = thread_with_earliest_deadline->remaining_time <= remaining_time_to_deadline ? thread_with_earliest_deadline->remaining_time : remaining_time_to_deadline;
            struct release_queue_entry *entry = NULL;
            list_for_each_entry(entry, args.release_queue, thread_list) {
                if (entry->release_time + entry->thrd->period < thread_with_earliest_deadline->current_deadline ||
                    (entry->release_time + entry->thrd->period == thread_with_earliest_deadline->current_deadline && entry->thrd->ID < thread_with_earliest_deadline->ID)) {
                    int remaining_time_to_next_release = entry->release_time - args.current_time;
                    if (remaining_time_to_next_release < r.allocated_time) {
                        r.allocated_time = remaining_time_to_next_release;
                    }
                }
            }
        }
    } 
    else {
        // run queue is empty, allocate time for sleeping
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 100;  
        struct release_queue_entry *entry = NULL;
        list_for_each_entry(entry, args.release_queue, thread_list) {
            int remaining_time_to_next_release = entry->release_time - args.current_time;
            if (remaining_time_to_next_release < r.allocated_time) {
                r.allocated_time = remaining_time_to_next_release;
            }
        }
    }

    return r;
}

/* Rate-Monotonic Scheduling */
struct threads_sched_result schedule_rm(struct threads_sched_args args)
{
    struct thread *thread_with_shortest_period = NULL;
    struct thread *th = NULL;
    // iterate through run queue to get the thread with the shortest period, i.e., the highest priority
    list_for_each_entry(th, args.run_queue, thread_list) {
        if (thread_with_shortest_period == NULL || th->period < thread_with_shortest_period->period ||
            (th->period == thread_with_shortest_period->period && th->ID < thread_with_shortest_period->ID)) {
            thread_with_shortest_period = th;
        }
    }

    struct threads_sched_result r;
    if (thread_with_shortest_period != NULL) {
        r.scheduled_thread_list_member = &thread_with_shortest_period->thread_list;
        int remaining_time_to_deadline = thread_with_shortest_period->current_deadline - args.current_time;
        
        if (remaining_time_to_deadline <= 0) {
            // the current shortest period thread already misses deadline
            r.allocated_time = 0;
            struct thread *th = NULL;
            // check if there are any other threads already miss deadline
            // and should choose the one with smallest ID
            list_for_each_entry(th, args.run_queue, thread_list) {
                if (th->ID < thread_with_shortest_period->ID &&
                    th->current_deadline >= args.current_time) {
                    r.scheduled_thread_list_member = &th->thread_list;
                }
            }
        }
        else {
            // run until meets/misses deadline or gets preempted by higher priority
            r.allocated_time = thread_with_shortest_period->remaining_time <= remaining_time_to_deadline ? thread_with_shortest_period->remaining_time : remaining_time_to_deadline;
            struct release_queue_entry *entry = NULL;
            list_for_each_entry(entry, args.release_queue, thread_list) {
                if (entry->thrd->period < thread_with_shortest_period->period ||
                    (entry->thrd->period == thread_with_shortest_period->period && entry->thrd->ID < thread_with_shortest_period->ID)) {
                    int remaining_time_to_next_release = entry->release_time - args.current_time;
                    if (remaining_time_to_next_release < r.allocated_time) {
                        r.allocated_time = remaining_time_to_next_release;
                    }
                }
            }
        }
    } else {
        // run queue is empty, allocate time for sleeping
        r.scheduled_thread_list_member = args.run_queue;
        r.allocated_time = 100;
        struct release_queue_entry *entry = NULL;
        list_for_each_entry(entry, args.release_queue, thread_list) {
            int remaining_time_to_next_release = entry->release_time - args.current_time;
            if (remaining_time_to_next_release < r.allocated_time) {
                r.allocated_time = remaining_time_to_next_release;
            }
        }
    }

    return r;
}
