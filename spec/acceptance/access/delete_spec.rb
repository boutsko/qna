require 'rails_helper'

feature 'User deletes his input', %q{
 to delete my questions and answers
 as a logged in user
 I should log in first
} do

  given!(:author) { create(:user) }
  given!(:other) { create(:user) }
  given!(:question) { create(:question, user: author) }
  given! (:answer) { create(:answer, question: question, user: author)  }
  scenario 'Authenticated user deletes his question' do

    sign_in(author)
    visit question_path(question)
    click_on 'Delete Question'
    expect(page).to have_text('Question destroyed')
  end

  scenario 'Guest tries to delete a question' do

    visit question_path(question)
    expect(page).to_not have_text("Delete Question")
  end

  scenario 'Authenticated user tries to delete a question created by another user' do

    sign_in(other)
    visit question_path(question)
    expect(page).to_not have_text("Delete Question")
  end

  before { answer }
  
  scenario 'Other user tries to delete a question created by another user' do
    sign_in(other)
    visit question_path(question)
    expect(page).to_not have_text("Delete Answer")
  end

  scenario 'User tries to delete his question' do
    sign_in(author)
    visit question_path(question)
    expect(page).to have_text("Delete Answer")
    click_on "Delete Answer"
    expect(page).to_not have_text("AnswerBody")
  end
end
