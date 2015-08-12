CakeCouponBook::Application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {omniauth_callbacks: :omniauth_callbacks, registrations: :registrations, confirmations: :confirmations}
  
  root to:'home#index'

  scope :search, controller: :searches do
    get :search_coupons, path:'coupons'
    get :search_pr_boxes, path:'pr_boxes'
  end

  mount Resque::Server, at: "/resque"

  resources :direct_donations, only: :create

  resources :coupon_books, path: :campaigns do
    member do
      scope :edit do
        get :story
        get :organize
        get :share
        get :customize
        post :save_organize
      end
      patch :launch
      patch :save_for_launch
      patch :toggle_visibility
      patch :update_order

      get :start_discount
      get :start_pr_box
      get :categories, format: :json
      
      get :download
      get :badge

      get :donate
    end
  end

  resources :categories do
    collection do
      get :load_all_discounts
    end
    member do
      get :discounts
    end
  end

  resources :collections do
    member do
      scope :edit do
        get :add_coupons
      end
    end
  end

  resources :collections_coupons, only: [:create, :destroy]

  resources :coupons do
    member do
      get :download
      get :click

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

  resources :pr_boxes, except: [:index, :show]

  resources :coupon_sponsors

  resources :subscriptors, only: :create

  resources :purchases, only: :create do
    member do
      get :vouchers
      get :succeeded
    end
  end

  scope :fundraisers, controller: :fundraisers, defaults: {format: :json} do
    get :collection_coupons
    get :collection_pr_boxes
  end

  namespace :dashboard do
    scope :fundraiser, controller: :fundraiser do
      get :home, as: :fundraiser_home
      get :history, as: :fundraiser_history
    end
    scope :sponsor, controller: :sponsor do
      get :home, as: :sponsor_home
      get :history, as: :sponsor_history
      get :coupons, as: :sponsor_coupons
      get :pr_boxes, as: :sponsor_pr_boxes
    end
  end

  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

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
