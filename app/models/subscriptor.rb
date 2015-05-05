class Subscriptor < ActiveRecord::Base
  include Formats
  
  validates :email, :message, presence: true
  validates_format_of :email, with: EMAIL_REGEX

  belongs_to :object, polymorphic: true
  belongs_to :origin, polymorphic: true

  after_create do
    UserNotification.new_subscriptor(self.id).deliver
  end
end