class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    if params[:token]
      user = User.find_signed(params[:token], purpose: :confirmation_email)
    elsif params[:email]
      user = User.find_by(email: params[:email]&.downcase)
    end

    if user&.authenticate(params[:password])
      login(user)
      render 'mes/show', formats: :json
    else
      json_response({ message: params[:token] ? '認証に失敗しました' : 'ログイン情報をお確かめ下さい' }, :bad_request)
    end
  end

  def destroy
    logout
    head :no_content
  end
end
