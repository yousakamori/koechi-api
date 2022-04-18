class SpacePolicy < ApplicationPolicy
  attr_reader :user, :record

  def show?
    @record.archived? ? @record.owner == @user : @record.users.include?(@user)
  end

  def create?
    @record.owner == @user
  end

  def update?
    @record.owner == @user
  end

  def destroy?
    @record.owner == @user
  end
end
