credentials = YAML.load_file("#{Rails.root}/config/aftership.yml")[Rails.env]
Spree::Aftership::Config[:consumer_key] =  credentials['consumer_key']
Spree::Aftership::Config[:consumer_secret] = credentials['consumer_secret']