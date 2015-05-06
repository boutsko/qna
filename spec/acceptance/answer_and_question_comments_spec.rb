# coding: utf-8
require 'acceptance_helper'

feature 'User can comment', %q{
  To extend information on an answer
  As a registered user
  I'd like to be able to comment it
}, type: :feature, js: true do

  given (:user) { create(:user) }
  given (:question) { create(:question, user: user) }
  given! (:answer) { create(:answer, question: question, user: user) }
  
  background do
    sign_in(user)
    visit question_path(question)
  end
  
  scenario 'User can comment on answer' do
    within "#answer_#{ answer.id }" do
      click_on 'Create comment'
      fill_in 'Body', with: 'my comment for answer'
      click_on 'Submit'
      expect(page).to have_text 'my comment for answer'
    end
  end

  scenario 'User can comment on question' do
    within "#question_#{ question.id }" do
      click_on 'Create question comment'
      fill_in 'Body', with: 'my comment for question'
      click_on 'Submit'
      expect(page).to have_text 'my comment for question'
    end
  end
  
end
