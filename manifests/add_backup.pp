define s3sync::add_backup (

  $target   = undef,
  $s3bucket = undef

) {

  if ! $target {
    fail('target parameter can\'t be empty')
  }

  if ! $s3bucket {
    fail('s3bucket parameter can\'t be empty')
  }

  if $rubyversion =~ /^1\.9/ {
    $command = "${s3sync::install_path}/s3sync/bin/s3sync"
  } else {
    $command = "${s3sync::install_path}/s3sync/s3sync.rb"
  }

  cron { "add_backup_${name}_${target}":
    command => "${command} -r ${target} ${s3bucket}:${::hostname}",
    user    => 'root',
    hour    => '4',
    minute  => '0'
  }
}
