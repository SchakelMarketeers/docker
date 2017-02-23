FROM library/php:7.1

COPY composer-setup.php /usr/local
COPY schakel-php-entrypoint /usr/local/bin/

# Install dependancies and
RUN apt-get update \
    && apt-get install -y \
        bzip2 \
        git \
        libc6-dev \
        libcurl4-gnutls-dev \
        libsqlite3-0 \
        libsqlite3-dev \
        libxml2 \
        libxml2-dev \
        libxslt1.1 \
        libxslt1-dev \
        libzip2 \
        libzip-dev \
        sqlite3 \
        unzip \
        wget \
        zip \
        zlib1g-dev \
    && docker-php-ext-install \
        curl \
        dom \
        json \
        mbstring \
        pdo \
        pdo_sqlite \
        simplexml \
        xml \
        zip \
    && docker-php-source delete \
    && rm -rf /var/lib/apt/lists/* \
    && pecl install xdebug-2.5.0 \
    && docker-php-ext-enable xdebug

# Install Composer
RUN mkdir -p /usr/share/composer/ \
    && php /usr/local/composer-setup.php \
        --install-dir=/usr/local/bin \
        --filename=composer

# Add Composer binaries to path
ENV PATH=$PATH:/usr/share/composer/vendor/bin

# Disable interaction globally and forcefully set home
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME=/usr/share/composer

# Install phpunit and php_codesniffer
RUN composer global require \
    --no-progress --no-suggest \
    phpunit/phpunit \
    squizlabs/php_codesniffer

ENTRYPOINT ["schakel-php-entrypoint"]
