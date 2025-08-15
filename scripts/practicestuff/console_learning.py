#!/usr/bin/env python3

import sys
import random
from datetime import datetime

import practicestuff_doomsday
import practicestuff_powers_up_to
import practicestuff_times_table_only
import practicestuff_times_table_up_to
import practicestuff_times_table_new_up_to

# General config
RUN_EVERY_MINUTES = 15

POWERS_CHANCE = 0.2
TIMES_TABLE_CHANCE = 0.4
DOOMSDAY_CHANCE = 0.4

# Powers config
POWERS_QUESTION_COUNT = 10

POWERS_MAX = 21

# Doomsday config
DOOMSDAY_QUESTION_COUNT = 5

# Times table config
TIMES_TABLE_QUESTION_COUNT = 20

TIMES_TABLE_CURRENT = 13

TIMES_TABLE_INNER_CHANCE_ALL = 0.1
TIMES_TABLE_INNER_CHANCE_NEW_UP_TO = 0.6
TIMES_TABLE_INNER_CHANCE_NEW = 0.3


def should_run() -> bool:
    try:
        with open("/tmp/console_learning_last_run.txt", "r") as f:
            last_run = float(f.read().strip())
            last_run = datetime.fromtimestamp(last_run)

        now = datetime.now()
        return (now - last_run).total_seconds() >= RUN_EVERY_MINUTES * 60
    except FileNotFoundError:
        return True


def save_timestamp():
    with open("/tmp/console_learning_last_run.txt", "w") as f:
        f.write(str(datetime.now().timestamp()))


def main():
    if "--no-delay" not in sys.argv:
        if not should_run():
            return

    try:
        opt = random.random()
        if opt < DOOMSDAY_CHANCE:
            practicestuff_doomsday.practice(DOOMSDAY_QUESTION_COUNT)
        elif opt < DOOMSDAY_CHANCE + POWERS_CHANCE:
            practicestuff_powers_up_to.practice(POWERS_MAX, POWERS_QUESTION_COUNT)
        else:
            inner_opt = random.random()
            if inner_opt < TIMES_TABLE_INNER_CHANCE_NEW:
                practicestuff_times_table_only.practice(TIMES_TABLE_CURRENT,
                                                        TIMES_TABLE_QUESTION_COUNT)
            elif inner_opt < TIMES_TABLE_INNER_CHANCE_NEW + TIMES_TABLE_INNER_CHANCE_ALL:
                practicestuff_times_table_up_to.practice(TIMES_TABLE_CURRENT,
                                                         TIMES_TABLE_QUESTION_COUNT)
            else:
                practicestuff_times_table_new_up_to.practice(TIMES_TABLE_CURRENT,
                                                             TIMES_TABLE_QUESTION_COUNT)

    except KeyboardInterrupt:
        sys.exit(1)

    save_timestamp()


if __name__ == "__main__":
    main()
