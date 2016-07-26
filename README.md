# Laravel 5 Installation script(for debian distros)
This script checks for the basic requirements and then install the fresh copy of laravel

## What it actually does
- Installs apache, php5, mysql if not already installed
- Installs phpmyadmin
- Checks if php is installed
- Checks if php version is above the requirement for laravel installation
- Checks if the required php extensions are enabled
- Checks and installs composer if not installed
- Install a fresh copy of laravel
- Set needed permissions for files and folders of laravel
- Create a .env file from the .env.example file
- generates application key

## What to do
Run this script with root permission (like 'sudo' in debian distros) from anywhere.
