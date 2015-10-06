class MediaAffiliateCampaignDecorator < ApplicationDecorator
  delegate_all

  decorates_association :coupon_book
  #decorates_association :media_affiliate

  def to_s
    object.name
  end

  def affiliate_name
    object.media_affiliate.full_name
  end

  def phone
    object.media_affiliate.phone
  end

  def launch_date
    object.launch_date.strftime("%m/%d/%Y") if object.launch_date.present?
  end

  def end_date
    object.end_date.strftime("%m/%d/%Y") if object.end_date.present?
  end

  def price
    h.humanized_money_with_symbol object.price
  end

  def goal
    h.humanized_money_with_symbol object.goal
  end

  def status
    object.status.titleize
  end

  def current_sales
    h.humanized_money_with_symbol (object.current_sales_cents/100.0)
  end

  def current_commission_amount
    h.humanized_money_with_symbol (object.current_commission_cents/100.0)
  end

  def commission_percentage
    "#{object.commission_percentage}%"
  end

  def community_page_url
    h.community_url(object.community, macid: object, token: object.token)   
  end 
end