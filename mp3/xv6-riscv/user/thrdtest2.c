#include "kernel/types.h"
#include "user/user.h"
#include "user/threads.h"

#define NULL 0
#define TOLERENCE 2

int main_id = -1;

void thrdstop_handler(void *arg)
{
    int *lock = (int *)arg;
    *lock = 1;
    thrdresume(main_id);
}

int test_cancelthrdstop_return_val_ticking_helper(int num_ticks)
{
    int lock = 0;
    int start_time_outer = uptime();

    // should jump to thrdstop_handler after [num_ticks] timer interrupts
    if (thrdstop(num_ticks+100, &main_id, thrdstop_handler, (void *)&lock) == -1) {
        fprintf(2, "thrdstop error\n");
        exit(1);
    }

    int start_time_inner = uptime();
    int elapsed_time_lb = 0;
    while (1) {
        int t = uptime();
        if (lock) {
            return 1;
        }
    
        elapsed_time_lb = t - start_time_inner;
        if (elapsed_time_lb >= num_ticks) {
            int cancelthrdstop_ret = cancelthrdstop(main_id, 0);
            int elapsed_time_ub = uptime() - start_time_outer;
            if (cancelthrdstop_ret > elapsed_time_ub || cancelthrdstop_ret < elapsed_time_lb) {
                fprintf(2, "cancelthrdstop return value differs too much from expected: "
                           "actual=%d lower_bound=%d, upper_bound=%d\n", cancelthrdstop_ret, elapsed_time_lb, elapsed_time_ub);
                return 1;
            }
            return 0;
        }
    }

    return 0;
}

int test_cancelthrdstop_return_val_ticking()
{
    int args[] = {4, 13};
    int failed = 0;
    for (int i = 0; i < sizeof(args) / sizeof(int); i++) {
        int result = test_cancelthrdstop_return_val_ticking_helper(args[i]);
        if (result) {
            failed = 1;
            break;
        }
    }

    return failed;
}

int main(int argc, char **argv)
{
    int result = test_cancelthrdstop_return_val_ticking();
    fprintf(2, "[%s] %s\n", result ? "FAILED" : "OK", "test_cancelthrdstop_return_val_ticking");

    exit(0);
}
