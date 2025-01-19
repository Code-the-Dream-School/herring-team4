class NotificationMailer < ApplicationMailer
  def schedule_notification
    @message = params[:message]
    mail(to: params[:recipient].email, subject: "Time to journal!")
  end
end
