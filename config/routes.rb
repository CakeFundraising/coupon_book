CakeCouponBook::Application.routes.draw do
  root to:'home#index'

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
    end
  end

  resources :categories

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
        get :launch
      end
    end
  end

  scope :users, controller: :users do
    get :sign_in
    post :new_session
    delete :sign_out
  end

  resources :coupon_sponsors
  resources :subscriptors, only: :create

  scope :dashboard, controller: :dashboard do
    get :home
    get :history
  end

end
