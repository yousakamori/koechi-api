require 'rails_helper'

RSpec.describe 'Me::Notifications API', type: :request do
  include SessionHelper
  let(:user) { create(:user, notifications_count: 2) }

  describe 'GET /me/notifications' do
    it 'notificationの一覧' do
      log_in_as(user.email, 'passw0rd')

      notifications = create_list(:notification, 2, checked: false, recipient: user)

      get '/me/notifications'

      expect(response).to have_http_status :ok
      expect(user.reload.notifications_count).to eq 0
      expect(notifications.first.reload.checked).to be_truthy
      expect(notifications.last.reload.checked).to be_truthy
    end
  end
end
