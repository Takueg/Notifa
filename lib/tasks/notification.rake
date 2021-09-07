namespace :notify do
  desc "Sending notifications for a user search"

  task send_slack_message: :environment do
    slack_client = Slack::Web::Client.new(token: "xoxb-2453239853905-2440672274050-lICCDEvHnLeaeSSXlNfkO0gU")
    searches = Search.joins(:notifications).where(notifications: {is_sent: nil})
    # iterate through the searches
    searches.each do |search|
      # send slack Messages with search results
      slack_user_id = slack_client.users_lookupByEmail(email: search.user.email).user.id
      slack_client.chat_postMessage(channel: slack_user_id, text: message_text(search))
    end
  end

  def message_text(search)
    <<-MESSAGE.gsub(/^ +/, "")
      Hi #{search.user.first_name},

      there are some new results for you at your search *#{search.title}* in *#{search.city}*:

      #{post_list(search).join("\n")}
    MESSAGE
  end

  def post_list(search)
    search.unsent_notifications.map do |notification|
      <<-POST
        *#{notification.post.title}*
        💰 #{notification.post.price} €
        🏠 #{notification.post.size} m2
        🏘 #{notification.post.room} rooms
        🖼 #{notification.post.image_urls.join(", ")}
        🔗 #{Rails.application.routes.url_helpers.post_url(notification.post)}
      POST
    end
  end
end
