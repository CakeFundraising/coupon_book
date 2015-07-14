class PrBox < Coupon
  FLAG_OPTIONS = [
    "Thank You!",
    "Important News!",
    "Free Stuff!",
    "Prizes!",
    "Business Spotlight!",
    "Volunteer!",
    "Special Event!",
    "Join Us!",
    "You're Invited!",
    "Sign Up Now!"
  ]

  validates :title, :description, :url, :flag, :sponsor_name, presence: true
  validates :flag, inclusion: {in: FLAG_OPTIONS}

  before_save do
    self.status = :launched
  end
end