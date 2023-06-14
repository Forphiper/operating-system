#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0
#define TOLERENCE 1
#define REC_DEPTH 33

#define THRDSTOP_DELAY 3
#define TIMEOUT_THRESHOLD 30

int main_id = -1;
int done = 0;
int ctx_id_arr[REC_DEPTH];

void thrdstop_handler_recurse(void *arg)
{
    int *depth_p = (int *)arg;
    int depth = *depth_p;
    fprintf(2, "depth = %d\n", depth);
    if (depth < REC_DEPTH) {
        if (depth > 0) {
            // free the previous level
            cancelthrdstop(ctx_id_arr[depth-1], 1);
        }

        *depth_p += 1;
        ctx_id_arr[depth] = -1;
        int r = thrdstop(THRDSTOP_DELAY, &ctx_id_arr[depth], thrdstop_handler_recurse, arg);
        if (r == -1) {
            fprintf(2, "[FAILED] unsuccessful thrdstop\n");
            exit(1);
        }

        int start_time = uptime();
        while (uptime() - start_time <= TIMEOUT_THRESHOLD) {
            // wait for handler
        }

        fprintf(2, "[FAILED] timeout waiting handler to execute\n");
        exit(1);
    } else {
        done = 1;
        thrdresume(main_id); // back to the while loop in test_context_id_recycled
    }
}

int test_context_id_recycled()
{
    int v = 0;
    thrdstop(THRDSTOP_DELAY, &main_id, thrdstop_handler_recurse, (void *)&v);
    
    int start_time = uptime();
    while (!done && uptime() - start_time <= TIMEOUT_THRESHOLD) {
        // wait for handler
    }

    return !done;
}

int main(int argc, char **argv)
{
    int result = test_context_id_recycled();
    fprintf(2, "[%s] %s\n", result ? "FAILED" : "OK", "test_context_id_recycled");

    exit(0);
}
