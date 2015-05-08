class Fundraiser < Ohm::Model
  attribute :name
  # attribute :mission
  # attribute :website
  # attribute :phone
  # attribute :email
  # attribute :manager_id
  # attribute :location

  collection :users, :User

  index :name

  alias_method :destroy, :delete

  def self.fetch(cake_id)
    self[cake_id] || self.fetch_and_create!(cake_id)
  end

  def self.fetch_and_create!(cake_id)
    data = Cake::Oauth::Fundraiser.new(self.users.first.cake_access_token).find(cake_id)

    unless data.nil?
      self.create(
        id:   cake_id,
        name: data["name"]
      )
      if data["picture"].present?
        Picture.create(data["picture"])
      end
    end
  end

  def self.create_from_data(data)
    unless data.nil? or self[data["id"]].present?
      self.create(
        id:   data["id"],
        name: data["name"]
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