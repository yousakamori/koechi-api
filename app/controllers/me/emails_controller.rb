class Me::EmailsController < ApplicationController
  def show
    render json: current_user.as_json({ only: [:email] })
  end

  def create
    current_user.update!(unconfirmed_email: me_params[:email])
    current_user.reset_email
    head :no_content
  end

  def update
    user = User.find_signed(params[:token], purpose: :reset_email) if params[:token]

    if user&.authenticate(params[:password])
      user.update!(email: user.unconfirmed_email, unconfirmed_email: nil)
      head :no_content
    else
      json_response({ message: 'パスワードが間違っているか登録期限が過ぎています' }, :unprocessable_entity)
    end
  end

  private

  def me_params
    params.permit(:email)
  end
end
