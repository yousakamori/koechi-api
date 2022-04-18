class LinksController < ApplicationController
  skip_before_action :authenticate_user, only: [:index]
  before_action :valid_type

  def index
    klass = Module.const_get(params[:type].classify)
    resource = klass.find_by!(slug: params[:slug])

    case klass.name
    when 'Talk'
      username = resource.user.username
      slug = resource.slug
      json_response({ path: "#{Rails.configuration.x.app.client_url}/#{username}/#{params[:type]}/#{slug}" })
    when 'Note'
      slug = resource.slug
      json_response({ path: "#{Rails.configuration.x.app.client_url}/#{params[:type]}/#{slug}" })
    when 'Comment'
      username = resource.commentable.user.username
      type = resource.commentable_type.pluralize.downcase
      slug = resource.commentable.slug
      hash = "#comment-#{resource.slug}"

      path = if type == 'notes'
               "#{Rails.configuration.x.app.client_url}/#{type}/#{slug}/#{hash}"
             elsif type == 'talks'
               "#{Rails.configuration.x.app.client_url}/#{username}/#{type}/#{slug}/#{hash}"
             else
               "#{Rails.configuration.x.app.client_url}/"
             end

      json_response({ path: path })
    else
      json_response({ path: "#{Rails.configuration.x.app.client_url}/" })
    end
  end

  private

  def valid_type
    json_response({ message: 'error' }, :not_found) unless %w[comments notes talks].include?(params[:type])
  end
end
