class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :questions
  has_many :answers
  has_many :votes

  def author_of?(obj)
    obj.user_id = self.id
  end

  def can_vote_for?(votable)
    votable.user_id != self.id
  end

end
