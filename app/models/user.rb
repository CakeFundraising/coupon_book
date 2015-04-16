class User < Ohm::Model
  attribute :full_name
  attribute :email
  attribute :cake_access_token

  reference :fundraiser, :Fundraiser
  reference :sponsor, :Sponsor

  unique :email
  index :cake_access_token

  alias_method :destroy, :delete

  def fetch(cake_id)
    self[cake_id]
  end

  def self.create_from_token(access_token)
    data = Cake::Oauth::User.new(access_token).self

    unless data.nil? or self[data["id"]].present?
      self.create(
        id:                data["id"],
        full_name:         data["info"]["full_name"],
        email:             data["info"]["email"],
        cake_access_token: access_token,
        fundraiser_id:     data["info"]["fundraiser_id"],
        sponsor_id:        data["info"]["sponsor_id"]
      )
      Fundraiser.create_from_data(data["extra"].try(:[], "fundraiser"))
      Sponsor.create_from_data(data["extra"].try(:[], "sponsor"))
    end
  end

  def self.find_by_access_token(access_token)
    if access_token.present?
      self.find(cake_access_token: access_token).first || self.create_from_token(access_token)
    end
  end

  def fundraiser
    Fundraiser.fetch(self.fundraiser_id.to_i)
  end

  def sponsor
    Sponsor.fetch(self.sponsor_id.to_i)
  end

  def fundraiser?
    self.fundraiser_id.present?
  end

  def sponsor?
    self.sponsor_id.present?
  end

end