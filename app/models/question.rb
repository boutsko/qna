class Question < ActiveRecord::Base
  include Votable
  include Commentable

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :attachments, as: :attachable
  has_many :votes, as: :votable

  validates :title, :body, :user,  presence: true
  
  #  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :attachments, reject_if: proc { |attrib| attrib['file'].nil? }

  after_save :update_reputation

  private

  def update_reputation
    self.delay.calculate_reputation
  end
  
  def calculate_reputation
    reputation = Reputation.calculate(self)
    self.user.update(reputation: reputation)
  end

end
