remote_file "#{Chef::Config[:file_cache_path]}/parallel-20150522-1.el7.cern.noarch.rpm" do
    source "http://linuxsoft.cern.ch/cern/centos/7/cern/x86_64/Packages/parallel-20150522-1.el7.cern.noarch.rpm"
    action :create
end

rpm_package "parallel" do
    source "#{Chef::Config[:file_cache_path]}/parallel-20150522-1.el7.cern.noarch.rpm"
    action :install
end
