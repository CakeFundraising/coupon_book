require 'deep_cloneable'
require 'roo'

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

  desc "Update all books screenshots"
  task update_screenshots: :environment do
    include Rails.application.routes.url_helpers

    CouponBook.all.each do |cb|
      Resque.enqueue(ResqueSchedule::BookScreenshot, cb.id, coupon_book_url(cb, host: ENV['HOST']))
    end
  end


  # https://dl.dropboxusercontent.com/s/as25m053o66j1iy/Test%20Contacts.xlsx?dl=0
  desc "Create and send vouchers given remote contacts file"
  task :send_vouchers, [:book_id, :file_url] => [:environment] do |t, args|
    cb = CouponBook.find(args.book_id)
    file = Roo::Spreadsheet.open(args.file_url)
    EMAIL_REGEX = /\A([\w\.%\+\-]+)@([\w\-]+\.)+([a-z]{2,})\z/i

    file.each(first_name: 'First Name', email: 'Email') do |row|
      unless EMAIL_REGEX.match(row[:email]).nil?
        purchase = Purchase.create(
          first_name: row[:first_name] || 'First Name', 
          last_name: row[:last_name] || 'Last Name', 
          email: row[:email], 
          purchasable: cb,
          card_token: 'free',
          amount: '0',
          zip_code: '00000',
          should_notify: false,
          should_charge: false
        )
        Resque.enqueue(ResqueSchedule::SendFreeVoucher, purchase.id)
      end
    end
  end

end
