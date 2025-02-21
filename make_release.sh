cd api_wrapper
./build.sh
cd ../command_handler
./build.sh
cd ..
rm release -r
mkdir release
cp api_wrapper/build/api_wrapper release/api_wrapper
cp api_wrapper/assistantRC release/assistantRC
cp command_handler/build/menu_prompt release/menu_prompt
cp command_handler/install_bash.sh release/install_bash.sh
cp install_release.sh release/install.sh
chmod +x release/install.sh
