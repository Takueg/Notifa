class Search < ApplicationRecord
  belongs_to :user
  has_many :notifications
  has_many :posts, through: :notifications

  validates :user, presence: true
  validates :city, presence: true
  validates :frequency, inclusion: { in: ["Immediately", "Hourly", "Once a day"] }
  validates :frequency, presence: true
  validates :category, inclusion: { in: ["Studio", "Apartment", "Private room", "Shared room", "House"] }
  # validates :room, numericality: { only_integer: true }

  OPTIONS = ["Immediately", "Hourly", "Once a day"]
end
