require 'open-uri'
require 'nokogiri'

namespace :scraper do
  desc "Searches Websites for posts"

  task generate_posts: :environment do
    #####################
    # terminal commands #
    #####################
    # rake scraper:generate_posts
    # rake --tasks

    puts "scraping for ebay-kleinanzeigen posts"

    card_selector = 'article.aditem'
      index_url = "https://www.ebay-kleinanzeigen.de"
      show_url = "https://www.ebay-kleinanzeigen.de/s-auf-zeit-wg/berlin/c199l3331"
      card_selector = 'article.aditem'

      # scraping_bee_url = "https://app.scrapingbee.com/api/v1/?api_key=2LNK704U3KIKTNT09S819GAP300XR9YVYKDG1LR7Q1QW8O7FOMMG978YAIO7VP3GWC7ZY0NFFYLJQM92&url=#{index_url}"

      post_html = URI.open(show_url).read
      post_doc = Nokogiri::HTML(post_html)

      post_doc.search(card_selector).each do |card|
        card_url = card.search("a").first.attr("href") # alternatively: card_url = post_doc.at('article').values.last
        puts ""
        puts "new card\n"
        puts ""
        show_page = index_url + card_url
        show_html = URI.open(show_page).read
        show_doc = Nokogiri::HTML(show_html)

        article_selector = '.boxedarticle'
        title_selector = '.boxedarticle--title'
        address_selector = 'span#street-address'
        price_selector = '.boxedarticle--price'
        size_selector = '.addetailslist--detail--value'
        # post_url_selector =
        images_selector = '.galleryimage-large'
        room_selector = '.addetailslist--detail--value'
        description_selector = 'p' # 'p#viewad-description-text.textforce-line-break'
        date_posted_selector = 'div#viewad-extra-info' ##<Nokogiri::XML::Element:0x3ffbf4d6a350 name="span" children=[#<Nokogiri::XML::Text:0x3ffbf3b44220 "21.08.2021">]>]>
        title = show_doc.search(article_selector).search(title_selector).first.content.strip
        address = show_doc.search(article_selector).search(address_selector).text.strip
        price = show_doc.search(article_selector).search(price_selector).first.content.strip
        size = show_doc.search(size_selector)[2]&.text&.strip
        post_url = index_url + card_url
        image_urls = show_doc.search(images_selector).first
        if image_urls
          image_urls.search("img").each do |image|
            image.attr("src")
          end
        end
        room = show_doc.search(room_selector)[3]&.text&.strip
        description = show_doc.search(description_selector).find { |span| span['itemprop'] == 'description' }.text.strip
        date_posted = show_doc.search(date_posted_selector).text.strip[0..9]
        company = "ebay-kleinanzeigen"

        # Post.create(title: title, address: address, price: price, size: size, post_url: post_url, image_url: image_urls, room: room, description: description, date_posted: date_posted, company: company)
      end
      return (title: title, address: address, price: price, size: size, post_url: post_url, image_url: image_urls, room: room, description: description, date_posted: date_posted, company: company)
  end
end
