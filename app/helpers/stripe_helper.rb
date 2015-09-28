module StripeHelper
  def stripe_connect_button
    content_tag(:div) do
      content_tag(:div) do
        link_to user_omniauth_authorize_path(:stripe_connect), class:'stripe-connect' do
          content_tag(:span, "Connect with Stripe")
        end 
      end
    end
  end

  def stripe_buttons
    account = current_fundraiser || current_affiliate || current_media_affiliate

    if account.stripe_account?
      go_to_stripe
    else
      stripe_connect_button
    end
  end

  def go_to_stripe
    link_to "https://manage.stripe.com/", target: :_blank, class: 'stripe-connect' do
      content_tag(:span, "Go to Stripe Dashboard")
    end
  end

  def stripe_link(text=nil)
    if text.nil?
      link_to 'https://stripe.com', target: :_blank do
        yield
      end
    else
      link_to text, 'https://stripe.com', target: :_blank
    end
  end
end