class User < ActiveRecord::Base
  include Omniauthable
  include Rolable

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :confirmable
  devise :omniauthable, omniauth_providers: [:facebook, :twitter]

  validates :first_name, :last_name, :email, presence: true
  validates :roles, presence: true, if: :persisted?

  has_roles [:fundraiser, :merchant, :cakester]
end
