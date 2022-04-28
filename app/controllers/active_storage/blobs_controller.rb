# TODO: 使ってない
class ActiveStorage::BlobsController < ActiveStorage::BaseController
  include ActiveStorage::SetBlob

  def show
    expires_in ActiveStorage.service_urls_expire_in
    if access_allowed?(@blob)
      redirect_to @blob.url(disposition: params[:disposition])
    else
      head :forbidden
    end
  end

  private

  def access_allowed?(_blob)
    # TODO: 未実装
    true
  end
end
