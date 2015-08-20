class User < ActiveRecord::Base
  include Omniauthable
  include Rolable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  validates :first_name, :last_name, :email, presence: true
  validates :roles, presence: true, if: :persisted?

  has_roles [:cakester, :merchant, :affiliate]

  def full_name
    "#{first_name} #{last_name}"
  end

  #User roles methods
  def set_cakester!
    unless merchant? or affiliate?
      self.roles = [:cakester]
      self.registered = true
      self.save
    end
  end

  def set_merchant!
    unless cakester? or affiliate?
      self.roles = [:merchant]
      self.registered = true
      self.save
    end
  end

  def set_affiliate!
    unless cakester? or merchant?
      self.roles = [:affiliate]
      self.registered = true
      self.save
    end
  end
end
