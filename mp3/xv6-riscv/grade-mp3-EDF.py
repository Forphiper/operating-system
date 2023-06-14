#!/usr/bin/env python3

import re
from gradelib import *

import os

os.system("make clean")
r = Runner(save("xv6.out"))

@test(3, "task1")
def test_uthread():
    r.run_qemu(shell_script([
        'task1'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_EDF"])
    expected = """run_queue is empty, sleep for 3 ticks
dispatch thread#1 at 3: allocated_time=2
dispatch thread#4 at 5: allocated_time=7
thread#4 finish one cycle at 12: 0 cycles left
dispatch thread#3 at 12: allocated_time=3
thread#3 finish one cycle at 15: 0 cycles left
dispatch thread#2 at 15: allocated_time=5
thread#2 finish one cycle at 20: 1 cycles left
dispatch thread#1 at 20: allocated_time=8
thread#1 finish one cycle at 28: 1 cycles left
dispatch thread#2 at 28: allocated_time=5
thread#2 finish one cycle at 33: 0 cycles left
dispatch thread#1 at 33: allocated_time=10
thread#1 finish one cycle at 43: 0 cycles left"""
    if not re.findall(expected, r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')
    
@test(3, "task2")
def test_uthread():
    r.run_qemu(shell_script([
        'task2'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_EDF"])
    expected = """run_queue is empty, sleep for 3 ticks
dispatch thread#2 at 3: allocated_time=10
thread#2 finish one cycle at 13: 1 cycles left
dispatch thread#1 at 13: allocated_time=5
thread#1 finish one cycle at 18: 1 cycles left
dispatch thread#4 at 18: allocated_time=7
thread#4 finish one cycle at 25: 0 cycles left
dispatch thread#3 at 25: allocated_time=3
thread#3 finish one cycle at 28: 0 cycles left
run_queue is empty, sleep for 5 ticks
dispatch thread#1 at 33: allocated_time=5
thread#1 finish one cycle at 38: 0 cycles left
dispatch thread#2 at 38: allocated_time=10
thread#2 finish one cycle at 48: 0 cycles left"""
    if not re.findall(expected, r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')

@test(4, "task3")
def test_uthread():
    r.run_qemu(shell_script([
        'task3'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_EDF"])
    expected = """run_queue is empty, sleep for 25 ticks
dispatch thread#1 at 25: allocated_time=6
thread#1 finish one cycle at 31: 9 cycles left
dispatch thread#2 at 31: allocated_time=1
dispatch thread#3 at 32: allocated_time=9
dispatch thread#6 at 41: allocated_time=9
thread#6 finish one cycle at 50: 7 cycles left
dispatch thread#3 at 50: allocated_time=2
thread#3 finish one cycle at 52: 0 cycles left
dispatch thread#2 at 52: allocated_time=2
dispatch thread#8 at 54: allocated_time=1
thread#8 finish one cycle at 55: 9 cycles left
dispatch thread#2 at 55: allocated_time=12
thread#2 finish one cycle at 67: 0 cycles left
dispatch thread#5 at 67: allocated_time=8
thread#5 finish one cycle at 75: 1 cycles left
dispatch thread#4 at 75: allocated_time=4
thread#4 finish one cycle at 79: 3 cycles left
dispatch thread#7 at 79: allocated_time=1
dispatch thread#11 at 80: allocated_time=1
thread#11 finish one cycle at 81: 1 cycles left
dispatch thread#7 at 81: allocated_time=1
dispatch thread#8 at 82: allocated_time=1
thread#8 finish one cycle at 83: 8 cycles left
dispatch thread#7 at 83: allocated_time=3
thread#7 finish one cycle at 86: 1 cycles left
dispatch thread#6 at 86: allocated_time=1
dispatch thread#11 at 87: allocated_time=1
thread#11 finish one cycle at 88: 0 cycles left
dispatch thread#6 at 88: allocated_time=3
dispatch thread#13 at 91: allocated_time=2
thread#13 finish one cycle at 93: 9 cycles left
dispatch thread#14 at 93: allocated_time=1
dispatch thread#15 at 94: allocated_time=1
thread#15 finish one cycle at 95: 2 cycles left
dispatch thread#14 at 95: allocated_time=1
thread#14 finish one cycle at 96: 1 cycles left
dispatch thread#6 at 96: allocated_time=5
thread#6 finish one cycle at 101: 6 cycles left
dispatch thread#15 at 101: allocated_time=1
thread#15 finish one cycle at 102: 1 cycles left
dispatch thread#12 at 102: allocated_time=1
thread#12 finish one cycle at 103: 1 cycles left
dispatch thread#1 at 103: allocated_time=5
dispatch thread#15 at 108: allocated_time=1
thread#15 finish one cycle at 109: 0 cycles left
dispatch thread#14 at 109: allocated_time=2
thread#14 finish one cycle at 111: 0 cycles left
dispatch thread#13 at 111: allocated_time=2
thread#13 finish one cycle at 113: 8 cycles left
dispatch thread#8 at 113: allocated_time=1
thread#8 finish one cycle at 114: 7 cycles left
dispatch thread#1 at 114: allocated_time=1
thread#1 finish one cycle at 115: 8 cycles left
dispatch thread#9 at 115: allocated_time=5
thread#9 finish one cycle at 120: 2 cycles left
dispatch thread#10 at 120: allocated_time=4
thread#10 finish one cycle at 124: 6 cycles left
dispatch thread#5 at 124: allocated_time=7
dispatch thread#13 at 131: allocated_time=2
thread#13 finish one cycle at 133: 7 cycles left
dispatch thread#6 at 133: allocated_time=5
dispatch thread#8 at 138: allocated_time=1
thread#8 finish one cycle at 139: 6 cycles left
dispatch thread#6 at 139: allocated_time=4
thread#6 finish one cycle at 143: 5 cycles left
dispatch thread#5 at 143: allocated_time=1
thread#5 finish one cycle at 144: 0 cycles left
dispatch thread#4 at 144: allocated_time=4
thread#4 finish one cycle at 148: 2 cycles left
dispatch thread#7 at 148: allocated_time=3
dispatch thread#13 at 151: allocated_time=2
thread#13 finish one cycle at 153: 6 cycles left
dispatch thread#7 at 153: allocated_time=2
thread#7 finish one cycle at 155: 0 cycles left
dispatch thread#12 at 155: allocated_time=1
thread#12 finish one cycle at 156: 0 cycles left
dispatch thread#1 at 156: allocated_time=6
thread#1 finish one cycle at 162: 7 cycles left
dispatch thread#9 at 162: allocated_time=4
dispatch thread#8 at 166: allocated_time=1
thread#8 finish one cycle at 167: 5 cycles left
dispatch thread#9 at 167: allocated_time=1
thread#9 finish one cycle at 168: 1 cycles left
dispatch thread#10 at 168: allocated_time=3
dispatch thread#13 at 171: allocated_time=2
thread#13 finish one cycle at 173: 5 cycles left
dispatch thread#10 at 173: allocated_time=1
thread#10 finish one cycle at 174: 5 cycles left
run_queue is empty, sleep for 2 ticks
dispatch thread#6 at 176: allocated_time=9
thread#6 finish one cycle at 185: 4 cycles left
run_queue is empty, sleep for 6 ticks
dispatch thread#13 at 191: allocated_time=2
thread#13 finish one cycle at 193: 4 cycles left
dispatch thread#4 at 193: allocated_time=1
dispatch thread#8 at 194: allocated_time=1
thread#8 finish one cycle at 195: 4 cycles left
dispatch thread#4 at 195: allocated_time=3
thread#4 finish one cycle at 198: 1 cycles left
run_queue is empty, sleep for 7 ticks
dispatch thread#1 at 205: allocated_time=6
thread#1 finish one cycle at 211: 6 cycles left
dispatch thread#13 at 211: allocated_time=2
thread#13 finish one cycle at 213: 3 cycles left
run_queue is empty, sleep for 8 ticks
dispatch thread#6 at 221: allocated_time=1
dispatch thread#8 at 222: allocated_time=1
thread#8 finish one cycle at 223: 3 cycles left
dispatch thread#6 at 223: allocated_time=8
thread#6 finish one cycle at 231: 3 cycles left
dispatch thread#13 at 231: allocated_time=2
thread#13 finish one cycle at 233: 2 cycles left
run_queue is empty, sleep for 6 ticks
dispatch thread#9 at 239: allocated_time=4
dispatch thread#10 at 243: allocated_time=4
thread#10 finish one cycle at 247: 4 cycles left
dispatch thread#9 at 247: allocated_time=1
thread#9 finish one cycle at 248: 0 cycles left
run_queue is empty, sleep for 2 ticks
dispatch thread#8 at 250: allocated_time=1
thread#8 finish one cycle at 251: 2 cycles left
dispatch thread#13 at 251: allocated_time=2
thread#13 finish one cycle at 253: 1 cycles left
run_queue is empty, sleep for 12 ticks
dispatch thread#1 at 265: allocated_time=1
dispatch thread#6 at 266: allocated_time=5
dispatch thread#13 at 271: allocated_time=2
thread#13 finish one cycle at 273: 0 cycles left
dispatch thread#6 at 273: allocated_time=4
thread#6 finish one cycle at 277: 2 cycles left
dispatch thread#1 at 277: allocated_time=1
dispatch thread#8 at 278: allocated_time=1
thread#8 finish one cycle at 279: 1 cycles left
dispatch thread#1 at 279: allocated_time=4
thread#1 finish one cycle at 283: 5 cycles left
dispatch thread#4 at 283: allocated_time=4
thread#4 finish one cycle at 287: 0 cycles left
run_queue is empty, sleep for 19 ticks
dispatch thread#8 at 306: allocated_time=1
thread#8 finish one cycle at 307: 0 cycles left
run_queue is empty, sleep for 4 ticks
dispatch thread#6 at 311: allocated_time=9
thread#6 finish one cycle at 320: 1 cycles left
run_queue is empty, sleep for 5 ticks
dispatch thread#1 at 325: allocated_time=6
thread#1 finish one cycle at 331: 4 cycles left
dispatch thread#10 at 331: allocated_time=4
thread#10 finish one cycle at 335: 3 cycles left
run_queue is empty, sleep for 21 ticks
dispatch thread#6 at 356: allocated_time=9
thread#6 finish one cycle at 365: 0 cycles left
run_queue is empty, sleep for 20 ticks
dispatch thread#1 at 385: allocated_time=6
thread#1 finish one cycle at 391: 3 cycles left
run_queue is empty, sleep for 18 ticks
dispatch thread#10 at 409: allocated_time=4
thread#10 finish one cycle at 413: 2 cycles left
run_queue is empty, sleep for 32 ticks
dispatch thread#1 at 445: allocated_time=6
thread#1 finish one cycle at 451: 2 cycles left
run_queue is empty, sleep for 41 ticks
dispatch thread#10 at 492: allocated_time=4
thread#10 finish one cycle at 496: 1 cycles left
run_queue is empty, sleep for 9 ticks
dispatch thread#1 at 505: allocated_time=6
thread#1 finish one cycle at 511: 1 cycles left
run_queue is empty, sleep for 54 ticks
dispatch thread#1 at 565: allocated_time=6
thread#1 finish one cycle at 571: 0 cycles left
run_queue is empty, sleep for 4 ticks
dispatch thread#10 at 575: allocated_time=4
thread#10 finish one cycle at 579: 0 cycles left"""
    if not re.findall(expected, r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')

@test(4, "task4")
def test_uthread():
    r.run_qemu(shell_script([
        'task4'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_EDF"])
    expected = """run_queue is empty, sleep for 9 ticks
dispatch thread#1 at 9: allocated_time=4
dispatch thread#3 at 13: allocated_time=1
thread#3 finish one cycle at 14: 0 cycles left
dispatch thread#1 at 14: allocated_time=3
thread#1 finish one cycle at 17: 9 cycles left
dispatch thread#2 at 17: allocated_time=5
thread#2 finish one cycle at 22: 3 cycles left
dispatch thread#4 at 22: allocated_time=1
thread#4 finish one cycle at 23: 6 cycles left
run_queue is empty, sleep for 7 ticks
dispatch thread#5 at 30: allocated_time=8
dispatch thread#6 at 38: allocated_time=8
thread#6 finish one cycle at 46: 8 cycles left
dispatch thread#5 at 46: allocated_time=1
dispatch thread#8 at 47: allocated_time=1
dispatch thread#9 at 48: allocated_time=4
dispatch thread#13 at 52: allocated_time=1
thread#13 finish one cycle at 53: 8 cycles left
dispatch thread#9 at 53: allocated_time=1
thread#9 finish one cycle at 54: 6 cycles left
dispatch thread#12 at 54: allocated_time=2
thread#12 finish one cycle at 56: 8 cycles left
dispatch thread#14 at 56: allocated_time=2
dispatch thread#13 at 58: allocated_time=1
thread#13 finish one cycle at 59: 7 cycles left
dispatch thread#14 at 59: allocated_time=4
thread#14 finish one cycle at 63: 7 cycles left
dispatch thread#8 at 63: allocated_time=1
dispatch thread#13 at 64: allocated_time=1
thread#13 finish one cycle at 65: 6 cycles left
dispatch thread#8 at 65: allocated_time=5
dispatch thread#13 at 70: allocated_time=1
thread#13 finish one cycle at 71: 5 cycles left
dispatch thread#8 at 71: allocated_time=2
dispatch thread#9 at 73: allocated_time=3
dispatch thread#13 at 76: allocated_time=1
thread#13 finish one cycle at 77: 4 cycles left
dispatch thread#9 at 77: allocated_time=2
thread#9 finish one cycle at 79: 5 cycles left
dispatch thread#12 at 79: allocated_time=2
thread#12 finish one cycle at 81: 7 cycles left
dispatch thread#8 at 81: allocated_time=1
dispatch thread#13 at 82: allocated_time=1
thread#13 finish one cycle at 83: 3 cycles left
dispatch thread#8 at 83: allocated_time=1
thread#8 finish one cycle at 84: 8 cycles left
dispatch thread#5 at 84: allocated_time=1
thread#5 finish one cycle at 85: 1 cycles left
dispatch thread#1 at 85: allocated_time=3
dispatch thread#13 at 88: allocated_time=1
thread#13 finish one cycle at 89: 2 cycles left
dispatch thread#1 at 89: allocated_time=4
thread#1 finish one cycle at 93: 8 cycles left
dispatch thread#6 at 93: allocated_time=1
dispatch thread#13 at 94: allocated_time=1
thread#13 finish one cycle at 95: 1 cycles left
dispatch thread#6 at 95: allocated_time=5
dispatch thread#13 at 100: allocated_time=1
thread#13 finish one cycle at 101: 0 cycles left
dispatch thread#6 at 101: allocated_time=2
thread#6 finish one cycle at 103: 7 cycles left
dispatch thread#9 at 103: allocated_time=5
thread#9 finish one cycle at 108: 4 cycles left
dispatch thread#12 at 108: allocated_time=2
thread#12 finish one cycle at 110: 6 cycles left
dispatch thread#7 at 110: allocated_time=6
thread#7 finish one cycle at 116: 5 cycles left
dispatch thread#2 at 116: allocated_time=5
thread#2 finish one cycle at 121: 2 cycles left
dispatch thread#11 at 121: allocated_time=19
thread#11 finish one cycle at 140: 9 cycles left
dispatch thread#10 at 140: allocated_time=1
thread#10 finish one cycle at 141: 7 cycles left
dispatch thread#9 at 141: allocated_time=5
thread#9 finish one cycle at 146: 3 cycles left
dispatch thread#14 at 146: allocated_time=6
thread#14 finish one cycle at 152: 6 cycles left
dispatch thread#12 at 152: allocated_time=2
thread#12 finish one cycle at 154: 5 cycles left
dispatch thread#15 at 154: allocated_time=5
thread#15 misses a deadline at 159"""
    if not re.findall(expected, r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')

@test(4, "task5")
def test_uthread():
    r.run_qemu(shell_script([
        'task5'
    ]), make_args = ["SCHEDPOLICY=THREAD_SCHEDULER_EDF"])
    expected = """run_queue is empty, sleep for 20 ticks
dispatch thread#1 at 20: allocated_time=1
thread#1 finish one cycle at 21: 7 cycles left
run_queue is empty, sleep for 4 ticks
dispatch thread#2 at 25: allocated_time=2
thread#2 finish one cycle at 27: 3 cycles left
dispatch thread#3 at 27: allocated_time=1
dispatch thread#1 at 28: allocated_time=1
thread#1 finish one cycle at 29: 6 cycles left
dispatch thread#3 at 29: allocated_time=2
thread#3 finish one cycle at 31: 2 cycles left
run_queue is empty, sleep for 5 ticks
dispatch thread#1 at 36: allocated_time=1
thread#1 finish one cycle at 37: 5 cycles left
run_queue is empty, sleep for 1 ticks
dispatch thread#4 at 38: allocated_time=3
thread#4 finish one cycle at 41: 6 cycles left
run_queue is empty, sleep for 3 ticks
dispatch thread#1 at 44: allocated_time=1
thread#1 finish one cycle at 45: 4 cycles left
run_queue is empty, sleep for 1 ticks
dispatch thread#5 at 46: allocated_time=4
dispatch thread#6 at 50: allocated_time=2
dispatch thread#1 at 52: allocated_time=1
thread#1 finish one cycle at 53: 3 cycles left
dispatch thread#2 at 53: allocated_time=2
thread#2 finish one cycle at 55: 2 cycles left
dispatch thread#6 at 55: allocated_time=1
thread#6 finish one cycle at 56: 2 cycles left
dispatch thread#7 at 56: allocated_time=2
dispatch thread#9 at 58: allocated_time=1
thread#9 finish one cycle at 59: 1 cycles left
dispatch thread#7 at 59: allocated_time=1
dispatch thread#1 at 60: allocated_time=1
thread#1 finish one cycle at 61: 2 cycles left
dispatch thread#7 at 61: allocated_time=3
dispatch thread#9 at 64: allocated_time=1
thread#9 finish one cycle at 65: 0 cycles left
dispatch thread#15 at 65: allocated_time=1
thread#15 finish one cycle at 66: 0 cycles left
dispatch thread#14 at 66: allocated_time=2
thread#14 finish one cycle at 68: 0 cycles left
dispatch thread#1 at 68: allocated_time=1
thread#1 finish one cycle at 69: 1 cycles left
dispatch thread#7 at 69: allocated_time=1
thread#7 finish one cycle at 70: 4 cycles left
dispatch thread#12 at 70: allocated_time=2
thread#12 finish one cycle at 72: 3 cycles left
dispatch thread#8 at 72: allocated_time=4
dispatch thread#1 at 76: allocated_time=1
thread#1 finish one cycle at 77: 0 cycles left
dispatch thread#8 at 77: allocated_time=2
dispatch thread#2 at 79: allocated_time=2
thread#2 finish one cycle at 81: 1 cycles left
dispatch thread#8 at 81: allocated_time=4
thread#8 finish one cycle at 85: 1 cycles left
dispatch thread#5 at 85: allocated_time=4
thread#5 finish one cycle at 89: 5 cycles left
dispatch thread#6 at 89: allocated_time=3
thread#6 finish one cycle at 92: 1 cycles left
dispatch thread#3 at 92: allocated_time=3
thread#3 finish one cycle at 95: 1 cycles left
dispatch thread#10 at 95: allocated_time=2
thread#10 finish one cycle at 97: 4 cycles left
dispatch thread#7 at 97: allocated_time=3
dispatch thread#12 at 100: allocated_time=2
thread#12 finish one cycle at 102: 2 cycles left
dispatch thread#7 at 102: allocated_time=4
thread#7 finish one cycle at 106: 3 cycles left
dispatch thread#2 at 106: allocated_time=2
thread#2 finish one cycle at 108: 0 cycles left
dispatch thread#11 at 108: allocated_time=4
thread#11 finish one cycle at 112: 4 cycles left
dispatch thread#8 at 112: allocated_time=4
dispatch thread#6 at 116: allocated_time=3
thread#6 finish one cycle at 119: 0 cycles left
dispatch thread#8 at 119: allocated_time=6
thread#8 finish one cycle at 125: 0 cycles left
dispatch thread#13 at 125: allocated_time=2
thread#13 finish one cycle at 127: 0 cycles left
dispatch thread#4 at 127: allocated_time=3
thread#4 finish one cycle at 130: 5 cycles left
dispatch thread#3 at 130: allocated_time=3
thread#3 finish one cycle at 133: 0 cycles left
dispatch thread#5 at 133: allocated_time=8
thread#5 finish one cycle at 141: 4 cycles left
dispatch thread#12 at 141: allocated_time=2
thread#12 finish one cycle at 143: 1 cycles left
dispatch thread#7 at 143: allocated_time=7
thread#7 finish one cycle at 150: 2 cycles left
dispatch thread#10 at 150: allocated_time=2
thread#10 finish one cycle at 152: 3 cycles left
dispatch thread#11 at 152: allocated_time=4
thread#11 finish one cycle at 156: 3 cycles left
run_queue is empty, sleep for 6 ticks
dispatch thread#4 at 162: allocated_time=3
thread#4 finish one cycle at 165: 4 cycles left
run_queue is empty, sleep for 7 ticks
dispatch thread#5 at 172: allocated_time=6
dispatch thread#12 at 178: allocated_time=2
thread#12 finish one cycle at 180: 0 cycles left
dispatch thread#5 at 180: allocated_time=2
thread#5 finish one cycle at 182: 3 cycles left
run_queue is empty, sleep for 1 ticks
dispatch thread#7 at 183: allocated_time=7
thread#7 finish one cycle at 190: 1 cycles left
run_queue is empty, sleep for 34 ticks
dispatch thread#4 at 224: allocated_time=2
dispatch thread#7 at 226: allocated_time=7
thread#7 finish one cycle at 233: 0 cycles left
dispatch thread#4 at 233: allocated_time=1
thread#4 finish one cycle at 234: 3 cycles left
run_queue is empty, sleep for 1 ticks
dispatch thread#5 at 235: allocated_time=8
thread#5 finish one cycle at 243: 2 cycles left
dispatch thread#10 at 243: allocated_time=2
thread#10 finish one cycle at 245: 2 cycles left
dispatch thread#11 at 245: allocated_time=4
thread#11 finish one cycle at 249: 2 cycles left
run_queue is empty, sleep for 37 ticks
dispatch thread#4 at 286: allocated_time=3
thread#4 finish one cycle at 289: 2 cycles left
run_queue is empty, sleep for 9 ticks
dispatch thread#5 at 298: allocated_time=8
thread#5 finish one cycle at 306: 1 cycles left
run_queue is empty, sleep for 17 ticks
dispatch thread#10 at 323: allocated_time=2
thread#10 finish one cycle at 325: 1 cycles left
run_queue is empty, sleep for 11 ticks
dispatch thread#11 at 336: allocated_time=4
thread#11 finish one cycle at 340: 1 cycles left
run_queue is empty, sleep for 8 ticks
dispatch thread#4 at 348: allocated_time=3
thread#4 finish one cycle at 351: 1 cycles left
run_queue is empty, sleep for 10 ticks
dispatch thread#5 at 361: allocated_time=8
thread#5 finish one cycle at 369: 0 cycles left
run_queue is empty, sleep for 41 ticks
dispatch thread#4 at 410: allocated_time=3
thread#4 finish one cycle at 413: 0 cycles left
dispatch thread#10 at 413: allocated_time=2
thread#10 finish one cycle at 415: 0 cycles left
run_queue is empty, sleep for 13 ticks
dispatch thread#11 at 428: allocated_time=4
thread#11 finish one cycle at 432: 0 cycles left
"""
    if not re.findall(expected, r.qemu.output, re.M):
        raise AssertionError('Output does not match expected output')

run_tests()
