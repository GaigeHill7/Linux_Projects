# Jump.sh — Script Explanation and Usage

This document explains what `scripts/Jump.sh` does, how to use it, and notes on its implementation.

## Overview

`Jump.sh` provides a `jump` function intended to be sourced into an interactive Bash shell session. It helps you move quickly to the nearest ancestor directory whose name matches an argument you provide. The function searches your current working directory (PWD) path from right to left and moves up to the matching ancestor.

## Location

- `scripts/Jump.sh` in this repository.

## Requirements

- Bash (uses `read -ra` arrays and other Bash-specific constructs). The script uses `#!/usr/bin/env bash` so that it can run on systems with `bash` in PATH.

## Usage

Source the script in your shell session so that the `jump` function is available and that it can use `cd` to change your current shell working directory:

```bash
# add to your ~/.bashrc or source manually
source /path/to/Linux_Projects/scripts/Jump.sh

# then use:
jump <directory-name>
```

Examples:

```
# Suppose your PWD is /home/gaige/work/projects/foo/bar
jump foo      # -> /home/gaige/work/projects/foo
jump projects # -> /home/gaige/work/projects
```

Notes:
- The function searches for the nearest matching ancestor; if the directory name appears multiple times in the path, `jump` will go to the closest one.
- If you run the script directly instead of sourcing it, it prints a helpful message telling you to source it and exits without changing directory.

## Return codes

- 0 — Success (changed directory)
- 1 — Missing argument (usage)
- 2 — Directory name not found in the current path
- 3 — `cd` failed

## Implementation details

- The function uses `IFS='/'` and `read -ra` to safely split `PWD` into an array `path_arr`.
- It locates the nearest (right-most) occurrence of the directory name by searching the array from the last element to the first.
- It constructs the destination path by appending `/..` the number of times equal to how many levels up are required.
- The function uses `cd "$cwd"` to avoid breaking on spaces and local variables to prevent environment pollution.
- The script uses `BASH_SOURCE` to detect whether it was sourced or executed and prints instructions (and exits) if executed directly.

## Edge cases & troubleshooting

- If `jump` prints an error that the directory name was not found, confirm your `pwd` and the directory name exactly.
- If you see a message about sourcing the script, add a `source` line to your shell startup file (`.bashrc` or `.profile`).
- `jump` assumes a conventional POSIX path. If you rely on unusual symbolic link setups, the path segments may not match what you expect.

## Contributing

- The function can be extended with flags (for example, `--first` or `--last` to control whether to go to the first or nearest match). Feel free to open a PR for behavior changes or tests.

# Jump.sh — quick navigation to ancestor directories

Jump.sh provides a small `jump` function that you can source into your interactive Bash session. The function moves your shell into the nearest (closest) ancestor directory matching the name you provide. It's convenient when you're several levels deep and need to move up to a parent by name.

---

## Location

- File: `scripts/Jump.sh`

---

## Overview

- `jump <directory-name>` looks for the nearest directory in your current working directory path with the given name and changes the shell into that directory.
- The function requires you to *source* the script (so the `cd` affects your current shell) via `source /path/to/Jump.sh` or by adding a `source` line to your `.bashrc`.
- If the directory name appears multiple times in your path, `jump` goes to the nearest ancestor (right-most occurrence).

---

## Usage

Sourcing the script into your shell session:

```bash
# Add to your ~/.bashrc or ~/.profile
if [ -f "$HOME/path/to/Linux_Projects/scripts/Jump.sh" ]; then
  source "$HOME/path/to/Linux_Projects/scripts/Jump.sh"
fi

# After sourcing, use:
jump <directory-name>
```

Examples:

```
# Starting PWD: /home/gaige/work/projects/foo/bar
jump foo    # -> /home/gaige/work/projects/foo
jump projects # -> /home/gaige/work/projects
```

Edge cases:
- If the directory name is not present in your CWD path, the function prints an error and returns with non-zero status.
- If called without argument, it prints usage.
- The script must be sourced for the `cd` to affect the caller's shell. If executed directly, an explanatory message is printed.

---

## Return codes

- 0: Success (changed directory)
- 1: Missing argument
- 2: Directory name not found in current path
- 3: `cd` failed (unlikely but possible when target is invalid)

---

## Implementation notes

- This function uses Bash features (arrays and `read -ra`), so it expects Bash.
- It parses `PWD` into an array using `IFS='/'` and searches from right-to-left for the nearest matching directory name.
- The function uses `cd` with proper quoting to support paths containing spaces.
- Temporary variables inside the function are declared `local` to avoid polluting the caller's shell.

---

## Examples & Testing

Try these quick tests:

```bash
# Start at /tmp/project/foo/bar/baz
cd /tmp/project/foo/bar/baz
jump foo   # -> /tmp/project/foo
jump project # -> /tmp/project
jump missing # -> prints error and returns non-zero
```

