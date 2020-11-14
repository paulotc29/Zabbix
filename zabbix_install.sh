#!/bin/bash

Menu(){
##clear
echo '----------------------------------------------'
echo '                MENU ZABBIX                      '
echo '----------------------------------------------'
echo
echo 'Escolha a opção : '
echo "1 - INSTALL PACOTES ZABBIX SERVER"
echo "2 - INSTALL PACOTES ZABBIX AGENTE"
echo "3 - UNISTALL PACOTES ZABBIX"
echo "4 - CONFIGURAÇÃO BANCO DE DADOS DO ZABBIX"
echo "5 - EDIÇÃO DOS ARQUIVOS DE CONFIGURAÇÃO ZABBIX"
echo "6 - REINICIAR OS SERVIÇOS DO ZABBIX"
echo "7 - STATUS DOS SERVIÇOS"
echo "8 - ZABBIX WEB"
echo "9 - EXIT"
echo
echo -n "Qual a opção desejada :"
read opcao # read le a variável opcao

case $opcao in

1) pacotes_server;; # funcao Um
2) pacotes_agente;;
3) unistall;;
4) banco_de_dados;; # funcao Dois 
5) arquivos;; # funcao Três
6) servicos ;; # funcao Três
7) status;;
8) web;; # funcao Três
9) Sair ;;  # funcao Quatro
*) 'Opção desconhecida.' ; echo; Menu;;

esac
}

pacotes_server(){
echo
echo "Instalação e configuração do Zabbix Server 5.2 no Ubuntu 20.04 (Focal)"
echo

echo "Instalação dos pacotes"
echo "Aperte um ENTER para iniciar a instalção"
read


wget https://repo.zabbix.com/zabbix/5.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.2-1+ubuntu20.04_all.deb
dpkg -i zabbix-release_5.2-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_5.2-1+ubuntu20.04_all.deb
sudo apt update
sudo apt-get install zabbix-frontend-php zabbix-apache-conf #zabbix-agent
sudo apt-get install mysql-server-8.0
#sudo apt-get install snmp-mibs-downloader
sudo apt-get install snmp-mibs-downloader zabbix-get zabbix-sender zabbix-java-gateway
sudo apt-get install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

echo "Pacotes instalados com sucesso"

Menu
}

pacotes_agente(){

wget https://repo.zabbix.com/zabbix/5.2/ubuntu/pool/main/z/zabbix-release/zabbix-release_5.2-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_5.2-1+ubuntu20.04_all.deb
sudo dpkg -i zabbix-release_5.2-1+ubuntu20.04_all.deb
read
sudo apt-get install snmp-mibs-downloader 
read
sudo apt-get install zabbix-get 
read
sudo apt-get install zabbix-sender
read
sudo apt-get install zabbix-java-gateway 
read
sudo apt-get install zabbix-agent
echo 
cho "Pacotes instalados com sucesso!"

Menu
}

unistall(){

sudo apt-get purge zabbix-frontend-php zabbix-apache-conf zabbix-agent
sudo apt-get purge mysql-server-8.0
sudo apt-get purge  snmp-mibs-downloader
sudo apt-get purge snmp-mibs-downloader zabbix-get zabbix-sender zabbix-java-gateway
sudo apt-get purge zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

Menu
}


banco_de_dados(){
#Acesso ao Banco:

#sudo mysql -uroot -p
#[ENTER]

#Configuração do banco de dados Mysql:

sql="sudo mysql -uroot -p -e" #Conectandose ao Mysql
echo "ENTER"
echo "mysql> create database zabbix character set utf8 collate utf8_bin;"
echo "mysql> create user zabbix@localhost identified by '1234';"
echo "mysql> grant all privileges on zabbix.* to zabbix@localhost;"
echo "mysql> quit;" 
echo 
echo "O banco de dados foi configurado!"
echo
echo "Fazer um teste de acesso ao banco com o usuário zabbix!"
echo 
echo "Aperte ENTER para continuar!"
read
echo
echo "Esquema inicial e os dados:"
echo
echo "zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -p"
echo
echo "Digite a senha para acesso ao banco: 1234" 
#Passord: 1234

Menu
}

arquivos(){
#Configure o banco de dados para o servidor Zabbix.
echo
echo "Necessário editar arquivo /etc/zabbix/zabbix_server.conf, conforme a linha a baixo:"
echo 
echo "DBPassword=1234"
echo 
echo "Aperte um ENTER para continuar a instalção"
read

echo
echo "Necessário editar o arquivo de configuração do Apache2, conforme a linha a baixo:"
echo
echo "nano /etc/zabbix/apache.conf"
echo "php_value date.timezone America/Recife"
echo
echo "Aperte um ENTER para continuar a instalção"
read
echo

Menu 
}

servicos(){

#Inicie o servidor Zabbix e os processos do agente e configure-os para que sejam iniciados durante o boot do sistema."

	systemctl restart zabbix-server zabbix-agent apache2
	systemctl enable zabbix-server zabbix-agent apache2

echo

Menu
}

status(){

 systemctl status zabbix-server zabbix-agent apache2
 
Menu
}

web(){

#Ip=`ip add | grep global | awk '{print $2}' | cut -c1-12`
echo 
echo "Conecte-se ao frontend Zabbix instalado: http://ip/zabbix"

Menu
}


Sair(){
if [[ exit ]]; then
echo 'Saiu do programa...'
echo
fi
}

# Primeira função a ser executada no programa.
Menu
