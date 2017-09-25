#
# Cookbook Name:: phpapp
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"
#include_recipe "nginx"
# Installing php7

package 'nginx-full' do
  action :install
  #action :remove
end

service "nginx" do
  action [:enable, :start]
end

['php7.0', 'php7.0-cli', 'php7.0-mysql', 'php7.0-gd', 'php7.0-curl', 'php7.0-dev', 'php7.0-mcrypt', 'php7.0-sqlite3', 'php7.0-xmlrpc', 'php7.0-xsl', 'php-xdebug', 'php7.0-mbstring', 'php-memcached', 'php-imagick'].each do |p|
  package p do
    action :install
  end
end



#apache_site "default" do
#  enable true
#end
