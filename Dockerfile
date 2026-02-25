FROM dunglas/frankenphp:php8.1
RUN install-php-extensions pdo_mysql bcmath gd
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
WORKDIR /app
COPY . .
WORKDIR /app/core
RUN composer install --no-dev --optimize-autoloader --no-scripts
ENV SERVER_ROOT=/app/core/public
EXPOSE 80
