FROM centos:6

RUN \
sed -i -e "s/^mirrorlist=http:\/\/mirrorlist.centos.org/#mirrorlist=http:\/\/mirrorlist.centos.org/g" /etc/yum.repos.d/CentOS-Base.repo && \
sed -i -e "s/^#baseurl=http:\/\/mirror.centos.org/baseurl=http:\/\/vault.centos.org/g" /etc/yum.repos.d/CentOS-Base.repo && \
yum clean all && yum update -y \
yum install -y \
  curl \
  gcc \
  install \
  iproute \
  less \
  lsof \
  make \
  net-tools.x86_64 \
  rsyslog \
  strace \
  sudo \
  unzip \
  wget

RUN yum install -y \
  libedit-devel \
  openssl-devel \
  pam-devel \
  rpm-build \
  tcp_wrappers \
  tcp_wrappers-devel

RUN useradd build

WORKDIR /home/build
USER build
RUN mkdir -p rpmbuild/BUILD rpmbuild/BUILDROOT rpmbuild/RPMS rpmbuild/SOURCES rpmbuild/SPECS rpmbuild/SRPMS

ADD sshd.pam.old rpmbuild/SOURCES
ADD build.sh

CMD /bin/bash build.sh

