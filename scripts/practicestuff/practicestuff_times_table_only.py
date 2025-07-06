#!/usr/bin/env python3

import sys
import subprocess


def practice(upper_boundary: int, question_count: int):
    try:
        subprocess.call(["practicestuff", "--behavior-on-error=repeat",
                         "--number-of-questions=" + str(question_count),
                         "times_table", "--lower-boundary-1=" + str(upper_boundary),
                         "--upper-boundary-1=" + str(upper_boundary),
                         "--upper-boundary-2=" + str(upper_boundary)])
    except KeyboardInterrupt:
        sys.exit(1)


if __name__ == "__main__":
    pass
