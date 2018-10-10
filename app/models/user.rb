class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :schedules
  has_many :answers, dependent: :nullify
  has_many :schedules, through: :answers, source: :schedule
  
  def reaction(schedule)
    self.answers.find_or_create_by(schedule_id: schedule.id)
  end
  
  def deaction(schedule)
    answer = self.answers.find_by(schedule_id: schedule.id)
    answer.destroy if answer
  end
  
  def reaction?(aschedule)
    self.schedules.include?(aschedule)
  end
end