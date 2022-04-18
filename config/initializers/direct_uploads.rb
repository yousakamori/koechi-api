require 'active_storage/direct_uploads_controller'

class ActiveStorage::DirectUploadsController
  skip_before_action :verify_authenticity_token
end
