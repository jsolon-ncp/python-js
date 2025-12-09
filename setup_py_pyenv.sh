#!/bin/bash
# ----------------------------------------------------------------------
# Python Environment Setup Script
# Creates and populates two isolated environments using pyenv and standard venv.
# ----------------------------------------------------------------------

# Exit immediately if a command exits with a non-zero status
set -e

PYTHON_VERSION="3.14"
REQUIREMENTS_FILE="requirements.txt"

echo "--- 1. Cleanup and Pre-Check ---"

# Remove any partially created or old virtual environments
rm -rf .venv
rm -rf .venv_stata
echo "Removed old .venv and .venv_stata directories."

# Check if the target Python version is installed via pyenv. If not, install it.
if ! pyenv versions --bare | grep -q "^$PYTHON_VERSION$"; then
    echo "Python $PYTHON_VERSION not found via pyenv. Installing now..."
    pyenv install $PYTHON_VERSION
    echo "Python $PYTHON_VERSION installed."
else
    echo "Python $PYTHON_VERSION is already installed via pyenv."
fi

# Dynamically find the absolute path to the pyenv-managed executable.
PYTHON_314_PATH=$(pyenv which python$PYTHON_VERSION)

if [ -z "$PYTHON_314_PATH" ]; then
    echo "Error: Could not find the Python $PYTHON_VERSION executable path via pyenv which."
    exit 1
fi

echo "Using stable Python executable at: $PYTHON_314_PATH"

# ----------------------------------------------------------------------
echo ""
echo "--- 2. Setup Standard Python Environment (.venv) ---"

# Create the virtual environment using the stable pyenv-managed Python
$PYTHON_314_PATH -m venv .venv
echo ".venv created successfully."

# Activate the .venv environment
source .venv/bin/activate

# Install requirements into the active .venv
echo "Installing requirements into .venv..."
pip install -r $REQUIREMENTS_FILE
echo "Packages installed in .venv."

# Deactivate the environment
deactivate
echo ".venv deactivated."

# ----------------------------------------------------------------------
echo ""
echo "--- 3. Setup Stata Python Environment (.venv_stata) ---"

# Create the Stata-specific virtual environment
$PYTHON_314_PATH -m venv .venv_stata
echo ".venv_stata created successfully."

# Activate the .venv_stata environment
source .venv_stata/bin/activate

# Install requirements into the active .venv_stata
echo "Installing requirements into .venv_stata..."
pip install -r $REQUIREMENTS_FILE
echo "Packages installed in .venv_stata."

# Final Verification: List packages in the active Stata environment
echo ""
echo "--- Final Verification: Packages in .venv_stata ---"
pip list

# Deactivate the environment
deactivate
echo ".venv_stata deactivated."

# ----------------------------------------------------------------------
echo ""
echo "--- 4. Final Instructions ---"
echo "SETUP COMPLETE!"
echo "Your two isolated environments, .venv and .venv_stata, are ready."
echo "You can now switch to Stata and configure your Python executable:"
echo "python set executable \"$PYTHON_314_PATH\" , permanently"
echo ""