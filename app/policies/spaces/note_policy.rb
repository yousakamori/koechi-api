class Spaces::NotePolicy < ApplicationPolicy
  def index?
    @record.member?(@user)
  end

  def create?
    @record.member?(@user)
  end
end
