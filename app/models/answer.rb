class Answer < ActiveRecord::Base
  include Votable
  
  belongs_to :question
  belongs_to :user

  has_many :attachments, as: :attachable
#  has_many :votes, as: :votable
  
  validates :body, presence: true

  # accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }
  
  default_scope { order(best: :desc, created_at: :asc) }

  def make_best
    self.question.answers.update_all(best: false)
    self.update(best: true)
  end
  
end
