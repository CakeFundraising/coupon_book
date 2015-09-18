module AppUrlHelper
  def campaign_root_url
    "#{coupon_books_url(protocol: 'https')}/"
  end
end