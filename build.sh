#!/bin/bash

version=8.9p1

wget -P ~/rpmbuild/SOURCES/ --no-check-certificate https://ftp.jaist.ac.jp/pub/OpenBSD/OpenSSH/portable/openssh-${version}.tar.gz
tar -zxf ~/rpmbuild/SOURCES/openssh-${version}.tar.gz

sed -re 's/^(%global no_.*_askpass) .*$/\1 2/g' -i openssh-${version}/contrib/redhat/openssh.spec
sed -re '/^Source1:/a Source2: sshd.pam.old' -i openssh-${version}/contrib/redhat/openssh.spec
sed -re '/^Source1:/s/^/#/' -i openssh-${version}/contrib/redhat/openssh.spec
sed -re '/^install.*sshd.pam.old/s@contrib/redhat/sshd.pam.old@%{SOURCE2}@' -i openssh-${version}/contrib/redhat/openssh.spec

rpmbuild -bs openssh-${version}/contrib/redhat/openssh.spec
rpmbuild --rebuild rpmbuild/SRPMS/openssh-${version}-1.el6.src.rpm
