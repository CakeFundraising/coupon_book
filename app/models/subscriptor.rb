class Subscriptor < ActiveRecord::Base
  include Formats
  
  validates :email, :message, presence: true
  validates_format_of :email, with: EMAIL_REGEX

  belongs_to :object, polymorphic: true
  belongs_to :origin, polymorphic: true

  after_create do
    UserNotificationMailer.new_subscriptor(self.id).deliver_now
  end

  def object
    self.object_type.constantize.fetch(self.object_id)
  end
end