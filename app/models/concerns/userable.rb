module Userable
  extend ActiveSupport::Concern

  def current_user_liked?(current_user)
    return false unless current_user

    likes.pluck(:user_id).include?(current_user.id)
  end

  def mine?(current_user)
    return false unless current_user

    user_id == current_user.id
  end
end
