FROM registry.access.redhat.com/ubi7/ubi:latest
MAINTAINER Juan Pablo Hernandez Caz <madridjphernandezes@gmail.com>
RUN yum update -y && \
    yum install httpd -y && \
    yum clean all
# Forma con archivo comprimido - lo descomprime en destino ADD paint.tar /var/www/html
# Otra forma copiendo recursos concretos descompimido el tar 
COPY index.html flow.js main.js perlin.js utils.js /var/www/html
EXPOSE 8080
#RUN sed -i "s/Listen 80/Listen 8080/g" /etc/httpd/conf/httpd.conf
RUN sed -ri -e "/^Listen 80/c\Listen 8080" /etc/httpd/conf/httpd.conf
RUN chgrp -R 0 /var/log/httpd /var/run/httpd && chmod -R g=u /var/log/httpd /var/run/httpd
USER 1001
ENTRYPOINT ["httpd", "-D", "FOREGROUND"]
