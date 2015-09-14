class Commission < ActiveRecord::Base
  belongs_to :purchase
  belongs_to :owner, polymorphic: true

  monetize :amount_cents
end
