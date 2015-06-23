module ExtraClickController
  extend ActiveSupport::Concern

  def extra_click(success_url, failure_url, redirect=true)
    if current_browser.present?
      if resource.active?
        resource.extra_clicks.create(url: success_url, browser: current_browser, bonus: resource.unique_extra_click_browsers.include?(current_browser))
      end
      redirect_to success_url if redirect
    else
      redirect_to failure_url, alert: 'There was an error when trying to count your click. Please try again.' if redirect
    end
  end
end