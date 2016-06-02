define td_agent::plugin (
) {
  exec { "td_agent::plugin::${name}":
    command => "/opt/td-agent/usr/sbin/td-agent-gem install ${name}",
    path    => '/opt/td-agent/usr/sbin:/opt/td-agent/usr/bin:/usr/bin:/bin',
    unless  => "/opt/td-agent/usr/sbin/td-agent-gem list |grep ${name} > /dev/null",
    require => Package['td-agent'],
  }
}
