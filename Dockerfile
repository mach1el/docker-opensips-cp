FROM debian:latest

ENV DEBIAN_FRONTEND noninteractive
ENV APACHE_LOG_DIR=/var/log/apache2
ENV APACHE_RUN_DIR=/var/run/apache2
ENV APACHE_PID_FILE=/var/run/apache2/apache2.pid
ENV APACHE_RUN_USER=www-data
ENV APACHE_RUN_GROUP=www-data
ENV TZ=Asia/Ho_Chi_Minh

RUN apt-get update -qq && \
    apt-get install -y \
    git \
    curl \
    wget \
    ca-certificates \
    gnupg2 \
    dirmngr \
    python3-pip \
    libpq-dev \
    runit   \
    procps  \
    parallel \
    sudo \
    pkg-config \
    file \
    apache2 \
    libapache2-mod-php \
    php-curl \
    php \
    php-mysql \
    php-gd \
    php-pear \
    php-cli \
    php-apcu \
    php-pgsql \
    && rm -rf /var/lib/apt/lists

RUN git clone --branch=8.3.2 https://github.com/OpenSIPS/opensips-cp.git /var/www/html/opensips-cp
RUN wget https://raw.githubusercontent.com/mach1el/ansible-role-opensips/main/templates/config/boxes.global.inc.php.j2 -O /var/www/html/opensips-cp/config/boxes.global.inc.php
RUN wget https://raw.githubusercontent.com/mach1el/ansible-role-opensips/main/templates/config/db.inc.php.j2 -O /var/www/html/opensips-cp/config/db.inc.php
RUN wget https://raw.githubusercontent.com/mach1el/ansible-role-opensips/main/templates/config/cdr_viewer.php.j2 -O /var/www/html/opensips-cp/config/tools/system/cdrviewer/local.inc.php

RUN chown -R www-data:www-data /var/www/html/opensips-cp/

COPY configs/opensips-cp.conf /etc/apache2/sites-available/opensips-cp.conf
COPY configs/apache2.conf /etc/apache2/apache2.conf

RUN a2dissite 000-default.conf
RUN a2ensite opensips-cp.conf

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

VOLUME ["/etc/apache2/"]
VOLUME ["/var/www/html/opensips-cp"]

EXPOSE 80/tcp

ADD units /
RUN ln -s /etc/sv/* /etc/service

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]