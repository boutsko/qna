class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user

    if user
      user.admin? ? admin_abilities : user_abilities
    else
      guest_abilities
    end
  end

  def guest_abilities
    can :read, :all
  end

  def user_abilities
    guest_abilities
    can :manage, [ Question, Answer ], user: user
    can :best, Answer do |a|
      user == a.question.user
    end

    can :create, Subscriber do |subscriber|
      !@user.subscribers.where(question_id:subscriber.question).present?
    end
    can :destroy, Subscriber do user_id: user
      
    can :manage, Comment

    can :like, [ Question, Answer ] do |votable|
      user.id != votable.user_id
    end

    can :dislike, [ Question, Answer ] do |votable|
      user.id != votable.user_id
    end

    can :withdraw_vote, [ Question, Answer ] do |votable|
      user.id != votable.user_id
    end
  end

  def admin_abilities
    can :manage, :all
  end

end
