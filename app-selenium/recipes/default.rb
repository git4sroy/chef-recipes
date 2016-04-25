#
# Cookbook Name:: app-selenium
# Recipe:: default
#
# Copyright (C) 2016 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#
case node['platform_family']
when 'windows'
	Chef::Log.warn('Not Supported.')
when 'mac_os_x'
	Chef::Log.warn('Not Supported.')
when 'rhel', 'fedora', 'centos'
	include_recipe 'app-selenium::yum'
	include_recipe 'app-selenium::gem'
	include_recipe 'app-selenium::parallel'
	include_recipe 'app-selenium::webdriver'
when 'debian'
	Chef::Log.warn('Not Supported.')
else
	Chef::Log.warn('Chrome cannot be installed on this platform using this cookbook.')
end
