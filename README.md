# Docker - ambiente de desenvolvimento

* Essa estrutura é montada para tocar todos os projetos DOCKER nela.

* Assim temos a pasta no $HOME (Home do Usuário), chamada discoDocker.

* Dentro dela temos: 
  - apache
  - docker

* Na teoria, todos os seus projetos de diversas linguagens e e ambientes podem entrar aqui.

* Por Exemplo:
  - C
  - Java
  - Python

* Na pasta "apache", temos:
  - conf => configuração dos vhosts do apache
  - projetos => pasta relacionada ao /var/www/html

* Daí toda a configuração extra do apache, pode ser inserido nessa pasta.
* Seja arquivos, como pastas.

* Na pasta "docker", temos:
  - Toda a configuração para subir os containers.
  - Sendo necessário instalar o "docker" e o "docker-compose".
  
* Pode-se utilizar o "Portainer" e não utilizar o "Docker-compose".
  * Vai da preferência de cada analista.

* Na pasta "docker", configure o ambiente através do arquivo: ".env".
  * Nele você modifica as pastas padrões, o banco e etc.

* Na pasta "docker", rode o comando: "./run.sh"
  * Ele irá configurar o ambiente com as configurações do arquivo "docker-compose.yml".

* Abra o arquivo "run.sh" e veja as modificações que podem ser executadas nele.

* Esse ambiente foi gerado com uma configuração de exemplo, utilizando o framework padrão PHP da STI.

* Na pasta raiz do projeto, temos:
  * info.php
  * mysqltest.php
  * oracletest.php
  * postgrestest.php
  * phpmemcachedadmin

* Nessa pasta que colocaremos os projetos...

São ferramentas úteis para testes rápidos e para validar o ambiente.

