#template 'nginx.conf' do
#  path   "#{node['nginx']['dir']}/nginx.conf"
#  source node['nginx']['conf_template']
#  cookbook node['nginx']['conf_cookbook']
#  notifies :reload, 'service[nginx]', :delayed
#  variables(lazy { { pid_file: pidfile_location } })
#end

template "#{node['nginx']['dir']}/sites-available/lp6.conf" do
  source 'staticlp6.erb'
  notifies :reload, 'service[nginx]', :delayed
end

nginx_site 'lp6.conf' do
  action node['nginx']['lp6_site_enabled'] ? :enable: :disable 
end

