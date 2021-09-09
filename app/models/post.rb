class Post < ApplicationRecord
  has_many :notifications

  before_create do
    if price < 50
      self.price = rand(250..2000)
    end
    if room.nil? || room < 1 || room > 10
      self.room = rand(1..5)
    end
    if size.nil? || size < 8
      self.size = rand(8..50)
    end
  end

  after_create do
    puts "Post was created"
    searches = Search.all
    if price.present?
      searches = searches.where(max_price: price..Float::INFINITY).or(searches.where(max_price: nil))
    end
    if room.present?
      searches = searches.where(room: 0..room).or(searches.where(room: nil))
    end
    if size.present?
      searches = searches.where(min_size: 0..size).or(searches.where(min_size: nil))
    end

    searches.each do |search|
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
