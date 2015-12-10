configuration = node['formatron_monitor']['configuration']

hosted_zone_name = configuration['dsl']['global']['hosted_zone_name']

grafana_secrets = configuration['config']['secrets']['grafana']
grafana_admin_user = grafana_secrets['admin']['user']
grafana_admin_password = grafana_secrets['admin']['password']

ldap_config = configuration['config']['ldap']
ldap_secrets = configuration['config']['secrets']['ldap']
ldap_hostname = "#{ldap_config['sub_domain']}.#{hosted_zone_name}"
ldap_port = ldap_config['port']
ldap_search_base = ldap_config['search_base']
ldap_dn_suffix = ldap_config['dn_suffix']
ldap_uid = ldap_config['uid']
ldap_bind_dn = ldap_secrets['bind_dn']
ldap_bind_password = ldap_secrets['bind_password']
ldap_first_name_attr = ldap_config['first_name_attr']
ldap_last_name_attr = ldap_config['last_name_attr']
ldap_member_of_attr = ldap_config['member_of_attr']
ldap_email_attr = ldap_config['email_attr']
ldap_admin_group_dn = grafana_secrets['ldap_admin_group_dn']
ldap_editor_group_dn = grafana_secrets['ldap_editor_group_dn']

node.override['formatron_grafana']['admin']['user'] = grafana_admin_user
node.override['formatron_grafana']['admin']['password'] = grafana_admin_password
node.override['formatron_grafana']['postgresql']['user'] = 'postgres'
node.override['formatron_grafana']['postgresql']['password'] = node['postgres_password']
node.override['formatron_grafana']['database']['host'] = 'localhost'
node.override['formatron_grafana']['database']['port'] = 5432
node.override['formatron_grafana']['database']['name'] = 'grafana'
node.override['formatron_grafana']['database']['user'] = 'grafana'
node.override['formatron_grafana']['database']['password'] = 'grafana'
node.override['formatron_grafana']['ldap_server'] = ldap_hostname
node.override['formatron_grafana']['ldap_port'] = ldap_port
node.override['formatron_grafana']['ldap_search_base'] = "#{ldap_search_base},#{ldap_dn_suffix}"
node.override['formatron_grafana']['ldap_bind_dn'] = "#{ldap_bind_dn},#{ldap_dn_suffix}"
node.override['formatron_grafana']['ldap_bind_password'] = ldap_bind_password
node.override['formatron_grafana']['ldap_uid'] = ldap_uid
node.override['formatron_grafana']['ldap_first_name_attr'] = ldap_first_name_attr
node.override['formatron_grafana']['ldap_last_name_attr'] = ldap_last_name_attr
node.override['formatron_grafana']['ldap_member_of_attr'] = ldap_member_of_attr
node.override['formatron_grafana']['ldap_email_attr'] = ldap_email_attr
node.override['formatron_grafana']['ldap_admin_group_dn'] = ldap_admin_group_dn
node.override['formatron_grafana']['ldap_editor_group_dn'] = ldap_editor_group_dn
include_recipe 'formatron_grafana::default'
