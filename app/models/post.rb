class Post < ApplicationRecord
  has_many :notifications


  after_create do
    puts "Post was created"
    puts self.title
  end

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch::Model
  pg_search_scope :search_strings,
    against: [ :category, :address ],
    using: {
      tsearch: { prefix: true }
    }
  
end
