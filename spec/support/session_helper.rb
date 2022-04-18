module SessionHelper
  def is_logged_in?
    !session[:user_id].nil?
  end

  def log_in_as(email, password)
    post '/login', params: { email: email, password: password }
  end
end
