module API
  module V1
    class Vouchers < API::V1::Root

      resource :vouchers do

        desc "Return voucher's status given a Voucher Number and SP id"
        params do
          requires :number, type: Integer, desc: "Voucher Number", allow_blank: false
          requires :sp, type: Integer, desc: "SP's ID", allow_blank: false
        end
        route_param :number do
          get :status do
            voucher = Voucher.find_by_number(params[:number])
            if voucher.nil?
              present :allowed, false
              present :message, 'Voucher number is not recognized.'              
            else
              status = voucher.validate_status(params[:sp])
              present :allowed, status[:allowed]
              present :message, status[:message]
            end
          end

          patch :redeem do
            voucher = Voucher.find_by_number(params[:number])
            if voucher.nil?
              present :allowed, false
              present :message, 'Voucher number is not recognized.'              
            else
              redeemed = voucher.redeem!(params[:sp])
              present :redeemed, redeemed
            end
          end
        end

      end

    end
  end
end