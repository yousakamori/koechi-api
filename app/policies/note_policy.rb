class NotePolicy < ApplicationPolicy
  def show?
    space = @record.space
    space.member?(@user) && (!space.archived || (space.archived && space.owner == @user))
  end

  def update?
    space = @record.space
    (@record.user == @user || space.memberships.find_by(user_id: @user).admin?) && (!space.archived || (space.archived && space.owner == @user))
  end

  def destroy?
    space = @record.space
    (@record.user == @user || space.memberships.find_by(user_id: @user).admin?) && (!space.archived || (space.archived && space.owner == @user))
  end

  def edit?
    space = @record.space
    (@record.user == @user || space.memberships.find_by(user_id: @user).admin?) && (!space.archived || (space.archived && space.owner == @user))
  end
end
