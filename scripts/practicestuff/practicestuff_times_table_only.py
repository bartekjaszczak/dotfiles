#!/usr/bin/env python3

import sys
import subprocess


def practice(upper_boundary):
    try:
        subprocess.call(["practicestuff", "--behavior-on-error=repeat", "--number-of-questions=10",
                         "times_table", "--lower-boundary-1=" + str(upper_boundary),
                         "--upper-boundary-1=" + str(upper_boundary),
                         "--upper-boundary-2=" + str(upper_boundary)])
    except KeyboardInterrupt:
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python practicestuff_times_table_only.py <number>")
        sys.exit(1)

    upper_boundary = sys.argv[1]
    practice(upper_boundary)
