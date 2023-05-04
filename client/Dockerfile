FROM centos:latest

ADD start_services.sh /usr/local/bin/start_services.sh

RUN rm -rf /etc/yum.repos.d/* && yum clean all && chmod +x /usr/local/bin/start_services.sh

ADD local.repo /etc/yum.repos.d/local.repo
ADD local2.repo /etc/yum.repos.d/local2.repo

CMD ["sh", "/usr/local/bin/start_services.sh"]
