class CommentPolicy < ApplicationPolicy
  def create?
    return true unless @record.commentable_type == 'Note'

    @record.commentable.space.member?(@user)
  end

  def update?
    return true unless @record.commentable_type == 'Note'

    @record.commentable.space.member?(@user)
  end

  def destroy?
    return true unless @record.commentable_type == 'Note'

    @record.commentable.space.member?(@user)
  end
end
