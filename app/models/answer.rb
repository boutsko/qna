class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachmentable
  
  validates :body, presence: true

  accepts_nested_attributes_for :attachments
  
  default_scope { order(best: :desc, created_at: :asc) }

  def make_best
    self.question.answers.update_all(best: false)
    self.update(best: true)
  end
  
end
