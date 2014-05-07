#
class ccgapache::params {

  case $::operatingsystem {

    'CentOS': {
      $packages = ['httpd', 'mod_ssl', 'python27-mod_wsgi']
      $service_name = 'httpd'
      $index_html = '/var/www/html/index.html'
      $conf_d = '/etc/httpd/conf.d'
    }

    'Debian', 'Ubuntu': {
      $packages = ['apache2', 'libapache2-mod-wsgi']
      $service_name = 'apache2'
      $index_html = '/var/www/index.html'
      $conf_d = '/etc/apache2/conf.d'
    }

    default: {
      fail("\"${module_name}\" provides no package default value
            for \"${::operatingsystem}\"")
    }
  }
}
