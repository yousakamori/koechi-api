class SearchesController < ApplicationController
  skip_before_action :authenticate_user
  before_action :check_keywords
  before_action :check_source, only: [:show]
  before_action :split_keywords

  PER_PAGE_SEARCHES = 48
  def show
    if params[:source] == 'users'
      q = User.ransack({ m: 'and', g: gouping_hash(@keywords, %w[name username]), s: 'follower_count desc' })
      @users = q.result.includes(avatar_attachment: :blob).page(params[:page]).per(params[:count] || PER_PAGE_SEARCHES)

      render 'users', formats: :json, handlers: 'jbuilder'
    end

    if params[:source] == 'talks'
      # TODO: sort順を考える
      q = Talk.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title]), s: 'created_at desc' })
      @talks = q.result.includes([user: { avatar_attachment: :blob }]).active.page(params[:page]).per(params[:count] || PER_PAGE_SEARCHES)

      render 'talks', formats: :json, handlers: 'jbuilder'
    end

    if params[:source] == 'notes'
      raise(ExceptionHandler::AuthenticationError) unless @current_user

      # TODO: sort順を考える
      q = my_notes.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title body_text]), s: 'created_at desc' })
      @notes = q.result.includes(:space, user: { avatar_attachment: :blob })
                .page(params[:page]).per(params[:count] || PER_PAGE_SEARCHES)

      render 'notes', formats: :json, handlers: 'jbuilder'
    end
  end

  def count
    counts = {}

    counts[:users_count] =
      User.ransack({ m: 'and', g: gouping_hash(@keywords, %w[name username]) }).result.count

    counts[:talks_count] =
      Talk.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title]) }).result.active.count

    if @current_user
      counts[:notes_count] = my_notes.ransack({ m: 'and', g: gouping_hash(@keywords, %w[title body_text]) }).result.count
    end

    json_response(counts)
  end

  private

  def check_keywords
    json_response({ message: '検索ワードを入力してください。' }, :bad_request) unless params[:q]
  end

  def check_source
    unless %w[users notes talks].include?(params[:source])
      json_response({ message: '適切なsourceパラメーターを指定してください。' }, :bad_request)
    end
  end

  def split_keywords
    decode_keywords = URI.decode_www_form_component(params[:q])
    @keywords = decode_keywords.split(/[[:blank:]]+/).select(&:present?)
  end

  def my_notes
    # TODO: archiveは表示したくない => めんどくさそう?
    spaces = @current_user.spaces
    Note.active.where(space_id: spaces.ids)
  end

  def gouping_hash(keywords, cols)
    keywords.reduce({}) do |h, k|
      h.merge(k => {
                g: cols.reduce({}) do |h, c|
                  h.merge({ c => { "#{c}_cont" => k } })
                end, m: 'or'
              })
    end
  end
end
