s3_config = "#{Rails.root}/config/amazon_s3.yml"
s3_credentials = YAML.load_file(s3_config)[Rails.env]


# Configure Spree Preferences
# 
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do: 
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to override the default site name.
  config.site_name = "NearFive"
  if Rails.env.production?
    config.use_s3 = true
  	config.s3_access_key = ENV['S3_KEY'] || s3_credentials['access_key_id'],
  	config.s3_secret =     ENV['S3_SECRET'] || s3_credentials['secret_access_key']
  	config.s3_bucket =     ENV['S3_BUCKET'] || s3_credentials['bucket']
  end
end

Spree.user_class = "Spree::User"

Spree::Config.set(:allow_ssl_in_staging => false)