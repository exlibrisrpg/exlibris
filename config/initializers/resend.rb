if Rails.env.production?
  Resend.api_key = Rails.application.credentials.dig(:resend, :api_key)
end
