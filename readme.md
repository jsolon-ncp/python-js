# John's Python Repository

## First steps

- Install or Upgrade Homebrew (MacOS Package Manager)
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

- Install uv (Python Package Manager)

