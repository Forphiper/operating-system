#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0
#define TOLERENCE 1

int main_id = -1;

void thrdstop_handler(void *arg)
{
    int *lock = (int *)arg;
    *lock = 1;
    thrdresume(main_id);
}

int test_cancelthrdstop_return_val_not_ticking_helper(int num_ticks)
{
    int lock = 0;

    // should jump to thrdstop_handler after [num_ticks] timer interrupts
    if (thrdstop(num_ticks, &main_id, thrdstop_handler, (void *)&lock) == -1) {
        fprintf(2, "thrdstop error\n");
        exit(1);
    }

    int start_time_inner = uptime();
    int elapsed_time_lb = 0;
    while (!lock) {
        int t = uptime();
        if (lock) {
            break;
        }

        elapsed_time_lb = t - start_time_inner;
        if (elapsed_time_lb > num_ticks) {
            fprintf(2, "thrdstop timing differs too much from expected value: "
                       "expected=%d actual>=%d\n", num_ticks, elapsed_time_lb);
            return 1;
        }
    }

    int cancelthrdstop_ret = cancelthrdstop(main_id, 0);
    if (cancelthrdstop_ret != num_ticks) {
        fprintf(2, "wrong cancelthrdstop return value: "
                   "expected=%d actual=%d\n", num_ticks, cancelthrdstop_ret);
        return 1;
    }

    return 0;
}

int test_cancelthrdstop_return_val_not_ticking()
{
    int args[] = {3, 7, 11, 6};
    int failed = 0;
    for (int i = 0; i < sizeof(args) / sizeof(int); i++) {
        int result = test_cancelthrdstop_return_val_not_ticking_helper(args[i]);
        if (result) {
            failed = 1;
            break;
        }
    }

    return failed;
}

int main(int argc, char **argv)
{
    int result = test_cancelthrdstop_return_val_not_ticking();
    fprintf(2, "[%s] %s\n", result ? "FAILED" : "OK", "test_cancelthrdstop_return_val_not_ticking");

    exit(0);
}
