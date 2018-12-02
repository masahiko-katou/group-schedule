class Schedule < ApplicationRecord
  belongs_to :user
  
  validates :user_id, presence: true, length: { maximum: 255 }
  validates :event, presence: true, length: {maximum: 50 }
  validates :event_date, presence: true
  validate :date_cannot_be_in_the_past
  validates :location, length: {maximum: 255}
  validates :detail, length: {maximum: 255}
  
  has_many :answers, dependent: :destroy
  
  def date_cannot_be_in_the_past
    if event_date.present? && event_date < Date.today
      errors.add(:event_date, ": 過去の日付は使用できません")
    end
  end
end
