class Me::LikesController < ApplicationController
  def show
    # TODO: archiveは表示したくない => めんどくさそう
    @likes = @current_user.likes
                          .includes([:note, { note: :space, likable: [user: { avatar_attachment: :blob }] }])
                          .liked.order(created_at: :desc).page(params[:page]).per(10)

    render 'show', formats: :json
  end
end
