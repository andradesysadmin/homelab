#!/bin/bash




#############################################################################
#                                                                           #  
#   Adicione permissão de execução a este script com chmod +x start.sh      #
#   Execute esse script com root ou usando sudo                             #
#                                                                           #
#############################################################################




# Valida se o script foi executado com os devidos privilégios

if [ "$(id -u)" -ne 0 ]; then
    echo "Este script precisa ser executado como root"
    exit 1
fi


# Tranforma todos os scripts do projeto em executaveis
chmod +x */*.sh


#Função que instala as aplicações 
function installs() {

    # Loop para execultar scripts contidos installs/ e validar suas saidas
    DIR = $(ls installs/)
    for in f in $DIR; do

        sudo /installs/$f
        if [ $? -eq 0 ]; then

            echo "$f executado com sucesso."
        else

            echo "Erro ao executar $f"
            exit 1
        fi
    done

}

function apps(){

    # Loop para execultar scripts contidos apps/ e validar suas saidas
    # -r para instalar o postgres primeiro
    DIR = $(ls -r apps/)
    for in f in $DIR; do

        sudo /installs/$f
        if [ $? -eq 0 ]; then

            echo "$f executado com sucesso."
        else

            echo "Erro ao executar $f"
            exit 1
        fi
    done

}

# function automation(){

# }

# Chama as funções
installs
apps
#automation