# FrankenPHP serves public/ the way php-fpm and nginx would: a request that is
# not a file goes to index.php, one PHP process per request (no worker mode).
FROM dunglas/frankenphp:1.13.4-php8.2-bookworm AS base

RUN install-php-extensions gd intl opcache pdo_mysql \
 && cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"
COPY dev/docker/php.ini "$PHP_INI_DIR/conf.d/zz-lmms.ini"

# SERVER_NAME without a host is plain HTTP on that port: TLS ends in front.
ENV APP_ENV=prod \
    SERVER_NAME=:5000 \
    LSP_DATA_DIR=/app/storage/lsp
WORKDIR /app

FROM base AS build

RUN install-php-extensions zip
COPY --from=composer:2.10.3 /usr/bin/composer /usr/bin/composer
COPY composer.json composer.lock symfony.lock ./
RUN composer install --no-dev --no-scripts --no-autoloader --no-interaction --prefer-dist
COPY . .
RUN composer dump-autoload --no-dev --optimize \
 && php bin/console cache:warmup

FROM base

COPY --from=build --chown=www-data:www-data /app /app
RUN chown -R www-data:www-data /data/caddy /config/caddy
USER www-data

EXPOSE 5000
