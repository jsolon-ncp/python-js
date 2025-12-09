#!/bin/bash

# --- Configuration ---
# NOTE: The PYTHON_VERSION constant is kept to specify the target version for the venvs,
# but the script will rely on this version being available on the system PATH.
PYTHON_VERSION="3.14"

DEFAULT_VENV_NAME=".venv"
STATA_VENV_NAME=".venv_stata"
DEFAULT_REQUIREMENTS="requirements.txt"
STATA_REQUIREMENTS="requirements.txt"

# --- 1. Identify Python Interpreter ---
# Action: Removed 'uv python install' step.
# Relying on an existing Python 3.x interpreter being available on the system PATH.
# We use the version number constant to construct the expected executable name.
echo "1. Identifying Python interpreter (relying on system/managed install)..."
PYTHON_EXEC="python$PYTHON_VERSION"

# Check if the desired Python executable exists
if ! command -v "$PYTHON_EXEC" &> /dev/null
then
    echo "Error: Python executable '$PYTHON_EXEC' not found on the system PATH. Exiting."
    echo "Please ensure Python $PYTHON_VERSION is installed and accessible."
    exit 1
fi
echo "Found interpreter: $PYTHON_EXEC"
echo "--------------------------------------------------"

# --- 2. Create and Configure Default Environment (.venv) ---
echo "2. Creating and configuring default environment: $DEFAULT_VENV_NAME"

# Create the environment
uv venv --python "$PYTHON_EXEC" "$DEFAULT_VENV_NAME" || { echo "Error: Venv creation failed. Exiting."; exit 1; }

# Activate and Install Packages
if [ -f "$DEFAULT_REQUIREMENTS" ]; then
    # Source the environment's activate script to set the PATH
    source "$DEFAULT_VENV_NAME/bin/activate"
    
    echo "   -> Installing packages from $DEFAULT_REQUIREMENTS..."
    uv pip install -r "$DEFAULT_REQUIREMENTS" || { echo "Error: Package installation in $DEFAULT_VENV_NAME failed."; deactivate; exit 1; }
    
    # Deactivate the environment before moving on
    deactivate
    
    echo "   -> Packages installed successfully."
else
    echo "   -> Warning: $DEFAULT_REQUIREMENTS not found. Skipping package installation."
fi
echo "--------------------------------------------------"


# --- 3. Create and Configure Stata Environment (.venv_stata) ---
echo "3. Creating and configuring Stata environment: $STATA_VENV_NAME"

# Create the environment
uv venv --python "$PYTHON_EXEC" "$STATA_VENV_NAME" || { echo "Error: Stata venv creation failed. Exiting."; exit 1; }

# Activate and Install Packages
if [ -f "$STATA_REQUIREMENTS" ]; then
    # Source the environment's activate script
    source "$STATA_VENV_NAME/bin/activate"
    
    echo "   -> Installing packages from $STATA_REQUIREMENTS..."
    uv pip install -r "$STATA_REQUIREMENTS" || { echo "Error: Package installation in $STATA_VENV_NAME failed."; deactivate; exit 1; }
    
    # Deactivate the environment
    deactivate
    
    echo "   -> Packages installed successfully."
else
    echo "   -> Warning: $STATA_REQUIREMENTS not found. Skipping package installation."
fi
echo "--------------------------------------------------"

echo "✅ Setup complete. Both virtual environments are fully configured."