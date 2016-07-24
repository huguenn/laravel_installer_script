#!/bin/bash

# check php version and extensions

if  [ "$(php -m | grep -c 'mbstring')" -ge 1 ]; then
	echo "Please enable 'mbstring' php extension to proceed"
	exit 1
fi 

if  [ "$(php -m | grep -c 'PDO')" -ge 1 ]; then
	echo "Please enable 'PDO' php extension to proceed"
	exit 1
fi 

if  [ "$(php -m | grep -c 'openssl')" -ge 1 ]; then
	echo "Please enable 'openssl' php extension to proceed"
	exit 1
fi 

if  [ "$(php -m | grep -c 'tokenizer')" -ge 1 ]; then
	echo "Please enable 'tokenizer' php extension to proceed"
	exit 1
fi 

#check if composer installed




# if a project name given then work on that otherwise prompt to give a project name
if [ "$1" == "" ]; then
	echo "Please give a project name."
else
	cd /var/www/html
	composer create-project --prefer-dist laravel/laravel $1
	#apache user group permission
	chown -R www-data.www-data /var/www/$1 
	chmod -R 755 /var/www/$1
	cd $1 
	chmod -R 777 storage
	chmod -R 777 bootstrap/cache	
	cp .env.example .env
	php artisan key:generate
	echo "Everything is ready mate!"

#create virtual host
fi
