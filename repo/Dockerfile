FROM centos:latest

# Установка необходимых пакетов для создания RPM-репозитория
# openssh-clients для возможности добавления пакетов по scp в контейнер
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-* &&\
    yum -y update && \
    yum install -y epel-release createrepo nginx yum-utils openssh-server openssh-clients 

# Копирование конфига nginx и файла запуска контейнера
COPY nginx.conf /etc/nginx/nginx.conf
COPY start_services.sh /usr/local/bin/start_services.sh
COPY nginxssh.conf /etc/supervisord.d/nginxssh.conf

# Добавление SSH публичного ключа в контейнер и настройка SSH доступа
# Изменить на свой публичный ключ id_rsa.pub
COPY id_rsa.pub /root/.ssh/authorized_keys
RUN chmod 700 /root/.ssh &&\
    chmod 600 /root/.ssh/authorized_keys &&\
    chmod +x /usr/local/bin/start_services.sh &&\
    /usr/bin/ssh-keygen -A && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config &&\ 
    sed -i 's/#PermitRootLogin yes/PermitRootLogin yes/' /etc/ssh/sshd_config 


# Создание символической ссылки для логирования в коллектор
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stdout /var/log/nginx/error.log

# Запуск скрипта, который запускает Nginx и SSH серверы
CMD ["sh", "/usr/local/bin/start_services.sh"]

