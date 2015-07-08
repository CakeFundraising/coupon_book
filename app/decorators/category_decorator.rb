class CategoryDecorator < ApplicationDecorator
  delegate_all
  decorates_association :items

  def to_s
    object.name
  end
end