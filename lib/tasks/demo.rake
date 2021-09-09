namespace :demo do
  desc "Sending notifications for a user search"

  task send_notification: :environment do
    # add more image urls to post one
    # create second post
    # heroku run rake demo:send_notification
    slack_client = Slack::Web::Client.new(token: ENV["SLACK_TOKEN"])
    Post.create(
      title: "Möbliertes Zimmer in frisch renovierter Wohnung, HK, Strom inklu.",
      price: 700,
      size: 35,
      room: 1,
      image_urls: [
        "https://i.ebayimg.com/00/s/NzY4WDEwMjQ=/z/y6sAAOSwPx5hFUa1/$_57.JPG",
        "https://i.ebayimg.com/00/s/MTYwMFgxMjAw/z/5xEAAOSwQL1hFUa0/$_57.JPG",
        "https://i.ebayimg.com/00/s/MTAyNFg3Njg=/z/zTkAAOSwrlthFUar/$_57.JPG"],
      post_url: "https://www.ebay-kleinanzeigen.de/s-anzeige/moebliertes-zimmer-in-frisch-renovierter-wohnung-hk-strom-inklu-/1844346652-199-17084",
      description: "Zur Vermietung steht das größte frisch renovierte und möblierte Zimmer einer 5-Zimmerwohnung in Friedenau. Das Zimmer ist ca. 35qm groß, verfügt über einen eigenen Wintergarten und ist Teil einer 5-Zimmerwohnung und WG wovon 3 Zimmer zur Zeit an deine zukünftigen Mitbewohner/in vermietet sind. Alle Zimmer sind möbliert sowie abschließbar und immer mindestens mit einem Kleiderschrank, Schreibtisch, Schrank, Sofa sowie Bett mit Matratze ausgestattet. Die Ausstattung des Zimmer kannst du auch direkt den Bildern entnehmen.\n\nDie Wohnung selbst befindet sich im 1 OG eines Mehrfamilienhauses in sehr ruhiger Lage. Sie ist 2017 vollumfänglich saniert worden und verfügt über eine luxuriöse Deckenhöhe von 3,80 Metern und Holzdielen in der gesamten Wohnung.\n\nDie Küche ist neu und mit allem ausgestattet was für den nächsten Kochabend nötig ist. Die Wohnung hat ein Bad mit WC und Dusche sowie ein zusätzliches separates WC.\n\nDas bedeutet du kannst je nach Bedarf direkt nur mit einem Koffer einziehen oder bringst zusätzlich deine eigenen Möbel mit. Im fussläufigem 5 min. Umkreis befinden sich Bäcker, Supermärkte und Restaurants.\n\nIn der Miete von 700€ sind sämtliche Nebenkosten inklusive Strom und Internet enthalten.",
      address: "Hertelstraße, 12161 Berlin - Friedenau",
      date_posted: Date.today,
      company: "ebay-kleinanzeigen",
      # category: "shared flat"
    )
    Post.create(
      title: "Untermiete auf Zeit - möblierte 2 Zimmer Wohnung in Wilmersdorf",
      price: 1200,
      size: 56,
      room: 2,
      image_urls: [
        "https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/urgAAOSwyIthOeq~/$_57.JPG",
        "https://i.ebayimg.com/00/s/MTIwMFgxNjAw/z/XpAAAOSwV45hOeq2/$_57.JPG",
        "https://i.ebayimg.com/00/s/MTYwMFgxMjAw/z/v~sAAOSwgDFhOeqt/$_57.JPG"],
      post_url: "https://www.ebay-kleinanzeigen.de/s-anzeige/untermiete-auf-zeit-moeblierte-2-zimmer-wohnung-in-wilmersdorf/1868288636-199-3537",
      description: "Die Wohnung befindet sich in Berlin Wilmersdorf und soll vom 01.10.2021 - 31.03.2022 untervermietet werden.\n\nObjektbeschreibung:\n\nDie Wohnung hat ein Schlafzimmer mit Fenster zum Innenhof, ein großes Wohnzimmer mit Balkon, Küche, Bad und eine geräumige Kammer mit genug Platz zum Verstauen.\n\nDie Untervermietung erfolgt nach Absprache mit der Hausverwaltung. Eine Anmeldung bei der Polizei ist möglich. Die Wohnung ist sehr zentral gelegen, die U-Bahnlinien U7 und U9 sowie der Bus 104 sind einige Gehminuten entfernt. Einkaufsmöglichkeiten, Restaurants, Spätis, Bäckerei sowie der Volkspark sind fußläufig erreichbar.\n\nIn der Miete sind bereits alle Kosten enthalten. Die Wohnung ist voll möbliert und mit allem ausgestattet.",
      address: "10715 Berlin - Wilmersdorf",
      date_posted: Date.today,
      company: "ebay-kleinanzeigen",
      # category: "shared flat"
    )
    # Post.create(
    #   title: "3-Zi City Apartment möbliert nahe KuDamm KaDeWe voll ausgestattet",
    #   price: 1700,
    #   size: 68,
    #   room: 3,
    #   image_urls: [
    #     "https://i.ebayimg.com/00/s/OTAwWDEyMDA=/z/M90AAOSww6RhOJkg/$_57.JPG",
    #     "https://i.ebayimg.com/00/s/OTAwWDEyMDA=/z/0mYAAOSw4BVhOJki/$_57.JPG",
    #     "https://i.ebayimg.com/00/s/OTAwWDEyMDA=/z/GsMAAOSwug9hOJkk/$_57.JPG"],
    #   post_url: "https://www.ebay-kleinanzeigen.de/s-anzeige/3-zi-city-apartment-moebliert-nahe-kudamm-kadewe-voll-ausgestattet/1867494499-199-3497",
    #   description: "Hochwertiges 3 Zimmer City-Apartment in 10777 Wilmersdorf voll ausgestattet\n\nObjektbeschreibung\n\nWunderschöne 3-Zimmer Wohnung mit Einbauküche, modernem Duschbad,\n\nWest-Balkon\n\n\Die Wohnung befindet sich im 2.OG mit Fahrstuhl\n\nLage\n\nDas Objekt liegt in der City West, unweit vom Ku´damm und KaDeWe. Die U-Bhf Augsburger Straße und Spichernstraße sind in weniger als 2 min fußläufig zu erreichen. Supermarkt, Bar, Restaurants etc. gibt es direkt vor der Tür.\n\n\Parkplätze können angemietet werden.\n\n\Wohnzimmer\n\n\Lounge Sofa\n\n\Hülsta Tische\n\n\Smart Lighting\n\n\Samsung Smart TV\n\n\Großer Balkon\n\n\Schlafzimmer\n\n\Premium Polster Boxspringbett 180x200cm\n\n\Schranksystem\n\n\kann indivduell noch angepasst werden\n\n\Smart Lighting",
    #   address: "Fürtherstr, 10777 Berlin - Tiergarten",
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
