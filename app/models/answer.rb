class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :schedule
  
  validates :user_id, presence: true
  validates :schedule_id, presence: true
  validates :status, presence: true, length: {maximum: 255}
  validates :comment, presence: true, length: {maximum: 255}, on: :absent
end
