Rails.application.routes.draw do
  # auth
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  # follow
  post '/follow', to: 'follow_relationships#create'
  delete '/unfollow', to: 'follow_relationships#destroy'

  # active storage direct upload
  resources :direct_uploads, only: [:create]

  # cnd
  direct :cdn_image do |model, _options|
    service = Rails.application.config.active_storage.service

    case service
    when :local
      rails_storage_proxy_url(model)
    when :amazon
      "#{Rails.configuration.x.app.cdn_url}/#{model.key}"
    else
      ''
    end
  end

  # validate
  namespace :validators do
    namespace :users do
      get :username_taken, :email_taken
    end
  end

  # space memberのautocomplete
  namespace :autocomplete do
    get 'users'
  end

  resources :users, only: %i[create show], param: :username do
    member do
      get :followers, :followings
      get :comments
    end
  end

  resource :search, only: [:show] do
    collection do
      get :count
    end
  end

  resource :reset_password, only: %i[create update], param: :username do
    get :check_token
  end

  resources :spaces, only: %i[show create update destroy], param: :slug do
    resources :notes, only: %i[index create], param: :slug, controller: 'spaces/notes'
    resource :members, only: %i[show create update destroy], param: :slug, controller: 'spaces/members'
  end

  resources :likes, only: [:create]
  resources :links, only: [:index]
  resources :notes, only: %i[edit show update destroy], param: :slug
  resources :comments, only: %i[create update destroy], param: :slug
  resource :me, only: %i[show update destroy]
  resources :talks, only: %i[index create update show destroy], param: :slug do
    collection do
      get :archived
    end
  end

  namespace :me do
    get '/library/likes', to: 'libraries#likes'

    resource :spaces, only: [:show] do
      collection do
        get :name
      end
    end

    resource :notes, only: [:show] do
      collection do
        get :term
      end
    end

    resources :notifications, only: [:index]
    resource :email, only: %i[show create update]
    resource :password, only: [:update]
  end
end
