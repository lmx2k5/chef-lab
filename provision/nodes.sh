#!/usr/bin/env bash
localedef -v -c -i en_US -f UTF-8 en_US.UTF-8
wget -P /tmp https://packages.chef.io/files/stable/chef/13.7.16/el/7/chef-13.7.16-1.el7.x86_64.rpm 
rpm -Uvh  /tmp/chef-13.7.16-1.el7.x86_64.rpm

# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL
# vagrant environment nodes
10.0.15.10  chef-server
10.0.15.15  lb
10.0.15.22  node1
10.0.15.23  node2
10.0.15.24  node3
EOL
