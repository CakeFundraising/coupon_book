class User < Ohm::Model
  attribute :full_name
  attribute :email
  attribute :cake_id
  attribute :cake_access_token

  reference :fundraiser, :Fundraiser
  reference :sponsor, :Sponsor

  unique :email
  unique :cake_id
  index :cake_access_token

  alias_method :destroy, :delete

  def fetch(cake_id)
    
  end

  def self.fetch_and_create!(access_token)
    data = Cake::Oauth::User.new(access_token).self

    if data.nil?
      nil
    else
      self.create(
        cake_id:           data[:cake_id],
        full_name:         data[:full_name],
        email:             data[:email],
        cake_access_token: access_token,
        fundraiser_id:     data[:fundraiser_id],
        sponsor_id:        data[:sponsor_id]
      )
    end
  end

  def self.find_by_access_token(access_token)
    if access_token.present?
      self.find(cake_access_token: access_token).first || self.fetch_and_create!(access_token)
    end
  end

end