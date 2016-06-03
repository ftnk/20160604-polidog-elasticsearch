class td_agent (){
  exec { 'import td gpg key':
    command => 'rpm --import https://packages.treasuredata.com/GPG-KEY-td-agent',
    path    => '/usr/bin:/bin',
    unless  => 'rpm -qi gpg-pubkey-a12e206f-52aecba3 > /dev/null'
  }

  file { '/etc/yum.repos.d/td.repo':
    ensure => file,
    source => 'puppet:///modules/td_agent/td.repo',
  }

  package { 'td-agent':
    ensure  => installed,
    require => [
      Exec['import td gpg key'],
      File['/etc/yum.repos.d/td.repo'],
      ],
  }

  service { 'td-agent':
    ensure  => running,
    enable  => true,
    require => Package['td-agent'],
  }

  file { '/etc/td-agent/td-agent.conf':
    ensure  => file,
    source  => 'puppet:///modules/td_agent/td-agent.conf',
    require => Package['td-agent'],
    notify  => Service['td-agent'],
  }
}
