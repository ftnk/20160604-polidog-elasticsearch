class elastic::elasticsearch (){
  file { '/etc/yum.repos.d/elasticsearch.repo':
    ensure => file,
    source => 'puppet:///modules/elastic/elasticsearch.repo',
  }

  package { 'elasticsearch':
    ensure  => installed,
    require => [
      Exec['import elastic gpg key'],
      File['/etc/yum.repos.d/elasticsearch.repo'],
    ],
  }

  service { 'elasticsearch':
    ensure => running,
    enable => true,
    require => [
      Package['elasticsearch'],
      Package['java'],
    ],
  }

  firewall { '100 allow inbound elasticsearch (9200)':
    dport  => 9200,
    proto  => tcp,
    action => accept,
  }

  file { '/etc/elasticsearch/templates':
    ensure  => directory,
    require => Package['elasticsearch'],
  }

  file { '/etc/elasticsearch/templates/dstat':
    ensure => file,
    source => 'puppet:///modules/elastic/templates/dstat',
  }

  file { '/etc/elasticsearch/templates/apache_access_ltsv':
    ensure => file,
    source => 'puppet:///modules/elastic/templates/apache_access_ltsv',
  }
}
