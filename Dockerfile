FROM aokinobu/apache
MAINTAINER Nobuyuki Aoki "aokinobu@gmail.com"

RUN a2enmod proxy
RUN a2enmod proxy_http
RUN a2enmod rewrite
RUN a2dissite 000-default.conf
ADD 000-sites.conf /etc/apache2/sites-available/000-sites.conf
RUN a2ensite 000-sites.conf
