define mailman::domain(
  $ensure,
  $vhost    = undef,
  $urlpath  = '/cgi-bin/mailman/',
  $language = 'en',
) {
  postfix::transport {$name:
    ensure      => present,
    destination => 'mailman',
  }

  file {'/etc/mailman/mm_cfg.py':
    ensure  => file,
    content => template('mailman/mm_cfg.py.erb'),
    require => Package['mailman'],
  }

  file {'/etc/mailman/apache.conf':
    ensure  => file,
    content => template('mailman/apache.conf.erb'),
    require => Package['mailman'],
  }
}
