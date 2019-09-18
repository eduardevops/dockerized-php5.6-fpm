FROM php:5.6-fpm

RUN mkdir -p /var/www/html/website

COPY  ./conf/website.conf /etc/nginx/sites-available/website.conf
COPY  ./conf/php.ini /usr/local/etc/php/
COPY  web /var/www/html/website

RUN chown -R www-data:www-data /var/www/html/website \
    &&  rm -f /etc/nginx/sites-enabled/default /var/www/html/index.nginx-debian.html \
    &&  ln -s /etc/nginx/sites-available/website.conf /etc/nginx/sites-enabled

RUN apt-get update && apt-get install -y --no-install-recommends nginx libpng-dev libjpeg-dev libjpeg62-turbo libmcrypt4 libmcrypt-dev libcurl3-dev libxml2-dev libxslt-dev libicu-dev  && rm -rf /var/lib/apt/lists/*

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

CMD ["nginx", "-g", "daemon off;"]
