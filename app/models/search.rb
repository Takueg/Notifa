class Search < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :destroy
  has_many :unsent_notifications, -> { where(is_sent: [nil, false]) }, foreign_key: :search_id, class_name: "Notification", dependent: :destroy
  has_many :posts, through: :notifications

  validates :user, presence: true
  validates :city, presence: true
  # validates :frequency, inclusion: { in: ["Immediately", "Hourly", "Daily"] }
  # validates :frequency, presence: true
  # validates :category, inclusion: { in: ["Studio", "Apartment", "Private room", "Shared room", "House"] }
  # validates :room, numericality: { only_integer: true }

  # def title
  #   super || "#{city}, #{category}"
  # end

  FREQUENCY_OPTIONS = ["Immediately", "Hourly", "Daily"]
  CHANNEL_OPTIONS = ["Email", "SMS", "Slack"]
end
