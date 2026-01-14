# Python Repository

This repository will document how to use python  
- installation of the required NCP python version
- creation of environments for python 
- use of python for core tasks 

## Organization
- Read Me shows basic principles
- All documentation in ./docs
- How to do tasks in the [How To Document](./docs/howto.md) 
- Environments in ./env
- Shell scripts in ./scripts
- Python code (.py) in ./src/python
- Issues in NCP Discord [all-python forum](https://discord.com/channels/1440712482510475419/1446090175515066460)

## How to use this repository
- Read Basic Principles below
- Read Goals below
- Implement [How To Document](./docs/howto.md)

## Basic Principles
- NCP users must maintain the latest version of Python that allows the installation of all libraries required.  As of Jan 2026, this should be Python 3.13.11 because of incompatibilities of pyodk with 3.14.
- Python virtual environments must always be used.
- Standard Requirements must include at least `numpy`, `pandas`, `matplotlib` `ipython`, and `pyodk`
- If Python will be used, create two python environments, in your repository using  (.venv and .venv_stata) using the script `./scripts/setup_py_uv.sh`.
- Python versions, packages and environments will be managed using `uv` only.  Use of other installations should have similar documentation (eg `pyenv` or `conda installations`) to be written by those who use them.
- The .venv_stata Stata environment is used by running in Stata  `python set exec pyexecutable` where pyexecutable is the absolute path to the python in .venv_stata.  

## Goals (defined in Jan 12 2026 Mtg)
- Install Python 
- Create project environments
- Configure your IDE to use the correct python interpter (added Jan 14)
- Import data from ODK Central using pyodk
- Managing ODK Central using pyodk
  - Adding Users for App
  - Adding Web Users and Roles
  - Creating the QR Codes
  - Sending the email
- Dashboard with Python / R
  - On our machines
  - Setup on ODK Server

# Notes on Project Repository Directories
## Basic Rules for this repository
- Root contains files otherwise not classified or required to be at root
- Data in ./data
- Outputs in ./tables or ./figures 
- Environment are in ./env, separated by language (.venv for python, .venv-stata for python via stata, renv, profile.do)
- Logs in ./logs
- Documentation  in ./docs
- Configurations are in ./config
- .gitignore ignores ./data and ./config
- Code live in ./scripts and ./src (where src = source )
  - in ./scripts are code that orchestrates the project tasks
  - in ./src are task specific code per language scripts to follow programming convention.  src = source.

