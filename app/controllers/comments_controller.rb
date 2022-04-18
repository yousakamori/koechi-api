class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]

  def create
    @comment = @current_user.comments.new(create_comment_params)
    authorize_archive

    ActiveRecord::Base.transaction do
      @comment.save!

      # notification
      action = @comment.parent_id ? 'comment_reply' : 'comment'

      if action == 'comment_reply'
        recipients = @comment.parent.children.map(&:user).push(@comment.parent.user).uniq

        recipients.each do |recipient|
          Notification.send_recipient!(action: action, recipient: recipient, sender: @current_user, notifiable: @comment)
        end
      end

      if action ==  'comment'
        recipient = @comment.commentable.user

        Notification.send_recipient!(action: action, recipient: recipient, sender: @current_user, notifiable: @comment)
      end
    end

    render 'create', formats: :json, handlers: 'jbuilder'
  end

  def update
    @comment.update!(update_comment_params)
    render json: @comment.as_json({ only: [:body_text, :body_json] })
  end

  def destroy
    @comment.destroy!
    head :no_content
  end

  private

  def set_comment
    @comment = @current_user.comments.find_by!(slug: params[:slug])
  end

  def authorize_archive
    return unless @comment.commentable_type == 'Talk'

    raise ExceptionHandler::ArchivedError if @comment.commentable&.archived?
  end

  def create_comment_params
    params.permit(:body_text, :body_json, :parent_id, :commentable_id, :commentable_type)
  end

  def update_comment_params
    params.permit(:body_text, :body_json)
  end
end
