# coding: utf-8
require 'acceptance_helper'

feature 'User can vote', %q{
  To like a question
  As a registered user
  I'd like to vote for it
}, type: :feature, js: true do

  given (:user) { create(:user) }
  given (:question) { create(:question, user: user) }
  given! (:answer) { create(:answer, question: question) }

  
  background do
    sign_in(user)
  end
    
  scenario 'User can vote for question/answer' do

    visit question_path(question)
    expect(page).to have_text question.body
    within "#answer_#{ answer.id }" do
      expect(page).to have_text answer.body
      expect(page).to have_link 'vote_up'
      expect(page).to have_link 'vote_down'
      expect(page).to have_text 'ratio'
    end
  end
  
    
  scenario 'User can not vote for his question/answer'
  scenario 'User can vote for question/answer only once'
  scenario 'User can cancel his vote and re-vote'
  scenario 'Question/answer has raiting'

end
