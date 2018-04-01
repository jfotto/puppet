# Set up regular Puppet runs
file { '/tmp/hello_otto.txt':
  ensure  => file,
  content => "Hello Mr. Otto \n",
}

file { '/usr/local/bin/run-puppet':
  source => '/etc/puppetlabs/code/environments/production/files/run-puppet.sh',
  mode   => '0755',
}

cron { 'run-puppet':
  command => '/usr/local/bin/run-puppet',
  hour    => '*',
  minute  => '*/15',
}
