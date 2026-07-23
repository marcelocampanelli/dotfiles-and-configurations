#!/bin/bash

extensions=(
  "anysphere.remote-containers"
  "anysphere.remote-ssh"
  "dbaeumer.vscode-eslint"
  "eamodio.gitlens"
  "esbenp.prettier-vscode"
  "golang.go"
  "hverlin.mise-vscode"
  "ms-azuretools.vscode-containers"
  "ms-azuretools.vscode-docker"
  "pkief.material-icon-theme"
  "rvest.vs-code-prettier-eslint"
  "shopify.ruby-lsp"
  "tombi-toml.tombi"
  "yoavbls.pretty-ts-errors"
)

for ext in "${extensions[@]}"; do
  echo "Instalando $ext..."
  cursor --install-extension "$ext" --force
done