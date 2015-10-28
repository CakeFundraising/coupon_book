class UserNotificationMailer < AsyncMailer
  #New Subscriptor
  def new_subscriptor(sub_id)
    @sub = Subscriptor.find(sub_id)
    @role = @sub.object.decorate
    @origin = @sub.origin.decorate

    mail(to: @role.object.email, cc: @sub.email, subject: 'New Contact from Eats for Good!')
  end 
end