name             'phpapp'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures phpapp'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

#%w{ apt }.each do |pkg|
#  depends pkg
#end

#%w{ ubuntu }.each do |os|
#  supports os
#end
depends 'apt'
depends 'nginx'
depends 'php'
