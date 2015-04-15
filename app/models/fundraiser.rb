class Fundraiser < Ohm::Model
  attribute :name
  attribute :cake_id

  collection :users, :User
  collection :coupon_books, :CouponBook

  index :name
  index :cake_id

  alias_method :destroy, :delete

  def self.fetch(cake_id)
    Fundraiser.find(cake_id: cake_id.to_s).first || Fundraiser.fetch_and_create!(cake_id)
  end

  def self.fetch_and_create!(cake_id)
    data = Cake::Oauth::Fundraiser.new(self.users.first.access_token).find(cake_id)

    if data.nil?
      nil
    else
      self.create(
        cake_id:  cake_id,
        name:     data[:name]
      )
    end
  end

end