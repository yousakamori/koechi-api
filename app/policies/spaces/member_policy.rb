class Spaces::MemberPolicy < ApplicationPolicy
  def show?
    @record.pluck(:user_id).include?(@user.id)
  end

  def create?
    @record.find_by(user_id: @user).admin?
  end

  def update?
    @record.find_by(user_id: @user).admin?
  end

  def destroy?
    @record.find_by(user_id: @user).admin?
  end
end
