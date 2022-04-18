class NotePolicy < ApplicationPolicy
  def show?
    @record.space.member?(@user)
  end

  def update?
    @record.user == @user || @record.space.memberships.find_by(user_id: @user).admin?
  end

  def destroy?
    @record.user == @user || @record.space.memberships.find_by(user_id: @user).admin?
  end

  def edit?
    @record.user == @user || @record.space.memberships.find_by(user_id: @user).admin?
  end
end
