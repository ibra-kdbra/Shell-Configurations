# General

- Scripts should start with `#!/bin/bash` (shebang).
- Best practice is to use `#!/usr/bin/env bash`.
- Use `chmod u+x` to make the file executable for its owner.
- Bash scripts run inside a non-interactive shell.
- It is possible to change options for the subshell with `set` or `shopt` in the script.

# Quotes

Quotes have a different effect on interpretation of scripts.

- Wrapping a command with single quotes will make bash interpret it as a literal string:
  ```bash
  'echo $(uname -r)'
  ```
- Using double quotes will allow bash to be reasonable about special characters while interpreting expansions correctly.

# Troubleshooting Tips

1. **Read errors carefully**
2. **Observe line numbers in errors**
   ```bash
   less -N myscript
   ```
3. **Check quotes and escaping**
   - Single quotes and double quotes work differently
4. **Check spacing in tests**
   - `[[$a-gt3]]` will fail but `[[ $a -gt 3 ]]` will work
5. **Check closure of expansions and substitutions**
6. **Remember that commands and variables are case sensitive**
7. **Use `set -x` to display commands as they run**
8. **Use `echo` statements throughout the script**
9. **Use `true` and `false` built-ins to troubleshoot logic**

# Script Portability Tips

1. **Check the user's Bash version before running the script**
   - Old Linux systems and Macs tend to have outdated versions of Bash
   - `$BASH_VERSION` and `$BASH_VERSINFO` contain version information
2. **Check if the user has nonstandard tools your script uses**
3. **Sometimes, it's useful to write scripts that also work with Bourne Shell (`sh`) for broader compatibility**
4. **Keep your scripts clear, readable, and well-commented for yourself and others**
5. **Decide how portable your script needs to be**

# Command Examples

1. `touch record_{0..5}{a..d}`

   Creates the following files:
   ```
   .
   ├── record_0a
   ├── record_0b
   ...
   └── record_5d
