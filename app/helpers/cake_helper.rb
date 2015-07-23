module CakeHelper
  CAKE_ROOT_URL = ENV['CAKE_HOST']
  EFG_ROOT_URL = ENV['EFG_HOST']

  def cake_about_page_path(page)
    "#{CAKE_ROOT_URL}/about/#{page}"
  end

  def cake_help_page_path(page)
    "#{CAKE_ROOT_URL}/help/#{page}"
  end

  def cake_new_user_session_path
    "#{CAKE_ROOT_URL}/users/sign_in"
  end

  def cake_new_user_registration_path(params=nil)
    if params.present?
      "#{CAKE_ROOT_URL}/users/sign_up?#{params.to_query}"
    else
      "#{CAKE_ROOT_URL}/users/sign_up"
    end
  end

  def cake_fundraiser_path(page)
    "#{CAKE_ROOT_URL}/fundraiser/#{page}"
  end

  def cake_sponsor_path(page)
    "#{CAKE_ROOT_URL}/sponsor/#{page}"
  end

  def cake_settings_path(page)
    "#{CAKE_ROOT_URL}/settings/#{page}"
  end

  def cake_profile_path(role)
    "#{CAKE_ROOT_URL}/#{role.class.name.downcase.pluralize}/#{role.id}"
  end

  #EFG pages
  def efg_contact_path
    "#{EFG_ROOT_URL}/#!contact/cbys"
  end

  def efg_about_path
    "#{EFG_ROOT_URL}/#!about1/csyv"
  end

  def efg_blog_path
    "#{EFG_ROOT_URL}/#!blog/cz4z"
  end
end