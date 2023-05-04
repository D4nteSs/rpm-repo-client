FROM centos:latest

RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-* && \
    sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
#RUN yum -y update && \
#    yum -y install openssh-clients curl wget && \
#    yum clean all && \
#    rm -rf /etc/yum.repos.d/*
RUN rm -rf /etc/yum.repos.d/* && yum clean all

ADD local.repo /etc/yum.repos.d
#CMD ["/usr/sbin/sshd","-D"]
