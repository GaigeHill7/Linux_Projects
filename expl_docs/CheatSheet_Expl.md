# CheatSheet.sh — Script Explanation and Usage

This document explains what `scripts/CheatSheet.sh` does, how to use it, and suggestions for improvement.

## Overview

`CheatSheet.sh` is a small Bash script that prints short cheat-sheet sections for common Linux commands. It takes a single argument (a section name) and prints the commands relevant to that section.

## Location

The script lives at `scripts/CheatSheet.sh` in this repository.

## How it Works

- The script starts with the bash shebang: `#!/bin/bash`.
- It reads a single command-line argument into the `section` variable (`section="$1"`).
- The script uses an `if / elif / else` block to pick which group of commands to display based on the `section` argument.
- If the provided `section` is not recognized, the script prints a usage message.

### Script Behavior (broken down)

- `section="$1"` — Captures the first argument (e.g., `files`, `network`, `processes`).
- `if [ "$section" == "files" ]; then` — Bash conditional to match the `files` section and display file-related commands.
- `elif [ "$section" == "network" ]; then` — Displays network-related commands.
- `elif [ "$section" == "processes" ]; then` — Displays process-related commands.
- `else` — Shows the usage message if the argument is not valid.

Note: Using `==` for string comparison is fine in `bash` (as the script uses `#!/bin/bash`), but generally `=` is more portable for POSIX `sh`. Since the shebang specifically invokes `bash`, `==` is acceptable here.

## Available Sections & Commands

1. files
	 - `ls` — List directory contents
	 - `cp` — Copy files and directories
	 - `mv` — Move or rename files and directories
	 - `rm` — Remove files or directories

2. network
	 - `ping` — Check network connectivity
	 - `ifconfig` — Display network interfaces (legacy, consider `ip addr` on modern systems)
	 - `netstat` — Show network status (can be replaced by `ss` on modern systems)
	 - `curl` — Transfer data from or to a server

3. processes
	 - `ps` — Display current processes
	 - `top` — Show real-time system processes
	 - `kill` — Terminate a process
	 - `htop` — Interactive process viewer

## Note :
    Make script an executable in Linux:
        - chmod +x filename.sh
    Move to usr/local/bin to allow you to run from any directory:
        - mv CheatSheet /usr/local/bin



