class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  before_action :skip_session_storage

  def flash; end
  def flash=(value); end
  def set_flash_message!(*args); end
  def set_flash_message(*args); end

  def create
    user = User.new(sign_up_params)

    if user.save
      # 🔑 Don't call `sign_in(resource)`
      # Instead, manually use Warden to set user — this works with devise-jwt
      warden.set_user(user)

      render json: {
        message: "Account created successfully",
        user: {
          id: user.id,
          username: user.username,
          email: user.email
        }
      }, status: :ok
    else
      render json: {
        message: "Account could not be created",
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private
  def skip_session_storage
    request.session_options[:skip] = true
  end

  # def respond_with(resource, _opts = {})
  #   if resource.persisted?
  #     render json: {
  #       message: "Account created successfully",
  #       user: {
  #         id: resource.id,
  #         username: resource.username,
  #         email: resource.email
  #       }
  #     }, status: :ok
  #   else
  #     render json: {
  #       message: "Account could not be created",
  #       errors: resource.errors.full_messages
  #     }, status: :unprocessable_entity
  #   end
  # end

  def sign_up_params
    params.require(:user).permit(:username, :password, :password_confirmation, :name, :phone_number)
  end
end
