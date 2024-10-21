#!/bin/bash

# Armazena o gerenciador de pacotes da distro
PACKAGE_MANAGER=""

# Comando de instalação
INSTALL_CMD=""

# Configurações iniciais para a prosseguir com a instalação
CONFIGS=""

# Define a versão do Python
PYTHON_VERSION="3.11"

function install() {

    eval $CONFIGS
    eval $INSTALL_CMD
}

#Verifica se o python ja esta instalado

if command -v python3 --version > /dev/null; then

    echo "Pyhton já está instalado"
    exit 0;

fi

if command -v apt >/dev/null; then

    PACKAGE_MANAGER="apt"
    INSTALL_CMD="sudo apt install python$PYTHON_VERSION -y"
    CONFIGS="sudo apt update"

elif command -v dnf >/dev/null; then

    PACKAGE_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install python$PYTHON_VERSION -y"
    CONFIGS="sudo dnf update -y"

elif command -v yum >/dev/null; then

    PACKAGE_MANAGER="yum"
    INSTALL_CMD="sudo yum install python$PYTHON_VERSION -y"
    CONFIGS="sudo yum update -y"

elif command -v pacman >/dev/null; then

    PACKAGE_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S python -y"
    CONFIGS="sudo pacman -Syu"

elif command -v zypper >/dev/null; then

    PACKAGE_MANAGER="zypper"
    INSTALL_CMD="sudo zypper install python3 -y"
    CONFIGS="sudo zypper refresh"

else

    PACKAGE_MANAGER="Gerenciador de pacotes desconhecido!"
    echo $PACKAGE_MANAGER
    exit 1
fi

echo "Instalando o Python $PYTHON_VERSION com: $PACKAGE_MANAGER"
install