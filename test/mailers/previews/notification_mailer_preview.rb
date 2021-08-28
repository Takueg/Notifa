# Preview all emails at http://localhost:3000/rails/mailers/notification_mailer
class NotificationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/notification_mailer/create_notification
  def create_notification
    search = Search.first
    NotificationMailer.with(search: search).create_notification.deliver_now

    # Imagine some users will randomly receive a discount on sign-up.

    # UserMailer.with(user: User.first, discount: true)
    # # You can access these values inside user_mailer.rb
    # # with params[:user] and params[:discount]
    # ⚠️ .with is a class method, call it before calling an “action”:

    # UserMailer.welcome.with(user: User.first) #=> 🧨
    # UserMailer.with(user: User.first).welcome #=> 👌
  end

end
