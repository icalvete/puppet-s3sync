class s3sync (

  $aws_access_key_id     = undef,
  $aws_secret_access_key = undef,
  $ssl_cert_dir          = undef,
  $aws_calling_format    = undef,
  $repo_scheme           = $s3sync::params::repo_scheme,
  $repo_domain           = $s3sync::params::repo_domain,
  $repo_port             = $s3sync::params::repo_port,
  $repo_user             = $s3sync::params::repo_user,
  $repo_pass             = $s3sync::params::repo_pass,
  $repo_path             = $s3sync::params::repo_path,
  $repo_resource         = $s3sync::params::package

) inherits s3sync::params {

  if ! $aws_access_key_id {
    fail('aws_access_key_id parameter can\'t be empty')
  }

  if ! $aws_secret_access_key {
    fail('aws_secret_access_key parameter can\'t be empty')
  }

  if ! $ssl_cert_dir {
    fail('ssl_cert_dir parameter can\'t be empty')
  }

  if ! $aws_calling_format {
    fail('aws_calling_format parameter can\'t be empty')
  }

  anchor {'s3sync::begin':
    before => Class['s3sync::install']
  }

  class {'s3sync::install':
    require => Anchor['s3sync::begin']
  }

  class {'s3sync::config':
    aws_access_key_id     => $aws_access_key_id,
    aws_secret_access_key => $aws_secret_access_key,
    ssl_cert_dir          => $ssl_cert_dir,
    aws_calling_format    => $aws_calling_format,
    require               => Class['s3sync::install']
  }

  anchor {'s3sync::end':
    require => Class['s3sync::config']
  }
}
