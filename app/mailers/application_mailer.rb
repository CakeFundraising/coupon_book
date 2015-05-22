class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@cakecausemarketing.com'
  layout 'mailer'

  def find_coupon_book(id)
    CouponBook.find(id).decorate
  end
end
