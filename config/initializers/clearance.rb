Clearance.configure do |config|
  config.allow_sign_up = false
  config.mailer_sender = "reply@example.com"
  config.rotate_csrf_on_sign_in = true
  config.redirect_url = "/admin"
end
