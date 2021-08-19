require 'open-uri'
require 'nokogiri'
require "yaml" # is just a code-example for the database saving

namespace :scraper do
  desc "Searches Websites for posts"

  task generate_posts: :environment do
    ####################################################
    # commands that could have to be fired on terminal #
    ####################################################
    # rake scraper:generate_posts
    # rake --tasks

    ###################
    # visit website x #
    ###################
    puts "scraping for ebay-kleinanzeigen posts"
    # attributes = "Berlin" # has to return the search field
    # EbayScraper.call()
    card_selector = 'article.aditem'
    # title_selector = 'h2.text-module-begin'
    # address_selector = 'div.aditem-main--top--left'
    # price_selector = 'p.aditem-main--middle--price'
    # size_selector = 'span.simpletag.tag-small'
    # room_selector = 'span.simpletag.tag-small'
    # description_selector = 'p.viewad-description-text'
    # image_url_selector = 'data-ix="0"'
    article_selector = 'section.a-span-16.l-col'
    title_selector = 'h1'

    # room = post_doc.search('simpletag tag-small').last.text.strip
    # # category: nil,
    # description = post_doc.search('aditem-main--middle--description').text.strip
    # date_posted = post_doc.search('aditem-main--top--right').text.strip
    # company = url
      index_url = "https://www.ebay-kleinanzeigen.de/"
      show_url = "https://www.ebay-kleinanzeigen.de/s-auf-zeit-wg/berlin/c199l3331"
    # scrape page for post data (e.g. name = Nokogiri etc)
      # def scrape_posts(url)
      post_html = URI.open(show_url).read
      post_doc = Nokogiri::HTML(post_html)
      unique_url = post_doc.at('article').values.last # getting the href of the card

      show_page = index_url + unique_url
      show_html = URI.open(show_page).read
      show_doc = Nokogiri::HTML(show_html)

      show_doc.search(article_selector).each  do |article|
        title = article.search(title_selector).last.content.strip
        # address = card.search(address_selector).first.content.strip
        # price = card.search(price_selector).first.content.strip
        # size = card.search(size_selector).first.content.strip
        # room = card.search(room_selector).last.content.strip
        # post_url_tag = card.search(post_url_selector)
        # description = card.search(description_selector).first.content.strip
        # image = card.search(image_url_selector).first
        # p post_url_tag
        p title
        # p address
        # p price
        # p size
        # p room
        # p description
        # Post.create(title: title, address: address, price: price, size: size, post_url: post_url, image_url: image_url, room: room, description: description, date_posted: date_posted, company: company)
      end

      # return {title: title, adress: address, price: price, size: size, post_url: post_url, image_url: image_url, room: room, description: description, date_posted: date_posted, company: company}
      # end

    # # save posts to database using scraped data (Flat.create(name: name))
    # puts "Fetching the urls"
    # urls = fetch_top_5_urls

    # puts "Fetching the 5 movies..."
    # movies = urls.map do |url|
    #   scrape_movie(url)  # returns a hash for a movie
    # end

    # ##################################################
    # # open the file, and write in it  - yaml example #
    # ##################################################
    # File.open("movies.yml", "wb") do |f|
    #   p movies.to_yaml
    #   f.write(movies.to_yaml)
    # end
    ################################################
    # print result to terminal (puts "post saved") #
    ################################################
    # return {title: title, adress: address, price: price, size: size, post_url: post_url, image_url: image_url, room: room, description: description, date_posted: date_posted, company: company}
  end
end
