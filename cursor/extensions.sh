#!/bin/bash

extensions=(
  "anysphere.remote-containers",
  "anysphere.remote-ssh",
  "bradlc.vscode-tailwindcss",
  "dbaeumer.vscode-eslint",
  "eamodio.gitlens",
  "esbenp.prettier-vscode",
  "golang.go",
  "hverlin.mise-vscode",
  "ms-azuretools.vscode-containers",
  "ms-azuretools.vscode-docker",
  "nebula-themes.nebula-aura-theme",
  "openai.chatgpt",
  "pkief.material-icon-theme",
  "rvest.vs-code-prettier-eslint",
  "shd101wyy.markdown-preview-enhanced",
  "shopify.ruby-lsp",
  "tombi-toml.tombi",
  "vue.volar",
  "yoavbls.pretty-ts-errors"
)

for ext in "${extensions[@]}"; do
  echo "Instalando $ext..."
  cursor --install-extension "$ext" --force
done