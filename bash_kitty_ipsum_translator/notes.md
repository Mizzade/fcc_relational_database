
## Commands
### Piping and redirecting
- `>`: Redirect input into a file, replacing the content with the input. If target file does not exits, it will be created
- `2>`: Redirect from standart output (stdout) to error output (stderr).
```
$ echo "foo" > example.txt

# Should output:
# foo
```
- `>>`: Redirect input into a file, appending to the
```
$ touch example.txt
$ echo "foo" > example.txt
$ echo "bar" >> example.txt

# Should output:
# foo
# bar
```
end of the file.
- `|` pipe the output of a function as input to another function.
```
<func1> | <func2>
```

### echo
- -e: enable interpretation of backslash escapes

### wc
- `-m`: print character counts
- `-l`: print the newlines counts
- `-w`: print the word counts

### grep
- `-o`: --only-matching,  Print only the matched (non-empty) parts of a matching line, with each such part on a separate output line.
- `-n`: --line-number, Prefix each line of output with the 1-based line number within its input file.

- multiple patterns search: grep -E '<pattern_1>|<pattern_2>'

### sed
- Usage: `sed 's/<pattern>/<replacement>/<flags>' <input>`
- multiple patterns: `sed 's/<pattern_1>/<replacement_1>/; s/<pattern_2>/<replacement_2>/'`
- `-E`: --regexp-extended, use extended regular expressions in the script (for portability use POSIX -E).


### Examples
Grep all occurrences that start with 'meow' and prefix them with the line number.

```
$ grep -n meow[a-z]* kitty_ipsum_1.txt
```

Like above, but in addition keep only the line numbers and remove the rest.

```
$ grep -n meow[a-z]* kitty_ipsum_1.txt | sed -E 's/([0-9]+).*/\1/'
```

Note: `\1` references the first capture group in the regexp pattern.


Show only the matching parts of the pattern, effectively rendering each match on a new line.

```
$ grep -o cat[a-z]* kitty_ipsum_1.txt
```

### Bash
- `$1` will be the variable to access the first argument given to the script.

### diff
Compare files line by line

- `--color`: color output

