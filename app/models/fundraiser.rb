class Fundraiser < Ohm::Model
  attribute :name
  attribute :mission
  attribute :website
  attribute :phone
  attribute :email
  attribute :manager_id
  
  attribute :stripe_account_id
  attribute :stripe_publishable_key
  attribute :stripe_account_token

  attribute :location
  attribute :location_address
  attribute :location_city
  attribute :location_zip_code
  attribute :location_state_code
  attribute :location_country_code

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
      fundraiser = self.create(
        id:   data["id"],
        name: data["name"],
        mission: data["mission"],
        website: data["website"],
        phone: data["phone"],
        manager_id: data["manager_id"],
        location: data["location"]["complete"],
        location_address: data["location"]["address"],
        location_city: data["location"]["city"],
        location_zip_code: data["location"]["zip_code"],
        location_state_code: data["location"]["state_code"],
        location_country_code: data["location"]["country_code"],
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
        banner_crop_h: data["picture"]["banner_crop_h"],
        stripe_account_id: data["stripe_account_uid"],
        stripe_account_token: data["stripe_account_token"],
        stripe_publishable_key: data["stripe_publishable_key"]
      )
      fundraiser.create_coupon_collection if fundraiser.coupon_collection.nil?
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