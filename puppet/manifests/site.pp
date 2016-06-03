node default {

  include ::my_fw

  include ::apache
  include ::elastic
  include ::elastic::elasticsearch
  include ::elastic::kibana
  include ::td_agent

  td_agent::plugin { 'fluent-plugin-elasticsearch': }
  td_agent::plugin { 'fluent-plugin-dstat': }

  package { 'java':
    ensure => installed,
    name   => 'java-1.8.0-openjdk',
  }

  package { 'ruby':
    ensure => installed,
  }

  # CentOS 6 の Ruby は 1.8 系のため、
  # Ruby 2.0 以降を必要とする net-ssh 3.0 以降は使えない。
  package { 'net-ssh':
    ensure   => '2.9.4',
    provider => gem,
    require  => Package['ruby'],
  }

  package { 'serverspec':
    ensure   => installed,
    provider => gem,
    require  => [
                 Package['ruby'],
                 Package['net-ssh'],
                 ],
  }

  package { 'python-setuptools':
    ensure => installed,
  }

  exec { 'install pip':
    command => 'easy_install pip',
    path    => '/usr/bin:/bin',
    creates => '/usr/bin/pip',
    require => Package['python-setuptools'],
  }

  exec { 'install elasticsearch-curator':
    command => 'pip install elasticsearch-curator',
    path    => '/usr/bin:/bin',
    creates => '/usr/bin/curator',
    require => Exec['install pip'],
  }
}
