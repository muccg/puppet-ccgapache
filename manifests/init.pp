#
class ccgapache (
  $user=$::ccgapache::params::user,
  $group=$::ccgapache::params::group
) inherits ccgapache::params {

  package { $ccgapache::params::packages:
    ensure => installed
  }

  service { $ccgapache::params::service_name:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    require    => Package[$ccg_apache::params::packages]
  }

  file {"${ccgapache::params::conf_d}/ccgapps.conf":
    content => "Include ${ccgapache::params::conf_d}/*.ccg\n",
    owner   => $user,
    group   => $group,
    require => Package[$ccgapache::params::packages]
  } ~> Service[$ccgapache::params::service_name]

  file {$ccgapache::params::index_html:
    content => '',
    owner   => $user,
    group   => $group,
    require => Package[$ccgapache::params::packages]
  }
}
