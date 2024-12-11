#!/bin/bash

# Prepare the cpp file to handle input / communicate with the model
cmake -B build -S .
cmake --build build
cmake --install build

function_content=$(cat << 'EOF'
# Function to handle copilot commands
function assistant_command_handler {
    last_command=$(history 1 | sed 's/^[ ]*[0-9]*[ ]*//')
    if [[ "$last_command" == '##'* ]]; then
        command=${last_command:2}

	apiPath="$HOME/.local/bin/api_wrapper"
	modelResponse=$($apiPath command)
	echo "$modelResponse"
        menuPath="$HOME/.local/bin/menu_prompt"
        "$menuPath"
        result=$?

        if [[ "$result" -eq 0 ]]; then
            history -s "${modelResponse}"
            $modelResponse
            return 0
        elif [[ "$result" -eq 1 ]]; then
            return 1
        fi
    fi
}

# Invoke the handler after every command
PROMPT_COMMAND='assistant_command_handler'
EOF
)

if grep -q "function assistant_command_handler" ~/.bashrc; then
    echo "Function 'assistant_command_handler' already exists in ~/.bashrc."
else
    echo "$function_content" >> ~/.bashrc
    source ~/.bashrc
fi

source ~/.bashrc
