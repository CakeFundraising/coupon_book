class Fundraiser < Ohm::Model
  attribute :name
  attribute :mission
  attribute :website
  attribute :phone
  attribute :email
  attribute :manager_id
  attribute :location

  attribute :avatar
  attribute :avatar_caption
  attribute :avatar_crop_x
  attribute :avatar_crop_y
  attribute :avatar_crop_w
  attribute :avatar_crop_h
  attribute :banner
  attribute :banner_caption
  attribute :banner_crop_x
  attribute :banner_crop_y
  attribute :banner_crop_w
  attribute :banner_crop_h

  collection :users, :User

  index :name

  alias_method :destroy, :delete

  def self.fetch(cake_id)
    self[cake_id] || self.fetch_and_create!(cake_id)
  end

  def self.fetch_and_create!(cake_id)
    data = Cake::Oauth::Fundraiser.new.find(cake_id)
    self.create_from_data(data) unless data.nil?
  end

  def self.create_from_data(data)
    unless data.nil? or self[data["id"]].present?
      self.create(
        id:   data["id"],
        name: data["name"],
        mission: data["mission"],
        website: data["website"],
        phone: data["phone"],
        manager_id: data["manager_id"],
        location: data["location"]["complete"],
        avatar: data["picture"]["avatar"],
        avatar_caption: data["picture"]["avatar_caption"],
        avatar_crop_x: data["picture"]["avatar_crop_x"],
        avatar_crop_y: data["picture"]["avatar_crop_y"],
        avatar_crop_w: data["picture"]["avatar_crop_w"],
        avatar_crop_h: data["picture"]["avatar_crop_h"],
        banner: data["picture"]["banner"],
        banner_caption: data["picture"]["banner_caption"],
        banner_crop_x: data["picture"]["banner_crop_x"],
        banner_crop_y: data["picture"]["banner_crop_y"],
        banner_crop_w: data["picture"]["banner_crop_w"],
        banner_crop_h: data["picture"]["banner_crop_h"]
      )
    end
  end

  #Associations
  def coupon_books
    CouponBook.where(fundraiser_id: self.id.to_i)
  end

  #Subscriptor
  def subscriptors
    Subscriptor.where(object_type: 'Fundraiser', object_id: self.id.to_i)
  end

  #Picture
  def picture
    Picture.where(picturable_type: 'Fundraiser', picturable_id: self.id.to_i).first
  end

  #Collection
  def coupon_collection
    Collection.where(owner_type: 'Fundraiser', owner_id: self.id.to_i).first
  end

  def build_coupon_collection
    Collection.new(owner_type: 'Fundraiser', owner_id: self.id.to_i)
  end

  def create_coupon_collection
    Collection.create(owner_type: 'Fundraiser', owner_id: self.id.to_i)
  end
end