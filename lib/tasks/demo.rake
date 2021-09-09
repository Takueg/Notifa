namespace :demo do
  desc "Sending notifications for a user search"

  task send_notification: :environment do
    # add more image urls to post one
    # create second post
    # heroku run rake demo:send_notification
    slack_client = Slack::Web::Client.new(token: ENV["SLACK_TOKEN"])
    Post.create(
      title: "Zwischenmiete 15.9.-21.10 im Herzen von Neukölln",
      price: 1050,
      size: 28,
      room: 1,
      image_urls: ["https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/3P4AAOSwSBNhOheu/$_57.JPG"],
      post_url: "https://www.ebay-kleinanzeigen.de/s-anzeige/zwischenmiete-15-9-21-10-im-herzen-von-neukoelln/1868456931-199-3391",
      description: "Wir vermieten unsere wunderschöne Wohnung in der Zeit zwischen 15.9. - 21.10. unter.\n\nDie 5 Wochen sind fix und nicht variabel. Das Haus ist sehr ruhig, daher wünschen wir uns einen verantwortlichen Zwischenmieter, der weder Partys veranstaltet noch auf Krawall aus ist. :-D\n\nDie Wohnung besteht aus Wohnzimmer, Arbeitszimmer, Schlafzimmer, Küche, Duschbad und Balkon! Das WLAN funktioniert ohne Probleme und reicht auch für Video Meetings aus. Die Anbindung ist super (U8 Leinestraße/U7 Karl-Marx-Straße sind in 6 Minuten fußläufig erreichbar), Supermärkte und Restaurants sind ebenfalls nur einen Katzensprung entfernt.\n\nBei Interesse bitte eine Nachricht an mich und wir können gern eine Online Besichtigung vereinbaren und alle weiteren Fragen klären.",
      address: "12053 Berlin - Neukölln",
      date_posted: Date.today,
      company: "ebay-kleinanzeigen",
      # category: "shared flat"
    )
    # Post.create(
    #   title: "Zwischenmiete 15.9.-21.10 im Herzen von Neukölln",
    #   price: 700,
    #   size: 28,
    #   room: 1,
    #   image_urls: ["https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/3P4AAOSwSBNhOheu/$_57.JPG"],
    #   post_url: "https://www.ebay-kleinanzeigen.de/s-anzeige/zwischenmiete-15-9-21-10-im-herzen-von-neukoelln/1868456931-199-3391",
    #   description: "Wir vermieten unsere wunderschöne Wohnung in der Zeit zwischen 15.9. - 21.10. unter.\n\nDie 5 Wochen sind fix und nicht variabel. Das Haus ist sehr ruhig, daher wünschen wir uns einen verantwortlichen Zwischenmieter, der weder Partys veranstaltet noch auf Krawall aus ist. :-D\n\nDie Wohnung besteht aus Wohnzimmer, Arbeitszimmer, Schlafzimmer, Küche, Duschbad und Balkon! Das WLAN funktioniert ohne Probleme und reicht auch für Video Meetings aus. Die Anbindung ist super (U8 Leinestraße/U7 Karl-Marx-Straße sind in 6 Minuten fußläufig erreichbar), Supermärkte und Restaurants sind ebenfalls nur einen Katzensprung entfernt.\n\nBei Interesse bitte eine Nachricht an mich und wir können gern eine Online Besichtigung vereinbaren und alle weiteren Fragen klären.",
    #   address: "12053 Berlin - Neukölln",
    #   date_posted: Date.today,
    #   company: "ebay-kleinanzeigen",
    #   # category: "shared flat"
    # )
    search = Search.last
    begin
      slack_user_id = slack_client.users_lookupByEmail(email: search.user.email).user.id
      slack_client.chat_postMessage(channel: slack_user_id, text: message_text(search))
    rescue Slack::Web::Api::Errors::AccountInactive
      next
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
