class Consumer < ActiveRecord::Base
  belongs_to :origin, polymorphic: true

  validates :email, :zip_code, :origin, presence: true
end
