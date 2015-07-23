require 'deep_cloneable'

namespace :cake do
  desc "Clone Coupon Book categories hierarchy"
  task :clone_discounts, [:book_id, :clone_target_ids] => [:environment] do |t, args|
    cb = CouponBook.find(args.book_id)
    clone_targets = CouponBook.find(args.clone_target_ids.split(' ').map(&:to_i))

    clone = cb.deep_clone(only: true, include:{categories: :categories_coupons})

    clone_targets.each do |target|
      target.categories << clone.categories unless target.categories.any?
    end
  end
end
