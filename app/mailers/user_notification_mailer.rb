class UserNotificationMailer < ApplicationMailer
  #New Subscriptor
  def new_subscriptor(sub_id)
    @sub = Subscriptor.find(sub_id)
    @role = @sub.object
    @origin = @sub.origin.decorate

    #mail(to: @role.manager.email, cc: @sub.email, subject: 'New Contact from Cake!')
    mail(to: 'bismark64@gmail.com', subject: 'New Contact from Eats for Good!')
  end 
end