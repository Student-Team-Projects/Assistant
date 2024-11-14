git clone https://github.com/microsoft/vcpkg
cd vcpkg
./bootstrap-vcpkg.sh
./vcpkg install boost
./vcpkg install restc-cpp
./vcpkg install nlohmann-json
cd ..
