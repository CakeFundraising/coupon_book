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

      get :start_discount
      get :start_pr_box
      get :categories, format: :json
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

  resources :pr_boxes, except: [:index, :show]

  scope :users, controller: :users do
    get :sign_in
    post :new_session
    delete :sign_out
  end

  resources :coupon_sponsors
  resources :subscriptors, only: :create
  resources :purchases, only: :create

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

end
