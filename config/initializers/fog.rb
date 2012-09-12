s3_config = "#{Rails.root}/config/amazon_s3.yml"
s3_credentials = YAML.load_file(s3_config)[Rails.env]

CarrierWave.configure do |config|
  unless Rails.env.test? || Rails.env.development?
    config.storage = :fog
    config.fog_directory = ENV['S3_BUCKET'] || s3_credentials['bucket']

    config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => ENV['S3_KEY'] || s3_credentials['access_key_id'],
      :aws_secret_access_key => ENV['S3_SECRET'] || s3_credentials['secret_access_key']
    }
	  config.fog_attributes = { 'Cache-Control'=>'max-age=315576000' }
  else
    config.storage = :file
  end
end
