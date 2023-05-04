FROM centos:latest

# Установка необходимых пакетов для создания RPM-репозитория
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
RUN yum -y update && \
    yum install -y createrepo nginx yum-utils openssh-server

# Добавление SSH публичного ключа в контейнер и настройка SSH доступа
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh &&\
    chmod 600 /root/.ssh/authorized_keys &&\
    chmod 755 /var/empty/sshd 
RUN /usr/bin/ssh-keygen -A && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config &&\ 
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config 

#RUN createrepo /repo

# Открытие портов для SSH
#ADD local.repo /etc/yum.repos.d/

ADD nginx.conf /etc/nginx/nginx.conf
RUN mkdir /usr/share/nginx/repos && \
    dnf reposync -g --delete -p /usr/share/nginx/repos/ --repoid=extras --newest-only --download-metadata
#RUN rm -rf /etc/rm -rf CentOS-Linux-*/CentOS-Linux-*
# Запуск SSH-сервера
ADD ./repos /usr/share/nginx/repos
ADD start_services.sh /usr/local/bin/start_services.sh
RUN chmod +x /usr/local/bin/start_services.sh

CMD ["sh", "/usr/local/bin/start_services.sh"]

#CMD nginx -g 'daemon off;' && /usr/sbin/sshd -D
