module CommunitiesHelper
  def commission_percentage(percentage=0)
    percentage = 0 if percentage.nil?
    Community::COMMISSION.select{|v| v >= percentage }.map{|v| ["#{v}%", v]}
  end
end