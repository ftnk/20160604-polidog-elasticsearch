class apache (){

  package { 'apache':
    ensure => installed,
    name   => 'httpd',
  }

  package { 'mod_ssl':
    ensure => installed,
    notify => Service['apache']
  }

  service { 'apache':
    ensure  => running,
    enable  => true,
    name    => 'httpd',
    require => Package['apache'],
  }

  firewall { '100 allow inbound http (80)':
    dport  => 80,
    proto  => tcp,
    action => accept,
  }

  file { '/etc/httpd/conf.d/vhosts.conf':
    ensure  => file,
    source  => 'puppet:///modules/apache/vhosts.conf',
    require => Package['apache'],
    notify  => Service['apache']
  }

  file { '/var/log/httpd':
    ensure => directory,
    owner  => 'root',
    group  => 'td-agent',
    mode   => '750',
    require => Package['td-agent'],
  }

  file { '/var/www/combined':
    ensure  => directory,
    require => Package['apache'],
  }

  file { '/var/www/combined/logs':
    ensure => directory,
    mode   => '755',
  }

  file { '/var/www/combined/htdocs':
    ensure => directory,
  }

  file { '/var/www/combined/htdocs/index.html':
    ensure  => file,
    content => "combined\n",
  }

  file { '/var/www/ltsv':
    ensure  => directory,
    require => Package['apache'],
  }

  file { '/var/www/ltsv/logs':
    ensure => directory,
    mode   => '755',
  }

  file { '/var/www/ltsv/htdocs':
    ensure => directory,
  }

  file { '/var/www/ltsv/htdocs/index.html':
    ensure  => file,
    content => "ltsv\n",
  }
}
