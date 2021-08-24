class Post < ApplicationRecord
  has_many :notifications

  after_create do
    puts "Post was created"
    puts self.title
  end
end
