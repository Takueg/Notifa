class Notification < ApplicationRecord
  belongs_to :post
  belongs_to :search
end
