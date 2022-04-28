class Spaces::NotesController < ApplicationController
  before_action :set_space
  before_action :authorize_user
  before_action :authorize_archive

  def index
    @notes = @space.notes.includes([user: { avatar_attachment: :blob }])
                   .active.order(posted_at: :desc).page(params[:page]).per(10)

    render 'index', formats: :json
  end

  def create
    posted_at = Time.zone.at(params[:posted_at]) || Time.current
    note = @current_user.notes.create!(space_id: @space.id, posted_at: posted_at)

    render json: { slug: note.slug }
  end

  private

  def set_space
    @space = Space.find_by!(slug: params[:space_slug])
  end

  def authorize_user
    authorize @space, policy_class: Spaces::NotePolicy
  end

  def authorize_archive
    raise ExceptionHandler::ArchivedError if @space.archived? && !@space.owner?(@current_user)
  end
end
