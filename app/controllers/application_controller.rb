class ApplicationController < ActionController::API
  include Pundit::Authorization
  include ActionController::Cookies
  include Response
  include ExceptionHandler
  include UserSession

  before_action :authenticate_user
  before_action :authenticate_timeout
  before_action :authorize_guest, only: %i[update destroy]

  def update; end
  def destroy; end

  private

  def authorize_guest
    return unless @current_user
    raise ExceptionHandler::GuestError if @current_user.guest?
  end
end
