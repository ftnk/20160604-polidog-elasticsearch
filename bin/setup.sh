#!/bin/sh

# Install Puppet
rpm -q puppetlabs-release > /dev/null || \
    rpm -ivh http://yum.puppetlabs.com/el/6/products/x86_64/puppetlabs-release-6-12.noarch.rpm
rpm -q puppet > /dev/null || \
    yum install -y puppet

# Install Puppet module
puppet module --modulepath=puppet/modules list | \
    grep puppetlabs-firewall > /dev/null || \
    puppet module --modulepath=./puppet/modules install puppetlabs-firewall

# install dstat
rpm -q dstat > /dev/null || \
    yum install -y http://pkgs.repoforge.org/dstat/dstat-0.7.2-1.el6.rfx.noarch.rpm

# Run Puppet
puppet apply \
       --modulepath=$(pwd)/puppet/modules \
       --verbose \
       puppet/manifests/site.pp

[ ! -f /usr/local/bin/embulk ] && \
    curl -o /usr/local/bin/embulk -L "http://dl.embulk.org/embulk-latest.jar" && \
    chmod +x /usr/local/bin/embulk
