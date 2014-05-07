#
class ccg_apache (
  $user=$::ccg_apache::params::user,
  $group=$::ccg_apache::params::group
) inherits ccg_apache::params {

  package { $ccg_apache::params::packages:
    ensure => installed
  }

  service { $ccg_apache::params::service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$ccg_apache::params::packages]
  }

  file {"${ccg_apache::params::conf_d}/ccgapps.conf":
    content => "Include ${ccg_apache::params::conf_d}/*.ccg\n",
    owner   => $user,
    group   => $group,
    require => Package[$ccg_apache::params::packages]
  } ~> Service[$ccg_apache::params::service_name]

  file {$ccg_apache::params::index_html:
    content => '',
    owner   => $user,
    group   => $group,
    require => Package[$ccg_apache::params::packages]
  }
}
