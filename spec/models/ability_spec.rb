require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

     it { should_not be_able_to :manage, :all }
  end


  describe 'admin' do
    let(:user) { create :user, admin: true }
    it { should be_able_to :manage, :all }
  end

  describe 'user' do
    let(:user) { create :user }
    let(:other) { create :user }
    let(:question) { create :question, user: user }
    let(:answer) { create :answer, question: question }
    let(:other_question) { create :question, user: other }
    let(:other_answer) { create :answer, question: other_question }
    

    it { should_not be_able_to :manage, :all }
    it { should be_able_to :read, :all }
    it { should be_able_to :create, Question }
    it { should be_able_to :create, Answer }
    it { should be_able_to :create, Comment }

    it { should be_able_to :update, create(:question, user: user), user: user }
    it { should_not be_able_to :update, create(:question, user: other), user: user }

    it { should be_able_to :update, create(:answer, user: user), user: user }
    it { should_not be_able_to :update, create(:answer, user: other), user: user }

    it { should be_able_to :update, create(:comment, body: "my comment") }

    it { should_not be_able_to :best, other_answer }
    it { should be_able_to :best, answer }

    it { should be_able_to :like, other_answer }
    it { should be_able_to :dislike, other_answer }
    it { should be_able_to :withdraw_vote, other_answer }

    it { should_not be_able_to :like, answer }
    it { should_not be_able_to :dislike, answer }
    it { should_not be_able_to :withdraw_vote, answer }

  end

end
