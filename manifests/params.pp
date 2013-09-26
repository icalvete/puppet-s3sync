class s3sync::params {
  case $::operatingsystem {
    default: {
      $s3sync_dir_conf = '/root/.s3conf'
      $repo_scheme     = hiera('sp_repo_scheme')
      $repo_domain     = hiera('sp_repo_domain')
      $repo_port       = hiera('sp_repo_port')
      $repo_user       = hiera('sp_repo_user')
      $repo_pass       = hiera('sp_repo_pass')
      $repo_path       = hiera('sp_repo_path')
      $package         = hiera('s3sync_package')
    }
  }
}
