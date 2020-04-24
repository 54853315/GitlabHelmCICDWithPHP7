# FROM php:7.2-fpm
FROM daocloud.io/php:7.2-fpm-alpine
ENV TZ=Asia/Shanghai
LABEL maintainer="konakona@crazyphper.com"

#阿里云镜像
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

RUN apk update && apk add --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        curl-dev \
        imagemagick-dev \
        libtool \
        libxml2-dev \
        postgresql-dev \
        #sqlite-dev \
	libmcrypt-dev \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
    && apk add --no-cache \
        curl \
        git \
        imagemagick \
        mysql-client \
        postgresql-libs \
        nodejs \
        nodejs-npm \
    # 配置npm中国镜像
    && npm config set registry https://registry.npm.taobao.org \
    && pecl install imagick \
    && pecl install mcrypt-1.0.1 \
    && docker-php-ext-enable mcrypt \
    && docker-php-ext-enable imagick \
    && docker-php-ext-install \
        curl \
        mbstring \
        pdo \
        pdo_mysql \
        pdo_pgsql \
        #pdo_sqlite \
        pcntl \
        #tokenizer \
        xml \
        zip \
	&& docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" iconv \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j"$(getconf _NPROCESSORS_ONLN)" gd \
    && pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && docker-php-ext-enable redis

RUN apk add --no-cache nginx supervisor procps

ENV COMPOSER_ALLOW_SUPERUSER=1
ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_HOME=/usr/local/share/composer

RUN mkdir -p /usr/local/share/composer \
	&& curl -o /tmp/composer-setup.php https://getcomposer.org/installer \
	&& php /tmp/composer-setup.php --no-ansi --install-dir=/usr/local/bin --filename=composer --snapshot \
	&& rm -f /tmp/composer-setup.* \
    # 配置composer中国全量镜像
    && composer config -g repo.packagist composer https://packagist.phpcomposer.com

RUN mkdir /run/nginx
RUN rm /etc/nginx/conf.d/*
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
COPY Config/nginx/default.conf /etc/nginx/conf.d/default.conf
# COPY docker/config/nginx/default /etc/nginx/sites-available/default
COPY Config/php/php-fpm.d/docker.conf /usr/local/etc/php-fpm.d/zz-docker.conf
COPY Config/php/php.ini /usr/local/etc/php/php.ini
COPY Config/supervisor/supervisord.conf /etc/supervisor/supervisord.conf
COPY Config/start.sh /usr/local/bin/start


COPY src /var/www
WORKDIR /var/www

RUN chown -R www-data:www-data /var/www/ \
    && chmod +x /usr/local/bin/start 

# RUN chmod -R 755 public \
#  && chmod -R 777 runtime \
#  && composer selfupdate --no-plugins

CMD ["/usr/local/bin/start"]