module AppUrlHelper
  def campaign_root_url
    "#{coupon_books_url(protocol: 'https')}/"
  end

  def community_page_root_url
    "#{communities_url(protocol: 'https')}/"
  end
end