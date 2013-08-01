StuartTerrett::Application.configure do
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
    address:              'smtp.gmail.com',
    port:                 587,
    domain:               'stuartterrett.com',
    user_name:            Auth.email_username,
    password:             Auth.email_password,
    authentication:       'plain',
    enable_starttls_auto: true  }
end
