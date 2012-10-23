class mailman {
  package {"mailman":
    ensure => present,
  }

  service {"mailman":
    ensure     => running,
    require    => Package["mailman"],
    hasstatus  => false,
    hasrestart => true,
    pattern    => '/usr/lib/mailman/bin/mailmanctl -s -q start',
  }

  exec {"mailman set password":
    command => "/usr/sbin/mmsitepass ree2tahG",
    creates => "/var/lib/mailman/data/adm.pw",
    require => Package["mailman"],
  }

  # BUG: I couldn't get this type to work...
  
  #maillist {"mailman":

  if $mailmanowner {
    $postmaster = $mailmanowner
  } else {
    $postmaster = "postmaster@camptocamp.com"
  }
}
