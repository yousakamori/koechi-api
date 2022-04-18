class Me::SpacesController < ApplicationController
  def show
    @spaces = @current_user.spaces.includes([:memberships, :owner]).order(created_at: :desc)

    render 'show', formats: :json, handlers: 'jbuilder'
  end

  def name
    @spaces = @current_user.spaces.where(archived: false).order(created_at: :desc)

    render 'name', formats: :json, handlers: 'jbuilder'
  end
end
