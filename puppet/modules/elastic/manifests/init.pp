class elastic (){
  exec { 'import elastic gpg key':
    command => '/bin/rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch',
    path    => '/usr/bin:/bin',
    unless  => '/bin/rpm -qi gpg-pubkey-d88e42b4-52371eca > /dev/null'
  }
}
