class apache (){

  package { 'apache':
    ensure => installed,
    name   => 'httpd',
  }

  service { 'apache':
    ensure => running,
    enable => true,
    name   => 'httpd',
  }

  firewall { '100 allow inbound http (80)':
    dport  => 80,
    proto  => tcp,
    action => accept,
  }

  file { '/var/log/httpd':
    ensure => directory,
    owner  => 'root',
    group  => 'td-agent',
    mode   => '750',
  }
}
