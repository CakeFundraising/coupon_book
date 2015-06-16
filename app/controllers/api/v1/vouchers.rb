module API
  module V1
    class Vouchers < API::V1::Root

      resource :vouchers do

        desc "Return voucher's status given a Voucher Number and SP id"
        params do
          requires :number, type: Integer, desc: "Voucher Number"
          requires :sp, type: Integer, desc: "SP's ID"
        end
        route_param :number do
          get jbuilder: 'vouchers/status' do
            @voucher = Voucher.find_by_number(params[:number])
            @sp = Sponsor.fetch(params[:sp])
          end
        end

      end

    end
  end
end