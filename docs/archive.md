## For reference only : Install Python using `pyenv` 
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