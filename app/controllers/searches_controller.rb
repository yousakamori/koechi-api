class SearchesController < ApplicationController
  skip_before_action :authenticate_user
  before_action :check_keywords
  before_action :check_source, only: [:show]
  before_action :split_keywords

  def show
    case params[:source]
    when 'users'
      q = User.ransack({ m: 'and', g: gouping_hash(@keywords, %w[name username]), s: 'follower_count desc' })
      @users = q.result.includes(avatar_attachment: :blob).page(params[:page]).per(params[:count] || Rails.configuration.x.app.per_page_search)

      render 'users', formats: :json
    when  'talks'
      q = Talk.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title]), s: ['liked_count desc', 'comments_count desc'] })
      @talks = q.result.includes([user: { avatar_attachment: :blob }]).active.page(params[:page]).per(params[:count] || Rails.configuration.x.app.per_page_search)

      render 'talks/index', formats: :json
    else
      # notes
      raise(Pundit::NotAuthorizedError) unless @current_user

      q = my_notes.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title body_text]), s: ['posted_at desc', 'liked_count desc'] })
      @notes = q.result.includes(:space, user: { avatar_attachment: :blob })
                .page(params[:page]).per(params[:count] || Rails.configuration.x.app.per_page_search)

      render 'notes/index', formats: :json
    end
  end

  def count
    counts = {}

    counts[:users_count] =
      User.ransack({ m: 'and', g: gouping_hash(@keywords, %w[name username]) }).result.count

    counts[:talks_count] =
      Talk.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title]) }).result.active.count

    if @current_user
      counts[:notes_count] =
        my_notes.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title body_text]) }).result.count
    end

    json_response(counts)
  end

  private

  def check_keywords
    json_response({ message: '検索ワードを入力してください。' }, :bad_request) unless params[:q]
  end

  def check_source
    return if %w[users notes talks].include?(params[:source])

    json_response({ message: '適切なsourceパラメーターを指定してください。' }, :bad_request)
  end

  def split_keywords
    decode_keywords = URI.decode_www_form_component(params[:q])
    @keywords = decode_keywords.split(/[[:blank:]]+/).select(&:present?)
  end

  def my_notes
    spaces = @current_user.spaces.active(@current_user)
    Note.active.where(space_id: spaces.ids)
  end

  def gouping_hash(keywords, cols)
    keywords.reduce({}) do |hk, k|
      hk.merge(k => {
                 g: cols.reduce({}) do |hc, c|
                   hc.merge({ c => { "#{c}_cont" => k } })
                 end, m: 'or'
               })
    end
  end
end
