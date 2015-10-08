CakeCouponBook::Application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, controllers: {omniauth_callbacks: :omniauth_callbacks, registrations: :registrations, sessions: :sessions, confirmations: :confirmations}
  
  root to:'home#index'

  scope :search, controller: :searches do
    get :search_campaigns, path:'campaigns'
    get :search_merchants, path:'merchants'
    get :search_communities, path:'communities'
    get :search_coupons, path:'deals'
    get :search_universal_coupons, path:'universal_deals'
    get :search_pr_boxes, path:'pr_boxes'
  end

  namespace :home, path:'/' do
    get :get_started
    get :load_tab
  end

  mount Resque::Server, at: "/resque"

  resources :direct_donations, only: :create

  resources :coupon_books, path: :campaigns do
    member do
      scope :edit do
        get :story
        get :merchants
        get :organize
        post :save_organize
        get :affiliates
        get :launching
        get :share
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
      get :checkout
    end
  end

  resources :communities, except: [:index, :destroy]

  resources :affiliate_campaigns, path: :group_campaigns do
    member do
      scope :edit do
        get :join
        get :get_paid
        get :share
      end

      patch :update_commission

      get :donate
      get :checkout
    end
    collection do
      get :book_preview
    end
  end

  resources :media_affiliate_campaigns, path: :media_campaigns do
    member do
      scope :edit do
        get :get_paid
        get :share
      end

      patch :update_commission

      get :donate
      get :checkout
    end
    collection do
      get :book_preview
    end
  end

  resources :categories do
    collection do
      get :load_all_discounts
      get :load_remaining_discounts
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

  resources :coupons, path: :deals do
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

  resources :pr_boxes, except: :show

  resources :coupon_sponsors

  resources :subscriptors, only: :create

  resources :purchases, only: :create do
    member do
      get :vouchers
      get :succeeded
    end
  end

  resources :vouchers, only: :index do
    member do
      patch :redeem
    end
  end

  resources :users, only: :index do
    collection do
      patch :roles
    end
  end

  resources :fundraisers do
    member do
      patch :registration_update
    end
    collection do
      get :collection_coupons, defaults: {format: :json}
      get :collection_pr_boxes, defaults: {format: :json}
    end
  end
  resources :merchants do
    member do
      patch :registration_update
    end
  end
  resources :affiliates do
    member do
      patch :registration_update
    end
  end
  resources :media_affiliates do
    member do
      patch :registration_update
    end
  end

  namespace :dashboard, path:'' do
    get :dashboard
    get :account
    get :history
    scope :get_paid do
      get :transfers
      get :stripe
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
