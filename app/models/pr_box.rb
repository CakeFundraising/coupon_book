class PrBox < ActiveRecord::Base
  include Picturable

  belongs_to :parent, polymorphic: true

  scope :latest, ->{ order(created_at: :desc) }

  validates :headline, :story, :url, :parent, presence: true

  #delegate :city, :state_code, to: :sponsor

end