# AI Linux Helper

![ArchLinux](https://img.shields.io/badge/Arch%20Linux-1793D1?logo=arch-linux&logoColor=fff&style=flat)
![Ollama](https://img.shields.io/badge/Ollama-AI%20Assistant-blue?logo=ollama&logoColor=white&style=flat)
![License](https://img.shields.io/badge/license-MIT-green)

## About the Project
This is an AI-supported terminal tool designed for ArchLinux. It simplifies interaction with the bash terminal by offering suggestions and guidance for command-line tasks. By using a special prefix, you can describe the task, and the assistant will provide the appropriate bash command. The tool supports several AI models and allows choosing a version suited to device’s capabilities.

## Installation

If you have ollama already installed, it is recommended to install it manually.

Clone the repository and enter *AssistantPython* directory.

To set up the environment run:

```bash
chmod +x setup.sh
./setup.sh
source ~/.bashrc
```

The setup script:

* installs all required system libraries and dependencies,
* downloads and prepares the selected AI model,
* configures communication components,
* updates the terminal alias used to invoke the assistant.
  

In case of using Ollama as the model provider, configure it before running the assistant by executing:

```bash
sudo pacman -Syu ollama
sudo systemctl start ollama
ollama pull mistral
```

These commands install Ollama, start the Ollama service, and download the required model used by the assistant.



After installation, configure the environment file.
In `AssistantPython/Assistant/.env` set the following variables:

* `MODEL_SOURCES`
* `KEY`
* `MODEL`

Variables names and their values should be adjusted depending on the selected model, analogously to the configuration used in `model_setup.py`.


To use the model, write a query preceded by `ai` as in the example:

```bash
ai list all files in the current directory
```

The result is a single command performing the described action. It can be applied or rejected by pressing `y/n`.

The alias mentioned above can be changed in *setup.sh* file.


## <a id="requirements"></a>Requirements
The project is intended for use with bash. Because the idea is to run in background, this project uses sudo to register ollama service.

Minimum requirements:
16GB memory, 16GB disk space, semi-modern CPU.

Recommended:
GPU with at least 8GB of VRAM, supported by Ollama, with appropriate drivers installed.

The smallest model that makes sense is 3.8GB. The recommended one is 7.4GB, but larger ones also exist. You can run it on CPU, in which case it is loaded into system memory. You can also run it on GPU, which is much faster, and uses GPU memory; system memory usage in that case is very small.


## License
This project is licensed under the terms of the MIT license.

## Authors
Michał Bawołek, Anna Bazan, Jakub Binięda, Anna Szymańska, Szymon Gaczoł, Filip Szlachetka, Jakub Wolny, Olgierd Zygmunt


