namespace :notify do
  desc "Sending notifications for a user search"

  task send_emails: :environment do
    # find searches with unsent notifications
    searches = Search.joins(:notifications).where(notifications: {is_sent: nil})
    # iterate through the searches
    searches.each do |search|
      # send email with search results
      NotificationMailer.with(search: search).create_notification.deliver_now
    end
  end
end
