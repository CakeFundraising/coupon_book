class VouchersController < InheritedResources::Base
  def redeem
    @voucher = resource
    response = @voucher.redeem!(nil)
    
    if response[:allowed]
      redirect_to vouchers_purchase_path(@voucher.purchase, token: @voucher.purchase.token), notice: response[:message]
    else
      redirect_to vouchers_purchase_path(@voucher.purchase, token: @voucher.purchase.token), alert: response[:message]
    end
  end
end