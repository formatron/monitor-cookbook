# the following attribute should be set to the contents of a standard
# Formatron configuration data bag item
default['formatron_monitor']['configuration'] = nil

default['formatron_monitor']['beats_dashboards']['version'] = '1.0.0'
default['formatron_monitor']['beats_dashboards']['checksum'] = '63afec8a11a4df2bb87a9ef62dc3c96c43c845fa7a96a146afed894aa88b5bfd'

# override this to add dashboards to grafana for instances
default['formatron_monitor']['grafana_instance_dashboards'] = []
