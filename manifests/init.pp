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
      ensure => installed,
    }

    package { $other_deps:
      ensure => installed,
    }

    if $enable_indexers {
      # Optional utilities that we use to index Word/PDF docs
      package { $index_deps:
        ensure => installed,
      }
    }

    if $enable_ldap {
      package { $ldap_deps:
        ensure => installed,
      }
    }
}
