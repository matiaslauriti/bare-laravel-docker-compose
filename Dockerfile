FROM php:8.0-fpm

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    libpng-dev \
    libjpeg62-turbo-dev \
    libfreetype6-dev \
    locales \
    zip \
    jpegoptim optipng pngquant gifsicle \
    vim \
    unzip \
    git \
    curl

# Install extensions
RUN docker-php-ext-install pdo_mysql exif pcntl gd

# Install composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Install latest xDebug
RUN pecl install xdebug

# Clean
RUN apt-get -y autoremove \
    && apt-get clean

# Expose port 9000 and start php-fpm server
EXPOSE 9000

CMD ["php-fpm"]
