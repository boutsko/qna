class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  
  validates :body, presence: true

  default_scope { order(created_at: :asc) }

  def make_best
    self.question.answers.update_all(best: false)
    self.update(best: true)
  end
  
end
