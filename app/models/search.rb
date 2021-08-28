class Search < ApplicationRecord
  belongs_to :user
  has_many :notifications, dependent: :destroy
  has_many :unsent_notifications, -> { where(is_sent: nil) }, foreign_key: :search_id, class_name: "Notification", dependent: :destroy
  has_many :posts, through: :notifications

  validates :user, presence: true
  validates :city, presence: true
  # validates :frequency, inclusion: { in: ["Immediately", "Hourly", "Daily"] }
  # validates :frequency, presence: true
  # validates :category, inclusion: { in: ["Studio", "Apartment", "Private room", "Shared room", "House"] }
  # validates :room, numericality: { only_integer: true }

  OPTIONS = ["Immediately", "Hourly", "Daily"]

  def title
    super || "#{city}, #{category}"
  end
end
