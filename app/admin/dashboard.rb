ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel 'Coupon Books' do
          table do
            tr do
              td do
                strong CouponBook.count
                span 'Total Coupon Books'
              end
              td do
                strong CouponBook.active.count
                span 'Active Coupon Books'
              end
              td do
                strong CouponBook.past.count
                span 'Past Coupon Books'
              end
            end
            tr do
              td do
                strong CouponBook.to_end.count
                span 'Coupon Books about to end'
              end
            end
          end
        end
      
        panel 'Coupons' do
          table do
            tr do
              td do
                strong Coupon.count
                span 'Total Coupons'
              end
              td do
                strong Coupon.active.count
                span 'Active Coupons'
              end
              td do
                strong Coupon.past.count
                span 'Expired Coupons'
              end
            end
            tr do
              td do
                strong Coupon.to_end.count
                span 'Coupons about to expire'
              end
            end
          end
        end
      
        panel 'Collections' do
          table do
            tr do
              td do
                strong Collection.count
                span 'Total Collections'
              end
              td do
                strong Collection.has_coupons.count
                span 'Collections with coupons'
              end
              td do
                strong Collection.empty.count
                span 'Empty Collections'
              end
            end
          end
        end
      
      end
      # 
      column do
        panel 'Fundraisers' do
          table do
            tr do
              td do
                strong Fundraiser.all.count
                span 'Total Fundraisers'
              end
            end
          end
        end
      
        panel 'Sponsors' do
          table do
            tr do
              td do
                strong Sponsor.all.count
                span 'Total Sponsors'
              end
            end
          end
        end
      end

    end
  end # content

end
