#!/bin/bash

PROJECT_ROOT=$(pwd)
VENV_PATH="$PROJECT_ROOT/.venv"
PYTHON_SCRIPT="$PROJECT_ROOT/test/AssistantPython/session.py"

echo "--- Konfiguracja środowiska ---"

# 1. Tworzenie środowiska
if [ ! -d "$VENV_PATH" ]; then
    python -m venv "$VENV_PATH"
fi

# 2. AKTUALIZACJA I INSTALACJA (Z użyciem pełnej ścieżki do pip w venv)
echo "Instalacja bibliotek..."
# Używamy bezpośrednio pip z venv, co zastępuje potrzebę 'source activate' w skrypcie
"$VENV_PATH/bin/pip" install --upgrade pip
if [ -f "requirements.txt" ]; then
    "$VENV_PATH/bin/pip" install -r requirements.txt
else
    echo "BŁĄD: Brak requirements.txt"
    exit 1
fi

# 3. Dodawanie aliasu do .bashrc
ALIAS_LINE="alias ai='$VENV_PATH/bin/python $PYTHON_SCRIPT'"

# Sprawdzanie czy alias już jest, jeśli nie - dodaj
if ! grep -q "alias ai=" ~/.bashrc; then
    echo -e "\n# AI Assistant\n$ALIAS_LINE" >> ~/.bashrc
    echo "Dodano alias do .bashrc"
else
    # Jeśli jest, podmień go na aktualną ścieżkę (przydatne przy przenoszeniu folderu)
    sed -i "s|alias ai=.*|$ALIAS_LINE|" ~/.bashrc
    echo "Zaktualizowano istniejący alias."
fi

echo "--- Gotowe! ---"
echo "Wpisz: source ~/.bashrc"