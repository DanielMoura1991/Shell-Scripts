#!/bin/bash

# Verifica se o usuário é root
if [ "$(id -u)" != "0" ]; then
   echo "Este script deve ser executado como root" 1>&2
   exit 1
fi

# Verifica se o sistema está atualizado
echo "Verificando atualizações de segurança..."
updates=$(apt-get update && apt-get upgrade --dry-run | grep "upgraded" | wc -l)
if [ $updates -eq 0 ]; then
  echo "O sistema está atualizado"
else
  echo "Existem atualizações de segurança disponíveis. Execute 'apt-get upgrade' para instalá-las."
fi

# Verifica se o firewall está ativado
echo "Verificando firewall..."
ufw status | grep -q "active"
if [ $? -eq 0 ]; then
  echo "Firewall ativo"
else
  echo "Firewall inativo. Ative-o com 'ufw enable'"
fi

# Verifica se o SSH está configurado corretamente
echo "Verificando configuração do SSH..."
if [ -f /etc/ssh/sshd_config ]; then
    # Verifica se o protocolo SSH está configurado como 2
    grep -q "^Protocol 2" /etc/ssh/sshd_config
    if [ $? -ne 0 ]; then
        echo "Protocolo SSH está configurado como 1. Altere-o para 2 no arquivo /etc/ssh/sshd_config"
    fi

    # Verifica se o login de root está desabilitado
    grep -q "^PermitRootLogin no" /etc/ssh/sshd_config
    if [ $? -ne 0 ]; then
        echo "Login de root está habilitado. Desabilite-o no arquivo /etc/ssh/sshd_config"
    fi
else
    echo "Arquivo de configuração do SSH não encontrado"
fi
