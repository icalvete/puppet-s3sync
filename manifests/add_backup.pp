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

  cron { "add_backup_${name}_${target}":
    command => "/root/s3sync/s3sync.rb -r ${target} ${s3bucket}:${::hostname}",
    user    => 'root',
    hour    => '4',
    minute  => '0'
  }
}
