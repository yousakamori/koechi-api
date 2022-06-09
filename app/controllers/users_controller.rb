class UsersController < ApplicationController
  skip_before_action :authenticate_user
  before_action :set_user, only: %i[show followers followings comments]
  # ___________________________________________________________________________
  #
  def create
    password = User.generate_signup_code
    user = User.where(user_params.merge(username: nil)).first_or_create! do |u|
      u.password = password
    end
    user.send_email!(:confirmation_email, password)

    head :no_content
  end

  def show
    render 'show', formats: :json
  end

  def followers
    @followers = @user.follower_relationships.order(created_at: :desc).page(params[:page]).per(params[:count] || Rails.configuration.x.app.per_page_follower).includes([follower: { avatar_attachment: :blob }])

    render 'followers', formats: :json
  end

  def followings
    @followings = @user.following_relationships.order(created_at: :desc).page(params[:page]).per(params[:count] || Rails.configuration.x.app.per_page_following).includes([following: { avatar_attachment: :blob }])

    render 'followings', formats: :json
  end

  def comments
    @comments = @user.comments.includes([:commentable]).where(comments: { commentable_type: 'Talk' }).order(created_at: :desc).page(params[:page]).per(params[:count] || Rails.configuration.x.app.per_page_comment)

    render 'comments', formats: :json
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end

  def user_params
    params.permit(:email)
  end
end
