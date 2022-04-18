require 'rails_helper'

RSpec.describe 'Sessions API', type: :request do
  include SessionHelper
  let(:user) { create(:user) }

  describe 'POST /login' do
    context '成功' do
      it '正しいEメールとパスワード' do
        log_in_as(user.email, 'passw0rd')
        expect(is_logged_in?).to be_truthy
        expect(response).to have_http_status :success
      end

      it 'タイムアウトセッションが更新されている' do
        log_in_as(user.email, 'passw0rd')
        expect(session[:user_last_access_time]).not_to be nil
      end
    end

    context '失敗' do
      it '間違ったEメール' do
        log_in_as('failure@example.com', 'passw0rd')
        get '/me/notes'
        expect(response).to have_http_status :bad_request
      end

      it '間違ったパスワード' do
        log_in_as(user.email, 'passwoooord')
        get '/me/notes'
        expect(response).to have_http_status :bad_request
      end

      it 'セッションタイムアウト' do
        log_in_as(user.email, 'passw0rd')
        travel_to ApplicationController::TIMEOUT.from_now.advance(seconds: 1)
        get '/me/notes'
        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe 'DELETE /logout' do
    it 'ログアウトできる' do
      log_in_as(user.email, 'passw0rd')
      delete '/logout'
      get '/me/notes'
      expect(response).to have_http_status :bad_request
    end
  end
end
