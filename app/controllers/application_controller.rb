class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::Helpers
  include Devise::Controllers::Helpers

  before_action :debug_jwt
  before_action :skip_session

  def debug_jwt
    Rails.logger.info "Authorization header: #{request.headers['Authorization']}"
  end

  def skip_session
    request.session_options[:skip] = true
  end

  # protect_from_forgery with: :null_session, if: -> { request.format.json? }
end
