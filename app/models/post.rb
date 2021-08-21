class Post < ApplicationRecord
  has_many :notifications

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_posts,
    against: [ :price, :size, :room, :category, :date_posted, :address ],
    using: {
      tsearch: { prefix: true }
    }
end
