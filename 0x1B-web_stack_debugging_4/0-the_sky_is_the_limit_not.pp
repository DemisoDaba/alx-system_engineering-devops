# Fix nginx to many failed requests
# Modify Nginx configuration using Puppet resources
file { '/etc/nginx/nginx.conf':
  ensure  => present,
  content => template('module_name/nginx.conf.erb'), # Use a template file for configuration
  notify  => Service['nginx'],
}

# Adjust worker_processes if needed
if $::nginx::params::worker_processes != 8 {
  class { 'nginx':
    worker_processes => 8,
  }
}

# Ensure Nginx service is running and configured
service { 'nginx':
  ensure  => 'running',
  enable  => true,
  require => File['/etc/nginx/nginx.conf'],
}

