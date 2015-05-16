class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      if user.admin?
        can :manage, :all
      else
        can :read, :all
        can :create, [ Question, Answer, Comment ]
        can :update, Question,  user: user
        can :update, Answer,  user: user
        can :update, Comment
      end
    end
    can :read, :all
  end
end
