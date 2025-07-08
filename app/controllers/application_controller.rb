class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  # protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
