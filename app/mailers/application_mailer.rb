class ApplicationMailer < ActionMailer::Base
  include ::Roadie::Rails::Automatic
  
  default from: 'EatsForGood.com <no-reply@eatsforgood.com>'
  layout 'mailer'

  def find_coupon_book(id)
    CouponBook.find(id).decorate
  end
end
