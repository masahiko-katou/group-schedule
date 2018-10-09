class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :reaction, class_name: 'Schedule'
  
  validates :user_id, presence: true
  validates :reaction_id, presence: true
end
