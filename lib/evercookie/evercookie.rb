# main module for evercookie gem
module Evercookie
  # path for controller
  mattr_accessor :namespace
  @@namespace = :evercookie

  # name for main js class
  mattr_accessor :js_class
  @@js_class = :evercookie

  # name for cookie for cache
  mattr_accessor :cookie_cache
  @@cookie_cache = :evercookie_cache

  # name for cookie for etag
  mattr_accessor :cookie_etag
  @@cookie_etag = :evercookie_etag

  # name for cookie for png
  mattr_accessor :cookie_png
  @@cookie_png = :evercookie_png

  # session hash name prefix
  mattr_accessor :hash_name
  @@hash_name = :evercookie

  # default method for setup evercookie
  def self.setup
    yield self
  end

  # getter for namespace
  def self.get_namespace
    @@namespace.to_sym
  end

  # getter for cookie path in javascript because rails controller actions
  # get cookies only from it's controller path
  def self.get_cookie_path
    "/#{get_namespace}/"
  end

  # getter for path of save action
  def self.get_save_path
    "/#{get_namespace}/save"
  end

  # getter for path of cache action
  def self.get_cache_path
    "/#{get_namespace}/ec_cache"
  end

  # getter for path of etag action
  def self.get_etag_path
    "/#{get_namespace}/ec_etag"
  end

  # getter for path of png action
  def self.get_png_path
    "/#{get_namespace}/ec_png"
  end

  # getter for path of etag action
  def self.get_auth_path
    "/#{get_namespace}/ec_auth"
  end
end