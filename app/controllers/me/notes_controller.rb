class Me::NotesController < ApplicationController
  before_action :set_spaces
  before_action :set_notes

  def show
    @notes = @notes.order(posted_at: :desc).page(params[:page]).per(params[:count] || Rails.configuration.x.app.per_page_note)

    render 'show', formats: :json
  end

  def term
    start_date = Time.zone.at(params[:start].to_i)
    end_date = Time.zone.at(params[:end].to_i).end_of_day
    @notes = @notes.where(posted_at: (start_date..end_date)).order(:posted_at)

    render 'term', formats: :json
  end

  private

  def set_spaces
    @spaces = @current_user.spaces.active(@current_user)
  end

  def set_notes
    @notes = Note.includes([{ space: [:memberships] },
                            { user: { avatar_attachment: :blob } }]).active.where(space_id: @spaces.ids)
  end
end
