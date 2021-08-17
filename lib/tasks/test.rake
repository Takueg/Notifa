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
    puts "scraping for ebay posts"
    attributes = "search_item1"
    # EbayScraper.call()
      url = "https://www.ebay-kleinanzeigen.de/s-auf-zeit-wg/#{attributes}"

      def scrape_posts(url)
        post_html = URI.open(url).read
        post_doc = Nokogiri::HTML(post_html)

        title_string = post_doc.search('h2').text.strip
        year = title_string[-5..-2]
        title = title_string[0...-7].strip
        summary = movie_doc.search('.summary_text').text.strip
      end

    # scrape page for post data (e.g. name = Nokogiri etc)

    # save posts to database using scraped data (Flat.create(name: name))
    puts "Fetching the urls"
    urls = fetch_top_5_urls

    puts "Fetching the 5 movies..."
    movies = urls.map do |url|
      scrape_movie(url)  # returns a hash for a movie
    end

    ##################################################
    # open the file, and write in it  - yaml example #
    ##################################################
    File.open("movies.yml", "wb") do |f|
      p movies.to_yaml
      f.write(movies.to_yaml)
    end
    ################################################
    # print result to terminal (puts "post saved") #
    ################################################
    return {title: title, year: year, summary: summary }
  end
end
