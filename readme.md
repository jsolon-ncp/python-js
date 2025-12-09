# John's Python Repository

There are multiple ways to manage Python versions, packages and environment.  Traditionally, this is done with `pyenv`, `pip`, and `venv`. Modern methods use `Poetry` (core language Python) or `uv` (core language Rust).  Best practice requires running python in a projects's own python environment.  Python and Stata environments should be separate to anticipate any incompatibilities with STata when Python is upgraded as these have occured in the past.  

## Principles
- NCP users must maintain the latest version of Python.
- Python virtual environments must always be used.
- Standard Requirements must include at least `numpy`, `pandas`, `matplotlib` and `ipython`.
- If it is anticipated that Python will be used, two virtual environments should be prepared for each repository (.venv and .venv_stata).
- All users must know how to install and manage Python versions, packages and environments using any method of their choice.
- The .venv_stata Stata environment is used by running in Stata  `python set exec pyexecutable` where pyexecutable is the absolute path to the python in .venv_stata.  

## Setup Python with `uv`
### Rationale
- Multi-functional and can do what `pyenv` (Manage Python versions) and `pip` (install packages) and `venv` (manage environments) can do
- Fast 

### Remove old Python versions 
#### Brew installed versions
- List python installations with brew `brew list | grep python`.  This may return python3.13 (used as an example)
- Optional :  the executable path for each python found `brew --prefix python@3.13`.  
- Uninstall : `brew uninstall python3.13` and repeat for each version found
- Cleanup dependencies : `brew autoremove`

#### Pyenv installed versions
- List python installations with `pyenv versions`.  Example result 3.13
- Uninstall with `pyenv uninstall 3.13`.  
- Comment out  `pyenv` references in .zshrc .  This avoids conflict in case you want to use `deactivate` to deactivate an environment.
  - Find .zshrc : `ls -a ~ | grep zshrc`
  - Open with vscodium `codium .zshrc` or `nano` and comment out the lines as below : 
```
#eval "$(pyenv init --path)"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
```
- Alteratively run  `sed -i '' '/pyenv/s/^/# /' ~/.zshrc`
#### Official Python Installer installations
- These cannot be removed with brew or pyenv
-  Find the Frameworks folder `ls -l /Library/Frameworks/Python.framework/Versions/` Assume 3.12 and Current->3.12
- Remove the python installation ` sudo rm -rf /Library/Frameworks/Python.framework/Versions/3.12`
- Remove the symlink `sudo rm  /Library/Frameworks/Python.framework/Versions/Current`

### Install uv
uv : `curl -LsSf https://astral.sh/uv/install.sh | sh`

### List installed python versions
- Show versions that can be installed `uv python list`
- Show installed versions `uv python list --only-installed` should show all installed python versions in case they have not been removed previously.
- Python in usr/bin/python3 were installed with the MacOS.  Leave that alone.

### Install with uv
- Install : `uv python install <version> --default`; adding `--default` creates executables python3 and python such that running these commands point to python3.14.
- Verify : `uv python list --only-installed`

## Install Python using `pyenv` 
- Only if you do not want to use `uv`
- Remove all other versions of Python as above see "Remove old Python versions"
- Install pyenv (Python Version Manager)
```
brew install pyenv
```
- Initialize pyenv 
```
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
echo 'eval "$(pyenv init -)"' >> ~/.zshrc
source ~/.zshrc
```
- Install Python
```
pyenv install 3.14.0
```
- Set this as the main python version
```
pyenv global 3.14.0
```
- Confirm python version
```
python --version
```
## Create Python environments per repository
- This script creates two virtual environments (.venv and .venv_stata)
- Default Packages are installed based on [requirements.txt](./requirements.txt) which includes pandas, numpy, matplotlib, ipython.  Modify accordingly. 
Make the shell script executable `chmod +x setup_py_uv.sh`
Run: `./setup_py_uv.sh`

