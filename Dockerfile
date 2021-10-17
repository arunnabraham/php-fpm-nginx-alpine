FROM php:7.4-fpm-alpine
# @see https://hub.docker.com/r/jpswade/php7.4-fpm-alpine

# Install gd, iconv, mbstring, mysql, soap, sockets, zip, and zlib extensions
# see example at https://hub.docker.com/_/php/

# Nginx
RUN apk add --update \
#        openrc \
        nginx \
        dhclient \
        curl \
        wget \
        php7-dev    \
		$PHPIZE_DEPS \
		freetype-dev \
		git \
		libjpeg-turbo-dev \
		libpng-dev \
		libxml2-dev \
		libzip-dev \
		openssh-client \
		php7-json \
		imagemagick \
		imagemagick-libs \
		imagemagick-dev

# Enable openrc
# RUN touch /run/openrc/softlevel
#rc-service networking restart
RUN wget -P /etc/ssl/certs/ http://curl.haxx.se/ca/cacert.pem && chmod 744 /etc/ssl/certs/cacert.pem
RUN apk del wget git openssh-client 
# install php extensions
ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions gd igbinary xdebug imagick pdo_pgsql pgsql mbstring pdo_mysql bcmath decimal opcache calendar redis sockets zip vips mysqli

# RUN printf "\n" | pecl install \
#		pcov && \
#		docker-php-ext-enable pcov

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
	&& php composer-setup.php \
	&& php -r "unlink('composer-setup.php');" \
	&& mv composer.phar /usr/bin/composer

# RUN mkdir /run/openrc \
#  && touch /run/openrc/softlevel

WORKDIR /var/www/claritymulti.com
COPY ./nginx-conf/claritymulti.com /etc/nginx/http.d/default.conf
COPY ./app /var/www/claritymulti.com
COPY ./entrypoint/server-run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/server-run.sh
# RUN rc-update add nginx default
# VOLUME [ "/sys/fs/cgroup" ]

EXPOSE 80
 CMD [ "/usr/local/bin/server-run.sh"]
#EOF