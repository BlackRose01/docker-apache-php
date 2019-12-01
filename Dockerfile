FROM debian:latest

MAINTAINER BlackRose<appdev.blackrose@gmail.com>

RUN apt-get update
RUN apt-get -y dist-upgrade
RUN apt-get -y install apache2 libapache2-mod-php php php-dev php-cgi php-cli php-curl php-fpm php-json php-mbstring php-xml php-zip php-imagick php-pear php-mysql alien
RUN apt-get -y clean

ADD oracle-instantclient19.5-basic-19.5.0.0.0-1.x86_64.rpm /tmp
ADD oracle-instantclient19.5-devel-19.5.0.0.0-1.x86_64.rpm /tmp

RUN alien /tmp/oracle-instantclient19.5-basic-19.5.0.0.0-1.x86_64.rpm
RUN alien /tmp/oracle-instantclient19.5-devel-19.5.0.0.0-1.x86_64.rpm

RUN dpkg -i /tmp/oracle-instantclient19.5-basic*
RUN dpkg -i /tmp/oracle-instantclient19.5-devel*

RUN echo "extension=oci8.so" >> /etc/php/7.3/fpm/php.ini
RUN echo "extension=oci8.so" >> /etc/php/7.3/cli/php.ini
RUN echo "extension=oci8.so" > /etc/php/7.3/apache2/conf.d/30-oci8.ini

RUN chmod -R 0755 /var/www/html

EXPOSE 80

CMD service apache2 start
