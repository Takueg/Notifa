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
    attributes = "Berlin" # has to return the search field
    # EbayScraper.call()
      url = "https://www.ebay-kleinanzeigen.de/s-auf-zeit-wg/#{attributes}"
    # scrape page for post data (e.g. name = Nokogiri etc)
      def scrape_posts(url)
        post_html = URI.open(url).read
        post_doc = Nokogiri::HTML(post_html)

        title = post_doc.search('h2').text.strip
        address = post_doc.search('aditem-main--top--left').text.strip
        price = post_doc.search('aditem-main--middle--price').text.strip
        size = post_doc.search('simpletag tag-small').first.text.strip
        post_url = post_doc.search('ellipsis').text.strip
        image_url = post_doc.search('img src').text.strip
        room = post_doc.search('simpletag tag-small').last.text.strip
        # category: nil,
        description = post_doc.search('aditem-main--middle--description').text.strip
        date_posted = post_doc.search('aditem-main--top--right').text.strip
        company = url
        return {title: title, adress: address, price: price, size: size, post_url: post_url, image_url: image_url, room: room, description: description, date_posted: date_posted, company: company}
      end

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
