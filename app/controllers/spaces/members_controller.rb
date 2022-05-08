class Spaces::MembersController < ApplicationController
  before_action :set_space
  before_action :authorize_user
  before_action :set_user, only: %i[create update destroy]
  before_action :authorize_owner, only: %i[update destroy]

  def show
    @members = Membership.includes([user: { avatar_attachment: :blob }]).where(space_id: @space.id)
                         .order_as_specified(user_id: [@space.owner.id, @current_user.id]).order(role: :desc)

    render 'show', formats: :json
  end

  def create
    ActiveRecord::Base.transaction do
      @member = Membership.create!(user_id: @user.id, space_id: @space.id)

      Notification.to_recipient!(action: :invite, recipient: @user, sender: @current_user, notifiable: @member)
    end

    render 'create', formats: :json
  end

  def update
    member = Membership.find_by(space_id: @space.id, user_id: @user.id)
    member.admin! if params[:role] == 'admin' && !member.admin?
    member.member! if params[:role] == 'member' && !member.member?

    head :no_content
  end

  def destroy
    ActiveRecord::Base.transaction do
      Membership.find_by(space_id: @space.id, user_id: @user.id).destroy!

      # ノートをownerに紐付ける
      @space.notes.where(user_id: @user.id).update(user_id: @space.owner.id)
    end

    head :no_content
  end

  private

  def set_space
    @space = Space.find_by(slug: params[:space_slug])
  end

  def authorize_user
    authorize @space.memberships, policy_class: Spaces::MemberPolicy
  end

  def set_user
    @user = User.activated.find_by(username: params[:username])
  end

  def authorize_owner
    json_response({ message: 'その操作をオーナーはできません' }, :forbidden) if @space.owner == @user
  end
end
