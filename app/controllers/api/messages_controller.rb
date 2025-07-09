class Api::MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: [ :show, :update, :destroy ]

  respond_to :json

  # GET /api/messages
  def index
    render json: current_user.messages
  end

  # GET /api/messages/:id
  def show
    render json: @message
  end

  # POST /api/messages
  def create
    message = current_user.messages.build(message_params)
    if message.save
      TwilioService.new.send_sms(message: message)
      render json: message, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/messages/:id
  def update
    if @message.update(message_params)
      render json: @message
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /api/messages/:id
  def destroy
    @message.destroy
    head :no_content
  end

  private

  def set_message
    @message = current_user.messages.find(params[:id])
  rescue Mongoid::Errors::DocumentNotFound
    render json: { error: "Message not found" }, status: :not_found
  end

  def message_params
    params.require(:message).permit(:content, :phone_number)
  end
end
