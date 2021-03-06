class CommentsController < ApplicationController
  before_action :set_comment
  before_action :authorize_archive
  before_action :authorize_user

  def create
    ActiveRecord::Base.transaction do
      @comment.save!

      if @comment.parent_id.nil?
        recipient = @comment.commentable.user

        Notification.to_recipient!(action: :comment, recipient: recipient, sender: @current_user, notifiable: @comment)
      else
        # 返信コメント
        recipients = @comment.parent.children.map(&:user).push(@comment.parent.user).uniq

        recipients.each do |r|
          Notification.to_recipient!(action: :comment_reply, recipient: r, sender: @current_user, notifiable: @comment)
        end
      end
    end

    render 'create', formats: :json
  end

  def update
    @comment.update!(update_comment_params)
    head :no_content
  end

  def destroy
    @comment.destroy!
    head :no_content
  end

  private

  def set_comment
    @comment = if action_name == 'create'
                 @current_user.comments.new(create_comment_params)
               else
                 @current_user.comments.find_by!(slug: params[:slug])
               end
  end

  def authorize_archive
    archived = case @comment.commentable_type
               when 'Talk'
                 @comment.commentable.archived?
               when 'Note'
                 @comment.commentable.space.archived?
               else
                 true
               end

    raise ExceptionHandler::ArchivedError if archived
  end

  def authorize_user
    authorize @comment
  end

  def create_comment_params
    params.permit(:body_text, :body_json, :parent_id, :commentable_id, :commentable_type)
  end

  def update_comment_params
    params.permit(:body_text, :body_json)
  end
end
