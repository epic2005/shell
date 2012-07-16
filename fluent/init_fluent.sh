#!/bin/bash

cd /usr/local/src
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p0.tar.gz
tar xvzf ruby-1.9.3-p0.tar.gz
cd ruby-1.9.3-p0/
./configure

cp Makefile Makefile.bak
sed -e "s/-fvisibility=hidden/-fvisibility=default/" Makefile.bak > Makefile
make clean
make
make install 

gem install fluentd
# gem install mysql2 --with-mysql-config=/usr/local/mysql5/bin/mysql_config --platform=ruby
gem install  fluent-plugin-mysql

fluentd --setup /usr/local/fluent
fluentd -c /usr/local/fluent/fluent.conf -vv