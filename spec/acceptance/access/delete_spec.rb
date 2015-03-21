require 'rails_helper'

feature 'User deletes his input', %q{
 to delete a question or answer which I created
 as a loged in user
 I should log in first
} do

  given!(:user) { create(:user) }
  given!(:author) { create(:user) }
  given!(:question1) { create(:question, user: user) }
  given!(:question2) { create(:question, user: author) }


  scenario 'Authenticated user deletes his question', focus: true do

    sign_in(user)
    visit question_path(question1)
    save_and_open_page
    click_on 'Delete Question'

  end

  scenario 'guest tries to delete a question created by input'

  scenario 'Authenticated user deletes question created by another user'
end
