class mailman(
  $mailman_password,
  $postmaster = "postmaster@${::domain}",
) {

  package {'mailman':
    ensure => present,
  }

  service {'mailman':
    ensure     => running,
    require    => Package['mailman'],
    hasstatus  => false,
    hasrestart => true,
    pattern    => '/usr/lib/mailman/bin/mailmanctl -s -q start',
  }

  # Based on mmsitepass python script, we do not need to use it
  # as it simply output the SHA1 in a file. This file cannot be configured
  # in mailman options. We just have to take care of the file rights.
  $hased_pass = sha1($mailman_password)
  file {'/var/lib/mailman/data/adm.pw':
    ensure  => present,
    owner   => 'root',
    group   => 'list',
    mode    => '0640',
    content => $hased_pass,
  }
}
