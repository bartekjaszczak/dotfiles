#!/usr/bin/env python3

import sys
import subprocess


def practice(upper_boundary):
    if upper_boundary < 11:
        print("The upper boundary must be at least 11.")
        sys.exit(1)
    try:
        subprocess.call(["practicestuff", "--behavior-on-error=repeat", "--number-of-questions=10",
                        "times_table", "--upper-boundary-1=" + str(upper_boundary),
                         "--lower-boundary-2=11" "--upper-boundary-2=" + str(upper_boundary)])
    except KeyboardInterrupt:
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python practicestuff_times_table_new_up_to.py <number>")
        sys.exit(1)

    upper_boundary = sys.argv[1]
    practice(upper_boundary)
