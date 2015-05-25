class AvatarPicture < ActiveRecord::Base
  belongs_to :avatarable, polymorphic: true, touch: true

  attr_accessor :bypass_cloudinary_validation

  URI_SIZES = {
    ico: [25, 19],
    thumb: [50, 38],
    square: [120, 120],
    medium: [300, 200]
  }

  validates :uri, presence: true, if: :persisted?

  after_initialize do
    self.bypass_cloudinary_validation ||= false 
  end

  before_save do
    unless Rails.env.test?
      get_cloudinary_identifier if self.uri.present? and self.uri_changed? and self.bypass_cloudinary_validation == 'false'
    end
  end

  private

  def get_cloudinary_identifier
    preloaded = Cloudinary::PreloadedFile.new(self.uri)
    raise "Invalid upload signature" unless preloaded.valid?
    self.uri = preloaded.identifier
  end
end
