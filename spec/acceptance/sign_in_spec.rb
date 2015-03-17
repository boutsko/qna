require 'rails_helper'

feature 'User sign in', %q{
 In order to be able to ask question
 As a user
 I want to be able to sign in
} do

  scenario 'Registered user tries to sign in' do
    User.create!(email: 'user1@test.com', password: '12345678')

    visit new_user_session_path #'/sign_in'
    fill_in 'Email', with: 'user1@test.com'
    fill_in 'Password', with: '12345678'


    click_on 'Log in'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user tries to sign in' do
    visit new_user_session_path #'/sign_in'
    fill_in 'Email', with: 'bar@test.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    save_and_open_page

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end
end
