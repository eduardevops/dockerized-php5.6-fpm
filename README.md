## Run any PHP-FPM 5.6 website inside Docker container

![Logo](./assets/logo.jpg)

#### Status
<img alt="Docker Pulls" src="https://img.shields.io/docker/pulls/eduardevops/php5.6-fpm" style="max-width:100%;"> <!-- <img alt="Image Size" src="https://img.shields.io/microbadger/image-size/eduardevops/php5.6-fpm/latest" style="max-width:100%;"> --> <a href="https://www.gnu.org/licenses/gpl-3.0/"> <img alt="Licenses" src="https://img.shields.io/badge/License-GPLv3-blue.svg" style="max-width:100%;"> </a>
<img alt="Build Status" src="https://img.shields.io/docker/cloud/build/eduardevops/php5.6" style="max-width:100%;">

------

## Table of contents
* [Status](#Status)
* [Motivation](#Motivation)
* [Components](#Components)
* [Build With](#Build-With)
* [Content Tree](#Content-Tree)
* [Rename Everything](#Rename-Everything)
* [How To](#How-To)

#### Motivation
Once I got a freelance job to dockerize a web application based on PHP 5.6 with MySQL database. I investigated and couldn’t find a proper PHP 5.6 Docker container, which could fully satisfy the needs of the project. I built the needed container on my own for that project both for using Apache with PHP and Nginx with PHP-FPM. After that, I thought it would be a good idea to make your life easier by sharing it publicly so that you can use it for your projects.

If you are looking for  PHP5.6 with Apache use the following project <br>
![Dockerized PHP5.6 with Apache2](https://github.com/eduardevops/dockerized-php5.6)

####  Versions
*	PHP-FPM v5.6.40
*	Nginx   v1.10.3
*	MySQL   v5.7.27
*	Redis   v5.0.5

#### Build With
*	[Docker](https://www.docker.com/)
*	[Docker Compose](https://docs.docker.com/compose/install/)

-----

#### Rename Everything
All names can be, and, in most cases, should be changed.


#### Alternative
docker-compose-alter.yml is an compose file version 2.4 so you can set memory limits for your containers. Also instead of env files it have all configurations inside the file. in case if for any reason you want to set your DB name, password, etc.

#### Backup
Script files are designed in a way that you can choose to backup/restore each component of the project separately whenever needed.

You may find cronjob examples in both, Web and Database backup scripts, or use your own to automate backup procedure. <br> 
Before you can use the scripts you need to make sure  have the same names and paths you have in other files (docker-compose.yml, .env.db, etc).

#### Env file
Edit .env.db file to change database name, username and basically everything in that file.

-----
#### Content
The list doesn't contain git generated files and repo assets (e.g. README.md, logo.jpg)

#### Project Tree

```less
├── .env.db
├── .env.web
├── Dockerfile
├── backup
│   ├── db_backup.sh
│   ├── db_restore.sh
│   ├── web_backup.sh
│   └── web_restore.sh
├── conf
│   ├── apache-reverse-proxy.conf
│   ├── nginx-reverse-proxy.conf
|   ├── php.ini
|   ├── website.conf
├── docker-compose-alter.yml
├── docker-compose.yml
└── web
    └── index.php
```

#### Config Folder
| File                        | Description                                                                                   |
| :-------------------------- |:--------------------------------------------------------------------------------------------- |
| apache-reverse-proxy.conf   | Basic reverse proxy config file for apache (With Letsencrypt certificates)                    |
| nginx-reverse-proxy.conf    | Basic reverse proxy config file for nginx  (With Letsencrypt certificates)                    |
| docker-compose-alter.yml    | Alternative compose file v2.4                                                                 |
| php.ini                     | php.ini in case you need specific configs for PHP (e.g. upload_max_filesize)                  |
| website.conf                | Apache config file for containers                                                             |

------

#### HowTo
Clone repo to your server (I would recommend using /opt directory)
```less
sudo git clone https://github.com/eduardevops/dockerized-php5.6-fpm.git
```
Put your webapp/website into the 'web' folder. <br>
Navigate to the project folder and start containers

```less
cd /path/to/dockerized-php5.6-fpm
docker-compose up -d
```
#### Illustration
![Compose Up](https://rawcdn.githack.com/eduardevops/dockerized-php5.6-apache/8b673db930eb8bc6401b74774ade1a40d808649c/assets/docker-compose-up.gif)


Check logs in real-time
```less
docker-compose logs -f
```
#### Illustration
![Compose Logs](https://rawcdn.githack.com/eduardevops/dockerized-php5.6-fpm/f746c13c3e6e30e79b58eefdf3a08ba76b17de15/assets/docker-compose-logs.gif)
