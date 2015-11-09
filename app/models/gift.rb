class Gift < ActiveRecord::Base
  belongs_to :purchase

  attr_accessor :email_confirmation

  validates :first_name, :last_name, :email, presence: true

  def name
    "#{first_name} #{last_name}"
  end
end
