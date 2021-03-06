#!/bin/bash
#
# Copyright 2017 Liu Hongyu
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
OPENSHIFT_RELEASE="$1"
# bash -c 'echo "export TZ=Asia/Shanghai" > /etc/profile.d/tz.sh'
    
setenforce 0
sed -i 's/SELINUX=enforcing/SELINUX=permissive/g' /etc/selinux/config

yum -y install docker
usermod -aG dockerroot vagrant
cat > /etc/docker/daemon.json <<EOF
{
    "group": "dockerroot"
}
EOF
systemctl enable docker
systemctl start docker

# Sourcing common functions
. /vagrant/common.sh
# Fix missing packages for openshift origin 3.11.0
# https://lists.openshift.redhat.com/openshift-archives/dev/2018-November/msg00005.html
if [ "$(version ${OPENSHIFT_RELEASE})" -eq "$(version 3.11)" ]; then
    yum install -y centos-release-openshift-origin311
    rm -f /etc/yum.repos.d/CentOS-ANSIBLE.repo
    yum install centos-release-ansible-28
    yum clean all
    yum repolist
fi
