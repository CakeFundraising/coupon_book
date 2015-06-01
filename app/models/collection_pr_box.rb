class CollectionPrBox < ActiveRecord::Base
  belongs_to :collection
  belongs_to :pr_box

  acts_as_list scope: :collection

  validates :pr_box, :collection, presence: true
end
