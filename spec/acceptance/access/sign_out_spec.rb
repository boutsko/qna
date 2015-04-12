require 'acceptance_helper'

feature 'Log out a user', %q{
 to complete my interaction with QnA system
 as an authorized user
 I can log out of the system
} do

  given(:user) { create(:user) }
  given(:question) { create(:question, user: user) }
  
  scenario 'Loged in user tries to log out', js: true do
    sign_in(user)
    visit question_path(question)
    expect(page).to have_content 'Logout'
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'
    
    #    visit question_path(question)
    visit questions_path
    expect(page).to have_content 'Login'
  end
end

