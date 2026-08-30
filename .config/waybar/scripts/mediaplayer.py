#!/usr/bin/env python3

import subprocess
import json

def get_metadata():
    try:
        status = subprocess.check_output(["playerctl", "status"], text=True).strip()
        if status.lower() != "playing":
            print(json.dumps({
                "text": "Pausado",
                "class": "paused",
                "alt": "paused"
            }))
            return

        artist = subprocess.check_output(["playerctl", "metadata", "artist"], text=True).strip()
        title = subprocess.check_output(["playerctl", "metadata", "title"], text=True).strip()
        player = subprocess.check_output(["playerctl", "metadata", "xesam:url"], text=True).strip()

        output = f"{artist} - {title}"

        print(json.dumps({
            "text": output,
            "class": "playing",
            "alt": "spotify" if "spotify" in player else "default"
        }))

    except subprocess.CalledProcessError:
        print(json.dumps({
            "text": " Nada reproduciéndose",
            "class": "stopped",
            "alt": "none"
        }))

get_metadata()
