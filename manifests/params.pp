# Standard parameters for the plone class

class plone::params {

  # Pillow dependencies based on info supplied by
  #  http://pillow.readthedocs.org/en/latest/installation.html#linux-installation

  case $::osfamily {

    'RedHat': {
      $pillow_deps = ['libtiff-devel','libjpeg-turbo-devel','libzip-devel',
                      'freetype-devel','lcms2-devel','tcl-devel','tk-devel']
      $index_deps  = ['poppler-utils']
      $ldap_deps   = ['openldap-devel','openssl-devel']
      $other_deps  = ['libxml2-devel','libxslt-devel','lynx','bzip2-devel','readline-devel']
    }

    'Debian': {
      $pillow_deps = $::lsbmajdistrelease ? {
        /^16/ => ['libtiff5-dev','libjpeg8-dev','zlib1g-dev','libfreetype6-dev',
                  'liblcms2-dev','libwebp-dev','tcl8.6-dev','tk8.6-dev','python-tk'],
        }
      $index_deps  = ['wv','poppler-utils']
      $ldap_deps   = ['libldap2-dev','libsasl2-dev']
      $other_deps  = ['libxml2-dev','libxslt1-dev','lynx']
    }

    default: {
      fail("Operating system ${::osfamily} is not supported!")
    }
  }

}
