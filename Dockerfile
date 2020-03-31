# Base image
FROM php:5.6-fpm

# Making web folder
# RUN mkdir -p /var/www/html/website
# VOLUME web:/var/www/html/website

# Configuring web
RUN   mkdir -p /var/www/html/website
COPY  ./conf/website.conf /etc/nginx/sites-available/website.conf
COPY  ./conf/php.ini /usr/local/etc/php/
COPY  web /var/www/html/website

# Install Nginx and other necessary libraries
RUN apt-get update && apt-get install -y --no-install-recommends nginx supervisor libpng-dev libjpeg-dev libjpeg62-turbo libmcrypt4 libmcrypt-dev libcurl3-dev libxml2-dev libxslt-dev libicu-dev  && rm -rf /var/lib/apt/lists/*

# Configure Nginx
RUN chown -R www-data:www-data /var/www/html/website \
    &&  unlink /etc/nginx/sites-enabled/default \
    &&  ln -s /etc/nginx/sites-available/website.conf /etc/nginx/sites-enabled

# Install PHP and PHP extensions
RUN apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y zlib1g-dev \
    && docker-php-ext-configure gd --with-jpeg-dir=/usr/lib \
    && docker-php-ext-install gd \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install zip \
    && docker-php-ext-install mysql \
    && docker-php-ext-install exif \
    && apt-get purge --auto-remove -y libjpeg-dev libmcrypt-dev libcurl3-dev libxml2-dev libicu-dev \
    && docker-php-ext-install mysqli \
    && docker-php-ext-install pdo_mysql \
    && apt-get autoremove

# Use supervisord instead of direct run for Nginx and PHP
ADD ./conf/supervisord.conf /etc/supervisord.conf

# PHP-FPM basic config file
ADD ./conf/www.conf /usr/local/etc/php-fpm.d/www.conf

# Adding startup script for Nginx and PHP
ADD /entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Exposing web ports
EXPOSE 80 9000

CMD ["/entrypoint.sh"]
