class SpacesController < ApplicationController
  before_action :set_space, only: %i[show update destroy]
  before_action :not_archived, only: [:destroy]
  before_action :authorize_user, only: %i[show update destroy]

  def show
    render 'show', formats: :json
  end

  def create
    ActiveRecord::Base.transaction do
      @space = @current_user.spaces.create!(space_create_params)
      @space.memberships.find_by(user_id: @current_user).admin!
    end

    render 'create', formats: :json
  end

  def update
    @space.update!(space_update_params)
    head :no_content
  end

  def destroy
    @space.destroy!
    head :no_content
  end

  private

  def set_space
    @space = Space.find_by!(slug: params[:slug])
  end

  def not_archived
    json_response({ message: 'アーカイブ済みのスペースのみ削除できます' }, :forbidden) unless @space.archived?
  end

  def authorize_user
    authorize @space
  end

  def space_create_params
    params.permit(:name, :emoji).merge(owner_id: @current_user.id)
  end

  def space_update_params
    params.permit(:name, :emoji, :archived)
  end
end
