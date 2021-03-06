module Votable
  extend ActiveSupport::Concern

  included do
    has_many :votes, as: :votable, dependent: :destroy
  end

  LIKE = 1
  DISLIKE = -1

  def liked_by(user)
    new_vote_by(user)
  end

  def disliked_by(user)
    new_vote_by(user, DISLIKE)
  end

  def withdraw_vote_by(user)
    votes.where(user: user).delete_all
  end

  def has_vote_by?(user)
    votes.where(user: user).any?
  end

  def vote_by(user)
    votes.find_by(user: user).like
  end

  def rating
    votes.sum :vote
  end

  private

  def new_vote_by(user, like = LIKE)
    votes.create(user: user, vote: like)
  end
end
