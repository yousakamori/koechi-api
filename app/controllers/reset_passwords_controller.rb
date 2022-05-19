class ResetPasswordsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    user = User.find_by(email: params[:email])
    user&.send_email!(:reset_password)

    head :no_content
  end

  def check_token
    user = User.find_signed(params[:token], purpose: :reset_password) if params[:token]
    render json: { valid_token: !!user }
  end

  def update
    user = User.find_signed!(params[:token], purpose: :reset_password)
    user.update!(reset_password_params)
    head :no_content
  end

  private

  def reset_password_params
    params.permit(:password)
  end
end
