class User < ActiveRecord::Base
  include Omniauthable
  include Rolable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter, :stripe_connect]

  validates :first_name, :last_name, :email, presence: true
  #validates :phone, :url, :roles, presence: true, if: :persisted?

  has_roles [:fundraiser, :merchant, :affiliate, :media_affiliate]

  has_one :location, as: :locatable, dependent: :destroy
  has_one :avatar_picture, as: :avatarable, dependent: :destroy

  accepts_nested_attributes_for :location, update_only: true, reject_if: :all_blank
  accepts_nested_attributes_for :avatar_picture, update_only: true, reject_if: :all_blank

  validates_associated :location, if: :persisted?
  validates_associated :avatar_picture, if: :persisted?

  delegate :zip_code, :city, :state_code, to: :location, allow_nil: true

  searchable do
    text :first_name, :last_name, boost: 2
    text :email, :zip_code, :city, :state_code
    string :type
    boolean :registered
    boolean :tax_exempt
    time :created_at
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  #User roles methods
  def set_fundraiser!
    unless merchant? or affiliate? or media_affiliate?
      self.roles = [:fundraiser]
      self.type = 'Fundraiser'
      self.save
    end
  end

  def set_merchant!
    unless fundraiser? or affiliate? or media_affiliate?
      self.roles = [:merchant]
      self.type = 'Merchant'
      self.save
    end
  end

  def set_affiliate!
    unless fundraiser? or merchant? or media_affiliate?
      self.roles = [:affiliate]
      self.type = 'Affiliate'
      self.save
    end
  end

  def set_media_affiliate!
    unless fundraiser? or merchant? or affiliate?
      self.roles = [:media_affiliate]
      self.type = 'MediaAffiliate'
      self.save
    end
  end

  def registered!
    create_collection if self.fundraiser? or self.merchant?
    update_attribute(:registered, true)
  end
end
