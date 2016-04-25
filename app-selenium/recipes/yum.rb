yum_repository 'google-chrome' do
	description 'Google Chrome Repo'
	baseurl node['app-selenium']['yum_baseurl']
	gpgkey node['app-selenium']['yum_gpgkey']
	action :add
end

package "google-chrome-#{node['app-selenium']['track']}" do
	action :install
end

['firefox', 'xorg-x11-server-Xvfb', 'python-pip', 'python-virtualenv', 'python-virtualenvwrapper', 'tigervnc-server', 'nodejs'].each do |pkg|
	yum_package pkg
end

%w[ /opt/Python2.7 /opt/Python2.7/bin ].each do |path|
  directory path do
    owner 'root'
    group 'root'
    mode '0755'
  end
end

link "/opt/Python2.7/bin/virtualenvwrapper.sh" do
	to "/usr/bin/virtualenvwrapper.sh"
	link_type :symbolic
	not_if "test -L /opt/Python2.7/bin/virtualenvwrapper.sh"
end

execute "install-phantomjs" do
	command "npm install phantomjs -g"
end
