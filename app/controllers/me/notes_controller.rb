class Me::NotesController < ApplicationController
  before_action :set_spaces
  before_action :set_notes

  PER_PAGE_NOTES = 50
  def show
    @notes = @notes.order(posted_at: :desc).page(params[:page]).per(params[:count] || PER_PAGE_NOTES)
    # posted_at
    @notes = @notes.where(posted_at: Time.at(params[:posted_at].to_i).all_day) if params[:posted_at]

    render 'show', formats: :json, handlers: 'jbuilder'
  end

  def term
    start_date = Time.at(params[:start].to_i)
    end_date = Time.at(params[:end].to_i).end_of_day
    @notes = @notes.where(posted_at: (start_date..end_date)).order(:posted_at)

    render 'term', formats: :json, handlers: 'jbuilder'
  end

  private

  def set_spaces
    @spaces = @current_user.spaces
  end

  def set_notes
    @notes = Note.includes([{ space: [:memberships] },
                            { user: { avatar_attachment: :blob } }]).active.where(space_id: @spaces.ids)
  end
end
