module CommunitiesHelper
  def commission_rate_options(percentage=0)
    Community::COMMISSION.select{|v| v >= percentage }.map{|v| ["#{v}%", v]}
  end

  def media_commission_rate(affiliate_rate)
    up_to = 100 - affiliate_rate
    (0..up_to).step(5).to_a.map{|v| ["#{v}%", v]}
  end
end