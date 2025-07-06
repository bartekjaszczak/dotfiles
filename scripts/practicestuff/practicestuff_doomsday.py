#!/usr/bin/env python3

import sys
import subprocess


def practice(question_count: int):
    try:
        subprocess.call(["practicestuff", "--behavior-on-error=repeat",
                         "--number-of-questions=" + str(question_count), "doomsday"])
    except KeyboardInterrupt:
        sys.exit(1)


if __name__ == "__main__":
    pass
