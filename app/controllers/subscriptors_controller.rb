class SubscriptorsController < InheritedResources::Base
  skip_before_action :verify_authenticity_token, only: :create

  def create
    create! do |success, failure|
      success.html do
        redirect_to resource.origin, notice: "Thank you for contacting us. Sign up for a free Eats For Good account today!"
      end
    end
  end

  private

  def object
    resource.object.decorate
  end

  def permitted_params
    params.permit(
      subscriptor: [:name, :email, :organization, :phone, :message, :object_type, :object_id, :origin_type, :origin_id]
    )
  end
end