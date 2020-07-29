# DockerFile
#FROM debian:8
FROM ubuntu:20.04

#FROM debian:latest
#FROM debian:latest

#Variáveis de ambiente
ARG HOME
ARG URL_PROXY
ARG DEBIAN_FRONTEND=noninteractive
ARG PHP_VERSION

ENV PASTA_TEMPORARIA /tmp

#
# Caso seja definido a configuração de PROXY.
#
#ENV http_proxy ${URL_PROXY}
#ENV ftp_proxy ${URL_PROXY}
#ENV all_proxy ${URL_PROXY}
#ENV https_proxy ${URL_PROXY}
#ENV no_proxy localhost,127.0.0.1
#ENV HTTP_PROXY ${URL_PROXY}
#ENV FTP_PROXY ${URL_PROXY}
#ENV ALL_PROXY ${URL_PROXY}
#ENV HTTPS_PROXY ${URL_PROXY}

# Realiza a cópia do resolv para acessar a internet.
#COPY resolv.conf /etc/

# Instala o composer
COPY composer.phar /usr/bin/composer

RUN export PATH=${PATH}:~/.composer/vendor/bin

# Define o timezone.
ENV TZ 'America/Sao_Paulo'
RUN echo $TZ > /etc/timezone && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    apt-get update && apt-get install -y tzdata && \
    dpkg-reconfigure -f noninteractive tzdata

# Atualiza o sistema
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y ca-certificates

RUN apt-get install --reinstall ca-certificates

RUN apt-get install -y apt-utils gnupg2 gnupg1 software-properties-common zip unzip vim lsof net-tools htop curl wget git \
                   ssh iputils-ping bash-completion build-essential gcc gcc+ make libaio1 sqlite3 mysql-client 
#                   telnet lynx

#Ubuntu
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/apache2
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
RUN add-apt-repository -y ppa:ondrej/php

RUN apt-get update
RUN apt-get -y upgrade

# Instala as versões de PHP
#RUN apt install -y php${PHP_VERSION} php${PHP_VERSION}-cli php${PHP_VERSION}-dev php${PHP_VERSION}-xml \
#                   php${PHP_VERSION}-soap php${PHP_VERSION}-xmlrpc php${PHP_VERSION}-curl php${PHP_VERSION}-gd \
#                   php${PHP_VERSION}-mbstring php${PHP_VERSION}-zip php${PHP_VERSION}-opcache php${PHP_VERSION}-json \
#                   php${PHP_VERSION}-common php${PHP_VERSION}-ldap php${PHP_VERSION}-intl php${PHP_VERSION}-imap
#
#RUN apt install -y php php-cli php-dev php-cgi php-pear apache2 php-mysql php-pgsql php-odbc php-mail php-memcached php-memcache \
#                   php-gd php-xdebug php-bcmath php-sqlite3 php-soap php-curl php-xml php-xmlrpc php-mbstring \
#                   php-intl php-json php-zip php-apcu php-imagick php-redis php-common php-fpm libphp-phpmailer \
#                   php-cas php-db php-solr pear-channels libmcrypt-dev libaio1

RUN apt install -y php7.4 php7.4-cli php7.4-dev php7.4-xml php7.4-soap php7.4-xmlrpc php7.4-curl php7.4-gd php7.4-mbstring               php7.4-zip php7.4-opcache php7.4-json php7.4-common php7.4-ldap php7.4-intl

RUN apt install -y php php-cli php-dev php-cgi php-pear apache2 php-mysql php-pgsql php-odbc php-mail php-memcached php-memcache \
                   php-gd php-xdebug php-bcmath php-sqlite3 php-soap php-curl php-xml php-xmlrpc php-mbstring \
                   php-intl php-json php-zip php-apcu php-imagick php-redis php-common php-fpm libphp-phpmailer \
                   php-cas php-db php-solr pear-channels libmcrypt-dev

# Instala a biblioteca em todas as versões.
RUN apt update && apt-get -y upgrade
#RUN apt install -y php5.6-bcmath php7.0-bcmath php7.1-bcmath php7.2-bcmath php7.3-bcmath php7.4-bcmath
RUN apt install -y  php7.4-bcmath

# PECL proxy
#RUN pear config-set http_proxy ${URL_PROXY}
RUN pecl channel-update pecl.php.net

# Desabilita o módulo PHP no apache2.
#RUN a2dismod php5.6
#RUN a2dismod php7.0
#RUN a2dismod php7.1
#RUN a2dismod php7.2
#RUN a2dismod php7.3
#RUN a2dismod php7.4

