class elastic::kibana (){

  file { '/etc/yum.repos.d/kibana.repo':
    ensure => file,
    source => 'puppet:///modules/elastic/kibana.repo',
  }

  package { 'kibana':
    ensure  => installed,
    require => [
      Exec['import elastic gpg key'],
      File['/etc/yum.repos.d/kibana.repo'],
    ],
  }

  service { 'kibana':
    ensure => running,
    enable => true,
  }
}
