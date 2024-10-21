#!/bin/bash

# Armazena o gerenciador de pacotes da distro
PACKAGE_MANAGER=""

# Comando de instalação
INSTALL_CMD=""

# Configurações iniciais para a prosseguir com a instalção
CONFIGS=""

# Define a versão do JDK ultilizada
JDK_VERSION="21"

#Define a porta do Jenkins
JENKINS_PORT=${1:-8090}

function install() {

    eval $CONFIGS
    eval $INSTALL_CMD

    sudo systemctl start jenkins
    sudo systemctl enable jenkins

    sudo sed -i "s/HTTP_PORT=.*/HTTP_PORT=$JENKINS_PORT/" /etc/default/jenkins
    sudo systemctl restart jenkins
}

if command -v apt >/dev/null; then

    PACKAGE_MANAGER="apt"
    INSTALL_CMD="sudo apt install jenkins -y"
    CONFIGS="sudo apt update && sudo apt install openjdk-$JDK_VERSION-jdk -y"

elif command -v dnf >/dev/null; then

    PACKAGE_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install jenkins -y"
    CONFIGS="sudo dnf install java-$JDK_VERSION-openjdk -y"

elif command -v yum >/dev/null; then

    PACKAGE_MANAGER="yum"
    INSTALL_CMD="sudo yum install jenkins -y"
    CONFIGS="sudo yum install java-$JDK_VERSION-openjdk -y"

elif command -v pacman >/dev/null; then

    PACKAGE_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S jenkins -y"
    CONFIGS="sudo pacman -S jre-openjdk -y"

elif command -v zypper >/dev/null; then

    PACKAGE_MANAGER="zypper"
    INSTALL_CMD="sudo zypper install jenkins -y"
    CONFIGS="sudo zypper install java-$JDK_VERSION-openjdk -y"

else

    PACKAGE_MANAGER="Gerenciador de pacotes desconhecido!"
    echo $PACKAGE_MANAGER
    exit 1
fi

echo "Instalando o Jenkins com: $PACKAGE_MANAGER"
install