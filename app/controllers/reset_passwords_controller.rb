class ResetPasswordsController < ApplicationController
  skip_before_action :authenticate_user
  before_action :set_user, only: [:check_token, :update]

  def create
    user = User.find_by(email: params[:email])
    user&.send_email!(:reset_password)

    head :no_content
  end

  def check_token
    render json: { valid_token: !!@user }
  end

  def update
    @user.update!(reset_password_params)
    head :no_content
  end

  private

  def set_user
    @user = User.find_signed(params[:token], purpose: :reset_password) if params[:token]
  end

  def reset_password_params
    params.permit(:password)
  end
end
