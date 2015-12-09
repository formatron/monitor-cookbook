# the following attribute should be set to the contents of a standard
# Formatron configuration data bag item
default['formatron_monitor']['configuration'] = nil

# override this to add dashboards to grafana for instances
default['formatron_monitor']['grafana_instance_dashboards'] = []
