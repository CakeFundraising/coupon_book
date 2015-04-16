module CakeHelper
  CAKE_ROOT_URL = 'https://www.cakecausemarketing.com'

  def cake_about_page_path(page)
    "#{CAKE_ROOT_URL}/about/#{page}"
  end

  def cake_help_page_path(page)
    "#{CAKE_ROOT_URL}/help/#{page}"
  end

  def cake_new_user_session_path
    "#{CAKE_ROOT_URL}/users/sign_in"
  end

  def cake_new_user_registration_path
    "#{CAKE_ROOT_URL}/users/sign_up"
  end
end