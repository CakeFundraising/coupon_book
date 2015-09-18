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
      
        panel 'Sales' do
          table do
            tr do
              td do
                strong Purchase.count
                span 'Total Sales'
              end
              td do
                strong link_to Purchase.last.email, admin_purchase_path(Purchase.last)
                span 'Last Sale'
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
      
        panel 'Merchants' do
          table do
            tr do
              td do
                strong Merchant.all.count
                span 'Total Merchants'
              end
            end
          end
        end
      end

    end
  end # content

end
