# coding: utf-8
require 'acceptance_helper'

feature 'User can vote', %q{
  To like a question
  As a registered user
  I'd like to vote for it
}, type: :feature, js: true do

  given (:question_author) { create(:user) }
  given (:answer_author) { create(:user) }
  given (:question) { create(:question, user: question_author) }
  given! (:answer) { create(:answer, question: question, user: answer_author) }
  
  background do
    sign_in(question_author)
  end
  
  scenario 'User can vote for question/answer' do

    visit question_path(question)
    expect(page).to have_text question.body

    within "#answer_#{ answer.id }" do
      expect(page).to have_text answer.body
      expect(page).to have_text 'Like'
      expect(page).to have_text 'Dislike'
      expect(page).to have_text 'Rating is: 0'

      click_link 'Like'
      expect(page).to have_text 'Rating is: 1'
      expect(page).to_not have_text 'Like'
      expect(page).to have_text 'Withdraw'

     click_link 'Withdraw'
     expect(page).to have_text 'Like'
     expect(page).to have_text 'Dislike'
    end
  end
  
  
  scenario 'User can not vote for his question/answer'
  scenario 'User can vote for question/answer only once'
  scenario 'User can cancel his vote and re-vote'
  scenario 'Question/answer has raiting'

end
