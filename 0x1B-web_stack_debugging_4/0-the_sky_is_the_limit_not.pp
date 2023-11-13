# Fix nginx to many failed requests
exec {'increase_workers':
command => '/bin/sed -i "s/worker_processes 4/worker_processes 8/g" /etc/nginx/nginx.conf',
notify  => Service['nginx'],
}

service {'nginx':
ensure => 'running',
}
