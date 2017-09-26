#
# Cookbook Name:: phpapp
# Recipe:: default
#
# Copyright 2017, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "apt"

#resources('template[nginx.conf]').cookbook 'phpapp'

# Installing php7

package 'nginx-full' do
  action :install
#  action :remove
end

service "nginx" do
  action [:enable, :start]
end

['php7.0', 'php7.0-cli', 'php7.0-mysql', 'php7.0-gd', 'php7.0-curl', 'php7.0-dev', 'php7.0-mcrypt', 'php7.0-sqlite3', 'php7.0-xmlrpc', 'php7.0-xsl', 'php-xdebug', 'php7.0-mbstring', 'php-memcached', 'php-imagick'].each do |p|
  package p do
    action :install
  end
end

# extra packages 

package 'zip' do
  action :install
end

package 'mediainfo' do
  action :install
end

#node.override['php']['directives'] = { :short_open_tag => 'On' }

ruby_block "php_ini" do
  block do
    file = Chef::Util::FileEdit.new("/etc/php/7.0/fpm/php.ini", )
    file.search_file_replace_line("upload_max_filesize = 2M", "upload_max_filesize = 256M")
    file.search_file_replace_line("memory_limit = 128M", "memory_limit = 256M")
    file.search_file_replace_line("post_max_size = 8M", "post_max_size = 256M")
    file.write_file
  end
end

ruby_block "www_conf" do
  block do
    file = Chef::Util::FileEdit.new("/etc/php/7.0/fpm/pool.d/www.conf", )
    file.search_file_replace_line("ppm.start_servers = 2", "pm.start_servers = 20")
    file.search_file_replace_line("pm.max_children = 5", "pm.max_children = 100")
    file.search_file_replace_line("pm.max_spare_servers = 3", "pm.max_spare_servers = 20")
    file.search_file_replace_line("pm.min_spare_servers = 1", "pm.min_spare_servers = 5")
    file.write_file
  end
end

#if node['platform'] == 'ubuntu'
  # do ubuntu things
#end

#apache_site "default" do
#  enable true
#end
if !File.exist?("/tmp/uploadprogress-master")

bash "install_uploadprogress" do
     user "root"
     cwd "/tmp"
     code <<-EOH
       wget https://github.com/Jan-E/uploadprogress/archive/master.zip
       unzip master.zip 
       cd uploadprogress-master && phpize && ./configure && make && sudo make install
     EOH
    not_if "test -d /tmp/uploadprogress-master"
end
end

file '/etc/php/7.0/mods-available/uploadprogress.ini' do
  content '; configuration for php uploadprogress module
; priority=20
extension=uploadprogress.so'
  action :create
  mode '0644'
  owner 'root'
  group 'root'
end

if !File.exist?("/etc/php/7.0/cli/conf.d/20-uploadprogress.ini")
execute 'phpenmod' do
  command 'phpenmod uploadprogress'
  action :run
end
end
