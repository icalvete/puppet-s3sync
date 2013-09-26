class s3sync::install
{

  common::down_resource {'s3sync_get_package':
    scheme   => $s3sync::repo_scheme,
    domain   => $s3sync::repo_domain,
    port     => $s3sync::repo_port,
    user     => $s3sync::repo_user,
    pass     => $s3sync::repo_pass,
    path     => $s3sync::repo_path,
    resource => $s3sync::repo_resource,
  }

  exec {'s3sync_install_package':
    cwd             => '/root',
    command         => "/bin/tar xfz /tmp/${s3sync::repo_resource}",
    require         => Common::Down_resource['s3sync_get_package'],
    unless          => '/usr/bin/test -d /root/s3sync'
  }
}
