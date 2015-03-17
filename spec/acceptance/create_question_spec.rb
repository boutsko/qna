require 'rails_helper'

feature 'Create question', %q{
  In order to get answer from community
  As authenticated user
  I want to be able to ask question
} do

  scenario 'Authenticated user creates question' do
    User.create!(email: 'user1@test.com', password: '12345678')

    visit new_user_session_path #'/sign_in'
    fill_in 'Email', with: 'user1@test.com'
    fill_in 'Password', with: '12345678'

    click_on 'Log in'

    # visit questions_path
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'text text'

    # save_and_open_page

    click_on 'Create'

    expect(page).to have_content 'Your question successfully created.'
  end

  scenario 'Non-authenticated user created question' do
    visit questions_path
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
