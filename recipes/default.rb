require 'securerandom'

configuration = node['formatron_monitor']['configuration']

hosted_zone_name = configuration['dsl']['global']['hosted_zone_name']

node.override['formatron_sensu']['rabbitmq']['host'] = 'localhost'
node.default['formatron_common']['configuration'] = configuration
include_recipe 'formatron_common::default'

node.default['java']['install_flavor'] = 'oracle'
node.default['java']['jdk_version'] = '8'
node.default['java']['oracle']['accept_oracle_download_terms'] = true
include_recipe 'java::default'

include_recipe 'formatron_erlang::default'
include_recipe 'formatron_rabbitmq::default'
include_recipe 'formatron_apache::default'
include_recipe 'formatron_redis::default'

postgres_password =
  node['postgres_password'] ||
  node.set['postgres_password'] =
    SecureRandom.random_number(36**12).to_s(36)
node.default['formatron_postgresql']['postgres_password'] = postgres_password
include_recipe 'formatron_postgresql::default'

include_recipe 'formatron_monitor::elk'
include_recipe 'formatron_monitor::sensu'
include_recipe 'formatron_monitor::uchiwa'
include_recipe 'formatron_monitor::graphite'
include_recipe 'formatron_monitor::grafana'

graphite_config = configuration['config']['graphite']
graphite_hostname = "#{graphite_config['sub_domain']}.#{hosted_zone_name}"
formatron_grafana_datasource 'graphite' do
  type 'graphite'
  url "http://#{graphite_hostname}"
  access 'proxy'
  basic_auth false
end
