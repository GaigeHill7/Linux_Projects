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

