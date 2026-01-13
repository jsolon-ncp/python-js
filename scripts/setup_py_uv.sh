#!/bin/bash
# =========================================
# Robust Python Environment Setup with uv
# =========================================

set -euo pipefail

echo "Setting up Python environments using uv"

# -------------------------
# 1. Determine Project Root
# -------------------------
# PROJECT_ROOT points to the repo root relative to this script
PROJECT_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
echo "Project root detected at: $PROJECT_ROOT"

# -------------------------
# 2. Define venvs and requirements
# -------------------------
ENV_DIR="$PROJECT_ROOT/env"
DEFAULT_VENV="$ENV_DIR/.venv"
STATA_VENV="$ENV_DIR/.venv_stata"

DEFAULT_REQUIREMENTS="$PROJECT_ROOT/requirements.txt"
STATA_REQUIREMENTS="$PROJECT_ROOT/requirements.txt"  # adjust if different

mkdir -p "$ENV_DIR"

# -------------------------
# 3. Function to create venv and install packages
# -------------------------
create_venv_and_install() {
    local VENV_PATH="$1"
    local REQUIREMENTS_FILE="$2"
    local VENV_NAME
    VENV_NAME=$(basename "$VENV_PATH")

    # Remove old venv if exists
    if [ -d "$VENV_PATH" ]; then
        echo "Removing existing venv: $VENV_PATH"
        rm -rf "$VENV_PATH"
    fi

    echo "Creating virtual environment: $VENV_PATH"
    uv venv "$VENV_PATH" --python python

    # Activate venv immediately to ensure uv pip works
    source "$VENV_PATH/bin/activate"

    # Check requirements file exists
    if [ -f "$REQUIREMENTS_FILE" ]; then
        echo "Installing packages from $REQUIREMENTS_FILE into $VENV_NAME..."
        uv pip install -r "$REQUIREMENTS_FILE"
        echo "Packages installed successfully in $VENV_NAME"
    else
        echo "Requirements file not found: $REQUIREMENTS_FILE. Skipping package installation."
    fi

    # Deactivate environment
    deactivate
    echo "--------------------------------------------------"
}

# -------------------------
# 4. Create default venv
# -------------------------
create_venv_and_install "$DEFAULT_VENV" "$DEFAULT_REQUIREMENTS"

# -------------------------
# 5. Create Stata venv
# -------------------------
create_venv_and_install "$STATA_VENV" "$STATA_REQUIREMENTS"

echo "Setup complete. Both Python environments are ready."
echo "Activate with:"
echo "  source $DEFAULT_VENV/bin/activate      # Default Python"
echo "  source $STATA_VENV/bin/activate        # Stata Python"
