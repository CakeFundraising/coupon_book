class AvatarPicture < ActiveRecord::Base
  belongs_to :avatarable, polymorphic: true, touch: true

  attr_accessor :bypass_clodinary_validation

  URI_SIZES = {
    ico: [25, 19],
    thumb: [50, 38],
    square: [120, 120],
    medium: [300, 200]
  }

  validates :uri, presence: true, if: :persisted?

  before_save do
    unless Rails.env.test? or self.bypass_clodinary_validation
      get_cloudinary_identifier if self.uri.present? and self.uri_changed?
    end
  end

  private

  def get_cloudinary_identifier
    preloaded = Cloudinary::PreloadedFile.new(self.uri)
    raise "Invalid upload signature" unless preloaded.valid?
    self.uri = preloaded.identifier
  end
end
