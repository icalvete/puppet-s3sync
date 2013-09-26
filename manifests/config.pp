class s3sync::config (
  $aws_access_key_id     = undef,
  $aws_secret_access_key = undef,
  $ssl_cert_dir          = undef,
  $aws_calling_format    = undef
) {

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
    fail("$aws_calling_format parameter can\'t be empty")
  }

  file { $s3sync::params::s3sync_dir_conf:
    ensure => directory
  }
  file { "${s3sync::params::s3sync_dir_conf}/certs":
    ensure  => directory,
    require => File[$s3sync::params::s3sync_dir_conf]
  }
  file {'s3sync_conf_file':
    ensure  => present,
    path    => "${s3sync::params::s3sync_dir_conf}/s3config.yml",
    content => template("${module_name}/s3config.yml.erb")
  }
}
