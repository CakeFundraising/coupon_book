CakeCouponBook::Application.routes.draw do
  root to:'home#index'

  resources :coupon_books do
    member do
      patch :update_coupon_order
    end
  end

  resources :coupon_categories

  resources :coupons do
    member do
      scope :pictures, controller: :cropping do
        post :crop
      end
    end
  end

end
