module ExceptionHandler
  extend ActiveSupport::Concern

  class AuthenticationError < StandardError; end

  class ArchivedError < StandardError; end

  included do
    rescue_from ExceptionHandler::AuthenticationError, with: :forbidden
    rescue_from ExceptionHandler::ArchivedError, with: :archived
    rescue_from Pundit::NotAuthorizedError, with: :forbidden
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
  end

  private

  def forbidden
    # 403
    json_response({ message: 'この操作は許可されていません。' }, :forbidden)
  end

  def not_found
    # 404
    json_response({ message: 'このページはすでに削除されているか、URLが間違っている可能性があります。' }, :not_found)
  end

  def archived
    json_response({ message: 'アーカイブを解除して操作してください。' }, :forbidden)
  end

  def unprocessable_entity(error)
    # 422
    json_response(validate_error_reponse(error.record.errors), :unprocessable_entity)
  end

  def validate_error_reponse(errors)
    { code: "#{errors.first.attribute}-#{errors.first.type}", message: errors.full_messages.first }
  end
end