class LikesController < ApplicationController
  before_action :set_like
  before_action :authorize_archive

  def create
    @like.with_lock do
      @like.liked = params[:liked]
      @like.save!

      if @like.liked
        # notification
        Notification.to_recipient!(action: :like, recipient: @like.likable.user,
                                   sender: @current_user, notifiable: @like.likable)
      end
    end

    render json: { liked: @like.liked }
  end

  private

  def set_like
    @like = @current_user.likes.find_or_initialize_by(likable_id: params[:likable_id],
                                                      likable_type: params[:likable_type])
  end

  def authorize_archive
    return unless @like.likable_type == 'Talk'

    raise ExceptionHandler::ArchivedError if @like.likable.archived?
  end
end
