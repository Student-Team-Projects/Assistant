# Assistant

<!--
![ArchLinux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=flat-square)
-->
![License](https://img.shields.io/badge/license-MIT-green)
![Ollama](https://img.shields.io/badge/Ollama-AI%20Assistant-blue?logo=ollama&logoColor=white&style=flat)

## About the Project
Assistant is an AI-supported terminal tool designed for ArchLinux. It simplifies interaction with the bash terminal by offering suggestions and guidance for command-line tasks. By using a special prefix, you can describe the task, and the assistant will provide the appropriate bash command. The tool supports several AI models and allows choosing a version suited to device’s capabilities.

## Installation
Clone the repository and enter *assistant* directory. Choose the model, adjusting the name in *./api_wrapper/assistantRC* configuration file. For possible options see [Requirements](#requirements).

To set up the environment run:
   ```bash
    chmod +x build.sh
    ./build.sh
   ```
The above installs the model and configures the communication. On the first request, the model must be loaded into memory. This can be done in advance to avoid long waiting time for the first response:
   ```bash
   ###
   ```
To use the model, write a query preceded by ## as in the example:
   ```bash
    ## list all files in the current directory
   ```
The result is a single command to performed the described action.

## <a id="requirements"></a>Requirements
The project is intended for use on ArchLinux. It requires Cpp version X or later.
|Model version|Minimum RAM|Recommended RAM|GPU requirements|
|:---|:---|:---|:---|
|llama3.2|8GB|32GB|None|

## Project structure
The *api_wrapper* directory contains source files related to installation, configuration and communication with the model.
- *build.sh* - configures the build environment, specifying the vcpkg toolchain for dependency management, and installs the assistantRC configuration file to home directory
- *install.sh* - installs necessary dependencies using pacman and vcpkg and pulls the model from the API
- *run.sh* - executes the api_wrapper binary to initiate communication with the model
- *assistantRC* - stores the model version
- *CMakeLists.txt* - defines project metadata, locates dependencies (Boost, restc-cpp, nlohmann-json) using vcpkg, links libraries to the executable, and sets the installation path to *~/.local/bin*
- *src/main.cpp* - manages API requests and responses, handles user input, and processes model output

The *command_handler* directory contains source files connected with handling of special commands at the level of the terminal.
- *build.sh* - builds the *menu_prompt* target and defines a custom function for PROMPT_COMMAND trigger to processes special commands (with ### or ## prefix) in *~/.bashrc* file
- *CMakeLists.txt* - configures the installation of *menu_prompt* executable to the *~/.local/bin* directory
- *menu_prompt.cpp* - displays the response from the model and confirms its execution

### Dependency management
In this project, the c++ libraries are managed using vcpkg. The build scripts and CMake configurations use the vcpkg toolchain with static linking to include all dependencies directly in the executable.

## Authors
Michał Bawołek, Anna Bazan, Jakub Binięda, Anna Szymańska