module API
  module V1
    class Sponsors < API::V1::Root

      resource :sponsors do

        desc "Return sponsor's data given an UID"
        params do
          requires :id, type: Integer, desc: "Sponsor ID", allow_blank: false
        end

        route_param :id do
          
          get :redeemed_vouchers do
            sponsor = Sponsor.fetch(params[:id])
            present :count, sponsor.vouchers.redeemed.count
          end

          get :pending_vouchers do
            sponsor = Sponsor.fetch(params[:id])
            present :count, sponsor.vouchers.pending.count
          end

          get :expired_vouchers do
            sponsor = Sponsor.fetch(params[:id])
            present :count, sponsor.vouchers.expired.count
          end
        end

      end

    end
  end
end