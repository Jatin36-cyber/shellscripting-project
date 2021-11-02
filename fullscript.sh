#!/bin/bash


apt update && apt upgrade -y
apt install nginx -y
systemctl start nginx
systemctl enable nginx
apt-get install php7.4 php7.4-fpm php7.4-cli php7.4-mysql php7.4-curl php7.4-json -y

wget https://dev.mysql.com/get/mysql-apt-config_0.8.12-1_all.deb   #for mysql 5.7
#wget https://repo.mysql.com//mysql-apt-config_0.8.18-1_all.deb     #for mysql 8

dpkg -i mysql-apt-config_0.8.12-1_all.deb           #for mysql 5.7
#dpkg -i mysql-apt-config_0.8.18-1_all.deb           #for mysql 8

apt update

apt install -f mysql-client=5.7* mysql-community-server=5.7* mysql-server=5.7*    #for mysql 5.7
#apt install mysql-client mysql-community-server mysql-server -y                   #for mysql 8

apt install certbot python3-certbot-nginx -y

apt-get install python2 -y
apt-get install make -y
apt-get install g++ -y
apt install phpmyadmin -y
ln -s /usr/share/phpmyadmin /var/www/html/dbaccess
apt-get install redis-server -y
systemctl start redis-server
systemctl start mysql
systemctl stop apache2
systemctl enable redis-server
systemctl enable mysql



sed -i 's/max_execution_time = 30/max_execution_time = 300/' /etc/php/7.4/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 200M/' /etc/php/7.4/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 200M/' /etc/php/7.4/fpm/php.ini

sed -i 's/pm.max_children = 5/pm.max_children = 20/' /etc/php/7.4/fpm/pool.d/www.conf

sed  -i '/# server_tokens off/a client_max_body_size 250m;' /etc/nginx/nginx.conf
sed  -i '/# server_tokens off/a underscores_in_headers on;' /etc/nginx/nginx.conf

echo  -e '\nsql-mode = ""\nmax_connections = 50000\ngroup_concat_max_len = 4294967295' >> /etc/mysql/mysql.conf.d/mysqld.cnf

sleep 5
echo -e "\n\n===============================================================\n\n"
echo "setup installation complete"

echo "Find the details below for confirmation: "

nginx -v
mysql --version
php -v

grep max_execution_time /etc/php/7.4/fpm/php.ini
grep upload_max_filesize /etc/php/7.4/fpm/php.ini
grep post_max_size /etc/php/7.4/fpm/php.ini

grep pm.max_children /etc/php/7.4/fpm/pool.d/www.conf

grep client_max_body_size /etc/nginx/nginx.conf
grep underscores_in_headers /etc/nginx/nginx.conf

grep -a3 group_concat_max_len /etc/mysql/mysql.conf.d/mysqld.cnf
