class Users::SessionsController < Devise::SessionsController

  respond_to :json

  # protect_from_forgery with: :null_session

  def flash; end
  def flash=(value); end
  def set_flash_message!(*args); end
  def set_flash_message(*args); end

  private

  def respond_with(resource, _opts = {})
    render json: { message: 'Logged in.', user: resource }, status: :ok
  end

  def respond_to_on_destroy
    render json: { message: 'Logged out.' }, status: :ok
  end
end
