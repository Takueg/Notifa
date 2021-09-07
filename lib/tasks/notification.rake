namespace :notify do
  desc "Sending notifications for a user search"

  task send_slack_message: :environment do
    slack_client = Slack::Web::Client.new(token: ENV["SLACK_TOKEN"])
    searches = Search.joins(:notifications).where(notifications: {is_sent: [nil, false]})
    # for testing purposes:
    # searches = searches.filter {|search| search.user.email == "tyras.torsten@gmail.com"}
    # iterate through the searches
    searches.each do |search|
      # send slack Messages with search results
      begin
        slack_user_id = slack_client.users_lookupByEmail(email: search.user.email).user.id
        slack_client.chat_postMessage(channel: slack_user_id, text: message_text(search))
      rescue Slack::Web::Api::Errors::AccountInactive
        next
      end
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
        🔗 <#{Rails.application.routes.url_helpers.post_url(notification.post)}|View flat>
      POST
    end
  end
end
