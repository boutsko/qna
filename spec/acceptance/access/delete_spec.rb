require 'rails_helper'

feature 'User deletes his input', %q{
 to delete a question or answer which I created
 as a loged in user
 I should log in first
} do

  given(:author) { create(:user) }
  given(:other) { create(:user) }
  given(:question1) { create(:question, user: author) }
  given(:question2) { create(:question, user: other) }

  scenario 'Authenticated user deletes his question' do

    sign_in(author)
    visit question_path(question1)
    save_and_open_page
    click_on 'Delete Question'

  end

  scenario 'guest tries to delete a question' do

    visit question_path(question1)
#    save_and_open_page
    expect(page).to_not have_text("Delete")
  end

  scenario 'Authenticated user deletes question created by another user' do

    sign_in(other)
    visit question_path(question1)
    # save_and_open_page
    expect(page).to_not have_text("Delete")
    # click_on 'Delete Question'
  end
end
