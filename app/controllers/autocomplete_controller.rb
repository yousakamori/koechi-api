class AutocompleteController < ApplicationController
  def users
    @users = User.autocomplete(params[:username])
    render 'users', formats: :json, handlers: 'jbuilder'
  end
end
