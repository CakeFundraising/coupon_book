class ApplicationDecorator < Draper::Decorator
  delegate_all

  def created_at
    object.created_at.strftime("%B %d, %Y")
  end

  def updated_at
    object.updated_at.strftime("%B %d, %Y")
  end
end