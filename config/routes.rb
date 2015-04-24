CakeCouponBook::Application.routes.draw do
  root to:'home#index'

  resources :coupon_books do
    member do
      patch :update_coupon_order
    end
  end

  resources :categories

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

  get :dashboard, controller: :dashboard

end
