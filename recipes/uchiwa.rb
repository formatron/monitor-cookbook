configuration = node['formatron_monitor']['configuration']

hosted_zone_name = configuration['dsl']['global']['hosted_zone_name']

uchiwa_config = configuration['config']['uchiwa']
uchiwa_hostname = "#{uchiwa_config['sub_domain']}.#{hosted_zone_name}"

sensu_config = configuration['config']['sensu']
sensu_hostname = "#{sensu_config['sub_domain']}.#{hosted_zone_name}"

ldap_config = configuration['config']['ldap']
ldap_secrets = configuration['config']['secrets']['ldap']
ldap_hostname = "#{ldap_config['sub_domain']}.#{hosted_zone_name}"
ldap_port = ldap_config['port']
ldap_search_base = ldap_config['search_base']
ldap_dn_suffix = ldap_config['dn_suffix']
ldap_uid = ldap_config['uid']
ldap_auth_name = ldap_config['auth_name']
ldap_bind_dn = ldap_secrets['bind_dn']
ldap_bind_password = ldap_secrets['bind_password']

node.default['formatron_uchiwa']['host'] = 'localhost'
node.default['formatron_uchiwa']['port'] = 3001
node.default['formatron_uchiwa']['sensu']['name'] = sensu_hostname
node.default['formatron_uchiwa']['sensu']['host'] = 'localhost'
node.default['formatron_uchiwa']['sensu']['port'] = 4567
include_recipe 'formatron_uchiwa::default'

formatron_apache_proxy uchiwa_hostname do
  proxy_pass 'http://localhost:3001/'
  ldap_auth_name ldap_auth_name
  ldap_url "ldap://#{ldap_hostname}:#{ldap_port}/#{ldap_search_base},#{ldap_dn_suffix}?#{ldap_uid}"
  ldap_bind_dn "#{ldap_bind_dn},#{ldap_dn_suffix}"
  ldap_bind_password ldap_bind_password
  notifies :reload, 'service[apache2]', :delayed
end
apache_site uchiwa_hostname
