class Schedule < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true, length: { maximum: 255 }
  validates :event, presence: true, length: {maximum: 50 }
  
  has_many :answers
  
end
