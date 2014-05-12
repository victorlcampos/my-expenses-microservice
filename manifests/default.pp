$home         = '/home/vagrant'
$as_vagrant   = 'sudo -u vagrant -H bash -l -c'

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['packages']
}

class preinstall {
  exec { "apt-update":
    command => "apt-get -y update",
    unless => "test -e ${home}/.rvm"
  }

  class {'locales':
    locales => 'en_US.UTF-8 UTF-8',
  }
}
class { 'preinstall':
  stage => preinstall
}

# --- Packages Stage -----------------------------------------------------------

stage { 'packages':
  before => Stage['main']
}

class packages {
  package {
    [ 'build-essential',
      'zlib1g-dev',
      'libssl-dev',
      'libreadline-dev',
      'git-core',
      'libxml2',
      'libxml2-dev',
      'libxslt1-dev',
      'libpam-dev',
      'libedit-dev',
      'libsqlite3-dev',
      'sqlite3',
      'nodejs',
      'imagemagick',
    ]:
    ensure => installed
  }
}
class { 'packages':
  stage => packages
}

# --- Postgresql Stage ---------------------------------------------------------
class install_postgresql {
  class { 'postgresql::server':
    require => [Class['locales']]
  }

  postgresql::server::role { 'vagrant':
    password_hash => postgresql_password('123456', '123456'),
    createdb   => true,
    createrole => true,
    superuser => true
  }

  postgresql::server::role { 'rails':
    password_hash => postgresql_password('123456', '123456'),
    createdb   => true,
    createrole => true,
    superuser => true
  }
}
class { 'install_postgresql': }

class install_rvm {
  include rvm
  rvm::system_user { vagrant: ;}
  rvm_system_ruby {
  'ruby-2.1':
    ensure      => 'present',
    default_use => true;
  }
}
class { 'install_rvm': }