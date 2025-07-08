class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # protect_from_forgery with: :null_session

  def flash; end
  def flash=(value); end
  def set_flash_message!(*args); end
  def set_flash_message(*args); end

  private

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation)
  end
end
