CakeCouponBook::Application.routes.draw do
  resources :coupon_books do
    member do
      patch :update_coupon_order
    end
  end

  resources :coupon_categories

  resources :coupons

end
