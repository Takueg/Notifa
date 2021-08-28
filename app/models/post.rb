class Post < ApplicationRecord
  has_many :notifications


  after_create do
    puts "Post was created"
    puts self.title
    puts "finding searches"
    searches = Search.where(max_price: price..Float::INFINITY).where(min_size: 0..size).where(room: 0..room)
    p searches
    searches.each do |search|
      puts "creating notification"
      Notification.create(search_id: search.id, post_id: id, is_sent: false)
    end
  end

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_strings,
    against: [ :category, :address, :title ],
    using: {
      tsearch: { prefix: true }
    }

end
