%w(
  sensu
  logstash
  kibana
  graphite
  grafana
  uchiwa
  ldap
).each do |hostname|
  hostsfile_entry '127.0.0.1' do
    hostname "#{hostname}.mydomain.com"
    action :append
  end
end

node.default['formatron_monitor']['configuration'] = {
  'dsl' => {
    'global' => {
      'hosted_zone_name' => 'mydomain.com'
    }
  },
  'config' => {
    'logstash' => {
      'sub_domain' => 'logstash',
      'port' => '5044'
    },
    'sensu' => {
      'sub_domain' => 'sensu',
      'checks' => {
        'mycheck' => {
          'gem' => 'cpu',
          'attributes' => {
            'command' => 'check-cpu.rb',
            'standalone' => true,
            'subscribers' => ['default'],
            'interval' => 10,
            'handlers' => ['relay']
          }
        }
      },
      'gems' => {
        'cpu' => {
          'gem' => 'sensu-plugins-cpu-checks',
          'version' => '0.0.4'
        }
      }
    },
    'kibana' => {
      'sub_domain' => 'kibana'
    },
    'graphite' => {
      'sub_domain' => 'graphite'
    },
    'grafana' => {
      'sub_domain' => 'grafana'
    },
    'uchiwa' => {
      'sub_domain' => 'uchiwa'
    },
    'ldap' => {
      'sub_domain' => 'ldap',
      'auth_name' => 'Crowd login',
      'uid' => 'uid',
      'search_base' => 'ou=myunit',
      'dn_suffix' => 'o=myorg',
      'first_name_attr' => 'givenName',
      'last_name_attr' => 'sn',
      'member_of_attr' => 'memberOf',
      'email_attr' => 'mail',
      'port' => 4000
    },
    'secrets' => {
      'sensu' => {
        'rabbitmq' => {
          'vhost' => '/sensu',
          'user' => 'sensu',
          'password' => 'password'
        }
      },
      'graphite' => {
        'root' => {
          'user' => 'root',
          'firstname' => 'root',
          'lastname' => 'user',
          'email' => 'email@mydomain.com',
          'password' => 'password'
        }
      },
      'grafana' => {
        'admin' => {
          'user' => 'admin',
          'password' => 'password'
        }
      },
      'ldap' => {
        'bind_dn' => 'cn=root',
        'bind_password' => 'password'
      }
    }
  }
}

node.default['formatron_sensu']['client']['subscriptions'] = ['default']

include_recipe 'formatron_monitor::default'
