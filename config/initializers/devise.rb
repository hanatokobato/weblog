Devise.setup do |config|
  # config.secret_key = '95cca8816befa8383bf43efbae6d5118b4a07b45ab69cf730b2de63511108ea1408dc436b550453fef8dabb513dc056d271a6b112c64b0f993099f6db5a5e453'

  # ==> Mailer Configuration
  config.mailer_sender = "please-change-me-at-config-initializers-devise@example.com"

  # Configure the class responsible to send e-mails.
  # config.mailer = 'Devise::Mailer'

  # Configure the parent class responsible to send e-mails.
  # config.parent_mailer = 'ActionMailer::Base'

  # ==> ORM configuration
  require "devise/orm/active_record"

  # ==> Configuration for any authentication mechanism
  # config.authentication_keys = [:email]

  # config.request_keys = []

  config.case_insensitive_keys = [:email]

  config.strip_whitespace_keys = [:email]

  # config.params_authenticatable = true

  # config.http_authenticatable = false

  # config.http_authenticatable_on_xhr = true

  # config.http_authentication_realm = 'Application'

  # config.paranoid = true

  config.skip_session_storage = [:http_auth]

  # config.clean_up_csrf_token_on_authentication = true

  # config.reload_routes = true

  # ==> Configuration for :database_authenticatable
  config.stretches = Rails.env.test? ? 1 : 11

  # config.pepper = '35c079b54d94cb3c9a8c148b307444b6cc76fd9b37bdcef24e3b49fe0064d6c0d25e09742486982578a421b9e648110a771930aa07072c9589db2d38b8a8f78d'

  # config.send_email_changed_notification = false

  # config.send_password_change_notification = false

  # ==> Configuration for :confirmable
  # config.allow_unconfirmed_access_for = 2.days

  # config.confirm_within = 3.days

  config.reconfirmable = true

  # config.confirmation_keys = [:email]

  # ==> Configuration for :rememberable
  # config.remember_for = 2.weeks

  config.expire_all_remember_me_on_sign_out = true

  # config.extend_remember_period = false

  # config.rememberable_options = {}

  # ==> Configuration for :validatable
  config.password_length = 6..128

  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/

  # ==> Configuration for :timeoutable
  # config.timeout_in = 30.minutes

  # ==> Configuration for :lockable
  # config.lock_strategy = :failed_attempts

  # config.unlock_keys = [:email]

  # config.unlock_strategy = :both

  # config.maximum_attempts = 20

  # config.unlock_in = 1.hour

  # config.last_attempt_warning = true

  # ==> Configuration for :recoverable

  # config.reset_password_keys = [:email]

  config.reset_password_within = 6.hours

  # config.sign_in_after_reset_password = true

  # ==> Configuration for :encryptable

  # config.encryptor = :sha512

  # ==> Scopes configuration

  # config.scoped_views = false

  # config.default_scope = :user

  # config.sign_out_all_scopes = true

  # ==> Navigation configuration
  # config.navigational_formats = ['*/*', :html]

  config.sign_out_via = :delete

  # ==> OmniAuth
  # config.omniauth :github, 'APP_ID', 'APP_SECRET', scope: 'user,public_repo'

  # ==> Warden configuration
  # config.warden do |manager|
  #   manager.intercept_401 = false
  #   manager.default_strategies(scope: :user).unshift :some_external_strategy
  # end

  # ==> Mountable engine configurations
  #
  #     mount MyEngine, at: '/my_engine'
  #
  # config.router_name = :my_engine
  #
  # When using OmniAuth, Devise cannot automatically set OmniAuth path,
  # so you need to do it manually. For the users scope, it would be:
  # config.omniauth_path_prefix = '/my_engine/users/auth'
end
