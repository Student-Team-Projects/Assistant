sudo pacman -S --needed autoconf automake autoconf-archive git cmake gcc zip unzip tar
sleep 1
git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg install boost
./vcpkg install restc-cpp
./vcpkg install nlohmann-json
cd ..
curl -fsSL https://ollama.com/install.sh | sh
curl http://localhost:11434/api/pull -d '{
  "model": "llama3.2",
  "stream": false
}'
