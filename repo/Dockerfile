FROM centos:latest

# Установка необходимых пакетов для создания RPM-репозитория
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* &&\
    yum -y update && \
    yum install -y createrepo nginx yum-utils openssh-server

ADD nginx.conf /etc/nginx/nginx.conf
ADD start_services.sh /usr/local/bin/start_services.sh

# Добавление SSH публичного ключа в контейнер и настройка SSH доступа
ADD id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh &&\
    chmod 600 /root/.ssh/authorized_keys &&\
    chmod +x /usr/local/bin/start_services.sh &&\
    /usr/bin/ssh-keygen -A && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config &&\ 
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config 

# Добавление базового репозитория extras для примера в локальный репозиторий 
RUN mkdir /usr/share/nginx/repos && \
    dnf reposync -g --delete -p /usr/share/nginx/repos/ --repoid=extras --newest-only --download-metadata &&\
    dnf reposync -g --delete -p /usr/share/nginx/repos/ --repoid=baseos --newest-only --download-metadata

# Добавление собственных "готовых репозиториев"
ADD ./repos /usr/share/nginx/repos

# Запуск скрипта, который запускает Nginx и SSH серверы
CMD ["sh", "/usr/local/bin/start_services.sh"]

