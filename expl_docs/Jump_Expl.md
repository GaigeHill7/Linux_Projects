# Jump.sh Explanation

## Overview
`Jump.sh` is a Bash script that defines a function called `jump`, which allows you to quickly navigate to a parent directory in your current path by specifying the directory name.

## How It Works
- The function splits your current working directory (`$PWD`) into its component directories.
- It loops through each directory in the path.
- When it finds a directory that matches the argument you provide, it calculates how many levels up it needs to go to reach that directory.
- It then changes the directory (`cd`) to that location.

## Usage
1. **Source the script:**

   source /path/to/Jump.sh
   - This is necessary, because it does not run a child process which cannot change current terminal. It works as if its saying "Read the commands inside this file as if I typed them directly into this terminal right now"

2. **Use the function:**

   jump <directory_name>

   For example, if your current path is `/home/user/projects/scripts` and you run `jump user`, you will be taken to `/home/user`.

## Script Breakdown
- **IFS Manipulation:** Temporarily changes the Internal Field Separator to split the path.
- **Array Handling:** Stores each directory in an array for easy access.
- **Loop & Match:** Finds the target directory and calculates how many `..` are needed to reach it.
- **Directory Change:** Uses `cd` to move to the desired directory.

## Notes
- Only the first match is used if the directory name appears multiple times in the path.
- The script must be sourced, not executed, to affect your current shell session.
- Works in Bash environments.

---
*This document explains the logic and usage of `Jump.sh` for quick directory navigation.*
