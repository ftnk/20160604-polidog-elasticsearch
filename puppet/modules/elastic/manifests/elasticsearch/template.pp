define elastic::elasticsearch::template (
){
  $filename = "/etc/elasticsearch/templates/${name}"

  exec { "post template ${name}":
    command => "curl -XPUT localhost:9200/_template/${name} -d \"$(cat ${filename})\"",
    path    => '/usr/bin:/bin',
    unless  => "curl -XGET localhost:9200/_template/ |grep ${name} > /dev/null",
    require => [
      File[$filename],
      Service['elasticsearch'],
    ],
  }
}
