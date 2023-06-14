#!/usr/bin/env python3
import os
import re

from gradelib import *

os.system("make clean")

r = Runner(save("xv6.out"))


@test(6, "thrdtest1")
def test_uthread():
    global passTestNum
    r.run_qemu(shell_script([
        'thrdtest1'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_DEFAULT"])

    if not re.findall(r"\[OK\] test_cancelthrdstop_return_val_not_ticking", r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')

@test(6, "thrdtest2")
def test_uthread():
    global passTestNum
    r.run_qemu(shell_script([
        'thrdtest2'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_DEFAULT"])

    if not re.findall("\[OK\] test_cancelthrdstop_return_val_ticking", r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')

@test(6, "thrdtest3")
def test_uthread():
    global passTestNum
    r.run_qemu(shell_script([
        'thrdtest3'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_DEFAULT"])

    if not re.findall("\[OK\] test_context_id_recycled", r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')

@test(6, "thrdtest4")
def test_uthread():
    global passTestNum
    r.run_qemu(shell_script([
        'thrdtest4'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_DEFAULT"])

    if not re.findall("\[OK\] test_context_correctly_saved", r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')


run_tests()
