#!/usr/bin/env python3

import sys
import random

import practicestuff_doomsday
import practicestuff_powers_up_to
import practicestuff_times_table_only
import practicestuff_times_table_up_to
import practicestuff_times_table_new_up_to

OPTIONS = 3
POWERS_MAX = 20
TIMES_TABLE_CURRENT = 11


def main():
    try:
        opt = random.randint(1, OPTIONS)
        if opt == 1:
            practicestuff_doomsday.practice()
        elif opt == 2:
            practicestuff_powers_up_to.practice(POWERS_MAX)
        elif opt == 3:
            inner_opt = random.randint(1, 3)
            if inner_opt == 1:
                practicestuff_times_table_only.practice(TIMES_TABLE_CURRENT)
            elif inner_opt == 2:
                practicestuff_times_table_up_to.practice(TIMES_TABLE_CURRENT)
            elif inner_opt == 3:
                practicestuff_times_table_new_up_to.practice(TIMES_TABLE_CURRENT)

    except KeyboardInterrupt:
        sys.exit(1)


if __name__ == "__main__":
    main()
