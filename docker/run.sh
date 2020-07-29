#!/bin/bash

echo 'Excluir maquinas ... fase 1'
sudo docker ps -a | awk '{ print $14 }' | xargs sudo docker rm $0
echo 'Excluir maquinas ... fase 2'
sudo docker ps -a | awk '{ print $15 }' | xargs sudo docker rm $0

echo 'Monta os containers...'
sudo docker-compose up -d --build

echo 'Atualiza a maquina virtual'
#sudo docker-compose exec php-apache apt update
#sudo docker-compose exec php-apache apt -y upgrade

echo 'Habilita os sites...'
sudo docker-compose exec php-apache sh -c "a2ensite pss.local"

echo 'Permissoes em pastas...'

# PSS - Sistema Exemplo.
echo 'PSS - pss/proxy/var/vendor...'
sudo docker-compose exec php-apache sh -c "chmod 777 /var/www/html/pss/proxy -R"
sudo docker-compose exec php-apache sh -c "chmod 777 /var/www/html/pss/var -R"
sudo docker-compose exec php-apache sh -c "chmod 777 /var/www/html/pss/vendor -R"

#echo 'PSS - composer'
#sudo docker-compose exec php-apache sh -c "cd /var/www/html/pss && composer install"

echo 'Reinicia o apache2'
sudo docker-compose exec php-apache sh -c "service apache2 reload"

#echo 'Reinicia o memcached'
#sudo docker-compose exec memcached service memcached restart

echo 'Modulos habilitados...'
sudo docker-compose exec php-apache php -m | grep -E 'memcache|oci8|uploadprogress|mcrypt'

#echo 'Aguardando o acesso...'
#sudo docker-compose exec php-apache tail -f /var/log/apache2/pss.local-error.log
#sudo docker-compose exec php-apache tail -f /var/log/apache2/pss.local-access.log

echo 'Acesso a maquina virtual'
sudo docker-compose exec php-apache bash

