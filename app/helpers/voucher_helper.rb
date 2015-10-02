module VoucherHelper
  def redeem_button(voucher)
    if voucher.redeemed?
      link_to 'Deal Already Used', nil, disabled: true, class:'btn btn-info btn-xl'
    elsif voucher.expired?
      link_to 'Deal Has Expired', nil, disabled: true, class:'btn btn-danger btn-xl'
    else
      link_to 'REDEEM', redeem_voucher_path(voucher), method: :patch, data: {confirm: 'Are you sure?'}, class:'btn btn-success btn-xl'
    end
  end 
end