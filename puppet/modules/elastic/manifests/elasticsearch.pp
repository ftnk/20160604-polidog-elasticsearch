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
}
