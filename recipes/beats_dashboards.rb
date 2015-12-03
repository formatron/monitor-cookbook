version = node['formatron_monitor']['beats_dashboards']['version']
checksum = node['formatron_monitor']['beats_dashboards']['checksum']
url = "http://download.elastic.co/beats/dashboards/beats-dashboards-#{version}.tar.gz"
tarball = File.join Chef::Config['file_cache_path'], 'beats-dashboards.tar.gz'

remote_file tarball do
  source url
  checksum checksum
  notifies :run, 'bash[install_beats_dashboards]', :immediately
end

bash 'install_beats_dashboards' do
  code <<-EOH
    mkdir -p /tmp/beats_dashboards
    cd /tmp/beats_dashboards
    tar -zxf #{tarball} --strip-components=1
    ./load.sh
  EOH
  action :nothing
end
