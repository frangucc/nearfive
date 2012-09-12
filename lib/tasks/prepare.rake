namespace :prepare do
  desc "Turn off SSL/mail for dev"
  task :ssl_off => :environment do
    p=Spree::Preference.find_by_key("spree/app_configuration/allow_ssl_in_staging")
    p.value = 0
    p.save!
    puts "allow_ssl_in_production=0"
  end
end