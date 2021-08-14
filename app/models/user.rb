class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :searches, dependent: :destroy
  has_many :notifications, through: :searches
  # has_many :posts, through :notifications
end
