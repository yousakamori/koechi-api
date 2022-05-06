class TalksController < ApplicationController
  skip_before_action :authenticate_user, only: %i[index show]
  before_action :set_talk, only: %i[update destroy]

  PER_PAGE_TALKS = 30
  def index
    @talks = Talk.includes(user: { avatar_attachment: :blob }).where(archived: false).page(params[:page] || 1).per(params[:count] || PER_PAGE_TALKS)

    # min comments count
    @talks = @talks.where(comments_count: params[:min_comments_count].to_i..) if params[:min_comments_count]

    # status => open / close
    @talks = @talks.where(closed: params[:status] == 'closed') if %w[open closed].include?(params[:status])

    # order => latest / alltime / weekly
    @talks = @talks.latest if params[:order] == 'latest'
    @talks = @talks.alltime if params[:order] == 'alltime'
    @talks = @talks.weekly if params[:order] == 'weekly'

    # username
    @talks = @talks.username(params[:username]) if params[:username] && User.exists?(username: params[:username])

    render 'index', formats: :json
  end

  def show
    @talk = Talk.includes(:likes).find_by!(slug: params[:slug])

    authorize @talk

    @user = @talk.user
    @comments = @talk.comments.includes(:likes, user: { avatar_attachment: :blob },
                                                children: [:likes, { user: { avatar_attachment: :blob } }]).where(parent_id: nil).order(:created_at)

    order_fields = @current_user ? [@user.id, @current_user.id] : [@user.id]
    @participants = User.group(:id).includes({ avatar_attachment: :blob })
                        .joins(:comments).where("comments.commentable_id": @talk.id).order_as_specified(id: order_fields)

    render 'show', formats: :json
  end

  def create
    @talk = @current_user.talks.create!(talk_params)
    render 'create', formats: :json
  end

  def update
    @talk.update!(talk_params)
    head :no_content
  end

  def destroy
    @talk.destroy!
    head :no_content
  end

  PER_PAGE_TALKS_ARCHIVED = 50
  def archived
    @talks = @current_user.talks.where(archived: true).page(params[:page] || 1).per(params[:count] || PER_PAGE_TALKS_ARCHIVED)

    render 'index', formats: :json
  end

  private

  def set_talk
    @talk = @current_user.talks.find_by!(slug: params[:slug])
  end

  def talk_params
    params.permit(:title, :closed, :archived)
  end
end
