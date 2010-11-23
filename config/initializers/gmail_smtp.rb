ActionMailer::Base.default_url_options = {:host => 'localhost:3000'}
ActionMailer::Base.raise_delivery_errors = true
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :enable_starttls_auto => true,
  :address => "smtp.gmail.com",
  :port => 587,
  :authentication => :plain,
  :domain => ENV['GMAIL_SMTP_USER'],
  :user_name => ENV['GMAIL_SMTP_USER'],
  :password => ENV['GMAIL_SMTP_PASSWORD']
}
