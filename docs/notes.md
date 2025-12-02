# Learning Python (NCP)
# References
- https://docs.python.org/3/tutorial/index.
- Data types https://pythononeliners.com/wp-content/uploads/2020/05/CheatSheet-Python-3-Complex-Data-Types.pdf 
- Classes : https://pythononeliners.com/wp-content/uploads/2020/05/CheatSheet-Python-4-Classes.pdf 
# Learning Objectives
## Install and Manage Python Integration with Stata (done)

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

