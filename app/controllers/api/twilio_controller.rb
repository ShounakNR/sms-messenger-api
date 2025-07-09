class Api::TwilioController < ApplicationController
  skip_before_action :verify_authenticity_token

  def status
    sid = params["MessageSid"]
    status = params["MessageStatus"]

    message = Message.find_by(twilio_sid: sid)
    if message
      message.update(status: status)
    end

    head :ok
  end
end
