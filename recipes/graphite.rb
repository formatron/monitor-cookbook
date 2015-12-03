require 'securerandom'

configuration = node['formatron_monitor']['configuration']

hosted_zone_name = configuration['dsl']['global']['hosted_zone_name']

graphite_config = configuration['config']['graphite']
graphite_hostname = "#{graphite_config['sub_domain']}.#{hosted_zone_name}"
graphite_timezone = graphite_config['timezone']
graphite_root_user = graphite_config['root']['user']
graphite_root_firstname = graphite_config['root']['firstname']
graphite_root_lastname = graphite_config['root']['lastname']
graphite_root_password = graphite_config['root']['password']
graphite_root_email = graphite_config['root']['email']
graphite_secret =
  node['graphite_secret'] ||
  node.set['graphite_secret'] =
    SecureRandom.random_number(36**12).to_s(36)

ldap_config = configuration['config']['ldap']
ldap_hostname = "#{ldap_config['sub_domain']}.#{hosted_zone_name}"
ldap_port = ldap_config['port']
ldap_search_base = ldap_config['search_base']
ldap_dn_suffix = ldap_config['dn_suffix']
ldap_uid = ldap_config['uid']
ldap_bind_dn = ldap_config['bind_dn']
ldap_bind_password = ldap_config['bind_password']

include_recipe 'apache2::mod_wsgi'

node.override['formatron_graphite']['hostname'] = graphite_hostname
node.override['formatron_graphite']['secret'] = graphite_secret
node.override['formatron_graphite']['timezone'] = graphite_timezone
node.override['formatron_graphite']['postgresql']['user'] = 'postgres'
node.override['formatron_graphite']['postgresql']['password'] = node['postgres_password']
node.override['formatron_graphite']['database']['host'] = 'localhost'
node.override['formatron_graphite']['database']['port'] = 5432
node.override['formatron_graphite']['database']['name'] = 'graphite'
node.override['formatron_graphite']['database']['user'] = 'graphite'
node.override['formatron_graphite']['database']['password'] = 'graphite'
node.override['formatron_graphite']['root_user'] = graphite_root_user
node.override['formatron_graphite']['root_firstname'] = graphite_root_firstname
node.override['formatron_graphite']['root_lastname'] = graphite_root_lastname
node.override['formatron_graphite']['root_password'] = graphite_root_password
node.override['formatron_graphite']['root_email'] = graphite_root_email
node.override['formatron_graphite']['ldap_server'] = ldap_hostname
node.override['formatron_graphite']['ldap_port'] = ldap_port
node.override['formatron_graphite']['ldap_search_base'] = "#{ldap_search_base},#{ldap_dn_suffix}"
node.override['formatron_graphite']['ldap_bind_dn'] = "#{ldap_bind_dn},#{ldap_dn_suffix}"
node.override['formatron_graphite']['ldap_bind_password'] = ldap_bind_password
node.override['formatron_graphite']['ldap_uid'] = ldap_uid
include_recipe 'formatron_graphite::default'
apache_site 'graphite'
