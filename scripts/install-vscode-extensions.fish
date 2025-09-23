#!/usr/bin/env fish
if not command -q fish
    echo "Fish shell not found, skipping VS Code extensions"
    exit 0
end

for ext in (cat ./vscode-extensions.txt)
    code --install-extension $ext; or true
end