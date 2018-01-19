Devise.setup do |config|
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  require "devise/orm/active_record"

  config.secret_key = "f6187ca24b8b17055f186e5b3eadfe38bd1cdc2b1e72cb0ec32783a612f432f2d0ee877a9b48571bdd54ecc4a7925568c0a79bede6e865cafe49d4b9ee077954"

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  config.skip_session_storage = [:http_auth]

  config.stretches = Rails.env.test? ? 1 : 11

  config.reconfirmable = true

  config.expire_all_remember_me_on_sign_out = true

  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  config.reset_password_within = 6.hours

  config.sign_out_via = :delete

  config.omniauth :facebook, ENV["facebook_app_id"], ENV["facebook_app_secret"]
  config.omniauth :google_oauth2, ENV["google_app_id"], ENV["google_app_secret"]
end
