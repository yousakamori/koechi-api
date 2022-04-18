class Validators::UsersController < ApplicationController
  skip_before_action :authenticate_user

  def username_taken
    username = params[:username]
    taken = User.activated.exists?(username: params[:username]) || username&.match?(PathRegex.full_namespace_path_regex)
    render json: { taken: taken }
  end

  def email_taken
    taken = User.activated.exists?(email: params[:email])
    render json: { taken: taken }
  end
end
