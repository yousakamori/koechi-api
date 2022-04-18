class FollowRelationshipsController < ApplicationController
  before_action :same_user_error, only: [:create]
  def create
    ActiveRecord::Base.transaction do
      current_user.follow!(params[:user_id])

      # notification
      recipient = User.find(params[:user_id])

      Notification.send_recipient!(action: 'follow', recipient: recipient, sender: @current_user)
    end

    head :no_content
  end

  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow!(user)

    head :no_content
  end

  private

  def same_user_error
    json_response({ message: '自分はフォローできません。' }, :bad_request) if @current_user.id == params[:user_id]
  end
end
