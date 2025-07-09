class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  # protect_from_forgery with: :null_session

  def flash; end
  def flash=(value); end
  def set_flash_message!(*args); end
  def set_flash_message(*args); end

  def create
    build_resource(sign_up_params)

    if resource.save
      sign_up(resource_name, resource)
      render json: {
        message: "Signed up successfully."
      }, status: :created
    else
      clean_up_passwords resource
      render json: {
        errors: resource.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation, :name, :phone_number)
  end
end
