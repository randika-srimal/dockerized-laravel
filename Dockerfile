FROM php:8.0-fpm-alpine

WORKDIR /app

RUN docker-php-ext-install pdo_mysql

RUN apk add --update npm

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

COPY ./src/ .

RUN composer install

RUN php artisan key:generate

RUN chown -R www-data:www-data storage

CMD php artisan serve --host=0.0.0.0 --port=8000

EXPOSE 8000
