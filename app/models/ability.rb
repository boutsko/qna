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
    can :manage, Comment

    can :manage, Vote do |v|
      user != v.user
    end

    can :like, Answer do |a|
      user != a.user
    end

    can :dislike, Answer do |a|
      user != a.user
    end

    can :withdraw_vote, Answer do |a|
      user != a.user
    end
  end
  
  def admin_abilities
    can :manage, :all
  end

end
