class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  
  validates :body, :question, :user, presence: true
end
