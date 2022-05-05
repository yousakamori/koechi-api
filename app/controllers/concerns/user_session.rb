module UserSession
  extend ActiveSupport::Concern

  private

  def authenticate_user
    if current_user.nil?
      json_response({ message: 'アカウント登録もしくはログインしてください' }, :unauthorized)
    elsif params[:controller] != 'mes' && @current_user.username.nil?
      json_response({ message: 'ユーザー名を登録してください' }, :bad_request)
    end
  end

  def current_user
    return nil unless session[:user_id]

    @current_user ||= User.find_by(id: session[:user_id])
  end

  TIMEOUT = 1.week
  def authenticate_timeout
    return unless current_user

    if session[:user_last_access_time] >= TIMEOUT.ago
      session[:user_last_access_time] = Time.current
    else
      logout
      render json: { message: 'セッションタイムアウト' }, status: :bad_request
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def login(user)
    session[:user_id] = user.id
    session[:user_last_access_time] = Time.current
    @current_user = user
  end

  def logout
    session.delete(:user_id)
    @current_user = nil
  end
end
