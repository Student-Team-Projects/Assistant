#!/bin/bash

PROJECT_ROOT=$(pwd)
VENV_PATH="$PROJECT_ROOT/.venv"
PYTHON_SCRIPT="$PROJECT_ROOT/test/AssistantPython/session.py"

echo "--- Environment Configuration ---"

# 1. Environment creation
if [ ! -d "$VENV_PATH" ]; then
    python -m venv "$VENV_PATH"
fi

# 2. UPDATE AND INSTALLATION (Using the full path to pip in venv)
echo "Installing libraries..."
# We use pip directly from venv, which replaces the need for 'source activate' in the script
"$VENV_PATH/bin/pip" install --upgrade pip
if [ -f "requirements.txt" ]; then
    "$VENV_PATH/bin/pip" install -r requirements.txt
else
    echo "ERROR: requirements.txt not found"
    exit 1
fi

# 3. Adding alias to .bashrc
ALIAS_LINE="alias ai='$VENV_PATH/bin/python $PYTHON_SCRIPT'"

# Check if the alias already exists; if not, add it
if ! grep -q "alias ai=" ~/.bashrc; then
    echo -e "\n# AI Assistant\n$ALIAS_LINE" >> ~/.bashrc
    echo "Added alias to .bashrc"
else
    # If it exists, update it with the current path (useful if moving the folder)
    sed -i "s|alias ai=.*|$ALIAS_LINE|" ~/.bashrc
    echo "Updated existing alias."
fi

echo "--- Done! ---"
echo "Run: source ~/.bashrc"