# Habilita o módulo PHP no apache2
RUN a2enmod php${PHP_VERSION}

# Define a versão a ser utilizada.
RUN update-alternatives --set php /usr/bin/php${PHP_VERSION}
RUN update-alternatives --set phar /usr/bin/phar${PHP_VERSION}
RUN update-alternatives --set phar.phar /usr/bin/phar.phar${PHP_VERSION}
RUN update-alternatives --set phpize /usr/bin/phpize${PHP_VERSION}
RUN update-alternatives --set php-config /usr/bin/php-config${PHP_VERSION}

RUN apt-get install -y php${PHP_VERSION}-pgsql php${PHP_VERSION}-mysql php${PHP_VERSION}-odbc php${PHP_VERSION}-sqlite3

# Install the Oracle Instant Client
RUN mkdir /opt/oracle
#ADD oracle/instantclient-basiclite-linux.x64-12.2.0.1.0.zip /opt/oracle
ADD oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip /opt/oracle
ADD oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip /opt/oracle
ADD oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip /opt/oracle

RUN unzip /opt/oracle/instantclient-basic-linux.x64-12.2.0.1.0.zip -d /opt/oracle
RUN unzip /opt/oracle/instantclient-sdk-linux.x64-12.2.0.1.0.zip -d /opt/oracle
RUN unzip /opt/oracle/instantclient-sqlplus-linux.x64-12.2.0.1.0.zip -d /opt/oracle

#Links simbólicos
RUN ln -s /opt/oracle/instantclient_12_2 /usr/local/instantclient
RUN ln -s /opt/oracle/instantclient_12_2 /opt/oracle/instantclient

RUN ln -s /opt/oracle/instantclient_12_2/libclntsh.so.12.1 /opt/oracle/instantclient_12_2/libclntsh.so
RUN ln -s /opt/oracle/instantclient_12_2/libocci.so.12.1 /opt/oracle/instantclient_12_2/libocci.so
RUN ln -s /opt/oracle/instantclient_12_2/sqlplus /usr/bin/sqlplus

RUN echo /opt/oracle/instantclient_12_2 > /etc/ld.so.conf.d/oracle-instantclient
RUN cd /opt/oracle && ldconfig

RUN chown -R root:www-data /opt/oracle

# Install the OCI8 PHP extension
RUN echo 'shared,instantclient,/opt/oracle/instantclient_12_2' | pecl install -f oci8

# Set up the Oracle environment variables
ENV ORACLE_HOME /opt/oracle/instantclient_12_2
ENV TNS_ADMIN /opt/oracle/instantclient_12_2
ENV LD_LIBRARY_PATH /opt/oracle/instantclient_12_2
ENV PATH=/opt/oracle/instantclient_12_2/bin:$PATH
ENV C_INCLUDE_PATH=/opt/oracle/instantclient_12_2/sdk/include

RUN echo "export LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2" >> /etc/apache2/envvars
RUN echo "export ORACLE_HOME=/opt/oracle/instantclient_12_2" >> /etc/apache2/envvars
RUN echo "LD_LIBRARY_PATH=/opt/oracle/instantclient_12_2:$LD_LIBRARY_PATH" >> /etc/environment


# Install the uploadprogress PHP Function.
# Install php-apcu to running php-uploadprogress
#RUN apt install -y php-uploadprogress
RUN pecl install uploadprogress

#Install mcrypt for PHP >= 7.2 and <= 8.0.0
RUN pecl install mcrypt-1.0.3

# Configuracao XDEBUG e OCI8.
#COPY xdebug.ini /etc/php/5.6/mods-available/
#COPY xdebug.ini /etc/php/7.0/mods-available/
#COPY xdebug.ini /etc/php/7.1/mods-available/
#COPY xdebug.ini /etc/php/7.2/mods-available/
#COPY xdebug.ini /etc/php/7.3/mods-available/
COPY xdebug.ini /etc/php/${PHP_VERSION}/mods-available/

#COPY oci8.ini /etc/php/5.6/mods-available/
#COPY oci8.ini /etc/php/7.0/mods-available/
#COPY oci8.ini /etc/php/7.1/mods-available/
#COPY oci8.ini /etc/php/7.2/mods-available/
#COPY oci8.ini /etc/php/7.3/mods-available/
COPY oci8.ini /etc/php/${PHP_VERSION}/mods-available/

#COPY uploadprogress.ini /etc/php/5.6/mods-available/
#COPY uploadprogress.ini /etc/php/7.0/mods-available/
#COPY uploadprogress.ini /etc/php/7.1/mods-available/
#COPY uploadprogress.ini /etc/php/7.2/mods-available/
#COPY uploadprogress.ini /etc/php/7.3/mods-available/
COPY uploadprogress.ini /etc/php/${PHP_VERSION}/mods-available/


