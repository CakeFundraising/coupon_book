class SubscriptorsController < InheritedResources::Base
  skip_before_action :verify_authenticity_token, only: :create

  def create
    create! do |success, failure|
      success.html do
        redirect_to resource.origin, notice: "Thank you for contacting #{object}. Sign up for a free Cake account today, and you'd be one step closer to partnering with #{object}."
      end
    end
  end

  private

  def object
    params[:subscriptor][:object_type].constantize.fetch(params[:subscriptor][:object_id]).decorate
  end

  def permitted_params
    params.permit(
      subscriptor: [:name, :email, :organization, :phone, :message, :object_type, :object_id, :origin_type, :origin_id]
    )
  end
end