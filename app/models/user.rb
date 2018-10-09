class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :schedules
  has_many :answers
  has_many :reactions, through: :answers, source: :reaction
  
  def reaction(schedule)
    self.answers.find_or_create_by(reaction_id: schedule.id)
  end
  
  def deaction(schedule)
    answer = self.answers.find_by(reaction_id: schedule.id)
    answer.destroy if answer
  end
  
  def reaction?(aschedule)
    self.reactions.include?(aschedule)
  end
end