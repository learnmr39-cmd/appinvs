FROM php:8.1-apache
RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libfreetype6-dev zip unzip git curl
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install pdo_mysql bcmath gd
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
WORKDIR /var/www/html
COPY . .
WORKDIR /var/www/html/core
RUN composer install --no-dev --optimize-autoloader
RUN chown -R www-data:www-data /var/www/html
EXPOSE 80
