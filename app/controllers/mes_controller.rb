class MesController < ApplicationController
  def show
    render 'show', formats: :json
  end

  def update
    if me_params[:avatar]
      # TODO: minimagixk => ruby-vipsにしたい
      # オリジナル画像を処理
      image = MiniMagick::Image.new(me_params[:avatar].tempfile.path)
      image.auto_orient
      image.thumbnail('240x240')
      image.gravity :center
      image.quality 80
    end

    @current_user.update!(me_params)

    render 'show', formats: :json
  end

  def destroy
    if @current_user.activated?
      # 本登録時
      if current_user&.authenticate(params[:password])
        @current_user.destroy!
        head :no_content
      else
        json_response({ message: 'パスワードが正しくありません' }, :unprocessable_entity)
      end
    else
      # 仮登録時
      @current_user.destroy!
      logout
      head :no_content
    end
  end

  private

  def me_params
    if @current_user.username.nil?
      # 初会登録
      params.permit(:id, :name, :password, :username, :bio, :avatar)
    else
      # 更新
      params.permit(:id, :name, :bio, :avatar, :twitter_username,
                    :email_notify_comments, :email_notify_followings, :email_notify_likes)
    end
  end
end
