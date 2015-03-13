# Class: plone
#
# This module manages plone dependencies and includes
# an type to build sites from a buildout source
#
# Parameters:
#   enable_ldap: include packages required for ldap connectivity
#   enable_indexer: include packages required for optional indexing
#
# Actions:
#
# Requires: see Modulefile
#
# Sample Usage:
#   class {'plone':
#     enable_ldap => true
#   }
#
# Authors:
#   Mike Wilson, mw@ceh.ac.uk
#
class plone (
  $enable_ldap     = false,
  $enable_indexers = false,
  ) inherits plone::params {

    package { $pillow_deps:
      alias   => 'pillow_deps',
      ensure  => installed,
    }

    # Work around for bug in Ubuntu 14 see
    # https://github.com/collective/buildout.python/issues/39
    if ($::osfamily == 'Debian') and ($::lsbmajdistrelease == '14') {
      file { '/usr/include/freetype':
        ensure  => link,
        target  => '/usr/include/freetype2',
        require => Package['pillow_deps'],
      }
    }

    # XML libraries required for lxml
    package { 'libxml2-dev':
      ensure  => installed,
    }

    package { 'libxslt1-dev':
      ensure  => installed,
    }

    # Text based browser required for Plone transforms
    package { 'lynx':
      ensure => installed,
    }

    if $enable_indexers {
      # Optional utilities that we use to index Word/PDF docs
      package { 'wv':
        ensure  => installed,
      }

      package { 'poppler-utils':
        ensure => installed,
      }
    }

    if $enable_ldap {
      package { 'libldap2-dev':
        ensure => installed,
      }

      package { 'libsasl2-dev':
        ensure => installed,
      }
    }
}
