# Bash Script Examples

This directory contains a small selection of [Bash](https://www.gnu.org/software/bash/) script examples for learning and reference purposes. The scripts are organized into categories based on their functionality.

## Table of Contents

- [Bash Script Examples](#bash-script-examples)
  - [Table of Contents](#table-of-contents)
    - [Basics](#basics)
    - [Input/Output](#inputoutput)
    - [Arguments and Options](#arguments-and-options)
    - [Interactive Validation](#interactive-validation)
    - [Control Structures](#control-structures)
    - [Utilities](#utilities)
    - [Games](#games)
    - [Docs](#docs)

---

### Basics

Fundamental Bash concepts.

- `variables_01.sh`: Demonstrates basic variable assignment for strings and numbers.
- `variables_02.sh`: Shows variable reassignment, read-only variables (`declare -r`), and case conversion (`declare -l`, `declare -u`).
- `if_statements.sh`: Illustrates `if`, `else`, and `elif` constructs using both extended test `[[...]]` and arithmetic evaluation `((...))`.
- `loops.sh`: Provides examples of `while`, `until`, and various `for` loop styles (range, array, command output).
- `arrays_01.sh`: Covers indexed and associative arrays, including creation, adding elements, and accessing them.
- `functions.sh`: Shows how to define and call functions, pass arguments, and use `$FUNCNAME`.
- `var_scopes.sh`: Explains the difference between global and local variables within functions.

### Input/Output

Scripts for file and data handling.

- `reading_files.sh`: Reads a file line by line using a `while` loop and input redirection.
- `writing_files.sh`: Appends lines to a file using a `for` loop and output redirection.
- `input.txt`: Sample input file for `reading_files.sh`.
- `output.txt`: Sample output file for `writing_files.sh`.

### Arguments and Options

Handling command-line parameters.

- `arguments.sh`: Accesses the first command-line argument (`$1`) and the script name (`$0`).
- `multiple_arguments.sh`: Iterates through all command-line arguments (`$@`) using a `for` loop.
- `options.sh`: Parses command-line options (with and without arguments) using `getopts`.
- `checking_number_of_arguments.sh`: Checks if the correct number of arguments (`$#`) is provided.

### Interactive Validation

User input and validation techniques.

- `interactive_input.sh`: Gathers user input using `read`, including silent input for passwords (`-s`) and prompts (`-p`).
- `input_validation.sh`: Validates user input using a regex match in an `until` loop.
- `ensuring_response_01.sh`: Uses `read -i` to provide a default value for user input.
- `ensuring_response_02.sh`: Uses a `while` loop with `-z` to ensure the user provides a non-empty response.

### Control Structures

Decision and selection constructs.

- `case.sh`: Demonstrates a `case` statement for simple pattern matching.
- `select_with_quit.sh`: Creates a `select` menu with an explicit "quit" option to exit the loop.
- `simple_select.sh`: Shows a basic `select` menu to let a user choose from a list of options.

### Utilities

Practical tools and formatting examples.

- `system_info.sh`: A script that prints a summary of system information like kernel version, free space, and memory.
- `fortune.sh`: A simple fortune-telling game that displays a random message.
- `slow_typer.sh`: A utility that reads from standard input and prints it out character by character with a delay, simulating typing.
- `alignment_01.sh`: Uses `printf` to demonstrate right, left, and zero-padded alignment of text and numbers.

### Games

Interactive entertainment scripts.

- `multigame.sh`: A three-in-one game application featuring a number guessing game, a coin flip, and a dice roll.

### Docs

Documentation and reference materials.

- [`notes.md`](./docs/notes.md): A text file with general notes, tips, and troubleshooting advice for Bash scripting.
- [`interview_questions.md`](./docs/interview_questions.md): A list of common Bash scripting interview questions and answers.
