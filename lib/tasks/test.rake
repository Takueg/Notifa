namespace :scraper do
  desc "Searches Websites for posts"

  task generate_posts: :environment do
    puts "whatever i like to say"
    # rake scraper:generate_posts
    # rake --tasks
    # visit website x
    puts "scraping for ebay posts"
    EbayScraper.call()

    puts "scraping for wg gesucht posts"
    WgScraper.call()
    # scrape page for post data (e.g. name = Nokogiri etc)

    # save posts to database using scraped data (Flat.create(name: name))
    # print result to terminal (puts "post saved")

  end
end
