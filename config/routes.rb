CakeCouponBook::Application.routes.draw do
  root to:'home#index'

  resources :coupon_books do
    member do
      patch :update_coupon_book_order
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

end
