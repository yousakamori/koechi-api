class Me::SpacesController < ApplicationController
  def show
    @spaces = @current_user.spaces.includes(%i[memberships owner]).order(created_at: :desc)

    render 'show', formats: :json
  end

  def name
    @spaces = @current_user.spaces.where(archived: false).order(created_at: :desc)

    render 'name', formats: :json
  end
end
