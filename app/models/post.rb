class Post < ApplicationRecord
  has_many :notifications

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
