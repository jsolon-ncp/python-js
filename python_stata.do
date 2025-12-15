/* python.do
*/

* Setup Python Environments using pyenv .venv for python and .venv_stata for Stata Python

local repo_root "~/github/work/python-js" // MODIFY PER REPOSITORY
cd `repo_root'

! /setup_python_venv.sh // This is a shell script that set installs Python 3.14, and installs basic packages (pandas, numpy, matplotlib) and sets up two python environments

/*
set python_exec  ~/.pyenv/shims/python3.14, permanently
python: print("Initialization check")
python query 
*/

* Setup Stata environment in rpeository


* ----------------------------------------------------------------------
* PORTABLE PYTHON EXECUTABLE SETUP
* ----------------------------------------------------------------------
local venv_exec : shell(echo "$(pwd)/.venv_stata/bin/python")

if "`venv_exec'" == "" {
    display as error "ERROR: Could not resolve the absolute path to the .venv_stata/bin/python executable."
    exit 1
}

python set executable "`venv_exec'" , permanently

display as text "Successfully set Stata Python executable to the portable path:"
display as result "`venv_exec'"






python set exec "/Users/juansolon/github/work/python-js/.venv_stata/bin/python" , permanently
python: print("Initialization check")
python query 

*Verify Environment
python:
import pandas as pd
import numpy as np

print("✅ SUCCESS: Python is running from the .venv_stata environment.")
print(f"   Using Pandas version: {pd.__version__}")
print(f"   Using NumPy version: {np.__version__}")
end



* Setup Environment using uv

python: import pandas as pd; print(f"Pandas version: {pd.__version__}")


set python_exec /Users/juansolon/.local/share/uv/python/cpython-3.14.0-macos-x86_64-none/bin/python3.14, permanently 
python query
python: print("Initialization check")

/* Navigate ot the python-js repository*/

cd ~/github/work/python-js


* Setup two environments, one for python and one for python within stata

! uv init // creates a project directory at root for use with uv

* Creates a virtual environment for Python 

! uv venv .venv --python 3.14

* Activates .venv 
! source .venv/bin/activate

* Installs basic libraries Pandas, Numpy, Matplotlib
! uv pip install -r requirements.txt // uv looks for the active environment and if that doesn't exist, it looks for .venv

* Creates a virtual environment for Stata Python ; Activates and Installs Requirements

! uv venv .venv_stata --python 3.14
! source .venv_stata/bin/activate
! uv pip install -r requirements.txt // uv looks for the active environment and if that doesn't exist, it looks for .venv

*
python: import sys; print(sys.executable)

set python_exec "/Users/juansolon/.local/bin/python" , permanently
python: import sys; print(sys.executable)
python query

* Confirm Pandas, Numpy
python: import pandas as pd; print(f"Pandas version: {pd.__version__}")

* --- CONFIGURE STATA PATH ---

* 2. Point Stata to the executable inside the new venv.
* The executable path is relative to the directory where you run the .do file.
python set path "./venv_stata/bin/python"

* 3. Optional: Verify the setup
python query


sysuse auto
collect: reg mpg price
collect_to_frame results
