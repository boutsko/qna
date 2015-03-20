require 'rails_helper'

feature 'Log out a user', %q{
 to complete my interaction with QnA system
 as an authorized user
 I can log out of the system
} do

  given(:user) { create(:user) }
  
  scenario 'Loged in user tries to log out' do
    sign_in(user)
    expect(page).to have_content 'Logout'
    click_on 'Logout'
    expect(page).to have_content 'Signed out successfully.'
  end
end

