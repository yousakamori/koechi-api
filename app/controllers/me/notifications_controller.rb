class Me::NotificationsController < ApplicationController
  def index
    @notifications = @current_user.notifications.includes([:notifiable, {
                                                            sender: { avatar_attachment: :blob }
                                                          }]).recent.page(params[:page] || 1).per(40)

    ActiveRecord::Base.transaction do
      # reset
      @current_user.notifications.update_all(checked: true)
      @current_user.update(notifications_count: 0)
    end

    render 'index', formats: :json
  end
end
