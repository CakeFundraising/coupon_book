class PrBox < ActiveRecord::Base
  include Picturable

  attr_accessor :fr_collection_id, :coupon_book_id, :disabled

  FLAG_OPTIONS = [
    "Thank You!",
    "Important News!",
    "Free Stuff!",
    "Prizes!",
    "Business Spotlight!",
    "Volunteer!",
    "Special Event!",
    "Join Us!",
    "You're Invited!"
  ]

  belongs_to :origin_collection, class_name: 'Collection', foreign_key: :collection_id

  has_many :collection_pr_boxes, dependent: :destroy
  has_many :collections, through: :collection_pr_boxes

  scope :latest, ->{ order(created_at: :desc) }

  validates :headline, :story, :url, :flag, :origin_collection, presence: true
  validates :flag, inclusion: {in: FLAG_OPTIONS} 

  delegate :owner, to: :origin_collection

  after_create :add_to_collection

  private

  def add_to_collection
    self.collection_pr_boxes.create(collection_id: self.collection_id) #Add coupon to owner's collection
  end
end