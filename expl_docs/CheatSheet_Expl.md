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

## Usage

Make the script executable (once):

```bash
chmod +x scripts/CheatSheet.sh
```

Run a specific section:

```bash
./scripts/CheatSheet.sh files
./scripts/CheatSheet.sh network
./scripts/CheatSheet.sh processes
```

If you run the script without an argument or with an unrecognized argument, it will print the usage message:

```bash
Usage: ./scripts/CheatSheet.sh {files|network|processes}
```

### Helpful shortcuts

- Add a short alias in your shell config (`~/.bashrc`, `~/.zshrc`):

```bash
alias cs='./scripts/CheatSheet.sh'
```

Then run `cs files` from the repo root.

## Extension Ideas

- Add a `--help` flag or `-h` to display usage and available sections.
- Add a `list` section or `--list` switch to display all available sections programmatically.
- Switch to `case` statements for clearer multi-case logic and easier additions.
- Support multiple sections or `--all` to print all sections at once.
- Output formatting (colors or column layout) for readability using `tput` or `printf`.

## Example Improvements (small sample)

1. Use proper `case` for readability and easier expansion:

```bash
case "$section" in
	files)
		# print files
		;;
	network)
		# print network
		;;
	processes)
		# print processes
		;;
	*)
		echo "Usage: $0 {files|network|processes}"
		;;
esac
```

2. Add an `--all` mode:

```bash
if [ "$section" == "all" ]; then
		# print everything
fi
```

## Notes & Tips

- Some commands listed (e.g., `ifconfig`, `netstat`) are legacy on modern Linux and have replacements (`ip`, `ss`). Consider including both variants.
- The script is intended as a simple helper; it does not attempt to detect whether a command exists on the system.

## License & Attribution

Add your name (or the project's) and license if you wish to clarify usage, e.g. MIT License or CC0. This repository does not currently include a per-file license; consider adding `LICENSE` to the root if required.

---

If you'd like, I can now automatically add this file to the repository and commit (and push) the change — let me know whether I should go ahead. ✅

