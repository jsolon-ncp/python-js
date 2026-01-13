# How to in Python
## Maintain Python Installations 
- See [ReadMe](./readme.md) for initial installation

## Upgrade your global python installation installed by uv
- This example upgrades from 3.14 to 3.14.2
- To maintain only one python package, you have to delete the previously installed one.
- This shows how to uninstall the current version and Install the new one assuming you have gone through ReadMe and removed python versions installed by Homebrew, Conda, etc.
- Verify the installed python with `uv python list --only-installed`
- Identify the version you want to install with `uv python list`
- Uninstall with `uv python uninstall 3.14`
- Install with `uv python install 3.14.2 --default` ; using default automatcially creates symlinks

## Create a symlink to the python installation
- If you did not install wiht --default, it would be useful to create symlinks.
- Locate the uv installed python
- Run this code (note this is a sample)
```
ln -sf "$HOME/.local/share/uv/python/cpython-3.14.0-macos-x86_64-none/bin/python3.14" "$HOME/.local/bin/python3"
```
- Then `export PATH="$HOME/.local/bin:$PATH"`
- Then `source ~/.zshrc`
- Verify with `python3 --version`

## Create Python environments per repository with `uv`
- This script creates two virtual environments (.venv and .venv_stata)
- Default Packages are installed based on [requirements.txt](./requirements.txt) which includes pandas, numpy, matplotlib, ipython, and pyodk.  Modify accordingly. 
- In your project repository root run this:
```
# Replace 'main' with your default branch name if different
curl -fsSL https://raw.githubusercontent.com/<YOUR_GITHUB_USERNAME>/python-js/main/scripts/setup_py_uv.sh | bash
```

## Install Pyodk
- See [ReadMe](./readme.md).  The default NCP python installation should include pyodk
```
source ./env/.venv/bin/activate
uv pip install pyodk
```
Authenticate with ODK Central