class PrBox < ActiveRecord::Base
  include Picturable

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
end