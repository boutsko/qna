require 'rails_helper'

feature 'Sign up a user', %q{
 to start using the QnA system
 as an authorized user
 I can sign up
} do

  given(:user) { create(:user) }
  
  scenario 'A guest tries to sign up' do
    visit questions_path
    expect(page).to have_content 'Register'
    click_on 'Register'
    expect(page).to have_content 'Sign up'
  end
end

