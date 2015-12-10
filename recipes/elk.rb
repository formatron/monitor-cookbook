configuration = node['formatron_monitor']['configuration']

hosted_zone_name = configuration['dsl']['global']['hosted_zone_name']

kibana_config = configuration['config']['kibana']
kibana_hostname = "#{kibana_config['sub_domain']}.#{hosted_zone_name}"

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

logstash_config = configuration['config']['logstash']
node.default['formatron_elasticsearch']['params']['network.host'] = 'localhost'
node.default['formatron_logstash']['port'] = logstash_config['beats_port']
node.default['formatron_kibana']['params']['server.host'] = 'localhost'

include_recipe 'formatron_elk::default'

formatron_apache_proxy kibana_hostname do
  proxy_pass 'http://localhost:5601/'
  ldap_auth_name ldap_auth_name
  ldap_url "ldap://#{ldap_hostname}:#{ldap_port}/#{ldap_search_base},#{ldap_dn_suffix}?#{ldap_uid}"
  ldap_bind_dn "#{ldap_bind_dn},#{ldap_dn_suffix}"
  ldap_bind_password ldap_bind_password
  notifies :reload, 'service[apache2]', :delayed
end
apache_site kibana_hostname
