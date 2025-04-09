#!/usr/bin/env python3

import sys
import subprocess


def practice(upper_boundary):
    try:
        subprocess.call(["practicestuff", "--behavior-on-error=repeat", "--number-of-questions=5",
                         "powers", "--upper-boundary=" + str(upper_boundary)])
    except KeyboardInterrupt:
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python practicestuff_powers_up_to.py <number>")
        sys.exit(1)
    upper_boundary = sys.argv[1]
    practice(upper_boundary)
