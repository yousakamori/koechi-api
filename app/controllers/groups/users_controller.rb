class Groups::UsersController < ApplicationController
  def destroy
    space = Space.find_by!(params[:slug])
    space.destroy(@current_user)
  end
end
