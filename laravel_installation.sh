#!/bin/bash

#global values
required_version="5.5.9"
RED='\033[0;31m'
GREEN='\033[0;32m'

#check for php installation
if ! type "php" > /dev/null; then
  echo -e "${RED}You don't have php installed, please install PHP first and then try again"
  exit 1
fi

#check php version
php_version=$(php -v | grep -P -o -i "PHP (\d+\.\d+\.\d+)" | tr -d "\n\r\f" | sed 's/PHP //g' )

if [[ $php_version < $required_version ]]
then
	echo -e "${RED}You need to upgrade your PHP version to work with Laravel. Required version: $required_version"
	exit 1
fi


#check for php extensions
if ! [ "$(php -m | grep -c 'mbstring')" -ge 1 ]; then
	echo -e "${RED}Please enable 'mbstring' php extension to proceed"
	exit 1
fi 

if ! [ "$(php -m | grep -c 'PDO')" -ge 1 ]; then
	echo -e "${RED}Please enable 'PDO' php extension to proceed"
	exit 1
fi 

if ! [ "$(php -m | grep -c 'openssl')" -ge 1 ]; then
	echo -e "${RED}Please enable 'openssl' php extension to proceed"
	exit 1
fi 

if ! [ "$(php -m | grep -c 'tokenizer')" -ge 1 ]; then
	echo -e "${RED}Please enable 'tokenizer' php extension to proceed"
	exit 1
fi 

#check if composer installation
if ! type "composer" > /dev/null; then
  echo -e "${RED}You don't have Composer installed, please install Composer to proceed."
  exit 1
fi


# if a project name given then work on that otherwise prompt to give a project name
if [ "$1" == "" ]; then
	echo -e "${RED}Please give a project name."
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
	echo -e "${GREEN}Everything is ready, mate! Create something awesome!"

#create virtual host
fi
