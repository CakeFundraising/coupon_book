class User
  include ActiveModelable

  attr_accessor :id, :full_name, :email, :password, :fundraiser_id, :sponsor_id

  belongs_to :fundraiser
  belongs_to :sponsor

  def self.find(id)
    nil
  end
end