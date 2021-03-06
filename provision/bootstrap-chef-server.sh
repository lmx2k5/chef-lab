#!/usr/bin/env bash

apt-get update -y -qq > /dev/null
apt-get upgrade -y -qq > /dev/null
apt-get -y -q install linux-headers-$(uname -r) build-essential > /dev/null

dpkg -i /vagrant/chef-server-core_amd64.deb

chown -R vagrant:vagrant /home/vagrant

mkdir /home/vagrant/certs

chef-server-ctl reconfigure
printf "\033c"
chef-server-ctl user-create testlabdev Test Lab testlab@testlab.com password --filename /home/vagrant/certs/testlabdev.pem
chef-server-ctl org-create testcheflab "Test Chef Lab" --association_user testlabdev --filename /home/vagrant/certs/testcheflab.pem
chef-server-ctl install chef-manage
chef-server-ctl reconfigure
chef-manage-ctl reconfigure --accept-license

#chef-server-ctl install opscode-reporting
#chef-server-ctl reconfigure
#opscode-reporting-ctl reconfigure --accept-license


# configure hosts file for our internal network defined by Vagrantfile
cat >> /etc/hosts <<EOL
# vagrant environment nodes
10.0.15.10  chef-server
10.0.15.15  lb
10.0.15.22  node1
10.0.15.23  node2
10.0.15.24  node3
EOL

printf "\033c"
echo "Chef Console is ready: http://chef-server with login: testlabdev password: password"
