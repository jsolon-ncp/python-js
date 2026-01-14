# How to do things in Python

## Use uv for python, package and enviroment management
- `uv` is a multi-functional program that  can do what `pyenv` (Manage Python versions) and `pip` (install packages) and `venv` (manage environments) can do. It is faster than pyenv and allows us to master only one program instead of 3.
- Install uv : 
```
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## Remove old Python versions 
To have a clean Python installation, remove all older python versions except the one that comes with MacOS. 

### Remove Brew installed versions
- List python installations with brew 
```
brew list | grep python
```
- This may return python3.13 (used as an example)
- Uninstall with:
```
brew uninstall python@3.13
```
- Repeat for each version found
- Cleanup dependencies: 
```
brew autoremove
```

### Remove Pyenv installed versions
- List python installations via pyenv 
- Example output may include 3.13.x
```
pyenv versions
```
- Uninstall a specific python version
- Replace 3.13.x with the version you want to remove. 
- Repeat for any versions you no longer need. 
```
pyenv uninstall 3.13.x
```
### Disable pyenv in shell
To avoid conflicts with `uv`, virtual environments and `deactivate`, comment out  `pyenv` initialization in your shell configuration. 
- Locate your .zshrc 
```
ls -a ~ | grep zshrc
```
- Edit .zshrc 
```
nano ~/.zshrc
```
- Comment out the following lines if present
```
#eval "$(pyenv init --path)"
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
```
- Save and Exit
- Reload shell configuration
```
source ~/.zshrc
```
### Disable pyenv in shell automatically (Alternative)
```
sed -i '' '/pyenv/s/^/# /' ~/.zshrc
source ~/.zshrc
```

### Remove Official Python Installer installations
- These are installations from downloaded installers from the web.  These cannot be removed with brew or pyenv
-  Find the Frameworks folder 
-  Results can be 3.12.x
```
ls -l /Library/Frameworks/Python.framework/Versions/
``` 
Remove the Python installation (replace 3.12.x with the python version)
```
sudo rm -rf /Library/Frameworks/Python.framework/Versions/3.12.x
```
- Remove the symlink 
```
sudo rm  /Library/Frameworks/Python.framework/Versions/Current
```

### List installed python versions
- Show versions that can be installed:
```
uv python list
```
- Show installed versions in case they have not been removed previously: 
```
uv python list --only-installed
``` 
- Python in usr/bin/python3 were installed with the MacOS.  Leave that alone.

### Install with uv
- Principle : `uv python install <version> --default`; adding `--default` creates executables python3 and python such that running these commands point to the installed python version.
- Run this to ensure compatibility with pyodk as of Jan 2026. 
```
uv python install 3.13.11
```
- Verify installation: 
```
uv python list --only-installed
```

## Upgrade your global python installation installed by uv
- This example upgrades from 3.13.11 to 3.14.2
- To maintain only one python package, you have to delete the previously installed one.
- It is also okay to install both 3.13.11 and 3.14.2 and just choose which one will be applied to your .venv and .venv-stata
- This shows how to uninstall the current version and Install the new one assuming you have gone through ReadMe and removed python versions installed by Homebrew, Conda, etc.
- Verify the installed python with `uv python list --only-installed`
- Identify the version you want to install with `uv python list`
- Uninstall with `uv python uninstall 3.13.11`
- Install with `uv python install 3.14.2 --default` ; using default automatcially creates symlinks

## Create a symlink to the python installation
- If you did not install wiht --default, it would be useful to create symlinks.
- Locate the uv installed python
- Modify this code (note this is a sample)
```
ln -sf "$HOME/.local/share/uv/python/cpython-3.14.0-macos-x86_64-none/bin/python3.14" "$HOME/.local/bin/python3"
```
- Then `export PATH="$HOME/.local/bin:$PATH"`
- Then `source ~/.zshrc`
- Verify with `python3 --version`

## Create Python environments per repository with `uv`
### Create interactively (must know)
- To create an environment via uv, you need to define :
  - project root directory 
  - env directory ./env
  - names of the virtual environments - .venv and .venv-stata
  - name of requirements file - requirements.txt
- Note that :
  - `uv venv` is the key command
  - `./env/.venv` is the path to the venv you want to create
  - ``-- python python` is the python option of `uv venv` which define which python version to use.  By stating `-- python python` you are telling uv venv to use what your system calls `python` which was defined by your simlink which in turn is defined by your uv python installed version.  
  - in other words, if you want to have anohter python version in your .venv, you need to specify that (eg `uv venv ./env/.venv -- python python3.10`)
#### Python venv
```
uv venv ./env/.venv --python python 
source "./env/.venv/bin/activate"
uv pip install -r ./requirements.txt
```
#### Python venv for Stata
```
uv venv ./env/.venv-stata --python python
source "./env/.venv-stata/bin/activate"
uv pip install -r ./requirements.txt
```
### Create Python environments per repository with `uv` via script
- This script creates two virtual environments (.venv and .venv_stata) based on uv venv, activation and uv pip install sequence.  
- Default Packages are installed based on [requirements.txt](./requirements.txt) which includes pandas, numpy, matplotlib, ipython, and pyodk.  Modify accordingly. 
- In your project repository root run this:
```
# Replace 'main' with your default branch name if different
curl -fsSL https://raw.githubusercontent.com/<YOUR_GITHUB_USERNAME>/python-js/main/scripts/setup_py_uv.sh | bash
```

## Install Pyodk
- The default NCP python installation should include pyodk
- However, if you did not use that and you want to install pyodk to an existing venv found in ./env/.venv, do this: 
```
source ./env/.venv/bin/activate
uv pip install pyodk
```

## Work with your VSCodium or Visual Studio Code
- VSCodium will select a python interpreter to use for any repository (folder) you open.  If you do not set that for your repository, it may use the globally installed python 3.x.  If you project requires another version or another set of libraries, then your code would fail.  Therefore, it is important to tell your IDE that you are using a specific python interpreter located in your virtual environment 
- in VSCodium or Visual Studio Code, open the command Palette
- go to Python: Select Intepreter
- select Enter Intepreter path
- Enter the path to your .venv
- to easily find your path, activate your .venv and type `which python` and the result is your path to that interpeter