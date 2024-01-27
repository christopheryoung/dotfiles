#!/opt/homebrew/bin/python3
"""
Note: Very simple wrapper for monolith

Do

chmod +x /Users/young/code/dotfiles/bin/capture.py
ln -s /Users/young/code/dotfiles/bin/capture.py /Users/young/bin/capture

in order to be able to call this easily.

"""
import datetime
import pathlib
import subprocess
import sys
import webbrowser


HOME = pathlib.Path.home()
CAPTURE_LOCATION = HOME / "code/historia/webcaptures"


def get_name(to_capture):
    url = pathlib.Path(to_capture)
    base_name = url.stem
    now = datetime.datetime.now()
    full_name = pathlib.Path(f'{base_name}@{now:%Y-%m-%d-%H-%M-%S}.html')
    return full_name


def main(to_capture):
    fname = get_name(to_capture)
    cmd = ["monolith", to_capture, "-a", "-e", "-I", "-o", str(fname)]
    result = subprocess.run(cmd, cwd=CAPTURE_LOCATION, capture_output=True, text=True)
    full_path = CAPTURE_LOCATION / fname
    if full_path.exists():
        webbrowser.open_new(full_path.as_uri())
    else:
        print(f"Failed to archive {to_capture}")


if __name__ == '__main__':
    to_capture = sys.argv[1]
    main(to_capture)
