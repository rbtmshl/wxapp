CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIKOPHU5YZGSLECMA',       # required
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = 'wxapp'                     # required
end
