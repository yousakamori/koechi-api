class Me::PasswordsController < ApplicationController
  def update
    if current_user&.authenticate(params[:old_password])
      current_user.update!(password: me_params[:new_password])
      head :no_content
    else
      json_response({ message: '現在のパスワードが正しくありません' }, :unprocessable_entity)
    end
  end

  private

  def me_params
    params.permit(:old_password, :new_password)
  end
end
