Rails.configuration.to_prepare do
  ActionMailer::Base.add_delivery_method :sendgrid, Mail::SendGrid,
                                         api_key: Rails.application.credentials.dig(:sendgrid, :sendgrid_api_key)
end
