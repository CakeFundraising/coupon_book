module CommunitiesHelper
  def commission_rate_options(percentage=0)
    Community::COMMISSION.map{|v| ["#{v}%", v]}
  end

  def media_commission_rate(affiliate_rate)
    up_to = 100 - affiliate_rate
    (0..up_to).to_a.map{|v| ["#{v}%", v]}
  end
end