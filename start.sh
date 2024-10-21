#!/bin/bash

#   Adicione permissão de execução a este script com chmod +x start.sh
#   Execute esse script com root ou usando sudo

# Adiciona permissão de execulsão a todos os outros scripts

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root."
    exit 1
fi

# Tranforma todos os scripts em executaveis
chmod +x */*.sh

function installs(){

}

function apps(){

}

# Chama as funções
installs
apps