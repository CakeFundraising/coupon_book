CakeCouponBook::Application.routes.draw do
  root to:'home#index'


  scope :search, controller: :searches do
    get :search_coupons, path:'coupons'
  end

  resources :coupon_books do
    member do
      scope :edit do
        get :tell_your_story
        get :coupons
        get :launch_coupon_book, path: :launch
        get :share
      end
      patch :launch
      patch :save_for_launch
      patch :toggle_visibility
      patch :update_order
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
    end
  end

  scope :users, controller: :users do
    get :sign_in
    post :new_session
    delete :sign_out
  end

  resources :coupon_sponsors

  scope :dashboard, controller: :dashboard do
    get :home
    get :history
  end

end
