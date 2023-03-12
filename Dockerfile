ARG PHP_VERSION

FROM php:${PHP_VERSION}-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    libzip-dev \
    zip \
    unzip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    git \
    curl

# Install extensions
RUN docker-php-ext-install pdo_mysql exif pcntl gd zip

# Install latest xDebug
ARG XDEBUG_VERSION
RUN pecl install xdebug${XDEBUG_VERSION}

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install NodeJS/NPM/Yarn
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - \
  && apt-get install -y nodejs \
  && curl -L https://www.npmjs.com/install.sh | sh \
  && npm install -g yarn

# Clean
RUN apt-get -y autoremove \
    && apt-get clean

ARG WWWUSER
ARG WWWGROUP

RUN groupadd --force -g $WWWGROUP main
RUN useradd -ms /bin/bash --no-user-group -g $WWWGROUP -u $WWWUSER main

USER $WWWUSER:$WWWGROUP

EXPOSE 9000

WORKDIR /var/www

CMD ["php-fpm"]
