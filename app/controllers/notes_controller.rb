class NotesController < ApplicationController
  before_action :set_note
  before_action :authorize_user

  def show
    @space = @note.space
    @comments = @note.comments.includes(:likes, user: { avatar_attachment: :blob },
                                                children: [:likes, { user: { avatar_attachment: :blob } }]).where(parent_id: nil).order(:created_at)

    @participants = User.group(:id).includes({ avatar_attachment: :blob }).joins(:comments)
                        .where("comments.commentable_id": @note.id).order_as_specified(id: [@note.user.id,
                                                                                            @current_user.id])

    render 'show', formats: :json
  end

  def update
    ActiveRecord::Base.transaction do
      @note.update!(note_params)
      Notification.to_recipient!(action: :note, recipient: @note.space.owner,
                                 sender: @current_user, notifiable: @note)
    end

    head :no_content
  end

  def destroy
    @note.destroy!
  end

  def edit
    render 'edit', formats: :json
  end

  private

  def set_note
    @note = Note.find_by!(slug: params[:slug])
  end

  def authorize_user
    authorize @note
  end

  def note_params
    params.permit(:title, :body_text, :body_json, :posted_at)
  end
end
