# Bash Scripting Interview Questions

### 1. What are pipes?
`|` - Pipes are used to send the output of one command as input to another.

### 2. What are redirects?
`>` `<` `>>` - Redirects are used to send the output of a command to a file, or use a file as input for a command.

### 3. Explain STDOUT, STDIN, STDERR.
- `STDIN` (0): Standard input, the default source of data for commands.
- `STDOUT` (1): Standard output, the default destination for a command's output.
- `STDERR` (2): Standard error, the default destination for error messages.

### 4. What are bash built-ins?
Commands that are built directly into the bash shell itself, not external programs.

### 5. What's the priority between commands and built-ins?
Bash will run a built-in if it has one, even if an external command with the same name is available.

### 6. What does the `help` command do?
Outputs the list of all available built-ins.

### 7. What are bash expansions and substitutions?
- `~`: Tilde expansion
- `{…}`: Brace expansion
- `${…}`: Parameter expansion
- `$(…)`: Command substitution
- `$((…))`: Arithmetic expansion

### 8. What does the `~` expansion do?
It represents the user's `$HOME` environment variable.

### 9. What does the `{…}` brace expansion do?
Creates sets of ranges.
- `echo /tmp/{one,two,three}/file.txt` -> `/tmp/one/file.txt /tmp/two/file.txt /tmp/three/file.txt`
- `echo {0..100}` -> `0 1 2 ... 100`

### 10. What does `${…}` parameter expansion do?
Retrieves and transforms stored values, most often used for working with variables.
- Pattern substitution: `echo ${greeting/there/everybody}`

### 11. What does `$(…)` command substitution do?
Puts the output of one command inside another.

### 12. What does `$((…))` arithmetic expansion do?
Performs integer arithmetic.

### 13. What is the difference between arithmetic expansion `$((…))` and arithmetic evaluation `((…))`?
- Expansion `$((...))` returns the result of the math operation.
- Evaluation `((...))` performs the calculation and changes the value of variables.

### 14. Can bash only do integer math?
Yes, natively. For more precise math, you can use `bc` or `awk`.

### 15. What kinds of mathematical operations does bash support?
`+`, `-`, `*`, `/`, `%` (modulo), `**` (exponentiation).

### 16. How to declare a variable that will always be a number?
`declare -i b=3`

### 17. How to get a random number in bash?
Use the `$RANDOM` variable.

### 18. What's an evaluation expansion `[...]`?
An alias for the `test` command, used to evaluate expressions and return an exit status (0 for true, 1 for false).

### 19. How can we read the value of an exit status?
Using the `$?` variable.

### 20. What is an extended test notation `[[...]]`?
An enhanced version of `[...]` that supports more features and is generally safer to use.

### 21. Will both commands be executed in `<command1> && ls`?
Only if `command1` returns a success (0) exit status.

### 22. What does an `-e` flag do in `echo -e ...`?
It interprets escaped characters like `\t`, `\n`, etc.

### 23. How would we alert a user with a bell character?
`echo -e "\a"`

### 24. How to output text using placeholders and formatting?
Using `printf "..." ...`.

### 25. Does bash support nested arrays?
No.

### 26. What types of arrays does bash support?
- Indexed arrays
- Associative arrays (maps)

### 27. How to use if statements in bash?
```bash
if (( condition )); then
    # things to do
elif (( condition )); then
    # things to do
else
    # things to do
fi
```

### 28. What kinds of loops are available in bash?
- `while`: Runs while a condition is true.
- `until`: Runs until a condition is true.
- `for`: Iterates through a list of items.

### 29. What if we declare a function after its call in a script?
It will fail. Functions must be declared before they are used.

### 30. What function variables are available?
- `$@`: Represents the list of arguments given to a function.
- `$FUNCNAME`: Represents the name of the function.

### 31. How to write and read text files in bash?
- Writing: `echo "abc" > out.txt` (overwrite), `echo "abc" >> out.txt` (append).
- Reading: `while read line; do echo $line; done < in.txt`

### 32. What are script arguments?
Values passed to a script from the command line, accessed via `$1`, `$2`, etc.

### 33. What are options in bash?
Flags (e.g., `-a`) used to pass information to a script, parsed with `getopts`.

### 34. What happens if we specify an option without a colon after it in `getopts`?
It's treated as a boolean flag that doesn't require a value.

### 35. How to gather input interactively?
Using the `read` command.

### 36. What is the `select` keyword used for?
To create a menu for the user to choose from a list of options.
