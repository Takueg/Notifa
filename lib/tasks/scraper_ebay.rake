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

    index_url = "https://www.ebay-kleinanzeigen.de"
    show_url = "https://www.ebay-kleinanzeigen.de/s-auf-zeit-wg/berlin/c199l3331"
    card_selector = 'article.aditem'

    post_html = URI.open(show_url).read
    post_doc = Nokogiri::HTML(post_html)

    post_doc.search(card_selector).first(15).each do |card|
      card_url = card.search("a").first.attr("href")
      show_page = index_url + card_url
      sleep(120)
      show_html = URI.open(show_page).read
      show_doc = Nokogiri::HTML(show_html)

      article_selector = '.boxedarticle'
      title_selector = '.boxedarticle--title'
      street_selector = 'span#street-address'
      city_selector = 'span#viewad-locality'
      price_selector = '.boxedarticle--price'
      size_selector = '.addetailslist--detail--value'
      images_selector = '.galleryimage-large'
      room_selector = '.addetailslist--detail--value'
      description_selector = 'p'
      date_posted_selector = 'div#viewad-extra-info'

      title = show_doc.search(article_selector).search(title_selector).first.content.strip
      street = show_doc.search(article_selector).search(street_selector).text.strip
      city = show_doc.search(article_selector).search(city_selector).text.strip
      address = street + ", " + city
      p address
      price = show_doc.search(article_selector).search(price_selector).first.content.strip
      size = show_doc.search(size_selector)[2]&.text&.strip
      post_url = index_url + card_url
      room = show_doc.search(room_selector)[3]&.text&.strip
      description = show_doc.search(description_selector).find { |span| span['itemprop'] == 'description' }.text.strip
      date_posted = show_doc.search(date_posted_selector).text.strip[0..9]
      company = "ebay-kleinanzeigen"
      image_gallery = show_doc.search(images_selector).first
        image_urls = []
        if image_gallery
          image_gallery.search("img").each do |image|
            image_urls << image.attr("src")
          end
        end

      Post.create!(title: title, address: address, price: price, size: size, post_url: post_url, room: room, description: description, date_posted: date_posted, company: company, image_urls: image_urls)
    end
  end

  task create_json: :environment do
    # should take all Posts and serialize them to a json
    filepath = File.join(Rails.root, 'db', 'posts.json')
    all_posts = JSON.generate(Post.all.map { |post|  post.attributes  })
    File.open(filepath, 'wb') do |file|
      file.write(all_posts)
    end
  end
end
