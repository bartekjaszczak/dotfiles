#!/usr/bin/env python3

import sys
import subprocess


def practice():
    try:
        subprocess.call(["practicestuff", "--behavior-on-error=repeat", "--number-of-questions=3",
                         "doomsday"])
    except KeyboardInterrupt:
        sys.exit(1)


if __name__ == "__main__":
    practice()
