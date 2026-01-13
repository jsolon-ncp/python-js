# John's Python Repository

This repository will document how to use python from 
- installation of the required NCP python version
- creation of environments for python 
- use of python for core tasks 

## Organization
- Read Me shows basic principles
- Documentation in ./docs
- Environments in ./env
- Shell scripts in ./scripts
- Python code (.py) in ./src/python
- Issues in NCP Discord [all-python forum](https://discord.com/channels/1440712482510475419/1446090175515066460)

## Basic Principles
- NCP users must maintain the latest version of Python that allows the installation of all libraries required.  As of Jan 2026, this should be Python 3.13.11 because of incompatibilities of pyodk with 3.14.
- Python virtual environments must always be used.
- Standard Requirements must include at least `numpy`, `pandas`, `matplotlib` `ipython`, and `pyodk`
- If Python will be used, create two python environments, in your repository using  (.venv and .venv_stata) using the script `./scripts/setup_py_uv.sh`.
- Python versions, packages and environments will be managed using `uv` only.  Use of other installations should have similar documentation (eg `pyenv` or `conda installations`) to be written by those who use them.
- The .venv_stata Stata environment is used by running in Stata  `python set exec pyexecutable` where pyexecutable is the absolute path to the python in .venv_stata.  

See docs/howto for 

## Setup Python with `uv`
### Rationale
- Multi-functional and can do what `pyenv` (Manage Python versions) and `pip` (install packages) and `venv` (manage environments) can do
- Fast 

### Remove old Python versions 
#### Brew installed versions
- List python installations with brew `brew list | grep python`.  This may return python3.13 (used as an example)
- Optional :  the executable path for each python found `brew --prefix python@3.13`.  
- Uninstall : `brew uninstall python@3.13` and repeat for each version found
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
``

## Create Python environments per repository with `pyenv`
- Make script executable `chmod +x ./scripts/setup_py_pyenv.sh`
- Run : `./scripts/setup_py_pyenv.sh`

# Notes on Project Repository Directories
## Basic Rules
- Data lives in ./data
- Outputs live in ./tables or ./figures or ./outputs/tables or ./outputs/figures
- Environment are in ./env, separated by language (.venv for python, .venv-stata for python via stata, renv, profile.do)
- Logs are in ./logs
- Documentation is in ./docs
- Configurations are in ./config
- .gitignore ignores ./data and ./config
- Code live in ./scripts and ./src (where src = source )
  - in ./scripts are code that orchestrates the project tasks
  - in ./src are task specific code per language scripts to follow programming convention.  src = source.

  This repository will follow that structure.  Note that the setup_py_uv.sh does not yet follow this structrue (Jan 12 2025)

##

