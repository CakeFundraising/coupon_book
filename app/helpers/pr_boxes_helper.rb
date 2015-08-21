module PrBoxesHelper
  def pr_box_pic(pr_box)
    if pr_box.url.nil?
      pr_box.picture.avatar
    else
      picture_rollover(pr_box.picture.avatar, pr_box.url) do
        content_tag(:div, 'Click to') + content_tag(:div, 'learn more')
      end
    end
  end

  def pr_box_see_all_pic(pr_box)
    picture_ajax_rollover(pr_box.picture.avatar) do
      link_to('#!', class:'expand see-more-box') do
        content_tag(:div, 'See all') + content_tag(:div, 'Deals')
      end
    end
  end
end