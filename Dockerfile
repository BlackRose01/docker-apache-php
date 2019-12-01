FROM debian:latest

MAINTAINER BlackRose<appdev.blackrose@gmail.com>

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install apache2 libapache2-mod-php php php-dev php-cgi php-cli php-curl php-fpm php-json php-mbstring php-xml php-zip php-imagick php-pear php-mysql unzip libaio1
RUN apt-get -y clean

ADD instantclient-basic-linux.x64-19.5.0.0.0dbru.zip /tmp
ADD instantclient-sdk-linux.x64-19.5.0.0.0dbru.zip /tmp

RUN unzip /tmp/instantclient-basic-linux.x64-19.5.0.0.0dbru.zip -d /usr/local/
RUN unzip /tmp/instantclient-sdk-linux.x64-19.5.0.0.0dbru.zip -d /usr/local/
RUN ln -s -f /usr/local/instantclient_19_5 /usr/local/instantclient
RUN ln -s -f /usr/local/instantclient/libclntsh.so.12.1 /usr/local/instantclient/libclntsh.so
RUN echo 'instantclient,/usr/local/instantclient' | pecl install oci8
RUN echo "extension=oci8.so" > /etc/php/7.3/apache2/conf.d/30-oci8.ini

RUN chmod -R 0755 /var/www/html

EXPOSE 80

RUN service apache2 start
