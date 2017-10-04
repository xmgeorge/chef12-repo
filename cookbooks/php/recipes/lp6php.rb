include_recipe "apt"


['php7.0-fpm', 'php7.0-cli', 'php7.0-mysql', 'php7.0-gd', 'php7.0-curl', 'php7.0-dev', 'php7.0-mcrypt', 'php7.0-sqlite3', 'php7.0-xmlrpc', 'php7.0-xsl', 'php-xdebug', 'php7.0-mbstring', 'php-memcached', 'php-imagick'].each do |p|
  package p do
    action :install
  end
end

