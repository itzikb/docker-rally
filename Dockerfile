FROM centos:7
RUN useradd -ms /bin/bash -u 5005 centos
RUN yum -y install epel-release
RUN yum -y install wget python-pip which gcc redhat-rpm-config python-devel python-pip iputils git 
RUN yum -y update

RUN echo "centos ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
ADD scripts /home/centos/scripts
RUN chmod 755 -R /home/centos/scripts \
    && chown centos:centos /home/centos/scripts

USER centos
WORKDIR /home/centos/rally
RUN wget -q -O- https://raw.githubusercontent.com/openstack/rally/master/install_rally.sh | bash
CMD ['/bin/bash']
