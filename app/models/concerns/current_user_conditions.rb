module CurrentUserConditions
  extend ActiveSupport::Concern

  def current_user_liked?(current_user)
    return false unless current_user

    likes.pluck(:user_id).include?(current_user.id)
  end
end
