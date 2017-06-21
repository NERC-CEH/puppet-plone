# Standard parameters for the plone class

class plone::params {

  # Pillow dependencies based on info supplied by
  #  http://pillow.readthedocs.org/en/latest/installation.html#linux-installation

  case $::osfamily {

    'RedHat': {
      $pillow_deps = ['libtiff-devel','libjpeg-turbo-devel','libzip-devel',
                   'freetype-devel','lcms2-devel','tcl-devel','tk-devel']
    }

    'Debian': {
      $pillow_deps = $::lsbmajdistrelease ? {
        /^12/ => ['libtiff4-dev','libjpeg8-dev','zlib1g-dev','libfreetype6-dev',
               'liblcms2-dev','libwebp-dev','tcl8.5-dev','tk8.5-dev','python-tk'],
        /^14/ => ['libtiff5-dev','libjpeg8-dev','zlib1g-dev','libfreetype6-dev',
               'liblcms2-dev','libwebp-dev','tcl8.6-dev','tk8.6-dev','python-tk'],
        /^16/ => ['libtiff5-dev','libjpeg8-dev','zlib1g-dev','libfreetype6-dev',
               'liblcms2-dev','libwebp-dev','tcl8.6-dev','tk8.6-dev','python-tk'],
        }
    }

    default: {
      fail("Operating system ${::osfamily} is not supported!")
    }
  }

}
