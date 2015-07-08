class Sponsor < Ohm::Model
  attribute :name
  attribute :mission
  attribute :website
  attribute :phone
  attribute :email
  attribute :manager_id

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
    data = Cake::Oauth::Sponsor.new.find(cake_id)
    self.create_from_data(data) unless data.nil?
  end

  def self.create_from_data(data)
    unless data.nil? or self[data["id"]].present?
      sponsor = self.create(
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
        banner_crop_h: data["picture"]["banner_crop_h"]
      )
      sponsor.create_collection if sponsor.collection.nil?
      sponsor
    end
  end

  #Collection
  def collection
    Collection.where(owner_type: 'Sponsor', owner_id: self.id.to_i).first
  end

  def build_collection
    Collection.new(owner_type: 'Sponsor', owner_id: self.id.to_i)
  end

  def create_collection
    Collection.create(owner_type: 'Sponsor', owner_id: self.id.to_i)
  end

  #Picture
  def picture
    Picture.where(picturable_type: 'Sponsor', picturable_id: self.id.to_i).first
  end

  #Coupons
  def coupons
    collection.coupons
  end

  def pr_boxes
    collection.pr_boxes
  end

  #Vouchers
  def vouchers
    Voucher.where(owner_type: 'Sponsor', owner_id: self.id.to_i)
  end

  #Analytics
  def total_unique_clicks
    self.collection.extra_clicks.count
  end

  def total_clicks
    self.coupons.sum(:extra_clicks_count)
  end

  def total_vouchers_sold
    self.vouchers.count
  end
end