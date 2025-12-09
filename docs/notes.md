# Learning Python (John)
# References
- https://docs.python.org/3/tutorial/index.
- Data types https://pythononeliners.com/wp-content/uploads/2020/05/CheatSheet-Python-3-Complex-Data-Types.pdf 
- Classes : https://pythononeliners.com/wp-content/uploads/2020/05/CheatSheet-Python-4-Classes.pdf 
- Free ebook : [Automate the Boring Stuff](https://automatetheboringstuff.com/#toc)

# Learning Objectives
## Install and Manage Python Integration with Stata (done)
## Understand basic operations , strings and lists (done)
## Construct If else statements and flow control 

# Notes on Lessons
## Python Installation and Integration
- Goal: Maintain the latest version of Python and the MacOS installed version.
- Goal: Setup Stata to use the latest Python version
### 1. Upgrade or install package managers  
  - Homebrew : `brew update` ; `brew upgrade`
  - Pyenv : `brew upgrade pyenv` 
  - uv : `curl -LsSf https://astral.sh/uv/install.sh | sh`
  - This will be my preferred manager for python, packages and virtual environments
### 2. List installed python versions
- `uv python list --only-installed` shows all python versions installed in your mac and the paths to those verions including symbolic links.
- Python in usr/bin/python3 were installed with the MacOS.  Leave that alone.
- You can copy the output for entering in Gemini to come up with the sudo rm commands to remove the packages that have to be manually removed.  
### 3. Remove unwanted Python versions
- Remove pyenv installed versions : `pyenv versions` will list all pyenv installed python.  Then, uninstall all the versions listed using  `pyenv uninstall 3.#.#`.
- Remove Homebrew installed versions `brew list | grep python`.  Then, uninstall by `brew uinstall python@3.##` If there is an error, these must be removed manually using `sudo rm`, see below.
- Python versions found in various directories
  - Here is the sample code to remove packages  
    - directory : /Library/Frameworks/Python.framework/Versions/3.10/bin/python3.10
    - code : `sudo rm /Library/Frameworks/Python.framework/Versions/3.10/bin/python3.10`
    - symlink: `/usr/local/bin/python3.10 -> ../../../Library/Frameworks/Python.framework/Versions/3.10/bin/python3.10`
    - code to remove symlink : `sudo rm /usr/local/bin/python3.10`
### 4 Verify remaining Python versions
- Check what remains with `uv python list --only-installed`
- This should leave you with only one versions, the one in usr/bin/python3 which is installed by the MacOS.
### 5. Install python with uv
- Find all available versions of python using `uv python list`
- The latest version of python can be installed by `uv python install --default`; adding `--default` creates executables python3 and python such that running these commands point to python3.14.
### 6. Setup Stata Python to use preferred version
- Following above, run `which python` in Terminal to show you the location of the stable generic symlink which points to your latest version.
- In my OS, : `/Users/juansolon/.local/bin/python` 
- In Stata `python set exec "/Users/juansolon/.local/bin/python" , permanently`
- In Stata, run `python query` to show the current python settings and this should show the path above and the desired latest version for python (not the macOS installed version)
### 7. Using Python from R
- The reticulate package in R allows R to use python modules, classes and functions.  
- Reticulate uses the python version found on your PATH which can be found wiht `which python`  
- Given the previous set-up above, R would use python 3.14

## Basic Intro to numbers, text and lists
- [Python Informal Introduction](https://docs.python.org/3/tutorial/introduction.html#using-python-as-a-calculator)
- single or double quotes are equivalent and are used to enclose literal strings
- escaping a quote with `\` or another a different type of quote than the quote enclosing the text `'doe` or `"doesn't"`
- triple quotes ``` or """ declares a multiline string literal
- strings can have prefixes immediately before the first quote.  These prefixes are `r`, `f`, `b`, `u` and the first two will have examples below.
   - r = raw strings ignores escape characters. Use Case: Windows file paths; Regular Expressions 
```
>>> print("Hello\nWorld")
Hello
World

>>> print(r"Hello\nWorld")
Hello\nWorld
```
   - raw strings and regular expressions  

| Problem             | Symbol | Escape Sequence                    | Regular Expression                        |
|:--------------------|:-------|:-----------------------------------|:------------------------------------------|
| Conflicting meaning | \n     | Render a line break                | Match the non-printable newline character |
| False friends       | \b     | Move the cursor back one character | Match a word boundary                     |
| Invalid syntax      | \d     | Not applicable                     | Match any digit character                 |

   - f = formatted string literals can be used to evaluate expressions inside string literals.  Use case : insert data in text.
```
   >>> name = "Jane"
   >>> age = 25
   >>> f"Hello, {name}! You're {age} years old."
   'Hello, Jane! You're 25 years old.'
```
   
### Manipulating Strings
- Concatenate with `+` or by placing strings beside each other ; 
- repeat strings with `*`
- strings are zero indexed and a `-` is used to count from the right
- strings can be sliced using [#:#]; an omitted first index defaults to zero and an omitted second index defaults to the maximum length
- The Python Standard Library as built-in [Text Processing Services](https://docs.python.org/3/library/text.html#textservices) which cover string functions and regular expressions.  

### Lists 
- A list is an ordered sequence of comma-delimited values enclosed in quotes all of which are enclosed in square-brackets  `['item1','item2','item3']`.
- A list is also called list value and values inside a list are called items. 
- Items in a list are zero-indexed which means that the first item has a position of zero.  
- Lists can be nested, as are their indices.  Thus in the example below `matrix[1][2]` should result in 6. 
- While there is no limit to depth of nesting, practical limits are 2 (a table) or 3 (a series of tables)
```
# A list of lists representing a 3x3 grid
matrix = [
    [1, 2, 3],  # Row 1
    [4, 5, 6],  # Row 2
    [7, 8, 9]   # Row 3
]

print(matrix)
# Output: [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
print(matrix[1][2])
# Output: 6
```
## Basic Programming
### Flow Control
- notes from python tutorial 3.2 First steps toward programming 
-  Comparators 
  - < (less than), > (greater than), == (equal to), <= (less than or equal to), >= (greater than or equal to) and !=
- Body of the loop must be indented
- flow control statements start with a condition followed by clauses as blocks of code.  
#### Statements (https://docs.python.org/3/tutorial/controlflow.html#) (https://automatetheboringstuff.com/3e/chapter2.html)
- while (execute repeatedly while condition is true; cyclical and iterative; loops may be infinite)
- if (execute zero or once if condition is true)
- for (equivalent to stata's foreach and forvalues)
- range (can be used with for the way forvalues is used) 
```
# range(1, 5) generates the sequence 1, 2, 3, 4
for i in range(1, 5):
    square = i * i
    print(f"The square of {i} is {square}")
```
- break and continue (works within for and while) - see the table for use cases  

| Keyword  | Use Case                                      | Purpose/Goal                                                                                                               | Example Scenario                                                                                                                   |
| :------- | :-------------------------------------------- | :------------------------------------------------------------------------------------------------------------------------- | :--------------------------------------------------------------------------------------------------------------------------------- |
| break    | Stopping an Unbounded Loop (e.g., User Input) | To exit a while True loop only when valid data is received, preventing an infinite loop.                                   | Continuously ask the user for a number until they enter a value between 1 and 10.                                                  |
| break    | First Match Found (Search Efficiency)         | To maximize efficiency by terminating a loop once the required item is located in a list, database cursor, or file.        | Searching a file for a specific error code; once the code is found, stop reading the rest of the file.                             |
| break    | Error/Boundary Condition                      | To terminate processing if a critical error or unexpected state is encountered mid-loop.                                   | Processing data packets in a stream; if a packet fails checksum validation, stop the entire process.                               |
| continue | Filtering/Skipping Bad Data                   | To skip processing elements that do not meet specific criteria, maintaining the loop's overall execution.                  | Iterating through sensor readings; use continue to skip any reading marked as None or out-of-range before performing calculations. |
| continue | Complex Nested Condition Simplification       | To reduce nested if statements by handling simple "skip" conditions at the top of the loop.                                | Skip processing if a file is empty, rather than wrapping the entire rest of the loop body in a large if file_is_not_empty: block.  |
| continue | Separating Logic                              | To ensure certain cleanup or logging actions occur at the end of every iteration, even if the main processing was skipped. | Skip processing a duplicate entry (continue), but still allow a final log line (placed after the continue) to run for every item.  |

- else 
  - an else clause is run after the natural completion of loop using for (after the final iteration) or while(when the condition becomes false).  A break will result in an else clause not being run.  
- pass does nothing; it can be used as a placeholder
- match takes a pattern and compares it with a subject.  The subject is defined by match and the pattern is defined by case.  The match statement evaluates the case blocks sequentially and stops at the first match.  
```
def http_error(status):
    match status:
        case 400:
            return "Bad request"
        case 404:
            return "Not found"
        case 418:
            return "I'm a teapot"
        case _:
            return "Something's wrong with the internet
```

