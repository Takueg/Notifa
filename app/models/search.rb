class Search < ApplicationRecord
  belongs_to :user
  has_many :notifications
  has_many :posts, through: :notifications

  validates :user, presence: true
  validates :city, presence: true
  validates :frequency, presence: true
  validates :frequency, inclusion: { in: ["immediately", "hourly", "once a day"] }
  validates :category, inclusion: { in: ["studio", "apartment", "private room", "shared room", "house"] }
end
