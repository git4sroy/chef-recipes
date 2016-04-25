require 'net/http'

os = 'linux'
bit = '64' if node['kernel']['machine'] == 'x86_64'

version = node['app-selenium']['version']
if version == 'LATEST_RELEASE'
  uri = URI("#{node['app-selenium']['url']}/#{version}")
  res = Net::HTTP.start(uri.host, use_ssl: true, verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
    http.get uri.request_uri
  end
  version = res.body.strip
end

name = "chromedriver_#{os}#{bit}-#{version}"

cache_path = "#{Chef::Config[:file_cache_path]}/#{name}.zip"

driver_path = "/usr/local/bin/"

remote_file 'download chromedriver' do
  path cache_path
  source "#{node['app-selenium']['url']}/#{version}/chromedriver_#{os}#{bit}.zip"
  use_etag true
  use_conditional_get true
  notifies :run, 'execute[unzip chromedriver]', :immediately unless platform?('windows')
end

execute 'unzip chromedriver' do
  command "unzip -o #{cache_path} -d #{driver_path} && chmod -R 0755 #{driver_path}"
  action :nothing
end
