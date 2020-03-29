# Base image
FROM php:5.6-fpm

RUN mkdir -p /var/www/html/website
VOLUME web:/var/www/html/website

COPY  ./conf/website.conf /etc/nginx/sites-available/website.conf
COPY  ./conf/php.ini /usr/local/etc/php/
COPY  web /var/www/html/website

# Install Nginx and other necessary libraries
RUN apt-get update && apt-get install -y --no-install-recommends nginx libpng-dev libjpeg-dev libjpeg62-turbo libmcrypt4 libmcrypt-dev libcurl3-dev libxml2-dev libxslt-dev libicu-dev  && rm -rf /var/lib/apt/lists/*

# Configure Nginx
RUN chown -R www-data:www-data /var/www/html/website \
    &&  unlink /etc/nginx/sites-enabled/default \
    &&  ln -s /etc/nginx/sites-available/website.conf /etc/nginx/sites-enabled

# Disable IPv6 support in Nginx
RUN   sed '/listen [::]:80/d' /etc/nginx/nginx.conf

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

# Exposing web ports
EXPOSE 80

STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]