# Desabilita a obrigatoriedade do uso da tag <?php. Pode-se usar: <? -- SEI não funciona no padrão <?php
RUN find /etc/php -name php.ini -exec sed -i -e 's/short_open_tag = Off/short_open_tag = On/g' {} \;

# Insere a pasta (infra_php) no path de pesquisa no final do php.ini.
#RUN find /etc/php -name php.ini -exec sed -i -e '$a\' -e 'include_path = ".:/var/www/html/sei/infra/infra_php"' {} \;

# Configura o ServerName para o apache2
RUN echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

# Enable Apache2 modules
RUN a2enmod rewrite

# Habilita modulos PHP
RUN phpenmod oci8
RUN phpenmod xdebug
RUN phpenmod uploadprogress
RUN phpenmod mcrypt

# Habilita o POST 80MB
RUN find /etc/php -name php.ini -exec sed -i -e 's/post_max_size = 8M/post_max_size = 80M/g' {} \;

# Habilita upload de arquivos com 20MB
RUN find /etc/php -name php.ini -exec sed -i -e 's/upload_max_filesize = 2M/upload_max_filesize = 20M/g' {} \;

# Habilita o número máximo de arquivos para upload em 4.
#RUN find /etc/php5 -name php.ini -exec sed -i -e 's/max_file_uploads = 20/max_file_uploads = 4/g' {} \;

# Habilita PHP a gravar a sessão no memcache
#RUN find /etc/php -name php.ini -exec sed -i -e 's/session.save_handler = files/session.save_handler = memcache/g' {} \;
RUN find /etc/php -name php.ini -exec sed -i -e 's/session.save_handler = files/session.save_handler = memcached/g' {} \;

# Habilita o caminho da sessão para o memcache
#RUN find /etc/php -name php.ini -exec sed -i -e 's/;session.save_path = "\/var\/lib\/php\/sessions"/session.save_path = "tcp:\/\/memcached:11211"/g' {} \;
RUN find /etc/php -name php.ini -exec sed -i -e 's/;session.save_path = "\/var\/lib\/php\/sessions"/session.save_path = "memcached:11211"/g' {} \;

# Habilita as mensagens de erros do PHP
RUN find /etc/php -name php.ini -exec sed -i -e 's/display_errors = Off/display_errors = On/g' {} \;
RUN find /etc/php -name php.ini -exec sed -i -e 's/display_startup_errors = Off/display_startup_errors = On/g' {} \;

# Define a versão a ser utilizada.
#RUN update-alternatives --set php /usr/bin/php${PHP_VERSION}

# Reinicializa os servicos
RUN service apache2 restart

# Set up the Apache2 environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid

# Install NodeJS

# Last version
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

#RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Install NodeJS
RUN apt install -y nodejs

# Uso do NPM com proxy.
#RUN npm config set registry=http://registry.npmjs.org
#RUN npm config set proxy=${URL_PROXY}
#RUN npm config set https-proxy=${URL_PROXY}
#RUN npm config set http-proxy=${URL_PROXY}
#RUN npm config set strict-ssl=false

# Install source code
#RUN apt install -y build-essential

# Install NVM
#RUN curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh

#RUN bash install_nvm.sh
#RUN source ~/.profile

#Install yarn
RUN npm install -g yarn

# install dependency
RUN yarn install

# Build for development
#RUN yarn run dev
# or yarn run watch
#RUN yarn run prod # or yarn run watch

#Adiciona o usuário de rede no docker.
#RUN useradd llemes

#Install Java
RUN apt-get install -y default-jre
RUN apt-get install -y default-jdk
RUN ln -s /usr /opt/java
RUN echo 'JAVA_HOME="/usr/lib/jvm/default-java"' >> /etc/environment
#RUN source /etc/environment#


# Biblioteca Xrender
RUN apt-get install -y libfontconfig1 libxrender1

#Retira a configuração de proxy.
#ENV http_proxy ''
#ENV ftp_proxy ''
#ENV all_proxy ''
#ENV https_proxy ''
#ENV no_proxy localhost,127.0.0.1
#ENV HTTP_PROXY ''
#ENV FTP_PROXY ''
#ENV ALL_PROXY ''
#ENV HTTPS_PROXY ''

EXPOSE 80 443

# Run Apache2 in Foreground
CMD /usr/sbin/apache2ctl -D FOREGROUND

