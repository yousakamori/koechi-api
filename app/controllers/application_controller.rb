class ApplicationController < ActionController::API
  include Pundit
  include ActionController::Cookies
  include Response
  include ExceptionHandler
  include UserSession

  before_action :authenticate_user
  before_action :authenticate_timeout
end
