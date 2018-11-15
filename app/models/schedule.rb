class Schedule < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true, length: { maximum: 255 }
  validates :event, presence: true, length: {maximum: 50 }
  validates :location, length: {maximum: 255}
  validates :detail, length: {maximum: 255}
  
  has_many :answers, dependent: :destroy
  
end
