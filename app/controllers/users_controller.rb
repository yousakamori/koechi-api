class UsersController < ApplicationController
  skip_before_action :authenticate_user
  before_action :set_user, only: [:show, :followers, :followings, :comments]
  # ___________________________________________________________________________
  #
  def create
    user = User.find_or_initialize_by(user_params.merge(activated_at: nil))
    user.email_registration!
    head :no_content
  end

  def show
    render 'show', formats: :json
  end

  PER_PAGE_FOLLOWERS = 40
  def followers
    @follows = @user.follower_relationships.order(created_at: :desc).page(params[:page]).per(params[:count] || PER_PAGE_FOLLOWERS).includes([follower: { avatar_attachment: :blob }])

    render 'follows', formats: :json
  end

  PER_PAGE_FOLLOWINGS = 40
  def followings
    @follows = @user.following_relationships.order(created_at: :desc).page(params[:page]).per(params[:count] || PER_PAGE_FOLLOWINGS).includes([following: { avatar_attachment: :blob }])

    render 'follows', formats: :json
  end

  PER_PAGE_COMMENTS = 100
  def comments
    @comments = @user.comments.includes([:commentable]).where(comments: { commentable_type: 'Talk' }).order(created_at: :desc).page(params[:page]).per(params[:count] || PER_PAGE_COMMENTS)

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
