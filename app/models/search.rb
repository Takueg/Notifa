class Search < ApplicationRecord
  belongs_to :user
  has_many :notifications
  has_many :posts, through :notifications

  validates :user, presence: true
  validates :city, presence: true
  validates :frequency, presence: true
end
