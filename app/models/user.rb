class User < ApplicationRecord
  attr_accessor :remember_token
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :schedules, dependent: :destroy
  has_many :answers, dependent: :destroy
  has_many :schedules, through: :answers
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
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
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def numbering(user)
    case user.part
    when "ヴァイオリン" then
      user.update(instrument: 1, section: 1)
    when "ヴィオラ" then
      user.update(instrument: 2, section: 1)
    when "チェロ" then
      user.update(instrument: 3, section: 2)
    when "コントラバス" then
      user.update(instrument: 4, section: 2)
    when "フルート" then
      user.update(instrument: 5, section: 3)
    when "オーボエ" then
      user.update(instrument: 6, section: 3)
    when "クラリネット" then
      user.update(instrument: 7, section: 3)
    when "ファゴット" then
      user.update(instrument: 8, section: 3)
    when "ホルン" then
      user.update(instrument: 9, section: 4)
    when "トランペット" then
      user.update(instrument: 10, section: 4)
    when "トロンボーン" then
      user.update(instrument: 11, section: 4)
    when "チューバ" then
      user.update(instrument: 12, section: 4)
    when "その他" then
      user.update(instrument: 13, section: 5)
    end
  end
end