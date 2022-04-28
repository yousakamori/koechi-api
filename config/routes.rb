Rails.application.routes.draw do
  # TODO: 使ってない
  get '/blobs/redirect/:signed_id/*filename' => 'active_storage/blobs#show'

  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  post '/follow', to: 'follow_relationships#create'
  delete '/unfollow', to: 'follow_relationships#destroy'

  resources :direct_uploads, only: [:create]

  # for delivering uploaded files from CDN
  # See: https://guides.rubyonrails.org/v7.0/active_storage_overview.html#putting-a-cdn-in-front-of-active-storage
  # direct :cdn do |model, options|

  #   obj = model.respond_to?(:blob) ? model.blob : model # Variantファイルよりもオリジナルファイルを優先
  #   uri = URI.parse(root_url)
  #   uri.host = 'cdn.koechi.com'
  #   uri.path = File.join("/", obj.key)
  #   uri.port = nil

  #   uri.to_s # e.g. "https://#{CDN_HOST}/#{obj.key}"
  # end

  # direct :cdn_image do |model, options|
  #   if model.respond_to?(:signed_id)
  #     route_for(
  #       :rails_service_blob_proxy,
  #       model.signed_id,
  #       model.filename,
  #       options.merge(host: 'https://cdn.koechi.com')
  #     )
  #   else
  #     signed_blob_id = model.blob.signed_id
  #     variation_key  = model.variation.key
  #     filename       = model.blob.filename

  #     route_for(
  #       :rails_blob_representation_proxy,
  #       signed_blob_id,
  #       variation_key,
  #       filename,
  #       options.merge(host: 'https://cdn.koechi.com')
  #     )
  #   end
  # end

  namespace :validators do
    namespace :users do
      get :username_taken, :email_taken
    end
  end

  namespace :autocomplete do
    get 'users'
  end

  resources :users, only: [:create, :show], param: :username do
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

  resource :reset_password, only: [:create, :update], param: :username do
    get :check_token
  end

  resources :spaces, only: [:show, :create, :update, :destroy], param: :slug do
    resources :notes, only: [:index, :create], param: :slug, controller: 'spaces/notes'
    resource :members, only: [:show, :create, :update, :destroy], param: :slug, controller: 'spaces/members'
  end

  resources :likes, only: [:create]
  resources :links, only: [:index]
  resources :notes, only: [:edit, :show, :update, :destroy], param: :slug
  resources :comments, only: [:create, :update, :destroy], param: :slug
  resources :talks, only: [:index, :create, :update, :show, :destroy], param: :slug do
    collection do
      get :archived
    end
  end

  resource :me, only: [:show, :update, :destroy]

  namespace :me do
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
    resource :likes, only: [:show]
    resource :email, only: [:show, :create, :update]
    resource :password, only: [:update]
  end
end
