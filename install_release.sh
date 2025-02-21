cp api_wrapper ~/.local/bin/
cp menu_prompt ~/.local/bin/
cp assistantRC ~/.assistantRC
./install_bash.sh
sleep 3
curl -fsSL https://ollama.com/install.sh | sh
sleep 3
curl http://localhost:11434/api/pull -d '{
  "model": "codellama:7b",
  "stream": false
}'

