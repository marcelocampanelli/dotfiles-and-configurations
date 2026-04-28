#!/bin/bash

extensions=(
  "aaron-bond.better-comments"
  "anysphere.remote-containers"
  "anysphere.remote-ssh"
  "bradlc.vscode-tailwindcss"
  "christian-kohler.npm-intellisense"
  "coenraads.bracket-pair-colorizer-2"
  "dbaeumer.vscode-eslint"
  "docker.docker"
  "eamodio.gitlens"
  "esbenp.prettier-vscode"
  "formulahendry.auto-rename-tag"
  "humao.rest-client"
  "johnpapa.vscode-peacock"
  "leonardssh.vscord"
  "mikestead.dotenv"
  "ms-azuretools.vscode-containers"
  "naumovs.color-highlight"
  "oderwat.indent-rainbow"
  "openai.chatgpt"
  "pascalx.sketchprompt"
  "pkief.material-icon-theme"
  "redhat.vscode-yaml"
  "shopify.ruby-lsp"
  "steoates.autoimport"
  "usernamehw.errorlens"
  "vue.volar"
  "yoavbls.pretty-ts-errors"
)

for ext in "${extensions[@]}"; do
  echo "Instalando $ext..."
  cursor --install-extension "$ext" --force
done