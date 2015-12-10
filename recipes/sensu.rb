configuration = node['formatron_monitor']['configuration']

hosted_zone_name = configuration['dsl']['global']['hosted_zone_name']

graphite_config = configuration['config']['graphite']
graphite_host = "#{graphite_config['sub_domain']}.#{hosted_zone_name}"
graphite_carbon_port = 2003

sensu_config = configuration['config']['sensu']
sensu_secrets = configuration['config']['secrets']['sensu']
rabbitmq_vhost = sensu_secrets['rabbitmq']['vhost']
rabbitmq_user = sensu_secrets['rabbitmq']['user']
rabbitmq_password = sensu_secrets['rabbitmq']['password']
sensu_checks = sensu_config['checks']
sensu_gems = sensu_config['gems']

formatron_rabbitmq_vhost rabbitmq_vhost

formatron_rabbitmq_user rabbitmq_user do
  password rabbitmq_password
end

formatron_rabbitmq_permissions rabbitmq_user do
  vhost rabbitmq_vhost
  conf '.*'
  write '.*'
  read '.*'
end

node.default['formatron_sensu']['redis']['host'] = 'localhost'
node.default['formatron_sensu']['api']['host'] = 'localhost'
node.default['formatron_sensu']['api']['port'] = 4567
node.default['formatron_sensu']['graphite']['host'] = graphite_host
node.default['formatron_sensu']['graphite']['carbon_port'] = graphite_carbon_port
node.default['formatron_sensu']['checks'] = sensu_checks unless sensu_checks.nil?
node.default['formatron_sensu']['gems'] = sensu_gems unless sensu_gems.nil?
include_recipe 'formatron_sensu::server'
