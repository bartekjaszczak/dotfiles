# Arguments:
# no args: restore/create default brightness settings
# -d <value> | --decrease <value>: decrease brightness by <value> percent
# -i <value> | --increase <value>: increase brightness by <value> percent
# -s <value> | --set <value>: set brightness to <value> percent
# -p         | --previous: restore previous brighthess (can be used to automatically dim the screen and restore on mouse move)

# You can run this script without arguments at startup to restore the brightness settings.
# You can also bind this script to a keyboard shortcut to increase/decrease the brightness by, for example, 10 percent.

# The script will attempt to queue multiple instances of itself to prevent conflicts and enable key spamming.
# The script will update monitor configurations only if it hasn't been run for a whole minute.
# The script should update the brightness of all monitors that support DDC/CI (VCP 10 - monitor brightness).
# The call to ddcutil takes a few seconds to complete, so the script isn't very responsive and may not be suitable for real-time brightness adjustments.

# Assumptions:
# - ddcutil is installed, I2C is enabled, and all monitors support DDC/CI (especially VCP 10 - monitor brightness)
# - The user has permission to run ddcutil without sudo
# - The user has permission to read/write from and to /tmp and ~/.cache

import time
import sys
import subprocess
import os

LAST_UPDATED_TIME_THRESHOLD = 60  # How much seconds have to pass before the script will re-read the monitor IDs
DEFAULT_BRIGHTNESS = 100  # Percent
TIMEOUT = 60  # How long the script will wait for previous instances to finish in seconds

LAST_UPDATED_INCORRECT = 0
DEFAULT_MONITOR_IDS = [1, 2]

BRIGHTNESS_TMP_FILE_PATH = '/tmp/brightness_control_temp'  # Stores the last updated time and monitor IDs
BRIGHTNESS_LOCK_FILE_PATH = '/tmp/brightness_control_lock'  # Locks the brightness control to prevent multiple instances
BRIGHTNESS_VALUE_FILE_PATH = os.path.expanduser('~/.cache/brightness_control_value')  # Stores the current and previous brightness value


def get_current_brightness():
    try:
        with open(BRIGHTNESS_VALUE_FILE_PATH, 'r') as file:
            values = file.read().split()
            current = int(values[0])
            return max(0, min(100, current))
    except:
        return DEFAULT_BRIGHTNESS


def get_previous_brightness():
    try:
        with open(BRIGHTNESS_VALUE_FILE_PATH, 'r') as file:
            values = file.read().split()
            previous = int(values[1])
            return max(0, min(100, previous))
    except:
        return DEFAULT_BRIGHTNESS


def get_tmp_values():
    try:
        with open(BRIGHTNESS_TMP_FILE_PATH, 'r') as file:
            values = file.read().split()
            return float(values[0]), list(map(int, values[1:]))
    except:
        return LAST_UPDATED_INCORRECT, DEFAULT_MONITOR_IDS


def read_monitor_ids():
    result = subprocess.run(['ddcutil', 'detect'], stdout=subprocess.PIPE, text=True)

    output = result.stdout
    try:
        return [line.split()[1] for line in output.splitlines() if line.startswith("Display")]
    except:
        return DEFAULT_MONITOR_IDS


def get_monitor_ids():
    last_updated_time, monitor_ids = get_tmp_values()
    if time.time() - last_updated_time > LAST_UPDATED_TIME_THRESHOLD:
        monitor_ids = read_monitor_ids()
    return monitor_ids


def determine_new_brightness(current_brightness):
    if len(sys.argv) == 1:
        return current_brightness
    elif sys.argv[1] in ['-d', '--decrease'] and len(sys.argv) > 2:
        try:
            return max(0, current_brightness - int(sys.argv[2]))
        except:
            return current_brightness
    elif sys.argv[1] in ['-i', '--increase'] and len(sys.argv) > 2:
        try:
            return min(100, current_brightness + int(sys.argv[2]))
        except:
            return current_brightness
    elif sys.argv[1] in ['-s', '--set'] and len(sys.argv) > 2:
        try:
            return max(0, min(100, int(sys.argv[2])))
        except:
            return current_brightness
    elif sys.argv[1] in ['-p', '--previous']:
        return get_previous_brightness()


def update_brightness(new_brightness, monitor_ids):
    for monitor_id in monitor_ids:
        subprocess.run(['ddcutil', 'setvcp', '10', str(new_brightness), '--display', str(monitor_id)])


def write_brightness_settings(current, previous):
    os.makedirs(os.path.dirname(BRIGHTNESS_VALUE_FILE_PATH), exist_ok=True)
    with open(BRIGHTNESS_VALUE_FILE_PATH, 'w') as file:
        file.write(str(current) + ' ' + str(previous))


def write_tmp_values(monitor_ids):
    with open(BRIGHTNESS_TMP_FILE_PATH, 'w') as file:
        file.write(str(time.time()) + ' ' + ' '.join(map(str, monitor_ids)))


def lock_brightness_control():
    with open(BRIGHTNESS_LOCK_FILE_PATH, 'w') as file:
        file.write('')


def unlock_brightness_control():
    os.remove(BRIGHTNESS_LOCK_FILE_PATH)


def is_brightness_control_locked():
    return os.path.exists(BRIGHTNESS_LOCK_FILE_PATH)


def notify(brightness):
    if brightness <= 50:
        subprocess.run(['dunstify', '-a', 'brightness_control', '-u', 'low', '-i', 'brightness-low',
                        '-h', 'string:x-dunst-stack-tag:brightness_control',
                        '-h', 'int:value:' + str(brightness), 'Brightness: ' + str(brightness) + '%'])
    else:
        subprocess.run(['dunstify', '-a', 'brightness_control', '-u', 'low', '-i', 'brightness-high',
                        '-h', 'string:x-dunst-stack-tag:brightness_control',
                        '-h', 'int:value:' + str(brightness), 'Brightness: ' + str(brightness) + '%'])


def main():
    STEP = 0.2  # Every 0.2 sec
    try:
        if is_brightness_control_locked():
            for _ in range(int(TIMEOUT / STEP)):
                time.sleep(STEP)
                if not is_brightness_control_locked():
                    break
            else:
                return

        lock_brightness_control()
        brightness = get_current_brightness()
        monitor_ids = get_monitor_ids()
        new_brightness = determine_new_brightness(brightness)
        notify(new_brightness)
        update_brightness(new_brightness, monitor_ids)
        write_brightness_settings(new_brightness, brightness)
        write_tmp_values(monitor_ids)
    finally:
        unlock_brightness_control()


if __name__ == '__main__':
    main()
