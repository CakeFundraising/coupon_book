CakeCouponBook::Application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to:'home#index'

  scope :search, controller: :searches do
    get :search_coupons, path:'coupons'
  end

  mount Resque::Server, at: "/resque"

  resources :coupon_books do
    member do
      scope :edit do
        get :tell_your_story
        get :coupons
        get :request_coupons
        get :launch_and_share
      end
      patch :launch
      patch :save_for_launch
      patch :toggle_visibility
      patch :update_order

      post :tree
      get :sponsor_landing, path: :start_discount
      get :download
    end
  end

  resources :categories

  resources :collections do
    member do
      scope :edit do
        get :add_coupons
      end
    end
  end

  delete 'collections_coupons' => 'collections_coupons#destroy'
  resources :collections_coupons

  resources :coupons do
    member do
      get :download

      scope :pictures, controller: :cropping do
        post :crop
      end
      scope :edit do
        get :sponsor
        get :discount
        get :news
        get :launching
      end
      patch :launch
      patch :universal_toggle
    end
  end

  scope :users, controller: :users do
    get :sign_in
    post :new_session
    delete :sign_out
  end

  resources :coupon_sponsors
  resources :subscriptors, only: :create
  resources :purchases, only: :create

  namespace :dashboard do
    scope :fundraiser, controller: :fundraiser do
      get :home, as: :fundraiser_home
      get :history, as: :fundraiser_history
    end
    scope :sponsor, controller: :sponsor do
      get :home, as: :sponsor_home
      get :history, as: :sponsor_history
      get :coupons, as: :sponsor_coupons
    end
  end

  mount API::Base => '/api'

  scope :browser, controller: :browsers do
    patch :fingerprint
  end

  # Adds routes for evercookie under namespace (path)
  scope "#{Evercookie.get_namespace}" do
    # route for js file to set cookie
    get 'set' => "evercookie/evercookie#set", as: :evercookie_set
    # route for js file to get cookie
    get 'get' => "evercookie/evercookie#get", as: :evercookie_get
    # route for save action to save cookie value to session
    get 'save' => "evercookie/evercookie#save", as: :evercookie_save

    # route to png image to be tracked by js script
    get 'ec_png' => "evercookie/evercookie#ec_png", as: :evercookie_png
    # route to etag action to be tracked by js script
    get 'ec_etag' => "evercookie/evercookie#ec_etag", as: :evercookie_etag
    # route to cache action to be tracked by js script
    get 'ec_cache' => "evercookie/evercookie#ec_cache", as: :evercookie_cache
    # route to basic auth to be tracked by js script
    get 'ec_auth' => "evercookie/evercookie#ec_auth", as: :evercookie_auth
  end

end
