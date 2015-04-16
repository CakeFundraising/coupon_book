CakeCouponBook::Application.routes.draw do
  root to:'home#index'

  resources :coupon_books do
    member do
      patch :update_coupon_order
    end
  end

  resources :coupon_categories

  resources :coupons

  scope :users, controller: :users do
    get :sign_in
    post :new_session
    delete :sign_out
  end

end
