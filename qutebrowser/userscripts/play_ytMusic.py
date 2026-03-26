#!/usr/bin/env python3

import sys
import subprocess
import os

# Get the current URL from qutebrowser
url = os.environ.get('QUTE_URL')

if not url:
    print("Error: QUTE_URL is not set. Make sure this script is run inside qutebrowser.")
    sys.exit(1)

# Match YouTube Music playlist URL
if 'music.youtube.com/playlist' in url:
    # Clean URL and launch with mpv
    mpv_command = ['mpv', url]
    
    try:
        subprocess.Popen(mpv_command)
        print(f"Opening playlist in mpv: {url}")
    except Exception as e:
        print(f"Error launching mpv: {e}")
        sys.exit(1)
else:
    print(f"Not a valid YouTube Music playlist: {url}")
    sys.exit(1)
