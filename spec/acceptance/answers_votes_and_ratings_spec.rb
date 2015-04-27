# coding: utf-8
require 'acceptance_helper'

feature 'User can vote', %q{
  To like an answer
  As a registered user
  I'd like to vote for it
}, type: :feature, js: true do

  given (:question_author) { create(:user) }
  given (:answer_author) { create(:user) }
  given (:question) { create(:question, user: question_author) }
  given! (:answer) { create(:answer, question: question, user: answer_author) }
  given! (:second_answer) { create(:answer, question: question, user: question_author) }
  
  background do
    sign_in(question_author)
    visit question_path(question)
  end
  
  scenario 'User can vote for answer' do
    within "#answer_#{ answer.id }" do
      expect(page).to have_text answer.body
      expect(page).to have_text 'Like'
      expect(page).to have_text 'Dislike'
      expect(page).to have_text 'Rating is: 0'
    end
  end

  scenario 'User can vote for answer only once' do
    within "#answer_#{ answer.id }" do
      click_link 'Like'
      expect(page).to have_text 'Rating is: 1'
      expect(page).to_not have_text 'Like'
      expect(page).to have_text 'Withdraw'
    end
  end
  
  scenario 'User can cancel his vote and re-vote' do
    within "#answer_#{ answer.id }" do
      click_link 'Like'
      expect(page).to have_text 'Rating is: 1'
      click_link 'Withdraw'
      expect(page).to have_text 'Rating is: 0'
      click_link 'Dislike'
      expect(page).to have_text 'Rating is: -1'
    end
  end

  scenario 'User can not vote for his answer' do
    within "#answer_#{ second_answer.id }" do
      expect(page).to_not have_text 'Like'
      expect(page).to_not have_text 'Dislike'
    end
  end
end
