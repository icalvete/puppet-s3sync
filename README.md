#puppet-s3sync

Puppet manifest to install and configure s3sync

[![Build Status](https://secure.travis-ci.org/icalvete/puppet-s3sync.png)](http://travis-ci.org/icalvete/puppet-s3sync)

##Actions:

Istall and configure [s3sync](https://github.com/ms4720/s3sync)

##Requires:

* [hiera](http://docs.puppetlabs.com/hiera/1/index.html)
* https://github.com/icalvete/puppet-common but really only need:
  + common::add_env define.
  + An http server and a tgz package or use common::down_resource

##Example:

**Password, keys, certificates... are dummy**

    node fourandgo {
      $tenant   = 'fourandgo'
      $s3bucket = 'fagsp-backup'

      class {'common': stage => 'pre'}

      common::add_env{'TENANT':
        key     => 'TENANT',
        value   => $tenant,
        require => Class['common']
      }
      
      class {'s3sync':
        aws_access_key_id     => 'AKIDIC77DD5534JG88A88A',
        aws_secret_access_key => '2rEBjuvwu8RYDJxIDrrFE67ukHh/Uk++ICVb+Kck2',
        ssl_cert_dir          => '/root/.s3sync/certs',
        aws_calling_format    => 'SUBDOMAIN',
        require               => Class['common']
      }
    }

    node 'fag01.smartpurposes.com' inherits fourandgo {
      $environment = 'PRO'

      common::add_env{'environment':
        key     => 'environment',
        value   => $environment,
        require => Class['common']
      }

       s3sync::add_backup {"log_sp_backup_${::hostname}":
         target    => hiera('sp_log_dir'),
         s3bucket  => $s3bucket
       }
    }

##TODO:

* Refactor to choose the cron setup.


##Authors:

Israel Calvete Talavera <icalvete@gmail.com>
