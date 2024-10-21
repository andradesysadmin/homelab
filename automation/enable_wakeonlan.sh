#!/bin/bash

PACKAGE_MANAGER=""
INSTALL_CMD=""
CONFIGS=""
INTERFACE=""

function install(){
    eval $CONFIGS
    eval $INSTALL_CMD
}

function enable_wol(){
    INTERFACE=$(ip -o -4 route show to default | awk '{print $5}')
    if [ -z "$INTERFACE" ]; then
        echo "Não foi possível encontrar a interface de rede padrão."
        exit 1
    fi

    ethtool -s $INTERFACE wol g
    if [ $? -eq 0 ]; then
        echo "Wake-on-LAN foi habilitado com sucesso na interface $INTERFACE."
    else
        echo "Falha ao habilitar Wake-on-LAN na interface $INTERFACE."
    fi

    WOL_STATUS=$(ethtool $INTERFACE | grep "Wake-on")
    echo "Novo status do Wake-on-LAN: $WOL_STATUS"
}

if command -v apt >/dev/null; then
    PACKAGE_MANAGER="apt"
    INSTALL_CMD="sudo apt install -y ethtool"
    CONFIGS="sudo apt update && sudo apt upgrade -y"

elif command -v dnf >/dev/null; then
    PACKAGE_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y ethtool"
    CONFIGS="sudo dnf install -y dnf-plugins-core"

elif command -v yum >/dev/null; then
    PACKAGE_MANAGER="yum"
    INSTALL_CMD="sudo yum install -y ethtool"
    CONFIGS="sudo yum install -y yum-utils"

elif command -v pacman >/dev/null; then
    PACKAGE_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm ethtool"
    CONFIGS="sudo pacman -Sy"

elif command -v zypper >/dev/null; then
    PACKAGE_MANAGER="zypper"
    INSTALL_CMD="sudo zypper install -y ethtool"
    CONFIGS="sudo zypper refresh"

else
    PACKAGE_MANAGER="Gerenciador de pacotes desconhecido!"
    echo $PACKAGE_MANAGER
    exit 1
fi

echo "Instalando o ethtool com o gerenciador de pacotes $PACKAGE_MANAGER"
install
enable_wol