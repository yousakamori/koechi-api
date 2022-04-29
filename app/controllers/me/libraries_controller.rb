class Me::LibrariesController < ApplicationController
  PER_PAGE_LIKES = 10
  def likes
    # TODO: archiveは表示したくない => めんどくさそう
    @likes = @current_user.likes
                          .includes([:note, { note: :space, likable: [user: { avatar_attachment: :blob }] }])
                          .liked.order(created_at: :desc).page(params[:page]).per(PER_PAGE_LIKES)

    render 'likes', formats: :json
  end
end
