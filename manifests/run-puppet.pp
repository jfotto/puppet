# Set up regular Puppet runs
node 'PuppetAgent1' {

  file { '/tmp/hello_otto.txt':
    ensure  => file,
    content => "Hello Mr. Otto -- localhost 1 only\n",
  }
  exec { 'Store Date':
    command => 'date > date.dat  ',
    cwd     =>  /tmp ,

  }
}
node 'PuppetAgent2' {

  file { '/tmp/hello_otto.txt':
    ensure  => file,
    content => "Hello Mr. Otto -- localhost 2 only\n",
  }

  file {'/etc/motd':
    source => 'vagrant/examples/files/motd.txt',
  }

  file {'/tmp/james_otto_dir':
         ensure => directory,
         owner  => 'vagrant',
         group  => 'vagrant',
  }

  file {'/tmp/james_otto_dir/otto_test':
         ensure => present,
         owner  => 'vagrant',
         group  => 'vagrant',
         content => 'Forescore and seven years ago our fathers brought forth on this continent a new nation, conceived in liberty, and dedicated to the propisition that all  men are created equal.  Now we are engaged in a  great civil war, testing whether that nation,  or any nation so conceived and so dedicated, can  long endure.  We are met on a great battlefield of  that war.  We have come to dedicate a portion of  that field as a final resting place for those who  here gave their lives that that nation might live.   It is altogether fitting and proper that we should  do this...The world will little note nor long  remember what we say here, but it can never forget  what they did here.  It is for us the living, rather,  to be dedicated here for the unfinished work which  they who fought here have thus far so nobly advanced.   It is rather for us to be here dedicated to the great  task remaining before us--that from these honored  dead we take increased devotion to that cause for  which they gave the last full measure of their  devotion-- that we here highly resolve that these  dead shall not have died in vain--that this nation,  under God, shall have a new birth of freedom--and  that the government of the people, by the people,  and for the people, shall not perish from the earth. ',
  }

  file {'/tmp/james_otto_dir/otto_test2':
         source => 'http://www.jr.co.il/humor/yiddish.txt',
         owner  => 'vagrant',
         group  => 'vagrant',
    }
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
