require 'rails_helper'

feature 'User deletes his input', %q{
 to delete my questions and answers
 as a logged in user
 I should log in first
} do

  given!(:author) { create(:user) }
  given!(:other) { create(:user) }
  given!(:question1) { create(:question, user: author) }

  scenario 'Authenticated user deletes his question' do

    sign_in(author)
    visit question_path(question1)
    click_on 'Delete Question'
    expect(page).to have_text('Question destroyed')
  end

  scenario 'Guest tries to delete a question' do

    visit question_path(question1)
    expect(page).to_not have_text("Delete Question")
  end

  scenario 'Authenticated user tries to delete a question created by another user' do

    sign_in(other)
    visit question_path(question1)
    expect(page).to_not have_text("Delete Question")
  end
end
