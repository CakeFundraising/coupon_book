class Fundraiser
  include ActiveModelable

  attr_accessor :id, :name
  attr_reader :coupon_book_ids
  attr_reader :user_ids

  has_many :coupon_books
  has_many :users
end