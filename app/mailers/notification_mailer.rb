class NotificationMailer < ApplicationMailer

  def create_notification
    puts "sending notification"
    @search = params[:search]

    mail(
      to:       @search.user.email,
      subject:  "New matches for your #{@search.title} search!"
    )
  end
end
