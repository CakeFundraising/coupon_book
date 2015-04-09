class Fundraiser
  include ActiveModel::Model
  include ActiveModel::Associations

  attr_accessor :id, :name
  attr_reader :coupon_book_ids

  has_many :coupon_books

  # need hash like accessor, used internal Rails
  def [](attr)
    self.send(attr)
  end

  # need hash like accessor, used internal Rails
  def []=(attr, value)
    self.send("#{attr}=", value)
  end
end