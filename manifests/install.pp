class s3sync::install
{

  if $rubyversion =~ /^1\.9/ {
    $resource = "19_${s3sync::repo_resource}"
  } else {
    $resource = $s3sync::repo_resource
  }

  common::down_resource {'s3sync_get_package':
    scheme   => $s3sync::repo_scheme,
    domain   => $s3sync::repo_domain,
    port     => $s3sync::repo_port,
    user     => $s3sync::repo_user,
    pass     => $s3sync::repo_pass,
    path     => $s3sync::repo_path,
    resource => $resource,
  }

  exec {'s3sync_install_package':
    cwd             => $s3sync::install_path,
    command         => "/bin/tar xfz /tmp/${resource}",
    require         => Common::Down_resource['s3sync_get_package'],
    unless          => '/usr/bin/test -d /root/s3sync'
  }
}
