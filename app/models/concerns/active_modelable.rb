module ActiveModelable
  extend ActiveSupport::Concern

  included do
    include ActiveModel::Model
    include ActiveModel::Associations
  end

  # need hash like accessor, used internal Rails
  def [](attr)
    self.send(attr)
  end

  # need hash like accessor, used internal Rails
  def []=(attr, value)
    self.send("#{attr}=", value)
  end
end