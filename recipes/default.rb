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

node['formatron_monitor']['grafana_instance_dashboards'].each do |name|
  formatron_monitor_grafana_instance_dashboard name do
    hosted_zone_name hosted_zone_name
  end
end

formatron_grafana_datasource 'topbeat' do
  type 'elasticsearch'
  url "http://localhost:9200"
  access 'proxy'
  basic_auth false
  database '[topbeat-]YYYY.MM.DD'
  json_data(
    'interval' => 'Daily',
    'timeField' => '@timestamp'
  )
end

formatron_grafana_datasource 'filebeat' do
  type 'elasticsearch'
  url "http://localhost:9200"
  access 'proxy'
  basic_auth false
  database '[filebeat-]YYYY.MM.DD'
  json_data(
    'interval' => 'Daily',
    'timeField' => '@timestamp'
  )
end

formatron_grafana_datasource 'packetbeat' do
  type 'elasticsearch'
  url "http://localhost:9200"
  access 'proxy'
  basic_auth false
  database '[packetbeat-]YYYY.MM.DD'
  json_data(
    'interval' => 'Daily',
    'timeField' => '@timestamp'
  )
end

formatron_beats_elasticsearch_template 'packetbeat'
formatron_beats_elasticsearch_template 'topbeat'
formatron_beats_elasticsearch_template 'filebeat'
