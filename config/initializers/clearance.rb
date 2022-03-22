Clearance.configure do |config|
  config.allow_sign_up = false
  config.cookie_domain = {
    production: ".exlibrisrpg.com",
    development: [".exlibrisrpg.test", "localhost"],
    test: [".example.com", "localhost"]
  }.fetch(Rails.env.to_sym, nil)
  config.mailer_sender = ENV.fetch("ADMIN_EMAIL_ADDRESS", "reply@example.com")
  config.rotate_csrf_on_sign_in = true
  config.redirect_url = "/admin"
end
