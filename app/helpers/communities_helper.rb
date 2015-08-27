module CommunitiesHelper
  def commission_percentage
    Community::COMMISSION.map{|v| ["#{v}%", v]}
  end
end