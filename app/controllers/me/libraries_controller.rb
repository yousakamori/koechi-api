class Me::LibrariesController < ApplicationController
  def likes
    @likes = @current_user.likes
                          .includes([:note, { note: :space, likable: [user: { avatar_attachment: :blob }] }])
                          .liked.order(created_at: :desc).page(params[:page]).per(Rails.configuration.x.app.per_page_like)
    render 'likes', formats: :json
  end
end
