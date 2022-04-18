class TalkPolicy < ApplicationPolicy
  def show?
    !@record.archived || @record.user_id == @user&.id
  end
end
