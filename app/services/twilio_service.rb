class TwilioService
  def initialize
    @client = Twilio::REST::Client.new(
      ENV.fetch("TWILIO_ACCOUNT_SID"),
      ENV.fetch("TWILIO_AUTH_TOKEN")
    )
    @to = ENV.fetch("TWILIO_PHONE_NUMBER_TO")
    @from = ENV.fetch("TWILIO_PHONE_NUMBER_FROM")
  end

  def send_sms(message:)
    twilio_message = @client.messages.create(
      from: @from,
      to: @to,
      body: message.content,
      status_callback: Rails.application.routes.url_helpers.api_twilio_status_webhook_url(host: "localhost:3000")
    )

    message.update(twilio_sid: twilio_message.sid, status: "queued")
  end
end
