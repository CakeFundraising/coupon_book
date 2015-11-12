class ConsumersController < InheritedResources::Base
  def create
    create! do |success, failure|
      success.html do
        redirect_to resource.origin, notice: "Thanks! We'll contact you as soon as there is an update in this Campaign."
      end
    end
  end

  def permitted_params
    params.permit(
      consumer: [:first_name, :last_name, :email, :zip_code, :origin_type, :origin_id]
    )
  end
end