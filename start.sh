#!/bin/bash


# Verifica se os programas estão instalados e os instala

if systemctl status jenkins >/dev/null 2>&1; then
    echo "Instalado"
else
    echo "Não instalado"
fi
