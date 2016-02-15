Rails.application.config.sorcery.submodules = [:user_activation, :reset_password]

Rails.application.config.sorcery.configure do |config|
  config.user_config do |user|
    user.user_activation_mailer = UserMailer
    user.reset_password_mailer = UserMailer
  end

  config.user_class = "User"
end
